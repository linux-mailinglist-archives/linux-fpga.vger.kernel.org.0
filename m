Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D403B28553A
	for <lists+linux-fpga@lfdr.de>; Wed,  7 Oct 2020 02:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgJGAK6 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 6 Oct 2020 20:10:58 -0400
Received: from mga04.intel.com ([192.55.52.120]:3648 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726645AbgJGAKc (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 6 Oct 2020 20:10:32 -0400
IronPort-SDR: Md00glzJBtL929ovcKSwB40cGevmdNCSXfpTZtYo+InOohzhfCRpe5vD/FrPeDCye7Gthx2LnV
 sfQRxQFdng+w==
X-IronPort-AV: E=McAfee;i="6000,8403,9766"; a="162139551"
X-IronPort-AV: E=Sophos;i="5.77,344,1596524400"; 
   d="scan'208";a="162139551"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2020 17:10:32 -0700
IronPort-SDR: cu00PO4f7EBw3tklmJSLmVCRR22pf3jrhwfiZNwAlXttbfHOT6viuQgcRZi7d8koYCpfVtmL6g
 4qefi0dWSaOg==
X-IronPort-AV: E=Sophos;i="5.77,344,1596524400"; 
   d="scan'208";a="297380419"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO rhweight-mobl2.ra.intel.com) ([10.212.2.223])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2020 17:10:29 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v3 2/7] fpga: sec-mgr: enable secure updates
Date:   Tue,  6 Oct 2020 17:09:59 -0700
Message-Id: <20201007001004.23790-3-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201007001004.23790-1-russell.h.weight@intel.com>
References: <20201007001004.23790-1-russell.h.weight@intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Extend the FPGA Intel Security Manager class driver to
include an update/filename sysfs node that can be used
to initiate a security update.  The filename of a secure
update file (BMC image, FPGA image, Root Entry Hash image,
or Code Signing Key cancellation image) can be written to
this sysfs entry to cause a secure update to occur.

The write of the filename will return immediately, and the
update will begin in the context of a kernel worker thread.
This tool utilizes the request_firmware framework, which
requires that the image file reside under /lib/firmware.

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Reviewed-by: Tom Rix <trix@redhat.com>
---
v3:
  - Removed unnecessary "goto done"
  - Added a comment to explain imgr->driver_unload in
    ifpga_sec_mgr_unregister()
v2:
  - Bumped documentation date and version
  - Removed explicit value assignments in enums
  - Other minor code cleanup per review comments 
---
 .../ABI/testing/sysfs-class-ifpga-sec-mgr     |  13 ++
 drivers/fpga/ifpga-sec-mgr.c                  | 164 ++++++++++++++++++
 include/linux/fpga/ifpga-sec-mgr.h            |  49 ++++++
 3 files changed, 226 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr b/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
index 707958971bcb..4f375f132c34 100644
--- a/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
+++ b/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
@@ -65,3 +65,16 @@ Contact:	Russ Weight <russell.h.weight@intel.com>
 Description:	Read only. Returns number of times the user image for the
 		static region has been flashed.
 		Format: "%u".
+
+What: 		/sys/class/ifpga_sec_mgr/ifpga_secX/update/filename
+Date:		Oct 2020
+KernelVersion:  5.11
+Contact:	Russ Weight <russell.h.weight@intel.com>
+Description:	Write only. Write the filename of an Intel image
+		file to this sysfs file to initiate a secure
+		update. The file must have an appropriate header
+		which, among other things, identifies the target
+		for the update. This mechanism is used to update
+		BMC images, BMC firmware, Static Region images,
+		and Root Entry Hashes, and to cancel Code Signing
+		Keys (CSK).
diff --git a/drivers/fpga/ifpga-sec-mgr.c b/drivers/fpga/ifpga-sec-mgr.c
index 26609fb9b73d..d630acad1fc3 100644
--- a/drivers/fpga/ifpga-sec-mgr.c
+++ b/drivers/fpga/ifpga-sec-mgr.c
@@ -5,8 +5,11 @@
  * Copyright (C) 2019-2020 Intel Corporation, Inc.
  */
 
+#include <linux/delay.h>
+#include <linux/firmware.h>
 #include <linux/fpga/ifpga-sec-mgr.h>
 #include <linux/idr.h>
+#include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
@@ -14,6 +17,8 @@
 static DEFINE_IDA(ifpga_sec_mgr_ida);
 static struct class *ifpga_sec_mgr_class;
 
+#define WRITE_BLOCK_SIZE 0x4000	/* Update remaining_size every 0x4000 bytes */
+
 #define to_sec_mgr(d) container_of(d, struct ifpga_sec_mgr, dev)
 
 static ssize_t
@@ -134,6 +139,94 @@ static struct attribute *sec_mgr_security_attrs[] = {
 	NULL,
 };
 
+static void ifpga_sec_dev_error(struct ifpga_sec_mgr *imgr,
+				enum ifpga_sec_err err_code)
+{
+	imgr->err_code = err_code;
+	imgr->iops->cancel(imgr);
+}
+
+static void progress_complete(struct ifpga_sec_mgr *imgr)
+{
+	mutex_lock(&imgr->lock);
+	imgr->progress = IFPGA_SEC_PROG_IDLE;
+	complete_all(&imgr->update_done);
+	mutex_unlock(&imgr->lock);
+}
+
+static void ifpga_sec_mgr_update(struct work_struct *work)
+{
+	u32 size, blk_size, offset = 0;
+	struct ifpga_sec_mgr *imgr;
+	const struct firmware *fw;
+	enum ifpga_sec_err ret;
+
+	imgr = container_of(work, struct ifpga_sec_mgr, work);
+
+	get_device(&imgr->dev);
+	if (request_firmware(&fw, imgr->filename, &imgr->dev)) {
+		imgr->err_code = IFPGA_SEC_ERR_FILE_READ;
+		goto idle_exit;
+	}
+
+	imgr->data = fw->data;
+	imgr->remaining_size = fw->size;
+
+	if (!try_module_get(imgr->dev.parent->driver->owner)) {
+		imgr->err_code = IFPGA_SEC_ERR_BUSY;
+		goto release_fw_exit;
+	}
+
+	imgr->progress = IFPGA_SEC_PROG_PREPARING;
+	ret = imgr->iops->prepare(imgr);
+	if (ret) {
+		ifpga_sec_dev_error(imgr, ret);
+		goto modput_exit;
+	}
+
+	imgr->progress = IFPGA_SEC_PROG_WRITING;
+	size = imgr->remaining_size;
+	while (size) {
+		blk_size = min_t(u32, size, WRITE_BLOCK_SIZE);
+		size -= blk_size;
+		ret = imgr->iops->write_blk(imgr, offset, blk_size);
+		if (ret) {
+			ifpga_sec_dev_error(imgr, ret);
+			goto done;
+		}
+
+		imgr->remaining_size = size;
+		offset += blk_size;
+	}
+
+	imgr->progress = IFPGA_SEC_PROG_PROGRAMMING;
+	ret = imgr->iops->poll_complete(imgr);
+	if (ret)
+		ifpga_sec_dev_error(imgr, ret);
+
+done:
+	if (imgr->iops->cleanup)
+		imgr->iops->cleanup(imgr);
+
+modput_exit:
+	module_put(imgr->dev.parent->driver->owner);
+
+release_fw_exit:
+	imgr->data = NULL;
+	release_firmware(fw);
+
+idle_exit:
+	/*
+	 * Note: imgr->remaining_size is left unmodified here to
+	 * provide additional information on errors. It will be
+	 * reinitialized when the next secure update begins.
+	 */
+	kfree(imgr->filename);
+	imgr->filename = NULL;
+	put_device(&imgr->dev);
+	progress_complete(imgr);
+}
+
 #define check_attr(attribute, _name) \
 	((attribute) == &dev_attr_##_name.attr && imgr->iops->_name)
 
@@ -164,6 +257,48 @@ static struct attribute_group sec_mgr_security_attr_group = {
 	.is_visible = sec_mgr_visible,
 };
 
+static ssize_t filename_store(struct device *dev, struct device_attribute *attr,
+			      const char *buf, size_t count)
+{
+	struct ifpga_sec_mgr *imgr = to_sec_mgr(dev);
+	int ret = count;
+
+	if (count == 0 || count >= PATH_MAX)
+		return -EINVAL;
+
+	mutex_lock(&imgr->lock);
+	if (imgr->driver_unload || imgr->progress != IFPGA_SEC_PROG_IDLE) {
+		ret = -EBUSY;
+		goto unlock_exit;
+	}
+
+	imgr->filename = kstrndup(buf, count - 1, GFP_KERNEL);
+	if (!imgr->filename) {
+		ret = -ENOMEM;
+		goto unlock_exit;
+	}
+
+	imgr->err_code = IFPGA_SEC_ERR_NONE;
+	imgr->progress = IFPGA_SEC_PROG_READING;
+	reinit_completion(&imgr->update_done);
+	schedule_work(&imgr->work);
+
+unlock_exit:
+	mutex_unlock(&imgr->lock);
+	return ret;
+}
+static DEVICE_ATTR_WO(filename);
+
+static struct attribute *sec_mgr_update_attrs[] = {
+	&dev_attr_filename.attr,
+	NULL,
+};
+
+static struct attribute_group sec_mgr_update_attr_group = {
+	.name = "update",
+	.attrs = sec_mgr_update_attrs,
+};
+
 static ssize_t name_show(struct device *dev,
 			 struct device_attribute *attr, char *buf)
 {
@@ -185,6 +320,7 @@ static struct attribute_group sec_mgr_attr_group = {
 static const struct attribute_group *ifpga_sec_mgr_attr_groups[] = {
 	&sec_mgr_attr_group,
 	&sec_mgr_security_attr_group,
+	&sec_mgr_update_attr_group,
 	NULL,
 };
 
@@ -243,6 +379,12 @@ ifpga_sec_mgr_create(struct device *dev, const char *name,
 	struct ifpga_sec_mgr *imgr;
 	int id, ret;
 
+	if (!iops || !iops->cancel || !iops->prepare ||
+	    !iops->write_blk || !iops->poll_complete) {
+		dev_err(dev, "Attempt to register without required ops\n");
+		return NULL;
+	}
+
 	if (!check_reh_handler(dev, iops, bmc) ||
 	    !check_reh_handler(dev, iops, sr) ||
 	    !check_reh_handler(dev, iops, pr) ||
@@ -270,6 +412,8 @@ ifpga_sec_mgr_create(struct device *dev, const char *name,
 	imgr->name = name;
 	imgr->priv = priv;
 	imgr->iops = iops;
+	init_completion(&imgr->update_done);
+	INIT_WORK(&imgr->work, ifpga_sec_mgr_update);
 
 	device_initialize(&imgr->dev);
 	imgr->dev.class = ifpga_sec_mgr_class;
@@ -390,11 +534,31 @@ EXPORT_SYMBOL_GPL(ifpga_sec_mgr_register);
  *
  * This function is intended for use in an Intel FPGA security manager
  * driver's remove() function.
+ *
+ * For some devices, once the secure update has begun authentication
+ * the hardware cannot be signaled to stop, and the driver will not
+ * exit until the hardware signals completion.  This could be 30+
+ * minutes of waiting. The driver_unload flag enableds a force-unload
+ * of the driver (e.g. modprobe -r) by signaling the parent driver to
+ * exit even if the hardware update is incomplete. The driver_unload
+ * flag also prevents new updates from starting once the unregister
+ * process has begun.
  */
 void ifpga_sec_mgr_unregister(struct ifpga_sec_mgr *imgr)
 {
 	dev_info(&imgr->dev, "%s %s\n", __func__, imgr->name);
 
+	mutex_lock(&imgr->lock);
+	imgr->driver_unload = true;
+	if (imgr->progress == IFPGA_SEC_PROG_IDLE) {
+		mutex_unlock(&imgr->lock);
+		goto unregister;
+	}
+
+	mutex_unlock(&imgr->lock);
+	wait_for_completion(&imgr->update_done);
+
+unregister:
 	device_unregister(&imgr->dev);
 }
 EXPORT_SYMBOL_GPL(ifpga_sec_mgr_unregister);
diff --git a/include/linux/fpga/ifpga-sec-mgr.h b/include/linux/fpga/ifpga-sec-mgr.h
index ded62090e9b9..27008abd8e75 100644
--- a/include/linux/fpga/ifpga-sec-mgr.h
+++ b/include/linux/fpga/ifpga-sec-mgr.h
@@ -7,12 +7,26 @@
 #ifndef _LINUX_IFPGA_SEC_MGR_H
 #define _LINUX_IFPGA_SEC_MGR_H
 
+#include <linux/completion.h>
 #include <linux/device.h>
 #include <linux/mutex.h>
 #include <linux/types.h>
 
 struct ifpga_sec_mgr;
 
+enum ifpga_sec_err {
+	IFPGA_SEC_ERR_NONE,
+	IFPGA_SEC_ERR_HW_ERROR,
+	IFPGA_SEC_ERR_TIMEOUT,
+	IFPGA_SEC_ERR_CANCELED,
+	IFPGA_SEC_ERR_BUSY,
+	IFPGA_SEC_ERR_INVALID_SIZE,
+	IFPGA_SEC_ERR_RW_ERROR,
+	IFPGA_SEC_ERR_WEAROUT,
+	IFPGA_SEC_ERR_FILE_READ,
+	IFPGA_SEC_ERR_MAX
+};
+
 /**
  * struct ifpga_sec_mgr_ops - device specific operations
  * @user_flash_count:	    Optional: Return sysfs string output for FPGA
@@ -35,6 +49,17 @@ struct ifpga_sec_mgr;
  * @bmc_reh_size:	    Optional: Return byte size for BMC root entry hash
  * @sr_reh_size:	    Optional: Return byte size for SR root entry hash
  * @pr_reh_size:	    Optional: Return byte size for PR root entry hash
+ * @prepare:		    Required: Prepare secure update
+ * @write_blk:		    Required: Write a block of data
+ * @poll_complete:	    Required: Check for the completion of the
+ *			    HW authentication/programming process. This
+ *			    function should check for imgr->driver_unload
+ *			    and abort with IFPGA_SEC_ERR_CANCELED when true.
+ * @cancel:		    Required: Signal HW to cancel update
+ * @cleanup:		    Optional: Complements the prepare()
+ *			    function and is called at the completion
+ *			    of the update, whether success or failure,
+ *			    if the prepare function succeeded.
  */
 struct ifpga_sec_mgr_ops {
 	int (*user_flash_count)(struct ifpga_sec_mgr *imgr);
@@ -56,6 +81,22 @@ struct ifpga_sec_mgr_ops {
 	int (*bmc_canceled_csk_nbits)(struct ifpga_sec_mgr *imgr);
 	int (*sr_canceled_csk_nbits)(struct ifpga_sec_mgr *imgr);
 	int (*pr_canceled_csk_nbits)(struct ifpga_sec_mgr *imgr);
+	enum ifpga_sec_err (*prepare)(struct ifpga_sec_mgr *imgr);
+	enum ifpga_sec_err (*write_blk)(struct ifpga_sec_mgr *imgr,
+					u32 offset, u32 size);
+	enum ifpga_sec_err (*poll_complete)(struct ifpga_sec_mgr *imgr);
+	void (*cleanup)(struct ifpga_sec_mgr *imgr);
+	enum ifpga_sec_err (*cancel)(struct ifpga_sec_mgr *imgr);
+};
+
+/* Update progress codes */
+enum ifpga_sec_prog {
+	IFPGA_SEC_PROG_IDLE,
+	IFPGA_SEC_PROG_READING,
+	IFPGA_SEC_PROG_PREPARING,
+	IFPGA_SEC_PROG_WRITING,
+	IFPGA_SEC_PROG_PROGRAMMING,
+	IFPGA_SEC_PROG_MAX
 };
 
 struct ifpga_sec_mgr {
@@ -63,6 +104,14 @@ struct ifpga_sec_mgr {
 	struct device dev;
 	const struct ifpga_sec_mgr_ops *iops;
 	struct mutex lock;		/* protect data structure contents */
+	struct work_struct work;
+	struct completion update_done;
+	char *filename;
+	const u8 *data;			/* pointer to update data */
+	u32 remaining_size;		/* size remaining to transfer */
+	enum ifpga_sec_prog progress;
+	enum ifpga_sec_err err_code;	/* security manager error code */
+	bool driver_unload;
 	void *priv;
 };
 
-- 
2.17.1


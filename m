Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0CC72945D9
	for <lists+linux-fpga@lfdr.de>; Wed, 21 Oct 2020 02:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439581AbgJUARC (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 20 Oct 2020 20:17:02 -0400
Received: from mga09.intel.com ([134.134.136.24]:23485 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439562AbgJUARB (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 20 Oct 2020 20:17:01 -0400
IronPort-SDR: Wpui0PTe6DFmOOKVvhUCD8/Dg9ycAtFOmmYmx/EBD6rtA0Iw5M/juo6JKssnQcdxgP4atiPXEF
 Mg7KeI7V4Tmg==
X-IronPort-AV: E=McAfee;i="6000,8403,9780"; a="167414195"
X-IronPort-AV: E=Sophos;i="5.77,399,1596524400"; 
   d="scan'208";a="167414195"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2020 17:17:00 -0700
IronPort-SDR: DHKNdQkUrLLJv9fDMpTEv6hl/zDMQXzywqoxMCYtbJ8QLgiiE1Di/+x3EX774u1equtNV+PDoQ
 tew6L47oFjPQ==
X-IronPort-AV: E=Sophos;i="5.77,399,1596524400"; 
   d="scan'208";a="348409812"
Received: from rhweight-mobl2.amr.corp.intel.com ([10.209.103.57])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2020 17:16:59 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v5 2/7] fpga: sec-mgr: enable secure updates
Date:   Tue, 20 Oct 2020 17:16:45 -0700
Message-Id: <20201021001650.13978-3-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201021001650.13978-1-russell.h.weight@intel.com>
References: <20201021001650.13978-1-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Extend the FPGA Security Manager class driver to
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
v5:
  - When checking the return values for functions of type enum
    fpga_sec_err err_code, test for FPGA_SEC_ERR_NONE instead of 0
v4:
  - Changed from "Intel FPGA Security Manager" to FPGA Security Manager"
    and removed unnecessary references to "Intel".
  - Changed: iops -> sops, imgr -> smgr, IFPGA_ -> FPGA_, ifpga_ to fpga_
v3:
  - Removed unnecessary "goto done"
  - Added a comment to explain imgr->driver_unload in
    ifpga_sec_mgr_unregister()
v2:
  - Bumped documentation date and version
  - Removed explicit value assignments in enums
  - Other minor code cleanup per review comments 
---
 .../ABI/testing/sysfs-class-fpga-sec-mgr      |  13 ++
 drivers/fpga/fpga-sec-mgr.c                   | 164 ++++++++++++++++++
 include/linux/fpga/fpga-sec-mgr.h             |  49 ++++++
 3 files changed, 226 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-fpga-sec-mgr b/Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
index 843f0b58f171..5f10496b2a54 100644
--- a/Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
+++ b/Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
@@ -65,3 +65,16 @@ Contact:	Russ Weight <russell.h.weight@intel.com>
 Description:	Read only. Returns number of times the user image for the
 		static region has been flashed.
 		Format: "%u".
+
+What: 		/sys/class/fpga_sec_mgr/fpga_secX/update/filename
+Date:		Oct 2020
+KernelVersion:  5.11
+Contact:	Russ Weight <russell.h.weight@intel.com>
+Description:	Write only. Write the filename of an image
+		file to this sysfs file to initiate a secure
+		update. The file must have an appropriate header
+		which, among other things, identifies the target
+		for the update. This mechanism is used to update
+		BMC images, BMC firmware, Static Region images,
+		and Root Entry Hashes, and to cancel Code Signing
+		Keys (CSK).
diff --git a/drivers/fpga/fpga-sec-mgr.c b/drivers/fpga/fpga-sec-mgr.c
index 95b5a7ccbe44..8248b86ad098 100644
--- a/drivers/fpga/fpga-sec-mgr.c
+++ b/drivers/fpga/fpga-sec-mgr.c
@@ -5,8 +5,11 @@
  * Copyright (C) 2019-2020 Intel Corporation, Inc.
  */
 
+#include <linux/delay.h>
+#include <linux/firmware.h>
 #include <linux/fpga/fpga-sec-mgr.h>
 #include <linux/idr.h>
+#include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
@@ -18,6 +21,8 @@ struct fpga_sec_mgr_devres {
 	struct fpga_sec_mgr *smgr;
 };
 
+#define WRITE_BLOCK_SIZE 0x4000	/* Update remaining_size every 0x4000 bytes */
+
 #define to_sec_mgr(d) container_of(d, struct fpga_sec_mgr, dev)
 
 static ssize_t
@@ -138,6 +143,94 @@ static struct attribute *sec_mgr_security_attrs[] = {
 	NULL,
 };
 
+static void fpga_sec_dev_error(struct fpga_sec_mgr *smgr,
+			       enum fpga_sec_err err_code)
+{
+	smgr->err_code = err_code;
+	smgr->sops->cancel(smgr);
+}
+
+static void progress_complete(struct fpga_sec_mgr *smgr)
+{
+	mutex_lock(&smgr->lock);
+	smgr->progress = FPGA_SEC_PROG_IDLE;
+	complete_all(&smgr->update_done);
+	mutex_unlock(&smgr->lock);
+}
+
+static void fpga_sec_mgr_update(struct work_struct *work)
+{
+	u32 size, blk_size, offset = 0;
+	struct fpga_sec_mgr *smgr;
+	const struct firmware *fw;
+	enum fpga_sec_err ret;
+
+	smgr = container_of(work, struct fpga_sec_mgr, work);
+
+	get_device(&smgr->dev);
+	if (request_firmware(&fw, smgr->filename, &smgr->dev)) {
+		smgr->err_code = FPGA_SEC_ERR_FILE_READ;
+		goto idle_exit;
+	}
+
+	smgr->data = fw->data;
+	smgr->remaining_size = fw->size;
+
+	if (!try_module_get(smgr->dev.parent->driver->owner)) {
+		smgr->err_code = FPGA_SEC_ERR_BUSY;
+		goto release_fw_exit;
+	}
+
+	smgr->progress = FPGA_SEC_PROG_PREPARING;
+	ret = smgr->sops->prepare(smgr);
+	if (ret != FPGA_SEC_ERR_NONE) {
+		fpga_sec_dev_error(smgr, ret);
+		goto modput_exit;
+	}
+
+	smgr->progress = FPGA_SEC_PROG_WRITING;
+	size = smgr->remaining_size;
+	while (size) {
+		blk_size = min_t(u32, size, WRITE_BLOCK_SIZE);
+		size -= blk_size;
+		ret = smgr->sops->write_blk(smgr, offset, blk_size);
+		if (ret != FPGA_SEC_ERR_NONE) {
+			fpga_sec_dev_error(smgr, ret);
+			goto done;
+		}
+
+		smgr->remaining_size = size;
+		offset += blk_size;
+	}
+
+	smgr->progress = FPGA_SEC_PROG_PROGRAMMING;
+	ret = smgr->sops->poll_complete(smgr);
+	if (ret != FPGA_SEC_ERR_NONE)
+		fpga_sec_dev_error(smgr, ret);
+
+done:
+	if (smgr->sops->cleanup)
+		smgr->sops->cleanup(smgr);
+
+modput_exit:
+	module_put(smgr->dev.parent->driver->owner);
+
+release_fw_exit:
+	smgr->data = NULL;
+	release_firmware(fw);
+
+idle_exit:
+	/*
+	 * Note: smgr->remaining_size is left unmodified here to
+	 * provide additional information on errors. It will be
+	 * reinitialized when the next secure update begins.
+	 */
+	kfree(smgr->filename);
+	smgr->filename = NULL;
+	put_device(&smgr->dev);
+	progress_complete(smgr);
+}
+
 #define check_attr(attribute, _name) \
 	((attribute) == &dev_attr_##_name.attr && smgr->sops->_name)
 
@@ -168,6 +261,48 @@ static struct attribute_group sec_mgr_security_attr_group = {
 	.is_visible = sec_mgr_visible,
 };
 
+static ssize_t filename_store(struct device *dev, struct device_attribute *attr,
+			      const char *buf, size_t count)
+{
+	struct fpga_sec_mgr *smgr = to_sec_mgr(dev);
+	int ret = count;
+
+	if (count == 0 || count >= PATH_MAX)
+		return -EINVAL;
+
+	mutex_lock(&smgr->lock);
+	if (smgr->driver_unload || smgr->progress != FPGA_SEC_PROG_IDLE) {
+		ret = -EBUSY;
+		goto unlock_exit;
+	}
+
+	smgr->filename = kstrndup(buf, count - 1, GFP_KERNEL);
+	if (!smgr->filename) {
+		ret = -ENOMEM;
+		goto unlock_exit;
+	}
+
+	smgr->err_code = FPGA_SEC_ERR_NONE;
+	smgr->progress = FPGA_SEC_PROG_READING;
+	reinit_completion(&smgr->update_done);
+	schedule_work(&smgr->work);
+
+unlock_exit:
+	mutex_unlock(&smgr->lock);
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
@@ -189,6 +324,7 @@ static struct attribute_group sec_mgr_attr_group = {
 static const struct attribute_group *fpga_sec_mgr_attr_groups[] = {
 	&sec_mgr_attr_group,
 	&sec_mgr_security_attr_group,
+	&sec_mgr_update_attr_group,
 	NULL,
 };
 
@@ -247,6 +383,12 @@ fpga_sec_mgr_create(struct device *dev, const char *name,
 	struct fpga_sec_mgr *smgr;
 	int id, ret;
 
+	if (!sops || !sops->cancel || !sops->prepare ||
+	    !sops->write_blk || !sops->poll_complete) {
+		dev_err(dev, "Attempt to register without required ops\n");
+		return NULL;
+	}
+
 	if (!check_reh_handler(dev, sops, bmc) ||
 	    !check_reh_handler(dev, sops, sr) ||
 	    !check_reh_handler(dev, sops, pr) ||
@@ -274,6 +416,8 @@ fpga_sec_mgr_create(struct device *dev, const char *name,
 	smgr->name = name;
 	smgr->priv = priv;
 	smgr->sops = sops;
+	init_completion(&smgr->update_done);
+	INIT_WORK(&smgr->work, fpga_sec_mgr_update);
 
 	device_initialize(&smgr->dev);
 	smgr->dev.class = fpga_sec_mgr_class;
@@ -391,11 +535,31 @@ EXPORT_SYMBOL_GPL(fpga_sec_mgr_register);
  *
  * This function is intended for use in an FPGA security manager
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
 void fpga_sec_mgr_unregister(struct fpga_sec_mgr *smgr)
 {
 	dev_info(&smgr->dev, "%s %s\n", __func__, smgr->name);
 
+	mutex_lock(&smgr->lock);
+	smgr->driver_unload = true;
+	if (smgr->progress == FPGA_SEC_PROG_IDLE) {
+		mutex_unlock(&smgr->lock);
+		goto unregister;
+	}
+
+	mutex_unlock(&smgr->lock);
+	wait_for_completion(&smgr->update_done);
+
+unregister:
 	device_unregister(&smgr->dev);
 }
 EXPORT_SYMBOL_GPL(fpga_sec_mgr_unregister);
diff --git a/include/linux/fpga/fpga-sec-mgr.h b/include/linux/fpga/fpga-sec-mgr.h
index dd596c6c3748..d2e482456d16 100644
--- a/include/linux/fpga/fpga-sec-mgr.h
+++ b/include/linux/fpga/fpga-sec-mgr.h
@@ -7,12 +7,26 @@
 #ifndef _LINUX_FPGA_SEC_MGR_H
 #define _LINUX_FPGA_SEC_MGR_H
 
+#include <linux/completion.h>
 #include <linux/device.h>
 #include <linux/mutex.h>
 #include <linux/types.h>
 
 struct fpga_sec_mgr;
 
+enum fpga_sec_err {
+	FPGA_SEC_ERR_NONE,
+	FPGA_SEC_ERR_HW_ERROR,
+	FPGA_SEC_ERR_TIMEOUT,
+	FPGA_SEC_ERR_CANCELED,
+	FPGA_SEC_ERR_BUSY,
+	FPGA_SEC_ERR_INVALID_SIZE,
+	FPGA_SEC_ERR_RW_ERROR,
+	FPGA_SEC_ERR_WEAROUT,
+	FPGA_SEC_ERR_FILE_READ,
+	FPGA_SEC_ERR_MAX
+};
+
 /**
  * struct fpga_sec_mgr_ops - device specific operations
  * @user_flash_count:	    Optional: Return sysfs string output for FPGA
@@ -35,6 +49,17 @@ struct fpga_sec_mgr;
  * @bmc_reh_size:	    Optional: Return byte size for BMC root entry hash
  * @sr_reh_size:	    Optional: Return byte size for SR root entry hash
  * @pr_reh_size:	    Optional: Return byte size for PR root entry hash
+ * @prepare:		    Required: Prepare secure update
+ * @write_blk:		    Required: Write a block of data
+ * @poll_complete:	    Required: Check for the completion of the
+ *			    HW authentication/programming process. This
+ *			    function should check for smgr->driver_unload
+ *			    and abort with FPGA_SEC_ERR_CANCELED when true.
+ * @cancel:		    Required: Signal HW to cancel update
+ * @cleanup:		    Optional: Complements the prepare()
+ *			    function and is called at the completion
+ *			    of the update, whether success or failure,
+ *			    if the prepare function succeeded.
  */
 struct fpga_sec_mgr_ops {
 	int (*user_flash_count)(struct fpga_sec_mgr *smgr);
@@ -56,6 +81,22 @@ struct fpga_sec_mgr_ops {
 	int (*bmc_canceled_csk_nbits)(struct fpga_sec_mgr *smgr);
 	int (*sr_canceled_csk_nbits)(struct fpga_sec_mgr *smgr);
 	int (*pr_canceled_csk_nbits)(struct fpga_sec_mgr *smgr);
+	enum fpga_sec_err (*prepare)(struct fpga_sec_mgr *smgr);
+	enum fpga_sec_err (*write_blk)(struct fpga_sec_mgr *smgr,
+				       u32 offset, u32 size);
+	enum fpga_sec_err (*poll_complete)(struct fpga_sec_mgr *smgr);
+	void (*cleanup)(struct fpga_sec_mgr *smgr);
+	enum fpga_sec_err (*cancel)(struct fpga_sec_mgr *smgr);
+};
+
+/* Update progress codes */
+enum fpga_sec_prog {
+	FPGA_SEC_PROG_IDLE,
+	FPGA_SEC_PROG_READING,
+	FPGA_SEC_PROG_PREPARING,
+	FPGA_SEC_PROG_WRITING,
+	FPGA_SEC_PROG_PROGRAMMING,
+	FPGA_SEC_PROG_MAX
 };
 
 struct fpga_sec_mgr {
@@ -63,6 +104,14 @@ struct fpga_sec_mgr {
 	struct device dev;
 	const struct fpga_sec_mgr_ops *sops;
 	struct mutex lock;		/* protect data structure contents */
+	struct work_struct work;
+	struct completion update_done;
+	char *filename;
+	const u8 *data;			/* pointer to update data */
+	u32 remaining_size;		/* size remaining to transfer */
+	enum fpga_sec_prog progress;
+	enum fpga_sec_err err_code;	/* security manager error code */
+	bool driver_unload;
 	void *priv;
 };
 
-- 
2.25.1


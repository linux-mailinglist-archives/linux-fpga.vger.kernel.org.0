Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64CE12CE059
	for <lists+linux-fpga@lfdr.de>; Thu,  3 Dec 2020 22:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbgLCVLO (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 3 Dec 2020 16:11:14 -0500
Received: from mga11.intel.com ([192.55.52.93]:57209 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725885AbgLCVLO (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 3 Dec 2020 16:11:14 -0500
IronPort-SDR: 999GXMo435FkmdrLPQ54Co3tGJm/bSXHPEq6rDeMe1Jo7CtQFBEBw082cUljFxWPRVEElc1LK6
 RjTPUsmpdjlw==
X-IronPort-AV: E=McAfee;i="6000,8403,9824"; a="169773012"
X-IronPort-AV: E=Sophos;i="5.78,390,1599548400"; 
   d="scan'208";a="169773012"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2020 13:10:02 -0800
IronPort-SDR: bKOE9znbHiuLBVUhJzXgUbjpSftih6fTjPbm5A5qRxopWKEQ5EJWh6GWPAfD+ZPT1HwYxoOmSZ
 ycqT/r5sbkuQ==
X-IronPort-AV: E=Sophos;i="5.78,390,1599548400"; 
   d="scan'208";a="330971708"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO rhweight-mobl2.ra.intel.com) ([10.251.23.110])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2020 13:10:01 -0800
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v7 2/7] fpga: sec-mgr: enable secure updates
Date:   Thu,  3 Dec 2020 13:09:53 -0800
Message-Id: <20201203210958.241329-3-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201203210958.241329-1-russell.h.weight@intel.com>
References: <20201203210958.241329-1-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Extend the FPGA Security Manager class driver to
include an update/filename sysfs node that can be used
to initiate a secure update.  The filename of a secure
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
v7:
  - Changed Date in documentation file to December 2020
  - Changed filename_store() to use kmemdup_nul() instead of
    kstrndup() and changed the count to not assume a line-return.
v6:
  - Changed "security update" to "secure update" in commit message
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
index f4211981441e..e9334f986380 100644
--- a/Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
+++ b/Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
@@ -3,3 +3,16 @@ Date:		December 2020
 KernelVersion:  5.11
 Contact:	Russ Weight <russell.h.weight@intel.com>
 Description:	Name of low level fpga security manager driver.
+
+What: 		/sys/class/fpga_sec_mgr/fpga_secX/update/filename
+Date:		December 2020
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
index 468379e0c825..7347ba1ba73e 100644
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
@@ -18,8 +21,140 @@ struct fpga_sec_mgr_devres {
 	struct fpga_sec_mgr *smgr;
 };
 
+#define WRITE_BLOCK_SIZE 0x4000	/* Update remaining_size every 0x4000 bytes */
+
 #define to_sec_mgr(d) container_of(d, struct fpga_sec_mgr, dev)
 
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
+	smgr->filename = kmemdup_nul(buf, count, GFP_KERNEL);
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
@@ -40,6 +175,7 @@ static struct attribute_group sec_mgr_attr_group = {
 
 static const struct attribute_group *fpga_sec_mgr_attr_groups[] = {
 	&sec_mgr_attr_group,
+	&sec_mgr_update_attr_group,
 	NULL,
 };
 
@@ -65,6 +201,12 @@ fpga_sec_mgr_create(struct device *dev, const char *name,
 	struct fpga_sec_mgr *smgr;
 	int id, ret;
 
+	if (!sops || !sops->cancel || !sops->prepare ||
+	    !sops->write_blk || !sops->poll_complete) {
+		dev_err(dev, "Attempt to register without required ops\n");
+		return NULL;
+	}
+
 	if (!name || !strlen(name)) {
 		dev_err(dev, "Attempt to register with no name!\n");
 		return NULL;
@@ -83,6 +225,8 @@ fpga_sec_mgr_create(struct device *dev, const char *name,
 	smgr->name = name;
 	smgr->priv = priv;
 	smgr->sops = sops;
+	init_completion(&smgr->update_done);
+	INIT_WORK(&smgr->work, fpga_sec_mgr_update);
 
 	device_initialize(&smgr->dev);
 	smgr->dev.class = fpga_sec_mgr_class;
@@ -200,11 +344,31 @@ EXPORT_SYMBOL_GPL(fpga_sec_mgr_register);
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
index f85665b79b9d..e03de72134d6 100644
--- a/include/linux/fpga/fpga-sec-mgr.h
+++ b/include/linux/fpga/fpga-sec-mgr.h
@@ -7,16 +7,57 @@
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
+	enum fpga_sec_err (*prepare)(struct fpga_sec_mgr *smgr);
+	enum fpga_sec_err (*write_blk)(struct fpga_sec_mgr *smgr,
+				       u32 offset, u32 size);
+	enum fpga_sec_err (*poll_complete)(struct fpga_sec_mgr *smgr);
+	enum fpga_sec_err (*cancel)(struct fpga_sec_mgr *smgr);
+	void (*cleanup)(struct fpga_sec_mgr *smgr);
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
@@ -24,6 +65,14 @@ struct fpga_sec_mgr {
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


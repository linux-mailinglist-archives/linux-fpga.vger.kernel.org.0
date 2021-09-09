Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC1340437A
	for <lists+linux-fpga@lfdr.de>; Thu,  9 Sep 2021 04:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234374AbhIICUS (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 8 Sep 2021 22:20:18 -0400
Received: from mga04.intel.com ([192.55.52.120]:63720 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234720AbhIICUQ (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 8 Sep 2021 22:20:16 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10101"; a="218793848"
X-IronPort-AV: E=Sophos;i="5.85,279,1624345200"; 
   d="scan'208";a="218793848"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2021 19:18:54 -0700
X-IronPort-AV: E=Sophos;i="5.85,279,1624345200"; 
   d="scan'208";a="503916527"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO rhweight-mobl2.ra.intel.com) ([10.212.194.237])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2021 19:18:54 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v15 2/6] fpga: image-load: enable image loads
Date:   Wed,  8 Sep 2021 19:18:42 -0700
Message-Id: <20210909021846.681121-3-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210909021846.681121-1-russell.h.weight@intel.com>
References: <20210909021846.681121-1-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Extend the FPGA Image Load class driver to include IOCTL support
(FPGA_IMAGE_LOAD_WRITE) for initiating an upload of an image to a device.
The IOCTL will return immediately, and the update will begin in the
context of a kernel worker thread.

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
---
v15:
 - Compare to previous patch:
     [PATCH v14 2/6] fpga: sec-mgr: enable secure updates
 - Changed file, symbol, and config names to reflect the new driver name
 - Removed update/filename sysfs file and added the FPGA_IMAGE_LOAD_WRITE
   IOCTL for writing the image data to the FPGA card. The driver no longer
   uses the request_firmware framework.
 - Fixed some error return values in fpga_image_load_register()
 - Removed signed-off/reviewed-by tags
v14:
 - Added MAINTAINERS reference for
   Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
 - Updated ABI documentation date and kernel version
 - Updated copyright to 2021
v13:
  - Change "if (count == 0 || " to "if (!count || "
  - Improve error message: "Attempt to register without all required ops\n"
v12:
  - Updated Date and KernelVersion fields in ABI documentation
  - Removed size parameter from write_blk() op - it is now up to
    the lower-level driver to determine the appropriate size and
    to update smgr->remaining_size accordingly.
v11:
  - Fixed a spelling error in a comment
  - Initialize smgr->err_code and smgr->progress explicitly in
    fpga_sec_mgr_create() instead of accepting the default 0 value.
v10:
  - Rebased to 5.12-rc2 next
  - Updated Date and KernelVersion in ABI documentation
v9:
  - Updated Date and KernelVersion in ABI documentation
v8:
  - No change
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
 Documentation/fpga/fpga-image-load.rst |  21 +++
 MAINTAINERS                            |   1 +
 drivers/fpga/fpga-image-load.c         | 224 ++++++++++++++++++++++++-
 include/linux/fpga/fpga-image-load.h   |  29 ++++
 include/uapi/linux/fpga-image-load.h   |  58 +++++++
 5 files changed, 329 insertions(+), 4 deletions(-)
 create mode 100644 include/uapi/linux/fpga-image-load.h

diff --git a/Documentation/fpga/fpga-image-load.rst b/Documentation/fpga/fpga-image-load.rst
index a6e53ac66026..2ca8d2f0212d 100644
--- a/Documentation/fpga/fpga-image-load.rst
+++ b/Documentation/fpga/fpga-image-load.rst
@@ -8,3 +8,24 @@ The FPGA Image Load class driver provides a common API for user-space
 tools to manage image uploads to FPGA devices. Device drivers that
 instantiate the FPGA Image Load class driver will interact with the
 target device to transfer and authenticate the image data.
+
+User API
+========
+
+open
+----
+
+An FPGA Image Load device is opened exclusively to control an image load.
+Image loads are processed by a kernel worker thread. A user may choose
+close the device while the upload continues.
+
+ioctl
+-----
+
+FPGA_IMAGE_LOAD_WRITE:
+
+Start an image load with the provided image buffer. This IOCTL returns
+immediately after starting a kernel worker thread to process the image load
+which could take as long a 40 minutes depending on the actual device being
+updated. This is an exclusive operation; an attempt to start concurrent image
+load for the same device will fail with EBUSY.
diff --git a/MAINTAINERS b/MAINTAINERS
index 4e7f48fa7e5c..637bc003ca81 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7365,6 +7365,7 @@ S:	Maintained
 F:	Documentation/fpga/fpga-image-load.rst
 F:	drivers/fpga/fpga-image-load.c
 F:	include/linux/fpga/fpga-image-load.h
+F:	include/uapi/linux/fpga-image-load.h
 
 FPU EMULATOR
 M:	Bill Metzenthen <billm@melbpc.org.au>
diff --git a/drivers/fpga/fpga-image-load.c b/drivers/fpga/fpga-image-load.c
index 7d75bbcff541..f5ccfa9dd977 100644
--- a/drivers/fpga/fpga-image-load.c
+++ b/drivers/fpga/fpga-image-load.c
@@ -5,18 +5,181 @@
  * Copyright (C) 2019-2021 Intel Corporation, Inc.
  */
 
+#include <linux/delay.h>
 #include <linux/fpga/fpga-image-load.h>
+#include <linux/fs.h>
+#include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/slab.h>
+#include <linux/uaccess.h>
 #include <linux/vmalloc.h>
 
 #define IMAGE_LOAD_XA_LIMIT	XA_LIMIT(0, INT_MAX)
 static DEFINE_XARRAY_ALLOC(fpga_image_load_xa);
 
 static struct class *fpga_image_load_class;
+static dev_t fpga_image_devt;
 
 #define to_image_load(d) container_of(d, struct fpga_image_load, dev)
 
+static void fpga_image_dev_error(struct fpga_image_load *imgld,
+				 enum fpga_image_err err_code)
+{
+	imgld->err_code = err_code;
+	imgld->lops->cancel(imgld);
+}
+
+static void fpga_image_prog_complete(struct fpga_image_load *imgld)
+{
+	mutex_lock(&imgld->lock);
+	imgld->progress = FPGA_IMAGE_PROG_IDLE;
+	complete_all(&imgld->update_done);
+	mutex_unlock(&imgld->lock);
+}
+
+static void fpga_image_do_load(struct work_struct *work)
+{
+	struct fpga_image_load *imgld;
+	enum fpga_image_err ret;
+	u32 size, offset = 0;
+
+	imgld = container_of(work, struct fpga_image_load, work);
+	size = imgld->remaining_size;
+
+	get_device(&imgld->dev);
+	if (!try_module_get(imgld->dev.parent->driver->owner)) {
+		imgld->err_code = FPGA_IMAGE_ERR_BUSY;
+		goto idle_exit;
+	}
+
+	imgld->progress = FPGA_IMAGE_PROG_PREPARING;
+	ret = imgld->lops->prepare(imgld);
+	if (ret != FPGA_IMAGE_ERR_NONE) {
+		fpga_image_dev_error(imgld, ret);
+		goto modput_exit;
+	}
+
+	imgld->progress = FPGA_IMAGE_PROG_WRITING;
+	while (imgld->remaining_size) {
+		ret = imgld->lops->write_blk(imgld, offset);
+		if (ret != FPGA_IMAGE_ERR_NONE) {
+			fpga_image_dev_error(imgld, ret);
+			goto done;
+		}
+
+		offset = size - imgld->remaining_size;
+	}
+
+	imgld->progress = FPGA_IMAGE_PROG_PROGRAMMING;
+	ret = imgld->lops->poll_complete(imgld);
+	if (ret != FPGA_IMAGE_ERR_NONE)
+		fpga_image_dev_error(imgld, ret);
+
+done:
+	if (imgld->lops->cleanup)
+		imgld->lops->cleanup(imgld);
+
+modput_exit:
+	module_put(imgld->dev.parent->driver->owner);
+
+idle_exit:
+	/*
+	 * Note: imgld->remaining_size is left unmodified here to provide
+	 * additional information on errors. It will be reinitialized when
+	 * the next image load begins.
+	 */
+	vfree(imgld->data);
+	imgld->data = NULL;
+	put_device(&imgld->dev);
+	fpga_image_prog_complete(imgld);
+}
+
+static int fpga_image_load_ioctl_write(struct fpga_image_load *imgld,
+				       unsigned long arg)
+{
+	struct fpga_image_write wb;
+	unsigned long minsz;
+	u8 *buf;
+
+	if (imgld->driver_unload || imgld->progress != FPGA_IMAGE_PROG_IDLE)
+		return -EBUSY;
+
+	minsz = offsetofend(struct fpga_image_write, buf);
+	if (copy_from_user(&wb, (void __user *)arg, minsz))
+		return -EFAULT;
+
+	if (wb.flags)
+		return -EINVAL;
+
+	/* Enforce 32-bit alignment on the write data */
+	if (wb.size & 0x3)
+		return -EINVAL;
+
+	buf = vzalloc(wb.size);
+	if (!buf)
+		return -ENOMEM;
+
+	if (copy_from_user(buf, u64_to_user_ptr(wb.buf), wb.size)) {
+		vfree(buf);
+		return -EFAULT;
+	}
+
+	imgld->data = buf;
+	imgld->remaining_size = wb.size;
+	imgld->err_code = FPGA_IMAGE_ERR_NONE;
+	imgld->progress = FPGA_IMAGE_PROG_STARTING;
+	reinit_completion(&imgld->update_done);
+	schedule_work(&imgld->work);
+
+	return 0;
+}
+
+static long fpga_image_load_ioctl(struct file *filp, unsigned int cmd,
+				  unsigned long arg)
+{
+	struct fpga_image_load *imgld = filp->private_data;
+	int ret = -ENOTTY;
+
+	switch (cmd) {
+	case FPGA_IMAGE_LOAD_WRITE:
+		mutex_lock(&imgld->lock);
+		ret = fpga_image_load_ioctl_write(imgld, arg);
+		mutex_unlock(&imgld->lock);
+		break;
+	}
+
+	return ret;
+}
+
+static int fpga_image_load_open(struct inode *inode, struct file *filp)
+{
+	struct fpga_image_load *imgld = container_of(inode->i_cdev,
+						     struct fpga_image_load, cdev);
+
+	if (test_and_set_bit(0, &imgld->opened))
+		return -EBUSY;
+
+	filp->private_data = imgld;
+
+	return 0;
+}
+
+static int fpga_image_load_release(struct inode *inode, struct file *filp)
+{
+	struct fpga_image_load *imgld = filp->private_data;
+
+	clear_bit(0, &imgld->opened);
+
+	return 0;
+}
+
+static const struct file_operations fpga_image_load_fops = {
+	.owner = THIS_MODULE,
+	.open = fpga_image_load_open,
+	.release = fpga_image_load_release,
+	.unlocked_ioctl = fpga_image_load_ioctl,
+};
+
 /**
  * fpga_image_load_register - create and register an FPGA Image Load Device
  *
@@ -33,11 +196,17 @@ fpga_image_load_register(struct device *parent,
 			 const struct fpga_image_load_ops *lops, void *priv)
 {
 	struct fpga_image_load *imgld;
-	int id, ret;
+	int ret;
+
+	if (!lops || !lops->cancel || !lops->prepare ||
+	    !lops->write_blk || !lops->poll_complete) {
+		dev_err(parent, "Attempt to register without all required ops\n");
+		return ERR_PTR(-ENOMEM);
+	}
 
 	imgld = kzalloc(sizeof(*imgld), GFP_KERNEL);
 	if (!imgld)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	ret = xa_alloc(&fpga_image_load_xa, &imgld->dev.id, imgld, IMAGE_LOAD_XA_LIMIT,
 		       GFP_KERNEL);
@@ -48,13 +217,19 @@ fpga_image_load_register(struct device *parent,
 
 	imgld->priv = priv;
 	imgld->lops = lops;
+	imgld->err_code = FPGA_IMAGE_ERR_NONE;
+	imgld->progress = FPGA_IMAGE_PROG_IDLE;
+	init_completion(&imgld->update_done);
+	INIT_WORK(&imgld->work, fpga_image_do_load);
 
 	imgld->dev.class = fpga_image_load_class;
 	imgld->dev.parent = parent;
+	imgld->dev.devt = MKDEV(MAJOR(fpga_image_devt), imgld->dev.id);
 
-	ret = dev_set_name(&imgld->dev, "fpga_image%d", id);
+	ret = dev_set_name(&imgld->dev, "fpga_image%d", imgld->dev.id);
 	if (ret) {
-		dev_err(parent, "Failed to set device name: fpga_image%d\n", id);
+		dev_err(parent, "Failed to set device name: fpga_image%d\n",
+			imgld->dev.id);
 		goto error_device;
 	}
 
@@ -64,6 +239,16 @@ fpga_image_load_register(struct device *parent,
 		return ERR_PTR(ret);
 	}
 
+	cdev_init(&imgld->cdev, &fpga_image_load_fops);
+	imgld->cdev.owner = parent->driver->owner;
+	imgld->cdev.kobj.parent = &imgld->dev.kobj;
+
+	ret = cdev_add(&imgld->cdev, imgld->dev.devt, 1);
+	if (ret) {
+		put_device(&imgld->dev);
+		return ERR_PTR(ret);
+	}
+
 	return imgld;
 
 error_device:
@@ -83,9 +268,29 @@ EXPORT_SYMBOL_GPL(fpga_image_load_register);
  *
  * This function is intended for use in an FPGA Image Load driver's
  * remove() function.
+ *
+ * For some devices, once authentication of the uploaded image has begun,
+ * the hardware cannot be signaled to stop, and the driver will not exit
+ * until the hardware signals completion.  This could be 30+ minutes of
+ * waiting. The driver_unload flag enables a force-unload of the driver
+ * (e.g. modprobe -r) by signaling the parent driver to exit even if the
+ * hardware update is incomplete. The driver_unload flag also prevents
+ * new updates from starting once the unregister process has begun.
  */
 void fpga_image_load_unregister(struct fpga_image_load *imgld)
 {
+	mutex_lock(&imgld->lock);
+	imgld->driver_unload = true;
+	if (imgld->progress == FPGA_IMAGE_PROG_IDLE) {
+		mutex_unlock(&imgld->lock);
+		goto unregister;
+	}
+
+	mutex_unlock(&imgld->lock);
+	wait_for_completion(&imgld->update_done);
+
+unregister:
+	cdev_del(&imgld->cdev);
 	device_unregister(&imgld->dev);
 }
 EXPORT_SYMBOL_GPL(fpga_image_load_unregister);
@@ -100,19 +305,30 @@ static void fpga_image_load_dev_release(struct device *dev)
 
 static int __init fpga_image_load_class_init(void)
 {
+	int ret;
 	pr_info("FPGA Image Load Driver\n");
 
 	fpga_image_load_class = class_create(THIS_MODULE, "fpga_image_load");
 	if (IS_ERR(fpga_image_load_class))
 		return PTR_ERR(fpga_image_load_class);
 
+	ret = alloc_chrdev_region(&fpga_image_devt, 0, MINORMASK,
+				  "fpga_image_load");
+	if (ret)
+		goto exit_destroy_class;
+
 	fpga_image_load_class->dev_release = fpga_image_load_dev_release;
 
 	return 0;
+
+exit_destroy_class:
+	class_destroy(fpga_image_load_class);
+	return ret;
 }
 
 static void __exit fpga_image_load_class_exit(void)
 {
+	unregister_chrdev_region(fpga_image_devt, MINORMASK);
 	class_destroy(fpga_image_load_class);
 	WARN_ON(!xa_empty(&fpga_image_load_xa));
 }
diff --git a/include/linux/fpga/fpga-image-load.h b/include/linux/fpga/fpga-image-load.h
index a9cef9e1056b..b3d790e5d943 100644
--- a/include/linux/fpga/fpga-image-load.h
+++ b/include/linux/fpga/fpga-image-load.h
@@ -7,22 +7,51 @@
 #ifndef _LINUX_FPGA_IMAGE_LOAD_H
 #define _LINUX_FPGA_IMAGE_LOAD_H
 
+#include <linux/cdev.h>
+#include <linux/completion.h>
 #include <linux/device.h>
 #include <linux/mutex.h>
 #include <linux/types.h>
+#include <uapi/linux/fpga-image-load.h>
 
 struct fpga_image_load;
 
 /**
  * struct fpga_image_load_ops - device specific operations
+ * @prepare:		    Required: Prepare secure update
+ * @write_blk:		    Required: Write a block of data
+ * @poll_complete:	    Required: Check for the completion of the
+ *			    HW authentication/programming process. This
+ *			    function should check for imgld->driver_unload
+ *			    and abort with FPGA_IMAGE_ERR_CANCELED when true.
+ * @cancel:		    Required: Signal HW to cancel update
+ * @cleanup:		    Optional: Complements the prepare()
+ *			    function and is called at the completion
+ *			    of the update, whether success or failure,
+ *			    if the prepare function succeeded.
  */
 struct fpga_image_load_ops {
+	enum fpga_image_err (*prepare)(struct fpga_image_load *imgld);
+	enum fpga_image_err (*write_blk)(struct fpga_image_load *imgld, u32 offset);
+	enum fpga_image_err (*poll_complete)(struct fpga_image_load *imgld);
+	enum fpga_image_err (*cancel)(struct fpga_image_load *imgld);
+	void (*cleanup)(struct fpga_image_load *imgld);
 };
 
 struct fpga_image_load {
 	struct device dev;
+	struct cdev cdev;
 	const struct fpga_image_load_ops *lops;
 	struct mutex lock;		/* protect data structure contents */
+	unsigned long opened;
+	struct work_struct work;
+	struct completion update_done;
+	const u8 *data;				/* pointer to update data */
+	u32 remaining_size;			/* size remaining to transfer */
+	enum fpga_image_prog progress;
+	enum fpga_image_prog err_progress;	/* progress at time of failure */
+	enum fpga_image_err err_code;		/* image load error code */
+	bool driver_unload;
 	void *priv;
 };
 
diff --git a/include/uapi/linux/fpga-image-load.h b/include/uapi/linux/fpga-image-load.h
new file mode 100644
index 000000000000..4146a0a9e408
--- /dev/null
+++ b/include/uapi/linux/fpga-image-load.h
@@ -0,0 +1,58 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Header File for FPGA Image Load User API
+ *
+ * Copyright (C) 2019-2021 Intel Corporation, Inc.
+ *
+ */
+
+#ifndef _UAPI_LINUX_FPGA_IMAGE_LOAD_H
+#define _UAPI_LINUX_FPGA_IMAGE_LOAD_H
+
+#include <linux/types.h>
+#include <linux/ioctl.h>
+
+#define FPGA_IMAGE_LOAD_MAGIC 0xB9
+
+/* Image load progress codes */
+enum fpga_image_prog {
+	FPGA_IMAGE_PROG_IDLE,
+	FPGA_IMAGE_PROG_STARTING,
+	FPGA_IMAGE_PROG_PREPARING,
+	FPGA_IMAGE_PROG_WRITING,
+	FPGA_IMAGE_PROG_PROGRAMMING,
+	FPGA_IMAGE_PROG_MAX
+};
+
+/* Image error progress codes */
+enum fpga_image_err {
+	FPGA_IMAGE_ERR_NONE,
+	FPGA_IMAGE_ERR_HW_ERROR,
+	FPGA_IMAGE_ERR_TIMEOUT,
+	FPGA_IMAGE_ERR_CANCELED,
+	FPGA_IMAGE_ERR_BUSY,
+	FPGA_IMAGE_ERR_INVALID_SIZE,
+	FPGA_IMAGE_ERR_RW_ERROR,
+	FPGA_IMAGE_ERR_WEAROUT,
+	FPGA_IMAGE_ERR_MAX
+};
+
+#define FPGA_IMAGE_LOAD_WRITE	_IOW(FPGA_IMAGE_LOAD_MAGIC, 0, struct fpga_image_write)
+
+/**
+ * FPGA_IMAGE_LOAD_WRITE - _IOW(FPGA_IMAGE_LOAD_MAGIC, 0,
+ *				struct fpga_image_write)
+ *
+ * Upload a data buffer to the target device. The user must provide the
+ * data buffer, size, and an eventfd file descriptor.
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+struct fpga_image_write {
+	/* Input */
+	__u32 flags;		/* Zero for now */
+	__u32 size;		/* Data size (in bytes) to be written */
+	__u64 buf;		/* User space address of source data */
+};
+
+#endif /* _UAPI_LINUX_FPGA_IMAGE_LOAD_H */
-- 
2.25.1


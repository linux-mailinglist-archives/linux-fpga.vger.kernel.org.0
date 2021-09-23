Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD3F8415473
	for <lists+linux-fpga@lfdr.de>; Thu, 23 Sep 2021 02:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238524AbhIWAMw (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 22 Sep 2021 20:12:52 -0400
Received: from mga14.intel.com ([192.55.52.115]:12010 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238608AbhIWAMv (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 22 Sep 2021 20:12:51 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10115"; a="223376118"
X-IronPort-AV: E=Sophos;i="5.85,315,1624345200"; 
   d="scan'208";a="223376118"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2021 17:11:20 -0700
X-IronPort-AV: E=Sophos;i="5.85,315,1624345200"; 
   d="scan'208";a="653478225"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO rhweight-mobl2.ra.intel.com) ([10.209.87.52])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2021 17:11:20 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v16 2/5] fpga: image-load: enable image uploads
Date:   Wed, 22 Sep 2021 17:10:53 -0700
Message-Id: <20210923001056.282790-3-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210923001056.282790-1-russell.h.weight@intel.com>
References: <20210923001056.282790-1-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Extend the FPGA Image Load framework to include IOCTL support
(FPGA_IMAGE_LOAD_WRITE) for initiating an upload of an image to a device.
The IOCTL will return immediately, and the update will begin in the
context of a kernel worker thread.

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
---
v16:
 - Shift from "Driver" terminology to "Framework" in comments and
   documentation
 - Rename lops to ops for structure member and local variables
 - Change the write_blk() definition to pass in *blk_size (a pointer to
   a default block size of WRITE_BLOCK_SIZE=0x4000) and max_size (the
   the maximum block size to stay within the limit of the data buffer).
   The write_blk() op may use the default *blk_size or modify it to a
   more optimal number for the given device, subject to the max_size limit.
 - All enum values for progress and errors are changed to macros, because
   they are included in the uapi header. This is done to maintain consistency
   amongst the DFL related IOCTL header files. All references to the enum
   types are changed to u32.
 - Bail out early in fpga_image_do_load() if imgld->driver_unload is true.
 - Add a call to cond_resched() in the write_blk() loop to ensure that
   we yield to higher priority tasks during long data transfers.
 - Switch to the system_unbound_wq to enable calls to cond_resched().
 - Switch from test_and_set_bit() to atomic_cmpxchg() to manage
   imgld->opened.
 - Change fpga_image_load_release() to block until the image upload is
   complete.
 - Remove the completion object, imgld->update_done, in favor of calling
   flush_work(&imgld->work);
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
 Documentation/fpga/fpga-image-load.rst |  26 ++-
 MAINTAINERS                            |   1 +
 drivers/fpga/fpga-image-load.c         | 238 ++++++++++++++++++++++++-
 include/linux/fpga/fpga-image-load.h   |  29 +++
 include/uapi/linux/fpga-image-load.h   |  54 ++++++
 5 files changed, 346 insertions(+), 2 deletions(-)
 create mode 100644 include/uapi/linux/fpga-image-load.h

diff --git a/Documentation/fpga/fpga-image-load.rst b/Documentation/fpga/fpga-image-load.rst
index dda9283ef1c7..ba371c7c0ca0 100644
--- a/Documentation/fpga/fpga-image-load.rst
+++ b/Documentation/fpga/fpga-image-load.rst
@@ -7,4 +7,28 @@ FPGA Image Load Framework
 The FPGA Image Load framework provides a common API for user-space
 tools to manage image uploads to FPGA devices. Device drivers that
 instantiate the FPGA Image Load framework will interact with the
-target device to transfer and authenticate the image data.
+target device to transfer and authenticate the image data. Image uploads
+are processed in the context of a kernel worker thread.
+
+User API
+========
+
+open
+----
+
+An fpga_image_load device is opened exclusively to control an image upload.
+The device must remain open throughout the duration of the image upload.
+An attempt to close the device while an upload is in progress will cause
+the upload to be cancelled. If unable to cancel the image upload, the close
+system call will block until the image upload is complete.
+
+ioctl
+-----
+
+FPGA_IMAGE_LOAD_WRITE:
+
+Start an image upload with the provided image buffer. This IOCTL returns
+immediately after starting a kernel worker thread to process the image
+upload which could take as long a 40 minutes depending on the actual device
+being updated. This is an exclusive operation; an attempt to start
+concurrent image uploads for the same device will fail with EBUSY.
diff --git a/MAINTAINERS b/MAINTAINERS
index 6e312d0ddeb6..4e44f62eef33 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7372,6 +7372,7 @@ S:	Maintained
 F:	Documentation/fpga/fpga-image-load.rst
 F:	drivers/fpga/fpga-image-load.c
 F:	include/linux/fpga/fpga-image-load.h
+F:	include/uapi/linux/fpga-image-load.h
 
 FPU EMULATOR
 M:	Bill Metzenthen <billm@melbpc.org.au>
diff --git a/drivers/fpga/fpga-image-load.c b/drivers/fpga/fpga-image-load.c
index 799d18444f7c..65f553b59011 100644
--- a/drivers/fpga/fpga-image-load.c
+++ b/drivers/fpga/fpga-image-load.c
@@ -5,18 +5,210 @@
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
 
+#define WRITE_BLOCK_SIZE 0x4000	/* Default write-block size is 0x4000 bytes */
+
+static void fpga_image_dev_error(struct fpga_image_load *imgld, u32 err_code)
+{
+	imgld->err_code = err_code;
+	imgld->ops->cancel(imgld);
+}
+
+static void fpga_image_prog_complete(struct fpga_image_load *imgld)
+{
+	mutex_lock(&imgld->lock);
+	imgld->progress = FPGA_IMAGE_PROG_IDLE;
+	mutex_unlock(&imgld->lock);
+}
+
+static void fpga_image_do_load(struct work_struct *work)
+{
+	struct fpga_image_load *imgld;
+	u32 ret, blk_size, offset = 0;
+
+	imgld = container_of(work, struct fpga_image_load, work);
+
+	if (imgld->driver_unload) {
+		imgld->err_code = FPGA_IMAGE_ERR_CANCELED;
+		goto idle_exit;
+	}
+
+	get_device(&imgld->dev);
+	if (!try_module_get(imgld->dev.parent->driver->owner)) {
+		imgld->err_code = FPGA_IMAGE_ERR_BUSY;
+		goto putdev_exit;
+	}
+
+	imgld->progress = FPGA_IMAGE_PROG_PREPARING;
+	ret = imgld->ops->prepare(imgld);
+	if (ret != FPGA_IMAGE_ERR_NONE) {
+		fpga_image_dev_error(imgld, ret);
+		goto modput_exit;
+	}
+
+	imgld->progress = FPGA_IMAGE_PROG_WRITING;
+	while (imgld->remaining_size) {
+		/*
+		 * The write_blk() op has the option to use the blk_size
+		 * value provided here, or to modify it to something more
+		 * optimal for the given device.
+		 */
+		blk_size = min_t(u32, WRITE_BLOCK_SIZE, imgld->remaining_size);
+		ret = imgld->ops->write_blk(imgld, offset, &blk_size,
+					    imgld->remaining_size);
+		if (ret != FPGA_IMAGE_ERR_NONE) {
+			fpga_image_dev_error(imgld, ret);
+			goto done;
+		}
+
+		imgld->remaining_size -= blk_size;
+		offset += blk_size;
+
+		/*
+		 * The class driver does not have control of the overall
+		 * size or the actual implementation of the write. Allow
+		 * for scheduling out.
+		 */
+		cond_resched();
+	}
+
+	imgld->progress = FPGA_IMAGE_PROG_PROGRAMMING;
+	ret = imgld->ops->poll_complete(imgld);
+	if (ret != FPGA_IMAGE_ERR_NONE)
+		fpga_image_dev_error(imgld, ret);
+
+done:
+	if (imgld->ops->cleanup)
+		imgld->ops->cleanup(imgld);
+
+modput_exit:
+	module_put(imgld->dev.parent->driver->owner);
+
+putdev_exit:
+	put_device(&imgld->dev);
+
+idle_exit:
+	/*
+	 * Note: imgld->remaining_size is left unmodified here to provide
+	 * additional information on errors. It will be reinitialized when
+	 * the next image load begins.
+	 */
+	vfree(imgld->data);
+	imgld->data = NULL;
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
+	queue_work(system_unbound_wq, &imgld->work);
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
+	if (atomic_cmpxchg(&imgld->opened, 0, 1))
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
+	mutex_lock(&imgld->lock);
+	if (imgld->progress == FPGA_IMAGE_PROG_IDLE) {
+		mutex_unlock(&imgld->lock);
+		goto close_exit;
+	}
+
+	mutex_unlock(&imgld->lock);
+	flush_work(&imgld->work);
+
+close_exit:
+	atomic_set(&imgld->opened, 0);
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
@@ -35,6 +227,12 @@ fpga_image_load_register(struct device *parent,
 	struct fpga_image_load *imgld;
 	int ret;
 
+	if (!ops || !ops->cancel || !ops->prepare ||
+	    !ops->write_blk || !ops->poll_complete) {
+		dev_err(parent, "Attempt to register without all required ops\n");
+		return ERR_PTR(-ENOMEM);
+	}
+
 	imgld = kzalloc(sizeof(*imgld), GFP_KERNEL);
 	if (!imgld)
 		return ERR_PTR(-ENOMEM);
@@ -48,9 +246,13 @@ fpga_image_load_register(struct device *parent,
 
 	imgld->priv = priv;
 	imgld->ops = ops;
+	imgld->err_code = FPGA_IMAGE_ERR_NONE;
+	imgld->progress = FPGA_IMAGE_PROG_IDLE;
+	INIT_WORK(&imgld->work, fpga_image_do_load);
 
 	imgld->dev.class = fpga_image_load_class;
 	imgld->dev.parent = parent;
+	imgld->dev.devt = MKDEV(MAJOR(fpga_image_devt), imgld->dev.id);
 
 	ret = dev_set_name(&imgld->dev, "fpga_image_load%d", imgld->dev.id);
 	if (ret) {
@@ -65,6 +267,16 @@ fpga_image_load_register(struct device *parent,
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
@@ -83,10 +295,23 @@ EXPORT_SYMBOL_GPL(fpga_image_load_register);
  * @imgld: pointer to struct fpga_image_load
  *
  * This function is intended for use in the parent driver's remove()
- * function.
+ * function. The driver_unload flag prevents new updates from starting
+ * once the unregister process has begun.
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
+	flush_work(&imgld->work);
+
+unregister:
+	cdev_del(&imgld->cdev);
 	device_unregister(&imgld->dev);
 }
 EXPORT_SYMBOL_GPL(fpga_image_load_unregister);
@@ -101,19 +326,30 @@ static void fpga_image_load_dev_release(struct device *dev)
 
 static int __init fpga_image_load_class_init(void)
 {
+	int ret;
 	pr_info("FPGA Image Load Framework\n");
 
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
index 8b051c82ef5f..41ab63cf7b20 100644
--- a/include/linux/fpga/fpga-image-load.h
+++ b/include/linux/fpga/fpga-image-load.h
@@ -7,22 +7,51 @@
 #ifndef _LINUX_FPGA_IMAGE_LOAD_H
 #define _LINUX_FPGA_IMAGE_LOAD_H
 
+#include <linux/cdev.h>
 #include <linux/device.h>
 #include <linux/mutex.h>
 #include <linux/types.h>
+#include <uapi/linux/fpga-image-load.h>
 
 struct fpga_image_load;
 
 /**
  * struct fpga_image_load_ops - device specific operations
+ * @prepare:		    Required: Prepare secure update
+ * @write_blk:		    Required: Write a block of data. The class driver
+ *			    provides a default block size. The write_blk() op
+ *			    may choose to modify *blk_size to something more
+ *			    optimal for the given device. *blk_size must be
+ *			    less than or equal to max_size.
+ * @poll_complete:	    Required: Check for the completion of the
+ *			    HW authentication/programming process.
+ * @cancel:		    Required: Signal HW to cancel update
+ * @cleanup:		    Optional: Complements the prepare()
+ *			    function and is called at the completion
+ *			    of the update, whether success or failure,
+ *			    if the prepare function succeeded.
  */
 struct fpga_image_load_ops {
+	u32 (*prepare)(struct fpga_image_load *imgld);
+	u32 (*write_blk)(struct fpga_image_load *imgld, u32 offset,
+			 u32 *blk_size, u32 max_size);
+	u32 (*poll_complete)(struct fpga_image_load *imgld);
+	u32 (*cancel)(struct fpga_image_load *imgld);
+	void (*cleanup)(struct fpga_image_load *imgld);
 };
 
 struct fpga_image_load {
 	struct device dev;
+	struct cdev cdev;
 	const struct fpga_image_load_ops *ops;
 	struct mutex lock;		/* protect data structure contents */
+	atomic_t opened;
+	struct work_struct work;
+	const u8 *data;			/* pointer to update data */
+	u32 remaining_size;		/* size remaining to transfer */
+	u32 progress;
+	u32 err_code;			/* image load error code */
+	bool driver_unload;
 	void *priv;
 };
 
diff --git a/include/uapi/linux/fpga-image-load.h b/include/uapi/linux/fpga-image-load.h
new file mode 100644
index 000000000000..0382078c5a6c
--- /dev/null
+++ b/include/uapi/linux/fpga-image-load.h
@@ -0,0 +1,54 @@
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
+#define FPGA_IMAGE_PROG_IDLE		0
+#define FPGA_IMAGE_PROG_STARTING	1
+#define FPGA_IMAGE_PROG_PREPARING	2
+#define FPGA_IMAGE_PROG_WRITING		3
+#define FPGA_IMAGE_PROG_PROGRAMMING	4
+#define FPGA_IMAGE_PROG_MAX		5
+
+/* Image error progress codes */
+#define FPGA_IMAGE_ERR_NONE		0
+#define FPGA_IMAGE_ERR_HW_ERROR		1
+#define FPGA_IMAGE_ERR_TIMEOUT		2
+#define FPGA_IMAGE_ERR_CANCELED		3
+#define FPGA_IMAGE_ERR_BUSY		4
+#define FPGA_IMAGE_ERR_INVALID_SIZE	5
+#define FPGA_IMAGE_ERR_RW_ERROR		6
+#define FPGA_IMAGE_ERR_WEAROUT		7
+#define FPGA_IMAGE_ERR_MAX		8
+
+/**
+ * FPGA_IMAGE_LOAD_WRITE - _IOW(FPGA_IMAGE_LOAD_MAGIC, 0,
+ *				struct fpga_image_write)
+ *
+ * Upload a data buffer to the target device. The user must provide the
+ * data buffer and size.
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
+#define FPGA_IMAGE_LOAD_WRITE	_IOW(FPGA_IMAGE_LOAD_MAGIC, 0, struct fpga_image_write)
+
+#endif /* _UAPI_LINUX_FPGA_IMAGE_LOAD_H */
-- 
2.25.1


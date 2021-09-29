Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D129041CF9D
	for <lists+linux-fpga@lfdr.de>; Thu, 30 Sep 2021 01:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347369AbhI2XCV (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 29 Sep 2021 19:02:21 -0400
Received: from mga09.intel.com ([134.134.136.24]:47379 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347368AbhI2XCO (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 29 Sep 2021 19:02:14 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10122"; a="225097219"
X-IronPort-AV: E=Sophos;i="5.85,334,1624345200"; 
   d="scan'208";a="225097219"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2021 16:00:31 -0700
X-IronPort-AV: E=Sophos;i="5.85,334,1624345200"; 
   d="scan'208";a="617768040"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO rhweight-mobl2.ra.intel.com) ([10.255.230.76])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2021 16:00:31 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v17 4/5] fpga: image-load: add status ioctl
Date:   Wed, 29 Sep 2021 16:00:24 -0700
Message-Id: <20210929230025.68961-5-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210929230025.68961-1-russell.h.weight@intel.com>
References: <20210929230025.68961-1-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Extend the FPGA Image Load framework to include an FPGA_IMAGE_LOAD_STATUS
IOCTL that can be used to monitor the progress of an ongoing image upload.
The status returned includes how much data remains to be transferred, the
progress of the image upload, and error information in the case of a
failure.

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
---
v17:
 - Rebased for changes to earlier patches.
v16:
 - Minor changes to adapt in changes in prevoius patches.
v15:
 - This patch is new to the patchset and provides an FPGA_IMAGE_LOAD_STATUS
   IOCTL to return the current values for: remaining_size, progress,
   err_progress, and err_code.
 - This patch has elements of the following three patches from the previous
   patch-set:
     [PATCH v14 3/6] fpga: sec-mgr: expose sec-mgr update status
     [PATCH v14 4/6] fpga: sec-mgr: expose sec-mgr update errors
     [PATCH v14 5/6] fpga: sec-mgr: expose sec-mgr update size
 - Changed file, symbol, and config names to reflect the new driver name
 - There are some minor changes to locking to enable this ioctl to return
   coherent data.
---
 Documentation/fpga/fpga-image-load.rst |  6 +++
 drivers/fpga/fpga-image-load.c         | 58 +++++++++++++++++++++-----
 include/linux/fpga/fpga-image-load.h   |  1 +
 include/uapi/linux/fpga-image-load.h   | 18 ++++++++
 4 files changed, 73 insertions(+), 10 deletions(-)

diff --git a/Documentation/fpga/fpga-image-load.rst b/Documentation/fpga/fpga-image-load.rst
index 487b5466f67c..f64f5ee473b8 100644
--- a/Documentation/fpga/fpga-image-load.rst
+++ b/Documentation/fpga/fpga-image-load.rst
@@ -33,3 +33,9 @@ being updated. This is an exclusive operation; an attempt to start
 concurrent image uploads for the same device will fail with EBUSY. An
 eventfd file descriptor parameter is provided to this IOCTL. It will be
 signalled at the completion of the image upload.
+
+FPGA_IMAGE_LOAD_STATUS:
+
+Collect status for an on-going image upload. The status returned includes
+how much data remains to be transferred, the progress of the image upload,
+and error information in the case of a failure.
diff --git a/drivers/fpga/fpga-image-load.c b/drivers/fpga/fpga-image-load.c
index f04dfc71c190..58373b9e8c02 100644
--- a/drivers/fpga/fpga-image-load.c
+++ b/drivers/fpga/fpga-image-load.c
@@ -22,6 +22,22 @@ static dev_t fpga_image_devt;
 
 #define to_image_load(d) container_of(d, struct fpga_image_load, dev)
 
+static void fpga_image_update_progress(struct fpga_image_load *imgld,
+				       u32 new_progress)
+{
+	mutex_lock(&imgld->lock);
+	imgld->progress = new_progress;
+	mutex_unlock(&imgld->lock);
+}
+
+static void fpga_image_set_error(struct fpga_image_load *imgld, u32 err_code)
+{
+	mutex_lock(&imgld->lock);
+	imgld->err_progress = imgld->progress;
+	imgld->err_code = err_code;
+	mutex_unlock(&imgld->lock);
+}
+
 static void fpga_image_prog_complete(struct fpga_image_load *imgld)
 {
 	mutex_lock(&imgld->lock);
@@ -38,24 +54,24 @@ static void fpga_image_do_load(struct work_struct *work)
 	imgld = container_of(work, struct fpga_image_load, work);
 
 	if (imgld->driver_unload) {
-		imgld->err_code = FPGA_IMAGE_ERR_CANCELED;
+		fpga_image_set_error(imgld, FPGA_IMAGE_ERR_CANCELED);
 		goto idle_exit;
 	}
 
 	get_device(&imgld->dev);
 	if (!try_module_get(imgld->dev.parent->driver->owner)) {
-		imgld->err_code = FPGA_IMAGE_ERR_BUSY;
+		fpga_image_set_error(imgld, FPGA_IMAGE_ERR_BUSY);
 		goto putdev_exit;
 	}
 
-	imgld->progress = FPGA_IMAGE_PROG_PREPARING;
+	fpga_image_update_progress(imgld, FPGA_IMAGE_PROG_PREPARING);
 	ret = imgld->ops->prepare(imgld, imgld->data, imgld->remaining_size);
 	if (ret) {
-		imgld->err_code = ret;
+		fpga_image_set_error(imgld, ret);
 		goto modput_exit;
 	}
 
-	imgld->progress = FPGA_IMAGE_PROG_WRITING;
+	fpga_image_update_progress(imgld, FPGA_IMAGE_PROG_WRITING);
 	while (imgld->remaining_size) {
 		ret = imgld->ops->write(imgld, imgld->data, offset,
 					imgld->remaining_size);
@@ -65,7 +81,7 @@ static void fpga_image_do_load(struct work_struct *work)
 					 "write-op wrote zero data\n");
 				ret = -FPGA_IMAGE_ERR_RW_ERROR;
 			}
-			imgld->err_code = -ret;
+			fpga_image_set_error(imgld, -ret);
 			goto done;
 		}
 
@@ -73,10 +89,10 @@ static void fpga_image_do_load(struct work_struct *work)
 		offset += ret;
 	}
 
-	imgld->progress = FPGA_IMAGE_PROG_PROGRAMMING;
+	fpga_image_update_progress(imgld, FPGA_IMAGE_PROG_PROGRAMMING);
 	ret = imgld->ops->poll_complete(imgld);
 	if (ret)
-		imgld->err_code = ret;
+		fpga_image_set_error(imgld, ret);
 
 done:
 	if (imgld->ops->cleanup)
@@ -151,20 +167,42 @@ static int fpga_image_load_ioctl_write(struct fpga_image_load *imgld,
 	return ret;
 }
 
+static int fpga_image_load_ioctl_status(struct fpga_image_load *imgld,
+					unsigned long arg)
+{
+	struct fpga_image_status status;
+
+	memset(&status, 0, sizeof(status));
+	status.progress = imgld->progress;
+	status.remaining_size = imgld->remaining_size;
+	status.err_progress = imgld->err_progress;
+	status.err_code = imgld->err_code;
+
+	if (copy_to_user((void __user *)arg, &status, sizeof(status)))
+		return -EFAULT;
+
+	return 0;
+}
+
 static long fpga_image_load_ioctl(struct file *filp, unsigned int cmd,
 				  unsigned long arg)
 {
 	struct fpga_image_load *imgld = filp->private_data;
 	int ret = -ENOTTY;
 
+	mutex_lock(&imgld->lock);
+
 	switch (cmd) {
 	case FPGA_IMAGE_LOAD_WRITE:
-		mutex_lock(&imgld->lock);
 		ret = fpga_image_load_ioctl_write(imgld, arg);
-		mutex_unlock(&imgld->lock);
+		break;
+	case FPGA_IMAGE_LOAD_STATUS:
+		ret = fpga_image_load_ioctl_status(imgld, arg);
 		break;
 	}
 
+	mutex_unlock(&imgld->lock);
+
 	return ret;
 }
 
diff --git a/include/linux/fpga/fpga-image-load.h b/include/linux/fpga/fpga-image-load.h
index 77b3c91ce073..366111d090fb 100644
--- a/include/linux/fpga/fpga-image-load.h
+++ b/include/linux/fpga/fpga-image-load.h
@@ -49,6 +49,7 @@ struct fpga_image_load {
 	const u8 *data;			/* pointer to update data */
 	u32 remaining_size;		/* size remaining to transfer */
 	u32 progress;
+	u32 err_progress;		/* progress at time of error */
 	u32 err_code;			/* image load error code */
 	bool driver_unload;
 	struct eventfd_ctx *finished;
diff --git a/include/uapi/linux/fpga-image-load.h b/include/uapi/linux/fpga-image-load.h
index 8d2d3db92e87..1b91343961df 100644
--- a/include/uapi/linux/fpga-image-load.h
+++ b/include/uapi/linux/fpga-image-load.h
@@ -51,4 +51,22 @@ struct fpga_image_write {
 
 #define FPGA_IMAGE_LOAD_WRITE	_IOW(FPGA_IMAGE_LOAD_MAGIC, 0, struct fpga_image_write)
 
+/**
+ * FPGA_IMAGE_LOAD_STATUS - _IOR(FPGA_IMAGE_LOAD_MAGIC, 1,
+ *				 struct fpga_image_status)
+ *
+ * Request status information for an ongoing update.
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+struct fpga_image_status {
+	/* Output */
+	__u32 remaining_size;	/* size remaining to transfer */
+	__u32 progress;		/* current progress of image load */
+	__u32 err_progress;	/* progress at time of error */
+	__u32 err_code;		/* error code */
+};
+
+#define FPGA_IMAGE_LOAD_STATUS	_IOR(FPGA_IMAGE_LOAD_MAGIC, 1, struct fpga_image_status)
+
 #endif /* _UAPI_LINUX_FPGA_IMAGE_LOAD_H */
-- 
2.25.1


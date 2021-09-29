Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8808541CF9C
	for <lists+linux-fpga@lfdr.de>; Thu, 30 Sep 2021 01:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347156AbhI2XCU (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 29 Sep 2021 19:02:20 -0400
Received: from mga09.intel.com ([134.134.136.24]:47376 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347367AbhI2XCO (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 29 Sep 2021 19:02:14 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10122"; a="225097217"
X-IronPort-AV: E=Sophos;i="5.85,334,1624345200"; 
   d="scan'208";a="225097217"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2021 16:00:31 -0700
X-IronPort-AV: E=Sophos;i="5.85,334,1624345200"; 
   d="scan'208";a="617768036"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO rhweight-mobl2.ra.intel.com) ([10.255.230.76])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2021 16:00:30 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v17 3/5] fpga: image-load: signal eventfd when complete
Date:   Wed, 29 Sep 2021 16:00:23 -0700
Message-Id: <20210929230025.68961-4-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210929230025.68961-1-russell.h.weight@intel.com>
References: <20210929230025.68961-1-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Amend the FPGA_IMAGE_LOAD_WRITE IOCTL implementation to include an
eventfd file descriptor as a parameter. The eventfd will be triggered
when the image upload completes.

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
---
v17:
 - More documentation cleanup.
v16:
 - Some cleanup of documentation for the FPGA_IMAGE_LOAD_WRITE IOCTL.
v15:
 - This patch is new to the patch-set, and adds an eventfd to the
   FPGA_IMAGE_LOAD_WRITE IOCTL. The eventfd is signalled upon completion
   of an update.
---
 Documentation/fpga/fpga-image-load.rst |  8 +++++---
 drivers/fpga/fpga-image-load.c         | 22 ++++++++++++++++++++--
 include/linux/fpga/fpga-image-load.h   |  2 ++
 include/uapi/linux/fpga-image-load.h   |  3 ++-
 4 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/Documentation/fpga/fpga-image-load.rst b/Documentation/fpga/fpga-image-load.rst
index f6b0e1624a05..487b5466f67c 100644
--- a/Documentation/fpga/fpga-image-load.rst
+++ b/Documentation/fpga/fpga-image-load.rst
@@ -28,6 +28,8 @@ FPGA_IMAGE_LOAD_WRITE:
 
 Start an image upload with the provided image buffer. This IOCTL returns
 immediately after starting a kernel worker thread to process the image
-upload which could take as long as 40 minutes depending on the actual
-device being updated. This is an exclusive operation; an attempt to start
-concurrent image uploads for the same device will fail with EBUSY.
+upload which could take as long as 40 minutes depending on the actual device
+being updated. This is an exclusive operation; an attempt to start
+concurrent image uploads for the same device will fail with EBUSY. An
+eventfd file descriptor parameter is provided to this IOCTL. It will be
+signalled at the completion of the image upload.
diff --git a/drivers/fpga/fpga-image-load.c b/drivers/fpga/fpga-image-load.c
index 4c2571e3b26f..f04dfc71c190 100644
--- a/drivers/fpga/fpga-image-load.c
+++ b/drivers/fpga/fpga-image-load.c
@@ -26,6 +26,7 @@ static void fpga_image_prog_complete(struct fpga_image_load *imgld)
 {
 	mutex_lock(&imgld->lock);
 	imgld->progress = FPGA_IMAGE_PROG_IDLE;
+	eventfd_signal(imgld->finished, 1);
 	mutex_unlock(&imgld->lock);
 }
 
@@ -96,6 +97,8 @@ static void fpga_image_do_load(struct work_struct *work)
 	vfree(imgld->data);
 	imgld->data = NULL;
 	fpga_image_prog_complete(imgld);
+	eventfd_ctx_put(imgld->finished);
+	imgld->finished = NULL;
 }
 
 static int fpga_image_load_ioctl_write(struct fpga_image_load *imgld,
@@ -103,6 +106,7 @@ static int fpga_image_load_ioctl_write(struct fpga_image_load *imgld,
 {
 	struct fpga_image_write wb;
 	unsigned long minsz;
+	int ret;
 	u8 *buf;
 
 	if (imgld->driver_unload || imgld->progress != FPGA_IMAGE_PROG_IDLE)
@@ -115,13 +119,23 @@ static int fpga_image_load_ioctl_write(struct fpga_image_load *imgld,
 	if (wb.flags)
 		return -EINVAL;
 
+	if (wb.evtfd < 0)
+		return -EINVAL;
+
 	buf = vzalloc(wb.size);
 	if (!buf)
 		return -ENOMEM;
 
 	if (copy_from_user(buf, u64_to_user_ptr(wb.buf), wb.size)) {
-		vfree(buf);
-		return -EFAULT;
+		ret = -EFAULT;
+		goto exit_free;
+	}
+
+	imgld->finished = eventfd_ctx_fdget(wb.evtfd);
+	if (IS_ERR(imgld->finished)) {
+		ret = PTR_ERR(imgld->finished);
+		imgld->finished = NULL;
+		goto exit_free;
 	}
 
 	imgld->data = buf;
@@ -131,6 +145,10 @@ static int fpga_image_load_ioctl_write(struct fpga_image_load *imgld,
 	queue_work(system_long_wq, &imgld->work);
 
 	return 0;
+
+exit_free:
+	vfree(buf);
+	return ret;
 }
 
 static long fpga_image_load_ioctl(struct file *filp, unsigned int cmd,
diff --git a/include/linux/fpga/fpga-image-load.h b/include/linux/fpga/fpga-image-load.h
index 7b445f489644..77b3c91ce073 100644
--- a/include/linux/fpga/fpga-image-load.h
+++ b/include/linux/fpga/fpga-image-load.h
@@ -9,6 +9,7 @@
 
 #include <linux/cdev.h>
 #include <linux/device.h>
+#include <linux/eventfd.h>
 #include <linux/mutex.h>
 #include <linux/types.h>
 #include <uapi/linux/fpga-image-load.h>
@@ -50,6 +51,7 @@ struct fpga_image_load {
 	u32 progress;
 	u32 err_code;			/* image load error code */
 	bool driver_unload;
+	struct eventfd_ctx *finished;
 	void *priv;
 };
 
diff --git a/include/uapi/linux/fpga-image-load.h b/include/uapi/linux/fpga-image-load.h
index 20eae3bb10d8..8d2d3db92e87 100644
--- a/include/uapi/linux/fpga-image-load.h
+++ b/include/uapi/linux/fpga-image-load.h
@@ -37,7 +37,7 @@
  *				struct fpga_image_write)
  *
  * Upload a data buffer to the target device. The user must provide the
- * data buffer and size.
+ * data buffer, size, and an eventfd file descriptor.
  *
  * Return: 0 on success, -errno on failure.
  */
@@ -45,6 +45,7 @@ struct fpga_image_write {
 	/* Input */
 	__u32 flags;		/* Zero for now */
 	__u32 size;		/* Data size (in bytes) to be written */
+	__s32 evtfd;		/* File descriptor for completion signal */
 	__u64 buf;		/* User space address of source data */
 };
 
-- 
2.25.1


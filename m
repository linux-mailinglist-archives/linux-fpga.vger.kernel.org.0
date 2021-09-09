Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2ED940437D
	for <lists+linux-fpga@lfdr.de>; Thu,  9 Sep 2021 04:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346657AbhIICUT (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 8 Sep 2021 22:20:19 -0400
Received: from mga04.intel.com ([192.55.52.120]:63717 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236112AbhIICUQ (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 8 Sep 2021 22:20:16 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10101"; a="218793849"
X-IronPort-AV: E=Sophos;i="5.85,279,1624345200"; 
   d="scan'208";a="218793849"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2021 19:18:55 -0700
X-IronPort-AV: E=Sophos;i="5.85,279,1624345200"; 
   d="scan'208";a="503916533"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO rhweight-mobl2.ra.intel.com) ([10.212.194.237])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2021 19:18:54 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v15 3/6] fpga: image-load: signal eventfd when complete
Date:   Wed,  8 Sep 2021 19:18:43 -0700
Message-Id: <20210909021846.681121-4-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210909021846.681121-1-russell.h.weight@intel.com>
References: <20210909021846.681121-1-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Amend the FPGA_IMAGE_LOAD_WRITE IOCTL implementation to include and
eventfd file descriptor as a parameter. The eventfd will be triggered
when the image upload completes.

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
---
v15:
 - This patch is new to the patch-set, and adds an eventfd to the
   FPGA_IMAGE_LOAD_WRITE IOCTL. The eventfd is signalled upon completion
   of an update.
---
 Documentation/fpga/fpga-image-load.rst |  4 +++-
 drivers/fpga/fpga-image-load.c         | 23 ++++++++++++++++++++---
 include/linux/fpga/fpga-image-load.h   |  2 ++
 include/uapi/linux/fpga-image-load.h   |  1 +
 4 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/Documentation/fpga/fpga-image-load.rst b/Documentation/fpga/fpga-image-load.rst
index 2ca8d2f0212d..739d735592a5 100644
--- a/Documentation/fpga/fpga-image-load.rst
+++ b/Documentation/fpga/fpga-image-load.rst
@@ -28,4 +28,6 @@ Start an image load with the provided image buffer. This IOCTL returns
 immediately after starting a kernel worker thread to process the image load
 which could take as long a 40 minutes depending on the actual device being
 updated. This is an exclusive operation; an attempt to start concurrent image
-load for the same device will fail with EBUSY.
+load for the same device will fail with EBUSY. An eventfd file descriptor
+parameter is provided to this IOCTL, and it will be signalled at the
+completion of the image load.
diff --git a/drivers/fpga/fpga-image-load.c b/drivers/fpga/fpga-image-load.c
index f5ccfa9dd977..b784456765b0 100644
--- a/drivers/fpga/fpga-image-load.c
+++ b/drivers/fpga/fpga-image-load.c
@@ -33,6 +33,7 @@ static void fpga_image_prog_complete(struct fpga_image_load *imgld)
 {
 	mutex_lock(&imgld->lock);
 	imgld->progress = FPGA_IMAGE_PROG_IDLE;
+	eventfd_signal(imgld->finished, 1);
 	complete_all(&imgld->update_done);
 	mutex_unlock(&imgld->lock);
 }
@@ -92,6 +93,8 @@ static void fpga_image_do_load(struct work_struct *work)
 	imgld->data = NULL;
 	put_device(&imgld->dev);
 	fpga_image_prog_complete(imgld);
+	eventfd_ctx_put(imgld->finished);
+	imgld->finished = NULL;
 }
 
 static int fpga_image_load_ioctl_write(struct fpga_image_load *imgld,
@@ -99,6 +102,7 @@ static int fpga_image_load_ioctl_write(struct fpga_image_load *imgld,
 {
 	struct fpga_image_write wb;
 	unsigned long minsz;
+	int ret;
 	u8 *buf;
 
 	if (imgld->driver_unload || imgld->progress != FPGA_IMAGE_PROG_IDLE)
@@ -115,13 +119,23 @@ static int fpga_image_load_ioctl_write(struct fpga_image_load *imgld,
 	if (wb.size & 0x3)
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
@@ -130,8 +144,11 @@ static int fpga_image_load_ioctl_write(struct fpga_image_load *imgld,
 	imgld->progress = FPGA_IMAGE_PROG_STARTING;
 	reinit_completion(&imgld->update_done);
 	schedule_work(&imgld->work);
-
 	return 0;
+
+exit_free:
+	vfree(buf);
+	return ret;
 }
 
 static long fpga_image_load_ioctl(struct file *filp, unsigned int cmd,
diff --git a/include/linux/fpga/fpga-image-load.h b/include/linux/fpga/fpga-image-load.h
index b3d790e5d943..68f3105b51d2 100644
--- a/include/linux/fpga/fpga-image-load.h
+++ b/include/linux/fpga/fpga-image-load.h
@@ -10,6 +10,7 @@
 #include <linux/cdev.h>
 #include <linux/completion.h>
 #include <linux/device.h>
+#include <linux/eventfd.h>
 #include <linux/mutex.h>
 #include <linux/types.h>
 #include <uapi/linux/fpga-image-load.h>
@@ -52,6 +53,7 @@ struct fpga_image_load {
 	enum fpga_image_prog err_progress;	/* progress at time of failure */
 	enum fpga_image_err err_code;		/* image load error code */
 	bool driver_unload;
+	struct eventfd_ctx *finished;
 	void *priv;
 };
 
diff --git a/include/uapi/linux/fpga-image-load.h b/include/uapi/linux/fpga-image-load.h
index 4146a0a9e408..a60da115adf5 100644
--- a/include/uapi/linux/fpga-image-load.h
+++ b/include/uapi/linux/fpga-image-load.h
@@ -52,6 +52,7 @@ struct fpga_image_write {
 	/* Input */
 	__u32 flags;		/* Zero for now */
 	__u32 size;		/* Data size (in bytes) to be written */
+	__s32 evtfd;		/* File descriptor for completion signal */
 	__u64 buf;		/* User space address of source data */
 };
 
-- 
2.25.1


Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D095415477
	for <lists+linux-fpga@lfdr.de>; Thu, 23 Sep 2021 02:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238689AbhIWAMy (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 22 Sep 2021 20:12:54 -0400
Received: from mga14.intel.com ([192.55.52.115]:12010 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238661AbhIWAMw (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 22 Sep 2021 20:12:52 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10115"; a="223376121"
X-IronPort-AV: E=Sophos;i="5.85,315,1624345200"; 
   d="scan'208";a="223376121"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2021 17:11:21 -0700
X-IronPort-AV: E=Sophos;i="5.85,315,1624345200"; 
   d="scan'208";a="653478237"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO rhweight-mobl2.ra.intel.com) ([10.209.87.52])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2021 17:11:21 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v16 5/5] fpga: image-load: enable cancel of image upload
Date:   Wed, 22 Sep 2021 17:10:56 -0700
Message-Id: <20210923001056.282790-6-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210923001056.282790-1-russell.h.weight@intel.com>
References: <20210923001056.282790-1-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Extend the FPGA Image Load framework to include a cancel IOCTL that can be
used to request that an image upload be canceled. The IOCTL may return
EBUSY if it cannot be canceled by software or ENODEV if there is no update
in progress.

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
---
v16:
 - This was previously patch 6/6
 - Amend fpga_image_load_release() to request cancellation of an ongoing
   update when possible.
v15:
 - Compare to previous patch:
     [PATCH v14 6/6] fpga: sec-mgr: enable cancel of secure update
 - Changed file, symbol, and config names to reflect the new driver name
 - Cancel is now initiated by IOCT instead of sysfs
 - Removed signed-off/reviewed-by tags
v14:
 - Updated ABI documentation date and kernel version
v13:
  - No change
v12:
  - Updated Date and KernelVersion fields in ABI documentation
v11:
  - No change
v10:
  - Rebased to 5.12-rc2 next
  - Updated Date and KernelVersion in ABI documentation
v9:
  - Updated Date and KernelVersion in ABI documentation
v8:
  - No change
v7:
  - Changed Date in documentation file to December 2020
v6:
  - No change
v5:
  - No change
v4:
  - Changed from "Intel FPGA Security Manager" to FPGA Security Manager"
    and removed unnecessary references to "Intel".
  - Changed: iops -> sops, imgr -> smgr, IFPGA_ -> FPGA_, ifpga_ to fpga_
v3:
  - No change
v2:
  - Bumped documentation date and version
  - Minor code cleanup per review comments
---
 Documentation/fpga/fpga-image-load.rst |  6 ++++
 drivers/fpga/fpga-image-load.c         | 49 +++++++++++++++++++++++---
 include/linux/fpga/fpga-image-load.h   |  1 +
 include/uapi/linux/fpga-image-load.h   |  2 ++
 4 files changed, 53 insertions(+), 5 deletions(-)

diff --git a/Documentation/fpga/fpga-image-load.rst b/Documentation/fpga/fpga-image-load.rst
index 572e18afebb9..21fa85f18680 100644
--- a/Documentation/fpga/fpga-image-load.rst
+++ b/Documentation/fpga/fpga-image-load.rst
@@ -40,3 +40,9 @@ FPGA_IMAGE_LOAD_STATUS:
 Collect status for an on-going image upload. The status returned includes
 how much data remains to be transferred, the progress of the image load,
 and error information in the case of a failure.
+
+FPGA_IMAGE_LOAD_CANCEL:
+
+Request that a on-going image upload be cancelled. This IOCTL may return
+EBUSY if it cannot be cancelled by software or ENODEV if there is no update
+in progress.
diff --git a/drivers/fpga/fpga-image-load.c b/drivers/fpga/fpga-image-load.c
index 2e9a5a041535..a95d18077d58 100644
--- a/drivers/fpga/fpga-image-load.c
+++ b/drivers/fpga/fpga-image-load.c
@@ -46,6 +46,24 @@ static void fpga_image_dev_error(struct fpga_image_load *imgld, u32 err_code)
 	imgld->ops->cancel(imgld);
 }
 
+static int fpga_image_prog_transition(struct fpga_image_load *imgld,
+				      u32 new_progress)
+{
+	int ret = 0;
+
+	mutex_lock(&imgld->lock);
+	if (imgld->request_cancel) {
+		imgld->err_progress = imgld->progress;
+		imgld->err_code = FPGA_IMAGE_ERR_CANCELED;
+		imgld->ops->cancel(imgld);
+		ret = -ECANCELED;
+	} else {
+		imgld->progress = new_progress;
+	}
+	mutex_unlock(&imgld->lock);
+	return ret;
+}
+
 static void fpga_image_prog_complete(struct fpga_image_load *imgld)
 {
 	mutex_lock(&imgld->lock);
@@ -79,8 +97,10 @@ static void fpga_image_do_load(struct work_struct *work)
 		goto modput_exit;
 	}
 
-	fpga_image_update_progress(imgld, FPGA_IMAGE_PROG_WRITING);
-	while (imgld->remaining_size) {
+	if (fpga_image_prog_transition(imgld, FPGA_IMAGE_PROG_WRITING))
+		goto done;
+
+	while (imgld->remaining_size && !imgld->request_cancel) {
 		/*
 		 * The write_blk() op has the option to use the blk_size
 		 * value provided here, or to modify it to something more
@@ -105,7 +125,9 @@ static void fpga_image_do_load(struct work_struct *work)
 		cond_resched();
 	}
 
-	fpga_image_update_progress(imgld, FPGA_IMAGE_PROG_PROGRAMMING);
+	if (fpga_image_prog_transition(imgld, FPGA_IMAGE_PROG_PROGRAMMING))
+		goto done;
+
 	ret = imgld->ops->poll_complete(imgld);
 	if (ret != FPGA_IMAGE_ERR_NONE)
 		fpga_image_dev_error(imgld, ret);
@@ -178,8 +200,8 @@ static int fpga_image_load_ioctl_write(struct fpga_image_load *imgld,
 	imgld->remaining_size = wb.size;
 	imgld->err_code = FPGA_IMAGE_ERR_NONE;
 	imgld->progress = FPGA_IMAGE_PROG_STARTING;
+	imgld->request_cancel = false;
 	queue_work(system_unbound_wq, &imgld->work);
-
 	return 0;
 
 exit_free:
@@ -208,7 +230,7 @@ static long fpga_image_load_ioctl(struct file *filp, unsigned int cmd,
 				  unsigned long arg)
 {
 	struct fpga_image_load *imgld = filp->private_data;
-	int ret = -ENOTTY;
+	int ret = 0;
 
 	mutex_lock(&imgld->lock);
 
@@ -219,6 +241,17 @@ static long fpga_image_load_ioctl(struct file *filp, unsigned int cmd,
 	case FPGA_IMAGE_LOAD_STATUS:
 		ret = fpga_image_load_ioctl_status(imgld, arg);
 		break;
+	case FPGA_IMAGE_LOAD_CANCEL:
+		if (imgld->progress == FPGA_IMAGE_PROG_PROGRAMMING)
+			ret = -EBUSY;
+		else if (imgld->progress == FPGA_IMAGE_PROG_IDLE)
+			ret = -ENODEV;
+		else
+			imgld->request_cancel = true;
+		break;
+	default:
+		ret = -ENOTTY;
+		break;
 	}
 
 	mutex_unlock(&imgld->lock);
@@ -249,6 +282,9 @@ static int fpga_image_load_release(struct inode *inode, struct file *filp)
 		goto close_exit;
 	}
 
+	if (imgld->progress != FPGA_IMAGE_PROG_PROGRAMMING)
+		imgld->request_cancel = true;
+
 	mutex_unlock(&imgld->lock);
 	flush_work(&imgld->work);
 
@@ -363,6 +399,9 @@ void fpga_image_load_unregister(struct fpga_image_load *imgld)
 		goto unregister;
 	}
 
+	if (imgld->progress != FPGA_IMAGE_PROG_PROGRAMMING)
+		imgld->request_cancel = true;
+
 	mutex_unlock(&imgld->lock);
 	flush_work(&imgld->work);
 
diff --git a/include/linux/fpga/fpga-image-load.h b/include/linux/fpga/fpga-image-load.h
index 8b58365893fc..8ba39d3299d9 100644
--- a/include/linux/fpga/fpga-image-load.h
+++ b/include/linux/fpga/fpga-image-load.h
@@ -53,6 +53,7 @@ struct fpga_image_load {
 	u32 progress;
 	u32 err_progress;		/* progress at time of error */
 	u32 err_code;			/* image load error code */
+	bool request_cancel;
 	bool driver_unload;
 	struct eventfd_ctx *finished;
 	void *priv;
diff --git a/include/uapi/linux/fpga-image-load.h b/include/uapi/linux/fpga-image-load.h
index dc0c9f1d78b1..da8a7452c29a 100644
--- a/include/uapi/linux/fpga-image-load.h
+++ b/include/uapi/linux/fpga-image-load.h
@@ -70,4 +70,6 @@ struct fpga_image_status {
 
 #define FPGA_IMAGE_LOAD_STATUS	_IOR(FPGA_IMAGE_LOAD_MAGIC, 1, struct fpga_image_status)
 
+#define FPGA_IMAGE_LOAD_CANCEL	_IO(FPGA_IMAGE_LOAD_MAGIC, 2)
+
 #endif /* _UAPI_LINUX_FPGA_IMAGE_LOAD_H */
-- 
2.25.1


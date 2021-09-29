Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 265B841CF9E
	for <lists+linux-fpga@lfdr.de>; Thu, 30 Sep 2021 01:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347375AbhI2XCV (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 29 Sep 2021 19:02:21 -0400
Received: from mga09.intel.com ([134.134.136.24]:47376 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347378AbhI2XCS (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 29 Sep 2021 19:02:18 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10122"; a="225097220"
X-IronPort-AV: E=Sophos;i="5.85,334,1624345200"; 
   d="scan'208";a="225097220"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2021 16:00:32 -0700
X-IronPort-AV: E=Sophos;i="5.85,334,1624345200"; 
   d="scan'208";a="617768043"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO rhweight-mobl2.ra.intel.com) ([10.255.230.76])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2021 16:00:31 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v17 5/5] fpga: image-load: enable cancel of image upload
Date:   Wed, 29 Sep 2021 16:00:25 -0700
Message-Id: <20210929230025.68961-6-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210929230025.68961-1-russell.h.weight@intel.com>
References: <20210929230025.68961-1-russell.h.weight@intel.com>
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
v17:
 - Documentation cleanup for cancelling.
 - Removed the request_cancel flag and handling from the class driver
   including the fpga_image_prog_transition() function.
 - The cancel system call now directly calls the cancel() op of the
   lower-level driver. 
 - Changed the cancel() op to return void.
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
 Documentation/fpga/fpga-image-load.rst | 13 +++++++++++--
 drivers/fpga/fpga-image-load.c         | 26 +++++++++++++++++++++++---
 include/linux/fpga/fpga-image-load.h   |  4 ++++
 include/uapi/linux/fpga-image-load.h   |  2 ++
 4 files changed, 40 insertions(+), 5 deletions(-)

diff --git a/Documentation/fpga/fpga-image-load.rst b/Documentation/fpga/fpga-image-load.rst
index f64f5ee473b8..3997b3bcd7ec 100644
--- a/Documentation/fpga/fpga-image-load.rst
+++ b/Documentation/fpga/fpga-image-load.rst
@@ -18,8 +18,9 @@ open
 
 An fpga_image_load device is opened exclusively to control an image upload.
 The device must remain open throughout the duration of the image upload.
-An attempt to close the device while an upload is in progress will block
-until the image upload is complete.
+An attempt to close the device while an upload is in progress will cause
+the upload to be cancelled. If unable to cancel the image upload, the close
+system call will block until the image upload is complete.
 
 ioctl
 -----
@@ -39,3 +40,11 @@ FPGA_IMAGE_LOAD_STATUS:
 Collect status for an on-going image upload. The status returned includes
 how much data remains to be transferred, the progress of the image upload,
 and error information in the case of a failure.
+
+FPGA_IMAGE_LOAD_CANCEL:
+
+Request that an on-going image upload be cancelled. This IOCTL will return
+ENODEV if there is no update in progress. Depending on the implementation
+of the lower-level driver, the cancellation may take affect immediately.
+In other cases, the cancellation request may be blocked until a critical
+operation such as a FLASH is safely completed.
diff --git a/drivers/fpga/fpga-image-load.c b/drivers/fpga/fpga-image-load.c
index 58373b9e8c02..239943d7f321 100644
--- a/drivers/fpga/fpga-image-load.c
+++ b/drivers/fpga/fpga-image-load.c
@@ -159,7 +159,6 @@ static int fpga_image_load_ioctl_write(struct fpga_image_load *imgld,
 	imgld->err_code = 0;
 	imgld->progress = FPGA_IMAGE_PROG_STARTING;
 	queue_work(system_long_wq, &imgld->work);
-
 	return 0;
 
 exit_free:
@@ -184,11 +183,21 @@ static int fpga_image_load_ioctl_status(struct fpga_image_load *imgld,
 	return 0;
 }
 
+static int fpga_image_load_ioctl_cancel(struct fpga_image_load *imgld,
+					unsigned long arg)
+{
+	if (imgld->progress == FPGA_IMAGE_PROG_IDLE)
+		return -ENODEV;
+
+	imgld->ops->cancel(imgld);
+	return 0;
+}
+
 static long fpga_image_load_ioctl(struct file *filp, unsigned int cmd,
 				  unsigned long arg)
 {
 	struct fpga_image_load *imgld = filp->private_data;
-	int ret = -ENOTTY;
+	int ret = 0;
 
 	mutex_lock(&imgld->lock);
 
@@ -199,6 +208,12 @@ static long fpga_image_load_ioctl(struct file *filp, unsigned int cmd,
 	case FPGA_IMAGE_LOAD_STATUS:
 		ret = fpga_image_load_ioctl_status(imgld, arg);
 		break;
+	case FPGA_IMAGE_LOAD_CANCEL:
+		ret = fpga_image_load_ioctl_cancel(imgld, arg);
+		break;
+	default:
+		ret = -ENOTTY;
+		break;
 	}
 
 	mutex_unlock(&imgld->lock);
@@ -229,6 +244,8 @@ static int fpga_image_load_release(struct inode *inode, struct file *filp)
 		goto close_exit;
 	}
 
+	imgld->ops->cancel(imgld);
+
 	mutex_unlock(&imgld->lock);
 	flush_work(&imgld->work);
 
@@ -263,7 +280,8 @@ fpga_image_load_register(struct device *parent,
 	struct fpga_image_load *imgld;
 	int ret;
 
-	if (!ops || !ops->prepare || !ops->write || !ops->poll_complete) {
+	if (!ops || !ops->cancel || !ops->prepare ||
+	    !ops->write || !ops->poll_complete) {
 		dev_err(parent, "Attempt to register without all required ops\n");
 		return ERR_PTR(-ENOMEM);
 	}
@@ -342,6 +360,8 @@ void fpga_image_load_unregister(struct fpga_image_load *imgld)
 		goto unregister;
 	}
 
+	imgld->ops->cancel(imgld);
+
 	mutex_unlock(&imgld->lock);
 	flush_work(&imgld->work);
 
diff --git a/include/linux/fpga/fpga-image-load.h b/include/linux/fpga/fpga-image-load.h
index 366111d090fb..6baf45072bdb 100644
--- a/include/linux/fpga/fpga-image-load.h
+++ b/include/linux/fpga/fpga-image-load.h
@@ -26,6 +26,9 @@ struct fpga_image_load;
  *			    written.
  * @poll_complete:	    Required: Check for the completion of the
  *			    HW authentication/programming process.
+ * @cancel:		    Required: Request cancellation of update. This op
+ *			    is called from the context of a different kernel
+ *			    thread, so race conditions need to be considered.
  * @cleanup:		    Optional: Complements the prepare()
  *			    function and is called at the completion
  *			    of the update, whether success or failure,
@@ -36,6 +39,7 @@ struct fpga_image_load_ops {
 	s32 (*write)(struct fpga_image_load *imgld, const u8 *data,
 		     u32 offset, u32 size);
 	u32 (*poll_complete)(struct fpga_image_load *imgld);
+	void (*cancel)(struct fpga_image_load *imgld);
 	void (*cleanup)(struct fpga_image_load *imgld);
 };
 
diff --git a/include/uapi/linux/fpga-image-load.h b/include/uapi/linux/fpga-image-load.h
index 1b91343961df..5bf8a8a57757 100644
--- a/include/uapi/linux/fpga-image-load.h
+++ b/include/uapi/linux/fpga-image-load.h
@@ -69,4 +69,6 @@ struct fpga_image_status {
 
 #define FPGA_IMAGE_LOAD_STATUS	_IOR(FPGA_IMAGE_LOAD_MAGIC, 1, struct fpga_image_status)
 
+#define FPGA_IMAGE_LOAD_CANCEL	_IO(FPGA_IMAGE_LOAD_MAGIC, 2)
+
 #endif /* _UAPI_LINUX_FPGA_IMAGE_LOAD_H */
-- 
2.25.1


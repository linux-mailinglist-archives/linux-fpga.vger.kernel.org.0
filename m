Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2D2D3D8302
	for <lists+linux-fpga@lfdr.de>; Wed, 28 Jul 2021 00:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbhG0WbX (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 27 Jul 2021 18:31:23 -0400
Received: from mga11.intel.com ([192.55.52.93]:37532 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232810AbhG0WbU (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 27 Jul 2021 18:31:20 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10058"; a="209429194"
X-IronPort-AV: E=Sophos;i="5.84,275,1620716400"; 
   d="scan'208";a="209429194"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2021 15:31:17 -0700
X-IronPort-AV: E=Sophos;i="5.84,275,1620716400"; 
   d="scan'208";a="437502459"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO rhweight-mobl2.ra.intel.com) ([10.209.69.186])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2021 15:31:17 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        richard.gong@intel.com, Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v14 4/6] fpga: sec-mgr: expose sec-mgr update errors
Date:   Tue, 27 Jul 2021 15:31:03 -0700
Message-Id: <20210727223105.152142-5-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210727223105.152142-1-russell.h.weight@intel.com>
References: <20210727223105.152142-1-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Extend the FPGA Security Manager class driver to include
an update/error sysfs node that can be read for error
information when a secure update fails.

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Reviewed-by: Tom Rix <trix@redhat.com>
---
v14:
 - Updated ABI documentation date and kernel version
v13:
  - Change set_error() to fpga_sec_set_error()
v12:
  - Updated Date and KernelVersion fields in ABI documentation
  - Changed syntax of sec_mgr_err_str[] array definition from:
	"none",			/* FPGA_SEC_ERR_NONE */
    to:
	[FPGA_SEC_ERR_NONE]	    = "none",
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
  - Use new function sysfs_emit() in the error_show() function
v4:
  - Changed from "Intel FPGA Security Manager" to FPGA Security Manager"
    and removed unnecessary references to "Intel".
  - Changed: iops -> sops, imgr -> smgr, IFPGA_ -> FPGA_, ifpga_ to fpga_
v3:
  - Use dev_err() for invalid error code in sec_error()
v2:
  - Bumped documentation date and version
  - Added warning to sec_progress() for invalid progress status
  - Added sec_error() function (similar to sec_progress())
---
 .../ABI/testing/sysfs-class-fpga-sec-mgr      | 17 ++++
 drivers/fpga/fpga-sec-mgr.c                   | 83 ++++++++++++++++---
 include/linux/fpga/fpga-sec-mgr.h             |  1 +
 3 files changed, 89 insertions(+), 12 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-fpga-sec-mgr b/Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
index e62cb12d41d4..1c650a54fca5 100644
--- a/Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
+++ b/Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
@@ -21,3 +21,20 @@ Description:	Read-only. Returns a string describing the current
 		programming. Userspace code can poll on this file,
 		as it will be signaled by sysfs_notify() on each
 		state change.
+
+What: 		/sys/class/fpga_sec_mgr/fpga_secX/update/error
+Date:		Aug 2021
+KernelVersion:	5.15
+Contact:	Russ Weight <russell.h.weight@intel.com>
+Description:	Read-only. Returns a string describing the failure
+		of a secure update. This string will be in the form
+		of <STATUS>:<ERROR>, where <STATUS> will be one of
+		the status strings described for the status sysfs
+		file and <ERROR> will be one of the following:
+		hw-error, timeout, user-abort, device-busy,
+		invalid-file-size, read-write-error, flash-wearout,
+		file-read-error.  The error sysfs file is only
+		meaningful when the secure update engine is in the
+		idle state. If this file is read while a secure
+		update is in progress, then the read will fail with
+		EBUSY.
diff --git a/drivers/fpga/fpga-sec-mgr.c b/drivers/fpga/fpga-sec-mgr.c
index 436c00e4cd0f..a90a61b59094 100644
--- a/drivers/fpga/fpga-sec-mgr.c
+++ b/drivers/fpga/fpga-sec-mgr.c
@@ -27,10 +27,16 @@ static void update_progress(struct fpga_sec_mgr *smgr,
 	sysfs_notify(&smgr->dev.kobj, "update", "status");
 }
 
+static void fpga_sec_set_error(struct fpga_sec_mgr *smgr, enum fpga_sec_err err_code)
+{
+	smgr->err_state = smgr->progress;
+	smgr->err_code = err_code;
+}
+
 static void fpga_sec_dev_error(struct fpga_sec_mgr *smgr,
 			       enum fpga_sec_err err_code)
 {
-	smgr->err_code = err_code;
+	fpga_sec_set_error(smgr, err_code);
 	smgr->sops->cancel(smgr);
 }
 
@@ -53,7 +59,7 @@ static void fpga_sec_mgr_update(struct work_struct *work)
 
 	get_device(&smgr->dev);
 	if (request_firmware(&fw, smgr->filename, &smgr->dev)) {
-		smgr->err_code = FPGA_SEC_ERR_FILE_READ;
+		fpga_sec_set_error(smgr, FPGA_SEC_ERR_FILE_READ);
 		goto idle_exit;
 	}
 
@@ -61,7 +67,7 @@ static void fpga_sec_mgr_update(struct work_struct *work)
 	smgr->remaining_size = fw->size;
 
 	if (!try_module_get(smgr->dev.parent->driver->owner)) {
-		smgr->err_code = FPGA_SEC_ERR_BUSY;
+		fpga_sec_set_error(smgr, FPGA_SEC_ERR_BUSY);
 		goto release_fw_exit;
 	}
 
@@ -119,24 +125,76 @@ static const char * const sec_mgr_prog_str[] = {
 	[FPGA_SEC_PROG_PROGRAMMING] = "programming"
 };
 
-static ssize_t
-status_show(struct device *dev, struct device_attribute *attr, char *buf)
+static const char * const sec_mgr_err_str[] = {
+	[FPGA_SEC_ERR_NONE]	    = "none",
+	[FPGA_SEC_ERR_HW_ERROR]	    = "hw-error",
+	[FPGA_SEC_ERR_TIMEOUT]	    = "timeout",
+	[FPGA_SEC_ERR_CANCELED]	    = "user-abort",
+	[FPGA_SEC_ERR_BUSY]	    = "device-busy",
+	[FPGA_SEC_ERR_INVALID_SIZE] = "invalid-file-size",
+	[FPGA_SEC_ERR_RW_ERROR]	    = "read-write-error",
+	[FPGA_SEC_ERR_WEAROUT]	    = "flash-wearout",
+	[FPGA_SEC_ERR_FILE_READ]    = "file-read-error"
+};
+
+static const char *sec_progress(struct device *dev, enum fpga_sec_prog prog)
 {
-	struct fpga_sec_mgr *smgr = to_sec_mgr(dev);
 	const char *status = "unknown-status";
-	enum fpga_sec_prog progress;
 
-	progress = smgr->progress;
-	if (progress < FPGA_SEC_PROG_MAX)
-		status = sec_mgr_prog_str[progress];
+	if (prog < FPGA_SEC_PROG_MAX)
+		status = sec_mgr_prog_str[prog];
 	else
 		dev_err(dev, "Invalid status during secure update: %d\n",
-			progress);
+			prog);
 
-	return sysfs_emit(buf, "%s\n", status);
+	return status;
+}
+
+static const char *sec_error(struct device *dev, enum fpga_sec_err err_code)
+{
+	const char *error = "unknown-error";
+
+	if (err_code < FPGA_SEC_ERR_MAX)
+		error = sec_mgr_err_str[err_code];
+	else
+		dev_err(dev, "Invalid error code during secure update: %d\n",
+			err_code);
+
+	return error;
+}
+
+static ssize_t
+status_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct fpga_sec_mgr *smgr = to_sec_mgr(dev);
+
+	return sysfs_emit(buf, "%s\n", sec_progress(dev, smgr->progress));
 }
 static DEVICE_ATTR_RO(status);
 
+static ssize_t
+error_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct fpga_sec_mgr *smgr = to_sec_mgr(dev);
+	int ret;
+
+	mutex_lock(&smgr->lock);
+
+	if (smgr->progress != FPGA_SEC_PROG_IDLE)
+		ret = -EBUSY;
+	else if (!smgr->err_code)
+		ret = 0;
+	else
+		ret = sysfs_emit(buf, "%s:%s\n",
+				 sec_progress(dev, smgr->err_state),
+				 sec_error(dev, smgr->err_code));
+
+	mutex_unlock(&smgr->lock);
+
+	return ret;
+}
+static DEVICE_ATTR_RO(error);
+
 static ssize_t filename_store(struct device *dev, struct device_attribute *attr,
 			      const char *buf, size_t count)
 {
@@ -172,6 +230,7 @@ static DEVICE_ATTR_WO(filename);
 static struct attribute *sec_mgr_update_attrs[] = {
 	&dev_attr_filename.attr,
 	&dev_attr_status.attr,
+	&dev_attr_error.attr,
 	NULL,
 };
 
diff --git a/include/linux/fpga/fpga-sec-mgr.h b/include/linux/fpga/fpga-sec-mgr.h
index 97d868a27151..ea6f1dd711ca 100644
--- a/include/linux/fpga/fpga-sec-mgr.h
+++ b/include/linux/fpga/fpga-sec-mgr.h
@@ -69,6 +69,7 @@ struct fpga_sec_mgr {
 	const u8 *data;			/* pointer to update data */
 	u32 remaining_size;		/* size remaining to transfer */
 	enum fpga_sec_prog progress;
+	enum fpga_sec_prog err_state;	/* progress state at time of failure */
 	enum fpga_sec_err err_code;	/* security manager error code */
 	bool driver_unload;
 	void *priv;
-- 
2.25.1


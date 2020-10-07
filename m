Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7EDB28552C
	for <lists+linux-fpga@lfdr.de>; Wed,  7 Oct 2020 02:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgJGAKh (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 6 Oct 2020 20:10:37 -0400
Received: from mga04.intel.com ([192.55.52.120]:3659 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726830AbgJGAKe (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 6 Oct 2020 20:10:34 -0400
IronPort-SDR: W6quRrd460f7ZXYC1iPf/XiQhVv6Jh7AcGeSmE9JM0Te64UiUyh0JcQ4vv8OF2G5WJ84F6huhq
 hYJhUPaSUw+g==
X-IronPort-AV: E=McAfee;i="6000,8403,9766"; a="162139568"
X-IronPort-AV: E=Sophos;i="5.77,344,1596524400"; 
   d="scan'208";a="162139568"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2020 17:10:33 -0700
IronPort-SDR: q0rLuqb6BlNegbNtXA4+fLnYTXJTBmoxF8nMAV7IYEpLYnb7cGQoZ7bqzPgqLfWvBNH5FPrlOq
 ZKWR8zR00ZVQ==
X-IronPort-AV: E=Sophos;i="5.77,344,1596524400"; 
   d="scan'208";a="297380457"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO rhweight-mobl2.ra.intel.com) ([10.212.2.223])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2020 17:10:32 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v3 4/7] fpga: sec-mgr: expose sec-mgr update errors
Date:   Tue,  6 Oct 2020 17:10:01 -0700
Message-Id: <20201007001004.23790-5-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201007001004.23790-1-russell.h.weight@intel.com>
References: <20201007001004.23790-1-russell.h.weight@intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Extend Intel Security Manager class driver to include
an update/error sysfs node that can be read for error
information when a secure update fails.

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Reviewed-by: Tom Rix <trix@redhat.com>
---
v3:
  - Use dev_err() for invalid error code in sec_error()
v2:
  - Bumped documentation date and version
  - Added warning to sec_progress() for invalid progress status
  - Added sec_error() function (similar to sec_progress())
---
 .../ABI/testing/sysfs-class-ifpga-sec-mgr     | 17 ++++
 drivers/fpga/ifpga-sec-mgr.c                  | 83 ++++++++++++++++---
 include/linux/fpga/ifpga-sec-mgr.h            |  1 +
 3 files changed, 89 insertions(+), 12 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr b/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
index 73a5246fea1b..1f9f2c215e0c 100644
--- a/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
+++ b/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
@@ -89,3 +89,20 @@ Description:	Read-only. Returns a string describing the current
 		programming. Userspace code can poll on this file,
 		as it will be signaled by sysfs_notify() on each
 		state change.
+
+What: 		/sys/class/ifpga_sec_mgr/ifpga_secX/update/error
+Date:		Oct 2020
+KernelVersion:  5.11
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
diff --git a/drivers/fpga/ifpga-sec-mgr.c b/drivers/fpga/ifpga-sec-mgr.c
index ef71c042e20e..a45907b756bf 100644
--- a/drivers/fpga/ifpga-sec-mgr.c
+++ b/drivers/fpga/ifpga-sec-mgr.c
@@ -146,10 +146,16 @@ static void update_progress(struct ifpga_sec_mgr *imgr,
 	sysfs_notify(&imgr->dev.kobj, "update", "status");
 }
 
+static void set_error(struct ifpga_sec_mgr *imgr, enum ifpga_sec_err err_code)
+{
+	imgr->err_state = imgr->progress;
+	imgr->err_code = err_code;
+}
+
 static void ifpga_sec_dev_error(struct ifpga_sec_mgr *imgr,
 				enum ifpga_sec_err err_code)
 {
-	imgr->err_code = err_code;
+	set_error(imgr, err_code);
 	imgr->iops->cancel(imgr);
 }
 
@@ -172,7 +178,7 @@ static void ifpga_sec_mgr_update(struct work_struct *work)
 
 	get_device(&imgr->dev);
 	if (request_firmware(&fw, imgr->filename, &imgr->dev)) {
-		imgr->err_code = IFPGA_SEC_ERR_FILE_READ;
+		set_error(imgr, IFPGA_SEC_ERR_FILE_READ);
 		goto idle_exit;
 	}
 
@@ -180,7 +186,7 @@ static void ifpga_sec_mgr_update(struct work_struct *work)
 	imgr->remaining_size = fw->size;
 
 	if (!try_module_get(imgr->dev.parent->driver->owner)) {
-		imgr->err_code = IFPGA_SEC_ERR_BUSY;
+		set_error(imgr, IFPGA_SEC_ERR_BUSY);
 		goto release_fw_exit;
 	}
 
@@ -272,24 +278,76 @@ static const char * const sec_mgr_prog_str[] = {
 	"programming"		/* IFPGA_SEC_PROG_PROGRAMMING */
 };
 
-static ssize_t
-status_show(struct device *dev, struct device_attribute *attr, char *buf)
+static const char * const sec_mgr_err_str[] = {
+	"none",			/* IFPGA_SEC_ERR_NONE */
+	"hw-error",		/* IFPGA_SEC_ERR_HW_ERROR */
+	"timeout",		/* IFPGA_SEC_ERR_TIMEOUT */
+	"user-abort",		/* IFPGA_SEC_ERR_CANCELED */
+	"device-busy",		/* IFPGA_SEC_ERR_BUSY */
+	"invalid-file-size",	/* IFPGA_SEC_ERR_INVALID_SIZE */
+	"read-write-error",	/* IFPGA_SEC_ERR_RW_ERROR */
+	"flash-wearout",	/* IFPGA_SEC_ERR_WEAROUT */
+	"file-read-error"	/* IFPGA_SEC_ERR_FILE_READ */
+};
+
+static const char *sec_progress(struct device *dev, enum ifpga_sec_prog prog)
 {
-	struct ifpga_sec_mgr *imgr = to_sec_mgr(dev);
 	const char *status = "unknown-status";
-	enum ifpga_sec_prog progress;
 
-	progress = imgr->progress;
-	if (progress < IFPGA_SEC_PROG_MAX)
-		status = sec_mgr_prog_str[progress];
+	if (prog < IFPGA_SEC_PROG_MAX)
+		status = sec_mgr_prog_str[prog];
 	else
 		dev_err(dev, "Invalid status during secure update: %d\n",
-			progress);
+			prog);
+
+	return status;
+}
+
+static const char *sec_error(struct device *dev, enum ifpga_sec_err err_code)
+{
+	const char *error = "unknown-error";
+
+	if (err_code < IFPGA_SEC_ERR_MAX)
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
+	struct ifpga_sec_mgr *imgr = to_sec_mgr(dev);
 
-	return sprintf(buf, "%s\n", status);
+	return sprintf(buf, "%s\n", sec_progress(dev, imgr->progress));
 }
 static DEVICE_ATTR_RO(status);
 
+static ssize_t
+error_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct ifpga_sec_mgr *imgr = to_sec_mgr(dev);
+	int ret;
+
+	mutex_lock(&imgr->lock);
+
+	if (imgr->progress != IFPGA_SEC_PROG_IDLE)
+		ret = -EBUSY;
+	else if (!imgr->err_code)
+		ret = 0;
+	else
+		ret = sprintf(buf, "%s:%s\n",
+			      sec_progress(dev, imgr->err_state),
+			      sec_error(dev, imgr->err_code));
+
+	mutex_unlock(&imgr->lock);
+
+	return ret;
+}
+static DEVICE_ATTR_RO(error);
+
 static ssize_t filename_store(struct device *dev, struct device_attribute *attr,
 			      const char *buf, size_t count)
 {
@@ -325,6 +383,7 @@ static DEVICE_ATTR_WO(filename);
 static struct attribute *sec_mgr_update_attrs[] = {
 	&dev_attr_filename.attr,
 	&dev_attr_status.attr,
+	&dev_attr_error.attr,
 	NULL,
 };
 
diff --git a/include/linux/fpga/ifpga-sec-mgr.h b/include/linux/fpga/ifpga-sec-mgr.h
index 27008abd8e75..246e3d452c59 100644
--- a/include/linux/fpga/ifpga-sec-mgr.h
+++ b/include/linux/fpga/ifpga-sec-mgr.h
@@ -110,6 +110,7 @@ struct ifpga_sec_mgr {
 	const u8 *data;			/* pointer to update data */
 	u32 remaining_size;		/* size remaining to transfer */
 	enum ifpga_sec_prog progress;
+	enum ifpga_sec_prog err_state;	/* progress state at time of failure */
 	enum ifpga_sec_err err_code;	/* security manager error code */
 	bool driver_unload;
 	void *priv;
-- 
2.17.1


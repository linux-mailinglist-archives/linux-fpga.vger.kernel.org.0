Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 403BD286BFD
	for <lists+linux-fpga@lfdr.de>; Thu,  8 Oct 2020 02:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727663AbgJHAQ6 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 7 Oct 2020 20:16:58 -0400
Received: from mga01.intel.com ([192.55.52.88]:22311 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726671AbgJHAQz (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 7 Oct 2020 20:16:55 -0400
IronPort-SDR: E17kH3lsclOpS4Ha+8KRO0TmiRfdDys3uUMxL85bDn5yLNpkKqawXBKUBKORaFo3X8PWWwGPC3
 XM/KDbFq1UTg==
X-IronPort-AV: E=McAfee;i="6000,8403,9767"; a="182629353"
X-IronPort-AV: E=Sophos;i="5.77,348,1596524400"; 
   d="scan'208";a="182629353"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2020 17:16:53 -0700
IronPort-SDR: BYlJ4QiM5Dc9HM4HbGpzV/czjzILGV1Kneyv+QadhyGP2/ASEdKKA+0sWIDGwSAdGceyC+Py0L
 qBQPf2Js8zAQ==
X-IronPort-AV: E=Sophos;i="5.77,348,1596524400"; 
   d="scan'208";a="355169286"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO rhweight-mobl2.ra.intel.com) ([10.251.1.22])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2020 17:16:52 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v4 4/7] fpga: sec-mgr: expose sec-mgr update errors
Date:   Wed,  7 Oct 2020 17:16:38 -0700
Message-Id: <20201008001641.28305-5-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201008001641.28305-1-russell.h.weight@intel.com>
References: <20201008001641.28305-1-russell.h.weight@intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Extend the FPGA Security Manager class driver to include
an update/error sysfs node that can be read for error
information when a secure update fails.

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Reviewed-by: Tom Rix <trix@redhat.com>
---
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
index 69b4cf7e1cd4..560513653c70 100644
--- a/Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
+++ b/Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
@@ -89,3 +89,20 @@ Description:	Read-only. Returns a string describing the current
 		programming. Userspace code can poll on this file,
 		as it will be signaled by sysfs_notify() on each
 		state change.
+
+What: 		/sys/class/fpga_sec_mgr/fpga_secX/update/error
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
diff --git a/drivers/fpga/fpga-sec-mgr.c b/drivers/fpga/fpga-sec-mgr.c
index 0104f1af1409..bd6a15d25a01 100644
--- a/drivers/fpga/fpga-sec-mgr.c
+++ b/drivers/fpga/fpga-sec-mgr.c
@@ -146,10 +146,16 @@ static void update_progress(struct fpga_sec_mgr *smgr,
 	sysfs_notify(&smgr->dev.kobj, "update", "status");
 }
 
+static void set_error(struct fpga_sec_mgr *smgr, enum fpga_sec_err err_code)
+{
+	smgr->err_state = smgr->progress;
+	smgr->err_code = err_code;
+}
+
 static void fpga_sec_dev_error(struct fpga_sec_mgr *smgr,
 			       enum fpga_sec_err err_code)
 {
-	smgr->err_code = err_code;
+	set_error(smgr, err_code);
 	smgr->sops->cancel(smgr);
 }
 
@@ -172,7 +178,7 @@ static void fpga_sec_mgr_update(struct work_struct *work)
 
 	get_device(&smgr->dev);
 	if (request_firmware(&fw, smgr->filename, &smgr->dev)) {
-		smgr->err_code = FPGA_SEC_ERR_FILE_READ;
+		set_error(smgr, FPGA_SEC_ERR_FILE_READ);
 		goto idle_exit;
 	}
 
@@ -180,7 +186,7 @@ static void fpga_sec_mgr_update(struct work_struct *work)
 	smgr->remaining_size = fw->size;
 
 	if (!try_module_get(smgr->dev.parent->driver->owner)) {
-		smgr->err_code = FPGA_SEC_ERR_BUSY;
+		set_error(smgr, FPGA_SEC_ERR_BUSY);
 		goto release_fw_exit;
 	}
 
@@ -272,24 +278,76 @@ static const char * const sec_mgr_prog_str[] = {
 	"programming"		/* FPGA_SEC_PROG_PROGRAMMING */
 };
 
-static ssize_t
-status_show(struct device *dev, struct device_attribute *attr, char *buf)
+static const char * const sec_mgr_err_str[] = {
+	"none",			/* FPGA_SEC_ERR_NONE */
+	"hw-error",		/* FPGA_SEC_ERR_HW_ERROR */
+	"timeout",		/* FPGA_SEC_ERR_TIMEOUT */
+	"user-abort",		/* FPGA_SEC_ERR_CANCELED */
+	"device-busy",		/* FPGA_SEC_ERR_BUSY */
+	"invalid-file-size",	/* FPGA_SEC_ERR_INVALID_SIZE */
+	"read-write-error",	/* FPGA_SEC_ERR_RW_ERROR */
+	"flash-wearout",	/* FPGA_SEC_ERR_WEAROUT */
+	"file-read-error"	/* FPGA_SEC_ERR_FILE_READ */
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
+
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
 
-	return sprintf(buf, "%s\n", status);
+	return sprintf(buf, "%s\n", sec_progress(dev, smgr->progress));
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
+		ret = sprintf(buf, "%s:%s\n",
+			      sec_progress(dev, smgr->err_state),
+			      sec_error(dev, smgr->err_code));
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
@@ -325,6 +383,7 @@ static DEVICE_ATTR_WO(filename);
 static struct attribute *sec_mgr_update_attrs[] = {
 	&dev_attr_filename.attr,
 	&dev_attr_status.attr,
+	&dev_attr_error.attr,
 	NULL,
 };
 
diff --git a/include/linux/fpga/fpga-sec-mgr.h b/include/linux/fpga/fpga-sec-mgr.h
index 13e90af76c45..6e46f18ad990 100644
--- a/include/linux/fpga/fpga-sec-mgr.h
+++ b/include/linux/fpga/fpga-sec-mgr.h
@@ -110,6 +110,7 @@ struct fpga_sec_mgr {
 	const u8 *data;			/* pointer to update data */
 	u32 remaining_size;		/* size remaining to transfer */
 	enum fpga_sec_prog progress;
+	enum fpga_sec_prog err_state;	/* progress state at time of failure */
 	enum fpga_sec_err err_code;	/* security manager error code */
 	bool driver_unload;
 	void *priv;
-- 
2.17.1


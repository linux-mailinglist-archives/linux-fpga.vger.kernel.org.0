Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E162F3822C6
	for <lists+linux-fpga@lfdr.de>; Mon, 17 May 2021 04:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233286AbhEQCeH (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 16 May 2021 22:34:07 -0400
Received: from mail-pj1-f47.google.com ([209.85.216.47]:56142 "EHLO
        mail-pj1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbhEQCeH (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 16 May 2021 22:34:07 -0400
Received: by mail-pj1-f47.google.com with SMTP id gm21so2826036pjb.5
        for <linux-fpga@vger.kernel.org>; Sun, 16 May 2021 19:32:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ehdtCvrQFrOOSfyoxkOjmU0xRJHpl55+MdR/k6VjjDk=;
        b=I3TzG+TkgxyfYUtnY+EASpjB3DRyLktuppXs2yFEyEAE1zkjmsoXfL8gV4vfNfcrGX
         /MIftOYDpZtw7rsS2HXEuRtO6rH7Pe7J1ywE3LqaWyh7eznpieLG5egJTWeBfI/sIA/D
         KvqKBssJhsjeIyuxt+vNSK2mliHWKXJrrZtVN1eFT0QAsi0CSrD36dXbD2PebEaNjp8y
         3blMvuREowpyxogqQ4LfH+mMvF8D73sI1sbC2tbpET5q8PkGSsmB8kx7hV2d/ofziN8j
         1reNBa5Hs9zFTl/EU+uslalA3dQk+SnuJGV7/LpHNtnrm3FRrswMb5uPYDSpkl9PfWeH
         W1OQ==
X-Gm-Message-State: AOAM533kQAfOgiTOOrJb+ghIcy1fDjoq6Q07cZtr+PllFG+B4/i5rMQb
        CzTQqDLg+Q+dK1s4OBD1u+U=
X-Google-Smtp-Source: ABdhPJyTmML9vm/r9BOVmc4V36BpIVWE8SVl2daKbtONB+zjPCnF/WIHMQiGalg5afJXp4m/QpNklw==
X-Received: by 2002:a17:90a:c285:: with SMTP id f5mr1123211pjt.221.1621218770990;
        Sun, 16 May 2021 19:32:50 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id i123sm8911486pfc.53.2021.05.16.19.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 May 2021 19:32:50 -0700 (PDT)
From:   Moritz Fischer <mdf@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-fpga@vger.kernel.org, moritzf@google.com,
        Moritz Fischer <mdf@kernel.org>,
        Russ Weight <russell.h.weight@intel.com>,
        Tom Rix <trix@redhat.com>
Subject: [PATCH 04/12] fpga: sec-mgr: expose sec-mgr update errors
Date:   Sun, 16 May 2021 19:31:52 -0700
Message-Id: <20210517023200.52707-5-mdf@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210517023200.52707-1-mdf@kernel.org>
References: <20210517023200.52707-1-mdf@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Russ Weight <russell.h.weight@intel.com>

Extend the FPGA Security Manager class driver to include
an update/error sysfs node that can be read for error
information when a secure update fails.

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Reviewed-by: Tom Rix <trix@redhat.com>
Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
 .../ABI/testing/sysfs-class-fpga-sec-mgr      | 17 ++++
 drivers/fpga/fpga-sec-mgr.c                   | 83 ++++++++++++++++---
 include/linux/fpga/fpga-sec-mgr.h             |  1 +
 3 files changed, 89 insertions(+), 12 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-fpga-sec-mgr b/Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
index b962ad2cf18d..24890d04521f 100644
--- a/Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
+++ b/Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
@@ -27,3 +27,20 @@ Description:	Read-only. Returns a string describing the current
 		programming. Userspace code can poll on this file,
 		as it will be signaled by sysfs_notify() on each
 		state change.
+
+What: 		/sys/class/fpga_sec_mgr/fpga_secX/update/error
+Date:		June 2021
+KernelVersion:	5.14
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
index 19f60048a965..903385779a1f 100644
--- a/drivers/fpga/fpga-sec-mgr.c
+++ b/drivers/fpga/fpga-sec-mgr.c
@@ -30,10 +30,16 @@ static void update_progress(struct fpga_sec_mgr *smgr,
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
 
@@ -56,7 +62,7 @@ static void fpga_sec_mgr_update(struct work_struct *work)
 
 	get_device(&smgr->dev);
 	if (request_firmware(&fw, smgr->filename, &smgr->dev)) {
-		smgr->err_code = FPGA_SEC_ERR_FILE_READ;
+		fpga_sec_set_error(smgr, FPGA_SEC_ERR_FILE_READ);
 		goto idle_exit;
 	}
 
@@ -64,7 +70,7 @@ static void fpga_sec_mgr_update(struct work_struct *work)
 	smgr->remaining_size = fw->size;
 
 	if (!try_module_get(smgr->dev.parent->driver->owner)) {
-		smgr->err_code = FPGA_SEC_ERR_BUSY;
+		fpga_sec_set_error(smgr, FPGA_SEC_ERR_BUSY);
 		goto release_fw_exit;
 	}
 
@@ -122,24 +128,76 @@ static const char * const sec_mgr_prog_str[] = {
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
 
-	return sysfs_emit(buf, "%s\n", status);
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
@@ -175,6 +233,7 @@ static DEVICE_ATTR_WO(filename);
 static struct attribute *sec_mgr_update_attrs[] = {
 	&dev_attr_filename.attr,
 	&dev_attr_status.attr,
+	&dev_attr_error.attr,
 	NULL,
 };
 
diff --git a/include/linux/fpga/fpga-sec-mgr.h b/include/linux/fpga/fpga-sec-mgr.h
index 978ab98ffac5..6b7b8a3d6aac 100644
--- a/include/linux/fpga/fpga-sec-mgr.h
+++ b/include/linux/fpga/fpga-sec-mgr.h
@@ -70,6 +70,7 @@ struct fpga_sec_mgr {
 	const u8 *data;			/* pointer to update data */
 	u32 remaining_size;		/* size remaining to transfer */
 	enum fpga_sec_prog progress;
+	enum fpga_sec_prog err_state;	/* progress state at time of failure */
 	enum fpga_sec_err err_code;	/* security manager error code */
 	bool driver_unload;
 	void *priv;
-- 
2.31.1


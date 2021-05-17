Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 400F23822C5
	for <lists+linux-fpga@lfdr.de>; Mon, 17 May 2021 04:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233540AbhEQCeG (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 16 May 2021 22:34:06 -0400
Received: from mail-pj1-f44.google.com ([209.85.216.44]:39887 "EHLO
        mail-pj1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbhEQCeG (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 16 May 2021 22:34:06 -0400
Received: by mail-pj1-f44.google.com with SMTP id o17-20020a17090a9f91b029015cef5b3c50so4704098pjp.4
        for <linux-fpga@vger.kernel.org>; Sun, 16 May 2021 19:32:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DJP2r0HTltsuZLhBCo0vZGGWtiQ8kd8CkqmXzteVj+M=;
        b=agYdqmFcXkEdwOxvoeKT+0E/RJ/4quHeELsxfQbANzI0TFY5h6BfdNKjOyVrbXYT1a
         xlKE04Vkf2Csw4z/FkG7wfUn2UAvvyMqQKU97T+rlPd4bfcX4y9xHNQdLREQn2du1Rwh
         2Fq5C0Z2CaHt4xt55YOWLI5sOadoXAd4Ue3R9Ezwg/tGxwDEDnUILYdKlMJiO3Yo1JQH
         SKajn5CLB1tmf5mfagvIa0VkMzwMOzK7ITj/J+NGJ3nIKwn704EeXaODNm5f4jtbWdKx
         AZxRgSKihU1Z1znyXrVMbK1sl6a3xptA5XCc+OkSSVZwOmAGcvSAFKBdlQl60Xx6/qB+
         DTzw==
X-Gm-Message-State: AOAM530whvXGGuSqSWOfzkJXuyptJxCUQuR3a0/SVgRV75OxfwDVdwtK
        k/o03KWqis+DSCCJaMdaOAM=
X-Google-Smtp-Source: ABdhPJxWJPkSXoThXZNpcllFrZZ2aCWgHWz+LjV/G7lymIqndGCtqL7Azthd2xEYfzLzobmy3OtEjw==
X-Received: by 2002:a17:90a:aa96:: with SMTP id l22mr23682002pjq.173.1621218769329;
        Sun, 16 May 2021 19:32:49 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id 184sm1774468pfv.38.2021.05.16.19.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 May 2021 19:32:48 -0700 (PDT)
From:   Moritz Fischer <mdf@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-fpga@vger.kernel.org, moritzf@google.com,
        Moritz Fischer <mdf@kernel.org>,
        Russ Weight <russell.h.weight@intel.com>,
        Tom Rix <trix@redhat.com>
Subject: [PATCH 03/12] fpga: sec-mgr: expose sec-mgr update status
Date:   Sun, 16 May 2021 19:31:51 -0700
Message-Id: <20210517023200.52707-4-mdf@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210517023200.52707-1-mdf@kernel.org>
References: <20210517023200.52707-1-mdf@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Russ Weight <russell.h.weight@intel.com>

Extend the FPGA Security Manager class driver to
include an update/status sysfs node that can be polled
and read to monitor the progress of an ongoing secure
update. Sysfs_notify() is used to signal transitions
between different phases of the update process.

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Reviewed-by: Tom Rix <trix@redhat.com>
Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
 .../ABI/testing/sysfs-class-fpga-sec-mgr      | 11 +++++
 drivers/fpga/fpga-sec-mgr.c                   | 42 +++++++++++++++++--
 2 files changed, 49 insertions(+), 4 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-fpga-sec-mgr b/Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
index 36d1b6ba8d76..b962ad2cf18d 100644
--- a/Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
+++ b/Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
@@ -16,3 +16,14 @@ Description:	Write only. Write the filename of an image
 		BMC images, BMC firmware, Static Region images,
 		and Root Entry Hashes, and to cancel Code Signing
 		Keys (CSK).
+
+What: 		/sys/class/fpga_sec_mgr/fpga_secX/update/status
+Date:		June 2021
+KernelVersion:	5.14
+Contact:	Russ Weight <russell.h.weight@intel.com>
+Description:	Read-only. Returns a string describing the current
+		status of an update. The string will be one of the
+		following: idle, reading, preparing, writing,
+		programming. Userspace code can poll on this file,
+		as it will be signaled by sysfs_notify() on each
+		state change.
diff --git a/drivers/fpga/fpga-sec-mgr.c b/drivers/fpga/fpga-sec-mgr.c
index bfdb01d2de57..19f60048a965 100644
--- a/drivers/fpga/fpga-sec-mgr.c
+++ b/drivers/fpga/fpga-sec-mgr.c
@@ -23,6 +23,13 @@ struct fpga_sec_mgr_devres {
 
 #define to_sec_mgr(d) container_of(d, struct fpga_sec_mgr, dev)
 
+static void update_progress(struct fpga_sec_mgr *smgr,
+			    enum fpga_sec_prog new_progress)
+{
+	smgr->progress = new_progress;
+	sysfs_notify(&smgr->dev.kobj, "update", "status");
+}
+
 static void fpga_sec_dev_error(struct fpga_sec_mgr *smgr,
 			       enum fpga_sec_err err_code)
 {
@@ -33,7 +40,7 @@ static void fpga_sec_dev_error(struct fpga_sec_mgr *smgr,
 static void progress_complete(struct fpga_sec_mgr *smgr)
 {
 	mutex_lock(&smgr->lock);
-	smgr->progress = FPGA_SEC_PROG_IDLE;
+	update_progress(smgr, FPGA_SEC_PROG_IDLE);
 	complete_all(&smgr->update_done);
 	mutex_unlock(&smgr->lock);
 }
@@ -61,14 +68,14 @@ static void fpga_sec_mgr_update(struct work_struct *work)
 		goto release_fw_exit;
 	}
 
-	smgr->progress = FPGA_SEC_PROG_PREPARING;
+	update_progress(smgr, FPGA_SEC_PROG_PREPARING);
 	ret = smgr->sops->prepare(smgr);
 	if (ret != FPGA_SEC_ERR_NONE) {
 		fpga_sec_dev_error(smgr, ret);
 		goto modput_exit;
 	}
 
-	smgr->progress = FPGA_SEC_PROG_WRITING;
+	update_progress(smgr, FPGA_SEC_PROG_WRITING);
 	while (smgr->remaining_size) {
 		ret = smgr->sops->write_blk(smgr, offset);
 		if (ret != FPGA_SEC_ERR_NONE) {
@@ -79,7 +86,7 @@ static void fpga_sec_mgr_update(struct work_struct *work)
 		offset = fw->size - smgr->remaining_size;
 	}
 
-	smgr->progress = FPGA_SEC_PROG_PROGRAMMING;
+	update_progress(smgr, FPGA_SEC_PROG_PROGRAMMING);
 	ret = smgr->sops->poll_complete(smgr);
 	if (ret != FPGA_SEC_ERR_NONE)
 		fpga_sec_dev_error(smgr, ret);
@@ -107,6 +114,32 @@ static void fpga_sec_mgr_update(struct work_struct *work)
 	progress_complete(smgr);
 }
 
+static const char * const sec_mgr_prog_str[] = {
+	[FPGA_SEC_PROG_IDLE]	    = "idle",
+	[FPGA_SEC_PROG_READING]	    = "reading",
+	[FPGA_SEC_PROG_PREPARING]   = "preparing",
+	[FPGA_SEC_PROG_WRITING]	    = "writing",
+	[FPGA_SEC_PROG_PROGRAMMING] = "programming"
+};
+
+static ssize_t
+status_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct fpga_sec_mgr *smgr = to_sec_mgr(dev);
+	const char *status = "unknown-status";
+	enum fpga_sec_prog progress;
+
+	progress = smgr->progress;
+	if (progress < FPGA_SEC_PROG_MAX)
+		status = sec_mgr_prog_str[progress];
+	else
+		dev_err(dev, "Invalid status during secure update: %d\n",
+			progress);
+
+	return sysfs_emit(buf, "%s\n", status);
+}
+static DEVICE_ATTR_RO(status);
+
 static ssize_t filename_store(struct device *dev, struct device_attribute *attr,
 			      const char *buf, size_t count)
 {
@@ -141,6 +174,7 @@ static DEVICE_ATTR_WO(filename);
 
 static struct attribute *sec_mgr_update_attrs[] = {
 	&dev_attr_filename.attr,
+	&dev_attr_status.attr,
 	NULL,
 };
 
-- 
2.31.1


Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE13F3822C8
	for <lists+linux-fpga@lfdr.de>; Mon, 17 May 2021 04:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbhEQCeM (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 16 May 2021 22:34:12 -0400
Received: from mail-pf1-f174.google.com ([209.85.210.174]:43952 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbhEQCeJ (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 16 May 2021 22:34:09 -0400
Received: by mail-pf1-f174.google.com with SMTP id d78so3080400pfd.10
        for <linux-fpga@vger.kernel.org>; Sun, 16 May 2021 19:32:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mIuyThC8N8Vs45tWKR2XaYfdwdhs1NWGJ6K0ZJ36n20=;
        b=JP1aAEcAQX842C82FEn6j4Am2SSwbTWVjOVhRDXI11bV26sPJhOLYux6p7QlTJdmta
         dFNY6+uvYwaeNJMayNdvDkN55TWGUxzQj5uidb5r7izu1oPHqli8OeyOOnUwp8YLF67b
         /TIEr4j+jqyFhrZ+M87xmtSewl80Pplrq8iq+imYO8fQa+DJv4CVpYWpSpm3PHMAORmy
         03QqFJqvw83sDvOTY+/DoUZI43k/mMn+hmp3WHsfKVykG3+SejSPhBhlkPV77VCn9iuo
         zPB0lTxVSvbPvNhpmZJmQsHQFj8xNfppPXQuGSaKL0pNnvTyVuDiN3UPImk2DcY+CSyp
         Zb6A==
X-Gm-Message-State: AOAM533NuKDASmxBZH+kldlCbcL96JbtBtr6BoZ3Qt8H67PqNg35MO29
        YNltJJWAK8FhBmRIZ0i8rL8=
X-Google-Smtp-Source: ABdhPJzlcFmRO8+EzxYq2eb6Qfc2AVu7uw9AGVlHZL8BpL9JUdS7WlSQh5DMOQMOwiX4Mfhoh/ox0A==
X-Received: by 2002:a63:581c:: with SMTP id m28mr22453421pgb.353.1621218774250;
        Sun, 16 May 2021 19:32:54 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id x27sm9050892pfo.216.2021.05.16.19.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 May 2021 19:32:53 -0700 (PDT)
From:   Moritz Fischer <mdf@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-fpga@vger.kernel.org, moritzf@google.com,
        Moritz Fischer <mdf@kernel.org>,
        Russ Weight <russell.h.weight@intel.com>,
        Tom Rix <trix@redhat.com>
Subject: [PATCH 06/12] fpga: sec-mgr: enable cancel of secure update
Date:   Sun, 16 May 2021 19:31:54 -0700
Message-Id: <20210517023200.52707-7-mdf@kernel.org>
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
an update/cancel sysfs file that can be written to request
that an update be canceled. The write may return EBUSY if
the update has progressed to the point that it cannot be
canceled by software or ENODEV if there is no update in
progress.

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Reviewed-by: Tom Rix <trix@redhat.com>
Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
 .../ABI/testing/sysfs-class-fpga-sec-mgr      | 10 ++++
 drivers/fpga/fpga-sec-mgr.c                   | 59 +++++++++++++++++--
 include/linux/fpga/fpga-sec-mgr.h             |  1 +
 3 files changed, 66 insertions(+), 4 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-fpga-sec-mgr b/Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
index c5d0b9d7c7e4..749f2d4c78d3 100644
--- a/Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
+++ b/Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
@@ -17,6 +17,16 @@ Description:	Write only. Write the filename of an image
 		and Root Entry Hashes, and to cancel Code Signing
 		Keys (CSK).
 
+What: 		/sys/class/fpga_sec_mgr/fpga_secX/update/cancel
+Date:		June 2021
+KernelVersion:	5.14
+Contact:	Russ Weight <russell.h.weight@intel.com>
+Description:	Write-only. Write a "1" to this file to request
+		that a current update be canceled. This request
+		will be rejected (EBUSY) if the programming phase
+		has already started or (ENODEV) if there is no
+		update in progress.
+
 What: 		/sys/class/fpga_sec_mgr/fpga_secX/update/status
 Date:		June 2021
 KernelVersion:	5.14
diff --git a/drivers/fpga/fpga-sec-mgr.c b/drivers/fpga/fpga-sec-mgr.c
index bc6b35cc7237..48950843c2b4 100644
--- a/drivers/fpga/fpga-sec-mgr.c
+++ b/drivers/fpga/fpga-sec-mgr.c
@@ -43,6 +43,23 @@ static void fpga_sec_dev_error(struct fpga_sec_mgr *smgr,
 	smgr->sops->cancel(smgr);
 }
 
+static int progress_transition(struct fpga_sec_mgr *smgr,
+			       enum fpga_sec_prog new_progress)
+{
+	int ret = 0;
+
+	mutex_lock(&smgr->lock);
+	if (smgr->request_cancel) {
+		fpga_sec_set_error(smgr, FPGA_SEC_ERR_CANCELED);
+		smgr->sops->cancel(smgr);
+		ret = -ECANCELED;
+	} else {
+		update_progress(smgr, new_progress);
+	}
+	mutex_unlock(&smgr->lock);
+	return ret;
+}
+
 static void progress_complete(struct fpga_sec_mgr *smgr)
 {
 	mutex_lock(&smgr->lock);
@@ -74,15 +91,19 @@ static void fpga_sec_mgr_update(struct work_struct *work)
 		goto release_fw_exit;
 	}
 
-	update_progress(smgr, FPGA_SEC_PROG_PREPARING);
+	if (progress_transition(smgr, FPGA_SEC_PROG_PREPARING))
+		goto modput_exit;
+
 	ret = smgr->sops->prepare(smgr);
 	if (ret != FPGA_SEC_ERR_NONE) {
 		fpga_sec_dev_error(smgr, ret);
 		goto modput_exit;
 	}
 
-	update_progress(smgr, FPGA_SEC_PROG_WRITING);
-	while (smgr->remaining_size) {
+	if (progress_transition(smgr, FPGA_SEC_PROG_WRITING))
+		goto done;
+
+	while (smgr->remaining_size && !smgr->request_cancel) {
 		ret = smgr->sops->write_blk(smgr, offset);
 		if (ret != FPGA_SEC_ERR_NONE) {
 			fpga_sec_dev_error(smgr, ret);
@@ -92,7 +113,9 @@ static void fpga_sec_mgr_update(struct work_struct *work)
 		offset = fw->size - smgr->remaining_size;
 	}
 
-	update_progress(smgr, FPGA_SEC_PROG_PROGRAMMING);
+	if (progress_transition(smgr, FPGA_SEC_PROG_PROGRAMMING))
+		goto done;
+
 	ret = smgr->sops->poll_complete(smgr);
 	if (ret != FPGA_SEC_ERR_NONE)
 		fpga_sec_dev_error(smgr, ret);
@@ -229,6 +252,7 @@ static ssize_t filename_store(struct device *dev, struct device_attribute *attr,
 	}
 
 	smgr->err_code = FPGA_SEC_ERR_NONE;
+	smgr->request_cancel = false;
 	smgr->progress = FPGA_SEC_PROG_READING;
 	reinit_completion(&smgr->update_done);
 	schedule_work(&smgr->work);
@@ -239,8 +263,32 @@ static ssize_t filename_store(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_WO(filename);
 
+static ssize_t cancel_store(struct device *dev, struct device_attribute *attr,
+			    const char *buf, size_t count)
+{
+	struct fpga_sec_mgr *smgr = to_sec_mgr(dev);
+	bool cancel;
+	int ret = count;
+
+	if (kstrtobool(buf, &cancel) || !cancel)
+		return -EINVAL;
+
+	mutex_lock(&smgr->lock);
+	if (smgr->progress == FPGA_SEC_PROG_PROGRAMMING)
+		ret = -EBUSY;
+	else if (smgr->progress == FPGA_SEC_PROG_IDLE)
+		ret = -ENODEV;
+	else
+		smgr->request_cancel = true;
+	mutex_unlock(&smgr->lock);
+
+	return ret;
+}
+static DEVICE_ATTR_WO(cancel);
+
 static struct attribute *sec_mgr_update_attrs[] = {
 	&dev_attr_filename.attr,
+	&dev_attr_cancel.attr,
 	&dev_attr_status.attr,
 	&dev_attr_error.attr,
 	&dev_attr_remaining_size.attr,
@@ -464,6 +512,9 @@ void fpga_sec_mgr_unregister(struct fpga_sec_mgr *smgr)
 		goto unregister;
 	}
 
+	if (smgr->progress != FPGA_SEC_PROG_PROGRAMMING)
+		smgr->request_cancel = true;
+
 	mutex_unlock(&smgr->lock);
 	wait_for_completion(&smgr->update_done);
 
diff --git a/include/linux/fpga/fpga-sec-mgr.h b/include/linux/fpga/fpga-sec-mgr.h
index 6b7b8a3d6aac..0e1f50434024 100644
--- a/include/linux/fpga/fpga-sec-mgr.h
+++ b/include/linux/fpga/fpga-sec-mgr.h
@@ -72,6 +72,7 @@ struct fpga_sec_mgr {
 	enum fpga_sec_prog progress;
 	enum fpga_sec_prog err_state;	/* progress state at time of failure */
 	enum fpga_sec_err err_code;	/* security manager error code */
+	bool request_cancel;
 	bool driver_unload;
 	void *priv;
 };
-- 
2.31.1


Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 642D82CE063
	for <lists+linux-fpga@lfdr.de>; Thu,  3 Dec 2020 22:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729435AbgLCVLi (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 3 Dec 2020 16:11:38 -0500
Received: from mga11.intel.com ([192.55.52.93]:57329 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729580AbgLCVLi (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 3 Dec 2020 16:11:38 -0500
IronPort-SDR: OdJ1pvRxSxzDe4O8tWzDeuUGFL4GBgyPzMVwLvV/IeYSA8A5Vw+BRb7MJeZ56hWmYhJoLfD983
 J4jNUabchuww==
X-IronPort-AV: E=McAfee;i="6000,8403,9824"; a="169773022"
X-IronPort-AV: E=Sophos;i="5.78,390,1599548400"; 
   d="scan'208";a="169773022"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2020 13:10:04 -0800
IronPort-SDR: G1qOdG3IsmV6z83zVZCnKl2Dg75n2rU/8m33xvkjJKqjujT5N8w5488bl0R36fvpnK1L7Jg8h+
 qh0JxHmTBSYA==
X-IronPort-AV: E=Sophos;i="5.78,390,1599548400"; 
   d="scan'208";a="330971745"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO rhweight-mobl2.ra.intel.com) ([10.251.23.110])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2020 13:10:03 -0800
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v7 6/7] fpga: sec-mgr: enable cancel of secure update
Date:   Thu,  3 Dec 2020 13:09:57 -0800
Message-Id: <20201203210958.241329-7-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201203210958.241329-1-russell.h.weight@intel.com>
References: <20201203210958.241329-1-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Extend the FPGA Security Manager class driver to include
an update/cancel sysfs file that can be written to request
that an update be canceled. The write may return EBUSY if
the update has progressed to the point that it cannot be
canceled by software or ENODEV if there is no update in
progress.

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Reviewed-by: Tom Rix <trix@redhat.com>
---
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
 .../ABI/testing/sysfs-class-fpga-sec-mgr      | 10 ++++
 drivers/fpga/fpga-sec-mgr.c                   | 59 +++++++++++++++++--
 include/linux/fpga/fpga-sec-mgr.h             |  1 +
 3 files changed, 66 insertions(+), 4 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-fpga-sec-mgr b/Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
index 62dc04e4335d..96694f229aff 100644
--- a/Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
+++ b/Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
@@ -17,6 +17,16 @@ Description:	Write only. Write the filename of an image
 		and Root Entry Hashes, and to cancel Code Signing
 		Keys (CSK).
 
+What: 		/sys/class/fpga_sec_mgr/fpga_secX/update/cancel
+Date:		December 2020
+KernelVersion:  5.11
+Contact:	Russ Weight <russell.h.weight@intel.com>
+Description:	Write-only. Write a "1" to this file to request
+		that a current update be canceled. This request
+		will be rejected (EBUSY) if the programming phase
+		has already started or (ENODEV) if there is no
+		update in progress.
+
 What: 		/sys/class/fpga_sec_mgr/fpga_secX/update/status
 Date:		December 2020
 KernelVersion:  5.11
diff --git a/drivers/fpga/fpga-sec-mgr.c b/drivers/fpga/fpga-sec-mgr.c
index 951020942991..d354fe2ab582 100644
--- a/drivers/fpga/fpga-sec-mgr.c
+++ b/drivers/fpga/fpga-sec-mgr.c
@@ -45,6 +45,23 @@ static void fpga_sec_dev_error(struct fpga_sec_mgr *smgr,
 	smgr->sops->cancel(smgr);
 }
 
+static int progress_transition(struct fpga_sec_mgr *smgr,
+			       enum fpga_sec_prog new_progress)
+{
+	int ret = 0;
+
+	mutex_lock(&smgr->lock);
+	if (smgr->request_cancel) {
+		set_error(smgr, FPGA_SEC_ERR_CANCELED);
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
@@ -76,16 +93,20 @@ static void fpga_sec_mgr_update(struct work_struct *work)
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
+	if (progress_transition(smgr, FPGA_SEC_PROG_WRITING))
+		goto done;
+
 	size = smgr->remaining_size;
-	while (size) {
+	while (size && !smgr->request_cancel) {
 		blk_size = min_t(u32, size, WRITE_BLOCK_SIZE);
 		size -= blk_size;
 		ret = smgr->sops->write_blk(smgr, offset, blk_size);
@@ -98,7 +119,9 @@ static void fpga_sec_mgr_update(struct work_struct *work)
 		offset += blk_size;
 	}
 
-	update_progress(smgr, FPGA_SEC_PROG_PROGRAMMING);
+	if (progress_transition(smgr, FPGA_SEC_PROG_PROGRAMMING))
+		goto done;
+
 	ret = smgr->sops->poll_complete(smgr);
 	if (ret != FPGA_SEC_ERR_NONE)
 		fpga_sec_dev_error(smgr, ret);
@@ -235,6 +258,7 @@ static ssize_t filename_store(struct device *dev, struct device_attribute *attr,
 	}
 
 	smgr->err_code = FPGA_SEC_ERR_NONE;
+	smgr->request_cancel = false;
 	smgr->progress = FPGA_SEC_PROG_READING;
 	reinit_completion(&smgr->update_done);
 	schedule_work(&smgr->work);
@@ -245,8 +269,32 @@ static ssize_t filename_store(struct device *dev, struct device_attribute *attr,
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
@@ -468,6 +516,9 @@ void fpga_sec_mgr_unregister(struct fpga_sec_mgr *smgr)
 		goto unregister;
 	}
 
+	if (smgr->progress != FPGA_SEC_PROG_PROGRAMMING)
+		smgr->request_cancel = true;
+
 	mutex_unlock(&smgr->lock);
 	wait_for_completion(&smgr->update_done);
 
diff --git a/include/linux/fpga/fpga-sec-mgr.h b/include/linux/fpga/fpga-sec-mgr.h
index 78f8dc51a508..e63e6437f394 100644
--- a/include/linux/fpga/fpga-sec-mgr.h
+++ b/include/linux/fpga/fpga-sec-mgr.h
@@ -73,6 +73,7 @@ struct fpga_sec_mgr {
 	enum fpga_sec_prog progress;
 	enum fpga_sec_prog err_state;	/* progress state at time of failure */
 	enum fpga_sec_err err_code;	/* security manager error code */
+	bool request_cancel;
 	bool driver_unload;
 	void *priv;
 };
-- 
2.25.1


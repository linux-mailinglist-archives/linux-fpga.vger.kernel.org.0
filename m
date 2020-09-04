Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D42FC25E452
	for <lists+linux-fpga@lfdr.de>; Sat,  5 Sep 2020 01:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbgIDXx3 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 4 Sep 2020 19:53:29 -0400
Received: from mga06.intel.com ([134.134.136.31]:64693 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728197AbgIDXxY (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 4 Sep 2020 19:53:24 -0400
IronPort-SDR: D330fQ94ovp7BUPR+pLzR3n/rc+OS5KGYLURUeemmAmRwwT4i/OLLu3f3P2WyFqLa9qVTv1O7N
 wryHb6lKpupw==
X-IronPort-AV: E=McAfee;i="6000,8403,9734"; a="219386215"
X-IronPort-AV: E=Sophos;i="5.76,391,1592895600"; 
   d="scan'208";a="219386215"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2020 16:53:19 -0700
IronPort-SDR: WLbPsB2SjpX7rtkaXev1/3oqiLUThGZrGNA2osd6bG/2LvHss3+AzGUdjXLAnTmqgqpdO/cBae
 W6Zx07x+aDCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,391,1592895600"; 
   d="scan'208";a="284656510"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO rhweight-mobl2.ra.intel.com) ([10.251.151.80])
  by fmsmga008.fm.intel.com with ESMTP; 04 Sep 2020 16:53:19 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, lee.jones@linaro.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v1 10/12] fpga: enable sec-mgr update cancel
Date:   Fri,  4 Sep 2020 16:53:03 -0700
Message-Id: <20200904235305.6254-11-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200904235305.6254-1-russell.h.weight@intel.com>
References: <20200904235305.6254-1-russell.h.weight@intel.com>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Extend the Intel Security Manager class driver to include
an update/cancel sysfs file that can be written to request
that an update be canceled. The write may return EBUSY if
the update has progressed to the point that it cannot be
canceled by software or ENODEV if there is no update in
progress.

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
---
 .../ABI/testing/sysfs-class-ifpga-sec-mgr     | 10 ++++
 drivers/fpga/ifpga-sec-mgr.c                  | 59 +++++++++++++++++--
 include/linux/fpga/ifpga-sec-mgr.h            |  1 +
 3 files changed, 66 insertions(+), 4 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr b/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
index cf1967f1b3e3..762a7dee9453 100644
--- a/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
+++ b/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
@@ -87,6 +87,16 @@ Description:	Write only. Write the filename of an Intel image
 		and Root Entry Hashes, and to cancel Code Signing
 		Keys (CSK).
 
+What: 		/sys/class/ifpga_sec_mgr/ifpga_secX/update/cancel
+Date:		Sep 2020
+KernelVersion:  5.10
+Contact:	Russ Weight <russell.h.weight@intel.com>
+Description:	Write-only. Write a "1" to this file to request
+		that a current update be canceled. This request
+		will be rejected (EBUSY) if the programming phase
+		has already started or (ENODEV) if there is no
+		update in progress.
+
 What: 		/sys/class/ifpga_sec_mgr/ifpga_secX/update/status
 Date:		Sep 2020
 KernelVersion:  5.10
diff --git a/drivers/fpga/ifpga-sec-mgr.c b/drivers/fpga/ifpga-sec-mgr.c
index 4ca5d13e5656..afd97c135ebe 100644
--- a/drivers/fpga/ifpga-sec-mgr.c
+++ b/drivers/fpga/ifpga-sec-mgr.c
@@ -159,6 +159,23 @@ static void ifpga_sec_dev_error(struct ifpga_sec_mgr *imgr,
 	imgr->iops->cancel(imgr);
 }
 
+static int progress_transition(struct ifpga_sec_mgr *imgr,
+			       enum ifpga_sec_prog new_progress)
+{
+	int ret = 0;
+
+	mutex_lock(&imgr->lock);
+	if (imgr->request_cancel) {
+		set_error(imgr, IFPGA_SEC_ERR_CANCELED);
+		imgr->iops->cancel(imgr);
+		ret = -ECANCELED;
+	} else {
+		update_progress(imgr, new_progress);
+	}
+	mutex_unlock(&imgr->lock);
+	return ret;
+}
+
 static void progress_complete(struct ifpga_sec_mgr *imgr)
 {
 	mutex_lock(&imgr->lock);
@@ -190,16 +207,20 @@ static void ifpga_sec_mgr_update(struct work_struct *work)
 		goto release_fw_exit;
 	}
 
-	update_progress(imgr, IFPGA_SEC_PROG_PREPARING);
+	if (progress_transition(imgr, IFPGA_SEC_PROG_PREPARING))
+		goto modput_exit;
+
 	ret = imgr->iops->prepare(imgr);
 	if (ret) {
 		ifpga_sec_dev_error(imgr, ret);
 		goto modput_exit;
 	}
 
-	update_progress(imgr, IFPGA_SEC_PROG_WRITING);
+	if (progress_transition(imgr, IFPGA_SEC_PROG_WRITING))
+		goto done;
+
 	size = imgr->remaining_size;
-	while (size) {
+	while (size && !imgr->request_cancel) {
 		blk_size = min_t(u32, size, WRITE_BLOCK_SIZE);
 		size -= blk_size;
 		ret = imgr->iops->write_blk(imgr, offset, blk_size);
@@ -212,7 +233,9 @@ static void ifpga_sec_mgr_update(struct work_struct *work)
 		offset += blk_size;
 	}
 
-	update_progress(imgr, IFPGA_SEC_PROG_PROGRAMMING);
+	if (progress_transition(imgr, IFPGA_SEC_PROG_PROGRAMMING))
+		goto done;
+
 	ret = imgr->iops->poll_complete(imgr);
 	if (ret) {
 		ifpga_sec_dev_error(imgr, ret);
@@ -359,6 +382,7 @@ static ssize_t filename_store(struct device *dev, struct device_attribute *attr,
 		imgr->filename[strlen(imgr->filename) - 1] = '\0';
 
 	imgr->err_code = IFPGA_SEC_ERR_NONE;
+	imgr->request_cancel = false;
 	imgr->progress = IFPGA_SEC_PROG_READ_FILE;
 	reinit_completion(&imgr->update_done);
 	schedule_work(&imgr->work);
@@ -369,8 +393,32 @@ static ssize_t filename_store(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_WO(filename);
 
+static ssize_t cancel_store(struct device *dev, struct device_attribute *attr,
+			    const char *buf, size_t count)
+{
+	struct ifpga_sec_mgr *imgr = to_sec_mgr(dev);
+	bool cancel;
+	int ret = 0;
+
+	if (kstrtobool(buf, &cancel) || !cancel)
+		return -EINVAL;
+
+	mutex_lock(&imgr->lock);
+	if (imgr->progress == IFPGA_SEC_PROG_PROGRAMMING)
+		ret = -EBUSY;
+	else if (imgr->progress == IFPGA_SEC_PROG_IDLE)
+		ret = -ENODEV;
+	else
+		imgr->request_cancel = true;
+	mutex_unlock(&imgr->lock);
+
+	return ret ? : count;
+}
+static DEVICE_ATTR_WO(cancel);
+
 static struct attribute *sec_mgr_update_attrs[] = {
 	&dev_attr_filename.attr,
+	&dev_attr_cancel.attr,
 	&dev_attr_status.attr,
 	&dev_attr_error.attr,
 	&dev_attr_remaining_size.attr,
@@ -536,6 +584,9 @@ void ifpga_sec_mgr_unregister(struct ifpga_sec_mgr *imgr)
 		goto unregister;
 	}
 
+	if (imgr->progress != IFPGA_SEC_PROG_PROGRAMMING)
+		imgr->request_cancel = true;
+
 	mutex_unlock(&imgr->lock);
 	wait_for_completion(&imgr->update_done);
 
diff --git a/include/linux/fpga/ifpga-sec-mgr.h b/include/linux/fpga/ifpga-sec-mgr.h
index f04bf9e30c67..f51ed663a723 100644
--- a/include/linux/fpga/ifpga-sec-mgr.h
+++ b/include/linux/fpga/ifpga-sec-mgr.h
@@ -183,6 +183,7 @@ struct ifpga_sec_mgr {
 	enum ifpga_sec_prog progress;
 	enum ifpga_sec_prog err_state;	/* progress state at time of failure */
 	enum ifpga_sec_err err_code;	/* security manager error code */
+	bool request_cancel;
 	bool driver_unload;
 	void *priv;
 };
-- 
2.17.1


Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE31D285535
	for <lists+linux-fpga@lfdr.de>; Wed,  7 Oct 2020 02:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbgJGAKu (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 6 Oct 2020 20:10:50 -0400
Received: from mga04.intel.com ([192.55.52.120]:3659 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726861AbgJGAKg (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 6 Oct 2020 20:10:36 -0400
IronPort-SDR: 1RkHMKj6BnhxQsihkQ59Q1mh9Ryou6LVIzFnJaahSYH0LWdoKAFTrYPkSLsxZnGdBHYHG94WD2
 CkqCB30G3mlA==
X-IronPort-AV: E=McAfee;i="6000,8403,9766"; a="162139588"
X-IronPort-AV: E=Sophos;i="5.77,344,1596524400"; 
   d="scan'208";a="162139588"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2020 17:10:35 -0700
IronPort-SDR: jNksh7tpK3n+ynRFBe9hUBV54sIm0ldKy+NtcFAShtcXG0Otd+PQ8+F313sRK6Rvrgd48/6sCh
 T3a4c1mzzS1Q==
X-IronPort-AV: E=Sophos;i="5.77,344,1596524400"; 
   d="scan'208";a="297380477"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO rhweight-mobl2.ra.intel.com) ([10.212.2.223])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2020 17:10:34 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v3 6/7] fpga: sec-mgr: enable cancel of secure update
Date:   Tue,  6 Oct 2020 17:10:03 -0700
Message-Id: <20201007001004.23790-7-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201007001004.23790-1-russell.h.weight@intel.com>
References: <20201007001004.23790-1-russell.h.weight@intel.com>
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
Reviewed-by: Tom Rix <trix@redhat.com>
---
v3:
  - No change
v2:
  - Bumped documentation date and version
  - Minor code cleanup per review comments 
---
 .../ABI/testing/sysfs-class-ifpga-sec-mgr     | 10 ++++
 drivers/fpga/ifpga-sec-mgr.c                  | 59 +++++++++++++++++--
 include/linux/fpga/ifpga-sec-mgr.h            |  1 +
 3 files changed, 66 insertions(+), 4 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr b/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
index ec51135fcb6a..caafe7eb7670 100644
--- a/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
+++ b/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
@@ -79,6 +79,16 @@ Description:	Write only. Write the filename of an Intel image
 		and Root Entry Hashes, and to cancel Code Signing
 		Keys (CSK).
 
+What: 		/sys/class/ifpga_sec_mgr/ifpga_secX/update/cancel
+Date:		Oct 2020
+KernelVersion:  5.11
+Contact:	Russ Weight <russell.h.weight@intel.com>
+Description:	Write-only. Write a "1" to this file to request
+		that a current update be canceled. This request
+		will be rejected (EBUSY) if the programming phase
+		has already started or (ENODEV) if there is no
+		update in progress.
+
 What: 		/sys/class/ifpga_sec_mgr/ifpga_secX/update/status
 Date:		Oct 2020
 KernelVersion:  5.11
diff --git a/drivers/fpga/ifpga-sec-mgr.c b/drivers/fpga/ifpga-sec-mgr.c
index d4fa5d60fa02..23914ef87f2d 100644
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
 	if (ret)
 		ifpga_sec_dev_error(imgr, ret);
@@ -379,6 +402,7 @@ static ssize_t filename_store(struct device *dev, struct device_attribute *attr,
 	}
 
 	imgr->err_code = IFPGA_SEC_ERR_NONE;
+	imgr->request_cancel = false;
 	imgr->progress = IFPGA_SEC_PROG_READING;
 	reinit_completion(&imgr->update_done);
 	schedule_work(&imgr->work);
@@ -389,8 +413,32 @@ static ssize_t filename_store(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_WO(filename);
 
+static ssize_t cancel_store(struct device *dev, struct device_attribute *attr,
+			    const char *buf, size_t count)
+{
+	struct ifpga_sec_mgr *imgr = to_sec_mgr(dev);
+	bool cancel;
+	int ret = count;
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
@@ -658,6 +706,9 @@ void ifpga_sec_mgr_unregister(struct ifpga_sec_mgr *imgr)
 		goto unregister;
 	}
 
+	if (imgr->progress != IFPGA_SEC_PROG_PROGRAMMING)
+		imgr->request_cancel = true;
+
 	mutex_unlock(&imgr->lock);
 	wait_for_completion(&imgr->update_done);
 
diff --git a/include/linux/fpga/ifpga-sec-mgr.h b/include/linux/fpga/ifpga-sec-mgr.h
index 246e3d452c59..890be0800b05 100644
--- a/include/linux/fpga/ifpga-sec-mgr.h
+++ b/include/linux/fpga/ifpga-sec-mgr.h
@@ -112,6 +112,7 @@ struct ifpga_sec_mgr {
 	enum ifpga_sec_prog progress;
 	enum ifpga_sec_prog err_state;	/* progress state at time of failure */
 	enum ifpga_sec_err err_code;	/* security manager error code */
+	bool request_cancel;
 	bool driver_unload;
 	void *priv;
 };
-- 
2.17.1


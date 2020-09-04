Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09EAF25E45D
	for <lists+linux-fpga@lfdr.de>; Sat,  5 Sep 2020 01:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728323AbgIDXxx (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 4 Sep 2020 19:53:53 -0400
Received: from mga06.intel.com ([134.134.136.31]:64696 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727986AbgIDXxW (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 4 Sep 2020 19:53:22 -0400
IronPort-SDR: 1YX5vJfTKfFfiqrzel1W/JioLSrHhlJx80LzFe5u7pgZ4i4gxpg/DXFwLuK4Y1Eiu6Bh2qqeE4
 BzuEZ13RkQCg==
X-IronPort-AV: E=McAfee;i="6000,8403,9734"; a="219386204"
X-IronPort-AV: E=Sophos;i="5.76,391,1592895600"; 
   d="scan'208";a="219386204"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2020 16:53:18 -0700
IronPort-SDR: 8e6BVrpMDBtTw+YGicNcmBo8lnTKNNODJYoY1X9YATr8Exb0YVbuHJggiwA1bjWLsXrFBeWrzE
 RCJ4r4ouHI3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,391,1592895600"; 
   d="scan'208";a="284656352"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO rhweight-mobl2.ra.intel.com) ([10.251.151.80])
  by fmsmga008.fm.intel.com with ESMTP; 04 Sep 2020 16:53:17 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, lee.jones@linaro.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v1 07/12] fpga: expose sec-mgr update status
Date:   Fri,  4 Sep 2020 16:53:00 -0700
Message-Id: <20200904235305.6254-8-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200904235305.6254-1-russell.h.weight@intel.com>
References: <20200904235305.6254-1-russell.h.weight@intel.com>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Extend the Intel Security Manager class driver to
include an update/status sysfs node that can be polled
and read to monitor the progress of an ongoing secure
update. Sysfs_notify() is used to signal transitions
between different phases of the update process.

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Reviewed-by: Wu Hao <hao.wu@intel.com>
---
 .../ABI/testing/sysfs-class-ifpga-sec-mgr     | 11 ++++++
 drivers/fpga/ifpga-sec-mgr.c                  | 34 ++++++++++++++++---
 2 files changed, 41 insertions(+), 4 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr b/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
index a476504b7ae9..849ccb2802f8 100644
--- a/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
+++ b/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
@@ -86,3 +86,14 @@ Description:	Write only. Write the filename of an Intel image
 		BMC images, BMC firmware, Static Region images,
 		and Root Entry Hashes, and to cancel Code Signing
 		Keys (CSK).
+
+What: 		/sys/class/ifpga_sec_mgr/ifpga_secX/update/status
+Date:		Sep 2020
+KernelVersion:  5.10
+Contact:	Russ Weight <russell.h.weight@intel.com>
+Description:	Read-only. Returns a string describing the current
+		status of an update. The string will be one of the
+		following: idle, read_file, preparing, writing,
+		programming. Userspace code can poll on this file,
+		as it will be signaled by sysfs_notify() on each
+		state change.
diff --git a/drivers/fpga/ifpga-sec-mgr.c b/drivers/fpga/ifpga-sec-mgr.c
index 73173badbe96..5fe3d85e2963 100644
--- a/drivers/fpga/ifpga-sec-mgr.c
+++ b/drivers/fpga/ifpga-sec-mgr.c
@@ -139,6 +139,13 @@ static struct attribute *sec_mgr_security_attrs[] = {
 	NULL,
 };
 
+static void update_progress(struct ifpga_sec_mgr *imgr,
+			    enum ifpga_sec_prog new_progress)
+{
+	imgr->progress = new_progress;
+	sysfs_notify(&imgr->dev.kobj, "update", "status");
+}
+
 static void ifpga_sec_dev_error(struct ifpga_sec_mgr *imgr,
 				enum ifpga_sec_err err_code)
 {
@@ -149,7 +156,7 @@ static void ifpga_sec_dev_error(struct ifpga_sec_mgr *imgr,
 static void progress_complete(struct ifpga_sec_mgr *imgr)
 {
 	mutex_lock(&imgr->lock);
-	imgr->progress = IFPGA_SEC_PROG_IDLE;
+	update_progress(imgr, IFPGA_SEC_PROG_IDLE);
 	complete_all(&imgr->update_done);
 	mutex_unlock(&imgr->lock);
 }
@@ -177,14 +184,14 @@ static void ifpga_sec_mgr_update(struct work_struct *work)
 		goto release_fw_exit;
 	}
 
-	imgr->progress = IFPGA_SEC_PROG_PREPARING;
+	update_progress(imgr, IFPGA_SEC_PROG_PREPARING);
 	ret = imgr->iops->prepare(imgr);
 	if (ret) {
 		ifpga_sec_dev_error(imgr, ret);
 		goto modput_exit;
 	}
 
-	imgr->progress = IFPGA_SEC_PROG_WRITING;
+	update_progress(imgr, IFPGA_SEC_PROG_WRITING);
 	size = imgr->remaining_size;
 	while (size) {
 		blk_size = min_t(u32, size, WRITE_BLOCK_SIZE);
@@ -199,7 +206,7 @@ static void ifpga_sec_mgr_update(struct work_struct *work)
 		offset += blk_size;
 	}
 
-	imgr->progress = IFPGA_SEC_PROG_PROGRAMMING;
+	update_progress(imgr, IFPGA_SEC_PROG_PROGRAMMING);
 	ret = imgr->iops->poll_complete(imgr);
 	if (ret) {
 		ifpga_sec_dev_error(imgr, ret);
@@ -251,6 +258,24 @@ static struct attribute_group sec_mgr_security_attr_group = {
 	.is_visible = sec_mgr_visible,
 };
 
+static const char * const sec_mgr_prog_str[] = {
+	"idle",			/* IFPGA_SEC_PROG_IDLE */
+	"read_file",		/* IFPGA_SEC_PROG_READ_FILE */
+	"preparing",		/* IFPGA_SEC_PROG_PREPARING */
+	"writing",		/* IFPGA_SEC_PROG_WRITING */
+	"programming"		/* IFPGA_SEC_PROG_PROGRAMMING */
+};
+
+static ssize_t
+status_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct ifpga_sec_mgr *imgr = to_sec_mgr(dev);
+
+	return sprintf(buf, "%s\n", (imgr->progress < IFPGA_SEC_PROG_MAX) ?
+		       sec_mgr_prog_str[imgr->progress] : "unknown-status");
+}
+static DEVICE_ATTR_RO(status);
+
 static ssize_t filename_store(struct device *dev, struct device_attribute *attr,
 			      const char *buf, size_t count)
 {
@@ -288,6 +313,7 @@ static DEVICE_ATTR_WO(filename);
 
 static struct attribute *sec_mgr_update_attrs[] = {
 	&dev_attr_filename.attr,
+	&dev_attr_status.attr,
 	NULL,
 };
 
-- 
2.17.1


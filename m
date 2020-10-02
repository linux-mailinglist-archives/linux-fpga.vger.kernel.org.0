Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0DB1281E71
	for <lists+linux-fpga@lfdr.de>; Sat,  3 Oct 2020 00:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725789AbgJBWhQ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 2 Oct 2020 18:37:16 -0400
Received: from mga11.intel.com ([192.55.52.93]:19237 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbgJBWhP (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 2 Oct 2020 18:37:15 -0400
IronPort-SDR: X8HoCUWvopY7KhBLslKsIk5OLSEso7/BaUAG9EN7AuBGkl7Sg++itVVkK0GMtCkgB2ynmxJVjo
 1vgFHIUOX7Xg==
X-IronPort-AV: E=McAfee;i="6000,8403,9762"; a="160415302"
X-IronPort-AV: E=Sophos;i="5.77,329,1596524400"; 
   d="scan'208";a="160415302"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2020 15:37:14 -0700
IronPort-SDR: ZFv0M67j5iE+qIOlWIabHnxtp3D3FBB2c8OR9degVcNlnQBbe2bD8zhboKaUndIAtToC4EFNRm
 iBIflgVhFCgQ==
X-IronPort-AV: E=Sophos;i="5.77,329,1596524400"; 
   d="scan'208";a="510808804"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO rhweight-mobl2.ra.intel.com) ([10.254.5.53])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2020 15:37:14 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v2 3/7] fpga: sec-mgr: expose sec-mgr update status
Date:   Fri,  2 Oct 2020 15:36:57 -0700
Message-Id: <20201002223701.1317-4-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201002223701.1317-1-russell.h.weight@intel.com>
References: <20201002223701.1317-1-russell.h.weight@intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Extend the Intel Security Manager class driver to
include an update/status sysfs node that can be polled
and read to monitor the progress of an ongoing secure
update. Sysfs_notify() is used to signal transitions
between different phases of the update process.

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
---
v2:
  - Bumped documentation date and version
  - Changed progress state "read_file" to "reading"
---
 .../ABI/testing/sysfs-class-ifpga-sec-mgr     | 11 +++++
 drivers/fpga/ifpga-sec-mgr.c                  | 40 +++++++++++++++++--
 2 files changed, 47 insertions(+), 4 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr b/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
index 4f375f132c34..73a5246fea1b 100644
--- a/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
+++ b/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
@@ -78,3 +78,14 @@ Description:	Write only. Write the filename of an Intel image
 		BMC images, BMC firmware, Static Region images,
 		and Root Entry Hashes, and to cancel Code Signing
 		Keys (CSK).
+
+What: 		/sys/class/ifpga_sec_mgr/ifpga_secX/update/status
+Date:		Oct 2020
+KernelVersion:  5.11
+Contact:	Russ Weight <russell.h.weight@intel.com>
+Description:	Read-only. Returns a string describing the current
+		status of an update. The string will be one of the
+		following: idle, reading, preparing, writing,
+		programming. Userspace code can poll on this file,
+		as it will be signaled by sysfs_notify() on each
+		state change.
diff --git a/drivers/fpga/ifpga-sec-mgr.c b/drivers/fpga/ifpga-sec-mgr.c
index 7d5a4979554b..ad918fb42dc2 100644
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
@@ -259,6 +266,30 @@ static struct attribute_group sec_mgr_security_attr_group = {
 	.is_visible = sec_mgr_visible,
 };
 
+static const char * const sec_mgr_prog_str[] = {
+	"idle",			/* IFPGA_SEC_PROG_IDLE */
+	"reading",		/* IFPGA_SEC_PROG_READING */
+	"preparing",		/* IFPGA_SEC_PROG_PREPARING */
+	"writing",		/* IFPGA_SEC_PROG_WRITING */
+	"programming"		/* IFPGA_SEC_PROG_PROGRAMMING */
+};
+
+static ssize_t
+status_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct ifpga_sec_mgr *imgr = to_sec_mgr(dev);
+	const char *status = "unknown-status";
+
+	if (imgr->progress < IFPGA_SEC_PROG_MAX)
+		status = sec_mgr_prog_str[imgr->progress];
+	else
+		dev_warn(dev, "Invalid status during secure update: %d\n",
+			 imgr->progress);
+
+	return sprintf(buf, "%s\n", status);
+}
+static DEVICE_ATTR_RO(status);
+
 static ssize_t filename_store(struct device *dev, struct device_attribute *attr,
 			      const char *buf, size_t count)
 {
@@ -293,6 +324,7 @@ static DEVICE_ATTR_WO(filename);
 
 static struct attribute *sec_mgr_update_attrs[] = {
 	&dev_attr_filename.attr,
+	&dev_attr_status.attr,
 	NULL,
 };
 
-- 
2.17.1


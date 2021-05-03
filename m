Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0207B372279
	for <lists+linux-fpga@lfdr.de>; Mon,  3 May 2021 23:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbhECVgw (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 3 May 2021 17:36:52 -0400
Received: from mga18.intel.com ([134.134.136.126]:6730 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229764AbhECVgw (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 3 May 2021 17:36:52 -0400
IronPort-SDR: 1csj0DEIMG/4QUsFu3BmUbvFdT7jBonCObhRz0qmqggHKb35l90RoafgGQbJRBABy2bIFj1oyz
 QE6rWT57N1bw==
X-IronPort-AV: E=McAfee;i="6200,9189,9973"; a="185312154"
X-IronPort-AV: E=Sophos;i="5.82,271,1613462400"; 
   d="scan'208";a="185312154"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2021 14:35:57 -0700
IronPort-SDR: /v7zWWgeCpbkRPEz3SQB9i9+7fEAMEScp2HIQ7R0gaTFo8YKVYigkoddcEJ3InSW9wC39KNvod
 e9jWlQq2QaDQ==
X-IronPort-AV: E=Sophos;i="5.82,271,1613462400"; 
   d="scan'208";a="428548807"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO rhweight-mobl2.ra.intel.com) ([10.212.218.202])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2021 14:35:56 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        richard.gong@intel.com, Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v12 3/7] fpga: sec-mgr: expose sec-mgr update status
Date:   Mon,  3 May 2021 14:35:42 -0700
Message-Id: <20210503213546.316439-4-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210503213546.316439-1-russell.h.weight@intel.com>
References: <20210503213546.316439-1-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Extend the FPGA Security Manager class driver to
include an update/status sysfs node that can be polled
and read to monitor the progress of an ongoing secure
update. Sysfs_notify() is used to signal transitions
between different phases of the update process.

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Reviewed-by: Tom Rix <trix@redhat.com>
---
v12:
  - Updated Date and KernelVersion fields in ABI documentation
  - Changed syntax of sec_mgr_prog_str[] array definition from:
	"idle",			/* FPGA_SEC_PROG_IDLE */
    to:
	[FPGA_SEC_PROG_IDLE]	    = "idle",
v11:
  - No change
v10:
  - Rebased to 5.12-rc2 next
  - Updated Date and KernelVersion in ABI documentation
v9:
  - Updated Date and KernelVersion in ABI documentation
v8:
  - No change
v7:
  - Changed Date in documentation file to December 2020
v6:
  - No change
v5:
  - Use new function sysfs_emit() in the status_show() function
v4:
  - Changed from "Intel FPGA Security Manager" to FPGA Security Manager"
    and removed unnecessary references to "Intel".
  - Changed: iops -> sops, imgr -> smgr, IFPGA_ -> FPGA_, ifpga_ to fpga_
v3:
  - Use a local variable to read progress once in status_show()
  - Use dev_err to report invalid progress status
v2:
  - Bumped documentation date and version
  - Changed progress state "read_file" to "reading"
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
index fe82feda6b3c..dec52c68fe16 100644
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
2.25.1


Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 160D335D1C4
	for <lists+linux-fpga@lfdr.de>; Mon, 12 Apr 2021 22:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245621AbhDLUJn (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 12 Apr 2021 16:09:43 -0400
Received: from mga06.intel.com ([134.134.136.31]:53871 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245575AbhDLUJm (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 12 Apr 2021 16:09:42 -0400
IronPort-SDR: SB8MiMX60t5oDFJTEvws8ILIk+EFAjGU5vILYjqrmhhvzwr4THeVA5bWCYcfqN5V0v89W+QJfT
 nGxU7dadT3QQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9952"; a="255595505"
X-IronPort-AV: E=Sophos;i="5.82,216,1613462400"; 
   d="scan'208";a="255595505"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2021 13:09:23 -0700
IronPort-SDR: serfuw1lQGphsGwnXVzEg4e9ETr826eYEFNQi18jSkARrGgtMDrfa2g8UaMzxxOk77C3xRJ+Zh
 iPDxZto4PQUQ==
X-IronPort-AV: E=Sophos;i="5.82,216,1613462400"; 
   d="scan'208";a="388776092"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO rhweight-mobl2.ra.intel.com) ([10.251.8.207])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2021 13:09:22 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v11 3/7] fpga: sec-mgr: expose sec-mgr update status
Date:   Mon, 12 Apr 2021 13:09:12 -0700
Message-Id: <20210412200916.242151-4-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210412200916.242151-1-russell.h.weight@intel.com>
References: <20210412200916.242151-1-russell.h.weight@intel.com>
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
index 4c0bdfd25553..64420c101626 100644
--- a/Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
+++ b/Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
@@ -16,3 +16,14 @@ Description:	Write only. Write the filename of an image
 		BMC images, BMC firmware, Static Region images,
 		and Root Entry Hashes, and to cancel Code Signing
 		Keys (CSK).
+
+What: 		/sys/class/fpga_sec_mgr/fpga_secX/update/status
+Date:		April 2021
+KernelVersion:  5.13
+Contact:	Russ Weight <russell.h.weight@intel.com>
+Description:	Read-only. Returns a string describing the current
+		status of an update. The string will be one of the
+		following: idle, reading, preparing, writing,
+		programming. Userspace code can poll on this file,
+		as it will be signaled by sysfs_notify() on each
+		state change.
diff --git a/drivers/fpga/fpga-sec-mgr.c b/drivers/fpga/fpga-sec-mgr.c
index f2f87a48adbf..11050d07422a 100644
--- a/drivers/fpga/fpga-sec-mgr.c
+++ b/drivers/fpga/fpga-sec-mgr.c
@@ -25,6 +25,13 @@ struct fpga_sec_mgr_devres {
 
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
@@ -35,7 +42,7 @@ static void fpga_sec_dev_error(struct fpga_sec_mgr *smgr,
 static void progress_complete(struct fpga_sec_mgr *smgr)
 {
 	mutex_lock(&smgr->lock);
-	smgr->progress = FPGA_SEC_PROG_IDLE;
+	update_progress(smgr, FPGA_SEC_PROG_IDLE);
 	complete_all(&smgr->update_done);
 	mutex_unlock(&smgr->lock);
 }
@@ -63,14 +70,14 @@ static void fpga_sec_mgr_update(struct work_struct *work)
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
 	size = smgr->remaining_size;
 	while (size) {
 		blk_size = min_t(u32, size, WRITE_BLOCK_SIZE);
@@ -85,7 +92,7 @@ static void fpga_sec_mgr_update(struct work_struct *work)
 		offset += blk_size;
 	}
 
-	smgr->progress = FPGA_SEC_PROG_PROGRAMMING;
+	update_progress(smgr, FPGA_SEC_PROG_PROGRAMMING);
 	ret = smgr->sops->poll_complete(smgr);
 	if (ret != FPGA_SEC_ERR_NONE)
 		fpga_sec_dev_error(smgr, ret);
@@ -113,6 +120,32 @@ static void fpga_sec_mgr_update(struct work_struct *work)
 	progress_complete(smgr);
 }
 
+static const char * const sec_mgr_prog_str[] = {
+	"idle",			/* FPGA_SEC_PROG_IDLE */
+	"reading",		/* FPGA_SEC_PROG_READING */
+	"preparing",		/* FPGA_SEC_PROG_PREPARING */
+	"writing",		/* FPGA_SEC_PROG_WRITING */
+	"programming"		/* FPGA_SEC_PROG_PROGRAMMING */
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
@@ -147,6 +180,7 @@ static DEVICE_ATTR_WO(filename);
 
 static struct attribute *sec_mgr_update_attrs[] = {
 	&dev_attr_filename.attr,
+	&dev_attr_status.attr,
 	NULL,
 };
 
-- 
2.25.1


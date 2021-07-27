Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5073D8301
	for <lists+linux-fpga@lfdr.de>; Wed, 28 Jul 2021 00:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232607AbhG0WbX (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 27 Jul 2021 18:31:23 -0400
Received: from mga11.intel.com ([192.55.52.93]:37532 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233416AbhG0WbV (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 27 Jul 2021 18:31:21 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10058"; a="209429200"
X-IronPort-AV: E=Sophos;i="5.84,275,1620716400"; 
   d="scan'208";a="209429200"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2021 15:31:18 -0700
X-IronPort-AV: E=Sophos;i="5.84,275,1620716400"; 
   d="scan'208";a="437502463"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO rhweight-mobl2.ra.intel.com) ([10.209.69.186])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2021 15:31:17 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        richard.gong@intel.com, Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v14 5/6] fpga: sec-mgr: expose sec-mgr update size
Date:   Tue, 27 Jul 2021 15:31:04 -0700
Message-Id: <20210727223105.152142-6-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210727223105.152142-1-russell.h.weight@intel.com>
References: <20210727223105.152142-1-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Extend the FPGA Security Manager class driver to include
an update/remaining_size sysfs node that can be read to
determine how much data remains to be transferred to the
secure update engine. This file can be used to monitor
progress during the "writing" phase of an update.

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Reviewed-by: Tom Rix <trix@redhat.com>
---
v14:
 - Updated ABI documentation date and kernel version
v13:
  - No change
v12:
  - Updated Date and KernelVersion fields in ABI documentation
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
  - Use new function sysfs_emit() in the remaining_size_show() function
v4:
  - Changed from "Intel FPGA Security Manager" to FPGA Security Manager"
    and removed unnecessary references to "Intel".
  - Changed: imgr -> smgr, ifpga_ to fpga_
v3:
  - No change
v2:
  - Bumped documentation date and version
---
 Documentation/ABI/testing/sysfs-class-fpga-sec-mgr | 11 +++++++++++
 drivers/fpga/fpga-sec-mgr.c                        | 10 ++++++++++
 2 files changed, 21 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-fpga-sec-mgr b/Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
index 1c650a54fca5..fc91c4341cee 100644
--- a/Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
+++ b/Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
@@ -22,6 +22,17 @@ Description:	Read-only. Returns a string describing the current
 		as it will be signaled by sysfs_notify() on each
 		state change.
 
+What: 		/sys/class/fpga_sec_mgr/fpga_secX/update/remaining_size
+Date:		Aug 2021
+KernelVersion:	5.15
+Contact:	Russ Weight <russell.h.weight@intel.com>
+Description:	Read-only. Returns the size of data that remains to
+		be written to the secure update engine. The size
+		value is initialized to the full size of the file
+		image and the value is updated periodically during
+		the "writing" phase of the update.
+		Format: "%u".
+
 What: 		/sys/class/fpga_sec_mgr/fpga_secX/update/error
 Date:		Aug 2021
 KernelVersion:	5.15
diff --git a/drivers/fpga/fpga-sec-mgr.c b/drivers/fpga/fpga-sec-mgr.c
index a90a61b59094..7acf712134dc 100644
--- a/drivers/fpga/fpga-sec-mgr.c
+++ b/drivers/fpga/fpga-sec-mgr.c
@@ -195,6 +195,15 @@ error_show(struct device *dev, struct device_attribute *attr, char *buf)
 }
 static DEVICE_ATTR_RO(error);
 
+static ssize_t remaining_size_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct fpga_sec_mgr *smgr = to_sec_mgr(dev);
+
+	return sysfs_emit(buf, "%u\n", smgr->remaining_size);
+}
+static DEVICE_ATTR_RO(remaining_size);
+
 static ssize_t filename_store(struct device *dev, struct device_attribute *attr,
 			      const char *buf, size_t count)
 {
@@ -231,6 +240,7 @@ static struct attribute *sec_mgr_update_attrs[] = {
 	&dev_attr_filename.attr,
 	&dev_attr_status.attr,
 	&dev_attr_error.attr,
+	&dev_attr_remaining_size.attr,
 	NULL,
 };
 
-- 
2.25.1


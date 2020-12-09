Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF862D4EF0
	for <lists+linux-fpga@lfdr.de>; Thu, 10 Dec 2020 00:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729888AbgLIXpO (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 9 Dec 2020 18:45:14 -0500
Received: from mga05.intel.com ([192.55.52.43]:64561 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388794AbgLIXpJ (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 9 Dec 2020 18:45:09 -0500
IronPort-SDR: fIGE+eRM5Ux3WUQfewd12nh9GDBq5B00Fr0TN6f5bopt5atuyN7d9LwmBQAselOgAukepBrgbg
 FYQEBabLkRwQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9830"; a="258884339"
X-IronPort-AV: E=Sophos;i="5.78,407,1599548400"; 
   d="scan'208";a="258884339"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2020 15:44:07 -0800
IronPort-SDR: zhtgEJougIaGEosw+6Or9AFcbBtTya87BvmFIZz4FXz/8hCqInGFTIbii5s9sDVfh5FcqqynRJ
 8TeCGRzNHkEw==
X-IronPort-AV: E=Sophos;i="5.78,407,1599548400"; 
   d="scan'208";a="333100037"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO rhweight-mobl2.ra.intel.com) ([10.255.229.49])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2020 15:44:07 -0800
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v8 5/7] fpga: sec-mgr: expose sec-mgr update size
Date:   Wed,  9 Dec 2020 15:43:59 -0800
Message-Id: <20201209234401.78668-6-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201209234401.78668-1-russell.h.weight@intel.com>
References: <20201209234401.78668-1-russell.h.weight@intel.com>
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
index e6a62054bed8..62dc04e4335d 100644
--- a/Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
+++ b/Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
@@ -28,6 +28,17 @@ Description:	Read-only. Returns a string describing the current
 		as it will be signaled by sysfs_notify() on each
 		state change.
 
+What: 		/sys/class/fpga_sec_mgr/fpga_secX/update/remaining_size
+Date:		December 2020
+KernelVersion:  5.11
+Contact:	Russ Weight <russell.h.weight@intel.com>
+Description:	Read-only. Returns the size of data that remains to
+		be written to the secure update engine. The size
+		value is initialized to the full size of the file
+		image and the value is updated periodically during
+		the "writing" phase of the update.
+		Format: "%u".
+
 What: 		/sys/class/fpga_sec_mgr/fpga_secX/update/error
 Date:		December 2020
 KernelVersion:  5.11
diff --git a/drivers/fpga/fpga-sec-mgr.c b/drivers/fpga/fpga-sec-mgr.c
index 3bd89598cccd..951020942991 100644
--- a/drivers/fpga/fpga-sec-mgr.c
+++ b/drivers/fpga/fpga-sec-mgr.c
@@ -204,6 +204,15 @@ error_show(struct device *dev, struct device_attribute *attr, char *buf)
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
@@ -240,6 +249,7 @@ static struct attribute *sec_mgr_update_attrs[] = {
 	&dev_attr_filename.attr,
 	&dev_attr_status.attr,
 	&dev_attr_error.attr,
+	&dev_attr_remaining_size.attr,
 	NULL,
 };
 
-- 
2.25.1


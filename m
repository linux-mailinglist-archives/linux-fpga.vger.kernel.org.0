Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64292286C07
	for <lists+linux-fpga@lfdr.de>; Thu,  8 Oct 2020 02:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbgJHARH (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 7 Oct 2020 20:17:07 -0400
Received: from mga01.intel.com ([192.55.52.88]:22311 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727647AbgJHAQ6 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 7 Oct 2020 20:16:58 -0400
IronPort-SDR: XjoUzdTd63kBgwrkllHLRjajBkNWy/J8yfUN9NuRuu8s0pIyyWDB4a8NqdQlOzMSF+RVVFsDq+
 XPGkdyhVWRKA==
X-IronPort-AV: E=McAfee;i="6000,8403,9767"; a="182629359"
X-IronPort-AV: E=Sophos;i="5.77,348,1596524400"; 
   d="scan'208";a="182629359"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2020 17:16:53 -0700
IronPort-SDR: 2sJL8wnS86tVVXYnpPO3/eKYp3WaVokvXvzWBceQsDDB26eMZhOBaZvgpiiN5ai9HzXEAyhChi
 SM9O+OGSv29w==
X-IronPort-AV: E=Sophos;i="5.77,348,1596524400"; 
   d="scan'208";a="355169289"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO rhweight-mobl2.ra.intel.com) ([10.251.1.22])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2020 17:16:53 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v4 5/7] fpga: sec-mgr: expose sec-mgr update size
Date:   Wed,  7 Oct 2020 17:16:39 -0700
Message-Id: <20201008001641.28305-6-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201008001641.28305-1-russell.h.weight@intel.com>
References: <20201008001641.28305-1-russell.h.weight@intel.com>
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
index 560513653c70..61432a3a06a2 100644
--- a/Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
+++ b/Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
@@ -90,6 +90,17 @@ Description:	Read-only. Returns a string describing the current
 		as it will be signaled by sysfs_notify() on each
 		state change.
 
+What: 		/sys/class/fpga_sec_mgr/fpga_secX/update/remaining_size
+Date:		Oct 2020
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
 Date:		Oct 2020
 KernelVersion:  5.11
diff --git a/drivers/fpga/fpga-sec-mgr.c b/drivers/fpga/fpga-sec-mgr.c
index bd6a15d25a01..da5b4c8fe2bb 100644
--- a/drivers/fpga/fpga-sec-mgr.c
+++ b/drivers/fpga/fpga-sec-mgr.c
@@ -348,6 +348,15 @@ error_show(struct device *dev, struct device_attribute *attr, char *buf)
 }
 static DEVICE_ATTR_RO(error);
 
+static ssize_t remaining_size_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct fpga_sec_mgr *smgr = to_sec_mgr(dev);
+
+	return sprintf(buf, "%u\n", smgr->remaining_size);
+}
+static DEVICE_ATTR_RO(remaining_size);
+
 static ssize_t filename_store(struct device *dev, struct device_attribute *attr,
 			      const char *buf, size_t count)
 {
@@ -384,6 +393,7 @@ static struct attribute *sec_mgr_update_attrs[] = {
 	&dev_attr_filename.attr,
 	&dev_attr_status.attr,
 	&dev_attr_error.attr,
+	&dev_attr_remaining_size.attr,
 	NULL,
 };
 
-- 
2.17.1


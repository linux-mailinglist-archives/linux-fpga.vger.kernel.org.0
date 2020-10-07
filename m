Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01DF8285533
	for <lists+linux-fpga@lfdr.de>; Wed,  7 Oct 2020 02:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbgJGAKh (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 6 Oct 2020 20:10:37 -0400
Received: from mga04.intel.com ([192.55.52.120]:3648 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726785AbgJGAKg (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 6 Oct 2020 20:10:36 -0400
IronPort-SDR: cbhl2ioKtc4rj6oK4UybUmhtrZwprQu1ZkHRUraejLEeu1JgwEZzkwHz0X2OrBNhxiGAkJ43Pv
 +iexqpJdxzAA==
X-IronPort-AV: E=McAfee;i="6000,8403,9766"; a="162139583"
X-IronPort-AV: E=Sophos;i="5.77,344,1596524400"; 
   d="scan'208";a="162139583"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2020 17:10:34 -0700
IronPort-SDR: zn3yGGU7+0ViMsUHdigM7lrjjOTKsItscjkdDtgDttFzRFfoXKIoDzDqz8khawr1CEHkL9FNpb
 KiRlBLKgEnQA==
X-IronPort-AV: E=Sophos;i="5.77,344,1596524400"; 
   d="scan'208";a="297380466"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO rhweight-mobl2.ra.intel.com) ([10.212.2.223])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2020 17:10:33 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v3 5/7] fpga: sec-mgr: expose sec-mgr update size
Date:   Tue,  6 Oct 2020 17:10:02 -0700
Message-Id: <20201007001004.23790-6-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201007001004.23790-1-russell.h.weight@intel.com>
References: <20201007001004.23790-1-russell.h.weight@intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Extend the Intel Security Manager class driver to include
an update/remaining_size sysfs node that can be read to
determine how much data remains to be transferred to the
secure update engine. This file can be used to monitor
progress during the "writing" phase of an update.

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Reviewed-by: Tom Rix <trix@redhat.com>
---
v3:
  - No change
v2:
  - Bumped documentation date and version
---
 Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr | 11 +++++++++++
 drivers/fpga/ifpga-sec-mgr.c                        | 10 ++++++++++
 2 files changed, 21 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr b/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
index 1f9f2c215e0c..ec51135fcb6a 100644
--- a/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
+++ b/Documentation/ABI/testing/sysfs-class-ifpga-sec-mgr
@@ -90,6 +90,17 @@ Description:	Read-only. Returns a string describing the current
 		as it will be signaled by sysfs_notify() on each
 		state change.
 
+What: 		/sys/class/ifpga_sec_mgr/ifpga_secX/update/remaining_size
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
 What: 		/sys/class/ifpga_sec_mgr/ifpga_secX/update/error
 Date:		Oct 2020
 KernelVersion:  5.11
diff --git a/drivers/fpga/ifpga-sec-mgr.c b/drivers/fpga/ifpga-sec-mgr.c
index a45907b756bf..d4fa5d60fa02 100644
--- a/drivers/fpga/ifpga-sec-mgr.c
+++ b/drivers/fpga/ifpga-sec-mgr.c
@@ -348,6 +348,15 @@ error_show(struct device *dev, struct device_attribute *attr, char *buf)
 }
 static DEVICE_ATTR_RO(error);
 
+static ssize_t remaining_size_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct ifpga_sec_mgr *imgr = to_sec_mgr(dev);
+
+	return sprintf(buf, "%u\n", imgr->remaining_size);
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


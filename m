Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85D4550627D
	for <lists+linux-fpga@lfdr.de>; Tue, 19 Apr 2022 05:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237758AbiDSDKi (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 18 Apr 2022 23:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233759AbiDSDKg (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 18 Apr 2022 23:10:36 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C57222DA9D
        for <linux-fpga@vger.kernel.org>; Mon, 18 Apr 2022 20:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650337675; x=1681873675;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5ikLuKQwN3tn9LL3ZhRo6bN8mdd0tzGw2MCw1FckcEw=;
  b=Jb2vBmsrVOR2bz/b6NGdVTG8PHSMWajBLBKgCYw4N8O+J5MpVBhlkBzu
   CC5Lu++gHf4fFKj0czMTuJ5uvXf2aK7kBGlTKDPPMSDdOXA9me3RZXyuS
   9MtazDmh9CYGxh6AGH7dKrxBPa4aYavd2T9puWX7/mlcr8oPDX24lSZWv
   4BMMLhYDW1FisWCIL/IuAAl3QWq2VLCD4JI7CGSq0KHH9DruyIt31ZJJg
   LuR5/GLqN6RaALeIvgbRF7V7Rm/MHHg83OKmD6/Dr0jzrUmc6Mdm8MwH/
   M+/AJlFQ5Kf6VwjYQRM2v+iNzRlx88xXxUnPHlcQrJzSM4PyFzjZrFj8Q
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="350110898"
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="350110898"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 20:07:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="657475507"
Received: from unknown (HELO localhost.localdomain.sh.intel.com) ([10.238.175.107])
  by fmsmga002.fm.intel.com with ESMTP; 18 Apr 2022 20:07:53 -0700
From:   Tianfei Zhang <tianfei.zhang@intel.com>
To:     hao.wu@intel.com, trix@redhat.com, mdf@kernel.org,
        yilun.xu@intel.com, linux-fpga@vger.kernel.org
Cc:     Tianfei zhang <tianfei.zhang@intel.com>
Subject: [PATCH v2] fpga: dfl: fme: adding reserved bits for revision of FME/Port error
Date:   Mon, 18 Apr 2022 23:03:57 -0400
Message-Id: <20220419030357.410495-1-tianfei.zhang@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Tianfei zhang <tianfei.zhang@intel.com>

There are 2 different register layouts for FME/Port error
registers. The new production like Intel PAC N6000 plans to
deploy the new register format which it is more reasonable.

To distinguish the register layouts,we provide another sysfs
node for revision info, but it is a bad method that using one
sysfs node's value to determine the usage of other sysfs node.

This patch introduces 4 reserved bits (Bit[59:56]) which
are reserved by HW, dfl driver appends the FME/Port error
revision info on those bits for attribution on the readout
value.

Signed-off-by: Tianfei zhang <tianfei.zhang@intel.com>
---
v2:
 - add documentation for this change.
 - fix the reverse xmas tree declaration.
---
 .../ABI/testing/sysfs-platform-dfl-fme        | 37 ++++++++++++-------
 drivers/fpga/dfl-fme-error.c                  | 36 +++++++++++++++---
 2 files changed, 54 insertions(+), 19 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-platform-dfl-fme b/Documentation/ABI/testing/sysfs-platform-dfl-fme
index d6ab34e81b9b..b886568d6071 100644
--- a/Documentation/ABI/testing/sysfs-platform-dfl-fme
+++ b/Documentation/ABI/testing/sysfs-platform-dfl-fme
@@ -50,46 +50,57 @@ Date:		August 2019
 KernelVersion:  5.4
 Contact:	Wu Hao <hao.wu@intel.com>
 Description:	Read-Write. Read this file for errors detected on pcie0 link.
-		Write this file to clear errors logged in pcie0_errors. Write
-		fails with -EINVAL if input parsing fails or input error code
-		doesn't match.
+		The readout value has embedded 4 bits revision attribution
+		in Bit[59:56] which reserved by hardware. Write this file to
+		clear errors logged in pcie0_errors. Clean Bit[59:56] before
+		write this file. Write fails with -EINVAL if input parsing
+		fails or input error code doesn't match.
 
 What:		/sys/bus/platform/devices/dfl-fme.0/errors/pcie1_errors
 Date:		August 2019
 KernelVersion:  5.4
 Contact:	Wu Hao <hao.wu@intel.com>
 Description:	Read-Write. Read this file for errors detected on pcie1 link.
-		Write this file to clear errors logged in pcie1_errors. Write
-		fails with -EINVAL if input parsing fails or input error code
-		doesn't match.
+		The readout value has embedded 4 bits revision attribution
+		in Bit[59:56] which reserved by hardware. Write this file to
+		clear errors logged in pcie1_errors. Clean Bit[59:56] before
+		write this file. Write fails with -EINVAL if input parsing fails
+		or input error code doesn't match.
 
 What:		/sys/bus/platform/devices/dfl-fme.0/errors/nonfatal_errors
 Date:		August 2019
 KernelVersion:  5.4
 Contact:	Wu Hao <hao.wu@intel.com>
-Description:	Read-only. It returns non-fatal errors detected.
+Description:	Read-only. It returns non-fatal errors detected. The readout
+		value has embedded 4 bits revision attribution in Bit[59:56]
+		which reserved by hardware.
 
 What:		/sys/bus/platform/devices/dfl-fme.0/errors/catfatal_errors
 Date:		August 2019
 KernelVersion:  5.4
 Contact:	Wu Hao <hao.wu@intel.com>
 Description:	Read-only. It returns catastrophic and fatal errors detected.
+		The readout value has embedded 4 bits revision attribution in
+		Bit[59:56] which reserved by hardware.
 
 What:		/sys/bus/platform/devices/dfl-fme.0/errors/inject_errors
 Date:		August 2019
 KernelVersion:  5.4
 Contact:	Wu Hao <hao.wu@intel.com>
-Description:	Read-Write. Read this file to check errors injected. Write this
-		file to inject errors for testing purpose. Write fails with
-		-EINVAL if input parsing fails or input inject error code isn't
-		supported.
+Description:	Read-Write. Read this file to check errors injected. The readout
+		value has embedded 4 bits revision attribution which reserved by
+		hardware. Write this file to inject errors for testing purpose.
+		Clean Bit[59:56] before write this file. Write fails with -EINVAL
+		if input parsing fails or input inject error code isn't supported.
 
 What:		/sys/bus/platform/devices/dfl-fme.0/errors/fme_errors
 Date:		August 2019
 KernelVersion:  5.4
 Contact:	Wu Hao <hao.wu@intel.com>
-Description:	Read-Write. Read this file to get errors detected on FME.
-		Write this file to clear errors logged in fme_errors. Write
+Description:	Read-Write. Read this file to get errors detected on FME. The
+		readout value has embedded 4 bits revision attribution which
+		reserved by hardware. Write this file to clear errors logged
+		in fme_errors. Clean Bit[59:56] before write this file. Write
 		fials with -EINVAL if input parsing fails or input error code
 		doesn't match.
 
diff --git a/drivers/fpga/dfl-fme-error.c b/drivers/fpga/dfl-fme-error.c
index 51c2892ec06d..a440bc09938d 100644
--- a/drivers/fpga/dfl-fme-error.c
+++ b/drivers/fpga/dfl-fme-error.c
@@ -39,6 +39,22 @@
 
 #define ERROR_MASK		GENMASK_ULL(63, 0)
 
+/* Bit[59:56] was reserved by software for error revision */
+#define ERROR_SW_REVISION_MASK GENMASK_ULL(59, 56)
+
+static u64 set_error_revision(struct device *dev, u64 value)
+{
+	void __iomem *base;
+	u64 revision;
+	u64 dfh;
+
+	base = dfl_get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_GLOBAL_ERR);
+	dfh = readq(base);
+	revision = FIELD_GET(DFH_REVISION, dfh);
+
+	return value | FIELD_PREP(ERROR_SW_REVISION_MASK, revision);
+}
+
 static ssize_t pcie0_errors_show(struct device *dev,
 				 struct device_attribute *attr, char *buf)
 {
@@ -52,7 +68,8 @@ static ssize_t pcie0_errors_show(struct device *dev,
 	value = readq(base + PCIE0_ERROR);
 	mutex_unlock(&pdata->lock);
 
-	return sprintf(buf, "0x%llx\n", (unsigned long long)value);
+	return sprintf(buf, "0x%llx\n",
+		       (unsigned long long)set_error_revision(dev, value));
 }
 
 static ssize_t pcie0_errors_store(struct device *dev,
@@ -97,7 +114,8 @@ static ssize_t pcie1_errors_show(struct device *dev,
 	value = readq(base + PCIE1_ERROR);
 	mutex_unlock(&pdata->lock);
 
-	return sprintf(buf, "0x%llx\n", (unsigned long long)value);
+	return sprintf(buf, "0x%llx\n",
+		       (unsigned long long)set_error_revision(dev, value));
 }
 
 static ssize_t pcie1_errors_store(struct device *dev,
@@ -133,11 +151,13 @@ static ssize_t nonfatal_errors_show(struct device *dev,
 				    struct device_attribute *attr, char *buf)
 {
 	void __iomem *base;
+	u64 value;
 
 	base = dfl_get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_GLOBAL_ERR);
+	value = readq(base + RAS_NONFAT_ERROR);
 
 	return sprintf(buf, "0x%llx\n",
-		       (unsigned long long)readq(base + RAS_NONFAT_ERROR));
+		       (unsigned long long)set_error_revision(dev, value));
 }
 static DEVICE_ATTR_RO(nonfatal_errors);
 
@@ -145,11 +165,13 @@ static ssize_t catfatal_errors_show(struct device *dev,
 				    struct device_attribute *attr, char *buf)
 {
 	void __iomem *base;
+	u64 value;
 
 	base = dfl_get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_GLOBAL_ERR);
+	value = readq(base + RAS_CATFAT_ERROR);
 
 	return sprintf(buf, "0x%llx\n",
-		       (unsigned long long)readq(base + RAS_CATFAT_ERROR));
+		       (unsigned long long)set_error_revision(dev, value));
 }
 static DEVICE_ATTR_RO(catfatal_errors);
 
@@ -165,9 +187,10 @@ static ssize_t inject_errors_show(struct device *dev,
 	mutex_lock(&pdata->lock);
 	v = readq(base + RAS_ERROR_INJECT);
 	mutex_unlock(&pdata->lock);
+	v = FIELD_GET(INJECT_ERROR_MASK, v);
 
 	return sprintf(buf, "0x%llx\n",
-		       (unsigned long long)FIELD_GET(INJECT_ERROR_MASK, v));
+		       (unsigned long long)set_error_revision(dev, v));
 }
 
 static ssize_t inject_errors_store(struct device *dev,
@@ -211,7 +234,8 @@ static ssize_t fme_errors_show(struct device *dev,
 	value = readq(base + FME_ERROR);
 	mutex_unlock(&pdata->lock);
 
-	return sprintf(buf, "0x%llx\n", (unsigned long long)value);
+	return sprintf(buf, "0x%llx\n",
+		       (unsigned long long)set_error_revision(dev, value));
 }
 
 static ssize_t fme_errors_store(struct device *dev,
-- 
2.26.2


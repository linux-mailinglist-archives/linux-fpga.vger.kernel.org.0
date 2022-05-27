Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECDC535A92
	for <lists+linux-fpga@lfdr.de>; Fri, 27 May 2022 09:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbiE0HgZ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 27 May 2022 03:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234319AbiE0HgX (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 27 May 2022 03:36:23 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E832A31355
        for <linux-fpga@vger.kernel.org>; Fri, 27 May 2022 00:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653636982; x=1685172982;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KelbTPq5V9JMYS2yicAlvfjjjXqzKzMFVu1IUgk4eic=;
  b=Zp9LxkOaerQw/G3T42TxDiAHvpYxY6THJ6SIqf5a9SZ37Fyy/Qwp/5r4
   m/7yxD9Aq5aAA8/4P55WcTm2Ja28P9caM21fizHhEXDsev4PF8doJCKXd
   2HGx+eMu9Mr1IXfAQ7rhfU/2jto+q3Dtv3pytkGLGLPol5ngc45gCXdMj
   3UA7wO+DDiQx2CvmYt/e6FJkOPOQpLLbTBKbxJc6bnPp0IRYvOjKtMI/V
   zwnSuxtbQcP4rCG/bbhXxnO33XO/E5zgxGxGG149x3ItpOQYp5m9gU5xa
   BsfN2aBjTtTu2TGEr7YnV77JJhP8QkgZfCo05pA4ervCmGHXT7wUJXL5j
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10359"; a="271981888"
X-IronPort-AV: E=Sophos;i="5.91,254,1647327600"; 
   d="scan'208";a="271981888"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2022 00:36:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,254,1647327600"; 
   d="scan'208";a="746797620"
Received: from unknown (HELO localhost.localdomain.sh.intel.com) ([10.238.175.107])
  by orsmga005.jf.intel.com with ESMTP; 27 May 2022 00:36:20 -0700
From:   Tianfei Zhang <tianfei.zhang@intel.com>
To:     hao.wu@intel.com, trix@redhat.com, mdf@kernel.org,
        yilun.xu@intel.com, linux-fpga@vger.kernel.org
Cc:     Tianfei zhang <tianfei.zhang@intel.com>
Subject: [PATCH v3] fpga: dfl: fme: adding reserved bits for revision of FME/Port error
Date:   Fri, 27 May 2022 03:32:53 -0400
Message-Id: <20220527073253.306501-1-tianfei.zhang@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Tianfei zhang <tianfei.zhang@intel.com>

There are 2 different register layouts for FME/Port error
registers. The older PAC card like N3000 used the older
register layout, but to improve the scalability, the new
production like Intel PAC N6000 plans to deploy the new
register format.

To distinguish the register layouts, we provide another sysfs
node for revision info, but it is a bad method that using one
sysfs node's value to determine the usage of other sysfs node.

This patch introduces 4 reserved bits (Bit[59:56]) in error
register to store the revision value which readout from
DFH_REVISION field in DFH register, the DFH_REVSION field also
4 bits width. DFL driver appends the FME/Port error
revision info in those bits for attribution on the readout
value.

Signed-off-by: Tianfei zhang <tianfei.zhang@intel.com>
---
v3:
 - no code change, just add some explanation of two register layouts in git message.
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


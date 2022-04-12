Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26D074FD085
	for <lists+linux-fpga@lfdr.de>; Tue, 12 Apr 2022 08:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350133AbiDLGpk (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 12 Apr 2022 02:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351602AbiDLGpX (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 12 Apr 2022 02:45:23 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC763B28B
        for <linux-fpga@vger.kernel.org>; Mon, 11 Apr 2022 23:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649745524; x=1681281524;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=t0Hl+M2maOOd0TfAZs4QKe6TJgp48gjT3xg/LEY9PFA=;
  b=OPbbFPMSoXoS0pytCdnaDg7ns6jIOjWndX0tuG9Q9F6rClcNZ4h7dCyz
   GBd27K+Vo73H2q1yl0wPACWtERF1pAmKY6C+OZVarFm5I8mMo8N/tzTZH
   lga/PmD0vZZx3R2YBWpa7FTTJ5N/LHlIlPFWRg/n/Oyxx7Yp7yvW1eeyb
   ddFVa7wtOi9JfgJnTnh8H8+Dv6oo8aiblW6xv3wX3+2a1h+1zD9tAiUaH
   KMhDs83LheXqoYR8Jc74gCRxjkZpTS6u1SH/+RbgdJ57OW3U6cmAV5leN
   gDSPBJhUaiQX3gE3oaQXKyPuCmFvwOiifvI8y3uKzslpEVNnbkiDzVnwV
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="287303364"
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="287303364"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 23:38:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="507414047"
Received: from unknown (HELO localhost.localdomain.sh.intel.com) ([10.238.175.107])
  by orsmga003.jf.intel.com with ESMTP; 11 Apr 2022 23:38:42 -0700
From:   Tianfei Zhang <tianfei.zhang@intel.com>
To:     hao.wu@intel.com, trix@redhat.com, mdf@kernel.org,
        yilun.xu@intel.com, linux-fpga@vger.kernel.org
Cc:     Tianfei zhang <tianfei.zhang@intel.com>
Subject: [PATCH v1] fpga: dfl: fme: adding reserved bits for revision of FME/Port error
Date:   Tue, 12 Apr 2022 02:35:23 -0400
Message-Id: <20220412063523.54587-1-tianfei.zhang@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Tianfei zhang <tianfei.zhang@intel.com>

There are 2 different register layouts for FME/Port error
registers. This patch introduces 4 reserved bits (Bit[59:56])
to indicate the revision of register layout for userland
application.

Signed-off-by: Tianfei zhang <tianfei.zhang@intel.com>
---
 drivers/fpga/dfl-fme-error.c | 36 ++++++++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/fpga/dfl-fme-error.c b/drivers/fpga/dfl-fme-error.c
index 51c2892ec06d..3b54470f56ca 100644
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
+	u64 dfh;
+	u64 revision;
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


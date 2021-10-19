Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2B024341F6
	for <lists+linux-fpga@lfdr.de>; Wed, 20 Oct 2021 01:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbhJSXSw (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 19 Oct 2021 19:18:52 -0400
Received: from mga17.intel.com ([192.55.52.151]:7453 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229992AbhJSXSv (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 19 Oct 2021 19:18:51 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10142"; a="209445792"
X-IronPort-AV: E=Sophos;i="5.87,164,1631602800"; 
   d="scan'208";a="209445792"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2021 16:15:54 -0700
X-IronPort-AV: E=Sophos;i="5.87,164,1631602800"; 
   d="scan'208";a="567152186"
Received: from rhweight-mobl.amr.corp.intel.com (HELO rhweight-mobl.ra.intel.com) ([10.212.183.7])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2021 16:15:52 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v1 2/2] fpga: dfl: fme: Clear fme global errors at driver init
Date:   Tue, 19 Oct 2021 16:15:45 -0700
Message-Id: <20211019231545.47118-3-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211019231545.47118-1-russell.h.weight@intel.com>
References: <20211019231545.47118-1-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

When the fme-error driver initializes, log any pre-existing errors and
clear them. To avoid code replication, common code is gathered into
a common fme_err_clear() function and a structure (err_reg) is created
to describe each of the error registers, the corresponding mask
registers, and the default mask for each register.

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
---
 drivers/fpga/dfl-fme-error.c | 128 +++++++++++++++++++++++------------
 1 file changed, 84 insertions(+), 44 deletions(-)

diff --git a/drivers/fpga/dfl-fme-error.c b/drivers/fpga/dfl-fme-error.c
index 51c2892ec06d..44da7b30c469 100644
--- a/drivers/fpga/dfl-fme-error.c
+++ b/drivers/fpga/dfl-fme-error.c
@@ -39,6 +39,27 @@
 
 #define ERROR_MASK		GENMASK_ULL(63, 0)
 
+struct err_reg {
+	char *name;
+	u32 err_offset;
+	u32 mask_offset;
+	u32 mask_value;
+};
+
+static struct err_reg pcie0_reg = {
+	.name = "PCIE0",
+	.err_offset = PCIE0_ERROR,
+	.mask_offset = PCIE0_ERROR_MASK,
+	.mask_value = 0ULL
+};
+
+static struct err_reg pcie1_reg = {
+	.name = "PCIE1",
+	.err_offset = PCIE1_ERROR,
+	.mask_offset = PCIE1_ERROR_MASK,
+	.mask_value = 0ULL
+};
+
 static ssize_t pcie0_errors_show(struct device *dev,
 				 struct device_attribute *attr, char *buf)
 {
@@ -55,31 +76,48 @@ static ssize_t pcie0_errors_show(struct device *dev,
 	return sprintf(buf, "0x%llx\n", (unsigned long long)value);
 }
 
-static ssize_t pcie0_errors_store(struct device *dev,
-				  struct device_attribute *attr,
-				  const char *buf, size_t count)
+static int fme_err_clear(struct device *dev, struct err_reg *reg,
+			 u64 err, bool clear_all)
 {
 	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
 	void __iomem *base;
 	int ret = 0;
-	u64 v, val;
-
-	if (kstrtou64(buf, 0, &val))
-		return -EINVAL;
+	u64 v;
 
 	base = dfl_get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_GLOBAL_ERR);
 
 	mutex_lock(&pdata->lock);
-	writeq(GENMASK_ULL(63, 0), base + PCIE0_ERROR_MASK);
+	writeq(GENMASK_ULL(63, 0), base + reg->mask_offset);
 
-	v = readq(base + PCIE0_ERROR);
-	if (val == v)
-		writeq(v, base + PCIE0_ERROR);
-	else
+	v = readq(base + reg->err_offset);
+	if (clear_all || err == v) {
+		if (clear_all && v)
+			dev_warn(dev, "%s: %s Errors: 0x%llx\n",
+				 __func__, reg->name, v);
+
+		writeq(v, base + reg->err_offset);
+	} else {
 		ret = -EINVAL;
+	}
 
-	writeq(0ULL, base + PCIE0_ERROR_MASK);
+	writeq(reg->mask_value, base + reg->mask_offset);
 	mutex_unlock(&pdata->lock);
+
+	return ret;
+}
+
+static ssize_t pcie0_errors_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t count)
+{
+	u64 val;
+	int ret;
+
+	if (kstrtou64(buf, 0, &val))
+		return -EINVAL;
+
+	ret = fme_err_clear(dev, &pcie0_reg, val, false);
+
 	return ret ? ret : count;
 }
 static DEVICE_ATTR_RW(pcie0_errors);
@@ -104,27 +142,14 @@ static ssize_t pcie1_errors_store(struct device *dev,
 				  struct device_attribute *attr,
 				  const char *buf, size_t count)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
-	void __iomem *base;
-	int ret = 0;
-	u64 v, val;
+	u64 val;
+	int ret;
 
 	if (kstrtou64(buf, 0, &val))
 		return -EINVAL;
 
-	base = dfl_get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_GLOBAL_ERR);
+	ret = fme_err_clear(dev, &pcie1_reg, val, false);
 
-	mutex_lock(&pdata->lock);
-	writeq(GENMASK_ULL(63, 0), base + PCIE1_ERROR_MASK);
-
-	v = readq(base + PCIE1_ERROR);
-	if (val == v)
-		writeq(v, base + PCIE1_ERROR);
-	else
-		ret = -EINVAL;
-
-	writeq(0ULL, base + PCIE1_ERROR_MASK);
-	mutex_unlock(&pdata->lock);
 	return ret ? ret : count;
 }
 static DEVICE_ATTR_RW(pcie1_errors);
@@ -218,29 +243,26 @@ static ssize_t fme_errors_store(struct device *dev,
 				struct device_attribute *attr,
 				const char *buf, size_t count)
 {
-	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	static struct err_reg fme_reg = {
+		.name = "FME",
+		.err_offset = FME_ERROR,
+		.mask_offset = FME_ERROR_MASK,
+		.mask_value = 0ULL
+	};
 	void __iomem *base;
-	u64 v, val;
-	int ret = 0;
+	u64 val;
+	int ret;
 
 	if (kstrtou64(buf, 0, &val))
 		return -EINVAL;
 
+	/* Workaround: disable MBP_ERROR if feature revision is 0 */
 	base = dfl_get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_GLOBAL_ERR);
+	if (!dfl_feature_revision(base))
+		fme_reg.mask_value = MBP_ERROR;
 
-	mutex_lock(&pdata->lock);
-	writeq(GENMASK_ULL(63, 0), base + FME_ERROR_MASK);
+	ret = fme_err_clear(dev, &fme_reg, val, false);
 
-	v = readq(base + FME_ERROR);
-	if (val == v)
-		writeq(v, base + FME_ERROR);
-	else
-		ret = -EINVAL;
-
-	/* Workaround: disable MBP_ERROR if feature revision is 0 */
-	writeq(dfl_feature_revision(base) ? 0ULL : MBP_ERROR,
-	       base + FME_ERROR_MASK);
-	mutex_unlock(&pdata->lock);
 	return ret ? ret : count;
 }
 static DEVICE_ATTR_RW(fme_errors);
@@ -338,6 +360,24 @@ static void fme_err_mask(struct device *dev, bool mask)
 static int fme_global_err_init(struct platform_device *pdev,
 			       struct dfl_feature *feature)
 {
+	static struct err_reg fme_reg = {
+		.name = "FME",
+		.err_offset = FME_ERROR,
+		.mask_offset = FME_ERROR_MASK,
+		.mask_value = 0ULL
+	};
+	void __iomem *base;
+
+	/* Workaround: disable MBP_ERROR if feature revision is 0 */
+	base = dfl_get_feature_ioaddr_by_id(&pdev->dev,
+					    FME_FEATURE_ID_GLOBAL_ERR);
+	if (!dfl_feature_revision(base))
+		fme_reg.mask_value = MBP_ERROR;
+
+	(void)fme_err_clear(&pdev->dev, &pcie0_reg, 0ULL, true);
+	(void)fme_err_clear(&pdev->dev, &pcie1_reg, 0ULL, true);
+	(void)fme_err_clear(&pdev->dev, &fme_reg, 0ULL, true);
+
 	fme_err_mask(&pdev->dev, false);
 
 	return 0;
-- 
2.25.1


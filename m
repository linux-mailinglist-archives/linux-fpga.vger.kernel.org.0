Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45B2C22BBE3
	for <lists+linux-fpga@lfdr.de>; Fri, 24 Jul 2020 04:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgGXCMk (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 23 Jul 2020 22:12:40 -0400
Received: from mga01.intel.com ([192.55.52.88]:14547 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726284AbgGXCMk (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 23 Jul 2020 22:12:40 -0400
IronPort-SDR: b9zL5Kn8H9YUm2qIAhMPb5EakILWGzoBLhS2TVzunrDSCGyQzdnJmujWhXcOjvCN5OlhM/D7aA
 GVmkyzKCFPrw==
X-IronPort-AV: E=McAfee;i="6000,8403,9691"; a="168780078"
X-IronPort-AV: E=Sophos;i="5.75,388,1589266800"; 
   d="scan'208";a="168780078"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2020 19:12:39 -0700
IronPort-SDR: x9FCOwNuy68WU8ugSvBT6vsj3dx0OeIvwtz9MDK8u1U/g9K6oNOdQQP3JCgHNLTTrV/u8da1Wb
 tMHMri8KW3Zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,388,1589266800"; 
   d="scan'208";a="271216015"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by fmsmga007.fm.intel.com with ESMTP; 23 Jul 2020 19:12:37 -0700
From:   Xu Yilun <yilun.xu@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com
Subject: [PATCH v2 1/4] fpga: dfl: change data type of feature id to u16
Date:   Fri, 24 Jul 2020 10:09:12 +0800
Message-Id: <1595556555-9903-2-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595556555-9903-1-git-send-email-yilun.xu@intel.com>
References: <1595556555-9903-1-git-send-email-yilun.xu@intel.com>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The feature id is stored in a 12 bit field in DFH. So a u16 variable is
enough for feature id.

This patch changes all feature id related places to fit u16.

Signed-off-by: Xu Yilun <yilun.xu@intel.com>
---
 drivers/fpga/dfl-fme-perf.c |  2 +-
 drivers/fpga/dfl.c          | 29 +++++++++++++++--------------
 drivers/fpga/dfl.h          | 10 +++++-----
 3 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/drivers/fpga/dfl-fme-perf.c b/drivers/fpga/dfl-fme-perf.c
index 6ce1ed2..5312662 100644
--- a/drivers/fpga/dfl-fme-perf.c
+++ b/drivers/fpga/dfl-fme-perf.c
@@ -148,7 +148,7 @@ struct fme_perf_priv {
 	struct device *dev;
 	void __iomem *ioaddr;
 	struct pmu pmu;
-	u64 id;
+	u16 id;
 
 	u32 fab_users;
 	u32 fab_port_id;
diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index b51db80..9bca22e 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -58,7 +58,7 @@ static const char *dfl_pdata_key_strings[DFL_ID_MAX] = {
  */
 struct dfl_dev_info {
 	const char *name;
-	u32 dfh_id;
+	u16 dfh_id;
 	struct idr id;
 	enum dfl_fpga_devt_type devt_type;
 };
@@ -134,7 +134,7 @@ static enum dfl_id_type feature_dev_id_type(struct platform_device *pdev)
 	return DFL_ID_MAX;
 }
 
-static enum dfl_id_type dfh_id_to_type(u32 id)
+static enum dfl_id_type dfh_id_to_type(u16 id)
 {
 	int i;
 
@@ -454,7 +454,7 @@ struct build_feature_devs_info {
  * @nr_irqs: number of irqs of this sub feature.
  */
 struct dfl_feature_info {
-	u64 fid;
+	u16 fid;
 	struct resource mmio_res;
 	void __iomem *ioaddr;
 	struct list_head node;
@@ -650,7 +650,7 @@ static inline u32 feature_size(void __iomem *start)
 	return ofst ? ofst : 4096;
 }
 
-static u64 feature_id(void __iomem *start)
+static u16 feature_id(void __iomem *start)
 {
 	u64 v = readq(start + DFH);
 	u16 id = FIELD_GET(DFH_ID, v);
@@ -668,7 +668,7 @@ static u64 feature_id(void __iomem *start)
 }
 
 static int parse_feature_irqs(struct build_feature_devs_info *binfo,
-			      resource_size_t ofst, u64 fid,
+			      resource_size_t ofst, u16 fid,
 			      unsigned int *irq_base, unsigned int *nr_irqs)
 {
 	void __iomem *base = binfo->ioaddr + ofst;
@@ -714,12 +714,12 @@ static int parse_feature_irqs(struct build_feature_devs_info *binfo,
 		return 0;
 	}
 
-	dev_dbg(binfo->dev, "feature: 0x%llx, irq_base: %u, nr_irqs: %u\n",
+	dev_dbg(binfo->dev, "feature: 0x%x, irq_base: %u, nr_irqs: %u\n",
 		fid, ibase, inr);
 
 	if (ibase + inr > binfo->nr_irqs) {
 		dev_err(binfo->dev,
-			"Invalid interrupt number in feature 0x%llx\n", fid);
+			"Invalid interrupt number in feature 0x%x\n", fid);
 		return -EINVAL;
 	}
 
@@ -727,7 +727,7 @@ static int parse_feature_irqs(struct build_feature_devs_info *binfo,
 		virq = binfo->irq_table[ibase + i];
 		if (virq < 0 || virq > NR_IRQS) {
 			dev_err(binfo->dev,
-				"Invalid irq table entry for feature 0x%llx\n",
+				"Invalid irq table entry for feature 0x%x\n",
 				fid);
 			return -EINVAL;
 		}
@@ -749,7 +749,7 @@ static int parse_feature_irqs(struct build_feature_devs_info *binfo,
 static int
 create_feature_instance(struct build_feature_devs_info *binfo,
 			struct dfl_fpga_enum_dfl *dfl, resource_size_t ofst,
-			resource_size_t size, u64 fid)
+			resource_size_t size, u16 fid)
 {
 	unsigned int irq_base, nr_irqs;
 	struct dfl_feature_info *finfo;
@@ -820,9 +820,10 @@ static int parse_feature_fiu(struct build_feature_devs_info *binfo,
 			     struct dfl_fpga_enum_dfl *dfl,
 			     resource_size_t ofst)
 {
-	u32 id, offset;
-	u64 v;
 	int ret = 0;
+	u32 offset;
+	u16 id;
+	u64 v;
 
 	v = readq(dfl->ioaddr + ofst + DFH);
 	id = FIELD_GET(DFH_ID, v);
@@ -856,8 +857,8 @@ static int parse_feature_private(struct build_feature_devs_info *binfo,
 				 resource_size_t ofst)
 {
 	if (!binfo->feature_dev) {
-		dev_err(binfo->dev, "the private feature %llx does not belong to any AFU.\n",
-			(unsigned long long)feature_id(dfl->ioaddr + ofst));
+		dev_err(binfo->dev, "the private feature 0x%x does not belong to any AFU.\n",
+			feature_id(dfl->ioaddr + ofst));
 		return -EINVAL;
 	}
 
@@ -1425,7 +1426,7 @@ static int do_set_irq_trigger(struct dfl_feature *feature, unsigned int idx,
 		return 0;
 
 	feature->irq_ctx[idx].name =
-		kasprintf(GFP_KERNEL, "fpga-irq[%u](%s-%llx)", idx,
+		kasprintf(GFP_KERNEL, "fpga-irq[%u](%s-%x)", idx,
 			  dev_name(&pdev->dev), feature->id);
 	if (!feature->irq_ctx[idx].name)
 		return -ENOMEM;
diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
index 632e733..b848e3c 100644
--- a/drivers/fpga/dfl.h
+++ b/drivers/fpga/dfl.h
@@ -197,7 +197,7 @@ int dfl_fpga_check_port_id(struct platform_device *pdev, void *pport_id);
  * @id: unique dfl private feature id.
  */
 struct dfl_feature_id {
-	u64 id;
+	u16 id;
 };
 
 /**
@@ -240,7 +240,7 @@ struct dfl_feature_irq_ctx {
  */
 struct dfl_feature {
 	struct platform_device *dev;
-	u64 id;
+	u16 id;
 	int resource_index;
 	void __iomem *ioaddr;
 	struct dfl_feature_irq_ctx *irq_ctx;
@@ -371,7 +371,7 @@ struct platform_device *dfl_fpga_inode_to_feature_dev(struct inode *inode)
 	   (feature) < (pdata)->features + (pdata)->num; (feature)++)
 
 static inline
-struct dfl_feature *dfl_get_feature_by_id(struct device *dev, u64 id)
+struct dfl_feature *dfl_get_feature_by_id(struct device *dev, u16 id)
 {
 	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
 	struct dfl_feature *feature;
@@ -384,7 +384,7 @@ struct dfl_feature *dfl_get_feature_by_id(struct device *dev, u64 id)
 }
 
 static inline
-void __iomem *dfl_get_feature_ioaddr_by_id(struct device *dev, u64 id)
+void __iomem *dfl_get_feature_ioaddr_by_id(struct device *dev, u16 id)
 {
 	struct dfl_feature *feature = dfl_get_feature_by_id(dev, id);
 
@@ -395,7 +395,7 @@ void __iomem *dfl_get_feature_ioaddr_by_id(struct device *dev, u64 id)
 	return NULL;
 }
 
-static inline bool is_dfl_feature_present(struct device *dev, u64 id)
+static inline bool is_dfl_feature_present(struct device *dev, u16 id)
 {
 	return !!dfl_get_feature_ioaddr_by_id(dev, id);
 }
-- 
2.7.4


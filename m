Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67F6A4DABB1
	for <lists+linux-fpga@lfdr.de>; Wed, 16 Mar 2022 08:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348406AbiCPHNM (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 16 Mar 2022 03:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354274AbiCPHNE (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 16 Mar 2022 03:13:04 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B045DE54;
        Wed, 16 Mar 2022 00:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647414711; x=1678950711;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RWgY9AC+lYBXFFxLtUrfMxojVXpyTuSrrkNnLAQetlM=;
  b=YXUhN6Um8u8khJcmILJdE39pl8/qK5QGGBq9fm3k43vO1gPWRCUd/QLk
   1wf1TYeRkevM8opmQSSeWzR1lxNgHIMWnzzR4zn8p/utf5JpfGHsa15sk
   I3uasEsGyo3ICyshdOhQk1dF4lwYk1NM3/HmJR4p8IRxDyQUVU/qPhY8s
   txXQ7SOUD1PMV2OveAoHgPOd3HYXMhDkGzBBHsitjt4czXG6G8/e6vGzp
   X06M/VV5MYqJC7oKOfMdyV59hmviSi+mqTBBy5WBysGlghIIxXLndh13p
   8CnD+lFMtGG9PhjZqHph8xT6D6pqRHlzVj0+Brkp8w1qCEmL5b+byJD+1
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="281289060"
X-IronPort-AV: E=Sophos;i="5.90,186,1643702400"; 
   d="scan'208";a="281289060"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 00:11:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,186,1643702400"; 
   d="scan'208";a="646538396"
Received: from unknown (HELO localhost.localdomain.sh.intel.com) ([10.238.175.107])
  by orsmga004.jf.intel.com with ESMTP; 16 Mar 2022 00:11:48 -0700
From:   Tianfei Zhang <tianfei.zhang@intel.com>
To:     hao.wu@intel.com, trix@redhat.com, mdf@kernel.org,
        yilun.xu@intel.com, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org
Cc:     corbet@lwn.net, Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Tianfei Zhang <tianfei.zhang@intel.com>
Subject: [PATCH v6 5/6] fpga: dfl: support PF/VF starting with DFH
Date:   Wed, 16 Mar 2022 03:08:13 -0400
Message-Id: <20220316070814.1916017-6-tianfei.zhang@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220316070814.1916017-1-tianfei.zhang@intel.com>
References: <20220316070814.1916017-1-tianfei.zhang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Matthew Gerlach <matthew.gerlach@linux.intel.com>

In OFS, it allows several PFs and VFs in static region or PR region.
Those PFs and VFs managed by DFL or a specific device, like virtio-net
device. Those PFs and VFs which managed by DFL can start with DFH, and
leverage VFIO to expose to an application or assign to a VM.

Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
---
 drivers/fpga/dfl-pci.c |  2 ++
 drivers/fpga/dfl.c     | 22 +++++++++++++---------
 drivers/fpga/dfl.h     |  7 +++++++
 3 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
index 2e9abeca3625..7d8b53330152 100644
--- a/drivers/fpga/dfl-pci.c
+++ b/drivers/fpga/dfl-pci.c
@@ -275,6 +275,8 @@ static int find_dfls_by_default(struct pci_dev *pcidev,
 		len = pci_resource_len(pcidev, 0);
 
 		dfl_fpga_enum_info_add_dfl(info, start, len);
+	} else if (dfl_feature_is_afu(base)) {
+		dev_info(&pcidev->dev, "find AFU\n");
 	} else {
 		ret = -ENODEV;
 	}
diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index 71e0725b6be0..db676f7482ec 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -900,9 +900,11 @@ static void build_info_free(struct build_feature_devs_info *binfo)
 		dfl_id_free(feature_dev_id_type(binfo->feature_dev),
 			    binfo->feature_dev->id);
 
-		list_for_each_entry_safe(finfo, p, &binfo->sub_features, node) {
-			list_del(&finfo->node);
-			kfree(finfo);
+		if (!list_empty(&binfo->sub_features)) {
+			list_for_each_entry_safe(finfo, p, &binfo->sub_features, node) {
+				list_del(&finfo->node);
+				kfree(finfo);
+			}
 		}
 	}
 
@@ -1444,12 +1446,14 @@ dfl_fpga_feature_devs_enumerate(struct dfl_fpga_enum_info *info)
 	 * start enumeration for all feature devices based on Device Feature
 	 * Lists.
 	 */
-	list_for_each_entry(dfl, &info->dfls, node) {
-		ret = parse_feature_list(binfo, dfl->start, dfl->len);
-		if (ret) {
-			remove_feature_devs(cdev);
-			build_info_free(binfo);
-			goto unregister_region_exit;
+	if (!list_empty(&info->dfls)) {
+		list_for_each_entry(dfl, &info->dfls, node) {
+			ret = parse_feature_list(binfo, dfl->start, dfl->len);
+			if (ret) {
+				remove_feature_devs(cdev);
+				build_info_free(binfo);
+				goto unregister_region_exit;
+			}
 		}
 	}
 
diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
index 83c2c50975e5..08edaeeb7f80 100644
--- a/drivers/fpga/dfl.h
+++ b/drivers/fpga/dfl.h
@@ -421,6 +421,13 @@ static inline bool dfl_feature_is_port(void __iomem *base)
 		(FIELD_GET(DFH_ID, v) == DFH_ID_FIU_PORT);
 }
 
+static inline bool dfl_feature_is_afu(void __iomem *base)
+{
+	u64 v = readq(base + DFH);
+
+	return (FIELD_GET(DFH_TYPE, v) == DFH_TYPE_AFU);
+}
+
 static inline u8 dfl_feature_revision(void __iomem *base)
 {
 	return (u8)FIELD_GET(DFH_REVISION, readq(base + DFH));
-- 
2.26.2


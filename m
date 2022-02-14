Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB41D4B4F4C
	for <lists+linux-fpga@lfdr.de>; Mon, 14 Feb 2022 12:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352225AbiBNLjp (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 14 Feb 2022 06:39:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352040AbiBNLja (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 14 Feb 2022 06:39:30 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272F5E0DA;
        Mon, 14 Feb 2022 03:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644838190; x=1676374190;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GVA2HyRU3/ajvARmfnCSRplK7C2pWCzhOUpUp/it5+c=;
  b=HR02gycDgQcunl+0FFC76j5vrzy03mXTJXPpz6qslCf/Y2pt2LE76ivj
   ks3szI31XFfAaxyKDDygmGxusOkkqLUji0MqS9fpSX+3QAszDjaTZmOSW
   6R0WteyQWByHtgXK5iUf7+GVo9XYHU6PqnHwOPh1BUpCmUBKFBCkSatop
   bPfX/ivjVkTKwxOW/Ccaj0aCgPCSlsvMqG9C2tbCb2kflaBXLq6stCfuW
   IEdEBcjf6HAVNfeUjNE60kbFEKOQB41n6BLP2j3lCsssGZwpqGOLmcZEC
   lZ5HMP5s/oeFuwFufoCLLq/b+iES0R4KrILE97v3LK1TSX2Ap3IkRqLe5
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="250276748"
X-IronPort-AV: E=Sophos;i="5.88,367,1635231600"; 
   d="scan'208";a="250276748"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 03:29:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,367,1635231600"; 
   d="scan'208";a="587167044"
Received: from unknown (HELO localhost.localdomain.sh.intel.com) ([10.238.175.107])
  by fmsmga008.fm.intel.com with ESMTP; 14 Feb 2022 03:29:47 -0800
From:   Tianfei zhang <tianfei.zhang@intel.com>
To:     hao.wu@intel.com, trix@redhat.com, mdf@kernel.org,
        yilun.xu@intel.com, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     corbet@lwn.net, Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Tianfei Zhang <tianfei.zhang@intel.com>
Subject: [PATCH v1 6/7] fpga: dfl: Handle dfl's starting with AFU
Date:   Mon, 14 Feb 2022 06:26:18 -0500
Message-Id: <20220214112619.219761-7-tianfei.zhang@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220214112619.219761-1-tianfei.zhang@intel.com>
References: <20220214112619.219761-1-tianfei.zhang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Matthew Gerlach <matthew.gerlach@linux.intel.com>

Allow for a Device Feature List (DFL) to start with
a Device Feature Header (DFH) of type Accelerator Function Unit (AFU)
by doing nothing.  This allows for PCIe VFs to be created.

Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
---
 drivers/fpga/dfl-pci.c |  7 ++++++-
 drivers/fpga/dfl.c     | 23 ++++++++++++++---------
 2 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
index 8abd9b408403..83b604d6dbe6 100644
--- a/drivers/fpga/dfl-pci.c
+++ b/drivers/fpga/dfl-pci.c
@@ -277,7 +277,12 @@ static int find_dfls_by_default(struct pci_dev *pcidev,
 
 		dfl_fpga_enum_info_add_dfl(info, start, len);
 	} else {
-		ret = -ENODEV;
+		v = readq(base + DFH);
+		if (FIELD_GET(DFH_TYPE, v) != DFH_TYPE_AFU) {
+			dev_info(&pcidev->dev, "Unknown feature type 0x%llx id 0x%llx\n",
+				 FIELD_GET(DFH_TYPE, v), FIELD_GET(DFH_ID, v));
+			ret = -ENODEV;
+		}
 	}
 
 	/* release I/O mappings for next step enumeration */
diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index a5263ac258c5..25bd24a4cca0 100644
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
 
@@ -1437,6 +1439,7 @@ dfl_fpga_feature_devs_enumerate(struct dfl_fpga_enum_info *info)
 
 	binfo->dev = info->dev;
 	binfo->cdev = cdev;
+	INIT_LIST_HEAD(&binfo->sub_features);
 
 	binfo->nr_irqs = info->nr_irqs;
 	if (info->nr_irqs)
@@ -1446,12 +1449,14 @@ dfl_fpga_feature_devs_enumerate(struct dfl_fpga_enum_info *info)
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
 
-- 
2.17.1


Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD864C3C4A
	for <lists+linux-fpga@lfdr.de>; Fri, 25 Feb 2022 04:17:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233737AbiBYDPI (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 24 Feb 2022 22:15:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236954AbiBYDN4 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 24 Feb 2022 22:13:56 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB3E7DA91;
        Thu, 24 Feb 2022 19:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645758804; x=1677294804;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+6kBKmZZxOFTdF4b8FToTP7Rqc52r8lXs4pLygIIL88=;
  b=d82ae4h7WDvgclgehNofPHRWwAnzkHwGg0eYlzjiT/7gN0lmVsXxui/G
   oxzArSMVesZlBYl40HDy5jSXZk+bCeXHvnISfDSq4BQkSIsckPQixP0me
   rqHPrgyPytOhPemcDQbf09eTfT/N480R+rnvaEG4Ln+xmHv+elKnqmUVc
   ERkHPS250OXQe6HKRfJiCw8OzA4r+h7M+50oYnTowuIDQDn8BIqcZeZSa
   8uIB+sDAEF0zxPGNR+/rEbWULmCP89gCYC+5PMa0jzi3JVax2QJgHspGb
   Hv+hbVbT7lm0G9/RiycYT5J5bUY+Aon1wXfftCmtC4BkSE8Y//kMeDN+l
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="252603001"
X-IronPort-AV: E=Sophos;i="5.90,135,1643702400"; 
   d="scan'208";a="252603001"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 19:13:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,135,1643702400"; 
   d="scan'208";a="684512494"
Received: from unknown (HELO localhost.localdomain.sh.intel.com) ([10.238.175.107])
  by fmsmga001.fm.intel.com with ESMTP; 24 Feb 2022 19:13:21 -0800
From:   Tianfei zhang <tianfei.zhang@intel.com>
To:     hao.wu@intel.com, trix@redhat.com, mdf@kernel.org,
        yilun.xu@intel.com, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     corbet@lwn.net, Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Tianfei Zhang <tianfei.zhang@intel.com>
Subject: [PATCH v2 4/5] fpga: dfl: Handle dfl's starting with AFU
Date:   Thu, 24 Feb 2022 22:10:01 -0500
Message-Id: <20220225031002.261264-5-tianfei.zhang@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220225031002.261264-1-tianfei.zhang@intel.com>
References: <20220225031002.261264-1-tianfei.zhang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
by doing nothing. This allows for PCIe VFs to be created.

Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
---
 drivers/fpga/dfl-pci.c |  7 ++++++-
 drivers/fpga/dfl.c     | 22 +++++++++++++---------
 2 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
index 33545c999c06..e7d58e7b1bbd 100644
--- a/drivers/fpga/dfl-pci.c
+++ b/drivers/fpga/dfl-pci.c
@@ -275,7 +275,12 @@ static int find_dfls_by_default(struct pci_dev *pcidev,
 
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
index afa9311c30d5..8a71ff6c3e2f 100644
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
 
@@ -1445,12 +1447,14 @@ dfl_fpga_feature_devs_enumerate(struct dfl_fpga_enum_info *info)
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
2.26.2


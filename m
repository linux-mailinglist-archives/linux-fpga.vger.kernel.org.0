Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 405454C8400
	for <lists+linux-fpga@lfdr.de>; Tue,  1 Mar 2022 07:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbiCAGZ4 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 1 Mar 2022 01:25:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbiCAGZr (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 1 Mar 2022 01:25:47 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD6E75E78;
        Mon, 28 Feb 2022 22:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646115895; x=1677651895;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uwzgygXogsb3bqCFgrX+F95j5uwutR+YBSqegpN8vdM=;
  b=Lo1RUrJEUa4viAw9yaWTOh76HS8BI0rakYloV645pB41Rl2Ueu4dTB0a
   hRpZBnUlvugDKIBNmu7MXcHRaxtiCq/qrdQ8LrsBRecUK8girIGzqTqda
   fl2aVDmZicjQofDEIsc+cfisENM28e325FemZfsn/lI2osPEYU223WfIA
   VSQ6wP//qRy+vTo5LwBaYw5J6+p9QP4fIUbvD0AEC6eU+d5tdvcGdIH3u
   MWEqRytIICe6uoTqGZgUT9KjlBaqkeV8u6G8CeDoZPbGwGfwl1oS93q/j
   MOGkXaXBNNlaSmA8JV/YqWdeew8GmzAVI/q6RzfKXhdg/PcZMkJ6rUWnp
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="251900328"
X-IronPort-AV: E=Sophos;i="5.90,145,1643702400"; 
   d="scan'208";a="251900328"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 22:24:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,145,1643702400"; 
   d="scan'208";a="708941793"
Received: from unknown (HELO localhost.localdomain.sh.intel.com) ([10.238.175.107])
  by orsmga005.jf.intel.com with ESMTP; 28 Feb 2022 22:24:45 -0800
From:   Tianfei zhang <tianfei.zhang@intel.com>
To:     hao.wu@intel.com, trix@redhat.com, mdf@kernel.org,
        yilun.xu@intel.com, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, corbet@lwn.net,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Tianfei Zhang <tianfei.zhang@intel.com>
Subject: [PATCH v3 4/5] fpga: dfl: Handle dfl's starting with AFU
Date:   Tue,  1 Mar 2022 01:21:22 -0500
Message-Id: <20220301062123.818687-5-tianfei.zhang@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220301062123.818687-1-tianfei.zhang@intel.com>
References: <20220301062123.818687-1-tianfei.zhang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
index fd04ef5c8b03..e30bbb3039cd 100644
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
 
@@ -1439,12 +1441,14 @@ dfl_fpga_feature_devs_enumerate(struct dfl_fpga_enum_info *info)
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


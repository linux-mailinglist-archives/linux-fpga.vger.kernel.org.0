Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A16CE4C80E8
	for <lists+linux-fpga@lfdr.de>; Tue,  1 Mar 2022 03:15:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbiCACOm (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 28 Feb 2022 21:14:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232096AbiCACOj (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 28 Feb 2022 21:14:39 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7CE23B57E;
        Mon, 28 Feb 2022 18:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646100839; x=1677636839;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oML+dI1CVtJvKKqi9bf8PECz0JNmrZ3/qP4u4OOOFUw=;
  b=lqyFPpV7IfDZiuW+IleRFpuu1BmYS2ME57pbcLXAnMpbG0to2w5k9AcG
   xfoSG6UrTyA5xnzd7FhNx1y5p3F3vi1mBXUL5M5SM8bRxOLEqVCQFDkc6
   2UGKbQUnC6ESEaOB6IDoVKzoVqyJyaMAn4x99vwFV5X4u5DfHvdETH1rM
   DleVHqAhsYfmF5x89Semb7+YSM+mwbtzLPpcf91AePof8NkAcDfWViU3W
   +fSCVCZ1wen65xik5HRrQTb2lA7WQ9RQw4Sv9vuEobGaitl1pLzFn3JmJ
   l653ZtiVDYJBuDfzMAgmbLq+5k8tFQioRlT9MTzq/M0RpL37Ikj8PXg8u
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="313757260"
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="313757260"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 18:13:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="708883534"
Received: from unknown (HELO localhost.localdomain.sh.intel.com) ([10.238.175.107])
  by orsmga005.jf.intel.com with ESMTP; 28 Feb 2022 18:13:43 -0800
From:   Tianfei zhang <tianfei.zhang@intel.com>
To:     hao.wu@intel.com, trix@redhat.com, mdf@kernel.org,
        yilun.xu@intel.com, linux-fpga@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, Tianfei Zhang <tianfei.zhang@intel.com>
Subject: [PATCH v2] fpga: dfl: check feature type before parse irq info
Date:   Mon, 28 Feb 2022 21:10:33 -0500
Message-Id: <20220301021033.589673-1-tianfei.zhang@intel.com>
X-Mailer: git-send-email 2.26.2
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

From: Tianfei Zhang <tianfei.zhang@intel.com>

The feature ID of "Port User Interrupt" and the
"PMCI Subsystem" are identical, 0x12, but one is for FME,
other is for Port. It should check the feature type While
parsing the irq info in parse_feature_irqs().

Fixes: 8d021039cbb5 ("fpga: dfl: parse interrupt info for feature devices on enumeration")
Link: https://lore.kernel.org/linux-fpga/BN9PR11MB54833D7636348D62F931526CE33A9@BN9PR11MB5483.namprd11.prod.outlook.com/

---
v2:
add DFL Feature ID Registry in documentation.

Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
---
 Documentation/fpga/dfl.rst | 11 +++++++++++
 drivers/fpga/dfl.c         | 38 ++++++++++++++++++++++----------------
 2 files changed, 33 insertions(+), 16 deletions(-)

diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
index ef9eec71f6f3..14f342bb85e4 100644
--- a/Documentation/fpga/dfl.rst
+++ b/Documentation/fpga/dfl.rst
@@ -502,6 +502,17 @@ Developer only needs to provide a sub feature driver with matched feature id.
 FME Partial Reconfiguration Sub Feature driver (see drivers/fpga/dfl-fme-pr.c)
 could be a reference.
 
+Individual DFL drivers are bound DFL devices based on Feature Type and Feature ID.
+The definition of Feature Type and Feature ID can be found:
+
+https://github.com/OPAE/linux-dfl-feature-id/blob/master/dfl-feature-ids.rst
+
+If you want to add a new feature ID for FPGA DFL feature device, we recommend that
+use a pull request to reserve a feature ID for DFL. Here is the DFL Feature ID
+Registry:
+
+https://github.com/OPAE/linux-dfl-feature-id
+
 Location of DFLs on a PCI Device
 ================================
 The original method for finding a DFL on a PCI device assumed the start of the
diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index 599bb21d86af..6bff39ff21a0 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -940,9 +940,12 @@ static int parse_feature_irqs(struct build_feature_devs_info *binfo,
 {
 	void __iomem *base = binfo->ioaddr + ofst;
 	unsigned int i, ibase, inr = 0;
+	enum dfl_id_type type;
 	int virq;
 	u64 v;
 
+	type = feature_dev_id_type(binfo->feature_dev);
+
 	/*
 	 * Ideally DFL framework should only read info from DFL header, but
 	 * current version DFL only provides mmio resources information for
@@ -957,22 +960,25 @@ static int parse_feature_irqs(struct build_feature_devs_info *binfo,
 	 * code will be added. But in order to be compatible to old version
 	 * DFL, the driver may still fall back to these quirks.
 	 */
-	switch (fid) {
-	case PORT_FEATURE_ID_UINT:
-		v = readq(base + PORT_UINT_CAP);
-		ibase = FIELD_GET(PORT_UINT_CAP_FST_VECT, v);
-		inr = FIELD_GET(PORT_UINT_CAP_INT_NUM, v);
-		break;
-	case PORT_FEATURE_ID_ERROR:
-		v = readq(base + PORT_ERROR_CAP);
-		ibase = FIELD_GET(PORT_ERROR_CAP_INT_VECT, v);
-		inr = FIELD_GET(PORT_ERROR_CAP_SUPP_INT, v);
-		break;
-	case FME_FEATURE_ID_GLOBAL_ERR:
-		v = readq(base + FME_ERROR_CAP);
-		ibase = FIELD_GET(FME_ERROR_CAP_INT_VECT, v);
-		inr = FIELD_GET(FME_ERROR_CAP_SUPP_INT, v);
-		break;
+	if (type == PORT_ID) {
+		switch (fid) {
+		case PORT_FEATURE_ID_UINT:
+			v = readq(base + PORT_UINT_CAP);
+			ibase = FIELD_GET(PORT_UINT_CAP_FST_VECT, v);
+			inr = FIELD_GET(PORT_UINT_CAP_INT_NUM, v);
+			break;
+		case PORT_FEATURE_ID_ERROR:
+			v = readq(base + PORT_ERROR_CAP);
+			ibase = FIELD_GET(PORT_ERROR_CAP_INT_VECT, v);
+			inr = FIELD_GET(PORT_ERROR_CAP_SUPP_INT, v);
+			break;
+		}
+	} else if (type == FME_ID) {
+		if (fid == FME_FEATURE_ID_GLOBAL_ERR) {
+			v = readq(base + FME_ERROR_CAP);
+			ibase = FIELD_GET(FME_ERROR_CAP_INT_VECT, v);
+			inr = FIELD_GET(FME_ERROR_CAP_SUPP_INT, v);
+		}
 	}
 
 	if (!inr) {
-- 
2.26.2


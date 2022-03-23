Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1F44E4EC3
	for <lists+linux-fpga@lfdr.de>; Wed, 23 Mar 2022 09:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242941AbiCWI4W (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 23 Mar 2022 04:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234460AbiCWI4V (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 23 Mar 2022 04:56:21 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F59F53B50;
        Wed, 23 Mar 2022 01:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648025692; x=1679561692;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=27fhujJg9XeamIFp4xQX/ElmnkUA7hiBTOhcEq2lNV4=;
  b=Nt4sdOhT1IxkrdWCQMAils+ZxBeujJBI6seyflePSC04KxkkQRM5Eiiq
   iP1atdwySIktsqGjn12ynrMG1Mlq8qwKYg9KyCkxK6A875+019JNC1naR
   Pm8zKnxt37x2/RqZJYmJ8RyPejhcq03+kHScwV4zef32Pt2QR2f0bR4AU
   QtZfzvTLQnrL9pAAr5e6MVvV+jRlmRef3o8KpGkNImQmUyfPSiBbTlwAu
   tBnA1D7levyOVHIUUzTGoNVnd+QG8Nq9zO6tutggt3i4vBJbDADnMzNhL
   fZoLFsbnKK80VwoqXOfxNG8oyWskmHuD+RGsmpdkjcaXzWr+zlYsgzGti
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10294"; a="258010493"
X-IronPort-AV: E=Sophos;i="5.90,203,1643702400"; 
   d="scan'208";a="258010493"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 01:54:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,203,1643702400"; 
   d="scan'208";a="717315443"
Received: from unknown (HELO localhost.localdomain.sh.intel.com) ([10.238.175.107])
  by orsmga005.jf.intel.com with ESMTP; 23 Mar 2022 01:54:27 -0700
From:   Tianfei Zhang <tianfei.zhang@intel.com>
To:     hao.wu@intel.com, trix@redhat.com, mdf@kernel.org,
        yilun.xu@intel.com, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     corbet@lwn.net, rdunlap@infradead.org,
        Tianfei zhang <tianfei.zhang@intel.com>
Subject: [PATCH v5 1/2] fpga: dfl: check feature type before parse irq info
Date:   Wed, 23 Mar 2022 04:51:01 -0400
Message-Id: <20220323085102.2297964-2-tianfei.zhang@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220323085102.2297964-1-tianfei.zhang@intel.com>
References: <20220323085102.2297964-1-tianfei.zhang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Tianfei zhang <tianfei.zhang@intel.com>

Previously the feature IDs defined are unique, no matter
which feature type. But currently we want to extend its
usage to have a per-type feature ID space, so this patch
adds feature type checking as well just before look into
feature ID for different features which have irq info.

Signed-off-by: Tianfei zhang <tianfei.zhang@intel.com>
---
v4:
  - Fix the git commit from Hao's comments.
  - Split documentation into another patch.
v3:
  - Remove "Fixes" in commit log with Hao's comment, this is a
    extension not a bug fix.
v2:
  - add DFL Feature ID Registry in documentation.
---
 drivers/fpga/dfl.c | 38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

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


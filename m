Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE3A74B4EFE
	for <lists+linux-fpga@lfdr.de>; Mon, 14 Feb 2022 12:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352168AbiBNLjn (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 14 Feb 2022 06:39:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351978AbiBNLja (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 14 Feb 2022 06:39:30 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA6FBF54;
        Mon, 14 Feb 2022 03:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644838179; x=1676374179;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=W/BuSL2ztgck7pI4bKqfzYgV6SD1PByKo0yDS6YFAvM=;
  b=kWaBzsfZDnPZiamSMsDiPc9pO/zLu6tflW3pHZQ4PzSkri7mPNKb8KpV
   2KioEe51A5gf5NnS649M8VbeO4+Ve9m70D6VsL186J3UiYofRZlVja8XM
   BcBE1thBiGoQ01NHGEKg0iYZxelmWNrRY+dcLgghTBP9BlbFxNeqdW+6X
   +5SjUthcdzWdfqxx/4MJ7OSW0Pi/iMi9SQvnVHbQkAIWE/11Ma9X2ZjXk
   l7AALrT+ba6zHFQ0dVg3HnB21WpCnxU/Hx1ndVM8FvwQzJMQgD3ek8tn6
   t0csY+7MBSmszDCfI3Vi3MDseaFGeUqj9aWz1aOZimvcx1l2vKU5rPyTA
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="250276732"
X-IronPort-AV: E=Sophos;i="5.88,367,1635231600"; 
   d="scan'208";a="250276732"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 03:29:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,367,1635231600"; 
   d="scan'208";a="587166995"
Received: from unknown (HELO localhost.localdomain.sh.intel.com) ([10.238.175.107])
  by fmsmga008.fm.intel.com with ESMTP; 14 Feb 2022 03:29:37 -0800
From:   Tianfei zhang <tianfei.zhang@intel.com>
To:     hao.wu@intel.com, trix@redhat.com, mdf@kernel.org,
        yilun.xu@intel.com, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     corbet@lwn.net, Tianfei Zhang <tianfei.zhang@intel.com>
Subject: [PATCH v1 2/7] fpga: dfl: check feature type before parse irq info
Date:   Mon, 14 Feb 2022 06:26:14 -0500
Message-Id: <20220214112619.219761-3-tianfei.zhang@intel.com>
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

From: Tianfei Zhang <tianfei.zhang@intel.com>

The feature ID of "Port User Interrupt" and the
"PMCI Subsystem" are identical, 0x12, but one is for FME,
other is for Port. It should check the feature type While
parsing the irq info in parse_feature_irqs().

Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
---
 drivers/fpga/dfl.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index 599bb21d86af..26f8cf890700 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -940,9 +940,14 @@ static int parse_feature_irqs(struct build_feature_devs_info *binfo,
 {
 	void __iomem *base = binfo->ioaddr + ofst;
 	unsigned int i, ibase, inr = 0;
+	enum dfl_id_type type;
 	int virq;
 	u64 v;
 
+	type = feature_dev_id_type(binfo->feature_dev);
+	if (type >= DFL_ID_MAX)
+		return -EINVAL;
+
 	/*
 	 * Ideally DFL framework should only read info from DFL header, but
 	 * current version DFL only provides mmio resources information for
@@ -959,16 +964,22 @@ static int parse_feature_irqs(struct build_feature_devs_info *binfo,
 	 */
 	switch (fid) {
 	case PORT_FEATURE_ID_UINT:
+		if (type != PORT_ID)
+			break;
 		v = readq(base + PORT_UINT_CAP);
 		ibase = FIELD_GET(PORT_UINT_CAP_FST_VECT, v);
 		inr = FIELD_GET(PORT_UINT_CAP_INT_NUM, v);
 		break;
 	case PORT_FEATURE_ID_ERROR:
+		if (type != PORT_ID)
+			break;
 		v = readq(base + PORT_ERROR_CAP);
 		ibase = FIELD_GET(PORT_ERROR_CAP_INT_VECT, v);
 		inr = FIELD_GET(PORT_ERROR_CAP_SUPP_INT, v);
 		break;
 	case FME_FEATURE_ID_GLOBAL_ERR:
+		if (type != FME_ID)
+			break;
 		v = readq(base + FME_ERROR_CAP);
 		ibase = FIELD_GET(FME_ERROR_CAP_INT_VECT, v);
 		inr = FIELD_GET(FME_ERROR_CAP_SUPP_INT, v);
-- 
2.17.1


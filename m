Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8DDD6524C8
	for <lists+linux-fpga@lfdr.de>; Tue, 20 Dec 2022 17:38:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234007AbiLTQgh (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 20 Dec 2022 11:36:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233952AbiLTQge (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 20 Dec 2022 11:36:34 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8353BCE2;
        Tue, 20 Dec 2022 08:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671554193; x=1703090193;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RoMkMX9ThmoZuoFVP+EN5cdp+nSCRgkililzuZ0lkfk=;
  b=gkMrt1Aao9AuqV0CTBUwSp+Up6OqEBONX3h1zvFSTnU6mbjcGQnwcU38
   yFtcgVN6imvhPUI2W+d8OZBgpIvkXJt3BouwzV7o7UbwPT9YoFcSNqGB7
   LdhPeiS1XpTSAlj7u6RJSSK4tiD6f25X5syoJ3lPdNZK1X2nw695lSYvn
   Dw/RvGFYupCCZSXEYbd0VCwHsJR2S4VcCfV7x4POJEzxl4vTieieqRyFP
   EBpKbQaImob7LqtxvLACB+YI0l/zkMY7TzARaJ/75+zLvYApB50RlU6gS
   pMU63KhK2LOBYYRAtZB4cLbhrHemUpLE8rwwkENUG5aObw8GQpj+hgFXY
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="317292841"
X-IronPort-AV: E=Sophos;i="5.96,259,1665471600"; 
   d="scan'208";a="317292841"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2022 08:36:32 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="896528221"
X-IronPort-AV: E=Sophos;i="5.96,259,1665471600"; 
   d="scan'208";a="896528221"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.139])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2022 08:36:31 -0800
From:   matthew.gerlach@linux.intel.com
To:     hao.wu@intel.com, yilun.xu@intel.com, russell.h.weight@intel.com,
        basheer.ahmed.muddebihal@intel.com, trix@redhat.com,
        mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tianfei.zhang@intel.com, corbet@lwn.net,
        gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        jirislaby@kernel.org, geert+renesas@glider.be,
        andriy.shevchenko@linux.intel.com,
        niklas.soderlund+renesas@ragnatech.se, macro@orcam.me.uk,
        johan@kernel.org, lukas@wunner.de, ilpo.jarvinen@linux.intel.com,
        marpagan@redhat.com, bagasdotme@gmail.com
Cc:     Basheer Ahmed Muddebihal 
        <basheer.ahmed.muddebihal@linux.intel.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: [PATCH v7 2/4] fpga: dfl: Add DFHv1 Register Definitions
Date:   Tue, 20 Dec 2022 08:36:50 -0800
Message-Id: <20221220163652.499831-3-matthew.gerlach@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221220163652.499831-1-matthew.gerlach@linux.intel.com>
References: <20221220163652.499831-1-matthew.gerlach@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Basheer Ahmed Muddebihal <basheer.ahmed.muddebihal@linux.intel.com>

This patch adds the definitions for DFHv1 header and related register
bitfields.

Signed-off-by: Basheer Ahmed Muddebihal <basheer.ahmed.muddebihal@linux.intel.com>
Co-developed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
v7: no change

v6: remove parameter definitions from include/linux/dfl.h

v5: consistently use fields for parameter data
    s/EOL/EOP/ to match doc
    remove unneeded mask
    added Co-developed-by

v4: s/MSIX/MSI_X/g
    move kerneldoc to implementation
    don't change copyright date

v3:
    keep DFHv1 definitions "hidden" in drivers/fpga/dfl.h

v2: clean up white space and one line comments
    remove extra space in commit
    use uniform number of digits in constants
    don't change copyright date because of removed content
---
 drivers/fpga/dfl.h | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
index 06cfcd5e84bb..fc59f33367ee 100644
--- a/drivers/fpga/dfl.h
+++ b/drivers/fpga/dfl.h
@@ -74,11 +74,43 @@
 #define DFH_REVISION		GENMASK_ULL(15, 12)	/* Feature revision */
 #define DFH_NEXT_HDR_OFST	GENMASK_ULL(39, 16)	/* Offset to next DFH */
 #define DFH_EOL			BIT_ULL(40)		/* End of list */
+#define DFH_VERSION		GENMASK_ULL(59, 52)	/* DFH version */
 #define DFH_TYPE		GENMASK_ULL(63, 60)	/* Feature type */
 #define DFH_TYPE_AFU		1
 #define DFH_TYPE_PRIVATE	3
 #define DFH_TYPE_FIU		4
 
+/*
+ * DFHv1 Register Offset definitons
+ * In DHFv1, DFH + GUID + CSR_START + CSR_SIZE_GROUP + PARAM_HDR + PARAM_DATA
+ * as common header registers
+ */
+#define DFHv1_CSR_ADDR		0x18  /* CSR Register start address */
+#define DFHv1_CSR_SIZE_GRP	0x20  /* Size of Reg Block and Group/tag */
+#define DFHv1_PARAM_HDR		0x28  /* Optional First Param header */
+
+/*
+ * CSR Rel Bit, 1'b0 = relative (offset from feature DFH start),
+ * 1'b1 = absolute (ARM or other non-PCIe use)
+ */
+#define DFHv1_CSR_ADDR_REL	BIT_ULL(0)
+
+/* CSR Header Register Bit Definitions */
+#define DFHv1_CSR_ADDR_MASK       GENMASK_ULL(63, 1)  /* 63:1 of CSR address */
+
+/* CSR SIZE Goup Register Bit Definitions */
+#define DFHv1_CSR_SIZE_GRP_INSTANCE_ID	GENMASK_ULL(15, 0)	/* Enumeration instantiated IP */
+#define DFHv1_CSR_SIZE_GRP_GROUPING_ID	GENMASK_ULL(30, 16)	/* Group Features/interfaces */
+#define DFHv1_CSR_SIZE_GRP_HAS_PARAMS	BIT_ULL(31)		/* Presence of Parameters */
+#define DFHv1_CSR_SIZE_GRP_SIZE		GENMASK_ULL(63, 32)	/* Size of CSR Block in bytes */
+
+/* PARAM Header Register Bit Definitions */
+#define DFHv1_PARAM_HDR_ID		GENMASK_ULL(15, 0) /* Id of this Param  */
+#define DFHv1_PARAM_HDR_VER		GENMASK_ULL(31, 16) /* Version Param */
+#define DFHv1_PARAM_HDR_NEXT_OFFSET	GENMASK_ULL(63, 35) /* Offset of next Param */
+#define DFHv1_PARAM_HDR_NEXT_EOP	BIT_ULL(32)
+#define DFHv1_PARAM_DATA		0x08  /* Offset of Param data from Param header */
+
 /* Next AFU Register Bitfield */
 #define NEXT_AFU_NEXT_DFH_OFST	GENMASK_ULL(23, 0)	/* Offset to next AFU */
 
-- 
2.25.1


Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D27A648A46
	for <lists+linux-fpga@lfdr.de>; Fri,  9 Dec 2022 22:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbiLIVpe (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 9 Dec 2022 16:45:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiLIVpE (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 9 Dec 2022 16:45:04 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 293503D388;
        Fri,  9 Dec 2022 13:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670622304; x=1702158304;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+Troux3plCX6Y7bEBUpvaNT3RYvxGKTZirOxEMP6luE=;
  b=F3zquobitMngiZSbxEo4KanY6JtWTI6QwlsMjUxbxq2UhTRCoeUr+zcz
   C/q6b2SMrnh9fx7qR7cExxD9XbH+Jzu5b/wN40q+Al+KfYRvshzMy8e2Q
   SLZFzzMtalQghiqNEL4esA+ubbpBgZQDYKgDv6cELxKajHlDQeZU4h4Dr
   cAfEIBSAXimVtmrVoREGC4NK2PWIVreSrVLs6dtAobyOkMpZFTzPmeloZ
   Atf8wRmBhAbIgVPOd5iZEO7qg4nDYwsAygSYDADB+vStbSD7EQUwusHVM
   scvpX7kaRr6akeBkUCd3mfhJTuX4w2JJfEAOgfk6jxFfMtPF76dD8yNYD
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="300975543"
X-IronPort-AV: E=Sophos;i="5.96,232,1665471600"; 
   d="scan'208";a="300975543"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2022 13:45:03 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="711031700"
X-IronPort-AV: E=Sophos;i="5.96,232,1665471600"; 
   d="scan'208";a="711031700"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.139])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2022 13:45:01 -0800
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
        marpagan@redhat.com
Cc:     Basheer Ahmed Muddebihal 
        <basheer.ahmed.muddebihal@linux.intel.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: [PATCH v6 2/4] fpga: dfl: Add DFHv1 Register Definitions
Date:   Fri,  9 Dec 2022 13:45:21 -0800
Message-Id: <20221209214523.3484193-3-matthew.gerlach@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221209214523.3484193-1-matthew.gerlach@linux.intel.com>
References: <20221209214523.3484193-1-matthew.gerlach@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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

v2: clean up whitespace and one line comments
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


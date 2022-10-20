Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1841606A3C
	for <lists+linux-fpga@lfdr.de>; Thu, 20 Oct 2022 23:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbiJTV0A (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 20 Oct 2022 17:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiJTVZ6 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 20 Oct 2022 17:25:58 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0BA180597;
        Thu, 20 Oct 2022 14:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666301157; x=1697837157;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RX2JNyvAov8v89XYF6H5UlH6Cd9vaxEM+damP0WRpBM=;
  b=kSmsRe053I1hTu7EHDjVe5xbu6eKTOg9hpeIAzWvWmNeoM6bPBqXgWz3
   1r3MhyTyr24c/TIQJHekuq53JbQP3ohEXmrbOZp3rq7qxQYZDbNE1W0yP
   bYiHT86xsbeSryJ2RJMIEautxd2H5PZHuGiWXo2LyN53zhIXamj0vw44+
   NKv7Cy6CQGaQhU4k6RLsZyQaBPYC9aVNC8eG5oTgzuzsMEjwO+pHCGs3s
   3h0DwUs6BjOnt0bsh0wVrRyPsmBH/55UHDrCXrqFj2N2oOHU9jLCvIAk2
   k38gdJpSCYG+DE/lwsHPkvPLO5aLfl6JTIkQ6jyLpfrusmOHht+fGum6r
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="333412435"
X-IronPort-AV: E=Sophos;i="5.95,199,1661842800"; 
   d="scan'208";a="333412435"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 14:25:56 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="693260674"
X-IronPort-AV: E=Sophos;i="5.95,199,1661842800"; 
   d="scan'208";a="693260674"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.139])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 14:25:56 -0700
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
Subject: [PATCH v4 2/4] fpga: dfl: Add DFHv1 Register Definitions
Date:   Thu, 20 Oct 2022 14:26:08 -0700
Message-Id: <20221020212610.697729-3-matthew.gerlach@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221020212610.697729-1-matthew.gerlach@linux.intel.com>
References: <20221020212610.697729-1-matthew.gerlach@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Basheer Ahmed Muddebihal <basheer.ahmed.muddebihal@linux.intel.com>

This patch adds the definitions for DFHv1 header and related register
bitfields.

Signed-off-by: Basheer Ahmed Muddebihal <basheer.ahmed.muddebihal@linux.intel.com>
Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
---
v4: s/MSIX/MSI_X/g
    move kerneldoc to implementation
    don't change copyright date

v3:
    keep DFHv1 definitions "hidden" in drivers/fpga/dfl.h

v2: clean up whitespace and one line comments
    remove extra space in commit
    use uniform number of digits in constants
    don't change copyright date because of removed content

dfl.h s/MSIX/MSI_X/g move kerneldoc
---
 drivers/fpga/dfl.h  | 33 +++++++++++++++++++++++++++++++++
 include/linux/dfl.h | 11 +++++++++++
 2 files changed, 44 insertions(+)

diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
index 06cfcd5e84bb..45e6e1359a67 100644
--- a/drivers/fpga/dfl.h
+++ b/drivers/fpga/dfl.h
@@ -74,11 +74,44 @@
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
+#define DFHv1_PARAM_HDR_VERSION		GENMASK_ULL(31, 16) /* Version Param */
+#define DFHv1_PARAM_HDR_NEXT_OFFSET	GENMASK_ULL(63, 32) /* Offset of next Param */
+#define DFHv1_PARAM_HDR_NEXT_EOL	BIT_ULL(0)
+#define DFHv1_PARAM_HDR_NEXT_MASK	GENMASK_ULL(1, 0)
+#define DFHv1_PARAM_DATA		0x08  /* Offset of Param data from Param header */
+
 /* Next AFU Register Bitfield */
 #define NEXT_AFU_NEXT_DFH_OFST	GENMASK_ULL(23, 0)	/* Offset to next AFU */
 
diff --git a/include/linux/dfl.h b/include/linux/dfl.h
index 431636a0dc78..fea9e16d35b6 100644
--- a/include/linux/dfl.h
+++ b/include/linux/dfl.h
@@ -11,6 +11,17 @@
 #include <linux/device.h>
 #include <linux/mod_devicetable.h>
 
+#define DFHv1_PARAM_ID_MSI_X		0x1
+#define DFHv1_PARAM_MSI_X_STARTV	0x0
+#define DFHv1_PARAM_MSI_X_NUMV		0x4
+
+#define DFHv1_PARAM_ID_CLK_FRQ    0x2
+#define DFHv1_PARAM_ID_FIFO_LEN   0x3
+
+#define DFHv1_PARAM_ID_REG_LAYOUT 0x4
+#define DFHv1_PARAM_ID_REG_WIDTH  GENMASK_ULL(63, 32)
+#define DFHv1_PARAM_ID_REG_SHIFT  GENMASK_ULL(31, 0)
+
 /**
  * enum dfl_id_type - define the DFL FIU types
  */
-- 
2.25.1


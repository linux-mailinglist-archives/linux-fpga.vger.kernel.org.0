Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 049055F45B6
	for <lists+linux-fpga@lfdr.de>; Tue,  4 Oct 2022 16:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbiJDOh3 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 4 Oct 2022 10:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbiJDOhT (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 4 Oct 2022 10:37:19 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4D661B13;
        Tue,  4 Oct 2022 07:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664894229; x=1696430229;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ARB2SvnlASaDDAxVt9LNpxzaPU3/rmi8jFR9GIJ/Gm4=;
  b=CETUM8MREBsFsy0zci/oVejmkudgdkihuH5I7zDBOV7YRab2ETHi/3k/
   V4j/p/CyDK4aSvWiwo+6eTF1VRXEFGYQzcRkXe+l3/Wv9fCczmcw1OjAY
   3hCv0hN/qRqPgndpjoM9Zjp8rPdt5KgYO96F65oqiHJCBZ9sH7AUyO8Kg
   GqWKFCzZ0Xrk3F0zj9tFD1onCPaSmJvwTy4UrGkngkOAhhCey/SzRZcwc
   N8uzpWkJeCjEQvPXTi9neGCkoIXojeRPMugoYsKHeGtnCsSL8REGOj3uI
   5j5//22W9PCPIG7crENsB1fvtVO5KUuF4XZubx7bf9ph3tLGx+J0ayW89
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="389215869"
X-IronPort-AV: E=Sophos;i="5.95,158,1661842800"; 
   d="scan'208";a="389215869"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 07:37:05 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="869021629"
X-IronPort-AV: E=Sophos;i="5.95,158,1661842800"; 
   d="scan'208";a="869021629"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.139])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 07:37:04 -0700
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
        johan@kernel.org, lukas@wunner.de
Cc:     Basheer Ahmed Muddebihal 
        <basheer.ahmed.muddebihal@linux.intel.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: [PATCH v3 2/4] fpga: dfl: Add DFHv1 Register Definitions
Date:   Tue,  4 Oct 2022 07:37:16 -0700
Message-Id: <20221004143718.1076710-3-matthew.gerlach@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221004143718.1076710-1-matthew.gerlach@linux.intel.com>
References: <20221004143718.1076710-1-matthew.gerlach@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
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
Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
---
v3:
    keep DFHv1 definitions "hidden" in drivers/fpga/dfl.h

v2: clean up whitespace and one line comments
    remove extra space in commit
    use uniform number of digits in constants
    don't change copyright date because of removed content
---
 drivers/fpga/dfl.h  | 33 ++++++++++++++++++++++++++++++++-
 include/linux/dfl.h | 13 ++++++++++++-
 2 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
index 06cfcd5e84bb..bd8720bc5320 100644
--- a/drivers/fpga/dfl.h
+++ b/drivers/fpga/dfl.h
@@ -2,7 +2,7 @@
 /*
  * Driver Header File for FPGA Device Feature List (DFL) Support
  *
- * Copyright (C) 2017-2018 Intel Corporation, Inc.
+ * Copyright (C) 2017-2022 Intel Corporation, Inc.
  *
  * Authors:
  *   Kang Luwei <luwei.kang@intel.com>
@@ -74,11 +74,42 @@
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
+#define DFHv1_PARAM_DATA		0x08  /* Offset of Param data from Param header */
+
 /* Next AFU Register Bitfield */
 #define NEXT_AFU_NEXT_DFH_OFST	GENMASK_ULL(23, 0)	/* Offset to next AFU */
 
diff --git a/include/linux/dfl.h b/include/linux/dfl.h
index 431636a0dc78..1a1a2b894687 100644
--- a/include/linux/dfl.h
+++ b/include/linux/dfl.h
@@ -2,7 +2,7 @@
 /*
  * Header file for DFL driver and device API
  *
- * Copyright (C) 2020 Intel Corporation, Inc.
+ * Copyright (C) 2020-2022 Intel Corporation, Inc.
  */
 
 #ifndef __LINUX_DFL_H
@@ -11,6 +11,17 @@
 #include <linux/device.h>
 #include <linux/mod_devicetable.h>
 
+#define DFHv1_PARAM_ID_MSIX	0x1
+#define DFHv1_PARAM_MSIX_STARTV	0x0
+#define DFHv1_PARAM_MSIX_NUMV	0x4
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


Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D19345AF429
	for <lists+linux-fpga@lfdr.de>; Tue,  6 Sep 2022 21:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiIFTEc (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 6 Sep 2022 15:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiIFTEZ (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 6 Sep 2022 15:04:25 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB0B6443;
        Tue,  6 Sep 2022 12:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662491061; x=1694027061;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xz+4geY51LylIndKYTx2HwbrKO8DoCD/2r2Fypr/EGY=;
  b=GkoMcGc3n84Xr/D8llj8YCjn9zroURYcuyqtsGLGPnksGhDS+bbomih/
   z/LlrbDVw5Tf1imFlDWbS/XlKDov3bP/+uyMskmucOMATKtrwz5CTJHuS
   zsn8VBwNhq25EmEVBD7JW+CMYh0qvvQvDVvwqbGpTPolAK/pI/8UP+s0X
   xO6atkeWAuXA9O5ybd/5rfnL9RdBpeDIszeFY+4CQohUqKxRc/2M/Nc5F
   G+jLDUMHmNLpVxE/IjCSZGiMHSf/KhvUKym0rhzMg5ATTvPujfIjTXJzh
   iw+zDTHnEH8zWlCMgi57ePUndGxq6+SY+TZBtPkz2L5LkB+fhuf/FAP74
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="283677336"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="283677336"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 12:04:18 -0700
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="789782545"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.43])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 12:04:18 -0700
From:   matthew.gerlach@linux.intel.com
To:     hao.wu@intel.com, yilun.xu@intel.com, russell.h.weight@intel.com,
        basheer.ahmed.muddebihal@intel.com, trix@redhat.com,
        mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tianfei.zhang@intel.com, corbet@lwn.net,
        gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        jirislaby@kernel.org, geert+renesas@glider.be,
        andriy.shevchenko@linux.intel.com,
        niklas.soderlund+renesas@ragnatech.se, phil.edworthy@renesas.com,
        macro@orcam.me.uk, johan@kernel.org, lukas@wunner.de
Cc:     Basheer Ahmed Muddebihal 
        <basheer.ahmed.muddebihal@linux.intel.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: [PATCH v1 2/5] fpga: dfl: Move the DFH definitions
Date:   Tue,  6 Sep 2022 12:04:23 -0700
Message-Id: <20220906190426.3139760-3-matthew.gerlach@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220906190426.3139760-1-matthew.gerlach@linux.intel.com>
References: <20220906190426.3139760-1-matthew.gerlach@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Basheer Ahmed Muddebihal <basheer.ahmed.muddebihal@linux.intel.com>

Moving the DFH register offset and register definitions from
drivers/fpga/dfl.h to include/linux/dfl.h.  These definitions
need to be accessed by dfl drivers that are outside of
drivers/fpga.

Signed-off-by: Basheer Ahmed Muddebihal <basheer.ahmed.muddebihal@linux.intel.com>
Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
---
 drivers/fpga/dfl.h  | 22 ++--------------------
 include/linux/dfl.h | 23 ++++++++++++++++++++++-
 2 files changed, 24 insertions(+), 21 deletions(-)

diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
index 06cfcd5e84bb..d4dfc03a0b61 100644
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
@@ -17,6 +17,7 @@
 #include <linux/bitfield.h>
 #include <linux/cdev.h>
 #include <linux/delay.h>
+#include <linux/dfl.h>
 #include <linux/eventfd.h>
 #include <linux/fs.h>
 #include <linux/interrupt.h>
@@ -53,28 +54,9 @@
 #define PORT_FEATURE_ID_UINT		0x12
 #define PORT_FEATURE_ID_STP		0x13
 
-/*
- * Device Feature Header Register Set
- *
- * For FIUs, they all have DFH + GUID + NEXT_AFU as common header registers.
- * For AFUs, they have DFH + GUID as common header registers.
- * For private features, they only have DFH register as common header.
- */
-#define DFH			0x0
-#define GUID_L			0x8
-#define GUID_H			0x10
-#define NEXT_AFU		0x18
-
-#define DFH_SIZE		0x8
-
 /* Device Feature Header Register Bitfield */
-#define DFH_ID			GENMASK_ULL(11, 0)	/* Feature ID */
 #define DFH_ID_FIU_FME		0
 #define DFH_ID_FIU_PORT		1
-#define DFH_REVISION		GENMASK_ULL(15, 12)	/* Feature revision */
-#define DFH_NEXT_HDR_OFST	GENMASK_ULL(39, 16)	/* Offset to next DFH */
-#define DFH_EOL			BIT_ULL(40)		/* End of list */
-#define DFH_TYPE		GENMASK_ULL(63, 60)	/* Feature type */
 #define DFH_TYPE_AFU		1
 #define DFH_TYPE_PRIVATE	3
 #define DFH_TYPE_FIU		4
diff --git a/include/linux/dfl.h b/include/linux/dfl.h
index 431636a0dc78..b5accdcfa368 100644
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
@@ -11,6 +11,27 @@
 #include <linux/device.h>
 #include <linux/mod_devicetable.h>
 
+/*
+ * Device Feature Header Register Set
+ *
+ * For FIUs, they all have DFH + GUID + NEXT_AFU as common header registers.
+ * For AFUs, they have DFH + GUID as common header registers.
+ * For private features, they only have DFH register as common header.
+ */
+#define DFH			0x0
+#define GUID_L			0x8
+#define GUID_H			0x10
+#define NEXT_AFU		0x18
+
+#define DFH_SIZE		0x8
+
+/* Device Feature Header Register Bitfield */
+#define DFH_ID			GENMASK_ULL(11, 0)	/* Feature ID */
+#define DFH_REVISION		GENMASK_ULL(15, 12)	/* Feature revision */
+#define DFH_NEXT_HDR_OFST	GENMASK_ULL(39, 16)	/* Offset to next DFH */
+#define DFH_EOL			BIT_ULL(40)		/* End of list */
+#define DFH_TYPE		GENMASK_ULL(63, 60)	/* Feature type */
+
 /**
  * enum dfl_id_type - define the DFL FIU types
  */
-- 
2.25.1


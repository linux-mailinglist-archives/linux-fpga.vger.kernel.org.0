Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D05B506668
	for <lists+linux-fpga@lfdr.de>; Tue, 19 Apr 2022 09:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238140AbiDSH6d (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 19 Apr 2022 03:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243286AbiDSH6a (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 19 Apr 2022 03:58:30 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F49D1AF07
        for <linux-fpga@vger.kernel.org>; Tue, 19 Apr 2022 00:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650354949; x=1681890949;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2o4tc1CLHX+w5gUSxi93XnlLgHHGhrPMqKI9dHIbefM=;
  b=N2BMzIQ46/4ob+Ciz/0OkIMJcWToiSvMJJR/ic2uX43W4IiLEcfUjcj1
   LKPcr87Hvhb2dx8lvNcB6iwkavRg5yKETszZBPl5Giy0fId5WgB6yV19+
   dSPUXFaE71UyeWcx/qLRa/PCEaTNol03xmsH/zJbCy3CO7f4tGj5/a4EZ
   nfcuMhyVHi8nc+bt/wqQXQT5i7A6U9OOpdx33DR+fM52g8xRFVgZXPumm
   5dYui9kuY5HgzHNp1ypfcDZl5JxKnZa1O79fcT+DXjM8aXntJ+JioWk07
   Fow5UCIP7HUdno3FRnk2ULGDCe1JT5LTeh1ynyMpGt+2hlRxxUkBGSJCH
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="324147709"
X-IronPort-AV: E=Sophos;i="5.90,272,1643702400"; 
   d="scan'208";a="324147709"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 00:55:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,272,1643702400"; 
   d="scan'208";a="726962238"
Received: from unknown (HELO localhost.localdomain.sh.intel.com) ([10.238.175.107])
  by orsmga005.jf.intel.com with ESMTP; 19 Apr 2022 00:55:46 -0700
From:   Tianfei Zhang <tianfei.zhang@intel.com>
To:     hao.wu@intel.com, trix@redhat.com, mdf@kernel.org,
        yilun.xu@intel.com, linux-fpga@vger.kernel.org
Cc:     Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Tianfei Zhang <tianfei.zhang@intel.com>
Subject: [PATCH v2] fpga: dfl: Allow Port to be linked to FME's DFL
Date:   Tue, 19 Apr 2022 03:52:24 -0400
Message-Id: <20220419075224.430824-1-tianfei.zhang@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Matthew Gerlach <matthew.gerlach@linux.intel.com>

Currently we use PORTn_OFFSET to locate PORT DFLs, and PORT DFLs are not
connected FME DFL. But for some cases (e.g. Intel Open FPGA Stack device),
PORT DFLs are connected to FME DFL directly, so we don't need to search
PORT DFLs via PORTn_OFFSET again. If BAR value of PORTn_OFFSET is 0x7
(FME_PORT_OFST_BAR_SKIP) then driver will skip searching the DFL for that
port. If BAR value is invalid, return -EINVAL.

Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
---
v2: return -EINVAL if bar number invalid.
---
 drivers/fpga/dfl-pci.c | 11 +++++++++++
 drivers/fpga/dfl.h     |  1 +
 2 files changed, 12 insertions(+)

diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
index 86ed9e4223d3..5bd6ef231ccc 100644
--- a/drivers/fpga/dfl-pci.c
+++ b/drivers/fpga/dfl-pci.c
@@ -263,6 +263,17 @@ static int find_dfls_by_default(struct pci_dev *pcidev,
 			 */
 			bar = FIELD_GET(FME_PORT_OFST_BAR_ID, v);
 			offset = FIELD_GET(FME_PORT_OFST_DFH_OFST, v);
+			if (bar == FME_PORT_OFST_BAR_SKIP) {
+				dev_dbg(&pcidev->dev, "skipping search DFL for port %d on BAR %d\n",
+					i, bar);
+				continue;
+			} else if (bar >= PCI_STD_NUM_BARS) {
+				dev_err(&pcidev->dev, "bad BAR %d for port %d\n",
+					bar, i);
+				ret = -EINVAL;
+				break;
+			}
+
 			start = pci_resource_start(pcidev, bar) + offset;
 			len = pci_resource_len(pcidev, bar) - offset;
 
diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
index 53572c7aced0..e0f0abfbeb8c 100644
--- a/drivers/fpga/dfl.h
+++ b/drivers/fpga/dfl.h
@@ -91,6 +91,7 @@
 #define FME_HDR_PORT_OFST(n)	(0x38 + ((n) * 0x8))
 #define FME_HDR_BITSTREAM_ID	0x60
 #define FME_HDR_BITSTREAM_MD	0x68
+#define FME_PORT_OFST_BAR_SKIP	7
 
 /* FME Fab Capability Register Bitfield */
 #define FME_CAP_FABRIC_VERID	GENMASK_ULL(7, 0)	/* Fabric version ID */
-- 
2.26.2


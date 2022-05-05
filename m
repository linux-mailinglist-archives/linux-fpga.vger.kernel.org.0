Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE2151BCDE
	for <lists+linux-fpga@lfdr.de>; Thu,  5 May 2022 12:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235150AbiEEKNb (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 5 May 2022 06:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiEEKNa (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 5 May 2022 06:13:30 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6262B49921
        for <linux-fpga@vger.kernel.org>; Thu,  5 May 2022 03:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651745391; x=1683281391;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YE/9rmScQ70JKKV8FAe+cMb8tUS26PW5Cyf4mjsJpuk=;
  b=kWrCtDor4cM/9AQUZ9BycdBTl5JO0ZW2nTNcYP2AiCxyACJF/+Fe7C68
   sbnZ+OOQILff7IwZ3NRH6F7Ov4Sxld5EUYvGWBeTqwr5Nes7vaiqdFnp1
   dMeEWbrC0iYdaAQk6BWZn1rS0eO6ncoFzXGUaMgsE+D331j3mLJsKOSrr
   qkYWUYEAFzmQfuhEMNFaI9S5POpMDdOVfZmJu2gVYOkyodXgM46mORWOd
   CQf11G/407XovrpdzRVDSQlX+6EwCsERSO+g6qT85QRd4n5QefQVTTND5
   99O4JtBjWrm9I5NGroWEH7qbJUtJq2U3Q6cnFRoNnlkzsO5J+Y06KjIL7
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="250048552"
X-IronPort-AV: E=Sophos;i="5.91,200,1647327600"; 
   d="scan'208";a="250048552"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 03:09:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,200,1647327600"; 
   d="scan'208";a="734832526"
Received: from unknown (HELO localhost.localdomain.sh.intel.com) ([10.238.175.107])
  by orsmga005.jf.intel.com with ESMTP; 05 May 2022 03:09:48 -0700
From:   Tianfei Zhang <tianfei.zhang@intel.com>
To:     hao.wu@intel.com, trix@redhat.com, mdf@kernel.org,
        yilun.xu@intel.com, linux-fpga@vger.kernel.org
Cc:     Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Tianfei Zhang <tianfei.zhang@intel.com>
Subject: [PATCH v5] fpga: dfl: Allow Port to be linked to FME's DFL
Date:   Thu,  5 May 2022 06:06:17 -0400
Message-Id: <20220505100617.703672-1-tianfei.zhang@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
Acked-by: Xu Yilun <yilun.xu@intel.com>
Acked-by: Wu Hao <hao.wu@intel.com>
---
v5: use "break" instead of "goto".
    add Acked-by Tag.
v4: move the location of FME_PORT_OFST_BAR_SKIP definition.
v3: remove dev_dbg and use goto instead of break.
v2: return -EINVAL if bar number invalid.
---
 drivers/fpga/dfl-pci.c | 9 +++++++++
 drivers/fpga/dfl.h     | 1 +
 2 files changed, 10 insertions(+)

diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
index 86ed9e4223d3..1df525a933f2 100644
--- a/drivers/fpga/dfl-pci.c
+++ b/drivers/fpga/dfl-pci.c
@@ -263,6 +263,15 @@ static int find_dfls_by_default(struct pci_dev *pcidev,
 			 */
 			bar = FIELD_GET(FME_PORT_OFST_BAR_ID, v);
 			offset = FIELD_GET(FME_PORT_OFST_DFH_OFST, v);
+			if (bar == FME_PORT_OFST_BAR_SKIP) {
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
index 53572c7aced0..06cfcd5e84bb 100644
--- a/drivers/fpga/dfl.h
+++ b/drivers/fpga/dfl.h
@@ -89,6 +89,7 @@
 #define FME_HDR_NEXT_AFU	NEXT_AFU
 #define FME_HDR_CAP		0x30
 #define FME_HDR_PORT_OFST(n)	(0x38 + ((n) * 0x8))
+#define FME_PORT_OFST_BAR_SKIP	7
 #define FME_HDR_BITSTREAM_ID	0x60
 #define FME_HDR_BITSTREAM_MD	0x68
 
-- 
2.26.2


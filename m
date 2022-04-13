Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0434F4FF347
	for <lists+linux-fpga@lfdr.de>; Wed, 13 Apr 2022 11:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbiDMJVJ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 13 Apr 2022 05:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiDMJVI (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 13 Apr 2022 05:21:08 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CDB352E48
        for <linux-fpga@vger.kernel.org>; Wed, 13 Apr 2022 02:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649841528; x=1681377528;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7gQT1Ix/ENAh2XjCj59a12ANeUyjf2fde8SqRQZh1v8=;
  b=HqE3WCG2NZtYv/PfcOiZ59yO41c47uQDzt7wprQCEPeS24JN7S+tXjQu
   nzdSqMoQC8b0rhDzEYwfIba9Oi35pLOPKKspG0RBniECfVkMqIpfSPHQZ
   SassOGabO+ZyZEph8dj0gMwggl27cyPlLzZxhQNum/tlV/fP9R2osrA//
   S59jZWtOr1uEzslBdK6weuk9luxM8rcOGPPdkh99lJL8cKoQkVd/jXMOn
   WUUcdhmq3R/SFXnZ+YKCDV0YOaWtnFfPaPU4wDiySlQdlXBwCRZsOGYrJ
   +WaPDNcbSA0tsjXV+vSWHKIiDs6G3A8a809gskgY/umcd99dWlFNdiKRQ
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10315"; a="262796466"
X-IronPort-AV: E=Sophos;i="5.90,256,1643702400"; 
   d="scan'208";a="262796466"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 02:18:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,256,1643702400"; 
   d="scan'208";a="724827401"
Received: from unknown (HELO localhost.localdomain.sh.intel.com) ([10.238.175.107])
  by orsmga005.jf.intel.com with ESMTP; 13 Apr 2022 02:18:45 -0700
From:   Tianfei Zhang <tianfei.zhang@intel.com>
To:     hao.wu@intel.com, trix@redhat.com, mdf@kernel.org,
        yilun.xu@intel.com, linux-fpga@vger.kernel.org
Cc:     Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Tianfei Zhang <tianfei.zhang@intel.com>
Subject: [PATCH v1] fpga: dfl: Allow Port to be linked to FME's DFL
Date:   Wed, 13 Apr 2022 05:15:19 -0400
Message-Id: <20220413091519.317735-1-tianfei.zhang@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
port.

Link: https://lore.kernel.org/linux-fpga/20220316070814.1916017-2-tianfei.zhang@intel.com/
Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
---
 drivers/fpga/dfl-pci.c | 7 +++++++
 drivers/fpga/dfl.h     | 1 +
 2 files changed, 8 insertions(+)

diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
index 717ac9715970..6347f31058f0 100644
--- a/drivers/fpga/dfl-pci.c
+++ b/drivers/fpga/dfl-pci.c
@@ -259,6 +259,13 @@ static int find_dfls_by_default(struct pci_dev *pcidev,
 			 */
 			bar = FIELD_GET(FME_PORT_OFST_BAR_ID, v);
 			offset = FIELD_GET(FME_PORT_OFST_DFH_OFST, v);
+			if (bar >= PCI_STD_NUM_BARS ||
+			    bar == FME_PORT_OFST_BAR_SKIP) {
+				dev_dbg(&pcidev->dev, "skipping search DFL for port %d on BAR %d\n",
+					i, bar);
+				continue;
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


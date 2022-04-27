Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC1A4511B0D
	for <lists+linux-fpga@lfdr.de>; Wed, 27 Apr 2022 16:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233315AbiD0NZk (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 27 Apr 2022 09:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235823AbiD0NXo (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 27 Apr 2022 09:23:44 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2B9BC31
        for <linux-fpga@vger.kernel.org>; Wed, 27 Apr 2022 06:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651065628; x=1682601628;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uNvDz9d9kDA8AE/RgW6XsVA2dFeaKGoRR8HQ3xfRP+k=;
  b=PVz0CEcCzHvkdKKSUCHf5BcPYLqLQUFq8aHGZw4HZjCX7XAZTNLLnxYw
   bSh40X9y5M9qDcLFZVbgq33ROx/FiBYPDjEepwxlQAmI7QqqozeUFrofQ
   j78iAOD0gIZh6QRZgYhJTIkvuQIeyFAC8fXNKijv3pbgiRjyucYgH8/rn
   GHRZpxsFzT4V0mCoS0uvqM8SohBsNJzZVHgH6QM//BYFZpvqTnoSCmcbX
   w5b/8HQlbppRZv8aVGMObMhpfsy/698k2cpmhiR7gkArZtqL3VS7KuBEg
   TBVwxMNdupAn4uprN9BCNnnNjaLbXFaLMDLYpXdSzZ4HruQojvtI5FJ8K
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="253304257"
X-IronPort-AV: E=Sophos;i="5.90,293,1643702400"; 
   d="scan'208";a="253304257"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 06:20:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,293,1643702400"; 
   d="scan'208";a="540013065"
Received: from unknown (HELO localhost.localdomain.sh.intel.com) ([10.238.175.107])
  by orsmga002.jf.intel.com with ESMTP; 27 Apr 2022 06:20:24 -0700
From:   Tianfei Zhang <tianfei.zhang@intel.com>
To:     hao.wu@intel.com, trix@redhat.com, mdf@kernel.org,
        yilun.xu@intel.com, linux-fpga@vger.kernel.org
Cc:     Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Tianfei Zhang <tianfei.zhang@intel.com>
Subject: [PATCH v4] fpga: dfl: Allow Port to be linked to FME's DFL
Date:   Wed, 27 Apr 2022 09:16:56 -0400
Message-Id: <20220427131656.588822-1-tianfei.zhang@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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
v4: move the location of FME_PORT_OFST_BAR_SKIP definition.
v3: remove dev_dbg and use goto instead of break.
v2: return -EINVAL if bar number invalid.
---
 drivers/fpga/dfl-pci.c | 10 ++++++++++
 drivers/fpga/dfl.h     |  1 +
 2 files changed, 11 insertions(+)

diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
index 86ed9e4223d3..dac45f96c326 100644
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
+				goto unmap_exit;
+			}
+
 			start = pci_resource_start(pcidev, bar) + offset;
 			len = pci_resource_len(pcidev, bar) - offset;
 
@@ -277,6 +286,7 @@ static int find_dfls_by_default(struct pci_dev *pcidev,
 		ret = -ENODEV;
 	}
 
+unmap_exit:
 	/* release I/O mappings for next step enumeration */
 	pcim_iounmap_regions(pcidev, BIT(0));
 
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


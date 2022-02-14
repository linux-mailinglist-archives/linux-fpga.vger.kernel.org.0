Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82964B4EFA
	for <lists+linux-fpga@lfdr.de>; Mon, 14 Feb 2022 12:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352138AbiBNLjn (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 14 Feb 2022 06:39:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352013AbiBNLja (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 14 Feb 2022 06:39:30 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E3CDE8B;
        Mon, 14 Feb 2022 03:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644838182; x=1676374182;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L8LQgDjx0EOOe2M9p7V6FYObzOK0Cj9rYbobse8T9IQ=;
  b=hwIot3nRZlzQeibazRS60y4VaAjyAAxVFr6W6tB2unGRT68e1Gsxwn3h
   gSvb5kk2nM96FDGq4m17wKW2fz4uJWTtglYy9emUeGx6oA1m4pr4jeGD7
   NdKVSmN/DQR9LVj4QCVsRKDjam5A7PqX2lpRL+oQ5txOAwqe1ozH3rOiF
   cEXFl9SAHIVKFAzJML2n4lfObyuw370OZD8VUy6jdrgEOsxSjpXt7xwYJ
   YffOIn0ATsEfBcya35jUGfVq0l7LUtPQ+m4d5yGBBAtstPnTsxL53SOUT
   KS0EN1TPzKy6YjWNsOZAaDjnDXPtzgQYcZdYbeqCmR3PwLyOdGa17FR1z
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="250276735"
X-IronPort-AV: E=Sophos;i="5.88,367,1635231600"; 
   d="scan'208";a="250276735"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 03:29:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,367,1635231600"; 
   d="scan'208";a="587167012"
Received: from unknown (HELO localhost.localdomain.sh.intel.com) ([10.238.175.107])
  by fmsmga008.fm.intel.com with ESMTP; 14 Feb 2022 03:29:39 -0800
From:   Tianfei zhang <tianfei.zhang@intel.com>
To:     hao.wu@intel.com, trix@redhat.com, mdf@kernel.org,
        yilun.xu@intel.com, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     corbet@lwn.net, Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Tianfei Zhang <tianfei.zhang@intel.com>
Subject: [PATCH v1 3/7] fpga: dfl: Allow for ports with no local bar space.
Date:   Mon, 14 Feb 2022 06:26:15 -0500
Message-Id: <20220214112619.219761-4-tianfei.zhang@intel.com>
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

From: Matthew Gerlach <matthew.gerlach@linux.intel.com>

From a fpga partial reconfiguration standpoint, a port
may not be connected any local BAR space.  The port could
be connected to a different PCIe Physical Function (PF) or
Virtual Function (VF), in which case another driver instance
would manage the endpoint.

Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
---
 drivers/fpga/dfl-pci.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
index 4d68719e608f..8abd9b408403 100644
--- a/drivers/fpga/dfl-pci.c
+++ b/drivers/fpga/dfl-pci.c
@@ -243,6 +243,7 @@ static int find_dfls_by_default(struct pci_dev *pcidev,
 		v = readq(base + FME_HDR_CAP);
 		port_num = FIELD_GET(FME_CAP_NUM_PORTS, v);
 
+		dev_info(&pcidev->dev, "port_num = %d\n", port_num);
 		WARN_ON(port_num > MAX_DFL_FPGA_PORT_NUM);
 
 		for (i = 0; i < port_num; i++) {
@@ -258,6 +259,13 @@ static int find_dfls_by_default(struct pci_dev *pcidev,
 			 */
 			bar = FIELD_GET(FME_PORT_OFST_BAR_ID, v);
 			offset = FIELD_GET(FME_PORT_OFST_DFH_OFST, v);
+			if (bar >= PCI_STD_NUM_BARS) {
+				dev_info(&pcidev->dev, "skipping port without local BAR space %d\n",
+					 bar);
+				continue;
+			} else {
+				dev_info(&pcidev->dev, "BAR %d offset %u\n", bar, offset);
+			}
 			start = pci_resource_start(pcidev, bar) + offset;
 			len = pci_resource_len(pcidev, bar) - offset;
 
-- 
2.17.1


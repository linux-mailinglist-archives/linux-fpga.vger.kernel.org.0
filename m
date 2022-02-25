Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15F724C3C40
	for <lists+linux-fpga@lfdr.de>; Fri, 25 Feb 2022 04:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236940AbiBYDNw (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 24 Feb 2022 22:13:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbiBYDNq (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 24 Feb 2022 22:13:46 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E1BD64BE7;
        Thu, 24 Feb 2022 19:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645758796; x=1677294796;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=peqfZ+rFk7ZwJ07YEOVnePiWyPNcAj7SeTjZgu1wjWo=;
  b=mKTR7uZ+ydvOMo1yALM61PTrA/p2IB7YdtLmPADCk6wkgzcHYlxrndUE
   YyaMT/+BXHkjEMFZQcQ/6E0DzT3GWdF0CQCHKcvGaKYn1W5A3u02xycvO
   jSIfLJmUaJrWTkF6H9t5jq6DAFxjQ+9GGyuFnN1F/pqxVE5QYyitB6Kw8
   813Sfc9aXpJ0XXScON239lcz1r2KlHKyYYJhPt4YggrUiXCZjE9Gdp6G8
   qItU74Ap2bVLlIYFwaZhwmCuHY/wIziCFBN8r7eh/N1AYVTFLHDnsRFMb
   Yb8LSCCidmPAFT1Zk+G5uYes+jTqw10ZMPmAoMglh1hw7PX+6uzakRndv
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="252602981"
X-IronPort-AV: E=Sophos;i="5.90,135,1643702400"; 
   d="scan'208";a="252602981"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 19:13:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,135,1643702400"; 
   d="scan'208";a="684512442"
Received: from unknown (HELO localhost.localdomain.sh.intel.com) ([10.238.175.107])
  by fmsmga001.fm.intel.com with ESMTP; 24 Feb 2022 19:13:13 -0800
From:   Tianfei zhang <tianfei.zhang@intel.com>
To:     hao.wu@intel.com, trix@redhat.com, mdf@kernel.org,
        yilun.xu@intel.com, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     corbet@lwn.net, Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Tianfei Zhang <tianfei.zhang@intel.com>
Subject: [PATCH v2 1/5] fpga: dfl: Allow for ports without specific bar space.
Date:   Thu, 24 Feb 2022 22:09:58 -0500
Message-Id: <20220225031002.261264-2-tianfei.zhang@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220225031002.261264-1-tianfei.zhang@intel.com>
References: <20220225031002.261264-1-tianfei.zhang@intel.com>
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

In IOFS, there is a Port device for each PR slot, like Port
control, Port user clock control and Port errors, those feature
devices are linked with DFL. The DFL of Port device was located
in PCIe Bar 0 MMIO space by default, but it also can put into any
PCIe Bar space. If the BarID (3bits field) in PORTn_OFFSET register
set to invalid means that DFL of Port device is located in the Bar 0
by default, in this case, it don't need add the Bar 0 into dfl list
twice.

---
v2: use FME_HDR_NO_PORT_BAR instead of PCI_STD_NUM_BARS.

Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
---
 drivers/fpga/dfl-pci.c | 6 ++++++
 drivers/fpga/dfl.h     | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
index 4d68719e608f..33545c999c06 100644
--- a/drivers/fpga/dfl-pci.c
+++ b/drivers/fpga/dfl-pci.c
@@ -258,6 +258,12 @@ static int find_dfls_by_default(struct pci_dev *pcidev,
 			 */
 			bar = FIELD_GET(FME_PORT_OFST_BAR_ID, v);
 			offset = FIELD_GET(FME_PORT_OFST_DFH_OFST, v);
+			if (bar >= FME_HDR_NO_PORT_BAR) {
+				dev_dbg(&pcidev->dev, "skipping port without specific BAR space %d\n",
+					bar);
+				continue;
+			}
+
 			start = pci_resource_start(pcidev, bar) + offset;
 			len = pci_resource_len(pcidev, bar) - offset;
 
diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
index 53572c7aced0..1fd493e82dd8 100644
--- a/drivers/fpga/dfl.h
+++ b/drivers/fpga/dfl.h
@@ -91,6 +91,7 @@
 #define FME_HDR_PORT_OFST(n)	(0x38 + ((n) * 0x8))
 #define FME_HDR_BITSTREAM_ID	0x60
 #define FME_HDR_BITSTREAM_MD	0x68
+#define FME_HDR_NO_PORT_BAR	7
 
 /* FME Fab Capability Register Bitfield */
 #define FME_CAP_FABRIC_VERID	GENMASK_ULL(7, 0)	/* Fabric version ID */
-- 
2.26.2


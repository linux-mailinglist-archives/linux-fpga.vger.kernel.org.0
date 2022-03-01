Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C87A44C83FF
	for <lists+linux-fpga@lfdr.de>; Tue,  1 Mar 2022 07:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbiCAGZY (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 1 Mar 2022 01:25:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232578AbiCAGZW (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 1 Mar 2022 01:25:22 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF4B70CF3;
        Mon, 28 Feb 2022 22:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646115881; x=1677651881;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lZEOfIz3m1DygDOUYcfK29oBMsF05/jk10P8QgkmIkY=;
  b=V7G2XSjHv1Umw8p1tgfGqPNqamtKCQ6OD3GN/cufeMCUPYEK/Jf0QROB
   srlZfRSMJCJCqPg49wkxky9ATo1vkLIZcVDdqAGMigfgYCGLyg+OWGBLr
   7XAoBjufNZv8RP8CC0xUkfm12ms9xjcwXlUQ4snyZJUhdiD/E4KORseUB
   OH92/9mw/zpFzCPR9VUquYFOPmALBYJ7FICYkPgrb8Zo3Z3S2fCwthPVS
   L3q2MjzCib2NkL3pGCgYxN8koQsDd54UB/OgpcwVZP9/mBlpuhj+0t5vx
   dKlWgewev6JXn+6byapJw69LsrtuyJ3MxZVckglclA+8tf8pIQb0ijOr/
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="251900310"
X-IronPort-AV: E=Sophos;i="5.90,145,1643702400"; 
   d="scan'208";a="251900310"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 22:24:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,145,1643702400"; 
   d="scan'208";a="708941743"
Received: from unknown (HELO localhost.localdomain.sh.intel.com) ([10.238.175.107])
  by orsmga005.jf.intel.com with ESMTP; 28 Feb 2022 22:24:37 -0800
From:   Tianfei zhang <tianfei.zhang@intel.com>
To:     hao.wu@intel.com, trix@redhat.com, mdf@kernel.org,
        yilun.xu@intel.com, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, corbet@lwn.net,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Tianfei Zhang <tianfei.zhang@intel.com>
Subject: [PATCH v3 1/5] fpga: dfl: Allow for ports without specific bar space.
Date:   Tue,  1 Mar 2022 01:21:19 -0500
Message-Id: <20220301062123.818687-2-tianfei.zhang@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220301062123.818687-1-tianfei.zhang@intel.com>
References: <20220301062123.818687-1-tianfei.zhang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Matthew Gerlach <matthew.gerlach@linux.intel.com>

In OFS, there is a Port device for each PR slot, like Port
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


Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F35284DABA4
	for <lists+linux-fpga@lfdr.de>; Wed, 16 Mar 2022 08:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232916AbiCPHNK (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 16 Mar 2022 03:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354174AbiCPHMw (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 16 Mar 2022 03:12:52 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6505DE74;
        Wed, 16 Mar 2022 00:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647414699; x=1678950699;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BLFuTRhqE482sqaHRif7NDKXQY4BaFJ4C/qrheqYfJs=;
  b=Jv5MP3dlRFp8xrNGv1GrZIu2sytx29ZnFEpf2UHNS73fb2HxBvziY7oE
   j0gD2uGrG9Ty+ehURzFcjIbwhoutcTMMt6MM6e1eGo3tIk3s9eI0Eu4nG
   TDGtj7LrH6iSm+Mg5Zv9OqI01SIkitG3ZZMROCPhpHDyu4oxN47xdYlxC
   Xt/z8B7eM2yOpE7BRJoR3HIA4/CeWb7uqmLrtEKPo1Sb+0yB7FT7Q+K9B
   du4llyl6hv+okUbMfK39hdO8POF4Lps0UITI2HT+WOrsmqPX3rPQBrluT
   a2ipnaR6AQclNUCawo7KrB33UXaIgsGhdNIkFJRIyfY7QAT9waIilzY46
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="281289023"
X-IronPort-AV: E=Sophos;i="5.90,186,1643702400"; 
   d="scan'208";a="281289023"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 00:11:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,186,1643702400"; 
   d="scan'208";a="646538324"
Received: from unknown (HELO localhost.localdomain.sh.intel.com) ([10.238.175.107])
  by orsmga004.jf.intel.com with ESMTP; 16 Mar 2022 00:11:35 -0700
From:   Tianfei Zhang <tianfei.zhang@intel.com>
To:     hao.wu@intel.com, trix@redhat.com, mdf@kernel.org,
        yilun.xu@intel.com, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org
Cc:     corbet@lwn.net, Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Tianfei Zhang <tianfei.zhang@intel.com>
Subject: [PATCH v6 1/6] fpga: dfl: Allow ports without local bar space.
Date:   Wed, 16 Mar 2022 03:08:09 -0400
Message-Id: <20220316070814.1916017-2-tianfei.zhang@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220316070814.1916017-1-tianfei.zhang@intel.com>
References: <20220316070814.1916017-1-tianfei.zhang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Matthew Gerlach <matthew.gerlach@linux.intel.com>

In OFS, each PR slot (AFU) has one port device which include Port
control, Port user clock control and Port errors. In legacy model,
the AFU MMIO space was connected with Port device, so from port
device point of view, there is a bar space associated with this
port device. But in "Multiple VFs per PR slot" model, the AFU MMIO
space was not connected with Port device. The BarID (3bits field) in
PORTn_OFFSET register indicates which PCI bar space associated with
this port device, the value 0b111 (FME_HDR_NO_PORT_BAR) means that
no PCI bar for this port device.

---
v3: add PCI bar number checking with PCI_STD_NUM_BARS.
v2: use FME_HDR_NO_PORT_BAR instead of PCI_STD_NUM_BARS.

Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
---
 drivers/fpga/dfl-pci.c | 7 +++++++
 drivers/fpga/dfl.h     | 1 +
 2 files changed, 8 insertions(+)

diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
index 4d68719e608f..2e9abeca3625 100644
--- a/drivers/fpga/dfl-pci.c
+++ b/drivers/fpga/dfl-pci.c
@@ -258,6 +258,13 @@ static int find_dfls_by_default(struct pci_dev *pcidev,
 			 */
 			bar = FIELD_GET(FME_PORT_OFST_BAR_ID, v);
 			offset = FIELD_GET(FME_PORT_OFST_DFH_OFST, v);
+			if (bar >= PCI_STD_NUM_BARS ||
+			    bar == FME_HDR_NO_PORT_BAR) {
+				dev_dbg(&pcidev->dev, "skipping port without local BAR space %d\n",
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


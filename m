Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E62656A69C
	for <lists+linux-fpga@lfdr.de>; Thu,  7 Jul 2022 17:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235917AbiGGPGF (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 7 Jul 2022 11:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235502AbiGGPGF (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 7 Jul 2022 11:06:05 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3349D26AC3;
        Thu,  7 Jul 2022 08:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657206364; x=1688742364;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=adckEd/EgBUQm/L61u5fHQUxAK/6Vk89aU9fjB5wRsI=;
  b=RXDQoxaBo6IyC8QJGDW44TDqEgyGDgVIpy+veuD0qo1X4Mu2eEWqa1SX
   F9wWLvPAys9mx7yXcLg68ZN/cALR9GcmxLBhBK17MC2i1PVrT28jMXqf4
   hJq9xdmZ+SfH5oeolCoOlPQj/1luM2Dn9r73rzPu6dDPPUVpZYoWA/NUf
   DkSjUaR+mjj+CuVAb/hXmF8FgL1BdJxrwdDKiRFwv7vpLQxUTzHXT/5ps
   QSJ4G4mXwFjbsCJjLeBydOHuW6rOFAEZ8SQNxzuaC3ZUmXrr06pORXWiU
   qz03gC9oScDWE63vrtxxJ1ihiKNVGQas/Hq3ItCyHkBZ6qFwUH5N+DLca
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10400"; a="263829564"
X-IronPort-AV: E=Sophos;i="5.92,253,1650956400"; 
   d="scan'208";a="263829564"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2022 08:05:58 -0700
X-IronPort-AV: E=Sophos;i="5.92,253,1650956400"; 
   d="scan'208";a="720546772"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.43])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2022 08:05:56 -0700
From:   matthew.gerlach@linux.intel.com
To:     hao.wu@intel.com, yilun.xu@intel.com, russell.h.weight@intel.com,
        basheer.ahmed.muddebihal@intel.com, trix@redhat.com,
        mdf@kernel.org, corbet@lwn.net, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tianfei.zhang@intel.com
Cc:     Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: [PATCH v3 2/2] fpga: dfl-pci: Add IDs for Intel N6000, N6001 and C6100 cards
Date:   Thu,  7 Jul 2022 08:05:49 -0700
Message-Id: <20220707150549.265621-3-matthew.gerlach@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220707150549.265621-1-matthew.gerlach@linux.intel.com>
References: <20220707150549.265621-1-matthew.gerlach@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75 autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Matthew Gerlach <matthew.gerlach@linux.intel.com>

Add pci_dev_table entries supporting the Intel N6000, N6001
and C6100 cards to the dfl-pci driver.

Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
---
v3: added necessary subdevice ids
    removed 'drivers: ' from title

v2: changed names from INTEL_OFS to INTEL_DFL
---
 drivers/fpga/dfl-pci.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
index fd1fa55c9113..94eabdf1d2f7 100644
--- a/drivers/fpga/dfl-pci.c
+++ b/drivers/fpga/dfl-pci.c
@@ -77,12 +77,19 @@ static void cci_pci_free_irq(struct pci_dev *pcidev)
 #define PCIE_DEVICE_ID_INTEL_PAC_D5005		0x0B2B
 #define PCIE_DEVICE_ID_SILICOM_PAC_N5010	0x1000
 #define PCIE_DEVICE_ID_SILICOM_PAC_N5011	0x1001
+#define PCIE_DEVICE_ID_INTEL_DFL		0xbcce
 
 /* VF Device */
 #define PCIE_DEVICE_ID_VF_INT_5_X		0xBCBF
 #define PCIE_DEVICE_ID_VF_INT_6_X		0xBCC1
 #define PCIE_DEVICE_ID_VF_DSC_1_X		0x09C5
 #define PCIE_DEVICE_ID_INTEL_PAC_D5005_VF	0x0B2C
+#define PCIE_DEVICE_ID_INTEL_DFL_VF		0xbccf
+
+/* PCI Subdevice ID */
+#define PCIE_SUBDEVICE_ID_INTEL_N6000		0x1770
+#define PCIE_SUBDEVICE_ID_INTEL_N6001		0x1771
+#define PCIE_SUBDEVICE_ID_INTEL_C6100		0x17d4
 
 static struct pci_device_id cci_pcie_id_tbl[] = {
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_PF_INT_5_X),},
@@ -96,6 +103,18 @@ static struct pci_device_id cci_pcie_id_tbl[] = {
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_INTEL_PAC_D5005_VF),},
 	{PCI_DEVICE(PCI_VENDOR_ID_SILICOM_DENMARK, PCIE_DEVICE_ID_SILICOM_PAC_N5010),},
 	{PCI_DEVICE(PCI_VENDOR_ID_SILICOM_DENMARK, PCIE_DEVICE_ID_SILICOM_PAC_N5011),},
+	{PCI_DEVICE_SUB(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_INTEL_DFL,
+			PCI_VENDOR_ID_INTEL, PCIE_SUBDEVICE_ID_INTEL_N6000),},
+	{PCI_DEVICE_SUB(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_INTEL_DFL_VF,
+			PCI_VENDOR_ID_INTEL, PCIE_SUBDEVICE_ID_INTEL_N6000),},
+	{PCI_DEVICE_SUB(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_INTEL_DFL,
+			PCI_VENDOR_ID_INTEL, PCIE_SUBDEVICE_ID_INTEL_N6001),},
+	{PCI_DEVICE_SUB(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_INTEL_DFL_VF,
+			PCI_VENDOR_ID_INTEL, PCIE_SUBDEVICE_ID_INTEL_N6001),},
+	{PCI_DEVICE_SUB(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_INTEL_DFL,
+			PCI_VENDOR_ID_INTEL, PCIE_SUBDEVICE_ID_INTEL_C6100),},
+	{PCI_DEVICE_SUB(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_INTEL_DFL_VF,
+			PCI_VENDOR_ID_INTEL, PCIE_SUBDEVICE_ID_INTEL_C6100),},
 	{0,}
 };
 MODULE_DEVICE_TABLE(pci, cci_pcie_id_tbl);
-- 
2.25.1


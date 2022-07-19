Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA34D57A288
	for <lists+linux-fpga@lfdr.de>; Tue, 19 Jul 2022 16:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236109AbiGSO5O (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 19 Jul 2022 10:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236206AbiGSO4v (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 19 Jul 2022 10:56:51 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339264A822;
        Tue, 19 Jul 2022 07:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658242608; x=1689778608;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mOi4uVPmUiLwhu9VuUzNCwyijPD85EMal5A97fZ2JcE=;
  b=MzSIBjTtCs/D5/wZ6cvb1Co6zWMqfSMEwpYm2DUPfpuc7IcLu7VRh7zP
   ThhLb7k+PfmvO43OLhpiwe3O4Oy6TwtSeLHaY/+J4RkDYgwGlU2QZ5uZ9
   AZ7G7x+fYL3aCa26mTAYbMxP1WrMZxQplKHUnkLwA+sKqvd6Itscgf66K
   Va0+I/oHZR3HwWeSx24MvCC8QiYcaC3koD4ubX//BluoeVIjd48pgiOtq
   EbbzAdc+bk3msL215d/x3iPedTPD1hXbrmBqVy1QA/xA5U9tshlcMGs28
   tH5tl6umKwNJiQ203kvO5fYnwk0CDOjyYvB/6RhbFwM8D4j+a4maf6nyc
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10413"; a="286523550"
X-IronPort-AV: E=Sophos;i="5.92,284,1650956400"; 
   d="scan'208";a="286523550"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2022 07:56:47 -0700
X-IronPort-AV: E=Sophos;i="5.92,284,1650956400"; 
   d="scan'208";a="625214442"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.43])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2022 07:56:47 -0700
From:   matthew.gerlach@linux.intel.com
To:     hao.wu@intel.com, yilun.xu@intel.com, russell.h.weight@intel.com,
        basheer.ahmed.muddebihal@intel.com, trix@redhat.com,
        mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tianfei.zhang@intel.com
Cc:     Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Marco Pagani <marpagan@redhat.com>
Subject: [PATCH v4] fpga: dfl-pci: Add IDs for Intel N6000, N6001 and C6100 cards
Date:   Tue, 19 Jul 2022 07:56:44 -0700
Message-Id: <20220719145644.242481-1-matthew.gerlach@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,UPPERCASE_50_75 autolearn=ham autolearn_force=no version=3.4.6
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
Tested-by: Marco Pagani <marpagan@redhat.com>
Reviewed-by: Tom Rix <trix@redhat.com>
Acked-by: Wu Hao <hao.wu@intel.com>
---
v4: moved subdevice ids next to respective device id

v3: added necessary subdevice ids
    removed 'drivers: ' from title

v2: changed names from INTEL_OFS to INTEL_DFL
---
 drivers/fpga/dfl-pci.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
index fd1fa55c9113..0914e7328b1a 100644
--- a/drivers/fpga/dfl-pci.c
+++ b/drivers/fpga/dfl-pci.c
@@ -77,12 +77,18 @@ static void cci_pci_free_irq(struct pci_dev *pcidev)
 #define PCIE_DEVICE_ID_INTEL_PAC_D5005		0x0B2B
 #define PCIE_DEVICE_ID_SILICOM_PAC_N5010	0x1000
 #define PCIE_DEVICE_ID_SILICOM_PAC_N5011	0x1001
+#define PCIE_DEVICE_ID_INTEL_DFL		0xbcce
+/* PCI Subdevice ID for PCIE_DEVICE_ID_INTEL_DFL */
+#define PCIE_SUBDEVICE_ID_INTEL_N6000		0x1770
+#define PCIE_SUBDEVICE_ID_INTEL_N6001		0x1771
+#define PCIE_SUBDEVICE_ID_INTEL_C6100		0x17d4
 
 /* VF Device */
 #define PCIE_DEVICE_ID_VF_INT_5_X		0xBCBF
 #define PCIE_DEVICE_ID_VF_INT_6_X		0xBCC1
 #define PCIE_DEVICE_ID_VF_DSC_1_X		0x09C5
 #define PCIE_DEVICE_ID_INTEL_PAC_D5005_VF	0x0B2C
+#define PCIE_DEVICE_ID_INTEL_DFL_VF		0xbccf
 
 static struct pci_device_id cci_pcie_id_tbl[] = {
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_PF_INT_5_X),},
@@ -96,6 +102,18 @@ static struct pci_device_id cci_pcie_id_tbl[] = {
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


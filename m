Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6534CB3D9
	for <lists+linux-fpga@lfdr.de>; Thu,  3 Mar 2022 01:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbiCCAe1 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 2 Mar 2022 19:34:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbiCCAe0 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 2 Mar 2022 19:34:26 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D33732EE7;
        Wed,  2 Mar 2022 16:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646267617; x=1677803617;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=h3pvaJzVup7pXnuQkVHvNdcjk0nARUMaKJwO0XAacDg=;
  b=i/7tH8IpcgBpwTaE4vrq1elO8pDbnE34N7IANHvlgTJfjJ2JlFtchmn0
   R2x1dA5utGCqUuZ6v1xE/q4eSHdDLQd6Mk0VT5jUkaWRiLbbUvsxyQcwY
   xGhw8cPQKnxhZ6+zYAgeNWOiYcsgj1YypQeAcjHYP6OEXE5Xo5rEJ1cJt
   dlqbOwFM9ua/S+46ycwwkAmNihibBIUkzSRqmdpuNWyPabXEhGd9NDW+C
   0753VuCHABk0BDinUmHzNHK/zZmxDjBYj+gs28CWeIjSBd3i/0scyiVjE
   PR8/9Hu1fxSa+NG79UlRISxSyOLkujSlAb3RrVLm5yHoAU8GHnQuM/hG8
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="253468952"
X-IronPort-AV: E=Sophos;i="5.90,150,1643702400"; 
   d="scan'208";a="253468952"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 16:33:32 -0800
X-IronPort-AV: E=Sophos;i="5.90,150,1643702400"; 
   d="scan'208";a="686309315"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.40])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 16:33:32 -0800
From:   matthew.gerlach@linux.intel.com
To:     hao.wu@intel.com, yilun.xu@intel.com, russell.h.weight@intel.com,
        basheer.ahmed.muddebihal@intel.com, trix@redhat.com,
        mdf@kernel.org, corbet@lwn.net, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        dan.j.williams@intel.com, ashok.raj@intel.com,
        tianfei.zhang@intel.com
Cc:     Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: [PATCH v2 2/2] drivers: fpga: dfl-pci: Add PCIE device IDs for Intel DFL cards
Date:   Wed,  2 Mar 2022 16:35:34 -0800
Message-Id: <20220303003534.3307971-3-matthew.gerlach@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220303003534.3307971-1-matthew.gerlach@linux.intel.com>
References: <20220303003534.3307971-1-matthew.gerlach@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Matthew Gerlach <matthew.gerlach@linux.intel.com>

Add the PCIE device IDs for Intel cards with Device Feature Lists
(DFL) to the pci_dev_table for the dfl-pci driver.

Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
---
v2: changed names from INTEL_OFS to INTEL_DFL
---
 drivers/fpga/dfl-pci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
index 717ac9715970..8faf284509e7 100644
--- a/drivers/fpga/dfl-pci.c
+++ b/drivers/fpga/dfl-pci.c
@@ -77,12 +77,14 @@ static void cci_pci_free_irq(struct pci_dev *pcidev)
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
 
 static struct pci_device_id cci_pcie_id_tbl[] = {
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_PF_INT_5_X),},
@@ -96,6 +98,8 @@ static struct pci_device_id cci_pcie_id_tbl[] = {
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_INTEL_PAC_D5005_VF),},
 	{PCI_DEVICE(PCI_VENDOR_ID_SILICOM_DENMARK, PCIE_DEVICE_ID_SILICOM_PAC_N5010),},
 	{PCI_DEVICE(PCI_VENDOR_ID_SILICOM_DENMARK, PCIE_DEVICE_ID_SILICOM_PAC_N5011),},
+	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_INTEL_DFL),},
+	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_INTEL_DFL_VF),},
 	{0,}
 };
 MODULE_DEVICE_TABLE(pci, cci_pcie_id_tbl);
-- 
2.25.1


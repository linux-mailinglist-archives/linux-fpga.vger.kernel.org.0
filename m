Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58D344B4F55
	for <lists+linux-fpga@lfdr.de>; Mon, 14 Feb 2022 12:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352276AbiBNLjq (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 14 Feb 2022 06:39:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352042AbiBNLja (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 14 Feb 2022 06:39:30 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EFF0E0DE;
        Mon, 14 Feb 2022 03:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644838192; x=1676374192;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=STRRUYI+lvRTyBLH3L2y01xRRbP5DjQI/AMuUvI0bDw=;
  b=eDZQsVWozUdsj8XzvuCDCd3XqrPARMAD49GAwTnKOo/mcDNNbbxY6Azv
   33XXoIiSuJDBDgbpaEbnIVwtcQhVYnqYCwYcm0NcPtEB/gyap22iqOMtS
   1g4KVl6URPskv/xYvdZ5zaHRUbAM8xHZ2+xAewd3PRaQ8/6i1MM4WDE2M
   /grU2jwdHRmjfiymKnC4JlWlYga/H2ASYqWoJPXUH8vat/g9i8HZewjkF
   q9Uab2YrMsYMYBd7oZRQjH4wRgA677G15+7oUeEbyq8jPKoAM15hG+pg0
   AuL7ETVdp5d8j9Xrj8mXtRhbKDRxvm7BAXATU6NfTMIxKo2yRLITNpjvP
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="250276749"
X-IronPort-AV: E=Sophos;i="5.88,367,1635231600"; 
   d="scan'208";a="250276749"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 03:29:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,367,1635231600"; 
   d="scan'208";a="587167074"
Received: from unknown (HELO localhost.localdomain.sh.intel.com) ([10.238.175.107])
  by fmsmga008.fm.intel.com with ESMTP; 14 Feb 2022 03:29:50 -0800
From:   Tianfei zhang <tianfei.zhang@intel.com>
To:     hao.wu@intel.com, trix@redhat.com, mdf@kernel.org,
        yilun.xu@intel.com, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     corbet@lwn.net, Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Tianfei Zhang <tianfei.zhang@intel.com>
Subject: [PATCH v1 7/7] fpga: dfl: pci: Add generic OFS PCI PID
Date:   Mon, 14 Feb 2022 06:26:19 -0500
Message-Id: <20220214112619.219761-8-tianfei.zhang@intel.com>
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

Add the PCI product id for an Open FPGA Stack PCI card.

Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
---
 drivers/fpga/dfl-pci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
index 83b604d6dbe6..cb2fbf3eb918 100644
--- a/drivers/fpga/dfl-pci.c
+++ b/drivers/fpga/dfl-pci.c
@@ -76,12 +76,14 @@ static void cci_pci_free_irq(struct pci_dev *pcidev)
 #define PCIE_DEVICE_ID_INTEL_PAC_D5005		0x0B2B
 #define PCIE_DEVICE_ID_SILICOM_PAC_N5010	0x1000
 #define PCIE_DEVICE_ID_SILICOM_PAC_N5011	0x1001
+#define PCIE_DEVICE_ID_INTEL_OFS		0xbcce
 
 /* VF Device */
 #define PCIE_DEVICE_ID_VF_INT_5_X		0xBCBF
 #define PCIE_DEVICE_ID_VF_INT_6_X		0xBCC1
 #define PCIE_DEVICE_ID_VF_DSC_1_X		0x09C5
 #define PCIE_DEVICE_ID_INTEL_PAC_D5005_VF	0x0B2C
+#define PCIE_DEVICE_ID_INTEL_OFS_VF		0xbccf
 
 static struct pci_device_id cci_pcie_id_tbl[] = {
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_PF_INT_5_X),},
@@ -95,6 +97,8 @@ static struct pci_device_id cci_pcie_id_tbl[] = {
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_INTEL_PAC_D5005_VF),},
 	{PCI_DEVICE(PCI_VENDOR_ID_SILICOM_DENMARK, PCIE_DEVICE_ID_SILICOM_PAC_N5010),},
 	{PCI_DEVICE(PCI_VENDOR_ID_SILICOM_DENMARK, PCIE_DEVICE_ID_SILICOM_PAC_N5011),},
+	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_INTEL_OFS),},
+	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_INTEL_OFS_VF),},
 	{0,}
 };
 MODULE_DEVICE_TABLE(pci, cci_pcie_id_tbl);
-- 
2.17.1


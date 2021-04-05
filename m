Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ADFE354979
	for <lists+linux-fpga@lfdr.de>; Tue,  6 Apr 2021 01:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242166AbhDEXvw (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 5 Apr 2021 19:51:52 -0400
Received: from mga02.intel.com ([134.134.136.20]:3167 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242157AbhDEXvv (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 5 Apr 2021 19:51:51 -0400
IronPort-SDR: AxIBdlyKHCmY2r1nuaDAQPHUgGTQLlR9ww0EmSA27Ne4gfqMXQG7Pml7wr879k4I02iOfZCGae
 gezO3AKWhWzg==
X-IronPort-AV: E=McAfee;i="6000,8403,9945"; a="180076754"
X-IronPort-AV: E=Sophos;i="5.81,308,1610438400"; 
   d="scan'208";a="180076754"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2021 16:51:44 -0700
IronPort-SDR: kjkCgB+AWNP8QgE1MSBETZkv6egEpy0i54+a3LpQTAs8bmHZckv07ziAoQUmqLttP33gJAlzky
 grNHd5+LcX8w==
X-IronPort-AV: E=Sophos;i="5.81,308,1610438400"; 
   d="scan'208";a="414501839"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.42])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2021 16:51:43 -0700
From:   matthew.gerlach@linux.intel.com
To:     hao.wu@intel.com, trix@redhat.com, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        yilun.xu@intel.com, jdelvare@suse.com, linux@roeck-us.net,
        lee.jones@linaro.org, linux-hwmon@vger.kernel.org,
        russell.h.weight@linux.intel.com
Cc:     Russ Weight <russell.h.weight@intel.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: [PATCH 1/3] fpga: dfl: pci: add DID for D5005 PAC cards
Date:   Mon,  5 Apr 2021 16:52:59 -0700
Message-Id: <20210405235301.187542-2-matthew.gerlach@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210405235301.187542-1-matthew.gerlach@linux.intel.com>
References: <20210405235301.187542-1-matthew.gerlach@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Russ Weight <russell.h.weight@intel.com>

This patch adds the approved PCI Express Device IDs for the
PF and VF for the card for D5005 PAC cards.

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
---
 drivers/fpga/dfl-pci.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
index 04e47e2..b44523e 100644
--- a/drivers/fpga/dfl-pci.c
+++ b/drivers/fpga/dfl-pci.c
@@ -69,14 +69,16 @@ static void cci_pci_free_irq(struct pci_dev *pcidev)
 }
 
 /* PCI Device ID */
-#define PCIE_DEVICE_ID_PF_INT_5_X	0xBCBD
-#define PCIE_DEVICE_ID_PF_INT_6_X	0xBCC0
-#define PCIE_DEVICE_ID_PF_DSC_1_X	0x09C4
-#define PCIE_DEVICE_ID_INTEL_PAC_N3000	0x0B30
+#define PCIE_DEVICE_ID_PF_INT_5_X		0xBCBD
+#define PCIE_DEVICE_ID_PF_INT_6_X		0xBCC0
+#define PCIE_DEVICE_ID_PF_DSC_1_X		0x09C4
+#define PCIE_DEVICE_ID_INTEL_PAC_N3000		0x0B30
+#define PCIE_DEVICE_ID_INTEL_PAC_D5005		0x0B2B
 /* VF Device */
-#define PCIE_DEVICE_ID_VF_INT_5_X	0xBCBF
-#define PCIE_DEVICE_ID_VF_INT_6_X	0xBCC1
-#define PCIE_DEVICE_ID_VF_DSC_1_X	0x09C5
+#define PCIE_DEVICE_ID_VF_INT_5_X		0xBCBF
+#define PCIE_DEVICE_ID_VF_INT_6_X		0xBCC1
+#define PCIE_DEVICE_ID_VF_DSC_1_X		0x09C5
+#define PCIE_DEVICE_ID_INTEL_PAC_D5005_VF	0x0B2C
 
 static struct pci_device_id cci_pcie_id_tbl[] = {
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_PF_INT_5_X),},
@@ -86,6 +88,8 @@ static void cci_pci_free_irq(struct pci_dev *pcidev)
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_PF_DSC_1_X),},
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_VF_DSC_1_X),},
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_INTEL_PAC_N3000),},
+	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_INTEL_PAC_D5005),},
+	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_INTEL_PAC_D5005_VF),},
 	{0,}
 };
 MODULE_DEVICE_TABLE(pci, cci_pcie_id_tbl);
-- 
1.8.3.1


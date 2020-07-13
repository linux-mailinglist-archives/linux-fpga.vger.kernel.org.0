Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D88B21CCE3
	for <lists+linux-fpga@lfdr.de>; Mon, 13 Jul 2020 03:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbgGMBv5 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 12 Jul 2020 21:51:57 -0400
Received: from mga14.intel.com ([192.55.52.115]:20262 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726261AbgGMBv5 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sun, 12 Jul 2020 21:51:57 -0400
IronPort-SDR: 0e71ysOWhlUbK/qYthGl6qXBCi2ZW2UwmGNcXNmRS33mIn6c5j1aNaKSd3dCQvCsDHPguSVTej
 Dr1sare8bq0g==
X-IronPort-AV: E=McAfee;i="6000,8403,9680"; a="147660851"
X-IronPort-AV: E=Sophos;i="5.75,345,1589266800"; 
   d="scan'208";a="147660851"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2020 18:51:56 -0700
IronPort-SDR: T3rQIr2AvbUkUYA0Lr1/+D8PwdSqBWaDwtZ7A0BFDgFJoEgilqL0zg0V6QkI0sQuVjbE+rCC3L
 KqS7DZnOoSCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,345,1589266800"; 
   d="scan'208";a="484847589"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by fmsmga006.fm.intel.com with ESMTP; 12 Jul 2020 18:51:54 -0700
From:   Xu Yilun <yilun.xu@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        Wu Hao <hao.wu@intel.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v2] fpga: dfl: pci: add device id for Intel FPGA PAC N3000
Date:   Mon, 13 Jul 2020 09:47:46 +0800
Message-Id: <1594604866-30877-1-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Add PCIe Device ID for Intel FPGA PAC N3000.

Signed-off-by: Wu Hao <hao.wu@intel.com>
Signed-off-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Reviewed-by: Wu Hao <hao.wu@intel.com>
Reviewed-by: Tom Rix <trix@redhat.com>
---
 drivers/fpga/dfl-pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
index 73b5153..e220bec 100644
--- a/drivers/fpga/dfl-pci.c
+++ b/drivers/fpga/dfl-pci.c
@@ -64,6 +64,7 @@ static void cci_pci_free_irq(struct pci_dev *pcidev)
 #define PCIE_DEVICE_ID_PF_INT_5_X	0xBCBD
 #define PCIE_DEVICE_ID_PF_INT_6_X	0xBCC0
 #define PCIE_DEVICE_ID_PF_DSC_1_X	0x09C4
+#define PCIE_DEVICE_ID_INTEL_PAC_N3000	0x0B30
 /* VF Device */
 #define PCIE_DEVICE_ID_VF_INT_5_X	0xBCBF
 #define PCIE_DEVICE_ID_VF_INT_6_X	0xBCC1
@@ -76,6 +77,7 @@ static struct pci_device_id cci_pcie_id_tbl[] = {
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_VF_INT_6_X),},
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_PF_DSC_1_X),},
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_VF_DSC_1_X),},
+	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_INTEL_PAC_N3000),},
 	{0,}
 };
 MODULE_DEVICE_TABLE(pci, cci_pcie_id_tbl);
-- 
2.7.4


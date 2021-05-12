Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D71937B3DA
	for <lists+linux-fpga@lfdr.de>; Wed, 12 May 2021 03:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbhELCAZ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 11 May 2021 22:00:25 -0400
Received: from mail-dm6nam11on2046.outbound.protection.outlook.com ([40.107.223.46]:56033
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230196AbhELCAX (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 11 May 2021 22:00:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aHaWq8hpBPAPHM30Qk7ekbnzZ9C7OGjCqSDtcq6FS8Q9BdNGm5yjyVzhYmj06Iopz+szL0choBnKhBiU2KAUtvxX3Tv0sE3bWlbhWNnxBDnZjGyyT+zR9PoYkCfkAjGYVGXo9FzTGZBzj2xkh2iO1nmf6v3ODY+vNOyu/6VCY0Zp20iuwRNzhoboS1bSqhc+E2dWxrVk/Y9xW3qSojCWyBioNzYE8pVBv2qOyPuhhZWXSz5X5mqEZFnq+sG7jbcvBuc7hFIgB2Dwo9kpIS3/kXeBIRYu+Oe1t+QBor3nm/uo3pV4yNtaECtdIoz4+QxfpK/uUAZPJsdhG1PX9qhLeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qf3UZzc72eCQiDdDldm1ViikonO6NLeCIrav8se8DFI=;
 b=lKq5De/15qGl51VX1c1TeGVHR616iSJ4pMS5havoB3LfIKfB/W8mLWa3qByEUTtdwRhWBwtuWBP06xvMtOtu3BeIgkw8xiAB5ThR5g/UIhp4MnNvhsTEtbQ3Ggj/yP8bBah87/o+48Wwd2cwWTqAf8rZji623cNK8ig4Rjyd+TDwd83GI08/BwoexZjoOuYCHVeBIU2E52KSx2ZYS+VPLj0vsko3Hd0k2AH2/8YuUZK9dPY8I96wnr1eZi3f9iLtqnuNvI0g4k5fbzttcoFCbmY3St6yZkqjsFwpRbAnNOTYFFNm1WTsMj2XBn4Z3k0mLF1NJ95gARe7C1gaBCoX5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qf3UZzc72eCQiDdDldm1ViikonO6NLeCIrav8se8DFI=;
 b=HhNCGnoexkdfqU+AkzIextlXNLS0NyVB7jynvDi8F6nny1CSZDNUxhfC6sQkaloZkG83e60rVnERgMdNTMmq48kBHTZsaU4zfWHkpJAqqFtIK4UMXb+tyDT84NWGLDXJ/selgCzPUBz1oj8HSff538ODj2UOTTblpAB7hkxtqzc=
Received: from BN0PR04CA0193.namprd04.prod.outlook.com (2603:10b6:408:e9::18)
 by CO6PR02MB7540.namprd02.prod.outlook.com (2603:10b6:303:b1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Wed, 12 May
 2021 01:59:14 +0000
Received: from BN1NAM02FT046.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:e9:cafe::f8) by BN0PR04CA0193.outlook.office365.com
 (2603:10b6:408:e9::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24 via Frontend
 Transport; Wed, 12 May 2021 01:59:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT046.mail.protection.outlook.com (10.13.3.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4065.21 via Frontend Transport; Wed, 12 May 2021 01:59:14 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 11 May 2021 18:59:07 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Tue, 11 May 2021 18:59:07 -0700
Envelope-to: mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.72.212] (port=35730 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1lge9T-0001bV-75; Tue, 11 May 2021 18:59:07 -0700
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id 6D07460012E; Tue, 11 May 2021 18:53:45 -0700 (PDT)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>, Max Zhen <max.zhen@xilinx.com>
Subject: [PATCH V6 XRT Alveo 09/20] fpga: xrt: management physical function driver (root)
Date:   Tue, 11 May 2021 18:53:28 -0700
Message-ID: <20210512015339.5649-10-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210512015339.5649-1-lizhi.hou@xilinx.com>
References: <20210512015339.5649-1-lizhi.hou@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca1afed2-1f7e-46d8-729f-08d914e98b17
X-MS-TrafficTypeDiagnostic: CO6PR02MB7540:
X-Microsoft-Antispam-PRVS: <CO6PR02MB7540A65961915680D2C5F1F9A1529@CO6PR02MB7540.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:326;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aZs3dwfd4Ur8uX4OzEE/Y/5sBZkimVosaxUSlUon99z6cga1V3tfFs4CM4cFvxnNNVHopjNJxcEiU56NISvnxmYNfVRpQ1yvnJIvMuZz6h6hb0G9M2S9gnFzFIzA0OtOiA9K4jt2AZTVP/ABqSd8vDbTdIRwTxycsdO6O/JQKbDnvtoIR0p2Rpm8DH4NDrMur2vIIBOaL8uRSJwpQ/a0KigaoGSpXnl6/xMLMh3IMHrhdl8kOtUkUFmxT1VpZuchAVALsvmv0vYOjK2zXnHlcaioedSrMW2QTY9EvPzv0LqSP+sIxRo11wtFtX2FwssErniy34SBVDoV4ji16Ynt8eeI2/9ORaj8LaYfFTZxhTf2Odih19Rms1bGdohB0TqxIUuzAD4KhsnFIFxPkJXFHr732dhRd5IBGCcW0wELmDgKXNy1g03RBKF+oSebhujk6Myafj2ULVeVIxl77CjP5GRqXXf1hQNz7VLKtDerKzJnKMNx/+vriAHG5H0ve9ImSxLPrdPRSoY2XBiqbBNKDVCUZGyzhfg/k1muR1b1Xs7aDxDhLe74sudjlPaxNffrK/lNDYyutjV2RgIR+75ocDlFtK6pKaZ9rURCPPugjGXj4RYirYqbIp77aDlmm/UBe8bYz22vYsPnMv1lfWqNyWDhNuQ+bV/OrV1ruySG7dE=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(396003)(39860400002)(46966006)(36840700001)(42186006)(316002)(83380400001)(36906005)(1076003)(54906003)(6666004)(6916009)(107886003)(44832011)(7636003)(36756003)(82310400003)(356005)(82740400003)(30864003)(426003)(478600001)(336012)(2616005)(2906002)(186003)(26005)(36860700001)(5660300002)(8676002)(8936002)(6266002)(70586007)(70206006)(4326008)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 01:59:14.1731
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca1afed2-1f7e-46d8-729f-08d914e98b17
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT046.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7540
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The PCIE device driver which attaches to management function on Alveo
devices. It instantiates one or more group drivers which, in turn,
instantiate xrt drivers. The instantiation of group and xrt drivers is
completely dtb driven.

Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
Signed-off-by: Max Zhen <max.zhen@xilinx.com>
Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
Reviewed-by: Tom Rix <trix@redhat.com>
---
 drivers/fpga/xrt/mgmt/root.c | 420 +++++++++++++++++++++++++++++++++++
 1 file changed, 420 insertions(+)
 create mode 100644 drivers/fpga/xrt/mgmt/root.c

diff --git a/drivers/fpga/xrt/mgmt/root.c b/drivers/fpga/xrt/mgmt/root.c
new file mode 100644
index 000000000000..9f3c806a9eaa
--- /dev/null
+++ b/drivers/fpga/xrt/mgmt/root.c
@@ -0,0 +1,420 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx Alveo Management Function Driver
+ *
+ * Copyright (C) 2020-2021 Xilinx, Inc.
+ *
+ * Authors:
+ *	Cheng Zhen <maxz@xilinx.com>
+ */
+
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/aer.h>
+#include <linux/vmalloc.h>
+#include <linux/delay.h>
+
+#include "xroot.h"
+#include "xmgmt.h"
+#include "metadata.h"
+
+#define XMGMT_MODULE_NAME	"xrt-mgmt"
+#define XMGMT_DRIVER_VERSION	"4.0.0"
+
+#define XMGMT_PDEV(xm)		((xm)->pdev)
+#define XMGMT_DEV(xm)		(&(XMGMT_PDEV(xm)->dev))
+#define xmgmt_err(xm, fmt, args...)	\
+	dev_err(XMGMT_DEV(xm), "%s: " fmt, __func__, ##args)
+#define xmgmt_warn(xm, fmt, args...)	\
+	dev_warn(XMGMT_DEV(xm), "%s: " fmt, __func__, ##args)
+#define xmgmt_info(xm, fmt, args...)	\
+	dev_info(XMGMT_DEV(xm), "%s: " fmt, __func__, ##args)
+#define xmgmt_dbg(xm, fmt, args...)	\
+	dev_dbg(XMGMT_DEV(xm), "%s: " fmt, __func__, ##args)
+#define XMGMT_DEV_ID(_pcidev)			\
+	({ typeof(_pcidev) (pcidev) = (_pcidev);	\
+	((pci_domain_nr((pcidev)->bus) << 16) |	\
+	PCI_DEVID((pcidev)->bus->number, 0)); })
+#define XRT_VSEC_ID		0x20
+#define XRT_MAX_READRQ		512
+
+static struct class *xmgmt_class;
+
+/* PCI Device IDs */
+/*
+ * Golden image is preloaded on the device when it is shipped to customer.
+ * Then, customer can load other shells (from Xilinx or some other vendor).
+ * If something goes wrong with the shell, customer can always go back to
+ * golden and start over again.
+ */
+#define PCI_DEVICE_ID_U50_GOLDEN	0xD020
+#define PCI_DEVICE_ID_U50		0x5020
+static const struct pci_device_id xmgmt_pci_ids[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_XILINX, PCI_DEVICE_ID_U50_GOLDEN), }, /* Alveo U50 (golden) */
+	{ PCI_DEVICE(PCI_VENDOR_ID_XILINX, PCI_DEVICE_ID_U50), }, /* Alveo U50 */
+	{ 0, }
+};
+
+struct xmgmt {
+	struct pci_dev *pdev;
+	void *root;
+
+	bool ready;
+};
+
+static int xmgmt_config_pci(struct xmgmt *xm)
+{
+	struct pci_dev *pdev = XMGMT_PDEV(xm);
+	int rc;
+
+	rc = pcim_enable_device(pdev);
+	if (rc < 0) {
+		xmgmt_err(xm, "failed to enable device: %d", rc);
+		return rc;
+	}
+
+	rc = pci_enable_pcie_error_reporting(pdev);
+	if (rc)
+		xmgmt_warn(xm, "failed to enable AER: %d", rc);
+
+	pci_set_master(pdev);
+
+	rc = pcie_get_readrq(pdev);
+	if (rc > XRT_MAX_READRQ)
+		pcie_set_readrq(pdev, XRT_MAX_READRQ);
+	return 0;
+}
+
+static int xmgmt_match_slot_and_save(struct device *dev, void *data)
+{
+	struct xmgmt *xm = data;
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	if (XMGMT_DEV_ID(pdev) == XMGMT_DEV_ID(xm->pdev)) {
+		pci_cfg_access_lock(pdev);
+		pci_save_state(pdev);
+	}
+
+	return 0;
+}
+
+static void xmgmt_pci_save_config_all(struct xmgmt *xm)
+{
+	bus_for_each_dev(&pci_bus_type, NULL, xm, xmgmt_match_slot_and_save);
+}
+
+static int xmgmt_match_slot_and_restore(struct device *dev, void *data)
+{
+	struct xmgmt *xm = data;
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	if (XMGMT_DEV_ID(pdev) == XMGMT_DEV_ID(xm->pdev)) {
+		pci_restore_state(pdev);
+		pci_cfg_access_unlock(pdev);
+	}
+
+	return 0;
+}
+
+static void xmgmt_pci_restore_config_all(struct xmgmt *xm)
+{
+	bus_for_each_dev(&pci_bus_type, NULL, xm, xmgmt_match_slot_and_restore);
+}
+
+static void xmgmt_root_hot_reset(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct pci_bus *bus;
+	u16 pci_cmd, devctl;
+	struct xmgmt *xm;
+	u8 pci_bctl;
+	int i, ret;
+
+	xm = pci_get_drvdata(pdev);
+	xmgmt_info(xm, "hot reset start");
+	xmgmt_pci_save_config_all(xm);
+	pci_disable_device(pdev);
+	bus = pdev->bus;
+
+	/*
+	 * When flipping the SBR bit, device can fall off the bus. This is
+	 * usually no problem at all so long as drivers are working properly
+	 * after SBR. However, some systems complain bitterly when the device
+	 * falls off the bus.
+	 * The quick solution is to temporarily disable the SERR reporting of
+	 * switch port during SBR.
+	 */
+
+	pci_read_config_word(bus->self, PCI_COMMAND, &pci_cmd);
+	pci_write_config_word(bus->self, PCI_COMMAND, (pci_cmd & ~PCI_COMMAND_SERR));
+	pcie_capability_read_word(bus->self, PCI_EXP_DEVCTL, &devctl);
+	pcie_capability_write_word(bus->self, PCI_EXP_DEVCTL, (devctl & ~PCI_EXP_DEVCTL_FERE));
+	pci_read_config_byte(bus->self, PCI_BRIDGE_CONTROL, &pci_bctl);
+	pci_write_config_byte(bus->self, PCI_BRIDGE_CONTROL, pci_bctl | PCI_BRIDGE_CTL_BUS_RESET);
+	msleep(100);
+	pci_write_config_byte(bus->self, PCI_BRIDGE_CONTROL, pci_bctl);
+	ssleep(1);
+
+	pcie_capability_write_word(bus->self, PCI_EXP_DEVCTL, devctl);
+	pci_write_config_word(bus->self, PCI_COMMAND, pci_cmd);
+
+	ret = pci_enable_device(pdev);
+	if (ret)
+		xmgmt_err(xm, "failed to enable device, ret %d", ret);
+
+	for (i = 0; i < 300; i++) {
+		pci_read_config_word(pdev, PCI_COMMAND, &pci_cmd);
+		if (pci_cmd != 0xffff)
+			break;
+		msleep(20);
+	}
+	if (i == 300)
+		xmgmt_err(xm, "timed out waiting for device to be online after reset");
+
+	xmgmt_info(xm, "waiting for %d ms", i * 20);
+	xmgmt_pci_restore_config_all(xm);
+	xmgmt_config_pci(xm);
+}
+
+static int xmgmt_add_vsec_node(struct xmgmt *xm, char *dtb)
+{
+	struct pci_dev *pdev = XMGMT_PDEV(xm);
+	struct xrt_md_endpoint ep = { 0 };
+	struct device *dev = DEV(pdev);
+	u32 off_low, off_high, header;
+	int cap = 0, ret = 0;
+	__be32 vsec_bar;
+	__be64 vsec_off;
+
+	while ((cap = pci_find_next_ext_capability(pdev, cap, PCI_EXT_CAP_ID_VNDR))) {
+		pci_read_config_dword(pdev, cap + PCI_VNDR_HEADER, &header);
+		if (PCI_VNDR_HEADER_ID(header) == XRT_VSEC_ID)
+			break;
+	}
+	if (!cap) {
+		xmgmt_info(xm, "No Vendor Specific Capability.");
+		return -ENOENT;
+	}
+
+	if (pci_read_config_dword(pdev, cap + 8, &off_low) ||
+	    pci_read_config_dword(pdev, cap + 12, &off_high)) {
+		xmgmt_err(xm, "pci_read vendor specific failed.");
+		return -EINVAL;
+	}
+
+	ep.ep_name = XRT_MD_NODE_VSEC;
+	ret = xrt_md_add_endpoint(dev, dtb, &ep);
+	if (ret) {
+		xmgmt_err(xm, "add vsec metadata failed, ret %d", ret);
+		goto failed;
+	}
+
+	vsec_bar = cpu_to_be32(off_low & 0xf);
+	ret = xrt_md_set_prop(dev, dtb, XRT_MD_NODE_VSEC, NULL,
+			      XRT_MD_PROP_BAR_IDX, &vsec_bar, sizeof(vsec_bar));
+	if (ret) {
+		xmgmt_err(xm, "add vsec bar idx failed, ret %d", ret);
+		goto failed;
+	}
+
+	vsec_off = cpu_to_be64(((u64)off_high << 32) | (off_low & ~0xfU));
+	ret = xrt_md_set_prop(dev, dtb, XRT_MD_NODE_VSEC, NULL,
+			      XRT_MD_PROP_OFFSET, &vsec_off, sizeof(vsec_off));
+	if (ret) {
+		xmgmt_err(xm, "add vsec offset failed, ret %d", ret);
+		goto failed;
+	}
+
+failed:
+	return ret;
+}
+
+static int xmgmt_create_root_metadata(struct xmgmt *xm, char **root_dtb)
+{
+	char *dtb = NULL;
+	int ret;
+
+	ret = xrt_md_create(XMGMT_DEV(xm), &dtb);
+	if (ret) {
+		xmgmt_err(xm, "create metadata failed, ret %d", ret);
+		goto failed;
+	}
+
+	ret = xmgmt_add_vsec_node(xm, dtb);
+	if (ret == -ENOENT) {
+		/*
+		 * We may be dealing with a MFG board.
+		 * Try vsec-golden which will bring up all hard-coded leaves
+		 * at hard-coded offsets.
+		 */
+		ret = xroot_add_simple_node(xm->root, dtb, XRT_MD_NODE_VSEC_GOLDEN);
+	} else if (ret == 0) {
+		ret = xroot_add_simple_node(xm->root, dtb, XRT_MD_NODE_MGMT_MAIN);
+	}
+	if (ret)
+		goto failed;
+
+	*root_dtb = dtb;
+	return 0;
+
+failed:
+	vfree(dtb);
+	return ret;
+}
+
+static ssize_t ready_show(struct device *dev,
+			  struct device_attribute *da,
+			  char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct xmgmt *xm = pci_get_drvdata(pdev);
+
+	return sprintf(buf, "%d\n", xm->ready);
+}
+static DEVICE_ATTR_RO(ready);
+
+static struct attribute *xmgmt_root_attrs[] = {
+	&dev_attr_ready.attr,
+	NULL
+};
+
+static struct attribute_group xmgmt_root_attr_group = {
+	.attrs = xmgmt_root_attrs,
+};
+
+static void xmgmt_root_get_id(struct device *dev, struct xrt_root_get_id *rid)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	rid->xpigi_vendor_id = pdev->vendor;
+	rid->xpigi_device_id = pdev->device;
+	rid->xpigi_sub_vendor_id = pdev->subsystem_vendor;
+	rid->xpigi_sub_device_id = pdev->subsystem_device;
+}
+
+static int xmgmt_root_get_resource(struct device *dev, struct xrt_root_get_res *res)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct xmgmt *xm;
+
+	xm = pci_get_drvdata(pdev);
+	if (res->xpigr_region_id > PCI_STD_RESOURCE_END) {
+		xmgmt_err(xm, "Invalid bar idx %d", res->xpigr_region_id);
+		return -EINVAL;
+	}
+
+	res->xpigr_res = &pdev->resource[res->xpigr_region_id];
+	return 0;
+}
+
+static struct xroot_physical_function_callback xmgmt_xroot_pf_cb = {
+	.xpc_get_id = xmgmt_root_get_id,
+	.xpc_get_resource = xmgmt_root_get_resource,
+	.xpc_hot_reset = xmgmt_root_hot_reset,
+};
+
+static int xmgmt_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	int ret;
+	struct device *dev = &pdev->dev;
+	struct xmgmt *xm = devm_kzalloc(dev, sizeof(*xm), GFP_KERNEL);
+	char *dtb = NULL;
+
+	if (!xm)
+		return -ENOMEM;
+	xm->pdev = pdev;
+	pci_set_drvdata(pdev, xm);
+
+	ret = xmgmt_config_pci(xm);
+	if (ret)
+		goto failed;
+
+	ret = xroot_probe(&pdev->dev, &xmgmt_xroot_pf_cb, &xm->root);
+	if (ret)
+		goto failed;
+
+	ret = xmgmt_create_root_metadata(xm, &dtb);
+	if (ret)
+		goto failed_metadata;
+
+	ret = xroot_create_group(xm->root, dtb);
+	vfree(dtb);
+	if (ret)
+		xmgmt_err(xm, "failed to create root group: %d", ret);
+
+	if (!xroot_wait_for_bringup(xm->root))
+		xmgmt_err(xm, "failed to bringup all groups");
+	else
+		xm->ready = true;
+
+	ret = sysfs_create_group(&pdev->dev.kobj, &xmgmt_root_attr_group);
+	if (ret) {
+		/* Warning instead of failing the probe. */
+		xmgmt_warn(xm, "create xmgmt root attrs failed: %d", ret);
+	}
+
+	xroot_broadcast(xm->root, XRT_EVENT_POST_CREATION);
+	xmgmt_info(xm, "%s started successfully", XMGMT_MODULE_NAME);
+	return 0;
+
+failed_metadata:
+	xroot_remove(xm->root);
+failed:
+	pci_set_drvdata(pdev, NULL);
+	return ret;
+}
+
+static void xmgmt_remove(struct pci_dev *pdev)
+{
+	struct xmgmt *xm = pci_get_drvdata(pdev);
+
+	xroot_broadcast(xm->root, XRT_EVENT_PRE_REMOVAL);
+	sysfs_remove_group(&pdev->dev.kobj, &xmgmt_root_attr_group);
+	xroot_remove(xm->root);
+	pci_disable_pcie_error_reporting(xm->pdev);
+	xmgmt_info(xm, "%s cleaned up successfully", XMGMT_MODULE_NAME);
+}
+
+static struct pci_driver xmgmt_driver = {
+	.name = XMGMT_MODULE_NAME,
+	.id_table = xmgmt_pci_ids,
+	.probe = xmgmt_probe,
+	.remove = xmgmt_remove,
+};
+
+static int __init xmgmt_init(void)
+{
+	int res = 0;
+
+	res = xmgmt_register_leaf();
+	if (res)
+		return res;
+
+	xmgmt_class = class_create(THIS_MODULE, XMGMT_MODULE_NAME);
+	if (IS_ERR(xmgmt_class))
+		return PTR_ERR(xmgmt_class);
+
+	res = pci_register_driver(&xmgmt_driver);
+	if (res) {
+		class_destroy(xmgmt_class);
+		return res;
+	}
+
+	return 0;
+}
+
+static __exit void xmgmt_exit(void)
+{
+	pci_unregister_driver(&xmgmt_driver);
+	class_destroy(xmgmt_class);
+	xmgmt_unregister_leaf();
+}
+
+module_init(xmgmt_init);
+module_exit(xmgmt_exit);
+
+MODULE_DEVICE_TABLE(pci, xmgmt_pci_ids);
+MODULE_VERSION(XMGMT_DRIVER_VERSION);
+MODULE_AUTHOR("XRT Team <runtime@xilinx.com>");
+MODULE_DESCRIPTION("Xilinx Alveo management function driver");
+MODULE_LICENSE("GPL v2");
-- 
2.27.0


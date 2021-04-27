Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE3036CD80
	for <lists+linux-fpga@lfdr.de>; Tue, 27 Apr 2021 23:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239077AbhD0VBb (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 27 Apr 2021 17:01:31 -0400
Received: from mail-dm6nam11on2079.outbound.protection.outlook.com ([40.107.223.79]:48629
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239033AbhD0VBa (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 27 Apr 2021 17:01:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eNOf54S9/GloPyrYtwP5c/4q2C+xlUX98sh4esMmMRWmD/ruUcEHIpMuzmpQEMwS0gRNvh5mriinMbEtmidds+p+gi+lff/eX+CCLZveJpoAajuv87fFutBQJUve54vX5XZcgtyErWDQ/Q9qLP+oF6cGmYO9sOlnWYFpGxtmFoPKfJ7yvwLkCs6322JFv1KXu+/RxfVR9IrkpVh/gYQShYiqRtRsgXv9RWPuGhoErWgvwHB4FC7V1fW5dyj94t7JtAn+kVwF0iI/FBG0fjMOjdELtTLza6F3XqRqC3ISkBXBNPyPQhR5iqr7EgNhqbBog3bT/ban/UOtxU8GJVThOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H8RScGIDoWdluaumJYlIDkx0teTWbdmTltU+s7uRyFo=;
 b=A4DuIsq1MpTzLjoxuk0wfm1e2P4i+3gmv209zQQyxwVTnGVvh9Ruh9dQyh3SZoYRuQ7RYjo0rsSWAAE7XeiDGUHGIPFb2fTB+iOglLMZjLKOMrNUC3axMD2UrSmRsKz0U8pkxiocBZ5fI0VFFTKgYKJQeIkp2/XDxZvGEKaBQIddNPnv+3hNGvzwLi0INwzWlj4cQgYsRlMs70bEac7bTnL0oPNCYq/aWU6cVReB/galel/7AclPOd0nMlCm8sLrmBTuPsl13jd98dQEgzuhuyg3HpCNYiH4Vd5qfAlD3oKWSp4/ix3t/4sQFG1hO/I7jcszVMwB7/MK1CLwgRtnfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H8RScGIDoWdluaumJYlIDkx0teTWbdmTltU+s7uRyFo=;
 b=KvBR7e+cNwhEA9I6LMfDoiR4DcqHQTHvMbFS6PMF3ZAXHRNfSNXXJJgEfv8b9mbBXQWsoSBGRwKjbGfyFCuDojWADUmf6QMHESyPD8aPeID7FzIzCQZCA6XzD1ZZJ0mlS85ktg2zE1oxI7rQImgNtXf2uVlvf21CrMhyBND9Jl4=
Received: from CY4PR1101CA0003.namprd11.prod.outlook.com
 (2603:10b6:910:15::13) by CO6PR02MB7794.namprd02.prod.outlook.com
 (2603:10b6:303:b1::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Tue, 27 Apr
 2021 21:00:45 +0000
Received: from CY1NAM02FT052.eop-nam02.prod.protection.outlook.com
 (2603:10b6:910:15:cafe::ab) by CY4PR1101CA0003.outlook.office365.com
 (2603:10b6:910:15::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.26 via Frontend
 Transport; Tue, 27 Apr 2021 21:00:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 CY1NAM02FT052.mail.protection.outlook.com (10.152.74.123) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4065.21 via Frontend Transport; Tue, 27 Apr 2021 21:00:44 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 27 Apr 2021 13:59:38 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Tue, 27 Apr 2021 13:59:38 -0700
Envelope-to: mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.72.212] (port=52014 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1lbUny-0001qO-0m; Tue, 27 Apr 2021 13:59:38 -0700
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id E32B260012C; Tue, 27 Apr 2021 13:54:35 -0700 (PDT)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>, Max Zhen <max.zhen@xilinx.com>
Subject: [PATCH V5 XRT Alveo 09/20] fpga: xrt: management physical function driver (root)
Date:   Tue, 27 Apr 2021 13:54:20 -0700
Message-ID: <20210427205431.23896-10-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210427205431.23896-1-lizhi.hou@xilinx.com>
References: <20210427205431.23896-1-lizhi.hou@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a1d1d8d-520b-4cc3-97c7-08d909bf868e
X-MS-TrafficTypeDiagnostic: CO6PR02MB7794:
X-Microsoft-Antispam-PRVS: <CO6PR02MB77946C0E9D936970D03165DEA1419@CO6PR02MB7794.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:326;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F5sasERKQXxOlM7q7QDD0AWMgiHctcj63t5A8+tLvZ1Guo9IBh9cNLBv1SnKr/9QY2H2WA4BgEh6O79n6tnQuUqE0j/qK4dwGxfGfc5zWKtjyiWERlFLTe//iz2CjC797YCRrL4KRHtycyjVDQOvqwTwPyO1wuPUGn3NpAO2grThgs90NKMWk2ZGu/CKHxOoh0AsHekJLr0WhNOAGdWLtM37w/9YiLLrowCJCtt19a7EVzVG/rmqV+LIPKLOPCM4njLr4vomiOidTlD3cHSldQigtyBw9oRtstEYbbdiqVvbKhG/+/TmEWHBts7Jvn/5fCjcLxDqJBbdIci/YDWOHFw7gja6WA3VW/4yeyi1i8r4fiCMin6zeXJxOn/2HEru8fCU1kkqt73Drc3VRhrp9ThYzzom46z+DQLG5JbX+ROtimHQVBRLo+NAY4SHuRvOxvuc2NHr7HBmExbrM03mPnYYIYg+B3XJ0ysT76OURwdvsloYL5EFwiWnqEYfcB687kLQiH0YGWLfLN0j6tPD7b91eW026fQadF2agb36XBaBDIzlzLLs+lgyjSpT0etrUuXHwbOOSBI3z9KYY32uyqTp4S/yOszr7cDCR8aviSmuhXfr4jAdpz2T7mV+wqxmobirDyyS8qVFgmb4rwQiIYFKG1DmNQjlhnKWTZ386HE=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(396003)(39850400004)(136003)(346002)(376002)(46966006)(36840700001)(7636003)(426003)(107886003)(26005)(36756003)(356005)(1076003)(30864003)(44832011)(70206006)(70586007)(2906002)(83380400001)(6666004)(316002)(42186006)(8676002)(478600001)(8936002)(4326008)(36906005)(6916009)(336012)(82310400003)(47076005)(54906003)(36860700001)(186003)(5660300002)(6266002)(2616005)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2021 21:00:44.9902
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a1d1d8d-520b-4cc3-97c7-08d909bf868e
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT052.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7794
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
---
 drivers/fpga/xrt/mgnt/root.c | 419 +++++++++++++++++++++++++++++++++++
 1 file changed, 419 insertions(+)
 create mode 100644 drivers/fpga/xrt/mgnt/root.c

diff --git a/drivers/fpga/xrt/mgnt/root.c b/drivers/fpga/xrt/mgnt/root.c
new file mode 100644
index 000000000000..6e362e9d4b59
--- /dev/null
+++ b/drivers/fpga/xrt/mgnt/root.c
@@ -0,0 +1,419 @@
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
+#include "xmgnt.h"
+#include "metadata.h"
+
+#define XMGNT_MODULE_NAME	"xrt-mgnt"
+#define XMGNT_DRIVER_VERSION	"4.0.0"
+
+#define XMGNT_PDEV(xm)		((xm)->pdev)
+#define XMGNT_DEV(xm)		(&(XMGNT_PDEV(xm)->dev))
+#define xmgnt_err(xm, fmt, args...)	\
+	dev_err(XMGNT_DEV(xm), "%s: " fmt, __func__, ##args)
+#define xmgnt_warn(xm, fmt, args...)	\
+	dev_warn(XMGNT_DEV(xm), "%s: " fmt, __func__, ##args)
+#define xmgnt_info(xm, fmt, args...)	\
+	dev_info(XMGNT_DEV(xm), "%s: " fmt, __func__, ##args)
+#define xmgnt_dbg(xm, fmt, args...)	\
+	dev_dbg(XMGNT_DEV(xm), "%s: " fmt, __func__, ##args)
+#define XMGNT_DEV_ID(_pcidev)			\
+	({ typeof(_pcidev) (pcidev) = (_pcidev);	\
+	((pci_domain_nr((pcidev)->bus) << 16) |	\
+	PCI_DEVID((pcidev)->bus->number, 0)); })
+#define XRT_VSEC_ID		0x20
+#define XRT_MAX_READRQ		512
+
+static struct class *xmgnt_class;
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
+static const struct pci_device_id xmgnt_pci_ids[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_XILINX, PCI_DEVICE_ID_U50_GOLDEN), }, /* Alveo U50 (golden) */
+	{ PCI_DEVICE(PCI_VENDOR_ID_XILINX, PCI_DEVICE_ID_U50), }, /* Alveo U50 */
+	{ 0, }
+};
+
+struct xmgnt {
+	struct pci_dev *pdev;
+	void *root;
+
+	bool ready;
+};
+
+static int xmgnt_config_pci(struct xmgnt *xm)
+{
+	struct pci_dev *pdev = XMGNT_PDEV(xm);
+	int rc;
+
+	rc = pcim_enable_device(pdev);
+	if (rc < 0) {
+		xmgnt_err(xm, "failed to enable device: %d", rc);
+		return rc;
+	}
+
+	rc = pci_enable_pcie_error_reporting(pdev);
+	if (rc)
+		xmgnt_warn(xm, "failed to enable AER: %d", rc);
+
+	pci_set_master(pdev);
+
+	rc = pcie_get_readrq(pdev);
+	if (rc > XRT_MAX_READRQ)
+		pcie_set_readrq(pdev, XRT_MAX_READRQ);
+	return 0;
+}
+
+static int xmgnt_match_slot_and_save(struct device *dev, void *data)
+{
+	struct xmgnt *xm = data;
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	if (XMGNT_DEV_ID(pdev) == XMGNT_DEV_ID(xm->pdev)) {
+		pci_cfg_access_lock(pdev);
+		pci_save_state(pdev);
+	}
+
+	return 0;
+}
+
+static void xmgnt_pci_save_config_all(struct xmgnt *xm)
+{
+	bus_for_each_dev(&pci_bus_type, NULL, xm, xmgnt_match_slot_and_save);
+}
+
+static int xmgnt_match_slot_and_restore(struct device *dev, void *data)
+{
+	struct xmgnt *xm = data;
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	if (XMGNT_DEV_ID(pdev) == XMGNT_DEV_ID(xm->pdev)) {
+		pci_restore_state(pdev);
+		pci_cfg_access_unlock(pdev);
+	}
+
+	return 0;
+}
+
+static void xmgnt_pci_restore_config_all(struct xmgnt *xm)
+{
+	bus_for_each_dev(&pci_bus_type, NULL, xm, xmgnt_match_slot_and_restore);
+}
+
+static void xmgnt_root_hot_reset(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct pci_bus *bus;
+	u16 pci_cmd, devctl;
+	struct xmgnt *xm;
+	u8 pci_bctl;
+	int i, ret;
+
+	xm = pci_get_drvdata(pdev);
+	xmgnt_info(xm, "hot reset start");
+	xmgnt_pci_save_config_all(xm);
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
+		xmgnt_err(xm, "failed to enable device, ret %d", ret);
+
+	for (i = 0; i < 300; i++) {
+		pci_read_config_word(pdev, PCI_COMMAND, &pci_cmd);
+		if (pci_cmd != 0xffff)
+			break;
+		msleep(20);
+	}
+	if (i == 300)
+		xmgnt_err(xm, "timed out waiting for device to be online after reset");
+
+	xmgnt_info(xm, "waiting for %d ms", i * 20);
+	xmgnt_pci_restore_config_all(xm);
+	xmgnt_config_pci(xm);
+}
+
+static int xmgnt_add_vsec_node(struct xmgnt *xm, char *dtb)
+{
+	u32 off_low, off_high, vsec_bar, header;
+	struct pci_dev *pdev = XMGNT_PDEV(xm);
+	struct xrt_md_endpoint ep = { 0 };
+	struct device *dev = DEV(pdev);
+	int cap = 0, ret = 0;
+	u64 vsec_off;
+
+	while ((cap = pci_find_next_ext_capability(pdev, cap, PCI_EXT_CAP_ID_VNDR))) {
+		pci_read_config_dword(pdev, cap + PCI_VNDR_HEADER, &header);
+		if (PCI_VNDR_HEADER_ID(header) == XRT_VSEC_ID)
+			break;
+	}
+	if (!cap) {
+		xmgnt_info(xm, "No Vendor Specific Capability.");
+		return -ENOENT;
+	}
+
+	if (pci_read_config_dword(pdev, cap + 8, &off_low) ||
+	    pci_read_config_dword(pdev, cap + 12, &off_high)) {
+		xmgnt_err(xm, "pci_read vendor specific failed.");
+		return -EINVAL;
+	}
+
+	ep.ep_name = XRT_MD_NODE_VSEC;
+	ret = xrt_md_add_endpoint(dev, dtb, &ep);
+	if (ret) {
+		xmgnt_err(xm, "add vsec metadata failed, ret %d", ret);
+		goto failed;
+	}
+
+	vsec_bar = cpu_to_be32(off_low & 0xf);
+	ret = xrt_md_set_prop(dev, dtb, XRT_MD_NODE_VSEC, NULL,
+			      XRT_MD_PROP_BAR_IDX, &vsec_bar, sizeof(vsec_bar));
+	if (ret) {
+		xmgnt_err(xm, "add vsec bar idx failed, ret %d", ret);
+		goto failed;
+	}
+
+	vsec_off = cpu_to_be64(((u64)off_high << 32) | (off_low & ~0xfU));
+	ret = xrt_md_set_prop(dev, dtb, XRT_MD_NODE_VSEC, NULL,
+			      XRT_MD_PROP_OFFSET, &vsec_off, sizeof(vsec_off));
+	if (ret) {
+		xmgnt_err(xm, "add vsec offset failed, ret %d", ret);
+		goto failed;
+	}
+
+failed:
+	return ret;
+}
+
+static int xmgnt_create_root_metadata(struct xmgnt *xm, char **root_dtb)
+{
+	char *dtb = NULL;
+	int ret;
+
+	ret = xrt_md_create(XMGNT_DEV(xm), &dtb);
+	if (ret) {
+		xmgnt_err(xm, "create metadata failed, ret %d", ret);
+		goto failed;
+	}
+
+	ret = xmgnt_add_vsec_node(xm, dtb);
+	if (ret == -ENOENT) {
+		/*
+		 * We may be dealing with a MFG board.
+		 * Try vsec-golden which will bring up all hard-coded leaves
+		 * at hard-coded offsets.
+		 */
+		ret = xroot_add_simple_node(xm->root, dtb, XRT_MD_NODE_VSEC_GOLDEN);
+	} else if (ret == 0) {
+		ret = xroot_add_simple_node(xm->root, dtb, XRT_MD_NODE_MGNT_MAIN);
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
+	struct xmgnt *xm = pci_get_drvdata(pdev);
+
+	return sprintf(buf, "%d\n", xm->ready);
+}
+static DEVICE_ATTR_RO(ready);
+
+static struct attribute *xmgnt_root_attrs[] = {
+	&dev_attr_ready.attr,
+	NULL
+};
+
+static struct attribute_group xmgnt_root_attr_group = {
+	.attrs = xmgnt_root_attrs,
+};
+
+static void xmgnt_root_get_id(struct device *dev, struct xrt_root_get_id *rid)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	rid->xpigi_vendor_id = pdev->vendor;
+	rid->xpigi_device_id = pdev->device;
+	rid->xpigi_sub_vendor_id = pdev->subsystem_vendor;
+	rid->xpigi_sub_device_id = pdev->subsystem_device;
+}
+
+static int xmgnt_root_get_resource(struct device *dev, struct xrt_root_get_res *res)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct xmgnt *xm;
+
+	xm = pci_get_drvdata(pdev);
+	if (res->xpigr_region_id > PCI_STD_RESOURCE_END) {
+		xmgnt_err(xm, "Invalid bar idx %d", res->xpigr_region_id);
+		return -EINVAL;
+	}
+
+	res->xpigr_res = &pdev->resource[res->xpigr_region_id];
+	return 0;
+}
+
+static struct xroot_physical_function_callback xmgnt_xroot_pf_cb = {
+	.xpc_get_id = xmgnt_root_get_id,
+	.xpc_get_resource = xmgnt_root_get_resource,
+	.xpc_hot_reset = xmgnt_root_hot_reset,
+};
+
+static int xmgnt_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	int ret;
+	struct device *dev = &pdev->dev;
+	struct xmgnt *xm = devm_kzalloc(dev, sizeof(*xm), GFP_KERNEL);
+	char *dtb = NULL;
+
+	if (!xm)
+		return -ENOMEM;
+	xm->pdev = pdev;
+	pci_set_drvdata(pdev, xm);
+
+	ret = xmgnt_config_pci(xm);
+	if (ret)
+		goto failed;
+
+	ret = xroot_probe(&pdev->dev, &xmgnt_xroot_pf_cb, &xm->root);
+	if (ret)
+		goto failed;
+
+	ret = xmgnt_create_root_metadata(xm, &dtb);
+	if (ret)
+		goto failed_metadata;
+
+	ret = xroot_create_group(xm->root, dtb);
+	vfree(dtb);
+	if (ret)
+		xmgnt_err(xm, "failed to create root group: %d", ret);
+
+	if (!xroot_wait_for_bringup(xm->root))
+		xmgnt_err(xm, "failed to bringup all groups");
+	else
+		xm->ready = true;
+
+	ret = sysfs_create_group(&pdev->dev.kobj, &xmgnt_root_attr_group);
+	if (ret) {
+		/* Warning instead of failing the probe. */
+		xmgnt_warn(xm, "create xmgnt root attrs failed: %d", ret);
+	}
+
+	xroot_broadcast(xm->root, XRT_EVENT_POST_CREATION);
+	xmgnt_info(xm, "%s started successfully", XMGNT_MODULE_NAME);
+	return 0;
+
+failed_metadata:
+	xroot_remove(xm->root);
+failed:
+	pci_set_drvdata(pdev, NULL);
+	return ret;
+}
+
+static void xmgnt_remove(struct pci_dev *pdev)
+{
+	struct xmgnt *xm = pci_get_drvdata(pdev);
+
+	xroot_broadcast(xm->root, XRT_EVENT_PRE_REMOVAL);
+	sysfs_remove_group(&pdev->dev.kobj, &xmgnt_root_attr_group);
+	xroot_remove(xm->root);
+	pci_disable_pcie_error_reporting(xm->pdev);
+	xmgnt_info(xm, "%s cleaned up successfully", XMGNT_MODULE_NAME);
+}
+
+static struct pci_driver xmgnt_driver = {
+	.name = XMGNT_MODULE_NAME,
+	.id_table = xmgnt_pci_ids,
+	.probe = xmgnt_probe,
+	.remove = xmgnt_remove,
+};
+
+static int __init xmgnt_init(void)
+{
+	int res = 0;
+
+	res = xmgnt_register_leaf();
+	if (res)
+		return res;
+
+	xmgnt_class = class_create(THIS_MODULE, XMGNT_MODULE_NAME);
+	if (IS_ERR(xmgnt_class))
+		return PTR_ERR(xmgnt_class);
+
+	res = pci_register_driver(&xmgnt_driver);
+	if (res) {
+		class_destroy(xmgnt_class);
+		return res;
+	}
+
+	return 0;
+}
+
+static __exit void xmgnt_exit(void)
+{
+	pci_unregister_driver(&xmgnt_driver);
+	class_destroy(xmgnt_class);
+	xmgnt_unregister_leaf();
+}
+
+module_init(xmgnt_init);
+module_exit(xmgnt_exit);
+
+MODULE_DEVICE_TABLE(pci, xmgnt_pci_ids);
+MODULE_VERSION(XMGNT_DRIVER_VERSION);
+MODULE_AUTHOR("XRT Team <runtime@xilinx.com>");
+MODULE_DESCRIPTION("Xilinx Alveo management function driver");
+MODULE_LICENSE("GPL v2");
-- 
2.27.0


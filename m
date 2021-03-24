Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1BBE347105
	for <lists+linux-fpga@lfdr.de>; Wed, 24 Mar 2021 06:35:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235317AbhCXFe6 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 24 Mar 2021 01:34:58 -0400
Received: from mail-co1nam11on2075.outbound.protection.outlook.com ([40.107.220.75]:63232
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235344AbhCXFel (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 24 Mar 2021 01:34:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bvPo1qFfJUWtWDXpH7tPNFdIyJ6eAkVAUwwsvoJqL1wEC7y2P4ilUjVNyR0pInSZlDDihkyXVi1Sj2+zb472Ru5dIHiNS64ukFVRWcEtjtAiGVboiaFvgoQTHww9WTz6HJJ8tO+5Si7kgglakcwUV2rvnLf4ak6buW8oGmpi4zKOHOhSDkbx2r3bHfB5gk0B3PE5BmXQQGe8O9SE1RJPYPMqNqenyrNVh1D9V5bZJ+R5ltnBboxEcjfmPYfEKhDpKe7yX99HxoNBE1kZsIMnt6XEmaVwTVn1/Z1pZ2MqbhOyKADfe5MeQLDgCIDACv6mIgtInFCV04JeOOvWfH6qug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YVvxrhC+mGAMXK7kio8dF9YKg6yZ+yzqQO9YpuTFMhc=;
 b=hsOgamRY6nKC9do/vDcZQn+GgCOKR82HO7W10ErssxawuO81OHAPvdOIHXiV+Ew+tmC8m6iF9yadwXYNnNjRylYBMxBhV9Fh+1qSIpYAgtZS6v1CwrKTm92DRVGr3nPK9a35FHB9e+OfaFmqSgE/7p417EuH2i5Ek2mXfDM3ys4IfPxYR5aABcDKi1sxNj0E+zbTzvEVBjF8MAEWQOeotWWFIRA94smUPdEKV7kKTLxCcCTVO4UCD01IbgbE6u+9o9S5f53+ywMMrUkv961198k97nqvHDir1CrBaFW3o79xIIfK+Nh47M5Z5X2vnnrOKyrV3neflUT9wjVBneRD+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YVvxrhC+mGAMXK7kio8dF9YKg6yZ+yzqQO9YpuTFMhc=;
 b=aGBCTL6Kp/Gg91Otld/yX/P02gGG0TkD37j75K/Sw+ak4cOAdebIMxOVx3AkNHVxSP02upKWSCJ8SwJkEuPpbCanKKrh7Ss/75nQaXm0xWzaIBa/FGyl5XBqS+ZCDKON6Z6BZl7Mqk6Afb1t04FXWFa31Bp3zPnGEZuWj0jzkfk=
Received: from DM5PR11CA0007.namprd11.prod.outlook.com (2603:10b6:3:115::17)
 by CY4PR02MB3381.namprd02.prod.outlook.com (2603:10b6:910:7d::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Wed, 24 Mar
 2021 05:34:39 +0000
Received: from DM3NAM02FT007.eop-nam02.prod.protection.outlook.com
 (2603:10b6:3:115:cafe::3) by DM5PR11CA0007.outlook.office365.com
 (2603:10b6:3:115::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24 via Frontend
 Transport; Wed, 24 Mar 2021 05:34:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT007.mail.protection.outlook.com (10.13.4.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3955.24 via Frontend Transport; Wed, 24 Mar 2021 05:34:39 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 23 Mar 2021 22:34:10 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2106.2 via Frontend Transport; Tue, 23 Mar 2021 22:34:10 -0700
Envelope-to: mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.72.212] (port=51038 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1lOw9i-0004YG-8d; Tue, 23 Mar 2021 22:34:10 -0700
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id 56AE3600128; Tue, 23 Mar 2021 22:29:56 -0700 (PDT)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>, Max Zhen <max.zhen@xilinx.com>
Subject: [PATCH V4 XRT Alveo 09/20] fpga: xrt: management physical function driver (root)
Date:   Tue, 23 Mar 2021 22:29:36 -0700
Message-ID: <20210324052947.27889-10-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210324052947.27889-1-lizhi.hou@xilinx.com>
References: <20210324052947.27889-1-lizhi.hou@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95b26703-d6aa-407f-b341-08d8ee8684a1
X-MS-TrafficTypeDiagnostic: CY4PR02MB3381:
X-Microsoft-Antispam-PRVS: <CY4PR02MB3381A1997099799D2FB88270A1639@CY4PR02MB3381.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:279;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9mfXA4/BLgTxa/a9l2ktZ8u2w0NGR0aJ4OB591V/+I8y6CZwyPO0IJ5rQUNbxN5KpBK/QR40A6VwhkA82L9nh6RLY48n5dwJntO2TMw+TsaWIyg/lSgXpXWwogVzeKGWtLjC5fJGJEQuQPD51Oc6UMyADf1eOhrclniZN9hKfooQvgBAhQ65dmUeWnvcK+K211d2cghmIBa/QXhyVJ89aG36cQg4KOlLcgnQXmDOAuEtTm0cuXpcmwXmj2bTFQb5T/OFhzinM17r4rwZbUDI8RNUjr2Zc04S4WrSSDE9lRs717/pEdQCgghOCtYJIpBZghPnD213Esrvzzp5pPBfNn+9zZgi3B+Qb441zz+5BidkPiXB5NKozzFuD7btesf4dcjdbOQWQ8IWZG50u6ILU9e/UvlrWVh4cXJygnCutQY0Qdg9qZATQZrf+apNGA/MuNl0d+vD6JUTOf0HQBkOnxY3UfzeFvD893r38I56hTTxiF92N+2EjYCNGaWWi1/jEFY9SoHTBZsZmpKBzlxrweHZSUx6xM+hSe8cSmZKIjpsN3uq2TMUCx01xHLznbK/BZj7F+9jhUO842ZnKQIExlnpGkFslYWHOt70XFWIefCJOHAsB0PqD821pUlTbW+D1HIivJyz7H6n4XyLLwfM9OShlvfVVOQXW+ThoL/L8LA=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(39850400004)(396003)(376002)(346002)(136003)(36840700001)(46966006)(6666004)(2906002)(8936002)(26005)(42186006)(83380400001)(6266002)(82310400003)(44832011)(70206006)(5660300002)(82740400003)(2616005)(426003)(8676002)(6916009)(107886003)(7636003)(316002)(54906003)(36906005)(336012)(4326008)(478600001)(36756003)(186003)(47076005)(70586007)(356005)(1076003)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2021 05:34:39.0243
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95b26703-d6aa-407f-b341-08d8ee8684a1
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT007.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB3381
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The PCIE device driver which attaches to management function on Alveo
devices. It instantiates one or more group drivers which, in turn,
instantiate platform drivers. The instantiation of group and platform
drivers is completely dtb driven.

Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
Signed-off-by: Max Zhen <max.zhen@xilinx.com>
Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
---
 drivers/fpga/xrt/mgmt/root.c | 333 +++++++++++++++++++++++++++++++++++
 1 file changed, 333 insertions(+)
 create mode 100644 drivers/fpga/xrt/mgmt/root.c

diff --git a/drivers/fpga/xrt/mgmt/root.c b/drivers/fpga/xrt/mgmt/root.c
new file mode 100644
index 000000000000..f97f92807c01
--- /dev/null
+++ b/drivers/fpga/xrt/mgmt/root.c
@@ -0,0 +1,333 @@
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
+
+static struct class *xmgmt_class;
+
+/* PCI Device IDs */
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
+	if (rc > 512)
+		pcie_set_readrq(pdev, 512);
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
+static void xmgmt_root_hot_reset(struct pci_dev *pdev)
+{
+	struct xmgmt *xm = pci_get_drvdata(pdev);
+	struct pci_bus *bus;
+	u8 pci_bctl;
+	u16 pci_cmd, devctl;
+	int i, ret;
+
+	xmgmt_info(xm, "hot reset start");
+
+	xmgmt_pci_save_config_all(xm);
+
+	pci_disable_device(pdev);
+
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
+		xmgmt_err(xm, "time'd out waiting for device to be online after reset");
+
+	xmgmt_info(xm, "waiting for %d ms", i * 20);
+	xmgmt_pci_restore_config_all(xm);
+	xmgmt_config_pci(xm);
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
+	ret = xroot_add_vsec_node(xm->root, dtb);
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
+static struct xroot_physical_function_callback xmgmt_xroot_pf_cb = {
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
+	ret = xroot_probe(pdev, &xmgmt_xroot_pf_cb, &xm->root);
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


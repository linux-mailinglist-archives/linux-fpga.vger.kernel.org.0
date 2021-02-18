Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDA4A31E676
	for <lists+linux-fpga@lfdr.de>; Thu, 18 Feb 2021 07:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbhBRGt4 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 18 Feb 2021 01:49:56 -0500
Received: from mail-mw2nam12on2089.outbound.protection.outlook.com ([40.107.244.89]:18701
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230499AbhBRGpY (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 18 Feb 2021 01:45:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GBLptQhQRiXXPoCwuTC0LGNwAup+K6YqkR0HfmVN4jD/dTxHiwgWpOAXMmF4WX25LxRljVjDGz50rwJBLXHijg3HYGrOu4Unto46vL+8Ji5lxvp73Nrx9U4KzWYDSvbPMsRb5V5IDXHLexhj4ULmy+tihCEPMQIdO60TMQTTihYDPtCox7grvN5OeLjvWjXzwlAwNFMFb/dkYfnln/G7WjC9gswfd7mxzhb4bl5/ihTA3MbRQcJ3s6CPUXUpGLyMCKKBW2nC851n/bQ8g83EPwyHS66UTQZ4rQG5BfFPncFoIybX6RhV01OfHniqP08IgqCsRw8/LyAvc19E1kPlmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=33iDveisfT4f79uuD+ddvuclmU/h4cKMP7UkUfVye9g=;
 b=At9hc6KD9txz3T9E4AHefX+C6KLE7sjxKLMdqWuPtFMOAARwzqIeYH5Yt8LxcJXvPniProN23sbxr17SpbDZdoWCcC/q/dL3DcOZlyW2dUV+JLWPAxEOA/IHto1Wc2KafZP+bV/GoWov3oKGRlXT5et8qAtHrmIwWm6Zex7ANSf+9y5iIYCS+54hld82+ax5jvotdxwoKWC2qSKrg+84IzL5S28OJKLefPVsPMhyMz0Ie694ejNWMiB+wAZhu1zfsqKDZAYeDHedVZKl0giS8BBRQP1hh/5o3VPXkL4RKuoi3zktMmapgohVabAuFFzKbFvKocU18AoPIMicJNS88Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=33iDveisfT4f79uuD+ddvuclmU/h4cKMP7UkUfVye9g=;
 b=VkFzMWTiapdtOWr4N+MFJfCe+XXdqiIoJV29UfgrmcxL+X0suvsSQjbX+fE/VHTHUEkPtXSgquODgJduwuC2fwSGKSrA6RHn1VEkzPZBTfuFizsD01gqcCL5mDoEqNNRvDOsO0wIyNorUOFi4w27D3B5nFmjwkm3Sa5yrh0dJSs=
Received: from DM6PR13CA0041.namprd13.prod.outlook.com (2603:10b6:5:134::18)
 by MN2PR02MB6352.namprd02.prod.outlook.com (2603:10b6:208:1b8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.34; Thu, 18 Feb
 2021 06:44:25 +0000
Received: from CY1NAM02FT027.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:134:cafe::3) by DM6PR13CA0041.outlook.office365.com
 (2603:10b6:5:134::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.15 via Frontend
 Transport; Thu, 18 Feb 2021 06:44:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 CY1NAM02FT027.mail.protection.outlook.com (10.152.75.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3868.27 via Frontend Transport; Thu, 18 Feb 2021 06:44:24 +0000
Received: from xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Wed, 17 Feb 2021 22:44:15 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Wed, 17 Feb 2021 22:44:15 -0800
Envelope-to: maxz@xilinx.com,
 max.zhen@xilinx.com,
 michal.simek@xilinx.com,
 sonal.santan@xilinx.com,
 lizhih@xilinx.com,
 stefanos@xilinx.com,
 mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.72.212] (port=40172 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1lCd2t-0000a7-P3; Wed, 17 Feb 2021 22:44:15 -0800
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id 01D13600120; Wed, 17 Feb 2021 22:41:05 -0800 (PST)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhih@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>, Max Zhen <max.zhen@xilinx.com>
Subject: [PATCH V3 XRT Alveo 07/18] fpga: xrt: management physical function driver (root)
Date:   Wed, 17 Feb 2021 22:40:08 -0800
Message-ID: <20210218064019.29189-8-lizhih@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210218064019.29189-1-lizhih@xilinx.com>
References: <20210218064019.29189-1-lizhih@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 71761757-4617-44c5-d460-08d8d3d8a19a
X-MS-TrafficTypeDiagnostic: MN2PR02MB6352:
X-Microsoft-Antispam-PRVS: <MN2PR02MB63520CA069E84B519E7C3803A1859@MN2PR02MB6352.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:366;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CnFRmFg04oeu0xm23yjbWrteVT74xaE/ZL9G8kgueHyOhXFx18GvqV7SYjBOZC+flyfQZFY3gWWO87M8uoOIO2uB2W/KX6ycq4G0JM7w1vz4yjAphUOENCoz8DFliTXFCpFbYNTp6WSuIrusl8mobvH0pUIAd/x/tn6n5g/Bngb1r2N6mO/oLZ5vIM1OlyPUs/9wX8D7gtilUgAjJJ2/nBMc+rn8mkVvPe4zsrgBqtMKtSjkXjnmDd9uBZWXEDiO1el/fAhq2394XQtavehidBrO7es3fXlBM6egPbambAEbQNdOnOqp6fWEMKB0W1AvnMSHy862eOjDMCB4Ltz20vyjFilvFMIUt9rYJMfkHDokGlACcuEC90sPrDO3frybvyF11xqhtucjdIHjXtIcI/6Y4PUh9pk6jfv95cUZQBugnxn5aTmy2m5J84pZIxpHN8EC59+uCH+xnHDpn0TYFdNrC4yudAFOTqNko7QySwNKinLzLHqNhVncBhEp9B9ZQJ4IPFmDJKQSMdMJmGEtWoAISDDq4vpl5XDg8l96N+8heCVSkVBuxa4VLj+31tircY9xGcr0fcR/SA4NciEgclXiTiuRes34YR70h0NiGgKcxts8hj4pXtyxuZQ4TkgnEXrTPdL5XHkkvvdZloTjEy6v5oopT5LC0Ecx7LxRQqI=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(376002)(39860400002)(36840700001)(46966006)(316002)(83380400001)(42186006)(2906002)(107886003)(26005)(186003)(7636003)(2616005)(478600001)(8676002)(36860700001)(70206006)(356005)(4326008)(336012)(44832011)(82740400003)(8936002)(6266002)(5660300002)(36906005)(70586007)(47076005)(36756003)(6916009)(1076003)(54906003)(82310400003)(426003)(30864003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2021 06:44:24.9970
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71761757-4617-44c5-d460-08d8d3d8a19a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT027.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6352
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The PCIE device driver which attaches to management function on Alveo
devices. It instantiates one or more partition drivers which in turn
instantiate platform drivers. The instantiation of partition and platform
drivers is completely data driven.

Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
Signed-off-by: Max Zhen <max.zhen@xilinx.com>
Signed-off-by: Lizhi Hou <lizhih@xilinx.com>
---
 drivers/fpga/xrt/include/xroot.h | 114 +++++++++++
 drivers/fpga/xrt/mgmt/root.c     | 342 +++++++++++++++++++++++++++++++
 2 files changed, 456 insertions(+)
 create mode 100644 drivers/fpga/xrt/include/xroot.h
 create mode 100644 drivers/fpga/xrt/mgmt/root.c

diff --git a/drivers/fpga/xrt/include/xroot.h b/drivers/fpga/xrt/include/xroot.h
new file mode 100644
index 000000000000..752e10daa85e
--- /dev/null
+++ b/drivers/fpga/xrt/include/xroot.h
@@ -0,0 +1,114 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Header file for Xilinx Runtime (XRT) driver
+ *
+ * Copyright (C) 2020-2021 Xilinx, Inc.
+ *
+ * Authors:
+ *	Cheng Zhen <maxz@xilinx.com>
+ */
+
+#ifndef _XRT_ROOT_H_
+#define _XRT_ROOT_H_
+
+#include <linux/pci.h>
+#include "subdev_id.h"
+#include "events.h"
+
+typedef bool (*xrt_subdev_match_t)(enum xrt_subdev_id,
+	struct platform_device *, void *);
+#define XRT_SUBDEV_MATCH_PREV	((xrt_subdev_match_t)-1)
+#define XRT_SUBDEV_MATCH_NEXT	((xrt_subdev_match_t)-2)
+
+/*
+ * Root IOCTL calls.
+ */
+enum xrt_root_ioctl_cmd {
+	/* Leaf actions. */
+	XRT_ROOT_GET_LEAF = 0,
+	XRT_ROOT_PUT_LEAF,
+	XRT_ROOT_GET_LEAF_HOLDERS,
+
+	/* Group actions. */
+	XRT_ROOT_CREATE_GROUP,
+	XRT_ROOT_REMOVE_GROUP,
+	XRT_ROOT_LOOKUP_GROUP,
+	XRT_ROOT_WAIT_GROUP_BRINGUP,
+
+	/* Event actions. */
+	XRT_ROOT_EVENT,
+	XRT_ROOT_EVENT_ASYNC,
+
+	/* Device info. */
+	XRT_ROOT_GET_RESOURCE,
+	XRT_ROOT_GET_ID,
+
+	/* Misc. */
+	XRT_ROOT_HOT_RESET,
+	XRT_ROOT_HWMON,
+};
+
+struct xrt_root_ioctl_get_leaf {
+	struct platform_device *xpigl_pdev; /* caller's pdev */
+	xrt_subdev_match_t xpigl_match_cb;
+	void *xpigl_match_arg;
+	struct platform_device *xpigl_leaf; /* target leaf pdev */
+};
+
+struct xrt_root_ioctl_put_leaf {
+	struct platform_device *xpipl_pdev; /* caller's pdev */
+	struct platform_device *xpipl_leaf; /* target's pdev */
+};
+
+struct xrt_root_ioctl_lookup_group {
+	struct platform_device *xpilp_pdev; /* caller's pdev */
+	xrt_subdev_match_t xpilp_match_cb;
+	void *xpilp_match_arg;
+	int xpilp_grp_inst;
+};
+
+struct xrt_root_ioctl_get_holders {
+	struct platform_device *xpigh_pdev; /* caller's pdev */
+	char *xpigh_holder_buf;
+	size_t xpigh_holder_buf_len;
+};
+
+struct xrt_root_ioctl_get_res {
+	struct resource *xpigr_res;
+};
+
+struct xrt_root_ioctl_get_id {
+	unsigned short  xpigi_vendor_id;
+	unsigned short  xpigi_device_id;
+	unsigned short  xpigi_sub_vendor_id;
+	unsigned short  xpigi_sub_device_id;
+};
+
+struct xrt_root_ioctl_hwmon {
+	bool xpih_register;
+	const char *xpih_name;
+	void *xpih_drvdata;
+	const struct attribute_group **xpih_groups;
+	struct device *xpih_hwmon_dev;
+};
+
+typedef int (*xrt_subdev_root_cb_t)(struct device *, void *, u32, void *);
+int xrt_subdev_root_request(struct platform_device *self, u32 cmd, void *arg);
+
+/*
+ * Defines physical function (MPF / UPF) specific operations
+ * needed in common root driver.
+ */
+struct xroot_pf_cb {
+	void (*xpc_hot_reset)(struct pci_dev *pdev);
+};
+
+int xroot_probe(struct pci_dev *pdev, struct xroot_pf_cb *cb, void **root);
+void xroot_remove(void *root);
+bool xroot_wait_for_bringup(void *root);
+int xroot_add_vsec_node(void *root, char *dtb);
+int xroot_create_group(void *xr, char *dtb);
+int xroot_add_simple_node(void *root, char *dtb, const char *endpoint);
+void xroot_broadcast(void *root, enum xrt_events evt);
+
+#endif	/* _XRT_ROOT_H_ */
diff --git a/drivers/fpga/xrt/mgmt/root.c b/drivers/fpga/xrt/mgmt/root.c
new file mode 100644
index 000000000000..583a37c9d30c
--- /dev/null
+++ b/drivers/fpga/xrt/mgmt/root.c
@@ -0,0 +1,342 @@
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
+#include "main-impl.h"
+#include "metadata.h"
+
+#define XMGMT_MODULE_NAME	"xmgmt"
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
+static const struct pci_device_id xmgmt_pci_ids[] = {
+	{ PCI_DEVICE(0x10EE, 0xd020), }, /* Alveo U50 (golden image) */
+	{ PCI_DEVICE(0x10EE, 0x5020), }, /* Alveo U50 */
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
+	if (rc < 0) {
+		xmgmt_err(xm, "failed to read mrrs %d", rc);
+		return rc;
+	}
+	if (rc > 512) {
+		rc = pcie_set_readrq(pdev, 512);
+		if (rc) {
+			xmgmt_err(xm, "failed to force mrrs %d", rc);
+			return rc;
+		}
+	}
+
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
+	pci_write_config_word(bus->self, PCI_COMMAND,
+			      (pci_cmd & ~PCI_COMMAND_SERR));
+	pcie_capability_read_word(bus->self, PCI_EXP_DEVCTL, &devctl);
+	pcie_capability_write_word(bus->self, PCI_EXP_DEVCTL,
+				   (devctl & ~PCI_EXP_DEVCTL_FERE));
+	pci_read_config_byte(bus->self, PCI_BRIDGE_CONTROL, &pci_bctl);
+	pci_bctl |= PCI_BRIDGE_CTL_BUS_RESET;
+	pci_write_config_byte(bus->self, PCI_BRIDGE_CONTROL, pci_bctl);
+
+	msleep(100);
+	pci_bctl &= ~PCI_BRIDGE_CTL_BUS_RESET;
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
+static struct xroot_pf_cb xmgmt_xroot_pf_cb = {
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
+	(void)xroot_remove(xm->root);
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
+	(void)xroot_remove(xm->root);
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
+	res = xmgmt_main_register_leaf();
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
+	xmgmt_main_unregister_leaf();
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
2.18.4


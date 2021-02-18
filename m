Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D879A31E6B2
	for <lists+linux-fpga@lfdr.de>; Thu, 18 Feb 2021 08:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbhBRHHF (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 18 Feb 2021 02:07:05 -0500
Received: from mail-dm6nam10on2043.outbound.protection.outlook.com ([40.107.93.43]:4449
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230321AbhBRHEv (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 18 Feb 2021 02:04:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A8UdA2AG+QCElCV3ucg4/HbZtcGe9Z4cFtrgKIwuyah7B/G56N7qIVlcbw4+dQbLaj5teWxhn4t2Grklc1iXviAT/JubGqjUHOR7bXMKm9RwN3hGhAzAXqy5mBGJbMsddndvWW9FsqDr8BPvzmyYypHoacYP150E/t6cCTP0CP8Eu8Zf2qpWuBlRE5SzBYow6oHw8PFNL51898BEqOi31RTjok1KacEahJHZktWXKGR5gcezHVZTQgoxr3hxKxmJS9GNKQdCGs6S7tpJlXpBIWCV4KK0Nlf0HZoEoKgxe7TAgDkC2Go65xLdAmF87ezhYjpdGYl9weW6ZUTt2XESmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aPsZqUqngQ6z5NtQb7WGfP1Px6O8uCV1bGf9qQnESvw=;
 b=MFAML7gI4693Ee0RnvWoy+58+/kjjHNRsJ0aZwGZyhzMsuyVSPkzwCv7N8E3cFVDrq7UPwG7KEdhzI7mzgUi4c4tdcHHC6EvWHWBYp4nY15jssek1amY8wjvtjGsjx0IFoM8ODsPtWG5bPIHpEDboOgkD+eAbmqsb8wrFJsS/p0P52MouDjGo9uq78sWZZY1xgGycgEaJPEcFqnSup1otsiEr2noutEEkbDk5EMJqXlkH94DdCcZ7Pz4fjyg7ILfU7AW58C7R9Lh64AwKCOb2qx9RoWz5Ge2KQYETvmgeM1MqepRDJgcqmVXR5LKLT0h5hSA4yOYGGC+bS/XcTaUtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aPsZqUqngQ6z5NtQb7WGfP1Px6O8uCV1bGf9qQnESvw=;
 b=RbvAxiVcejH7TpGn/8vZi1JGTXIUqH2XTexJEV2IyAFJdaVqQtk7ZttwwM5EepkinBIby66VMfEfzxNPryY0SstQSSIJEXqO39Xnqf+F7xGts0f9sZ4G/ZgFwW4nKI7FaE/l5WiWi7PR1umcq/ek5o0mcAMB+hrJ0Z8/+/X3FXA=
Received: from BLAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:32b::32)
 by BYAPR02MB5493.namprd02.prod.outlook.com (2603:10b6:a03:9a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25; Thu, 18 Feb
 2021 06:44:52 +0000
Received: from BL2NAM02FT051.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:32b:cafe::c2) by BLAPR03CA0027.outlook.office365.com
 (2603:10b6:208:32b::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend
 Transport; Thu, 18 Feb 2021 06:44:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT051.mail.protection.outlook.com (10.152.76.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3868.27 via Frontend Transport; Thu, 18 Feb 2021 06:44:52 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Wed, 17 Feb 2021 22:44:52 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Wed, 17 Feb 2021 22:44:52 -0800
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
Received: from [172.19.72.212] (port=40180 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1lCd3T-0000bV-TU; Wed, 17 Feb 2021 22:44:51 -0800
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id 3834C600126; Wed, 17 Feb 2021 22:41:06 -0800 (PST)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhih@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>, Max Zhen <max.zhen@xilinx.com>
Subject: [PATCH V3 XRT Alveo 10/18] fpga: xrt: VSEC platform driver
Date:   Wed, 17 Feb 2021 22:40:11 -0800
Message-ID: <20210218064019.29189-11-lizhih@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210218064019.29189-1-lizhih@xilinx.com>
References: <20210218064019.29189-1-lizhih@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2bccd600-6892-45ab-475e-08d8d3d8b214
X-MS-TrafficTypeDiagnostic: BYAPR02MB5493:
X-Microsoft-Antispam-PRVS: <BYAPR02MB5493DC1200A3BD562832E84DA1859@BYAPR02MB5493.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jHznzJx+IqATj03qWE016GsRC7O4PRf4kkhXxQRWDsZAiFPwpjXg1+aPMrKBAEn39e7wubGraMg35jWRYuTH00ryMxHHEWcqqPys8v1yGVmwIwkEikSBUiglG1O4r7LB0PPM3e0KP8lmHQdC4asGVGKxqNNoxSu50UF79ZcL7iTOhFUPCIibm5P8pogUe/tcYrlBQ6WjJeDomKD8epaiJZFRyVzoy2hz1Ew4j/47me7HeWT728D+zkGuD9ba7qYX9zmLQ/bCGIdASklVUsGeIbRMjj9tjTf3eSnK0C76KPUc62zAhL4pVEkTScll+hcpN54XDzF2ryNk/yEii32JSK8h6GKUExuhnZig/ASDMf7K778uPYNkzc5pHGWe6FfvcJcm0BXtCv2yEhD6CIIJ749sHeYemxafnyl2y/0tvxuTWM+DLjkVUVp4knVA52VkJ0jJv7aYRo0/WElJFh6a4W4KByQjBGHw/99AUrVGVq5zUof2we7JsYqUe5XaCORlT7TNrG2VhdSRLCyiyILUwuo6P6r7n9wq6s8fsBFDW9tUw8pHBmUt/tuIPVFu47LwY4fWUQVRvEAjTTg4Lq+hFkUpHI2nDLX7c9yhR2gauuxZz1AfQuOJimErFe93c/Tz4wHUTdCFzhQu93Awl0egGHrViSCMLyt3Ut6hh+4H3Ns=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(346002)(39860400002)(46966006)(36840700001)(70206006)(356005)(82740400003)(4326008)(8676002)(54906003)(47076005)(83380400001)(107886003)(2616005)(36906005)(5660300002)(36860700001)(70586007)(36756003)(6916009)(82310400003)(7636003)(186003)(336012)(8936002)(6266002)(6666004)(2906002)(26005)(1076003)(316002)(42186006)(478600001)(426003)(44832011);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2021 06:44:52.5585
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bccd600-6892-45ab-475e-08d8d3d8b214
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT051.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5493
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Add VSEC driver. VSEC is a hardware function discovered by walking
PCI Express configure space. A platform device node will be created
for it. VSEC provides board logic UUID and few offset of other hardware
functions.

Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
Signed-off-by: Max Zhen <max.zhen@xilinx.com>
Signed-off-by: Lizhi Hou <lizhih@xilinx.com>
---
 drivers/fpga/xrt/lib/xleaf/vsec.c | 359 ++++++++++++++++++++++++++++++
 1 file changed, 359 insertions(+)
 create mode 100644 drivers/fpga/xrt/lib/xleaf/vsec.c

diff --git a/drivers/fpga/xrt/lib/xleaf/vsec.c b/drivers/fpga/xrt/lib/xleaf/vsec.c
new file mode 100644
index 000000000000..8e5cb22522ec
--- /dev/null
+++ b/drivers/fpga/xrt/lib/xleaf/vsec.c
@@ -0,0 +1,359 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx Alveo FPGA VSEC Driver
+ *
+ * Copyright (C) 2020-2021 Xilinx, Inc.
+ *
+ * Authors:
+ *      Lizhi Hou<Lizhi.Hou@xilinx.com>
+ */
+
+#include <linux/platform_device.h>
+#include "metadata.h"
+#include "xleaf.h"
+
+#define XRT_VSEC "xrt_vsec"
+
+#define VSEC_TYPE_UUID		0x50
+#define VSEC_TYPE_FLASH		0x51
+#define VSEC_TYPE_PLATINFO	0x52
+#define VSEC_TYPE_MAILBOX	0x53
+#define VSEC_TYPE_END		0xff
+
+#define VSEC_UUID_LEN		16
+
+struct xrt_vsec_header {
+	u32		format;
+	u32		length;
+	u32		entry_sz;
+	u32		rsvd;
+} __packed;
+
+#define head_rd(g, r)			\
+	ioread32((void *)(g)->base + offsetof(struct xrt_vsec_header, r))
+
+#define GET_BAR(entry)	(((entry)->bar_rev >> 4) & 0xf)
+#define GET_BAR_OFF(_entry)				\
+	({ typeof(_entry) entry = (_entry);		\
+	 ((entry)->off_lo | ((u64)(entry)->off_hi << 16)); })
+#define GET_REV(entry)	((entry)->bar_rev & 0xf)
+
+struct xrt_vsec_entry {
+	u8		type;
+	u8		bar_rev;
+	u16		off_lo;
+	u32		off_hi;
+	u8		ver_type;
+	u8		minor;
+	u8		major;
+	u8		rsvd0;
+	u32		rsvd1;
+} __packed;
+
+#define read_entry(g, i, e)					\
+	do {							\
+		u32 *p = (u32 *)((g)->base +			\
+			sizeof(struct xrt_vsec_header) +	\
+			(i) * sizeof(struct xrt_vsec_entry));	\
+		u32 off;					\
+		for (off = 0;					\
+		    off < sizeof(struct xrt_vsec_entry) / 4;	\
+		    off++)					\
+			*((u32 *)(e) + off) = ioread32(p + off);\
+	} while (0)
+
+struct vsec_device {
+	u8		type;
+	char		*ep_name;
+	ulong		size;
+	char		*regmap;
+};
+
+static struct vsec_device vsec_devs[] = {
+	{
+		.type = VSEC_TYPE_UUID,
+		.ep_name = XRT_MD_NODE_BLP_ROM,
+		.size = VSEC_UUID_LEN,
+		.regmap = "vsec-uuid",
+	},
+	{
+		.type = VSEC_TYPE_FLASH,
+		.ep_name = XRT_MD_NODE_FLASH_VSEC,
+		.size = 4096,
+		.regmap = "vsec-flash",
+	},
+	{
+		.type = VSEC_TYPE_PLATINFO,
+		.ep_name = XRT_MD_NODE_PLAT_INFO,
+		.size = 4,
+		.regmap = "vsec-platinfo",
+	},
+	{
+		.type = VSEC_TYPE_MAILBOX,
+		.ep_name = XRT_MD_NODE_MAILBOX_VSEC,
+		.size = 48,
+		.regmap = "vsec-mbx",
+	},
+};
+
+struct xrt_vsec {
+	struct platform_device	*pdev;
+	void			*base;
+	ulong			length;
+
+	char			*metadata;
+	char			uuid[VSEC_UUID_LEN];
+};
+
+static char *type2epname(u32 type)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(vsec_devs); i++) {
+		if (vsec_devs[i].type == type)
+			return (vsec_devs[i].ep_name);
+	}
+
+	return NULL;
+}
+
+static ulong type2size(u32 type)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(vsec_devs); i++) {
+		if (vsec_devs[i].type == type)
+			return (vsec_devs[i].size);
+	}
+
+	return 0;
+}
+
+static char *type2regmap(u32 type)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(vsec_devs); i++) {
+		if (vsec_devs[i].type == type)
+			return (vsec_devs[i].regmap);
+	}
+
+	return NULL;
+}
+
+static int xrt_vsec_add_node(struct xrt_vsec *vsec,
+			     void *md_blob, struct xrt_vsec_entry *p_entry)
+{
+	struct xrt_md_endpoint ep;
+	char regmap_ver[64];
+	int ret;
+
+	if (!type2epname(p_entry->type))
+		return -EINVAL;
+
+	/*
+	 * VSEC may have more than 1 mailbox instance for the card
+	 * which has more than 1 physical function.
+	 * This is not supported for now. Assuming only one mailbox
+	 */
+
+	snprintf(regmap_ver, sizeof(regmap_ver) - 1, "%d-%d.%d.%d",
+		 p_entry->ver_type, p_entry->major, p_entry->minor,
+		 GET_REV(p_entry));
+	ep.ep_name = type2epname(p_entry->type);
+	ep.bar = GET_BAR(p_entry);
+	ep.bar_off = GET_BAR_OFF(p_entry);
+	ep.size = type2size(p_entry->type);
+	ep.regmap = type2regmap(p_entry->type);
+	ep.regmap_ver = regmap_ver;
+	ret = xrt_md_add_endpoint(DEV(vsec->pdev), vsec->metadata, &ep);
+	if (ret) {
+		xrt_err(vsec->pdev, "add ep failed, ret %d", ret);
+		goto failed;
+	}
+
+failed:
+	return ret;
+}
+
+static int xrt_vsec_create_metadata(struct xrt_vsec *vsec)
+{
+	struct xrt_vsec_entry entry;
+	int i, ret;
+
+	ret = xrt_md_create(&vsec->pdev->dev, &vsec->metadata);
+	if (ret) {
+		xrt_err(vsec->pdev, "create metadata failed");
+		return ret;
+	}
+
+	for (i = 0; i * sizeof(entry) < vsec->length -
+	    sizeof(struct xrt_vsec_header); i++) {
+		read_entry(vsec, i, &entry);
+		xrt_vsec_add_node(vsec, vsec->metadata, &entry);
+	}
+
+	return 0;
+}
+
+static int xrt_vsec_ioctl(struct platform_device *pdev, u32 cmd, void *arg)
+{
+	int ret = 0;
+
+	switch (cmd) {
+	case XRT_XLEAF_EVENT:
+		/* Does not handle any event. */
+		break;
+	default:
+		ret = -EINVAL;
+		xrt_err(pdev, "should never been called");
+		break;
+	}
+
+	return ret;
+}
+
+static int xrt_vsec_mapio(struct xrt_vsec *vsec)
+{
+	struct xrt_subdev_platdata *pdata = DEV_PDATA(vsec->pdev);
+	const u32 *bar;
+	const u64 *bar_off;
+	struct resource *res = NULL;
+	ulong addr;
+	int ret;
+
+	if (!pdata || xrt_md_size(DEV(vsec->pdev), pdata->xsp_dtb) == XRT_MD_INVALID_LENGTH) {
+		xrt_err(vsec->pdev, "empty metadata");
+		return -EINVAL;
+	}
+
+	ret = xrt_md_get_prop(DEV(vsec->pdev), pdata->xsp_dtb, XRT_MD_NODE_VSEC,
+			      NULL, XRT_MD_PROP_BAR_IDX, (const void **)&bar, NULL);
+	if (ret) {
+		xrt_err(vsec->pdev, "failed to get bar idx, ret %d", ret);
+		return -EINVAL;
+	}
+
+	ret = xrt_md_get_prop(DEV(vsec->pdev), pdata->xsp_dtb, XRT_MD_NODE_VSEC,
+			      NULL, XRT_MD_PROP_OFFSET, (const void **)&bar_off, NULL);
+	if (ret) {
+		xrt_err(vsec->pdev, "failed to get bar off, ret %d", ret);
+		return -EINVAL;
+	}
+
+	xrt_info(vsec->pdev, "Map vsec at bar %d, offset 0x%llx",
+		 be32_to_cpu(*bar), be64_to_cpu(*bar_off));
+
+	xleaf_get_barres(vsec->pdev, &res, be32_to_cpu(*bar));
+	if (!res) {
+		xrt_err(vsec->pdev, "failed to get bar addr");
+		return -EINVAL;
+	}
+
+	addr = res->start + (ulong)be64_to_cpu(*bar_off);
+
+	vsec->base = ioremap(addr, sizeof(struct xrt_vsec_header));
+	if (!vsec->base) {
+		xrt_err(vsec->pdev, "Map header failed");
+		return -EIO;
+	}
+
+	vsec->length = head_rd(vsec, length);
+	iounmap(vsec->base);
+	vsec->base = ioremap(addr, vsec->length);
+	if (!vsec->base) {
+		xrt_err(vsec->pdev, "map failed");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int xrt_vsec_remove(struct platform_device *pdev)
+{
+	struct xrt_vsec	*vsec;
+
+	vsec = platform_get_drvdata(pdev);
+
+	if (vsec->base) {
+		iounmap(vsec->base);
+		vsec->base = NULL;
+	}
+
+	vfree(vsec->metadata);
+
+	return 0;
+}
+
+static int xrt_vsec_probe(struct platform_device *pdev)
+{
+	struct xrt_vsec	*vsec;
+	int			ret = 0;
+
+	vsec = devm_kzalloc(&pdev->dev, sizeof(*vsec), GFP_KERNEL);
+	if (!vsec)
+		return -ENOMEM;
+
+	vsec->pdev = pdev;
+	platform_set_drvdata(pdev, vsec);
+
+	ret = xrt_vsec_mapio(vsec);
+	if (ret)
+		goto failed;
+
+	ret = xrt_vsec_create_metadata(vsec);
+	if (ret) {
+		xrt_err(pdev, "create metadata failed, ret %d", ret);
+		goto failed;
+	}
+	ret = xleaf_create_group(pdev, vsec->metadata);
+	if (ret < 0)
+		xrt_err(pdev, "create group failed, ret %d", ret);
+	else
+		ret = 0;
+
+failed:
+	if (ret)
+		xrt_vsec_remove(pdev);
+
+	return ret;
+}
+
+static struct xrt_subdev_endpoints xrt_vsec_endpoints[] = {
+	{
+		.xse_names = (struct xrt_subdev_ep_names []){
+			{ .ep_name = XRT_MD_NODE_VSEC },
+			{ NULL },
+		},
+		.xse_min_ep = 1,
+	},
+	{ 0 },
+};
+
+static struct xrt_subdev_drvdata xrt_vsec_data = {
+	.xsd_dev_ops = {
+		.xsd_ioctl = xrt_vsec_ioctl,
+	},
+};
+
+static const struct platform_device_id xrt_vsec_table[] = {
+	{ XRT_VSEC, (kernel_ulong_t)&xrt_vsec_data },
+	{ },
+};
+
+static struct platform_driver xrt_vsec_driver = {
+	.driver = {
+		.name = XRT_VSEC,
+	},
+	.probe = xrt_vsec_probe,
+	.remove = xrt_vsec_remove,
+	.id_table = xrt_vsec_table,
+};
+
+void vsec_leaf_init_fini(bool init)
+{
+	if (init)
+		xleaf_register_driver(XRT_SUBDEV_VSEC, &xrt_vsec_driver, xrt_vsec_endpoints);
+	else
+		xleaf_unregister_driver(XRT_SUBDEV_VSEC);
+}
-- 
2.18.4


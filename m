Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE38E34710C
	for <lists+linux-fpga@lfdr.de>; Wed, 24 Mar 2021 06:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235353AbhCXFfd (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 24 Mar 2021 01:35:33 -0400
Received: from mail-mw2nam12on2046.outbound.protection.outlook.com ([40.107.244.46]:42962
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233036AbhCXFfX (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 24 Mar 2021 01:35:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XLUG3Ta3d1l4CKoftgDq1LuQCJO2YguIuI+EiQl9hrdm4MmnFNHuq1uSKmzmF6XgyMh1vkUccXsqqdUX42iqK0iUbKmMLlktXK5zrdjVjBl3vRGHSeuVKsYkEFSwoQNQIMhP4uNvoUBTSlPDcy2zKrChDSXEI3HrW/Jwi5EFupHPkASisy0WXW4C8F2U4ci1xAML3z37V4yfigFOJtHQY+wN4J53cyXJg6G4Px9EYAW9804GpDCtRO9kcraD6XG/kyAsyPhNBCWxUKuqpJsZqD/3yfObWKG7gWDRKsfH8cd3dDVlgDEVS83p+PkvtkK/aGsfd8e5IY51IstQWMtK9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x5n5rbp52QygWuNPykEhc5q6TGQKwnMy2vr7WcEyRsk=;
 b=OnM7JHEGHRiSSnBv0yTAYHNL/H+18JxYTzj+m9t6qV3/hPqdm1dhDCVwbsW1F9k4eBWzhYsgr/E8d0JRqA2bKR0a+dHlvDhE76rt++YCe7AAlCHd0jz5dt5/5ko8E4mP1h/tl+pmoh7qUClADAOKgdm/iMB3ZPio4aDXCYR82whdcjNPg2R0DaDsNEo0LJxAy1FmUaRBB68BlheTog0M8ySiN/zqrpnRi5a3A3qW+60/CZSa+EFekWleYST6T+H+C/COEXGHAVTfa6Wpnl0cu0uBqnxu4tmfEQcxOoVqiXk++XAeBJxxQqwT3W1u6DJMHyVNXe9kLFoKk944AUOr8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x5n5rbp52QygWuNPykEhc5q6TGQKwnMy2vr7WcEyRsk=;
 b=oqgk+UDLYuDu+FhWnGleN7OATChQ2wY6tfpsdRSKc4PUT7zrvUBYGuCZ7rPJP1e0ExoZ+YcRqMc7Z0SzWNW1d0aedqUEFHpNKbGV0iLgvv6p863N3+ME5QW0VoMxD7fxDkroRM3SasWlvZ+k0EmSSpH1NqAf8/JaBbNheMw+5SA=
Received: from DM6PR06CA0022.namprd06.prod.outlook.com (2603:10b6:5:120::35)
 by MN2PR02MB6832.namprd02.prod.outlook.com (2603:10b6:208:1d8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Wed, 24 Mar
 2021 05:35:20 +0000
Received: from DM3NAM02FT025.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::18) by DM6PR06CA0022.outlook.office365.com
 (2603:10b6:5:120::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend
 Transport; Wed, 24 Mar 2021 05:35:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT025.mail.protection.outlook.com (10.13.4.112) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3977.25 via Frontend Transport; Wed, 24 Mar 2021 05:35:20 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 23 Mar 2021 22:34:46 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2106.2 via Frontend Transport; Tue, 23 Mar 2021 22:34:46 -0700
Envelope-to: mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.72.212] (port=51044 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1lOwAI-00061W-L3; Tue, 23 Mar 2021 22:34:46 -0700
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id 94D0260012A; Tue, 23 Mar 2021 22:29:56 -0700 (PDT)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>, Max Zhen <max.zhen@xilinx.com>
Subject: [PATCH V4 XRT Alveo 12/20] fpga: xrt: VSEC platform driver
Date:   Tue, 23 Mar 2021 22:29:39 -0700
Message-ID: <20210324052947.27889-13-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210324052947.27889-1-lizhi.hou@xilinx.com>
References: <20210324052947.27889-1-lizhi.hou@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3435a9ef-7ac6-4430-69a2-08d8ee869d59
X-MS-TrafficTypeDiagnostic: MN2PR02MB6832:
X-Microsoft-Antispam-PRVS: <MN2PR02MB683210D2DDD0099CABEFC951A1639@MN2PR02MB6832.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: be9SF4LaFtXF68EmpUWBoHf7wRMTEN4+sPDuUpMYEdSZtAD1wKB1k30UWk135ToiBplLDhoGSqdgScW4m9AV3GNpicI6C/kB03jscXj8RE2ry4aT/XG7oHUKYK+VcmvS4vJsA0AE7Jac/S0OokbMxpNkJMTtl+lkeZgqTvJgthW8a5iN4m4G/TWxI3WyXQK/01IhuJSboh5Ic6CGFez1GCrP4UfHHB/72em2/UiKCgyKO7F98RDlpleLfO4qC8kbgNi8q2UUka6hOLeb9Rk7CCpwkoFrSjJdV5f2wx9lU1I4LUUQ76gnlWA13Ry3GPgXc5F2QTcR7GS/fOIENAkFEZKNU3TLGGDhoTg7+MF+08rNlZVSIgYe3pmsuufmwlrVzeTeh/N8dgE7lq7KSuG8zRpvrIgxBOjdaUQ4j6Mtzt1EaRnfxo+mmrxLsm38nGhvnJzoCqaK3ktXVf+iymUL4jvcJuDud+F42g+hLUhRMqp6amAd1mBwhxU97Z1gNeo1gkMBZ20rpDp+2VGPtp/vDJzs1ysx4ncu8U4ZPPr/4GY2tj9cUKU0tt0aoFnv89dmWbacYwiuZsllKH2HOYA6EfYvpOcp/KFMB/WjHGVSjFre+gICtinH8nCKgqkkdzioosTcU8h9MXiy+CG+T42xTKcWytrZlabf/bE5omiDKvs=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(346002)(39860400002)(46966006)(36840700001)(4326008)(2906002)(8676002)(36860700001)(6266002)(356005)(47076005)(82310400003)(478600001)(42186006)(54906003)(36906005)(316002)(83380400001)(186003)(1076003)(336012)(5660300002)(44832011)(36756003)(426003)(70586007)(2616005)(82740400003)(6916009)(8936002)(26005)(70206006)(107886003)(6666004)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2021 05:35:20.4946
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3435a9ef-7ac6-4430-69a2-08d8ee869d59
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT025.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6832
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Add VSEC driver. VSEC is a hardware function discovered by walking
PCI Express configure space. A platform device node will be created
for it. VSEC provides board logic UUID and few offset of other hardware
functions.

Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
Signed-off-by: Max Zhen <max.zhen@xilinx.com>
Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
---
 drivers/fpga/xrt/lib/xleaf/vsec.c | 388 ++++++++++++++++++++++++++++++
 1 file changed, 388 insertions(+)
 create mode 100644 drivers/fpga/xrt/lib/xleaf/vsec.c

diff --git a/drivers/fpga/xrt/lib/xleaf/vsec.c b/drivers/fpga/xrt/lib/xleaf/vsec.c
new file mode 100644
index 000000000000..8595d23f5710
--- /dev/null
+++ b/drivers/fpga/xrt/lib/xleaf/vsec.c
@@ -0,0 +1,388 @@
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
+#include <linux/regmap.h>
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
+#define VSEC_REG_FORMAT		0x0
+#define VSEC_REG_LENGTH		0x4
+#define VSEC_REG_ENTRY		0x8
+
+struct xrt_vsec_header {
+	u32		format;
+	u32		length;
+	u32		entry_sz;
+	u32		rsvd;
+} __packed;
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
+static const struct regmap_config vsec_regmap_config = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+	.max_register = 0x1000,
+};
+
+struct xrt_vsec {
+	struct platform_device	*pdev;
+	struct regmap		*regmap;
+	u32			length;
+
+	char			*metadata;
+	char			uuid[VSEC_UUID_LEN];
+	int			group;
+};
+
+static inline int vsec_read_entry(struct xrt_vsec *vsec, u32 index, struct xrt_vsec_entry *entry)
+{
+	int ret;
+
+	ret = regmap_bulk_read(vsec->regmap, sizeof(struct xrt_vsec_header) +
+			       index * sizeof(struct xrt_vsec_entry), entry,
+			       sizeof(struct xrt_vsec_entry) /
+			       vsec_regmap_config.reg_stride);
+
+	return ret;
+}
+
+static inline u32 vsec_get_bar(struct xrt_vsec_entry *entry)
+{
+	return ((entry)->bar_rev >> 4) & 0xf;
+}
+
+static inline u64 vsec_get_bar_off(struct xrt_vsec_entry *entry)
+{
+	return (entry)->off_lo | ((u64)(entry)->off_hi << 16);
+}
+
+static inline u32 vsec_get_rev(struct xrt_vsec_entry *entry)
+{
+	return (entry)->bar_rev & 0xf;
+}
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
+		 vsec_get_rev(p_entry));
+	ep.ep_name = type2epname(p_entry->type);
+	ep.bar = vsec_get_bar(p_entry);
+	ep.bar_off = vsec_get_bar_off(p_entry);
+	ep.size = type2size(p_entry->type);
+	ep.regmap = type2regmap(p_entry->type);
+	ep.regmap_ver = regmap_ver;
+	ret = xrt_md_add_endpoint(DEV(vsec->pdev), vsec->metadata, &ep);
+	if (ret)
+		xrt_err(vsec->pdev, "add ep failed, ret %d", ret);
+
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
+		ret = vsec_read_entry(vsec, i, &entry);
+		if (ret) {
+			xrt_err(vsec->pdev, "failed read entry %d, ret %d", i, ret);
+			goto fail;
+		}
+
+		if (entry.type == VSEC_TYPE_END)
+			break;
+		ret = xrt_vsec_add_node(vsec, vsec->metadata, &entry);
+		if (ret)
+			goto fail;
+	}
+
+	return 0;
+
+fail:
+	vfree(vsec->metadata);
+	vsec->metadata = NULL;
+	return ret;
+}
+
+static int xrt_vsec_leaf_call(struct platform_device *pdev, u32 cmd, void *arg)
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
+	struct resource *res = NULL;
+	void __iomem *base = NULL;
+	const u64 *bar_off;
+	const u32 *bar;
+	u64 addr;
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
+	addr = res->start + be64_to_cpu(*bar_off);
+
+	base = devm_ioremap(&vsec->pdev->dev, addr, vsec_regmap_config.max_register);
+	if (!base) {
+		xrt_err(vsec->pdev, "Map failed");
+		return -EIO;
+	}
+
+	vsec->regmap = devm_regmap_init_mmio(&vsec->pdev->dev, base, &vsec_regmap_config);
+	if (IS_ERR(vsec->regmap)) {
+		xrt_err(vsec->pdev, "regmap %pR failed", res);
+		return PTR_ERR(vsec->regmap);
+	}
+
+	ret = regmap_read(vsec->regmap, VSEC_REG_LENGTH, &vsec->length);
+	if (ret) {
+		xrt_err(vsec->pdev, "failed to read length %d", ret);
+		return ret;
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
+	if (vsec->group >= 0)
+		xleaf_destroy_group(pdev, vsec->group);
+	vfree(vsec->metadata);
+
+	return 0;
+}
+
+static int xrt_vsec_probe(struct platform_device *pdev)
+{
+	struct xrt_vsec	*vsec;
+	int ret = 0;
+
+	vsec = devm_kzalloc(&pdev->dev, sizeof(*vsec), GFP_KERNEL);
+	if (!vsec)
+		return -ENOMEM;
+
+	vsec->pdev = pdev;
+	vsec->group = -1;
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
+	vsec->group = xleaf_create_group(pdev, vsec->metadata);
+	if (ret < 0) {
+		xrt_err(pdev, "create group failed, ret %d", vsec->group);
+		ret = vsec->group;
+		goto failed;
+	}
+
+	return 0;
+
+failed:
+	xrt_vsec_remove(pdev);
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
+		.xsd_leaf_call = xrt_vsec_leaf_call,
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
+XRT_LEAF_INIT_FINI_FUNC(XRT_SUBDEV_VSEC, vsec);
-- 
2.27.0


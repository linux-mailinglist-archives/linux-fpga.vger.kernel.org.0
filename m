Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88AAC37B3E8
	for <lists+linux-fpga@lfdr.de>; Wed, 12 May 2021 04:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbhELCBO (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 11 May 2021 22:01:14 -0400
Received: from mail-bn8nam11on2041.outbound.protection.outlook.com ([40.107.236.41]:14976
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230370AbhELCBL (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 11 May 2021 22:01:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WHinleQkOWziCxr5F5gzoOz67+tcwv70aSxXTfpLSw2ueFNQRuKA1hd0eWUt5/u7ARImnYZqrIAkWPTnk8yV6dhauBI4af+pUatLQE/BpwLubpjFqAc6epXFr9gZBhiMXl7APNcXWl9IgJQpEs/nPS7UZfc9QAci6XlWUksziE6vfy+WZxRg0mUPCsR1EVgrii9fvo6+C34sz/1rT09KcmjW76U/SYfRd0ITLvwbK+VU1joJjWqO2KKD7ibTCp7abGW4UTxYvNaaR8O0N9hRgKfzxbx7URmMh7ospu/v1hO/B+Wqfom3k3OQBrlvJHsqgC5/XvBM1PimapI/9NQHyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V9mJsve++LQwM6u/mJHRmEXlxHFFBqypjeFWgYcz4aQ=;
 b=nmLr9VP7yzOeClkzVXc0ZMTvBUlsI7nLs7pkIBqTPX+z5a3NClqy8mVW+/QRQYa1XT8fjN5RbuCCmu5bd3eB1nOWOR3O6ncbReU3rt+V5Sp1E2zJS6Z0SjojXVbVtbZo+vEtDExDp2GXeLnxMHXQFbVWZ2y73Fz5bt0oPAd9M/URucE7Zats1Gk1SkYCkapDyQOR0N336njatYVsxZWdIOj9S9JllifgWnTTPXEC3uMQXdyy2dksmWTJElALuVxWhLnLTJWZRoWOeMt5+tQDX6YRhrVlSaocausbiS+hiw0lcmgIViyC1pyTjVCXNwFgcWaUAPnhpgW6tVW/J5R3ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V9mJsve++LQwM6u/mJHRmEXlxHFFBqypjeFWgYcz4aQ=;
 b=XEdwGvOYvNZ1RhCAyNDHvjrOPL2oT5LkYbWeYmn5KYfMmezjxVlP8PIAUTOw2hqRrK2Lsq/Gamb0cTgWWp3+cHlg4fdYMKYNyQa9jLpDQxMqRFgcW8zZlZt3TRTDOrAFlsqgyk5244FUAwAjuruU6AvP7cPSsC1xPY4qZwMQKaw=
Received: from BN6PR18CA0003.namprd18.prod.outlook.com (2603:10b6:404:121::13)
 by BN6PR02MB2323.namprd02.prod.outlook.com (2603:10b6:404:36::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.27; Wed, 12 May
 2021 02:00:01 +0000
Received: from BN1NAM02FT035.eop-nam02.prod.protection.outlook.com
 (2603:10b6:404:121:cafe::f) by BN6PR18CA0003.outlook.office365.com
 (2603:10b6:404:121::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Wed, 12 May 2021 02:00:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT035.mail.protection.outlook.com (10.13.2.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4065.21 via Frontend Transport; Wed, 12 May 2021 02:00:00 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 11 May 2021 18:59:43 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Tue, 11 May 2021 18:59:43 -0700
Envelope-to: mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.72.212] (port=35736 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1lgeA3-0005ba-Bj; Tue, 11 May 2021 18:59:43 -0700
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id 994BA60012F; Tue, 11 May 2021 18:53:45 -0700 (PDT)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>, Max Zhen <max.zhen@xilinx.com>
Subject: [PATCH V6 XRT Alveo 12/20] fpga: xrt: VSEC driver
Date:   Tue, 11 May 2021 18:53:31 -0700
Message-ID: <20210512015339.5649-13-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210512015339.5649-1-lizhi.hou@xilinx.com>
References: <20210512015339.5649-1-lizhi.hou@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86ff74dd-9a9d-46e5-227c-08d914e9a6ed
X-MS-TrafficTypeDiagnostic: BN6PR02MB2323:
X-Microsoft-Antispam-PRVS: <BN6PR02MB23235CC853AE175AC670099EA1529@BN6PR02MB2323.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BOWcNV7yKbu5cw3DvLllr7QTvR2kCwnSoTOT5KsJ5jgCQYURt8pnVJBB2EJrN49e3K+2lNVEZRkjkMw9ziS7tjYFx4hT4rgOr9JN96gXSTQ+STFOCb1iCyG40iOlLkDcTbDAvnsUMgoQF8Ld2HdPBAy4uJvYMluQwI04W9zF5demD2LblHA/P2d5MXA3pPBTKp1zZVWLNPCNwWdydzg7VQhGsXqm7xeLvFmcP/fZ7RKH4M/7A2Te1j4Dr5yMYNLmLz9+RxSBDoRWWLsqFALtNIn5LJU0/2RnXdV6gRWHA7wEiGhyAWqaFTPsCje32MiXa0hDOnEQ0o9fVWUSiMz6eEV8MkOEKjFvOULv/FL/L4BWzLVhvacG/+ydn7PwP1b7p1wKdq9M6vMjjykmoYtwYANuuryQ6kNuAvIhxBRi1BXHNhclyEhxnKYwf8yJWH6AKwwjyTiMogbjkcMIJRgn75iC+kgYgJvD+pNCpEnM+dls5dvMLBjeMm+sGKEfpyoXAEjDnfGtulxG7Zg3QE+wQScwGgJitYcmqPfTH8d7BW6TlDVQYepCVaDGDZBePidLoK0d7A3ImvPa0vk4v/CV24oovjl/mY7i/JJ4MAZwzDyKMdBbi2DNzlna1eI5vf/GX+p/YBDaotIT/BK8wZg2nY3OYiuPNmlkkoyh7uLibEM=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(346002)(39860400002)(46966006)(36840700001)(186003)(36860700001)(82310400003)(336012)(426003)(2906002)(6666004)(1076003)(44832011)(83380400001)(70206006)(6916009)(6266002)(107886003)(5660300002)(2616005)(8676002)(70586007)(8936002)(82740400003)(356005)(478600001)(7636003)(47076005)(4326008)(316002)(54906003)(36906005)(42186006)(36756003)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 02:00:00.8650
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86ff74dd-9a9d-46e5-227c-08d914e9a6ed
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT035.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2323
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Add VSEC driver. VSEC is a hardware function discovered by walking
PCI Express configure space. A xrt device node will be created for it.
VSEC provides board logic UUID and few offset of other hardware functions.

Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
Signed-off-by: Max Zhen <max.zhen@xilinx.com>
Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
Reviewed-by: Tom Rix <trix@redhat.com>
---
 drivers/fpga/xrt/lib/xleaf/vsec.c | 372 ++++++++++++++++++++++++++++++
 1 file changed, 372 insertions(+)
 create mode 100644 drivers/fpga/xrt/lib/xleaf/vsec.c

diff --git a/drivers/fpga/xrt/lib/xleaf/vsec.c b/drivers/fpga/xrt/lib/xleaf/vsec.c
new file mode 100644
index 000000000000..a6fa4f2ec832
--- /dev/null
+++ b/drivers/fpga/xrt/lib/xleaf/vsec.c
@@ -0,0 +1,372 @@
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
+#include <linux/regmap.h>
+#include "metadata.h"
+#include "xdevice.h"
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
+	char		*compat;
+};
+
+static struct vsec_device vsec_devs[] = {
+	{
+		.type = VSEC_TYPE_UUID,
+		.ep_name = XRT_MD_NODE_BLP_ROM,
+		.size = VSEC_UUID_LEN,
+		.compat = "vsec-uuid",
+	},
+	{
+		.type = VSEC_TYPE_FLASH,
+		.ep_name = XRT_MD_NODE_FLASH_VSEC,
+		.size = 4096,
+		.compat = "vsec-flash",
+	},
+	{
+		.type = VSEC_TYPE_PLATINFO,
+		.ep_name = XRT_MD_NODE_PLAT_INFO,
+		.size = 4,
+		.compat = "vsec-platinfo",
+	},
+	{
+		.type = VSEC_TYPE_MAILBOX,
+		.ep_name = XRT_MD_NODE_MAILBOX_VSEC,
+		.size = 48,
+		.compat = "vsec-mbx",
+	},
+};
+
+XRT_DEFINE_REGMAP_CONFIG(vsec_regmap_config);
+
+struct xrt_vsec {
+	struct xrt_device	*xdev;
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
+	return (entry->bar_rev >> 4) & 0xf;
+}
+
+static inline u64 vsec_get_bar_off(struct xrt_vsec_entry *entry)
+{
+	return entry->off_lo | ((u64)entry->off_hi << 16);
+}
+
+static inline u32 vsec_get_rev(struct xrt_vsec_entry *entry)
+{
+	return entry->bar_rev & 0xf;
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
+static char *type2compat(u32 type)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(vsec_devs); i++) {
+		if (vsec_devs[i].type == type)
+			return (vsec_devs[i].compat);
+	}
+
+	return NULL;
+}
+
+static int xrt_vsec_add_node(struct xrt_vsec *vsec,
+			     void *md_blob, struct xrt_vsec_entry *p_entry)
+{
+	struct xrt_md_endpoint ep;
+	char compat_ver[64];
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
+	snprintf(compat_ver, sizeof(compat_ver) - 1, "%d-%d.%d.%d",
+		 p_entry->ver_type, p_entry->major, p_entry->minor,
+		 vsec_get_rev(p_entry));
+	ep.ep_name = type2epname(p_entry->type);
+	ep.bar_index = vsec_get_bar(p_entry);
+	ep.bar_off = vsec_get_bar_off(p_entry);
+	ep.size = type2size(p_entry->type);
+	ep.compat = type2compat(p_entry->type);
+	ep.compat_ver = compat_ver;
+	ret = xrt_md_add_endpoint(DEV(vsec->xdev), vsec->metadata, &ep);
+	if (ret)
+		xrt_err(vsec->xdev, "add ep failed, ret %d", ret);
+
+	return ret;
+}
+
+static int xrt_vsec_create_metadata(struct xrt_vsec *vsec)
+{
+	struct xrt_vsec_entry entry;
+	int i, ret;
+
+	ret = xrt_md_create(&vsec->xdev->dev, &vsec->metadata);
+	if (ret) {
+		xrt_err(vsec->xdev, "create metadata failed");
+		return ret;
+	}
+
+	for (i = 0; i * sizeof(entry) < vsec->length -
+	    sizeof(struct xrt_vsec_header); i++) {
+		ret = vsec_read_entry(vsec, i, &entry);
+		if (ret) {
+			xrt_err(vsec->xdev, "failed read entry %d, ret %d", i, ret);
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
+static int xrt_vsec_leaf_call(struct xrt_device *xdev, u32 cmd, void *arg)
+{
+	int ret = 0;
+
+	switch (cmd) {
+	case XRT_XLEAF_EVENT:
+		/* Does not handle any event. */
+		break;
+	default:
+		ret = -EINVAL;
+		xrt_err(xdev, "should never been called");
+		break;
+	}
+
+	return ret;
+}
+
+static int xrt_vsec_mapio(struct xrt_vsec *vsec)
+{
+	struct xrt_subdev_platdata *pdata = DEV_PDATA(vsec->xdev);
+	struct resource *res = NULL;
+	void __iomem *base = NULL;
+	const __be64 *bar_off;
+	const __be32 *bar;
+	u64 addr;
+	int ret;
+
+	if (!pdata || xrt_md_size(DEV(vsec->xdev), pdata->xsp_dtb) == XRT_MD_INVALID_LENGTH) {
+		xrt_err(vsec->xdev, "empty metadata");
+		return -EINVAL;
+	}
+
+	ret = xrt_md_get_prop(DEV(vsec->xdev), pdata->xsp_dtb, XRT_MD_NODE_VSEC,
+			      NULL, XRT_MD_PROP_BAR_IDX, (const void **)&bar, NULL);
+	if (ret) {
+		xrt_err(vsec->xdev, "failed to get bar idx, ret %d", ret);
+		return -EINVAL;
+	}
+
+	ret = xrt_md_get_prop(DEV(vsec->xdev), pdata->xsp_dtb, XRT_MD_NODE_VSEC,
+			      NULL, XRT_MD_PROP_OFFSET, (const void **)&bar_off, NULL);
+	if (ret) {
+		xrt_err(vsec->xdev, "failed to get bar off, ret %d", ret);
+		return -EINVAL;
+	}
+
+	xrt_info(vsec->xdev, "Map vsec at bar %d, offset 0x%llx",
+		 be32_to_cpu(*bar), be64_to_cpu(*bar_off));
+
+	xleaf_get_root_res(vsec->xdev, be32_to_cpu(*bar), &res);
+	if (!res) {
+		xrt_err(vsec->xdev, "failed to get bar addr");
+		return -EINVAL;
+	}
+
+	addr = res->start + be64_to_cpu(*bar_off);
+
+	base = devm_ioremap(&vsec->xdev->dev, addr, vsec_regmap_config.max_register);
+	if (!base) {
+		xrt_err(vsec->xdev, "Map failed");
+		return -EIO;
+	}
+
+	vsec->regmap = devm_regmap_init_mmio(&vsec->xdev->dev, base, &vsec_regmap_config);
+	if (IS_ERR(vsec->regmap)) {
+		xrt_err(vsec->xdev, "regmap %pR failed", res);
+		return PTR_ERR(vsec->regmap);
+	}
+
+	ret = regmap_read(vsec->regmap, VSEC_REG_LENGTH, &vsec->length);
+	if (ret) {
+		xrt_err(vsec->xdev, "failed to read length %d", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void xrt_vsec_remove(struct xrt_device *xdev)
+{
+	struct xrt_vsec	*vsec;
+
+	vsec = xrt_get_drvdata(xdev);
+
+	if (vsec->group >= 0)
+		xleaf_destroy_group(xdev, vsec->group);
+	vfree(vsec->metadata);
+}
+
+static int xrt_vsec_probe(struct xrt_device *xdev)
+{
+	struct xrt_vsec	*vsec;
+	int ret = 0;
+
+	vsec = devm_kzalloc(&xdev->dev, sizeof(*vsec), GFP_KERNEL);
+	if (!vsec)
+		return -ENOMEM;
+
+	vsec->xdev = xdev;
+	vsec->group = -1;
+	xrt_set_drvdata(xdev, vsec);
+
+	ret = xrt_vsec_mapio(vsec);
+	if (ret)
+		goto failed;
+
+	ret = xrt_vsec_create_metadata(vsec);
+	if (ret) {
+		xrt_err(xdev, "create metadata failed, ret %d", ret);
+		goto failed;
+	}
+	ret = xleaf_create_group(xdev, vsec->metadata);
+	if (ret < 0) {
+		xrt_err(xdev, "create group failed, ret %d", vsec->group);
+		goto failed;
+	}
+	vsec->group = ret;
+
+	return 0;
+
+failed:
+	xrt_vsec_remove(xdev);
+
+	return ret;
+}
+
+static struct xrt_dev_endpoints xrt_vsec_endpoints[] = {
+	{
+		.xse_names = (struct xrt_dev_ep_names []){
+			{ .ep_name = XRT_MD_NODE_VSEC },
+			{ NULL },
+		},
+		.xse_min_ep = 1,
+	},
+	{ 0 },
+};
+
+static struct xrt_driver xrt_vsec_driver = {
+	.driver = {
+		.name = XRT_VSEC,
+	},
+	.subdev_id = XRT_SUBDEV_VSEC,
+	.endpoints = xrt_vsec_endpoints,
+	.probe = xrt_vsec_probe,
+	.remove = xrt_vsec_remove,
+	.leaf_call = xrt_vsec_leaf_call,
+};
+
+XRT_LEAF_INIT_FINI_FUNC(vsec);
-- 
2.27.0


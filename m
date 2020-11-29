Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 214FD2C76BB
	for <lists+linux-fpga@lfdr.de>; Sun, 29 Nov 2020 01:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729302AbgK2ADZ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 28 Nov 2020 19:03:25 -0500
Received: from mail-bn8nam12on2081.outbound.protection.outlook.com ([40.107.237.81]:30561
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725852AbgK2ADY (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sat, 28 Nov 2020 19:03:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DqX2ThPaLLPE5OhyS4IFy1SoSHyOweZQ6DFKWmSyMdiPokILDrQTX22ISL6sRRuThhVMsJS6AQtcFXA98yULsl1Yq11wExh2PxfQqXday/nn1OLtzfxR+bN63yuQY+uKviEJyvZ3+MlApetNriTFPBCJ58PNX9niQH5mhPgceYjvRE6aIxlGTJ9KIvm4AMjWR7cfPgJWxu6XlOnSVR1B5mpJSkD0vEUf7DTFJkgZ7Is5ZEIM8k1QEkAgDSgT8MEnqC03sBB5dQd4uQ4s83bEoUqQK24hLLnxt/9Z2vlwxjyA2mlYzBtXTOFkgZ7CStAXB51CM1qkdY8ymKBZN4ZgOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OIrN3VIs0C16Hi9y7cQVzjqA+9TATb+JX2Mn/AhVVKo=;
 b=Z2Ye95pglfsCVmC7ujcEmU2qWrPR9ol7TJEnHTwY90OaLhnfaz6chQmRrxsZMgunDQgvojuuilMIyyRgDKN5FaQ3o4/LDFgEndlTzAY1k+/J82DgeymuhHNghc3WDipz5bh5Y0TAsIMgLHkEgvMZhpWO7eqLp+04ZYN3m5p+HHtXI5ee49t32d8Vx1K2OnaHfrLr4NqFSIa2cmx8QvZmFU0ZYd7n/FI+kv7H+5yLhXltDqw8f09x36EvuFeVBsmo72mzTiyqH4bryRcdW4xtl94peeVNPQgwLMpU/Es9AqKZUr/ilDo0z58uGBb8z4K1ejYmpy/eNvMb023SBCG5OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OIrN3VIs0C16Hi9y7cQVzjqA+9TATb+JX2Mn/AhVVKo=;
 b=S8R2RFZztEGu6caC+ftjb7akTgcLIfQgLjZJKrw0+gs3wUtEUn+QgsoyQH4y6XlnwwhT9z98mpxV2LLImwbZZEdaCgd3YiUeXtcZ62rRySxzhjbehoP3ocA71wGeMwtFLOfsMmxBsxxi0svKANjHc0khz/nCYh9nhLoieVRyZEE=
Received: from SA0PR11CA0083.namprd11.prod.outlook.com (2603:10b6:806:d2::28)
 by CH2PR02MB7047.namprd02.prod.outlook.com (2603:10b6:610:85::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20; Sun, 29 Nov
 2020 00:02:16 +0000
Received: from SN1NAM02FT048.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:d2:cafe::a2) by SA0PR11CA0083.outlook.office365.com
 (2603:10b6:806:d2::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.22 via Frontend
 Transport; Sun, 29 Nov 2020 00:02:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT048.mail.protection.outlook.com (10.152.72.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3611.27 via Frontend Transport; Sun, 29 Nov 2020 00:02:15 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Sat, 28 Nov 2020 16:02:15 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Sat, 28 Nov 2020 16:02:15 -0800
Envelope-to: michal.simek@xilinx.com,
 sonal.santan@xilinx.com,
 lizhih@xilinx.com,
 maxz@xilinx.com,
 stefanos@xilinx.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.72.212] (port=45052 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <sonal.santan@xilinx.com>)
        id 1kjAAQ-0000Ge-TF; Sat, 28 Nov 2020 16:02:14 -0800
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 6354)
        id 0FDEE60010C; Sat, 28 Nov 2020 16:00:45 -0800 (PST)
From:   Sonal Santan <sonal.santan@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Sonal Santan <sonal.santan@xilinx.com>,
        <linux-fpga@vger.kernel.org>, <maxz@xilinx.com>,
        <lizhih@xilinx.com>, <michal.simek@xilinx.com>,
        <stefanos@xilinx.com>, <devicetree@vger.kernel.org>
Subject: [PATCH Xilinx Alveo 3/8] fpga: xrt: infrastructure support for xmgmt driver
Date:   Sat, 28 Nov 2020 16:00:35 -0800
Message-ID: <20201129000040.24777-4-sonals@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201129000040.24777-1-sonals@xilinx.com>
References: <20201129000040.24777-1-sonals@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 186e5348-2fe8-4a60-ef30-08d893fa0807
X-MS-TrafficTypeDiagnostic: CH2PR02MB7047:
X-Microsoft-Antispam-PRVS: <CH2PR02MB7047C2EABEB9D6FFC43C45AFBBF60@CH2PR02MB7047.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:103;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VpCln0cvR/jq+q8MVpG53EVWBNk4RBcwwfVBmJ8cFz9OI9cmWgd9qjsSflp/FKGkGYbKglTubPPZk6LymeYeVFhCT3jTsS2XcR+TPvhDDWBGjEzhfmjGhYdGiG/WCVKO2w2yHq3PgwVIwJ/SDtAyEIatSsGquo7AOt+rC7+vsZkqljWK/FqDVdYNJ87azn22fdGSJaLFPqL/PR63HsyG0bKPG0/9ojfIw7P9AoILuzNinbEc4erb9h7iYtyaHTQ8mhYc8rSWpKnKU2v6h11OcOwZDSe44E2tzl8ZS6LHmoI3wfnSIdxrjxwUXw90+WoAWDYmyHqbZa5bxEfDyndtWcUEPxCIY0xgG7B73RY3jJmDEunJkLVrwrsgq8LOX/Fso0REZX0A5VQ6ExUfwDzMBA==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(376002)(346002)(39850400004)(396003)(136003)(46966005)(82740400003)(30864003)(6916009)(1076003)(478600001)(186003)(36756003)(336012)(450100002)(4326008)(6266002)(26005)(5660300002)(8936002)(54906003)(2616005)(7636003)(70206006)(70586007)(42186006)(6666004)(47076004)(82310400003)(36906005)(316002)(2906002)(44832011)(426003)(8676002)(83380400001)(356005)(579004);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2020 00:02:15.7960
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 186e5348-2fe8-4a60-ef30-08d893fa0807
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT048.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB7047
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Sonal Santan <sonal.santan@xilinx.com>

Add infrastructure code for XRT management physical function
driver. This provides support for enumerating and extracting
sections from xclbin files, interacting with device tree nodes
found in xclbin and working with Alveo partitions.

Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
---
 drivers/fpga/alveo/common/xrt-metadata.c | 590 ++++++++++++++++++
 drivers/fpga/alveo/common/xrt-root.c     | 744 +++++++++++++++++++++++
 drivers/fpga/alveo/common/xrt-root.h     |  24 +
 drivers/fpga/alveo/common/xrt-xclbin.c   | 387 ++++++++++++
 drivers/fpga/alveo/common/xrt-xclbin.h   |  46 ++
 5 files changed, 1791 insertions(+)
 create mode 100644 drivers/fpga/alveo/common/xrt-metadata.c
 create mode 100644 drivers/fpga/alveo/common/xrt-root.c
 create mode 100644 drivers/fpga/alveo/common/xrt-root.h
 create mode 100644 drivers/fpga/alveo/common/xrt-xclbin.c
 create mode 100644 drivers/fpga/alveo/common/xrt-xclbin.h

diff --git a/drivers/fpga/alveo/common/xrt-metadata.c b/drivers/fpga/alveo/common/xrt-metadata.c
new file mode 100644
index 000000000000..5596619ed82d
--- /dev/null
+++ b/drivers/fpga/alveo/common/xrt-metadata.c
@@ -0,0 +1,590 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx Alveo FPGA Metadata parse APIs
+ *
+ * Copyright (C) 2020 Xilinx, Inc.
+ *
+ * Authors:
+ *      Lizhi Hou <Lizhi.Hou@xilinx.com>
+ */
+
+#include <linux/libfdt_env.h>
+#include "libfdt.h"
+#include "xrt-metadata.h"
+
+#define MAX_BLOB_SIZE	(4096 * 25)
+
+#define md_err(dev, fmt, args...)			\
+	dev_err(dev, "%s: "fmt, __func__, ##args)
+#define md_warn(dev, fmt, args...)			\
+	dev_warn(dev, "%s: "fmt, __func__, ##args)
+#define md_info(dev, fmt, args...)			\
+	dev_info(dev, "%s: "fmt, __func__, ##args)
+#define md_dbg(dev, fmt, args...)			\
+	dev_dbg(dev, "%s: "fmt, __func__, ##args)
+
+static int xrt_md_setprop(struct device *dev, char *blob, int offset,
+	const char *prop, const void *val, int size);
+static int xrt_md_overlay(struct device *dev, char *blob, int target,
+	const char *overlay_blob, int overlay_offset);
+static int xrt_md_get_endpoint(struct device *dev, const char *blob,
+	const char *ep_name, const char *regmap_name, int *ep_offset);
+
+long xrt_md_size(struct device *dev, const char *blob)
+{
+	long len = (long) fdt_totalsize(blob);
+
+	return (len > MAX_BLOB_SIZE) ? -EINVAL : len;
+}
+
+int xrt_md_create(struct device *dev, char **blob)
+{
+	int ret = 0;
+
+	WARN_ON(!blob);
+
+	*blob = vmalloc(MAX_BLOB_SIZE);
+	if (!*blob)
+		return -ENOMEM;
+
+	ret = fdt_create_empty_tree(*blob, MAX_BLOB_SIZE);
+	if (ret) {
+		md_err(dev, "format blob failed, ret = %d", ret);
+		goto failed;
+	}
+
+	ret = fdt_next_node(*blob, -1, NULL);
+	if (ret < 0) {
+		md_err(dev, "No Node, ret = %d", ret);
+		goto failed;
+	}
+
+	ret = fdt_add_subnode(*blob, ret, NODE_ENDPOINTS);
+	if (ret < 0)
+		md_err(dev, "add node failed, ret = %d", ret);
+
+failed:
+	if (ret < 0) {
+		vfree(*blob);
+		*blob = NULL;
+	} else
+		ret = 0;
+
+	return ret;
+}
+
+int xrt_md_add_node(struct device *dev, char *blob, int parent_offset,
+	const char *ep_name)
+{
+	int ret;
+
+	ret = fdt_add_subnode(blob, parent_offset, ep_name);
+	if (ret < 0 && ret != -FDT_ERR_EXISTS)
+		md_err(dev, "failed to add node %s. %d", ep_name, ret);
+
+	return ret;
+}
+
+int xrt_md_del_endpoint(struct device *dev, char *blob, const char *ep_name,
+	char *regmap_name)
+{
+	int ret;
+	int ep_offset;
+
+	ret = xrt_md_get_endpoint(dev, blob, ep_name, regmap_name, &ep_offset);
+	if (ret) {
+		md_err(dev, "can not find ep %s", ep_name);
+		return -EINVAL;
+	}
+
+	ret = fdt_del_node(blob, ep_offset);
+	if (ret)
+		md_err(dev, "delete node %s failed, ret %d", ep_name, ret);
+
+	return ret;
+}
+
+static int __xrt_md_add_endpoint(struct device *dev, char *blob,
+	struct xrt_md_endpoint *ep, int *offset, bool root)
+{
+	int ret = 0;
+	int ep_offset;
+	u32 val, count = 0;
+	u64 io_range[2];
+	char comp[128];
+
+	if (!ep->ep_name) {
+		md_err(dev, "empty name");
+		return -EINVAL;
+	}
+
+	if (!root) {
+		ret = xrt_md_get_endpoint(dev, blob, NODE_ENDPOINTS, NULL,
+			&ep_offset);
+		if (ret) {
+			md_err(dev, "invalid blob, ret = %d", ret);
+			return -EINVAL;
+		}
+	} else {
+		ep_offset = 0;
+	}
+
+	ep_offset = xrt_md_add_node(dev, blob, ep_offset, ep->ep_name);
+	if (ep_offset < 0) {
+		md_err(dev, "add endpoint failed, ret = %d", ret);
+		return -EINVAL;
+	}
+	if (offset)
+		*offset = ep_offset;
+
+	if (ep->size != 0) {
+		val = cpu_to_be32(ep->bar);
+		ret = xrt_md_setprop(dev, blob, ep_offset, PROP_BAR_IDX,
+				&val, sizeof(u32));
+		if (ret) {
+			md_err(dev, "set %s failed, ret %d",
+				PROP_BAR_IDX, ret);
+			goto failed;
+		}
+		io_range[0] = cpu_to_be64((u64)ep->bar_off);
+		io_range[1] = cpu_to_be64((u64)ep->size);
+		ret = xrt_md_setprop(dev, blob, ep_offset, PROP_IO_OFFSET,
+			io_range, sizeof(io_range));
+		if (ret) {
+			md_err(dev, "set %s failed, ret %d",
+				PROP_IO_OFFSET, ret);
+			goto failed;
+		}
+	}
+
+	if (ep->regmap) {
+		if (ep->regmap_ver) {
+			count = snprintf(comp, sizeof(comp),
+				"%s-%s", ep->regmap, ep->regmap_ver);
+			count++;
+		}
+
+		count += snprintf(comp + count, sizeof(comp) - count,
+			"%s", ep->regmap);
+		count++;
+
+		ret = xrt_md_setprop(dev, blob, ep_offset, PROP_COMPATIBLE,
+			comp, count);
+		if (ret) {
+			md_err(dev, "set %s failed, ret %d",
+				PROP_COMPATIBLE, ret);
+			goto failed;
+		}
+	}
+
+failed:
+	if (ret)
+		xrt_md_del_endpoint(dev, blob, ep->ep_name, NULL);
+
+	return ret;
+}
+
+int xrt_md_add_endpoint(struct device *dev, char *blob,
+	struct xrt_md_endpoint *ep)
+{
+	return __xrt_md_add_endpoint(dev, blob, ep, NULL, false);
+}
+
+static int xrt_md_get_endpoint(struct device *dev, const char *blob,
+	const char *ep_name, const char *regmap_name, int *ep_offset)
+{
+	int offset;
+	const char *name;
+
+	for (offset = fdt_next_node(blob, -1, NULL);
+	    offset >= 0;
+	    offset = fdt_next_node(blob, offset, NULL)) {
+		name = fdt_get_name(blob, offset, NULL);
+		if (!name || strncmp(name, ep_name, strlen(ep_name) + 1))
+			continue;
+		if (!regmap_name ||
+		    !fdt_node_check_compatible(blob, offset, regmap_name))
+			break;
+	}
+	if (offset < 0)
+		return -ENODEV;
+
+	*ep_offset = offset;
+
+	return 0;
+}
+
+int xrt_md_get_epname_pointer(struct device *dev, const char *blob,
+	 const char *ep_name, const char *regmap_name, const char **epname)
+{
+	int offset;
+	int ret;
+
+	ret = xrt_md_get_endpoint(dev, blob, ep_name, regmap_name,
+		&offset);
+	if (!ret && epname && offset >= 0)
+		*epname = fdt_get_name(blob, offset, NULL);
+
+	return ret;
+}
+
+int xrt_md_get_prop(struct device *dev, const char *blob, const char *ep_name,
+	const char *regmap_name, const char *prop, const void **val, int *size)
+{
+	int offset;
+	int ret;
+
+	if (val)
+		*val = NULL;
+	if (ep_name) {
+		ret = xrt_md_get_endpoint(dev, blob, ep_name, regmap_name,
+			&offset);
+		if (ret) {
+			md_err(dev, "cannot get ep %s, regmap %s, ret = %d",
+				ep_name, regmap_name, ret);
+			return -EINVAL;
+		}
+	} else {
+		offset = fdt_next_node(blob, -1, NULL);
+		if (offset < 0) {
+			md_err(dev, "internal error, ret = %d", offset);
+			return -EINVAL;
+		}
+	}
+
+	if (val) {
+		*val = fdt_getprop(blob, offset, prop, size);
+		if (!*val) {
+			md_dbg(dev, "get ep %s, prop %s failed", ep_name, prop);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+static int xrt_md_setprop(struct device *dev, char *blob, int offset,
+	 const char *prop, const void *val, int size)
+{
+	int ret;
+
+	ret = fdt_setprop(blob, offset, prop, val, size);
+	if (ret)
+		md_err(dev, "failed to set prop %d", ret);
+
+	return ret;
+}
+
+int xrt_md_set_prop(struct device *dev, char *blob,
+	const char *ep_name, const char *regmap_name,
+	const char *prop, const void *val, int size)
+{
+	int offset;
+	int ret;
+
+	if (ep_name) {
+		ret = xrt_md_get_endpoint(dev, blob, ep_name,
+			regmap_name, &offset);
+		if (ret) {
+			md_err(dev, "cannot get node %s, ret = %d",
+				ep_name, ret);
+			return -EINVAL;
+		}
+	} else {
+		offset = fdt_next_node(blob, -1, NULL);
+		if (offset < 0) {
+			md_err(dev, "internal error, ret = %d", offset);
+			return -EINVAL;
+		}
+	}
+
+	ret = xrt_md_setprop(dev, blob, offset, prop, val, size);
+	if (ret)
+		md_err(dev, "set prop %s failed, ret = %d", prop, ret);
+
+	return ret;
+}
+
+int xrt_md_copy_endpoint(struct device *dev, char *blob, const char *src_blob,
+	const char *ep_name, const char *regmap_name, const char *new_ep_name)
+{
+	int offset, target;
+	int ret;
+	struct xrt_md_endpoint ep = {0};
+	const char *newepnm = new_ep_name ? new_ep_name : ep_name;
+
+	ret = xrt_md_get_endpoint(dev, src_blob, ep_name, regmap_name,
+		&offset);
+	if (ret)
+		return -EINVAL;
+
+	ret = xrt_md_get_endpoint(dev, blob, newepnm, regmap_name, &target);
+	if (ret) {
+		ep.ep_name = newepnm;
+		ret = __xrt_md_add_endpoint(dev, blob, &ep, &target,
+			fdt_parent_offset(src_blob, offset) == 0);
+		if (ret)
+			return -EINVAL;
+	}
+
+	ret = xrt_md_overlay(dev, blob, target, src_blob, offset);
+	if (ret)
+		md_err(dev, "overlay failed, ret = %d", ret);
+
+	return ret;
+}
+
+int xrt_md_copy_all_eps(struct device *dev, char *blob, const char *src_blob)
+{
+	return xrt_md_copy_endpoint(dev, blob, src_blob, NODE_ENDPOINTS,
+		NULL, NULL);
+}
+
+char *xrt_md_dup(struct device *dev, const char *blob)
+{
+	int ret;
+	char *dup_blob;
+
+	ret = xrt_md_create(dev, &dup_blob);
+	if (ret)
+		return NULL;
+	ret = xrt_md_overlay(dev, dup_blob, -1, blob, -1);
+	if (ret) {
+		vfree(dup_blob);
+		return NULL;
+	}
+
+	return dup_blob;
+}
+
+static int xrt_md_overlay(struct device *dev, char *blob, int target,
+	const char *overlay_blob, int overlay_offset)
+{
+	int	property, subnode;
+	int	ret;
+
+	WARN_ON(!blob || !overlay_blob);
+
+	if (!blob) {
+		md_err(dev, "blob is NULL");
+		return -EINVAL;
+	}
+
+	if (target < 0) {
+		target = fdt_next_node(blob, -1, NULL);
+		if (target < 0) {
+			md_err(dev, "invalid target");
+			return -EINVAL;
+		}
+	}
+	if (overlay_offset < 0) {
+		overlay_offset = fdt_next_node(overlay_blob, -1, NULL);
+		if (overlay_offset < 0) {
+			md_err(dev, "invalid overlay");
+			return -EINVAL;
+		}
+	}
+
+	fdt_for_each_property_offset(property, overlay_blob, overlay_offset) {
+		const char *name;
+		const void *prop;
+		int prop_len;
+
+		prop = fdt_getprop_by_offset(overlay_blob, property, &name,
+			&prop_len);
+		if (!prop || prop_len >= MAX_BLOB_SIZE) {
+			md_err(dev, "internal error");
+			return -EINVAL;
+		}
+
+		ret = xrt_md_setprop(dev, blob, target, name, prop,
+			prop_len);
+		if (ret) {
+			md_err(dev, "setprop failed, ret = %d", ret);
+			return ret;
+		}
+	}
+
+	fdt_for_each_subnode(subnode, overlay_blob, overlay_offset) {
+		const char *name = fdt_get_name(overlay_blob, subnode, NULL);
+		int nnode;
+
+		nnode = xrt_md_add_node(dev, blob, target, name);
+		if (nnode == -FDT_ERR_EXISTS)
+			nnode = fdt_subnode_offset(blob, target, name);
+		if (nnode < 0) {
+			md_err(dev, "add node failed, ret = %d", nnode);
+			return nnode;
+		}
+
+		ret = xrt_md_overlay(dev, blob, nnode, overlay_blob, subnode);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+int xrt_md_get_next_endpoint(struct device *dev, const char *blob,
+	const char *ep_name, const char *regmap_name,
+	char **next_ep, char **next_regmap)
+{
+	int offset, ret;
+
+	if (!ep_name) {
+		ret = xrt_md_get_endpoint(dev, blob, NODE_ENDPOINTS, NULL,
+			&offset);
+	} else {
+		ret = xrt_md_get_endpoint(dev, blob, ep_name, regmap_name,
+			&offset);
+	}
+
+	if (ret) {
+		*next_ep = NULL;
+		*next_regmap = NULL;
+		return -EINVAL;
+	}
+
+	offset = ep_name ? fdt_next_subnode(blob, offset) :
+		fdt_first_subnode(blob, offset);
+	if (offset < 0) {
+		*next_ep = NULL;
+		*next_regmap = NULL;
+		return -EINVAL;
+	}
+
+	*next_ep = (char *)fdt_get_name(blob, offset, NULL);
+	*next_regmap = (char *)fdt_stringlist_get(blob, offset, PROP_COMPATIBLE,
+		0, NULL);
+
+	return 0;
+}
+
+int xrt_md_get_compatible_epname(struct device *dev, const char *blob,
+	const char *regmap_name, const char **ep_name)
+{
+	int ep_offset;
+
+	ep_offset = fdt_node_offset_by_compatible(blob, -1, regmap_name);
+	if (ep_offset < 0) {
+		*ep_name = NULL;
+		return -ENOENT;
+	}
+
+	*ep_name = (char *)fdt_get_name(blob, ep_offset, NULL);
+
+	return 0;
+}
+
+int xrt_md_uuid_strtoid(struct device *dev, const char *uuidstr, uuid_t *p_uuid)
+{
+	char *p;
+	const char *str;
+	char tmp[3] = { 0 };
+	int i, ret;
+
+	memset(p_uuid, 0, sizeof(*p_uuid));
+	p = (char *)p_uuid;
+	str = uuidstr + strlen(uuidstr) - 2;
+
+	for (i = 0; i < sizeof(*p_uuid) && str >= uuidstr; i++) {
+		tmp[0] = *str;
+		tmp[1] = *(str + 1);
+		ret = kstrtou8(tmp, 16, p);
+		if (ret) {
+			md_err(dev, "Invalid uuid %s", uuidstr);
+			return -EINVAL;
+		}
+		p++;
+		str -= 2;
+	}
+
+	return 0;
+}
+
+void xrt_md_pack(struct device *dev, char *blob)
+{
+	int ret;
+
+	ret = fdt_pack(blob);
+	if (ret)
+		md_err(dev, "pack failed %d", ret);
+}
+
+int xrt_md_get_intf_uuids(struct device *dev, const char *blob,
+	u32 *num_uuids, uuid_t *intf_uuids)
+{
+	int offset, count = 0;
+	int ret;
+	const char *uuid_str;
+
+	ret = xrt_md_get_endpoint(dev, blob, NODE_INTERFACES, NULL, &offset);
+	if (ret)
+		return -ENOENT;
+
+	for (offset = fdt_first_subnode(blob, offset);
+	    offset >= 0;
+	    offset = fdt_next_subnode(blob, offset)) {
+		uuid_str = fdt_getprop(blob, offset, PROP_INTERFACE_UUID,
+			NULL);
+		if (!uuid_str) {
+			md_err(dev, "empty intf uuid node");
+			return -EINVAL;
+		}
+
+		if (intf_uuids && count < *num_uuids) {
+			ret = xrt_md_uuid_strtoid(dev, uuid_str,
+				&intf_uuids[count]);
+			if (ret)
+				return -EINVAL;
+		}
+		count++;
+	}
+
+	*num_uuids = count;
+
+	return 0;
+}
+
+int xrt_md_check_uuids(struct device *dev, const char *blob, char *subset_blob)
+{
+	const char *subset_int_uuid = NULL;
+	const char *int_uuid = NULL;
+	int offset, subset_offset, off;
+	int ret;
+
+	ret = xrt_md_get_endpoint(dev, subset_blob, NODE_INTERFACES, NULL,
+		&subset_offset);
+	if (ret)
+		return -EINVAL;
+
+	ret = xrt_md_get_endpoint(dev, blob, NODE_INTERFACES, NULL,
+		&offset);
+	if (ret)
+		return -EINVAL;
+
+	for (subset_offset = fdt_first_subnode(subset_blob, subset_offset);
+	    subset_offset >= 0;
+	    subset_offset = fdt_next_subnode(subset_blob, subset_offset)) {
+		subset_int_uuid = fdt_getprop(subset_blob, subset_offset,
+			PROP_INTERFACE_UUID, NULL);
+		if (!subset_int_uuid)
+			return -EINVAL;
+		off = offset;
+
+		for (off = fdt_first_subnode(blob, off);
+		    off >= 0;
+		    off = fdt_next_subnode(blob, off)) {
+			int_uuid = fdt_getprop(blob, off,
+				PROP_INTERFACE_UUID, NULL);
+			if (!int_uuid)
+				return -EINVAL;
+			if (!strcmp(int_uuid, subset_int_uuid))
+				break;
+		}
+		if (off < 0)
+			return -ENOENT;
+	}
+
+	return 0;
+}
diff --git a/drivers/fpga/alveo/common/xrt-root.c b/drivers/fpga/alveo/common/xrt-root.c
new file mode 100644
index 000000000000..7cc23dfaf3cf
--- /dev/null
+++ b/drivers/fpga/alveo/common/xrt-root.c
@@ -0,0 +1,744 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *
+ * Copyright (C) 2020 Xilinx, Inc.
+ *
+ * Authors:
+ *	Cheng Zhen <maxz@xilinx.com>
+ */
+
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/hwmon.h>
+#include "xrt-subdev.h"
+#include "xrt-parent.h"
+#include "xrt-partition.h"
+#include "xrt-root.h"
+#include "xrt-metadata.h"
+#include "xrt-root.h"
+
+#define	XROOT_PDEV(xr)		((xr)->pdev)
+#define	XROOT_DEV(xr)		(&(XROOT_PDEV(xr)->dev))
+#define xroot_err(xr, fmt, args...)	\
+	dev_err(XROOT_DEV(xr), "%s: " fmt, __func__, ##args)
+#define xroot_warn(xr, fmt, args...)	\
+	dev_warn(XROOT_DEV(xr), "%s: " fmt, __func__, ##args)
+#define xroot_info(xr, fmt, args...)	\
+	dev_info(XROOT_DEV(xr), "%s: " fmt, __func__, ##args)
+#define xroot_dbg(xr, fmt, args...)	\
+	dev_dbg(XROOT_DEV(xr), "%s: " fmt, __func__, ##args)
+
+#define XRT_VSEC_ID	0x20
+#define	XROOT_PART_FIRST	(-1)
+#define	XROOT_PART_LAST		(-2)
+
+static int xroot_parent_cb(struct device *, void *, u32, void *);
+
+struct xroot_async_evt {
+	struct list_head list;
+	struct xrt_parent_ioctl_async_broadcast_evt evt;
+};
+
+struct xroot_event_cb {
+	struct list_head list;
+	bool initialized;
+	struct xrt_parent_ioctl_evt_cb cb;
+};
+
+struct xroot_events {
+	struct list_head cb_list;
+	struct mutex cb_lock;
+	struct work_struct cb_init_work;
+	struct mutex async_evt_lock;
+	struct list_head async_evt_list;
+	struct work_struct async_evt_work;
+};
+
+struct xroot_parts {
+	struct xrt_subdev_pool pool;
+	struct work_struct bringup_work;
+	atomic_t bringup_pending;
+	atomic_t bringup_failed;
+	struct completion bringup_comp;
+};
+
+struct xroot {
+	struct pci_dev *pdev;
+	struct xroot_events events;
+	struct xroot_parts parts;
+};
+
+struct xroot_part_match_arg {
+	enum xrt_subdev_id id;
+	int instance;
+};
+
+static bool xroot_part_match(enum xrt_subdev_id id,
+	struct platform_device *pdev, void *arg)
+{
+	struct xroot_part_match_arg *a = (struct xroot_part_match_arg *)arg;
+	return id == a->id && pdev->id == a->instance;
+}
+
+static int xroot_get_partition(struct xroot *xr, int instance,
+	struct platform_device **partp)
+{
+	int rc = 0;
+	struct xrt_subdev_pool *parts = &xr->parts.pool;
+	struct device *dev = DEV(xr->pdev);
+	struct xroot_part_match_arg arg = { XRT_SUBDEV_PART, instance };
+
+	if (instance == XROOT_PART_LAST) {
+		rc = xrt_subdev_pool_get(parts, XRT_SUBDEV_MATCH_NEXT,
+			*partp, dev, partp);
+	} else if (instance == XROOT_PART_FIRST) {
+		rc = xrt_subdev_pool_get(parts, XRT_SUBDEV_MATCH_PREV,
+			*partp, dev, partp);
+	} else {
+		rc = xrt_subdev_pool_get(parts, xroot_part_match,
+			&arg, dev, partp);
+	}
+
+	if (rc && rc != -ENOENT)
+		xroot_err(xr, "failed to hold partition %d: %d", instance, rc);
+	return rc;
+}
+
+static void xroot_put_partition(struct xroot *xr, struct platform_device *part)
+{
+	int inst = part->id;
+	int rc = xrt_subdev_pool_put(&xr->parts.pool, part, DEV(xr->pdev));
+
+	if (rc)
+		xroot_err(xr, "failed to release partition %d: %d", inst, rc);
+}
+
+static int
+xroot_partition_trigger_evt(struct xroot *xr, struct xroot_event_cb *cb,
+	struct platform_device *part, enum xrt_events evt)
+{
+	xrt_subdev_match_t match = cb->cb.xevt_match_cb;
+	xrt_event_cb_t evtcb = cb->cb.xevt_cb;
+	void *arg = cb->cb.xevt_match_arg;
+	struct xrt_partition_ioctl_event e = { evt, &cb->cb };
+	struct xrt_event_arg_subdev esd = { XRT_SUBDEV_PART, part->id };
+	int rc;
+
+	if (match(XRT_SUBDEV_PART, part, arg)) {
+		rc = evtcb(cb->cb.xevt_pdev, evt, &esd);
+		if (rc)
+			return rc;
+	}
+
+	return xrt_subdev_ioctl(part, XRT_PARTITION_EVENT, &e);
+}
+
+static void
+xroot_event_partition(struct xroot *xr, int instance, enum xrt_events evt)
+{
+	int ret;
+	struct platform_device *pdev = NULL;
+	const struct list_head *ptr, *next;
+	struct xroot_event_cb *tmp;
+
+	BUG_ON(instance < 0);
+	ret = xroot_get_partition(xr, instance, &pdev);
+	if (ret)
+		return;
+
+	mutex_lock(&xr->events.cb_lock);
+	list_for_each_safe(ptr, next, &xr->events.cb_list) {
+		int rc;
+
+		tmp = list_entry(ptr, struct xroot_event_cb, list);
+		if (!tmp->initialized)
+			continue;
+
+		rc = xroot_partition_trigger_evt(xr, tmp, pdev, evt);
+		if (rc) {
+			list_del(&tmp->list);
+			vfree(tmp);
+		}
+	}
+	mutex_unlock(&xr->events.cb_lock);
+
+	(void) xroot_put_partition(xr, pdev);
+}
+
+int xroot_create_partition(void *root, char *dtb)
+{
+	struct xroot *xr = (struct xroot *)root;
+	int ret;
+
+	atomic_inc(&xr->parts.bringup_pending);
+	ret = xrt_subdev_pool_add(&xr->parts.pool,
+		XRT_SUBDEV_PART, xroot_parent_cb, xr, dtb);
+	if (ret >= 0) {
+		schedule_work(&xr->parts.bringup_work);
+	} else {
+		atomic_dec(&xr->parts.bringup_pending);
+		atomic_inc(&xr->parts.bringup_failed);
+		xroot_err(xr, "failed to create partition: %d", ret);
+	}
+	return ret;
+}
+
+static int xroot_destroy_single_partition(struct xroot *xr, int instance)
+{
+	struct platform_device *pdev = NULL;
+	int ret;
+
+	BUG_ON(instance < 0);
+	ret = xroot_get_partition(xr, instance, &pdev);
+	if (ret)
+		return ret;
+
+	xroot_event_partition(xr, instance, XRT_EVENT_PRE_REMOVAL);
+
+	/* Now tear down all children in this partition. */
+	ret = xrt_subdev_ioctl(pdev, XRT_PARTITION_FINI_CHILDREN, NULL);
+	(void) xroot_put_partition(xr, pdev);
+	if (!ret) {
+		ret = xrt_subdev_pool_del(&xr->parts.pool,
+			XRT_SUBDEV_PART, instance);
+	}
+
+	return ret;
+}
+
+static int xroot_destroy_partition(struct xroot *xr, int instance)
+{
+	struct platform_device *target = NULL;
+	struct platform_device *deps = NULL;
+	int ret;
+
+	BUG_ON(instance < 0);
+	/*
+	 * Make sure target partition exists and can't go away before
+	 * we remove it's dependents
+	 */
+	ret = xroot_get_partition(xr, instance, &target);
+	if (ret)
+		return ret;
+
+	/*
+	 * Remove all partitions depend on target one.
+	 * Assuming subdevs in higher partition ID can depend on ones in
+	 * lower ID partitions, we remove them in the reservse order.
+	 */
+	while (xroot_get_partition(xr, XROOT_PART_LAST, &deps) != -ENOENT) {
+		int inst = deps->id;
+
+		xroot_put_partition(xr, deps);
+		if (instance == inst)
+			break;
+		(void) xroot_destroy_single_partition(xr, inst);
+		deps = NULL;
+	}
+
+	/* Now we can remove the target partition. */
+	xroot_put_partition(xr, target);
+	return xroot_destroy_single_partition(xr, instance);
+}
+
+static int xroot_lookup_partition(struct xroot *xr,
+	struct xrt_parent_ioctl_lookup_partition *arg)
+{
+	int rc = -ENOENT;
+	struct platform_device *part = NULL;
+
+	while (rc < 0 && xroot_get_partition(xr, XROOT_PART_LAST,
+		&part) != -ENOENT) {
+		if (arg->xpilp_match_cb(XRT_SUBDEV_PART, part,
+			arg->xpilp_match_arg)) {
+			rc = part->id;
+		}
+		xroot_put_partition(xr, part);
+	}
+	return rc;
+}
+
+static void xroot_evt_cb_init_work(struct work_struct *work)
+{
+	const struct list_head *ptr, *next;
+	struct xroot_event_cb *tmp;
+	struct platform_device *part = NULL;
+	struct xroot *xr =
+		container_of(work, struct xroot, events.cb_init_work);
+
+	mutex_lock(&xr->events.cb_lock);
+
+	list_for_each_safe(ptr, next, &xr->events.cb_list) {
+		tmp = list_entry(ptr, struct xroot_event_cb, list);
+		if (tmp->initialized)
+			continue;
+
+		while (xroot_get_partition(xr, XROOT_PART_LAST,
+			&part) != -ENOENT) {
+			int rc = xroot_partition_trigger_evt(xr, tmp, part,
+				XRT_EVENT_POST_CREATION);
+
+			(void) xroot_put_partition(xr, part);
+			if (rc & XRT_EVENT_CB_STOP) {
+				list_del(&tmp->list);
+				vfree(tmp);
+				tmp = NULL;
+				break;
+			}
+		}
+
+		if (tmp)
+			tmp->initialized = true;
+	}
+
+	mutex_unlock(&xr->events.cb_lock);
+}
+
+static bool xroot_evt(struct xroot *xr, enum xrt_events evt)
+{
+	const struct list_head *ptr, *next;
+	struct xroot_event_cb *tmp;
+	int rc;
+	bool success = true;
+
+	mutex_lock(&xr->events.cb_lock);
+	list_for_each_safe(ptr, next, &xr->events.cb_list) {
+		tmp = list_entry(ptr, struct xroot_event_cb, list);
+		rc = tmp->cb.xevt_cb(tmp->cb.xevt_pdev, evt, NULL);
+		if (rc & XRT_EVENT_CB_ERR)
+			success = false;
+		if (rc & XRT_EVENT_CB_STOP) {
+			list_del(&tmp->list);
+			vfree(tmp);
+		}
+	}
+	mutex_unlock(&xr->events.cb_lock);
+
+	return success;
+}
+
+static void xroot_evt_async_evt_work(struct work_struct *work)
+{
+	struct xroot_async_evt *tmp;
+	struct xroot *xr =
+		container_of(work, struct xroot, events.async_evt_work);
+	bool success;
+
+	mutex_lock(&xr->events.async_evt_lock);
+	while (!list_empty(&xr->events.async_evt_list)) {
+		tmp = list_first_entry(&xr->events.async_evt_list,
+			struct xroot_async_evt, list);
+		list_del(&tmp->list);
+		mutex_unlock(&xr->events.async_evt_lock);
+
+		success = xroot_evt(xr, tmp->evt.xaevt_event);
+		if (tmp->evt.xaevt_cb) {
+			tmp->evt.xaevt_cb(tmp->evt.xaevt_pdev,
+				tmp->evt.xaevt_event, tmp->evt.xaevt_arg,
+				success);
+		}
+		vfree(tmp);
+
+		mutex_lock(&xr->events.async_evt_lock);
+	}
+	mutex_unlock(&xr->events.async_evt_lock);
+}
+
+static void xroot_evt_init(struct xroot *xr)
+{
+	INIT_LIST_HEAD(&xr->events.cb_list);
+	INIT_LIST_HEAD(&xr->events.async_evt_list);
+	mutex_init(&xr->events.async_evt_lock);
+	mutex_init(&xr->events.cb_lock);
+	INIT_WORK(&xr->events.cb_init_work, xroot_evt_cb_init_work);
+	INIT_WORK(&xr->events.async_evt_work, xroot_evt_async_evt_work);
+}
+
+static void xroot_evt_fini(struct xroot *xr)
+{
+	const struct list_head *ptr, *next;
+	struct xroot_event_cb *tmp;
+
+	flush_scheduled_work();
+
+	BUG_ON(!list_empty(&xr->events.async_evt_list));
+
+	mutex_lock(&xr->events.cb_lock);
+	list_for_each_safe(ptr, next, &xr->events.cb_list) {
+		tmp = list_entry(ptr, struct xroot_event_cb, list);
+		list_del(&tmp->list);
+		vfree(tmp);
+	}
+	mutex_unlock(&xr->events.cb_lock);
+}
+
+static int xroot_evt_cb_add(struct xroot *xr,
+	struct xrt_parent_ioctl_evt_cb *cb)
+{
+	struct xroot_event_cb *new = vzalloc(sizeof(*new));
+
+	if (!new)
+		return -ENOMEM;
+
+	cb->xevt_hdl = new;
+	new->cb = *cb;
+	new->initialized = false;
+
+	mutex_lock(&xr->events.cb_lock);
+	list_add(&new->list, &xr->events.cb_list);
+	mutex_unlock(&xr->events.cb_lock);
+
+	schedule_work(&xr->events.cb_init_work);
+	return 0;
+}
+
+static int xroot_async_evt_add(struct xroot *xr,
+	struct xrt_parent_ioctl_async_broadcast_evt *arg)
+{
+	struct xroot_async_evt *new = vzalloc(sizeof(*new));
+
+	if (!new)
+		return -ENOMEM;
+
+	new->evt = *arg;
+
+	mutex_lock(&xr->events.async_evt_lock);
+	list_add(&new->list, &xr->events.async_evt_list);
+	mutex_unlock(&xr->events.async_evt_lock);
+
+	schedule_work(&xr->events.async_evt_work);
+	return 0;
+}
+
+static void xroot_evt_cb_del(struct xroot *xr, void *hdl)
+{
+	struct xroot_event_cb *cb = (struct xroot_event_cb *)hdl;
+	const struct list_head *ptr;
+	struct xroot_event_cb *tmp;
+
+	mutex_lock(&xr->events.cb_lock);
+	list_for_each(ptr, &xr->events.cb_list) {
+		tmp = list_entry(ptr, struct xroot_event_cb, list);
+		if (tmp == cb)
+			break;
+	}
+	list_del(&cb->list);
+	mutex_unlock(&xr->events.cb_lock);
+	vfree(cb);
+}
+
+static int xroot_get_leaf(struct xroot *xr,
+	struct xrt_parent_ioctl_get_leaf *arg)
+{
+	int rc = -ENOENT;
+	struct platform_device *part = NULL;
+
+	while (rc && xroot_get_partition(xr, XROOT_PART_LAST,
+		&part) != -ENOENT) {
+		rc = xrt_subdev_ioctl(part, XRT_PARTITION_GET_LEAF, arg);
+		xroot_put_partition(xr, part);
+	}
+	return rc;
+}
+
+static int xroot_put_leaf(struct xroot *xr,
+	struct xrt_parent_ioctl_put_leaf *arg)
+{
+	int rc = -ENOENT;
+	struct platform_device *part = NULL;
+
+	while (rc && xroot_get_partition(xr, XROOT_PART_LAST,
+		&part) != -ENOENT) {
+		rc = xrt_subdev_ioctl(part, XRT_PARTITION_PUT_LEAF, arg);
+		xroot_put_partition(xr, part);
+	}
+	return rc;
+}
+
+static int xroot_parent_cb(struct device *dev, void *parg, u32 cmd, void *arg)
+{
+	struct xroot *xr = (struct xroot *)parg;
+	int rc = 0;
+
+	switch (cmd) {
+	/* Leaf actions. */
+	case XRT_PARENT_GET_LEAF: {
+		struct xrt_parent_ioctl_get_leaf *getleaf =
+			(struct xrt_parent_ioctl_get_leaf *)arg;
+		rc = xroot_get_leaf(xr, getleaf);
+		break;
+	}
+	case XRT_PARENT_PUT_LEAF: {
+		struct xrt_parent_ioctl_put_leaf *putleaf =
+			(struct xrt_parent_ioctl_put_leaf *)arg;
+		rc = xroot_put_leaf(xr, putleaf);
+		break;
+	}
+	case XRT_PARENT_GET_LEAF_HOLDERS: {
+		struct xrt_parent_ioctl_get_holders *holders =
+			(struct xrt_parent_ioctl_get_holders *)arg;
+		rc = xrt_subdev_pool_get_holders(&xr->parts.pool,
+			holders->xpigh_pdev, holders->xpigh_holder_buf,
+			holders->xpigh_holder_buf_len);
+		break;
+	}
+
+
+	/* Partition actions. */
+	case XRT_PARENT_CREATE_PARTITION:
+		rc = xroot_create_partition(xr, (char *)arg);
+		break;
+	case XRT_PARENT_REMOVE_PARTITION:
+		rc = xroot_destroy_partition(xr, (int)(uintptr_t)arg);
+		break;
+	case XRT_PARENT_LOOKUP_PARTITION: {
+		struct xrt_parent_ioctl_lookup_partition *getpart =
+			(struct xrt_parent_ioctl_lookup_partition *)arg;
+		rc = xroot_lookup_partition(xr, getpart);
+		break;
+	}
+	case XRT_PARENT_WAIT_PARTITION_BRINGUP:
+		rc = xroot_wait_for_bringup(xr) ? 0 : -EINVAL;
+		break;
+
+
+	/* Event actions. */
+	case XRT_PARENT_ADD_EVENT_CB: {
+		struct xrt_parent_ioctl_evt_cb *cb =
+			(struct xrt_parent_ioctl_evt_cb *)arg;
+		rc = xroot_evt_cb_add(xr, cb);
+		break;
+	}
+	case XRT_PARENT_REMOVE_EVENT_CB:
+		xroot_evt_cb_del(xr, arg);
+		rc = 0;
+		break;
+	case XRT_PARENT_ASYNC_BOARDCAST_EVENT:
+		rc = xroot_async_evt_add(xr,
+			(struct xrt_parent_ioctl_async_broadcast_evt *)arg);
+		break;
+
+
+	/* Device info. */
+	case XRT_PARENT_GET_RESOURCE: {
+		struct xrt_parent_ioctl_get_res *res =
+			(struct xrt_parent_ioctl_get_res *)arg;
+		res->xpigr_res = xr->pdev->resource;
+		break;
+	}
+	case XRT_PARENT_GET_ID: {
+		struct xrt_parent_ioctl_get_id *id =
+			(struct xrt_parent_ioctl_get_id *)arg;
+
+		id->xpigi_vendor_id = xr->pdev->vendor;
+		id->xpigi_device_id = xr->pdev->device;
+		id->xpigi_sub_vendor_id = xr->pdev->subsystem_vendor;
+		id->xpigi_sub_device_id = xr->pdev->subsystem_device;
+		break;
+	}
+
+
+	case XRT_PARENT_HOT_RESET: {
+		xroot_hot_reset(xr->pdev);
+		break;
+	}
+
+	case XRT_PARENT_HWMON: {
+		struct xrt_parent_ioctl_hwmon *hwmon =
+			(struct xrt_parent_ioctl_hwmon *)arg;
+
+		if (hwmon->xpih_register) {
+			hwmon->xpih_hwmon_dev =
+				hwmon_device_register_with_info(DEV(xr->pdev),
+				hwmon->xpih_name, hwmon->xpih_drvdata, NULL,
+				hwmon->xpih_groups);
+		} else {
+			(void) hwmon_device_unregister(hwmon->xpih_hwmon_dev);
+		}
+		break;
+	}
+
+	default:
+		xroot_err(xr, "unknown IOCTL cmd %d", cmd);
+		rc = -EINVAL;
+		break;
+	}
+
+	return rc;
+}
+
+static void xroot_bringup_partition_work(struct work_struct *work)
+{
+	struct platform_device *pdev = NULL;
+	struct xroot *xr = container_of(work, struct xroot, parts.bringup_work);
+
+	while (xroot_get_partition(xr, XROOT_PART_LAST, &pdev) != -ENOENT) {
+		int r, i;
+
+		i = pdev->id;
+		r = xrt_subdev_ioctl(pdev, XRT_PARTITION_INIT_CHILDREN, NULL);
+		(void) xroot_put_partition(xr, pdev);
+		if (r == -EEXIST)
+			continue; /* Already brough up, nothing to do. */
+		if (r)
+			atomic_inc(&xr->parts.bringup_failed);
+
+		xroot_event_partition(xr, i, XRT_EVENT_POST_CREATION);
+
+		if (atomic_dec_and_test(&xr->parts.bringup_pending))
+			complete(&xr->parts.bringup_comp);
+	}
+}
+
+static void xroot_parts_init(struct xroot *xr)
+{
+	xrt_subdev_pool_init(DEV(xr->pdev), &xr->parts.pool);
+	INIT_WORK(&xr->parts.bringup_work, xroot_bringup_partition_work);
+	atomic_set(&xr->parts.bringup_pending, 0);
+	atomic_set(&xr->parts.bringup_failed, 0);
+	init_completion(&xr->parts.bringup_comp);
+}
+
+static void xroot_parts_fini(struct xroot *xr)
+{
+	flush_scheduled_work();
+	(void) xrt_subdev_pool_fini(&xr->parts.pool);
+}
+
+int xroot_add_vsec_node(void *root, char *dtb)
+{
+	struct xroot *xr = (struct xroot *)root;
+	struct device *dev = DEV(xr->pdev);
+	struct xrt_md_endpoint ep = { 0 };
+	int cap = 0, ret = 0;
+	u32 off_low, off_high, vsec_bar, header;
+	u64 vsec_off;
+
+	while ((cap = pci_find_next_ext_capability(xr->pdev, cap,
+	    PCI_EXT_CAP_ID_VNDR))) {
+		pci_read_config_dword(xr->pdev, cap + PCI_VNDR_HEADER, &header);
+		if (PCI_VNDR_HEADER_ID(header) == XRT_VSEC_ID)
+			break;
+	}
+	if (!cap) {
+		xroot_info(xr, "No Vendor Specific Capability.");
+		return -ENOENT;
+	}
+
+	if (pci_read_config_dword(xr->pdev, cap+8, &off_low) ||
+	    pci_read_config_dword(xr->pdev, cap+12, &off_high)) {
+		xroot_err(xr, "pci_read vendor specific failed.");
+		return -EINVAL;
+	}
+
+	ep.ep_name = NODE_VSEC;
+	ret = xrt_md_add_endpoint(dev, dtb, &ep);
+	if (ret) {
+		xroot_err(xr, "add vsec metadata failed, ret %d", ret);
+		goto failed;
+	}
+
+	vsec_bar = cpu_to_be32(off_low & 0xf);
+	ret = xrt_md_set_prop(dev, dtb, NODE_VSEC,
+		NULL, PROP_BAR_IDX, &vsec_bar, sizeof(vsec_bar));
+	if (ret) {
+		xroot_err(xr, "add vsec bar idx failed, ret %d", ret);
+		goto failed;
+	}
+
+	vsec_off = cpu_to_be64(((u64)off_high << 32) | (off_low & ~0xfU));
+	ret = xrt_md_set_prop(dev, dtb, NODE_VSEC,
+		NULL, PROP_OFFSET, &vsec_off, sizeof(vsec_off));
+	if (ret) {
+		xroot_err(xr, "add vsec offset failed, ret %d", ret);
+		goto failed;
+	}
+
+failed:
+	return ret;
+}
+
+int xroot_add_simple_node(void *root, char *dtb, const char *endpoint)
+{
+	struct xroot *xr = (struct xroot *)root;
+	struct device *dev = DEV(xr->pdev);
+	struct xrt_md_endpoint ep = { 0 };
+	int ret = 0;
+
+	ep.ep_name = endpoint;
+	ret = xrt_md_add_endpoint(dev, dtb, &ep);
+	if (ret)
+		xroot_err(xr, "add %s failed, ret %d", endpoint, ret);
+
+	return ret;
+}
+
+bool xroot_wait_for_bringup(void *root)
+{
+	struct xroot *xr = (struct xroot *)root;
+
+	wait_for_completion(&xr->parts.bringup_comp);
+	return atomic_xchg(&xr->parts.bringup_failed, 0) == 0;
+}
+
+int xroot_probe(struct pci_dev *pdev, void **root)
+{
+	struct device *dev = DEV(pdev);
+	struct xroot *xr = NULL;
+
+	dev_info(dev, "%s: probing...", __func__);
+
+	xr = devm_kzalloc(dev, sizeof(*xr), GFP_KERNEL);
+	if (!xr)
+		return -ENOMEM;
+
+	xr->pdev = pdev;
+	xroot_parts_init(xr);
+	xroot_evt_init(xr);
+
+	*root = xr;
+	return 0;
+}
+
+void xroot_remove(void *root)
+{
+	struct xroot *xr = (struct xroot *)root;
+	struct platform_device *part = NULL;
+
+	xroot_info(xr, "leaving...");
+
+	if (xroot_get_partition(xr, XROOT_PART_FIRST, &part) == 0) {
+		int instance = part->id;
+
+		xroot_put_partition(xr, part);
+		(void) xroot_destroy_partition(xr, instance);
+	}
+
+	xroot_evt_fini(xr);
+	xroot_parts_fini(xr);
+}
+
+static void xroot_broadcast_event_cb(struct platform_device *pdev,
+	enum xrt_events evt, void *arg, bool success)
+{
+	struct completion *comp = (struct completion *)arg;
+
+	complete(comp);
+}
+
+void xroot_broadcast(void *root, enum xrt_events evt)
+{
+	int rc;
+	struct completion comp;
+	struct xroot *xr = (struct xroot *)root;
+	struct xrt_parent_ioctl_async_broadcast_evt e = {
+		NULL, evt, xroot_broadcast_event_cb, &comp
+	};
+
+	init_completion(&comp);
+	rc = xroot_async_evt_add(xr, &e);
+	if (rc == 0)
+		wait_for_completion(&comp);
+	else
+		xroot_err(xr, "can't broadcast event (%d): %d", evt, rc);
+}
diff --git a/drivers/fpga/alveo/common/xrt-root.h b/drivers/fpga/alveo/common/xrt-root.h
new file mode 100644
index 000000000000..e2a1c4554feb
--- /dev/null
+++ b/drivers/fpga/alveo/common/xrt-root.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020 Xilinx, Inc.
+ *
+ * Authors:
+ *	Cheng Zhen <maxz@xilinx.com>
+ */
+
+#ifndef	_XRT_ROOT_H_
+#define	_XRT_ROOT_H_
+
+#include <linux/pci.h>
+#include "xrt-subdev.h"
+
+int xroot_probe(struct pci_dev *pdev, void **root);
+void xroot_remove(void *root);
+bool xroot_wait_for_bringup(void *root);
+int xroot_add_vsec_node(void *root, char *dtb);
+int xroot_create_partition(void *root, char *dtb);
+int xroot_add_simple_node(void *root, char *dtb, const char *endpoint);
+void xroot_hot_reset(struct pci_dev *pdev);
+void xroot_broadcast(void *root, enum xrt_events evt);
+
+#endif	/* _XRT_ROOT_H_ */
diff --git a/drivers/fpga/alveo/common/xrt-xclbin.c b/drivers/fpga/alveo/common/xrt-xclbin.c
new file mode 100644
index 000000000000..b7db1b52a086
--- /dev/null
+++ b/drivers/fpga/alveo/common/xrt-xclbin.c
@@ -0,0 +1,387 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx Kernel Driver XCLBIN parser
+ *
+ * Copyright (C) 2020 Xilinx, Inc.
+ *
+ * Authors: David Zhang <davidzha@xilinx.com>
+ */
+
+#include <asm/errno.h>
+#include <linux/vmalloc.h>
+#include <linux/device.h>
+#include "xrt-xclbin.h"
+#include "xrt-metadata.h"
+
+/* Used for parsing bitstream header */
+#define XHI_EVEN_MAGIC_BYTE     0x0f
+#define XHI_ODD_MAGIC_BYTE      0xf0
+
+/* Extra mode for IDLE */
+#define XHI_OP_IDLE  -1
+#define XHI_BIT_HEADER_FAILURE -1
+
+/* The imaginary module length register */
+#define XHI_MLR                  15
+
+const char *xrt_xclbin_kind_to_string(enum axlf_section_kind kind)
+{
+	switch (kind) {
+	case BITSTREAM:			return "BITSTREAM";
+	case CLEARING_BITSTREAM:	return "CLEARING_BITSTREAM";
+	case EMBEDDED_METADATA:		return "EMBEDDED_METADATA";
+	case FIRMWARE:			return "FIRMWARE";
+	case DEBUG_DATA:		return "DEBUG_DATA";
+	case SCHED_FIRMWARE:		return "SCHED_FIRMWARE";
+	case MEM_TOPOLOGY:		return "MEM_TOPOLOGY";
+	case CONNECTIVITY:		return "CONNECTIVITY";
+	case IP_LAYOUT:			return "IP_LAYOUT";
+	case DEBUG_IP_LAYOUT:		return "DEBUG_IP_LAYOUT";
+	case DESIGN_CHECK_POINT:	return "DESIGN_CHECK_POINT";
+	case CLOCK_FREQ_TOPOLOGY:	return "CLOCK_FREQ_TOPOLOGY";
+	case MCS:			return "MCS";
+	case BMC:			return "BMC";
+	case BUILD_METADATA:		return "BUILD_METADATA";
+	case KEYVALUE_METADATA:		return "KEYVALUE_METADATA";
+	case USER_METADATA:		return "USER_METADATA";
+	case DNA_CERTIFICATE:		return "DNA_CERTIFICATE";
+	case PDI:			return "PDI";
+	case BITSTREAM_PARTIAL_PDI:	return "BITSTREAM_PARTIAL_PDI";
+	case PARTITION_METADATA:	return "PARTITION_METADATA";
+	case EMULATION_DATA:		return "EMULATION_DATA";
+	case SYSTEM_METADATA:		return "SYSTEM_METADATA";
+	case SOFT_KERNEL:		return "SOFT_KERNEL";
+	case ASK_FLASH:			return "ASK_FLASH";
+	case AIE_METADATA:		return "AIE_METADATA";
+	case ASK_GROUP_TOPOLOGY:	return "ASK_GROUP_TOPOLOGY";
+	case ASK_GROUP_CONNECTIVITY:	return "ASK_GROUP_CONNECTIVITY";
+	default:			return "UNKNOWN";
+	}
+}
+
+static const struct axlf_section_header *
+xrt_xclbin_get_section_hdr(const struct axlf *xclbin,
+	enum axlf_section_kind kind)
+{
+	int i = 0;
+
+	for (i = 0; i < xclbin->m_header.m_numSections; i++) {
+		if (xclbin->m_sections[i].m_sectionKind == kind)
+			return &xclbin->m_sections[i];
+	}
+
+	return NULL;
+}
+
+static int
+xrt_xclbin_check_section_hdr(const struct axlf_section_header *header,
+	uint64_t xclbin_len)
+{
+	return (header->m_sectionOffset + header->m_sectionSize) > xclbin_len ?
+		-EINVAL : 0;
+}
+
+static int xrt_xclbin_section_info(const struct axlf *xclbin,
+	enum axlf_section_kind kind,
+	uint64_t *offset, uint64_t *size)
+{
+	const struct axlf_section_header *memHeader = NULL;
+	uint64_t xclbin_len;
+	int err = 0;
+
+	memHeader = xrt_xclbin_get_section_hdr(xclbin, kind);
+	if (!memHeader)
+		return -EINVAL;
+
+	xclbin_len = xclbin->m_header.m_length;
+	err = xrt_xclbin_check_section_hdr(memHeader, xclbin_len);
+	if (err)
+		return err;
+
+	*offset = memHeader->m_sectionOffset;
+	*size = memHeader->m_sectionSize;
+
+	return 0;
+}
+
+/* caller should free the allocated memory for **data */
+int xrt_xclbin_get_section(const char *buf,
+	enum axlf_section_kind kind, void **data, uint64_t *len)
+{
+	const struct axlf *xclbin = (const struct axlf *)buf;
+	void *section = NULL;
+	int err = 0;
+	uint64_t offset = 0;
+	uint64_t size = 0;
+
+	err = xrt_xclbin_section_info(xclbin, kind, &offset, &size);
+	if (err)
+		return err;
+
+	section = vmalloc(size);
+	if (section == NULL)
+		return -ENOMEM;
+
+	memcpy(section, ((const char *)xclbin) + offset, size);
+
+	*data = section;
+	if (len)
+		*len = size;
+
+	return 0;
+}
+
+/* parse bitstream header */
+int xrt_xclbin_parse_header(const unsigned char *data,
+	unsigned int size, struct XHwIcap_Bit_Header *header)
+{
+	unsigned int i;
+	unsigned int len;
+	unsigned int tmp;
+	unsigned int index;
+
+	/* Start Index at start of bitstream */
+	index = 0;
+
+	/* Initialize HeaderLength.  If header returned early inidicates
+	 * failure.
+	 */
+	header->HeaderLength = XHI_BIT_HEADER_FAILURE;
+
+	/* Get "Magic" length */
+	header->MagicLength = data[index++];
+	header->MagicLength = (header->MagicLength << 8) | data[index++];
+
+	/* Read in "magic" */
+	for (i = 0; i < header->MagicLength - 1; i++) {
+		tmp = data[index++];
+		if (i % 2 == 0 && tmp != XHI_EVEN_MAGIC_BYTE)
+			return -1;	/* INVALID_FILE_HEADER_ERROR */
+
+		if (i % 2 == 1 && tmp != XHI_ODD_MAGIC_BYTE)
+			return -1;	/* INVALID_FILE_HEADER_ERROR */
+	}
+
+	/* Read null end of magic data. */
+	tmp = data[index++];
+
+	/* Read 0x01 (short) */
+	tmp = data[index++];
+	tmp = (tmp << 8) | data[index++];
+
+	/* Check the "0x01" half word */
+	if (tmp != 0x01)
+		return -1;	/* INVALID_FILE_HEADER_ERROR */
+
+	/* Read 'a' */
+	tmp = data[index++];
+	if (tmp != 'a')
+		return -1;	/* INVALID_FILE_HEADER_ERROR	*/
+
+	/* Get Design Name length */
+	len = data[index++];
+	len = (len << 8) | data[index++];
+
+	/* allocate space for design name and final null character. */
+	header->DesignName = vmalloc(len);
+
+	/* Read in Design Name */
+	for (i = 0; i < len; i++)
+		header->DesignName[i] = data[index++];
+
+	if (header->DesignName[len-1] != '\0')
+		return -1;
+
+	/* Read 'b' */
+	tmp = data[index++];
+	if (tmp != 'b')
+		return -1;	/* INVALID_FILE_HEADER_ERROR */
+
+	/* Get Part Name length */
+	len = data[index++];
+	len = (len << 8) | data[index++];
+
+	/* allocate space for part name and final null character. */
+	header->PartName = vmalloc(len);
+
+	/* Read in part name */
+	for (i = 0; i < len; i++)
+		header->PartName[i] = data[index++];
+
+	if (header->PartName[len-1] != '\0')
+		return -1;
+
+	/* Read 'c' */
+	tmp = data[index++];
+	if (tmp != 'c')
+		return -1;	/* INVALID_FILE_HEADER_ERROR */
+
+	/* Get date length */
+	len = data[index++];
+	len = (len << 8) | data[index++];
+
+	/* allocate space for date and final null character. */
+	header->Date = vmalloc(len);
+
+	/* Read in date name */
+	for (i = 0; i < len; i++)
+		header->Date[i] = data[index++];
+
+	if (header->Date[len - 1] != '\0')
+		return -1;
+
+	/* Read 'd' */
+	tmp = data[index++];
+	if (tmp != 'd')
+		return -1;	/* INVALID_FILE_HEADER_ERROR  */
+
+	/* Get time length */
+	len = data[index++];
+	len = (len << 8) | data[index++];
+
+	/* allocate space for time and final null character. */
+	header->Time = vmalloc(len);
+
+	/* Read in time name */
+	for (i = 0; i < len; i++)
+		header->Time[i] = data[index++];
+
+	if (header->Time[len - 1] != '\0')
+		return -1;
+
+	/* Read 'e' */
+	tmp = data[index++];
+	if (tmp != 'e')
+		return -1;	/* INVALID_FILE_HEADER_ERROR */
+
+	/* Get byte length of bitstream */
+	header->BitstreamLength = data[index++];
+	header->BitstreamLength = (header->BitstreamLength << 8) | data[index++];
+	header->BitstreamLength = (header->BitstreamLength << 8) | data[index++];
+	header->BitstreamLength = (header->BitstreamLength << 8) | data[index++];
+	header->HeaderLength = index;
+
+	return 0;
+}
+
+void xrt_xclbin_free_header(struct XHwIcap_Bit_Header *header)
+{
+	vfree(header->DesignName);
+	vfree(header->PartName);
+	vfree(header->Date);
+	vfree(header->Time);
+}
+
+struct xrt_clock_desc {
+	char	*clock_ep_name;
+	u32	clock_xclbin_type;
+	char	*clkfreq_ep_name;
+} clock_desc[] = {
+	{
+		.clock_ep_name = NODE_CLK_KERNEL1,
+		.clock_xclbin_type = CT_DATA,
+		.clkfreq_ep_name = NODE_CLKFREQ_K1,
+	},
+	{
+		.clock_ep_name = NODE_CLK_KERNEL2,
+		.clock_xclbin_type = CT_KERNEL,
+		.clkfreq_ep_name = NODE_CLKFREQ_K2,
+	},
+	{
+		.clock_ep_name = NODE_CLK_KERNEL3,
+		.clock_xclbin_type = CT_SYSTEM,
+		.clkfreq_ep_name = NODE_CLKFREQ_HBM,
+	},
+};
+
+const char *clock_type2epname(enum CLOCK_TYPE type)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(clock_desc); i++) {
+		if (clock_desc[i].clock_xclbin_type == type)
+			return clock_desc[i].clock_ep_name;
+	}
+	return NULL;
+}
+
+static const char *clock_type2clkfreq_name(u32 type)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(clock_desc); i++) {
+		if (clock_desc[i].clock_xclbin_type == type)
+			return clock_desc[i].clkfreq_ep_name;
+	}
+	return NULL;
+}
+
+static int xrt_xclbin_add_clock_metadata(struct device *dev,
+	const char *xclbin, char *dtb)
+{
+	int i;
+	u16 freq;
+	struct clock_freq_topology *clock_topo;
+	int rc = xrt_xclbin_get_section(xclbin,
+		CLOCK_FREQ_TOPOLOGY, (void **)&clock_topo, NULL);
+
+	if (rc)
+		return 0;
+
+	for (i = 0; i < clock_topo->m_count; i++) {
+		u8 type = clock_topo->m_clock_freq[i].m_type;
+		const char *ep_name = clock_type2epname(type);
+		const char *counter_name = clock_type2clkfreq_name(type);
+
+		if (!ep_name || !counter_name)
+			continue;
+
+		freq = cpu_to_be16(clock_topo->m_clock_freq[i].m_freq_Mhz);
+		rc = xrt_md_set_prop(dev, dtb, ep_name,
+			NULL, PROP_CLK_FREQ, &freq, sizeof(freq));
+		if (rc)
+			break;
+
+		rc = xrt_md_set_prop(dev, dtb, ep_name,
+			NULL, PROP_CLK_CNT, counter_name, strlen(counter_name) + 1);
+		if (rc)
+			break;
+	}
+
+	vfree(clock_topo);
+
+	return rc;
+}
+
+int xrt_xclbin_get_metadata(struct device *dev, const char *xclbin, char **dtb)
+{
+	char *md = NULL, *newmd = NULL;
+	u64 len;
+	int rc = xrt_xclbin_get_section(xclbin, PARTITION_METADATA,
+		(void **)&md, &len);
+
+	if (rc)
+		goto done;
+
+	/* Sanity check the dtb section. */
+	if (xrt_md_size(dev, md) > len) {
+		rc = -EINVAL;
+		goto done;
+	}
+
+	newmd = xrt_md_dup(dev, md);
+	if (!newmd) {
+		rc = -EFAULT;
+		goto done;
+	}
+	/* Convert various needed xclbin sections into dtb. */
+	rc = xrt_xclbin_add_clock_metadata(dev, xclbin, newmd);
+
+done:
+	if (rc == 0)
+		*dtb = newmd;
+	else
+		vfree(newmd);
+	vfree(md);
+	return rc;
+}
diff --git a/drivers/fpga/alveo/common/xrt-xclbin.h b/drivers/fpga/alveo/common/xrt-xclbin.h
new file mode 100644
index 000000000000..05214d824790
--- /dev/null
+++ b/drivers/fpga/alveo/common/xrt-xclbin.h
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx Kernel Driver XCLBIN parser
+ *
+ * Copyright (C) 2020 Xilinx, Inc.
+ *
+ * Authors: David Zhang <davidzha@xilinx.com>
+ */
+
+#ifndef _XRT_XCLBIN_H
+#define _XRT_XCLBIN_H
+
+#include <linux/types.h>
+#include <linux/device.h>
+#include <linux/xrt/xclbin.h>
+
+#define	ICAP_XCLBIN_V2	"xclbin2"
+#define DMA_HWICAP_BITFILE_BUFFER_SIZE 1024
+#define MAX_XCLBIN_SIZE (1024 * 1024 * 1024) /* Assuming xclbin <= 1G, always */
+
+enum axlf_section_kind;
+struct axlf;
+
+/**
+ * Bitstream header information.
+ */
+struct XHwIcap_Bit_Header {
+	unsigned int HeaderLength;     /* Length of header in 32 bit words */
+	unsigned int BitstreamLength;  /* Length of bitstream to read in bytes*/
+	unsigned char *DesignName;     /* Design name get from bitstream */
+	unsigned char *PartName;       /* Part name read from bitstream */
+	unsigned char *Date;           /* Date read from bitstream header */
+	unsigned char *Time;           /* Bitstream creation time*/
+	unsigned int MagicLength;      /* Length of the magic numbers*/
+};
+
+const char *xrt_xclbin_kind_to_string(enum axlf_section_kind kind);
+int xrt_xclbin_get_section(const char *xclbin,
+	enum axlf_section_kind kind, void **data, uint64_t *len);
+int xrt_xclbin_get_metadata(struct device *dev, const char *xclbin, char **dtb);
+int xrt_xclbin_parse_header(const unsigned char *data,
+	unsigned int size, struct XHwIcap_Bit_Header *header);
+void xrt_xclbin_free_header(struct XHwIcap_Bit_Header *header);
+const char *clock_type2epname(enum CLOCK_TYPE type);
+
+#endif /* _XRT_XCLBIN_H */
-- 
2.17.1


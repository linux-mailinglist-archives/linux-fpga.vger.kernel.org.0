Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70D4836CD88
	for <lists+linux-fpga@lfdr.de>; Tue, 27 Apr 2021 23:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239282AbhD0VBi (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 27 Apr 2021 17:01:38 -0400
Received: from mail-mw2nam10on2054.outbound.protection.outlook.com ([40.107.94.54]:25121
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239223AbhD0VBe (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 27 Apr 2021 17:01:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DaRo9fjWs5+/1JA7IZf8u7KQoKSWkkxy60dsrkzPthUWpj4Qh3ivnirkbnqoNZG/tlWlBFAZwn1ayCkJM8kh1EMFaqYKhzGH0j9SuF9hFRmCFSwcCdG1NcO3vW5udiKy5bkM40rEDHI/MTYF9H/s1+REIyd5LtdaznIWUzcsCL9142jt0t3CL5zIlDEeYQwJf6EEApKtzqkQj1RSMpXVLsyXWLCwC9lZhvaxgG6Rppas3eJ1s6X5td/JQCt++XYN9QdJCiHML53FPZBOj1OM3aluWvh2Cnhuhl5N7qqbqqBSBJr0GboxABGbYffUDLobgaqeI618RTqyBa1e2rcmKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CE9kHuQjnlH49TIMI/rIc9MtQAjvu20zrjZnRuyuGHM=;
 b=C5oK+y0PMF3UUfpVbGukr+LYHc+gpJC72vCJh+6g5pv2Z//zg0bB/Mrv4ianUQkn73e4COSZAiYMZcw2VDSHTIYvP4xSV+8P/OdfEJMNllKNboptzGONsowKX5YwwrzKDnCebjIV94IdXeP6bhKdszWpm0WfW7jSdC6SBosITlCM4rxXhEvZbM9xsmYgtM811hCO2BtSHBD/JsmuxA7iWyqJauQqBfRRwgBJOYH1/NkCGcQx6T2BpXYaxrE1g4QHn5S2Mzz9Ztp/+O4fBJJFX2/c+EU9/2bLVmC6aRmbtWASz3y0e8sbofTHB4CIS8A8x1KlB1F08Q9bFxRt6QsBKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CE9kHuQjnlH49TIMI/rIc9MtQAjvu20zrjZnRuyuGHM=;
 b=arUOvJJ66iBRTlzS398eUH9LRSftHk+cj8ZiZpjsBgdnn+7zhdzb8pkmz0LbUTmAiDDBxPgNqVhU//N6v8s+waaq9BkOcPhVU9n0T18KDgryL39t5xGkn3o7RzsDTG1WEGOb5Uy8zpdn/DcoVLJ+46FunaP/S5qdVeOZsqWGEnw=
Received: from CY4PR13CA0084.namprd13.prod.outlook.com (2603:10b6:903:152::22)
 by PH0PR02MB7381.namprd02.prod.outlook.com (2603:10b6:510:1e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Tue, 27 Apr
 2021 21:00:48 +0000
Received: from CY1NAM02FT062.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:152:cafe::41) by CY4PR13CA0084.outlook.office365.com
 (2603:10b6:903:152::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.18 via Frontend
 Transport; Tue, 27 Apr 2021 21:00:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 CY1NAM02FT062.mail.protection.outlook.com (10.152.75.60) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4065.21 via Frontend Transport; Tue, 27 Apr 2021 21:00:48 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 27 Apr 2021 14:00:03 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Tue, 27 Apr 2021 14:00:03 -0700
Envelope-to: mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.72.212] (port=52018 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1lbUoM-0008Gg-3k; Tue, 27 Apr 2021 14:00:02 -0700
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id 1079E60012E; Tue, 27 Apr 2021 13:54:36 -0700 (PDT)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>, Max Zhen <max.zhen@xilinx.com>
Subject: [PATCH V5 XRT Alveo 11/20] fpga: xrt: fpga-mgr and region implementation for xclbin download
Date:   Tue, 27 Apr 2021 13:54:22 -0700
Message-ID: <20210427205431.23896-12-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210427205431.23896-1-lizhi.hou@xilinx.com>
References: <20210427205431.23896-1-lizhi.hou@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 82d05f93-363a-4575-fe00-08d909bf8862
X-MS-TrafficTypeDiagnostic: PH0PR02MB7381:
X-Microsoft-Antispam-PRVS: <PH0PR02MB738115ECCD8F161693A576F5A1419@PH0PR02MB7381.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:608;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gI3UPCzUDy4kSo9NAUV/BwXWqyMFhdxf1iPIWHtvj7uQOVaYvMMvMmCdNqFgymHjjKs2bYeaSfMp1QnkfmFLn2vP0YkUFRU8iZuscjL1/jwshbDc3zhYT5psOY1+9AXjHHR61cvbtAr6JjuNxeMsEbnF/6OvPi7yD5m5mK94YFSG8Nk40YeBIPM+yr7TA8S0Lw6h1IRDwNv3Hc5hhT1FdgmkFuRU/DA55sYPQQraDCJKsKaZP9JG3tmhBp0P3KF5kZCq1H+vxFjcW0IHvf4NkOAZzwz3z2vPm1ddjfqU/yHqvhnSdg8z6UFdZdzXBPQAyITz+0aq883CyF6/V8Fs9tvUOeMK+4h0QrY2ooraw5o82OHkD7GmCySIrx/MEtReNgbHycExDsVm+EvAQ2clhC1rX7RJSaSf01dPG5dNECQU2W1UksTffGwJf2k5NTpallXI6ud6HclUYkB8THCMbKEmRV75G2EV2ip7Oii61Hyf6A9DGZvqhpBE5CllKypyJWfSY8f/889H1ZiuDWCw8ESheB1QQuJgMg1I+8GnkanSSTMobcO6vhHUEL6doYT4SAC61JFq7gmAgMQwKY9vjVeraXnaO6FpmHyf5h4Spgu66y9AOBSNTIWH/ngwXeO3EfIbbGJrkKGSEdQA7ZDYW8246p2CvyJCJxhHJ2Naw/g=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(136003)(376002)(396003)(39850400004)(346002)(36840700001)(46966006)(82310400003)(54906003)(7636003)(36906005)(30864003)(2906002)(82740400003)(1076003)(6666004)(2616005)(316002)(44832011)(478600001)(6266002)(36860700001)(107886003)(4326008)(5660300002)(186003)(336012)(47076005)(42186006)(26005)(426003)(83380400001)(70206006)(70586007)(8936002)(6916009)(8676002)(36756003)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2021 21:00:48.0608
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82d05f93-363a-4575-fe00-08d909bf8862
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT062.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7381
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

fpga-mgr and region implementation for xclbin download which will be
called from main xrt driver

Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
Signed-off-by: Max Zhen <max.zhen@xilinx.com>
Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
---
 drivers/fpga/xrt/mgnt/xmgnt-main-region.c | 485 ++++++++++++++++++++++
 drivers/fpga/xrt/mgnt/xrt-mgr.c           | 190 +++++++++
 drivers/fpga/xrt/mgnt/xrt-mgr.h           |  16 +
 3 files changed, 691 insertions(+)
 create mode 100644 drivers/fpga/xrt/mgnt/xmgnt-main-region.c
 create mode 100644 drivers/fpga/xrt/mgnt/xrt-mgr.c
 create mode 100644 drivers/fpga/xrt/mgnt/xrt-mgr.h

diff --git a/drivers/fpga/xrt/mgnt/xmgnt-main-region.c b/drivers/fpga/xrt/mgnt/xmgnt-main-region.c
new file mode 100644
index 000000000000..398fc816b178
--- /dev/null
+++ b/drivers/fpga/xrt/mgnt/xmgnt-main-region.c
@@ -0,0 +1,485 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * FPGA Region Support for Xilinx Alveo
+ *
+ * Copyright (C) 2020-2021 Xilinx, Inc.
+ *
+ * Authors: Lizhi.Hou@xilinx.com
+ */
+
+#include <linux/uuid.h>
+#include <linux/fpga/fpga-bridge.h>
+#include <linux/fpga/fpga-region.h>
+#include <linux/slab.h>
+#include "metadata.h"
+#include "xleaf.h"
+#include "xleaf/axigate.h"
+#include "xclbin-helper.h"
+#include "xmgnt.h"
+
+struct xmgnt_bridge {
+	struct xrt_device *xdev;
+	const char *bridge_name;
+};
+
+struct xmgnt_region {
+	struct xrt_device *xdev;
+	struct fpga_region *region;
+	struct fpga_compat_id compat_id;
+	uuid_t interface_uuid;
+	struct fpga_bridge *bridge;
+	int group_instance;
+	uuid_t depend_uuid;
+	struct list_head list;
+};
+
+struct xmgnt_region_match_arg {
+	struct xrt_device *xdev;
+	uuid_t *uuids;
+	u32 uuid_num;
+};
+
+static int xmgnt_br_enable_set(struct fpga_bridge *bridge, bool enable)
+{
+	struct xmgnt_bridge *br_data = (struct xmgnt_bridge *)bridge->priv;
+	struct xrt_device *axigate_leaf;
+	int rc;
+
+	axigate_leaf = xleaf_get_leaf_by_epname(br_data->xdev, br_data->bridge_name);
+	if (!axigate_leaf) {
+		xrt_err(br_data->xdev, "failed to get leaf %s",
+			br_data->bridge_name);
+		return -ENOENT;
+	}
+
+	if (enable)
+		rc = xleaf_call(axigate_leaf, XRT_AXIGATE_OPEN, NULL);
+	else
+		rc = xleaf_call(axigate_leaf, XRT_AXIGATE_CLOSE, NULL);
+
+	if (rc) {
+		xrt_err(br_data->xdev, "failed to %s gate %s, rc %d",
+			(enable ? "free" : "freeze"), br_data->bridge_name,
+			rc);
+	}
+
+	xleaf_put_leaf(br_data->xdev, axigate_leaf);
+
+	return rc;
+}
+
+const struct fpga_bridge_ops xmgnt_bridge_ops = {
+	.enable_set = xmgnt_br_enable_set
+};
+
+static void xmgnt_destroy_bridge(struct fpga_bridge *br)
+{
+	struct xmgnt_bridge *br_data = br->priv;
+
+	if (!br_data)
+		return;
+
+	xrt_info(br_data->xdev, "destroy fpga bridge %s", br_data->bridge_name);
+	fpga_bridge_unregister(br);
+
+	devm_kfree(DEV(br_data->xdev), br_data);
+
+	fpga_bridge_free(br);
+}
+
+static struct fpga_bridge *xmgnt_create_bridge(struct xrt_device *xdev,
+					       char *dtb)
+{
+	struct fpga_bridge *br = NULL;
+	struct xmgnt_bridge *br_data;
+	const char *gate;
+	int rc;
+
+	br_data = devm_kzalloc(DEV(xdev), sizeof(*br_data), GFP_KERNEL);
+	if (!br_data)
+		return NULL;
+	br_data->xdev = xdev;
+
+	br_data->bridge_name = XRT_MD_NODE_GATE_ULP;
+	rc = xrt_md_find_endpoint(&xdev->dev, dtb, XRT_MD_NODE_GATE_ULP,
+				  NULL, &gate);
+	if (rc) {
+		br_data->bridge_name = XRT_MD_NODE_GATE_PLP;
+		rc = xrt_md_find_endpoint(&xdev->dev, dtb, XRT_MD_NODE_GATE_PLP,
+					  NULL, &gate);
+	}
+	if (rc) {
+		xrt_err(xdev, "failed to get axigate, rc %d", rc);
+		goto failed;
+	}
+
+	br = fpga_bridge_create(DEV(xdev), br_data->bridge_name,
+				&xmgnt_bridge_ops, br_data);
+	if (!br) {
+		xrt_err(xdev, "failed to create bridge");
+		goto failed;
+	}
+
+	rc = fpga_bridge_register(br);
+	if (rc) {
+		xrt_err(xdev, "failed to register bridge, rc %d", rc);
+		goto failed;
+	}
+
+	xrt_info(xdev, "created fpga bridge %s", br_data->bridge_name);
+
+	return br;
+
+failed:
+	if (br)
+		fpga_bridge_free(br);
+	if (br_data)
+		devm_kfree(DEV(xdev), br_data);
+
+	return NULL;
+}
+
+static void xmgnt_destroy_region(struct fpga_region *region)
+{
+	struct xmgnt_region *r_data = region->priv;
+
+	xrt_info(r_data->xdev, "destroy fpga region %llx.%llx",
+		 region->compat_id->id_h, region->compat_id->id_l);
+
+	fpga_region_unregister(region);
+
+	if (r_data->group_instance > 0)
+		xleaf_destroy_group(r_data->xdev, r_data->group_instance);
+
+	if (r_data->bridge)
+		xmgnt_destroy_bridge(r_data->bridge);
+
+	if (r_data->region->info) {
+		fpga_image_info_free(r_data->region->info);
+		r_data->region->info = NULL;
+	}
+
+	fpga_region_free(region);
+
+	devm_kfree(DEV(r_data->xdev), r_data);
+}
+
+static int xmgnt_region_match(struct device *dev, const void *data)
+{
+	const struct xmgnt_region_match_arg *arg = data;
+	const struct fpga_region *match_region;
+	uuid_t compat_uuid;
+	int i;
+
+	if (dev->parent != &arg->xdev->dev)
+		return false;
+
+	match_region = to_fpga_region(dev);
+	/*
+	 * The device tree provides both parent and child uuids for an
+	 * xclbin in one array. Here we try both uuids to see if it matches
+	 * with target region's compat_id. Strictly speaking we should
+	 * only match xclbin's parent uuid with target region's compat_id
+	 * but given the uuids by design are unique comparing with both
+	 * does not hurt.
+	 */
+	import_uuid(&compat_uuid, (const char *)match_region->compat_id);
+	for (i = 0; i < arg->uuid_num; i++) {
+		if (uuid_equal(&compat_uuid, &arg->uuids[i]))
+			return true;
+	}
+
+	return false;
+}
+
+static int xmgnt_region_match_base(struct device *dev, const void *data)
+{
+	const struct xmgnt_region_match_arg *arg = data;
+	const struct fpga_region *match_region;
+	const struct xmgnt_region *r_data;
+
+	if (dev->parent != &arg->xdev->dev)
+		return false;
+
+	match_region = to_fpga_region(dev);
+	r_data = match_region->priv;
+	if (uuid_is_null(&r_data->depend_uuid))
+		return true;
+
+	return false;
+}
+
+static int xmgnt_region_match_by_uuid(struct device *dev, const void *data)
+{
+	const struct xmgnt_region_match_arg *arg = data;
+	const struct fpga_region *match_region;
+	const struct xmgnt_region *r_data;
+
+	if (dev->parent != &arg->xdev->dev)
+		return false;
+
+	if (arg->uuid_num != 1)
+		return false;
+
+	match_region = to_fpga_region(dev);
+	r_data = match_region->priv;
+	if (uuid_equal(&r_data->depend_uuid, arg->uuids))
+		return true;
+
+	return false;
+}
+
+static void xmgnt_region_cleanup(struct fpga_region *region)
+{
+	struct xmgnt_region *r_data = region->priv, *pdata, *temp;
+	struct xrt_device *xdev = r_data->xdev;
+	struct xmgnt_region_match_arg arg = { 0 };
+	struct fpga_region *match_region = NULL;
+	struct device *start_dev = NULL;
+	LIST_HEAD(free_list);
+	uuid_t compat_uuid;
+
+	list_add_tail(&r_data->list, &free_list);
+	arg.xdev = xdev;
+	arg.uuid_num = 1;
+	arg.uuids = &compat_uuid;
+
+	/* find all regions depending on this region */
+	list_for_each_entry_safe(pdata, temp, &free_list, list) {
+		import_uuid(arg.uuids, (const char *)pdata->region->compat_id);
+		start_dev = NULL;
+		while ((match_region = fpga_region_class_find(start_dev, &arg,
+							      xmgnt_region_match_by_uuid))) {
+			pdata = match_region->priv;
+			list_add_tail(&pdata->list, &free_list);
+			start_dev = &match_region->dev;
+			put_device(&match_region->dev);
+		}
+	}
+
+	list_del(&r_data->list);
+
+	list_for_each_entry_safe_reverse(pdata, temp, &free_list, list)
+		xmgnt_destroy_region(pdata->region);
+
+	if (r_data->group_instance > 0) {
+		xleaf_destroy_group(xdev, r_data->group_instance);
+		r_data->group_instance = -1;
+	}
+	if (r_data->region->info) {
+		fpga_image_info_free(r_data->region->info);
+		r_data->region->info = NULL;
+	}
+}
+
+void xmgnt_region_cleanup_all(struct xrt_device *xdev)
+{
+	struct xmgnt_region_match_arg arg = { 0 };
+	struct fpga_region *base_region;
+
+	arg.xdev = xdev;
+
+	while ((base_region = fpga_region_class_find(NULL, &arg, xmgnt_region_match_base))) {
+		put_device(&base_region->dev);
+
+		xmgnt_region_cleanup(base_region);
+		xmgnt_destroy_region(base_region);
+	}
+}
+
+/*
+ * Program a region with a xclbin image. Bring up the subdevs and the
+ * group object to contain the subdevs.
+ */
+static int xmgnt_region_program(struct fpga_region *region, const void *xclbin, char *dtb)
+{
+	const struct axlf *xclbin_obj = xclbin;
+	struct fpga_image_info *info;
+	struct xrt_device *xdev;
+	struct xmgnt_region *r_data;
+	int rc;
+
+	r_data = region->priv;
+	xdev = r_data->xdev;
+
+	info = fpga_image_info_alloc(&xdev->dev);
+	if (!info)
+		return -ENOMEM;
+
+	info->buf = xclbin;
+	info->count = xclbin_obj->header.length;
+	info->flags |= FPGA_MGR_PARTIAL_RECONFIG;
+	region->info = info;
+	rc = fpga_region_program_fpga(region);
+	if (rc) {
+		xrt_err(xdev, "programming xclbin failed, rc %d", rc);
+		return rc;
+	}
+
+	/* free bridges to allow reprogram */
+	if (region->get_bridges)
+		fpga_bridges_put(&region->bridge_list);
+
+	/*
+	 * Next bringup the subdevs for this region which will be managed by
+	 * its own group object.
+	 */
+	r_data->group_instance = xleaf_create_group(xdev, dtb);
+	if (r_data->group_instance < 0) {
+		xrt_err(xdev, "failed to create group, rc %d",
+			r_data->group_instance);
+		rc = r_data->group_instance;
+		return rc;
+	}
+
+	rc = xleaf_wait_for_group_bringup(xdev);
+	if (rc)
+		xrt_err(xdev, "group bringup failed, rc %d", rc);
+	return rc;
+}
+
+static int xmgnt_get_bridges(struct fpga_region *region)
+{
+	struct xmgnt_region *r_data = region->priv;
+	struct device *dev = &r_data->xdev->dev;
+
+	return fpga_bridge_get_to_list(dev, region->info, &region->bridge_list);
+}
+
+/*
+ * Program/create FPGA regions based on input xclbin file.
+ * 1. Identify a matching existing region for this xclbin
+ * 2. Tear down any previous objects for the found region
+ * 3. Program this region with input xclbin
+ * 4. Iterate over this region's interface uuids to determine if it defines any
+ *    child region. Create fpga_region for the child region.
+ */
+int xmgnt_process_xclbin(struct xrt_device *xdev,
+			 struct fpga_manager *fmgr,
+			 const struct axlf *xclbin,
+			 enum provider_kind kind)
+{
+	struct fpga_region *region, *compat_region = NULL;
+	struct xmgnt_region_match_arg arg = { 0 };
+	struct xmgnt_region *r_data;
+	uuid_t compat_uuid;
+	char *dtb = NULL;
+	int rc, i;
+
+	rc = xrt_xclbin_get_metadata(DEV(xdev), xclbin, &dtb);
+	if (rc) {
+		xrt_err(xdev, "failed to get dtb: %d", rc);
+		goto failed;
+	}
+
+	rc = xrt_md_get_interface_uuids(DEV(xdev), dtb, 0, NULL);
+	if (rc < 0) {
+		xrt_err(xdev, "failed to get intf uuid");
+		rc = -EINVAL;
+		goto failed;
+	}
+	arg.uuid_num = rc;
+	arg.uuids = kcalloc(arg.uuid_num, sizeof(uuid_t), GFP_KERNEL);
+	if (!arg.uuids) {
+		rc = -ENOMEM;
+		goto failed;
+	}
+	arg.xdev = xdev;
+
+	rc = xrt_md_get_interface_uuids(DEV(xdev), dtb, arg.uuid_num, arg.uuids);
+	if (rc != arg.uuid_num) {
+		xrt_err(xdev, "only get %d uuids, expect %d", rc, arg.uuid_num);
+		rc = -EINVAL;
+		goto failed;
+	}
+
+	/* if this is not base firmware, search for a compatible region */
+	if (kind != XMGNT_BLP) {
+		compat_region = fpga_region_class_find(NULL, &arg, xmgnt_region_match);
+		if (!compat_region) {
+			xrt_err(xdev, "failed to get compatible region");
+			rc = -ENOENT;
+			goto failed;
+		}
+
+		xmgnt_region_cleanup(compat_region);
+
+		rc = xmgnt_region_program(compat_region, xclbin, dtb);
+		if (rc) {
+			xrt_err(xdev, "failed to program region");
+			goto failed;
+		}
+	}
+
+	if (compat_region)
+		import_uuid(&compat_uuid, (const char *)compat_region->compat_id);
+
+	/* create all the new regions contained in this xclbin */
+	for (i = 0; i < arg.uuid_num; i++) {
+		if (compat_region && uuid_equal(&compat_uuid, &arg.uuids[i])) {
+			/* region for this interface already exists */
+			continue;
+		}
+
+		region = fpga_region_create(DEV(xdev), fmgr, xmgnt_get_bridges);
+		if (!region) {
+			xrt_err(xdev, "failed to create fpga region");
+			rc = -EFAULT;
+			goto failed;
+		}
+		r_data = devm_kzalloc(DEV(xdev), sizeof(*r_data), GFP_KERNEL);
+		if (!r_data) {
+			rc = -ENOMEM;
+			fpga_region_free(region);
+			goto failed;
+		}
+		r_data->xdev = xdev;
+		r_data->region = region;
+		r_data->group_instance = -1;
+		uuid_copy(&r_data->interface_uuid, &arg.uuids[i]);
+		if (compat_region)
+			import_uuid(&r_data->depend_uuid, (const char *)compat_region->compat_id);
+		r_data->bridge = xmgnt_create_bridge(xdev, dtb);
+		if (!r_data->bridge) {
+			xrt_err(xdev, "failed to create fpga bridge");
+			rc = -EFAULT;
+			devm_kfree(DEV(xdev), r_data);
+			fpga_region_free(region);
+			goto failed;
+		}
+
+		region->compat_id = &r_data->compat_id;
+		export_uuid((char *)region->compat_id, &r_data->interface_uuid);
+		region->priv = r_data;
+
+		rc = fpga_region_register(region);
+		if (rc) {
+			xrt_err(xdev, "failed to register fpga region");
+			xmgnt_destroy_bridge(r_data->bridge);
+			fpga_region_free(region);
+			devm_kfree(DEV(xdev), r_data);
+			goto failed;
+		}
+
+		xrt_info(xdev, "created fpga region %llx.%llx",
+			 region->compat_id->id_h, region->compat_id->id_l);
+	}
+
+	if (compat_region)
+		put_device(&compat_region->dev);
+	vfree(dtb);
+	kfree(arg.uuids);
+	return 0;
+
+failed:
+	if (compat_region) {
+		put_device(&compat_region->dev);
+		xmgnt_region_cleanup(compat_region);
+	} else {
+		xmgnt_region_cleanup_all(xdev);
+	}
+
+	vfree(dtb);
+	kfree(arg.uuids);
+	return rc;
+}
diff --git a/drivers/fpga/xrt/mgnt/xrt-mgr.c b/drivers/fpga/xrt/mgnt/xrt-mgr.c
new file mode 100644
index 000000000000..354747f3e872
--- /dev/null
+++ b/drivers/fpga/xrt/mgnt/xrt-mgr.c
@@ -0,0 +1,190 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * FPGA Manager Support for Xilinx Alveo
+ *
+ * Copyright (C) 2020-2021 Xilinx, Inc.
+ *
+ * Authors: Sonal.Santan@xilinx.com
+ */
+
+#include <linux/cred.h>
+#include <linux/efi.h>
+#include <linux/fpga/fpga-mgr.h>
+#include <linux/module.h>
+#include <linux/vmalloc.h>
+
+#include "xclbin-helper.h"
+#include "xleaf.h"
+#include "xrt-mgr.h"
+#include "xleaf/axigate.h"
+#include "xleaf/icap.h"
+#include "xmgnt.h"
+
+struct xfpga_class {
+	struct xrt_device *xdev;
+	char name[64];
+};
+
+/*
+ * xclbin download plumbing -- find the download subsystem, ICAP and
+ * pass the xclbin for heavy lifting
+ */
+static int xmgnt_download_bitstream(struct xrt_device *xdev,
+				    const struct axlf *xclbin)
+
+{
+	struct xclbin_bit_head_info bit_header = { 0 };
+	struct xrt_device *icap_leaf = NULL;
+	struct xrt_icap_wr arg;
+	char *bitstream = NULL;
+	u64 bit_len;
+	int ret;
+
+	ret = xrt_xclbin_get_section(DEV(xdev), xclbin, BITSTREAM, (void **)&bitstream, &bit_len);
+	if (ret) {
+		xrt_err(xdev, "bitstream not found");
+		return -ENOENT;
+	}
+	ret = xrt_xclbin_parse_bitstream_header(DEV(xdev), bitstream,
+						XCLBIN_HWICAP_BITFILE_BUF_SZ,
+						&bit_header);
+	if (ret) {
+		ret = -EINVAL;
+		xrt_err(xdev, "invalid bitstream header");
+		goto fail;
+	}
+	if (bit_header.header_length + bit_header.bitstream_length > bit_len) {
+		ret = -EINVAL;
+		xrt_err(xdev, "invalid bitstream length. header %d, bitstream %d, section len %lld",
+			bit_header.header_length, bit_header.bitstream_length, bit_len);
+		goto fail;
+	}
+
+	icap_leaf = xleaf_get_leaf_by_id(xdev, XRT_SUBDEV_ICAP, XRT_INVALID_DEVICE_INST);
+	if (!icap_leaf) {
+		ret = -ENODEV;
+		xrt_err(xdev, "icap does not exist");
+		goto fail;
+	}
+	arg.xiiw_bit_data = bitstream + bit_header.header_length;
+	arg.xiiw_data_len = bit_header.bitstream_length;
+	ret = xleaf_call(icap_leaf, XRT_ICAP_WRITE, &arg);
+	if (ret) {
+		xrt_err(xdev, "write bitstream failed, ret = %d", ret);
+		xleaf_put_leaf(xdev, icap_leaf);
+		goto fail;
+	}
+
+	xleaf_put_leaf(xdev, icap_leaf);
+	vfree(bitstream);
+
+	return 0;
+
+fail:
+	vfree(bitstream);
+
+	return ret;
+}
+
+/*
+ * There is no HW prep work we do here since we need the full
+ * xclbin for its sanity check.
+ */
+static int xmgnt_pr_write_init(struct fpga_manager *mgr,
+			       struct fpga_image_info *info,
+			       const char *buf, size_t count)
+{
+	const struct axlf *bin = (const struct axlf *)buf;
+	struct xfpga_class *obj = mgr->priv;
+
+	if (!(info->flags & FPGA_MGR_PARTIAL_RECONFIG)) {
+		xrt_info(obj->xdev, "%s only supports partial reconfiguration\n", obj->name);
+		return -EINVAL;
+	}
+
+	if (count < sizeof(struct axlf))
+		return -EINVAL;
+
+	if (count > bin->header.length)
+		return -EINVAL;
+
+	xrt_info(obj->xdev, "Prepare download of xclbin %pUb of length %lld B",
+		 &bin->header.uuid, bin->header.length);
+
+	return 0;
+}
+
+/*
+ * The implementation requries full xclbin image before we can start
+ * programming the hardware via ICAP subsystem. The full image is required
+ * for checking the validity of xclbin and walking the sections to
+ * discover the bitstream.
+ */
+static int xmgnt_pr_write(struct fpga_manager *mgr,
+			  const char *buf, size_t count)
+{
+	const struct axlf *bin = (const struct axlf *)buf;
+	struct xfpga_class *obj = mgr->priv;
+
+	if (bin->header.length != count)
+		return -EINVAL;
+
+	return xmgnt_download_bitstream((void *)obj->xdev, bin);
+}
+
+static int xmgnt_pr_write_complete(struct fpga_manager *mgr,
+				   struct fpga_image_info *info)
+{
+	const struct axlf *bin = (const struct axlf *)info->buf;
+	struct xfpga_class *obj = mgr->priv;
+
+	xrt_info(obj->xdev, "Finished download of xclbin %pUb",
+		 &bin->header.uuid);
+	return 0;
+}
+
+static enum fpga_mgr_states xmgnt_pr_state(struct fpga_manager *mgr)
+{
+	return FPGA_MGR_STATE_UNKNOWN;
+}
+
+static const struct fpga_manager_ops xmgnt_pr_ops = {
+	.initial_header_size = sizeof(struct axlf),
+	.write_init = xmgnt_pr_write_init,
+	.write = xmgnt_pr_write,
+	.write_complete = xmgnt_pr_write_complete,
+	.state = xmgnt_pr_state,
+};
+
+struct fpga_manager *xmgnt_fmgr_probe(struct xrt_device *xdev)
+{
+	struct xfpga_class *obj = devm_kzalloc(DEV(xdev), sizeof(struct xfpga_class),
+					       GFP_KERNEL);
+	struct fpga_manager *fmgr = NULL;
+	int ret = 0;
+
+	if (!obj)
+		return ERR_PTR(-ENOMEM);
+
+	snprintf(obj->name, sizeof(obj->name), "Xilinx Alveo FPGA Manager");
+	obj->xdev = xdev;
+	fmgr = fpga_mgr_create(&xdev->dev,
+			       obj->name,
+			       &xmgnt_pr_ops,
+			       obj);
+	if (!fmgr)
+		return ERR_PTR(-ENOMEM);
+
+	ret = fpga_mgr_register(fmgr);
+	if (ret) {
+		fpga_mgr_free(fmgr);
+		return ERR_PTR(ret);
+	}
+	return fmgr;
+}
+
+int xmgnt_fmgr_remove(struct fpga_manager *fmgr)
+{
+	fpga_mgr_unregister(fmgr);
+	return 0;
+}
diff --git a/drivers/fpga/xrt/mgnt/xrt-mgr.h b/drivers/fpga/xrt/mgnt/xrt-mgr.h
new file mode 100644
index 000000000000..d505a770ea9f
--- /dev/null
+++ b/drivers/fpga/xrt/mgnt/xrt-mgr.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2021 Xilinx, Inc.
+ *
+ * Authors: Sonal.Santan@xilinx.com
+ */
+
+#ifndef _XRT_MGR_H_
+#define _XRT_MGR_H_
+
+#include <linux/fpga/fpga-mgr.h>
+
+struct fpga_manager *xmgnt_fmgr_probe(struct xrt_device *xdev);
+int xmgnt_fmgr_remove(struct fpga_manager *fmgr);
+
+#endif /* _XRT_MGR_H_ */
-- 
2.27.0


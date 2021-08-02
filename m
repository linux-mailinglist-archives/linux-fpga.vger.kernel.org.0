Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36B4B3DDD2F
	for <lists+linux-fpga@lfdr.de>; Mon,  2 Aug 2021 18:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232647AbhHBQIC (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 2 Aug 2021 12:08:02 -0400
Received: from mail-dm6nam10on2042.outbound.protection.outlook.com ([40.107.93.42]:7905
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229979AbhHBQIA (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 2 Aug 2021 12:08:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RrJUSkzaQTIN746Mrdqq6rU6iTte8G9kwDwHWFfLTbLa5DtfzjPo4CC7ik1Y+us1SyK0Cm8AfPWSIdRH1uHAXGehvg3tScWD+20nbKckJOr7RfhqlnUgFO4/L+b7gD0Ad1Yro55eRdXT3dS9NjsTL0HrcUqgCWrzb1QLO+jYYH65n6/ASv/1981SnZwIH3P73XAINvtMsBRvNyorvjihmNTFesIbspKL8MNS/xEHCtYKNVXgq6+YTiNJRgXNvf0DTcllnwgEx94L84OZocj7gS5l1SCZiU3s9QvMjHoXx4y4wOZ6ZPNFbTc6CBSzcjxgIid8BcRYXYt9ZD/Cf0+k9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iUl7AflccZxU4PvOj7Nplt9qWvSh3441SZg9SXDXutA=;
 b=YvMUfjrxsOd67iGI6sRqHleX7Xyr1PqrxrLWfwSjHJK9sBrSzE35oV/T7xyd4WxOojmAI6ImaPbHP2iaHBTR0p2S6PCenuSfpH9KGdxfHe5FQ8J5U8zCoCHG9x7oUUX293tOY03adOJcXYA4Mtrn9rNbhhjhkzD6EqgYkzSyn2GTgpP/Ihu2cS9pNDypuXWjhX25Lm6csr+Z1dP8FWZLNELC8p79HAKfFsJKVKlT4HeNplFs1oQxyq2h1Mb6tQlYN0bffF4WTjzivDnab1nIDMjFXB9i8fvLPaOG8PSE4HizVKJBzl4wn9ieBTRyb1Vh1X90yijH2qgKwBpKx/HXzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iUl7AflccZxU4PvOj7Nplt9qWvSh3441SZg9SXDXutA=;
 b=jWk5ao5NVAURkHi0fDkhvPq7Aisb6GXQlqvBOowfg9wMwuDjm78AS7riD0n0qkVjDiXLxHYX/MokIPFilREFse/VdYEDhPEFuwmc6EWkJoH0BqbIpEwkSOOjF10EFkfedEWiAQDCWRrXzIvb4aW4WojhNuATJSuDIXBnJXJJvgI=
Received: from DM3PR12CA0123.namprd12.prod.outlook.com (2603:10b6:0:51::19) by
 BYAPR02MB5768.namprd02.prod.outlook.com (2603:10b6:a03:11b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.17; Mon, 2 Aug
 2021 16:07:48 +0000
Received: from DM3NAM02FT013.eop-nam02.prod.protection.outlook.com
 (2603:10b6:0:51:cafe::a6) by DM3PR12CA0123.outlook.office365.com
 (2603:10b6:0:51::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend
 Transport; Mon, 2 Aug 2021 16:07:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT013.mail.protection.outlook.com (10.13.5.126) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4373.18 via Frontend Transport; Mon, 2 Aug 2021 16:07:47 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 2 Aug 2021 09:07:42 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Mon, 2 Aug 2021 09:07:42 -0700
Envelope-to: mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [10.23.145.232] (port=49070 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1mAaTe-0005JA-GC; Mon, 02 Aug 2021 09:07:42 -0700
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id EFEEF601B35; Mon,  2 Aug 2021 09:05:30 -0700 (PDT)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>, Max Zhen <max.zhen@xilinx.com>
Subject: [PATCH V9 XRT Alveo 11/14] fpga: xrt: fpga-mgr and region implementation for xclbin download
Date:   Mon, 2 Aug 2021 09:05:18 -0700
Message-ID: <20210802160521.331031-12-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210802160521.331031-1-lizhi.hou@xilinx.com>
References: <20210802160521.331031-1-lizhi.hou@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a5a2674d-c6c2-4af9-2eb8-08d955cfabec
X-MS-TrafficTypeDiagnostic: BYAPR02MB5768:
X-Microsoft-Antispam-PRVS: <BYAPR02MB5768DDB48FF1AC3C9B0A8119A1EF9@BYAPR02MB5768.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:608;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cMLmqvl82xEKZ4/pUTJqfRpy0h4w4msV5sfsgGwtl15GS+u9LC049s0eIDGs8wIDsDtZYS/LUfhgLKWCaTL1SqTlkew2NjRliUcSYio+VokpJ7gSJ7iqy8b8XMG68ol27w2dLshjVOGxP/Qi22APw592PfuwVKD7JOckCJY4L1/WjU6w3Bj1M6nANwPzrW4BFMNtDgpvlv0MWHbF7fkqRXwbHRRWE74qLzYC1ifK/A1ySw0ZUYAMFUfRivNEcJusUvt3cFeilBXSZzVNWamYKzvtoYc9FGGMiJFsevD6Ng7xc6ETs8fLHM1h3U84r9qvO3ICBVi1NSHY45bYi/0kISRgXEVmht2tp6djkHq+zQIrYldaSx1k99I4EFJWOponC+uZyahqM3yY9jS8P0D82hzmOPuTcrGVzmN8uq5/v0iLo4DYwlFHa6nf7a3BbOjYOa0ysdwYIb7mXnZ1ZHZz+Vcbmf76llc1jTJNP1PzVJI99R+AWaBLHpBEfrlRo9WNpmEIqXaqMNq8CBKLANXMNO1xPS2gnVJLx1L9+DoW5zHhD1w6OCnjJ1dJnayoHMjp8FLIpQPHnY+UIc+UDmYK6floHXqTU7kooGJFYpsfjyMhvwmq9PEwRk5U5qZjfaEIXdQoH2pZ3nrwkQOBCnMQmZLwZqxA+JJL8G/yNt/wxsGNm3KgzIL5Lc+VidXyLdPDYUF0On6VUdJ9G3wItuz4fw==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(136003)(396003)(36840700001)(46966006)(336012)(47076005)(1076003)(36906005)(426003)(6666004)(107886003)(478600001)(44832011)(2906002)(186003)(356005)(36756003)(26005)(30864003)(4326008)(6916009)(7636003)(2616005)(54906003)(6266002)(82310400003)(36860700001)(42186006)(8936002)(83380400001)(316002)(70206006)(8676002)(5660300002)(82740400003)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2021 16:07:47.9709
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5a2674d-c6c2-4af9-2eb8-08d955cfabec
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT013.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5768
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

fpga-mgr and region implementation for xclbin download which will be
called from main xrt driver

Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
Signed-off-by: Max Zhen <max.zhen@xilinx.com>
Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
Reviewed-by: Tom Rix <trix@redhat.com>
---
 drivers/fpga/xrt/mgmt/xmgmt-main-region.c | 483 ++++++++++++++++++++++
 drivers/fpga/xrt/mgmt/xrt-mgr.c           | 190 +++++++++
 drivers/fpga/xrt/mgmt/xrt-mgr.h           |  16 +
 3 files changed, 689 insertions(+)
 create mode 100644 drivers/fpga/xrt/mgmt/xmgmt-main-region.c
 create mode 100644 drivers/fpga/xrt/mgmt/xrt-mgr.c
 create mode 100644 drivers/fpga/xrt/mgmt/xrt-mgr.h

diff --git a/drivers/fpga/xrt/mgmt/xmgmt-main-region.c b/drivers/fpga/xrt/mgmt/xmgmt-main-region.c
new file mode 100644
index 000000000000..6e6a16b13258
--- /dev/null
+++ b/drivers/fpga/xrt/mgmt/xmgmt-main-region.c
@@ -0,0 +1,483 @@
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
+#include "xmgmt.h"
+
+struct xmgmt_bridge {
+	struct xrt_device *xdev;
+	const char *bridge_name;
+};
+
+struct xmgmt_region {
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
+struct xmgmt_region_match_arg {
+	struct xrt_device *xdev;
+	uuid_t *uuids;
+	u32 uuid_num;
+};
+
+static int xmgmt_br_enable_set(struct fpga_bridge *bridge, bool enable)
+{
+	struct xmgmt_bridge *br_data = (struct xmgmt_bridge *)bridge->priv;
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
+static const struct fpga_bridge_ops xmgmt_bridge_ops = {
+	.enable_set = xmgmt_br_enable_set
+};
+
+static void xmgmt_destroy_bridge(struct fpga_bridge *br)
+{
+	struct xmgmt_bridge *br_data = br->priv;
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
+static struct fpga_bridge *xmgmt_create_bridge(struct xrt_device *xdev,
+					       char *dtb)
+{
+	struct fpga_bridge *br = NULL;
+	struct xmgmt_bridge *br_data;
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
+				&xmgmt_bridge_ops, br_data);
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
+static void xmgmt_destroy_region(struct fpga_region *region)
+{
+	struct xmgmt_region *r_data = region->priv;
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
+		xmgmt_destroy_bridge(r_data->bridge);
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
+static int xmgmt_region_match(struct device *dev, const void *data)
+{
+	const struct xmgmt_region_match_arg *arg = data;
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
+static int xmgmt_region_match_base(struct device *dev, const void *data)
+{
+	const struct xmgmt_region_match_arg *arg = data;
+	const struct fpga_region *match_region;
+	const struct xmgmt_region *r_data;
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
+static int xmgmt_region_match_by_uuid(struct device *dev, const void *data)
+{
+	const struct xmgmt_region_match_arg *arg = data;
+	const struct fpga_region *match_region;
+	const struct xmgmt_region *r_data;
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
+static void xmgmt_region_cleanup(struct fpga_region *region)
+{
+	struct xmgmt_region *r_data = region->priv, *pdata, *temp;
+	struct xrt_device *xdev = r_data->xdev;
+	struct xmgmt_region_match_arg arg = { 0 };
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
+							      xmgmt_region_match_by_uuid))) {
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
+		xmgmt_destroy_region(pdata->region);
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
+void xmgmt_region_cleanup_all(struct xrt_device *xdev)
+{
+	struct xmgmt_region_match_arg arg = { 0 };
+	struct fpga_region *base_region;
+
+	arg.xdev = xdev;
+
+	while ((base_region = fpga_region_class_find(NULL, &arg, xmgmt_region_match_base))) {
+		put_device(&base_region->dev);
+
+		xmgmt_region_cleanup(base_region);
+		xmgmt_destroy_region(base_region);
+	}
+}
+
+/*
+ * Program a region with a xclbin image. Bring up the subdevs and the
+ * group object to contain the subdevs.
+ */
+static int xmgmt_region_program(struct fpga_region *region, const void *xclbin, char *dtb)
+{
+	const struct axlf *xclbin_obj = xclbin;
+	struct fpga_image_info *info;
+	struct xrt_device *xdev;
+	struct xmgmt_region *r_data;
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
+static int xmgmt_get_bridges(struct fpga_region *region)
+{
+	struct xmgmt_region *r_data = region->priv;
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
+int xmgmt_process_xclbin(struct xrt_device *xdev,
+			 struct fpga_manager *fmgr,
+			 const struct axlf *xclbin,
+			 enum provider_kind kind)
+{
+	struct fpga_region *region, *compat_region = NULL;
+	struct xmgmt_region_match_arg arg = { 0 };
+	struct xmgmt_region *r_data;
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
+	if (kind != XMGMT_BLP) {
+		compat_region = fpga_region_class_find(NULL, &arg, xmgmt_region_match);
+		if (!compat_region) {
+			xrt_err(xdev, "failed to get compatible region");
+			rc = -ENOENT;
+			goto failed;
+		}
+
+		xmgmt_region_cleanup(compat_region);
+
+		rc = xmgmt_region_program(compat_region, xclbin, dtb);
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
+		region = fpga_region_create(DEV(xdev), fmgr, xmgmt_get_bridges);
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
+		r_data->bridge = xmgmt_create_bridge(xdev, dtb);
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
+			xmgmt_destroy_bridge(r_data->bridge);
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
+		xmgmt_region_cleanup(compat_region);
+	}
+
+	vfree(dtb);
+	kfree(arg.uuids);
+	return rc;
+}
diff --git a/drivers/fpga/xrt/mgmt/xrt-mgr.c b/drivers/fpga/xrt/mgmt/xrt-mgr.c
new file mode 100644
index 000000000000..ab253b516e8d
--- /dev/null
+++ b/drivers/fpga/xrt/mgmt/xrt-mgr.c
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
+#include "xmgmt.h"
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
+static int xmgmt_download_bitstream(struct xrt_device *xdev,
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
+static int xmgmt_pr_write_init(struct fpga_manager *mgr,
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
+ * The implementation requires full xclbin image before we can start
+ * programming the hardware via ICAP subsystem. The full image is required
+ * for checking the validity of xclbin and walking the sections to
+ * discover the bitstream.
+ */
+static int xmgmt_pr_write(struct fpga_manager *mgr,
+			  const char *buf, size_t count)
+{
+	const struct axlf *bin = (const struct axlf *)buf;
+	struct xfpga_class *obj = mgr->priv;
+
+	if (bin->header.length != count)
+		return -EINVAL;
+
+	return xmgmt_download_bitstream((void *)obj->xdev, bin);
+}
+
+static int xmgmt_pr_write_complete(struct fpga_manager *mgr,
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
+static enum fpga_mgr_states xmgmt_pr_state(struct fpga_manager *mgr)
+{
+	return FPGA_MGR_STATE_UNKNOWN;
+}
+
+static const struct fpga_manager_ops xmgmt_pr_ops = {
+	.initial_header_size = sizeof(struct axlf),
+	.write_init = xmgmt_pr_write_init,
+	.write = xmgmt_pr_write,
+	.write_complete = xmgmt_pr_write_complete,
+	.state = xmgmt_pr_state,
+};
+
+struct fpga_manager *xmgmt_fmgr_probe(struct xrt_device *xdev)
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
+			       &xmgmt_pr_ops,
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
+int xmgmt_fmgr_remove(struct fpga_manager *fmgr)
+{
+	fpga_mgr_unregister(fmgr);
+	return 0;
+}
diff --git a/drivers/fpga/xrt/mgmt/xrt-mgr.h b/drivers/fpga/xrt/mgmt/xrt-mgr.h
new file mode 100644
index 000000000000..a3d1ab1c34f0
--- /dev/null
+++ b/drivers/fpga/xrt/mgmt/xrt-mgr.h
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
+struct fpga_manager *xmgmt_fmgr_probe(struct xrt_device *xdev);
+int xmgmt_fmgr_remove(struct fpga_manager *fmgr);
+
+#endif /* _XRT_MGR_H_ */
-- 
2.27.0


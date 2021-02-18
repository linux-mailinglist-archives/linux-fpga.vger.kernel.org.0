Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7917031E673
	for <lists+linux-fpga@lfdr.de>; Thu, 18 Feb 2021 07:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbhBRGrW (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 18 Feb 2021 01:47:22 -0500
Received: from mail-bn8nam11on2067.outbound.protection.outlook.com ([40.107.236.67]:1633
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230414AbhBRGoe (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 18 Feb 2021 01:44:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lVEdj5+Rf1Y+sqKJt/KPMD/B9EgHhVGPK8KwXMpj1VKAD3ev+297+JzYU1b8bazZie8i+gt0cC37zAU/iqDoy2JODn3Chm1n7yrMaPyL5GJo4+o30hcuFgyiXQy6vb4643fUI0TvDXXFocIf4/bO84WvawS5YFpffnM3T3siXzAlucj8aSnbGpGU8OzJZoyvJJfPFcyk9lao80kwSm5XXfdCEcBfEfQvSv7FTmdFwciN0iVdHJUTlCw6ifCVb1IamZw2utzR3mUBwip7R7AMgGHDaCtJPorf/gYK/0RUGWej6AuYxQBYr+FrM+zzSga+CVMqgepF4RFMu3ucNvtfpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OvbnYh7wtw4wrcPKjmAjuyLX1itMsUsN/7g5nSLFyKU=;
 b=N7+i/TKov4eMw33S9YEzzsq8otcJbm10BhTQe8nvFVGF52URvkts75EdTg5A41eWqk4Yian8sr1TO4rO4KZJtfY7qNDjTRqfOpvsMu+YD1dtFuYhaiPUqvC0JCuraJflg2wkCXWzWhX/ltFT5rC6zkLhiubESp4g27bY0yRcvxI0aTEA6NMDzxvEaDW3NJK/UH7RsHDrHJZRg23FtCj7LVrL/ySmsm9PRLj6PnLjozI3BNA5weQ+qql2etTWjNv2zC1C20ucOilXjXk8H011GL9QbKE8THh7dRpjwOI0Of/1Dv88Oc9dU27rem3l/GS/pvRnoPAvxOGlXutcdBh1vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OvbnYh7wtw4wrcPKjmAjuyLX1itMsUsN/7g5nSLFyKU=;
 b=hfp5bDETBywyw1YGNx+YwNVBrXlR5+F6urHmOP98LcQ+xwIzLbqAcYzFBt4c+93DvCj+47+KR6GjyxSZfXCKK+l54Ymafix3f7dVHtrjsZk/NZIFvJbVIqXQ+bkdZk5tWdRmxCkC45tPQVjIyavGmkhgLWpQGTDDQEkp/oZiP3E=
Received: from CY4PR01CA0010.prod.exchangelabs.com (2603:10b6:903:1f::20) by
 DM6PR02MB4827.namprd02.prod.outlook.com (2603:10b6:5:fa::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3846.36; Thu, 18 Feb 2021 06:43:41 +0000
Received: from CY1NAM02FT050.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:1f:cafe::77) by CY4PR01CA0010.outlook.office365.com
 (2603:10b6:903:1f::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend
 Transport; Thu, 18 Feb 2021 06:43:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 CY1NAM02FT050.mail.protection.outlook.com (10.152.75.65) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3868.27 via Frontend Transport; Thu, 18 Feb 2021 06:43:41 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Wed, 17 Feb 2021 22:43:39 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Wed, 17 Feb 2021 22:43:39 -0800
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
Received: from [172.19.72.212] (port=40166 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1lCd2J-0001li-Ku; Wed, 17 Feb 2021 22:43:39 -0800
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id C364F60011D; Wed, 17 Feb 2021 22:41:05 -0800 (PST)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhih@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>, Max Zhen <max.zhen@xilinx.com>
Subject: [PATCH V3 XRT Alveo 04/18] fpga: xrt: xrt-lib platform driver manager
Date:   Wed, 17 Feb 2021 22:40:05 -0800
Message-ID: <20210218064019.29189-5-lizhih@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210218064019.29189-1-lizhih@xilinx.com>
References: <20210218064019.29189-1-lizhih@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f7f9018-ebb5-4956-046c-08d8d3d8876f
X-MS-TrafficTypeDiagnostic: DM6PR02MB4827:
X-Microsoft-Antispam-PRVS: <DM6PR02MB482731B575F5718A7DCDD140A1859@DM6PR02MB4827.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:119;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wnJBKVifC3DgR3wh6C6nDpCyUEKc/01/GIyF+flBwWbqX8hpD8UA9Xnq34v+2Uive3KhvUtc7IQ/vHio4mTwUoeVrH7XePJCa5Q+ktRwkJmxqUmAUEALhvWIT44nNusK9RLiEBymE02JnXCBOFLmZCbJ0jve3YTx1OVcPi/3j8+BtMZoPN4pKVRegKTkGxrpkPvYbIZGbFVxVzBz0pGXG3peTGsX0H+aZcjUdZxo7yBdivbohxc9ZULu03zwdR8BU0WpS40GK2XgtKoRazreQl3+5zuSNfJwaH1NzAmbJC4sdyl7v5Q8neh2dq2Lu18ddWd/MbcmP2kvwO/r0py9G+WugQExjJ6AlZODjotdPIEeQA5JLihJFMEmDJFIgYWw9VlHW4Z6O/CKwSkPGD8LhG9fdc9OEhjgB438V5whYhMKWHYTop5sl7hdsKHCoq7irrwdumq0o0SqNWv3PW0zwbW8VZxF/Onn/gv8afUdnt9Fa/PWJWQxvM3MDX2U16r1bBvH/PECsaECqc51j6rjGIIWkGSILnGi9LKXsdq5hUqIvVB78JQyqiLaGrOBMO3KmB+A8jdDPnGAoc42fFAYP+H8IvAzZ6L4wqrQeQzlJiLhViCQ8i0OJxAMqcQ4lNKyyPFNs74NOFBYT/dEaXlVRw==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(136003)(396003)(346002)(39860400002)(376002)(46966006)(36840700001)(1076003)(107886003)(356005)(44832011)(82740400003)(4326008)(82310400003)(26005)(7636003)(70586007)(2616005)(5660300002)(8676002)(336012)(6266002)(316002)(36906005)(186003)(426003)(2906002)(8936002)(83380400001)(36756003)(42186006)(478600001)(47076005)(70206006)(36860700001)(6916009)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2021 06:43:41.0882
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f7f9018-ebb5-4956-046c-08d8d3d8876f
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT050.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4827
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

xrt-lib kernel module infrastructure code to register and manage all
leaf driver modules.

Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
Signed-off-by: Max Zhen <max.zhen@xilinx.com>
Signed-off-by: Lizhi Hou <lizhih@xilinx.com>
---
 drivers/fpga/xrt/lib/main.c | 274 ++++++++++++++++++++++++++++++++++++
 drivers/fpga/xrt/lib/main.h |  17 +++
 2 files changed, 291 insertions(+)
 create mode 100644 drivers/fpga/xrt/lib/main.c
 create mode 100644 drivers/fpga/xrt/lib/main.h

diff --git a/drivers/fpga/xrt/lib/main.c b/drivers/fpga/xrt/lib/main.c
new file mode 100644
index 000000000000..36fb62710843
--- /dev/null
+++ b/drivers/fpga/xrt/lib/main.c
@@ -0,0 +1,274 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for Xilinx Alveo FPGA Support
+ *
+ * Copyright (C) 2020-2021 Xilinx, Inc.
+ *
+ * Authors:
+ *	Cheng Zhen <maxz@xilinx.com>
+ */
+
+#include <linux/module.h>
+#include "xleaf.h"
+#include "xroot.h"
+#include "main.h"
+
+#define XRT_IPLIB_MODULE_NAME		"xrt-lib"
+#define XRT_IPLIB_MODULE_VERSION	"4.0.0"
+#define XRT_MAX_DEVICE_NODES		128
+#define XRT_DRVNAME(drv)		((drv)->driver.name)
+
+/*
+ * Subdev driver is known by ID to others. We map the ID to it's
+ * struct platform_driver, which contains it's binding name and driver/file ops.
+ * We also map it to the endpoint name in DTB as well, if it's different
+ * than the driver's binding name.
+ */
+struct xrt_drv_map {
+	struct list_head list;
+	enum xrt_subdev_id id;
+	struct platform_driver *drv;
+	struct xrt_subdev_endpoints *eps;
+	struct ida ida; /* manage driver instance and char dev minor */
+};
+
+static DEFINE_MUTEX(xrt_lib_lock); /* global lock protecting xrt_drv_maps list */
+static LIST_HEAD(xrt_drv_maps);
+struct class *xrt_class;
+
+static inline struct xrt_subdev_drvdata *
+xrt_drv_map2drvdata(struct xrt_drv_map *map)
+{
+	return (struct xrt_subdev_drvdata *)map->drv->id_table[0].driver_data;
+}
+
+static struct xrt_drv_map *
+xrt_drv_find_map_by_id_nolock(enum xrt_subdev_id id)
+{
+	const struct list_head *ptr;
+
+	list_for_each(ptr, &xrt_drv_maps) {
+		struct xrt_drv_map *tmap = list_entry(ptr, struct xrt_drv_map, list);
+
+		if (tmap->id == id)
+			return tmap;
+	}
+	return NULL;
+}
+
+static struct xrt_drv_map *
+xrt_drv_find_map_by_id(enum xrt_subdev_id id)
+{
+	struct xrt_drv_map *map;
+
+	mutex_lock(&xrt_lib_lock);
+	map = xrt_drv_find_map_by_id_nolock(id);
+	mutex_unlock(&xrt_lib_lock);
+	/*
+	 * map should remain valid even after lock is dropped since a registered
+	 * driver should only be unregistered when driver module is being unloaded,
+	 * which means that the driver should not be used by then.
+	 */
+	return map;
+}
+
+static int xrt_drv_register_driver(struct xrt_drv_map *map)
+{
+	struct xrt_subdev_drvdata *drvdata;
+	int rc = 0;
+	const char *drvname = XRT_DRVNAME(map->drv);
+
+	rc = platform_driver_register(map->drv);
+	if (rc) {
+		pr_err("register %s platform driver failed\n", drvname);
+		return rc;
+	}
+
+	drvdata = xrt_drv_map2drvdata(map);
+	if (drvdata) {
+		/* Initialize dev_t for char dev node. */
+		if (xleaf_devnode_enabled(drvdata)) {
+			rc = alloc_chrdev_region(&drvdata->xsd_file_ops.xsf_dev_t, 0,
+						 XRT_MAX_DEVICE_NODES, drvname);
+			if (rc) {
+				platform_driver_unregister(map->drv);
+				pr_err("failed to alloc dev minor for %s: %d\n", drvname, rc);
+				return rc;
+			}
+		} else {
+			drvdata->xsd_file_ops.xsf_dev_t = (dev_t)-1;
+		}
+	}
+
+	ida_init(&map->ida);
+
+	pr_info("%s registered successfully\n", drvname);
+
+	return 0;
+}
+
+static void xrt_drv_unregister_driver(struct xrt_drv_map *map)
+{
+	const char *drvname = XRT_DRVNAME(map->drv);
+	struct xrt_subdev_drvdata *drvdata;
+
+	ida_destroy(&map->ida);
+
+	drvdata = xrt_drv_map2drvdata(map);
+	if (drvdata && drvdata->xsd_file_ops.xsf_dev_t != (dev_t)-1) {
+		unregister_chrdev_region(drvdata->xsd_file_ops.xsf_dev_t,
+					 XRT_MAX_DEVICE_NODES);
+	}
+
+	platform_driver_unregister(map->drv);
+
+	pr_info("%s unregistered successfully\n", drvname);
+}
+
+int xleaf_register_driver(enum xrt_subdev_id id,
+			  struct platform_driver *drv,
+			  struct xrt_subdev_endpoints *eps)
+{
+	struct xrt_drv_map *map;
+
+	mutex_lock(&xrt_lib_lock);
+
+	map = xrt_drv_find_map_by_id_nolock(id);
+	if (map) {
+		mutex_unlock(&xrt_lib_lock);
+		pr_err("Id %d already has a registered driver, 0x%p\n",
+		       id, map->drv);
+		return -EEXIST;
+	}
+
+	map = vzalloc(sizeof(*map));
+	if (!map) {
+		mutex_unlock(&xrt_lib_lock);
+		return -ENOMEM;
+	}
+	map->id = id;
+	map->drv = drv;
+	map->eps = eps;
+
+	xrt_drv_register_driver(map);
+
+	list_add(&map->list, &xrt_drv_maps);
+
+	mutex_unlock(&xrt_lib_lock);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(xleaf_register_driver);
+
+void xleaf_unregister_driver(enum xrt_subdev_id id)
+{
+	struct xrt_drv_map *map;
+
+	mutex_lock(&xrt_lib_lock);
+
+	map = xrt_drv_find_map_by_id_nolock(id);
+	if (!map) {
+		mutex_unlock(&xrt_lib_lock);
+		pr_err("Id %d has no registered driver\n", id);
+		return;
+	}
+
+	list_del(&map->list);
+
+	mutex_unlock(&xrt_lib_lock);
+
+	xrt_drv_unregister_driver(map);
+	vfree(map);
+}
+EXPORT_SYMBOL_GPL(xleaf_unregister_driver);
+
+const char *xrt_drv_name(enum xrt_subdev_id id)
+{
+	struct xrt_drv_map *map = xrt_drv_find_map_by_id(id);
+
+	if (map)
+		return XRT_DRVNAME(map->drv);
+	return NULL;
+}
+
+int xrt_drv_get_instance(enum xrt_subdev_id id)
+{
+	struct xrt_drv_map *map = xrt_drv_find_map_by_id(id);
+
+	return ida_alloc_range(&map->ida, 0, XRT_MAX_DEVICE_NODES, GFP_KERNEL);
+}
+
+void xrt_drv_put_instance(enum xrt_subdev_id id, int instance)
+{
+	struct xrt_drv_map *map = xrt_drv_find_map_by_id(id);
+
+	ida_free(&map->ida, instance);
+}
+
+struct xrt_subdev_endpoints *xrt_drv_get_endpoints(enum xrt_subdev_id id)
+{
+	struct xrt_drv_map *map = xrt_drv_find_map_by_id(id);
+	struct xrt_subdev_endpoints *eps;
+
+	eps = map ? map->eps : NULL;
+	return eps;
+}
+
+/* Leaf driver's module init/fini callbacks. */
+static void (*leaf_init_fini_cbs[])(bool) = {
+	group_leaf_init_fini,
+	vsec_leaf_init_fini,
+	devctl_leaf_init_fini,
+	axigate_leaf_init_fini,
+	icap_leaf_init_fini,
+	calib_leaf_init_fini,
+	clkfreq_leaf_init_fini,
+	clock_leaf_init_fini,
+	ucs_leaf_init_fini,
+};
+
+static __init int xrt_lib_init(void)
+{
+	int i;
+
+	xrt_class = class_create(THIS_MODULE, XRT_IPLIB_MODULE_NAME);
+	if (IS_ERR(xrt_class))
+		return PTR_ERR(xrt_class);
+
+	for (i = 0; i < ARRAY_SIZE(leaf_init_fini_cbs); i++)
+		leaf_init_fini_cbs[i](true);
+	return 0;
+}
+
+static __exit void xrt_lib_fini(void)
+{
+	struct xrt_drv_map *map;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(leaf_init_fini_cbs); i++)
+		leaf_init_fini_cbs[i](false);
+
+	mutex_lock(&xrt_lib_lock);
+
+	while (!list_empty(&xrt_drv_maps)) {
+		map = list_first_entry_or_null(&xrt_drv_maps, struct xrt_drv_map, list);
+		pr_err("Unloading module with %s still registered\n", XRT_DRVNAME(map->drv));
+		list_del(&map->list);
+		mutex_unlock(&xrt_lib_lock);
+		xrt_drv_unregister_driver(map);
+		vfree(map);
+		mutex_lock(&xrt_lib_lock);
+	}
+
+	mutex_unlock(&xrt_lib_lock);
+
+	class_destroy(xrt_class);
+}
+
+module_init(xrt_lib_init);
+module_exit(xrt_lib_fini);
+
+MODULE_VERSION(XRT_IPLIB_MODULE_VERSION);
+MODULE_AUTHOR("XRT Team <runtime@xilinx.com>");
+MODULE_DESCRIPTION("Xilinx Alveo IP Lib driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/fpga/xrt/lib/main.h b/drivers/fpga/xrt/lib/main.h
new file mode 100644
index 000000000000..f3bfc87ee614
--- /dev/null
+++ b/drivers/fpga/xrt/lib/main.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2021 Xilinx, Inc.
+ *
+ * Authors:
+ *	Cheng Zhen <maxz@xilinx.com>
+ */
+
+#ifndef _XRT_MAIN_H_
+#define _XRT_MAIN_H_
+
+const char *xrt_drv_name(enum xrt_subdev_id id);
+int xrt_drv_get_instance(enum xrt_subdev_id id);
+void xrt_drv_put_instance(enum xrt_subdev_id id, int instance);
+struct xrt_subdev_endpoints *xrt_drv_get_endpoints(enum xrt_subdev_id id);
+
+#endif	/* _XRT_MAIN_H_ */
-- 
2.18.4


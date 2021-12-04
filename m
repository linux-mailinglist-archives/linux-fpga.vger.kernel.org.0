Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE07468172
	for <lists+linux-fpga@lfdr.de>; Sat,  4 Dec 2021 01:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383873AbhLDAoj (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 3 Dec 2021 19:44:39 -0500
Received: from mail-mw2nam08on2045.outbound.protection.outlook.com ([40.107.101.45]:39392
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1354301AbhLDAoj (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 3 Dec 2021 19:44:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h7m6j8iJNFz9Y7kIyORoPNae07wi6pOGRkp1bD4a4qsh6IMMEom6KQZYvw6VtgrgDIYWi1o3zQ/w9aqZ/3Rx+xLQ8aB02fbGocv75fHPMEYYjTS0OSbXHn2NsG1/aK40IrS6zClqgLvqOJL94pCK7EIe1m4PEt9JGq5sX607XHVo/qifY3+Z1bzY7Tqi6dPW3UaYfOPGjtAtGY8HAYng3l3s7mumGw7GhOv8UYspDiWcIRtP08UaLFk/rvmFIDC8R+jBfYRA+Qr4386U84WxYsBcITE6cniq++0HZpXQ/kczWHAj8/jTNxHw49trwUghCcWzQWU2mOnkHUp+NB/eMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jWLCgOntJLI8ZMJ0WIcvcS8gElPjBGa5fgiu/SoYYx4=;
 b=BeMC0/K7VPyvm1A30nHI5qJz+AAE0fD7JyM0urNRD7C64IEOCztQhVsjHoDYaiJKTYV4hA01Slk+u9W/LUla3tlzJaqaEbybReUYjWrppTG1/cy9Rr5TQzCgspPr6N2mX2WRhMwSkxqxVl6uIitF7iY5mWu5ZLfG5r//gqoM53bUe8x4cCqBUPotxvhldJs1Qa1tVLiTU75kXIDOVAIuk8MLuUHBLFAy3QhV/8PNfZaD8+PzxFV2b/IvSk15WJCjxM88uGkIb6Jewtec4qn8osf2LGP/gNJRKvMYATRWSfV/yWsL+J0GQsiCN6hoa2MsZAzlLPVbkpwWa+Xa0rKIRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=infradead.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jWLCgOntJLI8ZMJ0WIcvcS8gElPjBGa5fgiu/SoYYx4=;
 b=ZdgIm0a+hrY5k1j1f6K+pCqrV2jEG3te1IB8UgqAqRe7Uob1xoAu7ZcWOOKuDqgfCe4LMEPZQRb8NBctJfhYXYvhfUWTQb/IS7eMyHikzH2r1n+40rAtH9uCLO/JoQCBbzHcqTIoGZTM1Sm0eHPqNMhdQrwEyuMNdGROinJ/C/k=
Received: from BN9PR03CA0628.namprd03.prod.outlook.com (2603:10b6:408:106::33)
 by CH2PR02MB6183.namprd02.prod.outlook.com (2603:10b6:610:3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.28; Sat, 4 Dec
 2021 00:41:11 +0000
Received: from BN1NAM02FT012.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:106:cafe::5e) by BN9PR03CA0628.outlook.office365.com
 (2603:10b6:408:106::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend
 Transport; Sat, 4 Dec 2021 00:41:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT012.mail.protection.outlook.com (10.13.2.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Sat, 4 Dec 2021 00:41:11 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 3 Dec 2021 16:41:03 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 3 Dec 2021 16:41:03 -0800
Envelope-to: dwmw2@infradead.org,
 mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.72.93] (port=55518 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1mtJ6t-000Ayu-2M; Fri, 03 Dec 2021 16:41:03 -0800
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id 7AD0C60084F; Fri,  3 Dec 2021 16:40:02 -0800 (PST)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>, <dwmw2@infradead.org>,
        Max Zhen <max.zhen@xilinx.com>
Subject: [PATCH V3 XRT Alveo Infrastructure 5/8] fpga: xrt: xrt bus and device
Date:   Fri, 3 Dec 2021 16:39:54 -0800
Message-ID: <20211204003957.1448567-6-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211204003957.1448567-1-lizhi.hou@xilinx.com>
References: <20211204003957.1448567-1-lizhi.hou@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1c36d96-b4d2-4206-ec5c-08d9b6bec535
X-MS-TrafficTypeDiagnostic: CH2PR02MB6183:
X-Microsoft-Antispam-PRVS: <CH2PR02MB618325DF9963F68A8BF03014A16B9@CH2PR02MB6183.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CMaTqkfljna41aAQciXA1a0NZFTpA8KdStSuTPdqhMJP8moWVp9dNoMMpCY6AVHwty6yZVbabAOI0TEEHOY8BMjgDYhm0uGe197/oxmojkZedVejGce2f8mi5uzxtt1eLmvLzN6qkI+dPLtiMBXvYfJG2TBm7+6jUsWmlfVOuBDay1HTR/3gxVqmhLcxw9+FgtQXacrLNK3LXFbhhHCj40JtrbP5VYULt9leUL6YgG8GxLOitYAryaU/F9JoiAP8lp7E5CKnaqC0dNXcs1tZzVb/0l4531kSW0vAZtFTuS2qBJZnNKc8qez1h4XqabuSt1F4TTXcJ0kL9A4cxfwJJHeFhMt7engEDeOmJW0vO87x8Oo1GxYMEpYG+Mie/PYiuBmFArAY9wPlhzA2z+R/EUTT5H9N83NyDjTsYQ9YwW/SWmhSAwdnOm6Gyy/W+p5FSe4dvT0K18vPQRQeVlIGp6GGKhSOhBgnMLGJ8JvoVYR+gzdQc7NHXOY4zqh/0NkNuSth8n8NV6sY2mTAresBEGKBPnYkk65OlgzOU9WRg4N6cPMGEIfAN+S2PpgFYiRcMXz0a9W5RWY2jBxT1U8ecweWp3b4HVMQ88KHpVclGSjhxvY4/8MbRzrHke+kki9y/2lAz1VmGjsUIRfwRfHbnJUDquTipohYpz0C+MRIk6VVART3vOSywkCkSwcTwJ7RMFzV7d5l77WsgD6ynxRpzA==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(36840700001)(46966006)(6916009)(47076005)(26005)(6666004)(356005)(316002)(6266002)(42186006)(5660300002)(70206006)(70586007)(54906003)(7636003)(36860700001)(2616005)(8936002)(36756003)(107886003)(336012)(82310400004)(508600001)(8676002)(1076003)(4326008)(186003)(2906002)(426003)(44832011);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2021 00:41:11.6916
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1c36d96-b4d2-4206-ec5c-08d9b6bec535
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT012.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6183
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

xrt-lib kernel module infrastructure code to add xrt_bus_type, xrt_driver
and xrt_device

Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
Signed-off-by: Max Zhen <max.zhen@xilinx.com>
Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
---
 drivers/fpga/xrt/lib/lib-drv.c | 192 +++++++++++++++++++++++++++++++++
 include/linux/xrt/xdevice.h    | 128 ++++++++++++++++++++++
 2 files changed, 320 insertions(+)
 create mode 100644 include/linux/xrt/xdevice.h

diff --git a/drivers/fpga/xrt/lib/lib-drv.c b/drivers/fpga/xrt/lib/lib-drv.c
index d4597cd4767f..3ad02a7c2aac 100644
--- a/drivers/fpga/xrt/lib/lib-drv.c
+++ b/drivers/fpga/xrt/lib/lib-drv.c
@@ -11,10 +11,195 @@
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/of_device.h>
+#include <linux/xrt/xdevice.h>
 #include "lib-drv.h"
 
 static int xrt_bus_ovcs_id;
 
+#define XRT_DRVNAME(drv)		((drv)->driver.name)
+
+static DEFINE_IDA(xrt_device_ida);
+
+static int xrt_bus_match(struct device *dev, struct device_driver *drv)
+{
+	if (of_driver_match_device(dev, drv))
+		return 1;
+
+	return 0;
+}
+
+static int xrt_bus_probe(struct device *dev)
+{
+	struct xrt_driver *xdrv = to_xrt_drv(dev->driver);
+	struct xrt_device *xdev = to_xrt_dev(dev);
+
+	return xdrv->probe(xdev);
+}
+
+static void xrt_bus_remove(struct device *dev)
+{
+	struct xrt_driver *xdrv = to_xrt_drv(dev->driver);
+	struct xrt_device *xdev = to_xrt_dev(dev);
+
+	if (xdrv->remove)
+		xdrv->remove(xdev);
+}
+
+struct bus_type xrt_bus_type = {
+	.name		= "xrt",
+	.match		= xrt_bus_match,
+	.probe		= xrt_bus_probe,
+	.remove		= xrt_bus_remove,
+};
+
+int xrt_register_driver(struct xrt_driver *drv)
+{
+	const char *drvname = XRT_DRVNAME(drv);
+	int rc = 0;
+
+	/* Initialize dev_t for char dev node. */
+	if (drv->file_ops.xsf_ops.open) {
+		rc = alloc_chrdev_region(&drv->file_ops.xsf_dev_t, 0,
+					 XRT_MAX_DEVICE_NODES, drvname);
+		if (rc) {
+			pr_err("failed to alloc dev minor for %s: %d\n", drvname, rc);
+			return rc;
+		}
+	} else {
+		drv->file_ops.xsf_dev_t = (dev_t)-1;
+	}
+
+	drv->driver.bus = &xrt_bus_type;
+
+	rc = driver_register(&drv->driver);
+	if (rc) {
+		pr_err("register %s xrt driver failed\n", drvname);
+		if (drv->file_ops.xsf_dev_t != (dev_t)-1) {
+			unregister_chrdev_region(drv->file_ops.xsf_dev_t,
+						 XRT_MAX_DEVICE_NODES);
+		}
+		return rc;
+	}
+
+	pr_info("%s registered successfully\n", drvname);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(xrt_register_driver);
+
+void xrt_unregister_driver(struct xrt_driver *drv)
+{
+	driver_unregister(&drv->driver);
+
+	if (drv->file_ops.xsf_dev_t != (dev_t)-1)
+		unregister_chrdev_region(drv->file_ops.xsf_dev_t, XRT_MAX_DEVICE_NODES);
+
+	pr_info("%s unregistered successfully\n", XRT_DRVNAME(drv));
+}
+EXPORT_SYMBOL_GPL(xrt_unregister_driver);
+
+static int xrt_dev_get_instance(void)
+{
+	int ret;
+
+	ret = ida_alloc_range(&xrt_device_ida, 0, 0x7fffffff, GFP_KERNEL);
+	if (ret < 0)
+		return ret;
+
+	return ret;
+}
+
+static void xrt_dev_put_instance(int instance)
+{
+	ida_free(&xrt_device_ida, instance);
+}
+
+static void xrt_device_release(struct device *dev)
+{
+	struct xrt_device *xdev = container_of(dev, struct xrt_device, dev);
+
+	kfree(xdev);
+}
+
+void xrt_device_unregister(struct xrt_device *xdev)
+{
+	if (xdev->state == XRT_DEVICE_STATE_ADDED)
+		device_del(&xdev->dev);
+
+	vfree(xdev->sdev_data);
+	kfree(xdev->resource);
+
+	if (xdev->instance != XRT_INVALID_DEVICE_INST)
+		xrt_dev_put_instance(xdev->instance);
+
+	if (xdev->dev.of_node)
+		of_node_put(xdev->dev.of_node);
+
+	if (xdev->dev.release == xrt_device_release)
+		put_device(&xdev->dev);
+}
+
+struct xrt_device *
+xrt_device_register(struct device *parent, struct device_node *dn,
+		    struct resource *res, u32 res_num,
+		    void *pdata, size_t data_sz)
+{
+	struct xrt_device *xdev = NULL;
+	int ret;
+
+	xdev = kzalloc(sizeof(*xdev), GFP_KERNEL);
+	if (!xdev)
+		return NULL;
+	xdev->instance = XRT_INVALID_DEVICE_INST;
+
+	/* Obtain dev instance number. */
+	ret = xrt_dev_get_instance();
+	if (ret < 0) {
+		dev_err(parent, "failed get instance, ret %d", ret);
+		goto fail;
+	}
+
+	xdev->instance = ret;
+	xdev->name = dn->full_name;
+	device_initialize(&xdev->dev);
+	xdev->dev.release = xrt_device_release;
+	xdev->dev.parent = parent;
+
+	xdev->dev.bus = &xrt_bus_type;
+	dev_set_name(&xdev->dev, "%s.%d", xdev->name, xdev->instance);
+
+	if (res_num > 0) {
+		xdev->num_resources = res_num;
+		xdev->resource = kmemdup(res, sizeof(*res) * res_num, GFP_KERNEL);
+		if (!xdev->resource)
+			goto fail;
+	}
+
+	if (data_sz > 0) {
+		xdev->sdev_data = vzalloc(data_sz);
+		if (!xdev->sdev_data)
+			goto fail;
+
+		memcpy(xdev->sdev_data, pdata, data_sz);
+	}
+
+	ret = device_add(&xdev->dev);
+	if (ret) {
+		dev_err(parent, "failed add device, ret %d", ret);
+		goto fail;
+	}
+	xdev->state = XRT_DEVICE_STATE_ADDED;
+	xdev->dev.of_node = of_node_get(dn);
+
+	return xdev;
+
+fail:
+	xrt_device_unregister(xdev);
+	kfree(xdev);
+
+	return NULL;
+}
+
 static __init int xrt_lib_init(void)
 {
 	int ret;
@@ -25,11 +210,18 @@ static __init int xrt_lib_init(void)
 	if (ret)
 		return ret;
 
+	ret = bus_register(&xrt_bus_type);
+	if (ret) {
+		of_overlay_remove(&xrt_bus_ovcs_id);
+		return ret;
+	}
+
 	return 0;
 }
 
 static __exit void xrt_lib_fini(void)
 {
+	bus_unregister(&xrt_bus_type);
 	of_overlay_remove(&xrt_bus_ovcs_id);
 }
 
diff --git a/include/linux/xrt/xdevice.h b/include/linux/xrt/xdevice.h
new file mode 100644
index 000000000000..0b3fec9ae598
--- /dev/null
+++ b/include/linux/xrt/xdevice.h
@@ -0,0 +1,128 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2021 Xilinx, Inc.
+ *
+ * Authors:
+ *    Lizhi Hou <lizhi.hou@xilinx.com>
+ */
+
+#ifndef _XRT_DEVICE_H_
+#define _XRT_DEVICE_H_
+
+#include <linux/fs.h>
+#include <linux/cdev.h>
+#include <linux/of.h>
+
+#define XRT_MAX_DEVICE_NODES		128
+#define XRT_INVALID_DEVICE_INST		(XRT_MAX_DEVICE_NODES + 1)
+
+enum {
+	XRT_DEVICE_STATE_NONE = 0,
+	XRT_DEVICE_STATE_ADDED
+};
+
+/*
+ * struct xrt_device - represent an xrt device on xrt bus
+ *
+ * dev: generic device interface.
+ * id: id of the xrt device.
+ */
+struct xrt_device {
+	struct device dev;
+	const char *name;
+	u32 instance;
+	u32 state;
+	u32 num_resources;
+	struct resource *resource;
+	void *sdev_data;
+};
+
+/*
+ * If populated by xrt device driver, infra will handle the mechanics of
+ * char device (un)registration.
+ */
+enum xrt_dev_file_mode {
+	/* Infra create cdev, default file name */
+	XRT_DEV_FILE_DEFAULT = 0,
+	/* Infra create cdev, need to encode inst num in file name */
+	XRT_DEV_FILE_MULTI_INST,
+	/* No auto creation of cdev by infra, leaf handles it by itself */
+	XRT_DEV_FILE_NO_AUTO,
+};
+
+struct xrt_dev_file_ops {
+	const struct file_operations xsf_ops;
+	dev_t xsf_dev_t;
+	const char *xsf_dev_name;
+	enum xrt_dev_file_mode xsf_mode;
+};
+
+/*
+ * this struct define the endpoints belong to the same xrt device
+ */
+struct xrt_dev_ep_names {
+	const char *ep_name;
+	const char *compat;
+};
+
+/*
+ * struct xrt_driver - represent a xrt device driver
+ *
+ * driver: driver model structure.
+ * id_table: pointer to table of device IDs the driver is interested in.
+ *           { } member terminated.
+ * probe: mandatory callback for device binding.
+ * remove: callback for device unbinding.
+ */
+struct xrt_driver {
+	struct device_driver driver;
+	struct xrt_dev_file_ops file_ops;
+
+	/*
+	 * Subdev driver callbacks populated by subdev driver.
+	 */
+	int (*probe)(struct xrt_device *xrt_dev);
+	void (*remove)(struct xrt_device *xrt_dev);
+	/*
+	 * If leaf_call is defined, these are called by other leaf drivers.
+	 * Note that root driver may call into leaf_call of a group driver.
+	 */
+	int (*leaf_call)(struct xrt_device *xrt_dev, u32 cmd, void *arg);
+};
+
+#define to_xrt_dev(d) container_of(d, struct xrt_device, dev)
+#define to_xrt_drv(d) container_of(d, struct xrt_driver, driver)
+/*
+ * module_xrt_driver() - Helper macro for drivers that don't do
+ * anything special in module init/exit.
+ */
+#define module_xrt_driver(__xrt_driver)				\
+	module_driver(__xrt_driver, xrt_register_driver,	\
+		      xrt_unregister_driver)
+
+static inline void *xrt_get_drvdata(const struct xrt_device *xdev)
+{
+	return dev_get_drvdata(&xdev->dev);
+}
+
+static inline void xrt_set_drvdata(struct xrt_device *xdev, void *data)
+{
+	dev_set_drvdata(&xdev->dev, data);
+}
+
+static inline void *xrt_get_xdev_data(struct device *dev)
+{
+	struct xrt_device *xdev = to_xrt_dev(dev);
+
+	return xdev->sdev_data;
+}
+
+struct xrt_device *
+xrt_device_register(struct device *parent, struct device_node *dn,
+		    struct resource *res, u32 res_num,
+		    void *pdata, size_t data_sz);
+void xrt_device_unregister(struct xrt_device *xdev);
+int xrt_register_driver(struct xrt_driver *drv);
+void xrt_unregister_driver(struct xrt_driver *drv);
+
+#endif /* _XRT_DEVICE_H_ */
-- 
2.27.0


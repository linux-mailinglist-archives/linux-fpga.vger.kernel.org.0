Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7391B3470FC
	for <lists+linux-fpga@lfdr.de>; Wed, 24 Mar 2021 06:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235331AbhCXFe1 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 24 Mar 2021 01:34:27 -0400
Received: from mail-bn7nam10on2081.outbound.protection.outlook.com ([40.107.92.81]:29857
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235291AbhCXFd6 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 24 Mar 2021 01:33:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=leWqiXdPbgloyjDcg2khxitrozTuzB21cj+aZg/MX+5izZ4lWj1P+IFW5lAtvCTzPp4MqIJPsJ1VyjR6dNbW/8WX+EaXvLeUooJapVT0KH7X4HT+vEUlNpDhZI6TPRS7RlNuEiBS7vrlWJEtxiefbDQKdFwLU1MYFqnWdPUGiBoEZDQQfL9WELTbrLxaHX9h5Tja2f+XdyhEpvy3IIzodJgM7E4UifeAeARmxhOzNiaTuoTNnOYPH4wIu+u1sFZaG0g0IzzMXB5JPf2IZrDAYt++cnV9kEHftrXGFr9zaNTr0PXnpBdCMtgdWOOdmtVrssLOj3TDWgIcn6EPQrhVqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KIsBt/MhaPGjr7kWa2UifsTuyQ1AGGIdYW0xt/FxRgk=;
 b=HAgGmyLPQ7mmZLol+jQkEM07DMC/3jmSGxwDXguW/DgC3/+MwNaoqRs9KZeoF50TfZAX+CzvNnQC5jQMTYtF3zFpxe2MUkErX+xibMwZOdt2H4nZc/HFXmVA+4x0LdwwT1ZJRVIfOxPvWWhBrdleMt8doq8OiZsv3B3WYmvaJ/nVBdULtmnFjCfweYy6QuiSQox25+rT3NhNKKuwzYzZKm3g2fZzy5WM2Z9AbZx8bktvwVLqGvc1Blcq0uK8ISvUKS134yrHZ+vQGuV4pcO1NvPph20B0id53vpERm38BPF8MXb4LOwV+W3wlW7UpzpQx+hwIRdLdN2mK6rcOgPlyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KIsBt/MhaPGjr7kWa2UifsTuyQ1AGGIdYW0xt/FxRgk=;
 b=RLoelE6LWNlC1SS4Vv0qcNQXCdPmgKz+/8LZAIScSoOfSfVKfnrWLGhaIn9TKnuKGpkwOVFH8n2EWochJGzR6hM4vc/odwb8i3oK7U1eDw0Ja89+PbFcZhzEsIwtmfDRwrU9spzPm4MtsKrmn5TgmuCYf26mD6mH4uHWs6CI5w8=
Received: from SN6PR16CA0068.namprd16.prod.outlook.com (2603:10b6:805:ca::45)
 by BY5PR02MB6788.namprd02.prod.outlook.com (2603:10b6:a03:202::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Wed, 24 Mar
 2021 05:33:56 +0000
Received: from SN1NAM02FT025.eop-nam02.prod.protection.outlook.com
 (2603:10b6:805:ca:cafe::6e) by SN6PR16CA0068.outlook.office365.com
 (2603:10b6:805:ca::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24 via Frontend
 Transport; Wed, 24 Mar 2021 05:33:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT025.mail.protection.outlook.com (10.152.72.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3977.25 via Frontend Transport; Wed, 24 Mar 2021 05:33:55 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 23 Mar 2021 22:33:46 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2106.2 via Frontend Transport; Tue, 23 Mar 2021 22:33:46 -0700
Envelope-to: mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.72.212] (port=51034 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1lOw9K-0004Vg-5e; Tue, 23 Mar 2021 22:33:46 -0700
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id 291CD600126; Tue, 23 Mar 2021 22:29:56 -0700 (PDT)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>, Max Zhen <max.zhen@xilinx.com>
Subject: [PATCH V4 XRT Alveo 07/20] fpga: xrt: root driver infrastructure
Date:   Tue, 23 Mar 2021 22:29:34 -0700
Message-ID: <20210324052947.27889-8-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210324052947.27889-1-lizhi.hou@xilinx.com>
References: <20210324052947.27889-1-lizhi.hou@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b75507c1-a08a-4ca3-5997-08d8ee866ae9
X-MS-TrafficTypeDiagnostic: BY5PR02MB6788:
X-Microsoft-Antispam-PRVS: <BY5PR02MB678832BB17073E56507BC6AAA1639@BY5PR02MB6788.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:393;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dRNYcUNAu5jfmhwt35qLJRr4vKTXmFNwLpC4T8ctRl2+iMIGEcfG7taW/7t3qFP3g3i0LKwfs+HTFG90x83ADrOtfJs8ly6UcNusvXtse0gptazkSQjV0gzHnWQCimTqZDMjHWYI++30WocjJzKQPnHGQ8iQUC7btzWp3gehG2+iiR3747DoeSmbxBYP5rhUgJ+OYwPRIhurcWAVoNx5bgLmLNZnxNXHKG3bkOoThtJlIF+uV4D6l27j5+TKpbRKFvhe+hZDDgq4NwE4xDZP/1R3jRSksF3/lgorIJbDcMy32CZv6CO+8yOJhFRhwI5Rb70At2zLPrbguO9mqbYXPqF7oTOeF5S/Br8S0mShvGtsa3NUcFVLdZXadEPQkXe2WH5QBirX2GkfK5BHhQwJXYqVPaOWJieud+zGp97F6fgjQF4Ea7QvBOwU5eZyLSJAdF8aivsJpnJ/PaBk4rJL1W0YeEOaxPAQqOb2mVkXPnGql4UabJ4A4QMv5fV+eTD4J+OM4wel3xLth0s4ACVRsR3VZ2oXTcrfirwqs56MmDYyzSX3IHE7fQL6CiRnC8ZlVpZPE+LYAH1ZJXw7qhxwsDzZ2ZoxmPf4uILrs+MPKBN9BYhEq+oU5UB+hhv7UnCUDa+wpq8mk6yq/N9fUV9sW3ztJEidX1HTsHRmsWghLLo=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(376002)(39860400002)(346002)(396003)(136003)(36840700001)(46966006)(8676002)(36860700001)(82310400003)(478600001)(70206006)(36906005)(44832011)(316002)(5660300002)(26005)(107886003)(30864003)(2906002)(70586007)(6916009)(426003)(83380400001)(336012)(7636003)(8936002)(2616005)(186003)(6666004)(47076005)(1076003)(6266002)(54906003)(4326008)(42186006)(356005)(36756003)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2021 05:33:55.8821
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b75507c1-a08a-4ca3-5997-08d8ee866ae9
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT025.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6788
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Contains common code for all root drivers and handles root calls from
platform drivers. This is part of root driver infrastructure.

Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
Signed-off-by: Max Zhen <max.zhen@xilinx.com>
Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
---
 drivers/fpga/xrt/include/events.h  |  45 +++
 drivers/fpga/xrt/include/xroot.h   | 117 ++++++
 drivers/fpga/xrt/lib/subdev_pool.h |  53 +++
 drivers/fpga/xrt/lib/xroot.c       | 589 +++++++++++++++++++++++++++++
 4 files changed, 804 insertions(+)
 create mode 100644 drivers/fpga/xrt/include/events.h
 create mode 100644 drivers/fpga/xrt/include/xroot.h
 create mode 100644 drivers/fpga/xrt/lib/subdev_pool.h
 create mode 100644 drivers/fpga/xrt/lib/xroot.c

diff --git a/drivers/fpga/xrt/include/events.h b/drivers/fpga/xrt/include/events.h
new file mode 100644
index 000000000000..775171a47c8e
--- /dev/null
+++ b/drivers/fpga/xrt/include/events.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2021 Xilinx, Inc.
+ *
+ * Authors:
+ *	Cheng Zhen <maxz@xilinx.com>
+ */
+
+#ifndef _XRT_EVENTS_H_
+#define _XRT_EVENTS_H_
+
+#include "subdev_id.h"
+
+/*
+ * Event notification.
+ */
+enum xrt_events {
+	XRT_EVENT_TEST = 0, /* for testing */
+	/*
+	 * Events related to specific subdev
+	 * Callback arg: struct xrt_event_arg_subdev
+	 */
+	XRT_EVENT_POST_CREATION,
+	XRT_EVENT_PRE_REMOVAL,
+	/*
+	 * Events related to change of the whole board
+	 * Callback arg: <none>
+	 */
+	XRT_EVENT_PRE_HOT_RESET,
+	XRT_EVENT_POST_HOT_RESET,
+	XRT_EVENT_PRE_GATE_CLOSE,
+	XRT_EVENT_POST_GATE_OPEN,
+};
+
+struct xrt_event_arg_subdev {
+	enum xrt_subdev_id xevt_subdev_id;
+	int xevt_subdev_instance;
+};
+
+struct xrt_event {
+	enum xrt_events xe_evt;
+	struct xrt_event_arg_subdev xe_subdev;
+};
+
+#endif	/* _XRT_EVENTS_H_ */
diff --git a/drivers/fpga/xrt/include/xroot.h b/drivers/fpga/xrt/include/xroot.h
new file mode 100644
index 000000000000..91c0aeb30bf8
--- /dev/null
+++ b/drivers/fpga/xrt/include/xroot.h
@@ -0,0 +1,117 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2021 Xilinx, Inc.
+ *
+ * Authors:
+ *	Cheng Zhen <maxz@xilinx.com>
+ */
+
+#ifndef _XRT_ROOT_H_
+#define _XRT_ROOT_H_
+
+#include <linux/platform_device.h>
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
+ * Root calls.
+ */
+enum xrt_root_cmd {
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
+	XRT_ROOT_EVENT_SYNC,
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
+struct xrt_root_get_leaf {
+	struct platform_device *xpigl_caller_pdev;
+	xrt_subdev_match_t xpigl_match_cb;
+	void *xpigl_match_arg;
+	struct platform_device *xpigl_tgt_pdev;
+};
+
+struct xrt_root_put_leaf {
+	struct platform_device *xpipl_caller_pdev;
+	struct platform_device *xpipl_tgt_pdev;
+};
+
+struct xrt_root_lookup_group {
+	struct platform_device *xpilp_pdev; /* caller's pdev */
+	xrt_subdev_match_t xpilp_match_cb;
+	void *xpilp_match_arg;
+	int xpilp_grp_inst;
+};
+
+struct xrt_root_get_holders {
+	struct platform_device *xpigh_pdev; /* caller's pdev */
+	char *xpigh_holder_buf;
+	size_t xpigh_holder_buf_len;
+};
+
+struct xrt_root_get_res {
+	struct resource *xpigr_res;
+};
+
+struct xrt_root_get_id {
+	unsigned short  xpigi_vendor_id;
+	unsigned short  xpigi_device_id;
+	unsigned short  xpigi_sub_vendor_id;
+	unsigned short  xpigi_sub_device_id;
+};
+
+struct xrt_root_hwmon {
+	bool xpih_register;
+	const char *xpih_name;
+	void *xpih_drvdata;
+	const struct attribute_group **xpih_groups;
+	struct device *xpih_hwmon_dev;
+};
+
+/*
+ * Callback for leaf to make a root request. Arguments are: parent device, parent cookie, req,
+ * and arg.
+ */
+typedef int (*xrt_subdev_root_cb_t)(struct device *, void *, u32, void *);
+int xrt_subdev_root_request(struct platform_device *self, u32 cmd, void *arg);
+
+/*
+ * Defines physical function (MPF / UPF) specific operations
+ * needed in common root driver.
+ */
+struct xroot_physical_function_callback {
+	void (*xpc_hot_reset)(struct pci_dev *pdev);
+};
+
+int xroot_probe(struct pci_dev *pdev, struct xroot_physical_function_callback *cb, void **root);
+void xroot_remove(void *root);
+bool xroot_wait_for_bringup(void *root);
+int xroot_add_vsec_node(void *root, char *dtb);
+int xroot_create_group(void *xr, char *dtb);
+int xroot_add_simple_node(void *root, char *dtb, const char *endpoint);
+void xroot_broadcast(void *root, enum xrt_events evt);
+
+#endif	/* _XRT_ROOT_H_ */
diff --git a/drivers/fpga/xrt/lib/subdev_pool.h b/drivers/fpga/xrt/lib/subdev_pool.h
new file mode 100644
index 000000000000..09d148e4e7ea
--- /dev/null
+++ b/drivers/fpga/xrt/lib/subdev_pool.h
@@ -0,0 +1,53 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2021 Xilinx, Inc.
+ *
+ * Authors:
+ *	Cheng Zhen <maxz@xilinx.com>
+ */
+
+#ifndef _XRT_SUBDEV_POOL_H_
+#define _XRT_SUBDEV_POOL_H_
+
+#include <linux/device.h>
+#include <linux/mutex.h>
+#include "xroot.h"
+
+/*
+ * The struct xrt_subdev_pool manages a list of xrt_subdevs for root and group drivers.
+ */
+struct xrt_subdev_pool {
+	struct list_head xsp_dev_list;
+	struct device *xsp_owner;
+	struct mutex xsp_lock; /* pool lock */
+	bool xsp_closing;
+};
+
+/*
+ * Subdev pool helper functions for root and group drivers only.
+ */
+void xrt_subdev_pool_init(struct device *dev,
+			  struct xrt_subdev_pool *spool);
+void xrt_subdev_pool_fini(struct xrt_subdev_pool *spool);
+int xrt_subdev_pool_get(struct xrt_subdev_pool *spool,
+			xrt_subdev_match_t match,
+			void *arg, struct device *holder_dev,
+			struct platform_device **pdevp);
+int xrt_subdev_pool_put(struct xrt_subdev_pool *spool,
+			struct platform_device *pdev,
+			struct device *holder_dev);
+int xrt_subdev_pool_add(struct xrt_subdev_pool *spool,
+			enum xrt_subdev_id id, xrt_subdev_root_cb_t pcb,
+			void *pcb_arg, char *dtb);
+int xrt_subdev_pool_del(struct xrt_subdev_pool *spool,
+			enum xrt_subdev_id id, int instance);
+ssize_t xrt_subdev_pool_get_holders(struct xrt_subdev_pool *spool,
+				    struct platform_device *pdev,
+				    char *buf, size_t len);
+
+void xrt_subdev_pool_trigger_event(struct xrt_subdev_pool *spool,
+				   enum xrt_events evt);
+void xrt_subdev_pool_handle_event(struct xrt_subdev_pool *spool,
+				  struct xrt_event *evt);
+
+#endif	/* _XRT_SUBDEV_POOL_H_ */
diff --git a/drivers/fpga/xrt/lib/xroot.c b/drivers/fpga/xrt/lib/xroot.c
new file mode 100644
index 000000000000..03407272650f
--- /dev/null
+++ b/drivers/fpga/xrt/lib/xroot.c
@@ -0,0 +1,589 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx Alveo FPGA Root Functions
+ *
+ * Copyright (C) 2020-2021 Xilinx, Inc.
+ *
+ * Authors:
+ *	Cheng Zhen <maxz@xilinx.com>
+ */
+
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/hwmon.h>
+#include "xroot.h"
+#include "subdev_pool.h"
+#include "group.h"
+#include "metadata.h"
+
+#define XROOT_PDEV(xr)		((xr)->pdev)
+#define XROOT_DEV(xr)		(&(XROOT_PDEV(xr)->dev))
+#define xroot_err(xr, fmt, args...)	\
+	dev_err(XROOT_DEV(xr), "%s: " fmt, __func__, ##args)
+#define xroot_warn(xr, fmt, args...)	\
+	dev_warn(XROOT_DEV(xr), "%s: " fmt, __func__, ##args)
+#define xroot_info(xr, fmt, args...)	\
+	dev_info(XROOT_DEV(xr), "%s: " fmt, __func__, ##args)
+#define xroot_dbg(xr, fmt, args...)	\
+	dev_dbg(XROOT_DEV(xr), "%s: " fmt, __func__, ##args)
+
+#define XRT_VSEC_ID		0x20
+
+#define XROOT_GROUP_FIRST		(-1)
+#define XROOT_GROUP_LAST		(-2)
+
+static int xroot_root_cb(struct device *, void *, u32, void *);
+
+struct xroot_evt {
+	struct list_head list;
+	struct xrt_event evt;
+	struct completion comp;
+	bool async;
+};
+
+struct xroot_events {
+	struct mutex evt_lock; /* event lock */
+	struct list_head evt_list;
+	struct work_struct evt_work;
+};
+
+struct xroot_groups {
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
+	struct xroot_groups groups;
+	struct xroot_physical_function_callback pf_cb;
+};
+
+struct xroot_group_match_arg {
+	enum xrt_subdev_id id;
+	int instance;
+};
+
+static bool xroot_group_match(enum xrt_subdev_id id, struct platform_device *pdev, void *arg)
+{
+	struct xroot_group_match_arg *a = (struct xroot_group_match_arg *)arg;
+
+	/* pdev->id is the instance of the subdev. */
+	return id == a->id && pdev->id == a->instance;
+}
+
+static int xroot_get_group(struct xroot *xr, int instance, struct platform_device **grpp)
+{
+	int rc = 0;
+	struct xrt_subdev_pool *grps = &xr->groups.pool;
+	struct device *dev = DEV(xr->pdev);
+	struct xroot_group_match_arg arg = { XRT_SUBDEV_GRP, instance };
+
+	if (instance == XROOT_GROUP_LAST) {
+		rc = xrt_subdev_pool_get(grps, XRT_SUBDEV_MATCH_NEXT,
+					 *grpp, dev, grpp);
+	} else if (instance == XROOT_GROUP_FIRST) {
+		rc = xrt_subdev_pool_get(grps, XRT_SUBDEV_MATCH_PREV,
+					 *grpp, dev, grpp);
+	} else {
+		rc = xrt_subdev_pool_get(grps, xroot_group_match,
+					 &arg, dev, grpp);
+	}
+
+	if (rc && rc != -ENOENT)
+		xroot_err(xr, "failed to hold group %d: %d", instance, rc);
+	return rc;
+}
+
+static void xroot_put_group(struct xroot *xr, struct platform_device *grp)
+{
+	int inst = grp->id;
+	int rc = xrt_subdev_pool_put(&xr->groups.pool, grp, DEV(xr->pdev));
+
+	if (rc)
+		xroot_err(xr, "failed to release group %d: %d", inst, rc);
+}
+
+static int xroot_trigger_event(struct xroot *xr, struct xrt_event *e, bool async)
+{
+	struct xroot_evt *enew = vzalloc(sizeof(*enew));
+
+	if (!enew)
+		return -ENOMEM;
+
+	enew->evt = *e;
+	enew->async = async;
+	init_completion(&enew->comp);
+
+	mutex_lock(&xr->events.evt_lock);
+	list_add(&enew->list, &xr->events.evt_list);
+	mutex_unlock(&xr->events.evt_lock);
+
+	schedule_work(&xr->events.evt_work);
+
+	if (async)
+		return 0;
+
+	wait_for_completion(&enew->comp);
+	vfree(enew);
+	return 0;
+}
+
+static void
+xroot_group_trigger_event(struct xroot *xr, int inst, enum xrt_events e)
+{
+	int ret;
+	struct platform_device *pdev = NULL;
+	struct xrt_event evt = { 0 };
+
+	WARN_ON(inst < 0);
+	/* Only triggers subdev specific events. */
+	if (e != XRT_EVENT_POST_CREATION && e != XRT_EVENT_PRE_REMOVAL) {
+		xroot_err(xr, "invalid event %d", e);
+		return;
+	}
+
+	ret = xroot_get_group(xr, inst, &pdev);
+	if (ret)
+		return;
+
+	/* Triggers event for children, first. */
+	xleaf_call(pdev, XRT_GROUP_TRIGGER_EVENT, (void *)(uintptr_t)e);
+
+	/* Triggers event for itself. */
+	evt.xe_evt = e;
+	evt.xe_subdev.xevt_subdev_id = XRT_SUBDEV_GRP;
+	evt.xe_subdev.xevt_subdev_instance = inst;
+	xroot_trigger_event(xr, &evt, false);
+
+	xroot_put_group(xr, pdev);
+}
+
+int xroot_create_group(void *root, char *dtb)
+{
+	struct xroot *xr = (struct xroot *)root;
+	int ret;
+
+	atomic_inc(&xr->groups.bringup_pending);
+	ret = xrt_subdev_pool_add(&xr->groups.pool, XRT_SUBDEV_GRP, xroot_root_cb, xr, dtb);
+	if (ret >= 0) {
+		schedule_work(&xr->groups.bringup_work);
+	} else {
+		atomic_dec(&xr->groups.bringup_pending);
+		atomic_inc(&xr->groups.bringup_failed);
+		xroot_err(xr, "failed to create group: %d", ret);
+	}
+	return ret;
+}
+EXPORT_SYMBOL_GPL(xroot_create_group);
+
+static int xroot_destroy_single_group(struct xroot *xr, int instance)
+{
+	struct platform_device *pdev = NULL;
+	int ret;
+
+	WARN_ON(instance < 0);
+	ret = xroot_get_group(xr, instance, &pdev);
+	if (ret)
+		return ret;
+
+	xroot_group_trigger_event(xr, instance, XRT_EVENT_PRE_REMOVAL);
+
+	/* Now tear down all children in this group. */
+	ret = xleaf_call(pdev, XRT_GROUP_FINI_CHILDREN, NULL);
+	xroot_put_group(xr, pdev);
+	if (!ret)
+		ret = xrt_subdev_pool_del(&xr->groups.pool, XRT_SUBDEV_GRP, instance);
+
+	return ret;
+}
+
+static int xroot_destroy_group(struct xroot *xr, int instance)
+{
+	struct platform_device *target = NULL;
+	struct platform_device *deps = NULL;
+	int ret;
+
+	WARN_ON(instance < 0);
+	/*
+	 * Make sure target group exists and can't go away before
+	 * we remove it's dependents
+	 */
+	ret = xroot_get_group(xr, instance, &target);
+	if (ret)
+		return ret;
+
+	/*
+	 * Remove all groups depend on target one.
+	 * Assuming subdevs in higher group ID can depend on ones in
+	 * lower ID groups, we remove them in the reservse order.
+	 */
+	while (xroot_get_group(xr, XROOT_GROUP_LAST, &deps) != -ENOENT) {
+		int inst = deps->id;
+
+		xroot_put_group(xr, deps);
+		/* Reached the target group instance, stop here. */
+		if (instance == inst)
+			break;
+		xroot_destroy_single_group(xr, inst);
+		deps = NULL;
+	}
+
+	/* Now we can remove the target group. */
+	xroot_put_group(xr, target);
+	return xroot_destroy_single_group(xr, instance);
+}
+
+static int xroot_lookup_group(struct xroot *xr,
+			      struct xrt_root_lookup_group *arg)
+{
+	int rc = -ENOENT;
+	struct platform_device *grp = NULL;
+
+	while (rc < 0 && xroot_get_group(xr, XROOT_GROUP_LAST, &grp) != -ENOENT) {
+		if (arg->xpilp_match_cb(XRT_SUBDEV_GRP, grp, arg->xpilp_match_arg))
+			rc = grp->id;
+		xroot_put_group(xr, grp);
+	}
+	return rc;
+}
+
+static void xroot_event_work(struct work_struct *work)
+{
+	struct xroot_evt *tmp;
+	struct xroot *xr = container_of(work, struct xroot, events.evt_work);
+
+	mutex_lock(&xr->events.evt_lock);
+	while (!list_empty(&xr->events.evt_list)) {
+		tmp = list_first_entry(&xr->events.evt_list, struct xroot_evt, list);
+		list_del(&tmp->list);
+		mutex_unlock(&xr->events.evt_lock);
+
+		xrt_subdev_pool_handle_event(&xr->groups.pool, &tmp->evt);
+
+		if (tmp->async)
+			vfree(tmp);
+		else
+			complete(&tmp->comp);
+
+		mutex_lock(&xr->events.evt_lock);
+	}
+	mutex_unlock(&xr->events.evt_lock);
+}
+
+static void xroot_event_init(struct xroot *xr)
+{
+	INIT_LIST_HEAD(&xr->events.evt_list);
+	mutex_init(&xr->events.evt_lock);
+	INIT_WORK(&xr->events.evt_work, xroot_event_work);
+}
+
+static void xroot_event_fini(struct xroot *xr)
+{
+	flush_scheduled_work();
+	WARN_ON(!list_empty(&xr->events.evt_list));
+}
+
+static int xroot_get_leaf(struct xroot *xr, struct xrt_root_get_leaf *arg)
+{
+	int rc = -ENOENT;
+	struct platform_device *grp = NULL;
+
+	while (rc && xroot_get_group(xr, XROOT_GROUP_LAST, &grp) != -ENOENT) {
+		rc = xleaf_call(grp, XRT_GROUP_GET_LEAF, arg);
+		xroot_put_group(xr, grp);
+	}
+	return rc;
+}
+
+static int xroot_put_leaf(struct xroot *xr, struct xrt_root_put_leaf *arg)
+{
+	int rc = -ENOENT;
+	struct platform_device *grp = NULL;
+
+	while (rc && xroot_get_group(xr, XROOT_GROUP_LAST, &grp) != -ENOENT) {
+		rc = xleaf_call(grp, XRT_GROUP_PUT_LEAF, arg);
+		xroot_put_group(xr, grp);
+	}
+	return rc;
+}
+
+static int xroot_root_cb(struct device *dev, void *parg, enum xrt_root_cmd cmd, void *arg)
+{
+	struct xroot *xr = (struct xroot *)parg;
+	int rc = 0;
+
+	switch (cmd) {
+	/* Leaf actions. */
+	case XRT_ROOT_GET_LEAF: {
+		struct xrt_root_get_leaf *getleaf = (struct xrt_root_get_leaf *)arg;
+
+		rc = xroot_get_leaf(xr, getleaf);
+		break;
+	}
+	case XRT_ROOT_PUT_LEAF: {
+		struct xrt_root_put_leaf *putleaf = (struct xrt_root_put_leaf *)arg;
+
+		rc = xroot_put_leaf(xr, putleaf);
+		break;
+	}
+	case XRT_ROOT_GET_LEAF_HOLDERS: {
+		struct xrt_root_get_holders *holders = (struct xrt_root_get_holders *)arg;
+
+		rc = xrt_subdev_pool_get_holders(&xr->groups.pool,
+						 holders->xpigh_pdev,
+						 holders->xpigh_holder_buf,
+						 holders->xpigh_holder_buf_len);
+		break;
+	}
+
+	/* Group actions. */
+	case XRT_ROOT_CREATE_GROUP:
+		rc = xroot_create_group(xr, (char *)arg);
+		break;
+	case XRT_ROOT_REMOVE_GROUP:
+		rc = xroot_destroy_group(xr, (int)(uintptr_t)arg);
+		break;
+	case XRT_ROOT_LOOKUP_GROUP: {
+		struct xrt_root_lookup_group *getgrp = (struct xrt_root_lookup_group *)arg;
+
+		rc = xroot_lookup_group(xr, getgrp);
+		break;
+	}
+	case XRT_ROOT_WAIT_GROUP_BRINGUP:
+		rc = xroot_wait_for_bringup(xr) ? 0 : -EINVAL;
+		break;
+
+	/* Event actions. */
+	case XRT_ROOT_EVENT_SYNC:
+	case XRT_ROOT_EVENT_ASYNC: {
+		bool async = (cmd == XRT_ROOT_EVENT_ASYNC);
+		struct xrt_event *evt = (struct xrt_event *)arg;
+
+		rc = xroot_trigger_event(xr, evt, async);
+		break;
+	}
+
+	/* Device info. */
+	case XRT_ROOT_GET_RESOURCE: {
+		struct xrt_root_get_res *res = (struct xrt_root_get_res *)arg;
+
+		res->xpigr_res = xr->pdev->resource;
+		break;
+	}
+	case XRT_ROOT_GET_ID: {
+		struct xrt_root_get_id *id = (struct xrt_root_get_id *)arg;
+
+		id->xpigi_vendor_id = xr->pdev->vendor;
+		id->xpigi_device_id = xr->pdev->device;
+		id->xpigi_sub_vendor_id = xr->pdev->subsystem_vendor;
+		id->xpigi_sub_device_id = xr->pdev->subsystem_device;
+		break;
+	}
+
+	/* MISC generic PCIE driver functions. */
+	case XRT_ROOT_HOT_RESET: {
+		xr->pf_cb.xpc_hot_reset(xr->pdev);
+		break;
+	}
+	case XRT_ROOT_HWMON: {
+		struct xrt_root_hwmon *hwmon = (struct xrt_root_hwmon *)arg;
+
+		if (hwmon->xpih_register) {
+			hwmon->xpih_hwmon_dev =
+				hwmon_device_register_with_info(DEV(xr->pdev),
+								hwmon->xpih_name,
+								hwmon->xpih_drvdata,
+								NULL,
+								hwmon->xpih_groups);
+		} else {
+			hwmon_device_unregister(hwmon->xpih_hwmon_dev);
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
+static void xroot_bringup_group_work(struct work_struct *work)
+{
+	struct platform_device *pdev = NULL;
+	struct xroot *xr = container_of(work, struct xroot, groups.bringup_work);
+
+	while (xroot_get_group(xr, XROOT_GROUP_FIRST, &pdev) != -ENOENT) {
+		int r, i;
+
+		i = pdev->id;
+		r = xleaf_call(pdev, XRT_GROUP_INIT_CHILDREN, NULL);
+		xroot_put_group(xr, pdev);
+		if (r == -EEXIST)
+			continue; /* Already brough up, nothing to do. */
+		if (r)
+			atomic_inc(&xr->groups.bringup_failed);
+
+		xroot_group_trigger_event(xr, i, XRT_EVENT_POST_CREATION);
+
+		if (atomic_dec_and_test(&xr->groups.bringup_pending))
+			complete(&xr->groups.bringup_comp);
+	}
+}
+
+static void xroot_groups_init(struct xroot *xr)
+{
+	xrt_subdev_pool_init(DEV(xr->pdev), &xr->groups.pool);
+	INIT_WORK(&xr->groups.bringup_work, xroot_bringup_group_work);
+	atomic_set(&xr->groups.bringup_pending, 0);
+	atomic_set(&xr->groups.bringup_failed, 0);
+	init_completion(&xr->groups.bringup_comp);
+}
+
+static void xroot_groups_fini(struct xroot *xr)
+{
+	flush_scheduled_work();
+	xrt_subdev_pool_fini(&xr->groups.pool);
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
+	while ((cap = pci_find_next_ext_capability(xr->pdev, cap, PCI_EXT_CAP_ID_VNDR))) {
+		pci_read_config_dword(xr->pdev, cap + PCI_VNDR_HEADER, &header);
+		if (PCI_VNDR_HEADER_ID(header) == XRT_VSEC_ID)
+			break;
+	}
+	if (!cap) {
+		xroot_info(xr, "No Vendor Specific Capability.");
+		return -ENOENT;
+	}
+
+	if (pci_read_config_dword(xr->pdev, cap + 8, &off_low) ||
+	    pci_read_config_dword(xr->pdev, cap + 12, &off_high)) {
+		xroot_err(xr, "pci_read vendor specific failed.");
+		return -EINVAL;
+	}
+
+	ep.ep_name = XRT_MD_NODE_VSEC;
+	ret = xrt_md_add_endpoint(dev, dtb, &ep);
+	if (ret) {
+		xroot_err(xr, "add vsec metadata failed, ret %d", ret);
+		goto failed;
+	}
+
+	vsec_bar = cpu_to_be32(off_low & 0xf);
+	ret = xrt_md_set_prop(dev, dtb, XRT_MD_NODE_VSEC, NULL,
+			      XRT_MD_PROP_BAR_IDX, &vsec_bar, sizeof(vsec_bar));
+	if (ret) {
+		xroot_err(xr, "add vsec bar idx failed, ret %d", ret);
+		goto failed;
+	}
+
+	vsec_off = cpu_to_be64(((u64)off_high << 32) | (off_low & ~0xfU));
+	ret = xrt_md_set_prop(dev, dtb, XRT_MD_NODE_VSEC, NULL,
+			      XRT_MD_PROP_OFFSET, &vsec_off, sizeof(vsec_off));
+	if (ret) {
+		xroot_err(xr, "add vsec offset failed, ret %d", ret);
+		goto failed;
+	}
+
+failed:
+	return ret;
+}
+EXPORT_SYMBOL_GPL(xroot_add_vsec_node);
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
+EXPORT_SYMBOL_GPL(xroot_add_simple_node);
+
+bool xroot_wait_for_bringup(void *root)
+{
+	struct xroot *xr = (struct xroot *)root;
+
+	wait_for_completion(&xr->groups.bringup_comp);
+	return atomic_read(&xr->groups.bringup_failed) == 0;
+}
+EXPORT_SYMBOL_GPL(xroot_wait_for_bringup);
+
+int xroot_probe(struct pci_dev *pdev, struct xroot_physical_function_callback *cb, void **root)
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
+	xr->pf_cb = *cb;
+	xroot_groups_init(xr);
+	xroot_event_init(xr);
+
+	*root = xr;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(xroot_probe);
+
+void xroot_remove(void *root)
+{
+	struct xroot *xr = (struct xroot *)root;
+	struct platform_device *grp = NULL;
+
+	xroot_info(xr, "leaving...");
+
+	if (xroot_get_group(xr, XROOT_GROUP_FIRST, &grp) == 0) {
+		int instance = grp->id;
+
+		xroot_put_group(xr, grp);
+		xroot_destroy_group(xr, instance);
+	}
+
+	xroot_event_fini(xr);
+	xroot_groups_fini(xr);
+}
+EXPORT_SYMBOL_GPL(xroot_remove);
+
+void xroot_broadcast(void *root, enum xrt_events evt)
+{
+	struct xroot *xr = (struct xroot *)root;
+	struct xrt_event e = { 0 };
+
+	/* Root pf driver only broadcasts below two events. */
+	if (evt != XRT_EVENT_POST_CREATION && evt != XRT_EVENT_PRE_REMOVAL) {
+		xroot_info(xr, "invalid event %d", evt);
+		return;
+	}
+
+	e.xe_evt = evt;
+	e.xe_subdev.xevt_subdev_id = XRT_ROOT;
+	e.xe_subdev.xevt_subdev_instance = 0;
+	xroot_trigger_event(xr, &e, false);
+}
+EXPORT_SYMBOL_GPL(xroot_broadcast);
-- 
2.27.0


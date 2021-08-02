Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21DEA3DDD25
	for <lists+linux-fpga@lfdr.de>; Mon,  2 Aug 2021 18:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232483AbhHBQHh (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 2 Aug 2021 12:07:37 -0400
Received: from mail-dm6nam11on2056.outbound.protection.outlook.com ([40.107.223.56]:33792
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232561AbhHBQHg (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 2 Aug 2021 12:07:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZUlCfXQ7xaFJl1eC6VIfMd+s7tULf4hNJXh4JPPXi5CR5F5xeJm5v8IjKFToC4o+4ePJSxmlFW34MupM3osdQoRpY/Ir9Pav85SV0ukvQnFbzZChtdBhmFCSbr8ll/+/RJKaBONAFyImnEajn0aIbyEowtfiHCtB97vYw9k94JLGtzaNgROfAsmvxbgoDvriUp1tBOx6G3r226UD2ca9LjmawYijDJvKh2le4YcBIBJC+8RdLR0LFhOdQOOUsrHaEDXIHyQ9pqaIYGAbKhy00hAG85ikIvsMpMV1hNQVoD9r4vZBVcr1lEkOjFXxAgqaHdLDIWgUMfvJVIYHBuS0Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qzCsO0sMDoeXy8kiQqfM+uww8nfblvLHmKuT2n9JA+o=;
 b=E4WGwaPctTDrqyfdZSyvgyWZMx42VEH4aKm76ug/N7fUefBytiZjZuZCmQjvzJHhaSeNGTqLo5AptaLejbfg231Z5Wy3NM7/mHugr5dPAbnU35OhRi7xC0CvmfDyXj0zSKpP75YwBqhrz8i/EVJ5wJYI3N0eCuo9cptvqJuuIbkxcwHUk96Nzk4tbBcTWrht8B8s2LIUhwAL/38Fw4GdUdPOz7d8LwkjxlWM5IjQgSyABP2w9OXshXspXzKjZ8xHKR1g9r3d4bS1pa2OrQJOd+THJhB6BStnCDWFOj8m/VJj7yK5PAu0za0B8r+dg7TSF2rUQ4tU4JTbKO0y9MGTPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qzCsO0sMDoeXy8kiQqfM+uww8nfblvLHmKuT2n9JA+o=;
 b=pyuOltG3aPim7CwpP3WeYSKTHR0/s67ZwUfuwf+0aWE1wC8xrtJdgeJ7SYY6LXPJr+I8jbFF/MILYJo1PIntwIGxXJMcyeHr20z7O4rwoeZC6IcthuPU6FBrqm7TZwqbhJQvbEJaTlRUpOO3JW97HR8fCAYthq14kqgacyOWSHU=
Received: from DM5PR08CA0039.namprd08.prod.outlook.com (2603:10b6:4:60::28) by
 DM6PR02MB6299.namprd02.prod.outlook.com (2603:10b6:5:1d5::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4373.21; Mon, 2 Aug 2021 16:07:22 +0000
Received: from DM3NAM02FT032.eop-nam02.prod.protection.outlook.com
 (2603:10b6:4:60:cafe::24) by DM5PR08CA0039.outlook.office365.com
 (2603:10b6:4:60::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend
 Transport; Mon, 2 Aug 2021 16:07:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT032.mail.protection.outlook.com (10.13.5.65) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4373.18 via Frontend Transport; Mon, 2 Aug 2021 16:07:22 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 2 Aug 2021 09:07:18 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Mon, 2 Aug 2021 09:07:18 -0700
Envelope-to: mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [10.23.145.232] (port=49066 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1mAaTG-0005HV-CY; Mon, 02 Aug 2021 09:07:18 -0700
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id D0823601B32; Mon,  2 Aug 2021 09:05:30 -0700 (PDT)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>, Max Zhen <max.zhen@xilinx.com>
Subject: [PATCH V9 XRT Alveo 07/14] fpga: xrt: root driver infrastructure
Date:   Mon, 2 Aug 2021 09:05:14 -0700
Message-ID: <20210802160521.331031-8-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210802160521.331031-1-lizhi.hou@xilinx.com>
References: <20210802160521.331031-1-lizhi.hou@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee42774c-a0ad-42da-c45c-08d955cf9cea
X-MS-TrafficTypeDiagnostic: DM6PR02MB6299:
X-Microsoft-Antispam-PRVS: <DM6PR02MB629936B46B47285E30335519A1EF9@DM6PR02MB6299.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:454;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tDoyNxvvoJcuHSKKNL6qxfFKiyZ2asaGCztUonPFqMGrGVGMxWKPTNIywWewBd1aWZgeXE8j5DGDTuivYAex4MQ/effVjwE3zhVnkstYbY6II8Y+w+/ip0Y1Gv7HfU9IoqLZUoeiTSvlQJe2IWt6bHqHTPJ4cgzvNJ2oAo+NgeLlcKsLQprBo4Y0b9NQfqDvIwsKnSMvA/BdKlz45qYruc/E8SDZgeCRczOaEyGLrE3BTFQHjORqQ/jGphjFZJWlnSfIIgv0vndE/Jlkr9CrBgIoumgbLNiiBf2M8B2mwWjV6jCAwNVhTRoFN6LP03QB+XpqYQnR7AHjWFh00/5hEv0Txrah2WKqexcaNG64hID0m/K6li5Ger0d16Gb41ZwqriIcx7yrnixuPF4mOesguomB+k4VONxSQ1yFmYH2CjL+xPz3oTCyD6zro8mW8mXXK3zHUWuPL2v4AQ8wJx1Ea8WABn6wnMhATRAPtFvVNWP/8gwykInDKPaaKoLE/MZR8+PFyL1aCCT7JhESKwDRW1lBwg6wmz3wx2lZxoREeibY8Z06DkZfjRrfXYVh/M4pWgidWFDb1SHiirpDtFVhIA6qmfQa74iM0Ir6rmwVuqj4mat/CKse7wJu5kcd6tUGFPQTDJw4BEaWkLvEhAfqUgarUG5JN9sivzIBBYvTJ9jqkb5xBnJfb7jF2kZ8CRSY6egmEM4o6RkU9NB6qaJnQ==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(396003)(376002)(39860400002)(136003)(346002)(36840700001)(46966006)(36860700001)(6916009)(82310400003)(2906002)(44832011)(83380400001)(30864003)(82740400003)(7636003)(36906005)(8936002)(426003)(1076003)(47076005)(70586007)(478600001)(36756003)(5660300002)(8676002)(2616005)(186003)(26005)(6266002)(107886003)(6666004)(356005)(70206006)(4326008)(42186006)(54906003)(316002)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2021 16:07:22.7948
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee42774c-a0ad-42da-c45c-08d955cf9cea
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT032.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6299
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Contains common code for all root drivers and handles root calls from
xrt drivers. This is part of root driver infrastructure.

Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
Signed-off-by: Max Zhen <max.zhen@xilinx.com>
Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
Reviewed-by: Tom Rix <trix@redhat.com>
---
 drivers/fpga/xrt/include/events.h  |  45 +++
 drivers/fpga/xrt/include/xroot.h   | 117 +++++++
 drivers/fpga/xrt/lib/subdev_pool.h |  53 +++
 drivers/fpga/xrt/lib/xroot.c       | 536 +++++++++++++++++++++++++++++
 4 files changed, 751 insertions(+)
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
index 000000000000..56461bcb07a9
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
+#include "xdevice.h"
+#include "subdev_id.h"
+#include "events.h"
+
+typedef bool (*xrt_subdev_match_t)(enum xrt_subdev_id, struct xrt_device *, void *);
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
+	struct xrt_device *xpigl_caller_xdev;
+	xrt_subdev_match_t xpigl_match_cb;
+	void *xpigl_match_arg;
+	struct xrt_device *xpigl_tgt_xdev;
+};
+
+struct xrt_root_put_leaf {
+	struct xrt_device *xpipl_caller_xdev;
+	struct xrt_device *xpipl_tgt_xdev;
+};
+
+struct xrt_root_lookup_group {
+	struct xrt_device *xpilp_xdev; /* caller's xdev */
+	xrt_subdev_match_t xpilp_match_cb;
+	void *xpilp_match_arg;
+	int xpilp_grp_inst;
+};
+
+struct xrt_root_get_holders {
+	struct xrt_device *xpigh_xdev; /* caller's xdev */
+	char *xpigh_holder_buf;
+	size_t xpigh_holder_buf_len;
+};
+
+struct xrt_root_get_res {
+	u32 xpigr_region_id;
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
+int xrt_subdev_root_request(struct xrt_device *self, u32 cmd, void *arg);
+
+/*
+ * Defines physical function (MPF / UPF) specific operations
+ * needed in common root driver.
+ */
+struct xroot_physical_function_callback {
+	void (*xpc_get_id)(struct device *dev, struct xrt_root_get_id *rid);
+	int (*xpc_get_resource)(struct device *dev, struct xrt_root_get_res *res);
+	void (*xpc_hot_reset)(struct device *dev);
+};
+
+int xroot_probe(struct device *dev, struct xroot_physical_function_callback *cb, void **root);
+void xroot_remove(void *root);
+bool xroot_wait_for_bringup(void *root);
+int xroot_create_group(void *xr, char *dtb);
+int xroot_add_simple_node(void *root, char *dtb, const char *endpoint);
+void xroot_broadcast(void *root, enum xrt_events evt);
+
+#endif	/* _XRT_ROOT_H_ */
diff --git a/drivers/fpga/xrt/lib/subdev_pool.h b/drivers/fpga/xrt/lib/subdev_pool.h
new file mode 100644
index 000000000000..03f617d7ffd7
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
+			struct xrt_device **xdevp);
+int xrt_subdev_pool_put(struct xrt_subdev_pool *spool,
+			struct xrt_device *xdev,
+			struct device *holder_dev);
+int xrt_subdev_pool_add(struct xrt_subdev_pool *spool,
+			enum xrt_subdev_id id, xrt_subdev_root_cb_t pcb,
+			void *pcb_arg, char *dtb);
+int xrt_subdev_pool_del(struct xrt_subdev_pool *spool,
+			enum xrt_subdev_id id, int instance);
+ssize_t xrt_subdev_pool_get_holders(struct xrt_subdev_pool *spool,
+				    struct xrt_device *xdev,
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
index 000000000000..f324a25e1d4d
--- /dev/null
+++ b/drivers/fpga/xrt/lib/xroot.c
@@ -0,0 +1,536 @@
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
+#include <linux/hwmon.h>
+#include "xroot.h"
+#include "subdev_pool.h"
+#include "group.h"
+#include "metadata.h"
+
+#define xroot_err(xr, fmt, args...) dev_err((xr)->dev, "%s: " fmt, __func__, ##args)
+#define xroot_warn(xr, fmt, args...) dev_warn((xr)->dev, "%s: " fmt, __func__, ##args)
+#define xroot_info(xr, fmt, args...) dev_info((xr)->dev, "%s: " fmt, __func__, ##args)
+#define xroot_dbg(xr, fmt, args...) dev_dbg((xr)->dev, "%s: " fmt, __func__, ##args)
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
+	atomic_t bringup_pending_cnt;
+	atomic_t bringup_failed_cnt;
+	struct completion bringup_comp;
+};
+
+struct xroot {
+	struct device *dev;
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
+static bool xroot_group_match(enum xrt_subdev_id id, struct xrt_device *xdev, void *arg)
+{
+	struct xroot_group_match_arg *a = (struct xroot_group_match_arg *)arg;
+
+	/* xdev->instance is the instance of the subdev. */
+	return id == a->id && xdev->instance == a->instance;
+}
+
+static int xroot_get_group(struct xroot *xr, int instance, struct xrt_device **grpp)
+{
+	int rc = 0;
+	struct xrt_subdev_pool *grps = &xr->groups.pool;
+	struct device *dev = xr->dev;
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
+static void xroot_put_group(struct xroot *xr, struct xrt_device *grp)
+{
+	int inst = grp->instance;
+	int rc = xrt_subdev_pool_put(&xr->groups.pool, grp, xr->dev);
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
+	struct xrt_device *xdev = NULL;
+	struct xrt_event evt = { 0 };
+
+	WARN_ON(inst < 0);
+	/* Only triggers subdev specific events. */
+	if (e != XRT_EVENT_POST_CREATION && e != XRT_EVENT_PRE_REMOVAL) {
+		xroot_err(xr, "invalid event %d", e);
+		return;
+	}
+
+	ret = xroot_get_group(xr, inst, &xdev);
+	if (ret)
+		return;
+
+	/* Triggers event for children, first. */
+	xleaf_call(xdev, XRT_GROUP_TRIGGER_EVENT, (void *)(uintptr_t)e);
+
+	/* Triggers event for itself. */
+	evt.xe_evt = e;
+	evt.xe_subdev.xevt_subdev_id = XRT_SUBDEV_GRP;
+	evt.xe_subdev.xevt_subdev_instance = inst;
+	xroot_trigger_event(xr, &evt, false);
+
+	xroot_put_group(xr, xdev);
+}
+
+int xroot_create_group(void *root, char *dtb)
+{
+	struct xroot *xr = (struct xroot *)root;
+	int ret;
+
+	atomic_inc(&xr->groups.bringup_pending_cnt);
+	ret = xrt_subdev_pool_add(&xr->groups.pool, XRT_SUBDEV_GRP, xroot_root_cb, xr, dtb);
+	if (ret >= 0) {
+		schedule_work(&xr->groups.bringup_work);
+	} else {
+		atomic_dec(&xr->groups.bringup_pending_cnt);
+		atomic_inc(&xr->groups.bringup_failed_cnt);
+		xroot_err(xr, "failed to create group: %d", ret);
+	}
+	return ret;
+}
+EXPORT_SYMBOL_GPL(xroot_create_group);
+
+static int xroot_destroy_single_group(struct xroot *xr, int instance)
+{
+	struct xrt_device *xdev = NULL;
+	int ret;
+
+	WARN_ON(instance < 0);
+	ret = xroot_get_group(xr, instance, &xdev);
+	if (ret)
+		return ret;
+
+	xroot_group_trigger_event(xr, instance, XRT_EVENT_PRE_REMOVAL);
+
+	/* Now tear down all children in this group. */
+	ret = xleaf_call(xdev, XRT_GROUP_FINI_CHILDREN, NULL);
+	xroot_put_group(xr, xdev);
+	if (!ret)
+		ret = xrt_subdev_pool_del(&xr->groups.pool, XRT_SUBDEV_GRP, instance);
+
+	return ret;
+}
+
+static int xroot_destroy_group(struct xroot *xr, int instance)
+{
+	struct xrt_device *target = NULL;
+	struct xrt_device *deps = NULL;
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
+		int inst = deps->instance;
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
+	struct xrt_device *grp = NULL;
+
+	while (rc < 0 && xroot_get_group(xr, XROOT_GROUP_LAST, &grp) != -ENOENT) {
+		if (arg->xpilp_match_cb(XRT_SUBDEV_GRP, grp, arg->xpilp_match_arg))
+			rc = grp->instance;
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
+	struct xrt_device *grp = NULL;
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
+	struct xrt_device *grp = NULL;
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
+						 holders->xpigh_xdev,
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
+		if (xr->pf_cb.xpc_get_resource) {
+			rc = xr->pf_cb.xpc_get_resource(xr->dev, res);
+		} else {
+			xroot_err(xr, "get resource is not supported");
+			rc = -EOPNOTSUPP;
+		}
+		break;
+	}
+	case XRT_ROOT_GET_ID: {
+		struct xrt_root_get_id *id = (struct xrt_root_get_id *)arg;
+
+		if (xr->pf_cb.xpc_get_id)
+			xr->pf_cb.xpc_get_id(xr->dev, id);
+		else
+			memset(id, 0, sizeof(*id));
+		break;
+	}
+
+	/* MISC generic root driver functions. */
+	case XRT_ROOT_HOT_RESET: {
+		if (xr->pf_cb.xpc_hot_reset) {
+			xr->pf_cb.xpc_hot_reset(xr->dev);
+		} else {
+			xroot_err(xr, "hot reset is not supported");
+			rc = -EOPNOTSUPP;
+		}
+		break;
+	}
+	case XRT_ROOT_HWMON: {
+		struct xrt_root_hwmon *hwmon = (struct xrt_root_hwmon *)arg;
+
+		if (hwmon->xpih_register) {
+			hwmon->xpih_hwmon_dev =
+				hwmon_device_register_with_info(xr->dev,
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
+	struct xrt_device *xdev = NULL;
+	struct xroot *xr = container_of(work, struct xroot, groups.bringup_work);
+
+	while (xroot_get_group(xr, XROOT_GROUP_FIRST, &xdev) != -ENOENT) {
+		int r, i;
+
+		i = xdev->instance;
+		r = xleaf_call(xdev, XRT_GROUP_INIT_CHILDREN, NULL);
+		xroot_put_group(xr, xdev);
+		if (r == -EEXIST)
+			continue; /* Already brought up, nothing to do. */
+		if (r)
+			atomic_inc(&xr->groups.bringup_failed_cnt);
+
+		xroot_group_trigger_event(xr, i, XRT_EVENT_POST_CREATION);
+
+		if (atomic_dec_and_test(&xr->groups.bringup_pending_cnt))
+			complete(&xr->groups.bringup_comp);
+	}
+}
+
+static void xroot_groups_init(struct xroot *xr)
+{
+	xrt_subdev_pool_init(xr->dev, &xr->groups.pool);
+	INIT_WORK(&xr->groups.bringup_work, xroot_bringup_group_work);
+	atomic_set(&xr->groups.bringup_pending_cnt, 0);
+	atomic_set(&xr->groups.bringup_failed_cnt, 0);
+	init_completion(&xr->groups.bringup_comp);
+}
+
+static void xroot_groups_fini(struct xroot *xr)
+{
+	flush_scheduled_work();
+	xrt_subdev_pool_fini(&xr->groups.pool);
+}
+
+int xroot_add_simple_node(void *root, char *dtb, const char *endpoint)
+{
+	struct xroot *xr = (struct xroot *)root;
+	struct device *dev = xr->dev;
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
+	return atomic_read(&xr->groups.bringup_failed_cnt) == 0;
+}
+EXPORT_SYMBOL_GPL(xroot_wait_for_bringup);
+
+int xroot_probe(struct device *dev, struct xroot_physical_function_callback *cb, void **root)
+{
+	struct xroot *xr = NULL;
+
+	dev_info(dev, "%s: probing...", __func__);
+
+	xr = devm_kzalloc(dev, sizeof(*xr), GFP_KERNEL);
+	if (!xr)
+		return -ENOMEM;
+
+	xr->dev = dev;
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
+	struct xrt_device *grp = NULL;
+
+	xroot_info(xr, "leaving...");
+
+	if (xroot_get_group(xr, XROOT_GROUP_FIRST, &grp) == 0) {
+		int instance = grp->instance;
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


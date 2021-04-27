Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07DE436CD9D
	for <lists+linux-fpga@lfdr.de>; Tue, 27 Apr 2021 23:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239369AbhD0VCc (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 27 Apr 2021 17:02:32 -0400
Received: from mail-eopbgr760074.outbound.protection.outlook.com ([40.107.76.74]:21057
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239370AbhD0VC1 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 27 Apr 2021 17:02:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=env+4oTJF7w2n1ZXWG4jfJAeox3QiPxIsJcdqMKNTzkgwN+JkZFPoZuwji2bhglpPi3RAgSyEUwKFhhYBql74MWQ5fuVCDVoa3ZGiNT97hhd3yVCbZPaTSpCn6YnB7eoJ+E/B4Jh8qlV0Sa3q956uA+XLSTvnYWKiMQHYEQiA9dlKj6Cm6q/XNuvSA3uBMZm22W7TX6CBASZN5OLhJ1fpInQZGkibNBPvhu9miaq+mrFaHZ7s5qqOWh6boQPr3548dEo4glohX0ZnGllqYoVCO4oYaZA8+l8hSjAX/sBxhZrVmeheOHXkVof7MaPFl58xtoJmVU+i9HxInrx1EUxig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JYwoBNtAX6m/I6XfqySqXVqz6kQiErSYKRX5cWqJ81U=;
 b=n3STEMAGw2yXuVoZjKiUzEhSHmsvQdzTVECLZZQwfSDhV/oRRTuwyob1IX/MW+S2r7F94UGwSEWNme+suH1rgAjO7vDCFJdeBFR8EnvOCnkHWKklsu/YmeCwZc+WSnvLrby8IHm0OknqJl/86qqY9GfYIE/3papWg3Mvwk8xItvIuiIHD+k3UWW57DtAG5TrkUGiufE23eRcsJvKw/97N0keWLMWJwq0wj8NgOCkQWHHKiqHSHabLWO1VbhDfIwL2WBgohqs7N4ddh9UmcdjmhPou8DHZEc17sV/UaZdNFMymEEX/wC3TLxkZaern6GyAkGCRZUbu0ubAUhoLq8D3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JYwoBNtAX6m/I6XfqySqXVqz6kQiErSYKRX5cWqJ81U=;
 b=LQaaD1V5vnOnUtMqNcHlbijiHqVQw078/C28OisNcDQ+igMqgdFw7xg45a9QSdEG/I0OwVH8OE0QXRUhNOtqxNuTKgMN1hc9Cc5qDGICO5QaVP8lnSoNR/fTozFh78PP1XLCSemuuwZ4RUEeeRXIK6iGPFIwdedpRiJRajS77mk=
Received: from CY4PR13CA0039.namprd13.prod.outlook.com (2603:10b6:903:99::25)
 by PH0PR02MB7669.namprd02.prod.outlook.com (2603:10b6:510:5d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.26; Tue, 27 Apr
 2021 21:01:40 +0000
Received: from CY1NAM02FT036.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:99:cafe::5) by CY4PR13CA0039.outlook.office365.com
 (2603:10b6:903:99::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.17 via Frontend
 Transport; Tue, 27 Apr 2021 21:01:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 CY1NAM02FT036.mail.protection.outlook.com (10.152.75.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4065.21 via Frontend Transport; Tue, 27 Apr 2021 21:01:40 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 27 Apr 2021 14:01:27 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Tue, 27 Apr 2021 14:01:27 -0700
Envelope-to: mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.72.212] (port=52032 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1lbUpj-0000IZ-6i; Tue, 27 Apr 2021 14:01:27 -0700
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id 86768600136; Tue, 27 Apr 2021 13:54:36 -0700 (PDT)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>, Max Zhen <max.zhen@xilinx.com>
Subject: [PATCH V5 XRT Alveo 18/20] fpga: xrt: DDR calibration driver
Date:   Tue, 27 Apr 2021 13:54:29 -0700
Message-ID: <20210427205431.23896-19-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210427205431.23896-1-lizhi.hou@xilinx.com>
References: <20210427205431.23896-1-lizhi.hou@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db5286a0-6776-4d52-98fa-08d909bfa766
X-MS-TrafficTypeDiagnostic: PH0PR02MB7669:
X-Microsoft-Antispam-PRVS: <PH0PR02MB766950F6C45AD09891929E0FA1419@PH0PR02MB7669.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:311;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m7GvNBL/i4Mq7phlbtRrqjck05UzMN3ufioP8j7OUUmo/rLMwqHUMlYfx9bEG5LxYiyjDn2THTKndNL/LFqtnIF3RkB/rEu3wc5ruRYRETSkUUaO7aqb+y4rzMJ/hHW/BFnHr06ZzEhsH6FJOZ2l1xxodpqIuMphOrTfzaDerhWEf12oumYG25SCJJ5jFuqhni/MfB2dsj5yKoz8gSJcWeWl53N9sEFxKLU4uJ3zjkoHA9mowacj2I60Rn42iEQoCSRCqFhDAOYD59JQW1cZSvD6ZgLPwm4eOGkQJRMUgnJii5qNiQO3LCr0mYJhGDcBAX/9b0TUOHZxhBF9GIDCDIrzepUH2hLKjaQRaQR2M/rs2ge1rf1LhG8KHC55NmQx8Jf5ZZkVKF0zs7QKfz9DxpYXGunKq52D+fIMh9BdbhP8EEimyzYyWlyXKAi8hmeKbe+QmGzhtquyT+xAXpJ1P/+oaVPwjmZq8UevvKYoezjgvPHAnQKUdsbPy/NN6a5kUXv8YvJ6a4P63pZ/I4pleAM0NRRP+RxKRFbjJ7macoKzNOdHFGiR2jSEQcCT57Xlq5kbBeLViToGuaajO/3ZsYmKWLYdTggGJuUaTnc9qia/uFaPM9R/hzLasR17jfPgE84YJJQEO3lrDKBJlCeSgIe5PaUZOHYEt9vSKeIWoZA=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(136003)(346002)(39850400004)(376002)(396003)(36840700001)(46966006)(44832011)(186003)(356005)(36860700001)(6266002)(336012)(7636003)(8676002)(8936002)(54906003)(6666004)(316002)(2906002)(107886003)(36906005)(5660300002)(47076005)(42186006)(83380400001)(2616005)(82310400003)(26005)(6916009)(70586007)(1076003)(70206006)(36756003)(478600001)(82740400003)(4326008)(426003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2021 21:01:40.0898
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db5286a0-6776-4d52-98fa-08d909bfa766
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT036.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7669
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Add DDR calibration driver. DDR calibration is a hardware function
discovered by walking firmware metadata. A xrt device node will
be created for it. Hardware provides DDR calibration status through
this function.

Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
Signed-off-by: Max Zhen <max.zhen@xilinx.com>
Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
---
 .../fpga/xrt/include/xleaf/ddr_calibration.h  |  28 +++
 drivers/fpga/xrt/lib/xleaf/ddr_calibration.c  | 210 ++++++++++++++++++
 2 files changed, 238 insertions(+)
 create mode 100644 drivers/fpga/xrt/include/xleaf/ddr_calibration.h
 create mode 100644 drivers/fpga/xrt/lib/xleaf/ddr_calibration.c

diff --git a/drivers/fpga/xrt/include/xleaf/ddr_calibration.h b/drivers/fpga/xrt/include/xleaf/ddr_calibration.h
new file mode 100644
index 000000000000..878740c26ca2
--- /dev/null
+++ b/drivers/fpga/xrt/include/xleaf/ddr_calibration.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2021 Xilinx, Inc.
+ *
+ * Authors:
+ *	Cheng Zhen <maxz@xilinx.com>
+ */
+
+#ifndef _XRT_DDR_CALIBRATION_H_
+#define _XRT_DDR_CALIBRATION_H_
+
+#include "xleaf.h"
+#include <linux/xrt/xclbin.h>
+
+/*
+ * Memory calibration driver leaf calls.
+ */
+enum xrt_calib_results {
+	XRT_CALIB_UNKNOWN = 0,
+	XRT_CALIB_SUCCEEDED,
+	XRT_CALIB_FAILED,
+};
+
+enum xrt_calib_leaf_cmd {
+	XRT_CALIB_RESULT = XRT_XLEAF_CUSTOM_BASE, /* See comments in xleaf.h */
+};
+
+#endif	/* _XRT_DDR_CALIBRATION_H_ */
diff --git a/drivers/fpga/xrt/lib/xleaf/ddr_calibration.c b/drivers/fpga/xrt/lib/xleaf/ddr_calibration.c
new file mode 100644
index 000000000000..36a0937c9195
--- /dev/null
+++ b/drivers/fpga/xrt/lib/xleaf/ddr_calibration.c
@@ -0,0 +1,210 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx Alveo FPGA memory calibration driver
+ *
+ * Copyright (C) 2020-2021 Xilinx, Inc.
+ *
+ * memory calibration
+ *
+ * Authors:
+ *      Lizhi Hou<Lizhi.Hou@xilinx.com>
+ */
+#include <linux/delay.h>
+#include <linux/regmap.h>
+#include "xclbin-helper.h"
+#include "metadata.h"
+#include "xleaf/ddr_calibration.h"
+
+#define XRT_CALIB	"xrt_calib"
+
+#define XRT_CALIB_STATUS_REG		0
+#define XRT_CALIB_READ_RETRIES		20
+#define XRT_CALIB_READ_INTERVAL		500 /* ms */
+
+XRT_DEFINE_REGMAP_CONFIG(calib_regmap_config);
+
+struct calib_cache {
+	struct list_head	link;
+	const char		*ep_name;
+	char			*data;
+	u32			data_size;
+};
+
+struct calib {
+	struct xrt_device	*xdev;
+	struct regmap		*regmap;
+	struct mutex		lock; /* calibration dev lock */
+	struct list_head	cache_list;
+	u32			cache_num;
+	enum xrt_calib_results	result;
+};
+
+static void __calib_cache_clean_nolock(struct calib *calib)
+{
+	struct calib_cache *cache, *temp;
+
+	list_for_each_entry_safe(cache, temp, &calib->cache_list, link) {
+		vfree(cache->data);
+		list_del(&cache->link);
+		vfree(cache);
+	}
+	calib->cache_num = 0;
+}
+
+static void calib_cache_clean(struct calib *calib)
+{
+	mutex_lock(&calib->lock);
+	__calib_cache_clean_nolock(calib);
+	mutex_unlock(&calib->lock);
+}
+
+static int calib_calibration(struct calib *calib)
+{
+	u32 times = XRT_CALIB_READ_RETRIES;
+	u32 status;
+	int ret;
+
+	while (times != 0) {
+		ret = regmap_read(calib->regmap, XRT_CALIB_STATUS_REG, &status);
+		if (ret) {
+			xrt_err(calib->xdev, "failed to read status reg %d", ret);
+			return ret;
+		}
+
+		if (status & BIT(0))
+			break;
+		msleep(XRT_CALIB_READ_INTERVAL);
+		times--;
+	}
+
+	if (!times) {
+		xrt_err(calib->xdev,
+			"MIG calibration timeout after bitstream download");
+		return -ETIMEDOUT;
+	}
+
+	xrt_info(calib->xdev, "took %dms", (XRT_CALIB_READ_RETRIES - times) *
+		 XRT_CALIB_READ_INTERVAL);
+	return 0;
+}
+
+static void xrt_calib_event_cb(struct xrt_device *xdev, void *arg)
+{
+	struct calib *calib = xrt_get_drvdata(xdev);
+	struct xrt_event *evt = (struct xrt_event *)arg;
+	enum xrt_events e = evt->xe_evt;
+	enum xrt_subdev_id id;
+	int ret;
+
+	id = evt->xe_subdev.xevt_subdev_id;
+
+	switch (e) {
+	case XRT_EVENT_POST_CREATION:
+		if (id == XRT_SUBDEV_UCS) {
+			ret = calib_calibration(calib);
+			if (ret)
+				calib->result = XRT_CALIB_FAILED;
+			else
+				calib->result = XRT_CALIB_SUCCEEDED;
+		}
+		break;
+	default:
+		xrt_dbg(xdev, "ignored event %d", e);
+		break;
+	}
+}
+
+static void xrt_calib_remove(struct xrt_device *xdev)
+{
+	struct calib *calib = xrt_get_drvdata(xdev);
+
+	calib_cache_clean(calib);
+}
+
+static int xrt_calib_probe(struct xrt_device *xdev)
+{
+	void __iomem *base = NULL;
+	struct resource *res;
+	struct calib *calib;
+	int err = 0;
+
+	calib = devm_kzalloc(&xdev->dev, sizeof(*calib), GFP_KERNEL);
+	if (!calib)
+		return -ENOMEM;
+
+	calib->xdev = xdev;
+	xrt_set_drvdata(xdev, calib);
+
+	res = xrt_get_resource(xdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		err = -EINVAL;
+		goto failed;
+	}
+
+	base = devm_ioremap_resource(&xdev->dev, res);
+	if (IS_ERR(base)) {
+		err = PTR_ERR(base);
+		goto failed;
+	}
+
+	calib->regmap = devm_regmap_init_mmio(&xdev->dev, base, &calib_regmap_config);
+	if (IS_ERR(calib->regmap)) {
+		xrt_err(xdev, "Map iomem failed");
+		err = PTR_ERR(calib->regmap);
+		goto failed;
+	}
+
+	mutex_init(&calib->lock);
+	INIT_LIST_HEAD(&calib->cache_list);
+
+	return 0;
+
+failed:
+	return err;
+}
+
+static int
+xrt_calib_leaf_call(struct xrt_device *xdev, u32 cmd, void *arg)
+{
+	struct calib *calib = xrt_get_drvdata(xdev);
+	int ret = 0;
+
+	switch (cmd) {
+	case XRT_XLEAF_EVENT:
+		xrt_calib_event_cb(xdev, arg);
+		break;
+	case XRT_CALIB_RESULT: {
+		enum xrt_calib_results *r = (enum xrt_calib_results *)arg;
+		*r = calib->result;
+		break;
+	}
+	default:
+		xrt_err(xdev, "unsupported cmd %d", cmd);
+		ret = -EINVAL;
+	}
+	return ret;
+}
+
+static struct xrt_dev_endpoints xrt_calib_endpoints[] = {
+	{
+		.xse_names = (struct xrt_dev_ep_names[]) {
+			{ .ep_name = XRT_MD_NODE_DDR_CALIB },
+			{ NULL },
+		},
+		.xse_min_ep = 1,
+	},
+	{ 0 },
+};
+
+static struct xrt_driver xrt_calib_driver = {
+	.driver = {
+		.name = XRT_CALIB,
+	},
+	.subdev_id = XRT_SUBDEV_CALIB,
+	.endpoints = xrt_calib_endpoints,
+	.probe = xrt_calib_probe,
+	.remove = xrt_calib_remove,
+	.leaf_call = xrt_calib_leaf_call,
+};
+
+XRT_LEAF_INIT_FINI_FUNC(calib);
-- 
2.27.0


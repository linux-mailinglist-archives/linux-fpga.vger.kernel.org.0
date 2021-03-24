Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 892B7347113
	for <lists+linux-fpga@lfdr.de>; Wed, 24 Mar 2021 06:36:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235375AbhCXFgE (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 24 Mar 2021 01:36:04 -0400
Received: from mail-mw2nam10on2067.outbound.protection.outlook.com ([40.107.94.67]:62945
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235384AbhCXFfs (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 24 Mar 2021 01:35:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GKuB+E9dVNRzewhm4W9AUKOl7q6GVXp6dV/PI5rAw9rjXmX8rjL3qKzTQBjWdqjdAtzmtGgUz1n4SQZf4WS4jUOlL/xBvOz80ThvetS/Eb7FRWVQDfZFUoritgiXAJ5E2rQ4pvapeG/yylgr8CdwHQ8UNE6YjRj+AS+GftRoKTwqpr/+qX9KEShOFjz8oPkzkUEYigtjL2FRrnMi9GHKRxOTUDP2AL6AIAiMNNRzMLukbMenbU1TfBEYuXiDnDWmxQDFqgo6k8HcwiJVuiKXwlgWCRB3FHyTr7K4IMlvWVWA9kvsVHlO1fknZM22G139n5M9iiJFnyOEggrKnjPHeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oYi8b3/1dyQ2xmsfv6IEN2O3BXcNBovu/jEK8G3VIcI=;
 b=USDCu9zg5M7HMVpl/u1kyolD4nfKr52gvboFFabTzIZd3rzZNBw573sSPHO7rTDGwc4PaOAREd+AKLGbLtKSGIvC9rEoRincDCYPGJ62euJpqRwhQoFucMaK4oA2TGWL96+UqItXLJ/Uvw7Jkh2xmeKWxwBRMM86i5No2/QhRXLlwOa7T08BTlDhxiREy0oejrBNJMSULMZ7O8ey3QnR2hjHht7JTf5/sQoA/xxC3yM2dIYfMHI7aosx2CJM+35fCURZNogWkOGa3Mhf8rPiVjPxAKZCdq2eeAm0L1vb7EK9eZHEUZS8mCJ5SftvhxJoj/wtLy0ZfT8GirQUs1QDbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oYi8b3/1dyQ2xmsfv6IEN2O3BXcNBovu/jEK8G3VIcI=;
 b=id990VqI4Q3+JtB+UEZsT9+H0lrE4WfV4iSrRk0jR0DY0sJwDu3ZEFC34PDC8aLgNsWlpgW8DATldaH+A88CGSnnTHl1u810duV6dYVjHRNWAXbEh7MqjLXy7mh2S1sscsa4NjL/R9YQa1kzZM2/mwQ2gblwplr+60/YIVHsDs8=
Received: from DS7PR03CA0040.namprd03.prod.outlook.com (2603:10b6:5:3b5::15)
 by SN6PR02MB4608.namprd02.prod.outlook.com (2603:10b6:805:a6::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Wed, 24 Mar
 2021 05:35:46 +0000
Received: from DM3NAM02FT059.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:3b5:cafe::d9) by DS7PR03CA0040.outlook.office365.com
 (2603:10b6:5:3b5::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24 via Frontend
 Transport; Wed, 24 Mar 2021 05:35:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT059.mail.protection.outlook.com (10.13.4.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3977.25 via Frontend Transport; Wed, 24 Mar 2021 05:35:45 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 23 Mar 2021 22:35:34 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2106.2 via Frontend Transport; Tue, 23 Mar 2021 22:35:34 -0700
Envelope-to: mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.72.212] (port=51052 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1lOwB4-0006DN-Qz; Tue, 23 Mar 2021 22:35:34 -0700
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id EDC5460012F; Tue, 23 Mar 2021 22:29:56 -0700 (PDT)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>, Max Zhen <max.zhen@xilinx.com>
Subject: [PATCH V4 XRT Alveo 16/20] fpga: xrt: clock platform driver
Date:   Tue, 23 Mar 2021 22:29:43 -0700
Message-ID: <20210324052947.27889-17-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210324052947.27889-1-lizhi.hou@xilinx.com>
References: <20210324052947.27889-1-lizhi.hou@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 11af8496-c0b8-47a3-03a5-08d8ee86ac5c
X-MS-TrafficTypeDiagnostic: SN6PR02MB4608:
X-Microsoft-Antispam-PRVS: <SN6PR02MB460857FC3C3FCC7FC9F0D420A1639@SN6PR02MB4608.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2dwLOpBVHzSehsRGnq4SySpxK9Yn0rh5/GgECntxAGvP6X8CGuio68njcv9A93bdL6mQpz68oq5pzkFqVjeOCkHrSnZbhbDsAGZUwho/EUuYgc2kG3Dr6808pyr1n9QEFVcVXP5cVDg34iPLU0sztzJFkEqFkJsVsB/VgM+5P7IetWxuCksD/7WXnUayWxORvb8TKYoXQ4aT/8fBZisCK+51pj/CPwUGAGIVCKP9FGpOZh8ymq+VL0k6DSalDukVccqQiT0VorDk1c7l0UFqQ1tjGzMM28jTrJRuG38TRZelCFACEQAGrSsT3zvaeX7U3x32/Ggu+ouHWh3CRHxU5Tg/Uod4ZF6QxbQJMT7iDmk3HeLYFIHj7XqwD1wXYYT9jfC4jwKhO5c5aytvQv847JK01Yg+cYm17dhg+1vbQU8F0Xzx3DzbeCXcya9srf1SXNnWLocRdpGUH8fBgJT4kEBZpXI4pZoHq4wUocL/a1H5P2HXTLgsRpl2Ykg8GfgNHFr3L5DAsQJyLjsK664Srp/xuOyfRIIcQYlZLpuJ6+RSvsvqEPRfmlPMP59t7KpVFwGZhQCuSpgtKcfZQ9vOW7QczIBrOCAxx3SC0AMqT5oiqbterqa5CNpf98RJEdgj5cpotzk2IjJFk+2Yyvkfpm0QplSshG2OwQ+75x2Cx3k=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(376002)(346002)(46966006)(36840700001)(1076003)(426003)(316002)(36906005)(6916009)(6666004)(54906003)(336012)(356005)(47076005)(186003)(4326008)(44832011)(42186006)(26005)(36860700001)(2906002)(8676002)(107886003)(82740400003)(82310400003)(5660300002)(478600001)(30864003)(2616005)(83380400001)(7636003)(36756003)(70206006)(6266002)(8936002)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2021 05:35:45.6765
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11af8496-c0b8-47a3-03a5-08d8ee86ac5c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT059.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4608
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Add clock driver. Clock is a hardware function discovered by walking
xclbin metadata. A platform device node will be created for it. Other
part of driver configures clock through clock driver.

Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
Signed-off-by: Max Zhen <max.zhen@xilinx.com>
Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
---
 drivers/fpga/xrt/include/xleaf/clock.h |  29 ++
 drivers/fpga/xrt/lib/xleaf/clock.c     | 669 +++++++++++++++++++++++++
 2 files changed, 698 insertions(+)
 create mode 100644 drivers/fpga/xrt/include/xleaf/clock.h
 create mode 100644 drivers/fpga/xrt/lib/xleaf/clock.c

diff --git a/drivers/fpga/xrt/include/xleaf/clock.h b/drivers/fpga/xrt/include/xleaf/clock.h
new file mode 100644
index 000000000000..6858473fd096
--- /dev/null
+++ b/drivers/fpga/xrt/include/xleaf/clock.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2021 Xilinx, Inc.
+ *
+ * Authors:
+ *	Lizhi Hou <Lizhi.Hou@xilinx.com>
+ */
+
+#ifndef _XRT_CLOCK_H_
+#define _XRT_CLOCK_H_
+
+#include "xleaf.h"
+#include <linux/xrt/xclbin.h>
+
+/*
+ * CLOCK driver leaf calls.
+ */
+enum xrt_clock_leaf_cmd {
+	XRT_CLOCK_SET = XRT_XLEAF_CUSTOM_BASE, /* See comments in xleaf.h */
+	XRT_CLOCK_GET,
+	XRT_CLOCK_VERIFY,
+};
+
+struct xrt_clock_get {
+	u16 freq;
+	u32 freq_cnter;
+};
+
+#endif	/* _XRT_CLOCK_H_ */
diff --git a/drivers/fpga/xrt/lib/xleaf/clock.c b/drivers/fpga/xrt/lib/xleaf/clock.c
new file mode 100644
index 000000000000..071485e4bf65
--- /dev/null
+++ b/drivers/fpga/xrt/lib/xleaf/clock.c
@@ -0,0 +1,669 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx Alveo FPGA Clock Wizard Driver
+ *
+ * Copyright (C) 2020-2021 Xilinx, Inc.
+ *
+ * Authors:
+ *      Lizhi Hou<Lizhi.Hou@xilinx.com>
+ *      Sonal Santan <sonals@xilinx.com>
+ *      David Zhang <davidzha@xilinx.com>
+ */
+
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/regmap.h>
+#include <linux/io.h>
+#include "metadata.h"
+#include "xleaf.h"
+#include "xleaf/clock.h"
+#include "xleaf/clkfreq.h"
+
+/* XRT_CLOCK_MAX_NUM_CLOCKS should be a concept from XCLBIN_ in the future */
+#define XRT_CLOCK_MAX_NUM_CLOCKS	4
+#define XRT_CLOCK_STATUS_MASK		0xffff
+#define XRT_CLOCK_STATUS_MEASURE_START	0x1
+#define XRT_CLOCK_STATUS_MEASURE_DONE	0x2
+
+#define XRT_CLOCK_STATUS_REG		0x4
+#define XRT_CLOCK_CLKFBOUT_REG		0x200
+#define XRT_CLOCK_CLKOUT0_REG		0x208
+#define XRT_CLOCK_LOAD_SADDR_SEN_REG	0x25C
+#define XRT_CLOCK_DEFAULT_EXPIRE_SECS	1
+
+#define CLOCK_ERR(clock, fmt, arg...)	\
+	xrt_err((clock)->pdev, fmt "\n", ##arg)
+#define CLOCK_WARN(clock, fmt, arg...)	\
+	xrt_warn((clock)->pdev, fmt "\n", ##arg)
+#define CLOCK_INFO(clock, fmt, arg...)	\
+	xrt_info((clock)->pdev, fmt "\n", ##arg)
+#define CLOCK_DBG(clock, fmt, arg...)	\
+	xrt_dbg((clock)->pdev, fmt "\n", ##arg)
+
+#define XRT_CLOCK	"xrt_clock"
+
+static const struct regmap_config clock_regmap_config = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+	.max_register = 0x1000,
+};
+
+struct clock {
+	struct platform_device  *pdev;
+	struct regmap		*regmap;
+	struct mutex		clock_lock; /* clock dev lock */
+
+	const char		*clock_ep_name;
+};
+
+/*
+ * Precomputed table with config0 and config2 register values together with
+ * target frequency. The steps are approximately 5 MHz apart. Table is
+ * generated by platform creation tool.
+ */
+static const struct xmgmt_ocl_clockwiz {
+	/* target frequency */
+	u16 ocl;
+	/* config0 register */
+	u32 config0;
+	/* config2 register */
+	u32 config2;
+} frequency_table[] = {
+	/*1275.000*/ { 10, 0x02EE0C01, 0x0001F47F },
+	/*1575.000*/ { 15, 0x02EE0F01, 0x00000069},
+	/*1600.000*/ { 20, 0x00001001, 0x00000050},
+	/*1600.000*/ { 25, 0x00001001, 0x00000040},
+	/*1575.000*/ { 30, 0x02EE0F01, 0x0001F434},
+	/*1575.000*/ { 35, 0x02EE0F01, 0x0000002D},
+	/*1600.000*/ { 40, 0x00001001, 0x00000028},
+	/*1575.000*/ { 45, 0x02EE0F01, 0x00000023},
+	/*1600.000*/ { 50, 0x00001001, 0x00000020},
+	/*1512.500*/ { 55, 0x007D0F01, 0x0001F41B},
+	/*1575.000*/ { 60, 0x02EE0F01, 0x0000FA1A},
+	/*1462.500*/ { 65, 0x02710E01, 0x0001F416},
+	/*1575.000*/ { 70, 0x02EE0F01, 0x0001F416},
+	/*1575.000*/ { 75, 0x02EE0F01, 0x00000015},
+	/*1600.000*/ { 80, 0x00001001, 0x00000014},
+	/*1487.500*/ { 85, 0x036B0E01, 0x0001F411},
+	/*1575.000*/ { 90, 0x02EE0F01, 0x0001F411},
+	/*1425.000*/ { 95, 0x00FA0E01, 0x0000000F},
+	/*1600.000*/ { 100, 0x00001001, 0x00000010},
+	/*1575.000*/ { 105, 0x02EE0F01, 0x0000000F},
+	/*1512.500*/ { 110, 0x007D0F01, 0x0002EE0D},
+	/*1437.500*/ { 115, 0x01770E01, 0x0001F40C},
+	/*1575.000*/ { 120, 0x02EE0F01, 0x00007D0D},
+	/*1562.500*/ { 125, 0x02710F01, 0x0001F40C},
+	/*1462.500*/ { 130, 0x02710E01, 0x0000FA0B},
+	/*1350.000*/ { 135, 0x01F40D01, 0x0000000A},
+	/*1575.000*/ { 140, 0x02EE0F01, 0x0000FA0B},
+	/*1450.000*/ { 145, 0x01F40E01, 0x0000000A},
+	/*1575.000*/ { 150, 0x02EE0F01, 0x0001F40A},
+	/*1550.000*/ { 155, 0x01F40F01, 0x0000000A},
+	/*1600.000*/ { 160, 0x00001001, 0x0000000A},
+	/*1237.500*/ { 165, 0x01770C01, 0x0001F407},
+	/*1487.500*/ { 170, 0x036B0E01, 0x0002EE08},
+	/*1575.000*/ { 175, 0x02EE0F01, 0x00000009},
+	/*1575.000*/ { 180, 0x02EE0F01, 0x0002EE08},
+	/*1387.500*/ { 185, 0x036B0D01, 0x0001F407},
+	/*1425.000*/ { 190, 0x00FA0E01, 0x0001F407},
+	/*1462.500*/ { 195, 0x02710E01, 0x0001F407},
+	/*1600.000*/ { 200, 0x00001001, 0x00000008},
+	/*1537.500*/ { 205, 0x01770F01, 0x0001F407},
+	/*1575.000*/ { 210, 0x02EE0F01, 0x0001F407},
+	/*1075.000*/ { 215, 0x02EE0A01, 0x00000005},
+	/*1512.500*/ { 220, 0x007D0F01, 0x00036B06},
+	/*1575.000*/ { 225, 0x02EE0F01, 0x00000007},
+	/*1437.500*/ { 230, 0x01770E01, 0x0000FA06},
+	/*1175.000*/ { 235, 0x02EE0B01, 0x00000005},
+	/*1500.000*/ { 240, 0x00000F01, 0x0000FA06},
+	/*1225.000*/ { 245, 0x00FA0C01, 0x00000005},
+	/*1562.500*/ { 250, 0x02710F01, 0x0000FA06},
+	/*1275.000*/ { 255, 0x02EE0C01, 0x00000005},
+	/*1462.500*/ { 260, 0x02710E01, 0x00027105},
+	/*1325.000*/ { 265, 0x00FA0D01, 0x00000005},
+	/*1350.000*/ { 270, 0x01F40D01, 0x00000005},
+	/*1512.500*/ { 275, 0x007D0F01, 0x0001F405},
+	/*1575.000*/ { 280, 0x02EE0F01, 0x00027105},
+	/*1425.000*/ { 285, 0x00FA0E01, 0x00000005},
+	/*1450.000*/ { 290, 0x01F40E01, 0x00000005},
+	/*1475.000*/ { 295, 0x02EE0E01, 0x00000005},
+	/*1575.000*/ { 300, 0x02EE0F01, 0x0000FA05},
+	/*1525.000*/ { 305, 0x00FA0F01, 0x00000005},
+	/*1550.000*/ { 310, 0x01F40F01, 0x00000005},
+	/*1575.000*/ { 315, 0x02EE0F01, 0x00000005},
+	/*1600.000*/ { 320, 0x00001001, 0x00000005},
+	/*1462.500*/ { 325, 0x02710E01, 0x0001F404},
+	/*1237.500*/ { 330, 0x01770C01, 0x0002EE03},
+	/* 837.500*/ { 335, 0x01770801, 0x0001F402},
+	/*1487.500*/ { 340, 0x036B0E01, 0x00017704},
+	/* 862.500*/ { 345, 0x02710801, 0x0001F402},
+	/*1575.000*/ { 350, 0x02EE0F01, 0x0001F404},
+	/* 887.500*/ { 355, 0x036B0801, 0x0001F402},
+	/*1575.000*/ { 360, 0x02EE0F01, 0x00017704},
+	/* 912.500*/ { 365, 0x007D0901, 0x0001F402},
+	/*1387.500*/ { 370, 0x036B0D01, 0x0002EE03},
+	/*1500.000*/ { 375, 0x00000F01, 0x00000004},
+	/*1425.000*/ { 380, 0x00FA0E01, 0x0002EE03},
+	/* 962.500*/ { 385, 0x02710901, 0x0001F402},
+	/*1462.500*/ { 390, 0x02710E01, 0x0002EE03},
+	/* 987.500*/ { 395, 0x036B0901, 0x0001F402},
+	/*1600.000*/ { 400, 0x00001001, 0x00000004},
+	/*1012.500*/ { 405, 0x007D0A01, 0x0001F402},
+	/*1537.500*/ { 410, 0x01770F01, 0x0002EE03},
+	/*1037.500*/ { 415, 0x01770A01, 0x0001F402},
+	/*1575.000*/ { 420, 0x02EE0F01, 0x0002EE03},
+	/*1487.500*/ { 425, 0x036B0E01, 0x0001F403},
+	/*1075.000*/ { 430, 0x02EE0A01, 0x0001F402},
+	/*1087.500*/ { 435, 0x036B0A01, 0x0001F402},
+	/*1375.000*/ { 440, 0x02EE0D01, 0x00007D03},
+	/*1112.500*/ { 445, 0x007D0B01, 0x0001F402},
+	/*1575.000*/ { 450, 0x02EE0F01, 0x0001F403},
+	/*1137.500*/ { 455, 0x01770B01, 0x0001F402},
+	/*1437.500*/ { 460, 0x01770E01, 0x00007D03},
+	/*1162.500*/ { 465, 0x02710B01, 0x0001F402},
+	/*1175.000*/ { 470, 0x02EE0B01, 0x0001F402},
+	/*1425.000*/ { 475, 0x00FA0E01, 0x00000003},
+	/*1500.000*/ { 480, 0x00000F01, 0x00007D03},
+	/*1212.500*/ { 485, 0x007D0C01, 0x0001F402},
+	/*1225.000*/ { 490, 0x00FA0C01, 0x0001F402},
+	/*1237.500*/ { 495, 0x01770C01, 0x0001F402},
+	/*1562.500*/ { 500, 0x02710F01, 0x00007D03},
+	/*1262.500*/ { 505, 0x02710C01, 0x0001F402},
+	/*1275.000*/ { 510, 0x02EE0C01, 0x0001F402},
+	/*1287.500*/ { 515, 0x036B0C01, 0x0001F402},
+	/*1300.000*/ { 520, 0x00000D01, 0x0001F402},
+	/*1575.000*/ { 525, 0x02EE0F01, 0x00000003},
+	/*1325.000*/ { 530, 0x00FA0D01, 0x0001F402},
+	/*1337.500*/ { 535, 0x01770D01, 0x0001F402},
+	/*1350.000*/ { 540, 0x01F40D01, 0x0001F402},
+	/*1362.500*/ { 545, 0x02710D01, 0x0001F402},
+	/*1512.500*/ { 550, 0x007D0F01, 0x0002EE02},
+	/*1387.500*/ { 555, 0x036B0D01, 0x0001F402},
+	/*1400.000*/ { 560, 0x00000E01, 0x0001F402},
+	/*1412.500*/ { 565, 0x007D0E01, 0x0001F402},
+	/*1425.000*/ { 570, 0x00FA0E01, 0x0001F402},
+	/*1437.500*/ { 575, 0x01770E01, 0x0001F402},
+	/*1450.000*/ { 580, 0x01F40E01, 0x0001F402},
+	/*1462.500*/ { 585, 0x02710E01, 0x0001F402},
+	/*1475.000*/ { 590, 0x02EE0E01, 0x0001F402},
+	/*1487.500*/ { 595, 0x036B0E01, 0x0001F402},
+	/*1575.000*/ { 600, 0x02EE0F01, 0x00027102},
+	/*1512.500*/ { 605, 0x007D0F01, 0x0001F402},
+	/*1525.000*/ { 610, 0x00FA0F01, 0x0001F402},
+	/*1537.500*/ { 615, 0x01770F01, 0x0001F402},
+	/*1550.000*/ { 620, 0x01F40F01, 0x0001F402},
+	/*1562.500*/ { 625, 0x02710F01, 0x0001F402},
+	/*1575.000*/ { 630, 0x02EE0F01, 0x0001F402},
+	/*1587.500*/ { 635, 0x036B0F01, 0x0001F402},
+	/*1600.000*/ { 640, 0x00001001, 0x0001F402},
+	/*1290.000*/ { 645, 0x01F44005, 0x00000002},
+	/*1462.500*/ { 650, 0x02710E01, 0x0000FA02}
+};
+
+static u32 find_matching_freq_config(unsigned short freq,
+				     const struct xmgmt_ocl_clockwiz *table,
+				     int size)
+{
+	u32 end = size - 1;
+	u32 start = 0;
+	u32 idx;
+
+	if (freq < table[0].ocl)
+		return 0;
+
+	if (freq > table[size - 1].ocl)
+		return size - 1;
+
+	while (start < end) {
+		idx = (start + end) / 2;
+		if (freq == table[idx].ocl)
+			break;
+		if (freq < table[idx].ocl)
+			end = idx;
+		else
+			start = idx + 1;
+	}
+	if (freq < table[idx].ocl)
+		idx--;
+
+	return idx;
+}
+
+static u32 find_matching_freq(u32 freq,
+			      const struct xmgmt_ocl_clockwiz *freq_table,
+			      int freq_table_size)
+{
+	int idx = find_matching_freq_config(freq, freq_table, freq_table_size);
+
+	return freq_table[idx].ocl;
+}
+
+static inline int clock_wiz_busy(struct clock *clock, int cycle, int interval)
+{
+	u32 val = 0;
+	int count;
+	int ret;
+
+	for (count = 0; count < cycle; count++) {
+		ret = regmap_read(clock->regmap, XRT_CLOCK_STATUS_REG, &val);
+		if (ret) {
+			CLOCK_ERR(clock, "read status failed %d", ret);
+			return ret;
+		}
+		if (val == 1)
+			break;
+
+		mdelay(interval);
+	}
+	if (val != 1) {
+		CLOCK_ERR(clock, "clockwiz is (%u) busy after %d ms",
+			  val, cycle * interval);
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
+static int get_freq(struct clock *clock, u16 *freq)
+{
+	u32 mul_frac0 = 0;
+	u32 div_frac1 = 0;
+	u32 mul0, div0;
+	u64 input;
+	u32 div1;
+	u32 val;
+	int ret;
+
+	WARN_ON(!mutex_is_locked(&clock->clock_lock));
+
+	ret = regmap_read(clock->regmap, XRT_CLOCK_STATUS_REG, &val);
+	if (ret) {
+		CLOCK_ERR(clock, "read status failed %d", ret);
+		return ret;
+	}
+
+	if ((val & 0x1) == 0) {
+		CLOCK_ERR(clock, "clockwiz is busy %x", val);
+		*freq = 0;
+		return -EBUSY;
+	}
+
+	ret = regmap_read(clock->regmap, XRT_CLOCK_CLKFBOUT_REG, &val);
+	if (ret) {
+		CLOCK_ERR(clock, "read clkfbout failed %d", ret);
+		return ret;
+	}
+
+	div0 = val & 0xff;
+	mul0 = (val & 0xff00) >> 8;
+	if (val & BIT(26)) {
+		mul_frac0 = val >> 16;
+		mul_frac0 &= 0x3ff;
+	}
+
+	/*
+	 * Multiply both numerator (mul0) and the denominator (div0) with 1000
+	 * to account for fractional portion of multiplier
+	 */
+	mul0 *= 1000;
+	mul0 += mul_frac0;
+	div0 *= 1000;
+
+	ret = regmap_read(clock->regmap, XRT_CLOCK_CLKOUT0_REG, &val);
+	if (ret) {
+		CLOCK_ERR(clock, "read clkout0 failed %d", ret);
+		return ret;
+	}
+
+	div1 = val & 0xff;
+	if (val & BIT(18)) {
+		div_frac1 = val >> 8;
+		div_frac1 &= 0x3ff;
+	}
+
+	/*
+	 * Multiply both numerator (mul0) and the denominator (div1) with
+	 * 1000 to account for fractional portion of divider
+	 */
+
+	div1 *= 1000;
+	div1 += div_frac1;
+	div0 *= div1;
+	mul0 *= 1000;
+	if (div0 == 0) {
+		CLOCK_ERR(clock, "clockwiz 0 divider");
+		return 0;
+	}
+
+	input = mul0 * 100;
+	do_div(input, div0);
+	*freq = (u16)input;
+
+	return 0;
+}
+
+static int set_freq(struct clock *clock, u16 freq)
+{
+	int err = 0;
+	u32 idx = 0;
+	u32 val = 0;
+	u32 config;
+
+	mutex_lock(&clock->clock_lock);
+	idx = find_matching_freq_config(freq, frequency_table,
+					ARRAY_SIZE(frequency_table));
+
+	CLOCK_INFO(clock, "New: %d Mhz", freq);
+	err = clock_wiz_busy(clock, 20, 50);
+	if (err)
+		goto fail;
+
+	config = frequency_table[idx].config0;
+	err = regmap_write(clock->regmap, XRT_CLOCK_CLKFBOUT_REG, config);
+	if (err) {
+		CLOCK_ERR(clock, "write clkfbout failed %d", err);
+		goto fail;
+	}
+
+	config = frequency_table[idx].config2;
+	err = regmap_write(clock->regmap, XRT_CLOCK_CLKOUT0_REG, config);
+	if (err) {
+		CLOCK_ERR(clock, "write clkout0 failed %d", err);
+		goto fail;
+	}
+
+	mdelay(10);
+	err = regmap_write(clock->regmap, XRT_CLOCK_LOAD_SADDR_SEN_REG, 7);
+	if (err) {
+		CLOCK_ERR(clock, "write load_saddr_sen failed %d", err);
+		goto fail;
+	}
+
+	mdelay(1);
+	err = regmap_write(clock->regmap, XRT_CLOCK_LOAD_SADDR_SEN_REG, 2);
+	if (err) {
+		CLOCK_ERR(clock, "write saddr failed %d", err);
+		goto fail;
+	}
+
+	CLOCK_INFO(clock, "clockwiz waiting for locked signal");
+
+	err = clock_wiz_busy(clock, 100, 100);
+	if (err) {
+		CLOCK_ERR(clock, "clockwiz MMCM/PLL did not lock");
+		/* restore */
+		regmap_write(clock->regmap, XRT_CLOCK_LOAD_SADDR_SEN_REG, 4);
+		mdelay(10);
+		regmap_write(clock->regmap, XRT_CLOCK_LOAD_SADDR_SEN_REG, 0);
+		goto fail;
+	}
+	regmap_read(clock->regmap, XRT_CLOCK_CLKFBOUT_REG, &val);
+	CLOCK_INFO(clock, "clockwiz CONFIG(0) 0x%x", val);
+	regmap_read(clock->regmap, XRT_CLOCK_CLKOUT0_REG, &val);
+	CLOCK_INFO(clock, "clockwiz CONFIG(2) 0x%x", val);
+
+fail:
+	mutex_unlock(&clock->clock_lock);
+	return err;
+}
+
+static int get_freq_counter(struct clock *clock, u32 *freq)
+{
+	struct xrt_subdev_platdata *pdata = DEV_PDATA(clock->pdev);
+	struct platform_device *pdev = clock->pdev;
+	struct platform_device *counter_leaf;
+	const void *counter;
+	int err;
+
+	WARN_ON(!mutex_is_locked(&clock->clock_lock));
+
+	err = xrt_md_get_prop(DEV(pdev), pdata->xsp_dtb, clock->clock_ep_name,
+			      NULL, XRT_MD_PROP_CLK_CNT, &counter, NULL);
+	if (err) {
+		xrt_err(pdev, "no counter specified");
+		return err;
+	}
+
+	counter_leaf = xleaf_get_leaf_by_epname(pdev, counter);
+	if (!counter_leaf) {
+		xrt_err(pdev, "can't find counter");
+		return -ENOENT;
+	}
+
+	err = xleaf_call(counter_leaf, XRT_CLKFREQ_READ, freq);
+	if (err)
+		xrt_err(pdev, "can't read counter");
+	xleaf_put_leaf(clock->pdev, counter_leaf);
+
+	return err;
+}
+
+static int clock_get_freq(struct clock *clock, u16 *freq, u32 *freq_cnter)
+{
+	int err = 0;
+
+	mutex_lock(&clock->clock_lock);
+
+	if (err == 0 && freq)
+		err = get_freq(clock, freq);
+
+	if (err == 0 && freq_cnter)
+		err = get_freq_counter(clock, freq_cnter);
+
+	mutex_unlock(&clock->clock_lock);
+	return err;
+}
+
+static int clock_verify_freq(struct clock *clock)
+{
+	u32 lookup_freq, clock_freq_counter, request_in_khz, tolerance;
+	int err = 0;
+	u16 freq;
+
+	mutex_lock(&clock->clock_lock);
+
+	err = get_freq(clock, &freq);
+	if (err) {
+		xrt_err(clock->pdev, "get freq failed, %d", err);
+		goto end;
+	}
+
+	err = get_freq_counter(clock, &clock_freq_counter);
+	if (err) {
+		xrt_err(clock->pdev, "get freq counter failed, %d", err);
+		goto end;
+	}
+
+	lookup_freq = find_matching_freq(freq, frequency_table,
+					 ARRAY_SIZE(frequency_table));
+	request_in_khz = lookup_freq * 1000;
+	tolerance = lookup_freq * 50;
+	if (tolerance < abs(clock_freq_counter - request_in_khz)) {
+		CLOCK_ERR(clock,
+			  "set clock(%s) failed, request %ukhz, actual %dkhz",
+			  clock->clock_ep_name, request_in_khz, clock_freq_counter);
+		err = -EDOM;
+	} else {
+		CLOCK_INFO(clock, "verified clock (%s)", clock->clock_ep_name);
+	}
+
+end:
+	mutex_unlock(&clock->clock_lock);
+	return err;
+}
+
+static int clock_init(struct clock *clock)
+{
+	struct xrt_subdev_platdata *pdata = DEV_PDATA(clock->pdev);
+	const u16 *freq;
+	int err = 0;
+
+	err = xrt_md_get_prop(DEV(clock->pdev), pdata->xsp_dtb,
+			      clock->clock_ep_name, NULL, XRT_MD_PROP_CLK_FREQ,
+		(const void **)&freq, NULL);
+	if (err) {
+		xrt_info(clock->pdev, "no default freq");
+		return 0;
+	}
+
+	err = set_freq(clock, be16_to_cpu(*freq));
+
+	return err;
+}
+
+static ssize_t freq_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct clock *clock = platform_get_drvdata(to_platform_device(dev));
+	ssize_t count;
+	u16 freq = 0;
+
+	count = clock_get_freq(clock, &freq, NULL);
+	if (count < 0)
+		return count;
+
+	count = snprintf(buf, 64, "%u\n", freq);
+
+	return count;
+}
+static DEVICE_ATTR_RO(freq);
+
+static struct attribute *clock_attrs[] = {
+	&dev_attr_freq.attr,
+	NULL,
+};
+
+static struct attribute_group clock_attr_group = {
+	.attrs = clock_attrs,
+};
+
+static int
+xrt_clock_leaf_call(struct platform_device *pdev, u32 cmd, void *arg)
+{
+	struct clock *clock;
+	int ret = 0;
+
+	clock = platform_get_drvdata(pdev);
+
+	switch (cmd) {
+	case XRT_XLEAF_EVENT:
+		/* Does not handle any event. */
+		break;
+	case XRT_CLOCK_SET: {
+		u16	freq = (u16)(uintptr_t)arg;
+
+		ret = set_freq(clock, freq);
+		break;
+	}
+	case XRT_CLOCK_VERIFY:
+		ret = clock_verify_freq(clock);
+		break;
+	case XRT_CLOCK_GET: {
+		struct xrt_clock_get *get =
+			(struct xrt_clock_get *)arg;
+
+		ret = clock_get_freq(clock, &get->freq, &get->freq_cnter);
+		break;
+	}
+	default:
+		xrt_err(pdev, "unsupported cmd %d", cmd);
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+static int clock_remove(struct platform_device *pdev)
+{
+	sysfs_remove_group(&pdev->dev.kobj, &clock_attr_group);
+
+	return 0;
+}
+
+static int clock_probe(struct platform_device *pdev)
+{
+	struct clock *clock = NULL;
+	void __iomem *base = NULL;
+	struct resource *res;
+	int ret;
+
+	clock = devm_kzalloc(&pdev->dev, sizeof(*clock), GFP_KERNEL);
+	if (!clock)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, clock);
+	clock->pdev = pdev;
+	mutex_init(&clock->clock_lock);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		ret = -EINVAL;
+		goto failed;
+	}
+
+	base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(base)) {
+		ret = PTR_ERR(base);
+		goto failed;
+	}
+
+	clock->regmap = devm_regmap_init_mmio(&pdev->dev, base, &clock_regmap_config);
+	if (IS_ERR(clock->regmap)) {
+		CLOCK_ERR(clock, "regmap %pR failed", res);
+		ret = PTR_ERR(clock->regmap);
+		goto failed;
+	}
+	clock->clock_ep_name = res->name;
+
+	ret = clock_init(clock);
+	if (ret)
+		goto failed;
+
+	ret = sysfs_create_group(&pdev->dev.kobj, &clock_attr_group);
+	if (ret) {
+		CLOCK_ERR(clock, "create clock attrs failed: %d", ret);
+		goto failed;
+	}
+
+	CLOCK_INFO(clock, "successfully initialized Clock subdev");
+
+	return 0;
+
+failed:
+	return ret;
+}
+
+static struct xrt_subdev_endpoints xrt_clock_endpoints[] = {
+	{
+		.xse_names = (struct xrt_subdev_ep_names[]) {
+			{ .regmap_name = "clkwiz" },
+			{ NULL },
+		},
+		.xse_min_ep = 1,
+	},
+	{ 0 },
+};
+
+static struct xrt_subdev_drvdata xrt_clock_data = {
+	.xsd_dev_ops = {
+		.xsd_leaf_call = xrt_clock_leaf_call,
+	},
+};
+
+static const struct platform_device_id xrt_clock_table[] = {
+	{ XRT_CLOCK, (kernel_ulong_t)&xrt_clock_data },
+	{ },
+};
+
+static struct platform_driver xrt_clock_driver = {
+	.driver = {
+		.name = XRT_CLOCK,
+	},
+	.probe = clock_probe,
+	.remove = clock_remove,
+	.id_table = xrt_clock_table,
+};
+
+XRT_LEAF_INIT_FINI_FUNC(XRT_SUBDEV_CLOCK, clock);
-- 
2.27.0


Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D26DB31E6BE
	for <lists+linux-fpga@lfdr.de>; Thu, 18 Feb 2021 08:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbhBRHK5 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 18 Feb 2021 02:10:57 -0500
Received: from mail-mw2nam12on2085.outbound.protection.outlook.com ([40.107.244.85]:34098
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231204AbhBRHHT (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 18 Feb 2021 02:07:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FHvIM24G8NBnSgwL4Le+getJ2mBVIEaCkYhf+LUgrUkJkOn5lfWKzM6fgDoWA44SFxzdLqBqVYQhCqKOjaEz6nDzCNF6wJjcl27nLisQ0pZ/kujBIOVJe4dHzPOK4l0kILpBPsRaxJ8Poe3qcclh0x69uYM11xJXj62LNBU9KHHrrF12kfTsMGdS2rjdzp21sUEk/97cdndastFqeIIdljNESlNH9nnVUZRE/sXk2EmB6k839SGSkfL6TstdHfUeAUtSDaLfmRFDQf5tlEOnDS6ku04sn065sPPPBp+U2NIq+l1fJMwHWv6ujcz5C3JiRjuuml8N+aTK1nJuXZlkmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fleb1iBzWsGyuP1NKtPAbxh0lsXBFDXwdSCSN3VjQjI=;
 b=BzAx9ilRgMYbv4dJFuVOr5FB2eyPsiBJlpqTdwjBBjDqyh6Hi4uA6LBrNi8Mm1qytdI0Qjp4gzc/1pwrVDZeO6zf4fJWAhLBbCHj+yM9jC+h6scpGaEqk+U0YXr64vJf6z875AZS9snkpjGOc1Ohm4TmwB04tJgPesgxbMH8eHhbyiFKIBqt5MXFDOzeu8pZOTWidGIo/tfmz+qrd+tj7R9YMKlVWNanQ7AQoehPRwVDY1nHGAwctf1ahPSX0YpK7zmUxWDppiGXDpszvx2WbynGHJ34Kq7x1QK4Mz3X3fyaZ8OKEypminyOY3O8QRsiLy7ekz654ABLCA8BcKVXEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fleb1iBzWsGyuP1NKtPAbxh0lsXBFDXwdSCSN3VjQjI=;
 b=JMyhezEpGvvhZRSKrEXTUz3PH8SKM2B8J3t4a3SxClI5bMTNk3mxMYOl/yKiTxExGz8eE7eL2p6XY1p2XK5I0CVLbCtBbTb/TrzH8H5sAdHXbG2puDlP36FpteB6nPwI3SAOX83ynzYg0u/gzVmtDDpYmBLVM1Ip1LiLCrvVNDE=
Received: from CY4PR13CA0046.namprd13.prod.outlook.com (2603:10b6:903:99::32)
 by SN6PR02MB5536.namprd02.prod.outlook.com (2603:10b6:805:f0::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.31; Thu, 18 Feb
 2021 06:45:49 +0000
Received: from CY1NAM02FT051.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:99:cafe::79) by CY4PR13CA0046.outlook.office365.com
 (2603:10b6:903:99::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.12 via Frontend
 Transport; Thu, 18 Feb 2021 06:45:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 CY1NAM02FT051.mail.protection.outlook.com (10.152.74.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3868.27 via Frontend Transport; Thu, 18 Feb 2021 06:45:49 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Wed, 17 Feb 2021 22:45:40 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Wed, 17 Feb 2021 22:45:40 -0800
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
Received: from [172.19.72.212] (port=40188 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1lCd4G-0000l4-2o; Wed, 17 Feb 2021 22:45:40 -0800
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id 795F860012B; Wed, 17 Feb 2021 22:41:06 -0800 (PST)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhih@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>, Max Zhen <max.zhen@xilinx.com>
Subject: [PATCH V3 XRT Alveo 14/18] fpga: xrt: clock platform driver
Date:   Wed, 17 Feb 2021 22:40:15 -0800
Message-ID: <20210218064019.29189-15-lizhih@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210218064019.29189-1-lizhih@xilinx.com>
References: <20210218064019.29189-1-lizhih@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6cb7b324-7a25-4f19-4911-08d8d3d8d3e0
X-MS-TrafficTypeDiagnostic: SN6PR02MB5536:
X-Microsoft-Antispam-PRVS: <SN6PR02MB553690C1D48821D574143843A1859@SN6PR02MB5536.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q7wdU5+kUoyB8Z+fjIyCkpYXwI297eol5QnHU+v54UnXHtHIs1CVE3DgHY4Vf7wKHw3Xhrg6itSEsGSOygUrftz668KKo9m9Gx/SffIKDgrRatbZ9Z/Zn7KqDUid8sPT01hm91tWvWcZimXB0HUCHiFyNcYI9Tl60VeOm4IoIZ8cIUy/DVttEsl7e2RC02TXRNLNpOXL+T+12p5O4QcTvr3USMHXYni0aZhOBNLY0OSQVE3Tsmdpv1uFaf+01BbPuCqhFgFwV2pHc8jPlLPRIz1qjFh6TGeVlBQFHUCE7+FH5TOXwci5ZHb767VZplUl/GZHhu/6G2N+CQBfupdvduq1KN8/oZrhA/1YJVF7Fd0l5YWhxByAfHC9r/ac0qLbYa/3EB4/huEor8PwkMzgN4JkbceBaV12ZDipSBCx3buC0n5cHVVVsGtAJWXznv8x2Nc3e8tZaAvTV2nBOLxyu16EeBLeKXmyZJej8/cH2Dm2eOwe3KmHS2cXoioWZ81PrBovq+JVNYA0b5wXGKu26BB3pjCnEcpUl35cNS/FA1XeOWXbwO6l05A605XTsMggSPwUNy6mze/zgnW29yH83vWSOMf1vGCW1A8iEp3U0VY/eOK7HeYD27cpKdrqG9+zCiBAX+v4p2ziIXxU89L19VfC1yao+hrqasoJNFX5nYU=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(396003)(39860400002)(46966006)(36840700001)(316002)(8936002)(70206006)(6666004)(6916009)(6266002)(478600001)(1076003)(336012)(36860700001)(42186006)(36756003)(8676002)(2616005)(83380400001)(54906003)(2906002)(30864003)(107886003)(36906005)(82740400003)(4326008)(70586007)(47076005)(426003)(82310400003)(356005)(7636003)(5660300002)(44832011)(26005)(186003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2021 06:45:49.3389
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cb7b324-7a25-4f19-4911-08d8d3d8d3e0
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT051.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5536
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Add clock driver. Clock is a hardware function discovered by walking
xclbin metadata. A platform device node will be created for it. Other
part of driver configures clock through clock driver.

Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
Signed-off-by: Max Zhen <max.zhen@xilinx.com>
Signed-off-by: Lizhi Hou <lizhih@xilinx.com>
---
 drivers/fpga/xrt/include/xleaf/clock.h |  31 ++
 drivers/fpga/xrt/lib/xleaf/clock.c     | 648 +++++++++++++++++++++++++
 2 files changed, 679 insertions(+)
 create mode 100644 drivers/fpga/xrt/include/xleaf/clock.h
 create mode 100644 drivers/fpga/xrt/lib/xleaf/clock.c

diff --git a/drivers/fpga/xrt/include/xleaf/clock.h b/drivers/fpga/xrt/include/xleaf/clock.h
new file mode 100644
index 000000000000..a2da59b32551
--- /dev/null
+++ b/drivers/fpga/xrt/include/xleaf/clock.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Header file for XRT Clock Leaf Driver
+ *
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
+ * CLOCK driver IOCTL calls.
+ */
+enum xrt_clock_ioctl_cmd {
+	XRT_CLOCK_SET = XRT_XLEAF_CUSTOM_BASE, /* See comments in xleaf.h */
+	XRT_CLOCK_GET,
+	XRT_CLOCK_VERIFY,
+};
+
+struct xrt_clock_ioctl_get {
+	u16 freq;
+	u32 freq_cnter;
+};
+
+#endif	/* _XRT_CLOCK_H_ */
diff --git a/drivers/fpga/xrt/lib/xleaf/clock.c b/drivers/fpga/xrt/lib/xleaf/clock.c
new file mode 100644
index 000000000000..a067b501a607
--- /dev/null
+++ b/drivers/fpga/xrt/lib/xleaf/clock.c
@@ -0,0 +1,648 @@
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
+#include <linux/io.h>
+#include "metadata.h"
+#include "xleaf.h"
+#include "xleaf/clock.h"
+#include "xleaf/clkfreq.h"
+
+/* CLOCK_MAX_NUM_CLOCKS should be a concept from XCLBIN_ in the future */
+#define CLOCK_MAX_NUM_CLOCKS		4
+#define OCL_CLKWIZ_STATUS_OFFSET	0x4
+#define OCL_CLKWIZ_STATUS_MASK		0xffff
+#define OCL_CLKWIZ_STATUS_MEASURE_START	0x1
+#define OCL_CLKWIZ_STATUS_MEASURE_DONE	0x2
+#define OCL_CLKWIZ_CONFIG_OFFSET(n)	(0x200 + 4 * (n))
+#define CLOCK_DEFAULT_EXPIRE_SECS	1
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
+struct clock {
+	struct platform_device  *pdev;
+	void __iomem		*clock_base;
+	struct mutex		clock_lock; /* clock dev lock */
+
+	const char		*clock_ep_name;
+};
+
+/*
+ * Precomputed table with config0 and config2 register values together with
+ * target frequency. The steps are approximately 5 MHz apart. Table is
+ * generated by wiz.pl.
+ */
+static const struct xmgmt_ocl_clockwiz {
+	/* target frequency */
+	unsigned short ocl;
+	/* config0 register */
+	unsigned long config0;
+	/* config2 register */
+	unsigned int config2;
+} frequency_table[] = {
+	{/*1275.000*/	10.000,		0x02EE0C01,	0x0001F47F},
+	{/*1575.000*/   15.000,		0x02EE0F01,     0x00000069},
+	{/*1600.000*/   20.000,		0x00001001,     0x00000050},
+	{/*1600.000*/   25.000,		0x00001001,     0x00000040},
+	{/*1575.000*/   30.000,		0x02EE0F01,     0x0001F434},
+	{/*1575.000*/   35.000,		0x02EE0F01,     0x0000002D},
+	{/*1600.000*/   40.000,		0x00001001,     0x00000028},
+	{/*1575.000*/   45.000,		0x02EE0F01,     0x00000023},
+	{/*1600.000*/   50.000,		0x00001001,     0x00000020},
+	{/*1512.500*/   55.000,		0x007D0F01,     0x0001F41B},
+	{/*1575.000*/   60.000,		0x02EE0F01,     0x0000FA1A},
+	{/*1462.500*/   65.000,		0x02710E01,     0x0001F416},
+	{/*1575.000*/   70.000,		0x02EE0F01,     0x0001F416},
+	{/*1575.000*/   75.000,		0x02EE0F01,     0x00000015},
+	{/*1600.000*/   80.000,		0x00001001,     0x00000014},
+	{/*1487.500*/   85.000,		0x036B0E01,     0x0001F411},
+	{/*1575.000*/   90.000,		0x02EE0F01,     0x0001F411},
+	{/*1425.000*/   95.000,		0x00FA0E01,     0x0000000F},
+	{/*1600.000*/   100.000,	0x00001001,     0x00000010},
+	{/*1575.000*/   105.000,	0x02EE0F01,     0x0000000F},
+	{/*1512.500*/   110.000,	0x007D0F01,     0x0002EE0D},
+	{/*1437.500*/   115.000,	0x01770E01,     0x0001F40C},
+	{/*1575.000*/   120.000,	0x02EE0F01,     0x00007D0D},
+	{/*1562.500*/   125.000,	0x02710F01,     0x0001F40C},
+	{/*1462.500*/   130.000,	0x02710E01,     0x0000FA0B},
+	{/*1350.000*/   135.000,	0x01F40D01,     0x0000000A},
+	{/*1575.000*/   140.000,	0x02EE0F01,     0x0000FA0B},
+	{/*1450.000*/   145.000,	0x01F40E01,     0x0000000A},
+	{/*1575.000*/   150.000,	0x02EE0F01,     0x0001F40A},
+	{/*1550.000*/   155.000,	0x01F40F01,     0x0000000A},
+	{/*1600.000*/   160.000,	0x00001001,     0x0000000A},
+	{/*1237.500*/   165.000,	0x01770C01,     0x0001F407},
+	{/*1487.500*/   170.000,	0x036B0E01,     0x0002EE08},
+	{/*1575.000*/   175.000,	0x02EE0F01,     0x00000009},
+	{/*1575.000*/   180.000,	0x02EE0F01,     0x0002EE08},
+	{/*1387.500*/   185.000,	0x036B0D01,     0x0001F407},
+	{/*1425.000*/   190.000,	0x00FA0E01,     0x0001F407},
+	{/*1462.500*/   195.000,	0x02710E01,     0x0001F407},
+	{/*1600.000*/   200.000,	0x00001001,     0x00000008},
+	{/*1537.500*/   205.000,        0x01770F01,     0x0001F407},
+	{/*1575.000*/   210.000,        0x02EE0F01,     0x0001F407},
+	{/*1075.000*/   215.000,        0x02EE0A01,     0x00000005},
+	{/*1512.500*/   220.000,        0x007D0F01,     0x00036B06},
+	{/*1575.000*/   225.000,        0x02EE0F01,     0x00000007},
+	{/*1437.500*/   230.000,        0x01770E01,     0x0000FA06},
+	{/*1175.000*/   235.000,        0x02EE0B01,     0x00000005},
+	{/*1500.000*/   240.000,        0x00000F01,     0x0000FA06},
+	{/*1225.000*/   245.000,        0x00FA0C01,     0x00000005},
+	{/*1562.500*/   250.000,        0x02710F01,     0x0000FA06},
+	{/*1275.000*/   255.000,        0x02EE0C01,     0x00000005},
+	{/*1462.500*/   260.000,        0x02710E01,     0x00027105},
+	{/*1325.000*/   265.000,        0x00FA0D01,     0x00000005},
+	{/*1350.000*/   270.000,        0x01F40D01,     0x00000005},
+	{/*1512.500*/   275.000,        0x007D0F01,     0x0001F405},
+	{/*1575.000*/   280.000,        0x02EE0F01,     0x00027105},
+	{/*1425.000*/   285.000,        0x00FA0E01,     0x00000005},
+	{/*1450.000*/   290.000,        0x01F40E01,     0x00000005},
+	{/*1475.000*/   295.000,        0x02EE0E01,     0x00000005},
+	{/*1575.000*/   300.000,        0x02EE0F01,     0x0000FA05},
+	{/*1525.000*/   305.000,        0x00FA0F01,     0x00000005},
+	{/*1550.000*/   310.000,        0x01F40F01,     0x00000005},
+	{/*1575.000*/   315.000,        0x02EE0F01,     0x00000005},
+	{/*1600.000*/   320.000,        0x00001001,     0x00000005},
+	{/*1462.500*/   325.000,        0x02710E01,     0x0001F404},
+	{/*1237.500*/   330.000,        0x01770C01,     0x0002EE03},
+	{/*837.500*/    335.000,        0x01770801,     0x0001F402},
+	{/*1487.500*/   340.000,        0x036B0E01,     0x00017704},
+	{/*862.500*/    345.000,        0x02710801,     0x0001F402},
+	{/*1575.000*/   350.000,        0x02EE0F01,     0x0001F404},
+	{/*887.500*/    355.000,        0x036B0801,     0x0001F402},
+	{/*1575.000*/   360.000,        0x02EE0F01,     0x00017704},
+	{/*912.500*/    365.000,        0x007D0901,     0x0001F402},
+	{/*1387.500*/   370.000,        0x036B0D01,     0x0002EE03},
+	{/*1500.000*/   375.000,        0x00000F01,     0x00000004},
+	{/*1425.000*/   380.000,        0x00FA0E01,     0x0002EE03},
+	{/*962.500*/    385.000,        0x02710901,     0x0001F402},
+	{/*1462.500*/   390.000,        0x02710E01,     0x0002EE03},
+	{/*987.500*/    395.000,        0x036B0901,     0x0001F402},
+	{/*1600.000*/   400.000,        0x00001001,     0x00000004},
+	{/*1012.500*/   405.000,        0x007D0A01,     0x0001F402},
+	{/*1537.500*/   410.000,        0x01770F01,     0x0002EE03},
+	{/*1037.500*/   415.000,        0x01770A01,     0x0001F402},
+	{/*1575.000*/   420.000,        0x02EE0F01,     0x0002EE03},
+	{/*1487.500*/   425.000,        0x036B0E01,     0x0001F403},
+	{/*1075.000*/   430.000,        0x02EE0A01,     0x0001F402},
+	{/*1087.500*/   435.000,        0x036B0A01,     0x0001F402},
+	{/*1375.000*/   440.000,        0x02EE0D01,     0x00007D03},
+	{/*1112.500*/   445.000,        0x007D0B01,     0x0001F402},
+	{/*1575.000*/   450.000,        0x02EE0F01,     0x0001F403},
+	{/*1137.500*/   455.000,        0x01770B01,     0x0001F402},
+	{/*1437.500*/   460.000,        0x01770E01,     0x00007D03},
+	{/*1162.500*/   465.000,        0x02710B01,     0x0001F402},
+	{/*1175.000*/   470.000,        0x02EE0B01,     0x0001F402},
+	{/*1425.000*/   475.000,        0x00FA0E01,     0x00000003},
+	{/*1500.000*/   480.000,        0x00000F01,     0x00007D03},
+	{/*1212.500*/   485.000,        0x007D0C01,     0x0001F402},
+	{/*1225.000*/   490.000,        0x00FA0C01,     0x0001F402},
+	{/*1237.500*/   495.000,        0x01770C01,     0x0001F402},
+	{/*1562.500*/   500.000,        0x02710F01,     0x00007D03},
+	{/*1262.500*/   505.000,        0x02710C01,     0x0001F402},
+	{/*1275.000*/   510.000,        0x02EE0C01,     0x0001F402},
+	{/*1287.500*/   515.000,        0x036B0C01,     0x0001F402},
+	{/*1300.000*/   520.000,        0x00000D01,     0x0001F402},
+	{/*1575.000*/   525.000,        0x02EE0F01,     0x00000003},
+	{/*1325.000*/   530.000,        0x00FA0D01,     0x0001F402},
+	{/*1337.500*/   535.000,        0x01770D01,     0x0001F402},
+	{/*1350.000*/   540.000,        0x01F40D01,     0x0001F402},
+	{/*1362.500*/   545.000,        0x02710D01,     0x0001F402},
+	{/*1512.500*/   550.000,        0x007D0F01,     0x0002EE02},
+	{/*1387.500*/   555.000,        0x036B0D01,     0x0001F402},
+	{/*1400.000*/   560.000,        0x00000E01,     0x0001F402},
+	{/*1412.500*/   565.000,        0x007D0E01,     0x0001F402},
+	{/*1425.000*/   570.000,        0x00FA0E01,     0x0001F402},
+	{/*1437.500*/   575.000,        0x01770E01,     0x0001F402},
+	{/*1450.000*/   580.000,        0x01F40E01,     0x0001F402},
+	{/*1462.500*/   585.000,        0x02710E01,     0x0001F402},
+	{/*1475.000*/   590.000,        0x02EE0E01,     0x0001F402},
+	{/*1487.500*/   595.000,        0x036B0E01,     0x0001F402},
+	{/*1575.000*/   600.000,        0x02EE0F01,     0x00027102},
+	{/*1512.500*/   605.000,        0x007D0F01,     0x0001F402},
+	{/*1525.000*/   610.000,        0x00FA0F01,     0x0001F402},
+	{/*1537.500*/   615.000,        0x01770F01,     0x0001F402},
+	{/*1550.000*/   620.000,        0x01F40F01,     0x0001F402},
+	{/*1562.500*/   625.000,        0x02710F01,     0x0001F402},
+	{/*1575.000*/   630.000,        0x02EE0F01,     0x0001F402},
+	{/*1587.500*/   635.000,        0x036B0F01,     0x0001F402},
+	{/*1600.000*/   640.000,        0x00001001,     0x0001F402},
+	{/*1290.000*/   645.000,        0x01F44005,     0x00000002},
+	{/*1462.500*/   650.000,        0x02710E01,     0x0000FA02}
+};
+
+static inline u32 reg_rd(struct clock *clock, u32 offset)
+{
+	return ioread32(clock->clock_base + offset);
+}
+
+static inline void reg_wr(struct clock *clock, u32 val, u32 offset)
+{
+	iowrite32(val, clock->clock_base + offset);
+}
+
+static u32 find_matching_freq_config(unsigned short freq,
+				     const struct xmgmt_ocl_clockwiz *table,
+				     int size)
+{
+	u32 start = 0;
+	u32 end = size - 1;
+	u32 idx = size - 1;
+
+	if (freq < table[0].ocl)
+		return 0;
+
+	if (freq > table[size - 1].ocl)
+		return size - 1;
+
+	while (start < end) {
+		if (freq == table[idx].ocl)
+			break;
+		if (freq < table[idx].ocl)
+			end = idx;
+		else
+			start = idx + 1;
+		idx = start + (end - start) / 2;
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
+
+	val = reg_rd(clock, OCL_CLKWIZ_STATUS_OFFSET);
+	for (count = 0; val != 1 && count < cycle; count++) {
+		mdelay(interval);
+		val = reg_rd(clock, OCL_CLKWIZ_STATUS_OFFSET);
+	}
+	if (val != 1) {
+		CLOCK_ERR(clock, "clockwiz is (%u) busy after %d ms",
+			  val, cycle * interval);
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+static int get_freq(struct clock *clock, u16 *freq)
+{
+#define XCL_INPUT_FREQ 100
+	const u64 input = XCL_INPUT_FREQ;
+	u32 val;
+	u32 mul0, div0;
+	u32 mul_frac0 = 0;
+	u32 div1;
+	u32 div_frac1 = 0;
+
+	WARN_ON(!mutex_is_locked(&clock->clock_lock));
+
+	val = reg_rd(clock, OCL_CLKWIZ_STATUS_OFFSET);
+	if ((val & 0x1) == 0) {
+		CLOCK_ERR(clock, "clockwiz is busy %x", val);
+		*freq = 0;
+		return -EBUSY;
+	}
+
+	val = reg_rd(clock, OCL_CLKWIZ_CONFIG_OFFSET(0));
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
+	val = reg_rd(clock, OCL_CLKWIZ_CONFIG_OFFSET(2));
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
+	*freq = (u16)((input * mul0) / div0);
+
+	return 0;
+}
+
+static int set_freq(struct clock *clock, u16 freq)
+{
+	u32 config;
+	int err;
+	u32 idx = 0;
+	u32 val;
+
+	WARN_ON(!mutex_is_locked(&clock->clock_lock));
+
+	idx = find_matching_freq_config(freq, frequency_table,
+					ARRAY_SIZE(frequency_table));
+
+	CLOCK_INFO(clock, "New: %d Mhz", freq);
+	err = clock_wiz_busy(clock, 20, 50);
+	if (err)
+		return -EBUSY;
+
+	config = frequency_table[idx].config0;
+	reg_wr(clock, config, OCL_CLKWIZ_CONFIG_OFFSET(0));
+
+	config = frequency_table[idx].config2;
+	reg_wr(clock, config, OCL_CLKWIZ_CONFIG_OFFSET(2));
+
+	mdelay(10);
+	reg_wr(clock, 7, OCL_CLKWIZ_CONFIG_OFFSET(23));
+
+	mdelay(1);
+	reg_wr(clock, 2, OCL_CLKWIZ_CONFIG_OFFSET(23));
+
+	CLOCK_INFO(clock, "clockwiz waiting for locked signal");
+
+	err = clock_wiz_busy(clock, 100, 100);
+	if (err) {
+		CLOCK_ERR(clock, "clockwiz MMCM/PLL did not lock");
+		/* restore */
+		reg_wr(clock, 4, OCL_CLKWIZ_CONFIG_OFFSET(23));
+		mdelay(10);
+		reg_wr(clock, 0, OCL_CLKWIZ_CONFIG_OFFSET(23));
+		return err;
+	}
+	val = reg_rd(clock, OCL_CLKWIZ_CONFIG_OFFSET(0));
+	CLOCK_INFO(clock, "clockwiz CONFIG(0) 0x%x", val);
+	val = reg_rd(clock, OCL_CLKWIZ_CONFIG_OFFSET(2));
+	CLOCK_INFO(clock, "clockwiz CONFIG(2) 0x%x", val);
+
+	return 0;
+}
+
+static int get_freq_counter(struct clock *clock, u32 *freq)
+{
+	const void *cnter;
+	struct platform_device *cnter_leaf;
+	struct platform_device *pdev = clock->pdev;
+	struct xrt_subdev_platdata *pdata = DEV_PDATA(clock->pdev);
+	int err = xrt_md_get_prop(DEV(pdev), pdata->xsp_dtb,
+		clock->clock_ep_name, NULL, XRT_MD_PROP_CLK_CNT, &cnter, NULL);
+
+	WARN_ON(!mutex_is_locked(&clock->clock_lock));
+
+	if (err) {
+		xrt_err(pdev, "no counter specified");
+		return err;
+	}
+
+	cnter_leaf = xleaf_get_leaf_by_epname(pdev, cnter);
+	if (!cnter_leaf) {
+		xrt_err(pdev, "can't find counter");
+		return -ENOENT;
+	}
+
+	err = xleaf_ioctl(cnter_leaf, XRT_CLKFREQ_READ, freq);
+	if (err)
+		xrt_err(pdev, "can't read counter");
+	xleaf_put_leaf(clock->pdev, cnter_leaf);
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
+static int clock_set_freq(struct clock *clock, u16 freq)
+{
+	int err;
+
+	mutex_lock(&clock->clock_lock);
+	err = set_freq(clock, freq);
+	mutex_unlock(&clock->clock_lock);
+
+	return err;
+}
+
+static int clock_verify_freq(struct clock *clock)
+{
+	int err = 0;
+	u16 freq;
+	u32 lookup_freq, clock_freq_counter, request_in_khz, tolerance;
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
+	int err = 0;
+	const u16 *freq;
+
+	err = xrt_md_get_prop(DEV(clock->pdev), pdata->xsp_dtb,
+			      clock->clock_ep_name, NULL, XRT_MD_PROP_CLK_FREQ,
+		(const void **)&freq, NULL);
+	if (err) {
+		xrt_info(clock->pdev, "no default freq");
+		return 0;
+	}
+
+	mutex_lock(&clock->clock_lock);
+	err = set_freq(clock, be16_to_cpu(*freq));
+	mutex_unlock(&clock->clock_lock);
+
+	return err;
+}
+
+static ssize_t freq_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct clock *clock = platform_get_drvdata(to_platform_device(dev));
+	u16 freq = 0;
+	ssize_t count;
+
+	count = clock_get_freq(clock, &freq, NULL);
+	if (count < 0)
+		return count;
+
+	count = snprintf(buf, 64, "%d\n", freq);
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
+xrt_clock_leaf_ioctl(struct platform_device *pdev, u32 cmd, void *arg)
+{
+	struct clock		*clock;
+	int			ret = 0;
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
+		ret = clock_set_freq(clock, freq);
+		break;
+	}
+	case XRT_CLOCK_VERIFY: {
+		ret = clock_verify_freq(clock);
+		break;
+	}
+	case XRT_CLOCK_GET: {
+		struct xrt_clock_ioctl_get *get =
+			(struct xrt_clock_ioctl_get *)arg;
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
+	struct clock *clock;
+
+	clock = platform_get_drvdata(pdev);
+	if (!clock) {
+		xrt_err(pdev, "driver data is NULL");
+		return -EINVAL;
+	}
+
+	platform_set_drvdata(pdev, NULL);
+	devm_kfree(&pdev->dev, clock);
+
+	CLOCK_INFO(clock, "successfully removed Clock subdev");
+	return 0;
+}
+
+static int clock_probe(struct platform_device *pdev)
+{
+	struct clock *clock = NULL;
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
+	clock->clock_base = ioremap(res->start, res->end - res->start + 1);
+	if (!clock->clock_base) {
+		CLOCK_ERR(clock, "map base %pR failed", res);
+		ret = -EFAULT;
+		goto failed;
+	}
+
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
+	clock_remove(pdev);
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
+		.xsd_ioctl = xrt_clock_leaf_ioctl,
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
+void clock_leaf_init_fini(bool init)
+{
+	if (init)
+		xleaf_register_driver(XRT_SUBDEV_CLOCK, &xrt_clock_driver, xrt_clock_endpoints);
+	else
+		xleaf_unregister_driver(XRT_SUBDEV_CLOCK);
+}
-- 
2.18.4


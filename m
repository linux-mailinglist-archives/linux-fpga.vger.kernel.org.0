Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2882F7012
	for <lists+linux-fpga@lfdr.de>; Fri, 15 Jan 2021 02:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731577AbhAOBle (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 14 Jan 2021 20:41:34 -0500
Received: from mail-bn8nam12on2066.outbound.protection.outlook.com ([40.107.237.66]:8489
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731508AbhAOBlc (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 14 Jan 2021 20:41:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AVPGz6AHQJORLJBVhGmviel/jrSV4TJ4ROPqenBKsKvRR3lzdknJiKfyjzZQNKvmIaa20YsnHoLx+aaGthvMRE7dOjehKkQ/ArejLnC26dBKUgEbEPfJp/Lx8hz0+arMKNhE/uI070Y7MXPCXAugOPiNqWYW4uFY/vHducheLKOIM4H96i9dRt5payHJmhe+aX827cvjF6oyJEYHB5uOyyLwZy0vbMqFCIZyQO1u2EiVv2vZh8O4cuUCuPS39WXQpZ3LBZOZzh6rMjMz+b3gdSR0+bSTLZhMqTZExEO3X+HaE1OUlj3n237sxdfVk3HBkBZF78TNmmhr7j35Zb2Xuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NmHDNegEhJNN2UarhCiLwJmdB4ze1rwdTXyW7SSCoBk=;
 b=lx7TQiLNnukGBWToK5B9zs9FP6TBVzJGXkksqyEhtV4EatrCkHzstQv4fDcSzvgNh3/psWIoKJFYUxQqCZkDAwbW+G56uj1gXhZoc3ApYRbQyVkOu8ZmblYKVupG+zyrB9qhnAZqndMAj/nuRBn/n9wHgmUA463oU3TgX4qc8GUOwYDbmMQxQQWLa3GxlnY3kRJFeTqza/A2NbNFOcxV3vb26UIFqEv08jvkHQH2k1lTwz3hMbC8/vgFS9PgvAkzQyh5CuoQD8a6yJQtTzvi7JLKNy4QFiUGjfW1ArThXb3aY5fV+L52yZHQhzZLtbChNopRDcz2xKhMwFnH4Famhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NmHDNegEhJNN2UarhCiLwJmdB4ze1rwdTXyW7SSCoBk=;
 b=AWxSUvXyM1F+PjFCwGEEU3qP+HDtkFsu93d6gtvB8hUx0PgH1sQezSnOkw/FUPWIJ4H5GC3Ms+88+y6Hma+t/jLWu9NfPVlsZRIRbZFsMy1SJMzDrMnruAvQW/5wEAsP0SCJ54iUgLCX6tWZJqY/ppvtg77G1yGl1Vi2yCI56Vk=
Received: from CY4PR1201CA0003.namprd12.prod.outlook.com
 (2603:10b6:910:16::13) by DM5PR02MB3896.namprd02.prod.outlook.com
 (2603:10b6:4:b7::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.12; Fri, 15 Jan
 2021 01:40:38 +0000
Received: from CY1NAM02FT064.eop-nam02.prod.protection.outlook.com
 (2603:10b6:910:16:cafe::4f) by CY4PR1201CA0003.outlook.office365.com
 (2603:10b6:910:16::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9 via Frontend
 Transport; Fri, 15 Jan 2021 01:40:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 CY1NAM02FT064.mail.protection.outlook.com (10.152.74.64) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3742.6 via Frontend Transport; Fri, 15 Jan 2021 01:40:37 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Thu, 14 Jan 2021 17:40:27 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Thu, 14 Jan 2021 17:40:27 -0800
Envelope-to: git@xilinx.com,
 michal.simek@xilinx.com,
 mdf@kernel.org,
 trix@redhat.com,
 robh+dt@kernel.org,
 linux-fpga@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 chinnikishore369@gmail.com
Received: from [10.140.6.60] (port=56178 helo=xhdnavam40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <nava.manne@xilinx.com>)
        id 1l0E6E-0007vy-G9; Thu, 14 Jan 2021 17:40:26 -0800
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <mdf@kernel.org>, <trix@redhat.com>, <robh+dt@kernel.org>,
        <michal.simek@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <git@xilinx.com>, <chinnikishore369@gmail.com>,
        Nava kishore Manne <nava.manne@xilinx.com>
Subject: [PATCH 2/2] fpga: Add support for Xilinx DFX AXI Shutdown manager
Date:   Fri, 15 Jan 2021 07:04:31 +0530
Message-ID: <20210115013431.27667-2-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210115013431.27667-1-nava.manne@xilinx.com>
References: <20210115013431.27667-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 30cefe67-9770-4695-c7ac-08d8b8f68f62
X-MS-TrafficTypeDiagnostic: DM5PR02MB3896:
X-Microsoft-Antispam-PRVS: <DM5PR02MB3896491C830C5719849B686AC2A70@DM5PR02MB3896.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lDRsbvcLI85gSjZGDzViMaVK/o6lpilom50jOoBbpwvWcgRS2RMDdOLA7Y5EsloLCQJMiyrctuMvOv5/1sZG3OpJGxVhYsov8uRK3wOq7vx/ZLLHce8e6RBAcEVnBmYJsPcnkGJQR8bqTf/6f15s0cSbwaDuCZy6OtFaIO0F4tip+XkZY3KF8HBDjVGgmkLhDqJDgxg0CCjPnY7pDzCt7C9kFQF9Bo07HWbE7rdLKF1p2f2ViEM9nB24JScLo4oVamIy/SrY+NO90i2efAwVgpgj07Wcgs8pQyXCNOpn+domrVPlZurLhJuKnk8mtT5gGnfzqUnFtHnOj+RLeWayCxF4VKJ1nU+/q+zK6XHJ2zOcn5uNIZO3OehNX2g71lDfO5KwlyGHRznJeuJ2Oy6tuGjYedfS4waNyTJ9MH2ypX6/VCxLeNeScPldFnJvYFpzkSLQ/VXuYW1/h69iSzF9vDLlv+B4HYibpzXEAakUA4+nOk1NrRu7y7quCBmq3fe+N5vl9VlHuHqsx13JvzZzlke5Q2as5Jw+JlCGoyhwRco=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(396003)(39860400002)(136003)(346002)(376002)(46966006)(4326008)(70206006)(2616005)(34020700004)(426003)(107886003)(8936002)(82740400003)(8676002)(356005)(6666004)(70586007)(9786002)(82310400003)(7696005)(110136005)(36906005)(478600001)(36756003)(186003)(5660300002)(316002)(83380400001)(1076003)(26005)(2906002)(336012)(47076005)(54906003)(7636003)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2021 01:40:37.9276
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30cefe67-9770-4695-c7ac-08d8b8f68f62
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT064.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB3896
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

This patch adds support for Xilinx Dynamic Function eXchange(DFX) AXI
shutdown manager IP. It can be used to safely handling the AXI traffic
on a Reconfigurable Partition when it is undergoing dynamic reconfiguration
and there by preventing system deadlock that may occur if AXI transactions
are interrupted during reconfiguration.

PR-Decoupler and AXI shutdown manager are completely different IPs.
But both the IP registers are compatible and also both belong to the
same sub-system (fpga-bridge).So using same driver for both IP's.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
 drivers/fpga/xilinx-pr-decoupler.c | 35 ++++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/drivers/fpga/xilinx-pr-decoupler.c b/drivers/fpga/xilinx-pr-decoupler.c
index 7d69af230567..c95f3d065ccb 100644
--- a/drivers/fpga/xilinx-pr-decoupler.c
+++ b/drivers/fpga/xilinx-pr-decoupler.c
@@ -19,10 +19,15 @@
 #define CTRL_OFFSET		0
 
 struct xlnx_pr_decoupler_data {
+	const struct xlnx_config_data *ipconfig;
 	void __iomem *io_base;
 	struct clk *clk;
 };
 
+struct xlnx_config_data {
+	char *name;
+};
+
 static inline void xlnx_pr_decoupler_write(struct xlnx_pr_decoupler_data *d,
 					   u32 offset, u32 val)
 {
@@ -76,15 +81,28 @@ static const struct fpga_bridge_ops xlnx_pr_decoupler_br_ops = {
 	.enable_show = xlnx_pr_decoupler_enable_show,
 };
 
+static const struct xlnx_config_data decoupler_config = {
+	.name = "Xilinx PR Decoupler",
+};
+
+static const struct xlnx_config_data shutdown_config = {
+	.name = "Xilinx DFX AXI shutdown mgr",
+};
+
 static const struct of_device_id xlnx_pr_decoupler_of_match[] = {
-	{ .compatible = "xlnx,pr-decoupler-1.00", },
-	{ .compatible = "xlnx,pr-decoupler", },
+	{ .compatible = "xlnx,pr-decoupler-1.00", .data = &decoupler_config },
+	{ .compatible = "xlnx,pr-decoupler", .data = &decoupler_config },
+	{ .compatible = "xlnx,dfx-axi-shutdown-manager-1.00",
+					.data = &shutdown_config },
+	{ .compatible = "xlnx,dfx-axi-shutdown-manager",
+					.data = &shutdown_config },
 	{},
 };
 MODULE_DEVICE_TABLE(of, xlnx_pr_decoupler_of_match);
 
 static int xlnx_pr_decoupler_probe(struct platform_device *pdev)
 {
+	struct device_node *np = pdev->dev.of_node;
 	struct xlnx_pr_decoupler_data *priv;
 	struct fpga_bridge *br;
 	int err;
@@ -94,6 +112,14 @@ static int xlnx_pr_decoupler_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
+	if (np) {
+		const struct of_device_id *match;
+
+		match = of_match_node(xlnx_pr_decoupler_of_match, np);
+		if (match && match->data)
+			priv->ipconfig = match->data;
+	}
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	priv->io_base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(priv->io_base))
@@ -114,7 +140,7 @@ static int xlnx_pr_decoupler_probe(struct platform_device *pdev)
 
 	clk_disable(priv->clk);
 
-	br = devm_fpga_bridge_create(&pdev->dev, "Xilinx PR Decoupler",
+	br = devm_fpga_bridge_create(&pdev->dev, priv->ipconfig->name,
 				     &xlnx_pr_decoupler_br_ops, priv);
 	if (!br) {
 		err = -ENOMEM;
@@ -125,7 +151,8 @@ static int xlnx_pr_decoupler_probe(struct platform_device *pdev)
 
 	err = fpga_bridge_register(br);
 	if (err) {
-		dev_err(&pdev->dev, "unable to register Xilinx PR Decoupler");
+		dev_err(&pdev->dev, "unable to register %s",
+			priv->ipconfig->name);
 		goto err_clk;
 	}
 
-- 
2.18.0


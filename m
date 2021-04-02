Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A880D3528B4
	for <lists+linux-fpga@lfdr.de>; Fri,  2 Apr 2021 11:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234914AbhDBJ3D (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 2 Apr 2021 05:29:03 -0400
Received: from mail-mw2nam10on2047.outbound.protection.outlook.com ([40.107.94.47]:24129
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234880AbhDBJ3B (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 2 Apr 2021 05:29:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CvbknA7eFTuhOAKBJZ0GLF1ABgnGzHxO3NYomq3oCtgr6wvLYcAW9ffW1odun1JGdbtEyU3m/yatAM1nrZ0sx8z/njnARUy9/bNSXpywkBSM4Mq8l3lUblE0IPZSTija6YFOSbYes7vD6p9Lrky5hymxeYNnflNugn0QhDgwr3X8ZZdlo63F0+9+mJXLPF9OnMu5qEJ9hb7150KeN7FedtAMuE4Ghg0U5M2hgXpIw00T7IbhITts3b69QrwIuIMC+lWSi2tymhI+hnaB3S42/9/Wm+wGP/laqT2jXon9mwSEgu+5G82I3RQxqID6z/5r4Mf1Npr5McCD4XmSh8sTqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7WZtbO0Km5LUTy7eHBE588zQtaz6Za6sOzWyOFrb5Jc=;
 b=kIig8cuTP2AtbjqGYqLFcu1z9il0m3BawlMzRqyBgQ5j4VZ+OF/4uj5VYmJvnKu9yUIPgQX5HCl4ozpoALDEoNaiKZEZ0JxaqZdwGc4MRV1joAPqT/lYwWYfFzoe5EAjVHYNhqlD62MlQ2msft6bcelW/MFZ5KlhC24SecMxrn76y/D53Aj76hXD6JKtCakBXddCLIw1QuREfkVpMWUPVgRkz3UFGEcpZVBQAs/3XW/snGi4mkQJVJkTOL8EHTHRzcGr+jKe7F5Nmqpbw2WFO0REW4QXUiU6D4mqhYHtrOu+cXN9m+lRTPZ3aPeL4yXmMRwh4ZNKoJAV42PFrq4xJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7WZtbO0Km5LUTy7eHBE588zQtaz6Za6sOzWyOFrb5Jc=;
 b=fIUmklOltH/KO8BnrS8xOY7sM7NeuJcY74uC9DYWSBAYLuPoq4jS4O76hYFbLZ02kkGeZc+KZX4Z4HF4dH2sHteH18sNph9+vLKHj0D57h6Vb2IemeY5VMGeclDx68zaBEWfFhgQNAWKv9AaNSUoVeyeZO62+ejX0EtO8wcJcu8=
Received: from SN7PR04CA0027.namprd04.prod.outlook.com (2603:10b6:806:f2::32)
 by BL0PR02MB5697.namprd02.prod.outlook.com (2603:10b6:208:85::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Fri, 2 Apr
 2021 09:28:58 +0000
Received: from SN1NAM02FT006.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:f2:cafe::6f) by SN7PR04CA0027.outlook.office365.com
 (2603:10b6:806:f2::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26 via Frontend
 Transport; Fri, 2 Apr 2021 09:28:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT006.mail.protection.outlook.com (10.152.72.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3999.28 via Frontend Transport; Fri, 2 Apr 2021 09:28:57 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 2 Apr 2021 02:28:54 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2106.2 via Frontend Transport; Fri, 2 Apr 2021 02:28:54 -0700
Envelope-to: git@xilinx.com,
 mdf@kernel.org,
 trix@redhat.com,
 robh+dt@kernel.org,
 linux-fpga@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Received: from [10.140.6.60] (port=58326 helo=xhdnavam40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <nava.manne@xilinx.com>)
        id 1lSG6m-0005gX-ST; Fri, 02 Apr 2021 02:28:53 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <mdf@kernel.org>, <trix@redhat.com>, <robh+dt@kernel.org>,
        <michal.simek@xilinx.com>, <nava.manne@xilinx.com>,
        <linux-fpga@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <git@xilinx.com>
Subject: [PATCH 3/3] fpga: region: Adds runtime PM support
Date:   Fri, 2 Apr 2021 14:50:49 +0530
Message-ID: <20210402092049.479-4-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210402092049.479-1-nava.manne@xilinx.com>
References: <20210402092049.479-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c3bd0c6-dff7-4fc8-d98d-08d8f5b9be0d
X-MS-TrafficTypeDiagnostic: BL0PR02MB5697:
X-Microsoft-Antispam-PRVS: <BL0PR02MB5697754DFB908B0BFA8FEDFDC27A9@BL0PR02MB5697.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n64styQM7ZIqYqa2Dt1XKEO2j2GIYo6JrgmgjRIEgX0d/QE3vofWZOIb61jj2q0gWRCvqnjEQHpWb1aglAnZlNd28BOuZsSvXYxFZfi800x9sKaN0JtHFgQxvUjA23oqLJK4HPk1Xk2+ExQgnogLMWMXUepG/Z0FcaZ5QeMBcaGWa07eweWGiFHJ8SJkH0cTvMreprsrEAi/OMEwSWiTXhSNHUMzYQbj8anEJZX+KCRFtzS71P8D+BUAlVXyHlCq57gJhYBKzcSQ2szEDEwL6+97eOcCmNMt0ue+z6QDiK9HNz0g+WNK4tb7nHabHRmCCa/sUueGXabT0Oq6Z6QCZsICpXakuaGRFaWlPbApmEVny6o0zPiohMeCeWDx2Qz1jLaFqxSApIEFfk0h5BUTJzJgF5evKOtoWQs87XfG3PXaDzRy2AMvt51DxyrXHP9TdszyGPNpfl9xgN6fHEOgdvHw5l7WatKHdtkOQc6HtluCrKbnka8Cqpob+MnU8fXFYO1DdvmMRIs74V/BmHAFtUkp+3MY/4lceIKsLWJZt5PD0gVT4+RA/dxM5tF3Q4on2sOFr0z2oXbTq3bGIB2ils1ykMEmuioiEupC8WQurRhxNN9UDPA/NZiMVSbIRr8LhZ+SUcSQeF2Wp23yNuwEJ4Cu0vBEYXsc0nZyY+A2WDNfo1zwAayRyTGkIWNxUiBL076QyhTHqTwQ5Ek9u20uLbZ7xS20vQWqsZ3zCHs0ZeGABAAOikjjooN+gsI2bOnG
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(396003)(39860400002)(46966006)(36840700001)(336012)(9786002)(478600001)(186003)(2906002)(8936002)(82310400003)(356005)(2616005)(6666004)(82740400003)(47076005)(7636003)(8676002)(921005)(7696005)(5660300002)(36860700001)(70206006)(36906005)(83380400001)(36756003)(426003)(26005)(70586007)(1076003)(316002)(110136005)(6636002)(102446001)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2021 09:28:57.8449
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c3bd0c6-dff7-4fc8-d98d-08d8f5b9be0d
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT006.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB5697
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Adds support to handle FPGA/PL power domain. With this patch,
the PL power domain will be turned on before loading the bitstream
and turned off while removing/unloading the bitstream using overlays.
This can be achieved by adding the runtime PM support.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
 drivers/fpga/of-fpga-region.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/fpga/of-fpga-region.c b/drivers/fpga/of-fpga-region.c
index e405309baadc..35fc2f3d4bd8 100644
--- a/drivers/fpga/of-fpga-region.c
+++ b/drivers/fpga/of-fpga-region.c
@@ -15,6 +15,7 @@
 #include <linux/of_platform.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/pm_runtime.h>
 
 static const struct of_device_id fpga_region_of_match[] = {
 	{ .compatible = "fpga-region", },
@@ -302,6 +303,7 @@ static int of_fpga_region_notify_pre_apply(struct fpga_region *region,
 	}
 
 	region->info = info;
+	pm_runtime_get_sync(dev->parent);
 	ret = fpga_region_program_fpga(region);
 	if (ret) {
 		/* error; reject overlay */
@@ -324,10 +326,13 @@ static int of_fpga_region_notify_pre_apply(struct fpga_region *region,
 static void of_fpga_region_notify_post_remove(struct fpga_region *region,
 					      struct of_overlay_notify_data *nd)
 {
+	struct device *dev = &region->dev;
+
 	fpga_bridges_disable(&region->bridge_list);
 	fpga_bridges_put(&region->bridge_list);
 	fpga_image_info_free(region->info);
 	region->info = NULL;
+	pm_runtime_put(dev->parent);
 }
 
 /**
@@ -411,9 +416,16 @@ static int of_fpga_region_probe(struct platform_device *pdev)
 		goto eprobe_mgr_put;
 	}
 
+	pm_runtime_enable(&pdev->dev);
+	ret = pm_runtime_get_sync(&pdev->dev);
+	if (ret < 0)
+		goto err_pm;
+
+	pm_runtime_put(&pdev->dev);
+
 	ret = fpga_region_register(region);
 	if (ret)
-		goto eprobe_mgr_put;
+		goto err_pm;
 
 	of_platform_populate(np, fpga_region_of_match, NULL, &region->dev);
 	platform_set_drvdata(pdev, region);
@@ -422,6 +434,9 @@ static int of_fpga_region_probe(struct platform_device *pdev)
 
 	return 0;
 
+err_pm:
+	pm_runtime_put(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
 eprobe_mgr_put:
 	fpga_mgr_put(mgr);
 	return ret;
@@ -434,6 +449,7 @@ static int of_fpga_region_remove(struct platform_device *pdev)
 
 	fpga_region_unregister(region);
 	fpga_mgr_put(mgr);
+	pm_runtime_disable(region->dev.parent);
 
 	return 0;
 }
-- 
2.18.0


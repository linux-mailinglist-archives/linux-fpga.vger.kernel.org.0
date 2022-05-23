Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE75531373
	for <lists+linux-fpga@lfdr.de>; Mon, 23 May 2022 18:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236490AbiEWNqW (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 23 May 2022 09:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236614AbiEWNqB (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 23 May 2022 09:46:01 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B352632;
        Mon, 23 May 2022 06:45:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XLbZwc85Huw4nDUb1VIJw8ZogJF/UOZzvERfrZy+SIaIVv6dQ2G1M/sZ/YJjF2mXTw6fnA3G52FStnCCphr8+Zp95iIa/IXrCATlhmxtwhfTqVwlFFCI3W4hWdSFIu1kP4ka1bZLO4RhNIT9SRdiArOMpOWiFMT78dmQO9NB+e8C6hfM5F0Z/bpsyheN9c1SyVjhENxynrXSyT1/7jYmhjCdsuZGBwFlw5UfWv2tnD5ZPfB0Sw2RxKHdHrayQKDjUEw1wl4EAn4apY0fYfMDBfGnF2eVC9Imr5lJOwyC96T7+Zwi+VXxhn+XYpWy5lMvR2QNXG3CCIJ3U0/ewK9qJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0uwHN2oj69xTfuVrTwOmq6FYI2g192WyEZmoFWEMzZY=;
 b=RalCOem5pARSV742Z0+ucoWRK4B4trWSaGye4q+TGPYBXCCjKCYDheJ1SIx/53O8YcYWbj6/+au3gOfg4IBg1i4uk5QFAimOucGPFwVkm5w3AVHWleXxNzL3nrr75idNBP6RfjK97wqX8jfUOgfotKHbSX3jRHvOcQ5Y6uNbMJ/+dNkusJUoRyXvTJVdLpLEn3jvFWBDaxhWVz6PjbxWa2/PSEyOy3hDBnnnZrrYBlQCL9DziOnI0+wBEIwsEciM10+/TwRSI+S5+oKGWBatNwAfMQaGL2l+PYMSA2IS3bmXSzewTR03ceT17eCDCbmSaPAJ843/88X7m8cYlsqfkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0uwHN2oj69xTfuVrTwOmq6FYI2g192WyEZmoFWEMzZY=;
 b=laX9wxLOsGtXi4qZENnIVELthcgJvSpIS1nGVFbXz0j958e0aryr+EH6vyOGX2oIHcQR3i+yrNQdtivYR8YIhMHw9mWbEbNeiS8ybKCEUdEw0XlpPxt+EUmoDxMiS3PQoSsgMQqyhmJoZUTecDzqK8RhHXnGnen5QJ+jNAvIGM4=
Received: from SN4PR0601CA0021.namprd06.prod.outlook.com
 (2603:10b6:803:2f::31) by PH0PR02MB7750.namprd02.prod.outlook.com
 (2603:10b6:510:5e::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Mon, 23 May
 2022 13:45:56 +0000
Received: from SN1NAM02FT0026.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:2f:cafe::fa) by SN4PR0601CA0021.outlook.office365.com
 (2603:10b6:803:2f::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.22 via Frontend
 Transport; Mon, 23 May 2022 13:45:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0026.mail.protection.outlook.com (10.97.5.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Mon, 23 May 2022 13:45:56 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 23 May 2022 06:45:48 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 23 May 2022 06:45:48 -0700
Envelope-to: git@xilinx.com,
 mdf@kernel.org,
 hao.wu@intel.com,
 yilun.xu@intel.com,
 trix@redhat.com,
 robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org,
 linux-fpga@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Received: from [10.140.6.60] (port=57798 helo=xhdnavam40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <nava.manne@xilinx.com>)
        id 1nt8NX-000GwK-Kl; Mon, 23 May 2022 06:45:48 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>,
        <trix@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <michal.simek@xilinx.com>,
        <nava.manne@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <git@xilinx.com>
Subject: [PATCH v2 3/3] fpga: region: Add runtime PM support
Date:   Mon, 23 May 2022 19:15:17 +0530
Message-ID: <20220523134517.4056873-4-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220523134517.4056873-1-nava.manne@xilinx.com>
References: <20220523134517.4056873-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5547734-ee85-4cec-0f5e-08da3cc29011
X-MS-TrafficTypeDiagnostic: PH0PR02MB7750:EE_
X-Microsoft-Antispam-PRVS: <PH0PR02MB7750C59358350FCC3342B158C2D49@PH0PR02MB7750.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6Q1jV34SDOJ0giSVHPWx4i3OXsga1IXmsUKWwMjWW2trlfUDe7KCkXzdRmMHsLR1sC2vPPxj1gkaASbZDUPJ7j6MiODVOAu2g71DRI2hwYYOzFTf0HyGwybvfrXbLo63T12wJmT+UE4PhuCt0VOsffvfB6TilzerAuQKgaHWeCxdBmEEYAwzqP2hWhl2lm47B2PG+KU2WbxFO8FHKjOo2u500sRNrelU1FsdcYnk3r+rSPKslwjRAImJaQ79yCTKxJuvlu8Ycj77/5GR135XTeUZ/RRWpVANWf3Req5FT9sQuNyxHIVWPjbadQ2M8SJvHqQjq/JzEZhWxEjIQIXdFh3PV4iZsoSQz2EFsxUZMDVVG3TxFALSJQO6Y6IqRTRKYn9WgLnPUAJh6IpJYOE16l2Zr/G0Sk9RpalCUkX7c5OpXv3txe4F5x0V/syyQZaacuBUrU9fFbJSwgOjm+OjY4O4RaqPfqjlb2F1d5vSTU/DLZJGNHSKOF3c6ru7lBg4mozANBDnsk4TkXQHZyPsCgIgLsJ5HTgrsFxXRPDvofKo3iuZJnBOnZlXR+5vZn1kJXDUut8c0eFptJLP93i6q/OXhvlERRSYj7AdxuOOylS3x3WnmObsVjw/gt7P3ESRYp72uEoJUMVMJeg7fsgtqGqjERRWovhLSP/3tBIW8XMlO6sEKGWl/9ru4ZmGFHfhw77Rd5mdMLWF6dTcNhV2LS1qg+HT0wF2FT4T7Jm4IHcsQjnSe8z56SMkI8w++uHcbeSJp2WeJ63h00zaCG/Hdg==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(70586007)(70206006)(8676002)(356005)(6666004)(921005)(7696005)(6636002)(110136005)(508600001)(316002)(36860700001)(47076005)(426003)(336012)(186003)(40460700003)(83380400001)(26005)(2616005)(7636003)(1076003)(5660300002)(82310400005)(9786002)(8936002)(7416002)(2906002)(36756003)(102446001)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2022 13:45:56.3924
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5547734-ee85-4cec-0f5e-08da3cc29011
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0026.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7750
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Add support to handle FPGA/PL power domain. With this patch,
the PL power domain will be turned on before loading the bitstream
into the targeted region and turned off while removing/unloading the
bitstream from the targeted region using overlays. This can be achieved
by adding the runtime PM support to the fpga regions.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
Changes for v2:
              - Updated commit message.
              - Updated runtime PM handling logic to fix the PM ref count
                imbalance issues.

 drivers/fpga/of-fpga-region.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/fpga/of-fpga-region.c b/drivers/fpga/of-fpga-region.c
index ae82532fc127..f14bb5916d97 100644
--- a/drivers/fpga/of-fpga-region.c
+++ b/drivers/fpga/of-fpga-region.c
@@ -15,6 +15,7 @@
 #include <linux/of_platform.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/pm_runtime.h>
 
 static const struct of_device_id fpga_region_of_match[] = {
 	{ .compatible = "fpga-region", },
@@ -301,10 +302,17 @@ static int of_fpga_region_notify_pre_apply(struct fpga_region *region,
 		return -EINVAL;
 	}
 
+	ret = pm_runtime_resume_and_get(dev->parent);
+	if (ret < 0) {
+		fpga_image_info_free(info);
+		return ret;
+	}
+
 	region->info = info;
 	ret = fpga_region_program_fpga(region);
 	if (ret) {
 		/* error; reject overlay */
+		pm_runtime_put_sync(dev->parent);
 		fpga_image_info_free(info);
 		region->info = NULL;
 	}
@@ -324,10 +332,13 @@ static int of_fpga_region_notify_pre_apply(struct fpga_region *region,
 static void of_fpga_region_notify_post_remove(struct fpga_region *region,
 					      struct of_overlay_notify_data *nd)
 {
+	struct device *dev = &region->dev;
+
 	fpga_bridges_disable(&region->bridge_list);
 	fpga_bridges_put(&region->bridge_list);
 	fpga_image_info_free(region->info);
 	region->info = NULL;
+	pm_runtime_put_sync(dev->parent);
 }
 
 /**
@@ -411,6 +422,8 @@ static int of_fpga_region_probe(struct platform_device *pdev)
 		goto eprobe_mgr_put;
 	}
 
+	pm_runtime_enable(&pdev->dev);
+
 	of_platform_populate(np, fpga_region_of_match, NULL, &region->dev);
 	platform_set_drvdata(pdev, region);
 
@@ -430,6 +443,7 @@ static int of_fpga_region_remove(struct platform_device *pdev)
 
 	fpga_region_unregister(region);
 	fpga_mgr_put(mgr);
+	pm_runtime_disable(region->dev.parent);
 
 	return 0;
 }
-- 
2.25.1


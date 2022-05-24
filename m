Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4E65326E4
	for <lists+linux-fpga@lfdr.de>; Tue, 24 May 2022 11:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235896AbiEXJvO (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 24 May 2022 05:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235903AbiEXJvN (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 24 May 2022 05:51:13 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD72511A2C;
        Tue, 24 May 2022 02:51:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fVsYoF7FPkcdvMqWbK4heghUaAayZYchMG15CnANB/xIYbAaxza0NMOC89YlmtfNUGwb3iWFcfXwRTL1KfYRjit3X1cPVyfeiHrVuhKxgTRFv85MUueChkbUTDoDSjHyMhtTb/gVJagOnNjrv67QV2pvzo//dXsGtIbHVZpI43Wf66K3XE/Jl1C9W4j1CDOD138RlW8DCvXzs+GYN6Mbi8AYrsPLpQdPWXw3ExM0hqfB/YTFWscJJxHEcL9/VmuCSPBVWqNuHX1VkNk82F4fyo016cxRb0JMimhcG2+Gq1r392rjXvBjLuBpGKET7bm7TDuy+08byF9JmcUWtvDUDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wc7Y9/yiSzssN7JXlWuSDw7Q3syTxyIFW+BWek2LhN8=;
 b=aqKDz5lGJZUmFZCELOFNJoLT5ToaeTLWuiDqWJ+VvheuNt6PeIXl6LoYkdHRh8ok9uyUbqGZxdr5kRPAbXiYJE7bTXgUzhiwo9+R0QR3w0pl8VGlDRcdsfxASwosPiiGwC9b762XpIuJtB+MJ9sjPCjLRwUeVEi6vcwxYMbkokWS0Anhh+m4rq+b5QAweBFB/rxp30gjO/VSHa0DzrpIpEHolEjn1c2TBSys4yLZaOPAoDrdb1q9lXtxi1uy7XWPWp2P9050Nk1gQfe55lMt2JBM8ZxkRUVbsISs9tke7vdusizqZQRjyszrKw2DO0H2cZhiXYaeaihD1D9QEEMC0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wc7Y9/yiSzssN7JXlWuSDw7Q3syTxyIFW+BWek2LhN8=;
 b=erwcY1S7CFCzWW5m5xUJbuQ7tgVWceSWthzpY2Y3L2JBYmhpwykDuxvIjo+iczsrEdzCYMPzwqatVzDXFbXXDZqNgfF+Odq550nBH5/WxpisoslyZOYoU0PH6q3Vj/D4pKp6qHA4/BHTJUs2MGlGN+oDJzCFR/ICzcD/WoeEUMs=
Received: from SN4PR0401CA0012.namprd04.prod.outlook.com
 (2603:10b6:803:21::22) by MN2PR02MB6304.namprd02.prod.outlook.com
 (2603:10b6:208:183::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Tue, 24 May
 2022 09:51:08 +0000
Received: from SN1NAM02FT0035.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:21:cafe::70) by SN4PR0401CA0012.outlook.office365.com
 (2603:10b6:803:21::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Tue, 24 May 2022 09:51:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0035.mail.protection.outlook.com (10.97.4.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Tue, 24 May 2022 09:51:08 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 24 May 2022 02:51:03 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 24 May 2022 02:51:03 -0700
Envelope-to: git@xilinx.com,
 mdf@kernel.org,
 hao.wu@intel.com,
 yilun.xu@intel.com,
 trix@redhat.com,
 gregkh@linuxfoundation.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 linux-fpga@vger.kernel.org
Received: from [10.140.6.60] (port=58200 helo=xhdnavam40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <nava.manne@xilinx.com>)
        id 1ntR9E-0005Sf-5p; Tue, 24 May 2022 02:48:16 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <michal.simek@xilinx.com>, <mdf@kernel.org>, <hao.wu@intel.com>,
        <yilun.xu@intel.com>, <trix@redhat.com>,
        <gregkh@linuxfoundation.org>, <ronak.jain@xilinx.com>,
        <abhyuday.godhasara@xilinx.com>, <rajan.vaja@xilinx.com>,
        <nava.manne@xilinx.com>, <lakshmi.sai.krishna.potthuri@xilinx.com>,
        <piyush.mehta@xilinx.com>, <harsha.harsha@xilinx.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-fpga@vger.kernel.org>,
        <git@xilinx.com>
Subject: [PATCH 3/3] fpga: zynqmp-fpga: Adds status interface
Date:   Tue, 24 May 2022 15:17:45 +0530
Message-ID: <20220524094745.287002-4-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220524094745.287002-1-nava.manne@xilinx.com>
References: <20220524094745.287002-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 23a2f9bf-d073-428d-21bf-08da3d6aed84
X-MS-TrafficTypeDiagnostic: MN2PR02MB6304:EE_
X-Microsoft-Antispam-PRVS: <MN2PR02MB6304785EE4A698EAFBCFCBFDC2D79@MN2PR02MB6304.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4qH87UU8CpUgcsdf7F+F6If61ADfja5/WAtiSnKjTeFqDruX8FDcagBoBBnKMsliselyAz5D8Mg9vBQpS+emhClXXhlKRvpBDIxzO5HpRTGpAVvUhGRIPNONx1o5H8OElqdl3FR9rjUZYB7SBRx4/E9oKNOmclKNmBeAlQiz4wHVtsui6BSKQbyFnq04I/dH5lXezQOsnp+9sy9bGD7lVGwLW9tnfdKh5NBNl2b3CHQIwC+HwBro4AQughAAKmFe5SqkVEXKnGzLntLxTZy/hjhISMocKl3Z1czaenri+sEf2t/mXC0CxXA1/0f2zFvpXWaHqxf1mVpJJxWu7Hjor0XejLF0/L/mBgnHxEelbihGc56F1ImIaL5DJ82/LadDBckXLddtWTdgrLetbC3/XcOs540ae6pVdeImNcrb3xjPQ5YuAOszXnhIdGBjJ8FA9QHuCsCGZIvixVRl7kqrCbnFrFqMVH8YtzLXd/3Zvu7x5rzFJAyJjlqP5If2M5MG2yHPaeC7bs9cdNQASHOFRfiDaI7WZeiMYSGgOYC8PFWdiuAQW1IzBWcaRUSukIgdL1X4ejZEHDYw7GNP5D6EvtW9EX5/swlZNw2p1icgZNF9bZ+VKpTr7UuzRPcPGSvZwxRnpy3LKIMDuwW9otL+T0yuVJTXzVCnOM99WKpzeuaD3ca0ofAc87ppcESZdVrZinBLthPXKXw2xBOn0ZEVQO9jhxuvJ+qZVdlCkd5tWcKZ+ipvF7gZj/8lIFxa2UOz2jmfn9SnWJZrdjs4T6v+Zg==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(5660300002)(7636003)(2616005)(8676002)(7696005)(6666004)(26005)(508600001)(40460700003)(8936002)(9786002)(2906002)(83380400001)(6636002)(316002)(921005)(356005)(110136005)(1076003)(186003)(36756003)(36860700001)(70586007)(70206006)(47076005)(82310400005)(426003)(336012)(102446001)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 09:51:08.6096
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23a2f9bf-d073-428d-21bf-08da3d6aed84
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0035.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6304
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Adds status interface for zynqmp-fpga, It's a read only
interface which allows the user to get the PL status.

Usage:
To read the PL configuration status
        cat /sys/class/fpga_manager/<fpga>/status

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
 drivers/fpga/zynqmp-fpga.c | 52 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/drivers/fpga/zynqmp-fpga.c b/drivers/fpga/zynqmp-fpga.c
index c60f20949c47..07c7b7326726 100644
--- a/drivers/fpga/zynqmp-fpga.c
+++ b/drivers/fpga/zynqmp-fpga.c
@@ -14,6 +14,19 @@
 
 /* Constant Definitions */
 #define IXR_FPGA_DONE_MASK	BIT(3)
+#define READ_DMA_SIZE		256U
+
+/* Error Register */
+#define IXR_FPGA_ERR_CRC_ERR		BIT(0)
+#define IXR_FPGA_ERR_SECURITY_ERR	BIT(16)
+
+/* Signal Status Register. For details refer ug570 */
+#define IXR_FPGA_END_OF_STARTUP		BIT(4)
+#define IXR_FPGA_GST_CFG_B		BIT(5)
+#define IXR_FPGA_INIT_B_INTERNAL	BIT(11)
+#define IXR_FPGA_DONE_INTERNAL_SIGNAL	BIT(13)
+
+#define IXR_FPGA_CONFIG_STAT_OFFSET	7U
 
 /**
  * struct zynqmp_fpga_priv - Private data structure
@@ -77,8 +90,47 @@ static enum fpga_mgr_states zynqmp_fpga_ops_state(struct fpga_manager *mgr)
 	return FPGA_MGR_STATE_UNKNOWN;
 }
 
+static u64 zynqmp_fpga_ops_status(struct fpga_manager *mgr)
+{
+	unsigned int *buf, reg_val;
+	dma_addr_t dma_addr;
+	u64 status = 0;
+	int ret;
+
+	buf = dma_alloc_coherent(mgr->dev.parent, READ_DMA_SIZE,
+				 &dma_addr, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	ret = zynqmp_pm_fpga_read(IXR_FPGA_CONFIG_STAT_OFFSET, dma_addr,
+				  PM_FPGA_READ_CONFIG_REG, &reg_val);
+	if (ret) {
+		status = FPGA_MGR_STATUS_FIRMWARE_REQ_ERR;
+		goto free_dmabuf;
+	}
+
+	if (reg_val & IXR_FPGA_ERR_CRC_ERR)
+		status |= FPGA_MGR_STATUS_CRC_ERR;
+	if (reg_val & IXR_FPGA_ERR_SECURITY_ERR)
+		status |= FPGA_MGR_STATUS_SECURITY_ERR;
+	if (!(reg_val & IXR_FPGA_INIT_B_INTERNAL))
+		status |= FPGA_MGR_STATUS_DEVICE_INIT_ERR;
+	if (!(reg_val & IXR_FPGA_DONE_INTERNAL_SIGNAL))
+		status |= FPGA_MGR_STATUS_SIGNAL_ERR;
+	if (!(reg_val & IXR_FPGA_GST_CFG_B))
+		status |= FPGA_MGR_STATUS_HIGH_Z_STATE_ERR;
+	if (!(reg_val & IXR_FPGA_END_OF_STARTUP))
+		status |= FPGA_MGR_STATUS_EOS_ERR;
+
+free_dmabuf:
+	dma_free_coherent(mgr->dev.parent, READ_DMA_SIZE, buf, dma_addr);
+
+	return status;
+}
+
 static const struct fpga_manager_ops zynqmp_fpga_ops = {
 	.state = zynqmp_fpga_ops_state,
+	.status = zynqmp_fpga_ops_status,
 	.write_init = zynqmp_fpga_ops_write_init,
 	.write = zynqmp_fpga_ops_write,
 };
-- 
2.25.1


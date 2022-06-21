Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 866B9552E5A
	for <lists+linux-fpga@lfdr.de>; Tue, 21 Jun 2022 11:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348870AbiFUJ3V (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 21 Jun 2022 05:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348928AbiFUJ3L (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 21 Jun 2022 05:29:11 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BEB8271C;
        Tue, 21 Jun 2022 02:29:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=innWu0GTv6FJJNhyXG3LiNZIA5x1zSTT+CeYjkvNLkG9h3SZOFmsVF/9wQlseBWjIJCv6tZXRmro+749sPu33eIUrVSUPU6LzBok+bakP5PrpG7izlek0eHgUYYDaGnVh7IXPOSPCh11sX1G6rV6/s0NkF/p+rQtdSnNxs+aW/PUuMQgaraZoxE82Dm6JksLcOXjFjNJXfOzYIomxleVQapTEi/2R2ue9S2wg6D4WnnwK/mRK7SqyP4fL8nIoTSD1wQ0oZTCc13Tn8LU3ZWZRarC8iKAPl1Cb8JT+Z77q8oA6AU9ODyiryEShosC9sc7P2rB7KrdVfN6LBbsqRWkoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V5y0Pm1kQkbMHm0i2knoXvV31XRIf2UoMMdM07UuU5k=;
 b=edNGDdPrzPOHJLwQo6WDoAR5XBaEAGfSE/koDDd9s5duK1Qt6Ea4MaBhGxyYWD0qKhAbNI76N+u3F0xlqvRHRAPJlwaOzQyS1bFM2LOv9x9cfOPRYc0YcORD9f8zwqZgcKHMj1A7NdZ9TJTdlEIg/mROVvJnZJB7RI3zqhcDqCifngSiQ3vbdtCBwkPO2xCeY/hM6e+Mb5gm9VSlh8tWJLqGPVFRM+kL38Os/Gea+vHfj9eZh8ucVAFnILokgquYE9kSu/m77UUxOe0Wjj4GC9Ougnh45J/PrKBf0dZPjW+J4gj63V9Vx1rQhwIOHRF4U4HL1fgiuUzfln1cHutxUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=intel.com smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V5y0Pm1kQkbMHm0i2knoXvV31XRIf2UoMMdM07UuU5k=;
 b=FNl2M6cP5cj0k+2Y4kh1pWjXIK5psKwHi2mcGtAxdePS21yX3cDtKXB4eBs4tHXlMWGB3AD2h/LKA0hnuuFAzjmuOYB3GOp3qj+LD/Kdi0dZb+YdVPxHdtuoWvilEJiyoGDGkHFLBkSUQehHfAtAM/OgVIR9MYt/ekHhOo9c4eY=
Received: from SA1PR05CA0011.namprd05.prod.outlook.com (2603:10b6:806:2d2::13)
 by SA2PR02MB7772.namprd02.prod.outlook.com (2603:10b6:806:149::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.18; Tue, 21 Jun
 2022 09:29:08 +0000
Received: from SN1NAM02FT0010.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:2d2:cafe::8a) by SA1PR05CA0011.outlook.office365.com
 (2603:10b6:806:2d2::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.9 via Frontend
 Transport; Tue, 21 Jun 2022 09:29:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0010.mail.protection.outlook.com (10.97.4.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5353.14 via Frontend Transport; Tue, 21 Jun 2022 09:29:08 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 21 Jun 2022 02:29:01 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 21 Jun 2022 02:29:01 -0700
Envelope-to: git@xilinx.com,
 hao.wu@intel.com,
 trix@redhat.com,
 mdf@kernel.org,
 yilun.xu@intel.com,
 gregkh@linuxfoundation.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 linux-fpga@vger.kernel.org
Received: from [10.140.6.60] (port=45120 helo=xhdnavam40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <nava.manne@xilinx.com>)
        id 1o3aBx-000DOt-70; Tue, 21 Jun 2022 02:29:01 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <michal.simek@xilinx.com>, <hao.wu@intel.com>, <trix@redhat.com>,
        <mdf@kernel.org>, <yilun.xu@intel.com>,
        <gregkh@linuxfoundation.org>, <ronak.jain@xilinx.com>,
        <rajan.vaja@xilinx.com>, <abhyuday.godhasara@xilinx.com>,
        <nava.manne@xilinx.com>, <piyush.mehta@xilinx.com>,
        <harsha.harsha@xilinx.com>,
        <lakshmi.sai.krishna.potthuri@xilinx.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-fpga@vger.kernel.org>,
        <git@xilinx.com>
Subject: [PATCH v2 3/3] fpga: zynqmp-fpga: Adds status interface
Date:   Tue, 21 Jun 2022 14:58:33 +0530
Message-ID: <20220621092833.1057408-4-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220621092833.1057408-1-nava.manne@xilinx.com>
References: <20220621092833.1057408-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd557fa9-1cb0-4d2b-a730-08da53687df4
X-MS-TrafficTypeDiagnostic: SA2PR02MB7772:EE_
X-Microsoft-Antispam-PRVS: <SA2PR02MB7772F3B3E3E0005B0F7AF41DC2B39@SA2PR02MB7772.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GL56llDNxqOQOaq70Zq0tMb0C9DvSC9y2s+t2zwpsq5RZERqle3nEyEmFkqvnqU4nga9oiEmY3s8IRttBAWOHhxwfb/9E3xMur6BrOnSVFk4L0beLWw3TWkcOGu57zovir5lJuA39hAM/fN1NtIWlJVYEw8ask+yCXPhLabenm9J1hu17t2BPWwKTb7Zk3w2cjnrCj2DFN0MMp17J2VFmZ6PeL5U3zADrgOmWMBPgR1qo20VdRclaGBICnHvG7Psi1ZYv21fqEkEQDId1TzW/ehbNsYMSK28hddgY/vfHAq52fo/ENN6hC+BmR6fa4QKxDYj+jcYphFF/CsgjQl2M8zbTWv8RW5ySD9Uce4C3nKGTZzY93/RK1DJYoD+WehYhfTaceQwqJFewYw0ONO4422azJRXD3WsciBf+KuQOGvU6cpPewAt7TVkP2Mg5Cdc67Vd4wE3ppkk9Y5G2NrM2WxuYX9hK/AcZZbJxOJ5r1i1jBLKxms2ipwcYLDPBimr5d3T8pKw/I3czJOzdhoQ4j4q8BwCVw6naftmwp9u/+uvl2sIlBvUcUEgaBC/4PYmucrOq4Jbm5DQsGbH4g1bkVgvlpph1NSnwf4Tze29kGWZZkgbQHYkuSoEFt7+Z8BDYzTdtzerp632Q0Q6amtrkfMUiFTZfmiq/pWB9K3uBNkl6gj9tRXMudOMURNcWQuc5B5nQiaDsVSR5O0Ots6SwPANwVedJ4a/iILnQr6V0ooxTZPeaJ0ypR0a57dCjGlDcb0myagR6+vouquAJi6uhUoeRDWVuWCgFIt6PcKvwHBoOD9RSfyRaqn8gf/8b8nW
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(396003)(39860400002)(346002)(46966006)(40470700004)(36840700001)(83380400001)(7636003)(47076005)(426003)(1076003)(336012)(921005)(82740400003)(356005)(6666004)(40480700001)(40460700003)(186003)(36860700001)(82310400005)(7696005)(70206006)(9786002)(26005)(110136005)(316002)(6636002)(478600001)(2906002)(2616005)(41300700001)(70586007)(8676002)(5660300002)(8936002)(36756003)(102446001)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2022 09:29:08.0455
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd557fa9-1cb0-4d2b-a730-08da53687df4
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0010.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR02MB7772
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
Changes for v2:
              - Updated status messages handling logic as suggested by Xu Yilun.

 drivers/fpga/zynqmp-fpga.c | 53 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/fpga/zynqmp-fpga.c b/drivers/fpga/zynqmp-fpga.c
index c60f20949c47..e194bba91d3f 100644
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
@@ -77,8 +90,48 @@ static enum fpga_mgr_states zynqmp_fpga_ops_state(struct fpga_manager *mgr)
 	return FPGA_MGR_STATE_UNKNOWN;
 }
 
+static ssize_t zynqmp_fpga_ops_status(struct fpga_manager *mgr, char *buf)
+{
+	unsigned int *kbuf, reg_val;
+	dma_addr_t dma_addr;
+	ssize_t len = 0;
+	int ret;
+
+	kbuf = dma_alloc_coherent(mgr->dev.parent, READ_DMA_SIZE,
+				  &dma_addr, GFP_KERNEL);
+	if (!kbuf)
+		return -ENOMEM;
+
+	ret = zynqmp_pm_fpga_read(IXR_FPGA_CONFIG_STAT_OFFSET, dma_addr,
+				  PM_FPGA_READ_CONFIG_REG, &reg_val);
+	if (ret) {
+		len += sprintf(buf + len, "firmware error\n");
+		goto free_dmabuf;
+	}
+
+	if (reg_val & IXR_FPGA_ERR_CRC_ERR)
+		len += sprintf(buf + len, "reconfig CRC error\n");
+	if (reg_val & IXR_FPGA_ERR_SECURITY_ERR)
+		len += sprintf(buf + len, "reconfig security error\n");
+	if (!(reg_val & IXR_FPGA_INIT_B_INTERNAL))
+		len += sprintf(buf + len, "Device Initialization error\n");
+	if (!(reg_val & IXR_FPGA_DONE_INTERNAL_SIGNAL))
+		len += sprintf(buf + len, "Device internal signal error\n");
+	if (!(reg_val & IXR_FPGA_GST_CFG_B))
+		len += sprintf(buf + len,
+			       "All I/Os are placed in High-Z state\n");
+	if (!(reg_val & IXR_FPGA_END_OF_STARTUP))
+		len += sprintf(buf + len, "Device sequence error\n");
+
+free_dmabuf:
+	dma_free_coherent(mgr->dev.parent, READ_DMA_SIZE, buf, dma_addr);
+
+	return len;
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


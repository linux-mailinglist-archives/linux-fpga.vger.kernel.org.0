Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E36BC4D13B6
	for <lists+linux-fpga@lfdr.de>; Tue,  8 Mar 2022 10:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345439AbiCHJqv (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 8 Mar 2022 04:46:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345431AbiCHJqu (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 8 Mar 2022 04:46:50 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CBAE41980;
        Tue,  8 Mar 2022 01:45:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j5PDzKH/TEDH+QAasunYi36FcGBQkXmA/oQYng/qeyNyWH9BO167WHnaJF9Dqacp7LjxkZAkGNj1U+TMbNbPV71Z/Cd8pN7VSCLaSovKPCTA7ApGXSgbSnpsyK1ecAHMK7ZCBBumcvRm47WTOx7aLafODSPDrlTVBT0YvT+6Ix3E0o8cN8I4eJt5W/2gNeAfNw+I/S2FVFgdVry3rh6Ao8jOvcLwGCM7E6d4rlEOyIYA8UDroaCSQbnPQunQCCZk7H8Yg92oyLaapOw7+AydEQUAAkHQetUySSFhqyYgUuAdxe0VNPc4MZyDf2seuHrLfkwyOMAjhYvoqH+0xQ1GBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HITE67sErS9XCJWfCQhFbawSlAcJif7BLpS4x25z2ko=;
 b=c8TJpQsFKsb8sALJJAd45KmXMzOLfol/DVTRNto8zrp5mPuj73QgPkcPT+d500ALFj+JLOEGvLHZtS7wu67rmUy59wUnv5o9tnn1nZxyAHPLsSyD3Un/Qm1bU36yvkIi2ZRU7AUfbr3Bj6pQegfrlGdSShp88yva1Jxzldmi9bEE2SaIHvoZ/3rwyGhKQJ7S7IILLj/LtWYCEFHUAPauYvzvLZDMxcalrkcb7slheHsMHF6h3K5KxvEVVDJaVCM3Jqi6wIxfM8uzXC+6ectBAAOttUIW0YA3c5ihMeDw1ktaBtK+aHvAecSZMCKZCNIZDwwH+nhmC1j+LrYBE4uYyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HITE67sErS9XCJWfCQhFbawSlAcJif7BLpS4x25z2ko=;
 b=pVoRpvprq/B3SbiRc+64hxmEBdGgTa4KRdziB1BOUw7Q+r0KQTrkr+l9H9sve4Y8EY++Y3T+K1nx0kzSaT7gYw+G5dutBXB2ZFFLhd19m+nFvGVmX+8ITymiIWnM5whHlxHLyepBQvCpLrmOc4bQFPQnNGu2c5alB6Vr+GT0A+M=
Received: from DM6PR12CA0022.namprd12.prod.outlook.com (2603:10b6:5:1c0::35)
 by DM5PR0201MB3573.namprd02.prod.outlook.com (2603:10b6:4:81::38) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.16; Tue, 8 Mar
 2022 09:45:50 +0000
Received: from DM3NAM02FT024.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:1c0:cafe::5f) by DM6PR12CA0022.outlook.office365.com
 (2603:10b6:5:1c0::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Tue, 8 Mar 2022 09:45:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT024.mail.protection.outlook.com (10.13.5.128) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Tue, 8 Mar 2022 09:45:50 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 8 Mar 2022 01:45:49 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 8 Mar 2022 01:45:49 -0800
Envelope-to: mdf@kernel.org,
 hao.wu@intel.com,
 yilun.xu@intel.com,
 trix@redhat.com,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Received: from [10.140.6.60] (port=33304 helo=xhdnavam40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <nava.manne@xilinx.com>)
        id 1nRWPc-000G0A-Gv; Tue, 08 Mar 2022 01:45:48 -0800
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>,
        <trix@redhat.com>, <michal.simek@xilinx.com>,
        <linux-fpga@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Nava kishore Manne <nava.manne@xilinx.com>
Subject: [PATCH 2/6] fpga: zynqmp: Initialized variables before using it
Date:   Tue, 8 Mar 2022 15:15:15 +0530
Message-ID: <20220308094519.1816649-3-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220308094519.1816649-1-nava.manne@xilinx.com>
References: <20220308094519.1816649-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a770e710-9032-4fc3-2394-08da00e86deb
X-MS-TrafficTypeDiagnostic: DM5PR0201MB3573:EE_
X-Microsoft-Antispam-PRVS: <DM5PR0201MB3573902E52DEEF25DB4E11DAC2099@DM5PR0201MB3573.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qm5GJsRFcYhC76add455AF5sdbeW0McKNBaMi4uhAtYq5b9bfad29/5TwuJA29E1NUvHwFgCqa8LVugRMFSXjyRPY0i9ZK8niAJ+PlicHQcrAVMiq/ojsmGnX+9cawnYnsxIkB4GWRENGMJLvjiIobWCaER3GrTpj/MBN9Utv58cZU+q7EkQMXYWL0DV4cw05UneP34Y6s7qVni8aW4Z8fUcMcwNOKHAXGoorAADtc+yiKLph95Z35apDGHzHb5S+MjwtJYyw1ZkAwdQxkuQmSNmRQ4ym50ZeTj+6+mBmhuedCIN8GgKQEpXMhVbXHcMwvoMTJtl0EsMKywKdZzA1rDeEiuca9oDZWr9EmsNVjI5GDfHlTP1kSAhMMRZp6Yx9pDN6vFW0woBfhzdxfjD3xp1M+1zE4cm5zllZP5X0voKzGeqQwxyVOiE6xSo39qtY+JLFCmZBaIiOIkE1QW4QeoBzoKzK+TjtdqZnaZGcEMTqcOLzJLECSE9KsLYWJukrP7e1mFwD8pyMIQLpV3cLqrvSgM2lYGezaHTK8VnXA7fBM8MukoFdrYklrVYqa09QJyjgoqm+2ciSmIZtmFCLF6J3rs66tSp3wLUvUaVFraneznJ1YvP70h3z+uRRopJ7B3Z0lyBg64i60eAi/Q5pmfE8WQIJW+kiI8coMy2LgxeELUWowGMpyT7xTjZ0vxwzZTAfDEmwDFJcSvrZNqoiLVxB6beuZ+nN4g+oxYGh3U=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(6666004)(70586007)(316002)(70206006)(7636003)(356005)(4326008)(40460700003)(5660300002)(110136005)(83380400001)(8676002)(36860700001)(26005)(186003)(336012)(9786002)(1076003)(2616005)(426003)(8936002)(4744005)(107886003)(36756003)(508600001)(82310400004)(2906002)(47076005)(7696005)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 09:45:50.1948
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a770e710-9032-4fc3-2394-08da00e86deb
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT024.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0201MB3573
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

This patch initialized variables with the proper value.
Addresses-Coverity: "uninit_use: Using uninitialized value"

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
 drivers/fpga/zynqmp-fpga.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/zynqmp-fpga.c b/drivers/fpga/zynqmp-fpga.c
index c60f20949c47..e931d69819a7 100644
--- a/drivers/fpga/zynqmp-fpga.c
+++ b/drivers/fpga/zynqmp-fpga.c
@@ -41,7 +41,7 @@ static int zynqmp_fpga_ops_write(struct fpga_manager *mgr,
 				 const char *buf, size_t size)
 {
 	struct zynqmp_fpga_priv *priv;
-	dma_addr_t dma_addr;
+	dma_addr_t dma_addr = 0;
 	u32 eemi_flags = 0;
 	char *kbuf;
 	int ret;
-- 
2.25.1


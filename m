Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 451914F07C2
	for <lists+linux-fpga@lfdr.de>; Sun,  3 Apr 2022 07:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236531AbiDCFS5 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 3 Apr 2022 01:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiDCFS4 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 3 Apr 2022 01:18:56 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6965E377E4;
        Sat,  2 Apr 2022 22:17:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jU1rkpFkZEtazeHfRQ2a7nWYbL1SVU8zAr0lQKfe2Mlc738yY+jhgQtmshB3LID89aosyyWqO2ReG8XRSGMkm/XMYsnt5OV0xTFG+WxHsARqRMBT2O922TbpCtC+OHLDqw7oUrVDKo2CMwHI54mrD5FhViuC+H1I+HPsfizFxc+Y/naxcCcKcnas33o9Hcp7RE+gWIjpOkhiz/AkDoQeEkMwwFouElxIIwBz33Z7Nim+TBNQk2HPYbtqLbtlW+4spBWHTWlfy7jNHqh9JoJaIeOgQkAmxDFtQdZXfWoziyQoUwXGPJQIO/k8vkhCPmVUUfT2n78IWnzZM392f7WiPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XE7hlEQ2JTlsiNShhYgWYOW7EmndVHyOKu+Vch0iGKE=;
 b=N7HTtakWlIu+IRXJJK1tzu3K1nGxVvkXMywPgeC9bAZbYNa7//OmienEwRC4gDoXtOMV5E8E3sKMw3kasJZRCZHVbaworhgLMhwjcJKpc4f2oFA7QIFi8P2GVCiHPTy5J+UIb6WhutI2uUaS5RjpCnmH7ubEuOHmKPa9oj8rxNY4td/uy6yRh/HjaacflbRtXbUxK4DijUM9S7R1AF6R0R5bpkGjYYkEXE7f7BYS7OWL3p+FKYZuKZusUOo4fFOrajMI9K/yb8oR/evSMWXhsZ5ZHqwZGnfmuQhA4cODAaMnG+N8g9rqQZA5PcCOYY0tPlw4hYwUBsAXKkO/s1BmUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XE7hlEQ2JTlsiNShhYgWYOW7EmndVHyOKu+Vch0iGKE=;
 b=jaUn1kyIwMD0N5zIcRf7IbfJ5WPC5yIcrf56In9Msx3zeG4bDBd842RGsB/VKToUbvsQjoyeLynHDvbawKOZFBgCYFFj1xHdWgQ6QuonZK/lWESepZs8LDxU/TS+DWEaCpE8QuW0Kp+4dPxijEPV/TdvA2laOujq5BbSVQvCPdg=
Received: from DS7PR03CA0097.namprd03.prod.outlook.com (2603:10b6:5:3b7::12)
 by SA1PR02MB8495.namprd02.prod.outlook.com (2603:10b6:806:1fa::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.30; Sun, 3 Apr
 2022 05:17:00 +0000
Received: from DM3NAM02FT007.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:3b7:cafe::90) by DS7PR03CA0097.outlook.office365.com
 (2603:10b6:5:3b7::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.28 via Frontend
 Transport; Sun, 3 Apr 2022 05:17:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT007.mail.protection.outlook.com (10.13.4.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5123.19 via Frontend Transport; Sun, 3 Apr 2022 05:16:59 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Sat, 2 Apr 2022 22:16:56 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Sat, 2 Apr 2022 22:16:56 -0700
Envelope-to: git@xilinx.com,
 mdf@kernel.org,
 hao.wu@intel.com,
 yilun.xu@intel.com,
 trix@redhat.com,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Received: from [10.140.6.60] (port=54274 helo=xhdnavam40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <nava.manne@xilinx.com>)
        id 1nasbg-0007vd-1b; Sat, 02 Apr 2022 22:16:56 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>,
        <trix@redhat.com>, <michal.simek@xilinx.com>,
        <linux-fpga@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <git@xilinx.com>
CC:     Nava kishore Manne <nava.manne@xilinx.com>
Subject: [PATCH v3 2/5] fpga: fix for coding style issues
Date:   Sun, 3 Apr 2022 10:46:38 +0530
Message-ID: <20220403051641.3867610-3-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220403051641.3867610-1-nava.manne@xilinx.com>
References: <20220403051641.3867610-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 557d6abe-cfc1-42f7-fba8-08da15312e46
X-MS-TrafficTypeDiagnostic: SA1PR02MB8495:EE_
X-Microsoft-Antispam-PRVS: <SA1PR02MB8495D0C4023D04D611CA1DECC2E29@SA1PR02MB8495.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tcHkjpehytoovadu9oAAKjsqWK7pZ8JXiRWb163sKbeRifDgt8Qizq2KslcqY6EhlHWY/XzMzHT0Ah13OZ63ro6bkLARCnVmgvmwXqY8AYNLapSH7TMaEMF77f2Gc3XUh2GHJZcZG2T+5FqyCspcPXDRwj72C78/TqPO8uNgPusf76PmU8PGF0sMW1NimLp/V2eSGhPl7euiQ+BIAvQ4hWUsAAkwsVokSpVhZi9zmTlyuzUf+kQTvOXyPDjBvMkNsyUUwVGSgSZ4R+YfEtmDbd0IUnWW0psF+M7Ln+/TfY1Bfb1KrsxfS0qkk+jHZKKzcJqVK3VgkKDuOANg1jDn431X6/iEfAFRKKDQkAFuYjk05SQl2rbbLkyROrJP0Dw+uqRIzDXaZw5WF4pCllVqJugBwcBYNIxcLX5H/SJSCsyHhnvAdsnYHv7CEemqrNCCAdBuGeEEunwPovHGsViPHoddnCcthEc7Duf/GkxzVDRM9cxREkCNxW03H0u0ajRIOC4OM4E0dI7588P5zFCiTl7cm/vFPN53zlJLcCrf6TJmBcpa12MWNfUD8Iv4t+mE4y+SkIDKtFTs/5pCGS1bc/ysQ0D4CQqewdK6CelbPOG4xXm0x6YVmOIYB9sXsS39SnWKEIfX1+XNWikSerLSxub3q0NMojVp0gxyHDMLXzvVR/2jWfee6si9FdKWo38XrP1PFNoqzcyXiJzUXW5CeeZHJ4r9tYn11WtWXyWxLTk=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(8936002)(2906002)(508600001)(47076005)(83380400001)(36756003)(70586007)(70206006)(110136005)(6636002)(316002)(82310400004)(107886003)(9786002)(7636003)(426003)(336012)(186003)(26005)(4326008)(8676002)(1076003)(5660300002)(2616005)(36860700001)(6666004)(7696005)(40460700003)(356005)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2022 05:16:59.9393
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 557d6abe-cfc1-42f7-fba8-08da15312e46
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT007.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8495
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

fixes the below checks reported by checkpatch.pl
Lines should not end with a '('
Alignment should match open parenthesis

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
Changes for v2:
                -None.
Changes for v3:
               -Fixed similar issue exists in "drivers/fpga/*".

 drivers/fpga/fpga-mgr.c    | 4 ++--
 drivers/fpga/fpga-region.c | 7 ++++---
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index d49a9ce34568..a699cc8e2fa6 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -151,8 +151,8 @@ static int fpga_mgr_write_init_buf(struct fpga_manager *mgr,
 	if (!mgr->mops->initial_header_size)
 		ret = fpga_mgr_write_init(mgr, info, NULL, 0);
 	else
-		ret = fpga_mgr_write_init(
-		    mgr, info, buf, min(mgr->mops->initial_header_size, count));
+		ret = fpga_mgr_write_init(mgr, info, buf,
+					  min(mgr->mops->initial_header_size, count));
 
 	if (ret) {
 		dev_err(&mgr->dev, "Error preparing FPGA for writing\n");
diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
index b0ac18de4885..3864bf4f8920 100644
--- a/drivers/fpga/fpga-region.c
+++ b/drivers/fpga/fpga-region.c
@@ -18,9 +18,10 @@
 static DEFINE_IDA(fpga_region_ida);
 static struct class *fpga_region_class;
 
-struct fpga_region *fpga_region_class_find(
-	struct device *start, const void *data,
-	int (*match)(struct device *, const void *))
+struct fpga_region *fpga_region_class_find(struct device *start,
+					   const void *data,
+					   int (*match)(struct device *,
+							const void *))
 {
 	struct device *dev;
 
-- 
2.25.1


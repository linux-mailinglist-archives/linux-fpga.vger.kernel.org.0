Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BEB850961B
	for <lists+linux-fpga@lfdr.de>; Thu, 21 Apr 2022 06:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350564AbiDUEvF (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 21 Apr 2022 00:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384145AbiDUEvD (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 21 Apr 2022 00:51:03 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0076512AA9;
        Wed, 20 Apr 2022 21:48:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FrnlJcv1PLbCMNzqa6vdOxfbxP3KkC7ug39kgZO/eGzaG6XLUk6jCTLVdRttEpeUwbz49haw1Ma8bq0Obhs9CX0OElSM+9lcl4gAJ+X2fdcCgQzvWUYk8AqHqCA42FL+eo1Yqhfz7gzopAQhhEtfLTiybVAJAot59onm5iJbntP0+za4KWHjA9f1LoW3xrHO2r7CpxROhaO6xaF1cGhYsTBYaBNY85y86RJgUyuFjM1JI9n4HAfzTuAH57EposDdKHbTJvEUNCXtCtZX/ROPktKxJaObNMgMFbu2NWZ2fWHlnHfJC0z8td+JNKyEP7XvvSebXB48HvGUp6hidWCSNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C4zM5twy8hBrPLh82bU64FcZmzDh/MNsmzkXbW6S33Q=;
 b=ebUVr6uLJpnZie41RLpJ/2TCDYVnGvTSzY1QhJlx/kO9iKu5DBqc5Ad4ceFkU0mlUtIUunCEXqbk5WPdw/cNfLYAxP6sPybI51aujhhWtgOFhI0mPK93tIEzNl2Fj7ydn1gKk5uKzZu7hF2s4Glre89oow/rIYQQQye6VZUtDIdSKGbQXNLYz6lO0iNwUbjQY1LpH6F+Rvn0si93PmWlULSuu/2c8YowC8A4Et8iym0NVEZJFlA/PZMQ4GLoJpk1jHYmwN5apdFRUJO+H/5DLXLcFj9Llq0Vpz2Rhm/zMoU5jVu0KVhTWE0pRR7TvXodLohCU/OgEc4x8XtdaDm+OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C4zM5twy8hBrPLh82bU64FcZmzDh/MNsmzkXbW6S33Q=;
 b=m9/TfxKhrJpEcg8qrGV29Wlyj81Pc73rTJ9/9gr3+3ncLQtd01godvp5+n8sp0u6h7wJLt+jJWrwFvsRwXP4XZO1AGBV2AOzVfNLRmPyst7Xlw5EhTC0Yv2UUz7VFrYoVudZWfPtJXdR75JjKiDbsQ/pZYN7zTh+rLKZdqxTtV4=
Received: from BN9PR03CA0612.namprd03.prod.outlook.com (2603:10b6:408:106::17)
 by DM6PR02MB7100.namprd02.prod.outlook.com (2603:10b6:5:25a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Thu, 21 Apr
 2022 04:48:06 +0000
Received: from BN1NAM02FT022.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:106:cafe::98) by BN9PR03CA0612.outlook.office365.com
 (2603:10b6:408:106::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13 via Frontend
 Transport; Thu, 21 Apr 2022 04:48:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT022.mail.protection.outlook.com (10.13.2.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Thu, 21 Apr 2022 04:48:06 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 20 Apr 2022 21:48:02 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 20 Apr 2022 21:48:02 -0700
Envelope-to: git@xilinx.com,
 mdf@kernel.org,
 hao.wu@intel.com,
 yilun.xu@intel.com,
 trix@redhat.com,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Received: from [10.140.6.60] (port=35750 helo=xhdnavam40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <nava.manne@xilinx.com>)
        id 1nhOja-0002Sb-0W; Wed, 20 Apr 2022 21:48:02 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>,
        <trix@redhat.com>, <michal.simek@xilinx.com>,
        <linux-fpga@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <git@xilinx.com>
CC:     Nava kishore Manne <nava.manne@xilinx.com>
Subject: [PATCH v5 4/5] fpga: Use tab instead of space indentation
Date:   Thu, 21 Apr 2022 10:17:43 +0530
Message-ID: <20220421044744.3777983-5-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220421044744.3777983-1-nava.manne@xilinx.com>
References: <20220421044744.3777983-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 483fd419-9da1-4ba2-5796-08da23522075
X-MS-TrafficTypeDiagnostic: DM6PR02MB7100:EE_
X-Microsoft-Antispam-PRVS: <DM6PR02MB7100566E871B9275CBC01E61C2F49@DM6PR02MB7100.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b0x8iqgILjvozwOPnOBdRuNmemk11/T2uv0D5NOcJ9iIqQhq+W4qFB2SjIKMT5VJx7N6u/dc/rcGrdmQkiWAew9naXt0fFzlr6kc874pB3f+TaL5SQ5dDLNj0IKw9WlBUTM9oDKNrxXS2xLYbiQJ37wXH4BG/ph+pQ/mtHurHf8WJqrP6jWzXB92J0FnE4mvs8/U7hZp9vP6vdHAiLyeznIeFtrtqwB7Qmby7zQRG2iydKnh7FQICJ/0TvGmwja8Tt2BwrWMEtYi0m0basj8gBvvTsu7ZkvlYKidQ16boVWTBUfTWWFCqMqSuC1m5nFTzWl/lvvTdkk68g55ZKsvbgSHfPHuu4vKCn1VcX0gWHeNl5uXMijYhE0TJ8TXAVhdD848FuNnk1g9o2zKwx2MzUR8mQWQPJPQwyq1DUO5FKjU4J/JpRcxs3FOju+iPySdBOlYriUZUkzoLS6fp9U2+hG3Uyn8EWUNfGHqZBQ5Yq86N+dyETQx5L+igWzPc3hBv+a4AxqIDNDGwM9YLXCltni/2AH1rxoh79xHuq0OC5l/NYPVmNBTdBVSahuLG4kgi+/g6s/0BHaEuxDTC8Zbrcf35m1IUvS3KKTsuj+iIvnDXvi+Tn+XUwfp6UocXJ1EM13gzTUOA+2PmFfMLlTB8wdmg/IxBIXLzbeIK9KLFQAsIGmRjmLAcz5RUbEN22DpI0vu7iX/DqYRCathrkRD6Lb5EjsFtZyO2t3njNo6uvY=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(36860700001)(83380400001)(4326008)(8676002)(36756003)(70586007)(70206006)(9786002)(8936002)(316002)(6636002)(186003)(110136005)(5660300002)(2906002)(82310400005)(26005)(1076003)(2616005)(107886003)(508600001)(426003)(336012)(47076005)(40460700003)(7636003)(356005)(6666004)(7696005)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2022 04:48:06.3791
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 483fd419-9da1-4ba2-5796-08da23522075
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT022.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB7100
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

In FPGA Makefile has both space and tab indentation, to
make them align use tab instead of space indentation.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
Acked-by: Xu Yilun <yilun.xu@intel.com>
---
Changes for v2:
              -None.
Changes for v3:
              -Updated commit description.
Changes for v4:
              -None.
Changes for v5:
              -Updated commit description.

 drivers/fpga/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
index 0bff783d1b61..5935b3d0abd5 100644
--- a/drivers/fpga/Makefile
+++ b/drivers/fpga/Makefile
@@ -18,9 +18,9 @@ obj-$(CONFIG_FPGA_MGR_TS73XX)		+= ts73xx-fpga.o
 obj-$(CONFIG_FPGA_MGR_XILINX_SPI)	+= xilinx-spi.o
 obj-$(CONFIG_FPGA_MGR_ZYNQ_FPGA)	+= zynq-fpga.o
 obj-$(CONFIG_FPGA_MGR_ZYNQMP_FPGA)	+= zynqmp-fpga.o
-obj-$(CONFIG_FPGA_MGR_VERSAL_FPGA)      += versal-fpga.o
-obj-$(CONFIG_ALTERA_PR_IP_CORE)         += altera-pr-ip-core.o
-obj-$(CONFIG_ALTERA_PR_IP_CORE_PLAT)    += altera-pr-ip-core-plat.o
+obj-$(CONFIG_FPGA_MGR_VERSAL_FPGA)	+= versal-fpga.o
+obj-$(CONFIG_ALTERA_PR_IP_CORE)		+= altera-pr-ip-core.o
+obj-$(CONFIG_ALTERA_PR_IP_CORE_PLAT)	+= altera-pr-ip-core-plat.o
 
 # FPGA Bridge Drivers
 obj-$(CONFIG_FPGA_BRIDGE)		+= fpga-bridge.o
-- 
2.25.1


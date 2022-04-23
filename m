Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EAD950CC7D
	for <lists+linux-fpga@lfdr.de>; Sat, 23 Apr 2022 19:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236551AbiDWRGT (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 23 Apr 2022 13:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236552AbiDWRGQ (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 23 Apr 2022 13:06:16 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2086.outbound.protection.outlook.com [40.107.236.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06EEB646A;
        Sat, 23 Apr 2022 10:03:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IrS8Kn8e32TmuygotDpKd5fVunNhB5QfdiUFJit8mqqPsEwph2aJcxQEhnAzDK2NZFNHjkwVDXHHyTETEASfCKBZ7XwqIjuVKMTZZZ29oI0R26RMDfV+rL1xXHeOQJmZ0hTHa6r0uBrZeC0349QO4LLPuUjKrSZjfZjPZg+5HXZ3ExF2W04Z8JhxGV63iDioJ9MEI1YNh6T4mfSEqS5G0xSNQ9hGWuEv9IUr5fQJESJbJ1FjZUENX7JzcnfOHArZJs76Ar1pWxfd6XxyIOkCrH+kgDapVKfvI0kCSzJhFzl7bsyOAbQShK2syyuxWM8BrmnTvHXzFt1YhFMkoTDDjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H2Pj2ZdklKpG2VYb4ZKoOj6v8mi2vKxUS8ZkiD73LjY=;
 b=ZuDZH+IKpt5E9oQjWzXbhtiqMUDWoBeByLFIKcQjHM8+sdltAMzVqyvirheTKtUw/5MAH2rlF+tQhtHmaTDNZcttZZCqiuhvCokuiciq6Z9PyHaOPJKTjiMDUhMC7RRUhsj0vsEsj1n6M7VOAWfwh9ohtS24L8WLpc8khPHeVb99ElYVvqp4P21Auz7gS2UtBvbQXOwKH1aONtZ7QIFOqaR9seYzBw+vr6GT112speON7wEdv77ZyaVA7nr9GXe3ZLDRO6FqR/e6xacEli44FHaOINdH8DzP6TE4kVmT7VUhkBiKZFDJPEqFzjaq4MMBqHFh3J83WytjRKz4wt+L9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H2Pj2ZdklKpG2VYb4ZKoOj6v8mi2vKxUS8ZkiD73LjY=;
 b=MHPYKJmau7JCAHZr8C8EhiTE8DSdxzE47LXY1rUnMttsVQf00WDqvRb76tdkKxZFz6sZWmNjbIjMwznBxsesieQ3YeB1TfLX/DziJUBADyFowQlLWtc2To/FYu//zSjT9YmT4PZDrRUKmTuH9OXzsg9zLSW0GbTojaamMPaLQdA=
Received: from DS7PR05CA0037.namprd05.prod.outlook.com (2603:10b6:8:2f::24) by
 CO6PR02MB7505.namprd02.prod.outlook.com (2603:10b6:303:b1::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.15; Sat, 23 Apr 2022 17:03:11 +0000
Received: from DM3NAM02FT056.eop-nam02.prod.protection.outlook.com
 (2603:10b6:8:2f:cafe::7c) by DS7PR05CA0037.outlook.office365.com
 (2603:10b6:8:2f::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.6 via Frontend
 Transport; Sat, 23 Apr 2022 17:03:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT056.mail.protection.outlook.com (10.13.4.177) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Sat, 23 Apr 2022 17:03:11 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Sat, 23 Apr 2022 10:03:07 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Sat, 23 Apr 2022 10:03:07 -0700
Envelope-to: git@xilinx.com,
 mdf@kernel.org,
 hao.wu@intel.com,
 yilun.xu@intel.com,
 trix@redhat.com,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Received: from [10.140.6.60] (port=37114 helo=xhdnavam40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <nava.manne@xilinx.com>)
        id 1niJA2-000FkB-Tf; Sat, 23 Apr 2022 10:03:07 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>,
        <trix@redhat.com>, <michal.simek@xilinx.com>,
        <linux-fpga@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <git@xilinx.com>
CC:     Nava kishore Manne <nava.manne@xilinx.com>
Subject: [PATCH v6 4/5] fpga: Use tab instead of space indentation
Date:   Sat, 23 Apr 2022 22:32:34 +0530
Message-ID: <20220423170235.2115479-5-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220423170235.2115479-1-nava.manne@xilinx.com>
References: <20220423170235.2115479-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0f392f01-06ba-4c15-f0f5-08da254b260c
X-MS-TrafficTypeDiagnostic: CO6PR02MB7505:EE_
X-Microsoft-Antispam-PRVS: <CO6PR02MB750533C15C6DC6C9E6E2DD0DC2F69@CO6PR02MB7505.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z/0ghV3GWnns4UzOqbWsVefNhWT5c/u8fnoMkRlWG/9Y5Ze3whoxA9oeDIDHt8iO+OuWKm38vKF/1mYWx/R+APibFEAJQe2bgtO9qlHiW0J2mZYXnLuuYttuDt/iYkq5JyWykOP8wVQLWHU7NNd2h6kHCPlT5BguHmzYsVe3rLwN3jJpnOJ96h8lYpKrlLiW54B+x1xXl9qdcbqi2valdpg3pIM1uxikUPlIXDPtSkooP2UEctioi8runFiLhLKLEPyJFSlcRDQIeVVm+8EaoqAqTIhDmPSEXjv3B0ELFrkbBLixo++45exW+dYH731erIMI/iG+V+hm4C+QITesf1t5xBoSQWv77f4l3LS+UXDJELokPoAvgcZEm9+yfZcdt+2muIIaWjNSyPr4rK7WLkLhmsk0u+dt7KfrmBF7+FEsIeuQ+FcqQs/kn5rRcNaElb5++UsCsfSUuyxImP/fFBrjKMTcajW1Cvp4zUIQmoCBVTPZqTykLSuG5CGuqTNEeaur5pdxKGO/F3RwGubnxd/bG6QO6L8/H2Ki2aYoPrb8EXmLqKzwcYFZqOh0O06FWbVfShP40PU0V9f9sd0lz+a7eDOhP57IPug9ZlqqETHumeZccViPlXbzL7LzqZZMtPXJ7XHsIra3mJI86rBqWqL3M719u0xWDRq+15yGa0QsF22AMvDWOE76t5eY86W1ZW24HvJ2SM4nFSuvYYRWZYdk/R/OhssLb60zKJI+nq8=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(8936002)(9786002)(5660300002)(107886003)(7636003)(356005)(1076003)(2616005)(40460700003)(6636002)(426003)(336012)(186003)(110136005)(508600001)(7696005)(6666004)(26005)(47076005)(316002)(36860700001)(8676002)(4326008)(83380400001)(70206006)(70586007)(36756003)(2906002)(82310400005)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2022 17:03:11.6722
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f392f01-06ba-4c15-f0f5-08da254b260c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT056.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7505
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
Changes for v6:
              -None.

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


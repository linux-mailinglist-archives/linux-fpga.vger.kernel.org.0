Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9154D4F07C3
	for <lists+linux-fpga@lfdr.de>; Sun,  3 Apr 2022 07:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237041AbiDCFTN (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 3 Apr 2022 01:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237442AbiDCFTK (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 3 Apr 2022 01:19:10 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937F6377C1;
        Sat,  2 Apr 2022 22:17:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IHdQn0apS6tcTNx44RuUqP/SR07PI3DKtCaf+XqCxtO9a6epI0QP76Qh1TSDVtMp5xLK6LoXMhQxWW+AApoATGuDMLlgnrXz7WAQZOOVHGAdDJ9lwSZ4TZ4R1MlXqRYW5HMhFuN/fezhIed7b4f15MJtuD4vNhHakINNvrWruV+g350pi2BgSRKPZN+uudmNQ+0mP6+DsuxfEE41RmQuh2/199xsEWlfApFPI25lStBhqd9F3Y95UjuK9jwWgCSZCebp8v+djuzV1YW4ixCFa2S9d6jKhatgrHeF5DzEiwVcfOFRDFWjUspRdEJ7rR+gf+OATOiK1pBcsuq+K/N2bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8OZSXHY3nIzm6y3mxAPj0bpzniQWDGT0n6H3Flnv4kY=;
 b=J8CRvp0tTfARKBwYU7UtmRRENjiYr5Tcng73t7tWraqRzp+1Pic8mXVcDBIfTAaP92BHmC7jggOvRVlIOv14YR5EZac0NTnlYip1QDokRTqh9OEMyv79kWdy7hLASnvOguO2+1Rob6GhT9LKlLsEeXc8HzVIUDwIzYoJkER7f623BFvtT+CH35/cg5ElqJBw7DX4NdKDhhBvKTSRU1lCmrrRBVZUCPCwpOYnUQLjbh4skhjRuSG4S5qHxDd7+JI8ICgPX5KosHixZ1HLj0XiPeGk4JNhQRzp1J/fq4aU57mzibGes3Q1OCpjBD/tSr5xDeO0Opk7KCf+GODPquGPJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8OZSXHY3nIzm6y3mxAPj0bpzniQWDGT0n6H3Flnv4kY=;
 b=Ct7zL3JspZo/k1kLkPJGl3/TPf/Ah85nCKmJEKZHlr3fDx9+AkQOQFFAaI6qeYy6HnTIjOY8w+CciC8F1aEHl8iScgz2uEyteXbfUpjGfFQ0ic0CPURd45FfIeL/66yfKdNSZnr2EkMexPgvREKx2p+SEgO903gBzEWa4m2jpGY=
Received: from BN9PR03CA0752.namprd03.prod.outlook.com (2603:10b6:408:13a::7)
 by PH0PR02MB8373.namprd02.prod.outlook.com (2603:10b6:510:100::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.30; Sun, 3 Apr
 2022 05:17:14 +0000
Received: from BN1NAM02FT061.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:13a:cafe::fb) by BN9PR03CA0752.outlook.office365.com
 (2603:10b6:408:13a::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31 via Frontend
 Transport; Sun, 3 Apr 2022 05:17:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT061.mail.protection.outlook.com (10.13.3.184) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5123.19 via Frontend Transport; Sun, 3 Apr 2022 05:17:14 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Sat, 2 Apr 2022 22:17:05 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Sat, 2 Apr 2022 22:17:05 -0700
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
        id 1nasbp-0007vd-9A; Sat, 02 Apr 2022 22:17:05 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>,
        <trix@redhat.com>, <michal.simek@xilinx.com>,
        <linux-fpga@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <git@xilinx.com>
CC:     Nava kishore Manne <nava.manne@xilinx.com>
Subject: [PATCH v3 4/5] fpga: Use tab instead of space indentation
Date:   Sun, 3 Apr 2022 10:46:40 +0530
Message-ID: <20220403051641.3867610-5-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220403051641.3867610-1-nava.manne@xilinx.com>
References: <20220403051641.3867610-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd150066-1f5c-4fba-6aa1-08da15313701
X-MS-TrafficTypeDiagnostic: PH0PR02MB8373:EE_
X-Microsoft-Antispam-PRVS: <PH0PR02MB8373E7CCB91592FBBBB35AE2C2E29@PH0PR02MB8373.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GOTRmhPwaG5FecWR+oUOEZrqzodA9OBDyZ0Ov17wwlRPmuMlWAJON35+2zyGWfbpEB+yiLJGePIAZMLqH9XJsqaVj7itroBbiKhGeSZWCbhLI564XOcxBrh2y/v5LO6n3/O1PI3ztKxsMxosU65wJdwBjFFQcFW0p6YRJ7oEeSoaAnh1YJYF3kSwEz+AFnAzD5XWQl2MZwS9/vHHp98qoSri1wzZYw51fUl6/BaGQ63YmK9gujuip8zI1V+MKTZJ7I2cx9aTnIaZdCVfnR0cHDlVOdw3Zw7VOfJculyEc34GR29iqaAL7lJdBsJLnVwb7ILceEi7TBIdhoryyOXgfaORomEWU+YGIbWONzP6kv1dCkSxf+O1NvKEACcCRU/ovgcyB3wZnWZ6GJaRPx9TU443cM24qyPH978WH4OQDCZzrr9ZWku8ieo1BHKlv18InjlsK/Ew6ybIb0F87AvUYxSigDdEQRCPaXxCWKJ8T8Zf/32rFKSYtDRErjyZ9p9INd/O9SAjIjjtBSIH0Zj1BQVJtoXFRNtaCp6TtJ6XW/QXwqkgkzCO1Ge7Wl+oxg4godeB2ZMLaUBwbk7dZLqJY4PSCHjPsGjJU1UuANtKYdIduBs2tSKaveqEwKwS9q0cznhaG0BeJAO3xEowFoirsRUW2lr9r3BWc4rBYQqn1FUzlguv/Q9IMBOxztoGoVY9E4VYLsftlLqBUpQPlGD1lxd3DvzIo7Vs7haOztzAPXM=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(186003)(82310400004)(7696005)(356005)(508600001)(426003)(2906002)(36860700001)(336012)(6666004)(70586007)(70206006)(26005)(316002)(47076005)(7636003)(9786002)(1076003)(83380400001)(107886003)(2616005)(8936002)(5660300002)(40460700003)(8676002)(6636002)(110136005)(36756003)(4326008)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2022 05:17:14.5517
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd150066-1f5c-4fba-6aa1-08da15313701
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT061.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8373
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

In FPGA Make file has both space and tab indentation to
make them align use tab instead of space indentation.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
Changes for v2:
                -None.
Changes for v3:
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


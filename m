Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FEF44D13CB
	for <lists+linux-fpga@lfdr.de>; Tue,  8 Mar 2022 10:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236073AbiCHJsq (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 8 Mar 2022 04:48:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345478AbiCHJrM (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 8 Mar 2022 04:47:12 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081A94163D;
        Tue,  8 Mar 2022 01:46:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QyYbYgzCM5Vr5y3VTnEtkLkvSFa+37RbgoUPrpfz2OB8QTNt2he2/It9/pzeGrABX3cWn4z339wBdIDSxh6C1DzhEpxw/mpkRHXicNZnYgCt3eY08WQFqEUawnM4/FHnCCDc1WsjEFQvTNF4YRCS043P/18JVwCZm1ZZ71K1gQ4+FY8eL2Zb8oxOsPUwdPUMnyYs0DhIi8ysPotbe9m+3YRnPV6jEtE9VOBkGvlqzA7wca6AyaSDLR6ta9IifrJsBWndE4AfcE6iU2ASekqp97UkSexca2oHkvPyHcQOqgwyUyRiymjO6p6/C0t8HLJKzvMb6X8qftLCZ8cwZ8oMjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jt8cKOgxVPstoWwfZUTB1O7ys+RUUeieCm5OMjh8Z5Q=;
 b=oZWAvTpqeIFsexUyqHbvEKS6o2XNQ6wdy1q1HY7N82gBclpraSn6AfYx8Y0mKy0MqF9ap+l7bPCYzMUYqehonlJQh3+/WE0dUzC2y7yeEXoVvQvncKzX9OiVBysMaPdvN4V1lr6u9hTcYz3bmqSpYLmihSPi8UiVywjFNmg/bCheQA/nN9/Hyw8ZRtS66CuuKMrMVKoVVhncD1474jaMhWXYdob995RwlOlyFq0xHFHpPUmuy6qu+qBng+P+3ajcSSZp/FzI52qhlIPSxhouCiOOBxnmLzHK8c2CU9IrKpqD88k6LLShOKdX5yebVariJqaLTxkzPCh6FayM3T1K1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jt8cKOgxVPstoWwfZUTB1O7ys+RUUeieCm5OMjh8Z5Q=;
 b=r/Mw00yEFFgjPiCmSi3Dy9LPe5OTawT/zSxJ7/kNFRdkue4wHRm2CnSQUiHGLaxJCaCrF2unciNXtouxNqC91r1AQ1gq/w798xSeSj5KuXW/pBYcv1NvNjrqLfFxRgqo1V0TXiQomGkSSQcmpPePH1CIpdPqJVVhTs2W6GI8fiU=
Received: from DS7PR05CA0054.namprd05.prod.outlook.com (2603:10b6:8:2f::28) by
 MWHPR0201MB3466.namprd02.prod.outlook.com (2603:10b6:301:7b::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.20; Tue, 8 Mar
 2022 09:46:08 +0000
Received: from DM3NAM02FT021.eop-nam02.prod.protection.outlook.com
 (2603:10b6:8:2f:cafe::1f) by DS7PR05CA0054.outlook.office365.com
 (2603:10b6:8:2f::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.17 via Frontend
 Transport; Tue, 8 Mar 2022 09:46:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT021.mail.protection.outlook.com (10.13.4.249) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Tue, 8 Mar 2022 09:46:08 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 8 Mar 2022 01:46:05 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 8 Mar 2022 01:46:05 -0800
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
        id 1nRWPt-000G0A-4J; Tue, 08 Mar 2022 01:46:05 -0800
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>,
        <trix@redhat.com>, <michal.simek@xilinx.com>,
        <linux-fpga@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Nava kishore Manne <nava.manne@xilinx.com>
Subject: [PATCH 5/6] fpga: Use tab instead of spaces for indentation
Date:   Tue, 8 Mar 2022 15:15:18 +0530
Message-ID: <20220308094519.1816649-6-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220308094519.1816649-1-nava.manne@xilinx.com>
References: <20220308094519.1816649-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 749dab40-c51a-47a5-cded-08da00e878a0
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3466:EE_
X-Microsoft-Antispam-PRVS: <MWHPR0201MB34667A44E2FDEAC58489E464C2099@MWHPR0201MB3466.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fNKNa9z8HV6YBUWkpop6tOK+6xLcbKSBcZrvXrFzpulb4/YDlRUo/yOe5B2HzH+qN6Tg1llhwZjhGMs+uwUMEg+sZIo9cU2nk2F4wyYkJY9/jkigFE2trX3CPj5Gx6VQLTpMtpK6uKGtW9wag0ADKdVtYu01/3mAOP2ZdMjJQNq24/x0XNrTVhzECTG2Rszdg32DLy+aTnnoX+iQh/i70rbO19a/GIfZCV1qPBO47dpGSiQAMtdSgeySZLAGLYDSoNtmMSsJCBopod4U+Y494qkuZfBnf7tsgmYKTlF+Z+yGUy1zeT7B27zbH2OR/7U6e/6yuiPTGdajeZtm9fvxOZNcVLmIkWg8fQkzUn+6SbM2tyxU7hCWh7Ir4FB+1vpMB0zzKUkYsvGE4rjR7eVC6cn1A6FEH5DowfAouZVjwLQSUW+3US35fjAMOz8Kbk+H6z4ie4anoDiX6dPu6ns1ocPvOTmoOGHVsSt1VOBNXindDnk58MPUQiSLbZmzIamrXj4M72jJjvOKeVWYuLCBzBVJc6gGUEf7nb8ue6YOqe6w6q5caJ6MM5LgK083qW5reQG3nOzVRtj+UoDxAvgiq6nJYx6gVM0zBP+mmGenp6MoFQpnRH0fd5lHL2A/zxenICKQZrF2i5907ypaRK1AiOvVqcG4ol7twdqQT0oetsoS4aah1ManqSYMMUKd1bynts4x071cMKrj0RZu7ejCvs7uFauC3fq/cKRUcSAg2yQ=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(7696005)(4326008)(47076005)(5660300002)(36860700001)(356005)(7636003)(8676002)(70206006)(70586007)(426003)(82310400004)(40460700003)(508600001)(336012)(6666004)(9786002)(2906002)(8936002)(36756003)(110136005)(1076003)(107886003)(2616005)(4744005)(83380400001)(186003)(26005)(316002)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 09:46:08.1626
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 749dab40-c51a-47a5-cded-08da00e878a0
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT021.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3466
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Trivial fix.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
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


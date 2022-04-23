Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A773150CC7E
	for <lists+linux-fpga@lfdr.de>; Sat, 23 Apr 2022 19:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236515AbiDWRGJ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 23 Apr 2022 13:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236520AbiDWRGG (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 23 Apr 2022 13:06:06 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2051.outbound.protection.outlook.com [40.107.236.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2381DAC92F;
        Sat, 23 Apr 2022 10:03:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fhFTelKM2hS/cqYXCA+gvfOKPJ4EmpXj+dHLR2pjgxIav4dFA54kNYAObCAiVlmoE353X1AGUne/lNvFOtn9w63LXojq1u8FKe82f5oh8P7PBnSkxlTxj/oZ8LLZrd2OzqM1RG2n5BuadDl/mwL28CJLTjjrzXNQc2bqk+t9rAB3Oky9pqLw7saklUKFL/Dkge2fLtN9YZSyld2gc4J2PKCv+39dW1wA0oV18T13fbWPsY1rwGUSvXLD9PI5QXH+iODx/ylFXJZtKLYCz5qK6kkbBAXQlY8m/zP2zzbt7RDUrAIw6Kek8UYPcsY0IFGac5iwTxmSVGkeUworGwqLEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gWxl3A7nKkKK9UuArPItKEN8cXGm/Fd9+3BOPvZ1pNc=;
 b=KrUNeyLitJ6r0CZmMc3OdP6Xy19zFGYQTnLExIoTjvY6qxNtLT35LcpxT64pzDRkFIcpTi3IJmofaMBa5GMZ7bD2GQPuMnrD4P+ZZuZaRvwOscVnXTqtvSNJj0gZ7YKYCEGZ3DQMQr/43GwMcMiyLUejZ40qUOFOuRV3LYjJc3DSJUq7ObzB/u7LUcYMSkbdbvEL/N8xQ8eYFteNXMwgnATsb7IHt9gdvdvkcPAepF/fDoR9mpkdr+7q7+u/gY7pr84fNvPPB3gZcnsG3ml952qZWM1RgydTFEM/OotHdTKPRQc1yXYD77uWvCUDKI2yjd/Dv26uo2zLMfmWYmt04g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gWxl3A7nKkKK9UuArPItKEN8cXGm/Fd9+3BOPvZ1pNc=;
 b=LTIAj8bnfFOk3g8xeAqnwMyPDzexD41kE4nKo4IdZqgvwC5ARn24X2z59PoNvllrvkzWeM4eOVyY5OVDUDdhNyoogalHDxbf+2VtSIrlacuGFJDZDz7E2s9QQj3SRYqcToL53lAzL2uP7u54g8TelvQ9KRdT7uoJfIrUQeuN/rE=
Received: from DS7PR05CA0052.namprd05.prod.outlook.com (2603:10b6:8:2f::30) by
 PH0PR02MB7509.namprd02.prod.outlook.com (2603:10b6:510:5e::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.14; Sat, 23 Apr 2022 17:03:05 +0000
Received: from DM3NAM02FT056.eop-nam02.prod.protection.outlook.com
 (2603:10b6:8:2f:cafe::25) by DS7PR05CA0052.outlook.office365.com
 (2603:10b6:8:2f::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.6 via Frontend
 Transport; Sat, 23 Apr 2022 17:03:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT056.mail.protection.outlook.com (10.13.4.177) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Sat, 23 Apr 2022 17:03:04 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Sat, 23 Apr 2022 10:02:52 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Sat, 23 Apr 2022 10:02:52 -0700
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
        id 1niJ9o-000FkB-5Q; Sat, 23 Apr 2022 10:02:52 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>,
        <trix@redhat.com>, <michal.simek@xilinx.com>,
        <linux-fpga@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <git@xilinx.com>
CC:     Nava kishore Manne <nava.manne@xilinx.com>
Subject: [PATCH v6 1/5] fpga: zynq: Fix incorrect variable type
Date:   Sat, 23 Apr 2022 22:32:31 +0530
Message-ID: <20220423170235.2115479-2-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220423170235.2115479-1-nava.manne@xilinx.com>
References: <20220423170235.2115479-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 553e801b-aac0-45e4-7188-08da254b21ea
X-MS-TrafficTypeDiagnostic: PH0PR02MB7509:EE_
X-Microsoft-Antispam-PRVS: <PH0PR02MB75092CFB48360AA23D1B6195C2F69@PH0PR02MB7509.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HUFPaM6hN7tQfPZAc1mFpjhcFb1NLScZEUwFSYU1aM6F04aMr6+bFQ1mL3ZnJcwb83w+K/r7iEuGvKMqoF72uEjNbSmnR8RlVYfidQD/5pSn7N7HJ6L5TKWIofSGvN2Qrsu6ljoFlH6QsYEefVji0KN/BaWnsG4geXY8/m/ZGGzXu73dQCWlHCKGPKdeQD9bxImvtMHrMUrDmCvH50z9o9rajP6sKV5TBc0EykPc3ny1Bj5aUJIL5H4HTA0mNPk+/Ct13bKuiWyWJ2F/Onh+xhrkPNhFZKI+91X3YEUE0Adz/PwIfFry6QUMwja+L7dkCnEJGb3B44brWYK5Jeed7qS7x4Nr5JjnW0o33bWFt87p2KYGvU4w6V/SPBh5+t8F+qTme5Z7vW98Zlz1p5vlvgdEJciq4m0VNo/Q2yZDqXCXO7tC8SrdJhak70e9T3vsQDPLrY236UzgFUMjZJ6U/5P/ONvM8O7jdHj/8mg5corL2lktItGREJNFoXay2pq7AdtIckkBmewiUEZ+2mOCB09DuKFr1yqVYjztz/8j2U9YmAGR/o9wEckUUSWzJzIIEouJT9GJy8+95eBTqSD7CajJ4yqDc8rkwWa8R2yrVhIQoyOL34cWioSF6xK5yA2UumtiEMC8JFJ4+leEap0Z2HYqSztdb6Gwe7VGiaZwsqRlQa5mnBDJms41hNwB1JlMEaxj5KxRmm2gvae8s+mtFc8hsVssK9Q/9oD62zxRhWQ=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(336012)(426003)(508600001)(5660300002)(9786002)(8936002)(47076005)(2616005)(36860700001)(107886003)(26005)(186003)(82310400005)(1076003)(6666004)(2906002)(7696005)(40460700003)(4326008)(356005)(70586007)(70206006)(8676002)(316002)(83380400001)(6636002)(110136005)(36756003)(7636003)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2022 17:03:04.7196
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 553e801b-aac0-45e4-7188-08da254b21ea
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT056.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7509
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

zynq_fpga_has_sync () API is expecting "u8 *" but the
formal parameter that was passed is of type "const char *".
fix this issue by changing the buf type to "const char *"

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
Acked-by: Xu Yilun <yilun.xu@intel.com>
---
Changes for v2:
                -None.
Changes for v3:
               - Changed arg buf type to "const char *" as suggested by Tom.
               - update zynq_fpga_has_sync () API description to align with API
                 functionality.
Changes for v4:
               - None.

Changes for v5:
               - Dropped the irrelevant doc update changes.
Changes for v6:
               - None.

 drivers/fpga/zynq-fpga.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
index 426aa34c6a0d..6beaba9dfe97 100644
--- a/drivers/fpga/zynq-fpga.c
+++ b/drivers/fpga/zynq-fpga.c
@@ -239,7 +239,7 @@ static irqreturn_t zynq_fpga_isr(int irq, void *data)
  * the correct byte order, and be dword aligned. The input is a Xilinx .bin
  * file with every 32 bit quantity swapped.
  */
-static bool zynq_fpga_has_sync(const u8 *buf, size_t count)
+static bool zynq_fpga_has_sync(const char *buf, size_t count)
 {
 	for (; count >= 4; buf += 4, count -= 4)
 		if (buf[0] == 0x66 && buf[1] == 0x55 && buf[2] == 0x99 &&
-- 
2.25.1


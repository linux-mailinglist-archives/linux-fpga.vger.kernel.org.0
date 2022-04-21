Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7C64509614
	for <lists+linux-fpga@lfdr.de>; Thu, 21 Apr 2022 06:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384116AbiDUEur (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 21 Apr 2022 00:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384111AbiDUEuq (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 21 Apr 2022 00:50:46 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F64B1C8;
        Wed, 20 Apr 2022 21:47:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XVWXX9MyjO5lbSh9tCQ5IxYCxY52N1xrcYNymFKownc83K6vlPfkCIZAikyOvyTFiU6V30K1pLSNGly5jULwfg+zSWk7wgKDIM9k5mkovLVV4oaPZZm2zOQsEZoJOiPRibi2abQTk3yCmoPGSbanqOzRf+Yj9Pt0S6D/YweGRv4wMvfhwrsT6ysA81GHAMlusUMWW01tmILZgrFbDzMiE/NCwOSRP5j2oFDWcNp1v3IDbvkuC0KcuTxyOFlkWZpts/KBavcEKgAEQIc/wdOgKwDFHsPT7Hi72Bdba/bw5A85bVwFH61ohOZGGBQnvywWQ3zEST+6RQYTgjbznJ0fUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dEFaYm6S5045Fu1uxh5+QFlwmq8IqQmdgNrTj0UAKnA=;
 b=ABMxpZiuyJeOnolyydv8O8Xw5DPuyRqzxx4cNtRXdKFAC+oaAavmgmrB8RYkB07zSw540I+rZG9yzdRDTuPkSlSwfWIn7pxR+qPKgf9qHr059We06/NSNbmax3geNPYDLfmy+lqImQvqrhXh7BV/q015oObA8DweZWJo0N2/Z6r0J24otdJc7Qa1Q6uT7/c3VTEeQXgdeurBMKr06Qpo3+VPIxqwZmc7uNu2ox2R1iPLAY0H0pr5hOZvTjPW3ukLsTFco/TtZzFEccrIyWKW6feV1kNR+/rcSwBFJoppl1/bvvSt5zeHgrcd+Ib05Zdh+ca+8TkYRbamc+L6qT3w3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dEFaYm6S5045Fu1uxh5+QFlwmq8IqQmdgNrTj0UAKnA=;
 b=JEzp8qF2XtaD2noCyHLzvBIf6X9LWeRH94bbXxTdRzJOHvMJfFN1U4HnQjWSJWTkJcOfiNT4f5hi0zOvS3WBuLjzdNA8QYbhfZ0cUHPqZlTGBkls2lS3s29M54uLfIjXZ6dsW2lJNlq7giZLHSyLR9+XSf08qPPZllIydOFUrHE=
Received: from BN9PR03CA0366.namprd03.prod.outlook.com (2603:10b6:408:f7::11)
 by CH2PR02MB6149.namprd02.prod.outlook.com (2603:10b6:610:4::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Thu, 21 Apr
 2022 04:47:55 +0000
Received: from BN1NAM02FT005.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:f7:cafe::fd) by BN9PR03CA0366.outlook.office365.com
 (2603:10b6:408:f7::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13 via Frontend
 Transport; Thu, 21 Apr 2022 04:47:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT005.mail.protection.outlook.com (10.13.2.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Thu, 21 Apr 2022 04:47:54 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 20 Apr 2022 21:47:53 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 20 Apr 2022 21:47:53 -0700
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
        id 1nhOjR-0002Sb-5C; Wed, 20 Apr 2022 21:47:53 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>,
        <trix@redhat.com>, <michal.simek@xilinx.com>,
        <linux-fpga@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <git@xilinx.com>
CC:     Nava kishore Manne <nava.manne@xilinx.com>
Subject: [PATCH v5 1/5] fpga: zynq: Fix incorrect variable type
Date:   Thu, 21 Apr 2022 10:17:40 +0530
Message-ID: <20220421044744.3777983-2-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220421044744.3777983-1-nava.manne@xilinx.com>
References: <20220421044744.3777983-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: de22d259-713e-4287-0489-08da23521998
X-MS-TrafficTypeDiagnostic: CH2PR02MB6149:EE_
X-Microsoft-Antispam-PRVS: <CH2PR02MB61491A26686EFFEE4DD0E616C2F49@CH2PR02MB6149.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yyGyZ6ENd6aGtM1WMpcmAWFWUy8u+fJP/0Ofql7qeDg5dEiG4Xy9Ah/GpgEnj5nX1JUzK2INbBfQ9TQfrCvGxslJVumoh30KN8/UrwBd4sNpwRw9mdG/G3hicMswgUn5nn7Cza+4m5fAxOAxAhJpGS9YtqBpZY/aVB2X7Dgo9RTw4GBZKIKhhm5ivhGSJ3CvcIh2vCw1sfAKC9vWmw5DQFDlhw8Wl0MzFufgfltAwwPKBXLQglfCmQo4tnl4LH5sbn0QnRMP7i8/BHaKf0j6Bl7YzLKgp+ppmWY+WNapmjMqopTEVOSP0Mu64kRKrOZ0pj8TS3/Of+3WDf+NBenSOidRYKUeRaCU/BNxvk2vPsuvY4mueHLB5sXXdDIRqIug83qEN65QDdB6fPnJqHo/aVTo5LRxH+gUoIi5+9xHdair70vAUF/2bmX9Jt9rhchaksW/gYpOhDTnIR0LyeQA68MVMl2mO6pp2mzjx/SnfQdxBzRV1dmzjwZEfladWr+gVRzA43GQMmojlrBy7na9eWflrCmnW2ceLjqbYH/ErXsuo4ueiN8klD1DtQN/6vcyVECH/09o8n1nRA/vgf2C+wnVN10KDAPcaGSIodcHSZaH4K+caDxzfiulrPiAdxnh38KA8j8RoIX4K5L4ZyMyIWDsVxOQBe3Lu87rzdEEniHlCAkuItgNigBRf38WI9enHdkIi0ZF8ANLsBiVwvqHPTcTUra2GmaYykTQt9soITs=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(186003)(1076003)(40460700003)(426003)(47076005)(107886003)(2906002)(336012)(36860700001)(36756003)(83380400001)(82310400005)(2616005)(9786002)(8936002)(6636002)(6666004)(70586007)(70206006)(508600001)(5660300002)(110136005)(356005)(4326008)(7636003)(316002)(7696005)(8676002)(26005)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2022 04:47:54.8623
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de22d259-713e-4287-0489-08da23521998
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT005.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6149
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
fixes this issue by changing the buf type to "const char *"

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
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


Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA5994D13B1
	for <lists+linux-fpga@lfdr.de>; Tue,  8 Mar 2022 10:47:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345421AbiCHJqo (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 8 Mar 2022 04:46:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345432AbiCHJqn (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 8 Mar 2022 04:46:43 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E684161B;
        Tue,  8 Mar 2022 01:45:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UJF1vkp+fMEaYtMxsCV+soXqGZp/6QN7WbzUPMrxgJyWXdKxEVROXjFRbEy3nfzNBzDBQ7nKPLd4Q196s4CQ3m4tw18tp248A2bBMLo2JuR0yxksvIjmztRFir4szVK98IwLDLfI4xkgydeIAoCYSbjJ8u0HlYvusk4HUzWM2zu+eVJPjb02nC4wolvpwhzUxGLBwBxQugkaJ5VOjMn2P6MpM3q1vdXW860jRifHfrnmqvOR8zf7/c7LASy8mnQbTc9q3GnD86+mpfZ/nHJxSBdx+tLGQE/AQj9ptM9rTW3ZZPGxNAZHC/X4Rf1uAlc8P2QZ7goQr2sLQ5SJ3egHag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1dBcBlPRbBNV8xdNyt7P09d3SCSTXyB+fyjlEPLFhUg=;
 b=OZtoAK1sfkPYjPK0KVRSA3tQYkw8YaBxgM9au9MYWE9+PItIPXCixWghZVC7x12V3nq79uyYlwWdnLQAiAgC4U9qUz9QkzR4NSQmGLNnGmA2pWfUy9CYfgvSqeb8QfI2JGbHgxVNq9ONzZsj4mnrrSwJMQkEFmKI3RfMMyHz5mDOUhXbCGVevLVxFhOf5LPUzzcK6+ZGAb0z9/NXi5tAK4lTBgtTrrRYFQHjODhebTN0Lg/qx1cg/k9lLI+PKKTSBguYQ2O/vW6Ftk/KzMN11BfXESm+As2CbdYpYCnPrDve18QIkBCErLFxFaA2LlRnE5jIYzKBz3GHOLbvVhhU8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1dBcBlPRbBNV8xdNyt7P09d3SCSTXyB+fyjlEPLFhUg=;
 b=b2cSKdBwB/kxs1cZAn5NC8yjwuvAI439PfVWgXMSf0Q40av+LIE0uHMyOb1n58qRIq1kVpPadvspfGqe24eiKX5xU9uX0qNRpqh2emUAnrqEg2tW7Qd/bOM3Eizp5WCuB9N19pTSEQqrcla72/DGE2c3H598Ia6/NtzfFuSIXBc=
Received: from SA9P221CA0019.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::24)
 by MW4PR02MB7201.namprd02.prod.outlook.com (2603:10b6:303:79::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Tue, 8 Mar
 2022 09:45:44 +0000
Received: from SN1NAM02FT0016.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:25:cafe::2) by SA9P221CA0019.outlook.office365.com
 (2603:10b6:806:25::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Tue, 8 Mar 2022 09:45:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0016.mail.protection.outlook.com (10.97.4.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Tue, 8 Mar 2022 09:45:43 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 8 Mar 2022 01:45:43 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 8 Mar 2022 01:45:43 -0800
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
        id 1nRWPW-000G0A-VB; Tue, 08 Mar 2022 01:45:43 -0800
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>,
        <trix@redhat.com>, <michal.simek@xilinx.com>,
        <linux-fpga@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Nava kishore Manne <nava.manne@xilinx.com>
Subject: [PATCH 1/6] fpga: zynq: Fix incorrect variable type
Date:   Tue, 8 Mar 2022 15:15:14 +0530
Message-ID: <20220308094519.1816649-2-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220308094519.1816649-1-nava.manne@xilinx.com>
References: <20220308094519.1816649-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9a42066-86c2-4824-f2b8-08da00e86a2e
X-MS-TrafficTypeDiagnostic: MW4PR02MB7201:EE_
X-Microsoft-Antispam-PRVS: <MW4PR02MB720146AD8558AA2476E95245C2099@MW4PR02MB7201.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oY/lZcMFKU4iaLDDtsx0RIFJLkECDi7qv/pawipHrErzxLmoTcUDz1eW/IBf2JoAUT2uFNbBMFtwx8TUPU6idUF0fReUTeyRWinoJQMXkKtbCYN09bslyMbvO9xd5vFsqs8/gfqQBV0IYokMyj/Kr6XVjuoJfJNHJA/18zW5O1Z9pXscOif3QiNcr7hoCxaLwgfz5ZyP7ZDunPQV6gseX6HXUIqnwQ9JHCRpBCfpgQzE2zbp8f7APRzaNphtOgMlwO6yNHV/hJHHNCYWjKmQnEUPZ9zsW+UOLPR2VbHJQHRTpSCLUs1CEoTkDkKuo8VOCV29eIHx0Oxn2th86WCjDj4ZZQ5J3C9c58JYUXxUCbDnsvk4UqICsbnE7HAFh+wTiAs67Ac1k7BhxVUIGnyBcLlkxevTF3ckxe3mG6ItznZoxURjx4mUZbxEuiL03jeEIDQRDJOY1JAHWvfxizmMBq7mXUdjI5SEWPRmjigbIu+5+2lPE6FH4bwGDa6V4y+9WkQ8bL4gUy3O15v3TE/WTm5Kpi2MertcdmXZUrpPRSD4cwfPnBp6eYmwVyfDPFPd30s+QZ1vj6kc/EBOJjjgvvIhI7RVC1rpA5/b7aSUAHDuJ9+lwpnWKzNa6MhAsyAoxtXSaF9LGRJ0vKQM46ZSOKOhqaVHv+yEhP7Cl8t35n8z+4Re3vr22TnFA7wW9hwWms0WDidmdigogZgtnrg61uGxicT1ODj9EmTvEpUGJFo=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(26005)(336012)(82310400004)(107886003)(2906002)(186003)(426003)(356005)(7636003)(1076003)(2616005)(83380400001)(47076005)(36860700001)(8676002)(4326008)(36756003)(70586007)(70206006)(9786002)(8936002)(4744005)(5660300002)(110136005)(316002)(7696005)(40460700003)(6666004)(508600001)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 09:45:43.9439
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9a42066-86c2-4824-f2b8-08da00e86a2e
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0016.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR02MB7201
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

zynq_fpga_has_sync () API is expecting "u8 *" but the
formal parameter that was passed is of type "const char *".
To fix this issue cast the const char pointer to u8 pointer.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
 drivers/fpga/zynq-fpga.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
index 426aa34c6a0d..12f644e79e91 100644
--- a/drivers/fpga/zynq-fpga.c
+++ b/drivers/fpga/zynq-fpga.c
@@ -275,7 +275,7 @@ static int zynq_fpga_ops_write_init(struct fpga_manager *mgr,
 
 	/* don't globally reset PL if we're doing partial reconfig */
 	if (!(info->flags & FPGA_MGR_PARTIAL_RECONFIG)) {
-		if (!zynq_fpga_has_sync(buf, count)) {
+		if (!zynq_fpga_has_sync((u8 *)buf, count)) {
 			dev_err(&mgr->dev,
 				"Invalid bitstream, could not find a sync word. Bitstream must be a byte swapped .bin file\n");
 			err = -EINVAL;
-- 
2.25.1


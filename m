Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26CB94E3A7E
	for <lists+linux-fpga@lfdr.de>; Tue, 22 Mar 2022 09:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbiCVIYA (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 22 Mar 2022 04:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiCVIX7 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 22 Mar 2022 04:23:59 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226EE5EDF8;
        Tue, 22 Mar 2022 01:22:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ldy8qnI34ft5PBi94L5Zid5GoS08N231FE8gAho9cTl2UxOU2aoY/eLjVQOLO1Jq3+yljCsnZQcfHx+AySkoTZ5+pZgOAZnUqzUdZxYIt2O5eTeTkfiKnlcQLw8tzuGdPmeFX58Tnr/QDuUBnMtbN6fM0TsmYAUdhKRCFhocC6pxp9cIjg7jqRuGBM4dbjj4D0w1rXZ7Xq7wWiWbr4g08BWAz2CWCasIS9i/3O/MN60yN8jSaqryYqJ1JaDAZfUaoeJBBAJWyl5htv8hxhMRtocSVCzYR66fLnOsH1KRkfqB5ZuRutJY1okY3By78yZJF6bAqjrtlp8vkIkSdko2ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ak2q+Yo2MKKkrgeLry6olHVen+gLKXxsh6LRiTLIbMg=;
 b=NzEPk5+tu9FUlD6bsXCzbsVlEYjUb15ArFaekAXCnfNou+y9zPazRatnak6/YxcLHV5kC9ConLTbfm+r/lSGldh9SpnPqwMq/0LpRbJlY/UXdgdCXHXxUu6qXX/ObOv+RNNI9iKdK3aZfPacJ42u72tNGCYbJTtKTy6xhGtYfK7tAD0tnivKhLJqCNAKrhZMU5G5YrRIKQK27wJTeYMxnp+Tyw9bqqMgbBdPwBLVXkdJpwZVV6KbA/ED+wRXgm687eae55BUD1wOvCTpZ2SBXZUGWntJaCwJdML5N667XkgCdJvN22Hain2XVKontufCwOsdYju9eWTI5hQs3G5PAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ak2q+Yo2MKKkrgeLry6olHVen+gLKXxsh6LRiTLIbMg=;
 b=iP6dN+J3yGCPkjUgrwzSIbdcl6VthXkjo5Ymlu6YFTaceMMe8gR5vmySXxCFt0SODp7RXvk1gtiIcHb6J+TPiP9irg6edsr8szs3sblhRs7mMVsk2jty5Gv+qW0N9SQ8tIytt+I47lmKPXQkS7e+VSgToa8Na80BzY+WxAjDwB8=
Received: from SA9PR13CA0077.namprd13.prod.outlook.com (2603:10b6:806:23::22)
 by DM5PR02MB2841.namprd02.prod.outlook.com (2603:10b6:3:108::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Tue, 22 Mar
 2022 08:22:30 +0000
Received: from SN1NAM02FT0029.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:23:cafe::29) by SA9PR13CA0077.outlook.office365.com
 (2603:10b6:806:23::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.12 via Frontend
 Transport; Tue, 22 Mar 2022 08:22:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0029.mail.protection.outlook.com (10.97.4.175) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5081.14 via Frontend Transport; Tue, 22 Mar 2022 08:22:30 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 22 Mar 2022 01:22:15 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 22 Mar 2022 01:22:15 -0700
Envelope-to: git@xilinx.com,
 mdf@kernel.org,
 hao.wu@intel.com,
 yilun.xu@intel.com,
 trix@redhat.com,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Received: from [10.140.6.60] (port=48200 helo=xhdnavam40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <nava.manne@xilinx.com>)
        id 1nWZmR-000Ei2-7J; Tue, 22 Mar 2022 01:22:15 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>,
        <trix@redhat.com>, <michal.simek@xilinx.com>,
        <linux-fpga@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <git@xilinx.com>
CC:     Nava kishore Manne <nava.manne@xilinx.com>
Subject: [PATCH v2 1/5] fpga: zynq: Fix incorrect variable type
Date:   Tue, 22 Mar 2022 13:51:58 +0530
Message-ID: <20220322082202.2007321-2-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220322082202.2007321-1-nava.manne@xilinx.com>
References: <20220322082202.2007321-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c202cb06-8f5b-4e36-5868-08da0bdd1b6a
X-MS-TrafficTypeDiagnostic: DM5PR02MB2841:EE_
X-Microsoft-Antispam-PRVS: <DM5PR02MB2841D1D7338AEF2D2BF1E38DC2179@DM5PR02MB2841.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MJweJw7Qalvbrvz4kUfuEI6MPz9KzD3OH7Uf3hZ6euQFxSVzbpDMg7OWaPsARULuXUPT1dCFnIix5FHf27NAhJfuyzteZv/QqGb49J4hEHzN8GljWeU6SUuNqc9Qw270gi3FYWAXQag79aqNpq00TEspjVznVIvozoeF98pJVHUIaGPWpe3NUI4YDCZGto44AYd7WOCpg220+s8IbrUprJj1u1ZjYSe0iOOa2Cht4mP+wQw0klD+Y5mEwNilMEbmqfffMIs/ZR35kFpeBdNxJEfZB4wO0UhMocAcH6TN/mLYSByt7HrFpBx05vfrozVgdhRh0io8LxmRs1GhZXCHXixk9iLKxesOmFP6dsyl/miS0psxYQfAUU/S2sKXB5ifdREjolc0VQXvLHeiJXbheaELRh4v8ge5IE4pMq3Jwz6KqtN0WYLOPCRn8R6ZbRs1zr1AkVNfw3x791dmtf9QyMczzJy3BcmHQD02iLgPaY2+5p6Ju4AeyJOTVIfGOhvfXuoE5BAklrNjbF4+gLMXSQU50Vl0u68uH+wvoAMAkgx3MrbxXfIFy4VwgaOd8bIg5Inos34SiMRdMGLOGmHYR+fErM/otsXh7EnsVjuloOI5VUZsoRMxQRsCHViCjrbKuxAITrb8pAdlSbMF49D35bEA2BWbdshqiTnfMQeXhzIbdhD0lKHfPPqndMOXH7UJGrTLJYY4G9dYWLemiIk6HxEhKCeHZYoYDz7oXceg1Rs=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(107886003)(186003)(26005)(6636002)(2906002)(1076003)(110136005)(4744005)(508600001)(336012)(316002)(426003)(6666004)(40460700003)(82310400004)(7696005)(7636003)(2616005)(70206006)(36860700001)(70586007)(8676002)(8936002)(83380400001)(356005)(9786002)(36756003)(47076005)(4326008)(5660300002)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2022 08:22:30.0103
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c202cb06-8f5b-4e36-5868-08da0bdd1b6a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0029.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB2841
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
Changes for v2:
		-None.

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


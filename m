Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD9DA5036CA
	for <lists+linux-fpga@lfdr.de>; Sat, 16 Apr 2022 15:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbiDPNkQ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 16 Apr 2022 09:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232093AbiDPNkO (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 16 Apr 2022 09:40:14 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2070.outbound.protection.outlook.com [40.107.236.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10761D39A7;
        Sat, 16 Apr 2022 06:37:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iMxVfUNP/KNPXHB8bAd3jJtssu//qm/bali53flSqwbNOsHAYamWHQ187dd0NBlT39Zvk7hF6cl1rLLIvKun1SHdW2X1hjf0H9/dLpT5QUWKNcQqZNvhPK7em/jtwSGYBOLYZXAO3Q0vhPkeRnUU4nlBjMkklmsPZmInU4t/TWwfpxKrHkYbME7nOvfdITIETZhk2prUDoB00B/V4Ztqy4FcA3XB1O7wimJJSL2Oqh4buPDOzHsAo/isia5qIV4WIP8Xn2ky652x2fuT9d7+RZDdaj1MeKoNuLpo5w6u3asn0FmR9uJ9Ln1X2HBCbdMHI5x89MAhwuQNGHTbJQj5fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GIKD7jfG/l6nA1zGhjG9YLGX6jUh2n7kdavS5YneHjs=;
 b=Cz9VFrtY1DWOPUrmHuS6h0cIM5yYgIfmfTt8FuY+YJuE7Q665y6DVm17AXrECRnLHDCXzeDK8DlFqZ3T1CovYbvKW9KpQgin4cXRHyv+scTcWVMJBTGqBFMe8xI4Qm8WX0Q7EBYNOEj/chLMOzCEtSmWdg3S2zUn6ZfTYNuiYy+B5uGtQvHhihM0Xp9OTeV94Ci/OLCo10tV6NPvGCI7PdGfIHp/Ppl7hmlUlB/qrZQGBjt9hgkJsrWe0FgBRTl9Mn860XRnhq76uIU0gKWWfL/BP4TNtuzoMFnothwsnRlnlJx2oFfr9Y9uGx/oGWtvrhTJtFz8QjJRabr21Jm4wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GIKD7jfG/l6nA1zGhjG9YLGX6jUh2n7kdavS5YneHjs=;
 b=gn4kXS+Ipyc8hzQBefVpHTmKQE10vdeJaw+zgVPtLS5uhE6Z53yQ0wSwqA+PP1ircdqAoWCeb746XtVVkUlExQdcwklbKicRxN4v3BW8skodOkMxrYANJVADiC7u1FB0/AdvuxhibnNGXgA1eaTQyn+PJtodEVrE1B8oAKBCctA=
Received: from BN0PR04CA0157.namprd04.prod.outlook.com (2603:10b6:408:eb::12)
 by DM6PR02MB4618.namprd02.prod.outlook.com (2603:10b6:5:2c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Sat, 16 Apr
 2022 13:37:36 +0000
Received: from BN1NAM02FT048.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:eb:cafe::e6) by BN0PR04CA0157.outlook.office365.com
 (2603:10b6:408:eb::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20 via Frontend
 Transport; Sat, 16 Apr 2022 13:37:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT048.mail.protection.outlook.com (10.13.2.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5164.19 via Frontend Transport; Sat, 16 Apr 2022 13:37:36 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Sat, 16 Apr 2022 06:37:31 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Sat, 16 Apr 2022 06:37:31 -0700
Envelope-to: git@xilinx.com,
 mdf@kernel.org,
 hao.wu@intel.com,
 yilun.xu@intel.com,
 trix@redhat.com,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Received: from [10.140.6.60] (port=32988 helo=xhdnavam40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <nava.manne@xilinx.com>)
        id 1nficF-00088I-C3; Sat, 16 Apr 2022 06:37:31 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>,
        <trix@redhat.com>, <michal.simek@xilinx.com>,
        <linux-fpga@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <git@xilinx.com>
CC:     Nava kishore Manne <nava.manne@xilinx.com>
Subject: [PATCH v4 2/5] fpga: fix for coding style issues
Date:   Sat, 16 Apr 2022 19:07:16 +0530
Message-ID: <20220416133719.3382895-3-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220416133719.3382895-1-nava.manne@xilinx.com>
References: <20220416133719.3382895-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0359884a-ac9b-4478-a77f-08da1fae44ed
X-MS-TrafficTypeDiagnostic: DM6PR02MB4618:EE_
X-Microsoft-Antispam-PRVS: <DM6PR02MB4618665AD4F3A2EAD7C73D8AC2F19@DM6PR02MB4618.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AvhWMjAqmJwKFB7phtQdWr7E4TdsOBiO9x1SRGIZBlXg0hnwU4AZ3GPG7903+wDAJGj5PInzuu8gIBtfg+UQAkFDN0Twf/0NTzE1ZRza8wH0WLOCc2KuQF/T1trKSNBuQ/ufdoNKK/+TGM7Khi41Msvda2RXYc+gfUc5it3hKUl8lMqcDY5cP4K5Ht5Y4n/fKXloanxdAQARfZPoDDxhKRlWnHjM4Mx6kVCE7u3ciCvmgshXYbJ+9fDPH24OGo0PuUcmbtNoscYQ4mQ1fQyblIXtGZySn5+A14UX9VvDG4SYD7IQeC3yyXQckcjKiMcpFC7gJoFXT7LRVNHP4oSdijGxI+K1uBgtJabFlktncJww0SI4eurekJHAnWjBv110HJvovSK9UukcUdds6UXdTxug2Bp6AIqh8pD/2mtPntyVymVvdj8nLnj+NhI1+tuRS8JRIB9YsKGmwGsWYYTsuf+qkETZCFLjtF6SXeTDeX0dfruWY1dzkm3g4nWFGQjpA0yHbvBYW2XztcJGtHzMN4tic0I7PS+xTU3fjff3Bhw4EG95QZYhSt7dmiaZ1iKb4UkGdZzq4aXboDhlKn/AubU0NTwQNyzps70EkMy+ODM4d9wqHIL3bckZT3lBfwAX7l/6HjKuS270eiLobyR0/EjJoEIE+g81MCBES03VmeEK/pB4U4i/Xs1Ncp957/V4cjIF3Xq2cnGR9o2/711U0lxJuGseRWRHcyuu2+cp1WI=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(36860700001)(7636003)(47076005)(2906002)(356005)(9786002)(5660300002)(8676002)(4326008)(70586007)(70206006)(8936002)(110136005)(6636002)(7696005)(83380400001)(508600001)(36756003)(40460700003)(336012)(426003)(186003)(26005)(2616005)(6666004)(107886003)(1076003)(82310400005)(316002)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2022 13:37:36.6136
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0359884a-ac9b-4478-a77f-08da1fae44ed
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT048.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4618
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
Changes for v4:
               -None.

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


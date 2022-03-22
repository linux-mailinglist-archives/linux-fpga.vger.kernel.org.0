Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF57F4E3A7D
	for <lists+linux-fpga@lfdr.de>; Tue, 22 Mar 2022 09:24:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbiCVIYD (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 22 Mar 2022 04:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbiCVIYA (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 22 Mar 2022 04:24:00 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC12C5EDFA;
        Tue, 22 Mar 2022 01:22:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GfroWHlOFFbB9An0hHNmskNXldVeY+CJjSJJKwKg3RAvOEPSxtA8FRO6jAFycmJR+IBiRont9F5Pq4eE/CQVmuQjVC646dfd+ag693xUqu4IW3z5KARpVr74M8z982Z5RmRxTkXMSwXraUelm372QFw94Zo9mJsltrR+0v5bE5Fm7DS8SXfn5RgM+GVc8AeeuYEO3athzCs0SxDQq4HCdO+GpJAC2bf2RxninRjTOltpghMoGyC6NqsEaiUbi7RmYPKTodVuc2vTp6F9FQO6aHdHFl+59G8CiYfNQzb9ao6hH+VdeOnLie3i91F27h2y1j16LSJFBF98LSyTHJNccw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E6rP4CZSj65+QvhOfulAe2jNokWPFYyLoj+WQtm9k/A=;
 b=mIBq/OmZFGxXAnVg7cQOm8/Yijq0RcG2qHeonEs1o5valNfMJvaF+rVix65XRCXklpOIlzfeAf6rOMSejWCEuEllD8f2k8TcNEZTHWqbYPNRItdYFnc1452jvR7wGUA4WcVmN64c+3xINprKlJUamafgUjqZz3AEssDHchEOkV5gF8KkquXpz2sinYI76rV2rKGqznBcy/68fTsbhM2WvzdiGjP8uWof/akoUzsib+KPL0qBEZNH5nJ1+Cw4Tv88OgyivugO9A4HmFChGSDx7etYetEPEmU70FM5y1LXeZYe6wHoOpOytyki5ZHHksCILTKHZ3RTCndC6B0RoJCTqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E6rP4CZSj65+QvhOfulAe2jNokWPFYyLoj+WQtm9k/A=;
 b=qfrSsewXFWiEA23v0kc6PM81VziqHZm3bUwyXw3ea1BQsgL0suFgacBRb6tRcCA0o8tNzO3LTSIAqK2MkqHKCrJkhq7vpkla11S+MMJgfs+YiqFFGYrws0tYSgqboxRrYebzLfH9PQYqtXv6eBCHV6RX/BXi5VEV6CK7TJidmSc=
Received: from SN7PR18CA0002.namprd18.prod.outlook.com (2603:10b6:806:f3::25)
 by SA1PR02MB8592.namprd02.prod.outlook.com (2603:10b6:806:1ff::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Tue, 22 Mar
 2022 08:22:30 +0000
Received: from SN1NAM02FT0051.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:f3:cafe::c1) by SN7PR18CA0002.outlook.office365.com
 (2603:10b6:806:f3::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.23 via Frontend
 Transport; Tue, 22 Mar 2022 08:22:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0051.mail.protection.outlook.com (10.97.5.34) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5081.14 via Frontend Transport; Tue, 22 Mar 2022 08:22:30 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 22 Mar 2022 01:22:24 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 22 Mar 2022 01:22:24 -0700
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
        id 1nWZmW-000Ei2-Vj; Tue, 22 Mar 2022 01:22:21 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>,
        <trix@redhat.com>, <michal.simek@xilinx.com>,
        <linux-fpga@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <git@xilinx.com>
CC:     Nava kishore Manne <nava.manne@xilinx.com>
Subject: [PATCH v2 2/5] fpga: fpga-mgr: fix for coding style issues
Date:   Tue, 22 Mar 2022 13:51:59 +0530
Message-ID: <20220322082202.2007321-3-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220322082202.2007321-1-nava.manne@xilinx.com>
References: <20220322082202.2007321-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 53f27c1d-b35a-43cf-cc13-08da0bdd1baf
X-MS-TrafficTypeDiagnostic: SA1PR02MB8592:EE_
X-Microsoft-Antispam-PRVS: <SA1PR02MB8592CC0C393AB7932C4BDF2DC2179@SA1PR02MB8592.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cDy9CKsamxQNUkCreyiM7WgZaqiphEd+Ez0VLuGgKKLNeOrvKPg0f5fznWVl6y7NWzh3zVtme7Up6LO2UBkdZHxkHQaGbUiwlvFTqlkr06Q64C6xpstCKBUmSvXOxEjtDPiHrmZgNdJC9JavgjcWToOkFKUSNosDe1kPGmoX1EXwXpDgIgYBvuJaU/g9XMFRjeub8KNy6arwA1VqcWeTJLnU+ih/StqYi2LfMdPOGqqqvlmzrjVLLPGqQ+ln4O6+RhOo42gMQ2+GjpQo26jE5j9y6HxwvEPG+wQfszG5WdEn0l1h+eRcgHpCDvonuXnrbDJ4sSep7kJuRPKumu78N5i/fS+LpZoqsaM7f0I4APlfKKYiN5MSSx6dTK9FHfCfk09SoXWnHtf5kG2QOWo7j1hFcohiO+H9fNxqPrD+OrN2zMe5bjo/i75YdyvhyUAUe8x//5uSltfYoeAEENpkQhXlnFPKtEs35jGZ9C6dwM5TWfdYMBFZ1qbfNvCMf5wQZxv1PL3ioxrJxaLCbtRFeAG5gNKDbRc9fk6QCVwmOtHB9j6DNlKMkL4VdJFVa1iB7CtiPaqQS+pKfEhQXJUoOnmpM8XEn4WF6/BX5if0TWDvU6/hkYQztUSUuuIwHwyOR2XCIcwnmSseiJ4cPXqmMzDiW7+1q+AiX5twnIfkenLjBhbazpPzCg4NNEIxIhYc7z4L01t39yT8gKBk21Hksas5RHYsOc1ieyxBanT/p+E=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(8676002)(70206006)(70586007)(9786002)(8936002)(6636002)(316002)(7636003)(36756003)(356005)(110136005)(508600001)(107886003)(1076003)(186003)(2616005)(36860700001)(336012)(426003)(2906002)(26005)(40460700003)(4326008)(47076005)(82310400004)(4744005)(83380400001)(7696005)(6666004)(5660300002)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2022 08:22:30.5749
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53f27c1d-b35a-43cf-cc13-08da0bdd1baf
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0051.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8592
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

 drivers/fpga/fpga-mgr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

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
-- 
2.25.1


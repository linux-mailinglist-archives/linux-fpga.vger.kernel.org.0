Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 657D06B93BF
	for <lists+linux-fpga@lfdr.de>; Tue, 14 Mar 2023 13:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjCNMZy (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 14 Mar 2023 08:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232184AbjCNMYz (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 14 Mar 2023 08:24:55 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20600.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::600])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E4BA334C;
        Tue, 14 Mar 2023 05:21:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SKx1/6vrCI/e4l4WtDqorObtSld1dLz9DW/9HpNLLBTjZPEHYNcj//PQ16S9AFh57EI5He+QEcPqnGDYQHN7d+jukWh4TXEU7YO97a8tDlrCHsV/OfCyEbvNzUPOGbR5qGck+N4G7BPRE8vxMgtgVKALFcJI/she4tNoNWGsrAXkEMNbjhiTtN8UPY/qLQaKNeQXjyES8WGuqHLELi0g8vleyP/ROqjc9ai3NLd/c+RCjR8SNc/vYrNPHGFf+L7i+PZdfpqULkoRsk5iUQQL9XKTuwaVwX9qd1GNYzXg0iVeXRYyKcovY87YQ1p5A5spZ1+uZkPkyBHnz8ZXH88O1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=06QRnwBFkAy5hwfYMclna6gUEFEuyUo99LDMVle2DQA=;
 b=hNNfkgvP4ZXlFMxPImZeg4O8Q5WaGKjpzl+X37fTzkwI2rGpwwGzNNlTbWWWyLYoH5ieAWMcb6asdQLnZH0Ys83HkOIk+bYrLOT49h/RENifBXIp3VuvY2LidEqG59MfDCMXcE3Ct+PX+GKWneRojSU1Q11XrtBEy/vmSZJhL9YUdn+AkB4O8FA4FOEYWW+SrBwjMYF0QAA7Z0+UpWT1/rFj2xMeKfpMDfirDgH2zDUkw8dUJN10T/G4eJK1DqV2EWCwGPNb+hj7c35sLjnbtOiiTCggNSy2QudA9HxiAHqsXpjd6i2esUT90vUAQKY7WpmHP/qqRktJoLfifenjEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=06QRnwBFkAy5hwfYMclna6gUEFEuyUo99LDMVle2DQA=;
 b=ibH6mZRDv9UBKG+rTuy+9gDx8HS/WMgcM5/g7qI80Nna4Q/vydnoILOzv8V1fUTT8LOAXHfjYkrNVr221dqpYdt8QJyw4atJjm/WZHZx2Qklwej15oDgAYYGbXpdqkpVWJcx+jAGEt5jo4D6N01r+WCJOWZF50ViPhKLdxa/5gw=
Received: from BN9PR03CA0586.namprd03.prod.outlook.com (2603:10b6:408:10d::21)
 by PH7PR12MB8153.namprd12.prod.outlook.com (2603:10b6:510:2b0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Tue, 14 Mar
 2023 12:17:59 +0000
Received: from BN8NAM11FT097.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10d:cafe::87) by BN9PR03CA0586.outlook.office365.com
 (2603:10b6:408:10d::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26 via Frontend
 Transport; Tue, 14 Mar 2023 12:17:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT097.mail.protection.outlook.com (10.13.176.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6199.11 via Frontend Transport; Tue, 14 Mar 2023 12:17:59 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 14 Mar
 2023 07:17:56 -0500
From:   Nava kishore Manne <nava.kishore.manne@amd.com>
To:     <mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>,
        <trix@redhat.com>, <michal.simek@xilinx.com>,
        <linux-fpga@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] fpga: zynq: Add parse_header ops support
Date:   Tue, 14 Mar 2023 17:47:54 +0530
Message-ID: <20230314121754.297264-1-nava.kishore.manne@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT097:EE_|PH7PR12MB8153:EE_
X-MS-Office365-Filtering-Correlation-Id: 587d42ae-afa6-4497-512c-08db2486265f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YWsIGHcTjlHWJ1q8w+mmBCj7mxFNlDe7ED7ExOpSam+iAspTu8LUMhbQWL43EjTuMAAtAclEZvIm63/098mgqM/qM6JsGnlOFYNNE+eTOdkcMKTNCcG/oUF/LAHx4aY3aEIawnX9CmpTruZTqz7DGqEPVsGh9dr6J/CLYTHoQVYfnthzU6htdlpI+1/R7RONBNsE1iuphhW6WPq2YfIpqAQagIUA2DpW5aWbxH+yg4Ed6HZZmaNjv+6yRrIxElWumy36HhgSlhHFcu7c+swwiWFNNY3qCcdNnRCJm/zkZYG7wsSE+E9GQGdl/V+ZHJ3m0yPkXwplM9VwGt61EBfCLrpKT+vYwSg1rFDkOccbcVnhKtXN86wFbxoYZTdFMUW3aBxPpjEZM9LJfgxuskMUs/vgYMuaQfOS1EoTMZQA3aEXMz4ZZM9KunsH+hQvFIJLun5SLHo6ateoERfx0y7rUr5KWCrNHRSUpHA8w8aRZjega431VaW8Sfw6aq6oP40vYegTzy0Rxx37rp8bvdRbJi7fmKFBUawSOjwTRJXXzMbxffPpFshtinMihW83rwXfq1cgYP1KraC8j+s3ZZbkEepHkRBo7Vw2N27P4iD+9+nVHl3cDo2lRxQ4lAfjhWQeI1X4iiBZCiq+RWk2qfQNzOYwZJE9IseqQvKYGngwziiWsQE/Mz/R2eA8ETcVHYFD5+mUyUj54vHYxHisccX5zqi5YGjC/8Bflcf8E1dyHZgCmlTmt3ZNg5PyVEZNuviy
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(346002)(396003)(376002)(451199018)(36840700001)(40470700004)(46966006)(336012)(47076005)(426003)(316002)(110136005)(40460700003)(103116003)(36756003)(40480700001)(356005)(16526019)(86362001)(82740400003)(36860700001)(83380400001)(82310400005)(186003)(81166007)(1076003)(26005)(2616005)(5660300002)(478600001)(41300700001)(8676002)(2906002)(8936002)(70586007)(70206006)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2023 12:17:59.0586
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 587d42ae-afa6-4497-512c-08db2486265f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT097.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8153
X-Spam-Status: No, score=-0.6 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The commit 3cc624beba63 ("fpga: fpga-mgr: support bitstream offset in
image buffer") added a new parse_header ops to handle the header related
stuff in the fpga framework. So moved the header validation logic from
write_init() to parse_header().

Signed-off-by: Nava kishore Manne <nava.kishore.manne@amd.com>
---
 drivers/fpga/zynq-fpga.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
index ae0da361e6c6..6e5df0193028 100644
--- a/drivers/fpga/zynq-fpga.c
+++ b/drivers/fpga/zynq-fpga.c
@@ -248,6 +248,21 @@ static bool zynq_fpga_has_sync(const u8 *buf, size_t count)
 	return false;
 }
 
+static int zynq_fpga_ops_parse_header(struct fpga_manager *mgr,
+				      struct fpga_image_info *info,
+				      const char *buf, size_t count)
+{
+	if (!(info->flags & FPGA_MGR_PARTIAL_RECONFIG)) {
+		if (!zynq_fpga_has_sync(buf, count)) {
+			dev_err(&mgr->dev,
+				"Invalid bitstream, could not find a sync word. Bitstream must be a byte swapped .bin file\n");
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
 static int zynq_fpga_ops_write_init(struct fpga_manager *mgr,
 				    struct fpga_image_info *info,
 				    const char *buf, size_t count)
@@ -275,13 +290,6 @@ static int zynq_fpga_ops_write_init(struct fpga_manager *mgr,
 
 	/* don't globally reset PL if we're doing partial reconfig */
 	if (!(info->flags & FPGA_MGR_PARTIAL_RECONFIG)) {
-		if (!zynq_fpga_has_sync(buf, count)) {
-			dev_err(&mgr->dev,
-				"Invalid bitstream, could not find a sync word. Bitstream must be a byte swapped .bin file\n");
-			err = -EINVAL;
-			goto out_err;
-		}
-
 		/* assert AXI interface resets */
 		regmap_write(priv->slcr, SLCR_FPGA_RST_CTRL_OFFSET,
 			     FPGA_RST_ALL_MASK);
@@ -545,6 +553,7 @@ static enum fpga_mgr_states zynq_fpga_ops_state(struct fpga_manager *mgr)
 static const struct fpga_manager_ops zynq_fpga_ops = {
 	.initial_header_size = 128,
 	.state = zynq_fpga_ops_state,
+	.parse_header = zynq_fpga_ops_parse_header,
 	.write_init = zynq_fpga_ops_write_init,
 	.write_sg = zynq_fpga_ops_write,
 	.write_complete = zynq_fpga_ops_write_complete,
-- 
2.25.1


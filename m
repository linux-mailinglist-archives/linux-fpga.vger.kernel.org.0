Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5988C6C0FF4
	for <lists+linux-fpga@lfdr.de>; Mon, 20 Mar 2023 11:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbjCTK5J (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 20 Mar 2023 06:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbjCTK4w (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 20 Mar 2023 06:56:52 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20600.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::600])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC99C2823D;
        Mon, 20 Mar 2023 03:53:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ACdCtQXczCcu+TBPpfYItOyAyVb3xuwqPdiQN/EOF9AWWWukEFjLzgGKrNArgdRvsZrQ6wrcplru8P25uwk66p5UBGNzEIDnTtWAf2chOgSpnx6t1d/u018ecbT38z+JmgGF9V6cuNf0TQq/Tm/TiDn/LKLUIY6hh5y8kabruFQ9VNL2ughvOFvvCvNq20fJKkg/MthQqjf8wnPwt/n0+VLYkv8TutQ3OwYfrNbb7nr/zBB2KWhHyE587b5V1JkXfTH6Qe3RFJXxBJdP/6yOb+7MjNC3ZrmNLQ+v2/t2op8yOiMddN8YqztyHxb1x9vRU3GfunUD43Z6iQoZ2U7iaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9G5x9tVVA8+tjN9Skd3JGVYtnjetlYUwM8hAeUgGsiY=;
 b=DpavIvBx+tao5U0oLkpWDaZ8s7g79UTSFVkkyeCp9IqlBpBFkyW2ZVQ38yJ247/YU0Dp6kXSbGmwb0kuha66qAj0irsEi2DsP3LVJTZ//670xYsR+Yf5baN7LtvgUP/RYOYP6grlVJV0L+22vJIpO6Fz7HsbMjRF9Ot+S2wbiGsobSQzJ6xdUQ535A12rHjR6J33T0BHw4k4MTTJrSUoVAvWzMB+s6VwwDV5NNkOxpAu2+LojBjjsygBFKcIwSGuzJ++/KNndPIIZssnnRXt+CKc2FKWgk9iF1t8qnbD3f0QZj9xQA7QUd+KqsBFrnncn15oAsp7aHs//DLB5VGHnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9G5x9tVVA8+tjN9Skd3JGVYtnjetlYUwM8hAeUgGsiY=;
 b=1ojHXRY3jmrk6cr8RooBHCH/9Pyxz2olUj1YN1p7INv+mmEopPmEn3+ZPygn/2s1dVyv4h0eFcjpceDgEGV9Qg035AAR6O7Lzd0x8rr99LVwePR3+AVS5LKThZZqc+Q6LJf4MvoW3VM9nSp4heGa57qYMtAeDS0tKntx7hA1i98=
Received: from DS7PR03CA0238.namprd03.prod.outlook.com (2603:10b6:5:3ba::33)
 by DM4PR12MB5296.namprd12.prod.outlook.com (2603:10b6:5:39d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 10:52:58 +0000
Received: from DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ba:cafe::bc) by DS7PR03CA0238.outlook.office365.com
 (2603:10b6:5:3ba::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Mon, 20 Mar 2023 10:52:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT035.mail.protection.outlook.com (10.13.172.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.15 via Frontend Transport; Mon, 20 Mar 2023 10:52:58 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 20 Mar
 2023 05:52:57 -0500
From:   Nava kishore Manne <nava.kishore.manne@amd.com>
To:     <mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>,
        <trix@redhat.com>, <michal.simek@xilinx.com>,
        <linux-fpga@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] fpga: zynq: Add parse_header ops support
Date:   Mon, 20 Mar 2023 16:22:54 +0530
Message-ID: <20230320105254.2214736-1-nava.kishore.manne@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT035:EE_|DM4PR12MB5296:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c096865-08ba-46a6-bf51-08db293144a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FWV+t0+kM+xdDCdQv+Kj1rTbARR09B9+WNYkSixeLJzdPqWGTmYNDKdm3WkqwENrypNezexi0n8fRhIN8VPBAHCOw8CYxWEx8rPs04IJXAEXzcKw+eFVlAU0Ncyk8pDdwQSXHFqvSZwJlvO+BXwinodQSh0LuXKI1556F0draMibkmmSoHh3pCv+YCgDQXbIO8Cw5YB/gvvzFltOP2PH9jegm7/f6Eq3uin0HTor40obfbKt4AoQEGj3nrAPcogglMB3C9VIsfUxxuK2SExIW/9wP0/3L6418w7W9E9jFRLXBHJLIQXJtj6UjCUyJZ3Ck6lrsKQm7CG2UUxDZhST/5TKYlIc62RJOZ4zQUJVMEDVlVr9VY91S1RueOUbFp6xp08+HTPPEPNYaAHUqTmM6Xsu8fWHDSe230dbULL+zsNi8UhE1OHaeRgvmIEJB8+XzYABY0sAquZttMAwbyNT4fj1gs8Ccf1tESZ//IXYtgNMQCeEO+satkAiUlhGQ3jBMfRetSH1drzlkn5vNCJaWNEo6fEwdzK321f86OUNJjjZE655M/2LjdUnfRfzIJ2TLKr451K3ru5WUH1EKBPzVOo1qAt8tGZsYqLXh5Dm9R2fwBSOjgIwga4QZSyrgjA+dqpvSSAAr8UtoOIg7jEHepOemzvkgYEmYoabU2CAVUKGhFEImNpulqRROdSI7tNKxs/zh1ohofUFqSXxGKRaPpEwRiEMsxqXD61R1baXpGWiYQKpdY6rI8ggGsf4QsoR
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(39860400002)(136003)(376002)(451199018)(40470700004)(46966006)(36840700001)(82310400005)(83380400001)(426003)(2616005)(47076005)(336012)(40460700003)(86362001)(356005)(36860700001)(70206006)(40480700001)(82740400003)(70586007)(36756003)(8676002)(41300700001)(81166007)(2906002)(5660300002)(8936002)(110136005)(103116003)(16526019)(1076003)(186003)(26005)(316002)(478600001)(6666004)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 10:52:58.4256
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c096865-08ba-46a6-bf51-08db293144a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5296
X-Spam-Status: No, score=-0.6 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
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
Changes for v2:
              - Limit the sync pattern validation size to header_size
                as suggested Yilun.

 drivers/fpga/zynq-fpga.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
index ae0da361e6c6..61024434a3d0 100644
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
+		if (!zynq_fpga_has_sync(buf, info->header_size)) {
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


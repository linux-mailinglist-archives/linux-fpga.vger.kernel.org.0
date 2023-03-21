Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AAB56C35C8
	for <lists+linux-fpga@lfdr.de>; Tue, 21 Mar 2023 16:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbjCUPdn (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 21 Mar 2023 11:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbjCUPdn (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 21 Mar 2023 11:33:43 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FECE1B57E;
        Tue, 21 Mar 2023 08:33:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ez4sVw5QZJVWFt/Lkc3WrUIWjeEu3U4WBZM8pbacuQReXDZl0XhUGw+FmWy55TLv4g+UbotWJ/p4x8XXF2CoYgjHDxQxx08JjY8iLAd1gzNUq5mKHVpTVVGNLQQReM/WrKxVjCTb8AZvE1pn51+sYzB4HqNwrOWbrL70DztrLqddNTGkfWv7Anu+AE/IrOvTRAQB6frKv/cif3GX4NTkNbLVVUpGAnGJLccxuWda8ndW78hoF+mMi6e593iO4g1/KXx5dUoVN7arT3DBdZ8wcyTjG2oZWK6Tef+64BG/h0/7cdbqI/+RqQFL7wIg+yyiajodAdEnWPZoZki/5DuBVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DOjan4i38dWPg5PkKOBvj2iXDWkLQeEIGXG301DH8dk=;
 b=jBsPW0i87lksZM6ulEdHnGHM1hF2PNWCQn2n77vwsG1hSdsr9DJwaqToGONYhAAGVjTO9TwUzUx9ci5tw25hh5UowsO458KJ5uuftIXda3jo/4nRq+9xuubt6n3XHFmwxxa/uKaBkpHIEZ1ugWLlGDiE+fAFMMEbUTazW8hJlJbQjXyyt4nEiwcWiq49K/siv/UxmkBWih9IPZHCoHjJ5wPVZYtNt+DYgMizvrdwS5xKaoLgJ5ulDv+lLfAKm0ww4aye9mr20hdkCshh6WZBOHVsq/AcXw7keYJER4+4PczCnU/ruiLReqkHKkt9cm7pA4mzyPE/JkhyxCyhvHo0rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DOjan4i38dWPg5PkKOBvj2iXDWkLQeEIGXG301DH8dk=;
 b=xYhO11OZvZVvD698DreMQuStuLeaSfMZ0obhNJQuAAAsbhKkAOtevwXmIZhPcW3CBI++87Vr7IOAif9IVAxYUAxJuiSKNDO+vHel8Bj+FAgIPFCyT30RCsbhNMMVzBAenu1xHI2hb9m+JOEKEo2/HDrq48UwrkjKKdMjYCntB5w=
Received: from MW4PR03CA0011.namprd03.prod.outlook.com (2603:10b6:303:8f::16)
 by SA1PR12MB8987.namprd12.prod.outlook.com (2603:10b6:806:386::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 15:33:40 +0000
Received: from CO1NAM11FT096.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::90) by MW4PR03CA0011.outlook.office365.com
 (2603:10b6:303:8f::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Tue, 21 Mar 2023 15:33:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT096.mail.protection.outlook.com (10.13.175.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.16 via Frontend Transport; Tue, 21 Mar 2023 15:33:39 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 21 Mar
 2023 10:33:37 -0500
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Moritz Fischer <mdf@kernel.org>, Tom Rix <trix@redhat.com>,
        Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-fpga@vger.kernel.org>
Subject: [PATCH] fpga: xilinx-pr-decoupler: Use readl wrapper instead of pure readl
Date:   Tue, 21 Mar 2023 16:33:23 +0100
Message-ID: <0381e4e8061c2fee182a104768e84feff3a82d25.1679412800.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT096:EE_|SA1PR12MB8987:EE_
X-MS-Office365-Filtering-Correlation-Id: b09906de-a9fb-41d5-c3dd-08db2a21a556
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DdsKw28i7MOvWj/K5KTZWP5HN1ZvnKb5/Beb0FJib2EVH5zF4g+SsoZNNuFkbRbRcwjJBqAlQN5qM9PBkv++oVO78ncwMXtXPB6OD6aO3gBO4D1lJBtNEGS7lDSks93WcJ61MHZyP/Dl3dsD9S4cnuwIra3IrdLkNbt2ItluqZn2RfKt5OQdGIR2JyiXYuS1cfjQMTQuMsmf9biek3GbHKKmZvLVvmBwTxSUOlutiragGxZbO7xrXAwrZQebS0jK6wCSlMtv9UWPQLaFuBB1B6voqMnKvTdqos19zgDy7Eoy/YTOkatQFhgWMfUHxmrGz4t87xQAOsixmzssJM8nZRBuKRXlnH8wYg+jVy7XMnprThVhtqRFNVh8Wt/Qq8/BiCIl3my9WtPOaBfsKZRwUx6YN55kUdo74CD6CUFRsij1Yea+EB4p+5fyjQsGx7Z02aGOeIiNlxFF6jir1DootCPbR56X0V+BGFbx1iojx4LMyutk8FzXEepWmmJ3Ve5xfIJaQ+6YoUTxm74FkvfHoN+FSjSBExFb+0pxBVOBqvUKFJlRkpUF097YSmm5gS1Tgpil4ZBJTZ7s5aKuiEK6TgzmerYyAJOZ5djf+mV4S+2/fAkQbaAKBVf6S6r4XTCYBdhZVI0j3hR2yO2+qiqu1wGOStrFO8h6OSTgw7bjSkmYKaRFwTo4IKvgYvAk9UTIosZCbWnXmUZi5swqZF8GXmxx0R5tWGske2+tC/KDxMWZraqvNgUBcriVLHG7qaEO
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(39860400002)(136003)(396003)(451199018)(46966006)(40470700004)(36840700001)(40460700003)(40480700001)(5660300002)(2616005)(70206006)(8676002)(70586007)(6666004)(54906003)(4744005)(316002)(4326008)(41300700001)(44832011)(36860700001)(8936002)(336012)(26005)(110136005)(47076005)(16526019)(83380400001)(186003)(966005)(426003)(478600001)(82310400005)(86362001)(36756003)(82740400003)(2906002)(356005)(81166007)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 15:33:39.7708
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b09906de-a9fb-41d5-c3dd-08db2a21a556
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT096.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8987
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Driver has IO wrappers but xlnx_pr_decouple_read() is not used and readl is
used instead which is just wrong.
It is also generating sparse issue that xlnx_pr_decouple_read() is unused.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Created based on discussion with Tom here
https://lore.kernel.org/r/20230317230617.1673923-1-trix@redhat.com
---
 drivers/fpga/xilinx-pr-decoupler.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/xilinx-pr-decoupler.c b/drivers/fpga/xilinx-pr-decoupler.c
index 2d9c491f7be9..b76d85449b8f 100644
--- a/drivers/fpga/xilinx-pr-decoupler.c
+++ b/drivers/fpga/xilinx-pr-decoupler.c
@@ -69,7 +69,7 @@ static int xlnx_pr_decoupler_enable_show(struct fpga_bridge *bridge)
 	if (err)
 		return err;
 
-	status = readl(priv->io_base);
+	status = xlnx_pr_decouple_read(priv, CTRL_OFFSET);
 
 	clk_disable(priv->clk);
 
-- 
2.36.1


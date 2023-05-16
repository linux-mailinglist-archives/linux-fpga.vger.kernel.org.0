Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E768704FB9
	for <lists+linux-fpga@lfdr.de>; Tue, 16 May 2023 15:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233157AbjEPNol (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 16 May 2023 09:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232378AbjEPNok (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 16 May 2023 09:44:40 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2058.outbound.protection.outlook.com [40.107.101.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881D3525D;
        Tue, 16 May 2023 06:44:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FHvsaf149tBlhPyu+C/PevQFBW81t36q5+jnLpn1Zs0grgOOj577xHiG+LQl3XqtuS6t7k642fklJKLdxE0vH6rYaUuiQt8Z+5qofv18TF40Dfe3TKebq7STGqqwAp5RqHXquoL5Yg9DFTMAwIvceRwTXLJo5qFK91xw2MN4AeEkI7zXE+wmKn2wnlIoGlmJt+/Zbjduqup1wV3VW0qh0oTiUhwBC5SS8bYK9a0yeqGP9Psw4MFlvxgvDn6bcbtFbHBV3gao4thHeWOpYKDUPXznswPhDH2m+bRAweLtCSkaOfPwLPZuDImx6n63j5vuxd5SUL/ztkF8jy4kYW1vlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6bJa6E6eDgtaMyswwzYiaoMdryfEoowiKttxI4B/Ado=;
 b=FREjGlqITFS6+8kjUnoZc2uanLAQzPFtYYgknGCsVHbWHATZxllFtBBtAUO6RVD3odMezgC7L9I6YEMBpPATLJECQ+sTT7CwJK0y6f5pZJoMkpwC8faF4PbnyQAYTyQQNSzFZQjSXiGvF7TIHsMzGZV9CxeMFIfKiegTNydOWLJHiLKk0Riw1xCTqbpAn6GHlpJz/x46h746vynfgr6MuAn15H2vdcPmEutptVeCO4oE9Y05/NMHQt+9ZuyO6Nn5HSjQ4QtPtb5I7hUkUzY+MnC3Dy3UkUUkl5b2SmklPkID9MFq8Vg5Drdkr6BeQAoWavrHhtcGIwm2WlRQTEPhtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6bJa6E6eDgtaMyswwzYiaoMdryfEoowiKttxI4B/Ado=;
 b=HFoyWRMv+iV4Vjdo/MAm7RkyvBqZJ581d8Ipydtlu7JOLNUdNYWZBXQDb+kHs1/FDYafH/gWw2o1q9glHQ8MA36ECDG5j/xgEbAe4+ktgh6ZBOAANwuo3zsEmmyziK8mORhQrUP0ZJC7Bw6Fz2K7mmUXOrluQb7Mw6D5HuRLwfU=
Received: from MW4PR04CA0379.namprd04.prod.outlook.com (2603:10b6:303:81::24)
 by IA0PR12MB7776.namprd12.prod.outlook.com (2603:10b6:208:430::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.32; Tue, 16 May
 2023 13:44:36 +0000
Received: from CO1NAM11FT103.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::4) by MW4PR04CA0379.outlook.office365.com
 (2603:10b6:303:81::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33 via Frontend
 Transport; Tue, 16 May 2023 13:44:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT103.mail.protection.outlook.com (10.13.174.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.15 via Frontend Transport; Tue, 16 May 2023 13:44:35 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 16 May
 2023 08:44:33 -0500
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Moritz Fischer <mdf@kernel.org>, Tom Rix <trix@redhat.com>,
        Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-fpga@vger.kernel.org>
Subject: [PATCH] fpga: xilinx: Switch Michal Simek's email to new one
Date:   Tue, 16 May 2023 15:44:30 +0200
Message-ID: <32514756730c7412018c26b0bb140647f9e9d414.1684244666.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1403; i=michal.simek@amd.com; h=from:subject:message-id; bh=li8QXRWBfUDOE4dvYAKV4dmIdsh5IWKuIySLSQ26CLs=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhpTkjt0rlKy8ZrAyR605Ma2NV01m7/xZjxd4z1JS+fUgP /DDHNakjlgWBkEmBlkxRRZpmytn9lbOmCJ88bAczBxWJpAhDFycAjARJg+GBS3ZSj/yReyP3zp2 b0/UP4cOgybXNob5oSvvlHoX3exT1SxR+pm4165Q/uphAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT103:EE_|IA0PR12MB7776:EE_
X-MS-Office365-Filtering-Correlation-Id: b53ef5aa-4d28-4c67-1634-08db5613afb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D9lzE1BPuqCzc/Leg7sGf30qrDJAkZeVJ6mRyhSy8D9pwNs6j0F0DDUQ9iUp0TnHWs9h4HsxE44c+RDtb8ZQ9c1qF10x9hC4tGjJuiyGQRUiLxy0VKUw8k5GqjVRPo7A9yiKMpVAPDymGSYhVxHJSajvkefh/41ySIKs/JmGGzPedshQDu0cRihP8YKPEf/KfiaS5NJj33svnSe4A/KU03DLR9Wo5YnCqiIdoE+pHFLs/NzbE43DOWm0P/yM/ddTppdw2ss2Vk6Ez4KNuqdObQYqqf1tj5naaqZWKWUuXoqI87uswlZSI9DrHIsHQPCmXo1wAiXE/insYG8BXQPyWHCu+/euKH9SvOMnVCBWzaOGZ/dClnlg8rWqDHR9+Eoc9L7WfqUuzLFpKVAeGHnyuhtxvR5Wgdqg6M121OY1KesQWTrzFNj2Loq+gI7I8Lw4FoxVtxSZxZIxc1jtwyroQc+xxeBPhCoWV0MkGjfwBlweyLacYIryleA54KnsuJNvwGt07mqTlFFujFbL7XKoG0u7yvCe0zuC1zmRSZ8Iy3uZo14Hx4fyVXLdcmkXReJUcgLIoUqP2wp+iqljLOtC93mcAufFSQRibAWVO9ZE8Sssw4NcEVPQIbqL7Gt73Yzm0sP5iLJ2nNRLt2XBKv72JfD0r3+d7wkKCsT0qm+kaiMvvW0lvHkVoV0dKLc5Ha4Y/H4dGtPHA2IAWWPaiV1TJwB1oVAKWoiQJNNeZslk0GTzbCCj9yDapAppnzZ20wC+Zkgk0eUI3n8Q71Ln7tVh9It95vGnvsn01v83a0I3hAQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(136003)(376002)(451199021)(46966006)(40470700004)(36840700001)(40460700003)(4326008)(478600001)(70586007)(70206006)(316002)(110136005)(54906003)(86362001)(36756003)(83380400001)(336012)(36860700001)(186003)(426003)(16526019)(2616005)(26005)(44832011)(8676002)(8936002)(5660300002)(2906002)(41300700001)(82310400005)(40480700001)(82740400003)(47076005)(81166007)(356005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 13:44:35.3806
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b53ef5aa-4d28-4c67-1634-08db5613afb6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT103.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7776
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

@xilinx.com is still working but better to switch to new amd.com after
AMD/Xilinx acquisition.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 drivers/fpga/xilinx-pr-decoupler.c | 2 +-
 drivers/fpga/zynq-fpga.c           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/fpga/xilinx-pr-decoupler.c b/drivers/fpga/xilinx-pr-decoupler.c
index b76d85449b8f..4d6ef2dd766e 100644
--- a/drivers/fpga/xilinx-pr-decoupler.c
+++ b/drivers/fpga/xilinx-pr-decoupler.c
@@ -184,5 +184,5 @@ module_platform_driver(xlnx_pr_decoupler_driver);
 
 MODULE_DESCRIPTION("Xilinx Partial Reconfiguration Decoupler");
 MODULE_AUTHOR("Moritz Fischer <mdf@kernel.org>");
-MODULE_AUTHOR("Michal Simek <michal.simek@xilinx.com>");
+MODULE_AUTHOR("Michal Simek <michal.simek@amd.com>");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
index ae0da361e6c6..730586b32c10 100644
--- a/drivers/fpga/zynq-fpga.c
+++ b/drivers/fpga/zynq-fpga.c
@@ -656,6 +656,6 @@ static struct platform_driver zynq_fpga_driver = {
 module_platform_driver(zynq_fpga_driver);
 
 MODULE_AUTHOR("Moritz Fischer <moritz.fischer@ettus.com>");
-MODULE_AUTHOR("Michal Simek <michal.simek@xilinx.com>");
+MODULE_AUTHOR("Michal Simek <michal.simek@amd.com>");
 MODULE_DESCRIPTION("Xilinx Zynq FPGA Manager");
 MODULE_LICENSE("GPL v2");
-- 
2.36.1


Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 250456CA2DF
	for <lists+linux-fpga@lfdr.de>; Mon, 27 Mar 2023 13:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjC0LvL (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 27 Mar 2023 07:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231968AbjC0LvK (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 27 Mar 2023 07:51:10 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9501B35AC;
        Mon, 27 Mar 2023 04:51:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e2DSrdCLdZoyk2o8pr6ST43iNHaSQ0cAskaNRjiHiKULU66BrVS8X2GJsxb1A2p1N9bRXALwMD9wFeQXG8X/bKGXcf02qe839pkPO2wbzrStCHQYO/MQWoFaC4nT2HooMiQRF8zT2/0AdGvyJb9u8TnRG44DWJEAH4TD9NILN99PoLehVmVeKN22nggDNL+olOC8uyukCSEbdyXTmb8PdKdSRLk9O5MXp58//C3qSm1vWAU8gf9oJ0wrLn4o7qETfU2zlwH7qcuqGRruPxtVwsy4vNmCOMHhmKm4U9A9mBpdaJDu+k3DIqFpbnA89zhazEGnp/J2obwv+PqmPnzJUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WvgnEEIBRGnDJVkynP5Mqw8pT4uEAJWqsR+0V32vm4I=;
 b=kR81pju2v1uJ74V3unRnK7HrCXtShgeKjbYlAEl8A1rMg0ZoPLOsXjqJUw3DX580/43xIndJWJEN9kQOW1d9crJK84QZP02yemIDtfcCqGjVKAn2z5iS4rMD9xPsq5Y1wzlgIKx24QFYeHY7g/gtrxA6eX9Q8AEwutORlBzrOexWtMyNdcoK1wSO5RHmTmWj5MVQFEbjzbAMB4A/jiiTn90oZkKl72lrp4iZetpEisP8xgWMffqu8bl9xpok+mOogFPsCyWkicExRmUjL+z1O1mp9AoIG0hWlws5BTPDs2uqp5id1n+nv6NtiPeaBpRAAa3H4ygSWxyrRj4QyA3zQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WvgnEEIBRGnDJVkynP5Mqw8pT4uEAJWqsR+0V32vm4I=;
 b=jKolk+h5wQCfKy2xtmAl0JC7IrWQWD795Ytm+Fs4zueSJo4O+RcJHYM29fH/3insdp8VRtIZvZTkOr+5lgLHQ6J1VEWxM/iMgpkAeTVXcE5w8YB31ewPbh7b6dh+N3h3LQKrrRFnpPQZ45rQypMtLwMtcqox75DMKkD0Hsf3I3I=
Received: from MN2PR20CA0054.namprd20.prod.outlook.com (2603:10b6:208:235::23)
 by MN0PR12MB5905.namprd12.prod.outlook.com (2603:10b6:208:379::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Mon, 27 Mar
 2023 11:51:07 +0000
Received: from BL02EPF000108EA.namprd05.prod.outlook.com
 (2603:10b6:208:235:cafe::b9) by MN2PR20CA0054.outlook.office365.com
 (2603:10b6:208:235::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.42 via Frontend
 Transport; Mon, 27 Mar 2023 11:51:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000108EA.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Mon, 27 Mar 2023 11:51:07 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 27 Mar
 2023 06:51:06 -0500
From:   Nava kishore Manne <nava.kishore.manne@amd.com>
To:     <mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>,
        <trix@redhat.com>, <linux-fpga@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] fpga: xilinx-pr-decoupler: select FPGA_BRIDGE for 'Xilinx LogiCORE PR Decoupler'
Date:   Mon, 27 Mar 2023 17:21:03 +0530
Message-ID: <20230327115103.106059-1-nava.kishore.manne@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000108EA:EE_|MN0PR12MB5905:EE_
X-MS-Office365-Filtering-Correlation-Id: be3f73a5-77ec-4901-3ca2-08db2eb98cf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZusHu/uP0n+K2GdA/1UcUpdvTZLEKnqQq50uM2kJlpR/QJ5DFJsjkhFL5KWggvk2gBiWLRT3CUZ4TxwjSnM0CvzI1JKR1qVbPUjaiErVyhxM0S9DCHwc40qpJYKEAGVo5125Ngp5VeWTvuJFDcrPWD8XfKEmvRwtRTMzzwDaW4/nQ5Z4RdqIP3ASh04Lr+IbE0mEWN61X2kUMaEAia6prFl9YtGHBI0RERxtnMOP36SpocItrZDj2GPx0B/NNZALUSGYrIDiDXwumJkpbuZr3BlBhB1E/lnNFmc2s0EP9/S/qXw/TzX9gqjlXuBABrN6BzEQgmz33VArOztdS+wu36vz1CX4X6o9v30v0hMTyTGAYyv3g3agTHOlh8E2zHUO9ZLAz60Cwr/BdPqxPn/ri9aWIfrsA6wtMJnuO93vcUHVAINBLnaKT/LJSBb9GQGXMpJhygFWCtONU1CJVKbbgC2+twj65CVWFxKry+dIZutw3KuU/BTtqcn8NWpCeWTYyAWbsPj4/zYmPs+gSoZbBYUlMt0DGw8XFKQ0KocVnCfZdLaY5L2WBG9qLREWNtW6IlrZSIWUc2xBdBKXnp/DdYUym8acTcV2h/Yjuw41KvAizVsnaYA04pKXVwCouJAzTatOxwwZ/x+krr3rpWOPoRZDy0KFjQ3/YCeTGncXMAtfceqp0ZxfTIKmzarAzQmot/4w82Qp4Hq+HC8bEI3x2+FBUnq5mDf+WoBNGh4OYGE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(136003)(396003)(451199021)(40470700004)(36840700001)(46966006)(70586007)(110136005)(103116003)(5660300002)(70206006)(316002)(8676002)(26005)(81166007)(8936002)(4744005)(2616005)(186003)(41300700001)(478600001)(1076003)(16526019)(336012)(426003)(47076005)(83380400001)(36860700001)(82740400003)(356005)(86362001)(40460700003)(36756003)(82310400005)(40480700001)(6666004)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 11:51:07.1429
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be3f73a5-77ec-4901-3ca2-08db2eb98cf7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000108EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5905
X-Spam-Status: No, score=1.3 required=5.0 tests=AC_FROM_MANY_DOTS,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The Xilinx LogiCORE PR Decoupler depends on the FPGA_BRIDGE always and
hence select it explicitly to make sure that it will be available all
the time when PR decoupler is enabled.

Signed-off-by: Nava kishore Manne <nava.kishore.manne@amd.com>
---
 drivers/fpga/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 0a00763b9f28..71003f256c60 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -115,8 +115,8 @@ config ALTERA_FREEZE_BRIDGE
 
 config XILINX_PR_DECOUPLER
 	tristate "Xilinx LogiCORE PR Decoupler"
-	depends on FPGA_BRIDGE
 	depends on HAS_IOMEM
+	select FPGA_BRIDGE
 	help
 	  Say Y to enable drivers for Xilinx LogiCORE PR Decoupler
 	  or Xilinx Dynamic Function eXchange AIX Shutdown Manager.
-- 
2.25.1


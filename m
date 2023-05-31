Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C02717C97
	for <lists+linux-fpga@lfdr.de>; Wed, 31 May 2023 11:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235764AbjEaJ4k (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 31 May 2023 05:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235587AbjEaJ4i (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 31 May 2023 05:56:38 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2084.outbound.protection.outlook.com [40.107.102.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A48C132;
        Wed, 31 May 2023 02:56:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rho5cfQ978DD3NBwuH5F8kVzo0mnLuA5zVb1bb93r/bWgmNzqdz6plbOS/m15k5Ugd3Jf2Txv7H21D7kYHyz7w6jfYOqK3URYh7vBkDGiwyfTW4CRU6sa22Va/OvfV5zaWQjhSLuCp4wk/jt05IUFHxubKjCNxYXK7TTWQHwYn5bqg1Jp1TMa83COpjf7Lfl4Al60boxclWs4SqlHr2z6/E5+q/872TH/i1S3RsHNJ1fuZ9GAbtIywu0SsttW9Ny4d2bknMi9z3LCDiOm6/5hLZ/pKmpRwhjJuZ86bg/pEenvvWricy1X5VLDH3iwSLM8MWr7UDaQFOJ21xee2Y9hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UBDSnOwHD/6z1qxcjGDdNCgWTAo23doghi/f3sNJJLo=;
 b=LV+31/Q1WdOtJvSpyVGs65oTs6SZAhS1Hjv58o8hGX9wQwqd7PNse6N27+kJgKR74rB/ha/Sgxy6tQQWZIJkSdZ9lb3pz1QQ2Z4+CQswF8DuS28O7Of71qVf6emwbao7/tzZF28eZK+hETZsa1LgEFP+bi/j28ALu/v7yoYttRpTbffdcACXYrmf/+ZVZMfSvnAchQenyZlpsDEVCv0dmaydIjP3lkfxzwFbn88UFr5mrszfZ1Z8e7CmiM8riAkoC65goJOxKbeDm100bWdGcYh+1FjjD3KOGc6R/0JJG89LsuIcGu+h3FqyYZjCoW4Y5Lpfh7xrxTcI4ehxmr/Z7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UBDSnOwHD/6z1qxcjGDdNCgWTAo23doghi/f3sNJJLo=;
 b=PJacP/PokDKH1YVy9HmBgg4rvxwBMDlEHvT8iWK00iNJJz0Q64QRN7miVnEOXkKgexVABJ+GZXIdNUP1zJjycKb5ujSSxbDMMS9NWQ9M2ujmP6gCnpq15qSsC2lg+C2VLcCvknB/Z/KfAsWtFB4yvrmxZomxvTY0HkgKq5vMjdM=
Received: from BN0PR10CA0009.namprd10.prod.outlook.com (2603:10b6:408:143::6)
 by CY5PR12MB6527.namprd12.prod.outlook.com (2603:10b6:930:30::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Wed, 31 May
 2023 09:56:29 +0000
Received: from BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:143:cafe::69) by BN0PR10CA0009.outlook.office365.com
 (2603:10b6:408:143::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22 via Frontend
 Transport; Wed, 31 May 2023 09:56:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT059.mail.protection.outlook.com (10.13.177.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.22 via Frontend Transport; Wed, 31 May 2023 09:56:29 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 31 May
 2023 04:56:27 -0500
From:   Nava kishore Manne <nava.kishore.manne@amd.com>
To:     <mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>,
        <trix@redhat.com>, <michal.simek@amd.com>,
        <linux-fpga@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Alfonso Rodriguez <alfonso.rodriguezm@upm.es>
Subject: [PATCH v2] fpga: zynq-fpga: Ensure proper xCAP interface switch
Date:   Wed, 31 May 2023 15:26:24 +0530
Message-ID: <20230531095624.1802757-1-nava.kishore.manne@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT059:EE_|CY5PR12MB6527:EE_
X-MS-Office365-Filtering-Correlation-Id: 70c81b88-430b-47ac-c9ce-08db61bd4e6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: psmqx7XL4WKQNmoq3KNol+qXDuJvJTLLiO/O9IonS3C6c2R2mVel5H70J7641V+gEb1nHf9CNZGvCxIppUY3IgPrGIBpB714kLWE+e9JGy6Huy3sS62uv7jSjqIawOZMSBGUMADkzQssCz1ufSCIvPhR2gHZt65UwsU5HqETm1eAqPrRxNlJa3jNhGua6vIairLpUIUvLXlgQ6mNIB459RnloN4e4dWOQi/TCRP7z6//iK2ZgD0Hz7C1XRRmykHWs5nzz441unEdvDO6+ztjfsIZpQ/9Tahoj227MArbPPLo9CRFU/JtpGgrzz+/ZqCGaW1hTxrUWDBakFjw9CirvGjCTRVFyBdBDr/wswvBSEkgt5gS6JH5ZQtL49PJi0gxM9Y5lweg7P2Y9QwW8YXtdrj2SY+mHnz1AHFFuJMIckw08qe9Jh7IAUQwCW1SdxAM4ttc6kLxtemN7EQ/BOcx0+8Kp+B5hlYbhynszPFxNk5md5LCqDjtdVh6Qh9bGsD8kxtA+JUxtoUIG8pgPwKbsrhifpy/dPh6RVZOKXrJuy0amwVrrj8zzRWXI5/58aay6DvTFy8C84pBVG3zS8fBTDkmyZA5YWcXqoI0tt/NYtT6HtXlSOmas3sTru8HdtxmcfGMlt7vDphhO4TmQ9VySyP/uoeVf3ID6E3ezzWX+ZU5fCtw0vsswMpGxnWmF+L6RC0tMA/qJmm2ANc4381P4Z3D/7NOfHIt2237BjKlmq1HKhvOz1sALZnejM/BzV00//Ks6OwKjZKFkxPfisXrVAoeYlRtwL4Oqvzx2bueXGM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(39860400002)(396003)(451199021)(46966006)(40470700004)(36840700001)(8936002)(8676002)(5660300002)(110136005)(478600001)(966005)(41300700001)(316002)(6666004)(1076003)(26005)(16526019)(186003)(70206006)(70586007)(4326008)(2616005)(426003)(2906002)(40460700003)(336012)(47076005)(83380400001)(81166007)(356005)(82740400003)(40480700001)(36860700001)(82310400005)(86362001)(103116003)(36756003)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 09:56:29.4988
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70c81b88-430b-47ac-c9ce-08db61bd4e6b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6527
X-Spam-Status: No, score=-0.6 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Alfonso Rodriguez <alfonso.rodriguezm@upm.es>

The Zynq platform has PCAP, ICAP and JTAG interfaces for configuring
programmable logic (PL). The existing driver implementation uses the
PCAP interface to configure the PL. Before switching the PL configuration
interface from PCAP to ICAP make sure that all outstanding Transactions
relevant to the PL configuration should be completed by the PCAP interface
otherwise it may lead to PL configuration issues.

This patch provides a required fix to ensure that all existing PL
transactions are completed before switching from PCAP to ICAP.

For detailed information relevant to PL configuration interfaces refer
Zynq 7000 TRM (section 6.5.1).
Link: https://docs.xilinx.com/v/u/en-US/ug585-Zynq-7000-TRM

Signed-off-by: Alfonso Rodriguez <alfonso.rodriguezm@upm.es>
Signed-off-by: Nava kishore Manne <nava.kishore.manne@amd.com>
---
Changes for v2:
              - Updated commit message and added Doc link as suggested by Yilun.

 drivers/fpga/zynq-fpga.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
index ae0da361e6c6..88db9ac36887 100644
--- a/drivers/fpga/zynq-fpga.c
+++ b/drivers/fpga/zynq-fpga.c
@@ -493,15 +493,16 @@ static int zynq_fpga_ops_write_complete(struct fpga_manager *mgr,
 	if (err)
 		return err;
 
-	/* Release 'PR' control back to the ICAP */
-	zynq_fpga_write(priv, CTRL_OFFSET,
-		zynq_fpga_read(priv, CTRL_OFFSET) & ~CTRL_PCAP_PR_MASK);
-
 	err = zynq_fpga_poll_timeout(priv, INT_STS_OFFSET, intr_status,
 				     intr_status & IXR_PCFG_DONE_MASK,
 				     INIT_POLL_DELAY,
 				     INIT_POLL_TIMEOUT);
 
+	/* Release 'PR' control back to the ICAP */
+	zynq_fpga_write(priv, CTRL_OFFSET,
+			zynq_fpga_read(priv, CTRL_OFFSET)
+			& ~CTRL_PCAP_PR_MASK);
+
 	clk_disable(priv->clk);
 
 	if (err)
-- 
2.25.1


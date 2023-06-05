Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 612367224FC
	for <lists+linux-fpga@lfdr.de>; Mon,  5 Jun 2023 13:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232955AbjFELy5 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 5 Jun 2023 07:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232312AbjFELyn (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 5 Jun 2023 07:54:43 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64EC1A7;
        Mon,  5 Jun 2023 04:54:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kgB+imNbUrwa4vb3M1TvQ5vo8I1JJvMuzatfnjN6JnRfyxV2MKcWmR7tNmyuVj/qU2dKyAM9yWivMdvfmxROeJCRfAqtV/4hFKliu+sWFpFvYLJ3NrQbOqBo+v2hCu5HTFD56qaz9L4F17/2j1x5sQML8jB20fOWRO+CSTOSD1oToHRltM+RvRdroVT4csxcq8ajKrDfxfY/elyOEoZxxguQXz+qOzknIKHJMQlKNGli3lTriMW4AShMllAcmzc65bUVNKScDlsg6IrOUrD/ZX3BPNW5ifv9HXd8Np803qq8L9YQbMyjAPeiGTjywB0yOIdnpA0RIhcRUQcE6dYKCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YrGMBjdJkwVeshHVlAcxK07lRl7eSuPUuPgMMMa6Zvo=;
 b=hs78UsZg/eIiLaCoI935KDq2Ice8S7WObERl+zRM1jR3Zn72BCK20pMUvSVDGtkWw5WF7MQ7wJWAwZbYtUptFbioROFWxwf1QUTgUEuxkBidUMOP2Mx3oB19tns+FEHF/rm6uLGzZ8er5Qs9WbErpshRfZ5Smtt3FcdkIKy+NVF7JDEOtSczwSDW2E7Y+2n9ycWOqynrADIaIHxS3qmJL9Poc0UJWuQRQzHrrnrGU7z8yJDh7m4tOe2ya/erD3Q+Q/MbxUi5xTbx7YwibgrUu9vgIemUYB+wyvBzgF+NMF50XlmWT/IX2QGJ3HefvWFVDwujobgWVotERfpqPnjMDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YrGMBjdJkwVeshHVlAcxK07lRl7eSuPUuPgMMMa6Zvo=;
 b=nS9aAXhlITTPa8QBCtQ44zWtTi7KCqX8zYOj5Dd0SivV+rgnhj+24yHFPt6zJxSuzOQJ5zdU3XG3J9fJg2GCPpBLWmpGQ9alTiPR8C7YMZssbHW4d4IcBy/GjfB/6IwMae/sMYUaRwEoOAIetAkhCUnb4fgzAMUU77TUs7bTQvQ=
Received: from SJ0PR13CA0225.namprd13.prod.outlook.com (2603:10b6:a03:2c1::20)
 by DS0PR12MB7608.namprd12.prod.outlook.com (2603:10b6:8:13b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 11:54:37 +0000
Received: from DM6NAM11FT090.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:2c1:cafe::97) by SJ0PR13CA0225.outlook.office365.com
 (2603:10b6:a03:2c1::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.18 via Frontend
 Transport; Mon, 5 Jun 2023 11:54:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT090.mail.protection.outlook.com (10.13.172.184) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.32 via Frontend Transport; Mon, 5 Jun 2023 11:54:36 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 5 Jun
 2023 06:54:35 -0500
From:   Nava kishore Manne <nava.kishore.manne@amd.com>
To:     <mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>,
        <trix@redhat.com>, <michal.simek@amd.com>,
        <linux-fpga@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Alfonso Rodriguez <alfonso.rodriguezm@upm.es>
Subject: [PATCH v3] fpga: zynq-fpga: Ensure proper xCAP interface switch
Date:   Mon, 5 Jun 2023 17:24:33 +0530
Message-ID: <20230605115433.186087-1-nava.kishore.manne@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT090:EE_|DS0PR12MB7608:EE_
X-MS-Office365-Filtering-Correlation-Id: df60a1da-97ca-48ab-9957-08db65bba2e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uof64TwQCGzLDkCy9DaryiY1Xz+SGHjFzSlz4B8y75Vuh4n0YN1TMo7TsivLsdOgy+fBrE8AF6VCM78cacQ8mMSK7uD54rOIXCouiyWC/VcQDFrQxiMuflJpUZXbRFwAsuvrv1moPD12HBwK/gg452OykA4OOXRpX5rOSdIzWZZVhiuu1AIRluhlMOc64PAhGbZuNwhmCn+jSRn88V8T4rxADP9LUZ+LBCf1zmf4Y7Sk2gzactljvEJ+SMalMSIDJgbrqldoVQ/ZubJ1HfJ8d051fQDAZDI98x2t0TY4RhEnP108ZVgthFGKFrttmLA0N9260e4Xp5zOWVHtzMYYZUw3LNCtSJ1awKA0QI00avZ3n1glU5BJ0nGlkKx77padnmXNGQE5igXD++QmYlmwgHKpiS9bQNTrPjlIceO4Lq81DGj2iBoG6sF47rf2ILKKQWJ7ifnAC3/B4u0AHmvdZrJ8+w+jLelyFHPdaTWpc2J74lDnMIlBqNLJG9tJiBBEEnIN8UPOm1HXY+nKmUDCzPL2JC7nk2WrIkj2glnw0jiL75XrUIV0VgObMyu+uffLh/JSKI1Ya4NNJwUl3ktiQsA0Fhvp//9WRR64rC8fURDhUZWTuE2TAH13y35gQqHqXvHqXPnP+NAjFucveSbnxsuI6IJZlLLQu+BeTacvmXefe+q3h/+lH/8HJmGPBgPltvDADNrYiRB1ClXO6cQw2js6nWX7mM2DX1A8c7o1ynOF2yFn0R+SH7pEYsX/JwVAalFtcA6LnOAcFxpA9Z6YB0LFuGabKov1CS4S6G7xGM4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(376002)(136003)(451199021)(40470700004)(36840700001)(46966006)(16526019)(186003)(336012)(426003)(2616005)(966005)(1076003)(26005)(47076005)(36860700001)(82310400005)(81166007)(356005)(82740400003)(70586007)(36756003)(70206006)(4326008)(478600001)(40460700003)(83380400001)(103116003)(40480700001)(8936002)(8676002)(86362001)(5660300002)(110136005)(316002)(2906002)(41300700001)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 11:54:36.8718
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df60a1da-97ca-48ab-9957-08db65bba2e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT090.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7608
X-Spam-Status: No, score=1.9 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
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
Changes for v3:
              - Fixed some minor code alignment issues.

Changes for v2:
              - Updated commit message and added Doc link as suggested by Yilun.
 
 drivers/fpga/zynq-fpga.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
index ae0da361e6c6..f8214cae9b6e 100644
--- a/drivers/fpga/zynq-fpga.c
+++ b/drivers/fpga/zynq-fpga.c
@@ -493,15 +493,15 @@ static int zynq_fpga_ops_write_complete(struct fpga_manager *mgr,
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
+			zynq_fpga_read(priv, CTRL_OFFSET) & ~CTRL_PCAP_PR_MASK);
+
 	clk_disable(priv->clk);
 
 	if (err)
-- 
2.25.1


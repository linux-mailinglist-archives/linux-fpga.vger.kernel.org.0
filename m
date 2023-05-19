Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C97037094F9
	for <lists+linux-fpga@lfdr.de>; Fri, 19 May 2023 12:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbjESKcz (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 19 May 2023 06:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjESKcy (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 19 May 2023 06:32:54 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5D7E66;
        Fri, 19 May 2023 03:32:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E4CgYiEtWt+RAaT+DEpruhiNPPPIn9lOxpBIZYyh8RqHihNFdPItnuHJd9LFJIHiG1+rwzvZLgU3PUlogB9kCNXVYxmWBm2+8VYs3c3RPGUyvXuySIqjkFYWWaMeqzCvwB5lRZgyBNS88kvFZtsya+u0CV4X3K39RN5tWfPGdZkVnp4oFhBee/c4Dj+NoPjO3Q3/1JjCYQN+Xwuo0xzLbpjXRUTTh0ZUUkPc/BbI08WNoBqOp/TXDco7blhMEDSBRujvEbYk7d8YnUzOfCHyjgUbCiKsH23l3Y06TsPlbHi0wtphgza42FkqfKE13X01bkg38eRPcgWQ7+rKfFmbUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FWQJu2T43YyHtjgCZdIDWouC5oLWu6GppEerJQ4kabU=;
 b=H1pbISKpYU/nd7kt1q6LNM/HESpacUEmMBVnSdpAzu9zczCPR3k0Wv3XfKTPfASx7F2tSLhK2Kasy78zBH62Ylj3LSSZ3I0dQYSobsEvKLzMvz+y3C8w7bfQX7+jzwz9nR9eC/OIGPszo1djbGtC/ae8nWmA0npJcI50PJb9kmcABPnuCjg9EkS4Bq3k14nIaX4i52TCbNDXBT/eb4XyljbsDwTSA+DSbpCrBZfoWngjKay/IXEF2+KBEtpAUARt8McHjLWwwgTGaBAv5zMdQrgt9GWs+1tJJxP2dkmvUa7ZJEvFM5yiVH1Hj7GVwAUrId436l0BQHWcMMBCRL3+WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FWQJu2T43YyHtjgCZdIDWouC5oLWu6GppEerJQ4kabU=;
 b=11eBNdrpV/AolUW542s2swMuQ4cnL946k5+E6apm3nU4DwB21dppgmDSSQ1ObbB7jF9JcCwWT7hZQ4vB2YPm4QTSXOehh2TZlFZNobLeY2/s0dJncjIHgbjHRd54h3rcix6mh/NIx7pj0IIjLrm0mIGh0zqtmJKcJRekmguV5Vk=
Received: from MW4PR04CA0292.namprd04.prod.outlook.com (2603:10b6:303:89::27)
 by SA3PR12MB9177.namprd12.prod.outlook.com (2603:10b6:806:39d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 10:32:50 +0000
Received: from CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89:cafe::81) by MW4PR04CA0292.outlook.office365.com
 (2603:10b6:303:89::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19 via Frontend
 Transport; Fri, 19 May 2023 10:32:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT010.mail.protection.outlook.com (10.13.175.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.21 via Frontend Transport; Fri, 19 May 2023 10:32:49 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 19 May
 2023 05:32:46 -0500
From:   Nava kishore Manne <nava.kishore.manne@amd.com>
To:     <mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>,
        <trix@redhat.com>, <michal.simek@amd.com>,
        <linux-fpga@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Alfonso Rodriguez <alfonso.rodriguezm@upm.es>
Subject: [PATCH] fpga: zynq-fpga: Ensure proper xCAP interface switch
Date:   Fri, 19 May 2023 16:02:32 +0530
Message-ID: <20230519103232.3009096-1-nava.kishore.manne@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT010:EE_|SA3PR12MB9177:EE_
X-MS-Office365-Filtering-Correlation-Id: e7499261-05d0-427c-9275-08db585464ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n08S1QJUpgSJQRBZ7yFuAGBytdjoCqdZ5ap0vt0hySTUf/9LZ2kSR9afzLy4tZMkdBqytx6oaik7yXtqJesJWO3zOPV0JIy/pKuyBb8kRixL83XfD86PGMpZQKx4oViBz1ArGmPgcJgcD5FSOF7ouXGMNf6IAcYpRxBGJXKLJXupY3EN24wdgcizhzhDfZySEQo+zjjwHeHsS2lcqC+TwbFVr8yHykvV4PMqSrVKqI++Bseu7yfT/uPMj/9o4THMeJlJjSMOLwsqrgAuA9tjOLP3w5ATq1SETcnTUbYWj1+9RTOzA/ahx61M0bTSgudp9cfQ1VNNDsVoFBWmw6c1ag6tL/XPR+uu1JthDS86E3IcSfCVBox6wW8PygRsH9oP3pCiCyBc8e1JVecm87op0YK4JfBGI4kBnvk7QNt1BRhY70FyBUK3bI5Dy2y50qgJRHrX8huA8KFlbFjABbixsITUyIRHUXGnh+vWRWxgnGPARCNta/A6UTRq2MU1gyVohVn55Khnkc8cNJ+spD643QJ8DdRUFH4+r5Tfk9NgFO5ns2KTiuqPh2jSbXFyNrHlS6DB8RuQ0l+tVh6yLI984qpuiQmVkdx78BuYDI9Ts6CGGf/BnMUT3YVzZwj49nGfz3m9vONs70aKgkVSLi9mVGcVHk/eDMKlMIM73xdgmLFXkAEs6OCsUv0om45G6fFTKnlFXd6BjqeILlgTCJ2MpWVvdP6bpmTo1RyphQGySmSxb+oKzXnrZxgLe0CqGcyGZrtQ9vF4k7UvdljoPSm+gjwGCYexE2zJnt5uSKdz6ow=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(39860400002)(346002)(451199021)(46966006)(40470700004)(36840700001)(478600001)(316002)(5660300002)(8936002)(8676002)(41300700001)(4326008)(110136005)(2906002)(40460700003)(70206006)(70586007)(36860700001)(36756003)(103116003)(40480700001)(6666004)(16526019)(1076003)(186003)(26005)(82740400003)(86362001)(47076005)(2616005)(356005)(81166007)(336012)(82310400005)(426003)(83380400001)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 10:32:49.1088
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7499261-05d0-427c-9275-08db585464ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9177
X-Spam-Status: No, score=1.9 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Alfonso Rodriguez <alfonso.rodriguezm@upm.es>

Ensure that the low-level fpga-manager driver for Zynq-7000 devices
switches between reconfiguration interfaces as specified in the TRM
(section 6.5.1: "Ensure that all outstanding transactions are completed
before changing interfaces"); device (re)configuration may fail otherwise

Signed-off-by: Alfonso Rodriguez <alfonso.rodriguezm@upm.es>
Tested-by: Nava kishore Manne <nava.kishore.manne@amd.com>
---
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


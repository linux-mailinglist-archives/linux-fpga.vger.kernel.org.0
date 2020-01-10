Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 704DA136772
	for <lists+linux-fpga@lfdr.de>; Fri, 10 Jan 2020 07:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731589AbgAJGcK (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 10 Jan 2020 01:32:10 -0500
Received: from mail-dm6nam11on2053.outbound.protection.outlook.com ([40.107.223.53]:15712
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731537AbgAJGcK (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 10 Jan 2020 01:32:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ab7Co9dMabYAnmvNJSREHKZq3ucKGDaLYRkFlI37PfYBvvuSZBDJ32+KpeNxDbE+U+RSyQ3wWdxgQj226qfyBx+pivKiUVRCniWxjmlfcoZNloFPVzyuhyT6J+GJULF4q/nPtL6zAke3iHFojc6cNNmFoBEcnVW8nerE91YNmWOiMKRtflhb5WHVPnyKWLtrck3tmi6j3pd0lGO6tCGmOuP/qEV9WUiuNKIkcnTl+BpdQsWa6CKpJeoN3E4f9TCenYCQGuWRZl0OUOVCD6Y5VMVOq3UpPQFqfEMNl87646hhc9qcD7vZrsHzoXnGAdIKyb5H85nNLbkToeH6DCVD5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5lSh0Lexav0MT75SWYllPAxUasBVeq6qrtP2qJhM3IU=;
 b=XMudsDh+gy5i07MJKW3JYav48+bJao4rORxFinrZYTtf6NkmuKQEseS5ULO2RGOsQdyhM0eWKFLrJcun5ZOuYFsd2kjMcPNTN2vJmlVAw0aOk0hvKoWDLqJXTdPisLKJt0i2xxtsGgdPOgBc6i4w9urIPafBGr4q9BQ0HXVx6kv3kW1vlDW5CoWmwQwe6puH888mq+Cl066zRtu5JxYr3V/iIzUgRM6UAs+GeP8Spo5gaMPKm3RpeovdQZVftvtiCeAT5bwDL+u9lJf2aWlcm6EK6SoLTKogZkThdY3Bpe+N3QGowCUXn7W41MUeysIcbvyA+6SKqv0RKn57eIh5Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5lSh0Lexav0MT75SWYllPAxUasBVeq6qrtP2qJhM3IU=;
 b=BhLSL8oPOAkAS/pPU5srVSUI42mnN0UlviBP+D7es7OfD/+tOFvayuIO6Xm7J6kYpQo0DGCYi8t9Pdg05wdNOMSO4xgLrn/jgSrwuImaG1ZEP16CGVRLTDG8Po1KjxFyFs+Sutb/egs0fNOiGJ6v0kdp7+8dETSTtxONxpNAaOg=
Received: from BN7PR02CA0015.namprd02.prod.outlook.com (2603:10b6:408:20::28)
 by DM5PR0201MB3448.namprd02.prod.outlook.com (2603:10b6:4:76::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.9; Fri, 10 Jan
 2020 06:32:02 +0000
Received: from SN1NAM02FT031.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::209) by BN7PR02CA0015.outlook.office365.com
 (2603:10b6:408:20::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.10 via Frontend
 Transport; Fri, 10 Jan 2020 06:32:02 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT031.mail.protection.outlook.com (10.152.72.116) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2623.9
 via Frontend Transport; Fri, 10 Jan 2020 06:32:01 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1ipnpx-0004yr-KA; Thu, 09 Jan 2020 22:32:01 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1ipnps-000371-Gl; Thu, 09 Jan 2020 22:31:56 -0800
Received: from [10.140.6.60] (helo=xhdnavam40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1ipnpp-00036R-Qy; Thu, 09 Jan 2020 22:31:54 -0800
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     mdf@kernel.org, michal.simek@xilinx.com,
        linux-fpga@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH] fpga: xilinx-pr-decoupler: Remove clk_get error message for probe defer
Date:   Fri, 10 Jan 2020 12:01:13 +0530
Message-Id: <20200110063113.3064-1-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(376002)(396003)(39860400002)(189003)(199004)(107886003)(1076003)(15650500001)(478600001)(36756003)(26005)(4744005)(7696005)(5660300002)(356004)(4326008)(6666004)(2616005)(8676002)(70206006)(70586007)(426003)(81156014)(186003)(316002)(2906002)(9786002)(336012)(81166006)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR0201MB3448;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12edb634-0bf3-47a3-537d-08d79596cd76
X-MS-TrafficTypeDiagnostic: DM5PR0201MB3448:
X-Microsoft-Antispam-PRVS: <DM5PR0201MB3448481C5AF067DBBA6D58D5C2380@DM5PR0201MB3448.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1091;
X-Forefront-PRVS: 02788FF38E
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e4AxsplylpkBPEKiFIybXSah0sUNSkh2qYdaMDhfRvUDUu2YfWU5nSTFLMQxq7PPRJa+jvY6MRYwpVF7+4xK5To2/MoaJFc15hf6xXEdky1u2+pSr1uR+NDj6duoMrprX2fLCwbKBXrquq4Edei+ULdsHwsQj6g54a5VPlhSfgI97emcpoSbmJj71qN5bVn70Tl8aizXiCWA+MRqSovo4XaEVFlZ46qgj8YYsTjbr595ZCBYGL3XqD2HGrWCR43BnF+kx+Tk7LPNJMRmirMPFWFHlE2+PxYWAXcmxYy+WHaXZzQ/oykHAmAP+deRHqM/bDjmvaTWN8KKRDyHJlzOVLRNATJsDyRdvBNzNmIZex2AAvhBI3SbZ1uR8hmI+FlFdpoBfTVz3tOBv16OxWsLWm943t8I02JVdNXI7SxBy+XtZ1DlrSE69zNQAp7YHLyS
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2020 06:32:01.9810
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12edb634-0bf3-47a3-537d-08d79596cd76
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0201MB3448
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

In probe, the driver checks for devm_clk_get return and print error
message in the failing case. However for -EPROBE_DEFER this message
is confusing so avoid it.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
 drivers/fpga/xilinx-pr-decoupler.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/fpga/xilinx-pr-decoupler.c b/drivers/fpga/xilinx-pr-decoupler.c
index af9b387c56d3..7d69af230567 100644
--- a/drivers/fpga/xilinx-pr-decoupler.c
+++ b/drivers/fpga/xilinx-pr-decoupler.c
@@ -101,7 +101,8 @@ static int xlnx_pr_decoupler_probe(struct platform_device *pdev)
 
 	priv->clk = devm_clk_get(&pdev->dev, "aclk");
 	if (IS_ERR(priv->clk)) {
-		dev_err(&pdev->dev, "input clock not found\n");
+		if (PTR_ERR(priv->clk) != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "input clock not found\n");
 		return PTR_ERR(priv->clk);
 	}
 
-- 
2.18.0


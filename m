Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5334F07BF
	for <lists+linux-fpga@lfdr.de>; Sun,  3 Apr 2022 07:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236197AbiDCFSt (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 3 Apr 2022 01:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiDCFSs (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 3 Apr 2022 01:18:48 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4326A36E03;
        Sat,  2 Apr 2022 22:16:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YTizUN0mVLqqmDXGRU+S81uuE0izu9abJG2axRLOof11SQx3gr+TmwvQ/eY0DVnMMAGf1aAS9FNzQJucDGYGBRCvSTtk24lcXRUsCcSzdmdMH+oFmH7MAEUKc0XXcrBApLJTyFye7lXl3AwkpAFkx4Ewr+Dslj9Ys9EeaKP7bpZBjJrIBp688b2y70ndwI/H8i9OKKOC1m+dG84u6QcVlIGelFhabB6JO/Ugzj2KSLrbpasclpvu42fR+K75iHxvvBA0+AqwoG3YosIdbdZhn1PKKnAF3HThFtXsajst5jE55vVqiztTDwH1HflSqnSVLLRTdl5DnDNTJn75A07XVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SA06ekR20e2oZeTaZX/BKA58rCuMnKu3rjWxe5gFLjQ=;
 b=MmwItFeoP+ZiUXoLLlKlpVEWxxRO/ICAN9EheB4yJZdpt/KSc87R2lCOyQJsry6o8ulfoEjsoo0Fig8aMkyCylKQMLy0AMDRvAOxoWa4eEpbxg0e/jtcIANbNxy7xAq0eNryHj297StC5xpTKI7xBNq/uZDldOBDXlkqnlcXMvKmlWkNVmd4spy0ILGD0DfARoLJwQsmF59zeRtQ4rFB087HIUNu62fr5XDnyuhDjuI9quUp6ANO1b102oD9nCwLGLlvAbY+4e6J1zCqFSnv6uiUxtfkqb0nReCvEkQwDiL/i3kgiTB2pU9dwQbZFApzbzjzEZ3hCUajrTh70qfYTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SA06ekR20e2oZeTaZX/BKA58rCuMnKu3rjWxe5gFLjQ=;
 b=EiZUWII6r8MyeFIwk86zMHtUGefeghWZ0ZqU9EksaCQUfme/a4z52wpux7p3WCz2yjiDilXOLMq9vBys0aUkbOurVKjUvzKETYjorFbWQeAcPfStXEUgGhPLmvmgK/dJ1hMnioh163JvWCt0CUKc92dLepgJFo/p8X1DYTrhozI=
Received: from BN6PR2001CA0022.namprd20.prod.outlook.com
 (2603:10b6:404:b4::32) by SJ0PR02MB7405.namprd02.prod.outlook.com
 (2603:10b6:a03:29f::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.30; Sun, 3 Apr
 2022 05:16:53 +0000
Received: from BN1NAM02FT022.eop-nam02.prod.protection.outlook.com
 (2603:10b6:404:b4:cafe::2c) by BN6PR2001CA0022.outlook.office365.com
 (2603:10b6:404:b4::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.30 via Frontend
 Transport; Sun, 3 Apr 2022 05:16:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT022.mail.protection.outlook.com (10.13.2.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5123.19 via Frontend Transport; Sun, 3 Apr 2022 05:16:53 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Sat, 2 Apr 2022 22:16:52 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Sat, 2 Apr 2022 22:16:52 -0700
Envelope-to: git@xilinx.com,
 mdf@kernel.org,
 hao.wu@intel.com,
 yilun.xu@intel.com,
 trix@redhat.com,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Received: from [10.140.6.60] (port=54274 helo=xhdnavam40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <nava.manne@xilinx.com>)
        id 1nasbb-0007vd-HS; Sat, 02 Apr 2022 22:16:51 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>,
        <trix@redhat.com>, <michal.simek@xilinx.com>,
        <linux-fpga@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <git@xilinx.com>
CC:     Nava kishore Manne <nava.manne@xilinx.com>
Subject: [PATCH v3 1/5] fpga: zynq: Fix incorrect variable type
Date:   Sun, 3 Apr 2022 10:46:37 +0530
Message-ID: <20220403051641.3867610-2-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220403051641.3867610-1-nava.manne@xilinx.com>
References: <20220403051641.3867610-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7943ae3-4f05-4664-fefe-08da15312a54
X-MS-TrafficTypeDiagnostic: SJ0PR02MB7405:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR02MB7405DFDACE365D3904B4B9FDC2E29@SJ0PR02MB7405.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /6jPcWj6U+ZCUMl1JblBbN6gTkaF1zJ5gAX0WBs/Jv/BbF9vwGmOxHcSlGE58H1GeC0Vmol1RZux87fPiVovoTSObMWo5aeood1mNHl46mrGwoSBeWydx9SqewG2vNv1JTaDzOnQGXnRIrHeyfDHXjQGhLBp99uo42t2xYKffQ2aI1kNtFmoZDdVWdIT7YQxV1tApRD37xeN1TNSl/2vkKdSauMdih+evHO8wauC9x9qzFioHTJr/0KKEAl7aoeKZ6gpebTu6c2Ujmlnt/5o/wDzBPf6vROn6X2zj9B8YFyj43z2cWx7XQyO8kXKCGRUew/mgsjovDnBsZFMZ5AY1pobDU88j2XSkk3DB+DwSHArMuLMAkTJOI+CcyMNOPqHCr6QBGeFnXGh7tfQuAwZ+VIo0UJgUsPxb7Atl5x9gemTp8UUDEx7gcgOLR9L5vv/uQ6lj1K7CwhqP14D/eOiY9VA+3xioFl4RueX4k+/pJuyd5s/ZqJLvbqVkY8SeqqGhdO39Q0hzF04wjWkciGsU/OJr6CKJtBHwvNyDlWr33HLa5zBhSLD2tgB57aUeK28uLVGs3LvDAodquVhP0EirrIXuUs4X0s/yc4zyj88xSi7MoMW2hjk1kT9BcYlbKSTJaiCiD+hxZQbtuitrEF8esqbHCPwKTx8QczHly1ZdBUMaMl51MWy/kE3QPkWIUGA82hRLQQq0cBYEIOs5jBEe5yWCpEbDJV8FqMzFrMVvdc=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(36756003)(186003)(26005)(6666004)(7696005)(508600001)(110136005)(70586007)(5660300002)(6636002)(83380400001)(70206006)(8676002)(47076005)(4326008)(8936002)(40460700003)(36860700001)(9786002)(1076003)(426003)(2616005)(107886003)(2906002)(316002)(82310400004)(7636003)(356005)(336012)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2022 05:16:53.2890
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7943ae3-4f05-4664-fefe-08da15312a54
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT022.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7405
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

zynq_fpga_has_sync () API is expecting "u8 *" but the
formal parameter that was passed is of type "const char *".
fixes this issue by changing the buf type to "const char *"

This patch will also update zynq_fpga_has_sync () API description
to align with API functionality.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
Changes for v2:
                -None.
Changes for v3:
               - Changed arg buf type to "const char *" as suggested by Tom.

 drivers/fpga/zynq-fpga.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
index 426aa34c6a0d..ada07eea64bc 100644
--- a/drivers/fpga/zynq-fpga.c
+++ b/drivers/fpga/zynq-fpga.c
@@ -235,11 +235,11 @@ static irqreturn_t zynq_fpga_isr(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-/* Sanity check the proposed bitstream. It must start with the sync word in
- * the correct byte order, and be dword aligned. The input is a Xilinx .bin
- * file with every 32 bit quantity swapped.
+/* Sanity check the proposed bitstream. The sync word must be found in the
+ * correct byte order and it should be dword aligned. The input is a
+ * Xilinx.bin file with every 32 bit quantity swapped.
  */
-static bool zynq_fpga_has_sync(const u8 *buf, size_t count)
+static bool zynq_fpga_has_sync(const char *buf, size_t count)
 {
 	for (; count >= 4; buf += 4, count -= 4)
 		if (buf[0] == 0x66 && buf[1] == 0x55 && buf[2] == 0x99 &&
-- 
2.25.1


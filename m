Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B918B6CA3FC
	for <lists+linux-fpga@lfdr.de>; Mon, 27 Mar 2023 14:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232653AbjC0MWv (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 27 Mar 2023 08:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232713AbjC0MWc (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 27 Mar 2023 08:22:32 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on20623.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e89::623])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288B85FD5;
        Mon, 27 Mar 2023 05:21:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nlB4pSXYTulqRP/QQKjkc/qh/t2t/KwbTTipiPWpJ40djc+tnMcJCCmm4E6ube4+0vnK0YdEyN6yT2I1jp6EMA02cflz1XYnpcn1VgNwFMehOQ6gxBNBRRLeUoEuzi/QWpAybbfKWYs1iHxcA7DK+1ZM35k+jtAwqLr9+Uf3P/4TZepi5Ke4E7mjF0WVjd3zNGglKxMSs80YnNwlCYHya1Z2RgatdQn6orG0kF1mfxyNOb8DgsU6zIRXsj7OvnIxfkKKnDEesdhfP5+SqbwHI+891i99kQtlc1RV7OtWHekzhkcAelY9CqT6uRqCFkEpiZ+TBTpDx4mQuEs85NUbMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/RvoqEsq6LK5XQhi6FAINqm3GjS0WHVVhPcBXQwK1eo=;
 b=HnC3kmbz5/53waEhdbF6EtcLtL/c6o8Jq+XERgB93Ft8H15+u47tCrAMgg9kCBXpHVCiMfmSwl41xF6XCDnq9vvMU+QK18tNcic+PP6IAWZGaIETH31XXClxNv53F7lnSm5mxPRsjVtLSNqfwyKV+NGrWq1BneKGNYPN6jPJ+sUchmk7M3RUa4xKk6D3m8iwf8SNWwvjVfqWvjP40tLfcRBdPrZZwgfpSTe12qWhKpwM396G0Bk/nsWWZ5JZTv1ThjmyWUFLXQJcBDu3DNCiBIw4uHxrAM/gaQ82PFfUtZGbl5suefkkG/fsho0DFX9Zbql+i6n8Eti176CfF4r0MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/RvoqEsq6LK5XQhi6FAINqm3GjS0WHVVhPcBXQwK1eo=;
 b=lmXJZnC//7f1rOe5PjiSRdclSRSJxhJO2DGJPWD+FadPK5dYSQuePkTm2biYhGxmgipgERw7+VZWyU4kY+ozrjmsehvPdzOCfSdu1+GQXoVFWq3uGHzEdMB5YvutFal+EVztvDp3MvGAD1XuSX0irPz1RTSbocEgUcc/xew1eMY=
Received: from MN2PR16CA0056.namprd16.prod.outlook.com (2603:10b6:208:234::25)
 by CY5PR12MB6347.namprd12.prod.outlook.com (2603:10b6:930:20::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 27 Mar
 2023 12:21:02 +0000
Received: from BL02EPF0000C404.namprd05.prod.outlook.com
 (2603:10b6:208:234:cafe::7b) by MN2PR16CA0056.outlook.office365.com
 (2603:10b6:208:234::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.43 via Frontend
 Transport; Mon, 27 Mar 2023 12:21:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000C404.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Mon, 27 Mar 2023 12:21:01 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 27 Mar
 2023 07:20:59 -0500
From:   Nava kishore Manne <nava.kishore.manne@amd.com>
To:     <mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>,
        <trix@redhat.com>, <michal.simek@xilinx.com>,
        <linux-fpga@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3] fpga: zynq: Add parse_header ops support
Date:   Mon, 27 Mar 2023 17:50:57 +0530
Message-ID: <20230327122057.205123-1-nava.kishore.manne@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C404:EE_|CY5PR12MB6347:EE_
X-MS-Office365-Filtering-Correlation-Id: 89e24ef1-bf6e-4935-6f48-08db2ebdba7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: chUClJwsCGg+34cvVUJFwMdOPrGixkOOMj2TwdFLDYSkq3cFWyjhhYRiADjqnXXFTxkq6otFFBDSt/0UEGTLnfG2EvwUHhH1FhIN/2NDWgc6PXdqpZAgYJsYHl/CNSRDOxO2OaGE4puw56PxLP3VALvIfkfNElEodjTzwAPaRsHQCB1C2qAiLDlQE50v0R2Y5wvrc9HeqowTfYGuVOydu9mz8RkjMh5b5jygJ+G117WOg0XWVh32RXKmzBwiAkRgy9pUHwU15vH64FxGBTNsASJE8udBKmu3KzYZawRSWpAj3IK4rYWk7WVq2hD7FtzGTGrugZ+Be/9WRcdOZFtZJaYozor0KvzZifrXjUK5fG7Bm0qq6WN3u8NLLYHd0yIbDsabCOTf0/cZUWgdI+5Esc/Y09a7B04agzzDYHLbrAU/BsPtRsIrv7rqtNm6LusgVKkRhLWHnj8STHI3661RCQvUaa3XqOwSK+MC/otPxpjkmF7zF4CiJEw4nlTEQ9uTFJuUACs5S0L5b/9rPgqO9tlV/w6On8q8KFQ+inOeiwvqSF/hS4T6bYAwzOi09si/l9jQSMI7IytIt3lDOFfnbsLxRNzhgVM9cIA52u+t3fQiWtNAsOUeZq3U5LzLwYrwE4S3j1L6kZxcetIR7R41IBHb3IKNDDDo6zI+1sZX8mCpDPBbQ4MMkPRDVu1YAaaB1jdq0taJVPjv6n96OWH/IMQfCPOkokJlUUsvvaks4TQkF2xximdoNwj5ndN8K5Gx
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(136003)(396003)(451199021)(36840700001)(46966006)(40470700004)(336012)(83380400001)(82310400005)(8936002)(8676002)(426003)(478600001)(47076005)(86362001)(2906002)(26005)(103116003)(81166007)(40460700003)(186003)(16526019)(36756003)(70206006)(2616005)(82740400003)(1076003)(36860700001)(70586007)(40480700001)(356005)(5660300002)(41300700001)(110136005)(316002)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 12:21:01.5133
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89e24ef1-bf6e-4935-6f48-08db2ebdba7e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C404.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6347
X-Spam-Status: No, score=1.3 required=5.0 tests=AC_FROM_MANY_DOTS,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
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

Changes for v3:
              - zynq_fpga_has_sync () API is expecting "u8 *". So type cast
                formal parameter "const char *" to "u8 *".

 drivers/fpga/zynq-fpga.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
index ae0da361e6c6..a6096f0c93fc 100644
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
+		if (!zynq_fpga_has_sync((u8 *)buf, info->header_size)) {
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


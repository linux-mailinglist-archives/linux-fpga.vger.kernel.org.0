Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8C516B8EF3
	for <lists+linux-fpga@lfdr.de>; Tue, 14 Mar 2023 10:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjCNJmg (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 14 Mar 2023 05:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbjCNJmc (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 14 Mar 2023 05:42:32 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78EF93E25;
        Tue, 14 Mar 2023 02:42:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DD5Gm3lwLnBFaIDxlzdnvg/DX80wEnCQujuyr1jpCE3kBUiShMsnIboO1Zsm0JlxCYu3K7636rLJu5X63NwFx40XPMy95tzsayq/dw2FLVyOnw/+s3KMSq/4fX6ZOqjwwb6xxErAx7O5qsCxI429ZYh2fbOlOldWZmW5qLhU/kaNW3C4z3dFPc8rLPaSxwVW5jb/S2LlzqIcignkzXJ+3oTo+2NUjE3t0l4Nlj6ATYzh8kN0YFuHGYKohk1frgkWuOKZrLd0M3mh4X7mbzZRT8HGEmPWflVW0j4WZOxKWSMQm5wnv1gOqTxKVvrIsEHICDv5HE9JPg6AbppLxQ4u6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Z69c7WM4rC1yEaAa+JumfL+MFI2E1NVoMA+og4oSWk=;
 b=MKw9RsE/CO0P+t6M4K7bqNu21bHXrpSP2xD5PKchirgBSBmn6xyTjzy8VLbzxmHKsSoof+ff7v3BxE5kf0QJnKGUrMZdzPlUfebxpZ2q3oTUo+Mw7C4syGI84DUwa4Sy92T8ZAntA4fwXT8wHVYS0wboW4iB7FHFDDY6qbMHvC1JbOWzs6GBzeusQ5Ij1O1HG77EStmFuFv2ICU+zOwG1SRpEoII53uz97BrJPoaW2mwYdi3J5M4IQ9mAzj1Xq+iX2OtlGjqq73iN6nTTZNvcYOIlbSd4S2PKthTxj9ZMdGbTy2+vEHpSX67XsyGDzKRkpsnLmvQkS6xm1jlas2bvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Z69c7WM4rC1yEaAa+JumfL+MFI2E1NVoMA+og4oSWk=;
 b=I/rwCIrRjApZjo4KuLbXhdXNQ81ed6+aOW55iszcY1cEXlXHnsm/ARAFZPh/gLCPa2Kz/LlowllAJvVCQNeGctBQe7ow2DzEIN5qQKuND4SPqhbEf93MIFgduX0EVhe5XDBwSQHHF/jzqZP2+Reqsty5ioMA+EdGYKTGync74Tg=
Received: from DM6PR08CA0056.namprd08.prod.outlook.com (2603:10b6:5:1e0::30)
 by CY8PR12MB8196.namprd12.prod.outlook.com (2603:10b6:930:78::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Tue, 14 Mar
 2023 09:42:25 +0000
Received: from DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1e0:cafe::f9) by DM6PR08CA0056.outlook.office365.com
 (2603:10b6:5:1e0::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26 via Frontend
 Transport; Tue, 14 Mar 2023 09:42:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT025.mail.protection.outlook.com (10.13.172.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.25 via Frontend Transport; Tue, 14 Mar 2023 09:42:25 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 14 Mar
 2023 04:42:24 -0500
From:   Nava kishore Manne <nava.kishore.manne@amd.com>
To:     <mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>,
        <trix@redhat.com>, <michal.simek@xilinx.com>,
        <linux-fpga@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] fpga: zynqmp: Make word align the configuration data
Date:   Tue, 14 Mar 2023 15:12:22 +0530
Message-ID: <20230314094222.66916-1-nava.kishore.manne@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT025:EE_|CY8PR12MB8196:EE_
X-MS-Office365-Filtering-Correlation-Id: 25c6848b-b32d-4f30-4be9-08db24706b1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CaJ0CdzlhFLbMfG8hs2o/qEK3KfZac9/YLUPZX9FDBiI2d8IaWl7w51yeQi5mCbYqW44vjGhYP+sylkw7/v+jS3cTxkhJfqz4bYt4Gzw3TdZTbaujwE4A3ebUim7QiU2KMm3lsWyubmuIJGgxqAXPtwV5MoQx9WOp/RvzGyD0OaBPgSz76DfdcgTviIUJxbiapKtHONQq6YnVTSFHW50edhN2rk2y59lytJnd0fc7kU23ytu6PzI6Wqh5ZXgRdzk6uBwzmJGDGZxS+KjEJacilON11a1ttTjAzXMDSCTRRd3ouW/WhZuq/M0ezTTjVQLGAzZrt3GeyG1dIvtZLl6Hdndqle/R6mikrAmG4MOdm7nJZ9JcQ6PKfH7tysGybjXhKxRN8RRh0qclm4TCu7gfTQZPALK0g5ovMaPzSMg8wZyP1WsMh20vYtTkTOobACZptMz+RhG/NkVxggwCBaJhBh6i49cUKAYZUGayOsTFVqt3ZVfQ8NjYs8XeaGp7mmVjvQEmfRHn1gzV6pzhra1xzuAJ6IbpJJjC7j4qrgP+ZM1HuRxKwS5IHAwrn6i+LOl41kWBsVEMBgvEr4Sd9Y4PWl9Y4wkFhzlnoJEjENUSARquMQ2DV2/PtYwPU/UEXyYhnp0CFywsnoc0+IQut2f1CXrhN+XMw0siCXgDT99gK7HFCaOF+9yczXsL5aA/Og9wUFv4ea3lzvvNQHljEZtrlzJTL51BFLHAAoldWRnh2vFbRA5kNgmetSF3QfQW7g4
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(136003)(39860400002)(346002)(451199018)(36840700001)(46966006)(40470700004)(86362001)(356005)(36756003)(103116003)(36860700001)(82740400003)(81166007)(8936002)(2906002)(41300700001)(5660300002)(40480700001)(40460700003)(82310400005)(2616005)(16526019)(186003)(26005)(1076003)(83380400001)(426003)(336012)(47076005)(316002)(110136005)(8676002)(70586007)(70206006)(478600001)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2023 09:42:25.4360
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25c6848b-b32d-4f30-4be9-08db24706b1e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8196
X-Spam-Status: No, score=-0.6 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

To avoid unwanted copies at firmware(PMUFW) this patch provides a fix
to align programmable logic(PL) configuration data if the data is not
word-aligned. To align the configuration data this patch adds a few
padding bytes and these additional padding bytes will not create any
functional impact on the PL configuration.

Signed-off-by: Nava kishore Manne <nava.kishore.manne@amd.com>
---
 drivers/fpga/zynqmp-fpga.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/fpga/zynqmp-fpga.c b/drivers/fpga/zynqmp-fpga.c
index c60f20949c47..70a12dc6e15c 100644
--- a/drivers/fpga/zynqmp-fpga.c
+++ b/drivers/fpga/zynqmp-fpga.c
@@ -15,6 +15,9 @@
 /* Constant Definitions */
 #define IXR_FPGA_DONE_MASK	BIT(3)
 
+#define DUMMY_PAD_BYTE		0xFF
+#define FPGA_WORD_SIZE		4
+
 /**
  * struct zynqmp_fpga_priv - Private data structure
  * @dev:	Device data structure
@@ -41,18 +44,26 @@ static int zynqmp_fpga_ops_write(struct fpga_manager *mgr,
 				 const char *buf, size_t size)
 {
 	struct zynqmp_fpga_priv *priv;
+	int word_align, ret, index;
 	dma_addr_t dma_addr;
 	u32 eemi_flags = 0;
 	char *kbuf;
-	int ret;
 
 	priv = mgr->priv;
+	word_align = size % FPGA_WORD_SIZE;
+	if (word_align)
+		word_align = FPGA_WORD_SIZE - word_align;
+
+	size = size + word_align;
 
 	kbuf = dma_alloc_coherent(priv->dev, size, &dma_addr, GFP_KERNEL);
 	if (!kbuf)
 		return -ENOMEM;
 
-	memcpy(kbuf, buf, size);
+	for (index = 0; index < word_align; index++)
+		kbuf[index] = DUMMY_PAD_BYTE;
+
+	memcpy(&kbuf[index], buf, size - index);
 
 	wmb(); /* ensure all writes are done before initiate FW call */
 
-- 
2.25.1


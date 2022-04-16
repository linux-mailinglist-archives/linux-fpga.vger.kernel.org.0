Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 177F45036CD
	for <lists+linux-fpga@lfdr.de>; Sat, 16 Apr 2022 15:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbiDPNkY (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 16 Apr 2022 09:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbiDPNkW (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 16 Apr 2022 09:40:22 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32021D3ACD;
        Sat, 16 Apr 2022 06:37:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VcNbQ2Lqj148Lft/e++PAZ7fSBVLyDhXqCnK7u/iiVACZ6CdwSVHCwHMHCSHdkLVv6JQ8g+jWj/rbQuUY1tOl6xf9chPeq0GwOyPCAUvEWeVBiosoMrDEeYn4uujhYGyv8T+6MvCW3dEYbV3qJYWf5o5VdYzFHynSdXKkDONAFk7BQLCP0sMQrNJl24g/1CsmXOrEwpFw7tyCClvjNArhKtqPru9LeFYQGAKNW9Kg4TNKphfROWORqd3YQ5FK6jA7f5AbEiK6R+/BGpYa6HHRJcSq8cR+AcfyALN3WOekp6MktjieowkGSppnzwGW4M3TUNebPbA5sHsd9WKg+o/XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ppXbW7xlxAO4m3+3JY3uSmnSyhVMzDYpFYUxyAN2Uk=;
 b=WLHA1lVhbqsuFxyWof7t1t8duno0nsmmIedVNiTgNln2y6p2ekcb1fxJRXwgcOKh0C5A00CioPgVJ/k+qxMvVAP0yHieAF5AeTVffSlCA8JdiihBYjHTlyOnJ9+DFFlnOqoMR/Cnj9PNH+4J5t+/AJFKdWVuXevrEYOh5dXGIbrDJQJxVMQjnUpTIJs7Ag2tbLUSxFTcEbSGF/mtY25uZd2yrhASvs/gzcXUyqLgCykVJ61gBDYCtbRbLzxaR9vUa7kkGfc6bdpTxVZZV1390v1W0I3VVRmGX1FyQW5ed/17ulOushIznV151g0L7mfGOzRlUzE6rukTW9nlP2Df6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ppXbW7xlxAO4m3+3JY3uSmnSyhVMzDYpFYUxyAN2Uk=;
 b=E44b9LlCSKhxbYX/K5LdXkgCeA6fCkiTMTp+NIOOs6OBTzkWZFh5n3rfJSuwL5qeTKmpIUWRxvImEgJeCtH4Kqv53+JacrD++VK3B+yKGKRGdmVdvy2Y2BKa53ywPWLV/CsUDdYz5oUUACroP1P1WALcEmH8s/GWMrJkKbfXFDA=
Received: from BN9PR03CA0571.namprd03.prod.outlook.com (2603:10b6:408:10d::6)
 by DM6PR02MB5529.namprd02.prod.outlook.com (2603:10b6:5:30::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Sat, 16 Apr
 2022 13:37:47 +0000
Received: from BN1NAM02FT036.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:10d:cafe::d4) by BN9PR03CA0571.outlook.office365.com
 (2603:10b6:408:10d::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20 via Frontend
 Transport; Sat, 16 Apr 2022 13:37:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT036.mail.protection.outlook.com (10.13.2.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5164.19 via Frontend Transport; Sat, 16 Apr 2022 13:37:47 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Sat, 16 Apr 2022 06:37:37 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Sat, 16 Apr 2022 06:37:37 -0700
Envelope-to: git@xilinx.com,
 mdf@kernel.org,
 hao.wu@intel.com,
 yilun.xu@intel.com,
 trix@redhat.com,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Received: from [10.140.6.60] (port=32988 helo=xhdnavam40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <nava.manne@xilinx.com>)
        id 1nficL-00088I-Bl; Sat, 16 Apr 2022 06:37:37 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>,
        <trix@redhat.com>, <michal.simek@xilinx.com>,
        <linux-fpga@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <git@xilinx.com>
CC:     Nava kishore Manne <nava.manne@xilinx.com>
Subject: [PATCH v4 4/5] fpga: Use tab instead of space indentation
Date:   Sat, 16 Apr 2022 19:07:18 +0530
Message-ID: <20220416133719.3382895-5-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220416133719.3382895-1-nava.manne@xilinx.com>
References: <20220416133719.3382895-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43b76460-f1d9-4190-ab0c-08da1fae4b2c
X-MS-TrafficTypeDiagnostic: DM6PR02MB5529:EE_
X-Microsoft-Antispam-PRVS: <DM6PR02MB55294635CC760CBAF96C722BC2F19@DM6PR02MB5529.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EKkcCRnShDFXAxqp0Eyrgjv1r7QW0I7wRqNFCsG/lsSL5tWp5xc4XvzPcNovJklvGiShjyEipX8cex4HirTQqK2DDTTaDWsU6fUmRqDBOk+PwO/CajNIS6+d4BVNk0vDk0r8bLPFdN3QgoENHZBEPs1rQ9XYoE48N3cCRjBnZztJ4VGm+GcTEaLpC/T7W4EEZ5pLBsKgBltZ9KsVwMjKtFdlb3LO3w0Jh7gSo76lW60ZFNNSRrpDRCM8k4O4EnN/qqJ49kAOQZt7jeWW72UxPCeWCpJyGUFhi/vy2oB8gezWXnQNELjR5oNAin29BqKAlEuLm53a0vVyCd36OrHnwedaNVoaDFPgGX4564CR3P7AZ44zYmautCZ5EI+UgQZzph/bEreslpFldMxWDjjsnR/eJa5h9l2XlB2UVx2SRIfXl1KsQocwH6tSBo6FQorFMRtwqDtpnJVQ5abeIVT2SKLaGPaCt0A86ZXl1YSx3CfHe01q6PBlJGjxhItxrMo+A9OMt8prlt7ghp4hfOooWvfWa3t8K3+QBpH8A0J0CDc/k6/e57KIKJehjmmpEC0lYyaVVEJX3PE6VR28G7qoJ9oXvUPaqJAEHI6tIzKO17ccAewdD0eIINuw/oAJbiZXFhRCpRRp9PosVV/RaI9tM8jwZNAMXrZI/p8YeyZEt7yyNuKfSAUoH3wHdTdk4FVAwx02aEn2Q3gAvCyY3QAZUa8lp1dJRdx8UPH6KZi9Y8Q=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(426003)(8936002)(4326008)(70586007)(508600001)(6636002)(1076003)(70206006)(36756003)(47076005)(336012)(82310400005)(5660300002)(186003)(26005)(40460700003)(2906002)(36860700001)(2616005)(83380400001)(107886003)(110136005)(9786002)(8676002)(6666004)(7696005)(356005)(7636003)(316002)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2022 13:37:47.0929
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43b76460-f1d9-4190-ab0c-08da1fae4b2c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT036.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5529
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

In FPGA Make file has both space and tab indentation to
make them align use tab instead of space indentation.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
Changes for v2:
                -None.
Changes for v3:
                -Updated commit description.
Changes for v4:
                -None.

 drivers/fpga/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
index 0bff783d1b61..5935b3d0abd5 100644
--- a/drivers/fpga/Makefile
+++ b/drivers/fpga/Makefile
@@ -18,9 +18,9 @@ obj-$(CONFIG_FPGA_MGR_TS73XX)		+= ts73xx-fpga.o
 obj-$(CONFIG_FPGA_MGR_XILINX_SPI)	+= xilinx-spi.o
 obj-$(CONFIG_FPGA_MGR_ZYNQ_FPGA)	+= zynq-fpga.o
 obj-$(CONFIG_FPGA_MGR_ZYNQMP_FPGA)	+= zynqmp-fpga.o
-obj-$(CONFIG_FPGA_MGR_VERSAL_FPGA)      += versal-fpga.o
-obj-$(CONFIG_ALTERA_PR_IP_CORE)         += altera-pr-ip-core.o
-obj-$(CONFIG_ALTERA_PR_IP_CORE_PLAT)    += altera-pr-ip-core-plat.o
+obj-$(CONFIG_FPGA_MGR_VERSAL_FPGA)	+= versal-fpga.o
+obj-$(CONFIG_ALTERA_PR_IP_CORE)		+= altera-pr-ip-core.o
+obj-$(CONFIG_ALTERA_PR_IP_CORE_PLAT)	+= altera-pr-ip-core-plat.o
 
 # FPGA Bridge Drivers
 obj-$(CONFIG_FPGA_BRIDGE)		+= fpga-bridge.o
-- 
2.25.1


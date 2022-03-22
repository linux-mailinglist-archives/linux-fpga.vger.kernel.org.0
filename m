Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4BB4E3A8A
	for <lists+linux-fpga@lfdr.de>; Tue, 22 Mar 2022 09:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiCVIZF (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 22 Mar 2022 04:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbiCVIYR (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 22 Mar 2022 04:24:17 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92795F279;
        Tue, 22 Mar 2022 01:22:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HcobbjvSEA2vcjZaksdquSWIZnTWfSEBxWBek5o3jSpKP1/bfu2OdNIDYYfGwUmfo9QLqkGiGmIDDC1Aucmhn6uQifelM8RlnqMI2flvH1NPju5E1xFl7rZq7ZfjiZOcBQgTx4kZb7F+yBHXAZYkTkvcbPADcACA+dHhs50KqXtD7xJG/MXnQBx7Bgz4NOtBs6S2t+7iuvSlyQJp7DN4pkl95py9veTPF6H1/CDfj/Fce8kyBRa/bmhOJX+Xem5JbyETogInIZwLuv7NYcC474xVYiE6WdOjXhpkOAI8FLmAh4ttKRC3J6yLw+XR1ttQfLkobGUGGROX/8sHepFBJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5cKxcuZv9Kbpk1ssnoEuLY8aE3XOpqSbuyZ4SxU3xdU=;
 b=M8mG0n+bhmjkfhgWFu5DKn/JRbs9seFB0HWWReD14/+FxcoduzMQtX7jya5m+eagV86CLpdE0QPExI/JQRQkx37UVO7pk4JO+adOHqTZb0CFraLSJDME3ezXyrqUYPGPhZ475CgSbYpaPwKSa1S3eGLRMLG9kd/XqpAbaj8mPH63VvgPvru+FR9cT1R/jFEzr10tbLoAEXAsNicDiGL+S7MEZI4jJYic/WqiUOxzf25syeqEEp19m1AMCHOXKYsAW8fMFNhylnUYlIrQ/oJ3zy7cNWlEhqTEDG7AtQkDv1zRN3ezNSVsFPlxDV04Mdta7hKh890ovl/ln+fWY55+0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5cKxcuZv9Kbpk1ssnoEuLY8aE3XOpqSbuyZ4SxU3xdU=;
 b=fS4EeQUtkPJ4vKVXp3IK2/NYldOV/ftdWF9nXLc5Lj/takLXsvwKv8Hg0JwPqfsDw7+fBGrJbtSTwplannGSMPF4lL7H9Xh7HD8bLuBpfxajm2VNOMXb4mY94R97iKszmplWukV2HftdW+My21YLNFzmecVGD/4Uxp0e3gL7rqs=
Received: from SN4PR0501CA0112.namprd05.prod.outlook.com
 (2603:10b6:803:42::29) by DM6PR02MB6875.namprd02.prod.outlook.com
 (2603:10b6:5:252::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Tue, 22 Mar
 2022 08:22:46 +0000
Received: from SN1NAM02FT0050.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:42::4) by SN4PR0501CA0112.outlook.office365.com
 (2603:10b6:803:42::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.11 via Frontend
 Transport; Tue, 22 Mar 2022 08:22:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0050.mail.protection.outlook.com (10.97.5.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5081.14 via Frontend Transport; Tue, 22 Mar 2022 08:22:46 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 22 Mar 2022 01:22:31 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 22 Mar 2022 01:22:31 -0700
Envelope-to: git@xilinx.com,
 mdf@kernel.org,
 hao.wu@intel.com,
 yilun.xu@intel.com,
 trix@redhat.com,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Received: from [10.140.6.60] (port=48200 helo=xhdnavam40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <nava.manne@xilinx.com>)
        id 1nWZmg-000Ei2-IL; Tue, 22 Mar 2022 01:22:30 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>,
        <trix@redhat.com>, <michal.simek@xilinx.com>,
        <linux-fpga@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <git@xilinx.com>
CC:     Nava kishore Manne <nava.manne@xilinx.com>
Subject: [PATCH v2 4/5] fpga: Use tab instead of spaces for indentation
Date:   Tue, 22 Mar 2022 13:52:01 +0530
Message-ID: <20220322082202.2007321-5-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220322082202.2007321-1-nava.manne@xilinx.com>
References: <20220322082202.2007321-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc15e0b6-1f72-4b52-b681-08da0bdd24ee
X-MS-TrafficTypeDiagnostic: DM6PR02MB6875:EE_
X-Microsoft-Antispam-PRVS: <DM6PR02MB68752A3C3A52775B575F8B84C2179@DM6PR02MB6875.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YfkFq8uu0RV46Hw1BaykvoEXgylBtyyuimUoeCgMYZSx6lfngONU8+SW/sUsjnUTOQS5Kn/+XTHjBA76KF/FkhkwInaFE5vubQHh09vgLbS52tyJtTIqZzqRW54yz6y5po0ilUAyGBId4glwYbkmvj6/E2XoX77k56WAWcUWQb5WaryekCW8Tu2HhGmMxPmIFl/ymaBPz01ahIHhK9ZoVdS+vHPr0ZBUXg8jtWaEmmc8FJ2hqNQiioLH5ceszBxXMlE7RJ1I2qhYZ2cd3DbYCzp+S0VCZFL/kqNqieW6lmmGQePLughqYYxM9jh6FE0zNtrltEIF6rMMAwKlBd2SpBjD0sgXtff8+tPoV8qvjbwRPJrRp3sK+FNxdlVFojzzPKa8W2KtihoTBjKTI61YZA6xalyXq294vV90F8BNb7YBAYvhqOKQRqkyKbHBDTxRil/HGIRWGoHfbKaKwyFxfRrJ4dlrc/h7+iwkWxH46sbkixqykVmcje5/yjElfY8+MQ31GnHFG+tC3611ihwGj79DApd/LSZvVMS6q88qwGVUgWRKPzvt5GNsUmWaPGCLMVOMRL0wjI0gRldFdTg1fE+PDecXRNDX8ifJdfqax7QxKWoVgKcr+kpqvagwskVZza9xL39TtTxtJ8t1MWuUzTV/nSykeCmrt7V5O7XmyrwhFAlC0CTTYZJGI3i2ggQLzSkSgMSraP27hhOPEY5b0OFaFYPob1UDge4txiTWVsk=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(4744005)(8936002)(356005)(7636003)(36756003)(82310400004)(9786002)(186003)(336012)(5660300002)(107886003)(2906002)(40460700003)(36860700001)(70206006)(426003)(70586007)(83380400001)(47076005)(8676002)(4326008)(316002)(6636002)(2616005)(110136005)(1076003)(508600001)(26005)(6666004)(7696005)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2022 08:22:46.0867
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc15e0b6-1f72-4b52-b681-08da0bdd24ee
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0050.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6875
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Trivial fix.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
Changes for v2:
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


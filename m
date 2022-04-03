Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED844F07C5
	for <lists+linux-fpga@lfdr.de>; Sun,  3 Apr 2022 07:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237197AbiDCFTI (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 3 Apr 2022 01:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236826AbiDCFTH (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 3 Apr 2022 01:19:07 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F3C36E13;
        Sat,  2 Apr 2022 22:17:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AsVRNDjcdhUV/wWFEPrwB++gtGPdPWpyUo1WS0c4h9ZIY3157p1qfJUw24GYFhclnV8GTPhcnesyEkxS5d1F7PMNg78j9/lDZJpm54EHlUq6xDDufo5s3eyW3rG8a1t2PVaJS7E579+RU/XZob5zt8RkM0y3Al4Ib6BYxoDRkZlsJhyrvKI3fSWNwSMRTDFxE+aImad5F/MiYx2U9/xsI3XZysJg4mkvlH0LORSpPhK8ORiQya7yuoS7QFGFP6vuJaywycomivmtq9TMLXX67tpShLymXTW/9S5i3Hcj7Db0dGockMnsBkDJbUAhRK155mfV39Yd5A+etwDxQyPvxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uQ5GYvtegcsURwB8tmcx0w6ob90PJadJRjYGo3P/TaE=;
 b=WL10F5dJOzJuQAehi1RF18wBaKcRZSvJGVp9V1EeCF52RUZV2QzYyfCwMmY2sIYPvj/Itzu3r9AV4AuXQ5u0TwkHuZUDzfr+a775u9RnnHhTUl2WgmneGoEBOcjNV5bRvs4QwdaWrc4+ODAgL/TMOvV6txHLl5QvNKhZO8f5BlptNBuYO6tbCTOs5/tRva4qbmjEvOaY0DYPB3ey/dnlstbcRHHCspsGqE8i4e0jsvCwMP+aViudS3jykt6L/Vg4V2Tv6kxSocN2RDtYxTw2jlND+F+IP1Ejqm7Kr65aC5qgBDjVH2hbtBnyp3+QjK9aL4UhSN/uNYZ+nqloPZ+9qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uQ5GYvtegcsURwB8tmcx0w6ob90PJadJRjYGo3P/TaE=;
 b=qFLy8Sd8OlaTSOEO4judxosaWupBeML2L8RRolXFBgGsCMUVXE0aUuZFXAsDlhH24Xgd+xDuZukG4MVUkQp+jDxzj32gVVJ9j498EScOZhvq1VCDJpep85bt1Bd7kpEkM4OJ7Y9AVFfnFc8fHY9JCAjKhoawSoS7McEMgVLzka4=
Received: from BN9PR03CA0766.namprd03.prod.outlook.com (2603:10b6:408:13a::21)
 by DM8PR02MB8264.namprd02.prod.outlook.com (2603:10b6:8:7::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5123.30; Sun, 3 Apr 2022 05:17:11 +0000
Received: from BN1NAM02FT061.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:13a:cafe::89) by BN9PR03CA0766.outlook.office365.com
 (2603:10b6:408:13a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.30 via Frontend
 Transport; Sun, 3 Apr 2022 05:17:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT061.mail.protection.outlook.com (10.13.3.184) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5123.19 via Frontend Transport; Sun, 3 Apr 2022 05:17:10 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Sat, 2 Apr 2022 22:17:01 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Sat, 2 Apr 2022 22:17:01 -0700
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
        id 1nasbk-0007vd-Gj; Sat, 02 Apr 2022 22:17:00 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>,
        <trix@redhat.com>, <michal.simek@xilinx.com>,
        <linux-fpga@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <git@xilinx.com>
CC:     Nava kishore Manne <nava.manne@xilinx.com>
Subject: [PATCH v3 3/5] fpga: fpga-mgr: Add missing kernel-doc description
Date:   Sun, 3 Apr 2022 10:46:39 +0530
Message-ID: <20220403051641.3867610-4-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220403051641.3867610-1-nava.manne@xilinx.com>
References: <20220403051641.3867610-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 991e3621-c7ca-4162-5154-08da153134d8
X-MS-TrafficTypeDiagnostic: DM8PR02MB8264:EE_
X-Microsoft-Antispam-PRVS: <DM8PR02MB826486EB1183559251FA121FC2E29@DM8PR02MB8264.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M5RdPlbew4iMaBf7L9AJb1HNSPFVzrtlbXE4YftQh9UUUrYzIMPvq7tXVy3szeMbMHCOkyjfdEX6CfBxM+2u3q0WUnTSmz6GZA42ojbcYNjQqhyEOBl88Rww6bNTwD9la3SJA58g54W9pg8m2TFbaN175YmymE0p+MMG8D7H5rJU2C4LJU/F5+HT58FsrtIcjdzLo3X9RotqO36lnw1gOkBJ/rqCpuDqw7pk3pWBALjPqxyj3hct94Inaw1EwMgW8VlMeui62VJ3arVFMLr+BFGSRXngRk8AUFHjuSV9IGjZ2/aVGPwEg4O6cBBjcuKn5ea5Mf1LEEXwbviyOEOKx8SEfABo5QoZ7Ziy0w/k1wEzsu9W8rKuyW2mAjP6TyZqT0EK4LcFO1U+W3XR40ZwxdFKsfvdBRuX42IZKbljrSyjYZIVCr8lvkQRqjPL9433weqrr7nkjf3UH4kMBpP2TTXNwR/RcOulyooXKcQF5OzJjbRrloARXVzrGLtiTl94RA99UJBZ9zwFmuv4TrGyg34t0UhsoSxodN/yp8HAn5i5h1v0zygfyJ2iVOVVCRgtwIiwgeKk2LEiX4IoXPi9O0saxGyNcV3VR5joxe913JZy8+VvJ1E8A1MRSBZISzPnfgTH/jyLfPajJTjIilxYo13Cw6rXq8fviyDuzJ7hQAIsZn4QQQU17vBRlwx2owvXJ3FvjbIFzQAwsqdhYISa/0TpUHF7aB3Mm1zMJbUu0CcRZXEu8D09jmfdEk/6L2MI
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(36756003)(186003)(6666004)(7696005)(26005)(508600001)(110136005)(70206006)(70586007)(83380400001)(6636002)(8676002)(4326008)(47076005)(8936002)(40460700003)(36860700001)(9786002)(426003)(1076003)(2616005)(107886003)(2906002)(316002)(82310400004)(7636003)(5660300002)(356005)(336012)(102446001)(21314003)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2022 05:17:10.9269
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 991e3621-c7ca-4162-5154-08da153134d8
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT061.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR02MB8264
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Fixed the warnings: No description found for return value of 'xxx'

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
Changes for v2:
                -Replaced s/@return:/Return:/
Changes for v3:
               -Updated commit description.

 drivers/fpga/fpga-mgr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index a699cc8e2fa6..0f2b28538f17 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -730,6 +730,8 @@ static void devm_fpga_mgr_unregister(struct device *dev, void *res)
  * @parent:	fpga manager device from pdev
  * @info:	parameters for fpga manager
  *
+ * Return:  fpga manager pointer on success, negative error code otherwise.
+ *
  * This is the devres variant of fpga_mgr_register_full() for which the unregister
  * function will be called automatically when the managing device is detached.
  */
@@ -763,6 +765,8 @@ EXPORT_SYMBOL_GPL(devm_fpga_mgr_register_full);
  * @mops:	pointer to structure of fpga manager ops
  * @priv:	fpga manager private data
  *
+ * Return:  fpga manager pointer on success, negative error code otherwise.
+ *
  * This is the devres variant of fpga_mgr_register() for which the
  * unregister function will be called automatically when the managing
  * device is detached.
-- 
2.25.1


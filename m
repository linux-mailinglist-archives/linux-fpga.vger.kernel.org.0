Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA41509615
	for <lists+linux-fpga@lfdr.de>; Thu, 21 Apr 2022 06:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383385AbiDUEvt (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 21 Apr 2022 00:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384144AbiDUEvN (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 21 Apr 2022 00:51:13 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51DEC12775;
        Wed, 20 Apr 2022 21:48:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YGRxEmJ0oUwhthGRLLVdvB3+DObkKSs83Tnl9USOVY/w5+w3/SI1hAzKWqBS4Jn47rjYSl3AuKGb0LxzMxvOVmJRR7zW0acU2+J+3AVWRouS98p//BiU37WMzLyV97lWWv60IGDzvThXLkWMsLj1W0sKkW+FcgfLfMKPp0M36W8EW5Bo5xMxitHKzS7i3zUhdz+5HDy/WlXoQIhc4uZHqoeJV/Kmb/Zg87x8oRPPuVH36kx961SXotpE5e0oMp2VS0ibWnKZv0gs7qgx0kQcnFXktFdWV/PyWDIxM51aPi7WM/Ae1JmNDS35EGgORClRA/Lw9lnBEaoKGsbxHxAeFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LgrCu266jMQsubVYVEzXTdhKc+k4GI3Rzf7zLOk3OKk=;
 b=baKaxJGuup3kzeUI/xe+Mtkl0RzbttcYMGPe+MRcNBh/ym1j1zEkIdUvpvPCg9WPOv5aLEZzdmCjGdwufhZW/2Nnt8stR2ATp/vUQ9WIKur1iyWFomdt/SbTUonu8dWLeiZJJF8ndoagD6GpHUlWcbP6o2PSyN4FgIOk8o3gIt0wDIxnfohOcP1HmpKhkymRt9vQkGPAb/UCadmXqeAFPfC6tnuNZ/3OJ3Yce9Lh5aZDfJpjiLBeaf8lrT1NCl9cwqGZidwqxCqAskiAahBIulVRfLgAvVgcB68A6SdgoJY4UsXfhzJqPB1NQfUprRiLLaoxXzisEq6L0C+NQyHN8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LgrCu266jMQsubVYVEzXTdhKc+k4GI3Rzf7zLOk3OKk=;
 b=QTDAqFNtR6sY0cPsJWCk90+SfSLKkGX0HbYd9pZ53+JyGNF6nXEbKDh+4Z2R94fzrByX2xqildsoHDa59uJt/Y9fmhh2lfYOtQfZC9Wu49C0B7kwj1yUeNYhrRZosd3QbdQNvctb87xOyYrPYctVZWjy0N1+yE/qo//CiCySS+o=
Received: from BN9PR03CA0663.namprd03.prod.outlook.com (2603:10b6:408:10e::8)
 by MWHPR02MB2494.namprd02.prod.outlook.com (2603:10b6:300:40::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Thu, 21 Apr
 2022 04:48:23 +0000
Received: from BN1NAM02FT018.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:10e:cafe::49) by BN9PR03CA0663.outlook.office365.com
 (2603:10b6:408:10e::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13 via Frontend
 Transport; Thu, 21 Apr 2022 04:48:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT018.mail.protection.outlook.com (10.13.3.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Thu, 21 Apr 2022 04:48:22 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 20 Apr 2022 21:47:59 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 20 Apr 2022 21:47:59 -0700
Envelope-to: git@xilinx.com,
 mdf@kernel.org,
 hao.wu@intel.com,
 yilun.xu@intel.com,
 trix@redhat.com,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Received: from [10.140.6.60] (port=35750 helo=xhdnavam40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <nava.manne@xilinx.com>)
        id 1nhOjX-0002Sb-2M; Wed, 20 Apr 2022 21:47:59 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>,
        <trix@redhat.com>, <michal.simek@xilinx.com>,
        <linux-fpga@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <git@xilinx.com>
CC:     Nava kishore Manne <nava.manne@xilinx.com>
Subject: [PATCH v5 3/5] fpga: fpga-mgr: fix kernel-doc warnings
Date:   Thu, 21 Apr 2022 10:17:42 +0530
Message-ID: <20220421044744.3777983-4-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220421044744.3777983-1-nava.manne@xilinx.com>
References: <20220421044744.3777983-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 25ba1a82-8c04-422b-109b-08da23522a44
X-MS-TrafficTypeDiagnostic: MWHPR02MB2494:EE_
X-Microsoft-Antispam-PRVS: <MWHPR02MB24945B171FF71F9B1C7CA268C2F49@MWHPR02MB2494.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u307XgvxK1HhrLK/4D/royOXWHrgDKtL3PHAyf+Ytk5VOmrHB2DJ/x3MH2zdjQ5QsVVF3zvOyU1+K0MM0oZfFjjlAMCN8gMMNPjmZbHueupK/PG4PdElSXL1wqd5Mb7aXmsVH02fnW2Krak7fOH5ZsOUKrhi0/Cty3x+MmGT19a1j8iTuOBnUAB+BMqHID2FEowdIlLXC9deJczU6UNSe4FcBzw8phaAHlKt3xkmnwdaarM7JHoZ9LYMqnNjL/OiipmZoNZfGbNmWg+AJC4c5oeBmIIyWScthZfswWuhc9sL7sg967sryYdRkbmDuSVlMNA8AbvsRkIzO2ZMbGSKSJBDmMQkZwVOw3dvybDpFT3fcW/U8Gp1UQhS73VyqFgHWrdiD5AVh4jDiIQt7posmT7cgOHhjPUSMuMRWA8EyuW4RbKkiCstctD+HM45UBOHOE85h+DDhOo+nyBgf2AYyUAoCPq+5QXeY1IwLhrjxnMdUE0I7roJSu+FOTjeKyFczfmMNaqpj7w3JRgFU2sCfmB2sX3HWe7JyErGNkYnCV2tN+4tFRj5xk315U7O5w0bf1Bu7t7gAy0e8EvlewOdKIRC8c1dJtanpdHMB4Cy6uFwnPVSg0FEJPaOJKqaqsPLe3BnU2xjXVBbOrz2i2iLkO2KmtCcz4CGG7M4BKl77bs+Lqoca84dPRi//oWKmpCZKcDRdnyFNCutrXfNzOfwAM+erOevysAtfBSwWEyOHFV9klE5gvjQoNBcCq/9puPC
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(70206006)(47076005)(8676002)(70586007)(4326008)(508600001)(83380400001)(336012)(8936002)(2616005)(7696005)(2906002)(40460700003)(9786002)(1076003)(6666004)(26005)(5660300002)(426003)(186003)(356005)(107886003)(110136005)(7636003)(36756003)(316002)(82310400005)(36860700001)(6636002)(102446001)(21314003)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2022 04:48:22.8334
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25ba1a82-8c04-422b-109b-08da23522a44
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT018.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2494
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

warnings: No description found for return value of 'xxx'

In-order to fix the above kernel-doc warnings added the
'Return' description for 'devm_fpga_mgr_register_full()'
and 'devm_fpga_mgr_register()' APIs.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
Acked-by: Xu Yilun <yilun.xu@intel.com>
---
Changes for v2:
               -Replaced s/@return:/Return:/
Changes for v3:
               -Updated commit description.
Changes for v4:
               -Updated commit description.
Changes for v5:
               -Updated commit description.

 drivers/fpga/fpga-mgr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index d9a2aad7b35f..6bd018f20793 100644
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


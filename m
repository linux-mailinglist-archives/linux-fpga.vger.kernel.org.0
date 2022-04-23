Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8E4650CC80
	for <lists+linux-fpga@lfdr.de>; Sat, 23 Apr 2022 19:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236513AbiDWRGK (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 23 Apr 2022 13:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236526AbiDWRGJ (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 23 Apr 2022 13:06:09 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2050.outbound.protection.outlook.com [40.107.100.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17818AFADC;
        Sat, 23 Apr 2022 10:03:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NSyCwVIhgWsKDSKqtWeik13koIv/40luRrcWuGP1bZJx8G/NxLrXnBhscf0uqhnRKYuq4iJeOvmZQs86P4Jt/bTaP8c4QFZggfXIJlNsZPpo5Ft9mCKpIFX/s48HFNw9T0A5GLwNxCr4R6cBE0WZy9BSuxDGY2VP5aFUe6hWzhRHITMHvs74cldr5lw//J8xWaYWvR3d4cYRVKzLYA7BmHDeIul3qoMDo1N9Gns5wfNDsUhDEzb2REBf9tx27Iqxzs+cyyLIUQ1lUSNgD4IAxZDVOb9SHZ68dfCMpv3Zav/Xm4LUtZlp0Joc7qHQZRL0ppmyjUcZnUTZpjU/AQHiVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KXhtSUcSvE+NykUjEighaqvGZMaGzM23ZZIWBFInkXc=;
 b=UZ2zrIg/rUBjuwj/C4TvqE+AeTfjjau1FIn5l+DzXNgjHqodnLgXaqKQBAQbjOpG8wBL8SvSAr3Nul9sfTQXFdQoyAlVaktjuPetf0L+DpCrYONH7vRo/EYdguQGR2cYtMZHrZt/8EBZ3yR63MetWN+sAl9JK4Fhh5kOMLVH5ZDKeBKzy/CqT5zgBPFqDKcoTz1uNgLXO4EuRDmwyFnWW7qwdOfIX0RnObP4q5pJDQMTjKLY3WaUwzR3A2KuxhHL18PwC7Kg4NlQJfL6JGfA2ZHmTgpi7Evt4aUpS0ZLXGVj2r3GUm4qyX8DsQfQXqauu/6LN8q4i7o8STha/OLMAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KXhtSUcSvE+NykUjEighaqvGZMaGzM23ZZIWBFInkXc=;
 b=fuxiihp7BOPOE/FNaE92ba8SgX5N7TvDsvrE+qSlljAONbw1Y4riQbWsDTPGrDpgEUb4LGTj/c5hF+6IIERhFlxWXG6cU7dJCOtYJTsVMobtZW1e/FgzDfakoymIfT5MykF5t8hnB3+X/5ocJc89ReJJBLTF3E/ULNTm+Nn7e1w=
Received: from DS7PR03CA0113.namprd03.prod.outlook.com (2603:10b6:5:3b7::28)
 by BL0PR02MB4802.namprd02.prod.outlook.com (2603:10b6:208:53::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Sat, 23 Apr
 2022 17:03:07 +0000
Received: from DM3NAM02FT020.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:3b7:cafe::a1) by DS7PR03CA0113.outlook.office365.com
 (2603:10b6:5:3b7::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Sat, 23 Apr 2022 17:03:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT020.mail.protection.outlook.com (10.13.4.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Sat, 23 Apr 2022 17:03:06 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Sat, 23 Apr 2022 10:03:02 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Sat, 23 Apr 2022 10:03:02 -0700
Envelope-to: git@xilinx.com,
 mdf@kernel.org,
 hao.wu@intel.com,
 yilun.xu@intel.com,
 trix@redhat.com,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Received: from [10.140.6.60] (port=37114 helo=xhdnavam40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <nava.manne@xilinx.com>)
        id 1niJ9x-000FkB-Pr; Sat, 23 Apr 2022 10:03:02 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>,
        <trix@redhat.com>, <michal.simek@xilinx.com>,
        <linux-fpga@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <git@xilinx.com>
CC:     Nava kishore Manne <nava.manne@xilinx.com>
Subject: [PATCH v6 3/5] fpga: fpga-mgr: fix kernel-doc warnings
Date:   Sat, 23 Apr 2022 22:32:33 +0530
Message-ID: <20220423170235.2115479-4-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220423170235.2115479-1-nava.manne@xilinx.com>
References: <20220423170235.2115479-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc2b9bde-b2d0-43c9-2f61-08da254b2333
X-MS-TrafficTypeDiagnostic: BL0PR02MB4802:EE_
X-Microsoft-Antispam-PRVS: <BL0PR02MB48027CAA55D8C61AB479F9F2C2F69@BL0PR02MB4802.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6fLgtGIVJq4lp3W9AF+s7sgThGQqkQgSqqd7GDTZ49ZGVM3DTIsc3FscU6hJIH/nhSwj/nrIawlX5OJbOhzooo7EiEMUW1i+Fw/8NFUdlUa7S2U2/LjgSF0hwOIuAd2VQ8TtYq3RRlg83+pObX9oUVE+ENbOmKf/RD/n1xWoZN3Rlf0jgRt7F1POk+zkBOnihM4AJaRKbVhwPePT7npo7oq0i6DxypZH7rvOoA7t12PFjYZODMXqjLNHSyyuA+a0x0nVP/2MoXVoJMj0WgdLpuDWgSF92WAfb+9ezrfC6SHTRzuGDdnz8ivjYplzVuudGx2RBd/V/3HcBhCnAcS0Guze4VcexY3tVK4PN/wj8Ov37cb2rsLPXv1R3/6f3t8a4Qx5b5ORy9L4ZjRyyz9NLs3JQDEsWb3G7b2Od9eQNlmETfK+xEaG3F6vGp/ngPU9fHfK+fbUJCBDVfEld1ewImkpNhrnZEdaEZKk6bwIeMNSlZ0z8ATzVIu0gygECRGm4uwwNZbDj1uW3P3hMvx5R/nbqiIaxzpfbYnhE0PVEiREa1bPeis7HCQ0Hu6NdQJ+dOOQIRMmQWYm4UFrIojN0S9HtXIy74qnNaLk704vpn0nu76cIwKz29gHS+4Z85AcWl1oZstBDwWWbaGgTdg5JmzrDvkn31eq0Mbjm9wNV8VIi4qak356Ekay+nbsDM+cQMMyojmXahfVkOFkL+pyorPnPjmKa4ag+28KCHaXu6riRYLKyf/iz03qt7JCheIS
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(82310400005)(2616005)(107886003)(7696005)(1076003)(83380400001)(70586007)(70206006)(40460700003)(336012)(426003)(47076005)(8936002)(356005)(9786002)(316002)(110136005)(186003)(508600001)(6636002)(7636003)(26005)(5660300002)(6666004)(4326008)(8676002)(36756003)(2906002)(36860700001)(102446001)(21314003)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2022 17:03:06.8741
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc2b9bde-b2d0-43c9-2f61-08da254b2333
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT020.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4802
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
Changes for v6:
               -None.

 drivers/fpga/fpga-mgr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index 24dee27c7897..a3595ecc3f79 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -731,6 +731,8 @@ static void devm_fpga_mgr_unregister(struct device *dev, void *res)
  * @parent:	fpga manager device from pdev
  * @info:	parameters for fpga manager
  *
+ * Return:  fpga manager pointer on success, negative error code otherwise.
+ *
  * This is the devres variant of fpga_mgr_register_full() for which the unregister
  * function will be called automatically when the managing device is detached.
  */
@@ -764,6 +766,8 @@ EXPORT_SYMBOL_GPL(devm_fpga_mgr_register_full);
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


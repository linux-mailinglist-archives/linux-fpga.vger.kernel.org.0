Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7184E3A81
	for <lists+linux-fpga@lfdr.de>; Tue, 22 Mar 2022 09:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbiCVIYI (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 22 Mar 2022 04:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbiCVIYF (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 22 Mar 2022 04:24:05 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D870D5EDFD;
        Tue, 22 Mar 2022 01:22:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WlcMvblNuScVeOVdTj2cdHNLaCGg8/7dIDzz11bcB4P5UmKsKcjs0dgsKgC325STMFCghLp3aMns4IfiA1qHtk/cRLS/e6u2ur7Gi0RBteEC2nE8Ox/AmPvjWQkTo8NbISZ84Y+nrhdMM6SXvNnB7JYo5JR9JNoeRl4zSVGcLtHnMhRj6RIeCxSPdJ06G/nSSqWLNvPpHIgeFUJ8eWyyETfwqxlilzWOvwnifVeh2qxbI/kMocqg2atpuPtwv6qakYcf9YuSUKov9xZq4rpa4AJMJuFmH8/OJv69JcjGI5rW6ewJAG2cOjDb3NQXuUv0y0Ju7fUIy9/vDXfm2hmCKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k5dHGZ3tGcTrLC5bDDqUenf7BT6GjLlzWb8GppL+1dc=;
 b=UcXuMsbRMRWUHCiHZqCT6FpbGDHcnjgET5cvzcwRxHlC0ra+47rSzp/49nQ5abEvPu+/O8RGk4Ul+QAG7d/0XudGeLnBEzP7qqW1Cywpu1hI1FiAV8zitXbDsUXudnmk5QNRlMve2ZnYS/0P5XR7b8y2oRT46TbNeEbr1ArA8IOgbT0XW3pEGLf77fmrSVvYi67Fx/N1EEeoVXqrhjF7+83DciPuO+/MXnXFadCLrPJBy+TDQJM0/VI8V9rwOA8+T7RFzfc/by/mPtOL2XDVMkKO2LK7L3VuuI/Ur/LPNBvDFQwggCit9UtzhvBzlCtHCRwI8L39XCISVzZ7Hhl9QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k5dHGZ3tGcTrLC5bDDqUenf7BT6GjLlzWb8GppL+1dc=;
 b=C2g+LlR0viTzKA2bl+nGiq5WQH7dh5fNhLNnpLNl3hIL/JgWpPM7PutNVu5V6V77dws1cyDoqQq68o9L4U/AZRoXxCDRfc6fo5xGIisP90aDYQgxVClcLBBFvArXz2tLNJIqFDtoOjuIh3ze6tAPxPWw/366mtycMC2kgasud5M=
Received: from SA9PR13CA0079.namprd13.prod.outlook.com (2603:10b6:806:23::24)
 by BYAPR02MB4070.namprd02.prod.outlook.com (2603:10b6:a02:fa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Tue, 22 Mar
 2022 08:22:36 +0000
Received: from SN1NAM02FT0029.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:23:cafe::f9) by SA9PR13CA0079.outlook.office365.com
 (2603:10b6:806:23::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.11 via Frontend
 Transport; Tue, 22 Mar 2022 08:22:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0029.mail.protection.outlook.com (10.97.4.175) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5081.14 via Frontend Transport; Tue, 22 Mar 2022 08:22:36 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 22 Mar 2022 01:22:27 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 22 Mar 2022 01:22:27 -0700
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
        id 1nWZmb-000Ei2-Oh; Tue, 22 Mar 2022 01:22:26 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>,
        <trix@redhat.com>, <michal.simek@xilinx.com>,
        <linux-fpga@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <git@xilinx.com>
CC:     Nava kishore Manne <nava.manne@xilinx.com>
Subject: [PATCH v2 3/5] fpga: fpga-mgr: Add missing kernel-doc description
Date:   Tue, 22 Mar 2022 13:52:00 +0530
Message-ID: <20220322082202.2007321-4-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220322082202.2007321-1-nava.manne@xilinx.com>
References: <20220322082202.2007321-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0c02b2d-1692-44b4-d101-08da0bdd1efd
X-MS-TrafficTypeDiagnostic: BYAPR02MB4070:EE_
X-Microsoft-Antispam-PRVS: <BYAPR02MB407084F95FA16D397425BC0EC2179@BYAPR02MB4070.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BiarAKYGP5x8IxGph/GY+e44D897fBWm4ayKdlEDWnliZTzoAHhfjlpYHmGRKuoSHs9AgnTXC20w893I6NgntT52ycFCByC8euSE3GQTq1vZgBzQEqxOoZhN0tFiSVStuu7sNnRrqSSB1bS790cmFKLm6mgp7vZn3K1DqZ+MM6OQTE0EDHSW4FfTixiDzfAg3WWPNNJFMM9B/2OUMZttipKOl6HXt064eaJGr5b5t717+knGz6oCyKnVkxWpHl1hIN4b2dhTEubPYHJMjM60xGfx3F9N42yhRn5JwxVJPwuL8u2lnKwKnICR63n+JzK+w9lCKT+yZRbQKJDAs+qEBU+owVsjy2U+kv2sjYEw5hCFDdf8S2SHOzlJjGDptJHnP5iTaaBS2j0sLiTWqKNcp1NlwONR2+4X1FJrzB5tX4s1nZguP2BKpcXpfy3EoMdso/RE42gdYl1V8gFC6BIBbJ5aPj2KCgftKr7wMjtBehxHc2uieEB4iGZZOWIkDjRhk94G/VHnSFGu2uZ33r10cfNXUIDJlvk4WGrBl6GcUDBxGb6WmNMb9+yvsRYuxvrAMFDTAuNnNlHYIJmJ1OyhLF8xgFD0ir9tz0FIgJZA1Hw0eC87wxLi7wzwyeXpYOKiZCdY+slzUzYfgPT1Ue0SmorkJ3rBu5a6gCbPJWpx/JDPQAoctuasajbPo1rNrRj6vTHY5CrP59pZcQ9qlgfTM2di71nKGLsP+lfWP6dPQvr+B1BEMYTUJGKdA4JWpPd4
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(36860700001)(26005)(2616005)(40460700003)(107886003)(83380400001)(1076003)(7696005)(47076005)(508600001)(186003)(336012)(426003)(6666004)(36756003)(8676002)(70206006)(5660300002)(9786002)(8936002)(110136005)(316002)(4326008)(82310400004)(7636003)(356005)(6636002)(70586007)(2906002)(102446001)(21314003)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2022 08:22:36.0881
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0c02b2d-1692-44b4-d101-08da0bdd1efd
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0029.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4070
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Fixed the warnings: Function parameter or member 'xxx' not
described.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
Changes for v2:
		-Replaced s/@return:/Return:/

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


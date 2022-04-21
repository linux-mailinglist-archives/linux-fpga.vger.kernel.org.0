Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4A9350961A
	for <lists+linux-fpga@lfdr.de>; Thu, 21 Apr 2022 06:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384121AbiDUEuw (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 21 Apr 2022 00:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384123AbiDUEuu (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 21 Apr 2022 00:50:50 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3694EDF65;
        Wed, 20 Apr 2022 21:48:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NHhK7/A7RaSIgGFSFiyENlVZijKr3aO63deYNxTPYjVJLPIDX4RLzhxxZtBWwEOTYytoiPZ/+au1GnOfF1jSK6BW11c2kbOT78bC0BiPfmdAsavixbLrEM1ZB36wfy27vzqpMNIgdMU+kd0R2OLP/2j7S0N5Xn8HX9IJcGIS6TI1SksSZPCDTYUlnhtDUccXQIqzTHgvXPY1GxzdPSmE00oqTodAu8Vi/xQZl/PNzUqF5N2eY91WIGYfjJI6+m1PC6or5+s8CMO+UGw71SC+YifUeEcepF3FkFnsHZHwoPwiPG2JSC0Pkt5kNiP1lcPpBqCiTFyrxqctgyblCXVavw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=56YDIZW1o0MgBlfBVn0+4GJyoxPavJ5PsQ+m93Ej5XU=;
 b=A7NpPe63MBL2GtXrvCdmiOlmmD9sCjAGQZ86sy8M3eUlzONlbf2zuVtXl1EwfbP2cBYPyfv/bWGVO1ELquVMpaGeVU3QKgitC7Jufo04t4vXBzd774DtMvP+o/MdxomjRnWxbSRLNRdhAv4nQeUCKIaCPrO5SHsBmprBjgGJrtrFCte4kIc7KbaaIWVBtbUi/ebny0zk7K5itdlwdSLMh8Zi6gXeXaR4eQi9Tr10djrfLKTkDuLhbHmQ63OPMUg/0+p46zPhcxIqDlCUrFD+PBUiwPdCWtpOiIELCnbpttC9oshRRKVnARFThTEKOnUwu9z2s3K/D8+4QPqkHd1QBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=56YDIZW1o0MgBlfBVn0+4GJyoxPavJ5PsQ+m93Ej5XU=;
 b=rjv582jSUuvZ+Km0+OC28y4AFdd4p3KCHKxVxD8Mu50ovUBlG2agbozLRRohbDI/hInAJoOeOBMY+kvtJBdARUs15NSIFtX5eYiisEw+YgAmhX5un06HeWnXaJDeFKZCtz7myqV3q0wtyOTvgHgZq17WnNDAir82+DtPbnjVLHg=
Received: from BN9PR03CA0439.namprd03.prod.outlook.com (2603:10b6:408:113::24)
 by MW4PR02MB7411.namprd02.prod.outlook.com (2603:10b6:303:7c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Thu, 21 Apr
 2022 04:47:58 +0000
Received: from BN1NAM02FT021.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:113:cafe::5c) by BN9PR03CA0439.outlook.office365.com
 (2603:10b6:408:113::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Thu, 21 Apr 2022 04:47:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT021.mail.protection.outlook.com (10.13.2.73) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Thu, 21 Apr 2022 04:47:57 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 20 Apr 2022 21:47:56 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 20 Apr 2022 21:47:56 -0700
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
        id 1nhOjU-0002Sb-3f; Wed, 20 Apr 2022 21:47:56 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>,
        <trix@redhat.com>, <michal.simek@xilinx.com>,
        <linux-fpga@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <git@xilinx.com>
CC:     Nava kishore Manne <nava.manne@xilinx.com>
Subject: [PATCH v5 2/5] fpga: fix for coding style issues
Date:   Thu, 21 Apr 2022 10:17:41 +0530
Message-ID: <20220421044744.3777983-3-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220421044744.3777983-1-nava.manne@xilinx.com>
References: <20220421044744.3777983-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 33d21f07-e96f-4b74-0096-08da23521b6f
X-MS-TrafficTypeDiagnostic: MW4PR02MB7411:EE_
X-Microsoft-Antispam-PRVS: <MW4PR02MB741177A81F51651CA4325AD5C2F49@MW4PR02MB7411.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JDNnMXZvR/kB1JjhpBwA2cyJTfQ0DcHf6bm2KCTOKAySbSQYXCy0leQ8Ix0z0yW85sjPM+Ut9HloigxDsBwytoVCbO8viTIbdFhCN+n3Q/+WPhaaAhbWhcrKAN7eOSHQXYwJfp5AqLmw1s3HOnO/VmwXRPWqYejn1QiFtnHlS6BOApbTrP0Id9Xrs1iNvg+SPB9O/Zjv67XEGJ2K+b/4u/RCPCz+h++rzyRFLPwKFXrgqZloqoQtW1UgaLP2+FQ7xmoDkeXIxaKd3LjWDl46MOjwi8iDileT/tFiWTHyEhFdS35fpP/h2b9GRRvSjrgYqsuHLY/FvW/3KXOhPYguhmto5RF8MgadWqjfGSpsxRyW0tBgt3vL2UJYHAs6v1xOdJA0PIaZwXoNXNF8UfXkl4hXMOkmMuiN5yKS8RcnLJNuja4Q6X0/2CZyMBU9MTQ9I0WccK2JOTl7zXFQTLlvN/IfN/+oNAueqJF5VI6Uo0xcTseVpyv2b5KFoeOOcvBN4ewvywfTAYPDZDMqiy37/fLtXBiBqJIx30EJNr34UN+g0BMLqNiD1osQFYnpxtRjfyOGt6pWfXQv53cNzn+ddsIIu4fp+WVKRqAAhnyNTJu/rpvLyW7NAjrMpnkM+KZQsjiRbwLGwRpBhJjiOWPcnY/m9yndj5owhL9ya68MTxn2JO9fVO2qN5yzMvbu49AbBsjnPkozJseS2bwu6E9P4UpoBzhIZypmIvTU3eY6xqQ=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(70586007)(82310400005)(6666004)(26005)(7696005)(6636002)(316002)(110136005)(508600001)(7636003)(356005)(70206006)(107886003)(47076005)(40460700003)(2616005)(426003)(336012)(1076003)(186003)(8936002)(9786002)(5660300002)(83380400001)(2906002)(8676002)(4326008)(36860700001)(36756003)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2022 04:47:57.9646
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33d21f07-e96f-4b74-0096-08da23521b6f
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT021.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR02MB7411
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

fixes the below checks reported by checkpatch.pl:
- Lines should not end with a '('
- Alignment should match open parenthesis

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
Acked-by: Xu Yilun <yilun.xu@intel.com>
---
Changes for v2:
                -None.
Changes for v3:
               -Fixed similar issue exists in "drivers/fpga/*".
Changes for v4:
               -None.
Changes for v5:
              - Reduced the length of the 'fpga_mgr_write_init(...)' API
                as suggested by Joe.
              - To align Include declaration and definition of APIs updated
                the FPGA-region.h file as suggested by joe.

 drivers/fpga/fpga-mgr.c          | 4 ++--
 drivers/fpga/fpga-region.c       | 7 ++++---
 drivers/fpga/of-fpga-region.c    | 6 +++---
 include/linux/fpga/fpga-region.h | 7 ++++---
 4 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index d49a9ce34568..d9a2aad7b35f 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -148,11 +148,11 @@ static int fpga_mgr_write_init_buf(struct fpga_manager *mgr,
 	int ret;
 
 	mgr->state = FPGA_MGR_STATE_WRITE_INIT;
+	count = min(mgr->mops->initial_header_size, count);
 	if (!mgr->mops->initial_header_size)
 		ret = fpga_mgr_write_init(mgr, info, NULL, 0);
 	else
-		ret = fpga_mgr_write_init(
-		    mgr, info, buf, min(mgr->mops->initial_header_size, count));
+		ret = fpga_mgr_write_init(mgr, info, buf, count);
 
 	if (ret) {
 		dev_err(&mgr->dev, "Error preparing FPGA for writing\n");
diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
index b0ac18de4885..3864bf4f8920 100644
--- a/drivers/fpga/fpga-region.c
+++ b/drivers/fpga/fpga-region.c
@@ -18,9 +18,10 @@
 static DEFINE_IDA(fpga_region_ida);
 static struct class *fpga_region_class;
 
-struct fpga_region *fpga_region_class_find(
-	struct device *start, const void *data,
-	int (*match)(struct device *, const void *))
+struct fpga_region *fpga_region_class_find(struct device *start,
+					   const void *data,
+					   int (*match)(struct device *,
+							const void *))
 {
 	struct device *dev;
 
diff --git a/drivers/fpga/of-fpga-region.c b/drivers/fpga/of-fpga-region.c
index 50b83057c048..55209737075f 100644
--- a/drivers/fpga/of-fpga-region.c
+++ b/drivers/fpga/of-fpga-region.c
@@ -189,9 +189,9 @@ static int child_regions_with_firmware(struct device_node *overlay)
  *   fpga_image_info struct if there is an image to program.
  *   error code for invalid overlay.
  */
-static struct fpga_image_info *of_fpga_region_parse_ov(
-						struct fpga_region *region,
-						struct device_node *overlay)
+static struct fpga_image_info
+*of_fpga_region_parse_ov(struct fpga_region *region,
+			 struct device_node *overlay)
 {
 	struct device *dev = &region->dev;
 	struct fpga_image_info *info;
diff --git a/include/linux/fpga/fpga-region.h b/include/linux/fpga/fpga-region.h
index 3b87f232425c..7ebf743b8f8a 100644
--- a/include/linux/fpga/fpga-region.h
+++ b/include/linux/fpga/fpga-region.h
@@ -52,9 +52,10 @@ struct fpga_region {
 
 #define to_fpga_region(d) container_of(d, struct fpga_region, dev)
 
-struct fpga_region *fpga_region_class_find(
-	struct device *start, const void *data,
-	int (*match)(struct device *, const void *));
+struct fpga_region *fpga_region_class_find(struct device *start,
+					   const void *data,
+					   int (*match)(struct device *,
+							const void *));
 
 int fpga_region_program_fpga(struct fpga_region *region);
 
-- 
2.25.1


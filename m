Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9CA50CC7F
	for <lists+linux-fpga@lfdr.de>; Sat, 23 Apr 2022 19:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233532AbiDWRGC (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 23 Apr 2022 13:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236515AbiDWRGA (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 23 Apr 2022 13:06:00 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2087.outbound.protection.outlook.com [40.107.101.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4027692D10;
        Sat, 23 Apr 2022 10:03:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=maJ4Wl9Uuy3Qmmw/EFj8XW09VNpUZgUKg7hnvw8Q/qoepwnewcC9II4Dnsb1XAYJqdma2RGESALje5r+D2bPwoiKkAu65FtR/+LEBzK3qHuseN8ByksxYILWSx0BQ2YrndHNhiCoDG66V/S53U2OzGSLZrITsw/asl+B+V39E7g9BxKYr4i5sx2FjmIq9WzYDA0bvjPNKMRSLRHQXKrWghRcmCkYhSFTHbaSGOX85t98FZHrZxylcvpcqsFb3cS/9hIR5nhXLsImg2au9r/tRPQiUKLXV+1Of033DX7b483E0qKU8E9b/5pSJ9aJ8JhoxpYSjxsjceTiGlNuORbNfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pnEo2ORND0+Zy/ZwO7QEpUF1PNGFJBh74/U2HLvrJxY=;
 b=Axrj/gB81M9n8LjehDlXRpL7h3ujVnYsFFgsecaEDSm5FIN8JUS7Nh1PhJFyAT2GG5vmjIR53FN4qmIXP0ocbS1I98fefwIKALVlX/VPJRie4E982sStLQqCMULMPySnEBBE4eFqtQSrdGFZiIVrUqOHhdzMhGnmWyp5KhduvzV66n77MboJTyQ2+RQlTfPsR+39iPUtV8JrBRY3p88qbZ7EqnKa/I5HUe24g8hRLAhTjDLD6ICXiGukAcngOLwsDhcXVlGmKJrU+emw5dX9GZ9Ffre7EihL2KVH4Qwv6KwWq+fXJ3fQd7arKKmiKro2B6SQQAPpSaDzFIRsoNVZsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pnEo2ORND0+Zy/ZwO7QEpUF1PNGFJBh74/U2HLvrJxY=;
 b=PSm4ObV71a8KrXRxYG2KIdSMHICyiosms4ItjSyH93F13RDXaJnYlB783niFcNDyaX3jkKrQvjXmZeAVYCQBEDb78ODH5IEm271mECUuFEV/g73Rr/arsaADM/72QK0HvEHMrWWxhRXdeoQC9nHOID1HkdNuHNRjZvyXzftpJxo=
Received: from DS7PR03CA0253.namprd03.prod.outlook.com (2603:10b6:5:3b3::18)
 by SJ0PR02MB7375.namprd02.prod.outlook.com (2603:10b6:a03:2a1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Sat, 23 Apr
 2022 17:02:59 +0000
Received: from DM3NAM02FT031.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:3b3:cafe::30) by DS7PR03CA0253.outlook.office365.com
 (2603:10b6:5:3b3::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Sat, 23 Apr 2022 17:02:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT031.mail.protection.outlook.com (10.13.4.184) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Sat, 23 Apr 2022 17:02:59 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Sat, 23 Apr 2022 10:02:57 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Sat, 23 Apr 2022 10:02:57 -0700
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
        id 1niJ9s-000FkB-QB; Sat, 23 Apr 2022 10:02:57 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>,
        <trix@redhat.com>, <michal.simek@xilinx.com>,
        <linux-fpga@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <git@xilinx.com>
CC:     Nava kishore Manne <nava.manne@xilinx.com>
Subject: [PATCH v6 2/5] fpga: fix for coding style issues
Date:   Sat, 23 Apr 2022 22:32:32 +0530
Message-ID: <20220423170235.2115479-3-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220423170235.2115479-1-nava.manne@xilinx.com>
References: <20220423170235.2115479-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 931914bd-445e-4000-8756-08da254b1eab
X-MS-TrafficTypeDiagnostic: SJ0PR02MB7375:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR02MB7375692CDFDF2B2A64788B0BC2F69@SJ0PR02MB7375.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0I2bNAEJK0rDjCvKcM5/oZYCjkzOv9sbo8jZMv0XcAwhB6uk087pXTGuKKXJKmd0IFg4vpUu9HxugyWyd/03eMIUle4uFTl6TVQ3XqIoZulZlso7UzdOTHHlNB+O6KPjbFq60h0jjitc0jA6m8oWfyPCcL7tuoKSgpPwlF+TPADWQ3Eo94ODIUwUkeh+EnRJaYU56wlHfN1A7PqXThKAALrPF/pCuktfohainLrfEQ05eApcYENjPvX/mTmFSfITdTR7ehggadelny6+tfss9/M7n3U6fEXqQ4alLDt8L3fJirQ8KvE7vIHvM0v2OldDkEMpZl1XOuyHv90+MlioVHiXL2izgNONLj1+E8N8blvsqVDrqk0wSBOzm2vGK8eGD056l2A5vS1imOFQ07U5UlkJhbk9kmaH5+zd0xgxBGRYEsVcjSjPnuNeBcygQV1QC+09LfgEJdNcC1fC7L96AxNxOtLRHDbQyVWokLVp/5VX3Hbqp/QkiHS0xKKCz4Xfg9qUZU7FCWRktzSqwrOsDl7RhrZqGlQs6p+yFGs+h1qIu1tuJL5ykh/2ZpbAhMp8HS1KCtojF555rpNojL8zEeIrLiEuPdFK9cY4XvgIrDRJqB4++VqFjStfqwrgfdlwwy++dImx1O/Onyrh+l/6OmpnWxvDV+svzvqi4DWeXx7g6lBtyU671/WgcepbcwnSZ1uXpqXwTCnwHWPShZetdIFFIQXBibFKkpxWKAfUzo0=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(9786002)(8936002)(5660300002)(107886003)(7636003)(356005)(1076003)(2616005)(426003)(336012)(40460700003)(6636002)(186003)(110136005)(508600001)(7696005)(6666004)(26005)(47076005)(316002)(36860700001)(8676002)(4326008)(83380400001)(70206006)(70586007)(36756003)(2906002)(82310400005)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2022 17:02:59.2741
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 931914bd-445e-4000-8756-08da254b1eab
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT031.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7375
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
              - Fixed similar issue exists with of_fpga_region_parse_ov() API.

Changes for v6:
              - Align the declaration and definition of APIs as suggested by
                Yilun and Joe.
              - Move the 'count' handling logic into 'else' block as suggested
                by Yilun.

 drivers/fpga/fpga-mgr.c          | 9 +++++----
 drivers/fpga/fpga-region.c       | 6 +++---
 drivers/fpga/of-fpga-region.c    | 6 +++---
 include/linux/fpga/fpga-region.h | 6 +++---
 4 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index d49a9ce34568..24dee27c7897 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -148,11 +148,12 @@ static int fpga_mgr_write_init_buf(struct fpga_manager *mgr,
 	int ret;
 
 	mgr->state = FPGA_MGR_STATE_WRITE_INIT;
-	if (!mgr->mops->initial_header_size)
+	if (!mgr->mops->initial_header_size) {
 		ret = fpga_mgr_write_init(mgr, info, NULL, 0);
-	else
-		ret = fpga_mgr_write_init(
-		    mgr, info, buf, min(mgr->mops->initial_header_size, count));
+	} else {
+		count = min(mgr->mops->initial_header_size, count);
+		ret = fpga_mgr_write_init(mgr, info, buf, count);
+	}
 
 	if (ret) {
 		dev_err(&mgr->dev, "Error preparing FPGA for writing\n");
diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
index b0ac18de4885..485948e3c0db 100644
--- a/drivers/fpga/fpga-region.c
+++ b/drivers/fpga/fpga-region.c
@@ -18,9 +18,9 @@
 static DEFINE_IDA(fpga_region_ida);
 static struct class *fpga_region_class;
 
-struct fpga_region *fpga_region_class_find(
-	struct device *start, const void *data,
-	int (*match)(struct device *, const void *))
+struct fpga_region *
+fpga_region_class_find(struct device *start, const void *data,
+		       int (*match)(struct device *, const void *))
 {
 	struct device *dev;
 
diff --git a/drivers/fpga/of-fpga-region.c b/drivers/fpga/of-fpga-region.c
index 50b83057c048..a598d03626af 100644
--- a/drivers/fpga/of-fpga-region.c
+++ b/drivers/fpga/of-fpga-region.c
@@ -189,9 +189,9 @@ static int child_regions_with_firmware(struct device_node *overlay)
  *   fpga_image_info struct if there is an image to program.
  *   error code for invalid overlay.
  */
-static struct fpga_image_info *of_fpga_region_parse_ov(
-						struct fpga_region *region,
-						struct device_node *overlay)
+static struct fpga_image_info *
+of_fpga_region_parse_ov(struct fpga_region *region,
+			struct device_node *overlay)
 {
 	struct device *dev = &region->dev;
 	struct fpga_image_info *info;
diff --git a/include/linux/fpga/fpga-region.h b/include/linux/fpga/fpga-region.h
index 3b87f232425c..9d4d32909340 100644
--- a/include/linux/fpga/fpga-region.h
+++ b/include/linux/fpga/fpga-region.h
@@ -52,9 +52,9 @@ struct fpga_region {
 
 #define to_fpga_region(d) container_of(d, struct fpga_region, dev)
 
-struct fpga_region *fpga_region_class_find(
-	struct device *start, const void *data,
-	int (*match)(struct device *, const void *));
+struct fpga_region *
+fpga_region_class_find(struct device *start, const void *data,
+		       int (*match)(struct device *, const void *));
 
 int fpga_region_program_fpga(struct fpga_region *region);
 
-- 
2.25.1


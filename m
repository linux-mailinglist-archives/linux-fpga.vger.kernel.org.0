Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6BC650CC82
	for <lists+linux-fpga@lfdr.de>; Sat, 23 Apr 2022 19:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiDWRHL (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 23 Apr 2022 13:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236557AbiDWRGT (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 23 Apr 2022 13:06:19 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3CC5B646A;
        Sat, 23 Apr 2022 10:03:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OlLB250JcMQoc/miyRA25fL7fV/6f/CvOaQ5Y8QYEsXxFmlbpy79sIHm4gs2EKP9ocQwDPXSorqv6ch7BCDotUUenOi03ibAIY/zM7+t19ktUEE6YYDCMx/OTPbUnGKRPkHq1mNDLviqjrKTptsmfEREsuoUGl7KWYN3Kt2Tf3llc5pakBafwT/RswUt11cI42j1wtKyv6FC/kjj/ximI1uzWsekJemf70PuMtoUuVrkcc1INO3qt6THz6LH8V20iU2dU+G+9dWyTEvS2fkZOq7e0st6qkalkn6ggxmyMw4xEihSTT4+IqVY7QIzzRJSKfUgQB95ydNKisLvexZ9GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F22sGPSvn6ZgCBKqPOsRG7jr8EpEybrU0FESyvyYM3g=;
 b=G1xzqS2fd0k3WpBV/ai7HGHBxRrZ0RaZh37pIrE/fwENw46OYSVabPdkk9LD5qFh402rh1+31Kc7IkdAFjXQYTq6geFCpCA07C3vGQmb7ae2eyNRFV6pi4fE9ctJp1MCKlTHSMRhVsxpdJCvqRqjZgjehZBvoDYZXkR/DKD6hDOn2PY7U20+JjkFuTPUgGP737G9wTqWpfvPfBjkFN4LS2xyfhlziC7iHK0igRbUk0hzz41S7WPvaQVHSO1ot9cZm7CiNgv9gX2yfKOaONWtbNwnh/1PVimB1ZsdlwaKnkz8Thw3DaBs+ywX9VRAiVf/h9T0MK8spxw/qsOGTX9ZcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F22sGPSvn6ZgCBKqPOsRG7jr8EpEybrU0FESyvyYM3g=;
 b=Qz5v9vhNMLgbhcc1wiWeLUqW8kSmhDp3e5r5M+q/X7tQZd50QYb95kjgn2NBK07Y9JP2aaQBnEoyTJIoU4GVtlLMLZuVyP4r04zukLQkrmN1+gCV/YyYmlnsQK9TQjmegIsojMY1sOicE8d4SYtO2jyhLxLseNc6ZQOHY3hI8fM=
Received: from DM6PR01CA0021.prod.exchangelabs.com (2603:10b6:5:296::26) by
 MN2PR02MB5951.namprd02.prod.outlook.com (2603:10b6:208:10e::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Sat, 23 Apr
 2022 17:03:16 +0000
Received: from DM3NAM02FT058.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:296:cafe::54) by DM6PR01CA0021.outlook.office365.com
 (2603:10b6:5:296::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Sat, 23 Apr 2022 17:03:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT058.mail.protection.outlook.com (10.13.5.42) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Sat, 23 Apr 2022 17:03:16 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Sat, 23 Apr 2022 10:03:15 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Sat, 23 Apr 2022 10:03:15 -0700
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
        id 1niJA9-000FkB-JS; Sat, 23 Apr 2022 10:03:14 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>,
        <trix@redhat.com>, <michal.simek@xilinx.com>,
        <linux-fpga@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <git@xilinx.com>
CC:     Nava kishore Manne <nava.manne@xilinx.com>
Subject: [PATCH v6 5/5] fpga: fpga-region: fix kernel-doc formatting issues
Date:   Sat, 23 Apr 2022 22:32:35 +0530
Message-ID: <20220423170235.2115479-6-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220423170235.2115479-1-nava.manne@xilinx.com>
References: <20220423170235.2115479-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24b865f0-2bca-43d6-9f3c-08da254b28e3
X-MS-TrafficTypeDiagnostic: MN2PR02MB5951:EE_
X-Microsoft-Antispam-PRVS: <MN2PR02MB59519685EB7EB839FBF083B7C2F69@MN2PR02MB5951.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JZGyOCn4ncapaX5osVWY+IaxQO6fNnBMMmWHX+sx8/jSNj2QLAFCFMmnCPOY6ordSzNn42hzCAAmGQoIi2Cbjsw3/7Nd8MIuGfQ1veeR8uQBzw0R/E/onv7JjtNNoAQWImvqRAO/fA1L6x4taUcSegMCzlVluFF7kCB1h7yADhhV6JizRFqWpXkQFdd3wvSOCCegfbVcwbEZnGaYnxAaoQmoxBlrMFsQfARoE/r9QJ4QCgizxFVBHF2cdYqjUoPDin+wSlVgYQ53jwXPPXH7VMkZd/sRGYAdfcBuXjkX8NPZCI58OSQlMwRLOjNo2G2J1nSU1WzaFS91U6SDLsl82cTbrkXlcj2zQzpyIfFdh1pmObMxKuQF5gpQ0hguaHabnY8uaWC78I4odVig/wyLJ/MO/u+OTIb6p0drpuSSQAsZjT7RGXsPkchaUrvkk1wzEZdvUaS7S5M15uPAtz9lcb2TYt6U6J9n8o/itSSeaGeX7NjAge5wWJU7wFwYYu7ZsohdaLwHGIX6OH6VRWwy1hN/yCy+M391tuxlpm02rzsd7eXQcjYiDmaUN+u44fqLZMksggpassJFoQWB5T5bO/dww6HHLGXPgJGjfgjoyUtWwCsa+IAzWF9HYOtP3D/gYCL+A0qrWixxX1QAZxd/VKqYUYJBxw8wyT4wivbYlQFEXR/Ep9mRT+FwlLBxjyc8aeZerNNtZOpBpsQkAqvKnicLk8gtJGNR4F0fdQYS5HE=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(2906002)(8676002)(4326008)(6666004)(110136005)(9786002)(8936002)(82310400005)(508600001)(186003)(7636003)(356005)(7696005)(316002)(336012)(5660300002)(6636002)(83380400001)(1076003)(426003)(40460700003)(26005)(2616005)(47076005)(70206006)(70586007)(107886003)(36756003)(36860700001)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2022 17:03:16.4190
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24b865f0-2bca-43d6-9f3c-08da254b28e3
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT058.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB5951
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

To fix below kernel-doc warnings this patch does the following
->Replaced Return\Returns with 'Return:' keyword.
->Added 'Return' description For __init of_fpga_region_init()' API.
->Added description for 'child_regions_with_firmware()' API.

warning: No description found for return value of
'of_fpga_region_find'.
warning: No description found for return value of
'of_fpga_region_get_bridges'.
warning: missing initial short description on line:
* child_regions_with_firmware
warning: No description found for return value of
'child_regions_with_firmware'.
warning: No description found for return value of
'of_fpga_region_notify_pre_apply'.
warning: No description found for return value of
'of_fpga_region_notify'.
warning: No description found for return value of
'of_fpga_region_init'.

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
              -None.
Changes for v6:
              -None.

 drivers/fpga/of-fpga-region.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/fpga/of-fpga-region.c b/drivers/fpga/of-fpga-region.c
index a598d03626af..ae82532fc127 100644
--- a/drivers/fpga/of-fpga-region.c
+++ b/drivers/fpga/of-fpga-region.c
@@ -28,7 +28,7 @@ MODULE_DEVICE_TABLE(of, fpga_region_of_match);
  *
  * Caller will need to put_device(&region->dev) when done.
  *
- * Returns FPGA Region struct or NULL
+ * Return: FPGA Region struct or NULL
  */
 static struct fpga_region *of_fpga_region_find(struct device_node *np)
 {
@@ -80,7 +80,7 @@ static struct fpga_manager *of_fpga_region_get_mgr(struct device_node *np)
  * Caller should call fpga_bridges_put(&region->bridge_list) when
  * done with the bridges.
  *
- * Return 0 for success (even if there are no bridges specified)
+ * Return: 0 for success (even if there are no bridges specified)
  * or -EBUSY if any of the bridges are in use.
  */
 static int of_fpga_region_get_bridges(struct fpga_region *region)
@@ -139,13 +139,13 @@ static int of_fpga_region_get_bridges(struct fpga_region *region)
 }
 
 /**
- * child_regions_with_firmware
+ * child_regions_with_firmware - Used to check the child region info.
  * @overlay: device node of the overlay
  *
  * If the overlay adds child FPGA regions, they are not allowed to have
  * firmware-name property.
  *
- * Return 0 for OK or -EINVAL if child FPGA region adds firmware-name.
+ * Return: 0 for OK or -EINVAL if child FPGA region adds firmware-name.
  */
 static int child_regions_with_firmware(struct device_node *overlay)
 {
@@ -184,7 +184,7 @@ static int child_regions_with_firmware(struct device_node *overlay)
  * Given an overlay applied to an FPGA region, parse the FPGA image specific
  * info in the overlay and do some checking.
  *
- * Returns:
+ * Return:
  *   NULL if overlay doesn't direct us to program the FPGA.
  *   fpga_image_info struct if there is an image to program.
  *   error code for invalid overlay.
@@ -279,7 +279,7 @@ of_fpga_region_parse_ov(struct fpga_region *region,
  * If the checks fail, overlay is rejected and does not get added to the
  * live tree.
  *
- * Returns 0 for success or negative error code for failure.
+ * Return: 0 for success or negative error code for failure.
  */
 static int of_fpga_region_notify_pre_apply(struct fpga_region *region,
 					   struct of_overlay_notify_data *nd)
@@ -339,7 +339,7 @@ static void of_fpga_region_notify_post_remove(struct fpga_region *region,
  * This notifier handles programming an FPGA when a "firmware-name" property is
  * added to an fpga-region.
  *
- * Returns NOTIFY_OK or error if FPGA programming fails.
+ * Return: NOTIFY_OK or error if FPGA programming fails.
  */
 static int of_fpga_region_notify(struct notifier_block *nb,
 				 unsigned long action, void *arg)
@@ -446,6 +446,8 @@ static struct platform_driver of_fpga_region_driver = {
 /**
  * of_fpga_region_init - init function for fpga_region class
  * Creates the fpga_region class and registers a reconfig notifier.
+ *
+ * Return: 0 on success, negative error code otherwise.
  */
 static int __init of_fpga_region_init(void)
 {
-- 
2.25.1


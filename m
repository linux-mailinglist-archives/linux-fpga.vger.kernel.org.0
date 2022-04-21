Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7435509617
	for <lists+linux-fpga@lfdr.de>; Thu, 21 Apr 2022 06:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384123AbiDUEvO (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 21 Apr 2022 00:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384141AbiDUEvG (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 21 Apr 2022 00:51:06 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2059.outbound.protection.outlook.com [40.107.95.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43931277F;
        Wed, 20 Apr 2022 21:48:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hejPcYuJB63D9sugL7uq+MOqdUoFpwSNNJGI4dw28a2oy63MYG6DuCzgCvMtpCP02q80qkBdJVyrc2B9+yNB8JHEQsAQ/1nHUDUrRokE/PeJ7B1OG9izYtiEI+/VHrI3w4JJU6yVcWPBjVVOYS6Fmb0aF5D5uQnzkPIgpvE7/+d/7nxhyxipbCrj7yqZA2pTqwPBd5sA7lBai7CIJIjqMhAPsoXUBgIHOrMjk8dbnluilm6K80dW/VqYqxEFA+TJQq579+uAx4qLRQTM9RjIcufo/MtaRMo7lLXHSwQYLnUhRTlSMXeQpuXdJb9eghteDxzIi8Q++Cg1JyanBI433A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Te8RHhwAl+kYv2piiuU9SHbgUVIrEOFFHHhFxIR5XnQ=;
 b=CZffssDt24B7SaFhdpc7Xek6znK6EOwUwV2sc2Q6QgV61YPeZ9Ww4NJRBZ2cIkKY/ugLbO+Z9if7n6HOx+LtnVP9agUCNQpljUibI9fJMCGaKrKFu3eynRKkNG7OiPzCvHREUhIrhCsE54VYqvwoiZIuvKUaLT7VJzO+8kb0wLggtJACJDHrp/SR8BLtvcaF7aAXikbp8ES95ydQFJkMuoj3CX+Bo4BKYYv2lf8jjQ3NCSyAnOCvJhckObPFdhzguJsOD9jlVVJx4BtuQ70/jxUsImDIsVvaQ1/QWcMum+RGdiN5+6mEcDz8ti9vzkJ/NeP42ZNQHGgHv8aRS/x9tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Te8RHhwAl+kYv2piiuU9SHbgUVIrEOFFHHhFxIR5XnQ=;
 b=CKYTp1xhBBFxkBJKRlCTDKSRJmtuZbXLr/8QxsR1g84F6XXJvjY3izqil7zMvgKUvJWg1lu4BnUUjRiPI+0Mojs0y9BxLFoYujFPy4GAtXDmGpTfGo+vJkqyNPFkG0RLFBmCnAUTJoc2NJEM+UXGZxnbnIZ2L/MDmAL+xFyXzMU=
Received: from BN9PR03CA0615.namprd03.prod.outlook.com (2603:10b6:408:106::20)
 by BY5PR02MB6082.namprd02.prod.outlook.com (2603:10b6:a03:1fe::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Thu, 21 Apr
 2022 04:48:13 +0000
Received: from BN1NAM02FT022.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:106:cafe::a9) by BN9PR03CA0615.outlook.office365.com
 (2603:10b6:408:106::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13 via Frontend
 Transport; Thu, 21 Apr 2022 04:48:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT022.mail.protection.outlook.com (10.13.2.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Thu, 21 Apr 2022 04:48:12 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 20 Apr 2022 21:48:05 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 20 Apr 2022 21:48:05 -0700
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
        id 1nhOjc-0002Sb-Ux; Wed, 20 Apr 2022 21:48:05 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>,
        <trix@redhat.com>, <michal.simek@xilinx.com>,
        <linux-fpga@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <git@xilinx.com>
CC:     Nava kishore Manne <nava.manne@xilinx.com>
Subject: [PATCH v5 5/5] fpga: fpga-region: fix kernel-doc formatting issues
Date:   Thu, 21 Apr 2022 10:17:44 +0530
Message-ID: <20220421044744.3777983-6-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220421044744.3777983-1-nava.manne@xilinx.com>
References: <20220421044744.3777983-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 754b2d37-7809-44b0-c7c8-08da23522446
X-MS-TrafficTypeDiagnostic: BY5PR02MB6082:EE_
X-Microsoft-Antispam-PRVS: <BY5PR02MB608248A7F8A8DCD97649BD0CC2F49@BY5PR02MB6082.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oBRx553Aks3I+u2KQ+39+Sf1XTkG0pUitg+AIdAk4CgaxdZG0bwGEHtIMlOnpOUVk7YpoOdkiq6XJRbkbfCyjDag0jxo+8XiKbhOcRaKALbaTt+NnOhC4qrSb5YakN7v9FUM1uNgJalixTELu4uCQ4V8b861bAUWdDK7jtYO/83J22WSEIbji3NYtpPSc8HSfgeQ57X5exNvLsFKWWDp42gsReXElQ1jAnXWTvdkK/65ln2+WZOKMM4PWJXQTWfRz9fVHJxfU3zWas3iMkYvlIf6eeWVd9jqAipTgN67UZivGZ93JS+Igd17iJM3tTXBRefbNr6yAtAznUBsNXQOcbz61Htbn89/OTpX5Gae7YkJxeXzm/F/L6PubvcrvR2OlZmcokhfPG8wF68jXYLodoEAuNNYHkKW1nisfxglv1rHyPMWXjbRuSQvGSt1BMW8wqBA3l6g3pMmP+zp0x2c8Kt8cONLC1dLGRm7mhrapFM7NfLzYMNdDWFMoWbMHL1IacDDJgNp4kYreyaMiVnn7rUCFSCB3XWmt4v84g6lxJ/JVXsCde23Rt8IZyotmolanfh4xjY7H9ATnxbRgjM8k2yi/mfj00/Jm/gZsHMB1p8oqeFVaCoq8ynMBG+WK8gMVNBLcWZxb8CIy9Y4iAnW3wHl71xtsDlXl2apm+3O2APZDonjYOQ7oPZzIAGkadee7buuDzV99bVXIFs99vg2Y4WkIbenJBYLWU6I6v7LjyE=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(5660300002)(508600001)(9786002)(2906002)(8936002)(7636003)(110136005)(356005)(6636002)(40460700003)(316002)(8676002)(70586007)(70206006)(4326008)(47076005)(83380400001)(107886003)(186003)(1076003)(336012)(2616005)(26005)(426003)(6666004)(82310400005)(7696005)(36860700001)(36756003)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2022 04:48:12.7849
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 754b2d37-7809-44b0-c7c8-08da23522446
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT022.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6082
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

 drivers/fpga/of-fpga-region.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/fpga/of-fpga-region.c b/drivers/fpga/of-fpga-region.c
index 55209737075f..b5ae3e8de5ab 100644
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
@@ -279,7 +279,7 @@ static struct fpga_image_info
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


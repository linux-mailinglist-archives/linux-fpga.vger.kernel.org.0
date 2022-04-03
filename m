Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD0254F07C4
	for <lists+linux-fpga@lfdr.de>; Sun,  3 Apr 2022 07:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236970AbiDCFTN (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 3 Apr 2022 01:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237729AbiDCFTL (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 3 Apr 2022 01:19:11 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BDB237026;
        Sat,  2 Apr 2022 22:17:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MrCI3jjR+yp9nzJ5lBHdJmtqrZSFdzFA94/wo+qxFE9kPpPfZVMUE5U9oeiBdhJmleUjpTx72+7YdtacsY9cDLKROI7PsbAUkfvwVSso7zZgeQbSszpD+4t1tHsgAY1NRaMKM2qWLjlhXX9DamYb2/MlNOl4dv32/DNf/yA4Eft3lvrCdccvhO+YLvtX7mcWI+E2S7ihLbbVrHVEHbuB9jMeG/OwmhWMWMLxDQ1XLNC50aePicDBUsAYBT2fHrRCFEn0R7mWkI6mlUFkHFwn0iAVMCD4+772tpUOykzG6nkzh3iCVSbCCFQgVAtSSjWLtV3M1ZKSAb9rARWlf7oAhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/bDLCRcQqsLDW3o4Kv8XZfprDMFd0u/5utggCmt/lG4=;
 b=Vken6r1INVME5u2XHOUUrzCOd6xEcBiU8RH+g8zfcvGZPCI08HYHC2u4ItL9cxd2aeR/AChLjIdb8UMIzlOmOyYJS1oGJTcA0rUM4Fy74CmMhz/Tt2DBOnsbHGLb36MRa5UXw4n873fp17/KaLVnCFxEQOeYN481Y/OTrHuDKlJ6yN9oqZ4sQiv4DLvzFHAOqxQWawGo5Wai4W8erOnJN+kLoGiLIqH4IfcS10jtQaMbDOAiSsnyz2TJeI5K2GyNFynnN+FK6T8eyq3+Ogjh1yb728QHSKkvBm4ZIktN5sqPS5fR0r3ZZk2TJA5MadKZv88xFaW/8JOUBGJ76+3/7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/bDLCRcQqsLDW3o4Kv8XZfprDMFd0u/5utggCmt/lG4=;
 b=s77X1EPLYNi/pSK7wQ/OHRuHUKlmI/Px5XyIGNKy5bT9rWwqtCT3Ab/n03wSGbgim2DKGwmz167ib7rXuhwYgoc4sYX0Rr/B3gI9MoDKmLV75ddjMTw+USii3QODcskf30WiWpIyImNx7ertpRLyFQB0i3qjSOmpGZ962E0Z6Gc=
Received: from DM5PR07CA0106.namprd07.prod.outlook.com (2603:10b6:4:ae::35) by
 SJ0PR02MB7742.namprd02.prod.outlook.com (2603:10b6:a03:320::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.30; Sun, 3 Apr
 2022 05:17:15 +0000
Received: from DM3NAM02FT063.eop-nam02.prod.protection.outlook.com
 (2603:10b6:4:ae:cafe::49) by DM5PR07CA0106.outlook.office365.com
 (2603:10b6:4:ae::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.30 via Frontend
 Transport; Sun, 3 Apr 2022 05:17:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT063.mail.protection.outlook.com (10.13.5.71) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5123.19 via Frontend Transport; Sun, 3 Apr 2022 05:17:15 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Sat, 2 Apr 2022 22:17:12 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Sat, 2 Apr 2022 22:17:12 -0700
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
        id 1nasbv-0007vd-IF; Sat, 02 Apr 2022 22:17:11 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>,
        <trix@redhat.com>, <michal.simek@xilinx.com>,
        <linux-fpga@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <git@xilinx.com>
CC:     Nava kishore Manne <nava.manne@xilinx.com>
Subject: [PATCH v3 5/5] fpga: fpga-region: Add missing kernel-doc description
Date:   Sun, 3 Apr 2022 10:46:41 +0530
Message-ID: <20220403051641.3867610-6-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220403051641.3867610-1-nava.manne@xilinx.com>
References: <20220403051641.3867610-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d070c189-461b-4c5c-f411-08da15313785
X-MS-TrafficTypeDiagnostic: SJ0PR02MB7742:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR02MB77427838CC72D259AC188F3EC2E29@SJ0PR02MB7742.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lmCmWkYPuVLaU4oLFh9VNJs+RCvL3jE9Qzp77IYzYg/Z6HbaoRk6xm/kXW3ZQWP+nRfjxzP895/NZaIIS392ML91VH+ynh4ZOQAVNpbhdd9Bc9VzqMDAoyP4sdPMDneKuT3DGmDo7sCYKNn2c/0nIoyW2yGJo26Xa7ghj8wG7k6T1DnaIhB31l9jEsWq8PjY8tG83NSbU8qKFupEF9FVEGTxYZgZSvUhTBjRCPGB3jsPezqp0edB+ClZuMWr+2TNsXroTRAB/RR+NPszqON0zZ6aFm/b8GLhRA8WCmYSi2HHdrJPcaQ5tKBfMu/aBJUTafMhOqGneWeGCHkT1PGGGO3h2oSLpn2Z1QPpSHwXN2ORCTr1nJQ7iCLPmtx7AxkdrWaiuqAk2w1FZqRBBM7fITTas4vwaIzSz7fB52LZAD/sQE0GzmVqPEFstsQPd9zg/u6jqqItW60dWaJR1vTgW9jjgBuANhj4uvenmv9RxOsYS83KpBkJt5SRMBmk5DmFQIxBS7IPY2cPhWjaleGnhuaV8lp0FX5P0mPd6asGOHpz6qjytv/BVdFs7OTnYhiEaYEclFCjp5si4n277lUzF0cLsIUkEpMxCg7fIzXZaWd2zCGLGfgb1YexWgP0iYMZRyR8b2FDYPTvNWTRhfJCUSJ38pLVy9F4yJjDYVbj/UMn5Dkhx4g/YMsk6SJjuEHvDaLX2kxhuezHA2XBFkZTPPEqJCaR1Dixj9fT0ogI6G63PY1FxtUr1Tlt6+FhLvpJ
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(2616005)(8936002)(40460700003)(316002)(7636003)(1076003)(83380400001)(107886003)(36756003)(47076005)(7696005)(110136005)(9786002)(2906002)(186003)(26005)(336012)(426003)(82310400004)(6666004)(70206006)(70586007)(36860700001)(5660300002)(508600001)(6636002)(8676002)(356005)(4326008)(102446001)(21314003)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2022 05:17:15.4515
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d070c189-461b-4c5c-f411-08da15313785
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT063.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7742
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
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

 drivers/fpga/of-fpga-region.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/fpga/of-fpga-region.c b/drivers/fpga/of-fpga-region.c
index 50b83057c048..9e330a2c0a1b 100644
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
@@ -279,7 +279,7 @@ static struct fpga_image_info *of_fpga_region_parse_ov(
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


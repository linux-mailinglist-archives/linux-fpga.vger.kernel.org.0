Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F46C5036CE
	for <lists+linux-fpga@lfdr.de>; Sat, 16 Apr 2022 15:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232093AbiDPNk0 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 16 Apr 2022 09:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232116AbiDPNkY (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 16 Apr 2022 09:40:24 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39165D3996;
        Sat, 16 Apr 2022 06:37:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VuHQYndd5fr6UunInNhue6UAOEA3OHCRQSHHbfQ1qkS+0YAGOvxWIeRaLpDB/0rQ3YWr9tKYPlgvtWSWIc34A53DVQ3niYkBDW5cXRB4hfPmpntSO2zbgwq6iAEaj46DU9AwUrwxlq0vJQIfsjdUN9+oCP1G11aP9o56u7Rp8xZu85D+IGo79T4mequai0/V8Hh21qPjT1DjOzSktS7gB9qDvrvvLQejGMwfRWlEFJjnvQIJd/TgSNubJ1m1dNmQ2rfsDWRG73bVavTlxqw/URVSuR7OFyDqCW5vP286nUlxTqxbogLYx2Zhxfr+LZg7LGGpibzAd+h+TC/HGVjWJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=82wL+R9Nk3zPle/kbOr+ES8fRDChUjz/L3cNN22UwzA=;
 b=mk2Cy1dnwRxZ6vLFCNUbdFhJkns9p1GidlDWOIcg/2gP6XMxxlfnRDSR5rAJrYFUt+XOmaanU8o8yH6EuXKJPExn+AI/ujrnS0TfuOEpcG7MGXUhscL6mgO/LLBAKqGOGSfP1EQZu4T9UkJ9Z9yMlaBJC71iug99OfaAi1hUS0tQwq0FvaRFr1irireT4WV2AMklJ2SohlvhnB4SFcujBOwFP/Q6LyXcmsS2LES+zJzPCCzqOnHmZQmIMhMN6OJNNMFqrDLkMmnY2jU4ypciG7xLHQA3eYacfIWBLPmWIh6BaykRtOv8Eto9h9/2wb07kVR5ddZPizbtOF64ZSwG7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=82wL+R9Nk3zPle/kbOr+ES8fRDChUjz/L3cNN22UwzA=;
 b=ErFCHG2ku+VXC1KklVHI7wjlug3xcWmNI13mpb8TehdTpdsPFXr1LmADJFwnnp6z8QF66ZXRhkRFxBF/aXGcLvVyLLxl4Qq11zgIFlo2zwfYZgi23W3QRb+iCs/2mT77i+PNnwgqKPBy6rbZXKimINiyErIY3dUQX5Mi90iQNqk=
Received: from BN9PR03CA0592.namprd03.prod.outlook.com (2603:10b6:408:10d::27)
 by SA1PR02MB8413.namprd02.prod.outlook.com (2603:10b6:806:1f4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Sat, 16 Apr
 2022 13:37:50 +0000
Received: from BN1NAM02FT036.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:10d:cafe::cb) by BN9PR03CA0592.outlook.office365.com
 (2603:10b6:408:10d::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20 via Frontend
 Transport; Sat, 16 Apr 2022 13:37:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT036.mail.protection.outlook.com (10.13.2.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5164.19 via Frontend Transport; Sat, 16 Apr 2022 13:37:49 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Sat, 16 Apr 2022 06:37:40 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Sat, 16 Apr 2022 06:37:40 -0700
Envelope-to: git@xilinx.com,
 mdf@kernel.org,
 hao.wu@intel.com,
 yilun.xu@intel.com,
 trix@redhat.com,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Received: from [10.140.6.60] (port=32988 helo=xhdnavam40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <nava.manne@xilinx.com>)
        id 1nficO-00088I-Bf; Sat, 16 Apr 2022 06:37:40 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>,
        <trix@redhat.com>, <michal.simek@xilinx.com>,
        <linux-fpga@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <git@xilinx.com>
CC:     Nava kishore Manne <nava.manne@xilinx.com>
Subject: [PATCH v4 5/5] fpga: fpga-region: fix kernel-doc formatting issues
Date:   Sat, 16 Apr 2022 19:07:19 +0530
Message-ID: <20220416133719.3382895-6-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220416133719.3382895-1-nava.manne@xilinx.com>
References: <20220416133719.3382895-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a129e05-e92c-42ad-2e98-08da1fae4cbd
X-MS-TrafficTypeDiagnostic: SA1PR02MB8413:EE_
X-Microsoft-Antispam-PRVS: <SA1PR02MB841381A4D79A6CFE402969CCC2F19@SA1PR02MB8413.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f0pQmshk/lL5pAsIbjfc31LpNmmwdnZSB1i4oa2ns1FlwddwGjgIETFTf92uFXj1cruHNPdPtjhLAJs+G/GYnhbfhhsiyMBXBajcxeYgpb16kR3NDqP+MujsjFHRWpIb1QGRK3P3YEVzRdihr3aVb4AAJfjF3d5vRxxLduH2U8NX4xXkp4026fgmg9tPdkY3dtaHvaUB2jdymr+LmAuFGWzDGRscOTlVM1UY4rytLvHBuPgl5x1GexaIBkG/UpM4VHGf5tVmr26xegK9xc5HJp6sAwkWpa9wnvXs5LrpfDQ9g4KHxeJsFDnM8+p71wYXsXv47iIR2sx3ICz8Wxu/Ia3V0Gci8xuDCif8MmGT/7h4K2pzeJzfxz7FnR77mQ4DqtFfBYkvoMLvIfFwuJUMBGRg8VlUsiLFLlQ5ZmcIIqjWMwiuqXDESQSp3zML14ykAzj7EUVhhCJ5ijxsrHTLQku+D/GwZxYV0ZSg8AUV7mpgdzIxKWs0rbYK8NKrmnqwwes1wNxx/MOaGZsyaOU4A7yCMU9SePc/1Iv4oEDiv4kMrX/zKXmg6h3VukO8PO41WqDb0ovhoqMxtycMAtvSf0MQ4NcxfaOG0aCz9ccODpYh4afwf2oQQ81atMx2gGMlnDmT4Liwol2qHR/PzFD7xat1yRPC8U9dtS8Ak9Up5v4Cq24mH8pyr/b7QniIL7NkijkJ0dOqGTRex1Ta3nCe+puTgq61sz/o8mS9p6v8/e0=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(36860700001)(6636002)(1076003)(110136005)(9786002)(186003)(5660300002)(2616005)(107886003)(26005)(508600001)(356005)(47076005)(8936002)(83380400001)(82310400005)(7636003)(36756003)(40460700003)(336012)(426003)(316002)(7696005)(4326008)(8676002)(6666004)(2906002)(70586007)(70206006)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2022 13:37:49.7177
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a129e05-e92c-42ad-2e98-08da1fae4cbd
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT036.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8413
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
---
Changes for v2:
                -Replaced s/@return:/Return:/
Changes for v3:
               -Updated commit description.
Changes for v4:
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


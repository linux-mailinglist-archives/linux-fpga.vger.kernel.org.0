Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC0F4E3A87
	for <lists+linux-fpga@lfdr.de>; Tue, 22 Mar 2022 09:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbiCVIYX (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 22 Mar 2022 04:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbiCVIYW (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 22 Mar 2022 04:24:22 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466BF5F247;
        Tue, 22 Mar 2022 01:22:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ybdr8tTkjUYJ4LZomxpH7yzuU+B5IFEkw0hvsa7rSXT/tt5ABVnnXiykOyFKh+fopYNzusFM1qogbB8wV/ly8bQhTWaX4sWIU5WlQ0rGVm0nkFGSAyYeY/0ZuVZ8WJjlnQ7ZW0q2rRKDKiazZrPXrtprtsYYRWT+wZSAXx5BnZYDeN1jMRr2qeWWSV9gU8e5MZKCP/mancVszrALaCXB0zQMLvPD+Iwu9MmEJSLThNJrI2YeSY0RfxuD3BZQ3KxyUyEbmGECWVlWokkB8qS3qZ2FDvOBeeu2FE9v/YwTndLheZM/mSMGIrHaT3jrd1E7dzYIe8e8vzmsXy604Kp8nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1HNa21YkKyUcxjGgDDg5XxmTBu5rVVbnDVIjKOVGPsc=;
 b=grO9J3QXjtngX5O+nQyiXrMXCfhkDB+AdDCtAPRXoDKWMvU/Dbq+eZVqate3+qBZu2q3GYOLfhZue8srytYyVVFGeUJzspKNHgD2BJ2kGOVZZ3VFeJoa1PK+0qtqXIZ4SOzgJZ2uegSOmcjUJ8rRNV+4zy+4S1IIeFgOdjhBec7Qj/phRYzJTiLbWZiiB2/fqCRRwobdEpyZitu9MCOJzoA+PtL/HGwDCdvKqJgyviNLI4AZDR8GRHJ0Z9/qJPruZdcr+9+96+AheWkYMcw/ak8iOfEziUVB/e2BPhEBetUQ/9mmb3KwJZHMrJqlK9OVDu3PlJS8U/O4FEx/KVKdHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1HNa21YkKyUcxjGgDDg5XxmTBu5rVVbnDVIjKOVGPsc=;
 b=I1VgHyJPRfxXAmNxukmKAHaisGMw7Sjkgo9fcj1vSRbGjOFSC802Gfqe9kMx/vLJSNv31V48jZQo7DOTymZnX2v4VoHU+DzX6zO4WZRdHXCF+l3bSZ0s+j15nzfET6UmPcbF9ZpeaAqYu2t6rIEAtcmaZ7LJofPz7Lgqnzy7XRU=
Received: from SN4PR0501CA0112.namprd05.prod.outlook.com
 (2603:10b6:803:42::29) by MN2PR02MB6288.namprd02.prod.outlook.com
 (2603:10b6:208:1b8::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Tue, 22 Mar
 2022 08:22:51 +0000
Received: from SN1NAM02FT0050.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:42:cafe::83) by SN4PR0501CA0112.outlook.office365.com
 (2603:10b6:803:42::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.11 via Frontend
 Transport; Tue, 22 Mar 2022 08:22:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0050.mail.protection.outlook.com (10.97.5.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5081.14 via Frontend Transport; Tue, 22 Mar 2022 08:22:50 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 22 Mar 2022 01:22:39 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 22 Mar 2022 01:22:39 -0700
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
        id 1nWZmo-000Ei2-N4; Tue, 22 Mar 2022 01:22:39 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>,
        <trix@redhat.com>, <michal.simek@xilinx.com>,
        <linux-fpga@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <git@xilinx.com>
CC:     Nava kishore Manne <nava.manne@xilinx.com>
Subject: [PATCH v2 5/5] fpga: fpga-region: Add missing kernel-doc description
Date:   Tue, 22 Mar 2022 13:52:02 +0530
Message-ID: <20220322082202.2007321-6-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220322082202.2007321-1-nava.manne@xilinx.com>
References: <20220322082202.2007321-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03cfb77b-f0a0-4257-9a97-08da0bdd27ab
X-MS-TrafficTypeDiagnostic: MN2PR02MB6288:EE_
X-Microsoft-Antispam-PRVS: <MN2PR02MB62884CA13ED4A9691205CADBC2179@MN2PR02MB6288.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v6m4eFqfnBAChilbv0cFT6BVy3e1HkVYF4UEzC55dcpPSmR2Pm/oZgFvKqSJ47pSL6YJWcm00F+43abq+HG3vZvAii242c05lZaF171dDuV8qfkOoDNcMpzEzFzZZRApZvLPT9kMGaYNDMuE+2ZdPw3U+WobiFby4NR6MLQb7QWviw9LeFBsr94nXQDySbgzB9ug0jNvBS4VgbEfa1LTuaG3EL1fa0CTOi0ffy7HfeFBALsifKxItQT2ROWOlc9XGwx6AbNfecYukZMS3CYFEOmCVIXNhAicSy956uEpcQnKM/DQG/KjdHqaJNfMEE9+2hsZPk1WssIbdsamHy3UWKm2olA+H2IWU8NerM4KUePwZvAMCah1PVcXiy8Xkd6nb7qduftQyyDtiMeyFhycSrnW6+2XcpvaSuhxZGgZeLHruhh33TCEDFmVpIu2ul15HONbAdFUUAv3U5LGd492Tl3ZoP2lMFxfDbvc049ubLPfLWC1wGPlIWwXL6EpMyF2P3D4BoAcD1nzo5JF8jRiptuWf9e16/xZNOwjN2YMkUf49f/m7bn1JLeO3925A93LLfhZ520n7HAstTgEkQe+YGwfz9ARHhSnlqbXDkXxS2X1RtZ9jFvdiyYnv6MAGafUT42z90J7b5zsChcuoeIW/JJ9XKJTci4sTWqkvSylR2YvyEDTw99wkv+KWqaIjL9aQiJp4ZRxvYqQDI5QRWQ+2RTuNN3iUN4XlpeOPQP29NBpstYZjzW3kWFoD8IKgvII
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(5660300002)(6636002)(316002)(47076005)(2906002)(82310400004)(36860700001)(7636003)(356005)(2616005)(110136005)(36756003)(8676002)(186003)(107886003)(4326008)(1076003)(508600001)(6666004)(7696005)(426003)(9786002)(336012)(8936002)(83380400001)(26005)(70586007)(70206006)(40460700003)(102446001)(21314003)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2022 08:22:50.6800
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03cfb77b-f0a0-4257-9a97-08da0bdd27ab
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0050.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6288
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


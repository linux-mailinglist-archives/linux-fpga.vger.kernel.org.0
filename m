Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 333B54D13BA
	for <lists+linux-fpga@lfdr.de>; Tue,  8 Mar 2022 10:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345475AbiCHJrV (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 8 Mar 2022 04:47:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345501AbiCHJrN (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 8 Mar 2022 04:47:13 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6AE419AF;
        Tue,  8 Mar 2022 01:46:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HKEoGO/ko9PpZGUeeNIhYzRqLcWLGLKuARWS6MddmAHvYTSFtoIlmX+Hnq+QJihwljU4AlV0/FFeZOEo5xMOnn/vwugMk0lRvLC9s5jLh3Gbx3+Z5L+vOSBtEuKuKUEZvmP7iWY3mPoDy82+nP4v3LWvzs//LrRARfGKiYMxo34MjnhGOHrQ1UFFrGwG2jScYJDK02dMtuH1wQNzbCbtpmtLfzK5CK2w0cFzG34vvqOrTGHtkJCtwiu9j/wsktrkbjxKAAm8XsP+l4F3cGKjYK5sKoGbkzxRSbSGjEjkjdfLdtxSevrTyFC4afHcTAxQogHPTR3YwjrGV9C8Zibelg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fXqsT7pzWAnlK0Z2Bo/Kgse9o7x0ZHMdonyXqFe4dVY=;
 b=a5hPdeL/gnZAMwQ3WyAHglPzOs4m9yh4pdho5j41+xTyeFboVIZ1S0u+vZTv9/GwiLXsHC1NK3scO92eG16k8uoXCp9ye/Pmlf22rCNUoKrXu9UlJ7f3oKa6v7glGY6eDRBTb4uoE7051dxHeeetJ4drnayCPFtXFyfLGxlWMW6FDZwn2t3+sWNkBL7mjrf+Hu6/AOsEoFUIxvUO85+RyS4R8Zm6TzpqS9dE7hEAf/oghBvrP7Ypl8RX40op92PPGm0YXaavOMmiBfatLrzpypsEAaUswiU/Ss4QaxU/UfXrFeaw1DgB7XqrBZ86s/uReMN2QfVWLnYHm+QapFNmfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fXqsT7pzWAnlK0Z2Bo/Kgse9o7x0ZHMdonyXqFe4dVY=;
 b=P2zUS+wUnO3hmwUXAhmRDdJjBsDYvHhspr8wH6WMGxdoEGH9yQS91CpVVwjhnWTcwde3ZOoQRtof/Q8q8DD7s3PRs293WFINEsFGC3v84EnA/6MetIhrnU4NnCFjlCRp7XhSuN1kQ+4d5JjzRteGmI06NxvNlbf1NFzukNKayok=
Received: from DM6PR11CA0009.namprd11.prod.outlook.com (2603:10b6:5:190::22)
 by BL0PR02MB4833.namprd02.prod.outlook.com (2603:10b6:208:53::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.25; Tue, 8 Mar
 2022 09:46:13 +0000
Received: from DM3NAM02FT016.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:190:cafe::5b) by DM6PR11CA0009.outlook.office365.com
 (2603:10b6:5:190::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Tue, 8 Mar 2022 09:46:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT016.mail.protection.outlook.com (10.13.4.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Tue, 8 Mar 2022 09:46:13 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 8 Mar 2022 01:46:12 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 8 Mar 2022 01:46:12 -0800
Envelope-to: mdf@kernel.org,
 hao.wu@intel.com,
 yilun.xu@intel.com,
 trix@redhat.com,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Received: from [10.140.6.60] (port=33304 helo=xhdnavam40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <nava.manne@xilinx.com>)
        id 1nRWQ0-000G0A-0a; Tue, 08 Mar 2022 01:46:12 -0800
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>,
        <trix@redhat.com>, <michal.simek@xilinx.com>,
        <linux-fpga@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Nava kishore Manne <nava.manne@xilinx.com>
Subject: [PATCH 6/6] fpga: fpga-region: Add missing kernel-doc description
Date:   Tue, 8 Mar 2022 15:15:19 +0530
Message-ID: <20220308094519.1816649-7-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220308094519.1816649-1-nava.manne@xilinx.com>
References: <20220308094519.1816649-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 750aafc6-32da-46fb-4842-08da00e87b9c
X-MS-TrafficTypeDiagnostic: BL0PR02MB4833:EE_
X-Microsoft-Antispam-PRVS: <BL0PR02MB48333CBC764A453F33B42DB7C2099@BL0PR02MB4833.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cR6KWy0UetRKMLJRVls4T7M/FSgVHOPKF+AljKqNSLCpJvrfDw1Fx8nNF0U68LO4qewVZh0AA8wuXUEIxjrHN0cvdVG86EYYSYQvpIcqSBJpmZhsWrn+DuCfrX2lfDhbrn0qmfhKIfQdu4IwUFJM1UQ8NQNp1cL/MbsaelTHYZ1BvmBPhWflDorXVAmHG3yuv8iVmoApXXmB/IZxKPY+cBBBoOewvF/PqmhDjyfSiax18dgj21iFSBY8YNT2VoViunqT/Nrbkj/juTBcwY6gpE463HPJ+D3fkVqRehj/SHQdtYQveuxA0m6yXwasuyPqdD0JXgT4je1IvWB5dWY1tzNX4R56pCLpG1aqHOwHT9SKqdlEeaVuwV3b2T6wkReZLg1ngUuZDHOl81pFosQy1F3CJ6UsQXEB4fN5rHQYG5shDzvYzty6Twpa/OYWQ80U2vBtWp0wAxS8xOiqpG8FV8vRv5WqZEl3xESpY+BecyBoTBgx/fJJa8Kr1MYTfyzucEQQ/W2OF3mmAJo6MqosxlWhi2QtZa9KrdxPjUWlvsKw3/ONS+HbNVWivva/bSQrLFkA3c4I38LfGL9/FycXfkpn7t0+8KfcLVizkEUd5JBf/YCq2U15NTdT9b3UXGW779/g6UfjDKh3SH283Y7KX6XQ7n5Hqc3HPQHzk4x2lcZuzmX8xRjAw0Ue9DQkGuLfJIoTX2PriAPhuEKdzFWTnnm1pXluFpv7cHbq8HokZsY=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(5660300002)(107886003)(7636003)(356005)(70586007)(36860700001)(4326008)(9786002)(8936002)(426003)(1076003)(83380400001)(2906002)(186003)(26005)(110136005)(36756003)(7696005)(70206006)(336012)(316002)(8676002)(47076005)(2616005)(508600001)(82310400004)(102446001)(21314003)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 09:46:13.1661
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 750aafc6-32da-46fb-4842-08da00e87b9c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT016.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4833
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
 drivers/fpga/of-fpga-region.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/fpga/of-fpga-region.c b/drivers/fpga/of-fpga-region.c
index 50b83057c048..61ce257c47f3 100644
--- a/drivers/fpga/of-fpga-region.c
+++ b/drivers/fpga/of-fpga-region.c
@@ -28,7 +28,7 @@ MODULE_DEVICE_TABLE(of, fpga_region_of_match);
  *
  * Caller will need to put_device(&region->dev) when done.
  *
- * Returns FPGA Region struct or NULL
+ * @return: FPGA Region struct or NULL
  */
 static struct fpga_region *of_fpga_region_find(struct device_node *np)
 {
@@ -43,7 +43,7 @@ static struct fpga_region *of_fpga_region_find(struct device_node *np)
  *
  * Caller should call fpga_mgr_put() when done with manager.
  *
- * Return: fpga manager struct or IS_ERR() condition containing error code.
+ * @return: fpga manager struct or IS_ERR() condition containing error code.
  */
 static struct fpga_manager *of_fpga_region_get_mgr(struct device_node *np)
 {
@@ -80,7 +80,7 @@ static struct fpga_manager *of_fpga_region_get_mgr(struct device_node *np)
  * Caller should call fpga_bridges_put(&region->bridge_list) when
  * done with the bridges.
  *
- * Return 0 for success (even if there are no bridges specified)
+ * @return: 0 for success (even if there are no bridges specified)
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
+ * @return: 0 for OK or -EINVAL if child FPGA region adds firmware-name.
  */
 static int child_regions_with_firmware(struct device_node *overlay)
 {
@@ -184,7 +184,7 @@ static int child_regions_with_firmware(struct device_node *overlay)
  * Given an overlay applied to an FPGA region, parse the FPGA image specific
  * info in the overlay and do some checking.
  *
- * Returns:
+ * @return:
  *   NULL if overlay doesn't direct us to program the FPGA.
  *   fpga_image_info struct if there is an image to program.
  *   error code for invalid overlay.
@@ -279,7 +279,7 @@ static struct fpga_image_info *of_fpga_region_parse_ov(
  * If the checks fail, overlay is rejected and does not get added to the
  * live tree.
  *
- * Returns 0 for success or negative error code for failure.
+ * @return: 0 for success or negative error code for failure.
  */
 static int of_fpga_region_notify_pre_apply(struct fpga_region *region,
 					   struct of_overlay_notify_data *nd)
@@ -339,7 +339,7 @@ static void of_fpga_region_notify_post_remove(struct fpga_region *region,
  * This notifier handles programming an FPGA when a "firmware-name" property is
  * added to an fpga-region.
  *
- * Returns NOTIFY_OK or error if FPGA programming fails.
+ * @return: NOTIFY_OK or error if FPGA programming fails.
  */
 static int of_fpga_region_notify(struct notifier_block *nb,
 				 unsigned long action, void *arg)
@@ -446,6 +446,8 @@ static struct platform_driver of_fpga_region_driver = {
 /**
  * of_fpga_region_init - init function for fpga_region class
  * Creates the fpga_region class and registers a reconfig notifier.
+ *
+ * @return: 0 on success, negative error code otherwise.
  */
 static int __init of_fpga_region_init(void)
 {
-- 
2.25.1


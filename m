Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 219F168D372
	for <lists+linux-fpga@lfdr.de>; Tue,  7 Feb 2023 11:02:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbjBGKAq (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 7 Feb 2023 05:00:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231882AbjBGKAY (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 7 Feb 2023 05:00:24 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2061d.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5a::61d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6EB46AF;
        Tue,  7 Feb 2023 01:59:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nGllwQM8fRt102no9w9uqm+i9o0UXN6IYrNwZMzXf8zP+LsUG3R/jhJpxXAPFIeCrpH9i9TUZjRL+6VPnGOKE3T2TP34w8sIdgiSH+QG6k8f4PYdr5c5HVfVNCGaRYNf5LXpChEVNs7/CjqgocC2bjSbUc18Lm6FbQtcXo2rkJ1YWjQC0T3mT3HsxJXYAjSfbNkEtTGmibq9c2W0YaH/hv+WXdP+mwBnCOeSMX6e+YG7x4P8sZr3sSlRQT111raZMzpqTh9kQnWeyd19N8ddtMoH3XfdLPjgkKxYYfeCprDFuSl35Z+fleYCjy7Q6zLztOVShv0dJ+H9ZU/6MJGi8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7unnzf7buQgHzowN47PYR3ng4sTA8Dslenk+RBAnIoI=;
 b=JfhrQ0TQQ+HuQohj61TQq8ZKoBifx1CXtyrO34I9h27cnd6d6MaJ2nmWNxBeNKSoovqe27ohpUiwqFDpOUARtRYLFywAp/nlsw0osG9FVEi2+zlU7oseggD40Fvv/rVPhFtlt7Boxsj0UWvAFczOfHtY2n/LXjBZ1BnByU/PieXM8bhbmEq9+W3jPokER3UXGIkFO9eoyfmPS5YD2tdL+DYdxhWK4z8QTtJk2kODPUmp8CzQ2EiEf4TWTjNFUxVZ4jY+rEfwbtw/xpTGDLvOPUgeQTCYTHvBOoj43F5KOSSNh1G5iGH9HQC5O+D7HPCe3HHLw+vdjb11122YT8lS0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7unnzf7buQgHzowN47PYR3ng4sTA8Dslenk+RBAnIoI=;
 b=kosP0eYbv3OfJuQtLMjMCNUtXyGI8cbQysUjDji+HOkw0R9xiULZ13GfSvM0lzqN8kwRQiEZJCNBAs1p+Whn7Qwjne4aMAD3cteepTDnBpdkJjbpyx2L8sunO0CZGVHJDi95CKqWc5MklQvF4s65YQWj104J1uXNqL6wKhnRRJI=
Received: from DM6PR08CA0048.namprd08.prod.outlook.com (2603:10b6:5:1e0::22)
 by SA1PR12MB5616.namprd12.prod.outlook.com (2603:10b6:806:22a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Tue, 7 Feb
 2023 09:59:21 +0000
Received: from DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1e0:cafe::d0) by DM6PR08CA0048.outlook.office365.com
 (2603:10b6:5:1e0::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.36 via Frontend
 Transport; Tue, 7 Feb 2023 09:59:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT004.mail.protection.outlook.com (10.13.172.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6064.32 via Frontend Transport; Tue, 7 Feb 2023 09:59:21 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 7 Feb
 2023 03:59:17 -0600
From:   Nava kishore Manne <nava.kishore.manne@amd.com>
To:     <mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>,
        <trix@redhat.com>, <linux-fpga@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Nava kishore Manne <nava.manne@xilinx.com>
Subject: [PATCH] fpga: mgr: Update the state to provide the exact error code
Date:   Tue, 7 Feb 2023 15:29:15 +0530
Message-ID: <20230207095915.169146-1-nava.kishore.manne@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT004:EE_|SA1PR12MB5616:EE_
X-MS-Office365-Filtering-Correlation-Id: e2cbc74b-b871-4fca-5b46-08db08f1fc39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vcvm4OwUwlhPBhUos0Msc9W1XZQ42YrsRODwnUbVgI40ok/GQzbd2nVqIM6HNK/DazoKks+tEmhd6IG6AZ5SaFL7u2dsOAlsErrtDcJoeWDGQlh8aeBjp3op9ch1q1pIKeVZXmG8dwlyBT0e9hz6bXT2uzVHckyS/42oxa3jA0V1JnzFtBlrcd1r4nZE/9/F+smiEPELcz3alU7Y7/ax7mA9rvRTUtzKNHrX9H2EGmd1O740p2ryi37/DjKzjR6hiExN7Q9TaNZfffwYutmWBDrW/BQ9VDb3QSuTsNWK6UuAuYeoCVGJYaNq4q+PaYH8K8ljUuTInzX54Um9msqQuBz6JvbUxUEeeRCH7nrr2p0gPBjEg/BJ2izf2963nHkC4nxZe0o9UkKoMpseREcO+ByppBVzy4OI2iqIPkjwd0ZzznXzGyk/bL+8Fe2d7IiPT06XsT2xetSsdy/SbvjnfDsDuzNG5rCM/Hfvz7/vQwHBhD5DhXkO6m5OBlWKa25XTHEaQjDDIX7EJ0lJuDjf2/fqZXGEeDjFloXs1IWdsTCXcZ1iUkTN+XiFTlabRo/v5QPhwEu54HSVjGawGapbhmq1EH0dtfU5ic55LHDQtniZoWa/CC+wkk5oIRAEaexdUCFdb4+lGA8k7OtRBbPVv1pC2prj7V4IFuVh6xT43qdQTgXJmqzuncQkWz+6drXYLMWH9PTie1FzuiuItWkZ5Ja2LT50ZVvEUZhUh8U7R3k=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(396003)(39860400002)(136003)(451199018)(46966006)(40470700004)(36840700001)(70206006)(36756003)(82310400005)(110136005)(41300700001)(4326008)(316002)(5660300002)(70586007)(86362001)(82740400003)(36860700001)(103116003)(356005)(81166007)(186003)(1076003)(26005)(16526019)(40480700001)(8936002)(426003)(15650500001)(47076005)(40460700003)(8676002)(2906002)(336012)(478600001)(83380400001)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 09:59:21.4033
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2cbc74b-b871-4fca-5b46-08db08f1fc39
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5616
X-Spam-Status: No, score=1.7 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Nava kishore Manne <nava.manne@xilinx.com>

Up on fpga configuration failure, the existing sysfs state interface
is just providing the generic error message rather than providing the
exact error code. This patch extends sysfs state interface to provide
the exact error received from the lower layer along with the existing
generic error message.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
 drivers/fpga/fpga-mgr.c       | 20 +++++++++++++++++++-
 include/linux/fpga/fpga-mgr.h |  2 ++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index 8efa67620e21..b2d74705a5a2 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -61,12 +61,14 @@ static inline int fpga_mgr_write_complete(struct fpga_manager *mgr,
 {
 	int ret = 0;
 
+	mgr->err = 0;
 	mgr->state = FPGA_MGR_STATE_WRITE_COMPLETE;
 	if (mgr->mops->write_complete)
 		ret = mgr->mops->write_complete(mgr, info);
 	if (ret) {
 		dev_err(&mgr->dev, "Error after writing image data to FPGA\n");
 		mgr->state = FPGA_MGR_STATE_WRITE_COMPLETE_ERR;
+		mgr->err = ret;
 		return ret;
 	}
 	mgr->state = FPGA_MGR_STATE_OPERATING;
@@ -154,6 +156,7 @@ static int fpga_mgr_parse_header_mapped(struct fpga_manager *mgr,
 {
 	int ret;
 
+	mgr->err = 0;
 	mgr->state = FPGA_MGR_STATE_PARSE_HEADER;
 	ret = fpga_mgr_parse_header(mgr, info, buf, count);
 
@@ -165,6 +168,7 @@ static int fpga_mgr_parse_header_mapped(struct fpga_manager *mgr,
 	if (ret) {
 		dev_err(&mgr->dev, "Error while parsing FPGA image header\n");
 		mgr->state = FPGA_MGR_STATE_PARSE_HEADER_ERR;
+		mgr->err = ret;
 	}
 
 	return ret;
@@ -185,6 +189,7 @@ static int fpga_mgr_parse_header_sg_first(struct fpga_manager *mgr,
 	int ret;
 
 	mgr->state = FPGA_MGR_STATE_PARSE_HEADER;
+	mgr->err = 0;
 
 	sg_miter_start(&miter, sgt->sgl, sgt->nents, SG_MITER_FROM_SG);
 	if (sg_miter_next(&miter) &&
@@ -197,6 +202,7 @@ static int fpga_mgr_parse_header_sg_first(struct fpga_manager *mgr,
 	if (ret && ret != -EAGAIN) {
 		dev_err(&mgr->dev, "Error while parsing FPGA image header\n");
 		mgr->state = FPGA_MGR_STATE_PARSE_HEADER_ERR;
+		mgr->err = ret;
 	}
 
 	return ret;
@@ -249,6 +255,7 @@ static void *fpga_mgr_parse_header_sg(struct fpga_manager *mgr,
 	if (ret) {
 		dev_err(&mgr->dev, "Error while parsing FPGA image header\n");
 		mgr->state = FPGA_MGR_STATE_PARSE_HEADER_ERR;
+		mgr->err = ret;
 		kfree(buf);
 		buf = ERR_PTR(ret);
 	}
@@ -272,6 +279,7 @@ static int fpga_mgr_write_init_buf(struct fpga_manager *mgr,
 	size_t header_size = info->header_size;
 	int ret;
 
+	mgr->err = 0;
 	mgr->state = FPGA_MGR_STATE_WRITE_INIT;
 
 	if (header_size > count)
@@ -284,6 +292,7 @@ static int fpga_mgr_write_init_buf(struct fpga_manager *mgr,
 	if (ret) {
 		dev_err(&mgr->dev, "Error preparing FPGA for writing\n");
 		mgr->state = FPGA_MGR_STATE_WRITE_INIT_ERR;
+		mgr->err = ret;
 		return ret;
 	}
 
@@ -370,6 +379,7 @@ static int fpga_mgr_buf_load_sg(struct fpga_manager *mgr,
 
 	/* Write the FPGA image to the FPGA. */
 	mgr->state = FPGA_MGR_STATE_WRITE;
+	mgr->err = 0;
 	if (mgr->mops->write_sg) {
 		ret = fpga_mgr_write_sg(mgr, sgt);
 	} else {
@@ -405,6 +415,7 @@ static int fpga_mgr_buf_load_sg(struct fpga_manager *mgr,
 	if (ret) {
 		dev_err(&mgr->dev, "Error while writing image data to FPGA\n");
 		mgr->state = FPGA_MGR_STATE_WRITE_ERR;
+		mgr->err = ret;
 		return ret;
 	}
 
@@ -437,10 +448,12 @@ static int fpga_mgr_buf_load_mapped(struct fpga_manager *mgr,
 	 * Write the FPGA image to the FPGA.
 	 */
 	mgr->state = FPGA_MGR_STATE_WRITE;
+	mgr->err = 0;
 	ret = fpga_mgr_write(mgr, buf, count);
 	if (ret) {
 		dev_err(&mgr->dev, "Error while writing image data to FPGA\n");
 		mgr->state = FPGA_MGR_STATE_WRITE_ERR;
+		mgr->err = ret;
 		return ret;
 	}
 
@@ -544,10 +557,11 @@ static int fpga_mgr_firmware_load(struct fpga_manager *mgr,
 	dev_info(dev, "writing %s to %s\n", image_name, mgr->name);
 
 	mgr->state = FPGA_MGR_STATE_FIRMWARE_REQ;
-
+	mgr->err = 0;
 	ret = request_firmware(&fw, image_name, dev);
 	if (ret) {
 		mgr->state = FPGA_MGR_STATE_FIRMWARE_REQ_ERR;
+		mgr->err = ret;
 		dev_err(dev, "Error requesting firmware %s\n", image_name);
 		return ret;
 	}
@@ -626,6 +640,10 @@ static ssize_t state_show(struct device *dev,
 {
 	struct fpga_manager *mgr = to_fpga_manager(dev);
 
+	if (mgr->err)
+		return sprintf(buf, "%s: 0x%x\n",
+			       state_str[mgr->state], mgr->err);
+
 	return sprintf(buf, "%s\n", state_str[mgr->state]);
 }
 
diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
index 54f63459efd6..be3a426ef903 100644
--- a/include/linux/fpga/fpga-mgr.h
+++ b/include/linux/fpga/fpga-mgr.h
@@ -202,6 +202,7 @@ struct fpga_manager_ops {
  * @compat_id: FPGA manager id for compatibility check.
  * @mops: pointer to struct of fpga manager ops
  * @priv: low level driver private date
+ * @err: low level driver error code
  */
 struct fpga_manager {
 	const char *name;
@@ -211,6 +212,7 @@ struct fpga_manager {
 	struct fpga_compat_id *compat_id;
 	const struct fpga_manager_ops *mops;
 	void *priv;
+	int err;
 };
 
 #define to_fpga_manager(d) container_of(d, struct fpga_manager, dev)
-- 
2.25.1


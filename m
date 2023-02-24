Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE426A1BF2
	for <lists+linux-fpga@lfdr.de>; Fri, 24 Feb 2023 13:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjBXMJI (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 24 Feb 2023 07:09:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjBXMJI (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 24 Feb 2023 07:09:08 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on20604.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8d::604])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18DF658DC;
        Fri, 24 Feb 2023 04:08:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oI1lrqzR413fwiH9RbkWoSN3fbBwUF773GPcRYzqbZZzuYtuFveMX2kLwAC4UBVDXa1TJNu3PDL55gvypErGH1JlYpCYpe4308jRIdwH+uWviq6zdhfCSGUKFFy6Bp/sOvrVqLtRSBZGdBmDmfHAvIzigfLHUrlPk6tKkP7r4xEP4PnNuLAvcNUUGXRrPwivkNoiMVYTSjioK1EdJsvNbXbsThGt2JKkfr9w/1FJpT4YOo1u4HC22auOh6wYyG/o+v9JMKqLb3sh7cLpNOuDYcKQGZ9dMsspTwhqEo2ZCOVveA1BJ0F86TirmzAyJLyRqVJk4IWSeXmVWAZwp9OO1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cIVgK7o4gWakuzK6prM7d/GiWN8vo6Rk7pyyKRAZiVc=;
 b=Gs+fUH/kyUqTx94Q18aTEbpPdhQmAos2xO8DBwSNWioWpZu31iCDBqxltiO1245wWWEgO7uaJ6O3gU+QP6nXoJWAnjWgc2fcsUFgdocsk+GB6o2sBh0/qHs+EU51E/jRKEgEBTopxp6z2Cm9E1CwEH94bSwfQbaN3ocBMDZ3CCqbcQ4EqHEXA7d5ODDza9ouqCQFpHoNkvqIbOPLJW5+6dZRIuWy5CNhXje2WxWpd3wgnCV4nkZdh7zk0POU88yONTtPLxxWNvgjtkFgHzCgFv3TjZc/DkLHzN8ocFyvkPtu1zz4F8Oa+OPqxF5tZ6DrtgNVlCIcWN401Ve/4CoJyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=xilinx.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cIVgK7o4gWakuzK6prM7d/GiWN8vo6Rk7pyyKRAZiVc=;
 b=Q2ie6aPxtHtK/7Y0FervG8tCIQE9T3TWyCKMux8O+uSTAtF0vq633leHdRDsIika2QLTzkbWX+4oFvG0oFGsbwkzfq17CqUbXd+KwG0YnPwQksS34bsTce3OT5DAFB8/seZn8rXgAfJvx1buIfxENglUdCIXBsb7cKo/APaJs5E=
Received: from BLAPR03CA0175.namprd03.prod.outlook.com (2603:10b6:208:32f::14)
 by DS7PR12MB6070.namprd12.prod.outlook.com (2603:10b6:8:9e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.21; Fri, 24 Feb
 2023 12:07:45 +0000
Received: from BL02EPF000108E8.namprd05.prod.outlook.com
 (2603:10b6:208:32f:cafe::41) by BLAPR03CA0175.outlook.office365.com
 (2603:10b6:208:32f::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.24 via Frontend
 Transport; Fri, 24 Feb 2023 12:07:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000108E8.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6134.16 via Frontend Transport; Fri, 24 Feb 2023 12:07:45 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 24 Feb
 2023 06:07:44 -0600
From:   Nava kishore Manne <nava.kishore.manne@amd.com>
To:     <michal.simek@xilinx.com>, <mdf@kernel.org>, <hao.wu@intel.com>,
        <yilun.xu@intel.com>, <trix@redhat.com>,
        <nava.kishore.manne@amd.com>, <ronak.jain@xilinx.com>,
        <gregkh@linuxfoundation.org>, <tanmay.shah@xilinx.com>,
        <mathieu.poirier@linaro.org>, <ben.levinsky@amd.com>,
        <rajan.vaja@xilinx.com>, <harsha.harsha@xilinx.com>,
        <arnd@arndb.de>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-fpga@vger.kernel.org>
Subject: [PATCH v7 1/2] firmware: xilinx: Add pm api function for PL config reg readback
Date:   Fri, 24 Feb 2023 17:37:37 +0530
Message-ID: <20230224120738.329416-2-nava.kishore.manne@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230224120738.329416-1-nava.kishore.manne@amd.com>
References: <20230224120738.329416-1-nava.kishore.manne@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000108E8:EE_|DS7PR12MB6070:EE_
X-MS-Office365-Filtering-Correlation-Id: 2321bd6d-636a-44e5-a554-08db165fbd63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6AAn+ycIio0tbC92SYOu0h8vYqXYkSnitkWNJv6gxiIThlXNl51c2wu+bQ79fMeE2Xq6PSiGOAV+B01Z6H81vVOZQPAvwL7aCQes5iuM5QmN6JAqgv2DXtEnI2bkv7ulluQGFyRwzWhof8aR3Ci4GeJq6xXvWl1QIUBveYrTe1goiA8uyVs3J+TOzLo6UhRXR7wPfq3yKqhcRmjPYgvGq6gzpn/fg6x7uZh+ER+0UrCLZocmrDkOb18gjJY+nhVprjy5NiPk/evxNHX6+t/7UiGb3+HRkRVbLbbEsjLdxsWqHhlQeSSO1QZOijpBVM1VX6T+PT2Mod89eyM2fBpIO2uk1xQt+jejsPOlWEoQ7gPpHsLxb+KpdF/q29eMUvOKUa7Dh4iwQE1Qx1QpBckZl5R3g8d31ScTOtb1xTRer6p4pBlES5h4v5P4gns76UuIM5OkSiDoKMR4J95BboI1FYDKXorq7bC5LKv4Y9Nkm3/U0t34Y6l62u5tJ7XNYCdGtuuxo3yLtf2iJCUFAFbc+NL6VYouQsJwFe/e8cWvzcDJkyhJijjL2nwtx8N9Xnj/Q7j/C3zJubzBCG9DqR0tH9C7VZ3vr31hnkrqUeQ8t702xOHRDXEOciXArIwH+hoAOC85VWNxuUnFp6hRvDUKnpJz7kJZzp8KjhnQ+/lMwGdHy6mguw7wiRscjDZH35d9T2jWPY/te9hpaKPRGaqDf2h6TVnV7U92Ij4wnsIkO88fuJeeo1gUwCP6moQ7WTOj0PvXFi5b8jxSugOHgmwxSkV2qP7XKBsh++ATnObN5LA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(136003)(39860400002)(376002)(451199018)(40470700004)(36840700001)(46966006)(7416002)(82740400003)(2906002)(36860700001)(81166007)(86362001)(478600001)(336012)(186003)(47076005)(426003)(26005)(36756003)(40480700001)(82310400005)(921005)(356005)(103116003)(16526019)(6666004)(70586007)(83380400001)(110136005)(40460700003)(70206006)(41300700001)(1076003)(2616005)(316002)(8936002)(8676002)(5660300002)(36900700001)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2023 12:07:45.7715
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2321bd6d-636a-44e5-a554-08db165fbd63
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000108E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6070
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Adds PM API for performing Programmable Logic(PL) configuration
register readback. It provides an interface to the firmware(pmufw)
to readback the FPGA configuration register.

Signed-off-by: Nava kishore Manne <nava.kishore.manne@amd.com>
---
changes for v2:
              - None.

Changes for v3:
              - Updated API and config reg read-back handling logic
              - Updated the commit msg to align with the changes.

Changes for v4:
              - Fixed some minor coding issues. No functional changes.
              - Updated Return value comments as suggested by Xu Yilun.

Changes for v5:
              - Fixed some minor coding issues as suggested by Xu Yilun.
                No functional changes.

Changes for v6:
              - None.

Changes for v7:
              - None.

 drivers/firmware/xilinx/zynqmp.c     | 33 ++++++++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h | 11 ++++++++++
 2 files changed, 44 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 129f68d7a6f5..3d8cc6795b43 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -948,6 +948,39 @@ int zynqmp_pm_fpga_get_status(u32 *value)
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_fpga_get_status);
 
+/**
+ * zynqmp_pm_fpga_get_config_status - Get the FPGA configuration status.
+ * @value: Buffer to store FPGA configuration status.
+ *
+ * This function provides access to the pmufw to get the FPGA configuration
+ * status
+ *
+ * Return: 0 on success, a negative value on error
+ */
+int zynqmp_pm_fpga_get_config_status(u32 *value)
+{
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	u32 buf, lower_addr, upper_addr;
+	int ret;
+
+	if (!value)
+		return -EINVAL;
+
+	lower_addr = lower_32_bits((u64)&buf);
+	upper_addr = upper_32_bits((u64)&buf);
+
+	ret = zynqmp_pm_invoke_fn(PM_FPGA_READ,
+				  XILINX_ZYNQMP_PM_FPGA_CONFIG_STAT_OFFSET,
+				  lower_addr, upper_addr,
+				  XILINX_ZYNQMP_PM_FPGA_READ_CONFIG_REG,
+				  ret_payload);
+
+	*value = ret_payload[1];
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(zynqmp_pm_fpga_get_config_status);
+
 /**
  * zynqmp_pm_pinctrl_request - Request Pin from firmware
  * @pin: Pin number to request
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index b09f443d3ab9..ce37d55ffa44 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -71,6 +71,10 @@
 #define XILINX_ZYNQMP_PM_FPGA_FULL	0x0U
 #define XILINX_ZYNQMP_PM_FPGA_PARTIAL	BIT(0)
 
+/* FPGA Status Reg */
+#define XILINX_ZYNQMP_PM_FPGA_CONFIG_STAT_OFFSET	7U
+#define XILINX_ZYNQMP_PM_FPGA_READ_CONFIG_REG		0U
+
 /*
  * Node IDs for the Error Events.
  */
@@ -120,6 +124,7 @@ enum pm_api_id {
 	PM_CLOCK_GETRATE = 42,
 	PM_CLOCK_SETPARENT = 43,
 	PM_CLOCK_GETPARENT = 44,
+	PM_FPGA_READ = 46,
 	PM_SECURE_AES = 47,
 	PM_FEATURE_CHECK = 63,
 };
@@ -515,6 +520,7 @@ int zynqmp_pm_aes_engine(const u64 address, u32 *out);
 int zynqmp_pm_sha_hash(const u64 address, const u32 size, const u32 flags);
 int zynqmp_pm_fpga_load(const u64 address, const u32 size, const u32 flags);
 int zynqmp_pm_fpga_get_status(u32 *value);
+int zynqmp_pm_fpga_get_config_status(u32 *value);
 int zynqmp_pm_write_ggs(u32 index, u32 value);
 int zynqmp_pm_read_ggs(u32 index, u32 *value);
 int zynqmp_pm_write_pggs(u32 index, u32 value);
@@ -721,6 +727,11 @@ static inline int zynqmp_pm_fpga_get_status(u32 *value)
 	return -ENODEV;
 }
 
+static inline int zynqmp_pm_fpga_get_config_status(u32 *value)
+{
+	return -ENODEV;
+}
+
 static inline int zynqmp_pm_write_ggs(u32 index, u32 value)
 {
 	return -ENODEV;
-- 
2.25.1


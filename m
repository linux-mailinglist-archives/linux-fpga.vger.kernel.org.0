Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5581869AACE
	for <lists+linux-fpga@lfdr.de>; Fri, 17 Feb 2023 12:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjBQLux (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 17 Feb 2023 06:50:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbjBQLuv (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 17 Feb 2023 06:50:51 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686DE66CDE;
        Fri, 17 Feb 2023 03:50:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kiInpS74RUaEoruXWtQJTDyLsZBp0FvRryJgo7mpsOpQ+VGgm0f+4e8IzFAMWbiU4XVXbWf4yQShMRM7vJrKoH89ZqJw01akgfsbWxznbo40AuP7nVDMqWQGkXCX8EgF5Tb34C8IsRIezEu1wp0zrlw9vMCffmyPE7FMMf1s4b1dCgEET+viWKd1tJ7E96xMoGcbb0587nLCU0NLqdLZHPqaxWpwvmkOZgLTrUPkAnp+jRP5t/U7haZ3vzftYadlWLXG8C+4aHjFJ1JuQ6kckmDcRjJsfrBpWTG4oc3w1kU7j3f0TlDqB61gjo/Tf83MqfjG9rgOqdUmtoNTvl96mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B5LDNf+ap8bmBeYhQUzkwcuaB4ufXivawYURPP3+O50=;
 b=nZIXMskZ+CRHYcQFzR5G3aI8ayf4TqKDv9xusW/fkSBLsiva5FvJ6Ogxy4lKMNy7fL0aJ+yx14HjjrT7StZf2SpwjHs9OY2onGI42HEqGNXl0JcCxLY7R3v3dn7w6GxunyhneWrFtUPkZ7zLVPD7t/EFkzkkutEImXkx/WD0Dr0aVDXCjhLnLbuy8DTxt05xDIgbTfeknUMnUZGhAG/X8x12m2iyLrh4LQL/UEZNorFs7MHJLoYFQ3KuHtOl1Ph8DGp1ye0V/hLiHsxeonnvUInh5zX4F8YWD5gbfcFUeleM69pDx4sClCsaoAtOW7hQKiRW/q6x9hrlaMS2q4RSww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=xilinx.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B5LDNf+ap8bmBeYhQUzkwcuaB4ufXivawYURPP3+O50=;
 b=W4tqlZARZIiDTYzBZSyGaIdEZeryuI3N4hYfC3EX6uHqVVzOOLw5AFnEwF4uDFl51VIWjBlJReRsD6UXOukyyD40tI+srNg5CbVTXPktvZngb+9l+OjQQ5wGqXZCpjtg3qDmpAoRqU+6iKiWfZ0WNT63Xpmh+t/lsAUcLbGx2DM=
Received: from BN9PR03CA0189.namprd03.prod.outlook.com (2603:10b6:408:f9::14)
 by SA0PR12MB7073.namprd12.prod.outlook.com (2603:10b6:806:2d5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.13; Fri, 17 Feb
 2023 11:50:43 +0000
Received: from BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f9:cafe::3f) by BN9PR03CA0189.outlook.office365.com
 (2603:10b6:408:f9::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.17 via Frontend
 Transport; Fri, 17 Feb 2023 11:50:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT014.mail.protection.outlook.com (10.13.177.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6111.15 via Frontend Transport; Fri, 17 Feb 2023 11:50:43 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 17 Feb
 2023 05:50:42 -0600
From:   Nava kishore Manne <nava.kishore.manne@amd.com>
To:     <michal.simek@xilinx.com>, <mdf@kernel.org>, <hao.wu@intel.com>,
        <yilun.xu@intel.com>, <trix@redhat.com>,
        <nava.kishore.manne@amd.com>, <ronak.jain@xilinx.com>,
        <gregkh@linuxfoundation.org>, <tanmay.shah@xilinx.com>,
        <mathieu.poirier@linaro.org>, <ben.levinsky@amd.com>,
        <rajan.vaja@xilinx.com>, <harsha.harsha@xilinx.com>,
        <arnd@arndb.de>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-fpga@vger.kernel.org>
Subject: [PATCH v6 1/2] firmware: xilinx: Add pm api function for PL config reg readback
Date:   Fri, 17 Feb 2023 17:20:35 +0530
Message-ID: <20230217115036.2617396-2-nava.kishore.manne@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230217115036.2617396-1-nava.kishore.manne@amd.com>
References: <20230217115036.2617396-1-nava.kishore.manne@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT014:EE_|SA0PR12MB7073:EE_
X-MS-Office365-Filtering-Correlation-Id: d6e451f2-9c8c-4b3f-18e6-08db10dd3321
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xenGZYTtst7InR1/fjKfyanVXoLIQdCmx5NEuUBeDI65sot+Ylq2JcYXnrceUkHtEduO/n7rwoFIXCPheHQkaog+/GgxJtY6HXWm0yP+bvO/so+mAYLpdjT9zBnGljs5uOWphVZOmyq09vjA/g4vDbi8Z6AI/EWgJjBpwSYZk18swDI0UabS5h9igHhwlLkTUdlbviP3BqzIYj/f7MEQ9SgM6slY+zvQ+m+BHDxglj9Ajl2Tyw8JLGc+GTNQ7FFfp3g2PBtCTIRBP9RFQmPvzfjqaK5QAWcuVASKXZN9vVF3vl1PMOhdlnClDglc953qY3W/FkMq9OOKbiZQhI49WMB5yweq/Kt2jlEIrcTFtYC3pRGMPq7r/nu/juHgzusGLiTvtHTX3h9/Yf26xp7wiwgyo5sFXe7eaLIZOKjlmnc7LgMQ9gpTe5XcuiW4NsYgjQaxPJsT6QB4RrBqRo6M5K31TLDpMG/aWJpTroHL3ry5JG0raEiPWy5JWJMhe9pq7xtdJ5jFzy4k5n7TI/6w6bonW4k4LhA96IHN3RT8RrrgtQFteJKfkrt32wtquS4a+37fpt5V8U2F+BnhKbVz9toN7R3P7T+t0UW9BVli8VHjgh4Cmr4z4H8YxPMiNfmgurpWt5Yv92dwvZmD8JAwphPXPu8UTd8IZORo2UYNtD0bD91wQVlAn5fgmmr4xeVKOispnN4a7QwVgxvz1hJr5DG201hhRpAzamVSKuqO5lQc/BxknpKEHgF1qrLMSEg/7lOoaNF5oyOK0Jpsyq7GREMVQk/fil6mbT4mKd3j3O0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(396003)(346002)(376002)(451199018)(40470700004)(36840700001)(46966006)(36756003)(82310400005)(2906002)(86362001)(40480700001)(2616005)(83380400001)(336012)(47076005)(426003)(81166007)(82740400003)(356005)(40460700003)(36860700001)(921005)(8676002)(70206006)(110136005)(316002)(70586007)(8936002)(41300700001)(7416002)(5660300002)(103116003)(16526019)(1076003)(6666004)(26005)(186003)(478600001)(2101003)(83996005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2023 11:50:43.4368
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6e451f2-9c8c-4b3f-18e6-08db10dd3321
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7073
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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


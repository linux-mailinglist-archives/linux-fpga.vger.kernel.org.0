Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97022654FF2
	for <lists+linux-fpga@lfdr.de>; Fri, 23 Dec 2022 13:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbiLWL7G (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 23 Dec 2022 06:59:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236213AbiLWL7C (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 23 Dec 2022 06:59:02 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE27D2A270;
        Fri, 23 Dec 2022 03:59:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TkLL5aLdt4fEFiFlbgBJ0hsUdXWOhTF29+yI67xVvhk0pP7ypp5ca+hB6Dx9O6hBudq8OM1W0Jq329JBJyqAiBTNg4FjiOXzvieqc4PPbShZHQmjrQ7eoHyJQitU8MBuXYfLbQCFsqMwGNsqhhyynSOKSV7TFkcZ87fVaGVq8+jN7CyKwQR2RpVVnUnhPfovNOzYM54E2jaxFeA6MkLaeysWWgdWjJbOz66cP52RnU/PLbUaRqMCFFVf14vVeefZHW4JXJPoailUeyutQnCrONtISxW6dwq2T++GZGjVh4m7O9rtwJL+Cl33huusVnKJUgtAL06Nq/vIMawRbNnU2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eKpFTELq3TQFVy6kA4P+dsv9wKc4ln+/JiLGaD+1Eco=;
 b=hyUW5EYv5xfmImm+G+AZSvlskJaHogbFFAa5aVTBDv4sF7kjNzSxQbPxR4waDotGp/06Yzy1wSL1C4MS8Jzma19LADAi0uxV56wAz4G3WisjHg0MIZmyH4w/PueaHGZCblXG5jCl9fiwrB8v3JpQ8PWPfj9YsfTRLyG20V8VldFkn4ziCTsIu5kZJulVuAeyYCFsS+mjufG5TKmLDlcFX3P/Ite9VfLakBd50xL5WDoiBnjcyH3cUXeE0x6JxJ/uorotHe7VWleJy2he/+0K+aTrTHwKa4Y6nvH+x2GSsCpbYfEEEQYcNmGyCjW3reCInMsfDDy3L8MFtPd1y/zJPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=xilinx.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eKpFTELq3TQFVy6kA4P+dsv9wKc4ln+/JiLGaD+1Eco=;
 b=h7nEFCTVgg25C4Wm5HBOG20O70vMpvV/pe1Fz8gU8DGSOqImx74wU0nPAUsiUFS0GUqryBTau6DURaAK/aX1ycLtiu2VC8tL1eP//k/heSlRqhLSwvE4ooXwDHZJJJWRYeo0puZFAsX3JBlArU+wOx6DatzCTh4VX5OBQNWTqJ4=
Received: from CY5PR19CA0065.namprd19.prod.outlook.com (2603:10b6:930:69::13)
 by SJ0PR12MB8137.namprd12.prod.outlook.com (2603:10b6:a03:4e5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Fri, 23 Dec
 2022 11:59:00 +0000
Received: from CY4PEPF0000C96D.namprd02.prod.outlook.com
 (2603:10b6:930:69:cafe::72) by CY5PR19CA0065.outlook.office365.com
 (2603:10b6:930:69::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.13 via Frontend
 Transport; Fri, 23 Dec 2022 11:58:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C96D.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.8 via Frontend Transport; Fri, 23 Dec 2022 11:58:58 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 23 Dec
 2022 05:58:56 -0600
From:   Nava kishore Manne <nava.kishore.manne@amd.com>
To:     <michal.simek@xilinx.com>, <mdf@kernel.org>, <hao.wu@intel.com>,
        <yilun.xu@intel.com>, <trix@redhat.com>, <ronak.jain@xilinx.com>,
        <gregkh@linuxfoundation.org>, <tanmay.shah@xilinx.com>,
        <ben.levinsky@amd.com>, <harsha.harsha@xilinx.com>,
        <rajan.vaja@xilinx.com>, <nava.kishore.manne@amd.com>,
        <mathieu.poirier@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-fpga@vger.kernel.org>
Subject: [PATCH v4 1/2] firmware: xilinx: Add pm api function for PL config reg readback
Date:   Fri, 23 Dec 2022 17:28:49 +0530
Message-ID: <20221223115850.2572573-2-nava.kishore.manne@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221223115850.2572573-1-nava.kishore.manne@amd.com>
References: <20221223115850.2572573-1-nava.kishore.manne@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C96D:EE_|SJ0PR12MB8137:EE_
X-MS-Office365-Filtering-Correlation-Id: 4164b4a9-1c52-4a53-3021-08dae4dd12e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5OnFMLKNUhqwd4AbcbXaMHfx4Ui716hp9TjeVhLVxq7anC9gtRqCMSii0YH7D3ZAgBY6bkPgul4/q/1p+vKbWqfdVScmkotd1d/M3ExUWiEol8rsG6MLZyeHld9vK9Um8lk4QtOh/o+Ihl9GA06oC9bhXsn9wpWL6ZgcUCFNLkcSWJFyFNX62fKVk+3YXcAktklOBgUjV4tMD5HYGiFIgGllwfn5r/hA274DTf7IOKNgrQYN0hIUFeR1rPtF/o/dge2EFO3FbTC2giZBn3iVmmRaK3kOdyacdpSufgTQKGEC+GoD1QdVhVQuiCZZ/GRnbj+EegJND4UKJ54vB663VxjT2EpOmi274jUaAFNf5n8waN35ua6Lr72pvpMzr2YawXsPbloOI5UDhDbNExxbFhlF2Z98yc31N/hVncQDYghYGEzfhOe6oZokxaLLB0gGYFMZSZKW/7fcmc0emdKbv0SyDkFDnXWZG5qR1FVkQ5lm65dRy7bzvUozMHL2BGuo0pXBbc8g8+85MoxOA0gPwGe8S+PI89sJRHaEgL7wcnpIPURynVTX7yFc0IAMfwnun70chVil/50HPPNcxP5upAKqP5CQ9B7IQjVrn2onvNg8zv2RWeaNuhBB0ALQDNR5ROtLmC4M/CEEDYWa+7PngYidgKtCcMmAZSDFDr3ca6hPBuxqxQjIuh8ItWq1lj6Y9xlwJlrwYIoENq9PiPu/Nc7oxbZ6PfnZO2Ii14wjSnYJMOoc4xhQeANnBL5MaepoZTTcsInnJucZ6jPt5VL+GLcG31BPl6HFOje9iHhuFX4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(396003)(136003)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(8676002)(47076005)(5660300002)(110136005)(70586007)(2906002)(70206006)(478600001)(41300700001)(26005)(16526019)(6666004)(186003)(40480700001)(426003)(86362001)(8936002)(36860700001)(82310400005)(81166007)(83380400001)(1076003)(336012)(2616005)(36756003)(921005)(356005)(316002)(103116003)(82740400003)(40460700003)(2101003)(36900700001)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2022 11:58:58.1167
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4164b4a9-1c52-4a53-3021-08dae4dd12e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C96D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8137
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
              - Fix some minor coding issues. No functional changes.
              - Updated Return value comments as suggested by Xu Yilun.

 drivers/firmware/xilinx/zynqmp.c     | 33 ++++++++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h | 10 +++++++++
 2 files changed, 43 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index ff5cabe70a2b..ca954e1119b5 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -941,6 +941,39 @@ int zynqmp_pm_fpga_get_status(u32 *value)
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
+	u32 buf, phys_lower_addr, phys_upper_addr;
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	if (!value)
+		return -EINVAL;
+
+	phys_lower_addr = lower_32_bits((u64)&buf);
+	phys_upper_addr = upper_32_bits((u64)&buf);
+
+	ret = zynqmp_pm_invoke_fn(PM_FPGA_READ,
+				  XILINX_ZYNQMP_PM_FPGA_CONFIG_STAT_OFFSET,
+				  phys_lower_addr, phys_upper_addr,
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
index 76d2b3ebad84..29e8964f4297 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -70,6 +70,10 @@
 #define XILINX_ZYNQMP_PM_FPGA_FULL	0x0U
 #define XILINX_ZYNQMP_PM_FPGA_PARTIAL	BIT(0)
 
+/* FPGA Status Reg */
+#define XILINX_ZYNQMP_PM_FPGA_CONFIG_STAT_OFFSET	7U
+#define XILINX_ZYNQMP_PM_FPGA_READ_CONFIG_REG		0U
+
 /*
  * Node IDs for the Error Events.
  */
@@ -117,6 +121,7 @@ enum pm_api_id {
 	PM_CLOCK_GETRATE = 42,
 	PM_CLOCK_SETPARENT = 43,
 	PM_CLOCK_GETPARENT = 44,
+	PM_FPGA_READ = 46,
 	PM_SECURE_AES = 47,
 	PM_FEATURE_CHECK = 63,
 };
@@ -505,6 +510,7 @@ int zynqmp_pm_register_sgi(u32 sgi_num, u32 reset);
 int zynqmp_pm_set_sd_config(u32 node, enum pm_sd_config_type config, u32 value);
 int zynqmp_pm_set_gem_config(u32 node, enum pm_gem_config_type config,
 			     u32 value);
+int zynqmp_pm_fpga_get_config_status(u32 *value);
 #else
 static inline int zynqmp_pm_get_api_version(u32 *version)
 {
@@ -790,6 +796,10 @@ static inline int zynqmp_pm_set_gem_config(u32 node,
 	return -ENODEV;
 }
 
+static inline int zynqmp_pm_fpga_get_config_status(u32 *value)
+{
+	return -ENODEV;
+}
 #endif
 
 #endif /* __FIRMWARE_ZYNQMP_H__ */
-- 
2.25.1


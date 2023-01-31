Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D539268297D
	for <lists+linux-fpga@lfdr.de>; Tue, 31 Jan 2023 10:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232824AbjAaJtB (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 31 Jan 2023 04:49:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232840AbjAaJs3 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 31 Jan 2023 04:48:29 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7749916310;
        Tue, 31 Jan 2023 01:48:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mAl/9aEjN5IR+X4V5hBizFHS0iBlbL25K9DCz4o6ob6xSBtUe/+ums6W2o13R71rn84GgejjGV3+3hc4vCToM0nTVnQnsztdFw8/pa5heabaJubCdT1HUQU1l/NfkS1LNbMIEF+y9RkO+7AX45ge/0MQ8jutxlH+8uUJbpjID8oCISv88VoPAS798RWVV/UiDJvhCXd5j+37p+CyjbLtm/UIIt4le9YQmc2W9+9iNbWCOuI4oPj/ZOjBl8MholKfYJ8D3zcB0ahlhK5g4NI+DOiT8MTvMFemfsd6FfuEW0F5bugpFO8NMsZrCcxkrmp2RqEPF60EquB4MieKrFzpBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7/qlEQMlwjjbM8Oyjm6juldL6i0cvXBAjK9LTAujTZs=;
 b=Vz/s/iVyHomdD8woUby5GfoEVTFYL4i7Fmsx/GBmNJ4UV805rzjdSdPdnHhYH0dqN8sAFd1IXp0CJZGg82P/lN8FzUpI7ZN7mbtmtHg9fsI1Dmi105RSi8GbLD/crOHwTOYI4CVQDnJDHLW8VkmkFpymtHFoSIeEpLicoPWOkLI+K+YW0ktUze4nUEStNaRztLlhP2iMMNG45f91C5W8/+keEcetHR2xP2sF1Cjzjo/3nb3M+up29z43L1hU9vgfRv/3lZu0JrM1VFtUi31d7gs/w7bl7QUfc+dgGyr4c6R3DRvfu022boJTMd4wXPCYuFNUJXC10AWb29M3B3Ropw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=xilinx.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7/qlEQMlwjjbM8Oyjm6juldL6i0cvXBAjK9LTAujTZs=;
 b=yHxF4jc5ew97UPsLfac7iv/HYMnq5HgxMn4tfIhL8kyhxD23ZwBUUuGEjV2Dq06ucTeRSzNLTFIv3mMr2Mz+TXX5uoAd7bU1WlrN0C1f/cvMCmZr3iynK98izsGtlp/MJFJUq4G0HCs+e3LUGVczNmpqywTcYFKALf3K4JdvjWI=
Received: from MW4PR04CA0165.namprd04.prod.outlook.com (2603:10b6:303:85::20)
 by PH7PR12MB5620.namprd12.prod.outlook.com (2603:10b6:510:137::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Tue, 31 Jan
 2023 09:48:18 +0000
Received: from CO1NAM11FT109.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::76) by MW4PR04CA0165.outlook.office365.com
 (2603:10b6:303:85::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38 via Frontend
 Transport; Tue, 31 Jan 2023 09:48:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT109.mail.protection.outlook.com (10.13.174.176) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.22 via Frontend Transport; Tue, 31 Jan 2023 09:48:18 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 31 Jan
 2023 03:48:16 -0600
From:   Nava kishore Manne <nava.kishore.manne@amd.com>
To:     <michal.simek@xilinx.com>, <mdf@kernel.org>, <hao.wu@intel.com>,
        <yilun.xu@intel.com>, <trix@redhat.com>,
        <nava.kishore.manne@amd.com>, <ronak.jain@xilinx.com>,
        <gregkh@linuxfoundation.org>, <tanmay.shah@xilinx.com>,
        <ben.levinsky@amd.com>, <rajan.vaja@xilinx.com>,
        <harsha.harsha@xilinx.com>, <mathieu.poirier@linaro.org>,
        <lakshmi.sai.krishna.potthuri@xilinx.com>, <arnd@arndb.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-fpga@vger.kernel.org>
Subject: [PATCH v5 1/2] firmware: xilinx: Add pm api function for PL config reg readback
Date:   Tue, 31 Jan 2023 15:18:09 +0530
Message-ID: <20230131094810.1945541-2-nava.kishore.manne@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230131094810.1945541-1-nava.kishore.manne@amd.com>
References: <20230131094810.1945541-1-nava.kishore.manne@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT109:EE_|PH7PR12MB5620:EE_
X-MS-Office365-Filtering-Correlation-Id: 28ce2347-0cce-4ca1-24a0-08db03704824
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jILbYNAPn2a/Q80R2tWzVedtv/S2vMsLK4Lrp6KZ6jITAIb2t6pguAhkqXKc0LsT0qeBduh0az66VT223wfs0rwyph7CD6oMFo8CwlVq8JHfgmk1POQdVu1ohxNeu4cYRAy5Mzy3yYLiaaun+OVvQyOEgjTlcOfcAi0/HwvXmISIVTGEEFYSer85w5aBtnkuyokodnFah78QRHaXiwOjixw2XYmwa/559xlitIUZMosq4CexEwcV2KQWtFII3JV+DtngltrCAwyaPw3bAG7RWshBtBWWGPW7HavxbgWP5kodg6spmcNE6k/7ZSnyORfOs97LcdG9ppAMlKbI7obouykogE2Kxtqskc4p39aokHzlQhMyXL/eJPVqULxaXNq6QEAlUvZblA42hs1l2VGU10uaUp0PggXqnIYUbV4lTtLHwaP9UR18STT3zQ7UNwKRUJUhp+QYKjuAT1HkvyZXamaKnN5J3mBnMBTFlWBwLEe9ijJjR7zwoxiE+AdkT1lz0mByYwX8FUGQ9VubkoiMdvM/c9thin7QAIvGUWzA7OYKMc6xyui6r8LpB/cOQpGNPuAL29p/DkaCg3PKtFuyCSIulnKZ6VfxgPbiQ6UFtEefu/FIQOGDnafB+6UJZbo7KSnVNIyHXSlUFxLmO6qslzfd7ybjHNVmjpIW7XBoeuxkPGPPQqGm+k1rE/o3q+X+N9taCwH6H2Bft7YtZwQI0vcOympXK+5t6L2ppLwVk35qJBWQhpMpRcu6uXGzSw0bWvKjLFU/4gp4Lo3YXQQrjJcfqrcmI4k6ie5M5mNvQc0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(376002)(136003)(346002)(451199018)(36840700001)(46966006)(40470700004)(83380400001)(7416002)(336012)(47076005)(86362001)(2616005)(82310400005)(82740400003)(356005)(921005)(2906002)(81166007)(26005)(36860700001)(36756003)(1076003)(40460700003)(426003)(186003)(16526019)(103116003)(478600001)(40480700001)(110136005)(8676002)(8936002)(41300700001)(5660300002)(6666004)(70206006)(316002)(70586007)(83996005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 09:48:18.3043
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28ce2347-0cce-4ca1-24a0-08db03704824
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT109.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5620
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


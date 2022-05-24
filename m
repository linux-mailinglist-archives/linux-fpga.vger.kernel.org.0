Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B698C5326EB
	for <lists+linux-fpga@lfdr.de>; Tue, 24 May 2022 11:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235919AbiEXJvX (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 24 May 2022 05:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235923AbiEXJvW (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 24 May 2022 05:51:22 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2083.outbound.protection.outlook.com [40.107.236.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B21B319FAB;
        Tue, 24 May 2022 02:51:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BczeKuQ2/2cn95ERgFEOljegcHbyK4VMkwp9rNCawcPWwS0UvKxoZsEDxU9g19jcVrUciFxUPHuUYG+Aw5lFKhAGtFGURyd5+fbm5IBq1ciE0zBBEYwz9uHdx3KumR+ewVvcl7s5aTmUiIpr0pXd1rwHRR/nBPlfgry+2BTQ4QbypmC9+vBHq/7Er2tEbnMk077lez9jBw/PJnsE4tT4xkX5N5Q6UglK71Z5XCY2InXgRud3nnRWI5270CNYtm2G4BJrVFZU6zXhDrDACmDuK2M/aLAi6NCzuGQZTsB4/ujtvvsWfOsgfeZJwNRU9qMjpIZC5XfDLXmkGLaDsGwLvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CSLMCHCCj+JHZNpcx0ZIcOIjJZZiUvqaWaTrm2N9kIA=;
 b=oMqDJjeUIOOG9vWFptLzONO8snM0Qo5odw/kPjwjkJ3WnqYAOgPcKXoQBxh/OLzqOSqSjBPbhkng4TZS/3GeCgj3tGn/U/+VafxbKkqiPuB/IXhwMysQZ1PS6JgIxWa7UEIwSTRJhGEXNN6R7wZ/8Ko/ziYtsXN5MPKXKwa80u2HavBnkY7ardmx6acAM4uw8ELYi4vtzyuxi+Nb0I/D10z/Ko4mIVvlBBy0KALl1RKbpaJRbgw9Jk/TCmzpuWc9VktxU4EL/e1z57g2Vd+B2Wwm30QG/JGdtIf7yxIcpnKya8vRsbtA74nl/c3SMnitGs+tkkAxa8SgcUiXVGlxPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CSLMCHCCj+JHZNpcx0ZIcOIjJZZiUvqaWaTrm2N9kIA=;
 b=GegyKzmVmaCS47p3y77YwZdytVV7k7lFGQDKVkVulQFve4vk3/3IFCgCV+vTdlW0nMXYxU/euy6ZWOCPpOyw2gLVn1izV9J14xsn0PNxx25tZi6nYI2x36ZxMdzPrkqatHlZCjjOqYz5nIAVHYXX+tOLtt++O1VqXsi/DYwM0TU=
Received: from SN4PR0401CA0007.namprd04.prod.outlook.com
 (2603:10b6:803:21::17) by CH2PR02MB6343.namprd02.prod.outlook.com
 (2603:10b6:610:c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.16; Tue, 24 May
 2022 09:51:13 +0000
Received: from SN1NAM02FT0035.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:21:cafe::1a) by SN4PR0401CA0007.outlook.office365.com
 (2603:10b6:803:21::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.22 via Frontend
 Transport; Tue, 24 May 2022 09:51:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0035.mail.protection.outlook.com (10.97.4.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Tue, 24 May 2022 09:51:13 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 24 May 2022 02:51:03 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 24 May 2022 02:51:03 -0700
Envelope-to: git@xilinx.com,
 mdf@kernel.org,
 hao.wu@intel.com,
 yilun.xu@intel.com,
 trix@redhat.com,
 gregkh@linuxfoundation.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 linux-fpga@vger.kernel.org
Received: from [10.140.6.60] (port=58200 helo=xhdnavam40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <nava.manne@xilinx.com>)
        id 1ntR97-0005Sf-JO; Tue, 24 May 2022 02:48:10 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <michal.simek@xilinx.com>, <mdf@kernel.org>, <hao.wu@intel.com>,
        <yilun.xu@intel.com>, <trix@redhat.com>,
        <gregkh@linuxfoundation.org>, <ronak.jain@xilinx.com>,
        <abhyuday.godhasara@xilinx.com>, <rajan.vaja@xilinx.com>,
        <nava.manne@xilinx.com>, <lakshmi.sai.krishna.potthuri@xilinx.com>,
        <piyush.mehta@xilinx.com>, <harsha.harsha@xilinx.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-fpga@vger.kernel.org>,
        <git@xilinx.com>
Subject: [PATCH 2/3] firmware: xilinx: Add pm api function for PL readback
Date:   Tue, 24 May 2022 15:17:44 +0530
Message-ID: <20220524094745.287002-3-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220524094745.287002-1-nava.manne@xilinx.com>
References: <20220524094745.287002-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff10153e-f106-4b5e-92ac-08da3d6af069
X-MS-TrafficTypeDiagnostic: CH2PR02MB6343:EE_
X-Microsoft-Antispam-PRVS: <CH2PR02MB6343BF3FA14C32918E5D348DC2D79@CH2PR02MB6343.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gaFzR3ThOpH+Gwm9Rlr4Yc1v6UTL1E8bCd+IXxdBDYHYsHyRNxACle6/DNitRp5X7QyWtdaQtdvgMNrGkonbfQxfULR3k0EHHk7U4UtmzAebPT1OlJZ1unjclf+jcBuLH+QU14NvEXh4UD3gjbJm6i0zOhYrvJ3HnYwpRJabpon20/yD9eUQwcqluJMVXP6XgH3zK8HAzMh+6FThnEw/2apThDEJqrM/UbXdnKXmRmtTMlhOuF6bgy0e69t3aCSEf/AVmTQNMB/qZ5M0kEW2vpyU8x89AEQtWedpFcQ7sbOnKJVRMDrscgiPZXyVFRpa2ccdHWSOIr/Z+NUEA0hvaKpryMLfJBh+xsaI6CYxaE5ks330w/yj8Fe5xkNatylxAJMJAEJjzIFrQul/UcnM5SClPy84SfaMlFBv0xjkPZAOBQQmequtC6JmA/4x4jJCVE0m8+ZDCZWlB28lKZB5gBSA0wLPcCx+YVz24iOhGNHw3pwvIF4NwktHwL8SiFo1a4zmbAgpxlFt9FV1F8NWuOYNiYd44S00Y8IJ1eRVNrIXxrVHtKTJSH27DI//yHAvcSwktg1ftFMFjWaoRilc9VwJDUN6G0ZPBcua+I4obKIWc+SSGNph14tmhY7kX450hmSM6F/thDAKMcyO4ZAWN9LZFR9M8KKMuwHDFupPB0+CD2r3zQQPpIUl9+r7idOjBTzqWl5OItzrO7JXMtrcY7YxtdZpRI5iHRCK3kzNexRB3ljDtrae0Tk8opAWZtXpuoRmxoF1vAkBeAEbOhu9CQ==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(508600001)(316002)(83380400001)(7696005)(110136005)(6636002)(7636003)(40460700003)(426003)(336012)(47076005)(356005)(6666004)(921005)(26005)(186003)(2616005)(82310400005)(36860700001)(1076003)(36756003)(2906002)(5660300002)(70206006)(70586007)(8936002)(9786002)(8676002)(102446001)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 09:51:13.4531
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff10153e-f106-4b5e-92ac-08da3d6af069
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0035.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6343
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Adds PM API for performing PL configuration readback.
It provides an interface to the pmufw to readback the
FPGA configuration registers as well as configuration
data.

For more detailed info related to the configuration
registers and configuration data refer ug570.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
 drivers/firmware/xilinx/zynqmp.c     | 33 ++++++++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h | 14 ++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 7977a494a651..40b99299b662 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -927,6 +927,39 @@ int zynqmp_pm_fpga_get_status(u32 *value)
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_fpga_get_status);
 
+/**
+ * zynqmp_pm_fpga_read - Perform the fpga configuration readback
+ * @reg_numframes: Configuration register offset (or) Number of frames to read
+ * @phys_address: Physical Address of the buffer
+ * @readback_type: Type of fpga readback operation
+ *                 0 - FPGA configuration register readback
+ *                 1 - FPGA configuration data readback
+ * @value: Value to read
+ *
+ * This function provides access to xilfpga library to perform
+ * fpga configuration readback.
+ *
+ * Return:	Returns status, either success or error+reason
+ */
+int zynqmp_pm_fpga_read(const u32 reg_numframes, const phys_addr_t phys_address,
+			bool readback_type, u32 *value)
+{
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	if (!value)
+		return -EINVAL;
+
+	ret = zynqmp_pm_invoke_fn(PM_FPGA_READ, reg_numframes,
+				  lower_32_bits(phys_address),
+				  upper_32_bits(phys_address), readback_type,
+				  ret_payload);
+	*value = ret_payload[1];
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(zynqmp_pm_fpga_read);
+
 /**
  * zynqmp_pm_pinctrl_request - Request Pin from firmware
  * @pin: Pin number to request
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 1ec73d5352c3..7dc4981345dc 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -61,6 +61,10 @@
 #define PM_LOAD_PDI	0x701
 #define PDI_SRC_DDR	0xF
 
+/* FPGA readback type */
+#define PM_FPGA_READ_CONFIG_REG		0x0U
+#define PM_FPGA_READ_CONFIG_DATA	0x1U
+
 /*
  * Firmware FPGA Manager flags
  * XILINX_ZYNQMP_PM_FPGA_FULL:	FPGA full reconfiguration
@@ -116,6 +120,7 @@ enum pm_api_id {
 	PM_CLOCK_GETRATE = 42,
 	PM_CLOCK_SETPARENT = 43,
 	PM_CLOCK_GETPARENT = 44,
+	PM_FPGA_READ = 46,
 	PM_SECURE_AES = 47,
 	PM_FEATURE_CHECK = 63,
 };
@@ -468,6 +473,8 @@ int zynqmp_pm_feature(const u32 api_id);
 int zynqmp_pm_is_function_supported(const u32 api_id, const u32 id);
 int zynqmp_pm_set_feature_config(enum pm_feature_config_id id, u32 value);
 int zynqmp_pm_get_feature_config(enum pm_feature_config_id id, u32 *payload);
+int zynqmp_pm_fpga_read(const u32 reg_numframes, const phys_addr_t phys_address,
+			bool readback_type, u32 *value);
 #else
 static inline int zynqmp_pm_get_api_version(u32 *version)
 {
@@ -733,6 +740,13 @@ static inline int zynqmp_pm_get_feature_config(enum pm_feature_config_id id,
 {
 	return -ENODEV;
 }
+
+static int zynqmp_pm_fpga_read(const u32 reg_numframes,
+			       const phys_addr_t phys_address,
+			       bool readback_type, u32 *value);
+{
+	return -ENODEV;
+}
 #endif
 
 #endif /* __FIRMWARE_ZYNQMP_H__ */
-- 
2.25.1


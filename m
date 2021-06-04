Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53F2B39B801
	for <lists+linux-fpga@lfdr.de>; Fri,  4 Jun 2021 13:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbhFDLft (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 4 Jun 2021 07:35:49 -0400
Received: from mail-sn1anam02on2052.outbound.protection.outlook.com ([40.107.96.52]:23882
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229962AbhFDLfs (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 4 Jun 2021 07:35:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BBoYKsNmBqgTZJ27Y7sKppMGDGRrAK8AWBQNQRcVsasy+6/xyKCBtWJBkxcszTDW6/NjM2PmVMj2LbVSVHUta+7fMmvmBitKNZFfSbItiufncFF8iSpg60CQRighUfUVtcd0v+apv3gNzut5Zf6QjiguCOnDfMYTU/fE7TTiCmISoXavf2FwWUh3CO5ScSNegUejiBpFTlzrBe637vk8Z8jzqj311hJeQvbZ5G+BfViV0bITl1V3mGbeg/whyX8tEuxldfvGPPsy+VYhQ9k+PmIiZytP2gxKjlLPSH+PE/BEkuI6HpmPwE9sgqIP/Zym7p4fPwrxZeoEE/xKeKLP7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/6M3AH8+0OkJrJ1tEatpCI7eEWjz/xiRoBiDefRxNEM=;
 b=RraabJP94lE4IdY656YO+HowsEY+BSz1AEGmTz7f4qosa5xseYfZB7zb668z+8UBhCrj0q9roVHfWVkdbFBfPImNjmV/QyKfvGywTShvKnUrc5BDFoNVy9rx2Yw48SFaVaGdfO2J19wShxTKmZqHx3kJpLpHZ8ByIzxhGebQV033cYoVFpbwa+WG+Ip2jfWTxaxoe8yZfdcErXBdleE8YBDTo1PMY73kfSRS6Ji9XN+jFv2fp75R7uYSool1Nnw5YwnpMCzdJwxpUKaOCZUUFv611a4r/FrDVu/SxaLku/q4PGk5BA1B+xUwdWGaUOfc+olKJZ3jQVPsemPD1wCjwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/6M3AH8+0OkJrJ1tEatpCI7eEWjz/xiRoBiDefRxNEM=;
 b=bxuEbUSarqYOSqVhOFjFOHhbIDI6mfpp9EtczNNv/wWEAluVgV2fkyTomxnDO63CXG8jDr5O/sRDeHLTljaNQbg5n6VN9w4jupGXVrt32a3vtlzdQaHWqg9aGBIbppjGvFqU43kEUIqsvCIxjRvBIZJOWVFfJWHemYqSuP4Ega8=
Received: from SN6PR2101CA0016.namprd21.prod.outlook.com
 (2603:10b6:805:106::26) by SN6PR02MB4958.namprd02.prod.outlook.com
 (2603:10b6:805:99::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Fri, 4 Jun
 2021 11:34:00 +0000
Received: from SN1NAM02FT0010.eop-nam02.prod.protection.outlook.com
 (2603:10b6:805:106:cafe::52) by SN6PR2101CA0016.outlook.office365.com
 (2603:10b6:805:106::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.3 via Frontend
 Transport; Fri, 4 Jun 2021 11:34:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0010.mail.protection.outlook.com (10.97.4.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4195.18 via Frontend Transport; Fri, 4 Jun 2021 11:34:00 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 4 Jun 2021 04:33:47 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Fri, 4 Jun 2021 04:33:47 -0700
Envelope-to: git@xilinx.com,
 robh+dt@kernel.org,
 mdf@kernel.org,
 trix@redhat.com,
 arnd@arndb.de,
 gregkh@linuxfoundation.org,
 zou_wei@huawei.com,
 iwamatsu@nigauri.org,
 devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 chinnikishore369@gmail.com
Received: from [10.140.6.60] (port=49944 helo=xhdnavam40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <nava.manne@xilinx.com>)
        id 1lp85C-0005PI-G2; Fri, 04 Jun 2021 04:33:46 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <robh+dt@kernel.org>, <michal.simek@xilinx.com>, <mdf@kernel.org>,
        <trix@redhat.com>, <nava.manne@xilinx.com>, <arnd@arndb.de>,
        <rajan.vaja@xilinx.com>, <gregkh@linuxfoundation.org>,
        <amit.sunil.dhamne@xilinx.com>, <tejas.patel@xilinx.com>,
        <zou_wei@huawei.com>, <lakshmi.sai.krishna.potthuri@xilinx.com>,
        <ravi.patel@xilinx.com>, <iwamatsu@nigauri.org>,
        <wendy.liang@xilinx.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-fpga@vger.kernel.org>,
        <git@xilinx.com>, <chinnikishore369@gmail.com>
Subject: [PATCH v7 1/4] drivers: firmware: Add PDI load API support
Date:   Fri, 4 Jun 2021 17:03:29 +0530
Message-ID: <20210604113332.1394-2-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210604113332.1394-1-nava.manne@xilinx.com>
References: <20210604113332.1394-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4fa61ff2-758e-4d35-0296-08d9274ca624
X-MS-TrafficTypeDiagnostic: SN6PR02MB4958:
X-Microsoft-Antispam-PRVS: <SN6PR02MB4958F6F819689D153DCAFD7DC23B9@SN6PR02MB4958.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:644;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VYrj0qsi3dFU3CbZk0EuQafwV96/XTE+KrtJ1xrioHVWj9fp+RUcHNHCEdkm8il/MYYt+/Vfc6oxfn96aMY48wxOdl9XYZPRJ3yoPistD1FjSyG2jVboyQbnCZCWoeW/qc4GTIZsp1sAg1w11T4bi0vQ9nO3NQFTIEEnquo6tOuDrUuyDFao7jHnHCDvwD0bAvDwxuYwIlEtsRvaTimIAEy+ihSdH+LNttlfpKIbLz42T4Av/hGlCpVnyrAIy7myxk5alWvl9jjib9izg1CjItdYK3DEnMEUlpK3XO+zI21P9oNnd0HF6peGm2meIOhlQtkmlKXSaCR612ugPM84xoc5f5Z0QrUFJ5+FPQb99pjUyS01Ot1nrvH+R1jPMA75aH5dYrjvGbvBWsB53mGEssQO5kS1PpIlAoAH2Bt691auZV4E9/i2aFrbTqcPvRfrBb6fiKFmnOUU05xxNtSvaboWNRdtgfOpFsGDZCfhQSxmNv6xTk/CltMjbN+lHZAkM0Dqd+7Hfrh0w6f+x/0TYqxFZf5ZpLSTokOdjxfHRGhfo/XOEnbLl8wVtTH3T5ixBQL7pO+iS8FYIGqT5Ue9ESNzAnjzqm3Qe78TxSuSyqgPrAKjcdOC/xxeWUi9+8zT97W2Tfuf6BNvJWPmN5FZ6aVWZbqZDPWqBVcopVrwhKrU4TghDB1hq08i+iBULo/xE/WKeLhY7XyNIZ3/U2FdQ0xjMS60YY0NR8PzCjhFJ4WCsOzJ4bRF8fKkJpZXfWbi
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(39860400002)(136003)(346002)(396003)(376002)(46966006)(36840700001)(36860700001)(316002)(36906005)(336012)(478600001)(7416002)(110136005)(8936002)(8676002)(1076003)(82740400003)(426003)(7696005)(2616005)(47076005)(83380400001)(2906002)(9786002)(7636003)(26005)(186003)(5660300002)(356005)(36756003)(6666004)(921005)(82310400003)(70586007)(70206006)(102446001)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2021 11:34:00.7171
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fa61ff2-758e-4d35-0296-08d9274ca624
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0010.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4958
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

This patch adds load PDI API support to enable full/partial PDI loading
from linux. Programmable Device Image (PDI) is combination of headers,
images and bitstream files to be loaded.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
Reviewed-by: Moritz Fischer <mdf@kernel.org>
---
Changes for v2:
              -Updated API Doc and commit msg.
               No functional changes.

Changes for v3:
              -None.

Changes for v4:
              -Rebased the changes on linux-next.
               No functional changes

Changes for v5:
              -None.

Changes for v6:
              -None.

Changes for v7:
              -None.

 drivers/firmware/xilinx/zynqmp.c     | 17 +++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h | 10 ++++++++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 15b138326ecc..2db571da9ad8 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -1011,6 +1011,23 @@ int zynqmp_pm_set_requirement(const u32 node, const u32 capabilities,
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_set_requirement);
 
+/**
+ * zynqmp_pm_load_pdi - Load and process PDI
+ * @src:       Source device where PDI is located
+ * @address:   PDI src address
+ *
+ * This function provides support to load PDI from linux
+ *
+ * Return: Returns status, either success or error+reason
+ */
+int zynqmp_pm_load_pdi(const u32 src, const u64 address)
+{
+	return zynqmp_pm_invoke_fn(PM_LOAD_PDI, src,
+				   lower_32_bits(address),
+				   upper_32_bits(address), 0, NULL);
+}
+EXPORT_SYMBOL_GPL(zynqmp_pm_load_pdi);
+
 /**
  * zynqmp_pm_aes - Access AES hardware to encrypt/decrypt the data using
  * AES-GCM core.
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 9d1a5c175065..56b426fe020c 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -52,6 +52,10 @@
 #define	ZYNQMP_PM_CAPABILITY_WAKEUP	0x4U
 #define	ZYNQMP_PM_CAPABILITY_UNUSABLE	0x8U
 
+/* Loader commands */
+#define PM_LOAD_PDI	0x701
+#define PDI_SRC_DDR	0xF
+
 /*
  * Firmware FPGA Manager flags
  * XILINX_ZYNQMP_PM_FPGA_FULL:	FPGA full reconfiguration
@@ -411,6 +415,7 @@ int zynqmp_pm_pinctrl_get_config(const u32 pin, const u32 param,
 				 u32 *value);
 int zynqmp_pm_pinctrl_set_config(const u32 pin, const u32 param,
 				 u32 value);
+int zynqmp_pm_load_pdi(const u32 src, const u64 address);
 #else
 static inline int zynqmp_pm_get_api_version(u32 *version)
 {
@@ -622,6 +627,11 @@ static inline int zynqmp_pm_pinctrl_set_config(const u32 pin, const u32 param,
 {
 	return -ENODEV;
 }
+
+static inline int zynqmp_pm_load_pdi(const u32 src, const u64 address)
+{
+	return -ENODEV;
+}
 #endif
 
 #endif /* __FIRMWARE_ZYNQMP_H__ */
-- 
2.17.1


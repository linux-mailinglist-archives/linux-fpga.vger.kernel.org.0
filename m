Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 536BD3B4F4A
	for <lists+linux-fpga@lfdr.de>; Sat, 26 Jun 2021 17:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbhFZPzg (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 26 Jun 2021 11:55:36 -0400
Received: from mail-mw2nam10on2070.outbound.protection.outlook.com ([40.107.94.70]:7040
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229657AbhFZPzg (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sat, 26 Jun 2021 11:55:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PnMDww0WPOGCeiK11Yl14PcqwGJP92rVpOXnUMZyHH9DF0vaa5D+DXDmg6Pnd0cCow/khi4DO3QKXwhvnq0HAkl4Gax4PKoUPWWxCQuypreof7MPwBNju7QY1lfPBnrjYJ9KJWzdmOzDLT+e2Hb1KmjoILY38cF6ylFtGMdcE2zthHYlbaCeptsYpjwUXrR3ZeQTBGALUY1Dza6yf5i3VkM/KPHBFJPgPHBnMpBi4FQWe2Xmf2X3zxbyYQqmdf8rkbXeCQzZ3F418hHEQsDVnWuqh80Esa9mYAyuJWrDp86zTiRkHOE6Q4+3OASTIk35K/YSyWI41c++udAD6Nts5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9CJLShNkS6bdJDMWUbG63sVgvPU2gGWe7gnSStU3vJI=;
 b=K1kqEtZJ3VQJdZn2zm+MIbeptWicNdKwo3FzvkrkL7WxhMJYHAyKaIDl1tULneSsDZhs4JUrg/qz7xa8Xz3pe4UP3/keeuCnGgl/Koenn+8jZFXemJ1LcRinZ8ktYdZiELrKshc2g3u8Ei3Y8N0aTk6SRL3lv85DWSyyD4NZ+8S5fgo0TF2XeHyaw4C1b0tJl1QCmlTsx3kXK4i3lUfbrzRMXeVFxudmsKlyhhAYTiy9h6ANKzTwnotr3kPccp9NYGSwqXcch3kqujopi0dhtiXothcPvCnn9rJsTmMC1wptvVBCDq65XBMj1ht+OdVHW7OOt6MVIF1BbjJV2iPwug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9CJLShNkS6bdJDMWUbG63sVgvPU2gGWe7gnSStU3vJI=;
 b=m6oT2s3MgkTKvF4YoY/SRDiu2/JTfacyuzqxXeloi7xsTy/ZVQqyKWeL1rQcWKQ3GC/34Af5U0T5B8ZppYAJnTxUUzf3DxpKBKE3CiMkrBjsWJfrh8mX4S6NpcV4taGeH0534/7WJxsb0HAvnvzeHtYHlifwYCI3Zhrv4oNRMaY=
Received: from DM5PR08CA0025.namprd08.prod.outlook.com (2603:10b6:4:60::14) by
 CH0PR02MB7963.namprd02.prod.outlook.com (2603:10b6:610:104::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.18; Sat, 26 Jun 2021 15:53:11 +0000
Received: from DM3NAM02FT008.eop-nam02.prod.protection.outlook.com
 (2603:10b6:4:60:cafe::45) by DM5PR08CA0025.outlook.office365.com
 (2603:10b6:4:60::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend
 Transport; Sat, 26 Jun 2021 15:53:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT008.mail.protection.outlook.com (10.13.5.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4264.18 via Frontend Transport; Sat, 26 Jun 2021 15:53:11 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 26 Jun 2021 08:53:02 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Sat, 26 Jun 2021 08:53:02 -0700
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
Received: from [10.140.6.60] (port=59432 helo=xhdnavam40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <nava.manne@xilinx.com>)
        id 1lxAc9-0000uY-6r; Sat, 26 Jun 2021 08:53:01 -0700
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
Subject: [PATCH v8 1/5] drivers: firmware: Add PDI load API support
Date:   Sat, 26 Jun 2021 21:22:44 +0530
Message-ID: <20210626155248.5004-2-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210626155248.5004-1-nava.manne@xilinx.com>
References: <20210626155248.5004-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f706569-dd5c-447d-240a-08d938ba802e
X-MS-TrafficTypeDiagnostic: CH0PR02MB7963:
X-Microsoft-Antispam-PRVS: <CH0PR02MB796370510A6EEDBFF7236E97C2059@CH0PR02MB7963.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:644;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sPF8zoJUMVrdWXcT6N+e/tOdzZcgzH+aCUCVsstKSFDmh7eDyQ3jiuG7XirttOZ6eGLsTz2Oyhhh5z+c27UKU9DWmVIsurHJUeVVOljQ2fBe6CQpu1mW34q1phmUYIutj1iZgez+Hm5s1sCD/U2l/TBNHdgq8kwlbang7WYUsViBxdeGR24/yE+ncDn/xe9+RdYdR5L07vIuUFwZXb+AFw/svl+3u2YEnWZScvo76ciIHc1uGP+SE4sffJFpksCFkKewSjJnEBFarRhO7TGJp0i1wWlnaTauoGwIwZdym2RjXpa9n9pUOtsIOw/Tw/OPOh6rLvzeTaBH2AMJYViwzHxrM6mFq2HX4k1TolZ7NRUCZZFd2OiIj/CXpyIb0VhOg8CLp0zH09AMvgQEf7TYSUFRcJScDQLZwhxZdZ1XCnt7g1DzRhJ9xJcfMkvn7nfNsELJS56rO4huycLtSOVrnV+UG5PXSHdyd7Wjc+ZrijHk9wX8s/CXWpUxG8Y4nRHW3OWtV8WU6B6xfqhgfuNfrqQRVtikmux385kmcjn8Nd/2DJYEFTO+E33BNxMpDrA0UHi4Kd1qzE46Gl0MrOVEYz5wMIijpOrOkMNIgcqeD+pITPR1miQWDkAz22reXLh30lrGPktRxE2YfTpQFn3Oxvw8IUEaUVEyQYlw5hW+B/+X8agSPH3ItgZUC3m+ZAHABkmSGvJ0psjwTM5Nu2RvjFwY4vAykQr3ZDqtn57KJzdmSLDdOIDoMKDow53iVUK6
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(346002)(39850400004)(136003)(376002)(396003)(36840700001)(46966006)(478600001)(356005)(36860700001)(2616005)(36756003)(26005)(1076003)(8676002)(8936002)(83380400001)(110136005)(82310400003)(70206006)(7416002)(7696005)(316002)(336012)(36906005)(921005)(426003)(7636003)(2906002)(70586007)(186003)(6666004)(9786002)(5660300002)(47076005)(82740400003)(102446001)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2021 15:53:11.4316
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f706569-dd5c-447d-240a-08d938ba802e
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT008.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB7963
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

Changes for v8:
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


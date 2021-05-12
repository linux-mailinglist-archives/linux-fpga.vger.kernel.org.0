Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9523D37BCDF
	for <lists+linux-fpga@lfdr.de>; Wed, 12 May 2021 14:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbhELMwd (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 12 May 2021 08:52:33 -0400
Received: from mail-bn8nam11on2088.outbound.protection.outlook.com ([40.107.236.88]:4960
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230280AbhELMwb (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 12 May 2021 08:52:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iG7wb4xiw/AcnBaTMXEwvXZlgqmEcH8Kvaiv/BkTYvqgH4UbDkXYUtapikzQEfmXQAW3YEVD0L/BbHJbVV8cOeRpUku5MGAz0thXaQjjatx6bLr677v01bUxBi7YemW889JtIcQKkxQkcM5ha1F7obIo+JoBFX030GharwESeqnxj8aD+BxvERPmx3EnDaIq0xerKQitriaT0Ahld3UVCAuKQj1Bxf+KTtmpBAToy1dqVg/YLJxK+SeJ8UbW7LQ0y//BKqaS4lkkaasvBGaUdWFqd15J0pRG0X6z2MzBnCFJ3LchNAw1CWn9Evq2NKRglBIZZFICsxxNSdWnnW9AVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6sIi3VBY9hxWN6y3jxgDEtwodJc6hAtpWU2YiJ+BxT4=;
 b=h6DJ6qpqcbHQxppvezqZIUEVyX6Txizx5ZUbgIMs8Q9m9arnMhVWYD1SzesJ2jS8PfA2Cq6TLM5USeKTAuXQRb7Z744Rj7SHO5rlP9WFXKtDLILoEf+SxqEooFXxZQ7QngdIV3vvqII1uDWlJ2MoWa2dnGIrL0xntqG/jsmA766gBdndJUv0vIUi/T/GbPTAHz/pGaxlm8XfcEA/uqWKwl5YwW3dP8em5d3Mb0GqFCvBpQq1rAx2tur5bYke+pKytWXyDLwxmiTTodqgQ7q7T72LcSSlq/sDIILoeF1IAYmg7C9WXM7Afb+iAaD3DQ/8ey1ZUvabZM0WG30Niz2Q4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6sIi3VBY9hxWN6y3jxgDEtwodJc6hAtpWU2YiJ+BxT4=;
 b=RnD/S5LUdTQWKJQ5sWz99Mo6YQQpQEaPowri54RZw2rTVfQQY62nnei9qWlkpCJOOh73lcWBnJ0WzT6LppN5xMIrttbOv1h2DOSCVGOmuJiK2wO6/1So8ZusJryCn3OJMEfLMPjyCL4XoRQtAIrI2GjMPRBP8aoo+LBj2fneF/E=
Received: from DM6PR13CA0004.namprd13.prod.outlook.com (2603:10b6:5:bc::17) by
 DM6PR02MB6252.namprd02.prod.outlook.com (2603:10b6:5:1d2::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.27; Wed, 12 May 2021 12:51:22 +0000
Received: from DM3NAM02FT041.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::96) by DM6PR13CA0004.outlook.office365.com
 (2603:10b6:5:bc::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.11 via Frontend
 Transport; Wed, 12 May 2021 12:51:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT041.mail.protection.outlook.com (10.13.5.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4065.21 via Frontend Transport; Wed, 12 May 2021 12:51:22 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 12 May 2021 05:51:01 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Wed, 12 May 2021 05:51:01 -0700
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
Received: from [10.140.6.60] (port=37340 helo=xhdnavam40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <nava.manne@xilinx.com>)
        id 1lgoKJ-0002rt-Do; Wed, 12 May 2021 05:50:59 -0700
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
Subject: [PATCH v5 1/4] drivers: firmware: Add PDI load API support
Date:   Wed, 12 May 2021 18:20:39 +0530
Message-ID: <20210512125042.30973-2-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210512125042.30973-1-nava.manne@xilinx.com>
References: <20210512125042.30973-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 20c7cec3-df7c-4b2b-a116-08d91544a511
X-MS-TrafficTypeDiagnostic: DM6PR02MB6252:
X-Microsoft-Antispam-PRVS: <DM6PR02MB62520B919403763FA9B72863C2529@DM6PR02MB6252.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:644;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rMHgWvlzB/v0pfYfLWAKfQ8BnuWDZ/lXh+beRXauZZp8bH43BOqCMhrFYTMRV4E20vsfDvEeMcAj1smPKRKZHAhPDi5jdScFS7XxFP7DzG2+h8OlVA9KqLmY0hmsqxhUV8BqICmh1KxqMPrTACnIu31GaP7ERlhj52WaCDt75WzYnzTqOvgAc7Er//Nu0bWquV3YOt/QiEzC37GP/RDG6TPBh+kqRbeqRemZZlikUIcO3pekm31OtS8QnZZuAC4PXFDc8evXnTA3No553hFbr5p4Bd7+F7ayfSiipDjhCJAN/HxwOC2HRxWceMlF7ZS8TmZ9SmCszyyIveco9AqPvfvKdZrcavTB0WnhW4wWJsZJqTjdVzk/OE2JtZ9QrzNKHOwxmDEbXO87JnLe1LWqpUY/E32Kl2w5pmJn/ZKvdpPIi1AfxTMm9VtRI6fneiPmiQFMkhr5ubGBRqQbeALChvA7ZhG0MVcvVZrHzU6JEl+B44QCg/P1wYkMYAFWc9oFFhRSEPtJOgeNSE/kQXtuHzXgYbFr54c5fMJaIgJJR2zvS5ODUeJ1osCpt9dxCJI7EQ6VtBreoPuH1SG9LiU4+9p3c4gClzDMLQHFzZ8aZr0hWb7PqpHjyezr5G93o+rO9mqkTMJE3tC6CyMLI2YccEY4sIzSN/nljF1UA3N7kkgmZCeFIoLM0jY8P3z3yfJGEMesRdGo7cgEWDNEux+iUrG3MwgFF0EHJFXFCYFt21AVulgH3r6Tm/XlJVRht56+
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(39860400002)(396003)(346002)(376002)(136003)(36840700001)(46966006)(8676002)(8936002)(5660300002)(82310400003)(478600001)(7696005)(110136005)(70206006)(921005)(26005)(70586007)(36906005)(316002)(7636003)(2906002)(426003)(7416002)(1076003)(6666004)(83380400001)(336012)(2616005)(36860700001)(9786002)(47076005)(36756003)(82740400003)(356005)(186003)(102446001)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 12:51:22.0101
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20c7cec3-df7c-4b2b-a116-08d91544a511
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT041.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6252
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

This patch adds load PDI API support to enable full/partial PDI loading
from linux. Programmable Device Image (PDI) is combination of headers,
images and bitstream files to be loaded.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
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


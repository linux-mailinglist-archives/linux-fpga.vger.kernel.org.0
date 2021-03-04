Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E85DC32CD5D
	for <lists+linux-fpga@lfdr.de>; Thu,  4 Mar 2021 08:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235993AbhCDHKy (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 4 Mar 2021 02:10:54 -0500
Received: from mail-dm3nam07on2089.outbound.protection.outlook.com ([40.107.95.89]:8001
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235951AbhCDHKi (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 4 Mar 2021 02:10:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ace6+DE3gFE71flTP7hk7eV9Q45MY4wiRqjlHFmjOP0/wogkDUzxKjyVwhY2vy0QUy2R2LilUIv8F8QbCM6m1aEWzWL4RXY4U3q16/aU/5cCKi7uQSxZFOK8trzseVD5h37IylmOlpxCXkcFsatRKfn8VdkEdNCmnOuR8usiQO1lcGuDWxRJgUwAlkQiBO5hUGhp50/sV8aUGhsEEcz1QmlLTswbX7l+r3CsYf4/PjwvvSiel3Hr1oTlz1EYLF5XhHK44NRT9TdPbJbkvz+MZCr1JKJYL+fOXwb+xIDSNiyCqjgW9E6H4KCWEPeL/kZItO+edFKT3WnmOvrAWmoe8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qT5EXLDa+KQbCrsrFzcXTWUy45PAfZvVhewx8drx8Ck=;
 b=m/IrMuo+W2/tdcJsfzH7B/FFmxxNVLLPesl7VSXxkD2jzW5egJpzaL+8w+zwP8tx4gGtFqJh2LOVYXN48CyUBwdt5gEHhWIN4lsDaXD7JU1qHyBzxPRnn8/1EX9KWwnHRMkxpvJgUSSE7qQFQ5zKXsla+tymiwENnh8z94N5NJ7oOOPWp2A3qzrS3o1WcLA+k7QXqRuK97MnNTFMsPjXgG6ou9eNaUxXDsdWqUv14VTX4RAZRfou8IwqRUOOEgHKKMSSpfMUtgLuaIXEfq0ZyKWZpswc1MXfrEtSUVk5dnfkL1MpvLBYaVjwkfKfdf8oupUe1eGuy7Ne/pL7ZCH2dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qT5EXLDa+KQbCrsrFzcXTWUy45PAfZvVhewx8drx8Ck=;
 b=NK/7DkfOKORu1nR0PCopCc2YprMFQB2S1tOctQ7GacuwkV7AQxfJJGYJtLF35spNmhgNFQRELdy5uE1qHf+bh6oLn0EYo5AB4Sgw6RGU6ayBYWEOVcJp9UhzwG6EnbkyxuMCE3P6AdCgusQD8YooKZay/D1CCAm2umhp3GKyai8=
Received: from BL1PR13CA0001.namprd13.prod.outlook.com (2603:10b6:208:256::6)
 by SA0PR02MB7130.namprd02.prod.outlook.com (2603:10b6:806:ec::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Thu, 4 Mar
 2021 07:09:41 +0000
Received: from BL2NAM02FT047.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:256:cafe::50) by BL1PR13CA0001.outlook.office365.com
 (2603:10b6:208:256::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.13 via Frontend
 Transport; Thu, 4 Mar 2021 07:09:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT047.mail.protection.outlook.com (10.152.77.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3890.19 via Frontend Transport; Thu, 4 Mar 2021 07:09:40 +0000
Received: from xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Wed, 3 Mar 2021 23:09:39 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Wed, 3 Mar 2021 23:09:39 -0800
Envelope-to: michal.simek@xilinx.com,
 rajan.vaja@xilinx.com,
 manish.narani@xilinx.com,
 amit.sunil.dhamne@xilinx.com,
 nava.manne@xilinx.com,
 mdf@kernel.org,
 trix@redhat.com,
 robh+dt@kernel.org,
 gregkh@linuxfoundation.org,
 arnd@arndb.de,
 linux-fpga@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 chinnikishore369@gmail.com
Received: from [10.140.6.60] (port=51424 helo=xhdnavam40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <nava.manne@xilinx.com>)
        id 1lHi79-0003nC-4t; Wed, 03 Mar 2021 23:09:39 -0800
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <mdf@kernel.org>, <trix@redhat.com>, <robh+dt@kernel.org>,
        <michal.simek@xilinx.com>, <gregkh@linuxfoundation.org>,
        <jolly.shah@xilinx.com>, <rajan.vaja@xilinx.com>, <arnd@arndb.de>,
        <manish.narani@xilinx.com>, <amit.sunil.dhamne@xilinx.com>,
        <tejas.patel@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <chinnikishore369@gmail.com>
CC:     Nava kishore Manne <nava.manne@xilinx.com>
Subject: [PATCH v3 1/3] drivers: firmware: Add PDI load API support
Date:   Thu, 4 Mar 2021 12:32:22 +0530
Message-ID: <20210304070224.22346-2-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210304070224.22346-1-nava.manne@xilinx.com>
References: <20210304070224.22346-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5219ebc0-d279-4d5a-18cc-08d8dedc7b07
X-MS-TrafficTypeDiagnostic: SA0PR02MB7130:
X-Microsoft-Antispam-PRVS: <SA0PR02MB7130CD3D5B74E655AF32BE99C2979@SA0PR02MB7130.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:586;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6NKFX2CoZ+5dRDYRxw55Y5rNAOcz0dQgCycezq0ld6L1eEDSog8NlZqTywBsMRT7aVOs/utTgUA+Ue4WUbc7/4VQQd3zG6/sZ4qbDnpsFTzJ9GFWw7wqqcRIlA5k8V1qrapaAhoPBvOEbWS/L3X7huXonz+h5ENH6ejfcatnzcrYuvykZJryDKeZeEN+VmNW1UBKGooVEM6MMdOm2eId6h0B9FbnmFGzv0BdyA9yjo9LAwbww0xgQRYSoBtj6hqq2kLPlqjlhxFmZkP8jHkWfUvya89wLMIz6uyH/0lO1LS8W+ckZQ1YJE8Q6uCl34CJrPuF5xuq+ZLtKLEnrnWOg7JLaq6IXVs83vWOm9A6pvS0Pzq/bpLCl1tTGaUdDfd95paZDPx/XBZL22MiOb7A6O4NHZIhH7Ss0b0T3+Zc8Lx0HWr0YzbwKjcXLSDW0ZnF6ClXjxOS44kk0N1TXUpt3I2SDzx9nl+h8OldcK5sYClUu4a08hLRtmxEfk1BQKyuMQCLq6bysj4tD/lUatxij/jQffevZWtJbtsxqojS9uYlNAG8cRxxQN0gP6T4ilqotP2uPpBMssutu996mA0O55W1gdOSMR30YFSRrn1xtUugNlgvb/mDL1XTt2/T21kWlAWN6dMPS150C7Rj2FwXLRPSfvddqVNwk4PWkQkzoKodgTTMS7pFwqKwZCuvon8dJD2/bhWA0ubhmMlA/4Y5SkwRvzkyFpt4ntGp4BSZEyoKP+hYT1TFePIOPl1Vlggd
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(39860400002)(396003)(376002)(346002)(136003)(36840700001)(46966006)(5660300002)(82310400003)(107886003)(36756003)(7696005)(478600001)(1076003)(110136005)(26005)(8676002)(316002)(4326008)(8936002)(186003)(2616005)(6666004)(36906005)(2906002)(336012)(921005)(36860700001)(70586007)(82740400003)(9786002)(426003)(47076005)(356005)(70206006)(83380400001)(7416002)(7636003)(102446001)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2021 07:09:40.9749
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5219ebc0-d279-4d5a-18cc-08d8dedc7b07
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT047.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR02MB7130
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
                -Added PDI_SRC_DDR macro in the firmware.h file.

 drivers/firmware/xilinx/zynqmp.c     | 17 +++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h | 10 ++++++++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 7eb9958662dd..9ee02655db89 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -897,6 +897,23 @@ int zynqmp_pm_set_requirement(const u32 node, const u32 capabilities,
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
index 2a0da841c942..3eba9d5c7640 100644
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
@@ -354,6 +358,7 @@ int zynqmp_pm_write_pggs(u32 index, u32 value);
 int zynqmp_pm_read_pggs(u32 index, u32 *value);
 int zynqmp_pm_system_shutdown(const u32 type, const u32 subtype);
 int zynqmp_pm_set_boot_health_status(u32 value);
+int zynqmp_pm_load_pdi(const u32 src, const u64 address);
 #else
 static inline struct zynqmp_eemi_ops *zynqmp_pm_get_eemi_ops(void)
 {
@@ -538,6 +543,11 @@ static inline int zynqmp_pm_set_boot_health_status(u32 value)
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
2.18.0


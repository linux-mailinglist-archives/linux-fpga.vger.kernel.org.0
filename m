Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8D436EC03
	for <lists+linux-fpga@lfdr.de>; Thu, 29 Apr 2021 16:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240094AbhD2OHu (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 29 Apr 2021 10:07:50 -0400
Received: from mail-bn8nam12on2047.outbound.protection.outlook.com ([40.107.237.47]:63584
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238595AbhD2OHu (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 29 Apr 2021 10:07:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RDq/PdyDGEO8PmbmfQ6RswS4YQozurRV9YicHwNYW0G4gmowraZTgfNP9qA3oHr6R3aUwnqNQrT5zHZ5TvNWG7UCg79r+cDkXYVoCqG1AL9IHSQaiN3Mjh2ZTG4+z9+FwvfdnCU6zP3VfgMoJtB+1JXgKpmwJsMUX5HqOyo0ZNJcDyZyAGjhkGZ3+slaVm1cJuruRnMxtMlIIiSp6XSZXRD1gBoAq7uwFyNUcqcTX50vGujr/uN4ElZmg+rEDRMR+hnAcaxJ+7jMtw4y3xrZESiFCa86tg/NzHSA1kXaoA3yN6deFK6h5HMjlhUCTzyNZ0rBnmh6qLQbuicjtBZM/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7zCgW9U225S7Y7LVJoBpoidULNHzSCc23aAW0PEUeE8=;
 b=TMT0i/yUfKUWbZAkU120bUGQamqWi4/WT6hggucqCoaH7Ozi8uEuzPy+DsuY/ua6JKBC5G2SyyfYfadVB8x+dgqDHofiNIugXcDti2/GucRamfXm4rfrCjAdUtKKRUrcFRTJJRSj85+wGN0DugtsXw8OhPNInHYYRd+d3pPF8G8e2fCy2uwke8JE+m29VaRRjrLXkVXETse4VdLeRLhrJVgdZSwOhJgwwmIEe53vk5Q79dntuNVX2OshqGg3EDwUiQn6jmk7tMg+s+inNgKXrG66Zb87RKlKWh4y+zODK81AvuVi3dQVOugNE/UzxIL6LGOGEG5CV69HxqXDHyih3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7zCgW9U225S7Y7LVJoBpoidULNHzSCc23aAW0PEUeE8=;
 b=aFr4kY9P6gRcJsjccpgz3e0hi0hi5hZGUb/FIk/U4HuJTd4AceixYL8fmiFyDSnWva4gim1lczzBLdJZ9EEFTVAzFvbuzcCUgYCqK7nPZFGYYAJd8Abp91UN+mRE+owm9QvlJqSol5vxERw4CEL1NoZ1Mgzk+WPlxBxArryOdso=
Received: from BL1PR13CA0146.namprd13.prod.outlook.com (2603:10b6:208:2bb::31)
 by DM6PR02MB5179.namprd02.prod.outlook.com (2603:10b6:5:44::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.24; Thu, 29 Apr
 2021 14:07:00 +0000
Received: from BL2NAM02FT018.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:2bb:cafe::c1) by BL1PR13CA0146.outlook.office365.com
 (2603:10b6:208:2bb::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.8 via Frontend
 Transport; Thu, 29 Apr 2021 14:07:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT018.mail.protection.outlook.com (10.152.77.170) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4065.21 via Frontend Transport; Thu, 29 Apr 2021 14:07:00 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 29 Apr 2021 07:04:28 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Thu, 29 Apr 2021 07:04:28 -0700
Envelope-to: git@xilinx.com,
 robh+dt@kernel.org,
 mdf@kernel.org,
 trix@redhat.com,
 gregkh@linuxfoundation.org,
 arnd@arndb.de,
 zou_wei@huawei.com,
 iwamatsu@nigauri.org,
 linus.walleij@linaro.org,
 devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 chinnikishore369@gmail.com
Received: from [10.140.6.60] (port=60740 helo=xhdnavam40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <nava.manne@xilinx.com>)
        id 1lc7HG-0004zS-Vp; Thu, 29 Apr 2021 07:04:27 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <robh+dt@kernel.org>, <michal.simek@xilinx.com>, <mdf@kernel.org>,
        <trix@redhat.com>, <nava.manne@xilinx.com>,
        <gregkh@linuxfoundation.org>, <arnd@arndb.de>,
        <rajan.vaja@xilinx.com>, <amit.sunil.dhamne@xilinx.com>,
        <manish.narani@xilinx.com>, <zou_wei@huawei.com>,
        <lakshmi.sai.krishna.potthuri@xilinx.com>, <iwamatsu@nigauri.org>,
        <wendy.liang@xilinx.com>, <linus.walleij@linaro.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-fpga@vger.kernel.org>,
        <chinnikishore369@gmail.com>, <git@xilinx.com>
Subject: [PATCH v4 2/4] drivers: firmware: Add PDI load API support
Date:   Thu, 29 Apr 2021 19:34:06 +0530
Message-ID: <20210429140408.23194-3-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210429140408.23194-1-nava.manne@xilinx.com>
References: <20210429140408.23194-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 792f7825-d9d5-490e-df16-08d90b180f02
X-MS-TrafficTypeDiagnostic: DM6PR02MB5179:
X-Microsoft-Antispam-PRVS: <DM6PR02MB5179DA95DFE91E368B2CCDCCC25F9@DM6PR02MB5179.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:644;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uEuUqkcFCZlChJM+EN6SHuoVJ8oOqg4N8ALyJ02Jlinu7SGF1TVOiphZTEDkZzWHo7ONS7IMNDEdCKcTD/IoxDfAuZDr56nV0bKmsNdXJjWMgRejt7VPJcuwMdncZsQZtqEq14dvua5vH0vKUU1XRckFUdQEEoqSwXuJ1ZdgbaqW3BoNS974sN9sjFzfR6/aDt6ZsC351fLX/eKSd8naeVHvQ6PIGDpK3ouID5iqQgG9+LZ/sl6rBFsTLCJadkm5QaDZRieBa0Ex+lrZTNp5wL2E24ED85HpMjVMlxSYXM7L2i6GlZ/09vXNB47O4Nq3U9TkheOYv6QJZ7SAsf3Phmv9ZJFwq1vLZFTvx7v5XC8qQGd8B6UO8SGD0lAyEF8rZxCI4BM6sfWQ/42QoxZDhzcM4fVKePwZg/6Q/EX2o8mYaRyaZHvdi55gc6yRUN9s1hgj2djRnpru65huo7hRL5Z4/GvNyqgnTlu4SHFXc0DKhf7Q7Cqk7bDlfC/Pq+9DeTPtWuwEc/HyWUQWezH2JLkGUj63nDOOSL7l26VikzrHIPpHwCDhc09wt/9f8KdGeYWxJN4GVmcRn99PtwES1fNkdCKZne9bropwMLyIjG2ehlQBCZSUpXVe01Id+Z9KWjWsM/xVBE5DjrNQD4vyXQXKpeS+hsV0GKNi4bGLUuI2I0QTDv/EVN/KEOhc8+unVKSSwnujM1jloIK/cZ2sf6NoX877UypalKCBTrZ++7hVkfcbV0w/QQykoGfWlLEp
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(346002)(136003)(39860400002)(396003)(376002)(36840700001)(46966006)(110136005)(6636002)(5660300002)(2616005)(9786002)(478600001)(186003)(26005)(82310400003)(336012)(6666004)(1076003)(83380400001)(356005)(7636003)(36860700001)(82740400003)(921005)(36756003)(70586007)(2906002)(8676002)(426003)(8936002)(47076005)(36906005)(70206006)(7696005)(7416002)(316002)(102446001)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 14:07:00.7213
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 792f7825-d9d5-490e-df16-08d90b180f02
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT018.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5179
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


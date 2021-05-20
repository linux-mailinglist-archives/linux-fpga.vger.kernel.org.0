Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1A01389F7C
	for <lists+linux-fpga@lfdr.de>; Thu, 20 May 2021 10:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbhETILl (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 20 May 2021 04:11:41 -0400
Received: from mail-bn1nam07on2084.outbound.protection.outlook.com ([40.107.212.84]:45187
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230440AbhETILl (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 20 May 2021 04:11:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y8xv8qpw60GrOGxHTe/kkuwi0g10/+KmNF1DyOSxVrRwhQQiUqf3B7H84CKs1tRzPdiBvLxb84sNi7+UGw5FBDHrQrtOArKkkiI5McZZgbB7FnXDhN/cOXdz+znfYMWjeaF7MAxkurIp1OX12ncOVXZf3WvEZ0rlWCOXIf0J5xmifOJ+XM9yFQNJHKfdT/hCiodHjLOrlvgNHhJofwrAvcGg41EQKxtD/Eq5+21CumQHRWUBziLVr5B7lz57fsBbFEi9PfPbNnBC78Edap453gwI9azMx73ED3+B+FI1HCFp5Zli+z9nVxVN1XAq4SqJ0BGp5Gk2ZPOH/p5ZJq9Mxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OXm2U9CL79e/31gvYG+DVVosvirA8jzcp39gEJ9Cd+A=;
 b=QUJ9QuhBtae4n2+BkEvbKQ4Z+sN0TC2gN2ENur0JMtSuxJuWn3YPdAfhV8W51x2CApSTO8m+B80vOJAqxk68xNe1f50ZIziwYxTz3xMEqVwCE2ghz4aJaldMOSnA2EHN7p3lNeaAY0n0vYH47u6UIsq7lSbZQZAwxM9YT63tjiyCRejHvxfukv/gUeueTlX7WtrWS8er3JTcgcNFYn9nj//7AdmHxh8d39o094lxWWEPPeoFCaDI2T4R9GqXazT5Tfb/kv/Rj0G98QynPtbKU7GL9HkkcUaK1CGUSGH7sJqtRTAEkC/kZh0/kvf5Akp5EsHplzbPLZcE6yjwr9Wqmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OXm2U9CL79e/31gvYG+DVVosvirA8jzcp39gEJ9Cd+A=;
 b=T/cV9xeDk75Lnvi10nTDovyQZ+XNayzOux93su7BuDDSv9XpMh3wqV3lGzpd10EGf1/lGBh1RfQ88tiyW4jLVpBRk+gKvlsokjxOrUYj/xwk1Eemfzhshlq0hx6R1mnS9bDIOXjux5AMoZR7BZSL7vuMHMLkgjy8UpXFvBlAjgo=
Received: from SA9PR10CA0010.namprd10.prod.outlook.com (2603:10b6:806:a7::15)
 by MN2PR02MB6910.namprd02.prod.outlook.com (2603:10b6:208:20e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Thu, 20 May
 2021 08:10:18 +0000
Received: from SN1NAM02FT0030.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:a7:cafe::5b) by SA9PR10CA0010.outlook.office365.com
 (2603:10b6:806:a7::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.33 via Frontend
 Transport; Thu, 20 May 2021 08:10:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0030.mail.protection.outlook.com (10.97.5.194) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.27 via Frontend Transport; Thu, 20 May 2021 08:10:18 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 20 May 2021 01:10:09 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Thu, 20 May 2021 01:10:09 -0700
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
Received: from [10.140.6.60] (port=42624 helo=xhdnavam40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <nava.manne@xilinx.com>)
        id 1ljdkt-0007IV-MN; Thu, 20 May 2021 01:10:08 -0700
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
Subject: [PATCH v6 1/4] drivers: firmware: Add PDI load API support
Date:   Thu, 20 May 2021 13:39:51 +0530
Message-ID: <20210520080954.1393-2-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210520080954.1393-1-nava.manne@xilinx.com>
References: <20210520080954.1393-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac3674e7-02a6-4e25-1780-08d91b66b4a7
X-MS-TrafficTypeDiagnostic: MN2PR02MB6910:
X-Microsoft-Antispam-PRVS: <MN2PR02MB691099CD9E24FE1BBA57733CC22A9@MN2PR02MB6910.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:644;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qIxnJQsAOCeKJ6WN7jgj/Jj0Rl1O3ockvlVdfVWNoCXu920Qg8D4apOVKWEzivojkD5NvTwntO4IAfrVBZJeq0dB+dqbRmiNN9ATo8O6jvpAaYp57d5RMBu0F5Lxif9iWBeMtE8M6Vrg8IdGBkK9mU7dX3hVClxxyk2rIIouNlQybT7uvYD9SUnA8EP6b1L7IavFPDQ3lXLPN4Bmz3cNHMNnKClzul0HaXjdXrhtb+CEMiopAlrggenQanwi7avfAfVj5vNITyr4GrLV+nqBJcTY3psoyx0QMVzNwIgGN3Ky1AY6+10SbU9mdlddcUsTmVQfB7wW4oaC1XDy8/lhxPDckTpFcAVAQYc3HTHXxOTGUIKsz41akV5fINa1R343RjFAOnLmNbhAY6L+QUHcQBymXycQD1W1BJceeP7OuPs3g28RKldUSzELz+CNtKXxiBK77VZhqFombPkAtC9Z9LpyXI2wTGbk9oKklrfxhkmuqrJolL9U4H9TdgNBlqXlSjIXn66TR0YIRkDo3wL+RTDi4qfQDtnkjYfxw8x9qe1bG0pXP3kZPs8zmaqMFePPD23tpnmFJqDBr/yh8z+TOiJOQ4Y3M7MlPn6J+KDCB6+KisoloNtu/3UMjN1vCLbT5P58zbR+yAKDTFYo3Q+YkTjOyh7xBqEGaEQGKKMnZT4FGjWd5IwTP4vlvexI6TMWiJQURw0sux+/LD+m46XVWDXfPOszCPHp191Hskj0b17WxrsyPTmQ0DUyvkex5eW/
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(39850400004)(136003)(376002)(346002)(396003)(36840700001)(46966006)(70586007)(316002)(336012)(26005)(7696005)(9786002)(6666004)(2616005)(478600001)(8676002)(921005)(70206006)(7416002)(356005)(82310400003)(426003)(36906005)(5660300002)(110136005)(186003)(47076005)(83380400001)(1076003)(82740400003)(36756003)(8936002)(2906002)(36860700001)(7636003)(102446001)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2021 08:10:18.0299
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac3674e7-02a6-4e25-1780-08d91b66b4a7
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0030.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6910
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


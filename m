Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E925731851B
	for <lists+linux-fpga@lfdr.de>; Thu, 11 Feb 2021 07:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbhBKGNp (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 11 Feb 2021 01:13:45 -0500
Received: from mail-bn7nam10on2041.outbound.protection.outlook.com ([40.107.92.41]:60289
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229639AbhBKGNb (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 11 Feb 2021 01:13:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bH+iqJR2jJaZRMWHH6jqFIGuU0C1nF7LHEdIoIwOet9gyS8fXAuvqCkfVw15KZ96fLpCOzH8eb0yke+cN4j7TKlUUaXbCJbAjDqOI69HDCTGlg5Kw4nb5ExvYkdv4oSvI048oZDHoldcBqFZclj+9j51Vdao+NzbyonPh59acd0v82Ql2UEm6ar3zmKEJCYeTKhnw0f73zy4xJhq2J7uYEsKxlQbHrs+i8uVO/ApAuYf82VXxicrIfBo8EFS14vkA0X7Gjf9TPnZqXBGErPOzdNLuVX1cjjn5YU7HP8dVqJRo0QzGUHJ4W+X1RlVYQEhazKlP4k3LGIdR9yJKDd81Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WMorSuOMuxl7J4Q2UWXp0Po/D+qd0BSJX2+jOm3Eb+E=;
 b=VkVS2KHs+rITpMvRDXcF3WXnEwyibSv76TjXRkD4QOSZrXhvPkNVjiNTBgcMOOn5521MjCYwOhJYQh0oLVglfpQUGbM3b2hVEDFWAk56kVxvF6MAW5mhXDnsbis7jk2N4C6QYldNRWgNOXcIAMTvTA8SvUrcAHDnlczdbzRxmiMyQSl6H3z0ikj/TyxAHsNZet9pN/I2OwPRRYHDoxQjO8gWjabvmgr9uN+Rm/j9vfjeJuceWayCdDCGpETpIc1y7DpbuzPLAu6vQZ0Tf4C9jkrhDy7TWsr6X5IRdxY29o9pzcCIItuN9rtyYM1K1gZaC+Lksh7DkEPFcZejolBy4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WMorSuOMuxl7J4Q2UWXp0Po/D+qd0BSJX2+jOm3Eb+E=;
 b=N82RF1uH8HxBsU44J3gAjzJlgNQjMoPv0L4Qq/cuHuUWxxHrOhH+2iCcVY6pYT9DuTiWIwp4Ch/YQNULB2eWMO3mn9AVqrOEHqBw/hbY/tZTNMHGq91JsJxfV93MS9xRW6aGmrAbXnZNpoXmnCNnyvjuEi7jPd5O5m5rxsIe48Q=
Received: from SA0PR11CA0208.namprd11.prod.outlook.com (2603:10b6:806:1bc::33)
 by DM6PR02MB4986.namprd02.prod.outlook.com (2603:10b6:5:4b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Thu, 11 Feb
 2021 06:12:38 +0000
Received: from SN1NAM02FT032.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:1bc:cafe::d7) by SA0PR11CA0208.outlook.office365.com
 (2603:10b6:806:1bc::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25 via Frontend
 Transport; Thu, 11 Feb 2021 06:12:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT032.mail.protection.outlook.com (10.152.72.126) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3846.25 via Frontend Transport; Thu, 11 Feb 2021 06:12:37 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Wed, 10 Feb 2021 22:12:19 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Wed, 10 Feb 2021 22:12:19 -0800
Envelope-to: git@xilinx.com,
 michal.simek@xilinx.com,
 mdf@kernel.org,
 trix@redhat.com,
 robh+dt@kernel.org,
 linux-fpga@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 chinnikishore369@gmail.com
Received: from [10.140.6.60] (port=34116 helo=xhdnavam40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <nava.manne@xilinx.com>)
        id 1lA5D2-0001Jy-48; Wed, 10 Feb 2021 22:12:12 -0800
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <mdf@kernel.org>, <trix@redhat.com>, <robh+dt@kernel.org>,
        <michal.simek@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <chinnikishore369@gmail.com>
CC:     <git@xilinx.com>, Nava kishore Manne <nava.manne@xilinx.com>
Subject: [PATCH v2 1/3] drivers: firmware: Add PDI load API support
Date:   Thu, 11 Feb 2021 11:35:30 +0530
Message-ID: <20210211060532.23662-2-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210211060532.23662-1-nava.manne@xilinx.com>
References: <20210211060532.23662-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee95c900-8b43-4f91-0f48-08d8ce54080e
X-MS-TrafficTypeDiagnostic: DM6PR02MB4986:
X-Microsoft-Antispam-PRVS: <DM6PR02MB498650B972CA09392F3438BBC28C9@DM6PR02MB4986.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:462;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: baYwksb9b46Hs43yWdBDOkU1i1MNIu9WGzhDwlBG/Z0+dAzA3YLuhhcryT/bmNs7oKvVH4iHJzJeTsf/cwfsk4Idtw0CEPZN6YYvu3byBh9wRkrYcv1tMIkaceH4hN9yeTAeXcyGMYbinkASvsEBCCaMAc/TPsQsPfYUkdzA+TzFv99/YjbvUWoFoP/qKorr8+VX2VYwMVdbjaBcuFSNPV5Pw1RjVpdHvVtREZJOAAtpGS+v8YYPJMYKC0KA66oqgEHo+n/+9Bk+z1wnlzL5KPE+kfZZAGocCHVztJOTWjaR2RVUmxoaIqFe42rvb2fUHCZXo45Ex0bsOf3oh11nJk/Knwx9VwT7ctvGg/cM1hLz+7nwyRv5jenG2i2opi2gtxvzPwHh9L9d6aYzu7JeCQ7Ys5nAqqYC4SOD9wH4kbnsDZR7LwUMXeVbWLgb8rFMGQC2Xbuz/C85bDd1jZ2S21fl8qK0c1MVvyJalujuB/OKUgE7/ttmIzTWdzMzWr65fVCvwg5S5eCn8IP7JdcPB/dvbaU4GnConverqiqs68LQ+f8Gr2xkFIoe98sci0xbft0xVTyZSGfvrD4B2cZfkgRwfzHFp9bp9F4f7weWbHsexpIel0Nm37hm7ixhPOgAiItLws5bPVS7phlQaDE3CVOaaMcVBGJT/F25XiyAhggkHjeL34H5inuzaG9DygqbSAZL8mIYNg15sv9PJpzWPA==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(396003)(346002)(136003)(39860400002)(376002)(36840700001)(46966006)(6666004)(9786002)(186003)(7696005)(83380400001)(26005)(356005)(1076003)(107886003)(8676002)(36756003)(82740400003)(82310400003)(2906002)(36860700001)(54906003)(47076005)(4326008)(2616005)(110136005)(336012)(316002)(36906005)(7636003)(8936002)(426003)(478600001)(70586007)(70206006)(5660300002)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2021 06:12:37.9819
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee95c900-8b43-4f91-0f48-08d8ce54080e
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT032.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4986
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

This patch adds load PDI API support to enable PDI/partial loading from
linux. Programmable Device Image (PDI) is combination of headers, images
and bitstream files to be loaded. Partial PDI is partial set of image/
images to be loaded.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
Changes for v2:
                -Updated API Doc and commit msg.
		 No functional changes.

 drivers/firmware/xilinx/zynqmp.c     | 17 +++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h |  9 +++++++++
 2 files changed, 26 insertions(+)

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
index 2a0da841c942..87114ee645b1 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -52,6 +52,9 @@
 #define	ZYNQMP_PM_CAPABILITY_WAKEUP	0x4U
 #define	ZYNQMP_PM_CAPABILITY_UNUSABLE	0x8U
 
+/* Loader commands */
+#define PM_LOAD_PDI	0x701
+
 /*
  * Firmware FPGA Manager flags
  * XILINX_ZYNQMP_PM_FPGA_FULL:	FPGA full reconfiguration
@@ -354,6 +357,7 @@ int zynqmp_pm_write_pggs(u32 index, u32 value);
 int zynqmp_pm_read_pggs(u32 index, u32 *value);
 int zynqmp_pm_system_shutdown(const u32 type, const u32 subtype);
 int zynqmp_pm_set_boot_health_status(u32 value);
+int zynqmp_pm_load_pdi(const u32 src, const u64 address);
 #else
 static inline struct zynqmp_eemi_ops *zynqmp_pm_get_eemi_ops(void)
 {
@@ -538,6 +542,11 @@ static inline int zynqmp_pm_set_boot_health_status(u32 value)
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


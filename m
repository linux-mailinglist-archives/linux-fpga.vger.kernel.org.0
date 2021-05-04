Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34FB23728C4
	for <lists+linux-fpga@lfdr.de>; Tue,  4 May 2021 12:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbhEDKYA (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 4 May 2021 06:24:00 -0400
Received: from mail-dm6nam12on2081.outbound.protection.outlook.com ([40.107.243.81]:5185
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230292AbhEDKX5 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 4 May 2021 06:23:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EAhw10TNhwplN3FqbBCKmUBNLoiLF+gjlYYBt2m94F9Hk8S5msaly7euCcPBqbDa3M+67UCOi9mub3wqKUeLuLcPbkHKZDKPUMmOIPV/RplYtvLN/prC1oLKuA6CVo8XKh3jTrGNx02+lDPft2lQwHZrjv+CXA8BibE/3RSjLylYDl9tLCOP2wWNFwmRXHApZackUu4EbUN6dFhiwq5w5debBSgX1TeRTbdcegkOD7AxOfV16zhMJ2eFLRGdePmSTVcnMNkR6iXpPcVo2vAyVBKu5jlx6ulO2ab7W/AE+H3m7sBM2U0drQ/WSOByh5qA+U76urhPZNmMv8rIrYP5EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CwjIuvfXMMaQ3a5UCdmXr54nHsAmdLP/Ek8WTnpW8rw=;
 b=Am+77hGwLg8/5otF1ik0LYmsolJCmtMrN4ru4rRNnHPHgvyBTAHXAzaILKi9wkmXIKG1hNmEG/vDn7UsoM7jg7gZHNMxCkiTZBbA/cEgBWH93vXYgSYcmuNQsH2u8UHCpIkH6P7PvKlzy1i9geKtEnpcqoDw22KQXZV3VBIR/l581oCzfVUN70rrDCkuL+22NPdadcHRTPaWrgaz4mmYTi31DDoy3gxQ7YFUuk5js1XyIqv+yhAXlvgEkm9UtsrJ1ZvqrFpYoXukB9QeNXY7jpqp9oiMcRjuxBECnSzqXhaniSjaulQcjsG7wzDPwU08Bu1Hj8jRj1nLg4S3+1kGBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CwjIuvfXMMaQ3a5UCdmXr54nHsAmdLP/Ek8WTnpW8rw=;
 b=H0Ieq8gJkn+4Lo0h88/y5hf5f05h/LqBOQxU/tEDqfC0/rvS/fmCb54Lu+acHJNN7U3se4sZ3Rh9hB2RIll2xh8t3eUNlJ/imN8kAwiWIzDz/RF1zqd5vX0Kg7ryx5D/KzDRdi96Fmim2qzYMgmuxrOPsmbxXkN9l8+I/sqbN4w=
Received: from BN9PR03CA0765.namprd03.prod.outlook.com (2603:10b6:408:13a::20)
 by MWHPR02MB2638.namprd02.prod.outlook.com (2603:10b6:300:45::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.40; Tue, 4 May
 2021 10:22:59 +0000
Received: from BN1NAM02FT040.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:13a:cafe::ee) by BN9PR03CA0765.outlook.office365.com
 (2603:10b6:408:13a::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.27 via Frontend
 Transport; Tue, 4 May 2021 10:22:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT040.mail.protection.outlook.com (10.13.2.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4065.21 via Frontend Transport; Tue, 4 May 2021 10:22:59 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 4 May 2021 03:22:43 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Tue, 4 May 2021 03:22:43 -0700
Envelope-to: git@xilinx.com,
 mdf@kernel.org,
 trix@redhat.com,
 robh+dt@kernel.org,
 arnd@arndb.de,
 gregkh@linuxfoundation.org,
 linus.walleij@linaro.org,
 zou_wei@huawei.com,
 linux-fpga@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 chinnikishore369@gmail.com
Received: from [10.140.6.60] (port=35290 helo=xhdnavam40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <nava.manne@xilinx.com>)
        id 1ldsCO-000192-RO; Tue, 04 May 2021 03:22:41 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <mdf@kernel.org>, <trix@redhat.com>, <robh+dt@kernel.org>,
        <michal.simek@xilinx.com>, <arnd@arndb.de>,
        <rajan.vaja@xilinx.com>, <gregkh@linuxfoundation.org>,
        <linus.walleij@linaro.org>, <amit.sunil.dhamne@xilinx.com>,
        <tejas.patel@xilinx.com>, <zou_wei@huawei.com>,
        <manish.narani@xilinx.com>,
        <lakshmi.sai.krishna.potthuri@xilinx.com>, <nava.manne@xilinx.com>,
        <wendy.liang@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <git@xilinx.com>,
        <chinnikishore369@gmail.com>
Subject: [RFC PATCH 1/4] drivers: firmware: Add user encrypted key load API support
Date:   Tue, 4 May 2021 15:52:24 +0530
Message-ID: <20210504102227.15475-2-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210504102227.15475-1-nava.manne@xilinx.com>
References: <20210504102227.15475-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 38e6d033-e19c-4990-18ed-08d90ee69760
X-MS-TrafficTypeDiagnostic: MWHPR02MB2638:
X-Microsoft-Antispam-PRVS: <MWHPR02MB2638906E89F43E7FEB868811C25A9@MWHPR02MB2638.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HSk9WfE582esI5uzcTCNUpCTy7tdrhBYoWmMVU8sSDCABAgFFuwgDit/s3q2FtQn+UOs3UFD7oN8iamgBjGfv6isI6FR3ov6Q3g93l9410tM9mkY71HzTbSpOs94HiGQTnPxKxKgXEcvYO9maQpJF0n5sor87oeD3KLgya22OFkZobvKps0l6GBUikYd4S5CGjegpOoE4/+GDhqJrYGqdDhPtJqge16vGrg6ZAg3e20oTU15WHXbw6Y9HrVS6FoJzqHMzzBONrWpr8b5xFfn5d35lvfmC89+ZzGMehr9fIr8VTrRVxqU/Kv6uHSxd1o2AM06n5Nu6OaQApn5W2kd3H/PgtGmocBu9yOlRAAXTTRvl3QgZiB9ExHvejHNy1HMpO1dcHjua2KUC0Oq50WoPRppmNLKXlL4hc8ZYW3jmsiTsm/361eVy19FMG2wzqitK+0hx3H+eCkPMAqeQI8r84dd72tVixa8BecN5PjogyYvuH8r2fnJydM7I+p3pgpZldhg8KqCJzhniDQEmnBwxUNf1yXveNv6RHdq4lvPwBYvJHpBDZUiOk8uMYVM+sshAJDS7wHhEDeQRnYwc+Ajh9sz4OtNZOM15OEffeC+dGVZhrI9/pGV0u4GPPHAJjdIkyprEqvWSC4vDtDWqypUAbT6mFauKgtcQRaUiXE1hbeFpU9PCDs32ILjdJ3gkutFPXqEKZhqaow3yghq6VsNM+tY1caUdyPMqTBNuliL4CZkgh6mqK13flq8Wno8BpaS
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(376002)(39860400002)(396003)(136003)(346002)(36840700001)(46966006)(7636003)(356005)(83380400001)(82740400003)(47076005)(2906002)(36860700001)(82310400003)(921005)(478600001)(316002)(8936002)(7416002)(110136005)(9786002)(186003)(26005)(36756003)(426003)(336012)(36906005)(7696005)(1076003)(6666004)(5660300002)(8676002)(70206006)(70586007)(2616005)(102446001)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2021 10:22:59.3090
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38e6d033-e19c-4990-18ed-08d90ee69760
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT040.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2638
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

This patch adds user encrypted key load API to support
User key encrypted images loading use cases from Linux.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
 drivers/firmware/xilinx/zynqmp.c     | 17 +++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h |  7 +++++++
 2 files changed, 24 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 15b138326ecc..2fa5687a75f8 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -787,6 +787,23 @@ int zynqmp_pm_fpga_load(const u64 address, const u32 size, const u32 flags)
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_fpga_load);
 
+/**
+ * zynqmp_pm_fpga_key_load - Perform to load the bitstream encrypted key
+ * @address:    Address to write
+ * @size:       encrypted key size
+ *
+ * This function provides access to pmufw. To transfer
+ * the required encrypted key.
+ *
+ * Return: Returns status, either success or error+reason
+ */
+int zynqmp_pm_fpga_enc_key_load(const u64 address, const u32 size)
+{
+	return zynqmp_pm_invoke_fn(PM_ENC_KEY_LOAD, lower_32_bits(address),
+				   upper_32_bits(address), size, 0, NULL);
+}
+EXPORT_SYMBOL_GPL(zynqmp_pm_fpga_enc_key_load);
+
 /**
  * zynqmp_pm_fpga_get_status - Read value from PCAP status register
  * @value: Value to read
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 9d1a5c175065..7aa9ad40ff53 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -91,6 +91,7 @@ enum pm_api_id {
 	PM_CLOCK_GETPARENT = 44,
 	PM_SECURE_AES = 47,
 	PM_FEATURE_CHECK = 63,
+	PM_ENC_KEY_LOAD = 64,
 };
 
 /* PMU-FW return status codes */
@@ -411,6 +412,7 @@ int zynqmp_pm_pinctrl_get_config(const u32 pin, const u32 param,
 				 u32 *value);
 int zynqmp_pm_pinctrl_set_config(const u32 pin, const u32 param,
 				 u32 value);
+int zynqmp_pm_fpga_enc_key_load(const u64 address, const u32 size);
 #else
 static inline int zynqmp_pm_get_api_version(u32 *version)
 {
@@ -622,6 +624,11 @@ static inline int zynqmp_pm_pinctrl_set_config(const u32 pin, const u32 param,
 {
 	return -ENODEV;
 }
+
+static inline int zynqmp_pm_fpga_enc_key_load(const u64 address, const u32 size)
+{
+	return -ENODEV;
+}
 #endif
 
 #endif /* __FIRMWARE_ZYNQMP_H__ */
-- 
2.17.1


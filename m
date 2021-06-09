Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 445B33A0C0A
	for <lists+linux-fpga@lfdr.de>; Wed,  9 Jun 2021 07:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236150AbhFIFzB (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 9 Jun 2021 01:55:01 -0400
Received: from mail-dm6nam11on2073.outbound.protection.outlook.com ([40.107.223.73]:2785
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234310AbhFIFy5 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 9 Jun 2021 01:54:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A/liBIpBV9OROlo2cyNdEqk77nQ7jbUrlalJlTEKgeB2MV55fO/P/oEE2Aryy8lxcL3vnxovvjRsEyFyZfvJSljUx/TYnXJuTFsxHxwtA2JxqTPge7sKZU4fR3WECApshpk8qGcCgqR0Qs3npbxU+Z+lpJ0etbhuPtNVUxuZtpDK+P5sYEKehRZMmf7fcJOjy8n1b4viostwfGz5pgqbqHSQbFcbalt+stk5PYhBjBTW68pBWme4pugcUM7fapzrTQVowqXd36G1lAs2xQOyLPrNnpxuk1ibK8zXSHOcRw85mfWvylGWTeAUji+IQgZ2AwmCYnmVTFntnCYScezZiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uABdoMqNvBJ3mNZWxD0ZDBUNP43d9hhIrfG2WjwBIBo=;
 b=CtQF6caoow3N1ZkBV4LvfmwiSsoiMRiLBV+iSaft0298dSeMy4XQOboLBy5EdLrNAu7Ij5dto1hd3YOtB8hLHpQ73v43ERD+SfCBqMk05j92q7He47XWpWynZ/GibExG1ChP3ohkZcKjjIp4GUuoqtS6cZZH+g0uAsEOAIa95kOZQacFV1QLmPcoy1Et85Fk5Njs6IvhN3pSc2B+lIqW90uIapnggcoI14oAdTV3JwAE+/fuw+hQKUS06ohIDxerzplu2MZUy1nB4HWiGlH/nklzyjp4d34hOUYIFLtIj45sutrSU1pBJrlNgrm/j1IyY0uwdXT5lGPP1dceHkOWAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uABdoMqNvBJ3mNZWxD0ZDBUNP43d9hhIrfG2WjwBIBo=;
 b=V87bdh02WfU+UXbuRMI0DdONSy06WOxkE9uG8bvV69OkkTimTNRGgVWjthXv/W4BtnLQ5w61PVSonreOfGKbo2QsYfAKCNfsYiPeiaorfPuVZMHYBN/SnbDI+KC9cme+G/ZrmUXntwnrNbusJlpOW6jFrX97xLc8/2l+KXaSbsw=
Received: from BN6PR14CA0006.namprd14.prod.outlook.com (2603:10b6:404:79::16)
 by SJ0PR02MB7855.namprd02.prod.outlook.com (2603:10b6:a03:322::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Wed, 9 Jun
 2021 05:53:00 +0000
Received: from BN1NAM02FT054.eop-nam02.prod.protection.outlook.com
 (2603:10b6:404:79:cafe::7f) by BN6PR14CA0006.outlook.office365.com
 (2603:10b6:404:79::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend
 Transport; Wed, 9 Jun 2021 05:52:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT054.mail.protection.outlook.com (10.13.2.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4219.21 via Frontend Transport; Wed, 9 Jun 2021 05:52:59 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 22:52:47 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Tue, 8 Jun 2021 22:52:47 -0700
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
Received: from [10.140.6.60] (port=51918 helo=xhdnavam40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <nava.manne@xilinx.com>)
        id 1lqr8w-0007H3-AX; Tue, 08 Jun 2021 22:52:46 -0700
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
Subject: [RFC v2 1/4] drivers: firmware: Add user encrypted key load API support
Date:   Wed, 9 Jun 2021 11:22:29 +0530
Message-ID: <20210609055232.4501-2-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210609055232.4501-1-nava.manne@xilinx.com>
References: <20210609055232.4501-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f4fdb56e-ac9f-44e3-5b39-08d92b0ad646
X-MS-TrafficTypeDiagnostic: SJ0PR02MB7855:
X-Microsoft-Antispam-PRVS: <SJ0PR02MB7855692FBDB6F49CCCBC624EC2369@SJ0PR02MB7855.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XBhXu2fl3VM1QSS5BivpPj0t6MLwpJMUmJwxstkK88EFZXZi+GG5/l9vZrc78/upeRRnhYroIdlNdhA50FkytmnOyzagKiDmLPMfkk5K2oczD5Qxuw8J9yiRWzu3isr6Ws+EUNNFJouo1vIK5m30nbHanRpy0zfUuYL8WcJ9uy7GlyFcL9TWIHPInhz++0TkI3CH0+rdXA/ZLNzW4LQMOU5bhBYrVJtYdNBMT7oyZ+1YULYzOx7rE8SfU++8fcQ7c+V/UB7F7pZhUcshW6Dgff+tNHN18gCKTu1dhEwXTPaLdk6nh01k+MtyiEdINyoYacJ/wrIIZ8zZyNDfsKYErkqWnD5Yr6cb/VFjhf/QFrYKJuAhFcn69yUNgi2tvIQzrUf+nMmulcphkS69fv897pvw6hHISPIzgsYWGBSGpgYrfOAkyl1qwcTgOayF8TM+i1akS9bVIqtl7NzKy2KQjTrqHw0yWNKhFOIPOLF4Be5EFX/+rJvKY79P73xWpXyWm6Oc0nh9lJXbT+wzKLS9LILAsZRngmcatOiraEYEsfnq4DAoHtkQ1R1r7PNCfgmXM8ftekeKtvBQE4CLeVk1QcsCKV6O9T9K9uUY3pXoSMUwt52DnagteLtB3KXg7tL3G4mZBeZYeMTUgDdoVGoQJUgvI6rjZdsQm51xB6dRk1NZ/YjEDdMexxzUTTYDvafk2dBYXEHtAoAj8By84W3B9sgF1dw3I52MDwzxOLo/8NjDhtZvUhZuD04G/v1YnTz+
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(136003)(39850400004)(36840700001)(46966006)(2616005)(8676002)(336012)(426003)(478600001)(82310400003)(6666004)(83380400001)(8936002)(70206006)(5660300002)(110136005)(7636003)(2906002)(356005)(316002)(70586007)(7696005)(36756003)(36906005)(36860700001)(186003)(9786002)(26005)(7416002)(1076003)(921005)(47076005)(82740400003)(102446001)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2021 05:52:59.2818
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4fdb56e-ac9f-44e3-5b39-08d92b0ad646
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT054.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7855
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

This patch adds user encrypted key load API to support
User key encrypted images loading use cases from Linux.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
Changes for v2:
		-None.

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


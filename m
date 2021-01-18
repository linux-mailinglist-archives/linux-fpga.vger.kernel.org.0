Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB042F97F1
	for <lists+linux-fpga@lfdr.de>; Mon, 18 Jan 2021 03:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731152AbhARCuV (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 17 Jan 2021 21:50:21 -0500
Received: from mail-dm6nam10on2044.outbound.protection.outlook.com ([40.107.93.44]:4704
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731128AbhARCuT (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sun, 17 Jan 2021 21:50:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=azxYsee1OCtFQbUriN1zwZAZ6KvqBoI8LamWWSOEelub5UgAMF27IVa+Hv2ua7T1iaCln0HCaCQDoonmslmKc1AVuCQy1ynkOW1XgSo2nA59viAy2vh0Gstt0xJ7yAeNNdwYY2pmcsM/C3ogotz484hsrZVKKbv0MidBZn9fZNduIHDuqR/zcDrT/Be+dkAhEvXHrmicWmJEocTkP1QM/2GmBnhppJ6obuSUqcw4W6tw1jV0w54zRLmQyML4Bkan+kbpmrDVaoRJjfiBIMZcBWH8hmxgm4WpfT8Ne7s18mo1iNeaC5Q0PkLDlPc5R4SjI3Aw1RPcyfrj23PfMlWR9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sewfEWt9Le9uh8w54oN736BzCE/Tb3R3X65VlU/nCLk=;
 b=hiQm0xA5XBqlAV8WSR1BCv7HVtVRwnyYqe7rvdwW+JvczYQ+hUv0UkxGKpDTEHzN+xevKNXSeROie8NEgktZHBl4FhcTLqY6PpxRwtwYNeDl/9+m+OOq8exoGA8q2gCiag+sGSBPLCkHKoud7QkRVgAPSGu6hc6EyBCt0lQ5+qKXqRv83iapfZGm81tt/Bl35PeOKHTqItw5AoOTQk0asQutYfnJrWS3fZ9QkqlZ5X1sF7vivKWLEg5EUtxLhMNAbu3lpET4I+jy2r2LjSkP3APFfAfyZRyDyBn/Ic32bDBbyg9h0MN7tQPmX6ZrlQ4oatW53wlTxKejQIiCwfhidg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sewfEWt9Le9uh8w54oN736BzCE/Tb3R3X65VlU/nCLk=;
 b=PV3386yO0JR4yDhn3X35Qi+sFvzpJI8+ZrQgNgx+A1rq+NVP2Qgt1L1s52xy6KmarOoumz+5eJA6citUFoRtb17PG5rc/otRRLVaQ2XMQ9c5e9qgdqfC/ojDqKIbwK+aPcC65jNiKI6Sf1Upx8zacjlMiYE6JoxPLnOJvqwAN5c=
Received: from SN4PR0501CA0153.namprd05.prod.outlook.com
 (2603:10b6:803:2c::31) by CH2PR02MB6614.namprd02.prod.outlook.com
 (2603:10b6:610:a6::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.14; Mon, 18 Jan
 2021 02:49:24 +0000
Received: from SN1NAM02FT029.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:2c:cafe::29) by SN4PR0501CA0153.outlook.office365.com
 (2603:10b6:803:2c::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.6 via Frontend
 Transport; Mon, 18 Jan 2021 02:49:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT029.mail.protection.outlook.com (10.152.72.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3763.12 via Frontend Transport; Mon, 18 Jan 2021 02:49:24 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Sun, 17 Jan 2021 18:49:18 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Sun, 17 Jan 2021 18:49:18 -0800
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
Received: from [10.140.6.60] (port=39926 helo=xhdnavam40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <nava.manne@xilinx.com>)
        id 1l1KbV-0001PD-1j; Sun, 17 Jan 2021 18:49:17 -0800
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <mdf@kernel.org>, <trix@redhat.com>, <robh+dt@kernel.org>,
        <michal.simek@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <git@xilinx.com>, <chinnikishore369@gmail.com>,
        Nava kishore Manne <nava.manne@xilinx.com>
Subject: [PATCH 1/3] drivers: firmware: Add Pdi load API support
Date:   Mon, 18 Jan 2021 08:13:16 +0530
Message-ID: <20210118024318.9530-1-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a7bb548-df3e-4bc5-4637-08d8bb5baa34
X-MS-TrafficTypeDiagnostic: CH2PR02MB6614:
X-Microsoft-Antispam-PRVS: <CH2PR02MB66147C8BE60ACD5A86B97FC3C2A40@CH2PR02MB6614.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ai99X6/R8AW40anabKzCtwoI8dPDrYsE0O2ASvao1uXS02uZ4eUMTs3LN0hefDVx40h3YOw57Mqa2pY61kgnmL6nMzundTs08a1opI5RtcJh0Kop5tbKKix0LbaGtq1/yWlwVfMDHcT3D+ZS1N76I8ga6u2Vsk3dnGnWGrjzkEubUYC1Wfnp1/WNU/7PVm03I6TJQp8g4CZvklEQk2e4nf67eVI7DbUn0mDT2gvrwYIQPCdlyBLojVVzc5WpM2C5mgzM6683IquV4+Z0R+2obX9sBh962hpWFNGZ/OuJlfBbjw50VMbtkolM3unexdsgiAzsrXWPDZKc6pK4FEjNxmhO5noPg4Hi625fW6ZCXy395YImhBoC4hzJXI1mbfazTn6EQK5Z8CAVeGJtN0Vv95HqWml1CrNEAHv3u/3PCndCrSeQJRl3TRITnQ6JAsCHL6s2P9Ho8QDd37TIjOnWwDeAMohewE/BiGtVvGjohCadZLJXj5CUsMtyjivyGdeRTummEoLvCK9407xlfAD6Ww==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(396003)(346002)(376002)(136003)(39850400004)(46966006)(70586007)(2906002)(70206006)(426003)(9786002)(336012)(36906005)(83380400001)(47076005)(5660300002)(8676002)(316002)(186003)(54906003)(110136005)(356005)(82310400003)(26005)(7636003)(2616005)(8936002)(82740400003)(107886003)(7696005)(1076003)(478600001)(4326008)(36756003)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2021 02:49:24.4106
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a7bb548-df3e-4bc5-4637-08d8bb5baa34
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT029.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6614
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

This patch adds load pdi api support to enable pdi/partial loading from
linux. Programmable Device Image (PDI) is combination of headers, images
and bitstream files to be loaded. Partial PDI is partial set of image/
images to be loaded.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
 drivers/firmware/xilinx/zynqmp.c     | 17 +++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h |  9 +++++++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 7eb9958662dd..a466225b9f9e 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -897,6 +897,23 @@ int zynqmp_pm_set_requirement(const u32 node, const u32 capabilities,
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_set_requirement);
 
+/**
+ * zynqmp_pm_load_pdi - Load and process pdi
+ * @src:       Source device where PDI is located
+ * @address:   Pdi src address
+ *
+ * This function provides support to load pdi from linux
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


Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0A95FD6A4
	for <lists+linux-fpga@lfdr.de>; Thu, 13 Oct 2022 11:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbiJMJGR (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 13 Oct 2022 05:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiJMJGQ (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 13 Oct 2022 05:06:16 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 814E54B992;
        Thu, 13 Oct 2022 02:06:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AwU2MJLhmXssIUaAx/J0y9Dtw31+pak5uvlvE4slt9oWdoD6+E5J+8P4hTKuRDoJaUuU2bgiiteIuRNofmven5pXN1L9eZGA7JurZ1fTMqPALzrOCpZvHmvzOrga6EsAJv12buHsE2TqOXX4KDKLAANwvrnUoetbG7xC82TgJSXrnPi8xGpdwcoaHZixNJ/zl1fJ7CaB5O1meObFNuqiKjhnQLTn58cA/cBLVHkaV1bPlJHBUZtNv9xA5r38SrSDeMi7FD47PHBFAB3j7KL3ZgiCpbuCxOeOPxFi2/k2l8KN5RYZQUMkbVNvWq+zfy/Hl3jG0kzRNOtsvjM7omeDvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jVw7E3maP+kFvQ1taOQSCAScBaVZu28hMZB7lpaSxn8=;
 b=kSeWVxha/xfAjYjEHvxNPgo9GAU0zS7gs3Q0aPcvV5c55vXr/l4TFXD8GZqfH40t1SqfEotWsFNa7msNHsYMYtLBz9/6FOIi0+lH3ExsAw1t+cplqitlfcaTWU5TN96COTNTbIIxEkFlRXkAUKYFUnAtfTNPCu0tkhc7nfzjxTRXY+b4S5zVHqtl7P6mJregcijzKeZ8Vgq4h+WIvXLGGc7lKRVncbD1aZWcwVL5hhF7T8OcvCaLNqFCDxp2Anx1agFyUjaiK6MKCeitEl29NHVPJTcWyger7eB02K3h3WEJDc4uvZ4xdrBDT6Tmje2/3tWbnSSHTYYlQcjP0ZEksg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=xilinx.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jVw7E3maP+kFvQ1taOQSCAScBaVZu28hMZB7lpaSxn8=;
 b=Gzt0nxvOJJqhvObPwai5YXc8xu9spHu82z7AAgLnJBWDnVc01C9GACovc/wIOyUgQcGBh13BsyJkexpK/9fOuKBSkb18m616iMn9d4enruoVprJBs/Z3yua+L2UouvfQsmHgW/KtXLfhpUKoF2ykiCpSPuREs/szPuii7Pgeovw=
Received: from MW4P223CA0020.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::25)
 by BL0PR12MB5010.namprd12.prod.outlook.com (2603:10b6:208:17c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21; Thu, 13 Oct
 2022 09:06:11 +0000
Received: from CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::8a) by MW4P223CA0020.outlook.office365.com
 (2603:10b6:303:80::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26 via Frontend
 Transport; Thu, 13 Oct 2022 09:06:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT013.mail.protection.outlook.com (10.13.174.227) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Thu, 13 Oct 2022 09:06:10 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 13 Oct
 2022 04:06:08 -0500
From:   Nava kishore Manne <nava.kishore.manne@amd.com>
To:     <git@xilinx.com>, <michal.simek@xilinx.com>, <mdf@kernel.org>,
        <hao.wu@intel.com>, <yilun.xu@intel.com>, <trix@redhat.com>,
        <gregkh@linuxfoundation.org>, <ronak.jain@xilinx.com>,
        <rajan.vaja@xilinx.com>, <abhyuday.godhasara@xilinx.com>,
        <nava.kishore.manne@amd.com>, <harsha.harsha@xilinx.com>,
        <lakshmi.sai.krishna.potthuri@xilinx.com>,
        <tanmay.shah@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-fpga@vger.kernel.org>
Subject: [PATCH v3 1/2] firmware: xilinx: Add pm api function for PL config reg readback
Date:   Thu, 13 Oct 2022 14:35:55 +0530
Message-ID: <20221013090556.741357-2-nava.kishore.manne@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221013090556.741357-1-nava.kishore.manne@amd.com>
References: <20221013090556.741357-1-nava.kishore.manne@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT013:EE_|BL0PR12MB5010:EE_
X-MS-Office365-Filtering-Correlation-Id: cddd7bda-aba9-4e28-09bf-08daacfa2bf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X3t4ohiLTYeZB4ztoQ89JKv1o4+mWWVfEWWTT+8X3kQwzr17/FH//kE0TSBpXvW/zEaCPsEI3vdr4Ju3Yv+i1RYecxCHKDqUBWXqnmLlVQ1ftPHPB5zy8YrFzpTBZPW39EIybP1jK0VYjMEqGN5dxuukw0koLs9i83p8cLoAVYSnm7Cbmuiagv9OY0eI0uGjF39B/KdHDnSsXoGaLFTR0uQnIVElVG8J2Iml3ZzDRSj8V5OCKLgHy2NRmKOoRvdcUOOLx+Y949rt0XdR5HFnF+zSaK0Z+V/AfMu4lloUs5O7d+4fC8pBMl3HYjtXICGGN0zhdA4hfmycaOJM4xEguofWhhtpeY+PhmLgVd65H0uGPNNzEiYKhFYF1orHr99VAxSJjnstV7fulFp7n8XYMsMxvoJalekslq+aSaFOIPBhvOWZCHqXDs2v0ZhyG/RydaIj9V97ch3rXrNeBlzsOfJXKvFBNyBEP8eJP70surMz78/BIC02MKvuT0UFFKOIlG5/bBkvxS2Ui7fs4EiAe/1wHHeHxJvTLko4Oo3HrWsUwhkV/jx13zWPownA2Q6M8S4KRee+QIu2n+Pebz1juKFNVBvyqYEF2/zmVEHDmBs8R350qTNkM30OTq03mNp6Da892IF+Zszy3ntWxr8aqIxfoU3MITFRN8q+xo7JVuWQ+m+Jrr/nEaSPxabQNcRkMJU1ZvAk76qzbUQjGdAHBJvkC580h9ZB1XMXGIP+Y/iIWUeUYOZmZeDEJQG3xAwV5toEUdPF20zLHK9JGOtpr6xn8R/jJhyFJJqqSn10s1CYX2i0fAmSd0bos402hK06bJULL5TO/4g88WzoqXc+AAs+/ZW5kydnj86Bd1QI1DIY2EeLkQ4jRD3poTZX4jlQ
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(396003)(346002)(136003)(451199015)(40470700004)(46966006)(36840700001)(86362001)(6666004)(426003)(40480700001)(5660300002)(921005)(82310400005)(356005)(83380400001)(70206006)(70586007)(8676002)(47076005)(81166007)(316002)(2906002)(41300700001)(110136005)(336012)(36756003)(26005)(36860700001)(186003)(16526019)(1076003)(2616005)(82740400003)(8936002)(103116003)(478600001)(40460700003)(83996005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2022 09:06:10.3464
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cddd7bda-aba9-4e28-09bf-08daacfa2bf3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5010
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Adds PM API for performing Programmable Logic(PL) configuration
register readback. It provides an interface to the firmware(pmufw)
to readback the FPGA configuration register.

Signed-off-by: Nava kishore Manne <nava.kishore.manne@amd.com>
---
hanges for v2:
              - None.

Changes for v3:
              - Updated API and config reg read-back handling logic
              - Updated the commit msg to align with the changes.

 drivers/firmware/xilinx/zynqmp.c     | 35 ++++++++++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h | 11 +++++++++
 2 files changed, 46 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index d1f652802181..045a113434c2 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -941,6 +941,41 @@ int zynqmp_pm_fpga_get_status(u32 *value)
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_fpga_get_status);
 
+/**
+ * zynqmp_pm_fpga_get_config_status - Get the FPGA configuration status.
+ * @value: Buffer to store FPGA configuration status.
+ *
+ * This function provides access to the pmufw to get the FPGA configuration
+ * status
+ *
+ * Return: Returns status, either success or error+reason
+ */
+int zynqmp_pm_fpga_get_config_status(u32 *value)
+{
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	u32 buf, phys_lower_addr, phys_upper_addr, addr;
+	int ret;
+
+	if (!value)
+		return -EINVAL;
+
+	addr = (u64)&buf;
+
+	phys_lower_addr = lower_32_bits(addr);
+	phys_upper_addr = upper_32_bits(addr);
+
+	ret = zynqmp_pm_invoke_fn(PM_FPGA_READ,
+				  XILINX_ZYNQMP_PM_FPGA_CONFIG_STAT_OFFSET,
+				  phys_lower_addr, phys_upper_addr,
+				  XILINX_ZYNQMP_PM_FPGA_READ_CONFIG_REG,
+				  ret_payload);
+
+	*value = ret_payload[1];
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(zynqmp_pm_fpga_get_config_status);
+
 /**
  * zynqmp_pm_pinctrl_request - Request Pin from firmware
  * @pin: Pin number to request
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 9f50dacbf7d6..34b0a9171293 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -70,6 +70,10 @@
 #define XILINX_ZYNQMP_PM_FPGA_FULL	0x0U
 #define XILINX_ZYNQMP_PM_FPGA_PARTIAL	BIT(0)
 
+/* FPGA Status Reg */
+#define XILINX_ZYNQMP_PM_FPGA_CONFIG_STAT_OFFSET	7U
+#define XILINX_ZYNQMP_PM_FPGA_READ_CONFIG_REG		0U
+
 /*
  * Node IDs for the Error Events.
  */
@@ -117,6 +121,7 @@ enum pm_api_id {
 	PM_CLOCK_GETRATE = 42,
 	PM_CLOCK_SETPARENT = 43,
 	PM_CLOCK_GETPARENT = 44,
+	PM_FPGA_READ = 46,
 	PM_SECURE_AES = 47,
 	PM_FEATURE_CHECK = 63,
 };
@@ -475,6 +480,7 @@ int zynqmp_pm_is_function_supported(const u32 api_id, const u32 id);
 int zynqmp_pm_set_feature_config(enum pm_feature_config_id id, u32 value);
 int zynqmp_pm_get_feature_config(enum pm_feature_config_id id, u32 *payload);
 int zynqmp_pm_register_sgi(u32 sgi_num, u32 reset);
+int zynqmp_pm_fpga_get_config_status(u32 *value);
 #else
 static inline int zynqmp_pm_get_api_version(u32 *version)
 {
@@ -745,6 +751,11 @@ static inline int zynqmp_pm_register_sgi(u32 sgi_num, u32 reset)
 {
 	return -ENODEV;
 }
+
+int zynqmp_pm_fpga_get_config_status(u32 *value)
+{
+	return -ENODEV;
+}
 #endif
 
 #endif /* __FIRMWARE_ZYNQMP_H__ */
-- 
2.25.1


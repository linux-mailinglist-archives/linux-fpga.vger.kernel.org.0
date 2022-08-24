Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9870059F243
	for <lists+linux-fpga@lfdr.de>; Wed, 24 Aug 2022 05:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232892AbiHXD4C (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 23 Aug 2022 23:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbiHXD4B (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 23 Aug 2022 23:56:01 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D94E31D335;
        Tue, 23 Aug 2022 20:55:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O16Lj5rxIuC3vyaECT4F+zdRh3tG8qwemZuoBRqdz8JVHYHdlonGYtuZYXl7LBCR57SlstpEscTt2IHG5s6XeVrgZWIdRb5I1G5SC1uljsePIxMBbGmAymzLUfKQcIWcXp8dBTwrcE+bdlcZa5rxDqa81iNkFraxg0nQj0jiCOxCvq/K79MqoLG8fstsCJevJ2aFOHq01YXNobIf9TPdfyK1jAwq6hCQT0hbRQF+5ksqDndGQjVso0iwt6QLzrBAlKIrp4pRKYsuL60mfNAPbLn8YUBUep4zTAHJS+B2VEL+kwOX3Z0/BTyUohBFx/Q3T0GNq1cUNLSxlF9RFY+reA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fl9k2yvCLnKrWskaDVWfp0yb3SvwdgAVPRCFbikq9gU=;
 b=ISH0Wpf8VjBHCEO3HwVj8EEFcc0be3bS2F6vj+yawW1fOg6dhzK0IVg/HVBvLv8/gW2Ebe4BtgpKOEVCv63hWSWHPuKUrmTRXPusBK4O8jxqHQmSApp3OHzKDXHOwTVC/UNbpQBVsf5frdZfUMTJfJ9odUT5lbxyHYJ+n5L+GFuBi2wiYuDg6SgIzmKrM4ndqm6tYAAqCG97F7i0KkJZEv8CkdPWuphwdWIzUfUVV0AZmwceIDeytbgwVK+kjkTM638V0DYgmG5PjxFoIUr9Y4x2l07P6Nh3bI2Wy77hUSHi9FAM2MuMq3ERAhWLmrODQ0WGfkZwULW92FY90rlanw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fl9k2yvCLnKrWskaDVWfp0yb3SvwdgAVPRCFbikq9gU=;
 b=nhQgNBtDN6HBupBJObOXLErzokms09HjtW3VzLS+DpWR31WFgR6xYCxGc/dmecF99dnWqQWDTN3pIOqYOYVlszaV68nkY0p+Lsk9ZGjiL4WpHKPWs4WLG8pUbFQdhig0CkBFQ9mjgD4kgSJzDHV3bhwoRU4VfJOWtr+av+eIIPo=
Received: from MW4PR03CA0277.namprd03.prod.outlook.com (2603:10b6:303:b5::12)
 by PH0PR12MB5631.namprd12.prod.outlook.com (2603:10b6:510:144::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Wed, 24 Aug
 2022 03:55:55 +0000
Received: from CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::72) by MW4PR03CA0277.outlook.office365.com
 (2603:10b6:303:b5::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21 via Frontend
 Transport; Wed, 24 Aug 2022 03:55:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT029.mail.protection.outlook.com (10.13.174.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Wed, 24 Aug 2022 03:55:55 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 23 Aug
 2022 22:55:52 -0500
From:   Nava kishore Manne <nava.kishore.manne@amd.com>
To:     <git@amd.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <michal.simek@xilinx.com>,
        <nava.kishore.manne@amd.com>, <mdf@kernel.org>, <hao.wu@intel.com>,
        <yilun.xu@intel.com>, <trix@redhat.com>, <p.zabel@pengutronix.de>,
        <gregkh@linuxfoundation.org>, <ronak.jain@xilinx.com>,
        <rajan.vaja@xilinx.com>, <abhyuday.godhasara@xilinx.com>,
        <piyush.mehta@xilinx.com>,
        <lakshmi.sai.krishna.potthuri@xilinx.com>,
        <harsha.harsha@xilinx.com>, <linus.walleij@linaro.org>,
        <nava.manne@xilinx.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-fpga@vger.kernel.org>
Subject: [PATCH 1/4] firmware: xilinx: Add afi ioctl support
Date:   Wed, 24 Aug 2022 09:25:39 +0530
Message-ID: <20220824035542.706433-2-nava.kishore.manne@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220824035542.706433-1-nava.kishore.manne@amd.com>
References: <20220824035542.706433-1-nava.kishore.manne@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fafa349c-fcf0-4a34-022a-08da85848bcb
X-MS-TrafficTypeDiagnostic: PH0PR12MB5631:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u7kvs30wirffBlVFJ6pWK2WzyjD2/mKcoA0M8wWXd2AGe/HUmU26E4OtDR7GlI9Lp72uc7kCp90VYxlrhr6Sh2lE9cHK15uYehEfpOlEMNcS5+b8jtDIaBkX5Vj1D25ctZcM49us4is1W1y05Lt4yjKoP64eBqupu1Cqj+CdxeI1Y+DO4uW5YP+fzLTQex0jtopl2+2YKkvcO9WTJB6+pYAl45rqYfzudvbijKFj8Cqf1mdW9Ys9ETAY9UN7bNXP0rg4J4iSFeU4SVQjooa1u/aKP+4wE5ue0MPmaTRBqs5qwzL4nv9h67sAEjpNhI/Ci6ZDm+nLRFXSEcuwVOMGB3UXDO2rjMvGwoL+TrcCzOQWFVBhS5oJNdme0DxUth1ZIcB44GxaxKxnAFOARv6xOeDVHAV5JxbqRHcheChWksHEwzFFJnLt4x3rGac1MzzsRrv/kX4eYbfrr4PLHG+/sKQ41IGbjUXbtlIlSvtMwJoQhpxKAd3DWKSMYKmFR9avv01MYCb0f6jbKQUNL85hHkFiOMHyEJLpOpwdJk44TaB4ACJdK+cPdlfS/CEqfMnjcOYY5ACliNKu/PUxB0cImi3TxRJfKsTq7x3UXZO8i8y/8ve6PjlXMt8WiPx+t1orWzT7YqkPdjSJwO0yFt9Wq58CxKtgvyYpKlGmOyO3dpIDlVIlSwf2WQfJ9llh0uRAckt/3qCS27kHPKBXm0O5813njnU9vXLY2yL7IkX4BVXy4k+mLTfGs1/iw7/mPdGdiBOEZlWcxnKDzeeIAxFLzbjLF8VhyI2JEqGERm7li/JJzLSr9uDSMxtnnDNyDhTezfd/NLTBEggUvtnn2o5XxR0DI5AdJbfHte3cokk1pG03FEckxTvxuB9HJN77BiqX
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(376002)(346002)(396003)(40470700004)(36840700001)(46966006)(36860700001)(40460700003)(82310400005)(16526019)(8676002)(336012)(426003)(2616005)(7416002)(83380400001)(5660300002)(1076003)(186003)(8936002)(47076005)(82740400003)(81166007)(356005)(2906002)(70586007)(36756003)(921005)(26005)(40480700001)(86362001)(103116003)(110136005)(316002)(70206006)(478600001)(6666004)(41300700001)(36900700001)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2022 03:55:55.1986
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fafa349c-fcf0-4a34-022a-08da85848bcb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5631
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Adds afi ioctl to support dynamic PS-PL bus width settings.

Signed-off-by: Nava kishore Manne <nava.kishore.manne@amd.com>
---
 drivers/firmware/xilinx/zynqmp.c     | 14 +++++++++++
 include/linux/firmware/xlnx-zynqmp.h | 36 ++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index d1f652802181..cbd84c96a66a 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -843,6 +843,20 @@ int zynqmp_pm_read_pggs(u32 index, u32 *value)
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_read_pggs);
 
+/**
+ * zynqmp_pm_afi() - PM API for setting the PS-PL bus width
+ * @config_id:	Register index value
+ * @bus_width:	Afi interface bus width value.
+ *
+ * Return:	Returns status, either success or error+reason
+ */
+int zynqmp_pm_afi(u32 config_id, u32 bus_width)
+{
+	return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_AFI,
+				   config_id, bus_width, NULL);
+}
+EXPORT_SYMBOL_GPL(zynqmp_pm_afi);
+
 /**
  * zynqmp_pm_set_boot_health_status() - PM API for setting healthy boot status
  * @value:	Status value to be written
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 9f50dacbf7d6..7d0d98303acc 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -78,6 +78,16 @@
 #define EVENT_ERROR_PSM_ERR1	(0x28108000U)
 #define EVENT_ERROR_PSM_ERR2	(0x2810C000U)
 
+#define AFIFM_BUS_WIDTH_128_CONFIG_VAL	0x0U
+#define AFIFM_BUS_WIDTH_64_CONFIG_VAL	0x1U
+#define AFIFM_BUS_WIDTH_32_CONFIG_VAL	0x2U
+
+#define AFIFS_SS0_SS2_BUS_WIDTH_128_CONFIG_VAL	0x200U
+#define AFIFS_SS0_SS2_BUS_WIDTH_64_CONFIG_VAL	0x100U
+#define AFIFS_SS1_BUS_WIDTH_128_CONFIG_VAL	0x800U
+#define AFIFS_SS1_BUS_WIDTH_64_CONFIG_VAL	0x400U
+#define AFIFS_SS_BUS_WIDTH_32_CONFIG_VAL	0x0U
+
 enum pm_api_cb_id {
 	PM_INIT_SUSPEND_CB = 30,
 	PM_ACKNOWLEDGE_CB = 31,
@@ -147,6 +157,7 @@ enum pm_ioctl_id {
 	IOCTL_READ_PGGS = 15,
 	/* Set healthy bit value */
 	IOCTL_SET_BOOT_HEALTH_STATUS = 17,
+	IOCTL_AFI = 18,
 	IOCTL_OSPI_MUX_SELECT = 21,
 	/* Register SGI to ATF */
 	IOCTL_REGISTER_SGI = 25,
@@ -155,6 +166,25 @@ enum pm_ioctl_id {
 	IOCTL_GET_FEATURE_CONFIG = 27,
 };
 
+enum pm_afi_config_id {
+	AFIFM0_RDCTRL = 0,
+	AFIFM0_WRCTRL = 1,
+	AFIFM1_RDCTRL = 2,
+	AFIFM1_WRCTRL = 3,
+	AFIFM2_RDCTRL = 4,
+	AFIFM2_WRCTRL = 5,
+	AFIFM3_RDCTRL = 6,
+	AFIFM3_WRCTRL = 7,
+	AFIFM4_RDCTRL = 8,
+	AFIFM4_WRCTRL = 9,
+	AFIFM5_RDCTRL = 10,
+	AFIFM5_WRCTRL = 11,
+	AFIFM6_RDCTRL = 12,
+	AFIFM6_WRCTRL = 13,
+	AFIFS = 14,
+	AFIFS_SS2 = 15,
+};
+
 enum pm_query_id {
 	PM_QID_INVALID = 0,
 	PM_QID_CLOCK_GET_NAME = 1,
@@ -475,6 +505,7 @@ int zynqmp_pm_is_function_supported(const u32 api_id, const u32 id);
 int zynqmp_pm_set_feature_config(enum pm_feature_config_id id, u32 value);
 int zynqmp_pm_get_feature_config(enum pm_feature_config_id id, u32 *payload);
 int zynqmp_pm_register_sgi(u32 sgi_num, u32 reset);
+int zynqmp_pm_afi(u32 config_id, u32 bus_width);
 #else
 static inline int zynqmp_pm_get_api_version(u32 *version)
 {
@@ -745,6 +776,11 @@ static inline int zynqmp_pm_register_sgi(u32 sgi_num, u32 reset)
 {
 	return -ENODEV;
 }
+
+static inline int zynqmp_pm_afi(u32 config_id, u32 bus_width)
+{
+	return -ENODEV;
+}
 #endif
 
 #endif /* __FIRMWARE_ZYNQMP_H__ */
-- 
2.25.1


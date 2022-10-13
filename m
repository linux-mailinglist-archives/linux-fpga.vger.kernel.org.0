Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 706D25FD6A5
	for <lists+linux-fpga@lfdr.de>; Thu, 13 Oct 2022 11:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiJMJG3 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 13 Oct 2022 05:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiJMJGV (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 13 Oct 2022 05:06:21 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2089.outbound.protection.outlook.com [40.107.96.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25FC122BE0;
        Thu, 13 Oct 2022 02:06:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b2IPx7EfyqVDFshximdP1Jmc32yUDo4//yjfEvJdPAnsDgn9pSugByubioUCaF19JXGgP6gcK4qmfsR8Tyu5XUICvxOeUYyDJh5ssnbDYg/QRCL50JfAxjMwAGRrHPWNuszwcbDSgz6XP+8zA2ue8Vndes4itqb2LOmB7spzpqaZHU+FG/v7loc0kCq8nDQCb6/UVocj1Ig+gT088bEUIQ3Ux5+oiy9diQr6wuzkGp58PgrcXLDuDD5xQ7PkNWZ5+3eBHykHm2AIMISa0FoYYOUjHoOmiAzt0lhErtazFna5PyL85OBGp+JseXnnIPBftiCYu/9zh3ocU+x62xV48Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gQHK3WlFdqHBGva3mKYYADCx9HNGT9ok7aYbfwSG/Go=;
 b=HlXUklA9t31PkN9xU4FvTrjniBsBz0C3nKuRi4zTPHBy2qVSNdMhBgSwdt8G+C/qw9fNNWfCuLP6Ni/a+mydaKL/mfNNf/IWrG6T8TTMoBfSgH7GTFtRVMeishokmfuTC0McqVGGnVkO2VZJGO6+xkQagxMxeekGiSLn4h7vpVpIAb1apr5Y1HJmNB7JIu2uY4WrCycZTUjU/AOosie4GV8HJ/2VFdoVU5YKA5D8zBfWR5Pi6EDT+h8KMSFWeRYeGBPoXkaq7XkT+/wnE4Os3G8gEsumA5LO+qaA+lvwTulvjhqYnnjqx9OjR2r4vec3RrX2GUI1VgF2tKtOVXgYgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=xilinx.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gQHK3WlFdqHBGva3mKYYADCx9HNGT9ok7aYbfwSG/Go=;
 b=RMnGi2o0lTqkxg1MS5KVg0h96Ugi+oCueMr198/FKuRSjtOjr5de2c8XmwZlrB4hXVMlDXTogeS2JYCdEi075B6YEmcvFOdiRmmjfFgmr0odBKkdiDlkymZQqxz6Uzl6oixGwPeOF4kFj3p0SYbkyPdIWSozEtBzF+5juvtRy8o=
Received: from MW4P223CA0018.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::23)
 by DM4PR12MB5168.namprd12.prod.outlook.com (2603:10b6:5:397::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21; Thu, 13 Oct
 2022 09:06:13 +0000
Received: from CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::da) by MW4P223CA0018.outlook.office365.com
 (2603:10b6:303:80::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.22 via Frontend
 Transport; Thu, 13 Oct 2022 09:06:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT013.mail.protection.outlook.com (10.13.174.227) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Thu, 13 Oct 2022 09:06:13 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 13 Oct
 2022 04:06:11 -0500
From:   Nava kishore Manne <nava.kishore.manne@amd.com>
To:     <git@xilinx.com>, <michal.simek@xilinx.com>, <mdf@kernel.org>,
        <hao.wu@intel.com>, <yilun.xu@intel.com>, <trix@redhat.com>,
        <gregkh@linuxfoundation.org>, <ronak.jain@xilinx.com>,
        <rajan.vaja@xilinx.com>, <abhyuday.godhasara@xilinx.com>,
        <nava.kishore.manne@amd.com>, <harsha.harsha@xilinx.com>,
        <lakshmi.sai.krishna.potthuri@xilinx.com>,
        <tanmay.shah@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-fpga@vger.kernel.org>
Subject: [PATCH v3 2/2] fpga: zynqmp-fpga: Adds status interface
Date:   Thu, 13 Oct 2022 14:35:56 +0530
Message-ID: <20221013090556.741357-3-nava.kishore.manne@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT013:EE_|DM4PR12MB5168:EE_
X-MS-Office365-Filtering-Correlation-Id: d7f05b45-a3c6-4750-8831-08daacfa2dc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hNGQmDfdaAGCdsbSOuPUAN967C48AZp+wNGvQwJwFPCnWvkZXy5CdeESvXTNKSRQUy5+6bagi08xWXTUxLWNQuHKaw5sklVYur/txi+GKe4N9LcOX+44pzAqx93+pUP2qzCds0beFKTuo6BLYNd8u67nkSqKgH23OG/c9iFttGCrJH7njN8dMWiuf6BkOiHaX1GWe7sB5lDwfjMZy07m5k0yw402/oQuvI3+Kr+o2lXnA8BZ6Dz4ItktUJWJ1AlS1hvqtCS3KKRXDL6p1S2UybowBnPNnD3KMKnvNOCQ4iAk6c60kItivp703nFQzUNLaWxpgZL/NdGIDn190Dp9gwaYbFdgjyLQYffnZtJPY5KXhjV6eHyIEuGLvEWnnacNDYDMEK7QuemLF7xHiz8awLFO24+CSj2auI/6nPcXQ7pKK41Dj4aG1G+yCUmg9D6d0yqIXEwp0lyflASAKZ4zuJ/2068UfFiN+Xy2AqQoPTjBN3RCVIPrxtStwoTh50mtxw/r8l6d2ajShu4XddB7swB9jQJmgbSYpWbFNGACmzMTl0hfIM8mU3R/SotWZzS7pGtsbzqgtMIWFe/mm97/VhuPmBF8C2VV9llOiQwPtuXT888CdlBGFd7/9R/wEvvFE8Pmec655n75F/CRWtkXCdVHlMeY+5uU1HrhEcv6zOYUWZAdb/ss3nDOmgJ14QCUKCSIR15wQufpR9JCNJvfNY9jvTYyz/sBUKt2SqKBAiHaymYQGD+qRfz4wvvgsu1M8Hw6d1p7xzeloTwDBBca1OgVjAlQo5v45CvxyoOtNp6VqhfsbiRhFQxcrmbSQT3pP5ZjYZmbJKX8zLKyXiRFZujw+mGO+KH3abdPdlQU0yy6YDtH1EjitL8j0aHRY0NL
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(39860400002)(396003)(376002)(451199015)(36840700001)(40470700004)(46966006)(82740400003)(110136005)(478600001)(82310400005)(16526019)(103116003)(40480700001)(2906002)(356005)(186003)(26005)(2616005)(81166007)(1076003)(336012)(83380400001)(6666004)(70206006)(86362001)(426003)(47076005)(70586007)(316002)(5660300002)(8936002)(8676002)(40460700003)(41300700001)(36756003)(36860700001)(921005)(83996005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2022 09:06:13.4243
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7f05b45-a3c6-4750-8831-08daacfa2dc1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5168
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Adds status interface for zynqmp-fpga, It's a read only interface
which allows the user to get the Programmable Logic(PL) configuration
status.

Usage:
To read the Programmable Logic(PL) configuration status
        cat /sys/class/fpga_manager/<fpga>/device/status

Signed-off-by: Nava kishore Manne <nava.kishore.manne@amd.com>
---
Changes for v2:
              - Updated status messages handling logic as suggested by Xu Yilun.

Changes for v3:
              - Updated status interface handling logic (Restrict the status
                interface to the device-specific instead of handled by the core)
                as suggested by Xu Yilun.

 drivers/fpga/zynqmp-fpga.c | 87 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/drivers/fpga/zynqmp-fpga.c b/drivers/fpga/zynqmp-fpga.c
index c60f20949c47..4e0295486c36 100644
--- a/drivers/fpga/zynqmp-fpga.c
+++ b/drivers/fpga/zynqmp-fpga.c
@@ -15,6 +15,37 @@
 /* Constant Definitions */
 #define IXR_FPGA_DONE_MASK	BIT(3)
 
+/* Error Register */
+#define IXR_FPGA_ERR_CRC_ERR		BIT(0)
+#define IXR_FPGA_ERR_SECURITY_ERR	BIT(16)
+
+/* Signal Status Register */
+#define IXR_FPGA_END_OF_STARTUP		BIT(4)
+#define IXR_FPGA_GST_CFG_B		BIT(5)
+#define IXR_FPGA_INIT_B_INTERNAL	BIT(11)
+#define IXR_FPGA_DONE_INTERNAL_SIGNAL	BIT(13)
+
+/* FPGA error status. */
+enum {
+	ZYNQMP_FPGA_STATUS_CRC_ERR,
+	ZYNQMP_FPGA_STATUS_SECURITY_ERR,
+	ZYNQMP_FPGA_STATUS_DEVICE_INIT_ERR,
+	ZYNQMP_FPGA_STATUS_SIGNAL_ERR,
+	ZYNQMP_FPGA_STATUS_HIGH_Z_STATE_ERR,
+	ZYNQMP_FPGA_STATUS_EOS_ERR,
+	ZYNQMP_FPGA_MGR_STATUS_FIRMWARE_REQ_ERR,
+};
+
+static const char * const zynqmp_fpga_error_statuses[] = {
+	[ZYNQMP_FPGA_STATUS_CRC_ERR] = "reconfig CRC error",
+	[ZYNQMP_FPGA_STATUS_SECURITY_ERR] = "reconfig security error",
+	[ZYNQMP_FPGA_STATUS_DEVICE_INIT_ERR] = "Device Initialization error",
+	[ZYNQMP_FPGA_STATUS_SIGNAL_ERR] = "Device internal signal error",
+	[ZYNQMP_FPGA_STATUS_HIGH_Z_STATE_ERR] = "All I/Os are placed in High-Z state",
+	[ZYNQMP_FPGA_STATUS_EOS_ERR] = "Device sequence error",
+	[ZYNQMP_FPGA_MGR_STATUS_FIRMWARE_REQ_ERR] = "firmware request error",
+};
+
 /**
  * struct zynqmp_fpga_priv - Private data structure
  * @dev:	Device data structure
@@ -77,6 +108,54 @@ static enum fpga_mgr_states zynqmp_fpga_ops_state(struct fpga_manager *mgr)
 	return FPGA_MGR_STATE_UNKNOWN;
 }
 
+static ssize_t status_show(struct device *dev,
+			   struct device_attribute *attr, char *buf)
+{
+	unsigned long status = 0;
+	ssize_t len = 0;
+	u32 reg_val;
+	int ret;
+	u8 i;
+
+	ret = zynqmp_pm_fpga_get_config_status(&reg_val);
+	if (!ret) {
+		if (reg_val & IXR_FPGA_ERR_CRC_ERR)
+			status |= ZYNQMP_FPGA_STATUS_CRC_ERR;
+		if (reg_val & IXR_FPGA_ERR_SECURITY_ERR)
+			status |= ZYNQMP_FPGA_STATUS_SECURITY_ERR;
+		if (!(reg_val & IXR_FPGA_INIT_B_INTERNAL))
+			status |= ZYNQMP_FPGA_STATUS_DEVICE_INIT_ERR;
+		if (!(reg_val & IXR_FPGA_DONE_INTERNAL_SIGNAL))
+			status |= ZYNQMP_FPGA_STATUS_SIGNAL_ERR;
+		if (!(reg_val & IXR_FPGA_GST_CFG_B))
+			status |= ZYNQMP_FPGA_STATUS_HIGH_Z_STATE_ERR;
+		if (!(reg_val & IXR_FPGA_END_OF_STARTUP))
+			status |= ZYNQMP_FPGA_STATUS_EOS_ERR;
+	} else {
+		status = ZYNQMP_FPGA_MGR_STATUS_FIRMWARE_REQ_ERR;
+	}
+
+	for_each_set_bit(i, &status, ARRAY_SIZE(zynqmp_fpga_error_statuses))
+		len += sysfs_emit_at(buf, len, "%s ",
+				     zynqmp_fpga_error_statuses[i]);
+
+	if (len)
+		buf[len - 1] = '\n';
+
+	return len;
+}
+
+static DEVICE_ATTR_RO(status);
+
+static struct attribute *zynqmp_fpga_device_attrs[] = {
+	&dev_attr_status.attr,
+	NULL,
+};
+
+static const struct attribute_group zynqmp_fpga_attr_group = {
+	.attrs = zynqmp_fpga_device_attrs,
+};
+
 static const struct fpga_manager_ops zynqmp_fpga_ops = {
 	.state = zynqmp_fpga_ops_state,
 	.write_init = zynqmp_fpga_ops_write_init,
@@ -88,6 +167,7 @@ static int zynqmp_fpga_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct zynqmp_fpga_priv *priv;
 	struct fpga_manager *mgr;
+	int ret;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -95,6 +175,13 @@ static int zynqmp_fpga_probe(struct platform_device *pdev)
 
 	priv->dev = dev;
 
+	/* Add the device attributes */
+	ret = sysfs_create_group(&dev->kobj, &zynqmp_fpga_attr_group);
+	if (ret) {
+		dev_err(dev, "Error creating sysfs files\n");
+		return ret;
+	}
+
 	mgr = devm_fpga_mgr_register(dev, "Xilinx ZynqMP FPGA Manager",
 				     &zynqmp_fpga_ops, priv);
 	return PTR_ERR_OR_ZERO(mgr);
-- 
2.25.1


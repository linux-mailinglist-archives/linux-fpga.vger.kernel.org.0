Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8920268297C
	for <lists+linux-fpga@lfdr.de>; Tue, 31 Jan 2023 10:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232220AbjAaJtE (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 31 Jan 2023 04:49:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232141AbjAaJsd (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 31 Jan 2023 04:48:33 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F7E1E5D0;
        Tue, 31 Jan 2023 01:48:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EJhwkE6axqfaeUuSadOHYs7pSFALwGPI3FjHv4atdmne6fbC/CqzqrJM/ZjdUZGZ8H7XOvDh+geuC8OR3qfMniKLhLbOPkg0DXpd+iTe/Bi/KjMteEeWhXd4TnPrTIn5FkxdqmZbobwi7n0ia7rfXkqW8bNof38Uq/dp8wlXG+js0KAKVY4//bkC4eVjkDzpLE5I2OBlh4jU3UweINDSHt0ftNGR/JTzj44Nj0E8ekAnz0qCEuqy/8cjnpEBFoUC1+TBLHd0eSZb8jgxGC7UkJPfnXpY+GXQyillLNz/VFQP2gWmEeXzx/yrDm3LlF/pKESx4eTT/fQfYIHFTXWiUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RcieFDkOP7s0IK53E+pYlAT/KhaaYrK49pL3I4189qs=;
 b=LBr9Z8bwib/oTrY6D/oohFuFoFg60LxpA3Hpp68f3zb0uDtVHSxC0OlzmmdcZaZJWTVTIo9N1okRTD/KaL5q/Hjw9Kx876uw+oMH/NnpC9oPJlHPYnS9KNvezOngPCrZsvPDhAo2Q8gO3EdKigzg9fh8L14sb3zdvezUMPRcB6RehO/dVc4eqRL2neRcKhU5+uf5DKjs8Vmpgt07CXkC7ZAyLOQsSnfRk3x3TjWPVDSxvnwZMgeNwEE9do7x2q7RlzPlx9CLefh6X5HSnmxvPE9Ht8icQ9GOrMAKxEOEF3ZczIjZGQ9hZl4212/gr1zLwjJunfszs9nLSpmH0IjZNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=xilinx.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RcieFDkOP7s0IK53E+pYlAT/KhaaYrK49pL3I4189qs=;
 b=YLZDCM4goWXZKklGR930mDVGgpqjvTOKDhYFKU47izveLoeFLD+pzbrwwpsU1eGMwC32ut/M0eqE3Pvy1fx1n1fqb3fI1vEl+YoIMjrgU5fQZRVin9ft1xGaCGx8tHtxixZVBBfb0ZBqZBy1ZoIP1CE2Yw5iagF3IZTJQmEmNO8=
Received: from MW4PR03CA0289.namprd03.prod.outlook.com (2603:10b6:303:b5::24)
 by IA0PR12MB8227.namprd12.prod.outlook.com (2603:10b6:208:406::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Tue, 31 Jan
 2023 09:48:24 +0000
Received: from CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::5e) by MW4PR03CA0289.outlook.office365.com
 (2603:10b6:303:b5::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38 via Frontend
 Transport; Tue, 31 Jan 2023 09:48:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT050.mail.protection.outlook.com (10.13.174.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.36 via Frontend Transport; Tue, 31 Jan 2023 09:48:22 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 31 Jan
 2023 03:48:20 -0600
From:   Nava kishore Manne <nava.kishore.manne@amd.com>
To:     <michal.simek@xilinx.com>, <mdf@kernel.org>, <hao.wu@intel.com>,
        <yilun.xu@intel.com>, <trix@redhat.com>,
        <nava.kishore.manne@amd.com>, <ronak.jain@xilinx.com>,
        <gregkh@linuxfoundation.org>, <tanmay.shah@xilinx.com>,
        <ben.levinsky@amd.com>, <rajan.vaja@xilinx.com>,
        <harsha.harsha@xilinx.com>, <mathieu.poirier@linaro.org>,
        <lakshmi.sai.krishna.potthuri@xilinx.com>, <arnd@arndb.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-fpga@vger.kernel.org>
Subject: [PATCH v5 2/2] fpga: zynqmp-fpga: Adds status interface
Date:   Tue, 31 Jan 2023 15:18:10 +0530
Message-ID: <20230131094810.1945541-3-nava.kishore.manne@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230131094810.1945541-1-nava.kishore.manne@amd.com>
References: <20230131094810.1945541-1-nava.kishore.manne@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT050:EE_|IA0PR12MB8227:EE_
X-MS-Office365-Filtering-Correlation-Id: e1e3c016-f12a-4221-4e34-08db03704ad5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HAfHSvG/9No2Ej7su/afx7qC02htMxgbu8hkoUJuY0rVyN9yXStCAa2kauUruYNw+8FZXkdI6mXuhoY6chSCToqbg9SWPk60w2vVrPxkpaabNwKw9soERP5OLcAhXNvtEsGXe3RPdqHupyiefyl5LvglYGpLMXvlMIJ9lJKGg09jY3POUVn7eHY5O/ayFGU/b2965slWr8/iyUTzIo6v/rwvHO0LgrGf/EMd8wiLdI6v1va4a/BfnjWGz41Otzym453EnjR6CSvZwmIhz+M59ayMnQyTXaWHh8n06MybLR9/yxj3PqNjBVgO9jNx7ZK7hMDHW5SUiP3bgJAAB1/CGVheGm0F9dw8L3F0Plae+URcLTyAM2F4uZxstlGRLtjw/PI/SidJZtqXH9DIAUjLiEBCoqciP/ZIGZBweBZ5avjINRBVE0tATW8n1c3F0ieobUN6QxLHalUTiduv72OsuhxCNLRon4aUd6H7P7CFHl1Z+rQ2FK3YN8uWhYuFBLarT5+2oWf5U/rFgNhl2MRR8W9i/mOI5M8LN1SgT/0s9k989MEWgcQql6hBbLYJ+8sNwR8PPl1UKdkn5n9g2mPSIA6AvBGYP9rRjCa/Ld2fB2O4ZGV7UTSJnWQND5aU1mM1cwU93k4NcLe+70naKu0mg6cREKyOx9Kv7sScSCklmlzFuL7t2AVIRxLDIm58XrsJ5l3DHWnfYhhG7Kc/4WKF3qItPNOddEcJsLYM1QNodVDufWUq2kiYsEeHI1qzddzheNYn0hiAgC7DWRGbdcr00mjEqFpYV215OzhRGk3N1p4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(346002)(376002)(39860400002)(451199018)(36840700001)(40470700004)(46966006)(70586007)(70206006)(82310400005)(8676002)(2616005)(82740400003)(86362001)(36860700001)(83380400001)(41300700001)(921005)(47076005)(426003)(336012)(8936002)(316002)(356005)(81166007)(16526019)(5660300002)(186003)(7416002)(110136005)(26005)(6666004)(478600001)(40460700003)(36756003)(2906002)(40480700001)(1076003)(103116003)(83996005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 09:48:22.8208
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1e3c016-f12a-4221-4e34-08db03704ad5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8227
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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

Changes for v4:
              - Limit the error strings to one word for each as suggested by
                Xu Yilun

Changes for v5:
              - Added new sysfs-driver-zynqmp-fpga file.

 .../ABI/testing/sysfs-driver-zynqmp-fpga      | 18 ++++
 drivers/fpga/zynqmp-fpga.c                    | 87 +++++++++++++++++++
 2 files changed, 105 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-zynqmp-fpga

diff --git a/Documentation/ABI/testing/sysfs-driver-zynqmp-fpga b/Documentation/ABI/testing/sysfs-driver-zynqmp-fpga
new file mode 100644
index 000000000000..66c98bb8dfba
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-zynqmp-fpga
@@ -0,0 +1,18 @@
+What:		/sys/class/fpga_manager/<fpga>/device/status
+Date:		Jan 2023
+KernelVersion:	6.2
+Contact:	Nava kishore Manne <nava.kishore.manne@amd.com>
+Description:	Read fpga status as a string.
+		If FPGA programming operation fails, it could be caused by crc
+		error or incompatible bitstream image. The intent of this
+		interface is to provide more detailed information for FPGA
+		programming errors to userspace. This is a list of strings for
+		the supported status.
+
+		* CRC-Error		- CRC error detected by hardware.
+		* Security-Error	- Security error detected by hardware.
+		* Initialization-Error	- Device Initialization error.
+		* Internal-Signal-Error	- Device internal signal error.
+		* I/Os-High-Z-state	- All I/Os are placed in High-Z state.
+		* Sequence-Error	- Device start-up sequence error.
+		* Firmware-Error	- Firmware error.
diff --git a/drivers/fpga/zynqmp-fpga.c b/drivers/fpga/zynqmp-fpga.c
index c60f20949c47..81d3e18527ee 100644
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
+	[ZYNQMP_FPGA_STATUS_CRC_ERR] = "CRC-Error",
+	[ZYNQMP_FPGA_STATUS_SECURITY_ERR] = "Security-Error",
+	[ZYNQMP_FPGA_STATUS_DEVICE_INIT_ERR] = "Initialization-Error",
+	[ZYNQMP_FPGA_STATUS_SIGNAL_ERR] = "Internal-Signal-Error",
+	[ZYNQMP_FPGA_STATUS_HIGH_Z_STATE_ERR] = "I/Os-High-Z-state",
+	[ZYNQMP_FPGA_STATUS_EOS_ERR] = "Sequence-Error",
+	[ZYNQMP_FPGA_MGR_STATUS_FIRMWARE_REQ_ERR] = "Firmware-Error",
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


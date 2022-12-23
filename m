Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E34D6654FF3
	for <lists+linux-fpga@lfdr.de>; Fri, 23 Dec 2022 13:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235518AbiLWL7U (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 23 Dec 2022 06:59:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbiLWL7H (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 23 Dec 2022 06:59:07 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF1540808;
        Fri, 23 Dec 2022 03:59:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mzFQL4+cYi1eHl40EANqzUjVB8Iv2lzryX2GFHJ9RMZtbAvsqhEdChEfSpTlf0PtE93gXYrwbmvQwoAfQyQgtt82Ck9s/157PlTJISMuzKeHgIooZFrx3GXS8B0MlXO1OhfHn8d4oZU0R8BLYsPQttF8IHgitHVwyYubxY8gRF65k5X0T8s51CPghg2WUMnIZjYLRuH4Fdzg4WJ0tVYD2YOIVvRPVUZ06J11sAvqE9ITSLwPX7UcEWJmiwugYBW2i6bb078WO9R56ebsLlb7krvTs65d/nJyq+dTXUTrMVKFVgj4WOVfcl6c3lTp4jred766+YpAwuHqSgDWSLXW5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jQK8n1QK5n2J428OVrvHJp/2LfJUm7/o3c1Sq01yt50=;
 b=X+7HOe8Z5YifmFR63h5JJXZBLch0Fq3zyEMlxn87/t4jd4F718wirV5BlDrJtp9dwdouTUc9pKlXokCOujeppiXUVM3HE/JQ5FOPJJzf0IY1NRHfFeEayn2bdTiZkBKPHZHOGDmnVs6Ex851gARw53wZE+/lzYpAgwID1GblroCt5+UVMqhgu+phWA8p1vPZMtsJ6axu2BigTx2T3DKHPsQBm0ZahpttbhURpBZVT5EIZVGekkhxyegICwYmShf4Ts3r16m+MequVSsi1epd/tSpNRDiy1eeEt8eMBzpEa65IuwwGO5W3A0ONmB5ZOfYXifEJTBBVmg0a093sp8d4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=xilinx.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jQK8n1QK5n2J428OVrvHJp/2LfJUm7/o3c1Sq01yt50=;
 b=qjjdBHyZrJhJ/j0b6fAnuW9wEKRmcU9y/9cFvuTIIwjhjKJ0484NSPzUbpULOHlrva9MXVPHeYDKOpcTnh+C9R2UySp5KPyluXaYINwVfD26WPqw6Y7z7tw4wlDyyHQJUv4ghxwqJHdr/HqYRdSRBy7ZQ1Hvx6AQh8zCryBEqaI=
Received: from CY5PR15CA0012.namprd15.prod.outlook.com (2603:10b6:930:14::12)
 by DS0PR12MB8576.namprd12.prod.outlook.com (2603:10b6:8:165::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Fri, 23 Dec
 2022 11:59:02 +0000
Received: from CY4PEPF0000C972.namprd02.prod.outlook.com
 (2603:10b6:930:14:cafe::dc) by CY5PR15CA0012.outlook.office365.com
 (2603:10b6:930:14::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.13 via Frontend
 Transport; Fri, 23 Dec 2022 11:59:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C972.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.8 via Frontend Transport; Fri, 23 Dec 2022 11:59:01 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 23 Dec
 2022 05:59:00 -0600
From:   Nava kishore Manne <nava.kishore.manne@amd.com>
To:     <michal.simek@xilinx.com>, <mdf@kernel.org>, <hao.wu@intel.com>,
        <yilun.xu@intel.com>, <trix@redhat.com>, <ronak.jain@xilinx.com>,
        <gregkh@linuxfoundation.org>, <tanmay.shah@xilinx.com>,
        <ben.levinsky@amd.com>, <harsha.harsha@xilinx.com>,
        <rajan.vaja@xilinx.com>, <nava.kishore.manne@amd.com>,
        <mathieu.poirier@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-fpga@vger.kernel.org>
Subject: [PATCH v4 2/2] fpga: zynqmp-fpga: Adds status interface
Date:   Fri, 23 Dec 2022 17:28:50 +0530
Message-ID: <20221223115850.2572573-3-nava.kishore.manne@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221223115850.2572573-1-nava.kishore.manne@amd.com>
References: <20221223115850.2572573-1-nava.kishore.manne@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C972:EE_|DS0PR12MB8576:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e5f2711-b7c4-4c62-5bb7-08dae4dd1506
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9jmn2UuDVDl6CgvqnPK4oVH0FaOKLQ0nicNgE/tddwPzW+5U2Q9E1qxSyPrytQgT5Hmnm4QUNG0tWRIAADcnXiKEC5X5QlyKhpqk+k5YnYINvbAO0/fMKYm/za+CaHe7/IAIvzA7Q1CiZKM0NpbW+jvWi9/w8/CIIZnYWJMmVKNo+uH8wnsbja3p8GAWYliZCQSZo2BkzOG2uG/aoSawCRcHAcSXRQS6X809XaujR1nEnxAWVX3KKTKF5Qqa262s4mcyn8RBfWDKar+gWqPhXoMjI5l99HzhL0UTywm2o9tsxF1uPnY+tEHeFd3jDdj1ik3y2OD041ip0LzlKG6Y+fw5i3rIl85QCDTDqQGpfyWJyV3HH/EZBb5g/h6CbsnZJf3nqxrZlW94Pxxp07hsD7gdzGq5m0tvvNoQhzjdwZ8Vy4fBS8mYsBOjqpEAIl9PXS2h3DPpseFVE7b65WDu4NCWBMpREb2keDLn2EbyJ1YG/aWRoz6cXKxPue2eTvsmDvAlxQW8lho/eaaXqF5/kZSzOa/eSRUOnEGtFhbYCG8lT0DrEIt+rnP9y06+0yn9a0k0gz66XE3ulcDEzgZmN04WkouwXFt4Mae5vFh5G51PSbSrRfTw/2qXmbdrAlGWQ2192RZ9HX4lsJ1w33dUdgmlJxSpI8dZCTmkoz2UZyawyyFdhnrksziodLMzgIx8nu5S6KPlw/BcSfY+Dnhft8lHFSVDkm5XGL/+S5vY4MqG1Pqu9+Q/xpf6iAt4GBgxOPcWyGMzvoDsHJ1Sy0tv1GukjdECgaWAnagAaipUT9I=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(376002)(396003)(39860400002)(451199015)(36840700001)(40470700004)(46966006)(2906002)(40480700001)(81166007)(478600001)(82740400003)(110136005)(316002)(8936002)(5660300002)(36756003)(86362001)(70206006)(70586007)(40460700003)(8676002)(47076005)(426003)(83380400001)(356005)(921005)(26005)(36860700001)(6666004)(336012)(2616005)(103116003)(41300700001)(1076003)(82310400005)(16526019)(186003)(2101003)(36900700001)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2022 11:59:01.6896
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e5f2711-b7c4-4c62-5bb7-08dae4dd1506
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C972.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8576
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

Changes for v4:
              - Limit the error strings to one word for each as suggested by
                Xu Yilun

 drivers/fpga/zynqmp-fpga.c | 87 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

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


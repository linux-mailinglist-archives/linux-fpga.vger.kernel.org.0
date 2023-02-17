Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48ABE69AACF
	for <lists+linux-fpga@lfdr.de>; Fri, 17 Feb 2023 12:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjBQLu6 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 17 Feb 2023 06:50:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbjBQLuy (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 17 Feb 2023 06:50:54 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4418366CF0;
        Fri, 17 Feb 2023 03:50:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FPNi8R8hIw3JVtnd50q2ZIgqUv6W9N5LHb+NiB+IxbyaRDF/kDAQ49j7FvX7EMqysqOIMq1f7KQ+W5r6IV3AF4L+KJ2HBdQ09wJF/ctBK94t5+wvkoU7URn5IvSgr+VuengXC+WfYGB53gjJ/TZHqi8njtdwOeJiUBQtw8Z8ZEEwLJ8uKFvetbp29gsby5AreB7KHobKkkUhn6CW2JooVNPe6AMPLkm1BxBqS6wMqZeQw5sEDR/bFn7OBHFTAskrisHuPclyByGzAxCpOh0Cpd5jsfxgbxD+wX5wL3mjCW+ZuLQ6xZyrwNnLv264MVSFcl7EzR24SP7yjj5ehy7ONQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=caIZEBUyI7NEf7NX/nbnttRbx4pfU4zy5ti6dk3Dq6M=;
 b=RfpPpUHyDDeSsbKRW++7TUyF/EMJ8j96wO1HS+LuDpdygbMjwSI+RAVmdEgHAbvbl79fkZ0sbazdcfAcgYeNIr4GQM1aSwBMuGhaHIHNhZV3pn/IUCAsDVctZMb6V5KmTYl8RUM19IidhbmYqKGdyFos0LNy9fkHPfgzEWy8EpXfeSUp+UYgjHmq/+tFxVvY11sJiBEb0VOerLFw6XsIWrWOMNARDRC/qKrRHbNLfdDVDXg0KKcrVv89pA09yc/DNsjqVGgXRoNbSlbLb8Ck0yXrZDeLNk4P61eIUu9Xgycvdy5S2UNYOI0PpxYd0NFKjwrRsfGj+3MtWOTxcXlmmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=xilinx.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=caIZEBUyI7NEf7NX/nbnttRbx4pfU4zy5ti6dk3Dq6M=;
 b=GFUSoJtXjIV9Bfz/5PcD3lMxYujYjnQ09Alre6JGTJnDwcUL0KGhJI8tr8K0CXn9aSralgp20iOeChe1n2sUQu4YKAcP3AhAITmBB5vXgdhgXZNddYwAUXKMauV1zXuL49ABmafsoTiDJIVhTqVEmEdBiv/WB1ho+y7NX95PNko=
Received: from BN9PR03CA0178.namprd03.prod.outlook.com (2603:10b6:408:f4::33)
 by PH8PR12MB6986.namprd12.prod.outlook.com (2603:10b6:510:1bd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.15; Fri, 17 Feb
 2023 11:50:48 +0000
Received: from BN8NAM11FT081.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f4:cafe::76) by BN9PR03CA0178.outlook.office365.com
 (2603:10b6:408:f4::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.13 via Frontend
 Transport; Fri, 17 Feb 2023 11:50:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT081.mail.protection.outlook.com (10.13.177.233) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6111.15 via Frontend Transport; Fri, 17 Feb 2023 11:50:48 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 17 Feb
 2023 05:50:46 -0600
From:   Nava kishore Manne <nava.kishore.manne@amd.com>
To:     <michal.simek@xilinx.com>, <mdf@kernel.org>, <hao.wu@intel.com>,
        <yilun.xu@intel.com>, <trix@redhat.com>,
        <nava.kishore.manne@amd.com>, <ronak.jain@xilinx.com>,
        <gregkh@linuxfoundation.org>, <tanmay.shah@xilinx.com>,
        <mathieu.poirier@linaro.org>, <ben.levinsky@amd.com>,
        <rajan.vaja@xilinx.com>, <harsha.harsha@xilinx.com>,
        <arnd@arndb.de>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-fpga@vger.kernel.org>
Subject: [PATCH v6 2/2] fpga: zynqmp-fpga: Adds status interface
Date:   Fri, 17 Feb 2023 17:20:36 +0530
Message-ID: <20230217115036.2617396-3-nava.kishore.manne@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230217115036.2617396-1-nava.kishore.manne@amd.com>
References: <20230217115036.2617396-1-nava.kishore.manne@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT081:EE_|PH8PR12MB6986:EE_
X-MS-Office365-Filtering-Correlation-Id: 9eb6a570-1607-44c0-197c-08db10dd35e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hR7K3RZCJw96g/O8P1hRgWBDcqzgneU1X/kIXq7A96RY9o7cQ/FSvW2eShm3d6Z4j4qyM+GbMqdKMPhR74azwQAjyp5g/ypE6oT4lkwX1SmPM1yA0fLEfzUP6JPfSSdktL/da3J8xFJaOqlXHQLdAFrEaN2IemuSy4leAm6+LkDqWpFyjisIJmIhj+ruIVOvgXT8vlEDQHlF/hvhtP+PjOGz/HHqXrJjrjLaH80KY37RZDM+Zs3AcVNqb1gFCmaCixABURYFngM0c/Jitmu02MJQ/ePx4g55etGt3X2jHqmZSURAoJkrg+CqBFbIlh79eSezs55FjgWqbzOrC1i6rmxeAPLNSliqFteHidXwJL9UziJGG0cgIObK2SF/RshOn7RnJ+AaXNW+WcLR2JWAX+HVKLXi/3uk5XHt0vL2PIaC6zFrRYPuSCUKpEeCxchGQDIPxPA8dricDj5kIakOdP9/rFcSNrVDZhj2Qkg57zUufcrWQqeeRL2NTXoPRzHN00i6iruHsHKfUCTKMerKg3l2241IX0uUt+L8mjyk2fm8gZOBvkN6fYI/4f5SmJSAc/Ma8t1yFmj0N4Lr5ZT6hhxTLaPEtRYAND5kErVsM2dw9vkIut/PwU/wTXI0yra63J7xeCjjUutg4gxJ1ynEPxv8EtnXt/KCb0uoJV45jCjXL1db78LL5nxuxGtAIhFHWiOPseW41ip/BUQ7hVq2F2Zg/r3pzScvHNsmcE4n9Gbpfgr6Ul8eKGec3dYyc8HWNDlrcm2VsfUR0+0DIkkoYjBHQnV5VQCuZHkmMFhL1Pw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(376002)(346002)(136003)(451199018)(40470700004)(46966006)(36840700001)(82310400005)(82740400003)(81166007)(36860700001)(103116003)(36756003)(316002)(110136005)(40480700001)(921005)(356005)(478600001)(83380400001)(40460700003)(47076005)(426003)(336012)(2616005)(6666004)(16526019)(26005)(186003)(1076003)(2906002)(7416002)(5660300002)(8936002)(41300700001)(86362001)(70206006)(8676002)(70586007)(83996005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2023 11:50:48.0430
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eb6a570-1607-44c0-197c-08db10dd35e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT081.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6986
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
	cat /sys/bus/platform/drivers/zynqmp_fpga_manager/
firmware:zynqmp-firmware:pcap/status

Signed-off-by: Nava kishore Manne <nava.kishore.manne@amd.com>
---
hanges for v2:
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

Changes for v6:
              - Updated the sysfs interface to cat /sys/bus/platform/drivers/...
		as suggested by Xu Yilun.
              - Exported raw hex value instead of multiple error strings
                as suggested by Greg.

 .../ABI/testing/sysfs-driver-zynqmp-fpga      | 72 +++++++++++++++++++
 drivers/fpga/zynqmp-fpga.c                    | 23 ++++++
 2 files changed, 95 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-zynqmp-fpga

diff --git a/Documentation/ABI/testing/sysfs-driver-zynqmp-fpga b/Documentation/ABI/testing/sysfs-driver-zynqmp-fpga
new file mode 100644
index 000000000000..af5d42916dd1
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-zynqmp-fpga
@@ -0,0 +1,72 @@
+What:		/sys/bus/platform/drivers/zynqmp_fpga_manager/firmware:zynqmp-firmware:pcap/status
+Date:		Jan 2023
+KernelVersion:	6.2
+Contact:	Nava kishore Manne <nava.kishore.manne@amd.com>
+Description:	(RO) Read fpga status.
+		Read returns a hexadecimal value that tells the current status
+                of the FPGA device. Each bit position in the status value is
+                described Below(see ug570 chapter 9).
+
+		======================  ==============================================
+		BIT(0)			0: No CRC error
+					1: CRC error
+
+		BIT(1)			0: Decryptor security not set
+					1: Decryptor security set
+
+		BIT(2)			0: MMCMs/PLLs are not locked
+					1: MMCMs/PLLs are locked
+
+		BIT(3)			0: DCI not matched
+					1: DCI matched
+
+		BIT(4)			0: Start-up sequence has not finished
+					1: Start-up sequence has finished
+
+		BIT(5)			0: All I/Os are placed in High-Z state
+					1: All I/Os behave as configured
+
+		BIT(6)			0: Flip-flops and block RAM are write disabled
+					1: Flip-flops and block RAM are write enabled
+
+		BIT(7)			0: GHIGH_B_STATUS asserted
+					1: GHIGH_B_STATUS deasserted
+
+		BIT(8) to BIT(10)	Status of the mode pins
+
+		BIT(11)			0: Initialization has not finished
+					1: Initialization finished
+
+		BIT(12)			Value on INIT_B_PIN pin
+
+		BIT(13)			0: Signal not released
+					1: Signal released
+
+		BIT(14)			Value on DONE_PIN pin.
+
+		BIT(15)			0: No IDCODE_ERROR
+					1: IDCODE_ERROR
+
+		BIT(16)			0: No SECURITY_ERROR
+					1: SECURITY_ERROR
+
+		BIT(17)			System Monitor over-temperature if set
+
+		BIT(18) to BIT(20)	Start-up state machine (0 to 7)
+					Phase 0 = 000
+					Phase 1 = 001
+					Phase 2 = 011
+					Phase 3 = 010
+					Phase 4 = 110
+					Phase 5 = 111
+					Phase 6 = 101
+					Phase 7 = 100
+
+		BIT(25) to BIT(26)	Indicates the detected bus width
+					00 = x1
+					01 = x8
+					10 = x16
+					11 = x32
+		======================  ==============================================
+
+		The other bits are reserved.
diff --git a/drivers/fpga/zynqmp-fpga.c b/drivers/fpga/zynqmp-fpga.c
index c60f20949c47..0c58ca27319f 100644
--- a/drivers/fpga/zynqmp-fpga.c
+++ b/drivers/fpga/zynqmp-fpga.c
@@ -77,6 +77,28 @@ static enum fpga_mgr_states zynqmp_fpga_ops_state(struct fpga_manager *mgr)
 	return FPGA_MGR_STATE_UNKNOWN;
 }
 
+static ssize_t status_show(struct device *dev,
+			   struct device_attribute *attr, char *buf)
+{
+	u32 status;
+	int ret;
+
+	ret = zynqmp_pm_fpga_get_config_status(&status);
+	if (ret)
+		return ret;
+
+	return sprintf(buf, "0x%x\n", status);
+}
+
+static DEVICE_ATTR_RO(status);
+
+static struct attribute *zynqmp_fpga_attrs[] = {
+	&dev_attr_status.attr,
+	NULL,
+};
+
+ATTRIBUTE_GROUPS(zynqmp_fpga);
+
 static const struct fpga_manager_ops zynqmp_fpga_ops = {
 	.state = zynqmp_fpga_ops_state,
 	.write_init = zynqmp_fpga_ops_write_init,
@@ -113,6 +135,7 @@ static struct platform_driver zynqmp_fpga_driver = {
 	.driver = {
 		.name = "zynqmp_fpga_manager",
 		.of_match_table = of_match_ptr(zynqmp_fpga_of_match),
+		.dev_groups = zynqmp_fpga_groups,
 	},
 };
 
-- 
2.25.1


Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC8206A1BF1
	for <lists+linux-fpga@lfdr.de>; Fri, 24 Feb 2023 13:10:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjBXMJJ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 24 Feb 2023 07:09:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjBXMJI (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 24 Feb 2023 07:09:08 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2060a.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8a::60a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342B1658E8;
        Fri, 24 Feb 2023 04:08:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cXRH1S1o3IGKS/HzDz0vKJZr3hsUDL3GJBz5JjDkvUHxXkZqwIVy57Z8QrHvCv/P8qTkjTF2FIfvNGdZuZ89e0FsnitZttjPtzHMLb84kfzafj7I4brbOfcJ/GvKBOdGWualHNIcaJK+KSvhEmY48rP+q5j3FET4ur2Uw3kmexSwrRiC/bNTF9ns0IyhHKGITguCTrQFlxThdHbscut6u+9bHrxRBJhuFcPvjT+a/iSJ6YAhUvITLcDKCbEJXMEyH7L09CA/PmINqoc8sxJJTtdFQ1H+QCF2uVJBf1hWp47jj09TrbCfYiICcNi/9JS6ZzV0MqROKyFRNn9CrqhLZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UY8aiAgk5qC6G8hQfDTAfZ1TFI+V5cb0zce0X0eQH6M=;
 b=axDy2IszDUOThqOdo1S/mfdCceutFIBwvLeWl5yPXmsC1ZBgEJVeYV/CvRD7EDvEf2bSrMzHxy5kCDCGHdI+9kb13fVhGD+FlE8fDb2lgIxJUqrAtR0cPjhcHDaJx0IT4KfHlJVxOvhX5Yneg62goVFmD0PV5s5dSarR99ie/uDeSqipr4apMSG9r1h+4QpwvsUt5sY+eswVRxwPpCF8YPHNDGNKLMmv5XUY8tIwyxmS9Xg+FMXhMONwK0dqoiozWrf/69YNsm9x/Bn2x2A/7z8nz852IpW9Fhs/YseeAjmrsESpnA3wIz+YqmdaPs32SxurylTUyEeXrMyOUEPUCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=xilinx.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UY8aiAgk5qC6G8hQfDTAfZ1TFI+V5cb0zce0X0eQH6M=;
 b=VO2AIC2IrK9ZkJGdgikxBR93yFjiQ5wBNlQesH3e5BgBecA9MPg4TD2K5Yn+zstDEa9jzCvJCA6+aQnObokbNxu1YcK0szkWAECZseEEGHcgAypoay7gC3u665fSxUZHiZvZIGMqVO6IzqJLsrnf7QCoIKjrbLjYOjdN0gl88V0=
Received: from BLAPR03CA0166.namprd03.prod.outlook.com (2603:10b6:208:32f::18)
 by PH7PR12MB6694.namprd12.prod.outlook.com (2603:10b6:510:1b1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19; Fri, 24 Feb
 2023 12:07:49 +0000
Received: from BL02EPF000108E8.namprd05.prod.outlook.com
 (2603:10b6:208:32f:cafe::12) by BLAPR03CA0166.outlook.office365.com
 (2603:10b6:208:32f::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.24 via Frontend
 Transport; Fri, 24 Feb 2023 12:07:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000108E8.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6134.16 via Frontend Transport; Fri, 24 Feb 2023 12:07:48 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 24 Feb
 2023 06:07:48 -0600
From:   Nava kishore Manne <nava.kishore.manne@amd.com>
To:     <michal.simek@xilinx.com>, <mdf@kernel.org>, <hao.wu@intel.com>,
        <yilun.xu@intel.com>, <trix@redhat.com>,
        <nava.kishore.manne@amd.com>, <ronak.jain@xilinx.com>,
        <gregkh@linuxfoundation.org>, <tanmay.shah@xilinx.com>,
        <mathieu.poirier@linaro.org>, <ben.levinsky@amd.com>,
        <rajan.vaja@xilinx.com>, <harsha.harsha@xilinx.com>,
        <arnd@arndb.de>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-fpga@vger.kernel.org>
Subject: [PATCH v7 2/2] fpga: zynqmp-fpga: Adds status interface
Date:   Fri, 24 Feb 2023 17:37:38 +0530
Message-ID: <20230224120738.329416-3-nava.kishore.manne@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230224120738.329416-1-nava.kishore.manne@amd.com>
References: <20230224120738.329416-1-nava.kishore.manne@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000108E8:EE_|PH7PR12MB6694:EE_
X-MS-Office365-Filtering-Correlation-Id: eccd1bae-0fca-49a3-016c-08db165fbf4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: knuy7uEOM8osNWOJ0Nex6vWU8ELM6wCFoSK3XsFMcBOvyPXiEX9XlrzIUHLvYk01W/PCvlXWtayp8tb8+ZSZyt/rEz3bcj6lWaZMj+rcRXXtgHuvUwmrbyk01g4gQ//2JU1FsDQSAFCJHevfTBZSR3OZ0hDo+ir6GosGb3k9qoDFVpVXIoxeOCr3gcTt/S0bOOJy9AbrDpT1OC+Qpmt/RLLKOfJ6FjwWKbTM+lXQSdSBml0YvxkD/0nSGze8emyhKq7cN7wYHCKlJXZRFgnd4aQ0GQQhXoHlqEIPNoIjuN12Mwk+dHhJJAtQnQDBqsVBXWxajLNBAFcxTgEALeMrqGLCHWDEbLCRBSnP+NjK52Kvg6ueV56y8nlFq50lqbXXarEfzNF6Uh4HOI8I7YHVIUQlvxLaDbx/EEyjxwC3KPGPx9R76/uwoht8R5Obk5PNSx7D9KzeZSxjPqog4NS5BP8CcUae5IFibHcGTTWQv2AaPKjxXRJszjaVgy9rpkPLLYnrWQ8l7/ZS9fY13xVBfRfD+LTnS0tX6wnjzJtoiu0FqpyIyENDw44HAEwvChLmrRAx5l+FPYvRmRrx7SRDDtchwkFl2RHs/tG1KqqF9iW9kQbw50DIgsj/stflDIla1O6ESO2Hi4u7avlyUGli+6RD07sUD995R9P2Fd+SoLlIAae8sbvl92BxPwCIsQW40YdYT/NN/+H+ZAQmlU9a/AjXBN+qpWDxBPuoMNOq/3dUVgTamg25YssOx4AZrbtNBZ5AYlQ2YwBBJYSkKeU+25h2/y/XIXc3thuTimJe+Vs=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(396003)(39860400002)(376002)(451199018)(36840700001)(40470700004)(46966006)(86362001)(5660300002)(2906002)(7416002)(82740400003)(41300700001)(426003)(81166007)(70206006)(8676002)(70586007)(36860700001)(82310400005)(316002)(36756003)(336012)(966005)(83380400001)(26005)(110136005)(40480700001)(8936002)(356005)(921005)(16526019)(6666004)(1076003)(47076005)(103116003)(2616005)(40460700003)(186003)(478600001)(36900700001)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2023 12:07:48.9590
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eccd1bae-0fca-49a3-016c-08db165fbf4a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000108E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6694
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Adds status interface for zynqmp-fpga. It's a read only interface
which allows the user to get the Programmable Logic(PL) configuration
status.

Usage:
To read the Programmable Logic(PL) configuration status.
cat /sys/bus/platform/drivers/zynqmp_fpga_manager/firmware:zynqmp-firmware:pcap/status

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

Changes for v6:
              - Updated the sysfs interface to cat /sys/bus/platform/drivers/...
                as suggested by Xu Yilun.
              - Exported raw hex value instead of multiple error strings
                as suggested by Greg.

Changes for v7:
              - Fixed some minor issues as suggested by Xu Yilun.

 .../ABI/testing/sysfs-driver-zynqmp-fpga      | 73 +++++++++++++++++++
 drivers/fpga/zynqmp-fpga.c                    | 21 ++++++
 2 files changed, 94 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-zynqmp-fpga

diff --git a/Documentation/ABI/testing/sysfs-driver-zynqmp-fpga b/Documentation/ABI/testing/sysfs-driver-zynqmp-fpga
new file mode 100644
index 000000000000..8f93d27b6d91
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-zynqmp-fpga
@@ -0,0 +1,73 @@
+What:		/sys/bus/platform/drivers/zynqmp_fpga_manager/firmware:zynqmp-firmware:pcap/status
+Date:		February 2023
+KernelVersion:	6.4
+Contact:	Nava kishore Manne <nava.kishore.manne@amd.com>
+Description:	(RO) Read fpga status.
+		Read returns a hexadecimal value that tells the current status
+		of the FPGA device. Each bit position in the status value is
+		described Below(see ug570 chapter 9).
+		https://docs.xilinx.com/v/u/en-US/ug570-ultrascale-configuration
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
index c60f20949c47..f3434e2c487b 100644
--- a/drivers/fpga/zynqmp-fpga.c
+++ b/drivers/fpga/zynqmp-fpga.c
@@ -77,6 +77,26 @@ static enum fpga_mgr_states zynqmp_fpga_ops_state(struct fpga_manager *mgr)
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
+	return sysfs_emit(buf, "0x%x\n", status);
+}
+static DEVICE_ATTR_RO(status);
+
+static struct attribute *zynqmp_fpga_attrs[] = {
+	&dev_attr_status.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(zynqmp_fpga);
+
 static const struct fpga_manager_ops zynqmp_fpga_ops = {
 	.state = zynqmp_fpga_ops_state,
 	.write_init = zynqmp_fpga_ops_write_init,
@@ -113,6 +133,7 @@ static struct platform_driver zynqmp_fpga_driver = {
 	.driver = {
 		.name = "zynqmp_fpga_manager",
 		.of_match_table = of_match_ptr(zynqmp_fpga_of_match),
+		.dev_groups = zynqmp_fpga_groups,
 	},
 };
 
-- 
2.25.1


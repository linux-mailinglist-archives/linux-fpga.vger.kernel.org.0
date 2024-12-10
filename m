Return-Path: <linux-fpga+bounces-980-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4988F9EB970
	for <lists+linux-fpga@lfdr.de>; Tue, 10 Dec 2024 19:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3720B280DAF
	for <lists+linux-fpga@lfdr.de>; Tue, 10 Dec 2024 18:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2562046BA;
	Tue, 10 Dec 2024 18:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iDdfLECX"
X-Original-To: linux-fpga@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CC2204560;
	Tue, 10 Dec 2024 18:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733855882; cv=fail; b=liqkqvGQGwkcFaM0xHv7gyA3ObPO7n0ZbJpby9Q2uYgsHQy62w/xjHU4lc+GmTfZ6ITjcEVnNZReWaRxpwjnLoafFGn6GnasEwHU1PokNSHhRePhamPW4SEbE/mz0QpryH7JHa+YwcnPBjmzASHA6kgEpPkMYrGDh+U+TXtyBrE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733855882; c=relaxed/simple;
	bh=pRujW3q7M3cb6eZ3WLuXAcZf3pSvABOjtEF5U6rvvv0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cr3tX3RdkxROfotMIjzw95R332VFkkISx57q5rWvdBaoajQ6WcnSwZvryqAwtN1P1gamS1J8WYbLSboq4vnsPHVA8uPgD5neyZ9TqR3AVFx4NL1cSDBKU/IOi0mNd9IPAcPu33b4rFC3mZEqz/TyUvWO9z1xUd1egPm6YzVLSxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iDdfLECX; arc=fail smtp.client-ip=40.107.236.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bP0NE9Nt6kq5Fwa1O8DRDbdKdCA3s7Wn+AuxFnWRF4TEwuHxt50vnfFH9LjBpJIuDTl+bni+tttSeljxiX4wSiC10OttZTq0gh5BeQl88ltRO9gJP/zfKPCRh71z1zDKiEf67sSVFlFzjdYLJFKKNmz0k/2GBTbSCPoLLNiwKb9ZEykGmP0nUKCMwhqZNSRpiD4SxngA3nw0iElWGHGxM/ADoha/J3fIEUpeeg8QE3zsCj/jJBe3pg4JKyP6dYXTMxJa9LM21ZCacHohI/eUvTCWpODfiJtK52xBGhtE5v7idEcYhmN1AB517FeM/BQ3LwEWG18JXb5EfTZSf4fbsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tdREsDzyVJR57/05d5vJn3b91G3BJJCrMraFtWha6eg=;
 b=qt4A7ATn1PjQi1SsZgcpvL0+pDUHOPwdrg4mqeL+vV75Dm1qn/v/2/gk/9oRUlQ+AdZwFMeR4L4DWuZzQ7p1ADJ+9fQGNX/4a2VHjlAXhFqVaecQuem/3Bv6dfkHVD3wFtNMBx+JLaL0j+19jLZy7zaxLs2F3gg8rGm9sxRQpb8hRU+2QFSXdzvrdpLQM+QWMpPTu44ub5pMaEYC23Xe/CBaP4JkhrJKZJ9H0q5LPgKVu+KPv9+NVpzyozAVl5Mb/5yEX8caEASRQ2oFl7Rx1aMkYxiBmeCW3nSA4JOHaMfwuccrTHvnM/i6XtrVB+6JiO1xFfnafYEffjwhyVriEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tdREsDzyVJR57/05d5vJn3b91G3BJJCrMraFtWha6eg=;
 b=iDdfLECXIvIBiKdO4YR7DxFsz9NCVxl47YmIePXDg9j9paO0V6VIKvCRgWeZUWoL5Mk/bVf+39g90CbCVHnSbRjOABytC0Cfmcy+3EikJcLCqcPemTOgma9qye5UZ0eWJYOBQgid7qNDUPWIawRaqdZhU8n2hJTL3axTiTEb36c=
Received: from SN7PR04CA0225.namprd04.prod.outlook.com (2603:10b6:806:127::20)
 by CH0PR12MB8529.namprd12.prod.outlook.com (2603:10b6:610:18d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Tue, 10 Dec
 2024 18:37:53 +0000
Received: from SN1PEPF000252A3.namprd05.prod.outlook.com
 (2603:10b6:806:127:cafe::ca) by SN7PR04CA0225.outlook.office365.com
 (2603:10b6:806:127::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.15 via Frontend Transport; Tue,
 10 Dec 2024 18:37:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A3.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Tue, 10 Dec 2024 18:37:53 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Dec
 2024 12:37:52 -0600
Received: from xsjyliu51.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 10 Dec 2024 12:37:52 -0600
From: Yidong Zhang <yidong.zhang@amd.com>
To: <linux-kernel@vger.kernel.org>, <linux-fpga@vger.kernel.org>,
	<mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>
CC: Yidong Zhang <yidong.zhang@amd.com>, <lizhi.hou@amd.com>, DMG Karthik
	<Karthik.DMG@amd.com>, Nishad Saraf <nishads@amd.com>, Prapul Krishnamurthy
	<prapulk@amd.com>, Hayden Laccabue <hayden.laccabue@amd.com>
Subject: [PATCH V2 1/4] drivers/fpga/amd: Add new driver amd versal-pci
Date: Tue, 10 Dec 2024 10:37:30 -0800
Message-ID: <20241210183734.30803-2-yidong.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241210183734.30803-1-yidong.zhang@amd.com>
References: <20241210183734.30803-1-yidong.zhang@amd.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: yidong.zhang@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A3:EE_|CH0PR12MB8529:EE_
X-MS-Office365-Filtering-Correlation-Id: aabfae20-d2f1-4bea-08e5-08dd1949c215
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CmT7TenKLtLXaqSBzS9GT8sAk9R5ft/49vjjYOQ7FAeu43iWkOaanlQzQxpQ?=
 =?us-ascii?Q?rVwyEuCgntYLN8kANt6dbBoEJm0vLj1nNJypWIgatIcMBjpfQDEUoasd6lZt?=
 =?us-ascii?Q?d/4t0ULqV/m+ijFbAAa9liydb3qFa9QKYfcpie50r2AKGXBlbwkS6cuIySJP?=
 =?us-ascii?Q?C/a55hRkGpMjnvLXF+e6gTLg///3CHragSr9mntd67He+L0zViUc7hf5vK/z?=
 =?us-ascii?Q?xubr8TPbkJ0h/1jh5xVjaIwBUTmEGtBGby/4eb1Nl+RLeDz7aKN+lmMHc6Ro?=
 =?us-ascii?Q?8G0gp51K7/fkLeCA5fqzijs++Yti7YAkJlNoXIq6qy2OzAm/UUAN0bpBsaEl?=
 =?us-ascii?Q?UaC8j+4NyPFkZYzCu7g4OQnqbvCYRJ0v1DOhD2MITZ1Ax06rw7PKZqFWOg+g?=
 =?us-ascii?Q?9kX9y1nF4BV3L6vZA1iA90AeZvBRkyEhHgcjgp1byXvJAlFMdilPhlS8mV00?=
 =?us-ascii?Q?xO2HY8DHwkLcqugrI8tDUxPJNA4Qm+D2AaShvMrU3nJmBJzTBrRbPVhLlxbO?=
 =?us-ascii?Q?axlHMPCUi9OgaEgrIi48eTxBCWrtryg4wxQd+vCHJ/g3gMs4zRIdddFLovk1?=
 =?us-ascii?Q?9jSqrSPvyoVt+a6A6DAeoVpn0hJFiCb/65dbGvgFdCSPl2po9xgTWhbQT0MW?=
 =?us-ascii?Q?bb0a+4fIkb7ZtvHX6nfHsPKw47eTYUL9J3e25z9ym1x6O1eItZe0wpi75mxM?=
 =?us-ascii?Q?b6CliQ9jfz1uwpD7HO08KM+cR4xN0nWwE/uK7wUmJNLAVTB9APStqGlNmEm6?=
 =?us-ascii?Q?HsPRo2XIZJHjhhRuxyosPRreW14MN9sl9cEjPSLeBioASVH1naimKsB3kYte?=
 =?us-ascii?Q?zyyeWwOS/D3227TDpil5siCtwMebQisXz7jgfji7iBpN27AYsEXue7G+3n/M?=
 =?us-ascii?Q?39sL2aYwGb85N7bzLUllKV6s9ZWuXcUNpSZuwdptUojvRB1CV5NtkDSo3QmB?=
 =?us-ascii?Q?RL/YEbUnMHe+JaltepV2crVObo7LOM/2Li9/myq7HdG5HjRmYmW0ynf138fS?=
 =?us-ascii?Q?AUFvoN/ZFt4hjPN6YBXYexr9qbLtp4u6e8xxzw132HCvCO7lqbGchTeLV2M0?=
 =?us-ascii?Q?Brh5xubIe/F8dZnTO4wqZr9aFTxP5qDu+d47USvM3Dt0kuQQ06f9gVes8fZl?=
 =?us-ascii?Q?42JOctq/TTeeRSJZaJRmqy621z1D1GMQfcyKTPMD/kNsOokrQRpGnPfHOTgq?=
 =?us-ascii?Q?rJtndQa5cy70ZDvan5G0KTamDNgBVMpwPAbc4gdRFQmNgEfzqXNAvq+FTWAF?=
 =?us-ascii?Q?EXSWCoPDoI2VsCaHRbjEFzKkKm0bCCJZ/9zAZxvb4MKNZd5S13hBnB9J8y6o?=
 =?us-ascii?Q?ggK+ownkQt/dT3Ed4rJioBk/Bol1f5YU8tkCLv8daGY+dbboA+GXVe/bVHYS?=
 =?us-ascii?Q?q94C3Qm/Q0HjkLXG8nfbmlvRNX0eaq+zWw7SjNE/c6M/7gBtkm64AVq8PuCn?=
 =?us-ascii?Q?IGvAyOak0eyuTaql2Hvvr1OA+kivFLR/?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 18:37:53.5162
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aabfae20-d2f1-4bea-08e5-08dd1949c215
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8529

AMD Versal based PCIe card, including V70, is designed for AI inference
efficiency and is tuned for video analytics and natural language processing
applications.

The driver architecture:

  +---------+  Communication +---------+  Remote  +-----+------+
  |         |  Channel       |         |  Queue   |     |      |
  | User PF | <============> | Mgmt PF | <=======>| FW  | FPGA |
  +---------+                +---------+          +-----+------+
    PL Data                    base FW
                               APU FW
                               PL Data (copy)
 - PL (FPGA Program Logic)
 - FW (Firmware)

There are 2 separate drivers from the original XRT[1] design.
 - UserPF driver
 - MgmtPF driver

The new AMD versal-pci driver will replace the MgmtPF driver for Versal
PCIe card.

The XRT[1] is already open-sourced. It includes solution of runtime for
many different type of PCIe Based cards. It also provides utilities for
managing and programming the devices.

The AMD versal-pci stands for AMD Versal brand PCIe device management
driver. This driver provides the following functionalities:

   - module and PCI device initialization
     this driver will attach to specific device id of V70 card;
     the driver will initialize itself based on bar resources for
     - communication channel:
       a hardware message service between mgmt PF and user PF
     - remote queue:
       a hardware queue based ring buffer service between mgmt PF and PCIe
       hardware firmware for programming FPGA Program Logic, loading
       firmware and checking card healthy status.

   - programming FW
     - The base FW is downloaded onto the flash of the card.
     - The APU FW is downloaded once after a POR (power on reset).
     - Reloading the MgmtPF driver will not change any existing hardware.

   - programming FPGA hardware binaries - PL Data
    - using fpga framework ops to support re-programing FPGA
    - the re-programming request will be initiated from the existing UserPF
      driver only, and the MgmtPF driver load the matched PL Data after
      receiving request from the communication channel. The matching PL
      Data is indexed by the PL Data UUID and Base FW UUID.
      - The Base FW UUID identifies unique based hardware. Often called the
      interface UUID.
      - The PL Data UUID identifies unique PL design that is generated
      based on the base hardware. Often called xclbin UUID.

    - Example:
      4fdebe35[...trimmed...]_96df7d[...trimmed...].xclbin
      |                     | |                   |
      +--  xclbin UUID    --+ +--interface UUID --+

[1] https://github.com/Xilinx/XRT/blob/master/README.rst

Co-developed-by: DMG Karthik <Karthik.DMG@amd.com>
Signed-off-by: DMG Karthik <Karthik.DMG@amd.com>
Co-developed-by: Nishad Saraf <nishads@amd.com>
Signed-off-by: Nishad Saraf <nishads@amd.com>
Co-developed-by: Prapul Krishnamurthy <prapulk@amd.com>
Signed-off-by: Prapul Krishnamurthy <prapulk@amd.com>
Co-developed-by: Hayden Laccabue <hayden.laccabue@amd.com>
Signed-off-by: Hayden Laccabue <hayden.laccabue@amd.com>
Signed-off-by: Yidong Zhang <yidong.zhang@amd.com>
---
 MAINTAINERS                        |   6 +
 drivers/fpga/Kconfig               |   3 +
 drivers/fpga/Makefile              |   3 +
 drivers/fpga/amd/Kconfig           |  15 ++
 drivers/fpga/amd/Makefile          |   5 +
 drivers/fpga/amd/versal-pci-main.c | 328 +++++++++++++++++++++++++++++
 drivers/fpga/amd/versal-pci.h      |  86 ++++++++
 7 files changed, 446 insertions(+)
 create mode 100644 drivers/fpga/amd/Kconfig
 create mode 100644 drivers/fpga/amd/Makefile
 create mode 100644 drivers/fpga/amd/versal-pci-main.c
 create mode 100644 drivers/fpga/amd/versal-pci.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 17daa9ee9384..302c10004c5d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1194,6 +1194,12 @@ L:	linux-spi@vger.kernel.org
 S:	Supported
 F:	drivers/spi/spi-amd.c
 
+AMD VERSAL PCI DRIVER
+M:	Yidong Zhang <yidong.zhang@amd.com>
+L:	linux-fpga@vger.kernel.org
+S:	Supported
+F:	drivers/fpga/amd/
+
 AMD XGBE DRIVER
 M:	"Shyam Sundar S K" <Shyam-sundar.S-k@amd.com>
 L:	netdev@vger.kernel.org
diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 37b35f58f0df..dce060a7bd8f 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -290,4 +290,7 @@ config FPGA_MGR_LATTICE_SYSCONFIG_SPI
 
 source "drivers/fpga/tests/Kconfig"
 
+# Driver files
+source "drivers/fpga/amd/Kconfig"
+
 endif # FPGA
diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
index aeb89bb13517..8412f3e211cc 100644
--- a/drivers/fpga/Makefile
+++ b/drivers/fpga/Makefile
@@ -58,5 +58,8 @@ obj-$(CONFIG_FPGA_DFL_NIOS_INTEL_PAC_N3000)	+= dfl-n3000-nios.o
 # Drivers for FPGAs which implement DFL
 obj-$(CONFIG_FPGA_DFL_PCI)		+= dfl-pci.o
 
+# AMD PCIe Versal Management Driver
+obj-$(CONFIG_AMD_VERSAL_PCI)		+= amd/
+
 # KUnit tests
 obj-$(CONFIG_FPGA_KUNIT_TESTS)		+= tests/
diff --git a/drivers/fpga/amd/Kconfig b/drivers/fpga/amd/Kconfig
new file mode 100644
index 000000000000..b18a42a340ba
--- /dev/null
+++ b/drivers/fpga/amd/Kconfig
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config AMD_VERSAL_PCI
+	tristate "AMD Versal PCIe Management Driver"
+	select FW_LOADER
+	select FW_UPLOAD
+	depends on FPGA
+	depends on HAS_IOMEM
+	depends on PCI
+	help
+	  AMD Versal PCIe Management Driver provides management services to
+	  download firmware, program bitstream, and communicate with the User
+	  function.
+
+	  If "M" is selected, the driver module will be versal-pci
diff --git a/drivers/fpga/amd/Makefile b/drivers/fpga/amd/Makefile
new file mode 100644
index 000000000000..5d1ef04b5e80
--- /dev/null
+++ b/drivers/fpga/amd/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_AMD_VERSAL_PCI)			+= versal-pci.o
+
+versal-pci-$(CONFIG_AMD_VERSAL_PCI)		:= versal-pci-main.o
diff --git a/drivers/fpga/amd/versal-pci-main.c b/drivers/fpga/amd/versal-pci-main.c
new file mode 100644
index 000000000000..a10ccf86802b
--- /dev/null
+++ b/drivers/fpga/amd/versal-pci-main.c
@@ -0,0 +1,328 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for Versal PCIe device
+ *
+ * Copyright (C) 2024 Advanced Micro Devices, Inc. All rights reserved.
+ */
+
+#include <linux/pci.h>
+
+#include "versal-pci.h"
+
+#define DRV_NAME			"amd-versal-pci"
+
+#define PCI_DEVICE_ID_V70PQ2		0x50B0
+#define VERSAL_XCLBIN_MAGIC_ID		"xclbin2"
+
+static int versal_pci_fpga_write_init(struct fpga_manager *mgr, struct fpga_image_info *info,
+				      const char *buf, size_t count)
+{
+	/* TODO */
+	return 0;
+}
+
+static int versal_pci_fpga_write(struct fpga_manager *mgr, const char *buf,
+				 size_t count)
+{
+	/* TODO */
+	return 0;
+}
+
+static int versal_pci_fpga_write_complete(struct fpga_manager *mgr,
+					  struct fpga_image_info *info)
+{
+	/* TODO */
+	return 0;
+}
+
+static enum fpga_mgr_states versal_pci_fpga_state(struct fpga_manager *mgr)
+{
+	struct fpga_device *fdev = mgr->priv;
+
+	return fdev->state;
+}
+
+static const struct fpga_manager_ops versal_pci_fpga_ops = {
+	.write_init = versal_pci_fpga_write_init,
+	.write = versal_pci_fpga_write,
+	.write_complete = versal_pci_fpga_write_complete,
+	.state = versal_pci_fpga_state,
+};
+
+static void versal_pci_fpga_fini(struct fpga_device *fdev)
+{
+	fpga_mgr_unregister(fdev->mgr);
+}
+
+static void versal_pci_uuid_parse(struct versal_pci_device *vdev, uuid_t *uuid)
+{
+	char str[UUID_STRING_LEN];
+	u8 i, j;
+
+	/* parse uuid into a valid uuid string format */
+	for (i  = 0, j = 0; i < strlen(vdev->fw_id) && i < sizeof(str); i++) {
+		str[j++] = vdev->fw_id[i];
+		if (j == 8 || j == 13 || j == 18 || j == 23)
+			str[j++] = '-';
+	}
+
+	uuid_parse(str, uuid);
+	vdev_info(vdev, "Interface uuid %pU", uuid);
+}
+
+static struct fpga_device *versal_pci_fpga_init(struct versal_pci_device *vdev)
+{
+	struct device *dev = &vdev->pdev->dev;
+	struct fpga_manager_info info = { 0 };
+	struct fpga_device *fdev;
+	int ret;
+
+	fdev = devm_kzalloc(dev, sizeof(*fdev), GFP_KERNEL);
+	if (!fdev)
+		return ERR_PTR(-ENOMEM);
+
+	fdev->vdev = vdev;
+
+	info = (struct fpga_manager_info) {
+		.name = "AMD Versal FPGA Manager",
+		.mops = &versal_pci_fpga_ops,
+		.priv = fdev,
+	};
+
+	fdev->mgr = fpga_mgr_register_full(dev, &info);
+	if (IS_ERR(fdev->mgr)) {
+		ret = PTR_ERR(fdev->mgr);
+		vdev_err(vdev, "Failed to register FPGA manager, err %d", ret);
+		return ERR_PTR(ret);
+	}
+
+	/* Place holder for rm_queue_get_fw_id(vdev->rdev) */
+	versal_pci_uuid_parse(vdev, &vdev->intf_uuid);
+
+	return fdev;
+}
+
+static int versal_pci_program_axlf(struct versal_pci_device *vdev, char *data, size_t size)
+{
+	const struct axlf *axlf = (struct axlf *)data;
+	struct fpga_image_info *image_info;
+	int ret;
+
+	image_info = fpga_image_info_alloc(&vdev->pdev->dev);
+	if (!image_info)
+		return -ENOMEM;
+
+	image_info->count = axlf->header.length;
+	image_info->buf = (char *)axlf;
+
+	ret = fpga_mgr_load(vdev->fdev->mgr, image_info);
+	if (ret) {
+		vdev_err(vdev, "failed to load xclbin: %d", ret);
+		goto exit;
+	}
+
+	vdev_info(vdev, "Downloaded axlf %pUb of size %zu Bytes", &axlf->header.uuid, size);
+	uuid_copy(&vdev->xclbin_uuid, &axlf->header.uuid);
+
+exit:
+	fpga_image_info_free(image_info);
+
+	return ret;
+}
+
+int versal_pci_load_xclbin(struct versal_pci_device *vdev, uuid_t *xuuid)
+{
+	const char *xclbin_location = "xilinx/xclbins";
+	char fw_name[100];
+	const struct firmware *fw;
+	int ret;
+
+	snprintf(fw_name, sizeof(fw_name), "%s/%pUb_%s.xclbin",
+		 xclbin_location, xuuid, vdev->fw_id);
+
+	vdev_info(vdev, "trying to load %s", fw_name);
+	ret = request_firmware(&fw, fw_name, &vdev->pdev->dev);
+	if (ret) {
+		vdev_warn(vdev, "request xclbin fw %s failed %d", fw_name, ret);
+		return ret;
+	}
+	vdev_info(vdev, "loaded data size %zu", fw->size);
+
+	ret = versal_pci_program_axlf(vdev, (char *)fw->data, fw->size);
+	if (ret)
+		vdev_err(vdev, "program axlf %s failed %d", fw_name, ret);
+
+	release_firmware(fw);
+
+	return ret;
+}
+
+static enum fw_upload_err versal_pci_fw_prepare(struct fw_upload *fw_upload, const u8 *data,
+						u32 size)
+{
+	/* TODO */
+	return FW_UPLOAD_ERR_NONE;
+}
+
+static enum fw_upload_err versal_pci_fw_write(struct fw_upload *fw_upload, const u8 *data,
+					      u32 offset, u32 size, u32 *written)
+{
+	/* TODO */
+	return FW_UPLOAD_ERR_NONE;
+}
+
+static enum fw_upload_err versal_pci_fw_poll_complete(struct fw_upload *fw_upload)
+{
+	/* TODO */
+	return FW_UPLOAD_ERR_NONE;
+}
+
+static void versal_pci_fw_cancel(struct fw_upload *fw_upload)
+{
+	/* TODO */
+}
+
+static void versal_pci_fw_cleanup(struct fw_upload *fw_upload)
+{
+	/* TODO */
+}
+
+static const struct fw_upload_ops versal_pci_fw_ops = {
+	.prepare = versal_pci_fw_prepare,
+	.write = versal_pci_fw_write,
+	.poll_complete = versal_pci_fw_poll_complete,
+	.cancel = versal_pci_fw_cancel,
+	.cleanup = versal_pci_fw_cleanup,
+};
+
+static void versal_pci_fw_upload_fini(struct firmware_device *fwdev)
+{
+	firmware_upload_unregister(fwdev->fw);
+	kfree(fwdev->name);
+}
+
+static u32 versal_pci_devid(struct versal_pci_device *vdev)
+{
+	return ((pci_domain_nr(vdev->pdev->bus) << 16) |
+		PCI_DEVID(vdev->pdev->bus->number, vdev->pdev->devfn));
+}
+
+static struct firmware_device *versal_pci_fw_upload_init(struct versal_pci_device *vdev)
+{
+	struct device *dev = &vdev->pdev->dev;
+	struct firmware_device *fwdev;
+	u32 devid;
+
+	fwdev = devm_kzalloc(dev, sizeof(*fwdev), GFP_KERNEL);
+	if (!fwdev)
+		return ERR_PTR(-ENOMEM);
+
+	devid = versal_pci_devid(vdev);
+	fwdev->name = kasprintf(GFP_KERNEL, "%s%x", DRV_NAME, devid);
+	if (!fwdev->name)
+		return ERR_PTR(-ENOMEM);
+
+	fwdev->fw = firmware_upload_register(THIS_MODULE, dev, fwdev->name,
+					     &versal_pci_fw_ops, fwdev);
+	if (IS_ERR(fwdev->fw)) {
+		kfree(fwdev->name);
+		return ERR_CAST(fwdev->fw);
+	}
+
+	fwdev->vdev = vdev;
+
+	return fwdev;
+}
+
+static void versal_pci_device_teardown(struct versal_pci_device *vdev)
+{
+	versal_pci_fpga_fini(vdev->fdev);
+	versal_pci_fw_upload_fini(vdev->fwdev);
+}
+
+static int versal_pci_device_setup(struct versal_pci_device *vdev)
+{
+	int ret;
+
+	vdev->fwdev = versal_pci_fw_upload_init(vdev);
+	if (IS_ERR(vdev->fwdev)) {
+		ret = PTR_ERR(vdev->fwdev);
+		vdev_err(vdev, "Failed to init FW uploader, err %d", ret);
+		return ret;
+	}
+
+	vdev->fdev = versal_pci_fpga_init(vdev);
+	if (IS_ERR(vdev->fdev)) {
+		ret = PTR_ERR(vdev->fdev);
+		vdev_err(vdev, "Failed to init FPGA manager, err %d", ret);
+		goto upload_fini;
+	}
+
+	return 0;
+
+upload_fini:
+	versal_pci_fw_upload_fini(vdev->fwdev);
+
+	return ret;
+}
+
+static void versal_pci_remove(struct pci_dev *pdev)
+{
+	struct versal_pci_device *vdev = pci_get_drvdata(pdev);
+
+	versal_pci_device_teardown(vdev);
+}
+
+static int versal_pci_probe(struct pci_dev *pdev, const struct pci_device_id *pdev_id)
+{
+	struct versal_pci_device *vdev;
+	int ret;
+
+	vdev = devm_kzalloc(&pdev->dev, sizeof(*vdev), GFP_KERNEL);
+	if (!vdev)
+		return -ENOMEM;
+
+	pci_set_drvdata(pdev, vdev);
+	vdev->pdev = pdev;
+
+	ret = pcim_enable_device(pdev);
+	if (ret) {
+		vdev_err(vdev, "Failed to enable device %d", ret);
+		return ret;
+	}
+
+	vdev->io_regs = pcim_iomap_region(vdev->pdev, MGMT_BAR, DRV_NAME);
+	if (IS_ERR(vdev->io_regs)) {
+		vdev_err(vdev, "Failed to map RM shared memory BAR%d", MGMT_BAR);
+		return PTR_ERR(vdev->io_regs);
+	}
+
+	ret = versal_pci_device_setup(vdev);
+	if (ret) {
+		vdev_err(vdev, "Failed to setup Versal device %d", ret);
+		return ret;
+	}
+
+	vdev_dbg(vdev, "Successfully probed %s driver!", DRV_NAME);
+	return 0;
+}
+
+static const struct pci_device_id versal_pci_ids[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_XILINX, PCI_DEVICE_ID_V70PQ2), },
+	{ 0 }
+};
+
+MODULE_DEVICE_TABLE(pci, versal_pci_ids);
+
+static struct pci_driver versal_pci_driver = {
+	.name = DRV_NAME,
+	.id_table = versal_pci_ids,
+	.probe = versal_pci_probe,
+	.remove = versal_pci_remove,
+};
+
+module_pci_driver(versal_pci_driver);
+
+MODULE_DESCRIPTION("AMD Versal PCIe Management Driver");
+MODULE_AUTHOR("XRT Team <runtimeca39d@amd.com>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/fpga/amd/versal-pci.h b/drivers/fpga/amd/versal-pci.h
new file mode 100644
index 000000000000..1509bd0532ea
--- /dev/null
+++ b/drivers/fpga/amd/versal-pci.h
@@ -0,0 +1,86 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Driver for Versal PCIe device
+ *
+ * Copyright (C) 2024 Advanced Micro Devices, Inc. All rights reserved.
+ */
+
+#ifndef __VERSAL_PCI_H
+#define __VERSAL_PCI_H
+
+#include <linux/firmware.h>
+#include <linux/fpga/fpga-mgr.h>
+
+#define MGMT_BAR		0
+
+#define vdev_info(vdev, fmt, args...)					\
+	dev_info(&(vdev)->pdev->dev, "%s: "fmt, __func__, ##args)
+
+#define vdev_warn(vdev, fmt, args...)					\
+	dev_warn(&(vdev)->pdev->dev, "%s: "fmt, __func__, ##args)
+
+#define vdev_err(vdev, fmt, args...)					\
+	dev_err(&(vdev)->pdev->dev, "%s: "fmt, __func__, ##args)
+
+#define vdev_dbg(vdev, fmt, args...)					\
+	dev_dbg(&(vdev)->pdev->dev, fmt, ##args)
+
+struct versal_pci_device;
+
+struct axlf_header {
+	__u64				length;
+	__u8				reserved1[24];
+	uuid_t				rom_uuid;
+	__u8				reserved2[64];
+	uuid_t				uuid;
+	__u8				reserved3[24];
+} __packed;
+
+struct axlf {
+	__u8				magic[8];
+	__u8				reserved[296];
+	struct axlf_header		header;
+} __packed;
+
+struct fw_tnx {
+	struct rm_cmd			*cmd;
+	__u32				opcode;
+	__u32				id;
+};
+
+struct fpga_device {
+	enum fpga_mgr_states		state;
+	struct fpga_manager		*mgr;
+	struct versal_pci_device	*vdev;
+	struct fw_tnx			fw;
+};
+
+struct firmware_device {
+	struct versal_pci_device	*vdev;
+	struct fw_upload		*fw;
+	__u8				*name;
+	__u32				fw_name_id;
+	struct rm_cmd			*cmd;
+	__u32				id;
+	uuid_t				uuid;
+};
+
+struct versal_pci_device {
+	struct pci_dev			*pdev;
+
+	struct fpga_device		*fdev;
+	struct firmware_device		*fwdev;
+	struct device			*device;
+
+	void __iomem			*io_regs;
+	uuid_t				xclbin_uuid;
+	uuid_t				intf_uuid;
+	__u8				fw_id[UUID_STRING_LEN + 1];
+
+	__u8				*debugfs_root;
+};
+
+/* versal pci driver APIs */
+int versal_pci_load_xclbin(struct versal_pci_device *vdev, uuid_t *xclbin_uuid);
+
+#endif	/* __VERSAL_PCI_H */
-- 
2.34.1



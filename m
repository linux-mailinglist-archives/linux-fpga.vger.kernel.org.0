Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B91843CF059
	for <lists+linux-fpga@lfdr.de>; Tue, 20 Jul 2021 01:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243400AbhGSXOL (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 19 Jul 2021 19:14:11 -0400
Received: from mail-bn8nam11on2071.outbound.protection.outlook.com ([40.107.236.71]:65377
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1388281AbhGSUsq (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 19 Jul 2021 16:48:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KdxGSj8NjNqMBRn/9cg0FdYtAIciU5iPharMOSiITBg7jP9V+jveMQ7lXWThJ9DynyztI08AuG/ayunMqkCSJ3+XwFhx5ALG/YOTBpKJ6wPSAsU7McTrKC0ftkyNPSEtjsSfC81stPTqKTRDog0nbISFtU4dKcW+ke7e4u+cPB6flaeHJkl17zWhozT9pLYrHydGnNh87u3T36b9SFzERS6SnvNFu70QXPIqkv+i3LKaDbZ7Zez1tY0c60gEs6XCHWssDPso6lkLwlSgQuB6GilXn71S8dYp9ydTGag7hZPGa1rx9lO6yPqd5AASGtXB4kEazLSv+FeUdF+6kwPYiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bAdSl5BtPpX3N6B7GVv+60kBFM5C6Yx6nNmTgjtL26k=;
 b=QRi5x/e6IeVMcEv0w+l5QmF9HRa8bu1BqwOR5MRhh2Ck2pn3RKOKZ4Gipxca/qBgt9nJ6vG27KVY/S+ypDcZKMxV6fKT3EqBi1JJONAyfnxx1abnQhUItS5CsMfMws8SWRQNk85UyQJuSu5PVNVe0iTMTI/TVBejjDxSCyIZB2X8HAsqTInz/l3yJ0s4rl8I/gb4Nw/Xosd/LELN1UFEFt7fLBZ+phlKpFPlIsM5AVvU/GQC7Oql5bOvQetKD49+fbqtdJ6AlkIMhtl/5dsvkIWuUCKOc/c+cMDfuaKwYQIdu+b4hPBQbhzPqwJVCOgiSU0IP/HDijVXGWBxWkYc7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bAdSl5BtPpX3N6B7GVv+60kBFM5C6Yx6nNmTgjtL26k=;
 b=sbRaa5rpGd+Kr0TDC8kRFLpt5SlQHHAC+NRCZG/qX7q3DAvCioXQ7SeXpvtOe6/ubwNCCfbYt7Q55xCcRgquYuokHIWbL3YOS5wdqrmeECaSFRBRa2MLeoEy/w4Yo68I+yvlHs0JC2FwBzBGnrNDHJoBTicWTOml+lpVU8Gwvvc=
Received: from DM3PR12CA0128.namprd12.prod.outlook.com (2603:10b6:0:51::24) by
 BYAPR02MB4710.namprd02.prod.outlook.com (2603:10b6:a03:52::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.21; Mon, 19 Jul 2021 21:29:21 +0000
Received: from DM3NAM02FT061.eop-nam02.prod.protection.outlook.com
 (2603:10b6:0:51:cafe::e3) by DM3PR12CA0128.outlook.office365.com
 (2603:10b6:0:51::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Mon, 19 Jul 2021 21:29:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT061.mail.protection.outlook.com (10.13.4.230) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4331.21 via Frontend Transport; Mon, 19 Jul 2021 21:29:21 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 19 Jul 2021 14:29:20 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Mon, 19 Jul 2021 14:29:20 -0700
Envelope-to: mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.73.109] (port=38300 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1m5apE-000FL6-He; Mon, 19 Jul 2021 14:29:20 -0700
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id 7D35F6020C7; Mon, 19 Jul 2021 14:26:32 -0700 (PDT)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>, Max Zhen <max.zhen@xilinx.com>
Subject: [PATCH V8 XRT Alveo 14/14] fpga: xrt: Kconfig and Makefile updates for XRT drivers
Date:   Mon, 19 Jul 2021 14:26:28 -0700
Message-ID: <20210719212628.134129-15-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210719212628.134129-1-lizhi.hou@xilinx.com>
References: <20210719212628.134129-1-lizhi.hou@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea6fcbe1-4929-42cb-a482-08d94afc45d3
X-MS-TrafficTypeDiagnostic: BYAPR02MB4710:
X-Microsoft-Antispam-PRVS: <BYAPR02MB471015BBA54A06F30BDD40C5A1E19@BYAPR02MB4710.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vMQ/8DGk8laKv/vCv5TqHCz4wZTHuTmhIQK/Wm5Yr8/vvdo9EBDKhr+7lr+Q4GTzoeQpZhbwfiPHu5z0g7W/5qQSSwS/v+coSA/n3hddcP3UH2Y/bHq+03hmw78OSz8u1RaTfXCvN+2zyWSNdw2BomUHVHwhhYFtULdobLoA8ulXHKk5eFxX/2sLj15T5mbL4TLLKalgD7Nk5EZKLbTnTgJYr7QIHIs5EKOLABbYkJ16igo88N6eLVJX8Xel8jUcIhEeglFO5tkgZOALRFvX+ZUJdoRALLZimrwe2L+05+CJIdx8mCnRWrPizXp4xejyfip/xRT0OBbdrD0v2izOjhGKhZxkSmUasiGKU3lIiUX5wJLyXWezETzj0pJ/kd3FMhNvHd2Czz7V4MwF8F9zlFLyS9Ym2ZKmFIi+TJjUdZLAqxhO7nQOIpYlzwliHrD3d3mYBNKsixrwoXBRB5AOyVJfycIz//DFqycHU9BLTiEpypf4FIVDFo50jlUDyXF9pgq4Re3UjLV8rxx1SMHtOFX4DpIFM4hlA44ZjMm7l4OzPR9ZwJeKJWo9BiRiH5DVcZw0QkyqPxva/8kxRIxLymop7AO8ikbEJdq0Az3cFkjo+EogmAGcVvdQR1UqirKL2w/x2GuWWtDyFiLrQkFUVriBw+BoEwo6w+vOw84jQYJeHSAllIzg4jWCfU45cMw3VGMk5alL0mzIcnAmc7G9Jw==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(26005)(356005)(54906003)(186003)(70206006)(82310400003)(7636003)(8676002)(2616005)(336012)(8936002)(83380400001)(426003)(2906002)(44832011)(316002)(36906005)(15650500001)(70586007)(42186006)(1076003)(47076005)(6266002)(508600001)(5660300002)(6666004)(6916009)(107886003)(36756003)(4326008)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2021 21:29:21.2428
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea6fcbe1-4929-42cb-a482-08d94afc45d3
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT061.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4710
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Update fpga Kconfig/Makefile and add Kconfig/Makefile for new drivers.

Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
Signed-off-by: Max Zhen <max.zhen@xilinx.com>
Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
Reviewed-by: Tom Rix <trix@redhat.com>
---
 drivers/Makefile                   |  1 +
 drivers/fpga/Kconfig               |  2 ++
 drivers/fpga/Makefile              |  5 +++++
 drivers/fpga/xrt/Kconfig           |  8 ++++++++
 drivers/fpga/xrt/lib/Kconfig       | 17 +++++++++++++++++
 drivers/fpga/xrt/lib/Makefile      | 24 ++++++++++++++++++++++++
 drivers/fpga/xrt/metadata/Kconfig  | 12 ++++++++++++
 drivers/fpga/xrt/metadata/Makefile | 16 ++++++++++++++++
 drivers/fpga/xrt/mgmt/Kconfig      | 15 +++++++++++++++
 drivers/fpga/xrt/mgmt/Makefile     | 19 +++++++++++++++++++
 10 files changed, 119 insertions(+)
 create mode 100644 drivers/fpga/xrt/Kconfig
 create mode 100644 drivers/fpga/xrt/lib/Kconfig
 create mode 100644 drivers/fpga/xrt/lib/Makefile
 create mode 100644 drivers/fpga/xrt/metadata/Kconfig
 create mode 100644 drivers/fpga/xrt/metadata/Makefile
 create mode 100644 drivers/fpga/xrt/mgmt/Kconfig
 create mode 100644 drivers/fpga/xrt/mgmt/Makefile

diff --git a/drivers/Makefile b/drivers/Makefile
index 27c018bdf4de..64fba9d3adb9 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -180,6 +180,7 @@ obj-$(CONFIG_STM)		+= hwtracing/stm/
 obj-$(CONFIG_ANDROID)		+= android/
 obj-$(CONFIG_NVMEM)		+= nvmem/
 obj-$(CONFIG_FPGA)		+= fpga/
+obj-$(CONFIG_FPGA_XRT_METADATA) += fpga/
 obj-$(CONFIG_FSI)		+= fsi/
 obj-$(CONFIG_TEE)		+= tee/
 obj-$(CONFIG_MULTIPLEXER)	+= mux/
diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 8cd454ee20c0..526447770cab 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -234,4 +234,6 @@ config FPGA_MGR_ZYNQMP_FPGA
 	  to configure the programmable logic(PL) through PS
 	  on ZynqMP SoC.
 
+source "drivers/fpga/xrt/Kconfig"
+
 endif # FPGA
diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
index 18dc9885883a..4b887bf95cb3 100644
--- a/drivers/fpga/Makefile
+++ b/drivers/fpga/Makefile
@@ -48,3 +48,8 @@ obj-$(CONFIG_FPGA_DFL_NIOS_INTEL_PAC_N3000)	+= dfl-n3000-nios.o
 
 # Drivers for FPGAs which implement DFL
 obj-$(CONFIG_FPGA_DFL_PCI)		+= dfl-pci.o
+
+# XRT drivers for Alveo
+obj-$(CONFIG_FPGA_XRT_METADATA)		+= xrt/metadata/
+obj-$(CONFIG_FPGA_XRT_LIB)		+= xrt/lib/
+obj-$(CONFIG_FPGA_XRT_XMGMT)		+= xrt/mgmt/
diff --git a/drivers/fpga/xrt/Kconfig b/drivers/fpga/xrt/Kconfig
new file mode 100644
index 000000000000..0e2c59589ddd
--- /dev/null
+++ b/drivers/fpga/xrt/Kconfig
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Xilinx Alveo FPGA device configuration
+#
+
+source "drivers/fpga/xrt/metadata/Kconfig"
+source "drivers/fpga/xrt/lib/Kconfig"
+source "drivers/fpga/xrt/mgmt/Kconfig"
diff --git a/drivers/fpga/xrt/lib/Kconfig b/drivers/fpga/xrt/lib/Kconfig
new file mode 100644
index 000000000000..935369fad570
--- /dev/null
+++ b/drivers/fpga/xrt/lib/Kconfig
@@ -0,0 +1,17 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# XRT Alveo FPGA device configuration
+#
+
+config FPGA_XRT_LIB
+	tristate "XRT Alveo Driver Library"
+	depends on HWMON && PCI && HAS_IOMEM
+	select FPGA_XRT_METADATA
+	select REGMAP_MMIO
+	help
+	  Select this option to enable Xilinx XRT Alveo driver library. This
+	  library is core infrastructure of XRT Alveo FPGA drivers which
+	  provides functions for working with device nodes, iteration and
+	  lookup of platform devices, common interfaces for platform devices,
+	  plumbing of function call and ioctls between platform devices and
+	  parent partitions.
diff --git a/drivers/fpga/xrt/lib/Makefile b/drivers/fpga/xrt/lib/Makefile
new file mode 100644
index 000000000000..55cd6063a324
--- /dev/null
+++ b/drivers/fpga/xrt/lib/Makefile
@@ -0,0 +1,24 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (C) 2020-2021 Xilinx, Inc. All rights reserved.
+#
+# Authors: Sonal.Santan@xilinx.com
+#
+
+FULL_XRT_PATH=$(srctree)/$(src)/..
+FULL_DTC_PATH=$(srctree)/scripts/dtc/libfdt
+
+obj-$(CONFIG_FPGA_XRT_LIB) += xrt-lib.o
+
+xrt-lib-objs :=			\
+	lib-drv.o		\
+	xroot.o			\
+	xclbin.o		\
+	subdev.o		\
+	cdev.o			\
+	group.o			\
+	xleaf/axigate.o		\
+	xleaf/icap.o
+
+ccflags-y := -I$(FULL_XRT_PATH)/include	 \
+	-I$(FULL_DTC_PATH)
diff --git a/drivers/fpga/xrt/metadata/Kconfig b/drivers/fpga/xrt/metadata/Kconfig
new file mode 100644
index 000000000000..129adda47e94
--- /dev/null
+++ b/drivers/fpga/xrt/metadata/Kconfig
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# XRT Alveo FPGA device configuration
+#
+
+config FPGA_XRT_METADATA
+	bool "XRT Alveo Driver Metadata Parser"
+	select LIBFDT
+	help
+	  This option provides helper functions to parse Xilinx Alveo FPGA
+	  firmware metadata. The metadata is in device tree format and the
+	  XRT driver uses it to discover the HW subsystems behind PCIe BAR.
diff --git a/drivers/fpga/xrt/metadata/Makefile b/drivers/fpga/xrt/metadata/Makefile
new file mode 100644
index 000000000000..14f65ef1595c
--- /dev/null
+++ b/drivers/fpga/xrt/metadata/Makefile
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (C) 2020-2021 Xilinx, Inc. All rights reserved.
+#
+# Authors: Sonal.Santan@xilinx.com
+#
+
+FULL_XRT_PATH=$(srctree)/$(src)/..
+FULL_DTC_PATH=$(srctree)/scripts/dtc/libfdt
+
+obj-$(CONFIG_FPGA_XRT_METADATA) += xrt-md.o
+
+xrt-md-objs := metadata.o
+
+ccflags-y := -I$(FULL_XRT_PATH)/include	\
+	-I$(FULL_DTC_PATH)
diff --git a/drivers/fpga/xrt/mgmt/Kconfig b/drivers/fpga/xrt/mgmt/Kconfig
new file mode 100644
index 000000000000..31e9e19fffb8
--- /dev/null
+++ b/drivers/fpga/xrt/mgmt/Kconfig
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Xilinx XRT FPGA device configuration
+#
+
+config FPGA_XRT_XMGMT
+	tristate "Xilinx Alveo Management Driver"
+	depends on FPGA_XRT_LIB
+	select FPGA_XRT_METADATA
+	select FPGA_BRIDGE
+	select FPGA_REGION
+	help
+	  Select this option to enable XRT PCIe driver for Xilinx Alveo FPGA.
+	  This driver provides interfaces for userspace application to access
+	  Alveo FPGA device.
diff --git a/drivers/fpga/xrt/mgmt/Makefile b/drivers/fpga/xrt/mgmt/Makefile
new file mode 100644
index 000000000000..16644571b673
--- /dev/null
+++ b/drivers/fpga/xrt/mgmt/Makefile
@@ -0,0 +1,19 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (C) 2020-2021 Xilinx, Inc. All rights reserved.
+#
+# Authors: Sonal.Santan@xilinx.com
+#
+
+FULL_XRT_PATH=$(srctree)/$(src)/..
+FULL_DTC_PATH=$(srctree)/scripts/dtc/libfdt
+
+obj-$(CONFIG_FPGA_XRT_XMGMT)	+= xrt-mgmt.o
+
+xrt-mgmt-objs := root.o		\
+	   xmgmt-main.o		\
+	   xrt-mgr.o		\
+	   xmgmt-main-region.o
+
+ccflags-y := -I$(FULL_XRT_PATH)/include		\
+	-I$(FULL_DTC_PATH)
-- 
2.27.0


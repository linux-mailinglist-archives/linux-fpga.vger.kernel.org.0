Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B04F136CDA3
	for <lists+linux-fpga@lfdr.de>; Tue, 27 Apr 2021 23:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239271AbhD0VCt (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 27 Apr 2021 17:02:49 -0400
Received: from mail-bn8nam11on2062.outbound.protection.outlook.com ([40.107.236.62]:63521
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238960AbhD0VCr (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 27 Apr 2021 17:02:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EilcCIZxHKxTuhh7bVUIuhx2971V42BQ25Hp/6gJX4GpE3zzUyGtEUn3XAzAs8wMGKv9oAnFhzEuhLtTtukXP3QLBMHb4lNK1DKmTKzSB9tU50Xg6rNldnIbHbpajBaKNwK0XX+2rf5Q3wkOCCL+MKcFx1lVr47NtXO8bM18BmY1fgT2Sk3J75MPnlhJu3Y3RnPt/0R4BKuuNW85xluZId+mi5EvDYGfAkRbMP0ow8lmVgmCTqHOMmr3PB7Kja3qDWJVVcp2xYWtH0Ot5ZijWvLRX7pyS70m/AxF0absRCercbOdLKs2d+s/clln1QrxDpEhxFEk9mJ8Dn5ihQR4mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3cxmXv3vBfbCiBsJslLcbz43lkHx4BJVAvczVSoN6Gc=;
 b=BzRayKQO6gzvcfdohVNFeOMitk7ef3YyG37Q3Ka/8+oA8Q4Aqh2BuWHU6my5Uo6leXdCTbw1ZsxlQtUsyhrqVQRZ4DRpUvsoEBuFDvYzPabhyaGS0Z0YtQb62hPR6WwIbuAbOkhLUUD3IfbwHAELE8Red8j4Tp5SN5hEU2lvUG+TwDQJKvxOyuAzs/Xobqxnc6T2Mz3V5wyo+wygyNjPdQWs5kgeHQrB8QisUUrsUdAnXOOw6alkLeBktnoy/4AbCXi2E7RfdFJn89yZl2R2ZPeN3u3da3ZoB0SZUMzWvhYMARL1oIJ1yv78aI1cE0S4lTCfCfvy460JX2zGklhSbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3cxmXv3vBfbCiBsJslLcbz43lkHx4BJVAvczVSoN6Gc=;
 b=f0Ga3ANh+V0boDZGpLPCUINQGkDAMlAxGMbSofIDSlvCiMZmJMVvAJxbvEn2zAa+11g/TJsmEp/FkLtvgyvG70NEKExIfI/h2W6dZp5U3W3GyRh8FIQrQKyo7ysAmTW/O1Y4bjFyInuAT4kQ4rna8F5JchNOCPqb1LODH7h83kc=
Received: from CY4PR18CA0064.namprd18.prod.outlook.com (2603:10b6:903:13f::26)
 by BL0PR02MB4450.namprd02.prod.outlook.com (2603:10b6:208:44::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25; Tue, 27 Apr
 2021 21:01:59 +0000
Received: from CY1NAM02FT063.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:13f:cafe::26) by CY4PR18CA0064.outlook.office365.com
 (2603:10b6:903:13f::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20 via Frontend
 Transport; Tue, 27 Apr 2021 21:01:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 CY1NAM02FT063.mail.protection.outlook.com (10.152.75.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4065.21 via Frontend Transport; Tue, 27 Apr 2021 21:01:59 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 27 Apr 2021 14:01:51 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Tue, 27 Apr 2021 14:01:51 -0700
Envelope-to: mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.72.212] (port=52036 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1lbUq7-0000Kz-9q; Tue, 27 Apr 2021 14:01:51 -0700
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id A8460600138; Tue, 27 Apr 2021 13:54:36 -0700 (PDT)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>, Max Zhen <max.zhen@xilinx.com>
Subject: [PATCH V5 XRT Alveo 20/20] fpga: xrt: Kconfig and Makefile updates for XRT drivers
Date:   Tue, 27 Apr 2021 13:54:31 -0700
Message-ID: <20210427205431.23896-21-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210427205431.23896-1-lizhi.hou@xilinx.com>
References: <20210427205431.23896-1-lizhi.hou@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ffc9f2ba-05bd-4ed3-6be5-08d909bfb30a
X-MS-TrafficTypeDiagnostic: BL0PR02MB4450:
X-Microsoft-Antispam-PRVS: <BL0PR02MB4450D381CF5D7B83DF44A767A1419@BL0PR02MB4450.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6yMldYsYY5gaBnW3XJ/PW5w8apcISvoP6JJfcKZpOgoLYb5jop6dBfJGxLcv9fmzx36onqI/j8bFtTWBxwZNoiNTHkZjKF0dChE0OcPXcEP+G6vmBxrMetANwP0jV3Gv6c2CEGJT8TlecWE+zn0A/3KQgP1j+qnJ0En0ZSjYfWVJ5FgGoMJBIvmvvdmA6lSgtF9goHUkdJy194uLyvYlU1mSc5WyUiLdiglRelLEVFqk8jYyvXKXN5ohX/Ty1P/wOcP/4+/X0qul3U3+RwmALfNjDYBldzCfFF87lZdT+qOFSQCff7vcPRPMhYLRmR8rvXF2R8iaEhE9iCVTFnJWU3WmL5gqXQZcyjkJiajX61N3m8FcBnSVPNC4upo5Sj/QH+d8HSXW3nJUg5t8eZ9WDGyryeF+BSUOSiM2fwGvICYieRNCmdMp4fG3+iguVmUcva5AMa27PjtQhfqMaE3TRCi3qz/G1jj8MQvN/7VA6WbQN+97BnPzPtHs04UetKcnEF9925xfLMRAjg9SXytL/F5oNDGN38bBag/tP8DcNNFRYoTVeVxUBxdFyiq/Uc6aiiD1OTU8zDzonCaUu4XoRuOeT5Eg5aR08elcDv6TRfLinoj83NnJ8DSCMTY/fBoT/LchhnntZu6DHeA88LbyQ06R66YC3+HYW7zRltcMfTMs8kjYMwdOu569VsfXYnxwMr0ZS6D3BXy2dtyjtiyMyfjf948iTB0dmlh4nYZnpz4=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(39860400002)(136003)(46966006)(36840700001)(426003)(36756003)(1076003)(82740400003)(966005)(8936002)(186003)(107886003)(83380400001)(36860700001)(6666004)(82310400003)(2906002)(54906003)(316002)(4326008)(42186006)(36906005)(5660300002)(6916009)(47076005)(2616005)(356005)(26005)(336012)(7636003)(478600001)(70586007)(70206006)(15650500001)(44832011)(8676002)(6266002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2021 21:01:59.6214
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffc9f2ba-05bd-4ed3-6be5-08d909bfb30a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT063.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4450
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Update fpga Kconfig/Makefile and add Kconfig/Makefile for new drivers.

Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
Signed-off-by: Max Zhen <max.zhen@xilinx.com>
Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
---
 MAINTAINERS                        | 11 +++++++++++
 drivers/Makefile                   |  1 +
 drivers/fpga/Kconfig               |  2 ++
 drivers/fpga/Makefile              |  5 +++++
 drivers/fpga/xrt/Kconfig           |  8 ++++++++
 drivers/fpga/xrt/lib/Kconfig       | 17 +++++++++++++++++
 drivers/fpga/xrt/lib/Makefile      | 30 ++++++++++++++++++++++++++++++
 drivers/fpga/xrt/metadata/Kconfig  | 12 ++++++++++++
 drivers/fpga/xrt/metadata/Makefile | 16 ++++++++++++++++
 drivers/fpga/xrt/mgnt/Kconfig      | 15 +++++++++++++++
 drivers/fpga/xrt/mgnt/Makefile     | 19 +++++++++++++++++++
 11 files changed, 136 insertions(+)
 create mode 100644 drivers/fpga/xrt/Kconfig
 create mode 100644 drivers/fpga/xrt/lib/Kconfig
 create mode 100644 drivers/fpga/xrt/lib/Makefile
 create mode 100644 drivers/fpga/xrt/metadata/Kconfig
 create mode 100644 drivers/fpga/xrt/metadata/Makefile
 create mode 100644 drivers/fpga/xrt/mgnt/Kconfig
 create mode 100644 drivers/fpga/xrt/mgnt/Makefile

diff --git a/MAINTAINERS b/MAINTAINERS
index 9450e052f1b1..89abe140041b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7016,6 +7016,17 @@ F:	Documentation/fpga/
 F:	drivers/fpga/
 F:	include/linux/fpga/
 
+FPGA XRT DRIVERS
+M:	Lizhi Hou <lizhi.hou@xilinx.com>
+R:	Max Zhen <max.zhen@xilinx.com>
+R:	Sonal Santan <sonal.santan@xilinx.com>
+L:	linux-fpga@vger.kernel.org
+S:	Supported
+W:	https://github.com/Xilinx/XRT
+F:	Documentation/fpga/xrt.rst
+F:	drivers/fpga/xrt/
+F:	include/uapi/linux/xrt/
+
 FPU EMULATOR
 M:	Bill Metzenthen <billm@melbpc.org.au>
 S:	Maintained
diff --git a/drivers/Makefile b/drivers/Makefile
index 6fba7daba591..dbb3b727fc7a 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -179,6 +179,7 @@ obj-$(CONFIG_STM)		+= hwtracing/stm/
 obj-$(CONFIG_ANDROID)		+= android/
 obj-$(CONFIG_NVMEM)		+= nvmem/
 obj-$(CONFIG_FPGA)		+= fpga/
+obj-$(CONFIG_FPGA_XRT_METADATA) += fpga/
 obj-$(CONFIG_FSI)		+= fsi/
 obj-$(CONFIG_TEE)		+= tee/
 obj-$(CONFIG_MULTIPLEXER)	+= mux/
diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 5ff9438b7b46..01410ff000b9 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -227,4 +227,6 @@ config FPGA_MGR_ZYNQMP_FPGA
 	  to configure the programmable logic(PL) through PS
 	  on ZynqMP SoC.
 
+source "drivers/fpga/xrt/Kconfig"
+
 endif # FPGA
diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
index 18dc9885883a..a1cad7f7af09 100644
--- a/drivers/fpga/Makefile
+++ b/drivers/fpga/Makefile
@@ -48,3 +48,8 @@ obj-$(CONFIG_FPGA_DFL_NIOS_INTEL_PAC_N3000)	+= dfl-n3000-nios.o
 
 # Drivers for FPGAs which implement DFL
 obj-$(CONFIG_FPGA_DFL_PCI)		+= dfl-pci.o
+
+# XRT drivers for Alveo
+obj-$(CONFIG_FPGA_XRT_METADATA)		+= xrt/metadata/
+obj-$(CONFIG_FPGA_XRT_LIB)		+= xrt/lib/
+obj-$(CONFIG_FPGA_XRT_XMGNT)		+= xrt/mgnt/
diff --git a/drivers/fpga/xrt/Kconfig b/drivers/fpga/xrt/Kconfig
new file mode 100644
index 000000000000..2424f89e6e03
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
+source "drivers/fpga/xrt/mgnt/Kconfig"
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
index 000000000000..58563416efbf
--- /dev/null
+++ b/drivers/fpga/xrt/lib/Makefile
@@ -0,0 +1,30 @@
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
+	xleaf/vsec.o		\
+	xleaf/axigate.o		\
+	xleaf/devctl.o		\
+	xleaf/icap.o		\
+	xleaf/clock.o		\
+	xleaf/clkfreq.o		\
+	xleaf/ucs.o		\
+	xleaf/ddr_calibration.o
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
diff --git a/drivers/fpga/xrt/mgnt/Kconfig b/drivers/fpga/xrt/mgnt/Kconfig
new file mode 100644
index 000000000000..b43242c14757
--- /dev/null
+++ b/drivers/fpga/xrt/mgnt/Kconfig
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Xilinx XRT FPGA device configuration
+#
+
+config FPGA_XRT_XMGNT
+	tristate "Xilinx Alveo Management Driver"
+	depends on FPGA_XRT_LIB
+	select FPGA_XRT_METADATA
+	select FPGA_BRIDGE
+	select FPGA_REGION
+	help
+	  Select this option to enable XRT PCIe driver for Xilinx Alveo FPGA.
+	  This driver provides interfaces for userspace application to access
+	  Alveo FPGA device.
diff --git a/drivers/fpga/xrt/mgnt/Makefile b/drivers/fpga/xrt/mgnt/Makefile
new file mode 100644
index 000000000000..b71d2ff0aa94
--- /dev/null
+++ b/drivers/fpga/xrt/mgnt/Makefile
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
+obj-$(CONFIG_FPGA_XRT_XMGNT)	+= xrt-mgnt.o
+
+xrt-mgnt-objs := root.o		\
+	   xmgnt-main.o		\
+	   xrt-mgr.o		\
+	   xmgnt-main-region.o
+
+ccflags-y := -I$(FULL_XRT_PATH)/include		\
+	-I$(FULL_DTC_PATH)
-- 
2.27.0


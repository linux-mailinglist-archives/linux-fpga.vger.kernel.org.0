Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC73C393ABF
	for <lists+linux-fpga@lfdr.de>; Fri, 28 May 2021 02:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235559AbhE1A4A (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 27 May 2021 20:56:00 -0400
Received: from mail-bn8nam12on2076.outbound.protection.outlook.com ([40.107.237.76]:50913
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233878AbhE1Az7 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 27 May 2021 20:55:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IS9QMph3QOFtLh56T+uNK2HAKUWcWefmZ5svaBE8+vhAKI/4A55ZzKQ438R8Ni1YrrMg4D98vJZgwGZrkb49G5Ub4op1YuU2CPX2YEgFMMI9qwbVBF6/+QZtAtUv+LyPVTbSggGh7TOUOYM2Tt+fW+83p1c7BL8RVcWlua2sRl+3xHH7hY6hnshhrVpRhYohhC190Jzj6TFpCtK4WoXiNPhn4rTSuh/LHAKytzPnnuS2Sz3A7gN3SZmkakFrGGpdnkQJylS2p0+AAs/6R1J8TWIymu8n7GWn30/+91inipqEwaSuk8xrjn4IQw5wnXPNvQVPwOhZg4Mpl1YpepXx/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OE/NR7+2MC0FI9oGGESMUwObnLdpbmsONUEn8sAUUMc=;
 b=hJ9pvYVz1HDUTYYpSHsB1K7VJ+r+vi2iRupLny37OO9Df+k5qFcwtpplKEEMjSxNzgNQQIxro+IMA9HZT0cArt626KgwH6/HbGVmRzqwYiWjJHYB0xJmzL1JJBAq7kkugHDdUD8irLpQH29rFiZwHiooRK8PGBtDi6cHD5MbonRTKHARbhlQNubPqzIJL3T4/lnR9FcHKwlF6ExG8XIbWaPsBwbfTJMPK7JArL0AtOusejK99XXn4FC8jXaMX1ZH4f64xa/6v/tIMNMgx7vf+WwEu7OZPxOMsvNTeDndqAdh1F6urZOzWDQeDkfqrcDIMyKvspfJgOXLqO/d/IjjCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OE/NR7+2MC0FI9oGGESMUwObnLdpbmsONUEn8sAUUMc=;
 b=QQAtGVMWWOnOuMx/eagNp3LvlJYVYgHCGSAlQqFYbaB7z9MdmkEr55gbo1hJFXxAK0+cQH63NGHJS4sz1VwDqNkWF1DsxiIpmFqnFwQqEBsgZTLB0NaUXC68/1ny9wZ2uhaLFCqtYLkyBa4XIWLOnEfvH4rANEQb00oAaZmo1x8=
Received: from SN6PR04CA0084.namprd04.prod.outlook.com (2603:10b6:805:f2::25)
 by DM6PR02MB7065.namprd02.prod.outlook.com (2603:10b6:5:25a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Fri, 28 May
 2021 00:54:23 +0000
Received: from SN1NAM02FT0051.eop-nam02.prod.protection.outlook.com
 (2603:10b6:805:f2:cafe::dd) by SN6PR04CA0084.outlook.office365.com
 (2603:10b6:805:f2::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21 via Frontend
 Transport; Fri, 28 May 2021 00:54:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0051.mail.protection.outlook.com (10.97.5.34) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4150.30 via Frontend Transport; Fri, 28 May 2021 00:54:23 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 27 May 2021 17:54:08 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Thu, 27 May 2021 17:54:08 -0700
Envelope-to: mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.73.109] (port=34046 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1lmQlM-0003iG-Cl; Thu, 27 May 2021 17:54:08 -0700
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id 8945A6032B5; Thu, 27 May 2021 17:50:07 -0700 (PDT)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>, Max Zhen <max.zhen@xilinx.com>
Subject: [PATCH V7 XRT Alveo 20/20] fpga: xrt: Kconfig and Makefile updates for XRT drivers
Date:   Thu, 27 May 2021 17:49:59 -0700
Message-ID: <20210528004959.61354-21-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210528004959.61354-1-lizhi.hou@xilinx.com>
References: <20210528004959.61354-1-lizhi.hou@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 85b11c6c-0ba8-4f74-6c80-08d9217322cc
X-MS-TrafficTypeDiagnostic: DM6PR02MB7065:
X-Microsoft-Antispam-PRVS: <DM6PR02MB706525A9414612EB66D67686A1229@DM6PR02MB7065.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K7isT1vNETSoddnpKa0pKe2UNFTZyCXqNR0GCx4d9gq1n2iDFTx+IMznK4E2NRI3mp+bm6WVFviXgXCjakqN9fQ9uqKonD4GkAVEsA/GWZHCDFUiEfCpIiTh4erNoXSlSdW1HYAyPqixnZKJV+cZgC+8Qml5Vm11ckJ+A/Z8N9oumswhEXJPFOXtiG0xdK1QT4dEtIyQBKdrKbDqUj9+V5ozEwolUzFgHzwmJx4xt+5oOOH7rxaYSufHPNvn7O7OXoU550Eux+kgjTMGLFzOV9234JrbqBuUFIjV9Z07pNBmWgIpDBdiaHIZ84QYONilOPCKUHLpTMXB0q8jqVc/saOad4td6YCi9dazfDq/1ladjJisdDlwLf+mJoOcgFq28pwz0TskhbuFgPjb8Zm91JxcCLOFEZBUEoIImhomlFhA1WCnaMbY/kUdgxsY5owFeq0AyJTZ3okmveE4Ymf5PsZr4yOU2Y9XQOik75jfd6KiQ04SZFOBPt9y3eI+OHcmHekCFR5Kw7+maygM0QFLSO+opFSJQ6IG1I4UhKKUHXb3sqiXaEeYYbl8SRJXoJcAaViRBASH0IRbGSdtyV7unfiO1/puadWbGItI0f8dV70rZ+THDCSkLOm3RsBPCrpr6qcB3ZZt2o3acXpMHoTtoD5PafkJpshMXNVEtVPwa80=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(136003)(39850400004)(46966006)(36840700001)(36756003)(5660300002)(82310400003)(478600001)(54906003)(6266002)(316002)(36906005)(8936002)(2906002)(26005)(186003)(6916009)(15650500001)(42186006)(8676002)(107886003)(336012)(2616005)(426003)(6666004)(1076003)(4326008)(44832011)(47076005)(70586007)(70206006)(82740400003)(7636003)(36860700001)(356005)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 00:54:23.7614
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85b11c6c-0ba8-4f74-6c80-08d9217322cc
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0051.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB7065
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
 drivers/fpga/xrt/lib/Makefile      | 30 ++++++++++++++++++++++++++++++
 drivers/fpga/xrt/metadata/Kconfig  | 12 ++++++++++++
 drivers/fpga/xrt/metadata/Makefile | 16 ++++++++++++++++
 drivers/fpga/xrt/mgmt/Kconfig      | 15 +++++++++++++++
 drivers/fpga/xrt/mgmt/Makefile     | 19 +++++++++++++++++++
 10 files changed, 125 insertions(+)
 create mode 100644 drivers/fpga/xrt/Kconfig
 create mode 100644 drivers/fpga/xrt/lib/Kconfig
 create mode 100644 drivers/fpga/xrt/lib/Makefile
 create mode 100644 drivers/fpga/xrt/metadata/Kconfig
 create mode 100644 drivers/fpga/xrt/metadata/Makefile
 create mode 100644 drivers/fpga/xrt/mgmt/Kconfig
 create mode 100644 drivers/fpga/xrt/mgmt/Makefile

diff --git a/drivers/Makefile b/drivers/Makefile
index 5a6d613e868d..e5d64c971463 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -181,6 +181,7 @@ obj-$(CONFIG_STM)		+= hwtracing/stm/
 obj-$(CONFIG_ANDROID)		+= android/
 obj-$(CONFIG_NVMEM)		+= nvmem/
 obj-$(CONFIG_FPGA)		+= fpga/
+obj-$(CONFIG_FPGA_XRT_METADATA) += fpga/
 obj-$(CONFIG_FSI)		+= fsi/
 obj-$(CONFIG_TEE)		+= tee/
 obj-$(CONFIG_MULTIPLEXER)	+= mux/
diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 33e15058d0dc..9b5fa43f3b8f 100644
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


Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C02637B400
	for <lists+linux-fpga@lfdr.de>; Wed, 12 May 2021 04:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbhELCCn (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 11 May 2021 22:02:43 -0400
Received: from mail-bn8nam12on2053.outbound.protection.outlook.com ([40.107.237.53]:29089
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230388AbhELCCm (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 11 May 2021 22:02:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G85yhFdCcZma8hjVmOzdFS0gCRXm8CI06wVB7ie+1OlRnsiU9DJdkMwiRW3MwYp2CzdKvfDzvWmIPhs9qPh2CwBtoAoPoV1ftSnNpbv7rGClmvUGaZ3wPxPw+1pK68gCUWerheQCG56pajk25wbd26HwffXhh7FL9uV5QcvoMnl9G4sIvel36OV2U4rYbctxkBe5XVwAq6fmGD6yubRZLVob5OFR3aq7jGAHt9PNnbCueCh5qG6HehtEZpIjULp2lq2YUZpP7PhgaxKikQQF8rxV+iEE1ir7dErHlitSgLSuYdoq3CIfH2gmyNoIXranF37Gw1t486abxLZY2bw/Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3qjrJi6L4/XfLDnC/XtevV+BhtoC8R1svYX0ijjj9nI=;
 b=TLF2tBAJ+1QWsTM5rr8HDOqTOTgXcK91zHl2zu+Zr+65KHeLk3WCwxQeVG9170SaWQpxcvOd//wa1avIw6Fg6MRHn12a/f2AYqyJPzZKJWQGMrD9wAh01qruvD8oaw2u+65tR1w19f/6VELuUzfQeajvokIUUN1rnCRDaxEADkvetGGtv1cvLbzn9cXGe5E9/N5f7s+ebmc1Da8nsCZO8sy/I0B0emChckvgVlDxxQRezvyQspbqAQDNUIOsYM7LAZjbp9BSB9gfDD2MC2ylqRKinTMBUB7ItpmlQCBUD2QS844bpvb5LWm8NUaqEHHInXw9D3n1xfvIMpPQLWZADw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3qjrJi6L4/XfLDnC/XtevV+BhtoC8R1svYX0ijjj9nI=;
 b=IFsME2D+czVBP/LII4QPCFXMREtNGAljzbCurmD+dvQbEJ7AwPTou/di2PWj15qkDb4BLHmSietDlsRh6t9IhqGEyabWCCA9RiTW4EGhXQ0VMk7y0LVDfuDVnrq2ZBu/AKzFrNfbv1+C+HhHSUAriOll2YPmeDH5ZCYu0APTBNA=
Received: from BN9P220CA0021.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::26)
 by MN2PR02MB6766.namprd02.prod.outlook.com (2603:10b6:208:1dc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Wed, 12 May
 2021 02:01:34 +0000
Received: from BN1NAM02FT052.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:13e:cafe::a) by BN9P220CA0021.outlook.office365.com
 (2603:10b6:408:13e::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Wed, 12 May 2021 02:01:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT052.mail.protection.outlook.com (10.13.2.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4065.21 via Frontend Transport; Wed, 12 May 2021 02:01:33 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 11 May 2021 19:01:21 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Tue, 11 May 2021 19:01:21 -0700
Envelope-to: mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.72.212] (port=35752 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1lgeBc-0002O6-UZ; Tue, 11 May 2021 19:01:20 -0700
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id 2BCF9600138; Tue, 11 May 2021 18:53:46 -0700 (PDT)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>, Max Zhen <max.zhen@xilinx.com>
Subject: [PATCH V6 XRT Alveo 20/20] fpga: xrt: Kconfig and Makefile updates for XRT drivers
Date:   Tue, 11 May 2021 18:53:39 -0700
Message-ID: <20210512015339.5649-21-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210512015339.5649-1-lizhi.hou@xilinx.com>
References: <20210512015339.5649-1-lizhi.hou@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e877211d-c46f-44a6-e721-08d914e9de5c
X-MS-TrafficTypeDiagnostic: MN2PR02MB6766:
X-Microsoft-Antispam-PRVS: <MN2PR02MB6766F1577512177CF3D112E8A1529@MN2PR02MB6766.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: riKqxK6APc/JJgY4P+1M3UOnfpJg5FytNpCJkopmssJ47ZFuxHEsFbcB5Ez4B3LG38O0XlzXtfgxuOERX/eyoqG8JkOD4V2/W5bCw+ZYa/etDh2ftSrKvAKkMyv6h00ahKVkznp1VAcIoCA1YB+L/w0hwUdjSub78/g2kwgaO0bh9BWJ6RyNryuQISu+IP2ocNfN7egp7V00C919+ypOoXc3NzDHa5jFoIButbuPgmwrxzKjxjWAryLqT1dhQdRqML6MKZoIIfjhw61qcxnitMP5wkfQOBWqrg5igUr8YNa6RwY84ZbnEpHq2DDnGzHqc1sDeFOvlHpyj0t8PeXkYIH7ssoiFeGKUBAbjUPzz59hrwQbuq8bgTREdwKx04kGqHV5mk+QdH/8BQwkoL9OkkoJsNpl9lYsARSeCDIlRUUdxYXxGx/WXwZr1m+NhqBUl0Vuc1xu0GLfzyHSSRRcSsxjLcEZEYXjy8axAauYNs/dHm918czg+XWu2ixmy1RW6agg8EMX9yNBi8/c00qp2csoYvrIxISgoZZuUx529HMEq15IdcP3q7O+FeOQGIg6CKurJOmRQVLoYCiZ7GxSxRYJ61/dPDO2aojRfd2k3v78GXpVdXe/xjzbZxya8P3lVwN0p7t7K07cPkCrSUWDpn1DfEvaBJpftpZQeHJYu7Y=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(39850400004)(376002)(136003)(396003)(346002)(46966006)(36840700001)(107886003)(6266002)(336012)(44832011)(426003)(5660300002)(2616005)(4326008)(15650500001)(6666004)(478600001)(1076003)(7636003)(82740400003)(8676002)(36756003)(6916009)(70206006)(70586007)(82310400003)(316002)(42186006)(36906005)(47076005)(8936002)(36860700001)(54906003)(2906002)(186003)(26005)(356005)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 02:01:33.8722
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e877211d-c46f-44a6-e721-08d914e9de5c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT052.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6766
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


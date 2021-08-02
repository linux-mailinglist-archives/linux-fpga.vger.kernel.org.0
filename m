Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DECB03DDD36
	for <lists+linux-fpga@lfdr.de>; Mon,  2 Aug 2021 18:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232215AbhHBQIb (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 2 Aug 2021 12:08:31 -0400
Received: from mail-co1nam11on2083.outbound.protection.outlook.com ([40.107.220.83]:63553
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229780AbhHBQIb (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 2 Aug 2021 12:08:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PJjeE7Z0UqcOV3y0GC+pKnCvvt0PoEp9aOtGIKPtgozMyf6T18LgYoJXZUNDyeywuxSxS/zZM2kQu/D5/SC++cX5BDWS/FLi3GUwctNpNR27bWH2ctTWaW5DM8mEzOYwSBupA1OepwAb3RiBGZOkn/OOnpT/QQ28jJY1ysRu0icJw8KkKF2/hWkcS9LBL4yvz9YFfjooIbeITIUTLD/OiFTUGcqdt2oViAXFhr+HOIAaNkjWTL+MJypZJe0VGTmyhQmKPXf5tPS5lYXZxi5B/qDwwGbw1vphCXnK8DV+K/YNruqu2vPfppqxyZ0deRhWQ2n2UkboP8eYhDtFiGUV2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bAdSl5BtPpX3N6B7GVv+60kBFM5C6Yx6nNmTgjtL26k=;
 b=bQjVjt6M/qAX21SeKjBDQ5bDJ2ste76X+lH5EsthC9knPrUX8acOu2TxJ0GHkay4orRcS97vQ3O972B/6GkYuPDNDopdul3zDGKe5+voShBbj4CU4BvFY02X/aNZ6bmQ621vjyHI9AEOPxllqxhocS/ARnGiBaGV3n0anwkXU4ejW4zWfu9ovZWCXWiIXqbj0WrnQFIB/HDQ2O28/PjxXlAefihdaBlfVILJGNkRMaL7OvSHfs3wLhZLR8opMyhcud7DOvACaNZiSxdUUKB3DcbzDaWECjjVZDAiaGesmv2AOkImt0xzTet/ZZXeLmedgVewXkKlY3pWpnp1Ay+iIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bAdSl5BtPpX3N6B7GVv+60kBFM5C6Yx6nNmTgjtL26k=;
 b=qHHrGhwiZkqxQU0lSQr/3HrKqXPyjU4x4wAZeg3AcZO7gal7SGJZnAoT88UgRIyC4KNdRVk6n33f83uVTeVK1CXlGW3NnUMnWHGKAL9zFv7RALXgQ3ndm7QBQr2ZdRVCrJYlJLmJaqAC8J2dxT2WNnd0z63eE7Cs+VkV5R7ZCtw=
Received: from DM5PR06CA0059.namprd06.prod.outlook.com (2603:10b6:3:37::21) by
 BN6PR02MB2385.namprd02.prod.outlook.com (2603:10b6:404:36::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4373.21; Mon, 2 Aug 2021 16:08:17 +0000
Received: from DM3NAM02FT058.eop-nam02.prod.protection.outlook.com
 (2603:10b6:3:37:cafe::fa) by DM5PR06CA0059.outlook.office365.com
 (2603:10b6:3:37::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.17 via Frontend
 Transport; Mon, 2 Aug 2021 16:08:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT058.mail.protection.outlook.com (10.13.5.42) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4373.18 via Frontend Transport; Mon, 2 Aug 2021 16:08:17 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 2 Aug 2021 09:08:06 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Mon, 2 Aug 2021 09:08:06 -0700
Envelope-to: mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [10.23.145.232] (port=49074 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1mAaU2-0005L8-K3; Mon, 02 Aug 2021 09:08:06 -0700
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id 191D3601B37; Mon,  2 Aug 2021 09:05:31 -0700 (PDT)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>, Max Zhen <max.zhen@xilinx.com>
Subject: [PATCH V9 XRT Alveo 14/14] fpga: xrt: Kconfig and Makefile updates for XRT drivers
Date:   Mon, 2 Aug 2021 09:05:21 -0700
Message-ID: <20210802160521.331031-15-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210802160521.331031-1-lizhi.hou@xilinx.com>
References: <20210802160521.331031-1-lizhi.hou@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e3aea5fe-840d-4103-357a-08d955cfbd80
X-MS-TrafficTypeDiagnostic: BN6PR02MB2385:
X-Microsoft-Antispam-PRVS: <BN6PR02MB2385C7264D1154E4FF183A52A1EF9@BN6PR02MB2385.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5DeoG+gPGNQ473TVzxpdmC20dIznfZs/J3m6+20jwrJaFZUUdcfyecjBB+bhDV/UV5c+VddgE3tSyUNj5cq2JEmD5Nc785VfvLBHtkzVp21eaI1s1q21w9x6v1wlao3Pjes/5IRqDetiw3tzCaAE0tgRNkcQ4/STwJ9r78v8P3nm+CYvD3tvcnbaPdJyIHqYaa76XDwVnWU5AyHcGW2JNJC3T0Dtd1vCqd+dEGiSFLEezfhYZneVYcgtvA4X1lqfnl/xk+2SdwFfvuIaf+qnXwbcHmCgxBsllR/YCJyhnELeyYpSNBgv0Nqs8FXNLAK+RwputGWWCCEryzLqAdgepWzhS3/zzTfRTI1xXZa2Xj6NP9b16cS4xQymRDeV7w5LsQ/HO+eFJB8+2el4tkn7woBelOuNMtIftsLL5ERX3gdfCr/tOvcpmPUqc8rNDXwGdzRF13Y6AClN3/VDEjs20QmBOgpzT3pXea7rQcsDVP8JbehF7dTk/smNnEjdj/Bt+ycPwqdHtot1vwP8P03vzy08+L6smEdwcNb/K6U/8wndONWHuDnUunVGqI1aOUgtDoJPSfnVhskjbMwnn9m4d+dtcUewzV/T3Sg0UCsEZHi6QMcEbB/E0Jq28ej16c5OgsRDN3duGpqXD8QXxR5Mkmq+cvnfK5hFcJ+SJ8KxGEk46BDf6FPdlfTCQmcaqA673Rhk0YtCkZH9Ppa64s6iNQ==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(39860400002)(136003)(46966006)(36840700001)(70206006)(426003)(26005)(44832011)(5660300002)(356005)(2906002)(4326008)(36756003)(7636003)(82740400003)(70586007)(6266002)(107886003)(2616005)(6666004)(6916009)(36906005)(316002)(186003)(8936002)(82310400003)(336012)(15650500001)(36860700001)(42186006)(1076003)(478600001)(83380400001)(8676002)(47076005)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2021 16:08:17.4423
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3aea5fe-840d-4103-357a-08d955cfbd80
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT058.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2385
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


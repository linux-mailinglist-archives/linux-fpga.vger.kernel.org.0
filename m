Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F23E7347126
	for <lists+linux-fpga@lfdr.de>; Wed, 24 Mar 2021 06:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235340AbhCXFhG (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 24 Mar 2021 01:37:06 -0400
Received: from mail-mw2nam12on2077.outbound.protection.outlook.com ([40.107.244.77]:58373
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235333AbhCXFgq (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 24 Mar 2021 01:36:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eQ9OEast/OLLwY26+oK0ahtnoL8reQx+FQwQNFpDuX27hiRu9CFEBw7RJg6W+ZmRgMdomWSY/6A0RGUPJKa3F9+DMpUPHcVIVGdJetAw1GGzwWn2bF9yY0pUDaUVtohZ+zjHzV7krOR0TSVFmgwLq/bpixSDAvW1eL1nf63R31XxdDWC2pQZex34APVPrUfsP17g0+omHrua76YyyYE3oAHhhIyErzdOxkCzcvXQOlgQq79ZKo232f2AOXNC6+mHpP0OopMOmprp+bu/WhQeLLy/9rna/roqezyMb5gYjmwg1aGbyZbodPwMS0WRTjnkj04GeshXVNj1X3wla8glbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FgnY9B0r73HcZ2CrK9u/ksYWo0wPjWRHZMjnJ/YvmCc=;
 b=feDGU9DGKynv5uC5mR1rdc3K6mmxiWzEKvVrh8CjAyugUA6JpKUCuRzBABqoBd+RZezzodgI/EZpjSxst5naYCSdQR395vPTzyusAS903inL13H+tslQT+b3ERfKYCe2ZSCQs3k7JnhumQpPRpJgj/xkagHZdfpmD+TrO+ySrHeUG50ukFUaWyl3Y34tag17FgcbkLL6fhUjeOGN6R3E8TMOV6s+ZBDeqWpwNLGBhz8W8Z3SkO/bmMetDy1KzAZMQWoDlLddq8duGSUIao2R2u9xLk408eeZLwOgNcIXrYBImhIW5wvGcpF+ByeB/In2XWC/kHnpAd/iR4u4jo/ghA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FgnY9B0r73HcZ2CrK9u/ksYWo0wPjWRHZMjnJ/YvmCc=;
 b=aYVOUzQ4lhZL91StFAtD8Axdt5eOaKATaqA0Se9DxIfuoDoj+jhdLp0as475ZH2+DlBaAf/nuY/aEe+D784CWmd6024vMBOZIBYuC81QNN9R+YOM9lZ/0FA7ezga2wAEkD8Sw48sPtETr2tYHus5GsELHTUrZCKEja91DB3BmxY=
Received: from SN7PR04CA0212.namprd04.prod.outlook.com (2603:10b6:806:127::7)
 by DM6PR02MB5801.namprd02.prod.outlook.com (2603:10b6:5:17c::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.23; Wed, 24 Mar
 2021 05:36:43 +0000
Received: from SN1NAM02FT046.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:127:cafe::1a) by SN7PR04CA0212.outlook.office365.com
 (2603:10b6:806:127::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24 via Frontend
 Transport; Wed, 24 Mar 2021 05:36:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT046.mail.protection.outlook.com (10.152.72.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3977.25 via Frontend Transport; Wed, 24 Mar 2021 05:36:43 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 23 Mar 2021 22:36:23 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2106.2 via Frontend Transport; Tue, 23 Mar 2021 22:36:23 -0700
Envelope-to: mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.72.212] (port=51060 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1lOwBr-0006HP-1B; Tue, 23 Mar 2021 22:36:23 -0700
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id 4D9C0600133; Tue, 23 Mar 2021 22:29:57 -0700 (PDT)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>, Max Zhen <max.zhen@xilinx.com>
Subject: [PATCH V4 XRT Alveo 20/20] fpga: xrt: Kconfig and Makefile updates for XRT drivers
Date:   Tue, 23 Mar 2021 22:29:47 -0700
Message-ID: <20210324052947.27889-21-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210324052947.27889-1-lizhi.hou@xilinx.com>
References: <20210324052947.27889-1-lizhi.hou@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a3a26724-e1a7-4ea6-f583-08d8ee86ce8b
X-MS-TrafficTypeDiagnostic: DM6PR02MB5801:
X-Microsoft-Antispam-PRVS: <DM6PR02MB58012737FC8DF69D088DE778A1639@DM6PR02MB5801.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V4uvT96kKhiUQQR6QYV/PcqhnfX2xRSTSLRGkOp/0DZ2CP13FrmEc6IGghc9FzpU+x3B+xpO+2dik3ECAjhz9cdS/CrHnFy8RzB7Xi94Aq264El914N3P8RNdSuj/6YlZpygLXcPhkncDtCx00cH/NUaDBAirbG6OqyZajKyfW7+D68VtMGuhwZXAo4Rmoxk64cU+tasBaPXfJ1oQTqU0s7Wj++C+jZ0q9AMbqyEn8EzaO50rgqQr/By3YUm86/Qy24hvJDHMC+Bhj4HXC8+PWlItTVb6cPnJpfkWYDEjretYp/rnH5xouxPUupvV50SnU0GRYKRdJj1LE7c13g3G47Hpvjscr4vgyMs8W1L6cR7XMNA2UweeqISw1hiknVh1M5O+bj6duCtHvV2enET4YfFD2NkfyZ8AJFJ+/nwXOTQpi6yVQdnpgXvHmaMd03pIxvHOYtu77YJxQdiOXZDiFzXKH4l0DWaiWEy6KCPIWR0aFw8rfh5FMcqjEgHMmvSDgBntiEgKmulNqsYKRNacYupMOPMijhEV798sdNot9AYB2+BS5wHaZq42n7f5AG4ostPUcosKKqIYrQyztOtvAGlTZ/y/kf5Ya7sFgTNizqzXz2Mcfr5EWBmjpf45aJpBxhWYFc4blX6ilUvtkEBIda5U7GvLfuy3pYWaCZjKzTG3LNUvKoaVOD8ub18xI818iQwcc0viFYJJ1rr3ZrPzKQNPB776tU7WtAMH5YMaRU=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(136003)(39860400002)(396003)(346002)(376002)(46966006)(36840700001)(426003)(6916009)(36860700001)(7636003)(6266002)(356005)(5660300002)(47076005)(2906002)(8676002)(2616005)(966005)(15650500001)(82310400003)(1076003)(186003)(6666004)(82740400003)(26005)(70586007)(36756003)(42186006)(478600001)(8936002)(36906005)(336012)(70206006)(54906003)(83380400001)(4326008)(316002)(44832011)(107886003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2021 05:36:43.0432
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3a26724-e1a7-4ea6-f583-08d8ee86ce8b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT046.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5801
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
 drivers/fpga/xrt/mgmt/Kconfig      | 15 +++++++++++++++
 drivers/fpga/xrt/mgmt/Makefile     | 19 +++++++++++++++++++
 11 files changed, 136 insertions(+)
 create mode 100644 drivers/fpga/xrt/Kconfig
 create mode 100644 drivers/fpga/xrt/lib/Kconfig
 create mode 100644 drivers/fpga/xrt/lib/Makefile
 create mode 100644 drivers/fpga/xrt/metadata/Kconfig
 create mode 100644 drivers/fpga/xrt/metadata/Makefile
 create mode 100644 drivers/fpga/xrt/mgmt/Kconfig
 create mode 100644 drivers/fpga/xrt/mgmt/Makefile

diff --git a/MAINTAINERS b/MAINTAINERS
index aa84121c5611..44ccc52987ac 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7009,6 +7009,17 @@ F:	Documentation/fpga/
 F:	drivers/fpga/
 F:	include/linux/fpga/
 
+FPGA XRT DRIVERS
+M:	Lizhi Hou <lizhi.hou@xilinx.com>
+R:	Max Zhen <max.zhen@xilinx.com>
+R:	Sonal Santan <sonal.santan@xilinx.com>
+L:	linux-fpga@vger.kernel.org
+S:	Maintained
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
index 000000000000..acabd811f3fd
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
+	   main.o		\
+	   fmgr-drv.o		\
+	   main-region.o
+
+ccflags-y := -I$(FULL_XRT_PATH)/include		\
+	-I$(FULL_DTC_PATH)
-- 
2.27.0


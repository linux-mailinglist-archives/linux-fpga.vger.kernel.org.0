Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 660CA46816B
	for <lists+linux-fpga@lfdr.de>; Sat,  4 Dec 2021 01:41:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383857AbhLDAoT (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 3 Dec 2021 19:44:19 -0500
Received: from mail-dm6nam12on2040.outbound.protection.outlook.com ([40.107.243.40]:48048
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1383816AbhLDAoS (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 3 Dec 2021 19:44:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CFdm3UDwwDg4ZErPdOiFK/4Wk31QyvtONKALhi6+/t5rvxa/AWm6jctUoHSxdUTXG3R/EaUGMSMF9k5z/NhPsUwFbc0ZaxuAYWdYGz/bEQ5ChCnDaay56jPyHMUlgi/OkB6nfSo36Y3mKLAipaZOgdYidPOTqdQNQ5wCxhhTMoSm3x71kQV729Q+igw4F7NpEeSZiUOWVc1aGudGQbIZcodyG/R9cT7fL5geTd3RZChyyPfQ8AK61mFgfq7ztyZOilkjEeqBu60okzEYzTQcJdDRx0OTA1ejwb3pfg+T/RhDX5eE11e813HWMl+f0MRTpsjC2M7c+ZBUTnV9mtFD2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iXTdzpOJ8obTBvITPBprkb8xjbWWvcxIkFxLtmJx810=;
 b=U2gygNm/EzqZ0Hd+nMKSdLE1NPg0yuWFCuCCSP+UXhSydoe7UbiKKNUrOYYgFB9A5fJJI/jm5cSNq0nXue2YtkTR9wQ8DLfPQgM2qlhER6FTvGUx6yCQQEg5bfsARGFQV5M/NRE8XkC0uiQS3vP64dEWimebPsIjIfdP65NJge+6POvd0xqfMiPQfztQ7U1vZElB4itedy/qNr0k64/UNDEKJB0ag7FMjWjGNXxlVpFaxuoty35W6wNglWDMYBm7JbR2R8AQ5nKTjwxdHQKNvHQsz1Ir4PNSQIQHWMdG5kHXvHlR8wU2fPeTAl12UeUyYGp6UkQOZhKrzemplpbJww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=infradead.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iXTdzpOJ8obTBvITPBprkb8xjbWWvcxIkFxLtmJx810=;
 b=GhGLYI4gECC7plDxrOmw9JpmraltFYpCQt4uCopeFaeLZTzyWPlUUhecy/rlncgNXgQePQCVE0FxJO7l9fx6jf4QFdaZXkzhYeLK75cN4RCx8kaynSDUHhGn6X0yYuGGZtT8cY2U4nkOtSGvmxXCng3PVIrXhpw/6x2Kd2pnDn4=
Received: from BN6PR17CA0008.namprd17.prod.outlook.com (2603:10b6:404:65::18)
 by CH2PR02MB6507.namprd02.prod.outlook.com (2603:10b6:610:67::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Sat, 4 Dec
 2021 00:40:51 +0000
Received: from BN1NAM02FT044.eop-nam02.prod.protection.outlook.com
 (2603:10b6:404:65:cafe::28) by BN6PR17CA0008.outlook.office365.com
 (2603:10b6:404:65::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.24 via Frontend
 Transport; Sat, 4 Dec 2021 00:40:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT044.mail.protection.outlook.com (10.13.2.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Sat, 4 Dec 2021 00:40:49 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 3 Dec 2021 16:40:39 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 3 Dec 2021 16:40:39 -0800
Envelope-to: dwmw2@infradead.org,
 mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.72.93] (port=55514 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1mtJ6U-000Dbb-VO; Fri, 03 Dec 2021 16:40:38 -0800
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id 4C0E460084D; Fri,  3 Dec 2021 16:40:02 -0800 (PST)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>, <dwmw2@infradead.org>,
        Max Zhen <max.zhen@xilinx.com>
Subject: [PATCH V3 XRT Alveo Infrastructure 4/8] fpga: xrt: xrt-lib initialization
Date:   Fri, 3 Dec 2021 16:39:53 -0800
Message-ID: <20211204003957.1448567-5-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211204003957.1448567-1-lizhi.hou@xilinx.com>
References: <20211204003957.1448567-1-lizhi.hou@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 29ee1cfc-0730-4927-ae02-08d9b6beb841
X-MS-TrafficTypeDiagnostic: CH2PR02MB6507:
X-Microsoft-Antispam-PRVS: <CH2PR02MB6507DD22F918E5A4D3552BE4A16B9@CH2PR02MB6507.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8FEky2bHVBL3GnwHiUkjQVpYmdSXhVGsRem/zbHuo8C2fcuE+efgcLoWW1WB8Kt98QNbmGf8bkqI4nP7KAyfYTZ1wp0wnHgQqGJdBSxSkf1NG8bog1uTyDLTddsTF+LTA2TUmxkTznGATUvPDLD5EJwH8Bu1ODPb+KwZ0qcTxiizc2anAHTG2CngarJA9Zvoi/BCwE6FQDcN2GhDxX2Y6j4dO7ZIjjIMJ3xREg1kdcmCgpItY6V7MHAoj2hwmq1Fho7+SVVvskJFJcNf2Ht24uMSfj6csqIy8sP7T1N8aFtwFj8+pezcgmi9CDwksOaW1Ga3bo5Q5q76l4hoK7djh4G4apUArnigG+iMRY+/KHkc0/jk2x+0Xbo/7JqZFZA0faOYL9Slnw1MGxrvbCzBsin1EEr1qkd4bszO8Cz6S2Vaf53N0f5FY1d5+pJtblZWl8YUQNk2qJRG/pH2joGm0wQHeB7Mhty6oNSlFT3DLAMtDhtJET1lCXyL4xu//J8aF9+zJTNfPvNWTUJVaeGToya/SsodOhRE0vO0ZrToSFgDJ5mQoBsQK21WOZTJqZLFdRLiKTTsq2GR69U5QlNpqpjMg441xCe1mEFGzlxC8RhG/DDAPDeJJgSp1yi5z6qG/As6Ox8JKui2w252z5poDgUrBTiIe7JHNXmuLgk+8/JMExUkFT5aZ4ZQQBnIxQI3lVXmHYCQ5U9CPu3fYUR16g==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(46966006)(36840700001)(508600001)(6916009)(8676002)(4326008)(1076003)(8936002)(336012)(70206006)(5660300002)(44832011)(2906002)(6266002)(426003)(26005)(47076005)(186003)(356005)(36756003)(316002)(6666004)(70586007)(82310400004)(2616005)(54906003)(42186006)(107886003)(7636003)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2021 00:40:49.9583
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29ee1cfc-0730-4927-ae02-08d9b6beb841
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT044.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6507
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

xrt-lib module initialization routine creates /xrt-bus device tree node

Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
Signed-off-by: Max Zhen <max.zhen@xilinx.com>
Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
---
 drivers/fpga/Kconfig             |  3 +++
 drivers/fpga/Makefile            |  3 +++
 drivers/fpga/xrt/Kconfig         |  6 +++++
 drivers/fpga/xrt/lib/Kconfig     | 16 +++++++++++++
 drivers/fpga/xrt/lib/Makefile    | 16 +++++++++++++
 drivers/fpga/xrt/lib/lib-drv.c   | 41 ++++++++++++++++++++++++++++++++
 drivers/fpga/xrt/lib/lib-drv.h   | 15 ++++++++++++
 drivers/fpga/xrt/lib/xrt-bus.dts | 13 ++++++++++
 8 files changed, 113 insertions(+)
 create mode 100644 drivers/fpga/xrt/Kconfig
 create mode 100644 drivers/fpga/xrt/lib/Kconfig
 create mode 100644 drivers/fpga/xrt/lib/Makefile
 create mode 100644 drivers/fpga/xrt/lib/lib-drv.c
 create mode 100644 drivers/fpga/xrt/lib/lib-drv.h
 create mode 100644 drivers/fpga/xrt/lib/xrt-bus.dts

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 991b3f361ec9..93ae387c97c5 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -243,4 +243,7 @@ config FPGA_MGR_VERSAL_FPGA
 	  configure the programmable logic(PL).
 
 	  To compile this as a module, choose M here.
+
+source "drivers/fpga/xrt/Kconfig"
+
 endif # FPGA
diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
index 0bff783d1b61..5bd41cf4c7ec 100644
--- a/drivers/fpga/Makefile
+++ b/drivers/fpga/Makefile
@@ -49,3 +49,6 @@ obj-$(CONFIG_FPGA_DFL_NIOS_INTEL_PAC_N3000)	+= dfl-n3000-nios.o
 
 # Drivers for FPGAs which implement DFL
 obj-$(CONFIG_FPGA_DFL_PCI)		+= dfl-pci.o
+
+# XRT drivers for Alveo
+obj-$(CONFIG_FPGA_XRT_LIB)		+= xrt/lib/
diff --git a/drivers/fpga/xrt/Kconfig b/drivers/fpga/xrt/Kconfig
new file mode 100644
index 000000000000..04c3bb5aaf4f
--- /dev/null
+++ b/drivers/fpga/xrt/Kconfig
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Xilinx Alveo FPGA device configuration
+#
+
+source "drivers/fpga/xrt/lib/Kconfig"
diff --git a/drivers/fpga/xrt/lib/Kconfig b/drivers/fpga/xrt/lib/Kconfig
new file mode 100644
index 000000000000..bb44956d9f94
--- /dev/null
+++ b/drivers/fpga/xrt/lib/Kconfig
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# XRT Alveo FPGA device configuration
+#
+
+config FPGA_XRT_LIB
+	tristate "XRT Alveo Driver Library"
+	depends on HWMON && PCI && HAS_IOMEM && OF_FLATTREE && OF_OVERLAY
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
index 000000000000..f67bb19ef20a
--- /dev/null
+++ b/drivers/fpga/xrt/lib/Makefile
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (C) 2020-2021 Xilinx, Inc. All rights reserved.
+#
+# Authors: Sonal.Santan@xilinx.com
+#
+
+FULL_XRT_PATH=$(srctree)/$(src)/..
+
+obj-$(CONFIG_FPGA_XRT_LIB) += xrt-lib.o
+
+xrt-lib-objs :=			\
+	lib-drv.o		\
+	xrt-bus.dtb.o
+
+ccflags-y := -I$(FULL_XRT_PATH)/include
diff --git a/drivers/fpga/xrt/lib/lib-drv.c b/drivers/fpga/xrt/lib/lib-drv.c
new file mode 100644
index 000000000000..d4597cd4767f
--- /dev/null
+++ b/drivers/fpga/xrt/lib/lib-drv.c
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020-2021 Xilinx, Inc.
+ *
+ * Authors:
+ *	Cheng Zhen <maxz@xilinx.com>
+ *	Lizhi Hou <lizhi.hou@xilinx.com>
+ */
+
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/vmalloc.h>
+#include <linux/of_device.h>
+#include "lib-drv.h"
+
+static int xrt_bus_ovcs_id;
+
+static __init int xrt_lib_init(void)
+{
+	int ret;
+
+	ret = of_overlay_fdt_apply(__dtb_xrt_bus_begin,
+				   __dtb_xrt_bus_end - __dtb_xrt_bus_begin,
+				   &xrt_bus_ovcs_id);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static __exit void xrt_lib_fini(void)
+{
+	of_overlay_remove(&xrt_bus_ovcs_id);
+}
+
+module_init(xrt_lib_init);
+module_exit(xrt_lib_fini);
+
+MODULE_AUTHOR("XRT Team <runtime@xilinx.com>");
+MODULE_DESCRIPTION("Xilinx Alveo IP Lib driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/fpga/xrt/lib/lib-drv.h b/drivers/fpga/xrt/lib/lib-drv.h
new file mode 100644
index 000000000000..4bf8a32c7ec5
--- /dev/null
+++ b/drivers/fpga/xrt/lib/lib-drv.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2021 Xilinx, Inc.
+ *
+ * Authors:
+ *	Cheng Zhen <maxz@xilinx.com>
+ */
+
+#ifndef _LIB_DRV_H_
+#define _LIB_DRV_H_
+
+extern u8 __dtb_xrt_bus_begin[];
+extern u8 __dtb_xrt_bus_end[];
+
+#endif	/* _LIB_DRV_H_ */
diff --git a/drivers/fpga/xrt/lib/xrt-bus.dts b/drivers/fpga/xrt/lib/xrt-bus.dts
new file mode 100644
index 000000000000..0720de26851b
--- /dev/null
+++ b/drivers/fpga/xrt/lib/xrt-bus.dts
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+/plugin/;
+
+/*
+ * xrt bus node which is overlayed dynamically when xrt-lib is loaded.
+ */
+&{/} {
+	xrt-bus {
+		#address-cells=<2>;
+		#size-cells=<2>;
+	};
+};
-- 
2.27.0


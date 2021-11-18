Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0E64564C9
	for <lists+linux-fpga@lfdr.de>; Thu, 18 Nov 2021 22:04:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233859AbhKRVHs (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 18 Nov 2021 16:07:48 -0500
Received: from mail-sn1anam02on2063.outbound.protection.outlook.com ([40.107.96.63]:6213
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232359AbhKRVHs (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 18 Nov 2021 16:07:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fG5IJjeekj/m+SunIe6a95X0y31jQb0XhJKawubiZzZgsp7N6+QeBLxUTggZgnoNOI/m84LPAncMIN0PGNL9L/YTNui9YQJVRNFpVz64waqgQFAeUrrEq0bK1PV9q8SkH5tIXuXcUWNSwV823lhFahsSu7RnrSCCnlA83L7/RJ4eJcG+vF92I+zV06RtDdIAp0BonQKPbs5/YS2Staq3wOtQaB3KxDYzA6bkp/lHzP0p8GFTV1kk/S5Wy6W3A1bactZR56umPD+rbpRvmBKfeR+SanrAKDzwu8LgvxvCIyUwdqiONnX+yB66ajPka63x6FPZxEkFY4srvWIirfrmFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iXTdzpOJ8obTBvITPBprkb8xjbWWvcxIkFxLtmJx810=;
 b=IoAi6X3JdbcG+J9TVmqWROSprEyiav6NuWbqwDvI/pyJtd3kcj9EAzAobFv0YX0Kb9bSjMDG4w5bXljiMtXdVW6+U//8ptb54aofRb2MEyoSppQKKJumXNxW14BzQtQ8wUjSZT0yBhbtBgAC4VHGVusW7HDNERjJzD67AzyIDVtlDcm3NHqcGbalgPXfVp3+MVxujTu6nY4Ie+cJOY1OQMnjdP+LkeaM1WzwamAJbZP7yxy3OCzyGqzsf+h/XMjxvOpNdsxzY56tJPDqdI+pOGMuCDmJCf5vOYJtOet+eY7i73O/Afa+yJ/VLg+huFEomKKoKOyaHqgDtUOVKrdzaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=infradead.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iXTdzpOJ8obTBvITPBprkb8xjbWWvcxIkFxLtmJx810=;
 b=VZTnbdTt1ttzf8pLrDzcYTdlxJdE7FJRwa0CCLc4Rke4W6P7GwmSB4GZMWf3Rgtb24xdgLCLVEDqT3rvmgIKysW22asc1frgOfVx1We7QWn2tKAOjqaXMh1wYibz6ZLK9cPn5oTWwzKYNzs59ZAqUpg0OImQyHWdEd4g9J8Ci0g=
Received: from BN0PR04CA0043.namprd04.prod.outlook.com (2603:10b6:408:e8::18)
 by DM5PR02MB3372.namprd02.prod.outlook.com (2603:10b6:4:63::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Thu, 18 Nov
 2021 21:04:45 +0000
Received: from BN1NAM02FT053.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:e8:cafe::bf) by BN0PR04CA0043.outlook.office365.com
 (2603:10b6:408:e8::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22 via Frontend
 Transport; Thu, 18 Nov 2021 21:04:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT053.mail.protection.outlook.com (10.13.2.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.19 via Frontend Transport; Thu, 18 Nov 2021 21:04:45 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 18 Nov 2021 13:04:24 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 18 Nov 2021 13:04:24 -0800
Envelope-to: dwmw2@infradead.org,
 mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.72.93] (port=37756 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1mnoa0-0001Z6-H0; Thu, 18 Nov 2021 13:04:24 -0800
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id E0D8A600144; Thu, 18 Nov 2021 13:03:36 -0800 (PST)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>, <dwmw2@infradead.org>,
        Max Zhen <max.zhen@xilinx.com>
Subject: [PATCH V1 XRT Alveo Infrastructure 5/9] fpga: xrt: xrt-lib initialization
Date:   Thu, 18 Nov 2021 13:03:19 -0800
Message-ID: <20211118210323.1070283-6-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211118210323.1070283-1-lizhi.hou@xilinx.com>
References: <20211118210323.1070283-1-lizhi.hou@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 053d4301-b160-42bc-f6bd-08d9aad70c6b
X-MS-TrafficTypeDiagnostic: DM5PR02MB3372:
X-Microsoft-Antispam-PRVS: <DM5PR02MB3372BD84788F74A91159B1F3A19B9@DM5PR02MB3372.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qRTZ58YOmeT2e87a23OUoiP8Gb2WB+8VwLNCs1pO+xDk2A2ytqYJmqgwRk6xGMej6bX33f9PHA4QRJwOBlVpC+2koh+w5/hwo/yJbFTqICFpvqiVbVG68RktU5b8j8X1wU1LutdVbHs1wug7OHnnG63SBILgWRwNtVbVaI1pcBBrd6hjrlfHqWG9Pw2FHrTiz9iygUopR9rxVPuVIVnrwvJlJD+WiVs+WuWJeR7syAtFroFJ/t8TyV0ayzV9UiibYklU6lKTVcbd8s73AUwY9CPA6VT69yVEvjnY2ieK4fE/3yd3NjGfuZQn1a4JeTLsSmnxSNNZ7zb71FW3QofKqIkKCcVaMcDTCaEjR4EdZErHnTULBUu1/IYbosyHF7suTkL88llwxUKzD3w0P3Pe7gnarjDSPo2yAu2OcEBFkIyM977+Ap2CKiyRcgn63XfgtP9RIo+w/CKd34xENM/RxTRQ9HYZ5/gvyec2N0B0foLxt7Z4MQB9T9VMB8IPpXy4YGuA6u87fySRD7ZUEqwNIdWVzinY/QzuBAgL8uzq4xmfuxVh5cjFaVsE0xEuhGwQigoKEs+J64GXXlx2dVhX2Sg92kT1qW/kGxuJq6Fyh2SB5Lj53Zfx7B9+LpfQUN+CV3Pny/50V2PtOPRzRmL1VICBbc+vJNEYqtvUPS6nWyWrZgtM55LxFLVuSDUFhbfKn48tpbpCB6w7j/dosHhRSg==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(46966006)(36840700001)(7636003)(26005)(6266002)(82310400003)(44832011)(70586007)(5660300002)(6916009)(6666004)(2616005)(8676002)(186003)(356005)(70206006)(4326008)(316002)(54906003)(508600001)(47076005)(107886003)(426003)(8936002)(42186006)(36756003)(336012)(36860700001)(1076003)(36906005)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2021 21:04:45.1289
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 053d4301-b160-42bc-f6bd-08d9aad70c6b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT053.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB3372
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


Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB8C64578B1
	for <lists+linux-fpga@lfdr.de>; Fri, 19 Nov 2021 23:25:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235839AbhKSW2l (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 19 Nov 2021 17:28:41 -0500
Received: from mail-bn8nam12on2060.outbound.protection.outlook.com ([40.107.237.60]:24928
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235895AbhKSW2i (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 19 Nov 2021 17:28:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TiHYYdq9r/uqrzwrDMccoBGAowJj83IewxTwN/KizraIUjmfrGOTyaHZf8Mw9tPWmo1trCfd2UTiPMSCliybLeeLp0sLxhyZmYnCI1Wv5AkK2iY0iGOkaYjVlYhmMfDM7nHTd8X0jlvBjddgVhbyH6UqYjZXBvkgnLQOAig4U++xiva8XSwXBiEhGCNeOfTqL8fbpIP4KSZSJRA3J35vGVT4SsgrvBoT7LNKjS/zx5lHo3CzZhQBE1M7v5YsRp50cv4Y34tNHd/r0G/Ht9rPMoeBb9dohqf83CVPBYomP3abPa+CgYg+HkFPe4S3xRiZSygljPE735mxgfliftALrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iXTdzpOJ8obTBvITPBprkb8xjbWWvcxIkFxLtmJx810=;
 b=R4Rv/aT6KOHh7WCVpmrGldGfnI8oFSgYmUOuGyWJpFUyDkLlCIJMa/05lccAVOw4wde+vfk61YLtSJeEfClunl/tSZDpaPDZnb44w0x/cNqdPPX+YkdPrgkeCfzkWT+D3b7Ud+jffu1Oh3G1RcAascAS9e12vkkgyO6bD0IJZtDkHvdrer91ReZA9YUPTXv3rcObfthR8tDXCQzX9MZsxWHKcl6UiFmyaaGSujENgz/FOqcE70QBMN1jf2aUOOUVEbzAYKlRY4nTtmWn38QoL9ffUxKfSfcC5X9qubGMuGCYyt9ENVoSzkvnk2RHbjK2et/3lX0HRNOiHW72UYTHQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=infradead.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iXTdzpOJ8obTBvITPBprkb8xjbWWvcxIkFxLtmJx810=;
 b=pt9z8+juD0IA0XAJ3bAdK1aeqVk5KUkG4wAasxTeJDRLOnMv3Nuqd3ugZbScWC37UYzZHFz+zRNAUj6J4WZRh89gADgEVgE45KkGTnTkXT3XR9Dwk9+HW9yXPTTglxP3AKCvLELFbz6VS8VpkYGdqaqs7prNM2EX8FD7VF5Cd1c=
Received: from DM5PR10CA0024.namprd10.prod.outlook.com (2603:10b6:4:2::34) by
 MN2PR02MB6831.namprd02.prod.outlook.com (2603:10b6:208:1d1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Fri, 19 Nov
 2021 22:25:29 +0000
Received: from DM3NAM02FT016.eop-nam02.prod.protection.outlook.com
 (2603:10b6:4:2:cafe::8b) by DM5PR10CA0024.outlook.office365.com
 (2603:10b6:4:2::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend
 Transport; Fri, 19 Nov 2021 22:25:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT016.mail.protection.outlook.com (10.13.4.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.19 via Frontend Transport; Fri, 19 Nov 2021 22:25:27 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 19 Nov 2021 14:25:27 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 19 Nov 2021 14:25:27 -0800
Envelope-to: dwmw2@infradead.org,
 mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.72.93] (port=38942 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1moCJy-0001Q2-VF; Fri, 19 Nov 2021 14:25:26 -0800
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id 40ED660014F; Fri, 19 Nov 2021 14:24:15 -0800 (PST)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>, <dwmw2@infradead.org>,
        Max Zhen <max.zhen@xilinx.com>
Subject: [PATCH V2 XRT Alveo Infrastructure 5/9] fpga: xrt: xrt-lib initialization
Date:   Fri, 19 Nov 2021 14:24:08 -0800
Message-ID: <20211119222412.1092763-6-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211119222412.1092763-1-lizhi.hou@xilinx.com>
References: <20211119222412.1092763-1-lizhi.hou@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3f9dd9a-cde4-467c-677e-08d9abab7d2b
X-MS-TrafficTypeDiagnostic: MN2PR02MB6831:
X-Microsoft-Antispam-PRVS: <MN2PR02MB6831F072D613530DF6837757A19C9@MN2PR02MB6831.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9AO6vd/E78+E3VQxCcIOgY6F/5nPQfN38Lh9CLwSDe9CnMRjT7acb8G+KcbkGr/2hBnPgUHdW9AeN5H6fOMxQdDUBoTJbAofz4/cLEZJ+h90Z0dzfBjaqKd9WwTSentkzrK1PUv0IMEMaRz4oDIiESxyCt8kmC36t0hOkSinuddKECW0to7A43YKayLU0JCbh8LrvSsAbnsAUxbT10jubcG8M6+Pj/MtbsXiInWcoxNrSJ+6fkqWEoASRhlEzFdmXOOHgW4gBUpR2uxiLlJZLJosrRKmiv/HzgxU6YY+/OjHKDgzjCFnAuouauh5oXvpd8ZjKc8XK0cwFq6VAWCuVPtP87h8MRiYr09yHSoRaET6soRzFnEj+JljyP1Jpckqw1PzM+zfxxdpdcVQ4FimPW0CMub7gJlrErzVM8cahA/JmSv6Rg0hYnrV6pD/4iecZ9Mhz4X5i5t5MnQIwcJkpWlXJZNKf2bqW1nBOr3E0I0VYQNxvqWeHcCYoTD4BY/ODSRQKRQNCXfhLfnvQY2TNpAGA6w6af+C0AMTR08YMOCbi7B5jBa9n6dlqaNKhnaxEKSEd91191p2PVm/HBApcEdlxDSnbd4gv3x0UYSq3eMbr6HvDa/BQqcCKk1GmvcuRhNLCPWaQuFDxGafYMWDihlPbuwRzvdqsPn6tP04Ne9evAkWD4MVXyb9E3i55JcIhAaT7AhHENEa0pzTdypujQ==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(36840700001)(46966006)(70586007)(508600001)(70206006)(2616005)(7636003)(47076005)(336012)(426003)(356005)(2906002)(44832011)(316002)(5660300002)(1076003)(8676002)(42186006)(186003)(82310400003)(4326008)(36860700001)(36906005)(6916009)(6666004)(36756003)(54906003)(107886003)(6266002)(8936002)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 22:25:27.6470
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3f9dd9a-cde4-467c-677e-08d9abab7d2b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT016.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6831
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


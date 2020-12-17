Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C51C2DCD3D
	for <lists+linux-fpga@lfdr.de>; Thu, 17 Dec 2020 08:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgLQHzj (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 17 Dec 2020 02:55:39 -0500
Received: from mail-bn8nam11on2045.outbound.protection.outlook.com ([40.107.236.45]:6017
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726580AbgLQHzi (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 17 Dec 2020 02:55:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e3ssRKObBQsv2iDXazfQ1ir6d6EDuGO7wQdbz1ob4Trw5qDHFW7CaaQEMl+HRITdRA6vJ/K1RN+aYJzX+KZ7Hs2nnCMP43feM9uPTSRJUP4El4pIfgNhtKqJQt0OK4ZLin4RPHQBU26HUfxoNo/nFTWeBVapoOS/S+H3PLt4zt1tYy9AwF0OmQ785u/zFKf6wMsVXnh4phHDI2uUB1vbr3md8w11IeW2NRZ1/5cdT0F3Pzoc3nRCGqR3PttbHHv1NkK9C4j4qLJRfom94mmcIdnOfEkaAm8BZ4hkXlAgXBijznAnNf8w3NLcF6AlipWhAgw3xWhCP4TflJgAdrm1sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ctd9m2sFtQcrWzLAOGYbz4fkHVoBl+alJtIJWKk2RqQ=;
 b=E8Q4bJW1ZaGIUQ36gnK6mpvWwCgL6pOFN7kfHXL3K9klgy4Dd+0xpfRXkc8pfn+0cwA/SHmEoM7qtgWA7TBSRRgJ2NGPgq0GgwjQrgrV5Sefmeyz0mXoiDCvgyAM4Dfk/8RLD2dVavDqDh1e3DvE89CI0XBFEyUTCkB3Zj4/ua2o45L9kT9GjHP1vskZ+n+pZcCxBrPoeH2EABBi2QMxm5xRTF2bE2fzsPieBbBGJxlWMGDErXfgnSPCV9tTWUlcZGGfHRn8qR51Vc7OKxjPxH1rpmHG4YB2e5SUou4jXBMQBf0jf9gIwqdwAW0YmfJQW1h+AhOKWKPcKFZMsuiOwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ctd9m2sFtQcrWzLAOGYbz4fkHVoBl+alJtIJWKk2RqQ=;
 b=d22Zevi3bY+g3e9TJ7xNDe2xkhJHF/hjEWa7nnRHth3YOoKRZE9XmLmi8V2TFUn9e5i//kP6eO+0rHtCekxx1vhbJ3S5eENP8wrLagKo/lW19cWCSBI4NCMMX2RtA7AoqVLoqCrHx1MwZS58p9RtsJcjEnXAnUgBo7Y4MsDB+jQ=
Received: from MN2PR06CA0003.namprd06.prod.outlook.com (2603:10b6:208:23d::8)
 by DM6PR02MB5723.namprd02.prod.outlook.com (2603:10b6:5:178::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.19; Thu, 17 Dec
 2020 07:54:45 +0000
Received: from BL2NAM02FT034.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:23d:cafe::74) by MN2PR06CA0003.outlook.office365.com
 (2603:10b6:208:23d::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend
 Transport; Thu, 17 Dec 2020 07:54:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT034.mail.protection.outlook.com (10.152.77.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3654.12 via Frontend Transport; Thu, 17 Dec 2020 07:54:44 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Wed, 16 Dec 2020 23:53:39 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Wed, 16 Dec 2020 23:53:39 -0800
Envelope-to: michal.simek@xilinx.com,
 sonal.santan@xilinx.com,
 lizhih@xilinx.com,
 maxz@xilinx.com,
 stefanos@xilinx.com,
 mdf@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.72.212] (port=42048 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <sonal.santan@xilinx.com>)
        id 1kpo6V-0007cc-6S; Wed, 16 Dec 2020 23:53:39 -0800
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 6354)
        id 0C838600118; Wed, 16 Dec 2020 23:51:27 -0800 (PST)
From:   Sonal Santan <sonal.santan@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Sonal Santan <sonal.santan@xilinx.com>,
        <linux-fpga@vger.kernel.org>, <maxz@xilinx.com>,
        <lizhih@xilinx.com>, <michal.simek@xilinx.com>,
        <stefanos@xilinx.com>, <devicetree@vger.kernel.org>,
        <trix@redhat.com>, <mdf@kernel.org>
Subject: [PATCH V2 XRT Alveo 6/6] fpga: xrt: Kconfig and Makefile updates for XRT drivers
Date:   Wed, 16 Dec 2020 23:50:46 -0800
Message-ID: <20201217075046.28553-7-sonals@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201217075046.28553-1-sonals@xilinx.com>
References: <20201217075046.28553-1-sonals@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3266f14-e8e9-4e47-ec32-08d8a261048b
X-MS-TrafficTypeDiagnostic: DM6PR02MB5723:
X-Microsoft-Antispam-PRVS: <DM6PR02MB57234D4DE82E2AFFECE97E87BBC40@DM6PR02MB5723.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fXyHbArf0D+kRKTvauUD8nxbtTzqIh3BsoINHJX7SB8wt+FFMo1CGfq9Z5p2b9pYPGfjN3ZpolvE6jJSGV7GXu3GJMps+lPnZm5QWKZKVspqi6N1h7R89UGAGCnqPnuqDt3gpSGMYLbijPyvTQy5F5bcwMxFSdvhfrWrTU3KXhRCErD2ELp/2fQv6xLPF0qouGakr0SA/OkYLA7pDQA7Y33Y2ZdTDoobcYcfezAV82xXod28DoBHVrrzHH6RDfST5lqBx1sNeWtpmqsMllx/sTDxGWWUKpnrtBiz3aW//wYAAmQnArLgXwd78flVBflj/OIeDgLoDq+VlXYrQkWQfOM36C73RsGUUN2cGFSeKeLgv3CV04eaov8cj8Flfdsp4oZrfOUDZLeZGU52R8q2SA==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(136003)(39860400002)(46966005)(5660300002)(6916009)(2616005)(2906002)(478600001)(356005)(6666004)(44832011)(426003)(42186006)(336012)(316002)(6266002)(7636003)(1076003)(82740400003)(4326008)(8676002)(8936002)(15650500001)(36756003)(70586007)(70206006)(26005)(82310400003)(47076004)(83380400001)(54906003)(186003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2020 07:54:44.2902
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3266f14-e8e9-4e47-ec32-08d8a261048b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT034.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5723
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Sonal Santan <sonal.santan@xilinx.com>

Update fpga Kconfig/Makefile and add Kconfig/Makefile for
new drivers.

Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
---
 drivers/fpga/Kconfig           |  2 ++
 drivers/fpga/Makefile          |  4 ++++
 drivers/fpga/xrt/Kconfig       |  7 +++++++
 drivers/fpga/xrt/Makefile      | 21 +++++++++++++++++++++
 drivers/fpga/xrt/lib/Kconfig   | 11 +++++++++++
 drivers/fpga/xrt/lib/Makefile  | 30 ++++++++++++++++++++++++++++++
 drivers/fpga/xrt/mgmt/Kconfig  | 11 +++++++++++
 drivers/fpga/xrt/mgmt/Makefile | 27 +++++++++++++++++++++++++++
 8 files changed, 113 insertions(+)
 create mode 100644 drivers/fpga/xrt/Kconfig
 create mode 100644 drivers/fpga/xrt/Makefile
 create mode 100644 drivers/fpga/xrt/lib/Kconfig
 create mode 100644 drivers/fpga/xrt/lib/Makefile
 create mode 100644 drivers/fpga/xrt/mgmt/Kconfig
 create mode 100644 drivers/fpga/xrt/mgmt/Makefile

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 7cd5a29fc437..73e4deb20986 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -215,4 +215,6 @@ config FPGA_MGR_ZYNQMP_FPGA
 	  to configure the programmable logic(PL) through PS
 	  on ZynqMP SoC.
 
+source "drivers/fpga/xrt/Kconfig"
+
 endif # FPGA
diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
index d8e21dfc6778..2b4453ff7c52 100644
--- a/drivers/fpga/Makefile
+++ b/drivers/fpga/Makefile
@@ -46,3 +46,7 @@ dfl-afu-objs += dfl-afu-error.o
 
 # Drivers for FPGAs which implement DFL
 obj-$(CONFIG_FPGA_DFL_PCI)		+= dfl-pci.o
+
+# XRT drivers for Alveo
+obj-$(CONFIG_FPGA_XRT_LIB)		+= xrt/lib/
+obj-$(CONFIG_FPGA_XRT_XMGMT)		+= xrt/mgmt/
diff --git a/drivers/fpga/xrt/Kconfig b/drivers/fpga/xrt/Kconfig
new file mode 100644
index 000000000000..50422f77c6df
--- /dev/null
+++ b/drivers/fpga/xrt/Kconfig
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Xilinx Alveo FPGA device configuration
+#
+
+source "drivers/fpga/xrt/lib/Kconfig"
+source "drivers/fpga/xrt/mgmt/Kconfig"
diff --git a/drivers/fpga/xrt/Makefile b/drivers/fpga/xrt/Makefile
new file mode 100644
index 000000000000..19e828cc7af9
--- /dev/null
+++ b/drivers/fpga/xrt/Makefile
@@ -0,0 +1,21 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (C) 2020 Xilinx, Inc. All rights reserved.
+#
+# Authors: Sonal.Santan@xilinx.com
+#
+
+all:
+	$(MAKE) -C lib all
+	$(MAKE) -C mgmt all
+	$(MAKE) lint
+
+tags:
+	../../../../scripts/tags.sh
+
+clean:
+	$(MAKE) -C lib clean
+	$(MAKE) -C mgmt clean
+
+lint:
+	../../../../scripts/lint.sh
diff --git a/drivers/fpga/xrt/lib/Kconfig b/drivers/fpga/xrt/lib/Kconfig
new file mode 100644
index 000000000000..541af91008ee
--- /dev/null
+++ b/drivers/fpga/xrt/lib/Kconfig
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# XRT Alveo FPGA device configuration
+#
+
+config FPGA_XRT_LIB
+	tristate "XRT Alveo Driver Library"
+	depends on HWMON && PCI
+	select LIBFDT
+	help
+	  XRT Alveo FPGA PCIe device driver common library.
diff --git a/drivers/fpga/xrt/lib/Makefile b/drivers/fpga/xrt/lib/Makefile
new file mode 100644
index 000000000000..176e2134171c
--- /dev/null
+++ b/drivers/fpga/xrt/lib/Makefile
@@ -0,0 +1,30 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (C) 2020 Xilinx, Inc. All rights reserved.
+#
+# Authors: Sonal.Santan@xilinx.com
+#
+
+FULL_XRT_PATH=$(srctree)/$(src)/..
+FULL_DTC_PATH=$(srctree)/scripts/dtc/libfdt
+
+obj-$(CONFIG_FPGA_XRT_LIB) := xrt-lib.o
+
+xrt-lib-objs := 			\
+	xrt-main.o			\
+	xrt-subdev.o			\
+	xrt-cdev.o			\
+	../common/xrt-metadata.o	\
+	subdevs/xrt-partition.o		\
+	subdevs/xrt-vsec.o		\
+	subdevs/xrt-axigate.o		\
+	subdevs/xrt-gpio.o		\
+	subdevs/xrt-icap.o		\
+	subdevs/xrt-clock.o		\
+	subdevs/xrt-clkfreq.o		\
+	subdevs/xrt-ucs.o		\
+	subdevs/xrt-calib.o
+
+ccflags-y := -I$(FULL_XRT_PATH)/include \
+	-I$(FULL_XRT_PATH)/common \
+	-I$(FULL_DTC_PATH)
diff --git a/drivers/fpga/xrt/mgmt/Kconfig b/drivers/fpga/xrt/mgmt/Kconfig
new file mode 100644
index 000000000000..a2fe7ab21941
--- /dev/null
+++ b/drivers/fpga/xrt/mgmt/Kconfig
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Xilinx XRT FPGA device configuration
+#
+
+config FPGA_XRT_XMGMT
+	tristate "Xilinx Alveo Management Driver"
+	depends on HWMON && PCI && FPGA_XRT_LIB
+	select LIBFDT
+	help
+	  XRT Alveo FPGA PCIe device driver for Management Physical Function.
diff --git a/drivers/fpga/xrt/mgmt/Makefile b/drivers/fpga/xrt/mgmt/Makefile
new file mode 100644
index 000000000000..d32698b8bf58
--- /dev/null
+++ b/drivers/fpga/xrt/mgmt/Makefile
@@ -0,0 +1,27 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (C) 2019-2020 Xilinx, Inc. All rights reserved.
+#
+# Authors: Sonal.Santan@xilinx.com
+#
+
+FULL_XRT_PATH=$(srctree)/$(src)/..
+FULL_DTC_PATH=$(srctree)/scripts/dtc/libfdt
+
+obj-$(CONFIG_FPGA_XRT_XMGMT)	+= xmgmt.o
+
+commondir := ../common
+
+xmgmt-objs := xmgmt-root.o			\
+	   xmgmt-main.o				\
+	   xmgmt-fmgr-drv.o      		\
+	   xmgmt-main-region.o			\
+	   $(commondir)/xrt-root.o		\
+	   $(commondir)/xrt-metadata.o		\
+	   $(commondir)/xrt-xclbin.o
+
+
+
+ccflags-y := -I$(FULL_XRT_PATH)/include \
+	-I$(FULL_XRT_PATH)/common \
+	-I$(FULL_DTC_PATH)
-- 
2.17.1


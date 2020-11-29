Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E597A2C76C6
	for <lists+linux-fpga@lfdr.de>; Sun, 29 Nov 2020 01:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729708AbgK2AEg (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 28 Nov 2020 19:04:36 -0500
Received: from mail-dm6nam10on2054.outbound.protection.outlook.com ([40.107.93.54]:10112
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729696AbgK2AEg (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sat, 28 Nov 2020 19:04:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SaZSvD/2CfpbDJW4EMWS81QptryhChDo7AnWqIgEDytJvPkWRUumlcSm6Jr1wJn870Ibne3Yf1yLABeofKWIFJ5BabPZfnsvwUgOidPbkoqVA+erqPYVinYhLSu2pFAIuJ5CYohFySTLkMjoYC2tzeD8sUG6BSc7lg7/e7By0/bxnmUvCqc00K1KvpK4KG3Wb8Kqjo2nr6itJIfdgUqiAvOCf6pMvaa6QdBJrPsViP8aQ7t8y6qPNdGn1Zu1B/8ttulMThrwKmFVO5U2DQX1e3eeVo1cqPoXi7wzh53PD5M3LLoitqEhn8ZDT0orn/5FEKLcJDb3xH6Q5CSeEs1FYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9OqiRMscmrD13Cd4jwI5dNfOD3ZIK8YoKkRqpIlFRoo=;
 b=doYMa1R+3ifTPz8jbHBGBs7lNuMvUQKynft8KF3cYYZAvPj3qurcb6Wy2Ba49mNL4Ufges9OH3wQp4MsYA6EFJFkS3jlYgqGNL3igyWGpY2UHuy9x/vgOvikmOePgM+gRiQRCBd5eFpcbfCN8YElTnKJc3fXB6UuVqvGlpfeAEpYEY7cX23rkJLEdJrc5cnNbFyOwjfjIj8vQtXZfv3m4uLorfqUESHGnsBBSDIjvLRd8xkhcLkzbdCxO/dwhPGwmqlbL/4wveRatMLFwkDOG06sx1J6XYnmMW9hxYqXGf0Cdp6mI/6s5EgtNSM43byqEROWMrl4pV4zBzzEU6yb9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9OqiRMscmrD13Cd4jwI5dNfOD3ZIK8YoKkRqpIlFRoo=;
 b=kzd2T41jKjLOfhch5x8r5EPoaegvUoHACnj1cfs6d6Jg6X0vdKPS7RAuohGSjzUsVi5+/49jkszw8ohUmwbudqzGMZra1fYsyJleF23CyJ+vo+EVaZ72m75NjvoT1FiBeAu/8d+12WB86FJErzQvGBfqzI8RTfLv8x69QGMmL54=
Received: from BL0PR02CA0003.namprd02.prod.outlook.com (2603:10b6:207:3c::16)
 by MN2PR02MB6719.namprd02.prod.outlook.com (2603:10b6:208:1d8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Sun, 29 Nov
 2020 00:03:43 +0000
Received: from BL2NAM02FT047.eop-nam02.prod.protection.outlook.com
 (2603:10b6:207:3c:cafe::d8) by BL0PR02CA0003.outlook.office365.com
 (2603:10b6:207:3c::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend
 Transport; Sun, 29 Nov 2020 00:03:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT047.mail.protection.outlook.com (10.152.77.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3611.27 via Frontend Transport; Sun, 29 Nov 2020 00:03:42 +0000
Received: from xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Sat, 28 Nov 2020 16:03:15 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Sat, 28 Nov 2020 16:03:15 -0800
Envelope-to: michal.simek@xilinx.com,
 sonal.santan@xilinx.com,
 lizhih@xilinx.com,
 maxz@xilinx.com,
 stefanos@xilinx.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.72.212] (port=45062 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <sonal.santan@xilinx.com>)
        id 1kjABP-0004cK-4f; Sat, 28 Nov 2020 16:03:15 -0800
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 6354)
        id 7014060011B; Sat, 28 Nov 2020 16:00:45 -0800 (PST)
From:   Sonal Santan <sonal.santan@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Sonal Santan <sonal.santan@xilinx.com>,
        <linux-fpga@vger.kernel.org>, <maxz@xilinx.com>,
        <lizhih@xilinx.com>, <michal.simek@xilinx.com>,
        <stefanos@xilinx.com>, <devicetree@vger.kernel.org>
Subject: [PATCH Xilinx Alveo 8/8] fpga: xrt: Kconfig and Makefile updates for XRT drivers
Date:   Sat, 28 Nov 2020 16:00:40 -0800
Message-ID: <20201129000040.24777-9-sonals@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201129000040.24777-1-sonals@xilinx.com>
References: <20201129000040.24777-1-sonals@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1bcd916-1a71-495f-0106-08d893fa3bf7
X-MS-TrafficTypeDiagnostic: MN2PR02MB6719:
X-Microsoft-Antispam-PRVS: <MN2PR02MB67191213516926B0414E58AFBBF60@MN2PR02MB6719.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I7Ec+UiYrxwiECsE2j/hkfzqKALU9Nc4FcbhKBgf6pZgw4es81aA8yE/F9mXEBl28ENaANPGVQvbz//aN+x4XL8crd3t6FH07YCUexJzQDXXz8T68Ws0Wu3l/gbTww/0FFlyYgGxwfC6Nx5oAScsE5VnOyEXsenrQvfCz/qUkLRUQdTaDMAlTP2S7Ux4Bi/fN7MVc92XkFbT1dkUkp70SrSF3K36j7y4nMpewOLJwWZnGC8cQ7ZsOLTpb21bwkdxj81MnJ9KsydaMiSgflbFnC4651SgbuFvPd52490OwFTHI/pklM2pFI6cHEtbgUCcB3CkLk12aeJ5qnYJFnQBjlzef27BkwQfhRJKQsRc2JgjLZToj6MGhZ/c+iL7ebQ5WPxfMO9NFhkFZz61TYuvqg==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(136003)(39850400004)(46966005)(70586007)(70206006)(36756003)(83380400001)(5660300002)(7636003)(6916009)(47076004)(6666004)(82740400003)(82310400003)(356005)(2616005)(4326008)(15650500001)(42186006)(316002)(1076003)(54906003)(36906005)(44832011)(450100002)(186003)(478600001)(26005)(336012)(8676002)(426003)(2906002)(8936002)(6266002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2020 00:03:42.8626
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1bcd916-1a71-495f-0106-08d893fa3bf7
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT047.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6719
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Sonal Santan <sonal.santan@xilinx.com>

Update fpga Kconfig/Makefile and add Kconfig/Makefile for
new drivers.

Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
---
 drivers/fpga/Kconfig             |  2 ++
 drivers/fpga/Makefile            |  3 +++
 drivers/fpga/alveo/Kconfig       |  7 ++++++
 drivers/fpga/alveo/lib/Kconfig   | 11 +++++++++
 drivers/fpga/alveo/lib/Makefile  | 42 ++++++++++++++++++++++++++++++++
 drivers/fpga/alveo/mgmt/Kconfig  | 11 +++++++++
 drivers/fpga/alveo/mgmt/Makefile | 28 +++++++++++++++++++++
 7 files changed, 104 insertions(+)
 create mode 100644 drivers/fpga/alveo/Kconfig
 create mode 100644 drivers/fpga/alveo/lib/Kconfig
 create mode 100644 drivers/fpga/alveo/lib/Makefile
 create mode 100644 drivers/fpga/alveo/mgmt/Kconfig
 create mode 100644 drivers/fpga/alveo/mgmt/Makefile

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 7cd5a29fc437..8687ef231308 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -215,4 +215,6 @@ config FPGA_MGR_ZYNQMP_FPGA
 	  to configure the programmable logic(PL) through PS
 	  on ZynqMP SoC.
 
+source "drivers/fpga/alveo/Kconfig"
+
 endif # FPGA
diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
index d8e21dfc6778..59943dccf405 100644
--- a/drivers/fpga/Makefile
+++ b/drivers/fpga/Makefile
@@ -46,3 +46,6 @@ dfl-afu-objs += dfl-afu-error.o
 
 # Drivers for FPGAs which implement DFL
 obj-$(CONFIG_FPGA_DFL_PCI)		+= dfl-pci.o
+
+obj-$(CONFIG_FPGA_ALVEO_LIB)		+= alveo/lib/
+obj-$(CONFIG_FPGA_ALVEO_XMGMT)		+= alveo/mgmt/
diff --git a/drivers/fpga/alveo/Kconfig b/drivers/fpga/alveo/Kconfig
new file mode 100644
index 000000000000..a583c3543945
--- /dev/null
+++ b/drivers/fpga/alveo/Kconfig
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Xilinx Alveo FPGA device configuration
+#
+
+source "drivers/fpga/alveo/lib/Kconfig"
+source "drivers/fpga/alveo/mgmt/Kconfig"
diff --git a/drivers/fpga/alveo/lib/Kconfig b/drivers/fpga/alveo/lib/Kconfig
new file mode 100644
index 000000000000..62175af2108e
--- /dev/null
+++ b/drivers/fpga/alveo/lib/Kconfig
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Xilinx Alveo FPGA device configuration
+#
+
+config FPGA_ALVEO_LIB
+	tristate "Xilinx Alveo Driver Library"
+	depends on HWMON && PCI 
+	select LIBFDT
+	help
+	  Xilinx Alveo FPGA PCIe device driver common library.
diff --git a/drivers/fpga/alveo/lib/Makefile b/drivers/fpga/alveo/lib/Makefile
new file mode 100644
index 000000000000..a14204dc489d
--- /dev/null
+++ b/drivers/fpga/alveo/lib/Makefile
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (C) 2020 Xilinx, Inc. All rights reserved.
+#
+# Authors: Sonal.Santan@xilinx.com
+#
+
+FULL_ALVEO_PATH=$(srctree)/$(src)/..
+FULL_DTC_PATH=$(srctree)/scripts/dtc/libfdt
+
+obj-$(CONFIG_FPGA_ALVEO_LIB) := xrt-lib.o
+
+xrt-lib-objs := 			\
+	xrt-main.o			\
+	xrt-subdev.o			\
+	xrt-cdev.o			\
+	../common/xrt-metadata.o	\
+	subdevs/xrt-partition.o	\
+	subdevs/xrt-test.o		\
+	subdevs/xrt-vsec.o		\
+	subdevs/xrt-vsec-golden.o	\
+	subdevs/xrt-axigate.o		\
+	subdevs/xrt-qspi.o		\
+	subdevs/xrt-gpio.o		\
+	subdevs/xrt-mailbox.o		\
+	subdevs/xrt-icap.o		\
+	subdevs/xrt-cmc.o		\
+	subdevs/xrt-cmc-ctrl.o		\
+	subdevs/xrt-cmc-sensors.o	\
+	subdevs/xrt-cmc-mailbox.o	\
+	subdevs/xrt-cmc-bdinfo.o	\
+	subdevs/xrt-cmc-sc.o		\
+	subdevs/xrt-srsr.o		\
+	subdevs/xrt-clock.o		\
+	subdevs/xrt-clkfreq.o		\
+	subdevs/xrt-ucs.o		\
+	subdevs/xrt-calib.o
+
+
+ccflags-y := -I$(FULL_ALVEO_PATH)/include \
+	-I$(FULL_ALVEO_PATH)/common \
+	-I$(FULL_DTC_PATH)
diff --git a/drivers/fpga/alveo/mgmt/Kconfig b/drivers/fpga/alveo/mgmt/Kconfig
new file mode 100644
index 000000000000..8a5590842dad
--- /dev/null
+++ b/drivers/fpga/alveo/mgmt/Kconfig
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Xilinx Alveo FPGA device configuration
+#
+
+config FPGA_ALVEO_XMGMT
+	tristate "Xilinx Alveo Management Driver"
+	depends on HWMON && PCI && FPGA_ALVEO_LIB
+	select LIBFDT
+	help
+	  Xilinx Alveo FPGA PCIe device driver for Management Physical Function.
diff --git a/drivers/fpga/alveo/mgmt/Makefile b/drivers/fpga/alveo/mgmt/Makefile
new file mode 100644
index 000000000000..08be7952a832
--- /dev/null
+++ b/drivers/fpga/alveo/mgmt/Makefile
@@ -0,0 +1,28 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (C) 2019-2020 Xilinx, Inc. All rights reserved.
+#
+# Authors: Sonal.Santan@xilinx.com
+#
+
+FULL_ALVEO_PATH=$(srctree)/$(src)/..
+FULL_DTC_PATH=$(srctree)/scripts/dtc/libfdt
+
+obj-$(CONFIG_FPGA_ALVEO_XMGMT)	+= xmgmt.o
+
+commondir := ../common
+
+xmgmt-objs := xmgmt-root.o			\
+	   xmgmt-main.o				\
+	   xmgmt-fmgr-drv.o      		\
+	   xmgmt-main-ulp.o			\
+	   xmgmt-main-mailbox.o			\
+	   $(commondir)/xrt-root.o		\
+	   $(commondir)/xrt-metadata.o		\
+	   $(commondir)/xrt-xclbin.o
+
+
+
+ccflags-y := -I$(FULL_ALVEO_PATH)/include \
+	-I$(FULL_ALVEO_PATH)/common \
+	-I$(FULL_DTC_PATH)
-- 
2.17.1


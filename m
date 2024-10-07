Return-Path: <linux-fpga+bounces-757-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14ADF9939C3
	for <lists+linux-fpga@lfdr.de>; Tue,  8 Oct 2024 00:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 816EFB23341
	for <lists+linux-fpga@lfdr.de>; Mon,  7 Oct 2024 22:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4425518CBEA;
	Mon,  7 Oct 2024 22:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="N8Ztyabw"
X-Original-To: linux-fpga@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C094D18A6DC;
	Mon,  7 Oct 2024 22:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728338500; cv=fail; b=V3AYqfgy8eJSd5Pin9S5TTFI+cM2rnrv/tjKh3qbo6kCoNCkTNiNC2D3dSLKqqromVa7x6WCVEmXp35Wgsyo7XlC+AeDpsRFisAE3kW8KpUBxCM/mjaWMYu71H3YzHhwYZNjyopCwf+wiW+K7ifzEgmplgDjr/zw1rnURfFkYJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728338500; c=relaxed/simple;
	bh=8JeASCvPeN8fFS/VYs9MvOsS2ATK2FAfn0fq/swkqWE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=X6+LPIA1Euj5XpFWEPdWfwdpmIFwTR+oIzYIffCD5eSamdSN+4mQlRSxvdi//oSPXh60B26wjZ0QkaqvZrV+BheS6WxQZqQc0TU7HBCg6S3w5ZSTg7gN6MfB+/r6/qqOCo+MVce7TPYknRO3OWZjXcBV6MQM4ftGewBTAuYJmHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=N8Ztyabw; arc=fail smtp.client-ip=40.107.223.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I8hp8YnKCpWyc1Fur7SFdylcBdJwDY3wez0mybY7hI+QDSifFt2F8OA9tg/Znqh8opqCtAZXJbtyjjCekXfpFDRejtD3iJ/oG0esC+p/+VyV6DjFL5o0ZiY33UfTbiyPo4aP9mtHDG+Ox3YEXs1/TbYYZWELTWCvewOJSY8Zrsgjwj1w8BeezwOpVDsXwGA6V7HmWTfn4xiwfu6UGmh/DmMY5wpMiOjx6hpsPBCdiDTiZ44ntE9lsJm+0CwMJlI2yTK/Ecy4Wcb+d34QmXnQbIFgnlljzuRSgJ7qPk9OqKPaQyXLDhaguK1xNrbFlOYWYnDo+DSyj3KHvEf812zSSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oCRy3kC0unmQWEF0XKnvmfFQlDTgqjedB9su2SCWCCo=;
 b=FoydI2DQG+fuBrsxJTBC3gs/6/9/IuJOjMulc2KKH1FiKdjZZCFejAncjzuQPPPRUmKPptgsogO0QTEbchV7URfZtcp7sT3eoTmthWaiHefjX+cX1NJkWXavE2ngZNKrWcFq3vEaTGcBNSnaHi/EsxGFX7jrbLDu4ooad5SEd0Sc6THucGojt48GqRweJl5RgTerqg+u2xs94r4+laLD3WJycupuOpJ5fPF98XG8mGLQXtV2H5qatRbarhvOholTsboQYYyVjme6zW0E2MGD6DEF9AXQLtz5bbrFTj0ZQYsAIxYf4s4Kbx8Mckwg0p/vezJtxtGB4pP1ZOGdaPlebQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oCRy3kC0unmQWEF0XKnvmfFQlDTgqjedB9su2SCWCCo=;
 b=N8ZtyabwN5hcI+mZHdJzImvnYI9zx/4y1er/dbU5OHUgO43AXRMVN8pVJy0CmlHc7yu8OL7fN7BRwrIBKioaZGnkJnx3X+AdCyUc75ZaURdbB1ipHxaVAblUKk4OxPI5zNAXpLoQfHb0N6UWR1zaRvqsJcszv+iQie6OSH3yVgA=
Received: from MN2PR01CA0014.prod.exchangelabs.com (2603:10b6:208:10c::27) by
 IA0PR12MB7601.namprd12.prod.outlook.com (2603:10b6:208:43b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 22:01:32 +0000
Received: from BN2PEPF000055E1.namprd21.prod.outlook.com
 (2603:10b6:208:10c:cafe::97) by MN2PR01CA0014.outlook.office365.com
 (2603:10b6:208:10c::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.29 via Frontend
 Transport; Mon, 7 Oct 2024 22:01:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055E1.mail.protection.outlook.com (10.167.245.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.0 via Frontend Transport; Mon, 7 Oct 2024 22:01:32 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Oct
 2024 17:01:31 -0500
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 7 Oct 2024 17:01:30 -0500
From: David Zhang <yidong.zhang@amd.com>
To: <linux-kernel@vger.kernel.org>, <linux-fpga@vger.kernel.org>,
	<mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>
CC: Yidong Zhang <yidong.zhang@amd.com>, <lizhi.hou@amd.com>, DMG Karthik
	<Karthik.DMG@amd.com>, Nishad Saraf <nishads@amd.com>, Prapul Krishnamurthy
	<prapulk@amd.com>
Subject: [PATCH V1 1/3] drivers/fpga/amd: Add new driver for AMD Versal PCIe card
Date: Mon, 7 Oct 2024 15:01:26 -0700
Message-ID: <20241007220128.3023169-1-yidong.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: yidong.zhang@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E1:EE_|IA0PR12MB7601:EE_
X-MS-Office365-Filtering-Correlation-Id: 595b2b7f-19e8-4a67-c5cd-08dce71b9a70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?24MGsLEpxns0N3FGJgDjRfQeH/mQL0Us5emSZSqSlrX1TWy0dtD4A3UnSdYk?=
 =?us-ascii?Q?E+TqExR7cPgJGVBcVefaHz/mRCABrnsUzSvfTGUPe+eIlVqiXd8i3i+VyBZ8?=
 =?us-ascii?Q?mC0T9xqL0wsrSMPPospEGFZr/ieAZTIYe8LgHfHqvfqJukDPWOmdMzVytS9Y?=
 =?us-ascii?Q?9rB6f3fEZ6q6zh7fhZSUoyQKKVfDwsoGqDv0bTN5s+2jw/YhuQ1g3F9Mfd4C?=
 =?us-ascii?Q?4ubf7pgeJCxxXyuvgZYICAsDMjKSO72tBM4LR1j5lWzA0FfAyWN73RnVPL62?=
 =?us-ascii?Q?0LjHtIH8J63gFolHP98CE4WL+6yLGlDwscpRuvnCQ1yDMo2+y+4+VL6cxj9Y?=
 =?us-ascii?Q?h9rHf6cAvvvyV8U6X+LJtXaw1MWYOHDA7NdHexszRe7P/UEwZibpvv5m4Gk0?=
 =?us-ascii?Q?8VvCiJMNS1FxJ0mUGDxhKGtnWBaxE+cXTQ2ZniD5L6rPA9KfBUujyLWt4KlK?=
 =?us-ascii?Q?q77lmgVb00NB0dzY1odPZK3VubWs2CKetm3iOLXmKVDYNNkYI8E4zYPK+YHS?=
 =?us-ascii?Q?LsGZpGiDpFDJi2igIoYKVHffxSHzCUJKTLpVgezfEv04fIhQBD06MG1562/b?=
 =?us-ascii?Q?xZXDLO7IuNClhRLqScU4Q6RrIfTu2puCvoP2C5+sKhe+nN/cfsjFbdwB+Nzx?=
 =?us-ascii?Q?5HrNmzqKDvA8Sklfs9xLNuhx5y88Qy9W1ouILIztX7MtY6DpFK1gOrBpm/VE?=
 =?us-ascii?Q?+s8ue7DNvc3qhwiS6Ds1BdhzNgnzEdT5xs9T6nMlIBmK3M0VGV/Ipu89flD1?=
 =?us-ascii?Q?HNq5yVApo+GRULkLR8Cjka/1jh4pcbubirEDD4w+cCIJCHzT9lI3oiRl94sR?=
 =?us-ascii?Q?dM5HHCBty9CdvzISBWVuGmnLTdDLEFCkjbGBtyNshZzMq1S/C/HYsujCP3Gl?=
 =?us-ascii?Q?Cp73tB8cXYdCNLFeaGiOkRLmk3ehrvApxXIB68pIUFr5dyTCt9JLss8iUkLH?=
 =?us-ascii?Q?Jb4Nb2m2kmvp5HNVVZkqUV7BtknOeAy6pZxDum2y4UwwO8FkACg+LUmmsb16?=
 =?us-ascii?Q?KH3ZGc3mvsCIgNLFGtjGrF8JNGXEG2G+TnkVPp7Tgf/pBfV1v0jlk57S2wG7?=
 =?us-ascii?Q?hlzB5ptSCwBRA+0IxVHuWhnPiFRT1tEDNkTZuzk+Gsjn/Ia0Hl8leJ7BgB2N?=
 =?us-ascii?Q?vS0F4p4XuA3btgBhWuvsXcBc3jadbUrnVQuWK8UaSf9PecuZUzGq/uECwtB0?=
 =?us-ascii?Q?FdBZCnlRjE/hmJL2gGzGsCgNE5T692efyOAKrKBmEVa3sBKeRsS8gA7KK4/Z?=
 =?us-ascii?Q?/DIlmora/DVVlsrgLw+j01Szxy3JShqI9oyRg1X8JNvP2UJU81Qk+z0jvTDl?=
 =?us-ascii?Q?+JQQpp/a2wG6grCc96d6LWREjFArbT1VWaz2Z2OqnV2scnFwW8Ja/z82Fr+G?=
 =?us-ascii?Q?/WbI7VgdX87CD3rpQc2StVlRwmCY?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 22:01:32.0357
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 595b2b7f-19e8-4a67-c5cd-08dce71b9a70
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055E1.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7601

From: Yidong Zhang <yidong.zhang@amd.com>

AMD Versal based PCIe card, including V70, is designed for AI inference
efficiency and is tuned for video analytics and natural language processing
applications.

Add the driver to support AMD Versal card management physical function.
Only very basic functionalities are added.
  - module and PCI device initialization
  - fpga framework ops callbacks
  - communication with user physical function

Co-developed-by: DMG Karthik <Karthik.DMG@amd.com>
Signed-off-by: DMG Karthik <Karthik.DMG@amd.com>
Co-developed-by: Nishad Saraf <nishads@amd.com>
Signed-off-by: Nishad Saraf <nishads@amd.com>
Co-developed-by: Prapul Krishnamurthy <prapulk@amd.com>
Signed-off-by: Prapul Krishnamurthy <prapulk@amd.com>
Signed-off-by: Yidong Zhang <yidong.zhang@amd.com>
---
 MAINTAINERS                    |   7 +
 drivers/fpga/Kconfig           |   3 +
 drivers/fpga/Makefile          |   3 +
 drivers/fpga/amd/Kconfig       |  17 ++
 drivers/fpga/amd/Makefile      |   6 +
 drivers/fpga/amd/vmgmt-comms.c | 344 ++++++++++++++++++++++++++++
 drivers/fpga/amd/vmgmt-comms.h |  14 ++
 drivers/fpga/amd/vmgmt.c       | 395 +++++++++++++++++++++++++++++++++
 drivers/fpga/amd/vmgmt.h       | 100 +++++++++
 include/uapi/linux/vmgmt.h     |  25 +++
 10 files changed, 914 insertions(+)
 create mode 100644 drivers/fpga/amd/Kconfig
 create mode 100644 drivers/fpga/amd/Makefile
 create mode 100644 drivers/fpga/amd/vmgmt-comms.c
 create mode 100644 drivers/fpga/amd/vmgmt-comms.h
 create mode 100644 drivers/fpga/amd/vmgmt.c
 create mode 100644 drivers/fpga/amd/vmgmt.h
 create mode 100644 include/uapi/linux/vmgmt.h

diff --git a/MAINTAINERS b/MAINTAINERS
index a097afd76ded..645f00ccb342 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1185,6 +1185,13 @@ M:	Sanjay R Mehta <sanju.mehta@amd.com>
 S:	Maintained
 F:	drivers/spi/spi-amd.c
 
+AMD VERSAL PCI DRIVER
+M:	Yidong Zhang <yidong.zhang@amd.com>
+L:	linux-fpga@vger.kernel.org
+S:	Supported
+F:	drivers/fpga/amd/
+F:	include/uapi/linux/vmgmt.h
+
 AMD XGBE DRIVER
 M:	"Shyam Sundar S K" <Shyam-sundar.S-k@amd.com>
 L:	netdev@vger.kernel.org
diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 37b35f58f0df..dce060a7bd8f 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -290,4 +290,7 @@ config FPGA_MGR_LATTICE_SYSCONFIG_SPI
 
 source "drivers/fpga/tests/Kconfig"
 
+# Driver files
+source "drivers/fpga/amd/Kconfig"
+
 endif # FPGA
diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
index aeb89bb13517..5e8a3869f9a0 100644
--- a/drivers/fpga/Makefile
+++ b/drivers/fpga/Makefile
@@ -58,5 +58,8 @@ obj-$(CONFIG_FPGA_DFL_NIOS_INTEL_PAC_N3000)	+= dfl-n3000-nios.o
 # Drivers for FPGAs which implement DFL
 obj-$(CONFIG_FPGA_DFL_PCI)		+= dfl-pci.o
 
+# AMD PCIe Versal Management Driver
+obj-y					+= amd/
+
 # KUnit tests
 obj-$(CONFIG_FPGA_KUNIT_TESTS)		+= tests/
diff --git a/drivers/fpga/amd/Kconfig b/drivers/fpga/amd/Kconfig
new file mode 100644
index 000000000000..126bc579a333
--- /dev/null
+++ b/drivers/fpga/amd/Kconfig
@@ -0,0 +1,17 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config AMD_VERSAL_MGMT
+	tristate "AMD PCIe Versal Management Driver"
+	select FW_LOADER
+	select FW_UPLOAD
+	select REGMAP_MMIO
+	depends on FPGA_BRIDGE
+	depends on FPGA_REGION
+	depends on HAS_IOMEM
+	depends on PCI
+	help
+	  AMD PCIe Versal Management Driver provides management services to
+	  download firmware, program bitstream, collect sensor data, control
+	  resets, and communicate with the User function.
+
+	  If "M" is selected, the driver module will be amd-vmgmt.
diff --git a/drivers/fpga/amd/Makefile b/drivers/fpga/amd/Makefile
new file mode 100644
index 000000000000..3e4c6dd3b787
--- /dev/null
+++ b/drivers/fpga/amd/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_AMD_VERSAL_MGMT)			+= amd-vmgmt.o
+
+amd-vmgmt-$(CONFIG_AMD_VERSAL_MGMT)		:= vmgmt.o	\
+						   vmgmt-comms.o
diff --git a/drivers/fpga/amd/vmgmt-comms.c b/drivers/fpga/amd/vmgmt-comms.c
new file mode 100644
index 000000000000..bed0d369a744
--- /dev/null
+++ b/drivers/fpga/amd/vmgmt-comms.c
@@ -0,0 +1,344 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for Versal PCIe device
+ *
+ * Copyright (C) 2024 Advanced Micro Devices, Inc. All rights reserved.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/jiffies.h>
+#include <linux/mutex.h>
+#include <linux/pci.h>
+#include <linux/timer.h>
+#include <linux/uuid.h>
+#include <linux/workqueue.h>
+
+#include "vmgmt.h"
+#include "vmgmt-comms.h"
+
+#define COMMS_PROTOCOL_VERSION			1
+#define COMMS_PCI_BAR_OFF			0x2000000
+#define COMMS_TIMER				(HZ / 10)
+#define COMMS_DATA_LEN				16
+#define COMMS_DATA_TYPE_MASK			GENMASK(7, 0)
+#define COMMS_DATA_EOM_MASK			BIT(31)
+#define COMMS_MSG_END				BIT(31)
+
+#define COMMS_REG_WRDATA_OFF			0x0
+#define COMMS_REG_RDDATA_OFF			0x8
+#define COMMS_REG_STATUS_OFF			0x10
+#define COMMS_REG_ERROR_OFF			0x14
+#define COMMS_REG_RIT_OFF			0x1C
+#define COMMS_REG_IS_OFF			0x20
+#define COMMS_REG_IE_OFF			0x24
+#define COMMS_REG_CTRL_OFF			0x2C
+#define COMMS_REGS_SIZE				0x1000
+
+#define COMMS_IRQ_DISABLE_ALL			0
+#define COMMS_IRQ_RECEIVE_ENABLE		BIT(1)
+#define COMMS_IRQ_CLEAR_ALL			GENMASK(2, 0)
+#define COMMS_CLEAR_FIFO			GENMASK(1, 0)
+#define COMMS_RECEIVE_THRESHOLD			15
+
+enum comms_req_ops {
+	COMMS_REQ_OPS_UNKNOWN			= 0,
+	COMMS_REQ_OPS_HOT_RESET			= 5,
+	COMMS_REQ_OPS_GET_PROTOCOL_VERSION	= 19,
+	COMMS_REQ_OPS_GET_XCLBIN_UUID		= 20,
+	COMMS_REQ_OPS_MAX,
+};
+
+enum comms_msg_type {
+	COMMS_MSG_INVALID			= 0,
+	COMMS_MSG_START				= 2,
+	COMMS_MSG_BODY				= 3,
+};
+
+enum comms_msg_service_type {
+	COMMS_MSG_SRV_RESPONSE			= BIT(0),
+	COMMS_MSG_SRV_REQUEST			= BIT(1),
+};
+
+struct comms_hw_msg {
+	struct {
+		u32		type;
+		u32		payload_size;
+	} header;
+	struct {
+		u64		id;
+		u32		flags;
+		u32		size;
+		u32		payload[COMMS_DATA_LEN - 6];
+	} body;
+} __packed;
+
+struct comms_srv_req {
+	u64			flags;
+	u32			opcode;
+	u32			data[];
+};
+
+struct comms_srv_ver_resp {
+	u32			version;
+};
+
+struct comms_srv_uuid_resp {
+	uuid_t			uuid;
+};
+
+struct comms_msg {
+	u64			id;
+	u32			flags;
+	u32			len;
+	u32			bytes_read;
+	u32			data[10];
+};
+
+struct comms_device {
+	struct vmgmt_device	*vdev;
+	struct regmap		*regmap;
+	struct timer_list	timer;
+	struct work_struct	work;
+};
+
+static bool comms_regmap_rd_regs(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case COMMS_REG_RDDATA_OFF:
+	case COMMS_REG_IS_OFF:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool comms_regmap_wr_regs(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case COMMS_REG_WRDATA_OFF:
+	case COMMS_REG_IS_OFF:
+	case COMMS_REG_IE_OFF:
+	case COMMS_REG_CTRL_OFF:
+	case COMMS_REG_RIT_OFF:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool comms_regmap_nir_regs(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case COMMS_REG_RDDATA_OFF:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static const struct regmap_config comms_regmap_config = {
+	.name = "comms_config",
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.readable_reg = comms_regmap_rd_regs,
+	.writeable_reg = comms_regmap_wr_regs,
+	.readable_noinc_reg = comms_regmap_nir_regs,
+};
+
+static inline struct comms_device *to_ccdev_work(struct work_struct *w)
+{
+	return container_of(w, struct comms_device, work);
+}
+
+static inline struct comms_device *to_ccdev_timer(struct timer_list *t)
+{
+	return container_of(t, struct comms_device, timer);
+}
+
+static u32 comms_set_uuid_resp(struct vmgmt_device *vdev, void *payload)
+{
+	struct comms_srv_uuid_resp *resp;
+	u32 resp_len = sizeof(*resp);
+
+	resp = (struct comms_srv_uuid_resp *)payload;
+	uuid_copy(&resp->uuid, &vdev->xclbin_uuid);
+	vmgmt_dbg(vdev, "xclbin UUID: %pUb", &resp->uuid);
+
+	return resp_len;
+}
+
+static u32 comms_set_protocol_resp(void *payload)
+{
+	struct comms_srv_ver_resp *resp = (struct comms_srv_ver_resp *)payload;
+	u32 resp_len = sizeof(*resp);
+
+	resp->version = COMMS_PROTOCOL_VERSION;
+
+	return sizeof(resp_len);
+}
+
+static void comms_send_response(struct comms_device *ccdev,
+				struct comms_msg *msg)
+{
+	struct comms_srv_req *req = (struct comms_srv_req *)msg->data;
+	struct vmgmt_device *vdev = ccdev->vdev;
+	struct comms_hw_msg response = {0};
+	u32 size;
+	int ret;
+	u8 i;
+
+	switch (req->opcode) {
+	case COMMS_REQ_OPS_GET_PROTOCOL_VERSION:
+		size = comms_set_protocol_resp(response.body.payload);
+		break;
+	case COMMS_REQ_OPS_GET_XCLBIN_UUID:
+		size = comms_set_uuid_resp(vdev, response.body.payload);
+		break;
+	default:
+		vmgmt_err(vdev, "Unsupported request opcode: %d", req->opcode);
+		*response.body.payload = -1;
+		size = sizeof(int);
+	}
+
+	vmgmt_dbg(vdev, "Response opcode: %d", req->opcode);
+
+	response.header.type = COMMS_MSG_START | COMMS_MSG_END;
+	response.header.payload_size = size;
+
+	response.body.flags = COMMS_MSG_SRV_RESPONSE;
+	response.body.size = size;
+	response.body.id = msg->id;
+
+	for (i = 0; i < COMMS_DATA_LEN; i++) {
+		ret = regmap_write(ccdev->regmap, COMMS_REG_WRDATA_OFF, ((u32 *)&response)[i]);
+		if (ret < 0) {
+			vmgmt_err(vdev, "regmap write failed: %d", ret);
+			return;
+		}
+	}
+}
+
+#define STATUS_IS_READY(status) ((status) & BIT(1))
+#define STATUS_IS_ERROR(status) ((status) & BIT(2))
+
+static void comms_check_request(struct work_struct *w)
+{
+	struct comms_device *ccdev = to_ccdev_work(w);
+	u32 status = 0, request[COMMS_DATA_LEN] = {0};
+	struct comms_hw_msg *hw_msg;
+	struct comms_msg msg;
+	u8 type, eom;
+	int ret;
+	int i;
+
+	ret = regmap_read(ccdev->regmap, COMMS_REG_IS_OFF, &status);
+	if (ret) {
+		vmgmt_err(ccdev->vdev, "regmap read failed: %d", ret);
+		return;
+	}
+	if (!STATUS_IS_READY(status))
+		return;
+	if (STATUS_IS_ERROR(status)) {
+		vmgmt_err(ccdev->vdev, "An error has occurred with comms");
+		return;
+	}
+
+	/* ACK status */
+	regmap_write(ccdev->regmap, COMMS_REG_IS_OFF, status);
+
+	for (i = 0; i < COMMS_DATA_LEN; i++) {
+		if (regmap_read(ccdev->regmap, COMMS_REG_RDDATA_OFF, &request[i]) < 0) {
+			vmgmt_err(ccdev->vdev, "regmap read failed");
+			return;
+		}
+	}
+
+	hw_msg = (struct comms_hw_msg *)request;
+	type = FIELD_GET(COMMS_DATA_TYPE_MASK, hw_msg->header.type);
+	eom = FIELD_GET(COMMS_DATA_EOM_MASK, hw_msg->header.type);
+
+	/* Only support fixed size 64B messages */
+	if (!eom || type != COMMS_MSG_START) {
+		vmgmt_err(ccdev->vdev, "Unsupported message format or length");
+		return;
+	}
+
+	msg.flags = hw_msg->body.flags;
+	msg.len = hw_msg->body.size;
+	msg.id = hw_msg->body.id;
+
+	if (msg.flags != COMMS_MSG_SRV_REQUEST) {
+		vmgmt_err(ccdev->vdev, "Unsupported service request");
+		return;
+	}
+
+	if (hw_msg->body.size > sizeof(msg.data) * sizeof(msg.data[0])) {
+		vmgmt_err(ccdev->vdev, "msg is too big: %d", hw_msg->body.size);
+		return;
+	}
+	memcpy(msg.data, hw_msg->body.payload, hw_msg->body.size);
+
+	/* Now decode and respond appropriately */
+	comms_send_response(ccdev, &msg);
+}
+
+static void comms_sched_work(struct timer_list *t)
+{
+	struct comms_device *ccdev = to_ccdev_timer(t);
+
+	/* Schedule a work in the general workqueue */
+	schedule_work(&ccdev->work);
+	/* Periodic timer */
+	mod_timer(&ccdev->timer, jiffies + COMMS_TIMER);
+}
+
+static void comms_config(struct comms_device *ccdev)
+{
+	/* Disable interrupts */
+	regmap_write(ccdev->regmap, COMMS_REG_IE_OFF, COMMS_IRQ_DISABLE_ALL);
+	/* Clear request and response FIFOs */
+	regmap_write(ccdev->regmap, COMMS_REG_CTRL_OFF, COMMS_CLEAR_FIFO);
+	/* Clear interrupts */
+	regmap_write(ccdev->regmap, COMMS_REG_IS_OFF, COMMS_IRQ_CLEAR_ALL);
+	/* Setup RIT reg */
+	regmap_write(ccdev->regmap, COMMS_REG_RIT_OFF, COMMS_RECEIVE_THRESHOLD);
+	/* Enable RIT interrupt */
+	regmap_write(ccdev->regmap, COMMS_REG_IE_OFF, COMMS_IRQ_RECEIVE_ENABLE);
+
+	/* Create and schedule timer to do recurring work */
+	INIT_WORK(&ccdev->work, &comms_check_request);
+	timer_setup(&ccdev->timer, &comms_sched_work, 0);
+	mod_timer(&ccdev->timer, jiffies + COMMS_TIMER);
+}
+
+void vmgmtm_comms_fini(struct comms_device *ccdev)
+{
+	/* First stop scheduling new work then cancel work */
+	del_timer_sync(&ccdev->timer);
+	cancel_work_sync(&ccdev->work);
+}
+
+struct comms_device *vmgmtm_comms_init(struct vmgmt_device *vdev)
+{
+	struct comms_device *ccdev;
+
+	ccdev = devm_kzalloc(&vdev->pdev->dev, sizeof(*ccdev), GFP_KERNEL);
+	if (!ccdev)
+		return ERR_PTR(-ENOMEM);
+
+	ccdev->vdev = vdev;
+
+	ccdev->regmap = devm_regmap_init_mmio(&vdev->pdev->dev,
+					      vdev->tbl + COMMS_PCI_BAR_OFF,
+					      &comms_regmap_config);
+	if (IS_ERR(ccdev->regmap)) {
+		vmgmt_err(vdev, "Comms regmap init failed");
+		return ERR_CAST(ccdev->regmap);
+	}
+
+	comms_config(ccdev);
+	return ccdev;
+}
diff --git a/drivers/fpga/amd/vmgmt-comms.h b/drivers/fpga/amd/vmgmt-comms.h
new file mode 100644
index 000000000000..0afb14c8bd32
--- /dev/null
+++ b/drivers/fpga/amd/vmgmt-comms.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Driver for Versal PCIe device
+ *
+ * Copyright (C) 2024 Advanced Micro Devices, Inc. All rights reserved.
+ */
+
+#ifndef __VMGMT_COMMS_H
+#define __VMGMT_COMMS_H
+
+struct comms_device *vmgmtm_comms_init(struct vmgmt_device *vdev);
+void vmgmtm_comms_fini(struct comms_device *ccdev);
+
+#endif	/* __VMGMT_COMMS_H */
diff --git a/drivers/fpga/amd/vmgmt.c b/drivers/fpga/amd/vmgmt.c
new file mode 100644
index 000000000000..b72eff9e8bc0
--- /dev/null
+++ b/drivers/fpga/amd/vmgmt.c
@@ -0,0 +1,395 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for Versal PCIe device
+ *
+ * Copyright (C) 2024 Advanced Micro Devices, Inc. All rights reserved.
+ */
+
+#include <linux/cdev.h>
+#include <linux/device/class.h>
+#include <linux/err.h>
+#include <linux/firmware.h>
+#include <linux/fs.h>
+#include <linux/fpga/fpga-mgr.h>
+#include <linux/idr.h>
+#include <linux/kdev_t.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/types.h>
+#include <linux/uuid.h>
+#include <linux/vmgmt.h>
+
+#include "vmgmt.h"
+#include "vmgmt-comms.h"
+
+#define DRV_NAME			"amd-vmgmt"
+#define CLASS_NAME			DRV_NAME
+
+#define PCI_DEVICE_ID_V70PQ2		0x50B0
+#define VERSAL_XCLBIN_MAGIC_ID		"xclbin2"
+
+static DEFINE_IDA(vmgmt_dev_minor_ida);
+static dev_t vmgmt_devnode;
+struct class *vmgmt_class;
+static struct fpga_bridge_ops vmgmt_br_ops;
+
+struct vmgmt_fpga_region {
+	struct fpga_device *fdev;
+	uuid_t *uuid;
+};
+
+static inline struct vmgmt_device *vmgmt_inode_to_vdev(struct inode *inode)
+{
+	return (struct vmgmt_device *)container_of(inode->i_cdev, struct vmgmt_device, cdev);
+}
+
+static enum fpga_mgr_states vmgmt_fpga_state(struct fpga_manager *mgr)
+{
+	struct fpga_device *fdev = mgr->priv;
+
+	return fdev->state;
+}
+
+static const struct fpga_manager_ops vmgmt_fpga_ops = {
+	.state = vmgmt_fpga_state,
+};
+
+static int vmgmt_get_bridges(struct fpga_region *region)
+{
+	struct fpga_device *fdev = region->priv;
+
+	return fpga_bridge_get_to_list(&fdev->vdev->pdev->dev, region->info,
+				       &region->bridge_list);
+}
+
+static void vmgmt_fpga_fini(struct fpga_device *fdev)
+{
+	fpga_region_unregister(fdev->region);
+	fpga_bridge_unregister(fdev->bridge);
+	fpga_mgr_unregister(fdev->mgr);
+}
+
+static struct fpga_device *vmgmt_fpga_init(struct vmgmt_device *vdev)
+{
+	struct device *dev = &vdev->pdev->dev;
+	struct fpga_region_info region = { 0 };
+	struct fpga_manager_info info = { 0 };
+	struct fpga_device *fdev;
+	int ret;
+
+	fdev = devm_kzalloc(dev, sizeof(*fdev), GFP_KERNEL);
+	if (!fdev)
+		return ERR_PTR(-ENOMEM);
+
+	fdev->vdev = vdev;
+
+	info = (struct fpga_manager_info) {
+		.name = "AMD Versal FPGA Manager",
+		.mops = &vmgmt_fpga_ops,
+		.priv = fdev,
+	};
+
+	fdev->mgr = fpga_mgr_register_full(dev, &info);
+	if (IS_ERR(fdev->mgr)) {
+		ret = PTR_ERR(fdev->mgr);
+		vmgmt_err(vdev, "Failed to register FPGA manager, err %d", ret);
+		return ERR_PTR(ret);
+	}
+
+	/* create fgpa bridge, region for the base shell */
+	fdev->bridge = fpga_bridge_register(dev, "AMD Versal FPGA Bridge",
+					    &vmgmt_br_ops, fdev);
+	if (IS_ERR(fdev->bridge)) {
+		vmgmt_err(vdev, "Failed to register FPGA bridge, err %ld",
+			  PTR_ERR(fdev->bridge));
+		ret = PTR_ERR(fdev->bridge);
+		goto unregister_fpga_mgr;
+	}
+
+	region = (struct fpga_region_info) {
+		.compat_id = (struct fpga_compat_id *)&vdev->intf_uuid,
+		.get_bridges = vmgmt_get_bridges,
+		.mgr = fdev->mgr,
+		.priv = fdev,
+	};
+
+	fdev->region = fpga_region_register_full(dev, &region);
+	if (IS_ERR(fdev->region)) {
+		vmgmt_err(vdev, "Failed to register FPGA region, err %ld",
+			  PTR_ERR(fdev->region));
+		ret = PTR_ERR(fdev->region);
+		goto unregister_fpga_bridge;
+	}
+
+	return fdev;
+
+unregister_fpga_bridge:
+	fpga_bridge_unregister(fdev->bridge);
+
+unregister_fpga_mgr:
+	fpga_mgr_unregister(fdev->mgr);
+
+	return ERR_PTR(ret);
+}
+
+static int vmgmt_open(struct inode *inode, struct file *filep)
+{
+	struct vmgmt_device *vdev = vmgmt_inode_to_vdev(inode);
+
+	if (WARN_ON(!vdev))
+		return -ENODEV;
+
+	filep->private_data = vdev;
+
+	return 0;
+}
+
+static int vmgmt_release(struct inode *inode, struct file *filep)
+{
+	filep->private_data = NULL;
+
+	return 0;
+}
+
+static const struct file_operations vmgmt_fops = {
+	.owner = THIS_MODULE,
+	.open = vmgmt_open,
+	.release = vmgmt_release,
+};
+
+static void vmgmt_chrdev_destroy(struct vmgmt_device *vdev)
+{
+	device_destroy(vmgmt_class, vdev->cdev.dev);
+	cdev_del(&vdev->cdev);
+	ida_free(&vmgmt_dev_minor_ida, vdev->minor);
+}
+
+static int vmgmt_chrdev_create(struct vmgmt_device *vdev)
+{
+	u32 devid;
+	int ret;
+
+	vdev->minor = ida_alloc(&vmgmt_dev_minor_ida, GFP_KERNEL);
+	if (vdev->minor < 0) {
+		vmgmt_err(vdev, "Failed to allocate chrdev ID");
+		return -ENODEV;
+	}
+
+	cdev_init(&vdev->cdev, &vmgmt_fops);
+
+	vdev->cdev.owner = THIS_MODULE;
+	vdev->cdev.dev = MKDEV(MAJOR(vmgmt_devnode), vdev->minor);
+	ret = cdev_add(&vdev->cdev, vdev->cdev.dev, 1);
+	if (ret) {
+		vmgmt_err(vdev, "Failed to add char device: %d\n", ret);
+		ida_free(&vmgmt_dev_minor_ida, vdev->minor);
+		return -ENODEV;
+	}
+
+	devid = PCI_DEVID(vdev->pdev->bus->number, vdev->pdev->devfn);
+	vdev->device = device_create(vmgmt_class, &vdev->pdev->dev,
+				     vdev->cdev.dev, NULL, "%s%x", DRV_NAME,
+				     devid);
+	if (IS_ERR(vdev->device)) {
+		vmgmt_err(vdev, "Failed to create device: %ld\n",
+			  PTR_ERR(vdev->device));
+		cdev_del(&vdev->cdev);
+		ida_free(&vmgmt_dev_minor_ida, vdev->minor);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static void vmgmt_fw_cancel(struct fw_upload *fw_upload)
+{
+	struct firmware_device *fwdev = fw_upload->dd_handle;
+
+	vmgmt_warn(fwdev->vdev, "canceled");
+}
+
+static const struct fw_upload_ops vmgmt_fw_ops = {
+	.cancel = vmgmt_fw_cancel,
+};
+
+static void vmgmt_fw_upload_fini(struct firmware_device *fwdev)
+{
+	firmware_upload_unregister(fwdev->fw);
+	kfree(fwdev->name);
+}
+
+static struct firmware_device *vmgmt_fw_upload_init(struct vmgmt_device *vdev)
+{
+	struct device *dev = &vdev->pdev->dev;
+	struct firmware_device *fwdev;
+	u32 devid;
+
+	fwdev = devm_kzalloc(dev, sizeof(*fwdev), GFP_KERNEL);
+	if (!fwdev)
+		return ERR_PTR(-ENOMEM);
+
+	devid = PCI_DEVID(vdev->pdev->bus->number, vdev->pdev->devfn);
+	fwdev->name = kasprintf(GFP_KERNEL, "%s%x", DRV_NAME, devid);
+	if (!fwdev->name)
+		return ERR_PTR(-ENOMEM);
+
+	fwdev->fw = firmware_upload_register(THIS_MODULE, dev, fwdev->name,
+					     &vmgmt_fw_ops, fwdev);
+	if (IS_ERR(fwdev->fw)) {
+		kfree(fwdev->name);
+		return ERR_CAST(fwdev->fw);
+	}
+
+	fwdev->vdev = vdev;
+
+	return fwdev;
+}
+
+static void vmgmt_device_teardown(struct vmgmt_device *vdev)
+{
+	vmgmt_fpga_fini(vdev->fdev);
+	vmgmt_fw_upload_fini(vdev->fwdev);
+	vmgmtm_comms_fini(vdev->ccdev);
+}
+
+static int vmgmt_device_setup(struct vmgmt_device *vdev)
+{
+	int ret;
+
+	vdev->fwdev = vmgmt_fw_upload_init(vdev);
+	if (IS_ERR(vdev->fwdev)) {
+		ret = PTR_ERR(vdev->fwdev);
+		vmgmt_err(vdev, "Failed to init FW uploader, err %d", ret);
+		goto done;
+	}
+
+	vdev->ccdev = vmgmtm_comms_init(vdev);
+	if (IS_ERR(vdev->ccdev)) {
+		ret = PTR_ERR(vdev->ccdev);
+		vmgmt_err(vdev, "Failed to init comms channel, err %d", ret);
+		goto upload_fini;
+	}
+
+	vdev->fdev = vmgmt_fpga_init(vdev);
+	if (IS_ERR(vdev->fdev)) {
+		ret = PTR_ERR(vdev->fdev);
+		vmgmt_err(vdev, "Failed to init FPGA maanger, err %d", ret);
+		goto comms_fini;
+	}
+
+	return 0;
+comms_fini:
+	vmgmtm_comms_fini(vdev->ccdev);
+upload_fini:
+	vmgmt_fw_upload_fini(vdev->fwdev);
+done:
+	return ret;
+}
+
+static void vmgmt_remove(struct pci_dev *pdev)
+{
+	struct vmgmt_device *vdev = pci_get_drvdata(pdev);
+
+	vmgmt_chrdev_destroy(vdev);
+	vmgmt_device_teardown(vdev);
+}
+
+static int vmgmt_probe(struct pci_dev *pdev,
+		       const struct pci_device_id *pdev_id)
+{
+	struct vmgmt_device *vdev;
+	int ret;
+
+	vdev = devm_kzalloc(&pdev->dev, sizeof(*vdev), GFP_KERNEL);
+	if (!vdev)
+		return -ENOMEM;
+
+	pci_set_drvdata(pdev, vdev);
+	vdev->pdev = pdev;
+
+	ret = pcim_enable_device(pdev);
+	if (ret) {
+		vmgmt_err(vdev, "Failed to enable device %d", ret);
+		return ret;
+	}
+
+	ret = pcim_iomap_regions(vdev->pdev, AMD_VMGMT_BAR_MASK, "amd-vmgmt");
+	if (ret) {
+		vmgmt_err(vdev, "Failed iomap regions %d", ret);
+		return -ENOMEM;
+	}
+
+	vdev->tbl = pcim_iomap_table(vdev->pdev)[AMD_VMGMT_BAR];
+	if (IS_ERR(vdev->tbl)) {
+		vmgmt_err(vdev, "Failed to map RM shared memory BAR%d", AMD_VMGMT_BAR);
+		return -ENOMEM;
+	}
+
+	ret = vmgmt_device_setup(vdev);
+	if (ret) {
+		vmgmt_err(vdev, "Failed to setup Versal device %d", ret);
+		return ret;
+	}
+
+	ret = vmgmt_chrdev_create(vdev);
+	if (ret) {
+		vmgmt_device_teardown(vdev);
+		return ret;
+	}
+
+	vmgmt_dbg(vdev, "Successfully probed %s driver!", DRV_NAME);
+	return 0;
+}
+
+static const struct pci_device_id vmgmt_pci_ids[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_XILINX, PCI_DEVICE_ID_V70PQ2), },
+	{ 0 }
+};
+
+MODULE_DEVICE_TABLE(pci, vmgmt_pci_ids);
+
+static struct pci_driver amd_vmgmt_driver = {
+	.name = DRV_NAME,
+	.id_table = vmgmt_pci_ids,
+	.probe = vmgmt_probe,
+	.remove = vmgmt_remove,
+};
+
+static int amd_vmgmt_init(void)
+{
+	int ret;
+
+	vmgmt_class = class_create(CLASS_NAME);
+	if (IS_ERR(vmgmt_class))
+		return PTR_ERR(vmgmt_class);
+
+	ret = alloc_chrdev_region(&vmgmt_devnode, 0, MINORMASK, DRV_NAME);
+	if (ret)
+		goto chr_err;
+
+	ret = pci_register_driver(&amd_vmgmt_driver);
+	if (ret)
+		goto pci_err;
+
+	return 0;
+
+pci_err:
+	unregister_chrdev_region(vmgmt_devnode, MINORMASK);
+chr_err:
+	class_destroy(vmgmt_class);
+	return ret;
+}
+
+static void amd_vmgmt_exit(void)
+{
+	pci_unregister_driver(&amd_vmgmt_driver);
+	unregister_chrdev_region(vmgmt_devnode, MINORMASK);
+	class_destroy(vmgmt_class);
+}
+
+module_init(amd_vmgmt_init);
+module_exit(amd_vmgmt_exit);
+
+MODULE_DESCRIPTION("AMD PCIe Versal Management Driver");
+MODULE_AUTHOR("XRT Team <runtimeca39d@amd.com>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/fpga/amd/vmgmt.h b/drivers/fpga/amd/vmgmt.h
new file mode 100644
index 000000000000..4dc8a43f825e
--- /dev/null
+++ b/drivers/fpga/amd/vmgmt.h
@@ -0,0 +1,100 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Driver for Versal PCIe device
+ *
+ * Copyright (C) 2024 Advanced Micro Devices, Inc. All rights reserved.
+ */
+
+#ifndef __VMGMT_H
+#define __VMGMT_H
+
+#include <linux/cdev.h>
+#include <linux/dev_printk.h>
+#include <linux/jiffies.h>
+#include <linux/list.h>
+#include <linux/firmware.h>
+#include <linux/fpga/fpga-bridge.h>
+#include <linux/fpga/fpga-mgr.h>
+#include <linux/fpga/fpga-region.h>
+#include <linux/pci.h>
+#include <linux/uuid.h>
+#include <linux/regmap.h>
+
+#define AMD_VMGMT_BAR			0
+#define AMD_VMGMT_BAR_MASK		BIT(0)
+
+#define vmgmt_info(vdev, fmt, args...)					\
+	dev_info(&(vdev)->pdev->dev, "%s: "fmt, __func__, ##args)
+
+#define vmgmt_warn(vdev, fmt, args...)					\
+	dev_warn(&(vdev)->pdev->dev, "%s: "fmt, __func__, ##args)
+
+#define vmgmt_err(vdev, fmt, args...)					\
+	dev_err(&(vdev)->pdev->dev, "%s: "fmt, __func__, ##args)
+
+#define vmgmt_dbg(vdev, fmt, args...)					\
+	dev_dbg(&(vdev)->pdev->dev, fmt, ##args)
+
+struct vmgmt_device;
+struct comms_device;
+struct rm_cmd;
+
+struct axlf_header {
+	u64				length;
+	unsigned char			reserved1[24];
+	uuid_t				rom_uuid;
+	unsigned char			reserved2[64];
+	uuid_t				uuid;
+	unsigned char			reserved3[24];
+} __packed;
+
+struct axlf {
+	char				magic[8];
+	unsigned char			reserved[296];
+	struct axlf_header		header;
+} __packed;
+
+struct fw_tnx {
+	struct rm_cmd		*cmd;
+	int			opcode;
+	int			id;
+};
+
+struct fpga_device {
+	enum fpga_mgr_states	state;
+	struct fpga_manager	*mgr;
+	struct fpga_bridge	*bridge;
+	struct fpga_region	*region;
+	struct vmgmt_device	*vdev;
+	struct fw_tnx		fw;
+};
+
+struct firmware_device {
+	struct vmgmt_device	*vdev;
+	struct fw_upload	*fw;
+	char			*name;
+	u32			fw_name_id;
+	struct rm_cmd		*cmd;
+	int			id;
+	uuid_t			uuid;
+};
+
+struct vmgmt_device {
+	struct pci_dev		*pdev;
+
+	struct rm_device	*rdev;
+	struct comms_device	*ccdev;
+	struct fpga_device	*fdev;
+	struct firmware_device	*fwdev;
+	struct cdev		cdev;
+	struct device		*device;
+
+	int                     minor;
+	void __iomem		*tbl;
+	uuid_t			xclbin_uuid;
+	uuid_t			intf_uuid;
+
+	void                    *debugfs_root;
+};
+
+#endif	/* __VMGMT_H */
diff --git a/include/uapi/linux/vmgmt.h b/include/uapi/linux/vmgmt.h
new file mode 100644
index 000000000000..2269ceb5c131
--- /dev/null
+++ b/include/uapi/linux/vmgmt.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Header file for Versal PCIe device user API
+ *
+ * Copyright (C) 2024 AMD Corporation, Inc.
+ */
+
+#ifndef _UAPI_LINUX_VMGMT_H
+#define _UAPI_LINUX_VMGMT_H
+
+#include <linux/ioctl.h>
+
+#define VERSAL_MGMT_MAGIC	0xB7
+#define VERSAL_MGMT_BASE	0
+
+/**
+ * VERSAL_MGMT_LOAD_XCLBIN_IOCTL - Download XCLBIN to the device
+ *
+ * This IOCTL is used to download XCLBIN down to the device.
+ * Return: 0 on success, -errno on failure.
+ */
+#define VERSAL_MGMT_LOAD_XCLBIN_IOCTL	_IOW(VERSAL_MGMT_MAGIC,		\
+					     VERSAL_MGMT_BASE + 0, void *)
+
+#endif /* _UAPI_LINUX_VMGMT_H */
-- 
2.34.1



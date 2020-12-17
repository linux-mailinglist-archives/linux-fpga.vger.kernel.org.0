Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19B642DCD36
	for <lists+linux-fpga@lfdr.de>; Thu, 17 Dec 2020 08:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbgLQHyb (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 17 Dec 2020 02:54:31 -0500
Received: from mail-co1nam11on2077.outbound.protection.outlook.com ([40.107.220.77]:37856
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726703AbgLQHya (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 17 Dec 2020 02:54:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YFxXGpYBsfwtDvS5CzvUwlJxWvJFmI34xEko69c8nJ2QmqwU5a6ztrhFqTu1d/4etk7fDiTSSJ9+IozLZDrISlYnqvhIIkuY/VGGsKU+qdVkqjPGrTrfCzw+qLdOChNpbOLhgm1QdAu+RbLyEMwE8mIBH2jlDyVzBtgNjp7WGNV+zANev4Z9kmxyyTJOxQlSIimNC9k9WOaWGE8jX7+9P6JuIvWvnBeyUzv3dXE4CeinngoIoS4jfPr7zktfhsL7Vj6tO5OW8vRTjLlRCtmbsd980HcsRqHjuSk1PA4sh8TQXs6y6k2VFyzJMz79GEo6qqr7KpO+hUMkkxsJ3U53nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jLxEA5X9bHusuJnL1zDuaEwAgoVMIEBcp6bh/vVJipE=;
 b=Gf/dcPYhg2pNMPmHzj9xHJnVokVZ8Ttu819uZPb4oZoLJjE377ipgxG/64/NPq2MLq0ZjWWKwgJTL5rrk0Z+bBBegdMuWMC8H0LcWVfw9nRquYUGFWh2MnL9s9RFOAdUoDcMv9vW7kTFLeAlxAIBNZksFtClyojlM2p0Njs+zDoXP/qNGEWBdSY+qduTMrDh8xWpAaOVuHkvCHYzbb6RdmdYCyuThRM8gUT8a7yCfOGsqaEfw35U/8RsIsmeN8BpPzVwhpK4XhllJl/LTamjM/DqF5Olq/gnhrDLpQQ/fwiWdScWNm9AEAiVkefQci9rFfPL7Uvp8+xtDHESfEWYmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jLxEA5X9bHusuJnL1zDuaEwAgoVMIEBcp6bh/vVJipE=;
 b=j2hENWKGaQPbQ9tGBfIp+poKwEMma1qmCFZ/11wKRbnTGwseueCPtiGqrohWxYCnh5mBie7mCP0qpI5vNQf6hMBYuJjJuvp+YPjE71ZcNKW7oRjaRgaH/2D7wcu7gs4+I2h3LDNz7VPfpqzzooN1v58JVGibav3hu3nGMb3WjGo=
Received: from DM5PR17CA0071.namprd17.prod.outlook.com (2603:10b6:3:13f::33)
 by BYAPR02MB3992.namprd02.prod.outlook.com (2603:10b6:a02:f3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.25; Thu, 17 Dec
 2020 07:53:28 +0000
Received: from CY1NAM02FT005.eop-nam02.prod.protection.outlook.com
 (2603:10b6:3:13f:cafe::ca) by DM5PR17CA0071.outlook.office365.com
 (2603:10b6:3:13f::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend
 Transport; Thu, 17 Dec 2020 07:53:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 CY1NAM02FT005.mail.protection.outlook.com (10.152.74.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3654.12 via Frontend Transport; Thu, 17 Dec 2020 07:53:27 +0000
Received: from xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Wed, 16 Dec 2020 23:53:27 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Wed, 16 Dec 2020 23:53:27 -0800
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
Received: from [172.19.72.212] (port=42046 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <sonal.santan@xilinx.com>)
        id 1kpo6J-0004dz-4q; Wed, 16 Dec 2020 23:53:27 -0800
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 6354)
        id 474BE600117; Wed, 16 Dec 2020 23:51:24 -0800 (PST)
From:   Sonal Santan <sonal.santan@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Sonal Santan <sonal.santan@xilinx.com>,
        <linux-fpga@vger.kernel.org>, <maxz@xilinx.com>,
        <lizhih@xilinx.com>, <michal.simek@xilinx.com>,
        <stefanos@xilinx.com>, <devicetree@vger.kernel.org>,
        <trix@redhat.com>, <mdf@kernel.org>
Subject: [PATCH V2 XRT Alveo 5/6] fpga: xrt: platform drivers for subsystems in shell partition
Date:   Wed, 16 Dec 2020 23:50:45 -0800
Message-ID: <20201217075046.28553-6-sonals@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201217075046.28553-1-sonals@xilinx.com>
References: <20201217075046.28553-1-sonals@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a65f507a-a0c3-4e85-7f4e-08d8a260d700
X-MS-TrafficTypeDiagnostic: BYAPR02MB3992:
X-Microsoft-Antispam-PRVS: <BYAPR02MB399289A3A1BD760C46B2A3B8BBC40@BYAPR02MB3992.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xsUv6PQkz1cUv8HSWUBLlPROn7STV5iVCRMYWeMnJ1uYPORz9kKkdyg88tc6+rPyxAgq217oHPZr2bbIo2jJ/xoXf9ZX/YpLMLyQzmyn6Jq3sj9kxdx97oAWBgGSmZ0cIN0V+AQv9oAv1CyEGHtqqdpUYYO5mwk2OOjRNp5ptd5zg72YbrO4Mmkjha3X1yIuQ+FsWQcABn8U7/wb3J+VUWL43jKffQ/5XoWDyJhrHhKCEFetqZnPEK37dG7er5pzgFDKOSWZfDaYwaGiOmOoKMwbr3yr6L4+OwUn8Z4UdEg2CZZadtjJLfVm/p9OLMDmHVNR5Y2V3aTw/toz9Koo79lbVxn28wF/dPTim5/eQB5AfqeRQtI8Nk8+2qcixYlSx2lGs4lMR9WXwhfuX/1j6xJXlTtzVpQ2ywUcc4cdeAtiGfxltuNOhVS8sKebcEl9xLsMVMx5gm7d2HBWdjX2Qg==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(136003)(396003)(46966005)(8936002)(6666004)(47076004)(186003)(6266002)(478600001)(82740400003)(54906003)(70206006)(82310400003)(30864003)(70586007)(2906002)(426003)(44832011)(316002)(26005)(1076003)(4326008)(2616005)(356005)(36756003)(8676002)(5660300002)(83380400001)(7636003)(42186006)(336012)(6916009)(579004)(559001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2020 07:53:27.9919
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a65f507a-a0c3-4e85-7f4e-08d8a260d700
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT005.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB3992
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Sonal Santan <sonal.santan@xilinx.com>

Add platform drivers for HW subsystems found in shell partition.
Each driver implements interfaces defined by xrt-subdev.h. The
driver instances are created by parent partition to manage
subsystem instances discovered by walking device tree. The
platform drivers may populate their own sysfs nodes, create
device nodes if needed and make calls into parent or other
platform drivers. The platform drivers can also send and receive
events.

Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
---
 drivers/fpga/xrt/include/subdev/axigate.h  |  31 +
 drivers/fpga/xrt/include/subdev/calib.h    |  28 +
 drivers/fpga/xrt/include/subdev/clkfreq.h  |  21 +
 drivers/fpga/xrt/include/subdev/clock.h    |  29 +
 drivers/fpga/xrt/include/subdev/gpio.h     |  41 ++
 drivers/fpga/xrt/include/subdev/icap.h     |  27 +
 drivers/fpga/xrt/include/subdev/ucs.h      |  22 +
 drivers/fpga/xrt/lib/subdevs/xrt-axigate.c | 298 ++++++++++
 drivers/fpga/xrt/lib/subdevs/xrt-calib.c   | 226 ++++++++
 drivers/fpga/xrt/lib/subdevs/xrt-clkfreq.c | 214 +++++++
 drivers/fpga/xrt/lib/subdevs/xrt-clock.c   | 638 +++++++++++++++++++++
 drivers/fpga/xrt/lib/subdevs/xrt-gpio.c    | 198 +++++++
 drivers/fpga/xrt/lib/subdevs/xrt-icap.c    | 306 ++++++++++
 drivers/fpga/xrt/lib/subdevs/xrt-ucs.c     | 238 ++++++++
 drivers/fpga/xrt/lib/subdevs/xrt-vsec.c    | 337 +++++++++++
 15 files changed, 2654 insertions(+)
 create mode 100644 drivers/fpga/xrt/include/subdev/axigate.h
 create mode 100644 drivers/fpga/xrt/include/subdev/calib.h
 create mode 100644 drivers/fpga/xrt/include/subdev/clkfreq.h
 create mode 100644 drivers/fpga/xrt/include/subdev/clock.h
 create mode 100644 drivers/fpga/xrt/include/subdev/gpio.h
 create mode 100644 drivers/fpga/xrt/include/subdev/icap.h
 create mode 100644 drivers/fpga/xrt/include/subdev/ucs.h
 create mode 100644 drivers/fpga/xrt/lib/subdevs/xrt-axigate.c
 create mode 100644 drivers/fpga/xrt/lib/subdevs/xrt-calib.c
 create mode 100644 drivers/fpga/xrt/lib/subdevs/xrt-clkfreq.c
 create mode 100644 drivers/fpga/xrt/lib/subdevs/xrt-clock.c
 create mode 100644 drivers/fpga/xrt/lib/subdevs/xrt-gpio.c
 create mode 100644 drivers/fpga/xrt/lib/subdevs/xrt-icap.c
 create mode 100644 drivers/fpga/xrt/lib/subdevs/xrt-ucs.c
 create mode 100644 drivers/fpga/xrt/lib/subdevs/xrt-vsec.c

diff --git a/drivers/fpga/xrt/include/subdev/axigate.h b/drivers/fpga/xrt/include/subdev/axigate.h
new file mode 100644
index 000000000000..d26f6d31a948
--- /dev/null
+++ b/drivers/fpga/xrt/include/subdev/axigate.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020 Xilinx, Inc.
+ *
+ * Authors:
+ *	Lizhi Hou <Lizhi.Hou@xilinx.com>
+ */
+
+#ifndef	_XRT_AXIGATE_H_
+#define	_XRT_AXIGATE_H_
+
+
+#include "subdev.h"
+#include "metadata.h"
+
+/*
+ * AXIGATE driver IOCTL calls.
+ */
+enum xrt_axigate_ioctl_cmd {
+	XRT_AXIGATE_FREEZE = 0,
+	XRT_AXIGATE_FREE,
+};
+
+/* the ep names are in the order of hardware layers */
+static const char * const xrt_axigate_epnames[] = {
+	NODE_GATE_PLP,
+	NODE_GATE_ULP,
+	NULL
+};
+
+#endif	/* _XRT_AXIGATE_H_ */
diff --git a/drivers/fpga/xrt/include/subdev/calib.h b/drivers/fpga/xrt/include/subdev/calib.h
new file mode 100644
index 000000000000..9328f28a83b0
--- /dev/null
+++ b/drivers/fpga/xrt/include/subdev/calib.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020 Xilinx, Inc.
+ *
+ * Authors:
+ *	Cheng Zhen <maxz@xilinx.com>
+ */
+
+#ifndef	_XRT_CALIB_H_
+#define	_XRT_CALIB_H_
+
+#include "subdev.h"
+#include <linux/xrt/xclbin.h>
+
+/*
+ * Memory calibration driver IOCTL calls.
+ */
+enum xrt_calib_results {
+	XRT_CALIB_UNKNOWN,
+	XRT_CALIB_SUCCEEDED,
+	XRT_CALIB_FAILED,
+};
+
+enum xrt_calib_ioctl_cmd {
+	XRT_CALIB_RESULT = 0,
+};
+
+#endif	/* _XRT_CALIB_H_ */
diff --git a/drivers/fpga/xrt/include/subdev/clkfreq.h b/drivers/fpga/xrt/include/subdev/clkfreq.h
new file mode 100644
index 000000000000..c4ed0e074510
--- /dev/null
+++ b/drivers/fpga/xrt/include/subdev/clkfreq.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020 Xilinx, Inc.
+ *
+ * Authors:
+ *	Lizhi Hou <Lizhi.Hou@xilinx.com>
+ */
+
+#ifndef	_XRT_CLKFREQ_H_
+#define	_XRT_CLKFREQ_H_
+
+#include "subdev.h"
+
+/*
+ * CLKFREQ driver IOCTL calls.
+ */
+enum xrt_clkfreq_ioctl_cmd {
+	XRT_CLKFREQ_READ = 0,
+};
+
+#endif	/* _XRT_CLKFREQ_H_ */
diff --git a/drivers/fpga/xrt/include/subdev/clock.h b/drivers/fpga/xrt/include/subdev/clock.h
new file mode 100644
index 000000000000..8f0b8954dcdb
--- /dev/null
+++ b/drivers/fpga/xrt/include/subdev/clock.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020 Xilinx, Inc.
+ *
+ * Authors:
+ *	Lizhi Hou <Lizhi.Hou@xilinx.com>
+ */
+
+#ifndef	_XRT_CLOCK_H_
+#define	_XRT_CLOCK_H_
+
+#include "subdev.h"
+#include <linux/xrt/xclbin.h>
+
+/*
+ * CLOCK driver IOCTL calls.
+ */
+enum xrt_clock_ioctl_cmd {
+	XRT_CLOCK_SET = 0,
+	XRT_CLOCK_GET,
+	XRT_CLOCK_VERIFY,
+};
+
+struct xrt_clock_ioctl_get {
+	u16 freq;
+	u32 freq_cnter;
+};
+
+#endif	/* _XRT_CLOCK_H_ */
diff --git a/drivers/fpga/xrt/include/subdev/gpio.h b/drivers/fpga/xrt/include/subdev/gpio.h
new file mode 100644
index 000000000000..bb965ee1940c
--- /dev/null
+++ b/drivers/fpga/xrt/include/subdev/gpio.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020 Xilinx, Inc.
+ *
+ * Authors:
+ *	Lizhi Hou <Lizhi.Hou@xilinx.com>
+ */
+
+#ifndef	_XRT_GPIO_H_
+#define	_XRT_GPIO_H_
+
+#include "subdev.h"
+
+/*
+ * GPIO driver IOCTL calls.
+ */
+enum xrt_gpio_ioctl_cmd {
+	XRT_GPIO_READ = 0,
+	XRT_GPIO_WRITE,
+};
+
+enum xrt_gpio_id {
+	XRT_GPIO_ROM_UUID,
+	XRT_GPIO_DDR_CALIB,
+	XRT_GPIO_GOLDEN_VER,
+	XRT_GPIO_MAX
+};
+
+struct xrt_gpio_ioctl_rw {
+	u32	xgir_id;
+	void	*xgir_buf;
+	u32	xgir_len;
+	u32	xgir_offset;
+};
+
+struct xrt_gpio_ioctl_intf_uuid {
+	u32	xgir_uuid_num;
+	uuid_t	*xgir_uuids;
+};
+
+#endif	/* _XRT_GPIO_H_ */
diff --git a/drivers/fpga/xrt/include/subdev/icap.h b/drivers/fpga/xrt/include/subdev/icap.h
new file mode 100644
index 000000000000..8424743d3280
--- /dev/null
+++ b/drivers/fpga/xrt/include/subdev/icap.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020 Xilinx, Inc.
+ *
+ * Authors:
+ *	Lizhi Hou <Lizhi.Hou@xilinx.com>
+ */
+
+#ifndef	_XRT_ICAP_H_
+#define	_XRT_ICAP_H_
+
+#include "subdev.h"
+
+/*
+ * ICAP driver IOCTL calls.
+ */
+enum xrt_icap_ioctl_cmd {
+	XRT_ICAP_WRITE = 0,
+	XRT_ICAP_IDCODE,
+};
+
+struct xrt_icap_ioctl_wr {
+	void	*xiiw_bit_data;
+	u32	xiiw_data_len;
+};
+
+#endif	/* _XRT_ICAP_H_ */
diff --git a/drivers/fpga/xrt/include/subdev/ucs.h b/drivers/fpga/xrt/include/subdev/ucs.h
new file mode 100644
index 000000000000..e0ae697b69da
--- /dev/null
+++ b/drivers/fpga/xrt/include/subdev/ucs.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020 Xilinx, Inc.
+ *
+ * Authors:
+ *	Lizhi Hou <Lizhi.Hou@xilinx.com>
+ */
+
+#ifndef	_XRT_UCS_H_
+#define	_XRT_UCS_H_
+
+#include "subdev.h"
+
+/*
+ * UCS driver IOCTL calls.
+ */
+enum xrt_ucs_ioctl_cmd {
+	XRT_UCS_CHECK = 0,
+	XRT_UCS_ENABLE,
+};
+
+#endif	/* _XRT_UCS_H_ */
diff --git a/drivers/fpga/xrt/lib/subdevs/xrt-axigate.c b/drivers/fpga/xrt/lib/subdevs/xrt-axigate.c
new file mode 100644
index 000000000000..27dabf388220
--- /dev/null
+++ b/drivers/fpga/xrt/lib/subdevs/xrt-axigate.c
@@ -0,0 +1,298 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx Alveo FPGA AXI Gate Driver
+ *
+ * Copyright (C) 2020 Xilinx, Inc.
+ *
+ * Authors:
+ *      Lizhi Hou<Lizhi.Hou@xilinx.com>
+ */
+
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/io.h>
+#include "metadata.h"
+#include "subdev.h"
+#include "parent.h"
+#include "subdev/axigate.h"
+
+#define XRT_AXIGATE "xrt_axigate"
+
+struct axigate_regs {
+	u32		iag_wr;
+	u32		iag_rvsd;
+	u32		iag_rd;
+} __packed;
+
+struct xrt_axigate {
+	struct platform_device	*pdev;
+	void			*base;
+	struct mutex		gate_lock;
+
+	void			*evt_hdl;
+	const char		*ep_name;
+
+	bool			gate_freezed;
+};
+
+#define reg_rd(g, r)						\
+	ioread32(&((struct axigate_regs *)g->base)->r)
+#define reg_wr(g, v, r)						\
+	iowrite32(v, &((struct axigate_regs *)g->base)->r)
+
+#define freeze_gate(gate)			\
+	do {					\
+		reg_wr(gate, 0, iag_wr);	\
+		ndelay(500);			\
+		reg_rd(gate, iag_rd);		\
+	} while (0)
+
+#define free_gate(gate)				\
+	do {					\
+		reg_wr(gate, 0x2, iag_wr);	\
+		ndelay(500);			\
+		(void) reg_rd(gate, iag_rd);	\
+		reg_wr(gate, 0x3, iag_wr);	\
+		ndelay(500);			\
+		reg_rd(gate, iag_rd);		\
+	} while (0)				\
+
+static int xrt_axigate_epname_idx(struct platform_device *pdev)
+{
+	int			i;
+	int			ret;
+	struct resource		*res;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		xrt_err(pdev, "Empty Resource!");
+		return -EINVAL;
+	}
+
+	for (i = 0; xrt_axigate_epnames[i]; i++) {
+		ret = strncmp(xrt_axigate_epnames[i], res->name,
+			strlen(xrt_axigate_epnames[i]) + 1);
+		if (!ret)
+			break;
+	}
+
+	return (xrt_axigate_epnames[i]) ? i : -EINVAL;
+}
+
+static bool xrt_axigate_leaf_match(enum xrt_subdev_id id,
+	struct platform_device *pdev, void *arg)
+{
+	const char		*ep_name = arg;
+	struct resource		*res;
+
+	if (id != XRT_SUBDEV_AXIGATE)
+		return false;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		xrt_err(pdev, "Empty Resource!");
+		return false;
+	}
+
+	if (strncmp(res->name, ep_name, strlen(res->name) + 1))
+		return true;
+
+	return false;
+}
+
+static void xrt_axigate_freeze(struct platform_device *pdev)
+{
+	struct xrt_axigate	*gate;
+	u32			freeze = 0;
+
+	gate = platform_get_drvdata(pdev);
+
+	mutex_lock(&gate->gate_lock);
+	freeze = reg_rd(gate, iag_rd);
+	if (freeze) {		/* gate is opened */
+		xrt_subdev_broadcast_event(pdev, XRT_EVENT_PRE_GATE_CLOSE);
+		freeze_gate(gate);
+	}
+
+	gate->gate_freezed = true;
+	mutex_unlock(&gate->gate_lock);
+
+	xrt_info(pdev, "freeze gate %s", gate->ep_name);
+}
+
+static void xrt_axigate_free(struct platform_device *pdev)
+{
+	struct xrt_axigate	*gate;
+	u32			freeze;
+
+	gate = platform_get_drvdata(pdev);
+
+	mutex_lock(&gate->gate_lock);
+	freeze = reg_rd(gate, iag_rd);
+	if (!freeze) {		/* gate is closed */
+		free_gate(gate);
+		xrt_subdev_broadcast_event_async(pdev,
+			XRT_EVENT_POST_GATE_OPEN, NULL, NULL);
+		/* xrt_axigate_free() could be called in event cb, thus
+		 * we can not wait for the completes
+		 */
+	}
+
+	gate->gate_freezed = false;
+	mutex_unlock(&gate->gate_lock);
+
+	xrt_info(pdev, "free gate %s", gate->ep_name);
+}
+
+static int
+xrt_axigate_event_cb(struct platform_device *pdev,
+	enum xrt_events evt, void *arg)
+{
+	struct platform_device *leaf;
+	struct xrt_event_arg_subdev *esd = (struct xrt_event_arg_subdev *)arg;
+	enum xrt_subdev_id id;
+	int instance;
+
+	switch (evt) {
+	case XRT_EVENT_POST_CREATION:
+		break;
+	default:
+		return XRT_EVENT_CB_CONTINUE;
+	}
+
+	id = esd->xevt_subdev_id;
+	instance = esd->xevt_subdev_instance;
+
+	/*
+	 * higher level axigate instance created,
+	 * make sure the gate is openned. This covers 1RP flow which
+	 * has plp gate as well.
+	 */
+	leaf = xrt_subdev_get_leaf_by_id(pdev, id, instance);
+	if (leaf) {
+		if (xrt_axigate_epname_idx(leaf) >
+		    xrt_axigate_epname_idx(pdev))
+			xrt_axigate_free(pdev);
+		else
+			xrt_subdev_ioctl(leaf, XRT_AXIGATE_FREE, NULL);
+		xrt_subdev_put_leaf(pdev, leaf);
+	}
+
+	return XRT_EVENT_CB_CONTINUE;
+}
+
+static int
+xrt_axigate_leaf_ioctl(struct platform_device *pdev, u32 cmd, void *arg)
+{
+	switch (cmd) {
+	case XRT_AXIGATE_FREEZE:
+		xrt_axigate_freeze(pdev);
+		break;
+	case XRT_AXIGATE_FREE:
+		xrt_axigate_free(pdev);
+		break;
+	default:
+		xrt_err(pdev, "unsupported cmd %d", cmd);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int xrt_axigate_remove(struct platform_device *pdev)
+{
+	struct xrt_axigate	*gate;
+
+	gate = platform_get_drvdata(pdev);
+
+	if (gate->base)
+		iounmap(gate->base);
+
+	platform_set_drvdata(pdev, NULL);
+	devm_kfree(&pdev->dev, gate);
+
+	return 0;
+}
+
+static int xrt_axigate_probe(struct platform_device *pdev)
+{
+	struct xrt_axigate	*gate;
+	struct resource		*res;
+	int			ret;
+
+	gate = devm_kzalloc(&pdev->dev, sizeof(*gate), GFP_KERNEL);
+	if (!gate)
+		return -ENOMEM;
+
+	gate->pdev = pdev;
+	platform_set_drvdata(pdev, gate);
+
+	xrt_info(pdev, "probing...");
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		xrt_err(pdev, "Empty resource 0");
+		ret = -EINVAL;
+		goto failed;
+	}
+
+	gate->base = ioremap(res->start, res->end - res->start + 1);
+	if (!gate->base) {
+		xrt_err(pdev, "map base iomem failed");
+		ret = -EFAULT;
+		goto failed;
+	}
+
+	gate->evt_hdl = xrt_subdev_add_event_cb(pdev,
+		xrt_axigate_leaf_match, (void *)res->name,
+		xrt_axigate_event_cb);
+
+	gate->ep_name = res->name;
+
+	mutex_init(&gate->gate_lock);
+
+	return 0;
+
+failed:
+	xrt_axigate_remove(pdev);
+	return ret;
+}
+
+struct xrt_subdev_endpoints xrt_axigate_endpoints[] = {
+	{
+		.xse_names = (struct xrt_subdev_ep_names[]) {
+			{ .ep_name = "ep_pr_isolate_ulp_00" },
+			{ NULL },
+		},
+		.xse_min_ep = 1,
+	},
+	{
+		.xse_names = (struct xrt_subdev_ep_names[]) {
+			{ .ep_name = "ep_pr_isolate_plp_00" },
+			{ NULL },
+		},
+		.xse_min_ep = 1,
+	},
+	{ 0 },
+};
+
+struct xrt_subdev_drvdata xrt_axigate_data = {
+	.xsd_dev_ops = {
+		.xsd_ioctl = xrt_axigate_leaf_ioctl,
+	},
+};
+
+static const struct platform_device_id xrt_axigate_table[] = {
+	{ XRT_AXIGATE, (kernel_ulong_t)&xrt_axigate_data },
+	{ },
+};
+
+struct platform_driver xrt_axigate_driver = {
+	.driver = {
+		.name = XRT_AXIGATE,
+	},
+	.probe = xrt_axigate_probe,
+	.remove = xrt_axigate_remove,
+	.id_table = xrt_axigate_table,
+};
diff --git a/drivers/fpga/xrt/lib/subdevs/xrt-calib.c b/drivers/fpga/xrt/lib/subdevs/xrt-calib.c
new file mode 100644
index 000000000000..6108f24a2023
--- /dev/null
+++ b/drivers/fpga/xrt/lib/subdevs/xrt-calib.c
@@ -0,0 +1,226 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx Alveo FPGA memory calibration driver
+ *
+ * Copyright (C) 2020 Xilinx, Inc.
+ *
+ * memory calibration
+ *
+ * Authors:
+ *      Lizhi Hou<Lizhi.Hou@xilinx.com>
+ */
+#include <linux/delay.h>
+#include "xrt-xclbin.h"
+#include "metadata.h"
+#include "subdev/calib.h"
+
+#define XRT_CALIB	"xrt_calib"
+
+struct calib_cache {
+	struct list_head	link;
+	const char		*ep_name;
+	char			*data;
+	uint32_t		data_size;
+};
+
+struct calib {
+	struct platform_device	*pdev;
+	void			*calib_base;
+	struct mutex		lock;
+	struct list_head	cache_list;
+	uint32_t		cache_num;
+	void			*evt_hdl;
+	enum xrt_calib_results	result;
+};
+
+#define CALIB_DONE(calib)			\
+	(ioread32(calib->calib_base) & BIT(0))
+
+static bool xrt_calib_leaf_match(enum xrt_subdev_id id,
+	struct platform_device *pdev, void *arg)
+{
+	if (id == XRT_SUBDEV_UCS || id == XRT_SUBDEV_SRSR)
+		return true;
+
+	return false;
+}
+
+static void calib_cache_clean_nolock(struct calib *calib)
+{
+	struct calib_cache *cache, *temp;
+
+	list_for_each_entry_safe(cache, temp, &calib->cache_list, link) {
+		vfree(cache->data);
+		list_del(&cache->link);
+		vfree(cache);
+	}
+	calib->cache_num = 0;
+}
+
+static void calib_cache_clean(struct calib *calib)
+{
+	mutex_lock(&calib->lock);
+	calib_cache_clean_nolock(calib);
+	mutex_unlock(&calib->lock);
+}
+
+static int calib_srsr(struct calib *calib, struct platform_device *srsr_leaf)
+{
+	return -ENOTSUPP;
+}
+
+static int calib_calibration(struct calib *calib)
+{
+	int i;
+
+	for (i = 0; i < 20; i++) {
+		if (CALIB_DONE(calib))
+			break;
+		msleep(500);
+	}
+
+	if (i == 20) {
+		xrt_err(calib->pdev,
+			"MIG calibration timeout after bitstream download");
+		return -ETIMEDOUT;
+	}
+
+	xrt_info(calib->pdev, "took %dms", i * 500);
+	return 0;
+}
+
+static int xrt_calib_event_cb(struct platform_device *pdev,
+	enum xrt_events evt, void *arg)
+{
+	struct calib *calib = platform_get_drvdata(pdev);
+	struct xrt_event_arg_subdev *esd = (struct xrt_event_arg_subdev *)arg;
+	struct platform_device *leaf;
+	int ret;
+
+	switch (evt) {
+	case XRT_EVENT_POST_CREATION: {
+		if (esd->xevt_subdev_id == XRT_SUBDEV_SRSR) {
+			leaf = xrt_subdev_get_leaf_by_id(pdev,
+				XRT_SUBDEV_SRSR, esd->xevt_subdev_instance);
+			BUG_ON(!leaf);
+			ret = calib_srsr(calib, leaf);
+			xrt_subdev_put_leaf(pdev, leaf);
+			calib->result =
+				ret ? XRT_CALIB_FAILED : XRT_CALIB_SUCCEEDED;
+		} else if (esd->xevt_subdev_id == XRT_SUBDEV_UCS) {
+			ret = calib_calibration(calib);
+			calib->result =
+				ret ? XRT_CALIB_FAILED : XRT_CALIB_SUCCEEDED;
+		}
+		break;
+	}
+	default:
+		xrt_info(pdev, "ignored event %d", evt);
+		break;
+	}
+
+	return XRT_EVENT_CB_CONTINUE;
+}
+
+int xrt_calib_remove(struct platform_device *pdev)
+{
+	struct calib *calib = platform_get_drvdata(pdev);
+
+	xrt_subdev_remove_event_cb(pdev, calib->evt_hdl);
+	calib_cache_clean(calib);
+
+	if (calib->calib_base)
+		iounmap(calib->calib_base);
+
+	platform_set_drvdata(pdev, NULL);
+	devm_kfree(&pdev->dev, calib);
+
+	return 0;
+}
+
+int xrt_calib_probe(struct platform_device *pdev)
+{
+	struct calib *calib;
+	struct resource *res;
+	int err = 0;
+
+	calib = devm_kzalloc(&pdev->dev, sizeof(*calib), GFP_KERNEL);
+	if (!calib)
+		return -ENOMEM;
+
+	calib->pdev = pdev;
+	platform_set_drvdata(pdev, calib);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		goto failed;
+
+	calib->calib_base = ioremap(res->start, res->end - res->start + 1);
+	if (!calib->calib_base) {
+		err = -EIO;
+		xrt_err(pdev, "Map iomem failed");
+		goto failed;
+	}
+
+	calib->evt_hdl = xrt_subdev_add_event_cb(pdev, xrt_calib_leaf_match,
+		NULL, xrt_calib_event_cb);
+
+	mutex_init(&calib->lock);
+	INIT_LIST_HEAD(&calib->cache_list);
+
+	return 0;
+
+failed:
+	xrt_calib_remove(pdev);
+	return err;
+}
+
+static int
+xrt_calib_leaf_ioctl(struct platform_device *pdev, u32 cmd, void *arg)
+{
+	struct calib *calib = platform_get_drvdata(pdev);
+	int ret = 0;
+
+	switch (cmd) {
+	case XRT_CALIB_RESULT: {
+		enum xrt_calib_results *r = (enum xrt_calib_results *)arg;
+		*r = calib->result;
+		break;
+	}
+	default:
+		xrt_err(pdev, "unsupported cmd %d", cmd);
+		ret = -EINVAL;
+	}
+	return ret;
+}
+
+struct xrt_subdev_endpoints xrt_calib_endpoints[] = {
+	{
+		.xse_names = (struct xrt_subdev_ep_names[]) {
+			{ .ep_name = NODE_DDR_CALIB },
+			{ NULL },
+		},
+		.xse_min_ep = 1,
+	},
+	{ 0 },
+};
+
+struct xrt_subdev_drvdata xrt_calib_data = {
+	.xsd_dev_ops = {
+		.xsd_ioctl = xrt_calib_leaf_ioctl,
+	},
+};
+
+static const struct platform_device_id xrt_calib_table[] = {
+	{ XRT_CALIB, (kernel_ulong_t)&xrt_calib_data },
+	{ },
+};
+
+struct platform_driver xrt_calib_driver = {
+	.driver = {
+		.name = XRT_CALIB,
+	},
+	.probe = xrt_calib_probe,
+	.remove = xrt_calib_remove,
+	.id_table = xrt_calib_table,
+};
diff --git a/drivers/fpga/xrt/lib/subdevs/xrt-clkfreq.c b/drivers/fpga/xrt/lib/subdevs/xrt-clkfreq.c
new file mode 100644
index 000000000000..d70b668cea3b
--- /dev/null
+++ b/drivers/fpga/xrt/lib/subdevs/xrt-clkfreq.c
@@ -0,0 +1,214 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx Alveo FPGA Clock Frequency Counter Driver
+ *
+ * Copyright (C) 2020 Xilinx, Inc.
+ *
+ * Authors:
+ *      Lizhi Hou<Lizhi.Hou@xilinx.com>
+ */
+
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/io.h>
+#include "metadata.h"
+#include "subdev.h"
+#include "parent.h"
+#include "subdev/clkfreq.h"
+
+#define CLKFREQ_ERR(clkfreq, fmt, arg...)   \
+	xrt_err((clkfreq)->pdev, fmt "\n", ##arg)
+#define CLKFREQ_WARN(clkfreq, fmt, arg...)  \
+	xrt_warn((clkfreq)->pdev, fmt "\n", ##arg)
+#define CLKFREQ_INFO(clkfreq, fmt, arg...)  \
+	xrt_info((clkfreq)->pdev, fmt "\n", ##arg)
+#define CLKFREQ_DBG(clkfreq, fmt, arg...)   \
+	xrt_dbg((clkfreq)->pdev, fmt "\n", ##arg)
+
+#define XRT_CLKFREQ		"xrt_clkfreq"
+
+#define OCL_CLKWIZ_STATUS_MASK		0xffff
+
+#define OCL_CLKWIZ_STATUS_MEASURE_START	0x1
+#define OCL_CLKWIZ_STATUS_MEASURE_DONE	0x2
+#define OCL_CLK_FREQ_COUNTER_OFFSET	0x8
+#define OCL_CLK_FREQ_V5_COUNTER_OFFSET	0x10
+#define OCL_CLK_FREQ_V5_CLK0_ENABLED	0x10000
+
+struct clkfreq {
+	struct platform_device	*pdev;
+	void __iomem		*clkfreq_base;
+	const char		*clkfreq_ep_name;
+	struct mutex		clkfreq_lock;
+};
+
+static inline u32 reg_rd(struct clkfreq *clkfreq, u32 offset)
+{
+	return ioread32(clkfreq->clkfreq_base + offset);
+}
+
+static inline void reg_wr(struct clkfreq *clkfreq, u32 val, u32 offset)
+{
+	iowrite32(val, clkfreq->clkfreq_base + offset);
+}
+
+
+static u32 clkfreq_read(struct clkfreq *clkfreq)
+{
+	u32 freq = 0, status;
+	int times = 10;
+
+	mutex_lock(&clkfreq->clkfreq_lock);
+	reg_wr(clkfreq, OCL_CLKWIZ_STATUS_MEASURE_START, 0);
+	while (times != 0) {
+		status = reg_rd(clkfreq, 0);
+		if ((status & OCL_CLKWIZ_STATUS_MASK) ==
+		    OCL_CLKWIZ_STATUS_MEASURE_DONE)
+			break;
+		mdelay(1);
+		times--;
+	};
+	if (times > 0) {
+		freq = (status & OCL_CLK_FREQ_V5_CLK0_ENABLED) ?
+			reg_rd(clkfreq, OCL_CLK_FREQ_V5_COUNTER_OFFSET) :
+			reg_rd(clkfreq, OCL_CLK_FREQ_COUNTER_OFFSET);
+	}
+	mutex_unlock(&clkfreq->clkfreq_lock);
+
+	return freq;
+}
+
+static ssize_t freq_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct clkfreq *clkfreq = platform_get_drvdata(to_platform_device(dev));
+	u32 freq;
+	ssize_t count;
+
+	freq = clkfreq_read(clkfreq);
+	count = snprintf(buf, 64, "%d\n", freq);
+
+	return count;
+}
+static DEVICE_ATTR_RO(freq);
+
+static struct attribute *clkfreq_attrs[] = {
+	&dev_attr_freq.attr,
+	NULL,
+};
+
+static struct attribute_group clkfreq_attr_group = {
+	.attrs = clkfreq_attrs,
+};
+
+static int
+xrt_clkfreq_leaf_ioctl(struct platform_device *pdev, u32 cmd, void *arg)
+{
+	struct clkfreq		*clkfreq;
+	int			ret = 0;
+
+	clkfreq = platform_get_drvdata(pdev);
+
+	switch (cmd) {
+	case XRT_CLKFREQ_READ: {
+		*(u32 *)arg = clkfreq_read(clkfreq);
+		break;
+	}
+	default:
+		xrt_err(pdev, "unsupported cmd %d", cmd);
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+static int clkfreq_remove(struct platform_device *pdev)
+{
+	struct clkfreq *clkfreq;
+
+	clkfreq = platform_get_drvdata(pdev);
+	if (!clkfreq) {
+		xrt_err(pdev, "driver data is NULL");
+		return -EINVAL;
+	}
+
+	platform_set_drvdata(pdev, NULL);
+	devm_kfree(&pdev->dev, clkfreq);
+
+	CLKFREQ_INFO(clkfreq, "successfully removed clkfreq subdev");
+	return 0;
+}
+
+
+
+static int clkfreq_probe(struct platform_device *pdev)
+{
+	struct clkfreq *clkfreq = NULL;
+	struct resource *res;
+	int ret;
+
+	clkfreq = devm_kzalloc(&pdev->dev, sizeof(*clkfreq), GFP_KERNEL);
+	if (!clkfreq)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, clkfreq);
+	clkfreq->pdev = pdev;
+	mutex_init(&clkfreq->clkfreq_lock);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	clkfreq->clkfreq_base = ioremap(res->start, res->end - res->start + 1);
+	if (!clkfreq->clkfreq_base) {
+		CLKFREQ_ERR(clkfreq, "map base %pR failed", res);
+		ret = -EFAULT;
+		goto failed;
+	}
+	clkfreq->clkfreq_ep_name = res->name;
+
+	ret = sysfs_create_group(&pdev->dev.kobj, &clkfreq_attr_group);
+	if (ret) {
+		CLKFREQ_ERR(clkfreq, "create clkfreq attrs failed: %d", ret);
+		goto failed;
+	}
+
+	CLKFREQ_INFO(clkfreq, "successfully initialized clkfreq subdev");
+
+	return 0;
+
+failed:
+	clkfreq_remove(pdev);
+	return ret;
+}
+
+
+struct xrt_subdev_endpoints xrt_clkfreq_endpoints[] = {
+	{
+		.xse_names = (struct xrt_subdev_ep_names[]) {
+			{ .regmap_name = "freq_cnt" },
+			{ NULL },
+		},
+		.xse_min_ep = 1,
+	},
+	{ 0 },
+};
+
+struct xrt_subdev_drvdata xrt_clkfreq_data = {
+	.xsd_dev_ops = {
+		.xsd_ioctl = xrt_clkfreq_leaf_ioctl,
+	},
+};
+
+static const struct platform_device_id xrt_clkfreq_table[] = {
+	{ XRT_CLKFREQ, (kernel_ulong_t)&xrt_clkfreq_data },
+	{ },
+};
+
+struct platform_driver xrt_clkfreq_driver = {
+	.driver = {
+		.name = XRT_CLKFREQ,
+	},
+	.probe = clkfreq_probe,
+	.remove = clkfreq_remove,
+	.id_table = xrt_clkfreq_table,
+};
diff --git a/drivers/fpga/xrt/lib/subdevs/xrt-clock.c b/drivers/fpga/xrt/lib/subdevs/xrt-clock.c
new file mode 100644
index 000000000000..9e3b93d322f8
--- /dev/null
+++ b/drivers/fpga/xrt/lib/subdevs/xrt-clock.c
@@ -0,0 +1,638 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx Alveo FPGA Clock Wizard Driver
+ *
+ * Copyright (C) 2020 Xilinx, Inc.
+ *
+ * Authors:
+ *      Lizhi Hou<Lizhi.Hou@xilinx.com>
+ */
+
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/io.h>
+#include "metadata.h"
+#include "subdev.h"
+#include "parent.h"
+#include "subdev/clock.h"
+#include "subdev/clkfreq.h"
+
+/* CLOCK_MAX_NUM_CLOCKS should be a concept from XCLBIN_ in the future */
+#define	CLOCK_MAX_NUM_CLOCKS		4
+#define	OCL_CLKWIZ_STATUS_OFFSET	0x4
+#define	OCL_CLKWIZ_STATUS_MASK		0xffff
+#define	OCL_CLKWIZ_STATUS_MEASURE_START	0x1
+#define	OCL_CLKWIZ_STATUS_MEASURE_DONE	0x2
+#define	OCL_CLKWIZ_CONFIG_OFFSET(n)	(0x200 + 4 * (n))
+#define	CLOCK_DEFAULT_EXPIRE_SECS	1
+
+#define	CLOCK_ERR(clock, fmt, arg...)	\
+	xrt_err((clock)->pdev, fmt "\n", ##arg)
+#define	CLOCK_WARN(clock, fmt, arg...)	\
+	xrt_warn((clock)->pdev, fmt "\n", ##arg)
+#define	CLOCK_INFO(clock, fmt, arg...)	\
+	xrt_info((clock)->pdev, fmt "\n", ##arg)
+#define	CLOCK_DBG(clock, fmt, arg...)	\
+	xrt_dbg((clock)->pdev, fmt "\n", ##arg)
+
+#define XRT_CLOCK	"xrt_clock"
+
+struct clock {
+	struct platform_device  *pdev;
+	void __iomem		*clock_base;
+	struct mutex		clock_lock;
+
+	const char		*clock_ep_name;
+};
+
+/*
+ * Precomputed table with config0 and config2 register values together with
+ * target frequency. The steps are approximately 5 MHz apart. Table is
+ * generated by wiz.pl.
+ */
+const static struct xmgmt_ocl_clockwiz {
+	/* target frequency */
+	unsigned short ocl;
+	/* config0 register */
+	unsigned long config0;
+	/* config2 register */
+	unsigned int config2;
+} frequency_table[] = {
+	{/*1275.000*/	10.000,		0x02EE0C01,	0x0001F47F},
+	{/*1575.000*/   15.000,		0x02EE0F01,     0x00000069},
+	{/*1600.000*/   20.000,		0x00001001,     0x00000050},
+	{/*1600.000*/   25.000,		0x00001001,     0x00000040},
+	{/*1575.000*/   30.000,		0x02EE0F01,     0x0001F434},
+	{/*1575.000*/   35.000,		0x02EE0F01,     0x0000002D},
+	{/*1600.000*/   40.000,		0x00001001,     0x00000028},
+	{/*1575.000*/   45.000,		0x02EE0F01,     0x00000023},
+	{/*1600.000*/   50.000,		0x00001001,     0x00000020},
+	{/*1512.500*/   55.000,		0x007D0F01,     0x0001F41B},
+	{/*1575.000*/   60.000,		0x02EE0F01,     0x0000FA1A},
+	{/*1462.500*/   65.000,		0x02710E01,     0x0001F416},
+	{/*1575.000*/   70.000,		0x02EE0F01,     0x0001F416},
+	{/*1575.000*/   75.000,		0x02EE0F01,     0x00000015},
+	{/*1600.000*/   80.000,		0x00001001,     0x00000014},
+	{/*1487.500*/   85.000,		0x036B0E01,     0x0001F411},
+	{/*1575.000*/   90.000,		0x02EE0F01,     0x0001F411},
+	{/*1425.000*/   95.000,		0x00FA0E01,     0x0000000F},
+	{/*1600.000*/   100.000,	0x00001001,     0x00000010},
+	{/*1575.000*/   105.000,	0x02EE0F01,     0x0000000F},
+	{/*1512.500*/   110.000,	0x007D0F01,     0x0002EE0D},
+	{/*1437.500*/   115.000,	0x01770E01,     0x0001F40C},
+	{/*1575.000*/   120.000,	0x02EE0F01,     0x00007D0D},
+	{/*1562.500*/   125.000,	0x02710F01,     0x0001F40C},
+	{/*1462.500*/   130.000,	0x02710E01,     0x0000FA0B},
+	{/*1350.000*/   135.000,	0x01F40D01,     0x0000000A},
+	{/*1575.000*/   140.000,	0x02EE0F01,     0x0000FA0B},
+	{/*1450.000*/   145.000,	0x01F40E01,     0x0000000A},
+	{/*1575.000*/   150.000,	0x02EE0F01,     0x0001F40A},
+	{/*1550.000*/   155.000,	0x01F40F01,     0x0000000A},
+	{/*1600.000*/   160.000,	0x00001001,     0x0000000A},
+	{/*1237.500*/   165.000,	0x01770C01,     0x0001F407},
+	{/*1487.500*/   170.000,	0x036B0E01,     0x0002EE08},
+	{/*1575.000*/   175.000,	0x02EE0F01,     0x00000009},
+	{/*1575.000*/   180.000,	0x02EE0F01,     0x0002EE08},
+	{/*1387.500*/   185.000,	0x036B0D01,     0x0001F407},
+	{/*1425.000*/   190.000,	0x00FA0E01,     0x0001F407},
+	{/*1462.500*/   195.000,	0x02710E01,     0x0001F407},
+	{/*1600.000*/   200.000,	0x00001001,     0x00000008},
+	{/*1537.500*/   205.000,        0x01770F01,     0x0001F407},
+	{/*1575.000*/   210.000,        0x02EE0F01,     0x0001F407},
+	{/*1075.000*/   215.000,        0x02EE0A01,     0x00000005},
+	{/*1512.500*/   220.000,        0x007D0F01,     0x00036B06},
+	{/*1575.000*/   225.000,        0x02EE0F01,     0x00000007},
+	{/*1437.500*/   230.000,        0x01770E01,     0x0000FA06},
+	{/*1175.000*/   235.000,        0x02EE0B01,     0x00000005},
+	{/*1500.000*/   240.000,        0x00000F01,     0x0000FA06},
+	{/*1225.000*/   245.000,        0x00FA0C01,     0x00000005},
+	{/*1562.500*/   250.000,        0x02710F01,     0x0000FA06},
+	{/*1275.000*/   255.000,        0x02EE0C01,     0x00000005},
+	{/*1462.500*/   260.000,        0x02710E01,     0x00027105},
+	{/*1325.000*/   265.000,        0x00FA0D01,     0x00000005},
+	{/*1350.000*/   270.000,        0x01F40D01,     0x00000005},
+	{/*1512.500*/   275.000,        0x007D0F01,     0x0001F405},
+	{/*1575.000*/   280.000,        0x02EE0F01,     0x00027105},
+	{/*1425.000*/   285.000,        0x00FA0E01,     0x00000005},
+	{/*1450.000*/   290.000,        0x01F40E01,     0x00000005},
+	{/*1475.000*/   295.000,        0x02EE0E01,     0x00000005},
+	{/*1575.000*/   300.000,        0x02EE0F01,     0x0000FA05},
+	{/*1525.000*/   305.000,        0x00FA0F01,     0x00000005},
+	{/*1550.000*/   310.000,        0x01F40F01,     0x00000005},
+	{/*1575.000*/   315.000,        0x02EE0F01,     0x00000005},
+	{/*1600.000*/   320.000,        0x00001001,     0x00000005},
+	{/*1462.500*/   325.000,        0x02710E01,     0x0001F404},
+	{/*1237.500*/   330.000,        0x01770C01,     0x0002EE03},
+	{/*837.500*/    335.000,        0x01770801,     0x0001F402},
+	{/*1487.500*/   340.000,        0x036B0E01,     0x00017704},
+	{/*862.500*/    345.000,        0x02710801,     0x0001F402},
+	{/*1575.000*/   350.000,        0x02EE0F01,     0x0001F404},
+	{/*887.500*/    355.000,        0x036B0801,     0x0001F402},
+	{/*1575.000*/   360.000,        0x02EE0F01,     0x00017704},
+	{/*912.500*/    365.000,        0x007D0901,     0x0001F402},
+	{/*1387.500*/   370.000,        0x036B0D01,     0x0002EE03},
+	{/*1500.000*/   375.000,        0x00000F01,     0x00000004},
+	{/*1425.000*/   380.000,        0x00FA0E01,     0x0002EE03},
+	{/*962.500*/    385.000,        0x02710901,     0x0001F402},
+	{/*1462.500*/   390.000,        0x02710E01,     0x0002EE03},
+	{/*987.500*/    395.000,        0x036B0901,     0x0001F402},
+	{/*1600.000*/   400.000,        0x00001001,     0x00000004},
+	{/*1012.500*/   405.000,        0x007D0A01,     0x0001F402},
+	{/*1537.500*/   410.000,        0x01770F01,     0x0002EE03},
+	{/*1037.500*/   415.000,        0x01770A01,     0x0001F402},
+	{/*1575.000*/   420.000,        0x02EE0F01,     0x0002EE03},
+	{/*1487.500*/   425.000,        0x036B0E01,     0x0001F403},
+	{/*1075.000*/   430.000,        0x02EE0A01,     0x0001F402},
+	{/*1087.500*/   435.000,        0x036B0A01,     0x0001F402},
+	{/*1375.000*/   440.000,        0x02EE0D01,     0x00007D03},
+	{/*1112.500*/   445.000,        0x007D0B01,     0x0001F402},
+	{/*1575.000*/   450.000,        0x02EE0F01,     0x0001F403},
+	{/*1137.500*/   455.000,        0x01770B01,     0x0001F402},
+	{/*1437.500*/   460.000,        0x01770E01,     0x00007D03},
+	{/*1162.500*/   465.000,        0x02710B01,     0x0001F402},
+	{/*1175.000*/   470.000,        0x02EE0B01,     0x0001F402},
+	{/*1425.000*/   475.000,        0x00FA0E01,     0x00000003},
+	{/*1500.000*/   480.000,        0x00000F01,     0x00007D03},
+	{/*1212.500*/   485.000,        0x007D0C01,     0x0001F402},
+	{/*1225.000*/   490.000,        0x00FA0C01,     0x0001F402},
+	{/*1237.500*/   495.000,        0x01770C01,     0x0001F402},
+	{/*1562.500*/   500.000,        0x02710F01,     0x00007D03},
+	{/*1262.500*/   505.000,        0x02710C01,     0x0001F402},
+	{/*1275.000*/   510.000,        0x02EE0C01,     0x0001F402},
+	{/*1287.500*/   515.000,        0x036B0C01,     0x0001F402},
+	{/*1300.000*/   520.000,        0x00000D01,     0x0001F402},
+	{/*1575.000*/   525.000,        0x02EE0F01,     0x00000003},
+	{/*1325.000*/   530.000,        0x00FA0D01,     0x0001F402},
+	{/*1337.500*/   535.000,        0x01770D01,     0x0001F402},
+	{/*1350.000*/   540.000,        0x01F40D01,     0x0001F402},
+	{/*1362.500*/   545.000,        0x02710D01,     0x0001F402},
+	{/*1512.500*/   550.000,        0x007D0F01,     0x0002EE02},
+	{/*1387.500*/   555.000,        0x036B0D01,     0x0001F402},
+	{/*1400.000*/   560.000,        0x00000E01,     0x0001F402},
+	{/*1412.500*/   565.000,        0x007D0E01,     0x0001F402},
+	{/*1425.000*/   570.000,        0x00FA0E01,     0x0001F402},
+	{/*1437.500*/   575.000,        0x01770E01,     0x0001F402},
+	{/*1450.000*/   580.000,        0x01F40E01,     0x0001F402},
+	{/*1462.500*/   585.000,        0x02710E01,     0x0001F402},
+	{/*1475.000*/   590.000,        0x02EE0E01,     0x0001F402},
+	{/*1487.500*/   595.000,        0x036B0E01,     0x0001F402},
+	{/*1575.000*/   600.000,        0x02EE0F01,     0x00027102},
+	{/*1512.500*/   605.000,        0x007D0F01,     0x0001F402},
+	{/*1525.000*/   610.000,        0x00FA0F01,     0x0001F402},
+	{/*1537.500*/   615.000,        0x01770F01,     0x0001F402},
+	{/*1550.000*/   620.000,        0x01F40F01,     0x0001F402},
+	{/*1562.500*/   625.000,        0x02710F01,     0x0001F402},
+	{/*1575.000*/   630.000,        0x02EE0F01,     0x0001F402},
+	{/*1587.500*/   635.000,        0x036B0F01,     0x0001F402},
+	{/*1600.000*/   640.000,        0x00001001,     0x0001F402},
+	{/*1290.000*/   645.000,        0x01F44005,     0x00000002},
+	{/*1462.500*/   650.000,        0x02710E01,     0x0000FA02}
+};
+
+static inline u32 reg_rd(struct clock *clock, u32 offset)
+{
+	return ioread32(clock->clock_base + offset);
+}
+
+static inline void reg_wr(struct clock *clock, u32 val, u32 offset)
+{
+	iowrite32(val, clock->clock_base + offset);
+}
+
+static u32 find_matching_freq_config(unsigned short freq,
+	const struct xmgmt_ocl_clockwiz *table, int size)
+{
+	u32 start = 0;
+	u32 end = size - 1;
+	u32 idx = size - 1;
+
+	if (freq < table[0].ocl)
+		return 0;
+
+	if (freq > table[size - 1].ocl)
+		return size - 1;
+
+	while (start < end) {
+		if (freq == table[idx].ocl)
+			break;
+		if (freq < table[idx].ocl)
+			end = idx;
+		else
+			start = idx + 1;
+		idx = start + (end - start) / 2;
+	}
+	if (freq < table[idx].ocl)
+		idx--;
+
+	return idx;
+}
+
+static u32 find_matching_freq(u32 freq,
+	const struct xmgmt_ocl_clockwiz *freq_table, int freq_table_size)
+{
+	int idx = find_matching_freq_config(freq, freq_table, freq_table_size);
+
+	return freq_table[idx].ocl;
+}
+
+static inline int clock_wiz_busy(struct clock *clock, int cycle,
+	int interval)
+{
+	u32 val = 0;
+	int count;
+
+	val = reg_rd(clock, OCL_CLKWIZ_STATUS_OFFSET);
+	for (count = 0; val != 1 && count < cycle; count++) {
+		mdelay(interval);
+		val = reg_rd(clock, OCL_CLKWIZ_STATUS_OFFSET);
+	}
+	if (val != 1) {
+		CLOCK_ERR(clock, "clockwiz is (%u) busy after %d ms",
+			val, cycle * interval);
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+static int get_freq(struct clock *clock, u16 *freq)
+{
+#define XCL_INPUT_FREQ 100
+	const u64 input = XCL_INPUT_FREQ;
+	u32 val;
+	u32 mul0, div0;
+	u32 mul_frac0 = 0;
+	u32 div1;
+	u32 div_frac1 = 0;
+
+	BUG_ON(!mutex_is_locked(&clock->clock_lock));
+
+	val = reg_rd(clock, OCL_CLKWIZ_STATUS_OFFSET);
+	if ((val & 0x1) == 0) {
+		CLOCK_ERR(clock, "clockwiz is busy %x", val);
+		*freq = 0;
+		return -EBUSY;
+	}
+
+	val = reg_rd(clock, OCL_CLKWIZ_CONFIG_OFFSET(0));
+
+	div0 = val & 0xff;
+	mul0 = (val & 0xff00) >> 8;
+	if (val & BIT(26)) {
+		mul_frac0 = val >> 16;
+		mul_frac0 &= 0x3ff;
+	}
+
+	/*
+	 * Multiply both numerator (mul0) and the denominator (div0) with 1000
+	 * to account for fractional portion of multiplier
+	 */
+	mul0 *= 1000;
+	mul0 += mul_frac0;
+	div0 *= 1000;
+
+	val = reg_rd(clock, OCL_CLKWIZ_CONFIG_OFFSET(2));
+
+	div1 = val & 0xff;
+	if (val & BIT(18)) {
+		div_frac1 = val >> 8;
+		div_frac1 &= 0x3ff;
+	}
+
+	/*
+	 * Multiply both numerator (mul0) and the denominator (div1) with
+	 * 1000 to account for fractional portion of divider
+	 */
+
+	div1 *= 1000;
+	div1 += div_frac1;
+	div0 *= div1;
+	mul0 *= 1000;
+	if (div0 == 0) {
+		CLOCK_ERR(clock, "clockwiz 0 divider");
+		return 0;
+	}
+
+	*freq = (u16)((input * mul0) / div0);
+
+	return 0;
+}
+
+static int set_freq(struct clock *clock, u16 freq)
+{
+	u32 config;
+	int err;
+	u32 idx = 0;
+	u32 val;
+
+	BUG_ON(!mutex_is_locked(&clock->clock_lock));
+
+	idx = find_matching_freq_config(freq, frequency_table,
+		ARRAY_SIZE(frequency_table));
+
+	CLOCK_INFO(clock, "New: %d Mhz", freq);
+	err = clock_wiz_busy(clock, 20, 50);
+	if (err)
+		return -EBUSY;
+
+	config = frequency_table[idx].config0;
+	reg_wr(clock, config, OCL_CLKWIZ_CONFIG_OFFSET(0));
+
+	config = frequency_table[idx].config2;
+	reg_wr(clock, config, OCL_CLKWIZ_CONFIG_OFFSET(2));
+
+	mdelay(10);
+	reg_wr(clock, 7, OCL_CLKWIZ_CONFIG_OFFSET(23));
+
+	mdelay(1);
+	reg_wr(clock, 2, OCL_CLKWIZ_CONFIG_OFFSET(23));
+
+	CLOCK_INFO(clock, "clockwiz waiting for locked signal");
+
+	err = clock_wiz_busy(clock, 100, 100);
+	if (err) {
+		CLOCK_ERR(clock, "clockwiz MMCM/PLL did not lock");
+		/* restore */
+		reg_wr(clock, 4, OCL_CLKWIZ_CONFIG_OFFSET(23));
+		mdelay(10);
+		reg_wr(clock, 0, OCL_CLKWIZ_CONFIG_OFFSET(23));
+		return err;
+	}
+	val = reg_rd(clock, OCL_CLKWIZ_CONFIG_OFFSET(0));
+	CLOCK_INFO(clock, "clockwiz CONFIG(0) 0x%x", val);
+	val = reg_rd(clock, OCL_CLKWIZ_CONFIG_OFFSET(2));
+	CLOCK_INFO(clock, "clockwiz CONFIG(2) 0x%x", val);
+
+	return 0;
+}
+
+static int get_freq_counter(struct clock *clock, u32 *freq)
+{
+	const void *cnter;
+	struct platform_device *cnter_leaf;
+	struct platform_device *pdev = clock->pdev;
+	struct xrt_subdev_platdata *pdata = DEV_PDATA(clock->pdev);
+	int err = xrt_md_get_prop(DEV(pdev), pdata->xsp_dtb,
+		clock->clock_ep_name, NULL, PROP_CLK_CNT, &cnter, NULL);
+
+	BUG_ON(!mutex_is_locked(&clock->clock_lock));
+
+	if (err) {
+		xrt_err(pdev, "no counter specified");
+		return err;
+	}
+
+	cnter_leaf = xrt_subdev_get_leaf_by_epname(pdev, cnter);
+	if (!cnter_leaf) {
+		xrt_err(pdev, "can't find counter");
+		return -ENOENT;
+	}
+
+	err = xrt_subdev_ioctl(cnter_leaf, XRT_CLKFREQ_READ, freq);
+	if (err)
+		xrt_err(pdev, "can't read counter");
+	xrt_subdev_put_leaf(clock->pdev, cnter_leaf);
+
+	return err;
+}
+
+static int clock_get_freq(struct clock *clock, u16 *freq, u32 *freq_cnter)
+{
+	int err = 0;
+
+	mutex_lock(&clock->clock_lock);
+
+	if (err == 0 && freq)
+		err = get_freq(clock, freq);
+
+	if (err == 0 && freq_cnter)
+		err = get_freq_counter(clock, freq_cnter);
+
+	mutex_unlock(&clock->clock_lock);
+	return err;
+}
+
+static int clock_set_freq(struct clock *clock, u16 freq)
+{
+	int err;
+
+	mutex_lock(&clock->clock_lock);
+	err = set_freq(clock, freq);
+	mutex_unlock(&clock->clock_lock);
+
+	return err;
+}
+
+static int clock_verify_freq(struct clock *clock)
+{
+	int err = 0;
+	u16 freq;
+	u32 lookup_freq, clock_freq_counter, request_in_khz, tolerance;
+
+	mutex_lock(&clock->clock_lock);
+
+	err = get_freq(clock, &freq);
+	if (err) {
+		xrt_err(clock->pdev, "get freq failed, %d", err);
+		goto end;
+	}
+
+	err = get_freq_counter(clock, &clock_freq_counter);
+	if (err) {
+		xrt_err(clock->pdev, "get freq counter failed, %d", err);
+		goto end;
+	}
+
+	lookup_freq = find_matching_freq(freq, frequency_table,
+		ARRAY_SIZE(frequency_table));
+	request_in_khz = lookup_freq * 1000;
+	tolerance = lookup_freq * 50;
+	if (tolerance < abs(clock_freq_counter-request_in_khz)) {
+		CLOCK_ERR(clock,
+		    "set clock(%s) failed, request %ukhz, actual %dkhz",
+		    clock->clock_ep_name, request_in_khz, clock_freq_counter);
+		err = -EDOM;
+	} else {
+		CLOCK_INFO(clock, "verified clock (%s)", clock->clock_ep_name);
+	}
+
+end:
+	mutex_unlock(&clock->clock_lock);
+	return err;
+}
+
+static int clock_init(struct clock *clock)
+{
+	struct xrt_subdev_platdata *pdata = DEV_PDATA(clock->pdev);
+	int err = 0;
+	const u16 *freq;
+
+	err = xrt_md_get_prop(DEV(clock->pdev), pdata->xsp_dtb,
+		clock->clock_ep_name, NULL, PROP_CLK_FREQ,
+		(const void **)&freq, NULL);
+	if (err) {
+		xrt_info(clock->pdev, "no default freq");
+		return 0;
+	}
+
+	mutex_lock(&clock->clock_lock);
+	err = set_freq(clock, be16_to_cpu(*freq));
+	mutex_unlock(&clock->clock_lock);
+
+	return err;
+}
+
+static ssize_t freq_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct clock *clock = platform_get_drvdata(to_platform_device(dev));
+	u16 freq = 0;
+	ssize_t count;
+
+	count = clock_get_freq(clock, &freq, NULL);
+	if (count < 0)
+		return count;
+
+	count = snprintf(buf, 64, "%d\n", freq);
+
+	return count;
+}
+static DEVICE_ATTR_RO(freq);
+
+static struct attribute *clock_attrs[] = {
+	&dev_attr_freq.attr,
+	NULL,
+};
+
+static struct attribute_group clock_attr_group = {
+	.attrs = clock_attrs,
+};
+
+static int
+xrt_clock_leaf_ioctl(struct platform_device *pdev, u32 cmd, void *arg)
+{
+	struct clock		*clock;
+	int			ret = 0;
+
+	clock = platform_get_drvdata(pdev);
+
+	switch (cmd) {
+	case XRT_CLOCK_SET: {
+		u16	freq = (u16)(uintptr_t)arg;
+
+		ret = clock_set_freq(clock, freq);
+		break;
+	}
+	case XRT_CLOCK_VERIFY: {
+		ret = clock_verify_freq(clock);
+		break;
+	}
+	case XRT_CLOCK_GET: {
+		struct xrt_clock_ioctl_get *get =
+			(struct xrt_clock_ioctl_get *)arg;
+
+		ret = clock_get_freq(clock, &get->freq, &get->freq_cnter);
+		break;
+	}
+	default:
+		xrt_err(pdev, "unsupported cmd %d", cmd);
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+static int clock_remove(struct platform_device *pdev)
+{
+	struct clock *clock;
+
+	clock = platform_get_drvdata(pdev);
+	if (!clock) {
+		xrt_err(pdev, "driver data is NULL");
+		return -EINVAL;
+	}
+
+	platform_set_drvdata(pdev, NULL);
+	devm_kfree(&pdev->dev, clock);
+
+	CLOCK_INFO(clock, "successfully removed Clock subdev");
+	return 0;
+}
+
+
+
+static int clock_probe(struct platform_device *pdev)
+{
+	struct clock *clock = NULL;
+	struct resource *res;
+	int ret;
+
+	clock = devm_kzalloc(&pdev->dev, sizeof(*clock), GFP_KERNEL);
+	if (!clock)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, clock);
+	clock->pdev = pdev;
+	mutex_init(&clock->clock_lock);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	clock->clock_base = ioremap(res->start, res->end - res->start + 1);
+	if (!clock->clock_base) {
+		CLOCK_ERR(clock, "map base %pR failed", res);
+		ret = -EFAULT;
+		goto failed;
+	}
+
+	clock->clock_ep_name = res->name;
+
+	ret = clock_init(clock);
+	if (ret)
+		goto failed;
+
+	ret = sysfs_create_group(&pdev->dev.kobj, &clock_attr_group);
+	if (ret) {
+		CLOCK_ERR(clock, "create clock attrs failed: %d", ret);
+		goto failed;
+	}
+
+	CLOCK_INFO(clock, "successfully initialized Clock subdev");
+
+	return 0;
+
+failed:
+	clock_remove(pdev);
+	return ret;
+}
+
+struct xrt_subdev_endpoints xrt_clock_endpoints[] = {
+	{
+		.xse_names = (struct xrt_subdev_ep_names[]) {
+			{ .regmap_name = "clkwiz" },
+			{ NULL },
+		},
+		.xse_min_ep = 1,
+	},
+	{ 0 },
+};
+
+struct xrt_subdev_drvdata xrt_clock_data = {
+	.xsd_dev_ops = {
+		.xsd_ioctl = xrt_clock_leaf_ioctl,
+	},
+};
+
+static const struct platform_device_id xrt_clock_table[] = {
+	{ XRT_CLOCK, (kernel_ulong_t)&xrt_clock_data },
+	{ },
+};
+
+struct platform_driver xrt_clock_driver = {
+	.driver = {
+		.name = XRT_CLOCK,
+	},
+	.probe = clock_probe,
+	.remove = clock_remove,
+	.id_table = xrt_clock_table,
+};
diff --git a/drivers/fpga/xrt/lib/subdevs/xrt-gpio.c b/drivers/fpga/xrt/lib/subdevs/xrt-gpio.c
new file mode 100644
index 000000000000..358e274a1550
--- /dev/null
+++ b/drivers/fpga/xrt/lib/subdevs/xrt-gpio.c
@@ -0,0 +1,198 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx Alveo FPGA GPIO Driver
+ *
+ * Copyright (C) 2020 Xilinx, Inc.
+ *
+ * Authors:
+ *      Lizhi Hou<Lizhi.Hou@xilinx.com>
+ */
+
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/io.h>
+#include "metadata.h"
+#include "subdev.h"
+#include "parent.h"
+#include "subdev/gpio.h"
+
+#define XRT_GPIO "xrt_gpio"
+
+struct xrt_name_id {
+	char *ep_name;
+	int id;
+};
+
+static struct xrt_name_id name_id[XRT_GPIO_MAX] = {
+	{ NODE_BLP_ROM, XRT_GPIO_ROM_UUID },
+	{ NODE_GOLDEN_VER, XRT_GPIO_GOLDEN_VER },
+};
+
+struct xrt_gpio {
+	struct platform_device	*pdev;
+	void		__iomem *base_addrs[XRT_GPIO_MAX];
+	ulong			sizes[XRT_GPIO_MAX];
+};
+
+static int xrt_gpio_name2id(struct xrt_gpio *gpio, const char *name)
+{
+	int	i;
+
+	for (i = 0; i < XRT_GPIO_MAX && name_id[i].ep_name; i++) {
+		if (!strncmp(name_id[i].ep_name, name,
+		    strlen(name_id[i].ep_name) + 1))
+			return name_id[i].id;
+	}
+
+	return -EINVAL;
+}
+
+static int
+xrt_gpio_leaf_ioctl(struct platform_device *pdev, u32 cmd, void *arg)
+{
+	struct xrt_gpio	*gpio;
+	int			ret = 0;
+
+	gpio = platform_get_drvdata(pdev);
+
+	switch (cmd) {
+	case XRT_GPIO_READ: {
+		struct xrt_gpio_ioctl_rw	*rw_arg = arg;
+		u32				*p_src, *p_dst, i;
+
+		if (rw_arg->xgir_len & 0x3) {
+			xrt_err(pdev, "invalid len %d", rw_arg->xgir_len);
+			return -EINVAL;
+		}
+
+		if (rw_arg->xgir_id >= XRT_GPIO_MAX) {
+			xrt_err(pdev, "invalid id %d", rw_arg->xgir_id);
+			return -EINVAL;
+		}
+
+		p_src = gpio->base_addrs[rw_arg->xgir_id];
+		if (!p_src) {
+			xrt_err(pdev, "io not found, id %d",
+				rw_arg->xgir_id);
+			return -EINVAL;
+		}
+		if (rw_arg->xgir_offset + rw_arg->xgir_len >
+		    gpio->sizes[rw_arg->xgir_id]) {
+			xrt_err(pdev, "invalid argument, off %d, len %d",
+				rw_arg->xgir_offset, rw_arg->xgir_len);
+			return -EINVAL;
+		}
+		p_dst = rw_arg->xgir_buf;
+		for (i = 0; i < rw_arg->xgir_len / sizeof(u32); i++) {
+			u32 val = ioread32(p_src + rw_arg->xgir_offset + i);
+
+			memcpy(p_dst + i, &val, sizeof(u32));
+		}
+		break;
+	}
+	default:
+		xrt_err(pdev, "unsupported cmd %d", cmd);
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+static int xrt_gpio_remove(struct platform_device *pdev)
+{
+	struct xrt_gpio	*gpio;
+	int			i;
+
+	gpio = platform_get_drvdata(pdev);
+
+	for (i = 0; i < XRT_GPIO_MAX; i++) {
+		if (gpio->base_addrs[i])
+			iounmap(gpio->base_addrs[i]);
+	}
+
+	platform_set_drvdata(pdev, NULL);
+	devm_kfree(&pdev->dev, gpio);
+
+	return 0;
+}
+
+static int xrt_gpio_probe(struct platform_device *pdev)
+{
+	struct xrt_gpio	*gpio;
+	int			i, id, ret = 0;
+	struct resource		*res;
+
+	gpio = devm_kzalloc(&pdev->dev, sizeof(*gpio), GFP_KERNEL);
+	if (!gpio)
+		return -ENOMEM;
+
+	gpio->pdev = pdev;
+	platform_set_drvdata(pdev, gpio);
+
+	xrt_info(pdev, "probing...");
+	for (i = 0, res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	    res;
+	    res = platform_get_resource(pdev, IORESOURCE_MEM, ++i)) {
+		id = xrt_gpio_name2id(gpio, res->name);
+		if (id < 0) {
+			xrt_err(pdev, "ep %s not found", res->name);
+			continue;
+		}
+		gpio->base_addrs[id] = ioremap(res->start,
+			res->end - res->start + 1);
+		if (!gpio->base_addrs[id]) {
+			xrt_err(pdev, "map base failed %pR", res);
+			ret = -EIO;
+			goto failed;
+		}
+		gpio->sizes[id] = res->end - res->start + 1;
+	}
+
+failed:
+	if (ret)
+		xrt_gpio_remove(pdev);
+
+	return ret;
+}
+
+struct xrt_subdev_endpoints xrt_gpio_endpoints[] = {
+	{
+		.xse_names = (struct xrt_subdev_ep_names[]) {
+			/* add name if ep is in same partition */
+			{ .ep_name = NODE_BLP_ROM },
+			{ NULL },
+		},
+		.xse_min_ep = 1,
+	},
+	{
+		.xse_names = (struct xrt_subdev_ep_names[]) {
+			{ .ep_name = NODE_GOLDEN_VER },
+			{ NULL },
+		},
+		.xse_min_ep = 1,
+	},
+	/* adding ep bundle generates gpio device instance */
+	{ 0 },
+};
+
+struct xrt_subdev_drvdata xrt_gpio_data = {
+	.xsd_dev_ops = {
+		.xsd_ioctl = xrt_gpio_leaf_ioctl,
+	},
+};
+
+static const struct platform_device_id xrt_gpio_table[] = {
+	{ XRT_GPIO, (kernel_ulong_t)&xrt_gpio_data },
+	{ },
+};
+
+struct platform_driver xrt_gpio_driver = {
+	.driver = {
+		.name = XRT_GPIO,
+	},
+	.probe = xrt_gpio_probe,
+	.remove = xrt_gpio_remove,
+	.id_table = xrt_gpio_table,
+};
diff --git a/drivers/fpga/xrt/lib/subdevs/xrt-icap.c b/drivers/fpga/xrt/lib/subdevs/xrt-icap.c
new file mode 100644
index 000000000000..3b23afb55d3c
--- /dev/null
+++ b/drivers/fpga/xrt/lib/subdevs/xrt-icap.c
@@ -0,0 +1,306 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx Alveo FPGA ICAP Driver
+ *
+ * Copyright (C) 2020 Xilinx, Inc.
+ *
+ * Authors:
+ *      Lizhi Hou<Lizhi.Hou@xilinx.com>
+ */
+
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/io.h>
+#include "metadata.h"
+#include "subdev.h"
+#include "parent.h"
+#include "subdev/icap.h"
+#include "xrt-xclbin.h"
+
+#define XRT_ICAP "xrt_icap"
+
+#define	ICAP_ERR(icap, fmt, arg...)	\
+	xrt_err((icap)->pdev, fmt "\n", ##arg)
+#define	ICAP_WARN(icap, fmt, arg...)	\
+	xrt_warn((icap)->pdev, fmt "\n", ##arg)
+#define	ICAP_INFO(icap, fmt, arg...)	\
+	xrt_info((icap)->pdev, fmt "\n", ##arg)
+#define	ICAP_DBG(icap, fmt, arg...)	\
+	xrt_dbg((icap)->pdev, fmt "\n", ##arg)
+
+/*
+ * AXI-HWICAP IP register layout
+ */
+struct icap_reg {
+	u32	ir_rsvd1[7];
+	u32	ir_gier;
+	u32	ir_isr;
+	u32	ir_rsvd2;
+	u32	ir_ier;
+	u32	ir_rsvd3[53];
+	u32	ir_wf;
+	u32	ir_rf;
+	u32	ir_sz;
+	u32	ir_cr;
+	u32	ir_sr;
+	u32	ir_wfv;
+	u32	ir_rfo;
+	u32	ir_asr;
+} __packed;
+
+struct icap {
+	struct platform_device	*pdev;
+	struct icap_reg		*icap_regs;
+	struct mutex		icap_lock;
+
+	unsigned int		idcode;
+};
+
+static inline u32 reg_rd(void __iomem *reg)
+{
+	if (!reg)
+		return -1;
+
+	return ioread32(reg);
+}
+
+static inline void reg_wr(void __iomem *reg, u32 val)
+{
+	if (!reg)
+		return;
+
+	iowrite32(val, reg);
+}
+
+static int wait_for_done(struct icap *icap)
+{
+	u32	w;
+	int	i = 0;
+
+	BUG_ON(!mutex_is_locked(&icap->icap_lock));
+	for (i = 0; i < 10; i++) {
+		udelay(5);
+		w = reg_rd(&icap->icap_regs->ir_sr);
+		ICAP_INFO(icap, "XHWICAP_SR: %x", w);
+		if (w & 0x5)
+			return 0;
+	}
+
+	ICAP_ERR(icap, "bitstream download timeout");
+	return -ETIMEDOUT;
+}
+
+static int icap_write(struct icap *icap, const u32 *word_buf, int size)
+{
+	int i;
+	u32 value = 0;
+
+	for (i = 0; i < size; i++) {
+		value = be32_to_cpu(word_buf[i]);
+		reg_wr(&icap->icap_regs->ir_wf, value);
+	}
+
+	reg_wr(&icap->icap_regs->ir_cr, 0x1);
+
+	for (i = 0; i < 20; i++) {
+		value = reg_rd(&icap->icap_regs->ir_cr);
+		if ((value & 0x1) == 0)
+			return 0;
+		ndelay(50);
+	}
+
+	ICAP_ERR(icap, "writing %d dwords timeout", size);
+	return -EIO;
+}
+
+static int bitstream_helper(struct icap *icap, const u32 *word_buffer,
+	u32 word_count)
+{
+	u32 remain_word;
+	u32 word_written = 0;
+	int wr_fifo_vacancy = 0;
+	int err = 0;
+
+	BUG_ON(!mutex_is_locked(&icap->icap_lock));
+	for (remain_word = word_count; remain_word > 0;
+		remain_word -= word_written, word_buffer += word_written) {
+		wr_fifo_vacancy = reg_rd(&icap->icap_regs->ir_wfv);
+		if (wr_fifo_vacancy <= 0) {
+			ICAP_ERR(icap, "no vacancy: %d", wr_fifo_vacancy);
+			err = -EIO;
+			break;
+		}
+		word_written = (wr_fifo_vacancy < remain_word) ?
+			wr_fifo_vacancy : remain_word;
+		if (icap_write(icap, word_buffer, word_written) != 0) {
+			ICAP_ERR(icap, "write failed remain %d, written %d",
+					remain_word, word_written);
+			err = -EIO;
+			break;
+		}
+	}
+
+	return err;
+}
+
+static int icap_download(struct icap *icap, const char *buffer,
+	unsigned long length)
+{
+	u32	numCharsRead = DMA_HWICAP_BITFILE_BUFFER_SIZE;
+	u32	byte_read;
+	int	err = 0;
+
+	mutex_lock(&icap->icap_lock);
+	for (byte_read = 0; byte_read < length; byte_read += numCharsRead) {
+		numCharsRead = length - byte_read;
+		if (numCharsRead > DMA_HWICAP_BITFILE_BUFFER_SIZE)
+			numCharsRead = DMA_HWICAP_BITFILE_BUFFER_SIZE;
+
+		err = bitstream_helper(icap, (u32 *)buffer,
+			numCharsRead / sizeof(u32));
+		if (err)
+			goto failed;
+		buffer += numCharsRead;
+	}
+
+	err = wait_for_done(icap);
+
+failed:
+	mutex_unlock(&icap->icap_lock);
+
+	return err;
+}
+
+/*
+ * Run the following sequence of canned commands to obtain IDCODE of the FPGA
+ */
+static void icap_probe_chip(struct icap *icap)
+{
+	u32 w;
+
+	w = reg_rd(&icap->icap_regs->ir_sr);
+	w = reg_rd(&icap->icap_regs->ir_sr);
+	reg_wr(&icap->icap_regs->ir_gier, 0x0);
+	w = reg_rd(&icap->icap_regs->ir_wfv);
+	reg_wr(&icap->icap_regs->ir_wf, 0xffffffff);
+	reg_wr(&icap->icap_regs->ir_wf, 0xaa995566);
+	reg_wr(&icap->icap_regs->ir_wf, 0x20000000);
+	reg_wr(&icap->icap_regs->ir_wf, 0x20000000);
+	reg_wr(&icap->icap_regs->ir_wf, 0x28018001);
+	reg_wr(&icap->icap_regs->ir_wf, 0x20000000);
+	reg_wr(&icap->icap_regs->ir_wf, 0x20000000);
+	w = reg_rd(&icap->icap_regs->ir_cr);
+	reg_wr(&icap->icap_regs->ir_cr, 0x1);
+	w = reg_rd(&icap->icap_regs->ir_cr);
+	w = reg_rd(&icap->icap_regs->ir_cr);
+	w = reg_rd(&icap->icap_regs->ir_sr);
+	w = reg_rd(&icap->icap_regs->ir_cr);
+	w = reg_rd(&icap->icap_regs->ir_sr);
+	reg_wr(&icap->icap_regs->ir_sz, 0x1);
+	w = reg_rd(&icap->icap_regs->ir_cr);
+	reg_wr(&icap->icap_regs->ir_cr, 0x2);
+	w = reg_rd(&icap->icap_regs->ir_rfo);
+	icap->idcode = reg_rd(&icap->icap_regs->ir_rf);
+	w = reg_rd(&icap->icap_regs->ir_cr);
+}
+
+static int
+xrt_icap_leaf_ioctl(struct platform_device *pdev, u32 cmd, void *arg)
+{
+	struct xrt_icap_ioctl_wr	*wr_arg = arg;
+	struct icap			*icap;
+	int				ret = 0;
+
+	icap = platform_get_drvdata(pdev);
+
+	switch (cmd) {
+	case XRT_ICAP_WRITE:
+		ret = icap_download(icap, wr_arg->xiiw_bit_data,
+				wr_arg->xiiw_data_len);
+		break;
+	case XRT_ICAP_IDCODE:
+		*(u64 *)arg = icap->idcode;
+		break;
+	default:
+		ICAP_ERR(icap, "unknown command %d", cmd);
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+static int xrt_icap_remove(struct platform_device *pdev)
+{
+	struct icap	*icap;
+
+	icap = platform_get_drvdata(pdev);
+
+	platform_set_drvdata(pdev, NULL);
+	devm_kfree(&pdev->dev, icap);
+
+	return 0;
+}
+
+static int xrt_icap_probe(struct platform_device *pdev)
+{
+	struct icap	*icap;
+	int			ret = 0;
+	struct resource		*res;
+
+	icap = devm_kzalloc(&pdev->dev, sizeof(*icap), GFP_KERNEL);
+	if (!icap)
+		return -ENOMEM;
+
+	icap->pdev = pdev;
+	platform_set_drvdata(pdev, icap);
+	mutex_init(&icap->icap_lock);
+
+	xrt_info(pdev, "probing");
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (res != NULL) {
+		icap->icap_regs = ioremap(res->start,
+			res->end - res->start + 1);
+		if (!icap->icap_regs) {
+			xrt_err(pdev, "map base failed %pR", res);
+			ret = -EIO;
+			goto failed;
+		}
+	}
+
+	icap_probe_chip(icap);
+failed:
+	return ret;
+}
+
+struct xrt_subdev_endpoints xrt_icap_endpoints[] = {
+	{
+		.xse_names = (struct xrt_subdev_ep_names[]) {
+			{ .ep_name = NODE_FPGA_CONFIG },
+			{ NULL },
+		},
+		.xse_min_ep = 1,
+	},
+	{ 0 },
+};
+
+struct xrt_subdev_drvdata xrt_icap_data = {
+	.xsd_dev_ops = {
+		.xsd_ioctl = xrt_icap_leaf_ioctl,
+	},
+};
+
+static const struct platform_device_id xrt_icap_table[] = {
+	{ XRT_ICAP, (kernel_ulong_t)&xrt_icap_data },
+	{ },
+};
+
+struct platform_driver xrt_icap_driver = {
+	.driver = {
+		.name = XRT_ICAP,
+	},
+	.probe = xrt_icap_probe,
+	.remove = xrt_icap_remove,
+	.id_table = xrt_icap_table,
+};
diff --git a/drivers/fpga/xrt/lib/subdevs/xrt-ucs.c b/drivers/fpga/xrt/lib/subdevs/xrt-ucs.c
new file mode 100644
index 000000000000..8ce696491357
--- /dev/null
+++ b/drivers/fpga/xrt/lib/subdevs/xrt-ucs.c
@@ -0,0 +1,238 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx Alveo FPGA UCS Driver
+ *
+ * Copyright (C) 2020 Xilinx, Inc.
+ *
+ * Authors:
+ *      Lizhi Hou<Lizhi.Hou@xilinx.com>
+ */
+
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/io.h>
+#include "metadata.h"
+#include "subdev.h"
+#include "parent.h"
+#include "subdev/ucs.h"
+#include "subdev/clock.h"
+
+#define UCS_ERR(ucs, fmt, arg...)   \
+	xrt_err((ucs)->pdev, fmt "\n", ##arg)
+#define UCS_WARN(ucs, fmt, arg...)  \
+	xrt_warn((ucs)->pdev, fmt "\n", ##arg)
+#define UCS_INFO(ucs, fmt, arg...)  \
+	xrt_info((ucs)->pdev, fmt "\n", ##arg)
+#define UCS_DBG(ucs, fmt, arg...)   \
+	xrt_dbg((ucs)->pdev, fmt "\n", ##arg)
+
+
+#define XRT_UCS		"xrt_ucs"
+
+#define CHANNEL1_OFFSET			0
+#define CHANNEL2_OFFSET			8
+
+#define CLK_MAX_VALUE			6400
+
+struct ucs_control_status_ch1 {
+	unsigned int shutdown_clocks_latched:1;
+	unsigned int reserved1:15;
+	unsigned int clock_throttling_average:14;
+	unsigned int reserved2:2;
+};
+
+
+struct xrt_ucs {
+	struct platform_device	*pdev;
+	void __iomem		*ucs_base;
+	struct mutex		ucs_lock;
+	void			*evt_hdl;
+};
+
+static inline u32 reg_rd(struct xrt_ucs *ucs, u32 offset)
+{
+	return ioread32(ucs->ucs_base + offset);
+}
+
+static inline void reg_wr(struct xrt_ucs *ucs, u32 val, u32 offset)
+{
+	iowrite32(val, ucs->ucs_base + offset);
+}
+
+static bool xrt_ucs_leaf_match(enum xrt_subdev_id id,
+	struct platform_device *pdev, void *arg)
+{
+	if (id == XRT_SUBDEV_CLOCK)
+		return true;
+
+	return false;
+}
+
+static int xrt_ucs_event_cb(struct platform_device *pdev,
+	enum xrt_events evt, void *arg)
+{
+
+	struct xrt_ucs		*ucs;
+	struct platform_device	*leaf;
+	struct xrt_event_arg_subdev *esd = (struct xrt_event_arg_subdev *)arg;
+
+	ucs = platform_get_drvdata(pdev);
+
+	switch (evt) {
+	case XRT_EVENT_POST_CREATION:
+		break;
+	default:
+		xrt_info(pdev, "ignored event %d", evt);
+		return XRT_EVENT_CB_CONTINUE;
+	}
+
+	leaf = xrt_subdev_get_leaf_by_id(pdev,
+		XRT_SUBDEV_CLOCK, esd->xevt_subdev_instance);
+	BUG_ON(!leaf);
+	xrt_subdev_ioctl(leaf, XRT_CLOCK_VERIFY, NULL);
+	xrt_subdev_put_leaf(pdev, leaf);
+
+	return XRT_EVENT_CB_CONTINUE;
+}
+
+static void ucs_check(struct xrt_ucs *ucs, bool *latched)
+{
+	struct ucs_control_status_ch1 *ucs_status_ch1;
+	u32 status;
+
+	mutex_lock(&ucs->ucs_lock);
+	status = reg_rd(ucs, CHANNEL1_OFFSET);
+	ucs_status_ch1 = (struct ucs_control_status_ch1 *)&status;
+	if (ucs_status_ch1->shutdown_clocks_latched) {
+		UCS_ERR(ucs, "Critical temperature or power event, kernel clocks have been stopped, run 'xbutil valiate -q' to continue. See AR 73398 for more details.");
+		/* explicitly indicate reset should be latched */
+		*latched = true;
+	} else if (ucs_status_ch1->clock_throttling_average >
+	    CLK_MAX_VALUE) {
+		UCS_ERR(ucs, "kernel clocks %d exceeds expected maximum value %d.",
+			ucs_status_ch1->clock_throttling_average,
+			CLK_MAX_VALUE);
+	} else if (ucs_status_ch1->clock_throttling_average) {
+		UCS_ERR(ucs, "kernel clocks throttled at %d%%.",
+			(ucs_status_ch1->clock_throttling_average /
+			 (CLK_MAX_VALUE / 100)));
+	}
+	mutex_unlock(&ucs->ucs_lock);
+}
+
+static void ucs_enable(struct xrt_ucs *ucs)
+{
+	reg_wr(ucs, 1, CHANNEL2_OFFSET);
+}
+
+static int
+xrt_ucs_leaf_ioctl(struct platform_device *pdev, u32 cmd, void *arg)
+{
+	struct xrt_ucs		*ucs;
+	int			ret = 0;
+
+	ucs = platform_get_drvdata(pdev);
+
+	switch (cmd) {
+	case XRT_UCS_CHECK: {
+		ucs_check(ucs, (bool *)arg);
+		break;
+	}
+	case XRT_UCS_ENABLE:
+		ucs_enable(ucs);
+		break;
+	default:
+		xrt_err(pdev, "unsupported cmd %d", cmd);
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+static int ucs_remove(struct platform_device *pdev)
+{
+	struct xrt_ucs *ucs;
+
+	ucs = platform_get_drvdata(pdev);
+	if (!ucs) {
+		xrt_err(pdev, "driver data is NULL");
+		return -EINVAL;
+	}
+
+	xrt_subdev_remove_event_cb(pdev, ucs->evt_hdl);
+	if (ucs->ucs_base)
+		iounmap(ucs->ucs_base);
+
+	platform_set_drvdata(pdev, NULL);
+	devm_kfree(&pdev->dev, ucs);
+
+	return 0;
+}
+
+
+
+static int ucs_probe(struct platform_device *pdev)
+{
+	struct xrt_ucs *ucs = NULL;
+	struct resource *res;
+	int ret;
+
+	ucs = devm_kzalloc(&pdev->dev, sizeof(*ucs), GFP_KERNEL);
+	if (!ucs)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, ucs);
+	ucs->pdev = pdev;
+	mutex_init(&ucs->ucs_lock);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	ucs->ucs_base = ioremap(res->start, res->end - res->start + 1);
+	if (!ucs->ucs_base) {
+		UCS_ERR(ucs, "map base %pR failed", res);
+		ret = -EFAULT;
+		goto failed;
+	}
+	ucs_enable(ucs);
+	ucs->evt_hdl = xrt_subdev_add_event_cb(pdev, xrt_ucs_leaf_match,
+		NULL, xrt_ucs_event_cb);
+
+	return 0;
+
+failed:
+	ucs_remove(pdev);
+	return ret;
+}
+
+
+struct xrt_subdev_endpoints xrt_ucs_endpoints[] = {
+	{
+		.xse_names = (struct xrt_subdev_ep_names[]) {
+			{ .ep_name = NODE_UCS_CONTROL_STATUS },
+			{ NULL },
+		},
+		.xse_min_ep = 1,
+	},
+	{ 0 },
+};
+
+struct xrt_subdev_drvdata xrt_ucs_data = {
+	.xsd_dev_ops = {
+		.xsd_ioctl = xrt_ucs_leaf_ioctl,
+	},
+};
+
+static const struct platform_device_id xrt_ucs_table[] = {
+	{ XRT_UCS, (kernel_ulong_t)&xrt_ucs_data },
+	{ },
+};
+
+struct platform_driver xrt_ucs_driver = {
+	.driver = {
+		.name = XRT_UCS,
+	},
+	.probe = ucs_probe,
+	.remove = ucs_remove,
+	.id_table = xrt_ucs_table,
+};
diff --git a/drivers/fpga/xrt/lib/subdevs/xrt-vsec.c b/drivers/fpga/xrt/lib/subdevs/xrt-vsec.c
new file mode 100644
index 000000000000..0ed9e1124588
--- /dev/null
+++ b/drivers/fpga/xrt/lib/subdevs/xrt-vsec.c
@@ -0,0 +1,337 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx Alveo FPGA VSEC Driver
+ *
+ * Copyright (C) 2020 Xilinx, Inc.
+ *
+ * Authors:
+ *      Lizhi Hou<Lizhi.Hou@xilinx.com>
+ */
+
+#include <linux/platform_device.h>
+#include "metadata.h"
+#include "subdev.h"
+
+#define XRT_VSEC "xrt_vsec"
+
+#define VSEC_TYPE_UUID		0x50
+#define VSEC_TYPE_FLASH		0x51
+#define VSEC_TYPE_PLATINFO	0x52
+#define VSEC_TYPE_MAILBOX	0x53
+#define VSEC_TYPE_END		0xff
+
+#define VSEC_UUID_LEN		16
+
+struct xrt_vsec_header {
+	u32		format;
+	u32		length;
+	u32		entry_sz;
+	u32		rsvd;
+} __packed;
+
+#define head_rd(g, r)			\
+	ioread32(&((struct xrt_vsec_header *)g->base)->r)
+
+#define GET_BAR(entry)	((entry->bar_rev >> 4) & 0xf)
+#define GET_BAR_OFF(entry)	(entry->off_lo | ((u64)entry->off_hi << 16))
+#define GET_REV(entry)	(entry->bar_rev & 0xf)
+
+struct xrt_vsec_entry {
+	u8		type;
+	u8		bar_rev;
+	u16		off_lo;
+	u32		off_hi;
+	u8		ver_type;
+	u8		minor;
+	u8		major;
+	u8		rsvd0;
+	u32		rsvd1;
+} __packed;
+
+#define read_entry(g, i, e)					\
+	do {							\
+		u32 *p = (u32 *)(g->base +			\
+			sizeof(struct xrt_vsec_header) +	\
+			i * sizeof(struct xrt_vsec_entry));	\
+		u32 off;					\
+		for (off = 0;					\
+		    off < sizeof(struct xrt_vsec_entry) / 4;	\
+		    off++)					\
+			*((u32 *)(e) + off) = ioread32(p + off);\
+	} while (0)
+
+struct vsec_device {
+	u8		type;
+	char		*ep_name;
+	ulong		size;
+	char		*regmap;
+};
+
+static struct vsec_device vsec_devs[] = {
+	{
+		.type = VSEC_TYPE_UUID,
+		.ep_name = NODE_BLP_ROM,
+		.size = VSEC_UUID_LEN,
+		.regmap = "vsec-uuid",
+	},
+	{
+		.type = VSEC_TYPE_FLASH,
+		.ep_name = NODE_FLASH_VSEC,
+		.size = 4096,
+		.regmap = "vsec-flash",
+	},
+	{
+		.type = VSEC_TYPE_PLATINFO,
+		.ep_name = NODE_PLAT_INFO,
+		.size = 4,
+		.regmap = "vsec-platinfo",
+	},
+	{
+		.type = VSEC_TYPE_MAILBOX,
+		.ep_name = NODE_MAILBOX_VSEC,
+		.size = 48,
+		.regmap = "vsec-mbx",
+	},
+};
+
+struct xrt_vsec {
+	struct platform_device	*pdev;
+	void			*base;
+	ulong			length;
+
+	char			*metadata;
+	char			uuid[VSEC_UUID_LEN];
+};
+
+static char *type2epname(u32 type)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(vsec_devs); i++) {
+		if (vsec_devs[i].type == type)
+			return (vsec_devs[i].ep_name);
+	}
+
+	return NULL;
+}
+
+static ulong type2size(u32 type)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(vsec_devs); i++) {
+		if (vsec_devs[i].type == type)
+			return (vsec_devs[i].size);
+	}
+
+	return 0;
+}
+
+static char *type2regmap(u32 type)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(vsec_devs); i++) {
+		if (vsec_devs[i].type == type)
+			return (vsec_devs[i].regmap);
+	}
+
+	return NULL;
+}
+
+static int xrt_vsec_add_node(struct xrt_vsec *vsec,
+	void *md_blob, struct xrt_vsec_entry *p_entry)
+{
+	struct xrt_md_endpoint ep;
+	char regmap_ver[64];
+	int ret;
+
+	if (!type2epname(p_entry->type))
+		return -EINVAL;
+
+	/*
+	 * VSEC may have more than 1 mailbox instance for the card
+	 * which has more than 1 physical function.
+	 * This is not supported for now. Assuming only one mailbox
+	 */
+
+	snprintf(regmap_ver, sizeof(regmap_ver) - 1, "%d-%d.%d.%d",
+		p_entry->ver_type, p_entry->major, p_entry->minor,
+		GET_REV(p_entry));
+	ep.ep_name = type2epname(p_entry->type);
+	ep.bar = GET_BAR(p_entry);
+	ep.bar_off = GET_BAR_OFF(p_entry);
+	ep.size = type2size(p_entry->type);
+	ep.regmap = type2regmap(p_entry->type);
+	ep.regmap_ver = regmap_ver;
+	ret = xrt_md_add_endpoint(DEV(vsec->pdev), vsec->metadata, &ep);
+	if (ret) {
+		xrt_err(vsec->pdev, "add ep failed, ret %d", ret);
+		goto failed;
+	}
+
+failed:
+	return ret;
+}
+
+static int xrt_vsec_create_metadata(struct xrt_vsec *vsec)
+{
+	struct xrt_vsec_entry entry;
+	int i, ret;
+
+	ret = xrt_md_create(&vsec->pdev->dev, &vsec->metadata);
+	if (ret) {
+		xrt_err(vsec->pdev, "create metadata failed");
+		return ret;
+	}
+
+	for (i = 0; i * sizeof(entry) < vsec->length -
+	    sizeof(struct xrt_vsec_header); i++) {
+		read_entry(vsec, i, &entry);
+		xrt_vsec_add_node(vsec, vsec->metadata, &entry);
+	}
+
+	return 0;
+}
+
+static int xrt_vsec_ioctl(struct platform_device *pdev, u32 cmd, void *arg)
+{
+	return 0;
+}
+
+static int xrt_vsec_mapio(struct xrt_vsec *vsec)
+{
+	struct xrt_subdev_platdata *pdata = DEV_PDATA(vsec->pdev);
+	const u32 *bar;
+	const u64 *bar_off;
+	struct resource *res = NULL;
+	ulong addr;
+	int ret;
+
+	if (!pdata || xrt_md_size(DEV(vsec->pdev), pdata->xsp_dtb) <= 0) {
+		xrt_err(vsec->pdev, "empty metadata");
+		return -EINVAL;
+	}
+
+	ret = xrt_md_get_prop(DEV(vsec->pdev), pdata->xsp_dtb, NODE_VSEC,
+		NULL, PROP_BAR_IDX, (const void **)&bar, NULL);
+	if (ret) {
+		xrt_err(vsec->pdev, "failed to get bar idx, ret %d", ret);
+		return -EINVAL;
+	}
+
+	ret = xrt_md_get_prop(DEV(vsec->pdev), pdata->xsp_dtb, NODE_VSEC,
+		NULL, PROP_OFFSET, (const void **)&bar_off, NULL);
+	if (ret) {
+		xrt_err(vsec->pdev, "failed to get bar off, ret %d", ret);
+		return -EINVAL;
+	}
+
+	xrt_info(vsec->pdev, "Map vsec at bar %d, offset 0x%llx",
+		be32_to_cpu(*bar), be64_to_cpu(*bar_off));
+
+	xrt_subdev_get_barres(vsec->pdev, &res, be32_to_cpu(*bar));
+	if (!res) {
+		xrt_err(vsec->pdev, "failed to get bar addr");
+		return -EINVAL;
+	}
+
+	addr = res->start + (ulong)be64_to_cpu(*bar_off);
+
+	vsec->base = ioremap(addr, sizeof(struct xrt_vsec_header));
+	if (!vsec->base) {
+		xrt_err(vsec->pdev, "Map header failed");
+		return -EIO;
+	}
+
+	vsec->length = head_rd(vsec, length);
+	iounmap(vsec->base);
+	vsec->base = ioremap(addr, vsec->length);
+	if (!vsec->base) {
+		xrt_err(vsec->pdev, "map failed");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int xrt_vsec_remove(struct platform_device *pdev)
+{
+	struct xrt_vsec	*vsec;
+
+	vsec = platform_get_drvdata(pdev);
+
+	if (vsec->base) {
+		iounmap(vsec->base);
+		vsec->base = NULL;
+	}
+
+	vfree(vsec->metadata);
+
+	return 0;
+}
+
+static int xrt_vsec_probe(struct platform_device *pdev)
+{
+	struct xrt_vsec	*vsec;
+	int			ret = 0;
+
+	vsec = devm_kzalloc(&pdev->dev, sizeof(*vsec), GFP_KERNEL);
+	if (!vsec)
+		return -ENOMEM;
+
+	vsec->pdev = pdev;
+	platform_set_drvdata(pdev, vsec);
+
+	ret = xrt_vsec_mapio(vsec);
+	if (ret)
+		goto failed;
+
+	ret = xrt_vsec_create_metadata(vsec);
+	if (ret) {
+		xrt_err(pdev, "create metadata failed, ret %d", ret);
+		goto failed;
+	}
+	ret = xrt_subdev_create_partition(pdev, vsec->metadata);
+	if (ret < 0)
+		xrt_err(pdev, "create partition failed, ret %d", ret);
+	else
+		ret = 0;
+
+failed:
+	if (ret)
+		xrt_vsec_remove(pdev);
+
+	return ret;
+}
+
+struct xrt_subdev_endpoints xrt_vsec_endpoints[] = {
+	{
+		.xse_names = (struct xrt_subdev_ep_names []){
+			{ .ep_name = NODE_VSEC },
+			{ NULL },
+		},
+		.xse_min_ep = 1,
+	},
+	{ 0 },
+};
+
+struct xrt_subdev_drvdata xrt_vsec_data = {
+	.xsd_dev_ops = {
+		.xsd_ioctl = xrt_vsec_ioctl,
+	},
+};
+
+static const struct platform_device_id xrt_vsec_table[] = {
+	{ XRT_VSEC, (kernel_ulong_t)&xrt_vsec_data },
+	{ },
+};
+
+struct platform_driver xrt_vsec_driver = {
+	.driver = {
+		.name = XRT_VSEC,
+	},
+	.probe = xrt_vsec_probe,
+	.remove = xrt_vsec_remove,
+	.id_table = xrt_vsec_table,
+};
-- 
2.17.1


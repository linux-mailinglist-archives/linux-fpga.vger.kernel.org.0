Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34D542C76BE
	for <lists+linux-fpga@lfdr.de>; Sun, 29 Nov 2020 01:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729393AbgK2ADs (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 28 Nov 2020 19:03:48 -0500
Received: from mail-dm6nam12on2063.outbound.protection.outlook.com ([40.107.243.63]:57057
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725852AbgK2ADs (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sat, 28 Nov 2020 19:03:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PdBV1Ne275b4bYrdwWRpQyfKOFu/ZyrL0/fx+V+Fu5TFXJKDxJ4vj/t8PNkbfLK2OeEfxGBDfHRx9ZfMYUZP+kzwsZQ3hvJ0d5yDDSV6jugT6Ba8nepGrgPka+dqG0vKTXCJtLrfpGMD2QNJgIXNGYV55gueE2TrJaoiLD7/S2chWVcKYbSGg+wPRpyzYXmuBL52u6zHMTPyO3+SSxvuNn5sYpiKTYfi6sX4OK1wa5m+mpYzGFRXXFOrGM1UI4sM8G24rcge4IIHCO2JMXqmX45Keo+8bWD6nWp0kwk8zSTSam5jXMCR8Mj6u1Z5wGlvvCPAoDA5cwyRV88yOhFY+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Go92kA20/T0owYpJ0EJI2VAx7sm+Dc4yEnq1eKkYVHI=;
 b=ck/m88AtmgdqXwyNMBfms0PpMH3wqVl4s04q2mX2jzOVILotFS2F2D6+p9BYuSZWpvX5NvYDYrSUya39XfqBlfS6jAii0DqfKI34dQP1qsuyUS2ncy1NSATTrp0i186WJgHlx90OpB1kpaBZV+2n5iQEMT2uokfq+pK9+SdK0/3+BMgdO6sL+lYqs6DScOM6VujKzr5rSuL+GeuEHHwjaOFk6ABamhIWG/qlKM+oUNgbgsC980+WSOWEHrsknJYShKyJsMAPXfMqCOYwDkY9hrsgJq7w/3QjsTSir8ZrwvsV4deSbxv84oV91PJtVKlwcxwKPoGDMhA5FvUEuf9/CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Go92kA20/T0owYpJ0EJI2VAx7sm+Dc4yEnq1eKkYVHI=;
 b=mtB8SO6IrnjgKNsYix2WpGmc7MwFMJtcbBN2sy2BXjqMp5p772xW3C9D25GrFZymtpm3OJ79QD+hAEbhqo9ox/D0ScitG5HcYIv/tElvw4WaF5PbfHfnKl4M629gObQ/8Ll5Hwr6r8qe2Upojn4QMPj5jdRXftnde1gFt7ewFP0=
Received: from SN4PR0401CA0019.namprd04.prod.outlook.com
 (2603:10b6:803:21::29) by CY4PR02MB2726.namprd02.prod.outlook.com
 (2603:10b6:903:124::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Sun, 29 Nov
 2020 00:02:51 +0000
Received: from SN1NAM02FT038.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:21:cafe::6c) by SN4PR0401CA0019.outlook.office365.com
 (2603:10b6:803:21::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend
 Transport; Sun, 29 Nov 2020 00:02:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT038.mail.protection.outlook.com (10.152.72.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3611.27 via Frontend Transport; Sun, 29 Nov 2020 00:02:51 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Sat, 28 Nov 2020 16:02:51 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Sat, 28 Nov 2020 16:02:51 -0800
Envelope-to: michal.simek@xilinx.com,
 sonal.santan@xilinx.com,
 lizhih@xilinx.com,
 maxz@xilinx.com,
 stefanos@xilinx.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.72.212] (port=45058 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <sonal.santan@xilinx.com>)
        id 1kjAB1-0000K5-1q; Sat, 28 Nov 2020 16:02:51 -0800
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 6354)
        id 48716600115; Sat, 28 Nov 2020 16:00:45 -0800 (PST)
From:   Sonal Santan <sonal.santan@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Sonal Santan <sonal.santan@xilinx.com>,
        <linux-fpga@vger.kernel.org>, <maxz@xilinx.com>,
        <lizhih@xilinx.com>, <michal.simek@xilinx.com>,
        <stefanos@xilinx.com>, <devicetree@vger.kernel.org>
Subject: [PATCH Xilinx Alveo 6/8] fpga: xrt: header file for platform and parent drivers
Date:   Sat, 28 Nov 2020 16:00:38 -0800
Message-ID: <20201129000040.24777-7-sonals@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201129000040.24777-1-sonals@xilinx.com>
References: <20201129000040.24777-1-sonals@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab761466-affd-47b1-70ec-08d893fa1d61
X-MS-TrafficTypeDiagnostic: CY4PR02MB2726:
X-Microsoft-Antispam-PRVS: <CY4PR02MB2726510B03066BB7B78BD67BBBF60@CY4PR02MB2726.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zyp2PZhxLy09OVhPiKJ+b4pZAbizmgYQrAruZETPxWTqi7L9SQX2u40nV4qrw6u/9VbxCGhqHKu44WY5qBtMcdJRi9E+3zyP5UoT/6E0IuKLl7A1jUZVBais2Iv/21wfwuz1E5w1RxkOZbVY+fOft3xHmYKYvQUwGiCWVqZMZpbfcuwqHdr5DyKTv5yjTIUK2Fcjl2x1e+BeyX1WOaURO++ijMxWv35Dx3CdYz/F4sPKhpVhO/BPxfOz1ZIiqZ3oBEqqF7XJ5fd3R4bFNPgIXwx/+w3wDYoK2cXUBhcdzjHiwqfs/rlWedw+9H53UYrEEDfzZYqGerCFyn7duXLCHLMydP9keTpSVmXfodW0grsa3VQt/LI/fscRr8YqpyaQmGh0JvmJYQB5RhCIXdHoHg==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(346002)(376002)(39850400004)(136003)(396003)(46966005)(70206006)(82310400003)(26005)(70586007)(6266002)(478600001)(5660300002)(336012)(2616005)(4326008)(30864003)(186003)(83380400001)(36756003)(426003)(356005)(44832011)(1076003)(8936002)(450100002)(8676002)(7636003)(82740400003)(47076004)(6666004)(6916009)(316002)(54906003)(42186006)(2906002)(36906005);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2020 00:02:51.6157
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab761466-affd-47b1-70ec-08d893fa1d61
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT038.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2726
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Sonal Santan <sonal.santan@xilinx.com>

Add private header files for platform and parent drivers.
Each header file defines ioctls supported by the platform
or parent driver. The header files also define core data
structures for sending and receiving events by platform
and parent drivers.

Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
---
 drivers/fpga/alveo/include/xmgmt-main.h    |  34 +++
 drivers/fpga/alveo/include/xrt-axigate.h   |  31 ++
 drivers/fpga/alveo/include/xrt-calib.h     |  28 ++
 drivers/fpga/alveo/include/xrt-clkfreq.h   |  21 ++
 drivers/fpga/alveo/include/xrt-clock.h     |  29 ++
 drivers/fpga/alveo/include/xrt-cmc.h       |  23 ++
 drivers/fpga/alveo/include/xrt-ddr-srsr.h  |  29 ++
 drivers/fpga/alveo/include/xrt-flash.h     |  28 ++
 drivers/fpga/alveo/include/xrt-gpio.h      |  41 +++
 drivers/fpga/alveo/include/xrt-icap.h      |  27 ++
 drivers/fpga/alveo/include/xrt-mailbox.h   |  44 +++
 drivers/fpga/alveo/include/xrt-metadata.h  | 184 ++++++++++++
 drivers/fpga/alveo/include/xrt-parent.h    | 103 +++++++
 drivers/fpga/alveo/include/xrt-partition.h |  33 ++
 drivers/fpga/alveo/include/xrt-subdev.h    | 333 +++++++++++++++++++++
 drivers/fpga/alveo/include/xrt-ucs.h       |  22 ++
 16 files changed, 1010 insertions(+)
 create mode 100644 drivers/fpga/alveo/include/xmgmt-main.h
 create mode 100644 drivers/fpga/alveo/include/xrt-axigate.h
 create mode 100644 drivers/fpga/alveo/include/xrt-calib.h
 create mode 100644 drivers/fpga/alveo/include/xrt-clkfreq.h
 create mode 100644 drivers/fpga/alveo/include/xrt-clock.h
 create mode 100644 drivers/fpga/alveo/include/xrt-cmc.h
 create mode 100644 drivers/fpga/alveo/include/xrt-ddr-srsr.h
 create mode 100644 drivers/fpga/alveo/include/xrt-flash.h
 create mode 100644 drivers/fpga/alveo/include/xrt-gpio.h
 create mode 100644 drivers/fpga/alveo/include/xrt-icap.h
 create mode 100644 drivers/fpga/alveo/include/xrt-mailbox.h
 create mode 100644 drivers/fpga/alveo/include/xrt-metadata.h
 create mode 100644 drivers/fpga/alveo/include/xrt-parent.h
 create mode 100644 drivers/fpga/alveo/include/xrt-partition.h
 create mode 100644 drivers/fpga/alveo/include/xrt-subdev.h
 create mode 100644 drivers/fpga/alveo/include/xrt-ucs.h

diff --git a/drivers/fpga/alveo/include/xmgmt-main.h b/drivers/fpga/alveo/include/xmgmt-main.h
new file mode 100644
index 000000000000..3f26c480ce27
--- /dev/null
+++ b/drivers/fpga/alveo/include/xmgmt-main.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020 Xilinx, Inc.
+ *
+ * Authors:
+ *	Cheng Zhen <maxz@xilinx.com>
+ */
+
+#ifndef	_XMGMT_MAIN_H_
+#define	_XMGMT_MAIN_H_
+
+#include <linux/xrt/xclbin.h>
+
+enum xrt_mgmt_main_ioctl_cmd {
+	// section needs to be vfree'd by caller
+	XRT_MGMT_MAIN_GET_AXLF_SECTION = 0,
+	// vbnv needs to be kfree'd by caller
+	XRT_MGMT_MAIN_GET_VBNV,
+};
+
+enum provider_kind {
+	XMGMT_BLP,
+	XMGMT_PLP,
+	XMGMT_ULP,
+};
+
+struct xrt_mgmt_main_ioctl_get_axlf_section {
+	enum provider_kind xmmigas_axlf_kind;
+	enum axlf_section_kind xmmigas_section_kind;
+	void *xmmigas_section;
+	u64 xmmigas_section_size;
+};
+
+#endif	/* _XMGMT_MAIN_H_ */
diff --git a/drivers/fpga/alveo/include/xrt-axigate.h b/drivers/fpga/alveo/include/xrt-axigate.h
new file mode 100644
index 000000000000..b1dd70546040
--- /dev/null
+++ b/drivers/fpga/alveo/include/xrt-axigate.h
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
+#include "xrt-subdev.h"
+#include "xrt-metadata.h"
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
diff --git a/drivers/fpga/alveo/include/xrt-calib.h b/drivers/fpga/alveo/include/xrt-calib.h
new file mode 100644
index 000000000000..5e5bb5cec285
--- /dev/null
+++ b/drivers/fpga/alveo/include/xrt-calib.h
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
+#include "xrt-subdev.h"
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
diff --git a/drivers/fpga/alveo/include/xrt-clkfreq.h b/drivers/fpga/alveo/include/xrt-clkfreq.h
new file mode 100644
index 000000000000..60e4109cc05a
--- /dev/null
+++ b/drivers/fpga/alveo/include/xrt-clkfreq.h
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
+#include "xrt-subdev.h"
+
+/*
+ * CLKFREQ driver IOCTL calls.
+ */
+enum xrt_clkfreq_ioctl_cmd {
+	XRT_CLKFREQ_READ = 0,
+};
+
+#endif	/* _XRT_CLKFREQ_H_ */
diff --git a/drivers/fpga/alveo/include/xrt-clock.h b/drivers/fpga/alveo/include/xrt-clock.h
new file mode 100644
index 000000000000..d98d9d619bb2
--- /dev/null
+++ b/drivers/fpga/alveo/include/xrt-clock.h
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
+#include "xrt-subdev.h"
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
diff --git a/drivers/fpga/alveo/include/xrt-cmc.h b/drivers/fpga/alveo/include/xrt-cmc.h
new file mode 100644
index 000000000000..f2bb61a2ab23
--- /dev/null
+++ b/drivers/fpga/alveo/include/xrt-cmc.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020 Xilinx, Inc.
+ *
+ * Authors:
+ *	Cheng Zhen <maxz@xilinx.com>
+ */
+
+#ifndef	_XRT_CMC_H_
+#define	_XRT_CMC_H_
+
+#include "xrt-subdev.h"
+#include <linux/xrt/xclbin.h>
+
+/*
+ * CMC driver IOCTL calls.
+ */
+enum xrt_cmc_ioctl_cmd {
+	XRT_CMC_READ_BOARD_INFO = 0,
+	XRT_CMC_READ_SENSORS,
+};
+
+#endif	/* _XRT_CMC_H_ */
diff --git a/drivers/fpga/alveo/include/xrt-ddr-srsr.h b/drivers/fpga/alveo/include/xrt-ddr-srsr.h
new file mode 100644
index 000000000000..56dc2ff8ea7c
--- /dev/null
+++ b/drivers/fpga/alveo/include/xrt-ddr-srsr.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020 Xilinx, Inc.
+ *
+ * Authors:
+ *      Lizhi Hou <Lizhi.Hou@xilinx.com>
+ */
+
+#ifndef _XRT_DDR_SRSR_H_
+#define _XRT_DDR_SRSR_H_
+
+#include "xrt-subdev.h"
+
+/*
+ * ddr-srsr driver IOCTL calls.
+ */
+enum xrt_ddr_srsr_ioctl_cmd {
+	XRT_SRSR_FAST_CALIB,
+	XRT_SRSR_CALIB,
+	XRT_SRSR_EP_NAME,
+};
+
+struct xrt_srsr_ioctl_calib {
+	void	*xsic_buf;
+	u32	xsic_size;
+	bool	xsic_retention;
+};
+
+#endif
diff --git a/drivers/fpga/alveo/include/xrt-flash.h b/drivers/fpga/alveo/include/xrt-flash.h
new file mode 100644
index 000000000000..949f490a3154
--- /dev/null
+++ b/drivers/fpga/alveo/include/xrt-flash.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020 Xilinx, Inc.
+ *
+ * Authors:
+ *	Cheng Zhen <maxz@xilinx.com>
+ */
+
+#ifndef	_XRT_FLASH_H_
+#define	_XRT_FLASH_H_
+
+#include "xrt-subdev.h"
+
+/*
+ * Flash controller driver IOCTL calls.
+ */
+enum xrt_flash_ioctl_cmd {
+	XRT_FLASH_GET_SIZE = 0,
+	XRT_FLASH_READ,
+};
+
+struct xrt_flash_ioctl_read {
+	char *xfir_buf;
+	size_t xfir_size;
+	loff_t xfir_offset;
+};
+
+#endif	/* _XRT_FLASH_H_ */
diff --git a/drivers/fpga/alveo/include/xrt-gpio.h b/drivers/fpga/alveo/include/xrt-gpio.h
new file mode 100644
index 000000000000..d85a356f5281
--- /dev/null
+++ b/drivers/fpga/alveo/include/xrt-gpio.h
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
+#include "xrt-subdev.h"
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
diff --git a/drivers/fpga/alveo/include/xrt-icap.h b/drivers/fpga/alveo/include/xrt-icap.h
new file mode 100644
index 000000000000..ea9e688e07eb
--- /dev/null
+++ b/drivers/fpga/alveo/include/xrt-icap.h
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
+#include "xrt-subdev.h"
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
diff --git a/drivers/fpga/alveo/include/xrt-mailbox.h b/drivers/fpga/alveo/include/xrt-mailbox.h
new file mode 100644
index 000000000000..cfa7e112c51b
--- /dev/null
+++ b/drivers/fpga/alveo/include/xrt-mailbox.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020 Xilinx, Inc.
+ *
+ * Authors:
+ *	Cheng Zhen <maxz@xilinx.com>
+ */
+
+#ifndef	_XRT_MAILBOX_H_
+#define	_XRT_MAILBOX_H_
+
+/*
+ * Mailbox IP driver IOCTL calls.
+ */
+enum xrt_mailbox_ioctl_cmd {
+	XRT_MAILBOX_POST = 0,
+	XRT_MAILBOX_REQUEST,
+	XRT_MAILBOX_LISTEN,
+};
+
+struct xrt_mailbox_ioctl_post {
+	u64 xmip_req_id; /* 0 means response */
+	bool xmip_sw_ch;
+	void *xmip_data;
+	size_t xmip_data_size;
+};
+
+struct xrt_mailbox_ioctl_request {
+	bool xmir_sw_ch;
+	u32 xmir_resp_ttl;
+	void *xmir_req;
+	size_t xmir_req_size;
+	void *xmir_resp;
+	size_t xmir_resp_size;
+};
+
+typedef	void (*mailbox_msg_cb_t)(void *arg, void *data, size_t len,
+	u64 msgid, int err, bool sw_ch);
+struct xrt_mailbox_ioctl_listen {
+	mailbox_msg_cb_t xmil_cb;
+	void *xmil_cb_arg;
+};
+
+#endif	/* _XRT_MAILBOX_H_ */
diff --git a/drivers/fpga/alveo/include/xrt-metadata.h b/drivers/fpga/alveo/include/xrt-metadata.h
new file mode 100644
index 000000000000..f445bfc279d2
--- /dev/null
+++ b/drivers/fpga/alveo/include/xrt-metadata.h
@@ -0,0 +1,184 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Xilinx Alveo FPGA Test Leaf Driver
+ *
+ * Copyright (C) 2020 Xilinx, Inc.
+ *
+ * Authors:
+ *      Lizhi Hou <Lizhi.Hou@xilinx.com>
+ */
+
+#ifndef _XRT_METADATA_H
+#define _XRT_METADATA_H
+
+#include <linux/device.h>
+#include <linux/vmalloc.h>
+#include <linux/uuid.h>
+
+#define PROP_COMPATIBLE "compatible"
+#define PROP_PF_NUM "pcie_physical_function"
+#define PROP_BAR_IDX "pcie_bar_mapping"
+#define PROP_IO_OFFSET "reg"
+#define PROP_INTERRUPTS "interrupts"
+#define PROP_INTERFACE_UUID "interface_uuid"
+#define PROP_LOGIC_UUID "logic_uuid"
+#define PROP_VERSION_MAJOR "firmware_version_major"
+
+#define PROP_HWICAP "axi_hwicap"
+#define PROP_PDI_CONFIG "pdi_config_mem"
+
+#define NODE_ENDPOINTS "addressable_endpoints"
+#define INTERFACES_PATH "/interfaces"
+
+#define NODE_FIRMWARE "firmware"
+#define NODE_INTERFACES "interfaces"
+#define NODE_PARTITION_INFO "partition_info"
+
+#define NODE_FLASH "ep_card_flash_program_00"
+#define NODE_XVC_PUB "ep_debug_bscan_user_00"
+#define NODE_XVC_PRI "ep_debug_bscan_mgmt_00"
+#define NODE_SYSMON "ep_cmp_sysmon_00"
+#define NODE_AF_BLP_CTRL_MGMT "ep_firewall_blp_ctrl_mgmt_00"
+#define NODE_AF_BLP_CTRL_USER "ep_firewall_blp_ctrl_user_00"
+#define NODE_AF_CTRL_MGMT "ep_firewall_ctrl_mgmt_00"
+#define NODE_AF_CTRL_USER "ep_firewall_ctrl_user_00"
+#define NODE_AF_CTRL_DEBUG "ep_firewall_ctrl_debug_00"
+#define NODE_AF_DATA_H2C "ep_firewall_data_h2c_00"
+#define NODE_AF_DATA_C2H "ep_firewall_data_c2h_00"
+#define NODE_AF_DATA_P2P "ep_firewall_data_p2p_00"
+#define NODE_AF_DATA_M2M "ep_firewall_data_m2m_00"
+#define NODE_CMC_REG "ep_cmc_regmap_00"
+#define NODE_CMC_RESET "ep_cmc_reset_00"
+#define NODE_CMC_MUTEX "ep_cmc_mutex_00"
+#define NODE_CMC_FW_MEM "ep_cmc_firmware_mem_00"
+#define NODE_ERT_FW_MEM "ep_ert_firmware_mem_00"
+#define NODE_ERT_CQ_MGMT "ep_ert_command_queue_mgmt_00"
+#define NODE_ERT_CQ_USER "ep_ert_command_queue_user_00"
+#define NODE_MAILBOX_MGMT "ep_mailbox_mgmt_00"
+#define NODE_MAILBOX_USER "ep_mailbox_user_00"
+#define NODE_GATE_PLP "ep_pr_isolate_plp_00"
+#define NODE_GATE_ULP "ep_pr_isolate_ulp_00"
+#define NODE_PCIE_MON "ep_pcie_link_mon_00"
+#define NODE_DDR_CALIB "ep_ddr_mem_calib_00"
+#define NODE_CLK_KERNEL1 "ep_aclk_kernel_00"
+#define NODE_CLK_KERNEL2 "ep_aclk_kernel_01"
+#define NODE_CLK_KERNEL3 "ep_aclk_hbm_00"
+#define NODE_KDMA_CTRL "ep_kdma_ctrl_00"
+#define NODE_FPGA_CONFIG "ep_fpga_configuration_00"
+#define NODE_ERT_SCHED "ep_ert_sched_00"
+#define NODE_XDMA "ep_xdma_00"
+#define NODE_MSIX "ep_msix_00"
+#define NODE_QDMA "ep_qdma_00"
+#define NODE_QDMA4 "ep_qdma4_00"
+#define NODE_STM "ep_stream_traffic_manager_00"
+#define NODE_STM4 "ep_stream_traffic_manager4_00"
+#define NODE_CLK_SHUTDOWN "ep_aclk_shutdown_00"
+#define NODE_ERT_BASE "ep_ert_base_address_00"
+#define NODE_ERT_RESET "ep_ert_reset_00"
+#define NODE_CLKFREQ_K1 "ep_freq_cnt_aclk_kernel_00"
+#define NODE_CLKFREQ_K2 "ep_freq_cnt_aclk_kernel_01"
+#define NODE_CLKFREQ_HBM "ep_freq_cnt_aclk_hbm_00"
+#define NODE_GAPPING "ep_gapping_demand_00"
+#define NODE_UCS_CONTROL_STATUS "ep_ucs_control_status_00"
+#define NODE_P2P "ep_p2p_00"
+#define NODE_REMAP_P2P "ep_remap_p2p_00"
+#define NODE_DDR4_RESET_GATE "ep_ddr_mem_srsr_gate_00"
+#define NODE_ADDR_TRANSLATOR "ep_remap_data_c2h_00"
+#define NODE_MAILBOX_XRT "ep_mailbox_user_to_ert_00"
+#define NODE_PMC_INTR   "ep_pmc_intr_00"
+#define NODE_PMC_MUX    "ep_pmc_mux_00"
+
+/* driver defined endpoints */
+#define NODE_VSEC "drv_ep_vsec_00"
+#define NODE_VSEC_GOLDEN "drv_ep_vsec_golden_00"
+#define NODE_BLP_ROM "drv_ep_blp_rom_00"
+#define NODE_MAILBOX_VSEC "ep_mailbox_vsec_00"
+#define NODE_PLAT_INFO "drv_ep_platform_info_mgmt_00"
+#define NODE_TEST "drv_ep_test_00"
+#define NODE_MGMT_MAIN "drv_ep_mgmt_main_00"
+#define NODE_FLASH_VSEC "drv_ep_card_flash_program_00"
+#define NODE_GOLDEN_VER "drv_ep_golden_ver_00"
+#define NODE_PARTITION_INFO_BLP "partition_info_0"
+#define NODE_PARTITION_INFO_PLP "partition_info_1"
+
+#define NODE_DDR_SRSR "drv_ep_ddr_srsr"
+#define REGMAP_DDR_SRSR "drv_ddr_srsr"
+
+#define PROP_OFFSET "drv_offset"
+#define PROP_CLK_FREQ "drv_clock_frequency"
+#define PROP_CLK_CNT "drv_clock_frequency_counter"
+#define	PROP_VBNV "vbnv"
+#define	PROP_VROM "vrom"
+#define PROP_PARTITION_LEVEL "partition_level"
+
+struct xrt_md_endpoint {
+	const char	*ep_name;
+	u32		bar;
+	long		bar_off;
+	ulong		size;
+	char		*regmap;
+	char		*regmap_ver;
+};
+
+/* Note: res_id is defined by leaf driver and must start with 0. */
+struct xrt_iores_map {
+	char		*res_name;
+	int		res_id;
+};
+
+static inline int xrt_md_res_name2id(const struct xrt_iores_map *res_map,
+	int entry_num, const char *res_name)
+{
+	int i;
+
+	BUG_ON(res_name == NULL);
+	for (i = 0; i < entry_num; i++) {
+		if (!strcmp(res_name, res_map->res_name))
+			return res_map->res_id;
+		res_map++;
+	}
+	return -1;
+}
+
+static inline const char *
+xrt_md_res_id2name(const struct xrt_iores_map *res_map, int entry_num, int id)
+{
+	int i;
+
+	BUG_ON(id > entry_num);
+	for (i = 0; i < entry_num; i++) {
+		if (res_map->res_id == id)
+			return res_map->res_name;
+		res_map++;
+	}
+	return NULL;
+}
+
+long xrt_md_size(struct device *dev, const char *blob);
+int xrt_md_create(struct device *dev, char **blob);
+int xrt_md_add_endpoint(struct device *dev, char *blob,
+	struct xrt_md_endpoint *ep);
+int xrt_md_del_endpoint(struct device *dev, char *blob, const char *ep_name,
+	char *regmap_name);
+int xrt_md_get_prop(struct device *dev, const char *blob, const char *ep_name,
+	const char *regmap_name, const char *prop, const void **val, int *size);
+int xrt_md_set_prop(struct device *dev, char *blob, const char *ep_name,
+	const char *regmap_name, const char *prop, const void *val, int size);
+int xrt_md_copy_endpoint(struct device *dev, char *blob, const char *src_blob,
+	const char *ep_name, const char *regmap_name, const char *new_ep_name);
+int xrt_md_copy_all_eps(struct device *dev, char  *blob, const char *src_blob);
+int xrt_md_get_next_endpoint(struct device *dev, const char *blob,
+	const char *ep_name,  const char *regmap_name,
+	char **next_ep, char **next_regmap);
+int xrt_md_get_compatible_epname(struct device *dev, const char *blob,
+	const char *regmap_name, const char **ep_name);
+int xrt_md_get_epname_pointer(struct device *dev, const char *blob,
+	const char *ep_name, const char *regmap_name, const char **epname);
+void xrt_md_pack(struct device *dev, char *blob);
+char *xrt_md_dup(struct device *dev, const char *blob);
+int xrt_md_get_intf_uuids(struct device *dev, const char *blob,
+	u32 *num_uuids, uuid_t *intf_uuids);
+int xrt_md_check_uuids(struct device *dev, const char *blob, char *subset_blob);
+int xrt_md_uuid_strtoid(struct device *dev, const char *uuidstr, uuid_t *uuid);
+
+#endif
diff --git a/drivers/fpga/alveo/include/xrt-parent.h b/drivers/fpga/alveo/include/xrt-parent.h
new file mode 100644
index 000000000000..28de117fbf91
--- /dev/null
+++ b/drivers/fpga/alveo/include/xrt-parent.h
@@ -0,0 +1,103 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020 Xilinx, Inc.
+ *
+ * Authors:
+ *	Cheng Zhen <maxz@xilinx.com>
+ */
+
+#ifndef	_XRT_PARENT_H_
+#define	_XRT_PARENT_H_
+
+#include "xrt-subdev.h"
+#include "xrt-partition.h"
+
+/*
+ * Parent IOCTL calls.
+ */
+enum xrt_parent_ioctl_cmd {
+	/* Leaf actions. */
+	XRT_PARENT_GET_LEAF = 0,
+	XRT_PARENT_PUT_LEAF,
+	XRT_PARENT_GET_LEAF_HOLDERS,
+
+	/* Partition actions. */
+	XRT_PARENT_CREATE_PARTITION,
+	XRT_PARENT_REMOVE_PARTITION,
+	XRT_PARENT_LOOKUP_PARTITION,
+	XRT_PARENT_WAIT_PARTITION_BRINGUP,
+
+	/* Event actions. */
+	XRT_PARENT_ADD_EVENT_CB,
+	XRT_PARENT_REMOVE_EVENT_CB,
+	XRT_PARENT_ASYNC_BOARDCAST_EVENT,
+
+	/* Device info. */
+	XRT_PARENT_GET_RESOURCE,
+	XRT_PARENT_GET_ID,
+
+	/* Misc. */
+	XRT_PARENT_HOT_RESET,
+	XRT_PARENT_HWMON,
+};
+
+struct xrt_parent_ioctl_get_leaf {
+	struct platform_device *xpigl_pdev; /* caller's pdev */
+	xrt_subdev_match_t xpigl_match_cb;
+	void *xpigl_match_arg;
+	struct platform_device *xpigl_leaf; /* target leaf pdev */
+};
+
+struct xrt_parent_ioctl_put_leaf {
+	struct platform_device *xpipl_pdev; /* caller's pdev */
+	struct platform_device *xpipl_leaf; /* target's pdev */
+};
+
+struct xrt_parent_ioctl_lookup_partition {
+	struct platform_device *xpilp_pdev; /* caller's pdev */
+	xrt_subdev_match_t xpilp_match_cb;
+	void *xpilp_match_arg;
+	int xpilp_part_inst;
+};
+
+struct xrt_parent_ioctl_evt_cb {
+	struct platform_device *xevt_pdev; /* caller's pdev */
+	xrt_subdev_match_t xevt_match_cb;
+	void *xevt_match_arg;
+	xrt_event_cb_t xevt_cb;
+	void *xevt_hdl;
+};
+
+struct xrt_parent_ioctl_async_broadcast_evt {
+	struct platform_device *xaevt_pdev; /* caller's pdev */
+	enum xrt_events xaevt_event;
+	xrt_async_broadcast_event_cb_t xaevt_cb;
+	void *xaevt_arg;
+};
+
+struct xrt_parent_ioctl_get_holders {
+	struct platform_device *xpigh_pdev; /* caller's pdev */
+	char *xpigh_holder_buf;
+	size_t xpigh_holder_buf_len;
+};
+
+struct xrt_parent_ioctl_get_res {
+	struct resource *xpigr_res;
+};
+
+struct xrt_parent_ioctl_get_id {
+	unsigned short  xpigi_vendor_id;
+	unsigned short  xpigi_device_id;
+	unsigned short  xpigi_sub_vendor_id;
+	unsigned short  xpigi_sub_device_id;
+};
+
+struct xrt_parent_ioctl_hwmon {
+	bool xpih_register;
+	const char *xpih_name;
+	void *xpih_drvdata;
+	const struct attribute_group **xpih_groups;
+	struct device *xpih_hwmon_dev;
+};
+
+#endif	/* _XRT_PARENT_H_ */
diff --git a/drivers/fpga/alveo/include/xrt-partition.h b/drivers/fpga/alveo/include/xrt-partition.h
new file mode 100644
index 000000000000..e0048f2a146f
--- /dev/null
+++ b/drivers/fpga/alveo/include/xrt-partition.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020 Xilinx, Inc.
+ *
+ * Authors:
+ *	Cheng Zhen <maxz@xilinx.com>
+ */
+
+#ifndef	_XRT_PARTITION_H_
+#define	_XRT_PARTITION_H_
+
+#include "xrt-subdev.h"
+
+/*
+ * Partition driver IOCTL calls.
+ */
+enum xrt_partition_ioctl_cmd {
+	XRT_PARTITION_GET_LEAF = 0,
+	XRT_PARTITION_PUT_LEAF,
+	XRT_PARTITION_INIT_CHILDREN,
+	XRT_PARTITION_FINI_CHILDREN,
+	XRT_PARTITION_EVENT,
+};
+
+struct xrt_partition_ioctl_event {
+	enum xrt_events xpie_evt;
+	struct xrt_parent_ioctl_evt_cb *xpie_cb;
+};
+
+extern int xrt_subdev_parent_ioctl(struct platform_device *pdev,
+	u32 cmd, void *arg);
+
+#endif	/* _XRT_PARTITION_H_ */
diff --git a/drivers/fpga/alveo/include/xrt-subdev.h b/drivers/fpga/alveo/include/xrt-subdev.h
new file mode 100644
index 000000000000..65ecbd9c596b
--- /dev/null
+++ b/drivers/fpga/alveo/include/xrt-subdev.h
@@ -0,0 +1,333 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020 Xilinx, Inc.
+ *
+ * Authors:
+ *	Cheng Zhen <maxz@xilinx.com>
+ */
+
+#ifndef	_XRT_SUBDEV_H_
+#define	_XRT_SUBDEV_H_
+
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+#include <linux/fs.h>
+#include <linux/cdev.h>
+#include <linux/pci.h>
+#include <linux/libfdt_env.h>
+#include "libfdt.h"
+
+/*
+ * Every subdev driver should have an ID for others to refer to it.
+ * There can be unlimited number of instances of a subdev driver. A
+ * <subdev_id, subdev_instance> tuple should be a unique identification of
+ * a specific instance of a subdev driver.
+ * NOTE: PLEASE do not change the order of IDs. Sub devices in the same
+ * partition are initialized by this order.
+ */
+enum xrt_subdev_id {
+	XRT_SUBDEV_PART = 0,
+	XRT_SUBDEV_VSEC,
+	XRT_SUBDEV_VSEC_GOLDEN,
+	XRT_SUBDEV_GPIO,
+	XRT_SUBDEV_AXIGATE,
+	XRT_SUBDEV_ICAP,
+	XRT_SUBDEV_TEST,
+	XRT_SUBDEV_MGMT_MAIN,
+	XRT_SUBDEV_QSPI,
+	XRT_SUBDEV_MAILBOX,
+	XRT_SUBDEV_CMC,
+	XRT_SUBDEV_CALIB,
+	XRT_SUBDEV_CLKFREQ,
+	XRT_SUBDEV_CLOCK,
+	XRT_SUBDEV_SRSR,
+	XRT_SUBDEV_UCS,
+	XRT_SUBDEV_NUM,
+};
+
+/*
+ * If populated by subdev driver, parent will handle the mechanics of
+ * char device (un)registration.
+ */
+enum xrt_subdev_file_mode {
+	// Infra create cdev, default file name
+	XRT_SUBDEV_FILE_DEFAULT = 0,
+	// Infra create cdev, need to encode inst num in file name
+	XRT_SUBDEV_FILE_MULTI_INST,
+	// No auto creation of cdev by infra, leaf handles it by itself
+	XRT_SUBDEV_FILE_NO_AUTO,
+};
+struct xrt_subdev_file_ops {
+	const struct file_operations xsf_ops;
+	dev_t xsf_dev_t;
+	const char *xsf_dev_name;
+	enum xrt_subdev_file_mode xsf_mode;
+};
+
+/*
+ * Subdev driver callbacks populated by subdev driver.
+ */
+struct xrt_subdev_drv_ops {
+	/*
+	 * Per driver module callback. Don't take any arguments.
+	 * If defined these are called as part of driver (un)registration.
+	 */
+	int (*xsd_post_init)(void);
+	void (*xsd_pre_exit)(void);
+
+	/*
+	 * Per driver instance callback. The pdev points to the instance.
+	 * If defined these are called by other leaf drivers.
+	 * Note that root driver may call into xsd_ioctl of a partition driver.
+	 */
+	int (*xsd_ioctl)(struct platform_device *pdev, u32 cmd, void *arg);
+};
+
+/*
+ * Defined and populated by subdev driver, exported as driver_data in
+ * struct platform_device_id.
+ */
+struct xrt_subdev_drvdata {
+	struct xrt_subdev_file_ops xsd_file_ops;
+	struct xrt_subdev_drv_ops xsd_dev_ops;
+};
+
+/*
+ * Partially initialized by parent driver, then, passed in as subdev driver's
+ * platform data when creating subdev driver instance by calling platform
+ * device register API (platform_device_register_data() or the likes).
+ *
+ * Once device register API returns, platform driver framework makes a copy of
+ * this buffer and maintains its life cycle. The content of the buffer is
+ * completely owned by subdev driver.
+ *
+ * Thus, parent driver should be very careful when it touches this buffer
+ * again once it's handed over to subdev driver. And the data structure
+ * should not contain pointers pointing to buffers that is managed by
+ * other or parent drivers since it could have been freed before platform
+ * data buffer is freed by platform driver framework.
+ */
+typedef int (*xrt_subdev_parent_cb_t)(struct device *, void *, u32, void *);
+struct xrt_subdev_platdata {
+	/*
+	 * Per driver instance callback. The pdev points to the instance.
+	 * Should always be defined for subdev driver to call into its parent.
+	 */
+	xrt_subdev_parent_cb_t xsp_parent_cb;
+	void *xsp_parent_cb_arg;
+
+	/* Something to associate w/ root for msg printing. */
+	const char *xsp_root_name;
+
+	/*
+	 * Char dev support for this subdev instance.
+	 * Initialized by subdev driver.
+	 */
+	struct cdev xsp_cdev;
+	struct device *xsp_sysdev;
+	struct mutex xsp_devnode_lock;
+	struct completion xsp_devnode_comp;
+	int xsp_devnode_ref;
+	bool xsp_devnode_online;
+	bool xsp_devnode_excl;
+
+	/*
+	 * Subdev driver specific init data. The buffer should be embedded
+	 * in this data structure buffer after dtb, so that it can be freed
+	 * together with platform data.
+	 */
+	loff_t xsp_priv_off; /* Offset into this platform data buffer. */
+	size_t xsp_priv_len;
+
+	/*
+	 * Populated by parent driver to describe the device tree for
+	 * the subdev driver to handle. Should always be last one since it's
+	 * of variable length.
+	 */
+	char xsp_dtb[sizeof(struct fdt_header)];
+};
+
+/*
+ * this struct define the endpoints belong to the same subdevice
+ */
+struct xrt_subdev_ep_names {
+	const char *ep_name;
+	const char *regmap_name;
+};
+
+struct xrt_subdev_endpoints {
+	struct xrt_subdev_ep_names *xse_names;
+	/* minimum number of endpoints to support the subdevice */
+	u32 xse_min_ep;
+};
+
+/*
+ * It manages a list of xrt_subdevs for root and partition drivers.
+ */
+struct xrt_subdev_pool {
+	struct list_head xpool_dev_list;
+	struct device *xpool_owner;
+	struct mutex xpool_lock;
+	bool xpool_closing;
+};
+
+typedef bool (*xrt_subdev_match_t)(enum xrt_subdev_id,
+	struct platform_device *, void *);
+#define	XRT_SUBDEV_MATCH_PREV	((xrt_subdev_match_t)-1)
+#define	XRT_SUBDEV_MATCH_NEXT	((xrt_subdev_match_t)-2)
+
+/* All subdev drivers should use below common routines to print out msg. */
+#define	DEV(pdev)	(&(pdev)->dev)
+#define	DEV_PDATA(pdev)					\
+	((struct xrt_subdev_platdata *)dev_get_platdata(DEV(pdev)))
+#define	DEV_DRVDATA(pdev)				\
+	((struct xrt_subdev_drvdata *)			\
+	platform_get_device_id(pdev)->driver_data)
+#define	FMT_PRT(prt_fn, pdev, fmt, args...)		\
+	prt_fn(DEV(pdev), "%s %s: "fmt,			\
+	DEV_PDATA(pdev)->xsp_root_name, __func__, ##args)
+#define xrt_err(pdev, fmt, args...) FMT_PRT(dev_err, pdev, fmt, ##args)
+#define xrt_warn(pdev, fmt, args...) FMT_PRT(dev_warn, pdev, fmt, ##args)
+#define xrt_info(pdev, fmt, args...) FMT_PRT(dev_info, pdev, fmt, ##args)
+#define xrt_dbg(pdev, fmt, args...) FMT_PRT(dev_dbg, pdev, fmt, ##args)
+
+/*
+ * Event notification.
+ */
+enum xrt_events {
+	XRT_EVENT_TEST = 0, // for testing
+	/*
+	 * Events related to specific subdev
+	 * Callback arg: struct xrt_event_arg_subdev
+	 */
+	XRT_EVENT_POST_CREATION,
+	XRT_EVENT_PRE_REMOVAL,
+	/*
+	 * Events related to change of the whole board
+	 * Callback arg: <none>
+	 */
+	XRT_EVENT_PRE_HOT_RESET,
+	XRT_EVENT_POST_HOT_RESET,
+	XRT_EVENT_PRE_GATE_CLOSE,
+	XRT_EVENT_POST_GATE_OPEN,
+	XRT_EVENT_POST_ATTACH,
+	XRT_EVENT_PRE_DETACH,
+};
+
+typedef int (*xrt_event_cb_t)(struct platform_device *pdev,
+	enum xrt_events evt, void *arg);
+typedef void (*xrt_async_broadcast_event_cb_t)(struct platform_device *pdev,
+	enum xrt_events evt, void *arg, bool success);
+
+struct xrt_event_arg_subdev {
+	enum xrt_subdev_id xevt_subdev_id;
+	int xevt_subdev_instance;
+};
+
+/*
+ * Flags in return value from event callback.
+ */
+/* Done with event handling, continue waiting for the next one */
+#define	XRT_EVENT_CB_CONTINUE	0x0
+/* Done with event handling, stop waiting for the next one */
+#define	XRT_EVENT_CB_STOP	0x1
+/* Error processing event */
+#define	XRT_EVENT_CB_ERR	0x2
+
+/*
+ * Subdev pool API for root and partition drivers only.
+ */
+extern void xrt_subdev_pool_init(struct device *dev,
+	struct xrt_subdev_pool *spool);
+extern int xrt_subdev_pool_fini(struct xrt_subdev_pool *spool);
+extern int xrt_subdev_pool_get(struct xrt_subdev_pool *spool,
+	xrt_subdev_match_t match, void *arg, struct device *holder_dev,
+	struct platform_device **pdevp);
+extern int xrt_subdev_pool_put(struct xrt_subdev_pool *spool,
+	struct platform_device *pdev, struct device *holder_dev);
+extern int xrt_subdev_pool_add(struct xrt_subdev_pool *spool,
+	enum xrt_subdev_id id, xrt_subdev_parent_cb_t pcb,
+	void *pcb_arg, char *dtb);
+extern int xrt_subdev_pool_del(struct xrt_subdev_pool *spool,
+	enum xrt_subdev_id id, int instance);
+extern int xrt_subdev_pool_event(struct xrt_subdev_pool *spool,
+	struct platform_device *pdev, xrt_subdev_match_t match, void *arg,
+	xrt_event_cb_t xevt_cb, enum xrt_events evt);
+extern ssize_t xrt_subdev_pool_get_holders(struct xrt_subdev_pool *spool,
+	struct platform_device *pdev, char *buf, size_t len);
+/*
+ * For leaf drivers.
+ */
+extern bool xrt_subdev_has_epname(struct platform_device *pdev, const char *nm);
+extern struct platform_device *xrt_subdev_get_leaf(
+	struct platform_device *pdev, xrt_subdev_match_t cb, void *arg);
+extern struct platform_device *xrt_subdev_get_leaf_by_id(
+	struct platform_device *pdev, enum xrt_subdev_id id, int instance);
+extern struct platform_device *xrt_subdev_get_leaf_by_epname(
+	struct platform_device *pdev, const char *name);
+extern int xrt_subdev_put_leaf(struct platform_device *pdev,
+	struct platform_device *leaf);
+extern int xrt_subdev_create_partition(struct platform_device *pdev,
+	char *dtb);
+extern int xrt_subdev_destroy_partition(struct platform_device *pdev,
+	int instance);
+extern int xrt_subdev_lookup_partition(
+	struct platform_device *pdev, xrt_subdev_match_t cb, void *arg);
+extern int xrt_subdev_wait_for_partition_bringup(struct platform_device *pdev);
+extern void *xrt_subdev_add_event_cb(struct platform_device *pdev,
+	xrt_subdev_match_t match, void *match_arg, xrt_event_cb_t cb);
+extern void xrt_subdev_remove_event_cb(
+	struct platform_device *pdev, void *hdl);
+extern int xrt_subdev_ioctl(struct platform_device *tgt, u32 cmd, void *arg);
+extern int xrt_subdev_broadcast_event(struct platform_device *pdev,
+	enum xrt_events evt);
+extern int xrt_subdev_broadcast_event_async(struct platform_device *pdev,
+	enum xrt_events evt, xrt_async_broadcast_event_cb_t cb, void *arg);
+extern void xrt_subdev_hot_reset(struct platform_device *pdev);
+extern void xrt_subdev_get_barres(struct platform_device *pdev,
+	struct resource **res, uint bar_idx);
+extern void xrt_subdev_get_parent_id(struct platform_device *pdev,
+	unsigned short *vendor, unsigned short *device,
+	unsigned short *subvendor, unsigned short *subdevice);
+extern struct device *xrt_subdev_register_hwmon(struct platform_device *pdev,
+	const char *name, void *drvdata, const struct attribute_group **grps);
+extern void xrt_subdev_unregister_hwmon(struct platform_device *pdev,
+	struct device *hwmon);
+
+extern int xrt_subdev_register_external_driver(enum xrt_subdev_id id,
+	struct platform_driver *drv, struct xrt_subdev_endpoints *eps);
+extern void xrt_subdev_unregister_external_driver(enum xrt_subdev_id id);
+
+/*
+ * Char dev APIs.
+ */
+static inline bool xrt_devnode_enabled(struct xrt_subdev_drvdata *drvdata)
+{
+	return drvdata && drvdata->xsd_file_ops.xsf_ops.open != NULL;
+}
+extern int xrt_devnode_create(struct platform_device *pdev,
+	const char *file_name, const char *inst_name);
+extern int xrt_devnode_destroy(struct platform_device *pdev);
+extern struct platform_device *xrt_devnode_open_excl(struct inode *inode);
+extern struct platform_device *xrt_devnode_open(struct inode *inode);
+extern void xrt_devnode_close(struct inode *inode);
+
+/* Helpers. */
+static inline void xrt_memcpy_fromio(void *buf, void __iomem *iomem, u32 size)
+{
+	int i;
+
+	BUG_ON(size & 0x3);
+	for (i = 0; i < size / 4; i++)
+		((u32 *)buf)[i] = ioread32((char *)(iomem) + sizeof(u32) * i);
+}
+static inline void xrt_memcpy_toio(void __iomem *iomem, void *buf, u32 size)
+{
+	int i;
+
+	BUG_ON(size & 0x3);
+	for (i = 0; i < size / 4; i++)
+		iowrite32(((u32 *)buf)[i], ((char *)(iomem) + sizeof(u32) * i));
+}
+
+#endif	/* _XRT_SUBDEV_H_ */
diff --git a/drivers/fpga/alveo/include/xrt-ucs.h b/drivers/fpga/alveo/include/xrt-ucs.h
new file mode 100644
index 000000000000..a64b15bda865
--- /dev/null
+++ b/drivers/fpga/alveo/include/xrt-ucs.h
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
+#include "xrt-subdev.h"
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
-- 
2.17.1


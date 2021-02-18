Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF1F31E68D
	for <lists+linux-fpga@lfdr.de>; Thu, 18 Feb 2021 08:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbhBRGzy (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 18 Feb 2021 01:55:54 -0500
Received: from mail-mw2nam08on2056.outbound.protection.outlook.com ([40.107.101.56]:24797
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231205AbhBRGss (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 18 Feb 2021 01:48:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ki5x8StfXT8xppwa9/ujOdm7GK/QESznariyA2mZSxaVWP+E84M08x29Pn0aQe9Ni7Ap0bztNed3/pQUaRjejfIzUL4KZ3kB2un4HkMuMBdcpp67JaHl+wk9BbkTgrEFGy+x8MYW6KizmbxXs0MiFsqA78exCsNaXM0Bwq9g/aMHQNwIsH1XURuTums5KWs2k9immakguKRpb+rxmf4jxPA5MhKgx7eT+gr4PSlW9HK0QSzcgBLTJeD45y8tTsFmITFQO9tF1L6r/86zuD9RYVRHvA06eWdpbNiNPmiUsgzMSupqSgMrbEsW9dEv6/RDjxFVSLEW5JMhKLdH5XY1ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O8IlLaKpSzmXAJIhkawUh9MkwRoVNpzyki+5fwb40jw=;
 b=LCN9NszmGDtL8ffYtLTEzPdVaDESUppBW36qKDc3wqx2LuY0Bmv3bKF62YrKU2bJDhnlQMHkr4RBb/9BafoB/9hqqc3HVeKGR66P9Nyo5Aa/gz+rH/XQRdSjFwdyJWD2kcpP/tKTY85o/aIcGWIl6l4bFDMAUb0wjMDNvp51vTdOdgDGQ8oSk2x0pZQqcBJ/MxHNNSS9lEBEzjAhcacNQyD5h7j+/GYkygdMk5qYeTKVtWLUYMgNWA6jo1oJxejXTRq2C9h0ItSLEgWG3ud/VTlZBEce0KHkKxXuAJViwOJqUmF5CcstRqwBuMxXYWKcNacbX1Pt6kbKFFE7t1ez8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O8IlLaKpSzmXAJIhkawUh9MkwRoVNpzyki+5fwb40jw=;
 b=RIQYeOS/tjI5YRtNeyMzsuHEo8re5A0euOq5eTBdDqxNpM8pEcMAIaeUuFKzZQfscEkjQzJyjN8HEdWygmdQQB7HA1QMgNpMDwAmbF5g6a6JyNs+mSRQ38w9Cok2fgvJGNHxmHsJmv2Sj2Zlsad2s2A3oyX3wJ4Uo5hQMZFa+gA=
Received: from CY4PR13CA0038.namprd13.prod.outlook.com (2603:10b6:903:99::24)
 by SN6PR02MB4320.namprd02.prod.outlook.com (2603:10b6:805:a4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.34; Thu, 18 Feb
 2021 06:45:36 +0000
Received: from CY1NAM02FT046.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:99:cafe::1d) by CY4PR13CA0038.outlook.office365.com
 (2603:10b6:903:99::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.8 via Frontend
 Transport; Thu, 18 Feb 2021 06:45:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 CY1NAM02FT046.mail.protection.outlook.com (10.152.74.232) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3868.27 via Frontend Transport; Thu, 18 Feb 2021 06:45:35 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Wed, 17 Feb 2021 22:45:16 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Wed, 17 Feb 2021 22:45:16 -0800
Envelope-to: maxz@xilinx.com,
 max.zhen@xilinx.com,
 michal.simek@xilinx.com,
 sonal.santan@xilinx.com,
 lizhih@xilinx.com,
 stefanos@xilinx.com,
 mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.72.212] (port=40184 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1lCd3r-00022Q-WF; Wed, 17 Feb 2021 22:45:16 -0800
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id 6245260012A; Wed, 17 Feb 2021 22:41:06 -0800 (PST)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhih@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>, Max Zhen <max.zhen@xilinx.com>
Subject: [PATCH V3 XRT Alveo 12/18] fpga: xrt: ICAP platform driver
Date:   Wed, 17 Feb 2021 22:40:13 -0800
Message-ID: <20210218064019.29189-13-lizhih@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210218064019.29189-1-lizhih@xilinx.com>
References: <20210218064019.29189-1-lizhih@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da78eea4-0a23-4b1e-43ac-08d8d3d8cbe2
X-MS-TrafficTypeDiagnostic: SN6PR02MB4320:
X-Microsoft-Antispam-PRVS: <SN6PR02MB4320780511B3B74524E2997CA1859@SN6PR02MB4320.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BiFiaEbgwcbu2QoS9l6ptZM5l5NMIjQZeHLvFfxw394A8HeE/uEqVtZklh9rOv3ApGxZMl1l1Zqef/7XKKmWDQGV3sZsRc47IbmoSvjAKRG+aiI8ZBMSeOBVEGj7Ai5UVFRU5CnxwnR57wiwGuBFedA7DVsC/rWTAircjVwidkvwYlvRfUhT5MucRfC6WuTNBg957T3dN7aE1QgQmQ0bAsMoFVf4vC0c67vDksrs4vNCfwPbKK/QzSzy9OMFdRrr6BTPuIbxxDy7Gk7g8y0c+64LJKuBg6LYuL7nDyAWzExCa6GyeAU9n6xIieqv6a7rY6yhCnU7Pi+GFgcBROjW/BH/BT2bbUbUp0p5V9VLq1GwkQWeB9K2N7W2BWT2cv8xQExLTSkCKtAv9P4Xi6/Y/RmupVTIp2jKj3up+neNn8NsyXTYvYuU8rEOVFiziFpvx4SBmyVSrMjVUQyKg4xBRClKLnuBywVAzEEaIoS1/HqKw+4z0CNvO+Nfr1dXj5iv7Wk1m7qXfDtApwf4uv7BuPL70r87wu92WKoQ6MT8hRpd4cVtftsqVbxdkLLZXbvtQxRrQd8lZcqfN5KklZh+zqDIds6WVDDlWZCvPAJNV8Py3l1HuVBq/ELLPe9FAAx5UC2YX5/s3juxJfGbZThVZ1VnZtEl0qpef0tSsGu9Cho=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(346002)(39860400002)(136003)(396003)(376002)(46966006)(36840700001)(2616005)(8936002)(426003)(5660300002)(36860700001)(82310400003)(107886003)(186003)(6266002)(336012)(82740400003)(4326008)(70206006)(70586007)(478600001)(6666004)(54906003)(8676002)(36756003)(7636003)(6916009)(83380400001)(26005)(47076005)(1076003)(356005)(36906005)(316002)(44832011)(42186006)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2021 06:45:35.9295
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da78eea4-0a23-4b1e-43ac-08d8d3d8cbe2
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT046.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4320
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Add ICAP driver. ICAP is a hardware function discovered by walking
firmware metadata. A platform device node will be created for it.
FPGA bitstream is written to hardware through ICAP.

Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
Signed-off-by: Max Zhen <max.zhen@xilinx.com>
Signed-off-by: Lizhi Hou <lizhih@xilinx.com>
---
 drivers/fpga/xrt/include/xleaf/icap.h |  29 +++
 drivers/fpga/xrt/lib/xleaf/icap.c     | 317 ++++++++++++++++++++++++++
 2 files changed, 346 insertions(+)
 create mode 100644 drivers/fpga/xrt/include/xleaf/icap.h
 create mode 100644 drivers/fpga/xrt/lib/xleaf/icap.c

diff --git a/drivers/fpga/xrt/include/xleaf/icap.h b/drivers/fpga/xrt/include/xleaf/icap.h
new file mode 100644
index 000000000000..a14fc0ffa78f
--- /dev/null
+++ b/drivers/fpga/xrt/include/xleaf/icap.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Header file for XRT ICAP Leaf Driver
+ *
+ * Copyright (C) 2020-2021 Xilinx, Inc.
+ *
+ * Authors:
+ *	Lizhi Hou <Lizhi.Hou@xilinx.com>
+ */
+
+#ifndef _XRT_ICAP_H_
+#define _XRT_ICAP_H_
+
+#include "xleaf.h"
+
+/*
+ * ICAP driver IOCTL calls.
+ */
+enum xrt_icap_ioctl_cmd {
+	XRT_ICAP_WRITE = XRT_XLEAF_CUSTOM_BASE, /* See comments in xleaf.h */
+	XRT_ICAP_IDCODE,
+};
+
+struct xrt_icap_ioctl_wr {
+	void	*xiiw_bit_data;
+	u32	xiiw_data_len;
+};
+
+#endif	/* _XRT_ICAP_H_ */
diff --git a/drivers/fpga/xrt/lib/xleaf/icap.c b/drivers/fpga/xrt/lib/xleaf/icap.c
new file mode 100644
index 000000000000..0500a97bdef9
--- /dev/null
+++ b/drivers/fpga/xrt/lib/xleaf/icap.c
@@ -0,0 +1,317 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx Alveo FPGA ICAP Driver
+ *
+ * Copyright (C) 2020-2021 Xilinx, Inc.
+ *
+ * Authors:
+ *      Lizhi Hou<Lizhi.Hou@xilinx.com>
+ *      Sonal Santan <sonals@xilinx.com>
+ *      Max Zhen <maxz@xilinx.com>
+ */
+
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/io.h>
+#include "metadata.h"
+#include "xleaf.h"
+#include "xleaf/icap.h"
+#include "xclbin-helper.h"
+
+#define XRT_ICAP "xrt_icap"
+
+#define ICAP_ERR(icap, fmt, arg...)	\
+	xrt_err((icap)->pdev, fmt "\n", ##arg)
+#define ICAP_WARN(icap, fmt, arg...)	\
+	xrt_warn((icap)->pdev, fmt "\n", ##arg)
+#define ICAP_INFO(icap, fmt, arg...)	\
+	xrt_info((icap)->pdev, fmt "\n", ##arg)
+#define ICAP_DBG(icap, fmt, arg...)	\
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
+	struct mutex		icap_lock; /* icap dev lock */
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
+	WARN_ON(!mutex_is_locked(&icap->icap_lock));
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
+			    u32 word_count)
+{
+	u32 remain_word;
+	u32 word_written = 0;
+	int wr_fifo_vacancy = 0;
+	int err = 0;
+
+	WARN_ON(!mutex_is_locked(&icap->icap_lock));
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
+				 remain_word, word_written);
+			err = -EIO;
+			break;
+		}
+	}
+
+	return err;
+}
+
+static int icap_download(struct icap *icap, const char *buffer,
+			 unsigned long length)
+{
+	u32	num_chars_read = DMA_HWICAP_BITFILE_BUFFER_SIZE;
+	u32	byte_read;
+	int	err = 0;
+
+	mutex_lock(&icap->icap_lock);
+	for (byte_read = 0; byte_read < length; byte_read += num_chars_read) {
+		num_chars_read = length - byte_read;
+		if (num_chars_read > DMA_HWICAP_BITFILE_BUFFER_SIZE)
+			num_chars_read = DMA_HWICAP_BITFILE_BUFFER_SIZE;
+
+		err = bitstream_helper(icap, (u32 *)buffer, num_chars_read / sizeof(u32));
+		if (err)
+			goto failed;
+		buffer += num_chars_read;
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
+	(void)w;
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
+	case XRT_XLEAF_EVENT:
+		/* Does not handle any event. */
+		break;
+	case XRT_ICAP_WRITE:
+		ret = icap_download(icap, wr_arg->xiiw_bit_data,
+				    wr_arg->xiiw_data_len);
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
+	if (res) {
+		icap->icap_regs = ioremap(res->start, res->end - res->start + 1);
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
+static struct xrt_subdev_endpoints xrt_icap_endpoints[] = {
+	{
+		.xse_names = (struct xrt_subdev_ep_names[]) {
+			{ .ep_name = XRT_MD_NODE_FPGA_CONFIG },
+			{ NULL },
+		},
+		.xse_min_ep = 1,
+	},
+	{ 0 },
+};
+
+static struct xrt_subdev_drvdata xrt_icap_data = {
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
+static struct platform_driver xrt_icap_driver = {
+	.driver = {
+		.name = XRT_ICAP,
+	},
+	.probe = xrt_icap_probe,
+	.remove = xrt_icap_remove,
+	.id_table = xrt_icap_table,
+};
+
+void icap_leaf_init_fini(bool init)
+{
+	if (init)
+		xleaf_register_driver(XRT_SUBDEV_ICAP, &xrt_icap_driver, xrt_icap_endpoints);
+	else
+		xleaf_unregister_driver(XRT_SUBDEV_ICAP);
+}
-- 
2.18.4


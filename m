Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4571D347112
	for <lists+linux-fpga@lfdr.de>; Wed, 24 Mar 2021 06:36:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235389AbhCXFgD (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 24 Mar 2021 01:36:03 -0400
Received: from mail-mw2nam12on2044.outbound.protection.outlook.com ([40.107.244.44]:30177
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235365AbhCXFfh (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 24 Mar 2021 01:35:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hqGmVEAGhAkqnp60s2x3wOiZ+16xwIMsk/Dhez0DR45pdU4Xs9es8Prew5XAZwG9PqOJfkjUvZciZVN9HvLFc0DxR7ClykIocR44FxIDSCmptph/Y1iF/QZdQog6uOCO2IQssHv6Cm1A/MIc+rSJ8j75FiMb+Wr9oxmAOmFk/igvtaeUhDQ2R3/ZeiD4n+z3I0Eh3nG0eLCtY1hzltOTHGOp7f7u5F6alhGKkJEIjTo9niyMasipf28IMjRodCehS5cyTcgxUrIsfeQYq+xvvriHTFncL2STvHhsl/lYFqnaNAubsbMM6NLg1LIxjllAS0Srbb2wdGGCBU3yU99ZNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hptM/dokqPZ7hIv7+CucsA0WAxgs2s1GQXoIAkG9PaU=;
 b=JMLDY4TJL9WmPClyPe/94SfyfD/vKb57olyl6sxQyQJgNFni9jTUsmzlsK4L5cwytnIPKkFu9l7paO+0mjQjiAvesGJvfFFHoc/up0zU6eErZDvMdfP77Hk2Qf4cPlxKj4iTwqq5iEXLNbElpj3crUjWhX1sRYuL93xyPt4RLNwmAgEfVZE61qJYGMvCxhTtXSL9bQAFs7aQy45Nj9Py93YN1lQuQKX6K5n/H04+7cVM4EmKOzqOqhrem9AkpyAZIYxP/YCuSaqNFYtzClcfu3+UCoNkgEdHcJID5YdjSyGUX2uDinAcZd4wzLbyRluFh+RWkB/AyT8DociVeWtYtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hptM/dokqPZ7hIv7+CucsA0WAxgs2s1GQXoIAkG9PaU=;
 b=a3ig78Ob8/eyoGrc7MuNgqSeEKVDgzFDleFUFZTbSwfHHn4kOhGGJ7NsVnZ4rrpRoXnMYWPIU3Uv9bbtoLUdT04IV061BbzHeABvZn/DvPaLYd7ZYL4JVTvZaX8nfwy2ehMWgLQ6WKEQgRT1klXQ3FFdifEEvFCITxOpQpU8EGA=
Received: from DM5PR06CA0081.namprd06.prod.outlook.com (2603:10b6:3:4::19) by
 SN6PR02MB4447.namprd02.prod.outlook.com (2603:10b6:805:a7::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.18; Wed, 24 Mar 2021 05:35:34 +0000
Received: from DM3NAM02FT024.eop-nam02.prod.protection.outlook.com
 (2603:10b6:3:4:cafe::83) by DM5PR06CA0081.outlook.office365.com
 (2603:10b6:3:4::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend
 Transport; Wed, 24 Mar 2021 05:35:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT024.mail.protection.outlook.com (10.13.5.128) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3955.24 via Frontend Transport; Wed, 24 Mar 2021 05:35:34 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 23 Mar 2021 22:35:10 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2106.2 via Frontend Transport; Tue, 23 Mar 2021 22:35:10 -0700
Envelope-to: mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.72.212] (port=51048 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1lOwAg-0006Bj-Nq; Tue, 23 Mar 2021 22:35:10 -0700
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id BC7B060012D; Tue, 23 Mar 2021 22:29:56 -0700 (PDT)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>, Max Zhen <max.zhen@xilinx.com>
Subject: [PATCH V4 XRT Alveo 14/20] fpga: xrt: ICAP platform driver
Date:   Tue, 23 Mar 2021 22:29:41 -0700
Message-ID: <20210324052947.27889-15-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210324052947.27889-1-lizhi.hou@xilinx.com>
References: <20210324052947.27889-1-lizhi.hou@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 415db1cb-4f93-4059-4c01-08d8ee86a576
X-MS-TrafficTypeDiagnostic: SN6PR02MB4447:
X-Microsoft-Antispam-PRVS: <SN6PR02MB44474DB76E99C4B819AAC18BA1639@SN6PR02MB4447.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mWtrTEQbAp4VmYfGNW0cvT7SG5aDnMLxU3FrQJFIV19AfURFd00OS1ke+11L0Q7YjiMK2QU/LoECl1ttstFW6WWBIvV0LMy1gM4V69FBpMcFJmhOvK/gGisywZNzpy4BVkdCzPy+W1jHnpfYEG9QplsupYccryCj+5MDRIJAvAiexbpF07/XYnxuWRLfufzICRnkY1QWgdNbN8vcp78G4hYfOJMDncXJzfcskQjbOfe6CpMOYPH5o6UsR9r0K0/p61F8yu1PAgSbzFJJFEWQt1UmDIxb1V7S3zsFXxfMl18GO3hS3nRHs6EB7vtPLnAumzYr/ryV9kKKjw4Ibl0Y5PFc/iNwDRgZq8SsLCnqVlAQQDYfGrczdLWo+N16JJgQoqHPGHTAKrS6RHFpNTsDfjYgMnX2EvC/rzkbjIFEZ+j/l8dHCnFQ6547+aJkxmG+F1HXqDrOpq7btoQW7zUrp0bP2EhqEuYWa4NDS/BCQIVFHeOwBft0PZ/ykt5zlU3w2acsI/UlVyyVNbyOAZ38ejwLmjwznGb1UcwDoL9tIeSfvJbUcsRIJKuWoN6wzU9cjJQAabDYZkVO9ZoQd0+iQ1sMnM3Pjjn6wfjBqui0UY/EWmn2gFL8mkIB4nf1iG0vwcEv5goan3l5RIyKhbwgWIRI5m1rnE86Zpbz9a2Jv1eFIJ64eiMJIQx5Nl5pM8SwyPxN5aKq0FxvZKv33Z+kuhOs1QX0ncREmDhrUApJx9Y=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(39860400002)(346002)(136003)(376002)(396003)(36840700001)(46966006)(44832011)(70586007)(7636003)(82740400003)(478600001)(82310400003)(4326008)(6916009)(2906002)(36860700001)(966005)(36906005)(8676002)(70206006)(1076003)(5660300002)(6266002)(316002)(42186006)(26005)(8936002)(83380400001)(54906003)(47076005)(426003)(356005)(107886003)(36756003)(6666004)(336012)(2616005)(186003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2021 05:35:34.1047
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 415db1cb-4f93-4059-4c01-08d8ee86a576
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT024.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4447
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

ICAP stands for Hardware Internal Configuration Access Port. ICAP is
discovered by walking firmware metadata. A platform device node will be
created for it. FPGA bitstream is written to hardware through ICAP.

Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
Signed-off-by: Max Zhen <max.zhen@xilinx.com>
Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
---
 drivers/fpga/xrt/include/xleaf/icap.h |  27 ++
 drivers/fpga/xrt/lib/xleaf/icap.c     | 344 ++++++++++++++++++++++++++
 2 files changed, 371 insertions(+)
 create mode 100644 drivers/fpga/xrt/include/xleaf/icap.h
 create mode 100644 drivers/fpga/xrt/lib/xleaf/icap.c

diff --git a/drivers/fpga/xrt/include/xleaf/icap.h b/drivers/fpga/xrt/include/xleaf/icap.h
new file mode 100644
index 000000000000..96d39a8934fa
--- /dev/null
+++ b/drivers/fpga/xrt/include/xleaf/icap.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
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
+ * ICAP driver leaf calls.
+ */
+enum xrt_icap_leaf_cmd {
+	XRT_ICAP_WRITE = XRT_XLEAF_CUSTOM_BASE, /* See comments in xleaf.h */
+	XRT_ICAP_GET_IDCODE,
+};
+
+struct xrt_icap_wr {
+	void	*xiiw_bit_data;
+	u32	xiiw_data_len;
+};
+
+#endif	/* _XRT_ICAP_H_ */
diff --git a/drivers/fpga/xrt/lib/xleaf/icap.c b/drivers/fpga/xrt/lib/xleaf/icap.c
new file mode 100644
index 000000000000..13db2b759138
--- /dev/null
+++ b/drivers/fpga/xrt/lib/xleaf/icap.c
@@ -0,0 +1,344 @@
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
+#include <linux/regmap.h>
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
+ * AXI-HWICAP IP register layout. Please see
+ * https://www.xilinx.com/support/documentation/ip_documentation/axi_hwicap/v3_0/pg134-axi-hwicap.pdf
+ */
+#define ICAP_REG_GIER		0x1C
+#define ICAP_REG_ISR		0x20
+#define ICAP_REG_IER		0x28
+#define ICAP_REG_WF		0x100
+#define ICAP_REG_RF		0x104
+#define ICAP_REG_SZ		0x108
+#define ICAP_REG_CR		0x10C
+#define ICAP_REG_SR		0x110
+#define ICAP_REG_WFV		0x114
+#define ICAP_REG_RFO		0x118
+#define ICAP_REG_ASR		0x11C
+
+#define ICAP_STATUS_EOS		0x4
+#define ICAP_STATUS_DONE	0x1
+
+/*
+ * Canned command sequence to obtain IDCODE of the FPGA
+ */
+static const u32 idcode_stream[] = {
+	/* dummy word */
+	cpu_to_be32(0xffffffff),
+	/* sync word */
+	cpu_to_be32(0xaa995566),
+	/* NOP word */
+	cpu_to_be32(0x20000000),
+	/* NOP word */
+	cpu_to_be32(0x20000000),
+	/* ID code */
+	cpu_to_be32(0x28018001),
+	/* NOP word */
+	cpu_to_be32(0x20000000),
+	/* NOP word */
+	cpu_to_be32(0x20000000),
+};
+
+static const struct regmap_config icap_regmap_config = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+	.max_register = 0x1000,
+};
+
+struct icap {
+	struct platform_device	*pdev;
+	struct regmap		*regmap;
+	struct mutex		icap_lock; /* icap dev lock */
+
+	u32			idcode;
+};
+
+static int wait_for_done(const struct icap *icap)
+{
+	int i = 0;
+	int ret;
+	u32 w;
+
+	for (i = 0; i < 10; i++) {
+		/*
+		 * it requires few micro seconds for ICAP to process incoming data.
+		 * Polling every 5us for 10 times would be good enough.
+		 */
+		udelay(5);
+		ret = regmap_read(icap->regmap, ICAP_REG_SR, &w);
+		if (ret)
+			return ret;
+		ICAP_INFO(icap, "XHWICAP_SR: %x", w);
+		if (w & (ICAP_STATUS_EOS | ICAP_STATUS_DONE))
+			return 0;
+	}
+
+	ICAP_ERR(icap, "bitstream download timeout");
+	return -ETIMEDOUT;
+}
+
+static int icap_write(const struct icap *icap, const u32 *word_buf, int size)
+{
+	u32 value = 0;
+	int ret;
+	int i;
+
+	for (i = 0; i < size; i++) {
+		value = be32_to_cpu(word_buf[i]);
+		ret = regmap_write(icap->regmap, ICAP_REG_WF, value);
+		if (ret)
+			return ret;
+	}
+
+	ret = regmap_write(icap->regmap, ICAP_REG_CR, 0x1);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < 20; i++) {
+		ret = regmap_read(icap->regmap, ICAP_REG_CR, &value);
+		if (ret)
+			return ret;
+
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
+	int wr_fifo_vacancy = 0;
+	u32 word_written = 0;
+	u32 remain_word;
+	int err = 0;
+
+	WARN_ON(!mutex_is_locked(&icap->icap_lock));
+	for (remain_word = word_count; remain_word > 0;
+	     remain_word -= word_written, word_buffer += word_written) {
+		err = regmap_read(icap->regmap, ICAP_REG_WFV, &wr_fifo_vacancy);
+		if (err) {
+			ICAP_ERR(icap, "read wr_fifo_vacancy failed %d", err);
+			break;
+		}
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
+	u32	num_chars_read = XCLBIN_HWICAP_BITFILE_BUF_SZ;
+	u32	byte_read;
+	int	err = 0;
+
+	if (length % sizeof(u32)) {
+		ICAP_ERR(icap, "invalid bitstream length %ld", length);
+		return -EINVAL;
+	}
+
+	mutex_lock(&icap->icap_lock);
+	for (byte_read = 0; byte_read < length; byte_read += num_chars_read) {
+		num_chars_read = length - byte_read;
+		if (num_chars_read > XCLBIN_HWICAP_BITFILE_BUF_SZ)
+			num_chars_read = XCLBIN_HWICAP_BITFILE_BUF_SZ;
+
+		err = bitstream_helper(icap, (u32 *)buffer, num_chars_read / sizeof(u32));
+		if (err)
+			goto failed;
+		buffer += num_chars_read;
+	}
+
+	/* there is not any cleanup needs to be done if writing ICAP timeout. */
+	err = wait_for_done(icap);
+
+failed:
+	mutex_unlock(&icap->icap_lock);
+
+	return err;
+}
+
+/*
+ * Discover the FPGA IDCODE using special sequence of canned commands
+ */
+static int icap_probe_chip(struct icap *icap)
+{
+	int err;
+	u32 val = 0;
+
+	regmap_read(icap->regmap, ICAP_REG_SR, &val);
+	if (val != ICAP_STATUS_DONE)
+		return -ENODEV;
+	/* Read ICAP FIFO vacancy */
+	regmap_read(icap->regmap, ICAP_REG_WFV, &val);
+	if (val < 8)
+		return -ENODEV;
+	err = icap_write(icap, idcode_stream, ARRAY_SIZE(idcode_stream));
+	if (err)
+		return err;
+	err = wait_for_done(icap);
+	if (err)
+		return err;
+
+	/* Tell config engine how many words to transfer to read FIFO */
+	regmap_write(icap->regmap, ICAP_REG_SZ, 0x1);
+	/* Switch the ICAP to read mode */
+	regmap_write(icap->regmap, ICAP_REG_CR, 0x2);
+	err = wait_for_done(icap);
+	if (err)
+		return err;
+
+	/* Read IDCODE from Read FIFO */
+	regmap_read(icap->regmap, ICAP_REG_RF, &icap->idcode);
+	return 0;
+}
+
+static int
+xrt_icap_leaf_call(struct platform_device *pdev, u32 cmd, void *arg)
+{
+	struct xrt_icap_wr *wr_arg = arg;
+	struct icap *icap;
+	int ret = 0;
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
+	case XRT_ICAP_GET_IDCODE:
+		*(u32 *)arg = icap->idcode;
+		break;
+	default:
+		ICAP_ERR(icap, "unknown command %d", cmd);
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+static int xrt_icap_probe(struct platform_device *pdev)
+{
+	void __iomem *base = NULL;
+	struct resource *res;
+	struct icap *icap;
+	int result = 0;
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
+	if (!res)
+		return -EINVAL;
+
+	base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	icap->regmap = devm_regmap_init_mmio(&pdev->dev, base, &icap_regmap_config);
+	if (IS_ERR(icap->regmap)) {
+		ICAP_ERR(icap, "init mmio failed");
+		return PTR_ERR(icap->regmap);
+	}
+	/* Disable ICAP interrupts */
+	regmap_write(icap->regmap, ICAP_REG_GIER, 0);
+
+	result = icap_probe_chip(icap);
+	if (result)
+		xrt_err(pdev, "Failed to probe FPGA");
+	else
+		xrt_info(pdev, "Discovered FPGA IDCODE %x", icap->idcode);
+	return result;
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
+		.xsd_leaf_call = xrt_icap_leaf_call,
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
+	.id_table = xrt_icap_table,
+};
+
+XRT_LEAF_INIT_FINI_FUNC(XRT_SUBDEV_ICAP, icap);
-- 
2.27.0


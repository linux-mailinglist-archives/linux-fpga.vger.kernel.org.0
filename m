Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E48963DDD33
	for <lists+linux-fpga@lfdr.de>; Mon,  2 Aug 2021 18:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbhHBQIY (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 2 Aug 2021 12:08:24 -0400
Received: from mail-sn1anam02on2041.outbound.protection.outlook.com ([40.107.96.41]:36462
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229780AbhHBQIX (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 2 Aug 2021 12:08:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AlXTaRgaG2Z2JL+dEaDtnG1UkrnuQ4elkrNmPQOOh0K+vuioJ0OSjwpHNAXgyqFS/z60Z7+15sai5NZOw1S5vFDBbzr5xslLGXG25aPOmkEA9j22B3vijm6OpR/kD9S2suFcAX4Njpb60QH3DvOdQZ7dANwlxk7FHLOcII3DWybKSSxc3B+DlHWTC1UteRyI3ubUcvZgxO+jovY6QJ4MMMz/8WdyB2l58OAXMVeMxCPVwP8n19ln0wZ9Qv+rIgQpClmJ+PArc0FzQPcM3wQJSr8TDcluY9hHFjls3geI5V+GZTBVwMYO4fLX985iCAJyZAJHe+YFaqzzzzfa8c25bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H73oNWFUlPijWaqmttCUfHvL9wgxRm1nQnYKC4IQPPo=;
 b=gBXJMEpxYOQHZiJwB8Mirpog07lLx6WWtvOC8PumctswUBAVUiMQEcueLOLQ3QtJbXYi9yIbef19J55NwH5KtzftEkV5bBGu9mqxL0xhmFJK83fj6ERnaHcMWbX8Ag2csJ2fmK9kQEkyTqibZwP5OLT0REavrimGluWqxXs7xkotXoDULd4JtlpDlzZeEhOPu3LbxbRo2vJg6HTw3gE3aohZUqCDqT9N+oRvVbaqtAUYVD6V8PRVPsRFHOdN68cI0jIOfsv2DrEKn7N/2ORvwFnRtFsxrVHdAMYNO0APL+rPsXjL5XNvpCX3DtIqSVBlgVr0tmaZ7mW2/H8DiCTtAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H73oNWFUlPijWaqmttCUfHvL9wgxRm1nQnYKC4IQPPo=;
 b=NigrWSQPKmrMJTl2yFqBp9J3+OGjjk5eYihtPcQRHm9TpJJH4lHjAmYDzHQ+W0cAeaeiK/Ce6rZTdloI1KPjdXivNQlLdnmrkp5vJiVGHyZuieXsMF9WZWiS8CIqdkJx2BNCmBzmT3noV6bxLn3ztdVnEB4WpcMGtNTMWDqVJoY=
Received: from DM5PR18CA0087.namprd18.prod.outlook.com (2603:10b6:3:3::25) by
 BL3PR02MB8130.namprd02.prod.outlook.com (2603:10b6:208:35d::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4373.19; Mon, 2 Aug 2021 16:08:12 +0000
Received: from DM3NAM02FT052.eop-nam02.prod.protection.outlook.com
 (2603:10b6:3:3:cafe::4d) by DM5PR18CA0087.outlook.office365.com
 (2603:10b6:3:3::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend
 Transport; Mon, 2 Aug 2021 16:08:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT052.mail.protection.outlook.com (10.13.5.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4373.18 via Frontend Transport; Mon, 2 Aug 2021 16:08:12 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 2 Aug 2021 09:07:54 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Mon, 2 Aug 2021 09:07:54 -0700
Envelope-to: mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [10.23.145.232] (port=49072 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1mAaTq-0004L5-Hr; Mon, 02 Aug 2021 09:07:54 -0700
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id 0A67A601B36; Mon,  2 Aug 2021 09:05:30 -0700 (PDT)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>, Max Zhen <max.zhen@xilinx.com>
Subject: [PATCH V9 XRT Alveo 12/14] fpga: xrt: ICAP driver
Date:   Mon, 2 Aug 2021 09:05:19 -0700
Message-ID: <20210802160521.331031-13-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210802160521.331031-1-lizhi.hou@xilinx.com>
References: <20210802160521.331031-1-lizhi.hou@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a385da27-1c2d-42bc-045e-08d955cfba50
X-MS-TrafficTypeDiagnostic: BL3PR02MB8130:
X-Microsoft-Antispam-PRVS: <BL3PR02MB813096A480353F8BB5D0B31BA1EF9@BL3PR02MB8130.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /rI0JzSQqmdJ+Kc4HTKhJQlThDTAh7zrNgKw5HdBeV36fLKSr8bdpp9eK9Keu4Uuu5VPMzlR9DgWm5xyRs651QhRpM39U5GFqLzEUGhGJs7gjrzffJLqG39XDpmmJ7GVd6Lw6BINLptTY7vhvvQ/9O7mbKywemgARIZ1OQRko192HCG2Fo3wi4cV6tW+8aQrBrnmhjUrMjeZOkabp2nv10tbZn926UcTzu5AgICEAPY76vFx3FnHaiNoB3JuQeJPOfE8X0xex4zTNLdhpEAXFLmLskfB/Ex4F88t5ZdHeQfKSoBKVnPE4qkubJROSCRHWhanHVSGC4D17/HhOzuuuJ2ZSZW6UFiR2r3Heps/u3DxGUIyPcV4WNqOATq4aNmMpMCE/F0CqJTg/a4IMuYjuEeVSfVEw/2LH46XDsmoH7JZ/yCXxAZrmMCuP3BVnvirv0nMhcjgENSnv23qEyjHMWt/aLUJiKYKAhRsy/c1kQmmQzmA7mJfPu37G6z11ACqXbomXUESIWlLwNHUTxemue6pMSl27xa9IlHPq1X28UIZ2hurb4l2xXcP8DkAgef178GXlnwfizO16y1BnlgIMQANuB/mPGHh0l171yIQtHBRxKNgWVA7hypyrZOGF2ve9pc4qDh5CGEzQ6uftyUkTiEtpxyQvaWKNvhTWPhxOG4ZY/YjqMxGLhrc60CiGkPa3+eqiSm8Mmmb2e1a08dJ7NschMmakgTew3Cch/cEXn4Hj1DZl4GPar+8qTdS+9auVh1CxTW7oWOV2uqCzqoz19NgER+LXMiT3CYwvwcAnjA=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(136003)(39860400002)(346002)(396003)(376002)(46966006)(36840700001)(966005)(82310400003)(478600001)(7636003)(54906003)(4326008)(8676002)(316002)(1076003)(107886003)(6916009)(6266002)(8936002)(6666004)(26005)(36906005)(36756003)(2906002)(42186006)(2616005)(36860700001)(70206006)(70586007)(83380400001)(47076005)(44832011)(356005)(336012)(82740400003)(5660300002)(186003)(426003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2021 16:08:12.1113
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a385da27-1c2d-42bc-045e-08d955cfba50
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT052.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB8130
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

ICAP stands for Hardware Internal Configuration Access Port. ICAP is
discovered by walking the firmware metadata. A xrt device node will be
created for it. FPGA bitstream is written to hardware through ICAP.

Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
Signed-off-by: Max Zhen <max.zhen@xilinx.com>
Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
Reviewed-by: Tom Rix <trix@redhat.com>
---
 drivers/fpga/xrt/include/xleaf/icap.h |  27 +++
 drivers/fpga/xrt/lib/xleaf/icap.c     | 328 ++++++++++++++++++++++++++
 2 files changed, 355 insertions(+)
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
index 000000000000..071923f61537
--- /dev/null
+++ b/drivers/fpga/xrt/lib/xleaf/icap.c
@@ -0,0 +1,328 @@
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
+	xrt_err((icap)->xdev, fmt "\n", ##arg)
+#define ICAP_WARN(icap, fmt, arg...)	\
+	xrt_warn((icap)->xdev, fmt "\n", ##arg)
+#define ICAP_INFO(icap, fmt, arg...)	\
+	xrt_info((icap)->xdev, fmt "\n", ##arg)
+#define ICAP_DBG(icap, fmt, arg...)	\
+	xrt_dbg((icap)->xdev, fmt "\n", ##arg)
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
+static const __be32 idcode_stream[] = {
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
+XRT_DEFINE_REGMAP_CONFIG(icap_regmap_config);
+
+struct icap {
+	struct xrt_device	*xdev;
+	struct regmap		*regmap;
+	struct mutex		icap_lock; /* icap dev lock */
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
+static int icap_write(const struct icap *icap, const __be32 *word_buf, int size)
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
+static int bitstream_helper(struct icap *icap, const __be32 *word_buffer,
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
+		err = bitstream_helper(icap, (__be32 *)buffer, num_chars_read / sizeof(u32));
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
+xrt_icap_leaf_call(struct xrt_device *xdev, u32 cmd, void *arg)
+{
+	struct xrt_icap_wr *wr_arg = arg;
+	struct icap *icap;
+	int ret = 0;
+
+	icap = xrt_get_drvdata(xdev);
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
+static int xrt_icap_probe(struct xrt_device *xdev)
+{
+	void __iomem *base = NULL;
+	struct resource *res;
+	struct icap *icap;
+	int result = 0;
+
+	icap = devm_kzalloc(&xdev->dev, sizeof(*icap), GFP_KERNEL);
+	if (!icap)
+		return -ENOMEM;
+
+	icap->xdev = xdev;
+	xrt_set_drvdata(xdev, icap);
+	mutex_init(&icap->icap_lock);
+
+	xrt_info(xdev, "probing");
+	res = xrt_get_resource(xdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -EINVAL;
+
+	base = devm_ioremap_resource(&xdev->dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	icap->regmap = devm_regmap_init_mmio(&xdev->dev, base, &icap_regmap_config);
+	if (IS_ERR(icap->regmap)) {
+		ICAP_ERR(icap, "init mmio failed");
+		return PTR_ERR(icap->regmap);
+	}
+	/* Disable ICAP interrupts */
+	regmap_write(icap->regmap, ICAP_REG_GIER, 0);
+
+	result = icap_probe_chip(icap);
+	if (result)
+		xrt_err(xdev, "Failed to probe FPGA");
+	else
+		xrt_info(xdev, "Discovered FPGA IDCODE %x", icap->idcode);
+	return result;
+}
+
+static struct xrt_dev_endpoints xrt_icap_endpoints[] = {
+	{
+		.xse_names = (struct xrt_dev_ep_names[]) {
+			{ .ep_name = XRT_MD_NODE_FPGA_CONFIG },
+			{ NULL },
+		},
+		.xse_min_ep = 1,
+	},
+	{ 0 },
+};
+
+static struct xrt_driver xrt_icap_driver = {
+	.driver = {
+		.name = XRT_ICAP,
+	},
+	.subdev_id = XRT_SUBDEV_ICAP,
+	.endpoints = xrt_icap_endpoints,
+	.probe = xrt_icap_probe,
+	.leaf_call = xrt_icap_leaf_call,
+};
+
+XRT_LEAF_INIT_FINI_FUNC(icap);
-- 
2.27.0


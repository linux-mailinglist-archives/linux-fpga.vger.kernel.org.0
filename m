Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82764393AAE
	for <lists+linux-fpga@lfdr.de>; Fri, 28 May 2021 02:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235571AbhE1AzI (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 27 May 2021 20:55:08 -0400
Received: from mail-bn7nam10on2057.outbound.protection.outlook.com ([40.107.92.57]:36544
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235586AbhE1Ay7 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 27 May 2021 20:54:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OKpRxaxNcjTzMhKSwWrGZcjYKUYedATUC31q2A2JAFFWbCClgbC8XSw9t5Bg/v67ZFuTDC2JA2kmHdM2cTNduUQl8/uVZM+skbwgM04tJ9Xlx0I/0ac3pbhnMXCvUTh63ihqehxpAQdLQHf5e8aKL2dqdZhn94G5tuLzui+m0VIpqO/dygkfd0MI0wx7yehQCTQpTIpSUQgBhIh+DYZyTs8YPHdXQnm9YR7st+XH5qMbQaUiiIZ6REL+r4jUBKOS7twXp2F4UDQbvy0c6RVQi5f0UT6tteChD0EWwGE7pWUTUF3tbDgOidwuc6ZWRYTGD1sO180F1TCFA5FLebCMOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H73oNWFUlPijWaqmttCUfHvL9wgxRm1nQnYKC4IQPPo=;
 b=PAUVuVxT75G7wftZg48wYXN1VF0isz5bUnJDCCBPdK6j8Myc58H38Gkvc7NwAWTYc7sOJayU7u04zmChvLIdf6fxH3DI1ZavP1JVs2akeAVB/8kQwM8gkkoP4H5/yxyHZ2J2G3wn+riqdK2SaQJvDTmmWyjRClSfcYKfaxONc6QbJTgwAv0Z2LH+iACKwG61kPDu6yqtpVTI8USzCZtTQY5z00YsVhQdo9akFDpJywh9XHB2llEz2iPr2Pq6S7w+WAkm4d6a0XAdO40QS1XFdl6nerMAr8ZtRv0HzEHdVga6mpp/DE46043U1MwGxxvbidD6ulGPQa904OK7qXd2Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H73oNWFUlPijWaqmttCUfHvL9wgxRm1nQnYKC4IQPPo=;
 b=ejIbI7V980MzJ7nYlY9+3vht4dzS86VO1KJk0LgUShWyWQ+9YhGToKB78w3xWjZr9LKr7MXPLYNSvDHdxVr+qDaF2cnnN0cVKBVCk076NL5daqL0elEEvKawLDAIK7uTzj+MQHTfIyvwTCSkNYKeNW8Ni74iQcuywskRAdEDEQI=
Received: from SA0PR11CA0014.namprd11.prod.outlook.com (2603:10b6:806:d3::19)
 by DM6PR02MB5033.namprd02.prod.outlook.com (2603:10b6:5:43::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.25; Fri, 28 May
 2021 00:53:21 +0000
Received: from SN1NAM02FT0062.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:d3:cafe::7c) by SA0PR11CA0014.outlook.office365.com
 (2603:10b6:806:d3::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.24 via Frontend
 Transport; Fri, 28 May 2021 00:53:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0062.mail.protection.outlook.com (10.97.4.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4150.30 via Frontend Transport; Fri, 28 May 2021 00:53:21 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 27 May 2021 17:52:56 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Thu, 27 May 2021 17:52:56 -0700
Envelope-to: mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.73.109] (port=34034 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1lmQkC-0003dW-4W; Thu, 27 May 2021 17:52:56 -0700
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id 06D616032B0; Thu, 27 May 2021 17:50:07 -0700 (PDT)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>, Max Zhen <max.zhen@xilinx.com>
Subject: [PATCH V7 XRT Alveo 14/20] fpga: xrt: ICAP driver
Date:   Thu, 27 May 2021 17:49:53 -0700
Message-ID: <20210528004959.61354-15-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210528004959.61354-1-lizhi.hou@xilinx.com>
References: <20210528004959.61354-1-lizhi.hou@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d1fd9af-ff3c-4ac9-91d9-08d92172fd80
X-MS-TrafficTypeDiagnostic: DM6PR02MB5033:
X-Microsoft-Antispam-PRVS: <DM6PR02MB50331D5D54A5EE3AF71D6013A1229@DM6PR02MB5033.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VNeJ//g7JfU1DQFVyI0Y0/81/L3fataz1S/mPPTFjmpXHMjsZxc4Ql85Uvby6+X79bfUwXps6rSw9eTB9TQpbSxTMYDM3NF7Hxd7BHdVJ104HfoAQLPPcpsbPjIublHSaM3ARflgFQ9KD809FRmfpRrzQZfFSgEhSo1YWp141DTTUTquXaCWlu+RsxAGMdCFj4Ffto+epnLOPphFlKx/zxSakl8S+t8gb+d6tNbEKGlWLI5z0NgIuGoP/pb0J60f6vi9WWmBrWIkH/u6zXUDGJmqvXKCDBkT6d9iYO5pANtyrPW5buqLdc2itBmmdZG4rEgtv4nEFcRoTJwvjkDzQk/IePvSnU5ZCvWVhWjXe3FIoybkau/6rcwR3eh3nkhcw/unG8iXmYlj09ELVna8nKTgkhEXEOaAduAA1HvsbQT3Q2My4yEgx0EK5/uwAUIJop+dNAW0qxKa2Fa1b5v2KwzdDJRa70PD2H/0rax7eqrIF3e5NNR+uhf4wISLybwI7R5fueIpFeWtwNG9W9g+ctKXQiYOmSHwFldmi6iVb7DzotAWtlNhd90ono2xIJoq5GDLi7Cfir/GtQla6l4xAYHUXeeTFSQzVPmcj8TOtplIXQ+iiTr/FfDGgWJY3yqW/3rXFtfo+7OpJINJLXHoy4goPl2hX9CSvTgDSI8BRtuEbb4gFXBy1akZdLZ6YlcX4qj1Yb6LKA9F5UvpxGEBnldPnxX6jjo2BWc6ql1m00/xgR2gj3Qqo8TZr7gt0hekGxRDlJKnLrUukScmRDSv1w==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(376002)(39850400004)(36840700001)(46966006)(2906002)(2616005)(6266002)(107886003)(186003)(316002)(54906003)(478600001)(5660300002)(26005)(426003)(47076005)(966005)(83380400001)(6666004)(82740400003)(36756003)(8936002)(42186006)(6916009)(82310400003)(4326008)(356005)(70586007)(7636003)(70206006)(1076003)(336012)(8676002)(36860700001)(44832011);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 00:53:21.1886
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d1fd9af-ff3c-4ac9-91d9-08d92172fd80
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0062.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5033
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


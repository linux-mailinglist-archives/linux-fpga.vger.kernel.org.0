Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42EF7393A89
	for <lists+linux-fpga@lfdr.de>; Fri, 28 May 2021 02:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235625AbhE1AxA (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 27 May 2021 20:53:00 -0400
Received: from mail-mw2nam08on2052.outbound.protection.outlook.com ([40.107.101.52]:3841
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235612AbhE1Aw7 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 27 May 2021 20:52:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R2vsnHZjU+RnbKuVq02zTm8smum8mkiiP245n+okcMDLIQn+DEhtVKsjen/lzRyVy3I4Ps1ueIuOO4kvKtW4dSAefZPOKEd2CSqJsrcPg8LdT/H0MkvIPEhDwffMDxqEnXC16CW3w+rV7C+KNGbn40kyIvRGqHSWIZqP8B5+EDi5pv/puI8F9BQbpwKcuAkoKF2bN6fhMZoynNu+5wpxFkr6OovsUrdv0TO0b5amOXsg74jCLujBJypGQC6kktF91z6BFTZ2PxC8PT+0/7CJuf0c5G9ClXj40sQIxI38uR085nMebT3ODbzrclDch8yFhCrj9rfg6nyojZcGayhabA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EcGZpgHowAkTMHSG/tiGDXIa/bEWyW/fV5vueCk/JOs=;
 b=kHFPWnRHcvwwxINFNoZwXYqVhTbGeMHosBO1tzIjPIi2MNn7Iq9tR3EGWObrX/mlOiYQN8hcPeXKvCX0t1YcA5/DWt8GcURTevJeOwjvRIHeYIsF6/fq6yl9vjEokaJUJs1a5EPgMmOpUb9u7v4k+RFdyZhSFLH81dNlSvfKxhun0rCnPTrV5X9eVEN0OC9jZVQJMATvkJ5gJzlGZPo/vzfhGHuyrg/WS+W8eklsEI3PgXUdU9a2yIeENKupJMFVBe4ESgX0NNDX+q0hj72a2NqtapQjZmnFbPYp4w4+c/worl2hfl7uwpoHXLe/lLhbdipG5zmEVEhdcgggtP31jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EcGZpgHowAkTMHSG/tiGDXIa/bEWyW/fV5vueCk/JOs=;
 b=eE0N3aVC71C8HUegRKiR7hcG+ZJMHhXyl+Ex2mCTIvbprv5crxbRKcmeGzEe0sm9A7Jndh+N0tv2/TgsWaXyTm334ydGKv0l40ahwxmWDdzWGkJ4DUUH3IUE8vhVHW1ZxbKn0xYTt25lf7fihYyxEVS36TxnXItR4y+unEtrp8s=
Received: from BN9PR03CA0776.namprd03.prod.outlook.com (2603:10b6:408:13a::31)
 by SJ0PR02MB7808.namprd02.prod.outlook.com (2603:10b6:a03:326::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Fri, 28 May
 2021 00:51:22 +0000
Received: from BN1NAM02FT055.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:13a:cafe::dc) by BN9PR03CA0776.outlook.office365.com
 (2603:10b6:408:13a::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Fri, 28 May 2021 00:51:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT055.mail.protection.outlook.com (10.13.2.163) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4150.30 via Frontend Transport; Fri, 28 May 2021 00:51:21 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 27 May 2021 17:50:43 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Thu, 27 May 2021 17:50:43 -0700
Envelope-to: mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.73.109] (port=34010 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1lmQi3-0007Am-Js; Thu, 27 May 2021 17:50:43 -0700
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id 154F56032A6; Thu, 27 May 2021 17:50:06 -0700 (PDT)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>, Max Zhen <max.zhen@xilinx.com>
Subject: [PATCH V7 XRT Alveo 03/20] fpga: xrt: xclbin file helper functions
Date:   Thu, 27 May 2021 17:49:42 -0700
Message-ID: <20210528004959.61354-4-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210528004959.61354-1-lizhi.hou@xilinx.com>
References: <20210528004959.61354-1-lizhi.hou@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b09cc833-f0fa-4443-0471-08d92172b635
X-MS-TrafficTypeDiagnostic: SJ0PR02MB7808:
X-Microsoft-Antispam-PRVS: <SJ0PR02MB780853B1FC91864457BF0B20A1229@SJ0PR02MB7808.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3czgZDV3HhDiXkMgF0a5yIhdLfeSZXI9Yw4paGfpjNx8d8EWm4nkwXCpAIJpajvDrW9OaM/2ne++hWjBFutGWCU9096xtYJvHD+dhfDltRsXYGT0f9h4/T6RZRu6cSfa2tu4lfMvUUttxf4ti/3N61hzsOcDe+I8czZv7ayuV5WOEud667yhGYUSvKcoFEFMY1CF6fNEquYo8+k8fP1WJWWxTl7e8WCkcjPPxs4/alMbuqdyse0WVJNE2esSlTsp01ClJNd/uc22yuoAgXIknOM0Fre6D8ly3KLf5n/TWkyDnV0LtdIjUn2PBq0Tm9yXaKl/058Qd3+7Km8JWzVBem4alJlw7VhIZU4LJWYCDgHu63p3iDbA3sElPSILK+p2qS1TByPE1cC1DPCSelzgn1EUyL8LIoRfd8GvyBDYZZHQxEd+NVGhZPP3xmpMXv7uhTpEzSuunBEY/0V9vyzhltKu+b70EsLDl5/IlHGaBheiG19kW1o9ehlzFslx22xe2mNKeezjdUEdj4yh2WI2OO2WNxag8Du924uRWozkryepoBU7RCUNMgHA0AI8ZDGTq0oUJC358+L8uhIyGQ99gyRdvD2YPvmYF5eZATYOXHnVJ1H+s7JW5lYF0mh+zJz6EbDRjYcLdtZRrqq94eCBbLNKNnVbGyEd3sjIRspldSg=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(39850400004)(346002)(376002)(396003)(136003)(46966006)(36840700001)(70586007)(36756003)(1076003)(4326008)(36860700001)(30864003)(478600001)(47076005)(70206006)(356005)(7636003)(2906002)(82740400003)(2616005)(426003)(5660300002)(44832011)(54906003)(83380400001)(6916009)(8936002)(8676002)(42186006)(316002)(6266002)(107886003)(26005)(6666004)(186003)(336012)(82310400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 00:51:21.5002
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b09cc833-f0fa-4443-0471-08d92172b635
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT055.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7808
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Alveo FPGA firmware and partial reconfigure file are in xclbin format. This
code enumerates and extracts sections from xclbin files. xclbin.h is cross
platform and used across all platforms and OS.

Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
Signed-off-by: Max Zhen <max.zhen@xilinx.com>
Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
Reviewed-by: Tom Rix <trix@redhat.com>
---
 drivers/fpga/xrt/include/xclbin-helper.h |  48 +++
 drivers/fpga/xrt/lib/xclbin.c            | 381 +++++++++++++++++++++
 include/uapi/linux/xrt/xclbin.h          | 409 +++++++++++++++++++++++
 3 files changed, 838 insertions(+)
 create mode 100644 drivers/fpga/xrt/include/xclbin-helper.h
 create mode 100644 drivers/fpga/xrt/lib/xclbin.c
 create mode 100644 include/uapi/linux/xrt/xclbin.h

diff --git a/drivers/fpga/xrt/include/xclbin-helper.h b/drivers/fpga/xrt/include/xclbin-helper.h
new file mode 100644
index 000000000000..d5e29a882cd1
--- /dev/null
+++ b/drivers/fpga/xrt/include/xclbin-helper.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2021 Xilinx, Inc.
+ *
+ * Authors:
+ *    David Zhang <davidzha@xilinx.com>
+ *    Sonal Santan <sonal.santan@xilinx.com>
+ */
+
+#ifndef _XCLBIN_HELPER_H_
+#define _XCLBIN_HELPER_H_
+
+#include <linux/types.h>
+#include <linux/device.h>
+#include <linux/xrt/xclbin.h>
+
+#define XCLBIN_VERSION2	"xclbin2"
+#define XCLBIN_HWICAP_BITFILE_BUF_SZ 1024
+#define XCLBIN_MAX_SZ_1G (1024 * 1024 * 1024) /* Assuming xclbin <= 1G, always */
+
+enum axlf_section_kind;
+struct axlf;
+
+/**
+ * Bitstream header information as defined by Xilinx tools.
+ * Please note that this struct definition is not owned by the driver.
+ */
+struct xclbin_bit_head_info {
+	u32 header_length;		/* Length of header in 32 bit words */
+	u32 bitstream_length;		/* Length of bitstream to read in bytes */
+	const unchar *design_name;	/* Design name get from bitstream */
+	const unchar *part_name;	/* Part name read from bitstream */
+	const unchar *date;		/* Date read from bitstream header */
+	const unchar *time;		/* Bitstream creation time */
+	u32 magic_length;		/* Length of the magic numbers */
+	const unchar *version;		/* Version string */
+};
+
+/* caller must free the allocated memory for **data. len could be NULL. */
+int xrt_xclbin_get_section(struct device *dev,  const struct axlf *xclbin,
+			   enum axlf_section_kind kind, void **data,
+			   uint64_t *len);
+int xrt_xclbin_get_metadata(struct device *dev, const struct axlf *xclbin, char **dtb);
+int xrt_xclbin_parse_bitstream_header(struct device *dev, const unchar *data,
+				      u32 size, struct xclbin_bit_head_info *head_info);
+const char *xrt_clock_type2epname(enum XCLBIN_CLOCK_TYPE type);
+
+#endif /* _XCLBIN_HELPER_H_ */
diff --git a/drivers/fpga/xrt/lib/xclbin.c b/drivers/fpga/xrt/lib/xclbin.c
new file mode 100644
index 000000000000..6edac3d418be
--- /dev/null
+++ b/drivers/fpga/xrt/lib/xclbin.c
@@ -0,0 +1,381 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx Alveo FPGA Driver XCLBIN parser
+ *
+ * Copyright (C) 2020-2021 Xilinx, Inc.
+ *
+ * Authors: David Zhang <davidzha@xilinx.com>
+ */
+
+#include <asm/errno.h>
+#include <linux/vmalloc.h>
+#include <linux/device.h>
+#include "xclbin-helper.h"
+#include "metadata.h"
+
+/* Used for parsing bitstream header */
+#define BITSTREAM_EVEN_MAGIC_BYTE	0x0f
+#define BITSTREAM_ODD_MAGIC_BYTE	0xf0
+
+static inline u16 bitstream_read16(const char *data, u32 *offset)
+{
+	u16 val;
+
+	val = be16_to_cpu(*(__be16 *)(data + *offset));
+	*offset += sizeof(__be16);
+
+	return val;
+}
+
+static inline u32 bitstream_read32(const char *data, u32 *offset)
+{
+	u32 val;
+
+	val = be32_to_cpu(*(__be32 *)(data + *offset));
+	*offset += sizeof(__be32);
+
+	return val;
+}
+
+static int xrt_xclbin_get_section_hdr(const struct axlf *xclbin,
+				      enum axlf_section_kind kind,
+				      const struct axlf_section_header **header)
+{
+	const struct axlf_section_header *phead = NULL;
+	u64 xclbin_len;
+	int i;
+
+	*header = NULL;
+	for (i = 0; i < xclbin->header.num_sections; i++) {
+		if (xclbin->sections[i].section_kind == kind) {
+			phead = &xclbin->sections[i];
+			break;
+		}
+	}
+
+	if (!phead)
+		return -ENOENT;
+
+	xclbin_len = xclbin->header.length;
+	if (xclbin_len > XCLBIN_MAX_SZ_1G || !phead->section_size ||
+	    phead->section_offset + phead->section_size > xclbin_len)
+		return -EINVAL;
+
+	*header = phead;
+	return 0;
+}
+
+static int xrt_xclbin_section_info(const struct axlf *xclbin,
+				   enum axlf_section_kind kind,
+				   u64 *offset, u64 *size)
+{
+	const struct axlf_section_header *mem_header = NULL;
+	int rc;
+
+	rc = xrt_xclbin_get_section_hdr(xclbin, kind, &mem_header);
+	if (rc)
+		return rc;
+
+	*offset = mem_header->section_offset;
+	*size = mem_header->section_size;
+
+	return 0;
+}
+
+/* caller must free the allocated memory for **data */
+int xrt_xclbin_get_section(struct device *dev,
+			   const struct axlf *buf,
+			   enum axlf_section_kind kind,
+			   void **data, u64 *len)
+{
+	const struct axlf *xclbin = (const struct axlf *)buf;
+	void *section = NULL;
+	u64 offset;
+	u64 size;
+	int err;
+
+	if (!data) {
+		dev_err(dev, "invalid data pointer");
+		return -EINVAL;
+	}
+
+	err = xrt_xclbin_section_info(xclbin, kind, &offset, &size);
+	if (err) {
+		dev_dbg(dev, "parsing section failed. kind %d, err = %d", kind, err);
+		return err;
+	}
+
+	section = vzalloc(size);
+	if (!section)
+		return -ENOMEM;
+
+	memcpy(section, ((const char *)xclbin) + offset, size);
+
+	*data = section;
+	if (len)
+		*len = size;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(xrt_xclbin_get_section);
+
+static inline int xclbin_bit_get_string(const unchar *data, u32 size,
+					u32 offset, unchar prefix,
+					const unchar **str)
+{
+	int len;
+	u32 tmp;
+
+	/* prefix and length will be 3 bytes */
+	if (offset + 3  > size)
+		return -EINVAL;
+
+	/* Read prefix */
+	tmp = data[offset++];
+	if (tmp != prefix)
+		return -EINVAL;
+
+	/* Get string length */
+	len = bitstream_read16(data, &offset);
+	if (offset + len > size)
+		return -EINVAL;
+
+	if (data[offset + len - 1] != '\0')
+		return -EINVAL;
+
+	*str = data + offset;
+
+	return len + 3;
+}
+
+/* parse bitstream header */
+int xrt_xclbin_parse_bitstream_header(struct device *dev, const unchar *data,
+				      u32 size, struct xclbin_bit_head_info *head_info)
+{
+	u32 offset = 0;
+	int len, i;
+	u16 magic;
+
+	memset(head_info, 0, sizeof(*head_info));
+
+	/* Get "Magic" length */
+	if (size < sizeof(u16)) {
+		dev_err(dev, "invalid size");
+		return -EINVAL;
+	}
+
+	len = bitstream_read16(data, &offset);
+	if (offset + len > size) {
+		dev_err(dev, "invalid magic len");
+		return -EINVAL;
+	}
+	head_info->magic_length = len;
+
+	for (i = 0; i < head_info->magic_length - 1; i++) {
+		magic = data[offset++];
+		if (!(i % 2) && magic != BITSTREAM_EVEN_MAGIC_BYTE) {
+			dev_err(dev, "invalid magic even byte at %d", offset);
+			return -EINVAL;
+		}
+
+		if ((i % 2) && magic != BITSTREAM_ODD_MAGIC_BYTE) {
+			dev_err(dev, "invalid magic odd byte at %d", offset);
+			return -EINVAL;
+		}
+	}
+
+	if (offset + 3 > size) {
+		dev_err(dev, "invalid length of magic end");
+		return -EINVAL;
+	}
+	/* Read null end of magic data. */
+	if (data[offset++]) {
+		dev_err(dev, "invalid magic end");
+		return -EINVAL;
+	}
+
+	/* Read 0x01 (short) */
+	magic = bitstream_read16(data, &offset);
+
+	/* Check the "0x01" half word */
+	if (magic != 0x01) {
+		dev_err(dev, "invalid magic end");
+		return -EINVAL;
+	}
+
+	len = xclbin_bit_get_string(data, size, offset, 'a', &head_info->design_name);
+	if (len < 0) {
+		dev_err(dev, "get design name failed");
+		return -EINVAL;
+	}
+
+	head_info->version = strstr(head_info->design_name, "Version=") + strlen("Version=");
+	offset += len;
+
+	len = xclbin_bit_get_string(data, size, offset, 'b', &head_info->part_name);
+	if (len < 0) {
+		dev_err(dev, "get part name failed");
+		return -EINVAL;
+	}
+	offset += len;
+
+	len = xclbin_bit_get_string(data, size, offset, 'c', &head_info->date);
+	if (len < 0) {
+		dev_err(dev, "get data failed");
+		return -EINVAL;
+	}
+	offset += len;
+
+	len = xclbin_bit_get_string(data, size, offset, 'd', &head_info->time);
+	if (len < 0) {
+		dev_err(dev, "get time failed");
+		return -EINVAL;
+	}
+	offset += len;
+
+	if (offset + 5 >= size) {
+		dev_err(dev, "can not get bitstream length");
+		return -EINVAL;
+	}
+
+	/* Read 'e' */
+	if (data[offset++] != 'e') {
+		dev_err(dev, "invalid prefix of bitstream length");
+		return -EINVAL;
+	}
+
+	/* Get byte length of bitstream */
+	head_info->bitstream_length = bitstream_read32(data, &offset);
+
+	head_info->header_length = offset;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(xrt_xclbin_parse_bitstream_header);
+
+static struct xrt_clock_desc {
+	char	*clock_ep_name;
+	u32	clock_xclbin_type;
+	char	*clkfreq_ep_name;
+} clock_desc[] = {
+	{
+		.clock_ep_name = XRT_MD_NODE_CLK_KERNEL1,
+		.clock_xclbin_type = CT_DATA,
+		.clkfreq_ep_name = XRT_MD_NODE_CLKFREQ_K1,
+	},
+	{
+		.clock_ep_name = XRT_MD_NODE_CLK_KERNEL2,
+		.clock_xclbin_type = CT_KERNEL,
+		.clkfreq_ep_name = XRT_MD_NODE_CLKFREQ_K2,
+	},
+	{
+		.clock_ep_name = XRT_MD_NODE_CLK_KERNEL3,
+		.clock_xclbin_type = CT_SYSTEM,
+		.clkfreq_ep_name = XRT_MD_NODE_CLKFREQ_HBM,
+	},
+};
+
+const char *xrt_clock_type2epname(enum XCLBIN_CLOCK_TYPE type)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(clock_desc); i++) {
+		if (clock_desc[i].clock_xclbin_type == type)
+			return clock_desc[i].clock_ep_name;
+	}
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(xrt_clock_type2epname);
+
+static const char *clock_type2clkfreq_name(enum XCLBIN_CLOCK_TYPE type)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(clock_desc); i++) {
+		if (clock_desc[i].clock_xclbin_type == type)
+			return clock_desc[i].clkfreq_ep_name;
+	}
+	return NULL;
+}
+
+static int xrt_xclbin_add_clock_metadata(struct device *dev,
+					 const struct axlf *xclbin,
+					 char *dtb)
+{
+	struct clock_freq_topology *clock_topo;
+	u16 freq;
+	int rc;
+	int i;
+
+	/* if clock section does not exist, add nothing and return success */
+	rc = xrt_xclbin_get_section(dev, xclbin, CLOCK_FREQ_TOPOLOGY,
+				    (void **)&clock_topo, NULL);
+	if (rc == -ENOENT)
+		return 0;
+	else if (rc)
+		return rc;
+
+	for (i = 0; i < clock_topo->count; i++) {
+		u8 type = clock_topo->clock_freq[i].type;
+		const char *ep_name = xrt_clock_type2epname(type);
+		const char *counter_name = clock_type2clkfreq_name(type);
+
+		if (!ep_name || !counter_name)
+			continue;
+
+		freq = be16_to_cpu((__force __be16)clock_topo->clock_freq[i].freq_MHZ);
+		rc = xrt_md_set_prop(dev, dtb, ep_name, NULL, XRT_MD_PROP_CLK_FREQ,
+				     &freq, sizeof(freq));
+		if (rc)
+			break;
+
+		rc = xrt_md_set_prop(dev, dtb, ep_name, NULL, XRT_MD_PROP_CLK_CNT,
+				     counter_name, strlen(counter_name) + 1);
+		if (rc)
+			break;
+	}
+
+	vfree(clock_topo);
+
+	return rc;
+}
+
+int xrt_xclbin_get_metadata(struct device *dev, const struct axlf *xclbin, char **dtb)
+{
+	char *md = NULL, *newmd = NULL;
+	u64 len, md_len;
+	int rc;
+
+	*dtb = NULL;
+
+	rc = xrt_xclbin_get_section(dev, xclbin, PARTITION_METADATA, (void **)&md, &len);
+	if (rc)
+		goto done;
+
+	md_len = xrt_md_size(dev, md);
+
+	/* Sanity check the dtb section. */
+	if (md_len > len) {
+		rc = -EINVAL;
+		goto done;
+	}
+
+	/* use dup function here to convert incoming metadata to writable */
+	newmd = xrt_md_dup(dev, md);
+	if (!newmd) {
+		rc = -EFAULT;
+		goto done;
+	}
+
+	/* Convert various needed xclbin sections into dtb. */
+	rc = xrt_xclbin_add_clock_metadata(dev, xclbin, newmd);
+
+	if (!rc)
+		*dtb = newmd;
+	else
+		vfree(newmd);
+done:
+	vfree(md);
+	return rc;
+}
+EXPORT_SYMBOL_GPL(xrt_xclbin_get_metadata);
diff --git a/include/uapi/linux/xrt/xclbin.h b/include/uapi/linux/xrt/xclbin.h
new file mode 100644
index 000000000000..fdaf0c91843d
--- /dev/null
+++ b/include/uapi/linux/xrt/xclbin.h
@@ -0,0 +1,409 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ *  Xilinx FPGA compiled binary container format
+ *
+ *  Copyright (C) 2015-2021, Xilinx Inc
+ */
+
+#ifndef _XCLBIN_H_
+#define _XCLBIN_H_
+
+#if defined(__KERNEL__)
+
+#include <linux/types.h>
+
+#elif defined(__cplusplus)
+
+#include <cstdlib>
+#include <cstdint>
+#include <algorithm>
+#include <uuid/uuid.h>
+
+#else
+
+#include <stdlib.h>
+#include <stdint.h>
+#include <uuid/uuid.h>
+
+#endif
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+/**
+ * DOC: Container format for Xilinx FPGA images
+ * The container stores bitstreams, metadata and firmware images.
+ * xclbin/xsabin is an ELF-like binary container format. It is a structured
+ * series of sections. There is a file header followed by several section
+ * headers which is followed by sections. A section header points to an
+ * actual section. There is an optional signature at the end. The
+ * following figure illustrates a typical xclbin:
+ *
+ *     +---------------------+
+ *     |                     |
+ *     |       HEADER        |
+ *     +---------------------+
+ *     |   SECTION  HEADER   |
+ *     |                     |
+ *     +---------------------+
+ *     |        ...          |
+ *     |                     |
+ *     +---------------------+
+ *     |   SECTION  HEADER   |
+ *     |                     |
+ *     +---------------------+
+ *     |       SECTION       |
+ *     |                     |
+ *     +---------------------+
+ *     |         ...         |
+ *     |                     |
+ *     +---------------------+
+ *     |       SECTION       |
+ *     |                     |
+ *     +---------------------+
+ *     |      SIGNATURE      |
+ *     |      (OPTIONAL)     |
+ *     +---------------------+
+ */
+
+enum XCLBIN_MODE {
+	XCLBIN_FLAT = 0,
+	XCLBIN_PR,
+	XCLBIN_TANDEM_STAGE2,
+	XCLBIN_TANDEM_STAGE2_WITH_PR,
+	XCLBIN_HW_EMU,
+	XCLBIN_SW_EMU,
+	XCLBIN_MODE_MAX
+};
+
+enum axlf_section_kind {
+	BITSTREAM = 0,
+	CLEARING_BITSTREAM,
+	EMBEDDED_METADATA,
+	FIRMWARE,
+	DEBUG_DATA,
+	SCHED_FIRMWARE,
+	MEM_TOPOLOGY,
+	CONNECTIVITY,
+	IP_LAYOUT,
+	DEBUG_IP_LAYOUT,
+	DESIGN_CHECK_POINT,
+	CLOCK_FREQ_TOPOLOGY,
+	MCS,
+	BMC,
+	BUILD_METADATA,
+	KEYVALUE_METADATA,
+	USER_METADATA,
+	DNA_CERTIFICATE,
+	PDI,
+	BITSTREAM_PARTIAL_PDI,
+	PARTITION_METADATA,
+	EMULATION_DATA,
+	SYSTEM_METADATA,
+	SOFT_KERNEL,
+	ASK_FLASH,
+	AIE_METADATA,
+	ASK_GROUP_TOPOLOGY,
+	ASK_GROUP_CONNECTIVITY
+};
+
+enum MEM_TYPE {
+	MEM_DDR3 = 0,
+	MEM_DDR4,
+	MEM_DRAM,
+	MEM_STREAMING,
+	MEM_PREALLOCATED_GLOB,
+	MEM_ARE,
+	MEM_HBM,
+	MEM_BRAM,
+	MEM_URAM,
+	MEM_STREAMING_CONNECTION
+};
+
+enum IP_TYPE {
+	IP_MB = 0,
+	IP_KERNEL,
+	IP_DNASC,
+	IP_DDR4_CONTROLLER,
+	IP_MEM_DDR4,
+	IP_MEM_HBM
+};
+
+struct axlf_section_header {
+	uint32_t section_kind;	    /* Section type */
+	char section_name[16];	    /* Examples: "stage2", "clear1", */
+				    /* "clear2", "ocl1", "ocl2, */
+				    /* "ublaze", "sched" */
+	char rsvd[4];
+	uint64_t section_offset;    /* File offset of section data */
+	uint64_t section_size;	    /* Size of section data */
+} __packed;
+
+struct axlf_header {
+	uint64_t length;		    /* Total size of the xclbin file */
+	uint64_t time_stamp;		    /* Number of seconds since epoch */
+					    /* when xclbin was created */
+	uint64_t feature_rom_timestamp;     /* TimeSinceEpoch of the featureRom */
+	uint16_t version_patch;	    /* Patch Version */
+	uint8_t version_major;	    /* Major Version - Version: 2.1.0 */
+	uint8_t version_minor;	    /* Minor Version */
+	uint32_t mode;		    /* XCLBIN_MODE */
+	union {
+		struct {
+			uint64_t platform_id;	/* 64 bit platform ID: */
+					/* vendor-device-subvendor-subdev */
+			uint64_t feature_id;	/* 64 bit feature id */
+		} rom;
+		unsigned char rom_uuid[16];	/* feature ROM UUID for which */
+						/* this xclbin was generated */
+	};
+	unsigned char platform_vbnv[64];	/* e.g. */
+		/* xilinx:xil-accel-rd-ku115:4ddr-xpr:3.4: null terminated */
+	union {
+		char next_axlf[16];		/* Name of next xclbin file */
+						/* in the daisy chain */
+		unsigned char uuid[16];		/* uuid of this xclbin */
+	};
+	char debug_bin[16];			/* Name of binary with debug */
+						/* information */
+	uint32_t num_sections;		/* Number of section headers */
+	char rsvd[4];
+} __packed;
+
+struct axlf {
+	char magic[8];			/* Should be "xclbin2\0" */
+	int32_t signature_length;		/* Length of the signature */
+						/* -1 indicates no signature */
+	unsigned char reserved[28];		/* Note: Initialized to 0xFFs */
+
+	unsigned char key_block[256];		/* Signature for validation */
+						/* of binary */
+	uint64_t unique_id;			/* axlf's uniqueId, use it to */
+						/* skip redownload etc */
+	struct axlf_header header;		/* Inline header */
+	struct axlf_section_header sections[1];   /* One or more section */
+						    /* headers follow */
+} __packed;
+
+/* bitstream information */
+struct xlnx_bitstream {
+	uint8_t freq[8];
+	char bits[1];
+} __packed;
+
+/****	MEMORY TOPOLOGY SECTION ****/
+struct mem_data {
+	uint8_t type; /* enum corresponding to mem_type */
+	uint8_t used; /* if 0 this bank is not present */
+	uint8_t rsvd[6];
+	union {
+		uint64_t size; /* if mem_type DDR, then size in KB */
+		uint64_t route_id; /* if streaming then "route_id" */
+	};
+	union {
+		uint64_t base_address;/* if DDR then the base address */
+		uint64_t flow_id; /* if streaming then "flow id" */
+	};
+	unsigned char tag[16]; /* DDR: BANK0,1,2,3, has to be null */
+			/* terminated; if streaming then stream0, 1 etc */
+} __packed;
+
+struct mem_topology {
+	int32_t count; /* Number of mem_data */
+	struct mem_data mem_data[1]; /* Should be sorted on mem_type */
+} __packed;
+
+/****	CONNECTIVITY SECTION ****/
+/* Connectivity of each argument of CU(Compute Unit). It will be in terms
+ * of argument index associated. For associating CU instances with arguments
+ * and banks, start at the connectivity section. Using the ip_layout_index
+ * access the ip_data.name. Now we can associate this CU instance with its
+ * original CU name and get the connectivity as well. This enables us to form
+ * related groups of CU instances.
+ */
+
+struct connection {
+	int32_t arg_index; /* From 0 to n, may not be contiguous as scalars */
+			   /* skipped */
+	int32_t ip_layout_index; /* index into the ip_layout section */
+			   /* ip_layout.ip_data[index].type == IP_KERNEL */
+	int32_t mem_data_index; /* index of the mem_data . Flag error is */
+				/* used false. */
+} __packed;
+
+struct connectivity {
+	int32_t count;
+	struct connection connection[1];
+} __packed;
+
+/****	IP_LAYOUT SECTION ****/
+
+/* IP Kernel */
+#define IP_INT_ENABLE_MASK	  0x0001
+#define IP_INTERRUPT_ID_MASK  0x00FE
+#define IP_INTERRUPT_ID_SHIFT 0x1
+
+enum IP_CONTROL {
+	AP_CTRL_HS = 0,
+	AP_CTRL_CHAIN,
+	AP_CTRL_NONE,
+	AP_CTRL_ME,
+	ACCEL_ADAPTER
+};
+
+#define IP_CONTROL_MASK	 0xFF00
+#define IP_CONTROL_SHIFT 0x8
+
+/* IPs on AXI lite - their types, names, and base addresses. */
+struct ip_data {
+	uint32_t type; /* map to IP_TYPE enum */
+	union {
+		uint32_t properties; /* Default: 32-bits to indicate ip */
+				     /* specific property. */
+		/* type: IP_KERNEL
+		 *	    int_enable   : Bit  - 0x0000_0001;
+		 *	    interrupt_id : Bits - 0x0000_00FE;
+		 *	    ip_control   : Bits = 0x0000_FF00;
+		 */
+		struct {		 /* type: IP_MEM_* */
+			uint16_t index;
+			uint8_t pc_index;
+			uint8_t unused;
+		} indices;
+	};
+	uint64_t base_address;
+	uint8_t name[64]; /* eg Kernel name corresponding to KERNEL */
+			    /* instance, can embed CU name in future. */
+} __packed;
+
+struct ip_layout {
+	int32_t count;
+	struct ip_data ip_data[1]; /* All the ip_data needs to be sorted */
+				     /* by base_address. */
+} __packed;
+
+/*** Debug IP section layout ****/
+enum DEBUG_IP_TYPE {
+	UNDEFINED = 0,
+	LAPC,
+	ILA,
+	AXI_MM_MONITOR,
+	AXI_TRACE_FUNNEL,
+	AXI_MONITOR_FIFO_LITE,
+	AXI_MONITOR_FIFO_FULL,
+	ACCEL_MONITOR,
+	AXI_STREAM_MONITOR,
+	AXI_STREAM_PROTOCOL_CHECKER,
+	TRACE_S2MM,
+	AXI_DMA,
+	TRACE_S2MM_FULL
+};
+
+struct debug_ip_data {
+	uint8_t type; /* type of enum DEBUG_IP_TYPE */
+	uint8_t index_lowbyte;
+	uint8_t properties;
+	uint8_t major;
+	uint8_t minor;
+	uint8_t index_highbyte;
+	uint8_t reserved[2];
+	uint64_t base_address;
+	char	name[128];
+} __packed;
+
+struct debug_ip_layout {
+	uint16_t count;
+	struct debug_ip_data debug_ip_data[1];
+} __packed;
+
+/* Supported clock frequency types */
+enum XCLBIN_CLOCK_TYPE {
+	CT_UNUSED = 0,			   /* Initialized value */
+	CT_DATA	  = 1,			   /* Data clock */
+	CT_KERNEL = 2,			   /* Kernel clock */
+	CT_SYSTEM = 3			   /* System Clock */
+};
+
+/* Clock Frequency Entry */
+struct clock_freq {
+	uint16_t freq_MHZ;		   /* Frequency in MHz */
+	uint8_t type;			   /* Clock type (enum CLOCK_TYPE) */
+	uint8_t unused[5];		   /* Not used - padding */
+	char name[128];			   /* Clock Name */
+} __packed;
+
+/* Clock frequency section */
+struct clock_freq_topology {
+	int16_t count;		   /* Number of entries */
+	struct clock_freq clock_freq[1]; /* Clock array */
+} __packed;
+
+/* Supported MCS file types */
+enum MCS_TYPE {
+	MCS_UNKNOWN = 0,		   /* Initialized value */
+	MCS_PRIMARY = 1,		   /* The primary mcs file data */
+	MCS_SECONDARY = 2,		   /* The secondary mcs file data */
+};
+
+/* One chunk of MCS data */
+struct mcs_chunk {
+	uint8_t type;			   /* MCS data type */
+	uint8_t unused[7];		   /* padding */
+	uint64_t offset;		   /* data offset from the start of */
+					   /* the section */
+	uint64_t size;		   /* data size */
+} __packed;
+
+/* MCS data section */
+struct mcs {
+	int8_t count;			   /* Number of chunks */
+	int8_t unused[7];		   /* padding */
+	struct mcs_chunk chunk[1];	   /* MCS chunks followed by data */
+} __packed;
+
+/* bmc data section */
+struct bmc {
+	uint64_t offset;		   /* data offset from the start of */
+					   /* the section */
+	uint64_t size;		   /* data size (bytes) */
+	char image_name[64];		   /* Name of the image */
+					   /* (e.g., MSP432P401R) */
+	char device_name[64];		   /* Device ID	(e.g., VCU1525)	 */
+	char version[64];
+	char md5value[33];		   /* MD5 Expected Value */
+				/* (e.g., 56027182079c0bd621761b7dab5a27ca) */
+	char padding[7];		   /* Padding */
+} __packed;
+
+/* soft kernel data section, used by classic driver */
+struct soft_kernel {
+	/** Prefix Syntax:
+	 *  mpo - member, pointer, offset
+	 *  This variable represents a zero terminated string
+	 *  that is offseted from the beginning of the section.
+	 *  The pointer to access the string is initialized as follows:
+	 *  char * pCharString = (address_of_section) + (mpo value)
+	 */
+	uint32_t mpo_name;	   /* Name of the soft kernel */
+	uint32_t image_offset;   /* Image offset */
+	uint32_t image_size;	   /* Image size */
+	uint32_t mpo_version;	   /* Version */
+	uint32_t mpo_md5_value;	   /* MD5 checksum */
+	uint32_t mpo_symbol_name;  /* Symbol name */
+	uint32_t num_instances;  /* Number of instances */
+	uint8_t padding[36];	   /* Reserved for future use */
+	uint8_t reserved_ext[16];   /* Reserved for future extended data */
+} __packed;
+
+enum CHECKSUM_TYPE {
+	CST_UNKNOWN = 0,
+	CST_SDBM = 1,
+	CST_LAST
+};
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif
-- 
2.27.0


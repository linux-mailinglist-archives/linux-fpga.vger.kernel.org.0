Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72DEC2C76B9
	for <lists+linux-fpga@lfdr.de>; Sun, 29 Nov 2020 01:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729180AbgK2ADF (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 28 Nov 2020 19:03:05 -0500
Received: from mail-bn8nam12on2045.outbound.protection.outlook.com ([40.107.237.45]:19104
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725852AbgK2ADF (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sat, 28 Nov 2020 19:03:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DYs4EOD2GJCBuBof4kzPDZhle8w+kf75HqfdAcJgFCsLTgzCR65YP0YGRnT5iiLrqgzuDoqw/F1Kt9Ee0pfeNeCt2QXY65ttteXrsEy7SUxXxxuwE+1HnGdTd5LQ3ZLISqBdGQundi7mAT7MtyPjHDC6zzg1S7CprgzjWvuxJD3OP3vDT2M34yBit5bcaJfqUVih3a0FoIQID/Dv1DuXWGdvSx7DD/n5+N2gqFRZGuVAw0wo2LyWXw0/1aeQQvky/7yYwdv/VXMFjH2NZAcwszVBvrpCKRkZQgK1lGU4Z8aIQpcSdZRXBU5aB2Fu9H8mLSUSvu+eaVDKbYckVRQd4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KZsq1PjEH00jkWwhcEVBABcgiSX/YLkrc0zPfbCBRBQ=;
 b=DrhEf/gS1MgfBPHs0tBTg1CozkpXu/Sfg6whZHx8e/OJvCxbtAu44L+DHNgfJIIAvKb8VHooeyysUv1DIySgoXv1SwVqZvE2U+DENa5Oh8wHbEyLAfICsz/YtsOem9AUKdWCvG9gNjBlpsbLJsQKuFI4PRQDgg9CovbyM5nlHs8lQpjYyCQHXLnllIHZibTC3EcSte6I6sI9qs7fELMaHevEaHi1+0vN/V6BqiNw4LYazNevgkPP+28KL33vLryWV/Kr3+4ckwp+BL+YEflUUr1uP0ObhEKlc37ldd77349/INVS3eSJNOwaUiPspcIgpm1GWkjjU9cqcfuD+Ze65w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KZsq1PjEH00jkWwhcEVBABcgiSX/YLkrc0zPfbCBRBQ=;
 b=UMe5xZhFlaBXb40fY24v6guEMQNuH4F26mmpFzlvVFtJwwMeOflPqdKMgrC+gftca4QnPEFnDwfWB1OyEgmyjlt9a32p4dPVuZtBZrzqkHSvyoswNoHxMNzCzlk+M+6fvPmdIhJQ4B1w8HP3gvvzdrP7Ui6SIViER2C3XFVvNcU=
Received: from MN2PR15CA0052.namprd15.prod.outlook.com (2603:10b6:208:237::21)
 by MN2PR02MB6384.namprd02.prod.outlook.com (2603:10b6:208:1b8::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Sun, 29 Nov
 2020 00:02:04 +0000
Received: from BL2NAM02FT039.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:237:cafe::c6) by MN2PR15CA0052.outlook.office365.com
 (2603:10b6:208:237::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.22 via Frontend
 Transport; Sun, 29 Nov 2020 00:02:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT039.mail.protection.outlook.com (10.152.77.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3611.27 via Frontend Transport; Sun, 29 Nov 2020 00:02:04 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Sat, 28 Nov 2020 16:02:03 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Sat, 28 Nov 2020 16:02:03 -0800
Envelope-to: michal.simek@xilinx.com,
 sonal.santan@xilinx.com,
 lizhih@xilinx.com,
 maxz@xilinx.com,
 stefanos@xilinx.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.72.212] (port=45050 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <sonal.santan@xilinx.com>)
        id 1kjAAE-0000FK-S2; Sat, 28 Nov 2020 16:02:02 -0800
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 6354)
        id F3DD1600113; Sat, 28 Nov 2020 16:00:44 -0800 (PST)
From:   Sonal Santan <sonal.santan@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Sonal Santan <sonal.santan@xilinx.com>,
        <linux-fpga@vger.kernel.org>, <maxz@xilinx.com>,
        <lizhih@xilinx.com>, <michal.simek@xilinx.com>,
        <stefanos@xilinx.com>, <devicetree@vger.kernel.org>
Subject: [PATCH Xilinx Alveo 2/8] fpga: xrt: Add UAPI header files
Date:   Sat, 28 Nov 2020 16:00:34 -0800
Message-ID: <20201129000040.24777-3-sonals@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201129000040.24777-1-sonals@xilinx.com>
References: <20201129000040.24777-1-sonals@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b8f7b394-bcb4-43a7-6711-08d893fa0135
X-MS-TrafficTypeDiagnostic: MN2PR02MB6384:
X-Microsoft-Antispam-PRVS: <MN2PR02MB63843A6265CADF3FB48C57D2BBF60@MN2PR02MB6384.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fcAlV1yprMCAYQHK5ZDyPRLwjMeh9a7C1VhxYAyJZnjf04t99+g2+eLJnyY0kLaPWbH3N546p9p/92FwFR/HUKAabWNjnZpsMMFJozO+G0Z86Z0k7xKtPR/kHbtO16L6QEr+eG3C3oIit3WL/+iuCTiri/nLp5n13z0wNygKr58NT7MQQDVX6N6FYRX5eZdxaup5fKE44+KE7YDEzT4ZtJO2P+Q81HfEzIXIW503XNDnXoJC0m4kr+oDIF31Dxxs/z5UgnXweKsdgcyqJh0D/i73pAGnIQWRR6oigeSSziKKhGQ2hkhvSf7SN8VGCXm4h/bxoR8OcHHFmKGVgbKyG5sBQW+bZC0HuA5lJnh0RxCzz3Vo1OjZVCuQv8kwwJmvEaySGhNMIMZX4VEFiW/RFQ==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(39850400004)(346002)(396003)(376002)(136003)(46966005)(5660300002)(8676002)(83380400001)(82740400003)(30864003)(36756003)(8936002)(356005)(2906002)(7636003)(70206006)(6916009)(70586007)(47076004)(82310400003)(4326008)(336012)(6266002)(6666004)(36906005)(26005)(426003)(2616005)(186003)(54906003)(478600001)(44832011)(316002)(1076003)(450100002)(42186006);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2020 00:02:04.2899
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8f7b394-bcb4-43a7-6711-08d893fa0135
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT039.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6384
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Sonal Santan <sonal.santan@xilinx.com>

Add XRT UAPI header files which describe flash layout, XRT
mailbox protocol, xclBin/axlf FPGA image container format and
XRT management physical function driver ioctl interfaces.

flash_xrt_data.h:
Layout used by XRT to store private data on flash.

mailbox_proto.h:
Mailbox opcodes and high level data structures representing
various kinds of information like sensors, clock, etc.

mailbox_transport.h:
Transport protocol used by mailbox.

xclbin.h:
Container format used to store compiled FPGA image which includes
bitstream and metadata.

xmgmt-ioctl.h:
Ioctls defined by management physical function driver:
* XMGMT_IOCICAPDOWNLOAD_AXLF
  xclbin download which programs the user partition
* XMGMT_IOCFREQSCALE
  Program the clocks driving user partition

Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
---
 include/uapi/linux/xrt/flash_xrt_data.h    |  67 ++++
 include/uapi/linux/xrt/mailbox_proto.h     | 394 +++++++++++++++++++
 include/uapi/linux/xrt/mailbox_transport.h |  74 ++++
 include/uapi/linux/xrt/xclbin.h            | 418 +++++++++++++++++++++
 include/uapi/linux/xrt/xmgmt-ioctl.h       |  72 ++++
 5 files changed, 1025 insertions(+)
 create mode 100644 include/uapi/linux/xrt/flash_xrt_data.h
 create mode 100644 include/uapi/linux/xrt/mailbox_proto.h
 create mode 100644 include/uapi/linux/xrt/mailbox_transport.h
 create mode 100644 include/uapi/linux/xrt/xclbin.h
 create mode 100644 include/uapi/linux/xrt/xmgmt-ioctl.h

diff --git a/include/uapi/linux/xrt/flash_xrt_data.h b/include/uapi/linux/xrt/flash_xrt_data.h
new file mode 100644
index 000000000000..0cafc2f38fbe
--- /dev/null
+++ b/include/uapi/linux/xrt/flash_xrt_data.h
@@ -0,0 +1,67 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020 Xilinx, Inc.
+ *
+ * Authors:
+ *	Cheng Zhen <maxz@xilinx.com>
+ */
+
+#ifndef _FLASH_XRT_DATA_H_
+#define _FLASH_XRT_DATA_H_
+
+#define XRT_DATA_MAGIC	"XRTDATA"
+
+/*
+ * This header file contains data structure for xrt meta data on flash. This
+ * file is included in user space utilities and kernel drivers. The data
+ * structure is used to describe on-flash xrt data which is written by utility
+ * and read by driver. Any change of the data structure should either be
+ * backward compatible or cause version to be bumped up.
+ */
+
+struct flash_data_ident {
+	char fdi_magic[7];
+	char fdi_version;
+};
+
+/*
+ * On-flash meta data describing XRT data on flash. Either fdh_id_begin or
+ * fdh_id_end should be at well-known location on flash so that the reader
+ * can easily pick up fdi_version from flash before it tries to interpret
+ * the whole data structure.
+ * E.g., you align header in the end of the flash so that fdh_id_end is at well
+ * known location or align header at the beginning of the flash so that
+ * fdh_id_begin is at well known location.
+ */
+struct flash_data_header {
+	struct flash_data_ident fdh_id_begin;
+	uint32_t fdh_data_offset;
+	uint32_t fdh_data_len;
+	uint32_t fdh_data_parity;
+	uint8_t fdh_reserved[16];
+	struct flash_data_ident fdh_id_end;
+};
+
+static inline uint32_t flash_xrt_data_get_parity32(unsigned char *buf, size_t n)
+{
+	char *p;
+	size_t i;
+	size_t len;
+	uint32_t parity = 0;
+
+	for (len = 0; len < n; len += 4) {
+		uint32_t tmp = 0;
+		size_t thislen = n - len;
+
+		/* One word at a time. */
+		if (thislen > 4)
+			thislen = 4;
+
+		for (i = 0, p = (char *)&tmp; i < thislen; i++)
+			p[i] = buf[len + i];
+		parity ^= tmp;
+	}
+	return parity;
+}
+
+#endif
diff --git a/include/uapi/linux/xrt/mailbox_proto.h b/include/uapi/linux/xrt/mailbox_proto.h
new file mode 100644
index 000000000000..2aa782d86792
--- /dev/null
+++ b/include/uapi/linux/xrt/mailbox_proto.h
@@ -0,0 +1,394 @@
+/* SPDX-License-Identifier: Apache-2.0 OR GPL-2.0 */
+/*
+ *  Copyright (C) 2019-2020, Xilinx Inc
+ */
+
+#ifndef _XCL_MB_PROTOCOL_H_
+#define _XCL_MB_PROTOCOL_H_
+
+#ifndef __KERNEL__
+#include <stdint.h>
+#else
+#include <linux/types.h>
+#endif
+
+/*
+ * This header file contains mailbox protocol b/w mgmt and user pfs.
+ * - Any changes made here should maintain backward compatibility.
+ * - If it's not possible, new OP code should be added and version number should
+ *   be bumped up.
+ * - Support for old OP code should never be removed.
+ */
+#define XCL_MB_PROTOCOL_VER	0U
+
+/*
+ * UUID_SZ should ALWAYS have the same number
+ * as the MACRO UUID_SIZE defined in linux/uuid.h
+ */
+#define XCL_UUID_SZ		16
+
+/**
+ * enum mailbox_request - List of all mailbox request OPCODE. Some OP code
+ *                        requires arguments, which is defined as corresponding
+ *                        data structures below. Response to the request usually
+ *                        is a int32_t containing the error code. Some responses
+ *                        are more complicated and require a data structure,
+ *                        which is also defined below in this file.
+ * @XCL_MAILBOX_REQ_UNKNOWN: invalid OP code
+ * @XCL_MAILBOX_REQ_TEST_READY: test msg is ready (post only, internal test only)
+ * @XCL_MAILBOX_REQ_TEST_READ: fetch test msg from peer (internal test only)
+ * @XCL_MAILBOX_REQ_LOCK_BITSTREAM: lock down xclbin on mgmt pf (not implemented)
+ * @XCL_MAILBOX_REQ_UNLOCK_BITSTREAM: unlock xclbin on mgmt pf (not implemented)
+ * @XCL_MAILBOX_REQ_HOT_RESET: request mgmt pf driver to reset the board
+ * @XCL_MAILBOX_REQ_FIREWALL: firewall trip detected on mgmt pf (post only)
+ * @XCL_MAILBOX_REQ_LOAD_XCLBIN_KADDR: download xclbin (pointed to by a pointer)
+ * @XCL_MAILBOX_REQ_LOAD_XCLBIN: download xclbin (bitstream is in payload)
+ * @XCL_MAILBOX_REQ_RECLOCK: set clock frequency
+ * @XCL_MAILBOX_REQ_PEER_DATA: read specified data from peer
+ * @XCL_MAILBOX_REQ_USER_PROBE: for user pf to probe the peer mgmt pf
+ * @XCL_MAILBOX_REQ_MGMT_STATE: for mgmt pf to notify user pf of its state change
+ *                          (post only)
+ * @XCL_MAILBOX_REQ_CHG_SHELL: shell change is required on mgmt pf (post only)
+ * @XCL_MAILBOX_REQ_PROGRAM_SHELL: request mgmt pf driver to reprogram shell
+ */
+enum xcl_mailbox_request {
+	XCL_MAILBOX_REQ_UNKNOWN =		0,
+	XCL_MAILBOX_REQ_TEST_READY =		1,
+	XCL_MAILBOX_REQ_TEST_READ =		2,
+	XCL_MAILBOX_REQ_LOCK_BITSTREAM =	3,
+	XCL_MAILBOX_REQ_UNLOCK_BITSTREAM =	4,
+	XCL_MAILBOX_REQ_HOT_RESET =		5,
+	XCL_MAILBOX_REQ_FIREWALL =		6,
+	XCL_MAILBOX_REQ_LOAD_XCLBIN_KADDR =	7,
+	XCL_MAILBOX_REQ_LOAD_XCLBIN =		8,
+	XCL_MAILBOX_REQ_RECLOCK =		9,
+	XCL_MAILBOX_REQ_PEER_DATA =		10,
+	XCL_MAILBOX_REQ_USER_PROBE =		11,
+	XCL_MAILBOX_REQ_MGMT_STATE =		12,
+	XCL_MAILBOX_REQ_CHG_SHELL =		13,
+	XCL_MAILBOX_REQ_PROGRAM_SHELL =		14,
+	XCL_MAILBOX_REQ_READ_P2P_BAR_ADDR =	15,
+	/* Version 0 OP code ends */
+};
+
+static inline const char *mailbox_req2name(enum xcl_mailbox_request req)
+{
+	switch (req) {
+	case XCL_MAILBOX_REQ_TEST_READY: return "XCL_MAILBOX_REQ_TEST_READY";
+	case XCL_MAILBOX_REQ_TEST_READ: return "XCL_MAILBOX_REQ_TEST_READ";
+	case XCL_MAILBOX_REQ_LOCK_BITSTREAM: return "XCL_MAILBOX_REQ_LOCK_BITSTREAM";
+	case XCL_MAILBOX_REQ_UNLOCK_BITSTREAM: return "XCL_MAILBOX_REQ_UNLOCK_BITSTREAM";
+	case XCL_MAILBOX_REQ_HOT_RESET: return "XCL_MAILBOX_REQ_HOT_RESET";
+	case XCL_MAILBOX_REQ_FIREWALL: return "XCL_MAILBOX_REQ_FIREWALL";
+	case XCL_MAILBOX_REQ_LOAD_XCLBIN_KADDR: return "XCL_MAILBOX_REQ_LOAD_XCLBIN_KADDR";
+	case XCL_MAILBOX_REQ_LOAD_XCLBIN: return "XCL_MAILBOX_REQ_LOAD_XCLBIN";
+	case XCL_MAILBOX_REQ_RECLOCK: return "XCL_MAILBOX_REQ_RECLOCK";
+	case XCL_MAILBOX_REQ_PEER_DATA: return "XCL_MAILBOX_REQ_PEER_DATA";
+	case XCL_MAILBOX_REQ_USER_PROBE: return "XCL_MAILBOX_REQ_USER_PROBE";
+	case XCL_MAILBOX_REQ_MGMT_STATE: return "XCL_MAILBOX_REQ_MGMT_STATE";
+	case XCL_MAILBOX_REQ_CHG_SHELL: return "XCL_MAILBOX_REQ_CHG_SHELL";
+	case XCL_MAILBOX_REQ_PROGRAM_SHELL: return "XCL_MAILBOX_REQ_PROGRAM_SHELL";
+	case XCL_MAILBOX_REQ_READ_P2P_BAR_ADDR: return "XCL_MAILBOX_REQ_READ_P2P_BAR_ADDR";
+	default: return "UNKNOWN";
+	}
+}
+
+/**
+ * struct mailbox_req_bitstream_lock - MAILBOX_REQ_LOCK_BITSTREAM and
+ *				       MAILBOX_REQ_UNLOCK_BITSTREAM payload type
+ * @uuid: uuid of the xclbin
+ */
+struct xcl_mailbox_req_bitstream_lock {
+	uint64_t reserved;
+	uint8_t uuid[XCL_UUID_SZ];
+};
+
+/**
+ * enum group_kind - Groups of data that can be fetched from mgmt side
+ * @SENSOR: all kinds of sensor readings
+ * @ICAP: ICAP IP related information
+ * @BDINFO: Board Info, serial_num, mac_address
+ * @MIG_ECC: ECC statistics
+ * @FIREWALL: AF detected time, status
+ */
+enum xcl_group_kind {
+	XCL_SENSOR = 0,
+	XCL_ICAP,
+	XCL_BDINFO,
+	XCL_MIG_ECC,
+	XCL_FIREWALL,
+	XCL_DNA,
+	XCL_SUBDEV,
+};
+
+static inline const char *mailbox_group_kind2name(enum xcl_group_kind kind)
+{
+	switch (kind) {
+	case XCL_SENSOR: return "XCL_SENSOR";
+	case XCL_ICAP: return "XCL_ICAP";
+	case XCL_BDINFO: return "XCL_BDINFO";
+	case XCL_MIG_ECC: return "XCL_MIG_ECC";
+	case XCL_FIREWALL: return "XCL_FIREWALL";
+	case XCL_DNA: return "XCL_DNA";
+	case XCL_SUBDEV: return "XCL_SUBDEV";
+	default: return "UNKNOWN";
+	}
+}
+
+/**
+ * struct xcl_board_info - Data structure used to fetch BDINFO group
+ */
+#define BOARD_INFO_STR_LEN	256
+#define BOARD_INFO_MAC_LEN	6
+#define BOARD_INFO_PAD_LEN	26
+struct xcl_board_info {
+	char	 serial_num[BOARD_INFO_STR_LEN];
+	char	 mac_addr0[BOARD_INFO_MAC_LEN];
+	char	 padding0[BOARD_INFO_PAD_LEN];
+	char	 mac_addr1[BOARD_INFO_MAC_LEN];
+	char	 padding1[BOARD_INFO_PAD_LEN];
+	char	 mac_addr2[BOARD_INFO_MAC_LEN];
+	char	 padding2[BOARD_INFO_PAD_LEN];
+	char	 mac_addr3[BOARD_INFO_MAC_LEN];
+	char	 padding3[BOARD_INFO_PAD_LEN];
+	char	 revision[BOARD_INFO_STR_LEN];
+	char	 bd_name[BOARD_INFO_STR_LEN];
+	char	 bmc_ver[BOARD_INFO_STR_LEN];
+	uint32_t max_power;
+	uint32_t fan_presence;
+	uint32_t config_mode;
+	char     exp_bmc_ver[BOARD_INFO_STR_LEN];
+	uint32_t mac_contiguous_num;
+	char     mac_addr_first[BOARD_INFO_MAC_LEN];
+};
+
+/**
+ * struct xcl_sensor - Data structure used to fetch SENSOR group
+ */
+struct xcl_sensor {
+	uint32_t vol_12v_pex;
+	uint32_t vol_12v_aux;
+	uint32_t cur_12v_pex;
+	uint32_t cur_12v_aux;
+	uint32_t vol_3v3_pex;
+	uint32_t vol_3v3_aux;
+	uint32_t cur_3v3_aux;
+	uint32_t ddr_vpp_btm;
+	uint32_t sys_5v5;
+	uint32_t top_1v2;
+	uint32_t vol_1v8;
+	uint32_t vol_0v85;
+	uint32_t ddr_vpp_top;
+	uint32_t mgt0v9avcc;
+	uint32_t vol_12v_sw;
+	uint32_t mgtavtt;
+	uint32_t vcc1v2_btm;
+	uint32_t fpga_temp;
+	uint32_t fan_temp;
+	uint32_t fan_rpm;
+	uint32_t dimm_temp0;
+	uint32_t dimm_temp1;
+	uint32_t dimm_temp2;
+	uint32_t dimm_temp3;
+	uint32_t vccint_vol;
+	uint32_t vccint_curr;
+	uint32_t se98_temp0;
+	uint32_t se98_temp1;
+	uint32_t se98_temp2;
+	uint32_t cage_temp0;
+	uint32_t cage_temp1;
+	uint32_t cage_temp2;
+	uint32_t cage_temp3;
+	uint32_t hbm_temp0;
+	uint32_t cur_3v3_pex;
+	uint32_t cur_0v85;
+	uint32_t vol_3v3_vcc;
+	uint32_t vol_1v2_hbm;
+	uint32_t vol_2v5_vpp;
+	uint32_t vccint_bram;
+	uint32_t version;
+	uint32_t oem_id;
+	uint32_t vccint_temp;
+	uint32_t vol_12v_aux1;
+	uint32_t vol_vcc1v2_i;
+	uint32_t vol_v12_in_i;
+	uint32_t vol_v12_in_aux0_i;
+	uint32_t vol_v12_in_aux1_i;
+	uint32_t vol_vccaux;
+	uint32_t vol_vccaux_pmc;
+	uint32_t vol_vccram;
+};
+
+/**
+ * struct xcl_hwicap - Data structure used to fetch ICAP group
+ */
+struct xcl_pr_region {
+	uint64_t freq_data;
+	uint64_t freq_kernel;
+	uint64_t freq_system;
+	uint64_t freq_unused;
+	uint64_t freq_cntr_data;
+	uint64_t freq_cntr_kernel;
+	uint64_t freq_cntr_system;
+	uint64_t freq_cntr_unused;
+	uint64_t idcode;
+	uint8_t uuid[XCL_UUID_SZ];
+	uint64_t mig_calib;
+	uint64_t data_retention;
+};
+
+/**
+ * struct xcl_mig_ecc -  Data structure used to fetch MIG_ECC group
+ */
+struct xcl_mig_ecc {
+	uint64_t mem_type;
+	uint64_t mem_idx;
+	uint64_t ecc_enabled;
+	uint64_t ecc_status;
+	uint64_t ecc_ce_cnt;
+	uint64_t ecc_ue_cnt;
+	uint64_t ecc_ce_ffa;
+	uint64_t ecc_ue_ffa;
+};
+
+/**
+ * struct xcl_firewall -  Data structure used to fetch FIREWALL group
+ */
+struct xcl_firewall {
+	uint64_t max_level;
+	uint64_t curr_status;
+	uint64_t curr_level;
+	uint64_t err_detected_status;
+	uint64_t err_detected_level;
+	uint64_t err_detected_time;
+};
+
+
+/**
+ * struct xcl_dna -  Data structure used to fetch DNA group
+ */
+struct xcl_dna {
+	uint64_t status;
+	uint32_t dna[4];
+	uint64_t capability;
+	uint64_t dna_version;
+	uint64_t revision;
+};
+/**
+ * Data structure used to fetch SUBDEV group
+ */
+enum xcl_subdev_return_code {
+	XRT_MSG_SUBDEV_RTN_UNCHANGED = 1,
+	XRT_MSG_SUBDEV_RTN_PARTIAL,
+	XRT_MSG_SUBDEV_RTN_COMPLETE,
+	XRT_MSG_SUBDEV_RTN_PENDINGPLP,
+};
+struct xcl_subdev {
+	uint32_t ver;
+	enum xcl_subdev_return_code rtncode;
+	uint64_t checksum;
+	uint64_t size;
+	uint64_t offset;
+	uint64_t data[1];
+};
+/**
+ * struct mailbox_subdev_peer - MAILBOX_REQ_PEER_DATA payload type
+ * @kind: data group
+ * @size: buffer size for receiving response
+ */
+struct xcl_mailbox_peer_data {
+	enum xcl_group_kind kind;
+	uint32_t padding;
+	uint64_t size;
+	uint64_t entries;
+	uint64_t offset;
+};
+
+/**
+ * struct mailbox_conn - MAILBOX_REQ_USER_PROBE payload type
+ * @kaddr: KVA of the verification data buffer
+ * @paddr: physical addresss of the verification data buffer
+ * @crc32: CRC value of the verification data buffer
+ * @version: protocol version supported by peer
+ */
+struct xcl_mailbox_conn {
+	uint64_t kaddr;
+	uint64_t paddr;
+	uint32_t crc32;
+	uint32_t version;
+};
+
+#define	XCL_COMM_ID_SIZE		2048
+#define XCL_MB_PEER_READY		(1UL << 0)
+#define XCL_MB_PEER_SAME_DOMAIN		(1UL << 1)
+/**
+ * struct mailbox_conn_resp - MAILBOX_REQ_USER_PROBE response payload type
+ * @version: protocol version should be used
+ * @conn_flags: connection status
+ * @chan_switch: bitmap to indicate SW / HW channel for each OP code msg
+ * @comm_id: user defined cookie
+ */
+struct xcl_mailbox_conn_resp {
+	uint32_t version;
+	uint32_t reserved;
+	uint64_t conn_flags;
+	uint64_t chan_switch;
+	char comm_id[XCL_COMM_ID_SIZE];
+};
+
+#define	XCL_MB_STATE_ONLINE	(1UL << 0)
+#define	XCL_MB_STATE_OFFLINE	(1UL << 1)
+/**
+ * struct mailbox_peer_state - MAILBOX_REQ_MGMT_STATE payload type
+ * @state_flags: peer state flags
+ */
+struct xcl_mailbox_peer_state {
+	uint64_t state_flags;
+};
+
+/**
+ * struct mailbox_bitstream_kaddr - MAILBOX_REQ_LOAD_XCLBIN_KADDR payload type
+ * @addr: pointer to xclbin body
+ */
+struct xcl_mailbox_bitstream_kaddr {
+	uint64_t addr;
+};
+
+/**
+ * struct mailbox_clock_freqscaling - MAILBOX_REQ_RECLOCK payload type
+ * @region: region of clock
+ * @target_freqs: array of target clock frequencies (max clocks: 16)
+ */
+struct xcl_mailbox_clock_freqscaling {
+	unsigned int region;
+	unsigned short target_freqs[16];
+};
+
+/**
+ * struct mailbox_req - mailbox request message header
+ * @req: opcode
+ * @flags: flags of this message
+ * @data: payload of variable length
+ */
+struct xcl_mailbox_req {
+	uint64_t flags;
+	enum xcl_mailbox_request req;
+	char data[1]; /* variable length of payload */
+};
+
+/**
+ * struct mailbox_p2p_bar_addr
+ * @bar_addr: p2p bar address
+ * @bar_len: p2p bar length
+ */
+struct xcl_mailbox_p2p_bar_addr {
+	uint64_t  p2p_bar_addr;
+	uint64_t  p2p_bar_len;
+};
+
+static inline const char *mailbox_chan2name(bool sw_ch)
+{
+	return sw_ch ? "SW-CHANNEL" : "HW-CHANNEL";
+}
+
+#endif /* _XCL_MB_PROTOCOL_H_ */
diff --git a/include/uapi/linux/xrt/mailbox_transport.h b/include/uapi/linux/xrt/mailbox_transport.h
new file mode 100644
index 000000000000..4823446797a6
--- /dev/null
+++ b/include/uapi/linux/xrt/mailbox_transport.h
@@ -0,0 +1,74 @@
+/* SPDX-License-Identifier: Apache-2.0 OR GPL-2.0 */
+/*
+ * Copyright (C) 2020 Xilinx, Inc.
+ *
+ * Authors:
+ *	Cheng Zhen <maxz@xilinx.com>
+ */
+
+#ifndef _XCL_MB_TRANSPORT_H_
+#define _XCL_MB_TRANSPORT_H_
+
+/*
+ * This header file contains data structures used in mailbox transport layer
+ * b/w mgmt and user pfs. Any changes made here should maintain backward
+ * compatibility.
+ */
+
+/**
+ * struct sw_chan - mailbox software channel message metadata. This defines the
+ *                  interface between daemons (MPD and MSD) and mailbox's
+ *                  read or write callbacks. A mailbox message (either a request
+ *                  or response) is wrapped by this data structure as payload.
+ *                  A sw_chan is passed between mailbox driver and daemon via
+ *                  read / write driver callbacks. And it is also passed between
+ *                  MPD and MSD via vendor defined interface (TCP socket, etc).
+ * @sz: payload size
+ * @flags: flags of this message as in struct mailbox_req
+ * @id: message ID
+ * @data: payload (struct mailbox_req or response data matching the request)
+ */
+struct xcl_sw_chan {
+	uint64_t sz;
+	uint64_t flags;
+	uint64_t id;
+	char data[1]; /* variable length of payload */
+};
+
+/**
+ * A packet transport by mailbox hardware channel.
+ * When extending, only add new data structure to body. Choose to add new flag
+ * if new feature can be safely ignored by peer, other wise, add new type.
+ */
+enum packet_type {
+	PKT_INVALID = 0,
+	PKT_TEST,
+	PKT_MSG_START,
+	PKT_MSG_BODY
+};
+
+#define	PACKET_SIZE	16 /* Number of DWORD. */
+
+/* Lower 8 bits for type, the rest for flags. Total packet size is 64 bytes */
+#define	PKT_TYPE_MASK		0xff
+#define	PKT_TYPE_MSG_END	(1 << 31)
+struct mailbox_pkt {
+	struct {
+		u32		type;
+		u32		payload_size;
+	} hdr;
+	union {
+		u32		data[PACKET_SIZE - 2];
+		struct {
+			u64	msg_req_id;
+			u32	msg_flags;
+			u32	msg_size;
+			u32	payload[0];
+		} msg_start;
+		struct {
+			u32	payload[0];
+		} msg_body;
+	} body;
+} __packed;
+
+#endif /* _XCL_MB_TRANSPORT_H_ */
diff --git a/include/uapi/linux/xrt/xclbin.h b/include/uapi/linux/xrt/xclbin.h
new file mode 100644
index 000000000000..885cae1700f9
--- /dev/null
+++ b/include/uapi/linux/xrt/xclbin.h
@@ -0,0 +1,418 @@
+/* SPDX-License-Identifier: Apache-2.0 OR GPL-2.0 */
+/*
+ *  Xilinx FPGA compiled binary container format
+ *
+ *  Copyright (C) 2015-2020, Xilinx Inc
+ */
+
+
+#ifndef _XCLBIN_H_
+#define _XCLBIN_H_
+
+#ifdef _WIN32
+  #include <cstdint>
+  #include <algorithm>
+  #include "windows/uuid.h"
+#else
+  #if defined(__KERNEL__)
+    #include <linux/types.h>
+    #include <linux/uuid.h>
+    #include <linux/version.h>
+  #elif defined(__cplusplus)
+    #include <cstdlib>
+    #include <cstdint>
+    #include <algorithm>
+    #include <uuid/uuid.h>
+  #else
+    #include <stdlib.h>
+    #include <stdint.h>
+    #include <uuid/uuid.h>
+  #endif
+#endif
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+    /**
+     * Container format for Xilinx bitstreams, metadata and other
+     * binary blobs.
+     * Every segment must be aligned at 8 byte boundary with null byte padding
+     * between adjacent segments if required.
+     * For segements which are not present both offset and length must be 0 in
+     * the header.
+     * Currently only xclbin0\0 is recognized as file magic. In future if/when file
+     * format is updated the magic string will be changed to xclbin1\0 and so on.
+     */
+    enum XCLBIN_MODE {
+        XCLBIN_FLAT,
+        XCLBIN_PR,
+        XCLBIN_TANDEM_STAGE2,
+        XCLBIN_TANDEM_STAGE2_WITH_PR,
+        XCLBIN_HW_EMU,
+        XCLBIN_SW_EMU,
+        XCLBIN_MODE_MAX
+    };
+
+    /*
+     *  AXLF LAYOUT
+     *  -----------
+     *
+     *  -----------------------------------------
+     *  | Magic                                 |
+     *  -----------------------------------------
+     *  | Header                                |
+     *  -----------------------------------------
+     *  | One or more section headers           |
+     *  -----------------------------------------
+     *  | Matching number of sections with data |
+     *  -----------------------------------------
+     *
+     */
+
+    enum axlf_section_kind {
+        BITSTREAM = 0,
+        CLEARING_BITSTREAM,
+        EMBEDDED_METADATA,
+        FIRMWARE,
+        DEBUG_DATA,
+        SCHED_FIRMWARE,
+        MEM_TOPOLOGY,
+        CONNECTIVITY,
+        IP_LAYOUT,
+        DEBUG_IP_LAYOUT,
+        DESIGN_CHECK_POINT,
+        CLOCK_FREQ_TOPOLOGY,
+        MCS,
+        BMC,
+        BUILD_METADATA,
+        KEYVALUE_METADATA,
+        USER_METADATA,
+        DNA_CERTIFICATE,
+        PDI,
+        BITSTREAM_PARTIAL_PDI,
+        PARTITION_METADATA,
+        EMULATION_DATA,
+        SYSTEM_METADATA,
+        SOFT_KERNEL,
+        ASK_FLASH,
+        AIE_METADATA,
+        ASK_GROUP_TOPOLOGY,
+        ASK_GROUP_CONNECTIVITY
+    };
+
+    enum MEM_TYPE {
+        MEM_DDR3,
+        MEM_DDR4,
+        MEM_DRAM,
+        MEM_STREAMING,
+        MEM_PREALLOCATED_GLOB,
+        MEM_ARE, //Aurora
+        MEM_HBM,
+        MEM_BRAM,
+        MEM_URAM,
+        MEM_STREAMING_CONNECTION
+    };
+
+    enum IP_TYPE {
+        IP_MB = 0,
+        IP_KERNEL, //kernel instance
+        IP_DNASC,
+        IP_DDR4_CONTROLLER,
+        IP_MEM_DDR4,
+        IP_MEM_HBM
+    };
+
+    struct axlf_section_header {
+        uint32_t m_sectionKind;             /* Section type */
+        char m_sectionName[16];             /* Examples: "stage2", "clear1", "clear2", "ocl1", "ocl2, "ublaze", "sched" */
+        uint64_t m_sectionOffset;           /* File offset of section data */
+        uint64_t m_sectionSize;             /* Size of section data */
+    };
+
+    struct axlf_header {
+        uint64_t m_length;                  /* Total size of the xclbin file */
+        uint64_t m_timeStamp;               /* Number of seconds since epoch when xclbin was created */
+        uint64_t m_featureRomTimeStamp;     /* TimeSinceEpoch of the featureRom */
+        uint16_t m_versionPatch;            /* Patch Version */
+        uint8_t m_versionMajor;             /* Major Version - Version: 2.1.0*/
+        uint8_t m_versionMinor;             /* Minor Version */
+        uint32_t m_mode;                    /* XCLBIN_MODE */
+	union {
+	    struct {
+		uint64_t m_platformId;      /* 64 bit platform ID: vendor-device-subvendor-subdev */
+		uint64_t m_featureId;       /* 64 bit feature id */
+	    } rom;
+	    unsigned char rom_uuid[16];     /* feature ROM UUID for which this xclbin was generated */
+	};
+        unsigned char m_platformVBNV[64];   /* e.g. xilinx:xil-accel-rd-ku115:4ddr-xpr:3.4: null terminated */
+	union {
+	    char m_next_axlf[16];           /* Name of next xclbin file in the daisy chain */
+	    uuid_t uuid;                    /* uuid of this xclbin*/
+	};
+        char m_debug_bin[16];               /* Name of binary with debug information */
+        uint32_t m_numSections;             /* Number of section headers */
+    };
+
+    struct axlf {
+        char m_magic[8];                            /* Should be "xclbin2\0"  */
+        int32_t m_signature_length;                 /* Length of the signature. -1 indicates no signature */
+        unsigned char reserved[28];                 /* Note: Initialized to 0xFFs */
+
+        unsigned char m_keyBlock[256];              /* Signature for validation of binary */
+        uint64_t m_uniqueId;                        /* axlf's uniqueId, use it to skip redownload etc */
+        struct axlf_header m_header;                /* Inline header */
+        struct axlf_section_header m_sections[1];   /* One or more section headers follow */
+    };
+
+    typedef struct axlf xclBin;
+
+    /**** BEGIN : Xilinx internal section *****/
+
+    /* bitstream information */
+    struct xlnx_bitstream {
+        uint8_t m_freq[8];
+        char bits[1];
+    };
+
+    /****   MEMORY TOPOLOGY SECTION ****/
+    struct mem_data {
+        uint8_t m_type; //enum corresponding to mem_type.
+        uint8_t m_used; //if 0 this bank is not present
+        union {
+            uint64_t m_size; //if mem_type DDR, then size in KB;
+            uint64_t route_id; //if streaming then "route_id"
+        };
+        union {
+            uint64_t m_base_address;//if DDR then the base address;
+            uint64_t flow_id; //if streaming then "flow id"
+        };
+        unsigned char m_tag[16]; //DDR: BANK0,1,2,3, has to be null terminated; if streaming then stream0, 1 etc
+    };
+
+    struct mem_topology {
+        int32_t m_count; //Number of mem_data
+        struct mem_data m_mem_data[1]; //Should be sorted on mem_type
+    };
+
+    /****   CONNECTIVITY SECTION ****/
+    /* Connectivity of each argument of Kernel. It will be in terms of argument
+     * index associated. For associating kernel instances with arguments and
+     * banks, start at the connectivity section. Using the m_ip_layout_index
+     * access the ip_data.m_name. Now we can associate this kernel instance
+     * with its original kernel name and get the connectivity as well. This
+     * enables us to form related groups of kernel instances.
+     */
+
+    struct connection {
+        int32_t arg_index; //From 0 to n, may not be contiguous as scalars skipped
+        int32_t m_ip_layout_index; //index into the ip_layout section. ip_layout.m_ip_data[index].m_type == IP_KERNEL
+        int32_t mem_data_index; //index of the m_mem_data . Flag error is m_used false.
+    };
+
+    struct connectivity {
+        int32_t m_count;
+        struct connection m_connection[1];
+    };
+
+
+    /****   IP_LAYOUT SECTION ****/
+
+    // IP Kernel
+    #define IP_INT_ENABLE_MASK    0x0001
+    #define IP_INTERRUPT_ID_MASK  0x00FE
+    #define IP_INTERRUPT_ID_SHIFT 0x1
+
+    enum IP_CONTROL {
+        AP_CTRL_HS = 0,
+        AP_CTRL_CHAIN = 1,
+        AP_CTRL_NONE = 2,
+        AP_CTRL_ME = 3,
+        ACCEL_ADAPTER = 4
+    };
+
+    #define IP_CONTROL_MASK  0xFF00
+    #define IP_CONTROL_SHIFT 0x8
+
+    /* IPs on AXI lite - their types, names, and base addresses.*/
+    struct ip_data {
+        uint32_t m_type; //map to IP_TYPE enum
+        union {
+            uint32_t properties; // Default: 32-bits to indicate ip specific property.
+                                 // m_type: IP_KERNEL
+                                 //         m_int_enable   : Bit  - 0x0000_0001;
+                                 //         m_interrupt_id : Bits - 0x0000_00FE;
+                                 //         m_ip_control   : Bits = 0x0000_FF00;
+            struct {             // m_type: IP_MEM_*
+               uint16_t m_index;
+               uint8_t m_pc_index;
+               uint8_t unused;
+            } indices;
+        };
+        uint64_t m_base_address;
+        uint8_t m_name[64]; //eg Kernel name corresponding to KERNEL instance, can embed CU name in future.
+    };
+
+    struct ip_layout {
+        int32_t m_count;
+        struct ip_data m_ip_data[1]; //All the ip_data needs to be sorted by m_base_address.
+    };
+
+    /*** Debug IP section layout ****/
+    enum DEBUG_IP_TYPE {
+        UNDEFINED = 0,
+        LAPC,
+        ILA,
+        AXI_MM_MONITOR,
+        AXI_TRACE_FUNNEL,
+        AXI_MONITOR_FIFO_LITE,
+        AXI_MONITOR_FIFO_FULL,
+        ACCEL_MONITOR,
+        AXI_STREAM_MONITOR,
+        AXI_STREAM_PROTOCOL_CHECKER,
+        TRACE_S2MM,
+        AXI_DMA,
+        TRACE_S2MM_FULL
+    };
+
+    struct debug_ip_data {
+        uint8_t m_type; // type of enum DEBUG_IP_TYPE
+        uint8_t m_index_lowbyte;
+        uint8_t m_properties;
+        uint8_t m_major;
+        uint8_t m_minor;
+        uint8_t m_index_highbyte;
+        uint8_t m_reserved[2];
+        uint64_t m_base_address;
+        char    m_name[128];
+    };
+
+    struct debug_ip_layout {
+        uint16_t m_count;
+        struct debug_ip_data m_debug_ip_data[1];
+    };
+
+    enum CLOCK_TYPE {                      /* Supported clock frequency types */
+        CT_UNUSED = 0,                     /* Initialized value */
+        CT_DATA   = 1,                     /* Data clock */
+        CT_KERNEL = 2,                     /* Kernel clock */
+        CT_SYSTEM = 3                      /* System Clock */
+    };
+
+    struct clock_freq {                    /* Clock Frequency Entry */
+        uint16_t m_freq_Mhz;               /* Frequency in MHz */
+        uint8_t m_type;                    /* Clock type (enum CLOCK_TYPE) */
+        uint8_t m_unused[5];               /* Not used - padding */
+        char m_name[128];                  /* Clock Name */
+    };
+
+    struct clock_freq_topology {           /* Clock frequency section */
+        int16_t m_count;                   /* Number of entries */
+        struct clock_freq m_clock_freq[1]; /* Clock array */
+    };
+
+    enum MCS_TYPE {                        /* Supported MCS file types */
+        MCS_UNKNOWN = 0,                   /* Initialized value */
+        MCS_PRIMARY = 1,                   /* The primary mcs file data */
+        MCS_SECONDARY = 2,                 /* The secondary mcs file data */
+    };
+
+    struct mcs_chunk {                     /* One chunk of MCS data */
+        uint8_t m_type;                    /* MCS data type */
+        uint8_t m_unused[7];               /* padding */
+        uint64_t m_offset;                 /* data offset from the start of the section */
+        uint64_t m_size;                   /* data size */
+    };
+
+    struct mcs {                           /* MCS data section */
+        int8_t m_count;                    /* Number of chunks */
+        int8_t m_unused[7];                /* padding */
+        struct mcs_chunk m_chunk[1];       /* MCS chunks followed by data */
+    };
+
+    struct bmc {                           /* bmc data section  */
+        uint64_t m_offset;                 /* data offset from the start of the section */
+        uint64_t m_size;                   /* data size (bytes)*/
+        char m_image_name[64];             /* Name of the image (e.g., MSP432P401R) */
+        char m_device_name[64];            /* Device ID         (e.g., VCU1525)  */
+        char m_version[64];
+        char m_md5value[33];               /* MD5 Expected Value(e.g., 56027182079c0bd621761b7dab5a27ca)*/
+        char m_padding[7];                 /* Padding */
+    };
+
+    struct soft_kernel {                   /* soft kernel data section  */
+        // Prefix Syntax:
+        //   mpo - member, pointer, offset
+        //     This variable represents a zero terminated string
+        //     that is offseted from the beginning of the section.
+        //
+        //     The pointer to access the string is initialized as follows:
+        //     char * pCharString = (address_of_section) + (mpo value)
+        uint32_t mpo_name;         // Name of the soft kernel
+        uint32_t m_image_offset;   // Image offset
+        uint32_t m_image_size;     // Image size
+        uint32_t mpo_version;      // Version
+        uint32_t mpo_md5_value;    // MD5 checksum
+        uint32_t mpo_symbol_name;  // Symbol name
+        uint32_t m_num_instances;  // Number of instances
+        uint8_t padding[36];       // Reserved for future use
+        uint8_t reservedExt[16];   // Reserved for future extended data
+    };
+
+    enum CHECKSUM_TYPE
+    {
+        CST_UNKNOWN = 0,
+        CST_SDBM = 1,
+        CST_LAST
+    };
+
+    /**** END : Xilinx internal section *****/
+
+# ifdef __cplusplus
+    namespace xclbin {
+      inline const axlf_section_header*
+      get_axlf_section(const axlf* top, axlf_section_kind kind)
+      {
+        auto begin = top->m_sections;
+        auto end = begin + top->m_header.m_numSections;
+        auto itr = std::find_if(begin,end,[kind](const axlf_section_header& sec) { return sec.m_sectionKind==(const uint32_t) kind; });
+        return (itr!=end) ? &(*itr) : nullptr;
+      }
+
+      // Helper C++ section iteration
+      // To keep with with the current "coding" them, the function get_axlf_section_next() was
+      // introduced find 'next' common section names.
+      //
+      // Future TODO: Create a custom iterator and refactor the code base to use it.
+      //
+      // Example on how this function may be used:
+      //
+      // const axlf_section_header * pSection;
+      // const axlf* top = <xclbin image in memory>;
+      // for (pSection = xclbin::get_axlf_section( top, SOFT_KERNEL);
+      //      pSection != nullptr;
+      //      pSection = xclbin::get_axlf_section_next( top, pSection, SOFT_KERNEL)) {
+      //   <code to do work>
+      // }
+      inline const axlf_section_header*
+      get_axlf_section_next(const axlf* top, const axlf_section_header* current_section, axlf_section_kind kind)
+      {
+        if (top == nullptr) { return nullptr; }
+        if (current_section == nullptr) { return nullptr; }
+
+        auto end = top->m_sections + top->m_header.m_numSections;
+
+        auto begin = current_section + 1;        // Point to the next section
+        if (begin == end) { return nullptr; }
+
+        auto itr = std::find_if(begin, end, [kind](const axlf_section_header &sec) {return sec.m_sectionKind == (const uint32_t)kind;});
+        return (itr!=end) ? &(*itr) : nullptr;
+      }
+    }
+# endif
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif
diff --git a/include/uapi/linux/xrt/xmgmt-ioctl.h b/include/uapi/linux/xrt/xmgmt-ioctl.h
new file mode 100644
index 000000000000..f949a7c21560
--- /dev/null
+++ b/include/uapi/linux/xrt/xmgmt-ioctl.h
@@ -0,0 +1,72 @@
+/* SPDX-License-Identifier: Apache-2.0 OR GPL-2.0 */
+/*
+ *  Copyright (C) 2015-2020, Xilinx Inc
+ *
+ */
+
+/**
+ * DOC: PCIe Kernel Driver for Managament Physical Function
+ * Interfaces exposed by *xclmgmt* driver are defined in file, *mgmt-ioctl.h*.
+ * Core functionality provided by *xmgmt* driver is described in the following table:
+ *
+ * ==== ====================================== ============================== ==================================
+ * #    Functionality                          ioctl request code             data format
+ * ==== ====================================== ============================== ==================================
+ * 1    FPGA image download                    XCLMGMT_IOCICAPDOWNLOAD_AXLF   xmgmt_ioc_bitstream_axlf
+ * 2    CL frequency scaling                   XCLMGMT_IOCFREQSCALE           xmgmt_ioc_freqscaling
+ * ==== ====================================== ============================== ==================================
+ *
+ */
+
+#ifndef _XMGMT_IOCALLS_POSIX_H_
+#define _XMGMT_IOCALLS_POSIX_H_
+
+#include <linux/ioctl.h>
+
+#define XMGMT_IOC_MAGIC	'X'
+#define XMGMT_NUM_SUPPORTED_CLOCKS 4
+
+#define XMGMT_IOC_FREQ_SCALE 0x2
+#define XMGMT_IOC_ICAP_DOWNLOAD_AXLF 0x6
+
+
+/**
+ * struct xmgmt_ioc_bitstream_axlf - load xclbin (AXLF) device image
+ * used with XMGMT_IOCICAPDOWNLOAD_AXLF ioctl
+ *
+ * @xclbin:	Pointer to user's xclbin structure in memory
+ */
+struct xmgmt_ioc_bitstream_axlf {
+	struct axlf *xclbin;
+};
+
+/**
+ * struct xmgmt_ioc_freqscaling - scale frequencies on the board using Xilinx clock wizard
+ * used with XMGMT_IOCFREQSCALE ioctl
+ *
+ * @ocl_region:	        PR region (currently only 0 is supported)
+ * @ocl_target_freq:	Array of requested frequencies, a value o zero in the array indicates leave untouched
+ */
+struct xmgmt_ioc_freqscaling {
+	unsigned int ocl_region;
+	unsigned short ocl_target_freq[XMGMT_NUM_SUPPORTED_CLOCKS];
+};
+
+#define DATA_CLK			0
+#define KERNEL_CLK			1
+#define SYSTEM_CLK			2
+
+#define XMGMT_IOCICAPDOWNLOAD_AXLF	_IOW(XMGMT_IOC_MAGIC, XMGMT_IOC_ICAP_DOWNLOAD_AXLF, struct xmgmt_ioc_bitstream_axlf)
+#define XMGMT_IOCFREQSCALE		_IOW(XMGMT_IOC_MAGIC, XMGMT_IOC_FREQ_SCALE, struct xmgmt_ioc_freqscaling)
+
+/*
+ * The following definitions are for binary compatibility with classic XRT management driver
+ */
+
+#define XCLMGMT_IOCICAPDOWNLOAD_AXLF XMGMT_IOCICAPDOWNLOAD_AXLF
+#define XCLMGMT_IOCFREQSCALE XMGMT_IOCFREQSCALE
+
+#define xclmgmt_ioc_bitstream_axlf xmgmt_ioc_bitstream_axlf
+#define xclmgmt_ioc_freqscaling xmgmt_ioc_freqscaling
+
+#endif
-- 
2.17.1


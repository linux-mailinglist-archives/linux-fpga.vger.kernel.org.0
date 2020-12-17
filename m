Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 650742DCD3B
	for <lists+linux-fpga@lfdr.de>; Thu, 17 Dec 2020 08:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbgLQHza (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 17 Dec 2020 02:55:30 -0500
Received: from mail-co1nam11on2042.outbound.protection.outlook.com ([40.107.220.42]:2337
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725988AbgLQHz3 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 17 Dec 2020 02:55:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YzwHxg/n0pi5PYmb423UKoPIvOD3kmaLS3I5Qbv3y6btFz9TR2J48GZRVAfhzj8TawX2TtWuXqAkmzXY4amcL6J6TgvQtSytTp+lVFTdVRSb7DE2clg8fNGRYxDjRK/EcHQZiRrhzxUBk3w1QTdkGQqoLhTL3+rQiSX6kGPzRYHm+2DTeIT4FUTu9DlVYVQOP3hQ4ojtrINZc05P4+/yt+fycOYbbGESblbBlhzca9tZSNC6BUoepSWZtLNZ2LVDsT9b/lNT9n6g08nt+bLm8iskpzicrjbqGPTAwbadbI9vQKRIxvnP+ibnz9vO62EhkAiKVSz0e7RZdeNIBJf5NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M/Jw7Kflxq0TNdD4hz4MRyxilir2LioezReLFM8iIsQ=;
 b=V81y/mPIqSMmRFo5LGB4TJrnZBoFcWJFk9j6jjZwjDDItjOIpPORwujkL3PHbCX3BVRAepJlaq3rQpcodZNMoQ3zfqZG4mU23ZTYUw32fNnNiHCnvqNe3tBwSRJTqic2yYweqPxuvKrdzg4I4dgw7LuiHnGdCKePpYaMVib5bj0cLZIBCvIrWIGzQdFyaTDLyoyV1IMsx0gKcCiapOfpgOKe8MzAdvwguJV/R9L2jdMFlgtrOBKBFwMXAUey+zVk3M1daplQo4Db/1GfV8sGLvb/GHGyqBqpcLu2NKrK6d8z+kCI4I8rdHPYyqFqSa/xvro+6gtPhP3iJK1z+0sOEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M/Jw7Kflxq0TNdD4hz4MRyxilir2LioezReLFM8iIsQ=;
 b=tT+eszQ2xxgrEkavH+OKN6RBKnAARoy3fHS2R5cEZihQsxCjGrMUwhUwPl5Y7mmPR0lGy5+h0d+f5WWKaZquMwbrTl8GPrAnyXui9Mc01ctxHihjBwNHMjsuSinFN9sV4YgkSK5dpOWcduQedD+yUUaAs1F1D+x78YZKSSMkemY=
Received: from BL1PR13CA0105.namprd13.prod.outlook.com (2603:10b6:208:2b9::20)
 by SN6PR02MB5216.namprd02.prod.outlook.com (2603:10b6:805:6f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.21; Thu, 17 Dec
 2020 07:54:29 +0000
Received: from BL2NAM02FT004.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:2b9:cafe::9b) by BL1PR13CA0105.outlook.office365.com
 (2603:10b6:208:2b9::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.16 via Frontend
 Transport; Thu, 17 Dec 2020 07:54:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT004.mail.protection.outlook.com (10.152.76.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3654.12 via Frontend Transport; Thu, 17 Dec 2020 07:54:27 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Wed, 16 Dec 2020 23:53:15 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Wed, 16 Dec 2020 23:53:15 -0800
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
Received: from [172.19.72.212] (port=42044 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <sonal.santan@xilinx.com>)
        id 1kpo67-0007an-2Q; Wed, 16 Dec 2020 23:53:15 -0800
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 6354)
        id C72CB60010B; Wed, 16 Dec 2020 23:51:20 -0800 (PST)
From:   Sonal Santan <sonal.santan@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Sonal Santan <sonal.santan@xilinx.com>,
        <linux-fpga@vger.kernel.org>, <maxz@xilinx.com>,
        <lizhih@xilinx.com>, <michal.simek@xilinx.com>,
        <stefanos@xilinx.com>, <devicetree@vger.kernel.org>,
        <trix@redhat.com>, <mdf@kernel.org>
Subject: [PATCH V2 XRT Alveo 4/6] fpga: xrt: XRT Alveo management physical function driver
Date:   Wed, 16 Dec 2020 23:50:44 -0800
Message-ID: <20201217075046.28553-5-sonals@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201217075046.28553-1-sonals@xilinx.com>
References: <20201217075046.28553-1-sonals@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e65b5cd9-2392-4019-4328-08d8a260fb3b
X-MS-TrafficTypeDiagnostic: SN6PR02MB5216:
X-Microsoft-Antispam-PRVS: <SN6PR02MB52161E3D1937E829E8E864BCBBC40@SN6PR02MB5216.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:225;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V9YT1LiB+GpyPpHfjl19Fz8sNE+Jjs2tXda2kc7BwqlkxuQaDy/GsBV4abXFNGHywfsran7ZxhxLasOrLK4M9Jf49uzpnsGDNsIxYPLNFSuh0J/5FQMCFs300PO2rn2Stjt6C8lqHepmMb2YroP7nMcgr8JCaCq7om8bkD8CNJ9F8X6thN/GgnC62Ce73zW/ciz9wc26GmU1Q3J1i70O4w6DlXTeRAl02gqKiQVZS6SABYxUMB1GgZQ8mvaSSJH3kaanhLnovD0l5cQxdM9nyluEiC+ZeBsIj3QwgNvLgh1soxufQw2ZSXvMO0z0BrkcXVGMKggMXUd75jGyWkdE6cyHW9y6Yr7fE2pPejdD6NmdrrpEMumJE2sk8NV7f/krVb7lAjptztGM7DkfPEjPHg==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(396003)(376002)(39860400002)(136003)(346002)(46966005)(82310400003)(6266002)(336012)(6666004)(2616005)(426003)(356005)(8676002)(47076004)(8936002)(82740400003)(478600001)(6916009)(7636003)(5660300002)(186003)(2906002)(36756003)(316002)(44832011)(42186006)(1076003)(4326008)(54906003)(26005)(83380400001)(30864003)(36906005)(70586007)(70206006)(559001)(579004);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2020 07:54:27.5227
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e65b5cd9-2392-4019-4328-08d8a260fb3b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT004.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5216
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Sonal Santan <sonal.santan@xilinx.com>

Add management physical function driver core. The driver attaches
to management physical function of Alveo devices. It instantiates
the root driver and one or more partition drivers which in turn
instantiate platform drivers. The instantiation of partition and
platform drivers is completely data driven. The driver integrates
with FPGA manager and provides xclbin download service.

Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
---
 drivers/fpga/xrt/include/xmgmt-main.h     |  34 +
 drivers/fpga/xrt/mgmt/xmgmt-fmgr-drv.c    | 179 ++++++
 drivers/fpga/xrt/mgmt/xmgmt-fmgr.h        |  29 +
 drivers/fpga/xrt/mgmt/xmgmt-main-impl.h   |  35 +
 drivers/fpga/xrt/mgmt/xmgmt-main-region.c | 476 ++++++++++++++
 drivers/fpga/xrt/mgmt/xmgmt-main.c        | 738 ++++++++++++++++++++++
 drivers/fpga/xrt/mgmt/xmgmt-root.c        | 375 +++++++++++
 include/uapi/linux/xrt/xmgmt-ioctl.h      |  72 +++
 8 files changed, 1938 insertions(+)
 create mode 100644 drivers/fpga/xrt/include/xmgmt-main.h
 create mode 100644 drivers/fpga/xrt/mgmt/xmgmt-fmgr-drv.c
 create mode 100644 drivers/fpga/xrt/mgmt/xmgmt-fmgr.h
 create mode 100644 drivers/fpga/xrt/mgmt/xmgmt-main-impl.h
 create mode 100644 drivers/fpga/xrt/mgmt/xmgmt-main-region.c
 create mode 100644 drivers/fpga/xrt/mgmt/xmgmt-main.c
 create mode 100644 drivers/fpga/xrt/mgmt/xmgmt-root.c
 create mode 100644 include/uapi/linux/xrt/xmgmt-ioctl.h

diff --git a/drivers/fpga/xrt/include/xmgmt-main.h b/drivers/fpga/xrt/include/xmgmt-main.h
new file mode 100644
index 000000000000..3f26c480ce27
--- /dev/null
+++ b/drivers/fpga/xrt/include/xmgmt-main.h
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
diff --git a/drivers/fpga/xrt/mgmt/xmgmt-fmgr-drv.c b/drivers/fpga/xrt/mgmt/xmgmt-fmgr-drv.c
new file mode 100644
index 000000000000..5e4a4e20b228
--- /dev/null
+++ b/drivers/fpga/xrt/mgmt/xmgmt-fmgr-drv.c
@@ -0,0 +1,179 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx Alveo Management Function Driver
+ *
+ * Copyright (C) 2019-2020 Xilinx, Inc.
+ * Bulk of the code borrowed from XRT mgmt driver file, fmgr.c
+ *
+ * Authors: Sonal.Santan@xilinx.com
+ */
+
+#include <linux/cred.h>
+#include <linux/efi.h>
+#include <linux/fpga/fpga-mgr.h>
+#include <linux/platform_device.h>
+#include <linux/module.h>
+#include <linux/vmalloc.h>
+
+#include "xrt-xclbin.h"
+#include "subdev.h"
+#include "xmgmt-fmgr.h"
+#include "subdev/axigate.h"
+#include "subdev/icap.h"
+#include "xmgmt-main-impl.h"
+
+struct xfpga_klass {
+	const struct platform_device *pdev;
+	char                          name[64];
+};
+
+/*
+ * xclbin download plumbing -- find the download subsystem, ICAP and
+ * pass the xclbin for heavy lifting
+ */
+static int xmgmt_download_bitstream(struct platform_device *pdev,
+	const struct axlf *xclbin)
+
+{
+	struct XHwIcap_Bit_Header bit_header = { 0 };
+	struct platform_device *icap_leaf = NULL;
+	struct xrt_icap_ioctl_wr arg;
+	char *bitstream = NULL;
+	int ret;
+
+	ret = xrt_xclbin_get_section(xclbin, BITSTREAM, (void **)&bitstream,
+		NULL);
+	if (ret || !bitstream) {
+		xrt_err(pdev, "bitstream not found");
+		return -ENOENT;
+	}
+	ret = xrt_xclbin_parse_header(bitstream,
+		DMA_HWICAP_BITFILE_BUFFER_SIZE, &bit_header);
+	if (ret) {
+		ret = -EINVAL;
+		xrt_err(pdev, "invalid bitstream header");
+		goto done;
+	}
+	icap_leaf = xrt_subdev_get_leaf_by_id(pdev, XRT_SUBDEV_ICAP,
+		PLATFORM_DEVID_NONE);
+	if (!icap_leaf) {
+		ret = -ENODEV;
+		xrt_err(pdev, "icap does not exist");
+		goto done;
+	}
+	arg.xiiw_bit_data = bitstream + bit_header.HeaderLength;
+	arg.xiiw_data_len = bit_header.BitstreamLength;
+	ret = xrt_subdev_ioctl(icap_leaf, XRT_ICAP_WRITE, &arg);
+	if (ret)
+		xrt_err(pdev, "write bitstream failed, ret = %d", ret);
+
+done:
+	if (icap_leaf)
+		xrt_subdev_put_leaf(pdev, icap_leaf);
+	vfree(bitstream);
+
+	return ret;
+}
+
+/*
+ * There is no HW prep work we do here since we need the full
+ * xclbin for its sanity check.
+ */
+static int xmgmt_pr_write_init(struct fpga_manager *mgr,
+	struct fpga_image_info *info, const char *buf, size_t count)
+{
+	const struct axlf *bin = (const struct axlf *)buf;
+	struct xfpga_klass *obj = mgr->priv;
+
+	if (!(info->flags & FPGA_MGR_PARTIAL_RECONFIG)) {
+		xrt_info(obj->pdev, "%s only supports partial reconfiguration\n", obj->name);
+		return -EINVAL;
+	}
+
+	if (count < sizeof(struct axlf))
+		return -EINVAL;
+
+	if (count > bin->m_header.m_length)
+		return -EINVAL;
+
+	xrt_info(obj->pdev, "Prepare download of xclbin %pUb of length %lld B",
+		&bin->m_header.uuid, bin->m_header.m_length);
+
+	return 0;
+}
+
+/*
+ * The implementation requries full xclbin image before we can start
+ * programming the hardware via ICAP subsystem. Full image is required
+ * for checking the validity of xclbin and walking the sections to
+ * discover the bitstream.
+ */
+static int xmgmt_pr_write(struct fpga_manager *mgr,
+	const char *buf, size_t count)
+{
+	const struct axlf *bin = (const struct axlf *)buf;
+	struct xfpga_klass *obj = mgr->priv;
+
+	if (bin->m_header.m_length != count)
+		return -EINVAL;
+
+	return xmgmt_download_bitstream((void *)obj->pdev, bin);
+}
+
+static int xmgmt_pr_write_complete(struct fpga_manager *mgr,
+	struct fpga_image_info *info)
+{
+	const struct axlf *bin = (const struct axlf *)info->buf;
+	struct xfpga_klass *obj = mgr->priv;
+
+	xrt_info(obj->pdev, "Finished download of xclbin %pUb",
+		 &bin->m_header.uuid);
+	return 0;
+}
+
+static enum fpga_mgr_states xmgmt_pr_state(struct fpga_manager *mgr)
+{
+	return FPGA_MGR_STATE_UNKNOWN;
+}
+
+static const struct fpga_manager_ops xmgmt_pr_ops = {
+	.initial_header_size = sizeof(struct axlf),
+	.write_init = xmgmt_pr_write_init,
+	.write = xmgmt_pr_write,
+	.write_complete = xmgmt_pr_write_complete,
+	.state = xmgmt_pr_state,
+};
+
+
+struct fpga_manager *xmgmt_fmgr_probe(struct platform_device *pdev)
+{
+	struct xfpga_klass *obj = devm_kzalloc(DEV(pdev), sizeof(struct xfpga_klass),
+					       GFP_KERNEL);
+	struct fpga_manager *fmgr = NULL;
+	int ret = 0;
+
+	if (!obj)
+		return ERR_PTR(-ENOMEM);
+
+	snprintf(obj->name, sizeof(obj->name), "Xilinx Alveo FPGA Manager");
+	obj->pdev = pdev;
+	fmgr = fpga_mgr_create(&pdev->dev,
+			       obj->name,
+			       &xmgmt_pr_ops,
+			       obj);
+	if (!fmgr)
+		return ERR_PTR(-ENOMEM);
+
+	ret = fpga_mgr_register(fmgr);
+	if (ret) {
+		fpga_mgr_free(fmgr);
+		return ERR_PTR(ret);
+	}
+	return fmgr;
+}
+
+int xmgmt_fmgr_remove(struct fpga_manager *fmgr)
+{
+	fpga_mgr_unregister(fmgr);
+	return 0;
+}
diff --git a/drivers/fpga/xrt/mgmt/xmgmt-fmgr.h b/drivers/fpga/xrt/mgmt/xmgmt-fmgr.h
new file mode 100644
index 000000000000..2beba649609f
--- /dev/null
+++ b/drivers/fpga/xrt/mgmt/xmgmt-fmgr.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Xilinx Alveo Management Function Driver
+ *
+ * Copyright (C) 2019-2020 Xilinx, Inc.
+ * Bulk of the code borrowed from XRT mgmt driver file, fmgr.c
+ *
+ * Authors: Sonal.Santan@xilinx.com
+ */
+
+#ifndef	_XMGMT_FMGR_H_
+#define	_XMGMT_FMGR_H_
+
+#include <linux/fpga/fpga-mgr.h>
+#include <linux/mutex.h>
+
+#include <linux/xrt/xclbin.h>
+
+enum xfpga_sec_level {
+	XFPGA_SEC_NONE = 0,
+	XFPGA_SEC_DEDICATE,
+	XFPGA_SEC_SYSTEM,
+	XFPGA_SEC_MAX = XFPGA_SEC_SYSTEM,
+};
+
+struct fpga_manager *xmgmt_fmgr_probe(struct platform_device *pdev);
+int xmgmt_fmgr_remove(struct fpga_manager *fmgr);
+
+#endif
diff --git a/drivers/fpga/xrt/mgmt/xmgmt-main-impl.h b/drivers/fpga/xrt/mgmt/xmgmt-main-impl.h
new file mode 100644
index 000000000000..73a03d6b0601
--- /dev/null
+++ b/drivers/fpga/xrt/mgmt/xmgmt-main-impl.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020 Xilinx, Inc.
+ *
+ * Authors:
+ *	Lizhi Hou <Lizhi.Hou@xilinx.com>
+ *	Cheng Zhen <maxz@xilinx.com>
+ */
+
+#ifndef	_XMGMT_MAIN_IMPL_H_
+#define	_XMGMT_MAIN_IMPL_H_
+
+#include "subdev.h"
+#include "xmgmt-main.h"
+
+struct fpga_manager;
+extern struct platform_driver xmgmt_main_driver;
+extern struct xrt_subdev_endpoints xrt_mgmt_main_endpoints[];
+
+extern int xmgmt_process_xclbin(struct platform_device *pdev,
+	struct fpga_manager *fmgr, const struct axlf *xclbin, enum provider_kind kind);
+extern void xmgmt_region_cleanup_all(struct platform_device *pdev);
+
+extern int bitstream_axlf_mailbox(struct platform_device *pdev,
+	const void *xclbin);
+extern int xmgmt_hot_reset(struct platform_device *pdev);
+
+/* Getting dtb for specified partition. Caller should vfree returned dtb .*/
+extern char *xmgmt_get_dtb(struct platform_device *pdev,
+	enum provider_kind kind);
+extern char *xmgmt_get_vbnv(struct platform_device *pdev);
+extern int xmgmt_get_provider_uuid(struct platform_device *pdev,
+	enum provider_kind kind, uuid_t *uuid);
+
+#endif	/* _XMGMT_MAIN_IMPL_H_ */
diff --git a/drivers/fpga/xrt/mgmt/xmgmt-main-region.c b/drivers/fpga/xrt/mgmt/xmgmt-main-region.c
new file mode 100644
index 000000000000..1612c8273b50
--- /dev/null
+++ b/drivers/fpga/xrt/mgmt/xmgmt-main-region.c
@@ -0,0 +1,476 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx Alveo Management Function Driver
+ *
+ * Copyright (C) 2019-2020 Xilinx, Inc.
+ * Bulk of the code borrowed from XRT mgmt driver file, fmgr.c
+ *
+ * Authors: Lizhi.Hou@xilinx.com
+ */
+
+#include <linux/uuid.h>
+#include <linux/fpga/fpga-bridge.h>
+#include <linux/fpga/fpga-region.h>
+#include "metadata.h"
+#include "subdev.h"
+#include "subdev/axigate.h"
+#include "xrt-xclbin.h"
+#include "xmgmt-main-impl.h"
+
+struct xmgmt_bridge {
+	struct platform_device *pdev;
+	const char *axigate_name;
+};
+
+struct xmgmt_region {
+	struct platform_device *pdev;
+	struct fpga_region *fregion;
+	uuid_t intf_uuid;
+	struct fpga_bridge *fbridge;
+	int part_inst;
+	uuid_t dep_uuid;
+	struct list_head list;
+};
+
+struct xmgmt_region_match_arg {
+	struct platform_device *pdev;
+	uuid_t *uuids;
+	u32 uuid_num;
+};
+
+static int xmgmt_br_enable_set(struct fpga_bridge *bridge, bool enable)
+{
+	struct xmgmt_bridge *br_data = (struct xmgmt_bridge *)bridge->priv;
+	struct platform_device *axigate_leaf;
+	int rc;
+
+	axigate_leaf = xrt_subdev_get_leaf_by_epname(br_data->pdev,
+		br_data->axigate_name);
+	if (!axigate_leaf) {
+		xrt_err(br_data->pdev, "failed to get leaf %s",
+			br_data->axigate_name);
+		return -ENOENT;
+	}
+
+	if (enable)
+		rc = xrt_subdev_ioctl(axigate_leaf, XRT_AXIGATE_FREE, NULL);
+	else
+		rc = xrt_subdev_ioctl(axigate_leaf, XRT_AXIGATE_FREEZE, NULL);
+
+	if (rc) {
+		xrt_err(br_data->pdev, "failed to %s gate %s, rc %d",
+			(enable ? "free" : "freeze"), br_data->axigate_name,
+			rc);
+	}
+
+	xrt_subdev_put_leaf(br_data->pdev, axigate_leaf);
+
+	return rc;
+}
+
+const struct fpga_bridge_ops xmgmt_bridge_ops = {
+	.enable_set = xmgmt_br_enable_set
+};
+
+static void xmgmt_destroy_bridge(struct fpga_bridge *br)
+{
+	struct xmgmt_bridge *br_data = br->priv;
+
+	if (!br_data)
+		return;
+
+	xrt_info(br_data->pdev, "destroy fpga bridge %s",
+		br_data->axigate_name);
+	fpga_bridge_unregister(br);
+
+	devm_kfree(DEV(br_data->pdev), br_data);
+
+	fpga_bridge_free(br);
+}
+
+static struct fpga_bridge *xmgmt_create_bridge(struct platform_device *pdev,
+	char *dtb)
+{
+	struct xmgmt_bridge *br_data;
+	struct fpga_bridge *br = NULL;
+	const char *gate;
+	int rc;
+
+	br_data = devm_kzalloc(DEV(pdev), sizeof(*br_data), GFP_KERNEL);
+	if (!br_data)
+		return NULL;
+	br_data->pdev = pdev;
+
+	br_data->axigate_name = NODE_GATE_ULP;
+	rc = xrt_md_get_epname_pointer(&pdev->dev, dtb, NODE_GATE_ULP,
+		NULL, &gate);
+	if (rc) {
+		br_data->axigate_name = NODE_GATE_PLP;
+		rc = xrt_md_get_epname_pointer(&pdev->dev, dtb, NODE_GATE_PLP,
+			NULL, &gate);
+	}
+	if (rc) {
+		xrt_err(pdev, "failed to get axigate, rc %d", rc);
+		goto failed;
+	}
+
+	br = fpga_bridge_create(DEV(pdev), br_data->axigate_name,
+		&xmgmt_bridge_ops, br_data);
+	if (!br) {
+		xrt_err(pdev, "failed to create bridge");
+		goto failed;
+	}
+
+	rc = fpga_bridge_register(br);
+	if (rc) {
+		xrt_err(pdev, "failed to register bridge, rc %d", rc);
+		goto failed;
+	}
+
+	xrt_info(pdev, "created fpga bridge %s", br_data->axigate_name);
+
+	return br;
+
+failed:
+	if (br)
+		fpga_bridge_free(br);
+	if (br_data)
+		devm_kfree(DEV(pdev), br_data);
+
+	return NULL;
+}
+
+static void xmgmt_destroy_region(struct fpga_region *re)
+{
+	struct xmgmt_region *r_data = re->priv;
+
+	xrt_info(r_data->pdev, "destroy fpga region %llx%llx",
+		re->compat_id->id_l, re->compat_id->id_h);
+
+	fpga_region_unregister(re);
+
+	if (r_data->part_inst > 0)
+		xrt_subdev_destroy_partition(r_data->pdev, r_data->part_inst);
+
+	if (r_data->fbridge)
+		xmgmt_destroy_bridge(r_data->fbridge);
+
+	if (r_data->fregion->info) {
+		fpga_image_info_free(r_data->fregion->info);
+		r_data->fregion->info = NULL;
+	}
+
+	fpga_region_free(re);
+
+	devm_kfree(DEV(r_data->pdev), r_data);
+}
+
+static int xmgmt_region_match(struct device *dev, const void *data)
+{
+	const struct xmgmt_region_match_arg *arg = data;
+	const struct fpga_region *match_re;
+	int i;
+
+	if (dev->parent != &arg->pdev->dev)
+		return false;
+
+	match_re = to_fpga_region(dev);
+	/*
+	 * The device tree provides both parent and child uuids for an
+	 * xclbin in one array. Here we try both uuids to see if it matches
+	 * with target region's compat_id. Strictly speaking we should
+	 * only match xclbin's parent uuid with target region's compat_id
+	 * but given the uuids by design are unique comparing with both
+	 * does not hurt.
+	 */
+	for (i = 0; i < arg->uuid_num; i++) {
+		if (!memcmp(match_re->compat_id, &arg->uuids[i],
+		    sizeof(*match_re->compat_id)))
+			return true;
+	}
+
+	return false;
+}
+
+static int xmgmt_region_match_base(struct device *dev, const void *data)
+{
+	const struct xmgmt_region_match_arg *arg = data;
+	const struct fpga_region *match_re;
+	const struct xmgmt_region *r_data;
+
+	if (dev->parent != &arg->pdev->dev)
+		return false;
+
+	match_re = to_fpga_region(dev);
+	r_data = match_re->priv;
+	if (uuid_is_null(&r_data->dep_uuid))
+		return true;
+
+	return false;
+}
+
+static int xmgmt_region_match_by_depuuid(struct device *dev, const void *data)
+{
+	const struct xmgmt_region_match_arg *arg = data;
+	const struct fpga_region *match_re;
+	const struct xmgmt_region *r_data;
+
+	if (dev->parent != &arg->pdev->dev)
+		return false;
+
+	match_re = to_fpga_region(dev);
+	r_data = match_re->priv;
+	if (!memcmp(&r_data->dep_uuid, arg->uuids,
+	    sizeof(uuid_t)))
+		return true;
+
+	return false;
+}
+
+static void xmgmt_region_cleanup(struct fpga_region *re)
+{
+	struct xmgmt_region *r_data = re->priv, *temp;
+	struct platform_device *pdev = r_data->pdev;
+	struct fpga_region *match_re = NULL;
+	struct device *start_dev = NULL;
+	struct xmgmt_region_match_arg arg;
+	LIST_HEAD(free_list);
+
+	list_add_tail(&r_data->list, &free_list);
+	arg.pdev = pdev;
+	arg.uuid_num = 1;
+
+	while (r_data != NULL) {
+		arg.uuids = (uuid_t *)r_data->fregion->compat_id;
+		match_re = fpga_region_class_find(start_dev, &arg,
+			xmgmt_region_match_by_depuuid);
+		if (match_re) {
+			r_data = match_re->priv;
+			list_add_tail(&r_data->list, &free_list);
+			start_dev = &match_re->dev;
+			put_device(&match_re->dev);
+			continue;
+		}
+
+		r_data = list_is_last(&r_data->list, &free_list) ? NULL :
+			list_next_entry(r_data, list);
+		start_dev = NULL;
+	}
+
+	list_for_each_entry_safe_reverse(r_data, temp, &free_list, list) {
+		if (list_is_first(&r_data->list, &free_list)) {
+			if (r_data->part_inst > 0) {
+				xrt_subdev_destroy_partition(pdev,
+					r_data->part_inst);
+				r_data->part_inst = -1;
+			}
+			if (r_data->fregion->info) {
+				fpga_image_info_free(r_data->fregion->info);
+				r_data->fregion->info = NULL;
+			}
+			continue;
+		}
+		xmgmt_destroy_region(r_data->fregion);
+	}
+}
+
+void xmgmt_region_cleanup_all(struct platform_device *pdev)
+{
+	struct fpga_region *base_re;
+	struct xmgmt_region_match_arg arg;
+
+	arg.pdev = pdev;
+
+	for (base_re = fpga_region_class_find(NULL, &arg,
+	    xmgmt_region_match_base);
+	    base_re;
+	    base_re = fpga_region_class_find(NULL, &arg,
+	    xmgmt_region_match_base)) {
+		put_device(&base_re->dev);
+
+		xmgmt_region_cleanup(base_re);
+		xmgmt_destroy_region(base_re);
+	}
+}
+
+/*
+ * Program a given region with given xclbin image. Bring up the subdevs and the
+ * partition object to contain the subdevs.
+ */
+static int xmgmt_region_program(struct fpga_region *re, const void *xclbin, char *dtb)
+{
+	struct xmgmt_region *r_data = re->priv;
+	struct platform_device *pdev = r_data->pdev;
+	struct fpga_image_info *info;
+	const struct axlf *xclbin_obj = xclbin;
+	int rc;
+
+	info = fpga_image_info_alloc(&pdev->dev);
+	if (!info)
+		return -ENOMEM;
+
+	info->buf = xclbin;
+	info->count = xclbin_obj->m_header.m_length;
+	info->flags |= FPGA_MGR_PARTIAL_RECONFIG;
+	re->info = info;
+	rc = fpga_region_program_fpga(re);
+	if (rc) {
+		xrt_err(pdev, "programming xclbin failed, rc %d", rc);
+		return rc;
+	}
+
+	/* free bridges to allow reprogram */
+	if (re->get_bridges)
+		fpga_bridges_put(&re->bridge_list);
+
+	/*
+	 * Next bringup the subdevs for this region which will be managed by
+	 * its own partition object.
+	 */
+	r_data->part_inst = xrt_subdev_create_partition(pdev, dtb);
+	if (r_data->part_inst < 0) {
+		xrt_err(pdev, "failed to create partition, rc %d",
+			r_data->part_inst);
+		rc = r_data->part_inst;
+		return rc;
+	}
+
+	rc = xrt_subdev_wait_for_partition_bringup(pdev);
+	if (rc)
+		xrt_err(pdev, "partition bringup failed, rc %d", rc);
+	return rc;
+}
+
+static int xmgmt_get_bridges(struct fpga_region *re)
+{
+	struct xmgmt_region *r_data = re->priv;
+	struct device *dev = &r_data->pdev->dev;
+
+	return fpga_bridge_get_to_list(dev, re->info, &re->bridge_list);
+}
+
+/*
+ * Program/create FPGA regions based on input xclbin file. This is key function
+ * stitching the flow together:
+ * 1. Identify a matching existing region for this xclbin
+ * 2. Tear down any previous objects for the found region
+ * 3. Program this region with input xclbin
+ * 4. Iterate over this region's interface uuids to determine if it defines any
+ *    child region. Create fpga_region for the child region.
+ */
+int xmgmt_process_xclbin(struct platform_device *pdev,
+	struct fpga_manager *fmgr, const struct axlf *xclbin, enum provider_kind kind)
+{
+	struct fpga_region *re, *compat_re = NULL;
+	struct xmgmt_region_match_arg arg;
+	struct xmgmt_region *r_data;
+	char *dtb = NULL;
+	int rc, i;
+
+	rc = xrt_xclbin_get_metadata(DEV(pdev), xclbin, &dtb);
+	if (rc) {
+		xrt_err(pdev, "failed to get dtb: %d", rc);
+		goto failed;
+	}
+
+	xrt_md_get_intf_uuids(DEV(pdev), dtb, &arg.uuid_num, NULL);
+	if (arg.uuid_num == 0) {
+		xrt_err(pdev, "failed to get intf uuid");
+		rc = -EINVAL;
+		goto failed;
+	}
+	arg.uuids = vzalloc(sizeof(uuid_t) * arg.uuid_num);
+	if (!arg.uuids) {
+		rc = -ENOMEM;
+		goto failed;
+	}
+	arg.pdev = pdev;
+
+	xrt_md_get_intf_uuids(DEV(pdev), dtb, &arg.uuid_num, arg.uuids);
+
+	/* if this is not base firmware, search for a compatible region */
+	if (kind != XMGMT_BLP) {
+		compat_re = fpga_region_class_find(NULL, &arg,
+			xmgmt_region_match);
+		if (!compat_re) {
+			xrt_err(pdev, "failed to get compatible region");
+			rc = -ENOENT;
+			goto failed;
+		}
+
+		xmgmt_region_cleanup(compat_re);
+
+		rc = xmgmt_region_program(compat_re, xclbin, dtb);
+		if (rc) {
+			xrt_err(pdev, "failed to program region");
+			goto failed;
+		}
+
+	}
+
+	/* create all the new regions contained in this xclbin */
+	for (i = 0; i < arg.uuid_num; i++) {
+		if (compat_re && !memcmp(compat_re->compat_id, &arg.uuids[i],
+					 sizeof(*compat_re->compat_id)))
+			/* region for this interface already exists */
+			continue;
+		re = fpga_region_create(DEV(pdev), fmgr, xmgmt_get_bridges);
+		if (!re) {
+			xrt_err(pdev, "failed to create fpga region");
+			rc = -EFAULT;
+			goto failed;
+		}
+		r_data = devm_kzalloc(DEV(pdev), sizeof(*r_data), GFP_KERNEL);
+		if (!r_data) {
+			rc = -ENOMEM;
+			fpga_region_free(re);
+			goto failed;
+		}
+		r_data->pdev = pdev;
+		r_data->fregion = re;
+		r_data->part_inst = -1;
+		memcpy(&r_data->intf_uuid, &arg.uuids[i],
+			sizeof(r_data->intf_uuid));
+		if (compat_re) {
+			memcpy(&r_data->dep_uuid, compat_re->compat_id,
+				sizeof(r_data->intf_uuid));
+		}
+		r_data->fbridge = xmgmt_create_bridge(pdev, dtb);
+		if (!r_data->fbridge) {
+			xrt_err(pdev, "failed to create fpga bridge");
+			rc = -EFAULT;
+			devm_kfree(DEV(pdev), r_data);
+			fpga_region_free(re);
+			goto failed;
+		}
+
+		re->compat_id = (struct fpga_compat_id *)&r_data->intf_uuid;
+		re->priv = r_data;
+
+		rc = fpga_region_register(re);
+		if (rc) {
+			xrt_err(pdev, "failed to register fpga region");
+			xmgmt_destroy_bridge(r_data->fbridge);
+			fpga_region_free(re);
+			devm_kfree(DEV(pdev), r_data);
+			goto failed;
+		}
+
+		xrt_info(pdev, "created fpga region %llx%llx",
+			re->compat_id->id_l, re->compat_id->id_h);
+	}
+
+failed:
+	if (compat_re)
+		put_device(&compat_re->dev);
+
+	if (rc) {
+		if (compat_re)
+			xmgmt_region_cleanup(compat_re);
+	}
+
+	if (dtb)
+		vfree(dtb);
+
+	return rc;
+}
diff --git a/drivers/fpga/xrt/mgmt/xmgmt-main.c b/drivers/fpga/xrt/mgmt/xmgmt-main.c
new file mode 100644
index 000000000000..6afeb2d23320
--- /dev/null
+++ b/drivers/fpga/xrt/mgmt/xmgmt-main.c
@@ -0,0 +1,738 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx Alveo FPGA MGMT PF entry point driver
+ *
+ * Copyright (C) 2020 Xilinx, Inc.
+ *
+ * Authors:
+ *	Sonal Santan <sonals@xilinx.com>
+ */
+
+#include <linux/firmware.h>
+#include <linux/uaccess.h>
+#include "xrt-xclbin.h"
+#include "metadata.h"
+#include "subdev.h"
+#include <linux/xrt/xmgmt-ioctl.h>
+#include "subdev/gpio.h"
+#include "xmgmt-main.h"
+#include "xmgmt-fmgr.h"
+#include "subdev/icap.h"
+#include "subdev/axigate.h"
+#include "xmgmt-main-impl.h"
+
+#define	XMGMT_MAIN "xmgmt_main"
+
+struct xmgmt_main {
+	struct platform_device *pdev;
+	void *evt_hdl;
+	struct axlf *firmware_blp;
+	struct axlf *firmware_plp;
+	struct axlf *firmware_ulp;
+	bool flash_ready;
+	bool gpio_ready;
+	struct fpga_manager *fmgr;
+	struct mutex busy_mutex;
+
+	uuid_t *blp_intf_uuids;
+	u32 blp_intf_uuid_num;
+};
+
+char *xmgmt_get_vbnv(struct platform_device *pdev)
+{
+	struct xmgmt_main *xmm = platform_get_drvdata(pdev);
+	const char *vbnv;
+	char *ret;
+	int i;
+
+	if (xmm->firmware_plp)
+		vbnv = xmm->firmware_plp->m_header.m_platformVBNV;
+	else if (xmm->firmware_blp)
+		vbnv = xmm->firmware_blp->m_header.m_platformVBNV;
+	else
+		return NULL;
+
+	ret = kstrdup(vbnv, GFP_KERNEL);
+	for (i = 0; i < strlen(ret); i++) {
+		if (ret[i] == ':' || ret[i] == '.')
+			ret[i] = '_';
+	}
+	return ret;
+}
+
+static bool xmgmt_main_leaf_match(enum xrt_subdev_id id,
+	struct platform_device *pdev, void *arg)
+{
+	if (id == XRT_SUBDEV_GPIO)
+		return xrt_subdev_has_epname(pdev, arg);
+	else if (id == XRT_SUBDEV_QSPI)
+		return true;
+
+	return false;
+}
+
+static int get_dev_uuid(struct platform_device *pdev, char *uuidstr, size_t len)
+{
+	char uuid[16];
+	struct platform_device *gpio_leaf;
+	struct xrt_gpio_ioctl_rw gpio_arg = { 0 };
+	int err, i, count;
+
+	gpio_leaf = xrt_subdev_get_leaf_by_epname(pdev, NODE_BLP_ROM);
+	if (!gpio_leaf) {
+		xrt_err(pdev, "can not get %s", NODE_BLP_ROM);
+		return -EINVAL;
+	}
+
+	gpio_arg.xgir_id = XRT_GPIO_ROM_UUID;
+	gpio_arg.xgir_buf = uuid;
+	gpio_arg.xgir_len = sizeof(uuid);
+	gpio_arg.xgir_offset = 0;
+	err = xrt_subdev_ioctl(gpio_leaf, XRT_GPIO_READ, &gpio_arg);
+	xrt_subdev_put_leaf(pdev, gpio_leaf);
+	if (err) {
+		xrt_err(pdev, "can not get uuid: %d", err);
+		return err;
+	}
+
+	for (count = 0, i = sizeof(uuid) - sizeof(u32);
+		i >= 0 && len > count; i -= sizeof(u32)) {
+		count += snprintf(uuidstr + count, len - count,
+			"%08x", *(u32 *)&uuid[i]);
+	}
+	return 0;
+}
+
+int xmgmt_hot_reset(struct platform_device *pdev)
+{
+	int ret = xrt_subdev_broadcast_event(pdev, XRT_EVENT_PRE_HOT_RESET);
+
+	if (ret) {
+		xrt_err(pdev, "offline failed, hot reset is canceled");
+		return ret;
+	}
+
+	(void) xrt_subdev_hot_reset(pdev);
+	xrt_subdev_broadcast_event(pdev, XRT_EVENT_POST_HOT_RESET);
+	return 0;
+}
+
+static ssize_t reset_store(struct device *dev,
+	struct device_attribute *da, const char *buf, size_t count)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+
+	(void) xmgmt_hot_reset(pdev);
+	return count;
+}
+static DEVICE_ATTR_WO(reset);
+
+static ssize_t VBNV_show(struct device *dev,
+	struct device_attribute *da, char *buf)
+{
+	ssize_t ret;
+	char *vbnv;
+	struct platform_device *pdev = to_platform_device(dev);
+
+	vbnv = xmgmt_get_vbnv(pdev);
+	ret = sprintf(buf, "%s\n", vbnv);
+	kfree(vbnv);
+	return ret;
+}
+static DEVICE_ATTR_RO(VBNV);
+
+static ssize_t logic_uuids_show(struct device *dev,
+	struct device_attribute *da, char *buf)
+{
+	ssize_t ret;
+	char uuid[80];
+	struct platform_device *pdev = to_platform_device(dev);
+
+	/*
+	 * Getting UUID pointed to by VSEC,
+	 * should be the same as logic UUID of BLP.
+	 * TODO: add PLP logic UUID
+	 */
+	ret = get_dev_uuid(pdev, uuid, sizeof(uuid));
+	if (ret)
+		return ret;
+	ret = sprintf(buf, "%s\n", uuid);
+	return ret;
+}
+static DEVICE_ATTR_RO(logic_uuids);
+
+static inline void uuid2str(const uuid_t *uuid, char *uuidstr, size_t len)
+{
+	int i, p;
+	u8 *u = (u8 *)uuid;
+
+	BUG_ON(sizeof(uuid_t) * 2 + 1 > len);
+	for (p = 0, i = sizeof(uuid_t) - 1; i >= 0; p++, i--)
+		(void) snprintf(&uuidstr[p*2], 3, "%02x", u[i]);
+}
+
+static ssize_t interface_uuids_show(struct device *dev,
+	struct device_attribute *da, char *buf)
+{
+	ssize_t ret = 0;
+	struct platform_device *pdev = to_platform_device(dev);
+	struct xmgmt_main *xmm = platform_get_drvdata(pdev);
+	u32 i;
+
+	/*
+	 * TODO: add PLP interface UUID
+	 */
+	for (i = 0; i < xmm->blp_intf_uuid_num; i++) {
+		char uuidstr[80];
+
+		uuid2str(&xmm->blp_intf_uuids[i], uuidstr, sizeof(uuidstr));
+		ret += sprintf(buf + ret, "%s\n", uuidstr);
+	}
+	return ret;
+}
+static DEVICE_ATTR_RO(interface_uuids);
+
+static struct attribute *xmgmt_main_attrs[] = {
+	&dev_attr_reset.attr,
+	&dev_attr_VBNV.attr,
+	&dev_attr_logic_uuids.attr,
+	&dev_attr_interface_uuids.attr,
+	NULL,
+};
+
+/*
+ * sysfs hook to load xclbin primarily used for driver debug
+ */
+static ssize_t ulp_image_write(struct file *filp, struct kobject *kobj,
+	struct bin_attribute *attr, char *buffer, loff_t off, size_t count)
+{
+	struct xmgmt_main *xmm =
+		dev_get_drvdata(container_of(kobj, struct device, kobj));
+	struct axlf *xclbin;
+	ulong len;
+
+	if (off == 0) {
+		if (count < sizeof(*xclbin)) {
+			xrt_err(xmm->pdev, "count is too small %ld", count);
+			return -EINVAL;
+		}
+
+		if (xmm->firmware_ulp) {
+			vfree(xmm->firmware_ulp);
+			xmm->firmware_ulp = NULL;
+		}
+		xclbin = (struct axlf *)buffer;
+		xmm->firmware_ulp = vmalloc(xclbin->m_header.m_length);
+		if (!xmm->firmware_ulp)
+			return -ENOMEM;
+	} else
+		xclbin = xmm->firmware_ulp;
+
+	len = xclbin->m_header.m_length;
+	if (off + count >= len && off < len) {
+		memcpy(xmm->firmware_ulp + off, buffer, len - off);
+		xmgmt_process_xclbin(xmm->pdev, xmm->fmgr, xmm->firmware_ulp,
+			XMGMT_ULP);
+	} else if (off + count < len) {
+		memcpy(xmm->firmware_ulp + off, buffer, count);
+	}
+
+	return count;
+}
+
+static struct bin_attribute ulp_image_attr = {
+	.attr = {
+		.name = "ulp_image",
+		.mode = 0200
+	},
+	.write = ulp_image_write,
+	.size = 0
+};
+
+static struct bin_attribute *xmgmt_main_bin_attrs[] = {
+	&ulp_image_attr,
+	NULL,
+};
+
+static const struct attribute_group xmgmt_main_attrgroup = {
+	.attrs = xmgmt_main_attrs,
+	.bin_attrs = xmgmt_main_bin_attrs,
+};
+
+static int load_firmware_from_flash(struct platform_device *pdev,
+	struct axlf **fw_buf, size_t *len)
+{
+	return -ENOTSUPP;
+}
+
+static int load_firmware_from_disk(struct platform_device *pdev, struct axlf **fw_buf,
+	size_t *len)
+{
+	char uuid[80];
+	int err = 0;
+	char fw_name[256];
+	const struct firmware *fw;
+
+	err = get_dev_uuid(pdev, uuid, sizeof(uuid));
+	if (err)
+		return err;
+
+	(void) snprintf(fw_name,
+		sizeof(fw_name), "xilinx/%s/partition.xsabin", uuid);
+	xrt_info(pdev, "try loading fw: %s", fw_name);
+
+	err = request_firmware(&fw, fw_name, DEV(pdev));
+	if (err)
+		return err;
+
+	*fw_buf = vmalloc(fw->size);
+	*len = fw->size;
+	if (*fw_buf != NULL)
+		memcpy(*fw_buf, fw->data, fw->size);
+	else
+		err = -ENOMEM;
+
+	release_firmware(fw);
+	return 0;
+}
+
+static const struct axlf *xmgmt_get_axlf_firmware(struct xmgmt_main *xmm,
+	enum provider_kind kind)
+{
+	switch (kind) {
+	case XMGMT_BLP:
+		return xmm->firmware_blp;
+	case XMGMT_PLP:
+		return xmm->firmware_plp;
+	case XMGMT_ULP:
+		return xmm->firmware_ulp;
+	default:
+		xrt_err(xmm->pdev, "unknown axlf kind: %d", kind);
+		return NULL;
+	}
+}
+
+char *xmgmt_get_dtb(struct platform_device *pdev, enum provider_kind kind)
+{
+	struct xmgmt_main *xmm = platform_get_drvdata(pdev);
+	char *dtb = NULL;
+	const struct axlf *provider = xmgmt_get_axlf_firmware(xmm, kind);
+	int rc;
+
+	if (provider == NULL)
+		return dtb;
+
+	rc = xrt_xclbin_get_metadata(DEV(pdev), provider, &dtb);
+	if (rc)
+		xrt_err(pdev, "failed to find dtb: %d", rc);
+	return dtb;
+}
+
+static const char *get_uuid_from_firmware(struct platform_device *pdev,
+	const struct axlf *xclbin)
+{
+	const void *uuid = NULL;
+	const void *uuiddup = NULL;
+	void *dtb = NULL;
+	int rc;
+
+	rc = xrt_xclbin_get_section(xclbin, PARTITION_METADATA, &dtb, NULL);
+	if (rc)
+		return NULL;
+
+	rc = xrt_md_get_prop(DEV(pdev), dtb, NULL, NULL,
+		PROP_LOGIC_UUID, &uuid, NULL);
+	if (!rc)
+		uuiddup = kstrdup(uuid, GFP_KERNEL);
+	vfree(dtb);
+	return uuiddup;
+}
+
+static bool is_valid_firmware(struct platform_device *pdev,
+	const struct axlf *xclbin, size_t fw_len)
+{
+	const char *fw_buf = (const char *)xclbin;
+	size_t axlflen = xclbin->m_header.m_length;
+	const char *fw_uuid;
+	char dev_uuid[80];
+	int err;
+
+	err = get_dev_uuid(pdev, dev_uuid, sizeof(dev_uuid));
+	if (err)
+		return false;
+
+	if (memcmp(fw_buf, ICAP_XCLBIN_V2, sizeof(ICAP_XCLBIN_V2)) != 0) {
+		xrt_err(pdev, "unknown fw format");
+		return false;
+	}
+
+	if (axlflen > fw_len) {
+		xrt_err(pdev, "truncated fw, length: %ld, expect: %ld",
+			fw_len, axlflen);
+		return false;
+	}
+
+	fw_uuid = get_uuid_from_firmware(pdev, xclbin);
+	if (fw_uuid == NULL || strcmp(fw_uuid, dev_uuid) != 0) {
+		xrt_err(pdev, "bad fw UUID: %s, expect: %s",
+			fw_uuid ? fw_uuid : "<none>", dev_uuid);
+		kfree(fw_uuid);
+		return false;
+	}
+
+	kfree(fw_uuid);
+	return true;
+}
+
+int xmgmt_get_provider_uuid(struct platform_device *pdev,
+	enum provider_kind kind, uuid_t *uuid)
+{
+	struct xmgmt_main *xmm = platform_get_drvdata(pdev);
+	const struct axlf *fwbuf;
+	const char *fw_uuid;
+	int rc = -ENOENT;
+
+	mutex_lock(&xmm->busy_mutex);
+
+	fwbuf = xmgmt_get_axlf_firmware(xmm, kind);
+	if (fwbuf == NULL)
+		goto done;
+
+	fw_uuid = get_uuid_from_firmware(pdev, fwbuf);
+	if (fw_uuid == NULL)
+		goto done;
+
+	rc = xrt_md_uuid_strtoid(DEV(pdev), fw_uuid, uuid);
+	kfree(fw_uuid);
+
+done:
+	mutex_unlock(&xmm->busy_mutex);
+	return rc;
+}
+
+static int xmgmt_create_blp(struct xmgmt_main *xmm)
+{
+	struct platform_device *pdev = xmm->pdev;
+	int rc = 0;
+	char *dtb = NULL;
+	const struct axlf *provider = xmgmt_get_axlf_firmware(xmm, XMGMT_BLP);
+
+	dtb = xmgmt_get_dtb(pdev, XMGMT_BLP);
+	if (dtb) {
+		rc = xmgmt_process_xclbin(xmm->pdev, xmm->fmgr,
+			provider, XMGMT_BLP);
+		if (rc) {
+			xrt_err(pdev, "failed to process BLP: %d", rc);
+			goto failed;
+		}
+
+		rc = xrt_subdev_create_partition(pdev, dtb);
+		if (rc < 0)
+			xrt_err(pdev, "failed to create BLP part: %d", rc);
+		else
+			rc = 0;
+
+		BUG_ON(xmm->blp_intf_uuids);
+		xrt_md_get_intf_uuids(&pdev->dev, dtb,
+			&xmm->blp_intf_uuid_num, NULL);
+		if (xmm->blp_intf_uuid_num > 0) {
+			xmm->blp_intf_uuids = vzalloc(sizeof(uuid_t) *
+				xmm->blp_intf_uuid_num);
+			xrt_md_get_intf_uuids(&pdev->dev, dtb,
+				&xmm->blp_intf_uuid_num, xmm->blp_intf_uuids);
+		}
+	}
+
+failed:
+	vfree(dtb);
+	return rc;
+}
+
+static int xmgmt_main_event_cb(struct platform_device *pdev,
+	enum xrt_events evt, void *arg)
+{
+	struct xmgmt_main *xmm = platform_get_drvdata(pdev);
+	struct xrt_event_arg_subdev *esd = (struct xrt_event_arg_subdev *)arg;
+	enum xrt_subdev_id id;
+	int instance;
+	size_t fwlen;
+
+	switch (evt) {
+	case XRT_EVENT_POST_CREATION: {
+		id = esd->xevt_subdev_id;
+		instance = esd->xevt_subdev_instance;
+		xrt_info(pdev, "processing event %d for (%d, %d)",
+			evt, id, instance);
+
+		if (id == XRT_SUBDEV_GPIO)
+			xmm->gpio_ready = true;
+		else if (id == XRT_SUBDEV_QSPI)
+			xmm->flash_ready = true;
+		else
+			BUG_ON(1);
+
+		if (xmm->gpio_ready && xmm->flash_ready) {
+			int rc;
+
+			rc = load_firmware_from_disk(pdev, &xmm->firmware_blp,
+				&fwlen);
+			if (rc != 0) {
+				rc = load_firmware_from_flash(pdev,
+					&xmm->firmware_blp, &fwlen);
+			}
+			if (rc == 0 && is_valid_firmware(pdev,
+			    xmm->firmware_blp, fwlen))
+				(void) xmgmt_create_blp(xmm);
+			else
+				xrt_err(pdev,
+					"failed to find firmware, giving up");
+			xmm->evt_hdl = NULL;
+		}
+		break;
+	}
+	case XRT_EVENT_POST_ATTACH:
+	case XRT_EVENT_PRE_DETACH:
+		break;
+	default:
+		xrt_info(pdev, "ignored event %d", evt);
+		break;
+	}
+
+	return XRT_EVENT_CB_CONTINUE;
+}
+
+static int xmgmt_main_probe(struct platform_device *pdev)
+{
+	struct xmgmt_main *xmm;
+
+	xrt_info(pdev, "probing...");
+
+	xmm = devm_kzalloc(DEV(pdev), sizeof(*xmm), GFP_KERNEL);
+	if (!xmm)
+		return -ENOMEM;
+
+	xmm->pdev = pdev;
+	xmm->fmgr = xmgmt_fmgr_probe(pdev);
+	if (IS_ERR(xmm->fmgr))
+		return PTR_ERR(xmm->fmgr);
+
+	platform_set_drvdata(pdev, xmm);
+	mutex_init(&xmm->busy_mutex);
+
+	xmm->evt_hdl = xrt_subdev_add_event_cb(pdev,
+		xmgmt_main_leaf_match, NODE_BLP_ROM, xmgmt_main_event_cb);
+
+	/* Ready to handle req thru sysfs nodes. */
+	if (sysfs_create_group(&DEV(pdev)->kobj, &xmgmt_main_attrgroup))
+		xrt_err(pdev, "failed to create sysfs group");
+	return 0;
+}
+
+static int xmgmt_main_remove(struct platform_device *pdev)
+{
+	struct xmgmt_main *xmm = platform_get_drvdata(pdev);
+
+	/* By now, partition driver should prevent any inter-leaf call. */
+
+	xrt_info(pdev, "leaving...");
+
+	if (xmm->evt_hdl)
+		(void) xrt_subdev_remove_event_cb(pdev, xmm->evt_hdl);
+	vfree(xmm->blp_intf_uuids);
+	vfree(xmm->firmware_blp);
+	vfree(xmm->firmware_plp);
+	vfree(xmm->firmware_ulp);
+	xmgmt_region_cleanup_all(pdev);
+	(void) xmgmt_fmgr_remove(xmm->fmgr);
+	(void) sysfs_remove_group(&DEV(pdev)->kobj, &xmgmt_main_attrgroup);
+	return 0;
+}
+
+static int
+xmgmt_main_leaf_ioctl(struct platform_device *pdev, u32 cmd, void *arg)
+{
+	struct xmgmt_main *xmm = platform_get_drvdata(pdev);
+	int ret = 0;
+
+	xrt_info(pdev, "handling IOCTL cmd: %d", cmd);
+
+	switch (cmd) {
+	case XRT_MGMT_MAIN_GET_AXLF_SECTION: {
+		struct xrt_mgmt_main_ioctl_get_axlf_section *get =
+			(struct xrt_mgmt_main_ioctl_get_axlf_section *)arg;
+		const struct axlf *firmware =
+			xmgmt_get_axlf_firmware(xmm, get->xmmigas_axlf_kind);
+
+		if (firmware == NULL) {
+			ret = -ENOENT;
+		} else {
+			ret = xrt_xclbin_get_section(firmware,
+				get->xmmigas_section_kind,
+				&get->xmmigas_section,
+				&get->xmmigas_section_size);
+		}
+		break;
+	}
+	case XRT_MGMT_MAIN_GET_VBNV: {
+		char **vbnv_p = (char **)arg;
+
+		*vbnv_p = xmgmt_get_vbnv(pdev);
+		break;
+	}
+	default:
+		xrt_err(pdev, "unknown cmd: %d", cmd);
+		ret = -EINVAL;
+		break;
+	}
+	return ret;
+}
+
+static int xmgmt_main_open(struct inode *inode, struct file *file)
+{
+	struct platform_device *pdev = xrt_devnode_open(inode);
+
+	/* Device may have gone already when we get here. */
+	if (!pdev)
+		return -ENODEV;
+
+	xrt_info(pdev, "opened");
+	file->private_data = platform_get_drvdata(pdev);
+	return 0;
+}
+
+static int xmgmt_main_close(struct inode *inode, struct file *file)
+{
+	struct xmgmt_main *xmm = file->private_data;
+
+	xrt_devnode_close(inode);
+
+	xrt_info(xmm->pdev, "closed");
+	return 0;
+}
+
+/*
+ * Called for xclbin download by either: xclbin load ioctl or
+ * peer request from the userpf driver over mailbox.
+ */
+static int xmgmt_bitstream_axlf_fpga_mgr(struct xmgmt_main *xmm,
+	void *axlf, size_t size)
+{
+	int ret;
+
+	BUG_ON(!mutex_is_locked(&xmm->busy_mutex));
+
+	/*
+	 * Should any error happens during download, we can't trust
+	 * the cached xclbin any more.
+	 */
+	vfree(xmm->firmware_ulp);
+	xmm->firmware_ulp = NULL;
+
+	ret = xmgmt_process_xclbin(xmm->pdev, xmm->fmgr, axlf, XMGMT_ULP);
+	if (ret == 0)
+		xmm->firmware_ulp = axlf;
+
+	return ret;
+}
+
+static int bitstream_axlf_ioctl(struct xmgmt_main *xmm, const void __user *arg)
+{
+	void *copy_buffer = NULL;
+	size_t copy_buffer_size = 0;
+	struct xmgmt_ioc_bitstream_axlf ioc_obj = { 0 };
+	struct axlf xclbin_obj = { {0} };
+	int ret = 0;
+
+	if (copy_from_user((void *)&ioc_obj, arg, sizeof(ioc_obj)))
+		return -EFAULT;
+	if (copy_from_user((void *)&xclbin_obj, ioc_obj.xclbin,
+		sizeof(xclbin_obj)))
+		return -EFAULT;
+	if (memcmp(xclbin_obj.m_magic, ICAP_XCLBIN_V2, sizeof(ICAP_XCLBIN_V2)))
+		return -EINVAL;
+
+	copy_buffer_size = xclbin_obj.m_header.m_length;
+	if (copy_buffer_size > MAX_XCLBIN_SIZE)
+		return -EINVAL;
+	copy_buffer = vmalloc(copy_buffer_size);
+	if (copy_buffer == NULL)
+		return -ENOMEM;
+
+	if (copy_from_user(copy_buffer, ioc_obj.xclbin, copy_buffer_size)) {
+		vfree(copy_buffer);
+		return -EFAULT;
+	}
+
+	ret = xmgmt_bitstream_axlf_fpga_mgr(xmm, copy_buffer, copy_buffer_size);
+	if (ret)
+		vfree(copy_buffer);
+
+	return ret;
+}
+
+static long xmgmt_main_ioctl(struct file *filp, unsigned int cmd,
+	unsigned long arg)
+{
+	long result = 0;
+	struct xmgmt_main *xmm = filp->private_data;
+
+	BUG_ON(!xmm);
+
+	if (_IOC_TYPE(cmd) != XMGMT_IOC_MAGIC)
+		return -ENOTTY;
+
+	mutex_lock(&xmm->busy_mutex);
+
+	xrt_info(xmm->pdev, "ioctl cmd %d, arg %ld", cmd, arg);
+	switch (cmd) {
+	case XMGMT_IOCICAPDOWNLOAD_AXLF:
+		result = bitstream_axlf_ioctl(xmm, (const void __user *)arg);
+		break;
+	default:
+		result = -ENOTTY;
+		break;
+	}
+
+	mutex_unlock(&xmm->busy_mutex);
+	return result;
+}
+
+struct xrt_subdev_endpoints xrt_mgmt_main_endpoints[] = {
+	{
+		.xse_names = (struct xrt_subdev_ep_names []){
+			{ .ep_name = NODE_MGMT_MAIN },
+			{ NULL },
+		},
+		.xse_min_ep = 1,
+	},
+	{ 0 },
+};
+
+struct xrt_subdev_drvdata xmgmt_main_data = {
+	.xsd_dev_ops = {
+		.xsd_ioctl = xmgmt_main_leaf_ioctl,
+	},
+	.xsd_file_ops = {
+		.xsf_ops = {
+			.owner = THIS_MODULE,
+			.open = xmgmt_main_open,
+			.release = xmgmt_main_close,
+			.unlocked_ioctl = xmgmt_main_ioctl,
+		},
+		.xsf_dev_name = "xmgmt",
+	},
+};
+
+static const struct platform_device_id xmgmt_main_id_table[] = {
+	{ XMGMT_MAIN, (kernel_ulong_t)&xmgmt_main_data },
+	{ },
+};
+
+struct platform_driver xmgmt_main_driver = {
+	.driver	= {
+		.name    = XMGMT_MAIN,
+	},
+	.probe   = xmgmt_main_probe,
+	.remove  = xmgmt_main_remove,
+	.id_table = xmgmt_main_id_table,
+};
diff --git a/drivers/fpga/xrt/mgmt/xmgmt-root.c b/drivers/fpga/xrt/mgmt/xmgmt-root.c
new file mode 100644
index 000000000000..8cac9c3b60b8
--- /dev/null
+++ b/drivers/fpga/xrt/mgmt/xmgmt-root.c
@@ -0,0 +1,375 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx Alveo Management Function Driver
+ *
+ * Copyright (C) 2020 Xilinx, Inc.
+ *
+ * Authors:
+ *	Cheng Zhen <maxz@xilinx.com>
+ */
+
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/aer.h>
+#include <linux/vmalloc.h>
+#include <linux/delay.h>
+
+#include "xrt-root.h"
+#include "subdev.h"
+#include "xmgmt-main-impl.h"
+#include "metadata.h"
+
+#define	XMGMT_MODULE_NAME	"xmgmt"
+#define	XMGMT_DRIVER_VERSION	"4.0.0"
+
+#define	XMGMT_PDEV(xm)		((xm)->pdev)
+#define	XMGMT_DEV(xm)		(&(XMGMT_PDEV(xm)->dev))
+#define xmgmt_err(xm, fmt, args...)	\
+	dev_err(XMGMT_DEV(xm), "%s: " fmt, __func__, ##args)
+#define xmgmt_warn(xm, fmt, args...)	\
+	dev_warn(XMGMT_DEV(xm), "%s: " fmt, __func__, ##args)
+#define xmgmt_info(xm, fmt, args...)	\
+	dev_info(XMGMT_DEV(xm), "%s: " fmt, __func__, ##args)
+#define xmgmt_dbg(xm, fmt, args...)	\
+	dev_dbg(XMGMT_DEV(xm), "%s: " fmt, __func__, ##args)
+#define	XMGMT_DEV_ID(pdev)			\
+	((pci_domain_nr(pdev->bus) << 16) |	\
+	PCI_DEVID(pdev->bus->number, 0))
+
+static struct class *xmgmt_class;
+static const struct pci_device_id xmgmt_pci_ids[] = {
+	{ PCI_DEVICE(0x10EE, 0xd020), },
+	{ PCI_DEVICE(0x10EE, 0x5020), },
+	{ 0, }
+};
+
+struct xmgmt {
+	struct pci_dev *pdev;
+	struct xroot *root;
+
+	/* save config for pci reset */
+	u32 saved_config[8][16];
+	bool ready;
+};
+
+static int xmgmt_config_pci(struct xmgmt *xm)
+{
+	struct pci_dev *pdev = XMGMT_PDEV(xm);
+	int rc;
+
+	rc = pcim_enable_device(pdev);
+	if (rc < 0) {
+		xmgmt_err(xm, "failed to enable device: %d", rc);
+		return rc;
+	}
+
+	rc = pci_enable_pcie_error_reporting(pdev);
+	if (rc)
+		xmgmt_warn(xm, "failed to enable AER: %d", rc);
+
+	pci_set_master(pdev);
+
+	rc = pcie_get_readrq(pdev);
+	if (rc < 0) {
+		xmgmt_err(xm, "failed to read mrrs %d", rc);
+		return rc;
+	}
+	if (rc > 512) {
+		rc = pcie_set_readrq(pdev, 512);
+		if (rc) {
+			xmgmt_err(xm, "failed to force mrrs %d", rc);
+			return rc;
+		}
+	}
+
+	return 0;
+}
+
+static void xmgmt_save_config_space(struct pci_dev *pdev, u32 *saved_config)
+{
+	int i;
+
+	for (i = 0; i < 16; i++)
+		pci_read_config_dword(pdev, i * 4, &saved_config[i]);
+}
+
+static int xmgmt_match_slot_and_save(struct device *dev, void *data)
+{
+	struct xmgmt *xm = data;
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	if (XMGMT_DEV_ID(pdev) == XMGMT_DEV_ID(xm->pdev)) {
+		pci_cfg_access_lock(pdev);
+		pci_save_state(pdev);
+		xmgmt_save_config_space(pdev,
+			xm->saved_config[PCI_FUNC(pdev->devfn)]);
+	}
+
+	return 0;
+}
+
+static void xmgmt_pci_save_config_all(struct xmgmt *xm)
+{
+	bus_for_each_dev(&pci_bus_type, NULL, xm, xmgmt_match_slot_and_save);
+}
+
+static void xmgmt_restore_config_space(struct pci_dev *pdev, u32 *config_saved)
+{
+	int i;
+	u32 val;
+
+	for (i = 0; i < 16; i++) {
+		pci_read_config_dword(pdev, i * 4, &val);
+		if (val == config_saved[i])
+			continue;
+
+		pci_write_config_dword(pdev, i * 4, config_saved[i]);
+		pci_read_config_dword(pdev, i * 4, &val);
+		if (val != config_saved[i]) {
+			dev_err(&pdev->dev,
+				 "restore config at %d failed", i * 4);
+		}
+	}
+}
+
+static int xmgmt_match_slot_and_restore(struct device *dev, void *data)
+{
+	struct xmgmt *xm = data;
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	if (XMGMT_DEV_ID(pdev) == XMGMT_DEV_ID(xm->pdev)) {
+		xmgmt_restore_config_space(pdev,
+			xm->saved_config[PCI_FUNC(pdev->devfn)]);
+
+		pci_restore_state(pdev);
+		pci_cfg_access_unlock(pdev);
+	}
+
+	return 0;
+}
+
+static void xmgmt_pci_restore_config_all(struct xmgmt *xm)
+{
+	bus_for_each_dev(&pci_bus_type, NULL, xm, xmgmt_match_slot_and_restore);
+}
+
+void xroot_hot_reset(struct pci_dev *pdev)
+{
+	struct xmgmt *xm = pci_get_drvdata(pdev);
+	struct pci_bus *bus;
+	u8 pci_bctl;
+	u16 pci_cmd, devctl;
+	int i;
+
+	xmgmt_info(xm, "hot reset start");
+
+	xmgmt_pci_save_config_all(xm);
+
+	pci_disable_device(pdev);
+
+	bus = pdev->bus;
+
+	/*
+	 * When flipping the SBR bit, device can fall off the bus. This is
+	 * usually no problem at all so long as drivers are working properly
+	 * after SBR. However, some systems complain bitterly when the device
+	 * falls off the bus.
+	 * The quick solution is to temporarily disable the SERR reporting of
+	 * switch port during SBR.
+	 */
+
+	pci_read_config_word(bus->self, PCI_COMMAND, &pci_cmd);
+	pci_write_config_word(bus->self, PCI_COMMAND,
+		(pci_cmd & ~PCI_COMMAND_SERR));
+	pcie_capability_read_word(bus->self, PCI_EXP_DEVCTL, &devctl);
+	pcie_capability_write_word(bus->self, PCI_EXP_DEVCTL,
+		(devctl & ~PCI_EXP_DEVCTL_FERE));
+	pci_read_config_byte(bus->self, PCI_BRIDGE_CONTROL, &pci_bctl);
+	pci_bctl |= PCI_BRIDGE_CTL_BUS_RESET;
+	pci_write_config_byte(bus->self, PCI_BRIDGE_CONTROL, pci_bctl);
+
+	msleep(100);
+	pci_bctl &= ~PCI_BRIDGE_CTL_BUS_RESET;
+	pci_write_config_byte(bus->self, PCI_BRIDGE_CONTROL, pci_bctl);
+	ssleep(1);
+
+	pcie_capability_write_word(bus->self, PCI_EXP_DEVCTL, devctl);
+	pci_write_config_word(bus->self, PCI_COMMAND, pci_cmd);
+
+	pci_enable_device(pdev);
+
+	for (i = 0; i < 300; i++) {
+		pci_read_config_word(pdev, PCI_COMMAND, &pci_cmd);
+		if (pci_cmd != 0xffff)
+			break;
+		msleep(20);
+	}
+
+	xmgmt_info(xm, "waiting for %d ms", i * 20);
+
+	xmgmt_pci_restore_config_all(xm);
+
+	xmgmt_config_pci(xm);
+}
+
+static int xmgmt_create_root_metadata(struct xmgmt *xm, char **root_dtb)
+{
+	char *dtb = NULL;
+	int ret;
+
+	ret = xrt_md_create(DEV(xm->pdev), &dtb);
+	if (ret) {
+		xmgmt_err(xm, "create metadata failed, ret %d", ret);
+		goto failed;
+	}
+
+	ret = xroot_add_simple_node(xm->root, dtb, NODE_TEST);
+	if (ret)
+		goto failed;
+
+	ret = xroot_add_vsec_node(xm->root, dtb);
+	if (ret == -ENOENT) {
+		/*
+		 * We may be dealing with a MFG board.
+		 * Try vsec-golden which will bring up all hard-coded leaves
+		 * at hard-coded offsets.
+		 */
+		ret = xroot_add_simple_node(xm->root, dtb, NODE_VSEC_GOLDEN);
+	} else if (ret == 0) {
+		ret = xroot_add_simple_node(xm->root, dtb, NODE_MGMT_MAIN);
+	}
+	if (ret)
+		goto failed;
+
+	*root_dtb = dtb;
+	return 0;
+
+failed:
+	vfree(dtb);
+	return ret;
+}
+
+static ssize_t ready_show(struct device *dev,
+	struct device_attribute *da, char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct xmgmt *xm = pci_get_drvdata(pdev);
+
+	return sprintf(buf, "%d\n", xm->ready);
+}
+static DEVICE_ATTR_RO(ready);
+
+static struct attribute *xmgmt_root_attrs[] = {
+	&dev_attr_ready.attr,
+	NULL
+};
+
+static struct attribute_group xmgmt_root_attr_group = {
+	.attrs = xmgmt_root_attrs,
+};
+
+static int xmgmt_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	int ret;
+	struct device *dev = DEV(pdev);
+	struct xmgmt *xm = devm_kzalloc(dev, sizeof(*xm), GFP_KERNEL);
+	char *dtb = NULL;
+
+	if (!xm)
+		return -ENOMEM;
+	xm->pdev = pdev;
+	pci_set_drvdata(pdev, xm);
+
+	ret = xmgmt_config_pci(xm);
+	if (ret)
+		goto failed;
+
+	ret = xroot_probe(pdev, &xm->root);
+	if (ret)
+		goto failed;
+
+	ret = xmgmt_create_root_metadata(xm, &dtb);
+	if (ret)
+		goto failed_metadata;
+
+	ret = xroot_create_partition(xm->root, dtb);
+	vfree(dtb);
+	if (ret)
+		xmgmt_err(xm, "failed to create root partition: %d", ret);
+
+	if (!xroot_wait_for_bringup(xm->root))
+		xmgmt_err(xm, "failed to bringup all partitions");
+	else
+		xm->ready = true;
+
+	ret = sysfs_create_group(&pdev->dev.kobj, &xmgmt_root_attr_group);
+	if (ret) {
+		/* Warning instead of failing the probe. */
+		xrt_warn(pdev, "create xmgmt root attrs failed: %d", ret);
+	}
+
+	xroot_broadcast(xm->root, XRT_EVENT_POST_ATTACH);
+	xmgmt_info(xm, "%s started successfully", XMGMT_MODULE_NAME);
+	return 0;
+
+failed_metadata:
+	(void) xroot_remove(xm->root);
+failed:
+	pci_set_drvdata(pdev, NULL);
+	return ret;
+}
+
+static void xmgmt_remove(struct pci_dev *pdev)
+{
+	struct xmgmt *xm = pci_get_drvdata(pdev);
+
+	xroot_broadcast(xm->root, XRT_EVENT_PRE_DETACH);
+	sysfs_remove_group(&pdev->dev.kobj, &xmgmt_root_attr_group);
+	(void) xroot_remove(xm->root);
+	pci_disable_pcie_error_reporting(xm->pdev);
+	xmgmt_info(xm, "%s cleaned up successfully", XMGMT_MODULE_NAME);
+}
+
+static struct pci_driver xmgmt_driver = {
+	.name = XMGMT_MODULE_NAME,
+	.id_table = xmgmt_pci_ids,
+	.probe = xmgmt_probe,
+	.remove = xmgmt_remove,
+};
+
+static int __init xmgmt_init(void)
+{
+	int res = xrt_subdev_register_external_driver(XRT_SUBDEV_MGMT_MAIN,
+		&xmgmt_main_driver, xrt_mgmt_main_endpoints);
+
+	if (res)
+		return res;
+
+	xmgmt_class = class_create(THIS_MODULE, XMGMT_MODULE_NAME);
+	if (IS_ERR(xmgmt_class))
+		return PTR_ERR(xmgmt_class);
+
+	res = pci_register_driver(&xmgmt_driver);
+	if (res) {
+		class_destroy(xmgmt_class);
+		return res;
+	}
+
+	return 0;
+}
+
+static __exit void xmgmt_exit(void)
+{
+	pci_unregister_driver(&xmgmt_driver);
+	class_destroy(xmgmt_class);
+	xrt_subdev_unregister_external_driver(XRT_SUBDEV_MGMT_MAIN);
+}
+
+module_init(xmgmt_init);
+module_exit(xmgmt_exit);
+
+MODULE_DEVICE_TABLE(pci, xmgmt_pci_ids);
+MODULE_VERSION(XMGMT_DRIVER_VERSION);
+MODULE_AUTHOR("XRT Team <runtime@xilinx.com>");
+MODULE_DESCRIPTION("Xilinx Alveo management function driver");
+MODULE_LICENSE("GPL v2");
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


Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85B902C76C1
	for <lists+linux-fpga@lfdr.de>; Sun, 29 Nov 2020 01:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbgK2AEY (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 28 Nov 2020 19:04:24 -0500
Received: from mail-bn8nam11on2049.outbound.protection.outlook.com ([40.107.236.49]:18529
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727949AbgK2AEY (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sat, 28 Nov 2020 19:04:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gRJtil5fT7slxTBAbxV2Y1WWTbf7VOJ+Zx8N8hRXof3h604nZ2+nEKxZKFJ1noLhIx0ZecZkuuB4kBIpyinpReHqrPRxwyCLdiPE5LHNXNgaeZOV2YTGrnOVzZdIi1aNt5SsjoRaBMans7056dh9/Gy8Fxf6fpBcPCyJQAdSJDOYzvFP3KZxS1uOxz45tg0Yc6HvTj/Tv6128y3KkDkm0vit+w06eXYQDK6OunsS7zKQuqzryV2Fl1GPyyWtwEXdCzlc3Y17JwR205q+iIBnnTv4l55qnTSLdz3xHi6yM4D06OshsxvtRGcXbd0TMyBVVzmyNj52mMQCcj5zq61OAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yeV8eK1vYrQ8B1QcOvPgz3uBYrmrumtkyVL2gflhr/M=;
 b=lAVG4baPCGUUJwu3EDp1x4lKiRloZFmMYj2ThnwOlXy0feJ4XEBDOW4GziM0aBtt8KXameqUkn4Ie2x+fvrHhZ+rzwKdEcQodFdD8JiCw6LhVsl64OgXumn6WoWXz9p5n2v3n4ZZ08MAk3hesom/PYCFwxuiQCEaqrYGTNbPfYvG3scAjzups6Lgfyd8nAZxeLVIQbSQ28nQsu2WEerJF0vZpLFV32TrSMEFVGScHmEUEYWVZ6OZbjrNSKu1YJkx8icolTOjtD/OfRQa7XYDr3YKCVDrOoJ41tiMt7FilYWbLp3krqyFSmfedz8xFXzg21+ufFa4XEAdz3RxqVdshw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yeV8eK1vYrQ8B1QcOvPgz3uBYrmrumtkyVL2gflhr/M=;
 b=EooFFqbXn3/8GYoogvrqqgU6dXbNCM5Jil4tdGT7gL/Ff3UKOKuTe2jD8Zz2pwFICF91T8Dviqxv6PHWtpJ62/w9VqH7Rup2JaDDfAqjLtCJJ/Ce0NA4QibKkPoVLhBGqhZSLlxipIFPxiM2bzum2OhJwYxHay7ZGA7IdxFAdTA=
Received: from BL1PR13CA0048.namprd13.prod.outlook.com (2603:10b6:208:257::23)
 by MW4PR02MB7489.namprd02.prod.outlook.com (2603:10b6:303:75::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.22; Sun, 29 Nov
 2020 00:03:04 +0000
Received: from BL2NAM02FT017.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:257:cafe::db) by BL1PR13CA0048.outlook.office365.com
 (2603:10b6:208:257::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.6 via Frontend
 Transport; Sun, 29 Nov 2020 00:03:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT017.mail.protection.outlook.com (10.152.77.174) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3611.27 via Frontend Transport; Sun, 29 Nov 2020 00:03:03 +0000
Received: from xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Sat, 28 Nov 2020 16:03:03 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Sat, 28 Nov 2020 16:03:03 -0800
Envelope-to: michal.simek@xilinx.com,
 sonal.santan@xilinx.com,
 lizhih@xilinx.com,
 maxz@xilinx.com,
 stefanos@xilinx.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.72.212] (port=45060 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <sonal.santan@xilinx.com>)
        id 1kjABD-0004bm-3C; Sat, 28 Nov 2020 16:03:03 -0800
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 6354)
        id 5B02D60011A; Sat, 28 Nov 2020 16:00:45 -0800 (PST)
From:   Sonal Santan <sonal.santan@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Sonal Santan <sonal.santan@xilinx.com>,
        <linux-fpga@vger.kernel.org>, <maxz@xilinx.com>,
        <lizhih@xilinx.com>, <michal.simek@xilinx.com>,
        <stefanos@xilinx.com>, <devicetree@vger.kernel.org>
Subject: [PATCH Xilinx Alveo 7/8] fpga: xrt: Alveo management physical function driver
Date:   Sat, 28 Nov 2020 16:00:39 -0800
Message-ID: <20201129000040.24777-8-sonals@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201129000040.24777-1-sonals@xilinx.com>
References: <20201129000040.24777-1-sonals@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8799e6cb-3c5e-4f82-0e7e-08d893fa249c
X-MS-TrafficTypeDiagnostic: MW4PR02MB7489:
X-Microsoft-Antispam-PRVS: <MW4PR02MB7489737D8AF0D94B33988B81BBF60@MW4PR02MB7489.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /x8cxx+CwCF5yseU78WPQr+kAfP27XgE4eVW06WJ0HJr/xLEkg96dvzsh8xEaB0W/0gBA3IlDbTfXVIOXYpWhlcfXT3FFfWFsRu3A6oG/TOJd0hRXF9qj5bl80aiQqJ1U6rf0U/odhHiy6XZ+SBV46zjIzkTugPHljCAhBZgLfsdbpZQxinsjDHcSoDl5aB06e6hfRdGRyiG0FcvMxVYQXN6XifEv2CXlyLNY7hrhrFrHGvXZ2gcsHX1vdIH8RxkZpVyr9C7S051ejysDy5QMBX39qPVyrt7gHS5P7tiOlr8qpQkSM3z3faHzvHyGaZSxiH8MXJZotuwMBn3rM2IaNBtM+9HxXnquGflH2fvr+Pd5IVI7QcAt4y82/qn29VkvmlKNCtzahsyDeghJcB+UQ==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(396003)(39850400004)(46966005)(7636003)(70586007)(4326008)(450100002)(6266002)(36906005)(6666004)(70206006)(478600001)(36756003)(316002)(42186006)(6916009)(54906003)(1076003)(5660300002)(30864003)(47076004)(82740400003)(356005)(8936002)(8676002)(2616005)(186003)(426003)(2906002)(336012)(26005)(44832011)(82310400003)(83380400001)(579004)(559001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2020 00:03:03.6820
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8799e6cb-3c5e-4f82-0e7e-08d893fa249c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT017.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR02MB7489
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
 drivers/fpga/alveo/mgmt/xmgmt-fmgr-drv.c     | 194 ++++
 drivers/fpga/alveo/mgmt/xmgmt-fmgr.h         |  29 +
 drivers/fpga/alveo/mgmt/xmgmt-main-impl.h    |  36 +
 drivers/fpga/alveo/mgmt/xmgmt-main-mailbox.c | 930 +++++++++++++++++++
 drivers/fpga/alveo/mgmt/xmgmt-main-ulp.c     | 190 ++++
 drivers/fpga/alveo/mgmt/xmgmt-main.c         | 843 +++++++++++++++++
 drivers/fpga/alveo/mgmt/xmgmt-root.c         | 375 ++++++++
 7 files changed, 2597 insertions(+)
 create mode 100644 drivers/fpga/alveo/mgmt/xmgmt-fmgr-drv.c
 create mode 100644 drivers/fpga/alveo/mgmt/xmgmt-fmgr.h
 create mode 100644 drivers/fpga/alveo/mgmt/xmgmt-main-impl.h
 create mode 100644 drivers/fpga/alveo/mgmt/xmgmt-main-mailbox.c
 create mode 100644 drivers/fpga/alveo/mgmt/xmgmt-main-ulp.c
 create mode 100644 drivers/fpga/alveo/mgmt/xmgmt-main.c
 create mode 100644 drivers/fpga/alveo/mgmt/xmgmt-root.c

diff --git a/drivers/fpga/alveo/mgmt/xmgmt-fmgr-drv.c b/drivers/fpga/alveo/mgmt/xmgmt-fmgr-drv.c
new file mode 100644
index 000000000000..d451b5a2c291
--- /dev/null
+++ b/drivers/fpga/alveo/mgmt/xmgmt-fmgr-drv.c
@@ -0,0 +1,194 @@
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
+#include "xrt-subdev.h"
+#include "xmgmt-fmgr.h"
+#include "xrt-axigate.h"
+#include "xmgmt-main-impl.h"
+
+/*
+ * Container to capture and cache full xclbin as it is passed in blocks by FPGA
+ * Manager. Driver needs access to full xclbin to walk through xclbin sections.
+ * FPGA Manager's .write() backend sends incremental blocks without any
+ * knowledge of xclbin format forcing us to collect the blocks and stitch them
+ * together here.
+ */
+
+struct xfpga_klass {
+	const struct platform_device *pdev;
+	struct axlf         *blob;
+	char                 name[64];
+	size_t               count;
+	size_t               total_count;
+	struct mutex         axlf_lock;
+	int                  reader_ref;
+	enum fpga_mgr_states state;
+	enum xfpga_sec_level sec_level;
+};
+
+struct key *xfpga_keys;
+
+static int xmgmt_pr_write_init(struct fpga_manager *mgr,
+	struct fpga_image_info *info, const char *buf, size_t count)
+{
+	struct xfpga_klass *obj = mgr->priv;
+	const struct axlf *bin = (const struct axlf *)buf;
+
+	if (count < sizeof(struct axlf)) {
+		obj->state = FPGA_MGR_STATE_WRITE_INIT_ERR;
+		return -EINVAL;
+	}
+
+	if (count > bin->m_header.m_length) {
+		obj->state = FPGA_MGR_STATE_WRITE_INIT_ERR;
+		return -EINVAL;
+	}
+
+	/* Free up the previous blob */
+	vfree(obj->blob);
+	obj->blob = vmalloc(bin->m_header.m_length);
+	if (!obj->blob) {
+		obj->state = FPGA_MGR_STATE_WRITE_INIT_ERR;
+		return -ENOMEM;
+	}
+
+	xrt_info(obj->pdev, "Begin download of xclbin %pUb of length %lld B",
+		&bin->m_header.uuid, bin->m_header.m_length);
+
+	obj->count = 0;
+	obj->total_count = bin->m_header.m_length;
+	obj->state = FPGA_MGR_STATE_WRITE_INIT;
+	return 0;
+}
+
+static int xmgmt_pr_write(struct fpga_manager *mgr,
+	const char *buf, size_t count)
+{
+	struct xfpga_klass *obj = mgr->priv;
+	char *curr = (char *)obj->blob;
+
+	if ((obj->state != FPGA_MGR_STATE_WRITE_INIT) &&
+		(obj->state != FPGA_MGR_STATE_WRITE)) {
+		obj->state = FPGA_MGR_STATE_WRITE_ERR;
+		return -EINVAL;
+	}
+
+	curr += obj->count;
+	obj->count += count;
+
+	/*
+	 * The xclbin buffer should not be longer than advertised in the header
+	 */
+	if (obj->total_count < obj->count) {
+		obj->state = FPGA_MGR_STATE_WRITE_ERR;
+		return -EINVAL;
+	}
+
+	xrt_info(obj->pdev, "Copying block of %zu B of xclbin", count);
+	memcpy(curr, buf, count);
+	obj->state = FPGA_MGR_STATE_WRITE;
+	return 0;
+}
+
+
+static int xmgmt_pr_write_complete(struct fpga_manager *mgr,
+				   struct fpga_image_info *info)
+{
+	int result = 0;
+	struct xfpga_klass *obj = mgr->priv;
+
+	if (obj->state != FPGA_MGR_STATE_WRITE) {
+		obj->state = FPGA_MGR_STATE_WRITE_COMPLETE_ERR;
+		return -EINVAL;
+	}
+
+	/* Check if we got the complete xclbin */
+	if (obj->blob->m_header.m_length != obj->count) {
+		obj->state = FPGA_MGR_STATE_WRITE_COMPLETE_ERR;
+		return -EINVAL;
+	}
+
+	result = xmgmt_ulp_download((void *)obj->pdev, obj->blob);
+
+	obj->state = result ? FPGA_MGR_STATE_WRITE_COMPLETE_ERR :
+		FPGA_MGR_STATE_WRITE_COMPLETE;
+	xrt_info(obj->pdev, "Finish downloading of xclbin %pUb: %d",
+		&obj->blob->m_header.uuid, result);
+	vfree(obj->blob);
+	obj->blob = NULL;
+	obj->count = 0;
+	return result;
+}
+
+static enum fpga_mgr_states xmgmt_pr_state(struct fpga_manager *mgr)
+{
+	struct xfpga_klass *obj = mgr->priv;
+
+	return obj->state;
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
+	struct fpga_manager *fmgr;
+	int ret = 0;
+	struct xfpga_klass *obj = vzalloc(sizeof(struct xfpga_klass));
+
+	xrt_info(pdev, "probing...");
+	if (!obj)
+		return ERR_PTR(-ENOMEM);
+
+	snprintf(obj->name, sizeof(obj->name), "Xilinx Alveo FPGA Manager");
+	obj->state = FPGA_MGR_STATE_UNKNOWN;
+	obj->pdev = pdev;
+	fmgr = fpga_mgr_create(&pdev->dev,
+			       obj->name,
+			       &xmgmt_pr_ops,
+			       obj);
+	if (!fmgr)
+		return ERR_PTR(-ENOMEM);
+
+	obj->sec_level = XFPGA_SEC_NONE;
+	ret = fpga_mgr_register(fmgr);
+	if (ret) {
+		fpga_mgr_free(fmgr);
+		kfree(obj);
+		return ERR_PTR(ret);
+	}
+	mutex_init(&obj->axlf_lock);
+	return fmgr;
+}
+
+int xmgmt_fmgr_remove(struct fpga_manager *fmgr)
+{
+	struct xfpga_klass *obj = fmgr->priv;
+
+	mutex_destroy(&obj->axlf_lock);
+	obj->state = FPGA_MGR_STATE_UNKNOWN;
+	fpga_mgr_unregister(fmgr);
+	vfree(obj->blob);
+	vfree(obj);
+	return 0;
+}
diff --git a/drivers/fpga/alveo/mgmt/xmgmt-fmgr.h b/drivers/fpga/alveo/mgmt/xmgmt-fmgr.h
new file mode 100644
index 000000000000..2beba649609f
--- /dev/null
+++ b/drivers/fpga/alveo/mgmt/xmgmt-fmgr.h
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
diff --git a/drivers/fpga/alveo/mgmt/xmgmt-main-impl.h b/drivers/fpga/alveo/mgmt/xmgmt-main-impl.h
new file mode 100644
index 000000000000..c89024cb8d46
--- /dev/null
+++ b/drivers/fpga/alveo/mgmt/xmgmt-main-impl.h
@@ -0,0 +1,36 @@
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
+#include "xrt-subdev.h"
+#include "xmgmt-main.h"
+
+extern struct platform_driver xmgmt_main_driver;
+extern struct xrt_subdev_endpoints xrt_mgmt_main_endpoints[];
+
+extern int xmgmt_ulp_download(struct platform_device *pdev, const void *xclbin);
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
+extern void *xmgmt_pdev2mailbox(struct platform_device *pdev);
+extern void *xmgmt_mailbox_probe(struct platform_device *pdev);
+extern void xmgmt_mailbox_remove(void *handle);
+extern void xmgmt_peer_notify_state(void *handle, bool online);
+
+#endif	/* _XMGMT_MAIN_IMPL_H_ */
diff --git a/drivers/fpga/alveo/mgmt/xmgmt-main-mailbox.c b/drivers/fpga/alveo/mgmt/xmgmt-main-mailbox.c
new file mode 100644
index 000000000000..b3d82fc3618b
--- /dev/null
+++ b/drivers/fpga/alveo/mgmt/xmgmt-main-mailbox.c
@@ -0,0 +1,930 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx Alveo FPGA MGMT PF entry point driver
+ *
+ * Copyright (C) 2020 Xilinx, Inc.
+ *
+ * Peer communication via mailbox
+ *
+ * Authors:
+ *      Cheng Zhen <maxz@xilinx.com>
+ */
+
+#include <linux/crc32c.h>
+#include <linux/xrt/mailbox_proto.h>
+#include "xmgmt-main-impl.h"
+#include "xrt-mailbox.h"
+#include "xrt-cmc.h"
+#include "xrt-metadata.h"
+#include "xrt-xclbin.h"
+#include "xrt-clock.h"
+#include "xrt-calib.h"
+#include "xrt-icap.h"
+
+struct xmgmt_mailbox {
+	struct platform_device *pdev;
+	struct platform_device *mailbox;
+	struct mutex lock;
+	void *evt_hdl;
+	char *test_msg;
+	bool peer_in_same_domain;
+};
+
+#define	XMGMT_MAILBOX_PRT_REQ(xmbx, send, request, sw_ch)	do {	\
+	const char *dir = (send) ? ">>>>>" : "<<<<<";			\
+									\
+	if ((request)->req == XCL_MAILBOX_REQ_PEER_DATA) {		\
+		struct xcl_mailbox_peer_data *p =			\
+			(struct xcl_mailbox_peer_data *)(request)->data;\
+									\
+		xrt_info((xmbx)->pdev, "%s(%s) %s%s",			\
+			mailbox_req2name((request)->req),		\
+			mailbox_group_kind2name(p->kind),		\
+			dir, mailbox_chan2name(sw_ch));			\
+	} else {							\
+		xrt_info((xmbx)->pdev, "%s %s%s",			\
+			mailbox_req2name((request)->req),		\
+			dir, mailbox_chan2name(sw_ch));			\
+	}								\
+} while (0)
+#define	XMGMT_MAILBOX_PRT_REQ_SEND(xmbx, req, sw_ch)			\
+	XMGMT_MAILBOX_PRT_REQ(xmbx, true, req, sw_ch)
+#define	XMGMT_MAILBOX_PRT_REQ_RECV(xmbx, req, sw_ch)			\
+	XMGMT_MAILBOX_PRT_REQ(xmbx, false, req, sw_ch)
+#define	XMGMT_MAILBOX_PRT_RESP(xmbx, resp)				\
+	xrt_info((xmbx)->pdev, "respond %ld bytes >>>>>%s",		\
+	(resp)->xmip_data_size, mailbox_chan2name((resp)->xmip_sw_ch))
+
+static inline struct xmgmt_mailbox *pdev2mbx(struct platform_device *pdev)
+{
+	return (struct xmgmt_mailbox *)xmgmt_pdev2mailbox(pdev);
+}
+
+static void xmgmt_mailbox_post(struct xmgmt_mailbox *xmbx,
+	u64 msgid, bool sw_ch, void *buf, size_t len)
+{
+	int rc;
+	struct xrt_mailbox_ioctl_post post = {
+		.xmip_req_id = msgid,
+		.xmip_sw_ch = sw_ch,
+		.xmip_data = buf,
+		.xmip_data_size = len
+	};
+
+	BUG_ON(!mutex_is_locked(&xmbx->lock));
+
+	if (!xmbx->mailbox) {
+		xrt_err(xmbx->pdev, "mailbox not available");
+		return;
+	}
+
+	if (msgid == 0) {
+		XMGMT_MAILBOX_PRT_REQ_SEND(xmbx,
+			(struct xcl_mailbox_req *)buf, sw_ch);
+	} else {
+		XMGMT_MAILBOX_PRT_RESP(xmbx, &post);
+	}
+
+	rc = xrt_subdev_ioctl(xmbx->mailbox, XRT_MAILBOX_POST, &post);
+	if (rc)
+		xrt_err(xmbx->pdev, "failed to post msg: %d", rc);
+}
+
+static void xmgmt_mailbox_notify(struct xmgmt_mailbox *xmbx, bool sw_ch,
+	struct xcl_mailbox_req *req, size_t len)
+{
+	xmgmt_mailbox_post(xmbx, 0, sw_ch, req, len);
+}
+
+static void xmgmt_mailbox_respond(struct xmgmt_mailbox *xmbx,
+	u64 msgid, bool sw_ch, void *buf, size_t len)
+{
+	mutex_lock(&xmbx->lock);
+	xmgmt_mailbox_post(xmbx, msgid, sw_ch, buf, len);
+	mutex_unlock(&xmbx->lock);
+}
+
+static void xmgmt_mailbox_resp_test_msg(struct xmgmt_mailbox *xmbx,
+	u64 msgid, bool sw_ch)
+{
+	struct platform_device *pdev = xmbx->pdev;
+	char *msg;
+
+	mutex_lock(&xmbx->lock);
+
+	if (xmbx->test_msg == NULL) {
+		mutex_unlock(&xmbx->lock);
+		xrt_err(pdev, "test msg is not set, drop request");
+		return;
+	}
+	msg = xmbx->test_msg;
+	xmbx->test_msg = NULL;
+
+	mutex_unlock(&xmbx->lock);
+
+	xmgmt_mailbox_respond(xmbx, msgid, sw_ch, msg, strlen(msg) + 1);
+	vfree(msg);
+}
+
+static int xmgmt_mailbox_dtb_add_prop(struct platform_device *pdev,
+	char *dst_dtb, const char *ep_name, const char *regmap_name,
+	const char *prop, const void *val, int size)
+{
+	int rc = xrt_md_set_prop(DEV(pdev), dst_dtb, ep_name, regmap_name,
+		prop, val, size);
+
+	if (rc) {
+		xrt_err(pdev, "failed to set %s@(%s, %s): %d",
+			ep_name, regmap_name, prop, rc);
+	}
+	return rc;
+}
+
+static int xmgmt_mailbox_dtb_add_vbnv(struct platform_device *pdev, char *dtb)
+{
+	int rc = 0;
+	char *vbnv = xmgmt_get_vbnv(pdev);
+
+	if (vbnv == NULL) {
+		xrt_err(pdev, "failed to get VBNV");
+		return -ENOENT;
+	}
+	rc = xmgmt_mailbox_dtb_add_prop(pdev, dtb, NULL, NULL,
+		PROP_VBNV, vbnv, strlen(vbnv) + 1);
+	kfree(vbnv);
+	return rc;
+}
+
+static int xmgmt_mailbox_dtb_copy_logic_uuid(struct platform_device *pdev,
+	const char *src_dtb, char *dst_dtb)
+{
+	const void *val;
+	int sz;
+	int rc = xrt_md_get_prop(DEV(pdev), src_dtb, NULL, NULL,
+		PROP_LOGIC_UUID, &val, &sz);
+
+	if (rc) {
+		xrt_err(pdev, "failed to get %s: %d", PROP_LOGIC_UUID, rc);
+		return rc;
+	}
+	return xmgmt_mailbox_dtb_add_prop(pdev, dst_dtb, NULL, NULL,
+		PROP_LOGIC_UUID, val, sz);
+}
+
+static int xmgmt_mailbox_dtb_add_vrom(struct platform_device *pdev,
+	const char *src_dtb, char *dst_dtb)
+{
+	/* For compatibility for legacy xrt driver. */
+	enum FeatureBitMask {
+		UNIFIED_PLATFORM		= 0x0000000000000001
+		, XARE_ENBLD			= 0x0000000000000002
+		, BOARD_MGMT_ENBLD		= 0x0000000000000004
+		, MB_SCHEDULER			= 0x0000000000000008
+		, PROM_MASK			= 0x0000000000000070
+		, DEBUG_MASK			= 0x000000000000FF00
+		, PEER_TO_PEER			= 0x0000000000010000
+		, FBM_UUID			= 0x0000000000020000
+		, HBM				= 0x0000000000040000
+		, CDMA				= 0x0000000000080000
+		, QDMA				= 0x0000000000100000
+		, RUNTIME_CLK_SCALE		= 0x0000000000200000
+		, PASSTHROUGH_VIRTUALIZATION	= 0x0000000000400000
+	};
+	struct FeatureRomHeader {
+		unsigned char EntryPointString[4];
+		uint8_t MajorVersion;
+		uint8_t MinorVersion;
+		uint32_t VivadoBuildID;
+		uint32_t IPBuildID;
+		uint64_t TimeSinceEpoch;
+		unsigned char FPGAPartName[64];
+		unsigned char VBNVName[64];
+		uint8_t DDRChannelCount;
+		uint8_t DDRChannelSize;
+		uint64_t DRBaseAddress;
+		uint64_t FeatureBitMap;
+		unsigned char uuid[16];
+		uint8_t HBMCount;
+		uint8_t HBMSize;
+		uint32_t CDMABaseAddress[4];
+	} header = { 0 };
+	char *vbnv = xmgmt_get_vbnv(pdev);
+	int rc;
+
+	*(u32 *)header.EntryPointString = 0x786e6c78;
+
+	if (vbnv)
+		strncpy(header.VBNVName, vbnv, sizeof(header.VBNVName) - 1);
+	kfree(vbnv);
+
+	header.FeatureBitMap = UNIFIED_PLATFORM;
+	rc = xrt_md_get_prop(DEV(pdev), src_dtb,
+		NODE_CMC_FW_MEM, NULL, PROP_IO_OFFSET, NULL, NULL);
+	if (rc == 0)
+		header.FeatureBitMap |= BOARD_MGMT_ENBLD;
+	rc = xrt_md_get_prop(DEV(pdev), src_dtb,
+		NODE_ERT_FW_MEM, NULL, PROP_IO_OFFSET, NULL, NULL);
+	if (rc == 0)
+		header.FeatureBitMap |= MB_SCHEDULER;
+
+	return xmgmt_mailbox_dtb_add_prop(pdev, dst_dtb, NULL, NULL,
+		PROP_VROM, &header, sizeof(header));
+}
+
+static u32 xmgmt_mailbox_dtb_user_pf(struct platform_device *pdev,
+	const char *dtb, const char *epname, const char *regmap)
+{
+	const u32 *pfnump;
+	int rc = xrt_md_get_prop(DEV(pdev), dtb, epname, regmap,
+		PROP_PF_NUM, (const void **)&pfnump, NULL);
+
+	if (rc)
+		return -1;
+	return be32_to_cpu(*pfnump);
+}
+
+static int xmgmt_mailbox_dtb_copy_user_endpoints(struct platform_device *pdev,
+	const char *src, char *dst)
+{
+	int rc = 0;
+	char *epname = NULL, *regmap = NULL;
+	u32 pfnum = xmgmt_mailbox_dtb_user_pf(pdev, src,
+		NODE_MAILBOX_USER, NULL);
+	const u32 level = cpu_to_be32(1);
+	struct device *dev = DEV(pdev);
+
+	if (pfnum == (u32)-1) {
+		xrt_err(pdev, "failed to get user pf num");
+		rc = -EINVAL;
+	}
+
+	for (xrt_md_get_next_endpoint(dev, src, NULL, NULL, &epname, &regmap);
+		rc == 0 && epname != NULL;
+		xrt_md_get_next_endpoint(dev, src, epname, regmap,
+		&epname, &regmap)) {
+		if (pfnum !=
+			xmgmt_mailbox_dtb_user_pf(pdev, src, epname, regmap))
+			continue;
+		rc = xrt_md_copy_endpoint(dev, dst, src, epname, regmap, NULL);
+		if (rc) {
+			xrt_err(pdev, "failed to copy (%s, %s): %d",
+				epname, regmap, rc);
+		} else {
+			rc = xrt_md_set_prop(dev, dst, epname, regmap,
+				PROP_PARTITION_LEVEL, &level, sizeof(level));
+			if (rc) {
+				xrt_err(pdev,
+					"can't set level for (%s, %s): %d",
+					epname, regmap, rc);
+			}
+		}
+	}
+	return rc;
+}
+
+static char *xmgmt_mailbox_user_dtb(struct platform_device *pdev)
+{
+	/* TODO: add support for PLP. */
+	const char *src = NULL;
+	char *dst = NULL;
+	struct device *dev = DEV(pdev);
+	int rc = xrt_md_create(dev, &dst);
+
+	if (rc || dst == NULL)
+		return NULL;
+
+	rc = xmgmt_mailbox_dtb_add_vbnv(pdev, dst);
+	if (rc)
+		goto fail;
+
+	src = xmgmt_get_dtb(pdev, XMGMT_BLP);
+	if (src == NULL) {
+		xrt_err(pdev, "failed to get BLP dtb");
+		goto fail;
+	}
+
+	rc = xmgmt_mailbox_dtb_copy_logic_uuid(pdev, src, dst);
+	if (rc)
+		goto fail;
+
+	rc = xmgmt_mailbox_dtb_add_vrom(pdev, src, dst);
+	if (rc)
+		goto fail;
+
+	rc = xrt_md_copy_endpoint(dev, dst, src, NODE_PARTITION_INFO,
+		NULL, NODE_PARTITION_INFO_BLP);
+	if (rc)
+		goto fail;
+
+	rc = xrt_md_copy_endpoint(dev, dst, src, NODE_INTERFACES, NULL, NULL);
+	if (rc)
+		goto fail;
+
+	rc = xmgmt_mailbox_dtb_copy_user_endpoints(pdev, src, dst);
+	if (rc)
+		goto fail;
+
+	xrt_md_pack(dev, dst);
+	vfree(src);
+	return dst;
+
+fail:
+	vfree(src);
+	vfree(dst);
+	return NULL;
+}
+
+static void xmgmt_mailbox_resp_subdev(struct xmgmt_mailbox *xmbx,
+	u64 msgid, bool sw_ch, u64 offset, u64 size)
+{
+	struct platform_device *pdev = xmbx->pdev;
+	char *dtb = xmgmt_mailbox_user_dtb(pdev);
+	long dtbsz;
+	struct xcl_subdev *hdr;
+	u64 totalsz;
+
+	if (dtb == NULL)
+		return;
+
+	dtbsz = xrt_md_size(DEV(pdev), dtb);
+	totalsz = dtbsz + sizeof(*hdr) - sizeof(hdr->data);
+	if (offset != 0 || totalsz > size) {
+		/* Only support fetching dtb in one shot. */
+		vfree(dtb);
+		xrt_err(pdev, "need %lldB, user buffer size is %lldB, dropped",
+			totalsz, size);
+		return;
+	}
+
+	hdr = vzalloc(totalsz);
+	if (hdr == NULL) {
+		vfree(dtb);
+		return;
+	}
+
+	hdr->ver = 1;
+	hdr->size = dtbsz;
+	hdr->rtncode = XRT_MSG_SUBDEV_RTN_COMPLETE;
+	(void) memcpy(hdr->data, dtb, dtbsz);
+
+	xmgmt_mailbox_respond(xmbx, msgid, sw_ch, hdr, totalsz);
+
+	vfree(dtb);
+	vfree(hdr);
+}
+
+static void xmgmt_mailbox_resp_sensor(struct xmgmt_mailbox *xmbx,
+	u64 msgid, bool sw_ch, u64 offset, u64 size)
+{
+	struct platform_device *pdev = xmbx->pdev;
+	struct xcl_sensor sensors = { 0 };
+	struct platform_device *cmcpdev = xrt_subdev_get_leaf_by_id(pdev,
+		XRT_SUBDEV_CMC, PLATFORM_DEVID_NONE);
+	int rc;
+
+	if (cmcpdev) {
+		rc = xrt_subdev_ioctl(cmcpdev, XRT_CMC_READ_SENSORS, &sensors);
+		(void) xrt_subdev_put_leaf(pdev, cmcpdev);
+		if (rc)
+			xrt_err(pdev, "can't read sensors: %d", rc);
+	}
+
+	xmgmt_mailbox_respond(xmbx, msgid, sw_ch, &sensors,
+		min((u64)sizeof(sensors), size));
+}
+
+static int xmgmt_mailbox_get_freq(struct xmgmt_mailbox *xmbx,
+	enum CLOCK_TYPE type, u64 *freq, u64 *freq_cnter)
+{
+	struct platform_device *pdev = xmbx->pdev;
+	const char *clkname =
+		clock_type2epname(type) ? clock_type2epname(type) : "UNKNOWN";
+	struct platform_device *clkpdev =
+		xrt_subdev_get_leaf_by_epname(pdev, clkname);
+	int rc;
+	struct xrt_clock_ioctl_get getfreq = { 0 };
+
+	if (clkpdev == NULL) {
+		xrt_info(pdev, "%s clock is not available", clkname);
+		return -ENOENT;
+	}
+
+	rc = xrt_subdev_ioctl(clkpdev, XRT_CLOCK_GET, &getfreq);
+	(void) xrt_subdev_put_leaf(pdev, clkpdev);
+	if (rc) {
+		xrt_err(pdev, "can't get %s clock frequency: %d", clkname, rc);
+		return rc;
+	}
+
+	if (freq)
+		*freq = getfreq.freq;
+	if (freq_cnter)
+		*freq_cnter = getfreq.freq_cnter;
+	return 0;
+}
+
+static int xmgmt_mailbox_get_icap_idcode(struct xmgmt_mailbox *xmbx, u64 *id)
+{
+	struct platform_device *pdev = xmbx->pdev;
+	struct platform_device *icappdev = xrt_subdev_get_leaf_by_id(pdev,
+		XRT_SUBDEV_ICAP, PLATFORM_DEVID_NONE);
+	int rc;
+
+	if (icappdev == NULL) {
+		xrt_err(pdev, "can't find icap");
+		return -ENOENT;
+	}
+
+	rc = xrt_subdev_ioctl(icappdev, XRT_ICAP_IDCODE, id);
+	(void) xrt_subdev_put_leaf(pdev, icappdev);
+	if (rc)
+		xrt_err(pdev, "can't get icap idcode: %d", rc);
+	return rc;
+}
+
+static int xmgmt_mailbox_get_mig_calib(struct xmgmt_mailbox *xmbx, u64 *calib)
+{
+	struct platform_device *pdev = xmbx->pdev;
+	struct platform_device *calibpdev = xrt_subdev_get_leaf_by_id(pdev,
+		XRT_SUBDEV_CALIB, PLATFORM_DEVID_NONE);
+	int rc;
+	enum xrt_calib_results res;
+
+	if (calibpdev == NULL) {
+		xrt_err(pdev, "can't find mig calibration subdev");
+		return -ENOENT;
+	}
+
+	rc = xrt_subdev_ioctl(calibpdev, XRT_CALIB_RESULT, &res);
+	(void) xrt_subdev_put_leaf(pdev, calibpdev);
+	if (rc) {
+		xrt_err(pdev, "can't get mig calibration result: %d", rc);
+	} else {
+		if (res == XRT_CALIB_SUCCEEDED)
+			*calib = 1;
+		else
+			*calib = 0;
+	}
+	return rc;
+}
+
+static void xmgmt_mailbox_resp_icap(struct xmgmt_mailbox *xmbx,
+	u64 msgid, bool sw_ch, u64 offset, u64 size)
+{
+	struct platform_device *pdev = xmbx->pdev;
+	struct xcl_pr_region icap = { 0 };
+
+	(void) xmgmt_mailbox_get_freq(xmbx,
+		CT_DATA, &icap.freq_data, &icap.freq_cntr_data);
+	(void) xmgmt_mailbox_get_freq(xmbx,
+		CT_KERNEL, &icap.freq_kernel, &icap.freq_cntr_kernel);
+	(void) xmgmt_mailbox_get_freq(xmbx,
+		CT_SYSTEM, &icap.freq_system, &icap.freq_cntr_system);
+	(void) xmgmt_mailbox_get_icap_idcode(xmbx, &icap.idcode);
+	(void) xmgmt_mailbox_get_mig_calib(xmbx, &icap.mig_calib);
+	BUG_ON(sizeof(icap.uuid) != sizeof(uuid_t));
+	(void) xmgmt_get_provider_uuid(pdev, XMGMT_ULP, (uuid_t *)&icap.uuid);
+
+	xmgmt_mailbox_respond(xmbx, msgid, sw_ch, &icap,
+		min((u64)sizeof(icap), size));
+}
+
+static void xmgmt_mailbox_resp_bdinfo(struct xmgmt_mailbox *xmbx,
+	u64 msgid, bool sw_ch, u64 offset, u64 size)
+{
+	struct platform_device *pdev = xmbx->pdev;
+	struct xcl_board_info *info = vzalloc(sizeof(*info));
+	struct platform_device *cmcpdev;
+	int rc;
+
+	if (info == NULL)
+		return;
+
+	cmcpdev = xrt_subdev_get_leaf_by_id(pdev,
+		XRT_SUBDEV_CMC, PLATFORM_DEVID_NONE);
+	if (cmcpdev) {
+		rc = xrt_subdev_ioctl(cmcpdev, XRT_CMC_READ_BOARD_INFO, info);
+		(void) xrt_subdev_put_leaf(pdev, cmcpdev);
+		if (rc)
+			xrt_err(pdev, "can't read board info: %d", rc);
+	}
+
+	xmgmt_mailbox_respond(xmbx, msgid, sw_ch, info,
+		min((u64)sizeof(*info), size));
+
+	vfree(info);
+}
+
+static void xmgmt_mailbox_simple_respond(struct xmgmt_mailbox *xmbx,
+	u64 msgid, bool sw_ch, int rc)
+{
+	xmgmt_mailbox_respond(xmbx, msgid, sw_ch, &rc, sizeof(rc));
+}
+
+static void xmgmt_mailbox_resp_peer_data(struct xmgmt_mailbox *xmbx,
+	struct xcl_mailbox_req *req, size_t len, u64 msgid, bool sw_ch)
+{
+	struct xcl_mailbox_peer_data *pdata =
+		(struct xcl_mailbox_peer_data *)req->data;
+
+	if (len < (sizeof(*req) + sizeof(*pdata) - 1)) {
+		xrt_err(xmbx->pdev, "received corrupted %s, dropped",
+			mailbox_req2name(req->req));
+		return;
+	}
+
+	switch (pdata->kind) {
+	case XCL_SENSOR:
+		xmgmt_mailbox_resp_sensor(xmbx, msgid, sw_ch,
+			pdata->offset, pdata->size);
+		break;
+	case XCL_ICAP:
+		xmgmt_mailbox_resp_icap(xmbx, msgid, sw_ch,
+			pdata->offset, pdata->size);
+		break;
+	case XCL_BDINFO:
+		xmgmt_mailbox_resp_bdinfo(xmbx, msgid, sw_ch,
+			pdata->offset, pdata->size);
+		break;
+	case XCL_SUBDEV:
+		xmgmt_mailbox_resp_subdev(xmbx, msgid, sw_ch,
+			pdata->offset, pdata->size);
+		break;
+	case XCL_MIG_ECC:
+	case XCL_FIREWALL:
+	case XCL_DNA: /* TODO **/
+		xmgmt_mailbox_simple_respond(xmbx, msgid, sw_ch, 0);
+		break;
+	default:
+		xrt_err(xmbx->pdev, "%s(%s) request not handled",
+			mailbox_req2name(req->req),
+			mailbox_group_kind2name(pdata->kind));
+		break;
+	}
+}
+
+static bool xmgmt_mailbox_is_same_domain(struct xmgmt_mailbox *xmbx,
+	struct xcl_mailbox_conn *mb_conn)
+{
+	uint32_t crc_chk;
+	phys_addr_t paddr;
+	struct platform_device *pdev = xmbx->pdev;
+
+	paddr = virt_to_phys((void *)mb_conn->kaddr);
+	if (paddr != (phys_addr_t)mb_conn->paddr) {
+		xrt_info(pdev, "paddrs differ, user 0x%llx, mgmt 0x%llx",
+			mb_conn->paddr, paddr);
+		return false;
+	}
+
+	crc_chk = crc32c_le(~0, (void *)mb_conn->kaddr, PAGE_SIZE);
+	if (crc_chk != mb_conn->crc32) {
+		xrt_info(pdev, "CRCs differ, user 0x%x, mgmt 0x%x",
+			mb_conn->crc32, crc_chk);
+		return false;
+	}
+
+	return true;
+}
+
+static void xmgmt_mailbox_resp_user_probe(struct xmgmt_mailbox *xmbx,
+	struct xcl_mailbox_req *req, size_t len, u64 msgid, bool sw_ch)
+{
+	struct xcl_mailbox_conn_resp *resp = vzalloc(sizeof(*resp));
+	struct xcl_mailbox_conn *conn = (struct xcl_mailbox_conn *)req->data;
+
+	if (resp == NULL)
+		return;
+
+	if (len < (sizeof(*req) + sizeof(*conn) - 1)) {
+		xrt_err(xmbx->pdev, "received corrupted %s, dropped",
+			mailbox_req2name(req->req));
+		vfree(resp);
+		return;
+	}
+
+	resp->conn_flags |= XCL_MB_PEER_READY;
+	if (xmgmt_mailbox_is_same_domain(xmbx, conn)) {
+		xmbx->peer_in_same_domain = true;
+		resp->conn_flags |= XCL_MB_PEER_SAME_DOMAIN;
+	}
+
+	xmgmt_mailbox_respond(xmbx, msgid, sw_ch, resp, sizeof(*resp));
+	vfree(resp);
+}
+
+static void xmgmt_mailbox_resp_hot_reset(struct xmgmt_mailbox *xmbx,
+	struct xcl_mailbox_req *req, size_t len, u64 msgid, bool sw_ch)
+{
+	int ret;
+	struct platform_device *pdev = xmbx->pdev;
+
+	xmgmt_mailbox_simple_respond(xmbx, msgid, sw_ch, 0);
+
+	ret = xmgmt_hot_reset(pdev);
+	if (ret)
+		xrt_err(pdev, "failed to hot reset: %d", ret);
+	else
+		xmgmt_peer_notify_state(xmbx, true);
+}
+
+static void xmgmt_mailbox_resp_load_xclbin(struct xmgmt_mailbox *xmbx,
+	struct xcl_mailbox_req *req, size_t len, u64 msgid, bool sw_ch)
+{
+	struct xcl_mailbox_bitstream_kaddr *kaddr =
+		(struct xcl_mailbox_bitstream_kaddr *)req->data;
+	void *xclbin = (void *)(uintptr_t)kaddr->addr;
+	int ret = bitstream_axlf_mailbox(xmbx->pdev, xclbin);
+
+	xmgmt_mailbox_simple_respond(xmbx, msgid, sw_ch, ret);
+}
+
+static void xmgmt_mailbox_listener(void *arg, void *data, size_t len,
+	u64 msgid, int err, bool sw_ch)
+{
+	struct xmgmt_mailbox *xmbx = (struct xmgmt_mailbox *)arg;
+	struct platform_device *pdev = xmbx->pdev;
+	struct xcl_mailbox_req *req = (struct xcl_mailbox_req *)data;
+
+	if (err) {
+		xrt_err(pdev, "failed to receive request: %d", err);
+		return;
+	}
+	if (len < sizeof(*req)) {
+		xrt_err(pdev, "received corrupted request");
+		return;
+	}
+
+	XMGMT_MAILBOX_PRT_REQ_RECV(xmbx, req, sw_ch);
+	switch (req->req) {
+	case XCL_MAILBOX_REQ_TEST_READ:
+		xmgmt_mailbox_resp_test_msg(xmbx, msgid, sw_ch);
+		break;
+	case XCL_MAILBOX_REQ_PEER_DATA:
+		xmgmt_mailbox_resp_peer_data(xmbx, req, len, msgid, sw_ch);
+		break;
+	case XCL_MAILBOX_REQ_READ_P2P_BAR_ADDR: /* TODO */
+		xmgmt_mailbox_simple_respond(xmbx, msgid, sw_ch, -ENOTSUPP);
+		break;
+	case XCL_MAILBOX_REQ_USER_PROBE:
+		xmgmt_mailbox_resp_user_probe(xmbx, req, len, msgid, sw_ch);
+		break;
+	case XCL_MAILBOX_REQ_HOT_RESET:
+		xmgmt_mailbox_resp_hot_reset(xmbx, req, len, msgid, sw_ch);
+		break;
+	case XCL_MAILBOX_REQ_LOAD_XCLBIN_KADDR:
+		if (xmbx->peer_in_same_domain) {
+			xmgmt_mailbox_resp_load_xclbin(xmbx,
+				req, len, msgid, sw_ch);
+		} else {
+			xrt_err(pdev, "%s not handled, not in same domain",
+				mailbox_req2name(req->req));
+		}
+		break;
+	default:
+		xrt_err(pdev, "%s(%d) request not handled",
+			mailbox_req2name(req->req), req->req);
+		break;
+	}
+}
+
+static void xmgmt_mailbox_reg_listener(struct xmgmt_mailbox *xmbx)
+{
+	struct xrt_mailbox_ioctl_listen listen = {
+		xmgmt_mailbox_listener, xmbx };
+
+	BUG_ON(!mutex_is_locked(&xmbx->lock));
+	if (!xmbx->mailbox)
+		return;
+	(void) xrt_subdev_ioctl(xmbx->mailbox, XRT_MAILBOX_LISTEN, &listen);
+}
+
+static void xmgmt_mailbox_unreg_listener(struct xmgmt_mailbox *xmbx)
+{
+	struct xrt_mailbox_ioctl_listen listen = { 0 };
+
+	BUG_ON(!mutex_is_locked(&xmbx->lock));
+	BUG_ON(!xmbx->mailbox);
+	(void) xrt_subdev_ioctl(xmbx->mailbox, XRT_MAILBOX_LISTEN, &listen);
+}
+
+static bool xmgmt_mailbox_leaf_match(enum xrt_subdev_id id,
+	struct platform_device *pdev, void *arg)
+{
+	return (id == XRT_SUBDEV_MAILBOX);
+}
+
+static int xmgmt_mailbox_event_cb(struct platform_device *pdev,
+	enum xrt_events evt, void *arg)
+{
+	struct xmgmt_mailbox *xmbx = pdev2mbx(pdev);
+	struct xrt_event_arg_subdev *esd = (struct xrt_event_arg_subdev *)arg;
+
+	switch (evt) {
+	case XRT_EVENT_POST_CREATION:
+		BUG_ON(esd->xevt_subdev_id != XRT_SUBDEV_MAILBOX);
+		BUG_ON(xmbx->mailbox);
+		mutex_lock(&xmbx->lock);
+		xmbx->mailbox = xrt_subdev_get_leaf_by_id(pdev,
+			XRT_SUBDEV_MAILBOX, PLATFORM_DEVID_NONE);
+		xmgmt_mailbox_reg_listener(xmbx);
+		mutex_unlock(&xmbx->lock);
+		break;
+	case XRT_EVENT_PRE_REMOVAL:
+		BUG_ON(esd->xevt_subdev_id != XRT_SUBDEV_MAILBOX);
+		BUG_ON(!xmbx->mailbox);
+		mutex_lock(&xmbx->lock);
+		xmgmt_mailbox_unreg_listener(xmbx);
+		(void) xrt_subdev_put_leaf(pdev, xmbx->mailbox);
+		xmbx->mailbox = NULL;
+		mutex_unlock(&xmbx->lock);
+		break;
+	default:
+		break;
+	}
+
+	return XRT_EVENT_CB_CONTINUE;
+}
+
+static ssize_t xmgmt_mailbox_user_dtb_show(struct file *filp,
+	struct kobject *kobj, struct bin_attribute *attr,
+	char *buf, loff_t off, size_t count)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct platform_device *pdev = to_platform_device(dev);
+	char *blob = NULL;
+	long  size;
+	ssize_t ret = 0;
+
+	blob = xmgmt_mailbox_user_dtb(pdev);
+	if (!blob) {
+		ret = -ENOENT;
+		goto failed;
+	}
+
+	size = xrt_md_size(dev, blob);
+	if (size <= 0) {
+		ret = -EINVAL;
+		goto failed;
+	}
+
+	if (off >= size)
+		goto failed;
+	if (off + count > size)
+		count = size - off;
+	memcpy(buf, blob + off, count);
+
+	ret = count;
+failed:
+	vfree(blob);
+	return ret;
+}
+
+static struct bin_attribute meta_data_attr = {
+	.attr = {
+		.name = "metadata_for_user",
+		.mode = 0400
+	},
+	.read = xmgmt_mailbox_user_dtb_show,
+	.size = 0
+};
+
+static struct bin_attribute  *xmgmt_mailbox_bin_attrs[] = {
+	&meta_data_attr,
+	NULL,
+};
+
+int xmgmt_mailbox_get_test_msg(struct xmgmt_mailbox *xmbx, bool sw_ch,
+	char *buf, size_t *len)
+{
+	int rc;
+	struct platform_device *pdev = xmbx->pdev;
+	struct xcl_mailbox_req req = { 0, XCL_MAILBOX_REQ_TEST_READ, };
+	struct xrt_mailbox_ioctl_request leaf_req = {
+		.xmir_sw_ch = sw_ch,
+		.xmir_resp_ttl = 1,
+		.xmir_req = &req,
+		.xmir_req_size = sizeof(req),
+		.xmir_resp = buf,
+		.xmir_resp_size = *len
+	};
+
+	mutex_lock(&xmbx->lock);
+	if (xmbx->mailbox) {
+		XMGMT_MAILBOX_PRT_REQ_SEND(xmbx, &req, leaf_req.xmir_sw_ch);
+		/*
+		 * mgmt should never send request to peer. it should send
+		 * either notification or response. here is the only exception
+		 * for debugging purpose.
+		 */
+		rc = xrt_subdev_ioctl(xmbx->mailbox,
+			XRT_MAILBOX_REQUEST, &leaf_req);
+	} else {
+		rc = -ENODEV;
+		xrt_err(pdev, "mailbox not available");
+	}
+	mutex_unlock(&xmbx->lock);
+
+	if (rc == 0)
+		*len = leaf_req.xmir_resp_size;
+	return rc;
+}
+
+int xmgmt_mailbox_set_test_msg(struct xmgmt_mailbox *xmbx,
+	char *buf, size_t len)
+{
+	mutex_lock(&xmbx->lock);
+
+	if (xmbx->test_msg)
+		vfree(xmbx->test_msg);
+	xmbx->test_msg = vmalloc(len);
+	if (xmbx->test_msg == NULL) {
+		mutex_unlock(&xmbx->lock);
+		return -ENOMEM;
+	}
+	(void) memcpy(xmbx->test_msg, buf, len);
+
+	mutex_unlock(&xmbx->lock);
+	return 0;
+}
+
+static ssize_t peer_msg_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	size_t len = 4096;
+	struct platform_device *pdev = to_platform_device(dev);
+	struct xmgmt_mailbox *xmbx = pdev2mbx(pdev);
+	int ret = xmgmt_mailbox_get_test_msg(xmbx, false, buf, &len);
+
+	return ret == 0 ? len : ret;
+}
+static ssize_t peer_msg_store(struct device *dev,
+	struct device_attribute *da, const char *buf, size_t count)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct xmgmt_mailbox *xmbx = pdev2mbx(pdev);
+	int ret = xmgmt_mailbox_set_test_msg(xmbx, (char *)buf, count);
+
+	return ret == 0 ? count : ret;
+}
+/* Message test i/f. */
+static DEVICE_ATTR_RW(peer_msg);
+
+static struct attribute *xmgmt_mailbox_attrs[] = {
+	&dev_attr_peer_msg.attr,
+	NULL,
+};
+
+static const struct attribute_group xmgmt_mailbox_attrgroup = {
+	.bin_attrs = xmgmt_mailbox_bin_attrs,
+	.attrs = xmgmt_mailbox_attrs,
+};
+
+void *xmgmt_mailbox_probe(struct platform_device *pdev)
+{
+	struct xmgmt_mailbox *xmbx =
+		devm_kzalloc(DEV(pdev), sizeof(*xmbx), GFP_KERNEL);
+
+	if (!xmbx)
+		return NULL;
+	xmbx->pdev = pdev;
+	mutex_init(&xmbx->lock);
+
+	xmbx->evt_hdl = xrt_subdev_add_event_cb(pdev,
+		xmgmt_mailbox_leaf_match, NULL, xmgmt_mailbox_event_cb);
+	(void) sysfs_create_group(&DEV(pdev)->kobj, &xmgmt_mailbox_attrgroup);
+	return xmbx;
+}
+
+void xmgmt_mailbox_remove(void *handle)
+{
+	struct xmgmt_mailbox *xmbx = (struct xmgmt_mailbox *)handle;
+	struct platform_device *pdev = xmbx->pdev;
+
+	(void) sysfs_remove_group(&DEV(pdev)->kobj, &xmgmt_mailbox_attrgroup);
+	if (xmbx->evt_hdl)
+		(void) xrt_subdev_remove_event_cb(pdev, xmbx->evt_hdl);
+	if (xmbx->mailbox)
+		(void) xrt_subdev_put_leaf(pdev, xmbx->mailbox);
+	if (xmbx->test_msg)
+		vfree(xmbx->test_msg);
+}
+
+void xmgmt_peer_notify_state(void *handle, bool online)
+{
+	struct xmgmt_mailbox *xmbx = (struct xmgmt_mailbox *)handle;
+	struct xcl_mailbox_peer_state *st;
+	struct xcl_mailbox_req *req;
+	size_t reqlen = sizeof(*req) + sizeof(*st) - 1;
+
+	req = vzalloc(reqlen);
+	if (req == NULL)
+		return;
+
+	req->req = XCL_MAILBOX_REQ_MGMT_STATE;
+	st = (struct xcl_mailbox_peer_state *)req->data;
+	st->state_flags = online ? XCL_MB_STATE_ONLINE : XCL_MB_STATE_OFFLINE;
+	mutex_lock(&xmbx->lock);
+	xmgmt_mailbox_notify(xmbx, false, req, reqlen);
+	mutex_unlock(&xmbx->lock);
+}
diff --git a/drivers/fpga/alveo/mgmt/xmgmt-main-ulp.c b/drivers/fpga/alveo/mgmt/xmgmt-main-ulp.c
new file mode 100644
index 000000000000..042d86fcef41
--- /dev/null
+++ b/drivers/fpga/alveo/mgmt/xmgmt-main-ulp.c
@@ -0,0 +1,190 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx Alveo FPGA MGMT PF entry point driver
+ *
+ * Copyright (C) 2020 Xilinx, Inc.
+ *
+ * xclbin download
+ *
+ * Authors:
+ *      Lizhi Hou <lizhi.hou@xilinx.com>
+ */
+
+#include <linux/firmware.h>
+#include <linux/uaccess.h>
+#include "xrt-xclbin.h"
+#include "xrt-metadata.h"
+#include "xrt-subdev.h"
+#include "xrt-gpio.h"
+#include "xmgmt-main.h"
+#include "xrt-icap.h"
+#include "xrt-axigate.h"
+
+static int xmgmt_download_bitstream(struct platform_device  *pdev,
+	const void *xclbin)
+{
+	struct platform_device *icap_leaf = NULL;
+	struct XHwIcap_Bit_Header bit_header = { 0 };
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
+static bool match_shell(enum xrt_subdev_id id,
+	struct platform_device *pdev, void *arg)
+{
+	struct xrt_subdev_platdata *pdata = DEV_PDATA(pdev);
+	const char *ulp_gate;
+	int ret;
+
+	if (!pdata || xrt_md_size(&pdev->dev, pdata->xsp_dtb) <= 0)
+		return false;
+
+	ret = xrt_md_get_epname_pointer(&pdev->dev, pdata->xsp_dtb,
+		NODE_GATE_ULP, NULL, &ulp_gate);
+	if (ret)
+		return false;
+
+	ret = xrt_md_check_uuids(&pdev->dev, pdata->xsp_dtb, arg);
+	if (ret)
+		return false;
+
+	return true;
+}
+
+static bool match_ulp(enum xrt_subdev_id id,
+	struct platform_device *pdev, void *arg)
+{
+	struct xrt_subdev_platdata *pdata = DEV_PDATA(pdev);
+	const char *ulp_gate;
+	int ret;
+
+	if (!pdata || xrt_md_size(&pdev->dev, pdata->xsp_dtb) <= 0)
+		return false;
+
+	ret = xrt_md_check_uuids(&pdev->dev, pdata->xsp_dtb, arg);
+	if (ret)
+		return false;
+
+	ret = xrt_md_get_epname_pointer(&pdev->dev, pdata->xsp_dtb,
+		NODE_GATE_ULP, NULL, &ulp_gate);
+	if (!ret)
+		return false;
+
+	return true;
+}
+
+int xmgmt_ulp_download(struct platform_device  *pdev, const void *xclbin)
+{
+	struct platform_device *axigate_leaf;
+	char *dtb = NULL;
+	int ret = 0, part_inst;
+
+	ret = xrt_xclbin_get_metadata(DEV(pdev), xclbin, &dtb);
+	if (ret) {
+		xrt_err(pdev, "can not get partition metadata, ret %d", ret);
+		goto failed;
+	}
+
+	part_inst = xrt_subdev_lookup_partition(pdev, match_shell, dtb);
+	if (part_inst < 0) {
+		xrt_err(pdev, "not found matching plp.");
+		ret = -ENODEV;
+		goto failed;
+	}
+
+	/*
+	 * Find ulp partition with interface uuid from incoming xclbin, which
+	 * is verified before with matching plp partition.
+	 */
+	part_inst = xrt_subdev_lookup_partition(pdev, match_ulp, dtb);
+	if (part_inst >= 0) {
+		ret = xrt_subdev_destroy_partition(pdev, part_inst);
+		if (ret) {
+			xrt_err(pdev, "failed to destroy existing ulp, %d",
+				ret);
+			goto failed;
+		}
+	}
+
+	axigate_leaf = xrt_subdev_get_leaf_by_epname(pdev, NODE_GATE_ULP);
+
+	/* gate may not be exist for 0rp */
+	if (axigate_leaf) {
+		ret = xrt_subdev_ioctl(axigate_leaf, XRT_AXIGATE_FREEZE,
+			NULL);
+		if (ret) {
+			xrt_err(pdev, "can not freeze gate %s, %d",
+				NODE_GATE_ULP, ret);
+			xrt_subdev_put_leaf(pdev, axigate_leaf);
+			goto failed;
+		}
+	}
+	ret = xmgmt_download_bitstream(pdev, xclbin);
+	if (axigate_leaf) {
+		xrt_subdev_ioctl(axigate_leaf, XRT_AXIGATE_FREE, NULL);
+
+		/* Do we really need this extra toggling gate before setting
+		 * clocks?
+		 * xrt_subdev_ioctl(axigate_leaf, XRT_AXIGATE_FREEZE, NULL);
+		 * xrt_subdev_ioctl(axigate_leaf, XRT_AXIGATE_FREE, NULL);
+		 */
+
+		xrt_subdev_put_leaf(pdev, axigate_leaf);
+	}
+	if (ret) {
+		xrt_err(pdev, "bitstream download failed, ret %d", ret);
+		goto failed;
+	}
+	ret = xrt_subdev_create_partition(pdev, dtb);
+	if (ret < 0) {
+		xrt_err(pdev, "failed creating partition, ret %d", ret);
+		goto failed;
+	}
+
+	ret = xrt_subdev_wait_for_partition_bringup(pdev);
+	if (ret)
+		xrt_err(pdev, "partiton bringup failed, ret %d", ret);
+
+	/*
+	 * TODO: needs to check individual subdevs to see if there
+	 * is any error, such as clock setting, memory bank calibration.
+	 */
+
+failed:
+	vfree(dtb);
+	return ret;
+}
diff --git a/drivers/fpga/alveo/mgmt/xmgmt-main.c b/drivers/fpga/alveo/mgmt/xmgmt-main.c
new file mode 100644
index 000000000000..23e68e3a4ae1
--- /dev/null
+++ b/drivers/fpga/alveo/mgmt/xmgmt-main.c
@@ -0,0 +1,843 @@
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
+#include "xrt-metadata.h"
+#include "xrt-flash.h"
+#include "xrt-subdev.h"
+#include <linux/xrt/flash_xrt_data.h>
+#include <linux/xrt/xmgmt-ioctl.h>
+#include "xrt-gpio.h"
+#include "xmgmt-main.h"
+#include "xmgmt-fmgr.h"
+#include "xrt-icap.h"
+#include "xrt-axigate.h"
+#include "xmgmt-main-impl.h"
+
+#define	XMGMT_MAIN "xmgmt_main"
+
+struct xmgmt_main {
+	struct platform_device *pdev;
+	void *evt_hdl;
+	char *firmware_blp;
+	char *firmware_plp;
+	char *firmware_ulp;
+	bool flash_ready;
+	bool gpio_ready;
+	struct fpga_manager *fmgr;
+	void *mailbox_hdl;
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
+	if (xmm->firmware_plp) {
+		vbnv = ((struct axlf *)xmm->firmware_plp)->
+			m_header.m_platformVBNV;
+	} else if (xmm->firmware_blp) {
+		vbnv = ((struct axlf *)xmm->firmware_blp)->
+			m_header.m_platformVBNV;
+	} else {
+		return NULL;
+	}
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
+		xclbin = (struct axlf *)xmm->firmware_ulp;
+
+	len = xclbin->m_header.m_length;
+	if (off + count >= len && off < len) {
+		memcpy(xmm->firmware_ulp + off, buffer, len - off);
+		xmgmt_ulp_download(xmm->pdev, xmm->firmware_ulp);
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
+	char **fw_buf, size_t *len)
+{
+	struct platform_device *flash_leaf = NULL;
+	struct flash_data_header header = { 0 };
+	const size_t magiclen = sizeof(header.fdh_id_begin.fdi_magic);
+	size_t flash_size = 0;
+	int ret = 0;
+	char *buf = NULL;
+	struct flash_data_ident id = { 0 };
+	struct xrt_flash_ioctl_read frd = { 0 };
+
+	xrt_info(pdev, "try loading fw from flash");
+
+	flash_leaf = xrt_subdev_get_leaf_by_id(pdev, XRT_SUBDEV_QSPI,
+		PLATFORM_DEVID_NONE);
+	if (flash_leaf == NULL) {
+		xrt_err(pdev, "failed to hold flash leaf");
+		return -ENODEV;
+	}
+
+	(void) xrt_subdev_ioctl(flash_leaf, XRT_FLASH_GET_SIZE, &flash_size);
+	if (flash_size == 0) {
+		xrt_err(pdev, "failed to get flash size");
+		ret = -EINVAL;
+		goto done;
+	}
+
+	frd.xfir_buf = (char *)&header;
+	frd.xfir_size = sizeof(header);
+	frd.xfir_offset = flash_size - sizeof(header);
+	ret = xrt_subdev_ioctl(flash_leaf, XRT_FLASH_READ, &frd);
+	if (ret) {
+		xrt_err(pdev, "failed to read header from flash: %d", ret);
+		goto done;
+	}
+
+	/* Pick the end ident since header is aligned in the end of flash. */
+	id = header.fdh_id_end;
+	if (strncmp(id.fdi_magic, XRT_DATA_MAGIC, magiclen)) {
+		char tmp[sizeof(id.fdi_magic) + 1] = { 0 };
+
+		memcpy(tmp, id.fdi_magic, magiclen);
+		xrt_info(pdev, "ignore meta data, bad magic: %s", tmp);
+		ret = -ENOENT;
+		goto done;
+	}
+	if (id.fdi_version != 0) {
+		xrt_info(pdev, "flash meta data version is not supported: %d",
+			id.fdi_version);
+		ret = -EOPNOTSUPP;
+		goto done;
+	}
+
+	buf = vmalloc(header.fdh_data_len);
+	if (buf == NULL) {
+		ret = -ENOMEM;
+		goto done;
+	}
+
+	frd.xfir_buf = buf;
+	frd.xfir_size = header.fdh_data_len;
+	frd.xfir_offset = header.fdh_data_offset;
+	ret = xrt_subdev_ioctl(flash_leaf, XRT_FLASH_READ, &frd);
+	if (ret) {
+		xrt_err(pdev, "failed to read meta data from flash: %d", ret);
+		goto done;
+	} else if (flash_xrt_data_get_parity32(buf, header.fdh_data_len) ^
+		header.fdh_data_parity) {
+		xrt_err(pdev, "meta data is corrupted");
+		ret = -EINVAL;
+		goto done;
+	}
+
+	xrt_info(pdev, "found meta data of %d bytes @0x%x",
+		header.fdh_data_len, header.fdh_data_offset);
+	*fw_buf = buf;
+	*len = header.fdh_data_len;
+
+done:
+	(void) xrt_subdev_put_leaf(pdev, flash_leaf);
+	return ret;
+}
+
+static int load_firmware_from_disk(struct platform_device *pdev, char **fw_buf,
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
+static const char *xmgmt_get_axlf_firmware(struct xmgmt_main *xmm,
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
+	const char *provider = xmgmt_get_axlf_firmware(xmm, kind);
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
+	const char *axlf)
+{
+	const void *uuid = NULL;
+	const void *uuiddup = NULL;
+	void *dtb = NULL;
+	int rc;
+
+	rc = xrt_xclbin_get_section(axlf, PARTITION_METADATA, &dtb, NULL);
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
+	char *fw_buf, size_t fw_len)
+{
+	struct axlf *axlf = (struct axlf *)fw_buf;
+	size_t axlflen = axlf->m_header.m_length;
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
+	fw_uuid = get_uuid_from_firmware(pdev, fw_buf);
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
+	const char *fwbuf;
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
+
+	dtb = xmgmt_get_dtb(pdev, XMGMT_BLP);
+	if (dtb) {
+		rc = xrt_subdev_create_partition(pdev, dtb);
+		if (rc < 0)
+			xrt_err(pdev, "failed to create BLP: %d", rc);
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
+		xmgmt_peer_notify_state(xmm->mailbox_hdl, true);
+		break;
+	case XRT_EVENT_PRE_DETACH:
+		xmgmt_peer_notify_state(xmm->mailbox_hdl, false);
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
+	platform_set_drvdata(pdev, xmm);
+	xmm->fmgr = xmgmt_fmgr_probe(pdev);
+	xmm->mailbox_hdl = xmgmt_mailbox_probe(pdev);
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
+	(void) xmgmt_fmgr_remove(xmm->fmgr);
+	xmgmt_mailbox_remove(xmm->mailbox_hdl);
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
+		const char *firmware =
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
+static int xmgmt_bitstream_axlf_fpga_mgr(struct xmgmt_main *xmm,
+	void *axlf, size_t size)
+{
+	int ret;
+	struct fpga_image_info info = { 0 };
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
+	info.buf = (char *)axlf;
+	info.count = size;
+	ret = fpga_mgr_load(xmm->fmgr, &info);
+	if (ret == 0)
+		xmm->firmware_ulp = axlf;
+
+	return ret;
+}
+
+int bitstream_axlf_mailbox(struct platform_device *pdev, const void *axlf)
+{
+	struct xmgmt_main *xmm = platform_get_drvdata(pdev);
+	void *copy_buffer = NULL;
+	size_t copy_buffer_size = 0;
+	const struct axlf *xclbin_obj = axlf;
+	int ret = 0;
+
+	if (memcmp(xclbin_obj->m_magic, ICAP_XCLBIN_V2, sizeof(ICAP_XCLBIN_V2)))
+		return -EINVAL;
+
+	copy_buffer_size = xclbin_obj->m_header.m_length;
+	if (copy_buffer_size > MAX_XCLBIN_SIZE)
+		return -EINVAL;
+	copy_buffer = vmalloc(copy_buffer_size);
+	if (copy_buffer == NULL)
+		return -ENOMEM;
+	(void) memcpy(copy_buffer, axlf, copy_buffer_size);
+
+	mutex_lock(&xmm->busy_mutex);
+	ret = xmgmt_bitstream_axlf_fpga_mgr(xmm, copy_buffer, copy_buffer_size);
+	mutex_unlock(&xmm->busy_mutex);
+	if (ret)
+		vfree(copy_buffer);
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
+void *xmgmt_pdev2mailbox(struct platform_device *pdev)
+{
+	struct xmgmt_main *xmm = platform_get_drvdata(pdev);
+
+	return xmm->mailbox_hdl;
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
diff --git a/drivers/fpga/alveo/mgmt/xmgmt-root.c b/drivers/fpga/alveo/mgmt/xmgmt-root.c
new file mode 100644
index 000000000000..005fd5e42651
--- /dev/null
+++ b/drivers/fpga/alveo/mgmt/xmgmt-root.c
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
+#include "xrt-subdev.h"
+#include "xmgmt-main-impl.h"
+#include "xrt-metadata.h"
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
+	void *root;
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
+		ret = xroot_add_simple_node(xm, dtb, NODE_VSEC_GOLDEN);
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
-- 
2.17.1


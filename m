Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94394393AC4
	for <lists+linux-fpga@lfdr.de>; Fri, 28 May 2021 02:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236073AbhE1A4O (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 27 May 2021 20:56:14 -0400
Received: from mail-co1nam11on2056.outbound.protection.outlook.com ([40.107.220.56]:31969
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235571AbhE1A4H (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 27 May 2021 20:56:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=He7sE/kx603KKb5mfb9E844Rq1892YwQSBOFlQQZNAToocLIcwPqzZbntRGbkadQdZAEz3AQSTFRXNLnuGgd+GaIBONuy5HzZ3yfQkqoDUieBvidM9GL4m9pe5AxHbwM8Rqv5T94XbDylJXIOUT99L7Jla5DFWMttNOhXHMzJOEQ4t9bOBTYTFOC8zduWLPXKW1rpPpTLvmOy1Ve6zsgmJdEpwuJXuMoMfsKLzWisU9mUbgL7NFL65YJ3XhLktnBtLdk2O1a+hoFtd9tAHArZd95MrcuW1TCLELaUtmIJZ8p50x+pVM5bckXxSNs1SDWcPreq97cgedg2RfmLQtiMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bwGScXAKq1YCjyZe/LJC51PdA34ZIXAEmS7y0o7dfMs=;
 b=SX2yOheMkDMVbgFirhiZ5RYvC05FeZCV1+UQc5PZMA60Q2P2buuL3pNoJTpWuuBSmmFvkpNj95yHyqZZxB0tdQ/OlMa1KLt9Rp/eGlRgt0dkFLAlOcWqcFIcoeBp3wWNVIGYnCuUF08aosjP2GRNOukeY8xJ5QjQnbuGPE3GtFAql+0xtDkt03YYMW37lG2TFxyPH+fDKGWS+xE71dngfpK7/+2M+Mw/k2t2zFbH9DO6hWqcphgHRCDKyuL8kBqVWaRPNin9rbIsT7t8a1Mn/vZ1pKfMrZbK/yTdX79/k4rkErVO1XAk5XtqTxUOEVjhSi9y82qcOqKwxxKXeMrFxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bwGScXAKq1YCjyZe/LJC51PdA34ZIXAEmS7y0o7dfMs=;
 b=iMQHpQYNrTcuIT9idKfGzRkR6dDHsA9GW05AmhxkclnnERqWSaUF1XPfMXEw/QixtifUBJG0c97Q9ziWJAMWfVFX6D/FDlIgLBrlagx7UaDdHV0vHOFLAnBI8uDuoi/ojh0lySjvKIDe6LUvovWy1MsJ9/j+2Dk0RJ2LGWANAmg=
Received: from BN6PR2001CA0008.namprd20.prod.outlook.com
 (2603:10b6:404:b4::18) by BL0PR02MB5411.namprd02.prod.outlook.com
 (2603:10b6:208:83::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Fri, 28 May
 2021 00:54:28 +0000
Received: from BN1NAM02FT052.eop-nam02.prod.protection.outlook.com
 (2603:10b6:404:b4:cafe::4) by BN6PR2001CA0008.outlook.office365.com
 (2603:10b6:404:b4::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Fri, 28 May 2021 00:54:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT052.mail.protection.outlook.com (10.13.2.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4150.30 via Frontend Transport; Fri, 28 May 2021 00:54:27 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 27 May 2021 17:53:44 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Thu, 27 May 2021 17:53:44 -0700
Envelope-to: mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.73.109] (port=34042 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1lmQky-0007Lg-A9; Thu, 27 May 2021 17:53:44 -0700
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id 59FB96032B4; Thu, 27 May 2021 17:50:07 -0700 (PDT)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>, Max Zhen <max.zhen@xilinx.com>
Subject: [PATCH V7 XRT Alveo 18/20] fpga: xrt: DDR calibration driver
Date:   Thu, 27 May 2021 17:49:57 -0700
Message-ID: <20210528004959.61354-19-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210528004959.61354-1-lizhi.hou@xilinx.com>
References: <20210528004959.61354-1-lizhi.hou@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a1e30e1d-9e81-4884-faaa-08d921732545
X-MS-TrafficTypeDiagnostic: BL0PR02MB5411:
X-Microsoft-Antispam-PRVS: <BL0PR02MB54114B5FE210C856C8FF7636A1229@BL0PR02MB5411.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:311;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eLHEckDZ6ubM2/p9W4Hz4PDKoUHEGQfNpEaJkB9wYd2RKNJlssdD37iG+j7j+H4+UsQp5A5E/7q/xvezd5C0w16kEkZ4ZhQV+p2lT/ugorqTnYflOtRK7OhcWJXnMkiMKxJyxDou+qKjV0y3YzsSQR/frauodeG0iaRSQlyXd5OaF6t9cSIQpgeCR5Y08wOL4uke69kRLQiVQ1kC1Y13MxRTm8wezlVi/YquttTEVsX7YCPEGA1Xf5x9FWIZUdreOjhyS5j098FVKy6yxnuVoUu2b53XWhXZK2lIMEeYJ9g19+W0OhvUeEPOFAiCRO8TTgfAtwiGLog6hzlrhBtEgHsqtiPa1P5sYnw7VrLDIv+/0AiIVpmm2k7l7KZvCtmLYHQMvsZty7sHrWAq053aYdy8TSzsKj4Y/KM3J3G+q/fG24dnxvSnFZKl5t+UPCXJJk5msGSFwOjsqv8WKSEWTorhugCNDtiCcRYktm9OkoE7bGIQOddq4PyQYiqrLEIIKv+fmG2UHHL+RXR0Vn+Lhbsp9s1JIT1/hQW1mrFIwI5zheWR+adGaosdT28Gr7GPTrh9wrRPhc6GUvRwLqfUx1ahoo2K0wfxUR2k2QnZnvZA0Mg1b4NNpVu2XquqDcs8pDUDRg3/E6i7x7QIrRocbxKRN6u8CD/suDxzlYQwdIQ=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(396003)(39840400004)(136003)(346002)(376002)(36840700001)(46966006)(5660300002)(4326008)(8676002)(186003)(47076005)(70586007)(107886003)(2616005)(6916009)(316002)(82310400003)(70206006)(42186006)(7636003)(356005)(36756003)(6266002)(1076003)(36860700001)(478600001)(26005)(44832011)(54906003)(83380400001)(8936002)(2906002)(426003)(336012)(6666004);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 00:54:27.8385
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1e30e1d-9e81-4884-faaa-08d921732545
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT052.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB5411
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Add DDR calibration driver. DDR calibration is a hardware function
discovered by walking firmware metadata. A xrt device node will
be created for it. Hardware provides DDR calibration status through
this function.

Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
Signed-off-by: Max Zhen <max.zhen@xilinx.com>
Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
Reviewed-by: Tom Rix <trix@redhat.com>
---
 .../fpga/xrt/include/xleaf/ddr_calibration.h  |  28 +++
 drivers/fpga/xrt/lib/xleaf/ddr_calibration.c  | 210 ++++++++++++++++++
 2 files changed, 238 insertions(+)
 create mode 100644 drivers/fpga/xrt/include/xleaf/ddr_calibration.h
 create mode 100644 drivers/fpga/xrt/lib/xleaf/ddr_calibration.c

diff --git a/drivers/fpga/xrt/include/xleaf/ddr_calibration.h b/drivers/fpga/xrt/include/xleaf/ddr_calibration.h
new file mode 100644
index 000000000000..878740c26ca2
--- /dev/null
+++ b/drivers/fpga/xrt/include/xleaf/ddr_calibration.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2021 Xilinx, Inc.
+ *
+ * Authors:
+ *	Cheng Zhen <maxz@xilinx.com>
+ */
+
+#ifndef _XRT_DDR_CALIBRATION_H_
+#define _XRT_DDR_CALIBRATION_H_
+
+#include "xleaf.h"
+#include <linux/xrt/xclbin.h>
+
+/*
+ * Memory calibration driver leaf calls.
+ */
+enum xrt_calib_results {
+	XRT_CALIB_UNKNOWN = 0,
+	XRT_CALIB_SUCCEEDED,
+	XRT_CALIB_FAILED,
+};
+
+enum xrt_calib_leaf_cmd {
+	XRT_CALIB_RESULT = XRT_XLEAF_CUSTOM_BASE, /* See comments in xleaf.h */
+};
+
+#endif	/* _XRT_DDR_CALIBRATION_H_ */
diff --git a/drivers/fpga/xrt/lib/xleaf/ddr_calibration.c b/drivers/fpga/xrt/lib/xleaf/ddr_calibration.c
new file mode 100644
index 000000000000..36a0937c9195
--- /dev/null
+++ b/drivers/fpga/xrt/lib/xleaf/ddr_calibration.c
@@ -0,0 +1,210 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx Alveo FPGA memory calibration driver
+ *
+ * Copyright (C) 2020-2021 Xilinx, Inc.
+ *
+ * memory calibration
+ *
+ * Authors:
+ *      Lizhi Hou<Lizhi.Hou@xilinx.com>
+ */
+#include <linux/delay.h>
+#include <linux/regmap.h>
+#include "xclbin-helper.h"
+#include "metadata.h"
+#include "xleaf/ddr_calibration.h"
+
+#define XRT_CALIB	"xrt_calib"
+
+#define XRT_CALIB_STATUS_REG		0
+#define XRT_CALIB_READ_RETRIES		20
+#define XRT_CALIB_READ_INTERVAL		500 /* ms */
+
+XRT_DEFINE_REGMAP_CONFIG(calib_regmap_config);
+
+struct calib_cache {
+	struct list_head	link;
+	const char		*ep_name;
+	char			*data;
+	u32			data_size;
+};
+
+struct calib {
+	struct xrt_device	*xdev;
+	struct regmap		*regmap;
+	struct mutex		lock; /* calibration dev lock */
+	struct list_head	cache_list;
+	u32			cache_num;
+	enum xrt_calib_results	result;
+};
+
+static void __calib_cache_clean_nolock(struct calib *calib)
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
+	__calib_cache_clean_nolock(calib);
+	mutex_unlock(&calib->lock);
+}
+
+static int calib_calibration(struct calib *calib)
+{
+	u32 times = XRT_CALIB_READ_RETRIES;
+	u32 status;
+	int ret;
+
+	while (times != 0) {
+		ret = regmap_read(calib->regmap, XRT_CALIB_STATUS_REG, &status);
+		if (ret) {
+			xrt_err(calib->xdev, "failed to read status reg %d", ret);
+			return ret;
+		}
+
+		if (status & BIT(0))
+			break;
+		msleep(XRT_CALIB_READ_INTERVAL);
+		times--;
+	}
+
+	if (!times) {
+		xrt_err(calib->xdev,
+			"MIG calibration timeout after bitstream download");
+		return -ETIMEDOUT;
+	}
+
+	xrt_info(calib->xdev, "took %dms", (XRT_CALIB_READ_RETRIES - times) *
+		 XRT_CALIB_READ_INTERVAL);
+	return 0;
+}
+
+static void xrt_calib_event_cb(struct xrt_device *xdev, void *arg)
+{
+	struct calib *calib = xrt_get_drvdata(xdev);
+	struct xrt_event *evt = (struct xrt_event *)arg;
+	enum xrt_events e = evt->xe_evt;
+	enum xrt_subdev_id id;
+	int ret;
+
+	id = evt->xe_subdev.xevt_subdev_id;
+
+	switch (e) {
+	case XRT_EVENT_POST_CREATION:
+		if (id == XRT_SUBDEV_UCS) {
+			ret = calib_calibration(calib);
+			if (ret)
+				calib->result = XRT_CALIB_FAILED;
+			else
+				calib->result = XRT_CALIB_SUCCEEDED;
+		}
+		break;
+	default:
+		xrt_dbg(xdev, "ignored event %d", e);
+		break;
+	}
+}
+
+static void xrt_calib_remove(struct xrt_device *xdev)
+{
+	struct calib *calib = xrt_get_drvdata(xdev);
+
+	calib_cache_clean(calib);
+}
+
+static int xrt_calib_probe(struct xrt_device *xdev)
+{
+	void __iomem *base = NULL;
+	struct resource *res;
+	struct calib *calib;
+	int err = 0;
+
+	calib = devm_kzalloc(&xdev->dev, sizeof(*calib), GFP_KERNEL);
+	if (!calib)
+		return -ENOMEM;
+
+	calib->xdev = xdev;
+	xrt_set_drvdata(xdev, calib);
+
+	res = xrt_get_resource(xdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		err = -EINVAL;
+		goto failed;
+	}
+
+	base = devm_ioremap_resource(&xdev->dev, res);
+	if (IS_ERR(base)) {
+		err = PTR_ERR(base);
+		goto failed;
+	}
+
+	calib->regmap = devm_regmap_init_mmio(&xdev->dev, base, &calib_regmap_config);
+	if (IS_ERR(calib->regmap)) {
+		xrt_err(xdev, "Map iomem failed");
+		err = PTR_ERR(calib->regmap);
+		goto failed;
+	}
+
+	mutex_init(&calib->lock);
+	INIT_LIST_HEAD(&calib->cache_list);
+
+	return 0;
+
+failed:
+	return err;
+}
+
+static int
+xrt_calib_leaf_call(struct xrt_device *xdev, u32 cmd, void *arg)
+{
+	struct calib *calib = xrt_get_drvdata(xdev);
+	int ret = 0;
+
+	switch (cmd) {
+	case XRT_XLEAF_EVENT:
+		xrt_calib_event_cb(xdev, arg);
+		break;
+	case XRT_CALIB_RESULT: {
+		enum xrt_calib_results *r = (enum xrt_calib_results *)arg;
+		*r = calib->result;
+		break;
+	}
+	default:
+		xrt_err(xdev, "unsupported cmd %d", cmd);
+		ret = -EINVAL;
+	}
+	return ret;
+}
+
+static struct xrt_dev_endpoints xrt_calib_endpoints[] = {
+	{
+		.xse_names = (struct xrt_dev_ep_names[]) {
+			{ .ep_name = XRT_MD_NODE_DDR_CALIB },
+			{ NULL },
+		},
+		.xse_min_ep = 1,
+	},
+	{ 0 },
+};
+
+static struct xrt_driver xrt_calib_driver = {
+	.driver = {
+		.name = XRT_CALIB,
+	},
+	.subdev_id = XRT_SUBDEV_CALIB,
+	.endpoints = xrt_calib_endpoints,
+	.probe = xrt_calib_probe,
+	.remove = xrt_calib_remove,
+	.leaf_call = xrt_calib_leaf_call,
+};
+
+XRT_LEAF_INIT_FINI_FUNC(calib);
-- 
2.27.0


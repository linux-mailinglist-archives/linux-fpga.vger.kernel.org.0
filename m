Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB0A3470F5
	for <lists+linux-fpga@lfdr.de>; Wed, 24 Mar 2021 06:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235295AbhCXFdy (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 24 Mar 2021 01:33:54 -0400
Received: from mail-eopbgr690071.outbound.protection.outlook.com ([40.107.69.71]:36654
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235278AbhCXFd3 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 24 Mar 2021 01:33:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JrhbmkKuAOCgtQ72QixyUSxUnNrvon0+e3RznESVgS3RugJKofTZXm7qR1YUobBhEjDdWyOdDhCE6FtxtHL+VWfiH2DZIfHbq7txIfx/g97B+8vkZ23eQ19ywL14SnXPN9d+SKoGFCtZ2Icmy6pILHn6HLIgbELw+MnIxwLs19hpnZKhjUITQhtpO1uoz/9mj8PuzJIyV3pi87Pew8t5GDj3ZJCpG8psmRzF9OSNSJGfHNTttlHlea7aJqODsZos3fG5PW7oN569fvI88gJhtHreDqwKLXsxNfK6sYfqPaO2ilrI2DKloZbfsyaQoQbFY/0MO+DAQPK2fmbhT3HkxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TcgMHpgYqNrYHHDKDvNYH/JZKzTNQl6apRp93jgHv5k=;
 b=fWUHdKfiXWbqS3Pyj9lxNhECjZ9d53NuB4EtENIOKQyU2YR2owNIylzdb8JOIfjEXbtllySfRBLi043vmlnNBHeIH2SxJukT20Ajlz0F1V072kEXUZQmNw/NFx97yomPKRTWdn3E6wErxEsNTAgA1RNT/s4/BndUaLpn1tIiTzfGfUk3Vy1LEosCQbmz9bKULIe01Zez63sPruQ9p7PsUzvm46FVTX8ihMTzXe26IPzcQzq3mweSjvlzNwWdXwv8/Kb2UXzAOavl3VLr9nIq3dGGcJ1DvUevAzZWyYGO1rdawAWdwfONYgAC3XREvRe7uTf5gxA0t8MWDh8zqb0Kfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TcgMHpgYqNrYHHDKDvNYH/JZKzTNQl6apRp93jgHv5k=;
 b=EMkYtQTe1ufbrMiYmNtf2T9sd/EiBp9jpIcEhMeT6QgeBdx8ARdKs0s9GhcojcviF1hykBlgyvB0EZZBs5exD24vChZnKlGVZmi/4A1RKMplFQo6MIWFUhJhUJaLmy1U6r8Rv0++GtHObmvPJo4kS85oJiX3aN/PGiZR1cLyNCI=
Received: from SN6PR16CA0037.namprd16.prod.outlook.com (2603:10b6:805:ca::14)
 by CH2PR02MB6214.namprd02.prod.outlook.com (2603:10b6:610:9::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Wed, 24 Mar
 2021 05:33:26 +0000
Received: from SN1NAM02FT017.eop-nam02.prod.protection.outlook.com
 (2603:10b6:805:ca:cafe::81) by SN6PR16CA0037.outlook.office365.com
 (2603:10b6:805:ca::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24 via Frontend
 Transport; Wed, 24 Mar 2021 05:33:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT017.mail.protection.outlook.com (10.152.72.115) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3955.24 via Frontend Transport; Wed, 24 Mar 2021 05:33:26 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 23 Mar 2021 22:33:10 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2106.2 via Frontend Transport; Tue, 23 Mar 2021 22:33:10 -0700
Envelope-to: mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.72.212] (port=51028 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1lOw8k-0004SU-16; Tue, 23 Mar 2021 22:33:10 -0700
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id D9A6A60011F; Tue, 23 Mar 2021 22:29:55 -0700 (PDT)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>, Max Zhen <max.zhen@xilinx.com>
Subject: [PATCH V4 XRT Alveo 04/20] fpga: xrt: xrt-lib platform driver manager
Date:   Tue, 23 Mar 2021 22:29:31 -0700
Message-ID: <20210324052947.27889-5-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210324052947.27889-1-lizhi.hou@xilinx.com>
References: <20210324052947.27889-1-lizhi.hou@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf626620-ac9e-405f-f215-08d8ee865959
X-MS-TrafficTypeDiagnostic: CH2PR02MB6214:
X-Microsoft-Antispam-PRVS: <CH2PR02MB6214E093E90AC96E14259C1EA1639@CH2PR02MB6214.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MNeIAPBBJ+qrXa9X1omwA+Vqu8+8YzfrO6uXDPK/nV3HV/MxwIOzvm4QOq5LO6lJkOpXl4mbUorSGog5DeEQYAKp5dwfrq7JXEoPzMs9NOvzf5H5fsoSCQYKKYjMuVZT5ZV155wsNgg7G2ZnaJgjl/dPrxMopnpIStgCS++a1CmsI2GTXyyfG2AVnzdOluWMmdaH8SjN2Std6fXZssouwqtaCj4DOmXnglaAqL4FWDuJMk3Pa8/f+n5mDj/F0ITY7c78jDuSx6W24X0iVJExCLybOpM34o0qsdolMjs2ceKBUVPN9NH1ghqBXZRhrrBq4pZ5fb4Rq6rFOEUvoYwrrtis904tLoeW8zDCXK4khfyR5gZNBHUXgkbCaeabhRQPWjcdrf+svNaGa3k3jAJIPxpOY7MU9RxYd/Hoyl01jCDq0SBXEWRFj80/ADeWqH+7mP3wsN6dVbcAGYvsDM+Jt8g/RysACpNl//DRONonYPILShPFQYEn8PBHX/ag2BssEOhhvlsh6GgtHGbNur3WGsWSpL0xTe07GXrKmtlJsL7CG1hzXNvPof9KG64DBdmbMUc9gIvZwpto14jUa7O/M0qM4nid+t0Cq5ciGJcH4R/EJHaNrbxcXd7Yvmz3M6PgJKwkhuj1P03vCBWTgFOQmnW+fguI3oUE10KVWFh+kik=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(39850400004)(136003)(36840700001)(46966006)(6916009)(42186006)(426003)(83380400001)(336012)(7636003)(316002)(107886003)(8676002)(5660300002)(30864003)(2616005)(6266002)(36906005)(1076003)(54906003)(70586007)(82740400003)(36860700001)(70206006)(186003)(2906002)(6666004)(356005)(82310400003)(26005)(47076005)(36756003)(44832011)(478600001)(8936002)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2021 05:33:26.4216
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf626620-ac9e-405f-f215-08d8ee865959
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT017.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6214
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

xrt-lib kernel module infrastructure code to register and manage all
leaf driver modules.

Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
Signed-off-by: Max Zhen <max.zhen@xilinx.com>
Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
---
 drivers/fpga/xrt/include/subdev_id.h |  38 ++++
 drivers/fpga/xrt/include/xleaf.h     | 264 +++++++++++++++++++++++++
 drivers/fpga/xrt/lib/lib-drv.c       | 277 +++++++++++++++++++++++++++
 drivers/fpga/xrt/lib/lib-drv.h       |  17 ++
 4 files changed, 596 insertions(+)
 create mode 100644 drivers/fpga/xrt/include/subdev_id.h
 create mode 100644 drivers/fpga/xrt/include/xleaf.h
 create mode 100644 drivers/fpga/xrt/lib/lib-drv.c
 create mode 100644 drivers/fpga/xrt/lib/lib-drv.h

diff --git a/drivers/fpga/xrt/include/subdev_id.h b/drivers/fpga/xrt/include/subdev_id.h
new file mode 100644
index 000000000000..42fbd6f5e80a
--- /dev/null
+++ b/drivers/fpga/xrt/include/subdev_id.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2021 Xilinx, Inc.
+ *
+ * Authors:
+ *	Cheng Zhen <maxz@xilinx.com>
+ */
+
+#ifndef _XRT_SUBDEV_ID_H_
+#define _XRT_SUBDEV_ID_H_
+
+/*
+ * Every subdev driver has an ID for others to refer to it. There can be multiple number of
+ * instances of a subdev driver. A <subdev_id, subdev_instance> tuple is a unique identification
+ * of a specific instance of a subdev driver.
+ */
+enum xrt_subdev_id {
+	XRT_SUBDEV_GRP = 0,
+	XRT_SUBDEV_VSEC = 1,
+	XRT_SUBDEV_VSEC_GOLDEN = 2,
+	XRT_SUBDEV_DEVCTL = 3,
+	XRT_SUBDEV_AXIGATE = 4,
+	XRT_SUBDEV_ICAP = 5,
+	XRT_SUBDEV_TEST = 6,
+	XRT_SUBDEV_MGMT_MAIN = 7,
+	XRT_SUBDEV_QSPI = 8,
+	XRT_SUBDEV_MAILBOX = 9,
+	XRT_SUBDEV_CMC = 10,
+	XRT_SUBDEV_CALIB = 11,
+	XRT_SUBDEV_CLKFREQ = 12,
+	XRT_SUBDEV_CLOCK = 13,
+	XRT_SUBDEV_SRSR = 14,
+	XRT_SUBDEV_UCS = 15,
+	XRT_SUBDEV_NUM = 16, /* Total number of subdevs. */
+	XRT_ROOT = -1, /* Special ID for root driver. */
+};
+
+#endif	/* _XRT_SUBDEV_ID_H_ */
diff --git a/drivers/fpga/xrt/include/xleaf.h b/drivers/fpga/xrt/include/xleaf.h
new file mode 100644
index 000000000000..acb500df04b0
--- /dev/null
+++ b/drivers/fpga/xrt/include/xleaf.h
@@ -0,0 +1,264 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2021 Xilinx, Inc.
+ *
+ * Authors:
+ *    Cheng Zhen <maxz@xilinx.com>
+ *    Sonal Santan <sonal.santan@xilinx.com>
+ */
+
+#ifndef _XRT_XLEAF_H_
+#define _XRT_XLEAF_H_
+
+#include <linux/platform_device.h>
+#include <linux/fs.h>
+#include <linux/cdev.h>
+#include "subdev_id.h"
+#include "xroot.h"
+#include "events.h"
+
+/* All subdev drivers should use below common routines to print out msg. */
+#define DEV(pdev)	(&(pdev)->dev)
+#define DEV_PDATA(pdev)					\
+	((struct xrt_subdev_platdata *)dev_get_platdata(DEV(pdev)))
+#define DEV_DRVDATA(pdev)				\
+	((struct xrt_subdev_drvdata *)			\
+	platform_get_device_id(pdev)->driver_data)
+#define FMT_PRT(prt_fn, pdev, fmt, args...)		\
+	({typeof(pdev) (_pdev) = (pdev);		\
+	prt_fn(DEV(_pdev), "%s %s: " fmt,		\
+	DEV_PDATA(_pdev)->xsp_root_name, __func__, ##args); })
+#define xrt_err(pdev, fmt, args...) FMT_PRT(dev_err, pdev, fmt, ##args)
+#define xrt_warn(pdev, fmt, args...) FMT_PRT(dev_warn, pdev, fmt, ##args)
+#define xrt_info(pdev, fmt, args...) FMT_PRT(dev_info, pdev, fmt, ##args)
+#define xrt_dbg(pdev, fmt, args...) FMT_PRT(dev_dbg, pdev, fmt, ##args)
+
+enum {
+	/* Starting cmd for common leaf cmd implemented by all leaves. */
+	XRT_XLEAF_COMMON_BASE = 0,
+	/* Starting cmd for leaves' specific leaf cmds. */
+	XRT_XLEAF_CUSTOM_BASE = 64,
+};
+
+enum xrt_xleaf_common_leaf_cmd {
+	XRT_XLEAF_EVENT = XRT_XLEAF_COMMON_BASE,
+};
+
+/*
+ * If populated by subdev driver, infra will handle the mechanics of
+ * char device (un)registration.
+ */
+enum xrt_subdev_file_mode {
+	/* Infra create cdev, default file name */
+	XRT_SUBDEV_FILE_DEFAULT = 0,
+	/* Infra create cdev, need to encode inst num in file name */
+	XRT_SUBDEV_FILE_MULTI_INST,
+	/* No auto creation of cdev by infra, leaf handles it by itself */
+	XRT_SUBDEV_FILE_NO_AUTO,
+};
+
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
+	 * Per driver instance callback. The pdev points to the instance.
+	 * If defined, these are called by other leaf drivers.
+	 * Note that root driver may call into xsd_leaf_call of a group driver.
+	 */
+	int (*xsd_leaf_call)(struct platform_device *pdev, u32 cmd, void *arg);
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
+ * Partially initialized by the parent driver, then, passed in as subdev driver's
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
+struct xrt_subdev_platdata {
+	/*
+	 * Per driver instance callback. The pdev points to the instance.
+	 * Should always be defined for subdev driver to get service from root.
+	 */
+	xrt_subdev_root_cb_t xsp_root_cb;
+	void *xsp_root_cb_arg;
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
+	struct mutex xsp_devnode_lock; /* devnode lock */
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
+	bool xsp_dtb_valid;
+	char xsp_dtb[0];
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
+struct subdev_match_arg {
+	enum xrt_subdev_id id;
+	int instance;
+};
+
+bool xleaf_has_endpoint(struct platform_device *pdev, const char *endpoint_name);
+struct platform_device *xleaf_get_leaf(struct platform_device *pdev,
+				       xrt_subdev_match_t cb, void *arg);
+
+static inline bool subdev_match(enum xrt_subdev_id id, struct platform_device *pdev, void *arg)
+{
+	const struct subdev_match_arg *a = (struct subdev_match_arg *)arg;
+	int instance = a->instance;
+
+	if (id != a->id)
+		return false;
+	if (instance != pdev->id && instance != PLATFORM_DEVID_NONE)
+		return false;
+	return true;
+}
+
+static inline bool xrt_subdev_match_epname(enum xrt_subdev_id id,
+					   struct platform_device *pdev, void *arg)
+{
+	return xleaf_has_endpoint(pdev, arg);
+}
+
+static inline struct platform_device *
+xleaf_get_leaf_by_id(struct platform_device *pdev,
+		     enum xrt_subdev_id id, int instance)
+{
+	struct subdev_match_arg arg = { id, instance };
+
+	return xleaf_get_leaf(pdev, subdev_match, &arg);
+}
+
+static inline struct platform_device *
+xleaf_get_leaf_by_epname(struct platform_device *pdev, const char *name)
+{
+	return xleaf_get_leaf(pdev, xrt_subdev_match_epname, (void *)name);
+}
+
+static inline int xleaf_call(struct platform_device *tgt, u32 cmd, void *arg)
+{
+	struct xrt_subdev_drvdata *drvdata = DEV_DRVDATA(tgt);
+
+	return (*drvdata->xsd_dev_ops.xsd_leaf_call)(tgt, cmd, arg);
+}
+
+int xleaf_broadcast_event(struct platform_device *pdev, enum xrt_events evt, bool async);
+int xleaf_create_group(struct platform_device *pdev, char *dtb);
+int xleaf_destroy_group(struct platform_device *pdev, int instance);
+void xleaf_get_barres(struct platform_device *pdev, struct resource **res, uint bar_idx);
+void xleaf_get_root_id(struct platform_device *pdev, unsigned short *vendor, unsigned short *device,
+		       unsigned short *subvendor, unsigned short *subdevice);
+void xleaf_hot_reset(struct platform_device *pdev);
+int xleaf_put_leaf(struct platform_device *pdev, struct platform_device *leaf);
+struct device *xleaf_register_hwmon(struct platform_device *pdev, const char *name, void *drvdata,
+				    const struct attribute_group **grps);
+void xleaf_unregister_hwmon(struct platform_device *pdev, struct device *hwmon);
+int xleaf_wait_for_group_bringup(struct platform_device *pdev);
+
+/*
+ * Character device helper APIs for use by leaf drivers
+ */
+static inline bool xleaf_devnode_enabled(struct xrt_subdev_drvdata *drvdata)
+{
+	return drvdata && drvdata->xsd_file_ops.xsf_ops.open;
+}
+
+int xleaf_devnode_create(struct platform_device *pdev,
+			 const char *file_name, const char *inst_name);
+int xleaf_devnode_destroy(struct platform_device *pdev);
+
+struct platform_device *xleaf_devnode_open_excl(struct inode *inode);
+struct platform_device *xleaf_devnode_open(struct inode *inode);
+void xleaf_devnode_close(struct inode *inode);
+
+/* Helpers. */
+int xleaf_register_driver(enum xrt_subdev_id id, struct platform_driver *drv,
+			  struct xrt_subdev_endpoints *eps);
+void xleaf_unregister_driver(enum xrt_subdev_id id);
+
+/* Module's init/fini routines for leaf driver in xrt-lib module */
+#define XRT_LEAF_INIT_FINI_FUNC(_id, name)				\
+void name##_leaf_init_fini(bool init)					\
+{									\
+	typeof(_id) id = _id;						\
+	if (init) {							\
+		xleaf_register_driver(id,				\
+				      &xrt_##name##_driver,		\
+				      xrt_##name##_endpoints);		\
+	} else {							\
+		xleaf_unregister_driver(id);				\
+	}								\
+}
+
+void group_leaf_init_fini(bool init);
+void vsec_leaf_init_fini(bool init);
+void devctl_leaf_init_fini(bool init);
+void axigate_leaf_init_fini(bool init);
+void icap_leaf_init_fini(bool init);
+void calib_leaf_init_fini(bool init);
+void clkfreq_leaf_init_fini(bool init);
+void clock_leaf_init_fini(bool init);
+void ucs_leaf_init_fini(bool init);
+
+#endif	/* _XRT_LEAF_H_ */
diff --git a/drivers/fpga/xrt/lib/lib-drv.c b/drivers/fpga/xrt/lib/lib-drv.c
new file mode 100644
index 000000000000..64bb8710be66
--- /dev/null
+++ b/drivers/fpga/xrt/lib/lib-drv.c
@@ -0,0 +1,277 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020-2021 Xilinx, Inc.
+ *
+ * Authors:
+ *	Cheng Zhen <maxz@xilinx.com>
+ */
+
+#include <linux/module.h>
+#include <linux/vmalloc.h>
+#include "xleaf.h"
+#include "xroot.h"
+#include "lib-drv.h"
+
+#define XRT_IPLIB_MODULE_NAME		"xrt-lib"
+#define XRT_IPLIB_MODULE_VERSION	"4.0.0"
+#define XRT_MAX_DEVICE_NODES		128
+#define XRT_DRVNAME(drv)		((drv)->driver.name)
+
+/*
+ * Subdev driver is known by it's ID to others. We map the ID to it's
+ * struct platform_driver, which contains it's binding name and driver/file ops.
+ * We also map it to the endpoint name in DTB as well, if it's different
+ * than the driver's binding name.
+ */
+struct xrt_drv_map {
+	struct list_head list;
+	enum xrt_subdev_id id;
+	struct platform_driver *drv;
+	struct xrt_subdev_endpoints *eps;
+	struct ida ida; /* manage driver instance and char dev minor */
+};
+
+static DEFINE_MUTEX(xrt_lib_lock); /* global lock protecting xrt_drv_maps list */
+static LIST_HEAD(xrt_drv_maps);
+struct class *xrt_class;
+
+static inline struct xrt_subdev_drvdata *
+xrt_drv_map2drvdata(struct xrt_drv_map *map)
+{
+	return (struct xrt_subdev_drvdata *)map->drv->id_table[0].driver_data;
+}
+
+static struct xrt_drv_map *
+__xrt_drv_find_map_by_id(enum xrt_subdev_id id)
+{
+	struct xrt_drv_map *tmap;
+
+	list_for_each_entry(tmap, &xrt_drv_maps, list) {
+		if (tmap->id == id)
+			return tmap;
+	}
+	return NULL;
+}
+
+static struct xrt_drv_map *
+xrt_drv_find_map_by_id(enum xrt_subdev_id id)
+{
+	struct xrt_drv_map *map;
+
+	mutex_lock(&xrt_lib_lock);
+	map = __xrt_drv_find_map_by_id(id);
+	mutex_unlock(&xrt_lib_lock);
+	/*
+	 * map should remain valid even after the lock is dropped since a registered
+	 * driver should only be unregistered when driver module is being unloaded,
+	 * which means that the driver should not be used by then.
+	 */
+	return map;
+}
+
+static int xrt_drv_register_driver(struct xrt_drv_map *map)
+{
+	struct xrt_subdev_drvdata *drvdata;
+	int rc = 0;
+	const char *drvname = XRT_DRVNAME(map->drv);
+
+	rc = platform_driver_register(map->drv);
+	if (rc) {
+		pr_err("register %s platform driver failed\n", drvname);
+		return rc;
+	}
+
+	drvdata = xrt_drv_map2drvdata(map);
+	if (drvdata) {
+		/* Initialize dev_t for char dev node. */
+		if (xleaf_devnode_enabled(drvdata)) {
+			rc = alloc_chrdev_region(&drvdata->xsd_file_ops.xsf_dev_t, 0,
+						 XRT_MAX_DEVICE_NODES, drvname);
+			if (rc) {
+				platform_driver_unregister(map->drv);
+				pr_err("failed to alloc dev minor for %s: %d\n", drvname, rc);
+				return rc;
+			}
+		} else {
+			drvdata->xsd_file_ops.xsf_dev_t = (dev_t)-1;
+		}
+	}
+
+	ida_init(&map->ida);
+
+	pr_info("%s registered successfully\n", drvname);
+
+	return 0;
+}
+
+static void xrt_drv_unregister_driver(struct xrt_drv_map *map)
+{
+	const char *drvname = XRT_DRVNAME(map->drv);
+	struct xrt_subdev_drvdata *drvdata;
+
+	ida_destroy(&map->ida);
+
+	drvdata = xrt_drv_map2drvdata(map);
+	if (drvdata && drvdata->xsd_file_ops.xsf_dev_t != (dev_t)-1) {
+		unregister_chrdev_region(drvdata->xsd_file_ops.xsf_dev_t,
+					 XRT_MAX_DEVICE_NODES);
+	}
+
+	platform_driver_unregister(map->drv);
+
+	pr_info("%s unregistered successfully\n", drvname);
+}
+
+int xleaf_register_driver(enum xrt_subdev_id id,
+			  struct platform_driver *drv,
+			  struct xrt_subdev_endpoints *eps)
+{
+	struct xrt_drv_map *map;
+	int rc;
+
+	mutex_lock(&xrt_lib_lock);
+
+	map = __xrt_drv_find_map_by_id(id);
+	if (map) {
+		mutex_unlock(&xrt_lib_lock);
+		pr_err("Id %d already has a registered driver, 0x%p\n",
+		       id, map->drv);
+		return -EEXIST;
+	}
+
+	map = kzalloc(sizeof(*map), GFP_KERNEL);
+	if (!map) {
+		mutex_unlock(&xrt_lib_lock);
+		return -ENOMEM;
+	}
+	map->id = id;
+	map->drv = drv;
+	map->eps = eps;
+
+	rc = xrt_drv_register_driver(map);
+	if (rc) {
+		kfree(map);
+		mutex_unlock(&xrt_lib_lock);
+		return rc;
+	}
+
+	list_add(&map->list, &xrt_drv_maps);
+
+	mutex_unlock(&xrt_lib_lock);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(xleaf_register_driver);
+
+void xleaf_unregister_driver(enum xrt_subdev_id id)
+{
+	struct xrt_drv_map *map;
+
+	mutex_lock(&xrt_lib_lock);
+
+	map = __xrt_drv_find_map_by_id(id);
+	if (!map) {
+		mutex_unlock(&xrt_lib_lock);
+		pr_err("Id %d has no registered driver\n", id);
+		return;
+	}
+
+	list_del(&map->list);
+
+	mutex_unlock(&xrt_lib_lock);
+
+	xrt_drv_unregister_driver(map);
+	kfree(map);
+}
+EXPORT_SYMBOL_GPL(xleaf_unregister_driver);
+
+const char *xrt_drv_name(enum xrt_subdev_id id)
+{
+	struct xrt_drv_map *map = xrt_drv_find_map_by_id(id);
+
+	if (map)
+		return XRT_DRVNAME(map->drv);
+	return NULL;
+}
+
+int xrt_drv_get_instance(enum xrt_subdev_id id)
+{
+	struct xrt_drv_map *map = xrt_drv_find_map_by_id(id);
+
+	return ida_alloc_range(&map->ida, 0, XRT_MAX_DEVICE_NODES, GFP_KERNEL);
+}
+
+void xrt_drv_put_instance(enum xrt_subdev_id id, int instance)
+{
+	struct xrt_drv_map *map = xrt_drv_find_map_by_id(id);
+
+	ida_free(&map->ida, instance);
+}
+
+struct xrt_subdev_endpoints *xrt_drv_get_endpoints(enum xrt_subdev_id id)
+{
+	struct xrt_drv_map *map = xrt_drv_find_map_by_id(id);
+	struct xrt_subdev_endpoints *eps;
+
+	eps = map ? map->eps : NULL;
+	return eps;
+}
+
+/* Leaf driver's module init/fini callbacks. */
+static void (*leaf_init_fini_cbs[])(bool) = {
+	group_leaf_init_fini,
+	vsec_leaf_init_fini,
+	devctl_leaf_init_fini,
+	axigate_leaf_init_fini,
+	icap_leaf_init_fini,
+	calib_leaf_init_fini,
+	clkfreq_leaf_init_fini,
+	clock_leaf_init_fini,
+	ucs_leaf_init_fini,
+};
+
+static __init int xrt_lib_init(void)
+{
+	int i;
+
+	xrt_class = class_create(THIS_MODULE, XRT_IPLIB_MODULE_NAME);
+	if (IS_ERR(xrt_class))
+		return PTR_ERR(xrt_class);
+
+	for (i = 0; i < ARRAY_SIZE(leaf_init_fini_cbs); i++)
+		leaf_init_fini_cbs[i](true);
+	return 0;
+}
+
+static __exit void xrt_lib_fini(void)
+{
+	struct xrt_drv_map *map;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(leaf_init_fini_cbs); i++)
+		leaf_init_fini_cbs[i](false);
+
+	mutex_lock(&xrt_lib_lock);
+
+	while (!list_empty(&xrt_drv_maps)) {
+		map = list_first_entry_or_null(&xrt_drv_maps, struct xrt_drv_map, list);
+		pr_err("Unloading module with %s still registered\n", XRT_DRVNAME(map->drv));
+		list_del(&map->list);
+		mutex_unlock(&xrt_lib_lock);
+		xrt_drv_unregister_driver(map);
+		kfree(map);
+		mutex_lock(&xrt_lib_lock);
+	}
+
+	mutex_unlock(&xrt_lib_lock);
+
+	class_destroy(xrt_class);
+}
+
+module_init(xrt_lib_init);
+module_exit(xrt_lib_fini);
+
+MODULE_VERSION(XRT_IPLIB_MODULE_VERSION);
+MODULE_AUTHOR("XRT Team <runtime@xilinx.com>");
+MODULE_DESCRIPTION("Xilinx Alveo IP Lib driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/fpga/xrt/lib/lib-drv.h b/drivers/fpga/xrt/lib/lib-drv.h
new file mode 100644
index 000000000000..a94c58149cb4
--- /dev/null
+++ b/drivers/fpga/xrt/lib/lib-drv.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2021 Xilinx, Inc.
+ *
+ * Authors:
+ *	Cheng Zhen <maxz@xilinx.com>
+ */
+
+#ifndef _LIB_DRV_H_
+#define _LIB_DRV_H_
+
+const char *xrt_drv_name(enum xrt_subdev_id id);
+int xrt_drv_get_instance(enum xrt_subdev_id id);
+void xrt_drv_put_instance(enum xrt_subdev_id id, int instance);
+struct xrt_subdev_endpoints *xrt_drv_get_endpoints(enum xrt_subdev_id id);
+
+#endif	/* _LIB_DRV_H_ */
-- 
2.27.0


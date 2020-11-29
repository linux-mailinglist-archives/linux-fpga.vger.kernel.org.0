Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 420D82C76C9
	for <lists+linux-fpga@lfdr.de>; Sun, 29 Nov 2020 01:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbgK2AFA (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 28 Nov 2020 19:05:00 -0500
Received: from mail-mw2nam10on2050.outbound.protection.outlook.com ([40.107.94.50]:37586
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728013AbgK2AFA (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sat, 28 Nov 2020 19:05:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g1PQ8azmcQR3yLEQefyv3Q7jZ5Gyv2Ts56o1FIwPuxpxoKF+4CXIOjEuy6nuO/hzjf1amsNUat16pG/sWUUVKL8hDQQ0p36c7FFS/X9/PfjFKbK5D3KkgNMlwkDz4kpxiON+wQojEn90uVjAVIaWxj1YCV7WqKfP6ftnZCT/JtLSzTBKRrAmEiWU/YjCR10JPYBb05MzzBZIiErVBThInJh+JXcptnqCKjNxaXjQWsPiBWLqJCqa2TTgqb8vQNdwNbTTyyFgVJzNQuIgVEO7bC3fMzTHHXgsCKbhEX4LWk184Or9dX8D+UEZYmDF9gSxBwQwUuMb0bexqFKL+wAZEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m2e8QH4NqujLt7uwI9rUPNO+xUwvslA98NsXpKabagU=;
 b=n4k+YlWD6D5NjayyY26dyGx/yHfM92WLo89kJuvVDiI65Fk4g+VY00PIrjq1+Wyn72ai/0lhCDPgg56Jtd9d6lAe+To/agLlVafvG4z5N9l2aR9pXHT5GLpxfj+yrnUu4Hbzc2oe/IEPjBpqRu1+2uNuQGH25mb+Irs/Y9LJk+zcWm8I91I0gHDjB1WZUIFJqBWte6f8EIik2E8zZwiQXMMWVYOMChPi0ELDxpt54m3FTX2rHYM4rIM58uyPgKqjrxGL4V+U7pAmRO75T1QOxy/974DbCLA11bAwRsin6S4TpqNWpjGUULL/r0SpI0X98XAuaZr6SLqRovARgdtp9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m2e8QH4NqujLt7uwI9rUPNO+xUwvslA98NsXpKabagU=;
 b=kvzNk20LKShdoJqHs4W7VHXa0J2FIaJw37obrQprJ9JCGzhYZTQAJUWQcvSR30/ZejxyJFlZh0olA34ReZ/hJMRFY0zetQvggYk5POg1elNMTW8d+C46nTxcRFMYz14KWsNJcK4rA1UXRnW3C2LYibF1N5ZsGu+qH41MEkEusIM=
Received: from MN2PR15CA0050.namprd15.prod.outlook.com (2603:10b6:208:237::19)
 by SJ0PR02MB7358.namprd02.prod.outlook.com (2603:10b6:a03:2a1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.21; Sun, 29 Nov
 2020 00:02:28 +0000
Received: from BL2NAM02FT018.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:237:cafe::5e) by MN2PR15CA0050.outlook.office365.com
 (2603:10b6:208:237::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend
 Transport; Sun, 29 Nov 2020 00:02:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT018.mail.protection.outlook.com (10.152.77.170) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3611.27 via Frontend Transport; Sun, 29 Nov 2020 00:02:27 +0000
Received: from xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Sat, 28 Nov 2020 16:02:27 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Sat, 28 Nov 2020 16:02:27 -0800
Envelope-to: michal.simek@xilinx.com,
 sonal.santan@xilinx.com,
 lizhih@xilinx.com,
 maxz@xilinx.com,
 stefanos@xilinx.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.72.212] (port=45054 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <sonal.santan@xilinx.com>)
        id 1kjAAc-0000Ht-Ut; Sat, 28 Nov 2020 16:02:26 -0800
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 6354)
        id 2085C600114; Sat, 28 Nov 2020 16:00:45 -0800 (PST)
From:   Sonal Santan <sonal.santan@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Sonal Santan <sonal.santan@xilinx.com>,
        <linux-fpga@vger.kernel.org>, <maxz@xilinx.com>,
        <lizhih@xilinx.com>, <michal.simek@xilinx.com>,
        <stefanos@xilinx.com>, <devicetree@vger.kernel.org>
Subject: [PATCH Xilinx Alveo 4/8] fpga: xrt: core infrastructure for xrt-lib module
Date:   Sat, 28 Nov 2020 16:00:36 -0800
Message-ID: <20201129000040.24777-5-sonals@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201129000040.24777-1-sonals@xilinx.com>
References: <20201129000040.24777-1-sonals@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 83e97607-a158-45b3-98ed-08d893fa0f21
X-MS-TrafficTypeDiagnostic: SJ0PR02MB7358:
X-Microsoft-Antispam-PRVS: <SJ0PR02MB7358BC4C2A4FAD3F3C10C344BBF60@SJ0PR02MB7358.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:172;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KevySMETLfTk2kitgP+L0QzebxqRIdekJfJIRfwjyYfXn/50cTzHP/HB9j/TIJSVHF1gg58AnAf4zDJAuym0eAM99QitgGrr8vfobuRtz8KTYzc4mhCtXUDkJJVFoMojZoSPZXcpo8o+5MjL35AbCdPyhG+lnSdUu6UGv1+BkcVHxUR2vo76CL84drjsr22xgSFTq3DJ8PaqhKtbx95UadFQetSo6KCYe8UJuBCbSk7bNAXzYLK0CySUez0KJ9X+4f9eeS9P7g7K7/P0O1FRKBJ7Ir6ID4YrfnB9pA1weG0iaV3+1QJvQXjfCXEfsmMugNBruUC8zf3ovEgTLf/pXJQy4F0k3z94DA5rHyVwIOdtX06NeBhAMJfOFieACq8tO/rsXQQ86XtS5E+jMn76iQ==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(39850400004)(396003)(136003)(346002)(376002)(46966005)(82740400003)(7636003)(8936002)(8676002)(356005)(44832011)(4326008)(336012)(2906002)(26005)(82310400003)(83380400001)(186003)(2616005)(426003)(42186006)(36906005)(316002)(450100002)(6266002)(47076004)(54906003)(70206006)(70586007)(36756003)(30864003)(1076003)(6916009)(478600001)(5660300002)(6666004)(579004);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2020 00:02:27.6472
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83e97607-a158-45b3-98ed-08d893fa0f21
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT018.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7358
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Sonal Santan <sonal.santan@xilinx.com>

Add xrt-lib kernel module infrastructrure code which defines APIs
for working with device nodes, iteration and lookup of platform
devices, common interfaces for platform devices, plumbing of
function call and ioctls between platform devices and parent
partitions.

Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
---
 drivers/fpga/alveo/lib/xrt-cdev.c   |  234 +++++++
 drivers/fpga/alveo/lib/xrt-main.c   |  275 ++++++++
 drivers/fpga/alveo/lib/xrt-main.h   |   46 ++
 drivers/fpga/alveo/lib/xrt-subdev.c | 1007 +++++++++++++++++++++++++++
 4 files changed, 1562 insertions(+)
 create mode 100644 drivers/fpga/alveo/lib/xrt-cdev.c
 create mode 100644 drivers/fpga/alveo/lib/xrt-main.c
 create mode 100644 drivers/fpga/alveo/lib/xrt-main.h
 create mode 100644 drivers/fpga/alveo/lib/xrt-subdev.c

diff --git a/drivers/fpga/alveo/lib/xrt-cdev.c b/drivers/fpga/alveo/lib/xrt-cdev.c
new file mode 100644
index 000000000000..b7bef9c8e9ce
--- /dev/null
+++ b/drivers/fpga/alveo/lib/xrt-cdev.c
@@ -0,0 +1,234 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx Alveo FPGA device node helper functions.
+ *
+ * Copyright (C) 2020 Xilinx, Inc.
+ *
+ * Authors:
+ *	Cheng Zhen <maxz@xilinx.com>
+ */
+
+#include "xrt-subdev.h"
+
+extern struct class *xrt_class;
+
+#define	XRT_CDEV_DIR		"xfpga"
+#define	INODE2PDATA(inode)	\
+	container_of((inode)->i_cdev, struct xrt_subdev_platdata, xsp_cdev)
+#define	INODE2PDEV(inode)	\
+	to_platform_device(kobj_to_dev((inode)->i_cdev->kobj.parent))
+#define	CDEV_NAME(sysdev)	(strchr((sysdev)->kobj.name, '!') + 1)
+
+/* Allow it to be accessed from cdev. */
+static void xrt_devnode_allowed(struct platform_device *pdev)
+{
+	struct xrt_subdev_platdata *pdata = DEV_PDATA(pdev);
+
+	/* Allow new opens. */
+	mutex_lock(&pdata->xsp_devnode_lock);
+	pdata->xsp_devnode_online = true;
+	mutex_unlock(&pdata->xsp_devnode_lock);
+}
+
+/* Turn off access from cdev and wait for all existing user to go away. */
+static int xrt_devnode_disallowed(struct platform_device *pdev)
+{
+	int ret = 0;
+	struct xrt_subdev_platdata *pdata = DEV_PDATA(pdev);
+
+	mutex_lock(&pdata->xsp_devnode_lock);
+
+	/* Prevent new opens. */
+	pdata->xsp_devnode_online = false;
+	/* Wait for existing user to close. */
+	while (!ret && pdata->xsp_devnode_ref) {
+		int rc;
+
+		mutex_unlock(&pdata->xsp_devnode_lock);
+		rc = wait_for_completion_killable(&pdata->xsp_devnode_comp);
+		mutex_lock(&pdata->xsp_devnode_lock);
+
+		if (rc == -ERESTARTSYS) {
+			/* Restore online state. */
+			pdata->xsp_devnode_online = true;
+			xrt_err(pdev, "%s is in use, ref=%d",
+				CDEV_NAME(pdata->xsp_sysdev),
+				pdata->xsp_devnode_ref);
+			ret = -EBUSY;
+		}
+	}
+
+	mutex_unlock(&pdata->xsp_devnode_lock);
+
+	return ret;
+}
+
+static struct platform_device *
+__xrt_devnode_open(struct inode *inode, bool excl)
+{
+	struct xrt_subdev_platdata *pdata = INODE2PDATA(inode);
+	struct platform_device *pdev = INODE2PDEV(inode);
+	bool opened = false;
+
+	mutex_lock(&pdata->xsp_devnode_lock);
+
+	if (pdata->xsp_devnode_online) {
+		if (excl && pdata->xsp_devnode_ref) {
+			xrt_err(pdev, "%s has already been opened exclusively",
+				CDEV_NAME(pdata->xsp_sysdev));
+		} else if (!excl && pdata->xsp_devnode_excl) {
+			xrt_err(pdev, "%s has been opened exclusively",
+				CDEV_NAME(pdata->xsp_sysdev));
+		} else {
+			pdata->xsp_devnode_ref++;
+			pdata->xsp_devnode_excl = excl;
+			opened = true;
+			xrt_info(pdev, "opened %s, ref=%d",
+				CDEV_NAME(pdata->xsp_sysdev),
+				pdata->xsp_devnode_ref);
+		}
+	} else {
+		xrt_err(pdev, "%s is offline", CDEV_NAME(pdata->xsp_sysdev));
+	}
+
+	mutex_unlock(&pdata->xsp_devnode_lock);
+
+	return opened ? pdev : NULL;
+}
+
+struct platform_device *
+xrt_devnode_open_excl(struct inode *inode)
+{
+	return __xrt_devnode_open(inode, true);
+}
+
+struct platform_device *
+xrt_devnode_open(struct inode *inode)
+{
+	return __xrt_devnode_open(inode, false);
+}
+EXPORT_SYMBOL_GPL(xrt_devnode_open);
+
+void xrt_devnode_close(struct inode *inode)
+{
+	struct xrt_subdev_platdata *pdata = INODE2PDATA(inode);
+	struct platform_device *pdev = INODE2PDEV(inode);
+	bool notify = false;
+
+	mutex_lock(&pdata->xsp_devnode_lock);
+
+	pdata->xsp_devnode_ref--;
+	if (pdata->xsp_devnode_ref == 0) {
+		pdata->xsp_devnode_excl = false;
+		notify = true;
+	}
+	if (notify) {
+		xrt_info(pdev, "closed %s, ref=%d",
+			CDEV_NAME(pdata->xsp_sysdev), pdata->xsp_devnode_ref);
+	} else {
+		xrt_info(pdev, "closed %s, notifying waiter",
+			CDEV_NAME(pdata->xsp_sysdev));
+	}
+
+	mutex_unlock(&pdata->xsp_devnode_lock);
+
+	if (notify)
+		complete(&pdata->xsp_devnode_comp);
+}
+EXPORT_SYMBOL_GPL(xrt_devnode_close);
+
+static inline enum xrt_subdev_file_mode
+devnode_mode(struct xrt_subdev_drvdata *drvdata)
+{
+	return drvdata->xsd_file_ops.xsf_mode;
+}
+
+int xrt_devnode_create(struct platform_device *pdev, const char *file_name,
+	const char *inst_name)
+{
+	struct xrt_subdev_drvdata *drvdata = DEV_DRVDATA(pdev);
+	struct xrt_subdev_file_ops *fops = &drvdata->xsd_file_ops;
+	struct xrt_subdev_platdata *pdata = DEV_PDATA(pdev);
+	struct cdev *cdevp;
+	struct device *sysdev;
+	int ret = 0;
+	char fname[256];
+
+	BUG_ON(fops->xsf_dev_t == (dev_t)-1);
+
+	mutex_init(&pdata->xsp_devnode_lock);
+	init_completion(&pdata->xsp_devnode_comp);
+
+	cdevp = &DEV_PDATA(pdev)->xsp_cdev;
+	cdev_init(cdevp, &fops->xsf_ops);
+	cdevp->owner = fops->xsf_ops.owner;
+	cdevp->dev = MKDEV(MAJOR(fops->xsf_dev_t), pdev->id);
+
+	/*
+	 * Set pdev as parent of cdev so that when pdev (and its platform
+	 * data) will not be freed when cdev is not freed.
+	 */
+	cdev_set_parent(cdevp, &DEV(pdev)->kobj);
+
+	ret = cdev_add(cdevp, cdevp->dev, 1);
+	if (ret) {
+		xrt_err(pdev, "failed to add cdev: %d", ret);
+		goto failed;
+	}
+	if (!file_name)
+		file_name = pdev->name;
+	if (!inst_name) {
+		if (devnode_mode(drvdata) == XRT_SUBDEV_FILE_MULTI_INST) {
+			snprintf(fname, sizeof(fname), "%s/%s/%s.%u",
+				XRT_CDEV_DIR, DEV_PDATA(pdev)->xsp_root_name,
+				file_name, pdev->id);
+		} else {
+			snprintf(fname, sizeof(fname), "%s/%s/%s",
+				XRT_CDEV_DIR, DEV_PDATA(pdev)->xsp_root_name,
+				file_name);
+		}
+	} else {
+		snprintf(fname, sizeof(fname), "%s/%s/%s.%s", XRT_CDEV_DIR,
+			DEV_PDATA(pdev)->xsp_root_name, file_name, inst_name);
+	}
+	sysdev = device_create(xrt_class, NULL, cdevp->dev, NULL, "%s", fname);
+	if (IS_ERR(sysdev)) {
+		ret = PTR_ERR(sysdev);
+		xrt_err(pdev, "failed to create device node: %d", ret);
+		goto failed;
+	}
+	pdata->xsp_sysdev = sysdev;
+
+	xrt_devnode_allowed(pdev);
+
+	xrt_info(pdev, "created (%d, %d): /dev/%s",
+		MAJOR(cdevp->dev), pdev->id, fname);
+	return 0;
+
+failed:
+	device_destroy(xrt_class, cdevp->dev);
+	cdev_del(cdevp);
+	cdevp->owner = NULL;
+	return ret;
+}
+
+int xrt_devnode_destroy(struct platform_device *pdev)
+{
+	struct xrt_subdev_platdata *pdata = DEV_PDATA(pdev);
+	struct cdev *cdevp = &pdata->xsp_cdev;
+	dev_t dev = cdevp->dev;
+	int rc;
+
+	BUG_ON(!cdevp->owner);
+
+	rc = xrt_devnode_disallowed(pdev);
+	if (rc)
+		return rc;
+
+	xrt_info(pdev, "removed (%d, %d): /dev/%s/%s", MAJOR(dev), MINOR(dev),
+		XRT_CDEV_DIR, CDEV_NAME(pdata->xsp_sysdev));
+	device_destroy(xrt_class, cdevp->dev);
+	pdata->xsp_sysdev = NULL;
+	cdev_del(cdevp);
+	return 0;
+}
diff --git a/drivers/fpga/alveo/lib/xrt-main.c b/drivers/fpga/alveo/lib/xrt-main.c
new file mode 100644
index 000000000000..b962410a628c
--- /dev/null
+++ b/drivers/fpga/alveo/lib/xrt-main.c
@@ -0,0 +1,275 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020 Xilinx, Inc.
+ *
+ * Authors:
+ *	Cheng Zhen <maxz@xilinx.com>
+ */
+
+#include <linux/module.h>
+#include "xrt-subdev.h"
+#include "xrt-main.h"
+
+#define	XRT_IPLIB_MODULE_NAME		"xrt-lib"
+#define	XRT_IPLIB_MODULE_VERSION	"4.0.0"
+#define	XRT_DRVNAME(drv)		((drv)->driver.name)
+#define	XRT_MAX_DEVICE_NODES		128
+
+struct mutex xrt_class_lock;
+struct class *xrt_class;
+
+/*
+ * Subdev driver is known by ID to others. We map the ID to it's
+ * struct platform_driver, which contains it's binding name and driver/file ops.
+ * We also map it to the endpoint name in DTB as well, if it's different
+ * than the driver's binding name.
+ */
+static struct xrt_drv_map {
+	enum xrt_subdev_id id;
+	struct platform_driver *drv;
+	struct xrt_subdev_endpoints *eps;
+	struct ida ida; /* manage driver instance and char dev minor */
+} xrt_drv_maps[] = {
+	{ XRT_SUBDEV_PART, &xrt_partition_driver, },
+	{ XRT_SUBDEV_VSEC, &xrt_vsec_driver, xrt_vsec_endpoints, },
+	{ XRT_SUBDEV_VSEC_GOLDEN, &xrt_vsec_golden_driver, xrt_vsec_golden_endpoints, },
+	{ XRT_SUBDEV_GPIO, &xrt_gpio_driver, xrt_gpio_endpoints,},
+	{ XRT_SUBDEV_AXIGATE, &xrt_axigate_driver, xrt_axigate_endpoints, },
+	{ XRT_SUBDEV_ICAP, &xrt_icap_driver, xrt_icap_endpoints, },
+	{ XRT_SUBDEV_CALIB, &xrt_calib_driver, xrt_calib_endpoints, },
+	{ XRT_SUBDEV_TEST, &xrt_test_driver, xrt_test_endpoints, },
+	{ XRT_SUBDEV_MGMT_MAIN, NULL, },
+	{ XRT_SUBDEV_QSPI, &xrt_qspi_driver, xrt_qspi_endpoints, },
+	{ XRT_SUBDEV_MAILBOX, &xrt_mailbox_driver, xrt_mailbox_endpoints, },
+	{ XRT_SUBDEV_CMC, &xrt_cmc_driver, xrt_cmc_endpoints, },
+	{ XRT_SUBDEV_CLKFREQ, &xrt_clkfreq_driver, xrt_clkfreq_endpoints, },
+	{ XRT_SUBDEV_CLOCK, &xrt_clock_driver, xrt_clock_endpoints, },
+	{ XRT_SUBDEV_UCS, &xrt_ucs_driver, xrt_ucs_endpoints, },
+};
+
+static inline struct xrt_subdev_drvdata *
+xrt_drv_map2drvdata(struct xrt_drv_map *map)
+{
+	return (struct xrt_subdev_drvdata *)map->drv->id_table[0].driver_data;
+}
+
+static struct xrt_drv_map *
+xrt_drv_find_map_by_id(enum xrt_subdev_id id)
+{
+	int i;
+	struct xrt_drv_map *map = NULL;
+
+	for (i = 0; i < ARRAY_SIZE(xrt_drv_maps); i++) {
+		struct xrt_drv_map *tmap = &xrt_drv_maps[i];
+
+		if (tmap->id != id)
+			continue;
+		map = tmap;
+		break;
+	}
+	return map;
+}
+
+static int xrt_drv_register_driver(enum xrt_subdev_id id)
+{
+	struct xrt_drv_map *map = xrt_drv_find_map_by_id(id);
+	struct xrt_subdev_drvdata *drvdata;
+	int rc = 0;
+	const char *drvname;
+
+	BUG_ON(!map);
+
+	if (!map->drv) {
+		pr_info("skip registration of subdev driver for id %d\n", id);
+		return rc;
+	}
+	drvname = XRT_DRVNAME(map->drv);
+
+	rc = platform_driver_register(map->drv);
+	if (rc) {
+		pr_err("register %s subdev driver failed\n", drvname);
+		return rc;
+	}
+
+	drvdata = xrt_drv_map2drvdata(map);
+	if (drvdata && drvdata->xsd_dev_ops.xsd_post_init) {
+		rc = drvdata->xsd_dev_ops.xsd_post_init();
+		if (rc) {
+			platform_driver_unregister(map->drv);
+			pr_err("%s's post-init, ret %d\n", drvname, rc);
+			return rc;
+		}
+	}
+
+	if (drvdata) {
+		/* Initialize dev_t for char dev node. */
+		if (xrt_devnode_enabled(drvdata)) {
+			rc = alloc_chrdev_region(
+				&drvdata->xsd_file_ops.xsf_dev_t, 0,
+				XRT_MAX_DEVICE_NODES, drvname);
+			if (rc) {
+				if (drvdata->xsd_dev_ops.xsd_pre_exit)
+					drvdata->xsd_dev_ops.xsd_pre_exit();
+				platform_driver_unregister(map->drv);
+				pr_err("failed to alloc dev minor for %s: %d\n",
+					drvname, rc);
+				return rc;
+			}
+		} else {
+			drvdata->xsd_file_ops.xsf_dev_t = (dev_t)-1;
+		}
+	}
+
+	ida_init(&map->ida);
+
+	pr_info("registered %s subdev driver\n", drvname);
+	return 0;
+}
+
+static void xrt_drv_unregister_driver(enum xrt_subdev_id id)
+{
+	struct xrt_drv_map *map = xrt_drv_find_map_by_id(id);
+	struct xrt_subdev_drvdata *drvdata;
+	const char *drvname;
+
+	BUG_ON(!map);
+	if (!map->drv) {
+		pr_info("skip unregistration of subdev driver for id %d\n", id);
+		return;
+	}
+
+	drvname = XRT_DRVNAME(map->drv);
+
+	ida_destroy(&map->ida);
+
+	drvdata = xrt_drv_map2drvdata(map);
+	if (drvdata && drvdata->xsd_file_ops.xsf_dev_t != (dev_t)-1) {
+		unregister_chrdev_region(drvdata->xsd_file_ops.xsf_dev_t,
+			XRT_MAX_DEVICE_NODES);
+	}
+
+	if (drvdata && drvdata->xsd_dev_ops.xsd_pre_exit)
+		drvdata->xsd_dev_ops.xsd_pre_exit();
+
+	platform_driver_unregister(map->drv);
+
+	pr_info("unregistered %s subdev driver\n", drvname);
+}
+
+int xrt_subdev_register_external_driver(enum xrt_subdev_id id,
+	struct platform_driver *drv, struct xrt_subdev_endpoints *eps)
+{
+	int i;
+	int result = 0;
+
+	mutex_lock(&xrt_class_lock);
+	for (i = 0; i < ARRAY_SIZE(xrt_drv_maps); i++) {
+		struct xrt_drv_map *map = &xrt_drv_maps[i];
+
+		if (map->id != id)
+			continue;
+		if (map->drv) {
+			result = -EEXIST;
+			pr_err("Id %d already has a registered driver, 0x%p\n",
+				id, map->drv);
+			break;
+		}
+		map->drv = drv;
+		BUG_ON(map->eps);
+		map->eps = eps;
+		xrt_drv_register_driver(id);
+	}
+	mutex_unlock(&xrt_class_lock);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(xrt_subdev_register_external_driver);
+
+void xrt_subdev_unregister_external_driver(enum xrt_subdev_id id)
+{
+	int i;
+
+	mutex_lock(&xrt_class_lock);
+	for (i = 0; i < ARRAY_SIZE(xrt_drv_maps); i++) {
+		struct xrt_drv_map *map = &xrt_drv_maps[i];
+
+		if (map->id != id)
+			continue;
+		xrt_drv_unregister_driver(id);
+		map->drv = NULL;
+		map->eps = NULL;
+		break;
+	}
+	mutex_unlock(&xrt_class_lock);
+}
+EXPORT_SYMBOL_GPL(xrt_subdev_unregister_external_driver);
+
+static __init int xrt_drv_register_drivers(void)
+{
+	int i;
+	int rc = 0;
+
+	mutex_init(&xrt_class_lock);
+	xrt_class = class_create(THIS_MODULE, XRT_IPLIB_MODULE_NAME);
+	if (IS_ERR(xrt_class))
+		return PTR_ERR(xrt_class);
+
+	for (i = 0; i < ARRAY_SIZE(xrt_drv_maps); i++) {
+		rc = xrt_drv_register_driver(xrt_drv_maps[i].id);
+		if (rc)
+			break;
+	}
+	if (!rc)
+		return 0;
+
+	while (i-- > 0)
+		xrt_drv_unregister_driver(xrt_drv_maps[i].id);
+	class_destroy(xrt_class);
+	return rc;
+}
+
+static __exit void xrt_drv_unregister_drivers(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(xrt_drv_maps); i++)
+		xrt_drv_unregister_driver(xrt_drv_maps[i].id);
+	class_destroy(xrt_class);
+}
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
+
+	return map ? map->eps : NULL;
+}
+
+module_init(xrt_drv_register_drivers);
+module_exit(xrt_drv_unregister_drivers);
+
+MODULE_VERSION(XRT_IPLIB_MODULE_VERSION);
+MODULE_AUTHOR("XRT Team <runtime@xilinx.com>");
+MODULE_DESCRIPTION("Xilinx Alveo IP Lib driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/fpga/alveo/lib/xrt-main.h b/drivers/fpga/alveo/lib/xrt-main.h
new file mode 100644
index 000000000000..f46f90d9e882
--- /dev/null
+++ b/drivers/fpga/alveo/lib/xrt-main.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020 Xilinx, Inc.
+ *
+ * Authors:
+ *	Cheng Zhen <maxz@xilinx.com>
+ */
+
+#ifndef	_XRT_MAIN_H_
+#define	_XRT_MAIN_H_
+
+extern struct platform_driver xrt_partition_driver;
+extern struct platform_driver xrt_test_driver;
+extern struct platform_driver xrt_vsec_driver;
+extern struct platform_driver xrt_vsec_golden_driver;
+extern struct platform_driver xrt_axigate_driver;
+extern struct platform_driver xrt_qspi_driver;
+extern struct platform_driver xrt_gpio_driver;
+extern struct platform_driver xrt_mailbox_driver;
+extern struct platform_driver xrt_icap_driver;
+extern struct platform_driver xrt_cmc_driver;
+extern struct platform_driver xrt_clkfreq_driver;
+extern struct platform_driver xrt_clock_driver;
+extern struct platform_driver xrt_ucs_driver;
+extern struct platform_driver xrt_calib_driver;
+
+extern struct xrt_subdev_endpoints xrt_vsec_endpoints[];
+extern struct xrt_subdev_endpoints xrt_vsec_golden_endpoints[];
+extern struct xrt_subdev_endpoints xrt_axigate_endpoints[];
+extern struct xrt_subdev_endpoints xrt_test_endpoints[];
+extern struct xrt_subdev_endpoints xrt_qspi_endpoints[];
+extern struct xrt_subdev_endpoints xrt_gpio_endpoints[];
+extern struct xrt_subdev_endpoints xrt_mailbox_endpoints[];
+extern struct xrt_subdev_endpoints xrt_icap_endpoints[];
+extern struct xrt_subdev_endpoints xrt_cmc_endpoints[];
+extern struct xrt_subdev_endpoints xrt_clkfreq_endpoints[];
+extern struct xrt_subdev_endpoints xrt_clock_endpoints[];
+extern struct xrt_subdev_endpoints xrt_ucs_endpoints[];
+extern struct xrt_subdev_endpoints xrt_calib_endpoints[];
+
+extern const char *xrt_drv_name(enum xrt_subdev_id id);
+extern int xrt_drv_get_instance(enum xrt_subdev_id id);
+extern void xrt_drv_put_instance(enum xrt_subdev_id id, int instance);
+extern struct xrt_subdev_endpoints *xrt_drv_get_endpoints(enum xrt_subdev_id id);
+
+#endif	/* _XRT_MAIN_H_ */
diff --git a/drivers/fpga/alveo/lib/xrt-subdev.c b/drivers/fpga/alveo/lib/xrt-subdev.c
new file mode 100644
index 000000000000..644c4ec19429
--- /dev/null
+++ b/drivers/fpga/alveo/lib/xrt-subdev.c
@@ -0,0 +1,1007 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020 Xilinx, Inc.
+ *
+ * Authors:
+ *	Cheng Zhen <maxz@xilinx.com>
+ */
+
+#include <linux/platform_device.h>
+#include <linux/pci.h>
+#include <linux/vmalloc.h>
+#include "xrt-subdev.h"
+#include "xrt-parent.h"
+#include "xrt-main.h"
+#include "xrt-metadata.h"
+
+#define DEV_IS_PCI(dev) ((dev)->bus == &pci_bus_type)
+static inline struct device *find_root(struct platform_device *pdev)
+{
+	struct device *d = DEV(pdev);
+
+	while (!DEV_IS_PCI(d))
+		d = d->parent;
+	return d;
+}
+
+/*
+ * It represents a holder of a subdev. One holder can repeatedly hold a subdev
+ * as long as there is a unhold corresponding to a hold.
+ */
+struct xrt_subdev_holder {
+	struct list_head xsh_holder_list;
+	struct device *xsh_holder;
+	int xsh_count;
+};
+
+/*
+ * It represents a specific instance of platform driver for a subdev, which
+ * provides services to its clients (another subdev driver or root driver).
+ */
+struct xrt_subdev {
+	struct list_head xs_dev_list;
+	struct list_head xs_holder_list;
+	enum xrt_subdev_id xs_id;		/* type of subdev */
+	struct platform_device *xs_pdev;	/* a particular subdev inst */
+	struct completion xs_holder_comp;
+};
+
+static struct xrt_subdev *xrt_subdev_alloc(void)
+{
+	struct xrt_subdev *sdev = vzalloc(sizeof(struct xrt_subdev));
+
+	if (!sdev)
+		return NULL;
+
+	INIT_LIST_HEAD(&sdev->xs_dev_list);
+	INIT_LIST_HEAD(&sdev->xs_holder_list);
+	init_completion(&sdev->xs_holder_comp);
+	return sdev;
+}
+
+static void xrt_subdev_free(struct xrt_subdev *sdev)
+{
+	vfree(sdev);
+}
+
+/*
+ * Subdev common sysfs nodes.
+ */
+static ssize_t holders_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	ssize_t len;
+	struct platform_device *pdev = to_platform_device(dev);
+	struct xrt_parent_ioctl_get_holders holders = { pdev, buf, 1024 };
+
+	len = xrt_subdev_parent_ioctl(pdev,
+		XRT_PARENT_GET_LEAF_HOLDERS, &holders);
+	if (len >= holders.xpigh_holder_buf_len)
+		return len;
+	buf[len] = '\n';
+	return len + 1;
+}
+static DEVICE_ATTR_RO(holders);
+
+static struct attribute *xrt_subdev_attrs[] = {
+	&dev_attr_holders.attr,
+	NULL,
+};
+
+static ssize_t metadata_output(struct file *filp, struct kobject *kobj,
+	struct bin_attribute *attr, char *buf, loff_t off, size_t count)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct platform_device *pdev = to_platform_device(dev);
+	struct xrt_subdev_platdata *pdata = DEV_PDATA(pdev);
+	unsigned char *blob;
+	long  size;
+	ssize_t ret = 0;
+
+	blob = pdata->xsp_dtb;
+	size = xrt_md_size(dev, blob);
+	if (size <= 0) {
+		ret = -EINVAL;
+		goto failed;
+	}
+
+	if (off >= size)
+		goto failed;
+
+	if (off + count > size)
+		count = size - off;
+	memcpy(buf, blob + off, count);
+
+	ret = count;
+failed:
+	return ret;
+}
+
+static struct bin_attribute meta_data_attr = {
+	.attr = {
+		.name = "metadata",
+		.mode = 0400
+	},
+	.read = metadata_output,
+	.size = 0
+};
+
+static struct bin_attribute  *xrt_subdev_bin_attrs[] = {
+	&meta_data_attr,
+	NULL,
+};
+
+static const struct attribute_group xrt_subdev_attrgroup = {
+	.attrs = xrt_subdev_attrs,
+	.bin_attrs = xrt_subdev_bin_attrs,
+};
+
+static int
+xrt_subdev_getres(struct device *parent, enum xrt_subdev_id id,
+	char *dtb, struct resource **res, int *res_num)
+{
+	struct xrt_subdev_platdata *pdata;
+	struct resource *pci_res = NULL;
+	const u64 *bar_range;
+	const u32 *bar_idx;
+	char *ep_name = NULL, *regmap = NULL;
+	uint bar;
+	int count1 = 0, count2 = 0, ret;
+
+	if (!dtb)
+		return -EINVAL;
+
+	pdata = DEV_PDATA(to_platform_device(parent));
+
+	for (xrt_md_get_next_endpoint(parent, dtb, NULL, NULL,
+		&ep_name, &regmap);
+		ep_name != NULL;
+		xrt_md_get_next_endpoint(parent, dtb, ep_name, regmap,
+		&ep_name, &regmap)) {
+		ret = xrt_md_get_prop(parent, dtb, ep_name, regmap,
+			PROP_IO_OFFSET, (const void **)&bar_range, NULL);
+		if (!ret)
+			count1++;
+	}
+	if (!count1)
+		return 0;
+
+	*res = vzalloc(sizeof(struct resource) * count1);
+
+	for (xrt_md_get_next_endpoint(parent, dtb, NULL, NULL,
+		&ep_name, &regmap);
+		ep_name != NULL;
+		xrt_md_get_next_endpoint(parent, dtb, ep_name, regmap,
+		&ep_name, &regmap)) {
+		ret = xrt_md_get_prop(parent, dtb, ep_name, regmap,
+			PROP_IO_OFFSET, (const void **)&bar_range, NULL);
+		if (ret)
+			continue;
+		xrt_md_get_prop(parent, dtb, ep_name, regmap,
+			PROP_BAR_IDX, (const void **)&bar_idx, NULL);
+		bar = bar_idx ? be32_to_cpu(*bar_idx) : 0;
+		xrt_subdev_get_barres(to_platform_device(parent), &pci_res,
+			bar);
+		(*res)[count2].start = pci_res->start +
+			be64_to_cpu(bar_range[0]);
+		(*res)[count2].end = pci_res->start +
+			be64_to_cpu(bar_range[0]) +
+			be64_to_cpu(bar_range[1]) - 1;
+		(*res)[count2].flags = IORESOURCE_MEM;
+		/* check if there is conflicted resource */
+		ret = request_resource(pci_res, *res + count2);
+		if (ret) {
+			dev_err(parent, "Conflict resource %pR\n",
+				*res + count2);
+			vfree(*res);
+			*res_num = 0;
+			*res = NULL;
+			return ret;
+		}
+		release_resource(*res + count2);
+
+		(*res)[count2].parent = pci_res;
+
+		xrt_md_get_epname_pointer(parent, pdata->xsp_dtb, ep_name,
+			regmap, &(*res)[count2].name);
+
+		count2++;
+	}
+
+	BUG_ON(count1 != count2);
+	*res_num = count2;
+
+	return 0;
+}
+
+static inline enum xrt_subdev_file_mode
+xrt_devnode_mode(struct xrt_subdev_drvdata *drvdata)
+{
+	return drvdata->xsd_file_ops.xsf_mode;
+}
+
+static bool xrt_subdev_cdev_auto_creation(struct platform_device *pdev)
+{
+	struct xrt_subdev_drvdata *drvdata = DEV_DRVDATA(pdev);
+
+	if (!drvdata)
+		return false;
+
+	return xrt_devnode_enabled(drvdata) &&
+		(xrt_devnode_mode(drvdata) == XRT_SUBDEV_FILE_DEFAULT ||
+		(xrt_devnode_mode(drvdata) == XRT_SUBDEV_FILE_MULTI_INST));
+}
+
+static struct xrt_subdev *
+xrt_subdev_create(struct device *parent, enum xrt_subdev_id id,
+	xrt_subdev_parent_cb_t pcb, void *pcb_arg, char *dtb)
+{
+	struct xrt_subdev *sdev = NULL;
+	struct platform_device *pdev = NULL;
+	struct xrt_subdev_platdata *pdata = NULL;
+	long dtb_len = 0;
+	size_t pdata_sz;
+	int inst = PLATFORM_DEVID_NONE;
+	struct resource *res = NULL;
+	int res_num = 0;
+
+	sdev = xrt_subdev_alloc();
+	if (!sdev) {
+		dev_err(parent, "failed to alloc subdev for ID %d", id);
+		goto fail;
+	}
+	sdev->xs_id = id;
+
+	if (dtb) {
+		xrt_md_pack(parent, dtb);
+		dtb_len = xrt_md_size(parent, dtb);
+		if (dtb_len <= 0) {
+			dev_err(parent, "invalid metadata len %ld", dtb_len);
+			goto fail;
+		}
+	}
+	pdata_sz = sizeof(struct xrt_subdev_platdata) + dtb_len - 1;
+
+	/* Prepare platform data passed to subdev. */
+	pdata = vzalloc(pdata_sz);
+	if (!pdata)
+		goto fail;
+
+	pdata->xsp_parent_cb = pcb;
+	pdata->xsp_parent_cb_arg = pcb_arg;
+	(void) memcpy(pdata->xsp_dtb, dtb, dtb_len);
+	if (id == XRT_SUBDEV_PART) {
+		/* Partition can only be created by root driver. */
+		BUG_ON(parent->bus != &pci_bus_type);
+		pdata->xsp_root_name = dev_name(parent);
+	} else {
+		struct platform_device *part = to_platform_device(parent);
+		/* Leaf can only be created by partition driver. */
+		BUG_ON(parent->bus != &platform_bus_type);
+		BUG_ON(strcmp(xrt_drv_name(XRT_SUBDEV_PART),
+			platform_get_device_id(part)->name));
+		pdata->xsp_root_name = DEV_PDATA(part)->xsp_root_name;
+	}
+
+	/* Obtain dev instance number. */
+	inst = xrt_drv_get_instance(id);
+	if (inst < 0) {
+		dev_err(parent, "failed to obtain instance: %d", inst);
+		goto fail;
+	}
+
+	/* Create subdev. */
+	if (id == XRT_SUBDEV_PART) {
+		pdev = platform_device_register_data(parent,
+			xrt_drv_name(XRT_SUBDEV_PART), inst, pdata, pdata_sz);
+	} else {
+		int rc = xrt_subdev_getres(parent, id, dtb, &res, &res_num);
+
+		if (rc) {
+			dev_err(parent, "failed to get resource for %s.%d: %d",
+				xrt_drv_name(id), inst, rc);
+			goto fail;
+		}
+		pdev = platform_device_register_resndata(parent,
+			xrt_drv_name(id), inst, res, res_num, pdata, pdata_sz);
+		vfree(res);
+	}
+	if (IS_ERR(pdev)) {
+		dev_err(parent, "failed to create subdev for %s inst %d: %ld",
+			xrt_drv_name(id), inst, PTR_ERR(pdev));
+		goto fail;
+	}
+	sdev->xs_pdev = pdev;
+
+	if (device_attach(DEV(pdev)) != 1) {
+		xrt_err(pdev, "failed to attach");
+		goto fail;
+	}
+
+	if (sysfs_create_group(&DEV(pdev)->kobj, &xrt_subdev_attrgroup))
+		xrt_err(pdev, "failed to create sysfs group");
+
+	/*
+	 * Create sysfs sym link under root for leaves
+	 * under random partitions for easy access to them.
+	 */
+	if (id != XRT_SUBDEV_PART) {
+		if (sysfs_create_link(&find_root(pdev)->kobj,
+			&DEV(pdev)->kobj, dev_name(DEV(pdev)))) {
+			xrt_err(pdev, "failed to create sysfs link");
+		}
+	}
+
+	/* All done, ready to handle req thru cdev. */
+	if (xrt_subdev_cdev_auto_creation(pdev)) {
+		(void) xrt_devnode_create(pdev,
+			DEV_DRVDATA(pdev)->xsd_file_ops.xsf_dev_name, NULL);
+	}
+
+	vfree(pdata);
+	return sdev;
+
+fail:
+	vfree(pdata);
+	if (sdev && !IS_ERR_OR_NULL(sdev->xs_pdev))
+		platform_device_unregister(sdev->xs_pdev);
+	if (inst >= 0)
+		xrt_drv_put_instance(id, inst);
+	xrt_subdev_free(sdev);
+	return NULL;
+}
+
+static void xrt_subdev_destroy(struct xrt_subdev *sdev)
+{
+	struct platform_device *pdev = sdev->xs_pdev;
+	int inst = pdev->id;
+	struct device *dev = DEV(pdev);
+
+	/* Take down the device node */
+	if (xrt_subdev_cdev_auto_creation(pdev))
+		(void) xrt_devnode_destroy(pdev);
+	if (sdev->xs_id != XRT_SUBDEV_PART)
+		(void) sysfs_remove_link(&find_root(pdev)->kobj, dev_name(dev));
+	(void) sysfs_remove_group(&dev->kobj, &xrt_subdev_attrgroup);
+	platform_device_unregister(pdev);
+	xrt_drv_put_instance(sdev->xs_id, inst);
+	xrt_subdev_free(sdev);
+}
+
+int xrt_subdev_parent_ioctl(struct platform_device *self, u32 cmd, void *arg)
+{
+	struct device *dev = DEV(self);
+	struct xrt_subdev_platdata *pdata = DEV_PDATA(self);
+
+	return (*pdata->xsp_parent_cb)(dev->parent, pdata->xsp_parent_cb_arg,
+		cmd, arg);
+}
+
+int xrt_subdev_ioctl(struct platform_device *tgt, u32 cmd, void *arg)
+{
+	struct xrt_subdev_drvdata *drvdata = DEV_DRVDATA(tgt);
+
+	return (*drvdata->xsd_dev_ops.xsd_ioctl)(tgt, cmd, arg);
+}
+EXPORT_SYMBOL_GPL(xrt_subdev_ioctl);
+
+struct platform_device *
+xrt_subdev_get_leaf(struct platform_device *pdev,
+	xrt_subdev_match_t match_cb, void *match_arg)
+{
+	int rc;
+	struct xrt_parent_ioctl_get_leaf get_leaf = {
+		pdev, match_cb, match_arg, };
+
+	rc = xrt_subdev_parent_ioctl(pdev, XRT_PARENT_GET_LEAF, &get_leaf);
+	if (rc)
+		return NULL;
+	return get_leaf.xpigl_leaf;
+}
+EXPORT_SYMBOL_GPL(xrt_subdev_get_leaf);
+
+struct subdev_match_arg {
+	enum xrt_subdev_id id;
+	int instance;
+};
+
+static bool subdev_match(enum xrt_subdev_id id,
+	struct platform_device *pdev, void *arg)
+{
+	struct subdev_match_arg *a = (struct subdev_match_arg *)arg;
+	return id == a->id &&
+		(pdev->id == a->instance || PLATFORM_DEVID_NONE == a->instance);
+}
+
+struct platform_device *
+xrt_subdev_get_leaf_by_id(struct platform_device *pdev,
+	enum xrt_subdev_id id, int instance)
+{
+	struct subdev_match_arg arg = { id, instance };
+
+	return xrt_subdev_get_leaf(pdev, subdev_match, &arg);
+}
+EXPORT_SYMBOL_GPL(xrt_subdev_get_leaf_by_id);
+
+bool xrt_subdev_has_epname(struct platform_device *pdev, const char *ep_name)
+{
+	struct resource	*res;
+	int		i;
+
+	for (i = 0, res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	    res;
+	    res = platform_get_resource(pdev, IORESOURCE_MEM, ++i)) {
+		if (!strncmp(res->name, ep_name, strlen(res->name) + 1))
+			return true;
+	}
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(xrt_subdev_has_epname);
+
+static bool xrt_subdev_match_epname(enum xrt_subdev_id id,
+	struct platform_device *pdev, void *arg)
+{
+	return xrt_subdev_has_epname(pdev, arg);
+}
+
+struct platform_device *
+xrt_subdev_get_leaf_by_epname(struct platform_device *pdev, const char *name)
+{
+	return xrt_subdev_get_leaf(pdev, xrt_subdev_match_epname, (void *)name);
+}
+EXPORT_SYMBOL_GPL(xrt_subdev_get_leaf_by_epname);
+
+int xrt_subdev_put_leaf(struct platform_device *pdev,
+	struct platform_device *leaf)
+{
+	struct xrt_parent_ioctl_put_leaf put_leaf = { pdev, leaf };
+
+	return xrt_subdev_parent_ioctl(pdev, XRT_PARENT_PUT_LEAF, &put_leaf);
+}
+EXPORT_SYMBOL_GPL(xrt_subdev_put_leaf);
+
+int xrt_subdev_create_partition(struct platform_device *pdev, char *dtb)
+{
+	return xrt_subdev_parent_ioctl(pdev,
+		XRT_PARENT_CREATE_PARTITION, dtb);
+}
+EXPORT_SYMBOL_GPL(xrt_subdev_create_partition);
+
+int xrt_subdev_destroy_partition(struct platform_device *pdev, int instance)
+{
+	return xrt_subdev_parent_ioctl(pdev,
+		XRT_PARENT_REMOVE_PARTITION, (void *)(uintptr_t)instance);
+}
+EXPORT_SYMBOL_GPL(xrt_subdev_destroy_partition);
+
+int xrt_subdev_lookup_partition(struct platform_device *pdev,
+	xrt_subdev_match_t match_cb, void *match_arg)
+{
+	int rc;
+	struct xrt_parent_ioctl_lookup_partition lkp = {
+		pdev, match_cb, match_arg, };
+
+	rc = xrt_subdev_parent_ioctl(pdev, XRT_PARENT_LOOKUP_PARTITION, &lkp);
+	if (rc)
+		return rc;
+	return lkp.xpilp_part_inst;
+}
+EXPORT_SYMBOL_GPL(xrt_subdev_lookup_partition);
+
+int xrt_subdev_wait_for_partition_bringup(struct platform_device *pdev)
+{
+	return xrt_subdev_parent_ioctl(pdev,
+		XRT_PARENT_WAIT_PARTITION_BRINGUP, NULL);
+}
+EXPORT_SYMBOL_GPL(xrt_subdev_wait_for_partition_bringup);
+
+void *xrt_subdev_add_event_cb(struct platform_device *pdev,
+	xrt_subdev_match_t match, void *match_arg, xrt_event_cb_t cb)
+{
+	struct xrt_parent_ioctl_evt_cb c = { pdev, match, match_arg, cb };
+
+	(void) xrt_subdev_parent_ioctl(pdev, XRT_PARENT_ADD_EVENT_CB, &c);
+	return c.xevt_hdl;
+}
+EXPORT_SYMBOL_GPL(xrt_subdev_add_event_cb);
+
+void xrt_subdev_remove_event_cb(struct platform_device *pdev, void *hdl)
+{
+	(void) xrt_subdev_parent_ioctl(pdev, XRT_PARENT_REMOVE_EVENT_CB, hdl);
+}
+EXPORT_SYMBOL_GPL(xrt_subdev_remove_event_cb);
+
+static ssize_t
+xrt_subdev_get_holders(struct xrt_subdev *sdev, char *buf, size_t len)
+{
+	const struct list_head *ptr;
+	struct xrt_subdev_holder *h;
+	ssize_t n = 0;
+
+	list_for_each(ptr, &sdev->xs_holder_list) {
+		h = list_entry(ptr, struct xrt_subdev_holder, xsh_holder_list);
+		n += snprintf(buf + n, len - n, "%s:%d ",
+			dev_name(h->xsh_holder), h->xsh_count);
+		if (n >= len)
+			break;
+	}
+	return n;
+}
+
+void xrt_subdev_pool_init(struct device *dev, struct xrt_subdev_pool *spool)
+{
+	INIT_LIST_HEAD(&spool->xpool_dev_list);
+	spool->xpool_owner = dev;
+	mutex_init(&spool->xpool_lock);
+	spool->xpool_closing = false;
+}
+EXPORT_SYMBOL_GPL(xrt_subdev_pool_init);
+
+static void xrt_subdev_pool_wait_for_holders(struct xrt_subdev_pool *spool,
+	struct xrt_subdev *sdev)
+{
+	const struct list_head *ptr, *next;
+	char holders[128];
+	struct xrt_subdev_holder *holder;
+	struct mutex *lk = &spool->xpool_lock;
+
+	BUG_ON(!mutex_is_locked(lk));
+
+	while (!list_empty(&sdev->xs_holder_list)) {
+		int rc;
+
+		/* It's most likely a bug if we ever enters this loop. */
+		(void) xrt_subdev_get_holders(sdev, holders, sizeof(holders));
+		xrt_err(sdev->xs_pdev, "awaits holders: %s", holders);
+		mutex_unlock(lk);
+		rc = wait_for_completion_killable(&sdev->xs_holder_comp);
+		mutex_lock(lk);
+		if (rc == -ERESTARTSYS) {
+			xrt_err(sdev->xs_pdev,
+				"give up on waiting for holders, clean up now");
+			list_for_each_safe(ptr, next, &sdev->xs_holder_list) {
+				holder = list_entry(ptr,
+					struct xrt_subdev_holder,
+					xsh_holder_list);
+				list_del(&holder->xsh_holder_list);
+				vfree(holder);
+			}
+		}
+	}
+}
+
+int xrt_subdev_pool_fini(struct xrt_subdev_pool *spool)
+{
+	int ret = 0;
+	struct list_head *dl = &spool->xpool_dev_list;
+	struct mutex *lk = &spool->xpool_lock;
+
+	mutex_lock(lk);
+
+	if (spool->xpool_closing) {
+		mutex_unlock(lk);
+		return 0;
+	}
+
+	spool->xpool_closing = true;
+	/* Remove subdev in the reverse order of added. */
+	while (!ret && !list_empty(dl)) {
+		struct xrt_subdev *sdev = list_first_entry(dl,
+			struct xrt_subdev, xs_dev_list);
+		xrt_subdev_pool_wait_for_holders(spool, sdev);
+		list_del(&sdev->xs_dev_list);
+		mutex_unlock(lk);
+		xrt_subdev_destroy(sdev);
+		mutex_lock(lk);
+	}
+
+	mutex_unlock(lk);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(xrt_subdev_pool_fini);
+
+static int xrt_subdev_hold(struct xrt_subdev *sdev, struct device *holder_dev)
+{
+	const struct list_head *ptr;
+	struct list_head *hl = &sdev->xs_holder_list;
+	struct xrt_subdev_holder *holder;
+	bool found = false;
+
+	list_for_each(ptr, hl) {
+		holder = list_entry(ptr, struct xrt_subdev_holder,
+			xsh_holder_list);
+		if (holder->xsh_holder == holder_dev) {
+			holder->xsh_count++;
+			found = true;
+			break;
+		}
+	}
+
+	if (!found) {
+		holder = vzalloc(sizeof(*holder));
+		if (!holder)
+			return -ENOMEM;
+		holder->xsh_holder = holder_dev;
+		holder->xsh_count = 1;
+		list_add_tail(&holder->xsh_holder_list, hl);
+	}
+
+	return holder->xsh_count;
+}
+
+static int
+xrt_subdev_release(struct xrt_subdev *sdev, struct device *holder_dev)
+{
+	const struct list_head *ptr, *next;
+	struct list_head *hl = &sdev->xs_holder_list;
+	struct xrt_subdev_holder *holder;
+	int count;
+	bool found = false;
+
+	list_for_each_safe(ptr, next, hl) {
+		holder = list_entry(ptr, struct xrt_subdev_holder,
+			xsh_holder_list);
+		if (holder->xsh_holder == holder_dev) {
+			found = true;
+			holder->xsh_count--;
+
+			count = holder->xsh_count;
+			if (count == 0) {
+				list_del(&holder->xsh_holder_list);
+				vfree(holder);
+				if (list_empty(hl))
+					complete(&sdev->xs_holder_comp);
+			}
+			break;
+		}
+	}
+	if (!found) {
+		dev_err(holder_dev, "can't release, %s did not hold %s",
+			dev_name(holder_dev),
+			dev_name(DEV(sdev->xs_pdev)));
+	}
+	return found ? count : -EINVAL;
+}
+
+int xrt_subdev_pool_add(struct xrt_subdev_pool *spool, enum xrt_subdev_id id,
+	xrt_subdev_parent_cb_t pcb, void *pcb_arg, char *dtb)
+{
+	struct mutex *lk = &spool->xpool_lock;
+	struct list_head *dl = &spool->xpool_dev_list;
+	struct xrt_subdev *sdev;
+	int ret = 0;
+
+	sdev = xrt_subdev_create(spool->xpool_owner, id, pcb, pcb_arg, dtb);
+	if (sdev) {
+		mutex_lock(lk);
+		if (spool->xpool_closing) {
+			/* No new subdev when pool is going away. */
+			xrt_err(sdev->xs_pdev, "pool is closing");
+			ret = -ENODEV;
+		} else {
+			list_add(&sdev->xs_dev_list, dl);
+		}
+		mutex_unlock(lk);
+		if (ret)
+			xrt_subdev_destroy(sdev);
+	} else {
+		ret = -EINVAL;
+	}
+
+	return ret ? ret : sdev->xs_pdev->id;
+}
+EXPORT_SYMBOL_GPL(xrt_subdev_pool_add);
+
+int xrt_subdev_pool_del(struct xrt_subdev_pool *spool, enum xrt_subdev_id id,
+	int instance)
+{
+	const struct list_head *ptr;
+	struct mutex *lk = &spool->xpool_lock;
+	struct list_head *dl = &spool->xpool_dev_list;
+	struct xrt_subdev *sdev;
+	int ret = -ENOENT;
+
+	mutex_lock(lk);
+	list_for_each(ptr, dl) {
+		sdev = list_entry(ptr, struct xrt_subdev, xs_dev_list);
+		if (sdev->xs_id != id || sdev->xs_pdev->id != instance)
+			continue;
+		xrt_subdev_pool_wait_for_holders(spool, sdev);
+		list_del(&sdev->xs_dev_list);
+		ret = 0;
+		break;
+	}
+	mutex_unlock(lk);
+	if (ret)
+		return ret;
+
+	xrt_subdev_destroy(sdev);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(xrt_subdev_pool_del);
+
+static int xrt_subdev_pool_get_impl(struct xrt_subdev_pool *spool,
+	xrt_subdev_match_t match, void *arg, struct device *holder_dev,
+	struct xrt_subdev **sdevp)
+{
+	const struct list_head *ptr;
+	struct mutex *lk = &spool->xpool_lock;
+	struct list_head *dl = &spool->xpool_dev_list;
+	struct xrt_subdev *sdev = NULL;
+	int ret = -ENOENT;
+
+	mutex_lock(lk);
+
+	if (match == XRT_SUBDEV_MATCH_PREV) {
+		struct platform_device *pdev = (struct platform_device *)arg;
+		struct xrt_subdev *d = NULL;
+
+		if (!pdev) {
+			sdev = list_empty(dl) ? NULL : list_last_entry(dl,
+				struct xrt_subdev, xs_dev_list);
+		} else {
+			list_for_each(ptr, dl) {
+				d = list_entry(ptr, struct xrt_subdev,
+					xs_dev_list);
+				if (d->xs_pdev != pdev)
+					continue;
+				if (!list_is_first(ptr, dl))
+					sdev = list_prev_entry(d, xs_dev_list);
+				break;
+			}
+		}
+	} else if (match == XRT_SUBDEV_MATCH_NEXT) {
+		struct platform_device *pdev = (struct platform_device *)arg;
+		struct xrt_subdev *d = NULL;
+
+		if (!pdev) {
+			sdev = list_first_entry_or_null(dl,
+				struct xrt_subdev, xs_dev_list);
+		} else {
+			list_for_each(ptr, dl) {
+				d = list_entry(ptr, struct xrt_subdev,
+					xs_dev_list);
+				if (d->xs_pdev != pdev)
+					continue;
+				if (!list_is_last(ptr, dl))
+					sdev = list_next_entry(d, xs_dev_list);
+				break;
+			}
+		}
+	} else {
+		list_for_each(ptr, dl) {
+			struct xrt_subdev *d = NULL;
+
+			d = list_entry(ptr, struct xrt_subdev, xs_dev_list);
+			if (d && !match(d->xs_id, d->xs_pdev, arg))
+				continue;
+			sdev = d;
+			break;
+		}
+	}
+
+	if (sdev)
+		ret = xrt_subdev_hold(sdev, holder_dev);
+
+	mutex_unlock(lk);
+
+	if (ret >= 0)
+		*sdevp = sdev;
+	return ret;
+}
+EXPORT_SYMBOL_GPL(xrt_subdev_pool_get);
+
+int xrt_subdev_pool_get(struct xrt_subdev_pool *spool,
+	xrt_subdev_match_t match, void *arg, struct device *holder_dev,
+	struct platform_device **pdevp)
+{
+	int rc;
+	struct xrt_subdev *sdev;
+
+	rc = xrt_subdev_pool_get_impl(spool, match, arg, holder_dev, &sdev);
+	if (rc < 0) {
+		if (rc != -ENOENT)
+			dev_err(holder_dev, "failed to hold device: %d", rc);
+		return rc;
+	}
+
+	if (DEV_IS_PCI(holder_dev)) {
+#ifdef	SUBDEV_DEBUG
+		dev_info(holder_dev, "%s: %s <<==== %s, ref=%d", __func__,
+			dev_name(holder_dev), dev_name(DEV(sdev->xs_pdev)), rc);
+#endif
+	} else {
+		xrt_info(to_platform_device(holder_dev), "%s <<==== %s",
+			dev_name(holder_dev), dev_name(DEV(sdev->xs_pdev)));
+	}
+
+	*pdevp = sdev->xs_pdev;
+	return 0;
+}
+
+static int xrt_subdev_pool_put_impl(struct xrt_subdev_pool *spool,
+	struct platform_device *pdev, struct device *holder_dev)
+{
+	const struct list_head *ptr;
+	struct mutex *lk = &spool->xpool_lock;
+	struct list_head *dl = &spool->xpool_dev_list;
+	struct xrt_subdev *sdev;
+	int ret = -ENOENT;
+
+	mutex_lock(lk);
+	list_for_each(ptr, dl) {
+		sdev = list_entry(ptr, struct xrt_subdev, xs_dev_list);
+		if (sdev->xs_pdev != pdev)
+			continue;
+		ret = xrt_subdev_release(sdev, holder_dev);
+		break;
+	}
+	mutex_unlock(lk);
+
+	if (ret < 0 && ret != -ENOENT)
+		dev_err(holder_dev, "failed to release device: %d", ret);
+	return ret;
+}
+
+int xrt_subdev_pool_put(struct xrt_subdev_pool *spool,
+	struct platform_device *pdev, struct device *holder_dev)
+{
+	int ret = xrt_subdev_pool_put_impl(spool, pdev, holder_dev);
+
+	if (ret < 0)
+		return ret;
+
+	if (DEV_IS_PCI(holder_dev)) {
+#ifdef	SUBDEV_DEBUG
+		dev_info(holder_dev, "%s: %s <<==X== %s, ref=%d", __func__,
+			dev_name(holder_dev), dev_name(DEV(spdev)), ret);
+#endif
+	} else {
+		struct platform_device *d = to_platform_device(holder_dev);
+
+		xrt_info(d, "%s <<==X== %s",
+			dev_name(holder_dev), dev_name(DEV(pdev)));
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(xrt_subdev_pool_put);
+
+int xrt_subdev_pool_event(struct xrt_subdev_pool *spool,
+	struct platform_device *pdev, xrt_subdev_match_t match, void *arg,
+	xrt_event_cb_t xevt_cb, enum xrt_events evt)
+{
+	int rc = 0;
+	struct platform_device *tgt = NULL;
+	struct xrt_subdev *sdev = NULL;
+	struct xrt_event_arg_subdev esd;
+
+	while (!rc && xrt_subdev_pool_get_impl(spool, XRT_SUBDEV_MATCH_NEXT,
+		tgt, DEV(pdev), &sdev) != -ENOENT) {
+		tgt = sdev->xs_pdev;
+		esd.xevt_subdev_id = sdev->xs_id;
+		esd.xevt_subdev_instance = tgt->id;
+		if (match(sdev->xs_id, sdev->xs_pdev, arg))
+			rc = xevt_cb(pdev, evt, &esd);
+		(void) xrt_subdev_pool_put_impl(spool, tgt, DEV(pdev));
+	}
+	return rc;
+}
+
+ssize_t xrt_subdev_pool_get_holders(struct xrt_subdev_pool *spool,
+	struct platform_device *pdev, char *buf, size_t len)
+{
+	const struct list_head *ptr;
+	struct mutex *lk = &spool->xpool_lock;
+	struct list_head *dl = &spool->xpool_dev_list;
+	struct xrt_subdev *sdev;
+	ssize_t ret = 0;
+
+	mutex_lock(lk);
+	list_for_each(ptr, dl) {
+		sdev = list_entry(ptr, struct xrt_subdev, xs_dev_list);
+		if (sdev->xs_pdev != pdev)
+			continue;
+		ret = xrt_subdev_get_holders(sdev, buf, len);
+		break;
+	}
+	mutex_unlock(lk);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(xrt_subdev_pool_get_holders);
+
+int xrt_subdev_broadcast_event_async(struct platform_device *pdev,
+	enum xrt_events evt, xrt_async_broadcast_event_cb_t cb, void *arg)
+{
+	struct xrt_parent_ioctl_async_broadcast_evt e = { pdev, evt, cb, arg };
+
+	return xrt_subdev_parent_ioctl(pdev,
+		XRT_PARENT_ASYNC_BOARDCAST_EVENT, &e);
+}
+EXPORT_SYMBOL_GPL(xrt_subdev_broadcast_event_async);
+
+struct xrt_broadcast_event_arg {
+	struct completion comp;
+	bool success;
+};
+
+static void xrt_broadcast_event_cb(struct platform_device *pdev,
+	enum xrt_events evt, void *arg, bool success)
+{
+	struct xrt_broadcast_event_arg *e =
+		(struct xrt_broadcast_event_arg *)arg;
+
+	e->success = success;
+	complete(&e->comp);
+}
+
+int xrt_subdev_broadcast_event(struct platform_device *pdev,
+	enum xrt_events evt)
+{
+	int ret;
+	struct xrt_broadcast_event_arg e;
+
+	init_completion(&e.comp);
+	e.success = false;
+	ret = xrt_subdev_broadcast_event_async(pdev, evt,
+		xrt_broadcast_event_cb, &e);
+	if (ret == 0)
+		wait_for_completion(&e.comp);
+	return e.success ? 0 : -EINVAL;
+}
+EXPORT_SYMBOL_GPL(xrt_subdev_broadcast_event);
+
+void xrt_subdev_hot_reset(struct platform_device *pdev)
+{
+	(void) xrt_subdev_parent_ioctl(pdev, XRT_PARENT_HOT_RESET, NULL);
+}
+EXPORT_SYMBOL_GPL(xrt_subdev_hot_reset);
+
+void xrt_subdev_get_barres(struct platform_device *pdev,
+	struct resource **res, uint bar_idx)
+{
+	struct xrt_parent_ioctl_get_res arg = { 0 };
+
+	BUG_ON(bar_idx > PCI_STD_RESOURCE_END);
+
+	(void) xrt_subdev_parent_ioctl(pdev, XRT_PARENT_GET_RESOURCE, &arg);
+
+	*res = &arg.xpigr_res[bar_idx];
+}
+
+void xrt_subdev_get_parent_id(struct platform_device *pdev,
+	unsigned short *vendor, unsigned short *device,
+	unsigned short *subvendor, unsigned short *subdevice)
+{
+	struct xrt_parent_ioctl_get_id id = { 0 };
+
+	(void) xrt_subdev_parent_ioctl(pdev, XRT_PARENT_GET_ID, (void *)&id);
+	if (vendor)
+		*vendor = id.xpigi_vendor_id;
+	if (device)
+		*device = id.xpigi_device_id;
+	if (subvendor)
+		*subvendor = id.xpigi_sub_vendor_id;
+	if (subdevice)
+		*subdevice = id.xpigi_sub_device_id;
+}
+
+struct device *xrt_subdev_register_hwmon(struct platform_device *pdev,
+	const char *name, void *drvdata, const struct attribute_group **grps)
+{
+	struct xrt_parent_ioctl_hwmon hm = { true, name, drvdata, grps, };
+
+	(void) xrt_subdev_parent_ioctl(pdev, XRT_PARENT_HWMON, (void *)&hm);
+	return hm.xpih_hwmon_dev;
+}
+
+void xrt_subdev_unregister_hwmon(struct platform_device *pdev,
+	struct device *hwmon)
+{
+	struct xrt_parent_ioctl_hwmon hm = { false, };
+
+	hm.xpih_hwmon_dev = hwmon;
+	(void) xrt_subdev_parent_ioctl(pdev, XRT_PARENT_HWMON, (void *)&hm);
+}
-- 
2.17.1


Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E14CF37B3D7
	for <lists+linux-fpga@lfdr.de>; Wed, 12 May 2021 03:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbhELB7v (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 11 May 2021 21:59:51 -0400
Received: from mail-bn7nam10on2047.outbound.protection.outlook.com ([40.107.92.47]:47935
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230253AbhELB7u (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 11 May 2021 21:59:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CT4zJMZf3niRAQgrluziBsvQ6T65QWHl8x7pJURquOvDfIGM05eg+eIdPeiffXjp8Cr/9VYAC3vYCgtBKQccvwYU+HjmQC48K7Elu6KU55P1rszJdfAqH6GuMbGFgq5cL/rL/TJ/MwXpe/09wXtGA8HOLNeYL2IeT4eUICmjsLxbNmW4wkirqz3JBcEa74LOeBy3WuxIr6jaDB4HWHEsvTtwB9wnTMhpAyIco9y6DfqVOxvyUcPiSlxX8/scY5iIXGkTePlCWmF/0nfUF7jLdLXCPaHzzJUlW44AoF2s7Dq7ECyc6tbhpit2tIh2jm0f9iLH+uc5KZPi1Xx6ebBgHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJGnxQJe6FQRgxaRo8LXtiTIBNZmF318AW7uIhkSTbU=;
 b=oe2/NGQbr1dK+lBR32Sn/lFN+2gK0uYseq7l4k+eiBmZOoVXrJcC1lychs7BnLYYh/lZaVTgPds/zcCP0IsmhxWKVIapEf2DGWjhxeZs6Tv6b2rU0aJnqRcO+EdZi9P1Rkgf3H8QJK9Atu/PHzHwClU8+8jyhkN+RFtfhH46mIIHtrKVDE0XSEqRsTp43cVr3aq1IELtGgus3O/tPAyamefKv7zjnrdnJVahLXfGuDUIV2IShKSe94f85ENj1mQgsSSwpv5jx8OBHLaaISh1RM5cwvE29FrHyAgUeVpGbpCeM9l89MSDbYa4dNxUzTu6EkBRd4EUnacFV+VoNAfDTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJGnxQJe6FQRgxaRo8LXtiTIBNZmF318AW7uIhkSTbU=;
 b=jSKNhlxM3jj+PBm/wRwZT8HP57mEF/woINBn5UU+wNv3mf7FQwrtEo+Ykr6djLu165RiCfhfn2MsmmFLoRVQNiFqqSfXd32+GQUsp/DlAu2Nil66pesA2Ni1dvFvBdwfod81yJrGG7z2FrfGRPPGDs/qgWPxF7D9D/L7kayz7MU=
Received: from BN9PR03CA0069.namprd03.prod.outlook.com (2603:10b6:408:fc::14)
 by DM5PR02MB2875.namprd02.prod.outlook.com (2603:10b6:3:110::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.29; Wed, 12 May
 2021 01:58:41 +0000
Received: from BN1NAM02FT038.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::d6) by BN9PR03CA0069.outlook.office365.com
 (2603:10b6:408:fc::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25 via Frontend
 Transport; Wed, 12 May 2021 01:58:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT038.mail.protection.outlook.com (10.13.2.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4065.21 via Frontend Transport; Wed, 12 May 2021 01:58:41 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 11 May 2021 18:58:31 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Tue, 11 May 2021 18:58:31 -0700
Envelope-to: mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.72.212] (port=35724 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1lge8t-0001ZI-27; Tue, 11 May 2021 18:58:31 -0700
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id 3059060012B; Tue, 11 May 2021 18:53:45 -0700 (PDT)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>, Max Zhen <max.zhen@xilinx.com>
Subject: [PATCH V6 XRT Alveo 06/20] fpga: xrt: char dev node helper functions
Date:   Tue, 11 May 2021 18:53:25 -0700
Message-ID: <20210512015339.5649-7-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210512015339.5649-1-lizhi.hou@xilinx.com>
References: <20210512015339.5649-1-lizhi.hou@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 34545949-54bb-4469-f08c-08d914e97774
X-MS-TrafficTypeDiagnostic: DM5PR02MB2875:
X-Microsoft-Antispam-PRVS: <DM5PR02MB2875C3FCF8EDA8CF985CCD32A1529@DM5PR02MB2875.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:67;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t0B1TOGS1wq4waNh24KTtdsJsMw4bvTa6DaDXsJYbJ+X5rSENGVU3HQ16SXn6C2YXfGT/sKUSElkYpzCWUTzxt1L875NjWbcOpG0BHriCGiFViguGJbW9SR2h3okfGZL2z6+7SFORaLGT+SEPPYAOX706he6sw03zuPTCfzMZKau11+qr9j8V5yk6fd/LkXh0bu/7+FUDGulaBBtTLKXGDyZkhOWRAIFnAFDKN3xjcLCIJXNpO1yqJnLFddCdWwVv1E7AdOpzfaxkSDE78Irv54RHL7iDG2oF1mh8PqNe/oAiaca4C9ABxr3GUESzJaYPAMiAEdZY9S0NCYaOdU8KtdM/DlqffFDqUVlLY51jgLKWHH8w+fvcQ0gV4SHGZmL97BZMOpQ1eI5zihWhk+zYX/o0jdzMkja5AnJph1IAxqWF8XN873S9YkcbpmOscyBeZ4q6Nfrl3gd/c7yP6lBNPLbPbDXbg+kunLOZrz7B8OQk7IrrINAVEYzMOABoPV4FeaUCzHJcZuMizt+oE5syH7QAn6C3JJb4eRVRqJeZaqdoM8a7D8NufV3/6UuS5QEPJ2cR8iHCsQL6oCCKQ6t/lChKo9afwI1zFHQTIqbJhBF4slmf5MwYRrsxMjt/tHBs6pvCqcVh9EchU8DWtSGq4BCXn3d6LoCfR+zwJwUmlU=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(346002)(39850400004)(46966006)(36840700001)(316002)(8936002)(6266002)(5660300002)(42186006)(2906002)(186003)(36906005)(54906003)(107886003)(2616005)(82310400003)(336012)(426003)(6666004)(6916009)(36860700001)(1076003)(44832011)(70586007)(47076005)(7636003)(356005)(70206006)(36756003)(82740400003)(83380400001)(8676002)(4326008)(478600001)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 01:58:41.2234
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34545949-54bb-4469-f08c-08d914e97774
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT038.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB2875
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Helper functions for char device node creation / removal for xrt
drivers. This is part of xrt driver infrastructure.

Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
Signed-off-by: Max Zhen <max.zhen@xilinx.com>
Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
Reviewed-by: Tom Rix <trix@redhat.com>
---
 drivers/fpga/xrt/lib/cdev.c | 209 ++++++++++++++++++++++++++++++++++++
 1 file changed, 209 insertions(+)
 create mode 100644 drivers/fpga/xrt/lib/cdev.c

diff --git a/drivers/fpga/xrt/lib/cdev.c b/drivers/fpga/xrt/lib/cdev.c
new file mode 100644
index 000000000000..3c20adac8c03
--- /dev/null
+++ b/drivers/fpga/xrt/lib/cdev.c
@@ -0,0 +1,209 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx Alveo FPGA device node helper functions.
+ *
+ * Copyright (C) 2020-2021 Xilinx, Inc.
+ *
+ * Authors:
+ *	Cheng Zhen <maxz@xilinx.com>
+ */
+
+#include "xleaf.h"
+#include "lib-drv.h"
+
+#define XRT_CDEV_DIR		"xrt"
+#define INODE2PDATA(inode)	\
+	container_of((inode)->i_cdev, struct xrt_subdev_platdata, xsp_cdev)
+#define INODE2PDEV(inode)	\
+	to_xrt_dev(kobj_to_dev((inode)->i_cdev->kobj.parent))
+#define CDEV_NAME(sysdev)	(strchr((sysdev)->kobj.name, '!') + 1)
+
+/* Allow it to be accessed from cdev. */
+static void xleaf_devnode_allowed(struct xrt_device *xdev)
+{
+	struct xrt_subdev_platdata *pdata = DEV_PDATA(xdev);
+
+	/* Allow new opens. */
+	mutex_lock(&pdata->xsp_devnode_lock);
+	pdata->xsp_devnode_online = true;
+	mutex_unlock(&pdata->xsp_devnode_lock);
+}
+
+/* Turn off access from cdev and wait for all existing user to go away. */
+static void xleaf_devnode_disallowed(struct xrt_device *xdev)
+{
+	struct xrt_subdev_platdata *pdata = DEV_PDATA(xdev);
+
+	mutex_lock(&pdata->xsp_devnode_lock);
+
+	/* Prevent new opens. */
+	pdata->xsp_devnode_online = false;
+	/* Wait for existing user to close. */
+	while (pdata->xsp_devnode_ref) {
+		mutex_unlock(&pdata->xsp_devnode_lock);
+		wait_for_completion(&pdata->xsp_devnode_comp);
+		mutex_lock(&pdata->xsp_devnode_lock);
+	}
+
+	mutex_unlock(&pdata->xsp_devnode_lock);
+}
+
+static struct xrt_device *
+__xleaf_devnode_open(struct inode *inode, bool excl)
+{
+	struct xrt_subdev_platdata *pdata = INODE2PDATA(inode);
+	struct xrt_device *xdev = INODE2PDEV(inode);
+	bool opened = false;
+
+	mutex_lock(&pdata->xsp_devnode_lock);
+
+	if (pdata->xsp_devnode_online) {
+		if (excl && pdata->xsp_devnode_ref) {
+			xrt_err(xdev, "%s has already been opened exclusively",
+				CDEV_NAME(pdata->xsp_sysdev));
+		} else if (!excl && pdata->xsp_devnode_excl) {
+			xrt_err(xdev, "%s has been opened exclusively",
+				CDEV_NAME(pdata->xsp_sysdev));
+		} else {
+			pdata->xsp_devnode_ref++;
+			pdata->xsp_devnode_excl = excl;
+			opened = true;
+			xrt_info(xdev, "opened %s, ref=%d",
+				 CDEV_NAME(pdata->xsp_sysdev),
+				 pdata->xsp_devnode_ref);
+		}
+	} else {
+		xrt_err(xdev, "%s is offline", CDEV_NAME(pdata->xsp_sysdev));
+	}
+
+	mutex_unlock(&pdata->xsp_devnode_lock);
+
+	xdev = opened ? xdev : NULL;
+	return xdev;
+}
+
+struct xrt_device *
+xleaf_devnode_open_excl(struct inode *inode)
+{
+	return __xleaf_devnode_open(inode, true);
+}
+
+struct xrt_device *
+xleaf_devnode_open(struct inode *inode)
+{
+	return __xleaf_devnode_open(inode, false);
+}
+EXPORT_SYMBOL_GPL(xleaf_devnode_open);
+
+void xleaf_devnode_close(struct inode *inode)
+{
+	struct xrt_subdev_platdata *pdata = INODE2PDATA(inode);
+	struct xrt_device *xdev = INODE2PDEV(inode);
+	bool notify = false;
+
+	mutex_lock(&pdata->xsp_devnode_lock);
+
+	WARN_ON(pdata->xsp_devnode_ref == 0);
+	pdata->xsp_devnode_ref--;
+	if (pdata->xsp_devnode_ref == 0) {
+		pdata->xsp_devnode_excl = false;
+		notify = true;
+	}
+	if (notify)
+		xrt_info(xdev, "closed %s", CDEV_NAME(pdata->xsp_sysdev));
+	else
+		xrt_info(xdev, "closed %s, notifying waiter", CDEV_NAME(pdata->xsp_sysdev));
+
+	mutex_unlock(&pdata->xsp_devnode_lock);
+
+	if (notify)
+		complete(&pdata->xsp_devnode_comp);
+}
+EXPORT_SYMBOL_GPL(xleaf_devnode_close);
+
+static inline enum xrt_dev_file_mode
+devnode_mode(struct xrt_device *xdev)
+{
+	return DEV_FILE_OPS(xdev)->xsf_mode;
+}
+
+int xleaf_devnode_create(struct xrt_device *xdev, const char *file_name,
+			 const char *inst_name)
+{
+	struct xrt_subdev_platdata *pdata = DEV_PDATA(xdev);
+	struct xrt_dev_file_ops *fops = DEV_FILE_OPS(xdev);
+	struct cdev *cdevp;
+	struct device *sysdev;
+	int ret = 0;
+	char fname[256];
+
+	mutex_init(&pdata->xsp_devnode_lock);
+	init_completion(&pdata->xsp_devnode_comp);
+
+	cdevp = &DEV_PDATA(xdev)->xsp_cdev;
+	cdev_init(cdevp, &fops->xsf_ops);
+	cdevp->owner = fops->xsf_ops.owner;
+	cdevp->dev = MKDEV(MAJOR(fops->xsf_dev_t), xdev->instance);
+
+	/*
+	 * Set xdev as parent of cdev so that when xdev (and its platform
+	 * data) will not be freed when cdev is not freed.
+	 */
+	cdev_set_parent(cdevp, &DEV(xdev)->kobj);
+
+	ret = cdev_add(cdevp, cdevp->dev, 1);
+	if (ret) {
+		xrt_err(xdev, "failed to add cdev: %d", ret);
+		goto failed;
+	}
+	if (!file_name)
+		file_name = xdev->name;
+	if (!inst_name) {
+		if (devnode_mode(xdev) == XRT_DEV_FILE_MULTI_INST) {
+			snprintf(fname, sizeof(fname), "%s/%s/%s.%u",
+				 XRT_CDEV_DIR, DEV_PDATA(xdev)->xsp_root_name,
+				 file_name, xdev->instance);
+		} else {
+			snprintf(fname, sizeof(fname), "%s/%s/%s",
+				 XRT_CDEV_DIR, DEV_PDATA(xdev)->xsp_root_name,
+				 file_name);
+		}
+	} else {
+		snprintf(fname, sizeof(fname), "%s/%s/%s.%s", XRT_CDEV_DIR,
+			 DEV_PDATA(xdev)->xsp_root_name, file_name, inst_name);
+	}
+	sysdev = device_create(xrt_class, NULL, cdevp->dev, NULL, "%s", fname);
+	if (IS_ERR(sysdev)) {
+		ret = PTR_ERR(sysdev);
+		xrt_err(xdev, "failed to create device node: %d", ret);
+		goto failed_cdev_add;
+	}
+	pdata->xsp_sysdev = sysdev;
+
+	xleaf_devnode_allowed(xdev);
+
+	xrt_info(xdev, "created (%d, %d): /dev/%s",
+		 MAJOR(cdevp->dev), xdev->instance, fname);
+	return 0;
+
+failed_cdev_add:
+	cdev_del(cdevp);
+failed:
+	cdevp->owner = NULL;
+	return ret;
+}
+
+void xleaf_devnode_destroy(struct xrt_device *xdev)
+{
+	struct xrt_subdev_platdata *pdata = DEV_PDATA(xdev);
+	struct cdev *cdevp = &pdata->xsp_cdev;
+	dev_t dev = cdevp->dev;
+
+	xleaf_devnode_disallowed(xdev);
+
+	xrt_info(xdev, "removed (%d, %d): /dev/%s/%s", MAJOR(dev), MINOR(dev),
+		 XRT_CDEV_DIR, CDEV_NAME(pdata->xsp_sysdev));
+	device_destroy(xrt_class, cdevp->dev);
+	pdata->xsp_sysdev = NULL;
+	cdev_del(cdevp);
+}
-- 
2.27.0


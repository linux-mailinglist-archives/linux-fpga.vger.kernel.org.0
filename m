Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1341E37B3DD
	for <lists+linux-fpga@lfdr.de>; Wed, 12 May 2021 03:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbhELCAc (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 11 May 2021 22:00:32 -0400
Received: from mail-dm6nam11on2072.outbound.protection.outlook.com ([40.107.223.72]:24605
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230343AbhELCAb (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 11 May 2021 22:00:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jMQpf4FVWgrtijFiBWHJNkRJjUX09SNwZlzzxAC9YSwe2rTXVApUAIvEJuXIvz0qXlEJrohxz7LNTJ6cm4pUnFX9VrEt/lDX7TRozL1VO0CvR7dvKJwUEaiilhtFISSlXFzlUKRtgeP7sJ56K+CnNxqSizOcJSvPmmOzmMVzFcrxF2yKVXfnatqsqqgfKZGzTbMocV4jMvXb8IKUJypxmlkBnZkQW+LnHfVfKH5ZzSd/MY6HJUqlPtE4r8PCfEW/xPQplMC1CY7cWOgoUPY7HSq20NFzbWhhPDE0RTSHS5vvUzPE5alfqWrLWw1BxfFjfaAN2XubuTWw9qB29z6Ynw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vfroxDJfddZ2euZUjEuBoExeJwVKFEBkQk17BBtPoA0=;
 b=FkwHrGQZiOZTP+I/wcduXmsEMDOj15kmxpXivb55CeSvXJnpGDyoGX+bAjd0bLyuqpzxntngmCQYG2BbQTFEsP314V3whtxXYkkEwY+c7XhAQbwMKZEwKeCndBk1brjt2/OxgESv37l0AlAcBfCANwky1/uvQLeVnRbnfSUy1wdMXFLjy1SlSKShC2lB25WbaKuq7sdNiu7c6i+FORrbz5762GKzNbiHBNvPuXiM5tJzKegYH3Jc38YmFZc2MG1H8F/Y3ZoK2OPKMny1aprqsGeieJIl8ruW+/Dfzu08Lbze6aBDrwJHoDsGPt9JwLg5UQHILvqk5XJVn7D9BvsG1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vfroxDJfddZ2euZUjEuBoExeJwVKFEBkQk17BBtPoA0=;
 b=Trbnkv0eBWHbfQBJJWh5bKUIRQKcF9CgXT5OPFU4Sht0qby77NSArM5OPZz/1Xz23Xa6DZZXdwerkLpSenOXuKFXvMe5rEnWmkuj34FB1YJXCO0nS9QLrMQECL0GOnXEHwnNVkm3zpY5XzIawN+GL/zcthHfg0yq8sHsWq+BucY=
Received: from BN6PR1101CA0023.namprd11.prod.outlook.com
 (2603:10b6:405:4a::33) by DM6PR02MB4714.namprd02.prod.outlook.com
 (2603:10b6:5:1a::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.27; Wed, 12 May
 2021 01:59:22 +0000
Received: from BN1NAM02FT018.eop-nam02.prod.protection.outlook.com
 (2603:10b6:405:4a:cafe::d1) by BN6PR1101CA0023.outlook.office365.com
 (2603:10b6:405:4a::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Wed, 12 May 2021 01:59:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT018.mail.protection.outlook.com (10.13.3.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4065.21 via Frontend Transport; Wed, 12 May 2021 01:59:22 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 11 May 2021 18:59:19 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Tue, 11 May 2021 18:59:19 -0700
Envelope-to: mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.72.212] (port=35732 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1lge9f-0005Yj-8d; Tue, 11 May 2021 18:59:19 -0700
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id 7577E60012C; Tue, 11 May 2021 18:53:45 -0700 (PDT)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>, Max Zhen <max.zhen@xilinx.com>
Subject: [PATCH V6 XRT Alveo 10/20] fpga: xrt: main driver for management function device
Date:   Tue, 11 May 2021 18:53:29 -0700
Message-ID: <20210512015339.5649-11-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210512015339.5649-1-lizhi.hou@xilinx.com>
References: <20210512015339.5649-1-lizhi.hou@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a5a4caf8-af26-4dab-0dd0-08d914e98fdd
X-MS-TrafficTypeDiagnostic: DM6PR02MB4714:
X-Microsoft-Antispam-PRVS: <DM6PR02MB47142C7B3BD5E89565C6D8BDA1529@DM6PR02MB4714.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:538;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3xyUZXmzBaQAhdT681LwemWcApqa+97Pvi43AyZbF0i2CWTtdGNrRzNaK856ofFFlG+huSM10qh4NemDLrIgkx+ICLjjYNuKe53eGzur30O2zFgwIlrJtBeU/xnemgPyG9OaMai91TIO6nKqBE3q+dHYzK4K97jEbtTZSsqWQv4GlYMn2o0z3stN4tja95N1G4ziCFg0hmOQo7o3d3xW5/Jb5CToDukCDNeMjWTopk8MPorvB3aL/THHFymoCY1YS8tpmjKP7yHtHntnt4F2/n/gB0TSUmJWubwhn1RrfnvOYSFjYfZMFlCk78isXyzLdOZTpsA2V8KGcdbXVt0kR6lRZ52N4wzGN9+5C6YwiKsnnah2/fIwpqgO+jgCw+wOOVSRKc3sjbtqiRAlJtEEKPivrWMgaxQQU7W1QEm/kp4MevPxUq+otUb3enUYiEA2AjYd6/ATAQ/BasM5Cn5CveTD5Qo0pXuXf1n7VNx6m0jigeGkO8vX+6EcRIRqlWA/hsd7W9xZYTJKLM3jXqDfz/HosaEK9041ybdOZzgF/3ppY0K19NVwj0ikqzMD69ybbByuFbpB4BKKe1H0LKwL7TWk/q4PI07EYIGJuG7ekuD0dq9oFFy37GdRjMnv1JJi5QLsGP4k2KOkI2KY3dDEQ9o7ga0Qsow93moWhsvvKBU=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(39860400002)(396003)(376002)(136003)(346002)(46966006)(36840700001)(82310400003)(54906003)(7636003)(1076003)(6266002)(8936002)(6916009)(82740400003)(356005)(8676002)(2906002)(83380400001)(47076005)(44832011)(2616005)(426003)(70586007)(42186006)(4326008)(478600001)(5660300002)(336012)(6666004)(36756003)(70206006)(26005)(36860700001)(30864003)(107886003)(316002)(36906005)(186003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 01:59:22.1660
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5a4caf8-af26-4dab-0dd0-08d914e98fdd
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT018.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4714
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

xrt driver that handles IOCTLs, such as hot reset and xclbin download.

Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
Signed-off-by: Max Zhen <max.zhen@xilinx.com>
Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
Reviewed-by: Tom Rix <trix@redhat.com>
---
 drivers/fpga/xrt/include/xmgmt-main.h |  34 ++
 drivers/fpga/xrt/mgmt/xmgmt-main.c    | 662 ++++++++++++++++++++++++++
 drivers/fpga/xrt/mgmt/xmgmt.h         |  33 ++
 include/uapi/linux/xrt/xmgmt-ioctl.h  |  46 ++
 4 files changed, 775 insertions(+)
 create mode 100644 drivers/fpga/xrt/include/xmgmt-main.h
 create mode 100644 drivers/fpga/xrt/mgmt/xmgmt-main.c
 create mode 100644 drivers/fpga/xrt/mgmt/xmgmt.h
 create mode 100644 include/uapi/linux/xrt/xmgmt-ioctl.h

diff --git a/drivers/fpga/xrt/include/xmgmt-main.h b/drivers/fpga/xrt/include/xmgmt-main.h
new file mode 100644
index 000000000000..dce9f0d1a0dc
--- /dev/null
+++ b/drivers/fpga/xrt/include/xmgmt-main.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2021 Xilinx, Inc.
+ *
+ * Authors:
+ *	Cheng Zhen <maxz@xilinx.com>
+ */
+
+#ifndef _XMGMT_MAIN_H_
+#define _XMGMT_MAIN_H_
+
+#include <linux/xrt/xclbin.h>
+#include "xleaf.h"
+
+enum xrt_mgmt_main_leaf_cmd {
+	XRT_MGMT_MAIN_GET_AXLF_SECTION = XRT_XLEAF_CUSTOM_BASE, /* See comments in xleaf.h */
+	XRT_MGMT_MAIN_GET_VBNV,
+};
+
+/* There are three kind of partitions. Each of them is programmed independently. */
+enum provider_kind {
+	XMGMT_BLP, /* Base Logic Partition */
+	XMGMT_PLP, /* Provider Logic Partition */
+	XMGMT_ULP, /* User Logic Partition */
+};
+
+struct xrt_mgmt_main_get_axlf_section {
+	enum provider_kind xmmigas_axlf_kind;
+	enum axlf_section_kind xmmigas_section_kind;
+	void *xmmigas_section;
+	u64 xmmigas_section_size;
+};
+
+#endif	/* _XMGMT_MAIN_H_ */
diff --git a/drivers/fpga/xrt/mgmt/xmgmt-main.c b/drivers/fpga/xrt/mgmt/xmgmt-main.c
new file mode 100644
index 000000000000..ce7c110e999a
--- /dev/null
+++ b/drivers/fpga/xrt/mgmt/xmgmt-main.c
@@ -0,0 +1,662 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx Alveo FPGA MGMT PF entry point driver
+ *
+ * Copyright (C) 2020-2021 Xilinx, Inc.
+ *
+ * Authors:
+ *	Sonal Santan <sonals@xilinx.com>
+ */
+
+#include <linux/firmware.h>
+#include <linux/uaccess.h>
+#include <linux/slab.h>
+#include "xclbin-helper.h"
+#include "metadata.h"
+#include "xleaf.h"
+#include <linux/xrt/xmgmt-ioctl.h>
+#include "xleaf/devctl.h"
+#include "xmgmt-main.h"
+#include "xrt-mgr.h"
+#include "xleaf/icap.h"
+#include "xleaf/axigate.h"
+#include "xmgmt.h"
+
+#define XMGMT_MAIN "xmgmt_main"
+#define XMGMT_SUPP_XCLBIN_MAJOR 2
+
+#define XMGMT_FLAG_FLASH_READY	1
+#define XMGMT_FLAG_DEVCTL_READY	2
+
+#define XMGMT_UUID_STR_LEN	(UUID_SIZE * 2 + 1)
+
+struct xmgmt_main {
+	struct xrt_device *xdev;
+	struct axlf *firmware_blp;
+	struct axlf *firmware_plp;
+	struct axlf *firmware_ulp;
+	u32 flags;
+	struct fpga_manager *fmgr;
+	struct mutex lock; /* busy lock */
+	uuid_t *blp_interface_uuids;
+	u32 blp_interface_uuid_num;
+};
+
+/*
+ * VBNV stands for Vendor, BoardID, Name, Version. It is a string
+ * which describes board and shell.
+ *
+ * Caller is responsible for freeing the returned string.
+ */
+char *xmgmt_get_vbnv(struct xrt_device *xdev)
+{
+	struct xmgmt_main *xmm = xrt_get_drvdata(xdev);
+	const char *vbnv;
+	char *ret;
+	int i;
+
+	if (xmm->firmware_plp)
+		vbnv = xmm->firmware_plp->header.platform_vbnv;
+	else if (xmm->firmware_blp)
+		vbnv = xmm->firmware_blp->header.platform_vbnv;
+	else
+		return NULL;
+
+	ret = kstrdup(vbnv, GFP_KERNEL);
+	if (!ret)
+		return NULL;
+
+	for (i = 0; i < strlen(ret); i++) {
+		if (ret[i] == ':' || ret[i] == '.')
+			ret[i] = '_';
+	}
+	return ret;
+}
+
+static int get_dev_uuid(struct xrt_device *xdev, char *uuidstr, size_t len)
+{
+	struct xrt_devctl_rw devctl_arg = { 0 };
+	struct xrt_device *devctl_leaf;
+	char uuid_buf[UUID_SIZE];
+	uuid_t uuid;
+	int err;
+
+	devctl_leaf = xleaf_get_leaf_by_epname(xdev, XRT_MD_NODE_BLP_ROM);
+	if (!devctl_leaf) {
+		xrt_err(xdev, "can not get %s", XRT_MD_NODE_BLP_ROM);
+		return -EINVAL;
+	}
+
+	devctl_arg.xdr_id = XRT_DEVCTL_ROM_UUID;
+	devctl_arg.xdr_buf = uuid_buf;
+	devctl_arg.xdr_len = sizeof(uuid_buf);
+	devctl_arg.xdr_offset = 0;
+	err = xleaf_call(devctl_leaf, XRT_DEVCTL_READ, &devctl_arg);
+	xleaf_put_leaf(xdev, devctl_leaf);
+	if (err) {
+		xrt_err(xdev, "can not get uuid: %d", err);
+		return err;
+	}
+	import_uuid(&uuid, uuid_buf);
+	xrt_md_trans_uuid2str(&uuid, uuidstr);
+
+	return 0;
+}
+
+int xmgmt_hot_reset(struct xrt_device *xdev)
+{
+	int ret = xleaf_broadcast_event(xdev, XRT_EVENT_PRE_HOT_RESET, false);
+
+	if (ret) {
+		xrt_err(xdev, "offline failed, hot reset is canceled");
+		return ret;
+	}
+
+	xleaf_hot_reset(xdev);
+	xleaf_broadcast_event(xdev, XRT_EVENT_POST_HOT_RESET, false);
+	return 0;
+}
+
+static ssize_t reset_store(struct device *dev, struct device_attribute *da,
+			   const char *buf, size_t count)
+{
+	struct xrt_device *xdev = to_xrt_dev(dev);
+
+	xmgmt_hot_reset(xdev);
+	return count;
+}
+static DEVICE_ATTR_WO(reset);
+
+static ssize_t VBNV_show(struct device *dev, struct device_attribute *da, char *buf)
+{
+	struct xrt_device *xdev = to_xrt_dev(dev);
+	ssize_t ret;
+	char *vbnv;
+
+	vbnv = xmgmt_get_vbnv(xdev);
+	if (!vbnv)
+		return -EINVAL;
+	ret = sprintf(buf, "%s\n", vbnv);
+	kfree(vbnv);
+	return ret;
+}
+static DEVICE_ATTR_RO(VBNV);
+
+/* logic uuid is the uuid uniquely identfy the partition */
+static ssize_t logic_uuids_show(struct device *dev, struct device_attribute *da, char *buf)
+{
+	struct xrt_device *xdev = to_xrt_dev(dev);
+	char uuid[XMGMT_UUID_STR_LEN];
+	ssize_t ret;
+
+	/* Getting UUID pointed to by VSEC, should be the same as logic UUID of BLP. */
+	ret = get_dev_uuid(xdev, uuid, sizeof(uuid));
+	if (ret)
+		return ret;
+	ret = sprintf(buf, "%s\n", uuid);
+	return ret;
+}
+static DEVICE_ATTR_RO(logic_uuids);
+
+static ssize_t interface_uuids_show(struct device *dev, struct device_attribute *da, char *buf)
+{
+	struct xrt_device *xdev = to_xrt_dev(dev);
+	struct xmgmt_main *xmm = xrt_get_drvdata(xdev);
+	ssize_t ret = 0;
+	u32 i;
+
+	for (i = 0; i < xmm->blp_interface_uuid_num; i++) {
+		char uuidstr[XMGMT_UUID_STR_LEN];
+
+		xrt_md_trans_uuid2str(&xmm->blp_interface_uuids[i], uuidstr);
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
+static const struct attribute_group xmgmt_main_attrgroup = {
+	.attrs = xmgmt_main_attrs,
+};
+
+static int load_firmware_from_disk(struct xrt_device *xdev, struct axlf **fw_buf, size_t *len)
+{
+	char uuid[XMGMT_UUID_STR_LEN];
+	const struct firmware *fw;
+	char fw_name[256];
+	int err = 0;
+
+	*len = 0;
+	err = get_dev_uuid(xdev, uuid, sizeof(uuid));
+	if (err)
+		return err;
+
+	snprintf(fw_name, sizeof(fw_name), "xilinx/%s/partition.xsabin", uuid);
+	xrt_info(xdev, "try loading fw: %s", fw_name);
+
+	err = request_firmware(&fw, fw_name, DEV(xdev));
+	if (err)
+		return err;
+
+	*fw_buf = vmalloc(fw->size);
+	if (!*fw_buf) {
+		release_firmware(fw);
+		return -ENOMEM;
+	}
+
+	*len = fw->size;
+	memcpy(*fw_buf, fw->data, fw->size);
+
+	release_firmware(fw);
+	return 0;
+}
+
+static const struct axlf *xmgmt_get_axlf_firmware(struct xmgmt_main *xmm, enum provider_kind kind)
+{
+	switch (kind) {
+	case XMGMT_BLP:
+		return xmm->firmware_blp;
+	case XMGMT_PLP:
+		return xmm->firmware_plp;
+	case XMGMT_ULP:
+		return xmm->firmware_ulp;
+	default:
+		xrt_err(xmm->xdev, "unknown axlf kind: %d", kind);
+		return NULL;
+	}
+}
+
+/* The caller needs to free the returned dtb buffer */
+char *xmgmt_get_dtb(struct xrt_device *xdev, enum provider_kind kind)
+{
+	struct xmgmt_main *xmm = xrt_get_drvdata(xdev);
+	const struct axlf *provider;
+	char *dtb = NULL;
+	int rc;
+
+	provider = xmgmt_get_axlf_firmware(xmm, kind);
+	if (!provider)
+		return dtb;
+
+	rc = xrt_xclbin_get_metadata(DEV(xdev), provider, &dtb);
+	if (rc)
+		xrt_err(xdev, "failed to find dtb: %d", rc);
+	return dtb;
+}
+
+/* The caller needs to free the returned uuid buffer */
+static const char *get_uuid_from_firmware(struct xrt_device *xdev, const struct axlf *xclbin)
+{
+	const void *uuiddup = NULL;
+	const void *uuid = NULL;
+	void *dtb = NULL;
+	int rc;
+
+	rc = xrt_xclbin_get_section(DEV(xdev), xclbin, PARTITION_METADATA, &dtb, NULL);
+	if (rc)
+		return NULL;
+
+	rc = xrt_md_get_prop(DEV(xdev), dtb, NULL, NULL, XRT_MD_PROP_LOGIC_UUID, &uuid, NULL);
+	if (!rc)
+		uuiddup = kstrdup(uuid, GFP_KERNEL);
+	vfree(dtb);
+	return uuiddup;
+}
+
+static bool is_valid_firmware(struct xrt_device *xdev,
+			      const struct axlf *xclbin, size_t fw_len)
+{
+	const char *fw_buf = (const char *)xclbin;
+	size_t axlflen = xclbin->header.length;
+	char dev_uuid[XMGMT_UUID_STR_LEN];
+	const char *fw_uuid;
+	int err;
+
+	err = get_dev_uuid(xdev, dev_uuid, sizeof(dev_uuid));
+	if (err)
+		return false;
+
+	if (memcmp(fw_buf, XCLBIN_VERSION2, sizeof(XCLBIN_VERSION2)) != 0) {
+		xrt_err(xdev, "unknown fw format");
+		return false;
+	}
+
+	if (axlflen > fw_len) {
+		xrt_err(xdev, "truncated fw, length: %zu, expect: %zu", fw_len, axlflen);
+		return false;
+	}
+
+	if (xclbin->header.version_major != XMGMT_SUPP_XCLBIN_MAJOR) {
+		xrt_err(xdev, "firmware is not supported");
+		return false;
+	}
+
+	fw_uuid = get_uuid_from_firmware(xdev, xclbin);
+	if (!fw_uuid || strncmp(fw_uuid, dev_uuid, sizeof(dev_uuid)) != 0) {
+		xrt_err(xdev, "bad fw UUID: %s, expect: %s",
+			fw_uuid ? fw_uuid : "<none>", dev_uuid);
+		kfree(fw_uuid);
+		return false;
+	}
+
+	kfree(fw_uuid);
+	return true;
+}
+
+int xmgmt_get_provider_uuid(struct xrt_device *xdev, enum provider_kind kind, uuid_t *uuid)
+{
+	struct xmgmt_main *xmm = xrt_get_drvdata(xdev);
+	const struct axlf *fwbuf;
+	const char *fw_uuid;
+	int rc = -ENOENT;
+
+	mutex_lock(&xmm->lock);
+
+	fwbuf = xmgmt_get_axlf_firmware(xmm, kind);
+	if (!fwbuf)
+		goto done;
+
+	fw_uuid = get_uuid_from_firmware(xdev, fwbuf);
+	if (!fw_uuid)
+		goto done;
+
+	rc = xrt_md_trans_str2uuid(DEV(xdev), fw_uuid, uuid);
+	kfree(fw_uuid);
+
+done:
+	mutex_unlock(&xmm->lock);
+	return rc;
+}
+
+static int xmgmt_create_blp(struct xmgmt_main *xmm)
+{
+	const struct axlf *provider = xmgmt_get_axlf_firmware(xmm, XMGMT_BLP);
+	struct xrt_device *xdev = xmm->xdev;
+	int rc = 0;
+	char *dtb = NULL;
+
+	dtb = xmgmt_get_dtb(xdev, XMGMT_BLP);
+	if (!dtb) {
+		xrt_err(xdev, "did not get BLP metadata");
+		return -EINVAL;
+	}
+
+	rc = xmgmt_process_xclbin(xmm->xdev, xmm->fmgr, provider, XMGMT_BLP);
+	if (rc) {
+		xrt_err(xdev, "failed to process BLP: %d", rc);
+		goto failed;
+	}
+
+	rc = xleaf_create_group(xdev, dtb);
+	if (rc < 0)
+		xrt_err(xdev, "failed to create BLP group: %d", rc);
+	else
+		rc = 0;
+
+	WARN_ON(xmm->blp_interface_uuids);
+	rc = xrt_md_get_interface_uuids(&xdev->dev, dtb, 0, NULL);
+	if (rc > 0) {
+		xmm->blp_interface_uuid_num = rc;
+		xmm->blp_interface_uuids =
+			kcalloc(xmm->blp_interface_uuid_num, sizeof(uuid_t), GFP_KERNEL);
+		if (!xmm->blp_interface_uuids) {
+			rc = -ENOMEM;
+			goto failed;
+		}
+		xrt_md_get_interface_uuids(&xdev->dev, dtb, xmm->blp_interface_uuid_num,
+					   xmm->blp_interface_uuids);
+	}
+
+failed:
+	vfree(dtb);
+	return rc;
+}
+
+static int xmgmt_load_firmware(struct xmgmt_main *xmm)
+{
+	struct xrt_device *xdev = xmm->xdev;
+	size_t fwlen;
+	int rc;
+
+	rc = load_firmware_from_disk(xdev, &xmm->firmware_blp, &fwlen);
+	if (!rc && is_valid_firmware(xdev, xmm->firmware_blp, fwlen))
+		xmgmt_create_blp(xmm);
+	else
+		xrt_err(xdev, "failed to find firmware, giving up: %d", rc);
+	return rc;
+}
+
+static void xmgmt_main_event_cb(struct xrt_device *xdev, void *arg)
+{
+	struct xmgmt_main *xmm = xrt_get_drvdata(xdev);
+	struct xrt_event *evt = (struct xrt_event *)arg;
+	enum xrt_events e = evt->xe_evt;
+	struct xrt_device *leaf;
+	enum xrt_subdev_id id;
+
+	id = evt->xe_subdev.xevt_subdev_id;
+	switch (e) {
+	case XRT_EVENT_POST_CREATION: {
+		if (id == XRT_SUBDEV_DEVCTL && !(xmm->flags & XMGMT_FLAG_DEVCTL_READY)) {
+			leaf = xleaf_get_leaf_by_epname(xdev, XRT_MD_NODE_BLP_ROM);
+			if (leaf) {
+				xmm->flags |= XMGMT_FLAG_DEVCTL_READY;
+				xleaf_put_leaf(xdev, leaf);
+			}
+		} else if (id == XRT_SUBDEV_QSPI && !(xmm->flags & XMGMT_FLAG_FLASH_READY)) {
+			xmm->flags |= XMGMT_FLAG_FLASH_READY;
+		} else {
+			break;
+		}
+
+		if (xmm->flags & XMGMT_FLAG_DEVCTL_READY)
+			xmgmt_load_firmware(xmm);
+		break;
+	}
+	case XRT_EVENT_PRE_REMOVAL:
+		break;
+	default:
+		xrt_dbg(xdev, "ignored event %d", e);
+		break;
+	}
+}
+
+static int xmgmt_main_probe(struct xrt_device *xdev)
+{
+	struct xmgmt_main *xmm;
+
+	xrt_info(xdev, "probing...");
+
+	xmm = devm_kzalloc(DEV(xdev), sizeof(*xmm), GFP_KERNEL);
+	if (!xmm)
+		return -ENOMEM;
+
+	xmm->xdev = xdev;
+	xmm->fmgr = xmgmt_fmgr_probe(xdev);
+	if (IS_ERR(xmm->fmgr))
+		return PTR_ERR(xmm->fmgr);
+
+	xrt_set_drvdata(xdev, xmm);
+	mutex_init(&xmm->lock);
+
+	/* Ready to handle req thru sysfs nodes. */
+	if (sysfs_create_group(&DEV(xdev)->kobj, &xmgmt_main_attrgroup))
+		xrt_err(xdev, "failed to create sysfs group");
+	return 0;
+}
+
+static void xmgmt_main_remove(struct xrt_device *xdev)
+{
+	struct xmgmt_main *xmm = xrt_get_drvdata(xdev);
+
+	/* By now, group driver should prevent any inter-leaf call. */
+
+	xrt_info(xdev, "leaving...");
+
+	kfree(xmm->blp_interface_uuids);
+	vfree(xmm->firmware_blp);
+	vfree(xmm->firmware_plp);
+	vfree(xmm->firmware_ulp);
+	xmgmt_region_cleanup_all(xdev);
+	xmgmt_fmgr_remove(xmm->fmgr);
+	sysfs_remove_group(&DEV(xdev)->kobj, &xmgmt_main_attrgroup);
+}
+
+static int
+xmgmt_mainleaf_call(struct xrt_device *xdev, u32 cmd, void *arg)
+{
+	struct xmgmt_main *xmm = xrt_get_drvdata(xdev);
+	int ret = 0;
+
+	switch (cmd) {
+	case XRT_XLEAF_EVENT:
+		xmgmt_main_event_cb(xdev, arg);
+		break;
+	case XRT_MGMT_MAIN_GET_AXLF_SECTION: {
+		struct xrt_mgmt_main_get_axlf_section *get =
+			(struct xrt_mgmt_main_get_axlf_section *)arg;
+		const struct axlf *firmware = xmgmt_get_axlf_firmware(xmm, get->xmmigas_axlf_kind);
+
+		if (!firmware) {
+			ret = -ENOENT;
+		} else {
+			ret = xrt_xclbin_get_section(DEV(xdev), firmware,
+						     get->xmmigas_section_kind,
+						     &get->xmmigas_section,
+						     &get->xmmigas_section_size);
+		}
+		break;
+	}
+	case XRT_MGMT_MAIN_GET_VBNV: {
+		char **vbnv_p = (char **)arg;
+
+		*vbnv_p = xmgmt_get_vbnv(xdev);
+		if (!*vbnv_p)
+			ret = -EINVAL;
+		break;
+	}
+	default:
+		xrt_err(xdev, "unknown cmd: %d", cmd);
+		ret = -EINVAL;
+		break;
+	}
+	return ret;
+}
+
+static int xmgmt_main_open(struct inode *inode, struct file *file)
+{
+	struct xrt_device *xdev = xleaf_devnode_open(inode);
+
+	/* Device may have gone already when we get here. */
+	if (!xdev)
+		return -ENODEV;
+
+	xrt_info(xdev, "opened");
+	file->private_data = xrt_get_drvdata(xdev);
+	return 0;
+}
+
+static int xmgmt_main_close(struct inode *inode, struct file *file)
+{
+	struct xmgmt_main *xmm = file->private_data;
+
+	xleaf_devnode_close(inode);
+
+	xrt_info(xmm->xdev, "closed");
+	return 0;
+}
+
+/*
+ * Called for xclbin download xclbin load ioctl.
+ */
+static int xmgmt_bitstream_axlf_fpga_mgr(struct xmgmt_main *xmm, void *axlf, size_t size)
+{
+	int ret;
+
+	WARN_ON(!mutex_is_locked(&xmm->lock));
+
+	/*
+	 * Should any error happens during download, we can't trust
+	 * the cached xclbin any more.
+	 */
+	vfree(xmm->firmware_ulp);
+	xmm->firmware_ulp = NULL;
+
+	ret = xmgmt_process_xclbin(xmm->xdev, xmm->fmgr, axlf, XMGMT_ULP);
+	if (ret == 0)
+		xmm->firmware_ulp = axlf;
+
+	return ret;
+}
+
+static int bitstream_axlf_ioctl(struct xmgmt_main *xmm, const void __user *arg)
+{
+	struct xmgmt_ioc_bitstream_axlf ioc_obj = { 0 };
+	struct axlf xclbin_obj = { {0} };
+	const void __user *xclbin;
+	size_t copy_buffer_size = 0;
+	void *copy_buffer = NULL;
+	int ret = 0;
+
+	if (copy_from_user((void *)&ioc_obj, arg, sizeof(ioc_obj)))
+		return -EFAULT;
+	xclbin = (const void __user *)ioc_obj.xclbin;
+	if (copy_from_user((void *)&xclbin_obj, xclbin, sizeof(xclbin_obj)))
+		return -EFAULT;
+	if (memcmp(xclbin_obj.magic, XCLBIN_VERSION2, sizeof(XCLBIN_VERSION2)))
+		return -EINVAL;
+
+	copy_buffer_size = xclbin_obj.header.length;
+	if (copy_buffer_size > XCLBIN_MAX_SZ_1G || copy_buffer_size < sizeof(xclbin_obj))
+		return -EINVAL;
+	if (xclbin_obj.header.version_major != XMGMT_SUPP_XCLBIN_MAJOR)
+		return -EINVAL;
+
+	copy_buffer = vmalloc(copy_buffer_size);
+	if (!copy_buffer)
+		return -ENOMEM;
+
+	if (copy_from_user(copy_buffer, xclbin, copy_buffer_size)) {
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
+static long xmgmt_main_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
+{
+	struct xmgmt_main *xmm = filp->private_data;
+	long result = 0;
+
+	if (_IOC_TYPE(cmd) != XMGMT_IOC_MAGIC)
+		return -ENOTTY;
+
+	mutex_lock(&xmm->lock);
+
+	xrt_info(xmm->xdev, "ioctl cmd %d, arg %ld", cmd, arg);
+	switch (cmd) {
+	case XMGMT_IOCICAPDOWNLOAD_AXLF:
+		result = bitstream_axlf_ioctl(xmm, (const void __user *)arg);
+		break;
+	default:
+		result = -ENOTTY;
+		break;
+	}
+
+	mutex_unlock(&xmm->lock);
+	return result;
+}
+
+static struct xrt_dev_endpoints xrt_mgmt_main_endpoints[] = {
+	{
+		.xse_names = (struct xrt_dev_ep_names []){
+			{ .ep_name = XRT_MD_NODE_MGMT_MAIN },
+			{ NULL },
+		},
+		.xse_min_ep = 1,
+	},
+	{ 0 },
+};
+
+static struct xrt_driver xmgmt_main_driver = {
+	.driver	= {
+		.name = XMGMT_MAIN,
+	},
+	.file_ops = {
+		.xsf_ops = {
+			.owner = THIS_MODULE,
+			.open = xmgmt_main_open,
+			.release = xmgmt_main_close,
+			.unlocked_ioctl = xmgmt_main_ioctl,
+		},
+		.xsf_dev_name = "xmgmt",
+	},
+	.subdev_id = XRT_SUBDEV_MGMT_MAIN,
+	.endpoints = xrt_mgmt_main_endpoints,
+	.probe = xmgmt_main_probe,
+	.remove = xmgmt_main_remove,
+	.leaf_call = xmgmt_mainleaf_call,
+};
+
+int xmgmt_register_leaf(void)
+{
+	return xrt_register_driver(&xmgmt_main_driver);
+}
+
+void xmgmt_unregister_leaf(void)
+{
+	xrt_unregister_driver(&xmgmt_main_driver);
+}
diff --git a/drivers/fpga/xrt/mgmt/xmgmt.h b/drivers/fpga/xrt/mgmt/xmgmt.h
new file mode 100644
index 000000000000..54ce3875471a
--- /dev/null
+++ b/drivers/fpga/xrt/mgmt/xmgmt.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2021 Xilinx, Inc.
+ *
+ * Authors:
+ *	Lizhi Hou <Lizhi.Hou@xilinx.com>
+ *	Cheng Zhen <maxz@xilinx.com>
+ */
+
+#ifndef _XMGMT_H_
+#define _XMGMT_H_
+
+#include "xmgmt-main.h"
+
+struct fpga_manager;
+int xmgmt_process_xclbin(struct xrt_device *xdev,
+			 struct fpga_manager *fmgr,
+			 const struct axlf *xclbin,
+			 enum provider_kind kind);
+void xmgmt_region_cleanup_all(struct xrt_device *xdev);
+
+int xmgmt_hot_reset(struct xrt_device *xdev);
+
+/* Getting dtb for specified group. Caller should vfree returned dtb. */
+char *xmgmt_get_dtb(struct xrt_device *xdev, enum provider_kind kind);
+char *xmgmt_get_vbnv(struct xrt_device *xdev);
+int xmgmt_get_provider_uuid(struct xrt_device *xdev,
+			    enum provider_kind kind, uuid_t *uuid);
+
+int xmgmt_register_leaf(void);
+void xmgmt_unregister_leaf(void);
+
+#endif	/* _XMGMT_H_ */
diff --git a/include/uapi/linux/xrt/xmgmt-ioctl.h b/include/uapi/linux/xrt/xmgmt-ioctl.h
new file mode 100644
index 000000000000..f94175063802
--- /dev/null
+++ b/include/uapi/linux/xrt/xmgmt-ioctl.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ *  Copyright (C) 2015-2021, Xilinx Inc
+ *
+ */
+
+/**
+ * DOC: PCIe Kernel Driver for Management Physical Function
+ * Interfaces exposed by *xrt-mgmt* driver are defined in file, *xmgmt-ioctl.h*.
+ * Core functionality provided by *xrt-mgmt* driver is described in the following table:
+ *
+ * =========== ============================== ==================================
+ * Functionality           ioctl request code           data format
+ * =========== ============================== ==================================
+ * 1 FPGA image download   XMGMT_IOCICAPDOWNLOAD_AXLF xmgmt_ioc_bitstream_axlf
+ * =========== ============================== ==================================
+ */
+
+#ifndef _XMGMT_IOCTL_H_
+#define _XMGMT_IOCTL_H_
+
+#include <linux/ioctl.h>
+
+#define XMGMT_IOC_MAGIC	'X'
+#define XMGMT_IOC_ICAP_DOWNLOAD_AXLF 0x6
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
+#define XMGMT_IOCICAPDOWNLOAD_AXLF				\
+	_IOW(XMGMT_IOC_MAGIC, XMGMT_IOC_ICAP_DOWNLOAD_AXLF, struct xmgmt_ioc_bitstream_axlf)
+
+/*
+ * The following definitions are for binary compatibility with classic XRT management driver
+ */
+#define XCLMGMT_IOCICAPDOWNLOAD_AXLF XMGMT_IOCICAPDOWNLOAD_AXLF
+#define xclmgmt_ioc_bitstream_axlf xmgmt_ioc_bitstream_axlf
+
+#endif
-- 
2.27.0


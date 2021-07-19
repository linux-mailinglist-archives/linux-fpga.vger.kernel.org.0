Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B98093CF053
	for <lists+linux-fpga@lfdr.de>; Tue, 20 Jul 2021 01:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242917AbhGSXN2 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 19 Jul 2021 19:13:28 -0400
Received: from mail-mw2nam10on2050.outbound.protection.outlook.com ([40.107.94.50]:25472
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1388265AbhGSUr5 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 19 Jul 2021 16:47:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fq9wmXHeJpiuJMDmCmFYUTHv82hIUpd25ggUie7O1C2V4ols8g+ekMYLJ/VWi17wXtIZ8d5DGZeHp0K0F9gdgag3Yi0Hd7xFOsYCzaDrp7FanFUP04HrJlhZBvL2WzxjvZmi4QhwyGNMyw5tq7gU6+Mb5AxQHBrSCYtmuWVFGi5lcqwpZqZUBuuFyXVQa7D22NdVkP1XQ10cxrkgKtdM3+u9L6799eiNAhjbi7m4+jCoIsgrEnoXkIATTmF5my3hxGtsxu26FUjTcABhBjmq1oJP2ZUAfAY07SynSyttJ4GS7ucnFte05DcB+ufxJJC0hcCO0qFItAKw8077gMx0Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EM69VIDVQl2L/KFaAbVCiClBc7ILLnpVLfAGhFxTSeM=;
 b=ktGHueqrktve6UOTzVyVDqAHnG2hitzeQvPaHL54F8DeuEUh8aPkeWpBffZ9YdQTKv8esoVPvL6xUnUcMg/lt9HC2r/ZuUyXDXS/uoWlnm2m51zG+p4N2gnMPL5n4u/jENlryw4+WeAn0cG67ozOuNedZ8H6ve/WVCKhYDQqO3pAlrdclsAZ64ufyl6wmrP2qHHjjWu1kJfkXWLhnKGV322MOQw/ricrpFkkzYczoefWxf74ZmrsKFDbJniMn49CClGUIxVtgaFtB8BnkpbO6A+IRnJRVAee9YxQn+U5cfV1mTiFe8qtO5/l+WXTqy7guEZcXWAafNWVV9ghC0RScA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EM69VIDVQl2L/KFaAbVCiClBc7ILLnpVLfAGhFxTSeM=;
 b=HO1eQB510C60X87IVfP6bfWLaYE/SibkwmzcPHpVEik2A+PL6tXaUXXy7Swk6z1UjtXaRL/PjvAg0tvRrh+coHt9s4Rpjg74XO2AKhabYxnddlkv2HjqbgIlncevqRkFCyFUEQVFEOdKB51qyg647P6IdaEOxrumxLQgrKLmgL0=
Received: from DM5PR13CA0048.namprd13.prod.outlook.com (2603:10b6:3:7b::34) by
 DM6PR02MB6810.namprd02.prod.outlook.com (2603:10b6:5:214::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.23; Mon, 19 Jul 2021 21:28:33 +0000
Received: from DM3NAM02FT022.eop-nam02.prod.protection.outlook.com
 (2603:10b6:3:7b:cafe::8f) by DM5PR13CA0048.outlook.office365.com
 (2603:10b6:3:7b::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.9 via Frontend
 Transport; Mon, 19 Jul 2021 21:28:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT022.mail.protection.outlook.com (10.13.5.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4331.21 via Frontend Transport; Mon, 19 Jul 2021 21:28:33 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 19 Jul 2021 14:28:32 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Mon, 19 Jul 2021 14:28:32 -0700
Envelope-to: mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.73.109] (port=38284 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1m5aoS-000FGv-Bx; Mon, 19 Jul 2021 14:28:32 -0700
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id 216CF6020C3; Mon, 19 Jul 2021 14:26:32 -0700 (PDT)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>, Max Zhen <max.zhen@xilinx.com>
Subject: [PATCH V8 XRT Alveo 10/14] fpga: xrt: main driver for management function device
Date:   Mon, 19 Jul 2021 14:26:24 -0700
Message-ID: <20210719212628.134129-11-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210719212628.134129-1-lizhi.hou@xilinx.com>
References: <20210719212628.134129-1-lizhi.hou@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 04d148c9-a82f-4cbe-d6bf-08d94afc291b
X-MS-TrafficTypeDiagnostic: DM6PR02MB6810:
X-Microsoft-Antispam-PRVS: <DM6PR02MB6810105E07CF1E36DF501509A1E19@DM6PR02MB6810.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:317;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XsKXbAhMPIh7ab+/6lQo2hG18OkA6rFeg5OBrgN1ZFAWfnQAREGXlT7YYGbDVJ8FzwadmcMjsobl/0ZFbpHEhm8xrP9MQeBRrfhLTmTjT4ul8TsV022KUCB1SO4G/rCVsjQ2PpB/jZg6vGo1+71X22ehjWcY91KyrxJvusXahBx3eGTfUdVH2c5ZOdSeVr5qHhrijVaiXHtPuJ77lyz2CUSTFjL1GxDpBq33zQE4Q1J/iGBD8AnDLJUtRQUea0dwRfrpdfIYFsIWHahg8hRZMEx+aukZIdUldFKli2wu8w8vGwoFeK7NyBEkvc0lea8zxn2+v+qoLNXAhuWdt68RWTm7K0K/969DhAFI6Z+ClWmz9B0gExrhHqn4MatQ0i7PDnrvYicz8VGokT9YzYxU1WXfeoeTtDJg89RXddCfgp/ESYCgwg0w+mtBCDs7rKj6tLZgyx7j2we8lgumKbQsg6kbtQIkidZZSXLc4jyYHzIGWLamZCg7ier0GhuToGFBxALVru1vyypNOf26QYtU7dyPpYF5HBVqh3ZHfIP7YjVZhpgj73KUahib2Lr5COk8KaX/sNpH1w45lfqbLHdH/hYsIeSh8yDAytjHIivA6VKKSYYiLRD6gYJbgT7aIhGzYDtnnS//wWViBXIU/NVTMhC9huvLS/pbvuSdT9rlYpkS6syJTrC/oRUmj1S0dfsf2/3B8OyuXJfY9SLTa5D9rA==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(39860400002)(136003)(346002)(396003)(376002)(36840700001)(46966006)(54906003)(82740400003)(5660300002)(2906002)(336012)(30864003)(83380400001)(6266002)(2616005)(42186006)(6666004)(44832011)(426003)(316002)(7636003)(36906005)(107886003)(36756003)(186003)(4326008)(478600001)(26005)(47076005)(356005)(82310400003)(6916009)(8676002)(1076003)(70206006)(36860700001)(70586007)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2021 21:28:33.0610
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04d148c9-a82f-4cbe-d6bf-08d94afc291b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT022.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6810
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
 3 files changed, 729 insertions(+)
 create mode 100644 drivers/fpga/xrt/include/xmgmt-main.h
 create mode 100644 drivers/fpga/xrt/mgmt/xmgmt-main.c
 create mode 100644 drivers/fpga/xrt/mgmt/xmgmt.h

diff --git a/drivers/fpga/xrt/include/xmgmt-main.h b/drivers/fpga/xrt/include/xmgmt-main.h
new file mode 100644
index 000000000000..e7e95a839c12
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
+#include <linux/fpga-xrt.h>
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
index 000000000000..7275da8e5b01
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
+#include <linux/fpga-xrt.h>
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
+/* logic uuid is the uuid uniquely identify the partition */
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
+	if (rc < 0) {
+		xrt_err(xdev, "failed to create BLP group: %d", rc);
+		goto failed;
+	}
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
-- 
2.27.0


Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51D5736CD85
	for <lists+linux-fpga@lfdr.de>; Tue, 27 Apr 2021 23:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239271AbhD0VBh (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 27 Apr 2021 17:01:37 -0400
Received: from mail-bn8nam11on2083.outbound.protection.outlook.com ([40.107.236.83]:27136
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239210AbhD0VBe (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 27 Apr 2021 17:01:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IQb2wcuKjUUy6YAKtp61dtYOQ8Ah0r678nZ2VF/Z1LFjkMH45q6wE1T1SZ4cpkeyqQMhLfrrI5Oh2rFT14N0/UQR/JDZfHq9UylEZNllauEFX8f326nQKnG4Jx6R1+Ea8T/2NRr6WYglIzXEPl5aGeohPsDfOqluuI9G01K6OdTV44uFJciIqbuyQgdLXds0n2OO+FLkqS6selVkN1g36EhN0QRHfuFzNZiQeWK3aDgW+s3X+Lqv5zTOPbc/Zg6Kod/gnvrfCpenRFBFe2ZcBT1XF/wjA2N77otBLegonlclNxeypjOmWG93QgR9VcFI317h94ToVIfMGM6Wj/2vyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=al49dlEQdlzDXkqGBX6PdjeLLVRKdOUMJ+b3FojAIGE=;
 b=JGIpqtX5HHW+uYhAnPyDAHjK55wHp8V5oVu7b+Cs8yt8VWlA126w8qH1vTAK+4JJaGWY8n/e3zY+1ESR6I9kBnKX+LGIcgMLsoqP1NI/B/m0Ha4uCZtlklP69bkziJnTqmD5z4xooSymzjCdsJqS6m9wRPZehtsKLBzKaCqWh3GZp55Fvmj0BSLWg6/amQJrS+KGscYoj23HjiCRCymQCF4hCLors3EuaA7sdhOzHV/a55UpS4KZd+smEUdw3356lu/sNOPsL6Gdf4ykdBI9ADDQI5lFvZrjzfjARcGPYeavOeRXgslCtng/vc8uG9ldLh2mZh5SUfFZKrOOmbAR7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=al49dlEQdlzDXkqGBX6PdjeLLVRKdOUMJ+b3FojAIGE=;
 b=jbuDoLZwzsIfJQr0hnWN8Vh6ixT2+9xmlczdPqNbqQsesoihB7RJrDdotNYv9YDTPGACrUaM8SrC/e5A5xML3q/c9TRd0qB0z4s2iTq1VnJir/7+OaXnckyXaQIDG4F07p/RyV7Qu1EEGVeF3VU1RQ/IXXr0K5gr8AZfycSYuT8=
Received: from CY4PR1101CA0005.namprd11.prod.outlook.com
 (2603:10b6:910:15::15) by SN6PR02MB5518.namprd02.prod.outlook.com
 (2603:10b6:805:eb::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Tue, 27 Apr
 2021 21:00:45 +0000
Received: from CY1NAM02FT052.eop-nam02.prod.protection.outlook.com
 (2603:10b6:910:15:cafe::10) by CY4PR1101CA0005.outlook.office365.com
 (2603:10b6:910:15::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20 via Frontend
 Transport; Tue, 27 Apr 2021 21:00:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 CY1NAM02FT052.mail.protection.outlook.com (10.152.74.123) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4065.21 via Frontend Transport; Tue, 27 Apr 2021 21:00:45 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 27 Apr 2021 13:59:50 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Tue, 27 Apr 2021 13:59:50 -0700
Envelope-to: mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.72.212] (port=52016 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1lbUoA-0001ql-2G; Tue, 27 Apr 2021 13:59:50 -0700
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id F1C3260012D; Tue, 27 Apr 2021 13:54:35 -0700 (PDT)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>, Max Zhen <max.zhen@xilinx.com>
Subject: [PATCH V5 XRT Alveo 10/20] fpga: xrt: main driver for management function device
Date:   Tue, 27 Apr 2021 13:54:21 -0700
Message-ID: <20210427205431.23896-11-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210427205431.23896-1-lizhi.hou@xilinx.com>
References: <20210427205431.23896-1-lizhi.hou@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1cef002d-78e2-493b-671f-08d909bf8705
X-MS-TrafficTypeDiagnostic: SN6PR02MB5518:
X-Microsoft-Antispam-PRVS: <SN6PR02MB551830E07A1371ADE88DACCBA1419@SN6PR02MB5518.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:538;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3QQ/+3+8FZp7RJ61eypJN4kTUhcQ5RZEhc2Ql1RJVwbBp8YyyJzwpvVyB5HSEwOjSKr5yU0qk1iiOU6tnfvYvV6pOujxvic7i2YDSIVYsBJMwmZNZOOawCXmtFLuvKXyV75QctKO2JxoTxuPORRD9Dn7nr7+y/8Wbfq9aWE0chK0yoNtmk4SbffkmAL/p1ccE48UTCX9kWAu0yanjwJsMDE2voVx741HLlQzn4Cr846H26WPsyciigFEhDU+PY2sZTYRWYU7DDciXjSONcaum2tLKskR0S/d2DbdiRnZy/0gLt21Frk2OWZ9PePWD/RPW3lZ8ALZVBn4F2NlaahI9S+kNFt81yKhQiRKgs0g4X//6ANtqqIxXMulQ7cVF6AMUx1oUjM0QBu+gOSjuXtLoDpXfLBpN2YYD23OIuAy4JTtfSfXAIjGwjGLPG/5UJImY+CHFdY+5YaiHUIdSRnYJEXIO8C97MMTBgofYB+0Jd3z5+kYo2/1KKmDZjwDxlI9BlZYrxdeB9JnWdDbVnc0682oXGgKyJXibaTdzxSMfRgtuAC0ohbApB4TzzJbWmczcFcWWAkeh+hDtS1mU5zRFFuTReFN6T+7d/AwSjZCo+dje7g0qZ61hrjUAy5xEWMXdlK7689R4E/OpegvNM1K9K1YepE215Fhzlqe47f3bE8=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(376002)(39850400004)(396003)(346002)(136003)(46966006)(36840700001)(6266002)(356005)(186003)(4326008)(70206006)(1076003)(82740400003)(2616005)(42186006)(107886003)(6916009)(426003)(5660300002)(47076005)(7636003)(30864003)(54906003)(44832011)(2906002)(316002)(70586007)(8676002)(36906005)(82310400003)(8936002)(336012)(36756003)(478600001)(6666004)(36860700001)(26005)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2021 21:00:45.7688
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cef002d-78e2-493b-671f-08d909bf8705
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT052.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5518
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

xrt driver that handles IOCTLs, such as hot reset and xclbin download.

Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
Signed-off-by: Max Zhen <max.zhen@xilinx.com>
Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
---
 drivers/fpga/xrt/include/xmgnt-main.h |  34 ++
 drivers/fpga/xrt/mgnt/xmgnt-main.c    | 660 ++++++++++++++++++++++++++
 drivers/fpga/xrt/mgnt/xmgnt.h         |  33 ++
 include/uapi/linux/xrt/xmgnt-ioctl.h  |  46 ++
 4 files changed, 773 insertions(+)
 create mode 100644 drivers/fpga/xrt/include/xmgnt-main.h
 create mode 100644 drivers/fpga/xrt/mgnt/xmgnt-main.c
 create mode 100644 drivers/fpga/xrt/mgnt/xmgnt.h
 create mode 100644 include/uapi/linux/xrt/xmgnt-ioctl.h

diff --git a/drivers/fpga/xrt/include/xmgnt-main.h b/drivers/fpga/xrt/include/xmgnt-main.h
new file mode 100644
index 000000000000..b46dac710cd3
--- /dev/null
+++ b/drivers/fpga/xrt/include/xmgnt-main.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2021 Xilinx, Inc.
+ *
+ * Authors:
+ *	Cheng Zhen <maxz@xilinx.com>
+ */
+
+#ifndef _XMGNT_MAIN_H_
+#define _XMGNT_MAIN_H_
+
+#include <linux/xrt/xclbin.h>
+#include "xleaf.h"
+
+enum xrt_mgnt_main_leaf_cmd {
+	XRT_MGNT_MAIN_GET_AXLF_SECTION = XRT_XLEAF_CUSTOM_BASE, /* See comments in xleaf.h */
+	XRT_MGNT_MAIN_GET_VBNV,
+};
+
+/* There are three kind of partitions. Each of them is programmed independently. */
+enum provider_kind {
+	XMGNT_BLP, /* Base Logic Partition */
+	XMGNT_PLP, /* Provider Logic Partition */
+	XMGNT_ULP, /* User Logic Partition */
+};
+
+struct xrt_mgnt_main_get_axlf_section {
+	enum provider_kind xmmigas_axlf_kind;
+	enum axlf_section_kind xmmigas_section_kind;
+	void *xmmigas_section;
+	u64 xmmigas_section_size;
+};
+
+#endif	/* _XMGNT_MAIN_H_ */
diff --git a/drivers/fpga/xrt/mgnt/xmgnt-main.c b/drivers/fpga/xrt/mgnt/xmgnt-main.c
new file mode 100644
index 000000000000..a1c6dc34f6c0
--- /dev/null
+++ b/drivers/fpga/xrt/mgnt/xmgnt-main.c
@@ -0,0 +1,660 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx Alveo FPGA MGNT PF entry point driver
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
+#include <linux/xrt/xmgnt-ioctl.h>
+#include "xleaf/devctl.h"
+#include "xmgnt-main.h"
+#include "xrt-mgr.h"
+#include "xleaf/icap.h"
+#include "xleaf/axigate.h"
+#include "xmgnt.h"
+
+#define XMGNT_MAIN "xmgnt_main"
+#define XMGNT_SUPP_XCLBIN_MAJOR 2
+
+#define XMGNT_FLAG_FLASH_READY	1
+#define XMGNT_FLAG_DEVCTL_READY	2
+
+#define XMGNT_UUID_STR_LEN	(UUID_SIZE * 2 + 1)
+
+struct xmgnt_main {
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
+char *xmgnt_get_vbnv(struct xrt_device *xdev)
+{
+	struct xmgnt_main *xmm = xrt_get_drvdata(xdev);
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
+int xmgnt_hot_reset(struct xrt_device *xdev)
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
+	xmgnt_hot_reset(xdev);
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
+	vbnv = xmgnt_get_vbnv(xdev);
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
+	char uuid[XMGNT_UUID_STR_LEN];
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
+	struct xmgnt_main *xmm = xrt_get_drvdata(xdev);
+	ssize_t ret = 0;
+	u32 i;
+
+	for (i = 0; i < xmm->blp_interface_uuid_num; i++) {
+		char uuidstr[XMGNT_UUID_STR_LEN];
+
+		xrt_md_trans_uuid2str(&xmm->blp_interface_uuids[i], uuidstr);
+		ret += sprintf(buf + ret, "%s\n", uuidstr);
+	}
+	return ret;
+}
+static DEVICE_ATTR_RO(interface_uuids);
+
+static struct attribute *xmgnt_main_attrs[] = {
+	&dev_attr_reset.attr,
+	&dev_attr_VBNV.attr,
+	&dev_attr_logic_uuids.attr,
+	&dev_attr_interface_uuids.attr,
+	NULL,
+};
+
+static const struct attribute_group xmgnt_main_attrgroup = {
+	.attrs = xmgnt_main_attrs,
+};
+
+static int load_firmware_from_disk(struct xrt_device *xdev, struct axlf **fw_buf, size_t *len)
+{
+	char uuid[XMGNT_UUID_STR_LEN];
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
+static const struct axlf *xmgnt_get_axlf_firmware(struct xmgnt_main *xmm, enum provider_kind kind)
+{
+	switch (kind) {
+	case XMGNT_BLP:
+		return xmm->firmware_blp;
+	case XMGNT_PLP:
+		return xmm->firmware_plp;
+	case XMGNT_ULP:
+		return xmm->firmware_ulp;
+	default:
+		xrt_err(xmm->xdev, "unknown axlf kind: %d", kind);
+		return NULL;
+	}
+}
+
+/* The caller needs to free the returned dtb buffer */
+char *xmgnt_get_dtb(struct xrt_device *xdev, enum provider_kind kind)
+{
+	struct xmgnt_main *xmm = xrt_get_drvdata(xdev);
+	const struct axlf *provider;
+	char *dtb = NULL;
+	int rc;
+
+	provider = xmgnt_get_axlf_firmware(xmm, kind);
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
+	char dev_uuid[XMGNT_UUID_STR_LEN];
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
+	if (xclbin->header.version_major != XMGNT_SUPP_XCLBIN_MAJOR) {
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
+int xmgnt_get_provider_uuid(struct xrt_device *xdev, enum provider_kind kind, uuid_t *uuid)
+{
+	struct xmgnt_main *xmm = xrt_get_drvdata(xdev);
+	const struct axlf *fwbuf;
+	const char *fw_uuid;
+	int rc = -ENOENT;
+
+	mutex_lock(&xmm->lock);
+
+	fwbuf = xmgnt_get_axlf_firmware(xmm, kind);
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
+static int xmgnt_create_blp(struct xmgnt_main *xmm)
+{
+	const struct axlf *provider = xmgnt_get_axlf_firmware(xmm, XMGNT_BLP);
+	struct xrt_device *xdev = xmm->xdev;
+	int rc = 0;
+	char *dtb = NULL;
+
+	dtb = xmgnt_get_dtb(xdev, XMGNT_BLP);
+	if (!dtb) {
+		xrt_err(xdev, "did not get BLP metadata");
+		return -EINVAL;
+	}
+
+	rc = xmgnt_process_xclbin(xmm->xdev, xmm->fmgr, provider, XMGNT_BLP);
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
+static int xmgnt_load_firmware(struct xmgnt_main *xmm)
+{
+	struct xrt_device *xdev = xmm->xdev;
+	size_t fwlen;
+	int rc;
+
+	rc = load_firmware_from_disk(xdev, &xmm->firmware_blp, &fwlen);
+	if (!rc && is_valid_firmware(xdev, xmm->firmware_blp, fwlen))
+		xmgnt_create_blp(xmm);
+	else
+		xrt_err(xdev, "failed to find firmware, giving up: %d", rc);
+	return rc;
+}
+
+static void xmgnt_main_event_cb(struct xrt_device *xdev, void *arg)
+{
+	struct xmgnt_main *xmm = xrt_get_drvdata(xdev);
+	struct xrt_event *evt = (struct xrt_event *)arg;
+	enum xrt_events e = evt->xe_evt;
+	struct xrt_device *leaf;
+	enum xrt_subdev_id id;
+
+	id = evt->xe_subdev.xevt_subdev_id;
+	switch (e) {
+	case XRT_EVENT_POST_CREATION: {
+		if (id == XRT_SUBDEV_DEVCTL && !(xmm->flags & XMGNT_FLAG_DEVCTL_READY)) {
+			leaf = xleaf_get_leaf_by_epname(xdev, XRT_MD_NODE_BLP_ROM);
+			if (leaf) {
+				xmm->flags |= XMGNT_FLAG_DEVCTL_READY;
+				xleaf_put_leaf(xdev, leaf);
+			}
+		} else if (id == XRT_SUBDEV_QSPI && !(xmm->flags & XMGNT_FLAG_FLASH_READY)) {
+			xmm->flags |= XMGNT_FLAG_FLASH_READY;
+		} else {
+			break;
+		}
+
+		if (xmm->flags & XMGNT_FLAG_DEVCTL_READY)
+			xmgnt_load_firmware(xmm);
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
+static int xmgnt_main_probe(struct xrt_device *xdev)
+{
+	struct xmgnt_main *xmm;
+
+	xrt_info(xdev, "probing...");
+
+	xmm = devm_kzalloc(DEV(xdev), sizeof(*xmm), GFP_KERNEL);
+	if (!xmm)
+		return -ENOMEM;
+
+	xmm->xdev = xdev;
+	xmm->fmgr = xmgnt_fmgr_probe(xdev);
+	if (IS_ERR(xmm->fmgr))
+		return PTR_ERR(xmm->fmgr);
+
+	xrt_set_drvdata(xdev, xmm);
+	mutex_init(&xmm->lock);
+
+	/* Ready to handle req thru sysfs nodes. */
+	if (sysfs_create_group(&DEV(xdev)->kobj, &xmgnt_main_attrgroup))
+		xrt_err(xdev, "failed to create sysfs group");
+	return 0;
+}
+
+static void xmgnt_main_remove(struct xrt_device *xdev)
+{
+	struct xmgnt_main *xmm = xrt_get_drvdata(xdev);
+
+	/* By now, group driver should prevent any inter-leaf call. */
+
+	xrt_info(xdev, "leaving...");
+
+	kfree(xmm->blp_interface_uuids);
+	vfree(xmm->firmware_blp);
+	vfree(xmm->firmware_plp);
+	vfree(xmm->firmware_ulp);
+	xmgnt_region_cleanup_all(xdev);
+	xmgnt_fmgr_remove(xmm->fmgr);
+	sysfs_remove_group(&DEV(xdev)->kobj, &xmgnt_main_attrgroup);
+}
+
+static int
+xmgnt_mainleaf_call(struct xrt_device *xdev, u32 cmd, void *arg)
+{
+	struct xmgnt_main *xmm = xrt_get_drvdata(xdev);
+	int ret = 0;
+
+	switch (cmd) {
+	case XRT_XLEAF_EVENT:
+		xmgnt_main_event_cb(xdev, arg);
+		break;
+	case XRT_MGNT_MAIN_GET_AXLF_SECTION: {
+		struct xrt_mgnt_main_get_axlf_section *get =
+			(struct xrt_mgnt_main_get_axlf_section *)arg;
+		const struct axlf *firmware = xmgnt_get_axlf_firmware(xmm, get->xmmigas_axlf_kind);
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
+	case XRT_MGNT_MAIN_GET_VBNV: {
+		char **vbnv_p = (char **)arg;
+
+		*vbnv_p = xmgnt_get_vbnv(xdev);
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
+static int xmgnt_main_open(struct inode *inode, struct file *file)
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
+static int xmgnt_main_close(struct inode *inode, struct file *file)
+{
+	struct xmgnt_main *xmm = file->private_data;
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
+static int xmgnt_bitstream_axlf_fpga_mgr(struct xmgnt_main *xmm, void *axlf, size_t size)
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
+	ret = xmgnt_process_xclbin(xmm->xdev, xmm->fmgr, axlf, XMGNT_ULP);
+	if (ret == 0)
+		xmm->firmware_ulp = axlf;
+
+	return ret;
+}
+
+static int bitstream_axlf_ioctl(struct xmgnt_main *xmm, const void __user *arg)
+{
+	struct xmgnt_ioc_bitstream_axlf ioc_obj = { 0 };
+	struct axlf xclbin_obj = { {0} };
+	size_t copy_buffer_size = 0;
+	void *copy_buffer = NULL;
+	int ret = 0;
+
+	if (copy_from_user((void *)&ioc_obj, arg, sizeof(ioc_obj)))
+		return -EFAULT;
+	if (copy_from_user((void *)&xclbin_obj, ioc_obj.xclbin, sizeof(xclbin_obj)))
+		return -EFAULT;
+	if (memcmp(xclbin_obj.magic, XCLBIN_VERSION2, sizeof(XCLBIN_VERSION2)))
+		return -EINVAL;
+
+	copy_buffer_size = xclbin_obj.header.length;
+	if (copy_buffer_size > XCLBIN_MAX_SIZE || copy_buffer_size < sizeof(xclbin_obj))
+		return -EINVAL;
+	if (xclbin_obj.header.version_major != XMGNT_SUPP_XCLBIN_MAJOR)
+		return -EINVAL;
+
+	copy_buffer = vmalloc(copy_buffer_size);
+	if (!copy_buffer)
+		return -ENOMEM;
+
+	if (copy_from_user(copy_buffer, ioc_obj.xclbin, copy_buffer_size)) {
+		vfree(copy_buffer);
+		return -EFAULT;
+	}
+
+	ret = xmgnt_bitstream_axlf_fpga_mgr(xmm, copy_buffer, copy_buffer_size);
+	if (ret)
+		vfree(copy_buffer);
+
+	return ret;
+}
+
+static long xmgnt_main_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
+{
+	struct xmgnt_main *xmm = filp->private_data;
+	long result = 0;
+
+	if (_IOC_TYPE(cmd) != XMGNT_IOC_MAGIC)
+		return -ENOTTY;
+
+	mutex_lock(&xmm->lock);
+
+	xrt_info(xmm->xdev, "ioctl cmd %d, arg %ld", cmd, arg);
+	switch (cmd) {
+	case XMGNT_IOCICAPDOWNLOAD_AXLF:
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
+static struct xrt_dev_endpoints xrt_mgnt_main_endpoints[] = {
+	{
+		.xse_names = (struct xrt_dev_ep_names []){
+			{ .ep_name = XRT_MD_NODE_MGNT_MAIN },
+			{ NULL },
+		},
+		.xse_min_ep = 1,
+	},
+	{ 0 },
+};
+
+static struct xrt_driver xmgnt_main_driver = {
+	.driver	= {
+		.name = XMGNT_MAIN,
+	},
+	.file_ops = {
+		.xsf_ops = {
+			.owner = THIS_MODULE,
+			.open = xmgnt_main_open,
+			.release = xmgnt_main_close,
+			.unlocked_ioctl = xmgnt_main_ioctl,
+		},
+		.xsf_dev_name = "xmgnt",
+	},
+	.subdev_id = XRT_SUBDEV_MGNT_MAIN,
+	.endpoints = xrt_mgnt_main_endpoints,
+	.probe = xmgnt_main_probe,
+	.remove = xmgnt_main_remove,
+	.leaf_call = xmgnt_mainleaf_call,
+};
+
+int xmgnt_register_leaf(void)
+{
+	return xrt_register_driver(&xmgnt_main_driver);
+}
+
+void xmgnt_unregister_leaf(void)
+{
+	xrt_unregister_driver(&xmgnt_main_driver);
+}
diff --git a/drivers/fpga/xrt/mgnt/xmgnt.h b/drivers/fpga/xrt/mgnt/xmgnt.h
new file mode 100644
index 000000000000..c8159903de4a
--- /dev/null
+++ b/drivers/fpga/xrt/mgnt/xmgnt.h
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
+#ifndef _XMGNT_H_
+#define _XMGNT_H_
+
+#include "xmgnt-main.h"
+
+struct fpga_manager;
+int xmgnt_process_xclbin(struct xrt_device *xdev,
+			 struct fpga_manager *fmgr,
+			 const struct axlf *xclbin,
+			 enum provider_kind kind);
+void xmgnt_region_cleanup_all(struct xrt_device *xdev);
+
+int xmgnt_hot_reset(struct xrt_device *xdev);
+
+/* Getting dtb for specified group. Caller should vfree returned dtb. */
+char *xmgnt_get_dtb(struct xrt_device *xdev, enum provider_kind kind);
+char *xmgnt_get_vbnv(struct xrt_device *xdev);
+int xmgnt_get_provider_uuid(struct xrt_device *xdev,
+			    enum provider_kind kind, uuid_t *uuid);
+
+int xmgnt_register_leaf(void);
+void xmgnt_unregister_leaf(void);
+
+#endif	/* _XMGNT_H_ */
diff --git a/include/uapi/linux/xrt/xmgnt-ioctl.h b/include/uapi/linux/xrt/xmgnt-ioctl.h
new file mode 100644
index 000000000000..e4ba5335fa3f
--- /dev/null
+++ b/include/uapi/linux/xrt/xmgnt-ioctl.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ *  Copyright (C) 2015-2021, Xilinx Inc
+ *
+ */
+
+/**
+ * DOC: PCIe Kernel Driver for Management Physical Function
+ * Interfaces exposed by *xrt-mgnt* driver are defined in file, *xmgnt-ioctl.h*.
+ * Core functionality provided by *xrt-mgnt* driver is described in the following table:
+ *
+ * =========== ============================== ==================================
+ * Functionality           ioctl request code           data format
+ * =========== ============================== ==================================
+ * 1 FPGA image download   XMGNT_IOCICAPDOWNLOAD_AXLF xmgnt_ioc_bitstream_axlf
+ * =========== ============================== ==================================
+ */
+
+#ifndef _XMGNT_IOCTL_H_
+#define _XMGNT_IOCTL_H_
+
+#include <linux/ioctl.h>
+
+#define XMGNT_IOC_MAGIC	'X'
+#define XMGNT_IOC_ICAP_DOWNLOAD_AXLF 0x6
+
+/**
+ * struct xmgnt_ioc_bitstream_axlf - load xclbin (AXLF) device image
+ * used with XMGNT_IOCICAPDOWNLOAD_AXLF ioctl
+ *
+ * @xclbin:	Pointer to user's xclbin structure in memory
+ */
+struct xmgnt_ioc_bitstream_axlf {
+	struct axlf *xclbin;
+};
+
+#define XMGNT_IOCICAPDOWNLOAD_AXLF				\
+	_IOW(XMGNT_IOC_MAGIC, XMGNT_IOC_ICAP_DOWNLOAD_AXLF, struct xmgnt_ioc_bitstream_axlf)
+
+/*
+ * The following definitions are for binary compatibility with classic XRT management driver
+ */
+#define XCLMGNT_IOCICAPDOWNLOAD_AXLF XMGNT_IOCICAPDOWNLOAD_AXLF
+#define xclmgnt_ioc_bitstream_axlf xmgnt_ioc_bitstream_axlf
+
+#endif
-- 
2.27.0


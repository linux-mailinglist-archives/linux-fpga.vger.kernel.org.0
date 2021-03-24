Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7816347104
	for <lists+linux-fpga@lfdr.de>; Wed, 24 Mar 2021 06:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235309AbhCXFe5 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 24 Mar 2021 01:34:57 -0400
Received: from mail-mw2nam10on2058.outbound.protection.outlook.com ([40.107.94.58]:21761
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235313AbhCXFeb (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 24 Mar 2021 01:34:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MHF3T+F1lSX3HRBxZfLCcLnSdfsueh1eSmkCn8M0G+ZlZtFHkgqyJsMKW7HVpdVkf5cB4MF2xpj4rSc8WrGhMQhb1tplXvA2vjtsYKwSIiv0SqaBw8faGw4OgsshdespqDx2dCXppebTRKKN18fUuFghQPQOv48Cx4aqt55C+Msc1vYv6JFFdYyszsPlE16+bu3DK+EisH3kkgtuaCmqHns+Eb3nJkem1iWnnriD52G1hedxoMiDfPuffHQwyw120Vald2xI/9imxn6sFOI4h2jQrgmA6rcYwwcuddLBjsUeOmgs1yBkDs0eCIh++c9z6LTadPhkL4FzFQSNT+RzOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eDjsXaCv9fH9Cb+X5pDhT068FjO3cKxqmjoimj7398w=;
 b=cgEIyS+Bbh4t9x6KNZIScg4yQCa3Y7yPJiUUx2KFP9zzW59m7mYT4lEnJnUBxzyNjmZUL0eQBvUIb46NLifT64RkNXylbNl8LIrwKu0sTWrkb5nf5GMm4Y2IZJ6aMTinuAlQ7jeaP4ofzkeNdRahrepaPSmuEZrLod0CLU+SwFK4CuO7gusBEh2b9OyEFH1SKH2WfS8+n96YG/m2WyDmFnlxdnI5Kt5FkUo4x/hI5hBIZyNkkw36Hs4I/SkiwQytMf1tJkOh0StyRFpub8MpfJuJKJBvsnGoym1AgU5WTp4gw7q6Dr7do27orgMQaN+b3q/rGZEIzcQqTQ4C5KKvZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eDjsXaCv9fH9Cb+X5pDhT068FjO3cKxqmjoimj7398w=;
 b=kC9aQJqF31VfQTZvIUwGOiwGtRHxAUg62aKLmRV0riBqCUsbNtgCcRNU/hJzVq66v046QTVDKeSy89HUibjDPasf3/1RNRC4zd7Ntjp+LgJGeyJIy9dUenztn/21CztrWgkrLELP0pag9W3JvZzxtPeYQFmojswEAzC+JXUTthI=
Received: from SN4PR0501CA0113.namprd05.prod.outlook.com
 (2603:10b6:803:42::30) by BN7PR02MB5218.namprd02.prod.outlook.com
 (2603:10b6:408:26::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.25; Wed, 24 Mar
 2021 05:34:25 +0000
Received: from SN1NAM02FT006.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:42:cafe::1a) by SN4PR0501CA0113.outlook.office365.com
 (2603:10b6:803:42::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.9 via Frontend
 Transport; Wed, 24 Mar 2021 05:34:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT006.mail.protection.outlook.com (10.152.72.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3977.25 via Frontend Transport; Wed, 24 Mar 2021 05:34:24 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 23 Mar 2021 22:34:22 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2106.2 via Frontend Transport; Tue, 23 Mar 2021 22:34:22 -0700
Envelope-to: mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.72.212] (port=51040 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1lOw9u-0005yr-IM; Tue, 23 Mar 2021 22:34:22 -0700
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id 68E8E600129; Tue, 23 Mar 2021 22:29:56 -0700 (PDT)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>, Max Zhen <max.zhen@xilinx.com>
Subject: [PATCH V4 XRT Alveo 10/20] fpga: xrt: main platform driver for management function device
Date:   Tue, 23 Mar 2021 22:29:37 -0700
Message-ID: <20210324052947.27889-11-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210324052947.27889-1-lizhi.hou@xilinx.com>
References: <20210324052947.27889-1-lizhi.hou@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2be4366a-3c9a-4f0c-eada-08d8ee867c29
X-MS-TrafficTypeDiagnostic: BN7PR02MB5218:
X-Microsoft-Antispam-PRVS: <BN7PR02MB5218198B953ECB6BC0DD3476A1639@BN7PR02MB5218.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:538;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sEZuxVuD8/7+FjdDqkmxHc1nvfcw8RU0Cbr/q1Rkvm6Hw5eMwAjguxywPFaNbob6CzFRs/n6oG81YitylcxLDGyKzmv1CHynR+7W1tBPy+kEbRqwDYDMoHZcHWainXEgvuVQrwYyyxDjMt9HH0hOmMIEsV/lxjjv6oAHux8ShGpQUNsslrgnssDNY8g2tzN8c25VRxw6s7yMpTk5Is1E205nG/7YPiGZQAIhP6xf6tRsdLy3wn3msMuq7ePE5y0/lj8z+Ww2zgQgpsHnAjsUIa/38vk9IxoBXVR7KCLkvy1P3dZVK6kwrBL5SJdeMiIKRlhjZIB7jVOgbczG8TkIndSsHlNPKtqOk+oW1XP/Pq+lKdcfH/onZ3d2Rr2MC570AsqpRiu61rpemk9njjkQSAXl89mRydt0+yYcAhg+259+vxLQbd6jjRDBlHiAkKDQ2jDICPw50rZnugcUtzqC32ccDthokowFCmrqYl19eaQ+rVzguqvpatX1QgSu8MRpOnh3vKPkd61gTfrxJIJ1Qy5seIA55k7siQatI2Cs3kPAJQIVbg0wp8vo7DZRACVUgyXfjDK+k7UG1gsf4u9rxx4NihjMoSlTITu7CWDKudoVmKS2KyVE0/0MTtoAnfan6QbthLkgsLJwBSs4zcHzvpsozQ38LqmetrOc6uN6QFU=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(396003)(39860400002)(36840700001)(46966006)(2616005)(2906002)(186003)(36906005)(42186006)(54906003)(47076005)(316002)(36860700001)(5660300002)(426003)(26005)(8936002)(6266002)(30864003)(36756003)(82310400003)(83380400001)(70586007)(70206006)(336012)(107886003)(1076003)(82740400003)(6916009)(6666004)(4326008)(7636003)(356005)(8676002)(478600001)(44832011);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2021 05:34:24.8275
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2be4366a-3c9a-4f0c-eada-08d8ee867c29
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT006.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB5218
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

platform driver that handles IOCTLs, such as hot reset and xclbin download.

Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
Signed-off-by: Max Zhen <max.zhen@xilinx.com>
Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
---
 drivers/fpga/xrt/include/xmgmt-main.h |  34 ++
 drivers/fpga/xrt/mgmt/main.c          | 670 ++++++++++++++++++++++++++
 drivers/fpga/xrt/mgmt/xmgnt.h         |  34 ++
 include/uapi/linux/xrt/xmgmt-ioctl.h  |  46 ++
 4 files changed, 784 insertions(+)
 create mode 100644 drivers/fpga/xrt/include/xmgmt-main.h
 create mode 100644 drivers/fpga/xrt/mgmt/main.c
 create mode 100644 drivers/fpga/xrt/mgmt/xmgnt.h
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
diff --git a/drivers/fpga/xrt/mgmt/main.c b/drivers/fpga/xrt/mgmt/main.c
new file mode 100644
index 000000000000..f3b46e1fd78b
--- /dev/null
+++ b/drivers/fpga/xrt/mgmt/main.c
@@ -0,0 +1,670 @@
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
+#include "xclbin-helper.h"
+#include "metadata.h"
+#include "xleaf.h"
+#include <linux/xrt/xmgmt-ioctl.h>
+#include "xleaf/devctl.h"
+#include "xmgmt-main.h"
+#include "fmgr.h"
+#include "xleaf/icap.h"
+#include "xleaf/axigate.h"
+#include "xmgnt.h"
+
+#define XMGMT_MAIN "xmgmt_main"
+#define XMGMT_SUPP_XCLBIN_MAJOR 2
+
+#define XMGMT_FLAG_FLASH_READY	1
+#define XMGMT_FLAG_DEVCTL_READY	2
+
+#define XMGMT_UUID_STR_LEN	80
+
+struct xmgmt_main {
+	struct platform_device *pdev;
+	struct axlf *firmware_blp;
+	struct axlf *firmware_plp;
+	struct axlf *firmware_ulp;
+	u32 flags;
+	struct fpga_manager *fmgr;
+	struct mutex lock; /* busy lock */
+
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
+char *xmgmt_get_vbnv(struct platform_device *pdev)
+{
+	struct xmgmt_main *xmm = platform_get_drvdata(pdev);
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
+static int get_dev_uuid(struct platform_device *pdev, char *uuidstr, size_t len)
+{
+	struct xrt_devctl_rw devctl_arg = { 0 };
+	struct platform_device *devctl_leaf;
+	char uuid_buf[UUID_SIZE];
+	uuid_t uuid;
+	int err;
+
+	devctl_leaf = xleaf_get_leaf_by_epname(pdev, XRT_MD_NODE_BLP_ROM);
+	if (!devctl_leaf) {
+		xrt_err(pdev, "can not get %s", XRT_MD_NODE_BLP_ROM);
+		return -EINVAL;
+	}
+
+	devctl_arg.xdr_id = XRT_DEVCTL_ROM_UUID;
+	devctl_arg.xdr_buf = uuid_buf;
+	devctl_arg.xdr_len = sizeof(uuid_buf);
+	devctl_arg.xdr_offset = 0;
+	err = xleaf_call(devctl_leaf, XRT_DEVCTL_READ, &devctl_arg);
+	xleaf_put_leaf(pdev, devctl_leaf);
+	if (err) {
+		xrt_err(pdev, "can not get uuid: %d", err);
+		return err;
+	}
+	import_uuid(&uuid, uuid_buf);
+	xrt_md_trans_uuid2str(&uuid, uuidstr);
+
+	return 0;
+}
+
+int xmgmt_hot_reset(struct platform_device *pdev)
+{
+	int ret = xleaf_broadcast_event(pdev, XRT_EVENT_PRE_HOT_RESET, false);
+
+	if (ret) {
+		xrt_err(pdev, "offline failed, hot reset is canceled");
+		return ret;
+	}
+
+	xleaf_hot_reset(pdev);
+	xleaf_broadcast_event(pdev, XRT_EVENT_POST_HOT_RESET, false);
+	return 0;
+}
+
+static ssize_t reset_store(struct device *dev, struct device_attribute *da,
+			   const char *buf, size_t count)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+
+	xmgmt_hot_reset(pdev);
+	return count;
+}
+static DEVICE_ATTR_WO(reset);
+
+static ssize_t VBNV_show(struct device *dev, struct device_attribute *da, char *buf)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	ssize_t ret;
+	char *vbnv;
+
+	vbnv = xmgmt_get_vbnv(pdev);
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
+	struct platform_device *pdev = to_platform_device(dev);
+	char uuid[XMGMT_UUID_STR_LEN];
+	ssize_t ret;
+
+	/* Getting UUID pointed to by VSEC, should be the same as logic UUID of BLP. */
+	ret = get_dev_uuid(pdev, uuid, sizeof(uuid));
+	if (ret)
+		return ret;
+	ret = sprintf(buf, "%s\n", uuid);
+	return ret;
+}
+static DEVICE_ATTR_RO(logic_uuids);
+
+static ssize_t interface_uuids_show(struct device *dev, struct device_attribute *da, char *buf)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct xmgmt_main *xmm = platform_get_drvdata(pdev);
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
+static int load_firmware_from_disk(struct platform_device *pdev, struct axlf **fw_buf, size_t *len)
+{
+	char uuid[XMGMT_UUID_STR_LEN];
+	const struct firmware *fw;
+	char fw_name[256];
+	int err = 0;
+
+	*len = 0;
+	err = get_dev_uuid(pdev, uuid, sizeof(uuid));
+	if (err)
+		return err;
+
+	snprintf(fw_name, sizeof(fw_name), "xilinx/%s/partition.xsabin", uuid);
+	xrt_info(pdev, "try loading fw: %s", fw_name);
+
+	err = request_firmware(&fw, fw_name, DEV(pdev));
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
+		xrt_err(xmm->pdev, "unknown axlf kind: %d", kind);
+		return NULL;
+	}
+}
+
+/* The caller needs to free the returned dtb buffer */
+char *xmgmt_get_dtb(struct platform_device *pdev, enum provider_kind kind)
+{
+	struct xmgmt_main *xmm = platform_get_drvdata(pdev);
+	const struct axlf *provider;
+	char *dtb = NULL;
+	int rc;
+
+	provider = xmgmt_get_axlf_firmware(xmm, kind);
+	if (!provider)
+		return dtb;
+
+	rc = xrt_xclbin_get_metadata(DEV(pdev), provider, &dtb);
+	if (rc)
+		xrt_err(pdev, "failed to find dtb: %d", rc);
+	return dtb;
+}
+
+/* The caller needs to free the returned uuid buffer */
+static const char *get_uuid_from_firmware(struct platform_device *pdev, const struct axlf *xclbin)
+{
+	const void *uuiddup = NULL;
+	const void *uuid = NULL;
+	void *dtb = NULL;
+	int rc;
+
+	rc = xrt_xclbin_get_section(DEV(pdev), xclbin, PARTITION_METADATA, &dtb, NULL);
+	if (rc)
+		return NULL;
+
+	rc = xrt_md_get_prop(DEV(pdev), dtb, NULL, NULL, XRT_MD_PROP_LOGIC_UUID, &uuid, NULL);
+	if (!rc)
+		uuiddup = kstrdup(uuid, GFP_KERNEL);
+	vfree(dtb);
+	return uuiddup;
+}
+
+static bool is_valid_firmware(struct platform_device *pdev,
+			      const struct axlf *xclbin, size_t fw_len)
+{
+	const char *fw_buf = (const char *)xclbin;
+	size_t axlflen = xclbin->header.length;
+	char dev_uuid[XMGMT_UUID_STR_LEN];
+	const char *fw_uuid;
+	int err;
+
+	err = get_dev_uuid(pdev, dev_uuid, sizeof(dev_uuid));
+	if (err)
+		return false;
+
+	if (memcmp(fw_buf, XCLBIN_VERSION2, sizeof(XCLBIN_VERSION2)) != 0) {
+		xrt_err(pdev, "unknown fw format");
+		return false;
+	}
+
+	if (axlflen > fw_len) {
+		xrt_err(pdev, "truncated fw, length: %zu, expect: %zu", fw_len, axlflen);
+		return false;
+	}
+
+	if (xclbin->header.version_major != XMGMT_SUPP_XCLBIN_MAJOR) {
+		xrt_err(pdev, "firmware is not supported");
+		return false;
+	}
+
+	fw_uuid = get_uuid_from_firmware(pdev, xclbin);
+	if (!fw_uuid || strncmp(fw_uuid, dev_uuid, sizeof(dev_uuid)) != 0) {
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
+int xmgmt_get_provider_uuid(struct platform_device *pdev, enum provider_kind kind, uuid_t *uuid)
+{
+	struct xmgmt_main *xmm = platform_get_drvdata(pdev);
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
+	fw_uuid = get_uuid_from_firmware(pdev, fwbuf);
+	if (!fw_uuid)
+		goto done;
+
+	rc = xrt_md_trans_str2uuid(DEV(pdev), fw_uuid, uuid);
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
+	struct platform_device *pdev = xmm->pdev;
+	int rc = 0;
+	char *dtb = NULL;
+
+	dtb = xmgmt_get_dtb(pdev, XMGMT_BLP);
+	if (!dtb) {
+		xrt_err(pdev, "did not get BLP metadata");
+		return -EINVAL;
+	}
+
+	rc = xmgmt_process_xclbin(xmm->pdev, xmm->fmgr, provider, XMGMT_BLP);
+	if (rc) {
+		xrt_err(pdev, "failed to process BLP: %d", rc);
+		goto failed;
+	}
+
+	rc = xleaf_create_group(pdev, dtb);
+	if (rc < 0)
+		xrt_err(pdev, "failed to create BLP group: %d", rc);
+	else
+		rc = 0;
+
+	WARN_ON(xmm->blp_interface_uuids);
+	rc = xrt_md_get_interface_uuids(&pdev->dev, dtb, 0, NULL);
+	if (rc > 0) {
+		xmm->blp_interface_uuid_num = rc;
+		xmm->blp_interface_uuids = vzalloc(sizeof(uuid_t) * xmm->blp_interface_uuid_num);
+		if (!xmm->blp_interface_uuids) {
+			rc = -ENOMEM;
+			goto failed;
+		}
+		xrt_md_get_interface_uuids(&pdev->dev, dtb, xmm->blp_interface_uuid_num,
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
+	struct platform_device *pdev = xmm->pdev;
+	size_t fwlen;
+	int rc;
+
+	rc = load_firmware_from_disk(pdev, &xmm->firmware_blp, &fwlen);
+	if (!rc && is_valid_firmware(pdev, xmm->firmware_blp, fwlen))
+		xmgmt_create_blp(xmm);
+	else
+		xrt_err(pdev, "failed to find firmware, giving up: %d", rc);
+	return rc;
+}
+
+static void xmgmt_main_event_cb(struct platform_device *pdev, void *arg)
+{
+	struct xmgmt_main *xmm = platform_get_drvdata(pdev);
+	struct xrt_event *evt = (struct xrt_event *)arg;
+	enum xrt_events e = evt->xe_evt;
+	struct platform_device *leaf;
+	enum xrt_subdev_id id;
+
+	id = evt->xe_subdev.xevt_subdev_id;
+	switch (e) {
+	case XRT_EVENT_POST_CREATION: {
+		if (id == XRT_SUBDEV_DEVCTL && !(xmm->flags & XMGMT_FLAG_DEVCTL_READY)) {
+			leaf = xleaf_get_leaf_by_epname(pdev, XRT_MD_NODE_BLP_ROM);
+			if (leaf) {
+				xmm->flags |= XMGMT_FLAG_DEVCTL_READY;
+				xleaf_put_leaf(pdev, leaf);
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
+		xrt_dbg(pdev, "ignored event %d", e);
+		break;
+	}
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
+	mutex_init(&xmm->lock);
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
+	/* By now, group driver should prevent any inter-leaf call. */
+
+	xrt_info(pdev, "leaving...");
+
+	vfree(xmm->blp_interface_uuids);
+	vfree(xmm->firmware_blp);
+	vfree(xmm->firmware_plp);
+	vfree(xmm->firmware_ulp);
+	xmgmt_region_cleanup_all(pdev);
+	xmgmt_fmgr_remove(xmm->fmgr);
+	sysfs_remove_group(&DEV(pdev)->kobj, &xmgmt_main_attrgroup);
+	return 0;
+}
+
+static int
+xmgmt_mainleaf_call(struct platform_device *pdev, u32 cmd, void *arg)
+{
+	struct xmgmt_main *xmm = platform_get_drvdata(pdev);
+	int ret = 0;
+
+	switch (cmd) {
+	case XRT_XLEAF_EVENT:
+		xmgmt_main_event_cb(pdev, arg);
+		break;
+	case XRT_MGMT_MAIN_GET_AXLF_SECTION: {
+		struct xrt_mgmt_main_get_axlf_section *get =
+			(struct xrt_mgmt_main_get_axlf_section *)arg;
+		const struct axlf *firmware = xmgmt_get_axlf_firmware(xmm, get->xmmigas_axlf_kind);
+
+		if (!firmware) {
+			ret = -ENOENT;
+		} else {
+			ret = xrt_xclbin_get_section(DEV(pdev), firmware,
+						     get->xmmigas_section_kind,
+						     &get->xmmigas_section,
+						     &get->xmmigas_section_size);
+		}
+		break;
+	}
+	case XRT_MGMT_MAIN_GET_VBNV: {
+		char **vbnv_p = (char **)arg;
+
+		*vbnv_p = xmgmt_get_vbnv(pdev);
+		if (!*vbnv_p)
+			ret = -EINVAL;
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
+	struct platform_device *pdev = xleaf_devnode_open(inode);
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
+	xleaf_devnode_close(inode);
+
+	xrt_info(xmm->pdev, "closed");
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
+	ret = xmgmt_process_xclbin(xmm->pdev, xmm->fmgr, axlf, XMGMT_ULP);
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
+	if (xclbin_obj.header.version_major != XMGMT_SUPP_XCLBIN_MAJOR)
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
+	mutex_unlock(&xmm->lock);
+	return result;
+}
+
+static struct xrt_subdev_endpoints xrt_mgmt_main_endpoints[] = {
+	{
+		.xse_names = (struct xrt_subdev_ep_names []){
+			{ .ep_name = XRT_MD_NODE_MGMT_MAIN },
+			{ NULL },
+		},
+		.xse_min_ep = 1,
+	},
+	{ 0 },
+};
+
+static struct xrt_subdev_drvdata xmgmt_main_data = {
+	.xsd_dev_ops = {
+		.xsd_leaf_call = xmgmt_mainleaf_call,
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
+static struct platform_driver xmgmt_main_driver = {
+	.driver	= {
+		.name    = XMGMT_MAIN,
+	},
+	.probe   = xmgmt_main_probe,
+	.remove  = xmgmt_main_remove,
+	.id_table = xmgmt_main_id_table,
+};
+
+int xmgmt_register_leaf(void)
+{
+	return xleaf_register_driver(XRT_SUBDEV_MGMT_MAIN,
+				     &xmgmt_main_driver, xrt_mgmt_main_endpoints);
+}
+
+void xmgmt_unregister_leaf(void)
+{
+	xleaf_unregister_driver(XRT_SUBDEV_MGMT_MAIN);
+}
diff --git a/drivers/fpga/xrt/mgmt/xmgnt.h b/drivers/fpga/xrt/mgmt/xmgnt.h
new file mode 100644
index 000000000000..9d7c11194745
--- /dev/null
+++ b/drivers/fpga/xrt/mgmt/xmgnt.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2021 Xilinx, Inc.
+ *
+ * Authors:
+ *	Lizhi Hou <Lizhi.Hou@xilinx.com>
+ *	Cheng Zhen <maxz@xilinx.com>
+ */
+
+#ifndef _XMGMT_XMGNT_H_
+#define _XMGMT_XMGNT_H_
+
+#include <linux/platform_device.h>
+#include "xmgmt-main.h"
+
+struct fpga_manager;
+int xmgmt_process_xclbin(struct platform_device *pdev,
+			 struct fpga_manager *fmgr,
+			 const struct axlf *xclbin,
+			 enum provider_kind kind);
+void xmgmt_region_cleanup_all(struct platform_device *pdev);
+
+int xmgmt_hot_reset(struct platform_device *pdev);
+
+/* Getting dtb for specified group. Caller should vfree returned dtb .*/
+char *xmgmt_get_dtb(struct platform_device *pdev, enum provider_kind kind);
+char *xmgmt_get_vbnv(struct platform_device *pdev);
+int xmgmt_get_provider_uuid(struct platform_device *pdev,
+			    enum provider_kind kind, uuid_t *uuid);
+
+int xmgmt_register_leaf(void);
+void xmgmt_unregister_leaf(void);
+
+#endif	/* _XMGMT_XMGNT_H_ */
diff --git a/include/uapi/linux/xrt/xmgmt-ioctl.h b/include/uapi/linux/xrt/xmgmt-ioctl.h
new file mode 100644
index 000000000000..da992e581189
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
+ * Interfaces exposed by *xclmgmt* driver are defined in file, *mgmt-ioctl.h*.
+ * Core functionality provided by *xmgmt* driver is described in the following table:
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


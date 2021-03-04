Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93E5032CD69
	for <lists+linux-fpga@lfdr.de>; Thu,  4 Mar 2021 08:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236078AbhCDHL0 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 4 Mar 2021 02:11:26 -0500
Received: from mail-eopbgr770044.outbound.protection.outlook.com ([40.107.77.44]:15015
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236072AbhCDHLC (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 4 Mar 2021 02:11:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jp5HHpXy6xh3DuQAeNX/er5SM7BSS2vU3wVKDkGrMaTaevNm0itbE/N2Is2iA+Z2KatB7H/+C3weXQwPEZ6VI2DFBkG3uGy5O6Xd7+vgu50H2ZP0ChnKRQ5upOd556T6f+/QpqhkUIS06oJvtgpM+3SV4IbdRohhxqVSbY/gJQTPSW8U/41L9XMBKFngZZbwjcd86EtJG8rWeAaPFjFqjI/gH7jUHIOVVtwsk6yH3esEvV+3Btk7SSlPqOzD9gULM1Ciogu9Nc1TpxgIcJtmNy2Q7297DQPgFZ1vLf8q41f/Cxz4sKzv0+b0kx3bg0b2Tl7Jnynxek6ZD7IEw+/1ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ed2ls+4ejQAMXXA/JtV3M27GxYigFPEAZIjFH5YgEdY=;
 b=Yaj49DKv/CJLF6MB2yL8+poqMz1RLuoauty+WwJJgBLg6xNPpjA6tE55yW6ZDBCsz76/n0ATPnJtDTkAlVZXC9uFAtpjkR47PnmpcGe2EZQkMYzcW38TdvuWV5kHOOMDM8QvdZDjfjgfCbML4I+etRt028tPnXbzyKLflw/rmTQFJGD2uuj+aAcgiNZVenfMPictH/kD5RGKIYYliRhYJfJJvICdoeRoRgYzdfzqeoEGmRwSqhKXTFHO33M/+02Vf4rghWKaudalReOLBxw3UJj+/iwNkbrvwBFYaHdLjCd/q5+UHSTy1/3r7fM4q2Q0A8FxdQGbcMk+38nRFDRtiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ed2ls+4ejQAMXXA/JtV3M27GxYigFPEAZIjFH5YgEdY=;
 b=LWHjJC39YJeKDFBxC60CHRHsYFbPh7x9T+g+tj6IV/QuA1ZF9vHCyUEH+Vf4f9zOag0NsjhbCaGMmVmjjLGbQnxQqf4xtKwOEHpaB44NHg4X7DFtXlpDi6A4mV2YKGByJk/5Mvlt9ZoUH85caOmoUBD62wZugBf9RwUta18I4RA=
Received: from MN2PR12CA0001.namprd12.prod.outlook.com (2603:10b6:208:a8::14)
 by SA2PR02MB7786.namprd02.prod.outlook.com (2603:10b6:806:14f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.28; Thu, 4 Mar
 2021 07:10:15 +0000
Received: from BL2NAM02FT007.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:a8:cafe::d2) by MN2PR12CA0001.outlook.office365.com
 (2603:10b6:208:a8::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Thu, 4 Mar 2021 07:10:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT007.mail.protection.outlook.com (10.152.77.46) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3890.19 via Frontend Transport; Thu, 4 Mar 2021 07:10:15 +0000
Received: from xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Wed, 3 Mar 2021 23:09:49 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Wed, 3 Mar 2021 23:09:49 -0800
Envelope-to: michal.simek@xilinx.com,
 rajan.vaja@xilinx.com,
 manish.narani@xilinx.com,
 amit.sunil.dhamne@xilinx.com,
 nava.manne@xilinx.com,
 appana.durga.rao@xilinx.com,
 mdf@kernel.org,
 trix@redhat.com,
 robh+dt@kernel.org,
 gregkh@linuxfoundation.org,
 arnd@arndb.de,
 linux-fpga@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 chinnikishore369@gmail.com
Received: from [10.140.6.60] (port=51424 helo=xhdnavam40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <nava.manne@xilinx.com>)
        id 1lHi7I-0003nC-LY; Wed, 03 Mar 2021 23:09:49 -0800
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <mdf@kernel.org>, <trix@redhat.com>, <robh+dt@kernel.org>,
        <michal.simek@xilinx.com>, <gregkh@linuxfoundation.org>,
        <jolly.shah@xilinx.com>, <rajan.vaja@xilinx.com>, <arnd@arndb.de>,
        <manish.narani@xilinx.com>, <amit.sunil.dhamne@xilinx.com>,
        <tejas.patel@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <chinnikishore369@gmail.com>
CC:     Nava kishore Manne <nava.manne@xilinx.com>,
        Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
Subject: [PATCH v3 3/3] fpga: versal-fpga: Add versal fpga manager driver
Date:   Thu, 4 Mar 2021 12:32:24 +0530
Message-ID: <20210304070224.22346-4-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210304070224.22346-1-nava.manne@xilinx.com>
References: <20210304070224.22346-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8a1215b-91f8-4ec1-27c1-08d8dedc8f53
X-MS-TrafficTypeDiagnostic: SA2PR02MB7786:
X-Microsoft-Antispam-PRVS: <SA2PR02MB77869C3494D2BCB0CBF0C5C3C2979@SA2PR02MB7786.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ux/gkmiAmXtrhyul6lvZvHZIkUkgfpiy0BI7wascvFaiMV4W2419Qx3VlQRJNdlvulCNswmFQ93zlosdecR8TvjroHBeGy2pHwI/NFOz2YQHuNztIu1eOYUcge01bErl0JpYBLYOqzzF2jKrOMdX3SWud6RmHZCymu2b3Dn2XVi1ANdZ+3ex2Eiy5AphXTMp3qZAr9wyCf0tu1pWwzcGhoOB6/1W88cnsE4+J5CdGkuzsEEqeai44iTkH42HHd5E78y9azHDngtPbHFrTXYWG7sY7N9UpRFWGV+qAAYFTkhw9JWi18yfvR8+Sfz3ZjsgsfZtjaB0i+d2N2r2vRrZZ4flK2L5/Zbi+D4FHdM8B7XkCAbaJTMwWaPbg0cBnmCv3Tw6elso4G1Qq1eEMu9FmP8+D3MCk87RKiwJLgCY9eoW5kUgLKtbpKM2dl1+V9L614eshIRNXxQK8EUpg7LzEA2lxcuHMaWF3CAZeJgrVgPHGPpjQRbVF0L07lH93DSPua6qlI1X4J8DxIoVIXLT/b3jSZlMyTpQ2Z/1GHgxLJGXBvC9C2I7VELDwSxUaVEOqBj6pyGLmPtq0tdnCitXDOZHFZF8hFFdA2ETsfRvqOQmPUXFzfwyV/jy9EP8h/+bCDkaFV1ElNre/kn7DG1rPv+et1JlmBtH2bYJ+hqegokVvVI5XTIvDl896QvOrGMhl7hfncLmolaKubD+BwDHLXSsoxsfQ2yVdE80PWvaWPrG2RwkSeIGdfbU/06kqNG6
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(396003)(39860400002)(36840700001)(46966006)(8936002)(54906003)(36906005)(8676002)(36756003)(83380400001)(7416002)(426003)(82310400003)(9786002)(82740400003)(316002)(2906002)(356005)(110136005)(7696005)(107886003)(2616005)(5660300002)(1076003)(70586007)(36860700001)(6666004)(186003)(26005)(4326008)(47076005)(7636003)(70206006)(336012)(921005)(478600001)(102446001)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2021 07:10:15.0198
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8a1215b-91f8-4ec1-27c1-08d8dedc8f53
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT007.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR02MB7786
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Add support for Xilinx Versal FPGA manager.

PDI source type can be DDR, OCM, QSPI flash etc..
But driver allocates memory always from DDR, Since driver supports only
DDR source type.

Signed-off-by: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
Changes for v2:
                -Updated the Fpga Mgr registrations call's
                 to 5.11
                -Fixed some minor coding issues as suggested by
                 Moritz.
Changes for v3:
                -Rewritten the Versal fpga Kconfig contents.

 drivers/fpga/Kconfig       |   9 +++
 drivers/fpga/Makefile      |   1 +
 drivers/fpga/versal-fpga.c | 117 +++++++++++++++++++++++++++++++++++++
 3 files changed, 127 insertions(+)
 create mode 100644 drivers/fpga/versal-fpga.c

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index bf85b9a65ec2..c1603c7e1518 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -223,4 +223,13 @@ config FPGA_MGR_ZYNQMP_FPGA
 	  to configure the programmable logic(PL) through PS
 	  on ZynqMP SoC.
 
+config FPGA_MGR_VERSAL_FPGA
+	tristate "Xilinx Versal FPGA"
+	depends on ARCH_ZYNQMP || COMPILE_TEST
+	help
+	  Select this option to enable FPGA manager driver support for
+	  Xilinx Versal SoC. This driver uses the firmware interface to
+	  configure the programmable logic(PL).
+
+	  To compile this as a module, choose M here.
 endif # FPGA
diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
index d8e21dfc6778..40c9adb6a644 100644
--- a/drivers/fpga/Makefile
+++ b/drivers/fpga/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_FPGA_MGR_TS73XX)		+= ts73xx-fpga.o
 obj-$(CONFIG_FPGA_MGR_XILINX_SPI)	+= xilinx-spi.o
 obj-$(CONFIG_FPGA_MGR_ZYNQ_FPGA)	+= zynq-fpga.o
 obj-$(CONFIG_FPGA_MGR_ZYNQMP_FPGA)	+= zynqmp-fpga.o
+obj-$(CONFIG_FPGA_MGR_VERSAL_FPGA)      += versal-fpga.o
 obj-$(CONFIG_ALTERA_PR_IP_CORE)         += altera-pr-ip-core.o
 obj-$(CONFIG_ALTERA_PR_IP_CORE_PLAT)    += altera-pr-ip-core-plat.o
 
diff --git a/drivers/fpga/versal-fpga.c b/drivers/fpga/versal-fpga.c
new file mode 100644
index 000000000000..5744e44f981d
--- /dev/null
+++ b/drivers/fpga/versal-fpga.c
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019-2021 Xilinx, Inc.
+ */
+
+#include <linux/dma-mapping.h>
+#include <linux/fpga/fpga-mgr.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/string.h>
+#include <linux/firmware/xlnx-zynqmp.h>
+
+/**
+ * struct versal_fpga_priv - Private data structure
+ * @dev:	Device data structure
+ */
+struct versal_fpga_priv {
+	struct device *dev;
+};
+
+static int versal_fpga_ops_write_init(struct fpga_manager *mgr,
+				      struct fpga_image_info *info,
+				      const char *buf, size_t size)
+{
+	return 0;
+}
+
+static int versal_fpga_ops_write(struct fpga_manager *mgr,
+				 const char *buf, size_t size)
+{
+	struct versal_fpga_priv *priv;
+	dma_addr_t dma_addr = 0;
+	char *kbuf;
+	int ret;
+
+	priv = mgr->priv;
+
+	kbuf = dma_alloc_coherent(priv->dev, size, &dma_addr, GFP_KERNEL);
+	if (!kbuf)
+		return -ENOMEM;
+
+	memcpy(kbuf, buf, size);
+
+	wmb(); /* ensure all writes are done before initiate FW call */
+
+	ret = zynqmp_pm_load_pdi(PDI_SRC_DDR, dma_addr);
+
+	dma_free_coherent(priv->dev, size, kbuf, dma_addr);
+
+	return ret;
+}
+
+static int versal_fpga_ops_write_complete(struct fpga_manager *mgr,
+					  struct fpga_image_info *info)
+{
+	return 0;
+}
+
+static enum fpga_mgr_states versal_fpga_ops_state(struct fpga_manager *mgr)
+{
+	return FPGA_MGR_STATE_UNKNOWN;
+}
+
+static const struct fpga_manager_ops versal_fpga_ops = {
+	.state = versal_fpga_ops_state,
+	.write_init = versal_fpga_ops_write_init,
+	.write = versal_fpga_ops_write,
+	.write_complete = versal_fpga_ops_write_complete,
+};
+
+static int versal_fpga_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct versal_fpga_priv *priv;
+	struct fpga_manager *mgr;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = dev;
+	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
+	if (ret < 0) {
+		dev_err(dev, "no usable DMA configuration\n");
+		return ret;
+	}
+
+	mgr = devm_fpga_mgr_create(dev, "Xilinx Versal FPGA Manager",
+				   &versal_fpga_ops, priv);
+	if (!mgr)
+		return -ENOMEM;
+
+	return devm_fpga_mgr_register(dev, mgr);
+}
+
+static const struct of_device_id versal_fpga_of_match[] = {
+	{ .compatible = "xlnx,versal-fpga", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, versal_fpga_of_match);
+
+static struct platform_driver versal_fpga_driver = {
+	.probe = versal_fpga_probe,
+	.driver = {
+		.name = "versal_fpga_manager",
+		.of_match_table = of_match_ptr(versal_fpga_of_match),
+	},
+};
+module_platform_driver(versal_fpga_driver);
+
+MODULE_AUTHOR("Nava kishore Manne <nava.manne@xilinx.com>");
+MODULE_AUTHOR("Appana Durga Kedareswara rao <appanad.durga.rao@xilinx.com>");
+MODULE_DESCRIPTION("Xilinx Versal FPGA Manager");
+MODULE_LICENSE("GPL");
-- 
2.18.0


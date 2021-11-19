Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9F244578A8
	for <lists+linux-fpga@lfdr.de>; Fri, 19 Nov 2021 23:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235003AbhKSW17 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 19 Nov 2021 17:27:59 -0500
Received: from mail-bn8nam12on2057.outbound.protection.outlook.com ([40.107.237.57]:15520
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234745AbhKSW17 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 19 Nov 2021 17:27:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WvRs8+fK6mpAwjmdCa6QOVg41kWLV2QW0N7QVuFxOW3Pcfrl5bJD0N8OU5CVuQ7nZVjScBvhZjA7QBofS6Q5deAhHyjnRXoAOS2VAh/e1yFnX9C8rXw4F0nihVu1y5zO3FDow48f7QLAIklqUILdiFLzrplUAJQcMPhCR09lhvmJrfHWjDXH0x6q3mbBK6S6jPjGmBSpVAUn9bsAQfc8KgLEc245TWCH0Dy77oO0dCxE0OPC0LqtfK6fm49a86mN5Jc81YBLF9s2upHMnXyVRJpd4SgRe1vLb2FHBxzw52BMsGYe2tiYJ40MGpxf30ILFxo8CzPAynHbILA9RSImuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dor8ozB7mx0oWaaCwou5aFQnENTnttIBANnGY2uccQ8=;
 b=KXJ+h3r8fd0YQ+A5/QeBrYEmyDS9viVqCJo2dpJ9mOPvk4mDNu1+aCvLOGL6K6tIU1csGhZHFDkoJowyapDuY5GEjKuwyjfDP+hEuqzO5hMclp1pmOBws0RzsLfVh4oCkrVDKQCunQYaaac3IPG1q1Jvxa6DdUSrBiq9hwZx7hC5lGvUIhMQszH0iQCLRI8vHmGkoOBJ1iZ5hgUvfem+pQrt8A/aFaQWhqY+m5c/s6lGhFVZDYKPld+7+Gmg5E4IWVrJP8PfWwe8WAOIqXGt1VLU0h8F60U3bWpM4+hVHn1l8m2luaj9Ozk00Lw6rXX8Uo0IINfWlMM2f24B4mebtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=infradead.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dor8ozB7mx0oWaaCwou5aFQnENTnttIBANnGY2uccQ8=;
 b=iBmZ+WzvMUaBP/9t7V6KSHvcNj0HUxScsO4uhC1OvreLHs+k5t0RvcuG4q/afX6mA8gCPI+KWe0mSxmK5H5Z/j329y2EkNIy9vHggtmM29TQM5vjLFWW3/JyNb+7TqvLAQ/rFqDQs/ZLsjRohly2TBbVfC6Fz27OFU2zNssOM6c=
Received: from DS7PR05CA0030.namprd05.prod.outlook.com (2603:10b6:5:3b9::35)
 by BYAPR02MB5062.namprd02.prod.outlook.com (2603:10b6:a03:6f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Fri, 19 Nov
 2021 22:24:52 +0000
Received: from DM3NAM02FT031.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:3b9:cafe::cc) by DS7PR05CA0030.outlook.office365.com
 (2603:10b6:5:3b9::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.11 via Frontend
 Transport; Fri, 19 Nov 2021 22:24:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT031.mail.protection.outlook.com (10.13.4.184) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.19 via Frontend Transport; Fri, 19 Nov 2021 22:24:51 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 19 Nov 2021 14:24:50 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 19 Nov 2021 14:24:50 -0800
Envelope-to: dwmw2@infradead.org,
 mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.72.93] (port=38936 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1moCJO-000ANC-Nh; Fri, 19 Nov 2021 14:24:50 -0800
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id ECEAE600147; Fri, 19 Nov 2021 14:24:14 -0800 (PST)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>, <dwmw2@infradead.org>,
        Max Zhen <max.zhen@xilinx.com>
Subject: [PATCH V2 XRT Alveo Infrastructure 4/9] of: create empty of root
Date:   Fri, 19 Nov 2021 14:24:07 -0800
Message-ID: <20211119222412.1092763-5-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211119222412.1092763-1-lizhi.hou@xilinx.com>
References: <20211119222412.1092763-1-lizhi.hou@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 121281a7-92cd-4736-ca61-08d9abab678a
X-MS-TrafficTypeDiagnostic: BYAPR02MB5062:
X-Microsoft-Antispam-PRVS: <BYAPR02MB506286185DA3F40BE54A0365A19C9@BYAPR02MB5062.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jAfEHgx+B9160Mb/DN8mWfV/cXomRauH306W+sy/4NMGdF5V+QoqK50eeSMnIMDe0L6nQ+d0hqO+mluAlytJWqf+v+ElDDBwsu0dAuZb2X90lYTr2WEgNl+dZGZLcMwX+cgXoqLzvNLUK+IFn8UgBlVMRF7iRWgVz3lH4n24VcCcvVpiZt1Ju4j2ylPM3zGYN2wikSgx1C/TFyD+NELOd2uxfuI6ZYxICXnuzNX2OdLyXGm4cHr9l/imLd9mMIK17G/ZGsKmSFMy4Be0y4D+JraYtiDT8cPHY3iMJ1o3LFIwO0pqkRV7ldcZSZ2IlVC7QoMASFqFKPPgOPMJJzGXfA40B7RKhKK1UwQAlD5QTz+KqpSvzhd9glf2YPyJhSjTZJYFxxl6DZE/bkCRCit9DAwCUKOMSoIbC+NNOiV8dnISPFuv7jzGJNmCDo2xLACr/qaA+0H/L0xDLXEQMI5doLVHN8NcQZ7jwUjXTidfSWAjZ16cEATZQqp5jKP1Xucy06zIVutAnQ/2y6tT4m6csHKXjgHfh2mn5yTNbqW7c5eCcAF+3PFGR5CX0++nNDBN7lLTgSuYRTmyYCSeovwHMbluJwUzIcC0GOfS33nr7z0j1JjUHzrx4EshS88fcHNcEqCy/slWd86oh5i/5UEy4/YSPgO8AGicy1yv2KiJAaUaXYJb/bSqZZlN/RlyDQ7kcE4nES8HM+Y9kAc2tCn78g==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(46966006)(36840700001)(36906005)(8936002)(82310400003)(42186006)(26005)(8676002)(508600001)(44832011)(2616005)(54906003)(316002)(6916009)(36756003)(4326008)(5660300002)(426003)(356005)(70586007)(70206006)(83380400001)(107886003)(2906002)(6666004)(36860700001)(1076003)(7636003)(6266002)(186003)(336012)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 22:24:51.3632
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 121281a7-92cd-4736-ca61-08d9abab678a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT031.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5062
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

When OF_FLATTREE is selected and there is not a device tree, create an
empty device tree root node. of/unittest.c code is referenced.

Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
Signed-off-by: Max Zhen <max.zhen@xilinx.com>
Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
---
 drivers/of/Makefile        |  2 +-
 drivers/of/fdt.c           | 20 ++++++++++++++++++++
 drivers/of/fdt_default.dts |  5 +++++
 drivers/of/of_private.h    |  5 +++++
 4 files changed, 31 insertions(+), 1 deletion(-)
 create mode 100644 drivers/of/fdt_default.dts

diff --git a/drivers/of/Makefile b/drivers/of/Makefile
index c13b982084a3..815f5220465b 100644
--- a/drivers/of/Makefile
+++ b/drivers/of/Makefile
@@ -2,7 +2,7 @@
 obj-y = base.o device.o platform.o property.o
 obj-$(CONFIG_OF_KOBJ) += kobj.o
 obj-$(CONFIG_OF_DYNAMIC) += dynamic.o
-obj-$(CONFIG_OF_FLATTREE) += fdt.o
+obj-$(CONFIG_OF_FLATTREE) += fdt.o fdt_default.dtb.o
 obj-$(CONFIG_OF_EARLY_FLATTREE) += fdt_address.o
 obj-$(CONFIG_OF_PROMTREE) += pdt.o
 obj-$(CONFIG_OF_ADDRESS)  += address.o
diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index d64445e43ceb..3d6e4543419e 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -481,6 +481,26 @@ void *of_fdt_unflatten_tree(const unsigned long *blob,
 }
 EXPORT_SYMBOL_GPL(of_fdt_unflatten_tree);
 
+static int __init of_fdt_root_init(void)
+{
+	struct device_node *np;
+
+	if (of_root)
+		return 0;
+
+	if (!of_fdt_unflatten_tree((const unsigned long *)__dtb_fdt_default_begin,
+				   NULL, &of_root)) {
+		pr_warn("%s: unflatten default tree failed\n", __func__);
+		return -ENODATA;
+	}
+
+	for_each_of_allnodes(np)
+		__of_attach_node_sysfs(np);
+
+	return 0;
+}
+late_initcall(of_fdt_root_init);
+
 /* Everything below here references initial_boot_params directly. */
 int __initdata dt_root_addr_cells;
 int __initdata dt_root_size_cells;
diff --git a/drivers/of/fdt_default.dts b/drivers/of/fdt_default.dts
new file mode 100644
index 000000000000..d1f12a76dfc6
--- /dev/null
+++ b/drivers/of/fdt_default.dts
@@ -0,0 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+
+/ {
+};
diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index 631489f7f8c0..47c6bb47ef25 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -41,6 +41,11 @@ extern struct mutex of_mutex;
 extern struct list_head aliases_lookup;
 extern struct kset *of_kset;
 
+#if defined(CONFIG_OF_FLATTREE)
+extern u8 __dtb_fdt_default_begin[];
+extern u8 __dtb_fdt_default_end[];
+#endif
+
 #if defined(CONFIG_OF_DYNAMIC)
 extern int of_property_notify(int action, struct device_node *np,
 			      struct property *prop, struct property *old_prop);
-- 
2.27.0


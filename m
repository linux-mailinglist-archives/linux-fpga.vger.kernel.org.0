Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21E134564CC
	for <lists+linux-fpga@lfdr.de>; Thu, 18 Nov 2021 22:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbhKRVID (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 18 Nov 2021 16:08:03 -0500
Received: from mail-dm6nam11on2041.outbound.protection.outlook.com ([40.107.223.41]:62177
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231667AbhKRVIC (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 18 Nov 2021 16:08:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MTP6CoD+RI5Ow2UmAvUopslPM21i96auIlx8qHPUyUmlvTNWxeOr6a6JB7QCXALCpicqTCWDEMz3zhPSIGJLGhDGzBqZwyQrGNns/jOPtuCUhpx2XBJEjUh1nkaHqYWBnvd/3jXig41A8hIf3qjA81Csu2QEOLyKfD0sH9iLwAf1crspp8D6OgR+qlKPULpIu7ofhyO1PS/CpiQnb1ELwdI5siubXc3aVGWCbbSo/RZAY+5W3HFmrDFb3+yTuFkw8Zg6NsSmVK3wiaTkBLydUixfS7S3CHvPeSK0vrQuSwkou+llLk8yr6Pc6XwFSuLZi2A61ODy9J2/Cni0DT0VIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dor8ozB7mx0oWaaCwou5aFQnENTnttIBANnGY2uccQ8=;
 b=JqhVpVGT/XpAuNcnShlly3n75QkclBdPtHAx3JvAQOB8fr+qScj/cC9krAgoc8HtRRjKbMDoFf0pmBibF/xjRi71nqTcl+SKKr9TZ+oRWZ15hv7WQ5ws/wVcqBLZAEuL87nXsyuSybAkMutJcc0+JXdCDR4dr3vlsRlti+NZ2xW0eZ5WawsgASvvd6n8FU7QN8OEyFogYWCXRli+NmLpmSpdSU8YBVSlbi7H5eVAUdZLZQ37RA4millr6+JBE2i2nPI7l4bT6klOSgZ/I1sV29vp5RaZZTv/gPA/LvnG26Jwni3FroM25TW3gQmYed7KFnrRK3tFiC3+TB0AOhm+zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=infradead.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dor8ozB7mx0oWaaCwou5aFQnENTnttIBANnGY2uccQ8=;
 b=d3BFhpGStij0tb8qcHE3BB2bTbRGx6mD8nuSvlpd2R4ur8YHIT8e1RVlox2Onmehn1w+ZwX8bdSu1Itp+O6ayID3S6tfZY+k1UyiSzGJHgRbA9Hz7xiM9HrQ7C6GMhyUs003OTpSxhOC2Sgk21vwf75URz8q32+jLsiWoXOCxew=
Received: from SN6PR16CA0070.namprd16.prod.outlook.com (2603:10b6:805:ca::47)
 by SA1PR02MB8400.namprd02.prod.outlook.com (2603:10b6:806:1f4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Thu, 18 Nov
 2021 21:04:59 +0000
Received: from SN1NAM02FT0018.eop-nam02.prod.protection.outlook.com
 (2603:10b6:805:ca:cafe::59) by SN6PR16CA0070.outlook.office365.com
 (2603:10b6:805:ca::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend
 Transport; Thu, 18 Nov 2021 21:04:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0018.mail.protection.outlook.com (10.97.5.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.19 via Frontend Transport; Thu, 18 Nov 2021 21:04:59 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 18 Nov 2021 13:04:48 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 18 Nov 2021 13:04:48 -0800
Envelope-to: dwmw2@infradead.org,
 mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.72.93] (port=37760 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1mnoaO-0007HC-KA; Thu, 18 Nov 2021 13:04:48 -0800
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id 105C9600147; Thu, 18 Nov 2021 13:03:36 -0800 (PST)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>, <dwmw2@infradead.org>,
        Max Zhen <max.zhen@xilinx.com>
Subject: [PATCH V1 XRT Alveo Infrastructure 4/9] of: create empty of root
Date:   Thu, 18 Nov 2021 13:03:18 -0800
Message-ID: <20211118210323.1070283-5-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211118210323.1070283-1-lizhi.hou@xilinx.com>
References: <20211118210323.1070283-1-lizhi.hou@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3cb75961-2ea5-4cd1-8a60-08d9aad714bf
X-MS-TrafficTypeDiagnostic: SA1PR02MB8400:
X-Microsoft-Antispam-PRVS: <SA1PR02MB8400924416CD7340519213EAA19B9@SA1PR02MB8400.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zyYZQlkZUxh7piK10PdqPbAg1G5Md5CNCQL8A5NWHlM6O5EyBw26G03oMsoVSgaDXYD5N8YDsjYXz39N9UL8RxZJv3ARODeqZULvUv2puuhUpeKRqZ6zyiQOsWirv1h8f1Kb+fA6rUnfX8PAqn5sZ5TRdMjQsbtD9N+DL+nkxMxfmjOd8CVd5kTdY7sQIQg/FZR/TLDown2Q4mdCzEXsK72eu0X0u1EtAfVKfCvgI9HsjOOq1ZWZs3ibjE0ZaRL69geSjDTRTcBDUZ2MdHxSCF02csJH6vJwXDx8JUO1epB4ZBlNv8fQBcWLLE1z4PEI5BA8waiqkcaZez7100XiJbfKv7JgI2QlC42SMC+NrG6eOye27u+tNUgXCzD62I8jjskzm7i3edpaIoJtxoNifLP9blIUJSlPpGtR+Czz3QbKwRHrLcByG5fpDjFsjXzWFHX6vOzVsZMZWqo7aY3Snxssa3FUjgveO1yguT+ERewD3LhIlQpvCBrtxBkaBWUnCT7TUPc8aJgB1wnEFF9wGC+pWVk3GVHiIJM5jIFuFSJT+DVm5DlxEncZq61kxmDGzlT658Dnsp+zUh4k+FgztTGqLUgB+ANvJYHS4zTqzKNrSbD9F7nbWa8e4Ca5K3rZ9rgnwCRrvnU/PWQFUZCBruI0tTJs8S4tuCIQyKgez1bV4KzG8srEbP6n4vr0lgW25m/+Z8CLWv+a99npyzqL0w==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(46966006)(36840700001)(6916009)(5660300002)(1076003)(186003)(82310400003)(36906005)(26005)(6666004)(70206006)(70586007)(8936002)(8676002)(508600001)(336012)(36860700001)(42186006)(4326008)(6266002)(44832011)(107886003)(2616005)(356005)(47076005)(426003)(2906002)(7636003)(83380400001)(316002)(36756003)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2021 21:04:59.1613
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cb75961-2ea5-4cd1-8a60-08d9aad714bf
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0018.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8400
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


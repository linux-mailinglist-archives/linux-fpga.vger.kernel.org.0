Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0428485BDE
	for <lists+linux-fpga@lfdr.de>; Wed,  5 Jan 2022 23:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245229AbiAEWw1 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 5 Jan 2022 17:52:27 -0500
Received: from mail-bn8nam11on2042.outbound.protection.outlook.com ([40.107.236.42]:28193
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S245199AbiAEWvW (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 5 Jan 2022 17:51:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TECCwkwACSVSflLwU0DH3zXL0Clwt+6hBcQE5qvhFEIAHQaL8PcSFcBE824YwT5r5g2QZ3VTLk9PldBXD8sNjsAkcdyWkBdjwmmeRgt8CqhqDNnH+0O1gerW/kDe7Bp4jU7BhO6+A4bg6iDIdtTuzZTy+kY2E6YyFxrwXJxtirliqioNDeqDmmba1vCskIxayWWowzYFjW8dKnkFpUL4C7xYqny6MjzUP0XQcIU7ciiZaxkU8Ns6MoycTku4U7w8FtAGOkOJaEJippV+uW4QpniiVICz8tBcc5qGEehxzRNCThyHXWJ2/3h6LBN7MiyrDsZJ/sGPGwsYliTGPoLxoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ejP6Jvo/Wo15iIUgV5OqBwRFJigbTzBzOLGPObONoXw=;
 b=cIWRID7pAEMnmwVJ0tWPFbq59Ex/mzDl3F0nAblD65Kn15AM+2zEicSiNHQnrAsK0vNAFRuywMtt1t/hLXzPbAUWR/wT6rUU1kJgOqDpwIXZ1Rr8veSOTicmeQtREL2T7OD5gL2k/ZRPHOpFmQczI85v9y+V58ZTQbaUxr37UGNdwMeJhtd4aSWBO+oX20vJZuBS2aXAO4+yHJZtXF+jgReZKfCEYkrFfl3vK+gAJ+m2WKQyFIGPoazw/D1V4prR/juxUxjzNATHhy3UiIjEKmgsVVksejWYNGt+eT6hGR4x6e/L4P0ox0+f3tgoYzeOgji8gZY4WuEMeh/lihxpWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=infradead.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ejP6Jvo/Wo15iIUgV5OqBwRFJigbTzBzOLGPObONoXw=;
 b=GkthItMIMcs8c6BqE/HADU2JsA+KkIhiRwUXTrO/dhjUdXG4Dzup90a4KVsxxElXtnUwEUbv+a2IX4nG0bfyry8ppHGC9THVxbwcp89j51F0HR0PvZ7D+QRvK0LFIugM9AO3kwONZiH3HK+dZLXTNjUTq3djU4t0SME+aNeKlmw=
Received: from BN6PR2001CA0007.namprd20.prod.outlook.com
 (2603:10b6:404:b4::17) by SA2PR02MB7612.namprd02.prod.outlook.com
 (2603:10b6:806:134::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14; Wed, 5 Jan
 2022 22:51:19 +0000
Received: from BN1NAM02FT039.eop-nam02.prod.protection.outlook.com
 (2603:10b6:404:b4:cafe::de) by BN6PR2001CA0007.outlook.office365.com
 (2603:10b6:404:b4::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7 via Frontend
 Transport; Wed, 5 Jan 2022 22:51:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT039.mail.protection.outlook.com (10.13.2.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4867.7 via Frontend Transport; Wed, 5 Jan 2022 22:51:18 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 5 Jan 2022 14:51:12 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 5 Jan 2022 14:51:12 -0800
Envelope-to: dwmw2@infradead.org,
 mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.72.93] (port=56784 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1n5F7g-000B78-A7; Wed, 05 Jan 2022 14:51:12 -0800
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id 02C88600AD4; Wed,  5 Jan 2022 14:50:22 -0800 (PST)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>, <dwmw2@infradead.org>,
        Max Zhen <max.zhen@xilinx.com>
Subject: [PATCH V4 XRT Alveo Infrastructure 3/5] of: create empty of root
Date:   Wed, 5 Jan 2022 14:50:11 -0800
Message-ID: <20220105225013.1567871-4-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220105225013.1567871-1-lizhi.hou@xilinx.com>
References: <20220105225013.1567871-1-lizhi.hou@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf1b028d-665a-4520-f081-08d9d09de30b
X-MS-TrafficTypeDiagnostic: SA2PR02MB7612:EE_
X-Microsoft-Antispam-PRVS: <SA2PR02MB761254E5DF375D036C556BAFA14B9@SA2PR02MB7612.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zHaGhIIIeP1+z8FkJm5fUtSMhzZNbBsakFCa8lvosUPyJJM6t1PNAi6c6wajxEMAN+b7VgLyni9X2xXc/M+dKEsMMTUknm39nlEGRJ3c9c4jjxwTaUGWOKJ8qoyL+XO2ggWwGYSwnnScu1RSDptwAWMSqr4h+5Z0QrDXc26TIcWKm5ThSnpNeVAARCyayNLUXWYrglyrLjQfATvybfSfsf5rduvlbhFVD/w55sCVzx2iDGhciqE5XBDCT9aeh5rmlZ4Xo9HkrsAOUu7OKgFcHGyq/lPPXq9VD7kKM65xVERsAAmKFNAheuyJKU3g/WcGchY32dwCl7xzcwCCTsaHVuWadBSYgaFTMfxo4P3z7g0yEcVttr7w7pBG3wEJj0aYzPCuaZfGwqOXkHhd57jls8l55FnUrTB01vbIdJSjpQYjTwWxcij7YKu71uYRdUBMsAIvcTaOy4BQVgMsOaTM2ix7o9M9eM6KToEnsMRbo4dhHZq4y2fygaU/ddaOwSMqQ9PP2/SSxOpfX+lQC87JhhZ3z/MviB8cXF7WxyhJ3r7iPQIY58zF7U+4uQSSAy7KHHZ7WvsJFcSGNC4rIIlGO7kkwP8nlrhIw5/Rw0BgC4hZw7eGpM/cNwK0KDHjeqUJW9G7VbTXBGMq3l8AixuIICQQlBJtA6mdNIgE9nz5SFGe46L1HO9tQ8ruujTLT/Pann27sadX4AoKuF17qLAdFA==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(8936002)(36756003)(26005)(186003)(2906002)(54906003)(36860700001)(8676002)(82310400004)(508600001)(47076005)(7636003)(2616005)(44832011)(6666004)(70206006)(356005)(70586007)(1076003)(107886003)(6266002)(336012)(316002)(42186006)(426003)(4326008)(5660300002)(83380400001)(6916009);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 22:51:18.5883
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf1b028d-665a-4520-f081-08d9d09de30b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT039.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR02MB7612
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

When OF_FLATTREE is selected and there is not a device tree, create an
empty device tree root node. of/unittest.c code is referenced.

Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
Signed-off-by: Max Zhen <max.zhen@xilinx.com>
Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
---
 drivers/of/Makefile        |  5 +++
 drivers/of/fdt.c           | 90 ++++++++++++++++++++++++++++++++++++++
 drivers/of/fdt_default.dts |  5 +++
 drivers/of/of_private.h    | 17 +++++++
 drivers/of/unittest.c      | 72 ++----------------------------
 5 files changed, 120 insertions(+), 69 deletions(-)
 create mode 100644 drivers/of/fdt_default.dts

diff --git a/drivers/of/Makefile b/drivers/of/Makefile
index c13b982084a3..a2989055c578 100644
--- a/drivers/of/Makefile
+++ b/drivers/of/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-y = base.o device.o platform.o property.o
+
 obj-$(CONFIG_OF_KOBJ) += kobj.o
 obj-$(CONFIG_OF_DYNAMIC) += dynamic.o
 obj-$(CONFIG_OF_FLATTREE) += fdt.o
@@ -20,4 +21,8 @@ obj-y	+= kexec.o
 endif
 endif
 
+ifndef CONFIG_OF_UNITTEST
+obj-$(CONFIG_OF_FLATTREE) += fdt_default.dtb.o
+endif
+
 obj-$(CONFIG_OF_UNITTEST) += unittest-data/
diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 4546572af24b..66ef9ac97829 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -466,6 +466,96 @@ void *of_fdt_unflatten_tree(const unsigned long *blob,
 }
 EXPORT_SYMBOL_GPL(of_fdt_unflatten_tree);
 
+static int __init of_fdt_root_init(void)
+{
+	struct device_node *dt = NULL, *np;
+	void *fdt = NULL, *fdt_aligned;
+	struct property *prop = NULL;
+	__be32 *val = NULL;
+	int size, rc = 0;
+
+#if !defined(CONFIG_OF_UNITTEST)
+	if (of_root)
+		return 0;
+#endif
+	size = __dtb_fdt_default_end - __dtb_fdt_default_begin;
+
+	fdt = kmalloc(size + FDT_ALIGN_SIZE, GFP_KERNEL);
+	if (!fdt)
+		return -ENOMEM;
+
+	fdt_aligned = PTR_ALIGN(fdt, FDT_ALIGN_SIZE);
+	memcpy(fdt_aligned, __dtb_fdt_default_begin, size);
+
+	if (!of_fdt_unflatten_tree((const unsigned long *)fdt_aligned,
+				   NULL, &dt)) {
+		pr_warn("%s: unflatten default tree failed\n", __func__);
+		kfree(fdt);
+		return -ENODATA;
+	}
+	if (!dt) {
+		pr_warn("%s: empty default tree\n", __func__);
+		kfree(fdt);
+		return -ENODATA;
+	}
+
+	/*
+	 * This lock normally encloses of_resolve_phandles()
+	 */
+	of_overlay_mutex_lock();
+
+	rc = of_resolve_phandles(dt);
+	if (rc) {
+		pr_err("%s: Failed to resolve phandles (rc=%i)\n", __func__, rc);
+		goto failed;
+	}
+
+	if (!of_root) {
+		prop = kcalloc(2, sizeof(*prop), GFP_KERNEL);
+		if (!prop) {
+			rc = -ENOMEM;
+			goto failed;
+		}
+		val = kzalloc(sizeof(*val), GFP_KERNEL);
+		if (!val) {
+			rc = -ENOMEM;
+			goto failed;
+		}
+		*val = cpu_to_be32(sizeof(void *) / sizeof(u32));
+
+		prop->name = "#address-cells";
+		prop->value = val;
+		prop->length = sizeof(u32);
+		of_add_property(dt, prop);
+		prop++;
+		prop->name = "#size-cells";
+		prop->value = val;
+		prop->length = sizeof(u32);
+		of_add_property(dt, prop);
+		of_root = dt;
+		for_each_of_allnodes(np)
+			__of_attach_node_sysfs(np);
+		of_aliases = of_find_node_by_path("/aliases");
+		of_chosen = of_find_node_by_path("/chosen");
+		of_overlay_mutex_unlock();
+pr_info("OF ROOT FLAG %lx\n", of_root->_flags);
+		return 0;
+	}
+
+	unittest_data_add(dt);
+
+	of_overlay_mutex_unlock();
+
+	return 0;
+
+failed:
+	of_overlay_mutex_unlock();
+	kfree(val);
+	kfree(prop);
+	return rc;
+}
+pure_initcall(of_fdt_root_init);
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
index 631489f7f8c0..1ef93bccfdba 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -41,6 +41,18 @@ extern struct mutex of_mutex;
 extern struct list_head aliases_lookup;
 extern struct kset *of_kset;
 
+#if defined(CONFIG_OF_UNITTEST)
+extern u8 __dtb_testcases_begin[];
+extern u8 __dtb_testcases_end[];
+#define __dtb_fdt_default_begin		__dtb_testcases_begin
+#define __dtb_fdt_default_end		__dtb_testcases_end
+void __init unittest_data_add(struct device_node *dt);
+#else
+extern u8 __dtb_fdt_default_begin[];
+extern u8 __dtb_fdt_default_end[];
+static inline void unittest_data_add(struct device_node *dt) {}
+#endif
+
 #if defined(CONFIG_OF_DYNAMIC)
 extern int of_property_notify(int action, struct device_node *np,
 			      struct property *prop, struct property *old_prop);
@@ -84,6 +96,11 @@ static inline void __of_detach_node_sysfs(struct device_node *np) {}
 
 #if defined(CONFIG_OF_RESOLVE)
 int of_resolve_phandles(struct device_node *tree);
+#else
+static inline int of_resolve_phandles(struct device_node *tree)
+{
+	return 0;
+}
 #endif
 
 void __of_phandle_cache_inv_entry(phandle handle);
diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 8c056972a6dd..745f455235cc 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -1402,73 +1402,15 @@ static void attach_node_and_children(struct device_node *np)
  *	unittest_data_add - Reads, copies data from
  *	linked tree and attaches it to the live tree
  */
-static int __init unittest_data_add(void)
+void __init unittest_data_add(struct device_node *dt)
 {
-	void *unittest_data;
-	void *unittest_data_align;
-	struct device_node *unittest_data_node = NULL, *np;
-	/*
-	 * __dtb_testcases_begin[] and __dtb_testcases_end[] are magically
-	 * created by cmd_dt_S_dtb in scripts/Makefile.lib
-	 */
-	extern uint8_t __dtb_testcases_begin[];
-	extern uint8_t __dtb_testcases_end[];
-	const int size = __dtb_testcases_end - __dtb_testcases_begin;
-	int rc;
-	void *ret;
-
-	if (!size) {
-		pr_warn("%s: testcases is empty\n", __func__);
-		return -ENODATA;
-	}
-
-	/* creating copy */
-	unittest_data = kmalloc(size + FDT_ALIGN_SIZE, GFP_KERNEL);
-	if (!unittest_data)
-		return -ENOMEM;
-
-	unittest_data_align = PTR_ALIGN(unittest_data, FDT_ALIGN_SIZE);
-	memcpy(unittest_data_align, __dtb_testcases_begin, size);
-
-	ret = of_fdt_unflatten_tree(unittest_data_align, NULL, &unittest_data_node);
-	if (!ret) {
-		pr_warn("%s: unflatten testcases tree failed\n", __func__);
-		kfree(unittest_data);
-		return -ENODATA;
-	}
-	if (!unittest_data_node) {
-		pr_warn("%s: testcases tree is empty\n", __func__);
-		kfree(unittest_data);
-		return -ENODATA;
-	}
-
-	/*
-	 * This lock normally encloses of_resolve_phandles()
-	 */
-	of_overlay_mutex_lock();
-
-	rc = of_resolve_phandles(unittest_data_node);
-	if (rc) {
-		pr_err("%s: Failed to resolve phandles (rc=%i)\n", __func__, rc);
-		of_overlay_mutex_unlock();
-		return -EINVAL;
-	}
-
-	if (!of_root) {
-		of_root = unittest_data_node;
-		for_each_of_allnodes(np)
-			__of_attach_node_sysfs(np);
-		of_aliases = of_find_node_by_path("/aliases");
-		of_chosen = of_find_node_by_path("/chosen");
-		of_overlay_mutex_unlock();
-		return 0;
-	}
+	struct device_node *np;
 
 	EXPECT_BEGIN(KERN_INFO,
 		     "Duplicate name in testcase-data, renamed to \"duplicate-name#1\"");
 
 	/* attach the sub-tree to live tree */
-	np = unittest_data_node->child;
+	np = dt->child;
 	while (np) {
 		struct device_node *next = np->sibling;
 
@@ -1479,10 +1421,6 @@ static int __init unittest_data_add(void)
 
 	EXPECT_END(KERN_INFO,
 		   "Duplicate name in testcase-data, renamed to \"duplicate-name#1\"");
-
-	of_overlay_mutex_unlock();
-
-	return 0;
 }
 
 #ifdef CONFIG_OF_OVERLAY
@@ -3258,7 +3196,6 @@ static inline __init void of_unittest_overlay_high_level(void) {}
 static int __init of_unittest(void)
 {
 	struct device_node *np;
-	int res;
 
 	pr_info("start of unittest - you will see error messages\n");
 
@@ -3267,9 +3204,6 @@ static int __init of_unittest(void)
 	if (IS_ENABLED(CONFIG_UML))
 		unittest_unflatten_overlay_base();
 
-	res = unittest_data_add();
-	if (res)
-		return res;
 	if (!of_aliases)
 		of_aliases = of_find_node_by_path("/aliases");
 
-- 
2.27.0


Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C391346816F
	for <lists+linux-fpga@lfdr.de>; Sat,  4 Dec 2021 01:41:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383862AbhLDAob (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 3 Dec 2021 19:44:31 -0500
Received: from mail-mw2nam12on2079.outbound.protection.outlook.com ([40.107.244.79]:50658
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1383842AbhLDAoa (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 3 Dec 2021 19:44:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GC/DdzTUSpquLzPypBxgW+JsLdfOfvg5QWes2DbOkdg0JHkV1yzyOWBgrNxu53stS3C2+Hs3pELxMXtMZZkmjTdn7ksCS942XBoRSCBygDwHgI1XlzsfvVUP93ZRol29WGdtnauBmS5NkdDgoWQXfW8+QgiuCGEzfYXhevIuNTJSR2WtTIZIvBuZLuBgiHys6TwyK4w6pYEtqQqAJNkAPSkeobEty/4s/Dk7g/lZJx2DKa0g1Xm+DG2Fc5gWdGeu720GfV2xnHB2VhmbnMF6oZm0pqYE9hRuO6sI8VttCAWxPZtxDpfURGTseBH/X9WUsuP/ZwTpycgtVTOfDLG0ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iRCZPXORRD7MeK847sKb0QE6TnICYFsC7tSOTlwDDFg=;
 b=FjByZ44p6gcpp/3eGpdZ/E2Y2akoy3cuInAbFMfwOhTujj5J2OO9BfSUjyb9P2qt6GdR9WTyQtQu7qaaqH6it1sReol0Mpj5fg8wGLUR8czTKkBU1Zm40s7EgJjNYiE4b26Hq6pSAJ/SiwM/Z7sOBVeAEdX17bH6wBA9qSMIi5XzO/AMcMkxdJQu2LvnFEi2l1K+UVT6y2Q9TNG/USxoUVPNvaT9FFEn+iaMR/aMKctfXtvQ75+yidp+piV+GRkJKabqd5BzHaH0d/AiAymBNkz98HsuPeGnK1AbncwPMfw3VUaJYT4PwwoMSzOnpUXVAgdUDWlhY6j5tZ0kUUiEwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=infradead.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iRCZPXORRD7MeK847sKb0QE6TnICYFsC7tSOTlwDDFg=;
 b=RxKqNop9t7TliR6Feku619lPv636T8AamDTpy/bgxT8N//0bNoq0d/6P5nzWg/Kw+j9GI64yzRcd46b8rQiJmtrkLYmQ3t39wuKBCB8kJp7vILUi/Jc17Ms20oPAwkkwWnxdTM/JNyfv8FfKpU1p8mpQW5P7uYUHzfq6pJAVZQI=
Received: from BN9PR03CA0343.namprd03.prod.outlook.com (2603:10b6:408:f6::18)
 by BY5PR02MB6737.namprd02.prod.outlook.com (2603:10b6:a03:209::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.14; Sat, 4 Dec
 2021 00:41:04 +0000
Received: from BN1NAM02FT009.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:f6:cafe::64) by BN9PR03CA0343.outlook.office365.com
 (2603:10b6:408:f6::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend
 Transport; Sat, 4 Dec 2021 00:41:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT009.mail.protection.outlook.com (10.13.2.127) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Sat, 4 Dec 2021 00:41:02 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 3 Dec 2021 16:40:51 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 3 Dec 2021 16:40:51 -0800
Envelope-to: dwmw2@infradead.org,
 mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.72.93] (port=55516 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1mtJ6h-000Dd4-0Z; Fri, 03 Dec 2021 16:40:51 -0800
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id 6589A600850; Fri,  3 Dec 2021 16:40:02 -0800 (PST)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>, <dwmw2@infradead.org>,
        Max Zhen <max.zhen@xilinx.com>
Subject: [PATCH V3 XRT Alveo Infrastructure 3/8] of: create empty of root
Date:   Fri, 3 Dec 2021 16:39:52 -0800
Message-ID: <20211204003957.1448567-4-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211204003957.1448567-1-lizhi.hou@xilinx.com>
References: <20211204003957.1448567-1-lizhi.hou@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e2db2ac-fbcf-45e4-5d5d-08d9b6bec000
X-MS-TrafficTypeDiagnostic: BY5PR02MB6737:
X-Microsoft-Antispam-PRVS: <BY5PR02MB6737602A9F76A4A66BAFB013A16B9@BY5PR02MB6737.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iqMpEpd+KPe6u86POBua50bqwhk4WeV+fEIps+lHkZ4tt9bgKGNJ7MHkpD1c+s1vhAMh0KcF5a82OdSTpVLGyAbUkHYQNRgiTjsKtcKi+z73dRkBVU8Lq8110KxThrKDHN9/m0ODyl+FpzOhhosLBpS4QBnRPbrs13DpjsVwr+gEvN6ojyxPRZBAZ/0AQ8Pi5phr8QXzKmbqh3ZdkbLjan5ah30jhCT2qmTb+MXPZ2GR5Mf/+5VJ1CM5GeOclK5uGMd7F5e0GuhGb4+w5sN8Lv2O3kulm0IX3/MpelpmW0AIWO9owMQAIV/5wQZ1f6Xfz2SkAVzqZnLYV4ZQay6fUhNuyPKpCRcek9RxcFXFlP53eHSKAQIg3BZ8y/RYF0ZYKKHco7ceSH3VQyp6702IgMX/fCbcrNSyYSlwkXF02yMPgdEr8Kg5/eNiyRG71iA9fH4IK7IF2P4tCpzTmZaQ3cczLlnyAJ+VmtI1wHwlSQLFzXsOGR6Cv9cSYLp54wNBAOoRvmhE4DhoOOOD7cyOlAEzHhUPvBtW/5PPt/C/w8fgV7lhrigNWJYMEwqkz2sGQ/IizMuS+WD0kxOYKqD4AO9wGPdi8ZtM/Q6BrdtwqXJd52oc+w3ANcWapIKnYrflo+tO2AZJRlwynLsyP6amQc84R480YMqvmyBiVqcB8lCKpIsFxJuq3sDKNCkgfl4Bqaz3kLQzrNUAFwlPgT8+8Q==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(36840700001)(46966006)(82310400004)(6916009)(7636003)(186003)(356005)(8936002)(336012)(1076003)(2906002)(4326008)(107886003)(426003)(83380400001)(36860700001)(44832011)(36756003)(6666004)(54906003)(26005)(508600001)(6266002)(5660300002)(8676002)(2616005)(47076005)(70206006)(42186006)(70586007)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2021 00:41:02.9520
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e2db2ac-fbcf-45e4-5d5d-08d9b6bec000
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT009.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6737
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
 drivers/of/fdt.c           | 61 +++++++++++++++++++++++++++++++++
 drivers/of/fdt_default.dts |  5 +++
 drivers/of/of_private.h    | 15 ++++++++
 drivers/of/unittest.c      | 70 ++------------------------------------
 5 files changed, 89 insertions(+), 67 deletions(-)
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
index 4546572af24b..0b3577f08e1d 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -466,6 +466,67 @@ void *of_fdt_unflatten_tree(const unsigned long *blob,
 }
 EXPORT_SYMBOL_GPL(of_fdt_unflatten_tree);
 
+static int __init of_fdt_root_init(void)
+{
+	struct device_node *dt = NULL, *np;
+	void *fdt, *fdt_aligned;
+	int size, rc;
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
+		of_overlay_mutex_unlock();
+		return -EINVAL;
+	}
+
+	if (!of_root) {
+		of_root = dt;
+		for_each_of_allnodes(np)
+			__of_attach_node_sysfs(np);
+		of_aliases = of_find_node_by_path("/aliases");
+		of_chosen = of_find_node_by_path("/chosen");
+		of_overlay_mutex_unlock();
+		return 0;
+	}
+
+	unittest_data_add(dt);
+
+	of_overlay_mutex_unlock();
+
+	return 0;
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
index 631489f7f8c0..af74ef1185be 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -41,6 +41,21 @@ extern struct mutex of_mutex;
 extern struct list_head aliases_lookup;
 extern struct kset *of_kset;
 
+#if defined(CONFIG_OF_UNITTEST)
+extern u8 __dtb_testcases_begin[];
+extern u8 __dtb_testcases_end[];
+#define __dtb_fdt_default_begin		__dtb_testcases_begin
+#define __dtb_fdt_default_end		__dtb_testcases_end
+int __init unittest_data_add(struct device_node *dt);
+#else
+extern u8 __dtb_fdt_default_begin[];
+extern u8 __dtb_fdt_default_end[];
+static inline int unittest_data_add(struct device_node *dt)
+{
+	return 0;
+}
+#endif
+
 #if defined(CONFIG_OF_DYNAMIC)
 extern int of_property_notify(int action, struct device_node *np,
 			      struct property *prop, struct property *old_prop);
diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 8c056972a6dd..bc0b3184a6ce 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -1402,73 +1402,15 @@ static void attach_node_and_children(struct device_node *np)
  *	unittest_data_add - Reads, copies data from
  *	linked tree and attaches it to the live tree
  */
-static int __init unittest_data_add(void)
+int __init unittest_data_add(struct device_node *dt)
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
 
@@ -1480,8 +1422,6 @@ static int __init unittest_data_add(void)
 	EXPECT_END(KERN_INFO,
 		   "Duplicate name in testcase-data, renamed to \"duplicate-name#1\"");
 
-	of_overlay_mutex_unlock();
-
 	return 0;
 }
 
@@ -3258,7 +3198,6 @@ static inline __init void of_unittest_overlay_high_level(void) {}
 static int __init of_unittest(void)
 {
 	struct device_node *np;
-	int res;
 
 	pr_info("start of unittest - you will see error messages\n");
 
@@ -3267,9 +3206,6 @@ static int __init of_unittest(void)
 	if (IS_ENABLED(CONFIG_UML))
 		unittest_unflatten_overlay_base();
 
-	res = unittest_data_add();
-	if (res)
-		return res;
 	if (!of_aliases)
 		of_aliases = of_find_node_by_path("/aliases");
 
-- 
2.27.0


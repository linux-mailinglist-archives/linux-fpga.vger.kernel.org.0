Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59C122C76A9
	for <lists+linux-fpga@lfdr.de>; Sun, 29 Nov 2020 00:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725839AbgK1X7g (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 28 Nov 2020 18:59:36 -0500
Received: from mail-bn8nam12on2080.outbound.protection.outlook.com ([40.107.237.80]:50048
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727281AbgK1X7g (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sat, 28 Nov 2020 18:59:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bPLj0+uop1uXC7EO9IlUttfzd3C/gB0tRju+yV7moCyxmAZMp8/Rhv+ISaHgzhNv1PUp9V70KItBsn5DuMR+v2B4zTmscWFPkK5WDjnAfV58EMYbGHrr9lljDjqNEbJQ7xE+NP2aaZk3Ra4GlYzOP5sIqkJbM0i1ZQbrufFg6qV1+RWVJ3LwLwUjiq9iBttOscGSjz7MIpl/5VKzHSX/NIYS4ikHOfVD4Dl5HKbGobHqTyLoA5TBOwCUJo0rL+WkJbXVklV98mG3zW+0tJUs7n1eAP+iFLT4C1ShMVXya+UgsXjcW9ehK4kewl71QLMSdhL9IPw/Hvz1My9Ld2AKIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/IaLdn4I0OC3CxvpS5Ab3JG/+igJLoj/oHs9GxEfuDY=;
 b=Kr+ddj3D0BX4PknWHO7LSp65qIurWL524x3yJY7w0DcT7527g6ZyOLZbuOLEaWiy1OCJ7dDhFQXK/766NoDFbM454I/0OOxs3uZOG3fk3oAHIRoCAirmS40KaEcpwEpwuYMShDvz4k0upOCTdIzIU6Yn6N4duB+0//CE/8qNiltORpOHgS3WfO/o+YVCCs5ZRrwFoHGmqAVuIG9dxXnjK2qaZCGocsrg17otTUjPAF1MpALMIdsvpypDgsnJ8RzMHEZW18W4yVFmFq4b7++fDTmoE8ob8K8f12a9tuaLX8COpU2hcpGcM1aqW8LOX3ET6drIiBFX+vVzM2xeQXHVRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/IaLdn4I0OC3CxvpS5Ab3JG/+igJLoj/oHs9GxEfuDY=;
 b=nu7fogrgBi/8xyZPl1YV0nCVRgtCR8YVeFpH0bns8toBr45BU3JUlqBIUoR9jXgTEVaVtfSNuhA11H3M35eTBSZZ1+mPC0bkWBi5JHcD/3IhbHSJWTMHWx+Y+FKqfPuV0MezbTozs5XIQM0Qvnjd85R+EBBEoLc/yOFJMbCL638=
Received: from BL1PR13CA0453.namprd13.prod.outlook.com (2603:10b6:208:2c4::8)
 by DM6PR02MB6057.namprd02.prod.outlook.com (2603:10b6:5:1fe::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Sat, 28 Nov
 2020 23:58:42 +0000
Received: from BL2NAM02FT053.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:2c4:cafe::c2) by BL1PR13CA0453.outlook.office365.com
 (2603:10b6:208:2c4::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.8 via Frontend
 Transport; Sat, 28 Nov 2020 23:58:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT053.mail.protection.outlook.com (10.152.76.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3611.27 via Frontend Transport; Sat, 28 Nov 2020 23:58:42 +0000
Received: from xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Sat, 28 Nov 2020 15:58:41 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Sat, 28 Nov 2020 15:58:41 -0800
Envelope-to: michal.simek@xilinx.com,
 sonal.santan@xilinx.com,
 lizhih@xilinx.com,
 maxz@xilinx.com,
 stefanos@xilinx.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.72.212] (port=45040 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <sonal.santan@xilinx.com>)
        id 1kjA6z-0003SQ-IU; Sat, 28 Nov 2020 15:58:41 -0800
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 6354)
        id 32B03600039; Sat, 28 Nov 2020 15:57:35 -0800 (PST)
From:   Sonal Santan <sonal.santan@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Sonal Santan <sonal.santan@xilinx.com>,
        <linux-fpga@vger.kernel.org>, <maxz@xilinx.com>,
        <lizhih@xilinx.com>, <michal.simek@xilinx.com>,
        <stefanos@xilinx.com>, <devicetree@vger.kernel.org>
Subject: [PATCH Xilinx Alveo libfdt prep 1/1] Export subset of libfdt symbols for use by other drivers.
Date:   Sat, 28 Nov 2020 15:56:59 -0800
Message-ID: <20201128235659.24679-2-sonals@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201128235659.24679-1-sonals@xilinx.com>
References: <20201128235659.24679-1-sonals@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c91561f-7835-43af-f83a-08d893f988f1
X-MS-TrafficTypeDiagnostic: DM6PR02MB6057:
X-Microsoft-Antispam-PRVS: <DM6PR02MB60578BC56B1598194BE4146BBBF70@DM6PR02MB6057.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /H6tPKWRkhcpy4aSHfB9xzygxDa/xamFE6ZrlvU3LbImkM1AvPpvEpaiXNwvTEPo7iuespWveOrkBNzBc7Rt66ERIT8C6veoWxZwA7oL2newb5df+QSBWqM/iqDrl2vCkmejYjHv87B7UgZd8Op76hXVM7ah27s6pql8YU3C8yicyMV4Faux8J/ymMoZ9+O0TyyIePnL/iONZVETaP3UKUkHvcZxRS51LVoIzAx4hIEh0a/gOupG7y9tDVc63CUT7i4mfF+q1X1Wg2Rfi+h1WFaKo+YxAmhgc0c+ske6ktoj0EK/GraCHWZeCm/zGwbYUUGLeuuT53FtdaJasA5jEtvE7ZRe76bi7+LRlCXLcFr/MAqmI1uxpNtD69Fb48EprPlC8V9E3FVK9CYHgklhDA==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(136003)(39850400004)(46966005)(42186006)(82740400003)(2906002)(54906003)(36906005)(450100002)(1076003)(316002)(6266002)(47076004)(82310400003)(36756003)(356005)(7636003)(70206006)(5660300002)(6666004)(478600001)(70586007)(336012)(6916009)(26005)(8936002)(186003)(4326008)(44832011)(8676002)(2616005)(426003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2020 23:58:42.5204
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c91561f-7835-43af-f83a-08d893f988f1
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT053.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6057
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Sonal Santan <sonal.santan@xilinx.com>

Some drivers may want to use device tree as metadata format to discover HW
subsystems behind PCIe BAR. This is particularly useful for PCIe FPGA
devices.

Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
---
 lib/fdt.c            |  6 ++++++
 lib/fdt_empty_tree.c |  3 +++
 lib/fdt_ro.c         | 11 +++++++++++
 lib/fdt_rw.c         |  6 ++++++
 4 files changed, 26 insertions(+)

diff --git a/lib/fdt.c b/lib/fdt.c
index 97f20069fc37..9747513b50e7 100644
--- a/lib/fdt.c
+++ b/lib/fdt.c
@@ -1,2 +1,8 @@
 #include <linux/libfdt_env.h>
+#include <linux/export.h>
 #include "../scripts/dtc/libfdt/fdt.c"
+
+EXPORT_SYMBOL_GPL(fdt_next_node);
+EXPORT_SYMBOL_GPL(fdt_first_subnode);
+EXPORT_SYMBOL_GPL(fdt_next_subnode);
+EXPORT_SYMBOL_GPL(fdt_subnode_offset);
diff --git a/lib/fdt_empty_tree.c b/lib/fdt_empty_tree.c
index 5d30c58150ad..3dab578c9d22 100644
--- a/lib/fdt_empty_tree.c
+++ b/lib/fdt_empty_tree.c
@@ -1,2 +1,5 @@
 #include <linux/libfdt_env.h>
+#include <linux/export.h>
 #include "../scripts/dtc/libfdt/fdt_empty_tree.c"
+
+EXPORT_SYMBOL_GPL(fdt_create_empty_tree);
diff --git a/lib/fdt_ro.c b/lib/fdt_ro.c
index f73c04ea7be4..ec96cf3d0d7a 100644
--- a/lib/fdt_ro.c
+++ b/lib/fdt_ro.c
@@ -1,2 +1,13 @@
 #include <linux/libfdt_env.h>
+#include <linux/export.h>
 #include "../scripts/dtc/libfdt/fdt_ro.c"
+
+EXPORT_SYMBOL_GPL(fdt_getprop_by_offset);
+EXPORT_SYMBOL_GPL(fdt_node_check_compatible);
+EXPORT_SYMBOL_GPL(fdt_get_name);
+EXPORT_SYMBOL_GPL(fdt_next_property_offset);
+EXPORT_SYMBOL_GPL(fdt_getprop);
+EXPORT_SYMBOL_GPL(fdt_node_offset_by_compatible);
+EXPORT_SYMBOL_GPL(fdt_parent_offset);
+EXPORT_SYMBOL_GPL(fdt_stringlist_get);
+EXPORT_SYMBOL_GPL(fdt_first_property_offset);
diff --git a/lib/fdt_rw.c b/lib/fdt_rw.c
index 0c1f0f4a4b13..ec3939ed3d7d 100644
--- a/lib/fdt_rw.c
+++ b/lib/fdt_rw.c
@@ -1,2 +1,8 @@
 #include <linux/libfdt_env.h>
+#include <linux/export.h>
 #include "../scripts/dtc/libfdt/fdt_rw.c"
+
+EXPORT_SYMBOL_GPL(fdt_del_node);
+EXPORT_SYMBOL_GPL(fdt_add_subnode);
+EXPORT_SYMBOL_GPL(fdt_pack);
+EXPORT_SYMBOL_GPL(fdt_setprop);
-- 
2.17.1


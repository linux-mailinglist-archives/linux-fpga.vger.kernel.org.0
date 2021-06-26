Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 872E23B4F4E
	for <lists+linux-fpga@lfdr.de>; Sat, 26 Jun 2021 17:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbhFZPzp (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 26 Jun 2021 11:55:45 -0400
Received: from mail-mw2nam12on2066.outbound.protection.outlook.com ([40.107.244.66]:61313
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230104AbhFZPzn (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sat, 26 Jun 2021 11:55:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OWuzd1FTBp0Ab+nw41IzIuLigorv7bm8MLKjSOQ/wFtquCyhHGApBn5UTEPGA5YeUamz7mj5A7naO+DG+BjIG67qtJRA5jgMim8SQv+cCvbVuM+qAm3qR6CpTnSknkRI78CPwiDnvImLhopQoWwqBVVX+viO7H+rAsPLX/CHL66adZ0kgApOSBQuD7TmKkkXJ0NzDUhneKAeyuo6jvrkQwlGP4p0sTsrXV4qJOmxfUf3kSRqT/Ipjy49tJRGY49MLPMCdrH/J86nlarx0bBWPwzwbB5qiibySoKFXs0lhSu0hahKRmdWpMlqRp3kQZS8xtcDk/KYchQ+BBaXATv5Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5QCTNueeSm3Cq8bHj+O+uvcEw97uH5QOXpgQWGWFLi4=;
 b=YGW3WA6mlv2k1OuShOkcGRGF8HdUl127SNxQOQsD/fRXFQPV86NvLkehFRrKwGqFydLNI8327+HBnTxGZMviBdPJzg6zSu32SpJRmowJTskTmgysem2zG+WjJLL5WdjqHistszsE4P7ziFbKr7b4iYlxYFo+XVDITpYZFQXy25R8S68ISSnlcW0RY+c1Slo9ZPsxFqJcCHSGiJsOB97yfeoxvigqppYK6hlQq8kWUJXH4rizZr27CbQEROaEpmfFp/XmJy1aiGqyyGjPdSawLzZ1r5bI+H+OUOjd3/U3eXfGDyCZlL1kPLhgveau5JkjGOwHPfFVP8s5uOLKZfBvVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5QCTNueeSm3Cq8bHj+O+uvcEw97uH5QOXpgQWGWFLi4=;
 b=BmJRur+fOTBpXUnZofnKGdQ7pV0GJBNdnIjojVsRNxL/CcCJmZ8SICqxWLfgR8ga9hTVeqbY5bPAU+DSD8bvLeB9OO2cSVZxBOP+GV7ElxAHHG9g02t4cG6zYHmO7KMvfynxGu9M9pC3atsE6PfR1CSOacVc9d5PQjzUc5E2M90=
Received: from DM5PR08CA0044.namprd08.prod.outlook.com (2603:10b6:4:60::33) by
 DM5PR02MB2729.namprd02.prod.outlook.com (2603:10b6:3:107::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.23; Sat, 26 Jun 2021 15:53:19 +0000
Received: from DM3NAM02FT008.eop-nam02.prod.protection.outlook.com
 (2603:10b6:4:60:cafe::f6) by DM5PR08CA0044.outlook.office365.com
 (2603:10b6:4:60::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend
 Transport; Sat, 26 Jun 2021 15:53:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT008.mail.protection.outlook.com (10.13.5.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4264.18 via Frontend Transport; Sat, 26 Jun 2021 15:53:19 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 26 Jun 2021 08:53:08 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Sat, 26 Jun 2021 08:53:08 -0700
Envelope-to: git@xilinx.com,
 robh+dt@kernel.org,
 mdf@kernel.org,
 trix@redhat.com,
 arnd@arndb.de,
 gregkh@linuxfoundation.org,
 zou_wei@huawei.com,
 iwamatsu@nigauri.org,
 devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 chinnikishore369@gmail.com
Received: from [10.140.6.60] (port=59432 helo=xhdnavam40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <nava.manne@xilinx.com>)
        id 1lxAcE-0000uY-OA; Sat, 26 Jun 2021 08:53:07 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <robh+dt@kernel.org>, <michal.simek@xilinx.com>, <mdf@kernel.org>,
        <trix@redhat.com>, <nava.manne@xilinx.com>, <arnd@arndb.de>,
        <rajan.vaja@xilinx.com>, <gregkh@linuxfoundation.org>,
        <amit.sunil.dhamne@xilinx.com>, <tejas.patel@xilinx.com>,
        <zou_wei@huawei.com>, <lakshmi.sai.krishna.potthuri@xilinx.com>,
        <ravi.patel@xilinx.com>, <iwamatsu@nigauri.org>,
        <wendy.liang@xilinx.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-fpga@vger.kernel.org>,
        <git@xilinx.com>, <chinnikishore369@gmail.com>
CC:     Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
Subject: [PATCH v8 2/5] dt-bindings: fpga: Add binding doc for versal fpga manager
Date:   Sat, 26 Jun 2021 21:22:45 +0530
Message-ID: <20210626155248.5004-3-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210626155248.5004-1-nava.manne@xilinx.com>
References: <20210626155248.5004-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a35e3e5a-1f77-4a90-7496-08d938ba8523
X-MS-TrafficTypeDiagnostic: DM5PR02MB2729:
X-Microsoft-Antispam-PRVS: <DM5PR02MB2729ACFB695E9720EC1C8A48C2059@DM5PR02MB2729.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FLRaxyNeKistVU2v1CQOz+/hYDhQHac9htgZv3PGzNmz8Y0OMHXY4QfeiLTZ?=
 =?us-ascii?Q?WrzvOqq+ywK9046QWt7eJLKuL27ginyTOHPdVtN16hjpVgSImuGT4QHxCQcm?=
 =?us-ascii?Q?IFyrmjHtsYS7tbtVqanYlAwhgJ+xO/+g1Ncc7Bn0aW96EXc3lG14jBosDTMv?=
 =?us-ascii?Q?bciA1BMHhCqxHbtWLgGguNWcofL3CQUSyxQUBS4n6nxqzaSuTVKZeLF6wpFJ?=
 =?us-ascii?Q?+6J3fYF2i7g1PR/FfJetUVxIq8CUiLXemAcee27irTuaGn0A8vdflgmLAYUy?=
 =?us-ascii?Q?ihEKGhRU5kMNMpoYX6LdmR/8JByDcQ+uQr4Zst+SagAxkBnPQf5b/1l27Yfk?=
 =?us-ascii?Q?9PtfAD6ZQQNHsoZsH08P40HDG/qKC3obuu8uP8htxaPtTF2mZREMIevlYpNn?=
 =?us-ascii?Q?wFLvhYgC/KdbLVr8xuTevgxplHKpAMGyoujQfYZ72d2FScjWdcfqoPzwzCR0?=
 =?us-ascii?Q?TuYR7aJigwoDWPNDcS+UgDiovwuF46kVyxkJNvpIKwMGauyNyicvcXU5Tkx4?=
 =?us-ascii?Q?ZjPMVu2JZpLjg2hNQwe5LD+sjCFS/Rpfzi7+i872Vjk5psJC0qK0gyzg+Adt?=
 =?us-ascii?Q?v4714uAjUrW5aiUXeaEFL3LGH35w/lAkqhlwQNdY+6rF6tR68+jFRJUwA4Zv?=
 =?us-ascii?Q?Ao+Bh5E37jui63dksD2ww2Vr//vDJcH5S8lyZX2jP13x9hoEvBLi5iCuMPwZ?=
 =?us-ascii?Q?+rlFmQf/Pftye2995dZER5vvy8xBHQJQ0+TTPfvkUZoYUbk0GhQ6qjzAz9RG?=
 =?us-ascii?Q?ER5G7WQFyB62i4t+HoCxmA4ZdGFjy2iV/SP11qjX7S/LgZxVVd29mdUok18T?=
 =?us-ascii?Q?ujJDzn7azRVNCst45wCloEyNBb8pHxPWZVZ4cZIXgPFWFmcWSKyIxcmaqdLq?=
 =?us-ascii?Q?7GYoWAJ7CjByroaTei3AZdWpez3w4tVsXx1O7Fcw+9TmWQ+gmK6FxOj/LJJc?=
 =?us-ascii?Q?eJavK5ZgHs4jcFQqDC/ETg=3D=3D?=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(39850400004)(346002)(376002)(396003)(136003)(46966006)(36840700001)(7416002)(9786002)(82740400003)(47076005)(2616005)(83380400001)(2906002)(478600001)(186003)(36756003)(316002)(8936002)(26005)(8676002)(7696005)(36906005)(36860700001)(336012)(6666004)(107886003)(1076003)(4326008)(356005)(7636003)(426003)(82310400003)(5660300002)(110136005)(921005)(966005)(70586007)(70206006)(102446001)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2021 15:53:19.7492
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a35e3e5a-1f77-4a90-7496-08d938ba8523
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT008.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB2729
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>

This patch adds binding doc for versal fpga manager driver.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
Signed-off-by: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes for v2:
              -Fixed file format and syntax issues.

Changes for v3:
              -Removed unwated extra spaces.

Changes for v4:
              -Rebased the changes on linux-next.
               No functional changes

Changes for v5:
              -Updated fpga node name to versal_fpga.

Changes for v6:
              -None.

Changes for v7:
              -None.

Changes for v8:
              -None.

 .../bindings/fpga/xlnx,versal-fpga.yaml       | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,versal-fpga.yaml

diff --git a/Documentation/devicetree/bindings/fpga/xlnx,versal-fpga.yaml b/Documentation/devicetree/bindings/fpga/xlnx,versal-fpga.yaml
new file mode 100644
index 000000000000..ac6a207278d5
--- /dev/null
+++ b/Documentation/devicetree/bindings/fpga/xlnx,versal-fpga.yaml
@@ -0,0 +1,33 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/fpga/xlnx,versal-fpga.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx Versal FPGA driver.
+
+maintainers:
+  - Nava kishore Manne <nava.manne@xilinx.com>
+
+description: |
+  Device Tree Versal FPGA bindings for the Versal SoC, controlled
+  using firmware interface.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - xlnx,versal-fpga
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    versal_fpga: versal_fpga {
+         compatible = "xlnx,versal-fpga";
+    };
+
+...
-- 
2.17.1


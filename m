Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29CEF485BD4
	for <lists+linux-fpga@lfdr.de>; Wed,  5 Jan 2022 23:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245159AbiAEWup (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 5 Jan 2022 17:50:45 -0500
Received: from mail-bn8nam11on2041.outbound.protection.outlook.com ([40.107.236.41]:42336
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S245165AbiAEWuk (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 5 Jan 2022 17:50:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XqtsSSHr/39mtN2vB4f5QZF9IHiVg7a8XcAIUpCLPU4R8eSKCN9sXojFQeqvYQcwlQbnaiRws9EOSw2IMOG8tZjMdlm7KIfRAEmUAj46ftpNtwHv586KypdJjM0MrvgNnntUxCZmRLmPIlR4QNZTitfkUwxqsr+uu4Q+J8DCJKzYkxYCtkWtGqSJPoAMmRwNdHb3EjXvRiqKy7pFDRD90iAe9ivc33aO9+YKVmWjr/+8hK1wAWmYFtwDk4fbn7ldPbMpMQUEJo6kIMHmy6FRlAnMGGkoFPKlz3KlMC2AAAxy6DRDu6DerGJb5WcdoM6XojiUMzH8bf1A0V/9kozAmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JwjTMgUJphZrOlnjddsZELFwfjPYNOX6QO/d+9TvrCk=;
 b=K8MnVShK7Kv6MJNCsuXNlXzTXmPavfbQoeHBFlQQOAxynTZ/3oJ7t8CMKV6rKFs/qjhFrloE8I9X7vkKTDiAJCnKbwTVoawTOSFuNnhPP7WmVLUHIhrzwRJhVd+dIPri6V50u637Mb4NFmBXJga9Zwi6fPLbnCR6gOYbhAPUU5idIY5VWnBWRuKOB7IdRjDbjNUNm+k4x5UiXzqcJ4nHjG8xbeRcsIfcXRS+Nh6tQ9PA8UMi8c6Hf8oJ/kgwev26KowscgM3Kj16PHNoUF6570NJw5xLdlCfV4t5gno3oUh2gHRnnyq9Hsal6YprY3ds9/FXZ5SJu2mEG/pKZS5oaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=infradead.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JwjTMgUJphZrOlnjddsZELFwfjPYNOX6QO/d+9TvrCk=;
 b=As1y1I6EwPV0+DKMSx0fVTZyHy0fB5nuadcH4P60Hv3WSH41FVE1JBoxhJJGx4M3YRzugHBPJMY03Z3FEsHhTOYbgGinCLAOU4tGdhbh5eKVzsf6SPfUzFRvk99wH4RaM2tlrW50vmXOXDREJeu6FqySDmrhMjNF9FjnOsk3M/k=
Received: from DM5PR13CA0059.namprd13.prod.outlook.com (2603:10b6:3:117::21)
 by BL3PR02MB7922.namprd02.prod.outlook.com (2603:10b6:208:351::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Wed, 5 Jan
 2022 22:50:35 +0000
Received: from DM3NAM02FT053.eop-nam02.prod.protection.outlook.com
 (2603:10b6:3:117:cafe::89) by DM5PR13CA0059.outlook.office365.com
 (2603:10b6:3:117::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.4 via Frontend
 Transport; Wed, 5 Jan 2022 22:50:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT053.mail.protection.outlook.com (10.13.5.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4867.7 via Frontend Transport; Wed, 5 Jan 2022 22:50:34 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 5 Jan 2022 14:50:34 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 5 Jan 2022 14:50:34 -0800
Envelope-to: dwmw2@infradead.org,
 mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.72.93] (port=56776 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1n5F74-000GFd-3D; Wed, 05 Jan 2022 14:50:34 -0800
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id AAA12600AD3; Wed,  5 Jan 2022 14:50:22 -0800 (PST)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>, <dwmw2@infradead.org>,
        Max Zhen <max.zhen@xilinx.com>
Subject: [PATCH V4 XRT Alveo Infrastructure 2/5] Documentation: devicetree: bindings: add binding for Alveo platform
Date:   Wed, 5 Jan 2022 14:50:10 -0800
Message-ID: <20220105225013.1567871-3-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220105225013.1567871-1-lizhi.hou@xilinx.com>
References: <20220105225013.1567871-1-lizhi.hou@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd2babec-11b0-40a3-5527-08d9d09dc8fa
X-MS-TrafficTypeDiagnostic: BL3PR02MB7922:EE_
X-Microsoft-Antispam-PRVS: <BL3PR02MB79221C51A52804F5B84B76FBA14B9@BL3PR02MB7922.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wqcRSS9E/NR/IV25O8y3FREirdlzrKE50G2Jdt/TfAp2cApZaFdPuJ20bHoKy+KU67Ft8xYpX40hMSfydGji9YG1Fdp9mCPv4cQ6f1i40GT5jdqHFHyhya+l+xgP2lxnRkUW0nZNZjhJf80elzlF1Tau2CX+dE2opKJOfPZ4OfuDfwi/a+epJipu4fx1DO5k06VS2Ytm2mTXmg+1A6kjXMwWSfHtzhwXGRO3LaaM78PLRgbrH5oEp6E1GsLpAVVYz7LZDwal78ldYvpqWqWeEz4G6ljkaDORIiKhXrfCyBa53yVtYOaCY+wsNJQD7YuOjneGMoHNd2eqXWo2GRr40ZI7uiQmso/R7oyfybcLNohJTqY2ktYDXXrafEjOtz2eU3xkIQdh+QvTjSiMAJ59CZOC72hahxBLoPRKEgqFA0kcWdJ+R5Ue0YEJNIFB4y3InXT8Z5nVM5UaXRztw6hRzkC/SxdhiEaQCw2gkOvcVvShn1XgK3WsAng/NyPDZGmwdTPBQPjabG5o5QwI+dqGr8/ieG2kvDe/eB1ANPAv3v8pqNtIh8d5w5+/R12XNUcDxqs0N04YlPZYJVv5ArCFkniel/DXaeQcTzfdHyV3jW9qtSIPFPVKnz4EHPng/18smKNjZTLUXP5Gp0t91BQMWC6OpEfTg7oGLEn+lJh7lMdwE4JhFYaN0CJgY2afiImnaFK9POkCCJLD3WUwsS9JNWKtpsZmdhFTLzh/2SOugMg8PIoBRQ/paftx/raOFOfy0ECFDXZ1Qvkrp/HLPPC9kSiiLJHYVWO/biuKv91si5aS9IvT7yeVHqSD6L75elyTONI0EFsNr8se0YEAy2kjJQ==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(2616005)(44832011)(36756003)(336012)(70206006)(186003)(8936002)(26005)(70586007)(8676002)(82310400004)(7636003)(47076005)(5660300002)(107886003)(426003)(4326008)(508600001)(966005)(2906002)(6666004)(356005)(6266002)(42186006)(316002)(1076003)(54906003)(6916009)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 22:50:34.8990
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd2babec-11b0-40a3-5527-08d9d09dc8fa
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT053.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB7922
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Create device tree binding document for partitions and pr isolation on
Xilinx Alveo platform.

Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
Signed-off-by: Max Zhen <max.zhen@xilinx.com>
Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
---
 .../bindings/fpga/xlnx,alveo-partition.yaml   | 76 +++++++++++++++++++
 .../fpga/xlnx,alveo-pr-isolation.yaml         | 40 ++++++++++
 2 files changed, 116 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,alveo-partition.yaml
 create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,alveo-pr-isolation.yaml

diff --git a/Documentation/devicetree/bindings/fpga/xlnx,alveo-partition.yaml b/Documentation/devicetree/bindings/fpga/xlnx,alveo-partition.yaml
new file mode 100644
index 000000000000..ee50cb51d08e
--- /dev/null
+++ b/Documentation/devicetree/bindings/fpga/xlnx,alveo-partition.yaml
@@ -0,0 +1,76 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/fpga/xlnx,alveo-partition.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx Alveo platform partition bindings
+
+description: |
+  Xilinx Alveo platform is a PCI device and has one or more partitions. A
+  partition is programmed dynamically and contains a set of hardware
+  peripherals also referred to as endpoints which appear on the PCI BARs.
+  This binding is defined for endpoint address translation which uses the
+  the following encoding:
+
+    0xIooooooo 0xoooooooo
+
+  Where:
+
+    I = BAR index
+    oooooo oooooooo = BAR offset
+
+  As a PCI device, the Alveo platform is enumerated at runtime. Thus,
+  the partition node is created by Alveo device driver. The device driver
+  gets the BAR base address of the PCI device and creates the 'range'
+  property for address translation.
+
+allOf:
+  - $ref: /schemas/simple-bus.yaml#
+
+maintainers:
+  - Lizhi Hou <lizhi.hou@xilinx.com>
+
+properties:
+  compatible:
+    contains:
+      const: xlnx,alveo-partition
+
+  "#address-cells":
+    const: 2
+
+  "#size-cells":
+    const: 2
+
+  ranges: true
+
+patternProperties:
+  "^.*@[0-9a-f]+$":
+    description: hardware endpoints belong to this partition.
+    type: object
+
+required:
+  - compatible
+  - "#address-cells"
+  - "#size-cells"
+  - ranges
+
+additionalProperties: false
+
+examples:
+  - |
+    bus {
+        #address-cells = <2>;
+        #size-cells = <2>;
+        xrt-part-bus@0 {
+            compatible = "xlnx,alveo-partition", "simple-bus";
+            #address-cells = <2>;
+            #size-cells = <2>;
+            ranges = <0x0 0x0 0x0 0xe0000000 0x0 0x2000000
+                      0x20000000 0x0 0x0 0xe4200000 0x0 0x40000>;
+            pr-isolate-ulp@41000 {
+                compatible = "xlnx,alveo-pr-isolation";
+                reg = <0x0 0x41000 0 0x1000>;
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/fpga/xlnx,alveo-pr-isolation.yaml b/Documentation/devicetree/bindings/fpga/xlnx,alveo-pr-isolation.yaml
new file mode 100644
index 000000000000..8db949093ee0
--- /dev/null
+++ b/Documentation/devicetree/bindings/fpga/xlnx,alveo-pr-isolation.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/fpga/xlnx,alveo-pr-isolation.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx Partial Reconfig Isolation for Alveo platforms
+
+description: |
+  The Partial Reconfig ensures glitch free operation of the inputs from
+  a reconfigurable partition during partial reconfiguration on Alveo
+  platform.
+
+maintainers:
+  - Lizhi Hou <lizhi.hou@xilinx.com>
+
+properties:
+  compatible:
+    const: xlnx,alveo-pr-isolation
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    bus {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        pr-isolation-ulp@41000 {
+            compatible = "xlnx,alveo-pr-isolation";
+            reg = <0 0x41000 0 0x1000>;
+        };
+    };
-- 
2.27.0


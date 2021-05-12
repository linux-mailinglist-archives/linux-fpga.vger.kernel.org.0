Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2995337BCE7
	for <lists+linux-fpga@lfdr.de>; Wed, 12 May 2021 14:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbhELMwm (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 12 May 2021 08:52:42 -0400
Received: from mail-co1nam11on2050.outbound.protection.outlook.com ([40.107.220.50]:7923
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230492AbhELMwl (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 12 May 2021 08:52:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SzUWaf7R5MyzDcIzTZIXXpKSc56vgR5dtIMTWGWzNtgnMvdDBTnvhXns4rcdmIoQK33V/xRql14k1NOSut1/zS7EJ8GmgdCAVFkZQ0Cujru4q6vzTwiAzqEYcXiLd7a44Gb9eKogxqJ2+58qRaNjpBcuewozBJqo205V+wu3Sj9JcryRmvT5CQ2HZNiiMUQd+1M8cuguRPdUeBfRSQQclaSgKIDcWglXNpqzaUPBTMP4JaSqYzTj59Oan/KPkDsh62Wc6k+O1c1fV8eYt8sr0g8mX9oDun9mfh61xolHMY09AL9qd8vru6xFlZ63FLaOsHRJYnchSfEVK+Y6rvbK2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u9VH/BFszZUq0u9jF5SIZBEBLW01IzBUL2lsYsLoiVQ=;
 b=JXEQUGeSsUNq8kdgerD0IDRf+JUlWmVA6oJEttaJLKBu0isdcYEOQxmVWt+feJA8QncKFFx+mB/LHF0xKMvWvr4pbrtbzSHAw5DNUh8p77aiS/KT0zQYG4lNfh09mE02N5O8FX/yEelzQKkLN8WeYjh5Mm1C0E0WtdHzKg45SqJ9kN703JzYg1gjXmwDBlHT2zKzAnFEirLeScjHTtD6cda0jE1jc8zczJ+htTtuoKTeEC7I0jjV5QP+QiHdlX2bySTJLwbhVvBSvJ8llcpyUCNrdnO8JjIBdk4V6JNWoUdJhVGLL+OmzaNlIFF4WoLeg4NEU7dagjQfAyyEAUzlDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u9VH/BFszZUq0u9jF5SIZBEBLW01IzBUL2lsYsLoiVQ=;
 b=Aj9jKvsas9ScVhjtQGGqZ0kegbNsZHk1Xs1zm9o7alVS05Fx4RY1OBazDerQggxdB4vevKYoN/8i+pMsfuX/eYDEeIOnEAzMVVusHh2hDL1u8W/7A/JqTONddIIvttdab7AyV54zCumeFOH4EjF2gtEv0GLftvwOw086UYMFUTY=
Received: from DM5PR07CA0166.namprd07.prod.outlook.com (2603:10b6:3:ee::32) by
 SN6PR02MB5661.namprd02.prod.outlook.com (2603:10b6:805:ed::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.30; Wed, 12 May 2021 12:51:31 +0000
Received: from DM3NAM02FT015.eop-nam02.prod.protection.outlook.com
 (2603:10b6:3:ee:cafe::d) by DM5PR07CA0166.outlook.office365.com
 (2603:10b6:3:ee::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24 via Frontend
 Transport; Wed, 12 May 2021 12:51:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT015.mail.protection.outlook.com (10.13.5.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4065.21 via Frontend Transport; Wed, 12 May 2021 12:51:31 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 12 May 2021 05:51:12 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Wed, 12 May 2021 05:51:12 -0700
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
Received: from [10.140.6.60] (port=37340 helo=xhdnavam40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <nava.manne@xilinx.com>)
        id 1lgoKU-0002rt-6P; Wed, 12 May 2021 05:51:10 -0700
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
Subject: [PATCH v5 3/4] dt-bindings: firmware: Add bindings for xilinx firmware
Date:   Wed, 12 May 2021 18:20:41 +0530
Message-ID: <20210512125042.30973-4-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210512125042.30973-1-nava.manne@xilinx.com>
References: <20210512125042.30973-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae5678bb-1f9c-42e4-753c-08d91544aa94
X-MS-TrafficTypeDiagnostic: SN6PR02MB5661:
X-Microsoft-Antispam-PRVS: <SN6PR02MB5661F6BDFAF3C769903105CDC2529@SN6PR02MB5661.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hq5TdgtUetwbDT7QzNcGcvsImI/opUh+K1lCuUcizY+gR0yfZrWP1f9u9dYGWCcw437cQHAVLN8ndNX9sntwkTaxt4CVjzkgOyH+6CoUNB543f9qKfKp+P/lcAqQrxJhtH2O4ALafk/56W5ZuHRrpbOwGcwssDDUU/ONP/yFtRBdVtdIByevDrO0QYspUmC6k/idAmev51wa+++7anqU5L5wNjgLMO3H1JHL5d59lrIVZDpYOLJ3mFd8HoEImYjZmL65rseCaRmqyhU5BUhFgCuq6XtqNyaMt6is2E09mx74FlV1A0/z97U4fOcrYYWgqfxMfX1SsnWDs+cKzAwAngzkR4xZGkXOULlQj8H9SKHJ8RBgKHQEpDf6cMUn/xz4PcEmixkM7M8sU9kXKeJeLWE8fJwS43G4Fba43zOirhZv5ZiQeWZYP087t2Dvgq7IxaSj2hfxPmO1V+muJwNU9WJX/H4EyfMMT9/1YBX6mk+fMsGZtRMT30zOM+RLjds7oB0j3n4gkdHzjRbRWXrSnm0BGTrk+wi9zxegDJ5rUzzIEWFYX9Y63P72gK4CNL9rYtx55jW3BHOn1sFs0rAlaAZ6bttPU7yCofLEm0p2viAhkfflhEcqOEw/NFdGgZw9glpk6xvYp2eE2+TJtgBjCdWkrp/z+9jjb4YJSMWIqtOd0AwkSd4QgsqE27Mtlz5q5Y3riya2mdNcnFL2wRhfMDx4VkPyivAdk4OrVWbrmMSd83N+wkj/S9xi88KxsbADttwmzyI3g4NUz7o9TduWrs2Y0Yv31EsanBkvJUNjRULCGSAQUwQw9OVWrMpFzu7DnpTi5Ryz71ID2yCQXn2yazdRUirZDy5WBwKUxzB1UxQ=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(136003)(39830400003)(346002)(376002)(396003)(36840700001)(46966006)(1076003)(26005)(2906002)(7416002)(7696005)(316002)(70206006)(70586007)(966005)(186003)(478600001)(336012)(36756003)(36860700001)(110136005)(47076005)(7636003)(82310400003)(426003)(8936002)(2616005)(356005)(8676002)(36906005)(9786002)(83380400001)(5660300002)(6666004)(921005)(102446001)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 12:51:31.2551
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae5678bb-1f9c-42e4-753c-08d91544aa94
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT015.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5661
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Add documentation to describe Xilinx firmware driver bindings.
Firmware driver provides an interface to firmware APIs.
Interface APIs can be used by any driver to communicate
to Platform Management Unit.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
Changes for v4:
                -Added new yaml file for xilinx firmware
                 as suggested by Rob.
Changes for v5:
                -Fixed some minor issues and updated the fpga node name to versal_fpga.

 .../firmware/xilinx/xlnx,zynqmp-firmware.yaml | 66 +++++++++++++++++++
 1 file changed, 66 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml

diff --git a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
new file mode 100644
index 000000000000..e6848c2dfb67
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/firmware/xilinx/xlnx,zynqmp-firmware.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx firmware driver
+
+maintainers:
+  - Nava kishore Manne <nava.manne@xilinx.com>
+
+description:
+  The zynqmp-firmware node describes the interface to platform firmware.
+  ZynqMP has an interface to communicate with secure firmware. Firmware
+  driver provides an interface to firmware APIs. Interface APIs can be
+  used by any driver to communicate to PMUFW(Platform Management Unit).
+  These requests include clock management, pin control, device control,
+  power management service, FPGA service and other platform management
+  services.
+
+properties:
+  compatible:
+    oneOf:
+      - description:
+          For implementations complying for Zynq Ultrascale+ MPSoC.
+        const: xlnx,zynqmp-firmware
+
+      - description:
+          For implementations complying for Versal.
+        const: xlnx,versal-firmware
+
+  method:
+    description: |
+                 The method of calling the PM-API firmware layer.
+                 Permitted values are.
+                 - "smc" : SMC #0, following the SMCCC
+                 - "hvc" : HVC #0, following the SMCCC
+
+    $ref: /schemas/types.yaml#/definitions/string-array
+    enum:
+      - smc
+      - hvc
+
+patternProperties:
+  "versal_fpga":
+    $ref: "../../fpga/xlnx,versal-fpga.yaml#"
+    description: Compatible of the FPGA device.
+    type: object
+
+    required:
+      - compatible
+
+required:
+  - compatible
+
+examples:
+  - |
+    versal-firmware {
+      compatible = "xlnx,versal-firmware";
+      method = "smc";
+      versal_fpga: versal_fpga {
+        compatible = "xlnx,versal-fpga";
+      };
+    };
+
+additionalProperties: false
-- 
2.17.1


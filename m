Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1A4C39B807
	for <lists+linux-fpga@lfdr.de>; Fri,  4 Jun 2021 13:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbhFDLgF (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 4 Jun 2021 07:36:05 -0400
Received: from mail-mw2nam12on2051.outbound.protection.outlook.com ([40.107.244.51]:15073
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229962AbhFDLgF (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 4 Jun 2021 07:36:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nuSQuOro8hAbnWKbeXCjJMj1HCGdisIqpIVGqMLxoveT2Yuib9mS07YNFkeYXFJckZr6KgwqlVH+CB4XLDEOAHlviHX+IaCnxH8xEse9z3u/Y2RrjO7Zirb23RDZ+QiTnOLZOeD2gaFrpREuw/Ves+8BBWKdD7kJndBLbAdGMQx7liy+lSSzJNa92E0wXZ3ZzQqWzZ2Hg4/uqr8d+bh5Z/yGyiUx3s0+G2Zx7IaYcheCV9BP0Y88kw30xN3skTaEvtgMvREGWeDlP/80zGbhhmuKGpLuxLBILRCxqIFrDCKweVWX2p9FQUgXWKXLQUmEb4ETmWj611GE7FS2LbTzSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GGl4Z16v/obVHp99+OZhrcZPKWGkTqSsIlxvPF5wTQg=;
 b=LoEsOShxYp5z9XSnQ6svLQUMEs3dzaZq92SVwbu93I73cYKEoRuvizi17LAenWydwiw37Ri802n3l+6by4FSXbCCDyvQ9gcpdmvb0oqUIGCt/c7GyRApx5i9L2TbKF5MpxvYdH1MaW5smOk6dEvDI7xAIi//Lp6ficnHNBfBtVUu7hhOvns2oz5I35sKQwD3MmV4RT1/vyRkY0B6j9gRUx8HvhWyenhm6OLFtNOQTUTOBGUlu5lHABgJkLfyueFwiPyCb3TUxl+CPedi4to6lKNsm7yk3I66Q97Jeks6KCEGJf9ceukxWhvA8NkZiNNo5lQ+n7EQHOflT5ntdvZwmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GGl4Z16v/obVHp99+OZhrcZPKWGkTqSsIlxvPF5wTQg=;
 b=Y8z2wwHiZkGOxlnhl5CCpoxj7BteMQgWFPg2HG9uSKXsVAfnGC6MxXQgEKwLxwAQ4rNnHtIcf0C5JW27O8uH+O67SR5X83+M3Spwm8oBPUAjcXvJM16dSe2S1KWRo3LSawE4ctkgUtRzA3Y9fh8u7GET+/yYaDo4kGbvNefWk34=
Received: from SA9PR13CA0064.namprd13.prod.outlook.com (2603:10b6:806:23::9)
 by MWHPR0201MB3577.namprd02.prod.outlook.com (2603:10b6:301:76::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Fri, 4 Jun
 2021 11:34:17 +0000
Received: from SN1NAM02FT0017.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:23:cafe::14) by SA9PR13CA0064.outlook.office365.com
 (2603:10b6:806:23::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.10 via Frontend
 Transport; Fri, 4 Jun 2021 11:34:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0017.mail.protection.outlook.com (10.97.4.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4195.18 via Frontend Transport; Fri, 4 Jun 2021 11:34:17 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 4 Jun 2021 04:34:00 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Fri, 4 Jun 2021 04:34:00 -0700
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
Received: from [10.140.6.60] (port=49944 helo=xhdnavam40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <nava.manne@xilinx.com>)
        id 1lp85O-0005PI-Mw; Fri, 04 Jun 2021 04:33:59 -0700
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
Subject: [PATCH v7 3/4] dt-bindings: firmware: Add bindings for xilinx firmware
Date:   Fri, 4 Jun 2021 17:03:31 +0530
Message-ID: <20210604113332.1394-4-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210604113332.1394-1-nava.manne@xilinx.com>
References: <20210604113332.1394-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff0eeb84-4180-4517-d554-08d9274cb01d
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3577:
X-Microsoft-Antispam-PRVS: <MWHPR0201MB357754D9C3DF92E5DE3430BBC23B9@MWHPR0201MB3577.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: quIN6Hsgb8Vq+yO/w+EZerweM/vDw+OhYYy6X5y1TfTKOaTTFQx1A0Nv8O88QcmBh4rdDzQdmutU/GsqrlUXgJHe3qNvXVDnz+uXTEAA9gvvpf8kTeV4zHQTWJrUiP8LcKzUJinzG8Qt1G/ZCNWGG85vdCIDZneFVi5bj3MHoHPaOn3JezvihUg47XcyNaldr01VkRYBwH0Mz6wGXEqpUN/ssbipRDbEd8c98v9iZPg5d8SMzl087ThRICP0G1GYdZbkoyWnH+Y7RDmBQj2NloK22fgXL7MdzDXEcNLDaL/dqkQ6k5vtZds2HZBdvNkbeqniUCcI3zb8+O7F8FdCfifqX2ChJ46bjEzqnaQidWoUfSGhJWGbuUxZI7nJmzkZxOG1Vqitq+YDFjxDv2YMpzt4CerrDc0NTNoPhcLvJ4TCOWFvgzeez8UrJ58PedeaoWzfju3AXgyjWbAfsBckyvIcu5mrYsBIyaBkG2CNyuielkPMASacTZFASYAs4gO+dDH0arIs042Hli0dt/3OiU2NCTOOkMFtTL7TO6ItpkYGkLcBqzvsuMmrKcUhD/KJMQwetLhhA9QyUyHRquWFpLfbB/POAUu/yksUaytefOhG6xB7TaH9SokH5gYSTlzo66ATyoxLawgQevFf7oXv60Dlo6PdgG0VwXFBVfdzv5k/xt8ZSuz/2aNk1jI53WvJrVdb3+Crx3gbQnUqy4UB88bGLncI7OX7FprJ/th/ozbV6U6NMmBaNxN8CTXR4aC1IqEuTRwypY3OC0AoSYU15ZdFdmRLs8Ga+3ElMnnWzQwzh4pCQOguRSl9y9qg4fYQ5TZxPzJwgg8YXEropwv4Gqj4DOUHfO1VW8jlkNN8lya2t4t13BfjUAFp6zJuskI5IkrSAAxOZEYUqOe4W4IT1Q==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(136003)(396003)(46966006)(36840700001)(186003)(6666004)(966005)(7416002)(426003)(83380400001)(478600001)(70586007)(8676002)(2906002)(26005)(70206006)(336012)(8936002)(36906005)(9786002)(316002)(110136005)(7696005)(36756003)(921005)(356005)(47076005)(5660300002)(82740400003)(1076003)(2616005)(82310400003)(7636003)(36860700001)(102446001)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2021 11:34:17.4579
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff0eeb84-4180-4517-d554-08d9274cb01d
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0017.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3577
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

Changes for v6:
              -Added AES and Clk nodes as a sub nodes to the firmware node.

Changes for v7:
              -Fixed child nodes format ssues.

 .../firmware/xilinx/xlnx,zynqmp-firmware.yaml | 94 +++++++++++++++++++
 1 file changed, 94 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml

diff --git a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
new file mode 100644
index 000000000000..8e0241c4c137
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
@@ -0,0 +1,94 @@
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
+  "versal_fpga":
+    $ref: /schemas/fpga/xlnx,versal-fpga.yaml#
+    description: Compatible of the FPGA device.
+    type: object
+
+  "zynqmp-aes":
+    $ref: /schemas/crypto/xlnx,zynqmp-aes.yaml#
+    description: |
+                 The ZynqMP AES-GCM hardened cryptographic accelerator is
+                 used to encrypt or decrypt the data with provided key and
+                 initialization vector.
+    type: object
+
+  "clock-controller":
+    $ref: /schemas/clock/xlnx,versal-clk.yaml#
+    description: |
+                 The clock controller is a hardware block of Xilinx versal
+                 clock tree. It reads required input clock frequencies from
+                 the devicetree and acts as clock provider for all clock
+                 consumers of PS clocks.list of clock specifiers which are
+                 external input clocks to the given clock controller.
+    type: object
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    versal-firmware {
+      compatible = "xlnx,versal-firmware";
+      method = "smc";
+
+      versal_fpga: versal_fpga {
+        compatible = "xlnx,versal-fpga";
+      };
+
+      xlnx_aes: zynqmp-aes {
+        compatible = "xlnx,zynqmp-aes";
+      };
+
+      versal_clk: clock-controller {
+        #clock-cells = <1>;
+        compatible = "xlnx,versal-clk";
+        clocks = <&ref>, <&alt_ref>, <&pl_alt_ref>;
+        clock-names = "ref", "alt_ref", "pl_alt_ref";
+      };
+    };
+
+...
-- 
2.17.1


Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37586389F85
	for <lists+linux-fpga@lfdr.de>; Thu, 20 May 2021 10:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbhETIL5 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 20 May 2021 04:11:57 -0400
Received: from mail-mw2nam12on2045.outbound.protection.outlook.com ([40.107.244.45]:54049
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231211AbhETILz (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 20 May 2021 04:11:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hY6orsAWzG0Y9ZwWaO1cCvee0WRdDpM8XZN9O5zVSKoBgmuExNXyb0Him19Rd/PelSD98BCwXkNp1n1BESIM64O2qFxRuqLHyibBpVl+uZmZ8ulIZhJaMrXHWePlwGYRROtlO253TWE1fUFTo04rmRQqOrsXzY1P2ATKNwxeoC+n7zxINS7FH8bw6i87S3NND8DA4ZjMwe1JdHRhtqH0ExFNoWOuagusG77hf/mq3ibOef2HKmgPn23CHWtWWV0aONV98qjIJpjEWyZA+qZy0lXhxdtu+4Vn+LAZcHmlv6xYG7t0BwjDTs88UjUVJBqKjIXnpZw0zAxPg8iET9I6LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YrIy+6hP3NQzquFEHYUWYM9ay1KssBxMmQ5PbZ/rZqU=;
 b=ANk3xRsPQO1atrPgGfp/vm6u7h1aqAgHViadkaNPHQjwR1hcRWAqFZa2BqpRJj5Nxp0sqdNmbDOFfehctSSasr2KqxAIwZ91ARyqsznevmN3qjz8D0Dqxi3ZAXTdVS6fT+mhNYYA2p2ndpcvwtDlK0NzdF2mgAU1y+E5Wr7/mRURc5+JI64qWibSBrY3I6xbBWnlQcrmefsxn9MqZft7bpk/F5vkH0XaVZszgKoMdwDfftv6hsYxHtNxhdS9j3XZEnVuLGwl4oyoQ23A6+BI0YNSFF0HhTY8v4FAla1HyX2Tc0bWXAQOvN4Hf0BEeJ+FTT0WRexxbliJ3pKsR7b/gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YrIy+6hP3NQzquFEHYUWYM9ay1KssBxMmQ5PbZ/rZqU=;
 b=qL6SdCzx+g201WCsBdDeYPajfUD7vX9C8o7EPExqGTx2kkaYOU/AED6W4zvTiQplYeEAJcK0SxpdC6X2hn4jxvXgy6nkzTp2BvX/LzKj5mAV/yGic0DfFfieJh9QR+cOgn6mGohrYfrpu9FX0TpICpAmmmIpXpMsegjHjeWRZd8=
Received: from SA0PR11CA0117.namprd11.prod.outlook.com (2603:10b6:806:d1::32)
 by MN2PR02MB6079.namprd02.prod.outlook.com (2603:10b6:208:185::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Thu, 20 May
 2021 08:10:31 +0000
Received: from SN1NAM02FT0047.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:d1:cafe::b0) by SA0PR11CA0117.outlook.office365.com
 (2603:10b6:806:d1::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23 via Frontend
 Transport; Thu, 20 May 2021 08:10:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0047.mail.protection.outlook.com (10.97.5.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.27 via Frontend Transport; Thu, 20 May 2021 08:10:31 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 20 May 2021 01:10:25 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Thu, 20 May 2021 01:10:25 -0700
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
Received: from [10.140.6.60] (port=42624 helo=xhdnavam40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <nava.manne@xilinx.com>)
        id 1ljdl4-0007IV-K3; Thu, 20 May 2021 01:10:19 -0700
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
Subject: [PATCH v6 3/4] dt-bindings: firmware: Add bindings for xilinx firmware
Date:   Thu, 20 May 2021 13:39:53 +0530
Message-ID: <20210520080954.1393-4-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210520080954.1393-1-nava.manne@xilinx.com>
References: <20210520080954.1393-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e58186c0-f4e2-4c4e-8729-08d91b66bc76
X-MS-TrafficTypeDiagnostic: MN2PR02MB6079:
X-Microsoft-Antispam-PRVS: <MN2PR02MB60796AF83BA192FF33FB656FC22A9@MN2PR02MB6079.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mKteWy7vUy596WVHnpHfofERVTx0KzJl1kIDtyPID5+7Q/OnGAnvZN6lxQ7NO94ii2GxeS9iBiaY84H4wpxLcVxmiCXTxupRWKnW5qbWe/QS1d/5Q0sR2j5zb1gVatH846fd5khgJQIZjzPNZoyKromm1aQZ/2V7NwO22PdBIGc9JBXz6P+OSFY8uFXwp6k0nGxN41pUtCXOXikkpZrw+42HrERukemBk4toy0tMkKF0yHsbZCOO3n0J5m2D3/9qD0yAKO4t46udwTPdfVvnmpiXz5sEEDRGEHrHo27whysAiS7wdD4WbXFipGYgnuNA4yrXvIOP0WTlE7Eur21uqsr16Zkjv7+KRsIQ0rIxkogWXBi2RHO8CEZRaOSn6i9XkM/OJkZgBxIp7egaPVtOXLzGI+6iDOuIyp/iz9AA8xv5Bma1RySKaelbl9V01I01IRyPN3T+EBCASSaWeGsEFlm6OwNwPELpOQuOcwN16DmNMozeZDviQlLHN85lH+FNUrom8ff1uGtKm3a3ePigTv/+X9UsjRxf1nFkLlYbj6pkZEuLGx959Cvciy38jN9nmyGleIuEZGZ9cFcu+fgTZWvq4t4NqXtllUAiRYeRWXFqde/OYDUtISrcb/iv+5gAiiyz7EJbhEMb/H9Te9Ab5SN1rZT6QQZpEDnIUevBy+Icr+QRQa3xjEjJA5Oo478Nw9QShphk4cqgpZ3YO93sQe2tZ0pE1/GhAK47q9erOCd2jQziPJKL32Jw/HW0cc9m58m10ZbyylpoZpvfC+5dhj9Cd6X+LcAxysPd7rDfECZMKm04T+JQAqT61ctjvToKJnA6C8aPIQeXSTbcK21byw==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(346002)(396003)(39850400004)(136003)(376002)(36840700001)(46966006)(2906002)(36756003)(110136005)(478600001)(36906005)(316002)(966005)(1076003)(8936002)(70586007)(8676002)(921005)(5660300002)(70206006)(7696005)(47076005)(9786002)(7636003)(26005)(356005)(6666004)(82740400003)(7416002)(83380400001)(82310400003)(186003)(2616005)(426003)(336012)(36860700001)(102446001)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2021 08:10:31.1334
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e58186c0-f4e2-4c4e-8729-08d91b66bc76
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0047.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6079
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

 .../firmware/xilinx/xlnx,zynqmp-firmware.yaml | 102 ++++++++++++++++++
 1 file changed, 102 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml

diff --git a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
new file mode 100644
index 000000000000..58016191e150
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
@@ -0,0 +1,102 @@
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
+    required:
+      - compatible
+
+  "zynqmp-aes":
+    $ref: "../../crypto/xlnx,zynqmp-aes.yaml#"
+    description: |
+                 The ZynqMP AES-GCM hardened cryptographic accelerator is
+                 used to encrypt or decrypt the data with provided key and
+                 initialization vector.
+    type: object
+    required:
+      - compatible
+
+  "clock-controller":
+    $ref: "../../clock/xlnx,versal-clk.yaml#"
+    description: |
+                 The clock controller is a hardware block of Xilinx versal
+                 clock tree. It reads required input clock frequencies from
+                 the devicetree and acts as clock provider for all clock
+                 consumers of PS clocks.list of clock specifiers which are
+                 external input clocks to the given clock controller.
+    type: object
+    required:
+      - compatible
+      - "#clock-cells"
+      - clocks
+      - clock-names
+
+required:
+  - compatible
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
+additionalProperties: false
-- 
2.17.1


Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 009583B4F53
	for <lists+linux-fpga@lfdr.de>; Sat, 26 Jun 2021 17:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbhFZPzx (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 26 Jun 2021 11:55:53 -0400
Received: from mail-bn8nam11on2070.outbound.protection.outlook.com ([40.107.236.70]:27489
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230214AbhFZPzw (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sat, 26 Jun 2021 11:55:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KqB4NVdPqdx4gfbsGUkX2FKjCAclVDrVBjEEqeUF/NeC9234nUMOwoikTR+h6iaEynr5aQixB2qLWQfMJjkT57hY9wo6F05Dld6riKoUOjmxZ/lIgXTWNla2KFz3qyba4b+oGV4vlBDIOtW8wZQlHrKjWXx5Vyv14U8zu5ZXsfDIusWOsJ6vxObaIwSXrgkou8/xhcKfbaElLcVQKtwMC/cqcsbad9mWdP5CDO3TQbU0n6+HK01X/Y2NsTRyPyYP2l4ql3JHuLR/HH4EhsN4eI4ukjlBr0udnmiIcuF7xMVklr4eqvX53gloCozmaWXzXmpU6Ao/24uiKw4eGFewaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ekfT3nWBsx27HZztkh6foa9TrVwSFqlGWBR1D9nI/A8=;
 b=lYVof9r586bIpuQDN8nO7kmZWQixK6Zs20JYotNkG84utuqz9Ctdxt/+/CFOds0oQOXPhK/x2kIiktDm9rP0uh7RGqbP4Zr5VaEcRn+QFUHtJFa9f2I2GurJqRoQmjnmBIV26aH5fdKPTFT5vAtmxrQgO6Be8zTcSSjIy+bn6oWcETBJ3G8ttkIUXeRPOMuZEVoQrELcnVEag0dfcxvHmM0ACqbYvtJRdcpH4alzBQAUvYcTEuBmKmhCwPrwipL/GhkERGr+nrZJEYnjlSHHn6vRp8OyGyuIzvisNuqqYdpplUmWsL9hUgBtftox6L0HwgXqirNhi/no6dExyDWXng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ekfT3nWBsx27HZztkh6foa9TrVwSFqlGWBR1D9nI/A8=;
 b=kK4ICwNtl3551+4M2qQH5vke5Np/1onesoZf8smGV0qXyBtbWf/RLbKfPeFjqYYGCpZuTNv4mk3ufS8ceWCYEWtbrM0B5Hs9ofeWtM4KlQqk9OQbqrltOEU0R4M8GLjwfEsQkF3p2GXEiqpRXKr7N7GMi9FwAd0e28jNr7JBeF8=
Received: from DM6PR13CA0059.namprd13.prod.outlook.com (2603:10b6:5:134::36)
 by BY5PR02MB6051.namprd02.prod.outlook.com (2603:10b6:a03:1b5::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Sat, 26 Jun
 2021 15:53:25 +0000
Received: from DM3NAM02FT044.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:134:cafe::ea) by DM6PR13CA0059.outlook.office365.com
 (2603:10b6:5:134::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.8 via Frontend
 Transport; Sat, 26 Jun 2021 15:53:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT044.mail.protection.outlook.com (10.13.5.98) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4264.18 via Frontend Transport; Sat, 26 Jun 2021 15:53:25 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 26 Jun 2021 08:53:13 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Sat, 26 Jun 2021 08:53:13 -0700
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
        id 1lxAcK-0000uY-2K; Sat, 26 Jun 2021 08:53:12 -0700
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
Subject: [PATCH v8 3/5] dt-bindings: firmware: Add bindings for xilinx firmware
Date:   Sat, 26 Jun 2021 21:22:46 +0530
Message-ID: <20210626155248.5004-4-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210626155248.5004-1-nava.manne@xilinx.com>
References: <20210626155248.5004-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 366f3bec-6003-4e41-5991-08d938ba884e
X-MS-TrafficTypeDiagnostic: BY5PR02MB6051:
X-Microsoft-Antispam-PRVS: <BY5PR02MB60510452D880538E3334B355C2059@BY5PR02MB6051.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X4FdhzP0FbxNiBTT+jGDQ5T8HfEkhGWJu8ZGQvpCxSCVdvTShYmfsS9RdgY2XA51FUTHrvBE0ZZ1OK6qAEUXvLyFn6G3JqFJUwpyjyMMdWbnjZ9PGHsI0Yu5PxwVkxa0L3gfVdw7OeVI4kFoO3Lf0dbmybvu9rbhTeUPnfIb51F/aUubXGIx8zX7iVzeS8Z+9Jv5K6mCNjbhgvJtqVl7OhJ9sRAeQGuFvMFzwj8BtV264WegIkx6RT5NoY6fkvYTJvd7cbg8ku9jxxxVBPVCq8bbZVQ0SE8cHE3PzGj4HZJgU2k0vCJICrDSjK29R5FiqVYIDxFfS94ArlQyI01WkXh4MRdcYwgX88uAChe0d6NKCeXHGCYbvZTu27mR+pBxCMOkBP+DVrZs8sR+9PZby+aOA8d4AN5SnXvuTUGJlnDPOSgXz2LAG0YnOZSAU7zIrLMJq+gGYGZ8P/Q9B1CigP0BjPGAFIgeVC9msFpaaTAGVAZpx/w/32SMDjzupkeuCaKAFwdrNFMwkBWO4RczktVtRM8Px3iHa6NHc+ZngRjBVJoRPPC/9Cm8gB0d8tp5fmjEs+Thy9yGY+FZXjuf3IVMzaWXcQZppeArqnPGtR0jHbexwW6tDWV8HsWIGuZROU21iSW2bCUX/HIOGlQUzUxWENmtm+1y1EKeiH8fk8XniFTJQKOhbdzavxVXc9DsRe40BsoAk6ko8fuID3M2MJQVHXa8wL8VDZhLaWRP3N9g6fp1yvrTufsC9iUOFE4ZI0ki9n2POFa9db+QBeZMebWlX9HjkYFzPx+rVfaMERAf1zJfJp4yS45Mg7uVAhIM7r3z0HQ+yYiL1u/hodSXk4zPEDt7lG2wwRXwCrJw9MJsaPL7/FTGVNKBZd7A01nZbDdR1EZryMdnxQP2sTqsJw==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(376002)(39850400004)(36840700001)(46966006)(82310400003)(921005)(36756003)(47076005)(2906002)(316002)(110136005)(7636003)(36860700001)(70586007)(70206006)(356005)(6666004)(36906005)(186003)(8676002)(1076003)(7416002)(8936002)(426003)(336012)(83380400001)(9786002)(2616005)(82740400003)(7696005)(5660300002)(966005)(478600001)(26005)(102446001)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2021 15:53:25.0644
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 366f3bec-6003-4e41-5991-08d938ba884e
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT044.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6051
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

Changes for v8:
                -Fixed some minor issues as suggested by rob.

 .../firmware/xilinx/xlnx,zynqmp-firmware.yaml | 89 +++++++++++++++++++
 1 file changed, 89 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml

diff --git a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
new file mode 100644
index 000000000000..f14f7b454f07
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
@@ -0,0 +1,89 @@
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
+description: The zynqmp-firmware node describes the interface to platform
+  firmware. ZynqMP has an interface to communicate with secure firmware.
+  Firmware driver provides an interface to firmware APIs. Interface APIs
+  can be used by any driver to communicate to PMUFW(Platform Management Unit).
+  These requests include clock management, pin control, device control,
+  power management service, FPGA service and other platform management
+  services.
+
+properties:
+  compatible:
+    oneOf:
+      - description: For implementations complying for Zynq Ultrascale+ MPSoC.
+        const: xlnx,zynqmp-firmware
+
+      - description: For implementations complying for Versal.
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
+  versal_fpga:
+    $ref: /schemas/fpga/xlnx,versal-fpga.yaml#
+    description: Compatible of the FPGA device.
+    type: object
+
+  zynqmp-aes:
+    $ref: /schemas/crypto/xlnx,zynqmp-aes.yaml#
+    description: The ZynqMP AES-GCM hardened cryptographic accelerator is
+      used to encrypt or decrypt the data with provided key and initialization
+      vector.
+    type: object
+
+  clock-controller:
+    $ref: /schemas/clock/xlnx,versal-clk.yaml#
+    description: The clock controller is a hardware block of Xilinx versal
+      clock tree. It reads required input clock frequencies from the devicetree
+      and acts as clock provider for all clock consumers of PS clocks.list of
+      clock specifiers which are external input clocks to the given clock
+      controller.
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


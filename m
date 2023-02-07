Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAE768D4CC
	for <lists+linux-fpga@lfdr.de>; Tue,  7 Feb 2023 11:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbjBGKs1 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 7 Feb 2023 05:48:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbjBGKsW (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 7 Feb 2023 05:48:22 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2053.outbound.protection.outlook.com [40.107.95.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E91AD17CEF;
        Tue,  7 Feb 2023 02:48:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=maWIRERrn3t0w9edrAOxTQw16tsB2aTIezSFIoe8o6JQXGcsh8V/cNeTz+FfNGaoXPsyQVMjY5qX4rgv3xIuQqurgGnVyEpwHwPaXL5fNfOcZiDbFvlmXfw5i0PoDbS4vcAOUsuXKIcHb4iIalaaae1/ZY67PIYbeLPJ8uxkJmfQ2dKVBov9lprAvmPjtGFr/Z4fkzhZBKynkPm1xm7iCKCf9+Ult28Q34xHlNTR42KoIfrxuhYbOyOi6q85sNKWcPGZLotJHxVXd8U88w5td1+xIvMXirDN8vAYQn8ZALUHRG+fKRIVzD8BY88ru5be2MMabA22hPneED176y+bHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DD5xY+tGSHPrhB9SKeJupnqbiTYdS/WileHROMtDLfE=;
 b=dqxYtOaRb8Ou5wTfLBiMPuIEBaZI0TFsYEDJbqu7Dau9oQZyQasDElSFzDrBfSS7WYf43joimFQgLS0qShYHsO0plMkZ5j8vy4cqqEbw/grn5f6gl2CldjM1Kt746fbLRuucBv2WReq8YntcAUkze4mnfPQnd5fKOxBAs8wxORyb+1BYSxEfwpM6nYBkU2GK2E2ZFcV4+XSgqNnzSBtnGpPH7C0J6ZJZqWT0S3CpGUFrTc/SlFtxzZPDwtYsnt0Kylv6xxYM/CseRwP4fwmzEfwSDrIRAkFJATAyHXXDu4JseAWBH0SpFGwoVHZ3S9yLyte0dnoZVN/J/KvXvLQrWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DD5xY+tGSHPrhB9SKeJupnqbiTYdS/WileHROMtDLfE=;
 b=JgKN0OoO7Fc1+5LkEHit/FWXBT4KYSopZflxYUpYbz00WCbWffbHS6+xSg7RR2g3T/4zFD4nn3kuiWSwjPEr4DS16JdiYolWrrdiczeWHLyv1DdTD+ZkqkbhmoQkmVzSSFpgAU7nZUkOmWrC3xwCmd/0QTQzNMX4bMT6pbxpd4c=
Received: from DS7PR03CA0287.namprd03.prod.outlook.com (2603:10b6:5:3ad::22)
 by PH8PR12MB6793.namprd12.prod.outlook.com (2603:10b6:510:1c4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.36; Tue, 7 Feb
 2023 10:48:16 +0000
Received: from DM6NAM11FT085.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ad:cafe::8a) by DS7PR03CA0287.outlook.office365.com
 (2603:10b6:5:3ad::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.36 via Frontend
 Transport; Tue, 7 Feb 2023 10:48:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT085.mail.protection.outlook.com (10.13.172.236) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6064.35 via Frontend Transport; Tue, 7 Feb 2023 10:48:15 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 7 Feb
 2023 04:48:14 -0600
From:   Nava kishore Manne <nava.kishore.manne@amd.com>
To:     <mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>,
        <trix@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <michal.simek@xilinx.com>,
        <nava.kishore.manne@amd.com>, <linux-fpga@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] dt-bindings: fpga: convert bindings document to yaml
Date:   Tue, 7 Feb 2023 16:18:12 +0530
Message-ID: <20230207104812.182439-1-nava.kishore.manne@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT085:EE_|PH8PR12MB6793:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c4ce491-3590-4c8a-0c24-08db08f8d143
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Zq2lM6oYCp+JokvkXidNNd05LHcc3Zut0m5cMUK+M12iVUNeeYDuj5clwWSMbmr3+YrJeaa6A7iiUqXBqgo6PnwvhmYerCDjfNgzB1i6FzbI7Mo1mKACDCuTGrm2HT5UPCk20oQRLjUhhREAuCYmt7xrjgOZ5Ull4GIvr9tIkbvkKGsm6EgT4nfQSAlDGntXT3DFVrKB5ZF8QrWkYJc6ts+0/Fr6leS4dBmkikAzYrVixMM7yh3Gzu44zZ0eoYHnt4+W8E4isTXZqBkdN4fA/W10VasehAfUPNXNvHA/Re1OcVavx9Jnyx09/kuoe4y3ctd+x78nYK4bfBWZZrB+WlFgwaO2yNQt9XOg7b9xg/m0fb3/6BFFjrtX8/aF7tEvQIH8quFW2TcS+mRjeDPQRIOjY/ASeZbN+RNLPXP0kV2UvhCgaW2LMm9FtCFs16zy8Gf0ypVjlihelmSbFH3zbMqlgvFmktVsDIoUKZ3zOCKmc9pXeIa6jHZaW9EEgwWXAE1zyVHdb6q/zgHxzvi1EfqDixhfHAa4ppvGf3fK29xg+J10ZsoUgnqzkyUP0gX8HbJAIJgja7V6oltu0Wl6t73MGk35FgfEBOKDHYDIuPKFqpZznS3Cl193GjstR4azbBXUhVXkRLKAVqT6CUWVoBWLjjomt/LEYi5/E4VzBEEeRlhq0JFLNYZ5IJ3RTf4jSjuRKXh+AST4xxxa52UZuYG7H30AkCEXwEzGMnm0jyY/b7z741wRgA6nHNZ4gfrbZoXesI60qBMbiTb4SOmT0+dvnMkaXYxEAuHiCmgiPrgFRIa9QUKzo8FQ8f//v4R6iZPYUuTTjokDXn5dyayqFuguXyoXC+cNpyANnZAPaldmIsiZJ74AdNXTN6c7lAF
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(136003)(396003)(39860400002)(451199018)(46966006)(40470700004)(36840700001)(103116003)(7416002)(36756003)(5660300002)(86362001)(2906002)(82310400005)(8676002)(186003)(16526019)(26005)(316002)(83380400001)(336012)(70206006)(426003)(70586007)(2616005)(966005)(40480700001)(478600001)(1076003)(110136005)(82740400003)(40460700003)(356005)(81166007)(921005)(47076005)(8936002)(41300700001)(36860700001)(36900700001)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 10:48:15.7863
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c4ce491-3590-4c8a-0c24-08db08f8d143
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT085.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6793
X-Spam-Status: No, score=1.2 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Convert the xilinx-pr-decoupler binding document from txt to yaml.

Signed-off-by: Nava kishore Manne <nava.kishore.manne@amd.com>
---
 .../bindings/fpga/xilinx-pr-decoupler.txt     | 54 -------------
 .../bindings/fpga/xlnx,pr-decoupler.yaml      | 76 +++++++++++++++++++
 2 files changed, 76 insertions(+), 54 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/fpga/xilinx-pr-decoupler.txt
 create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,pr-decoupler.yaml

diff --git a/Documentation/devicetree/bindings/fpga/xilinx-pr-decoupler.txt b/Documentation/devicetree/bindings/fpga/xilinx-pr-decoupler.txt
deleted file mode 100644
index 0acdfa6d62a4..000000000000
--- a/Documentation/devicetree/bindings/fpga/xilinx-pr-decoupler.txt
+++ /dev/null
@@ -1,54 +0,0 @@
-Xilinx LogiCORE Partial Reconfig Decoupler Softcore
-
-The Xilinx LogiCORE Partial Reconfig Decoupler manages one or more
-decouplers / fpga bridges.
-The controller can decouple/disable the bridges which prevents signal
-changes from passing through the bridge.  The controller can also
-couple / enable the bridges which allows traffic to pass through the
-bridge normally.
-
-Xilinx LogiCORE Dynamic Function eXchange(DFX) AXI shutdown manager
-Softcore is compatible with the Xilinx LogiCORE pr-decoupler.
-
-The Dynamic Function eXchange AXI shutdown manager prevents AXI traffic
-from passing through the bridge. The controller safely handles AXI4MM
-and AXI4-Lite interfaces on a Reconfigurable Partition when it is
-undergoing dynamic reconfiguration, preventing the system deadlock
-that can occur if AXI transactions are interrupted by DFX
-
-The Driver supports only MMIO handling. A PR region can have multiple
-PR Decouplers which can be handled independently or chained via decouple/
-decouple_status signals.
-
-Required properties:
-- compatible		: Should contain "xlnx,pr-decoupler-1.00" followed by
-                          "xlnx,pr-decoupler" or
-                          "xlnx,dfx-axi-shutdown-manager-1.00" followed by
-                          "xlnx,dfx-axi-shutdown-manager"
-- regs			: base address and size for decoupler module
-- clocks		: input clock to IP
-- clock-names		: should contain "aclk"
-
-See Documentation/devicetree/bindings/fpga/fpga-region.txt and
-Documentation/devicetree/bindings/fpga/fpga-bridge.txt for generic bindings.
-
-Example:
-Partial Reconfig Decoupler:
-	fpga-bridge@100000450 {
-		compatible = "xlnx,pr-decoupler-1.00",
-			     "xlnx-pr-decoupler";
-		regs = <0x10000045 0x10>;
-		clocks = <&clkc 15>;
-		clock-names = "aclk";
-		bridge-enable = <0>;
-	};
-
-Dynamic Function eXchange AXI shutdown manager:
-	fpga-bridge@100000450 {
-		compatible = "xlnx,dfx-axi-shutdown-manager-1.00",
-			     "xlnx,dfx-axi-shutdown-manager";
-		regs = <0x10000045 0x10>;
-		clocks = <&clkc 15>;
-		clock-names = "aclk";
-		bridge-enable = <0>;
-	};
diff --git a/Documentation/devicetree/bindings/fpga/xlnx,pr-decoupler.yaml b/Documentation/devicetree/bindings/fpga/xlnx,pr-decoupler.yaml
new file mode 100644
index 000000000000..caea58a9ba7d
--- /dev/null
+++ b/Documentation/devicetree/bindings/fpga/xlnx,pr-decoupler.yaml
@@ -0,0 +1,76 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/fpga/xlnx,pr-decoupler.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx LogiCORE Partial Reconfig Decoupler/AXI shutdown manager Softcore
+
+maintainers:
+  - Nava kishore Manne <nava.kishore.manne@amd.com>
+
+properties:
+  compatible:
+    oneOf:
+      - description: The Xilinx LogiCORE Partial Reconfig Decoupler manages one
+          or more decouplers / fpga bridges. The controller can decouple/disable
+          the bridges which prevents signal changes from passing through the
+          bridge. The controller can also couple / enable the bridges which
+          allows traffic to pass through the bridge normally.
+        items:
+          - const: xlnx,pr-decoupler-1.00
+          - const: xlnx,pr-decoupler
+      - description: The Xilinx LogiCORE Dynamic Function eXchange(DFX)
+          AXI shutdown manager softcore is compatible with the Xilinx
+          LogiCORE pr-decoupler. The Dynamic Function eXchange AXI shutdown
+          manager prevents AXI traffic from passing through the bridge.
+          The controller safely handles AXI4MM and AXI4-Lite interfaces on
+          a Reconfigurable Partition when it is undergoing dynamic
+          reconfiguration, preventing the system deadlock that can occur
+          if AXI transactions are interrupted by DFX.
+        items:
+          - const: xlnx,dfx-axi-shutdown-manager-1.00
+          - const: xlnx,dfx-axi-shutdown-manager
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: aclk
+
+  bridge-enable:
+    description:
+      Zero if driver should disable bridge at startup
+      One if driver should enable bridge at startup
+      Default is to leave bridge in current state.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    fpga-bridge@100000450 {
+      compatible = "xlnx,pr-decoupler-1.00", "xlnx,pr-decoupler";
+      reg = <0x10000045 0x10>;
+      clocks = <&clkc 15>;
+      clock-names = "aclk";
+      bridge-enable = <0>;
+    };
+
+  - |
+    fpga-bridge@100000850 {
+      compatible = "xlnx,dfx-axi-shutdown-manager-1.00", "xlnx,dfx-axi-shutdown-manager";
+      reg = <0x10000045 0x10>;
+      clocks = <&clkc 15>;
+      clock-names = "aclk";
+      bridge-enable = <0>;
+    };
-- 
2.25.1


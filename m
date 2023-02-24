Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 348D46A1B52
	for <lists+linux-fpga@lfdr.de>; Fri, 24 Feb 2023 12:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjBXLSn (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 24 Feb 2023 06:18:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjBXLSd (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 24 Feb 2023 06:18:33 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802AB1115F;
        Fri, 24 Feb 2023 03:18:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SM2DjsyW3hUv6TzvpPNaJf4WZQPAyYMalRoNTnEi9ZDdvXSks9cJU6xwCXJWFvea6A7M6TPxHv9lbi77PvYAeYc25A+SIy/ekPRJbOgirFyzFgUqv4RGRl/N7uR4vs2eDtOiJzckIcuEu1M/EjRqmWSLDqnW/YoWlO+ZatSatv9Ktw6Ngv8ZPmxRIVzEx76jLMRCCt89QU0/Uj6bNFfiIq0TeuCZS6AqlS+A2bXoSD1vZv5i7PJkDiZpwWZw/6cpjItdCgHelYBjIN9O2NvufwG4itQdMT4resMdMEi50hmtnbAil84ooOeQtq0DADwu9pR9hPmxOo3VabRWJ3S9LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JpkPJlYpYIAoXMdJ4j2g72QxYYeBWGzMhIRm75I6zFg=;
 b=SEPrz1sopO5p5Wu346YfaUHlAv8kgaZFGkm2QN18ZWuC8KO69QimGhZUBezOVIfk1jwIcFX/cABOJTfNl4JcIbGXsxHHuv3l/S4rCD0eMNJegPTTRPwzl4+9msy/eIyj4H+vaedvuHH2SA+ynfu4LVVpbkv4lY5u+dYJ9r1xJM77YPj8uxhTMskLEPDsxX6VXt7ClbtFXsgRmtTA/932fb6PQ+nXFwPNIUEG1cA07mZWoSVB90DmcSKrgUwh893TxHFRFyaBMcrAdC8ZLvenzUeG3trOhty8QDwiCio58Q7BaC4vWcmCFkSUIlw73wzeinKLgzB4txgxiiBxBR2O8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JpkPJlYpYIAoXMdJ4j2g72QxYYeBWGzMhIRm75I6zFg=;
 b=mw1piDzICCiXjeBSQRWN997SDwM1Qg8K9t9+zjiQW/3h1TJk7OdHCJyXqJopFOnOea6/PUmY3CTSBGlgU7SqKfvtXcHTus1KsUFDbggpPNsEVZ3dDztVady61UrokoEWtIWq+y7cOGiJcW3utg+QyUqi8G10N3qZ1e2jhyR+G5k=
Received: from BN9PR03CA0969.namprd03.prod.outlook.com (2603:10b6:408:109::14)
 by CH3PR12MB8212.namprd12.prod.outlook.com (2603:10b6:610:120::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.24; Fri, 24 Feb
 2023 11:18:28 +0000
Received: from BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::56) by BN9PR03CA0969.outlook.office365.com
 (2603:10b6:408:109::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.24 via Frontend
 Transport; Fri, 24 Feb 2023 11:18:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT065.mail.protection.outlook.com (10.13.177.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6134.24 via Frontend Transport; Fri, 24 Feb 2023 11:18:28 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 24 Feb
 2023 05:18:27 -0600
From:   Nava kishore Manne <nava.kishore.manne@amd.com>
To:     <mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>,
        <trix@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <michal.simek@xilinx.com>,
        <nava.kishore.manne@amd.com>, <linux-fpga@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3] dt-bindings: fpga: xilinx-pr-decoupler: convert bindings to json-schema
Date:   Fri, 24 Feb 2023 16:48:25 +0530
Message-ID: <20230224111825.161593-1-nava.kishore.manne@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT065:EE_|CH3PR12MB8212:EE_
X-MS-Office365-Filtering-Correlation-Id: 007bee93-0942-4180-a155-08db1658dacc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E2iJuZ2pafSmTAyCUKFWAMVh5lVlGo0ccMOeqwYrpvKKTYhEgeKhiq3IqfGBfLoPtkUR/5nXkAPK4dWsqpFeOoxBvC791mOtNLMzQcscWZISEJbiQCWsocY7pZpsGLNCzsLcNr73PB5V16vA/245NuCbHJuYFJCmOstj1NXhuOD7tWy/bpk6iQJgajhIM5QhDZB63JRsDH1PIWZYAZAIweGZ1j4HUoC3LiMb1SzQmbCMP9khtAdKc49Ef/A3ZLvU9Wa33xWaQ+uRe6qWJvCZZTOGyFXX/au5zJUgvQeA/gE7yrxwV6g0mxvnH1/Zbfe8ClZUoct7BYTlAtOID+9J5UJ4iHjcs/KoEchm8kX5lnpExjhbKRmObzT3s52nwhFeTvGR4rl2+jb5pHuj2CMCZCBhEDoFpOHdrk9BagU7JnYl2+2shqAWtWtOt3C13o7aXWBJwpxx0N6MCIa6ZKBXNKdWRd9t0u94Q009XqdlN7X8uZe92mgDNWpJmBmkmrknIh7NAOz8ZUG8sbN9pV1iRYBpvuZ90CQd5+3p+hsTWMQas1vxZHc+yQDctossveg33e/NsirvMOKlcbQYwDl4N04DjXhq2/O/ktK7XeEBT99465YES3b977e+8K8kFGJ4TomB4TnkOXvum1uYZNPSChdvrhp74ryUNctNZMi0vE85C8p2zl2mjU3oDahH/3EMZyntAbsaULG16sB62GY9nlpSxZ0yY8TcEgi+0FWi2zSv+h/21EOQF7la45ytYDH25aQnJL7aqvEiNTVYYVUx3sX7/G78Fd8Iu88Awd3067ofQwMynlHLm9LqW7ze95eG3jiEuN6NJQOfXHtxyQxddg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(396003)(39860400002)(136003)(451199018)(46966006)(40470700004)(36840700001)(40460700003)(8676002)(70206006)(110136005)(83380400001)(8936002)(5660300002)(316002)(41300700001)(1076003)(70586007)(2616005)(16526019)(336012)(426003)(186003)(47076005)(478600001)(26005)(966005)(103116003)(921005)(356005)(40480700001)(36756003)(82310400005)(86362001)(82740400003)(36860700001)(7416002)(81166007)(2906002)(2101003)(36900700001)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2023 11:18:28.6365
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 007bee93-0942-4180-a155-08db1658dacc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8212
X-Spam-Status: No, score=0.4 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Convert xilinx-pr-decoupler bindings to DT schema format using json-schema

Signed-off-by: Nava kishore Manne <nava.kishore.manne@amd.com>
---
Changes for v3:
              - Removed 'bridge-enable' property and addressed some minor
                comments as suggested by Krzysztof.

Changes for v2:
              - Updated the description and addressed some minor comments
                as suggested by Krzysztof.

 .../bindings/fpga/xilinx-pr-decoupler.txt     | 54 ----------------
 .../bindings/fpga/xlnx,pr-decoupler.yaml      | 64 +++++++++++++++++++
 2 files changed, 64 insertions(+), 54 deletions(-)
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
index 000000000000..a7d4b8e59e19
--- /dev/null
+++ b/Documentation/devicetree/bindings/fpga/xlnx,pr-decoupler.yaml
@@ -0,0 +1,64 @@
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
+description: |
+  The Xilinx LogiCORE Partial Reconfig(PR) Decoupler manages one or more
+  decouplers/fpga bridges. The controller can decouple/disable the bridges
+  which prevents signal changes from passing through the bridge. The controller
+  can also couple / enable the bridges which allows traffic to pass through the
+  bridge normally.
+  Xilinx LogiCORE Dynamic Function eXchange(DFX) AXI shutdown manager Softcore
+  is compatible with the Xilinx LogiCORE pr-decoupler. The Dynamic Function
+  eXchange AXI shutdown manager prevents AXI traffic from passing through the
+  bridge. The controller safely handles AXI4MM and AXI4-Lite interfaces on a
+  Reconfigurable Partition when it is undergoing dynamic reconfiguration,
+  preventing the system deadlock that can occur if AXI transactions are
+  interrupted by DFX.
+  Please refer to fpga-region.txt and fpga-bridge.txt in this directory for
+  common binding part and usage.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - const: xlnx,pr-decoupler-1.00
+          - const: xlnx,pr-decoupler
+      - items:
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
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    fpga-bridge@100000450 {
+      compatible = "xlnx,pr-decoupler-1.00", "xlnx,pr-decoupler";
+      reg = <0x10000045 0x10>;
+      clocks = <&clkc 15>;
+      clock-names = "aclk";
+    };
+...
-- 
2.25.1


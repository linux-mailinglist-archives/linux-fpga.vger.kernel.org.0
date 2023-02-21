Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2126569DF4D
	for <lists+linux-fpga@lfdr.de>; Tue, 21 Feb 2023 12:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233337AbjBULuc (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 21 Feb 2023 06:50:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233481AbjBULub (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 21 Feb 2023 06:50:31 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C6310A8C;
        Tue, 21 Feb 2023 03:50:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VS+ka6xgzf86qDty9+/++EE2Qi5SgJNSCB2QDjmLaATTt+knlhKlbB5SXxj2XqHPsTufQDx420Bj9wzSxgNeOo3xoTJV+yPxYgdXMEJsX/Vz4ZUsr5bM3oXVHzDQaCLfrQCLAyANM3GI6R9DPpC9Hm/NREQclsiv4bOT6tlb8vpgLDE4AN6RZnayAumY5l1kPkhLpuuHOqUMMhz4BRo0E5GahjnxHS/Jr2Z4GMxhz52zBdzS0xT3WVbDGpEN4iaoosual+Zdwn1sOW17XbLEAkNIa6xgjwDpXN9tdGx8h6ak161cC1F9b0wUtBkhKCDvfTKhMmN1pGEOXmuhBMgQ2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yb0+XKgTmardZC+FWcj0k+gvbRMAEGIio0dawcg7wJc=;
 b=oM+tYnUmbuekNQdU1X1LHMn2CqcQVT/17t2nlMkknG1kfCHmC0NFG4QLsQUqnveFEqJD4KLJdT0+ViHG61C3pZ0kRZBVY39APy0D43N36GTJwP5ln2FfvuGR/CGlzmhuVoUzp6W5ta+ONujK/jvwMTy31BkAf6iQG5qnSr+Y9GVrki07jhewf0xVrXqoYwkv5Nt01lWWLc+HMrQPlLOWsWf92lySUv7/mnKSo7DV9StyjC8DwyLlIVen7dyi79twMt0tcD9TOq7HwyNkh0YjrMliNnm+uqH48lqqRMCD+XgZ65oDoNfofoSCYAVX0+75QabOZsK2GFp7NedAaOOPHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yb0+XKgTmardZC+FWcj0k+gvbRMAEGIio0dawcg7wJc=;
 b=317bAQWkYphKynhFhGQpp5X/LsVaJ2A4DbBBMOHdBtK/Vn69fZ7nUo8Mm/9gnZD6xkXBJydOuPol0ojJGll2nMnbrk8Ryij2bfsSQgYHw/+AK4PSukPers4uZkhzC6IIT+f/dBXJDeNnIX4lH5fx0NEuk9PKgzyftem9Ou8/6Ak=
Received: from MN2PR10CA0015.namprd10.prod.outlook.com (2603:10b6:208:120::28)
 by SA1PR12MB7224.namprd12.prod.outlook.com (2603:10b6:806:2bb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Tue, 21 Feb
 2023 11:50:17 +0000
Received: from BL02EPF00010209.namprd05.prod.outlook.com
 (2603:10b6:208:120:cafe::f4) by MN2PR10CA0015.outlook.office365.com
 (2603:10b6:208:120::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.20 via Frontend
 Transport; Tue, 21 Feb 2023 11:50:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00010209.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6134.14 via Frontend Transport; Tue, 21 Feb 2023 11:50:16 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 21 Feb
 2023 05:50:14 -0600
From:   Nava kishore Manne <nava.kishore.manne@amd.com>
To:     <mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>,
        <trix@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <michal.simek@xilinx.com>,
        <nava.kishore.manne@amd.com>, <linux-fpga@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] dt-bindings: fpga: xilinx-pr-decoupler: convert bindings to json-schema
Date:   Tue, 21 Feb 2023 17:20:12 +0530
Message-ID: <20230221115012.3468798-1-nava.kishore.manne@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00010209:EE_|SA1PR12MB7224:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ba1ec0d-f742-4862-52e9-08db1401ccd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U9YAZZ/drgXpU0hP7rTWTevMUZVxswcXUsNxGpGbogEI881Pxlyv2P+TM3EYiPC5LMbJ7jYdigUUUZ7EmturZ/ltBghu9gZ1d9ldQ71P5CzgvTCo8+ABdzs3uj2jZQ1RHa180nSzk5AsBsHeEhvRn8Huan1XpJ84VTktyfcDjartSpY3hmyN70AH7XgNAGoRORASIAPZRgpCEF+NAHAGeRgG2WTSEyqT4wR5NYSCDkBOKb3NXk6X7H6ok/loxYt58PGDb8buT2nG7qaDBQCLZPcFT/RRAoiVU+NTL3L4znbiE7UG1P6JFEAbXGzgvvo4XKu3BppmazOOrbsnY+XCXj3iW4LYFqP9t9X81ddsDA7dwzx1v0bk4U7C6gFd+OYmOS/6Yz3uJxo/qCx4wpdKgd/wyzmAYebpjUBaqlif5tVekk9K6LXloWzxK6q6BQC+3B5YouIPA8Nt9+kDOZWD7DAFKg+eBJgSuUvuQ5ZDFARt0WL+fM0O6oMhc3VRsRLR4oZcWBg27iaYD0BOcI3ol09JuS3TfiBnKLqdAGPRhuGLBr/QF2ik0B3J3p/QOY8eRkWitN3UkVwziov5FHjaiGBasUjyjldn2WCCnam6qm4bbai/f3UONFoAuw0Vd57+7dqrV4aHN/+Y3XXw5yNxuwvhdiF0mJVfSCND+QQJLPbZfzdx47W7oAW1ZYSs31vgmZ/mHU7cLBBQX5O+a/btjGgXr4DqsCIU65yMeR7DCrUaGtdDGmh1joBRZ6aXR7vUjTig1lBtOmgVbBb44mLuAPoUDfKI6193EKlptLQX91ql2B0YDECe+vLdRAHj+Hi86GEztO8m+SSfKpd2XwUAyA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(396003)(136003)(346002)(451199018)(46966006)(36840700001)(40470700004)(82740400003)(81166007)(82310400005)(2616005)(921005)(356005)(110136005)(86362001)(478600001)(36860700001)(83380400001)(70586007)(70206006)(5660300002)(2906002)(8676002)(41300700001)(8936002)(103116003)(26005)(1076003)(186003)(966005)(40480700001)(426003)(40460700003)(336012)(16526019)(316002)(7416002)(36756003)(47076005)(83996005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2023 11:50:16.6643
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ba1ec0d-f742-4862-52e9-08db1401ccd5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00010209.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7224
X-Spam-Status: No, score=0.5 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
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
Changes for v2:
              - Updated the description and addressed some minor comments
                as suggested by Krzysztof.

 .../bindings/fpga/xilinx-pr-decoupler.txt     | 54 --------------
 .../bindings/fpga/xlnx,pr-decoupler.yaml      | 71 +++++++++++++++++++
 2 files changed, 71 insertions(+), 54 deletions(-)
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
index 000000000000..4a08d4bfa20d
--- /dev/null
+++ b/Documentation/devicetree/bindings/fpga/xlnx,pr-decoupler.yaml
@@ -0,0 +1,71 @@
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
+description: The Xilinx LogiCORE Partial Reconfig Decoupler manages one or more
+  decouplers / fpga bridges. The controller can decouple/disable the bridges
+  which prevents signal changes from passing through the bridge.  The controller
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
+          - const: xlnx,pr-decoupler-1.00 #For PR-Decoupler.
+          - const: xlnx,pr-decoupler
+      - items:
+          - const: xlnx,dfx-axi-shutdown-manager-1.00 #For AXI shutdown manager.
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
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1]
+    description:
+      Zero if driver should disable bridge at startup. One if driver should
+      enable bridge at startup. Default is to leave bridge in current state.
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
+      bridge-enable = <0>;
+    };
+...
-- 
2.25.1


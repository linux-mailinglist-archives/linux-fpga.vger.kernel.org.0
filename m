Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0E96A3FEE
	for <lists+linux-fpga@lfdr.de>; Mon, 27 Feb 2023 12:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjB0LDJ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 27 Feb 2023 06:03:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjB0LCo (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 27 Feb 2023 06:02:44 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B5521293;
        Mon, 27 Feb 2023 03:02:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D6w+SOYdyXLp7qkfmkZS6uOnSDzsCXgrEHMyRJosrYB+PkP/SPQsxgIAPT0C6ft6VZoHK3SQeZ/N7dfK5X6EDv2tpB2xKA8EUAggqEZQIqg6o5QoxlHm9rF+H9M31/zmTFdLKQGG+MCEbAN2Zw9QogqZTFxmR8HEqb4dcQq27+LEPRfiEVXvQBlJzwd2hBQ9eKAkZzxGCGo8llIYcLNIZl5JV8R0Wot8R/EbqErPs1Dc+sukpIcOE/t2zbStgCGAHN5fvQ8jO32OTh5Jz3uIjV7VEm8E93UBwSbnEnp3nFyD0iZlD33kEloTM34B3PBKw/ZbBLTGUMWmIgekHn8/vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=inTQOEUUDG0KqvuoJ1owR3dG7MXRHZRv2VFt18WKHFg=;
 b=VrE+/9K9dz4RNdEhWFZTTSt+tr6le8xwtX1AMktp7XCh5wtZDAMxi5vJa7k8HdQYB6I8jf869DJDITs1fzGiHyJhJ6DJa6woThh6bsZHIIiPgXcia2opSg9xGl3rLa+w83MQbQw5iazYgxPmtuGmA/DkqBom8OLAgrh4c1esDpsgwyqfg0rntXTbsbvbloyhhmWduAQfgTYyQfGau2Ki/3A9E6ilahM+dLo/XR/xQelcMrwJl9/sLBMWtDXrb1q3aTONPLUXkwl6QRaVR8kFe4Y72RnKhbf8IqPgHcnPCAqv0ycBQqU78FfZf4sass2ENr/q66ysH/dm6N61hmNLlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=inTQOEUUDG0KqvuoJ1owR3dG7MXRHZRv2VFt18WKHFg=;
 b=4X/Gaj2ffv0eqhi8Va2aD8a5VYue1hnlrzG5UhmAJ7VZJfv6UAsLEvfe4hszMGyN51FTYpwAZkqRdrLYAw0kegdZkUpg+YjIbVWZgsZiTCAdpvNxVwyWMGw/z6Tf3HPDsdHHPYDAXjsBqBgqXtu7XndgUkhMlqxmbodj1bHoq7E=
Received: from DM6PR03CA0047.namprd03.prod.outlook.com (2603:10b6:5:100::24)
 by DM4PR12MB5231.namprd12.prod.outlook.com (2603:10b6:5:39b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Mon, 27 Feb
 2023 11:02:17 +0000
Received: from DS1PEPF0000E62E.namprd02.prod.outlook.com
 (2603:10b6:5:100:cafe::2e) by DM6PR03CA0047.outlook.office365.com
 (2603:10b6:5:100::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.28 via Frontend
 Transport; Mon, 27 Feb 2023 11:02:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E62E.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.12 via Frontend Transport; Mon, 27 Feb 2023 11:02:17 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 27 Feb
 2023 05:02:16 -0600
From:   Nava kishore Manne <nava.kishore.manne@amd.com>
To:     <mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>,
        <trix@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <michal.simek@xilinx.com>,
        <nava.kishore.manne@amd.com>, <linux-fpga@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] dt-bindings: fpga: xilinx-spi: convert bindings to json-schema
Date:   Mon, 27 Feb 2023 16:32:13 +0530
Message-ID: <20230227110213.291225-1-nava.kishore.manne@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E62E:EE_|DM4PR12MB5231:EE_
X-MS-Office365-Filtering-Correlation-Id: ee8b0091-19db-42b8-ac6e-08db18b216fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nSeoAMbKYkLa4Lr1pR2cFyGe7geRQTklY76XjaNUxywQKfSRUVK1ckKb25TREcC5z1VaLol6m466GKYvjbWXuklqP38kKIkCc/lnqdEOgAyg1/UjSJxw80MmACp9hJvZoivCLGWEYMY5tovq6iI1H1Du06IAGiHi4ZLOKOVichZpjBmcwKQSRzXALpGnfyEeJafEhk+LW62nchzC5RNx0BpdNy3l3nxF0vlLFIhwNMr35XhK3lowd/CMhl60ytGWin+zzkJU+68yOz4+B25/2tqcwjAkf5gYz8pPlY1zxJ8U/jNJWv1ciR4ZhVb3+Y3w8Mj72mH12XM1oQflXmbo8vVxA8XAToGjzYDlDRFzjfrBjwCVXIY7VV/WULo6nsyW0gYxTVBVWT4CfUQvSLt0cNUNeHgIONwrFJ0PUAXWp4UbPymZiS5A0M5nz4Tdxm4wKPDMFHmvUtL/MPutjYEqkT/xfMQGPU/dFZi1L59zRMRlqJnN4/u7HJNqRXe+VMbHgToUcZl2osq7o947nbtxrvzyJPDqf/g+w6n5vLX23rb0AuB2P5Qg4LEnYvj+3O94znKCLOlSVuzyLRYcK9lx9yPispci3Uq3RrCYNs0G9xPLu95tCJ9SixVI4vOEz6CZcIs69FvuY/M9uvKR1nzXnzIAeeX0j9SRVlItpvn0iX0BwL5DwFQ4KjF6QoKYAlRD30nyxioJ7ThO+m3EMnbGr2Fwl3HL/8tCom+h7CxykosQhXk7ugY3shY865PrY2w+RcjtgaHsdnDLdGlyvZkIuGM12NBCOPgqIa64TL6pT8BmuHsMjE2Idb8Iwb3QlKac1xQWqLolU4e/Ew6lasExQg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(396003)(39860400002)(346002)(451199018)(46966006)(40470700004)(36840700001)(40460700003)(16526019)(186003)(81166007)(82740400003)(83380400001)(921005)(356005)(8936002)(70586007)(70206006)(41300700001)(2906002)(7416002)(36860700001)(5660300002)(8676002)(40480700001)(336012)(47076005)(478600001)(1076003)(426003)(6666004)(26005)(966005)(2616005)(316002)(103116003)(36756003)(110136005)(86362001)(82310400005)(83996005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2023 11:02:17.1310
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee8b0091-19db-42b8-ac6e-08db18b216fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E62E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5231
X-Spam-Status: No, score=1.0 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Convert xilinx-spi bindings to DT schema format using json-schema.

Signed-off-by: Nava kishore Manne <nava.kishore.manne@amd.com>
---
Changes for v2:
              - Removed 'fpga-region.txt' relevant info from the description
                and addressed some minor comments as suggested by Krzysztof.

 .../bindings/fpga/xilinx-slave-serial.txt     | 51 ------------
 .../bindings/fpga/xlnx,fpga-slave-serial.yaml | 80 +++++++++++++++++++
 2 files changed, 80 insertions(+), 51 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/fpga/xilinx-slave-serial.txt
 create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,fpga-slave-serial.yaml

diff --git a/Documentation/devicetree/bindings/fpga/xilinx-slave-serial.txt b/Documentation/devicetree/bindings/fpga/xilinx-slave-serial.txt
deleted file mode 100644
index 5ef659c1394d..000000000000
--- a/Documentation/devicetree/bindings/fpga/xilinx-slave-serial.txt
+++ /dev/null
@@ -1,51 +0,0 @@
-Xilinx Slave Serial SPI FPGA Manager
-
-Xilinx Spartan-6 and 7 Series FPGAs support a method of loading the
-bitstream over what is referred to as "slave serial" interface.
-The slave serial link is not technically SPI, and might require extra
-circuits in order to play nicely with other SPI slaves on the same bus.
-
-See:
-- https://www.xilinx.com/support/documentation/user_guides/ug380.pdf
-- https://www.xilinx.com/support/documentation/user_guides/ug470_7Series_Config.pdf
-- https://www.xilinx.com/support/documentation/application_notes/xapp583-fpga-configuration.pdf
-
-Required properties:
-- compatible: should contain "xlnx,fpga-slave-serial"
-- reg: spi chip select of the FPGA
-- prog_b-gpios: config pin (referred to as PROGRAM_B in the manual)
-- done-gpios: config status pin (referred to as DONE in the manual)
-
-Optional properties:
-- init-b-gpios: initialization status and configuration error pin
-                (referred to as INIT_B in the manual)
-
-Example for full FPGA configuration:
-
-	fpga-region0 {
-		compatible = "fpga-region";
-		fpga-mgr = <&fpga_mgr_spi>;
-		#address-cells = <0x1>;
-		#size-cells = <0x1>;
-	};
-
-	spi1: spi@10680 {
-		compatible = "marvell,armada-xp-spi", "marvell,orion-spi";
-		pinctrl-0 = <&spi0_pins>;
-		pinctrl-names = "default";
-		#address-cells = <1>;
-		#size-cells = <0>;
-		cell-index = <1>;
-		interrupts = <92>;
-		clocks = <&coreclk 0>;
-
-		fpga_mgr_spi: fpga-mgr@0 {
-			compatible = "xlnx,fpga-slave-serial";
-			spi-max-frequency = <60000000>;
-			spi-cpha;
-			reg = <0>;
-			prog_b-gpios = <&gpio0 29 GPIO_ACTIVE_LOW>;
-			init-b-gpios = <&gpio0 28 GPIO_ACTIVE_LOW>;
-			done-gpios = <&gpio0 9 GPIO_ACTIVE_HIGH>;
-		};
-	};
diff --git a/Documentation/devicetree/bindings/fpga/xlnx,fpga-slave-serial.yaml b/Documentation/devicetree/bindings/fpga/xlnx,fpga-slave-serial.yaml
new file mode 100644
index 000000000000..614d86ad825f
--- /dev/null
+++ b/Documentation/devicetree/bindings/fpga/xlnx,fpga-slave-serial.yaml
@@ -0,0 +1,80 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/fpga/xlnx,fpga-slave-serial.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx Slave Serial SPI FPGA
+
+maintainers:
+  - Nava kishore Manne <nava.kishore.manne@amd.com>
+
+description: |
+  Xilinx Spartan-6 and 7 Series FPGAs support a method of loading the bitstream
+  over what is referred to as slave serial interface.The slave serial link is
+  not technically SPI, and might require extra circuits in order to play nicely
+  with other SPI slaves on the same bus.
+
+  Datasheets:
+    https://www.xilinx.com/support/documentation/user_guides/ug380.pdf
+    https://www.xilinx.com/support/documentation/user_guides/ug470_7Series_Config.pdf
+    https://www.xilinx.com/support/documentation/application_notes/xapp583-fpga-configuration.pdf
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    enum:
+      - xlnx,fpga-slave-serial
+
+  spi-cpha: true
+
+  spi-max-frequency:
+    maximum: 60000000
+
+  reg:
+    maxItems: 1
+
+  prog_b-gpios:
+    description:
+      config pin (referred to as PROGRAM_B in the manual)
+    maxItems: 1
+
+  done-gpios:
+    description:
+      config status pin (referred to as DONE in the manual)
+    maxItems: 1
+
+  init-b-gpios:
+    description:
+      initialization status and configuration error pin
+      (referred to as INIT_B in the manual)
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - prog_b-gpios
+  - done-gpios
+  - init-b-gpios
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      fpga_mgr_spi: fpga-mgr@0 {
+        compatible = "xlnx,fpga-slave-serial";
+        spi-max-frequency = <60000000>;
+        spi-cpha;
+        reg = <0>;
+        prog_b-gpios = <&gpio0 29 GPIO_ACTIVE_LOW>;
+        init-b-gpios = <&gpio0 28 GPIO_ACTIVE_LOW>;
+        done-gpios = <&gpio0 9 GPIO_ACTIVE_HIGH>;
+      };
+    };
+...
-- 
2.25.1


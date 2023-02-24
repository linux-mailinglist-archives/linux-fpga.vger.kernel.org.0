Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54B1F6A1B84
	for <lists+linux-fpga@lfdr.de>; Fri, 24 Feb 2023 12:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbjBXLhW (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 24 Feb 2023 06:37:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBXLhV (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 24 Feb 2023 06:37:21 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0216F628F3;
        Fri, 24 Feb 2023 03:37:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R9sHSFR9c8t29J+dxtSKy7rbK42D/X/5MmPOV4Eim434sSV2038+D4xo5RXjesPgmP2aaHPymCwCf/jGpvVM4YIZYZzjAskM9ikTASQa1jypxm6RRE1yNfsVR0lNrtUy3tzhdyTNm2T1weC9osaKtFq/zfFayMcMETLjSXBwf+HiXq7v0mL6d0QhvRFTS2t/RiQ8lu+KMk0GJUQ4CvJTQvNyuWojvHbpjpiOXY3kKIy28oCjbQ5NCq1NZCJ3T6nh47qTt5k4ChoaBSnAdqddXZADPOHDykf0HPSGP7sykED+7PalWZaJp8N6luoOZlH3BzE/y6adk4O/0BuHfwhO7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O2aXjSTL+1avBAMy3eSFZRY0hIFMRupGjGjcUwcRn3s=;
 b=cNKUDCl4dZuNLdO+Kp+GWDSQbIA9YyX9fjzjyVYEsmO63BQMXa1ZGRlf9D6Dp8f6EG/TaHhD5HfUrUo0vlJButINPkedQvBue07IUmYppVB2NXoTBiD4UO36srLifBVT0zd6tXY9GU4hXIze5FwaIUyEJmPFrnh2TK4aRALp5kM/gTrYaAHY032Pgt1dlyoBHVLkAabNILf2m7BtuIWV4uFq0zbvZsOqIeuIYEk3kcJOuEy3/Dy7fxt/QrhWgrulLY24QG/W9JI297xytf72JwG/lWnxV5ScJB9tSTDljjO5KkSaQ7oTAufYytyFdKyJeLV4b0oMyJ56Qy5hnJQTrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O2aXjSTL+1avBAMy3eSFZRY0hIFMRupGjGjcUwcRn3s=;
 b=NEn4H+2dfVqFtdhtvX7+Fd7bPXAXP316dTbhI4HFPjzNzw2eENI5T0gq901mHwJGBt6R/9J4scI2jDd4BJQMC8g22MktB5zCXfFUI71iNykUoIIHIlmpi3mrvGVEGEgF5oWAsZzzgaRxb9pI4sqq5T1/sRkr2V78QU1/nkWMNyU=
Received: from MW4P223CA0016.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::21)
 by DM6PR12MB4465.namprd12.prod.outlook.com (2603:10b6:5:28f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.24; Fri, 24 Feb
 2023 11:37:15 +0000
Received: from CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::ff) by MW4P223CA0016.outlook.office365.com
 (2603:10b6:303:80::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.24 via Frontend
 Transport; Fri, 24 Feb 2023 11:37:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT054.mail.protection.outlook.com (10.13.174.70) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6134.24 via Frontend Transport; Fri, 24 Feb 2023 11:37:15 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 24 Feb
 2023 05:37:13 -0600
From:   Nava kishore Manne <nava.kishore.manne@amd.com>
To:     <mdf@kernel.org>, <hao.wu@intel.com>, <yilun.xu@intel.com>,
        <trix@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <michal.simek@xilinx.com>,
        <nava.kishore.manne@amd.com>, <linux-fpga@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] dt-bindings: fpga: xilinx-spi: convert bindings to json-schema
Date:   Fri, 24 Feb 2023 17:07:11 +0530
Message-ID: <20230224113711.193903-1-nava.kishore.manne@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT054:EE_|DM6PR12MB4465:EE_
X-MS-Office365-Filtering-Correlation-Id: 79820682-c20b-4be3-9537-08db165b7a77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AjHJjrr8sAuJYHntZ9Pl9mNxxNN0nVoJYl2WErkOaSdtmru/wRDfMi22uJ6k3eFViQ198dIENg0RNph2dmZoaQdralLCWm/ryf/fY+NmMthrXLz6igfDfLvW7z2jGQsKsD4ucWq/CvholiCYCBEDdh6MdAmFIIS3kLXklOawfdQRP3tSA5UwXuaoH4zdGXFoAzHYcWamAgEgHTxFjSThoi0F9IyEQcBEIWGubagSom3BeNPWE9Tf6F3fkp9Y4NYbrDQo7b5LrCJc7OSbEuhCXv+MvG+5Ns5dHbUrjqTcSdUPMYVCHbix3nS1pPBZkJ1i6+CMCLjFRFWOi/4ey3BGWUbUWAefzenXxEnB4gvxeXtGcrEo0Fa6iTY0142jSbbLBl6LM8a1KjlPtTXmBnlJxw2Sq/BVZ0SHokXPi9/p1LqZyVeyKTjn31MP3TN1lm3fyyrK7uuFmqWJPo9GCqHHMGdGhgxoMZpVxRcN80pElm7Zxa5DtQHbF2+iwvr9vexAx/NVbg2FvOX4JyE0mkJbMW1S+CbFsTsA4Tuk5Fu5E9A3dRj7HCqrQe+c/xlEiecjoLHf0+/x0tyy7k23gbly5WKXxWAqd+qIrT5fHrUhXK9D2hA7jvZMOkYYlAqD7l7B02SzsFISMfh9JNewlxn+LxLNNdmEVasZvgotdAuvOjNzFXb9QczRv7eqAcZWfcFoFE794OGIUlX1B4AQUZnEqoVUhRn+/OfMfq04ZZEun9TZbm4AmCr8JRNUMKzhbLEE+jlIpVj/IvViwgbnwZXWpz0deGVoczYa4I0MQBrGMP2d3Rz0nmC/d5oqHb2UDesCQC5D/egR0IqkFOXKcKQCCw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(136003)(346002)(39860400002)(451199018)(40470700004)(46966006)(36840700001)(356005)(921005)(36860700001)(82740400003)(83380400001)(81166007)(86362001)(36756003)(103116003)(2906002)(41300700001)(8936002)(7416002)(5660300002)(40480700001)(40460700003)(82310400005)(26005)(186003)(16526019)(1076003)(47076005)(426003)(316002)(336012)(2616005)(8676002)(70206006)(70586007)(966005)(110136005)(478600001)(83996005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2023 11:37:15.4143
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79820682-c20b-4be3-9537-08db165b7a77
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4465
X-Spam-Status: No, score=0.4 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Convert xilinx-spi bindings to DT schema format using json-schema

Signed-off-by: Nava kishore Manne <nava.kishore.manne@amd.com>
---
 .../bindings/fpga/xilinx-slave-serial.txt     | 51 ------------
 .../bindings/fpga/xlnx,fpga-slave-serial.yaml | 77 +++++++++++++++++++
 2 files changed, 77 insertions(+), 51 deletions(-)
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
index 000000000000..a606e1bd1b1d
--- /dev/null
+++ b/Documentation/devicetree/bindings/fpga/xlnx,fpga-slave-serial.yaml
@@ -0,0 +1,77 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/fpga/xlnx,fpga-slave-serial.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx Slave Serial SPI FPGA driver.
+
+maintainers:
+  - Nava kishore Manne <nava.kishore.manne@amd.com>
+
+description: |
+  Xilinx Spartan-6 and 7 Series FPGAs support a method of loading the bitstream
+  over what is referred to as slave serial interface.The slave serial link is
+  not technically SPI, and might require extra circuits in order to play nicely
+  with other SPI slaves on the same bus.
+  Please refer to fpga-region.txt in this directory for  common binding part
+  and usage.
+
+  Datasheets:
+    https://www.xilinx.com/support/documentation/user_guides/ug380.pdf
+    https://www.xilinx.com/support/documentation/user_guides/ug470_7Series_Config.pdf
+    https://www.xilinx.com/support/documentation/application_notes/xapp583-fpga-configuration.pdf
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - xlnx,fpga-slave-serial
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
+
+  done-gpios:
+    description:
+      config status pin (referred to as DONE in the manual)
+
+  init-b-gpios:
+    description:
+      initialization status and configuration error pin
+      (referred to as INIT_B in the manual)
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
+    spi0 {
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


Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDF7352A6B
	for <lists+linux-fpga@lfdr.de>; Fri,  2 Apr 2021 13:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235293AbhDBL55 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 2 Apr 2021 07:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235291AbhDBL55 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 2 Apr 2021 07:57:57 -0400
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A39BC06178A
        for <linux-fpga@vger.kernel.org>; Fri,  2 Apr 2021 04:57:56 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:7c3c:adbc:7a1a:b85f])
        by laurent.telenet-ops.be with bizsmtp
        id nnxu240034A7w6i01nxuyt; Fri, 02 Apr 2021 13:57:54 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lSIQz-00CRkq-Kz; Fri, 02 Apr 2021 13:57:53 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lSIQz-004Cyv-Bu; Fri, 02 Apr 2021 13:57:53 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Moritz Fischer <mdf@kernel.org>, Tom Rix <trix@redhat.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] dt-bindings: fpga: fpga-region: Convert to sugar syntax
Date:   Fri,  2 Apr 2021 13:57:49 +0200
Message-Id: <e73c46db7f1474417cbc3c2d8f582d2e62833eeb.1617364549.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Using overlay sugar syntax makes the DTS files easier to read (and
write).

While at it, fix two build issues:
  - "/dts-v1/" and "/plugin/" must be separate statements.
  - Add a missing closing curly brace.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 .../devicetree/bindings/fpga/fpga-region.txt  | 187 ++++++++----------
 1 file changed, 85 insertions(+), 102 deletions(-)

diff --git a/Documentation/devicetree/bindings/fpga/fpga-region.txt b/Documentation/devicetree/bindings/fpga/fpga-region.txt
index e811cf8250199b14..d787d57491a1c537 100644
--- a/Documentation/devicetree/bindings/fpga/fpga-region.txt
+++ b/Documentation/devicetree/bindings/fpga/fpga-region.txt
@@ -245,36 +245,31 @@ Base tree contains:
 
 Overlay contains:
 
-/dts-v1/ /plugin/;
-/ {
-	fragment@0 {
-		target = <&fpga_region0>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-		__overlay__ {
-			#address-cells = <1>;
-			#size-cells = <1>;
-
-			firmware-name = "soc_system.rbf";
-			fpga-bridges = <&fpga_bridge1>;
-			ranges = <0x20000 0xff200000 0x100000>,
-				 <0x0 0xc0000000 0x20000000>;
-
-			gpio@10040 {
-				compatible = "altr,pio-1.0";
-				reg = <0x10040 0x20>;
-				altr,ngpio = <4>;
-				#gpio-cells = <2>;
-				clocks = <2>;
-				gpio-controller;
-			};
-
-			onchip-memory {
-				device_type = "memory";
-				compatible = "altr,onchipmem-15.1";
-				reg = <0x0 0x10000>;
-			};
-		};
+/dts-v1/;
+/plugin/;
+
+&fpga_region0 {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	firmware-name = "soc_system.rbf";
+	fpga-bridges = <&fpga_bridge1>;
+	ranges = <0x20000 0xff200000 0x100000>,
+		 <0x0 0xc0000000 0x20000000>;
+
+	gpio@10040 {
+		compatible = "altr,pio-1.0";
+		reg = <0x10040 0x20>;
+		altr,ngpio = <4>;
+		#gpio-cells = <2>;
+		clocks = <2>;
+		gpio-controller;
+	};
+
+	onchip-memory {
+		device_type = "memory";
+		compatible = "altr,onchipmem-15.1";
+		reg = <0x0 0x10000>;
 	};
 };
 
@@ -371,25 +366,22 @@ Live Device Tree contains:
 	};
 
 DT Overlay contains:
-/dts-v1/ /plugin/;
-/ {
-fragment@0 {
-	target = <&fpga_region0>;
+
+/dts-v1/;
+/plugin/;
+
+&fpga_region0 {
 	#address-cells = <1>;
 	#size-cells = <1>;
-	__overlay__ {
-		#address-cells = <1>;
-		#size-cells = <1>;
 
-		firmware-name = "zynq-gpio.bin";
+	firmware-name = "zynq-gpio.bin";
 
-		gpio1: gpio@40000000 {
-			compatible = "xlnx,xps-gpio-1.00.a";
-			reg = <0x40000000 0x10000>;
-			gpio-controller;
-			#gpio-cells = <0x2>;
-			xlnx,gpio-width= <0x6>;
-		};
+	gpio1: gpio@40000000 {
+		compatible = "xlnx,xps-gpio-1.00.a";
+		reg = <0x40000000 0x10000>;
+		gpio-controller;
+		#gpio-cells = <0x2>;
+		xlnx,gpio-width= <0x6>;
 	};
 };
 
@@ -402,41 +394,37 @@ This example programs the FPGA to have two regions that can later be partially
 configured.  Each region has its own bridge in the FPGA fabric.
 
 DT Overlay contains:
-/dts-v1/ /plugin/;
-/ {
-	fragment@0 {
-		target = <&fpga_region0>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-		__overlay__ {
-			#address-cells = <1>;
-			#size-cells = <1>;
-
-			firmware-name = "base.rbf";
-
-			fpga-bridge@4400 {
-				compatible = "altr,freeze-bridge-controller";
-				reg = <0x4400 0x10>;
-
-				fpga_region1: fpga-region1 {
-					compatible = "fpga-region";
-					#address-cells = <0x1>;
-					#size-cells = <0x1>;
-					ranges;
-				};
-			};
-
-			fpga-bridge@4420 {
-				compatible = "altr,freeze-bridge-controller";
-				reg = <0x4420 0x10>;
-
-				fpga_region2: fpga-region2 {
-					compatible = "fpga-region";
-					#address-cells = <0x1>;
-					#size-cells = <0x1>;
-					ranges;
-				};
-			};
+
+/dts-v1/;
+/plugin/;
+
+&fpga_region0 {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	firmware-name = "base.rbf";
+
+	fpga-bridge@4400 {
+		compatible = "altr,freeze-bridge-controller";
+		reg = <0x4400 0x10>;
+
+		fpga_region1: fpga-region1 {
+			compatible = "fpga-region";
+			#address-cells = <0x1>;
+			#size-cells = <0x1>;
+			ranges;
+		};
+	};
+
+	fpga-bridge@4420 {
+		compatible = "altr,freeze-bridge-controller";
+		reg = <0x4420 0x10>;
+
+		fpga_region2: fpga-region2 {
+			compatible = "fpga-region";
+			#address-cells = <0x1>;
+			#size-cells = <0x1>;
+			ranges;
 		};
 	};
 };
@@ -451,28 +439,23 @@ differences are that the FPGA is partially reconfigured due to the
 "partial-fpga-config" boolean and the only bridge that is controlled during
 programming is the FPGA based bridge of fpga_region1.
 
-/dts-v1/ /plugin/;
-/ {
-	fragment@0 {
-		target = <&fpga_region1>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-		__overlay__ {
-			#address-cells = <1>;
-			#size-cells = <1>;
-
-			firmware-name = "soc_image2.rbf";
-			partial-fpga-config;
-
-			gpio@10040 {
-				compatible = "altr,pio-1.0";
-				reg = <0x10040 0x20>;
-				clocks = <0x2>;
-				altr,ngpio = <0x4>;
-				#gpio-cells = <0x2>;
-				gpio-controller;
-			};
-		};
+/dts-v1/;
+/plugin/;
+
+&fpga_region1 {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	firmware-name = "soc_image2.rbf";
+	partial-fpga-config;
+
+	gpio@10040 {
+		compatible = "altr,pio-1.0";
+		reg = <0x10040 0x20>;
+		clocks = <0x2>;
+		altr,ngpio = <0x4>;
+		#gpio-cells = <0x2>;
+		gpio-controller;
 	};
 };
 
-- 
2.25.1


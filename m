Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 978756D1873
	for <lists+linux-fpga@lfdr.de>; Fri, 31 Mar 2023 09:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbjCaHTN (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 31 Mar 2023 03:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbjCaHTG (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 31 Mar 2023 03:19:06 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90066A273;
        Fri, 31 Mar 2023 00:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1680247142; x=1711783142;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hOfRnZh6joD9wrKnKMqNIhxc6oY1UO42spl4a8bgXYg=;
  b=p+pAoPDAIAcumZB5AdliJCRQOVsu0DATmCbTijlEfjoN9mMxF7/gyotI
   Xi06pw+yrj/ZdXbPsGH5sM6KR4iGB5QFM3UcE8JHzjephEZiNon/YO9E+
   U9/lM+ldGb8ApE8oTHKzkVfyMIWV5EB2QrnvHty+hqxOoirEiYDNWOeIm
   8XraH3bgkiU170JlUhQ65N07GUzCpZvmvgiE7kPO7De2rtSBhWGTlUiFA
   +iJIp0bNm8dxGEKUyl80S7KDeuDCljq0YaXuw+AaPEhts/KAfxBOI4dDt
   ZolMTXh+sjxNsqPddbO+IL8FwkmbCmi2JIqqFODSZd3bmNRVGER8wN3Kt
   A==;
X-IronPort-AV: E=Sophos;i="5.98,307,1673938800"; 
   d="scan'208";a="207148840"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Mar 2023 00:19:02 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 31 Mar 2023 00:19:01 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Fri, 31 Mar 2023 00:18:59 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     <linux-fpga@vger.kernel.org>
CC:     <conor@kernel.org>, <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 7/7] riscv: dts: microchip: add the mpfs' system controller qspi & associated flash
Date:   Fri, 31 Mar 2023 08:18:23 +0100
Message-ID: <20230331071823.956087-8-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230331071823.956087-1-conor.dooley@microchip.com>
References: <20230331071823.956087-1-conor.dooley@microchip.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3434; i=conor.dooley@microchip.com; h=from:subject; bh=hOfRnZh6joD9wrKnKMqNIhxc6oY1UO42spl4a8bgXYg=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDClqnVYFDlmR03ij2ZbP4wgyY/fMn+u9JmHD/9bG5skVne+0 JEU6SlkYxDgYZMUUWRJv97VIrf/jssO55y3MHFYmkCEMXJwCMJFF8xn+KVX/PD3ls2DwcadG5QmWcr Z/jt44leFnNeHy2XOff0xj3snI8Ms/pTzuhbiwB897zYUr4vwDFi1vkmE48nC2v/azLfUPGQE=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The system controller's flash can be accessed via an MSS-exposed QSPI
controller sitting, which sits between the mailbox's control & data
registers. On Icicle, it has an MT25QL01GBBB8ESF connected to it.

The system controller and MSS both have separate QSPI controllers, both
of which can access the flash, although the system controller takes
priority.
Unfortunately, on engineering sample silicon, such as that on Icicle
kits, the MSS' QSPI controller cannot write to the flash due to a bug.
As a workaround, a QSPI controller can be implemented in the FPGA
fabric and the IO routing modified to connect it to the flash in place
of the "hard" controller in the MSS.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../boot/dts/microchip/mpfs-icicle-kit.dts    | 21 ++++++++++++++++
 arch/riscv/boot/dts/microchip/mpfs.dtsi       | 24 ++++++++++++++-----
 2 files changed, 39 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts b/arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts
index 90b261114763..2dae3f8f33f6 100644
--- a/arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts
+++ b/arch/riscv/boot/dts/microchip/mpfs-icicle-kit.dts
@@ -199,6 +199,27 @@ &syscontroller {
 	status = "okay";
 };
 
+&syscontroller_qspi {
+	/*
+	 * The flash *is* there, but Icicle kits that have engineering sample
+	 * silicon (write?) access to this flash to non-functional. The system
+	 * controller itself can actually access it, but the MSS cannot write
+	 * an image there. Instantiating a coreQSPI in the fabric & connecting
+	 * it to the flash instead should work though. Pre-production or later
+	 * silicon does not have this issue.
+	 */
+	status = "disabled";
+
+	sys_ctrl_flash: flash@0 { // MT25QL01GBBB8ESF-0SIT
+		compatible = "jedec,spi-nor";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		spi-max-frequency = <20000000>;
+		spi-rx-bus-width = <1>;
+		reg = <0>;
+	};
+};
+
 &usb {
 	status = "okay";
 	dr_mode = "host";
diff --git a/arch/riscv/boot/dts/microchip/mpfs.dtsi b/arch/riscv/boot/dts/microchip/mpfs.dtsi
index 0a9bb84af438..568da2b570c0 100644
--- a/arch/riscv/boot/dts/microchip/mpfs.dtsi
+++ b/arch/riscv/boot/dts/microchip/mpfs.dtsi
@@ -173,11 +173,6 @@ refclk: mssrefclk {
 		#clock-cells = <0>;
 	};
 
-	syscontroller: syscontroller {
-		compatible = "microchip,mpfs-sys-controller";
-		mboxes = <&mbox 0>;
-	};
-
 	soc {
 		#address-cells = <2>;
 		#size-cells = <2>;
@@ -498,11 +493,28 @@ usb: usb@20201000 {
 
 		mbox: mailbox@37020000 {
 			compatible = "microchip,mpfs-mailbox";
-			reg = <0x0 0x37020000 0x0 0x1000>, <0x0 0x2000318C 0x0 0x40>;
+			reg = <0x0 0x37020000 0x0 0x58>, <0x0 0x2000318C 0x0 0x40>,
+			      <0x0 0x37020800 0x0 0x100>;
 			interrupt-parent = <&plic>;
 			interrupts = <96>;
 			#mbox-cells = <1>;
 			status = "disabled";
 		};
+
+		syscontroller_qspi: spi@37020100 {
+			compatible = "microchip,mpfs-qspi", "microchip,coreqspi-rtl-v2";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x0 0x37020100 0x0 0x100>;
+			interrupt-parent = <&plic>;
+			interrupts = <110>;
+			clocks = <&clkcfg CLK_QSPI>; /* this is probably wrong, consult the docs! */
+			status = "disabled";
+		};
+	};
+
+	syscontroller: syscontroller {
+		compatible = "microchip,mpfs-sys-controller";
+		mboxes = <&mbox 0>;
 	};
 };
-- 
2.39.2


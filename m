Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 762B769B141
	for <lists+linux-fpga@lfdr.de>; Fri, 17 Feb 2023 17:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbjBQQlW (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 17 Feb 2023 11:41:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbjBQQlT (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 17 Feb 2023 11:41:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF1A972E11;
        Fri, 17 Feb 2023 08:41:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5C0B7B82CB5;
        Fri, 17 Feb 2023 16:41:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83AB1C433D2;
        Fri, 17 Feb 2023 16:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676652059;
        bh=AjGLCJDaBLeS+ZJn3SLxobc8nrc/IffXtF3vDUxqz3g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DJZUfZJnxBBHc7U58XjuoN3nKx5tYwwfWvMR2Th9MWOHCJUNLBLpQTvlzEzhANqBg
         9/3/flM25H3zbd4a4lV/1IVmMkTLVbyu7b9/w3JPxK792qbt5lqq0SuCrIOpnocGei
         JamiHe3RWjCsfJIUVjC1n0pPX2XJWAAyz+hzWt8Po4zzy7bjZRNSU6SZiPc/CK8zz7
         vI+i/ytI7wIXaKDnkznja8D9vqq1gl+bAPHa0aLz7zLB3QDf7A0ua7/b5wbo7DCT8P
         KeYv8P+PWww3Gr8MMYyQp/cgpX5KP8xXe9XvT6LV+mrqLJmnEq3zR2rijr64wboTTS
         q4hT3s5P+3F1A==
From:   Conor Dooley <conor@kernel.org>
To:     Xu Yilun <yilun.xu@intel.com>, conor@kernel.org
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: [PATCH v1 6/6] riscv: dts: microchip: add the mpfs' system controller qspi & associated flash
Date:   Fri, 17 Feb 2023 16:40:23 +0000
Message-Id: <20230217164023.14255-7-conor@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230217164023.14255-1-conor@kernel.org>
References: <20230217164023.14255-1-conor@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3434; i=conor.dooley@microchip.com; h=from:subject; bh=zi1BUMETDrjgTzSYci2/43ZGtuWfx3kHNh6ZsIx3EnU=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDMnv174taji+aGd1T7v7hmnptxf0/j/+TWbS4esnvu5es1/p zo3bNh2lLAxiHAyyYoosibf7WqTW/3HZ4dzzFmYOKxPIEAYuTgGYSEc7I8Pxv0r/94uLtlyYuI05O9 Mz3lZ6QmVdj3j8kpg5W/b9z4lmZLgfxHNHOGcjq8mVBye2SveKfDypZT6Z64XQxI0XbRZtrGYHAA==
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

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
2.39.1


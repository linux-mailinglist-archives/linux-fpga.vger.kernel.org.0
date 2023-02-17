Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6F3969B137
	for <lists+linux-fpga@lfdr.de>; Fri, 17 Feb 2023 17:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbjBQQkw (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 17 Feb 2023 11:40:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbjBQQkt (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 17 Feb 2023 11:40:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CAAA6FF1E;
        Fri, 17 Feb 2023 08:40:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B150561EE5;
        Fri, 17 Feb 2023 16:40:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 906D2C433A0;
        Fri, 17 Feb 2023 16:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676652047;
        bh=8Pkfc5Vtr1bS1mfUGRyytTI2Goy5iCLpHwo24Vj3Z4Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iZopDMN/t/u+V8+JAFkyK6Easm2YKxMfzovzbDhLKTTW2uoA5pibaW9nNphyrlgPz
         dJ0fJ20e9NpMGoo7A4gTbsCDA9XlNt//MDfR/QQfs6TqzccOPsfWC2JWhmEVadY5lY
         /8eW3K6sYTTm32hR2LP0uqhZybx1CHfx5zvrwehpKfHTaP+q5vPqwQsmsVcGGLm67g
         tT5D1SgNpCHUnyRhYhh6dh6dChwNcNqFZ9DvBV6EwVxLwb6dQFiWVlW7ghGkIJmFaz
         Ipj1QHKjMN5wzFrTSDrcI2hhrUOt7IQGf23kVgVHcrOZSlrS8UOzauNiq+iEkmVlez
         4qJe7N94WqvOA==
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
Subject: [PATCH v1 2/6] dt-bindings: soc: microchip: add a property for system controller flash
Date:   Fri, 17 Feb 2023 16:40:19 +0000
Message-Id: <20230217164023.14255-3-conor@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230217164023.14255-1-conor@kernel.org>
References: <20230217164023.14255-1-conor@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1632; i=conor.dooley@microchip.com; h=from:subject; bh=fTElDZa5UroElstrQ0dzqW+hmPb678nX3XRMkYJvFsI=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDMnv17498Deyouk5h1zP2z+h8+6vbr/qvOLkvAp5xQ4Lz/CX 0mcXd5SyMIhxMMiKKbIk3u5rkVr/x2WHc89bmDmsTCBDGLg4BWAix88yMpz/c+1uxwu1xe8XzvD6o7 9m46nA+kczWkVF1IVXJM3dNi+e4Z/NJD0Wl4fxFZF8+c4Ta/pbGO9NWxbErHfykcLz/RFq6lwA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

The system controller "shares" a SPI flash device with a QSPI controller
in the MSS. This flash is used to store FPGA bitstreams & other
metadata. IAP and Auto Upgrade both write images to this flash that the
System Controller will use to re-program the FPGA.

Add a phandle property signifying which flash device is connected to the
system controller.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../soc/microchip/microchip,mpfs-sys-controller.yaml   | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/microchip/microchip,mpfs-sys-controller.yaml b/Documentation/devicetree/bindings/soc/microchip/microchip,mpfs-sys-controller.yaml
index 04ffee3a7c59..97a7cb74cbf9 100644
--- a/Documentation/devicetree/bindings/soc/microchip/microchip,mpfs-sys-controller.yaml
+++ b/Documentation/devicetree/bindings/soc/microchip/microchip,mpfs-sys-controller.yaml
@@ -26,6 +26,16 @@ properties:
   compatible:
     const: microchip,mpfs-sys-controller
 
+  microchip,bitstream-flash:
+    $ref: "/schemas/types.yaml#/definitions/phandle"
+    description:
+      The SPI flash connected to the system controller's QSPI controller.
+      The system controller may retrieve FPGA bitstreams from this flash to
+      perform In-Application Programming (IAP) or during device initialisation
+      for Auto Update. The MSS and system controller have separate QSPI
+      controllers and this flash is connected to both. Software running in the
+      MSS can write bitstreams to the flash.
+
 required:
   - compatible
   - mboxes
-- 
2.39.1


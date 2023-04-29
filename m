Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 743C06F245D
	for <lists+linux-fpga@lfdr.de>; Sat, 29 Apr 2023 12:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbjD2KxJ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 29 Apr 2023 06:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjD2KxI (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 29 Apr 2023 06:53:08 -0400
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2B51737;
        Sat, 29 Apr 2023 03:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding:
         in-reply-to:references;
        bh=0PyCfhAWDVAWva6rWT5Nk8RbNax9fE6QpdYvbE2fN1o=;
        b=lYG3QWLMbyXfgYsx9C3TRv7utJnO1vczZEUNN47jlN7LWMTVi35MVg1l2fu7mdoxe0p3Uz5p7vYi8
         joGsA4oyXrffah6J+cdnZd0ktShOUQHXG9kApQXRh5ZmRDXDNWytmlv4jgPo5s11mAJTPvJYF+9HVe
         DwkEbI/FEvHQWEYYejyB1N2uZoy2ebXHzXM21t2O0uMaKAJCMEAcL38Djy2dcbY2D0xza1SEfvQbPU
         gLEuOP0jChZSqC9lz0xNq2wLGLjnBLRqdGAADxZVUeFbc9RERicTkFoOCnLKYaSPJ/MTwrP7S0uXwx
         abVD85tBa6hf5zUZ4cN2MCXepXbCAkQ==
X-Kerio-Anti-Spam:  Build: [Engines: 2.17.2.1477, Stamp: 3], Multi: [Enabled, t: (0.000011,0.009827)], BW: [Enabled, t: (0.000024,0.000001)], RTDA: [Enabled, t: (0.085764), Hit: No, Details: v2.49.0; Id: 15.pfspt.1gv6a9oi4.1dkuf; mclb], total: 0(700)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from h-e2.ddg ([85.143.252.66])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Sat, 29 Apr 2023 13:52:47 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
To:     linux-kernel@vger.kernel.org
Cc:     Ivan Bornyakov <i.bornyakov@metrotek.ru>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Vladimir Georgiev <v.georgiev@metrotek.ru>, system@metrotek.ru,
        linux-fpga@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v3 2/2] dt-bindings: fpga: replace Ivan Bornyakov maintainership
Date:   Sat, 29 Apr 2023 13:48:38 +0300
Message-Id: <20230429104838.5064-3-i.bornyakov@metrotek.ru>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230429104838.5064-1-i.bornyakov@metrotek.ru>
References: <20230429104838.5064-1-i.bornyakov@metrotek.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

As I'm leaving Metrotek, hand over Lattice Slave SPI sysCONFIG FPGA
manager and Microchip Polarfire FPGA manager maintainership duties to
Vladimir.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Vladimir Georgiev <v.georgiev@metrotek.ru>
Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>
---
 Documentation/devicetree/bindings/fpga/lattice,sysconfig.yaml   | 2 +-
 .../devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/fpga/lattice,sysconfig.yaml b/Documentation/devicetree/bindings/fpga/lattice,sysconfig.yaml
index 4fb05eb84e2a..164331eb6275 100644
--- a/Documentation/devicetree/bindings/fpga/lattice,sysconfig.yaml
+++ b/Documentation/devicetree/bindings/fpga/lattice,sysconfig.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Lattice Slave SPI sysCONFIG FPGA manager
 
 maintainers:
-  - Ivan Bornyakov <i.bornyakov@metrotek.ru>
+  - Vladimir Georgiev <v.georgiev@metrotek.ru>
 
 description: |
   Lattice sysCONFIG port, which is used for FPGA configuration, among others,
diff --git a/Documentation/devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml b/Documentation/devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml
index 527532f039ce..a157eecfb5fc 100644
--- a/Documentation/devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml
+++ b/Documentation/devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Microchip Polarfire FPGA manager.
 
 maintainers:
-  - Ivan Bornyakov <i.bornyakov@metrotek.ru>
+  - Vladimir Georgiev <v.georgiev@metrotek.ru>
 
 description:
   Device Tree Bindings for Microchip Polarfire FPGA Manager using slave SPI to
-- 
2.40.0



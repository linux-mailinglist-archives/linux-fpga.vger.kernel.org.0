Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 369246EEFFD
	for <lists+linux-fpga@lfdr.de>; Wed, 26 Apr 2023 10:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240088AbjDZIK2 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 26 Apr 2023 04:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239908AbjDZIKY (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 26 Apr 2023 04:10:24 -0400
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69EE249D8
        for <linux-fpga@vger.kernel.org>; Wed, 26 Apr 2023 01:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding:
         in-reply-to:references;
        bh=rzqh9JFsCU0kabuMUMIh7+lJvsZRnxF/8gNrWseor3E=;
        b=Vu/qfY5c5OwLjVDZSKmGHbxv7updnr7N1YvETUqfVtK8bo6eedP7oUnXU4fB9Tllly8dsCFqvRpYt
         xUgYjMMwbpX74UWWAws1Tn9vxWKVNnHw4Vt8GR+YzLdABcPrukE/+MGnmbQ7pDEioEcwtg9csLTaFL
         K81075AeZ+AjF0Qf4Ig3BdykiDYiv0r6f6KqwB/3RHO2ZI1sH8wRT22617WpGF0yn0zYISSGcSt4zl
         cEy+S/b6ftOWgUQKkseztWbLtO0kFDXTz1d5KaNohrmoNTmFB8xmVrzjgee+onF9gQv6CQDWf0A4jw
         YaTLmK7mT33TecMLU7AEzq0NAP86E6g==
X-Kerio-Anti-Spam:  Build: [Engines: 2.17.2.1477, Stamp: 3], Multi: [Enabled, t: (0.000008,0.009622)], BW: [Enabled, t: (0.000016,0.000001)], RTDA: [Enabled, t: (0.101347), Hit: No, Details: v2.49.0; Id: 15.9lqkh.1guu81jg1.1bkd; mclb], total: 0(700)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from h-e2.ddg ([85.143.252.66])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Wed, 26 Apr 2023 10:39:29 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
To:     linux-kernel@vger.kernel.org
Cc:     Ivan Bornyakov <i.bornyakov@metrotek.ru>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>, system@metrotek.ru,
        linux-fpga@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: fpga: replace Ivan Bornyakov maintainership
Date:   Wed, 26 Apr 2023 10:35:19 +0300
Message-Id: <20230426073519.9167-3-i.bornyakov@metrotek.ru>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230426073519.9167-1-i.bornyakov@metrotek.ru>
References: <20230426073519.9167-1-i.bornyakov@metrotek.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

As I'm leaving Metrotek and my Metrotek email will be off soon, replace
it with Metrotek System Team collective inbox.

Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>
---
 Documentation/devicetree/bindings/fpga/lattice,sysconfig.yaml   | 2 +-
 .../devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/fpga/lattice,sysconfig.yaml b/Documentation/devicetree/bindings/fpga/lattice,sysconfig.yaml
index 4fb05eb84e2a..ea347248de26 100644
--- a/Documentation/devicetree/bindings/fpga/lattice,sysconfig.yaml
+++ b/Documentation/devicetree/bindings/fpga/lattice,sysconfig.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Lattice Slave SPI sysCONFIG FPGA manager
 
 maintainers:
-  - Ivan Bornyakov <i.bornyakov@metrotek.ru>
+  - STC Metrotek System Team <system@metrotek.ru>
 
 description: |
   Lattice sysCONFIG port, which is used for FPGA configuration, among others,
diff --git a/Documentation/devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml b/Documentation/devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml
index 527532f039ce..0226343bf24a 100644
--- a/Documentation/devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml
+++ b/Documentation/devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Microchip Polarfire FPGA manager.
 
 maintainers:
-  - Ivan Bornyakov <i.bornyakov@metrotek.ru>
+  - STC Metrotek System Team <system@metrotek.ru>
 
 description:
   Device Tree Bindings for Microchip Polarfire FPGA Manager using slave SPI to
-- 
2.40.0



Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8B96F1A37
	for <lists+linux-fpga@lfdr.de>; Fri, 28 Apr 2023 16:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345926AbjD1OGj (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 28 Apr 2023 10:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239683AbjD1OGi (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 28 Apr 2023 10:06:38 -0400
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6D126BC;
        Fri, 28 Apr 2023 07:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding:
         in-reply-to:references;
        bh=q8zcS4eSpLOU+KM3Wsz07PCE+lkv5k2H0fjoK3Tf61A=;
        b=Jz4ShgvhOp0AjDyYF5HFxRhmaNfl98bCm+qpITBdRYOT+bfXa5MUJ0WtZgOYjMG3HgTgVg997b+lZ
         XK49ezrXGRUtAHQWIMyHmnHNtmQ+uW089YbDmTlciTEuQyTZw2ZiDrE8dvuN5RZ4Qz+YJKElEavF8J
         UIXQEAqtNa/Wtes/5zDJYP+XutFRmRCLFJPN0+nQq6qTk7z7J5YOgKCdrY3sEN5bnbYKQbGp0moHk9
         RocyQrANCde6dT6kGeX/8yY1/vJ+4czIv3zJhHUxUjymZqbUlcIfj5rkfT1ot65P1nDKAtgKqVYGq6
         6xzORmxjOH2uFPj9DK3/FH93z25GNog==
X-Kerio-Anti-Spam:  Build: [Engines: 2.17.2.1477, Stamp: 3], Multi: [Enabled, t: (0.000008,0.009770)], BW: [Enabled, t: (0.000016,0.000001)], RTDA: [Enabled, t: (0.098375), Hit: No, Details: v2.49.0; Id: 15.pmd6d.1gv42uom2.8dpe; mclb], total: 0(700)
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
        Fri, 28 Apr 2023 17:05:59 +0300
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
Subject: [PATCH v2 2/2] dt-bindings: fpga: replace Ivan Bornyakov maintainership
Date:   Fri, 28 Apr 2023 17:01:50 +0300
Message-Id: <20230428140150.2592-3-i.bornyakov@metrotek.ru>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230428140150.2592-1-i.bornyakov@metrotek.ru>
References: <20230428140150.2592-1-i.bornyakov@metrotek.ru>
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

Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>
Signed-off-by: Vladimir Georgiev <v.georgiev@metrotek.ru>
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



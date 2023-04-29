Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE5FB6F245E
	for <lists+linux-fpga@lfdr.de>; Sat, 29 Apr 2023 12:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbjD2KxJ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 29 Apr 2023 06:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjD2KxI (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 29 Apr 2023 06:53:08 -0400
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315A41994;
        Sat, 29 Apr 2023 03:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding:
         in-reply-to:references;
        bh=dDUhgU3gdliI7An9gdYhWkmwO+R1aeFHiwe9G48NKWk=;
        b=FETLqAiO5Sfv2dVgh2bNDM7TkqG0f2p0qWHhn+u3rSXyzit8wbjD/Q9uBQ0PYjoLU+sxuP6j+eOiy
         OjEe1/H8LNaD4x4u5oZffiLJ52KIkdZwsm3m9aAlW754WYVXa9WX1MQToa2rTnfu5GCR1hZjgWe0bh
         ubDm35G/VLe1Qq09Heug9h7fDpSsnRDJxWcQAlmeQY6sFTzt+qtxB+0B+4noL+tXY8PE3kIWCR1LvU
         nSXjqbYtLsDCeR+iATvX17L59HcrtChrc5fFPBB25JKjpefZODd7JJv3Fv11fD3SBmLkZJ+rkpyEMv
         tdfH6hhUT3MbmqDgU6ListZWWvSg5IA==
X-Kerio-Anti-Spam:  Build: [Engines: 2.17.2.1477, Stamp: 3], Multi: [Enabled, t: (0.000005,0.006136)], BW: [Enabled, t: (0.000017,0.000001)], RTDA: [Enabled, t: (0.109029), Hit: No, Details: v2.49.0; Id: 15.fqtxn.1gv6a9mjv.m30; mclb], total: 0(700)
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
        Sat, 29 Apr 2023 13:52:46 +0300
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
Subject: [PATCH v3 1/2] MAINTAINERS: update Microchip MPF FPGA reviewers
Date:   Sat, 29 Apr 2023 13:48:37 +0300
Message-Id: <20230429104838.5064-2-i.bornyakov@metrotek.ru>
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

As I'm leaving Metrotek, hand over reviewing duty of Microchip MPF FPGA
driver to Vladimir.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Vladimir Georgiev <v.georgiev@metrotek.ru>
Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a81ba8328704..aab9fbb20362 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8100,7 +8100,7 @@ F:	drivers/fpga/intel-m10-bmc-sec-update.c
 
 MICROCHIP POLARFIRE FPGA DRIVERS
 M:	Conor Dooley <conor.dooley@microchip.com>
-R:	Ivan Bornyakov <i.bornyakov@metrotek.ru>
+R:	Vladimir Georgiev <v.georgiev@metrotek.ru>
 L:	linux-fpga@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml
-- 
2.40.0



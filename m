Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2FD6F1A36
	for <lists+linux-fpga@lfdr.de>; Fri, 28 Apr 2023 16:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbjD1OGi (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 28 Apr 2023 10:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjD1OGh (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 28 Apr 2023 10:06:37 -0400
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E585D26A6;
        Fri, 28 Apr 2023 07:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding:
         in-reply-to:references;
        bh=IXYi3aZjGGXCZazQVo7X+EG+FTa3w/hr5bbTwCJq9Nc=;
        b=Qd7p5RT09yWhjXdjNs8UlR7LoXo9ne2+mqRC1Cg8XMp533Dm5cavNhi5ZQW9XhkvI0xNnLVhkbn/H
         JDBVPm5aDt40FuVh+xWFflb6hidbgZb9gsvOIeQ0j5NdSkP11X/rhDTSN53E91VdLD9913HVOSq8GW
         6dUerqNOkhMOAZDpZ14kKUzvKyADbf10gC804ERfVJlQwuqbTGez6ktXrDQGdD1IiBdlz1qR6XrYlb
         pTtzQmoKK8rGU8NJgmuU4PolStCfPKjeeAZ0AWed1TPlWSZhePPjSyF5Oow0yIjj5It3hfpnkfOWC5
         BKzhJUDz6zYBIGUm9GOg4DcA2NHnaxA==
X-Kerio-Anti-Spam:  Build: [Engines: 2.17.2.1477, Stamp: 3], Multi: [Enabled, t: (0.000009,0.005894)], BW: [Enabled, t: (0.000019,0.000001)], RTDA: [Enabled, t: (0.109427), Hit: No, Details: v2.49.0; Id: 15.xkggt.1gv42uom1.pifq; mclb], total: 0(700)
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
        Fri, 28 Apr 2023 17:05:58 +0300
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
Subject: [PATCH v2 1/2] MAINTAINERS: update Microchip MPF FPGA reviewers
Date:   Fri, 28 Apr 2023 17:01:49 +0300
Message-Id: <20230428140150.2592-2-i.bornyakov@metrotek.ru>
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

As I'm leaving Metrotek, hand over reviewing duty of Microchip MPF FPGA
driver to Vladimir.

Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>
Signed-off-by: Vladimir Georgiev <v.georgiev@metrotek.ru>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4b8971cba764..aea13e060442 100644
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



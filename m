Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80EBD6EEFFE
	for <lists+linux-fpga@lfdr.de>; Wed, 26 Apr 2023 10:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240156AbjDZIK3 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 26 Apr 2023 04:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239826AbjDZIKY (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 26 Apr 2023 04:10:24 -0400
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D7E469B;
        Wed, 26 Apr 2023 01:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding:
         in-reply-to:references;
        bh=NxC/jPXqC7aEO8nGXZSk/aRp67gMVY+hdJrzh3qtRbk=;
        b=WqJ8IBsTAfiwk4k/CJxjzuFaRXfc7TN7Rz6WSjbetfBhSgs4ObctEpyQ1O0SHAt8ZsqRiYSR5JVJE
         vZVdhVb+3HWwx31CTAbYU2kpBJgjAX/3TOoBMJA59HrfNLm4jEqlY8j5HfwDsfF7meKfZ1DjqQd9CP
         3Yiucs07lFCqkLOerUe17z/rUOyUcEE6ZWnjt2azbqDhGPrjgMbIxVjmnTQyHGdZz54tWi757hSON0
         XSbq5piqoyI9CoQUWiSP/UeQHS77gg4hu5UUNpKNBnpCanzr9Iq53v206GMoC4wg8BBA2vHtlIFZNR
         V9pBiy1kw843QuTE2uHaMp2RuvjjuqA==
X-Kerio-Anti-Spam:  Build: [Engines: 2.17.2.1477, Stamp: 3], Multi: [Enabled, t: (0.000010,0.005926)], BW: [Enabled, t: (0.000020,0.000001)], RTDA: [Enabled, t: (0.101301), Hit: No, Details: v2.49.0; Id: 15.fz7nw.1guu81jft.5pu; mclb], total: 0(700)
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
        Wed, 26 Apr 2023 10:39:28 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
To:     linux-kernel@vger.kernel.org
Cc:     Ivan Bornyakov <i.bornyakov@metrotek.ru>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>, system@metrotek.ru,
        linux-fpga@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 1/2] MAINTAINERS: update Microchip MPF FPGA reviewers
Date:   Wed, 26 Apr 2023 10:35:18 +0300
Message-Id: <20230426073519.9167-2-i.bornyakov@metrotek.ru>
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

As I'm leaving Metrotek, I'll have no access to the hardware and my
Metrotek email will be off soon. Replace my email with Metrotek System
Team collective inbox.

Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f50945bb7d1b..94b185972aca 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8100,7 +8100,7 @@ F:	drivers/fpga/intel-m10-bmc-sec-update.c
 
 MICROCHIP POLARFIRE FPGA DRIVERS
 M:	Conor Dooley <conor.dooley@microchip.com>
-R:	Ivan Bornyakov <i.bornyakov@metrotek.ru>
+R:	system@metrotek.ru
 L:	linux-fpga@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml
-- 
2.40.0



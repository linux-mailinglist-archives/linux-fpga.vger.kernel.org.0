Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF39557FFC
	for <lists+linux-fpga@lfdr.de>; Thu, 23 Jun 2022 18:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbiFWQd5 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 23 Jun 2022 12:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232152AbiFWQdz (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 23 Jun 2022 12:33:55 -0400
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA803ED34;
        Thu, 23 Jun 2022 09:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding:
         in-reply-to:references;
        bh=OrLn5Q0sfM7eS9qpF9n9MlSilXyC6AzkezqdHXRJHJE=;
        b=HMXkuQzmBJltpRycYMkr0E2fO2qrfHxFHB574gcF0X9QJo9EwXeoIZohMT06yGFX1MgLRyHOVbdSZ
         cuxt1jLaBOmiVFlff/jdN3icYhdW0EVWF+eoRRuwTQ1w9UzU5TpYlIUeUto+dsTO5qsRrtKsztvn7F
         FVLWpik2JRVSCKpDhtCH5h5Kxtva/yFGGp/2zOeFXMWb9Y5c//fzioG95vgNUgYXUnXjafQeDBVFxN
         rCvuT6he/VVCepxoO9jpahbB0h+Uf3sUXnAfHMX/7HvQZmLcitpG7hM6QnpglikLuyneM9a1ADLu/s
         BghAcXmwDjJFMf77qo284cDpHxnjsKw==
X-Kerio-Anti-Spam:  Build: [Engines: 2.16.3.1424, Stamp: 3], Multi: [Enabled, t: (0.000009,0.005981)], BW: [Enabled, t: (0.000020,0.000001)], RTDA: [Enabled, t: (0.073463), Hit: No, Details: v2.40.0; Id: 15.52k0dd.1g68mj0lp.emrc; mclb], total: 0(700)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from h-e2.ddg ([85.143.252.66])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Thu, 23 Jun 2022 19:33:38 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
To:     mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
        trix@redhat.com, corbet@lwn.net
Cc:     Ivan Bornyakov <i.bornyakov@metrotek.ru>,
        conor.dooley@microchip.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, system@metrotek.ru
Subject: [PATCH v22 5/5] MAINTAINERS: add Microchip PolarFire FPGA drivers entry
Date:   Thu, 23 Jun 2022 19:32:48 +0300
Message-Id: <20220623163248.3672-6-i.bornyakov@metrotek.ru>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220623163248.3672-1-i.bornyakov@metrotek.ru>
References: <20220623163248.3672-1-i.bornyakov@metrotek.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Add MAINTAINERS entry for the newly added Microchip PolarFire (MPF) FPGA
manager. Add myself as a reviewer and Conor Dooley as a maintainer.

Suggested-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Xu Yilun <yilun.xu@intel.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cd7a70782aaa..74df3812b37f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7895,6 +7895,14 @@ S:	Maintained
 F:	Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
 F:	drivers/fpga/intel-m10-bmc-sec-update.c
 
+MICROCHIP POLARFIRE FPGA DRIVERS
+M:	Conor Dooley <conor.dooley@microchip.com>
+R:	Ivan Bornyakov <i.bornyakov@metrotek.ru>
+L:	linux-fpga@vger.kernel.org
+S:	Supported
+F:	Documentation/devicetree/bindings/fpga/microchip,mpf-spi-fpga-mgr.yaml
+F:	drivers/fpga/microchip-spi.c
+
 FPU EMULATOR
 M:	Bill Metzenthen <billm@melbpc.org.au>
 S:	Maintained
-- 
2.36.1



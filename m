Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF9655167D
	for <lists+linux-fpga@lfdr.de>; Mon, 20 Jun 2022 13:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241124AbiFTLAJ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 20 Jun 2022 07:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240411AbiFTLAI (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 20 Jun 2022 07:00:08 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247EC55AE;
        Mon, 20 Jun 2022 04:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1655722807; x=1687258807;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c8QNBVZ8wFnmT7eCQXOvJyyFc4aUfS6m/vVmJyJk64g=;
  b=2swxPYfLMKjKWWzuxwGqtMijESKVe6ce8gtR0xKJyVNg8Bzmm3kTBrCh
   9x51HbGgO3JpwEJyxv2YsgQgDN6MbgLUv/tQ4vZfc+nfbBvxl9WuHwBRu
   e2UEpQ6mqpbd6QKgpolw45EcpfMAoPhISpVibfo7EibILPDmmZGU5cbt+
   byYU2sEJo3mE5Y11MK8IgDopUer+rubEoTy/E/V2LpPyWOQ05odZlT7rY
   zpCwiorq2J9kNM9FBnC/BTjl4WqAGt6eE5+PAEsA20VnFGZN05xDIk7LI
   jMMJaLorLCSwpPgPk4N1NaISgLM8Nf1Xvonn3omUInRd5yFY5nkHgU0TZ
   w==;
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="100805212"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Jun 2022 04:00:05 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 20 Jun 2022 04:00:05 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Mon, 20 Jun 2022 04:00:02 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     <i.bornyakov@metrotek.ru>
CC:     <Conor.Dooley@microchip.com>, <corbet@lwn.net>,
        <devicetree@vger.kernel.org>, <hao.wu@intel.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-doc@vger.kernel.org>,
        <linux-fpga@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <mdf@kernel.org>, <robh+dt@kernel.org>, <system@metrotek.ru>,
        <trix@redhat.com>, <yilun.xu@intel.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v20 0/4] Microchip Polarfire FPGA manager
Date:   Mon, 20 Jun 2022 11:57:48 +0100
Message-ID: <20220620105747.2145347-1-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220620100745.yxjmq2qtsicxlrgn@h-e2.ddg>
References: <20220620100745.yxjmq2qtsicxlrgn@h-e2.ddg>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

I had a quick check in -next and there's an entry for the BMC
driver there.
How about the following? I put you as R, but clearly if you want to be
maintainer then you are *more than* qualified.
Feel free to edit the patch if so, either is fine by me.
You can tack this onto a v21 if you have more changes or I can resend
standalone once the driver is merged.

Thanks,
Conor.

From: Conor Dooley <conor.dooley@microchip.com>
Date: Mon, 20 Jun 2022 11:46:19 +0100
Subject: [PATCH] MAINTAINERS: add polarfire fpga programmer drivers
Add a MAINTAINERS entry for the newly added PolarFire (MPF) SPI slave
programming driver.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 168e0af869a7..60ab3c4bf65d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7869,6 +7869,14 @@ S:	Maintained
 F:	Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
 F:	drivers/fpga/intel-m10-bmc-sec-update.c
 
+FPGA PolarFire Drivers
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

base-commit: 07dc787be2316e243a16a33d0a9b734cd9365bd3
-- 
2.36.1


Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A40516D186B
	for <lists+linux-fpga@lfdr.de>; Fri, 31 Mar 2023 09:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbjCaHS6 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 31 Mar 2023 03:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbjCaHS4 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 31 Mar 2023 03:18:56 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044E9AD20;
        Fri, 31 Mar 2023 00:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1680247130; x=1711783130;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v+iGAOoMCBTZGHjA4MlM8wSqYcR0Frqq6qIhcdJ6VMQ=;
  b=BOZDvfJQsxN8QBHrF1NGfWPKiLXHKJDBADxv1n1Rk0oDJtkuAuUbqxRM
   ses4DV9amd5YU2c1W5Ea466cDg6dfjEVsAe/jTYgONRUFJrfMQA/TWb+6
   CcdLzk0RhF22LLeEZxuyUDE4izzGfuGxXPPPkBkzMwaZTNbZ/IDA9h1fM
   AYjZZXLmk60puDcd/HWzzzjZpQ9qFNjSEhLOLsAF/qh1yIjXcgp50iS7n
   FT6RVicBWRSe0GusuCEUGwKXCu3mi8WeHEVlMx7p2dHH2PkYM9rC1Vsha
   GKk+hsI35Mblw2ThhckYfaKCVbQOVmULsIb9Vczo+9GXBV1oCNj6HPzxc
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,307,1673938800"; 
   d="scan'208";a="204349705"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Mar 2023 00:18:49 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 31 Mar 2023 00:18:46 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Fri, 31 Mar 2023 00:18:44 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     <linux-fpga@vger.kernel.org>
CC:     <conor@kernel.org>, <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/7] soc: microchip: mpfs: add a prefix to rx_callback()
Date:   Fri, 31 Mar 2023 08:18:17 +0100
Message-ID: <20230331071823.956087-2-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230331071823.956087-1-conor.dooley@microchip.com>
References: <20230331071823.956087-1-conor.dooley@microchip.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1311; i=conor.dooley@microchip.com; h=from:subject; bh=v+iGAOoMCBTZGHjA4MlM8wSqYcR0Frqq6qIhcdJ6VMQ=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDClqnZYdwexPn4oeOna7jq3DNefegq0nhZf/fnGl8NcJfqG0 bRPPdZSyMIhxMMiKKbIk3u5rkVr/x2WHc89bmDmsTCBDGLg4BWAicsIM/2z2J17J72e+Xq1+ZdthlR 8a5kU5nxKvz9r7zWzLD5bJdvEM/5RWHLM+vDBzSmu4MEeniEXxJv8kW31v7/UcRaUK06cKswAA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Add a prefix to the function name to match the rest of the file.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/soc/microchip/mpfs-sys-controller.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/microchip/mpfs-sys-controller.c b/drivers/soc/microchip/mpfs-sys-controller.c
index ceaeebc1fc6b..216d9f4ea0ce 100644
--- a/drivers/soc/microchip/mpfs-sys-controller.c
+++ b/drivers/soc/microchip/mpfs-sys-controller.c
@@ -75,7 +75,7 @@ int mpfs_blocking_transaction(struct mpfs_sys_controller *sys_controller, struct
 }
 EXPORT_SYMBOL(mpfs_blocking_transaction);
 
-static void rx_callback(struct mbox_client *client, void *msg)
+static void mpfs_sys_controller_rx_callback(struct mbox_client *client, void *msg)
 {
 	struct mpfs_sys_controller *sys_controller =
 		container_of(client, struct mpfs_sys_controller, client);
@@ -121,7 +121,7 @@ static int mpfs_sys_controller_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	sys_controller->client.dev = dev;
-	sys_controller->client.rx_callback = rx_callback;
+	sys_controller->client.rx_callback = mpfs_sys_controller_rx_callback;
 	sys_controller->client.tx_block = 1U;
 	sys_controller->client.tx_tout = msecs_to_jiffies(MPFS_SYS_CTRL_TIMEOUT_MS);
 
-- 
2.39.2


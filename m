Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A07069B13A
	for <lists+linux-fpga@lfdr.de>; Fri, 17 Feb 2023 17:42:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbjBQQk4 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 17 Feb 2023 11:40:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjBQQkx (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 17 Feb 2023 11:40:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BED86EF0A;
        Fri, 17 Feb 2023 08:40:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B0A6461EDE;
        Fri, 17 Feb 2023 16:40:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B645C4339B;
        Fri, 17 Feb 2023 16:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676652050;
        bh=s71zhhs0wecI4Nj/TiJBEe21bHckcl5t2kj31eKsk2c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o5dlIZsDSWDbpNjmUXNT8rcYz8bORxiOy20ztT1YlygZebRA6cwJZ0zlH53KP9xL2
         LPMUCAIVA/svO57gelYC4fUpHVsQooUFMOTxgXWa79tk2fWJJ97r+tD8t9Dm5nzgNw
         8GXP0ExwYEjcPc/cKFTCDmAz19idenfJc09u8vul9BfbIxXE8EqprlA3oUEhniMqyf
         q194fEcuGqMy2Y/dxmXbDY/9Vjen8KVI7ppHnwqkrHFPqcK7l7oGEp2czGyogtTGMA
         r+CWKMpmMuFey66/FSkOIlydAp4eBUpoP/StaIuMSwuxec6Ncx4DmMF/70aJ8Tu1lH
         VYwTs7M+uyosQ==
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
Subject: [PATCH v1 3/6] soc: microchip: mpfs: enable access to the system controller's flash
Date:   Fri, 17 Feb 2023 16:40:20 +0000
Message-Id: <20230217164023.14255-4-conor@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230217164023.14255-1-conor@kernel.org>
References: <20230217164023.14255-1-conor@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3442; i=conor.dooley@microchip.com; h=from:subject; bh=OKHGlsPAKNTTp6NanBTdt/Ki4XURpI/Var46Ky0xqoU=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDMnv1769ftcuntsoS4VZu9G6U0llpoLaY6XHgiV3Gvv1dRvu bQvrKGVhEONgkBVTZEm83dcitf6Pyw7nnrcwc1iZQIYwcHEKwETmHWX4K/Yxb6tE2OVJ3mZHFsyUTk n9IDXp5KwpC8Tn7WlY9NLDtoCRYbHNZw6xP3NOLFr9Wzxu977bCZdMTtk0xj2zCQiwdNzNyQYA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

The system controller has a flash that contains images used to reprogram
the FPGA using IAP (In-Application Programming).
Introduce a function that allows a driver with a reference to the system
controller to get one to a flash device attached to it.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/soc/microchip/Kconfig               |  1 +
 drivers/soc/microchip/mpfs-sys-controller.c | 20 ++++++++++++++++++++
 include/soc/microchip/mpfs.h                |  2 ++
 3 files changed, 23 insertions(+)

diff --git a/drivers/soc/microchip/Kconfig b/drivers/soc/microchip/Kconfig
index eb656b33156b..9b0fdd95276e 100644
--- a/drivers/soc/microchip/Kconfig
+++ b/drivers/soc/microchip/Kconfig
@@ -1,6 +1,7 @@
 config POLARFIRE_SOC_SYS_CTRL
 	tristate "POLARFIRE_SOC_SYS_CTRL"
 	depends on POLARFIRE_SOC_MAILBOX
+	depends on MTD
 	help
 	  This driver adds support for the PolarFire SoC (MPFS) system controller.
 
diff --git a/drivers/soc/microchip/mpfs-sys-controller.c b/drivers/soc/microchip/mpfs-sys-controller.c
index 11616e3c9ac8..bcbb4bab09e5 100644
--- a/drivers/soc/microchip/mpfs-sys-controller.c
+++ b/drivers/soc/microchip/mpfs-sys-controller.c
@@ -12,6 +12,8 @@
 #include <linux/kref.h>
 #include <linux/module.h>
 #include <linux/jiffies.h>
+#include <linux/mtd/mtd.h>
+#include <linux/spi/spi.h>
 #include <linux/interrupt.h>
 #include <linux/of_platform.h>
 #include <linux/mailbox_client.h>
@@ -30,6 +32,7 @@ struct mpfs_sys_controller {
 	struct mbox_client client;
 	struct mbox_chan *chan;
 	struct completion c;
+	struct mtd_info *flash;
 	struct kref consumers;
 };
 
@@ -97,6 +100,12 @@ static void mpfs_sys_controller_put(void *data)
 	kref_put(&sys_controller->consumers, mpfs_sys_controller_delete);
 }
 
+struct mtd_info *mpfs_sys_controller_get_flash(struct mpfs_sys_controller *mpfs_client)
+{
+	return mpfs_client->flash;
+}
+EXPORT_SYMBOL(mpfs_sys_controller_get_flash);
+
 static struct platform_device subdevs[] = {
 	{
 		.name		= "mpfs-rng",
@@ -112,12 +121,23 @@ static int mpfs_sys_controller_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct mpfs_sys_controller *sys_controller;
+	struct device_node *np;
 	int i, ret;
 
 	sys_controller = kzalloc(sizeof(*sys_controller), GFP_KERNEL);
 	if (!sys_controller)
 		return -ENOMEM;
 
+	np = of_parse_phandle(dev->of_node, "microchip,bitstream-flash", 0);
+	if (!np)
+		goto no_flash;
+
+	sys_controller->flash = of_get_mtd_device_by_node(np);
+	of_node_put(np);
+	if (IS_ERR(sys_controller->flash))
+		return dev_err_probe(dev, PTR_ERR(sys_controller->flash), "Failed to get flash\n");
+
+no_flash:
 	sys_controller->client.dev = dev;
 	sys_controller->client.rx_callback = mpfs_sys_controller_rx_callback;
 	sys_controller->client.tx_block = 1U;
diff --git a/include/soc/microchip/mpfs.h b/include/soc/microchip/mpfs.h
index f916dcde457f..09722f83b0ca 100644
--- a/include/soc/microchip/mpfs.h
+++ b/include/soc/microchip/mpfs.h
@@ -38,6 +38,8 @@ int mpfs_blocking_transaction(struct mpfs_sys_controller *mpfs_client, struct mp
 
 struct mpfs_sys_controller *mpfs_sys_controller_get(struct device *dev);
 
+struct mtd_info *mpfs_sys_controller_get_flash(struct mpfs_sys_controller *mpfs_client);
+
 #endif /* if IS_ENABLED(CONFIG_POLARFIRE_SOC_SYS_CTRL) */
 
 #if IS_ENABLED(CONFIG_MCHP_CLK_MPFS)
-- 
2.39.1


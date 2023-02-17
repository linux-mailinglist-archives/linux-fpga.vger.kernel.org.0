Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 873EE69B135
	for <lists+linux-fpga@lfdr.de>; Fri, 17 Feb 2023 17:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbjBQQkq (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 17 Feb 2023 11:40:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjBQQkq (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 17 Feb 2023 11:40:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3FC6BDCD;
        Fri, 17 Feb 2023 08:40:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9B0661EE5;
        Fri, 17 Feb 2023 16:40:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95E58C433D2;
        Fri, 17 Feb 2023 16:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676652044;
        bh=uqM+5rtlFlEeXSd/1anUI6DmVd10V3MqxkeZ8jvGqac=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YyjGX9s0fUOU95il4oo4Yxn3apt+m5I+pZ0R+kVThA/OZeL2ZvHMydDbh0GDLIYqM
         2vC68gXhJCSmmlz5f/04yN5wF5uzLl4Vuu7j+41Q0PS/u7Cw/qbaXJekWuJnxHnL3t
         CE8xyGoZ1db0PaMJTrmJTkeDEEpm7QUvqOlsQkigofx31jahniDpmjiK1lIEt/stEm
         6iql/fle5ABVBSzjNS89m/u8bCQ2khTRM3w5Xox9KSZ4mImQKVZAM2grkB/Y4v6Ymb
         MI3VnUUorUt/R5q1pico2pJv5lliR00loKesLKziA5R1bttuy+U96ssOfvRcKMNr0w
         1ueRrBCmT4fUA==
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
Subject: [PATCH v1 1/6] soc: microchip: mpfs: add a prefix to rx_callback()
Date:   Fri, 17 Feb 2023 16:40:18 +0000
Message-Id: <20230217164023.14255-2-conor@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230217164023.14255-1-conor@kernel.org>
References: <20230217164023.14255-1-conor@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1311; i=conor.dooley@microchip.com; h=from:subject; bh=RNzEefOhKfQMOBdza8p2YEG5lWs9FX5mqYbHLNGi5xk=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDMnv1759mjS3vey3XWWh/u+Eh2vL/2snBJVfX+B9R4LbJWnG fuYTHaUsDGIcDLJiiiyJt/tapNb/cdnh3PMWZg4rE8gQBi5OAZhI9xtGhjkCcm2uAefOlN69cmkz85 KXTV/DrvcKr3U9qZHx//aM/S0M//T+ON/84f/YXUf/9lSBmU8rHpj39xZd8dM9sW2zWUKWPxMA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

Add a prefix to the function name to match the rest of the file.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/soc/microchip/mpfs-sys-controller.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/microchip/mpfs-sys-controller.c b/drivers/soc/microchip/mpfs-sys-controller.c
index 973a748d324c..11616e3c9ac8 100644
--- a/drivers/soc/microchip/mpfs-sys-controller.c
+++ b/drivers/soc/microchip/mpfs-sys-controller.c
@@ -73,7 +73,7 @@ int mpfs_blocking_transaction(struct mpfs_sys_controller *sys_controller, struct
 }
 EXPORT_SYMBOL(mpfs_blocking_transaction);
 
-static void rx_callback(struct mbox_client *client, void *msg)
+static void mpfs_sys_controller_rx_callback(struct mbox_client *client, void *msg)
 {
 	struct mpfs_sys_controller *sys_controller =
 		container_of(client, struct mpfs_sys_controller, client);
@@ -119,7 +119,7 @@ static int mpfs_sys_controller_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	sys_controller->client.dev = dev;
-	sys_controller->client.rx_callback = rx_callback;
+	sys_controller->client.rx_callback = mpfs_sys_controller_rx_callback;
 	sys_controller->client.tx_block = 1U;
 	sys_controller->client.tx_tout = msecs_to_jiffies(MPFS_SYS_CTRL_TIMEOUT_MS);
 
-- 
2.39.1


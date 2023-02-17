Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA84969B13C
	for <lists+linux-fpga@lfdr.de>; Fri, 17 Feb 2023 17:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbjBQQlG (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 17 Feb 2023 11:41:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjBQQk6 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 17 Feb 2023 11:40:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B8D971CA1;
        Fri, 17 Feb 2023 08:40:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD9E961EEC;
        Fri, 17 Feb 2023 16:40:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 895C0C433D2;
        Fri, 17 Feb 2023 16:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676652053;
        bh=uGoJRv9LAzu1WKQhfnsYWd6U9roPlOaRoVRun8gS2As=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fYbtCpn1bJdYLzPGDJ4B6qBN8l0H9KP2b7UqP6Z44fszrR8RRn0UH05vq3cWrG3sP
         WPbEwvwakZnPsuVK1ayv7oHbL7qtVXiD3d7jaR89ROlOeNMLibIEjQSh3Fz+0k8SME
         84+tvbPleFuvFOUDCpXUYYnVyXOnwrg3tviCg+BygsWwIeumobi8TH9HPOcB+8Hszo
         y3BdHPxo9E4mAxTFXhEu3+s6UE+2nB4PFxEGX5vwZcuXICevF83QI2kZ0bLBm0Aowl
         MX0UTYmz1RSnn9G6WGlZaV7SX7LdvMjJ5arIGdNsJYbqkX7hvjy7rxqT11lV/ePOva
         3JxrWwMjN3JFA==
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
Subject: [PATCH v1 4/6] soc: microchip: mpfs: add auto-update subdev to system controller
Date:   Fri, 17 Feb 2023 16:40:21 +0000
Message-Id: <20230217164023.14255-5-conor@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230217164023.14255-1-conor@kernel.org>
References: <20230217164023.14255-1-conor@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1866; i=conor.dooley@microchip.com; h=from:subject; bh=ADNLFIuLz+bv6oLLm4KQdjoPfC5CtvF+uTlkACIcj0E=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDMnv175tEGV0j9HZ2vLvTNU+nerJm7euyfWawrkrQO497+9U nfl/OkpZGMQ4GGTFFFkSb/e1SK3/47LDuectzBxWJpAhDFycAjAR3vuMDHO5uJRuXvrQt1lxU9rXDX MdvlqEP77yrY95l3putZHK74eMDLsOLvw57errlJiDTJcn3OCdv+CW4oaVtvPF73xk2PVnjzsTAA==
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

The PolarFire SoC's system controller offers the ability to re-program
the FPGA from a user application via two, related, mechanisms.
In-Application Programming (IAP) is not ideal for use in Linux, as it
will immediately take down the system when requested. Auto Update is
preferred, as it will only take affect at device power up*, allowing the
OS (and potential applications in AMP) to be shut down gracefully.

* Auto Update occurs at device initialisation, which can also be
  triggered by device reset - possible with the v2023.02 version of the
  Hart Software Services (HSS) and reference design.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/soc/microchip/mpfs-sys-controller.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/microchip/mpfs-sys-controller.c b/drivers/soc/microchip/mpfs-sys-controller.c
index bcbb4bab09e5..223eec66edf9 100644
--- a/drivers/soc/microchip/mpfs-sys-controller.c
+++ b/drivers/soc/microchip/mpfs-sys-controller.c
@@ -114,7 +114,11 @@ static struct platform_device subdevs[] = {
 	{
 		.name		= "mpfs-generic-service",
 		.id		= -1,
-	}
+	},
+	{
+		.name		= "mpfs-auto-update",
+		.id		= -1,
+	},
 };
 
 static int mpfs_sys_controller_probe(struct platform_device *pdev)
@@ -156,7 +160,6 @@ static int mpfs_sys_controller_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, sys_controller);
 
-	dev_info(&pdev->dev, "Registered MPFS system controller\n");
 
 	for (i = 0; i < ARRAY_SIZE(subdevs); i++) {
 		subdevs[i].dev.parent = dev;
@@ -164,6 +167,8 @@ static int mpfs_sys_controller_probe(struct platform_device *pdev)
 			dev_warn(dev, "Error registering sub device %s\n", subdevs[i].name);
 	}
 
+	dev_info(&pdev->dev, "Registered MPFS system controller\n");
+
 	return 0;
 }
 
-- 
2.39.1


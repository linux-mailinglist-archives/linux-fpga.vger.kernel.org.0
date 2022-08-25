Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4595A1359
	for <lists+linux-fpga@lfdr.de>; Thu, 25 Aug 2022 16:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240229AbiHYOSc (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 25 Aug 2022 10:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238408AbiHYOOd (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 25 Aug 2022 10:14:33 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB33B6D08
        for <linux-fpga@vger.kernel.org>; Thu, 25 Aug 2022 07:14:19 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <jzi@pengutronix.de>)
        id 1oRDce-0002ws-U1; Thu, 25 Aug 2022 16:14:16 +0200
Received: from [2a0a:edc0:0:1101:1d::39] (helo=dude03.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <jzi@pengutronix.de>)
        id 1oRDce-001umu-2d; Thu, 25 Aug 2022 16:14:16 +0200
Received: from jzi by dude03.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <jzi@pengutronix.de>)
        id 1oRDcc-005xwF-0y; Thu, 25 Aug 2022 16:14:14 +0200
From:   Johannes Zink <j.zink@pengutronix.de>
To:     linux-fpga@vger.kernel.org
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, kernel@pengutronix.de,
        Johannes Zink <j.zink@pengutronix.de>
Subject: [PATCH 05/16] fpga: machxo2-spi: remove #ifdef DEBUG
Date:   Thu, 25 Aug 2022 16:13:32 +0200
Message-Id: <20220825141343.1375690-6-j.zink@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220825141343.1375690-1-j.zink@pengutronix.de>
References: <20220825141343.1375690-1-j.zink@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: jzi@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-fpga@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

This provides dynamic debug support, pr_debug checks anyway if DEBUG is
defined statically or is activated dynamically.

Signed-off-by: Johannes Zink <j.zink@pengutronix.de>
---
 drivers/fpga/machxo2-spi.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/fpga/machxo2-spi.c b/drivers/fpga/machxo2-spi.c
index 905607992a12..39dd62359821 100644
--- a/drivers/fpga/machxo2-spi.c
+++ b/drivers/fpga/machxo2-spi.c
@@ -88,7 +88,6 @@ static int get_status(struct spi_device *spi, unsigned long *status)
 	return 0;
 }
 
-#ifdef DEBUG
 static const char *get_err_string(u8 err)
 {
 	switch (err) {
@@ -104,16 +103,13 @@ static const char *get_err_string(u8 err)
 
 	return "Default switch case";
 }
-#endif
 
 static void dump_status_reg(unsigned long *status)
 {
-#ifdef DEBUG
 	pr_debug("machxo2 status: 0x%08lX - done=%d, cfgena=%d, busy=%d, fail=%d, devver=%d, err=%s\n",
 		 *status, test_bit(DONE, status), test_bit(ENAB, status),
 		 test_bit(BUSY, status), test_bit(FAIL, status),
 		 test_bit(DVER, status), get_err_string(get_err(status)));
-#endif
 }
 
 static int wait_until_not_busy(struct spi_device *spi)
-- 
2.30.2


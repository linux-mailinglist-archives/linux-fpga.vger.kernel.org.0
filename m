Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7770D5A134E
	for <lists+linux-fpga@lfdr.de>; Thu, 25 Aug 2022 16:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiHYORC (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 25 Aug 2022 10:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241969AbiHYOOe (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 25 Aug 2022 10:14:34 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF58B6D59
        for <linux-fpga@vger.kernel.org>; Thu, 25 Aug 2022 07:14:20 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <jzi@pengutronix.de>)
        id 1oRDcg-0002y5-1l; Thu, 25 Aug 2022 16:14:18 +0200
Received: from [2a0a:edc0:0:1101:1d::39] (helo=dude03.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <jzi@pengutronix.de>)
        id 1oRDcf-001unO-00; Thu, 25 Aug 2022 16:14:17 +0200
Received: from jzi by dude03.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <jzi@pengutronix.de>)
        id 1oRDcc-005xwI-1U; Thu, 25 Aug 2022 16:14:14 +0200
From:   Johannes Zink <j.zink@pengutronix.de>
To:     linux-fpga@vger.kernel.org
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, kernel@pengutronix.de,
        Johannes Zink <j.zink@pengutronix.de>
Subject: [PATCH 06/16] fpga: machxo2-spi: factor out status check for readability
Date:   Thu, 25 Aug 2022 16:13:33 +0200
Message-Id: <20220825141343.1375690-7-j.zink@pengutronix.de>
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

We have the same sequence at two different places, so factor it out
into a helper to improve readability.

Signed-off-by: Johannes Zink <j.zink@pengutronix.de>
---
 drivers/fpga/machxo2-spi.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/fpga/machxo2-spi.c b/drivers/fpga/machxo2-spi.c
index 39dd62359821..5e12612c7289 100644
--- a/drivers/fpga/machxo2-spi.c
+++ b/drivers/fpga/machxo2-spi.c
@@ -167,14 +167,19 @@ static int machxo2_cleanup(struct fpga_manager *mgr)
 	return ret;
 }
 
+static bool machxo2_status_done(unsigned long status)
+{
+	return !test_bit(BUSY, &status) && test_bit(DONE, &status) &&
+		get_err(&status) == ENOERR;
+}
+
 static enum fpga_mgr_states machxo2_spi_state(struct fpga_manager *mgr)
 {
 	struct spi_device *spi = mgr->priv;
 	unsigned long status;
 
 	get_status(spi, &status);
-	if (!test_bit(BUSY, &status) && test_bit(DONE, &status) &&
-	    get_err(&status) == ENOERR)
+	if (machxo2_status_done(status))
 		return FPGA_MGR_STATE_OPERATING;
 
 	return FPGA_MGR_STATE_UNKNOWN;
@@ -329,8 +334,7 @@ static int machxo2_write_complete(struct fpga_manager *mgr,
 		/* check refresh status */
 		get_status(spi, &status);
 		dump_status_reg(&status);
-		if (!test_bit(BUSY, &status) && test_bit(DONE, &status) &&
-		    get_err(&status) == ENOERR)
+		if (machxo2_status_done(status))
 			break;
 		if (++refreshloop == MACHXO2_MAX_REFRESH_LOOP) {
 			machxo2_cleanup(mgr);
-- 
2.30.2


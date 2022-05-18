Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9DE52B2F4
	for <lists+linux-fpga@lfdr.de>; Wed, 18 May 2022 09:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbiERGvj (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 18 May 2022 02:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231639AbiERGuT (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 18 May 2022 02:50:19 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557FA23BFA;
        Tue, 17 May 2022 23:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652856609; x=1684392609;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qLSSlJQUcJ7Jk5kyK0nA+TPrGxree8c3irzJ5UAVEoI=;
  b=fvZ86t9nKG2FzoVmnfT/jjPlUlhxc9Ag4PEOQH4NWiQX0XPZtYlv82Um
   Nh8+1+xvgS250c8FyN9gAQbh8C2YzhUFK2qB+hVgsDD3KfBJ4ukHEEDmP
   B6kZyHYEaQ3vfoYxkcG+UPTHCeQ6pncX2K6YVF066jjlLMQMpKj2A59d5
   dBe8q04YzRCcT0pO4WGFIasFw7fmRaZT/S5yZ57pzaMul1paCWC99yqqO
   BNkWlQBRXaAQa1Llj1VZazqhfQBI2hAYbZpw91M+NhlJO0ud7oYQmFuHP
   FI6DYFVwwxYRQkwoH/f8e7WIxdhG1nQg/ou7ykGxJEJYJqS/H7PfNt56+
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="357920239"
X-IronPort-AV: E=Sophos;i="5.91,234,1647327600"; 
   d="scan'208";a="357920239"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 23:50:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,234,1647327600"; 
   d="scan'208";a="817295163"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.90])
  by fmsmga006.fm.intel.com with ESMTP; 17 May 2022 23:50:06 -0700
From:   tien.sung.ang@intel.com
To:     mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
        trix@redhat.com
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ang Tien Sung <tien.sung.ang@intel.com>
Subject: [PATCH] fpga: altera-cvp: Truncated bitstream error support
Date:   Wed, 18 May 2022 14:48:44 +0800
Message-Id: <20220518064844.2694651-1-tien.sung.ang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Ang Tien Sung <tien.sung.ang@intel.com>

To support the error handling of a truncated bitstream sent.
The current AIB CvP firmware is not capable of handling a
data stream smaller than 4096bytes. The firmware's limitation
causes a hung-up as it's DMA engine waits forever for the
completion of the instructed 4096bytes.
To resolve this design limitation, both firmware and CvP
driver made several changes. At the CvP driver, we just
have to ensure that anything lesser than 4096bytes are
padded with extra bytes. The CvP will then, initiate the
tear-down by clearing the START_XFER and CVP_CONFIG bits.
We should also check for CVP_ERROR during the CvP completion.
A send_buf which is always 4096bytes is used to copy the
data during every transaction.

Signed-off-by: Ang Tien Sung <tien.sung.ang@intel.com>
---
 drivers/fpga/altera-cvp.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
index 4ffb9da537d8..80edcfb5e5fc 100644
--- a/drivers/fpga/altera-cvp.c
+++ b/drivers/fpga/altera-cvp.c
@@ -81,6 +81,7 @@ struct altera_cvp_conf {
 	u8			numclks;
 	u32			sent_packets;
 	u32			vsec_offset;
+	u8			*send_buf;
 	const struct cvp_priv	*priv;
 };
 
@@ -453,7 +454,11 @@ static int altera_cvp_write(struct fpga_manager *mgr, const char *buf,
 		}
 
 		len = min(conf->priv->block_size, remaining);
-		altera_cvp_send_block(conf, data, len);
+		/* Copy the requested host data into the transmit buffer */
+
+		memcpy(conf->send_buf, data, len);
+		altera_cvp_send_block(conf, (const u32 *)conf->send_buf,
+		conf->priv->block_size);
 		data += len / sizeof(u32);
 		done += len;
 		remaining -= len;
@@ -492,10 +497,13 @@ static int altera_cvp_write_complete(struct fpga_manager *mgr,
 	if (ret)
 		return ret;
 
-	/* STEP 16 - check CVP_CONFIG_ERROR_LATCHED bit */
-	altera_read_config_dword(conf, VSE_UNCOR_ERR_STATUS, &val);
-	if (val & VSE_UNCOR_ERR_CVP_CFG_ERR) {
-		dev_err(&mgr->dev, "detected CVP_CONFIG_ERROR_LATCHED!\n");
+	/*
+	 * STEP 16 - If bitstream error (truncated/miss-matched),
+	 * we shall exit here.
+	 */
+	ret = altera_read_config_dword(conf, VSE_CVP_STATUS, &val);
+	if (ret || (val & VSE_CVP_STATUS_CFG_ERR)) {
+		dev_err(&mgr->dev, "CVP_CONFIG_ERROR!\n");
 		return -EPROTO;
 	}
 
@@ -661,6 +669,12 @@ static int altera_cvp_probe(struct pci_dev *pdev,
 
 	pci_set_drvdata(pdev, mgr);
 
+	/* Allocate the 4096 block size transmit buffer */
+	conf->send_buf = devm_kzalloc(&pdev->dev, conf->priv->block_size, GFP_KERNEL);
+	if (!conf->send_buf) {
+		ret = -ENOMEM;
+		goto err_unmap;
+	}
 	return 0;
 
 err_unmap:
-- 
2.25.1


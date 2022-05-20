Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C65E52E202
	for <lists+linux-fpga@lfdr.de>; Fri, 20 May 2022 03:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbiETBbj (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 19 May 2022 21:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344086AbiETBbf (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 19 May 2022 21:31:35 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90AC895A08;
        Thu, 19 May 2022 18:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653010293; x=1684546293;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kyp3JRERShg4eTuUYYWrAsJejoTn+bDOBMBL5rwGgCI=;
  b=dT8iAA//YoHwWdRowTKHH8WHp8WGDVOwLghm+geUmHqffKNjTKV4P3F+
   Nhxxz0sSEvO5lNg4eWj/EhnJn1/Fm5jA3oJYxM5bD4We3r00QDhS7q7W3
   tvMwU+sVRgM9uujUvA1Fnq6b9YxHPU8UZ7XK/E7aoL9PJeP0j9mXBleWF
   nMIV4+UmT87bWuac8cPGoNlpFkvtLBWoR69mJQY7BM9aIclJ85e2s6Tio
   /c6PhC0TnVr+2PE2zLxyUof7QaW64KeypY+vMENlZUG7xaLV+S7z6XNTs
   gWjLSdFukn6CZ9ThKGwE2pPR3PE0Ws1dqvy19K4GhI1E0u+2tPRR3Bnr7
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="333067384"
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="333067384"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 18:31:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="524396205"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.90])
  by orsmga003.jf.intel.com with ESMTP; 19 May 2022 18:31:24 -0700
From:   tien.sung.ang@intel.com
To:     christophe.jaillet@wanadoo.fr
Cc:     mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
        trix@redhat.com, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ang Tien Sung <tien.sung.ang@intel.com>
Subject: [PATCH v2] fpga: altera-cvp: Truncated bitstream error support
Date:   Fri, 20 May 2022 09:30:40 +0800
Message-Id: <20220520013040.2920835-1-tien.sung.ang@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <6939d35f-36a0-568e-bfec-4dd2e3a48604@wanadoo.fr>
References: <6939d35f-36a0-568e-bfec-4dd2e3a48604@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
changelog v2:
* Alignment fix parameter 'conf' altera_cvp_send_block
---
 drivers/fpga/altera-cvp.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
index 4ffb9da537d8..5169f9bcd726 100644
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
+				      conf->priv->block_size);
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


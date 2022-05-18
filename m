Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80F7152B3E2
	for <lists+linux-fpga@lfdr.de>; Wed, 18 May 2022 09:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232308AbiERHj3 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 18 May 2022 03:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232338AbiERHj1 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 18 May 2022 03:39:27 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71419115CA2;
        Wed, 18 May 2022 00:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652859566; x=1684395566;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Daoi5XaegiVVBVBvMlk587j4GbG+Rc+fXkmJuyrCp4o=;
  b=fCsHPXhVLyoPbIhrG4/t3grb6BoiU9rJ0iI+ky6AFlffyoqhq3JGFfui
   fI+AQnYojhtn0HSKrjTmANc5JbAsSmmpeASgbgGmgo9+Uu8PepcLYXeE2
   WAes+8h31NqO2AbRTgt2idCjaIsNHBC+7+hUa7LO0bfv1qd2jduIAXPaT
   lIYx8DSwFzYeK1vnuw5gr1rkjVbKokzOVWsHE19hKdWUujl0/4cU0UAG1
   GFjszjVgDSjYS8GdKC/s7DRTx7/6h92+sp5yOLXJ3EQbbha3H/Vx0AyZ2
   c61F+FAci441ye2aJnIQz32AdwEuQSGuEEcgab/t68M97OFWrfRPFvIBn
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="270358808"
X-IronPort-AV: E=Sophos;i="5.91,234,1647327600"; 
   d="scan'208";a="270358808"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 00:39:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,234,1647327600"; 
   d="scan'208";a="574939464"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.90])
  by fmsmga007.fm.intel.com with ESMTP; 18 May 2022 00:39:12 -0700
From:   tien.sung.ang@intel.com
To:     mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
        trix@redhat.com
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dinh Nguyen <dinh.nguyen@intel.com>,
        Ang Tien Sung <tien.sung.ang@intel.com>
Subject: [PATCH] fpga: altera-cvp: allow interrupt to continue next time
Date:   Wed, 18 May 2022 15:38:44 +0800
Message-Id: <20220518073844.2713722-1-tien.sung.ang@intel.com>
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

From: Dinh Nguyen <dinh.nguyen@intel.com>

CFG_READY signal/bit may time-out due to firmware not responding
within the given time-out. This time varies due to numerous
factors like size of bitstream and others.
This time-out error does not impact the result of the CvP
previous transactions. The CvP driver shall then, respond with
EAGAIN instead Time out error.

Signed-off-by: Dinh Nguyen <dinh.nguyen@intel.com>
Signed-off-by: Ang Tien Sung <tien.sung.ang@intel.com>
---
 drivers/fpga/altera-cvp.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
index 4ffb9da537d8..d74ff63c61e8 100644
--- a/drivers/fpga/altera-cvp.c
+++ b/drivers/fpga/altera-cvp.c
@@ -309,10 +309,22 @@ static int altera_cvp_teardown(struct fpga_manager *mgr,
 	/* STEP 15 - poll CVP_CONFIG_READY bit for 0 with 10us timeout */
 	ret = altera_cvp_wait_status(conf, VSE_CVP_STATUS_CFG_RDY, 0,
 				     conf->priv->poll_time_us);
-	if (ret)
+	if (ret) {
 		dev_err(&mgr->dev, "CFG_RDY == 0 timeout\n");
+		goto error_path;
+	}
 
 	return ret;
+
+error_path:
+	/* reset CVP_MODE and HIP_CLK_SEL bit */
+	altera_read_config_dword(conf, VSE_CVP_MODE_CTRL, &val);
+	val &= ~VSE_CVP_MODE_CTRL_HIP_CLK_SEL;
+	val &= ~VSE_CVP_MODE_CTRL_CVP_MODE;
+	altera_write_config_dword(conf, VSE_CVP_MODE_CTRL, val);
+
+	return -EAGAIN;
+
 }
 
 static int altera_cvp_write_init(struct fpga_manager *mgr,
-- 
2.25.1


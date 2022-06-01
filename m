Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A41A539AD7
	for <lists+linux-fpga@lfdr.de>; Wed,  1 Jun 2022 03:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348058AbiFABlK (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 31 May 2022 21:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbiFABlJ (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 31 May 2022 21:41:09 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B971C72209;
        Tue, 31 May 2022 18:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654047668; x=1685583668;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bREUMPRddav0ot+T1KCx4aoc9q3KUb7RuUd1KJFsQz8=;
  b=mT0Cx6wUmJ93VKhZQoqaL9qNPKdam7Zr68B5wwn3QlajZCmqtGNYl8z1
   M8yKcAo2J/lId/3fKgQOHt8Waanzrqn6SeSPlIYzU37A6T4IZsAf+MP7z
   N3eQJ9Jr76EuFZvzUBN6vq9myoA75b9pM5eDdZ1L7wCr8P5w2WWQfrbRT
   gG4Zun7/zg2TFeS7pndWrM7ouGf8xumHsSAI9W16C+0Ej4iyiU1QEwvBm
   yNVUGcZlI3wY+KB3ZrubBUEdzB5qPzVXlh1eMQENxhtQgfMDpveCbUZX3
   6nw0U2PgJsFarJxKqUmw+6z3FujB85TwwwFWUlNJCLvVI+BgM/Nv3kLjo
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10364"; a="255917808"
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; 
   d="scan'208";a="255917808"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 18:41:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; 
   d="scan'208";a="679861174"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.90])
  by fmsmga002.fm.intel.com with ESMTP; 31 May 2022 18:41:06 -0700
From:   tien.sung.ang@intel.com
To:     yilun.xu@intel.com
Cc:     hao.wu@intel.com, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, mdf@kernel.org,
        tien.sung.ang@intel.com, trix@redhat.com, dinh.nguyen@intel.com
Subject: [PATCH v2] fpga: altera-cvp: allow interrupt to continue next time
Date:   Wed,  1 Jun 2022 09:40:27 +0800
Message-Id: <20220601014027.2547481-1-tien.sung.ang@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220528120503.GB175058@yilunxu-OptiPlex-7050>
References: <20220528120503.GB175058@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Dinh Nguyen <dinh.nguyen@intel.com>

The main objective of this change is to perform error handling
if the CvP firmware becomes unresponsive. The error_path flow
resets the CvP mode and HIP_CLK_SEL bit.

CFG_READY signal/bit may time-out due to firmware not responding
within the given time-out. This time varies due to numerous
factors like size of bitstream and others.
This time-out error may or may not impact the result of the CvP
previous transactions. The CvP driver shall then, respond with
EAGAIN instead Time out error.

Signed-off-by: Dinh Nguyen <dinh.nguyen@intel.com>
Signed-off-by: Ang Tien Sung <tien.sung.ang@intel.com>
---

changelog v2:
* Amend the commit message

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


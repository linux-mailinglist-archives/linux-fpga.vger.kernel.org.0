Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0A45A6700
	for <lists+linux-fpga@lfdr.de>; Tue, 30 Aug 2022 17:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbiH3PKL (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 30 Aug 2022 11:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbiH3PKK (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 30 Aug 2022 11:10:10 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528FE286D0;
        Tue, 30 Aug 2022 08:10:06 -0700 (PDT)
X-QQ-mid: bizesmtp72t1661872189taippgaq
Received: from localhost.localdomain ( [182.148.13.26])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 30 Aug 2022 23:09:43 +0800 (CST)
X-QQ-SSF: 01000000002000B0C000B00A0000000
X-QQ-FEAT: Kol1Dm0TdrBY3VVmcZA8Cluyd69CRq9T6xCeEOK7HZtzwD/guwODQBL26XGp5
        FlrnS2dttpsBfKHkIkutuyymhI8o6tPYjjlbwH+Ktk+L0UsHZqTXSVEkvnuJZdj1tag5GmL
        xyzu3Nv086ySEsJ30YdB9mCFd7EMCRFE92zGHP4PSzee8OSr37ogb7YgwvKi9w6XhFCrZp/
        ldJGv4WVJqu5j7acDdNakxyYlwiUqCiDxZU3zzFiF7xoJHeUWwcm9hkJORnn/RlzuXRGB3g
        giUeDkOO6fEyykY3yxpDenPqU5JSjHxBJAvrjKEKwmQTr5tABG/nSDKgqv5va9Bl6wGyXVP
        EahHYI4aICF1YmaPAUxhsFcYCZHviAu3DAwKDTkng3INTAgf5Gv+v/2ckCuZA==
X-QQ-GoodBg: 0
From:   Shaomin Deng <dengshaomin@cdjrlc.com>
To:     mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Shaomin Deng <dengshaomin@cdjrlc.com>
Subject: [PATCH] fpga: mgr: Fix double word in comments
Date:   Tue, 30 Aug 2022 11:09:43 -0400
Message-Id: <20220830150943.25371-1-dengshaomin@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Remove the repeated word "if" in comments.

Signed-off-by: Shaomin Deng <dengshaomin@cdjrlc.com>
---
 drivers/fpga/stratix10-soc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
index 357cea58ec98..e4f2e83a615b 100644
--- a/drivers/fpga/stratix10-soc.c
+++ b/drivers/fpga/stratix10-soc.c
@@ -285,7 +285,7 @@ static int s10_ops_write(struct fpga_manager *mgr, const char *buf,
 
 	/*
 	 * Loop waiting for buffers to be returned.  When a buffer is returned,
-	 * reuse it to send more data or free if if all data has been sent.
+	 * reuse it to send more data or free if all data has been sent.
 	 */
 	while (count > 0 || s10_free_buffer_count(mgr) != NUM_SVC_BUFS) {
 		reinit_completion(&priv->status_return_completion);
-- 
2.35.1


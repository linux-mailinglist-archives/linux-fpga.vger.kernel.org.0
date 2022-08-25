Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0F35A14BE
	for <lists+linux-fpga@lfdr.de>; Thu, 25 Aug 2022 16:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242081AbiHYOnr (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 25 Aug 2022 10:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242076AbiHYOn3 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 25 Aug 2022 10:43:29 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA703F58C
        for <linux-fpga@vger.kernel.org>; Thu, 25 Aug 2022 07:42:11 -0700 (PDT)
X-QQ-mid: bizesmtp84t1661438525tuj1fomv
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 25 Aug 2022 22:41:56 +0800 (CST)
X-QQ-SSF: 01000000002000B0B000B00A0000000
X-QQ-FEAT: bhet8yMU7vnSvreiVCTgDgU7lrvb8webw52cOpi6Ryih3/N0xoqC0KdNaAilU
        06hjeqzPyRSfLCLznJIvoPUl+Pk5cys7L/pGLDUZ3QLgb0+8MURjZRZ01TXxuFAf0dSPhra
        MZRWGHPNDqORiz7a9xnxufRv7lpt0azE1znnFqHrqko5O9lwdfkSnboBp72ttssSzKnIFO0
        ye7rWqnUm1D2R39yEi82dvRi6bKiAXY0ZKYQW+2RHhozVM6TV20JXNzLh6vAuDHLTNBXP+O
        +pEUJoFofKskagtzw47MK1UUH4GtbUT7Lub7trQoYSWhjR7ETwbVdinCKZ8pfQ/KHMUOUqs
        JQ2as0dn5vhJK4LwsZcTlhOoPFiWLAmyCxLKUfjXafYIZaca1dfTISqqIVu+g==
X-QQ-GoodBg: 0
From:   Shaomin Deng <dengshaomin@cdjrlc.com>
To:     mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
        linux-fpga@vger.kernel.org
Cc:     trix@redhat.com, Shaomin Deng <dengshaomin@cdjrlc.com>
Subject: [PATCH] fpga: stratix10-soc: Fix comments typo
Date:   Thu, 25 Aug 2022 10:41:55 -0400
Message-Id: <20220825144155.2345-1-dengshaomin@cdjrlc.com>
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

Delete the repeated word "if" in comments.

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


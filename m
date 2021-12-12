Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43F004717F6
	for <lists+linux-fpga@lfdr.de>; Sun, 12 Dec 2021 04:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232691AbhLLDUM (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 11 Dec 2021 22:20:12 -0500
Received: from smtpbg128.qq.com ([106.55.201.39]:45482 "EHLO smtpbg587.qq.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229635AbhLLDUL (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sat, 11 Dec 2021 22:20:11 -0500
X-QQ-mid: bizesmtp38t1639279199tdq67v03
Received: from localhost.localdomain (unknown [182.132.179.213])
        by esmtp6.qq.com (ESMTP) with 
        id ; Sun, 12 Dec 2021 11:19:57 +0800 (CST)
X-QQ-SSF: 01000000002000D0H000000A0000000
X-QQ-FEAT: pfdRPpmj9hGOWCM589m+cqRH8mjOMc7u8FKv+sD3OL2xNT5o7KZ170K1NLbdn
        Ex+DpdrbfrtR4++MLZDaTG8hk/W58As5RBTHPsD9hi+KZKUHLUYK79kCZD1nkaDtc1tlxm8
        gEWk9k8/b4vDiJ3m2fdwekHsk2GRDr9rtm08up3nHKqs8Py6AYXAcY3cLcuRchytrgW+CI1
        A/gmUCPbHghfxcK2jMvZ2ZHJiEwiINmDUT59vOQKlcS1oMVLb8a7/dkziE4sTl9SaXy6DLO
        J+xGm8Owe0QunU7SNqtFI1kNUSaqtN8+bbeoNw/31LjhwEWNREV0gsg9wAJghSrD6FePor7
        y1mMI3GnFomKuOAWUogAVrMA22dQFL+H5MFDzcU
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     hao.wu@intel.com
Cc:     mdf@kernel.org, yilun.xu@intel.com, trix@redhat.com,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] fpga: stratix10-soc: fix typo in a comment
Date:   Sun, 12 Dec 2021 11:19:56 +0800
Message-Id: <20211212031956.46029-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam5
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The double `if' in the comment in line 288 is repeated. Remove one
of them from the comment.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
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
2.34.1


Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1D222C982
	for <lists+linux-fpga@lfdr.de>; Fri, 24 Jul 2020 17:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgGXPzi (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 24 Jul 2020 11:55:38 -0400
Received: from mga09.intel.com ([134.134.136.24]:55400 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726381AbgGXPzi (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 24 Jul 2020 11:55:38 -0400
IronPort-SDR: /6KniTZdBd/UbPhVH0OXkVJCdLuspm5UhuhaOLvaqikyrgPINLzICV7qz5XaC0Et1OWY1AvL5u
 4WuDIgXfwtfg==
X-IronPort-AV: E=McAfee;i="6000,8403,9692"; a="152013967"
X-IronPort-AV: E=Sophos;i="5.75,391,1589266800"; 
   d="scan'208";a="152013967"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2020 08:55:37 -0700
IronPort-SDR: TXx5h+ln0r1Ie1dc4I8gPGRdq3qXEmqlJcCmRyhYQ+7Cy0j5+5XK3EUjfVqunD/G43REfnvzkR
 hy58pVJxluwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,391,1589266800"; 
   d="scan'208";a="433118864"
Received: from marshy.an.intel.com ([10.122.105.159])
  by orsmga004.jf.intel.com with ESMTP; 24 Jul 2020 08:55:36 -0700
From:   richard.gong@linux.intel.com
To:     mdf@kernel.org
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        trix@redhat.com, dinguyen@kernel.org, richard.gong@linux.intel.com,
        Richard Gong <richard.gong@intel.com>
Subject: [RESEND PATCHv1] fpga: stratix10-soc: make FPGA task un-interruptible
Date:   Fri, 24 Jul 2020 11:10:09 -0500
Message-Id: <1595607009-2065-1-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Richard Gong <richard.gong@intel.com>

When CTRL+C occurs during the process of FPGA reconfiguration, the FPGA
reconfiguration process stops and the user can't perform a new FPGA
reconfiguration properly.

Set FPGA task to be not interruptible so that the user can properly
perform FPGA reconfiguration after CTRL+C event.

Signed-off-by: Richard Gong <richard.gong@intel.com>
Reviewed-by: Tom Rix <trix@redhat.com>
---
 drivers/fpga/stratix10-soc.c | 23 +++--------------------
 1 file changed, 3 insertions(+), 20 deletions(-)

diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
index 44b7c56..657a70c 100644
--- a/drivers/fpga/stratix10-soc.c
+++ b/drivers/fpga/stratix10-soc.c
@@ -196,17 +196,13 @@ static int s10_ops_write_init(struct fpga_manager *mgr,
 	if (ret < 0)
 		goto init_done;
 
-	ret = wait_for_completion_interruptible_timeout(
+	ret = wait_for_completion_timeout(
 		&priv->status_return_completion, S10_RECONFIG_TIMEOUT);
 	if (!ret) {
 		dev_err(dev, "timeout waiting for RECONFIG_REQUEST\n");
 		ret = -ETIMEDOUT;
 		goto init_done;
 	}
-	if (ret < 0) {
-		dev_err(dev, "error (%d) waiting for RECONFIG_REQUEST\n", ret);
-		goto init_done;
-	}
 
 	ret = 0;
 	if (!test_and_clear_bit(SVC_STATUS_OK, &priv->status)) {
@@ -318,7 +314,7 @@ static int s10_ops_write(struct fpga_manager *mgr, const char *buf,
 		 */
 		wait_status = 1; /* not timed out */
 		if (!priv->status)
-			wait_status = wait_for_completion_interruptible_timeout(
+			wait_status = wait_for_completion_timeout(
 				&priv->status_return_completion,
 				S10_BUFFER_TIMEOUT);
 
@@ -340,13 +336,6 @@ static int s10_ops_write(struct fpga_manager *mgr, const char *buf,
 			ret = -ETIMEDOUT;
 			break;
 		}
-		if (wait_status < 0) {
-			ret = wait_status;
-			dev_err(dev,
-				"error (%d) waiting for svc layer buffers\n",
-				ret);
-			break;
-		}
 	}
 
 	if (!s10_free_buffers(mgr))
@@ -372,7 +361,7 @@ static int s10_ops_write_complete(struct fpga_manager *mgr,
 		if (ret < 0)
 			break;
 
-		ret = wait_for_completion_interruptible_timeout(
+		ret = wait_for_completion_timeout(
 			&priv->status_return_completion, timeout);
 		if (!ret) {
 			dev_err(dev,
@@ -380,12 +369,6 @@ static int s10_ops_write_complete(struct fpga_manager *mgr,
 			ret = -ETIMEDOUT;
 			break;
 		}
-		if (ret < 0) {
-			dev_err(dev,
-				"error (%d) waiting for RECONFIG_COMPLETED\n",
-				ret);
-			break;
-		}
 		/* Not error or timeout, so ret is # of jiffies until timeout */
 		timeout = ret;
 		ret = 0;
-- 
2.7.4


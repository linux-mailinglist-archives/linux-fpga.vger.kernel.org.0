Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 973731D503D
	for <lists+linux-fpga@lfdr.de>; Fri, 15 May 2020 16:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbgEOOTl (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 15 May 2020 10:19:41 -0400
Received: from mga17.intel.com ([192.55.52.151]:33489 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbgEOOTl (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 15 May 2020 10:19:41 -0400
IronPort-SDR: VbmSNRgpC1pktixqmSk0+ubFnnD+nYzK5kGxs0WGSip2lsy8HhqsZ05ekLATbzvjXlzExyx1Yn
 r1leke1GbS8g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2020 07:19:41 -0700
IronPort-SDR: X806o53qBM8MjR9VttUyfi0cXh5zmXgMlCiMmkMbtxsD8FcSWu76betx4xBGcK+BDkMubjUgtd
 gTSBZRcOTssg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,395,1583222400"; 
   d="scan'208";a="252388959"
Received: from marshy.an.intel.com ([10.122.105.159])
  by fmsmga007.fm.intel.com with ESMTP; 15 May 2020 07:19:40 -0700
From:   richard.gong@linux.intel.com
To:     mdf@kernel.org
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        dinguyen@kernel.org, richard.gong@linux.intel.com,
        Richard Gong <richard.gong@intel.com>
Subject: [PATCHv2] fpga: stratix10-soc: remove the pre-set reconfiguration condition
Date:   Fri, 15 May 2020 09:35:03 -0500
Message-Id: <1589553303-7341-1-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Richard Gong <richard.gong@intel.com>

The reconfiguration mode is pre-set by driver as the full reconfiguration.
As a result, user have to change code and recompile the drivers if he or
she wants to perform a partial reconfiguration. Removing the pre-set
reconfiguration condition so that user can select full or partial
reconfiguration via overlay device tree without recompiling the drivers.

Also add an error message if the configuration request is failure.

Signed-off-by: Richard Gong <richard.gong@intel.com>
---
v2: define and use constant values
---
 drivers/fpga/stratix10-soc.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
index 44b7c56..4d52a80 100644
--- a/drivers/fpga/stratix10-soc.c
+++ b/drivers/fpga/stratix10-soc.c
@@ -14,9 +14,13 @@
 /*
  * FPGA programming requires a higher level of privilege (EL3), per the SoC
  * design.
+ * SoC firmware supports full and partial reconfiguration.
  */
 #define NUM_SVC_BUFS	4
 #define SVC_BUF_SIZE	SZ_512K
+#define FULL_RECONFIG_FLAG	0
+#define PARTIAL_RECONFIG_FLAG	1
+
 
 /* Indicates buffer is in use if set */
 #define SVC_BUF_LOCK	0
@@ -182,12 +186,12 @@ static int s10_ops_write_init(struct fpga_manager *mgr,
 	uint i;
 	int ret;
 
-	ctype.flags = 0;
 	if (info->flags & FPGA_MGR_PARTIAL_RECONFIG) {
 		dev_dbg(dev, "Requesting partial reconfiguration.\n");
-		ctype.flags |= BIT(COMMAND_RECONFIG_FLAG_PARTIAL);
+		ctype.flags = PARTIAL_RECONFIG_FLAG;
 	} else {
 		dev_dbg(dev, "Requesting full reconfiguration.\n");
+		ctype.flags = FULL_RECONFIG_FLAG;
 	}
 
 	reinit_completion(&priv->status_return_completion);
@@ -210,6 +214,7 @@ static int s10_ops_write_init(struct fpga_manager *mgr,
 
 	ret = 0;
 	if (!test_and_clear_bit(SVC_STATUS_OK, &priv->status)) {
+		dev_err(dev, "RECONFIG_REQUEST failed\n");
 		ret = -ETIMEDOUT;
 		goto init_done;
 	}
-- 
2.7.4


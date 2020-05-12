Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8254A1CF54C
	for <lists+linux-fpga@lfdr.de>; Tue, 12 May 2020 15:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbgELNMH (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 12 May 2020 09:12:07 -0400
Received: from mga04.intel.com ([192.55.52.120]:31830 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726891AbgELNMH (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 12 May 2020 09:12:07 -0400
IronPort-SDR: kfwqYFtbR2x7kebXu0H2A/QqkF4qTEXhwQnxeN5tfM2XP4TU9EbqRT078/r7jRlRhtISN8Utrm
 3AAiCYu/li3g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2020 06:11:46 -0700
IronPort-SDR: enexzkz5PmtuHs0D0sFloFyx2Mpk3LsCixCKMhaEd4RTIPC42deB01ymKVYVXBAw+/JynL3jrr
 qYZpuHyxq0xA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,383,1583222400"; 
   d="scan'208";a="286645821"
Received: from marshy.an.intel.com ([10.122.105.159])
  by fmsmga004.fm.intel.com with ESMTP; 12 May 2020 06:11:46 -0700
From:   richard.gong@linux.intel.com
To:     mdf@kernel.org
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        dinguyen@kernel.org, richard.gong@linux.intel.com,
        Richard Gong <richard.gong@intel.com>
Subject: [PATCHv1] fpga: stratix10-soc: remove the pre-set reconfiguration condition
Date:   Tue, 12 May 2020 08:27:31 -0500
Message-Id: <1589290051-30246-1-git-send-email-richard.gong@linux.intel.com>
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
 drivers/fpga/stratix10-soc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
index 44b7c56..2da8a40 100644
--- a/drivers/fpga/stratix10-soc.c
+++ b/drivers/fpga/stratix10-soc.c
@@ -182,12 +182,12 @@ static int s10_ops_write_init(struct fpga_manager *mgr,
 	uint i;
 	int ret;
 
-	ctype.flags = 0;
 	if (info->flags & FPGA_MGR_PARTIAL_RECONFIG) {
 		dev_dbg(dev, "Requesting partial reconfiguration.\n");
-		ctype.flags |= BIT(COMMAND_RECONFIG_FLAG_PARTIAL);
+		ctype.flags = 1;
 	} else {
 		dev_dbg(dev, "Requesting full reconfiguration.\n");
+		ctype.flags = 0;
 	}
 
 	reinit_completion(&priv->status_return_completion);
@@ -210,6 +210,7 @@ static int s10_ops_write_init(struct fpga_manager *mgr,
 
 	ret = 0;
 	if (!test_and_clear_bit(SVC_STATUS_OK, &priv->status)) {
+		dev_err(dev, "RECONFIG_REQUEST failed\n");
 		ret = -ETIMEDOUT;
 		goto init_done;
 	}
-- 
2.7.4


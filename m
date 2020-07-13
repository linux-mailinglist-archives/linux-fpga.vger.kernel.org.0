Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9BEE21CF6E
	for <lists+linux-fpga@lfdr.de>; Mon, 13 Jul 2020 08:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729139AbgGMGOi (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 13 Jul 2020 02:14:38 -0400
Received: from mga12.intel.com ([192.55.52.136]:16296 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727107AbgGMGOh (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 13 Jul 2020 02:14:37 -0400
IronPort-SDR: vdy2necNpix16EtH8PDL7SdPTprmZreiNhbr/7B87TiIbx4tf1ZugMmWe7fggHqjw4Mrgq8JYw
 VxLRgw1z+C8g==
X-IronPort-AV: E=McAfee;i="6000,8403,9680"; a="128138025"
X-IronPort-AV: E=Sophos;i="5.75,346,1589266800"; 
   d="scan'208";a="128138025"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2020 23:14:37 -0700
IronPort-SDR: fRCAvb+PM5UB8wkQMDFH0RSiYXLEhgfrINWpkAPiJ1CjYtSk2S9987QfamM1dtVuC2RoYpRohD
 cn1lHwhg0IEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,346,1589266800"; 
   d="scan'208";a="459177315"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by orsmga005.jf.intel.com with ESMTP; 12 Jul 2020 23:14:34 -0700
From:   Xu Yilun <yilun.xu@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     lgoncalv@redhat.com, trix@redhat.com,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Xu Yilun <yilun.xu@intel.com>
Subject: [PATCH v2 2/2] fpga: dfl: fix bug in port reset handshake
Date:   Mon, 13 Jul 2020 14:10:03 +0800
Message-Id: <1594620603-18029-3-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594620603-18029-1-git-send-email-yilun.xu@intel.com>
References: <1594620603-18029-1-git-send-email-yilun.xu@intel.com>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Matthew Gerlach <matthew.gerlach@linux.intel.com>

When putting the port in reset, driver must wait for the soft reset
acknowledgment bit instead of the soft reset bit.

Fixes: 47c1b19c160f (fpga: dfl: afu: add port ops support)
Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Signed-off-by: Xu Yilun <yilun.xu@intel.com>
Acked-by: Wu Hao <hao.wu@intel.com>
Reviewed-by: Tom Rix <trix@redhat.com>
---
v2: add Reviewed-by of Tom, no code change.
---
 drivers/fpga/dfl-afu-main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
index 7c84fee..753cda4 100644
--- a/drivers/fpga/dfl-afu-main.c
+++ b/drivers/fpga/dfl-afu-main.c
@@ -83,7 +83,8 @@ int __afu_port_disable(struct platform_device *pdev)
 	 * on this port and minimum soft reset pulse width has elapsed.
 	 * Driver polls port_soft_reset_ack to determine if reset done by HW.
 	 */
-	if (readq_poll_timeout(base + PORT_HDR_CTRL, v, v & PORT_CTRL_SFTRST,
+	if (readq_poll_timeout(base + PORT_HDR_CTRL, v,
+			       v & PORT_CTRL_SFTRST_ACK,
 			       RST_POLL_INVL, RST_POLL_TIMEOUT)) {
 		dev_err(&pdev->dev, "timeout, fail to reset device\n");
 		return -ETIMEDOUT;
-- 
2.7.4


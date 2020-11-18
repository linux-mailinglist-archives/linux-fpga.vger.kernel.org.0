Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79CAA2B7F27
	for <lists+linux-fpga@lfdr.de>; Wed, 18 Nov 2020 15:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbgKROJK (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 18 Nov 2020 09:09:10 -0500
Received: from mga18.intel.com ([134.134.136.126]:44082 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726721AbgKROJJ (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 18 Nov 2020 09:09:09 -0500
IronPort-SDR: ZRtLRxiXBJLKpIhA9+JRySOGYWAI6nV44JyP9Ws332985HWmOAd9Bx8jhoXEr6juKju+grzaRn
 TQ3p31Ws9/GA==
X-IronPort-AV: E=McAfee;i="6000,8403,9808"; a="158892830"
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="158892830"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2020 06:09:08 -0800
IronPort-SDR: Tm0ELrCvDRFEKrpSt5F23OrJXxIfOJ6tRx5LqJOPIIWasd4/grqgHS5f1EJnKtRorn0Nss/wxn
 Y8x4N4vkw2+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="325596943"
Received: from marshy.an.intel.com ([10.122.105.143])
  by orsmga003.jf.intel.com with ESMTP; 18 Nov 2020 06:09:07 -0800
From:   richard.gong@linux.intel.com
To:     gregkh@linuxfoundation.org, mdf@kernel.org, trix@redhat.com,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dinguyen@kernel.org, sridhar.rajagopal@intel.com,
        richard.gong@linux.intel.com, richard.gong@intel.com
Subject: [PATCHv2 5/5] fpga: stratix10-soc: extend driver for bitstream authentication
Date:   Wed, 18 Nov 2020 08:29:13 -0600
Message-Id: <1605709753-7800-6-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1605709753-7800-1-git-send-email-richard.gong@linux.intel.com>
References: <1605709753-7800-1-git-send-email-richard.gong@linux.intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Richard Gong <richard.gong@intel.com>

Extend FPGA manager driver to support FPGA bitstream authentication on
Intel SocFPGA platforms.

Signed-off-by: Richard Gong <richard.gong@intel.com>
---
v2: use flag defined in stratix10-svc driver
---
 drivers/fpga/stratix10-soc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
index 657a70c..b77067e 100644
--- a/drivers/fpga/stratix10-soc.c
+++ b/drivers/fpga/stratix10-soc.c
@@ -186,6 +186,9 @@ static int s10_ops_write_init(struct fpga_manager *mgr,
 	if (info->flags & FPGA_MGR_PARTIAL_RECONFIG) {
 		dev_dbg(dev, "Requesting partial reconfiguration.\n");
 		ctype.flags |= BIT(COMMAND_RECONFIG_FLAG_PARTIAL);
+	} else if (info->flags & FPGA_MGR_BITSTREM_AUTHENTICATION) {
+		dev_dbg(dev, "Requesting bitstream authentication.\n");
+		ctype.flags |= BIT(COMMAND_AUTHENTICATE_BITSTREAM);
 	} else {
 		dev_dbg(dev, "Requesting full reconfiguration.\n");
 	}
-- 
2.7.4


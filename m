Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7AC2D99C1
	for <lists+linux-fpga@lfdr.de>; Mon, 14 Dec 2020 15:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440131AbgLNOWV (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 14 Dec 2020 09:22:21 -0500
Received: from mga14.intel.com ([192.55.52.115]:65447 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440127AbgLNOWT (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 14 Dec 2020 09:22:19 -0500
IronPort-SDR: JfzNPqeiKLTX8RQvbboB1ZEKT2CE9JA3wmAzE8VGfFeDoy2KU7SuwaaWZv2LVZ0UxgkFPUZ74V
 ElF9I46YyOfA==
X-IronPort-AV: E=McAfee;i="6000,8403,9834"; a="173941497"
X-IronPort-AV: E=Sophos;i="5.78,419,1599548400"; 
   d="scan'208";a="173941497"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2020 06:19:08 -0800
IronPort-SDR: /nmVoXBcGhUwJyNEmaqMhM/8V/tROZbPYbFIFefNY2XmtJYqePv1MAchPPXzez/+r8rs+TpjNS
 /XWcbQ4sDijA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,419,1599548400"; 
   d="scan'208";a="333456267"
Received: from marshy.an.intel.com ([10.122.105.143])
  by fmsmga008.fm.intel.com with ESMTP; 14 Dec 2020 06:18:49 -0800
From:   richard.gong@linux.intel.com
To:     gregkh@linuxfoundation.org, mdf@kernel.org, trix@redhat.com,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dinguyen@kernel.org, sridhar.rajagopal@intel.com,
        richard.gong@linux.intel.com, Richard Gong <richard.gong@intel.com>
Subject: [RESEND PATCHv2 5/5] fpga: stratix10-soc: extend driver for bitstream authentication
Date:   Mon, 14 Dec 2020 08:40:00 -0600
Message-Id: <1607956800-28476-6-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1607956800-28476-1-git-send-email-richard.gong@linux.intel.com>
References: <1607956800-28476-1-git-send-email-richard.gong@linux.intel.com>
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


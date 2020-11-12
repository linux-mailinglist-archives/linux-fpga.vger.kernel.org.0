Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B47C2B0B93
	for <lists+linux-fpga@lfdr.de>; Thu, 12 Nov 2020 18:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgKLRrn (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 12 Nov 2020 12:47:43 -0500
Received: from mga18.intel.com ([134.134.136.126]:5888 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726427AbgKLRrc (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 12 Nov 2020 12:47:32 -0500
IronPort-SDR: L2Cy4M26uLEx+dd9H2e1J5zKZwO+4rkEX68jWy0Cl+klbFHDjVX6h+Blelfc0ECY00b4J13MDO
 ScCT2a813TAw==
X-IronPort-AV: E=McAfee;i="6000,8403,9803"; a="158128483"
X-IronPort-AV: E=Sophos;i="5.77,472,1596524400"; 
   d="scan'208";a="158128483"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2020 09:47:32 -0800
IronPort-SDR: NbEprrJmNWrSQpq/a12O87/g3d+3K21XcPJd9XyUZkc3zEEI4V6rxP7Nf12yJKTyHVOA/0r18L
 gar8+Y74G7rA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,472,1596524400"; 
   d="scan'208";a="328576399"
Received: from marshy.an.intel.com ([10.122.105.143])
  by orsmga006.jf.intel.com with ESMTP; 12 Nov 2020 09:47:31 -0800
From:   richard.gong@linux.intel.com
To:     mdf@kernel.org, trix@redhat.com, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     dinguyen@kernel.org, sridhar.rajagopal@intel.com,
        richard.gong@linux.intel.com, Richard Gong <richard.gong@intel.com>
Subject: [PATCHv1 4/4] fpga: stratix10-soc: entend driver for bitstream authentication
Date:   Thu, 12 Nov 2020 12:06:43 -0600
Message-Id: <1605204403-6663-5-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1605204403-6663-1-git-send-email-richard.gong@linux.intel.com>
References: <1605204403-6663-1-git-send-email-richard.gong@linux.intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Richard Gong <richard.gong@intel.com>

Exten FPGA manager driver to support FPGA bitstream authentication on
Intel SocFPGA platforms.

Signed-off-by: Richard Gong <richard.gong@intel.com>
---
 drivers/fpga/stratix10-soc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
index 657a70c..8a59365 100644
--- a/drivers/fpga/stratix10-soc.c
+++ b/drivers/fpga/stratix10-soc.c
@@ -185,7 +185,10 @@ static int s10_ops_write_init(struct fpga_manager *mgr,
 	ctype.flags = 0;
 	if (info->flags & FPGA_MGR_PARTIAL_RECONFIG) {
 		dev_dbg(dev, "Requesting partial reconfiguration.\n");
-		ctype.flags |= BIT(COMMAND_RECONFIG_FLAG_PARTIAL);
+		ctype.flags |= FPGA_MGR_PARTIAL_RECONFIG;
+	} else if (info->flags & FPGA_MGR_BITSTREM_AUTHENTICATION) {
+		dev_dbg(dev, "Requesting bitstream authentication.\n");
+		ctype.flags |= FPGA_MGR_BITSTREM_AUTHENTICATION;
 	} else {
 		dev_dbg(dev, "Requesting full reconfiguration.\n");
 	}
-- 
2.7.4


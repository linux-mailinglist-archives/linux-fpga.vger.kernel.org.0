Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D87015DB59
	for <lists+linux-fpga@lfdr.de>; Fri, 14 Feb 2020 16:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729666AbgBNPpk (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 14 Feb 2020 10:45:40 -0500
Received: from mga12.intel.com ([192.55.52.136]:30603 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729073AbgBNPpk (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 14 Feb 2020 10:45:40 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2020 07:45:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,441,1574150400"; 
   d="scan'208";a="433053662"
Received: from marshy.an.intel.com ([10.122.105.159])
  by fmsmga005.fm.intel.com with ESMTP; 14 Feb 2020 07:45:38 -0800
From:   richard.gong@linux.intel.com
To:     gregkh@linuxfoundation.org, mdf@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, dinguyen@kernel.org
Cc:     linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, richard.gong@linux.intel.com,
        Richard Gong <richard.gong@intel.com>
Subject: [PATCHv1 3/7] fpga: stratix10-soc: add compatible property value for intel agilex
Date:   Fri, 14 Feb 2020 10:00:48 -0600
Message-Id: <1581696052-11540-4-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1581696052-11540-1-git-send-email-richard.gong@linux.intel.com>
References: <1581696052-11540-1-git-send-email-richard.gong@linux.intel.com>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Richard Gong <richard.gong@intel.com>

Add compatible property value so we can reuse FPGA manager driver on
Intel Agilex SoC platform.

Signed-off-by: Richard Gong <richard.gong@intel.com>
---
 drivers/fpga/stratix10-soc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
index 215d337..bac93d0 100644
--- a/drivers/fpga/stratix10-soc.c
+++ b/drivers/fpga/stratix10-soc.c
@@ -482,7 +482,8 @@ static int s10_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id s10_of_match[] = {
-	{ .compatible = "intel,stratix10-soc-fpga-mgr", },
+	{.compatible = "intel,stratix10-soc-fpga-mgr"},
+	{.compatible = "intel,agilex-soc-fpga-mgr"},
 	{},
 };
 
-- 
2.7.4


Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50E223A1FDC
	for <lists+linux-fpga@lfdr.de>; Thu, 10 Jun 2021 00:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbhFIWQo (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 9 Jun 2021 18:16:44 -0400
Received: from mga18.intel.com ([134.134.136.126]:22626 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229535AbhFIWQn (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 9 Jun 2021 18:16:43 -0400
IronPort-SDR: x3Qb8omvxnaP9g6BxxFcDK5vaNZeUymXR0cZnt5MzKvZcwbsCmzqi2pfjPg+XTOHfiYLT+6b9Z
 S1KN+4cvgNsQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10010"; a="192496207"
X-IronPort-AV: E=Sophos;i="5.83,261,1616482800"; 
   d="scan'208";a="192496207"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 15:14:39 -0700
IronPort-SDR: dII4NCOHqnfqDwCxZfpW50sTIc+QYkf03LaczQgX9RXfw1+1L4V2T6ow9AAtMX1BVrNCdJVPV8
 k99q1jjJebcw==
X-IronPort-AV: E=Sophos;i="5.83,261,1616482800"; 
   d="scan'208";a="477095311"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO rhweight-mobl2.ra.intel.com) ([10.251.20.114])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 15:14:38 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        richard.gong@intel.com, Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v2 2/8] fpga: stratix10-soc: Add missing fpga_mgr_free() call
Date:   Wed,  9 Jun 2021 15:11:29 -0700
Message-Id: <20210609221135.261837-3-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210609221135.261837-1-russell.h.weight@intel.com>
References: <20210609221135.261837-1-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The stratix10-soc driver uses fpga_mgr_create() function and is therefore
responsible to call fpga_mgr_free() to release the class driver resources.
Add a missing call to fpga_mgr_free in the s10_remove() function.

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Reviewed-by: Xu Yilun <yilun.xu@intel.com>
---
v2:
  - Added reviewed-by tag
---
 drivers/fpga/stratix10-soc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
index 657a70c5fc99..9e34bbbce26e 100644
--- a/drivers/fpga/stratix10-soc.c
+++ b/drivers/fpga/stratix10-soc.c
@@ -454,6 +454,7 @@ static int s10_remove(struct platform_device *pdev)
 	struct s10_priv *priv = mgr->priv;
 
 	fpga_mgr_unregister(mgr);
+	fpga_mgr_free(mgr);
 	stratix10_svc_free_channel(priv->chan);
 
 	return 0;
-- 
2.25.1


Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF483A08A2
	for <lists+linux-fpga@lfdr.de>; Wed,  9 Jun 2021 02:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbhFIAv1 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 8 Jun 2021 20:51:27 -0400
Received: from mga11.intel.com ([192.55.52.93]:53669 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230307AbhFIAvY (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 8 Jun 2021 20:51:24 -0400
IronPort-SDR: DLwVvV1OlFcX9qbzQvSyThVCMPqHXU3jJM3oZRqw6Ix0V2V61WTDGQOx1OOjL7/0ajpGmd2Drh
 Mff0TNDWtNjA==
X-IronPort-AV: E=McAfee;i="6200,9189,10009"; a="201954216"
X-IronPort-AV: E=Sophos;i="5.83,259,1616482800"; 
   d="scan'208";a="201954216"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 17:49:31 -0700
IronPort-SDR: qtEC+aiPpB+Qn3YBGjT4ujXWWbdWwIh/Pm4l7T7LnukNIkrBEmxgzTVyPLi4nKdgN8varhB1Pn
 BNW16eiQHL4g==
X-IronPort-AV: E=Sophos;i="5.83,259,1616482800"; 
   d="scan'208";a="449747478"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO rhweight-mobl2.ra.intel.com) ([10.209.100.99])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 17:49:30 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        richard.gong@intel.com, Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v1 2/5] fpga: altera-pr-ip: Remove fpga_mgr_unregister() call
Date:   Tue,  8 Jun 2021 17:49:22 -0700
Message-Id: <20210609004925.238044-3-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210609004925.238044-1-russell.h.weight@intel.com>
References: <20210609004925.238044-1-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The altera-pr-ip driver uses the devm_fpga_mgr_register() call, so it is
unnecessary to call fpga_mgr_unregister(). Also, mgr is no longer stored
in the dev.driver_data, so remove the call to dev_get_drvdata().

alt_pr_unregister() is now an empty function, but is left intact because
it is an exported symbol.

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
---
 drivers/fpga/altera-pr-ip-core.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/fpga/altera-pr-ip-core.c b/drivers/fpga/altera-pr-ip-core.c
index 5b130c4d9882..c150a084e440 100644
--- a/drivers/fpga/altera-pr-ip-core.c
+++ b/drivers/fpga/altera-pr-ip-core.c
@@ -201,11 +201,7 @@ EXPORT_SYMBOL_GPL(alt_pr_register);
 
 void alt_pr_unregister(struct device *dev)
 {
-	struct fpga_manager *mgr = dev_get_drvdata(dev);
-
 	dev_dbg(dev, "%s\n", __func__);
-
-	fpga_mgr_unregister(mgr);
 }
 EXPORT_SYMBOL_GPL(alt_pr_unregister);
 
-- 
2.25.1


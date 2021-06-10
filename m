Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB34C3A3420
	for <lists+linux-fpga@lfdr.de>; Thu, 10 Jun 2021 21:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbhFJTgb (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 10 Jun 2021 15:36:31 -0400
Received: from mga17.intel.com ([192.55.52.151]:36545 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230322AbhFJTga (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 10 Jun 2021 15:36:30 -0400
IronPort-SDR: l92XTwMw0Kq/QyPTCFP2lS8W1/V9d9BOpBEpljL7X7luHKLfNQfbw/NhTWZ2AEPFqndNy0dLEq
 E0Yek1HAaTEg==
X-IronPort-AV: E=McAfee;i="6200,9189,10011"; a="185756070"
X-IronPort-AV: E=Sophos;i="5.83,264,1616482800"; 
   d="scan'208";a="185756070"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2021 12:34:28 -0700
IronPort-SDR: Tng3ZgZVaUyIDZ+2gx1oxxELsoBCK1TqWp/U3Z5GaAMX7Tr+o61kOk2THjPohpUGVDa/GaKMkG
 Ivz9VHIP+KLQ==
X-IronPort-AV: E=Sophos;i="5.83,264,1616482800"; 
   d="scan'208";a="477458076"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO rhweight-mobl2.ra.intel.com) ([10.212.184.121])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2021 12:34:27 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        richard.gong@intel.com, Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v3 1/8] fpga: altera-pr-ip: Remove function alt_pr_unregister
Date:   Thu, 10 Jun 2021 12:34:15 -0700
Message-Id: <20210610193422.286835-2-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210610193422.286835-1-russell.h.weight@intel.com>
References: <20210610193422.286835-1-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Remove the alt_pr_unregister() function; it is no longer used.

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Reviewed-by: Xu Yilun <yilun.xu@intel.com>
---
v3:
  - Added Reviewed-by tag
v2:
  - The first version of this patch was entitled:
    "fpga: altera-pr-ip: Remove function alt_pr_unregister". This version of the
    patch removes the alt_pr_unregister() function altogether, instead of just
    removing portions of it.
---
 drivers/fpga/altera-pr-ip-core.c       | 10 ----------
 include/linux/fpga/altera-pr-ip-core.h |  1 -
 2 files changed, 11 deletions(-)

diff --git a/drivers/fpga/altera-pr-ip-core.c b/drivers/fpga/altera-pr-ip-core.c
index 5b130c4d9882..dfdf21ed34c4 100644
--- a/drivers/fpga/altera-pr-ip-core.c
+++ b/drivers/fpga/altera-pr-ip-core.c
@@ -199,16 +199,6 @@ int alt_pr_register(struct device *dev, void __iomem *reg_base)
 }
 EXPORT_SYMBOL_GPL(alt_pr_register);
 
-void alt_pr_unregister(struct device *dev)
-{
-	struct fpga_manager *mgr = dev_get_drvdata(dev);
-
-	dev_dbg(dev, "%s\n", __func__);
-
-	fpga_mgr_unregister(mgr);
-}
-EXPORT_SYMBOL_GPL(alt_pr_unregister);
-
 MODULE_AUTHOR("Matthew Gerlach <matthew.gerlach@linux.intel.com>");
 MODULE_DESCRIPTION("Altera Partial Reconfiguration IP Core");
 MODULE_LICENSE("GPL v2");
diff --git a/include/linux/fpga/altera-pr-ip-core.h b/include/linux/fpga/altera-pr-ip-core.h
index 0b08ac20ab16..a6b4c07858cc 100644
--- a/include/linux/fpga/altera-pr-ip-core.h
+++ b/include/linux/fpga/altera-pr-ip-core.h
@@ -13,6 +13,5 @@
 #include <linux/io.h>
 
 int alt_pr_register(struct device *dev, void __iomem *reg_base);
-void alt_pr_unregister(struct device *dev);
 
 #endif /* _ALT_PR_IP_CORE_H */
-- 
2.25.1


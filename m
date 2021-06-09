Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16E6A3A08A5
	for <lists+linux-fpga@lfdr.de>; Wed,  9 Jun 2021 02:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbhFIAva (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 8 Jun 2021 20:51:30 -0400
Received: from mga11.intel.com ([192.55.52.93]:53671 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231535AbhFIAv2 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 8 Jun 2021 20:51:28 -0400
IronPort-SDR: hS8ov8Uh+IaI3gYZpq/2IgVUfJ7QBVG89qHxaEmTqUr5bjq7ykaNf/Xej3bEs+lS+undOvzo53
 26hyjXGKcQKw==
X-IronPort-AV: E=McAfee;i="6200,9189,10009"; a="201954217"
X-IronPort-AV: E=Sophos;i="5.83,259,1616482800"; 
   d="scan'208";a="201954217"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 17:49:31 -0700
IronPort-SDR: cWpYcW8lkqHVjnZFTdZJN0kkvj5kBvQgkfmxXoK1Gi8KX/g9miSjTum18zn3HOnkrBZMZtXEx4
 obL801oqaZRw==
X-IronPort-AV: E=Sophos;i="5.83,259,1616482800"; 
   d="scan'208";a="449747481"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO rhweight-mobl2.ra.intel.com) ([10.209.100.99])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 17:49:31 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        richard.gong@intel.com, Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v1 3/5] fpga: stratix10-soc: Add missing fpga_mgr_free() call
Date:   Tue,  8 Jun 2021 17:49:23 -0700
Message-Id: <20210609004925.238044-4-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210609004925.238044-1-russell.h.weight@intel.com>
References: <20210609004925.238044-1-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The stratix10-soc driver uses fpga_mgr_create() function and is therefore
responsible to call fpga_mgr_free() to release the class driver resources.
Add a missing call to fpga_mgr_free in the s10_remove() function.

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
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


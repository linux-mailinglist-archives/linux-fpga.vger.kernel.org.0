Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9753A1FE0
	for <lists+linux-fpga@lfdr.de>; Thu, 10 Jun 2021 00:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbhFIWQp (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 9 Jun 2021 18:16:45 -0400
Received: from mga18.intel.com ([134.134.136.126]:22632 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229705AbhFIWQp (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 9 Jun 2021 18:16:45 -0400
IronPort-SDR: /crg8Oat9z3JtQn8OYt7uwKBT+eCdBJYKODKyp5Xe+ke1a0QnMPBEkW25d2gcPsREdJCYZNG4q
 HO9MrCIhl/rg==
X-IronPort-AV: E=McAfee;i="6200,9189,10010"; a="192496222"
X-IronPort-AV: E=Sophos;i="5.83,261,1616482800"; 
   d="scan'208";a="192496222"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 15:14:44 -0700
IronPort-SDR: vJWkLBw2uo43mdE2RXXCialkX31S7Snq7YG//2jIAyWqwNllS8S/JEkC/5eClZuHBel0bulfZx
 3gFmgEdgk/rA==
X-IronPort-AV: E=Sophos;i="5.83,261,1616482800"; 
   d="scan'208";a="477095341"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO rhweight-mobl2.ra.intel.com) ([10.251.20.114])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 15:14:43 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        richard.gong@intel.com, Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v2 7/8] fpga: bridge: Use standard dev_release for class driver
Date:   Wed,  9 Jun 2021 15:11:34 -0700
Message-Id: <20210609221135.261837-8-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210609221135.261837-1-russell.h.weight@intel.com>
References: <20210609221135.261837-1-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The FPGA bridge class driver data structure is being treated as a managed
resource instead of using standard dev_release call-back to release the
class data structure. This change populates the class.dev_release function
and changes the fpga_bridge_free() function to call put_device(). It also
changes fpga_bridge_unregister() to call device_del() instead of
device_unregister().

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
---
v2:
  - Moved the renaming of "dev" to "parent" to a separate patch
  - Call fpga_bridge_free() in devm_fpga_bridge_release() instead of
    put_device()
---
 drivers/fpga/fpga-bridge.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
index 6c56afc66a6d..b40f4b4228e7 100644
--- a/drivers/fpga/fpga-bridge.c
+++ b/drivers/fpga/fpga-bridge.c
@@ -340,8 +340,10 @@ struct fpga_bridge *fpga_bridge_create(struct device *parent, const char *name,
 		return NULL;
 
 	id = ida_simple_get(&fpga_bridge_ida, 0, 0, GFP_KERNEL);
-	if (id < 0)
-		goto error_kfree;
+	if (id < 0) {
+		kfree(bridge);
+		return NULL;
+	}
 
 	mutex_init(&bridge->mutex);
 	INIT_LIST_HEAD(&bridge->node);
@@ -358,17 +360,12 @@ struct fpga_bridge *fpga_bridge_create(struct device *parent, const char *name,
 	bridge->dev.id = id;
 
 	ret = dev_set_name(&bridge->dev, "br%d", id);
-	if (ret)
-		goto error_device;
+	if (ret) {
+		put_device(&bridge->dev);
+		return NULL;
+	}
 
 	return bridge;
-
-error_device:
-	ida_simple_remove(&fpga_bridge_ida, id);
-error_kfree:
-	kfree(bridge);
-
-	return NULL;
 }
 EXPORT_SYMBOL_GPL(fpga_bridge_create);
 
@@ -378,8 +375,7 @@ EXPORT_SYMBOL_GPL(fpga_bridge_create);
  */
 void fpga_bridge_free(struct fpga_bridge *bridge)
 {
-	ida_simple_remove(&fpga_bridge_ida, bridge->dev.id);
-	kfree(bridge);
+	put_device(&bridge->dev);
 }
 EXPORT_SYMBOL_GPL(fpga_bridge_free);
 
@@ -469,12 +465,16 @@ void fpga_bridge_unregister(struct fpga_bridge *bridge)
 	if (bridge->br_ops && bridge->br_ops->fpga_bridge_remove)
 		bridge->br_ops->fpga_bridge_remove(bridge);
 
-	device_unregister(&bridge->dev);
+	device_del(&bridge->dev);
 }
 EXPORT_SYMBOL_GPL(fpga_bridge_unregister);
 
 static void fpga_bridge_dev_release(struct device *dev)
 {
+	struct fpga_bridge *bridge = to_fpga_bridge(dev);
+
+	ida_simple_remove(&fpga_bridge_ida, bridge->dev.id);
+	kfree(bridge);
 }
 
 static int __init fpga_bridge_dev_init(void)
-- 
2.25.1


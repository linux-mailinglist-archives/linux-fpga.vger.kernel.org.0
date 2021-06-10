Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 189523A3427
	for <lists+linux-fpga@lfdr.de>; Thu, 10 Jun 2021 21:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbhFJTge (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 10 Jun 2021 15:36:34 -0400
Received: from mga17.intel.com ([192.55.52.151]:36549 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230462AbhFJTgd (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 10 Jun 2021 15:36:33 -0400
IronPort-SDR: tyFt7AmHuJAFP4FqnH22Tg7YuVteMEZnXScATmZxpmDgUIM1092orEUi8IazszTdQnTb4ER/iJ
 57xGN1DHKKzA==
X-IronPort-AV: E=McAfee;i="6200,9189,10011"; a="185756091"
X-IronPort-AV: E=Sophos;i="5.83,264,1616482800"; 
   d="scan'208";a="185756091"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2021 12:34:36 -0700
IronPort-SDR: PYY8qrDhHeaaaJNUwcgvCxI0K4ZJ+V9wOGIsJKPj7yAW4+pV9ubHxiMXCmaB0JZplX6SHEABpj
 Vh7fa0elzE9Q==
X-IronPort-AV: E=Sophos;i="5.83,264,1616482800"; 
   d="scan'208";a="477458114"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO rhweight-mobl2.ra.intel.com) ([10.212.184.121])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2021 12:34:35 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        richard.gong@intel.com, Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v3 8/8] fpga: region: Use standard dev_release for class driver
Date:   Thu, 10 Jun 2021 12:34:22 -0700
Message-Id: <20210610193422.286835-9-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210610193422.286835-1-russell.h.weight@intel.com>
References: <20210610193422.286835-1-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The FPGA region class driver data structure is being treated as a managed
resource instead of using standard dev_release call-back to release the
class data structure. This change populates the class.dev_release function
and changes the fpga_region_free() function to call put_device().
It also changes fpga_region_unregister() to call device_del() instead
of device_unregister().

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Reviewed-by: Xu Yilun <yilun.xu@intel.com>
---
v3:
  - moved a "dev" to "parent" rename in the comment header for
    devm_fpga_region_create() to the appropriate patch.
  - Added Reviewed-by tag
v2:
  - Moved the renaming of "dev" to "parent" to a separate patch
  - Call fpga_region_free() in devm_fpga_region_release() instead of put_device()
---
 drivers/fpga/fpga-region.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
index 4d60d643cada..bdc15fab60c0 100644
--- a/drivers/fpga/fpga-region.c
+++ b/drivers/fpga/fpga-region.c
@@ -204,8 +204,10 @@ struct fpga_region
 		return NULL;
 
 	id = ida_simple_get(&fpga_region_ida, 0, 0, GFP_KERNEL);
-	if (id < 0)
-		goto err_free;
+	if (id < 0) {
+		kfree(region);
+		return NULL;
+	}
 
 	region->mgr = mgr;
 	region->get_bridges = get_bridges;
@@ -219,17 +221,12 @@ struct fpga_region
 	region->dev.id = id;
 
 	ret = dev_set_name(&region->dev, "region%d", id);
-	if (ret)
-		goto err_remove;
+	if (ret) {
+		put_device(&region->dev);
+		return NULL;
+	}
 
 	return region;
-
-err_remove:
-	ida_simple_remove(&fpga_region_ida, id);
-err_free:
-	kfree(region);
-
-	return NULL;
 }
 EXPORT_SYMBOL_GPL(fpga_region_create);
 
@@ -239,8 +236,7 @@ EXPORT_SYMBOL_GPL(fpga_region_create);
  */
 void fpga_region_free(struct fpga_region *region)
 {
-	ida_simple_remove(&fpga_region_ida, region->dev.id);
-	kfree(region);
+	put_device(&region->dev);
 }
 EXPORT_SYMBOL_GPL(fpga_region_free);
 
@@ -310,12 +306,16 @@ EXPORT_SYMBOL_GPL(fpga_region_register);
  */
 void fpga_region_unregister(struct fpga_region *region)
 {
-	device_unregister(&region->dev);
+	device_del(&region->dev);
 }
 EXPORT_SYMBOL_GPL(fpga_region_unregister);
 
 static void fpga_region_dev_release(struct device *dev)
 {
+	struct fpga_region *region = to_fpga_region(dev);
+
+	ida_simple_remove(&fpga_region_ida, region->dev.id);
+	kfree(region);
 }
 
 /**
-- 
2.25.1


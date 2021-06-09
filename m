Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76FA33A1FE2
	for <lists+linux-fpga@lfdr.de>; Thu, 10 Jun 2021 00:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbhFIWQr (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 9 Jun 2021 18:16:47 -0400
Received: from mga18.intel.com ([134.134.136.126]:22632 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229535AbhFIWQp (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 9 Jun 2021 18:16:45 -0400
IronPort-SDR: qCYL81gop8nssK1NUFTmxhk6WhnPoXx9roEJ/fCz+WXGNPJ3AThuQrDwjZtRK61DjCXh+4memj
 60S327RFjDIA==
X-IronPort-AV: E=McAfee;i="6200,9189,10010"; a="192496224"
X-IronPort-AV: E=Sophos;i="5.83,261,1616482800"; 
   d="scan'208";a="192496224"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 15:14:44 -0700
IronPort-SDR: nBw5Cza1AKQ3ns9FJBQLYlQXbOPpbYqXYwKgXFmx1zrauNnAGUMVXyUaLEdfbHklEsuDmtG2cU
 WERXK7X/ajpA==
X-IronPort-AV: E=Sophos;i="5.83,261,1616482800"; 
   d="scan'208";a="477095344"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO rhweight-mobl2.ra.intel.com) ([10.251.20.114])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 15:14:44 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        richard.gong@intel.com, Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v2 8/8] fpga: region: Use standard dev_release for class driver
Date:   Wed,  9 Jun 2021 15:11:35 -0700
Message-Id: <20210609221135.261837-9-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210609221135.261837-1-russell.h.weight@intel.com>
References: <20210609221135.261837-1-russell.h.weight@intel.com>
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
---
v2:
  - Moved the renaming of "dev" to "parent" to a separate patch
  - Call fpga_region_free() in devm_fpga_region_release() instead of put_device()
---
 drivers/fpga/fpga-region.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
index 563626d66e56..bdc15fab60c0 100644
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
 
@@ -253,7 +249,7 @@ static void devm_fpga_region_release(struct device *dev, void *res)
 
 /**
  * devm_fpga_region_create - create and initialize a managed FPGA region struct
- * @dev: device parent
+ * @parent: device parent
  * @mgr: manager that programs this region
  * @get_bridges: optional function to get bridges to a list
  *
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


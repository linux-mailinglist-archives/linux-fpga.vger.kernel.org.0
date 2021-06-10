Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 662DC3A3426
	for <lists+linux-fpga@lfdr.de>; Thu, 10 Jun 2021 21:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbhFJTge (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 10 Jun 2021 15:36:34 -0400
Received: from mga17.intel.com ([192.55.52.151]:36545 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230479AbhFJTgd (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 10 Jun 2021 15:36:33 -0400
IronPort-SDR: Bu36er0lyqg5Jj6fg/CS/5ny2WIBPm6BVjEO6xlySI8ZMD+mYpLTG8Zl3ntHrgE4vqFgKxfA8e
 aL5QlaPkohgg==
X-IronPort-AV: E=McAfee;i="6200,9189,10011"; a="185756083"
X-IronPort-AV: E=Sophos;i="5.83,264,1616482800"; 
   d="scan'208";a="185756083"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2021 12:34:33 -0700
IronPort-SDR: s2JnthPZxkmoV5fjiAIczbrwwgikV7V0hvHu5jDeZD3CoLquul4hJZsVSROuehHOvPFdwSwQyT
 G8v08q3oeQuQ==
X-IronPort-AV: E=Sophos;i="5.83,264,1616482800"; 
   d="scan'208";a="477458100"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO rhweight-mobl2.ra.intel.com) ([10.212.184.121])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2021 12:34:32 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        richard.gong@intel.com, Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v3 5/8] fpga: region: Rename dev to parent for parent device
Date:   Thu, 10 Jun 2021 12:34:19 -0700
Message-Id: <20210610193422.286835-6-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210610193422.286835-1-russell.h.weight@intel.com>
References: <20210610193422.286835-1-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Rename variable "dev" to "parent" in cases where it represents the parent
device.

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Reviewed-by: Xu Yilun <yilun.xu@intel.com>
---
v3:
  - Added a "dev" to "parent" rename in the comment header for
    devm_fpga_region_create() that was missed in the first verion.
  - Added Reviewed-by tag
v2:
  - This patch contains the renaming of "dev" to "parent" that was previously
    part of the patch: "fpga: region: Use standard dev_release for class driver"
---
 drivers/fpga/fpga-region.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
index c3134b89c3fe..4d60d643cada 100644
--- a/drivers/fpga/fpga-region.c
+++ b/drivers/fpga/fpga-region.c
@@ -181,7 +181,7 @@ ATTRIBUTE_GROUPS(fpga_region);
 
 /**
  * fpga_region_create - alloc and init a struct fpga_region
- * @dev: device parent
+ * @parent: device parent
  * @mgr: manager that programs this region
  * @get_bridges: optional function to get bridges to a list
  *
@@ -192,7 +192,7 @@ ATTRIBUTE_GROUPS(fpga_region);
  * Return: struct fpga_region or NULL
  */
 struct fpga_region
-*fpga_region_create(struct device *dev,
+*fpga_region_create(struct device *parent,
 		    struct fpga_manager *mgr,
 		    int (*get_bridges)(struct fpga_region *))
 {
@@ -214,8 +214,8 @@ struct fpga_region
 
 	device_initialize(&region->dev);
 	region->dev.class = fpga_region_class;
-	region->dev.parent = dev;
-	region->dev.of_node = dev->of_node;
+	region->dev.parent = parent;
+	region->dev.of_node = parent->of_node;
 	region->dev.id = id;
 
 	ret = dev_set_name(&region->dev, "region%d", id);
@@ -253,7 +253,7 @@ static void devm_fpga_region_release(struct device *dev, void *res)
 
 /**
  * devm_fpga_region_create - create and initialize a managed FPGA region struct
- * @dev: device parent
+ * @parent: device parent
  * @mgr: manager that programs this region
  * @get_bridges: optional function to get bridges to a list
  *
@@ -268,7 +268,7 @@ static void devm_fpga_region_release(struct device *dev, void *res)
  * Return: struct fpga_region or NULL
  */
 struct fpga_region
-*devm_fpga_region_create(struct device *dev,
+*devm_fpga_region_create(struct device *parent,
 			 struct fpga_manager *mgr,
 			 int (*get_bridges)(struct fpga_region *))
 {
@@ -278,12 +278,12 @@ struct fpga_region
 	if (!ptr)
 		return NULL;
 
-	region = fpga_region_create(dev, mgr, get_bridges);
+	region = fpga_region_create(parent, mgr, get_bridges);
 	if (!region) {
 		devres_free(ptr);
 	} else {
 		*ptr = region;
-		devres_add(dev, ptr);
+		devres_add(parent, ptr);
 	}
 
 	return region;
-- 
2.25.1


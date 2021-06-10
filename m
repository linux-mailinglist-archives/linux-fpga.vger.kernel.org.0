Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6374A3A3422
	for <lists+linux-fpga@lfdr.de>; Thu, 10 Jun 2021 21:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbhFJTgc (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 10 Jun 2021 15:36:32 -0400
Received: from mga17.intel.com ([192.55.52.151]:36545 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230462AbhFJTgc (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 10 Jun 2021 15:36:32 -0400
IronPort-SDR: ugJ/TnypSr5v709c5kREWrWAIeFYF60dHFqMdGHR2Lyeys4QociW5U6H+Y7Ftsv3mJmJHi8HLm
 bgk/IL6o2w5A==
X-IronPort-AV: E=McAfee;i="6200,9189,10011"; a="185756081"
X-IronPort-AV: E=Sophos;i="5.83,264,1616482800"; 
   d="scan'208";a="185756081"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2021 12:34:32 -0700
IronPort-SDR: bxhmxWsGHqQmxdCKzm2LXiX+1Jv0yA3aXqRLIslgg1NQmOOxVuzI3dQD9mOc6IikV7Mr5nXrKU
 ojxcSH65jnow==
X-IronPort-AV: E=Sophos;i="5.83,264,1616482800"; 
   d="scan'208";a="477458097"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO rhweight-mobl2.ra.intel.com) ([10.212.184.121])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2021 12:34:29 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        richard.gong@intel.com, Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v3 4/8] fpga: bridge: Rename dev to parent for parent device
Date:   Thu, 10 Jun 2021 12:34:18 -0700
Message-Id: <20210610193422.286835-5-russell.h.weight@intel.com>
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
  - Added Reviewed-by tag
v2:
  - This patch contains the renaming of "dev" to "parent" that was previously
    part of the patch: "fpga: bridge: Use standard dev_release for class driver"
---
 drivers/fpga/fpga-bridge.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
index 05c6d4f2d043..6c56afc66a6d 100644
--- a/drivers/fpga/fpga-bridge.c
+++ b/drivers/fpga/fpga-bridge.c
@@ -313,7 +313,7 @@ ATTRIBUTE_GROUPS(fpga_bridge);
 
 /**
  * fpga_bridge_create - create and initialize a struct fpga_bridge
- * @dev:	FPGA bridge device from pdev
+ * @parent:	FPGA bridge device from pdev
  * @name:	FPGA bridge name
  * @br_ops:	pointer to structure of fpga bridge ops
  * @priv:	FPGA bridge private data
@@ -323,7 +323,7 @@ ATTRIBUTE_GROUPS(fpga_bridge);
  *
  * Return: struct fpga_bridge or NULL
  */
-struct fpga_bridge *fpga_bridge_create(struct device *dev, const char *name,
+struct fpga_bridge *fpga_bridge_create(struct device *parent, const char *name,
 				       const struct fpga_bridge_ops *br_ops,
 				       void *priv)
 {
@@ -331,7 +331,7 @@ struct fpga_bridge *fpga_bridge_create(struct device *dev, const char *name,
 	int id, ret;
 
 	if (!name || !strlen(name)) {
-		dev_err(dev, "Attempt to register with no name!\n");
+		dev_err(parent, "Attempt to register with no name!\n");
 		return NULL;
 	}
 
@@ -353,8 +353,8 @@ struct fpga_bridge *fpga_bridge_create(struct device *dev, const char *name,
 	device_initialize(&bridge->dev);
 	bridge->dev.groups = br_ops->groups;
 	bridge->dev.class = fpga_bridge_class;
-	bridge->dev.parent = dev;
-	bridge->dev.of_node = dev->of_node;
+	bridge->dev.parent = parent;
+	bridge->dev.of_node = parent->of_node;
 	bridge->dev.id = id;
 
 	ret = dev_set_name(&bridge->dev, "br%d", id);
@@ -392,7 +392,7 @@ static void devm_fpga_bridge_release(struct device *dev, void *res)
 
 /**
  * devm_fpga_bridge_create - create and init a managed struct fpga_bridge
- * @dev:	FPGA bridge device from pdev
+ * @parent:	FPGA bridge device from pdev
  * @name:	FPGA bridge name
  * @br_ops:	pointer to structure of fpga bridge ops
  * @priv:	FPGA bridge private data
@@ -408,7 +408,7 @@ static void devm_fpga_bridge_release(struct device *dev, void *res)
  *  Return: struct fpga_bridge or NULL
  */
 struct fpga_bridge
-*devm_fpga_bridge_create(struct device *dev, const char *name,
+*devm_fpga_bridge_create(struct device *parent, const char *name,
 			 const struct fpga_bridge_ops *br_ops, void *priv)
 {
 	struct fpga_bridge **ptr, *bridge;
@@ -417,12 +417,12 @@ struct fpga_bridge
 	if (!ptr)
 		return NULL;
 
-	bridge = fpga_bridge_create(dev, name, br_ops, priv);
+	bridge = fpga_bridge_create(parent, name, br_ops, priv);
 	if (!bridge) {
 		devres_free(ptr);
 	} else {
 		*ptr = bridge;
-		devres_add(dev, ptr);
+		devres_add(parent, ptr);
 	}
 
 	return bridge;
-- 
2.25.1


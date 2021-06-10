Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8023A3424
	for <lists+linux-fpga@lfdr.de>; Thu, 10 Jun 2021 21:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbhFJTgd (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 10 Jun 2021 15:36:33 -0400
Received: from mga17.intel.com ([192.55.52.151]:36549 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230467AbhFJTgc (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 10 Jun 2021 15:36:32 -0400
IronPort-SDR: KVweHjacBhh3Tz4fKihudhh9HGAJbxwAqApr5diPp4wo+hMrga8rJnVHxDlib4XNixRROlbo8Y
 PZ3HFCRALNOA==
X-IronPort-AV: E=McAfee;i="6200,9189,10011"; a="185756074"
X-IronPort-AV: E=Sophos;i="5.83,264,1616482800"; 
   d="scan'208";a="185756074"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2021 12:34:29 -0700
IronPort-SDR: z1iFBR+UPv2uD0PsiQ+LjRpyyINI/8Qg4gJAmKTMhGTc6yvDjlrqY//uaAuxOcfYiFH5IYRV5X
 m63/XItEqH+Q==
X-IronPort-AV: E=Sophos;i="5.83,264,1616482800"; 
   d="scan'208";a="477458083"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO rhweight-mobl2.ra.intel.com) ([10.212.184.121])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2021 12:34:28 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        richard.gong@intel.com, Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v3 3/8] fpga: mgr: Rename dev to parent for parent device
Date:   Thu, 10 Jun 2021 12:34:17 -0700
Message-Id: <20210610193422.286835-4-russell.h.weight@intel.com>
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
    part of the patch: "fpga: mgr: Use standard dev_release for class driver"
---
 drivers/fpga/fpga-mgr.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index b85bc47c91a9..42ddc0844781 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -551,7 +551,7 @@ EXPORT_SYMBOL_GPL(fpga_mgr_unlock);
 
 /**
  * fpga_mgr_create - create and initialize a FPGA manager struct
- * @dev:	fpga manager device from pdev
+ * @parent:	fpga manager device from pdev
  * @name:	fpga manager name
  * @mops:	pointer to structure of fpga manager ops
  * @priv:	fpga manager private data
@@ -561,7 +561,7 @@ EXPORT_SYMBOL_GPL(fpga_mgr_unlock);
  *
  * Return: pointer to struct fpga_manager or NULL
  */
-struct fpga_manager *fpga_mgr_create(struct device *dev, const char *name,
+struct fpga_manager *fpga_mgr_create(struct device *parent, const char *name,
 				     const struct fpga_manager_ops *mops,
 				     void *priv)
 {
@@ -571,12 +571,12 @@ struct fpga_manager *fpga_mgr_create(struct device *dev, const char *name,
 	if (!mops || !mops->write_complete || !mops->state ||
 	    !mops->write_init || (!mops->write && !mops->write_sg) ||
 	    (mops->write && mops->write_sg)) {
-		dev_err(dev, "Attempt to register without fpga_manager_ops\n");
+		dev_err(parent, "Attempt to register without fpga_manager_ops\n");
 		return NULL;
 	}
 
 	if (!name || !strlen(name)) {
-		dev_err(dev, "Attempt to register with no name!\n");
+		dev_err(parent, "Attempt to register with no name!\n");
 		return NULL;
 	}
 
@@ -597,8 +597,8 @@ struct fpga_manager *fpga_mgr_create(struct device *dev, const char *name,
 	device_initialize(&mgr->dev);
 	mgr->dev.class = fpga_mgr_class;
 	mgr->dev.groups = mops->groups;
-	mgr->dev.parent = dev;
-	mgr->dev.of_node = dev->of_node;
+	mgr->dev.parent = parent;
+	mgr->dev.of_node = parent->of_node;
 	mgr->dev.id = id;
 
 	ret = dev_set_name(&mgr->dev, "fpga%d", id);
@@ -636,7 +636,7 @@ static void devm_fpga_mgr_release(struct device *dev, void *res)
 
 /**
  * devm_fpga_mgr_create - create and initialize a managed FPGA manager struct
- * @dev:	fpga manager device from pdev
+ * @parent:	fpga manager device from pdev
  * @name:	fpga manager name
  * @mops:	pointer to structure of fpga manager ops
  * @priv:	fpga manager private data
@@ -651,7 +651,7 @@ static void devm_fpga_mgr_release(struct device *dev, void *res)
  *
  * Return: pointer to struct fpga_manager or NULL
  */
-struct fpga_manager *devm_fpga_mgr_create(struct device *dev, const char *name,
+struct fpga_manager *devm_fpga_mgr_create(struct device *parent, const char *name,
 					  const struct fpga_manager_ops *mops,
 					  void *priv)
 {
@@ -661,13 +661,13 @@ struct fpga_manager *devm_fpga_mgr_create(struct device *dev, const char *name,
 	if (!dr)
 		return NULL;
 
-	dr->mgr = fpga_mgr_create(dev, name, mops, priv);
+	dr->mgr = fpga_mgr_create(parent, name, mops, priv);
 	if (!dr->mgr) {
 		devres_free(dr);
 		return NULL;
 	}
 
-	devres_add(dev, dr);
+	devres_add(parent, dr);
 
 	return dr->mgr;
 }
-- 
2.25.1


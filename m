Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59EB53A6CCA
	for <lists+linux-fpga@lfdr.de>; Mon, 14 Jun 2021 19:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235494AbhFNRLb (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 14 Jun 2021 13:11:31 -0400
Received: from mail-pl1-f182.google.com ([209.85.214.182]:45595 "EHLO
        mail-pl1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235485AbhFNRLa (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 14 Jun 2021 13:11:30 -0400
Received: by mail-pl1-f182.google.com with SMTP id 11so6911884plk.12
        for <linux-fpga@vger.kernel.org>; Mon, 14 Jun 2021 10:09:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J51T/obrOPyGovoDbxVC+XlPtDQp4fDs5hHapdvBwUQ=;
        b=T6FQyzPDhQEoCeU43s0YermfCuZZd1zK7pGIs8N2H0JmePnv5jrOFynDXbwUE6rRIC
         RIRN4Qsk3ExXR52P79aIkux3k96OMtsB7HnfjlBmAGE2NWyvZUauJjsYrznww2nQxois
         8W+J2EFdh9+S7Mxp85UGYpK3vIJTH/lae4Tqtu1Q3XF3Pm00MR+h1M588zHO8Vkn7UuK
         G/1OURFkofkspKHXw+BuxSAsoqkBsJNeCPW8q1iNWUp/7oQz0hq8labeLSupacGMPQuB
         w3Tcn+MCBE0ivEVwjqg6YvTE7L+ut7G/1Dc/dZxh6lUxAotquVmKUhQU/3d9ZEmKGqRZ
         TUyw==
X-Gm-Message-State: AOAM530BIdeZRmHK6W+wHen53YhDqmCe/RBs6+sHDhFtZ4eJAlL6TjcN
        pKViAwoCiVexSwiLKdRn89o=
X-Google-Smtp-Source: ABdhPJz1ofeenPb7MeqGNomVR3olGcRm75QReY+latpEcF6F58+y6X1WQ/C+GImP9VC6cSMJ+SzgEQ==
X-Received: by 2002:a17:90a:398f:: with SMTP id z15mr20118996pjb.183.1623690567460;
        Mon, 14 Jun 2021 10:09:27 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id u7sm13767164pgl.39.2021.06.14.10.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 10:09:26 -0700 (PDT)
From:   Moritz Fischer <mdf@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-fpga@vger.kernel.org, Moritz Fischer <mdf@kernel.org>,
        Russ Weight <russell.h.weight@intel.com>,
        Xu Yilun <yilun.xu@intel.com>
Subject: [PATCH 3/8] fpga: mgr: Rename dev to parent for parent device
Date:   Mon, 14 Jun 2021 10:09:04 -0700
Message-Id: <20210614170909.232415-4-mdf@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210614170909.232415-1-mdf@kernel.org>
References: <20210614170909.232415-1-mdf@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Russ Weight <russell.h.weight@intel.com>

Rename variable "dev" to "parent" in cases where it represents the parent
device.

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Reviewed-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Moritz Fischer <mdf@kernel.org>
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
2.31.1


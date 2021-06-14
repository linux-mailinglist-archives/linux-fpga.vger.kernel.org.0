Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8EF3A6CCF
	for <lists+linux-fpga@lfdr.de>; Mon, 14 Jun 2021 19:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235497AbhFNRLt (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 14 Jun 2021 13:11:49 -0400
Received: from mail-pj1-f51.google.com ([209.85.216.51]:36721 "EHLO
        mail-pj1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235485AbhFNRLr (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 14 Jun 2021 13:11:47 -0400
Received: by mail-pj1-f51.google.com with SMTP id s17-20020a17090a8811b029016e89654f93so5328085pjn.1
        for <linux-fpga@vger.kernel.org>; Mon, 14 Jun 2021 10:09:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QuO24i1X2z6IyYjkrN2N6FYOKq0ITn0EZx7zLWieMiE=;
        b=PEBeBXO+qlg8yGWQCSM+uQW/KWHTE6iJuJcbHy+VjyA9DDn25IdjN5oncB0D8XA/pe
         nf5EXhuJ5R3DVbDrdp1bemkBXDRpOX/qT8Y7IL11Kjn7+8Q0O9pSk+5Ocd6Uq3vbv57q
         xlmSriH/MxOR7OtJOutfmT8tXk+GQAKOR7iB7xL3O6ntw0Eo0Nubx1wXmvh/qvSAK26K
         RabQB6c6QEBiGzzcOuRQjaCoNu0fZpVAxKY2gXGRO6RE0PNpJbtQ5YPq8laysg5ELM1Q
         CSlsWQUuSjzi+HrkBzTK9U3G3kGcP4uN0RTRMSpHYXTVvJ0SoFQbLr6ghqcREd5QQa27
         NUMQ==
X-Gm-Message-State: AOAM531LA5KsOL2ynu+eODIWc2KmLChqKyqu0Yq1brlt99pl1bL/o0Gg
        2gsqB1jlhNreGjJKhrvvT0w=
X-Google-Smtp-Source: ABdhPJyC8HS2xWHTtcjUi+GiG2jnKfXmHKaHuNoKU5J2YrMBjZIYfCsDYfAyHKxVhu1hSJtAHXmuWw==
X-Received: by 2002:a17:90a:901:: with SMTP id n1mr163591pjn.44.1623690569296;
        Mon, 14 Jun 2021 10:09:29 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id d3sm13369787pfn.141.2021.06.14.10.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 10:09:28 -0700 (PDT)
From:   Moritz Fischer <mdf@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-fpga@vger.kernel.org, Moritz Fischer <mdf@kernel.org>,
        Russ Weight <russell.h.weight@intel.com>,
        Xu Yilun <yilun.xu@intel.com>
Subject: [PATCH 4/8] fpga: bridge: Rename dev to parent for parent device
Date:   Mon, 14 Jun 2021 10:09:05 -0700
Message-Id: <20210614170909.232415-5-mdf@kernel.org>
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
 drivers/fpga/fpga-bridge.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
index e9266b2a357f..d4aca0f724f5 100644
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
2.31.1


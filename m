Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5B5E3A6CD0
	for <lists+linux-fpga@lfdr.de>; Mon, 14 Jun 2021 19:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235502AbhFNRLu (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 14 Jun 2021 13:11:50 -0400
Received: from mail-pg1-f169.google.com ([209.85.215.169]:44857 "EHLO
        mail-pg1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235485AbhFNRLu (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 14 Jun 2021 13:11:50 -0400
Received: by mail-pg1-f169.google.com with SMTP id t13so1808454pgu.11
        for <linux-fpga@vger.kernel.org>; Mon, 14 Jun 2021 10:09:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1IKLcPLgXhbPPaHVOyD7rp4+LtK4qcz/bWQRShT4Gok=;
        b=A0prdY0aOEli8SstWH3pzq6JaoEC1th6kL9ievgLSllyX04MCvyzH4l8t+trFHo/g7
         4dIvCt0oRCToDo6OC+I+mfUb9lp5gY3ADVw6FCDnMRzahqRtiJ53joVbAhZ8NFq3QSi7
         UefNyw3FaId+XBhDtIgQ4gc98UCdH46x9rDHoQGE2G73AASs7E3WPU3SHkSQ53Tgogz/
         zjse7ItNIpRl9hZyr+QGKAyI3DsqivW+nor7RoEiiUaaRreTfBjDZmDuWEwRJmScktod
         uBwTgBdKLnxECM6ejxrkzLjv0VOgXi4Vpl9OiiizlC9cGoJFZUFwV5jw936cvZLBx1K9
         KXYw==
X-Gm-Message-State: AOAM530o3C51Su7EJ38tkQhvgKblHgoFGcA4/pfl/+eYKQIMyiITT713
        MgoCDf6pU8V1pXFUJnh3p34=
X-Google-Smtp-Source: ABdhPJyg/JG2AqLqM29MJon3jKhHQ7TiA3vlIYphr/A1aLCSFnnOLJYh/qlNrCvN6FXrR+Eoz/INpg==
X-Received: by 2002:a63:1a5b:: with SMTP id a27mr29661pgm.427.1623690570850;
        Mon, 14 Jun 2021 10:09:30 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id n37sm12742163pfv.47.2021.06.14.10.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 10:09:30 -0700 (PDT)
From:   Moritz Fischer <mdf@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-fpga@vger.kernel.org, Moritz Fischer <mdf@kernel.org>,
        Russ Weight <russell.h.weight@intel.com>,
        Xu Yilun <yilun.xu@intel.com>
Subject: [PATCH 5/8] fpga: region: Rename dev to parent for parent device
Date:   Mon, 14 Jun 2021 10:09:06 -0700
Message-Id: <20210614170909.232415-6-mdf@kernel.org>
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
2.31.1


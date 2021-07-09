Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE013C2936
	for <lists+linux-fpga@lfdr.de>; Fri,  9 Jul 2021 20:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbhGISti (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 9 Jul 2021 14:49:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25792 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229821AbhGISti (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 9 Jul 2021 14:49:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625856414;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=wMNuEC7p1hYYeQcAVeoisWoHkfZWMVz8tQXwl6mqvRw=;
        b=AmoX78kBhJpC2SdHqtGWt8ucCkbdBQAkQZkXmFBJbBkak96VfXxyQ9se2saonrC8R1r092
        XRDHoWQKLhtE0k+pQoxczDXTiN1ZYTFQ28Hxq4Qx4U0HsgiRjzch6Q/WAEsW+AMfpUErgv
        5AR2vrMs2cTLa7L/VxDTNIo6MM+QuEo=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-ewp7DsV4NJKgg02QuZsPig-1; Fri, 09 Jul 2021 14:46:53 -0400
X-MC-Unique: ewp7DsV4NJKgg02QuZsPig-1
Received: by mail-ot1-f72.google.com with SMTP id 16-20020a9d05900000b02903f5a4101f8eso1422897otd.17
        for <linux-fpga@vger.kernel.org>; Fri, 09 Jul 2021 11:46:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wMNuEC7p1hYYeQcAVeoisWoHkfZWMVz8tQXwl6mqvRw=;
        b=FxRpAHllKtw5RjjB71ykE7gpgbAVsmWZ9qALl4zZE7DxSlQMFs2kILnFW0HSVwkoNF
         uxi+xmcR7wSe6movl0eg9RavcE84JibaLycTgcl3laXhV1tOWFvV+65Vel1HpFMcFrsL
         UTGxGBBX3BqoQ919ZzjGpCAJ9YGIFgYCuryZGv31Gu7AQQ4WYHg4AisVTwAWNj5nanJC
         bBA7mkzXwWHMLCHY0avyUOUOk/RjVr4r+OMnctC/b6K2UU0rWptL377bJFGpm72npRtf
         YpeClH/P25z9jsWSci/4MTfqMJm026AWlUkon+q6gUaslUKfTBxdSc96fYdnbKXnWHLB
         t5ZA==
X-Gm-Message-State: AOAM533GE7VVay4bmJsDiZxPtkV4MNmzutJQUsTu0+1v2t6CzfiVExeX
        S6hPngGWq1/F1KRhRnN3+eygIcyPRVUakkHRsWLBDQLI4qj9ScyAypuDZmdf1TCur41nVEtfJKq
        dsjyebcV+UjBYPQl4+Ai38g==
X-Received: by 2002:aca:1809:: with SMTP id h9mr313937oih.4.1625856412474;
        Fri, 09 Jul 2021 11:46:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwT6Qkx17xOl0yMmkNwVOlw5rcnNBZ7ZjKZSODzgT5CEJC/DZwMvYGwmRnePz7tODl1Xst8Aw==
X-Received: by 2002:aca:1809:: with SMTP id h9mr313920oih.4.1625856412298;
        Fri, 09 Jul 2021 11:46:52 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id s8sm756129otp.37.2021.07.09.11.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 11:46:51 -0700 (PDT)
From:   trix@redhat.com
To:     mdf@kernel.org, corbet@lwn.net, hao.wu@intel.com
Cc:     linux-fpga@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Russ Weight <russell.h.weight@intel.com>,
        Tom Rix <trix@redhat.com>, Xu Yilun <yilun.xu@intel.com>
Subject: [RFC PATCH v10 3/3] fpga: region: Use standard dev_release for class driver
Date:   Fri,  9 Jul 2021 11:46:48 -0700
Message-Id: <20210709184648.2521926-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Russ Weight <russell.h.weight@intel.com>

The FPGA region class driver data structure is being treated as a
managed resource instead of using the standard dev_release call-back
function to release the class data structure. This change removes the
managed resource code and combines the create() and register()
functions into a single register() function.

The parameter 'void *priv' was added to register().

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Signed-off-by: Tom Rix <trix@redhat.com>
Reviewed-by: Xu Yilun <yilun.xu@intel.com>
---
 Documentation/driver-api/fpga/fpga-region.rst |   4 -
 drivers/fpga/dfl-fme-region.c                 |   7 +-
 drivers/fpga/dfl.c                            |  12 +-
 drivers/fpga/fpga-region.c                    | 108 +++++-------------
 drivers/fpga/of-fpga-region.c                 |  10 +-
 include/linux/fpga/fpga-region.h              |  12 +-
 6 files changed, 38 insertions(+), 115 deletions(-)

diff --git a/Documentation/driver-api/fpga/fpga-region.rst b/Documentation/driver-api/fpga/fpga-region.rst
index 2f621de51130d..572729e49ec02 100644
--- a/Documentation/driver-api/fpga/fpga-region.rst
+++ b/Documentation/driver-api/fpga/fpga-region.rst
@@ -47,7 +47,6 @@ API to add a new FPGA region
 
 * struct fpga_region — The FPGA region struct
 * struct fpga_region_ops —  Low level FPGA region driver ops
-* devm_fpga_region_create() — Allocate and init a region struct
 * fpga_region_register() —  Register an FPGA region
 * fpga_region_unregister() —  Unregister an FPGA region
 
@@ -79,9 +78,6 @@ following APIs to handle building or tearing down that list.
 .. kernel-doc:: include/linux/fpga/fpga-region.h
    :functions: fpga_region_ops
 
-.. kernel-doc:: drivers/fpga/fpga-region.c
-   :functions: devm_fpga_region_create
-
 .. kernel-doc:: drivers/fpga/fpga-region.c
    :functions: fpga_region_register
 
diff --git a/drivers/fpga/dfl-fme-region.c b/drivers/fpga/dfl-fme-region.c
index be1d57ee37666..13befbb4e1a6c 100644
--- a/drivers/fpga/dfl-fme-region.c
+++ b/drivers/fpga/dfl-fme-region.c
@@ -57,19 +57,14 @@ static int fme_region_probe(struct platform_device *pdev)
 	if (IS_ERR(mgr))
 		return -EPROBE_DEFER;
 
-	region = devm_fpga_region_create(dev, mgr, &fme_fpga_region_ops);
+	region = fpga_region_register(dev, mgr, &fme_fpga_region_ops, pdata);
 	if (!region) {
 		ret = -ENOMEM;
 		goto eprobe_mgr_put;
 	}
 
-	region->priv = pdata;
 	platform_set_drvdata(pdev, region);
 
-	ret = fpga_region_register(region);
-	if (ret)
-		goto eprobe_mgr_put;
-
 	dev_dbg(dev, "DFL FME FPGA Region probed\n");
 
 	return 0;
diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index 511b20ff35a33..6e628c07c1dc1 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -1400,19 +1400,15 @@ dfl_fpga_feature_devs_enumerate(struct dfl_fpga_enum_info *info)
 	if (!cdev)
 		return ERR_PTR(-ENOMEM);
 
-	cdev->region = devm_fpga_region_create(info->dev, NULL, NULL);
-	if (!cdev->region) {
-		ret = -ENOMEM;
-		goto free_cdev_exit;
-	}
-
 	cdev->parent = info->dev;
 	mutex_init(&cdev->lock);
 	INIT_LIST_HEAD(&cdev->port_dev_list);
 
-	ret = fpga_region_register(cdev->region);
-	if (ret)
+	cdev->region = fpga_region_register(info->dev, NULL, NULL, NULL);
+	if (IS_ERR(cdev->region)) {
+		ret = PTR_ERR(cdev->region);
 		goto free_cdev_exit;
+	}
 
 	/* create and init build info for enumeration */
 	binfo = devm_kzalloc(info->dev, sizeof(*binfo), GFP_KERNEL);
diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
index b08d3914716f0..6442e80480b43 100644
--- a/drivers/fpga/fpga-region.c
+++ b/drivers/fpga/fpga-region.c
@@ -184,39 +184,44 @@ static struct attribute *fpga_region_attrs[] = {
 ATTRIBUTE_GROUPS(fpga_region);
 
 /**
- * fpga_region_create - alloc and init a struct fpga_region
+ * fpga_region_register - create and register an FPGA Region device
  * @parent: device parent
  * @mgr: manager that programs this region
- * @rops:  optional pointer to struct for fpga region ops
+ * @rops: optional pointer to struct for fpga region ops
+ * @priv: fpga region private data
  *
  * The caller of this function is responsible for freeing the resulting region
- * struct with fpga_region_free().  Using devm_fpga_region_create() instead is
+ * struct with fpga_region_unregiser().  Using devm_fpga_region_create() instead is
  * recommended.
  *
- * Return: struct fpga_region or NULL
+ * Return: struct fpga_region or ERR_PTR()
  */
-struct fpga_region
-*fpga_region_create(struct device *parent,
-		    struct fpga_manager *mgr,
-		    const struct fpga_region_ops *rops)
+struct fpga_region *
+fpga_region_register(struct device *parent,
+		     struct fpga_manager *mgr,
+		     const struct fpga_region_ops *rops,
+		     void *priv)
 {
 	struct fpga_region *region;
 	int id, ret = 0;
 
 	region = kzalloc(sizeof(*region), GFP_KERNEL);
 	if (!region)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	id = ida_simple_get(&fpga_region_ida, 0, 0, GFP_KERNEL);
-	if (id < 0)
+	if (id < 0) {
+		ret = id;
 		goto err_free;
+	}
 
 	region->mgr = mgr;
 	region->rops = rops;
+	region->priv = priv;
+
 	mutex_init(&region->mutex);
 	INIT_LIST_HEAD(&region->bridge_list);
 
-	device_initialize(&region->dev);
 	region->dev.class = fpga_region_class;
 	region->dev.parent = parent;
 	region->dev.of_node = parent->of_node;
@@ -226,6 +231,12 @@ struct fpga_region
 	if (ret)
 		goto err_remove;
 
+	ret = device_register(&region->dev);
+	if (ret) {
+		put_device(&region->dev);
+		return ERR_PTR(ret);
+	}
+
 	return region;
 
 err_remove:
@@ -233,76 +244,7 @@ struct fpga_region
 err_free:
 	kfree(region);
 
-	return NULL;
-}
-EXPORT_SYMBOL_GPL(fpga_region_create);
-
-/**
- * fpga_region_free - free an FPGA region created by fpga_region_create()
- * @region: FPGA region
- */
-void fpga_region_free(struct fpga_region *region)
-{
-	ida_simple_remove(&fpga_region_ida, region->dev.id);
-	kfree(region);
-}
-EXPORT_SYMBOL_GPL(fpga_region_free);
-
-static void devm_fpga_region_release(struct device *dev, void *res)
-{
-	struct fpga_region *region = *(struct fpga_region **)res;
-
-	fpga_region_free(region);
-}
-
-/**
- * devm_fpga_region_create - create and initialize a managed FPGA region struct
- * @parent: device parent
- * @mgr: manager that programs this region
- * @rops:  optional pointer to struct for fpga region ops
- *
- * This function is intended for use in an FPGA region driver's probe function.
- * After the region driver creates the region struct with
- * devm_fpga_region_create(), it should register it with fpga_region_register().
- * The region driver's remove function should call fpga_region_unregister().
- * The region struct allocated with this function will be freed automatically on
- * driver detach.  This includes the case of a probe function returning error
- * before calling fpga_region_register(), the struct will still get cleaned up.
- *
- * Return: struct fpga_region or NULL
- */
-struct fpga_region
-*devm_fpga_region_create(struct device *parent,
-			 struct fpga_manager *mgr,
-			 const struct fpga_region_ops *rops)
-{
-	struct fpga_region **ptr, *region;
-
-	ptr = devres_alloc(devm_fpga_region_release, sizeof(*ptr), GFP_KERNEL);
-	if (!ptr)
-		return NULL;
-
-	region = fpga_region_create(parent, mgr, rops);
-	if (!region) {
-		devres_free(ptr);
-	} else {
-		*ptr = region;
-		devres_add(parent, ptr);
-	}
-
-	return region;
-}
-EXPORT_SYMBOL_GPL(devm_fpga_region_create);
-
-/**
- * fpga_region_register - register an FPGA region
- * @region: FPGA region
- *
- * Return: 0 or -errno
- */
-int fpga_region_register(struct fpga_region *region)
-{
-	return device_add(&region->dev);
+	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL_GPL(fpga_region_register);
 
@@ -320,6 +262,10 @@ EXPORT_SYMBOL_GPL(fpga_region_unregister);
 
 static void fpga_region_dev_release(struct device *dev)
 {
+	struct fpga_region *region = to_fpga_region(dev);
+
+	ida_simple_remove(&fpga_region_ida, region->dev.id);
+	kfree(region);
 }
 
 /**
diff --git a/drivers/fpga/of-fpga-region.c b/drivers/fpga/of-fpga-region.c
index 2c99605e008a6..bceb51b2476c6 100644
--- a/drivers/fpga/of-fpga-region.c
+++ b/drivers/fpga/of-fpga-region.c
@@ -409,16 +409,12 @@ static int of_fpga_region_probe(struct platform_device *pdev)
 	if (IS_ERR(mgr))
 		return -EPROBE_DEFER;
 
-	region = devm_fpga_region_create(dev, mgr, &of_fpga_region_ops);
-	if (!region) {
-		ret = -ENOMEM;
+	region = fpga_region_register(dev, mgr, &of_fpga_region_ops, NULL);
+	if (IS_ERR(region)) {
+		ret = PTR_ERR(region);
 		goto eprobe_mgr_put;
 	}
 
-	ret = fpga_region_register(region);
-	if (ret)
-		goto eprobe_mgr_put;
-
 	of_platform_populate(np, fpga_region_of_match, NULL, &region->dev);
 	platform_set_drvdata(pdev, region);
 
diff --git a/include/linux/fpga/fpga-region.h b/include/linux/fpga/fpga-region.h
index afc79784b2823..98f001625933f 100644
--- a/include/linux/fpga/fpga-region.h
+++ b/include/linux/fpga/fpga-region.h
@@ -51,15 +51,9 @@ struct fpga_region *fpga_region_class_find(
 
 int fpga_region_program_fpga(struct fpga_region *region);
 
-struct fpga_region
-*fpga_region_create(struct device *dev, struct fpga_manager *mgr,
-		    const struct fpga_region_ops *rops);
-void fpga_region_free(struct fpga_region *region);
-int fpga_region_register(struct fpga_region *region);
+struct fpga_region *
+fpga_region_register(struct device *parent, struct fpga_manager *mgr,
+		     const struct fpga_region_ops *rops, void *priv);
 void fpga_region_unregister(struct fpga_region *region);
 
-struct fpga_region
-*devm_fpga_region_create(struct device *dev, struct fpga_manager *mgr,
-			 const struct fpga_region_ops *rops);
-
 #endif /* _FPGA_REGION_H */
-- 
2.26.3


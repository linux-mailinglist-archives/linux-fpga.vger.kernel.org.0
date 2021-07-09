Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 010653C292D
	for <lists+linux-fpga@lfdr.de>; Fri,  9 Jul 2021 20:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbhGISsQ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 9 Jul 2021 14:48:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47401 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230129AbhGISsP (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 9 Jul 2021 14:48:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625856331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZE+8I+fCwfENmMykXhY87Q7jxn2ECw/J1dlCjcQ+Uls=;
        b=XSNF4NzvQdr7K4a68iCT+LGL37KFCUgqb7bD5LBNVbvTmHzSC72WTeD/ek+7tG2rnO9qN/
        cgvrRpA7t70IC5XoGqxCpV4+kjPw68XBhFjCu0vOSa3+b6I1DGLE6oveVkZuvxhjqnYL08
        sRwOHZz3burGuQXRABqFP1ttYnLB4KI=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-MMUAgg4ZMZqR8YC62QIUiw-1; Fri, 09 Jul 2021 14:45:30 -0400
X-MC-Unique: MMUAgg4ZMZqR8YC62QIUiw-1
Received: by mail-ot1-f71.google.com with SMTP id y59-20020a9d22c10000b0290451891192f0so6726313ota.1
        for <linux-fpga@vger.kernel.org>; Fri, 09 Jul 2021 11:45:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZE+8I+fCwfENmMykXhY87Q7jxn2ECw/J1dlCjcQ+Uls=;
        b=juD4bOw48Y2Vk+XehPwHZbivmlye6kHdC0+ZVMKoPacaN3YOqXMXgPue4kQkC7ZGel
         k6m/3ZfteQk32ON2qjTgxd1Vp9+hUI6k+Ng2twVxWkCIjqqJT57/SB1MX6nQsn5HpN/f
         NiY+GdwfqFDz8UZl9tcfCnjb+g1W7uil+IK81uSa/+N0rIMDKzChHzmvqpY3NQq7oVb6
         YkyXT5Wng2uMWkjuP6b6hhT/BGnuXSFxFFDhhukIL2mo1wmLAPS0WaN1hbThkhd3greZ
         gyMv5myegsEqRquXu6DsnvwIDIl7iuY53xwYNKpDFRpF1YUJeiU98Qgr7hmzOQ5uGHQU
         KfVg==
X-Gm-Message-State: AOAM532tTYPfdwzAZrcbu+s7qbM6B/wxLJtKfq4VK8zZXnslhlExJ+jO
        H7pEwU4Zq+zpWg9CQ0exzAEhZmYUAWTB3fTeDf5vx5VSj2q9hiKd7ba8FQP4ay0S8i5dp22Wuj+
        uJXjShpopNXcJG9kXCc89UQ==
X-Received: by 2002:a05:6830:24a6:: with SMTP id v6mr27364616ots.116.1625856327905;
        Fri, 09 Jul 2021 11:45:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwdRIyXJ2DESf9uOweCiMLi6c6iJom9u6aaW6CW/mSaNlMzgsZYVjyiKhROcO4KzpqR3nXyEw==
X-Received: by 2002:a05:6830:24a6:: with SMTP id v6mr27364558ots.116.1625856326800;
        Fri, 09 Jul 2021 11:45:26 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id a44sm1145482ooj.12.2021.07.09.11.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 11:45:26 -0700 (PDT)
From:   trix@redhat.com
To:     mdf@kernel.org, corbet@lwn.net, hao.wu@intel.com,
        michal.simek@xilinx.com
Cc:     linux-fpga@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Russ Weight <russell.h.weight@intel.com>,
        Tom Rix <trix@redhat.com>, Xu Yilun <yilun.xu@intel.com>
Subject: [RFC PATCH v10 1/3] fpga: mgr: Use standard dev_release for class driver
Date:   Fri,  9 Jul 2021 11:45:09 -0700
Message-Id: <20210709184511.2521508-3-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210709184511.2521508-1-trix@redhat.com>
References: <20210709184511.2521508-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Russ Weight <russell.h.weight@intel.com>

The FPGA manager class driver data structure is being treated as a
managed resource instead of using the standard dev_release call-back
function to release the class data structure. This change removes
the managed resource code for the freeing of the class data structure
and combines the create() and register() functions into a single
register() function.

The devm_fpga_mgr_register() function is retained

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Signed-off-by: Tom Rix <trix@redhat.com>
Reviewed-by: Xu Yilun <yilun.xu@intel.com>
---
 Documentation/driver-api/fpga/fpga-mgr.rst |  23 +--
 drivers/fpga/altera-cvp.c                  |  12 +-
 drivers/fpga/altera-pr-ip-core.c           |   7 +-
 drivers/fpga/altera-ps-spi.c               |   9 +-
 drivers/fpga/dfl-fme-mgr.c                 |  10 +-
 drivers/fpga/fpga-mgr.c                    | 166 ++++++---------------
 drivers/fpga/ice40-spi.c                   |   9 +-
 drivers/fpga/machxo2-spi.c                 |   9 +-
 drivers/fpga/socfpga-a10.c                 |  16 +-
 drivers/fpga/socfpga.c                     |   9 +-
 drivers/fpga/stratix10-soc.c               |  16 +-
 drivers/fpga/ts73xx-fpga.c                 |   9 +-
 drivers/fpga/xilinx-spi.c                  |  11 +-
 drivers/fpga/zynq-fpga.c                   |  16 +-
 drivers/fpga/zynqmp-fpga.c                 |   9 +-
 include/linux/fpga/fpga-mgr.h              |  16 +-
 16 files changed, 111 insertions(+), 236 deletions(-)

diff --git a/Documentation/driver-api/fpga/fpga-mgr.rst b/Documentation/driver-api/fpga/fpga-mgr.rst
index 917ee22db429d..86488aa9391a5 100644
--- a/Documentation/driver-api/fpga/fpga-mgr.rst
+++ b/Documentation/driver-api/fpga/fpga-mgr.rst
@@ -49,14 +49,14 @@ probe function calls fpga_mgr_register(), such as::
 		 * them in priv
 		 */
 
-		mgr = devm_fpga_mgr_create(dev, "Altera SOCFPGA FPGA Manager",
-					   &socfpga_fpga_ops, priv);
-		if (!mgr)
-			return -ENOMEM;
+		mgr = fpga_mgr_register(dev, "Altera SOCFPGA FPGA Manager",
+					&socfpga_fpga_ops, priv);
+		if (IS_ERR(mgr))
+			return PTR_ERR(mgr);
 
 		platform_set_drvdata(pdev, mgr);
 
-		return fpga_mgr_register(mgr);
+		return 0;
 	}
 
 	static int socfpga_fpga_remove(struct platform_device *pdev)
@@ -68,6 +68,11 @@ probe function calls fpga_mgr_register(), such as::
 		return 0;
 	}
 
+Alternatively, the probe function could call the resource managed register
+functions devm_fpga_mgr_register(). When these functions are used, the
+parameter syntax is the same, but the call to fpga_mgr_unregister() should
+be removed. In the above example, the socfpga_fpga_remove() function would
+not be required.
 
 The ops will implement whatever device specific register writes are needed to
 do the programming sequence for this particular FPGA.  These ops return 0 for
@@ -104,8 +109,8 @@ API for implementing a new FPGA Manager driver
 * ``fpga_mgr_states`` —  Values for :c:expr:`fpga_manager->state`.
 * struct fpga_manager —  the FPGA manager struct
 * struct fpga_manager_ops —  Low level FPGA manager driver ops
-* devm_fpga_mgr_create() —  Allocate and init a manager struct
-* fpga_mgr_register() —  Register an FPGA manager
+* fpga_mgr_register() —  Create and register an FPGA manager
+* devm_fpga_mgr_register() —  Resource managed version of fpga_mgr_register()
 * fpga_mgr_unregister() —  Unregister an FPGA manager
 
 .. kernel-doc:: include/linux/fpga/fpga-mgr.h
@@ -118,10 +123,10 @@ API for implementing a new FPGA Manager driver
    :functions: fpga_manager_ops
 
 .. kernel-doc:: drivers/fpga/fpga-mgr.c
-   :functions: devm_fpga_mgr_create
+   :functions: fpga_mgr_register
 
 .. kernel-doc:: drivers/fpga/fpga-mgr.c
-   :functions: fpga_mgr_register
+   :functions: devm_fpga_mgr_register
 
 .. kernel-doc:: drivers/fpga/fpga-mgr.c
    :functions: fpga_mgr_unregister
diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
index 4e0edb60bfba6..b61020ceb0a1e 100644
--- a/drivers/fpga/altera-cvp.c
+++ b/drivers/fpga/altera-cvp.c
@@ -652,19 +652,15 @@ static int altera_cvp_probe(struct pci_dev *pdev,
 	snprintf(conf->mgr_name, sizeof(conf->mgr_name), "%s @%s",
 		 ALTERA_CVP_MGR_NAME, pci_name(pdev));
 
-	mgr = devm_fpga_mgr_create(&pdev->dev, conf->mgr_name,
-				   &altera_cvp_ops, conf);
-	if (!mgr) {
-		ret = -ENOMEM;
+	mgr = fpga_mgr_register(&pdev->dev, conf->mgr_name,
+				&altera_cvp_ops, conf);
+	if (IS_ERR(mgr)) {
+		ret = PTR_ERR(mgr);
 		goto err_unmap;
 	}
 
 	pci_set_drvdata(pdev, mgr);
 
-	ret = fpga_mgr_register(mgr);
-	if (ret)
-		goto err_unmap;
-
 	return 0;
 
 err_unmap:
diff --git a/drivers/fpga/altera-pr-ip-core.c b/drivers/fpga/altera-pr-ip-core.c
index dfdf21ed34c4e..be0667968d33b 100644
--- a/drivers/fpga/altera-pr-ip-core.c
+++ b/drivers/fpga/altera-pr-ip-core.c
@@ -191,11 +191,8 @@ int alt_pr_register(struct device *dev, void __iomem *reg_base)
 		(val & ALT_PR_CSR_STATUS_MSK) >> ALT_PR_CSR_STATUS_SFT,
 		(int)(val & ALT_PR_CSR_PR_START));
 
-	mgr = devm_fpga_mgr_create(dev, dev_name(dev), &alt_pr_ops, priv);
-	if (!mgr)
-		return -ENOMEM;
-
-	return devm_fpga_mgr_register(dev, mgr);
+	mgr = devm_fpga_mgr_register(dev, dev_name(dev), &alt_pr_ops, priv);
+	return PTR_ERR_OR_ZERO(mgr);
 }
 EXPORT_SYMBOL_GPL(alt_pr_register);
 
diff --git a/drivers/fpga/altera-ps-spi.c b/drivers/fpga/altera-ps-spi.c
index 23bfd4d1ad0f7..5e1e009dba896 100644
--- a/drivers/fpga/altera-ps-spi.c
+++ b/drivers/fpga/altera-ps-spi.c
@@ -302,12 +302,9 @@ static int altera_ps_probe(struct spi_device *spi)
 	snprintf(conf->mgr_name, sizeof(conf->mgr_name), "%s %s",
 		 dev_driver_string(&spi->dev), dev_name(&spi->dev));
 
-	mgr = devm_fpga_mgr_create(&spi->dev, conf->mgr_name,
-				   &altera_ps_ops, conf);
-	if (!mgr)
-		return -ENOMEM;
-
-	return devm_fpga_mgr_register(&spi->dev, mgr);
+	mgr = devm_fpga_mgr_register(&spi->dev, conf->mgr_name,
+				     &altera_ps_ops, conf);
+	return PTR_ERR_OR_ZERO(mgr);
 }
 
 static const struct spi_device_id altera_ps_spi_ids[] = {
diff --git a/drivers/fpga/dfl-fme-mgr.c b/drivers/fpga/dfl-fme-mgr.c
index 8c5423eeffe75..da509c4c029f6 100644
--- a/drivers/fpga/dfl-fme-mgr.c
+++ b/drivers/fpga/dfl-fme-mgr.c
@@ -313,12 +313,12 @@ static int fme_mgr_probe(struct platform_device *pdev)
 
 	_fme_mgr_get_compat_id(priv->ioaddr, &priv->compat_id);
 
-	mgr = devm_fpga_mgr_create(dev, "DFL FME FPGA Manager",
-				   &fme_mgr_ops, priv);
-	if (!mgr)
-		return -ENOMEM;
+	mgr = devm_fpga_mgr_register(dev, "DFL FME FPGA Manager",
+				     &fme_mgr_ops, priv);
+	if (IS_ERR(mgr))
+		return PTR_ERR(mgr);
 
-	return devm_fpga_mgr_register(dev, mgr);
+	return 0;
 }
 
 static struct platform_driver fme_mgr_driver = {
diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index ecb4c3c795fa5..e240a23df79ff 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -550,20 +550,20 @@ void fpga_mgr_unlock(struct fpga_manager *mgr)
 EXPORT_SYMBOL_GPL(fpga_mgr_unlock);
 
 /**
- * fpga_mgr_create - create and initialize an FPGA manager struct
+ * fpga_mgr_register - create and register an FPGA Manager device
  * @parent:	fpga manager device from pdev
  * @name:	fpga manager name
  * @mops:	pointer to structure of fpga manager ops
  * @priv:	fpga manager private data
  *
- * The caller of this function is responsible for freeing the struct with
- * fpga_mgr_free().  Using devm_fpga_mgr_create() instead is recommended.
+ * The caller of this function is responsible for calling fpga_mgr_unregister().
+ * Using devm_fpga_mgr_register() instead is recommended.
  *
- * Return: pointer to struct fpga_manager or NULL
+ * Return: pointer to struct fpga_manager pointer or ERR_PTR()
  */
-struct fpga_manager *fpga_mgr_create(struct device *parent, const char *name,
-				     const struct fpga_manager_ops *mops,
-				     void *priv)
+struct fpga_manager *
+fpga_mgr_register(struct device *parent, const char *name,
+		  const struct fpga_manager_ops *mops, void *priv)
 {
 	struct fpga_manager *mgr;
 	int id, ret;
@@ -572,21 +572,23 @@ struct fpga_manager *fpga_mgr_create(struct device *parent, const char *name,
 	    !mops->write_init || (!mops->write && !mops->write_sg) ||
 	    (mops->write && mops->write_sg)) {
 		dev_err(parent, "Attempt to register without fpga_manager_ops\n");
-		return NULL;
+		return ERR_PTR(-EINVAL);
 	}
 
 	if (!name || !strlen(name)) {
 		dev_err(parent, "Attempt to register with no name!\n");
-		return NULL;
+		return ERR_PTR(-EINVAL);
 	}
 
 	mgr = kzalloc(sizeof(*mgr), GFP_KERNEL);
 	if (!mgr)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	id = ida_simple_get(&fpga_mgr_ida, 0, 0, GFP_KERNEL);
-	if (id < 0)
+	if (id < 0) {
+		ret = id;
 		goto error_kfree;
+	}
 
 	mutex_init(&mgr->ref_mutex);
 
@@ -594,7 +596,6 @@ struct fpga_manager *fpga_mgr_create(struct device *parent, const char *name,
 	mgr->mops = mops;
 	mgr->priv = priv;
 
-	device_initialize(&mgr->dev);
 	mgr->dev.class = fpga_mgr_class;
 	mgr->dev.groups = mops->groups;
 	mgr->dev.parent = parent;
@@ -605,84 +606,6 @@ struct fpga_manager *fpga_mgr_create(struct device *parent, const char *name,
 	if (ret)
 		goto error_device;
 
-	return mgr;
-
-error_device:
-	ida_simple_remove(&fpga_mgr_ida, id);
-error_kfree:
-	kfree(mgr);
-
-	return NULL;
-}
-EXPORT_SYMBOL_GPL(fpga_mgr_create);
-
-/**
- * fpga_mgr_free - free an FPGA manager created with fpga_mgr_create()
- * @mgr:	fpga manager struct
- */
-void fpga_mgr_free(struct fpga_manager *mgr)
-{
-	ida_simple_remove(&fpga_mgr_ida, mgr->dev.id);
-	kfree(mgr);
-}
-EXPORT_SYMBOL_GPL(fpga_mgr_free);
-
-static void devm_fpga_mgr_release(struct device *dev, void *res)
-{
-	struct fpga_mgr_devres *dr = res;
-
-	fpga_mgr_free(dr->mgr);
-}
-
-/**
- * devm_fpga_mgr_create - create and initialize a managed FPGA manager struct
- * @parent:	fpga manager device from pdev
- * @name:	fpga manager name
- * @mops:	pointer to structure of fpga manager ops
- * @priv:	fpga manager private data
- *
- * This function is intended for use in an FPGA manager driver's probe function.
- * After the manager driver creates the manager struct with
- * devm_fpga_mgr_create(), it should register it with fpga_mgr_register().  The
- * manager driver's remove function should call fpga_mgr_unregister().  The
- * manager struct allocated with this function will be freed automatically on
- * driver detach.  This includes the case of a probe function returning error
- * before calling fpga_mgr_register(), the struct will still get cleaned up.
- *
- * Return: pointer to struct fpga_manager or NULL
- */
-struct fpga_manager *devm_fpga_mgr_create(struct device *parent, const char *name,
-					  const struct fpga_manager_ops *mops,
-					  void *priv)
-{
-	struct fpga_mgr_devres *dr;
-
-	dr = devres_alloc(devm_fpga_mgr_release, sizeof(*dr), GFP_KERNEL);
-	if (!dr)
-		return NULL;
-
-	dr->mgr = fpga_mgr_create(parent, name, mops, priv);
-	if (!dr->mgr) {
-		devres_free(dr);
-		return NULL;
-	}
-
-	devres_add(parent, dr);
-
-	return dr->mgr;
-}
-EXPORT_SYMBOL_GPL(devm_fpga_mgr_create);
-
-/**
- * fpga_mgr_register - register an FPGA manager
- * @mgr: fpga manager struct
- *
- * Return: 0 on success, negative error code otherwise.
- */
-int fpga_mgr_register(struct fpga_manager *mgr)
-{
-	int ret;
-
 	/*
 	 * Initialize framework state by requesting low level driver read state
 	 * from device.  FPGA may be in reset mode or may have been programmed
@@ -690,18 +613,20 @@ int fpga_mgr_register(struct fpga_manager *mgr)
 	 */
 	mgr->state = mgr->mops->state(mgr);
 
-	ret = device_add(&mgr->dev);
-	if (ret)
-		goto error_device;
-
-	dev_info(&mgr->dev, "%s registered\n", mgr->name);
+	ret = device_register(&mgr->dev);
+	if (ret) {
+		put_device(&mgr->dev);
+		return ERR_PTR(ret);
+	}
 
-	return 0;
+	return mgr;
 
 error_device:
-	ida_simple_remove(&fpga_mgr_ida, mgr->dev.id);
+	ida_simple_remove(&fpga_mgr_ida, id);
+error_kfree:
+	kfree(mgr);
 
-	return ret;
+	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL_GPL(fpga_mgr_register);
 
@@ -726,14 +651,6 @@ void fpga_mgr_unregister(struct fpga_manager *mgr)
 }
 EXPORT_SYMBOL_GPL(fpga_mgr_unregister);
 
-static int fpga_mgr_devres_match(struct device *dev, void *res,
-				 void *match_data)
-{
-	struct fpga_mgr_devres *dr = res;
-
-	return match_data == dr->mgr;
-}
-
 static void devm_fpga_mgr_unregister(struct device *dev, void *res)
 {
 	struct fpga_mgr_devres *dr = res;
@@ -743,44 +660,45 @@ static void devm_fpga_mgr_unregister(struct device *dev, void *res)
 
 /**
  * devm_fpga_mgr_register - resource managed variant of fpga_mgr_register()
- * @dev: managing device for this FPGA manager
- * @mgr: fpga manager struct
+ * @parent: fpga manager device from pdev
+ * @info: parameters for fpga manager
+ * @name: fpga manager name
+ * @mops: pointer to structure of fpga manager ops
+ * @priv: fpga manager private data
  *
  * This is the devres variant of fpga_mgr_register() for which the unregister
  * function will be called automatically when the managing device is detached.
  */
-int devm_fpga_mgr_register(struct device *dev, struct fpga_manager *mgr)
+struct fpga_manager *
+devm_fpga_mgr_register(struct device *parent, const char *name,
+		       const struct fpga_manager_ops *mops, void *priv)
 {
 	struct fpga_mgr_devres *dr;
-	int ret;
-
-	/*
-	 * Make sure that the struct fpga_manager * that is passed in is
-	 * managed itself.
-	 */
-	if (WARN_ON(!devres_find(dev, devm_fpga_mgr_release,
-				 fpga_mgr_devres_match, mgr)))
-		return -EINVAL;
+	struct fpga_manager *mgr;
 
 	dr = devres_alloc(devm_fpga_mgr_unregister, sizeof(*dr), GFP_KERNEL);
 	if (!dr)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
-	ret = fpga_mgr_register(mgr);
-	if (ret) {
+	mgr = fpga_mgr_register(parent, name, mops, priv);
+	if (IS_ERR(mgr)) {
 		devres_free(dr);
-		return ret;
+		return mgr;
 	}
 
 	dr->mgr = mgr;
-	devres_add(dev, dr);
+	devres_add(parent, dr);
 
-	return 0;
+	return mgr;
 }
 EXPORT_SYMBOL_GPL(devm_fpga_mgr_register);
 
 static void fpga_mgr_dev_release(struct device *dev)
 {
+	struct fpga_manager *mgr = to_fpga_manager(dev);
+
+	ida_simple_remove(&fpga_mgr_ida, mgr->dev.id);
+	kfree(mgr);
 }
 
 static int __init fpga_mgr_class_init(void)
diff --git a/drivers/fpga/ice40-spi.c b/drivers/fpga/ice40-spi.c
index 69dec5af23c36..b7591912248fc 100644
--- a/drivers/fpga/ice40-spi.c
+++ b/drivers/fpga/ice40-spi.c
@@ -178,12 +178,9 @@ static int ice40_fpga_probe(struct spi_device *spi)
 		return ret;
 	}
 
-	mgr = devm_fpga_mgr_create(dev, "Lattice iCE40 FPGA Manager",
-				   &ice40_fpga_ops, priv);
-	if (!mgr)
-		return -ENOMEM;
-
-	return devm_fpga_mgr_register(dev, mgr);
+	mgr = devm_fpga_mgr_register(dev, "Lattice iCE40 FPGA Manager",
+				     &ice40_fpga_ops, priv);
+	return PTR_ERR_OR_ZERO(mgr);
 }
 
 static const struct of_device_id ice40_fpga_of_match[] = {
diff --git a/drivers/fpga/machxo2-spi.c b/drivers/fpga/machxo2-spi.c
index 1afb41aa20d71..8469dfb5dd219 100644
--- a/drivers/fpga/machxo2-spi.c
+++ b/drivers/fpga/machxo2-spi.c
@@ -366,12 +366,9 @@ static int machxo2_spi_probe(struct spi_device *spi)
 		return -EINVAL;
 	}
 
-	mgr = devm_fpga_mgr_create(dev, "Lattice MachXO2 SPI FPGA Manager",
-				   &machxo2_ops, spi);
-	if (!mgr)
-		return -ENOMEM;
-
-	return devm_fpga_mgr_register(dev, mgr);
+	mgr = devm_fpga_mgr_register(dev, "Lattice MachXO2 SPI FPGA Manager",
+				     &machxo2_ops, spi);
+	return PTR_ERR_OR_ZERO(mgr);
 }
 
 #ifdef CONFIG_OF
diff --git a/drivers/fpga/socfpga-a10.c b/drivers/fpga/socfpga-a10.c
index 573d88bdf7307..ac8e89b8a5cc9 100644
--- a/drivers/fpga/socfpga-a10.c
+++ b/drivers/fpga/socfpga-a10.c
@@ -508,19 +508,15 @@ static int socfpga_a10_fpga_probe(struct platform_device *pdev)
 		return -EBUSY;
 	}
 
-	mgr = devm_fpga_mgr_create(dev, "SoCFPGA Arria10 FPGA Manager",
-				   &socfpga_a10_fpga_mgr_ops, priv);
-	if (!mgr)
-		return -ENOMEM;
-
-	platform_set_drvdata(pdev, mgr);
-
-	ret = fpga_mgr_register(mgr);
-	if (ret) {
+	mgr = fpga_mgr_register(dev, "SoCFPGA Arria10 FPGA Manager",
+				&socfpga_a10_fpga_mgr_ops, priv);
+	if (IS_ERR(mgr)) {
 		clk_disable_unprepare(priv->clk);
-		return ret;
+		return PTR_ERR(mgr);
 	}
 
+	platform_set_drvdata(pdev, mgr);
+
 	return 0;
 }
 
diff --git a/drivers/fpga/socfpga.c b/drivers/fpga/socfpga.c
index 1f467173fc1f3..7e0741f996968 100644
--- a/drivers/fpga/socfpga.c
+++ b/drivers/fpga/socfpga.c
@@ -571,12 +571,9 @@ static int socfpga_fpga_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	mgr = devm_fpga_mgr_create(dev, "Altera SOCFPGA FPGA Manager",
-				   &socfpga_fpga_ops, priv);
-	if (!mgr)
-		return -ENOMEM;
-
-	return devm_fpga_mgr_register(dev, mgr);
+	mgr = devm_fpga_mgr_register(dev, "Altera SOCFPGA FPGA Manager",
+				     &socfpga_fpga_ops, priv);
+	return PTR_ERR_OR_ZERO(mgr);
 }
 
 #ifdef CONFIG_OF
diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
index a2cea500f7cc6..9155e888a133e 100644
--- a/drivers/fpga/stratix10-soc.c
+++ b/drivers/fpga/stratix10-soc.c
@@ -425,18 +425,11 @@ static int s10_probe(struct platform_device *pdev)
 
 	init_completion(&priv->status_return_completion);
 
-	mgr = fpga_mgr_create(dev, "Stratix10 SOC FPGA Manager",
-			      &s10_ops, priv);
-	if (!mgr) {
-		dev_err(dev, "unable to create FPGA manager\n");
-		ret = -ENOMEM;
-		goto probe_err;
-	}
-
-	ret = fpga_mgr_register(mgr);
-	if (ret) {
+	mgr = fpga_mgr_register(dev, "Stratix10 SOC FPGA Manager",
+				&s10_ops, priv);
+	if (IS_ERR(mgr)) {
 		dev_err(dev, "unable to register FPGA manager\n");
-		fpga_mgr_free(mgr);
+		ret = PTR_ERR(mgr);
 		goto probe_err;
 	}
 
@@ -454,7 +447,6 @@ static int s10_remove(struct platform_device *pdev)
 	struct s10_priv *priv = mgr->priv;
 
 	fpga_mgr_unregister(mgr);
-	fpga_mgr_free(mgr);
 	stratix10_svc_free_channel(priv->chan);
 
 	return 0;
diff --git a/drivers/fpga/ts73xx-fpga.c b/drivers/fpga/ts73xx-fpga.c
index 101f016c6ed8c..fd52de20ddb2b 100644
--- a/drivers/fpga/ts73xx-fpga.c
+++ b/drivers/fpga/ts73xx-fpga.c
@@ -122,12 +122,9 @@ static int ts73xx_fpga_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->io_base))
 		return PTR_ERR(priv->io_base);
 
-	mgr = devm_fpga_mgr_create(kdev, "TS-73xx FPGA Manager",
-				   &ts73xx_fpga_ops, priv);
-	if (!mgr)
-		return -ENOMEM;
-
-	return devm_fpga_mgr_register(kdev, mgr);
+	mgr = devm_fpga_mgr_register(kdev, "TS-73xx FPGA Manager",
+				     &ts73xx_fpga_ops, priv);
+	return PTR_ERR_OR_ZERO(mgr);
 }
 
 static struct platform_driver ts73xx_fpga_driver = {
diff --git a/drivers/fpga/xilinx-spi.c b/drivers/fpga/xilinx-spi.c
index fee4d0abf6bfe..db23626f9ab27 100644
--- a/drivers/fpga/xilinx-spi.c
+++ b/drivers/fpga/xilinx-spi.c
@@ -247,13 +247,10 @@ static int xilinx_spi_probe(struct spi_device *spi)
 		return dev_err_probe(&spi->dev, PTR_ERR(conf->done),
 				     "Failed to get DONE gpio\n");
 
-	mgr = devm_fpga_mgr_create(&spi->dev,
-				   "Xilinx Slave Serial FPGA Manager",
-				   &xilinx_spi_ops, conf);
-	if (!mgr)
-		return -ENOMEM;
-
-	return devm_fpga_mgr_register(&spi->dev, mgr);
+	mgr = devm_fpga_mgr_register(&spi->dev,
+				     "Xilinx Slave Serial FPGA Manager",
+				     &xilinx_spi_ops, conf);
+	return PTR_ERR_OR_ZERO(mgr);
 }
 
 static const struct of_device_id xlnx_spi_of_match[] = {
diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
index 07fa8d9ec6750..74bbb9710f4ee 100644
--- a/drivers/fpga/zynq-fpga.c
+++ b/drivers/fpga/zynq-fpga.c
@@ -609,20 +609,16 @@ static int zynq_fpga_probe(struct platform_device *pdev)
 
 	clk_disable(priv->clk);
 
-	mgr = devm_fpga_mgr_create(dev, "Xilinx Zynq FPGA Manager",
-				   &zynq_fpga_ops, priv);
-	if (!mgr)
-		return -ENOMEM;
-
-	platform_set_drvdata(pdev, mgr);
-
-	err = fpga_mgr_register(mgr);
-	if (err) {
+	mgr = fpga_mgr_register(dev, "Xilinx Zynq FPGA Manager",
+				&zynq_fpga_ops, priv);
+	if (IS_ERR(mgr)) {
 		dev_err(dev, "unable to register FPGA manager\n");
 		clk_unprepare(priv->clk);
-		return err;
+		return PTR_ERR(mgr);
 	}
 
+	platform_set_drvdata(pdev, mgr);
+
 	return 0;
 }
 
diff --git a/drivers/fpga/zynqmp-fpga.c b/drivers/fpga/zynqmp-fpga.c
index 125743c9797ff..975bdc4d0a65e 100644
--- a/drivers/fpga/zynqmp-fpga.c
+++ b/drivers/fpga/zynqmp-fpga.c
@@ -102,12 +102,9 @@ static int zynqmp_fpga_probe(struct platform_device *pdev)
 
 	priv->dev = dev;
 
-	mgr = devm_fpga_mgr_create(dev, "Xilinx ZynqMP FPGA Manager",
-				   &zynqmp_fpga_ops, priv);
-	if (!mgr)
-		return -ENOMEM;
-
-	return devm_fpga_mgr_register(dev, mgr);
+	mgr = devm_fpga_mgr_register(dev, "Xilinx ZynqMP FPGA Manager",
+				     &zynqmp_fpga_ops, priv);
+	return PTR_ERR_OR_ZERO(mgr);
 }
 
 static const struct of_device_id zynqmp_fpga_of_match[] = {
diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
index ebdea215a8643..cd852d4e17839 100644
--- a/include/linux/fpga/fpga-mgr.h
+++ b/include/linux/fpga/fpga-mgr.h
@@ -178,17 +178,13 @@ struct fpga_manager *fpga_mgr_get(struct device *dev);
 
 void fpga_mgr_put(struct fpga_manager *mgr);
 
-struct fpga_manager *fpga_mgr_create(struct device *dev, const char *name,
-				     const struct fpga_manager_ops *mops,
-				     void *priv);
-void fpga_mgr_free(struct fpga_manager *mgr);
-int fpga_mgr_register(struct fpga_manager *mgr);
+struct fpga_manager *
+fpga_mgr_register(struct device *parent, const char *name,
+		  const struct fpga_manager_ops *mops, void *priv);
 void fpga_mgr_unregister(struct fpga_manager *mgr);
 
-int devm_fpga_mgr_register(struct device *dev, struct fpga_manager *mgr);
-
-struct fpga_manager *devm_fpga_mgr_create(struct device *dev, const char *name,
-					  const struct fpga_manager_ops *mops,
-					  void *priv);
+struct fpga_manager *
+devm_fpga_mgr_register(struct device *parent, const char *name,
+		       const struct fpga_manager_ops *mops, void *priv);
 
 #endif /*_LINUX_FPGA_MGR_H */
-- 
2.26.3


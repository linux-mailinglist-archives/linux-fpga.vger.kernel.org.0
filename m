Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3C03C2931
	for <lists+linux-fpga@lfdr.de>; Fri,  9 Jul 2021 20:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbhGIStU (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 9 Jul 2021 14:49:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32417 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229506AbhGIStT (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 9 Jul 2021 14:49:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625856395;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=zs305fSgOIpwBUwyxoV06D5N+pPR0pzJgrOMpwSsZcQ=;
        b=JkoLZLE6vv/TFAzDrlxdoTOwoLwrPL8Gu+JPPXQJQJ9Ym9GNzuaHjEEr0Dhp48HPYQKKFh
        aNkoCBp5xQ584XJxF0CMGgIYe056faN4sLQPby8bitj9iHVB/fASAAJK42G4P6L0GDSmOV
        4sWqiu72MQSnRXfvYmPWbvk42OMZjVM=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-126-_-Mf8BOqOiWXy5014VYiFw-1; Fri, 09 Jul 2021 14:46:34 -0400
X-MC-Unique: _-Mf8BOqOiWXy5014VYiFw-1
Received: by mail-oo1-f70.google.com with SMTP id d12-20020a4aeb8c0000b029023bbaaddcbbso6047414ooj.13
        for <linux-fpga@vger.kernel.org>; Fri, 09 Jul 2021 11:46:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zs305fSgOIpwBUwyxoV06D5N+pPR0pzJgrOMpwSsZcQ=;
        b=SnUMZ93eiWlZhTATGIRusKs91XklqvwZ1wMlnMwki7CyWyYeUgls0KBKx6Ex1swGkd
         izwd3f4P4fMhUjx2IpWIf7hW7M6H9z3ND4UhRZikMVHCUjtgbhSVFAdE39CmEkcXpgsX
         f1OGcYQ9XN1BsNPZOOAsBh6GHh1fM/2aF+g9EQRRe8ClI8Mo497dxtmDcF/sgleDtzip
         ytodhh8jIp5hkNk5iq+yJMMzNdaH9f1huQgK+1IZyoHzEPbW2P9huFh2hz+6HZsHMXyB
         U5aKwqrIGrA+XYqWH+Ib/f5gOEpiwEWLjzh7v+yK13Na3/OUjObkPIsPBZqnhjXbhMed
         TNJA==
X-Gm-Message-State: AOAM530L4+BtCuhxWVeZUD5knwivxvkqk8/x6f2XpnIR3rzZUlFbu8Py
        GCVcpGRBp0yALVYh9D5HEy7iJxbaXuaHPmVTL1McV2MYixvMPVkULgnhnk9Na5AfaUSqrXNCDTV
        F7e4NaZj9f2OUnu86jyWj/A==
X-Received: by 2002:aca:ac56:: with SMTP id v83mr24688247oie.178.1625856393899;
        Fri, 09 Jul 2021 11:46:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyQoY3lLhGCPXuBrfIZlHf4LBNGDrj5opH2RMTGDYa5nR+h1WiTlX/2LBWkFQaE+45NVvAnkQ==
X-Received: by 2002:aca:ac56:: with SMTP id v83mr24688220oie.178.1625856393658;
        Fri, 09 Jul 2021 11:46:33 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id l8sm1365245otk.81.2021.07.09.11.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 11:46:33 -0700 (PDT)
From:   trix@redhat.com
To:     mdf@kernel.org, corbet@lwn.net, hao.wu@intel.com,
        michal.simek@xilinx.com
Cc:     linux-fpga@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Russ Weight <russell.h.weight@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
Subject: [RFC PATCH v10 2/3] fpga: bridge: Use standard dev_release for class driver
Date:   Fri,  9 Jul 2021 11:46:24 -0700
Message-Id: <20210709184624.2521751-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Russ Weight <russell.h.weight@intel.com>

The FPGA bridge class driver data structure is being treated as a
managed resource instead of using the standard dev_release call-back
function to release the class data structure. This change removes
the managed resource code and combines the create() and register()
functions into a single register() function.

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Reviewed-by: Xu Yilun <yilun.xu@intel.com>
Reviewed-by: Tom Rix <trix@redhat.com>
---
 Documentation/driver-api/fpga/fpga-bridge.rst |  12 +-
 drivers/fpga/altera-fpga2sdram.c              |  12 +-
 drivers/fpga/altera-freeze-bridge.c           |  10 +-
 drivers/fpga/altera-hps2fpga.c                |  12 +-
 drivers/fpga/dfl-fme-br.c                     |  10 +-
 drivers/fpga/fpga-bridge.c                    | 122 ++++--------------
 drivers/fpga/xilinx-pr-decoupler.c            |  17 +--
 include/linux/fpga/fpga-bridge.h              |  30 +++--
 8 files changed, 77 insertions(+), 148 deletions(-)

diff --git a/Documentation/driver-api/fpga/fpga-bridge.rst b/Documentation/driver-api/fpga/fpga-bridge.rst
index 198aadafd3e7d..6042085340953 100644
--- a/Documentation/driver-api/fpga/fpga-bridge.rst
+++ b/Documentation/driver-api/fpga/fpga-bridge.rst
@@ -4,11 +4,10 @@ FPGA Bridge
 API to implement a new FPGA bridge
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-* struct fpga_bridge — The FPGA Bridge structure
-* struct fpga_bridge_ops — Low level Bridge driver ops
-* devm_fpga_bridge_create() — Allocate and init a bridge struct
-* fpga_bridge_register() — Register a bridge
-* fpga_bridge_unregister() — Unregister a bridge
+* struct fpga_bridge - The FPGA Bridge structure
+* struct fpga_bridge_ops - Low level Bridge driver ops
+* fpga_bridge_register() - Create and register a bridge
+* fpga_bridge_unregister() - Unregister a bridge
 
 .. kernel-doc:: include/linux/fpga/fpga-bridge.h
    :functions: fpga_bridge
@@ -16,9 +15,6 @@ API to implement a new FPGA bridge
 .. kernel-doc:: include/linux/fpga/fpga-bridge.h
    :functions: fpga_bridge_ops
 
-.. kernel-doc:: drivers/fpga/fpga-bridge.c
-   :functions: devm_fpga_bridge_create
-
 .. kernel-doc:: drivers/fpga/fpga-bridge.c
    :functions: fpga_bridge_register
 
diff --git a/drivers/fpga/altera-fpga2sdram.c b/drivers/fpga/altera-fpga2sdram.c
index a78e49c63c640..66063507116b7 100644
--- a/drivers/fpga/altera-fpga2sdram.c
+++ b/drivers/fpga/altera-fpga2sdram.c
@@ -121,17 +121,13 @@ static int alt_fpga_bridge_probe(struct platform_device *pdev)
 	/* Get f2s bridge configuration saved in handoff register */
 	regmap_read(sysmgr, SYSMGR_ISWGRP_HANDOFF3, &priv->mask);
 
-	br = devm_fpga_bridge_create(dev, F2S_BRIDGE_NAME,
-				     &altera_fpga2sdram_br_ops, priv);
-	if (!br)
-		return -ENOMEM;
+	br = fpga_bridge_register(dev, F2S_BRIDGE_NAME,
+				  &altera_fpga2sdram_br_ops, priv);
+	if (IS_ERR(br))
+		return PTR_ERR(mgr);
 
 	platform_set_drvdata(pdev, br);
 
-	ret = fpga_bridge_register(br);
-	if (ret)
-		return ret;
-
 	dev_info(dev, "driver initialized with handoff %08x\n", priv->mask);
 
 	if (!of_property_read_u32(dev->of_node, "bridge-enable", &enable)) {
diff --git a/drivers/fpga/altera-freeze-bridge.c b/drivers/fpga/altera-freeze-bridge.c
index dd58c4aea92ea..bfbfa43cd05bc 100644
--- a/drivers/fpga/altera-freeze-bridge.c
+++ b/drivers/fpga/altera-freeze-bridge.c
@@ -244,14 +244,14 @@ static int altera_freeze_br_probe(struct platform_device *pdev)
 
 	priv->base_addr = base_addr;
 
-	br = devm_fpga_bridge_create(dev, FREEZE_BRIDGE_NAME,
-				     &altera_freeze_br_br_ops, priv);
-	if (!br)
-		return -ENOMEM;
+	br = fpga_bridge_register(dev, FREEZE_BRIDGE_NAME,
+				  &altera_freeze_br_br_ops, priv);
+	if (IS_ERR(br))
+		return PTR_ERR(br);
 
 	platform_set_drvdata(pdev, br);
 
-	return fpga_bridge_register(br);
+	return 0;
 }
 
 static int altera_freeze_br_remove(struct platform_device *pdev)
diff --git a/drivers/fpga/altera-hps2fpga.c b/drivers/fpga/altera-hps2fpga.c
index 77b95f2518216..aa758426c22bc 100644
--- a/drivers/fpga/altera-hps2fpga.c
+++ b/drivers/fpga/altera-hps2fpga.c
@@ -180,19 +180,15 @@ static int alt_fpga_bridge_probe(struct platform_device *pdev)
 		}
 	}
 
-	br = devm_fpga_bridge_create(dev, priv->name,
-				     &altera_hps2fpga_br_ops, priv);
-	if (!br) {
-		ret = -ENOMEM;
+	br = fpga_bridge_register(dev, priv->name,
+				  &altera_hps2fpga_br_ops, priv);
+	if (IS_ERR(br)) {
+		ret = PTR_ERR(br);
 		goto err;
 	}
 
 	platform_set_drvdata(pdev, br);
 
-	ret = fpga_bridge_register(br);
-	if (ret)
-		goto err;
-
 	return 0;
 
 err:
diff --git a/drivers/fpga/dfl-fme-br.c b/drivers/fpga/dfl-fme-br.c
index 3ff9f3a687ce5..808d1f4d76df8 100644
--- a/drivers/fpga/dfl-fme-br.c
+++ b/drivers/fpga/dfl-fme-br.c
@@ -68,14 +68,14 @@ static int fme_br_probe(struct platform_device *pdev)
 
 	priv->pdata = dev_get_platdata(dev);
 
-	br = devm_fpga_bridge_create(dev, "DFL FPGA FME Bridge",
-				     &fme_bridge_ops, priv);
-	if (!br)
-		return -ENOMEM;
+	br = fpga_bridge_register(dev, "DFL FPGA FME Bridge",
+				  &fme_bridge_ops, priv);
+	if (IS_ERR(br))
+		return PTR_ERR(br);
 
 	platform_set_drvdata(pdev, br);
 
-	return fpga_bridge_register(br);
+	return 0;
 }
 
 static int fme_br_remove(struct platform_device *pdev)
diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
index 2bfb2ff869305..16ae053afc30f 100644
--- a/drivers/fpga/fpga-bridge.c
+++ b/drivers/fpga/fpga-bridge.c
@@ -312,36 +312,41 @@ static struct attribute *fpga_bridge_attrs[] = {
 ATTRIBUTE_GROUPS(fpga_bridge);
 
 /**
- * fpga_bridge_create - create and initialize a struct fpga_bridge
+ * fpga_bridge_register - create and register an FPGA Bridge device
  * @parent:	FPGA bridge device from pdev
  * @name:	FPGA bridge name
  * @br_ops:	pointer to structure of fpga bridge ops
  * @priv:	FPGA bridge private data
  *
- * The caller of this function is responsible for freeing the bridge with
- * fpga_bridge_free().  Using devm_fpga_bridge_create() instead is recommended.
- *
- * Return: struct fpga_bridge or NULL
+ * Return: struct fpga_bridge pointer or ERR_PTR()
  */
-struct fpga_bridge *fpga_bridge_create(struct device *parent, const char *name,
-				       const struct fpga_bridge_ops *br_ops,
-				       void *priv)
+struct fpga_bridge *
+fpga_bridge_register(struct device *parent, const char *name,
+		     const struct fpga_bridge_ops *br_ops,
+		     void *priv)
 {
 	struct fpga_bridge *bridge;
 	int id, ret;
 
+	if (!br_ops) {
+		dev_err(parent, "Attempt to register without fpga_bridge_ops\n");
+		return ERR_PTR(-EINVAL);
+	}
+
 	if (!name || !strlen(name)) {
 		dev_err(parent, "Attempt to register with no name!\n");
-		return NULL;
+		return ERR_PTR(-EINVAL);
 	}
 
 	bridge = kzalloc(sizeof(*bridge), GFP_KERNEL);
 	if (!bridge)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	id = ida_simple_get(&fpga_bridge_ida, 0, 0, GFP_KERNEL);
-	if (id < 0)
+	if (id < 0) {
+		ret = id;
 		goto error_kfree;
+	}
 
 	mutex_init(&bridge->mutex);
 	INIT_LIST_HEAD(&bridge->node);
@@ -350,17 +355,23 @@ struct fpga_bridge *fpga_bridge_create(struct device *parent, const char *name,
 	bridge->br_ops = br_ops;
 	bridge->priv = priv;
 
-	device_initialize(&bridge->dev);
 	bridge->dev.groups = br_ops->groups;
 	bridge->dev.class = fpga_bridge_class;
 	bridge->dev.parent = parent;
 	bridge->dev.of_node = parent->of_node;
 	bridge->dev.id = id;
+	of_platform_populate(bridge->dev.of_node, NULL, NULL, &bridge->dev);
 
 	ret = dev_set_name(&bridge->dev, "br%d", id);
 	if (ret)
 		goto error_device;
 
+	ret = device_register(&bridge->dev);
+	if (ret) {
+		put_device(&bridge->dev);
+		return ERR_PTR(ret);
+	}
+
 	return bridge;
 
 error_device:
@@ -368,88 +379,7 @@ struct fpga_bridge *fpga_bridge_create(struct device *parent, const char *name,
 error_kfree:
 	kfree(bridge);
 
-	return NULL;
-}
-EXPORT_SYMBOL_GPL(fpga_bridge_create);
-
-/**
- * fpga_bridge_free - free an fpga bridge created by fpga_bridge_create()
- * @bridge:	FPGA bridge struct
- */
-void fpga_bridge_free(struct fpga_bridge *bridge)
-{
-	ida_simple_remove(&fpga_bridge_ida, bridge->dev.id);
-	kfree(bridge);
-}
-EXPORT_SYMBOL_GPL(fpga_bridge_free);
-
-static void devm_fpga_bridge_release(struct device *dev, void *res)
-{
-	struct fpga_bridge *bridge = *(struct fpga_bridge **)res;
-
-	fpga_bridge_free(bridge);
-}
-
-/**
- * devm_fpga_bridge_create - create and init a managed struct fpga_bridge
- * @parent:	FPGA bridge device from pdev
- * @name:	FPGA bridge name
- * @br_ops:	pointer to structure of fpga bridge ops
- * @priv:	FPGA bridge private data
- *
- * This function is intended for use in an FPGA bridge driver's probe function.
- * After the bridge driver creates the struct with devm_fpga_bridge_create(), it
- * should register the bridge with fpga_bridge_register().  The bridge driver's
- * remove function should call fpga_bridge_unregister().  The bridge struct
- * allocated with this function will be freed automatically on driver detach.
- * This includes the case of a probe function returning error before calling
- * fpga_bridge_register(), the struct will still get cleaned up.
- *
- *  Return: struct fpga_bridge or NULL
- */
-struct fpga_bridge
-*devm_fpga_bridge_create(struct device *parent, const char *name,
-			 const struct fpga_bridge_ops *br_ops, void *priv)
-{
-	struct fpga_bridge **ptr, *bridge;
-
-	ptr = devres_alloc(devm_fpga_bridge_release, sizeof(*ptr), GFP_KERNEL);
-	if (!ptr)
-		return NULL;
-
-	bridge = fpga_bridge_create(parent, name, br_ops, priv);
-	if (!bridge) {
-		devres_free(ptr);
-	} else {
-		*ptr = bridge;
-		devres_add(parent, ptr);
-	}
-
-	return bridge;
-}
-EXPORT_SYMBOL_GPL(devm_fpga_bridge_create);
-
-/**
- * fpga_bridge_register - register an FPGA bridge
- *
- * @bridge: FPGA bridge struct
- *
- * Return: 0 for success, error code otherwise.
- */
-int fpga_bridge_register(struct fpga_bridge *bridge)
-{
-	struct device *dev = &bridge->dev;
-	int ret;
-
-	ret = device_add(dev);
-	if (ret)
-		return ret;
-
-	of_platform_populate(dev->of_node, NULL, NULL, dev);
-
-	dev_info(dev->parent, "fpga bridge [%s] registered\n", bridge->name);
-
-	return 0;
+	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL_GPL(fpga_bridge_register);
 
@@ -475,6 +405,10 @@ EXPORT_SYMBOL_GPL(fpga_bridge_unregister);
 
 static void fpga_bridge_dev_release(struct device *dev)
 {
+	struct fpga_bridge *bridge = to_fpga_bridge(dev);
+
+	ida_simple_remove(&fpga_bridge_ida, bridge->dev.id);
+	kfree(bridge);
 }
 
 static int __init fpga_bridge_dev_init(void)
diff --git a/drivers/fpga/xilinx-pr-decoupler.c b/drivers/fpga/xilinx-pr-decoupler.c
index ea2bde6e5bc4e..c004e52b94646 100644
--- a/drivers/fpga/xilinx-pr-decoupler.c
+++ b/drivers/fpga/xilinx-pr-decoupler.c
@@ -138,22 +138,17 @@ static int xlnx_pr_decoupler_probe(struct platform_device *pdev)
 
 	clk_disable(priv->clk);
 
-	br = devm_fpga_bridge_create(&pdev->dev, priv->ipconfig->name,
-				     &xlnx_pr_decoupler_br_ops, priv);
-	if (!br) {
-		err = -ENOMEM;
-		goto err_clk;
-	}
-
-	platform_set_drvdata(pdev, br);
-
-	err = fpga_bridge_register(br);
-	if (err) {
+	br = fpga_bridge_register(&pdev->dev, priv->ipconfig->name,
+				  &xlnx_pr_decoupler_br_ops, priv);
+	if (IS_ERR(br)) {
+		err = PTR_ERR(br);
 		dev_err(&pdev->dev, "unable to register %s",
 			priv->ipconfig->name);
 		goto err_clk;
 	}
 
+	platform_set_drvdata(pdev, br);
+
 	return 0;
 
 err_clk:
diff --git a/include/linux/fpga/fpga-bridge.h b/include/linux/fpga/fpga-bridge.h
index 6c3c28806ff13..223da48a6d18b 100644
--- a/include/linux/fpga/fpga-bridge.h
+++ b/include/linux/fpga/fpga-bridge.h
@@ -22,6 +22,23 @@ struct fpga_bridge_ops {
 	const struct attribute_group **groups;
 };
 
+/**
+ * struct fpga_bridge_info - collection of parameters an FPGA Bridge
+ * @name: fpga bridge name
+ * @br_ops: pointer to structure of fpga bridge ops
+ * @priv: fpga bridge private data
+ *
+ * fpga_bridge_info contains parameters for the register function. These
+ * are separated into an info structure because they some are optional
+ * others could be added to in the future. The info structure facilitates
+ * maintaining a stable API.
+ */
+struct fpga_bridge_info {
+	const char *name;
+	const struct fpga_bridge_ops *br_ops;
+	void *priv;
+};
+
 /**
  * struct fpga_bridge - FPGA bridge structure
  * @name: name of low level FPGA bridge
@@ -62,15 +79,10 @@ int of_fpga_bridge_get_to_list(struct device_node *np,
 			       struct fpga_image_info *info,
 			       struct list_head *bridge_list);
 
-struct fpga_bridge *fpga_bridge_create(struct device *dev, const char *name,
-				       const struct fpga_bridge_ops *br_ops,
-				       void *priv);
-void fpga_bridge_free(struct fpga_bridge *br);
-int fpga_bridge_register(struct fpga_bridge *br);
+struct fpga_bridge *
+fpga_bridge_register(struct device *parent, const char *name,
+		     const struct fpga_bridge_ops *br_ops,
+		     void *priv);
 void fpga_bridge_unregister(struct fpga_bridge *br);
 
-struct fpga_bridge
-*devm_fpga_bridge_create(struct device *dev, const char *name,
-			 const struct fpga_bridge_ops *br_ops, void *priv);
-
 #endif /* _LINUX_FPGA_BRIDGE_H */
-- 
2.26.3


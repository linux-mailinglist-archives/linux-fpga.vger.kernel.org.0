Return-Path: <linux-fpga+bounces-350-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D248871D7
	for <lists+linux-fpga@lfdr.de>; Fri, 22 Mar 2024 18:18:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD3E31C21129
	for <lists+linux-fpga@lfdr.de>; Fri, 22 Mar 2024 17:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A8C5FB87;
	Fri, 22 Mar 2024 17:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eSCq8JNs"
X-Original-To: linux-fpga@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A044AEC1
	for <linux-fpga@vger.kernel.org>; Fri, 22 Mar 2024 17:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711127930; cv=none; b=mATsdsWB/WM5bo8TgJFoo06MBOZp5BUGXhm9QT3afO0DNOT76Vj6r16wdW8nmMvmH3DUrLk2bP3evY15NBg8/HTsXVx++qvKs23wWpHwpai5IshtXXRLE6OLroX7XhXfFqO0GEtBvn+yivJrmCPLjbqCLNM0RuHJGO0ArHrdCo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711127930; c=relaxed/simple;
	bh=0LSLi2KEn6JTb2qiXC9G8i4NO9OJ/cgHYcogU7lNVR0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jmo819rbQ95+c6KSl47b3BiEFNeuVcziy54NTeaPRzccueSNnOw5vASAdw3VKCppLVAl3bHWMVoe4nbOJkueZbLycCFg+ORWvzTs8sN3jcdE6px+traYTEOdM6iRTSwkmXsEYBNXO2RDwx96OxOHnHa2bCYLpguiYFU6V31LFUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eSCq8JNs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711127927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fIjqeJ0xWEWrZnQDP+leJjCC5X/NzJjm/S1+lAOoaxk=;
	b=eSCq8JNsYeMkozS+ec+QZpEhVJ+aGjFrrZK/+GGJ3P9moWfDkqtG/yuPzkqLIkyOh2slI3
	/eX538QbclLZoOjDhic1nkV08a3qTb0oIQMloRiagVsJcKb/Rt11DibZ77FEOj7280fN6Y
	9DE5Qr3ixgzPuqxZqlUunmKT+ygUI6s=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-386-fkKeOYRdP8yQj0yxrtEScg-1; Fri, 22 Mar 2024 13:18:45 -0400
X-MC-Unique: fkKeOYRdP8yQj0yxrtEScg-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2d59d0b6856so19584671fa.3
        for <linux-fpga@vger.kernel.org>; Fri, 22 Mar 2024 10:18:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711127924; x=1711732724;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fIjqeJ0xWEWrZnQDP+leJjCC5X/NzJjm/S1+lAOoaxk=;
        b=eMKQHwovrUa3wOfaHhHEQfSowgVBDtLtkxOyXXmCLFaTdOA+h4aREinL91Qfem2QEQ
         5X4ZEB0uPLpM0lQ/RikxsKg2o2NtADnWkIuIozVuOVwQzk3037dI/jNAjK+ip4EkR2zX
         4et0h+gwasHAWG+Qsh59xjjF6vDqOkMiFw3sjwkBNzAGaKerj8eCM//zTzmoX3Zp7DK3
         +JRX4nlkc3Rlab2UnFB4fVjMWVKZI6l6EduAJevz+t/D8uKh+Ak4sEIr9vIxFw14Avz8
         oOlGSBBD2eSbCTJmq4CMaX0kYRyRNo0FNsL+DviOSiz3ktzurj8ZHEbEgN/ASe+niKyM
         1JQg==
X-Forwarded-Encrypted: i=1; AJvYcCW9wC+D62VfcN/ta0LwpdWrUNCCXkz3PclIIN0iUZhtw5Qmw5SklsIqLEptS1Pr9q9qIRHbDvjoVhxGR4Xj+B5HGgyvDlHh9nmWVA==
X-Gm-Message-State: AOJu0YyVNtY3D1hAHepDnICX+JWAQIS3IH/uK4SgIwl/pglsDfuARgQo
	1RZjAnJ8qam81psstRHdmkxAFcMRGWGaO3fGo/RwreCHZC+2S5dJDCfJKfGo+RxJ+2TBTZBjas1
	jkRXYEbiu/pVltCpYoIn2FFxEpyrl2PfP+d4xwRXq7dBIxDeQUFkJrEuA0A==
X-Received: by 2002:a2e:3613:0:b0:2d4:6bc3:192b with SMTP id d19-20020a2e3613000000b002d46bc3192bmr121311lja.31.1711127924227;
        Fri, 22 Mar 2024 10:18:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGl5RkuwAtV6YmZQf0pQGCDanzuIbpweV6PbQUqgc7zx+bJvKfNzOMHaRV7mNnwMblds2YMJg==
X-Received: by 2002:a2e:3613:0:b0:2d4:6bc3:192b with SMTP id d19-20020a2e3613000000b002d46bc3192bmr121290lja.31.1711127923875;
        Fri, 22 Mar 2024 10:18:43 -0700 (PDT)
Received: from klayman.redhat.com (net-2-34-30-89.cust.vodafonedsl.it. [2.34.30.89])
        by smtp.gmail.com with ESMTPSA id g14-20020a05600c310e00b004140a6d52e9sm10354wmo.1.2024.03.22.10.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 10:18:43 -0700 (PDT)
From: Marco Pagani <marpagan@redhat.com>
To: Moritz Fischer <mdf@kernel.org>,
	Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alan Tull <atull@opensource.altera.com>
Cc: Marco Pagani <marpagan@redhat.com>,
	Russ Weight <russ.weight@linux.dev>,
	linux-fpga@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] fpga: bridge: add owner module and take its refcount
Date: Fri, 22 Mar 2024 18:18:37 +0100
Message-ID: <20240322171839.233864-1-marpagan@redhat.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current implementation of the fpga bridge assumes that the low-level
module registers a driver for the parent device and uses its owner pointer
to take the module's refcount. This approach is problematic since it can
lead to a null pointer dereference while attempting to get the bridge if
the parent device does not have a driver.

To address this problem, add a module owner pointer to the fpga_bridge
struct and use it to take the module's refcount. Modify the function for
registering a bridge to take an additional owner module parameter and
rename it to avoid conflicts. Use the old function name for a helper macro
that automatically sets the module that registers the bridge as the owner.
This ensures compatibility with existing low-level control modules and
reduces the chances of registering a bridge without setting the owner.

Also, update the documentation to keep it consistent with the new interface
for registering an fpga bridge.

Other changes: opportunistically move put_device() from __fpga_bridge_get()
to fpga_bridge_get() and of_fpga_bridge_get() to improve code clarity since
the bridge device is taken in these functions.

Fixes: 21aeda950c5f ("fpga: add fpga bridge framework")
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Xu Yilun <yilun.xu@intel.com>
Reviewed-by: Russ Weight <russ.weight@linux.dev>
Signed-off-by: Marco Pagani <marpagan@redhat.com>
---

v3:
- Add reviewed-by Russ Weight
- Fix typo in the documentation (bridge -> FPGA bridge)
v2:
- Split out protection against races while taking the mod's refcount
---
 Documentation/driver-api/fpga/fpga-bridge.rst |  7 ++-
 drivers/fpga/fpga-bridge.c                    | 57 ++++++++++---------
 include/linux/fpga/fpga-bridge.h              | 10 +++-
 3 files changed, 43 insertions(+), 31 deletions(-)

diff --git a/Documentation/driver-api/fpga/fpga-bridge.rst b/Documentation/driver-api/fpga/fpga-bridge.rst
index 604208534095..833f68fb0700 100644
--- a/Documentation/driver-api/fpga/fpga-bridge.rst
+++ b/Documentation/driver-api/fpga/fpga-bridge.rst
@@ -6,9 +6,12 @@ API to implement a new FPGA bridge
 
 * struct fpga_bridge - The FPGA Bridge structure
 * struct fpga_bridge_ops - Low level Bridge driver ops
-* fpga_bridge_register() - Create and register a bridge
+* __fpga_bridge_register() - Create and register a bridge
 * fpga_bridge_unregister() - Unregister a bridge
 
+The helper macro ``fpga_bridge_register()`` automatically sets
+the module that registers the FPGA bridge as the owner.
+
 .. kernel-doc:: include/linux/fpga/fpga-bridge.h
    :functions: fpga_bridge
 
@@ -16,7 +19,7 @@ API to implement a new FPGA bridge
    :functions: fpga_bridge_ops
 
 .. kernel-doc:: drivers/fpga/fpga-bridge.c
-   :functions: fpga_bridge_register
+   :functions: __fpga_bridge_register
 
 .. kernel-doc:: drivers/fpga/fpga-bridge.c
    :functions: fpga_bridge_unregister
diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
index 79c473b3c7c3..8ef395b49bf8 100644
--- a/drivers/fpga/fpga-bridge.c
+++ b/drivers/fpga/fpga-bridge.c
@@ -55,33 +55,26 @@ int fpga_bridge_disable(struct fpga_bridge *bridge)
 }
 EXPORT_SYMBOL_GPL(fpga_bridge_disable);
 
-static struct fpga_bridge *__fpga_bridge_get(struct device *dev,
+static struct fpga_bridge *__fpga_bridge_get(struct device *bridge_dev,
 					     struct fpga_image_info *info)
 {
 	struct fpga_bridge *bridge;
-	int ret = -ENODEV;
 
-	bridge = to_fpga_bridge(dev);
+	bridge = to_fpga_bridge(bridge_dev);
 
 	bridge->info = info;
 
-	if (!mutex_trylock(&bridge->mutex)) {
-		ret = -EBUSY;
-		goto err_dev;
-	}
+	if (!mutex_trylock(&bridge->mutex))
+		return ERR_PTR(-EBUSY);
 
-	if (!try_module_get(dev->parent->driver->owner))
-		goto err_ll_mod;
+	if (!try_module_get(bridge->br_ops_owner)) {
+		mutex_unlock(&bridge->mutex);
+		return ERR_PTR(-ENODEV);
+	}
 
 	dev_dbg(&bridge->dev, "get\n");
 
 	return bridge;
-
-err_ll_mod:
-	mutex_unlock(&bridge->mutex);
-err_dev:
-	put_device(dev);
-	return ERR_PTR(ret);
 }
 
 /**
@@ -98,13 +91,18 @@ static struct fpga_bridge *__fpga_bridge_get(struct device *dev,
 struct fpga_bridge *of_fpga_bridge_get(struct device_node *np,
 				       struct fpga_image_info *info)
 {
-	struct device *dev;
+	struct fpga_bridge *bridge;
+	struct device *bridge_dev;
 
-	dev = class_find_device_by_of_node(&fpga_bridge_class, np);
-	if (!dev)
+	bridge_dev = class_find_device_by_of_node(&fpga_bridge_class, np);
+	if (!bridge_dev)
 		return ERR_PTR(-ENODEV);
 
-	return __fpga_bridge_get(dev, info);
+	bridge = __fpga_bridge_get(bridge_dev, info);
+	if (IS_ERR(bridge))
+		put_device(bridge_dev);
+
+	return bridge;
 }
 EXPORT_SYMBOL_GPL(of_fpga_bridge_get);
 
@@ -125,6 +123,7 @@ static int fpga_bridge_dev_match(struct device *dev, const void *data)
 struct fpga_bridge *fpga_bridge_get(struct device *dev,
 				    struct fpga_image_info *info)
 {
+	struct fpga_bridge *bridge;
 	struct device *bridge_dev;
 
 	bridge_dev = class_find_device(&fpga_bridge_class, NULL, dev,
@@ -132,7 +131,11 @@ struct fpga_bridge *fpga_bridge_get(struct device *dev,
 	if (!bridge_dev)
 		return ERR_PTR(-ENODEV);
 
-	return __fpga_bridge_get(bridge_dev, info);
+	bridge = __fpga_bridge_get(bridge_dev, info);
+	if (IS_ERR(bridge))
+		put_device(bridge_dev);
+
+	return bridge;
 }
 EXPORT_SYMBOL_GPL(fpga_bridge_get);
 
@@ -146,7 +149,7 @@ void fpga_bridge_put(struct fpga_bridge *bridge)
 	dev_dbg(&bridge->dev, "put\n");
 
 	bridge->info = NULL;
-	module_put(bridge->dev.parent->driver->owner);
+	module_put(bridge->br_ops_owner);
 	mutex_unlock(&bridge->mutex);
 	put_device(&bridge->dev);
 }
@@ -316,18 +319,19 @@ static struct attribute *fpga_bridge_attrs[] = {
 ATTRIBUTE_GROUPS(fpga_bridge);
 
 /**
- * fpga_bridge_register - create and register an FPGA Bridge device
+ * __fpga_bridge_register - create and register an FPGA Bridge device
  * @parent:	FPGA bridge device from pdev
  * @name:	FPGA bridge name
  * @br_ops:	pointer to structure of fpga bridge ops
  * @priv:	FPGA bridge private data
+ * @owner:	owner module containing the br_ops
  *
  * Return: struct fpga_bridge pointer or ERR_PTR()
  */
 struct fpga_bridge *
-fpga_bridge_register(struct device *parent, const char *name,
-		     const struct fpga_bridge_ops *br_ops,
-		     void *priv)
+__fpga_bridge_register(struct device *parent, const char *name,
+		       const struct fpga_bridge_ops *br_ops,
+		       void *priv, struct module *owner)
 {
 	struct fpga_bridge *bridge;
 	int id, ret;
@@ -357,6 +361,7 @@ fpga_bridge_register(struct device *parent, const char *name,
 
 	bridge->name = name;
 	bridge->br_ops = br_ops;
+	bridge->br_ops_owner = owner;
 	bridge->priv = priv;
 
 	bridge->dev.groups = br_ops->groups;
@@ -386,7 +391,7 @@ fpga_bridge_register(struct device *parent, const char *name,
 
 	return ERR_PTR(ret);
 }
-EXPORT_SYMBOL_GPL(fpga_bridge_register);
+EXPORT_SYMBOL_GPL(__fpga_bridge_register);
 
 /**
  * fpga_bridge_unregister - unregister an FPGA bridge
diff --git a/include/linux/fpga/fpga-bridge.h b/include/linux/fpga/fpga-bridge.h
index 223da48a6d18..94c4edd047e5 100644
--- a/include/linux/fpga/fpga-bridge.h
+++ b/include/linux/fpga/fpga-bridge.h
@@ -45,6 +45,7 @@ struct fpga_bridge_info {
  * @dev: FPGA bridge device
  * @mutex: enforces exclusive reference to bridge
  * @br_ops: pointer to struct of FPGA bridge ops
+ * @br_ops_owner: module containing the br_ops
  * @info: fpga image specific information
  * @node: FPGA bridge list node
  * @priv: low level driver private date
@@ -54,6 +55,7 @@ struct fpga_bridge {
 	struct device dev;
 	struct mutex mutex; /* for exclusive reference to bridge */
 	const struct fpga_bridge_ops *br_ops;
+	struct module *br_ops_owner;
 	struct fpga_image_info *info;
 	struct list_head node;
 	void *priv;
@@ -79,10 +81,12 @@ int of_fpga_bridge_get_to_list(struct device_node *np,
 			       struct fpga_image_info *info,
 			       struct list_head *bridge_list);
 
+#define fpga_bridge_register(parent, name, br_ops, priv) \
+	__fpga_bridge_register(parent, name, br_ops, priv, THIS_MODULE)
 struct fpga_bridge *
-fpga_bridge_register(struct device *parent, const char *name,
-		     const struct fpga_bridge_ops *br_ops,
-		     void *priv);
+__fpga_bridge_register(struct device *parent, const char *name,
+		       const struct fpga_bridge_ops *br_ops, void *priv,
+		       struct module *owner);
 void fpga_bridge_unregister(struct fpga_bridge *br);
 
 #endif /* _LINUX_FPGA_BRIDGE_H */

base-commit: b1a91ca25f15b6d7b311de4465854a5981dee3d3
-- 
2.44.0



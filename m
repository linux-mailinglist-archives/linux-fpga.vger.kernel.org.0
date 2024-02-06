Return-Path: <linux-fpga+bounces-250-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08EE084B2E7
	for <lists+linux-fpga@lfdr.de>; Tue,  6 Feb 2024 11:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3705281822
	for <lists+linux-fpga@lfdr.de>; Tue,  6 Feb 2024 10:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE1C12F399;
	Tue,  6 Feb 2024 10:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QE6OuMda"
X-Original-To: linux-fpga@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FC912F395
	for <linux-fpga@vger.kernel.org>; Tue,  6 Feb 2024 10:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707217026; cv=none; b=thSGQSnR/MvnW3I45slZSm3xyH2SdDzyGaXnANWFlcM+RHNThqpmHOiUr2pyCQUl2MknnGy+UKPZ1c4hn4cWqCLI5LqS5yBh+2oTDhvN8Q9kpLGirsed+Cg0wMyu6ptoySj5dhMaOFZVpPYFPlHn/WJBCeSt2ZzixDvcfgc15U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707217026; c=relaxed/simple;
	bh=mx+qFJHWvcfHrBaWIWIDXxsAKm6eCbXwFoyWQ5CUgRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QW8PJztwbORJqr1Kvd15WrTnJfUSSPzzFXyziQ0l3Vz2C5UmxqJtigxuo+tPfBm4n3iBeUbL1zwLvNMOlUH3NWj8qxcTkKqb/9LMozJ3Q/N8h5RBFOYTVApBAwsmMQS1JH7yIZ6kg9FUwCx9DUroUfQH8iHN795evkNaxu92CQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QE6OuMda; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707217023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xn5ffsNZGAZsd7lRYjQry8OWwGEZNAaMs6dD/mwfZJ4=;
	b=QE6OuMdapiKaHakHY1L7JeFhqyaGFdqUUA0diTrQ3p/HanjdPM6VdnJna3z0dtqG0N+4U1
	7RSd+eoByc82ZzDa4a5lErav/Nx7bquvMghRbTcOCR0cHQWLsd32MvmYRcXRae9KoscHQn
	UzTcZiWqtiQSAI5Y1rSHDiOgWEZTIS0=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-c3oRvt-SNCCT6p2rr0-9jw-1; Tue, 06 Feb 2024 05:57:02 -0500
X-MC-Unique: c3oRvt-SNCCT6p2rr0-9jw-1
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-7d5bddc5a8bso3016605241.1
        for <linux-fpga@vger.kernel.org>; Tue, 06 Feb 2024 02:57:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707217021; x=1707821821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xn5ffsNZGAZsd7lRYjQry8OWwGEZNAaMs6dD/mwfZJ4=;
        b=FCRCVQqxi8GZ5FIDZN1qiS/OijxMrBvH0i9uzIW7v9iZXnyta3pFmqnDJMQ++YTJbu
         Xvwdude0GFhsA+YO0OFYMgNu748DEA3T1t0fyiRe/SYeIZAOSxNCxhtMc+0r4vHY7HOk
         95YH/NlntGN/vRwuL0fMdN2hmC8ejFQkeGzvky+OtQqiSXnyeEF/a/+AIwENqpIX7TB/
         TV0vQAv82/0vVDwMZmN1fIAu6gpPwmx5AiobKfYTIhohpgVGKCVDTGdv0+f2NCn47caI
         f+JSezxCs4vOjRLnng3L6SgM4jqAY3UN9c6LSRaUcbrqQxWRJA6kvgK1/Y2JRuEOOEts
         S7FQ==
X-Gm-Message-State: AOJu0Yw0QLv2kT0NAtBjH9pJnxMYKSCk54P6VYeaScDIqSAFZzNXzXar
	cTzWyAP/da+4Gnnut+hvB8HbIG+UiNU9cVvjCxXJrNQsu7Ogmdhly8EMC+v/TQkru3xQWlHBxot
	Lf4dX1u3codH6phEDcM7CfcdjaTSy9poS/c8D32tMxHYUKsW27nwXhpXbww==
X-Received: by 2002:a67:cd15:0:b0:46d:3e3e:c71f with SMTP id u21-20020a67cd15000000b0046d3e3ec71fmr1977857vsl.4.1707217021282;
        Tue, 06 Feb 2024 02:57:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG0Y2CTIOcXnbDGesb0m/dnD3q/O30bx+DDKOfiAfK9djkJnmq9QvMX8vVwUFtp6HEahOHMcA==
X-Received: by 2002:a67:cd15:0:b0:46d:3e3e:c71f with SMTP id u21-20020a67cd15000000b0046d3e3ec71fmr1977839vsl.4.1707217020980;
        Tue, 06 Feb 2024 02:57:00 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW03GPz1y2mXVQ22Ea/iB09vgKNE9/Eq9Yv8BwHGCHJXdCnzkFFJI3rgio3syOAPa9OTRF7BHuC66x4RK5CW5d2EbTX9aXV8Ji4YrcQQ4aVHtvVVEqKbdDV7rXoTWTfJRB+LQTzWH4hZgqDCBJZ471Qygms4fMw0rL2PmOmVniDSJGx6NAM7pWpe835LNBZr5oPUrTyzPD6eAa7ycVTbFNFaEJ4rqmXGTmAFBNo8dmQ6zAzwgz1hQnAWY1ng+9forUt+2GSGLx5C4M6Knd5xEmroCRXAUJbUrwxdEBlltptLjfLZTyCwXNJJlxHrM0k9OIBFWgaKWmAx24HuJEKB9brzl4U
Received: from klayman.redhat.com (net-2-34-24-75.cust.vodafonedsl.it. [2.34.24.75])
        by smtp.gmail.com with ESMTPSA id hf15-20020a0562140e8f00b0068c95b634d3sm909547qvb.11.2024.02.06.02.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 02:57:00 -0800 (PST)
From: Marco Pagani <marpagan@redhat.com>
To: Moritz Fischer <mdf@kernel.org>,
	Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alan Tull <atull@opensource.altera.com>
Cc: Marco Pagani <marpagan@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-fpga@vger.kernel.org
Subject: [RFC PATCH 1/1] fpga: bridge: improve protection against low-level control module unloading
Date: Tue,  6 Feb 2024 11:56:44 +0100
Message-ID: <20240206105644.41185-2-marpagan@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206105644.41185-1-marpagan@redhat.com>
References: <20240206105644.41185-1-marpagan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a module owner field to the fpga_bridge struct and use it to take
the low-level control module refcount instead of assuming that the
parent device has a driver and using its owner pointer. The owner is now
passed as an additional argument at registration time. To this end, the
function for registering a bridge has been modified to take an
additional parameter. The old registration function name is used for a
helper macro that automatically sets the module that registers the fpga
bridge as the owner. This ensures compatibility with existing low-level
control modules and reduces the chances of inadvertently registering a
bridge without setting the owner.

Update the documentation to keep it consistent with the new function for
registering a bridge.

Other changes: opportunistically move put_device() from
__fpga_bridge_get() to fpga_bridge_get() and of_fpga_bridge_get() to
improve code clarity since the device refcount is taken in these
functions.

Fixes: 21aeda950c5f ("fpga: add fpga bridge framework")
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Marco Pagani <marpagan@redhat.com>
---
 Documentation/driver-api/fpga/fpga-bridge.rst |  7 ++-
 drivers/fpga/fpga-bridge.c                    | 61 +++++++++++--------
 include/linux/fpga/fpga-bridge.h              | 10 ++-
 3 files changed, 47 insertions(+), 31 deletions(-)

diff --git a/Documentation/driver-api/fpga/fpga-bridge.rst b/Documentation/driver-api/fpga/fpga-bridge.rst
index 604208534095..d8cf0b592673 100644
--- a/Documentation/driver-api/fpga/fpga-bridge.rst
+++ b/Documentation/driver-api/fpga/fpga-bridge.rst
@@ -6,9 +6,12 @@ API to implement a new FPGA bridge
 
 * struct fpga_bridge - The FPGA Bridge structure
 * struct fpga_bridge_ops - Low level Bridge driver ops
-* fpga_bridge_register() - Create and register a bridge
+* __fpga_bridge_register() - Create and register a bridge
 * fpga_bridge_unregister() - Unregister a bridge
 
+The helper macro ``fpga_bridge_register()`` can be used to ease the
+registration of a bridge.
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
index 79c473b3c7c3..aaea612d3339 100644
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
+	if (!bridge->br_ops || !try_module_get(bridge->br_ops_owner)) {
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
@@ -404,6 +409,10 @@ void fpga_bridge_unregister(struct fpga_bridge *bridge)
 	if (bridge->br_ops->fpga_bridge_remove)
 		bridge->br_ops->fpga_bridge_remove(bridge);
 
+	mutex_lock(&bridge->mutex);
+	bridge->br_ops = NULL;
+	mutex_unlock(&bridge->mutex);
+
 	device_unregister(&bridge->dev);
 }
 EXPORT_SYMBOL_GPL(fpga_bridge_unregister);
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
-- 
2.43.0



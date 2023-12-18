Return-Path: <linux-fpga+bounces-58-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D01A7817BD5
	for <lists+linux-fpga@lfdr.de>; Mon, 18 Dec 2023 21:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD05F1C2162A
	for <lists+linux-fpga@lfdr.de>; Mon, 18 Dec 2023 20:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E642872061;
	Mon, 18 Dec 2023 20:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FfNC5crF"
X-Original-To: linux-fpga@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A20548784
	for <linux-fpga@vger.kernel.org>; Mon, 18 Dec 2023 20:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702931302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w2UwYCwVRjcUcjWfvK32U8AOw6QLNt0hCo/IhBitX7A=;
	b=FfNC5crFsDdR2f9wFRnwBZzp2Ejnv6uTFkgZlOb5LekLI7ofxLKNE5tjnXTdc6aROSl9E2
	OCgB+boVuwxWfFFJavZ2RYCrPdcUrchK21mR0mKsTt7OChMfdJXnsWG5uRUnXUieObUIs0
	JwJL55Fh0atZTXvBDha0yajWf/IYL8k=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-sYaHRM4MOySg2NyHBnBVEg-1; Mon, 18 Dec 2023 15:28:20 -0500
X-MC-Unique: sYaHRM4MOySg2NyHBnBVEg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-33664cd4057so811442f8f.1
        for <linux-fpga@vger.kernel.org>; Mon, 18 Dec 2023 12:28:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702931299; x=1703536099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w2UwYCwVRjcUcjWfvK32U8AOw6QLNt0hCo/IhBitX7A=;
        b=eTrW2DrIcY13pYrXbnY713AKIe4P2JPhbuIwxlp9ovvhDlZ5qdOG7v+Lzrh7ZHQLdd
         roJH58VVBHyezazuo02MAek0jrTFGZRsna1QeyLx/UGuEuAaAn01cr1obQTTN6PIbWH9
         CgCyWMwVP057GcLOqiy5iPAo40+7FQxXgg0FUuL6uRiVGApPQvyYxSWu+NOukcbIz6bw
         u+tv0BveJ4AInJTDvFxhQtE4KsD1dgzdW3J2a/8W0kWWkLblzkn/tJ3WXq3H095zk4LC
         gtF8LfkLZlWz0xTy9VxTW8ZFMgdEEWUv2eEIuF8T0SKaiAVI54PdonwOebZPLlOdukWx
         LT6g==
X-Gm-Message-State: AOJu0YwYAWcZZoN5PgB+GysTkn80wMmDML4DiepB+pbBfaEbSY6MQaFn
	6J/gytg8ECqKXdGU1nG7s/qMrWZy/5v3h8AnhkOGmMmHGso3fA34qesWS6FDH0JKrU0nGDOaP2h
	EiUdk1BlbmIkY9mGYoZEV
X-Received: by 2002:a05:600c:206:b0:40c:2710:f67 with SMTP id 6-20020a05600c020600b0040c27100f67mr7826184wmi.85.1702931299493;
        Mon, 18 Dec 2023 12:28:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEDg29E4gIyB56631JHFETgOjS+yb8CjqZn4f9smNDpgvRnBZUbsLTlpMaOUHcZAV1EcmOPZw==
X-Received: by 2002:a05:600c:206:b0:40c:2710:f67 with SMTP id 6-20020a05600c020600b0040c27100f67mr7826182wmi.85.1702931299220;
        Mon, 18 Dec 2023 12:28:19 -0800 (PST)
Received: from klayman.redhat.com (net-2-34-31-72.cust.vodafonedsl.it. [2.34.31.72])
        by smtp.gmail.com with ESMTPSA id p3-20020a05600c1d8300b0040d1450ca7esm9487652wms.7.2023.12.18.12.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 12:28:18 -0800 (PST)
From: Marco Pagani <marpagan@redhat.com>
To: Moritz Fischer <mdf@kernel.org>,
	Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Marco Pagani <marpagan@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-fpga@vger.kernel.org
Subject: [RFC PATCH v3 1/2] fpga: add an owner field and use it to take the low-level module's refcount
Date: Mon, 18 Dec 2023 21:28:08 +0100
Message-ID: <20231218202809.84253-2-marpagan@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218202809.84253-1-marpagan@redhat.com>
References: <20231218202809.84253-1-marpagan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a module owner field to the fpga_manager_ops struct and use it to
take the low-level control module's refcount instead of relying on the
parent device's driver pointer. Low-level control modules should
statically set the owner field to THIS_MODULE. To detect when the owner
module pointer becomes stale, set the mops pointer to null during
fpga_mgr_unregister() (called by the low-level module exit function) and
test it before taking the module's refcount. Use a mutex to avoid a
crash that can happen if __fpga_mgr_get() gets suspended between testing
the mops pointer and taking the low-level refcount and then resumes when
the low-level module has already been freed.

Thanks to Xu Yilun for suggesting the locking pattern.

Other changes: move put_device() from __fpga_mgr_get() to fpga_mgr_get()
and of_fpga_mgr_get() to improve code clarity.

Fixes: 654ba4cc0f3e ("fpga manager: ensure lifetime with of_fpga_mgr_get")
Signed-off-by: Marco Pagani <marpagan@redhat.com>
---
 drivers/fpga/fpga-mgr.c       | 50 ++++++++++++++++++++++++-----------
 include/linux/fpga/fpga-mgr.h |  4 +++
 2 files changed, 38 insertions(+), 16 deletions(-)

diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index 06651389c592..a32b7d40080d 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -664,20 +664,20 @@ static struct attribute *fpga_mgr_attrs[] = {
 };
 ATTRIBUTE_GROUPS(fpga_mgr);
 
-static struct fpga_manager *__fpga_mgr_get(struct device *dev)
+static struct fpga_manager *__fpga_mgr_get(struct device *mgr_dev)
 {
 	struct fpga_manager *mgr;
 
-	mgr = to_fpga_manager(dev);
+	mgr = to_fpga_manager(mgr_dev);
 
-	if (!try_module_get(dev->parent->driver->owner))
-		goto err_dev;
+	mutex_lock(&mgr->mops_mutex);
 
-	return mgr;
+	if (!mgr->mops || !try_module_get(mgr->mops->owner))
+		mgr = ERR_PTR(-ENODEV);
 
-err_dev:
-	put_device(dev);
-	return ERR_PTR(-ENODEV);
+	mutex_unlock(&mgr->mops_mutex);
+
+	return mgr;
 }
 
 static int fpga_mgr_dev_match(struct device *dev, const void *data)
@@ -693,12 +693,18 @@ static int fpga_mgr_dev_match(struct device *dev, const void *data)
  */
 struct fpga_manager *fpga_mgr_get(struct device *dev)
 {
-	struct device *mgr_dev = class_find_device(&fpga_mgr_class, NULL, dev,
-						   fpga_mgr_dev_match);
+	struct fpga_manager *mgr;
+	struct device *mgr_dev;
+
+	mgr_dev = class_find_device(&fpga_mgr_class, NULL, dev, fpga_mgr_dev_match);
 	if (!mgr_dev)
 		return ERR_PTR(-ENODEV);
 
-	return __fpga_mgr_get(mgr_dev);
+	mgr = __fpga_mgr_get(mgr_dev);
+	if (IS_ERR(mgr))
+		put_device(mgr_dev);
+
+	return mgr;
 }
 EXPORT_SYMBOL_GPL(fpga_mgr_get);
 
@@ -711,13 +717,18 @@ EXPORT_SYMBOL_GPL(fpga_mgr_get);
  */
 struct fpga_manager *of_fpga_mgr_get(struct device_node *node)
 {
-	struct device *dev;
+	struct fpga_manager *mgr;
+	struct device *mgr_dev;
 
-	dev = class_find_device_by_of_node(&fpga_mgr_class, node);
-	if (!dev)
+	mgr_dev = class_find_device_by_of_node(&fpga_mgr_class, node);
+	if (!mgr_dev)
 		return ERR_PTR(-ENODEV);
 
-	return __fpga_mgr_get(dev);
+	mgr = __fpga_mgr_get(mgr_dev);
+	if (IS_ERR(mgr))
+		put_device(mgr_dev);
+
+	return mgr;
 }
 EXPORT_SYMBOL_GPL(of_fpga_mgr_get);
 
@@ -727,7 +738,7 @@ EXPORT_SYMBOL_GPL(of_fpga_mgr_get);
  */
 void fpga_mgr_put(struct fpga_manager *mgr)
 {
-	module_put(mgr->dev.parent->driver->owner);
+	module_put(mgr->mops->owner);
 	put_device(&mgr->dev);
 }
 EXPORT_SYMBOL_GPL(fpga_mgr_put);
@@ -803,6 +814,7 @@ fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *in
 	}
 
 	mutex_init(&mgr->ref_mutex);
+	mutex_init(&mgr->mops_mutex);
 
 	mgr->name = info->name;
 	mgr->mops = info->mops;
@@ -888,6 +900,12 @@ void fpga_mgr_unregister(struct fpga_manager *mgr)
 	 */
 	fpga_mgr_fpga_remove(mgr);
 
+	mutex_lock(&mgr->mops_mutex);
+
+	mgr->mops = NULL;
+
+	mutex_unlock(&mgr->mops_mutex);
+
 	device_unregister(&mgr->dev);
 }
 EXPORT_SYMBOL_GPL(fpga_mgr_unregister);
diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
index 54f63459efd6..b4d9413cb444 100644
--- a/include/linux/fpga/fpga-mgr.h
+++ b/include/linux/fpga/fpga-mgr.h
@@ -162,6 +162,7 @@ struct fpga_manager_info {
  * @write_complete: set FPGA to operating state after writing is done
  * @fpga_remove: optional: Set FPGA into a specific state during driver remove
  * @groups: optional attribute groups.
+ * @owner: owner module containing the ops.
  *
  * fpga_manager_ops are the low level functions implemented by a specific
  * fpga manager driver.  The optional ones are tested for NULL before being
@@ -184,6 +185,7 @@ struct fpga_manager_ops {
 			      struct fpga_image_info *info);
 	void (*fpga_remove)(struct fpga_manager *mgr);
 	const struct attribute_group **groups;
+	struct module *owner;
 };
 
 /* FPGA manager status: Partial/Full Reconfiguration errors */
@@ -201,6 +203,7 @@ struct fpga_manager_ops {
  * @state: state of fpga manager
  * @compat_id: FPGA manager id for compatibility check.
  * @mops: pointer to struct of fpga manager ops
+ * @mops_mutex: protects mops from low-level module removal
  * @priv: low level driver private date
  */
 struct fpga_manager {
@@ -209,6 +212,7 @@ struct fpga_manager {
 	struct mutex ref_mutex;
 	enum fpga_mgr_states state;
 	struct fpga_compat_id *compat_id;
+	struct mutex mops_mutex;
 	const struct fpga_manager_ops *mops;
 	void *priv;
 };
-- 
2.43.0



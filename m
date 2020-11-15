Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8E322B38D3
	for <lists+linux-fpga@lfdr.de>; Sun, 15 Nov 2020 20:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbgKOTvc (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 15 Nov 2020 14:51:32 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37140 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727263AbgKOTvb (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 15 Nov 2020 14:51:31 -0500
Received: by mail-pf1-f195.google.com with SMTP id c66so11389753pfa.4;
        Sun, 15 Nov 2020 11:51:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kaCMoVF5ntXg+etJc321w7tzX64fi2nIl8DoCz0hp/Q=;
        b=mo09ZekgCgl+8aLBDcUCrakmYOJY2arIW7/N9rRpNjid6WG0ghJtQp4C6GdBPbIQpy
         CHeXiDJSow/NfW8Vz1GBsb118DwewTXasPSc1KsokTdcw7dkgiVi+CG+7mzZZTo5ivNW
         01Dg7BFAzylgt7EbaaZi5ik0ukCkUDrMc7jVqarzMj3/92/X99cXxG/XZ0rkPW0wJewD
         dJriEqp7xEWYe3ZjMz2NUtj/PFs98hFXHNZDfPCpeMm9Ux5dshkKACaDKkaamh8L4mbn
         30uAzoGRUpsIeLhGwjmTAQCdF006ttIZBUkuRMEu7HEeFg0BbXoG2SksCmAIZHbtMNKp
         dwYw==
X-Gm-Message-State: AOAM5334lBqmIhucUkEqEiqBbUezPqeW3AbzDs+UKI3wQWDyhL3uZfY3
        pkFWNEP+UzDbcwyuHPdnTy4=
X-Google-Smtp-Source: ABdhPJy/FUDNJ4m30AJjEmUCghd2AP7bGMFVjAaQF0O8Gz9VlDZBUJTQHadmX6JosxD2JxXghbHoIA==
X-Received: by 2002:a17:90a:db89:: with SMTP id h9mr10616467pjv.34.1605469891107;
        Sun, 15 Nov 2020 11:51:31 -0800 (PST)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id t74sm15901133pfc.47.2020.11.15.11.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2020 11:51:30 -0800 (PST)
From:   Moritz Fischer <mdf@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        trix@redhat.com, Moritz Fischer <mdf@kernel.org>
Subject: [RESEND PATCH 01/10] fpga: fpga-mgr: Add devm_fpga_mgr_register() API
Date:   Sun, 15 Nov 2020 11:51:18 -0800
Message-Id: <20201115195127.284487-2-mdf@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201115195127.284487-1-mdf@kernel.org>
References: <20201115195127.284487-1-mdf@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Add a devm_fpga_mgr_register() API that can be used to register a FPGA
Manager that was created using devm_fpga_mgr_create().

Introduce a struct fpga_mgr_devres that makes the devres
allocation a little bit more readable and gets reused for
devm_fpga_mgr_create() devm_fpga_mgr_register().

Reviewed-by: Tom Rix <trix@redhat.com>
Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
 drivers/fpga/fpga-mgr.c       | 81 +++++++++++++++++++++++++++++------
 include/linux/fpga/fpga-mgr.h |  2 +
 2 files changed, 71 insertions(+), 12 deletions(-)

diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index f38bab01432e..b85bc47c91a9 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -21,6 +21,10 @@
 static DEFINE_IDA(fpga_mgr_ida);
 static struct class *fpga_mgr_class;
 
+struct fpga_mgr_devres {
+	struct fpga_manager *mgr;
+};
+
 /**
  * fpga_image_info_alloc - Allocate a FPGA image info struct
  * @dev: owning device
@@ -625,9 +629,9 @@ EXPORT_SYMBOL_GPL(fpga_mgr_free);
 
 static void devm_fpga_mgr_release(struct device *dev, void *res)
 {
-	struct fpga_manager *mgr = *(struct fpga_manager **)res;
+	struct fpga_mgr_devres *dr = res;
 
-	fpga_mgr_free(mgr);
+	fpga_mgr_free(dr->mgr);
 }
 
 /**
@@ -651,21 +655,21 @@ struct fpga_manager *devm_fpga_mgr_create(struct device *dev, const char *name,
 					  const struct fpga_manager_ops *mops,
 					  void *priv)
 {
-	struct fpga_manager **ptr, *mgr;
+	struct fpga_mgr_devres *dr;
 
-	ptr = devres_alloc(devm_fpga_mgr_release, sizeof(*ptr), GFP_KERNEL);
-	if (!ptr)
+	dr = devres_alloc(devm_fpga_mgr_release, sizeof(*dr), GFP_KERNEL);
+	if (!dr)
 		return NULL;
 
-	mgr = fpga_mgr_create(dev, name, mops, priv);
-	if (!mgr) {
-		devres_free(ptr);
-	} else {
-		*ptr = mgr;
-		devres_add(dev, ptr);
+	dr->mgr = fpga_mgr_create(dev, name, mops, priv);
+	if (!dr->mgr) {
+		devres_free(dr);
+		return NULL;
 	}
 
-	return mgr;
+	devres_add(dev, dr);
+
+	return dr->mgr;
 }
 EXPORT_SYMBOL_GPL(devm_fpga_mgr_create);
 
@@ -722,6 +726,59 @@ void fpga_mgr_unregister(struct fpga_manager *mgr)
 }
 EXPORT_SYMBOL_GPL(fpga_mgr_unregister);
 
+static int fpga_mgr_devres_match(struct device *dev, void *res,
+				 void *match_data)
+{
+	struct fpga_mgr_devres *dr = res;
+
+	return match_data == dr->mgr;
+}
+
+static void devm_fpga_mgr_unregister(struct device *dev, void *res)
+{
+	struct fpga_mgr_devres *dr = res;
+
+	fpga_mgr_unregister(dr->mgr);
+}
+
+/**
+ * devm_fpga_mgr_register - resource managed variant of fpga_mgr_register()
+ * @dev: managing device for this FPGA manager
+ * @mgr: fpga manager struct
+ *
+ * This is the devres variant of fpga_mgr_register() for which the unregister
+ * function will be called automatically when the managing device is detached.
+ */
+int devm_fpga_mgr_register(struct device *dev, struct fpga_manager *mgr)
+{
+	struct fpga_mgr_devres *dr;
+	int ret;
+
+	/*
+	 * Make sure that the struct fpga_manager * that is passed in is
+	 * managed itself.
+	 */
+	if (WARN_ON(!devres_find(dev, devm_fpga_mgr_release,
+				 fpga_mgr_devres_match, mgr)))
+		return -EINVAL;
+
+	dr = devres_alloc(devm_fpga_mgr_unregister, sizeof(*dr), GFP_KERNEL);
+	if (!dr)
+		return -ENOMEM;
+
+	ret = fpga_mgr_register(mgr);
+	if (ret) {
+		devres_free(dr);
+		return ret;
+	}
+
+	dr->mgr = mgr;
+	devres_add(dev, dr);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(devm_fpga_mgr_register);
+
 static void fpga_mgr_dev_release(struct device *dev)
 {
 }
diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
index e8ca62b2cb5b..2bc3030a69e5 100644
--- a/include/linux/fpga/fpga-mgr.h
+++ b/include/linux/fpga/fpga-mgr.h
@@ -198,6 +198,8 @@ void fpga_mgr_free(struct fpga_manager *mgr);
 int fpga_mgr_register(struct fpga_manager *mgr);
 void fpga_mgr_unregister(struct fpga_manager *mgr);
 
+int devm_fpga_mgr_register(struct device *dev, struct fpga_manager *mgr);
+
 struct fpga_manager *devm_fpga_mgr_create(struct device *dev, const char *name,
 					  const struct fpga_manager_ops *mops,
 					  void *priv);
-- 
2.29.2


Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A694F2A3D5B
	for <lists+linux-fpga@lfdr.de>; Tue,  3 Nov 2020 08:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbgKCHOY (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 3 Nov 2020 02:14:24 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33922 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbgKCHOY (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 3 Nov 2020 02:14:24 -0500
Received: by mail-pf1-f194.google.com with SMTP id o129so13409831pfb.1
        for <linux-fpga@vger.kernel.org>; Mon, 02 Nov 2020 23:14:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kaCMoVF5ntXg+etJc321w7tzX64fi2nIl8DoCz0hp/Q=;
        b=eJ+0zZNh9Dba8YXaEQQNVdHQ2nw8Y0xFd6gyvl7OObuA14IxrwTGI6YGR1TWM49B1l
         ZjbOfIIO9mEuTirjfcZzRPdK4t4llDWgV1RLFPJ5j40t2PuWdANJkBOLykSbnomBY5ih
         gWejGg3U5EePEGPXmHjWwTEFB/wBy6fiJ5y/TRQHHtSx5f84GmYBn93QzHg4umuAFIY+
         rU93PJvxHFjcJuxOWQBlL9lBy1c5HIf4Gtqi/kX8n+DmOEsDt95u/DMYwTAB0urd85Ou
         4sf6GUmfDmWi0fvfZWM9tkqUtwe1ojAcn32QxTGP8bHjkW/BP3+E6I8l+f+iYw/+Etz9
         bB9g==
X-Gm-Message-State: AOAM532pSgtp5y0ASFn7hE0HLdCW56jbLWK0w7YxF0a2xaZ/QONUfOVu
        qGMRdkBsomzYaZ6CthIAinQ=
X-Google-Smtp-Source: ABdhPJxVp6amYp/mCIBJaAo2EQG7oYiSxcIgLUgPUOSG3eEsTymiOqfg5oZSJgVXc/9wexoxpyaApA==
X-Received: by 2002:a62:16ce:0:b029:160:5faa:23d5 with SMTP id 197-20020a6216ce0000b02901605faa23d5mr24885905pfw.26.1604387663449;
        Mon, 02 Nov 2020 23:14:23 -0800 (PST)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id b67sm15873289pfa.151.2020.11.02.23.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 23:14:22 -0800 (PST)
From:   Moritz Fischer <mdf@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-fpga@vger.kernel.org, Moritz Fischer <mdf@kernel.org>,
        Tom Rix <trix@redhat.com>
Subject: [PATCH 01/10] fpga: fpga-mgr: Add devm_fpga_mgr_register() API
Date:   Mon,  2 Nov 2020 23:14:02 -0800
Message-Id: <20201103071411.11997-2-mdf@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201103071411.11997-1-mdf@kernel.org>
References: <20201103071411.11997-1-mdf@kernel.org>
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


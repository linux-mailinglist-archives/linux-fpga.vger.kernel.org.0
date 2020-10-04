Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6272028290A
	for <lists+linux-fpga@lfdr.de>; Sun,  4 Oct 2020 07:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725836AbgJDFOu (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 4 Oct 2020 01:14:50 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:33761 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbgJDFOt (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 4 Oct 2020 01:14:49 -0400
Received: by mail-pj1-f66.google.com with SMTP id t23so2387718pji.0;
        Sat, 03 Oct 2020 22:14:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e9dROueXo0BgEtMsBpPMHaAR3SvNMce1Uv/F/sJsEdw=;
        b=SzXc1t8WmEaT4gPTa9Wu7Hh/XKANg2k7I9I7uzi3+rKbjbcPWov8ZrfJBwHqfvNZQ8
         gd6E8aWN8ZP8tc5vAVvdzgUbuPPxc+5hmTdxdbxNHjSckBokDZL+UVxX5/FxSZqhD4KA
         qg/J739XLeWCeWKrXMFgNYoXDzU3lZ4yeeEmEQNb7x9S7DnSOGnBOC/qzyjbmyD4jD9D
         rwdJ8flg7IQrGCBCQUe4SV5CmxKOg8S619JSqEwQgWhIuwSU0aVHRkEFOURKrlfQ0MO5
         uGo52rgYGuSUF+rGVdKOAostUfquVjywsEp+sJSgpBV4F3Rz2kjdd5Off/DwZFdrbFnQ
         BfFw==
X-Gm-Message-State: AOAM531nK8tHRxuJoif6N2mO6faCRNYZ2LaLN7Mc37I98BREZsFkj8zM
        VxAYf/uKuQts/DDh+vHVLcTsMEQEVP4=
X-Google-Smtp-Source: ABdhPJy8ZnJ4aY7II/coq6RV7KcdKTGw1X3kkzNwC1i68pFQCjiBz5fSZmzADaGy6b5tAgE/tMQzlQ==
X-Received: by 2002:a17:90a:c28e:: with SMTP id f14mr10285907pjt.83.1601788488269;
        Sat, 03 Oct 2020 22:14:48 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id d128sm7540251pfd.94.2020.10.03.22.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2020 22:14:47 -0700 (PDT)
From:   Moritz Fischer <mdf@kernel.org>
To:     linux-fpga@vger.kernel.org
Cc:     trix@redhat.com, hao.wu@intel.com, michal.simek@xilinx.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        russell.h.weight@intel.com, matthew.gerlach@intel.com,
        Moritz Fischer <mdf@kernel.org>
Subject: [PATCH 01/10] fpga: fpga-mgr: Add devm_fpga_mgr_register() API
Date:   Sat,  3 Oct 2020 22:14:14 -0700
Message-Id: <20201004051423.75879-2-mdf@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201004051423.75879-1-mdf@kernel.org>
References: <20201004051423.75879-1-mdf@kernel.org>
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

Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
 drivers/fpga/fpga-mgr.c       | 76 ++++++++++++++++++++++++++++++-----
 include/linux/fpga/fpga-mgr.h |  2 +
 2 files changed, 68 insertions(+), 10 deletions(-)

diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index f38bab01432e..774ac98fb69c 100644
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
 
@@ -722,6 +726,58 @@ void fpga_mgr_unregister(struct fpga_manager *mgr)
 }
 EXPORT_SYMBOL_GPL(fpga_mgr_unregister);
 
+static int fpga_mgr_devres_match(struct device *dev, void *priv,
+				 void *match_data)
+{
+	struct fpga_mgr_devres *dr = priv;
+
+	return match_data == dr->mgr;
+}
+
+static void devm_fpga_mgr_unregister(struct device *dev, void *priv)
+{
+	struct fpga_mgr_devres *dr = priv;
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
+	int err;
+
+	/* Make sure that the struct fpga_manager * that is passed in is
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
+	err = fpga_mgr_register(mgr);
+	if (err) {
+		devres_free(dr);
+		return err;
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
2.28.0


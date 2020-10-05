Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B61C283D98
	for <lists+linux-fpga@lfdr.de>; Mon,  5 Oct 2020 19:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729093AbgJERic (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 5 Oct 2020 13:38:32 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46823 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729076AbgJERhq (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 5 Oct 2020 13:37:46 -0400
Received: by mail-pg1-f195.google.com with SMTP id 34so6422029pgo.13;
        Mon, 05 Oct 2020 10:37:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tybOLLtw84rXzj8SWCLjMJDPl0218bwFPqf/Udii/sQ=;
        b=gcM5z7bzg0+lejc1Nc12Ye8ZX+mFgQo66Nk4U3jtdaE/dVHhH1W7IVpVT8UHHLlmAe
         Am/Qe2gi+iMeMTLUnselnIkWEXf8+Sfo20p6h/wvUq+FUaAtOk4OXcehsXn3hJ07vt8C
         kKjQGOXmLULBAqUI+iryyrb5G8+FDhQwx4ZcepkAfqHhVuar+7X44Vw4Ob1IC1bmgEAJ
         Ct93tdYZ86K3a+1+4wIoLpxYTx0az0GAM29SI5zTQBE1Ww8aSkmReLvHlHHpTrKptleZ
         KEVC9TZV/RgklSeF4KH6iV/sycuwfGWNQmxcAX+jp3wMCTkQSEWax8AUY0li5CchCIbw
         G9hA==
X-Gm-Message-State: AOAM532/Ffa/fA7TD88qryPkgxYp0dyArLHaK7+aI8KG+vxx6g5ZI881
        0VBpZ03aBux7eetrdrsPfZ7GbY/iGBE=
X-Google-Smtp-Source: ABdhPJyx9fuPbSBu4xIJRLHVID+oD5yS5Ng1RbS88t2JGKT08aMhnSmNock/loTlXeSrXdv2rF1eDA==
X-Received: by 2002:aa7:9522:0:b029:142:2501:3986 with SMTP id c2-20020aa795220000b029014225013986mr599718pfp.75.1601919464820;
        Mon, 05 Oct 2020 10:37:44 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id g1sm183977pjl.21.2020.10.05.10.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 10:37:43 -0700 (PDT)
From:   Moritz Fischer <mdf@kernel.org>
To:     linux-fpga@vger.kernel.org
Cc:     trix@redhat.com, hao.wu@intel.com, michal.simek@xilinx.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        russell.h.weight@intel.com, matthew.gerlach@intel.com,
        Moritz Fischer <mdf@kernel.org>
Subject: [PATCH v2 01/10] fpga: fpga-mgr: Add devm_fpga_mgr_register() API
Date:   Mon,  5 Oct 2020 10:37:26 -0700
Message-Id: <20201005173735.162408-2-mdf@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201005173735.162408-1-mdf@kernel.org>
References: <20201005173735.162408-1-mdf@kernel.org>
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
2.28.0


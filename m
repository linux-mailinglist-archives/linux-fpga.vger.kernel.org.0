Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E28C96FF3F9
	for <lists+linux-fpga@lfdr.de>; Thu, 11 May 2023 16:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238066AbjEKOVI (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 11 May 2023 10:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238227AbjEKOUy (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 11 May 2023 10:20:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B13170D
        for <linux-fpga@vger.kernel.org>; Thu, 11 May 2023 07:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683814805;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tQ5Ey0GxlvfOuwjDlz/RC7ExtmJfITLgsdhieZAj2To=;
        b=DbdUHIDVdVGvn6Kv6ApRXHNtuC+NLiL0ExDqmrLXHYYnd6DKmhOqRhdjdymbYLeEH86zyp
        GOmJOmhpiqOEScmR5Y1FoPyQ56kRZBHr1/7Gcn58Y6rNsXCozHx7mPm7qRUZjOG+3b/wBr
        y1YX5EKa/RTbnMeku+MxBlzptOdLCRY=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-yyXrIheTPrutl9u15wGIHA-1; Thu, 11 May 2023 10:20:02 -0400
X-MC-Unique: yyXrIheTPrutl9u15wGIHA-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-3f39c562996so20719381cf.1
        for <linux-fpga@vger.kernel.org>; Thu, 11 May 2023 07:20:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683814802; x=1686406802;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tQ5Ey0GxlvfOuwjDlz/RC7ExtmJfITLgsdhieZAj2To=;
        b=lOugUdu0I1M+rd0sgUuO/5uUiWPFYZ0XY1p7zfrU0q/2TKqnj8fL949qbs2zbBrYyh
         BWBjO0Q3320seLLR/3QmZMjnENDEMp57JXOOS8LpA2W2Z00pojkL+60rCfSSEVVExNTU
         Em4h3ncpxZjXlgXphvxGCrrvkI+iJIiux4gD7mJbx6j87Uh0akT56b/oT+D+gkkV9hcM
         ydlGOqkJ+8eZEyDgyoDqVGgmd1mkERxnQDxSzcGp6a1zhQWv+elpfd5zHaF/vmvarEWZ
         zxQzDuaP9VaMvUPYmzhAl6PLjKDDY0NHdeOl2qSR+jx+wYBsAagXWYJoe5Mmp2CgWeBW
         Xn0w==
X-Gm-Message-State: AC+VfDymD7bHZCqlair0+LmiVBB3Mw4FVfwSdrdmM7PqT4iDc0AIT5Ej
        EHtDCx5BJLue39bXwza2P1ZFzN6KB3frkeJs3cLPAQ/uFov8th7a9XWvB+ca9Q96QAw8x0MdqS5
        EkahcE6QEbJ9yh+TPTSkc
X-Received: by 2002:a05:622a:1b92:b0:3f3:a36d:1bd with SMTP id bp18-20020a05622a1b9200b003f3a36d01bdmr11928288qtb.44.1683814802075;
        Thu, 11 May 2023 07:20:02 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4vHT4UKCVs3K3+n0Hvv4KTRl8rQwjhLAiwpVM05w8kEpwpwkawP6jWnglPNao/Ax3ynXvvpw==
X-Received: by 2002:a05:622a:1b92:b0:3f3:a36d:1bd with SMTP id bp18-20020a05622a1b9200b003f3a36d01bdmr11928248qtb.44.1683814801750;
        Thu, 11 May 2023 07:20:01 -0700 (PDT)
Received: from klayman.redhat.com (net-2-34-28-169.cust.vodafonedsl.it. [2.34.28.169])
        by smtp.gmail.com with ESMTPSA id oo11-20020a05620a530b00b0074db94ed42fsm965516qkn.116.2023.05.11.07.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 07:20:01 -0700 (PDT)
From:   Marco Pagani <marpagan@redhat.com>
To:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
Cc:     Marco Pagani <marpagan@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: [RFC PATCH v5 3/4] fpga: add fake FPGA region
Date:   Thu, 11 May 2023 16:19:21 +0200
Message-Id: <20230511141922.437328-4-marpagan@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230511141922.437328-1-marpagan@redhat.com>
References: <20230511141922.437328-1-marpagan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Add fake FPGA region platform driver with support functions. This module
is part of the KUnit tests for the FPGA subsystem.

Signed-off-by: Marco Pagani <marpagan@redhat.com>
---
 drivers/fpga/tests/fake-fpga-region.c | 245 ++++++++++++++++++++++++++
 drivers/fpga/tests/fake-fpga-region.h |  40 +++++
 2 files changed, 285 insertions(+)
 create mode 100644 drivers/fpga/tests/fake-fpga-region.c
 create mode 100644 drivers/fpga/tests/fake-fpga-region.h

diff --git a/drivers/fpga/tests/fake-fpga-region.c b/drivers/fpga/tests/fake-fpga-region.c
new file mode 100644
index 000000000000..020c3ad13812
--- /dev/null
+++ b/drivers/fpga/tests/fake-fpga-region.c
@@ -0,0 +1,245 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for the fake FPGA region
+ *
+ * Copyright (C) 2023 Red Hat, Inc.
+ *
+ * Author: Marco Pagani <marpagan@redhat.com>
+ */
+
+#include <linux/device.h>
+#include <linux/list.h>
+#include <linux/platform_device.h>
+#include <linux/fpga/fpga-mgr.h>
+#include <linux/fpga/fpga-region.h>
+#include <linux/fpga/fpga-bridge.h>
+#include <kunit/test.h>
+
+#include "fake-fpga-region.h"
+
+#define FAKE_FPGA_REGION_DEV_NAME	"fake_fpga_region"
+
+struct fake_region_pdata {
+	struct kunit *test;
+	struct fpga_manager *mgr;
+};
+
+struct bridge_elem {
+	struct fpga_bridge *bridge;
+	struct list_head node;
+};
+
+struct fake_region_priv {
+	struct list_head bridge_list;
+	struct fake_region_pdata *pdata;
+};
+
+/**
+ * fake_fpga_region_register() - register a fake FPGA region.
+ * @mgr: associated FPGA manager.
+ * @parent: parent device.
+ * @test: KUnit test context object.
+ *
+ * Return: pointer to a new fake FPGA region on success, an ERR_PTR() encoded
+ * error code on failure.
+ */
+struct fake_fpga_region *
+fake_fpga_region_register(struct kunit *test, struct fpga_manager *mgr,
+			  struct device *parent)
+{
+	struct fake_fpga_region *region_ctx;
+	struct fake_region_pdata pdata;
+	int ret;
+
+	region_ctx = kunit_kzalloc(test, sizeof(*region_ctx), GFP_KERNEL);
+	if (!region_ctx) {
+		ret = -ENOMEM;
+		goto err_mem;
+	}
+
+	region_ctx->pdev = platform_device_alloc(FAKE_FPGA_REGION_DEV_NAME,
+						 PLATFORM_DEVID_AUTO);
+	if (!region_ctx->pdev) {
+		pr_err("Fake FPGA region device allocation failed\n");
+		ret = -ENOMEM;
+		goto err_mem;
+	}
+
+	pdata.mgr = mgr;
+	pdata.test = test;
+	platform_device_add_data(region_ctx->pdev, &pdata, sizeof(pdata));
+
+	region_ctx->pdev->dev.parent = parent;
+	ret = platform_device_add(region_ctx->pdev);
+	if (ret) {
+		pr_err("Fake FPGA region device add failed\n");
+		goto err_pdev;
+	}
+
+	region_ctx->region = platform_get_drvdata(region_ctx->pdev);
+
+	kunit_info(test, "Fake FPGA region %u: registered\n",
+		   region_ctx->region->dev.id);
+
+	return region_ctx;
+
+err_pdev:
+	platform_device_put(region_ctx->pdev);
+err_mem:
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL_GPL(fake_fpga_region_register);
+
+/**
+ * fake_fpga_region_unregister() - unregister a fake FPGA region.
+ * @region_ctx: fake FPGA region context data structure.
+ */
+void fake_fpga_region_unregister(struct fake_fpga_region *region_ctx)
+{
+	struct fake_region_priv *priv;
+	struct kunit *test;
+	u32 id;
+
+	if (!region_ctx)
+		return;
+
+	id = region_ctx->region->dev.id;
+	priv = region_ctx->region->priv;
+	test = priv->pdata->test;
+
+	platform_device_unregister(region_ctx->pdev);
+
+	kunit_info(test, "Fake FPGA region %u: unregistered\n", id);
+}
+EXPORT_SYMBOL_GPL(fake_fpga_region_unregister);
+
+/**
+ * fake_fpga_region_add_bridge() - add a bridge to a fake FPGA region.
+ * @region_ctx: fake FPGA region context data structure.
+ * @bridge: FPGA bridge.
+ *
+ * Return: 0 if registration succeeded, an error code otherwise.
+ */
+int fake_fpga_region_add_bridge(struct fake_fpga_region *region_ctx,
+				struct fpga_bridge *bridge)
+{
+	struct fake_region_priv *priv;
+	struct bridge_elem *elem;
+
+	priv = region_ctx->region->priv;
+
+	elem = devm_kzalloc(&region_ctx->pdev->dev, sizeof(*elem), GFP_KERNEL);
+	if (!elem)
+		return -ENOMEM;
+
+	/* Add bridge to the list of bridges in the private context */
+	elem->bridge = bridge;
+	list_add(&elem->node, &priv->bridge_list);
+
+	kunit_info(priv->pdata->test, "Bridge: %u added to fake FPGA region: %u\n",
+		   bridge->dev.id, region_ctx->region->dev.id);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(fake_fpga_region_add_bridge);
+
+int fake_fpga_region_program(struct fake_fpga_region *region_ctx)
+{
+	int ret;
+
+	ret = fpga_region_program_fpga(region_ctx->region);
+
+	/* fpga_region_program_fpga() already puts the bridges in case of errors */
+	if (!ret)
+		fpga_bridges_put(&region_ctx->region->bridge_list);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(fake_fpga_region_program);
+
+static int fake_region_get_bridges(struct fpga_region *region)
+{
+	struct fake_region_priv *priv;
+	struct bridge_elem *elem;
+	int ret;
+
+	priv = region->priv;
+
+	/* Copy the list of bridges from the private context to the region */
+	list_for_each_entry(elem, &priv->bridge_list, node) {
+		ret = fpga_bridge_get_to_list(elem->bridge->dev.parent,
+					      region->info,
+					      &region->bridge_list);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+
+static int fake_fpga_region_probe(struct platform_device *pdev)
+{
+	struct device *dev;
+	struct fpga_region *region;
+	struct fpga_manager *mgr;
+	struct fake_region_pdata *pdata;
+	struct fake_region_priv *priv;
+	struct fpga_region_info info;
+
+	dev = &pdev->dev;
+	pdata = dev_get_platdata(dev);
+
+	if (!pdata) {
+		dev_err(&pdev->dev, "Fake FPGA region probe: missing platform data\n");
+		return -EINVAL;
+	}
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	mgr = fpga_mgr_get(pdata->mgr->dev.parent);
+	if (IS_ERR(mgr))
+		return PTR_ERR(mgr);
+
+	priv->pdata = pdata;
+	INIT_LIST_HEAD(&priv->bridge_list);
+
+	memset(&info, 0, sizeof(info));
+	info.priv = priv;
+	info.mgr = mgr;
+	info.get_bridges = fake_region_get_bridges;
+
+	region = fpga_region_register_full(dev, &info);
+	if (IS_ERR(region)) {
+		fpga_mgr_put(mgr);
+		return PTR_ERR(region);
+	}
+
+	platform_set_drvdata(pdev, region);
+
+	return 0;
+}
+
+static int fake_fpga_region_remove(struct platform_device *pdev)
+{
+	struct fpga_region *region = platform_get_drvdata(pdev);
+	struct fpga_manager *mgr = region->mgr;
+
+	fpga_mgr_put(mgr);
+	fpga_region_unregister(region);
+
+	return 0;
+}
+
+static struct platform_driver fake_fpga_region_drv = {
+	.driver = {
+		.name = FAKE_FPGA_REGION_DEV_NAME
+	},
+	.probe = fake_fpga_region_probe,
+	.remove = fake_fpga_region_remove,
+};
+
+module_platform_driver(fake_fpga_region_drv);
+
+MODULE_LICENSE("GPL");
diff --git a/drivers/fpga/tests/fake-fpga-region.h b/drivers/fpga/tests/fake-fpga-region.h
new file mode 100644
index 000000000000..c72992cbb218
--- /dev/null
+++ b/drivers/fpga/tests/fake-fpga-region.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Header file for the fake FPGA region
+ *
+ * Copyright (C) 2023 Red Hat, Inc.
+ *
+ * Author: Marco Pagani <marpagan@redhat.com>
+ */
+
+#ifndef __FPGA_FAKE_RGN_H
+#define __FPGA_FAKE_RGN_H
+
+#include <linux/platform_device.h>
+#include <kunit/test.h>
+#include <linux/fpga/fpga-mgr.h>
+#include <linux/fpga/fpga-bridge.h>
+
+/**
+ * struct fake_fpga_region - fake FPGA region context data structure
+ *
+ * @region: FPGA region.
+ * @pdev: platform device of the FPGA region.
+ */
+struct fake_fpga_region {
+	struct fpga_region *region;
+	struct platform_device *pdev;
+};
+
+struct fake_fpga_region *
+fake_fpga_region_register(struct kunit *test, struct fpga_manager *mgr,
+			  struct device *parent);
+
+int fake_fpga_region_add_bridge(struct fake_fpga_region *region_ctx,
+				struct fpga_bridge *bridge);
+
+int fake_fpga_region_program(struct fake_fpga_region *region_ctx);
+
+void fake_fpga_region_unregister(struct fake_fpga_region *region_ctx);
+
+#endif /* __FPGA_FAKE_RGN_H */
-- 
2.40.1


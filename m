Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70F5A6E2879
	for <lists+linux-fpga@lfdr.de>; Fri, 14 Apr 2023 18:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbjDNQhm (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 14 Apr 2023 12:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjDNQhl (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 14 Apr 2023 12:37:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE87219D
        for <linux-fpga@vger.kernel.org>; Fri, 14 Apr 2023 09:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681490207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p9EM7KUyJwVaEwxyA/Y+8HQEJUTbAzizsc3Hf5VvwRo=;
        b=Y3WVl3N1e5du+9Lu+fAGfFK5q7wcYmP67uz+ZC+RLMVhiUR3bwgTjzDadxhQDaKR3FghQu
        QZpNWvH3fSHsePMQ4hrZmxmCfbSEprDXuX3IylAXIBzezerFrfA2FC6qIrguqhwhpKJUgz
        NwKXXeRnqxd4986dg9E9RQlg0eQkOnI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-fUApRQ1zOASOExjOSNkRgg-1; Fri, 14 Apr 2023 12:36:45 -0400
X-MC-Unique: fUApRQ1zOASOExjOSNkRgg-1
Received: by mail-wm1-f69.google.com with SMTP id q19-20020a05600c46d300b003ef69894934so7778289wmo.6
        for <linux-fpga@vger.kernel.org>; Fri, 14 Apr 2023 09:36:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681490204; x=1684082204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p9EM7KUyJwVaEwxyA/Y+8HQEJUTbAzizsc3Hf5VvwRo=;
        b=b3fMo1j7FL28xgJWBgpAOUE8I3KISiSCXIpTJdkXsKJSM4cFdsyP+SmHIvXCpS2X4h
         LW3KYvSbR0ubbaskT5f5zbhBObagoCdUfv1MbyKx0GwZPM9Z403DRBlKb/lL6NFswlIy
         05eqtPSxr4AmC1H/Ho1Yqk8YZaAVeRwntXWGojnBdiWrk63z8H78Vj6Vt3s8v/J4GZlY
         nOYGeNUKeegQj8Gu+CMqI3tgmagXGf+z+ChF/2yEhscPdLSeIFxUmvpX/KHXk+mk8hRt
         45h90WkpPNnWsAPkxwUzsIoxhcFmcW1zf+ieTgwVaUgC4ANa78mhJ/OvAOf5MI2wH1cS
         dS2Q==
X-Gm-Message-State: AAQBX9cqAH8SeQR6JE9tBixX7AakeEfuJ6Q62+Px05H7iZ8E95l52GpP
        377005bB47BhIrC+NRAFezP8DngtvJKq6lCSzGniG8QdLqpz9CVax3WY4LGRkfVz53MVLWQjtc1
        eVH5O9Y0vhY1AnrAwhkz1
X-Received: by 2002:adf:ef52:0:b0:2cf:3a99:9c1e with SMTP id c18-20020adfef52000000b002cf3a999c1emr4607570wrp.49.1681490204653;
        Fri, 14 Apr 2023 09:36:44 -0700 (PDT)
X-Google-Smtp-Source: AKy350aHh1ukXcrQ0bBP6pKlEqnPSsxI7M9srJy72/U/qtIReKhwoyuEJ6viISvmJmiSvY873TwamQ==
X-Received: by 2002:adf:ef52:0:b0:2cf:3a99:9c1e with SMTP id c18-20020adfef52000000b002cf3a999c1emr4607551wrp.49.1681490204267;
        Fri, 14 Apr 2023 09:36:44 -0700 (PDT)
Received: from klayman.redhat.com (net-2-34-29-20.cust.vodafonedsl.it. [2.34.29.20])
        by smtp.gmail.com with ESMTPSA id k21-20020a05600c1c9500b003ee74c25f12sm8312119wms.35.2023.04.14.09.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 09:36:43 -0700 (PDT)
From:   Marco Pagani <marpagan@redhat.com>
To:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
Cc:     Marco Pagani <marpagan@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: [RFC PATCH v3 2/4] fpga: add fake FPGA bridge
Date:   Fri, 14 Apr 2023 18:36:34 +0200
Message-Id: <20230414163636.236174-3-marpagan@redhat.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230414163636.236174-1-marpagan@redhat.com>
References: <20230414163636.236174-1-marpagan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Add fake FPGA bridge driver with support functions. The driver includes
a counter for the number of switching cycles. This module is part of
the KUnit tests for the FPGA subsystem.

Signed-off-by: Marco Pagani <marpagan@redhat.com>
---
 drivers/fpga/tests/fake-fpga-bridge.c | 242 ++++++++++++++++++++++++++
 drivers/fpga/tests/fake-fpga-bridge.h |  36 ++++
 2 files changed, 278 insertions(+)
 create mode 100644 drivers/fpga/tests/fake-fpga-bridge.c
 create mode 100644 drivers/fpga/tests/fake-fpga-bridge.h

diff --git a/drivers/fpga/tests/fake-fpga-bridge.c b/drivers/fpga/tests/fake-fpga-bridge.c
new file mode 100644
index 000000000000..6a62c04a75c0
--- /dev/null
+++ b/drivers/fpga/tests/fake-fpga-bridge.c
@@ -0,0 +1,242 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for the fake FPGA bridge
+ *
+ * Copyright (C) 2023 Red Hat, Inc.
+ *
+ * Author: Marco Pagani <marpagan@redhat.com>
+ */
+
+#include <linux/types.h>
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <linux/fpga/fpga-bridge.h>
+#include <kunit/test.h>
+
+#include "fake-fpga-bridge.h"
+
+#define FAKE_FPGA_BRIDGE_DEV_NAME	"fake_fpga_bridge"
+
+struct fake_bridge_priv {
+	int id;
+	bool enable;
+	int cycles_count;
+	struct kunit *test;
+};
+
+struct fake_bridge_data {
+	struct kunit *test;
+};
+
+static int op_enable_show(struct fpga_bridge *bridge)
+{
+	struct fake_bridge_priv *priv;
+
+	priv = bridge->priv;
+
+	if (priv->test)
+		kunit_info(priv->test, "Fake FPGA bridge %d: enable_show\n",
+			   priv->id);
+
+	return priv->enable;
+}
+
+static int op_enable_set(struct fpga_bridge *bridge, bool enable)
+{
+	struct fake_bridge_priv *priv;
+
+	priv = bridge->priv;
+
+	if (enable && !priv->enable)
+		priv->cycles_count++;
+
+	priv->enable = enable;
+
+	if (priv->test)
+		kunit_info(priv->test, "Fake FPGA bridge %d: enable_set: %d\n",
+			   priv->id, enable);
+
+	return 0;
+}
+
+static void op_remove(struct fpga_bridge *bridge)
+{
+	struct fake_bridge_priv *priv;
+
+	priv = bridge->priv;
+
+	if (priv->test)
+		kunit_info(priv->test, "Fake FPGA bridge: remove\n");
+}
+
+static const struct fpga_bridge_ops fake_fpga_bridge_ops = {
+	.enable_show = op_enable_show,
+	.enable_set = op_enable_set,
+	.fpga_bridge_remove = op_remove,
+};
+
+/**
+ * fake_fpga_bridge_register() - register a fake FPGA bridge.
+ * @parent: parent device.
+ * @test: KUnit test context object.
+ *
+ * Return: pointer to a new fake FPGA bridge on success, an ERR_PTR()
+ * encoded error code on failure.
+ */
+struct fake_fpga_bridge *
+fake_fpga_bridge_register(struct device *parent, struct kunit *test)
+{
+	struct fake_fpga_bridge *bridge_ctx;
+	struct fake_bridge_data pdata;
+	struct fake_bridge_priv *priv;
+	int ret;
+
+	bridge_ctx = kzalloc(sizeof(*bridge_ctx), GFP_KERNEL);
+	if (!bridge_ctx) {
+		ret = -ENOMEM;
+		goto err_mem;
+	}
+
+	bridge_ctx->pdev = platform_device_alloc(FAKE_FPGA_BRIDGE_DEV_NAME,
+						 PLATFORM_DEVID_AUTO);
+	if (!bridge_ctx->pdev) {
+		pr_err("Fake FPGA bridge device allocation failed\n");
+		ret = -ENOMEM;
+		goto err_mem;
+	}
+
+	pdata.test = test;
+	platform_device_add_data(bridge_ctx->pdev, &pdata, sizeof(pdata));
+
+	bridge_ctx->pdev->dev.parent = parent;
+	ret = platform_device_add(bridge_ctx->pdev);
+	if (ret) {
+		pr_err("Fake FPGA bridge device add failed\n");
+		goto err_pdev;
+	}
+
+	bridge_ctx->bridge = platform_get_drvdata(bridge_ctx->pdev);
+
+	if (test) {
+		priv = bridge_ctx->bridge->priv;
+		kunit_info(test, "Fake FPGA bridge %d registered\n", priv->id);
+	}
+
+	return bridge_ctx;
+
+err_pdev:
+	platform_device_put(bridge_ctx->pdev);
+	kfree(bridge_ctx);
+err_mem:
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL_GPL(fake_fpga_bridge_register);
+
+/**
+ * fake_fpga_bridge_unregister() - unregister a fake FPGA bridge.
+ * @bridge_ctx: fake FPGA bridge context data structure.
+ */
+void fake_fpga_bridge_unregister(struct fake_fpga_bridge *bridge_ctx)
+{
+	struct fake_bridge_priv *priv;
+	struct kunit *test;
+	int id;
+
+	if (!bridge_ctx)
+		return;
+
+	priv = bridge_ctx->bridge->priv;
+	test = priv->test;
+	id = priv->id;
+
+	if (bridge_ctx->pdev) {
+		platform_device_unregister(bridge_ctx->pdev);
+		if (test)
+			kunit_info(test, "Fake FPGA bridge %d unregistered\n", id);
+	}
+
+	kfree(bridge_ctx);
+}
+EXPORT_SYMBOL_GPL(fake_fpga_bridge_unregister);
+
+/**
+ * fake_fpga_bridge_get_state() - get state of a fake FPGA bridge.
+ * @bridge_ctx: fake FPGA bridge context data structure.
+ *
+ * Return: 1 if the bridge is enabled, 0 if disabled.
+ */
+int fake_fpga_bridge_get_state(const struct fake_fpga_bridge *bridge_ctx)
+{
+	return bridge_ctx->bridge->br_ops->enable_show(bridge_ctx->bridge);
+}
+EXPORT_SYMBOL_GPL(fake_fpga_bridge_get_state);
+
+/**
+ * fake_fpga_bridge_get_cycles_count() - get the number of switching cycles.
+ * @bridge_ctx: fake FPGA bridge context data structure.
+ *
+ * Return: number of switching cycles.
+ */
+int fake_fpga_bridge_get_cycles_count(const struct fake_fpga_bridge *bridge_ctx)
+{
+	struct fake_bridge_priv *priv;
+
+	priv = bridge_ctx->bridge->priv;
+
+	return priv->cycles_count;
+}
+EXPORT_SYMBOL_GPL(fake_fpga_bridge_get_cycles_count);
+
+static int fake_fpga_bridge_probe(struct platform_device *pdev)
+{
+	struct device *dev;
+	struct fpga_bridge *bridge;
+	struct fake_bridge_data *pdata;
+	struct fake_bridge_priv *priv;
+	static int id_count;
+
+	dev = &pdev->dev;
+	pdata = dev_get_platdata(dev);
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->id = id_count++;
+	priv->enable = true;
+
+	if (pdata)
+		priv->test = pdata->test;
+
+	bridge = fpga_bridge_register(dev, "Fake FPGA Bridge",
+				      &fake_fpga_bridge_ops, priv);
+	if (IS_ERR(bridge))
+		return PTR_ERR(bridge);
+
+	platform_set_drvdata(pdev, bridge);
+
+	return 0;
+}
+
+static int fake_fpga_bridge_remove(struct platform_device *pdev)
+{
+	struct fpga_bridge *bridge = platform_get_drvdata(pdev);
+
+	fpga_bridge_unregister(bridge);
+
+	return 0;
+}
+
+static struct platform_driver fake_fpga_bridge_drv = {
+	.driver = {
+		.name = FAKE_FPGA_BRIDGE_DEV_NAME
+	},
+	.probe = fake_fpga_bridge_probe,
+	.remove = fake_fpga_bridge_remove,
+};
+
+module_platform_driver(fake_fpga_bridge_drv);
+
+MODULE_AUTHOR("Marco Pagani <marpagan@redhat.com>");
+MODULE_DESCRIPTION("Fake FPGA Bridge");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/fpga/tests/fake-fpga-bridge.h b/drivers/fpga/tests/fake-fpga-bridge.h
new file mode 100644
index 000000000000..a5acfdf18056
--- /dev/null
+++ b/drivers/fpga/tests/fake-fpga-bridge.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Header file for the fake FPGA bridge
+ *
+ * Copyright (C) 2023 Red Hat, Inc.
+ *
+ * Author: Marco Pagani <marpagan@redhat.com>
+ */
+
+#ifndef __FPGA_FAKE_BRIDGE_H
+#define __FPGA_FAKE_BRIDGE_H
+
+#include <linux/platform_device.h>
+#include <kunit/test.h>
+
+/**
+ * struct fake_fpga_bridge - fake FPGA bridge context data structure
+ *
+ * @bridge: FPGA bridge.
+ * @pdev: platform device of the FPGA bridge.
+ */
+struct fake_fpga_bridge {
+	struct fpga_bridge *bridge;
+	struct platform_device *pdev;
+};
+
+struct fake_fpga_bridge *
+fake_fpga_bridge_register(struct device *parent, struct kunit *test);
+
+void fake_fpga_bridge_unregister(struct fake_fpga_bridge *bridge_ctx);
+
+int fake_fpga_bridge_get_state(const struct fake_fpga_bridge *bridge_ctx);
+
+int fake_fpga_bridge_get_cycles_count(const struct fake_fpga_bridge *bridge_ctx);
+
+#endif /* __FPGA_FAKE_BRIDGE_H */
-- 
2.39.2


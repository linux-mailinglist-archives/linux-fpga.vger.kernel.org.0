Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B886E47A4
	for <lists+linux-fpga@lfdr.de>; Mon, 17 Apr 2023 14:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjDQMZd (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 17 Apr 2023 08:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbjDQMZU (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 17 Apr 2023 08:25:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CE893E5
        for <linux-fpga@vger.kernel.org>; Mon, 17 Apr 2023 05:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681734199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p9EM7KUyJwVaEwxyA/Y+8HQEJUTbAzizsc3Hf5VvwRo=;
        b=MYCAO6rWM9+NSl++7kt7jsSbm16sZdyML4PeI1DohJtQNEHlXEttr1EN7HQzZf4fq737FB
        ZbQ1j/mPZRYWEpUIsFb6JeAjcip/w9JGZWgvcOEKDJzI8lBwyJ4c7ebDce9CATGlbAQgvQ
        SxuX6y/xwe+lcd9JfdOiFwDcCg5lAQQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-A05TjcfaNzKM0yHJS8EqyQ-1; Mon, 17 Apr 2023 08:23:17 -0400
X-MC-Unique: A05TjcfaNzKM0yHJS8EqyQ-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-505149e1a4eso10315653a12.1
        for <linux-fpga@vger.kernel.org>; Mon, 17 Apr 2023 05:23:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681734197; x=1684326197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p9EM7KUyJwVaEwxyA/Y+8HQEJUTbAzizsc3Hf5VvwRo=;
        b=hNhtTA3Tt81Sosh2g6bvLMV3RuMDN9cdRCmjrKYtf9IqCjaUWPknVlH69Y5TKK5OgK
         bC4pHaZmWz/V6bb519avOTtlax9qwFBKYDpfjNCsw4U1yszJXBqaayrRCkgY1PTE22WP
         WdpH9Me3K8Iq1HAz/N232VGF6LRIh1HtKYjbKMnmA60akKCzC8rcvctq+h8qrDjGt5mU
         cJcl6xJEV6lGQIBYDBw2/ec58DTRewJsjVOcz/vZtjFHFGhE7+iRvrBWihakpaUzeVRt
         mbDZ0jxa7gpyVLJPn5DTnLue8EN9vxraAOvIqfpRTgIBE//8b6RAJnTlIOUv+ZqpI+x6
         G+qg==
X-Gm-Message-State: AAQBX9eX+dv7L3eb240GmI20x3ILOp3seJwQnHDwoDFPxQJbL+PVlTb0
        oFI/UTk3KajUiMgqqEtuS5NMGT7rten2JlpDBjjDJPytDVqxd5+O5ljleh0rD5LCiomgSjrQfIj
        LD/TiCQaZR3KyQlfWgqJF
X-Received: by 2002:aa7:cf88:0:b0:500:47ed:9784 with SMTP id z8-20020aa7cf88000000b0050047ed9784mr12990284edx.14.1681734196732;
        Mon, 17 Apr 2023 05:23:16 -0700 (PDT)
X-Google-Smtp-Source: AKy350bcV5yClC5o+iqbcAU05lKyT1d8TcCYeG2x9TZrpFENRu8PF08g4fj64YjFI1bngK2VwI1qVQ==
X-Received: by 2002:aa7:cf88:0:b0:500:47ed:9784 with SMTP id z8-20020aa7cf88000000b0050047ed9784mr12990267edx.14.1681734196373;
        Mon, 17 Apr 2023 05:23:16 -0700 (PDT)
Received: from klayman.. ([37.163.248.182])
        by smtp.gmail.com with ESMTPSA id q21-20020aa7cc15000000b004fbf6b35a56sm5756618edt.76.2023.04.17.05.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 05:23:16 -0700 (PDT)
From:   Marco Pagani <marpagan@redhat.com>
To:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
Cc:     Marco Pagani <marpagan@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: [RFC PATCH v4 2/4] fpga: add fake FPGA bridge
Date:   Mon, 17 Apr 2023 14:23:06 +0200
Message-Id: <20230417122308.131453-3-marpagan@redhat.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230417122308.131453-1-marpagan@redhat.com>
References: <20230417122308.131453-1-marpagan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
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


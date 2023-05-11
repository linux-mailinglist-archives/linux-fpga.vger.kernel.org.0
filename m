Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E88D46FF3F7
	for <lists+linux-fpga@lfdr.de>; Thu, 11 May 2023 16:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238286AbjEKOU6 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 11 May 2023 10:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238197AbjEKOUs (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 11 May 2023 10:20:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D10E72
        for <linux-fpga@vger.kernel.org>; Thu, 11 May 2023 07:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683814799;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y7yrARP0OaOnDRJGgagTj/prTEpIs9t+1o9Qdk5PnIg=;
        b=YEa2O6t3RL2YJIKfqBmu9DwNFsdG8Y7pRW0/6XO2IY5Su8/vNuiRP0YEE9gP76zkaoHG9Q
        cVQpJ9QJ955eR4sEUwHgDVkQIU7QPO4TuhlktXws3lKfbWvqYV9bZwCWkcHn8oc0UNd3kq
        /TWTR9URPf98e5tqw7M1nm0Ypm5G41c=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-kvPc_jvKPOSng6DpWlg5Tw-1; Thu, 11 May 2023 10:19:58 -0400
X-MC-Unique: kvPc_jvKPOSng6DpWlg5Tw-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-3f4deee3ec6so18986961cf.1
        for <linux-fpga@vger.kernel.org>; Thu, 11 May 2023 07:19:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683814798; x=1686406798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y7yrARP0OaOnDRJGgagTj/prTEpIs9t+1o9Qdk5PnIg=;
        b=MHhj+bkwjskaDO9Pr6Qm9GgXpnJKmzJHbI8gj+jRvPo6kZvNmzHx/AibjTKLtEpH3x
         jbKxNr4Qr5/nVLcaJIu/aW+qDyOKdS0Oa5t/J55/Pt102t0VsdkgZqKFiG3aH69CEbIW
         lC4PZ1GH6pHYJihffNjtTtNa2XtRgTpDOeCWEUDeo81gEJXfbs3JmFULYtbYd6G0LcXv
         Kq5jJZJ8HeG52CS7KseeOdncH0SdwdQzcLM0M6kELhvsKRGYwCqdyaXNq5dB+A3RaiyS
         kmN7zBB5ZDWZtsBqV6ozSM1WhksyFPWybwV4g3yHmkjBBuPkQAKQ4G1M2TkGn2PHy5PW
         sf/w==
X-Gm-Message-State: AC+VfDwJJji9QiyUlGCJvdWs9c8PrJZ10eOs12EELpCmznouJot0CFwM
        LUELL5su+YY5+m7rNU5pVTrCfj/LYXJ8Y2If1net7uwJcS3CGCMfsqSMpftrX58Bj1TPX2Kxvjk
        acUTkNh7LRGB5HBizOZYk
X-Received: by 2002:a05:622a:651:b0:3f3:8f4a:a5e1 with SMTP id a17-20020a05622a065100b003f38f4aa5e1mr22159268qtb.19.1683814798087;
        Thu, 11 May 2023 07:19:58 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5v5fa81D4Bi+Q+dtmG0kwAX1l9T0KPFKUGBDlDmc5hkH/928w5eIdxzLDHy9uqFl5EJf5x/A==
X-Received: by 2002:a05:622a:651:b0:3f3:8f4a:a5e1 with SMTP id a17-20020a05622a065100b003f38f4aa5e1mr22159231qtb.19.1683814797771;
        Thu, 11 May 2023 07:19:57 -0700 (PDT)
Received: from klayman.redhat.com (net-2-34-28-169.cust.vodafonedsl.it. [2.34.28.169])
        by smtp.gmail.com with ESMTPSA id oo11-20020a05620a530b00b0074db94ed42fsm965516qkn.116.2023.05.11.07.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 07:19:57 -0700 (PDT)
From:   Marco Pagani <marpagan@redhat.com>
To:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
Cc:     Marco Pagani <marpagan@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: [RFC PATCH v5 2/4] fpga: add fake FPGA bridge
Date:   Thu, 11 May 2023 16:19:20 +0200
Message-Id: <20230511141922.437328-3-marpagan@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230511141922.437328-1-marpagan@redhat.com>
References: <20230511141922.437328-1-marpagan@redhat.com>
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

Add fake FPGA bridge platform driver with support functions. This module
is part of the KUnit tests for the FPGA subsystem.

Signed-off-by: Marco Pagani <marpagan@redhat.com>
---
 drivers/fpga/tests/fake-fpga-bridge.c | 203 ++++++++++++++++++++++++++
 drivers/fpga/tests/fake-fpga-bridge.h |  40 +++++
 2 files changed, 243 insertions(+)
 create mode 100644 drivers/fpga/tests/fake-fpga-bridge.c
 create mode 100644 drivers/fpga/tests/fake-fpga-bridge.h

diff --git a/drivers/fpga/tests/fake-fpga-bridge.c b/drivers/fpga/tests/fake-fpga-bridge.c
new file mode 100644
index 000000000000..e5db0a809ee3
--- /dev/null
+++ b/drivers/fpga/tests/fake-fpga-bridge.c
@@ -0,0 +1,203 @@
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
+struct fake_bridge_pdata {
+	struct kunit *test;
+	struct fake_fpga_bridge_stats *stats;
+};
+
+struct fake_bridge_priv {
+	bool state;
+	struct fake_bridge_pdata *pdata;
+};
+
+static int op_enable_show(struct fpga_bridge *bridge)
+{
+	struct fake_bridge_priv *priv;
+
+	priv = bridge->priv;
+
+	kunit_info(priv->pdata->test, "Fake FPGA bridge %u: enable_show\n",
+		   bridge->dev.id);
+
+	return priv->state;
+}
+
+static int op_enable_set(struct fpga_bridge *bridge, bool enable)
+{
+	struct fake_bridge_priv *priv;
+
+	priv = bridge->priv;
+
+	if (enable && !priv->state)
+		priv->pdata->stats->cycles_count++;
+
+	priv->state = enable;
+	priv->pdata->stats->enable = priv->state;
+
+	kunit_info(priv->pdata->test, "Fake FPGA bridge %u: enable_set: %d\n",
+		   bridge->dev.id, enable);
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
+	kunit_info(priv->pdata->test, "Fake FPGA bridge %u: remove\n",
+		   bridge->dev.id);
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
+ * @test: KUnit test context object.
+ * @parent: parent device.
+ *
+ * Return: pointer to a new fake FPGA bridge on success, an ERR_PTR()
+ * encoded error code on failure.
+ */
+struct fake_fpga_bridge *
+fake_fpga_bridge_register(struct kunit *test, struct device *parent)
+{
+	struct fake_fpga_bridge *bridge_ctx;
+	struct fake_bridge_pdata pdata;
+	struct fake_bridge_priv *priv;
+	int ret;
+
+	bridge_ctx = kunit_kzalloc(test, sizeof(*bridge_ctx), GFP_KERNEL);
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
+	pdata.stats = &bridge_ctx->stats;
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
+	priv = bridge_ctx->bridge->priv;
+	bridge_ctx->stats.enable = priv->state;
+
+	kunit_info(test, "Fake FPGA bridge %u: registered\n",
+		   bridge_ctx->bridge->dev.id);
+
+	return bridge_ctx;
+
+err_pdev:
+	platform_device_put(bridge_ctx->pdev);
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
+	u32 id;
+
+	if (!bridge_ctx)
+		return;
+
+	id = bridge_ctx->bridge->dev.id;
+	priv = bridge_ctx->bridge->priv;
+	test = priv->pdata->test;
+
+	platform_device_unregister(bridge_ctx->pdev);
+
+	kunit_info(test, "Fake FPGA bridge %u: unregistered\n", id);
+}
+EXPORT_SYMBOL_GPL(fake_fpga_bridge_unregister);
+
+static int fake_fpga_bridge_probe(struct platform_device *pdev)
+{
+	struct device *dev;
+	struct fake_bridge_pdata *pdata;
+	struct fpga_bridge *bridge;
+	struct fake_bridge_priv *priv;
+
+	dev = &pdev->dev;
+	pdata = dev_get_platdata(dev);
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->pdata = pdata;
+	priv->state = true;
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
+MODULE_LICENSE("GPL");
diff --git a/drivers/fpga/tests/fake-fpga-bridge.h b/drivers/fpga/tests/fake-fpga-bridge.h
new file mode 100644
index 000000000000..3ecfab7e2890
--- /dev/null
+++ b/drivers/fpga/tests/fake-fpga-bridge.h
@@ -0,0 +1,40 @@
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
+#include <linux/types.h>
+#include <linux/platform_device.h>
+#include <kunit/test.h>
+
+struct fake_fpga_bridge_stats {
+	bool enable;
+	u32 cycles_count;
+};
+
+/**
+ * struct fake_fpga_bridge - fake FPGA bridge context data structure
+ *
+ * @bridge: FPGA bridge.
+ * @pdev: platform device of the FPGA bridge.
+ * @stats: info from the low level driver.
+ */
+struct fake_fpga_bridge {
+	struct fpga_bridge *bridge;
+	struct platform_device *pdev;
+	struct fake_fpga_bridge_stats stats;
+};
+
+struct fake_fpga_bridge *
+fake_fpga_bridge_register(struct kunit *test, struct device *parent);
+
+void fake_fpga_bridge_unregister(struct fake_fpga_bridge *bridge_ctx);
+
+#endif /* __FPGA_FAKE_BRIDGE_H */
-- 
2.40.1


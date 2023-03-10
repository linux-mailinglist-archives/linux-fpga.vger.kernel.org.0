Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8E0B6B4E04
	for <lists+linux-fpga@lfdr.de>; Fri, 10 Mar 2023 18:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbjCJRG7 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 10 Mar 2023 12:06:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbjCJRGi (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 10 Mar 2023 12:06:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5828812B7F4
        for <linux-fpga@vger.kernel.org>; Fri, 10 Mar 2023 09:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678467862;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TLMUZ4rcRrVbv/xw3bzEUDacK1AkWuGTxKePE+7Ll2Q=;
        b=cy00tXgX+53RqlbwuGg8p4jLHaMh59OvO9rzA6niOK37B7Hntf5UdLmQhezKlppLRsudAg
        BCr42RbKDqZnZHYKHe415EBsQUxpFTSkgRxzNEcl/PMN+Aq5z6kBvq48aeyoHqvE67Yn6X
        SIhmoy35A6p9/BzUnW2ls+AmEMTUVGw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-xzI6sF0VOEiAOR6A4FqVrg-1; Fri, 10 Mar 2023 12:04:20 -0500
X-MC-Unique: xzI6sF0VOEiAOR6A4FqVrg-1
Received: by mail-wm1-f69.google.com with SMTP id 4-20020a05600c024400b003eb2e295c05so2063312wmj.0
        for <linux-fpga@vger.kernel.org>; Fri, 10 Mar 2023 09:04:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678467859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TLMUZ4rcRrVbv/xw3bzEUDacK1AkWuGTxKePE+7Ll2Q=;
        b=mweTuhdsZSLg/vmbtiS7bXVU8ZoCpEwz/s6E0uY060SAesKR+OO9qO1FdykBf64xWd
         DOqgHxARcOkIFtpkJGaCFnVYMQikePPHoGn3ZvsIHolAXxa5Tyvzx6gG14Ptc6VvhKGg
         Os+LPhiV0Aa4VUsQgWY8VFC387dQqnYhc3C+QoEAL6aYiWdOY12NKD32puArevayMXxa
         GU7qPNP2+mm64QYr0Ygjim2zUAEPx+GmQePfj0Yrzbva4Ke/7qak3S9sMs9Vy4RtevR7
         kfmDCzh0lf2qHl0eAan7Yy7nI9HRN4U71jYDXR8kKQfCwhLOyzxBFfGF0LS/FauWLz/E
         xZsw==
X-Gm-Message-State: AO0yUKVKgpY0GqS4NK9SKOYHRajWYckzoIPyOTMpD/VA7ptBu6AeKa+t
        K1Oq0vSbsvfyQv4Zv6ZOZ0/Q8dJNBO/+DTLAIBj982MAV9pC0pIfSf0G7F+aIjtLf5VSOjOXXiC
        x1LWeMm2SRZ5qtDkGm4Tw
X-Received: by 2002:a05:600c:35c4:b0:3df:9858:c039 with SMTP id r4-20020a05600c35c400b003df9858c039mr1902544wmq.14.1678467859781;
        Fri, 10 Mar 2023 09:04:19 -0800 (PST)
X-Google-Smtp-Source: AK7set+wo4tcCDeoO4GRrE1HMlcLGh0FeVLGonOokUbTLaPIt6uaUKMsYlZG/70VM1tBEimZ4iJw1g==
X-Received: by 2002:a05:600c:35c4:b0:3df:9858:c039 with SMTP id r4-20020a05600c35c400b003df9858c039mr1902526wmq.14.1678467859516;
        Fri, 10 Mar 2023 09:04:19 -0800 (PST)
Received: from klayman.redhat.com (net-2-34-29-20.cust.vodafonedsl.it. [2.34.29.20])
        by smtp.gmail.com with ESMTPSA id u10-20020a05600c00ca00b003eb192787bfsm417294wmm.25.2023.03.10.09.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 09:04:19 -0800 (PST)
From:   Marco Pagani <marpagan@redhat.com>
To:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
Cc:     Marco Pagani <marpagan@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: [RFC PATCH v2 2/4] fpga: add fake FPGA bridge
Date:   Fri, 10 Mar 2023 18:04:10 +0100
Message-Id: <20230310170412.708363-3-marpagan@redhat.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230310170412.708363-1-marpagan@redhat.com>
References: <20230310170412.708363-1-marpagan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
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
 drivers/fpga/tests/fake-fpga-bridge.c | 228 ++++++++++++++++++++++++++
 drivers/fpga/tests/fake-fpga-bridge.h |  36 ++++
 2 files changed, 264 insertions(+)
 create mode 100644 drivers/fpga/tests/fake-fpga-bridge.c
 create mode 100644 drivers/fpga/tests/fake-fpga-bridge.h

diff --git a/drivers/fpga/tests/fake-fpga-bridge.c b/drivers/fpga/tests/fake-fpga-bridge.c
new file mode 100644
index 000000000000..8a2f64fc1bbb
--- /dev/null
+++ b/drivers/fpga/tests/fake-fpga-bridge.c
@@ -0,0 +1,228 @@
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
+ * @bridge_ctx: fake FPGA bridge context data structure.
+ * @parent: parent device.
+ * @test: KUnit test context object.
+ *
+ * Return: 0 if registration succeeded, an error code otherwise.
+ */
+int fake_fpga_bridge_register(struct fake_fpga_bridge *bridge_ctx,
+			      struct device *parent, struct kunit *test)
+{
+	struct fake_bridge_data pdata;
+	struct fake_bridge_priv *priv;
+	int ret;
+
+	pdata.test = test;
+
+	bridge_ctx->pdev = platform_device_alloc(FAKE_FPGA_BRIDGE_DEV_NAME,
+						 PLATFORM_DEVID_AUTO);
+	if (IS_ERR(bridge_ctx->pdev)) {
+		pr_err("Fake FPGA bridge device allocation failed\n");
+		return -ENOMEM;
+	}
+
+	bridge_ctx->pdev->dev.parent = parent;
+	platform_device_add_data(bridge_ctx->pdev, &pdata, sizeof(pdata));
+
+	ret = platform_device_add(bridge_ctx->pdev);
+	if (ret) {
+		pr_err("Fake FPGA bridge device add failed\n");
+		platform_device_put(bridge_ctx->pdev);
+		return ret;
+	}
+
+	bridge_ctx->bridge = platform_get_drvdata(bridge_ctx->pdev);
+
+	if (test) {
+		priv = bridge_ctx->bridge->priv;
+		kunit_info(test, "Fake FPGA bridge %d registered\n", priv->id);
+	}
+
+	return 0;
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
index 000000000000..ae224b13f284
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
+int fake_fpga_bridge_register(struct fake_fpga_bridge *bridge_ctx,
+			      struct device *parent, struct kunit *test);
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


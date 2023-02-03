Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8EB689FFC
	for <lists+linux-fpga@lfdr.de>; Fri,  3 Feb 2023 18:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233089AbjBCRIN (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 3 Feb 2023 12:08:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232910AbjBCRIL (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 3 Feb 2023 12:08:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E319D589
        for <linux-fpga@vger.kernel.org>; Fri,  3 Feb 2023 09:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675444043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aTqTPW1mDhdo6UVlHMTIqNJ0ko0wBmbKrV94jadhHOI=;
        b=Gj0HKFF3zF6JRpnsVgntsHbjvbNNZA64yv6w7bSc91FktN6Qe2bNb1aMharu9JMYzowpdO
        w+pidjd7IScqNHzd7D+OxIbuu6/VcKgDuYetFYH6P6tKgPLGp/DdsXOQpS1jbWQqGzzXVz
        5rKgEALCewqY30bm2x+4/LI5022t62w=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-624-eMV9itsYOnSlQF1RlX_BZg-1; Fri, 03 Feb 2023 12:07:22 -0500
X-MC-Unique: eMV9itsYOnSlQF1RlX_BZg-1
Received: by mail-qv1-f69.google.com with SMTP id ng1-20020a0562143bc100b004bb706b3a27so3085508qvb.20
        for <linux-fpga@vger.kernel.org>; Fri, 03 Feb 2023 09:07:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aTqTPW1mDhdo6UVlHMTIqNJ0ko0wBmbKrV94jadhHOI=;
        b=D2EhOU4WE5DVZDKBnNzS/xHjNpJOTN+tQDVsS/YSAoxiSeBv95T8pZ9sZ50jWLt28a
         EJ2Wf1g7PiKDTv4qCh7lTg9l9o2I7M2z61JIq7n3vNb0DqyAvC/2BEE4J8cSyRgD1slu
         s3fCLCmFvIK3DEMavCpPGsW5xh2V2u/nwIvRfiKSG297j/FsQPeeaRsTPF9yw14jb88M
         ju4KhVLQF2V+txO6iMF1gyF1YrPpBo1i887eXIvjacpPfdsO4KmtUrbKj81OuAX1JHJL
         r6yQbHvOKBFKOMUFs83UJz8vgECNa54Hw0NYjZL9YB3rWVvqhcj0XdI/Xn97wqhudPbw
         hAQA==
X-Gm-Message-State: AO0yUKXG3N560V6S2vDdxSHt0bxAeadkOlCLdeL0UlvYsNAmcTILYulW
        6blaYYEFxE0d4wfErNhfFcT7BNdL08V/XEvfB672AQB/Fs+/kZS3GRGmFg1UTQNo/iDPIWPX+Qp
        TSfDwLK5GnY8XbqYJC9wh
X-Received: by 2002:a05:6214:5ed2:b0:537:6aea:124b with SMTP id mn18-20020a0562145ed200b005376aea124bmr16953970qvb.16.1675444041612;
        Fri, 03 Feb 2023 09:07:21 -0800 (PST)
X-Google-Smtp-Source: AK7set/E7wRxA2GC/e/iNJqZjQ9H5pct+9VhQL/zag8BiEqJiu9fmGsD+wCCGxgYgBCcSHNC96+Aaw==
X-Received: by 2002:a05:6214:5ed2:b0:537:6aea:124b with SMTP id mn18-20020a0562145ed200b005376aea124bmr16953943qvb.16.1675444041288;
        Fri, 03 Feb 2023 09:07:21 -0800 (PST)
Received: from klayman.redhat.com (net-2-34-30-183.cust.vodafonedsl.it. [2.34.30.183])
        by smtp.gmail.com with ESMTPSA id b13-20020ac801cd000000b003a6a19ee4f0sm1884287qtg.33.2023.02.03.09.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 09:07:21 -0800 (PST)
From:   Marco Pagani <marpagan@redhat.com>
To:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
Cc:     Marco Pagani <marpagan@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: [RFC PATCH 4/4] fpga: add fake FPGA bridge
Date:   Fri,  3 Feb 2023 18:06:53 +0100
Message-Id: <20230203170653.414990-5-marpagan@redhat.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230203170653.414990-1-marpagan@redhat.com>
References: <20230203170653.414990-1-marpagan@redhat.com>
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
the KUnit test suite for the FPGA subsystem.

Signed-off-by: Marco Pagani <marpagan@redhat.com>
---
 drivers/fpga/tests/fake-fpga-bridge.c | 214 ++++++++++++++++++++++++++
 drivers/fpga/tests/fake-fpga-bridge.h |  36 +++++
 2 files changed, 250 insertions(+)
 create mode 100644 drivers/fpga/tests/fake-fpga-bridge.c
 create mode 100644 drivers/fpga/tests/fake-fpga-bridge.h

diff --git a/drivers/fpga/tests/fake-fpga-bridge.c b/drivers/fpga/tests/fake-fpga-bridge.c
new file mode 100644
index 000000000000..1f3c8e4fbb6a
--- /dev/null
+++ b/drivers/fpga/tests/fake-fpga-bridge.c
@@ -0,0 +1,214 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for fake FPGA bridge
+ *
+ * Copyright (C) 2023 Red Hat, Inc. All rights reserved.
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
+}
+
+static const struct fpga_bridge_ops fake_fpga_bridge_ops = {
+	.enable_show = op_enable_show,
+	.enable_set = op_enable_set,
+	.fpga_bridge_remove = op_remove,
+};
+
+/**
+ * fake_fpga_bridge_register - register a fake FPGA bridge
+ * @bridge_ctx: fake FPGA bridge context data structure.
+ * @test: KUnit test context object.
+ *
+ * Return: 0 if registration succeeded, an error code otherwise.
+ */
+int fake_fpga_bridge_register(struct fake_fpga_bridge *bridge_ctx,
+			      struct kunit *test)
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
+ * fake_fpga_bridge_unregister - unregister a fake FPGA bridge
+ * @bridge_ctx: fake FPGA bridge context data structure.
+ */
+void fake_fpga_bridge_unregister(struct fake_fpga_bridge *bridge_ctx)
+{
+	struct fake_bridge_priv *priv;
+	struct kunit *test;
+	int id;
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
+ * fake_fpga_bridge_get_state - get state of a fake FPGA bridge
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
+ * fake_fpga_bridge_get_cycles_count - get the number of switching cycles
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
+	priv->test = pdata->test;
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
index 000000000000..9de62d2f993b
--- /dev/null
+++ b/drivers/fpga/tests/fake-fpga-bridge.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Header file for fake FPGA bridge
+ *
+ * Copyright (C) 2023 Red Hat, Inc. All rights reserved.
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
+			      struct kunit *test);
+
+void fake_fpga_bridge_unregister(struct fake_fpga_bridge *bridge_ctx);
+
+int fake_fpga_bridge_get_state(const struct fake_fpga_bridge *bridge_ctx);
+
+int fake_fpga_bridge_get_cycles_count(const struct fake_fpga_bridge *bridge_ctx);
+
+#endif /* __FPGA_FAKE_BRIDGE_H */
-- 
2.39.1


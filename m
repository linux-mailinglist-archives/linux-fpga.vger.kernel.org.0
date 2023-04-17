Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE2526E47A3
	for <lists+linux-fpga@lfdr.de>; Mon, 17 Apr 2023 14:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbjDQMZe (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 17 Apr 2023 08:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbjDQMZV (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 17 Apr 2023 08:25:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81711977E
        for <linux-fpga@vger.kernel.org>; Mon, 17 Apr 2023 05:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681734200;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ou06vBW/0QyFtGlD5ya/Ii/hKgm9cYXdnbTozs3jPKM=;
        b=VgQmiszvmLYnPrINLJ8qqWjFfK7KT/GJvO8HztbRaQnzkdKvfqfP1VrtVgKet9uIzNLHPD
        fNmN2+mm44bvYVAIkUG78aWZpiV9F+sLwt8oMI7nGlh0cYtYDumPI/s5CCKiy37AN2nGFr
        yAz268YoSybhG1DmYBp2oyQxuXy27Ug=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-4zVyLpCnNaaihl7E73N3TA-1; Mon, 17 Apr 2023 08:23:19 -0400
X-MC-Unique: 4zVyLpCnNaaihl7E73N3TA-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-506905b850cso976218a12.1
        for <linux-fpga@vger.kernel.org>; Mon, 17 Apr 2023 05:23:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681734198; x=1684326198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ou06vBW/0QyFtGlD5ya/Ii/hKgm9cYXdnbTozs3jPKM=;
        b=aw3GFu9wyXpYDntHfT+ktktWlKxSBCohayL5dAIwgCVKBB2D4/Lx5uZIGTTQOBA0Bu
         XlOjpVUkwPDIa2m3TlleQ+hD1sb1akmj2TcD1xFwGuraHQgPv7jC4/PkjvKkorLGYUo8
         duG+oFRgekh87iPFN3UuDNcMCSLjfodhcGSu5gAArHr+RhuTGIpKsxfz3zy5W0fdoxe3
         8Qhz2esNm82tw5qQkqvDo7LSclE77PDSfLPYgacxxYTCGjN8+DLrprt8bL2Z5gwFVgu2
         oDPyiaVZNuzbwIlErTxN1UvLnN6o5Ikgc8vW3i0aprwUCnAgM16hPoqMx6l3uGCQs9e7
         STWg==
X-Gm-Message-State: AAQBX9dEtH2ltr/KxlN5MZS07WDaNxyAczYa8/JjkXez3ap1TJqxO5uA
        35KGYsw7+bRoUObFKw8BKG2HWdaciwucQ+sXciOJEuUfZsFW4mnLg1CIRYrrcklXSKPBHltJz0u
        Cgjz1Li6lkOMvSabkxcfe
X-Received: by 2002:a05:6402:138b:b0:506:72fc:8dd7 with SMTP id b11-20020a056402138b00b0050672fc8dd7mr12514396edv.24.1681734198136;
        Mon, 17 Apr 2023 05:23:18 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZSttHT1nZjkXCWrkAxDdPs36P9jYt8i38CJc2oE2JCR7/NExrkmtYRfl1A0Ru1uyrc2PrEBg==
X-Received: by 2002:a05:6402:138b:b0:506:72fc:8dd7 with SMTP id b11-20020a056402138b00b0050672fc8dd7mr12514377edv.24.1681734197796;
        Mon, 17 Apr 2023 05:23:17 -0700 (PDT)
Received: from klayman.. ([37.163.248.182])
        by smtp.gmail.com with ESMTPSA id q21-20020aa7cc15000000b004fbf6b35a56sm5756618edt.76.2023.04.17.05.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 05:23:17 -0700 (PDT)
From:   Marco Pagani <marpagan@redhat.com>
To:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
Cc:     Marco Pagani <marpagan@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: [RFC PATCH v4 3/4] fpga: add fake FPGA region
Date:   Mon, 17 Apr 2023 14:23:07 +0200
Message-Id: <20230417122308.131453-4-marpagan@redhat.com>
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

Add fake FPGA region platform driver with support functions. This
module is part of the KUnit tests for the FPGA subsystem.

Signed-off-by: Marco Pagani <marpagan@redhat.com>
---
 drivers/fpga/tests/fake-fpga-region.c | 259 ++++++++++++++++++++++++++
 drivers/fpga/tests/fake-fpga-region.h |  40 ++++
 2 files changed, 299 insertions(+)
 create mode 100644 drivers/fpga/tests/fake-fpga-region.c
 create mode 100644 drivers/fpga/tests/fake-fpga-region.h

diff --git a/drivers/fpga/tests/fake-fpga-region.c b/drivers/fpga/tests/fake-fpga-region.c
new file mode 100644
index 000000000000..b23ae5e94fe6
--- /dev/null
+++ b/drivers/fpga/tests/fake-fpga-region.c
@@ -0,0 +1,259 @@
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
+struct fake_region_priv {
+	int id;
+	struct kunit *test;
+	struct list_head bridge_list;
+};
+
+struct bridge_elem {
+	struct fpga_bridge *bridge;
+	struct list_head node;
+};
+
+struct fake_region_data {
+	struct fpga_manager *mgr;
+	struct kunit *test;
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
+fake_fpga_region_register(struct fpga_manager *mgr, struct device *parent,
+			  struct kunit *test)
+{
+	struct fake_fpga_region *region_ctx;
+	struct fake_region_data pdata;
+	struct fake_region_priv *priv;
+	int ret;
+
+	region_ctx = kzalloc(sizeof(*region_ctx), GFP_KERNEL);
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
+	if (test) {
+		priv = region_ctx->region->priv;
+		kunit_info(test, "Fake FPGA region %d registered\n", priv->id);
+	}
+
+	return region_ctx;
+
+err_pdev:
+	platform_device_put(region_ctx->pdev);
+	kfree(region_ctx);
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
+	int id;
+
+	if (!region_ctx)
+		return;
+
+	priv = region_ctx->region->priv;
+	test = priv->test;
+	id = priv->id;
+
+	if (region_ctx->pdev) {
+		platform_device_unregister(region_ctx->pdev);
+		if (test)
+			kunit_info(test, "Fake FPGA region %d unregistered\n", id);
+	}
+
+	kfree(region_ctx);
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
+	if (priv->test)
+		kunit_info(priv->test, "Bridge added to fake FPGA region %d\n",
+			   priv->id);
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
+	struct fake_region_data *pdata;
+	struct fake_region_priv *priv;
+	struct fpga_region_info info;
+	static int id_count;
+
+	dev = &pdev->dev;
+	pdata = dev_get_platdata(dev);
+
+	if (!pdata) {
+		dev_err(&pdev->dev, "Missing platform data\n");
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
+	INIT_LIST_HEAD(&priv->bridge_list);
+	priv->id = id_count++;
+	priv->test = pdata->test;
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
+MODULE_AUTHOR("Marco Pagani <marpagan@redhat.com>");
+MODULE_DESCRIPTION("Fake FPGA Bridge");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/fpga/tests/fake-fpga-region.h b/drivers/fpga/tests/fake-fpga-region.h
new file mode 100644
index 000000000000..976982c192bc
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
+fake_fpga_region_register(struct fpga_manager *mgr, struct device *parent,
+			  struct kunit *test);
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
2.39.2


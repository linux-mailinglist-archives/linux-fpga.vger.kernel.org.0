Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B976E287D
	for <lists+linux-fpga@lfdr.de>; Fri, 14 Apr 2023 18:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjDNQh6 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 14 Apr 2023 12:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjDNQhl (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 14 Apr 2023 12:37:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CBA180
        for <linux-fpga@vger.kernel.org>; Fri, 14 Apr 2023 09:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681490208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kMb9o8GA5qaf/O6P/WTt8dwtDDJUMr/NJY9J2xItdGk=;
        b=LWyzvua6PxpqUF8miL7zSV1qGQn9xR/0W8lEpM7ZuvpCe14s+sxG57TYMuebBUPbawCZ4Z
        spyQM8sfm1lbDnaUsZvHMUWXLfMnLaZlaazCpHv5k8MuQ//mlsga+uuzMyVXnwEs5zQ7ur
        GRoGq6fSxSsFnn4E5ihvTfI6Dh940HM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-W1ahDhzVO5WWgPjRlsymCA-1; Fri, 14 Apr 2023 12:36:47 -0400
X-MC-Unique: W1ahDhzVO5WWgPjRlsymCA-1
Received: by mail-wm1-f70.google.com with SMTP id m4-20020a05600c3b0400b003f0968719a7so5492281wms.2
        for <linux-fpga@vger.kernel.org>; Fri, 14 Apr 2023 09:36:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681490206; x=1684082206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kMb9o8GA5qaf/O6P/WTt8dwtDDJUMr/NJY9J2xItdGk=;
        b=I9PmO6PsFchFZugyfc0P6HbmFKU3krVdbFnzzO79xlQeauoi6700swyn9f0VTQpr/8
         YUFBfPUdM75jBslbRGnhs2eyX2A+f2aCKQFE2aeWfhCnVk7HSVNxtVv9JBvgfCc5pMAt
         lDd+BizC1/nZHnnvjKLCvN+oAtz5Y+mPZTW0UQzLQcWx/SBHkiFfl1ls5IjXuIINtKhk
         h021Ftn+gYhMqzdzdw7wNw6EKsuhTuaS2toHLkxSmmfDRKevGhWYOp6BJF2S5LppiUrf
         Kw+P17hrJ1wDwrTGkJhEK31r4CzRjbiyNYYxCHjFErkMP4BNC4grqzZJ2uhwoaeOLJ6r
         SAIQ==
X-Gm-Message-State: AAQBX9dDSyTEMRcTF0ugsvI/AFJzo0G6MJWTJa627O2maB/gzFt6ryif
        4Nqu77cW76Gah8elly2hiBj5q4RQ/GpG8QG6VHaSNAV9QKvKbXYGXipBfvheY21pu8X2zQOld0N
        6PtI7sVvVzgvrp9wS/Twt
X-Received: by 2002:a1c:7706:0:b0:3ed:3033:496d with SMTP id t6-20020a1c7706000000b003ed3033496dmr4951385wmi.0.1681490205886;
        Fri, 14 Apr 2023 09:36:45 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZFNwYegLTP1Y5Y145IlEYT15uP8eriK8eqE8zeHtSXxOPKYYXaWO6jz8i0DyWPH6PPmzThnw==
X-Received: by 2002:a1c:7706:0:b0:3ed:3033:496d with SMTP id t6-20020a1c7706000000b003ed3033496dmr4951371wmi.0.1681490205612;
        Fri, 14 Apr 2023 09:36:45 -0700 (PDT)
Received: from klayman.redhat.com (net-2-34-29-20.cust.vodafonedsl.it. [2.34.29.20])
        by smtp.gmail.com with ESMTPSA id k21-20020a05600c1c9500b003ee74c25f12sm8312119wms.35.2023.04.14.09.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 09:36:44 -0700 (PDT)
From:   Marco Pagani <marpagan@redhat.com>
To:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
Cc:     Marco Pagani <marpagan@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: [RFC PATCH v3 3/4] fpga: add fake FPGA region
Date:   Fri, 14 Apr 2023 18:36:35 +0200
Message-Id: <20230414163636.236174-4-marpagan@redhat.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230414163636.236174-1-marpagan@redhat.com>
References: <20230414163636.236174-1-marpagan@redhat.com>
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
index 000000000000..25c0b140c6a7
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
+EXPORT_SYMBOL_GPL(fake_fpga_region_program)
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


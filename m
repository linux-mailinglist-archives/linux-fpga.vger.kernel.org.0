Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D82BD6B4E06
	for <lists+linux-fpga@lfdr.de>; Fri, 10 Mar 2023 18:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbjCJRHF (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 10 Mar 2023 12:07:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231781AbjCJRGn (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 10 Mar 2023 12:06:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 891A412D4B7
        for <linux-fpga@vger.kernel.org>; Fri, 10 Mar 2023 09:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678467863;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JO3sx9KQ7oN1zllI/65sQBKcfWX+lgrDYeSnCW02Np8=;
        b=QV6ylzYHdt/dN5tfq4rxkOApZOvWArtIt9EhjtXgYfj3gBf4AHTImUN+PNJXythUWhqVcn
        qMn48BpqM5xViQhYwVIWCIwQqr5K7lKNePHDHZNsVNpfVFcOWrM6CcDqKEgPa5/v9cXkE/
        D/1MogTR4sJLWMBhPG9G18EHUOlXnSM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-dNK7PEuCOeCOhHEkBuPn9w-1; Fri, 10 Mar 2023 12:04:22 -0500
X-MC-Unique: dNK7PEuCOeCOhHEkBuPn9w-1
Received: by mail-wm1-f71.google.com with SMTP id u19-20020a05600c00d300b003eb24ce58ceso2053624wmm.9
        for <linux-fpga@vger.kernel.org>; Fri, 10 Mar 2023 09:04:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678467861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JO3sx9KQ7oN1zllI/65sQBKcfWX+lgrDYeSnCW02Np8=;
        b=W7hsK2vlzQLOOAUan02vwtEYq+k4KIsoGbUmKYaSyPmyiGdjgaVCm6yqTajFpj60f7
         Vm5JYXDKm9vo3CZaFiG3MqoOTJXsuoQ5aobvrt0vNpoV5BcBYcK7gu6Fca1qj+X/7KdA
         sf/8kxTlMw0fD49CWPF4E7Vq9Cpyk1MBWmwj7YusoYqzf2RunvR52vzUfnvMPDwBxM6H
         k3asYXtqhuoHitbT+LLrZAcBOc5kWyUj4wSQ3fiz91swp1if+stDUrQX3igwMYLSKm+/
         NDVIze3xPTyJHN//vTsyB7B89tIxIlJBvPU1QJdQssZ7/ERTCWeI3IKjvRZXw/ob6zBF
         lbKg==
X-Gm-Message-State: AO0yUKUz2fv3QLlYv0THaSBx8NMLwVFHIPqqS4qURhPFaeFNXilwwaSg
        IQ+1BFiHw6yCe6pOMJ6xrSdFW0fZxgqfNrBVegkdsHkckCAoaCdn47M6bBPi/VL9hnyHwbkQ6AC
        z448DTSaWsmSXRF37CCce
X-Received: by 2002:a05:600c:4ed0:b0:3e2:20c7:6553 with SMTP id g16-20020a05600c4ed000b003e220c76553mr3538243wmq.13.1678467860799;
        Fri, 10 Mar 2023 09:04:20 -0800 (PST)
X-Google-Smtp-Source: AK7set8a/X2ECIxxtoj7k/lA29GXntDuLn/Pxfde/l4NVEEffAwWazr4tc8sD3zBnvX62xHsbuY1vg==
X-Received: by 2002:a05:600c:4ed0:b0:3e2:20c7:6553 with SMTP id g16-20020a05600c4ed000b003e220c76553mr3538218wmq.13.1678467860569;
        Fri, 10 Mar 2023 09:04:20 -0800 (PST)
Received: from klayman.redhat.com (net-2-34-29-20.cust.vodafonedsl.it. [2.34.29.20])
        by smtp.gmail.com with ESMTPSA id u10-20020a05600c00ca00b003eb192787bfsm417294wmm.25.2023.03.10.09.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 09:04:20 -0800 (PST)
From:   Marco Pagani <marpagan@redhat.com>
To:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
Cc:     Marco Pagani <marpagan@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: [RFC PATCH v2 3/4] fpga: add fake FPGA region
Date:   Fri, 10 Mar 2023 18:04:11 +0100
Message-Id: <20230310170412.708363-4-marpagan@redhat.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230310170412.708363-1-marpagan@redhat.com>
References: <20230310170412.708363-1-marpagan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Add fake FPGA region platform driver with support functions. This
module is part of the KUnit tests for the FPGA subsystem.

Signed-off-by: Marco Pagani <marpagan@redhat.com>
---
 drivers/fpga/tests/fake-fpga-region.c | 219 ++++++++++++++++++++++++++
 drivers/fpga/tests/fake-fpga-region.h |  38 +++++
 2 files changed, 257 insertions(+)
 create mode 100644 drivers/fpga/tests/fake-fpga-region.c
 create mode 100644 drivers/fpga/tests/fake-fpga-region.h

diff --git a/drivers/fpga/tests/fake-fpga-region.c b/drivers/fpga/tests/fake-fpga-region.c
new file mode 100644
index 000000000000..54d0e564728b
--- /dev/null
+++ b/drivers/fpga/tests/fake-fpga-region.c
@@ -0,0 +1,219 @@
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
+struct fake_region_data {
+	struct fpga_manager *mgr;
+	struct kunit *test;
+};
+
+/**
+ * fake_fpga_region_register() - register a fake FPGA region.
+ * @region_ctx: fake FPGA region context data structure.
+ * @mgr: associated FPGA manager.
+ * @parent: parent device.
+ * @test: KUnit test context object.
+ *
+ * Return: 0 if registration succeeded, an error code otherwise.
+ */
+int fake_fpga_region_register(struct fake_fpga_region *region_ctx,
+			      struct fpga_manager *mgr, struct device *parent,
+			      struct kunit *test)
+{
+	struct fake_region_data pdata;
+	struct fake_region_priv *priv;
+	int ret;
+
+	pdata.mgr = mgr;
+	pdata.test = test;
+
+	region_ctx->pdev = platform_device_alloc(FAKE_FPGA_REGION_DEV_NAME,
+						 PLATFORM_DEVID_AUTO);
+	if (IS_ERR(region_ctx->pdev)) {
+		pr_err("Fake FPGA region device allocation failed\n");
+		return -ENOMEM;
+	}
+
+	region_ctx->pdev->dev.parent = parent;
+	platform_device_add_data(region_ctx->pdev, &pdata, sizeof(pdata));
+
+	ret = platform_device_add(region_ctx->pdev);
+	if (ret) {
+		pr_err("Fake FPGA region device add failed\n");
+		platform_device_put(region_ctx->pdev);
+		return ret;
+	}
+
+	region_ctx->region = platform_get_drvdata(region_ctx->pdev);
+
+	if (test) {
+		priv = region_ctx->region->priv;
+		kunit_info(test, "Fake FPGA region %d registered\n", priv->id);
+	}
+
+	return 0;
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
+void fake_fpga_region_add_bridge(struct fake_fpga_region *region_ctx,
+				 struct fpga_bridge *bridge)
+{
+	struct fake_region_priv *priv;
+
+	priv = region_ctx->region->priv;
+
+	/* Add bridge to the list of bridges in the private context */
+	list_add(&bridge->node, &priv->bridge_list);
+
+	if (priv->test)
+		kunit_info(priv->test, "Bridge added to fake FPGA region %d\n",
+			   priv->id);
+}
+EXPORT_SYMBOL_GPL(fake_fpga_region_add_bridge);
+
+static int fake_region_get_bridges(struct fpga_region *region)
+{
+	struct fake_region_priv *priv;
+	struct fpga_bridge *bridge, *tmp;
+	int ret;
+
+	priv = region->priv;
+
+	list_for_each_entry_safe(bridge, tmp, &priv->bridge_list, node) {
+		list_del(&bridge->node);
+		ret = fpga_bridge_get_to_list(bridge->dev.parent,
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
+	fpga_bridges_put(&region->bridge_list);
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
index 000000000000..9268ca335662
--- /dev/null
+++ b/drivers/fpga/tests/fake-fpga-region.h
@@ -0,0 +1,38 @@
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
+int fake_fpga_region_register(struct fake_fpga_region *region_ctx,
+			      struct fpga_manager *mgr, struct device *parent,
+			      struct kunit *test);
+
+void fake_fpga_region_add_bridge(struct fake_fpga_region *region_ctx,
+				 struct fpga_bridge *bridge);
+
+void fake_fpga_region_unregister(struct fake_fpga_region *region_ctx);
+
+#endif /* __FPGA_FAKE_RGN_H */
-- 
2.39.2


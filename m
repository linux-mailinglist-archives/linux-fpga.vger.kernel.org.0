Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 063F6689FFE
	for <lists+linux-fpga@lfdr.de>; Fri,  3 Feb 2023 18:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233387AbjBCRIR (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 3 Feb 2023 12:08:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233068AbjBCRIO (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 3 Feb 2023 12:08:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC2DA9D48
        for <linux-fpga@vger.kernel.org>; Fri,  3 Feb 2023 09:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675444039;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nXijhy+bLVt2oImSC5wDtd/ir3c5z1uIhiC8dhyhZro=;
        b=X06ttQ8KlPTVhyicR6iKpuLkV+4csxRITmp1NrJgQso21/MK8Fmw1m+a/UhTIkNXEDW14f
        Z1CEoat9igZFUTfHbgL7yKJxiStRsaWzb5u3D3hPcbdDpsyyKk4doMyEjkvDLyPqapZCT0
        GQreuOCBV1vWdcZoetdzyT69LAuRtQ8=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-433-BP9-zXKPMSizziC9GxrtQw-1; Fri, 03 Feb 2023 12:07:18 -0500
X-MC-Unique: BP9-zXKPMSizziC9GxrtQw-1
Received: by mail-qt1-f199.google.com with SMTP id l3-20020a05622a174300b003b9b6101f65so2942755qtk.11
        for <linux-fpga@vger.kernel.org>; Fri, 03 Feb 2023 09:07:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nXijhy+bLVt2oImSC5wDtd/ir3c5z1uIhiC8dhyhZro=;
        b=rIV48J3k63H+pK3Q/Xw+cDpGgQMRIbcmCykoSTVwwjOLbOcCi5wl9l8Ot4MJOeb9X/
         GEEa5f4RYzMrqPqSSinv7qhXEE1adisVVl34SoBhfytE2mTVOHFXkmlUDc/pWs2jSp4g
         qedW2Ap70q/c4t8aig8gLnne9AOoRxDBj6ETTBR2rHk2CLZVkXtx9pzWgwmStDmvw98Z
         NAAFlWfVoKB2il3NG27k85mRD56ddnKPm2/FZ/yJkSFSgu+rWSY6+uQEkIjQTiUCAQ0i
         HgsRoOC+UP+/z7TEpdtV5d82T6VtWnoldwxou0e4m+Hm77ZZ0ck/9IwhEsckMYTLWPVc
         KGZQ==
X-Gm-Message-State: AO0yUKU2ptreIC/mviWZlv6HpT/f6Hh3pmtXf3G4R/t5Yyh1kf0B2BUQ
        Qt3rMdvZn6oFceAiPhmso/9CTbtJ6uWo+USV+bKnn88+BmSfuzoaDp+/CCwT1esUNG6XepIrpQa
        hf4l6XqdhO2s998oDDJtp
X-Received: by 2002:a05:622a:24e:b0:3a9:8cc6:d4b2 with SMTP id c14-20020a05622a024e00b003a98cc6d4b2mr9749346qtx.5.1675444038085;
        Fri, 03 Feb 2023 09:07:18 -0800 (PST)
X-Google-Smtp-Source: AK7set93MmWHhJVO/vDfU+RgYuWcx9JCpyyECVBzD234/JkYM24DN0DejklXMjtE26rBQV2BTbxlaQ==
X-Received: by 2002:a05:622a:24e:b0:3a9:8cc6:d4b2 with SMTP id c14-20020a05622a024e00b003a98cc6d4b2mr9749315qtx.5.1675444037771;
        Fri, 03 Feb 2023 09:07:17 -0800 (PST)
Received: from klayman.redhat.com (net-2-34-30-183.cust.vodafonedsl.it. [2.34.30.183])
        by smtp.gmail.com with ESMTPSA id b13-20020ac801cd000000b003a6a19ee4f0sm1884287qtg.33.2023.02.03.09.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 09:07:17 -0800 (PST)
From:   Marco Pagani <marpagan@redhat.com>
To:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
Cc:     Marco Pagani <marpagan@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: [RFC PATCH 2/4] fpga: add fake FPGA region
Date:   Fri,  3 Feb 2023 18:06:51 +0100
Message-Id: <20230203170653.414990-3-marpagan@redhat.com>
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

Add fake FPGA region platform driver with support functions. This
module is part of the KUnit test suite for the FPGA subsystem.

Signed-off-by: Marco Pagani <marpagan@redhat.com>
---
 drivers/fpga/tests/fake-fpga-region.c | 186 ++++++++++++++++++++++++++
 drivers/fpga/tests/fake-fpga-region.h |  37 +++++
 2 files changed, 223 insertions(+)
 create mode 100644 drivers/fpga/tests/fake-fpga-region.c
 create mode 100644 drivers/fpga/tests/fake-fpga-region.h

diff --git a/drivers/fpga/tests/fake-fpga-region.c b/drivers/fpga/tests/fake-fpga-region.c
new file mode 100644
index 000000000000..095397e41837
--- /dev/null
+++ b/drivers/fpga/tests/fake-fpga-region.c
@@ -0,0 +1,186 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for fake FPGA region
+ *
+ * Copyright (C) 2023 Red Hat, Inc. All rights reserved.
+ *
+ * Author: Marco Pagani <marpagan@redhat.com>
+ */
+
+#include <linux/device.h>
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
+};
+
+struct fake_region_data {
+	struct fpga_manager *mgr;
+	struct kunit *test;
+};
+
+/**
+ * fake_fpga_region_register - register a fake FPGA region
+ * @region_ctx: fake FPGA region context data structure.
+ * @test: KUnit test context object.
+ *
+ * Return: 0 if registration succeeded, an error code otherwise.
+ */
+int fake_fpga_region_register(struct fake_fpga_region *region_ctx,
+			      struct fpga_manager *mgr, struct kunit *test)
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
+ * fake_fpga_region_unregister - unregister a fake FPGA region
+ * @region_ctx: fake FPGA region context data structure.
+ */
+void fake_fpga_region_unregister(struct fake_fpga_region *region_ctx)
+{
+	struct fake_region_priv *priv;
+	struct kunit *test;
+	int id;
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
+ * fake_fpga_region_add_bridge - add a bridge to a fake FPGA region
+ * @region_ctx: fake FPGA region context data structure.
+ * @bridge: FPGA bridge.
+ *
+ * Return: 0 if registration succeeded, an error code otherwise.
+ */
+int fake_fpga_region_add_bridge(struct fake_fpga_region *region_ctx,
+				struct fpga_bridge *bridge)
+{
+	struct fake_region_priv *priv;
+	int ret;
+
+	priv = region_ctx->region->priv;
+
+	ret = fpga_bridge_get_to_list(bridge->dev.parent, NULL,
+				      &region_ctx->region->bridge_list);
+
+	if (priv->test && !ret)
+		kunit_info(priv->test, "Bridge added to fake FPGA region %d\n",
+			   priv->id);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(fake_fpga_region_add_bridge);
+
+static int fake_fpga_region_probe(struct platform_device *pdev)
+{
+	struct device *dev;
+	struct fpga_region *region;
+	struct fpga_manager *mgr;
+	struct fake_region_data *pdata;
+	struct fake_region_priv *priv;
+	static int id_count;
+
+	dev = &pdev->dev;
+	pdata = dev_get_platdata(dev);
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	mgr = fpga_mgr_get(pdata->mgr->dev.parent);
+	if (IS_ERR(mgr))
+		return PTR_ERR(mgr);
+
+	/*
+	 * No get_bridges() method since the bridges list is
+	 * pre-built using fake_fpga_region_add_bridge()
+	 */
+	region = fpga_region_register(dev, mgr, NULL);
+	if (IS_ERR(region)) {
+		fpga_mgr_put(mgr);
+		return PTR_ERR(region);
+	}
+
+	priv->test = pdata->test;
+	priv->id = id_count++;
+	region->priv = priv;
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
index 000000000000..55b2df3f04ba
--- /dev/null
+++ b/drivers/fpga/tests/fake-fpga-region.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Header file for fake FPGA region
+ *
+ * Copyright (C) 2023 Red Hat, Inc. All rights reserved.
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
+			      struct fpga_manager *mgr, struct kunit *test);
+
+int fake_fpga_region_add_bridge(struct fake_fpga_region *region_ctx,
+				struct fpga_bridge *bridge);
+
+void fake_fpga_region_unregister(struct fake_fpga_region *region_ctx);
+
+#endif /* __FPGA_FAKE_RGN_H */
-- 
2.39.1


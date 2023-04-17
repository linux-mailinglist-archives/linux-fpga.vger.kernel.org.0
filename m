Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34D706E47A2
	for <lists+linux-fpga@lfdr.de>; Mon, 17 Apr 2023 14:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbjDQMZg (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 17 Apr 2023 08:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbjDQMZ0 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 17 Apr 2023 08:25:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00ED65257
        for <linux-fpga@vger.kernel.org>; Mon, 17 Apr 2023 05:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681734198;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nQ42dcQvki9IfHxndNIcUE+MqFzkjDsdNaPpQ6RElBw=;
        b=e1tazDHe2T6d418xApDodMnV7zhPZePg4W8niW3dHYAXYlajGIy+jjDZA2a+rlmWlWL4w3
        CAu+GaJhmKy/desU6Zstts2AsCpKfs59m3cmNAc0yVDQEcMy32q6hY5cVUkJX3YFGA6I7l
        ohs94Q7yKiDuqgWZHoqxRal2FbSfW3Q=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-PjtTI-9xPvmY1HtHqWGpZA-1; Mon, 17 Apr 2023 08:23:16 -0400
X-MC-Unique: PjtTI-9xPvmY1HtHqWGpZA-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5068e922bcaso832388a12.1
        for <linux-fpga@vger.kernel.org>; Mon, 17 Apr 2023 05:23:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681734195; x=1684326195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nQ42dcQvki9IfHxndNIcUE+MqFzkjDsdNaPpQ6RElBw=;
        b=Gmu3xBMb6AntJFRqP7VgvdVFtJ0ZiO8a59u6LqhTN0Q6pC5ZYRASeuVT1vG8Lwb1SL
         bTHYotbKsojYzcpQwSxbVkvM2w25phbuEBsEObBnFjQc56oqBfJkSFoXnpds/TIud6Qn
         OzZWDb8Ckh3oBpZpv8K1lhwbrtbLFRapVoXh4SO6K1kjZ0JlbtF/d9aZCCFaQr13+XzG
         aA/hgr4bdhfTD3s9qfc7WIeXLNfyY+vPx1XBwKUHvksTaVBF5JMunEcW+mPPRoFxRLmk
         VG11QFXZ3J+oYtY1t4ZBjbRViJCHQJ3oEwod7Fl8FBRYLLjtuDXSjhVCNeA0y0KF93Pr
         /y8g==
X-Gm-Message-State: AAQBX9dnQMiTBSNKemI8DlJcySLUve/aR8VJwb/GMU/yJoiQ0qYuQoyH
        2+OLV9BmdxLy/6b1KCiqU/uP4BmAtTrR9FhAzkpsLSfAUbiY8nPDgK0uWgGCuWXpBVRb04hofQL
        69JeTJPN0Z8qfhVYK3wUF
X-Received: by 2002:aa7:c79a:0:b0:506:af22:1271 with SMTP id n26-20020aa7c79a000000b00506af221271mr1352662eds.0.1681734195520;
        Mon, 17 Apr 2023 05:23:15 -0700 (PDT)
X-Google-Smtp-Source: AKy350b840itZTrJjuBKu9hRqJjRfC3ji23pWETtYNRuyF5SslQgbczA/v4Zo8zRfe2cFCeQmcatFQ==
X-Received: by 2002:aa7:c79a:0:b0:506:af22:1271 with SMTP id n26-20020aa7c79a000000b00506af221271mr1352639eds.0.1681734195083;
        Mon, 17 Apr 2023 05:23:15 -0700 (PDT)
Received: from klayman.. ([37.163.248.182])
        by smtp.gmail.com with ESMTPSA id q21-20020aa7cc15000000b004fbf6b35a56sm5756618edt.76.2023.04.17.05.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 05:23:14 -0700 (PDT)
From:   Marco Pagani <marpagan@redhat.com>
To:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
Cc:     Marco Pagani <marpagan@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: [RFC PATCH v4 1/4] fpga: add fake FPGA manager
Date:   Mon, 17 Apr 2023 14:23:05 +0200
Message-Id: <20230417122308.131453-2-marpagan@redhat.com>
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

Add fake FPGA manager platform driver with support functions.
The driver checks the programming sequence using KUnit expectations.
This module is part of the KUnit tests for the FPGA subsystem.

Signed-off-by: Marco Pagani <marpagan@redhat.com>
---
 drivers/fpga/tests/fake-fpga-mgr.c | 386 +++++++++++++++++++++++++++++
 drivers/fpga/tests/fake-fpga-mgr.h |  43 ++++
 2 files changed, 429 insertions(+)
 create mode 100644 drivers/fpga/tests/fake-fpga-mgr.c
 create mode 100644 drivers/fpga/tests/fake-fpga-mgr.h

diff --git a/drivers/fpga/tests/fake-fpga-mgr.c b/drivers/fpga/tests/fake-fpga-mgr.c
new file mode 100644
index 000000000000..636df637b291
--- /dev/null
+++ b/drivers/fpga/tests/fake-fpga-mgr.c
@@ -0,0 +1,386 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for the fake FPGA manager
+ *
+ * Copyright (C) 2023 Red Hat, Inc.
+ *
+ * Author: Marco Pagani <marpagan@redhat.com>
+ */
+
+#include <linux/types.h>
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <linux/fpga/fpga-mgr.h>
+#include <kunit/test.h>
+
+#include "fake-fpga-mgr.h"
+
+#define FAKE_FPGA_MGR_DEV_NAME	"fake_fpga_mgr"
+
+#define FAKE_HEADER_BYTE	0x3f
+#define FAKE_HEADER_SIZE	FPGA_IMG_BLOCK
+
+struct fake_mgr_priv {
+	int rcfg_count;
+	bool op_parse_header;
+	bool op_write_init;
+	bool op_write;
+	bool op_write_sg;
+	bool op_write_complete;
+	struct kunit *test;
+};
+
+struct fake_mgr_data {
+	struct kunit *test;
+};
+
+static void check_header(struct kunit *test, const u8 *buf);
+
+static enum fpga_mgr_states op_state(struct fpga_manager *mgr)
+{
+	struct fake_mgr_priv *priv;
+
+	priv = mgr->priv;
+
+	if (priv->test)
+		kunit_info(priv->test, "Fake FPGA manager: state\n");
+
+	return FPGA_MGR_STATE_UNKNOWN;
+}
+
+static u64 op_status(struct fpga_manager *mgr)
+{
+	struct fake_mgr_priv *priv;
+
+	priv = mgr->priv;
+
+	if (priv->test)
+		kunit_info(priv->test, "Fake FPGA manager: status\n");
+
+	return 0;
+}
+
+static int op_parse_header(struct fpga_manager *mgr, struct fpga_image_info *info,
+			   const char *buf, size_t count)
+{
+	struct fake_mgr_priv *priv;
+
+	priv = mgr->priv;
+
+	if (priv->test) {
+		kunit_info(priv->test, "Fake FPGA manager: parse_header\n");
+
+		KUNIT_EXPECT_EQ(priv->test, mgr->state,
+				FPGA_MGR_STATE_PARSE_HEADER);
+
+		check_header(priv->test, buf);
+	}
+
+	priv->op_parse_header = true;
+
+	return 0;
+}
+
+static int op_write_init(struct fpga_manager *mgr, struct fpga_image_info *info,
+			 const char *buf, size_t count)
+{
+	struct fake_mgr_priv *priv;
+
+	priv = mgr->priv;
+
+	if (priv->test) {
+		kunit_info(priv->test, "Fake FPGA manager: write_init\n");
+
+		KUNIT_EXPECT_EQ(priv->test, mgr->state,
+				FPGA_MGR_STATE_WRITE_INIT);
+	}
+
+	priv->op_write_init = true;
+
+	return 0;
+}
+
+static int op_write(struct fpga_manager *mgr, const char *buf, size_t count)
+{
+	struct fake_mgr_priv *priv;
+
+	priv = mgr->priv;
+
+	if (priv->test) {
+		kunit_info(priv->test, "Fake FPGA manager: write\n");
+
+		KUNIT_EXPECT_EQ(priv->test, mgr->state,
+				FPGA_MGR_STATE_WRITE);
+	}
+
+	priv->op_write = true;
+
+	return 0;
+}
+
+static int op_write_sg(struct fpga_manager *mgr, struct sg_table *sgt)
+{
+	struct fake_mgr_priv *priv;
+
+	priv = mgr->priv;
+
+	if (priv->test) {
+		kunit_info(priv->test, "Fake FPGA manager: write_sg\n");
+
+		KUNIT_EXPECT_EQ(priv->test, mgr->state,
+				FPGA_MGR_STATE_WRITE);
+	}
+
+	priv->op_write_sg = true;
+
+	return 0;
+}
+
+static int op_write_complete(struct fpga_manager *mgr, struct fpga_image_info *info)
+{
+	struct fake_mgr_priv *priv;
+
+	priv = mgr->priv;
+
+	if (priv->test) {
+		kunit_info(priv->test, "Fake FPGA manager: write_complete\n");
+
+		KUNIT_EXPECT_EQ(priv->test, mgr->state,
+				FPGA_MGR_STATE_WRITE_COMPLETE);
+	}
+
+	priv->op_write_complete = true;
+	priv->rcfg_count++;
+
+	return 0;
+}
+
+static void op_fpga_remove(struct fpga_manager *mgr)
+{
+	struct fake_mgr_priv *priv;
+
+	priv = mgr->priv;
+
+	if (priv->test)
+		kunit_info(priv->test, "Fake FPGA manager: remove\n");
+}
+
+static const struct fpga_manager_ops fake_fpga_mgr_ops = {
+	.initial_header_size = FAKE_HEADER_SIZE,
+	.skip_header = false,
+	.state = op_state,
+	.status = op_status,
+	.parse_header = op_parse_header,
+	.write_init = op_write_init,
+	.write = op_write,
+	.write_sg = op_write_sg,
+	.write_complete = op_write_complete,
+	.fpga_remove = op_fpga_remove,
+};
+
+/**
+ * fake_fpga_mgr_register() - register a fake FPGA manager.
+ * @mgr_ctx: fake FPGA manager context data structure.
+ * @test: KUnit test context object.
+ *
+ * Return: pointer to a new fake FPGA manager on success, an ERR_PTR()
+ * encoded error code on failure.
+ */
+struct fake_fpga_mgr *
+fake_fpga_mgr_register(struct kunit *test, struct device *parent)
+{
+	struct fake_fpga_mgr *mgr_ctx;
+	struct fake_mgr_data pdata;
+	int ret;
+
+	mgr_ctx = kzalloc(sizeof(*mgr_ctx), GFP_KERNEL);
+	if (!mgr_ctx) {
+		ret = -ENOMEM;
+		goto err_mem;
+	}
+
+	mgr_ctx->pdev = platform_device_alloc(FAKE_FPGA_MGR_DEV_NAME,
+					      PLATFORM_DEVID_AUTO);
+	if (!mgr_ctx->pdev) {
+		pr_err("Fake FPGA manager device allocation failed\n");
+		ret = -ENOMEM;
+		goto err_mem;
+	}
+
+	pdata.test = test;
+	platform_device_add_data(mgr_ctx->pdev, &pdata, sizeof(pdata));
+
+	mgr_ctx->pdev->dev.parent = parent;
+	ret = platform_device_add(mgr_ctx->pdev);
+	if (ret) {
+		pr_err("Fake FPGA manager device add failed\n");
+		goto err_pdev;
+	}
+
+	mgr_ctx->mgr = platform_get_drvdata(mgr_ctx->pdev);
+
+	if (test)
+		kunit_info(test, "Fake FPGA manager registered\n");
+
+	return mgr_ctx;
+
+err_pdev:
+	platform_device_put(mgr_ctx->pdev);
+	kfree(mgr_ctx);
+err_mem:
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL_GPL(fake_fpga_mgr_register);
+
+/**
+ * fake_fpga_mgr_unregister() - unregister a fake FPGA manager.
+ * @mgr_ctx: fake FPGA manager context data structure.
+ */
+void fake_fpga_mgr_unregister(struct fake_fpga_mgr *mgr_ctx)
+{
+	struct fake_mgr_priv *priv;
+	struct kunit *test;
+
+	if (!mgr_ctx)
+		return;
+
+	priv = mgr_ctx->mgr->priv;
+	test = priv->test;
+
+	if (mgr_ctx->pdev) {
+		platform_device_unregister(mgr_ctx->pdev);
+		if (test)
+			kunit_info(test, "Fake FPGA manager unregistered\n");
+	}
+
+	kfree(mgr_ctx);
+}
+EXPORT_SYMBOL_GPL(fake_fpga_mgr_unregister);
+
+/**
+ * fake_fpga_mgr_get_rcfg_count() - get the number of reconfigurations.
+ * @mgr_ctx: fake FPGA manager context data structure.
+ *
+ * Return: number of reconfigurations.
+ */
+int fake_fpga_mgr_get_rcfg_count(const struct fake_fpga_mgr *mgr_ctx)
+{
+	struct fake_mgr_priv *priv;
+
+	priv = mgr_ctx->mgr->priv;
+
+	return priv->rcfg_count;
+}
+EXPORT_SYMBOL_GPL(fake_fpga_mgr_get_rcfg_count);
+
+/**
+ * fake_fpga_mgr_fill_header() - fill an image buffer with the test header.
+ * @buf: image buffer.
+ */
+void fake_fpga_mgr_fill_header(u8 *buf)
+{
+	int i;
+
+	for (i = 0; i < FAKE_HEADER_SIZE; i++)
+		buf[i] = FAKE_HEADER_BYTE;
+}
+EXPORT_SYMBOL_GPL(fake_fpga_mgr_fill_header);
+
+static void check_header(struct kunit *test, const u8 *buf)
+{
+	int i;
+
+	for (i = 0; i < FAKE_HEADER_SIZE; i++)
+		KUNIT_EXPECT_EQ(test, buf[i], FAKE_HEADER_BYTE);
+}
+
+static void clear_op_flags(struct fake_mgr_priv *priv)
+{
+	priv->op_parse_header = false;
+	priv->op_write_init = false;
+	priv->op_write = false;
+	priv->op_write_sg = false;
+	priv->op_write_complete = false;
+}
+
+/**
+ * fake_fpga_mgr_check_write_buf() - check if programming using a buffer succeeded.
+ * @mgr_ctx: fake FPGA manager context data structure.
+ */
+void fake_fpga_mgr_check_write_buf(struct fake_fpga_mgr *mgr_ctx)
+{
+	struct fake_mgr_priv *priv;
+
+	priv = mgr_ctx->mgr->priv;
+
+	if (priv->test) {
+		KUNIT_EXPECT_EQ(priv->test, priv->op_parse_header, true);
+		KUNIT_EXPECT_EQ(priv->test, priv->op_write_init, true);
+		KUNIT_EXPECT_EQ(priv->test, priv->op_write, true);
+		KUNIT_EXPECT_EQ(priv->test, priv->op_write_complete, true);
+	}
+
+	clear_op_flags(priv);
+}
+EXPORT_SYMBOL_GPL(fake_fpga_mgr_check_write_buf);
+
+/**
+ * fake_fpga_mgr_check_write_sgt() - check if programming using a s.g. table succeeded.
+ * @mgr_ctx: fake FPGA manager context data structure.
+ */
+void fake_fpga_mgr_check_write_sgt(struct fake_fpga_mgr *mgr_ctx)
+{
+	struct fake_mgr_priv *priv;
+
+	priv = mgr_ctx->mgr->priv;
+
+	if (priv->test) {
+		KUNIT_EXPECT_EQ(priv->test, priv->op_parse_header, true);
+		KUNIT_EXPECT_EQ(priv->test, priv->op_write_init, true);
+		KUNIT_EXPECT_EQ(priv->test, priv->op_write_sg, true);
+		KUNIT_EXPECT_EQ(priv->test, priv->op_write_complete, true);
+	}
+
+	clear_op_flags(priv);
+}
+EXPORT_SYMBOL_GPL(fake_fpga_mgr_check_write_sgt);
+
+static int fake_fpga_mgr_probe(struct platform_device *pdev)
+{
+	struct device *dev;
+	struct fake_mgr_priv *priv;
+	struct fake_mgr_data *pdata;
+	struct fpga_manager *mgr;
+
+	dev = &pdev->dev;
+	pdata = dev_get_platdata(dev);
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	if (pdata)
+		priv->test = pdata->test;
+
+	mgr = devm_fpga_mgr_register(dev, "Fake FPGA Manager",
+				     &fake_fpga_mgr_ops, priv);
+	if (IS_ERR(mgr))
+		return PTR_ERR(mgr);
+
+	platform_set_drvdata(pdev, mgr);
+
+	return 0;
+}
+
+static struct platform_driver fake_fpga_mgr_drv = {
+	.driver = {
+		.name = FAKE_FPGA_MGR_DEV_NAME
+	},
+	.probe = fake_fpga_mgr_probe,
+};
+
+module_platform_driver(fake_fpga_mgr_drv);
+
+MODULE_AUTHOR("Marco Pagani <marpagan@redhat.com>");
+MODULE_DESCRIPTION("Fake FPGA Manager");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/fpga/tests/fake-fpga-mgr.h b/drivers/fpga/tests/fake-fpga-mgr.h
new file mode 100644
index 000000000000..453672b5df72
--- /dev/null
+++ b/drivers/fpga/tests/fake-fpga-mgr.h
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Header file for the fake FPGA manager
+ *
+ * Copyright (C) 2023 Red Hat, Inc.
+ *
+ * Author: Marco Pagani <marpagan@redhat.com>
+ */
+
+#ifndef __FPGA_FAKE_MGR_H
+#define __FPGA_FAKE_MGR_H
+
+#include <linux/fpga/fpga-mgr.h>
+#include <linux/platform_device.h>
+#include <kunit/test.h>
+
+#define FPGA_IMG_BLOCK	1024
+
+/**
+ * struct fake_fpga_mgr - fake FPGA manager context data structure
+ *
+ * @mgr: FPGA manager.
+ * @pdev: platform device of the FPGA manager.
+ */
+struct fake_fpga_mgr {
+	struct fpga_manager *mgr;
+	struct platform_device *pdev;
+};
+
+struct fake_fpga_mgr *
+fake_fpga_mgr_register(struct kunit *test, struct device *parent);
+
+void fake_fpga_mgr_unregister(struct fake_fpga_mgr *mgr_ctx);
+
+int fake_fpga_mgr_get_rcfg_count(const struct fake_fpga_mgr *mgr_ctx);
+
+void fake_fpga_mgr_fill_header(u8 *buf);
+
+void fake_fpga_mgr_check_write_buf(struct fake_fpga_mgr *mgr_ctx);
+
+void fake_fpga_mgr_check_write_sgt(struct fake_fpga_mgr *mgr_ctx);
+
+#endif /* __FPGA_FAKE_MGR_H */
-- 
2.39.2


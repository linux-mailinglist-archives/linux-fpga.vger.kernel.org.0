Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B37BE6B4E0B
	for <lists+linux-fpga@lfdr.de>; Fri, 10 Mar 2023 18:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbjCJRHL (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 10 Mar 2023 12:07:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbjCJRGo (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 10 Mar 2023 12:06:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BDE81219FF
        for <linux-fpga@vger.kernel.org>; Fri, 10 Mar 2023 09:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678467861;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ar/llKR8abJ7wDatTJh3Vi/fK/K7kyCaNJ9z2TjsCKo=;
        b=SK6zOqpASh+ApF9xOhBjL02n+B/pj0522LsYPFHM7MvFsbMUaHro8mHok/YrZKGHzLSKFS
        4NrNRsm+y1uZNmHmKMPc+tUW85+qu6YoywHUzzXR9xbsi+JkimvbcAmg05ct2ua39IxrXw
        9pDrkOuU2Yo+cB8KppSG5PoBKxCEEfo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465--0DYnFSQMQ2IvyJjQtb0xA-1; Fri, 10 Mar 2023 12:04:20 -0500
X-MC-Unique: -0DYnFSQMQ2IvyJjQtb0xA-1
Received: by mail-wm1-f71.google.com with SMTP id k26-20020a05600c0b5a00b003dfe4bae099so2232222wmr.0
        for <linux-fpga@vger.kernel.org>; Fri, 10 Mar 2023 09:04:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678467859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ar/llKR8abJ7wDatTJh3Vi/fK/K7kyCaNJ9z2TjsCKo=;
        b=KvD1eDnCTcEHMK8WfkbJr/ap/6lOzSC6R0CP1brW2VxJa80MiwGv3VxIUmOcuujmvJ
         4056lyNRASa17up5/YgDh4/h4ML2eD3oEwepS2B2WUdfupEw2QvSQ9f0lSx2JV0v3SHb
         s2NX1QDLsmsC6gtYZB3hH7r3ahhqIYSrGW5nw11CbRuosaQcL+509kIw1VJC8qOpDxTS
         h65yyDPmZL4WZ44Snmq6x2B5Iu/Ub2ceKgxI3Pxkw3KpayG4HVkPmz2uAm6sv0zLCeO7
         TzPY4kgTC2YbSxzbmDddkx5wPgIZWkckeZkNZptSqh3BMHfgzz9v2u9p60K7oVLDcKBd
         vyTw==
X-Gm-Message-State: AO0yUKUtkqnCiHi6NAc6hlP/bDE66b+3qB0L4Z+DfcjtFg/XhnbPDccL
        SkF5CF1kikvB0eBUoY9M3ApLMbzT1jaGfColLouEM2ApV8IOTsMARBRRSbJCGc7hKxqhoMqZk0Y
        LvDzvwnnQ6RM4oTkmgNBC
X-Received: by 2002:a05:600c:314c:b0:3eb:2f06:c989 with SMTP id h12-20020a05600c314c00b003eb2f06c989mr3429929wmo.22.1678467858993;
        Fri, 10 Mar 2023 09:04:18 -0800 (PST)
X-Google-Smtp-Source: AK7set+tIYxi1AzLj8kiA0aj5ioueUBe+S7oZgbFeRh5QuBhQMhGIiJj8o5+Q8VMHV5n7D4Ms4Ixwg==
X-Received: by 2002:a05:600c:314c:b0:3eb:2f06:c989 with SMTP id h12-20020a05600c314c00b003eb2f06c989mr3429901wmo.22.1678467858683;
        Fri, 10 Mar 2023 09:04:18 -0800 (PST)
Received: from klayman.redhat.com (net-2-34-29-20.cust.vodafonedsl.it. [2.34.29.20])
        by smtp.gmail.com with ESMTPSA id u10-20020a05600c00ca00b003eb192787bfsm417294wmm.25.2023.03.10.09.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 09:04:18 -0800 (PST)
From:   Marco Pagani <marpagan@redhat.com>
To:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
Cc:     Marco Pagani <marpagan@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: [RFC PATCH v2 1/4] fpga: add fake FPGA manager
Date:   Fri, 10 Mar 2023 18:04:09 +0100
Message-Id: <20230310170412.708363-2-marpagan@redhat.com>
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

Add fake FPGA manager platform driver with support functions.
The driver checks the programming sequence using KUnit expectations.
This module is part of the KUnit tests for the FPGA subsystem.

Signed-off-by: Marco Pagani <marpagan@redhat.com>
---
 drivers/fpga/tests/fake-fpga-mgr.c | 369 +++++++++++++++++++++++++++++
 drivers/fpga/tests/fake-fpga-mgr.h |  42 ++++
 2 files changed, 411 insertions(+)
 create mode 100644 drivers/fpga/tests/fake-fpga-mgr.c
 create mode 100644 drivers/fpga/tests/fake-fpga-mgr.h

diff --git a/drivers/fpga/tests/fake-fpga-mgr.c b/drivers/fpga/tests/fake-fpga-mgr.c
new file mode 100644
index 000000000000..1bca6baeb0e5
--- /dev/null
+++ b/drivers/fpga/tests/fake-fpga-mgr.c
@@ -0,0 +1,369 @@
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
+ * Return: 0 if registration succeeded, an error code otherwise.
+ */
+int fake_fpga_mgr_register(struct fake_fpga_mgr *mgr_ctx, struct kunit *test)
+{
+	struct fake_mgr_data pdata;
+	int ret;
+
+	pdata.test = test;
+
+	mgr_ctx->pdev = platform_device_alloc(FAKE_FPGA_MGR_DEV_NAME,
+					      PLATFORM_DEVID_AUTO);
+	if (IS_ERR_OR_NULL(mgr_ctx->pdev)) {
+		pr_err("Fake FPGA manager device allocation failed\n");
+		return -ENOMEM;
+	}
+
+	platform_device_add_data(mgr_ctx->pdev, &pdata, sizeof(pdata));
+
+	ret = platform_device_add(mgr_ctx->pdev);
+	if (ret) {
+		pr_err("Fake FPGA manager device add failed\n");
+		platform_device_put(mgr_ctx->pdev);
+		return ret;
+	}
+
+	mgr_ctx->mgr = platform_get_drvdata(mgr_ctx->pdev);
+
+	if (test)
+		kunit_info(test, "Fake FPGA manager registered\n");
+
+	return 0;
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
index 000000000000..3778cbf594bc
--- /dev/null
+++ b/drivers/fpga/tests/fake-fpga-mgr.h
@@ -0,0 +1,42 @@
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
+int fake_fpga_mgr_register(struct fake_fpga_mgr *mgr_ctx, struct kunit *test);
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


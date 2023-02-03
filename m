Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0352689FFF
	for <lists+linux-fpga@lfdr.de>; Fri,  3 Feb 2023 18:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233620AbjBCRI3 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 3 Feb 2023 12:08:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233412AbjBCRIV (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 3 Feb 2023 12:08:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC72A7788
        for <linux-fpga@vger.kernel.org>; Fri,  3 Feb 2023 09:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675444047;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n/LlZDn23HB324SQHQ+0J+ByiKAzljtqAhnLrmeqO/k=;
        b=BjYdFmn3856HUHIcX1q5uUqYp/oABM9GrhHbtj8WMH1UIyU6qBIbFjFo7ijd3pK5YDPqzT
        ImFWDL2gsqHcbBP9FSmvua85JhTGu735XJHWJO05JPwux8mRZ7jzlqpc9loliJmORPXcPe
        04dXTIHf8dj+LckOT8YwTHputHz+dnk=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-118-QUnckzl-O4eFszdwStuY7g-1; Fri, 03 Feb 2023 12:07:24 -0500
X-MC-Unique: QUnckzl-O4eFszdwStuY7g-1
Received: by mail-qk1-f197.google.com with SMTP id 130-20020a370588000000b0072fcbe20069so655469qkf.22
        for <linux-fpga@vger.kernel.org>; Fri, 03 Feb 2023 09:07:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n/LlZDn23HB324SQHQ+0J+ByiKAzljtqAhnLrmeqO/k=;
        b=8PKApWZGRoqsRqPHKEvGkAHqaduAX8UuB2pkkOwRwMTX7vsQ17sL079+VuIZzNzyZL
         Z99oXrC27vJGjNR8vBlZbvGSv8zm/gvre8eiUlBkMOxNjW3S5M7ePh6QJyS6LcU8gq3i
         0T8CNDE09rM4yB6vZVtdVmjFwuyF2ItBM6MVybNF6MeJv6oWE+5OIZ45SbqEw2Y23crF
         6evLZxY1pPvyJDi1W21HibRxfi1owIfo0Fb5nHc1dgo0S79uB/wibwsS+ETRhvP6szHC
         wh+4bw6KBBg2QNRJLArrR5CC74EEkYn3Ucww4UhWgy8xWMU/ZniON8k9cMXu+Cpvvt0z
         Xd6g==
X-Gm-Message-State: AO0yUKU9uDtHbZQPKLmIFD1Zvd5BWZb9jkHw0JlV2INAtVr+594M1/cl
        KA+27/KPFBiNGz3IIiqrYGec6NJl3X+Lh8AjEzHETM2afsbqHGyxXdGxzvLgbkn31ddB8DgtoFU
        DTw8xo6g1FlEDMmb3x8ib
X-Received: by 2002:a05:6214:411a:b0:56a:eea2:9361 with SMTP id kc26-20020a056214411a00b0056aeea29361mr1622124qvb.31.1675444039917;
        Fri, 03 Feb 2023 09:07:19 -0800 (PST)
X-Google-Smtp-Source: AK7set9cGKgBgCh7EecMUjgYhNdUPt9dhzc6F9lAG303dYZcktvmshEiSF0R5vFKoznNPSooh+2SBQ==
X-Received: by 2002:a05:6214:411a:b0:56a:eea2:9361 with SMTP id kc26-20020a056214411a00b0056aeea29361mr1622078qvb.31.1675444039544;
        Fri, 03 Feb 2023 09:07:19 -0800 (PST)
Received: from klayman.redhat.com (net-2-34-30-183.cust.vodafonedsl.it. [2.34.30.183])
        by smtp.gmail.com with ESMTPSA id b13-20020ac801cd000000b003a6a19ee4f0sm1884287qtg.33.2023.02.03.09.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 09:07:19 -0800 (PST)
From:   Marco Pagani <marpagan@redhat.com>
To:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
Cc:     Marco Pagani <marpagan@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: [RFC PATCH 3/4] fpga: add fake FPGA manager
Date:   Fri,  3 Feb 2023 18:06:52 +0100
Message-Id: <20230203170653.414990-4-marpagan@redhat.com>
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

Add fake FPGA manager platform driver with support functions.
The driver checks the programming sequence using KUnit expectations.
This module is part of the KUnit test suite for the FPGA subsystem.

Signed-off-by: Marco Pagani <marpagan@redhat.com>
---
 drivers/fpga/tests/fake-fpga-mgr.c | 365 +++++++++++++++++++++++++++++
 drivers/fpga/tests/fake-fpga-mgr.h |  42 ++++
 2 files changed, 407 insertions(+)
 create mode 100644 drivers/fpga/tests/fake-fpga-mgr.c
 create mode 100644 drivers/fpga/tests/fake-fpga-mgr.h

diff --git a/drivers/fpga/tests/fake-fpga-mgr.c b/drivers/fpga/tests/fake-fpga-mgr.c
new file mode 100644
index 000000000000..9daf328353d8
--- /dev/null
+++ b/drivers/fpga/tests/fake-fpga-mgr.c
@@ -0,0 +1,365 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for fake FPGA manager
+ *
+ * Copyright (C) 2023 Red Hat, Inc. All rights reserved.
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
+#define FAKE_HEADER_SIZE	FPGA_TEST_BIT_BLOCK
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
+ * fake_fpga_mgr_register - register a fake FPGA manager
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
+	if (IS_ERR(mgr_ctx->pdev)) {
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
+ * fake_fpga_mgr_unregister - unregister a fake FPGA manager
+ * @mgr_ctx: fake FPGA manager context data structure.
+ */
+void fake_fpga_mgr_unregister(struct fake_fpga_mgr *mgr_ctx)
+{
+	struct fake_mgr_priv *priv;
+	struct kunit *test;
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
+ * fake_fpga_mgr_get_rcfg_count - get the number of reconfigurations
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
+ * fake_fpga_mgr_fill_header - fill the bitstream buffer with the test header
+ * @mgr_ctx: fake FPGA manager context data structure.
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
+ * fake_fpga_mgr_check_write_buf - check if programming using a buffer succeeded
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
+ * fake_fpga_mgr_check_write_sg - check if programming using a s.g. table succeeded
+ * @mgr_ctx: fake FPGA manager context data structure.
+ */
+void fake_fpga_mgr_check_write_sg(struct fake_fpga_mgr *mgr_ctx)
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
+EXPORT_SYMBOL_GPL(fake_fpga_mgr_check_write_sg);
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
+	priv->test = pdata->test;
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
index 000000000000..5cecb6f646c9
--- /dev/null
+++ b/drivers/fpga/tests/fake-fpga-mgr.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Header file for fake FPGA manager
+ *
+ * Copyright (C) 2023 Red Hat, Inc. All rights reserved.
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
+#define FPGA_TEST_BIT_BLOCK	1024
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
+void fake_fpga_mgr_check_write_sg(struct fake_fpga_mgr *mgr_ctx);
+
+#endif /* __FPGA_FAKE_MGR_H */
-- 
2.39.1


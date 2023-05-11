Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE6566FF3F0
	for <lists+linux-fpga@lfdr.de>; Thu, 11 May 2023 16:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238120AbjEKOUm (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 11 May 2023 10:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238094AbjEKOUk (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 11 May 2023 10:20:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86892126
        for <linux-fpga@vger.kernel.org>; Thu, 11 May 2023 07:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683814794;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A3JyemX4wBKEk8PrT7a2ZLhtspMQc4S/1qp1M7U5InU=;
        b=F15GnB44eIkyiPBs/KZzcsoZxeb5NQnYRy6wvh13NgJoI+PVPWRGECxzoKGlpsOT1unKwg
        ciZGtCXuvAEmW5oFI1VMgH8a0mNBvvWJoc196aHg/qmcgwB/Yebu/CXHs9voCC7584ZmK6
        PWtLiACqnQv06nRRKITuPjMLwCudrEg=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-s3MXOB7nOB2QoYTcfU_uUg-1; Thu, 11 May 2023 10:19:53 -0400
X-MC-Unique: s3MXOB7nOB2QoYTcfU_uUg-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-61b5bcb4c09so49758126d6.2
        for <linux-fpga@vger.kernel.org>; Thu, 11 May 2023 07:19:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683814792; x=1686406792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A3JyemX4wBKEk8PrT7a2ZLhtspMQc4S/1qp1M7U5InU=;
        b=lyYwE0ymOh/3DnXxceRhU5uFto9IMc4DIEdghHBsMAR4r3GkQ3sPHxqTybudFVV4rI
         zDkk6XGzqJPh7UzBS/Obl+dM20CBpXkthoVORMByBqkQStDmL9YGVRtacIzoBmhqLD/b
         Yszz2ZhmNam3SUYT+BKLeohyC4BWFCQrT16rDSzlaDQpbLvXTGLgqHisXYHZfImPukNx
         PVH66jBsXkp7sRlgZjNyU202Vo73g7wrD4JoPmW4SZak7MXzs0m2wSRX6HFMbj+j+wgF
         8IEhCMcfiBW69sqfYcFXDEa98yFSfTSHs3HCkG8Af6hBlCP3Cl2Dy/2whERQvaZB+c0v
         CzRA==
X-Gm-Message-State: AC+VfDwP1MLB/Hy04Qfs8M7bfi+rXjQMX9T/5tVFhQZ7VIhelAQX/kAy
        r7R17GjcbcAKlkiUsIqwIwh02plykSvNTDptwdWTkdjus5q3vE9bRVRCvQhmEpwVWwo1aJKHqSM
        l5JxMaJ1vLtbP3udhUptu
X-Received: by 2002:a05:6214:628:b0:621:42c8:9bdd with SMTP id a8-20020a056214062800b0062142c89bddmr12976247qvx.29.1683814792433;
        Thu, 11 May 2023 07:19:52 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6iAl17BOI+r85d/81viObbbYhSRYN0YMsn+XezRK2buEaaAwAbXirGZ2awl52VNwMsoh79uQ==
X-Received: by 2002:a05:6214:628:b0:621:42c8:9bdd with SMTP id a8-20020a056214062800b0062142c89bddmr12976197qvx.29.1683814791992;
        Thu, 11 May 2023 07:19:51 -0700 (PDT)
Received: from klayman.redhat.com (net-2-34-28-169.cust.vodafonedsl.it. [2.34.28.169])
        by smtp.gmail.com with ESMTPSA id oo11-20020a05620a530b00b0074db94ed42fsm965516qkn.116.2023.05.11.07.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 07:19:51 -0700 (PDT)
From:   Marco Pagani <marpagan@redhat.com>
To:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
Cc:     Marco Pagani <marpagan@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: [RFC PATCH v5 1/4] fpga: add fake FPGA manager
Date:   Thu, 11 May 2023 16:19:19 +0200
Message-Id: <20230511141922.437328-2-marpagan@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230511141922.437328-1-marpagan@redhat.com>
References: <20230511141922.437328-1-marpagan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Add fake FPGA manager platform driver with support functions. This module
is part of the KUnit tests for the FPGA subsystem.

Signed-off-by: Marco Pagani <marpagan@redhat.com>
---
 drivers/fpga/tests/fake-fpga-mgr.c | 271 +++++++++++++++++++++++++++++
 drivers/fpga/tests/fake-fpga-mgr.h |  53 ++++++
 2 files changed, 324 insertions(+)
 create mode 100644 drivers/fpga/tests/fake-fpga-mgr.c
 create mode 100644 drivers/fpga/tests/fake-fpga-mgr.h

diff --git a/drivers/fpga/tests/fake-fpga-mgr.c b/drivers/fpga/tests/fake-fpga-mgr.c
new file mode 100644
index 000000000000..1e994db10159
--- /dev/null
+++ b/drivers/fpga/tests/fake-fpga-mgr.c
@@ -0,0 +1,271 @@
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
+
+#include "fake-fpga-mgr.h"
+
+#define FAKE_FPGA_MGR_DEV_NAME	"fake_fpga_mgr"
+
+struct fake_mgr_pdata {
+	struct kunit *test;
+	struct fake_fpga_mgr_stats *stats;
+};
+
+struct fake_mgr_priv {
+	int seq_num;
+	struct fake_mgr_pdata *pdata;
+};
+
+static bool check_header(struct kunit *test, const char *buf, size_t count)
+{
+	size_t i;
+
+	for (i = 0; i < count; i++)
+		if (buf[i] != TEST_HEADER_MAGIC)
+			return false;
+
+	return true;
+}
+
+static enum fpga_mgr_states op_state(struct fpga_manager *mgr)
+{
+	struct fake_mgr_priv *priv;
+
+	priv = mgr->priv;
+
+	kunit_info(priv->pdata->test, "Fake FPGA manager: state\n");
+
+	return mgr->state;
+}
+
+static u64 op_status(struct fpga_manager *mgr)
+{
+	struct fake_mgr_priv *priv;
+
+	priv = mgr->priv;
+
+	kunit_info(priv->pdata->test, "Fake FPGA manager: status\n");
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
+	/* Set header_size and data_size as expected */
+	info->header_size = TEST_HEADER_SIZE;
+	info->data_size = info->count - TEST_HEADER_SIZE;
+
+	priv->pdata->stats->header_done = check_header(priv->pdata->test, buf,
+						       info->header_size);
+	priv->pdata->stats->op_parse_header_state = mgr->state;
+	priv->pdata->stats->op_parse_header_seq = priv->seq_num++;
+
+	kunit_info(priv->pdata->test, "Fake FPGA manager: parse_header\n");
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
+	priv->pdata->stats->op_write_init_state = mgr->state;
+	priv->pdata->stats->op_write_init_seq = priv->seq_num++;
+
+	kunit_info(priv->pdata->test, "Fake FPGA manager: write_init\n");
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
+	priv->pdata->stats->op_write_state = mgr->state;
+	priv->pdata->stats->op_write_seq = priv->seq_num++;
+
+	kunit_info(priv->pdata->test, "Fake FPGA manager: write\n");
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
+	priv->pdata->stats->op_write_state = mgr->state;
+	priv->pdata->stats->op_write_seq = priv->seq_num++;
+
+	kunit_info(priv->pdata->test, "Fake FPGA manager: write_sg\n");
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
+	priv->pdata->stats->op_write_complete_state = mgr->state;
+	priv->pdata->stats->op_write_complete_seq = priv->seq_num++;
+	priv->pdata->stats->prog_count++;
+
+	kunit_info(priv->pdata->test, "Fake FPGA manager: write_complete\n");
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
+	kunit_info(priv->pdata->test, "Fake FPGA manager: remove\n");
+}
+
+static const struct fpga_manager_ops fake_fpga_mgr_ops = {
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
+ * @test: KUnit test context object.
+ * @mgr_ctx: fake FPGA manager context data structure.
+ *
+ * Return: pointer to a new fake FPGA manager on success, an ERR_PTR()
+ * encoded error code on failure.
+ */
+struct fake_fpga_mgr *
+fake_fpga_mgr_register(struct kunit *test, struct device *parent)
+{
+	struct fake_fpga_mgr *mgr_ctx;
+	struct fake_mgr_pdata pdata;
+	int ret;
+
+	mgr_ctx = kunit_kzalloc(test, sizeof(*mgr_ctx), GFP_KERNEL);
+	if (!mgr_ctx) {
+		ret = -ENOMEM;
+		goto err_mem;
+	}
+
+	mgr_ctx->pdev = platform_device_alloc(FAKE_FPGA_MGR_DEV_NAME,
+					      PLATFORM_DEVID_AUTO);
+	if (!mgr_ctx->pdev) {
+		kunit_err(test, "Fake FPGA manager device allocation failed\n");
+		ret = -ENOMEM;
+		goto err_mem;
+	}
+
+	pdata.test = test;
+	pdata.stats = &mgr_ctx->stats;
+	platform_device_add_data(mgr_ctx->pdev, &pdata, sizeof(pdata));
+
+	mgr_ctx->pdev->dev.parent = parent;
+	ret = platform_device_add(mgr_ctx->pdev);
+	if (ret) {
+		kunit_err(test, "Fake FPGA manager device add failed\n");
+		goto err_pdev;
+	}
+
+	mgr_ctx->mgr = platform_get_drvdata(mgr_ctx->pdev);
+
+	kunit_info(test, "Fake FPGA manager registered\n");
+
+	return mgr_ctx;
+
+err_pdev:
+	platform_device_put(mgr_ctx->pdev);
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
+	test = priv->pdata->test;
+
+	platform_device_unregister(mgr_ctx->pdev);
+
+	kunit_info(test, "Fake FPGA manager unregistered\n");
+}
+EXPORT_SYMBOL_GPL(fake_fpga_mgr_unregister);
+
+static int fake_fpga_mgr_probe(struct platform_device *pdev)
+{
+	struct device *dev;
+	struct fake_mgr_pdata *pdata;
+	struct fpga_manager *mgr;
+	struct fake_mgr_priv *priv;
+
+	dev = &pdev->dev;
+	pdata = dev_get_platdata(dev);
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->pdata = pdata;
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
+MODULE_LICENSE("GPL");
diff --git a/drivers/fpga/tests/fake-fpga-mgr.h b/drivers/fpga/tests/fake-fpga-mgr.h
new file mode 100644
index 000000000000..282c20d8e40c
--- /dev/null
+++ b/drivers/fpga/tests/fake-fpga-mgr.h
@@ -0,0 +1,53 @@
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
+#include <linux/types.h>
+#include <linux/platform_device.h>
+#include <kunit/test.h>
+#include <linux/fpga/fpga-mgr.h>
+
+#define FPGA_IMG_BLOCK		1024
+#define TEST_HEADER_MAGIC	0x3f
+#define TEST_HEADER_SIZE	FPGA_IMG_BLOCK
+
+struct fake_fpga_mgr_stats {
+	u32 prog_count;
+	bool header_done;
+	u32 op_parse_header_seq;
+	u32 op_write_init_seq;
+	u32 op_write_seq;
+	u32 op_write_complete_seq;
+	enum fpga_mgr_states op_parse_header_state;
+	enum fpga_mgr_states op_write_init_state;
+	enum fpga_mgr_states op_write_state;
+	enum fpga_mgr_states op_write_complete_state;
+};
+
+/**
+ * struct fake_fpga_mgr - fake FPGA manager context data structure
+ *
+ * @mgr: FPGA manager.
+ * @pdev: platform device of the FPGA manager.
+ * @stats: info from the low level driver.
+ */
+struct fake_fpga_mgr {
+	struct fpga_manager *mgr;
+	struct platform_device *pdev;
+	struct fake_fpga_mgr_stats stats;
+};
+
+struct fake_fpga_mgr *
+fake_fpga_mgr_register(struct kunit *test, struct device *parent);
+
+void fake_fpga_mgr_unregister(struct fake_fpga_mgr *mgr_ctx);
+
+#endif /* __FPGA_FAKE_MGR_H */
-- 
2.40.1


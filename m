Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD94757CEC
	for <lists+linux-fpga@lfdr.de>; Tue, 18 Jul 2023 15:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbjGRNIs (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 18 Jul 2023 09:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232488AbjGRNHh (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 18 Jul 2023 09:07:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91BE01987
        for <linux-fpga@vger.kernel.org>; Tue, 18 Jul 2023 06:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689685410;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8wZhu53F4F7gIlc8a4am6xpj3s/cLtV4xrOxNFzw7tE=;
        b=RfiQdrANQxfy6YXMsABUEXtZFdruZc71yGcZdegmV3gM3BWvd0UR6vmbQwf+B4yx16wRot
        CMilgEHRMGuWmrvOj4Lc43J2i7b1DfhxquZ3/s0DFRDWPP7OmoN6yLdTo6fLbOrJDcRgZW
        1cE6Ms0PjSx0OdB637jyL9jHBaOCVmY=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-294-uKqBz_lbMdui1dgps2QZ_Q-1; Tue, 18 Jul 2023 09:03:29 -0400
X-MC-Unique: uKqBz_lbMdui1dgps2QZ_Q-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7675581a4afso738412185a.1
        for <linux-fpga@vger.kernel.org>; Tue, 18 Jul 2023 06:03:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689685409; x=1692277409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8wZhu53F4F7gIlc8a4am6xpj3s/cLtV4xrOxNFzw7tE=;
        b=N+0XNHpnsQq2oCBshwrh5CGCo5YR8TxKcTMTojB+2bJTuhGq464U1c6/CttpwrbRlG
         0w7IDB4Q8eouGLik4JEFcnxbN1yQ5NMJBaTcbVRsg/t6p65QfHEANiVaIytaP86w6Hra
         j+42MdBuXV+UgVXwDnY6KWlvBJnUD/DwRJqEkAXBoUmdrNHB12wua2IR4Si7yuawNViY
         tI3uV8rpAIWx6ESHkgo6dEkz24KTApQIQE07z7Os+wsgh0A4pXAGnvh6F+62DExpRaof
         54B6SGR+RsdD8c/z/qqHd/c7kZ4CRaMg7wLhS9BUqj81PbHtG063YKVPwAgSnHn7UvYo
         gTtA==
X-Gm-Message-State: ABy/qLbYhgpToHpYmoQD2pwC7egmtR8l66SGcGPQFMQseNVJsEffuCiZ
        dZHT1bMt7YRYyLrUQEGAzvLRrFgaK6dogDWKQKTUcbiTR2YnRm9WLZncwkZeu7DPohhLH0NDYZA
        Ic+J3zpbkTnP8qriLclAzwCeevs43
X-Received: by 2002:a05:620a:25a:b0:768:10dc:e578 with SMTP id q26-20020a05620a025a00b0076810dce578mr8003273qkn.48.1689685409011;
        Tue, 18 Jul 2023 06:03:29 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHjywV0VCnroYOjlGpt9l3fXaJFjlR/FC7OBqBcOjZSb/ZEuE18ojBHlvTnn2uXrCMzj0i7AA==
X-Received: by 2002:a05:620a:25a:b0:768:10dc:e578 with SMTP id q26-20020a05620a025a00b0076810dce578mr8003252qkn.48.1689685408736;
        Tue, 18 Jul 2023 06:03:28 -0700 (PDT)
Received: from klayman.redhat.com (net-2-34-27-228.cust.vodafonedsl.it. [2.34.27.228])
        by smtp.gmail.com with ESMTPSA id h18-20020a05620a10b200b00765ab6d3e81sm550221qkk.122.2023.07.18.06.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 06:03:28 -0700 (PDT)
From:   Marco Pagani <marpagan@redhat.com>
To:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
Cc:     Marco Pagani <marpagan@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: [PATCH v10 2/4] fpga: add an initial KUnit suite for the FPGA Bridge
Date:   Tue, 18 Jul 2023 15:03:02 +0200
Message-ID: <20230718130304.87048-3-marpagan@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230718130304.87048-1-marpagan@redhat.com>
References: <20230718130304.87048-1-marpagan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The suite tests the basic behaviors of the FPGA Bridge including
the functions that operate on a list of bridges.

Signed-off-by: Marco Pagani <marpagan@redhat.com>
Acked-by: Xu Yilun <yilun.xu@intel.com>
---
 drivers/fpga/tests/fpga-bridge-test.c | 175 ++++++++++++++++++++++++++
 1 file changed, 175 insertions(+)
 create mode 100644 drivers/fpga/tests/fpga-bridge-test.c

diff --git a/drivers/fpga/tests/fpga-bridge-test.c b/drivers/fpga/tests/fpga-bridge-test.c
new file mode 100644
index 000000000000..1d258002cdd7
--- /dev/null
+++ b/drivers/fpga/tests/fpga-bridge-test.c
@@ -0,0 +1,175 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit test for the FPGA Bridge
+ *
+ * Copyright (C) 2023 Red Hat, Inc.
+ *
+ * Author: Marco Pagani <marpagan@redhat.com>
+ */
+
+#include <kunit/test.h>
+#include <linux/device.h>
+#include <linux/fpga/fpga-bridge.h>
+#include <linux/module.h>
+#include <linux/types.h>
+
+struct bridge_stats {
+	bool enable;
+};
+
+struct bridge_ctx {
+	struct fpga_bridge *bridge;
+	struct platform_device *pdev;
+	struct bridge_stats stats;
+};
+
+static int op_enable_set(struct fpga_bridge *bridge, bool enable)
+{
+	struct bridge_stats *stats = bridge->priv;
+
+	stats->enable = enable;
+
+	return 0;
+}
+
+/*
+ * Fake FPGA bridge that implements only the enable_set op to track
+ * the state.
+ */
+static const struct fpga_bridge_ops fake_bridge_ops = {
+	.enable_set = op_enable_set,
+};
+
+/**
+ * register_test_bridge() - Register a fake FPGA bridge for testing.
+ * @test: KUnit test context object.
+ *
+ * Return: Context of the newly registered FPGA bridge.
+ */
+static struct bridge_ctx *register_test_bridge(struct kunit *test)
+{
+	struct bridge_ctx *ctx;
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+
+	ctx->pdev = platform_device_register_simple("bridge_pdev", PLATFORM_DEVID_AUTO, NULL, 0);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->pdev);
+
+	ctx->bridge = fpga_bridge_register(&ctx->pdev->dev, "Fake FPGA bridge", &fake_bridge_ops,
+					   &ctx->stats);
+	KUNIT_ASSERT_FALSE(test, IS_ERR_OR_NULL(ctx->bridge));
+
+	return ctx;
+}
+
+static void unregister_test_bridge(struct bridge_ctx *ctx)
+{
+	fpga_bridge_unregister(ctx->bridge);
+	platform_device_unregister(ctx->pdev);
+}
+
+static void fpga_bridge_test_get(struct kunit *test)
+{
+	struct bridge_ctx *ctx = test->priv;
+	struct fpga_bridge *bridge;
+
+	bridge = fpga_bridge_get(&ctx->pdev->dev, NULL);
+	KUNIT_EXPECT_PTR_EQ(test, bridge, ctx->bridge);
+
+	bridge = fpga_bridge_get(&ctx->pdev->dev, NULL);
+	KUNIT_EXPECT_EQ(test, PTR_ERR(bridge), -EBUSY);
+
+	fpga_bridge_put(ctx->bridge);
+}
+
+static void fpga_bridge_test_toggle(struct kunit *test)
+{
+	struct bridge_ctx *ctx = test->priv;
+	int ret;
+
+	ret = fpga_bridge_disable(ctx->bridge);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_FALSE(test, ctx->stats.enable);
+
+	ret = fpga_bridge_enable(ctx->bridge);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_TRUE(test, ctx->stats.enable);
+}
+
+/* Test the functions for getting and controlling a list of bridges */
+static void fpga_bridge_test_get_put_list(struct kunit *test)
+{
+	struct list_head bridge_list;
+	struct bridge_ctx *ctx_0, *ctx_1;
+	int ret;
+
+	ctx_0 = test->priv;
+	ctx_1 = register_test_bridge(test);
+
+	INIT_LIST_HEAD(&bridge_list);
+
+	/* Get bridge 0 and add it to the list */
+	ret = fpga_bridge_get_to_list(&ctx_0->pdev->dev, NULL, &bridge_list);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	KUNIT_EXPECT_PTR_EQ(test, ctx_0->bridge,
+			    list_first_entry_or_null(&bridge_list, struct fpga_bridge, node));
+
+	/* Get bridge 1 and add it to the list */
+	ret = fpga_bridge_get_to_list(&ctx_1->pdev->dev, NULL, &bridge_list);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	KUNIT_EXPECT_PTR_EQ(test, ctx_1->bridge,
+			    list_first_entry_or_null(&bridge_list, struct fpga_bridge, node));
+
+	/* Disable an then enable both bridges from the list */
+	ret = fpga_bridges_disable(&bridge_list);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	KUNIT_EXPECT_FALSE(test, ctx_0->stats.enable);
+	KUNIT_EXPECT_FALSE(test, ctx_1->stats.enable);
+
+	ret = fpga_bridges_enable(&bridge_list);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	KUNIT_EXPECT_TRUE(test, ctx_0->stats.enable);
+	KUNIT_EXPECT_TRUE(test, ctx_1->stats.enable);
+
+	/* Put and remove both bridges from the list */
+	fpga_bridges_put(&bridge_list);
+
+	KUNIT_EXPECT_TRUE(test, list_empty(&bridge_list));
+
+	unregister_test_bridge(ctx_1);
+}
+
+static int fpga_bridge_test_init(struct kunit *test)
+{
+	test->priv = register_test_bridge(test);
+
+	return 0;
+}
+
+static void fpga_bridge_test_exit(struct kunit *test)
+{
+	unregister_test_bridge(test->priv);
+}
+
+static struct kunit_case fpga_bridge_test_cases[] = {
+	KUNIT_CASE(fpga_bridge_test_get),
+	KUNIT_CASE(fpga_bridge_test_toggle),
+	KUNIT_CASE(fpga_bridge_test_get_put_list),
+	{}
+};
+
+static struct kunit_suite fpga_bridge_suite = {
+	.name = "fpga_bridge",
+	.init = fpga_bridge_test_init,
+	.exit = fpga_bridge_test_exit,
+	.test_cases = fpga_bridge_test_cases,
+};
+
+kunit_test_suite(fpga_bridge_suite);
+
+MODULE_LICENSE("GPL");
-- 
2.41.0


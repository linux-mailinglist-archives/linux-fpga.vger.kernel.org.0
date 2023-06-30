Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB66743EDC
	for <lists+linux-fpga@lfdr.de>; Fri, 30 Jun 2023 17:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233019AbjF3P1B (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 30 Jun 2023 11:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233010AbjF3P0e (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 30 Jun 2023 11:26:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A514C30F7
        for <linux-fpga@vger.kernel.org>; Fri, 30 Jun 2023 08:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688138742;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AZt43Ky3719pMlaApXqVMD6ZwhsTjVdiVPLbUGmOVRw=;
        b=H8eNg4hrru7a6VAYb+vKrHitOeKotq0xmAF1cJ/ecW6uzE2eREjs94iXb3fNCbXD8tibZe
        YQiuLspneaE47zni0x+X841OA4g+xl6OW0rUUzfuKpsCCKCVFwqDtSU0lRg28zyvKENFKg
        ZxqW2S/viR5oqAR4slMxQNjhFxT4/E8=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-p_KK2FZGMUOZXjemmMapIA-1; Fri, 30 Jun 2023 11:25:39 -0400
X-MC-Unique: p_KK2FZGMUOZXjemmMapIA-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-51debc21fbdso682210a12.3
        for <linux-fpga@vger.kernel.org>; Fri, 30 Jun 2023 08:25:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688138738; x=1690730738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AZt43Ky3719pMlaApXqVMD6ZwhsTjVdiVPLbUGmOVRw=;
        b=dn0WSfHj55XyHsqu1kp0lmrMK+UImAIee72ODeegsJTrb4ygJCYa3mTvqAvPRi5t03
         UVxEnBqQJY1k0PhqtLAtuflSwrGGDCfL7l7q3QiL2miC7c+2cP3D3G0koRtf/BP6eXqH
         F2YbpdrZYe1etcMKN8V3rgP214Ne3we9/VBt9kQyRdGD5bMgfs6e7Moy/jPToS/Hby4z
         gyZMbGtJ3l1bnq52NJawysc1ocBnBvn+WlKbYOV/tzZStBEueNWJgnIgIu6QtiwHZFQi
         iPOY7B9QXBTAh5h0xjN3opp1FDUnN+lpT13xEt9IjLm3vY8tHGnr6rkgFIvjkKBvVc3n
         JlgQ==
X-Gm-Message-State: ABy/qLZrI4wX/28Cnbwn/BV5Mx7/gX6YOiWFnPtwfxWtAmE6kv+dLt7N
        HaS2Rag0vDegHTEVw8f0fZEI1qDb3dG7HFz8+LHST6+OGviAvm56qnXBBNxo8Ak2ETpl2RAeM4I
        4mM6/8gLev/jZqm3TxxHg
X-Received: by 2002:a05:6402:284:b0:51d:b963:4bd3 with SMTP id l4-20020a056402028400b0051db9634bd3mr2448026edv.31.1688138738456;
        Fri, 30 Jun 2023 08:25:38 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHdQs2DouSui7WkBs9UgpGj763b16U7P3l+G7aXnH6gG3XD2369/aeMPCYKs7ltT9fZfIsIZg==
X-Received: by 2002:a05:6402:284:b0:51d:b963:4bd3 with SMTP id l4-20020a056402028400b0051db9634bd3mr2448013edv.31.1688138738179;
        Fri, 30 Jun 2023 08:25:38 -0700 (PDT)
Received: from klayman.station (net-2-34-24-242.cust.vodafonedsl.it. [2.34.24.242])
        by smtp.gmail.com with ESMTPSA id k24-20020aa7c398000000b0051def9be785sm813230edq.85.2023.06.30.08.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 08:25:37 -0700 (PDT)
From:   Marco Pagani <marpagan@redhat.com>
To:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
Cc:     Marco Pagani <marpagan@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: [PATCH v8 3/4] fpga: add an initial KUnit suite for the FPGA Region
Date:   Fri, 30 Jun 2023 17:25:06 +0200
Message-ID: <20230630152507.30219-4-marpagan@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230630152507.30219-1-marpagan@redhat.com>
References: <20230630152507.30219-1-marpagan@redhat.com>
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

The suite tests the basic behaviors of the FPGA Region including
the programming and the function for finding a specific region.

Signed-off-by: Marco Pagani <marpagan@redhat.com>
Acked-by: Xu Yilun <yilun.xu@intel.com>
---
 drivers/fpga/tests/fpga-region-test.c | 211 ++++++++++++++++++++++++++
 1 file changed, 211 insertions(+)
 create mode 100644 drivers/fpga/tests/fpga-region-test.c

diff --git a/drivers/fpga/tests/fpga-region-test.c b/drivers/fpga/tests/fpga-region-test.c
new file mode 100644
index 000000000000..8a195d85a877
--- /dev/null
+++ b/drivers/fpga/tests/fpga-region-test.c
@@ -0,0 +1,211 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit test for the FPGA Region
+ *
+ * Copyright (C) 2023 Red Hat, Inc.
+ *
+ * Author: Marco Pagani <marpagan@redhat.com>
+ */
+
+#include <kunit/test.h>
+#include <linux/fpga/fpga-bridge.h>
+#include <linux/fpga/fpga-mgr.h>
+#include <linux/fpga/fpga-region.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/types.h>
+
+struct mgr_stats {
+	u32 write_count;
+};
+
+struct bridge_stats {
+	bool enable;
+	u32 cycles_count;
+};
+
+struct test_ctx {
+	struct fpga_manager *mgr;
+	struct platform_device *mgr_pdev;
+	struct fpga_bridge *bridge;
+	struct platform_device *bridge_pdev;
+	struct fpga_region *region;
+	struct platform_device *region_pdev;
+	struct bridge_stats bridge_stats;
+	struct mgr_stats mgr_stats;
+};
+
+static int op_write(struct fpga_manager *mgr, const char *buf, size_t count)
+{
+	struct mgr_stats *stats = mgr->priv;
+
+	stats->write_count++;
+
+	return 0;
+}
+
+/*
+ * Fake Manager that implements only the write op to count the number of
+ * programming cycles. The internals of the programming sequence are
+ * tested in the Manager suite since they are outside the responsibility
+ * of the Region.
+ */
+static const struct fpga_manager_ops fake_mgr_ops = {
+	.write = op_write,
+};
+
+static int op_enable_set(struct fpga_bridge *bridge, bool enable)
+{
+	struct bridge_stats *stats = bridge->priv;
+
+	if (!stats->enable && enable)
+		stats->cycles_count++;
+
+	stats->enable = enable;
+
+	return 0;
+}
+
+/*
+ * Fake Bridge that implements only enable_set op to count the number of
+ * activation cycles.
+ */
+static const struct fpga_bridge_ops fake_bridge_ops = {
+	.enable_set = op_enable_set,
+};
+
+static int fake_region_get_bridges(struct fpga_region *region)
+{
+	struct fpga_bridge *bridge = region->priv;
+
+	return fpga_bridge_get_to_list(bridge->dev.parent, region->info, &region->bridge_list);
+}
+
+static int fake_region_match(struct device *dev, const void *data)
+{
+	return dev->parent == data;
+}
+
+static void fpga_region_test_class_find(struct kunit *test)
+{
+	struct test_ctx *ctx = test->priv;
+	struct fpga_region *region;
+
+	region = fpga_region_class_find(NULL, &ctx->region_pdev->dev, fake_region_match);
+	KUNIT_EXPECT_PTR_EQ(test, region, ctx->region);
+}
+
+/*
+ * Region programming test. The Region must call get_bridges() to get and
+ * control the bridges, and then the Manager for the actual programming.
+ */
+static void fpga_region_test_program_fpga(struct kunit *test)
+{
+	struct test_ctx *ctx = test->priv;
+	struct fpga_image_info *img_info;
+	char img_buf[4];
+	int ret;
+
+	img_info = fpga_image_info_alloc(&ctx->mgr_pdev->dev);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, img_info);
+
+	img_info->buf = img_buf;
+	img_info->count = sizeof(img_buf);
+
+	ctx->region->info = img_info;
+	ret = fpga_region_program_fpga(ctx->region);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	KUNIT_EXPECT_EQ(test, 1, ctx->mgr_stats.write_count);
+	KUNIT_EXPECT_EQ(test, 1, ctx->bridge_stats.cycles_count);
+
+	fpga_bridges_put(&ctx->region->bridge_list);
+
+	ret = fpga_region_program_fpga(ctx->region);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	KUNIT_EXPECT_EQ(test, 2, ctx->mgr_stats.write_count);
+	KUNIT_EXPECT_EQ(test, 2, ctx->bridge_stats.cycles_count);
+
+	fpga_bridges_put(&ctx->region->bridge_list);
+
+	fpga_image_info_free(img_info);
+}
+
+/*
+ * The configuration used in this test suite uses a single bridge to
+ * limit the code under test to a single unit. The functions used by the
+ * Region for getting and controlling bridges are tested (with a list of
+ * multiple bridges) in the Bridge suite.
+ */
+static int fpga_region_test_init(struct kunit *test)
+{
+	struct test_ctx *ctx;
+	struct fpga_region_info region_info = { 0 };
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+
+	ctx->mgr_pdev = platform_device_register_simple("mgr_pdev", PLATFORM_DEVID_AUTO, NULL, 0);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->mgr_pdev);
+
+	ctx->mgr = devm_fpga_mgr_register(&ctx->mgr_pdev->dev, "Fake FPGA Manager", &fake_mgr_ops,
+					  &ctx->mgr_stats);
+	KUNIT_ASSERT_FALSE(test, IS_ERR_OR_NULL(ctx->mgr));
+
+	ctx->bridge_pdev = platform_device_register_simple("bridge_pdev", PLATFORM_DEVID_AUTO,
+							   NULL, 0);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->bridge_pdev);
+
+	ctx->bridge = fpga_bridge_register(&ctx->bridge_pdev->dev, "Fake FPGA Bridge",
+					   &fake_bridge_ops, &ctx->bridge_stats);
+	KUNIT_ASSERT_FALSE(test, IS_ERR_OR_NULL(ctx->bridge));
+
+	ctx->bridge_stats.enable = true;
+
+	ctx->region_pdev = platform_device_register_simple("region_pdev", PLATFORM_DEVID_AUTO,
+							   NULL, 0);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->region_pdev);
+
+	region_info.mgr = ctx->mgr;
+	region_info.priv = ctx->bridge;
+	region_info.get_bridges = fake_region_get_bridges;
+
+	ctx->region = fpga_region_register_full(&ctx->region_pdev->dev, &region_info);
+	KUNIT_ASSERT_FALSE(test, IS_ERR_OR_NULL(ctx->region));
+
+	test->priv = ctx;
+
+	return 0;
+}
+
+static void fpga_region_test_exit(struct kunit *test)
+{
+	struct test_ctx *ctx = test->priv;
+
+	fpga_region_unregister(ctx->region);
+	platform_device_unregister(ctx->region_pdev);
+
+	fpga_bridge_unregister(ctx->bridge);
+	platform_device_unregister(ctx->bridge_pdev);
+
+	platform_device_unregister(ctx->mgr_pdev);
+}
+
+static struct kunit_case fpga_region_test_cases[] = {
+	KUNIT_CASE(fpga_region_test_class_find),
+	KUNIT_CASE(fpga_region_test_program_fpga),
+
+	{}
+};
+
+static struct kunit_suite fpga_region_suite = {
+	.name = "fpga_mgr",
+	.init = fpga_region_test_init,
+	.exit = fpga_region_test_exit,
+	.test_cases = fpga_region_test_cases,
+};
+
+kunit_test_suite(fpga_region_suite);
+
+MODULE_LICENSE("GPL");
-- 
2.41.0


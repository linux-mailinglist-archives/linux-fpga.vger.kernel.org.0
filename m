Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68676717C86
	for <lists+linux-fpga@lfdr.de>; Wed, 31 May 2023 11:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235684AbjEaJzM (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 31 May 2023 05:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235666AbjEaJzI (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 31 May 2023 05:55:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD65D10E
        for <linux-fpga@vger.kernel.org>; Wed, 31 May 2023 02:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685526862;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N4+A4nutXompnLSFNP6hePxbga6fySP2AhvC5oSdcgc=;
        b=M33IKeG9oLGurmT/ggvbAwLdaLt1pPeNq6RxJss/MoK0uBthXDhxB5sVYuhQq2zLXL8b49
        vwcS0wLogzn5VHp5ZVIkpITOvZovm9B5pf0odaQN0lu8HQ82lpX276G+IwHHAQRbmNfGwT
        UkCbMV1BGLXmgCXuytyunu4ChKaBmXw=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-iRfKg5Q2PfyGZUo83mdxxQ-1; Wed, 31 May 2023 05:54:20 -0400
X-MC-Unique: iRfKg5Q2PfyGZUo83mdxxQ-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-75aff1596d3so895279185a.2
        for <linux-fpga@vger.kernel.org>; Wed, 31 May 2023 02:54:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685526860; x=1688118860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N4+A4nutXompnLSFNP6hePxbga6fySP2AhvC5oSdcgc=;
        b=IavOmheQ3KyVVqTJUiDB5nHCGIpOnKS0hk1wWVC3zzPvAm0kKlBZiBvkqui1sU7ijZ
         aePPn1IRbjozlTDBW4hrlulfHVlSgQlJlyIN2tORQPf7950nrWitbXq0iUQt2qwEfTHC
         WSaFQmSRzHMO+BxaYCmrfHEj8OO5bePpsXB3yeHfrrLDcptfpAzkTHwF9fyiFtPfltKG
         isImrqtoFAu2NwaBCPPbn1n7Dn0PqsqkiKKCoYkfol+7zH5V1nUKOBKXFQXExXicnwxB
         YCtNcQIxrzPdqmqUlWY84LQRyucYsZnekbGMw4OS6/+VhxcrYofWcTsTmccNCObjU7HB
         j6xA==
X-Gm-Message-State: AC+VfDxkJrhlAWUZUyQP87RBKFrWokqeoholtRvTYaJk6HM8vJvmeDcX
        UU1J8ArfT3l4v8xr9uHjKQ4VSfmpqQk8yPyuzkp3W8rHAQNHGeX2Qr7CrLdFqw4voNaxEjU/FQw
        CcYFoRcN4Gw/LY4yIfu3K2bO2gcVd
X-Received: by 2002:a05:620a:3e87:b0:75b:23a1:3619 with SMTP id tv7-20020a05620a3e8700b0075b23a13619mr4538334qkn.42.1685526859952;
        Wed, 31 May 2023 02:54:19 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4XAPDhiSr9z/JJXAbxuN94ql/8RbJLbnJyOaiq2qnXni+lBq9rVInwvH5mK80geDRuTCF/qQ==
X-Received: by 2002:a05:620a:3e87:b0:75b:23a1:3619 with SMTP id tv7-20020a05620a3e8700b0075b23a13619mr4538319qkn.42.1685526859697;
        Wed, 31 May 2023 02:54:19 -0700 (PDT)
Received: from klayman.redhat.com (net-2-34-28-169.cust.vodafonedsl.it. [2.34.28.169])
        by smtp.gmail.com with ESMTPSA id k25-20020a05620a139900b0074def53eca5sm4902404qki.53.2023.05.31.02.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 02:54:19 -0700 (PDT)
From:   Marco Pagani <marpagan@redhat.com>
To:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
Cc:     Marco Pagani <marpagan@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: [RFC PATCH v6 1/4] fpga: add an initial KUnit suite for the FPGA Manager
Date:   Wed, 31 May 2023 11:54:02 +0200
Message-Id: <20230531095405.342080-2-marpagan@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230531095405.342080-1-marpagan@redhat.com>
References: <20230531095405.342080-1-marpagan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The suite tests the basic behaviors of the FPGA Manager, and the
programming using a single contiguous buffer and scatter gather table.

Signed-off-by: Marco Pagani <marpagan@redhat.com>
---
 drivers/fpga/tests/fpga-mgr-test.c | 289 +++++++++++++++++++++++++++++
 1 file changed, 289 insertions(+)
 create mode 100644 drivers/fpga/tests/fpga-mgr-test.c

diff --git a/drivers/fpga/tests/fpga-mgr-test.c b/drivers/fpga/tests/fpga-mgr-test.c
new file mode 100644
index 000000000000..c771ae4dd05e
--- /dev/null
+++ b/drivers/fpga/tests/fpga-mgr-test.c
@@ -0,0 +1,289 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit test for the FPGA Manager
+ *
+ * Copyright (C) 2023 Red Hat, Inc.
+ *
+ * Author: Marco Pagani <marpagan@redhat.com>
+ */
+
+#include <linux/types.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/scatterlist.h>
+#include <kunit/test.h>
+#include <linux/fpga/fpga-mgr.h>
+
+#define HEADER_MAGIC		'H'
+#define IMAGE_MAGIC		'P'
+#define IMAGE_BLOCK		1024
+
+#define HEADER_SIZE		IMAGE_BLOCK
+#define IMAGE_SIZE		(IMAGE_BLOCK * 4)
+
+struct mgr_stats {
+	bool header_match;
+	bool image_match;
+	u32 seq_num;
+	u32 op_parse_header_seq;
+	u32 op_write_init_seq;
+	u32 op_write_seq;
+	u32 op_write_sg_seq;
+	u32 op_write_complete_seq;
+	enum fpga_mgr_states op_parse_header_state;
+	enum fpga_mgr_states op_write_init_state;
+	enum fpga_mgr_states op_write_state;
+	enum fpga_mgr_states op_write_sg_state;
+	enum fpga_mgr_states op_write_complete_state;
+};
+
+struct mgr_ctx {
+	struct fpga_image_info *img_info;
+	struct fpga_manager *mgr;
+	struct platform_device *pdev;
+	struct mgr_stats stats;
+};
+
+static char *init_test_buffer(struct kunit *test, size_t count)
+{
+	char *buf;
+	size_t i;
+
+	buf = kunit_kzalloc(test, count, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf);
+
+	for (i = 0; i < count; i++)
+		buf[i] = i < HEADER_SIZE ? HEADER_MAGIC : IMAGE_MAGIC;
+
+	return buf;
+}
+
+static int op_parse_header(struct fpga_manager *mgr, struct fpga_image_info *info,
+			   const char *buf, size_t count)
+{
+	struct mgr_stats *stats = mgr->priv;
+	size_t i;
+
+	/* Set header_size and data_size for later */
+	info->header_size = HEADER_SIZE;
+	info->data_size = info->count - HEADER_SIZE;
+
+	stats->header_match = true;
+
+	/* Check header */
+	for (i = 0; i < info->header_size; i++)
+		if (buf[i] != HEADER_MAGIC)
+			stats->header_match = false;
+
+	stats->op_parse_header_state = mgr->state;
+	stats->op_parse_header_seq = stats->seq_num++;
+
+	return 0;
+}
+
+static int op_write_init(struct fpga_manager *mgr, struct fpga_image_info *info,
+			 const char *buf, size_t count)
+{
+	struct mgr_stats *stats = mgr->priv;
+
+	stats->op_write_init_state = mgr->state;
+	stats->op_write_init_seq = stats->seq_num++;
+
+	return 0;
+}
+
+static int op_write(struct fpga_manager *mgr, const char *buf, size_t count)
+{
+	struct mgr_stats *stats = mgr->priv;
+	size_t i;
+
+	/* Check image */
+	stats->image_match = true;
+	for (i = 0; i < count; i++)
+		if (buf[i] != IMAGE_MAGIC)
+			stats->image_match = false;
+
+	stats->op_write_state = mgr->state;
+	stats->op_write_seq = stats->seq_num++;
+
+	return 0;
+}
+
+static int op_write_sg(struct fpga_manager *mgr, struct sg_table *sgt)
+{
+	struct mgr_stats *stats = mgr->priv;
+	struct scatterlist *sg;
+	char *img;
+	unsigned int si, i, j = 0;
+
+	stats->image_match = true;
+
+	/* Check image (write_sg will still get whole image in sg_table) */
+	for_each_sgtable_sg(sgt, sg, si) {
+		img = sg_virt(sg);
+		for (i = 0; i < sg->length; i++) {
+			if (i + j > HEADER_SIZE && img[i] != IMAGE_MAGIC)
+				stats->image_match = false;
+		}
+		j += i;
+	}
+
+	stats->op_write_sg_state = mgr->state;
+	stats->op_write_sg_seq = stats->seq_num++;
+
+	return 0;
+}
+
+static int op_write_complete(struct fpga_manager *mgr, struct fpga_image_info *info)
+{
+	struct mgr_stats *stats = mgr->priv;
+
+	stats->op_write_complete_state = mgr->state;
+	stats->op_write_complete_seq = stats->seq_num++;
+
+	return 0;
+}
+
+static const struct fpga_manager_ops fake_mgr_ops = {
+	.skip_header = true,
+	.parse_header = op_parse_header,
+	.write_init = op_write_init,
+	.write = op_write,
+	.write_sg = op_write_sg,
+	.write_complete = op_write_complete,
+};
+
+static void fpga_mgr_test_get(struct kunit *test)
+{
+	struct mgr_ctx *ctx = test->priv;
+	struct fpga_manager *mgr;
+
+	mgr = fpga_mgr_get(&ctx->pdev->dev);
+	KUNIT_EXPECT_PTR_EQ(test, mgr, ctx->mgr);
+
+	fpga_mgr_put(ctx->mgr);
+}
+
+static void fpga_mgr_test_lock(struct kunit *test)
+{
+	struct mgr_ctx *ctx = test->priv;
+	int ret;
+
+	ret = fpga_mgr_lock(ctx->mgr);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	ret = fpga_mgr_lock(ctx->mgr);
+	KUNIT_EXPECT_EQ(test, ret, -EBUSY);
+
+	fpga_mgr_unlock(ctx->mgr);
+}
+
+static void fpga_mgr_test_img_load_buf(struct kunit *test)
+{
+	struct mgr_ctx *ctx = test->priv;
+	char *img_buf;
+	int ret;
+
+	img_buf = init_test_buffer(test, IMAGE_SIZE);
+
+	ctx->img_info->count = IMAGE_SIZE;
+	ctx->img_info->buf = img_buf;
+
+	ret = fpga_mgr_load(ctx->mgr, ctx->img_info);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	KUNIT_EXPECT_TRUE(test, ctx->stats.header_match);
+	KUNIT_EXPECT_TRUE(test, ctx->stats.image_match);
+
+	KUNIT_EXPECT_EQ(test, ctx->stats.op_parse_header_state, FPGA_MGR_STATE_PARSE_HEADER);
+	KUNIT_EXPECT_EQ(test, ctx->stats.op_write_init_state, FPGA_MGR_STATE_WRITE_INIT);
+	KUNIT_EXPECT_EQ(test, ctx->stats.op_write_state, FPGA_MGR_STATE_WRITE);
+	KUNIT_EXPECT_EQ(test, ctx->stats.op_write_complete_state, FPGA_MGR_STATE_WRITE_COMPLETE);
+
+	KUNIT_EXPECT_EQ(test, ctx->stats.op_write_init_seq, ctx->stats.op_parse_header_seq + 1);
+	KUNIT_EXPECT_EQ(test, ctx->stats.op_write_seq, ctx->stats.op_parse_header_seq + 2);
+	KUNIT_EXPECT_EQ(test, ctx->stats.op_write_complete_seq, ctx->stats.op_parse_header_seq + 3);
+}
+
+static void fpga_mgr_test_img_load_sgt(struct kunit *test)
+{
+	struct mgr_ctx *ctx = test->priv;
+	struct sg_table *sgt;
+	char *img_buf;
+	int ret;
+
+	img_buf = init_test_buffer(test, IMAGE_SIZE);
+
+	sgt = kunit_kzalloc(test, sizeof(*sgt), GFP_KERNEL);
+	ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	sg_init_one(sgt->sgl, img_buf, IMAGE_SIZE);
+
+	ctx->img_info->sgt = sgt;
+
+	ret = fpga_mgr_load(ctx->mgr, ctx->img_info);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	KUNIT_EXPECT_TRUE(test, ctx->stats.header_match);
+	KUNIT_EXPECT_TRUE(test, ctx->stats.image_match);
+
+	KUNIT_EXPECT_EQ(test, ctx->stats.op_parse_header_state, FPGA_MGR_STATE_PARSE_HEADER);
+	KUNIT_EXPECT_EQ(test, ctx->stats.op_write_init_state, FPGA_MGR_STATE_WRITE_INIT);
+	KUNIT_EXPECT_EQ(test, ctx->stats.op_write_sg_state, FPGA_MGR_STATE_WRITE);
+	KUNIT_EXPECT_EQ(test, ctx->stats.op_write_complete_state, FPGA_MGR_STATE_WRITE_COMPLETE);
+
+	KUNIT_EXPECT_EQ(test, ctx->stats.op_write_init_seq, ctx->stats.op_parse_header_seq + 1);
+	KUNIT_EXPECT_EQ(test, ctx->stats.op_write_sg_seq, ctx->stats.op_parse_header_seq + 2);
+	KUNIT_EXPECT_EQ(test, ctx->stats.op_write_complete_seq, ctx->stats.op_parse_header_seq + 3);
+
+	sg_free_table(ctx->img_info->sgt);
+}
+
+static int fpga_mgr_test_init(struct kunit *test)
+{
+	struct mgr_ctx *ctx;
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+
+	ctx->pdev = platform_device_register_simple("mgr_pdev", PLATFORM_DEVID_AUTO, NULL, 0);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->pdev);
+
+	ctx->mgr = devm_fpga_mgr_register(&ctx->pdev->dev, "Fake FPGA Manager", &fake_mgr_ops,
+					  &ctx->stats);
+	KUNIT_ASSERT_FALSE(test, IS_ERR_OR_NULL(ctx->mgr));
+
+	ctx->img_info = fpga_image_info_alloc(&ctx->pdev->dev);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->img_info);
+
+	test->priv = ctx;
+
+	return 0;
+}
+
+static void fpga_mgr_test_exit(struct kunit *test)
+{
+	struct mgr_ctx *ctx = test->priv;
+
+	fpga_image_info_free(ctx->img_info);
+	platform_device_unregister(ctx->pdev);
+}
+
+static struct kunit_case fpga_mgr_test_cases[] = {
+	KUNIT_CASE(fpga_mgr_test_get),
+	KUNIT_CASE(fpga_mgr_test_lock),
+	KUNIT_CASE(fpga_mgr_test_img_load_buf),
+	KUNIT_CASE(fpga_mgr_test_img_load_sgt),
+	{}
+};
+
+static struct kunit_suite fpga_mgr_suite = {
+	.name = "fpga_mgr",
+	.init = fpga_mgr_test_init,
+	.exit = fpga_mgr_test_exit,
+	.test_cases = fpga_mgr_test_cases,
+};
+
+kunit_test_suite(fpga_mgr_suite);
+
+MODULE_LICENSE("GPL");
-- 
2.40.1


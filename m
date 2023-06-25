Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 838E173CED6
	for <lists+linux-fpga@lfdr.de>; Sun, 25 Jun 2023 09:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjFYHM0 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 25 Jun 2023 03:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbjFYHMZ (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 25 Jun 2023 03:12:25 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D777FE75;
        Sun, 25 Jun 2023 00:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687677143; x=1719213143;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4/wVAC43F0bRmZJRuBpBJGcCQsfCU0YfQMzZiWSSc5Y=;
  b=LrZxdsO4MXss7wiP5zeZC5FXLmW6WgF9PtZzyrEDfvFRBkoFAIfIptXG
   6Uk6Q3t6wWnXHauN7u5L84XZV80W37v6oOOcppTfqrWg11aLacwMDmKnj
   kHc5GaLfw/bI44AhBbzXAlqxv+zBM+zWEYPh4HXt1RWCTgrJvkzeIOkms
   ZEwFrIOuJaKLS051UGJVKCjBCS2obsVKX/i/EM2OrZUKDFUc0Om8h8Wb5
   +/gQ0nruvvZw4LrnPzshT7LC2btp8/idVR2PCCRxKQfIToTRykx+IaizT
   cjb1RaIYR8FvylRsAHIQyg9T60L6rsRWBUDH/GWb8YR29T0rNQT+wx4+P
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10751"; a="361072280"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="361072280"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2023 00:12:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10751"; a="962406881"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="962406881"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga006.fm.intel.com with ESMTP; 25 Jun 2023 00:12:21 -0700
Date:   Sun, 25 Jun 2023 15:11:15 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Marco Pagani <marpagan@redhat.com>
Cc:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: Re: [PATCH v7 1/4] fpga: add an initial KUnit suite for the FPGA
 Manager
Message-ID: <ZJfokyHdapZEgTyY@yilunxu-OptiPlex-7050>
References: <20230616154405.220502-1-marpagan@redhat.com>
 <20230616154405.220502-2-marpagan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616154405.220502-2-marpagan@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2023-06-16 at 17:44:02 +0200, Marco Pagani wrote:
> The suite tests the basic behaviors of the FPGA Manager including
> programming using a single contiguous buffer and a scatter gather table.
> 
> Signed-off-by: Marco Pagani <marpagan@redhat.com>
> ---
>  drivers/fpga/tests/fpga-mgr-test.c | 302 +++++++++++++++++++++++++++++
>  1 file changed, 302 insertions(+)
>  create mode 100644 drivers/fpga/tests/fpga-mgr-test.c
> 
> diff --git a/drivers/fpga/tests/fpga-mgr-test.c b/drivers/fpga/tests/fpga-mgr-test.c
> new file mode 100644
> index 000000000000..70e897dad3b6
> --- /dev/null
> +++ b/drivers/fpga/tests/fpga-mgr-test.c
> @@ -0,0 +1,302 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * KUnit test for the FPGA Manager
> + *
> + * Copyright (C) 2023 Red Hat, Inc.
> + *
> + * Author: Marco Pagani <marpagan@redhat.com>
> + */
> +
> +#include <linux/types.h>
> +#include <linux/module.h>
> +#include <linux/device.h>
> +#include <linux/scatterlist.h>
> +#include <kunit/test.h>
> +#include <linux/fpga/fpga-mgr.h>

alphabetical order please

> +
> +#define HEADER_FILL		'H'
> +#define IMAGE_FILL		'P'
> +#define IMAGE_BLOCK		1024
> +
> +#define HEADER_SIZE		IMAGE_BLOCK
> +#define IMAGE_SIZE		(IMAGE_BLOCK * 4)
> +
> +struct mgr_stats {
> +	bool header_match;
> +	bool image_match;
> +	u32 seq_num;
> +	u32 op_parse_header_seq;
> +	u32 op_write_init_seq;
> +	u32 op_write_seq;
> +	u32 op_write_sg_seq;
> +	u32 op_write_complete_seq;
> +	enum fpga_mgr_states op_parse_header_state;
> +	enum fpga_mgr_states op_write_init_state;
> +	enum fpga_mgr_states op_write_state;
> +	enum fpga_mgr_states op_write_sg_state;
> +	enum fpga_mgr_states op_write_complete_state;
> +};
> +
> +struct mgr_ctx {
> +	struct fpga_image_info *img_info;
> +	struct fpga_manager *mgr;
> +	struct platform_device *pdev;
> +	struct mgr_stats stats;
> +};
> +
> +/**
> + * init_test_buffer() - Allocate and initialize a test image in a buffer.
> + * @test: KUnit test context object.
> + * @count: image size in bytes.
> + *
> + * Return: pointer to the newly allocated image.
> + */
> +static char *init_test_buffer(struct kunit *test, size_t count)
> +{
> +	char *buf;
> +	size_t i;
> +
> +	buf = kunit_kzalloc(test, count, GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf);
> +
> +	for (i = 0; i < count; i++)
> +		buf[i] = i < HEADER_SIZE ? HEADER_FILL : IMAGE_FILL;

memset?

> +
> +	return buf;
> +}
> +
> +static int op_parse_header(struct fpga_manager *mgr, struct fpga_image_info *info,
> +			   const char *buf, size_t count)
> +{
> +	struct mgr_stats *stats = mgr->priv;
> +	size_t i;
> +
> +	/* Set header_size and data_size for later */
> +	info->header_size = HEADER_SIZE;
> +	info->data_size = info->count - HEADER_SIZE;
> +
> +	stats->header_match = true;
> +
> +	/* Check header */
> +	for (i = 0; i < info->header_size; i++)
> +		if (buf[i] != HEADER_FILL)
> +			stats->header_match = false;
> +
> +	stats->op_parse_header_state = mgr->state;
> +	stats->op_parse_header_seq = stats->seq_num++;
> +
> +	return 0;
> +}
> +
> +static int op_write_init(struct fpga_manager *mgr, struct fpga_image_info *info,
> +			 const char *buf, size_t count)
> +{
> +	struct mgr_stats *stats = mgr->priv;
> +
> +	stats->op_write_init_state = mgr->state;
> +	stats->op_write_init_seq = stats->seq_num++;
> +
> +	return 0;
> +}
> +
> +static int op_write(struct fpga_manager *mgr, const char *buf, size_t count)
> +{
> +	struct mgr_stats *stats = mgr->priv;
> +	size_t i;
> +
> +	/* Check image */
> +	stats->image_match = true;
> +	for (i = 0; i < count; i++)
> +		if (buf[i] != IMAGE_FILL)
> +			stats->image_match = false;
> +
> +	stats->op_write_state = mgr->state;
> +	stats->op_write_seq = stats->seq_num++;
> +
> +	return 0;
> +}
> +
> +static int op_write_sg(struct fpga_manager *mgr, struct sg_table *sgt)
> +{
> +	struct mgr_stats *stats = mgr->priv;
> +	struct scatterlist *sg;
> +	char *img;
> +	unsigned int si, i, j = 0;
> +
> +	stats->image_match = true;
> +
> +	/* Check image (write_sg will still get whole image in sg_table) */
> +	for_each_sgtable_sg(sgt, sg, si) {
> +		img = sg_virt(sg);
> +		for (i = 0; i < sg->length; i++) {
> +			if (i + j > HEADER_SIZE && img[i] != IMAGE_FILL)

Is it possible just use sg_miter_skip() to skip the image header?

> +				stats->image_match = false;
> +		}
> +		j += i;
> +	}
> +
> +	stats->op_write_sg_state = mgr->state;
> +	stats->op_write_sg_seq = stats->seq_num++;
> +
> +	return 0;
> +}
> +
> +static int op_write_complete(struct fpga_manager *mgr, struct fpga_image_info *info)
> +{
> +	struct mgr_stats *stats = mgr->priv;
> +
> +	stats->op_write_complete_state = mgr->state;
> +	stats->op_write_complete_seq = stats->seq_num++;
> +
> +	return 0;
> +}
> +
> +/*
> + * Fake Manager that implements all ops required to check the programming
> + * sequence using a single contiguous buffer and a scatter gather table.
> + */
> +static const struct fpga_manager_ops fake_mgr_ops = {
> +	.skip_header = true,
> +	.parse_header = op_parse_header,
> +	.write_init = op_write_init,
> +	.write = op_write,
> +	.write_sg = op_write_sg,
> +	.write_complete = op_write_complete,
> +};
> +
> +static void fpga_mgr_test_get(struct kunit *test)
> +{
> +	struct mgr_ctx *ctx = test->priv;
> +	struct fpga_manager *mgr;
> +
> +	mgr = fpga_mgr_get(&ctx->pdev->dev);
> +	KUNIT_EXPECT_PTR_EQ(test, mgr, ctx->mgr);
> +
> +	fpga_mgr_put(ctx->mgr);
> +}
> +
> +static void fpga_mgr_test_lock(struct kunit *test)
> +{
> +	struct mgr_ctx *ctx = test->priv;
> +	int ret;
> +
> +	ret = fpga_mgr_lock(ctx->mgr);
> +	KUNIT_EXPECT_EQ(test, ret, 0);
> +
> +	ret = fpga_mgr_lock(ctx->mgr);
> +	KUNIT_EXPECT_EQ(test, ret, -EBUSY);
> +
> +	fpga_mgr_unlock(ctx->mgr);
> +}
> +
> +/* Check the programming sequence using an image in a buffer */
> +static void fpga_mgr_test_img_load_buf(struct kunit *test)
> +{
> +	struct mgr_ctx *ctx = test->priv;
> +	char *img_buf;
> +	int ret;
> +
> +	img_buf = init_test_buffer(test, IMAGE_SIZE);
> +
> +	ctx->img_info->count = IMAGE_SIZE;
> +	ctx->img_info->buf = img_buf;
> +
> +	ret = fpga_mgr_load(ctx->mgr, ctx->img_info);
> +	KUNIT_EXPECT_EQ(test, ret, 0);
> +
> +	KUNIT_EXPECT_TRUE(test, ctx->stats.header_match);
> +	KUNIT_EXPECT_TRUE(test, ctx->stats.image_match);
> +
> +	KUNIT_EXPECT_EQ(test, ctx->stats.op_parse_header_state, FPGA_MGR_STATE_PARSE_HEADER);
> +	KUNIT_EXPECT_EQ(test, ctx->stats.op_write_init_state, FPGA_MGR_STATE_WRITE_INIT);
> +	KUNIT_EXPECT_EQ(test, ctx->stats.op_write_state, FPGA_MGR_STATE_WRITE);
> +	KUNIT_EXPECT_EQ(test, ctx->stats.op_write_complete_state, FPGA_MGR_STATE_WRITE_COMPLETE);
> +
> +	KUNIT_EXPECT_EQ(test, ctx->stats.op_write_init_seq, ctx->stats.op_parse_header_seq + 1);
> +	KUNIT_EXPECT_EQ(test, ctx->stats.op_write_seq, ctx->stats.op_parse_header_seq + 2);
> +	KUNIT_EXPECT_EQ(test, ctx->stats.op_write_complete_seq, ctx->stats.op_parse_header_seq + 3);
> +}
> +
> +/* Check the programming sequence using an image in a scatter gather table */
> +static void fpga_mgr_test_img_load_sgt(struct kunit *test)
> +{
> +	struct mgr_ctx *ctx = test->priv;
> +	struct sg_table *sgt;
> +	char *img_buf;
> +	int ret;
> +
> +	img_buf = init_test_buffer(test, IMAGE_SIZE);
> +
> +	sgt = kunit_kzalloc(test, sizeof(*sgt), GFP_KERNEL);
> +	ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
> +	KUNIT_ASSERT_EQ(test, ret, 0);
> +	sg_init_one(sgt->sgl, img_buf, IMAGE_SIZE);
> +
> +	ctx->img_info->sgt = sgt;
> +
> +	ret = fpga_mgr_load(ctx->mgr, ctx->img_info);
> +	KUNIT_EXPECT_EQ(test, ret, 0);
> +
> +	KUNIT_EXPECT_TRUE(test, ctx->stats.header_match);
> +	KUNIT_EXPECT_TRUE(test, ctx->stats.image_match);
> +
> +	KUNIT_EXPECT_EQ(test, ctx->stats.op_parse_header_state, FPGA_MGR_STATE_PARSE_HEADER);
> +	KUNIT_EXPECT_EQ(test, ctx->stats.op_write_init_state, FPGA_MGR_STATE_WRITE_INIT);
> +	KUNIT_EXPECT_EQ(test, ctx->stats.op_write_sg_state, FPGA_MGR_STATE_WRITE);
> +	KUNIT_EXPECT_EQ(test, ctx->stats.op_write_complete_state, FPGA_MGR_STATE_WRITE_COMPLETE);
> +
> +	KUNIT_EXPECT_EQ(test, ctx->stats.op_write_init_seq, ctx->stats.op_parse_header_seq + 1);
> +	KUNIT_EXPECT_EQ(test, ctx->stats.op_write_sg_seq, ctx->stats.op_parse_header_seq + 2);
> +	KUNIT_EXPECT_EQ(test, ctx->stats.op_write_complete_seq, ctx->stats.op_parse_header_seq + 3);
> +
> +	sg_free_table(ctx->img_info->sgt);
> +}
> +
> +static int fpga_mgr_test_init(struct kunit *test)
> +{
> +	struct mgr_ctx *ctx;
> +
> +	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
> +
> +	ctx->pdev = platform_device_register_simple("mgr_pdev", PLATFORM_DEVID_AUTO, NULL, 0);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->pdev);
> +
> +	ctx->mgr = devm_fpga_mgr_register(&ctx->pdev->dev, "Fake FPGA Manager", &fake_mgr_ops,
> +					  &ctx->stats);
> +	KUNIT_ASSERT_FALSE(test, IS_ERR_OR_NULL(ctx->mgr));
> +
> +	ctx->img_info = fpga_image_info_alloc(&ctx->pdev->dev);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->img_info);
> +
> +	test->priv = ctx;
> +
> +	return 0;
> +}
> +
> +static void fpga_mgr_test_exit(struct kunit *test)
> +{
> +	struct mgr_ctx *ctx = test->priv;
> +
> +	fpga_image_info_free(ctx->img_info);
> +	platform_device_unregister(ctx->pdev);
> +}
> +
> +static struct kunit_case fpga_mgr_test_cases[] = {
> +	KUNIT_CASE(fpga_mgr_test_get),
> +	KUNIT_CASE(fpga_mgr_test_lock),
> +	KUNIT_CASE(fpga_mgr_test_img_load_buf),
> +	KUNIT_CASE(fpga_mgr_test_img_load_sgt),
> +	{}
> +};
> +
> +static struct kunit_suite fpga_mgr_suite = {
> +	.name = "fpga_mgr",
> +	.init = fpga_mgr_test_init,
> +	.exit = fpga_mgr_test_exit,
> +	.test_cases = fpga_mgr_test_cases,
> +};
> +
> +kunit_test_suite(fpga_mgr_suite);
> +
> +MODULE_LICENSE("GPL");
> -- 
> 2.40.1
> 

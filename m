Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDB6473FCD7
	for <lists+linux-fpga@lfdr.de>; Tue, 27 Jun 2023 15:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbjF0NZA (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 27 Jun 2023 09:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjF0NYd (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 27 Jun 2023 09:24:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA352728
        for <linux-fpga@vger.kernel.org>; Tue, 27 Jun 2023 06:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687872223;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tGxhg8QGQ9+BpJAoqUPu1JIoDVbHcL8KnysND43NiuE=;
        b=Bj6hWLBHfG3NVlvutprbthzcSsx8lACBHaRsqGGUxU7pgKQohqBZzmVMbgPhuNXz9tURZM
        wMgei0lQumMEG7bcE/3Jm9IW5l++/jL33xQCFEyH0yafP/wsASuv5Ylnt8nimNUnGWcOSb
        DYDVFg2Hw4aGWMbU8g0cdCU1FkzF0Sg=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274-q6TP7ltCPyqtOh8xA3_9Dg-1; Tue, 27 Jun 2023 09:23:40 -0400
X-MC-Unique: q6TP7ltCPyqtOh8xA3_9Dg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-987ffac39e3so308686566b.0
        for <linux-fpga@vger.kernel.org>; Tue, 27 Jun 2023 06:23:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687872214; x=1690464214;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tGxhg8QGQ9+BpJAoqUPu1JIoDVbHcL8KnysND43NiuE=;
        b=NVBa7NRMNvcr6TDvEQk/lmrLliomMNfBU1SuEMv9UXwUtrU0TqS1zSblAH7prwrLTx
         yiXt/NqoNdtZqNty1DIjdQbcrVU5PBVp8Gg0+5JKaoNaSsp+gfwOn/f81yk6IelIm0p6
         1zq5JmkS4k6ZGppfuZfhhLYx1yXgWSyj+plbM4HBoPC0C2zP+b4nIBp59cj0mWwK3Fia
         Ntin+CZWuCvYcl5K4COT23P6VGqVtQqjyrjUFPl1iV5Vngw9Qiawm6tU/EenHC5sVEqx
         JsRr/OfwhUEvulGSH6ISGVM8pbvLW/p6Z4PAyQfT3F2md7Q8qerZM98ZP9jYYIQY5v3D
         yqbw==
X-Gm-Message-State: AC+VfDxX3iBVIP+DinnTKol1FmSV/ILKBHrwa4tJtDl6xHoh2Yfc799q
        DGj3aT5Lz9yf0ezE1wB9BGkO6IxRviIx3JmX451id1ZJv/WWHQS3w3nK7hEGSDryvVqCzsOtmRt
        +w+w86eVmku5dqnYC0P7G
X-Received: by 2002:a17:907:6d1f:b0:991:d336:9b32 with SMTP id sa31-20020a1709076d1f00b00991d3369b32mr4605042ejc.35.1687872213996;
        Tue, 27 Jun 2023 06:23:33 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7ZI6wqeMqj0mC7/1kR2G2bIYUZUExPbAvxtZ249lLZ7QyeDSV0ok3T7mdKpUcxIdnPlIifmQ==
X-Received: by 2002:a17:907:6d1f:b0:991:d336:9b32 with SMTP id sa31-20020a1709076d1f00b00991d3369b32mr4605021ejc.35.1687872213562;
        Tue, 27 Jun 2023 06:23:33 -0700 (PDT)
Received: from [192.168.9.16] (net-2-34-24-242.cust.vodafonedsl.it. [2.34.24.242])
        by smtp.gmail.com with ESMTPSA id w6-20020a17090633c600b0098748422178sm4516770eja.56.2023.06.27.06.23.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 06:23:33 -0700 (PDT)
Message-ID: <d230b259-b3b2-c6b1-1238-c3f04587f340@redhat.com>
Date:   Tue, 27 Jun 2023 15:23:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v7 1/4] fpga: add an initial KUnit suite for the FPGA
 Manager
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
References: <20230616154405.220502-1-marpagan@redhat.com>
 <20230616154405.220502-2-marpagan@redhat.com>
 <ZJfokyHdapZEgTyY@yilunxu-OptiPlex-7050>
Content-Language: en-US
From:   Marco Pagani <marpagan@redhat.com>
In-Reply-To: <ZJfokyHdapZEgTyY@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 2023-06-25 09:11, Xu Yilun wrote:
> On 2023-06-16 at 17:44:02 +0200, Marco Pagani wrote:
>> The suite tests the basic behaviors of the FPGA Manager including
>> programming using a single contiguous buffer and a scatter gather table.
>>
>> Signed-off-by: Marco Pagani <marpagan@redhat.com>
>> ---
>>  drivers/fpga/tests/fpga-mgr-test.c | 302 +++++++++++++++++++++++++++++
>>  1 file changed, 302 insertions(+)
>>  create mode 100644 drivers/fpga/tests/fpga-mgr-test.c
>>
>> diff --git a/drivers/fpga/tests/fpga-mgr-test.c b/drivers/fpga/tests/fpga-mgr-test.c
>> new file mode 100644
>> index 000000000000..70e897dad3b6
>> --- /dev/null
>> +++ b/drivers/fpga/tests/fpga-mgr-test.c
>> @@ -0,0 +1,302 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * KUnit test for the FPGA Manager
>> + *
>> + * Copyright (C) 2023 Red Hat, Inc.
>> + *
>> + * Author: Marco Pagani <marpagan@redhat.com>
>> + */
>> +
>> +#include <linux/types.h>
>> +#include <linux/module.h>
>> +#include <linux/device.h>
>> +#include <linux/scatterlist.h>
>> +#include <kunit/test.h>
>> +#include <linux/fpga/fpga-mgr.h>
> 
> alphabetical order please
>

I'll sort all includes alphabetically in the next version.

>> +
>> +#define HEADER_FILL		'H'
>> +#define IMAGE_FILL		'P'
>> +#define IMAGE_BLOCK		1024
>> +
>> +#define HEADER_SIZE		IMAGE_BLOCK
>> +#define IMAGE_SIZE		(IMAGE_BLOCK * 4)
>> +
>> +struct mgr_stats {
>> +	bool header_match;
>> +	bool image_match;
>> +	u32 seq_num;
>> +	u32 op_parse_header_seq;
>> +	u32 op_write_init_seq;
>> +	u32 op_write_seq;
>> +	u32 op_write_sg_seq;
>> +	u32 op_write_complete_seq;
>> +	enum fpga_mgr_states op_parse_header_state;
>> +	enum fpga_mgr_states op_write_init_state;
>> +	enum fpga_mgr_states op_write_state;
>> +	enum fpga_mgr_states op_write_sg_state;
>> +	enum fpga_mgr_states op_write_complete_state;
>> +};
>> +
>> +struct mgr_ctx {
>> +	struct fpga_image_info *img_info;
>> +	struct fpga_manager *mgr;
>> +	struct platform_device *pdev;
>> +	struct mgr_stats stats;
>> +};
>> +
>> +/**
>> + * init_test_buffer() - Allocate and initialize a test image in a buffer.
>> + * @test: KUnit test context object.
>> + * @count: image size in bytes.
>> + *
>> + * Return: pointer to the newly allocated image.
>> + */
>> +static char *init_test_buffer(struct kunit *test, size_t count)
>> +{
>> +	char *buf;
>> +	size_t i;
>> +
>> +	buf = kunit_kzalloc(test, count, GFP_KERNEL);
>> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf);
>> +
>> +	for (i = 0; i < count; i++)
>> +		buf[i] = i < HEADER_SIZE ? HEADER_FILL : IMAGE_FILL;
> 
> memset?
>

Okay, I'll use memset in the next version.

>> +
>> +	return buf;
>> +}
>> +
>> +static int op_parse_header(struct fpga_manager *mgr, struct fpga_image_info *info,
>> +			   const char *buf, size_t count)
>> +{
>> +	struct mgr_stats *stats = mgr->priv;
>> +	size_t i;
>> +
>> +	/* Set header_size and data_size for later */
>> +	info->header_size = HEADER_SIZE;
>> +	info->data_size = info->count - HEADER_SIZE;
>> +
>> +	stats->header_match = true;
>> +
>> +	/* Check header */
>> +	for (i = 0; i < info->header_size; i++)
>> +		if (buf[i] != HEADER_FILL)
>> +			stats->header_match = false;
>> +
>> +	stats->op_parse_header_state = mgr->state;
>> +	stats->op_parse_header_seq = stats->seq_num++;
>> +
>> +	return 0;
>> +}
>> +
>> +static int op_write_init(struct fpga_manager *mgr, struct fpga_image_info *info,
>> +			 const char *buf, size_t count)
>> +{
>> +	struct mgr_stats *stats = mgr->priv;
>> +
>> +	stats->op_write_init_state = mgr->state;
>> +	stats->op_write_init_seq = stats->seq_num++;
>> +
>> +	return 0;
>> +}
>> +
>> +static int op_write(struct fpga_manager *mgr, const char *buf, size_t count)
>> +{
>> +	struct mgr_stats *stats = mgr->priv;
>> +	size_t i;
>> +
>> +	/* Check image */
>> +	stats->image_match = true;
>> +	for (i = 0; i < count; i++)
>> +		if (buf[i] != IMAGE_FILL)
>> +			stats->image_match = false;
>> +
>> +	stats->op_write_state = mgr->state;
>> +	stats->op_write_seq = stats->seq_num++;
>> +
>> +	return 0;
>> +}
>> +
>> +static int op_write_sg(struct fpga_manager *mgr, struct sg_table *sgt)
>> +{
>> +	struct mgr_stats *stats = mgr->priv;
>> +	struct scatterlist *sg;
>> +	char *img;
>> +	unsigned int si, i, j = 0;
>> +
>> +	stats->image_match = true;
>> +
>> +	/* Check image (write_sg will still get whole image in sg_table) */
>> +	for_each_sgtable_sg(sgt, sg, si) {
>> +		img = sg_virt(sg);
>> +		for (i = 0; i < sg->length; i++) {
>> +			if (i + j > HEADER_SIZE && img[i] != IMAGE_FILL)
> 
> Is it possible just use sg_miter_skip() to skip the image header?
> 

I'll use sg_miter_* functions in the next version.

>> +				stats->image_match = false;
>> +		}
>> +		j += i;
>> +	}
>> +
>> +	stats->op_write_sg_state = mgr->state;
>> +	stats->op_write_sg_seq = stats->seq_num++;
>> +
>> +	return 0;
>> +}
>> +
>> +static int op_write_complete(struct fpga_manager *mgr, struct fpga_image_info *info)
>> +{
>> +	struct mgr_stats *stats = mgr->priv;
>> +
>> +	stats->op_write_complete_state = mgr->state;
>> +	stats->op_write_complete_seq = stats->seq_num++;
>> +
>> +	return 0;
>> +}
>> +
>> +/*
>> + * Fake Manager that implements all ops required to check the programming
>> + * sequence using a single contiguous buffer and a scatter gather table.
>> + */
>> +static const struct fpga_manager_ops fake_mgr_ops = {
>> +	.skip_header = true,
>> +	.parse_header = op_parse_header,
>> +	.write_init = op_write_init,
>> +	.write = op_write,
>> +	.write_sg = op_write_sg,
>> +	.write_complete = op_write_complete,
>> +};
>> +
>> +static void fpga_mgr_test_get(struct kunit *test)
>> +{
>> +	struct mgr_ctx *ctx = test->priv;
>> +	struct fpga_manager *mgr;
>> +
>> +	mgr = fpga_mgr_get(&ctx->pdev->dev);
>> +	KUNIT_EXPECT_PTR_EQ(test, mgr, ctx->mgr);
>> +
>> +	fpga_mgr_put(ctx->mgr);
>> +}
>> +
>> +static void fpga_mgr_test_lock(struct kunit *test)
>> +{
>> +	struct mgr_ctx *ctx = test->priv;
>> +	int ret;
>> +
>> +	ret = fpga_mgr_lock(ctx->mgr);
>> +	KUNIT_EXPECT_EQ(test, ret, 0);
>> +
>> +	ret = fpga_mgr_lock(ctx->mgr);
>> +	KUNIT_EXPECT_EQ(test, ret, -EBUSY);
>> +
>> +	fpga_mgr_unlock(ctx->mgr);
>> +}
>> +
>> +/* Check the programming sequence using an image in a buffer */
>> +static void fpga_mgr_test_img_load_buf(struct kunit *test)
>> +{
>> +	struct mgr_ctx *ctx = test->priv;
>> +	char *img_buf;
>> +	int ret;
>> +
>> +	img_buf = init_test_buffer(test, IMAGE_SIZE);
>> +
>> +	ctx->img_info->count = IMAGE_SIZE;
>> +	ctx->img_info->buf = img_buf;
>> +
>> +	ret = fpga_mgr_load(ctx->mgr, ctx->img_info);
>> +	KUNIT_EXPECT_EQ(test, ret, 0);
>> +
>> +	KUNIT_EXPECT_TRUE(test, ctx->stats.header_match);
>> +	KUNIT_EXPECT_TRUE(test, ctx->stats.image_match);
>> +
>> +	KUNIT_EXPECT_EQ(test, ctx->stats.op_parse_header_state, FPGA_MGR_STATE_PARSE_HEADER);
>> +	KUNIT_EXPECT_EQ(test, ctx->stats.op_write_init_state, FPGA_MGR_STATE_WRITE_INIT);
>> +	KUNIT_EXPECT_EQ(test, ctx->stats.op_write_state, FPGA_MGR_STATE_WRITE);
>> +	KUNIT_EXPECT_EQ(test, ctx->stats.op_write_complete_state, FPGA_MGR_STATE_WRITE_COMPLETE);
>> +
>> +	KUNIT_EXPECT_EQ(test, ctx->stats.op_write_init_seq, ctx->stats.op_parse_header_seq + 1);
>> +	KUNIT_EXPECT_EQ(test, ctx->stats.op_write_seq, ctx->stats.op_parse_header_seq + 2);
>> +	KUNIT_EXPECT_EQ(test, ctx->stats.op_write_complete_seq, ctx->stats.op_parse_header_seq + 3);
>> +}
>> +
>> +/* Check the programming sequence using an image in a scatter gather table */
>> +static void fpga_mgr_test_img_load_sgt(struct kunit *test)
>> +{
>> +	struct mgr_ctx *ctx = test->priv;
>> +	struct sg_table *sgt;
>> +	char *img_buf;
>> +	int ret;
>> +
>> +	img_buf = init_test_buffer(test, IMAGE_SIZE);
>> +
>> +	sgt = kunit_kzalloc(test, sizeof(*sgt), GFP_KERNEL);
>> +	ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
>> +	KUNIT_ASSERT_EQ(test, ret, 0);
>> +	sg_init_one(sgt->sgl, img_buf, IMAGE_SIZE);
>> +
>> +	ctx->img_info->sgt = sgt;
>> +
>> +	ret = fpga_mgr_load(ctx->mgr, ctx->img_info);
>> +	KUNIT_EXPECT_EQ(test, ret, 0);
>> +
>> +	KUNIT_EXPECT_TRUE(test, ctx->stats.header_match);
>> +	KUNIT_EXPECT_TRUE(test, ctx->stats.image_match);
>> +
>> +	KUNIT_EXPECT_EQ(test, ctx->stats.op_parse_header_state, FPGA_MGR_STATE_PARSE_HEADER);
>> +	KUNIT_EXPECT_EQ(test, ctx->stats.op_write_init_state, FPGA_MGR_STATE_WRITE_INIT);
>> +	KUNIT_EXPECT_EQ(test, ctx->stats.op_write_sg_state, FPGA_MGR_STATE_WRITE);
>> +	KUNIT_EXPECT_EQ(test, ctx->stats.op_write_complete_state, FPGA_MGR_STATE_WRITE_COMPLETE);
>> +
>> +	KUNIT_EXPECT_EQ(test, ctx->stats.op_write_init_seq, ctx->stats.op_parse_header_seq + 1);
>> +	KUNIT_EXPECT_EQ(test, ctx->stats.op_write_sg_seq, ctx->stats.op_parse_header_seq + 2);
>> +	KUNIT_EXPECT_EQ(test, ctx->stats.op_write_complete_seq, ctx->stats.op_parse_header_seq + 3);
>> +
>> +	sg_free_table(ctx->img_info->sgt);
>> +}
>> +
>> +static int fpga_mgr_test_init(struct kunit *test)
>> +{
>> +	struct mgr_ctx *ctx;
>> +
>> +	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
>> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
>> +
>> +	ctx->pdev = platform_device_register_simple("mgr_pdev", PLATFORM_DEVID_AUTO, NULL, 0);
>> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->pdev);
>> +
>> +	ctx->mgr = devm_fpga_mgr_register(&ctx->pdev->dev, "Fake FPGA Manager", &fake_mgr_ops,
>> +					  &ctx->stats);
>> +	KUNIT_ASSERT_FALSE(test, IS_ERR_OR_NULL(ctx->mgr));
>> +
>> +	ctx->img_info = fpga_image_info_alloc(&ctx->pdev->dev);
>> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->img_info);
>> +
>> +	test->priv = ctx;
>> +
>> +	return 0;
>> +}
>> +
>> +static void fpga_mgr_test_exit(struct kunit *test)
>> +{
>> +	struct mgr_ctx *ctx = test->priv;
>> +
>> +	fpga_image_info_free(ctx->img_info);
>> +	platform_device_unregister(ctx->pdev);
>> +}
>> +
>> +static struct kunit_case fpga_mgr_test_cases[] = {
>> +	KUNIT_CASE(fpga_mgr_test_get),
>> +	KUNIT_CASE(fpga_mgr_test_lock),
>> +	KUNIT_CASE(fpga_mgr_test_img_load_buf),
>> +	KUNIT_CASE(fpga_mgr_test_img_load_sgt),
>> +	{}
>> +};
>> +
>> +static struct kunit_suite fpga_mgr_suite = {
>> +	.name = "fpga_mgr",
>> +	.init = fpga_mgr_test_init,
>> +	.exit = fpga_mgr_test_exit,
>> +	.test_cases = fpga_mgr_test_cases,
>> +};
>> +
>> +kunit_test_suite(fpga_mgr_suite);
>> +
>> +MODULE_LICENSE("GPL");
>> -- 
>> 2.40.1
>>
> 


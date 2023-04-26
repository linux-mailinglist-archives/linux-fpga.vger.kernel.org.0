Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A91E6EF7EA
	for <lists+linux-fpga@lfdr.de>; Wed, 26 Apr 2023 17:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239625AbjDZPpm (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 26 Apr 2023 11:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232584AbjDZPpl (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 26 Apr 2023 11:45:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83ECB4ECA
        for <linux-fpga@vger.kernel.org>; Wed, 26 Apr 2023 08:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682523892;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DlTRL1GwTI6pzsbx4OaM4kh9mkITLAPIxP7UTNVAlK8=;
        b=erCIXVYog8mhh3X5V0DGxIQjiMz91q5qvxfFh2LrwRWL7bwhRYfRGNwLk7wlXUfZNowFa/
        E4YM9gN7Ny1TtLnwvvcICbpTOcs0M2MIjxBW67SifAhsnrR7psCXw5tHxk5BuTCztaF+O3
        b2whkX45uO8u8mihQE+km2GEkXUKdp8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-NTiUXoSUMU6kyB5KToWtDA-1; Wed, 26 Apr 2023 11:44:51 -0400
X-MC-Unique: NTiUXoSUMU6kyB5KToWtDA-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-5ef41c0847cso48152086d6.1
        for <linux-fpga@vger.kernel.org>; Wed, 26 Apr 2023 08:44:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682523891; x=1685115891;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DlTRL1GwTI6pzsbx4OaM4kh9mkITLAPIxP7UTNVAlK8=;
        b=cCZ412Kx3TNRGc9IOv1Zt/LA+A3ajAjXw/SC3TjIA2slHiMLyNnUBxSY3V812ccyJS
         eL53qtLEgyMvJB5qN64nBd2tPdmoQ3NSEPVzssAPCSYDk5+PQXISI3BhjkKA2+ucyH8+
         ZkynVrsgVS1t7U0UtjEspYZ9lasgX3YYiX3jGo6Qq4+yHTF+fzONrYih/mLW/oJghEAJ
         7SDQ/zNepIrpAGZ+aBLTesUHJMpeZMFFqQMg9KFwPT6fBtVRK2YL6uaz9/QUipMpNn9h
         5o3m8mB/6Z7TQ/jxruoC0vc36rwcR/ZAglXymUN64F5aEcNynQaRykdcyVuMTIGZP8zr
         BIxw==
X-Gm-Message-State: AAQBX9d9UpxJyooaA0sGP4XY1KiM8yuDZ2sxO4PGnKGDu73kBvA3zFei
        kjs6E2+XBrl/P7A5/GZUFIhb4ovPbJRC/S0bBlYh6KunROkxsxqxpr6gpJpwzq8QKjaqS69NTiw
        2fD6mU/wg9duI0zOrlPrF
X-Received: by 2002:a05:6214:508b:b0:5ba:8af3:5d58 with SMTP id kk11-20020a056214508b00b005ba8af35d58mr34268483qvb.36.1682523890745;
        Wed, 26 Apr 2023 08:44:50 -0700 (PDT)
X-Google-Smtp-Source: AKy350YViSiODlulDMbtHjvRL5wFLcXzLKj33VGz6WyYQ2WVgR465YYm/EzU1tG2QFHHSgy4h8jkbQ==
X-Received: by 2002:a05:6214:508b:b0:5ba:8af3:5d58 with SMTP id kk11-20020a056214508b00b005ba8af35d58mr34268439qvb.36.1682523890374;
        Wed, 26 Apr 2023 08:44:50 -0700 (PDT)
Received: from [192.168.9.16] (net-2-34-28-169.cust.vodafonedsl.it. [2.34.28.169])
        by smtp.gmail.com with ESMTPSA id z21-20020ac86b95000000b003e64ea3faf7sm5411514qts.59.2023.04.26.08.44.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Apr 2023 08:44:50 -0700 (PDT)
Message-ID: <cef792a1-42c1-b262-b07e-529006fdcb6d@redhat.com>
Date:   Wed, 26 Apr 2023 17:44:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH v4 1/4] fpga: add fake FPGA manager
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
References: <20230417122308.131453-1-marpagan@redhat.com>
 <20230417122308.131453-2-marpagan@redhat.com>
 <ZEGE+UqTyKGTyv9h@yilunxu-OptiPlex-7050>
Content-Language: en-US
From:   Marco Pagani <marpagan@redhat.com>
In-Reply-To: <ZEGE+UqTyKGTyv9h@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 2023-04-20 20:31, Xu Yilun wrote:
> On 2023-04-17 at 14:23:05 +0200, Marco Pagani wrote:
>> Add fake FPGA manager platform driver with support functions.
>> The driver checks the programming sequence using KUnit expectations.
>> This module is part of the KUnit tests for the FPGA subsystem.
>>
>> Signed-off-by: Marco Pagani <marpagan@redhat.com>
>> ---
>>  drivers/fpga/tests/fake-fpga-mgr.c | 386 +++++++++++++++++++++++++++++
>>  drivers/fpga/tests/fake-fpga-mgr.h |  43 ++++
>>  2 files changed, 429 insertions(+)
>>  create mode 100644 drivers/fpga/tests/fake-fpga-mgr.c
>>  create mode 100644 drivers/fpga/tests/fake-fpga-mgr.h
>>
>> diff --git a/drivers/fpga/tests/fake-fpga-mgr.c b/drivers/fpga/tests/fake-fpga-mgr.c
>> new file mode 100644
>> index 000000000000..636df637b291
>> --- /dev/null
>> +++ b/drivers/fpga/tests/fake-fpga-mgr.c
>> @@ -0,0 +1,386 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Driver for the fake FPGA manager
>> + *
>> + * Copyright (C) 2023 Red Hat, Inc.
>> + *
>> + * Author: Marco Pagani <marpagan@redhat.com>
>> + */
>> +
>> +#include <linux/types.h>
>> +#include <linux/device.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/fpga/fpga-mgr.h>
>> +#include <kunit/test.h>
>> +
>> +#include "fake-fpga-mgr.h"
>> +
>> +#define FAKE_FPGA_MGR_DEV_NAME	"fake_fpga_mgr"
>> +
>> +#define FAKE_HEADER_BYTE	0x3f
>> +#define FAKE_HEADER_SIZE	FPGA_IMG_BLOCK
>> +
>> +struct fake_mgr_priv {
>> +	int rcfg_count;
>> +	bool op_parse_header;
>> +	bool op_write_init;
>> +	bool op_write;
>> +	bool op_write_sg;
>> +	bool op_write_complete;
>> +	struct kunit *test;
>> +};
>> +
>> +struct fake_mgr_data {
>> +	struct kunit *test;
>> +};
>> +
>> +static void check_header(struct kunit *test, const u8 *buf);
>> +
>> +static enum fpga_mgr_states op_state(struct fpga_manager *mgr)
>> +{
>> +	struct fake_mgr_priv *priv;
>> +
>> +	priv = mgr->priv;
>> +
>> +	if (priv->test)
>> +		kunit_info(priv->test, "Fake FPGA manager: state\n");
>> +
>> +	return FPGA_MGR_STATE_UNKNOWN;
>> +}
>> +
>> +static u64 op_status(struct fpga_manager *mgr)
>> +{
>> +	struct fake_mgr_priv *priv;
>> +
>> +	priv = mgr->priv;
>> +
>> +	if (priv->test)
>> +		kunit_info(priv->test, "Fake FPGA manager: status\n");
>> +
>> +	return 0;
>> +}
>> +
>> +static int op_parse_header(struct fpga_manager *mgr, struct fpga_image_info *info,
>> +			   const char *buf, size_t count)
>> +{
>> +	struct fake_mgr_priv *priv;
>> +
>> +	priv = mgr->priv;
>> +
>> +	if (priv->test) {
>> +		kunit_info(priv->test, "Fake FPGA manager: parse_header\n");
>> +
>> +		KUNIT_EXPECT_EQ(priv->test, mgr->state,
>> +				FPGA_MGR_STATE_PARSE_HEADER);
>> +
>> +		check_header(priv->test, buf);
>> +	}
>> +
>> +	priv->op_parse_header = true;
>> +
>> +	return 0;
>> +}
>> +
>> +static int op_write_init(struct fpga_manager *mgr, struct fpga_image_info *info,
>> +			 const char *buf, size_t count)
>> +{
>> +	struct fake_mgr_priv *priv;
>> +
>> +	priv = mgr->priv;
>> +
>> +	if (priv->test) {
>> +		kunit_info(priv->test, "Fake FPGA manager: write_init\n");
>> +
>> +		KUNIT_EXPECT_EQ(priv->test, mgr->state,
>> +				FPGA_MGR_STATE_WRITE_INIT);
>> +	}
>> +
>> +	priv->op_write_init = true;
>> +
>> +	return 0;
>> +}
>> +
>> +static int op_write(struct fpga_manager *mgr, const char *buf, size_t count)
>> +{
>> +	struct fake_mgr_priv *priv;
>> +
>> +	priv = mgr->priv;
>> +
>> +	if (priv->test) {
>> +		kunit_info(priv->test, "Fake FPGA manager: write\n");
>> +
>> +		KUNIT_EXPECT_EQ(priv->test, mgr->state,
>> +				FPGA_MGR_STATE_WRITE);
>> +	}
>> +
>> +	priv->op_write = true;
>> +
>> +	return 0;
>> +}
>> +
>> +static int op_write_sg(struct fpga_manager *mgr, struct sg_table *sgt)
>> +{
>> +	struct fake_mgr_priv *priv;
>> +
>> +	priv = mgr->priv;
>> +
>> +	if (priv->test) {
>> +		kunit_info(priv->test, "Fake FPGA manager: write_sg\n");
>> +
>> +		KUNIT_EXPECT_EQ(priv->test, mgr->state,
>> +				FPGA_MGR_STATE_WRITE);
>> +	}
>> +
>> +	priv->op_write_sg = true;
>> +
>> +	return 0;
>> +}
>> +
>> +static int op_write_complete(struct fpga_manager *mgr, struct fpga_image_info *info)
>> +{
>> +	struct fake_mgr_priv *priv;
>> +
>> +	priv = mgr->priv;
>> +
>> +	if (priv->test) {
>> +		kunit_info(priv->test, "Fake FPGA manager: write_complete\n");
>> +
>> +		KUNIT_EXPECT_EQ(priv->test, mgr->state,
>> +				FPGA_MGR_STATE_WRITE_COMPLETE);
>> +	}
>> +
>> +	priv->op_write_complete = true;
>> +	priv->rcfg_count++;
>> +
>> +	return 0;
>> +}
>> +
>> +static void op_fpga_remove(struct fpga_manager *mgr)
>> +{
>> +	struct fake_mgr_priv *priv;
>> +
>> +	priv = mgr->priv;
>> +
>> +	if (priv->test)
>> +		kunit_info(priv->test, "Fake FPGA manager: remove\n");
>> +}
>> +
>> +static const struct fpga_manager_ops fake_fpga_mgr_ops = {
>> +	.initial_header_size = FAKE_HEADER_SIZE,
>> +	.skip_header = false,
>> +	.state = op_state,
>> +	.status = op_status,
>> +	.parse_header = op_parse_header,
>> +	.write_init = op_write_init,
>> +	.write = op_write,
>> +	.write_sg = op_write_sg,
>> +	.write_complete = op_write_complete,
>> +	.fpga_remove = op_fpga_remove,
>> +};
>> +
>> +/**
>> + * fake_fpga_mgr_register() - register a fake FPGA manager.
>> + * @mgr_ctx: fake FPGA manager context data structure.
>> + * @test: KUnit test context object.
>> + *
>> + * Return: pointer to a new fake FPGA manager on success, an ERR_PTR()
>> + * encoded error code on failure.
>> + */
>> +struct fake_fpga_mgr *
>> +fake_fpga_mgr_register(struct kunit *test, struct device *parent)
>> +{
>> +	struct fake_fpga_mgr *mgr_ctx;
>> +	struct fake_mgr_data pdata;
>> +	int ret;
>> +
>> +	mgr_ctx = kzalloc(sizeof(*mgr_ctx), GFP_KERNEL);
>> +	if (!mgr_ctx) {
>> +		ret = -ENOMEM;
>> +		goto err_mem;
>> +	}
>> +
>> +	mgr_ctx->pdev = platform_device_alloc(FAKE_FPGA_MGR_DEV_NAME,
>> +					      PLATFORM_DEVID_AUTO);
>> +	if (!mgr_ctx->pdev) {
>> +		pr_err("Fake FPGA manager device allocation failed\n");
>> +		ret = -ENOMEM;
>> +		goto err_mem;
>> +	}
>> +
>> +	pdata.test = test;
>> +	platform_device_add_data(mgr_ctx->pdev, &pdata, sizeof(pdata));
>> +
>> +	mgr_ctx->pdev->dev.parent = parent;
>> +	ret = platform_device_add(mgr_ctx->pdev);
>> +	if (ret) {
>> +		pr_err("Fake FPGA manager device add failed\n");
>> +		goto err_pdev;
>> +	}
>> +
>> +	mgr_ctx->mgr = platform_get_drvdata(mgr_ctx->pdev);
>> +
>> +	if (test)
>> +		kunit_info(test, "Fake FPGA manager registered\n");
>> +
>> +	return mgr_ctx;
>> +
>> +err_pdev:
>> +	platform_device_put(mgr_ctx->pdev);
>> +	kfree(mgr_ctx);
>> +err_mem:
>> +	return ERR_PTR(ret);
>> +}
>> +EXPORT_SYMBOL_GPL(fake_fpga_mgr_register);
>> +
>> +/**
>> + * fake_fpga_mgr_unregister() - unregister a fake FPGA manager.
>> + * @mgr_ctx: fake FPGA manager context data structure.
>> + */
>> +void fake_fpga_mgr_unregister(struct fake_fpga_mgr *mgr_ctx)
>> +{
>> +	struct fake_mgr_priv *priv;
>> +	struct kunit *test;
>> +
>> +	if (!mgr_ctx)
>> +		return;
>> +
>> +	priv = mgr_ctx->mgr->priv;
>> +	test = priv->test;
>> +
>> +	if (mgr_ctx->pdev) {
>> +		platform_device_unregister(mgr_ctx->pdev);
>> +		if (test)
>> +			kunit_info(test, "Fake FPGA manager unregistered\n");
>> +	}
>> +
>> +	kfree(mgr_ctx);
>> +}
>> +EXPORT_SYMBOL_GPL(fake_fpga_mgr_unregister);
>> +
>> +/**
>> + * fake_fpga_mgr_get_rcfg_count() - get the number of reconfigurations.
>> + * @mgr_ctx: fake FPGA manager context data structure.
>> + *
>> + * Return: number of reconfigurations.
>> + */
>> +int fake_fpga_mgr_get_rcfg_count(const struct fake_fpga_mgr *mgr_ctx)
>> +{
>> +	struct fake_mgr_priv *priv;
>> +
>> +	priv = mgr_ctx->mgr->priv;
>> +
>> +	return priv->rcfg_count;
>> +}
>> +EXPORT_SYMBOL_GPL(fake_fpga_mgr_get_rcfg_count);
>> +
>> +/**
>> + * fake_fpga_mgr_fill_header() - fill an image buffer with the test header.
>> + * @buf: image buffer.
>> + */
>> +void fake_fpga_mgr_fill_header(u8 *buf)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < FAKE_HEADER_SIZE; i++)
>> +		buf[i] = FAKE_HEADER_BYTE;
>> +}
>> +EXPORT_SYMBOL_GPL(fake_fpga_mgr_fill_header);
>> +
>> +static void check_header(struct kunit *test, const u8 *buf)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < FAKE_HEADER_SIZE; i++)
>> +		KUNIT_EXPECT_EQ(test, buf[i], FAKE_HEADER_BYTE);
>> +}
>> +
>> +static void clear_op_flags(struct fake_mgr_priv *priv)
>> +{
>> +	priv->op_parse_header = false;
>> +	priv->op_write_init = false;
>> +	priv->op_write = false;
>> +	priv->op_write_sg = false;
>> +	priv->op_write_complete = false;
>> +}
>> +
>> +/**
>> + * fake_fpga_mgr_check_write_buf() - check if programming using a buffer succeeded.
>> + * @mgr_ctx: fake FPGA manager context data structure.
>> + */
>> +void fake_fpga_mgr_check_write_buf(struct fake_fpga_mgr *mgr_ctx)
>> +{
>> +	struct fake_mgr_priv *priv;
>> +
>> +	priv = mgr_ctx->mgr->priv;
>> +
>> +	if (priv->test) {
>> +		KUNIT_EXPECT_EQ(priv->test, priv->op_parse_header, true);
>> +		KUNIT_EXPECT_EQ(priv->test, priv->op_write_init, true);
>> +		KUNIT_EXPECT_EQ(priv->test, priv->op_write, true);
>> +		KUNIT_EXPECT_EQ(priv->test, priv->op_write_complete, true);
>> +	}
>> +
>> +	clear_op_flags(priv);
>> +}
>> +EXPORT_SYMBOL_GPL(fake_fpga_mgr_check_write_buf);
>> +
>> +/**
>> + * fake_fpga_mgr_check_write_sgt() - check if programming using a s.g. table succeeded.
>> + * @mgr_ctx: fake FPGA manager context data structure.
>> + */
>> +void fake_fpga_mgr_check_write_sgt(struct fake_fpga_mgr *mgr_ctx)
>> +{
>> +	struct fake_mgr_priv *priv;
>> +
>> +	priv = mgr_ctx->mgr->priv;
>> +
>> +	if (priv->test) {
>> +		KUNIT_EXPECT_EQ(priv->test, priv->op_parse_header, true);
>> +		KUNIT_EXPECT_EQ(priv->test, priv->op_write_init, true);
>> +		KUNIT_EXPECT_EQ(priv->test, priv->op_write_sg, true);
>> +		KUNIT_EXPECT_EQ(priv->test, priv->op_write_complete, true);
>> +	}
>> +
>> +	clear_op_flags(priv);
>> +}
>> +EXPORT_SYMBOL_GPL(fake_fpga_mgr_check_write_sgt);
> 
> I'm wondering, if we could move all these exported functions out of
> fake_fpga driver module. And make this driver module serves FPGA
> mgr framework only, just like other fpga drivers do.
> 
> I assume the main requirement is to check the statistics produced
> by the fake fpga driver. Directly accessing mgr->priv outside the
> driver could be unwanted.  To solve this, could we create a shared
> buffer for the statistics and pass to fake drivers by platform data.
> 
> I hope move all the tester's actions in fpga-test.c, so that people
> could easily see from code what a user need to do to enable fpga
> reprogramming and what are expected in one file. The fake drivers could
> be kept as simple, they only move the process forward and produce
> statistics.
> 
> Thanks,
> Yilun
>

I agree with you. Initially, I wanted to keep all KUnit test assertions
and expectations contained in fpga-test. However, I could not find a simple
way to test that the FPGA manager performs the correct state transitions
during programming. So I ended up putting KUnit assertions in the methods
of the low-level fake driver as a first solution.

I like your suggestion of using a shared buffer to have a cleaner
implementation. My only concern is that it would make the code more complex.
I will work on this for V5.

Thanks,
Marco


>> +
>> +static int fake_fpga_mgr_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev;
>> +	struct fake_mgr_priv *priv;
>> +	struct fake_mgr_data *pdata;
>> +	struct fpga_manager *mgr;
>> +
>> +	dev = &pdev->dev;
>> +	pdata = dev_get_platdata(dev);
>> +
>> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>> +	if (!priv)
>> +		return -ENOMEM;
>> +
>> +	if (pdata)
>> +		priv->test = pdata->test;
>> +
>> +	mgr = devm_fpga_mgr_register(dev, "Fake FPGA Manager",
>> +				     &fake_fpga_mgr_ops, priv);
>> +	if (IS_ERR(mgr))
>> +		return PTR_ERR(mgr);
>> +
>> +	platform_set_drvdata(pdev, mgr);
>> +
>> +	return 0;
>> +}
>> +
>> +static struct platform_driver fake_fpga_mgr_drv = {
>> +	.driver = {
>> +		.name = FAKE_FPGA_MGR_DEV_NAME
>> +	},
>> +	.probe = fake_fpga_mgr_probe,
>> +};
>> +
>> +module_platform_driver(fake_fpga_mgr_drv);
>> +
>> +MODULE_AUTHOR("Marco Pagani <marpagan@redhat.com>");
>> +MODULE_DESCRIPTION("Fake FPGA Manager");
>> +MODULE_LICENSE("GPL v2");
>> diff --git a/drivers/fpga/tests/fake-fpga-mgr.h b/drivers/fpga/tests/fake-fpga-mgr.h
>> new file mode 100644
>> index 000000000000..453672b5df72
>> --- /dev/null
>> +++ b/drivers/fpga/tests/fake-fpga-mgr.h
>> @@ -0,0 +1,43 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Header file for the fake FPGA manager
>> + *
>> + * Copyright (C) 2023 Red Hat, Inc.
>> + *
>> + * Author: Marco Pagani <marpagan@redhat.com>
>> + */
>> +
>> +#ifndef __FPGA_FAKE_MGR_H
>> +#define __FPGA_FAKE_MGR_H
>> +
>> +#include <linux/fpga/fpga-mgr.h>
>> +#include <linux/platform_device.h>
>> +#include <kunit/test.h>
>> +
>> +#define FPGA_IMG_BLOCK	1024
>> +
>> +/**
>> + * struct fake_fpga_mgr - fake FPGA manager context data structure
>> + *
>> + * @mgr: FPGA manager.
>> + * @pdev: platform device of the FPGA manager.
>> + */
>> +struct fake_fpga_mgr {
>> +	struct fpga_manager *mgr;
>> +	struct platform_device *pdev;
>> +};
>> +
>> +struct fake_fpga_mgr *
>> +fake_fpga_mgr_register(struct kunit *test, struct device *parent);
>> +
>> +void fake_fpga_mgr_unregister(struct fake_fpga_mgr *mgr_ctx);
>> +
>> +int fake_fpga_mgr_get_rcfg_count(const struct fake_fpga_mgr *mgr_ctx);
>> +
>> +void fake_fpga_mgr_fill_header(u8 *buf);
>> +
>> +void fake_fpga_mgr_check_write_buf(struct fake_fpga_mgr *mgr_ctx);
>> +
>> +void fake_fpga_mgr_check_write_sgt(struct fake_fpga_mgr *mgr_ctx);
>> +
>> +#endif /* __FPGA_FAKE_MGR_H */
>> -- 
>> 2.39.2
>>
> 


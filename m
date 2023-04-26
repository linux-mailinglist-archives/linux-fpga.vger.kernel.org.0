Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3E3A6EF85C
	for <lists+linux-fpga@lfdr.de>; Wed, 26 Apr 2023 18:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbjDZQWe (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 26 Apr 2023 12:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjDZQWd (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 26 Apr 2023 12:22:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC2307683
        for <linux-fpga@vger.kernel.org>; Wed, 26 Apr 2023 09:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682526105;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2OXep4zNHi4qTSZ6NcQM7JQ/r5lnL1zw8lhoPMi+9jk=;
        b=CI38XK2osJ7MFJbFAfWWwfdNG8DIH4rmUK0p5hZvz8KQ4+IBmxGl3f2IoP7sJqH65XlJ+e
        MzhJze+rEOPOKlHW9wIHMq0wFLRBXX9p9TL008fWl/07xPWD0RrHpuxFmtjpNvCcCjGjXg
        Co0xs3fvJbdzFy2X0Uv4qZyGpDsmy0I=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-C8lAP-QQPlOFSoWneXumWg-1; Wed, 26 Apr 2023 12:21:44 -0400
X-MC-Unique: C8lAP-QQPlOFSoWneXumWg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-2fa5d643cd8so2290710f8f.2
        for <linux-fpga@vger.kernel.org>; Wed, 26 Apr 2023 09:21:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682526103; x=1685118103;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2OXep4zNHi4qTSZ6NcQM7JQ/r5lnL1zw8lhoPMi+9jk=;
        b=iolBvpYxTIYqbppVJVMpMXWyrN6cMXmjOcllLl3j3WS1Bhy+9aCAhRqPLhM7yNU7HK
         HLUiod5VS1TcfvlhoodFXY4wxtS7rur1aJyE6C4oadK8zp/A7RnZ2VrFb+850fKlmDTH
         533y/4YoXLSkAfCexg5XyCja/0WJaWHpPSLQLuuhQJYQr06eBENl3LCaI77PO/xf7OoF
         zliSk0Amd2IG3QDxJ0IBDR6gFgKNIaUC/ZZtn9sE1wjp5j0l9c5+QI7lgAsuRfkXHfs1
         386iE6xzRkEC21nJHnFXxqnGDjoTRIXJVozn3P/8eOec2Mg81uEl6tz5j6ZugiSNDwhT
         H2ZA==
X-Gm-Message-State: AAQBX9e6o7npG0NdGilg9TeugP5LfNireusAoZX3p48zQKCsBnG3Ifzv
        5J1AxhFxDgYTa7HrFtsS1/0QbR8GEmhLlSm2PjhpEu363olutNKOntN095OCxNjxlf9gOPpMgHx
        lQtOLMyQSbYxTjpsr1tjx
X-Received: by 2002:a5d:5962:0:b0:2cf:ee9d:ce2f with SMTP id e34-20020a5d5962000000b002cfee9dce2fmr14816126wri.19.1682526103053;
        Wed, 26 Apr 2023 09:21:43 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZgaMKAQ4zUgM/jX2m3kP07MpmtQjNVd1W0IKLIq3RH/cyKshdQu/7VDp2BGOEiWd4a3fA/wA==
X-Received: by 2002:a5d:5962:0:b0:2cf:ee9d:ce2f with SMTP id e34-20020a5d5962000000b002cfee9dce2fmr14816105wri.19.1682526102688;
        Wed, 26 Apr 2023 09:21:42 -0700 (PDT)
Received: from [192.168.9.16] (net-2-34-28-169.cust.vodafonedsl.it. [2.34.28.169])
        by smtp.gmail.com with ESMTPSA id x9-20020a5d60c9000000b002fbdb797483sm16101222wrt.49.2023.04.26.09.21.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Apr 2023 09:21:42 -0700 (PDT)
Message-ID: <eebddf51-c83b-29f0-8ee7-703c2e383070@redhat.com>
Date:   Wed, 26 Apr 2023 18:21:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH v4 3/4] fpga: add fake FPGA region
Content-Language: en-US
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
References: <20230417122308.131453-1-marpagan@redhat.com>
 <20230417122308.131453-4-marpagan@redhat.com>
 <ZEGGpNQfUxsMUOnh@yilunxu-OptiPlex-7050>
From:   Marco Pagani <marpagan@redhat.com>
In-Reply-To: <ZEGGpNQfUxsMUOnh@yilunxu-OptiPlex-7050>
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



On 2023-04-20 20:38, Xu Yilun wrote:
> On 2023-04-17 at 14:23:07 +0200, Marco Pagani wrote:
>> Add fake FPGA region platform driver with support functions. This
>> module is part of the KUnit tests for the FPGA subsystem.
>>
>> Signed-off-by: Marco Pagani <marpagan@redhat.com>
>> ---
>>  drivers/fpga/tests/fake-fpga-region.c | 259 ++++++++++++++++++++++++++
>>  drivers/fpga/tests/fake-fpga-region.h |  40 ++++
>>  2 files changed, 299 insertions(+)
>>  create mode 100644 drivers/fpga/tests/fake-fpga-region.c
>>  create mode 100644 drivers/fpga/tests/fake-fpga-region.h
>>
>> diff --git a/drivers/fpga/tests/fake-fpga-region.c b/drivers/fpga/tests/fake-fpga-region.c
>> new file mode 100644
>> index 000000000000..b23ae5e94fe6
>> --- /dev/null
>> +++ b/drivers/fpga/tests/fake-fpga-region.c
>> @@ -0,0 +1,259 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Driver for the fake FPGA region
>> + *
>> + * Copyright (C) 2023 Red Hat, Inc.
>> + *
>> + * Author: Marco Pagani <marpagan@redhat.com>
>> + */
>> +
>> +#include <linux/device.h>
>> +#include <linux/list.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/fpga/fpga-mgr.h>
>> +#include <linux/fpga/fpga-region.h>
>> +#include <linux/fpga/fpga-bridge.h>
>> +#include <kunit/test.h>
>> +
>> +#include "fake-fpga-region.h"
>> +
>> +#define FAKE_FPGA_REGION_DEV_NAME	"fake_fpga_region"
>> +
>> +struct fake_region_priv {
>> +	int id;
>> +	struct kunit *test;
>> +	struct list_head bridge_list;
>> +};
>> +
>> +struct bridge_elem {
>> +	struct fpga_bridge *bridge;
>> +	struct list_head node;
>> +};
>> +
>> +struct fake_region_data {
>> +	struct fpga_manager *mgr;
>> +	struct kunit *test;
>> +};
>> +
>> +/**
>> + * fake_fpga_region_register() - register a fake FPGA region.
>> + * @mgr: associated FPGA manager.
>> + * @parent: parent device.
>> + * @test: KUnit test context object.
>> + *
>> + * Return: pointer to a new fake FPGA region on success, an ERR_PTR() encoded
>> + * error code on failure.
>> + */
>> +struct fake_fpga_region *
>> +fake_fpga_region_register(struct fpga_manager *mgr, struct device *parent,
>> +			  struct kunit *test)
>> +{
>> +	struct fake_fpga_region *region_ctx;
>> +	struct fake_region_data pdata;
>> +	struct fake_region_priv *priv;
>> +	int ret;
>> +
>> +	region_ctx = kzalloc(sizeof(*region_ctx), GFP_KERNEL);
>> +	if (!region_ctx) {
>> +		ret = -ENOMEM;
>> +		goto err_mem;
>> +	}
>> +
>> +	region_ctx->pdev = platform_device_alloc(FAKE_FPGA_REGION_DEV_NAME,
>> +						 PLATFORM_DEVID_AUTO);
>> +	if (!region_ctx->pdev) {
>> +		pr_err("Fake FPGA region device allocation failed\n");
>> +		ret = -ENOMEM;
>> +		goto err_mem;
>> +	}
>> +
>> +	pdata.mgr = mgr;
>> +	pdata.test = test;
>> +	platform_device_add_data(region_ctx->pdev, &pdata, sizeof(pdata));
>> +
>> +	region_ctx->pdev->dev.parent = parent;
>> +	ret = platform_device_add(region_ctx->pdev);
>> +	if (ret) {
>> +		pr_err("Fake FPGA region device add failed\n");
>> +		goto err_pdev;
>> +	}
>> +
>> +	region_ctx->region = platform_get_drvdata(region_ctx->pdev);
>> +
>> +	if (test) {
>> +		priv = region_ctx->region->priv;
>> +		kunit_info(test, "Fake FPGA region %d registered\n", priv->id);
>> +	}
>> +
>> +	return region_ctx;
>> +
>> +err_pdev:
>> +	platform_device_put(region_ctx->pdev);
>> +	kfree(region_ctx);
>> +err_mem:
>> +	return ERR_PTR(ret);
>> +}
>> +EXPORT_SYMBOL_GPL(fake_fpga_region_register);
>> +
>> +/**
>> + * fake_fpga_region_unregister() - unregister a fake FPGA region.
>> + * @region_ctx: fake FPGA region context data structure.
>> + */
>> +void fake_fpga_region_unregister(struct fake_fpga_region *region_ctx)
>> +{
>> +	struct fake_region_priv *priv;
>> +	struct kunit *test;
>> +	int id;
>> +
>> +	if (!region_ctx)
>> +		return;
>> +
>> +	priv = region_ctx->region->priv;
>> +	test = priv->test;
>> +	id = priv->id;
>> +
>> +	if (region_ctx->pdev) {
>> +		platform_device_unregister(region_ctx->pdev);
>> +		if (test)
>> +			kunit_info(test, "Fake FPGA region %d unregistered\n", id);
>> +	}
>> +
>> +	kfree(region_ctx);
>> +}
>> +EXPORT_SYMBOL_GPL(fake_fpga_region_unregister);
>> +
>> +/**
>> + * fake_fpga_region_add_bridge() - add a bridge to a fake FPGA region.
>> + * @region_ctx: fake FPGA region context data structure.
>> + * @bridge: FPGA bridge.
>> + *
>> + * Return: 0 if registration succeeded, an error code otherwise.
>> + */
>> +int fake_fpga_region_add_bridge(struct fake_fpga_region *region_ctx,
>> +				struct fpga_bridge *bridge)
>> +{
>> +	struct fake_region_priv *priv;
>> +	struct bridge_elem *elem;
>> +
>> +	priv = region_ctx->region->priv;
>> +
>> +	elem = devm_kzalloc(&region_ctx->pdev->dev, sizeof(*elem), GFP_KERNEL);
>> +	if (!elem)
>> +		return -ENOMEM;
>> +
>> +	/* Add bridge to the list of bridges in the private context */
>> +	elem->bridge = bridge;
>> +	list_add(&elem->node, &priv->bridge_list);
>> +
>> +	if (priv->test)
>> +		kunit_info(priv->test, "Bridge added to fake FPGA region %d\n",
>> +			   priv->id);
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(fake_fpga_region_add_bridge);
> 
> To move these exported functions out of fake driver, could we also provide
> the bridge list in platform_data?
> 
> Thanks,
> Yilun

I feel that the function for adding bridges to the fake region should belong
to the region driver itself rather than the fpga-test module. However, I can
certainly include the bridge list also in platform_data.

Thanks,
Marco


> 
>> +
>> +int fake_fpga_region_program(struct fake_fpga_region *region_ctx)
>> +{
>> +	int ret;
>> +
>> +	ret = fpga_region_program_fpga(region_ctx->region);
>> +
>> +	/* fpga_region_program_fpga() already puts the bridges in case of errors */
>> +	if (!ret)
>> +		fpga_bridges_put(&region_ctx->region->bridge_list);
>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(fake_fpga_region_program);
>> +
>> +static int fake_region_get_bridges(struct fpga_region *region)
>> +{
>> +	struct fake_region_priv *priv;
>> +	struct bridge_elem *elem;
>> +	int ret;
>> +
>> +	priv = region->priv;
>> +
>> +	/* Copy the list of bridges from the private context to the region */
>> +	list_for_each_entry(elem, &priv->bridge_list, node) {
>> +		ret = fpga_bridge_get_to_list(elem->bridge->dev.parent,
>> +					      region->info,
>> +					      &region->bridge_list);
>> +		if (ret)
>> +			break;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static int fake_fpga_region_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev;
>> +	struct fpga_region *region;
>> +	struct fpga_manager *mgr;
>> +	struct fake_region_data *pdata;
>> +	struct fake_region_priv *priv;
>> +	struct fpga_region_info info;
>> +	static int id_count;
>> +
>> +	dev = &pdev->dev;
>> +	pdata = dev_get_platdata(dev);
>> +
>> +	if (!pdata) {
>> +		dev_err(&pdev->dev, "Missing platform data\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>> +	if (!priv)
>> +		return -ENOMEM;
>> +
>> +	mgr = fpga_mgr_get(pdata->mgr->dev.parent);
>> +	if (IS_ERR(mgr))
>> +		return PTR_ERR(mgr);
>> +
>> +	INIT_LIST_HEAD(&priv->bridge_list);
>> +	priv->id = id_count++;
>> +	priv->test = pdata->test;
>> +
>> +	memset(&info, 0, sizeof(info));
>> +	info.priv = priv;
>> +	info.mgr = mgr;
>> +	info.get_bridges = fake_region_get_bridges;
>> +
>> +	region = fpga_region_register_full(dev, &info);
>> +	if (IS_ERR(region)) {
>> +		fpga_mgr_put(mgr);
>> +		return PTR_ERR(region);
>> +	}
>> +
>> +	platform_set_drvdata(pdev, region);
>> +
>> +	return 0;
>> +}
>> +
>> +static int fake_fpga_region_remove(struct platform_device *pdev)
>> +{
>> +	struct fpga_region *region = platform_get_drvdata(pdev);
>> +	struct fpga_manager *mgr = region->mgr;
>> +
>> +	fpga_mgr_put(mgr);
>> +	fpga_region_unregister(region);
>> +
>> +	return 0;
>> +}
>> +
>> +static struct platform_driver fake_fpga_region_drv = {
>> +	.driver = {
>> +		.name = FAKE_FPGA_REGION_DEV_NAME
>> +	},
>> +	.probe = fake_fpga_region_probe,
>> +	.remove = fake_fpga_region_remove,
>> +};
>> +
>> +module_platform_driver(fake_fpga_region_drv);
>> +
>> +MODULE_AUTHOR("Marco Pagani <marpagan@redhat.com>");
>> +MODULE_DESCRIPTION("Fake FPGA Bridge");
>> +MODULE_LICENSE("GPL v2");
>> diff --git a/drivers/fpga/tests/fake-fpga-region.h b/drivers/fpga/tests/fake-fpga-region.h
>> new file mode 100644
>> index 000000000000..976982c192bc
>> --- /dev/null
>> +++ b/drivers/fpga/tests/fake-fpga-region.h
>> @@ -0,0 +1,40 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Header file for the fake FPGA region
>> + *
>> + * Copyright (C) 2023 Red Hat, Inc.
>> + *
>> + * Author: Marco Pagani <marpagan@redhat.com>
>> + */
>> +
>> +#ifndef __FPGA_FAKE_RGN_H
>> +#define __FPGA_FAKE_RGN_H
>> +
>> +#include <linux/platform_device.h>
>> +#include <kunit/test.h>
>> +#include <linux/fpga/fpga-mgr.h>
>> +#include <linux/fpga/fpga-bridge.h>
>> +
>> +/**
>> + * struct fake_fpga_region - fake FPGA region context data structure
>> + *
>> + * @region: FPGA region.
>> + * @pdev: platform device of the FPGA region.
>> + */
>> +struct fake_fpga_region {
>> +	struct fpga_region *region;
>> +	struct platform_device *pdev;
>> +};
>> +
>> +struct fake_fpga_region *
>> +fake_fpga_region_register(struct fpga_manager *mgr, struct device *parent,
>> +			  struct kunit *test);
>> +
>> +int fake_fpga_region_add_bridge(struct fake_fpga_region *region_ctx,
>> +				struct fpga_bridge *bridge);
>> +
>> +int fake_fpga_region_program(struct fake_fpga_region *region_ctx);
>> +
>> +void fake_fpga_region_unregister(struct fake_fpga_region *region_ctx);
>> +
>> +#endif /* __FPGA_FAKE_RGN_H */
>> -- 
>> 2.39.2
>>
> 


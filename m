Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 652EE6C3B4D
	for <lists+linux-fpga@lfdr.de>; Tue, 21 Mar 2023 21:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjCUUI4 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 21 Mar 2023 16:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbjCUUIw (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 21 Mar 2023 16:08:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9262883E1
        for <linux-fpga@vger.kernel.org>; Tue, 21 Mar 2023 13:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679429268;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BVkVRqjx7xFcSolJZItC36k2JyBUQOXv1fWeiIscWG0=;
        b=b5xcPYBL8R/3fwGFw714iU5zMgD7ixDqwgcgoK6hjgnvXQoMRSmcpmtWvzhyZ0r5KJn7LO
        5Ipc6TitlTDA2qezX3Z7WUmMzaR3v0vT5hCKt/C3omlDoogz3xQYnCc62oLmjti1ndKgL+
        UA3qmCJQxC7B36P6cs0EV8keJn958Ew=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-RxWsWmGAN4qgvsLvNc60Xg-1; Tue, 21 Mar 2023 16:07:47 -0400
X-MC-Unique: RxWsWmGAN4qgvsLvNc60Xg-1
Received: by mail-qt1-f197.google.com with SMTP id u1-20020a05622a198100b003e12a0467easo4462367qtc.11
        for <linux-fpga@vger.kernel.org>; Tue, 21 Mar 2023 13:07:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679429267;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BVkVRqjx7xFcSolJZItC36k2JyBUQOXv1fWeiIscWG0=;
        b=UJzDyrfDOtDlefdWvky/KoPksmrM1hrv5hp8mHEmidqmYNFkp5Yo6XHJtI8VQfcO/h
         ryDjDo2SixkGBH2O2tO3sPyZ3i0j7qybRH1gdXhcesl8MuqQseqwUYbhG0gd+EEsJfYo
         FyaF1va0dB36M98zyEs3ZkCnLQXz5kDcTV+HxF9ryBqLvPmM1XXkRGsUm2Hoz5rQzFbu
         bNuf8kvd0MyWle7zzxB40GopEurHU62GtUrdyniHb1CrjLHs1E1aUPOvGfh9muH+I3UU
         Kmq3NQHo876qh2pBDETkWwkqeQuyhPu/pBLXeR1G7H2WlU0mYhw3/46Uuw63aHp7hKp5
         gGAA==
X-Gm-Message-State: AO0yUKWWgcMuKejxMWVsAYYGsfBIp+7ulJW1tAH0gRwsGus7diMr6IIK
        bnCBulYl+MJ32Ull3qkL3HT+z+pEuebPGfNRj2JZ5wQGsHiBoLTTIlf461Duo13J9EYGUo6O1p/
        fbPPS15pgyUGEaeOZMkCt
X-Received: by 2002:ac8:7d46:0:b0:3bd:89d:224d with SMTP id h6-20020ac87d46000000b003bd089d224dmr2181271qtb.3.1679429266884;
        Tue, 21 Mar 2023 13:07:46 -0700 (PDT)
X-Google-Smtp-Source: AK7set9hWS+Q0dnnm3S7yAOCcL3PcCykXH6Nabj++4oftgjJeRYESVVItxi9ncMXlKOlbBDMSrACag==
X-Received: by 2002:ac8:7d46:0:b0:3bd:89d:224d with SMTP id h6-20020ac87d46000000b003bd089d224dmr2181227qtb.3.1679429266476;
        Tue, 21 Mar 2023 13:07:46 -0700 (PDT)
Received: from [192.168.9.16] (net-2-34-29-20.cust.vodafonedsl.it. [2.34.29.20])
        by smtp.gmail.com with ESMTPSA id b14-20020a05620a270e00b0073b7f2a0bcbsm10142587qkp.36.2023.03.21.13.07.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 13:07:45 -0700 (PDT)
Message-ID: <7e717966-597d-0ce4-1152-ebf43a611a35@redhat.com>
Date:   Tue, 21 Mar 2023 21:07:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC PATCH v2 3/4] fpga: add fake FPGA region
Content-Language: en-US
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
References: <20230310170412.708363-1-marpagan@redhat.com>
 <20230310170412.708363-4-marpagan@redhat.com>
 <ZBRDu2/Kc142b8jJ@yilunxu-OptiPlex-7050>
From:   Marco Pagani <marpagan@redhat.com>
In-Reply-To: <ZBRDu2/Kc142b8jJ@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 2023-03-17 11:40, Xu Yilun wrote:
> On 2023-03-10 at 18:04:11 +0100, Marco Pagani wrote:
>> Add fake FPGA region platform driver with support functions. This
>> module is part of the KUnit tests for the FPGA subsystem.
>>
>> Signed-off-by: Marco Pagani <marpagan@redhat.com>
>> ---
>>  drivers/fpga/tests/fake-fpga-region.c | 219 ++++++++++++++++++++++++++
>>  drivers/fpga/tests/fake-fpga-region.h |  38 +++++
>>  2 files changed, 257 insertions(+)
>>  create mode 100644 drivers/fpga/tests/fake-fpga-region.c
>>  create mode 100644 drivers/fpga/tests/fake-fpga-region.h
>>
>> diff --git a/drivers/fpga/tests/fake-fpga-region.c b/drivers/fpga/tests/fake-fpga-region.c
>> new file mode 100644
>> index 000000000000..54d0e564728b
>> --- /dev/null
>> +++ b/drivers/fpga/tests/fake-fpga-region.c
>> @@ -0,0 +1,219 @@
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
>> +struct fake_region_data {
>> +	struct fpga_manager *mgr;
>> +	struct kunit *test;
>> +};
>> +
>> +/**
>> + * fake_fpga_region_register() - register a fake FPGA region.
>> + * @region_ctx: fake FPGA region context data structure.
>> + * @mgr: associated FPGA manager.
>> + * @parent: parent device.
>> + * @test: KUnit test context object.
>> + *
>> + * Return: 0 if registration succeeded, an error code otherwise.
>> + */
>> +int fake_fpga_region_register(struct fake_fpga_region *region_ctx,
>> +			      struct fpga_manager *mgr, struct device *parent,
>> +			      struct kunit *test)
>> +{
>> +	struct fake_region_data pdata;
>> +	struct fake_region_priv *priv;
>> +	int ret;
>> +
>> +	pdata.mgr = mgr;
>> +	pdata.test = test;
>> +
>> +	region_ctx->pdev = platform_device_alloc(FAKE_FPGA_REGION_DEV_NAME,
>> +						 PLATFORM_DEVID_AUTO);
>> +	if (IS_ERR(region_ctx->pdev)) {
>> +		pr_err("Fake FPGA region device allocation failed\n");
>> +		return -ENOMEM;
>> +	}
>> +
>> +	region_ctx->pdev->dev.parent = parent;
>> +	platform_device_add_data(region_ctx->pdev, &pdata, sizeof(pdata));
>> +
>> +	ret = platform_device_add(region_ctx->pdev);
>> +	if (ret) {
>> +		pr_err("Fake FPGA region device add failed\n");
>> +		platform_device_put(region_ctx->pdev);
>> +		return ret;
>> +	}
>> +
>> +	region_ctx->region = platform_get_drvdata(region_ctx->pdev);
>> +
>> +	if (test) {
>> +		priv = region_ctx->region->priv;
>> +		kunit_info(test, "Fake FPGA region %d registered\n", priv->id);
>> +	}
>> +
>> +	return 0;
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
>> +void fake_fpga_region_add_bridge(struct fake_fpga_region *region_ctx,
>> +				 struct fpga_bridge *bridge)
>> +{
>> +	struct fake_region_priv *priv;
>> +
>> +	priv = region_ctx->region->priv;
>> +
>> +	/* Add bridge to the list of bridges in the private context */
>> +	list_add(&bridge->node, &priv->bridge_list);
>> +
>> +	if (priv->test)
>> +		kunit_info(priv->test, "Bridge added to fake FPGA region %d\n",
>> +			   priv->id);
>> +}
>> +EXPORT_SYMBOL_GPL(fake_fpga_region_add_bridge);
>> +
>> +static int fake_region_get_bridges(struct fpga_region *region)
>> +{
>> +	struct fake_region_priv *priv;
>> +	struct fpga_bridge *bridge, *tmp;
>> +	int ret;
>> +
>> +	priv = region->priv;
>> +
>> +	list_for_each_entry_safe(bridge, tmp, &priv->bridge_list, node) {
>> +		list_del(&bridge->node);
> 
> I think the fake_fpga_region user just need to call
> fake_fpga_region_add_bridge() once on init, and may call
> fpga_bridges_put() at any time after fpga_region_program_fpga(), then
> you may lose the track of the bridges, which breaks the next
> fpga_region_program_fpga().
> 
> Thanks,
> Yilun
>

That's right, fake_fpga_region_add_bridge() is intended to be called once
(for each bridge) just after registering the region. I should have added
this to the kernel-doc description of the function.

When a fake region is unregistered, its bridges are released using
fpga_bridges_put() by the remove method of the platform driver.

In the fpga_test_static_cfg test case, the base region is configured
twice. Then, when the base region is unregistered by the exit method of
the test suite, the base bridge is released.

Here's the raw test output with dev_dbg() prints of the FPGA bridge
enabled:

    # Subtest: fpga
    1..2
    # fpga_test_static_cfg: Fake FPGA manager: state
    # fpga_test_static_cfg: Fake FPGA manager registered
    # fpga_test_static_cfg: Fake FPGA bridge 3 registered
    # fpga_test_static_cfg: Fake FPGA region 0 registered
    # fpga_test_static_cfg: Bridge added to fake FPGA region 0
    # fpga_test_static_cfg: FPGA base system built
    # fpga_test_static_cfg: Fake FPGA bridge 3: enable_show
    # fpga_test_static_cfg: FPGA image allocated in a buffer, size: 16384
fpga_bridge br0: get <---
fpga_bridge br0: disable
    # fpga_test_static_cfg: Fake FPGA bridge 3: enable_set: 0
    # fpga_test_static_cfg: Fake FPGA manager: parse_header
    # fpga_test_static_cfg: Fake FPGA manager: write_init
    # fpga_test_static_cfg: Fake FPGA manager: write
    # fpga_test_static_cfg: Fake FPGA manager: write_complete
fpga_bridge br0: enable
    # fpga_test_static_cfg: Fake FPGA bridge 3: enable_set: 1
    # fpga_test_static_cfg: Fake FPGA bridge 3: enable_show
    # fpga_test_static_cfg: FPGA configuration completed using a buffer image
    # fpga_test_static_cfg: FPGA image allocated in a scatter gather table, size: 16384
fpga_bridge br0: disable
    # fpga_test_static_cfg: Fake FPGA bridge 3: enable_set: 0
    # fpga_test_static_cfg: Fake FPGA manager: parse_header
    # fpga_test_static_cfg: Fake FPGA manager: write_init
    # fpga_test_static_cfg: Fake FPGA manager: write_sg
    # fpga_test_static_cfg: Fake FPGA manager: write_complete
fpga_bridge br0: enable
    # fpga_test_static_cfg: Fake FPGA bridge 3: enable_set: 1
    # fpga_test_static_cfg: Fake FPGA bridge 3: enable_show
    # fpga_test_static_cfg: FPGA configuration completed using scatter gather table image
fpga_bridge br0: put <---
    # fpga_test_static_cfg: Fake FPGA region 0 unregistered
    # fpga_test_static_cfg: Fake FPGA bridge: remove
    # fpga_test_static_cfg: Fake FPGA bridge 3 unregistered
fpga_manager fpga0: fpga_mgr_unregister Fake FPGA Manager
    # fpga_test_static_cfg: Fake FPGA manager: remove
    # fpga_test_static_cfg: Fake FPGA manager unregistered
    ok 1 fpga_test_static_cfg

In my understanding, of-region uses a similar approach by releasing
bridges only when the overlay is removed.


>> +		ret = fpga_bridge_get_to_list(bridge->dev.parent,
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
>> +	fpga_bridges_put(&region->bridge_list);
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
>> index 000000000000..9268ca335662
>> --- /dev/null
>> +++ b/drivers/fpga/tests/fake-fpga-region.h
>> @@ -0,0 +1,38 @@
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
>> +int fake_fpga_region_register(struct fake_fpga_region *region_ctx,
>> +			      struct fpga_manager *mgr, struct device *parent,
>> +			      struct kunit *test);
>> +
>> +void fake_fpga_region_add_bridge(struct fake_fpga_region *region_ctx,
>> +				 struct fpga_bridge *bridge);
>> +
>> +void fake_fpga_region_unregister(struct fake_fpga_region *region_ctx);
>> +
>> +#endif /* __FPGA_FAKE_RGN_H */
>> -- 
>> 2.39.2
>>
> 

Thanks,
Marco


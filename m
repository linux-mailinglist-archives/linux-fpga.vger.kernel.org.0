Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD5D6A6B1B
	for <lists+linux-fpga@lfdr.de>; Wed,  1 Mar 2023 11:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjCAKwc (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 1 Mar 2023 05:52:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjCAKwb (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 1 Mar 2023 05:52:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C914D36455
        for <linux-fpga@vger.kernel.org>; Wed,  1 Mar 2023 02:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677667909;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gIs1usQex0ll6DawZu+39nJ5HxG4saqbBsfI9UTeiMI=;
        b=N+2otFtP4yzuZWrXS7ntFGc6qJWdM2mxJR3z6lt72Reoi3UoCQLoJF90fx0Di2UZcoZm+e
        +1O7zbzmnLTtS0hUSXxTT1YiWWuCsS/Gn0VUvE/zoSBzfpuLss8RmXR0hkuoEId9uQT3cn
        Tb4pM7L7sM4z3B6I1JOmVbpeH0p4+Ys=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-255-bQJa5rxvMuicBq8gzzlLiw-1; Wed, 01 Mar 2023 05:51:47 -0500
X-MC-Unique: bQJa5rxvMuicBq8gzzlLiw-1
Received: by mail-wm1-f70.google.com with SMTP id n15-20020a05600c500f00b003dd07ce79c8so5183629wmr.1
        for <linux-fpga@vger.kernel.org>; Wed, 01 Mar 2023 02:51:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677667906;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gIs1usQex0ll6DawZu+39nJ5HxG4saqbBsfI9UTeiMI=;
        b=OlJi8Uzs/XskQ4j/in73s07kIoIFQ8HNlwLGpy7HEGECvm4T1mNwMUDVwoUgi7gJAe
         IyZ5xZ1GCNjDdR3y8B5URj1QLBNOCzXeaF/sPoUmkk6TTmBxQDvi8w1BaMuERuUsG5xv
         gnCtl6/5uLFLV293MZP2/d5Nzrua7myO0akJWWCTylgKezMvLPvyDd0FdQ1CuK8Wifes
         G0f5vmGUBPIM4YsdJ9JyGX/Ajvx4RsHAaIX7lgGEUgpyI+Q/n73lQdAVgKunxCZ06yWH
         GI/X/BCILLlifUvCD94jN/srHYCTZ4gX5igRIFVJBzWTB//qy9iA0mebnChVqwJzB54x
         lxbg==
X-Gm-Message-State: AO0yUKXcNJ8FQaL43xkAIg5VJie+jduPuolNMlA2nqMwfyAtcHX333XQ
        pjNQr8FDR/oWek0QLTPLC3nUm6JAj0oneBl/nIYVHIdBqi2eYFGJfK2+bs8YIvoLTW9OwKzOXbB
        GB+hoYVGzbHNrFCXfoh3R
X-Received: by 2002:adf:e101:0:b0:2c5:98f2:5b1d with SMTP id t1-20020adfe101000000b002c598f25b1dmr4706175wrz.63.1677667906592;
        Wed, 01 Mar 2023 02:51:46 -0800 (PST)
X-Google-Smtp-Source: AK7set9zdtmxRdljQjqrLAQKpPHUV8t27PMpeBlrMs3+VjF0xKGfh7nOH0UlM7Xvh5V3ecmWBwSx7A==
X-Received: by 2002:adf:e101:0:b0:2c5:98f2:5b1d with SMTP id t1-20020adfe101000000b002c598f25b1dmr4706166wrz.63.1677667906266;
        Wed, 01 Mar 2023 02:51:46 -0800 (PST)
Received: from [192.168.9.16] (net-2-34-29-20.cust.vodafonedsl.it. [2.34.29.20])
        by smtp.gmail.com with ESMTPSA id t3-20020a5d49c3000000b002c5804b6afasm12600596wrs.67.2023.03.01.02.51.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Mar 2023 02:51:45 -0800 (PST)
Message-ID: <98baa5ba-1254-86e5-de9b-ef1a03912a55@redhat.com>
Date:   Wed, 1 Mar 2023 11:51:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC PATCH 2/4] fpga: add fake FPGA region
Content-Language: en-US
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230203170653.414990-1-marpagan@redhat.com>
 <20230203170653.414990-3-marpagan@redhat.com>
 <Y/Ckw+F/sb2er2oK@yilunxu-OptiPlex-7050>
 <3f17060a-69ce-fb39-61ab-a892b9a1e8c6@redhat.com>
 <Y/hlUOy26HBfdJFR@yilunxu-OptiPlex-7050>
From:   Marco Pagani <marpagan@redhat.com>
In-Reply-To: <Y/hlUOy26HBfdJFR@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 2023-02-24 08:20, Xu Yilun wrote:
> On 2023-02-21 at 15:53:20 +0100, Marco Pagani wrote:
>>
>>
>> On 2023-02-18 11:13, Xu Yilun wrote:
>>> On 2023-02-03 at 18:06:51 +0100, Marco Pagani wrote:
>>>> Add fake FPGA region platform driver with support functions. This
>>>> module is part of the KUnit test suite for the FPGA subsystem.
>>>>
>>>> Signed-off-by: Marco Pagani <marpagan@redhat.com>
>>>> ---
>>>>  drivers/fpga/tests/fake-fpga-region.c | 186 ++++++++++++++++++++++++++
>>>>  drivers/fpga/tests/fake-fpga-region.h |  37 +++++
>>>>  2 files changed, 223 insertions(+)
>>>>  create mode 100644 drivers/fpga/tests/fake-fpga-region.c
>>>>  create mode 100644 drivers/fpga/tests/fake-fpga-region.h
>>>>
>>>> diff --git a/drivers/fpga/tests/fake-fpga-region.c b/drivers/fpga/tests/fake-fpga-region.c
>>>> new file mode 100644
>>>> index 000000000000..095397e41837
>>>> --- /dev/null
>>>> +++ b/drivers/fpga/tests/fake-fpga-region.c
>>>> @@ -0,0 +1,186 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +/*
>>>> + * Driver for fake FPGA region
>>>> + *
>>>> + * Copyright (C) 2023 Red Hat, Inc. All rights reserved.
>>>> + *
>>>> + * Author: Marco Pagani <marpagan@redhat.com>
>>>> + */
>>>> +
>>>> +#include <linux/device.h>
>>>> +#include <linux/platform_device.h>
>>>> +#include <linux/fpga/fpga-mgr.h>
>>>> +#include <linux/fpga/fpga-region.h>
>>>> +#include <linux/fpga/fpga-bridge.h>
>>>> +#include <kunit/test.h>
>>>> +
>>>> +#include "fake-fpga-region.h"
>>>> +
>>>> +#define FAKE_FPGA_REGION_DEV_NAME	"fake_fpga_region"
>>>> +
>>>> +struct fake_region_priv {
>>>> +	int id;
>>>> +	struct kunit *test;
>>>> +};
>>>> +
>>>> +struct fake_region_data {
>>>> +	struct fpga_manager *mgr;
>>>> +	struct kunit *test;
>>>> +};
>>>> +
>>>> +/**
>>>> + * fake_fpga_region_register - register a fake FPGA region
>>>> + * @region_ctx: fake FPGA region context data structure.
>>>> + * @test: KUnit test context object.
>>>> + *
>>>> + * Return: 0 if registration succeeded, an error code otherwise.
>>>> + */
>>>> +int fake_fpga_region_register(struct fake_fpga_region *region_ctx,
>>>> +			      struct fpga_manager *mgr, struct kunit *test)
>>>> +{
>>>> +	struct fake_region_data pdata;
>>>> +	struct fake_region_priv *priv;
>>>> +	int ret;
>>>> +
>>>> +	pdata.mgr = mgr;
>>>> +	pdata.test = test;
>>>> +
>>>> +	region_ctx->pdev = platform_device_alloc(FAKE_FPGA_REGION_DEV_NAME,
>>>> +						 PLATFORM_DEVID_AUTO);
>>>> +	if (IS_ERR(region_ctx->pdev)) {
>>>> +		pr_err("Fake FPGA region device allocation failed\n");
>>>> +		return -ENOMEM;
>>>> +	}
>>>> +
>>>> +	platform_device_add_data(region_ctx->pdev, &pdata, sizeof(pdata));
>>>> +
>>>> +	ret = platform_device_add(region_ctx->pdev);
>>>> +	if (ret) {
>>>> +		pr_err("Fake FPGA region device add failed\n");
>>>> +		platform_device_put(region_ctx->pdev);
>>>> +		return ret;
>>>> +	}
>>>> +
>>>> +	region_ctx->region = platform_get_drvdata(region_ctx->pdev);
>>>> +
>>>> +	if (test) {
>>>> +		priv = region_ctx->region->priv;
>>>> +		kunit_info(test, "Fake FPGA region %d registered\n", priv->id);
>>>> +	}
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(fake_fpga_region_register);
>>>> +
>>>> +/**
>>>> + * fake_fpga_region_unregister - unregister a fake FPGA region
>>>> + * @region_ctx: fake FPGA region context data structure.
>>>> + */
>>>> +void fake_fpga_region_unregister(struct fake_fpga_region *region_ctx)
>>>> +{
>>>> +	struct fake_region_priv *priv;
>>>> +	struct kunit *test;
>>>> +	int id;
>>>> +
>>>> +	priv = region_ctx->region->priv;
>>>> +	test = priv->test;
>>>> +	id = priv->id;
>>>> +
>>>> +	if (region_ctx->pdev) {
>>>> +		platform_device_unregister(region_ctx->pdev);
>>>> +		if (test)
>>>> +			kunit_info(test, "Fake FPGA region %d unregistered\n", id);
>>>> +	}
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(fake_fpga_region_unregister);
>>>> +
>>>> +/**
>>>> + * fake_fpga_region_add_bridge - add a bridge to a fake FPGA region
>>>> + * @region_ctx: fake FPGA region context data structure.
>>>> + * @bridge: FPGA bridge.
>>>> + *
>>>> + * Return: 0 if registration succeeded, an error code otherwise.
>>>> + */
>>>> +int fake_fpga_region_add_bridge(struct fake_fpga_region *region_ctx,
>>>> +				struct fpga_bridge *bridge)
>>>> +{
>>>> +	struct fake_region_priv *priv;
>>>> +	int ret;
>>>> +
>>>> +	priv = region_ctx->region->priv;
>>>> +
>>>> +	ret = fpga_bridge_get_to_list(bridge->dev.parent, NULL,
>>>> +				      &region_ctx->region->bridge_list);
>>>> +
>>>> +	if (priv->test && !ret)
>>>> +		kunit_info(priv->test, "Bridge added to fake FPGA region %d\n",
>>>> +			   priv->id);
>>>> +
>>>> +	return ret;
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(fake_fpga_region_add_bridge);
>>>> +
>>>> +static int fake_fpga_region_probe(struct platform_device *pdev)
>>>> +{
>>>> +	struct device *dev;
>>>> +	struct fpga_region *region;
>>>> +	struct fpga_manager *mgr;
>>>> +	struct fake_region_data *pdata;
>>>> +	struct fake_region_priv *priv;
>>>> +	static int id_count;
>>>> +
>>>> +	dev = &pdev->dev;
>>>> +	pdata = dev_get_platdata(dev);
>>>> +
>>>> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>>>> +	if (!priv)
>>>> +		return -ENOMEM;
>>>> +
>>>> +	mgr = fpga_mgr_get(pdata->mgr->dev.parent);
>>>> +	if (IS_ERR(mgr))
>>>> +		return PTR_ERR(mgr);
>>>> +
>>>> +	/*
>>>> +	 * No get_bridges() method since the bridges list is
>>>> +	 * pre-built using fake_fpga_region_add_bridge()
>>>> +	 */
>>>
>>> This is not the common use for drivers to associate the region & bridge,
>>> Better to realize the get_bridges() method.
>>
>> Initially, I was using a get_bridges() method to create the list of bridges
>> before each reconfiguration. However, this required having a "duplicated"
>> list of bridges in the context of the fake region low-level driver.
>>
>> Since I couldn't find a reason to keep a duplicate list of bridges in the
>> fake region driver, I decided then to change the approach and build the
>> list of bridges at device instantiation time.
>>
>> In my understanding, the approach of creating the list of bridges just
>> before reconfiguration with a get_bridges() method works best for the
>> OF case, where the topology is already encoded in the DT. I feel using
>> this approach on platforms without OF support would increase complexity
>> and create unnecessary duplication.
> 
> I'm not fully get your point. My understanding is we don't have to
> always grab the bridge driver module if we don't reprogram. In many
> cases, we just work with the existing bitstream before Linux is started.
> So generally I prefer not to have an example that gets all bridges at
> initialization unless there is a real need.

The fake region can be used without bridges to model the scenario where
the FPGA is statically configured by the bootloader.

I was referring to the choice between building the bridge list of the
region (fpga_region->bridge_list) ahead of programming vs. just before
programming.

Currently, fake_fpga_region_add_bridge() attaches the bridge directly
to the bridge_list of the fpga_region struct.

Alternatively, I could change fake_fpga_region_add_bridge() to attach
the bridge to a secondary list in the low-level driver. The secondary
list would then be copied to the fpga_region->bridge_list by a
get_bridges() method just before programming.

However, I feel that using this approach would make test code more
complicated than necessary. Ideally, I would like to keep fake modules
as simple as possible.


Thanks,
Marco


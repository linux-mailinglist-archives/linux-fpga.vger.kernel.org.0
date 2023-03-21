Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B06256C3861
	for <lists+linux-fpga@lfdr.de>; Tue, 21 Mar 2023 18:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbjCUReG (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 21 Mar 2023 13:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbjCUReD (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 21 Mar 2023 13:34:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C6A13538
        for <linux-fpga@vger.kernel.org>; Tue, 21 Mar 2023 10:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679419990;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LgfGTuq3iZNHpPTQKBE8qmgZ4CuvjtSnRz/xWCxlQVQ=;
        b=hldOgpagb7CvFSWydp1FMPKl+2QDS+ZhV2bOPDiFfSs6F2hKdGUmhODIfg18yIm3h+skdG
        WJLLJf7NxdveA+4+YaqdFBruw+FrueugxLJdsEYDruvkABqAJCyfHZA9lvSZaywXAZUxIL
        Wp0XdZRnwsR5xvh6n/LmJQT44tstkI0=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-3UxkBCCLMxSlLFXAU0WYOQ-1; Tue, 21 Mar 2023 13:33:09 -0400
X-MC-Unique: 3UxkBCCLMxSlLFXAU0WYOQ-1
Received: by mail-qk1-f200.google.com with SMTP id d187-20020a3768c4000000b00746864b272cso3134716qkc.15
        for <linux-fpga@vger.kernel.org>; Tue, 21 Mar 2023 10:33:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679419989;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LgfGTuq3iZNHpPTQKBE8qmgZ4CuvjtSnRz/xWCxlQVQ=;
        b=GFFGx921OinCYq8GlKJ0cbR1EjrL94JetTBRrDqmFLJxEgwphvINOxzA09emlJGjfy
         QNyMwI1dREKda1dxjBPPNIgrMGSHSjOPcbEnXNw0drz4z1tTGv3GvlJkHKgsAgWsDtTt
         qtfk+lDFYhKUO7IoBpvOEiQ1qSEzVt/h7llgwYUjf1XIFEdwmw/6OnWW1vCCmyj1HoWq
         GtFnOWDyEaFAWIfV4B9S/LyJbAZqR3vNW7Mwxv626BQz3rcXPVFXxLKzEuM9CvTylXHJ
         Y1gjjyvfjAH2uNUZKVstaAMVsWa0262CvoOifvJQBBlO2jWQiBu7/pOau1Tm1NrS59cY
         ZNHA==
X-Gm-Message-State: AO0yUKVIdziUDa3OoQ8FUQTf6ITNQ4SgyjAkOHUlrKq8zH4lIvXVgeBE
        q6xSLAwmJICf0yP4v2YlTDO3P9xxWpTJq5ObklNCUpLIhH5vJP+My78rhm38COsB1nkxpY8zOYN
        /gmPSI1x9Xon7DjSo3bCf
X-Received: by 2002:ac8:7c55:0:b0:3bf:c3f9:70a3 with SMTP id o21-20020ac87c55000000b003bfc3f970a3mr1208458qtv.26.1679419988945;
        Tue, 21 Mar 2023 10:33:08 -0700 (PDT)
X-Google-Smtp-Source: AK7set83+iaYCeYsz2V7w4NmnWFvf/0dfadMALWX0NW0OMPWEvU7qlhCb9nr2yBqkTGlddy+inC6CQ==
X-Received: by 2002:ac8:7c55:0:b0:3bf:c3f9:70a3 with SMTP id o21-20020ac87c55000000b003bfc3f970a3mr1208426qtv.26.1679419988621;
        Tue, 21 Mar 2023 10:33:08 -0700 (PDT)
Received: from [192.168.9.16] (net-2-34-29-20.cust.vodafonedsl.it. [2.34.29.20])
        by smtp.gmail.com with ESMTPSA id 196-20020a370acd000000b0074690b42617sm3125514qkk.15.2023.03.21.10.33.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 10:33:08 -0700 (PDT)
Message-ID: <988e8e8e-d514-4c69-a384-7d0a70c514c4@redhat.com>
Date:   Tue, 21 Mar 2023 18:33:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC PATCH v2 2/4] fpga: add fake FPGA bridge
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
References: <20230310170412.708363-1-marpagan@redhat.com>
 <20230310170412.708363-3-marpagan@redhat.com>
 <ZBQlnUQWZHJ+ZBu5@yilunxu-OptiPlex-7050>
Content-Language: en-US
From:   Marco Pagani <marpagan@redhat.com>
In-Reply-To: <ZBQlnUQWZHJ+ZBu5@yilunxu-OptiPlex-7050>
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



On 2023-03-17 09:32, Xu Yilun wrote:
> On 2023-03-10 at 18:04:10 +0100, Marco Pagani wrote:
>> Add fake FPGA bridge driver with support functions. The driver includes
>> a counter for the number of switching cycles. This module is part of
>> the KUnit tests for the FPGA subsystem.
>>
>> Signed-off-by: Marco Pagani <marpagan@redhat.com>
>> ---
>>  drivers/fpga/tests/fake-fpga-bridge.c | 228 ++++++++++++++++++++++++++
>>  drivers/fpga/tests/fake-fpga-bridge.h |  36 ++++
>>  2 files changed, 264 insertions(+)
>>  create mode 100644 drivers/fpga/tests/fake-fpga-bridge.c
>>  create mode 100644 drivers/fpga/tests/fake-fpga-bridge.h
>>
>> diff --git a/drivers/fpga/tests/fake-fpga-bridge.c b/drivers/fpga/tests/fake-fpga-bridge.c
>> new file mode 100644
>> index 000000000000..8a2f64fc1bbb
>> --- /dev/null
>> +++ b/drivers/fpga/tests/fake-fpga-bridge.c
>> @@ -0,0 +1,228 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Driver for the fake FPGA bridge
>> + *
>> + * Copyright (C) 2023 Red Hat, Inc.
>> + *
>> + * Author: Marco Pagani <marpagan@redhat.com>
>> + */
>> +
>> +#include <linux/types.h>
>> +#include <linux/device.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/fpga/fpga-bridge.h>
>> +#include <kunit/test.h>
>> +
>> +#include "fake-fpga-bridge.h"
>> +
>> +#define FAKE_FPGA_BRIDGE_DEV_NAME	"fake_fpga_bridge"
>> +
>> +struct fake_bridge_priv {
>> +	int id;
>> +	bool enable;
>> +	int cycles_count;
>> +	struct kunit *test;
>> +};
>> +
>> +struct fake_bridge_data {
>> +	struct kunit *test;
>> +};
>> +
>> +static int op_enable_show(struct fpga_bridge *bridge)
>> +{
>> +	struct fake_bridge_priv *priv;
>> +
>> +	priv = bridge->priv;
>> +
>> +	if (priv->test)
>> +		kunit_info(priv->test, "Fake FPGA bridge %d: enable_show\n",
>> +			   priv->id);
> 
> Why check the kunit pointer every time? I remember you mentioned that
> the fake fpga modules are expected to be used out of Kunit test, so the
> priv->test may be NULL? I suggest you work on these usecases in separate
> patchsets. For now just check priv->test on probe is fine.
> 

The idea was to provide additional info messages, tied with the test, if the
fake bridge is registered with a test instance. If you believe these prints
are unnecessary, I can remove them or replace them with generic dev_info().

>> +
>> +	return priv->enable;
>> +}
>> +
>> +static int op_enable_set(struct fpga_bridge *bridge, bool enable)
>> +{
>> +	struct fake_bridge_priv *priv;
>> +
>> +	priv = bridge->priv;
>> +
>> +	if (enable && !priv->enable)
>> +		priv->cycles_count++;
>> +
>> +	priv->enable = enable;
>> +
>> +	if (priv->test)
>> +		kunit_info(priv->test, "Fake FPGA bridge %d: enable_set: %d\n",
>> +			   priv->id, enable);
>> +
>> +	return 0;
>> +}
>> +
>> +static void op_remove(struct fpga_bridge *bridge)
>> +{
>> +	struct fake_bridge_priv *priv;
>> +
>> +	priv = bridge->priv;
>> +
>> +	if (priv->test)
>> +		kunit_info(priv->test, "Fake FPGA bridge: remove\n");
>> +}
>> +
>> +static const struct fpga_bridge_ops fake_fpga_bridge_ops = {
>> +	.enable_show = op_enable_show,
>> +	.enable_set = op_enable_set,
>> +	.fpga_bridge_remove = op_remove,
>> +};
>> +
>> +/**
>> + * fake_fpga_bridge_register() - register a fake FPGA bridge.
>> + * @bridge_ctx: fake FPGA bridge context data structure.
>> + * @parent: parent device.
>> + * @test: KUnit test context object.
>> + *
>> + * Return: 0 if registration succeeded, an error code otherwise.
>> + */
>> +int fake_fpga_bridge_register(struct fake_fpga_bridge *bridge_ctx,
>> +			      struct device *parent, struct kunit *test)
> 
> struct fake_fpga_bridge *fake_fpga_bridge_register(struct device *parent, ...)
> 
> Is it better?
> 
> Thanks,
> Yilun

Agreed, it is better. I'll change the registration functions for the fake
bridge, manager, and region in the next version.

> 
>> +{
>> +	struct fake_bridge_data pdata;
>> +	struct fake_bridge_priv *priv;
>> +	int ret;
>> +
>> +	pdata.test = test;
>> +
>> +	bridge_ctx->pdev = platform_device_alloc(FAKE_FPGA_BRIDGE_DEV_NAME,
>> +						 PLATFORM_DEVID_AUTO);
>> +	if (IS_ERR(bridge_ctx->pdev)) {
>> +		pr_err("Fake FPGA bridge device allocation failed\n");
>> +		return -ENOMEM;
>> +	}
>> +
>> +	bridge_ctx->pdev->dev.parent = parent;
>> +	platform_device_add_data(bridge_ctx->pdev, &pdata, sizeof(pdata));
>> +
>> +	ret = platform_device_add(bridge_ctx->pdev);
>> +	if (ret) {
>> +		pr_err("Fake FPGA bridge device add failed\n");
>> +		platform_device_put(bridge_ctx->pdev);
>> +		return ret;
>> +	}
>> +
>> +	bridge_ctx->bridge = platform_get_drvdata(bridge_ctx->pdev);
>> +
>> +	if (test) {
>> +		priv = bridge_ctx->bridge->priv;
>> +		kunit_info(test, "Fake FPGA bridge %d registered\n", priv->id);
>> +	}
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(fake_fpga_bridge_register);
>> +
>> +/**
>> + * fake_fpga_bridge_unregister() - unregister a fake FPGA bridge.
>> + * @bridge_ctx: fake FPGA bridge context data structure.
>> + */
>> +void fake_fpga_bridge_unregister(struct fake_fpga_bridge *bridge_ctx)
>> +{
>> +	struct fake_bridge_priv *priv;
>> +	struct kunit *test;
>> +	int id;
>> +
>> +	if (!bridge_ctx)
>> +		return;
>> +
>> +	priv = bridge_ctx->bridge->priv;
>> +	test = priv->test;
>> +	id = priv->id;
>> +
>> +	if (bridge_ctx->pdev) {
>> +		platform_device_unregister(bridge_ctx->pdev);
>> +		if (test)
>> +			kunit_info(test, "Fake FPGA bridge %d unregistered\n", id);
>> +	}
>> +}
>> +EXPORT_SYMBOL_GPL(fake_fpga_bridge_unregister);
>> +
>> +/**
>> + * fake_fpga_bridge_get_state() - get state of a fake FPGA bridge.
>> + * @bridge_ctx: fake FPGA bridge context data structure.
>> + *
>> + * Return: 1 if the bridge is enabled, 0 if disabled.
>> + */
>> +int fake_fpga_bridge_get_state(const struct fake_fpga_bridge *bridge_ctx)
>> +{
>> +	return bridge_ctx->bridge->br_ops->enable_show(bridge_ctx->bridge);
>> +}
>> +EXPORT_SYMBOL_GPL(fake_fpga_bridge_get_state);
>> +
>> +/**
>> + * fake_fpga_bridge_get_cycles_count() - get the number of switching cycles.
>> + * @bridge_ctx: fake FPGA bridge context data structure.
>> + *
>> + * Return: number of switching cycles.
>> + */
>> +int fake_fpga_bridge_get_cycles_count(const struct fake_fpga_bridge *bridge_ctx)
>> +{
>> +	struct fake_bridge_priv *priv;
>> +
>> +	priv = bridge_ctx->bridge->priv;
>> +
>> +	return priv->cycles_count;
>> +}
>> +EXPORT_SYMBOL_GPL(fake_fpga_bridge_get_cycles_count);
>> +
>> +static int fake_fpga_bridge_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev;
>> +	struct fpga_bridge *bridge;
>> +	struct fake_bridge_data *pdata;
>> +	struct fake_bridge_priv *priv;
>> +	static int id_count;
>> +
>> +	dev = &pdev->dev;
>> +	pdata = dev_get_platdata(dev);
>> +
>> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>> +	if (!priv)
>> +		return -ENOMEM;
>> +
>> +	priv->id = id_count++;
>> +	priv->enable = true;
>> +
>> +	if (pdata)
>> +		priv->test = pdata->test;
>> +
>> +	bridge = fpga_bridge_register(dev, "Fake FPGA Bridge",
>> +				      &fake_fpga_bridge_ops, priv);
>> +	if (IS_ERR(bridge))
>> +		return PTR_ERR(bridge);
>> +
>> +	platform_set_drvdata(pdev, bridge);
>> +
>> +	return 0;
>> +}
>> +
>> +static int fake_fpga_bridge_remove(struct platform_device *pdev)
>> +{
>> +	struct fpga_bridge *bridge = platform_get_drvdata(pdev);
>> +
>> +	fpga_bridge_unregister(bridge);
>> +
>> +	return 0;
>> +}
>> +
>> +static struct platform_driver fake_fpga_bridge_drv = {
>> +	.driver = {
>> +		.name = FAKE_FPGA_BRIDGE_DEV_NAME
>> +	},
>> +	.probe = fake_fpga_bridge_probe,
>> +	.remove = fake_fpga_bridge_remove,
>> +};
>> +
>> +module_platform_driver(fake_fpga_bridge_drv);
>> +
>> +MODULE_AUTHOR("Marco Pagani <marpagan@redhat.com>");
>> +MODULE_DESCRIPTION("Fake FPGA Bridge");
>> +MODULE_LICENSE("GPL v2");
>> diff --git a/drivers/fpga/tests/fake-fpga-bridge.h b/drivers/fpga/tests/fake-fpga-bridge.h
>> new file mode 100644
>> index 000000000000..ae224b13f284
>> --- /dev/null
>> +++ b/drivers/fpga/tests/fake-fpga-bridge.h
>> @@ -0,0 +1,36 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Header file for the fake FPGA bridge
>> + *
>> + * Copyright (C) 2023 Red Hat, Inc.
>> + *
>> + * Author: Marco Pagani <marpagan@redhat.com>
>> + */
>> +
>> +#ifndef __FPGA_FAKE_BRIDGE_H
>> +#define __FPGA_FAKE_BRIDGE_H
>> +
>> +#include <linux/platform_device.h>
>> +#include <kunit/test.h>
>> +
>> +/**
>> + * struct fake_fpga_bridge - fake FPGA bridge context data structure
>> + *
>> + * @bridge: FPGA bridge.
>> + * @pdev: platform device of the FPGA bridge.
>> + */
>> +struct fake_fpga_bridge {
>> +	struct fpga_bridge *bridge;
>> +	struct platform_device *pdev;
>> +};
>> +
>> +int fake_fpga_bridge_register(struct fake_fpga_bridge *bridge_ctx,
>> +			      struct device *parent, struct kunit *test);
>> +
>> +void fake_fpga_bridge_unregister(struct fake_fpga_bridge *bridge_ctx);
>> +
>> +int fake_fpga_bridge_get_state(const struct fake_fpga_bridge *bridge_ctx);
>> +
>> +int fake_fpga_bridge_get_cycles_count(const struct fake_fpga_bridge *bridge_ctx);
>> +
>> +#endif /* __FPGA_FAKE_BRIDGE_H */
>> -- 
>> 2.39.2
>>

Thanks,
Marco


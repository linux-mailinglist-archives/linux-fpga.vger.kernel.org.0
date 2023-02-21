Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0BE969E2C7
	for <lists+linux-fpga@lfdr.de>; Tue, 21 Feb 2023 15:56:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjBUOyU (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 21 Feb 2023 09:54:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234181AbjBUOyL (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 21 Feb 2023 09:54:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69311D92A
        for <linux-fpga@vger.kernel.org>; Tue, 21 Feb 2023 06:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676991205;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EYpL26YyPMYjG88doImJInQ/vYm3J/zu2ofZlQhSMvo=;
        b=Ka2MMXrooO94ol4f5KUbmZERAD1sCXb41lYI0OgwwGR6wtl8cFok6JGXf66H+bmlMHDDyB
        Ne+CALD6kWWXVhDPpYcoQ6DqsXGbCWoLQk67HtuMROZXhjjdtmKn4YdIkRFjZLFT3BbC6v
        oJ5ZvE6HYCi60BCTDEn+BZjOyTIDe58=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-85-CA9yOTl2NF6qewAdD-CI8g-1; Tue, 21 Feb 2023 09:53:23 -0500
X-MC-Unique: CA9yOTl2NF6qewAdD-CI8g-1
Received: by mail-ed1-f70.google.com with SMTP id ee6-20020a056402290600b004ad51f8fc36so6132209edb.22
        for <linux-fpga@vger.kernel.org>; Tue, 21 Feb 2023 06:53:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EYpL26YyPMYjG88doImJInQ/vYm3J/zu2ofZlQhSMvo=;
        b=SHYjC5cROJY7Vhci3ifmBA7aJdOvTVH6SxrwdZk4a3tpsrdDpibs+4ztn0x7uGDyvm
         hJFOdmcwcuJnKrt+SI5BPmany6q/UNuCJ+OLnKWW8Tg1IZ0cs0PfJmHccWCfpy26NAVI
         TUJaiw9Olrmk1ZnqXS5D+2wYI5775N05mSQl0tnaYXvTfZlOYbmx5/Rigk5zO5sj/mUB
         x4jAgOKK7zaJjaTOLWJRfPnZGEhZTes7t/8S1UoyPzIFtr5FY1oFOd8rHuuaNPo8wesA
         Q8MOGaoiLUJx64isfbQt03pC8tyaLji832dV1CIYOovu9LnyOTQtQfgQywMId8izSzNY
         we7w==
X-Gm-Message-State: AO0yUKUI5PY5amujVCxCLAj3Z39e3oTazpPQmkc2oS+rhNWaPXzh1Chg
        90mbZTJKMVEzoxxH78MG6vEKRgHCiiOtd+AHgqXkDdjfS2v+nUHHC+EnAolphN6QnXA3Ln9IT+G
        L5kb9MAxusLvYcAF8F3v+
X-Received: by 2002:a17:907:7ea0:b0:877:a9d2:e5e9 with SMTP id qb32-20020a1709077ea000b00877a9d2e5e9mr13754238ejc.42.1676991201977;
        Tue, 21 Feb 2023 06:53:21 -0800 (PST)
X-Google-Smtp-Source: AK7set8sg6C8d9TLkX5PNoaqVkzQERrnLVM5Nxi5jgmqijEzUW4CIzpUWfANo0owGlI14gno9s7vwg==
X-Received: by 2002:a17:907:7ea0:b0:877:a9d2:e5e9 with SMTP id qb32-20020a1709077ea000b00877a9d2e5e9mr13754213ejc.42.1676991201683;
        Tue, 21 Feb 2023 06:53:21 -0800 (PST)
Received: from [192.168.9.16] (net-2-34-30-183.cust.vodafonedsl.it. [2.34.30.183])
        by smtp.gmail.com with ESMTPSA id gk7-20020a17090790c700b008c673cd9ba2sm4033186ejb.126.2023.02.21.06.53.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 06:53:21 -0800 (PST)
Message-ID: <3f17060a-69ce-fb39-61ab-a892b9a1e8c6@redhat.com>
Date:   Tue, 21 Feb 2023 15:53:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFC PATCH 2/4] fpga: add fake FPGA region
Content-Language: en-US
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230203170653.414990-1-marpagan@redhat.com>
 <20230203170653.414990-3-marpagan@redhat.com>
 <Y/Ckw+F/sb2er2oK@yilunxu-OptiPlex-7050>
From:   Marco Pagani <marpagan@redhat.com>
In-Reply-To: <Y/Ckw+F/sb2er2oK@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 2023-02-18 11:13, Xu Yilun wrote:
> On 2023-02-03 at 18:06:51 +0100, Marco Pagani wrote:
>> Add fake FPGA region platform driver with support functions. This
>> module is part of the KUnit test suite for the FPGA subsystem.
>>
>> Signed-off-by: Marco Pagani <marpagan@redhat.com>
>> ---
>>  drivers/fpga/tests/fake-fpga-region.c | 186 ++++++++++++++++++++++++++
>>  drivers/fpga/tests/fake-fpga-region.h |  37 +++++
>>  2 files changed, 223 insertions(+)
>>  create mode 100644 drivers/fpga/tests/fake-fpga-region.c
>>  create mode 100644 drivers/fpga/tests/fake-fpga-region.h
>>
>> diff --git a/drivers/fpga/tests/fake-fpga-region.c b/drivers/fpga/tests/fake-fpga-region.c
>> new file mode 100644
>> index 000000000000..095397e41837
>> --- /dev/null
>> +++ b/drivers/fpga/tests/fake-fpga-region.c
>> @@ -0,0 +1,186 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Driver for fake FPGA region
>> + *
>> + * Copyright (C) 2023 Red Hat, Inc. All rights reserved.
>> + *
>> + * Author: Marco Pagani <marpagan@redhat.com>
>> + */
>> +
>> +#include <linux/device.h>
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
>> +};
>> +
>> +struct fake_region_data {
>> +	struct fpga_manager *mgr;
>> +	struct kunit *test;
>> +};
>> +
>> +/**
>> + * fake_fpga_region_register - register a fake FPGA region
>> + * @region_ctx: fake FPGA region context data structure.
>> + * @test: KUnit test context object.
>> + *
>> + * Return: 0 if registration succeeded, an error code otherwise.
>> + */
>> +int fake_fpga_region_register(struct fake_fpga_region *region_ctx,
>> +			      struct fpga_manager *mgr, struct kunit *test)
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
>> + * fake_fpga_region_unregister - unregister a fake FPGA region
>> + * @region_ctx: fake FPGA region context data structure.
>> + */
>> +void fake_fpga_region_unregister(struct fake_fpga_region *region_ctx)
>> +{
>> +	struct fake_region_priv *priv;
>> +	struct kunit *test;
>> +	int id;
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
>> + * fake_fpga_region_add_bridge - add a bridge to a fake FPGA region
>> + * @region_ctx: fake FPGA region context data structure.
>> + * @bridge: FPGA bridge.
>> + *
>> + * Return: 0 if registration succeeded, an error code otherwise.
>> + */
>> +int fake_fpga_region_add_bridge(struct fake_fpga_region *region_ctx,
>> +				struct fpga_bridge *bridge)
>> +{
>> +	struct fake_region_priv *priv;
>> +	int ret;
>> +
>> +	priv = region_ctx->region->priv;
>> +
>> +	ret = fpga_bridge_get_to_list(bridge->dev.parent, NULL,
>> +				      &region_ctx->region->bridge_list);
>> +
>> +	if (priv->test && !ret)
>> +		kunit_info(priv->test, "Bridge added to fake FPGA region %d\n",
>> +			   priv->id);
>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(fake_fpga_region_add_bridge);
>> +
>> +static int fake_fpga_region_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev;
>> +	struct fpga_region *region;
>> +	struct fpga_manager *mgr;
>> +	struct fake_region_data *pdata;
>> +	struct fake_region_priv *priv;
>> +	static int id_count;
>> +
>> +	dev = &pdev->dev;
>> +	pdata = dev_get_platdata(dev);
>> +
>> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>> +	if (!priv)
>> +		return -ENOMEM;
>> +
>> +	mgr = fpga_mgr_get(pdata->mgr->dev.parent);
>> +	if (IS_ERR(mgr))
>> +		return PTR_ERR(mgr);
>> +
>> +	/*
>> +	 * No get_bridges() method since the bridges list is
>> +	 * pre-built using fake_fpga_region_add_bridge()
>> +	 */
> 
> This is not the common use for drivers to associate the region & bridge,
> Better to realize the get_bridges() method.

Initially, I was using a get_bridges() method to create the list of bridges
before each reconfiguration. However, this required having a "duplicated"
list of bridges in the context of the fake region low-level driver.

Since I couldn't find a reason to keep a duplicate list of bridges in the
fake region driver, I decided then to change the approach and build the
list of bridges at device instantiation time.

In my understanding, the approach of creating the list of bridges just
before reconfiguration with a get_bridges() method works best for the
OF case, where the topology is already encoded in the DT. I feel using
this approach on platforms without OF support would increase complexity
and create unnecessary duplication.

> 
> Thanks,
> Yilun
> 
>> +	region = fpga_region_register(dev, mgr, NULL);
>> +	if (IS_ERR(region)) {
>> +		fpga_mgr_put(mgr);
>> +		return PTR_ERR(region);
>> +	}
>> +
>> +	priv->test = pdata->test;
>> +	priv->id = id_count++;
>> +	region->priv = priv;
>> +
>> +	platform_set_drvdata(pdev, region);
>> +
>> +	return 0;
>> +}
> 

Thanks,
Marco


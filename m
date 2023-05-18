Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D56FB7081A5
	for <lists+linux-fpga@lfdr.de>; Thu, 18 May 2023 14:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjERMoj (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 18 May 2023 08:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjERMoj (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 18 May 2023 08:44:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00448106
        for <linux-fpga@vger.kernel.org>; Thu, 18 May 2023 05:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684413830;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KGFOlYgs9yiTXXHlUFyD+9RUZz2pUrP3MHmsVP+sEYA=;
        b=BbEr3kbsK8Z1JYbVmI3Y/DtU+Wta+wPqUmA9n4VDyHy2wx8B5uI7fvToekla56GSjDPHYK
        Q/88V0y09Bb775Qmsco7wM3+ZoXcTnhidA7AC/GX+0+zmxHw14gRVa6HbltO9OWxzT9mrx
        k0H7l89bv28kJC3hK1gIHVAdzDY8lOE=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-DPkfn0VtP_-nB--PDWz7OQ-1; Thu, 18 May 2023 08:43:49 -0400
X-MC-Unique: DPkfn0VtP_-nB--PDWz7OQ-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-50bcbb5724aso2147727a12.1
        for <linux-fpga@vger.kernel.org>; Thu, 18 May 2023 05:43:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684413828; x=1687005828;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KGFOlYgs9yiTXXHlUFyD+9RUZz2pUrP3MHmsVP+sEYA=;
        b=C9DqAWzmq1sVCzHhm9M4bsF0zmRLANi1yf/DuOn3NdzaCnvLt9Ml4lXxeKFgLX4dUq
         3D3MhmkBzlv2m32HuVEL5/KUbqn4o9EbhzcG9IvSdEyzDruEpU4xdak3Kfnk5tWLpq4k
         8eaWy0/9Xlqb+52HCF27EHa8m4HVxRw/BuO4y27/vN31OoZZVdbRzELbJHVdUgAjZl+8
         qyEAnhZOTugTV3V35iG9odULUvItlIs42ig9SM7gajlpqnfqkcJu4OXxGjbu3XkGggn1
         rw4OGKDjPkFalGX2HKO2e/b5jQtUvfNMY+v/WbGb7JBfnK1FqY8rwIEBLrKqYBhcT6LY
         46xg==
X-Gm-Message-State: AC+VfDxYsLI7bIpkXmFHFvMChuTl0VAZ7voblp/8ADbB4yj3TV6SUK3j
        tRTkZJJco8AVvYFEQl/uqUT8yilHR0E343A8V3yLonx8anYZ8EgzX1uu848zP06FzCP3tp6k3u2
        IL6YW8SVINlxYN7LrZCdH
X-Received: by 2002:a05:6402:1489:b0:510:e556:c842 with SMTP id e9-20020a056402148900b00510e556c842mr1823553edv.23.1684413827830;
        Thu, 18 May 2023 05:43:47 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6S/mjmYvAQCOuz0IhicZsygKCZlE5h31DxVl0j2/IE41XTTHE030AIoeeAwWfv9KPVGmF5+g==
X-Received: by 2002:a05:6402:1489:b0:510:e556:c842 with SMTP id e9-20020a056402148900b00510e556c842mr1823541edv.23.1684413827511;
        Thu, 18 May 2023 05:43:47 -0700 (PDT)
Received: from [192.168.9.16] (net-2-34-28-169.cust.vodafonedsl.it. [2.34.28.169])
        by smtp.gmail.com with ESMTPSA id k5-20020a05640212c500b0050d988bf956sm549255edx.45.2023.05.18.05.43.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 May 2023 05:43:46 -0700 (PDT)
Message-ID: <f9b7d388-9a8b-0663-ea02-892606950907@redhat.com>
Date:   Thu, 18 May 2023 14:43:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH v5 4/4] fpga: add initial KUnit test suites
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
References: <20230511141922.437328-1-marpagan@redhat.com>
 <20230511141922.437328-5-marpagan@redhat.com>
 <ZF/LpdlyBu2Z1uQE@yilunxu-OptiPlex-7050>
 <a50022a6-59e1-6b53-2c5b-c6eb44277876@redhat.com>
 <ZGSmtCkPwi2TMW7K@yilunxu-OptiPlex-7050>
Content-Language: en-US
From:   Marco Pagani <marpagan@redhat.com>
In-Reply-To: <ZGSmtCkPwi2TMW7K@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 2023-05-17 12:04, Xu Yilun wrote:
> On 2023-05-15 at 19:24:07 +0200, Marco Pagani wrote:
>>
>>
>> On 2023-05-13 19:40, Xu Yilun wrote:
>>> On 2023-05-11 at 16:19:22 +0200, Marco Pagani wrote:
>>>> Introduce initial KUnit tests for the FPGA subsystem. Tests are organized
>>>> into three test suites. The first suite tests the FPGA Manager.
>>>> The second suite tests the FPGA Bridge. Finally, the last test suite
>>>> models a complete FPGA platform and tests static and partial reconfiguration.
>>>>
>>>> Signed-off-by: Marco Pagani <marpagan@redhat.com>
>>
>> [...]
>>
>>>> +static void fpga_bridge_test_get_put_list(struct kunit *test)
>>>> +{
>>>> +	struct list_head bridge_list;
>>>> +	struct fake_fpga_bridge *bridge_0_ctx, *bridge_1_ctx;
>>>> +	int ret;
>>>> +
>>>> +	bridge_0_ctx = test->priv;
>>>> +
>>>> +	/* Register another bridge for this test */
>>>> +	bridge_1_ctx = fake_fpga_bridge_register(test, NULL);
>>>> +	KUNIT_ASSERT_FALSE(test, IS_ERR(bridge_1_ctx));
>>>
>>> I think bridge_1 could also be initialized in test_init together with
>>> bridge_0
>>
>> I can do it, but it would remain unused in the previous test case.
>>  
>>>> +
>>>> +	INIT_LIST_HEAD(&bridge_list);
>>>> +
>>>> +	/* Get bridge_0 and add it to the list */
>>>> +	ret = fpga_bridge_get_to_list(bridge_1_ctx->bridge->dev.parent, NULL,
>>>> +				      &bridge_list);
>>>> +	KUNIT_EXPECT_EQ(test, ret, 0);
>>>> +
>>>> +	KUNIT_EXPECT_PTR_EQ(test, bridge_1_ctx->bridge,
>>>> +			    list_first_entry_or_null(&bridge_list, struct fpga_bridge, node));
>>>
>>> Should operate on bridge_0_ctx?
>>
>> Yes, sorry. Code and comments are reversed. I'll fix it in the next version.
>>
>>>> +
>>>> +	/* Get bridge_1 and add it to the list */
>>>> +	ret = fpga_bridge_get_to_list(bridge_0_ctx->bridge->dev.parent, NULL,
>>>> +				      &bridge_list);
>>>> +	KUNIT_EXPECT_EQ(test, ret, 0);
>>>> +
>>>> +	KUNIT_EXPECT_PTR_EQ(test, bridge_0_ctx->bridge,
>>>> +			    list_first_entry_or_null(&bridge_list, struct fpga_bridge, node));
>>>
>>> Should operate on bridge_1_ctx?
>>
>> Same.
>>
>>>> +
>>>> +	/* Disable an then enable both bridges from the list */
>>>> +	KUNIT_EXPECT_TRUE(test, bridge_0_ctx->stats.enable);
>>>
>>> Why expect enable without fpga_bridges_enable()?
>>
>> To check that the bridge is initialized in the correct (enabled) state.
>>
>> [...]
>>
>>>> +static void fpga_test_partial_rcfg(struct kunit *test)
>>>> +{
>>>> +	struct fpga_base_ctx *base_ctx;
>>>> +	struct fake_fpga_region *sub_region_0_ctx, *sub_region_1_ctx;
>>>> +	struct fake_fpga_bridge *sub_bridge_0_ctx, *sub_bridge_1_ctx;
>>>> +	struct fpga_image_info *partial_img_info;
>>>> +	int ret;
>>>> +
>>>> +	base_ctx = test->priv;
>>>> +
>>>> +	/*
>>>> +	 * Add two reconfigurable sub-regions, each controlled by a bridge. The
>>>> +	 * reconfigurable sub-region are children of their bridges which are,
>>>> +	 * in turn, children of the base region. For simplicity, the same image
>>>> +	 * is used to configure reconfigurable regions
>>>> +	 */
>>>> +	sub_bridge_0_ctx = fake_fpga_bridge_register(test,
>>>> +						     &base_ctx->region_ctx->region->dev);
>>>> +	KUNIT_ASSERT_FALSE(test, IS_ERR(sub_bridge_0_ctx));
>>>> +
>>>> +	sub_region_0_ctx = fake_fpga_region_register(test, base_ctx->mgr_ctx->mgr,
>>>> +						     &sub_bridge_0_ctx->bridge->dev);
>>>> +	KUNIT_ASSERT_FALSE(test, IS_ERR(sub_region_0_ctx));
>>>> +
>>>> +	ret = fake_fpga_region_add_bridge(sub_region_0_ctx, sub_bridge_0_ctx->bridge);
>>>> +	KUNIT_ASSERT_EQ(test, ret, 0);
>>>> +
>>>> +	sub_bridge_1_ctx = fake_fpga_bridge_register(test,
>>>> +						     &base_ctx->region_ctx->region->dev);
>>>> +	KUNIT_ASSERT_FALSE(test, IS_ERR(sub_bridge_1_ctx));
>>>> +
>>>> +	sub_region_1_ctx = fake_fpga_region_register(test, base_ctx->mgr_ctx->mgr,
>>>> +						     &sub_bridge_1_ctx->bridge->dev);
>>>> +	KUNIT_ASSERT_FALSE(test, IS_ERR(sub_region_1_ctx));
>>>> +
>>>> +	ret = fake_fpga_region_add_bridge(sub_region_1_ctx, sub_bridge_1_ctx->bridge);
>>>> +	KUNIT_ASSERT_EQ(test, ret, 0);
>>>
>>> I'm wondering if we need to construct the topology for partial
>>> reconfiguration test. The FPGA core doesn't actually check the topology.
>>> It is OK to do partial reconfiguration for a region without parents as
>>> long as its associated FPGA manager device has the capability.
>>>
>>> Thanks,
>>> Yilun
>>
>> I agree with you. Creating a hierarchical layout is rather unnecessary.
>>
> 
> I assume the following sections have nothing to do with hierarchial
> layout, is it?
>

It was a general summary to put things in perspective and ask your opinion
before moving forward with the next version.

>> Initially, the idea was to test that all components behave as expected
>> in a complete setup, e.g., only the bridge of the specific reconfigurable
>> region gets disabled during programming and then re-enabled.
>>
>> However, after some iterations, I'm starting to think that it would be
>> better to restructure the whole test code into a set of self-contained
>> test modules, one for each core component. 
>>
>> In that way, each module would contain the implementation of the fake/mock
>> low-level driver and the related tests. For instance, the manager module
>> would contain the implementation of the fake manager and the test_img_load_buf
>> and test_img_load_sgt test cases. Similarly, the bridge module would contain
>> the fake/mock bridge implementation and the test_toggle and test_get_put_list
>> cases.
>>
>> I think that in this way, the code would be simpler and more adherent to the
>> unit testing methodology. The downside is that making tests that need multiple
>> components would be more cumbersome and possibly lead to code duplication.
>> For instance, testing the region's fpga_region_program_fpga() would require
>> implementing additional local mock/fakes for the manager and bridge.
> 
> This way is good to me.
>

Okay, I'll move toward multiple test modules for v6.
 
>>
>> What do you think?
>>
>> Thanks,
>> Marco
>>
>> [...]
>>
>

Thanks,
Marco


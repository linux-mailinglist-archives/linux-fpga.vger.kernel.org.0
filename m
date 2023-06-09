Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E52272971D
	for <lists+linux-fpga@lfdr.de>; Fri,  9 Jun 2023 12:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236269AbjFIKip (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 9 Jun 2023 06:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237805AbjFIKiE (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 9 Jun 2023 06:38:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8FB35B6
        for <linux-fpga@vger.kernel.org>; Fri,  9 Jun 2023 03:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686306952;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M7aBfg3F7FbTL8MCx2KleeNyHDU6Z7DcYSGcp5gszIE=;
        b=FfEehcdW6qnUf4/WLc0e6NJgUAyBhr0j/fBsHI0GmARpiAxBfha1PHjXGpQ8m5h5am0qMc
        jHvErxZ8jxa7IYXFIK57PH94Xc0Ur4VVRLtQYOwLzxyvuTTHJ6E+xHJYhcQOt/o4OltZ2R
        wGwBLsMbr6u7iuLWI4DQigFJ6w0OOkI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-MEMeCBhiP-WS_6AwCn5vQw-1; Fri, 09 Jun 2023 06:35:51 -0400
X-MC-Unique: MEMeCBhiP-WS_6AwCn5vQw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-30ade645c59so571384f8f.2
        for <linux-fpga@vger.kernel.org>; Fri, 09 Jun 2023 03:35:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686306950; x=1688898950;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M7aBfg3F7FbTL8MCx2KleeNyHDU6Z7DcYSGcp5gszIE=;
        b=C4MfACfO5FjBwmxgh1HTkalG3wNStlkZ1pdUomFGgOrTfMt5/bhG1sYU/QOI6HeLer
         27vNakwCoo5+fFFUS0D0/S5IGa1c73nmP5irqQXwb/R8Xy+DnP151avNUrPVXvtWdML6
         Cm8RShH3WTaT7o6lDlk9c1n3ei/1gO/LmVCJqL4IHazz8+POkm16H8SKy+6uoNTFl8rT
         XoSskymixWEB78owcVT9U95TxNI3moE7iZ4cMKFOxQrBvS51jhDt2m1p3hL0pwP4ZtMT
         e0t+yZzUYnvse8m5xjbwyP2Ge/Ti/tve1QOS5D9z9/h5MjvMJiTXvdv2aRO1O/yR+cV2
         qvMA==
X-Gm-Message-State: AC+VfDw8bcBBb+e27hGbVYxsbL/l1eIidMplbyPFg9B6hNwOZmSsg6fA
        1zIxx+0Lu52YvbbrqMlwlFWbfjA1ifI1q25RdG1a69fhEx7hbTZzAaN+qkEtFaST3lR9ZX0WG30
        XQ+JEazHXc7BaIUpVE68X
X-Received: by 2002:adf:e8c1:0:b0:30a:f030:8637 with SMTP id k1-20020adfe8c1000000b0030af0308637mr552409wrn.22.1686306950162;
        Fri, 09 Jun 2023 03:35:50 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4UrCHBQ9Tji/kvdpUyPHGM0Qiyj809y6GXrItiE91Hi8xc5BY0sFCvpl5hEVBrAeFnBfXpDA==
X-Received: by 2002:adf:e8c1:0:b0:30a:f030:8637 with SMTP id k1-20020adfe8c1000000b0030af0308637mr552401wrn.22.1686306949812;
        Fri, 09 Jun 2023 03:35:49 -0700 (PDT)
Received: from [192.168.9.16] (net-2-34-28-201.cust.vodafonedsl.it. [2.34.28.201])
        by smtp.gmail.com with ESMTPSA id i1-20020adffc01000000b0030aee3da084sm4079505wrr.49.2023.06.09.03.35.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jun 2023 03:35:49 -0700 (PDT)
Message-ID: <f12ee323-ff6f-b4c9-02d8-e0b4a46e74fc@redhat.com>
Date:   Fri, 9 Jun 2023 12:35:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH v6 3/4] fpga: add an initial KUnit suite for the FPGA
 Region
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
References: <20230531095405.342080-1-marpagan@redhat.com>
 <20230531095405.342080-4-marpagan@redhat.com>
 <ZHuQc7WfN1zKOeTE@yilunxu-OptiPlex-7050>
 <d1ef2f9a-f416-e7d6-7481-d81c1941702e@redhat.com>
 <ZH8R5APukuZVkIv5@yilunxu-OptiPlex-7050>
 <a9652cb5-3d73-f49f-6de3-a49d528e91ec@redhat.com>
 <ZIMIVJtnzjROr88m@yilunxu-OptiPlex-7050>
Content-Language: en-US
From:   Marco Pagani <marpagan@redhat.com>
In-Reply-To: <ZIMIVJtnzjROr88m@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 2023-06-09 13:09, Xu Yilun wrote:
> On 2023-06-07 at 17:57:22 +0200, Marco Pagani wrote:
>>
>>
>> On 2023-06-06 13:00, Xu Yilun wrote:
>>> On 2023-06-05 at 18:58:56 +0200, Marco Pagani wrote:
>>>>
>>>>
>>>> On 2023-06-03 21:11, Xu Yilun wrote:
>>>>> On 2023-05-31 at 11:54:04 +0200, Marco Pagani wrote:
>>>>>> The suite tests the programming of an FPGA Region with a Bridge
>>>>>> and the function for finding a particular Region.
>>>>>>
>>>>>> Signed-off-by: Marco Pagani <marpagan@redhat.com>
>>>>>> ---
>>>>>>  drivers/fpga/tests/fpga-region-test.c | 186 ++++++++++++++++++++++++++
>>>>>>  1 file changed, 186 insertions(+)
>>>>>>  create mode 100644 drivers/fpga/tests/fpga-region-test.c
>>>>
>>>> [...]
>>>>
>>>>  
>>>>> Maybe better just put all tests in one module, and have unified
>>>>> fake_mgr_ops/mgr_stats/fake_bridge_ops/bridge_stats across all tests.
>>>>>
>>>>> In previous thread, I said I'm good to the self-contained test module
>>>>> but I didn't actually follow the idea. Sorry for that.
>>>>>
>>>>> The concern is why in this region test, the write_count and only the
>>>>> write_count is taken care of.
>>>>>
>>>>> Although fpga_mgr_load() test covers all mgr_ops, but does that
>>>>> means these ops are still good for more complex case like
>>>>> fpga_region_program_fpga()? And there is no guarantee
>>>>> fpga_region_program_fpga() would always call mgr_ops the same way
>>>>> as fpga_mgr_load() in future.
>>>>>
>>>>> Similar for fpga_bridge. Maybe a complete setup for fpga_region is
>>>>> still necessary.
>>>>
>>>> I think that putting all tests in a single module (like in previous
>>>> versions) goes against the principles of unit testing, making the
>>>> code more similar to an integration test.
>>>>
>>>> Unit tests should be focused on a single behavior. The programming
>>>> test case included in the Region's suite should test only the behavior
>>>> of the Region itself. Specifically, that fpga_region_program_fpga() calls
>>>> get_bridges(), to get and control bridges, and then the Manager for the
>>>> actual programming.
>>>>
>>>> The programming sequence itself is outside the responsibilities of the
>>>> Region, and its correctness is already ensured by the Manager suite.
>>>> Similarly, the correctness of the Bridge's methods used by the Region
>>>> for getting and controlling multiple bridges is already ensured by the
>>>> Bridge test suite.
>>>>
>>>> For this reason, the Manager and Bridge fakes used in the Region suite
>>>> implement only the minimal set of operations necessary to ensure the
>>>> correctness of the Region's behavior. If I used a "full" Manager (and
>>>> tested all mgr_ops), then the test case would have become an integration
>>>> test rather than a unit test for the Region.
>>>
>>> I agree with you about a unit test should focus on a single behavior. But
>>> I have concerns that each test suite uses different definitions of the
>>> same structure, mgr/bridge stats, mgr/bridge ops, mgr/bridge ctx. Even
>>> if we have full definitions for these structures to acommodate all
>>> tests, it doesn't break the principle of unit test, just ignore the fields
>>> and skip checks that you don't care. E.g. only checks mgr.write_count &
>>> bridge.enable_count for region test.
>>>
>>> And a single module simplifies the implementation.
>>>
>>> struct mgr_stats {
>>> 	...
>>> };
>>>
>>> struct mgr_ctx {
>>> 	struct fpga_image_info *img_info;
>>> 	struct fpga_manager *mgr;
>>> 	struct platform_device *pdev;
>>> 	struct mgr_stats stats;
>>> };
>>>
>>> struct bridge_stats {
>>> 	...
>>> };
>>>
>>> struct bridge_ctx {
>>> 	struct fpga_bridge *bridge;
>>> 	struct platform_device *pdev;
>>> 	struct bridge_stats stats;
>>> };
>>>
>>> struct region_ctx {
>>> 	struct mgr_ctx mgr_ctx;
>>> 	struct bridge_ctx bridge_ctx;
>>>
>>> 	struct fpga_region *region;
>>> 	struct platform_device *region_pdev;
>>> };
>>>
>>> How do you think?
>>>
>>> Thanks,
>>> Yilun
>>>
>>
>> My concern with unified fakes having the same ops, stats, and context structs
>> is that they would couple the test suites together. I think it's better to
>> have multiple fakes, each with the single responsibility of providing minimal
>> support for the component under test. Otherwise, we would end up having
>> overcomplicated fakes that implement the union (in the set theory sense of
>> the term) of all behaviors tested by all suites. By using these fakes, some
>> test cases might implicitly exercise behaviors that are outside their scope
>> (e.g., the Region programming test case calling all Manager ops). I feel
>> this would go against the principle of limiting the amount of code under test
>> to a single unit. 
> 
> OK. On second thought, it is good to me.
> 
> I think now the high level opens are all addressed. Will you keep on
> improving the patchset or make it stable for upstream? If the later, you
> may drop the RFC prefix.

I plan to stabilize the patchset for the upstream.

Thanks,
Marco

> 
> Thanks,
> Yilun
> 
>> Thanks,
>> Marco
>>
>>>>> BTW: I like the way that fake drivers are removed. Looks much straight
>>>>> forward.
>>>>
>>>> I appreciate that.
>>>>  
>>>>> Thanks,
>>>>> Yilun
>>>>>
>>>>
>>>> Thanks,
>>>> Marco
>>>>
>>>> [...]
>>>>
>>>
>>
> 


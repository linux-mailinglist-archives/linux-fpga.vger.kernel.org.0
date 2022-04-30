Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D83F515E79
	for <lists+linux-fpga@lfdr.de>; Sat, 30 Apr 2022 16:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382888AbiD3O63 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 30 Apr 2022 10:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379276AbiD3O60 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 30 Apr 2022 10:58:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C3CBE1ADA7
        for <linux-fpga@vger.kernel.org>; Sat, 30 Apr 2022 07:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651330503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3y/gnO5NriXy01NUlwMKjVmeqtM4bTYvuSzVe16kUvA=;
        b=cXpb1peYT+1K1pZR2qUBrabxxi+k2RAndq2bxFMLQt/T0OG2Y1ujJ3IB1jELyC3LwXNMeT
        9pbkcc7/9c8T1F1xFUkdujnwpR+tWmpusuNV+ZdvnVBP86KDpMaQT8Sd69OctTxBj+HaqA
        J5cTr1rQBusQyipSebnvwgu5Io1G3/M=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-292-5__Thk4MNoCmQrnHKsbQcQ-1; Sat, 30 Apr 2022 10:55:01 -0400
X-MC-Unique: 5__Thk4MNoCmQrnHKsbQcQ-1
Received: by mail-qk1-f199.google.com with SMTP id c8-20020a05620a268800b0069c0f1b3206so7110701qkp.18
        for <linux-fpga@vger.kernel.org>; Sat, 30 Apr 2022 07:55:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=3y/gnO5NriXy01NUlwMKjVmeqtM4bTYvuSzVe16kUvA=;
        b=c2PRMCd9LHzUFPEx61pCluHIdtizmKAD2Gr+XwBvywVpnZ9p6HoHFOFSFq4XM0ziOr
         ZOk1wFFouY489nC5OrKdh+8BtJdhbPXiyzZ7O22cUCQWFAEfPWGK7aDgRy1COVEfL7/h
         TLbCPqdRnItx11qyG1irge9RIfMAb/8aNwYHAcR/0GOZx8XJ3ZQ19Owrah4lpJKrTW/t
         F4A3kgRjqkDm6m1pRt4FPSl78/PRmyBOeXW+4DBmy/P1IyWMHiih+2KxvtujRGBrrntl
         p0HDeFxaPukCZLwSTP2LuE4dPy5TIJ8FPEOXcxfk/3L6cxouY0D+QC7FHE1LWOwqr4ya
         WcZA==
X-Gm-Message-State: AOAM530X+IfrLKOWc8MQ6yi4mr/r0WX5CA9MUvq4/puc93aQNXGRxrh4
        86lHr0S1MVMSq6QRZ8OVhEz73d6lUefy8cCrSQcxDw/SWQVU90lYCz26jKB5sHLB92HXsY8hAoA
        7arVVrp/X2DZZFtxV6UkbnA==
X-Received: by 2002:a05:622a:24f:b0:2e1:d658:a595 with SMTP id c15-20020a05622a024f00b002e1d658a595mr3697059qtx.657.1651330500920;
        Sat, 30 Apr 2022 07:55:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxAM5zJTWiyPuGQdIWl49gZOfPfVpS5CrBSrsyOAEpsZkkkcuY8ZmDmZi+GA19jWspyUlCPRg==
X-Received: by 2002:a05:622a:24f:b0:2e1:d658:a595 with SMTP id c15-20020a05622a024f00b002e1d658a595mr3697043qtx.657.1651330500721;
        Sat, 30 Apr 2022 07:55:00 -0700 (PDT)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id o26-20020a05620a111a00b0069fc13ce242sm1256381qkk.115.2022.04.30.07.54.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Apr 2022 07:54:59 -0700 (PDT)
Subject: Re: [PATCH v3] uio: dfl: add HSSI subsystem feature id
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     Tianfei Zhang <tianfei.zhang@intel.com>, hao.wu@intel.com,
        mdf@kernel.org, linux-fpga@vger.kernel.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
References: <20220429005726.607804-1-tianfei.zhang@intel.com>
 <b3f0bc47-70ea-2da5-2891-3b01550c6da6@redhat.com>
 <20220430142452.GB398931@yilunxu-OptiPlex-7050>
From:   Tom Rix <trix@redhat.com>
Message-ID: <774dee52-7f68-9d50-4a61-feaedd99eb86@redhat.com>
Date:   Sat, 30 Apr 2022 07:54:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220430142452.GB398931@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 4/30/22 7:24 AM, Xu Yilun wrote:
> On Fri, Apr 29, 2022 at 05:23:53AM -0700, Tom Rix wrote:
>> On 4/28/22 5:57 PM, Tianfei Zhang wrote:
>>> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>>
>>> Add the Device Feature List (DFL) feature id for the
>>> High Speed Serial Interface (HSSI) Subsystem to the
>>> table of ids supported by the uio_dfl driver.
>>>
>>> The HSSI Subsystem is a configurable set of IP blocks
>>> to be used as part of a Ethernet or PCS/FEC/PMA pipeline.
>>> Like the Ethernet group used by the N3000 card, the HSSI
>>> Subsystem does not fully implement a network device from
>>> a Linux netdev perspective and is controlled and monitored
>>> from user space software via the uio interface.
>> Generally you should include the url for the dfl definitions.
>>
>> Can you add it here to the commit log ?
> Do you refer to this url, https://github.com/OPAE/dfl-feature-id ?

Yes, exactly.

To someone not working the day-to-day working dfl they will have no clue 
where the fids come from.

When a new one is added to the kernel, it should have a listing in 
dfl-feature-id repo.

If it doesn't, there will be a future conflict.

Tom

>
> Hao has some comments about this at
>
>    https://lore.kernel.org/all/DM6PR11MB38190E6EEF6DE3EB900290C585F39@DM6PR11MB3819.namprd11.prod.outlook.com/
>
>> Otherwise fine.
>>
>> Reviewed-by: Tom Rix <trix@redhat.com>
>>
>>> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>> Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
> This patch is now good to me.
>
> Acked-by: Xu Yilun <yilun.xu@intel.com>
>
>>> ---
>>> v3: change the name of this feature id to HSSI_SUBSYS and rewrite
>>>       the git message.
>>> v2: add HSSI introduction and the git repo of Feature ID table.
>>> ---
>>>    drivers/uio/uio_dfl.c | 2 ++
>>>    1 file changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/uio/uio_dfl.c b/drivers/uio/uio_dfl.c
>>> index 89c0fc7b0cbc..8f39cc8bb034 100644
>>> --- a/drivers/uio/uio_dfl.c
>>> +++ b/drivers/uio/uio_dfl.c
>>> @@ -45,9 +45,11 @@ static int uio_dfl_probe(struct dfl_device *ddev)
>>>    }
>>>    #define FME_FEATURE_ID_ETH_GROUP	0x10
>>> +#define FME_FEATURE_ID_HSSI_SUBSYS	0x15
>>>    static const struct dfl_device_id uio_dfl_ids[] = {
>>>    	{ FME_ID, FME_FEATURE_ID_ETH_GROUP },
>>> +	{ FME_ID, FME_FEATURE_ID_HSSI_SUBSYS },
>>>    	{ }
>>>    };
>>>    MODULE_DEVICE_TABLE(dfl, uio_dfl_ids);


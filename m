Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB5773FCDE
	for <lists+linux-fpga@lfdr.de>; Tue, 27 Jun 2023 15:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjF0N1o (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 27 Jun 2023 09:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjF0N1n (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 27 Jun 2023 09:27:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2022944
        for <linux-fpga@vger.kernel.org>; Tue, 27 Jun 2023 06:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687872409;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x5OGDtvd0E7HFLWScv2tbUzF38eyNnShGwCqNEJiqeQ=;
        b=ZMmGokirguHMqiywcyBJfryq2IexyZp+B9Yk4jmy+qNZQVcvezv1tjSEXMiSy46tfEOarm
        gEF7BWjk7W4BOcpO3YPkgeNuJy5pexert6AtLI711fBT5/wvfd+lqcpOsLzgshyERH+MGP
        TCIvu5Ptexuf8C2pBhl372vV7vyOOec=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-UwfAIS3vNOKLm_CTLGie6g-1; Tue, 27 Jun 2023 09:26:42 -0400
X-MC-Unique: UwfAIS3vNOKLm_CTLGie6g-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-51d912fc933so3288687a12.0
        for <linux-fpga@vger.kernel.org>; Tue, 27 Jun 2023 06:26:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687872400; x=1690464400;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x5OGDtvd0E7HFLWScv2tbUzF38eyNnShGwCqNEJiqeQ=;
        b=ccyO7ZhiMy3zYiXoowxneHNvNKJt8V1sEm6r9dTDH/g9QlO8xWIF97fpOoNvG7OICC
         GSEpxSfARVuSo2heC/SGwYMAXq1jRHEHGWnMcThLECB+efJ/nekxGxm3cwYNgf8I9E0C
         u971o167f2uXBqBA+lEfnW3vQHFudGIrS1Xb1TpsddR6PD3Krv1/fW48txhzAz8ZKYOq
         vPLgeqQsQEiy0Ce65O9BdNWAjcUJ0+qczc88araibBb85R6KtgWyU+E2t1FvYqb6XrC/
         2UVL9e8vcaItvPIXSSWwuuXDRPIabVyr14FaiXRw5jtXkqbo02XTcIwIaCFIYn7eMGFy
         z0IA==
X-Gm-Message-State: AC+VfDzkj/GQZtUI33txMyGa7CqUJhV11/CgfpGU7R6vvQb+3IImfaP/
        +3Wb1piI0q5wYlI+MwGyv52jtIFIaZJ/l5TiLUC3VMSxCeVaDnXuBK8z7AleeDgxDw/rQ3BOXYC
        /cWuiAex8EBpMZrp4Y8q0Uac3s1ga
X-Received: by 2002:a05:6402:274b:b0:51a:4039:b9e with SMTP id z11-20020a056402274b00b0051a40390b9emr30961221edd.9.1687872400178;
        Tue, 27 Jun 2023 06:26:40 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ52G/Z6Xg/VoMG87M0wyoejW240OWaVId3zpD7jzorufN5qsBpvpT/GqcTBGzYaqkSey7RpLQ==
X-Received: by 2002:a05:6402:274b:b0:51a:4039:b9e with SMTP id z11-20020a056402274b00b0051a40390b9emr30961198edd.9.1687872399918;
        Tue, 27 Jun 2023 06:26:39 -0700 (PDT)
Received: from [192.168.9.16] (net-2-34-24-242.cust.vodafonedsl.it. [2.34.24.242])
        by smtp.gmail.com with ESMTPSA id e19-20020a170906249300b0098e4aef0791sm3089232ejb.66.2023.06.27.06.26.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 06:26:39 -0700 (PDT)
Message-ID: <e33e9470-0c55-dcc9-95c7-836e53e49d42@redhat.com>
Date:   Tue, 27 Jun 2023 15:26:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v7 2/4] fpga: add an initial KUnit suite for the FPGA
 Bridge
Content-Language: en-US
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
References: <20230616154405.220502-1-marpagan@redhat.com>
 <20230616154405.220502-3-marpagan@redhat.com>
 <ZJftyXGY5TbEqPqk@yilunxu-OptiPlex-7050>
From:   Marco Pagani <marpagan@redhat.com>
In-Reply-To: <ZJftyXGY5TbEqPqk@yilunxu-OptiPlex-7050>
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



On 2023-06-25 09:33, Xu Yilun wrote:
> On 2023-06-16 at 17:44:03 +0200, Marco Pagani wrote:
>> The suite tests the basic behaviors of the FPGA Bridge including
>> the functions that operate on a list of Bridges.
>                                           ^
> why uppercase?
>

It's a typo. I'll fix the description in the next version.

>>
>> Signed-off-by: Marco Pagani <marpagan@redhat.com>
>> ---
>>  drivers/fpga/tests/fpga-bridge-test.c | 175 ++++++++++++++++++++++++++
>>  1 file changed, 175 insertions(+)
>>  create mode 100644 drivers/fpga/tests/fpga-bridge-test.c
>>
>> diff --git a/drivers/fpga/tests/fpga-bridge-test.c b/drivers/fpga/tests/fpga-bridge-test.c
>> new file mode 100644
>> index 000000000000..fce67ac59a7c
>> --- /dev/null
>> +++ b/drivers/fpga/tests/fpga-bridge-test.c
>> @@ -0,0 +1,175 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * KUnit test for the FPGA Bridge
>> + *
>> + * Copyright (C) 2023 Red Hat, Inc.
>> + *
>> + * Author: Marco Pagani <marpagan@redhat.com>
>> + */
>> +
>> +#include <linux/types.h>
>> +#include <linux/module.h>
>> +#include <linux/device.h>
>> +#include <kunit/test.h>
>> +#include <linux/fpga/fpga-bridge.h>
> 
> alphabetical order please.
>

I'll sort all includes alphabetically in the next version.
 
> Others LGTM.
> Acked-by: Xu Yilun <yilun.xu@intel.com>
> 


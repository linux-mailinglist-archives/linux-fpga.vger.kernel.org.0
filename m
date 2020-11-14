Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AFA02B2E48
	for <lists+linux-fpga@lfdr.de>; Sat, 14 Nov 2020 17:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbgKNP7n (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 14 Nov 2020 10:59:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56315 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727023AbgKNP7n (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Sat, 14 Nov 2020 10:59:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605369581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/z1B79VS6bauxShMToBYrbJVsmG7jXKkwYFCUP4q2iU=;
        b=hyAN7C0sAXQphKcCSD81WauBw24Iec1+M6FPx9UiMt2bsbfnDUmrAe1wozrV3VInanD75b
        741gG/XlPe4IHZS6mBp+CQjp4F5JGYkioeTtVajw7iLacvFfsWFFZZO/M1V54g/6l7/RzA
        p0yS1cXwwhh9L30n33KqnFG27MtudkU=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-1jJ5GwW6P4iKSWTbsSMHnw-1; Sat, 14 Nov 2020 10:59:39 -0500
X-MC-Unique: 1jJ5GwW6P4iKSWTbsSMHnw-1
Received: by mail-qt1-f200.google.com with SMTP id e22so7666405qte.22
        for <linux-fpga@vger.kernel.org>; Sat, 14 Nov 2020 07:59:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=/z1B79VS6bauxShMToBYrbJVsmG7jXKkwYFCUP4q2iU=;
        b=dWTZj2k1/6gHj6rWhQNiml1OZhl9u++uBbqMvuipOyZzHhFL1aSuLRLzmmXA0Uq0qs
         QPKWOO0xZt9NHIscVHnAi/HcteTPyh0S05OyVlu4v3O0L9RaTTO0fnCdKxL/pviDDbDl
         r+43DKPU2hpfyLcDK32waggQsvm+m473N5Fy3z8IgjTiln2VSWgWjwHBarppgW5dmaLP
         yo3iGYpOm/0gUpXoXLXmyN4SXfSMBjyqGs1qIWBl2N4Lgpkh8s8ED8n738JRBvIPqcVx
         vHU6ZNoR7xl03dstumTblYhSLo1I8Bbp02LG32884qmFolZumFYVblINlPQ/FDBd0aAk
         OyIg==
X-Gm-Message-State: AOAM533ibzZWtK1uCxBTC8+GETCsph0PjZ8t5SrCzq14nLx3JS1iZ70r
        ZYuLlVaUzsFi/WdnI90Bo90goF6dHHx+zGAraG6tSO5hTVJZozC2FL/oyk0pDBkG4KO4I9Ge16C
        cywJsBFmz5NDHjkxkZf92ig==
X-Received: by 2002:a37:b8c:: with SMTP id 134mr7093956qkl.483.1605369579484;
        Sat, 14 Nov 2020 07:59:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzqg0PGoBgLFTsBJoexYCYGqpRS7JiOSmj5AywSbRW4KMhJJWVidG+QsDWZa7LIBlnPWVR/lg==
X-Received: by 2002:a37:b8c:: with SMTP id 134mr7093948qkl.483.1605369579307;
        Sat, 14 Nov 2020 07:59:39 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id r18sm8779627qtp.89.2020.11.14.07.59.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Nov 2020 07:59:38 -0800 (PST)
Subject: Re: [PATCHv1 3/4] dt-bindings: fpga: add authenticate-fpga-config
 property
To:     Richard Gong <richard.gong@linux.intel.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dinguyen@kernel.org, sridhar.rajagopal@intel.com,
        Richard Gong <richard.gong@intel.com>
References: <1605204403-6663-1-git-send-email-richard.gong@linux.intel.com>
 <1605204403-6663-4-git-send-email-richard.gong@linux.intel.com>
 <94ccfc8d-ecf9-7782-9044-d3c0cb862118@redhat.com>
 <e7b815c1-e153-2bed-7793-0affd4d74f9e@linux.intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <a63cb1f6-4bb4-9f7d-e1b0-8054e8d4a21b@redhat.com>
Date:   Sat, 14 Nov 2020 07:59:37 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <e7b815c1-e153-2bed-7793-0affd4d74f9e@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 11/14/20 6:52 AM, Richard Gong wrote:
> Hi Tom,
>
>>>       prior to OS boot up.
>>>   - encrypted-fpga-config : boolean, set if the bitstream is encrypted
>>> +- authenticate-fpga-config : boolean, set if do bitstream authentication
>>
>> The list is mostly in alphabetical order so the new 'authenticate-... ' should go at the top.
>>
>
> The original list is not in alphabetical order. The order of partial-fpga-config, external-fpga-config and encrypted-fpga-config here follows the implementation in the of-fpga-region.c file.
>
> So authenticate-fpga-config should follow the way, correct?
>
This is why i say 'mostly' ..

In general when listing options for a user to read, you should make it easy for them to find

the option they are looking for.  Ordering them alphabetically is an obvious but not the only

way.  I am not asking for you to fix the whole table, just what you are adding. If there is

a better way to organize them please propose the method.

Tom

>> Improve what you mean by 'authentication' similar to my comment in the first patch.
>>
>
> Will do in the version 2 submission.
>
> Regards,
> Richard
>
>> Tom
>>
>>>   - region-unfreeze-timeout-us : The maximum time in microseconds to wait for
>>>       bridges to successfully become enabled after the region has been
>>>       programmed.
>>
>


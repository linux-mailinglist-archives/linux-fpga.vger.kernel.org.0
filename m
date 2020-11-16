Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE9B12B48DB
	for <lists+linux-fpga@lfdr.de>; Mon, 16 Nov 2020 16:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730696AbgKPPMM (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 16 Nov 2020 10:12:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46762 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728029AbgKPPML (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 16 Nov 2020 10:12:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605539530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OGx9VTVE9xrpd7TRsclbo/UztTFDKECkKQ0QsjPjJB8=;
        b=CHlSrcZy8y6w/2vAgLuOjrn7GWhE3NuOXnTmLLgFGLJ0QLhseUlOgZPTv98Cw9hrz8sKFj
        7Lqs9jhSoc3YsaD9mV31jPkI5HyMpzuBj+ykN+9G5YvjTOBIN5A0cW8UrwShYZFllH5QES
        dEqSfgxP42HTw0ykM06Gvee849H5phc=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-JVlqb4xwP0u1alP8Ph-c4w-1; Mon, 16 Nov 2020 10:11:52 -0500
X-MC-Unique: JVlqb4xwP0u1alP8Ph-c4w-1
Received: by mail-qv1-f70.google.com with SMTP id ek3so5205151qvb.0
        for <linux-fpga@vger.kernel.org>; Mon, 16 Nov 2020 07:11:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=OGx9VTVE9xrpd7TRsclbo/UztTFDKECkKQ0QsjPjJB8=;
        b=HXHb+YUuiG2BV2UG/byU4Vc85urT84U9xn5JGTvMfMjrffx5i2x8GG96kW2Z/QDC/n
         o60sAyuR3GWuqtnzHkaEaCGELYyGSXKz8/IxH/39jXTsRsgZZz8Vl9LTwh4jMBt1ATC2
         0cbR8+BPPmN05qG/QQxA3pqf9BKrMpM+vv+9U00I+3XMtwuXaBK3GO+oulEXdLn+6Bwi
         20SLyCJlbtywHBeq8iDEHUHySPUkNq+Gt8V0D5jltyZdsXc7UC2F7IZO5y1tNWt2VSO5
         blasHS+LkjZeNwnW2/vDb6txQob1ym21KBJTjVtDiLK425EvE0zxXEo4kBv7dI3Z0gFJ
         zqaQ==
X-Gm-Message-State: AOAM531nh2Lpz7/sYxuvbPXAWd9M1WuGBl0wmYKebbtOLUNrv+NUmugp
        63+Yc+byk6krLwk4MIvEOQNkIE6c6XCEGbH/xlrSIxVT84NadaFadoPXoX6nQUjFkYXq1Qw3zXy
        eten/jC01fhQYw3woBVXCSQ==
X-Received: by 2002:ac8:5c47:: with SMTP id j7mr15238832qtj.62.1605539511760;
        Mon, 16 Nov 2020 07:11:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwOAN/fykwbTByJ3lPL54lAYfP0o9Whbe5l7+LWEx0FBqjIa2HK8fyxDntVIqhpaP38dkIenA==
X-Received: by 2002:ac8:5c47:: with SMTP id j7mr15238799qtj.62.1605539511500;
        Mon, 16 Nov 2020 07:11:51 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id f202sm11870849qke.112.2020.11.16.07.11.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2020 07:11:50 -0800 (PST)
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
 <a63cb1f6-4bb4-9f7d-e1b0-8054e8d4a21b@redhat.com>
 <50204b8d-91dd-e1d4-45f0-9b3e21d7309b@linux.intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <30a35bbd-f1c1-4f80-c3b4-ae5aa409ec4c@redhat.com>
Date:   Mon, 16 Nov 2020 07:11:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <50204b8d-91dd-e1d4-45f0-9b3e21d7309b@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 11/16/20 5:50 AM, Richard Gong wrote:
> Hi Tom,
>
>
> On 11/14/20 9:59 AM, Tom Rix wrote:
>>
>> On 11/14/20 6:52 AM, Richard Gong wrote:
>>> Hi Tom,
>>>
>>>>>        prior to OS boot up.
>>>>>    - encrypted-fpga-config : boolean, set if the bitstream is encrypted
>>>>> +- authenticate-fpga-config : boolean, set if do bitstream authentication
>>>>
>>>> The list is mostly in alphabetical order so the new 'authenticate-... ' should go at the top.
>>>>
>>>
>>> The original list is not in alphabetical order. The order of partial-fpga-config, external-fpga-config and encrypted-fpga-config here follows the implementation in the of-fpga-region.c file.
>>>
>>> So authenticate-fpga-config should follow the way, correct?
>>>
>> This is why i say 'mostly' ..
>>
>> In general when listing options for a user to read, you should make it easy for them to find
>>
>> the option they are looking for.  Ordering them alphabetically is an obvious but not the only
>>
>> way.  I am not asking for you to fix the whole table, just what you are adding. If there is
>>
>> a better way to organize them please propose the method.
>>
>
> How about put authenticate-fpga-config above partial-fpga-config? I would like to group all xxx-fpga-config flags together.

Ok that sounds fine.

Tom

>
>
> Regards,
> Richard
>
>> Tom
>>
>>>> Improve what you mean by 'authentication' similar to my comment in the first patch.
>>>>
>>>
>>> Will do in the version 2 submission.
>>>
>>> Regards,
>>> Richard
>>>
>>>> Tom
>>>>
>>>>>    - region-unfreeze-timeout-us : The maximum time in microseconds to wait for
>>>>>        bridges to successfully become enabled after the region has been
>>>>>        programmed.
>>>>
>>>
>>
>


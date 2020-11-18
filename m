Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 951572B73C5
	for <lists+linux-fpga@lfdr.de>; Wed, 18 Nov 2020 02:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgKRB36 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 17 Nov 2020 20:29:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56188 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727246AbgKRB36 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 17 Nov 2020 20:29:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605662996;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5y9d1mDFu+1IAn4UKYshZB62u1n5Z+noiYA1PqcdhCk=;
        b=PfQCA4cwGft1kIrM88CZ+KZ1BincKYvjIkt7mdeyk55xAm9AZ6OspEj+6WHaxsNk10S9hk
        3Xi7y3fJG8Prp2uxfmSLuzdAS5Ad/5+fY2G2yIsaYEycJip/BgPqI5th9dPpbcE9P8wTVp
        bx0CKM96V8oiVNfJxUU0Wz9ATN3BFwg=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-J4IlT1YpOGesZEDOv6S6RA-1; Tue, 17 Nov 2020 20:29:55 -0500
X-MC-Unique: J4IlT1YpOGesZEDOv6S6RA-1
Received: by mail-qt1-f199.google.com with SMTP id i20so381136qtr.0
        for <linux-fpga@vger.kernel.org>; Tue, 17 Nov 2020 17:29:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=5y9d1mDFu+1IAn4UKYshZB62u1n5Z+noiYA1PqcdhCk=;
        b=rJzW8bcByYysajLVbDyFJco78wdNkj5R+VVawEu8iqS+QCg3CTZtuMp0UwLnm6+Vk1
         vIJbRfWRnEmRR2+vXFXFlu77nNfV3qVnqTAU8eo/f/7H3Y04QHE7WLCXSZy7BZlf/dw2
         umcAl3E3lWCwnkTj82oIyju2BuDab4qdlSERw8oDjih9/+wSbtz2tV23UKjPWeUZ2Q6D
         s1EzlCx+ovORwukueovep2CILZRi/fcB9zrwNkCWf3hKxhsNMVkXi7VBV2OmpEAOBFcI
         N+71uWGH+LyW3Ihy5G5fai6Gpsowi0D+Hx8aNxAoLdrG7xm1zRuAcvh+s0hHGWr3KlDw
         RU1Q==
X-Gm-Message-State: AOAM533jH1eVtNdDsSVggptKOXVItimzSL5P+kE9mLPS6oEgZlbRkN17
        XYDRIMkP8kl5gFrAlkUj1Mmv7Cl7USHxx+5WpJwUC4GH+syDAahFWMp2X5BJe8zPhZGZPQG2K1h
        iFwwecfMMluPlynYYNWa0xA==
X-Received: by 2002:a0c:9bac:: with SMTP id o44mr2630011qve.43.1605662994570;
        Tue, 17 Nov 2020 17:29:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxmxm5sTloYaS7lk1Nby+l3Pt4GRZsecKIapPOdPkL0PKYvK5KZOWnsOoSdlJa8/b2h2bRjjA==
X-Received: by 2002:a0c:9bac:: with SMTP id o44mr2630000qve.43.1605662994342;
        Tue, 17 Nov 2020 17:29:54 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id c27sm15395005qkk.57.2020.11.17.17.29.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2020 17:29:53 -0800 (PST)
Subject: Re: [PATCH 2/2] fpga: dfl: look for vendor specific capability
To:     matthew.gerlach@linux.intel.com
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        mdf@kernel.org, hao.wu@intel.com, linux-doc@vger.kernel.org,
        corbet@lwn.net
References: <20201117012552.262149-1-matthew.gerlach@linux.intel.com>
 <20201117012552.262149-3-matthew.gerlach@linux.intel.com>
 <53b9cb12-8002-5737-ba8b-7c59687ead5a@redhat.com>
 <alpine.DEB.2.22.394.2011171457150.312724@rhweight-WRK1>
From:   Tom Rix <trix@redhat.com>
Message-ID: <2a81ac9c-482e-c0ec-ea71-d811fdf8a01a@redhat.com>
Date:   Tue, 17 Nov 2020 17:29:51 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2011171457150.312724@rhweight-WRK1>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


>> Is this really an either/or ?
>>
>> Could there be a base functionality on bar0 and a skew functionality on vendor bars?
>
> For simplicity I think either or is better.  If skew functionality is in vendor bars, why not just use the vendor bars all the time.
>
>>
>> If vendor is going to completely override, why not use bar0 ?
>
> I'm not sure I understand the question, but in v2 the legacy DFL search will only occur if there is no VSEC found.
>
Wondering if vsec was ignored, would the bar0 work ?

Or another way, how badly would an old driver behave.

consider incrementing the driver version if it would be bad.

Tom


>>
>> Tom
>>
>>>
>>>      if (ret)
>>>          goto irq_free_exit;
>>
>>
>


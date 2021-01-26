Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89622303F4D
	for <lists+linux-fpga@lfdr.de>; Tue, 26 Jan 2021 14:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405516AbhAZNvB (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 26 Jan 2021 08:51:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24469 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405514AbhAZNut (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 26 Jan 2021 08:50:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611668960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MYu5BQ2EF91Z99K/GYTOY1vC6Pp9/D8PfbMST9otyFw=;
        b=RFCNzvsvHmkrvGROSKFxFAkryJN1PPaHcF4D0niELkeC9q92OkIsAWczC6eBvdSQEIuRKV
        f23VZEA0uaQCrxP+dDCshb8wm5gYRYJJHddOUYcbRmMBr11nrM+igGW+qQOgSIAdrpMxJa
        Re2DvwRn6uOZfcAWIcDl0j+R8xy0L2Y=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-2T-GKp6qOd-noPU_7KM0AA-1; Tue, 26 Jan 2021 08:49:17 -0500
X-MC-Unique: 2T-GKp6qOd-noPU_7KM0AA-1
Received: by mail-qk1-f199.google.com with SMTP id y187so12401963qke.20
        for <linux-fpga@vger.kernel.org>; Tue, 26 Jan 2021 05:49:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=MYu5BQ2EF91Z99K/GYTOY1vC6Pp9/D8PfbMST9otyFw=;
        b=nHLuS9LtSomNj+SozTpEYKqIQfGLlRwjsSM9f8zO1zXDcukEYbS6kY5lwlePZly8YW
         Dt8Gg4b/KPEmzIw6EU2S1wGB+HhH6eP9D8pX5J8wHoLa/Ga8OggOIdjDpkVCv+bEh+5+
         CkXXfC9jO+Vlj3kW1ZQBq+Sa0rVKxaQLwtZE9Fgl53Cow18ISsAqmPHXvSUY4eMlgMPk
         erlknbblnvJFljhe+BVW09QN9pZz8ChL56tWluN17+eLeiIOSgVV5r2o8HKZD78SE9ja
         bbJA6dI0uxecO17Mvb2fDxB7qGtlQqXxt3CPTntjhF9Ee825pf98RxP7g0KiXiQeGXoH
         qJag==
X-Gm-Message-State: AOAM532B+6pGXV69JzKNIDq5pcIZu8f4LKNNIBACy3XHt+4B6tk8Mjis
        RTgJ93CEg6zPjvgvqRgwT5uVxeG/SJYZ8THAR5YU3nkBa+27mHc5wRrFCqVpFi9zT7PeRU+vtu9
        Md91G3Mgh1/QuXocI2d3a+A==
X-Received: by 2002:a37:8344:: with SMTP id f65mr5590661qkd.398.1611668957155;
        Tue, 26 Jan 2021 05:49:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzZDLsBwpdlQ4agI0cNfcNke8pZgQ77JzfLYMIDWdFaOKEFCetH7NP1xUkn9txwyk3OaxJ2ww==
X-Received: by 2002:a37:8344:: with SMTP id f65mr5590638qkd.398.1611668956833;
        Tue, 26 Jan 2021 05:49:16 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id u5sm14547658qkb.120.2021.01.26.05.49.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jan 2021 05:49:16 -0800 (PST)
Subject: Re: [PATCH v9 1/2] uio: uio_dfl: add userspace i/o driver for DFL bus
To:     Xu Yilun <yilun.xu@intel.com>, Moritz Fischer <mdf@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, lgoncalv@redhat.com, hao.wu@intel.com
References: <1611564563-9665-1-git-send-email-yilun.xu@intel.com>
 <1611564563-9665-2-git-send-email-yilun.xu@intel.com>
 <e9bb1ff8-f630-f1a3-985c-7e51369a733f@redhat.com>
 <YA98/8r+yOCurHAJ@epycbox.lan> <20210126024005.GB3907@yilunxu-OptiPlex-7050>
From:   Tom Rix <trix@redhat.com>
Message-ID: <2453fe70-9459-f260-305c-3ca5d6fa8aff@redhat.com>
Date:   Tue, 26 Jan 2021 05:49:14 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210126024005.GB3907@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 1/25/21 6:40 PM, Xu Yilun wrote:
> On Mon, Jan 25, 2021 at 06:22:55PM -0800, Moritz Fischer wrote:
>> On Mon, Jan 25, 2021 at 11:00:38AM -0800, Tom Rix wrote:
>>> On 1/25/21 12:49 AM, Xu Yilun wrote:
>>>> This patch supports the DFL drivers be written in userspace. This is
>>>> realized by exposing the userspace I/O device interfaces.
>>>>
>>>> The driver now only binds the ether group feature, which has no irq. So
>>>> the irq support is not implemented yet.
>>>>
>>>> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
>>>> ---
>>>> v9: switch to add a uio driver in drivers/uio
>>>> ---
>>>>  drivers/uio/Kconfig   | 13 ++++++++++
>>>>  drivers/uio/Makefile  |  1 +
>>>>  drivers/uio/uio_dfl.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++
>>> You should add this to the MAINTAINERS file.
>> This is covered by MAINTAINERS under drivers/uio.
> Yes. But is it OK I also add the file in "FPGA DFL DRIVERS"? So DFL
> developers would also be aware if there is change. It is a little
> different from other feature driver, it is like a generic driver for
> DFL bus.

I think the issue is which maintainer branch this gets merged into.

It would not be linux-fpga.

It is this sort of driver I want to add to FPGA SUBDEVICES list described here

https://lore.kernel.org/linux-fpga/96a9d3d9-6091-47c9-21f9-0cfdd9464732@redhat.com/

Where the driver is maintained in the subsystem but reviewed in linux-fpga.

Tom

>>>>  3 files changed, 80 insertions(+)
>>>>  create mode 100644 drivers/uio/uio_dfl.c
>>>>
>>>> diff --git a/drivers/uio/Kconfig b/drivers/uio/Kconfig
>>>> index 202ee81..44778f8 100644
>>>> --- a/drivers/uio/Kconfig
>>>> +++ b/drivers/uio/Kconfig
>>>> @@ -165,4 +165,17 @@ config UIO_HV_GENERIC
>>>>  	  to network and storage devices from userspace.
>>>>  
>>>>  	  If you compile this as a module, it will be called uio_hv_generic.
>>>> +
>>>> +config UIO_DFL
>>>> +	tristate "Generic driver for DFL bus"
>>> The term 'DFL' will be unknown to folks in drivers/uio
>>>
>>> I think it would be better if DFL was always prefixed 'FPGA DFL'
>>>
>>>> +	depends on FPGA_DFL
>>>> +	help
>>>> +	  Generic DFL (Device Feature List) driver for Userspace I/O devices.
>>>> +	  It is useful to provide direct access to DFL devices from userspace.
>>>> +	  A sample userspace application using this driver is available for
>>>> +	  download in a git repository:
>>>> +
>>>> +	    git clone https://github.com/OPAE/opae-sdk.git
>>>> +
>>>> +	  If you compile this as a module, it will be called uio_dfl.
>> I'm not sure KConfig is the right place for this.
> Do you mean the OPAE link? I see several uio drivers provide their
> userspace application link in Kconfig. I guess the uio drivers are
> selected for these applications so it may be better pointing out where
> they are.
>
> Thanks,
> Yilun
>


Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 917132FECFC
	for <lists+linux-fpga@lfdr.de>; Thu, 21 Jan 2021 15:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729307AbhAUOfg (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 21 Jan 2021 09:35:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20588 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731416AbhAUOf2 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 21 Jan 2021 09:35:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611239641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OPgZQ9Q0d3vyyfzwXvao6f1etHw0jK/2oOivmLElAWA=;
        b=dn4XobPimT+vVgbsoqDRbe/Z/d2YkcmicDcGEC8qiE0DoCkR/LE8q9YeYxED7i4BNj3DmK
        FHCMkxIqd12bSmZvCVqCTMK8gy9fhPdqnLt5iedvy5UyvoBWqKHBtBIDCo+9BQE0ITnaEH
        CiNmHGibXbZ3P/0235QM+juAVacT8Js=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-MLWkPjctPOShQhIiJt_JlA-1; Thu, 21 Jan 2021 09:30:23 -0500
X-MC-Unique: MLWkPjctPOShQhIiJt_JlA-1
Received: by mail-qv1-f70.google.com with SMTP id x19so1534052qvv.16
        for <linux-fpga@vger.kernel.org>; Thu, 21 Jan 2021 06:30:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=OPgZQ9Q0d3vyyfzwXvao6f1etHw0jK/2oOivmLElAWA=;
        b=RhZVhOJtlmkaGWneoRQHfEBDWlq4yW5IY/43lPIMeDuDOmHdSRYzPjyJZbVRBuNDji
         Yw6UG4eDUU2khy9P+XwVO+a4vTLpWfC5sdblpipOCSP3gBu6hrSph4yoG+9hHhGvz3VO
         J6aQcSU/3UnwMmt5nBw5FfQP9FzjQtdjMdlSgMyGryR+iyWxmDyMjeVxW3Nu/AZuM8XQ
         vM6xdz5Bzvgp1ZL5Jr57D1PuWPSA0sDC/LSRahDpzWWmdVFX9aZJRs6A9L4CmJMe4HQM
         FVWhZpT+6n/a44OuRcxDRAYGbDR+DFcw5loUJS8z3k1ihBCK2E92svE9WXIVCey7Z3bT
         mQlw==
X-Gm-Message-State: AOAM5339Ud9ey14QZGbOer6eWL+8VnhCYe4U7FvE8aAK4h2g+9reQ57A
        /SOJYrrRaVSeA2haEq/0S4ikx0piuXSUJPANPY+2BE5TYnPrRFIeyBns8AG+Xn8eELV6ELsPi7/
        2dxzmqJ916dAF6LkcQWX38A==
X-Received: by 2002:ac8:24c8:: with SMTP id t8mr13708966qtt.328.1611239423463;
        Thu, 21 Jan 2021 06:30:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwG9N+ifnQhFiSEWYUQWQZ6h6RlgnLaIwbr7ZsgJ1C6oKEbZ3bEHc8bcMxj/oT1ikk0/sN74g==
X-Received: by 2002:ac8:24c8:: with SMTP id t8mr13708936qtt.328.1611239423108;
        Thu, 21 Jan 2021 06:30:23 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id v8sm3541315qtq.80.2021.01.21.06.30.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jan 2021 06:30:22 -0800 (PST)
Subject: Re: [PATCH v6 1/2] fpga: dfl: add the userspace I/O device support
 for DFL devices
To:     Moritz Fischer <mdf@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Xu Yilun <yilun.xu@intel.com>, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, lgoncalv@redhat.com, hao.wu@intel.com
References: <1610502848-30345-1-git-send-email-yilun.xu@intel.com>
 <1610502848-30345-2-git-send-email-yilun.xu@intel.com>
 <YARbgGU6lr3zZaKP@kroah.com> <YARkTFMrotPo45ic@epycbox.lan>
From:   Tom Rix <trix@redhat.com>
Message-ID: <1d205328-6ffa-0f77-0bdf-0f4b822edc3a@redhat.com>
Date:   Thu, 21 Jan 2021 06:30:20 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YARkTFMrotPo45ic@epycbox.lan>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 1/17/21 8:22 AM, Moritz Fischer wrote:
> Greg,
>
> On Sun, Jan 17, 2021 at 04:45:04PM +0100, Greg KH wrote:
>> On Wed, Jan 13, 2021 at 09:54:07AM +0800, Xu Yilun wrote:
>>> This patch supports the DFL drivers be written in userspace. This is
>>> realized by exposing the userspace I/O device interfaces.
>>>
>>> The driver leverages the uio_pdrv_genirq, it adds the uio_pdrv_genirq
>>> platform device with the DFL device's resources, and let the generic UIO
>>> platform device driver provide support to userspace access to kernel
>>> interrupts and memory locations.
>> Why doesn't the existing uio driver work for this, why do you need a new
>> one?
>>
>>> ---
>>>  drivers/fpga/Kconfig        | 10 +++++
>>>  drivers/fpga/Makefile       |  1 +
>>>  drivers/fpga/dfl-uio-pdev.c | 93 +++++++++++++++++++++++++++++++++++++++++++++
>> uio drivers traditionally go in drivers/uio/ and start with "uio", so
>> shouldn't this be drivers/uio/uio_dfl_pdev.c to match the same naming
>> scheme?
> I had considered suggesting that, but ultimately this driver only
> creates a 'uio_pdrv_genirq' platform device, so it didn't seem like a
> good fit.
>> But again, you need to explain in detail, why the existing uio driver
>> doesn't work properly, or why you can't just add a few lines to an
>> existing one.
> Ultimately there are three options I see:
> 1) Do what Xu does, which is re-use the 'uio_pdrv_genirq' uio driver by
>   creating a platform device for it as sub-device of the dfl device that
>   we bind to uio_pdrv_genirq
> 2) Add a module_dfl_driver part to drivers/uio/uio_pdrv_genirq.c and
>   corresponding id table
> 3) Create a new uio_dfl_genirq kind of driver that uses the dfl bus and
>   that would make sense to then put into drivers/uio. (This would
>   duplicate code in uio_pdrv_genirq to some extend)
>
> Overall I think in terms of code re-use I think Xu's choice might be
> less new code as it simply wraps the uio platform device driver, and
> allows for defining the resources passed to the UIO driver to be defined
> by hardware through a DFL.
>
> I've seen the pattern that Xu proposed used in other places like the
> macb network driver where you'd have macb_main (the platform driver) and
> macb_pci that wraps it for a pci usage.
>
> - Moritz

Thinking of this problem more generally.

Every fpga will have a handful of sub devices.

Do we want to carry them in the fpga subsystem or carry them in the other subsystems ?

Consider the short term reviewing and long term maintenance of the sub devices by the subsystem maintainers.

It easier for them if the sub devices are in the other subsystems.


Applying this to specifically for dfl_uio.

No one from the uio subsystem reviewing this change is a problem.

I think this change needs to go to the uio subsystem.

And a new entry in the MAINTAINERS file to keep the fpga subsystem in the loop for reviews and acks

Tom


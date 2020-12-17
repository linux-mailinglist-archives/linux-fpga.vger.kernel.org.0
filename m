Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 773C92DD23C
	for <lists+linux-fpga@lfdr.de>; Thu, 17 Dec 2020 14:37:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbgLQNhX (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 17 Dec 2020 08:37:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53692 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726983AbgLQNhX (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 17 Dec 2020 08:37:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608212156;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SgJOBcxRN4tEtPumxdF20iYY88fFb0qgiurqky0v6BE=;
        b=FQbBuYZ4cSHEj3r0F3D1uJU1sSaajuDHxkXnkUbyeVizfothBKEayzHLFzIRPPJYfIuOQM
        YYK9YQmZqxtXNknieQFY4rSRHeCS7wz4h50RSQsugfulYzLpExR1NX1X57/iUT0AgFDm3p
        6NYHYXD1/fmx8GYNFMDB9GmxgzHTt74=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-459-xMf2zK8AOkCDGtpHWqnl8A-1; Thu, 17 Dec 2020 08:35:55 -0500
X-MC-Unique: xMf2zK8AOkCDGtpHWqnl8A-1
Received: by mail-qk1-f197.google.com with SMTP id k126so4842307qkf.8
        for <linux-fpga@vger.kernel.org>; Thu, 17 Dec 2020 05:35:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=SgJOBcxRN4tEtPumxdF20iYY88fFb0qgiurqky0v6BE=;
        b=HjqjHviH4nl35yp7Z27SDAp4R/Ge8j1nIyHol11raBNsDyWmF6h12n6eu7jC7wbqjl
         XQulFoWqWSxX6e07mYKgsknhR8+Ivuzth7nAnkIeVG25LDTkmE0NiOvdIyNYUGwYruRq
         Yqr4Y/oKBAGnLAxhxQnzsR7E51V+oRTTaissYkgR/mwmBqMKMTPfzjJNaUGadnm/jWdE
         23OvZIy7ihb7drp7vji6RaosY9eWYyFgtkFVRJMY0G3NnqIdFmlREnl4bpld9ppEKgZw
         ejxzsnnNzHVphF28+lcijWxHtT9Raz0QvWjJSZnCj6rATJpZgOEaMzPKZyAEwEgsh946
         ElVQ==
X-Gm-Message-State: AOAM5310+eJh5bKrhmJWvvatndY802B6CsctA+h//7QxXh+9/3q0N585
        Pd0ViAN8enBrZCOn/QoagU2P2wUm72vqFD5aH1Rd0y/EVdWB8/W3Jbuy1gHhwFxP10fO+qIzhR8
        SFROErF2zUaGbzm9yK/SpyA==
X-Received: by 2002:a05:620a:ec7:: with SMTP id x7mr48049240qkm.405.1608212154532;
        Thu, 17 Dec 2020 05:35:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxPs+dQeJxIwLKOCxSjTEM23FpThc6Rq1C2Qh0/YIA30/RVV77JmZbVHRRLj3GBEXH8+F6uGw==
X-Received: by 2002:a05:620a:ec7:: with SMTP id x7mr48049217qkm.405.1608212154332;
        Thu, 17 Dec 2020 05:35:54 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id s19sm53162qta.35.2020.12.17.05.35.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Dec 2020 05:35:53 -0800 (PST)
Subject: Re: [PATCH v3 0/3] UIO support for dfl devices
To:     Xu Yilun <yilun.xu@intel.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, lgoncalv@redhat.com, hao.wu@intel.com
References: <1608183881-18692-1-git-send-email-yilun.xu@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <85d48e41-0185-0938-b0ed-93d0f825e761@redhat.com>
Date:   Thu, 17 Dec 2020 05:35:51 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <1608183881-18692-1-git-send-email-yilun.xu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 12/16/20 9:44 PM, Xu Yilun wrote:
> This patchset supports some dfl device drivers written in userspace.
>
> In the patchset v1, the "driver_override" interface should be used to bind
> the DFL UIO driver to DFL devices. But there is concern that the
> "driver_override" interface is not OK itself. So in v2, we use a new
> matching algorithem. The "driver_override" interface is abandoned, the DFL
> UIO driver matches any DFL device which could not be handled by other DFL
> drivers. So the DFL UIO driver could be used for new DFL devices which are
> not supported by kernel, also it will not impact the devices which are
> already got supported.

This set looks good to me.

Moritz,

Is it possible to get this into 5.11 ?

Tom

>
> Main changes from v1:
> - switch to the new matching algorithem. It matches DFL devices which could
>   not be handled by other DFL drivers.
> - refacor the code about device resources filling.
> - add the documentation.
>
> Main changes from v2:
> - split the match ops changes in dfl.c to an independent patch.
> - move the declarations needed for dfl-uio-pdev from include/linux/dfl.h
>   to driver/fpga/dfl.h
> - some minor fixes.
>
>
> Xu Yilun (3):
>   fpga: dfl: add the match() ops for dfl driver
>   fpga: dfl: add the userspace I/O device support for DFL devices
>   Documentation: fpga: dfl: Add description for DFL UIO support
>
>  Documentation/fpga/dfl.rst  |  27 +++++++++++
>  drivers/fpga/Kconfig        |  10 ++++
>  drivers/fpga/Makefile       |   1 +
>  drivers/fpga/dfl-uio-pdev.c | 110 ++++++++++++++++++++++++++++++++++++++++++++
>  drivers/fpga/dfl.c          |  22 +++++++--
>  drivers/fpga/dfl.h          |   5 ++
>  include/linux/dfl.h         |   3 ++
>  7 files changed, 173 insertions(+), 5 deletions(-)
>  create mode 100644 drivers/fpga/dfl-uio-pdev.c
>


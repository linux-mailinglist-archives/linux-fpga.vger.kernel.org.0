Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84A813A8A70
	for <lists+linux-fpga@lfdr.de>; Tue, 15 Jun 2021 22:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbhFOUuk (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 15 Jun 2021 16:50:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43884 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229898AbhFOUuj (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 15 Jun 2021 16:50:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623790114;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KQ07UnerLYYg5xbQ2D5ZXpRlZkXdV15KKy3dzWwHbIQ=;
        b=OSmNgLJyms9znjti4I/VSl0oF4rw/9aA6iGOZR+jwL+sjxXPyy+KmO3GumoxH+NmBQ41fD
        MMDngd27JQAtdksN5dS0GuaRqx+jXL2pd5KT9kb/8+F1QloiyzZq+GXPvA8Tua0yBnyUHm
        DZCgp8R69hhnhnpWDXSJhfo7nuNbn2U=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-Hosu1J5gOvuoLjFImmtY5Q-1; Tue, 15 Jun 2021 16:48:31 -0400
X-MC-Unique: Hosu1J5gOvuoLjFImmtY5Q-1
Received: by mail-oi1-f197.google.com with SMTP id l123-20020acad4810000b02901f1fb44dca7so8357682oig.15
        for <linux-fpga@vger.kernel.org>; Tue, 15 Jun 2021 13:48:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=KQ07UnerLYYg5xbQ2D5ZXpRlZkXdV15KKy3dzWwHbIQ=;
        b=mf8qQSy3FVSgebu36i7+OgdZAkVXarfr8B9w8OcJFYmOJo7PbUhyVVA4jxT0L4X0hN
         1IO6Sa+qvwjH2mJl33I3iLvymOL7W5CrKauPJxbF1ZDmZIr95meJ6oMYxjqKhZEkgiqJ
         KwsvwCIZBFtziJETlbZIVrq5lMKO7XiMFIm7HNnmC5TfiZFV9MJBy638TCAXY3gx2y86
         tXuM/ob1OC5bhF3ORju3sWzziSRctE+iWpWA8BiN6WfC88YV3L/Ron76CqDNBLeIEtvA
         bkn6Mq6u7VS6OeQ39llaFN2s1kcb6APyGKOjoKiFz+KBoksCZ8rSN6s/r2kR4rHdQS7X
         DVfA==
X-Gm-Message-State: AOAM531FEoYj3yB8d0eWfk1nk6UzDf8TAQbvv8c8/ZgblzbpIBVqq5ng
        Y4s9vJgXWutuBhJu/FAvLwlZIYA1W222XDydCrOmxxAUK1c8MtB+1lSIrAeg+KdjiYiqdrd2+U2
        /NvQ4PivgncXzMbBMnTl1FQ==
X-Received: by 2002:a05:6830:1f05:: with SMTP id u5mr876283otg.322.1623790110353;
        Tue, 15 Jun 2021 13:48:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzvrGdxE+mzotrdFHuMpTK34RUPz5I1mTgC8N7HwfPe918vRPs0JpOJGFEIPWIQK4ioxDj+rg==
X-Received: by 2002:a05:6830:1f05:: with SMTP id u5mr876264otg.322.1623790110110;
        Tue, 15 Jun 2021 13:48:30 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id i26sm1364oig.13.2021.06.15.13.48.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jun 2021 13:48:29 -0700 (PDT)
Subject: Re: [PATCH v4 1/4] fpga: dfl: reorganize to subdir layout
To:     "Wu, Hao" <hao.wu@intel.com>, "mdf@kernel.org" <mdf@kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "krzysztof.kozlowski@canonical.com" 
        <krzysztof.kozlowski@canonical.com>,
        "nava.manne@xilinx.com" <nava.manne@xilinx.com>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "davidgow@google.com" <davidgow@google.com>,
        "fpacheco@redhat.com" <fpacheco@redhat.com>,
        "Gong, Richard" <richard.gong@intel.com>,
        "luca@lucaceresoli.net" <luca@lucaceresoli.net>
Cc:     "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20210614201648.3358206-1-trix@redhat.com>
 <20210614201648.3358206-3-trix@redhat.com>
 <DM6PR11MB381964374223D0D2958AFA6985309@DM6PR11MB3819.namprd11.prod.outlook.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <d64b0fb8-5f83-2995-7ee9-b4ed2932ef60@redhat.com>
Date:   Tue, 15 Jun 2021 13:48:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <DM6PR11MB381964374223D0D2958AFA6985309@DM6PR11MB3819.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 6/15/21 1:08 AM, Wu, Hao wrote:
>> Subject: [PATCH v4 1/4] fpga: dfl: reorganize to subdir layout
>>
>> From: Tom Rix <trix@redhat.com>
>>
>> Follow drivers/net/ethernet/ which has control configs
>> NET_VENDOR_BLA that map to drivers/net/ethernet/bla
>> Since fpgas do not have many vendors, drop the 'VENDOR' and use
>> FPGA_BLA.
> Hi Tom,
>
> Thanks for this patch. : )
>
> DFL is not a vendor, but something can be shared/reused. It's possible that
> other vendors reuse the same concepts and the drivers of DFL. If vendor
> drivers need to be moved inside sub folders, then maybe it's better to
> leave DFL in the parent folder?

xrt is also not a vendor, more a subdevice framework like dfl.

I am not sure what you mean by other dfl vendors can you give an example ?

>> There are several new subdirs
>> altera/
>> dfl/
>> lattice/
>> xilinx/
>>
>> Each subdir has a Kconfig that has a new/reused
>>
>> if FPGA_BLA
>>    ... existing configs ...
>> endif FPGA_BLA
>>
>> Which is sourced into the main fpga/Kconfig
>>
>> Each subdir has a Makefile whose transversal is controlled in the
>> fpga/Makefile by
>>
>> obj-$(CONFIG_FPGA_BLA) += bla/
>>
>> This is the dfl/ subdir part.
>>
>> Create a dfl/ subdir
>> Move dfl-* files to it.
>> Add a Kconfig and Makefile
>>
>> Because FPGA_DFL is now used in dfl/Kconfig in a if/endif
>> block, all the other configs in dfl/Kconfig implicitly depend
>> on FPGA_DFL.  So the explicit dependence can be removed.  Also
>> since FPGA_DFL depends on HAS_IOMEM, it can be removed from the
>> other configs.
> Hm.. sounds like this change (remove HAS_IOMEM) is better to be split
> into another patch. How do you think?

I'll drop this from the patchset so this so patchset does the one thing 
of moving stuff around and do the HAS_IOMEM change after stuff settles.

Tom

>
> Thanks
> Hao
>


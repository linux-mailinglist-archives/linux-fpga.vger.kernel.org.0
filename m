Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC7663A1898
	for <lists+linux-fpga@lfdr.de>; Wed,  9 Jun 2021 17:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbhFIPKI (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 9 Jun 2021 11:10:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37929 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231629AbhFIPKH (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 9 Jun 2021 11:10:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623251291;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3petPtHlsPDryAINfA1PFiWj/Uqj+GdPUr7vulKPiao=;
        b=WR/kToSKEicrqKiFyJXyICVptuL4+QCJcLyMo4EKVSO2GoMNY8fTlAg6DwBDYIbAwrZjmX
        T+v2VoClby6XTuu6qQvHMyXtVDmBpWxUwTjcBaDx4wuEw9ytPqcf59y2q4pmR7oxTmLxyI
        h1WLVQ8CtpuSpKObHRu9/EP050xDB2M=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-5lIGEhZJOyOQzSstDIFL1A-1; Wed, 09 Jun 2021 11:08:10 -0400
X-MC-Unique: 5lIGEhZJOyOQzSstDIFL1A-1
Received: by mail-oo1-f69.google.com with SMTP id x24-20020a4a9b980000b0290249d5c08dd6so6284807ooj.15
        for <linux-fpga@vger.kernel.org>; Wed, 09 Jun 2021 08:08:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=3petPtHlsPDryAINfA1PFiWj/Uqj+GdPUr7vulKPiao=;
        b=Xu2PsbazHGj2OmKAZM7NXnBxhp33tiQ5NSM46Yc/A/sm+Zbm/juorYO7RlsPoySvdH
         wZEWe+bxP3ATF2Fa/yleqeSEWD1PlhxD2qGgfnemKgFCLnCO8CK0FLDFmQvrH9nnpoUp
         7JUoR/ByMpKJ9C5ALvAUQt/lf0KHy21C1I/l7jXxtjurc1ok5ylT/2hiVlsuj9U9OVaS
         2fDRkfJLSdNOb9ZALvSS9dPeV/f3s8VBLUnPcnwiSmYUyczPUxmcA2cO8fB2iMAkGG26
         A/kvS2RuIzkLB0E+zUuYi9MHAVV8bJTCgSG8nrvzll6jw37qvUJrNsx2iaJUp4Y0ooDg
         Aigg==
X-Gm-Message-State: AOAM533+/fPXQv403WS+w2u0G46O+1vIIVr4YLb97y+ZHU5GXRBq2AsJ
        hjmfWXnP5X+1JyoM1IIvnQubxhbDlpnbgCWyEVpOwzeYAJJGcwvq0iilbN2tX0y6ytTITYVXX0E
        06k7xwkwFVy7hhmUzjF0FLA==
X-Received: by 2002:a05:6808:9b2:: with SMTP id e18mr7077835oig.109.1623251289113;
        Wed, 09 Jun 2021 08:08:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwbHsFNlaNYpno/4x7efvptW6SQHPDd6WOjUIUALjKKBlIhJgxL+9Cv0ptzSOy7nphUSHVJvA==
X-Received: by 2002:a05:6808:9b2:: with SMTP id e18mr7077813oig.109.1623251288875;
        Wed, 09 Jun 2021 08:08:08 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id t21sm45440otd.35.2021.06.09.08.08.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 08:08:08 -0700 (PDT)
Subject: Re: [PATCH v2 0/4] fpga: reorganize to subdirs
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     mdf@kernel.org, hao.wu@intel.com, michal.simek@xilinx.com,
        nava.manne@xilinx.com, dinguyen@kernel.org,
        krzysztof.kozlowski@canonical.com, yilun.xu@intel.com,
        arnd@arndb.de, fpacheco@redhat.com, richard.gong@intel.com,
        luca@lucaceresoli.net, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20210609142208.3085451-1-trix@redhat.com>
 <YMDV7R52QUTFhpHH@kroah.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <2738ee7a-448f-c327-c430-13fb44da45ec@redhat.com>
Date:   Wed, 9 Jun 2021 08:08:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YMDV7R52QUTFhpHH@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 6/9/21 7:53 AM, Greg KH wrote:
> On Wed, Jun 09, 2021 at 07:22:03AM -0700, trix@redhat.com wrote:
>> From: Tom Rix <trix@redhat.com>
>>
>> The incoming xrt patchset has a toplevel subdir xrt/
>> The current fpga/ uses a single dir with filename prefixes to subdivide owners
>> For consistency, there should be only one way to organize the fpga/ dir.
>> Because the subdir model scales better, refactor to use it.
>> The discussion wrt xrt is here:
>> https://lore.kernel.org/linux-fpga/68e85a4f-4a10-1ff9-0443-aa565878c855@redhat.com/
>>
>> Follow drivers/net/ethernet/ which has control configs
>> NET_VENDOR_BLA that map to drivers/net/ethernet/bla
>> Since fpgas do not have many vendors, drop the 'VENDOR' and use
>> FPGA_BLA.
>>
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
>> Some cleanup to arrange thing alphabetically and make fpga/Makefile's
>> whitespace look more like net/'s
>>
>> Changes from
>> v1
>>    Drop renaming files
>>    Cleanup makefiles
> You can rename the files, you just can not rename the .ko objects
> without everyone knowing what you are doing and you trying to bury it in
> the middle of a differently described patch.
>
> If you want to do that, do you?  I don't really understand why you want
> to move things around right now other than "we have 40 files in one
> directory, ick!".

I am trying to resolve the layout inconsistency between what we have and 
what the xrt patchset does.

The big issue is the files vs dirs.

Over specified filenames is secondary, so I dropped them.

40 files in one dir is itself not a problem.

having 40 files and an xrt/ is.

fpga/ layout should be consistent so the Makefile and Kconfig are easier 
to maintain.

My preference is for subdir's.

Tom

>
> greg k-h
>


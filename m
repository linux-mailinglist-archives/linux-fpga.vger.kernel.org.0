Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 892AA3A69DD
	for <lists+linux-fpga@lfdr.de>; Mon, 14 Jun 2021 17:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233222AbhFNPSE (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 14 Jun 2021 11:18:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29644 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232958AbhFNPSE (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 14 Jun 2021 11:18:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623683761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tseWl+ar2j5bgA3GbFaHmCrYs1B8K7aJoZuY0R4FknU=;
        b=jRKTkPmebdaCTSWIHPH94/pSdNuJswldeCO0XwDD3fZRK68XByvvCjgpCWFQn34LNLo+9F
        DTCIFYBLCyh/T88fEq77tfC0YAFJodBJVh3uSin65tR34N1Jmh3W16tRKoe2k9uyT2v2Wh
        6XXbbal/U4rLOUub2KtHdJfomLR2zI4=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-s6GHPf4dMMeDdd8F4yoJhQ-1; Mon, 14 Jun 2021 11:15:59 -0400
X-MC-Unique: s6GHPf4dMMeDdd8F4yoJhQ-1
Received: by mail-oo1-f70.google.com with SMTP id v19-20020a4a31530000b029024944222912so7146093oog.1
        for <linux-fpga@vger.kernel.org>; Mon, 14 Jun 2021 08:15:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=tseWl+ar2j5bgA3GbFaHmCrYs1B8K7aJoZuY0R4FknU=;
        b=qg76NPlh9DnkL4Qp+e5VmjxOnP7azoipvxyVQnVTA7VOBD1yUrbo4mC3wtU99NBDPC
         weMd/r9UcUNzcW2P7M0PtIn4vwYZEu3bguclS+3G/1k9fTo9aotNGnatySWoQn+AVnuU
         qVIINZRNu9xjPEhcVaJ2kI4+s9bkw6W+1jcrglCstZfatRlBtd+0oDI/Lr6QS+Qfd4ZS
         9TtA7w3HGlrvVUin9iSOafkkYS/0Vp7c4gArYrUwA2JgkGIg/4ijBOOuEOVnpZ6X9mS2
         DXhqtlT/gC5yWcGYB7GjypBiaK716YwghZtlM+oRHIsnG+LSahVRUsR+7tTl6Z90J8z/
         ShMA==
X-Gm-Message-State: AOAM533GZSuvATRE9HeBPiTpl27Gq2ItfmP8yCGDFMdHi+rf7YP97P8Z
        3zrNFHwE+tvfL4fLEUPR852kaUkys0igEwU1nrmNcSkdLcsOU/4KIbpR1Q1es75vGGwcVS5cpsF
        EbXxSukSN3J55Z+7SLT6Cfw==
X-Received: by 2002:a9d:4d12:: with SMTP id n18mr14245632otf.128.1623683758961;
        Mon, 14 Jun 2021 08:15:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwcaCZ7HY5QTYsEFbkVzcsOtHFA2QLCLpRc2qiT/TOz9XlKqbbHHsOe3awXHQkzSxP0bJe4eQ==
X-Received: by 2002:a9d:4d12:: with SMTP id n18mr14245619otf.128.1623683758789;
        Mon, 14 Jun 2021 08:15:58 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id a24sm3365436otr.3.2021.06.14.08.15.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jun 2021 08:15:58 -0700 (PDT)
Subject: Re: [PATCH v3 1/4] fpga: dfl: reorganize to subdir layout
To:     Luca Ceresoli <luca@lucaceresoli.net>, mdf@kernel.org,
        hao.wu@intel.com, michal.simek@xilinx.com,
        gregkh@linuxfoundation.org, krzysztof.kozlowski@canonical.com,
        dinguyen@kernel.org, nava.manne@xilinx.com, yilun.xu@intel.com,
        davidgow@google.com, fpacheco@redhat.com, richard.gong@intel.com
Cc:     linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20210611162129.3203483-1-trix@redhat.com>
 <20210611162129.3203483-3-trix@redhat.com>
 <3e83dee8-4746-b22b-c032-1d73364f9cb7@lucaceresoli.net>
From:   Tom Rix <trix@redhat.com>
Message-ID: <c8ff863b-e904-3e39-f397-31efb0762a95@redhat.com>
Date:   Mon, 14 Jun 2021 08:15:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <3e83dee8-4746-b22b-c032-1d73364f9cb7@lucaceresoli.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 6/14/21 2:28 AM, Luca Ceresoli wrote:
> Hi Tom,
>
> On 11/06/21 18:21, trix@redhat.com wrote:
>> From: Tom Rix <trix@redhat.com>
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
>>
>> Signed-off-by: Tom Rix <trix@redhat.com>
>> ---
>>   MAINTAINERS                                 |  2 +-
>>   drivers/fpga/Kconfig                        | 80 +-------------------
>>   drivers/fpga/Makefile                       | 18 +----
>>   drivers/fpga/dfl/Kconfig                    | 83 +++++++++++++++++++++
>>   drivers/fpga/dfl/Makefile                   | 16 ++++
>>   drivers/fpga/{ => dfl}/dfl-afu-dma-region.c |  0
>>   drivers/fpga/{ => dfl}/dfl-afu-error.c      |  0
>>   drivers/fpga/{ => dfl}/dfl-afu-main.c       |  0
>>   drivers/fpga/{ => dfl}/dfl-afu-region.c     |  0
>>   drivers/fpga/{ => dfl}/dfl-afu.h            |  0
>>   drivers/fpga/{ => dfl}/dfl-fme-br.c         |  0
>>   drivers/fpga/{ => dfl}/dfl-fme-error.c      |  0
>>   drivers/fpga/{ => dfl}/dfl-fme-main.c       |  0
>>   drivers/fpga/{ => dfl}/dfl-fme-mgr.c        |  0
>>   drivers/fpga/{ => dfl}/dfl-fme-perf.c       |  0
>>   drivers/fpga/{ => dfl}/dfl-fme-pr.c         |  0
>>   drivers/fpga/{ => dfl}/dfl-fme-pr.h         |  0
>>   drivers/fpga/{ => dfl}/dfl-fme-region.c     |  0
>>   drivers/fpga/{ => dfl}/dfl-fme.h            |  0
>>   drivers/fpga/{ => dfl}/dfl-n3000-nios.c     |  0
>>   drivers/fpga/{ => dfl}/dfl-pci.c            |  0
>>   drivers/fpga/{ => dfl}/dfl.c                |  0
>>   drivers/fpga/{ => dfl}/dfl.h                |  0
>>   23 files changed, 102 insertions(+), 97 deletions(-)
>>   create mode 100644 drivers/fpga/dfl/Kconfig
>>   create mode 100644 drivers/fpga/dfl/Makefile
>>   rename drivers/fpga/{ => dfl}/dfl-afu-dma-region.c (100%)
>>   rename drivers/fpga/{ => dfl}/dfl-afu-error.c (100%)
>>   rename drivers/fpga/{ => dfl}/dfl-afu-main.c (100%)
>>   rename drivers/fpga/{ => dfl}/dfl-afu-region.c (100%)
>>   rename drivers/fpga/{ => dfl}/dfl-afu.h (100%)
>>   rename drivers/fpga/{ => dfl}/dfl-fme-br.c (100%)
>>   rename drivers/fpga/{ => dfl}/dfl-fme-error.c (100%)
>>   rename drivers/fpga/{ => dfl}/dfl-fme-main.c (100%)
>>   rename drivers/fpga/{ => dfl}/dfl-fme-mgr.c (100%)
>>   rename drivers/fpga/{ => dfl}/dfl-fme-perf.c (100%)
>>   rename drivers/fpga/{ => dfl}/dfl-fme-pr.c (100%)
> You should update Documentation/fpga/dfl.rst too as it mentions
> "drivers/fpga/dfl-fme-pr.c". This update was in your initial patch 5 so
> it's lost now, but it really should be in this patch.
>
>>   rename drivers/fpga/{ => dfl}/dfl-fme-pr.h (100%)
>>   rename drivers/fpga/{ => dfl}/dfl-fme-region.c (100%)
>>   rename drivers/fpga/{ => dfl}/dfl-fme.h (100%)
>>   rename drivers/fpga/{ => dfl}/dfl-n3000-nios.c (100%)
>>   rename drivers/fpga/{ => dfl}/dfl-pci.c (100%)
>>   rename drivers/fpga/{ => dfl}/dfl.c (100%)
> Same as above.

Yes to both, will be fixed in v4

Tom


>


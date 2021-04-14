Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6091E35FBAD
	for <lists+linux-fpga@lfdr.de>; Wed, 14 Apr 2021 21:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353405AbhDNTdr (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 14 Apr 2021 15:33:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35594 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353397AbhDNTdq (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 14 Apr 2021 15:33:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618428804;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p6QkSZ5sEebW/2lr/o8AURusvoopYRKQiuJ8Cl87Iw4=;
        b=Uc97KNYDu63gvcxkj1QoNGxyblDMNV1CHJQdGW9+ZLdfk0eJfIJ4d8mldtkvyCZQCm9mlh
        Dw+HG5CX2IXUDFs1kggkgtlNTVN8NP4tB0y6NHNIFJcwaBOsOyjtVc9812osL3KFad8laD
        jkZ+xMbCsYMMfWGkWY+yYG/GglJtdMs=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-514-rIx1GBYyN1-qNO-6P_fiBg-1; Wed, 14 Apr 2021 15:33:22 -0400
X-MC-Unique: rIx1GBYyN1-qNO-6P_fiBg-1
Received: by mail-qt1-f198.google.com with SMTP id l7-20020ac80c470000b029019ad46696f7so2597007qti.0
        for <linux-fpga@vger.kernel.org>; Wed, 14 Apr 2021 12:33:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=p6QkSZ5sEebW/2lr/o8AURusvoopYRKQiuJ8Cl87Iw4=;
        b=crnmOzOtRtJewzXXqaZ7UrMbs4N10QosBds8ParxY0vDbgCi1Lu9JJ/XmmQYFmmpoo
         rDaNNiVJr2pTC7wA9L4BYIAetW8TRU6UD1z0/HeaobDJ1ZZL6GkiI5WRoNMX6hdpfAHH
         GNm+NfsSFeBVqDpQpg6c+jo/SamdhK0GGDE2Ff8j01r5ObrcpSwumB/u0w7y4ShmAjOu
         R3Y0vblFWTrgg9AawobAUN+DhwOmTybd6nh8uAbtFNxTgPSbJhWDj2YoPj0zNes1CVpK
         gwB7yf2R25v/siV2UA2WxoYjAvxROPFjtVrSpIiQo6jagnpVJIVAlwYX5l4mouI5xozU
         wtCQ==
X-Gm-Message-State: AOAM531IUiSF1FmL43FoWpWX6WueC7vvmUdemvUItdhh5tDKnT8FFIGP
        wL4rSUT0WE+cPqzSfcuMYysLofWqbD/j7YclV1BCOyGYTGiwt3PeKlLjWcxm6AAspSMXyHL4Z6U
        JF2XQqHKUx8QOP/KZZfxqd+VP29nVXHU5xD6cvEKioHv7T70UqmJNEiKzoxUTaJQ2U2ki
X-Received: by 2002:a05:6214:204:: with SMTP id i4mr40693598qvt.47.1618428801093;
        Wed, 14 Apr 2021 12:33:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwrNuI0MQQKTGZyrhCr4aPHE6Cg8SbPRiQ1Uxz+Vmk7jiIk4Nf8OsYVF+R4jhTtUrQby9HzXg==
X-Received: by 2002:a05:6214:204:: with SMTP id i4mr40693571qvt.47.1618428800793;
        Wed, 14 Apr 2021 12:33:20 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id c27sm315917qko.71.2021.04.14.12.33.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Apr 2021 12:33:20 -0700 (PDT)
Subject: Re: Proposal of improvement for DMA - direct passing of hugepages to
 the SG list
To:     wzab@ise.pw.edu.pl, LKML <linux-kernel@vger.kernel.org>
Cc:     linux-fpga@vger.kernel.org
References: <6c7a1cff-3ad6-0a75-c45b-ce437ea156ef@elektron.elka.pw.edu.pl>
From:   Tom Rix <trix@redhat.com>
Message-ID: <f563241e-70ac-2f04-b85f-96b42e3a6fb1@redhat.com>
Date:   Wed, 14 Apr 2021 12:33:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <6c7a1cff-3ad6-0a75-c45b-ce437ea156ef@elektron.elka.pw.edu.pl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 4/14/21 4:58 AM, wzab@ise.pw.edu.pl wrote:
> Hi,
>
> I'm working both on DMA engines implementations in FPGA and their 
> Linux drivers.
> Now I need to create an engine that takes the hugepages-backed buffer 
> allocated
> by the user-space application and passes it to the device.
> My current solution:
>
> https://forums.xilinx.com/t5/Embedded-Linux/How-to-pass-efficiently-the-hugepages-backed-buffer-to-the-BM/m-p/1229340/highlight/true#M49777 
>
> or https://stackoverflow.com/a/67065962/1735409
>
> uses the get_user_pages_fast function, to create the kernel mapping,
> and then uses sg_alloc_table_from_pages to build sg_table for it.
>
> I have verified that the created sg_table has one entry for each 
> individual
> hugepage (so I can efficiently map it for my SG-capable DMA device).
>
> The disadvantage of that solution is that I need to create and keep a 
> huge set
> of standard-size pages. Because the "struct page" occupies between 56 
> and 80
> bytes, I get the overhead up to 80/4096 which is approx. 2%.
>
> The open question is if I can free those pages as soon as the sg_table
> is created? (As far as I know, the hugepages are locked automatically).
> Of course it is unclear what happens if the application crashes and 
> its mmaped
> hugepage-based buffer gets freed. Will the driver be notified about 
> closing the
> file so that it can disable DMA before that memory can be taken for other
> purposes?
>
> To be sure that it doesn't happen maybe it is good to keep those pages 
> locked
> in the kernel as well.
> The big improvement would be if we could have the get_user_hugepages_fast
> function. The user should be allowed to create a smaller number of 
> page structs.
> The function should check if the requested region really consists of 
> hugepages
> and return an error if it doesn't.
>
> Another important fact is that we don't need a kernel mapping for 
> those pages
> at all. So it would be good to have yet another function:
> sg_alloc_table_from_user_pages
> which should take an additional "flag" argument enabling the user to 
> decide
> if the area used consists of normal pages or of hugepages.
>
> The function should return an error in  case if the flag does not 
> match the
> properties of the region. Of course the function should also lock the 
> pages,
> and sg_free_table should unlock them (protecting against the danger
> of application crash, that I described above).
>
> As a temporary workaround, is it possible to "manually" walk the pages
> creating the application-delivered buffer, verify that they are 
> hugepages,
> lock them and create the sg_table?
> What functions/macros should be used for that to ensure that the 
> implemented
> solution be portable and keeps working in a reasonable number of 
> future versions
> of the Linux kernel?
>
> I'll appreciate comments, suggestions and considering of the above 
> proposal.
> With best regards,
> Wojtek
>
Do you have trial patch you could RFC ?

Are you aware of the xilinx qdma patchset ?

https://www.xilinx.com/support/answers/71453.html

https://github.com/Xilinx/dma_ip_drivers

Maybe its kernel or dpdk driver has what you need.

Tom




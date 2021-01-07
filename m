Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9522ED4F6
	for <lists+linux-fpga@lfdr.de>; Thu,  7 Jan 2021 18:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbhAGRCn (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 7 Jan 2021 12:02:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32910 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726326AbhAGRCg (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 7 Jan 2021 12:02:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610038870;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tYC79LNk2nzU1Q3GB47wy9Gu7cJ3IMZGWrzODwHrOJw=;
        b=FqXECTG5A6gri8+PGIzC/elVBefzx+3dzSJ0V5KHHCH9ao/NofS0eoR793bG8XuhXsajja
        vv5zqaamPCSO2KAPNfnKRQLXoFyyL4tvn5mX/PKjRnUdbfEzpqVrgThnX9OFd5GvWWx5ve
        2g0Q18Ta8Gd/vRJV92lIrZCfN+v6uHI=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-586-aDYXMQFbOHKl_2Nuxxyh0g-1; Thu, 07 Jan 2021 12:01:08 -0500
X-MC-Unique: aDYXMQFbOHKl_2Nuxxyh0g-1
Received: by mail-pg1-f199.google.com with SMTP id z20so5174979pgh.18
        for <linux-fpga@vger.kernel.org>; Thu, 07 Jan 2021 09:01:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=tYC79LNk2nzU1Q3GB47wy9Gu7cJ3IMZGWrzODwHrOJw=;
        b=Nb/qLR/eEHEEL4gpARwLRkmE69KS2j81SHGBmXp16egHL06Am5mmSwJvFbtmPyNx9c
         AJjUDguhcCWylAObJEExBegfq/JHD72CNE4Do+r9pVxJaQkqTYqc5JerehDVZPuHFNhD
         JiVnUxe4OWdS9Bb+JumU77GdLsmw5SdPBYkKb8GI3ikBrCGw9U77Uzu+bb9iQ7DLNEHj
         SHE6I3FYYFhnOd9BKHbxuBV7kEAHN7cLx4DXdIJ90/ZGIV7qZlkqm6ihwlIWXSd3IJVa
         HNgjKIgNmuULyyR8LZLqQmKLOaW+QHywc5Y2HZ9glQWlvro74hdLrdDBGx/3M1Epu/Xt
         a+yQ==
X-Gm-Message-State: AOAM533XVfOpPc92gWoD/24EqDWQAhKqOni2GDMuN4UxyXWKLdovyweV
        2ZBUibFnMJ5t9ivj4bdGfm5+nlLQ5cRjEPh3GitXnV3mhKgx5KmJ602cCBdcbSb79KmGhbJY/IO
        LCDqeMUkk3o5bs1RvzNiI9g==
X-Received: by 2002:a17:902:fe87:b029:da:5d3b:4a84 with SMTP id x7-20020a170902fe87b02900da5d3b4a84mr9876756plm.51.1610038867252;
        Thu, 07 Jan 2021 09:01:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJysL4EldspCf6rNFwrd0bAyeFEK4JxLwg2+MTt3NtFgM2enXGtOwOvfdPwi2PbRwBbnrn5iAQ==
X-Received: by 2002:a17:902:fe87:b029:da:5d3b:4a84 with SMTP id x7-20020a170902fe87b02900da5d3b4a84mr9876736plm.51.1610038867052;
        Thu, 07 Jan 2021 09:01:07 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id b18sm6517233pfi.173.2021.01.07.09.01.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jan 2021 09:01:06 -0800 (PST)
Subject: Re: [PATCH 0/8] FPGA DFL Changes for 5.12
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, moritzf@google.com
References: <20210107043714.991646-1-mdf@kernel.org>
 <80b29715-aa0a-b2ac-03af-904fc8f8be98@redhat.com>
 <X/czarr9bXr849p5@kroah.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <51e3350c-00d3-b2fe-cdc5-be64b661c224@redhat.com>
Date:   Thu, 7 Jan 2021 09:01:05 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <X/czarr9bXr849p5@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 1/7/21 8:14 AM, Greg KH wrote:
> On Thu, Jan 07, 2021 at 08:09:12AM -0800, Tom Rix wrote:
>> On 1/6/21 8:37 PM, Moritz Fischer wrote:
>>> This is a resend of the previous (unfortunately late) patchset of
>>> changes for FPGA DFL.
>> Is there something I can do to help ?
> This is all now merged in my tree, so there's not much left to do here
> :)

Yes this patchset is done now.

I am offering to help in an ongoing manner, something like 10hr/week would be easy as i already spend about 30hr/week doing stuff in the kernel in addition to reviewing linux-fpga.

Tom

> thanks,
>
> greg k-h
>


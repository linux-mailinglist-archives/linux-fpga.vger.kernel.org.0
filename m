Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C75D44C130
	for <lists+linux-fpga@lfdr.de>; Wed, 10 Nov 2021 13:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbhKJMak (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 10 Nov 2021 07:30:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23712 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231342AbhKJMaj (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 10 Nov 2021 07:30:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636547272;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dYLRQH0TP4O3xvYZerqmbmFmpTBL4DQnhLEPVVOshr8=;
        b=AqVB99/iMJu2n7jBcTdWkyVM8lwnzwUsE6rw+t8/AiDS6PosZD/5NeEMFiOQf8RwWn1MKl
        Phkii+xytNIb/0Q5fBXs7sSFwrovgzjYij80VURc/+rbZTvK874QGTb1kFKvE4KTtXlR8A
        H6UsnlVzplM/32LUaGr2wdAGSD7874k=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-hwee-9B_NDq56_7mjFgd4w-1; Wed, 10 Nov 2021 07:27:48 -0500
X-MC-Unique: hwee-9B_NDq56_7mjFgd4w-1
Received: by mail-oi1-f200.google.com with SMTP id y21-20020aca4b15000000b002a819a3cd6dso1465842oia.15
        for <linux-fpga@vger.kernel.org>; Wed, 10 Nov 2021 04:27:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=dYLRQH0TP4O3xvYZerqmbmFmpTBL4DQnhLEPVVOshr8=;
        b=2aFIDOJXUKY6WeRx8NDfjpztcpu1tJ5jEkqebLsb4qT+GmQLLFh//BUr3dKFnbPzqO
         zzkvGyvVyReGm6/Ok0GHWKiEcmk5P2MZVN8DETX6r9uyBuD37+a9Fd+XEICQjgZBqZty
         mc3inx18sDdSbJMra8QHpymqZ3f4F7IeW1jFrLf0JFAR+u+40lQoKkeRjXftGQdPujWC
         eBfiWFnpIaRMj7GustvYKNUD75QyrUvfd1p2ZwTcxELbQeBy0sIVsB1gpj4DRXvnS5fk
         zAueK3OKPRoG4EiNqRUJNh9TnoWo4W3EIgA3fBxRuFAMuUThwwCI0EoD6rWw37Ny4KQS
         y2rw==
X-Gm-Message-State: AOAM533JQzkRRnze6uQ2jORBLh4mChVWho9Z2VnfbAi+z4nv4uGiz9gy
        F/NxUQcx0VGq2mFCFS6KY7wJPoR97cT5CDEOfncGwlHwPR4OxjLU6uKOLiDJB69WD6lG4cs/qyH
        TIpCuUC09lIGLcByFVa54vg==
X-Received: by 2002:a05:6830:25c6:: with SMTP id d6mr12545946otu.240.1636547268275;
        Wed, 10 Nov 2021 04:27:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxnXhWz6Tm1aQTYJ1ZH0K0WyVfJMRvn68Fsd1Y8zL14GrIvur82vWO2ukeKeUAu5n+umO8QFA==
X-Received: by 2002:a05:6830:25c6:: with SMTP id d6mr12545936otu.240.1636547268109;
        Wed, 10 Nov 2021 04:27:48 -0800 (PST)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id l7sm7389756oog.22.2021.11.10.04.27.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Nov 2021 04:27:47 -0800 (PST)
Subject: Re: [PATCH v1 1/1] fpga: dfl: pci: Use pci_find_vsec_capability()
 when looking for DFL
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Moritz Fischer <mdf@kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>
References: <20211109154127.18455-1-andriy.shevchenko@linux.intel.com>
 <8ccc133a-fb47-4548-fee3-d57775a5166d@redhat.com>
 <YYq4fSRoyzFE4Vei@smile.fi.intel.com>
 <39ac1f40-66ab-6c7e-0042-8fcdc062ed00@redhat.com>
 <YYuBz0tdduAk1c/6@smile.fi.intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <3106bd57-9144-6a4d-8ad9-3ebf804018ab@redhat.com>
Date:   Wed, 10 Nov 2021 04:27:45 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YYuBz0tdduAk1c/6@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 11/10/21 12:24 AM, Andy Shevchenko wrote:
> On Tue, Nov 09, 2021 at 10:27:58AM -0800, Tom Rix wrote:
>> On 11/9/21 10:05 AM, Andy Shevchenko wrote:
>>> On Tue, Nov 09, 2021 at 07:55:43AM -0800, Tom Rix wrote:
>>>> On 11/9/21 7:41 AM, Andy Shevchenko wrote:
> ...
>
>>>>> +	voff = pci_find_vsec_capability(dev, PCI_VENDOR_ID_INTEL, PCI_VSEC_ID_INTEL_DFLS);
>>>> This may be a weakness in the origin code, but intel isn't the exclusive
>>>> user of DFL.
>>> This does not change the original code. If you think so, this can be extended
>>> later on.
>> I would rather see this fixed now or explained why this isn't a problem.
> This is out of scope of this change in a few ways:
>   - we don't do 2+ things in one patch
>   - the change doesn't change behaviour
>   - the change is a simple cleanup
>   - another vendor may well have quite different VSEC ID for DFL
>
> If you think that it should be needed, one can come up with it later on.

Fixing a problem is more useful than a cleanup. The fix should come first.

Tom

>


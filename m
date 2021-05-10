Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5715737972E
	for <lists+linux-fpga@lfdr.de>; Mon, 10 May 2021 20:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbhEJSxc (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 10 May 2021 14:53:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41063 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232501AbhEJSxc (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 10 May 2021 14:53:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620672746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g7j+izsokRqpT308sJPWfxVQOB87GOP9BtFazVppLoQ=;
        b=NZSM4MJzbaPvIyeoahISgjDMXx3Pc+5gJ+iCpSkpY+by9bJ7UPTDy/Xtz/+igPyitlu9CA
        qTwkQHbF6Vm1qhZPMi4CDn6IS4mAFKhjgjBDfeyZOexUo+54HGsw9ZO5SXBerIYW5A/FVp
        xIGV7nBVvalAsKGmwq99rtPRfr/NPNU=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-564-s9abtl1FOS2VTL0yN1BtJg-1; Mon, 10 May 2021 14:52:18 -0400
X-MC-Unique: s9abtl1FOS2VTL0yN1BtJg-1
Received: by mail-qk1-f200.google.com with SMTP id h190-20020a3785c70000b02902e022511825so12359789qkd.7
        for <linux-fpga@vger.kernel.org>; Mon, 10 May 2021 11:52:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=g7j+izsokRqpT308sJPWfxVQOB87GOP9BtFazVppLoQ=;
        b=ikOUq9EZKMaKjGj99HwX9nt+5/p36kEjVmAnDBOpFEHwkmo1PJYbcnzOJum4QFlj1f
         +YanEfaHO3vadGmzj2UaQfCkflLYsY+EZkXRrmqphTmmURy2mp0qHicUG5IxUjWIOkfs
         G5tuRGypXts1E9OTHOWPDdZkTB5ouMVWZsACdwys0Juyw7lsDMZArmDrTP8KVhJsaNm/
         8qnndcoSProMzwheWzjXt5JidMcQqqD/2XSEks+bE2LHr7BCLW+4mns6niLvz5EviUHU
         QQUtY3Aezlt5PGuH2Lj2JCW0xN1W0TyAF6nU4k/wavUuQQz5Vjjk+dEVZTWrUykbD5rY
         nR+A==
X-Gm-Message-State: AOAM532DesogHsCV+r2dsb38VyQYelZ+V7VQfYYCEEugI6UliR1b2P+L
        jTAirMJk7rt/IVwRxCcpv+kvzV+OtmFldlQyoHrsMYO3BzGtNo3YScHpLfxZHqMr8+//1Mv4s+l
        WvPxVXJsikdz6gCXxfqTrqQ==
X-Received: by 2002:a05:620a:2912:: with SMTP id m18mr24874749qkp.475.1620672737973;
        Mon, 10 May 2021 11:52:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzslxJCI13N/HGEQf/0CdbPdBfh/ACVbIw9n9wIQ9PcwW2U4mKsFsbmO04LbWfLWQIMFWZd5A==
X-Received: by 2002:a05:620a:2912:: with SMTP id m18mr24874733qkp.475.1620672737751;
        Mon, 10 May 2021 11:52:17 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id u9sm12338360qtf.76.2021.05.10.11.52.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 May 2021 11:52:17 -0700 (PDT)
Subject: Re: [PATCH v12 0/7] FPGA Security Manager Class Driver
To:     Moritz Fischer <mdf@kernel.org>
Cc:     Russ Weight <russell.h.weight@intel.com>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        lgoncalv@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@intel.com, richard.gong@intel.com
References: <20210503213546.316439-1-russell.h.weight@intel.com>
 <6f3ce0db-883e-2c5b-e671-9ccc363ee532@redhat.com>
 <YJlvYNXUcwrBFGey@epycbox.lan>
From:   Tom Rix <trix@redhat.com>
Message-ID: <91d29fc4-ac04-270a-f73a-e1dd3ba2965f@redhat.com>
Date:   Mon, 10 May 2021 11:52:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YJlvYNXUcwrBFGey@epycbox.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 5/10/21 10:37 AM, Moritz Fischer wrote:
> On Mon, May 10, 2021 at 07:12:57AM -0700, Tom Rix wrote:
>> On 5/3/21 2:35 PM, Russ Weight wrote:
>>> The FPGA Security Manager class driver provides a common
>>> API for user-space tools to manage updates for secure FPGA
>>> devices. Device drivers that instantiate the FPGA Security
>>> Manager class driver will interact with a HW secure update
>>> engine in order to transfer new FPGA and BMC images to FLASH so
>>> that they will be automatically loaded when the FPGA card reboots.
>> Russ,
>>
>> These have my Reviewed-by, but since it has been a while, I am looking these
>> over again.
>>
>> If you do not hear anything from me in the next couple of days, please
>> assume everything is fine.
>>
>> Tom
>>
> I'll do one more one-over, if it looks good will apply end of the week,

FWIW, my pass was fine.

Thanks,

Tom

>
> - Moritz
>


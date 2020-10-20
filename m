Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EAD7293E61
	for <lists+linux-fpga@lfdr.de>; Tue, 20 Oct 2020 16:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407841AbgJTONj (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 20 Oct 2020 10:13:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23180 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2407899AbgJTONj (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 20 Oct 2020 10:13:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603203217;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R16EbEDXYLBuqh4nIdDbRp7O0oRY2wnv3lXnFRIbqKI=;
        b=Ots5fy+CJCt43kVpUQTBi2K4t3Y3aqDQKO3igVQxzjNBE254fXr7+3FLm3yEEPw4/hyRuD
        6tNhlZl5svGN7//QeHfzJFUYIJ7ejL9l9QpaK4Qj0y9A7/4+T5Dn15fMIyJzZt9PsCm2Yz
        wqre3cQuqnLV14nUeQEsFigUeRh59CE=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-Vl7iyXigPKGOLzNAmUxZ3A-1; Tue, 20 Oct 2020 10:13:35 -0400
X-MC-Unique: Vl7iyXigPKGOLzNAmUxZ3A-1
Received: by mail-qv1-f72.google.com with SMTP id k6so1447938qvg.9
        for <linux-fpga@vger.kernel.org>; Tue, 20 Oct 2020 07:13:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=R16EbEDXYLBuqh4nIdDbRp7O0oRY2wnv3lXnFRIbqKI=;
        b=n6iNwvfDFL1WZ+drfOBZw5bmI0bNgYdcJ9m1FNGS9abXomcIaniO3EhfsKJXUCSznc
         Kgym/bQNMxJpEXd0HJhcGn3k9x/ZaacIAUUJnscPpdE1T9JUfc8Hi1UOsNVT0NIYEgKS
         Q/ksthPxAz+VE5sGkj/V40iBJK0gCtX++2vglBOzKKdVHVlD4kTs5cZm7o3Ncn/FVfIt
         lkYy9xDIXPKjwg0YR5N8K7Hb17ZuSL6RWBQ2QCBTxdXI1TV/YRysDUGNZgZzr2MKbIb/
         9bkzj8wpHylLW+k9TF2y10EnNChP8wSj55JtqZWB2RDk2zMsghWAq1SOWr+ZYVdzMh/F
         MEbA==
X-Gm-Message-State: AOAM532T7WGWJYYpriBuwFGjaI3oz4pQ/q+ITHMaUO8GC+byKOlnj/32
        +2TQ199iBON5ntqAJXyV6dVgjrPEgovigk4cS5mOfx/wmID9e03mqFL3mKmYXJOK8gcOVhjltM6
        89hzP2OqVCH5f2mMzSrK9Rg==
X-Received: by 2002:a37:4244:: with SMTP id p65mr994618qka.141.1603203214566;
        Tue, 20 Oct 2020 07:13:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz+u0NYgPuykSbBGly8cM+QOe6I8vZ8CSK1Vl+thq2i8Y9RMNBefXkQTQxBeCh/pM8txDvIng==
X-Received: by 2002:a37:4244:: with SMTP id p65mr994602qka.141.1603203214330;
        Tue, 20 Oct 2020 07:13:34 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id e19sm806862qkl.94.2020.10.20.07.13.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2020 07:13:33 -0700 (PDT)
Subject: Re: [PATCH 1/2] fpga: dfl: add driver_override support
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        lgoncalv@redhat.com, hao.wu@intel.com
References: <1602828151-24784-1-git-send-email-yilun.xu@intel.com>
 <1602828151-24784-2-git-send-email-yilun.xu@intel.com>
 <63d7730b-d9b8-c75d-16f6-3ebb507aabaa@redhat.com>
 <20201019040612.GA16172@yilunxu-OptiPlex-7050>
 <f767b9a0-1db8-7ced-6bd9-5ee1f58d40da@redhat.com>
 <20201020071158.GC28746@yilunxu-OptiPlex-7050>
From:   Tom Rix <trix@redhat.com>
Message-ID: <48cc1b5f-4bb1-260d-7b8b-9484d3f0a6ba@redhat.com>
Date:   Tue, 20 Oct 2020 07:13:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201020071158.GC28746@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 10/20/20 12:11 AM, Xu Yilun wrote:
>>>>>  int __dfl_driver_register(struct dfl_driver *dfl_drv, struct module *owner)
>>>>>  {
>>>>> -	if (!dfl_drv || !dfl_drv->probe || !dfl_drv->id_table)
>>>>> +	if (!dfl_drv || !dfl_drv->probe)
>>>> id_table is still needed for the normal case.
>>>>
>>>> Instead of removing this check, could you add something like
>>>>
>>>> || (!dfl_drv->is_override && !dfl_drv->id_table)
>>> I don't think it is needed. Seems is_override and !id_table are duplicated
>>> conditions for this implementation. And it may make confusing, e.g. could
>>> a driver been force matched when is_override is not set?
>>>
>>> I think we could make it simple, if the dfl driver didn't provide the
>>> id_table, normally it could not match any device. I think it could be
>>> easily understood by dfl driver developers.
>>>
>> Then an ASSERT should be added in dfl_bus_match() for id_entry.
> I didn't get your idea. What Assertion should be added for id_entry?
> BUG_ON(id_entry == NULL)? Then dfl-uio-pdev can't be inserted before
> driver_override is set.
>
> I think it is normal case that a driver is successfully registered but
> doesn't match any device because it provides no id_table.

Ok, i see your point.

Thanks for the explanation.

Tom


>
> Thanks,
> Yilun.
>


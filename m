Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF773B3186
	for <lists+linux-fpga@lfdr.de>; Thu, 24 Jun 2021 16:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbhFXOji (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 24 Jun 2021 10:39:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41404 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230170AbhFXOjh (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 24 Jun 2021 10:39:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624545438;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9h8u0xPq+lyz4kG2IM71OZjooGkjqLutHSguaAe0NLE=;
        b=L/EnulhFts90OqL3t75ZoF/oByYLU7TJVLJIA6Amny2EhIQt105gheCFMCNDB+L43H9v7A
        lwNR4b9yygOrUbwaMuajG19U5OScBYQAJug3eTb4qeDOVEA9UW7DvbRWdubXjVf7iJVyvN
        wsOge5XlCjEmhcZOD9j/D1eZq9ayk44=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-534-thb3oLIDM0yYcQ9dZFCXPA-1; Thu, 24 Jun 2021 10:37:16 -0400
X-MC-Unique: thb3oLIDM0yYcQ9dZFCXPA-1
Received: by mail-oi1-f197.google.com with SMTP id q31-20020a056808201fb02902242061b668so3910710oiw.8
        for <linux-fpga@vger.kernel.org>; Thu, 24 Jun 2021 07:37:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=9h8u0xPq+lyz4kG2IM71OZjooGkjqLutHSguaAe0NLE=;
        b=lE2SeJq8q5WMvf9bxpB9IBIlqejBvbzTexC99gmBDxnDH1D+acNrFwt5GlxmRpdKpo
         +BQ5kJuLPaL6k5kMZiqXkscj65uiHUAX+PgSX4lE2L9Sz3ltNotxqfI78X434La7fDj9
         k9ul3+aSnQBdulVj++EeCXaL8s4Xf8ZH6xBwZ+G195XjDeipENQVr5eY0OxxJ9Nf0WhX
         fadON2ePBGTpsTskxCTE8G8Y6dVeSw8/FHcsQ0dsnlV8tP6mFkPBkaWv5dv5o8c7ilLC
         rcv2mHX9fJzsWpC2VNTXUeqfeLVZoxw8ICJIZ0GQK5YhVDSe9ZgWDNHWw15nTy5dR5VC
         ZoIA==
X-Gm-Message-State: AOAM5316mX4fgXcTnAokh7UnNz8vkv68Qc6JKaPkmjNQe/rgq2yWYEQn
        nZYGA2283vkwQm2XV+v0q7eQvxVPEVS5qzydctFZ6ONOUACYNChOiOeJbL2TDl04sYLoEN0+87G
        JxiQeUNm3r2w9gBlOSGzZtg==
X-Received: by 2002:a05:6808:60e:: with SMTP id y14mr7361121oih.105.1624545436102;
        Thu, 24 Jun 2021 07:37:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzw2Crh/+XLQyWazz2/WmdZ58gp6OxY8shHXD3gklt/l5Xl579uOibcqZlSSEOhwX2KHZdxAg==
X-Received: by 2002:a05:6808:60e:: with SMTP id y14mr7361113oih.105.1624545435916;
        Thu, 24 Jun 2021 07:37:15 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 2sm692895ota.58.2021.06.24.07.37.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jun 2021 07:37:15 -0700 (PDT)
Subject: Re: [PATCH v3 1/7] fpga-mgr: wrap the write_init() op
To:     Xu Yilun <yilun.xu@intel.com>,
        Russ Weight <russell.h.weight@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     hao.wu@intel.com, mdf@kernel.org, michal.simek@xilinx.com,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20210623182410.3787784-1-trix@redhat.com>
 <20210623182410.3787784-3-trix@redhat.com>
 <20210624075414.GA44700@yilunxu-OptiPlex-7050>
From:   Tom Rix <trix@redhat.com>
Message-ID: <02bd1acf-6b8d-7ca1-6a9c-c3f6d3a2071c@redhat.com>
Date:   Thu, 24 Jun 2021 07:37:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210624075414.GA44700@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 6/24/21 12:54 AM, Xu Yilun wrote:
> On Wed, Jun 23, 2021 at 11:24:04AM -0700, trix@redhat.com wrote:
>> From: Tom Rix <trix@redhat.com>
>>
>> An FPGA manager should not be required to provide a
>> write_init() op if there is nothing for it do.
>> So add a wrapper and move the op checking.
>> Default to success.
>>
>> Signed-off-by: Tom Rix <trix@redhat.com>
>> ---
>>   drivers/fpga/fpga-mgr.c | 14 +++++++++++---
>>   1 file changed, 11 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
>> index ecb4c3c795fa5..87bbb940c9504 100644
>> --- a/drivers/fpga/fpga-mgr.c
>> +++ b/drivers/fpga/fpga-mgr.c
>> @@ -69,6 +69,14 @@ void fpga_image_info_free(struct fpga_image_info *info)
>>   }
>>   EXPORT_SYMBOL_GPL(fpga_image_info_free);
>>   
>> +static int fpga_mgr_write_init(struct fpga_manager *mgr,
>> +			       struct fpga_image_info *info,
>> +			       const char *buf, size_t count)
>> +{
>> +	if (mgr->mops && mgr->mops->write_init)
> Maybe we don't have to check mgr->mops, it is already checked on
> creation.

The check was on purpose because my earlier patchset responding to 
problems with sec-mgr.

Focusing on Greg's comment that why can't sec-mgr be done with existing 
code,

I think the sec-mgr can be folded into the exiting fpga-mgr via a new 
set of ops.

the 'generalize fpga_mgr_load' patchset set has two sets of ops,

one for existing partial reconfiguration

and one for reimaging the whole board, what the sec-mgr is doing.

Since dfl has the only instance of need, it would have the only reimage ops.

The check at creation has been deferred to at use.

other targets could have null ops.

Having maybe null ops means the wrappers need to check.

Here is a ref to the earlier patchset

https://lore.kernel.org/linux-fpga/20210524162721.2220782-1-trix@redhat.com/

I'll respin 'generalize fpga_mgr_load' within the context this patchset 
to give you some more context.

It will test is the check is needed and give folks a chance to comment 
if this a way sec-mgr should go.

Tom


>
> The same concern to all the following patches.
>
> Thanks,
> Yilun
>
>> +		return  mgr->mops->write_init(mgr, info, buf, count);
>> +	return 0;
>> +}
>>   /*
>>    * Call the low level driver's write_init function.  This will do the
>>    * device-specific things to get the FPGA into the state where it is ready to
>> @@ -83,9 +91,9 @@ static int fpga_mgr_write_init_buf(struct fpga_manager *mgr,
>>   
>>   	mgr->state = FPGA_MGR_STATE_WRITE_INIT;
>>   	if (!mgr->mops->initial_header_size)
>> -		ret = mgr->mops->write_init(mgr, info, NULL, 0);
>> +		ret = fpga_mgr_write_init(mgr, info, NULL, 0);
>>   	else
>> -		ret = mgr->mops->write_init(
>> +		ret = fpga_mgr_write_init(
>>   		    mgr, info, buf, min(mgr->mops->initial_header_size, count));
>>   
>>   	if (ret) {
>> @@ -569,7 +577,7 @@ struct fpga_manager *fpga_mgr_create(struct device *parent, const char *name,
>>   	int id, ret;
>>   
>>   	if (!mops || !mops->write_complete || !mops->state ||
>> -	    !mops->write_init || (!mops->write && !mops->write_sg) ||
>> +	    (!mops->write && !mops->write_sg) ||
>>   	    (mops->write && mops->write_sg)) {
>>   		dev_err(parent, "Attempt to register without fpga_manager_ops\n");
>>   		return NULL;
>> -- 
>> 2.26.3


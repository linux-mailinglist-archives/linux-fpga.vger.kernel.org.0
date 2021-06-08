Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C38139F832
	for <lists+linux-fpga@lfdr.de>; Tue,  8 Jun 2021 15:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233075AbhFHN5q (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 8 Jun 2021 09:57:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59734 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232341AbhFHN5p (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 8 Jun 2021 09:57:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623160552;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pqyA9BJti9sC0WTScn33LjmDjTwa9gvCflfpKLm9Avo=;
        b=FAS7rgqWcPD0FaIp8BKGBU6ikVzI7SH+HveF95ZY3zchFWt8H6CPyq7jF09p5ViBebSnlG
        Lree9UjNdwS7RJSbCupr5tIYs/twfozATbXKiJz34q1iU948MMgOPF2Vt04nA+2cs6OLXJ
        DyWtIsxR0Aoy9MTuP8oKtYfiLYrvXRc=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-m2XTwbbfMUCXV1Y-NtjBrg-1; Tue, 08 Jun 2021 09:55:51 -0400
X-MC-Unique: m2XTwbbfMUCXV1Y-NtjBrg-1
Received: by mail-ot1-f69.google.com with SMTP id o26-20020a9d6d1a0000b02903e61e3de711so6444599otp.12
        for <linux-fpga@vger.kernel.org>; Tue, 08 Jun 2021 06:55:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=pqyA9BJti9sC0WTScn33LjmDjTwa9gvCflfpKLm9Avo=;
        b=RfXB1xnxcNsEFZo2RTrOCAsnQo8b5/DIWxdmBLUfmFhIaEklj5fj2TseWofVEyP7oD
         j9M8pVqOYvTq5Qjn7Hmi0l6pdpfSAfZZ+eaR5BIzHBH2qLLd/Ff+ZrwhPZiFYJ77N6sc
         LyfmonUEewF7DwxElZ7V8Q+zedQW5ifTNloESua4fNjGV6aUbQBWqadlgjskbN4oPEW/
         qIlORmcoNLk9q0ovgS6Rz2YSJhqcYa6tSu0rVKqVNExTf7K7rKbHZery9w0bHk3tLjO+
         8+tT9fJqJWAd+z/vjosgpf1f7QKtJfrNxrrXov3TBmjQ7stNlbnyYdynj4vXAJk1Gp9V
         6+1A==
X-Gm-Message-State: AOAM532yJ0s0GJDoRUrn6yTif6C8bw+AGcQxj1wwb+wbkRPzgjTSgOVP
        8+rsqodgKVlAXsA3wwVGDt0U/OciiN0I0rNhX7WSrNxqgI7kJfAnc7Lvj1Ote5T9zZ9NqoQBZKp
        kkB3ZHz8SpIXvwt3YscvNJQ==
X-Received: by 2002:a9d:2222:: with SMTP id o31mr3811716ota.75.1623160549903;
        Tue, 08 Jun 2021 06:55:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzEAySIQOYInGX/sY8rboJULzWUyayMRQC0dxIkUMsMOch3zVDlIIZUzOmsskrELB/Z11eXdg==
X-Received: by 2002:a9d:2222:: with SMTP id o31mr3811673ota.75.1623160549362;
        Tue, 08 Jun 2021 06:55:49 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id q22sm3003373otl.11.2021.06.08.06.55.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jun 2021 06:55:48 -0700 (PDT)
Subject: Re: [PATCH 1/7] fpga: wrap the write_init() op
To:     Moritz Fischer <mdf@kernel.org>
Cc:     hao.wu@intel.com, michal.simek@xilinx.com,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20210607172402.2938697-1-trix@redhat.com>
 <20210607172402.2938697-2-trix@redhat.com> <YL6fUSD0KLP0l80g@epycbox.lan>
From:   Tom Rix <trix@redhat.com>
Message-ID: <17c1b4b5-0dfa-03f6-149d-eaa09da9089b@redhat.com>
Date:   Tue, 8 Jun 2021 06:55:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YL6fUSD0KLP0l80g@epycbox.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 6/7/21 3:36 PM, Moritz Fischer wrote:
> On Mon, Jun 07, 2021 at 10:23:56AM -0700, trix@redhat.com wrote:
>> From: Tom Rix <trix@redhat.com>
>>
>> The board should not be required to provide a
> Nit: Can you turn these into for whole series:
> A FPGA Manager should not be ...

ok

>
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
>> index b85bc47c91a9..24547e36a56d 100644
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
>> @@ -569,7 +577,7 @@ struct fpga_manager *fpga_mgr_create(struct device *dev, const char *name,
>>   	int id, ret;
>>   
>>   	if (!mops || !mops->write_complete || !mops->state ||
>> -	    !mops->write_init || (!mops->write && !mops->write_sg) ||
>> +	    (!mops->write && !mops->write_sg) ||
>>   	    (mops->write && mops->write_sg)) {
>>   		dev_err(dev, "Attempt to register without fpga_manager_ops\n");
>>   		return NULL;
>> -- 
>> 2.26.3
>>
> Can you change the subjects to "fpga: fpga-mgr: ..."

ok

I know this varies widely, but..

each 'bla:' is a subdir bla/

In the next patchset to reorganize around a subdir structure, there are 
a few infrastructure files that i think could go into a fpga/fpga-mgr/

fpga-bridge.c  fpga-mgr.c  fpga-region.c  of-fpga-region.c

These are the only unmoved files in the patchset.

I was not sure about moving them so I left them alone.

Tom

>
> Otherwise series looks good.
>
> - Moritz
>


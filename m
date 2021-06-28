Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 270E43B69F7
	for <lists+linux-fpga@lfdr.de>; Mon, 28 Jun 2021 23:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237552AbhF1VFi (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 28 Jun 2021 17:05:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37620 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235991AbhF1VFh (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 28 Jun 2021 17:05:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624914191;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yzYnIdqALVwqpJ5Uy7M/EcMdnqNtYf74mt8YlEcYEKk=;
        b=h2dqHdnxl2xlHLSfTpNbCyn3HnTlysG/r2w1MBmt73y1ET7CL0q/vTAl5TCnXAln/DFKiw
        Ec3e4Az4EXlJeUQE+MWKruEhJcHwVl00aGtatIfbh2EEiRAh5Lvrdg3BcRJrgCyRilj8Lq
        wSBH/TS23mYXHC6LuySxyuqdtQ8aD3g=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-546-jc0P3dPMO6miiKmZUENrGA-1; Mon, 28 Jun 2021 17:03:07 -0400
X-MC-Unique: jc0P3dPMO6miiKmZUENrGA-1
Received: by mail-ot1-f72.google.com with SMTP id y59-20020a9d22c10000b0290451891192f0so13991518ota.1
        for <linux-fpga@vger.kernel.org>; Mon, 28 Jun 2021 14:03:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=yzYnIdqALVwqpJ5Uy7M/EcMdnqNtYf74mt8YlEcYEKk=;
        b=rbNpEgq1s+oxrsKiUX9n1uWorgPHQV54VeTTyvxLl8grbrDfZf5reIGxJg0ENhu5DK
         Xk2OWf3kMGWfft4e9/r5zRNkDOjyjqzIYLKAdNAnP2Bml1YZSvJIh1UfB92/RmfreDfA
         +AZu8Hcyy4tAGCfldUYKXkEc+TH8VDPXq5VJiQFFJTWMGrViCbeAajDkj0jtQDYedKcM
         bgqqOIXh2KILhSuFLOd3siYD3K4OSTip+jlM+nZdJBogajxAzGCNx737qAtZNOIPzk/O
         JTrfUtLGPZR/wAg5Q1KCkq23g4l8WysIUkWktDOTzhbDVBjfg4tKUaBdVJEy5GGUxCv9
         tkyA==
X-Gm-Message-State: AOAM530lQ/9fuBUVKuELLI7OkK9Y+x45Fp5T+VYJEWDtmViy68u7hk35
        V93YRICmWjm/Veyv6ldIUuGwPWKgb8poUHyWOj92D5yVG3r1bTBC7oiQEsKogyXUmsKpGePrNGe
        YB8EPcTEE3uW0LYcHshfOrQ==
X-Received: by 2002:a05:6808:1511:: with SMTP id u17mr22439675oiw.53.1624914186636;
        Mon, 28 Jun 2021 14:03:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzsZr7MBgtbktSb31XipIXX24eIxiYdVF2FG1UGZtqkHHRG/FrDVq9DRXtYM9k67DJiSLzlow==
X-Received: by 2002:a05:6808:1511:: with SMTP id u17mr22439662oiw.53.1624914186524;
        Mon, 28 Jun 2021 14:03:06 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id v203sm3454609oib.37.2021.06.28.14.03.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jun 2021 14:03:05 -0700 (PDT)
Subject: Re: [PATCH v4 1/7] fpga-mgr: wrap the write_init() op
To:     Moritz Fischer <mdf@kernel.org>, "Xu, Yilun" <yilun.xu@intel.com>
Cc:     hao.wu@intel.com, michal.simek@xilinx.com,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20210625195148.837230-1-trix@redhat.com>
 <20210625195148.837230-3-trix@redhat.com> <YNoauN/c0E65n8JU@epycbox.lan>
From:   Tom Rix <trix@redhat.com>
Message-ID: <088cbfc6-e627-c929-0d87-830bc6271c58@redhat.com>
Date:   Mon, 28 Jun 2021 14:03:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YNoauN/c0E65n8JU@epycbox.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 6/28/21 11:53 AM, Moritz Fischer wrote:
> On Fri, Jun 25, 2021 at 12:51:42PM -0700, trix@redhat.com wrote:
>> From: Tom Rix <trix@redhat.com>
>>
>> An FPGA manager should not be required to provide a
>> write_init() op if there is nothing for it do.
>> So add a wrapper and move the op checking.
>> Default to success.
>>
>> Signed-off-by: Tom Rix <trix@redhat.com>
>> ---
>>   drivers/fpga/fpga-mgr.c | 15 ++++++++++++---
>>   1 file changed, 12 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
>> index ecb4c3c795fa5..c047de8a059b7 100644
>> --- a/drivers/fpga/fpga-mgr.c
>> +++ b/drivers/fpga/fpga-mgr.c
>> @@ -25,6 +25,15 @@ struct fpga_mgr_devres {
>>   	struct fpga_manager *mgr;
>>   };
>>   
>> +static inline int fpga_mgr_write_init(struct fpga_manager *mgr,
>> +				      struct fpga_image_info *info,
>> +				      const char *buf, size_t count)
>> +{
>> +	if (mgr->mops->write_init)
> Will you need a if (mgr->mops && mgr->mops->write_init) here later?

This was changed from v3 based on Yilun's comment

https://lore.kernel.org/linux-fpga/20210624075414.GA44700@yilunxu-OptiPlex-7050/

This is checked on creation

>> +		return  mgr->mops->write_init(mgr, info, buf, count);
>> +	return 0;
>> +}
>> +
>>   /**
>>    * fpga_image_info_alloc - Allocate an FPGA image info struct
>>    * @dev: owning device
>> @@ -83,9 +92,9 @@ static int fpga_mgr_write_init_buf(struct fpga_manager *mgr,
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
>> @@ -569,7 +578,7 @@ struct fpga_manager *fpga_mgr_create(struct device *parent, const char *name,
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
>>
> Looks good to me, I might reword the commit message some when applying.

That is fine.

Thanks

Tom


> - Moritz
>


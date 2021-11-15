Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 305E6452478
	for <lists+linux-fpga@lfdr.de>; Tue, 16 Nov 2021 02:36:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350679AbhKPBjT (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 15 Nov 2021 20:39:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47922 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241715AbhKOSbi (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 15 Nov 2021 13:31:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637000919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aK6hdSkba46cIWzDDwDuhdoY6SKI2x0eiy91mL63vTY=;
        b=gL5s8Y/qnvU3qBo2GlnsX0Fy7AdJGf1VJqFdC3EUWO0v7tBNgtccVYpBVxitAkBe/C136T
        CrvNHyi/qt/ZNzjpkKxLHLhzym4WfZiLNf/YZShudlj8KL9HfSOlA8Ltv6ELJiGG+ZCs2i
        AuETQjZn54YiGJm3VCSZpJqIQvZPclw=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-J-m0axL_N4qv3UAPNcjtAw-1; Mon, 15 Nov 2021 13:28:35 -0500
X-MC-Unique: J-m0axL_N4qv3UAPNcjtAw-1
Received: by mail-pl1-f197.google.com with SMTP id p3-20020a170903248300b00143c00a5411so1327221plw.12
        for <linux-fpga@vger.kernel.org>; Mon, 15 Nov 2021 10:28:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=aK6hdSkba46cIWzDDwDuhdoY6SKI2x0eiy91mL63vTY=;
        b=PU0S9ltxHG0lcZE4ahsphNsAuP9kD2nvos5DiCPNI3661pDUf0Q8uP4bDhkockg04N
         gBWLJEdK8O8qbr+L484eMY8fYoNjYGZuy2WOcIdlEMjive38d9XuvEUfptk0aGj/44I+
         z8GCnuPMfy38ZE0Z8iR7SMwmANN1lIMp2Us8goVoVukiWO/z3TF/79h56FgvMq6FDITQ
         bk1Hio/robkvyAB4RWS1HDd6mSu++adajBpGN02xMVkuBnEoYE97XDJngX4QbJemCPzz
         7+nD6QYpeyN3Z32IWi3bik14d8m18OtIgxFLnOa4Jl6+ggI6ropjNrnpCivZKWuz4JG0
         jmjw==
X-Gm-Message-State: AOAM533WRp2qrErTe/H7wxOOms7vnI/Cq40wiy7PWn/UUCrZ0PQxX+MJ
        CgKjJSziy0xQp+1hqE7DY7u+lLh7sskNZf6DguxVJu/JDivLAepH+KqgVhq6OSdZfNKo7DPK+ox
        TaZvfF0g9CoXK6OvHeMH3cg==
X-Received: by 2002:a17:902:db0e:b0:142:13e4:b456 with SMTP id m14-20020a170902db0e00b0014213e4b456mr37967722plx.43.1637000914787;
        Mon, 15 Nov 2021 10:28:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzoa4unXYJvqaLuNm3SXfxeoZm0u9FN99pjwP+rVREsW6clf0JQsu6KT/A37FXckA140Y8vFg==
X-Received: by 2002:a17:902:db0e:b0:142:13e4:b456 with SMTP id m14-20020a170902db0e00b0014213e4b456mr37967698plx.43.1637000914561;
        Mon, 15 Nov 2021 10:28:34 -0800 (PST)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id i127sm15204292pfe.2.2021.11.15.10.28.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Nov 2021 10:28:34 -0800 (PST)
Subject: Re: [PATCH] fpga: dfl: pci: generalize find_dfls_by_vsec()
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     hao.wu@intel.com, mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211113221252.4062704-1-trix@redhat.com>
 <20211115012516.GA288162@yilunxu-OptiPlex-7050>
From:   Tom Rix <trix@redhat.com>
Message-ID: <f645abbe-230c-b3b8-de6c-6b8a605535f4@redhat.com>
Date:   Mon, 15 Nov 2021 10:28:32 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20211115012516.GA288162@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 11/14/21 5:25 PM, Xu Yilun wrote:
> On Sat, Nov 13, 2021 at 02:12:52PM -0800, trix@redhat.com wrote:
>> From: Tom Rix <trix@redhat.com>
>>
>> find_dfls_by_vsec() is a general dfl function.
>> Although dfl has multiple vendors, only Intel is supported.
>> Move vsec and vendor id to an array variable.
>> Other vendors can append the array to enable their support.
> As Hao mentioned, DVSEC could be a better solution if DFL should be
> present in components by a variety of vendors. This is not finally
> determined, but I think we should not add new features for VSEC now.

Can you expand what you mean by this ?

I am considering the n5010 usecase, the vendor is not intel and will go 
through this dfl function and always fail.

This is broken.

Either the function should be generalized or moved to an intel specific 
call.

Tom

>
> Thanks,
> Yilun
>
>> Signed-off-by: Tom Rix <trix@redhat.com>
>> ---
>>   drivers/fpga/dfl-pci.c | 31 ++++++++++++++++++++++++-------
>>   1 file changed, 24 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
>> index 4d68719e608f..9dc0815c8274 100644
>> --- a/drivers/fpga/dfl-pci.c
>> +++ b/drivers/fpga/dfl-pci.c
>> @@ -136,19 +136,36 @@ static int *cci_pci_create_irq_table(struct pci_dev *pcidev, unsigned int nvec)
>>   	return table;
>>   }
>>   
>> -static int find_dfls_by_vsec(struct pci_dev *pcidev, struct dfl_fpga_enum_info *info)
>> +struct dfl_vsec {
>> +	u16 vendor;
>> +	u16 id;
>> +};
>> +
>> +static struct dfl_vsec vsecs[] = {
>> +	{ PCI_VENDOR_ID_INTEL, PCI_VSEC_ID_INTEL_DFLS },
>> +};
>> +
>> +static int find_dfls_by_vsec(struct pci_dev *pcidev,
>> +			     struct dfl_fpga_enum_info *info)
>>   {
>>   	u32 bir, offset, vndr_hdr, dfl_cnt, dfl_res;
>>   	int dfl_res_off, i, bars, voff = 0;
>>   	resource_size_t start, len;
>>   
>> -	while ((voff = pci_find_next_ext_capability(pcidev, voff, PCI_EXT_CAP_ID_VNDR))) {
>> -		vndr_hdr = 0;
>> -		pci_read_config_dword(pcidev, voff + PCI_VNDR_HEADER, &vndr_hdr);
>> +	for (i = 0; i < ARRAY_SIZE(vsecs); i++) {
>> +		if (pcidev->vendor != vsecs[i].vendor)
>> +			continue;
>> +
>> +		while ((voff =
>> +			pci_find_next_ext_capability(pcidev, voff,
>> +						     PCI_EXT_CAP_ID_VNDR))) {
>> +			vndr_hdr = 0;
>> +			pci_read_config_dword(pcidev, voff + PCI_VNDR_HEADER,
>> +					      &vndr_hdr);
>>   
>> -		if (PCI_VNDR_HEADER_ID(vndr_hdr) == PCI_VSEC_ID_INTEL_DFLS &&
>> -		    pcidev->vendor == PCI_VENDOR_ID_INTEL)
>> -			break;
>> +			if (PCI_VNDR_HEADER_ID(vndr_hdr) == vsecs[i].id)
>> +				break;
>> +		}
>>   	}
>>   
>>   	if (!voff) {
>> -- 
>> 2.26.3


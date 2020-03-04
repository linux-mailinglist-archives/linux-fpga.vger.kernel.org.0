Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E48BD179185
	for <lists+linux-fpga@lfdr.de>; Wed,  4 Mar 2020 14:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729286AbgCDNia (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 4 Mar 2020 08:38:30 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:37096 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729118AbgCDNi3 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 4 Mar 2020 08:38:29 -0500
Received: by mail-qv1-f67.google.com with SMTP id c19so774598qvv.4
        for <linux-fpga@vger.kernel.org>; Wed, 04 Mar 2020 05:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=7JghIa37Fhjg/kv9C6J5np7KHN3FU6ZXjJNkxfYklnw=;
        b=Tn1BtvxC54NW/0EyKDj3pqyrUnuwPgZxvsKSJ2u2CAmzBNyPtjNLQJAq8+5PXE1JZI
         +MCMUVAWLOFT+a9KM3JgZ4SJN9pghKWIs8VZEKAjcPwODXkXzVfi50xHTtNUdHDxFnpa
         Ms39/VEvUu9sfX7m4rxFJrPtm2bAF0bh439s1g+D5BPr280HCC4vHTO4oiTBvtAn3VF9
         dSibsuFbsMsEvQwzpYrPm6/cm5Qn+/9RVtsVwu+I+nYXSxrz03KviQHi3BhQf8PQy6VH
         rA18pBcFoINjfha8veOsHtaHLjGtJp5IDP5NbAVpumRsYSbf31fmQxXg+zim49g1mx78
         TPDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=7JghIa37Fhjg/kv9C6J5np7KHN3FU6ZXjJNkxfYklnw=;
        b=nwevB+BW9lzqZwJ7VvMB+T8fKhDE972AiEslzXKL6LsfIl+TsUwMrSlgjkgJDD1hHz
         Xqi9/BObLGy1MUT98beiZJ+5Yp/8pd+CcGqzEz8UPWpOC1dnFMJJNmHrSjwIH+UzK/A2
         5JnygqwStMfg0MnVOAwiiYwLWhCvo/Dzbc449120ONWweYHdmijva23bQ9NylgIyOdMU
         FsM4YSxbv67yu0D/QId6OndI+q4WiOasHJIoDvbnSMGjEkxTBu9u66NBS6r+Y2kSaUyc
         GGFRs7hLL0QCIXfR9uMflUSAwfCaRTeg9hl+BkpWjqvuks8hEAGOx5rlBKyD3FK0jHHB
         cYsw==
X-Gm-Message-State: ANhLgQ0V+HducfLEHX5TFCdzR9x91ySutDizz9ysGkPfr9tzk+9a4PNz
        I8nmPCCabyXcNxJ8dy3PTYjS80m7
X-Google-Smtp-Source: ADFU+vs5a05OVPWWzuicWw1fF+ru0whG2uzP4PNtYJZYCVfdsaBtHo+W+42xuhWqa/P+QLGCq11JFA==
X-Received: by 2002:ad4:54a7:: with SMTP id r7mr2053459qvy.116.1583329108198;
        Wed, 04 Mar 2020 05:38:28 -0800 (PST)
Received: from [192.168.102.5] (pool-71-182-232-12.pitbpa.fios.verizon.net. [71.182.232.12])
        by smtp.googlemail.com with ESMTPSA id 4sm5553354qkl.79.2020.03.04.05.38.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2020 05:38:27 -0800 (PST)
Subject: Re: [Resend] [PATCH] fpga: support debug access to memory-mapped afu
 regions
To:     Wu Hao <hao.wu@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org
References: <20200304061406.98865-1-d.c.ddcc@gmail.com>
 <20200304103829.GA14731@hao-dev>
From:   Dominic Chen <d.c.ddcc@gmail.com>
Autocrypt: addr=d.c.ddcc@gmail.com; prefer-encrypt=mutual; keydata=
 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
 SP1d4L0/7aR4qw==
Message-ID: <cf46872f-e8dd-ed6b-7637-b23163bdde95@gmail.com>
Date:   Wed, 4 Mar 2020 08:38:27 -0500
MIME-Version: 1.0
In-Reply-To: <20200304103829.GA14731@hao-dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Sure, I will send out a v2.

Thanks,

Dominic

On 3/4/2020 5:38 AM, Wu Hao wrote:
> Hi Dominic,
>
> Thanks a lot for this patch. Please see my comments inline.
>
> On Wed, Mar 04, 2020 at 01:14:06AM -0500, Dominic Chen wrote:
>> Allow debug access to memory-mapped regions using e.g. gdb.
> Do you mind improving the title to something like
>
>    "fpga: dfl: afu: ...."
>
>> Signed-off-by: Dominic Chen <d.c.ddcc@gmail.com>
>> ---
>>  drivers/fpga/dfl-afu-main.c | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
>> index 02baa6a227c0..38983f9dde98 100644
>> --- a/drivers/fpga/dfl-afu-main.c
>> +++ b/drivers/fpga/dfl-afu-main.c
>> @@ -459,6 +459,12 @@ static long afu_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>>  	return -EINVAL;
>>  }
>>  
>> +#ifdef CONFIG_HAVE_IOREMAP_PROT
>> +const struct vm_operations_struct afu_vma_ops = {
> let's add "static" for afu_vma_ops here.
>
>> +	.access = generic_access_phys,
>> +};
>> +#endif /* CONFIG_HAVE_IOREMAP_PROT */
>> +
> What about
>
>   static const struct vm_operations_struct afu_vma_ops = {
>   #ifdef CONFIG_HAVE_IOREMAP_PROT
>   	.access = generic_access_phys,
>   #endif
>   };
>
> Then we just need one line below.
>
>   vma->vm_ops = &afu_vma_ops;
>
>
> Thanks
> Hao
>
>>  static int afu_mmap(struct file *filp, struct vm_area_struct *vma)
>>  {
>>  	struct platform_device *pdev = filp->private_data;
>> @@ -488,6 +494,11 @@ static int afu_mmap(struct file *filp, struct vm_area_struct *vma)
>>  	    !(region.flags & DFL_PORT_REGION_WRITE))
>>  		return -EPERM;
>>  
>> +	// Support debug access to the mapping
>> +#ifdef CONFIG_HAVE_IOREMAP_PROT
>> +	vma->vm_ops = &afu_vma_ops;
>> +#endif /* CONFIG_HAVE_IOREMAP_PROT */
>> +
>>  	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
>>  
>>  	return remap_pfn_range(vma, vma->vm_start,
>> -- 
>> 2.17.1

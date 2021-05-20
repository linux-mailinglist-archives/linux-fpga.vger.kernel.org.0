Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8B1238B024
	for <lists+linux-fpga@lfdr.de>; Thu, 20 May 2021 15:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233098AbhETNkg (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 20 May 2021 09:40:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58238 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231733AbhETNkg (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 20 May 2021 09:40:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621517953;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tIHuKc7qKGZdh6rEj/UQHhsvnRluHQvBwSw2juTcRH8=;
        b=PYH4O1osIZC3Ht/NTCj9Y/PZO5xIMWYl7AOytSPzAx+aOl0ntRLW+3jGE32NrfLgmzuzJk
        V1YtaRKrsCWxVdCw1HQCTAVhcCoDeRzcuwD0G1LnOUsieD/WDgM8y/POjiRPZYZDgT+HBL
        rt1U5vg+zFg5Yosp5ZgV2xQUfbfk3vU=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-545-WNUnLYVhMsaBqeQc6wdzsQ-1; Thu, 20 May 2021 09:39:12 -0400
X-MC-Unique: WNUnLYVhMsaBqeQc6wdzsQ-1
Received: by mail-qt1-f200.google.com with SMTP id s11-20020ac8758b0000b029020e731296abso1635507qtq.22
        for <linux-fpga@vger.kernel.org>; Thu, 20 May 2021 06:39:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=tIHuKc7qKGZdh6rEj/UQHhsvnRluHQvBwSw2juTcRH8=;
        b=b21Nux8vr8a8Dqa/+VZdh1JlQjTUR5AtNGlCTVSxSov7Yyqx+xcZUCUb7JzaUrtv5D
         BXNa6f+pfCzPHsWHeV+LKuC/tdMLScq5O0DDiuZZnj42rDrbF0r7ScCufuN2voGBpfnC
         WufOgmPHGAAHzcZ3v8LZn5xk18kmtqX6jedKxaZUDG8m5o+2i7O/YNHV5CNxeuZSrxD1
         i06KTi1/kI4/RtLdZvIERq2WFxcL9sWne94XE1OZqzsVBQLN5s1nyp80H30zB5E+/8jw
         /Ukap3NgU6PWh8GBL8VW7fisV60rzwJdJEcP8IKkyreTM0gHs5fL4f/nUjP76gfmuv/T
         5/7A==
X-Gm-Message-State: AOAM533RHdytlQ7vRaTVmmJf7+s943fWflWSCfqsmwIBWznELaf7Ri4F
        IMmlKEYof8PSt8Zfn3sVYUKYwesmCnWmtzz6+r2E6h3soZs574vOx7eV0XvQ6RY89btLPT0oXza
        PYUipgwH5mK6ZbwOV4Z4Z5w==
X-Received: by 2002:aed:2010:: with SMTP id 16mr5164692qta.256.1621517951943;
        Thu, 20 May 2021 06:39:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyY6d7yrV3IScAgQdkxLU88EkWvFf8eL6VXoT9cYThIk8gfokUR+vQJYCXMNAJnr4qS2t8Wlg==
X-Received: by 2002:aed:2010:: with SMTP id 16mr5164670qta.256.1621517951736;
        Thu, 20 May 2021 06:39:11 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id f13sm1092060qkk.107.2021.05.20.06.39.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 May 2021 06:39:11 -0700 (PDT)
Subject: Re: [PATCH 2/2] fpga: add cancel() and get_error() to update ops
To:     Moritz Fischer <mdf@kernel.org>,
        Russ Weight <russell.h.weight@intel.com>
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210519204318.1976186-1-trix@redhat.com>
 <YKV6G+9FOgMsqQuz@epycbox.lan>
From:   Tom Rix <trix@redhat.com>
Message-ID: <053373e3-bf53-d662-d4a2-1297efed830d@redhat.com>
Date:   Thu, 20 May 2021 06:39:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YKV6G+9FOgMsqQuz@epycbox.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 5/19/21 1:50 PM, Moritz Fischer wrote:
> Tom,
>
> On Wed, May 19, 2021 at 01:43:18PM -0700, trix@redhat.com wrote:
>> From: Tom Rix <trix@redhat.com>
>>
>> A user may want to cancel an update or get
>> more information on when an update fails.
>> Add some device ops to do these.
>>
>> Signed-off-by: Tom Rix <trix@redhat.com>
>> ---
>>   include/linux/fpga/fpga-mgr.h | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
>> index ab68280f3b4a4..31d6ebc34d87a 100644
>> --- a/include/linux/fpga/fpga-mgr.h
>> +++ b/include/linux/fpga/fpga-mgr.h
>> @@ -111,6 +111,8 @@ struct fpga_image_info {
>>    * @write: write count bytes of configuration data to the FPGA
>>    * @write_sg: write the scatter list of configuration data to the FPGA
>>    * @write_complete: set FPGA to operating state after writing is done
>> + * @cancel: cancel the update
>> + * @get_error: get extended error information
>>    */
>>   struct fpga_manager_update_ops {
>>   	int (*write_init)(struct fpga_manager *mgr,
>> @@ -120,6 +122,8 @@ struct fpga_manager_update_ops {
>>   	int (*write_sg)(struct fpga_manager *mgr, struct sg_table *sgt);
>>   	int (*write_complete)(struct fpga_manager *mgr,
>>   			      struct fpga_image_info *info);
>> +	int (*cancel)(struct fpga_manager *mgr);
>> +	int (*get_error)(struct fpga_manager *mgr, u64 *err);
>>   };
>>   
>>   /**
>> -- 
>> 2.26.3
>>
> There is no user for this, so if we add this, we add it with code
> calling it.

These additions come for unioning the fpga manager ops with the secure 
manager ops.

So will be needed if the secure manager goes this this way.

Tom

> Thanks
>
> - Moritz
>


Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3329A50BC10
	for <lists+linux-fpga@lfdr.de>; Fri, 22 Apr 2022 17:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449494AbiDVPuE (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 22 Apr 2022 11:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234255AbiDVPuC (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 22 Apr 2022 11:50:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1122D5D67A
        for <linux-fpga@vger.kernel.org>; Fri, 22 Apr 2022 08:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650642428;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OlUy6l6p+0482ZzVUfRyqGdQTewbaSoYgyNY1zTmabI=;
        b=fKV61xVDn+Dq4cPSjSyhMHx5QdgVos90DbiX7DkOXbvPmbHxSQilCoIjKtgtEzXwmjvn/w
        WNP1nEhDfSmzqkj+xhGinmxo95t9q6SrLvrvZSS90MPCwIUE5XdC8hQu3bC8MjOiA5mCno
        5hmob25OS8vYpjFb4/Q0q0aJEr52b74=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-13-OXqQZj1_OdGsvuAyTjoioQ-1; Fri, 22 Apr 2022 11:47:06 -0400
X-MC-Unique: OXqQZj1_OdGsvuAyTjoioQ-1
Received: by mail-ej1-f70.google.com with SMTP id sa27-20020a1709076d1b00b006e8b357a2e7so4340141ejc.14
        for <linux-fpga@vger.kernel.org>; Fri, 22 Apr 2022 08:47:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OlUy6l6p+0482ZzVUfRyqGdQTewbaSoYgyNY1zTmabI=;
        b=D3Xai/hDGZYxMh/gz/TMwxYstzlk8EbfEObVZFl7RIckMAXZ2WYp/b96vff6Hpqcts
         zpk4V8l6++zk1T2k5RqdsgR/zPpoLj8/V+lWe2sGjswnAY3nakVy2hmrdDcBIMVnJiwG
         oTy8ZTLEmSUcO2qjaLDVVCHP08/KVo9hsqr4fYIzFElfjunUoOse2CuSnjngJs9irwx1
         xL7wPESuCXd4ZongsH/sGRqKnIwckiuh8X0vYHhB5JQwYCJ0asNu8OwR8rOs4Pgbdxn1
         H1NMulcV3q/b08y+QlI/bKTyvwoCe71PX173IQkp2hrzsxaF9CG8rgcxgQcV4lYY+fIp
         Z6Wg==
X-Gm-Message-State: AOAM5306KiIoDAvr8e12hSvnpRTXtTrLs7nAHdPvm6w4ji4Pl8evIywF
        l66/TQq5pekRXMD1cKMPD2RdHIvsj8nli3iJ3LmWLOe650qI8QFHMBpkxsUEe+Q9jRrJW9TI7uR
        X2nCr6flOebOSc7cvk6Zq
X-Received: by 2002:aa7:dc49:0:b0:41d:72e2:d34e with SMTP id g9-20020aa7dc49000000b0041d72e2d34emr5507177edu.385.1650642425640;
        Fri, 22 Apr 2022 08:47:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzFAEE1VI+rkI2TiIlFRwMgrd+6Gm1qiHH/aaBKToMrAJsFJRrIiqTZsXd/t0p6TRHUNMoGiw==
X-Received: by 2002:aa7:dc49:0:b0:41d:72e2:d34e with SMTP id g9-20020aa7dc49000000b0041d72e2d34emr5507163edu.385.1650642425483;
        Fri, 22 Apr 2022 08:47:05 -0700 (PDT)
Received: from [192.168.9.10] (net-188-152-140-108.cust.vodafonedsl.it. [188.152.140.108])
        by smtp.gmail.com with ESMTPSA id j4-20020a170906278400b006e99f136c78sm859368ejc.23.2022.04.22.08.47.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 08:47:04 -0700 (PDT)
Message-ID: <736b71d7-1e07-f5c3-d8ad-c3e1b1595d5c@redhat.com>
Date:   Fri, 22 Apr 2022 17:47:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] fpga: altera-pr-ip: fix unsigned comparison with less
 than zero
Content-Language: en-US
To:     Moritz Fischer <mdf@kernel.org>
Cc:     Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>,
        Tom Rix <trix@redhat.com>, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220405185349.220607-1-marpagan@redhat.com>
 <Yl+K789ZUWd5Si0B@archbook>
From:   Marco Pagani <marpagan@redhat.com>
In-Reply-To: <Yl+K789ZUWd5Si0B@archbook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2022-04-20 06:24, Moritz Fischer wrote:
> Marco,
> 
> On Tue, Apr 05, 2022 at 08:53:49PM +0200, Marco Pagani wrote:
>> Fix the "comparison with less than zero" warning reported by
>> cppcheck for the unsigned (size_t) parameter "count" of the
>> "alt_pr_fpga_write()" function.
>>
> Should this have a Reported-by: tag?

I found this problem using the "cppcheck" tool, as reported in the
commit log. I did not find any previous report of this. Am I missing
something?

>> Signed-off-by: Marco Pagani <marpagan@redhat.com>
>> ---
>>  drivers/fpga/altera-pr-ip-core.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/fpga/altera-pr-ip-core.c b/drivers/fpga/altera-pr-ip-core.c
>> index be0667968d33..2ff3d8e46a0c 100644
>> --- a/drivers/fpga/altera-pr-ip-core.c
>> +++ b/drivers/fpga/altera-pr-ip-core.c
>> @@ -108,7 +108,7 @@ static int alt_pr_fpga_write(struct fpga_manager *mgr, const char *buf,
>>  	u32 *buffer_32 = (u32 *)buf;
>>  	size_t i = 0;
>>  
>> -	if (count <= 0)
>> +	if (count == 0)
>>  		return -EINVAL;
> 
> if (!count)
> 	return -EINVAL?

Ok, I'll change that in v2.

>>  
>>  	/* Write out the complete 32-bit chunks */
>> -- 
>> 2.35.1
> 
> Cheers,
> Moritz
>>
> 

Cheers,
Marco


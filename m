Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B97226BFA1C
	for <lists+linux-fpga@lfdr.de>; Sat, 18 Mar 2023 14:02:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbjCRNAX (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 18 Mar 2023 09:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjCRNAW (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 18 Mar 2023 09:00:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A85D627998
        for <linux-fpga@vger.kernel.org>; Sat, 18 Mar 2023 05:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679144373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8tqDexaW1R0cNP270wcvWDX3I0jhzNRDxhsGsGPr4AY=;
        b=UC2vfoDbMb+kmXhuXfVIWAN70KpuJXotZo20pPM7F00C3MKXRFrECEK4i+8EAV9/pGLorW
        YGKOR1bCqSyTfoEh5Zn9FxmL6q+RSk7yHojg3poASYHlMPGBJPKhIa0HKQT/OXN5s0jlBD
        5gR7nFEmV/otEMvzKdnOGn4L53Ga6BM=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-YCdbVup5NvWbnx4HvnjyeQ-1; Sat, 18 Mar 2023 08:59:32 -0400
X-MC-Unique: YCdbVup5NvWbnx4HvnjyeQ-1
Received: by mail-qt1-f199.google.com with SMTP id j5-20020ac85c45000000b003d81e3fe559so3935264qtj.16
        for <linux-fpga@vger.kernel.org>; Sat, 18 Mar 2023 05:59:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679144371;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8tqDexaW1R0cNP270wcvWDX3I0jhzNRDxhsGsGPr4AY=;
        b=P8LDSdVqfo0zx523mxbeDy5BCXJ1emgWLigMijkfBPfGtDEB1UzJQ2ZC+PQMrP/4gD
         nBTnET62n7ZB8t4S6BMFvAmswSTpR4lZJ8ERJc5/OOCpqjwhYfDCqg0pEU98AZK7/jJt
         AVeQa7Ik+0RfofeBFJPM87kb6Cgw4b6M1PlghN6RkhWSG6Zeh2UYDO6/9BKcsLKvNmEp
         0ziYsnbumMT4qYikBocPgX5tsOXVoIJHl1NMOKipwI61ca00MejCBc19Khz83k3oGRiO
         zGdhDvn4KAHidJ5a/3KxjNRSrgTzlWf5shDYuC7Rm8G9PN03haciWi0GSYq9EqZd2TmY
         0U8Q==
X-Gm-Message-State: AO0yUKUV4tLYhLVVdq2p2kHsUgYiHSWCK66TsisAHVS99qma9csi5rEn
        UcmNe57R9fK+Z3wJ7T69rocBvKdtMmcmGJhZAm6r3Se1WbtB2RYzH03/fhiNtpRs6JBnoJS+C1c
        qzRbscxG5v9JykE3Rqmjszw==
X-Received: by 2002:a05:6214:f06:b0:56e:a96a:2bdc with SMTP id gw6-20020a0562140f0600b0056ea96a2bdcmr46423990qvb.40.1679144371726;
        Sat, 18 Mar 2023 05:59:31 -0700 (PDT)
X-Google-Smtp-Source: AK7set8CTTnO50sIImmBipYldccpFr7gf2qDGHwyz89jzJjdzdbo+0Y13fj80VnaMoC6j8knqIms5Q==
X-Received: by 2002:a05:6214:f06:b0:56e:a96a:2bdc with SMTP id gw6-20020a0562140f0600b0056ea96a2bdcmr46423962qvb.40.1679144371464;
        Sat, 18 Mar 2023 05:59:31 -0700 (PDT)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id u23-20020a37ab17000000b0071f0d0aaef7sm97543qke.80.2023.03.18.05.59.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Mar 2023 05:59:31 -0700 (PDT)
Subject: Re: [PATCH] fpga: xilinx-pr-decoupler: remove unused
 xlnx_pr_decouple_read function
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     mdf@kernel.org, hao.wu@intel.com, michal.simek@xilinx.com,
        nathan@kernel.org, ndesaulniers@google.com,
        linux-fpga@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20230317230617.1673923-1-trix@redhat.com>
 <ZBWLeC7UuDf+4dJE@yilunxu-OptiPlex-7050>
From:   Tom Rix <trix@redhat.com>
Message-ID: <7cab9365-6493-2de0-bcef-cd46809056a8@redhat.com>
Date:   Sat, 18 Mar 2023 05:59:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <ZBWLeC7UuDf+4dJE@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 3/18/23 2:59 AM, Xu Yilun wrote:
> On 2023-03-17 at 19:06:17 -0400, Tom Rix wrote:
>> clang with W=1 reports
>> drivers/fpga/xilinx-pr-decoupler.c:37:19: error: unused function 'xlnx_pr_decouple_read' [-Werror,-Wunused-function]
>> static inline u32 xlnx_pr_decouple_read(const struct xlnx_pr_decoupler_data *d,
>>                    ^
>> This static function is not used, so remove it.
> I prefer to move the description as the first section. If you agree, I
> could do it before apply.

I have no preference, that is fine.

Tom

>
> Acked-by: Xu Yilun <yilun.xu@intel.com>
>
>> Signed-off-by: Tom Rix <trix@redhat.com>
>> ---
>>   drivers/fpga/xilinx-pr-decoupler.c | 6 ------
>>   1 file changed, 6 deletions(-)
>>
>> diff --git a/drivers/fpga/xilinx-pr-decoupler.c b/drivers/fpga/xilinx-pr-decoupler.c
>> index 2d9c491f7be9..b6f18c07c752 100644
>> --- a/drivers/fpga/xilinx-pr-decoupler.c
>> +++ b/drivers/fpga/xilinx-pr-decoupler.c
>> @@ -34,12 +34,6 @@ static inline void xlnx_pr_decoupler_write(struct xlnx_pr_decoupler_data *d,
>>   	writel(val, d->io_base + offset);
>>   }
>>   
>> -static inline u32 xlnx_pr_decouple_read(const struct xlnx_pr_decoupler_data *d,
>> -					u32 offset)
>> -{
>> -	return readl(d->io_base + offset);
>> -}
>> -
>>   static int xlnx_pr_decoupler_enable_set(struct fpga_bridge *bridge, bool enable)
>>   {
>>   	int err;
>> -- 
>> 2.27.0
>>


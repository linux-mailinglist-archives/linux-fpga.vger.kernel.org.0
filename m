Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6884D521555
	for <lists+linux-fpga@lfdr.de>; Tue, 10 May 2022 14:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241721AbiEJM0U (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 10 May 2022 08:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241729AbiEJM0L (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 10 May 2022 08:26:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 84D84EAB96
        for <linux-fpga@vger.kernel.org>; Tue, 10 May 2022 05:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652185332;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WiCK89kEWIvNaDQ0qeQE1chY8VrhB7OUssbjzFZyR9I=;
        b=h3KJivVQpPIJYHlZPwWsMNGBHjjQsRx4oFNoFj91sRri/3lKMNUXD+U6TW3UQKj0bdoNzy
        +MmSlkUhCtMahLwQp75QBSzqndcrBzRttx4I48YhcMSt27XRGmj2hJOIgfnjQJybTiitW1
        n0+HdmCmLxa+zi9PnU1WGiIudaozN+Q=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-544-CmXObd99M0GTU0-WTT8Tpw-1; Tue, 10 May 2022 08:22:03 -0400
X-MC-Unique: CmXObd99M0GTU0-WTT8Tpw-1
Received: by mail-qk1-f197.google.com with SMTP id d186-20020a3768c3000000b0069fcfacbea0so10596318qkc.0
        for <linux-fpga@vger.kernel.org>; Tue, 10 May 2022 05:22:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=WiCK89kEWIvNaDQ0qeQE1chY8VrhB7OUssbjzFZyR9I=;
        b=CsDubba7FgeWmMs/Nx3z7LmTwBNw/QU0gr6+SJfatDoyQsrQSIdJv9sqhr7RbMuQBx
         DIocxc0XnAvbTbONv+2lF+u7XEDQGzaJB25xRo2u1WNUdjc3+BbEwZ+8LEmgvbY56oXV
         0xA2HS07dMm++8kXxwSGuMqrbf0AtGCLtFSUlrO+ltT+rWNJbglxza7isB6RJySYGjGk
         LBQpemeJaVVRgnDu7XIzEkB+yMq9SwwOmFvyVvhETqIQmj9dGzBR3Qmvun45TUpNZIkd
         AKE5KZHUB91wXcqNxVLNc+M4RzQhWNlA3oyWCqA8dUzYELYOZlgUZbSC4xRRvYEiYIW2
         AIcQ==
X-Gm-Message-State: AOAM533qv6RHMDVhdVWMUN7xwO3ih3BV1U1JRKBWNphbr935SMjV7Qk+
        2kd4KjUjWqzBEf9e82ajcw89k1rccxg1pUvlxlifLkXE0MOviYYUs2WJ1YXdVNIXgM4YiIDmnv7
        Rl95nGjCUpCcOZcrJ7Gg0oQ==
X-Received: by 2002:a0c:f1d2:0:b0:45a:8012:1a90 with SMTP id u18-20020a0cf1d2000000b0045a80121a90mr17561386qvl.31.1652185323122;
        Tue, 10 May 2022 05:22:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZZjKWZKhkjX3wHG/+rKMpjtCtqRWirgGCroWqAJqGXK9ad3x9NMH6HpjWzGpcuPfqIfG2ow==
X-Received: by 2002:a0c:f1d2:0:b0:45a:8012:1a90 with SMTP id u18-20020a0cf1d2000000b0045a80121a90mr17561377qvl.31.1652185322938;
        Tue, 10 May 2022 05:22:02 -0700 (PDT)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id m13-20020ac8688d000000b002f39b99f696sm9430628qtq.48.2022.05.10.05.22.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 05:22:02 -0700 (PDT)
Subject: Re: [PATCH] fpga: zynq: fix zynq_fpga_has_sync()
To:     Nava kishore Manne <navam@xilinx.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
        Wu Hao <hao.wu@intel.com>
Cc:     Michal Simek <michals@xilinx.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
References: <YnkE8AbimDa7sfN8@kili>
 <b1448881-4a68-0bc4-b828-0b9c79ffdf11@redhat.com>
 <SN6PR02MB4576F78E793E7C0EE2A0A4FDC2C69@SN6PR02MB4576.namprd02.prod.outlook.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <0668a373-1101-5c34-31f1-d8435c59680d@redhat.com>
Date:   Tue, 10 May 2022 05:21:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <SN6PR02MB4576F78E793E7C0EE2A0A4FDC2C69@SN6PR02MB4576.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 5/9/22 8:15 AM, Nava kishore Manne wrote:
> Hi Tom,
>
> 	Please find my response inline.
>
>> -----Original Message-----
>> From: Tom Rix <trix@redhat.com>
>> Sent: Monday, May 9, 2022 6:14 PM
>> To: Dan Carpenter <dan.carpenter@oracle.com>; Moritz Fischer
>> <mdf@kernel.org>; Nava kishore Manne <navam@xilinx.com>; Xu Yilun
>> <yilun.xu@intel.com>; Wu Hao <hao.wu@intel.com>
>> Cc: Michal Simek <michals@xilinx.com>; linux-fpga@vger.kernel.org; kernel-
>> janitors@vger.kernel.org
>> Subject: Re: [PATCH] fpga: zynq: fix zynq_fpga_has_sync()
>>
>>
>> On 5/9/22 5:11 AM, Dan Carpenter wrote:
>>> The type needs to be u8.  The type was accidentally changed to char as
>>> a cleanup.  Unfortunately, that meant that the zynq_fpga_has_sync()
>>> function never returns true.  This bug was detected by Smatch and Clang:
>>>
>>> drivers/fpga/zynq-fpga.c:245 zynq_fpga_has_sync() warn: impossible
>> condition '(buf[2] == 153) => ((-128)-127 == 153)'
>>> drivers/fpga/zynq-fpga.c:246 zynq_fpga_has_sync() warn: impossible
>> condition '(buf[3] == 170) => ((-128)-127 == 170)'
>>> drivers/fpga/zynq-fpga.c:246:14: warning: result of comparison of
>>> constant 170 with expression of type 'const char' is always false
>>> [-Wtautological-constant-out-of-range-compare]
>>>                          buf[3] == 0xaa)
>>>                          ~~~~~~ ^  ~~~~
>>> drivers/fpga/zynq-fpga.c:245:50: warning: result of comparison of
>>> constant 153 with expression of type 'const char' is always false
>>> [-Wtautological-constant-out-of-range-compare]
>>>                      if (buf[0] == 0x66 && buf[1] == 0x55 && buf[2] == 0x99 &&
>>>                                                              ~~~~~~ ^
>>> ~~~~
>>>
>>> Fixes: ada14a023a64 ("fpga: zynq: Fix incorrect variable type")
>>> Reported-by: kernel test robot <lkp@intel.com>
>>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>>> ---
>>> The ada14a023a64 ("fpga: zynq: Fix incorrect variable type") patch
>>> went through six of revisions.  The kbuild bug found this bug early on
>>> but the author ingored kbuild-bot and kept resending the buggy patch
>>> anyway.
>>>
>>> After the patch was merged then I sent a separate bug report and Xu
>>> Yilun asked about why only the author was on the CC list for the first
>>> bug reports.  A valid question, definitely.  I will poke the kbuild
>>> devs about this.
>>>
>>> Hm...  Actually looking through the list there have been a bunch of
>>> bug reports about this because both Smatch and Clang complain so
>>> kbuild sends duplicate warnings for this type of bug.  And then kbuild
>>> sends another to say "This issue is still remaining" warning.  And
>>> then Xu Yilun sent an email "Kbuild-bot is still complaining.  Please
>>> don't forget to fix this."  So that's at least four public emails
>>> about this and one or two private emails directly from kbuild-bot to the
>> author.
>>> The kbuild-bot wanted to send *another* warning today, but I decided
>>> to send a fix instead.
>>>
>>> LOL.
>>>
>>>    drivers/fpga/zynq-fpga.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c index
>>> 6beaba9dfe97..426aa34c6a0d 100644
>>> --- a/drivers/fpga/zynq-fpga.c
>>> +++ b/drivers/fpga/zynq-fpga.c
>>> @@ -239,7 +239,7 @@ static irqreturn_t zynq_fpga_isr(int irq, void *data)
>>>     * the correct byte order, and be dword aligned. The input is a Xilinx .bin
>>>     * file with every 32 bit quantity swapped.
>>>     */
>>> -static bool zynq_fpga_has_sync(const char *buf, size_t count)
>>> +static bool zynq_fpga_has_sync(const u8 *buf, size_t count)
>> This is called from zynq_fpga_ops_write_init, a fpga_manager_ops function
>> that
>>
>> uses 'const char *' as a type for its write() buf's.
>>
>> I think const u8 * would be a better type for all of the fpga_manager
>> instances.
>>
>> If folks agree, I'll make the change.
>>
> I agree, please change it to u8

I was hoping one of the fpga/ maintainers would chime in.

Though it seems obvious that the type-specifier should be unsigned, this 
is a general interface change to the subsystem.

I would rather have buy in before spending a couple of days doing the 
change and having it rejected.

Tom

>
> Regards,
> Nava kishore.


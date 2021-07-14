Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D99023C8600
	for <lists+linux-fpga@lfdr.de>; Wed, 14 Jul 2021 16:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbhGNOZU (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 14 Jul 2021 10:25:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38172 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232037AbhGNOZT (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 14 Jul 2021 10:25:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626272547;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M+PCijAFK+zc4yebc2+Chhr3mPpRnKROJHkGBmiJexA=;
        b=CmPQZ5gQs5+8ihwaEdPirHybOd2CBWo2BIET9XPtvHgHGeIblQltGBOHSxVdtr0GijzCtI
        phg9ZPMrGedEAzG1EpfdAA5BCNK2wy+Jl8lB3O2eDkbJ4IO/1D/Untk0I5aSLlxPm0MOPc
        NtgH2fSO7ejZeXDgBLFdkAtWHCnup70=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-bfv033euOVi4DykxDpwVjQ-1; Wed, 14 Jul 2021 10:22:26 -0400
X-MC-Unique: bfv033euOVi4DykxDpwVjQ-1
Received: by mail-qt1-f197.google.com with SMTP id 61-20020aed21430000b029024e7e455d67so1992404qtc.16
        for <linux-fpga@vger.kernel.org>; Wed, 14 Jul 2021 07:22:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=M+PCijAFK+zc4yebc2+Chhr3mPpRnKROJHkGBmiJexA=;
        b=ofvGf5j39aayAg9vA+6FMGOcrNnRdpQTdqcg/90dkM5iW3zmXIa6RnuwdR0C8NkygU
         pWZN7YIr2s2K/7Y6q5zj7AGFT41YSkbjJ2cteaCgnDZZHEcmRfL4cHH0X6PgtK5f7UP+
         n3m8tKKlMa/t/ldVL3HjUmdqDFhzFP7AYq1fO+ReC50IzqMXCZJY1zawaE3PpCXbr2SV
         7siO2XI+B9RaUyUwU8GYVGd/WZMqBACXynCX3akxh5uyAFNstsUeE6pbA5j9901QZOyt
         EGoTlsPw/IN+mXje5x+IT8cE5SQUHdUtXFMWXYjIWD9WGB7y6AnA/fY9IC0HLTLeHSMq
         iB4Q==
X-Gm-Message-State: AOAM533xXFyjwDxpZiE2c59fRhYBrbZ4HWBCoKGYyVSz8GKry37rHvWZ
        51ZDt3/ZmZjP1eX6juTID4i99zFABrscz/kBW5TPAQy7EyGEzOS/dlUVwvEvQGGBFZbSa0jYLVi
        V0OT9R0esbE8I/sec/pHyNQ==
X-Received: by 2002:a37:cd0:: with SMTP id 199mr10167164qkm.69.1626272545205;
        Wed, 14 Jul 2021 07:22:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwIl4qQxdtL1RBVqFykTv9nwuH3HGdWbTZY5hynMAyEJAyRrYZKgBknquu9Xi3Ou9JMvCGkcA==
X-Received: by 2002:a37:cd0:: with SMTP id 199mr10167145qkm.69.1626272545038;
        Wed, 14 Jul 2021 07:22:25 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id f12sm1102779qke.37.2021.07.14.07.22.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jul 2021 07:22:24 -0700 (PDT)
Subject: Re: [PATCH v4 2/4] spi: spi-altera-dfl: support n5010 feature
 revision
To:     =?UTF-8?Q?Martin_Hundeb=c3=b8ll?= <mhu@silicom.dk>,
        =?UTF-8?Q?Martin_Hundeb=c3=b8ll?= <martin@geanix.com>,
        Wu Hao <hao.wu@intel.com>, Moritz Fischer <mdf@kernel.org>,
        Xu Yilun <yilun.xu@intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-spi@vger.kernel.org
References: <20210705101645.2040106-1-martin@geanix.com>
 <20210705101645.2040106-3-martin@geanix.com>
 <d6250f86-db93-bcc2-d46e-6dba30976cc4@redhat.com>
 <f3bbe112-b105-07ac-9d2e-8ffc89c0a89c@silicom.dk>
From:   Tom Rix <trix@redhat.com>
Message-ID: <99abfd17-4307-0b88-32a3-c80f61da587b@redhat.com>
Date:   Wed, 14 Jul 2021 07:22:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <f3bbe112-b105-07ac-9d2e-8ffc89c0a89c@silicom.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 7/14/21 4:33 AM, Martin Hundebøll wrote:
>
>
> On 06/07/2021 16.56, Tom Rix wrote:
>>> diff --git a/drivers/spi/spi-altera-dfl.c 
>>> b/drivers/spi/spi-altera-dfl.c
>>> index 3e32e4fe5895..f6cf7c8d9dac 100644
>>> --- a/drivers/spi/spi-altera-dfl.c
>>> +++ b/drivers/spi/spi-altera-dfl.c
>>> @@ -111,6 +111,13 @@ static struct spi_board_info m10_bmc_info = {
>>>       .chip_select = 0,
>>>   };
>>> +static struct spi_board_info m10_n5010_bmc_info = {
>>> +    .modalias = "m10-n5010",
>>> +    .max_speed_hz = 12500000,
>>> +    .bus_num = 0,
>>> +    .chip_select = 0,
>>> +};
>>
>> Other then the modalias, this is exactly the same as m10_bmc_info.
>>
>> Why not set platform_data?
>
> So like this?
>
> +static struct spi_board_info m10_n5010_bmc_info = {
> +    .platform_data = "m10-n5010",
> +    .max_speed_hz = 12500000,
> +    .bus_num = 0,
> +    .chip_select = 0,
> +};
>
> I don't see how that should improve the situation, but we might allocate
> the board info on the stack and set modalias dynamically instead?

No, I mean that instead of have two *bmc_info's generalize the existing one.

This could be done by using the as yet unused platform_data field to 
hold the identity as a bit/enum in an int.

Tom

>
> // Martin
>


Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FADB5213B3
	for <lists+linux-fpga@lfdr.de>; Tue, 10 May 2022 13:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240524AbiEJL24 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 10 May 2022 07:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232943AbiEJL2y (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 10 May 2022 07:28:54 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A632ABBF4
        for <linux-fpga@vger.kernel.org>; Tue, 10 May 2022 04:24:56 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 129so9982964wmz.0
        for <linux-fpga@vger.kernel.org>; Tue, 10 May 2022 04:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=Q9ZRcghSC4Zvb59xWNLpgwQRMRVcmsJ18TNHtRXVuxo=;
        b=Z8rrIL6/GXzsZMveC2UvwKakgRmDeIw1l90/SleuXTMgs2cSdCxz/gmmODmAv6sEH2
         h5XIM3/YspFdyoTA0JemciadBa44j3VSGsGllMClineyi7qIFswlQwNAJGfiQd0fUkxm
         JW66RrO1CCZMUOpvT7wgXBu5XGD8ySg9oIGHC8a2gCLcoqbqw80PAeySedyai8xjaUsv
         17pQzZ6ahOXkqC0oGwYOtcTjzC8nSyfqjAPMXhzXgy9SJnG4Im7QxKiaRR/7utl42tYA
         x8ePtZRcgzb8SbMPv4rCE27OwGcwXqrVcPx6VWF9f5I27j6FL+PA+t74BY6wYzapSXgC
         Q5Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=Q9ZRcghSC4Zvb59xWNLpgwQRMRVcmsJ18TNHtRXVuxo=;
        b=mR0R9EdsC69W8yrx6ExIo7i8/pxa/jku3IDJ7OtrpRZCA+PdaijvCZeSUECsQGpvSQ
         qQBEiZnZXJZXshgHlZB4ZFvCfSvy0NQN1HK2sN5/6PgBfIxp9PAd5oqZd6tDkTYCpA2W
         vdmo23ofPz97mTokggQgADfc/0qb35FhuFRlD8qaWVuhHECcoRV0NVhoHRqQpO4d6xAy
         YpcbIn8Ul7we7OcqAAQAmJRo6CPKGFdhmSwLxPqNZESxKLEvCnpeS/SD6nfPUu8KwUbT
         lPFURRrwW/qUAO13yvL+umyTGAiNYQutba4G+CaCZGH8sWr73DelfOgwAEHOf4KuIWSh
         PpMA==
X-Gm-Message-State: AOAM533Xp9J1qisxqmXwYfA50+goEPvcgImlckKZEgQiqv9XfcGjy6sV
        bY6gokObDHy8pFVRXUpB5hGoTg==
X-Google-Smtp-Source: ABdhPJzHodgmub9AKZbEZJmNj8kVL+mO6/cqFeW/NflOzT4A4EkxOlFoqbMN5nCm3xonWyHTJZpAmA==
X-Received: by 2002:a7b:c76e:0:b0:394:8be3:a83c with SMTP id x14-20020a7bc76e000000b003948be3a83cmr12055521wmk.41.1652181895085;
        Tue, 10 May 2022 04:24:55 -0700 (PDT)
Received: from [10.205.160.53] ([95.83.233.54])
        by smtp.gmail.com with ESMTPSA id i6-20020a05600c354600b003942a244f33sm2404493wmq.12.2022.05.10.04.24.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 04:24:54 -0700 (PDT)
Message-ID: <4b752147-1a09-a4af-bc5d-3b132b84ef49@conchuod.ie>
Date:   Tue, 10 May 2022 12:29:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
From:   Conor Dooley <mail@conchuod.ie>
Subject: Re: [PATCH v11 2/3] fpga: microchip-spi: add Microchip MPF FPGA
 manager
To:     Ivan Bornyakov <i.bornyakov@metrotek.ru>,
        Conor.Dooley@microchip.com
Cc:     mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
        trix@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-fpga@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        system@metrotek.ru
References: <20220507074304.11144-1-i.bornyakov@metrotek.ru>
 <20220507074304.11144-3-i.bornyakov@metrotek.ru>
 <bd5cb37b-ee56-f6d5-2d98-c08566b60728@microchip.com>
 <20220509171621.zk4owxwlngxjodgz@x260>
 <da1e5125-de6b-11a8-a52d-7e6e5f45ab70@conchuod.ie>
Content-Language: en-US
In-Reply-To: <da1e5125-de6b-11a8-a52d-7e6e5f45ab70@conchuod.ie>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 09/05/2022 19:56, Conor Dooley wrote:
> On 09/05/2022 18:16, Ivan Bornyakov wrote:
>> On Mon, May 09, 2022 at 11:41:18AM +0000, Conor.Dooley@microchip.com wrote:
>>> Hey Ivan, one comment below.
>>> Thanks,
>>> Conor.
>>>
>>> On 07/05/2022 08:43, Ivan Bornyakov wrote:
>>>> ... snip ...
>>>> +static int mpf_read_status(struct spi_device *spi)
>>>> +{
>>>> +       u8 status, status_command = MPF_SPI_READ_STATUS;
>>>> +       struct spi_transfer xfer = {
>>>> +               .tx_buf = &status_command,
>>>> +               .rx_buf = &status,
>>>> +               .len = 1,
>>>> +       };
>>>> +       int ret = spi_sync_transfer(spi, &xfer, 1);
>>>> +
>>>> +       if ((status & MPF_STATUS_SPI_VIOLATION) ||
>>>> +           (status & MPF_STATUS_SPI_ERROR))
>>>> +               ret = -EIO;
>>>> +
>>>> +       return ret ? : status;
>>>> +}
>>>> +
>>>> ... snip ...
>>>> +
>>>> +static int poll_status_not_busy(struct spi_device *spi, u8 mask)
>>>> +{
>>>> +       int status, timeout = MPF_STATUS_POLL_TIMEOUT;
>>>> +
>>>> +       while (timeout--) {
>>>> +               status = mpf_read_status(spi);
>>>> +               if (status < 0 ||
>>>> +                   (!(status & MPF_STATUS_BUSY) && (!mask || (status & mask))))
>>>> +                       return status;
>>>> +
>>>> +               usleep_range(1000, 2000);
>>>> +       }
>>>> +
>>>> +       return -EBUSY;
>>>> +}
>>>
>>> Is there a reason you changed this from the snippet you sent me
>>> in the responses to version 8:
>>> static int poll_status_not_busy(struct spi_device *spi, u8 mask)
>>> {
>>> 	u8 status, status_command = MPF_SPI_READ_STATUS;
>>> 	int ret, timeout = MPF_STATUS_POLL_TIMEOUT;
>>> 	struct spi_transfer xfer = {
>>> 		.tx_buf = &status_command,
>>> 		.rx_buf = &status,
>>> 		.len = 1,
>>> 	};
>>>
>>> 	while (timeout--) {
>>> 		ret = spi_sync_transfer(spi, &xfer, 1);
>>> 		if (ret < 0)
>>> 			return ret;
>>>
>>> 		if (!(status & MPF_STATUS_BUSY) && (!mask || (status & mask)))
>>> 			return status;
>>>
>>> 		usleep_range(1000, 2000);
>>> 	}
>>>
>>> 	return -EBUSY;
>>> }
>>>
>>> With the current version, I hit the "Failed to write bitstream
>>> frame" check in mpf_ops_write at random points in the transfer.
>>> Replacing poll_status_not_busy with the above allows it to run
>>> to completion.
>>
>> In my eyes they are equivalent, aren't they?
>>
> 
> I was in a bit of a rush today & didn't have time to do proper
> debugging, I'll put some debug code in tomorrow and try to find
> exactly what is different between the two.
> 
> Off the top of my head, since I don't have a board on me to test,
> the only difference I can see is that with the snippet you only
> checked if spi_sync_transfer was negative whereas now you check
> if it has a value at all w/ that ternary operator.
> 
> But even that seems like it *shouldn't* be the problem, since ret
> should contain -errno or zero, right?
> Either way, I will do some digging tomorrow.

I put a printk("status %x, ret %d", status, ret); into the failure
path of mpf_read_status() & it looks like a status 0xA is being
returned - error & ready? That seems like a very odd combo to be
getting back out of it. It shouldn't be dodgy driver/connection
either, b/c that's what I see if I connect my protocol analyser:
https://i.imgur.com/VbjgfCk.png

That's mosi (hex), ss, sclk, mosi, miso (hex), miso in descending
order.

I think what was happening was with the snippet you returned one
of the following: -EBUSY, ret (aka -errno) or status. Since status
is positive, the checks in mpf_spi_write.*() saw nothing wrong at
all and programming continued despite there being a problem.

The new version fixes this by returning -EIO rather than status from
poll_status_not_busy().

I wish I had a socketable PolarFire so I could investigate further,
but this looks like it might a be hardware issue somewhere on my
end?

So ye, sorry for the noise and carry on! I'll try tofind what is to
blame for it.

Thanks,
Conor.



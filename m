Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C31CE5204E0
	for <lists+linux-fpga@lfdr.de>; Mon,  9 May 2022 20:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240326AbiEITAU (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 9 May 2022 15:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240337AbiEITAP (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 9 May 2022 15:00:15 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5686C14E2DA
        for <linux-fpga@vger.kernel.org>; Mon,  9 May 2022 11:56:18 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id w4so20688660wrg.12
        for <linux-fpga@vger.kernel.org>; Mon, 09 May 2022 11:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=fqTBattGAJtnrmVWrbgz/UotSXeK8Snx1e8ZFCucKYs=;
        b=gDkG04/SNxmFNVgZf2d+irbN58bze6dLPrPLblpNEnpzyfg3yubPF3B0U6E/9ctDrq
         wDypkXp7VhgTOVfAjOJNBQyi9lUlwsMt4aaFQaHCtV3uO1VAvnq275wobPNDbf7yfbwe
         Z0cAPR50UUkVcwZ2RsCUw42jScMWc1ZPRVj9vg/Gqdws20DlniqLNg8FnWnDi5eYCfrL
         IDHf2CsiWeJj6vX0/5obzvHMoTII/wyc+8ZmGzQ+LUAuPPQ7ETeigSMuEPaltJpJAfpT
         LqE8Ai9WH0otikn32hI1NdPZdtEMqNVIVY8+UObjuuKmkzSg6ZsppWXPVmWcrSrik5uj
         060A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fqTBattGAJtnrmVWrbgz/UotSXeK8Snx1e8ZFCucKYs=;
        b=qX5pAwP5gfFlv+KNfuE+VHc0OX/iGyVr36KM6355J5MXz9JMMAgx9cy7BuwK7yvXbo
         eFPo25yoCAJSC9zYkV9ZiifjiDoWI7TYP1UigSx7wWtrBdg0MIj5jd/hCRa3Mwt2AGVy
         haJMNtZsLJHxJzuQeu/Z/8Q+b5JGg3CjJzmeP4Aj4+yvjTJ77RWfepnALnLRBBTHSOWK
         V8zE+Ek1NInc2v7knlaZgnqEhmzbwIQ9hYftsWRanpoGHa65ukwquRwX/WIbHim68TJf
         y2aRZOfIIdHKAX0vuuZjdO/+HecLOFqBI35hzr5JtkWhhI+EFvMp09iLkooLF+5kEZGa
         DBDw==
X-Gm-Message-State: AOAM533wtZJHap8UR7DrXOmdOVlZLqLBgVoAEMTJXZY6810uFUta7h5M
        1sMPOjsHDpX6y0HPQrN/ywYjSQ==
X-Google-Smtp-Source: ABdhPJzuVr+4GGP9XPU0tTEDkNW/jy+aopJiM1dLh8aO1XPuGKab/R04N5cXcMLL+cChk3I40SCs6w==
X-Received: by 2002:adf:e941:0:b0:20a:d483:1bbc with SMTP id m1-20020adfe941000000b0020ad4831bbcmr15595525wrn.218.1652122576800;
        Mon, 09 May 2022 11:56:16 -0700 (PDT)
Received: from [192.168.2.222] ([109.76.240.96])
        by smtp.gmail.com with ESMTPSA id x22-20020a1c7c16000000b003942a244ecfsm71616wmc.20.2022.05.09.11.56.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 May 2022 11:56:16 -0700 (PDT)
Message-ID: <da1e5125-de6b-11a8-a52d-7e6e5f45ab70@conchuod.ie>
Date:   Mon, 9 May 2022 19:56:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v11 2/3] fpga: microchip-spi: add Microchip MPF FPGA
 manager
Content-Language: en-US
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
From:   Conor Dooley <mail@conchuod.ie>
In-Reply-To: <20220509171621.zk4owxwlngxjodgz@x260>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 09/05/2022 18:16, Ivan Bornyakov wrote:
> On Mon, May 09, 2022 at 11:41:18AM +0000, Conor.Dooley@microchip.com wrote:
>> Hey Ivan, one comment below.
>> Thanks,
>> Conor.
>>
>> On 07/05/2022 08:43, Ivan Bornyakov wrote:
>>> ... snip ...
>>> +static int mpf_read_status(struct spi_device *spi)
>>> +{
>>> +       u8 status, status_command = MPF_SPI_READ_STATUS;
>>> +       struct spi_transfer xfer = {
>>> +               .tx_buf = &status_command,
>>> +               .rx_buf = &status,
>>> +               .len = 1,
>>> +       };
>>> +       int ret = spi_sync_transfer(spi, &xfer, 1);
>>> +
>>> +       if ((status & MPF_STATUS_SPI_VIOLATION) ||
>>> +           (status & MPF_STATUS_SPI_ERROR))
>>> +               ret = -EIO;
>>> +
>>> +       return ret ? : status;
>>> +}
>>> +
>>> ... snip ...
>>> +
>>> +static int poll_status_not_busy(struct spi_device *spi, u8 mask)
>>> +{
>>> +       int status, timeout = MPF_STATUS_POLL_TIMEOUT;
>>> +
>>> +       while (timeout--) {
>>> +               status = mpf_read_status(spi);
>>> +               if (status < 0 ||
>>> +                   (!(status & MPF_STATUS_BUSY) && (!mask || (status & mask))))
>>> +                       return status;
>>> +
>>> +               usleep_range(1000, 2000);
>>> +       }
>>> +
>>> +       return -EBUSY;
>>> +}
>>
>> Is there a reason you changed this from the snippet you sent me
>> in the responses to version 8:
>> static int poll_status_not_busy(struct spi_device *spi, u8 mask)
>> {
>> 	u8 status, status_command = MPF_SPI_READ_STATUS;
>> 	int ret, timeout = MPF_STATUS_POLL_TIMEOUT;
>> 	struct spi_transfer xfer = {
>> 		.tx_buf = &status_command,
>> 		.rx_buf = &status,
>> 		.len = 1,
>> 	};
>>
>> 	while (timeout--) {
>> 		ret = spi_sync_transfer(spi, &xfer, 1);
>> 		if (ret < 0)
>> 			return ret;
>>
>> 		if (!(status & MPF_STATUS_BUSY) && (!mask || (status & mask)))
>> 			return status;
>>
>> 		usleep_range(1000, 2000);
>> 	}
>>
>> 	return -EBUSY;
>> }
>>
>> With the current version, I hit the "Failed to write bitstream
>> frame" check in mpf_ops_write at random points in the transfer.
>> Replacing poll_status_not_busy with the above allows it to run
>> to completion.
> 
> In my eyes they are equivalent, aren't they?
> 

I was in a bit of a rush today & didn't have time to do proper
debugging, I'll put some debug code in tomorrow and try to find
exactly what is different between the two.

Off the top of my head, since I don't have a board on me to test,
the only difference I can see is that with the snippet you only
checked if spi_sync_transfer was negative whereas now you check
if it has a value at all w/ that ternary operator.

But even that seems like it *shouldn't* be the problem, since ret
should contain -errno or zero, right?
Either way, I will do some digging tomorrow.

Thanks,
Conor.


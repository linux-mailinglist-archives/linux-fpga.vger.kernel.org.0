Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA7F255A45
	for <lists+linux-fpga@lfdr.de>; Fri, 28 Aug 2020 14:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbgH1Meq (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 28 Aug 2020 08:34:46 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:57852 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729397AbgH1MeO (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 28 Aug 2020 08:34:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598618047;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ct8xDJYJ89VJvANRUmU/6ISWosO9og6URdO8Jpm3Dgs=;
        b=QPItl0QufkDiI5tP8i1eR0IZG1hR95sUgc9KIRRKnw5WKXxb6l+gymbrxSVGrEit3l4TLp
        OjEQN1LZZLM8d2yBnUZp27x53o/XEHPGRpo7qZ7Lm+if9eLx3cYIZhekdb5RWipIjpB20V
        ZI9hGV6+r8fj5PgsSPcF5R5uRBSa68Q=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-ozK9bj_-OGi2s4OOddeMSg-1; Fri, 28 Aug 2020 08:34:05 -0400
X-MC-Unique: ozK9bj_-OGi2s4OOddeMSg-1
Received: by mail-qk1-f197.google.com with SMTP id c67so839376qkd.0
        for <linux-fpga@vger.kernel.org>; Fri, 28 Aug 2020 05:34:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Ct8xDJYJ89VJvANRUmU/6ISWosO9og6URdO8Jpm3Dgs=;
        b=eoDYHDAb3Zq/40nrWD9nCQ+mVSuBRyNrlJNp4CAI6Zj4y3gF7gwglg1xB+yCHaNzAz
         4B21c6nqusUxDZd1Y00sF3iqeW8+M7nU3RfOJtTJ4NbdbhBurT6/IciHIYtgXngZG1SF
         Uhp5Kw6UmDdX2eQgbB3ZCD4O2EojiYWEBEKm/HMh/JKYJoxjkpXN+Y9K4zxvAAcv+X7h
         FdNA6KjCOu6rlMVs4Nj8fQnPBUYIPg1RE45e0KB2ZborEC8CcHyEnyH+8u41gNmi5b8+
         p6zVAItS+eMX/TEQFnEIG9SRFtTsxu0G7oudq+ldM3vDeste6XOFN+1AvStL1V9peB0W
         4bQQ==
X-Gm-Message-State: AOAM5313jJpuh1FHIAj9Q0ddT/awdpVAdT2vCOxR2GozL0wStWtxQ+ft
        9EK8sdkNX3DXE5uL7WsOPit79nqxRsHIb/JSaRlcLWJaPZ2KDGOKPDROrktm3D9NpOSIB+naVXh
        OzKnXLIALuuRc3sQr5gtDqw==
X-Received: by 2002:ac8:4d0c:: with SMTP id w12mr1305100qtv.194.1598618044769;
        Fri, 28 Aug 2020 05:34:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzipaTL/51rdxeovoXzoqbx0fNREecI8K0Uri/QfP4khzDvEJeVpIYkEaXnKNUdJNfZML0kDA==
X-Received: by 2002:ac8:4d0c:: with SMTP id w12mr1305080qtv.194.1598618044469;
        Fri, 28 Aug 2020 05:34:04 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 201sm611014qkf.103.2020.08.28.05.34.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Aug 2020 05:34:03 -0700 (PDT)
Subject: Re: [PATCH v2 3/5] fpga manager: xilinx-spi: rework write_complete
 loop implementation
To:     Luca Ceresoli <luca@lucaceresoli.net>
Cc:     linux-fpga@vger.kernel.org, Moritz Fischer <mdf@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anatolij Gustschin <agust@denx.de>
References: <20200827143249.10973-1-luca@lucaceresoli.net>
 <20200827143249.10973-3-luca@lucaceresoli.net>
 <2b8d9ed7-0468-9001-2f8e-386312aae6cb@redhat.com>
 <bc35f12e-6ff2-94a7-d519-94616f6dfc6c@lucaceresoli.net>
 <27bbb896-fedf-6a3a-7220-5c57239a3b87@redhat.com>
 <913cb7ea-3502-b3cd-3ec9-af60d63129c9@lucaceresoli.net>
From:   Tom Rix <trix@redhat.com>
Message-ID: <67ad9e7e-b07a-52e7-f82d-b7f8fac28d8f@redhat.com>
Date:   Fri, 28 Aug 2020 05:34:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <913cb7ea-3502-b3cd-3ec9-af60d63129c9@lucaceresoli.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 8/27/20 11:38 PM, Luca Ceresoli wrote:
> Hi Tom,
>
> On 27/08/20 21:34, Tom Rix wrote:
>> On 8/27/20 12:26 PM, Luca Ceresoli wrote:
>>> Hi Tom,
>>>
>>> thanks for the prompt feedback!
>>>
>>> On 27/08/20 20:59, Tom Rix wrote:
>>>> On 8/27/20 7:32 AM, Luca Ceresoli wrote:
>>>>> In preparation to add error checking for gpiod_get_value(), rework
>>>>> the loop to avoid the duplication of these lines:
>>>>>
>>>>> 	if (gpiod_get_value(conf->done))
>>>>> 		return xilinx_spi_apply_cclk_cycles(conf);
>>>>>
>>>>> There is little advantage in this rework with current code. However
>>>>> error checking will expand these two lines to five, making code
>>>>> duplication more annoying.
>>>>>
>>>>> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
>>>>>
>>>>> ---
>>>>>
>>>>> This patch is new in v2
>>>>> ---
>>>>>  drivers/fpga/xilinx-spi.c | 15 ++++++---------
>>>>>  1 file changed, 6 insertions(+), 9 deletions(-)
>>>>>
>>>>> diff --git a/drivers/fpga/xilinx-spi.c b/drivers/fpga/xilinx-spi.c
>>>>> index 01f494172379..cfc933d70f52 100644
>>>>> --- a/drivers/fpga/xilinx-spi.c
>>>>> +++ b/drivers/fpga/xilinx-spi.c
>>>>> @@ -151,22 +151,19 @@ static int xilinx_spi_write_complete(struct fpga_manager *mgr,
>>>>>  				     struct fpga_image_info *info)
>>>>>  {
>>>>>  	struct xilinx_spi_conf *conf = mgr->priv;
>>>>> -	unsigned long timeout;
>>>>> +	unsigned long timeout = jiffies + usecs_to_jiffies(info->config_complete_timeout_us);
>>>>>  	int ret;
>>>>>  
>>>>> -	if (gpiod_get_value(conf->done))
>>>>> -		return xilinx_spi_apply_cclk_cycles(conf);
>>>>> -
>>>>> -	timeout = jiffies + usecs_to_jiffies(info->config_complete_timeout_us);
>>>>> +	while (true) {
>>>>> +		if (gpiod_get_value(conf->done))
>>>>> +			return xilinx_spi_apply_cclk_cycles(conf);
>>>>>  
>>>>> -	while (time_before(jiffies, timeout)) {
>>>>> +		if (time_after(jiffies, timeout))
>>>>> +			break;
>>>>>  
>>>>>  		ret = xilinx_spi_apply_cclk_cycles(conf);
>>>>>  		if (ret)
>>>>>  			return ret;
>>>>> -
>>>>> -		if (gpiod_get_value(conf->done))
>>>>> -			return xilinx_spi_apply_cclk_cycles(conf);
>>>>>  	} 
>>>> Do you need another
>>>>
>>>> 	if (gpiod_get_value(conf->done))
>>>> 		return xilinx_spi_apply_cclk_cycles(conf);
>>>>
>>>> here to cover the chance of sleeping in the loop ?
>>> If I got your question correctly: if we get here it's because of a
>>> timeout, thus programming has failed (DONE didn't come up after some
>>> time), and checking it one more here seems pointless.
>> It may not be pointless, if this routine sleeps because it was scheduled out, when it wakes up a lot of time  happened. You will see this as a timeout but the state may be good.  Another, final check at the end will cover this case.
> Oh, now I got your point! Yes, there is this risk, and it exists in
> current code as well but with a smaller risk window. Unrolling the
> current and new loop code they behave the same except for the position
> of the timeout computation (after vs before the first 'if (done) return'
> group).
>
> I think this reimplementation is sleep-safe, check for GPIO errors and
> also avoid code duplication:
>
> static int xilinx_spi_write_complete(struct fpga_manager *mgr,
> 				     struct fpga_image_info *info)
> {
> 	struct xilinx_spi_conf *conf = mgr->priv;
> 	unsigned long timeout = jiffies +
> 		usecs_to_jiffies(info->config_complete_timeout_us);
> 	bool expired;
> 	int done;
> 	int ret;
>
> 	while (!expired) {
> 		expired = time_after(jiffies, timeout);
>
> 		done = get_done_gpio(mgr);
> 		if (done < 0)
> 			return done;
>
> 		ret = xilinx_spi_apply_cclk_cycles(conf);
> 		if (ret)
> 			return ret;
>
> 		if (done)
> 			return 0;
> 	}
>
> 	dev_err(&mgr->dev, "Timeout after config data transfer\n");
>
> 	return -ETIMEDOUT;
> }
>
> A key point is to assess all the status (expired and done variables)
> before taking any action based on it. Then we can unconditionally apply
> 8 cclk cycles before even checking the actual DONE value, so that we
> always do that after DONE has been seen asserted.
>
> Does it look good?

Yes. Thanks for the extra work.

Tom

>


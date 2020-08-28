Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 750B1255499
	for <lists+linux-fpga@lfdr.de>; Fri, 28 Aug 2020 08:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbgH1Gi5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fpga@lfdr.de>); Fri, 28 Aug 2020 02:38:57 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:58161 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726010AbgH1Gi5 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 28 Aug 2020 02:38:57 -0400
Received: from [78.134.86.56] (port=44498 helo=[192.168.77.62])
        by hostingweb31.netsons.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <luca@lucaceresoli.net>)
        id 1kBY2H-000EXc-0n; Fri, 28 Aug 2020 08:38:53 +0200
Subject: Re: [PATCH v2 3/5] fpga manager: xilinx-spi: rework write_complete
 loop implementation
To:     Tom Rix <trix@redhat.com>
References: <20200827143249.10973-1-luca@lucaceresoli.net>
 <20200827143249.10973-3-luca@lucaceresoli.net>
 <2b8d9ed7-0468-9001-2f8e-386312aae6cb@redhat.com>
 <bc35f12e-6ff2-94a7-d519-94616f6dfc6c@lucaceresoli.net>
 <27bbb896-fedf-6a3a-7220-5c57239a3b87@redhat.com>
From:   Luca Ceresoli <luca@lucaceresoli.net>
Cc:     linux-fpga@vger.kernel.org, Moritz Fischer <mdf@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anatolij Gustschin <agust@denx.de>
Message-ID: <913cb7ea-3502-b3cd-3ec9-af60d63129c9@lucaceresoli.net>
Date:   Fri, 28 Aug 2020 08:38:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <27bbb896-fedf-6a3a-7220-5c57239a3b87@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca@lucaceresoli.net
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Tom,

On 27/08/20 21:34, Tom Rix wrote:
> 
> On 8/27/20 12:26 PM, Luca Ceresoli wrote:
>> Hi Tom,
>>
>> thanks for the prompt feedback!
>>
>> On 27/08/20 20:59, Tom Rix wrote:
>>> On 8/27/20 7:32 AM, Luca Ceresoli wrote:
>>>> In preparation to add error checking for gpiod_get_value(), rework
>>>> the loop to avoid the duplication of these lines:
>>>>
>>>> 	if (gpiod_get_value(conf->done))
>>>> 		return xilinx_spi_apply_cclk_cycles(conf);
>>>>
>>>> There is little advantage in this rework with current code. However
>>>> error checking will expand these two lines to five, making code
>>>> duplication more annoying.
>>>>
>>>> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
>>>>
>>>> ---
>>>>
>>>> This patch is new in v2
>>>> ---
>>>>  drivers/fpga/xilinx-spi.c | 15 ++++++---------
>>>>  1 file changed, 6 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/drivers/fpga/xilinx-spi.c b/drivers/fpga/xilinx-spi.c
>>>> index 01f494172379..cfc933d70f52 100644
>>>> --- a/drivers/fpga/xilinx-spi.c
>>>> +++ b/drivers/fpga/xilinx-spi.c
>>>> @@ -151,22 +151,19 @@ static int xilinx_spi_write_complete(struct fpga_manager *mgr,
>>>>  				     struct fpga_image_info *info)
>>>>  {
>>>>  	struct xilinx_spi_conf *conf = mgr->priv;
>>>> -	unsigned long timeout;
>>>> +	unsigned long timeout = jiffies + usecs_to_jiffies(info->config_complete_timeout_us);
>>>>  	int ret;
>>>>  
>>>> -	if (gpiod_get_value(conf->done))
>>>> -		return xilinx_spi_apply_cclk_cycles(conf);
>>>> -
>>>> -	timeout = jiffies + usecs_to_jiffies(info->config_complete_timeout_us);
>>>> +	while (true) {
>>>> +		if (gpiod_get_value(conf->done))
>>>> +			return xilinx_spi_apply_cclk_cycles(conf);
>>>>  
>>>> -	while (time_before(jiffies, timeout)) {
>>>> +		if (time_after(jiffies, timeout))
>>>> +			break;
>>>>  
>>>>  		ret = xilinx_spi_apply_cclk_cycles(conf);
>>>>  		if (ret)
>>>>  			return ret;
>>>> -
>>>> -		if (gpiod_get_value(conf->done))
>>>> -			return xilinx_spi_apply_cclk_cycles(conf);
>>>>  	} 
>>> Do you need another
>>>
>>> 	if (gpiod_get_value(conf->done))
>>> 		return xilinx_spi_apply_cclk_cycles(conf);
>>>
>>> here to cover the chance of sleeping in the loop ?
>> If I got your question correctly: if we get here it's because of a
>> timeout, thus programming has failed (DONE didn't come up after some
>> time), and checking it one more here seems pointless.
> 
> It may not be pointless, if this routine sleeps because it was scheduled out, when it wakes up a lot of time  happened. You will see this as a timeout but the state may be good.  Another, final check at the end will cover this case.

Oh, now I got your point! Yes, there is this risk, and it exists in
current code as well but with a smaller risk window. Unrolling the
current and new loop code they behave the same except for the position
of the timeout computation (after vs before the first 'if (done) return'
group).

I think this reimplementation is sleep-safe, check for GPIO errors and
also avoid code duplication:

static int xilinx_spi_write_complete(struct fpga_manager *mgr,
				     struct fpga_image_info *info)
{
	struct xilinx_spi_conf *conf = mgr->priv;
	unsigned long timeout = jiffies +
		usecs_to_jiffies(info->config_complete_timeout_us);
	bool expired;
	int done;
	int ret;

	while (!expired) {
		expired = time_after(jiffies, timeout);

		done = get_done_gpio(mgr);
		if (done < 0)
			return done;

		ret = xilinx_spi_apply_cclk_cycles(conf);
		if (ret)
			return ret;

		if (done)
			return 0;
	}

	dev_err(&mgr->dev, "Timeout after config data transfer\n");

	return -ETIMEDOUT;
}

A key point is to assess all the status (expired and done variables)
before taking any action based on it. Then we can unconditionally apply
8 cclk cycles before even checking the actual DONE value, so that we
always do that after DONE has been seen asserted.

Does it look good?

-- 
Luca


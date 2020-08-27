Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 610EA254E33
	for <lists+linux-fpga@lfdr.de>; Thu, 27 Aug 2020 21:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbgH0T0H (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 27 Aug 2020 15:26:07 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:48502 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726236AbgH0T0H (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 27 Aug 2020 15:26:07 -0400
Received: from [78.134.86.56] (port=44256 helo=[192.168.77.62])
        by hostingweb31.netsons.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <luca@lucaceresoli.net>)
        id 1kBNX9-0008JP-Ii; Thu, 27 Aug 2020 21:26:03 +0200
Subject: Re: [PATCH v2 3/5] fpga manager: xilinx-spi: rework write_complete
 loop implementation
To:     Tom Rix <trix@redhat.com>, linux-fpga@vger.kernel.org
Cc:     Moritz Fischer <mdf@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anatolij Gustschin <agust@denx.de>
References: <20200827143249.10973-1-luca@lucaceresoli.net>
 <20200827143249.10973-3-luca@lucaceresoli.net>
 <2b8d9ed7-0468-9001-2f8e-386312aae6cb@redhat.com>
From:   Luca Ceresoli <luca@lucaceresoli.net>
Message-ID: <bc35f12e-6ff2-94a7-d519-94616f6dfc6c@lucaceresoli.net>
Date:   Thu, 27 Aug 2020 21:26:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <2b8d9ed7-0468-9001-2f8e-386312aae6cb@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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

thanks for the prompt feedback!

On 27/08/20 20:59, Tom Rix wrote:
> 
> On 8/27/20 7:32 AM, Luca Ceresoli wrote:
>> In preparation to add error checking for gpiod_get_value(), rework
>> the loop to avoid the duplication of these lines:
>>
>> 	if (gpiod_get_value(conf->done))
>> 		return xilinx_spi_apply_cclk_cycles(conf);
>>
>> There is little advantage in this rework with current code. However
>> error checking will expand these two lines to five, making code
>> duplication more annoying.
>>
>> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
>>
>> ---
>>
>> This patch is new in v2
>> ---
>>  drivers/fpga/xilinx-spi.c | 15 ++++++---------
>>  1 file changed, 6 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/fpga/xilinx-spi.c b/drivers/fpga/xilinx-spi.c
>> index 01f494172379..cfc933d70f52 100644
>> --- a/drivers/fpga/xilinx-spi.c
>> +++ b/drivers/fpga/xilinx-spi.c
>> @@ -151,22 +151,19 @@ static int xilinx_spi_write_complete(struct fpga_manager *mgr,
>>  				     struct fpga_image_info *info)
>>  {
>>  	struct xilinx_spi_conf *conf = mgr->priv;
>> -	unsigned long timeout;
>> +	unsigned long timeout = jiffies + usecs_to_jiffies(info->config_complete_timeout_us);
>>  	int ret;
>>  
>> -	if (gpiod_get_value(conf->done))
>> -		return xilinx_spi_apply_cclk_cycles(conf);
>> -
>> -	timeout = jiffies + usecs_to_jiffies(info->config_complete_timeout_us);
>> +	while (true) {
>> +		if (gpiod_get_value(conf->done))
>> +			return xilinx_spi_apply_cclk_cycles(conf);
>>  
>> -	while (time_before(jiffies, timeout)) {
>> +		if (time_after(jiffies, timeout))
>> +			break;
>>  
>>  		ret = xilinx_spi_apply_cclk_cycles(conf);
>>  		if (ret)
>>  			return ret;
>> -
>> -		if (gpiod_get_value(conf->done))
>> -			return xilinx_spi_apply_cclk_cycles(conf);
>>  	} 
> 
> Do you need another
> 
> 	if (gpiod_get_value(conf->done))
> 		return xilinx_spi_apply_cclk_cycles(conf);
> 
> here to cover the chance of sleeping in the loop ?

If I got your question correctly: if we get here it's because of a
timeout, thus programming has failed (DONE didn't come up after some
time), and checking it one more here seems pointless.

Does this reply your question?

-- 
Luca

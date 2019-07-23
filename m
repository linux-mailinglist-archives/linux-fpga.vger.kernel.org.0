Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 565B371A92
	for <lists+linux-fpga@lfdr.de>; Tue, 23 Jul 2019 16:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387969AbfGWOil (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 23 Jul 2019 10:38:41 -0400
Received: from mga17.intel.com ([192.55.52.151]:35444 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730165AbfGWOil (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 23 Jul 2019 10:38:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jul 2019 07:38:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,299,1559545200"; 
   d="scan'208";a="197143796"
Received: from tthayer-hp-z620.an.intel.com (HELO [10.122.105.146]) ([10.122.105.146])
  by fmsmga002.fm.intel.com with ESMTP; 23 Jul 2019 07:38:40 -0700
From:   Thor Thayer <thor.thayer@linux.intel.com>
Subject: Re: [PATCHv2 2/3] fpga: altera-cvp: Preparation for V2 parts.
Reply-To: thor.thayer@linux.intel.com
To:     Moritz Fischer <mdf@kernel.org>
Cc:     richard.gong@linux.intel.com, agust@denx.de,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1563317287-18834-1-git-send-email-thor.thayer@linux.intel.com>
 <1563317287-18834-3-git-send-email-thor.thayer@linux.intel.com>
 <20190722005938.GB2583@archbook>
Message-ID: <6e54c0ee-b8ec-4f95-cf81-70aacc82c72e@linux.intel.com>
Date:   Tue, 23 Jul 2019 09:40:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190722005938.GB2583@archbook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Moritz,

On 7/21/19 7:59 PM, Moritz Fischer wrote:
> Thor,
> 
> On Tue, Jul 16, 2019 at 05:48:06PM -0500, thor.thayer@linux.intel.com wrote:
>> From: Thor Thayer <thor.thayer@linux.intel.com>
>>
>> In preparation for adding newer V2 parts that use a FIFO,
>> reorganize altera_cvp_chk_error() and change the write
>> function to block based.
>> V2 parts have a block size matching the FIFO while older
>> V1 parts write a 32 bit word at a time.
>>
>> Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
>> ---
>> v2 Remove inline function declaration
>>     Reverse Christmas Tree format for local variables
>> ---
>>   drivers/fpga/altera-cvp.c | 72 ++++++++++++++++++++++++++++++-----------------
>>   1 file changed, 46 insertions(+), 26 deletions(-)
>>
>> diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
>> index b78c90580071..37419d6b9915 100644
>> --- a/drivers/fpga/altera-cvp.c
>> +++ b/drivers/fpga/altera-cvp.c
>> @@ -140,6 +140,41 @@ static int altera_cvp_wait_status(struct altera_cvp_conf *conf, u32 status_mask,
>>   	return -ETIMEDOUT;
>>   }
>>   
>> +static int altera_cvp_chk_error(struct fpga_manager *mgr, size_t bytes)
>> +{
>> +	struct altera_cvp_conf *conf = mgr->priv;
>> +	u32 val;
>> +
>> +	/* STEP 10 (optional) - check CVP_CONFIG_ERROR flag */
>> +	altera_read_config_dword(conf, VSE_CVP_STATUS, &val);
> Same as in the other email, why can we ignore return values here. I
> think the original code probably did that already.

Yes, I actually didn't make any changes to this function. You can see I 
moved it from below since it is used in the following function.

I'm not checking the return code from any of the read/write functions 
since the original driver didn't. Would you prefer I check and issue a 
warning?

Thanks for reviewing!

>> +	if (val & VSE_CVP_STATUS_CFG_ERR) {
>> +		dev_err(&mgr->dev, "CVP_CONFIG_ERROR after %zu bytes!\n",
>> +			bytes);
>> +		return -EPROTO;
>> +	}
>> +	return 0;
>> +}
>> +
>> +static int altera_cvp_send_block(struct altera_cvp_conf *conf,
>> +				 const u32 *data, size_t len)
>> +{
>> +	u32 mask, words = len / sizeof(u32);
>> +	int i, remainder;
>> +
>> +	for (i = 0; i < words; i++)
>> +		conf->write_data(conf, *data++);
>> +
>> +	/* write up to 3 trailing bytes, if any */
>> +	remainder = len % sizeof(u32);
>> +	if (remainder) {
>> +		mask = BIT(remainder * 8) - 1;
>> +		if (mask)
>> +			conf->write_data(conf, *data & mask);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>   static int altera_cvp_teardown(struct fpga_manager *mgr,
>>   			       struct fpga_image_info *info)
>>   {
>> @@ -262,39 +297,29 @@ static int altera_cvp_write_init(struct fpga_manager *mgr,
>>   	return 0;
>>   }
>>   
>> -static inline int altera_cvp_chk_error(struct fpga_manager *mgr, size_t bytes)
>> -{
>> -	struct altera_cvp_conf *conf = mgr->priv;
>> -	u32 val;
>> -
>> -	/* STEP 10 (optional) - check CVP_CONFIG_ERROR flag */
>> -	altera_read_config_dword(conf, VSE_CVP_STATUS, &val);
>> -	if (val & VSE_CVP_STATUS_CFG_ERR) {
>> -		dev_err(&mgr->dev, "CVP_CONFIG_ERROR after %zu bytes!\n",
>> -			bytes);
>> -		return -EPROTO;
>> -	}
>> -	return 0;
>> -}
>> -
>>   static int altera_cvp_write(struct fpga_manager *mgr, const char *buf,
>>   			    size_t count)
>>   {
>>   	struct altera_cvp_conf *conf = mgr->priv;
>> +	size_t done, remaining, len;
>>   	const u32 *data;
>> -	size_t done, remaining;
>>   	int status = 0;
>> -	u32 mask;
>>   
>>   	/* STEP 9 - write 32-bit data from RBF file to CVP data register */
>>   	data = (u32 *)buf;
>>   	remaining = count;
>>   	done = 0;
>>   
>> -	while (remaining >= 4) {
>> -		conf->write_data(conf, *data++);
>> -		done += 4;
>> -		remaining -= 4;
>> +	while (remaining) {
>> +		if (remaining >= sizeof(u32))
>> +			len = sizeof(u32);
>> +		else
>> +			len = remaining;
>> +
>> +		altera_cvp_send_block(conf, data, len);
>> +		data++;
>> +		done += len;
>> +		remaining -= len;
>>   
>>   		/*
>>   		 * STEP 10 (optional) and STEP 11
>> @@ -312,11 +337,6 @@ static int altera_cvp_write(struct fpga_manager *mgr, const char *buf,
>>   		}
>>   	}
>>   
>> -	/* write up to 3 trailing bytes, if any */
>> -	mask = BIT(remaining * 8) - 1;
>> -	if (mask)
>> -		conf->write_data(conf, *data & mask);
>> -
>>   	if (altera_cvp_chkcfg)
>>   		status = altera_cvp_chk_error(mgr, count);
>>   
>> -- 
>> 2.7.4
>>
> Cheers,
> Moritz
> 


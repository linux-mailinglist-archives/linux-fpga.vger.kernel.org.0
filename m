Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28A977344F
	for <lists+linux-fpga@lfdr.de>; Wed, 24 Jul 2019 18:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbfGXQ5N (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 24 Jul 2019 12:57:13 -0400
Received: from mga01.intel.com ([192.55.52.88]:29580 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726567AbfGXQ5N (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 24 Jul 2019 12:57:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jul 2019 09:57:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,303,1559545200"; 
   d="scan'208";a="193519956"
Received: from tthayer-hp-z620.an.intel.com (HELO [10.122.105.146]) ([10.122.105.146])
  by fmsmga004.fm.intel.com with ESMTP; 24 Jul 2019 09:57:12 -0700
Reply-To: thor.thayer@linux.intel.com
Subject: Re: [PATCHv2 2/3] fpga: altera-cvp: Preparation for V2 parts.
To:     Moritz Fischer <mdf@kernel.org>
Cc:     richard.gong@linux.intel.com, agust@denx.de,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1563317287-18834-1-git-send-email-thor.thayer@linux.intel.com>
 <1563317287-18834-3-git-send-email-thor.thayer@linux.intel.com>
 <20190722005938.GB2583@archbook>
 <6e54c0ee-b8ec-4f95-cf81-70aacc82c72e@linux.intel.com>
 <20190724145704.GB24455@archbox>
From:   Thor Thayer <thor.thayer@linux.intel.com>
Message-ID: <b52ea6f3-a547-ebce-88f5-6256501a7e99@linux.intel.com>
Date:   Wed, 24 Jul 2019 11:59:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190724145704.GB24455@archbox>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Moritz,

On 7/24/19 9:57 AM, Moritz Fischer wrote:
> On Tue, Jul 23, 2019 at 09:40:51AM -0500, Thor Thayer wrote:
>> Hi Moritz,
>>
>> On 7/21/19 7:59 PM, Moritz Fischer wrote:
>>> Thor,
>>>
>>> On Tue, Jul 16, 2019 at 05:48:06PM -0500, thor.thayer@linux.intel.com wrote:
>>>> From: Thor Thayer <thor.thayer@linux.intel.com>
>>>>
>>>> In preparation for adding newer V2 parts that use a FIFO,
>>>> reorganize altera_cvp_chk_error() and change the write
>>>> function to block based.
>>>> V2 parts have a block size matching the FIFO while older
>>>> V1 parts write a 32 bit word at a time.
>>>>
>>>> Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
>>>> ---
>>>> v2 Remove inline function declaration
>>>>      Reverse Christmas Tree format for local variables
>>>> ---
>>>>    drivers/fpga/altera-cvp.c | 72 ++++++++++++++++++++++++++++++-----------------
>>>>    1 file changed, 46 insertions(+), 26 deletions(-)
>>>>
>>>> diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
>>>> index b78c90580071..37419d6b9915 100644
>>>> --- a/drivers/fpga/altera-cvp.c
>>>> +++ b/drivers/fpga/altera-cvp.c
>>>> @@ -140,6 +140,41 @@ static int altera_cvp_wait_status(struct altera_cvp_conf *conf, u32 status_mask,
>>>>    	return -ETIMEDOUT;
>>>>    }
>>>> +static int altera_cvp_chk_error(struct fpga_manager *mgr, size_t bytes)
>>>> +{
>>>> +	struct altera_cvp_conf *conf = mgr->priv;
>>>> +	u32 val;
>>>> +
>>>> +	/* STEP 10 (optional) - check CVP_CONFIG_ERROR flag */
>>>> +	altera_read_config_dword(conf, VSE_CVP_STATUS, &val);
>>> Same as in the other email, why can we ignore return values here. I
>>> think the original code probably did that already.
>>
>> Yes, I actually didn't make any changes to this function. You can see I
>> moved it from below since it is used in the following function.
>>
>> I'm not checking the return code from any of the read/write functions since
>> the original driver didn't. Would you prefer I check and issue a warning?
> 
> Not sure a warning would change much here. We should probably look at
> why it was ok in the first place.

A quick grep of the drivers directory shows that an overwhelming 
majority of pci_read_config_dword() and pci_write_config_dword() calls 
do not check the return code.

For robustness, I agree with you that checking and returning the return 
code in this error checking function is important. I will return the 
error code if the read fails.

It shouldn't be necessary to change the rest of the code though unless 
you feel strongly about updating the existing codebase.

>>
>> Thanks for reviewing!
>>
>>>> +	if (val & VSE_CVP_STATUS_CFG_ERR) {
>>>> +		dev_err(&mgr->dev, "CVP_CONFIG_ERROR after %zu bytes!\n",
>>>> +			bytes);
>>>> +		return -EPROTO;
>>>> +	}
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static int altera_cvp_send_block(struct altera_cvp_conf *conf,
>>>> +				 const u32 *data, size_t len)
>>>> +{
>>>> +	u32 mask, words = len / sizeof(u32);
>>>> +	int i, remainder;
>>>> +
>>>> +	for (i = 0; i < words; i++)
>>>> +		conf->write_data(conf, *data++);
>>>> +
>>>> +	/* write up to 3 trailing bytes, if any */
>>>> +	remainder = len % sizeof(u32);
>>>> +	if (remainder) {
>>>> +		mask = BIT(remainder * 8) - 1;
>>>> +		if (mask)
>>>> +			conf->write_data(conf, *data & mask);
>>>> +	}
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>>    static int altera_cvp_teardown(struct fpga_manager *mgr,
>>>>    			       struct fpga_image_info *info)
>>>>    {
>>>> @@ -262,39 +297,29 @@ static int altera_cvp_write_init(struct fpga_manager *mgr,
>>>>    	return 0;
>>>>    }
>>>> -static inline int altera_cvp_chk_error(struct fpga_manager *mgr, size_t bytes)
>>>> -{
>>>> -	struct altera_cvp_conf *conf = mgr->priv;
>>>> -	u32 val;
>>>> -
>>>> -	/* STEP 10 (optional) - check CVP_CONFIG_ERROR flag */
>>>> -	altera_read_config_dword(conf, VSE_CVP_STATUS, &val);
>>>> -	if (val & VSE_CVP_STATUS_CFG_ERR) {
>>>> -		dev_err(&mgr->dev, "CVP_CONFIG_ERROR after %zu bytes!\n",
>>>> -			bytes);
>>>> -		return -EPROTO;
>>>> -	}
>>>> -	return 0;
>>>> -}
>>>> -
>>>>    static int altera_cvp_write(struct fpga_manager *mgr, const char *buf,
>>>>    			    size_t count)
>>>>    {
>>>>    	struct altera_cvp_conf *conf = mgr->priv;
>>>> +	size_t done, remaining, len;
>>>>    	const u32 *data;
>>>> -	size_t done, remaining;
>>>>    	int status = 0;
>>>> -	u32 mask;
>>>>    	/* STEP 9 - write 32-bit data from RBF file to CVP data register */
>>>>    	data = (u32 *)buf;
>>>>    	remaining = count;
>>>>    	done = 0;
>>>> -	while (remaining >= 4) {
>>>> -		conf->write_data(conf, *data++);
>>>> -		done += 4;
>>>> -		remaining -= 4;
>>>> +	while (remaining) {
>>>> +		if (remaining >= sizeof(u32))
>>>> +			len = sizeof(u32);
>>>> +		else
>>>> +			len = remaining;
>>>> +
>>>> +		altera_cvp_send_block(conf, data, len);
>>>> +		data++;
>>>> +		done += len;
>>>> +		remaining -= len;
>>>>    		/*
>>>>    		 * STEP 10 (optional) and STEP 11
>>>> @@ -312,11 +337,6 @@ static int altera_cvp_write(struct fpga_manager *mgr, const char *buf,
>>>>    		}
>>>>    	}
>>>> -	/* write up to 3 trailing bytes, if any */
>>>> -	mask = BIT(remaining * 8) - 1;
>>>> -	if (mask)
>>>> -		conf->write_data(conf, *data & mask);
>>>> -
>>>>    	if (altera_cvp_chkcfg)
>>>>    		status = altera_cvp_chk_error(mgr, count);
>>>> -- 
>>>> 2.7.4
>>>>
>>> Cheers,
>>> Moritz
>>>
>>
> 
> Moritz
> 
Thor

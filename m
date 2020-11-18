Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C499B2B836C
	for <lists+linux-fpga@lfdr.de>; Wed, 18 Nov 2020 18:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgKRRzM (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 18 Nov 2020 12:55:12 -0500
Received: from mga11.intel.com ([192.55.52.93]:54544 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725822AbgKRRzM (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 18 Nov 2020 12:55:12 -0500
IronPort-SDR: 7Mv/Yn38UvRQ8KRG396fpP7R4DkN07DavvwHQDdyYFMjD/XbPfpo9qkINUymEGekIK1ZI+d9RH
 0mxx7zVRG9BQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9809"; a="167647891"
X-IronPort-AV: E=Sophos;i="5.77,488,1596524400"; 
   d="scan'208";a="167647891"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2020 09:55:11 -0800
IronPort-SDR: A5VeSJnIRUs3Iu1CA37zWlEeXwPm7btFNbSL2hyrERlSDqHvOhGgOFIcVjqVGXWaR8Z53gxktI
 vJrGhFwbuA6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,488,1596524400"; 
   d="scan'208";a="532816133"
Received: from marshy.an.intel.com (HELO [10.122.105.143]) ([10.122.105.143])
  by fmsmga006.fm.intel.com with ESMTP; 18 Nov 2020 09:55:10 -0800
From:   Richard Gong <richard.gong@linux.intel.com>
Subject: Re: [PATCHv2 1/5] firmware: stratix10-svc: add
 COMMAND_AUTHENTICATE_BITSTREAM flag
To:     Moritz Fischer <mdf@kernel.org>
Cc:     gregkh@linuxfoundation.org, trix@redhat.com,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        dinguyen@kernel.org, sridhar.rajagopal@intel.com,
        richard.gong@intel.com
References: <1605709753-7800-1-git-send-email-richard.gong@linux.intel.com>
 <1605709753-7800-2-git-send-email-richard.gong@linux.intel.com>
 <X7U+BTkW7ZmsMByV@epycbox.lan>
Message-ID: <d8b58b40-63c6-115e-8e61-f092e3f050b3@linux.intel.com>
Date:   Wed, 18 Nov 2020 12:16:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <X7U+BTkW7ZmsMByV@epycbox.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


Hi Moritz,

On 11/18/20 9:30 AM, Moritz Fischer wrote:
> On Wed, Nov 18, 2020 at 08:29:09AM -0600, richard.gong@linux.intel.com wrote:
>> From: Richard Gong <richard.gong@intel.com>
>>
>> Add COMMAND_AUTHENTICATE_BITSTREAM command flag for new added bitstream
>> authentication feature. Authenticating a bistream is to make sure a signed
>> bitstream has the valid signatures.
>>
>> Except for the actual configuration of the device, the bitstream
>> authentication works the same way as FPGA configuration does. If the
>> authentication passes, the signed bitstream will be programmed into QSPI
>> flash memory and will be expected to boot without issues.
>>
>> Clean up COMMAND_RECONFIG_FLAG_PARTIAL flag by resetting it to 0, which
>> aligns with the firmware settings.
> 
> Should this be down with the v2: ?

I think the commit message should describe all the changes made in the 
patch, is it?

>>
>> Signed-off-by: Richard Gong <richard.gong@intel.com>
>> ---
>> v2: new added
>> ---
>>   include/linux/firmware/intel/stratix10-svc-client.h | 11 ++++++++---
>>   1 file changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/linux/firmware/intel/stratix10-svc-client.h b/include/linux/firmware/intel/stratix10-svc-client.h
>> index a93d859..85463c8 100644
>> --- a/include/linux/firmware/intel/stratix10-svc-client.h
>> +++ b/include/linux/firmware/intel/stratix10-svc-client.h
>> @@ -51,12 +51,17 @@
>>   #define SVC_STATUS_NO_SUPPORT		6
>>   
>>   /**
>> - * Flag bit for COMMAND_RECONFIG
>> + * Flag bit for COMMAND_RECONFIG, in bit number
>>    *
>>    * COMMAND_RECONFIG_FLAG_PARTIAL:
>> - * Set to FPGA configuration type (full or partial).
>> + * Set for partial FPGA configuration.
>> + *
>> + * COMMAND_AUTHENTICATE_BITSTREAM:
>> + * Set for bitstream authentication, which makes sure a signed bitstream
>> + * has valid signatures before committing it to QSPI flash memory.
>>    */
>> -#define COMMAND_RECONFIG_FLAG_PARTIAL	1
>> +#define COMMAND_RECONFIG_FLAG_PARTIAL	0
>> +#define COMMAND_AUTHENTICATE_BITSTREAM	1
> 
> Can you explain how this commit by itself doesn't break things?
> 
> Before this change firmware expected BIT(0) to be set for partial
> reconfiguration, now BIT(0) suddenly means authentication? How doest his
> work? :)
>  > Was there a firmware version change? Did this never work before?
> 
> If this is version depenedent for firmware, then this might need a
> different compatible string / id / some form of probing?
> 
> Entirely possible that I'm missing something, but it doesn't *seem*
> right.
>>   

It did work before.

Before this change, firmware only checks if the received flag value is 
zero. If the value is zero, it preforms full reconfiguration. Otherwise 
it does partial reconfiguration.

To support bitstream authentication feature, firmware is updated to 
check the received flag value as below:
	0	--- full reconfiguration
	BIT(0) 	--- partial reconfiguration
	BIT(1) 	--- bitstream authentication

Therefore I have updated the command flag setting at Intel service layer 
driver to align with firmware.

Regards,
Richard

>>   /**
>>    * Timeout settings for service clients:
>> -- 
>> 2.7.4
>>
> 
> Cheers,
> Moritz
> 

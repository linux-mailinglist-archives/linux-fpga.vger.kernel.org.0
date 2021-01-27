Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1BF305C01
	for <lists+linux-fpga@lfdr.de>; Wed, 27 Jan 2021 13:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbhA0Msx (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 27 Jan 2021 07:48:53 -0500
Received: from mga03.intel.com ([134.134.136.65]:1762 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234782AbhA0Mqn (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 27 Jan 2021 07:46:43 -0500
IronPort-SDR: UdQZReNievoMq2Ay0O8tvqMOr8ALMf4c1Q3iu2C4KxhSOyzSoFcC131KO6jo5BcrSRtj5l8fK4
 GuHwqui3wJFA==
X-IronPort-AV: E=McAfee;i="6000,8403,9876"; a="180140525"
X-IronPort-AV: E=Sophos;i="5.79,379,1602572400"; 
   d="scan'208";a="180140525"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 04:44:56 -0800
IronPort-SDR: UY66y7hlTgMWE7SAKaZ+FYqbWxrF5r0DuNU7oPyCc5tNnyCW+SQ6Jpfo8f6GMEIKa8I7+o9nXb
 nqItxCBoilBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,379,1602572400"; 
   d="scan'208";a="357054026"
Received: from marshy.an.intel.com (HELO [10.122.105.143]) ([10.122.105.143])
  by orsmga006.jf.intel.com with ESMTP; 27 Jan 2021 04:44:55 -0800
Subject: Re: [PATCHv3 1/6] firmware: stratix10-svc: add
 COMMAND_AUTHENTICATE_BITSTREAM flag
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     mdf@kernel.org, trix@redhat.com, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, dinguyen@kernel.org,
        sridhar.rajagopal@intel.com, Richard Gong <richard.gong@intel.com>
References: <1611608188-25621-1-git-send-email-richard.gong@linux.intel.com>
 <1611608188-25621-2-git-send-email-richard.gong@linux.intel.com>
 <YBFW50LPP/yEbvEW@kroah.com>
From:   Richard Gong <richard.gong@linux.intel.com>
Message-ID: <2f9d082b-9970-8f41-0351-324f1bad6cbf@linux.intel.com>
Date:   Wed, 27 Jan 2021 07:05:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YBFW50LPP/yEbvEW@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


Hi Greg,

Thanks for review!

On 1/27/21 6:04 AM, Greg KH wrote:
> On Mon, Jan 25, 2021 at 02:56:23PM -0600, richard.gong@linux.intel.com wrote:
>> From: Richard Gong <richard.gong@intel.com>
>>
>> Add COMMAND_AUTHENTICATE_BITSTREAM command flag for new added bitstream
>> authentication feature. Authenticating a bitstream is to make sure a signed
>> bitstream has the valid signatures.
>>
>> Except for the actual configuration of the device, the bitstream
>> authentication works the same way as FPGA configuration does. If the
>> authentication passes, the signed bitstream will be programmed into QSPI
>> flash memory and will be expected to boot without issues.
>>
>> Clean up COMMAND_RECONFIG_FLAG_PARTIAL flag by resetting it to 0, which
>> aligns with the firmware settings.
>>
>> Signed-off-by: Richard Gong <richard.gong@intel.com>
>> ---
>> v3: no change
>> v2: new added
>> ---
>>   include/linux/firmware/intel/stratix10-svc-client.h | 11 ++++++++---
>>   1 file changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/linux/firmware/intel/stratix10-svc-client.h b/include/linux/firmware/intel/stratix10-svc-client.h
>> index ebc2956..7ada1f2 100644
>> --- a/include/linux/firmware/intel/stratix10-svc-client.h
>> +++ b/include/linux/firmware/intel/stratix10-svc-client.h
>> @@ -51,12 +51,17 @@
>>   #define SVC_STATUS_NO_SUPPORT		6
>>   
>>   /*
>> - * Flag bit for COMMAND_RECONFIG
>> + * Flag for COMMAND_RECONFIG, in bit number
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
> 
> So is this a bugfix, changing this value to the correct one?

Yes, it is a bug fix.
> 
> If so, shouldn't this be a stand-alone patch and get backported to
> stable kernel releases?

Sure, I will make change and submit again as a standalone patch.

> 
> If not, then no one uses this flag today?
> 
> thanks,
> 
> greg k-h
> 
Regards,
Richard

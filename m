Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B998D306757
	for <lists+linux-fpga@lfdr.de>; Thu, 28 Jan 2021 00:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232410AbhA0W4h (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 27 Jan 2021 17:56:37 -0500
Received: from mga09.intel.com ([134.134.136.24]:35355 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232054AbhA0W4L (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 27 Jan 2021 17:56:11 -0500
IronPort-SDR: GVbOi88v1N5FelZSRIfuuuqE62v+dgXfNUNLdL23hlVAPr8IY0D0JQUJeFIqDBQd74ICIo9xOJ
 SNrY+jkL/QGQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9877"; a="180289598"
X-IronPort-AV: E=Sophos;i="5.79,380,1602572400"; 
   d="scan'208";a="180289598"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 14:41:53 -0800
IronPort-SDR: lozf7SQPhkpLAZiaAsurwpg9Jes5vfROVmpbrG8hPclCe57e6zsCH47X6++wFHQvNnQJ6SUjQ6
 GLkojqFZjdGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,380,1602572400"; 
   d="scan'208";a="357213129"
Received: from marshy.an.intel.com (HELO [10.122.105.143]) ([10.122.105.143])
  by orsmga006.jf.intel.com with ESMTP; 27 Jan 2021 14:41:51 -0800
Subject: Re: [PATCHv3 1/6] firmware: stratix10-svc: add
 COMMAND_AUTHENTICATE_BITSTREAM flag
To:     Moritz Fischer <mdf@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>, trix@redhat.com,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        dinguyen@kernel.org, sridhar.rajagopal@intel.com,
        Richard Gong <richard.gong@intel.com>
References: <1611608188-25621-1-git-send-email-richard.gong@linux.intel.com>
 <1611608188-25621-2-git-send-email-richard.gong@linux.intel.com>
 <YBFW50LPP/yEbvEW@kroah.com>
 <2f9d082b-9970-8f41-0351-324f1bad6cbf@linux.intel.com>
 <YBHeDF7p8QKu83tP@epycbox.lan>
From:   Richard Gong <richard.gong@linux.intel.com>
Message-ID: <2d2271ca-6e6a-c8e1-6a7a-4e32d9c05d73@linux.intel.com>
Date:   Wed, 27 Jan 2021 17:02:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YBHeDF7p8QKu83tP@epycbox.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


Hi Moritz,

Sorry for the confusion.

On 1/27/21 3:41 PM, Moritz Fischer wrote:
> On Wed, Jan 27, 2021 at 07:05:41AM -0600, Richard Gong wrote:
>>
>> Hi Greg,
>>
>> Thanks for review!
>>
>> On 1/27/21 6:04 AM, Greg KH wrote:
>>> On Mon, Jan 25, 2021 at 02:56:23PM -0600, richard.gong@linux.intel.com wrote:
>>>> From: Richard Gong <richard.gong@intel.com>
>>>>
>>>> Add COMMAND_AUTHENTICATE_BITSTREAM command flag for new added bitstream
>>>> authentication feature. Authenticating a bitstream is to make sure a signed
>>>> bitstream has the valid signatures.
>>>>
>>>> Except for the actual configuration of the device, the bitstream
>>>> authentication works the same way as FPGA configuration does. If the
>>>> authentication passes, the signed bitstream will be programmed into QSPI
>>>> flash memory and will be expected to boot without issues.
>>>>
>>>> Clean up COMMAND_RECONFIG_FLAG_PARTIAL flag by resetting it to 0, which
>>>> aligns with the firmware settings.
>>>>
>>>> Signed-off-by: Richard Gong <richard.gong@intel.com>
>>>> ---
>>>> v3: no change
>>>> v2: new added
>>>> ---
>>>>    include/linux/firmware/intel/stratix10-svc-client.h | 11 ++++++++---
>>>>    1 file changed, 8 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/include/linux/firmware/intel/stratix10-svc-client.h b/include/linux/firmware/intel/stratix10-svc-client.h
>>>> index ebc2956..7ada1f2 100644
>>>> --- a/include/linux/firmware/intel/stratix10-svc-client.h
>>>> +++ b/include/linux/firmware/intel/stratix10-svc-client.h
>>>> @@ -51,12 +51,17 @@
>>>>    #define SVC_STATUS_NO_SUPPORT		6
>>>>    /*
>>>> - * Flag bit for COMMAND_RECONFIG
>>>> + * Flag for COMMAND_RECONFIG, in bit number
>>>>     *
>>>>     * COMMAND_RECONFIG_FLAG_PARTIAL:
>>>> - * Set to FPGA configuration type (full or partial).
>>>> + * Set for partial FPGA configuration.
>>>> + *
>>>> + * COMMAND_AUTHENTICATE_BITSTREAM:
>>>> + * Set for bitstream authentication, which makes sure a signed bitstream
>>>> + * has valid signatures before committing it to QSPI flash memory.
>>>>     */
>>>> -#define COMMAND_RECONFIG_FLAG_PARTIAL	1
>>>> +#define COMMAND_RECONFIG_FLAG_PARTIAL	0
>>>
>>> So is this a bugfix, changing this value to the correct one?
>>
>> Yes, it is a bug fix.
> Wat? This is a change in interface spec with the firmware. I thought the
> whole point of the firmware version SVC call was to prevent breaking old
> firmware?
> 
> Didn't we discuss this earlier?
> 

We discussed before and I thought we were all aligned.

There are 2 aspects:
1. The purpose I changed COMMAND_RECONFIG_FLAG_PARTIAL to 0 from 1 is to 
align with the current firmware setting. This change will NOT break old 
firmware since always treats request with non-zero value as partial 
reconfiguration.

2. When we add new bitstream authentication function, the old firmware 
couldn't distinguish partial reconfiguration or bitstream authentication 
since the value of both requests were not zero. To address this back 
compatible issue, I extend Intel service layer driver for FPGA manager 
driver to get the running firmware version via SMC call. Then FPGA 
manager driver can decide whether to handle the newly added bitstream 
authentication based on the retrieved firmware version.

>>>
>>> If so, shouldn't this be a stand-alone patch and get backported to
>>> stable kernel releases?
>>
>> Sure, I will make change and submit again as a standalone patch.
>>
>>>
>>> If not, then no one uses this flag today?
>>>
>>> thanks,
>>>
>>> greg k-h
>>>
>> Regards,
>> Richard
> 
> - Moritz
> 
Regards,
Richard

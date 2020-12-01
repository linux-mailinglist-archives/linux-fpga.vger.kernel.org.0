Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2EA22CAB7C
	for <lists+linux-fpga@lfdr.de>; Tue,  1 Dec 2020 20:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730213AbgLATLT (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 1 Dec 2020 14:11:19 -0500
Received: from mga17.intel.com ([192.55.52.151]:2546 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731248AbgLATLT (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 1 Dec 2020 14:11:19 -0500
IronPort-SDR: htJPhwuBw5+0xOFLP7qpOmJhLiYAxEBe0si/kfT5LtFVcilS10OqEoNBUU/rm6rDouLQmXPG0O
 85QI5xtycSrQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9822"; a="152718780"
X-IronPort-AV: E=Sophos;i="5.78,385,1599548400"; 
   d="scan'208";a="152718780"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2020 11:09:31 -0800
IronPort-SDR: btcYYaIT38WOT1WsfHcisBpaR8qvgMFNa1ubGn8s8TajCwcM/fu2mAfFebHEmcmtg5m5BEAOtI
 jb8nNn7Cp+Tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,385,1599548400"; 
   d="scan'208";a="537645085"
Received: from marshy.an.intel.com (HELO [10.122.105.143]) ([10.122.105.143])
  by fmsmga006.fm.intel.com with ESMTP; 01 Dec 2020 11:09:31 -0800
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
 <d8b58b40-63c6-115e-8e61-f092e3f050b3@linux.intel.com>
 <X7m6gy/B8DiafyYQ@archbook>
 <771ba4f4-59e1-74b0-ba55-3f65914e2bc7@linux.intel.com>
 <X8XHJimPDaE/lNx0@archbook>
From:   Richard Gong <richard.gong@linux.intel.com>
Message-ID: <e67a2abe-2c97-fe1c-9dc7-100b8a20381b@linux.intel.com>
Date:   Tue, 1 Dec 2020 13:30:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <X8XHJimPDaE/lNx0@archbook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


Hi Moritz,

On 11/30/20 10:31 PM, Moritz Fischer wrote:
> Hi Richard,
> 
> On Mon, Nov 30, 2020 at 12:55:44PM -0600, Richard Gong wrote:
>>
>> Hi Moritz,
>>
>> Sorry for late reply, I was out last week.
> 
> No worries, usually I'm late with replies ;-)
>>
>> On 11/21/20 7:10 PM, Moritz Fischer wrote:
>>> Richard,
>>>
>>> On Wed, Nov 18, 2020 at 12:16:09PM -0600, Richard Gong wrote:
>>>
>>>>>> -#define COMMAND_RECONFIG_FLAG_PARTIAL	1
>>>>>> +#define COMMAND_RECONFIG_FLAG_PARTIAL	0
>>>>>> +#define COMMAND_AUTHENTICATE_BITSTREAM	1
>>>>>
>>>>> Can you explain how this commit by itself doesn't break things?
>>>>>
>>>>> Before this change firmware expected BIT(0) to be set for partial
>>>>> reconfiguration, now BIT(0) suddenly means authentication? How doest his
>>>>> work? :)
>>>>>    > Was there a firmware version change? Did this never work before?
>>>>>
>>>>> If this is version depenedent for firmware, then this might need a
>>>>> different compatible string / id / some form of probing?
>>>>>
>>>>> Entirely possible that I'm missing something, but it doesn't *seem*
>>>>> right.
>>>>
>>>> It did work before.
>>>>
>>>> Before this change, firmware only checks if the received flag value is zero.
>>>> If the value is zero, it preforms full reconfiguration. Otherwise it does
>>>> partial reconfiguration.
>>>>
>>>> To support bitstream authentication feature, firmware is updated to check
>>>> the received flag value as below:
>>>> 	0	--- full reconfiguration
>>>> 	BIT(0) 	--- partial reconfiguration
>>>> 	BIT(1) 	--- bitstream authentication
>>>
>>> So there are two different versions of firmware involved that behave
>>> differently?
>>>
>>> Old firmware:
>>> - ctype.flags  = 0x0 -> Full reconfig
>>> - ctype.flags != 0 -> Partial reconfig
>>>
>>> New firmware:
>>> - ctype.flags = 0x0 -> Full reconfig
>>> - ctype.flags = 0x1 -> Partial reconfig
>>> - ctype.flags = 0x2 -> Authenticate
>>>
>>> Old software:
>>> - Send 0x0 for Full
>>> - Send 0x1 for Partial
>>>
>>> New software:
>>> - Send 0x0 for Full
>>> - Send 0x1 for Partial
>>> - Send 0x2 for Auth
>>>
>>> If I send request for authentication BIT(1) (new software) to old
>>> firmware it'd try and attempt a partial reconfiguration with the data I
>>> send? Is that safe?
>>>
>>
>> Yes, it is possible and it is not safe. But we will inform our customers
>> they should update to the latest firmware (SDM firmware and ATF) if they
>> want to have authentication feature.
>>
>> We are migrating boot loader boot flow to the new ATF boot flow, which is
>> SDM firmware -> SPL -> ATF -> U-boot proper -> Linux. The new authentication
>> feature is supported only in the new ATF boot flow. ATF communicates with
>> SDM firmware via mailbox, and SDM firmware performs the actual full/partial
>> reconfiguration and bitstream authentication. ATF sets up EL3 environment
>> and initializes PSCI services.
> 
> Can U-Boot determine whether it's the new or old flow? Can you set a
> different compatible value in your device-tree, to disambiguate
> behaviors?
> 

The boot flow is determined by defconfig during compilation, which means 
each boot flow will have its own defconfig.

SDM firmware loads SPL into OCRAM, then SPL will load the apporiate ATF 
or U-boot into the DRAM according to the setting of CONFIG_SPL_ATF. If 
CONFIG_SPL_ATF=y, SPL loads ATF and then jumps to ATF. ATF setups EL3 
environment and initialize the PSCI services.

CONFIG_SPL_ATF is not set for the old boot flow.

>> The old boot flow is SDM firmware -> SPL -> U-boot proper -> Linux, which
>> SPL/U-boot handles PSCI services and communicates with SDM firmware via
>> mailbox. SDM firmware performs the actual full/partial reconfiguration.
>>
>> ATF = Arm Trust Firmware, SDM = Secure Device Manager
>>
>>> Is there a way for software to figure out the firmware version and do
>>> the right thing?
>>
>> It is not feasible for kernel driver to get the firmware version per current
>> designs and implementations. I don't think there is other way around this.
>>
>>>
>>>> Therefore I have updated the command flag setting at Intel service layer
>>>> driver to align with firmware.
>>>>
>>>> Regards,
>>>> Richard
>>>>
>>>>>>     /**
>>>>>>      * Timeout settings for service clients:
>>>>>> -- 
>>>>>> 2.7.4
>>>>>>
>>>>>
>>>>> Cheers,
>>>>> Moritz
>>>>>
>>>
>>> Thanks,
>>> Moritz
>>>
>> Regards,
>> Richard
> 
> Thanks,
> Moritz
> 
Regards,
Richard

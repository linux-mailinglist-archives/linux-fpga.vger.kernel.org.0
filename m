Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6805F2C8CEE
	for <lists+linux-fpga@lfdr.de>; Mon, 30 Nov 2020 19:37:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729647AbgK3Sgj (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 30 Nov 2020 13:36:39 -0500
Received: from mga06.intel.com ([134.134.136.31]:18345 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727952AbgK3Sgj (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 30 Nov 2020 13:36:39 -0500
IronPort-SDR: PWvcGSKmvorEao3Xj9sDAJn9Yf7OTM7Rd0Efl82M8axHN4WYqn/5urVdu9uLPWpOYd/b2F5cOD
 tQtWHNdertog==
X-IronPort-AV: E=McAfee;i="6000,8403,9821"; a="234293138"
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="234293138"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 10:34:58 -0800
IronPort-SDR: xX8pAokTZQ0by/OWyYuiZnRxDCsiivurak+f9Xio3lW5hHeX3PJBzd1v964Jp8IInY4mofl8d4
 qRQYh4IGYIMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="537100801"
Received: from marshy.an.intel.com (HELO [10.122.105.143]) ([10.122.105.143])
  by fmsmga006.fm.intel.com with ESMTP; 30 Nov 2020 10:34:57 -0800
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
From:   Richard Gong <richard.gong@linux.intel.com>
Message-ID: <771ba4f4-59e1-74b0-ba55-3f65914e2bc7@linux.intel.com>
Date:   Mon, 30 Nov 2020 12:55:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <X7m6gy/B8DiafyYQ@archbook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


Hi Moritz,

Sorry for late reply, I was out last week.

On 11/21/20 7:10 PM, Moritz Fischer wrote:
> Richard,
> 
> On Wed, Nov 18, 2020 at 12:16:09PM -0600, Richard Gong wrote:
> 
>>>> -#define COMMAND_RECONFIG_FLAG_PARTIAL	1
>>>> +#define COMMAND_RECONFIG_FLAG_PARTIAL	0
>>>> +#define COMMAND_AUTHENTICATE_BITSTREAM	1
>>>
>>> Can you explain how this commit by itself doesn't break things?
>>>
>>> Before this change firmware expected BIT(0) to be set for partial
>>> reconfiguration, now BIT(0) suddenly means authentication? How doest his
>>> work? :)
>>>   > Was there a firmware version change? Did this never work before?
>>>
>>> If this is version depenedent for firmware, then this might need a
>>> different compatible string / id / some form of probing?
>>>
>>> Entirely possible that I'm missing something, but it doesn't *seem*
>>> right.
>>
>> It did work before.
>>
>> Before this change, firmware only checks if the received flag value is zero.
>> If the value is zero, it preforms full reconfiguration. Otherwise it does
>> partial reconfiguration.
>>
>> To support bitstream authentication feature, firmware is updated to check
>> the received flag value as below:
>> 	0	--- full reconfiguration
>> 	BIT(0) 	--- partial reconfiguration
>> 	BIT(1) 	--- bitstream authentication
> 
> So there are two different versions of firmware involved that behave
> differently?
> 
> Old firmware:
> - ctype.flags  = 0x0 -> Full reconfig
> - ctype.flags != 0 -> Partial reconfig
> 
> New firmware:
> - ctype.flags = 0x0 -> Full reconfig
> - ctype.flags = 0x1 -> Partial reconfig
> - ctype.flags = 0x2 -> Authenticate
> 
> Old software:
> - Send 0x0 for Full
> - Send 0x1 for Partial
> 
> New software:
> - Send 0x0 for Full
> - Send 0x1 for Partial
> - Send 0x2 for Auth
> 
> If I send request for authentication BIT(1) (new software) to old
> firmware it'd try and attempt a partial reconfiguration with the data I
> send? Is that safe?
> 

Yes, it is possible and it is not safe. But we will inform our customers 
they should update to the latest firmware (SDM firmware and ATF) if they 
want to have authentication feature.

We are migrating boot loader boot flow to the new ATF boot flow, which 
is SDM firmware -> SPL -> ATF -> U-boot proper -> Linux. The new 
authentication feature is supported only in the new ATF boot flow. ATF 
communicates with SDM firmware via mailbox, and SDM firmware performs 
the actual full/partial reconfiguration and bitstream authentication. 
ATF sets up EL3 environment and initializes PSCI services.

The old boot flow is SDM firmware -> SPL -> U-boot proper -> Linux, 
which SPL/U-boot handles PSCI services and communicates with SDM 
firmware via mailbox. SDM firmware performs the actual full/partial 
reconfiguration.

ATF = Arm Trust Firmware, SDM = Secure Device Manager

> Is there a way for software to figure out the firmware version and do
> the right thing?

It is not feasible for kernel driver to get the firmware version per 
current designs and implementations. I don't think there is other way 
around this.

> 
>> Therefore I have updated the command flag setting at Intel service layer
>> driver to align with firmware.
>>
>> Regards,
>> Richard
>>
>>>>    /**
>>>>     * Timeout settings for service clients:
>>>> -- 
>>>> 2.7.4
>>>>
>>>
>>> Cheers,
>>> Moritz
>>>
> 
> Thanks,
> Moritz
> 
Regards,
Richard

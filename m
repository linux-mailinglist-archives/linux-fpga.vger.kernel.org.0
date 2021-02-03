Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDE530E635
	for <lists+linux-fpga@lfdr.de>; Wed,  3 Feb 2021 23:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbhBCWoJ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 3 Feb 2021 17:44:09 -0500
Received: from mga02.intel.com ([134.134.136.20]:23638 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232102AbhBCWoF (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 3 Feb 2021 17:44:05 -0500
IronPort-SDR: 0PiRG2fXlXiS4ZKs9tNDzCp4V3hcGhd52hwU70WRWyxKw2f0gOLKHYGkjXRvVr5HTbA5yDNAJW
 lFNgSDH7NftA==
X-IronPort-AV: E=McAfee;i="6000,8403,9884"; a="168240570"
X-IronPort-AV: E=Sophos;i="5.79,399,1602572400"; 
   d="scan'208";a="168240570"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 14:43:22 -0800
IronPort-SDR: sFoMAdrNkxTVXmy/YRxe75/aIh5a4ygS21WDWlN7PWYgLnzaGHo4OFTpw74NH6aCUuMp5uVl3i
 k0XagAOd1PbQ==
X-IronPort-AV: E=Sophos;i="5.79,399,1602572400"; 
   d="scan'208";a="396839883"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO [10.0.2.4]) ([10.212.187.111])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 14:43:21 -0800
Subject: Re: [PATCH v2 1/1] fpga: dfl: afu: harden port enable logic
To:     "Wu, Hao" <hao.wu@intel.com>, "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "trix@redhat.com" <trix@redhat.com>,
        "lgoncalv@redhat.com" <lgoncalv@redhat.com>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "Gerlach, Matthew" <matthew.gerlach@intel.com>
References: <20200917183219.3603-1-russell.h.weight@intel.com>
 <DM6PR11MB38194BD85854B598F1CD97C5853F0@DM6PR11MB3819.namprd11.prod.outlook.com>
 <8ab0e288-97f0-d167-50f0-624e05d77944@intel.com>
 <DM6PR11MB3819BC4BFE16A9CBE185EB1185B49@DM6PR11MB3819.namprd11.prod.outlook.com>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <25ada056-e591-4a6d-2e0e-704b099d00bf@intel.com>
Date:   Wed, 3 Feb 2021 14:43:19 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <DM6PR11MB3819BC4BFE16A9CBE185EB1185B49@DM6PR11MB3819.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 2/3/21 1:28 AM, Wu, Hao wrote:
>> Subject: Re: [PATCH v2 1/1] fpga: dfl: afu: harden port enable logic
>>
>> Sorry for the delay on this patch. It seemed like a lower priority patch than
>> others, since we haven't seen any issues with current products. Please my
>> responses inline.
>>
>> On 9/17/20 7:08 PM, Wu, Hao wrote:
>>>> -----Original Message-----
>>>> From: Russ Weight <russell.h.weight@intel.com>
>>>> Sent: Friday, September 18, 2020 2:32 AM
>>>> To: mdf@kernel.org; linux-fpga@vger.kernel.org; linux-
>>>> kernel@vger.kernel.org
>>>> Cc: trix@redhat.com; lgoncalv@redhat.com; Xu, Yilun <yilun.xu@intel.com>;
>>>> Wu, Hao <hao.wu@intel.com>; Gerlach, Matthew
>>>> <matthew.gerlach@intel.com>; Weight, Russell H
>>>> <russell.h.weight@intel.com>
>>>> Subject: [PATCH v2 1/1] fpga: dfl: afu: harden port enable logic
>>>>
>>>> Port enable is not complete until ACK = 0. Change
>>>> __afu_port_enable() to guarantee that the enable process
>>>> is complete by polling for ACK == 0.
>>> The description of this port reset ack bit is
>>>
>>> " After initiating a Port soft reset, SW should monitor this bit. HW
>>> will set this bit when all outstanding requests initiated by this port
>>> have been drained, and the minimum soft reset pulse width has
>>> elapsed. "
>>>
>>> But no description about what to do when clearing a Port soft reset
>>> to enable the port.
>>>
>>> So we need to understand clearly on why we need this change
>>> (e.g. what may happen without this change), and will it apply for all
>>> existing DFL devices and future ones, or just for one specific card.
>>> Could you please help? : )
>> I touched bases with the hardware engineers. The recommendation to wait
>> for ACK to be cleared is new with OFS and is documented in the latest
>> OFS specification as follows (see step #4):
>>
>>> 3.7.1 AFU Soft Resets
>>> Software may cause a soft reset to be issued to the AFU as follows:
>>> 1. Assert the PortSoftReset field of the PORT_CONTROL register
>>> 2. Wait for the Port to acknowledge the soft reset by monitoring the
>>> PortSoftResetAck field of the PORT_CONTROL register, i.e.
>> PortSoftResetAck=1
>>> 3. Deasserting the PortSoftReset field
>>> 4. Wait for the Port to acknowledge the soft reset de-assertion by monitoring
>> the
>>> PortSoftResetAck field of the PORT_CONTROL register, i.e.
>> PortSoftResetAck=0
>>> This sequence ensures that outstanding transactions are suitably flushed and
>>> that the FIM minimum reset pulse width is respected. Failing to follow this
>>> sequence leaves the AFU in an undefined state.
>> The OFS specification has not been posted publicly, yet.
>>
>> Also, this is how it was explained to me:
>>
>>> In most scenario, port will be able to get out of reset soon enough
>>> when SW releases the port reset, especially on all the PAC products
>>> which have been verified before release.
>>>
>>> Polling for HW to clear the ACK is meant to handle the following scenarios:
>>>
>>>   * Different platform can take variable period of time to get out of reset
>>>   * Bug in the HW that hold the port in reset
>> So this change is not required for the currently released PAC cards,
>> but it is needed for OFS based products. I don't think there is any reason
>> to hold off on the patch, as it is still valid for current products.
> As you know, this driver is used for different cards, and we need to make
> sure new changes introduced in new version spec, don't break old products
> as we are sharing the same driver. and we are not sure if in the future some
> new products but still uses old specs, and then things may be broken if the
> driver which always perform new flow. Another method is that introduce 1
> bit in hardware register to tell the driver to perform the additional steps,
> then it can avoid impacts to the old products. If this can't be done, then
> we at least need to verify this change on all existing hardware and suggest
> users to follow new spec only.

According to the HW engineers, the RTL implementation has not changed; it is
the same as the RTL in the current PAC products. Polling for HW to clear the
ACK is something we could have (should have?) been doing all along. The timing
hasn't been an issue for the current PAC products, as proven by our testing.
However, with OFS we cannot anticipate what the timing will be for customer
designed products, so the specification is calling out this requirement as a
precaution.

I am using a development machine that has the older PAC devices installed. I
cleared port errors on these cards as a quick check, and the reset completes
without hanging - which indicates that the ACK bit is in fact getting cleared.
So there is not need for any device-specific conditional statements here.

- Russ

>
> Hao


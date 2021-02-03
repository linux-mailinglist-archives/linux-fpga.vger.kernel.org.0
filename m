Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA09130E6D3
	for <lists+linux-fpga@lfdr.de>; Thu,  4 Feb 2021 00:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233568AbhBCXKl (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 3 Feb 2021 18:10:41 -0500
Received: from mga04.intel.com ([192.55.52.120]:38359 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232102AbhBCXHx (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 3 Feb 2021 18:07:53 -0500
IronPort-SDR: VRbjoZM4SWPxKdjU9oTlFQqVdFz4l0xoOMwzc6usmWX0GoQ6MujgL0kZC1syX8ft71M0Md1JyB
 ZMOvIsknbJgw==
X-IronPort-AV: E=McAfee;i="6000,8403,9884"; a="178573104"
X-IronPort-AV: E=Sophos;i="5.79,399,1602572400"; 
   d="scan'208";a="178573104"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 15:06:00 -0800
IronPort-SDR: e0VUiffLUVOp7XfLHnHvDWphV6pFAQIRDgTUONfkaeLvn2AlPZe+ytShYOtermtOoY7E8VSXO2
 ii2Gnsrq9Low==
X-IronPort-AV: E=Sophos;i="5.79,399,1602572400"; 
   d="scan'208";a="414564275"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.42])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 15:05:59 -0800
Date:   Wed, 3 Feb 2021 15:07:17 -0800 (PST)
From:   matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@rhweight-WRK1
To:     Russ Weight <russell.h.weight@intel.com>
cc:     "Wu, Hao" <hao.wu@intel.com>, "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "trix@redhat.com" <trix@redhat.com>,
        "lgoncalv@redhat.com" <lgoncalv@redhat.com>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "Gerlach, Matthew" <matthew.gerlach@intel.com>
Subject: Re: [PATCH v2 1/1] fpga: dfl: afu: harden port enable logic
In-Reply-To: <25ada056-e591-4a6d-2e0e-704b099d00bf@intel.com>
Message-ID: <alpine.DEB.2.22.394.2102031504300.1186805@rhweight-WRK1>
References: <20200917183219.3603-1-russell.h.weight@intel.com> <DM6PR11MB38194BD85854B598F1CD97C5853F0@DM6PR11MB3819.namprd11.prod.outlook.com> <8ab0e288-97f0-d167-50f0-624e05d77944@intel.com> <DM6PR11MB3819BC4BFE16A9CBE185EB1185B49@DM6PR11MB3819.namprd11.prod.outlook.com>
 <25ada056-e591-4a6d-2e0e-704b099d00bf@intel.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On Wed, 3 Feb 2021, Russ Weight wrote:

>
>
> On 2/3/21 1:28 AM, Wu, Hao wrote:
>>> Subject: Re: [PATCH v2 1/1] fpga: dfl: afu: harden port enable logic
>>>
>>> Sorry for the delay on this patch. It seemed like a lower priority patch than
>>> others, since we haven't seen any issues with current products. Please my
>>> responses inline.
>>>
>>> On 9/17/20 7:08 PM, Wu, Hao wrote:
>>>>> -----Original Message-----
>>>>> From: Russ Weight <russell.h.weight@intel.com>
>>>>> Sent: Friday, September 18, 2020 2:32 AM
>>>>> To: mdf@kernel.org; linux-fpga@vger.kernel.org; linux-
>>>>> kernel@vger.kernel.org
>>>>> Cc: trix@redhat.com; lgoncalv@redhat.com; Xu, Yilun <yilun.xu@intel.com>;
>>>>> Wu, Hao <hao.wu@intel.com>; Gerlach, Matthew
>>>>> <matthew.gerlach@intel.com>; Weight, Russell H
>>>>> <russell.h.weight@intel.com>
>>>>> Subject: [PATCH v2 1/1] fpga: dfl: afu: harden port enable logic
>>>>>
>>>>> Port enable is not complete until ACK = 0. Change
>>>>> __afu_port_enable() to guarantee that the enable process
>>>>> is complete by polling for ACK == 0.
>>>> The description of this port reset ack bit is
>>>>
>>>> " After initiating a Port soft reset, SW should monitor this bit. HW
>>>> will set this bit when all outstanding requests initiated by this port
>>>> have been drained, and the minimum soft reset pulse width has
>>>> elapsed. "
>>>>
>>>> But no description about what to do when clearing a Port soft reset
>>>> to enable the port.
>>>>
>>>> So we need to understand clearly on why we need this change
>>>> (e.g. what may happen without this change), and will it apply for all
>>>> existing DFL devices and future ones, or just for one specific card.
>>>> Could you please help? : )
>>> I touched bases with the hardware engineers. The recommendation to wait
>>> for ACK to be cleared is new with OFS and is documented in the latest
>>> OFS specification as follows (see step #4):
>>>
>>>> 3.7.1 AFU Soft Resets
>>>> Software may cause a soft reset to be issued to the AFU as follows:
>>>> 1. Assert the PortSoftReset field of the PORT_CONTROL register
>>>> 2. Wait for the Port to acknowledge the soft reset by monitoring the
>>>> PortSoftResetAck field of the PORT_CONTROL register, i.e.
>>> PortSoftResetAck=1
>>>> 3. Deasserting the PortSoftReset field
>>>> 4. Wait for the Port to acknowledge the soft reset de-assertion by monitoring
>>> the
>>>> PortSoftResetAck field of the PORT_CONTROL register, i.e.
>>> PortSoftResetAck=0
>>>> This sequence ensures that outstanding transactions are suitably flushed and
>>>> that the FIM minimum reset pulse width is respected. Failing to follow this
>>>> sequence leaves the AFU in an undefined state.
>>> The OFS specification has not been posted publicly, yet.
>>>
>>> Also, this is how it was explained to me:
>>>
>>>> In most scenario, port will be able to get out of reset soon enough
>>>> when SW releases the port reset, especially on all the PAC products
>>>> which have been verified before release.
>>>>
>>>> Polling for HW to clear the ACK is meant to handle the following scenarios:
>>>>
>>>>   * Different platform can take variable period of time to get out of reset
>>>>   * Bug in the HW that hold the port in reset
>>> So this change is not required for the currently released PAC cards,
>>> but it is needed for OFS based products. I don't think there is any reason
>>> to hold off on the patch, as it is still valid for current products.
>> As you know, this driver is used for different cards, and we need to make
>> sure new changes introduced in new version spec, don't break old products
>> as we are sharing the same driver. and we are not sure if in the future some
>> new products but still uses old specs, and then things may be broken if the
>> driver which always perform new flow. Another method is that introduce 1
>> bit in hardware register to tell the driver to perform the additional steps,
>> then it can avoid impacts to the old products. If this can't be done, then
>> we at least need to verify this change on all existing hardware and suggest
>> users to follow new spec only.
>
> According to the HW engineers, the RTL implementation has not changed; it is
> the same as the RTL in the current PAC products. Polling for HW to clear the
> ACK is something we could have (should have?) been doing all along. The timing

I also confirmed with HW engineers.  The original specification was 
not precise.  The code should have been doing this all along.

Matthew Gerlach

> hasn't been an issue for the current PAC products, as proven by our testing.
> However, with OFS we cannot anticipate what the timing will be for customer
> designed products, so the specification is calling out this requirement as a
> precaution.
>
> I am using a development machine that has the older PAC devices installed. I
> cleared port errors on these cards as a quick check, and the reset completes
> without hanging - which indicates that the ACK bit is in fact getting cleared.
> So there is not need for any device-specific conditional statements here.
>
> - Russ
>
>>
>> Hao
>
>

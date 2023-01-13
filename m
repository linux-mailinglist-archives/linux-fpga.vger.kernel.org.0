Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73A3366A2A7
	for <lists+linux-fpga@lfdr.de>; Fri, 13 Jan 2023 20:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbjAMTEl (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 13 Jan 2023 14:04:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjAMTEh (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 13 Jan 2023 14:04:37 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF275D405;
        Fri, 13 Jan 2023 11:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673636675; x=1705172675;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=7H+c/VpvYq+UNviR3pZvrval0VSjRocGl0CoGfUil34=;
  b=C0o1aB1oAn4OOPHwn4gNgvtYoIrLiXimPQFAr4eMxydLt5Uk/wDJfzS7
   koXxv8S5rmP7YLXRSg7hUoQx2DVbHeAClK//t9s670ld2P0QfPDKGfINx
   th/1NhFGjMt6uyiYoaIqWz4qJWTDdetT+MOSJjakXJWyI9WTC0IMB/IYN
   8PAlb4SLXnsEWAgdO802xM9998hzCK+/57xEw/ZZc6rpTc06hpshNhmIX
   It3tnY1/Q87teUBs6FZlp3ktSU0RNscnW2SE1K/eZlBYUNSL1ao7/vI60
   nj/TWLeE1Vi7B85ntYxos40fdVuWHc609SO0N9diut9rM4WsAtQ8Pmeu5
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="325332256"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="325332256"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 11:04:33 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="635873047"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="635873047"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.43])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 11:04:33 -0800
Date:   Fri, 13 Jan 2023 11:05:06 -0800 (PST)
From:   matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@rhweight-WRK1
To:     Xu Yilun <yilun.xu@intel.com>
cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        hao.wu@intel.com, russell.h.weight@intel.com,
        basheer.ahmed.muddebihal@intel.com, trix@redhat.com,
        mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tianfei.zhang@intel.com, corbet@lwn.net,
        gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        jirislaby@kernel.org, geert+renesas@glider.be,
        niklas.soderlund+renesas@ragnatech.se, macro@orcam.me.uk,
        johan@kernel.org, lukas@wunner.de, ilpo.jarvinen@linux.intel.com,
        marpagan@redhat.com, bagasdotme@gmail.com
Subject: Re: [PATCH v10 3/4] fpga: dfl: add basic support for DFHv1
In-Reply-To: <Y8DAb3R3bP/M7f0v@yilunxu-OptiPlex-7050>
Message-ID: <alpine.DEB.2.22.394.2301131056020.1326035@rhweight-WRK1>
References: <20230110003029.806022-1-matthew.gerlach@linux.intel.com> <20230110003029.806022-4-matthew.gerlach@linux.intel.com> <Y708L2rRc1RDVkui@smile.fi.intel.com> <alpine.DEB.2.22.394.2301101310150.815911@rhweight-WRK1> <Y74bSzUBLYH4cLDh@yilunxu-OptiPlex-7050>
 <Y7/ggajPS2WNrPPU@smile.fi.intel.com> <alpine.DEB.2.22.394.2301120732500.845139@rhweight-WRK1> <Y8DAb3R3bP/M7f0v@yilunxu-OptiPlex-7050>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On Fri, 13 Jan 2023, Xu Yilun wrote:

> On 2023-01-12 at 07:36:29 -0800, matthew.gerlach@linux.intel.com wrote:
>>
>>
>> On Thu, 12 Jan 2023, Andy Shevchenko wrote:
>>
>>> On Wed, Jan 11, 2023 at 10:13:31AM +0800, Xu Yilun wrote:
>>>> On 2023-01-10 at 14:07:16 -0800, matthew.gerlach@linux.intel.com wrote:
>>>>> On Tue, 10 Jan 2023, Andy Shevchenko wrote:
>>>>>> On Mon, Jan 09, 2023 at 04:30:28PM -0800, matthew.gerlach@linux.intel.com wrote:
>>>>>>> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>>
>>> ...
>>>
>>>>>>> v10: change dfh_find_param to return size of parameter data in bytes
>>>>>>
>>>>>> The problem that might occur with this approach is byte ordering.
>>>>>> When we have u64 items, we know that they all are placed in CPU
>>>>>> ordering by the bottom layer. What's the contract now? Can it be
>>>>>> a problematic? Please double check this (always keep in mind BE32
>>>>>> as most interesting case for u64/unsigned long representation and
>>>>>> other possible byte ordering outcomes).
>>>>>
>>>>> A number of u64 items certainly states explicit alignment of the memory, but
>>>>> I think byte ordering is a different issue.
>>>>>
>>>>> The bottom layer, by design, is still enforcing a number u64 items under the
>>>>> hood. So the contract has not changed. Changing units of size from u64s to
>>>>> bytes was suggested to match the general practice of size of memory being in
>>>>> bytes. I think the suggestion was made because the return type for
>>>>> dfh_find_param() changed from u64* to void* in version 9, when indirectly
>>>>> returning the size of the parameter data was introduced.  So a void * with a
>>>>> size in bytes makes sense. On the other hand, returning a u64 * is a more
>>>>> precise reflection of the data alignment. I think the API should be as
>>>>
>>>> I prefer (void *) + bytes. The properties in the parameter block are not
>>>> guarateed to be u64 for each, e.g. the REG_LAYOUT, so (void *) could better
>>>> indicate it is not. It is just a block of data unknown to DFL core and to
>>>> be parsed by drivers.
>>>
>>> If the hardware / protocol is capable of communicating the arbitrary lengths
>>> of parameters, then yes, bytes make sense. But this should be clear what byte
>>> ordering is there if the items can be words / dwords / qwords.
>>
>> The hardware does communicate the arbitrary lengths of the parameter data;
>> so bytes make sense.  I will update Documentation/fpga/dfl.rst to explicitly
>> say that multi-byte quantities are little-endian.
>>
>>>
>>> TL;DR: The Q is: Is the parameter block a byte stream? If yes, then your
>>> proposal is okay. If no, no void * should be used. In the latter it should
>>> be union of possible items or a like as defined by a protocol.
>>
>> The parameter block is not a byte stream; so void * should be used.
>
> Mm.. I think Andy's idea is, if the parameter block is not a byte stream,
> void * should NOT be used.
>
> My understanding is, The parameter block is not a byte stream in HW, it is
> some items (or properties) of various lengths. They are compacted in the
> parameter block. But the layout is not generally defined, each parameter
> block could have its own layout.

Your understanding is correct that the parameter block is a set of items 
(or properties) of variouse lengths in HW. The parameter blocks are 
comparable to PCI capabilities in PCI config space. Each capability has its own 
defined stucture.

>
> The definition and layout of the parameter block is specific to each device,
> that is, people design the parameter block for the device when they design
> the device. So DFL core doesn't try to generalize all the layouts, they
> are unlimited. DFL core just see it as a block of untouched data to be parsed
> by each driver. So from DFL core's perspective, it is a byte stream.

Yes, from the DFL core's perspective, the parameter blocks are opaque 
chunks of data. This would affirm your preference of using (void *) and 
byte size in the API for the function, dfh_find_param.

Thanks,
Matthew Gerlach

> Thanks,
> Yilun
>
>>
>> Thanks,
>> Matthew Gerlach
>>
>>
>>>
>>>> And why users/drivers need to care about the alignment of the parameter
>>>> block?
>>>>
>>>>> follows:
>>>
>>> --
>>> With Best Regards,
>>> Andy Shevchenko
>>>
>>>
>>>
>

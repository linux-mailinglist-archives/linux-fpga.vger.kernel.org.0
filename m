Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B939667A1B
	for <lists+linux-fpga@lfdr.de>; Thu, 12 Jan 2023 16:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239863AbjALP5K (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 12 Jan 2023 10:57:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjALP4Z (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 12 Jan 2023 10:56:25 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB59A5A8B1;
        Thu, 12 Jan 2023 07:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673538398; x=1705074398;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=rZdVhyovnZwLRgUV7awB0Pfol4ouRAVFDTvxApxMr2g=;
  b=IowAaLT+HC1pWN9l9MSwt5jVGt4xIqpIyXQtoR0NSkZM8rwd9zDvCvjf
   AYvmg6X5DxIZRuVDi1KoKxZ9vOpyH/wHE/HPCDcmfDRrDmaybytq9oVRb
   Iedey8cxYGt6WuCua/8XfJlbEjRSM4iIJ+FyDDfaXCZwifWp6m3ITCmrq
   SatOX83LomXgU87VBrb3Bwld8i7elWMdp8HCrL8fqduhx1EerOIOfOurJ
   2pXjlycMA1uCrkSkXPDvg60eMQvBlEqPvnRy5S5srT87sq9+jPfu1VgLq
   MglKmSwsrEBChoautvnmYZ/AJMKSnrU9AAARNl51WNraUlvrnlzsTHaMV
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="388223956"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="388223956"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 07:35:52 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="690171248"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="690171248"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.43])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 07:35:51 -0800
Date:   Thu, 12 Jan 2023 07:36:29 -0800 (PST)
From:   matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@rhweight-WRK1
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc:     Xu Yilun <yilun.xu@intel.com>, hao.wu@intel.com,
        russell.h.weight@intel.com, basheer.ahmed.muddebihal@intel.com,
        trix@redhat.com, mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tianfei.zhang@intel.com, corbet@lwn.net,
        gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        jirislaby@kernel.org, geert+renesas@glider.be,
        niklas.soderlund+renesas@ragnatech.se, macro@orcam.me.uk,
        johan@kernel.org, lukas@wunner.de, ilpo.jarvinen@linux.intel.com,
        marpagan@redhat.com, bagasdotme@gmail.com
Subject: Re: [PATCH v10 3/4] fpga: dfl: add basic support for DFHv1
In-Reply-To: <Y7/ggajPS2WNrPPU@smile.fi.intel.com>
Message-ID: <alpine.DEB.2.22.394.2301120732500.845139@rhweight-WRK1>
References: <20230110003029.806022-1-matthew.gerlach@linux.intel.com> <20230110003029.806022-4-matthew.gerlach@linux.intel.com> <Y708L2rRc1RDVkui@smile.fi.intel.com> <alpine.DEB.2.22.394.2301101310150.815911@rhweight-WRK1> <Y74bSzUBLYH4cLDh@yilunxu-OptiPlex-7050>
 <Y7/ggajPS2WNrPPU@smile.fi.intel.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On Thu, 12 Jan 2023, Andy Shevchenko wrote:

> On Wed, Jan 11, 2023 at 10:13:31AM +0800, Xu Yilun wrote:
>> On 2023-01-10 at 14:07:16 -0800, matthew.gerlach@linux.intel.com wrote:
>>> On Tue, 10 Jan 2023, Andy Shevchenko wrote:
>>>> On Mon, Jan 09, 2023 at 04:30:28PM -0800, matthew.gerlach@linux.intel.com wrote:
>>>>> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>
> ...
>
>>>>> v10: change dfh_find_param to return size of parameter data in bytes
>>>>
>>>> The problem that might occur with this approach is byte ordering.
>>>> When we have u64 items, we know that they all are placed in CPU
>>>> ordering by the bottom layer. What's the contract now? Can it be
>>>> a problematic? Please double check this (always keep in mind BE32
>>>> as most interesting case for u64/unsigned long representation and
>>>> other possible byte ordering outcomes).
>>>
>>> A number of u64 items certainly states explicit alignment of the memory, but
>>> I think byte ordering is a different issue.
>>>
>>> The bottom layer, by design, is still enforcing a number u64 items under the
>>> hood. So the contract has not changed. Changing units of size from u64s to
>>> bytes was suggested to match the general practice of size of memory being in
>>> bytes. I think the suggestion was made because the return type for
>>> dfh_find_param() changed from u64* to void* in version 9, when indirectly
>>> returning the size of the parameter data was introduced.  So a void * with a
>>> size in bytes makes sense. On the other hand, returning a u64 * is a more
>>> precise reflection of the data alignment. I think the API should be as
>>
>> I prefer (void *) + bytes. The properties in the parameter block are not
>> guarateed to be u64 for each, e.g. the REG_LAYOUT, so (void *) could better
>> indicate it is not. It is just a block of data unknown to DFL core and to
>> be parsed by drivers.
>
> If the hardware / protocol is capable of communicating the arbitrary lengths
> of parameters, then yes, bytes make sense. But this should be clear what byte
> ordering is there if the items can be words / dwords / qwords.

The hardware does communicate the arbitrary lengths of the parameter data; 
so bytes make sense.  I will update Documentation/fpga/dfl.rst to 
explicitly say that multi-byte quantities are little-endian.

>
> TL;DR: The Q is: Is the parameter block a byte stream? If yes, then your
> proposal is okay. If no, no void * should be used. In the latter it should
> be union of possible items or a like as defined by a protocol.

The parameter block is not a byte stream; so void * should be used.

Thanks,
Matthew Gerlach


>
>> And why users/drivers need to care about the alignment of the parameter
>> block?
>>
>>> follows:
>
> -- 
> With Best Regards,
> Andy Shevchenko
>
>
>

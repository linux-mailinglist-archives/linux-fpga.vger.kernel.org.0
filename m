Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5856679A9
	for <lists+linux-fpga@lfdr.de>; Thu, 12 Jan 2023 16:42:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240590AbjALPkX (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 12 Jan 2023 10:40:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240554AbjALPjo (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 12 Jan 2023 10:39:44 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E62A48CD4;
        Thu, 12 Jan 2023 07:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673537432; x=1705073432;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=0ritdKUn0cRU7l3A1Ps2Js7vFq3raQ8V5MfOb3WntQg=;
  b=k3iy8YuMV4//PXat6nX0NbgVotHUkqsi97AFxsXfINhXIN7GcrK7iFvl
   rzl7N2yyN0aQdpPEswhFSVoVb2TUg5oZkCxBvQ1MY83p44LLeeWa64Otc
   AxYI+Xp4eFT3hIO4I9JdCjysmLzOfgLb3non8tn7czMDEYx7qGuAKX3w1
   9wDe1RJaPB7OnK109XyMIUm/NR1LJsNoTTbP53mqxYZZikLG9ykE5Ok+y
   RUviUtOIb+yki9n/X97yldU1Z80JLz+f3D70QNHpWRaMd8J8w0yMg8140
   tlHV9DCNli5GD/6pVJSOmdcf5QfvyQKQHtltdFXOr79/Lm+wsVl93S5Xh
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="350958895"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="350958895"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 07:30:24 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="659820546"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="659820546"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.43])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 07:30:23 -0800
Date:   Thu, 12 Jan 2023 07:30:54 -0800 (PST)
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
In-Reply-To: <Y74bSzUBLYH4cLDh@yilunxu-OptiPlex-7050>
Message-ID: <alpine.DEB.2.22.394.2301120728210.845139@rhweight-WRK1>
References: <20230110003029.806022-1-matthew.gerlach@linux.intel.com> <20230110003029.806022-4-matthew.gerlach@linux.intel.com> <Y708L2rRc1RDVkui@smile.fi.intel.com> <alpine.DEB.2.22.394.2301101310150.815911@rhweight-WRK1>
 <Y74bSzUBLYH4cLDh@yilunxu-OptiPlex-7050>
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



On Wed, 11 Jan 2023, Xu Yilun wrote:

> On 2023-01-10 at 14:07:16 -0800, matthew.gerlach@linux.intel.com wrote:
>>
>>
>> On Tue, 10 Jan 2023, Andy Shevchenko wrote:
>>
>>> On Mon, Jan 09, 2023 at 04:30:28PM -0800, matthew.gerlach@linux.intel.com wrote:
>>>> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>>>
>>>> Version 1 of the Device Feature Header (DFH) definition adds
>>>> functionality to the Device Feature List (DFL) bus.
>>>>
>>>> A DFHv1 header may have one or more parameter blocks that
>>>> further describes the HW to SW. Add support to the DFL bus
>>>> to parse the MSI-X parameter.
>>>>
>>>> The location of a feature's register set is explicitly
>>>> described in DFHv1 and can be relative to the base of the DFHv1
>>>> or an absolute address. Parse the location and pass the information
>>>> to DFL driver.
>>>
>>> ...
>>>
>>>> v10: change dfh_find_param to return size of parameter data in bytes
>>>
>>> The problem that might occur with this approach is byte ordering.
>>> When we have u64 items, we know that they all are placed in CPU
>>> ordering by the bottom layer. What's the contract now? Can it be
>>> a problematic? Please double check this (always keep in mind BE32
>>> as most interesting case for u64/unsigned long representation and
>>> other possible byte ordering outcomes).
>>
>> A number of u64 items certainly states explicit alignment of the memory, but
>> I think byte ordering is a different issue.
>>
>> The bottom layer, by design, is still enforcing a number u64 items under the
>> hood. So the contract has not changed. Changing units of size from u64s to
>> bytes was suggested to match the general practice of size of memory being in
>> bytes. I think the suggestion was made because the return type for
>> dfh_find_param() changed from u64* to void* in version 9, when indirectly
>> returning the size of the parameter data was introduced.  So a void * with a
>> size in bytes makes sense. On the other hand, returning a u64 * is a more
>> precise reflection of the data alignment. I think the API should be as
>
> I prefer (void *) + bytes. The properties in the parameter block are not
> guarateed to be u64 for each, e.g. the REG_LAYOUT, so (void *) could better
> indicate it is not. It is just a block of data unknown to DFL core and to
> be parsed by drivers.

OK, (void *) + size in bytes is fine.

>
> And why users/drivers need to care about the alignment of the parameter
> block?

Consumers of the parameter block data might try access data that is 
unaligned for a particular CPU.  The good news is that the definition of 
the parameter blocks ensures the data is u64 aligned.

Thanks,
Matthew Gerlach
>
> Thanks,
> Yilun
>
>
>> follows:
>>
>> /**
>>  * dfh_find_param() - find parameter block for the given parameter id
>>  * @dfl_dev: dfl device
>>  * @param_id: id of dfl parameter
>>  * @pcount: destination to store size of parameter data in u64 bit words
>>  *
>>  * Return: pointer to start of parameter data, PTR_ERR otherwise.
>>  */
>> u64 *dfh_find_param(struct dfl_device *dfl_dev, int param_id, size_t
>> *pcount)
>>
>> Regarding byte ordering, Documentation/fpga/dfl.rst does not currently
>> mention endianness. All current HW implementations of DFL are little-endian.
>> I should add a statement in Documentation/fpga/dfl.rst that fields in the
>> Device Feature Header are little-endian.
>>
>> Thanks for the feedback,
>> Matthew Gerlach
>>
>>>
>>> --
>>> With Best Regards,
>>> Andy Shevchenko
>>>
>>>
>>>
>

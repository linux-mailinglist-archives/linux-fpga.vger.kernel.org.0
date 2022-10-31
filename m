Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2F4A613ED1
	for <lists+linux-fpga@lfdr.de>; Mon, 31 Oct 2022 21:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbiJaUPJ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 31 Oct 2022 16:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbiJaUPG (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 31 Oct 2022 16:15:06 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35DB06337;
        Mon, 31 Oct 2022 13:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667247305; x=1698783305;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=IHbJOlvitpR4GGONJy+qLhQEFg8wxFTPAPEhDEJBvcI=;
  b=Gbm1faOrlUqsBnNglUrYPOgFhzUG7psoc5fnpkUvlz4SNAUQMMIZ/2sv
   ryPvpMudpHhL4ikWyr31ctVDZWoBbJPMf8ms+lwg6PF0zjL697FTLwN9u
   mbEUeqvubfbk8jRbPgbVv9Kl1QxtIablCdDPwVTP2H4HGVWOW7q7XUatt
   tlxi8poftOd1jFLjetgYzVn8jDXWvWZNKp+PqzwQE7QAx7t3neWc6Al56
   CpHEnLWWDnDwl2Ehswu4kNybhWbK719WOwqJOlZrDqfcXWp28zPaHt41s
   qlV+ejQDYKAexxA15nPzfdkD20itVN1imCYCdhuz8yRTm43Fn5ePBgbB3
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="308989799"
X-IronPort-AV: E=Sophos;i="5.95,228,1661842800"; 
   d="scan'208";a="308989799"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2022 13:15:04 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="758956171"
X-IronPort-AV: E=Sophos;i="5.95,228,1661842800"; 
   d="scan'208";a="758956171"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.139])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2022 13:15:04 -0700
Date:   Mon, 31 Oct 2022 13:15:06 -0700 (PDT)
From:   matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@rhweight-WRK1
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc:     Xu Yilun <yilun.xu@intel.com>, hao.wu@intel.com,
        russell.h.weight@intel.com, basheer.ahmed.muddebihal@intel.com,
        trix@redhat.com, mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tianfei.zhang@intel.com, corbet@lwn.net, jirislaby@kernel.org,
        geert+renesas@glider.be, niklas.soderlund+renesas@ragnatech.se,
        macro@orcam.me.uk, johan@kernel.org, lukas@wunner.de,
        ilpo.jarvinen@linux.intel.com, marpagan@redhat.com
Subject: Re: [PATCH v4 3/4] fpga: dfl: add basic support DFHv1
In-Reply-To: <Y1/q/PDPNq7pNtda@smile.fi.intel.com>
Message-ID: <alpine.DEB.2.22.394.2210311310560.2680729@rhweight-WRK1>
References: <20221020212610.697729-1-matthew.gerlach@linux.intel.com> <20221020212610.697729-4-matthew.gerlach@linux.intel.com> <Y10l3NkIn0gsdVZq@yilunxu-OptiPlex-7050> <Y171ZEHpOydtR4dW@smile.fi.intel.com> <Y18h4+ESJo+NQnOu@yilunxu-OptiPlex-7050>
 <Y1/q/PDPNq7pNtda@smile.fi.intel.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On Mon, 31 Oct 2022, Andy Shevchenko wrote:

> On Mon, Oct 31, 2022 at 09:16:19AM +0800, Xu Yilun wrote:
>> On 2022-10-31 at 00:06:28 +0200, Andy Shevchenko wrote:
>>> On Sat, Oct 29, 2022 at 09:08:44PM +0800, Xu Yilun wrote:
>>>> On 2022-10-20 at 14:26:09 -0700, matthew.gerlach@linux.intel.com wrote:
>>>
>>>>>  struct dfl_feature_info {
>>>>>  	u16 fid;
>>>>>  	u8 revision;
>>>>> +	u8 dfh_version;
>>>>>  	struct resource mmio_res;
>>>>>  	void __iomem *ioaddr;
>>>>>  	struct list_head node;
>>>>>  	unsigned int irq_base;
>>>>>  	unsigned int nr_irqs;
>>>>> +	unsigned int param_size;
>>>>> +	u64 params[];
>>>>>  };
>>>
>>> ...
>>>
>>>>> +	finfo = kzalloc(sizeof(*finfo) + dfh_psize, GFP_KERNEL);
>>>
>>>
>>> This probably may use something from overflow.h.
>>>
>>>> The u64 flexible array in the structure, but seems dfh_get_psize could
>>>> not garantee 64bit aligned size.
>>>>
>>>> What's the mandatory alignment of param data? If 64bit aligned, bit 33-34
>>>> of PARAM_HDR should be reserved. If 32bit aligned, finfo:params should be
>>>> u32[].
>>>
>>> Isn't it guaranteed by the C standard / architecture ABI?
>>
>> I'm referring to the malloc size of the structure. It reserved dfh_psize
>> bytes for this u64 array, but there is no garantee dfh_psize should be a
>> multiple of 8. So there may be memory leak when accessing the last
>> array element?
>
> Have you looked at macros in the overflow.h? Would the use of it solve your
> concern?

By clarifying the definition of the next field in the parameter header 
as the number of 8-byte words, dfh_get_psize is guaranteed to be a multiple of 8.
This is fixed in the next revision of patches.

Matthew Gerlach

>
> -- 
> With Best Regards,
> Andy Shevchenko
>
>
>

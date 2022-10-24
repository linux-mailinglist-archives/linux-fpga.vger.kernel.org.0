Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B313560B177
	for <lists+linux-fpga@lfdr.de>; Mon, 24 Oct 2022 18:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234168AbiJXQXi (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 24 Oct 2022 12:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232443AbiJXQXS (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 24 Oct 2022 12:23:18 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353AF4B0E4;
        Mon, 24 Oct 2022 08:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666624140; x=1698160140;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=2aq6bJvZs/INx2TIs6FczB9jmb8q3tRqCcz8AIvKGzQ=;
  b=J+JCyiVWb5CkeN8MYnca/S4XA2nP9R2RotbIipWevSAAC4v66c++jFLG
   xnJlVO/DH9NjzQQjAL7KtoV+t7FS0W2oXfLsoP7hRjtvMxDJ4EDMHaZlo
   HwUC98rjqnaQT8ocPkC+0gVoatTgMMkHuCUekbqr7TVNV7pvs/X7ZRiRW
   vSU60SXplbbl9VvV1tLi/XUYBBZfVaM4nmLGba1mJ0lqjVCqnJazVaEWS
   ZLfLZJeNSN5Z6wgdU4PtUXiBk4iKt6XWHdDibSQ1DCpOK0hagHfpRbC5a
   0N6xqDBOr7ZpKh2RiTR6WJ+IMk9WPvxOEMrYrwzBRhB5Y8/h1uSdRhzz6
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="287155496"
X-IronPort-AV: E=Sophos;i="5.95,209,1661842800"; 
   d="scan'208";a="287155496"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 07:55:59 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="626092623"
X-IronPort-AV: E=Sophos;i="5.95,209,1661842800"; 
   d="scan'208";a="626092623"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.139])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 07:55:58 -0700
Date:   Mon, 24 Oct 2022 07:56:11 -0700 (PDT)
From:   matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@rhweight-WRK1
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc:     hao.wu@intel.com, yilun.xu@intel.com, russell.h.weight@intel.com,
        basheer.ahmed.muddebihal@intel.com, trix@redhat.com,
        mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tianfei.zhang@intel.com, corbet@lwn.net,
        gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        jirislaby@kernel.org, geert+renesas@glider.be,
        niklas.soderlund+renesas@ragnatech.se, macro@orcam.me.uk,
        johan@kernel.org, lukas@wunner.de, ilpo.jarvinen@linux.intel.com,
        marpagan@redhat.com
Subject: Re: [PATCH v4 3/4] fpga: dfl: add basic support DFHv1
In-Reply-To: <Y1HGhT5+Nxv6anw5@smile.fi.intel.com>
Message-ID: <alpine.DEB.2.22.394.2210240746570.2070724@rhweight-WRK1>
References: <20221020212610.697729-1-matthew.gerlach@linux.intel.com> <20221020212610.697729-4-matthew.gerlach@linux.intel.com> <Y1HGhT5+Nxv6anw5@smile.fi.intel.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On Fri, 21 Oct 2022, Andy Shevchenko wrote:

> On Thu, Oct 20, 2022 at 02:26:09PM -0700, matthew.gerlach@linux.intel.com wrote:
>> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>
>> Add generic support for MSI-X interrupts for DFL devices.
>>
>> The location of a feature's registers is explicitly
>> described in DFHv1 and can be relative to the base of the DFHv1
>> or an absolute address.  Parse the location and pass the information
>> to DFL driver.
>
> ...
>
>> +static void *find_param(void *base, resource_size_t max, int param)
>
> Why base can't be u64 * to begin with?

It can be u64, and I will consider it for the next iteration.
>
>> +{
>> +	int off = 0;
>> +	u64 v, next;
>> +
>> +	while (off < max) {
>
> Maybe you need a comment somewhere to tell that the caller guarantees that max
> won't provoke OOB accesses.
>
>> +		v = *(u64 *)(base + off);
>
> Okay, if offset is not multiple of at least 4, how do you guarantee no
> exception on the architectures with disallowed misaligned accesses?
>
> Making base to be u64 * solves this, but you need to take care to provide
> offset in terms of u64 words.

The masking of next below ensures that the offset it at least 4 byte 
aligned, but it might make sense to define the next field in terms of 8 
byte words.

>
>> +		if (param == FIELD_GET(DFHv1_PARAM_HDR_ID, v))
>> +			return base + off + DFHv1_PARAM_DATA;
>> +
>> +		next = FIELD_GET(DFHv1_PARAM_HDR_NEXT_OFFSET, v);
>> +		off += next & ~DFHv1_PARAM_HDR_NEXT_MASK;
>> +		if (next & DFHv1_PARAM_HDR_NEXT_EOL)
>> +			break;
>> +
>> +	}
>> +
>> +	return NULL;
>> +}
>
> ...
>
>> +		/*
>> +		 * DFHv0 only provides mmio resource information for each feature
>
> MMIO

I'll change mmio to MMIO here and a place in the documentation that I 
noticed.

>
>> +		 * in the DFL header.  There is no generic interrupt information.
>> +		 * Instead, features with interrupt functionality provide
>> +		 * the information in feature specific registers.
>> +		 */
>
> ...
>
>> +		if (!finfo->param_size)
>>  			break;
>
> This is redundant as it's implied by find_param().

I will remove the redundant code.

>
>> +		p = find_param(params, finfo->param_size, DFHv1_PARAM_ID_MSI_X);
>> +		if (!p)
>>  			break;
>
> ...
>
>> +static int dfh_get_psize(void __iomem *dfh_base, resource_size_t max)
>> +{
>> +	int size = 0;
>> +	u64 v, next;
>> +
>> +	if (!FIELD_GET(DFHv1_CSR_SIZE_GRP_HAS_PARAMS,
>> +		       readq(dfh_base + DFHv1_CSR_SIZE_GRP)))
>> +		return 0;
>> +
>> +	while (size + DFHv1_PARAM_HDR < max) {
>> +		v = readq(dfh_base + DFHv1_PARAM_HDR + size);
>> +
>> +		next = FIELD_GET(DFHv1_PARAM_HDR_NEXT_OFFSET, v);
>> +		if (!(next & ~DFHv1_PARAM_HDR_NEXT_MASK))
>> +			return -EINVAL;
>> +
>> +		size += next & ~DFHv1_PARAM_HDR_NEXT_MASK;
>> +
>> +		if (next & DFHv1_PARAM_HDR_NEXT_EOL)
>> +			return size;
>
> These 3 looks like they deserve different fields and hence separate FIELD_GET()
> will return exactly what we need without additional masking, right?

I agree separate FIELD_GET() calls will be cleaner.

>
>> +	}
>> +
>> +	return -ENOENT;
>> +}
>
> ...
>
>> +	if (dfh_psize > 0) {
>
> Isn't this implied by memcpy_fromio()? I mean if it's 0, nothing bad will
> happen if you call the above directly.
>
>> +		memcpy_fromio(finfo->params,
>> +			      binfo->ioaddr + ofst + DFHv1_PARAM_HDR, dfh_psize);
>> +		finfo->param_size = dfh_psize;
>> +	}
>
> ...
>
>>  	finfo->mmio_res.flags = IORESOURCE_MEM;
>> +	if (dfh_ver == 1) {
>> +		v = readq(binfo->ioaddr + ofst + DFHv1_CSR_ADDR);
>> +		if (v & DFHv1_CSR_ADDR_REL)
>> +			finfo->mmio_res.start = v & ~DFHv1_CSR_ADDR_REL;
>> +		else
>> +			finfo->mmio_res.start = binfo->start + ofst +
>> +					       FIELD_GET(DFHv1_CSR_ADDR_MASK, v);
>> +
>> +		v = readq(binfo->ioaddr + ofst + DFHv1_CSR_SIZE_GRP);
>> +		finfo->mmio_res.end = finfo->mmio_res.start +
>> +				      FIELD_GET(DFHv1_CSR_SIZE_GRP_SIZE, v) - 1;
>> +	} else {
>> +		finfo->mmio_res.start = binfo->start + ofst;
>> +		finfo->mmio_res.end = finfo->mmio_res.start + size - 1;
>> +	}
>
> You may define
>
> 	resource_size_t start, end;
>
> locally and simplify above quite a bit.

That is a good suggestion that should clean up the code quite a bit.

>
> ...
>
>> +void *dfh_find_param(struct dfl_device *dfl_dev, int param);
>
> + Blank line.
>
>>  #endif /* __LINUX_DFL_H */
>
> -- 
> With Best Regards,
> Andy Shevchenko
>
>
>

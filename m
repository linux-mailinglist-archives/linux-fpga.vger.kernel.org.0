Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F185FA134
	for <lists+linux-fpga@lfdr.de>; Mon, 10 Oct 2022 17:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbiJJPeT (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 10 Oct 2022 11:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiJJPeS (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 10 Oct 2022 11:34:18 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A451C13C;
        Mon, 10 Oct 2022 08:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665416057; x=1696952057;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=lUSCuC5/e6LCRmiPeoKpiXWGbJptWgiRV0WhCh4s7pU=;
  b=Vh4jx+pmX/oodiaG4o9RN/vi1XYjTMeWrTXhZm3PM6Ftl7B95PxWjD4g
   +lk92JrfxSBbzbAGxfwWkq1DK9UB4VE4ZORHmXp1pHoR6hhZMrkFItPes
   c+c/6s7yaZ8DmYMFjKJr662rpP9AsT9TJUDXrzuIVlXcKjivD9lcCcllf
   s3HtB1UNoEHh6LpjWCm7pNG5Kx7GvA4F+NaINE3rDhkIZdKYQBwjKyI8e
   HTYOq3y/99UwLuDynivcL4bztKiQh2iz4BvE67/mfw/J3kWCIEiXH1HeF
   7xa+9bCVfaL5i6niBYFTOCeD4IbnOABo5KSHk2asrVos39dsYHxudeBvG
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="302994140"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="302994140"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 08:34:17 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="656971747"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="656971747"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.139])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 08:34:16 -0700
Date:   Mon, 10 Oct 2022 08:34:27 -0700 (PDT)
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
        johan@kernel.org, lukas@wunner.de
Subject: Re: [PATCH v3 3/4] fpga: dfl: add basic support for DFHv1
In-Reply-To: <YzxNCngIuzMqIOHe@smile.fi.intel.com>
Message-ID: <alpine.DEB.2.22.394.2210100813330.2399686@rhweight-WRK1>
References: <20221004143718.1076710-1-matthew.gerlach@linux.intel.com> <20221004143718.1076710-4-matthew.gerlach@linux.intel.com> <YzxNCngIuzMqIOHe@smile.fi.intel.com>
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



On Tue, 4 Oct 2022, Andy Shevchenko wrote:

> On Tue, Oct 04, 2022 at 07:37:17AM -0700, matthew.gerlach@linux.intel.com wrote:
>> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>
>> Add generic support for MSIX interrupts for DFL devices.
>
> $ git grep -n -w MSI[xX] | wc -l
> 421
>
> $ git grep -n -w MSI-[xX] | wc -l
> 1224
>
> MSI-X (This is I believe the official name for that)

Yes, MSI-X is the official name.  I will update accordingly.

>
> And everywhere.
>
>> The location of a feature's registers is explicitly
>> described in DFHv1 and can be relative to the base of the DFHv1
>> or an absolute address.  Parse the location and pass the information
>> to DFL driver.
>
> ...
>
>> +	ddev->csr_res.start = feature->csr_res.start;
>> +	ddev->csr_res.end = feature->csr_res.end;
>> +	ddev->csr_res.flags = IORESOURCE_MEM;
>
> Why simple assignment of the resource can't work?
>
> 	ddev->csr_res = feature->csr_res;
>
> (I know the downside of this, but still)

A simple structure assignment does look cleaner.

>
> ...
>
>> +		feature->csr_res.start = finfo->csr_res.start;
>> +		feature->csr_res.end = finfo->csr_res.end;
>
> Ditto.
>
> ...
>
>> +	case 0:
>> +		type = feature_dev_id_type(binfo->feature_dev);
>> +		if (type == PORT_ID) {
>> +			switch (fid) {
>> +			case PORT_FEATURE_ID_UINT:
>> +				v = readq(base + PORT_UINT_CAP);
>> +				ibase = FIELD_GET(PORT_UINT_CAP_FST_VECT, v);
>> +				inr = FIELD_GET(PORT_UINT_CAP_INT_NUM, v);
>> +				break;
>> +			case PORT_FEATURE_ID_ERROR:
>> +				v = readq(base + PORT_ERROR_CAP);
>> +				ibase = FIELD_GET(PORT_ERROR_CAP_INT_VECT, v);
>> +				inr = FIELD_GET(PORT_ERROR_CAP_SUPP_INT, v);
>> +				break;
>
> No default?

The default is to do nothing.

>
>> +			}
>> +		} else if (type == FME_ID) {
>
>> +			if (fid == FME_FEATURE_ID_GLOBAL_ERR) {
>
> Don't remember if that was discussed already or not, but
>
> I would use switch-case here as well in order to be consistent with the
> previous code piece pattern.

Using a switch statement for a single case seems a little strange to me, 
but I'll take a look to see the result seems more consistent.

>
>> +				v = readq(base + FME_ERROR_CAP);
>> +				ibase = FIELD_GET(FME_ERROR_CAP_INT_VECT, v);
>> +				inr = FIELD_GET(FME_ERROR_CAP_SUPP_INT, v);
>> +			}
>> +		}
>> +		break;
>
> ...
>
>> +		if (v & DFHv1_CSR_ADDR_REL)
>> +			finfo->csr_res.start = FIELD_GET(DFHv1_CSR_ADDR_MASK, v);
>> +		else
>> +			finfo->csr_res.start = binfo->start + ofst
>> +					       + FIELD_GET(DFHv1_CSR_ADDR_MASK, v);
>
> Locate + on the previous line.

Got it.
>
>> +		v = readq(binfo->ioaddr + ofst + DFHv1_CSR_SIZE_GRP);
>> +		finfo->csr_res.end = finfo->csr_res.start
>> +				     + FIELD_GET(DFHv1_CSR_SIZE_GRP_SIZE, v) - 1;
>
> Ditto.
>
> ...
>
>> +int dfhv1_find_param(void __iomem *base, resource_size_t max, int param)
>> +{
>> +	int off = DFHv1_PARAM_HDR;
>> +	u64 v, next;
>> +
>> +	while (off < max) {
>> +		v = readq(base + off);
>> +		if (param == FIELD_GET(DFHv1_PARAM_HDR_ID, v))
>
>> +			return (DFHv1_PARAM_DATA + off);
>
> Too many parentheses.

OK, I can remove the parentheses.

>
>> +
>> +		next = FIELD_GET(DFHv1_PARAM_HDR_NEXT_OFFSET, v);
>> +		if (!next)
>> +			break;
>> +
>> +		off += next;
>> +	}
>> +
>> +	return -ENOENT;
>> +}
>
> The entire function seems a bit dangerous to me. You can ask for any max which
> covers (up to) 64-bit address space and then do MMIO by basically arbitrary
> address. How do you protect against wrong MMIO window here? (This is FPGA, so
> anything can be read from HW, i.o.w. it's _untrusted_ source of the data.)

A broken FPGA image certainly can return anything from a read.  That being 
said I think this is similar to a reg field in a device tree.  The values 
in the reg field can be broken or mistyped.

>
> Also, have you tested this with IOMMU enabled? How do they work together (if
> there is any collision at all between two?)

All my testing has been with IOMMU enabled. The registers may be in the 
same page as the DFHv1 header, but they may not.  For this reason the 
DFHv1 header is ioremapped, parsed, and then unmapped before the actual 
registers are mapped.

  > > ...
>
>> +int dfhv1_find_param(void __iomem *base, resource_size_t max, int param);
>
>> +int dfhv1_has_params(void __iomem *base);
>
> I would expect to see some struct instead of base which will provide means of
> protection against wrong MMIO accesses.
>
> ...
>
> Kernel doc usually accompanies the C-code, i.o.w. implementations and not
> declarations.

I will move kernel doc to the function implementations.

>
> -- 
> With Best Regards,
> Andy Shevchenko
>
>
>

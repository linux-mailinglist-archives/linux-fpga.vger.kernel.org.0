Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 935AD606AFF
	for <lists+linux-fpga@lfdr.de>; Fri, 21 Oct 2022 00:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbiJTWHN (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 20 Oct 2022 18:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbiJTWHL (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 20 Oct 2022 18:07:11 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D10421129A;
        Thu, 20 Oct 2022 15:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666303631; x=1697839631;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+94sJoPVgFoSr/c+TPQoj87dXcPRQ88d4O59CyxLYHA=;
  b=M66Czo4eumZ8BooJxHs83fpCoOZK4jQQrSlqJVWncMifstqdHsI/R40x
   WjktrMQfYd92aN1kXhv/hEibOjNyRCKNkKTys1C5GuBoJe2IR8DCaYe4i
   zI7zLaw4w4sp5HEBfoADmeo97Z1r3u5biVtXS9wUZrf/TDRHx2zSb0kcw
   LkcIFQcQurT0+YqCI7kfgUcscDG+Td7Me31rx38L3dpiLVxVbHbL7/NKK
   akM+FwyX/0p9BgDqG2ShGCla6GFyZw/mMGz7psLqEfs5XkI92bZJg/Lqv
   gWR4ygpqHuIT6SMS5KgXcyQEhg3rlanECQTsL6xrbm/pAzIVMk713JYeB
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="290154108"
X-IronPort-AV: E=Sophos;i="5.95,199,1661842800"; 
   d="scan'208";a="290154108"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 15:07:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="663332863"
X-IronPort-AV: E=Sophos;i="5.95,199,1661842800"; 
   d="scan'208";a="663332863"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 20 Oct 2022 15:07:04 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oldgs-00AnCf-0F;
        Fri, 21 Oct 2022 01:07:02 +0300
Date:   Fri, 21 Oct 2022 01:07:01 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     matthew.gerlach@linux.intel.com
Cc:     hao.wu@intel.com, yilun.xu@intel.com, russell.h.weight@intel.com,
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
Message-ID: <Y1HGhT5+Nxv6anw5@smile.fi.intel.com>
References: <20221020212610.697729-1-matthew.gerlach@linux.intel.com>
 <20221020212610.697729-4-matthew.gerlach@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020212610.697729-4-matthew.gerlach@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, Oct 20, 2022 at 02:26:09PM -0700, matthew.gerlach@linux.intel.com wrote:
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> 
> Add generic support for MSI-X interrupts for DFL devices.
> 
> The location of a feature's registers is explicitly
> described in DFHv1 and can be relative to the base of the DFHv1
> or an absolute address.  Parse the location and pass the information
> to DFL driver.

...

> +static void *find_param(void *base, resource_size_t max, int param)

Why base can't be u64 * to begin with?

> +{
> +	int off = 0;
> +	u64 v, next;
> +
> +	while (off < max) {

Maybe you need a comment somewhere to tell that the caller guarantees that max
won't provoke OOB accesses.

> +		v = *(u64 *)(base + off);

Okay, if offset is not multiple of at least 4, how do you guarantee no
exception on the architectures with disallowed misaligned accesses?

Making base to be u64 * solves this, but you need to take care to provide
offset in terms of u64 words.

> +		if (param == FIELD_GET(DFHv1_PARAM_HDR_ID, v))
> +			return base + off + DFHv1_PARAM_DATA;
> +
> +		next = FIELD_GET(DFHv1_PARAM_HDR_NEXT_OFFSET, v);
> +		off += next & ~DFHv1_PARAM_HDR_NEXT_MASK;
> +		if (next & DFHv1_PARAM_HDR_NEXT_EOL)
> +			break;
> +
> +	}
> +
> +	return NULL;
> +}

...

> +		/*
> +		 * DFHv0 only provides mmio resource information for each feature

MMIO

> +		 * in the DFL header.  There is no generic interrupt information.
> +		 * Instead, features with interrupt functionality provide
> +		 * the information in feature specific registers.
> +		 */

...

> +		if (!finfo->param_size)
>  			break;

This is redundant as it's implied by find_param().

> +		p = find_param(params, finfo->param_size, DFHv1_PARAM_ID_MSI_X);
> +		if (!p)
>  			break;

...

> +static int dfh_get_psize(void __iomem *dfh_base, resource_size_t max)
> +{
> +	int size = 0;
> +	u64 v, next;
> +
> +	if (!FIELD_GET(DFHv1_CSR_SIZE_GRP_HAS_PARAMS,
> +		       readq(dfh_base + DFHv1_CSR_SIZE_GRP)))
> +		return 0;
> +
> +	while (size + DFHv1_PARAM_HDR < max) {
> +		v = readq(dfh_base + DFHv1_PARAM_HDR + size);
> +
> +		next = FIELD_GET(DFHv1_PARAM_HDR_NEXT_OFFSET, v);
> +		if (!(next & ~DFHv1_PARAM_HDR_NEXT_MASK))
> +			return -EINVAL;
> +
> +		size += next & ~DFHv1_PARAM_HDR_NEXT_MASK;
> +
> +		if (next & DFHv1_PARAM_HDR_NEXT_EOL)
> +			return size;

These 3 looks like they deserve different fields and hence separate FIELD_GET()
will return exactly what we need without additional masking, right?

> +	}
> +
> +	return -ENOENT;
> +}

...

> +	if (dfh_psize > 0) {

Isn't this implied by memcpy_fromio()? I mean if it's 0, nothing bad will
happen if you call the above directly.

> +		memcpy_fromio(finfo->params,
> +			      binfo->ioaddr + ofst + DFHv1_PARAM_HDR, dfh_psize);
> +		finfo->param_size = dfh_psize;
> +	}

...

>  	finfo->mmio_res.flags = IORESOURCE_MEM;
> +	if (dfh_ver == 1) {
> +		v = readq(binfo->ioaddr + ofst + DFHv1_CSR_ADDR);
> +		if (v & DFHv1_CSR_ADDR_REL)
> +			finfo->mmio_res.start = v & ~DFHv1_CSR_ADDR_REL;
> +		else
> +			finfo->mmio_res.start = binfo->start + ofst +
> +					       FIELD_GET(DFHv1_CSR_ADDR_MASK, v);
> +
> +		v = readq(binfo->ioaddr + ofst + DFHv1_CSR_SIZE_GRP);
> +		finfo->mmio_res.end = finfo->mmio_res.start +
> +				      FIELD_GET(DFHv1_CSR_SIZE_GRP_SIZE, v) - 1;
> +	} else {
> +		finfo->mmio_res.start = binfo->start + ofst;
> +		finfo->mmio_res.end = finfo->mmio_res.start + size - 1;
> +	}

You may define

	resource_size_t start, end;

locally and simplify above quite a bit.

...

> +void *dfh_find_param(struct dfl_device *dfl_dev, int param);

+ Blank line.

>  #endif /* __LINUX_DFL_H */

-- 
With Best Regards,
Andy Shevchenko



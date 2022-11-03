Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C41D56173DB
	for <lists+linux-fpga@lfdr.de>; Thu,  3 Nov 2022 02:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbiKCBpv (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 2 Nov 2022 21:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiKCBpu (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 2 Nov 2022 21:45:50 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02BC412088;
        Wed,  2 Nov 2022 18:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667439949; x=1698975949;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Sln4k5J/uP9rg3q9ZfFqzdN1uhd3yeOy4OBz6rjRhlQ=;
  b=SRHQ4S7lW68nfJ4wGdk+OvnLleJO2qnJHr4PiSfum+y29ABf2MB+7qo2
   VvR4XRmpOzNK1M0QMqnoxoTvmgYdEKGcUUD750tV+e76GnuN6DDE/YYhd
   +jx6nMwxyOmZ/kqnZMz42oAk0cqkvnyq+Or9ys8UvcbJnA9CRgSbnHsIt
   yVWiIwmYi2FwFxZxu4OyWi82Yx4hPQb8Ja4g2rNCY9WIYHspOPJ89iKm4
   F6v09LBzgZLIEjiS063gEZ8uVbkrHXkl38ftvPal6b4VkEYD0HQcpLUN7
   p/H3uZII5jV+1QYOxDMAu2v1ckw0C5LD4zrVw9cKy9i3ipcp77DTVTmh6
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="307177385"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="307177385"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 18:45:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="612462262"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="612462262"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga006.jf.intel.com with ESMTP; 02 Nov 2022 18:45:45 -0700
Date:   Thu, 3 Nov 2022 09:36:33 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     matthew.gerlach@linux.intel.com
Cc:     hao.wu@intel.com, russell.h.weight@intel.com,
        basheer.ahmed.muddebihal@intel.com, trix@redhat.com,
        mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tianfei.zhang@intel.com, corbet@lwn.net, jirislaby@kernel.org,
        geert+renesas@glider.be, andriy.shevchenko@linux.intel.com,
        niklas.soderlund+renesas@ragnatech.se, macro@orcam.me.uk,
        johan@kernel.org, lukas@wunner.de, ilpo.jarvinen@linux.intel.com,
        marpagan@redhat.com
Subject: Re: [PATCH v4 3/4] fpga: dfl: add basic support DFHv1
Message-ID: <Y2MbIV5lJBgIsA4D@yilunxu-OptiPlex-7050>
References: <20221020212610.697729-1-matthew.gerlach@linux.intel.com>
 <20221020212610.697729-4-matthew.gerlach@linux.intel.com>
 <Y10l3NkIn0gsdVZq@yilunxu-OptiPlex-7050>
 <alpine.DEB.2.22.394.2210290739540.2504975@rhweight-WRK1>
 <alpine.DEB.2.22.394.2211011520290.2767909@rhweight-WRK1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2211011520290.2767909@rhweight-WRK1>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2022-11-01 at 15:37:19 -0700, matthew.gerlach@linux.intel.com wrote:
> 
> 
> On Sat, 29 Oct 2022, matthew.gerlach@linux.intel.com wrote:
> 
> > 
> > > 
> > > >  	if (!finfo)
> > > >  		return -ENOMEM;
> > > > 
> > > > +	if (dfh_psize > 0) {
> > > > +		memcpy_fromio(finfo->params,
> > > > +			      binfo->ioaddr + ofst + DFHv1_PARAM_HDR, dfh_psize);
> > > > +		finfo->param_size = dfh_psize;
> > > > +	}
> > > > +
> > > >  	finfo->fid = fid;
> > > >  	finfo->revision = revision;
> > > > -	finfo->mmio_res.start = binfo->start + ofst;
> > > > -	finfo->mmio_res.end = finfo->mmio_res.start + size - 1;
> > > > +	finfo->dfh_version = dfh_ver;
> > > >  	finfo->mmio_res.flags = IORESOURCE_MEM;
> > > > -	finfo->irq_base = irq_base;
> > > > -	finfo->nr_irqs = nr_irqs;
> > > > +	if (dfh_ver == 1) {
> > > > +		v = readq(binfo->ioaddr + ofst + DFHv1_CSR_ADDR);
> > > > +		if (v & DFHv1_CSR_ADDR_REL)
> > > > +			finfo->mmio_res.start = v & ~DFHv1_CSR_ADDR_REL;
> > > > +		else
> > > > +			finfo->mmio_res.start = binfo->start + ofst +
> > > > +					       FIELD_GET(DFHv1_CSR_ADDR_MASK, v);
> > > > +
> > > > +		v = readq(binfo->ioaddr + ofst + DFHv1_CSR_SIZE_GRP);
> > > > +		finfo->mmio_res.end = finfo->mmio_res.start +
> > > > +				      FIELD_GET(DFHv1_CSR_SIZE_GRP_SIZE, v) - 1;
> > > 
> > > So for dflv1, no feature header resource for dfl_device, is it a problem
> > > for dfl_uio? Does userspace driver need the raw feature header?
> > These are two very good questions.  The dfl_uio driver question is
> > particularly relevent because user space is looking at the GUIDs.
> > 
> 
> In the case of dfl_uio driver, user space will definitely want to look at
> the feature header for the GUID and the parameters.  Since DFHv1 can have
> the DFH header and the feature registers in non-contiguous memory locations,
> a resource for the dfl_device will be required.  In earlier
> revisions of this patch set, a second resource was added called csr_res
> pointing to the feature's register while mmio_res pointed at the header.
> Do we just need better names or do we need an array of named resources?

Either is OK, you could also name a resource element in an array by
struct resource:name. But my concern is still no overlapping.

Thanks,
Yilun

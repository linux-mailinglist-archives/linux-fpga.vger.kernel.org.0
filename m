Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5C0C6651B8
	for <lists+linux-fpga@lfdr.de>; Wed, 11 Jan 2023 03:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbjAKCX5 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 10 Jan 2023 21:23:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbjAKCX5 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 10 Jan 2023 21:23:57 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361461A4;
        Tue, 10 Jan 2023 18:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673403836; x=1704939836;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=O6W8EEZZDpgsAPj45+hyJPC7dzxMaVkD0nu6O0WNFoY=;
  b=f+csRMx2wpoxqtBXHluN4VTPrhg/CiLrPYUAnz2DqCp7eIR1riGtwvTv
   ZRDwqDLG8SfD+7TioQTYw1bqqOGBDjBdlqorCyci2PjdDJLBaPlSdEljG
   d5bvPnH7mzTsw28Fp7OZpOJnUv23ZrbKGqh8qyjpqbF2w7RjqB/+d2v6G
   AWNFL2ymgG7QDc5CS6KB1jfimPs9+gkW70mThSXD5T2+XNS+P6R0g5Zz+
   TU9nk6Dn+qSnjjAp3LTiV9+Z9RvbHBU9SJPg78YsLHt2MYioys2jcXVKD
   FzGuUkorZ0Uy42z8nBuhmTTteX2Mt5uO43MrZWCU3lIeqPVPEUjGCoNHE
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="324549812"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="324549812"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 18:23:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="687766202"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="687766202"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga008.jf.intel.com with ESMTP; 10 Jan 2023 18:23:50 -0800
Date:   Wed, 11 Jan 2023 10:13:31 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     matthew.gerlach@linux.intel.com
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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
Message-ID: <Y74bSzUBLYH4cLDh@yilunxu-OptiPlex-7050>
References: <20230110003029.806022-1-matthew.gerlach@linux.intel.com>
 <20230110003029.806022-4-matthew.gerlach@linux.intel.com>
 <Y708L2rRc1RDVkui@smile.fi.intel.com>
 <alpine.DEB.2.22.394.2301101310150.815911@rhweight-WRK1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2301101310150.815911@rhweight-WRK1>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2023-01-10 at 14:07:16 -0800, matthew.gerlach@linux.intel.com wrote:
> 
> 
> On Tue, 10 Jan 2023, Andy Shevchenko wrote:
> 
> > On Mon, Jan 09, 2023 at 04:30:28PM -0800, matthew.gerlach@linux.intel.com wrote:
> > > From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > > 
> > > Version 1 of the Device Feature Header (DFH) definition adds
> > > functionality to the Device Feature List (DFL) bus.
> > > 
> > > A DFHv1 header may have one or more parameter blocks that
> > > further describes the HW to SW. Add support to the DFL bus
> > > to parse the MSI-X parameter.
> > > 
> > > The location of a feature's register set is explicitly
> > > described in DFHv1 and can be relative to the base of the DFHv1
> > > or an absolute address. Parse the location and pass the information
> > > to DFL driver.
> > 
> > ...
> > 
> > > v10: change dfh_find_param to return size of parameter data in bytes
> > 
> > The problem that might occur with this approach is byte ordering.
> > When we have u64 items, we know that they all are placed in CPU
> > ordering by the bottom layer. What's the contract now? Can it be
> > a problematic? Please double check this (always keep in mind BE32
> > as most interesting case for u64/unsigned long representation and
> > other possible byte ordering outcomes).
> 
> A number of u64 items certainly states explicit alignment of the memory, but
> I think byte ordering is a different issue.
> 
> The bottom layer, by design, is still enforcing a number u64 items under the
> hood. So the contract has not changed. Changing units of size from u64s to
> bytes was suggested to match the general practice of size of memory being in
> bytes. I think the suggestion was made because the return type for
> dfh_find_param() changed from u64* to void* in version 9, when indirectly
> returning the size of the parameter data was introduced.  So a void * with a
> size in bytes makes sense. On the other hand, returning a u64 * is a more
> precise reflection of the data alignment. I think the API should be as

I prefer (void *) + bytes. The properties in the parameter block are not
guarateed to be u64 for each, e.g. the REG_LAYOUT, so (void *) could better
indicate it is not. It is just a block of data unknown to DFL core and to
be parsed by drivers.

And why users/drivers need to care about the alignment of the parameter
block?

Thanks,
Yilun


> follows:
> 
> /**
>  * dfh_find_param() - find parameter block for the given parameter id
>  * @dfl_dev: dfl device
>  * @param_id: id of dfl parameter
>  * @pcount: destination to store size of parameter data in u64 bit words
>  *
>  * Return: pointer to start of parameter data, PTR_ERR otherwise.
>  */
> u64 *dfh_find_param(struct dfl_device *dfl_dev, int param_id, size_t
> *pcount)
> 
> Regarding byte ordering, Documentation/fpga/dfl.rst does not currently
> mention endianness. All current HW implementations of DFL are little-endian.
> I should add a statement in Documentation/fpga/dfl.rst that fields in the
> Device Feature Header are little-endian.
> 
> Thanks for the feedback,
> Matthew Gerlach
> 
> > 
> > -- 
> > With Best Regards,
> > Andy Shevchenko
> > 
> > 
> > 

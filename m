Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5AAE666FB4
	for <lists+linux-fpga@lfdr.de>; Thu, 12 Jan 2023 11:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233979AbjALKbX (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 12 Jan 2023 05:31:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbjALKay (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 12 Jan 2023 05:30:54 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CBF52640;
        Thu, 12 Jan 2023 02:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673519242; x=1705055242;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NdBbMoGChw6KosXwVC+RIdZs4IKxKn2BNHXvx35POVQ=;
  b=kVMRmzplwZs/uKq+lNqRds/3FZEYufUYuZweaZBFySmvzRO9eRxsskRH
   gGd6u/h5kFAZqpOUqJiWswSbVAHPjtmJqilIIQBw95lyr3NMa0J/PeAa8
   XvnoHAMexvCpICsahVG43ji56qFkH+3m7q0C2Y/TR4q4h4GtzqcR/m7kC
   k1NwydTa4dh6zILfgnzPfN37KUefd/0Vn5ZcpJsjFy2ZSKvPKbBG0F/Sd
   4XIMj9gci9zxHyMWvQCLWANPJRxufe8BYJ/5V4D4+QumdbfdKZSndZ1GA
   41c/HWgKyZghzQa+nq/poDc5c39jXjOgONuz3nYui9clOHYdfDhp2+ptW
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="321360890"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="321360890"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 02:27:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="607733710"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="607733710"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 12 Jan 2023 02:27:16 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pFunh-007zjX-31;
        Thu, 12 Jan 2023 12:27:13 +0200
Date:   Thu, 12 Jan 2023 12:27:13 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     matthew.gerlach@linux.intel.com, hao.wu@intel.com,
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
Message-ID: <Y7/ggajPS2WNrPPU@smile.fi.intel.com>
References: <20230110003029.806022-1-matthew.gerlach@linux.intel.com>
 <20230110003029.806022-4-matthew.gerlach@linux.intel.com>
 <Y708L2rRc1RDVkui@smile.fi.intel.com>
 <alpine.DEB.2.22.394.2301101310150.815911@rhweight-WRK1>
 <Y74bSzUBLYH4cLDh@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y74bSzUBLYH4cLDh@yilunxu-OptiPlex-7050>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, Jan 11, 2023 at 10:13:31AM +0800, Xu Yilun wrote:
> On 2023-01-10 at 14:07:16 -0800, matthew.gerlach@linux.intel.com wrote:
> > On Tue, 10 Jan 2023, Andy Shevchenko wrote:
> > > On Mon, Jan 09, 2023 at 04:30:28PM -0800, matthew.gerlach@linux.intel.com wrote:
> > > > From: Matthew Gerlach <matthew.gerlach@linux.intel.com>

...

> > > > v10: change dfh_find_param to return size of parameter data in bytes
> > > 
> > > The problem that might occur with this approach is byte ordering.
> > > When we have u64 items, we know that they all are placed in CPU
> > > ordering by the bottom layer. What's the contract now? Can it be
> > > a problematic? Please double check this (always keep in mind BE32
> > > as most interesting case for u64/unsigned long representation and
> > > other possible byte ordering outcomes).
> > 
> > A number of u64 items certainly states explicit alignment of the memory, but
> > I think byte ordering is a different issue.
> > 
> > The bottom layer, by design, is still enforcing a number u64 items under the
> > hood. So the contract has not changed. Changing units of size from u64s to
> > bytes was suggested to match the general practice of size of memory being in
> > bytes. I think the suggestion was made because the return type for
> > dfh_find_param() changed from u64* to void* in version 9, when indirectly
> > returning the size of the parameter data was introduced.  So a void * with a
> > size in bytes makes sense. On the other hand, returning a u64 * is a more
> > precise reflection of the data alignment. I think the API should be as
> 
> I prefer (void *) + bytes. The properties in the parameter block are not
> guarateed to be u64 for each, e.g. the REG_LAYOUT, so (void *) could better
> indicate it is not. It is just a block of data unknown to DFL core and to
> be parsed by drivers.

If the hardware / protocol is capable of communicating the arbitrary lengths
of parameters, then yes, bytes make sense. But this should be clear what byte
ordering is there if the items can be words / dwords / qwords.

TL;DR: The Q is: Is the parameter block a byte stream? If yes, then your
proposal is okay. If no, no void * should be used. In the latter it should
be union of possible items or a like as defined by a protocol.

> And why users/drivers need to care about the alignment of the parameter
> block?
> 
> > follows:

-- 
With Best Regards,
Andy Shevchenko



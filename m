Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF7C6689A4
	for <lists+linux-fpga@lfdr.de>; Fri, 13 Jan 2023 03:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233589AbjAMCeh (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 12 Jan 2023 21:34:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbjAMCef (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 12 Jan 2023 21:34:35 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD745E086;
        Thu, 12 Jan 2023 18:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673577274; x=1705113274;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1Fhn7RBHP5K/zgQ40UOi83c/4i6gFct3E7arxwKP9fg=;
  b=V8QFgrh1GffE1olnkg/Qco6Ew3WI8sbjza0JHpphZCDHDBauIilDSEFH
   6S0wxzLUastKjJGIVx8n2FLILqr3bL+L8bI8RX5e+b8nCnrPyslAVgIHS
   oYfQj/haE3Au3J7CBJ60mkmAHRd06Qk7GmcJOtmOupoS1sdyNJgTixBjO
   oOXd6fR0V7LqruZfBfLmWKSfH5Q5m5YuEv2qgdea08V63l0Cu7TXGJ5Xg
   gJTw4/92+baT8/ZKMG37gm9N8ytUIt/nQDy9XdkSzuDgzNcB8Ra68V3r8
   pN06+wJ7Ree8vuNO7BI5Hp0hKiv7zMOXJ5WRem1yiyhf8wLOWGTVhcPyG
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="325953181"
X-IronPort-AV: E=Sophos;i="5.97,212,1669104000"; 
   d="scan'208";a="325953181"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 18:33:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="903436020"
X-IronPort-AV: E=Sophos;i="5.97,212,1669104000"; 
   d="scan'208";a="903436020"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga006.fm.intel.com with ESMTP; 12 Jan 2023 18:32:59 -0800
Date:   Fri, 13 Jan 2023 10:22:39 +0800
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
Message-ID: <Y8DAb3R3bP/M7f0v@yilunxu-OptiPlex-7050>
References: <20230110003029.806022-1-matthew.gerlach@linux.intel.com>
 <20230110003029.806022-4-matthew.gerlach@linux.intel.com>
 <Y708L2rRc1RDVkui@smile.fi.intel.com>
 <alpine.DEB.2.22.394.2301101310150.815911@rhweight-WRK1>
 <Y74bSzUBLYH4cLDh@yilunxu-OptiPlex-7050>
 <Y7/ggajPS2WNrPPU@smile.fi.intel.com>
 <alpine.DEB.2.22.394.2301120732500.845139@rhweight-WRK1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2301120732500.845139@rhweight-WRK1>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2023-01-12 at 07:36:29 -0800, matthew.gerlach@linux.intel.com wrote:
> 
> 
> On Thu, 12 Jan 2023, Andy Shevchenko wrote:
> 
> > On Wed, Jan 11, 2023 at 10:13:31AM +0800, Xu Yilun wrote:
> > > On 2023-01-10 at 14:07:16 -0800, matthew.gerlach@linux.intel.com wrote:
> > > > On Tue, 10 Jan 2023, Andy Shevchenko wrote:
> > > > > On Mon, Jan 09, 2023 at 04:30:28PM -0800, matthew.gerlach@linux.intel.com wrote:
> > > > > > From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > 
> > ...
> > 
> > > > > > v10: change dfh_find_param to return size of parameter data in bytes
> > > > > 
> > > > > The problem that might occur with this approach is byte ordering.
> > > > > When we have u64 items, we know that they all are placed in CPU
> > > > > ordering by the bottom layer. What's the contract now? Can it be
> > > > > a problematic? Please double check this (always keep in mind BE32
> > > > > as most interesting case for u64/unsigned long representation and
> > > > > other possible byte ordering outcomes).
> > > > 
> > > > A number of u64 items certainly states explicit alignment of the memory, but
> > > > I think byte ordering is a different issue.
> > > > 
> > > > The bottom layer, by design, is still enforcing a number u64 items under the
> > > > hood. So the contract has not changed. Changing units of size from u64s to
> > > > bytes was suggested to match the general practice of size of memory being in
> > > > bytes. I think the suggestion was made because the return type for
> > > > dfh_find_param() changed from u64* to void* in version 9, when indirectly
> > > > returning the size of the parameter data was introduced.  So a void * with a
> > > > size in bytes makes sense. On the other hand, returning a u64 * is a more
> > > > precise reflection of the data alignment. I think the API should be as
> > > 
> > > I prefer (void *) + bytes. The properties in the parameter block are not
> > > guarateed to be u64 for each, e.g. the REG_LAYOUT, so (void *) could better
> > > indicate it is not. It is just a block of data unknown to DFL core and to
> > > be parsed by drivers.
> > 
> > If the hardware / protocol is capable of communicating the arbitrary lengths
> > of parameters, then yes, bytes make sense. But this should be clear what byte
> > ordering is there if the items can be words / dwords / qwords.
> 
> The hardware does communicate the arbitrary lengths of the parameter data;
> so bytes make sense.  I will update Documentation/fpga/dfl.rst to explicitly
> say that multi-byte quantities are little-endian.
> 
> > 
> > TL;DR: The Q is: Is the parameter block a byte stream? If yes, then your
> > proposal is okay. If no, no void * should be used. In the latter it should
> > be union of possible items or a like as defined by a protocol.
> 
> The parameter block is not a byte stream; so void * should be used.

Mm.. I think Andy's idea is, if the parameter block is not a byte stream,
void * should NOT be used.

My understanding is, The parameter block is not a byte stream in HW, it is
some items (or properties) of various lengths. They are compacted in the
parameter block. But the layout is not generally defined, each parameter
block could have its own layout.

The definition and layout of the parameter block is specific to each device,
that is, people design the parameter block for the device when they design
the device. So DFL core doesn't try to generalize all the layouts, they
are unlimited. DFL core just see it as a block of untouched data to be parsed
by each driver. So from DFL core's perspective, it is a byte stream.

Thanks,
Yilun

> 
> Thanks,
> Matthew Gerlach
> 
> 
> > 
> > > And why users/drivers need to care about the alignment of the parameter
> > > block?
> > > 
> > > > follows:
> > 
> > -- 
> > With Best Regards,
> > Andy Shevchenko
> > 
> > 
> > 

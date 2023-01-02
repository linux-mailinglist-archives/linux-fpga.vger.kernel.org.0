Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38E6365B5E5
	for <lists+linux-fpga@lfdr.de>; Mon,  2 Jan 2023 18:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbjABR24 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 2 Jan 2023 12:28:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbjABR2g (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 2 Jan 2023 12:28:36 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F3C203;
        Mon,  2 Jan 2023 09:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672680515; x=1704216515;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=q5qnnYp8tgnzFx+TZm3WZrqFfCIt/TufhrxR83XrQys=;
  b=lv9/5qu7TQnNRS0mTQ4CdPU7j5AvTsencnGqHd0yh1rrZb5MujmP76Dm
   uD0Q8ze4ilO+Ewk0D9meSqj68Ap3YbSflSGd5xDWucEb/MiGjU95TYO0C
   rQEiMO2h4TW/XLQbq1euiz7d5N2VaBtQpTrMNsTHFbKC6hHO09Ls6XphX
   xyNiVjwRlX32JpW5nVH+g3cUCjJt1tr0GKLeuPGIhQHY3wZny/hmpuyFy
   Xcu+X2y8eJSqI+Ij0d/VhPCWx0LZp+0N/XWMrZXlW/6hRnkCsT0s/ONfN
   1oNthmUmOa1q2KpUpcKdEvUAQFFvWttU/ldloQB67/+WYVWhplZUWKedh
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="319219201"
X-IronPort-AV: E=Sophos;i="5.96,294,1665471600"; 
   d="scan'208";a="319219201"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2023 09:28:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="647957008"
X-IronPort-AV: E=Sophos;i="5.96,294,1665471600"; 
   d="scan'208";a="647957008"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 02 Jan 2023 09:28:28 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pCObp-003WZ5-3A;
        Mon, 02 Jan 2023 19:28:25 +0200
Date:   Mon, 2 Jan 2023 19:28:25 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     matthew.gerlach@linux.intel.com
Cc:     Tom Rix <trix@redhat.com>, hao.wu@intel.com, yilun.xu@intel.com,
        russell.h.weight@intel.com, basheer.ahmed.muddebihal@intel.com,
        mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tianfei.zhang@intel.com, corbet@lwn.net,
        gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        jirislaby@kernel.org, geert+renesas@glider.be,
        niklas.soderlund+renesas@ragnatech.se, macro@orcam.me.uk,
        johan@kernel.org, lukas@wunner.de, ilpo.jarvinen@linux.intel.com,
        marpagan@redhat.com, bagasdotme@gmail.com
Subject: Re: [PATCH v8 3/4] fpga: dfl: add basic support for DFHv1
Message-ID: <Y7MUOQ/X/ls5/+RP@smile.fi.intel.com>
References: <20221228181624.1793433-1-matthew.gerlach@linux.intel.com>
 <20221228181624.1793433-4-matthew.gerlach@linux.intel.com>
 <628c125a-5a84-e1bd-7724-2637315cc35e@redhat.com>
 <Y637aBTrbRloUtvD@smile.fi.intel.com>
 <alpine.DEB.2.22.394.2301020852500.2516029@rhweight-WRK1>
 <Y7MT6e8c2VLCjZuw@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7MT6e8c2VLCjZuw@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Jan 02, 2023 at 07:27:06PM +0200, Andy Shevchenko wrote:
> On Mon, Jan 02, 2023 at 08:54:48AM -0800, matthew.gerlach@linux.intel.com wrote:
> > On Thu, 29 Dec 2022, Andy Shevchenko wrote:
> > > On Thu, Dec 29, 2022 at 08:18:03AM -0800, Tom Rix wrote:
> > > > On 12/28/22 10:16 AM, matthew.gerlach@linux.intel.com wrote:

...

> > > > > +	u64 params[];
> > > > u64 *params
> 
> > > This will break the overflow.h macros, no?
> > > Besides that it will break the code for sure as it's not an equivalent.
> 
> > I don't understand how this will break the overflow.h macros. The definition
> > of struct dfl_feature_info and all of its uses are in a single file, dfl.c.
> 
> Hint: __must_be_array()
> 
> As I said, the proposed change is not acceptable since it's not an equivalent.

Ah, you meant that there is no use of macros from overflow in the dfl.c?
IIRC we discussed that some of the code may make use of them, or am I
mistaken?

-- 
With Best Regards,
Andy Shevchenko



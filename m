Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCBBD64BDA2
	for <lists+linux-fpga@lfdr.de>; Tue, 13 Dec 2022 20:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235893AbiLMTwn (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 13 Dec 2022 14:52:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbiLMTwm (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 13 Dec 2022 14:52:42 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D8B71147;
        Tue, 13 Dec 2022 11:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670961159; x=1702497159;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MU6rFsdcfnzIZ8FnppA/8eHjC/2nt+tjADR1U5/R7l0=;
  b=P3NQ9AA4pZXPhverRN7FZsV+uGtLaUWgf5Gk2nSDkyvoVcNMHRCSgFgB
   jUvPsPeYZL2FpxX8eKh3giHaazxTwbCetPIWmYgD9WNxftYxgJ2f3FPtH
   ROj6xpXw/ImJ0MIYOB9M17LBe37RtHcHtHrDGJkHm7Tp6QW5BTV9j+AGZ
   xHOtlIvjTVx0xM/jI//13F/Uv/3+3U03Y+7jZNkByY/jLgpukxToI0arb
   /+iTF+7hiVOnQJZtWx6qgC81m9SuVd70pTcr3Ampzc4/G5t4wdsVlStio
   +QlosJB19SLiE4Vwx+4NMw31iCC/+UWjzO52vECHsUaNQG+Db/jSzCsb0
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="320087110"
X-IronPort-AV: E=Sophos;i="5.96,242,1665471600"; 
   d="scan'208";a="320087110"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2022 11:52:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10560"; a="717325838"
X-IronPort-AV: E=Sophos;i="5.96,242,1665471600"; 
   d="scan'208";a="717325838"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 13 Dec 2022 11:52:32 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1p5BKI-009RL9-07;
        Tue, 13 Dec 2022 21:52:30 +0200
Date:   Tue, 13 Dec 2022 21:52:29 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     matthew.gerlach@linux.intel.com
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, hao.wu@intel.com,
        yilun.xu@intel.com, russell.h.weight@intel.com,
        basheer.ahmed.muddebihal@intel.com, trix@redhat.com,
        mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tianfei.zhang@intel.com, corbet@lwn.net,
        gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        jirislaby@kernel.org, geert+renesas@glider.be,
        niklas.soderlund+renesas@ragnatech.se, macro@orcam.me.uk,
        johan@kernel.org, lukas@wunner.de, ilpo.jarvinen@linux.intel.com,
        marpagan@redhat.com
Subject: Re: [PATCH v6 1/4] Documentation: fpga: dfl: Add documentation for
 DFHv1
Message-ID: <Y5jX/eXrFdAO7xml@smile.fi.intel.com>
References: <20221209214523.3484193-1-matthew.gerlach@linux.intel.com>
 <20221209214523.3484193-2-matthew.gerlach@linux.intel.com>
 <Y5P6NjDxy/S7nlF7@debian.me>
 <alpine.DEB.2.22.394.2212130844330.3732069@rhweight-WRK1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2212130844330.3732069@rhweight-WRK1>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Dec 13, 2022 at 08:50:25AM -0800, matthew.gerlach@linux.intel.com wrote:
> On Sat, 10 Dec 2022, Bagas Sanjaya wrote:
> > On Fri, Dec 09, 2022 at 01:45:20PM -0800, matthew.gerlach@linux.intel.com wrote:

...

> > >  Open discussion
> > >  ===============
> > >  FME driver exports one ioctl (DFL_FPGA_FME_PORT_PR) for partial reconfiguration
> > 
> > What about this wording below (including fitting the prose within 80 columns)?
> 
> The wording you suggest is an improvement. I will include your suggestions.
> I mistakenly thought that Restructured Text needed list items to be a single
> line and checkpatch.pl did not flag the long lines.

I usually test the output with rst2pdf. You can also try kernel doc script to
produce man and HTML and see how they are rendered.

-- 
With Best Regards,
Andy Shevchenko



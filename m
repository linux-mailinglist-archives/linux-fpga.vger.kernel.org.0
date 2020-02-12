Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51D47159F96
	for <lists+linux-fpga@lfdr.de>; Wed, 12 Feb 2020 04:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbgBLDkQ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 11 Feb 2020 22:40:16 -0500
Received: from mga05.intel.com ([192.55.52.43]:25726 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727602AbgBLDkQ (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 11 Feb 2020 22:40:16 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2020 19:40:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,428,1574150400"; 
   d="scan'208";a="380645109"
Received: from hao-dev.bj.intel.com (HELO localhost) ([10.238.157.65])
  by orsmga004.jf.intel.com with ESMTP; 11 Feb 2020 19:40:11 -0800
Date:   Wed, 12 Feb 2020 11:19:29 +0800
From:   Wu Hao <hao.wu@intel.com>
To:     Will Deacon <will@kernel.org>
Cc:     mdf@kernel.org, mark.rutland@arm.com, gregkh@linuxfoundation.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, atull@kernel.org, yilun.xu@intel.com,
        Luwei Kang <luwei.kang@intel.com>
Subject: Re: [PATCH v7 2/2] fpga: dfl: fme: add performance reporting support
Message-ID: <20200212031929.GB5645@hao-dev>
References: <1581306469-22629-1-git-send-email-hao.wu@intel.com>
 <1581306469-22629-3-git-send-email-hao.wu@intel.com>
 <20200210163400.GA21900@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200210163400.GA21900@willie-the-truck>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Feb 10, 2020 at 04:34:01PM +0000, Will Deacon wrote:
> Hi,
> 
> On Mon, Feb 10, 2020 at 11:47:49AM +0800, Wu Hao wrote:
> > This patch adds support for performance reporting private feature
> > for FPGA Management Engine (FME). Now it supports several different
> > performance counters, including 'basic', 'cache', 'fabric', 'vtd'
> > and 'vtd_sip'. It allows user to use standard linux tools to access
> > these performance counters.
> 
> I had a quick look at this, and it mostly looks alright to me. Just a few
> high-level comments/questions:

Hi Will

Thanks a lot for the review! :)

> 
>   - I would still prefer for the PMU drivers to live under drivers/perf/

Hm.. one possible way is to create a platform device, and introduce a new
platform device driver under drivers/perf/.

> 
>   - You should probably give the PMU a better name than "fme%d", for example
>     "intel_fpga_dfl_fme%d".

Sure. as it's not intel only, so will use "fpga_dfl_fme" or "dfl_fme" instead.

> 
>   - CPU0 can be hotplugged off on non-x86 systems. How do you cope with
>     that?

Oh.. then we can't just always return CPU0 for cpumask, have to switch
to another available cpu. Will add code to handle this case in the next
version. Thanks!

> 
>   - readq() will emit 2x32-bit reads on some architectures. What happens
>     in this case?

64bit counter may increase and carry out of bit31 between 2-32bit reads,
we probably need some more code (add extra reads?) to handle this case.


Thanks again for these valuable comments, will try to fix all of them in
the next version. : )

Hao

> 
> Will

Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 457CD740BBD
	for <lists+linux-fpga@lfdr.de>; Wed, 28 Jun 2023 10:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234642AbjF1IjX (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 28 Jun 2023 04:39:23 -0400
Received: from mga07.intel.com ([134.134.136.100]:40497 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235249AbjF1Ifw (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 28 Jun 2023 04:35:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687941352; x=1719477352;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=30tbHYBVKtiwmy4ek/9rLdJHPLikMjah+QEc5qOEVZI=;
  b=hr80XAf1IRnE1zjPP5AM4Eg4rutqBtvksrnw4AXj8Vng1zsAS6+NGJbJ
   parkS5wbpx1D2csilrKSFOHTiB5sBL0RM8ma2BUAZnf47s20rIVE3vdZc
   6AZ8fP8vLmCrtS6EMjupKPoW0fA1wKOgF5UZnn6ezwgJfoEjEA+SZJVDn
   gmL/fiKqaXo/hSqDr8ku5YrTonYlu2NmO9ThDGC5YO54j2UhXadN19wxD
   8+Jd2GEITtPMw2IivBVcVV9Y43usYX3QMRC9Xy+Mgbz8ddLw7gjtJS7Dp
   Io3Nfej5Rn+e6N2j8n7WvjJhE+uTjTJPsfwrhHY1hF4x6y9LCORQ9n7Cw
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="427765542"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; 
   d="scan'208";a="427765542"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2023 22:57:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="806768023"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; 
   d="scan'208";a="806768023"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Jun 2023 22:57:46 -0700
Date:   Wed, 28 Jun 2023 13:56:36 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Peter Colberg <peter.colberg@intel.com>, hao.wu@intel.com,
        gregkh@linuxfoundation.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, aaron.j.grier@intel.com,
        tianfei.zhang@intel.com, russell.h.weight@intel.com,
        matthew.gerlach@linux.intel.com, marpagan@redhat.com,
        lgoncalv@redhat.com
Subject: Re: [PATCH v2] fpga: dfl: afu: use PFN_DOWN() and PFN_PHYS() helper
 macros
Message-ID: <ZJvLlHpJwr/tv3gq@yilunxu-OptiPlex-7050>
References: <2023061908-subscribe-persuader-9b9f@gregkh>
 <20230619195634.11366-1-peter.colberg@intel.com>
 <ZJqBE1mCjSaRIvyt@yilunxu-OptiPlex-7050>
 <ZJspBy/imk1qH+s2@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJspBy/imk1qH+s2@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2023-06-27 at 21:23:03 +0300, Andy Shevchenko wrote:
> On Tue, Jun 27, 2023 at 02:26:27PM +0800, Xu Yilun wrote:
> > On 2023-06-19 at 15:56:34 -0400, Peter Colberg wrote:
> 
> ...
> 
> > > -	int npages = region->length >> PAGE_SHIFT;
> > > +	int npages = PFN_DOWN(region->length);
> > 
> > I don't much prefer this change, it is not doing the phy addr to pfn
> > convertion. The macro name doesn't match what is doing here.
> 
> This macro converts length to pages. And it's not about phy addr.

You are right.

> > > -	offset = vma->vm_pgoff << PAGE_SHIFT;
> > > +	offset = PFN_PHYS(vma->vm_pgoff);
> > 
> > ditto. The variables are offsets within file, not phys addr & pfn.
> 
> Here I probably can agree.

OK. Remove this one, and others LGTM.

Thanks,
Yilun

> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

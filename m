Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7069A740325
	for <lists+linux-fpga@lfdr.de>; Tue, 27 Jun 2023 20:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbjF0SXL (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 27 Jun 2023 14:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjF0SXL (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 27 Jun 2023 14:23:11 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2589B107;
        Tue, 27 Jun 2023 11:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687890190; x=1719426190;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=X8aFP6n5+e9dFtrJDRcwbrABsg9kq0BYA5F9HfO3IHY=;
  b=bL6ATSs0GeLWfYZwiu08neoVBr1iTRS4TLXJJHap4mgUM+1CigvZ3zjR
   24lPoEn5NditnlxK7TUeFJa53X+VjH5oROR6Yi+apfKE+rU5KQisTIeN7
   33yGLTZGNk3JarKFAag5a0zPjSHzrqeykAf6Cq/SoNAr5a7NS24jIWuqA
   0dfKHR5zHkYb0ZCuzob6NKoMuoBYWSVxAu3J/FQrYZqbtwnIxTMnhsrtK
   3gHDvdFgbth1hAZ3oeftXKsLOcWnbZsR50KH6T3HqtdCqhj1Fbpxc0a5s
   FzxFrR3Vby2M+sl3IagHk9/6IGF/Qf+Md4tcAtAAW0jcv7spuH7XUAv3e
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="359148466"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; 
   d="scan'208";a="359148466"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2023 11:23:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="716633644"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; 
   d="scan'208";a="716633644"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 27 Jun 2023 11:23:05 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qEDLE-000OhP-03;
        Tue, 27 Jun 2023 21:23:04 +0300
Date:   Tue, 27 Jun 2023 21:23:03 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     Peter Colberg <peter.colberg@intel.com>, hao.wu@intel.com,
        gregkh@linuxfoundation.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, aaron.j.grier@intel.com,
        tianfei.zhang@intel.com, russell.h.weight@intel.com,
        matthew.gerlach@linux.intel.com, marpagan@redhat.com,
        lgoncalv@redhat.com
Subject: Re: [PATCH v2] fpga: dfl: afu: use PFN_DOWN() and PFN_PHYS() helper
 macros
Message-ID: <ZJspBy/imk1qH+s2@smile.fi.intel.com>
References: <2023061908-subscribe-persuader-9b9f@gregkh>
 <20230619195634.11366-1-peter.colberg@intel.com>
 <ZJqBE1mCjSaRIvyt@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJqBE1mCjSaRIvyt@yilunxu-OptiPlex-7050>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Jun 27, 2023 at 02:26:27PM +0800, Xu Yilun wrote:
> On 2023-06-19 at 15:56:34 -0400, Peter Colberg wrote:

...

> > -	int npages = region->length >> PAGE_SHIFT;
> > +	int npages = PFN_DOWN(region->length);
> 
> I don't much prefer this change, it is not doing the phy addr to pfn
> convertion. The macro name doesn't match what is doing here.

This macro converts length to pages. And it's not about phy addr.

...

> > -	long npages = region->length >> PAGE_SHIFT;
> > +	long npages = PFN_DOWN(region->length);
> 
> ditto

Ditto.

...

> > -	int npages = region->length >> PAGE_SHIFT;
> > +	int npages = PFN_DOWN(region->length);
> 
> ditto

Ditto.

...

> > -	offset = vma->vm_pgoff << PAGE_SHIFT;
> > +	offset = PFN_PHYS(vma->vm_pgoff);
> 
> ditto. The variables are offsets within file, not phys addr & pfn.

Here I probably can agree.

-- 
With Best Regards,
Andy Shevchenko



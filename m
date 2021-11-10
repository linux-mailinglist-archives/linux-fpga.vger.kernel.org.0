Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF24944BCCC
	for <lists+linux-fpga@lfdr.de>; Wed, 10 Nov 2021 09:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbhKJI15 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 10 Nov 2021 03:27:57 -0500
Received: from mga14.intel.com ([192.55.52.115]:24874 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229850AbhKJI15 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 10 Nov 2021 03:27:57 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10163"; a="232869524"
X-IronPort-AV: E=Sophos;i="5.87,223,1631602800"; 
   d="scan'208";a="232869524"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2021 00:25:01 -0800
X-IronPort-AV: E=Sophos;i="5.87,223,1631602800"; 
   d="scan'208";a="492009144"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2021 00:24:59 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mkiuV-005LpB-Jm;
        Wed, 10 Nov 2021 10:24:47 +0200
Date:   Wed, 10 Nov 2021 10:24:47 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Tom Rix <trix@redhat.com>
Cc:     Moritz Fischer <mdf@kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>
Subject: Re: [PATCH v1 1/1] fpga: dfl: pci: Use pci_find_vsec_capability()
 when looking for DFL
Message-ID: <YYuBz0tdduAk1c/6@smile.fi.intel.com>
References: <20211109154127.18455-1-andriy.shevchenko@linux.intel.com>
 <8ccc133a-fb47-4548-fee3-d57775a5166d@redhat.com>
 <YYq4fSRoyzFE4Vei@smile.fi.intel.com>
 <39ac1f40-66ab-6c7e-0042-8fcdc062ed00@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39ac1f40-66ab-6c7e-0042-8fcdc062ed00@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Nov 09, 2021 at 10:27:58AM -0800, Tom Rix wrote:
> On 11/9/21 10:05 AM, Andy Shevchenko wrote:
> > On Tue, Nov 09, 2021 at 07:55:43AM -0800, Tom Rix wrote:
> > > On 11/9/21 7:41 AM, Andy Shevchenko wrote:

...

> > > > +	voff = pci_find_vsec_capability(dev, PCI_VENDOR_ID_INTEL, PCI_VSEC_ID_INTEL_DFLS);
> > > This may be a weakness in the origin code, but intel isn't the exclusive
> > > user of DFL.
> > This does not change the original code. If you think so, this can be extended
> > later on.
> 
> I would rather see this fixed now or explained why this isn't a problem.

This is out of scope of this change in a few ways:
 - we don't do 2+ things in one patch
 - the change doesn't change behaviour
 - the change is a simple cleanup
 - another vendor may well have quite different VSEC ID for DFL

If you think that it should be needed, one can come up with it later on.

-- 
With Best Regards,
Andy Shevchenko



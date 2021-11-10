Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36A7A44BAB4
	for <lists+linux-fpga@lfdr.de>; Wed, 10 Nov 2021 04:51:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbhKJDyj (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 9 Nov 2021 22:54:39 -0500
Received: from mga04.intel.com ([192.55.52.120]:42692 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229963AbhKJDyj (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 9 Nov 2021 22:54:39 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10163"; a="231319822"
X-IronPort-AV: E=Sophos;i="5.87,222,1631602800"; 
   d="scan'208";a="231319822"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2021 19:51:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,222,1631602800"; 
   d="scan'208";a="602061612"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.68])
  by orsmga004.jf.intel.com with ESMTP; 09 Nov 2021 19:51:49 -0800
Date:   Wed, 10 Nov 2021 11:44:57 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     matthew.gerlach@linux.intel.com
Cc:     Tom Rix <trix@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, Wu Hao <hao.wu@intel.com>
Subject: Re: [PATCH v1 1/1] fpga: dfl: pci: Use pci_find_vsec_capability()
  when looking for DFL
Message-ID: <20211110034457.GA286728@yilunxu-OptiPlex-7050>
References: <20211109154127.18455-1-andriy.shevchenko@linux.intel.com>
 <8ccc133a-fb47-4548-fee3-d57775a5166d@redhat.com>
 <YYq4fSRoyzFE4Vei@smile.fi.intel.com>
 <39ac1f40-66ab-6c7e-0042-8fcdc062ed00@redhat.com>
 <alpine.DEB.2.22.394.2111091044060.1548144@rhweight-WRK1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2111091044060.1548144@rhweight-WRK1>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Nov 09, 2021 at 10:51:33AM -0800, matthew.gerlach@linux.intel.com wrote:
> 
> 
> On Tue, 9 Nov 2021, Tom Rix wrote:
> 
> > 
> > On 11/9/21 10:05 AM, Andy Shevchenko wrote:
> > > On Tue, Nov 09, 2021 at 07:55:43AM -0800, Tom Rix wrote:
> > > > On 11/9/21 7:41 AM, Andy Shevchenko wrote:
> > > > > Currently the find_dfls_by_vsec() opens code pci_find_vsec_capability().
> > > > > Refactor the former to use the latter. No functional change intended.
> > > Thanks for review, my answers below.
> > > 
> > > ...
> > > 
> > > > > +	u16 voff;
> > > > The later use of voff in pci_read_config_dword is of type 'int', it may be
> > > > better to keep voff as an int.
> > > I don't think so. The rule of thumb that the types should match the
> > > value they
> > > got in the first place. In this case it's u16. Compiler will
> > > implicitly cast it
> > > to whatever is needed as long as the type is good for integer promotion.
> > > 
> 
> I think u16 is more precise than int, but I think it'll get promoted to an
> int anywhen when used with calls to pci_read_config_dword().  Was this

I agree u16 is OK.

A minor concern, is it better we also change the dfl_res_off to u16?
dfl_res_off & voff are the same type of variables needed on positioning
the DFL, so I'd like them listed together.

> change tested on real or emulated HW?
> 
> > > ...
> > > 
> > > > > +	voff = pci_find_vsec_capability(dev, PCI_VENDOR_ID_INTEL,
> > > > > PCI_VSEC_ID_INTEL_DFLS);
> > > > This may be a weakness in the origin code, but intel isn't the exclusive
> > > > user of DFL.
> > > This does not change the original code. If you think so, this can be
> > > extended
> > > later on.
> > 
> > I would rather see this fixed now or explained why this isn't a problem.
> 
> I agree that a single Vendor/VSEC id being supported is a problem, but I
> think fixing it should be a separate patch.  Do we need to change this a

I agree. The vendor_id should be checked before VSEC ID is meaningful,
and now this Vendor/VSEC pair is the only supported one, so this piece of
code is good to me.

> table lookup of Vendor/VSEC id's, or do we need to reserve a more generic
> Vendor/VSEC pair?

A generic Vendor/VSEC pair means all vendors must use the unified
vendor_id if they want to use DFL. I'm not sure if this is proper.

Thanks,
Yilun

> 
> > 
> > Tom
> > 
> > > 
> > > > >    	if (!voff) {
> > > > >    		dev_dbg(&pcidev->dev, "%s no DFL VSEC found\n", __func__);
> > > > >    		return -ENODEV;
> > 
> > 

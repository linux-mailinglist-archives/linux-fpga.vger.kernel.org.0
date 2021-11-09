Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50E6744B256
	for <lists+linux-fpga@lfdr.de>; Tue,  9 Nov 2021 19:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241617AbhKISIv (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 9 Nov 2021 13:08:51 -0500
Received: from mga12.intel.com ([192.55.52.136]:36213 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241585AbhKISIu (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 9 Nov 2021 13:08:50 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10163"; a="212541328"
X-IronPort-AV: E=Sophos;i="5.87,220,1631602800"; 
   d="scan'208";a="212541328"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2021 10:06:04 -0800
X-IronPort-AV: E=Sophos;i="5.87,220,1631602800"; 
   d="scan'208";a="533773655"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2021 10:06:02 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mkVVG-005APw-6V;
        Tue, 09 Nov 2021 20:05:50 +0200
Date:   Tue, 9 Nov 2021 20:05:49 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Tom Rix <trix@redhat.com>
Cc:     Moritz Fischer <mdf@kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>
Subject: Re: [PATCH v1 1/1] fpga: dfl: pci: Use pci_find_vsec_capability()
 when looking for DFL
Message-ID: <YYq4fSRoyzFE4Vei@smile.fi.intel.com>
References: <20211109154127.18455-1-andriy.shevchenko@linux.intel.com>
 <8ccc133a-fb47-4548-fee3-d57775a5166d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ccc133a-fb47-4548-fee3-d57775a5166d@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Nov 09, 2021 at 07:55:43AM -0800, Tom Rix wrote:
> On 11/9/21 7:41 AM, Andy Shevchenko wrote:
> > Currently the find_dfls_by_vsec() opens code pci_find_vsec_capability().
> > Refactor the former to use the latter. No functional change intended.

Thanks for review, my answers below.

...

> > +	u16 voff;
> The later use of voff in pci_read_config_dword is of type 'int', it may be
> better to keep voff as an int.

I don't think so. The rule of thumb that the types should match the value they
got in the first place. In this case it's u16. Compiler will implicitly cast it
to whatever is needed as long as the type is good for integer promotion.

...

> > +	voff = pci_find_vsec_capability(dev, PCI_VENDOR_ID_INTEL, PCI_VSEC_ID_INTEL_DFLS);
> 
> This may be a weakness in the origin code, but intel isn't the exclusive
> user of DFL.

This does not change the original code. If you think so, this can be extended
later on.

> >   	if (!voff) {
> >   		dev_dbg(&pcidev->dev, "%s no DFL VSEC found\n", __func__);
> >   		return -ENODEV;

-- 
With Best Regards,
Andy Shevchenko



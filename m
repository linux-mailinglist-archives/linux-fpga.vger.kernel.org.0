Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFF3219C6F
	for <lists+linux-fpga@lfdr.de>; Thu,  9 Jul 2020 11:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbgGIJjd (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 9 Jul 2020 05:39:33 -0400
Received: from mga07.intel.com ([134.134.136.100]:32124 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726261AbgGIJjc (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 9 Jul 2020 05:39:32 -0400
IronPort-SDR: FRQBPIUQbBYqHnGi2xhlRCOw8AjWBG3k81KFebQ/RLaWlifM2O3y2VP/DEj524y/DwnQrjLEko
 dNfS9pgfA1xg==
X-IronPort-AV: E=McAfee;i="6000,8403,9676"; a="212882877"
X-IronPort-AV: E=Sophos;i="5.75,331,1589266800"; 
   d="scan'208";a="212882877"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2020 02:39:31 -0700
IronPort-SDR: G0DDcW5MkFbaqHHnb6bsxH2Lg7sOHpQA5T1pGyDFgvaBnFhlznBkmjPjfx42yK2l4ak7tqJynu
 cWl8pDDgqVeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,331,1589266800"; 
   d="scan'208";a="483735217"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by fmsmga006.fm.intel.com with ESMTP; 09 Jul 2020 02:39:29 -0700
Date:   Thu, 9 Jul 2020 17:35:27 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     "Wu, Hao" <hao.wu@intel.com>
Cc:     "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "trix@redhat.com" <trix@redhat.com>,
        "lgoncalv@redhat.com" <lgoncalv@redhat.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        "Weight, Russell H" <russell.h.weight@intel.com>
Subject: Re: [PATCH] fpga: dfl: pci: add device id for Intel FPGA PAC N3000
Message-ID: <20200709093527.GA32541@yilunxu-OptiPlex-7050>
References: <1594282705-32289-1-git-send-email-yilun.xu@intel.com>
 <DM6PR11MB3819117029F124067F7EA8B985640@DM6PR11MB3819.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB3819117029F124067F7EA8B985640@DM6PR11MB3819.namprd11.prod.outlook.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, Jul 09, 2020 at 05:10:49PM +0800, Wu, Hao wrote:
> > Subject: [PATCH] fpga: dfl: pci: add device id for Intel FPGA PAC N3000
> >
> > Add PCIe Device ID for Intel FPGA PAC N3000.
> >
> > Signed-off-by: Wu Hao <hao.wu@intel.com>
> > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> > ---
> >  drivers/fpga/dfl-pci.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
> > index 73b5153..824aecf 100644
> > --- a/drivers/fpga/dfl-pci.c
> > +++ b/drivers/fpga/dfl-pci.c
> > @@ -64,6 +64,7 @@ static void cci_pci_free_irq(struct pci_dev *pcidev)
> >  #define PCIE_DEVICE_ID_PF_INT_5_X0xBCBD
> >  #define PCIE_DEVICE_ID_PF_INT_6_X0xBCC0
> >  #define PCIE_DEVICE_ID_PF_DSC_1_X0x09C4
> > +#define PCIE_DEVICE_ID_PF_PAC_N30000x0B30
> 
> Should we drop _PF_ here? and also do you want _INTEL_ here?

I think we could keep _PF_, also there is no need to support VF of pac
n3000 in product now, but it does exist (ID: 0x0b31).

And add _INTEL_ is good to me.

Then how about this one:
  #define PCIE_DEVICE_ID_PF_INTEL_PAC_N3000	0x0B30

> 
> Thanks
> Hao

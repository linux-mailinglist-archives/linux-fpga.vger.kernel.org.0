Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2182279A3
	for <lists+linux-fpga@lfdr.de>; Tue, 21 Jul 2020 09:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbgGUHng (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 21 Jul 2020 03:43:36 -0400
Received: from mga14.intel.com ([192.55.52.115]:33980 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726389AbgGUHng (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 21 Jul 2020 03:43:36 -0400
IronPort-SDR: UpWHygMqV8zhPtp0k06S7xf+7hsyfy3VEtZ5pisOt+m7XdgZF2cymyvxgZyDuUN6Cxovj7ZMUa
 c4A7t5K1Ap5A==
X-IronPort-AV: E=McAfee;i="6000,8403,9688"; a="149236145"
X-IronPort-AV: E=Sophos;i="5.75,378,1589266800"; 
   d="scan'208";a="149236145"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2020 00:43:35 -0700
IronPort-SDR: iqbMeA+6tWKmX7+r07yBRC38+nVMDfTOrAw7ZGC1dsuLBwLN4eSTIAQbhKAEOhH3HDzntBS8dm
 Ja4IymKAbj1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,378,1589266800"; 
   d="scan'208";a="431893396"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by orsmga004.jf.intel.com with ESMTP; 21 Jul 2020 00:43:33 -0700
Date:   Tue, 21 Jul 2020 15:40:25 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     "Wu, Hao" <hao.wu@intel.com>
Cc:     "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "trix@redhat.com" <trix@redhat.com>,
        "lgoncalv@redhat.com" <lgoncalv@redhat.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        "Weight, Russell H" <russell.h.weight@intel.com>
Subject: Re: [PATCH 1/2] fpga: dfl: map feature mmio resources in their own
  feature drivers
Message-ID: <20200721074025.GF17091@yilunxu-OptiPlex-7050>
References: <1594791498-14495-1-git-send-email-yilun.xu@intel.com>
 <1594791498-14495-2-git-send-email-yilun.xu@intel.com>
 <DM6PR11MB381928806B8E65BEEF66D07F857B0@DM6PR11MB3819.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB381928806B8E65BEEF66D07F857B0@DM6PR11MB3819.namprd11.prod.outlook.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Jul 20, 2020 at 05:09:35PM +0800, Wu, Hao wrote:
> > Subject: [PATCH 1/2] fpga: dfl: map feature mmio resources in their own
> > feature drivers
> >
> > This patch makes preparation for modularization of DFL sub feature
> > drivers.
> >
> > Currently, if we need to support a new DFL sub feature, an entry should
> > be added to fme/port_feature_drvs[] in dfl-fme/port-main.c. And we need
> > to re-compile the whole DFL modules. That make the DFL drivers hard to be
> > extended.
> >
> > Another consideration is that DFL may contain some IP blocks which are
> > already supported by kernel, most of them are supported by platform
> > device drivers. We could create platform devices for these IP blocks and
> > get them supported by these drivers.
> >
> > An important issue is that platform device drivers usually requests mmio
> > resources on probe. But now dfl mmio is mapped in dfl bus driver (e.g.
> > dfl-pci) as a whole region. Then platform device drivers for sub features
> > can't request their own mmio resources again. This is what the patch
> > trying to resolve.
> >
> > This patch changes the DFL enumeration. DFL bus driver will unmap mmio
> > resources after first step enumeration and pass enumeration info to DFL
> > framework. Then DFL framework will map the mmio resources again, do 2nd
> > step enumeration, and also unmap the mmio resources. In this way, sub
> > feature drivers could then request their own mmio resources as needed.
> >
> > An exception is that mmio resource of FIU headers are still mapped in dfl
> > bus driver. The FIU headers have some fundamental functions (sriov set,
> > port enable/disable) needed for dfl bus devices and other sub features.
> > They should not be unmapped as long as dfl bus device is alive.
> >
> > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > Signed-off-by: Wu Hao <hao.wu@intel.com>
> > Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> > ---
> >  drivers/fpga/dfl-pci.c |  21 ++++--
> >  drivers/fpga/dfl.c     | 187 +++++++++++++++++++++++++++++++++++-----------
> > ---
> >  drivers/fpga/dfl.h     |   6 +-
> >  3 files changed, 152 insertions(+), 62 deletions(-)
> >
> > diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
> > index e220bec..22dc025 100644
> > --- a/drivers/fpga/dfl-pci.c
> > +++ b/drivers/fpga/dfl-pci.c
> > @@ -39,6 +39,11 @@ static void __iomem *cci_pci_ioremap_bar(struct
> > pci_dev *pcidev, int bar)
> >  return pcim_iomap_table(pcidev)[bar];
> >  }
> >
> > +static void cci_pci_iounmap_bars(struct pci_dev *pcidev, int mapped_bars)
> > +{
> > +pcim_iounmap_regions(pcidev, mapped_bars);
> > +}
> > +
> >  static int cci_pci_alloc_irq(struct pci_dev *pcidev)
> >  {
> >  int ret, nvec = pci_msix_vec_count(pcidev);
> > @@ -123,7 +128,7 @@ static int *cci_pci_create_irq_table(struct pci_dev
> > *pcidev, unsigned int nvec)
> >  static int cci_enumerate_feature_devs(struct pci_dev *pcidev)
> >  {
> >  struct cci_drvdata *drvdata = pci_get_drvdata(pcidev);
> > -int port_num, bar, i, nvec, ret = 0;
> > +int port_num, bar, i, nvec, mapped_bars, ret = 0;
> >  struct dfl_fpga_enum_info *info;
> >  struct dfl_fpga_cdev *cdev;
> >  resource_size_t start, len;
> > @@ -163,6 +168,8 @@ static int cci_enumerate_feature_devs(struct pci_dev
> > *pcidev)
> >  goto irq_free_exit;
> >  }
> >
> > +mapped_bars = BIT(0);
> > +
> >  /*
> >   * PF device has FME and Ports/AFUs, and VF device only has one
> >   * Port/AFU. Check them and add related "Device Feature List" info
> > @@ -172,7 +179,7 @@ static int cci_enumerate_feature_devs(struct pci_dev
> > *pcidev)
> >  start = pci_resource_start(pcidev, 0);
> >  len = pci_resource_len(pcidev, 0);
> >
> > -dfl_fpga_enum_info_add_dfl(info, start, len, base);
> > +dfl_fpga_enum_info_add_dfl(info, start, len);
> >
> >  /*
> >   * find more Device Feature Lists (e.g. Ports) per information
> > @@ -200,22 +207,26 @@ static int cci_enumerate_feature_devs(struct
> > pci_dev *pcidev)
> >  if (!base)
> >  continue;
> >
> > +mapped_bars |= BIT(bar);
> > +
> 
> One more place,
> 
> As you removed base addr usage below, so ideally we don't need to map
> more bars for port here? is my understanding correct?

Exactly, thanks for the catching. This makes the code much simpler.

Thanks,
Yilun

> 
> >  start = pci_resource_start(pcidev, bar) + offset;
> >  len = pci_resource_len(pcidev, bar) - offset;
> >
> > -dfl_fpga_enum_info_add_dfl(info, start, len,
> > -   base + offset);
> > +dfl_fpga_enum_info_add_dfl(info, start, len);
> 
> Thanks
> Hao

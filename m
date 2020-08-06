Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A015723D830
	for <lists+linux-fpga@lfdr.de>; Thu,  6 Aug 2020 10:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbgHFIyG (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 6 Aug 2020 04:54:06 -0400
Received: from mga11.intel.com ([192.55.52.93]:12501 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726094AbgHFIyG (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 6 Aug 2020 04:54:06 -0400
IronPort-SDR: 8riitl7awcECN3o2wbk13vGeGzfMPGMok5606GAPhdt5VIXfEPB8BJL8W+fzzu+9/ujc+akih5
 m4o/EKj9f0fg==
X-IronPort-AV: E=McAfee;i="6000,8403,9704"; a="150498635"
X-IronPort-AV: E=Sophos;i="5.75,441,1589266800"; 
   d="scan'208";a="150498635"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2020 01:54:05 -0700
IronPort-SDR: InD2z2LzvaoEpB1qIUDjK4uckbvUGxbnedd0SgcCWvZeFkxTjiopNMxEng1nNiYcDnpaPK2q48
 MyN9lEd/qgJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,441,1589266800"; 
   d="scan'208";a="493125492"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by fmsmga006.fm.intel.com with ESMTP; 06 Aug 2020 01:54:03 -0700
Date:   Thu, 6 Aug 2020 16:50:33 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     "Wu, Hao" <hao.wu@intel.com>
Cc:     "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "trix@redhat.com" <trix@redhat.com>,
        "lgoncalv@redhat.com" <lgoncalv@redhat.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        "Weight, Russell H" <russell.h.weight@intel.com>
Subject: Re: [PATCH v3 3/4] fpga: dfl: create a dfl bus type to support DFL
   devices
Message-ID: <20200806085033.GA13943@yilunxu-OptiPlex-7050>
References: <1596524715-18038-1-git-send-email-yilun.xu@intel.com>
 <1596524715-18038-4-git-send-email-yilun.xu@intel.com>
 <DM6PR11MB38194B629A3DC70FC0E8A010854B0@DM6PR11MB3819.namprd11.prod.outlook.com>
 <20200806060257.GB7179@yilunxu-OptiPlex-7050>
 <DM6PR11MB3819D5CFD0A46DCE02C9EF1A85480@DM6PR11MB3819.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB3819D5CFD0A46DCE02C9EF1A85480@DM6PR11MB3819.namprd11.prod.outlook.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, Aug 06, 2020 at 03:11:14PM +0800, Wu, Hao wrote:
> > > > +static int dfl_bus_uevent(struct device *dev, struct kobj_uevent_env
> > *env)
> > > > +{
> > > > +struct dfl_device *ddev = to_dfl_dev(dev);
> > > > +
> > > > +return add_uevent_var(env, "MODALIAS=dfl:t%08Xf%04X",
> > > > +      ddev->type, ddev->feature_id);
> > >
> > > Then we only print 12bit of feature_id will be enough?
> > > should we make type shorter as well as feature id?
> >
> > I could envision that we need a struct
> >
> >  struct dfl_feature_id {
> > u16 id: 12;
> >  }
> >
> > for it.
> >
> > But it seems more complex and I didn't see the benifit. We don't have to
> > worry about the invalid values cause we parse all the ddev->feature_id in
> > dfl driver, and ensures it will not be larger than 12bit value.
> 
> Ideally type is only 4bits per spec, but looks like it's adding more zero before
> the type value, and also the feature id. This may not be a real problem, but
> may look a little wired, isn't it?

OK, I could change the print.

> 
> >
> > > And do you think if we should add a new field for dfl version?
> >
> > I think it may not be necessary now. If we support dfl v1 in future, we
> > still could try to check uuid first, then fall back to type &
> > feature_id.
> 
> I think it's all about the uevent and it's user, and for users, they may have to
> deal with different versions, right? As you mentioned, if the event will be
> different format for v1 and it's not compatible with v0, anyway we need
> the version sooner or later, is my understanding correct?

The version is not needed for uevent. The different formats of
uevents explain themselves (dfl v0 or dfl v1), is it?
If we add the dfl version in uevent then we should also add
the version in struct dfl_device_id, and all dfl driver should fill the
version info in its id_table. But actually that's redundent work to
driver developer.

The version in struct dfl_device may simplify the internal code on how
to format the uevent. But considering the only extension of dflv1 I
think checking the null uuid is also simply enough.

> 
> >
> > Do you have any idea for the potential usage of dfl version.
> >
> 
> > > > +/* then add irq resource */
> > > > +if (feature->nr_irqs) {
> > > > +ddev->irqs = kcalloc(feature->nr_irqs,
> > > > +     sizeof(*ddev->irqs), GFP_KERNEL);
> > > > +if (!ddev->irqs) {
> > > > +ret = -ENOMEM;
> > > > +goto put_dev;
> > > > +}
> > > > +
> > > > +for (i = 0; i < feature->nr_irqs; i++)
> > > > +ddev->irqs[i] = feature->irq_ctx[i].irq;
> > > > +
> > > > +ddev->num_irqs = feature->nr_irqs;
> > >
> > > Do we need to consider using IORESOURCE_IRQ here as well?
> >
> > The helper functions for IORESOURCE_IRQ are all for platform_devices,
> > We need to define a set of functions similar to them, I think current
> > implementation is simpler, for dfl bus and drivers.
> 
> If some case that it's going to reuse some platform device driver,
> then dfl_device driver will create platform device, it has to pass the mmio
> and irq resources to platform device driver, how you plan to do that?

I think even we create struct resource array for dfl_devices, the dfl
driver still has to create and fill its pdev resource as needed. There
is little chance the driver could just memcpy them. So the dfl driver
could fill the irq resources of pdev according to ddev->irqs & num_irqs.

> 
> > > > +static int dfl_devs_init(struct platform_device *pdev)
> > > > +{
> > > > +struct dfl_feature_platform_data *pdata = dev_get_platdata(&pdev-
> > > > >dev);
> > > > +struct dfl_feature *feature;
> > > > +struct dfl_device *ddev;
> > > > +
> > > > +dfl_fpga_dev_for_each_feature(pdata, feature) {
> > > > +if (feature->ioaddr || feature->priv)
> > >
> > > Why checks priv here?
> >
> > I want to make sure the dfl_device is not already created.
> 
> Is that a valid case that we expected? or sounds like error code needs
> to be returned?

OK. It is invalid, I could error out in this case.

> 
> Thanks
> Hao

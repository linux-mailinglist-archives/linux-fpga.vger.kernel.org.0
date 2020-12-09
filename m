Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE132D3E0C
	for <lists+linux-fpga@lfdr.de>; Wed,  9 Dec 2020 10:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgLIJB6 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 9 Dec 2020 04:01:58 -0500
Received: from mga01.intel.com ([192.55.52.88]:29830 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbgLIJB6 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 9 Dec 2020 04:01:58 -0500
IronPort-SDR: o/OqkZwW0Mu2nJDxD6IC+8VgNrswiv5PpluMADaKfV26hgWgjXjLNocW9s34xb5DdHsSXQTxmb
 uiPgPHx1/+kg==
X-IronPort-AV: E=McAfee;i="6000,8403,9829"; a="192345508"
X-IronPort-AV: E=Sophos;i="5.78,405,1599548400"; 
   d="scan'208";a="192345508"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2020 01:01:14 -0800
IronPort-SDR: +L64zLlKXOxYoF9nb6tcIHNktWFpUAouuuDI/Ixrw+SeGm7O4jfY8sKIP3YKP50NlYIQBaL3um
 JE7zZv3PaGFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,405,1599548400"; 
   d="scan'208";a="368111398"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by fmsmga004.fm.intel.com with ESMTP; 09 Dec 2020 01:01:13 -0800
Date:   Wed, 9 Dec 2020 16:56:34 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Tom Rix <trix@redhat.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, hao.wu@intel.com,
        mdf@kernel.org, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: Re: [RFC] fpga: dfl: a prototype uio driver
Message-ID: <20201209085634.GC29754@yilunxu-OptiPlex-7050>
References: <20201206215554.350230-1-trix@redhat.com>
 <X83hkdgrMysGuUdL@kroah.com>
 <53097eaf-02ee-8e41-9738-107115dc9dcd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <53097eaf-02ee-8e41-9738-107115dc9dcd@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Tom:

On Mon, Dec 07, 2020 at 05:07:05AM -0800, Tom Rix wrote:
> 
> On 12/7/20 12:02 AM, Greg KH wrote:
> > On Sun, Dec 06, 2020 at 01:55:54PM -0800, trix@redhat.com wrote:
> >> From: Tom Rix <trix@redhat.com>
> >>
> >> >From [PATCH 0/2] UIO support for dfl devices
> >> https://lore.kernel.org/linux-fpga/1602828151-24784-1-git-send-email-yilun.xu@intel.com/
> > Why is this here?
> 
> As reference, Yilun's work has precedence for a uio driver and this rfc is trying to address what i believe is a sticking point of the driver override.  This rfc is some code i hacked out to show the idea and move uio support along.  I would like to see uio support for at least the unclaimed feature id's because this would make it easier for them to be developed.

I see there is concern about sharing DFL devices for both UIO and kernel
drivers. Even if a lock could be created to serialize the accesses of
both interfaces, they could potentially impact each other without notice
on hardware level.

Maybe it is better we split the uio driver for unclaimed features. But
how we could know it is an unclaimed feature, may be for simplicity we
list the feature ids in device id table for dfl uio driver? We should
change the code of dfl uio when we want to use uio for a new dfl device,
is that acceptable?

Thanks,
Yilun

> 
> >> Here is an idea to have uio support with no driver override.
> >>
> >> This makes UIO the primary driver interface because every feature
> >> will have one and makes the existing platform driver interface
> >> secondary.  There will be a new burden for locking write access when
> >> they compete.
> >>
> >> Example shows finding the fpga's temperture.
> >>
> >> Signed-off-by: Tom Rix <trix@redhat.com>
> >> ---
> >>  drivers/fpga/dfl-fme-main.c |  9 +++-
> >>  drivers/fpga/dfl-uio.c      | 96 +++++++++++++++++++++++++++++++++++++
> >>  drivers/fpga/dfl.c          | 44 ++++++++++++++++-
> >>  drivers/fpga/dfl.h          |  9 ++++
> >>  uio.c                       | 56 ++++++++++++++++++++++
> >>  5 files changed, 212 insertions(+), 2 deletions(-)
> >>  create mode 100644 drivers/fpga/dfl-uio.c
> >>  create mode 100644 uio.c
> >>
> >> diff --git a/drivers/fpga/dfl-fme-main.c b/drivers/fpga/dfl-fme-main.c
> >> index 037dc4f946f0..3323e90a18c4 100644
> >> --- a/drivers/fpga/dfl-fme-main.c
> >> +++ b/drivers/fpga/dfl-fme-main.c
> >> @@ -709,12 +709,18 @@ static int fme_probe(struct platform_device *pdev)
> >>  	if (ret)
> >>  		goto dev_destroy;
> >>  
> >> -	ret = dfl_fpga_dev_ops_register(pdev, &fme_fops, THIS_MODULE);
> >> +	ret = dfl_fpga_dev_feature_init_uio(pdev, DFH_TYPE_FIU);
> >>  	if (ret)
> >>  		goto feature_uinit;
> >>  
> >> +	ret = dfl_fpga_dev_ops_register(pdev, &fme_fops, THIS_MODULE);
> >> +	if (ret)
> >> +		goto feature_uinit_uio;
> >> +
> >>  	return 0;
> >>  
> >> +feature_uinit_uio:
> >> +	dfl_fpga_dev_feature_uinit_uio(pdev, DFH_TYPE_FIU);
> >>  feature_uinit:
> >>  	dfl_fpga_dev_feature_uinit(pdev);
> >>  dev_destroy:
> >> @@ -726,6 +732,7 @@ exit:
> >>  static int fme_remove(struct platform_device *pdev)
> >>  {
> >>  	dfl_fpga_dev_ops_unregister(pdev);
> >> +	dfl_fpga_dev_feature_uinit_uio(pdev, DFH_TYPE_FIU);
> >>  	dfl_fpga_dev_feature_uinit(pdev);
> >>  	fme_dev_destroy(pdev);
> >>  
> >> diff --git a/drivers/fpga/dfl-uio.c b/drivers/fpga/dfl-uio.c
> >> new file mode 100644
> >> index 000000000000..7610ee0b19dc
> >> --- /dev/null
> >> +++ b/drivers/fpga/dfl-uio.c
> >> @@ -0,0 +1,96 @@
> >> +/* SPDX-License-Identifier: GPL-2.0 */
> >> +/*
> >> + * prototype dfl uio driver
> >> + *
> >> + * Copyright Tom Rix 2020
> >> + */
> >> +#include <linux/module.h>
> >> +#include "dfl.h"
> >> +
> >> +static irqreturn_t dfl_uio_handler(int irq, struct uio_info *info)
> >> +{
> >> +	return IRQ_HANDLED;
> >> +}
> >> +
> >> +static int dfl_uio_mmap(struct uio_info *info, struct vm_area_struct *vma)
> >> +{
> >> +	int ret = -ENODEV;
> >> +	return ret;
> > Did you run this through checkpatch?
> >
> > Does the code make sense?
> >
> >> +}
> >> +
> >> +static int dfl_uio_open(struct uio_info *info, struct inode *inode)
> >> +{
> >> +	int ret = -ENODEV;
> >> +	struct dfl_feature *feature = container_of(info, struct dfl_feature, uio);
> >> +	if (feature->dev)
> >> +		mutex_lock(&feature->lock);
> >> +
> >> +	ret = 0;
> >> +	return ret;
> > Same here, does this make sense?
> >
> > And wait, you are having userspace grab a kernel lock?  What could go
> > wrong?  :(
> >
> Yes, this is the bad part of this idea.
> 
> Tom
> 
> 
> >> +}
> >> +
> >> +static int dfl_uio_release(struct uio_info *info, struct inode *inode)
> >> +{
> >> +	int ret = -ENODEV;
> >> +	struct dfl_feature *feature = container_of(info, struct dfl_feature, uio);
> >> +	if (feature->dev)
> >> +		mutex_unlock(&feature->lock);
> >> +
> >> +	ret = 0;
> >> +	return ret;
> >> +}
> >> +
> >> +static int dfl_uio_irqcontrol(struct uio_info *info, s32 irq_on)
> >> +{
> >> +	int ret = -ENODEV;
> >> +	return ret;
> >> +}
> >> +
> >> +int dfl_uio_add(struct dfl_feature *feature)
> >> +{
> >> +	struct uio_info *uio = &feature->uio;
> >> +	struct resource *res =
> >> +		&feature->dev->resource[feature->resource_index];
> >> +	int ret = 0;
> >> +
> >> +	uio->name = kasprintf(GFP_KERNEL, "dfl-uio-%llx", feature->id);
> >> +	if (!uio->name) {
> >> +		ret = -ENOMEM;
> >> +		goto exit;
> >> +	}
> >> +
> >> +	uio->version = "0.1";
> >> +	uio->mem[0].memtype = UIO_MEM_PHYS;
> >> +	uio->mem[0].addr = res->start & PAGE_MASK;
> >> +	uio->mem[0].offs = res->start & ~PAGE_MASK;
> >> +	uio->mem[0].size = (uio->mem[0].offs + resource_size(res)
> >> +			    + PAGE_SIZE - 1) & PAGE_MASK;
> >> +	/* How are nr_irqs > 1 handled ??? */
> >> +	if (feature->nr_irqs == 1)
> >> +		uio->irq = feature->irq_ctx[0].irq;
> >> +	uio->handler = dfl_uio_handler;
> >> +	//uio->mmap = dfl_uio_mmap;
> > ???
> >
> > I don't understand what this patch is trying to show...
> > thanks,
> >
> > greg k-h
> >

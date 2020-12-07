Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9989C2D0B6C
	for <lists+linux-fpga@lfdr.de>; Mon,  7 Dec 2020 09:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbgLGIB5 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 7 Dec 2020 03:01:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:41772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726126AbgLGIBz (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 7 Dec 2020 03:01:55 -0500
Date:   Mon, 7 Dec 2020 09:02:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1607328075;
        bh=1HSeYOYJiWP1uEvgndSKEe0JixZnkmlIsE+hcM2rUdU=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=KCIrDHQbXT/az9/0ZFkln65dScvIGofPxM3AyFWHjYiWBmSOi1o5EYfKCzzy7X+xW
         d1yzwmLHox26ejO+cyFdTabqnLDNl++0swtNJdqWO9Vnb/4bTwUhRUArAvE7AYi52G
         hIucQDzeF/ZhtZuD24wyUs/Il4Nvrvjw+nMaEG6s=
From:   Greg KH <gregkh@linuxfoundation.org>
To:     trix@redhat.com
Cc:     yilun.xu@intel.com, hao.wu@intel.com, mdf@kernel.org,
        linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: Re: [RFC] fpga: dfl: a prototype uio driver
Message-ID: <X83hkdgrMysGuUdL@kroah.com>
References: <20201206215554.350230-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201206215554.350230-1-trix@redhat.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Sun, Dec 06, 2020 at 01:55:54PM -0800, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> >From [PATCH 0/2] UIO support for dfl devices
> https://lore.kernel.org/linux-fpga/1602828151-24784-1-git-send-email-yilun.xu@intel.com/

Why is this here?
> 
> Here is an idea to have uio support with no driver override.
> 
> This makes UIO the primary driver interface because every feature
> will have one and makes the existing platform driver interface
> secondary.  There will be a new burden for locking write access when
> they compete.
> 
> Example shows finding the fpga's temperture.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/fpga/dfl-fme-main.c |  9 +++-
>  drivers/fpga/dfl-uio.c      | 96 +++++++++++++++++++++++++++++++++++++
>  drivers/fpga/dfl.c          | 44 ++++++++++++++++-
>  drivers/fpga/dfl.h          |  9 ++++
>  uio.c                       | 56 ++++++++++++++++++++++
>  5 files changed, 212 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/fpga/dfl-uio.c
>  create mode 100644 uio.c
> 
> diff --git a/drivers/fpga/dfl-fme-main.c b/drivers/fpga/dfl-fme-main.c
> index 037dc4f946f0..3323e90a18c4 100644
> --- a/drivers/fpga/dfl-fme-main.c
> +++ b/drivers/fpga/dfl-fme-main.c
> @@ -709,12 +709,18 @@ static int fme_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto dev_destroy;
>  
> -	ret = dfl_fpga_dev_ops_register(pdev, &fme_fops, THIS_MODULE);
> +	ret = dfl_fpga_dev_feature_init_uio(pdev, DFH_TYPE_FIU);
>  	if (ret)
>  		goto feature_uinit;
>  
> +	ret = dfl_fpga_dev_ops_register(pdev, &fme_fops, THIS_MODULE);
> +	if (ret)
> +		goto feature_uinit_uio;
> +
>  	return 0;
>  
> +feature_uinit_uio:
> +	dfl_fpga_dev_feature_uinit_uio(pdev, DFH_TYPE_FIU);
>  feature_uinit:
>  	dfl_fpga_dev_feature_uinit(pdev);
>  dev_destroy:
> @@ -726,6 +732,7 @@ exit:
>  static int fme_remove(struct platform_device *pdev)
>  {
>  	dfl_fpga_dev_ops_unregister(pdev);
> +	dfl_fpga_dev_feature_uinit_uio(pdev, DFH_TYPE_FIU);
>  	dfl_fpga_dev_feature_uinit(pdev);
>  	fme_dev_destroy(pdev);
>  
> diff --git a/drivers/fpga/dfl-uio.c b/drivers/fpga/dfl-uio.c
> new file mode 100644
> index 000000000000..7610ee0b19dc
> --- /dev/null
> +++ b/drivers/fpga/dfl-uio.c
> @@ -0,0 +1,96 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * prototype dfl uio driver
> + *
> + * Copyright Tom Rix 2020
> + */
> +#include <linux/module.h>
> +#include "dfl.h"
> +
> +static irqreturn_t dfl_uio_handler(int irq, struct uio_info *info)
> +{
> +	return IRQ_HANDLED;
> +}
> +
> +static int dfl_uio_mmap(struct uio_info *info, struct vm_area_struct *vma)
> +{
> +	int ret = -ENODEV;
> +	return ret;

Did you run this through checkpatch?

Does the code make sense?

> +}
> +
> +static int dfl_uio_open(struct uio_info *info, struct inode *inode)
> +{
> +	int ret = -ENODEV;
> +	struct dfl_feature *feature = container_of(info, struct dfl_feature, uio);
> +	if (feature->dev)
> +		mutex_lock(&feature->lock);
> +
> +	ret = 0;
> +	return ret;

Same here, does this make sense?

And wait, you are having userspace grab a kernel lock?  What could go
wrong?  :(


> +}
> +
> +static int dfl_uio_release(struct uio_info *info, struct inode *inode)
> +{
> +	int ret = -ENODEV;
> +	struct dfl_feature *feature = container_of(info, struct dfl_feature, uio);
> +	if (feature->dev)
> +		mutex_unlock(&feature->lock);
> +
> +	ret = 0;
> +	return ret;
> +}
> +
> +static int dfl_uio_irqcontrol(struct uio_info *info, s32 irq_on)
> +{
> +	int ret = -ENODEV;
> +	return ret;
> +}
> +
> +int dfl_uio_add(struct dfl_feature *feature)
> +{
> +	struct uio_info *uio = &feature->uio;
> +	struct resource *res =
> +		&feature->dev->resource[feature->resource_index];
> +	int ret = 0;
> +
> +	uio->name = kasprintf(GFP_KERNEL, "dfl-uio-%llx", feature->id);
> +	if (!uio->name) {
> +		ret = -ENOMEM;
> +		goto exit;
> +	}
> +
> +	uio->version = "0.1";
> +	uio->mem[0].memtype = UIO_MEM_PHYS;
> +	uio->mem[0].addr = res->start & PAGE_MASK;
> +	uio->mem[0].offs = res->start & ~PAGE_MASK;
> +	uio->mem[0].size = (uio->mem[0].offs + resource_size(res)
> +			    + PAGE_SIZE - 1) & PAGE_MASK;
> +	/* How are nr_irqs > 1 handled ??? */
> +	if (feature->nr_irqs == 1)
> +		uio->irq = feature->irq_ctx[0].irq;
> +	uio->handler = dfl_uio_handler;
> +	//uio->mmap = dfl_uio_mmap;

???

I don't understand what this patch is trying to show...

thanks,

greg k-h

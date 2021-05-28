Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5BCE394481
	for <lists+linux-fpga@lfdr.de>; Fri, 28 May 2021 16:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235665AbhE1OyB (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 28 May 2021 10:54:01 -0400
Received: from mga03.intel.com ([134.134.136.65]:20012 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235415AbhE1OyB (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 28 May 2021 10:54:01 -0400
IronPort-SDR: VoL1VIKR1NlfUHE9A2qxG3vXIeWei9GTtAbTX6qGSTg5ZV5fy0VQDs5rEwUTCtEdAp5YU9YE1q
 iacMH5kDi28Q==
X-IronPort-AV: E=McAfee;i="6200,9189,9998"; a="203003637"
X-IronPort-AV: E=Sophos;i="5.83,229,1616482800"; 
   d="scan'208";a="203003637"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2021 07:52:25 -0700
IronPort-SDR: cmTTLkiZkblT6mMp/Yd81DxGoGo0ulV8juh7u9Le98zhhkITu8knuZBtyZpzrfgc3+OUMZPFwK
 USYCjgni9TIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,229,1616482800"; 
   d="scan'208";a="481071598"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.162])
  by fmsmga002.fm.intel.com with ESMTP; 28 May 2021 07:52:22 -0700
Date:   Fri, 28 May 2021 22:46:55 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     Tom Rix <trix@redhat.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, lgoncalv@redhat.com, hao.wu@intel.com,
        matthew.gerlach@intel.com, richard.gong@intel.com
Subject: Re: [PATCH v3 1/3] fpga: mgr: Use standard dev_release for class
  driver
Message-ID: <20210528144655.GA1881270@yilunxu-OptiPlex-7050>
References: <20210524185049.681683-1-russell.h.weight@intel.com>
 <20210524185049.681683-2-russell.h.weight@intel.com>
 <353d1753-070d-38fc-dfc6-7020aea32c5d@redhat.com>
 <cf4bb8d9-6953-ecf6-30a5-8556e5d40959@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cf4bb8d9-6953-ecf6-30a5-8556e5d40959@intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, May 25, 2021 at 09:51:35AM -0700, Russ Weight wrote:
> Hi Tom,
> 
> On 5/24/21 1:16 PM, Tom Rix wrote:
> > Russ,
> >
> > I think the signature fpga_mgr_register, should change to
> >
> > int fpga_mgr_register(struct device *, const struct fpga_mager_ops *mops, void *priv);
> >
> > I'll explain below ..
> >
> > On 5/24/21 11:50 AM, Russ Weight wrote:
> >> The FPGA manager class driver data structure is being treated as a
> >> managed resource instead of using standard dev_release call-back
> >> to release the class data structure. This change removes the
> >> managed resource code for the freeing of the class data structure
> >> and combines the create() and register() functions into a single
> >> register() function.
> >>
> >> The devm_fpga_mgr_register() function is retained.
> >>
> >> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> >> ---
> >> v3:
> >>    - Cleaned up comment header for fpga_mgr_register()
> >>    - Fix error return on ida_simple_get() failure
> >> v2:
> >>    - Restored devm_fpga_mgr_register() functionality, adapted for the combined
> >>      create/register functionality.
> >>    - All previous callers of devm_fpga_mgr_register() will continue to call
> >>      devm_fpga_mgr_register().
> >>    - replaced unnecessary ternary operators in return statements with standard
> >>      if conditions.
> >> ---
> >>   drivers/fpga/altera-cvp.c        |  12 +--
> >>   drivers/fpga/altera-pr-ip-core.c |   8 +-
> >>   drivers/fpga/altera-ps-spi.c     |  10 +-
> >>   drivers/fpga/dfl-fme-mgr.c       |  10 +-
> >>   drivers/fpga/fpga-mgr.c          | 163 ++++++++-----------------------
> >>   drivers/fpga/ice40-spi.c         |  10 +-
> >>   drivers/fpga/machxo2-spi.c       |  10 +-
> >>   drivers/fpga/socfpga-a10.c       |  16 ++-
> >>   drivers/fpga/socfpga.c           |  10 +-
> >>   drivers/fpga/stratix10-soc.c     |  15 +--
> >>   drivers/fpga/ts73xx-fpga.c       |  10 +-
> >>   drivers/fpga/xilinx-spi.c        |  12 +--
> >>   drivers/fpga/zynq-fpga.c         |  16 ++-
> >>   drivers/fpga/zynqmp-fpga.c       |  10 +-
> >>   include/linux/fpga/fpga-mgr.h    |  17 ++--
> >>   15 files changed, 112 insertions(+), 217 deletions(-)
> >>
> >> diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
> >> index 4e0edb60bfba..b61020ceb0a1 100644
> >> --- a/drivers/fpga/altera-cvp.c
> >> +++ b/drivers/fpga/altera-cvp.c
> >> @@ -652,19 +652,15 @@ static int altera_cvp_probe(struct pci_dev *pdev,
> >>       snprintf(conf->mgr_name, sizeof(conf->mgr_name), "%s @%s",
> >>            ALTERA_CVP_MGR_NAME, pci_name(pdev));
> >>   -    mgr = devm_fpga_mgr_create(&pdev->dev, conf->mgr_name,
> >> -                   &altera_cvp_ops, conf);
> >> -    if (!mgr) {
> >> -        ret = -ENOMEM;
> >> +    mgr = fpga_mgr_register(&pdev->dev, conf->mgr_name,
> >> +                &altera_cvp_ops, conf);
> >> +    if (IS_ERR(mgr)) {
> >> +        ret = PTR_ERR(mgr);
> >>           goto err_unmap;
> >>       }
> >>         pci_set_drvdata(pdev, mgr);
> >
> > This is a wrapper around
> >
> > dev_set_drvdata()
> >
> >>   -    ret = fpga_mgr_register(mgr);
> >> -    if (ret)
> >> -        goto err_unmap;
> >> -
> >>       return 0;
> >>     err_unmap:
> >> diff --git a/drivers/fpga/altera-pr-ip-core.c b/drivers/fpga/altera-pr-ip-core.c
> >> index 5b130c4d9882..0980e134cc43 100644
> >> --- a/drivers/fpga/altera-pr-ip-core.c
> >> +++ b/drivers/fpga/altera-pr-ip-core.c
> >> @@ -191,11 +191,11 @@ int alt_pr_register(struct device *dev, void __iomem *reg_base)
> >>           (val & ALT_PR_CSR_STATUS_MSK) >> ALT_PR_CSR_STATUS_SFT,
> >>           (int)(val & ALT_PR_CSR_PR_START));
> >>   -    mgr = devm_fpga_mgr_create(dev, dev_name(dev), &alt_pr_ops, priv);
> > using the name of the device
> >> -    if (!mgr)
> >> -        return -ENOMEM;
> >> +    mgr = devm_fpga_mgr_register(dev, dev_name(dev), &alt_pr_ops, priv);
> >> +    if (IS_ERR(mgr))
> >> +        return PTR_ERR(mgr);
> > mgr is unused
> >>   -    return devm_fpga_mgr_register(dev, mgr);
> >> +    return 0;
> >>   }
> >>   EXPORT_SYMBOL_GPL(alt_pr_register);
> >>   diff --git a/drivers/fpga/altera-ps-spi.c b/drivers/fpga/altera-ps-spi.c
> >> index 23bfd4d1ad0f..d3f77b0312b2 100644
> >> --- a/drivers/fpga/altera-ps-spi.c
> >> +++ b/drivers/fpga/altera-ps-spi.c
> >> @@ -302,12 +302,12 @@ static int altera_ps_probe(struct spi_device *spi)
> >>       snprintf(conf->mgr_name, sizeof(conf->mgr_name), "%s %s",
> >>            dev_driver_string(&spi->dev), dev_name(&spi->dev));
> > a combo of devices name, is that really necessary ?
> 
> I would like to limit the scope of this patch to address:
> (1) a populated dev_release function
> (2) combining the device_initialize() and device_add() calls into single call
>     to device_register()
> 
> Changing the name or removing the sysfs name file could have implications for
> users who expect it to be there or, worse yet, have a script that looks for it.
> I think these could be done in a separate patch if needed.

I agree.

> 
> >>   -    mgr = devm_fpga_mgr_create(&spi->dev, conf->mgr_name,
> >> -                   &altera_ps_ops, conf);
> >> -    if (!mgr)
> >> -        return -ENOMEM;
> >> +    mgr = devm_fpga_mgr_register(&spi->dev, conf->mgr_name,
> >> +                     &altera_ps_ops, conf);
> >> +    if (IS_ERR(mgr))
> >> +        return PTR_ERR(mgr);
> > mgr is unused
> >>   -    return devm_fpga_mgr_register(&spi->dev, mgr);
> >> +    return 0;
> >>   }
> >>     static const struct spi_device_id altera_ps_spi_ids[] = {
> >> diff --git a/drivers/fpga/dfl-fme-mgr.c b/drivers/fpga/dfl-fme-mgr.c
> >> index d5861d13b306..d71eba817b3b 100644
> >> --- a/drivers/fpga/dfl-fme-mgr.c
> >> +++ b/drivers/fpga/dfl-fme-mgr.c
> >> @@ -308,14 +308,14 @@ static int fme_mgr_probe(struct platform_device *pdev)
> >>         fme_mgr_get_compat_id(priv->ioaddr, compat_id);
> >>   -    mgr = devm_fpga_mgr_create(dev, "DFL FME FPGA Manager",
> >> -                   &fme_mgr_ops, priv);
> >> -    if (!mgr)
> >> -        return -ENOMEM;
> >> +    mgr = devm_fpga_mgr_register(dev, "DFL FME FPGA Manager",
> >> +                     &fme_mgr_ops, priv);
> > drv name is 'dfl-fme-mgr', is this close enough ?
> >> +    if (IS_ERR(mgr))
> >> +        return PTR_ERR(mgr);
> >>         mgr->compat_id = compat_id;
> >>   -    return devm_fpga_mgr_register(dev, mgr);
> >> +    return 0;
> >>   }
> >>     static struct platform_driver fme_mgr_driver = {
> >> diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
> >> index b85bc47c91a9..22f0dd5c2834 100644
> >> --- a/drivers/fpga/fpga-mgr.c
> >> +++ b/drivers/fpga/fpga-mgr.c
> >> @@ -550,20 +550,20 @@ void fpga_mgr_unlock(struct fpga_manager *mgr)
> >>   EXPORT_SYMBOL_GPL(fpga_mgr_unlock);
> >>     /**
> >> - * fpga_mgr_create - create and initialize a FPGA manager struct
> >> + * fpga_mgr_register - create and register a FPGA Manager device
> >>    * @dev:    fpga manager device from pdev
> >
> > nit, space or tab after ':' ? this is inconsistent everywhere.
> >
> >
> >>    * @name:    fpga manager name
> >>    * @mops:    pointer to structure of fpga manager ops
> >>    * @priv:    fpga manager private data
> >>    *
> >> - * The caller of this function is responsible for freeing the struct with
> >> - * fpga_mgr_free().  Using devm_fpga_mgr_create() instead is recommended.
> >> + * The caller of this function is responsible for calling fpga_mgr_unregister().
> >> + * Using devm_fpga_mgr_register instead is recommended.
> >>    *
> >> - * Return: pointer to struct fpga_manager or NULL
> >> + * Returns a struct fpga_manager pointer on success, or ERR_PTR() on error.
> >>    */
> >> -struct fpga_manager *fpga_mgr_create(struct device *dev, const char *name,
> >> -                     const struct fpga_manager_ops *mops,
> >> -                     void *priv)
> >> +struct fpga_manager *
> >> +fpga_mgr_register(struct device *dev, const char *name,
> >> +          const struct fpga_manager_ops *mops, void *priv)
> >>   {
> >>       struct fpga_manager *mgr;
> >>       int id, ret;
> >> @@ -572,21 +572,23 @@ struct fpga_manager *fpga_mgr_create(struct device *dev, const char *name,
> >>           !mops->write_init || (!mops->write && !mops->write_sg) ||
> >>           (mops->write && mops->write_sg)) {
> >>           dev_err(dev, "Attempt to register without fpga_manager_ops\n");
> >> -        return NULL;
> >> +        return ERR_PTR(-EINVAL);
> >
> > return -EINVAL;
> >
> > And similar
> >
> > The user's error checking is simplified to an int check.
> >
> > The clunky ERR_PTR()/PTR_ERR() can be removed
> >
> >>       }
> >>         if (!name || !strlen(name)) {
> >>           dev_err(dev, "Attempt to register with no name!\n");
> >> -        return NULL;
> >> +        return ERR_PTR(-EINVAL);
> >>       }
> >>         mgr = kzalloc(sizeof(*mgr), GFP_KERNEL);
> >>       if (!mgr)
> >> -        return NULL;
> >> +        return ERR_PTR(-ENOMEM);
> >>         id = ida_simple_get(&fpga_mgr_ida, 0, 0, GFP_KERNEL);
> >> -    if (id < 0)
> >> +    if (id < 0) {
> >> +        ret = id;
> >>           goto error_kfree;
> >> +    }
> >>         mutex_init(&mgr->ref_mutex);
> >>   @@ -594,7 +596,6 @@ struct fpga_manager *fpga_mgr_create(struct device *dev, const char *name,
> >
> > Just use the device name, do not give the user an option and simplify the calling parameters.
> >
> > mgr->name = dev_name(dev)
> >
> >>       mgr->mops = mops;
> >>       mgr->priv = priv;
> >>   -    device_initialize(&mgr->dev);
> >>       mgr->dev.class = fpga_mgr_class;
> >>       mgr->dev.groups = mops->groups;
> >>       mgr->dev.parent = dev;
> >> @@ -605,84 +606,6 @@ struct fpga_manager *fpga_mgr_create(struct device *dev, const char *name,
> >>       if (ret)
> >>           goto error_device;
> >>   
> >
> > The only use of returned mgr seems to be a variant of setting the dev->driver_data = mgr
> >
> > so just make it the default and don't pass back the ptr.
> >
> > dev_set_drvdata(dev, mgr);
> 
> I also noticed that in most cases the return pointer is not used. I get what
> you are saying - it would be a nice simplification if the pointer did not need
> to be returned.
> 
> However, I believe we are talking about modifying the driver_data for the
> parent of the class driver, right? And the parent driver could spawn
> multiple class drivers, or sub drivers. Having one of those sub-drivers control
> the contents of it's driver-data doesn't feel right. It seems like the parent
> driver should have exclusive control over this pointer.

I also agree.

Thanks,
Yilun

> 
> I'm curious what others think...
> 
> - Russ
> 
> >
> > return 0;
> >
> >
> > Tom
> >
> >

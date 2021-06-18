Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D38733AD4B9
	for <lists+linux-fpga@lfdr.de>; Sat, 19 Jun 2021 00:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbhFRWD7 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 18 Jun 2021 18:03:59 -0400
Received: from mail-pj1-f45.google.com ([209.85.216.45]:38643 "EHLO
        mail-pj1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbhFRWD6 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 18 Jun 2021 18:03:58 -0400
Received: by mail-pj1-f45.google.com with SMTP id t19-20020a17090ae513b029016f66a73701so1623283pjy.3
        for <linux-fpga@vger.kernel.org>; Fri, 18 Jun 2021 15:01:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jWhmoO6tqhGRWI2788lvihJ4RVL4M0SfpD6CWiM8pa4=;
        b=r8TeMRgETqPUUpUWaSpG27n/JCfw4oNna+CdIveBw3JkYbSBVQfJ/a2z/u19RL8Wg9
         HyQ5xGQLsG9YNes9quZzRNuxKdmGRmV/qp82qVgIQUmDvmsTK8f68x7dZIyAtgnZ/gs1
         wHTuTJSSLO03qwX7Q4F9+Me3bL3wcF4wMQnsz7a1yPOEQ5lew1TBxXslP3ElvsknfadA
         sEPXSsVHujnrGX2Eg3tgkw3GqIeC8j4iZ9yeGUMq8KAxwo7qDscMDFOH2lgNh1B/n1eb
         vycGqtC63zIGe7VovWWFY/qnMxWXToviqn9RvmwqmaVMiobVQ9Hn5+H1osmykm5P0DIK
         yvQw==
X-Gm-Message-State: AOAM530YT8sShxiyxyBy6bBdjBXEtERY1WMgNHwwUu6FPeTnMTMfEq4s
        /3m3TLhC2sZyI8A45PD2BmM=
X-Google-Smtp-Source: ABdhPJxuA5Ctb+Aoe20xcpLUCwWOQ20mmW0o6vT1CnPX/Pydpo+w9xZh3KCQp7KU3PczZEw8QKJXxQ==
X-Received: by 2002:a17:90a:7c02:: with SMTP id v2mr13168203pjf.118.1624053707731;
        Fri, 18 Jun 2021 15:01:47 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id f28sm9842553pgb.12.2021.06.18.15.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 15:01:46 -0700 (PDT)
Date:   Fri, 18 Jun 2021 15:01:45 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Tom Rix <trix@redhat.com>
Cc:     Russ Weight <russell.h.weight@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, lgoncalv@redhat.com, hao.wu@intel.com,
        matthew.gerlach@intel.com, richard.gong@intel.com
Subject: Re: [PATCH v5 1/3] fpga: mgr: Use standard dev_release for class
 driver
Message-ID: <YM0XyY9d+13GQyCS@epycbox.lan>
References: <20210616225740.399486-1-russell.h.weight@intel.com>
 <20210616225740.399486-2-russell.h.weight@intel.com>
 <20210618154554.GA5626@yilunxu-OptiPlex-7050>
 <beca500b-a66c-d6fa-1452-3e7513394d0e@intel.com>
 <69a0135d-ad0b-49ea-f741-54c982a0e5f3@intel.com>
 <2253ceae-8c9b-9176-4ec2-88e84c2b627a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2253ceae-8c9b-9176-4ec2-88e84c2b627a@redhat.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, Jun 18, 2021 at 01:39:42PM -0700, Tom Rix wrote:
> 
> On 6/18/21 10:58 AM, Russ Weight wrote:
> > 
> > On 6/18/21 9:03 AM, Russ Weight wrote:
> > > On 6/18/21 8:45 AM, Xu Yilun wrote:
> > > > On Wed, Jun 16, 2021 at 03:57:38PM -0700, Russ Weight wrote:
> > > > > The FPGA manager class driver data structure is being treated as a
> > > > > managed resource instead of using standard dev_release call-back
> > > > > to release the class data structure. This change removes the
> > > > > managed resource code for the freeing of the class data structure
> > > > > and combines the create() and register() functions into a single
> > > > > register() function.
> > > > > 
> > > > > The devm_fpga_mgr_register() function is retained.
> > > > > 
> > > > > Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> > > > > ---
> > > > > v5:
> > > > >    - Rebased on top of recently accepted patches.
> > > > >    - Removed compat_id from the fpga_mgr_register() parameter list
> > > > >      and added it to the fpga_manager_ops structure. This also required
> > > > My reason for this change is, we could avoid further change of the
> > > > fpga_mgr_register() API if we add new input parameters later on.
> > > With this patchset, changes are only required for the callers
> > > that use the new parameters.
> > > 
> > > > >      dynamically allocating the dfl-fme-ops structure in order to add
> > > > >      the appropriate compat_id.
> > > > But enforcing the dynamical allocation of the parameters is not prefered
> > > > to me. How about a dedicated structure that wraps all the needed
> > > > parameters:
> > > > 
> > > > struct fpga_mgr_info {
> > > > 	const char *name;
> > > > 	const struct fpga_manager_ops *mops;
> > > > 	const struct fpga_compat_id *compat_id;
> > > > 	const void *priv;
> > > > };
> > > > 
> > > > Then We can simply define a local variable of this struct for
> > > > fpga_mgr_register().
> > > > 
> > > > more details inline.
> > > I agree the at the dynamic allocation is not preferred, but it is only
> > > required if compat_id is used. In all other cases, the static structure
> > > can continue to be used. In otherwords, only one caller is affected.
> > > > > v4:
> > > > >    - Added the compat_id parameter to fpga_mgr_register() and
> > > > >      devm_fpga_mgr_register() to ensure that the compat_id is set before
> > > > >      the device_register() call.
> > > > > v3:
> > > > >    - Cleaned up comment header for fpga_mgr_register()
> > > > >    - Fix error return on ida_simple_get() failure
> > > > > v2:
> > > > >    - Restored devm_fpga_mgr_register() functionality, adapted for the combined
> > > > >      create/register functionality.
> > > > >    - All previous callers of devm_fpga_mgr_register() will continue to call
> > > > >      devm_fpga_mgr_register().
> > > > >    - replaced unnecessary ternary operators in return statements with standard
> > > > >      if conditions.
> > > > > ---
> > > > >   drivers/fpga/altera-cvp.c        |  12 +--
> > > > >   drivers/fpga/altera-pr-ip-core.c |   8 +-
> > > > >   drivers/fpga/altera-ps-spi.c     |  10 +-
> > > > >   drivers/fpga/dfl-fme-mgr.c       |  52 ++++++----
> > > > >   drivers/fpga/dfl-fme-region.c    |   2 +-
> > > > >   drivers/fpga/fpga-mgr.c          | 163 ++++++++-----------------------
> > > > >   drivers/fpga/ice40-spi.c         |  10 +-
> > > > >   drivers/fpga/machxo2-spi.c       |  10 +-
> > > > >   drivers/fpga/socfpga-a10.c       |  16 ++-
> > > > >   drivers/fpga/socfpga.c           |  10 +-
> > > > >   drivers/fpga/stratix10-soc.c     |  16 +--
> > > > >   drivers/fpga/ts73xx-fpga.c       |  10 +-
> > > > >   drivers/fpga/xilinx-spi.c        |  12 +--
> > > > >   drivers/fpga/zynq-fpga.c         |  16 ++-
> > > > >   drivers/fpga/zynqmp-fpga.c       |  10 +-
> > > > >   include/linux/fpga/fpga-mgr.h    |  43 ++++----
> > > > >   16 files changed, 153 insertions(+), 247 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
> > > > > index ccf4546eff29..4ffb9da537d8 100644
> > > > > --- a/drivers/fpga/altera-cvp.c
> > > > > +++ b/drivers/fpga/altera-cvp.c
> > > > > @@ -652,19 +652,15 @@ static int altera_cvp_probe(struct pci_dev *pdev,
> > > > >   	snprintf(conf->mgr_name, sizeof(conf->mgr_name), "%s @%s",
> > > > >   		 ALTERA_CVP_MGR_NAME, pci_name(pdev));
> > > > > -	mgr = devm_fpga_mgr_create(&pdev->dev, conf->mgr_name,
> > > > > -				   &altera_cvp_ops, conf);
> > > > > -	if (!mgr) {
> > > > > -		ret = -ENOMEM;
> > > > > +	mgr = fpga_mgr_register(&pdev->dev, conf->mgr_name,
> > > > > +				&altera_cvp_ops, conf);
> > > > > +	if (IS_ERR(mgr)) {
> > > > > +		ret = PTR_ERR(mgr);
> > > > >   		goto err_unmap;
> > > > >   	}
> > > > >   	pci_set_drvdata(pdev, mgr);
> > > > > -	ret = fpga_mgr_register(mgr);
> > > > > -	if (ret)
> > > > > -		goto err_unmap;
> > > > > -
> > > > >   	return 0;
> > > > >   err_unmap:
> > > > > diff --git a/drivers/fpga/altera-pr-ip-core.c b/drivers/fpga/altera-pr-ip-core.c
> > > > > index dfdf21ed34c4..17babf974852 100644
> > > > > --- a/drivers/fpga/altera-pr-ip-core.c
> > > > > +++ b/drivers/fpga/altera-pr-ip-core.c
> > > > > @@ -191,11 +191,11 @@ int alt_pr_register(struct device *dev, void __iomem *reg_base)
> > > > >   		(val & ALT_PR_CSR_STATUS_MSK) >> ALT_PR_CSR_STATUS_SFT,
> > > > >   		(int)(val & ALT_PR_CSR_PR_START));
> > > > > -	mgr = devm_fpga_mgr_create(dev, dev_name(dev), &alt_pr_ops, priv);
> > > > > -	if (!mgr)
> > > > > -		return -ENOMEM;
> > > > > +	mgr = devm_fpga_mgr_register(dev, dev_name(dev), &alt_pr_ops, priv);
> > > > > +	if (IS_ERR(mgr))
> > > > > +		return PTR_ERR(mgr);
> > > > > -	return devm_fpga_mgr_register(dev, mgr);
> > > > > +	return 0;
> > > > >   }
> > > > >   EXPORT_SYMBOL_GPL(alt_pr_register);
> > > > > diff --git a/drivers/fpga/altera-ps-spi.c b/drivers/fpga/altera-ps-spi.c
> > > > > index 23bfd4d1ad0f..d3f77b0312b2 100644
> > > > > --- a/drivers/fpga/altera-ps-spi.c
> > > > > +++ b/drivers/fpga/altera-ps-spi.c
> > > > > @@ -302,12 +302,12 @@ static int altera_ps_probe(struct spi_device *spi)
> > > > >   	snprintf(conf->mgr_name, sizeof(conf->mgr_name), "%s %s",
> > > > >   		 dev_driver_string(&spi->dev), dev_name(&spi->dev));
> > > > > -	mgr = devm_fpga_mgr_create(&spi->dev, conf->mgr_name,
> > > > > -				   &altera_ps_ops, conf);
> > > > > -	if (!mgr)
> > > > > -		return -ENOMEM;
> > > > > +	mgr = devm_fpga_mgr_register(&spi->dev, conf->mgr_name,
> > > > > +				     &altera_ps_ops, conf);
> > > > > +	if (IS_ERR(mgr))
> > > > > +		return PTR_ERR(mgr);
> > > > > -	return devm_fpga_mgr_register(&spi->dev, mgr);
> > > > > +	return 0;
> > > > >   }
> > > > >   static const struct spi_device_id altera_ps_spi_ids[] = {
> > > > > diff --git a/drivers/fpga/dfl-fme-mgr.c b/drivers/fpga/dfl-fme-mgr.c
> > > > > index d5861d13b306..1b93bc292dbe 100644
> > > > > --- a/drivers/fpga/dfl-fme-mgr.c
> > > > > +++ b/drivers/fpga/dfl-fme-mgr.c
> > > > > @@ -264,14 +264,6 @@ static u64 fme_mgr_status(struct fpga_manager *mgr)
> > > > >   	return pr_error_to_mgr_status(priv->pr_error);
> > > > >   }
> > > > > -static const struct fpga_manager_ops fme_mgr_ops = {
> > > > > -	.write_init = fme_mgr_write_init,
> > > > > -	.write = fme_mgr_write,
> > > > > -	.write_complete = fme_mgr_write_complete,
> > > > > -	.state = fme_mgr_state,
> > > > > -	.status = fme_mgr_status,
> > > > > -};
> > > > > -
> > > > >   static void fme_mgr_get_compat_id(void __iomem *fme_pr,
> > > > >   				  struct fpga_compat_id *id)
> > > > >   {
> > > > > @@ -279,10 +271,34 @@ static void fme_mgr_get_compat_id(void __iomem *fme_pr,
> > > > >   	id->id_h = readq(fme_pr + FME_PR_INTFC_ID_H);
> > > > >   }
> > > > > +static struct fpga_manager_ops *fme_mgr_get_ops(struct device *dev,
> > > > > +						struct fme_mgr_priv *priv)
> > > > > +{
> > > > > +	struct fpga_manager_ops *ops;
> > > > > +
> > > > > +	ops = devm_kzalloc(dev, sizeof(*ops), GFP_KERNEL);
> > > > > +	if (!ops)
> > > > > +		return NULL;
> > > > > +
> > > > > +	ops->compat_id = devm_kzalloc(dev, sizeof(struct fpga_compat_id),
> > > > > +				      GFP_KERNEL);
> > > > > +	if (!ops->compat_id)
> > > > > +		return NULL;
> > > > > +
> > > > > +	fme_mgr_get_compat_id(priv->ioaddr, ops->compat_id);
> > > > > +	ops->write_init = fme_mgr_write_init;
> > > > > +	ops->write = fme_mgr_write;
> > > > > +	ops->write_complete = fme_mgr_write_complete;
> > > > > +	ops->state = fme_mgr_state;
> > > > > +	ops->status = fme_mgr_status;
> > > > > +
> > > > > +	return ops;
> > > > > +}
> > What do other's think? Is it better to dynamically allocate the ops structure
> > for users of compat_id (just one user at this time)? Or better to create an
> > info structure on the stack for all callers? See above for an example of a
> > dynamically allocated the ops structure.
> > 
> > To me, using the ops structure seems more standard, and the dynamic allocation,
> > while not optimal, does not require much more space or complexity than the static
> > allocation. At this time it only affects one caller.
> > 
> > Adding the info structure as a parameter to the register() functions adds a
> > little more complexity to all callers, whether or not they use the dynamic
> > elements of the structure.
> 
> Looks like dfl is the only user of compat_id.
> 
> A board specific value does not belong in a common structure, it belongs in
> a board structure
> 
> Move compat_id out of fpga-mgr.h and into dfl.h
> 
> In dfl- you can do whatever you want.

Agreed. You'll have to deal with DFL specific region, that directly
accesses mgr->compat_id.

But yes, this should move to DFL, nobody else is using it.

- Moritz

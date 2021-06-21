Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E67E3AE374
	for <lists+linux-fpga@lfdr.de>; Mon, 21 Jun 2021 08:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbhFUGr1 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 21 Jun 2021 02:47:27 -0400
Received: from mga18.intel.com ([134.134.136.126]:55469 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230202AbhFUGrM (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 21 Jun 2021 02:47:12 -0400
IronPort-SDR: 0N1ywyV0HJ1xscAQQlgHMhZvESFw3p5iIjhvDcLPpoWJbb8k4cwl247Cdq7xNRh+QGEJ1+C0M6
 BSZ69FL6dsWg==
X-IronPort-AV: E=McAfee;i="6200,9189,10021"; a="194098526"
X-IronPort-AV: E=Sophos;i="5.83,289,1616482800"; 
   d="scan'208";a="194098526"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2021 23:44:58 -0700
IronPort-SDR: PApTi2KbIDMFGSi3OntTC00NUIK8QCkqMUJ+yjscU4eu43VpXDCrc68anqZVsymMaYD4PpRchf
 h5yRAn0c0+tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,289,1616482800"; 
   d="scan'208";a="486379707"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.162])
  by orsmga001.jf.intel.com with ESMTP; 20 Jun 2021 23:44:55 -0700
Date:   Mon, 21 Jun 2021 14:39:44 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     Tom Rix <trix@redhat.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, lgoncalv@redhat.com, hao.wu@intel.com,
        matthew.gerlach@intel.com, richard.gong@intel.com
Subject: Re: [PATCH v5 1/3] fpga: mgr: Use standard dev_release for class
  driver
Message-ID: <20210621063944.GC21682@yilunxu-OptiPlex-7050>
References: <20210616225740.399486-1-russell.h.weight@intel.com>
 <20210616225740.399486-2-russell.h.weight@intel.com>
 <20210618154554.GA5626@yilunxu-OptiPlex-7050>
 <beca500b-a66c-d6fa-1452-3e7513394d0e@intel.com>
 <69a0135d-ad0b-49ea-f741-54c982a0e5f3@intel.com>
 <2253ceae-8c9b-9176-4ec2-88e84c2b627a@redhat.com>
 <af3423d4-a833-8cbf-5863-d387946e8bad@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <af3423d4-a833-8cbf-5863-d387946e8bad@intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, Jun 18, 2021 at 03:31:50PM -0700, Russ Weight wrote:
> 
> 
> On 6/18/21 1:39 PM, Tom Rix wrote:
> >
> > On 6/18/21 10:58 AM, Russ Weight wrote:
> >>
> >> On 6/18/21 9:03 AM, Russ Weight wrote:
> >>> On 6/18/21 8:45 AM, Xu Yilun wrote:
> >>>> On Wed, Jun 16, 2021 at 03:57:38PM -0700, Russ Weight wrote:
> >>>>> The FPGA manager class driver data structure is being treated as a
> >>>>> managed resource instead of using standard dev_release call-back
> >>>>> to release the class data structure. This change removes the
> >>>>> managed resource code for the freeing of the class data structure
> >>>>> and combines the create() and register() functions into a single
> >>>>> register() function.
> >>>>>
> >>>>> The devm_fpga_mgr_register() function is retained.
> >>>>>
> >>>>> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> >>>>> ---
> >>>>> v5:
> >>>>>    - Rebased on top of recently accepted patches.
> >>>>>    - Removed compat_id from the fpga_mgr_register() parameter list
> >>>>>      and added it to the fpga_manager_ops structure. This also required
> >>>> My reason for this change is, we could avoid further change of the
> >>>> fpga_mgr_register() API if we add new input parameters later on.
> >>> With this patchset, changes are only required for the callers
> >>> that use the new parameters.
> >>>
> >>>>>      dynamically allocating the dfl-fme-ops structure in order to add
> >>>>>      the appropriate compat_id.
> >>>> But enforcing the dynamical allocation of the parameters is not prefered
> >>>> to me. How about a dedicated structure that wraps all the needed
> >>>> parameters:
> >>>>
> >>>> struct fpga_mgr_info {
> >>>>     const char *name;
> >>>>     const struct fpga_manager_ops *mops;
> >>>>     const struct fpga_compat_id *compat_id;
> >>>>     const void *priv;
> >>>> };
> >>>>
> >>>> Then We can simply define a local variable of this struct for
> >>>> fpga_mgr_register().
> >>>>
> >>>> more details inline.
> >>> I agree the at the dynamic allocation is not preferred, but it is only
> >>> required if compat_id is used. In all other cases, the static structure
> >>> can continue to be used. In otherwords, only one caller is affected.
> >>>>> v4:
> >>>>>    - Added the compat_id parameter to fpga_mgr_register() and
> >>>>>      devm_fpga_mgr_register() to ensure that the compat_id is set before
> >>>>>      the device_register() call.
> >>>>> v3:
> >>>>>    - Cleaned up comment header for fpga_mgr_register()
> >>>>>    - Fix error return on ida_simple_get() failure
> >>>>> v2:
> >>>>>    - Restored devm_fpga_mgr_register() functionality, adapted for the combined
> >>>>>      create/register functionality.
> >>>>>    - All previous callers of devm_fpga_mgr_register() will continue to call
> >>>>>      devm_fpga_mgr_register().
> >>>>>    - replaced unnecessary ternary operators in return statements with standard
> >>>>>      if conditions.
> >>>>> ---
> >>>>>   drivers/fpga/altera-cvp.c        |  12 +--
> >>>>>   drivers/fpga/altera-pr-ip-core.c |   8 +-
> >>>>>   drivers/fpga/altera-ps-spi.c     |  10 +-
> >>>>>   drivers/fpga/dfl-fme-mgr.c       |  52 ++++++----
> >>>>>   drivers/fpga/dfl-fme-region.c    |   2 +-
> >>>>>   drivers/fpga/fpga-mgr.c          | 163 ++++++++-----------------------
> >>>>>   drivers/fpga/ice40-spi.c         |  10 +-
> >>>>>   drivers/fpga/machxo2-spi.c       |  10 +-
> >>>>>   drivers/fpga/socfpga-a10.c       |  16 ++-
> >>>>>   drivers/fpga/socfpga.c           |  10 +-
> >>>>>   drivers/fpga/stratix10-soc.c     |  16 +--
> >>>>>   drivers/fpga/ts73xx-fpga.c       |  10 +-
> >>>>>   drivers/fpga/xilinx-spi.c        |  12 +--
> >>>>>   drivers/fpga/zynq-fpga.c         |  16 ++-
> >>>>>   drivers/fpga/zynqmp-fpga.c       |  10 +-
> >>>>>   include/linux/fpga/fpga-mgr.h    |  43 ++++----
> >>>>>   16 files changed, 153 insertions(+), 247 deletions(-)
> >>>>>
> >>>>> diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
> >>>>> index ccf4546eff29..4ffb9da537d8 100644
> >>>>> --- a/drivers/fpga/altera-cvp.c
> >>>>> +++ b/drivers/fpga/altera-cvp.c
> >>>>> @@ -652,19 +652,15 @@ static int altera_cvp_probe(struct pci_dev *pdev,
> >>>>>       snprintf(conf->mgr_name, sizeof(conf->mgr_name), "%s @%s",
> >>>>>            ALTERA_CVP_MGR_NAME, pci_name(pdev));
> >>>>>   -    mgr = devm_fpga_mgr_create(&pdev->dev, conf->mgr_name,
> >>>>> -                   &altera_cvp_ops, conf);
> >>>>> -    if (!mgr) {
> >>>>> -        ret = -ENOMEM;
> >>>>> +    mgr = fpga_mgr_register(&pdev->dev, conf->mgr_name,
> >>>>> +                &altera_cvp_ops, conf);
> >>>>> +    if (IS_ERR(mgr)) {
> >>>>> +        ret = PTR_ERR(mgr);
> >>>>>           goto err_unmap;
> >>>>>       }
> >>>>>         pci_set_drvdata(pdev, mgr);
> >>>>>   -    ret = fpga_mgr_register(mgr);
> >>>>> -    if (ret)
> >>>>> -        goto err_unmap;
> >>>>> -
> >>>>>       return 0;
> >>>>>     err_unmap:
> >>>>> diff --git a/drivers/fpga/altera-pr-ip-core.c b/drivers/fpga/altera-pr-ip-core.c
> >>>>> index dfdf21ed34c4..17babf974852 100644
> >>>>> --- a/drivers/fpga/altera-pr-ip-core.c
> >>>>> +++ b/drivers/fpga/altera-pr-ip-core.c
> >>>>> @@ -191,11 +191,11 @@ int alt_pr_register(struct device *dev, void __iomem *reg_base)
> >>>>>           (val & ALT_PR_CSR_STATUS_MSK) >> ALT_PR_CSR_STATUS_SFT,
> >>>>>           (int)(val & ALT_PR_CSR_PR_START));
> >>>>>   -    mgr = devm_fpga_mgr_create(dev, dev_name(dev), &alt_pr_ops, priv);
> >>>>> -    if (!mgr)
> >>>>> -        return -ENOMEM;
> >>>>> +    mgr = devm_fpga_mgr_register(dev, dev_name(dev), &alt_pr_ops, priv);
> >>>>> +    if (IS_ERR(mgr))
> >>>>> +        return PTR_ERR(mgr);
> >>>>>   -    return devm_fpga_mgr_register(dev, mgr);
> >>>>> +    return 0;
> >>>>>   }
> >>>>>   EXPORT_SYMBOL_GPL(alt_pr_register);
> >>>>>   diff --git a/drivers/fpga/altera-ps-spi.c b/drivers/fpga/altera-ps-spi.c
> >>>>> index 23bfd4d1ad0f..d3f77b0312b2 100644
> >>>>> --- a/drivers/fpga/altera-ps-spi.c
> >>>>> +++ b/drivers/fpga/altera-ps-spi.c
> >>>>> @@ -302,12 +302,12 @@ static int altera_ps_probe(struct spi_device *spi)
> >>>>>       snprintf(conf->mgr_name, sizeof(conf->mgr_name), "%s %s",
> >>>>>            dev_driver_string(&spi->dev), dev_name(&spi->dev));
> >>>>>   -    mgr = devm_fpga_mgr_create(&spi->dev, conf->mgr_name,
> >>>>> -                   &altera_ps_ops, conf);
> >>>>> -    if (!mgr)
> >>>>> -        return -ENOMEM;
> >>>>> +    mgr = devm_fpga_mgr_register(&spi->dev, conf->mgr_name,
> >>>>> +                     &altera_ps_ops, conf);
> >>>>> +    if (IS_ERR(mgr))
> >>>>> +        return PTR_ERR(mgr);
> >>>>>   -    return devm_fpga_mgr_register(&spi->dev, mgr);
> >>>>> +    return 0;
> >>>>>   }
> >>>>>     static const struct spi_device_id altera_ps_spi_ids[] = {
> >>>>> diff --git a/drivers/fpga/dfl-fme-mgr.c b/drivers/fpga/dfl-fme-mgr.c
> >>>>> index d5861d13b306..1b93bc292dbe 100644
> >>>>> --- a/drivers/fpga/dfl-fme-mgr.c
> >>>>> +++ b/drivers/fpga/dfl-fme-mgr.c
> >>>>> @@ -264,14 +264,6 @@ static u64 fme_mgr_status(struct fpga_manager *mgr)
> >>>>>       return pr_error_to_mgr_status(priv->pr_error);
> >>>>>   }
> >>>>>   -static const struct fpga_manager_ops fme_mgr_ops = {
> >>>>> -    .write_init = fme_mgr_write_init,
> >>>>> -    .write = fme_mgr_write,
> >>>>> -    .write_complete = fme_mgr_write_complete,
> >>>>> -    .state = fme_mgr_state,
> >>>>> -    .status = fme_mgr_status,
> >>>>> -};
> >>>>> -
> >>>>>   static void fme_mgr_get_compat_id(void __iomem *fme_pr,
> >>>>>                     struct fpga_compat_id *id)
> >>>>>   {
> >>>>> @@ -279,10 +271,34 @@ static void fme_mgr_get_compat_id(void __iomem *fme_pr,
> >>>>>       id->id_h = readq(fme_pr + FME_PR_INTFC_ID_H);
> >>>>>   }
> >>>>>   +static struct fpga_manager_ops *fme_mgr_get_ops(struct device *dev,
> >>>>> +                        struct fme_mgr_priv *priv)
> >>>>> +{
> >>>>> +    struct fpga_manager_ops *ops;
> >>>>> +
> >>>>> +    ops = devm_kzalloc(dev, sizeof(*ops), GFP_KERNEL);
> >>>>> +    if (!ops)
> >>>>> +        return NULL;
> >>>>> +
> >>>>> +    ops->compat_id = devm_kzalloc(dev, sizeof(struct fpga_compat_id),
> >>>>> +                      GFP_KERNEL);
> >>>>> +    if (!ops->compat_id)
> >>>>> +        return NULL;
> >>>>> +
> >>>>> +    fme_mgr_get_compat_id(priv->ioaddr, ops->compat_id);
> >>>>> +    ops->write_init = fme_mgr_write_init;
> >>>>> +    ops->write = fme_mgr_write;
> >>>>> +    ops->write_complete = fme_mgr_write_complete;
> >>>>> +    ops->state = fme_mgr_state;
> >>>>> +    ops->status = fme_mgr_status;
> >>>>> +
> >>>>> +    return ops;
> >>>>> +}
> >> What do other's think? Is it better to dynamically allocate the ops structure
> >> for users of compat_id (just one user at this time)? Or better to create an
> >> info structure on the stack for all callers? See above for an example of a
> >> dynamically allocated the ops structure.
> >>
> >> To me, using the ops structure seems more standard, and the dynamic allocation,
> >> while not optimal, does not require much more space or complexity than the static
> >> allocation. At this time it only affects one caller.
> >>
> >> Adding the info structure as a parameter to the register() functions adds a
> >> little more complexity to all callers, whether or not they use the dynamic
> >> elements of the structure.
> >
> > Looks like dfl is the only user of compat_id.
> >
> > A board specific value does not belong in a common structure, it belongs in a board structure
> >
> > Move compat_id out of fpga-mgr.h and into dfl.h
> >
> > In dfl- you can do whatever you want.
> 
> Yilun - is this a correct explanation of the use of compat_id?
> 
> I believe the compat_id is used to verify whether or not an AFU is compatible with the Static Region. When the FPGA Manager is created (for PR purposes) the compat_id is read from the Static Region and stored in the FPGA Manager. When the region is created (containing the PR region), the same compat_id is then associated with the FPGA Region. The compat_id is exported by the region via syfs to allow userspace to verify compatibility between an AFU and the static region.
> 
> And I suppose the FPGA Manager _could_ be associated with multiple regions?
> 
> So I think compat_id _is_ (optionally) an attribute of the FPGA manager and the Region.

Yes, I believe it could be associated with FPGA mgr & region dev. It is
for compatibility check of the FPGA reconfiguration hardware and image.
Maybe we don't move it away just because DFL is the only one who
implements this interface.

Thanks,
Yilun

> 
> - Russ
> 
> >
> > And leave the others' ops as-is.
> >
> >
> > Tom
> >
> >>
> >> - Russ
> >>
> >>>>> +
> >>>>>   static int fme_mgr_probe(struct platform_device *pdev)
> >>>>>   {
> >>>>>       struct dfl_fme_mgr_pdata *pdata = dev_get_platdata(&pdev->dev);
> >>>>> -    struct fpga_compat_id *compat_id;
> >>>>> +    struct fpga_manager_ops *fme_mgr_ops;
> >>>>>       struct device *dev = &pdev->dev;
> >>>>>       struct fme_mgr_priv *priv;
> >>>>>       struct fpga_manager *mgr;
> >>>>> @@ -302,20 +318,16 @@ static int fme_mgr_probe(struct platform_device *pdev)
> >>>>>               return PTR_ERR(priv->ioaddr);
> >>>>>       }
> >>>>>   -    compat_id = devm_kzalloc(dev, sizeof(*compat_id), GFP_KERNEL);
> >>>>> -    if (!compat_id)
> >>>>> -        return -ENOMEM;
> >>>>> -
> >>>>> -    fme_mgr_get_compat_id(priv->ioaddr, compat_id);
> >>>>> -
> >>>>> -    mgr = devm_fpga_mgr_create(dev, "DFL FME FPGA Manager",
> >>>>> -                   &fme_mgr_ops, priv);
> >>>>> -    if (!mgr)
> >>>>> +    fme_mgr_ops = fme_mgr_get_ops(dev, priv);
> >>>>> +    if (!fme_mgr_ops)
> >>>>>           return -ENOMEM;
> >>>>>   -    mgr->compat_id = compat_id;
> >>>>> +    mgr = devm_fpga_mgr_register(dev, "DFL FME FPGA Manager",
> >>>>> +                     fme_mgr_ops, priv);
> >>>>> +    if (IS_ERR(mgr))
> >>>>> +        return PTR_ERR(mgr);
> >>>> With structure fpga_mgr_info, we don't need the dynamical allocation
> >>>> anymore:
> >>>>
> >>>>     struct fpga_mgr_info minfo = { 0 };
> >>>>
> >>>>     minfo.name = "DFL FME FPGA Manager";
> >>>>     minfo.mops = &fme_mgr_ops;
> >>>>     minfo.compat_id = compat_id;
> >>>>     minfo.priv = priv;
> >>>>
> >>>>     mgr = devm_fpga_mgr_register(dev, &minfo);
> >>>>
> >>>> Drivers could also leaves minfo.compat_id zero if they don't care.
> >>>>
> >>>> I also expect more opinions.
> >>>>
> >>>>>   -    return devm_fpga_mgr_register(dev, mgr);
> >>>>> +    return 0;
> >>>>>   }
> >>>>>     static struct platform_driver fme_mgr_driver = {
> >>>>> diff --git a/drivers/fpga/dfl-fme-region.c b/drivers/fpga/dfl-fme-region.c
> >>>>> index 1eeb42af1012..a64c13e198a0 100644
> >>>>> --- a/drivers/fpga/dfl-fme-region.c
> >>>>> +++ b/drivers/fpga/dfl-fme-region.c
> >>>>> @@ -46,7 +46,7 @@ static int fme_region_probe(struct platform_device *pdev)
> >>>>>       }
> >>>>>         region->priv = pdata;
> >>>>> -    region->compat_id = mgr->compat_id;
> >>>>> +    region->compat_id = mgr->mops->compat_id;
> >>>> The changes should be in Patch #3, is it?
> >>> This is the patch that moves compat_id out of mgr and into mgr->mops.
> >>> In order to be able to compile, this patch needs the change.
> >>>
> >>>>>       platform_set_drvdata(pdev, region);
> >>>>>         ret = fpga_region_register(region);
> >>>>> diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
> >>>>> index ecb4c3c795fa..9aecfea432c8 100644
> >>>>> --- a/drivers/fpga/fpga-mgr.c
> >>>>> +++ b/drivers/fpga/fpga-mgr.c
> >>>>> @@ -550,20 +550,20 @@ void fpga_mgr_unlock(struct fpga_manager *mgr)
> >>>>>   EXPORT_SYMBOL_GPL(fpga_mgr_unlock);
> >>>>>     /**
> >>>>> - * fpga_mgr_create - create and initialize an FPGA manager struct
> >>>>> + * fpga_mgr_register - create and register an FPGA Manager device
> >>>>>    * @parent:    fpga manager device from pdev
> >>>>>    * @name:    fpga manager name
> >>>>>    * @mops:    pointer to structure of fpga manager ops
> >>>>>    * @priv:    fpga manager private data
> >>>>>    *
> >>>>> - * The caller of this function is responsible for freeing the struct with
> >>>>> - * fpga_mgr_free().  Using devm_fpga_mgr_create() instead is recommended.
> >>>>> + * The caller of this function is responsible for calling fpga_mgr_unregister().
> >>>>> + * Using devm_fpga_mgr_register instead is recommended.
> >>>>>    *
> >>>>> - * Return: pointer to struct fpga_manager or NULL
> >>>>> + * Return: pointer to struct fpga_manager pointer or ERR_PTR()
> >>>>>    */
> >>>>> -struct fpga_manager *fpga_mgr_create(struct device *parent, const char *name,
> >>>>> -                     const struct fpga_manager_ops *mops,
> >>>>> -                     void *priv)
> >>>>> +struct fpga_manager *
> >>>>> +fpga_mgr_register(struct device *parent, const char *name,
> >>>>> +          const struct fpga_manager_ops *mops, void *priv)
> >>>> fpga_mgr_register(struct device *parent, struct fpga_mgr_info *minfo)
> >>>>
> >>>>>   {
> >>>>>       struct fpga_manager *mgr;
> >>>>>       int id, ret;
> >>>>> @@ -572,21 +572,23 @@ struct fpga_manager *fpga_mgr_create(struct device *parent, const char *name,
> >>>>>           !mops->write_init || (!mops->write && !mops->write_sg) ||
> >>>>>           (mops->write && mops->write_sg)) {
> >>>>>           dev_err(parent, "Attempt to register without fpga_manager_ops\n");
> >>>>> -        return NULL;
> >>>>> +        return ERR_PTR(-EINVAL);
> >>>>>       }
> >>>>>         if (!name || !strlen(name)) {
> >>>>>           dev_err(parent, "Attempt to register with no name!\n");
> >>>>> -        return NULL;
> >>>>> +        return ERR_PTR(-EINVAL);
> >>>>>       }
> >>>>>         mgr = kzalloc(sizeof(*mgr), GFP_KERNEL);
> >>>>>       if (!mgr)
> >>>>> -        return NULL;
> >>>>> +        return ERR_PTR(-ENOMEM);
> >>>>>         id = ida_simple_get(&fpga_mgr_ida, 0, 0, GFP_KERNEL);
> >>>>> -    if (id < 0)
> >>>>> +    if (id < 0) {
> >>>>> +        ret = id;
> >>>>>           goto error_kfree;
> >>>>> +    }
> >>>>>         mutex_init(&mgr->ref_mutex);
> >>>>>   @@ -594,7 +596,6 @@ struct fpga_manager *fpga_mgr_create(struct device *parent, const char *name,
> >>>>>       mgr->mops = mops;
> >>>>>       mgr->priv = priv;
> >>>>     mgr->name = minfo->name;
> >>>>     mgr->mops = minfo->mops;
> >>>>     mgr->priv = minfo->priv;
> >>>>     mgr->compat_id = minfo->compat_id;
> >>>>
> >>>>>   -    device_initialize(&mgr->dev);
> >>>>>       mgr->dev.class = fpga_mgr_class;
> >>>>>       mgr->dev.groups = mops->groups;
> >>>>>       mgr->dev.parent = parent;
> >>>>> @@ -605,84 +606,6 @@ struct fpga_manager *fpga_mgr_create(struct device *parent, const char *name,
> >>>>>       if (ret)
> >>>>>           goto error_device;
> >>>>>   -    return mgr;
> >>>>> -
> >>>>> -error_device:
> >>>>> -    ida_simple_remove(&fpga_mgr_ida, id);
> >>>>> -error_kfree:
> >>>>> -    kfree(mgr);
> >>>>> -
> >>>>> -    return NULL;
> >>>>> -}
> >>>>> -EXPORT_SYMBOL_GPL(fpga_mgr_create);
> >>>>> -
> >>>>> -/**
> >>>>> - * fpga_mgr_free - free an FPGA manager created with fpga_mgr_create()
> >>>>> - * @mgr:    fpga manager struct
> >>>>> - */
> >>>>> -void fpga_mgr_free(struct fpga_manager *mgr)
> >>>>> -{
> >>>>> -    ida_simple_remove(&fpga_mgr_ida, mgr->dev.id);
> >>>>> -    kfree(mgr);
> >>>>> -}
> >>>>> -EXPORT_SYMBOL_GPL(fpga_mgr_free);
> >>>>> -
> >>>>> -static void devm_fpga_mgr_release(struct device *dev, void *res)
> >>>>> -{
> >>>>> -    struct fpga_mgr_devres *dr = res;
> >>>>> -
> >>>>> -    fpga_mgr_free(dr->mgr);
> >>>>> -}
> >>>>> -
> >>>>> -/**
> >>>>> - * devm_fpga_mgr_create - create and initialize a managed FPGA manager struct
> >>>>> - * @parent:    fpga manager device from pdev
> >>>>> - * @name:    fpga manager name
> >>>>> - * @mops:    pointer to structure of fpga manager ops
> >>>>> - * @priv:    fpga manager private data
> >>>>> - *
> >>>>> - * This function is intended for use in an FPGA manager driver's probe function.
> >>>>> - * After the manager driver creates the manager struct with
> >>>>> - * devm_fpga_mgr_create(), it should register it with fpga_mgr_register().  The
> >>>>> - * manager driver's remove function should call fpga_mgr_unregister().  The
> >>>>> - * manager struct allocated with this function will be freed automatically on
> >>>>> - * driver detach.  This includes the case of a probe function returning error
> >>>>> - * before calling fpga_mgr_register(), the struct will still get cleaned up.
> >>>>> - *
> >>>>> - * Return: pointer to struct fpga_manager or NULL
> >>>>> - */
> >>>>> -struct fpga_manager *devm_fpga_mgr_create(struct device *parent, const char *name,
> >>>>> -                      const struct fpga_manager_ops *mops,
> >>>>> -                      void *priv)
> >>>>> -{
> >>>>> -    struct fpga_mgr_devres *dr;
> >>>>> -
> >>>>> -    dr = devres_alloc(devm_fpga_mgr_release, sizeof(*dr), GFP_KERNEL);
> >>>>> -    if (!dr)
> >>>>> -        return NULL;
> >>>>> -
> >>>>> -    dr->mgr = fpga_mgr_create(parent, name, mops, priv);
> >>>>> -    if (!dr->mgr) {
> >>>>> -        devres_free(dr);
> >>>>> -        return NULL;
> >>>>> -    }
> >>>>> -
> >>>>> -    devres_add(parent, dr);
> >>>>> -
> >>>>> -    return dr->mgr;
> >>>>> -}
> >>>>> -EXPORT_SYMBOL_GPL(devm_fpga_mgr_create);
> >>>>> -
> >>>>> -/**
> >>>>> - * fpga_mgr_register - register an FPGA manager
> >>>>> - * @mgr: fpga manager struct
> >>>>> - *
> >>>>> - * Return: 0 on success, negative error code otherwise.
> >>>>> - */
> >>>>> -int fpga_mgr_register(struct fpga_manager *mgr)
> >>>>> -{
> >>>>> -    int ret;
> >>>>> -
> >>>>>       /*
> >>>>>        * Initialize framework state by requesting low level driver read state
> >>>>>        * from device.  FPGA may be in reset mode or may have been programmed
> >>>>> @@ -690,18 +613,20 @@ int fpga_mgr_register(struct fpga_manager *mgr)
> >>>>>        */
> >>>>>       mgr->state = mgr->mops->state(mgr);
> >>>>>   -    ret = device_add(&mgr->dev);
> >>>>> -    if (ret)
> >>>>> -        goto error_device;
> >>>>> -
> >>>>> -    dev_info(&mgr->dev, "%s registered\n", mgr->name);
> >>>>> +    ret = device_register(&mgr->dev);
> >>>>> +    if (ret) {
> >>>>> +        put_device(&mgr->dev);
> >>>>> +        return ERR_PTR(ret);
> >>>>> +    }
> >>>>>   -    return 0;
> >>>>> +    return mgr;
> >>>>>     error_device:
> >>>>> -    ida_simple_remove(&fpga_mgr_ida, mgr->dev.id);
> >>>>> +    ida_simple_remove(&fpga_mgr_ida, id);
> >>>>> +error_kfree:
> >>>>> +    kfree(mgr);
> >>>>>   -    return ret;
> >>>>> +    return ERR_PTR(ret);
> >>>>>   }
> >>>>>   EXPORT_SYMBOL_GPL(fpga_mgr_register);
> >>>>>   @@ -726,14 +651,6 @@ void fpga_mgr_unregister(struct fpga_manager *mgr)
> >>>>>   }
> >>>>>   EXPORT_SYMBOL_GPL(fpga_mgr_unregister);
> >>>>>   -static int fpga_mgr_devres_match(struct device *dev, void *res,
> >>>>> -                 void *match_data)
> >>>>> -{
> >>>>> -    struct fpga_mgr_devres *dr = res;
> >>>>> -
> >>>>> -    return match_data == dr->mgr;
> >>>>> -}
> >>>>> -
> >>>>>   static void devm_fpga_mgr_unregister(struct device *dev, void *res)
> >>>>>   {
> >>>>>       struct fpga_mgr_devres *dr = res;
> >>>>> @@ -743,44 +660,44 @@ static void devm_fpga_mgr_unregister(struct device *dev, void *res)
> >>>>>     /**
> >>>>>    * devm_fpga_mgr_register - resource managed variant of fpga_mgr_register()
> >>>>> - * @dev: managing device for this FPGA manager
> >>>>> - * @mgr: fpga manager struct
> >>>>> + * @dev:    fpga manager device from pdev
> >>>>> + * @name:    fpga manager name
> >>>>> + * @mops:    pointer to structure of fpga manager ops
> >>>>> + * @priv:    fpga manager private data
> >>>>>    *
> >>>>>    * This is the devres variant of fpga_mgr_register() for which the unregister
> >>>>>    * function will be called automatically when the managing device is detached.
> >>>>>    */
> >>>>> -int devm_fpga_mgr_register(struct device *dev, struct fpga_manager *mgr)
> >>>>> +struct fpga_manager *
> >>>>> +devm_fpga_mgr_register(struct device *dev, const char *name,
> >>>>     devm_fpga_mgr_register(struct device *parent,
> >>> Yes - thanks for catching that.
> >>>
> >>> - Russ
> >>>
> >>>>> +               const struct fpga_manager_ops *mops, void *priv)
> >>>>>   {
> >>>>>       struct fpga_mgr_devres *dr;
> >>>>> -    int ret;
> >>>>> -
> >>>>> -    /*
> >>>>> -     * Make sure that the struct fpga_manager * that is passed in is
> >>>>> -     * managed itself.
> >>>>> -     */
> >>>>> -    if (WARN_ON(!devres_find(dev, devm_fpga_mgr_release,
> >>>>> -                 fpga_mgr_devres_match, mgr)))
> >>>>> -        return -EINVAL;
> >>>>> +    struct fpga_manager *mgr;
> >>>>>         dr = devres_alloc(devm_fpga_mgr_unregister, sizeof(*dr), GFP_KERNEL);
> >>>>>       if (!dr)
> >>>>> -        return -ENOMEM;
> >>>>> +        return ERR_PTR(-ENOMEM);
> >>>>>   -    ret = fpga_mgr_register(mgr);
> >>>>> -    if (ret) {
> >>>>> +    mgr = fpga_mgr_register(dev, name, mops, priv);
> >>>>> +    if (IS_ERR(mgr)) {
> >>>>>           devres_free(dr);
> >>>>> -        return ret;
> >>>>> +        return mgr;
> >>>>>       }
> >>>>>         dr->mgr = mgr;
> >>>>>       devres_add(dev, dr);
> >>>>>   -    return 0;
> >>>>> +    return mgr;
> >>>>>   }
> >>>>>   EXPORT_SYMBOL_GPL(devm_fpga_mgr_register);
> >>>>>     static void fpga_mgr_dev_release(struct device *dev)
> >>>>>   {
> >>>>> +    struct fpga_manager *mgr = to_fpga_manager(dev);
> >>>>> +
> >>>>> +    ida_simple_remove(&fpga_mgr_ida, mgr->dev.id);
> >>>>> +    kfree(mgr);
> >>>>>   }
> >>>>>     static int __init fpga_mgr_class_init(void)
> >>>>> diff --git a/drivers/fpga/ice40-spi.c b/drivers/fpga/ice40-spi.c
> >>>>> index 69dec5af23c3..91ac25f339f3 100644
> >>>>> --- a/drivers/fpga/ice40-spi.c
> >>>>> +++ b/drivers/fpga/ice40-spi.c
> >>>>> @@ -178,12 +178,12 @@ static int ice40_fpga_probe(struct spi_device *spi)
> >>>>>           return ret;
> >>>>>       }
> >>>>>   -    mgr = devm_fpga_mgr_create(dev, "Lattice iCE40 FPGA Manager",
> >>>>> -                   &ice40_fpga_ops, priv);
> >>>>> -    if (!mgr)
> >>>>> -        return -ENOMEM;
> >>>>> +    mgr = devm_fpga_mgr_register(dev, "Lattice iCE40 FPGA Manager",
> >>>>> +                     &ice40_fpga_ops, priv);
> >>>>> +    if (IS_ERR(mgr))
> >>>>> +        return PTR_ERR(mgr);
> >>>>>   -    return devm_fpga_mgr_register(dev, mgr);
> >>>>> +    return 0;
> >>>>>   }
> >>>>>     static const struct of_device_id ice40_fpga_of_match[] = {
> >>>>> diff --git a/drivers/fpga/machxo2-spi.c b/drivers/fpga/machxo2-spi.c
> >>>>> index 114a64d2b7a4..0137c1e2e706 100644
> >>>>> --- a/drivers/fpga/machxo2-spi.c
> >>>>> +++ b/drivers/fpga/machxo2-spi.c
> >>>>> @@ -366,12 +366,12 @@ static int machxo2_spi_probe(struct spi_device *spi)
> >>>>>           return -EINVAL;
> >>>>>       }
> >>>>>   -    mgr = devm_fpga_mgr_create(dev, "Lattice MachXO2 SPI FPGA Manager",
> >>>>> -                   &machxo2_ops, spi);
> >>>>> -    if (!mgr)
> >>>>> -        return -ENOMEM;
> >>>>> +    mgr = devm_fpga_mgr_register(dev, "Lattice MachXO2 SPI FPGA Manager",
> >>>>> +                     &machxo2_ops, spi);
> >>>>> +    if (IS_ERR(mgr))
> >>>>> +        return PTR_ERR(mgr);
> >>>>>   -    return devm_fpga_mgr_register(dev, mgr);
> >>>>> +    return 0;
> >>>>>   }
> >>>>>     static const struct of_device_id of_match[] = {
> >>>>> diff --git a/drivers/fpga/socfpga-a10.c b/drivers/fpga/socfpga-a10.c
> >>>>> index 573d88bdf730..ac8e89b8a5cc 100644
> >>>>> --- a/drivers/fpga/socfpga-a10.c
> >>>>> +++ b/drivers/fpga/socfpga-a10.c
> >>>>> @@ -508,19 +508,15 @@ static int socfpga_a10_fpga_probe(struct platform_device *pdev)
> >>>>>           return -EBUSY;
> >>>>>       }
> >>>>>   -    mgr = devm_fpga_mgr_create(dev, "SoCFPGA Arria10 FPGA Manager",
> >>>>> -                   &socfpga_a10_fpga_mgr_ops, priv);
> >>>>> -    if (!mgr)
> >>>>> -        return -ENOMEM;
> >>>>> -
> >>>>> -    platform_set_drvdata(pdev, mgr);
> >>>>> -
> >>>>> -    ret = fpga_mgr_register(mgr);
> >>>>> -    if (ret) {
> >>>>> +    mgr = fpga_mgr_register(dev, "SoCFPGA Arria10 FPGA Manager",
> >>>>> +                &socfpga_a10_fpga_mgr_ops, priv);
> >>>>> +    if (IS_ERR(mgr)) {
> >>>>>           clk_disable_unprepare(priv->clk);
> >>>>> -        return ret;
> >>>>> +        return PTR_ERR(mgr);
> >>>>>       }
> >>>>>   +    platform_set_drvdata(pdev, mgr);
> >>>>> +
> >>>>>       return 0;
> >>>>>   }
> >>>>>   diff --git a/drivers/fpga/socfpga.c b/drivers/fpga/socfpga.c
> >>>>> index 1f467173fc1f..ebfa9f4d24ef 100644
> >>>>> --- a/drivers/fpga/socfpga.c
> >>>>> +++ b/drivers/fpga/socfpga.c
> >>>>> @@ -571,12 +571,12 @@ static int socfpga_fpga_probe(struct platform_device *pdev)
> >>>>>       if (ret)
> >>>>>           return ret;
> >>>>>   -    mgr = devm_fpga_mgr_create(dev, "Altera SOCFPGA FPGA Manager",
> >>>>> -                   &socfpga_fpga_ops, priv);
> >>>>> -    if (!mgr)
> >>>>> -        return -ENOMEM;
> >>>>> +    mgr = devm_fpga_mgr_register(dev, "Altera SOCFPGA FPGA Manager",
> >>>>> +                     &socfpga_fpga_ops, priv);
> >>>>> +    if (IS_ERR(mgr))
> >>>>> +        return PTR_ERR(mgr);
> >>>>>   -    return devm_fpga_mgr_register(dev, mgr);
> >>>>> +    return 0;
> >>>>>   }
> >>>>>     #ifdef CONFIG_OF
> >>>>> diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
> >>>>> index a2cea500f7cc..9155e888a133 100644
> >>>>> --- a/drivers/fpga/stratix10-soc.c
> >>>>> +++ b/drivers/fpga/stratix10-soc.c
> >>>>> @@ -425,18 +425,11 @@ static int s10_probe(struct platform_device *pdev)
> >>>>>         init_completion(&priv->status_return_completion);
> >>>>>   -    mgr = fpga_mgr_create(dev, "Stratix10 SOC FPGA Manager",
> >>>>> -                  &s10_ops, priv);
> >>>>> -    if (!mgr) {
> >>>>> -        dev_err(dev, "unable to create FPGA manager\n");
> >>>>> -        ret = -ENOMEM;
> >>>>> -        goto probe_err;
> >>>>> -    }
> >>>>> -
> >>>>> -    ret = fpga_mgr_register(mgr);
> >>>>> -    if (ret) {
> >>>>> +    mgr = fpga_mgr_register(dev, "Stratix10 SOC FPGA Manager",
> >>>>> +                &s10_ops, priv);
> >>>>> +    if (IS_ERR(mgr)) {
> >>>>>           dev_err(dev, "unable to register FPGA manager\n");
> >>>>> -        fpga_mgr_free(mgr);
> >>>>> +        ret = PTR_ERR(mgr);
> >>>>>           goto probe_err;
> >>>>>       }
> >>>>>   @@ -454,7 +447,6 @@ static int s10_remove(struct platform_device *pdev)
> >>>>>       struct s10_priv *priv = mgr->priv;
> >>>>>         fpga_mgr_unregister(mgr);
> >>>>> -    fpga_mgr_free(mgr);
> >>>>>       stratix10_svc_free_channel(priv->chan);
> >>>>>         return 0;
> >>>>> diff --git a/drivers/fpga/ts73xx-fpga.c b/drivers/fpga/ts73xx-fpga.c
> >>>>> index 101f016c6ed8..5efbec2b9f9f 100644
> >>>>> --- a/drivers/fpga/ts73xx-fpga.c
> >>>>> +++ b/drivers/fpga/ts73xx-fpga.c
> >>>>> @@ -122,12 +122,12 @@ static int ts73xx_fpga_probe(struct platform_device *pdev)
> >>>>>       if (IS_ERR(priv->io_base))
> >>>>>           return PTR_ERR(priv->io_base);
> >>>>>   -    mgr = devm_fpga_mgr_create(kdev, "TS-73xx FPGA Manager",
> >>>>> -                   &ts73xx_fpga_ops, priv);
> >>>>> -    if (!mgr)
> >>>>> -        return -ENOMEM;
> >>>>> +    mgr = devm_fpga_mgr_register(kdev, "TS-73xx FPGA Manager",
> >>>>> +                     &ts73xx_fpga_ops, priv);
> >>>>> +    if (IS_ERR(mgr))
> >>>>> +        return PTR_ERR(mgr);
> >>>>>   -    return devm_fpga_mgr_register(kdev, mgr);
> >>>>> +    return 0;
> >>>>>   }
> >>>>>     static struct platform_driver ts73xx_fpga_driver = {
> >>>>> diff --git a/drivers/fpga/xilinx-spi.c b/drivers/fpga/xilinx-spi.c
> >>>>> index fee4d0abf6bf..efda475f7a98 100644
> >>>>> --- a/drivers/fpga/xilinx-spi.c
> >>>>> +++ b/drivers/fpga/xilinx-spi.c
> >>>>> @@ -247,13 +247,13 @@ static int xilinx_spi_probe(struct spi_device *spi)
> >>>>>           return dev_err_probe(&spi->dev, PTR_ERR(conf->done),
> >>>>>                        "Failed to get DONE gpio\n");
> >>>>>   -    mgr = devm_fpga_mgr_create(&spi->dev,
> >>>>> -                   "Xilinx Slave Serial FPGA Manager",
> >>>>> -                   &xilinx_spi_ops, conf);
> >>>>> -    if (!mgr)
> >>>>> -        return -ENOMEM;
> >>>>> +    mgr = devm_fpga_mgr_register(&spi->dev,
> >>>>> +                     "Xilinx Slave Serial FPGA Manager",
> >>>>> +                     &xilinx_spi_ops, conf);
> >>>>> +    if (IS_ERR(mgr))
> >>>>> +        return PTR_ERR(mgr);
> >>>>>   -    return devm_fpga_mgr_register(&spi->dev, mgr);
> >>>>> +    return 0;
> >>>>>   }
> >>>>>     static const struct of_device_id xlnx_spi_of_match[] = {
> >>>>> diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
> >>>>> index 9b75bd4f93d8..426aa34c6a0d 100644
> >>>>> --- a/drivers/fpga/zynq-fpga.c
> >>>>> +++ b/drivers/fpga/zynq-fpga.c
> >>>>> @@ -609,20 +609,16 @@ static int zynq_fpga_probe(struct platform_device *pdev)
> >>>>>         clk_disable(priv->clk);
> >>>>>   -    mgr = devm_fpga_mgr_create(dev, "Xilinx Zynq FPGA Manager",
> >>>>> -                   &zynq_fpga_ops, priv);
> >>>>> -    if (!mgr)
> >>>>> -        return -ENOMEM;
> >>>>> -
> >>>>> -    platform_set_drvdata(pdev, mgr);
> >>>>> -
> >>>>> -    err = fpga_mgr_register(mgr);
> >>>>> -    if (err) {
> >>>>> +    mgr = fpga_mgr_register(dev, "Xilinx Zynq FPGA Manager",
> >>>>> +                &zynq_fpga_ops, priv);
> >>>>> +    if (IS_ERR(mgr)) {
> >>>>>           dev_err(dev, "unable to register FPGA manager\n");
> >>>>>           clk_unprepare(priv->clk);
> >>>>> -        return err;
> >>>>> +        return PTR_ERR(mgr);
> >>>>>       }
> >>>>>   +    platform_set_drvdata(pdev, mgr);
> >>>>> +
> >>>>>       return 0;
> >>>>>   }
> >>>>>   diff --git a/drivers/fpga/zynqmp-fpga.c b/drivers/fpga/zynqmp-fpga.c
> >>>>> index 125743c9797f..1a6d520985be 100644
> >>>>> --- a/drivers/fpga/zynqmp-fpga.c
> >>>>> +++ b/drivers/fpga/zynqmp-fpga.c
> >>>>> @@ -102,12 +102,12 @@ static int zynqmp_fpga_probe(struct platform_device *pdev)
> >>>>>         priv->dev = dev;
> >>>>>   -    mgr = devm_fpga_mgr_create(dev, "Xilinx ZynqMP FPGA Manager",
> >>>>> -                   &zynqmp_fpga_ops, priv);
> >>>>> -    if (!mgr)
> >>>>> -        return -ENOMEM;
> >>>>> +    mgr = devm_fpga_mgr_register(dev, "Xilinx ZynqMP FPGA Manager",
> >>>>> +                     &zynqmp_fpga_ops, priv);
> >>>>> +    if (IS_ERR(mgr))
> >>>>> +        return PTR_ERR(mgr);
> >>>>>   -    return devm_fpga_mgr_register(dev, mgr);
> >>>>> +    return 0;
> >>>>>   }
> >>>>>     static const struct of_device_id zynqmp_fpga_of_match[] = {
> >>>>> diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
> >>>>> index 474c1f506307..d3c6f0153457 100644
> >>>>> --- a/include/linux/fpga/fpga-mgr.h
> >>>>> +++ b/include/linux/fpga/fpga-mgr.h
> >>>>> @@ -105,6 +105,17 @@ struct fpga_image_info {
> >>>>>   #endif
> >>>>>   };
> >>>>>   +/**
> >>>>> + * struct fpga_compat_id - id for compatibility check
> >>>>> + *
> >>>>> + * @id_h: high 64bit of the compat_id
> >>>>> + * @id_l: low 64bit of the compat_id
> >>>>> + */
> >>>>> +struct fpga_compat_id {
> >>>>> +    u64 id_h;
> >>>>> +    u64 id_l;
> >>>>> +};
> >>>>> +
> >>>>>   /**
> >>>>>    * struct fpga_manager_ops - ops for low level fpga manager drivers
> >>>>>    * @initial_header_size: Maximum number of bytes that should be passed into write_init
> >>>>> @@ -116,6 +127,7 @@ struct fpga_image_info {
> >>>>>    * @write_complete: set FPGA to operating state after writing is done
> >>>>>    * @fpga_remove: optional: Set FPGA into a specific state during driver remove
> >>>>>    * @groups: optional attribute groups.
> >>>>> + * @compat_id: optional: FPGA manager id for compatibility check.
> >>>>>    *
> >>>>>    * fpga_manager_ops are the low level functions implemented by a specific
> >>>>>    * fpga manager driver.  The optional ones are tested for NULL before being
> >>>>> @@ -134,6 +146,7 @@ struct fpga_manager_ops {
> >>>>>                     struct fpga_image_info *info);
> >>>>>       void (*fpga_remove)(struct fpga_manager *mgr);
> >>>>>       const struct attribute_group **groups;
> >>>>> +    struct fpga_compat_id *compat_id;
> >>>> We don't have to move compat_id here, keep it in struct fpga_mgr
> >>>>
> >>>> Thanks,
> >>>> Yilun
> >>>>
> >>>>>   };
> >>>>>     /* FPGA manager status: Partial/Full Reconfiguration errors */
> >>>>> @@ -143,24 +156,12 @@ struct fpga_manager_ops {
> >>>>>   #define FPGA_MGR_STATUS_IP_PROTOCOL_ERR        BIT(3)
> >>>>>   #define FPGA_MGR_STATUS_FIFO_OVERFLOW_ERR    BIT(4)
> >>>>>   -/**
> >>>>> - * struct fpga_compat_id - id for compatibility check
> >>>>> - *
> >>>>> - * @id_h: high 64bit of the compat_id
> >>>>> - * @id_l: low 64bit of the compat_id
> >>>>> - */
> >>>>> -struct fpga_compat_id {
> >>>>> -    u64 id_h;
> >>>>> -    u64 id_l;
> >>>>> -};
> >>>>> -
> >>>>>   /**
> >>>>>    * struct fpga_manager - fpga manager structure
> >>>>>    * @name: name of low level fpga manager
> >>>>>    * @dev: fpga manager device
> >>>>>    * @ref_mutex: only allows one reference to fpga manager
> >>>>>    * @state: state of fpga manager
> >>>>> - * @compat_id: FPGA manager id for compatibility check.
> >>>>>    * @mops: pointer to struct of fpga manager ops
> >>>>>    * @priv: low level driver private date
> >>>>>    */
> >>>>> @@ -169,7 +170,6 @@ struct fpga_manager {
> >>>>>       struct device dev;
> >>>>>       struct mutex ref_mutex;
> >>>>>       enum fpga_mgr_states state;
> >>>>> -    struct fpga_compat_id *compat_id;
> >>>>>       const struct fpga_manager_ops *mops;
> >>>>>       void *priv;
> >>>>>   };
> >>>>> @@ -191,17 +191,14 @@ struct fpga_manager *fpga_mgr_get(struct device *dev);
> >>>>>     void fpga_mgr_put(struct fpga_manager *mgr);
> >>>>>   -struct fpga_manager *fpga_mgr_create(struct device *dev, const char *name,
> >>>>> -                     const struct fpga_manager_ops *mops,
> >>>>> -                     void *priv);
> >>>>> -void fpga_mgr_free(struct fpga_manager *mgr);
> >>>>> -int fpga_mgr_register(struct fpga_manager *mgr);
> >>>>> +struct fpga_manager *fpga_mgr_register(struct device *dev, const char *name,
> >>>>> +                       const struct fpga_manager_ops *mops,
> >>>>> +                       void *priv);
> >>>>>   void fpga_mgr_unregister(struct fpga_manager *mgr);
> >>>>>   -int devm_fpga_mgr_register(struct device *dev, struct fpga_manager *mgr);
> >>>>> -
> >>>>> -struct fpga_manager *devm_fpga_mgr_create(struct device *dev, const char *name,
> >>>>> -                      const struct fpga_manager_ops *mops,
> >>>>> -                      void *priv);
> >>>>> +struct fpga_manager *
> >>>>> +devm_fpga_mgr_register(struct device *dev, const char *name,
> >>>>> +               const struct fpga_manager_ops *mops,
> >>>>> +               void *priv);
> >>>>>     #endif /*_LINUX_FPGA_MGR_H */
> >>>>> -- 
> >>>>> 2.25.1
> >

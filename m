Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9BB539C22F
	for <lists+linux-fpga@lfdr.de>; Fri,  4 Jun 2021 23:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbhFDVTB (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 4 Jun 2021 17:19:01 -0400
Received: from mga18.intel.com ([134.134.136.126]:45035 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230123AbhFDVTB (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 4 Jun 2021 17:19:01 -0400
IronPort-SDR: u37Z5K6/lm4KhQi1htb0G1S4zn9i1/xsY3sZUDxvpXuXwUfz6GJr+4kXh2Y8NZsEt+QMYRDkX5
 xC+BnPQ4Zr/g==
X-IronPort-AV: E=McAfee;i="6200,9189,10005"; a="191705109"
X-IronPort-AV: E=Sophos;i="5.83,248,1616482800"; 
   d="scan'208";a="191705109"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2021 14:17:13 -0700
IronPort-SDR: pHY4bcHDMtqXWfnyIgXuv6qV7iDvHRQmIF/jcm+fNs1Tmetlc4QBrHvyHJYWQGKKhZnbvV23US
 5ZRSaWb9+Fiw==
X-IronPort-AV: E=Sophos;i="5.83,248,1616482800"; 
   d="scan'208";a="484058782"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO [10.0.2.4]) ([10.212.182.189])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2021 14:17:12 -0700
Subject: Re: [PATCH v4 1/3] fpga: mgr: Use standard dev_release for class
 driver
To:     Tom Rix <trix@redhat.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org
Cc:     lgoncalv@redhat.com, yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@intel.com, richard.gong@intel.com
References: <20210528215755.839712-1-russell.h.weight@intel.com>
 <20210528215755.839712-2-russell.h.weight@intel.com>
 <3741e1dd-e010-79c0-7d27-930192f632a8@redhat.com>
 <92ced1b2-1ea7-58ce-32d3-413ee474efc8@intel.com>
 <bed407db-4b67-2c45-df17-dee891335000@intel.com>
 <94b1f6f1-5117-b081-7d9b-e5ea5071b8de@redhat.com>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <472c981b-03c8-f10b-713c-6d3d747498aa@intel.com>
Date:   Fri, 4 Jun 2021 14:17:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <94b1f6f1-5117-b081-7d9b-e5ea5071b8de@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 6/4/21 1:56 PM, Tom Rix wrote:
>
> On 6/3/21 3:45 PM, Russ Weight wrote:
>>
>> On 6/1/21 5:38 PM, Russ Weight wrote:
>>> On 6/1/21 4:24 PM, Tom Rix wrote:
>>>> On 5/28/21 2:57 PM, Russ Weight wrote:
>>>>> The FPGA manager class driver data structure is being treated as a
>>>>> managed resource instead of using standard dev_release call-back
>>>>> to release the class data structure. This change removes the
>>>>> managed resource code for the freeing of the class data structure
>>>>> and combines the create() and register() functions into a single
>>>>> register() function.
>>>>>
>>>>> The devm_fpga_mgr_register() function is retained.
>>>>>
>>>>> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
>>>>> ---
>>>>> v4:
>>>>>     - Added the compat_id parameter to fpga_mgr_register() and
>>>> On a refactor, it is best to do the refactoring as mechanically as possible.
>>>>
>>>> While compat_id may be useful, it should be done in a separate patch.
>>> These would have to be included with the changes merge the create and register
>>> functions into a single function.
>>>
>>>> Unless it is really needed for your next security update patch consider resubmitting later
>>>>
>>>>>       devm_fpga_mgr_register() to ensure that the compat_id is set before
>>>>>       the device_register() call.
>>>>> v3:
>>>>>     - Cleaned up comment header for fpga_mgr_register()
>>>>>     - Fix error return on ida_simple_get() failure
>>>>> v2:
>>>>>     - Restored devm_fpga_mgr_register() functionality, adapted for the combined
>>>>>       create/register functionality.
>>>>>     - All previous callers of devm_fpga_mgr_register() will continue to call
>>>>>       devm_fpga_mgr_register().
>>>>>     - replaced unnecessary ternary operators in return statements with standard
>>>>>       if conditions.
>>>>> ---
>>>>>    drivers/fpga/altera-cvp.c        |  12 +--
>>>>>    drivers/fpga/altera-pr-ip-core.c |   9 +-
>>>>>    drivers/fpga/altera-ps-spi.c     |  10 +-
>>>>>    drivers/fpga/dfl-fme-mgr.c       |  12 +--
>>>>>    drivers/fpga/fpga-mgr.c          | 168 +++++++++----------------------
>>>>>    drivers/fpga/ice40-spi.c         |  10 +-
>>>>>    drivers/fpga/machxo2-spi.c       |  10 +-
>>>>>    drivers/fpga/socfpga-a10.c       |  16 ++-
>>>>>    drivers/fpga/socfpga.c           |  10 +-
>>>>>    drivers/fpga/stratix10-soc.c     |  15 +--
>>>>>    drivers/fpga/ts73xx-fpga.c       |  10 +-
>>>>>    drivers/fpga/xilinx-spi.c        |  12 +--
>>>>>    drivers/fpga/zynq-fpga.c         |  16 ++-
>>>>>    drivers/fpga/zynqmp-fpga.c       |  10 +-
>>>>>    include/linux/fpga/fpga-mgr.h    |  19 ++--
>>>>>    15 files changed, 120 insertions(+), 219 deletions(-)
>>>> ./Documentation/driver-api/fpga/fpga-mgr.rst
>>>>
>>>> still refers to fpga_mgr_create.
>>> Thanks for catching that.
>>>
>>>>> diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
>>>>> index 4e0edb60bfba..25eaa97ae7aa 100644
>>>>> --- a/drivers/fpga/altera-cvp.c
>>>>> +++ b/drivers/fpga/altera-cvp.c
>>>>> @@ -652,19 +652,15 @@ static int altera_cvp_probe(struct pci_dev *pdev,
>>>>>        snprintf(conf->mgr_name, sizeof(conf->mgr_name), "%s @%s",
>>>>>             ALTERA_CVP_MGR_NAME, pci_name(pdev));
>>>>>    -    mgr = devm_fpga_mgr_create(&pdev->dev, conf->mgr_name,
>>>>> -                   &altera_cvp_ops, conf);
>>>>> -    if (!mgr) {
>>>>> -        ret = -ENOMEM;
>>>>> +    mgr = fpga_mgr_register(&pdev->dev, conf->mgr_name, NULL,
>>>>> +                &altera_cvp_ops, conf);
>>>>> +    if (IS_ERR(mgr)) {
>>>>> +        ret = PTR_ERR(mgr);
>>>>>            goto err_unmap;
>>>>>        }
>>>>>          pci_set_drvdata(pdev, mgr);
>>>>>    -    ret = fpga_mgr_register(mgr);
>>>>> -    if (ret)
>>>>> -        goto err_unmap;
>>>>> -
>>>>>        return 0;
>>>>>      err_unmap:
>>>>> diff --git a/drivers/fpga/altera-pr-ip-core.c b/drivers/fpga/altera-pr-ip-core.c
>>>>> index 5b130c4d9882..bfd4de1e7ac5 100644
>>>>> --- a/drivers/fpga/altera-pr-ip-core.c
>>>>> +++ b/drivers/fpga/altera-pr-ip-core.c
>>>>> @@ -191,11 +191,12 @@ int alt_pr_register(struct device *dev, void __iomem *reg_base)
>>>>>            (val & ALT_PR_CSR_STATUS_MSK) >> ALT_PR_CSR_STATUS_SFT,
>>>>>            (int)(val & ALT_PR_CSR_PR_START));
>>>>>    -    mgr = devm_fpga_mgr_create(dev, dev_name(dev), &alt_pr_ops, priv);
>>>>> -    if (!mgr)
>>>>> -        return -ENOMEM;
>>>>> +    mgr = devm_fpga_mgr_register(dev, dev_name(dev), NULL,
>>>>> +                     &alt_pr_ops, priv);
>>>>> +    if (IS_ERR(mgr))
>>>>> +        return PTR_ERR(mgr);
>>>>>    -    return devm_fpga_mgr_register(dev, mgr);
>>>>> +    return 0;
>>>>>    }
>>>>>    EXPORT_SYMBOL_GPL(alt_pr_register);
>>>>>    diff --git a/drivers/fpga/altera-ps-spi.c b/drivers/fpga/altera-ps-spi.c
>>>>> index 23bfd4d1ad0f..e6fc7208213c 100644
>>>>> --- a/drivers/fpga/altera-ps-spi.c
>>>>> +++ b/drivers/fpga/altera-ps-spi.c
>>>>> @@ -302,12 +302,12 @@ static int altera_ps_probe(struct spi_device *spi)
>>>>>        snprintf(conf->mgr_name, sizeof(conf->mgr_name), "%s %s",
>>>>>             dev_driver_string(&spi->dev), dev_name(&spi->dev));
>>>>>    -    mgr = devm_fpga_mgr_create(&spi->dev, conf->mgr_name,
>>>>> -                   &altera_ps_ops, conf);
>>>>> -    if (!mgr)
>>>>> -        return -ENOMEM;
>>>>> +    mgr = devm_fpga_mgr_register(&spi->dev, conf->mgr_name, NULL,
>>>>> +                     &altera_ps_ops, conf);
>>>>> +    if (IS_ERR(mgr))
>>>>> +        return PTR_ERR(mgr);
>>>>>    -    return devm_fpga_mgr_register(&spi->dev, mgr);
>>>>> +    return 0;
>>>>>    }
>>>>>      static const struct spi_device_id altera_ps_spi_ids[] = {
>>>>> diff --git a/drivers/fpga/dfl-fme-mgr.c b/drivers/fpga/dfl-fme-mgr.c
>>>>> index d5861d13b306..c9b98afa7d50 100644
>>>>> --- a/drivers/fpga/dfl-fme-mgr.c
>>>>> +++ b/drivers/fpga/dfl-fme-mgr.c
>>>>> @@ -308,14 +308,12 @@ static int fme_mgr_probe(struct platform_device *pdev)
>>>>>          fme_mgr_get_compat_id(priv->ioaddr, compat_id);
>>>>>    -    mgr = devm_fpga_mgr_create(dev, "DFL FME FPGA Manager",
>>>>> -                   &fme_mgr_ops, priv);
>>>>> -    if (!mgr)
>>>>> -        return -ENOMEM;
>>>>> -
>>>>> -    mgr->compat_id = compat_id;
>>>>> +    mgr = devm_fpga_mgr_register(dev, "DFL FME FPGA Manager", compat_id,
>>>>> +                     &fme_mgr_ops, priv);
>>>>> +    if (IS_ERR(mgr))
>>>>> +        return PTR_ERR(mgr);
>>>>>    -    return devm_fpga_mgr_register(dev, mgr);
>>>>> +    return 0;
>>>>>    }
>>>>>      static struct platform_driver fme_mgr_driver = {
>>>>> diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
>>>>> index b85bc47c91a9..d6d64ce34417 100644
>>>>> --- a/drivers/fpga/fpga-mgr.c
>>>>> +++ b/drivers/fpga/fpga-mgr.c
>>>>> @@ -550,20 +550,22 @@ void fpga_mgr_unlock(struct fpga_manager *mgr)
>>>>>    EXPORT_SYMBOL_GPL(fpga_mgr_unlock);
>>>>>      /**
>>>>> - * fpga_mgr_create - create and initialize a FPGA manager struct
>>>>> + * fpga_mgr_register - create and register a FPGA Manager device
>>>>>     * @dev:    fpga manager device from pdev
>>>>>     * @name:    fpga manager name
>>>>> + * @compat_id:    FPGA manager id for compatibility check.
>>>> for consistency, use lowercase fpga
>>>>
>>>> similar issue below.
>>> OK
>>>
>>>>>     * @mops:    pointer to structure of fpga manager ops
>>>>>     * @priv:    fpga manager private data
>>>>>     *
>>>>> - * The caller of this function is responsible for freeing the struct with
>>>>> - * fpga_mgr_free().  Using devm_fpga_mgr_create() instead is recommended.
>>>>> + * The caller of this function is responsible for calling fpga_mgr_unregister().
>>>>> + * Using devm_fpga_mgr_register instead is recommended.
>>>>>     *
>>>>> - * Return: pointer to struct fpga_manager or NULL
>>>>> + * Return: struct fpga_manager pointer on success, ERR_PTR() on error.
>>>>>     */
>>>>> -struct fpga_manager *fpga_mgr_create(struct device *dev, const char *name,
>>>>> -                     const struct fpga_manager_ops *mops,
>>>>> -                     void *priv)
>>>>> +struct fpga_manager *
>>>>> +fpga_mgr_register(struct device *dev, const char *name,
>>>>> +          struct fpga_compat_id *compat_id,
>>>>> +          const struct fpga_manager_ops *mops, void *priv)
>>>>>    {
>>>>>        struct fpga_manager *mgr;
>>>>>        int id, ret;
>>>>> @@ -572,29 +574,31 @@ struct fpga_manager *fpga_mgr_create(struct device *dev, const char *name,
>>>>>            !mops->write_init || (!mops->write && !mops->write_sg) ||
>>>>>            (mops->write && mops->write_sg)) {
>>>>>            dev_err(dev, "Attempt to register without fpga_manager_ops\n");
>>>>> -        return NULL;
>>>>> +        return ERR_PTR(-EINVAL);
>>>>>        }
>>>>>          if (!name || !strlen(name)) {
>>>>>            dev_err(dev, "Attempt to register with no name!\n");
>>>>> -        return NULL;
>>>>> +        return ERR_PTR(-EINVAL);
>>>>>        }
>>>>>          mgr = kzalloc(sizeof(*mgr), GFP_KERNEL);
>>>>>        if (!mgr)
>>>>> -        return NULL;
>>>>> +        return ERR_PTR(-ENOMEM);
>>>>>          id = ida_simple_get(&fpga_mgr_ida, 0, 0, GFP_KERNEL);
>>>>> -    if (id < 0)
>>>>> +    if (id < 0) {
>>>>> +        ret = id;
>>>> ida_* returns a normal error, so needs a wrapping in
>>>>
>>>> ret = ERR_PTR(id)
>>> Thanks - I'll fix that
>> Actually, if you follow the "goto error_kfree", you will see that ret is
>> wrapped in ERR_PTR() in the return statement, so id does not need to be
>> wrapped here.
>>
>>>>>            goto error_kfree;
>>>>> +    }
>>>>>          mutex_init(&mgr->ref_mutex);
>>>>>          mgr->name = name;
>>>>> +    mgr->compat_id = compat_id;
>>>>>        mgr->mops = mops;
>>>>>        mgr->priv = priv;
>>>>>    -    device_initialize(&mgr->dev);
>>>>>        mgr->dev.class = fpga_mgr_class;
>>>>>        mgr->dev.groups = mops->groups;
>>>>>        mgr->dev.parent = dev;
>>>>> @@ -605,84 +609,6 @@ struct fpga_manager *fpga_mgr_create(struct device *dev, const char *name,
>>>>>        if (ret)
>>>>>            goto error_device;
>>>>>    -    return mgr;
>>>>> -
>>>>> -error_device:
>>>>> -    ida_simple_remove(&fpga_mgr_ida, id);
>>>>> -error_kfree:
>>>>> -    kfree(mgr);
>>>>> -
>>>>> -    return NULL;
>>>>> -}
>>>>> -EXPORT_SYMBOL_GPL(fpga_mgr_create);
>>>>> -
>>>>> -/**
>>>>> - * fpga_mgr_free - free a FPGA manager created with fpga_mgr_create()
>>>>> - * @mgr:    fpga manager struct
>>>>> - */
>>>>> -void fpga_mgr_free(struct fpga_manager *mgr)
>>>>> -{
>>>>> -    ida_simple_remove(&fpga_mgr_ida, mgr->dev.id);
>>>>> -    kfree(mgr);
>>>>> -}
>>>>> -EXPORT_SYMBOL_GPL(fpga_mgr_free);
>>>>> -
>>>>> -static void devm_fpga_mgr_release(struct device *dev, void *res)
>>>>> -{
>>>>> -    struct fpga_mgr_devres *dr = res;
>>>>> -
>>>>> -    fpga_mgr_free(dr->mgr);
>>>>> -}
>>>>> -
>>>>> -/**
>>>>> - * devm_fpga_mgr_create - create and initialize a managed FPGA manager struct
>>>>> - * @dev:    fpga manager device from pdev
>>>>> - * @name:    fpga manager name
>>>>> - * @mops:    pointer to structure of fpga manager ops
>>>>> - * @priv:    fpga manager private data
>>>>> - *
>>>>> - * This function is intended for use in a FPGA manager driver's probe function.
>>>>> - * After the manager driver creates the manager struct with
>>>>> - * devm_fpga_mgr_create(), it should register it with fpga_mgr_register().  The
>>>>> - * manager driver's remove function should call fpga_mgr_unregister().  The
>>>>> - * manager struct allocated with this function will be freed automatically on
>>>>> - * driver detach.  This includes the case of a probe function returning error
>>>>> - * before calling fpga_mgr_register(), the struct will still get cleaned up.
>>>>> - *
>>>>> - * Return: pointer to struct fpga_manager or NULL
>>>>> - */
>>>>> -struct fpga_manager *devm_fpga_mgr_create(struct device *dev, const char *name,
>>>>> -                      const struct fpga_manager_ops *mops,
>>>>> -                      void *priv)
>>>>> -{
>>>>> -    struct fpga_mgr_devres *dr;
>>>>> -
>>>>> -    dr = devres_alloc(devm_fpga_mgr_release, sizeof(*dr), GFP_KERNEL);
>>>>> -    if (!dr)
>>>>> -        return NULL;
>>>>> -
>>>>> -    dr->mgr = fpga_mgr_create(dev, name, mops, priv);
>>>>> -    if (!dr->mgr) {
>>>>> -        devres_free(dr);
>>>>> -        return NULL;
>>>>> -    }
>>>>> -
>>>>> -    devres_add(dev, dr);
>>>>> -
>>>>> -    return dr->mgr;
>>>>> -}
>>>>> -EXPORT_SYMBOL_GPL(devm_fpga_mgr_create);
>>>>> -
>>>>> -/**
>>>>> - * fpga_mgr_register - register a FPGA manager
>>>>> - * @mgr: fpga manager struct
>>>>> - *
>>>>> - * Return: 0 on success, negative error code otherwise.
>>>>> - */
>>>>> -int fpga_mgr_register(struct fpga_manager *mgr)
>>>>> -{
>>>>> -    int ret;
>>>>> -
>>>>>        /*
>>>>>         * Initialize framework state by requesting low level driver read state
>>>>>         * from device.  FPGA may be in reset mode or may have been programmed
>>>>> @@ -690,18 +616,20 @@ int fpga_mgr_register(struct fpga_manager *mgr)
>>>>>         */
>>>>>        mgr->state = mgr->mops->state(mgr);
>>>>>    -    ret = device_add(&mgr->dev);
>>>>> -    if (ret)
>>>>> -        goto error_device;
>>>>> -
>>>>> -    dev_info(&mgr->dev, "%s registered\n", mgr->name);
>>>> can we keep this dev_info() line and move it below device_register() ?
>>> In Greg's response to my driver, he said he said that a well-behaved driver does
>>> not need dev_info() calls...
>>>>> +    ret = device_register(&mgr->dev);
>>>>> +    if (ret) {
>>>>> +        put_device(&mgr->dev);
>>>> pr_err() here ?
>>> OK - I can add a message
>>>
>>>>> +        return ERR_PTR(ret);
>>>>> +    }
>>>>>    -    return 0;
>>>>> +    return mgr;
>>>>>      error_device:
>>>>> -    ida_simple_remove(&fpga_mgr_ida, mgr->dev.id);
>>>>> +    ida_simple_remove(&fpga_mgr_ida, id);
>>>>> +error_kfree:
>>>>> +    kfree(mgr);
>>>>>    -    return ret;
>>>>> +    return ERR_PTR(ret);
>>>>>    }
>>>>>    EXPORT_SYMBOL_GPL(fpga_mgr_register);
>>>>>    @@ -726,14 +654,6 @@ void fpga_mgr_unregister(struct fpga_manager *mgr)
>>>>>    }
>>>>>    EXPORT_SYMBOL_GPL(fpga_mgr_unregister);
>>>>>    -static int fpga_mgr_devres_match(struct device *dev, void *res,
>>>>> -                 void *match_data)
>>>>> -{
>>>>> -    struct fpga_mgr_devres *dr = res;
>>>>> -
>>>>> -    return match_data == dr->mgr;
>>>>> -}
>>>>> -
>>>>>    static void devm_fpga_mgr_unregister(struct device *dev, void *res)
>>>>>    {
>>>>>        struct fpga_mgr_devres *dr = res;
>>>>> @@ -743,44 +663,46 @@ static void devm_fpga_mgr_unregister(struct device *dev, void *res)
>>>>>      /**
>>>>>     * devm_fpga_mgr_register - resource managed variant of fpga_mgr_register()
>>>>> - * @dev: managing device for this FPGA manager
>>>>> - * @mgr: fpga manager struct
>>>>> + * @dev:    fpga manager device from pdev
>>>>> + * @name:    fpga manager name
>>>>> + * @compat_id:    FPGA manager id for compatibility check.
>>>>> + * @mops:    pointer to structure of fpga manager ops
>>>>> + * @priv:    fpga manager private data
>>>>>     *
>>>>>     * This is the devres variant of fpga_mgr_register() for which the unregister
>>>>>     * function will be called automatically when the managing device is detached.
>>>>>     */
>>>>> -int devm_fpga_mgr_register(struct device *dev, struct fpga_manager *mgr)
>>>>> +struct fpga_manager *
>>>>> +devm_fpga_mgr_register(struct device *dev, const char *name,
>>>>> +               struct fpga_compat_id *compat_id,
>>>>> +               const struct fpga_manager_ops *mops, void *priv)
>>>>>    {
>>>>>        struct fpga_mgr_devres *dr;
>>>>> -    int ret;
>>>>> -
>>>>> -    /*
>>>>> -     * Make sure that the struct fpga_manager * that is passed in is
>>>>> -     * managed itself.
>>>>> -     */
>>>>> -    if (WARN_ON(!devres_find(dev, devm_fpga_mgr_release,
>>>>> -                 fpga_mgr_devres_match, mgr)))
>>>>> -        return -EINVAL;
>>>>> +    struct fpga_manager *mgr;
>>>>>          dr = devres_alloc(devm_fpga_mgr_unregister, sizeof(*dr), GFP_KERNEL);
>>>>>        if (!dr)
>>>>> -        return -ENOMEM;
>>>>> +        return ERR_PTR(-ENOMEM);
>>>>>    -    ret = fpga_mgr_register(mgr);
>>>>> -    if (ret) {
>>>>> +    mgr = fpga_mgr_register(dev, name, compat_id, mops, priv);
>>>>> +    if (IS_ERR(mgr)) {
>>>>>            devres_free(dr);
>>>>> -        return ret;
>>>>> +        return mgr;
>>>>>        }
>>>>>          dr->mgr = mgr;
>>>>>        devres_add(dev, dr);
>>>>>    -    return 0;
>>>>> +    return mgr;
>>>>>    }
>>>>>    EXPORT_SYMBOL_GPL(devm_fpga_mgr_register);
>>>>>      static void fpga_mgr_dev_release(struct device *dev)
>>>>>    {
>>>>> +    struct fpga_manager *mgr = to_fpga_manager(dev);
>>>>> +
>>>>> +    ida_simple_remove(&fpga_mgr_ida, mgr->dev.id);
>>>>> +    kfree(mgr);
>>>>>    }
>>>>>      static int __init fpga_mgr_class_init(void)
>>>>> diff --git a/drivers/fpga/ice40-spi.c b/drivers/fpga/ice40-spi.c
>>>>> index 69dec5af23c3..b1c7c0713e11 100644
>>>>> --- a/drivers/fpga/ice40-spi.c
>>>>> +++ b/drivers/fpga/ice40-spi.c
>>>>> @@ -178,12 +178,12 @@ static int ice40_fpga_probe(struct spi_device *spi)
>>>>>            return ret;
>>>>>        }
>>>>>    -    mgr = devm_fpga_mgr_create(dev, "Lattice iCE40 FPGA Manager",
>>>>> -                   &ice40_fpga_ops, priv);
>>>>> -    if (!mgr)
>>>>> -        return -ENOMEM;
>>>>> +    mgr = devm_fpga_mgr_register(dev, "Lattice iCE40 FPGA Manager",
>>>>> +                     NULL, &ice40_fpga_ops, priv);
>>>>> +    if (IS_ERR(mgr))
>>>>> +        return PTR_ERR(mgr);
>>>>>    -    return devm_fpga_mgr_register(dev, mgr);
>>>>> +    return 0;
>>>>>    }
>>>>>      static const struct of_device_id ice40_fpga_of_match[] = {
>>>>> diff --git a/drivers/fpga/machxo2-spi.c b/drivers/fpga/machxo2-spi.c
>>>>> index 114a64d2b7a4..75cc6efaa1b6 100644
>>>>> --- a/drivers/fpga/machxo2-spi.c
>>>>> +++ b/drivers/fpga/machxo2-spi.c
>>>>> @@ -366,12 +366,12 @@ static int machxo2_spi_probe(struct spi_device *spi)
>>>>>            return -EINVAL;
>>>>>        }
>>>>>    -    mgr = devm_fpga_mgr_create(dev, "Lattice MachXO2 SPI FPGA Manager",
>>>>> -                   &machxo2_ops, spi);
>>>>> -    if (!mgr)
>>>>> -        return -ENOMEM;
>>>>> +    mgr = devm_fpga_mgr_register(dev, "Lattice MachXO2 SPI FPGA Manager",
>>>>> +                     NULL, &machxo2_ops, spi);
>>>>> +    if (IS_ERR(mgr))
>>>>> +        return PTR_ERR(mgr);
>>>>>    -    return devm_fpga_mgr_register(dev, mgr);
>>>>> +    return 0;
>>>>>    }
>>>>>      static const struct of_device_id of_match[] = {
>>>>> diff --git a/drivers/fpga/socfpga-a10.c b/drivers/fpga/socfpga-a10.c
>>>>> index 573d88bdf730..80b8891fb302 100644
>>>>> --- a/drivers/fpga/socfpga-a10.c
>>>>> +++ b/drivers/fpga/socfpga-a10.c
>>>>> @@ -508,19 +508,15 @@ static int socfpga_a10_fpga_probe(struct platform_device *pdev)
>>>>>            return -EBUSY;
>>>>>        }
>>>>>    -    mgr = devm_fpga_mgr_create(dev, "SoCFPGA Arria10 FPGA Manager",
>>>>> -                   &socfpga_a10_fpga_mgr_ops, priv);
>>>>> -    if (!mgr)
>>>>> -        return -ENOMEM;
>>>>> -
>>>>> -    platform_set_drvdata(pdev, mgr);
>>>>> -
>>>>> -    ret = fpga_mgr_register(mgr);
>>>>> -    if (ret) {
>>>>> +    mgr = fpga_mgr_register(dev, "SoCFPGA Arria10 FPGA Manager",
>>>>> +                NULL, &socfpga_a10_fpga_mgr_ops, priv);
>>>>> +    if (IS_ERR(mgr)) {
>>>>>            clk_disable_unprepare(priv->clk);
>>>>> -        return ret;
>>>>> +        return PTR_ERR(mgr);
>>>>>        }
>>>>>    +    platform_set_drvdata(pdev, mgr);
>>>>> +
>>>>>        return 0;
>>>>>    }
>>>>>    diff --git a/drivers/fpga/socfpga.c b/drivers/fpga/socfpga.c
>>>>> index 1f467173fc1f..06edfab8a496 100644
>>>>> --- a/drivers/fpga/socfpga.c
>>>>> +++ b/drivers/fpga/socfpga.c
>>>>> @@ -571,12 +571,12 @@ static int socfpga_fpga_probe(struct platform_device *pdev)
>>>>>        if (ret)
>>>>>            return ret;
>>>>>    -    mgr = devm_fpga_mgr_create(dev, "Altera SOCFPGA FPGA Manager",
>>>>> -                   &socfpga_fpga_ops, priv);
>>>>> -    if (!mgr)
>>>>> -        return -ENOMEM;
>>>>> +    mgr = devm_fpga_mgr_register(dev, "Altera SOCFPGA FPGA Manager",
>>>>> +                     NULL, &socfpga_fpga_ops, priv);
>>>>> +    if (IS_ERR(mgr))
>>>>> +        return PTR_ERR(mgr);
>>>>>    -    return devm_fpga_mgr_register(dev, mgr);
>>>>> +    return 0;
>>>>>    }
>>>>>      #ifdef CONFIG_OF
>>>>> diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
>>>>> index 657a70c5fc99..434094c3ac69 100644
>>>>> --- a/drivers/fpga/stratix10-soc.c
>>>>> +++ b/drivers/fpga/stratix10-soc.c
>>>>> @@ -425,18 +425,11 @@ static int s10_probe(struct platform_device *pdev)
>>>>>          init_completion(&priv->status_return_completion);
>>>>>    -    mgr = fpga_mgr_create(dev, "Stratix10 SOC FPGA Manager",
>>>>> -                  &s10_ops, priv);
>>>>> -    if (!mgr) {
>>>>> -        dev_err(dev, "unable to create FPGA manager\n");
>>>>> -        ret = -ENOMEM;
>>>>> -        goto probe_err;
>>>>> -    }
>>>>> -
>>>>> -    ret = fpga_mgr_register(mgr);
>>>>> -    if (ret) {
>>>>> +    mgr = fpga_mgr_register(dev, "Stratix10 SOC FPGA Manager",
>>>>> +                NULL, &s10_ops, priv);
>>>>> +    if (IS_ERR(mgr)) {
>>>>>            dev_err(dev, "unable to register FPGA manager\n");
>>>>> -        fpga_mgr_free(mgr);
>>>>> +        ret = PTR_ERR(mgr);
>>>>>            goto probe_err;
>>>>>        }
>>>>>    diff --git a/drivers/fpga/ts73xx-fpga.c b/drivers/fpga/ts73xx-fpga.c
>>>>> index 101f016c6ed8..5efbec2b9f9f 100644
>>>>> --- a/drivers/fpga/ts73xx-fpga.c
>>>>> +++ b/drivers/fpga/ts73xx-fpga.c
>>>>> @@ -122,12 +122,12 @@ static int ts73xx_fpga_probe(struct platform_device *pdev)
>>>>>        if (IS_ERR(priv->io_base))
>>>>>            return PTR_ERR(priv->io_base);
>>>>>    -    mgr = devm_fpga_mgr_create(kdev, "TS-73xx FPGA Manager",
>>>>> -                   &ts73xx_fpga_ops, priv);
>>>>> -    if (!mgr)
>>>>> -        return -ENOMEM;
>>>>> +    mgr = devm_fpga_mgr_register(kdev, "TS-73xx FPGA Manager",
>>>> This is missing compat_id param.
>>> Thanks - I thought I'll do another pass and make sure I catch them all.
>>>
>>>> Similar for others.
>>>>
>>>>> +                     &ts73xx_fpga_ops, priv);
>>>>> +    if (IS_ERR(mgr))
>>>>> +        return PTR_ERR(mgr);
>>>>>    -    return devm_fpga_mgr_register(kdev, mgr);
>>>>> +    return 0;
>>>>>    }
>>>>>      static struct platform_driver ts73xx_fpga_driver = {
>>>>> diff --git a/drivers/fpga/xilinx-spi.c b/drivers/fpga/xilinx-spi.c
>>>>> index fee4d0abf6bf..6f1894929687 100644
>>>>> --- a/drivers/fpga/xilinx-spi.c
>>>>> +++ b/drivers/fpga/xilinx-spi.c
>>>>> @@ -247,13 +247,13 @@ static int xilinx_spi_probe(struct spi_device *spi)
>>>>>            return dev_err_probe(&spi->dev, PTR_ERR(conf->done),
>>>>>                         "Failed to get DONE gpio\n");
>>>>>    -    mgr = devm_fpga_mgr_create(&spi->dev,
>>>>> -                   "Xilinx Slave Serial FPGA Manager",
>>>>> -                   &xilinx_spi_ops, conf);
>>>>> -    if (!mgr)
>>>>> -        return -ENOMEM;
>>>>> +    mgr = devm_fpga_mgr_register(&spi->dev,
>>>>> +                     "Xilinx Slave Serial FPGA Manager",
>>>>> +                     NULL, &xilinx_spi_ops, conf);
>>>>> +    if (IS_ERR(mgr))
>>>>> +        return PTR_ERR(mgr);
>>>>>    -    return devm_fpga_mgr_register(&spi->dev, mgr);
>>>>> +    return 0;
>>>>>    }
>>>>>      static const struct of_device_id xlnx_spi_of_match[] = {
>>>>> diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
>>>>> index 07fa8d9ec675..74bbb9710f4e 100644
>>>>> --- a/drivers/fpga/zynq-fpga.c
>>>>> +++ b/drivers/fpga/zynq-fpga.c
>>>>> @@ -609,20 +609,16 @@ static int zynq_fpga_probe(struct platform_device *pdev)
>>>>>          clk_disable(priv->clk);
>>>>>    -    mgr = devm_fpga_mgr_create(dev, "Xilinx Zynq FPGA Manager",
>>>>> -                   &zynq_fpga_ops, priv);
>>>>> -    if (!mgr)
>>>>> -        return -ENOMEM;
>>>>> -
>>>>> -    platform_set_drvdata(pdev, mgr);
>>>>> -
>>>>> -    err = fpga_mgr_register(mgr);
>>>>> -    if (err) {
>>>>> +    mgr = fpga_mgr_register(dev, "Xilinx Zynq FPGA Manager",
>>>> This is missing compat_id param as well.
>>>>> +                &zynq_fpga_ops, priv);
>>>>> +    if (IS_ERR(mgr)) {
>>>>>            dev_err(dev, "unable to register FPGA manager\n");
>>>>>            clk_unprepare(priv->clk);
>>>>> -        return err;
>>>>> +        return PTR_ERR(mgr);
>>>>>        }
>>>>>    +    platform_set_drvdata(pdev, mgr);
>>>>> +
>>>>>        return 0;
>>>>>    }
>>>>>    diff --git a/drivers/fpga/zynqmp-fpga.c b/drivers/fpga/zynqmp-fpga.c
>>>>> index 125743c9797f..1a6d520985be 100644
>>>>> --- a/drivers/fpga/zynqmp-fpga.c
>>>>> +++ b/drivers/fpga/zynqmp-fpga.c
>>>>> @@ -102,12 +102,12 @@ static int zynqmp_fpga_probe(struct platform_device *pdev)
>>>>>          priv->dev = dev;
>>>>>    -    mgr = devm_fpga_mgr_create(dev, "Xilinx ZynqMP FPGA Manager",
>>>>> -                   &zynqmp_fpga_ops, priv);
>>>>> -    if (!mgr)
>>>>> -        return -ENOMEM;
>>>>> +    mgr = devm_fpga_mgr_register(dev, "Xilinx ZynqMP FPGA Manager",
>>>>> +                     &zynqmp_fpga_ops, priv);
>>>>> +    if (IS_ERR(mgr))
>>>>> +        return PTR_ERR(mgr);
>>>>>    -    return devm_fpga_mgr_register(dev, mgr);
>>>>> +    return 0;
>>>>>    }
>>>>>      static const struct of_device_id zynqmp_fpga_of_match[] = {
>>>>> diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
>>>>> index 2bc3030a69e5..3e1859cc0640 100644
>>>>> --- a/include/linux/fpga/fpga-mgr.h
>>>>> +++ b/include/linux/fpga/fpga-mgr.h
>>>>> @@ -191,17 +191,16 @@ struct fpga_manager *fpga_mgr_get(struct device *dev);
>>>>>      void fpga_mgr_put(struct fpga_manager *mgr);
>>>>>    -struct fpga_manager *fpga_mgr_create(struct device *dev, const char *name,
>>>>> -                     const struct fpga_manager_ops *mops,
>>>>> -                     void *priv);
>>>> My biggest concern is that removing this will break all oot fpga drivers.
>>>>
>>>> The other patches have similar api changes
>>>>
>>>> Having a stable api is very important.
>>> That is a good point. While Greg did call out the separation of the
>>> device_initialize() and device_add() calls, his biggest concern was with
>>> the empty dev_release() functions. Maybe it would be best to first submit
>>> a patch that only addresses the dev_release() functions? Maybe it would be
>>> OK to leave the create and register functions as separate functions in order
>>> to maintain a stable API...
>> On further investigation, I don't think we have much choice in changing
>> the API. We are almost coming full circle here. In 2018, there was only
>> an fpga_mgr_register() function. It was returning an errno value or zero.
>> It was also setting the drvdata of the parent driver with a pointer to
>> the resulting fpga_manager structure.
>>
>> It looks like the reason the interface was split into two (create and
>> register) was so that the fpga_manager pointer could be returned (by the
>> create function) without writing the drvdata of the parent driver:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7085e2a94f7df5f419e3cfb2fe809ce6564e9629
>>
>> When the interfaces were split, fpga_mgr_free() was also created to free
>> the memory if the register function was not called. The fpga_mgr_free()
>> function was also called by the fpga_mgr_dev_release() function. A later
>> patch was submitted to simplify the memory management for the class driver:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=084181fe8cc7472695b907f0018f4cd00934cb12
>>
>> It is this second commit that empties the fpga_mgr_dev_release() function
>> and instead uses devm_fpga_mgr_create() to manage the memory for the class
>> driver.
>>
>> The fix I am proposing essentially takes us back to the 2018 implementation,
>> but returns the fpga_manager pointer or ERR_PTR() instead of returning zero or
>> an errno.
>>
>> The definition of the API is integral to the memory management issue. I cannot
>> think of an acceptable solution for the upstream that doesn't involve
>> changing the API. It could result in some ifdef's in an out-of-tree driver,
>> but I don't think we can avoid it in this case.
>
> IMO, the important patch is the next patch for the update.
>
> It seems like this one is adding features and stepping on the api when it seems that only removing the empty release is needed.
>
> Can most of this one be deferred until after the update ?

As I understand it, removing the empty dev_release() function is not an option:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/base/core.c?id=084181fe8cc7472695b907f0018f4cd00934cb12#n890

The warning message makes it clear that the pointer must be populated. Providing an empty function just circumvents the warning. The purpose of this patch set is to populate the dev_release function properly, but that means removing the devm_* support that wants to manage the same memory. The whole memory management issue is greatly simplified by merging the create and register functions.

- Russ

>
> Tom
>
>>
>>> - Russ
>>>
>>>> My recommendation is to keep the public api and hide the change with an exported but not public function.
>>>>
>>>> Tom
>>>>
>>>>> -void fpga_mgr_free(struct fpga_manager *mgr);
>>>>> -int fpga_mgr_register(struct fpga_manager *mgr);
>>>>> +struct fpga_manager *fpga_mgr_register(struct device *dev, const char *name,
>>>>> +                       struct fpga_compat_id *compat_id,
>>>>> +                       const struct fpga_manager_ops *mops,
>>>>> +                       void *priv);
>>>>>    void fpga_mgr_unregister(struct fpga_manager *mgr);
>>>>>    -int devm_fpga_mgr_register(struct device *dev, struct fpga_manager *mgr);
>>>>> -
>>>>> -struct fpga_manager *devm_fpga_mgr_create(struct device *dev, const char *name,
>>>>> -                      const struct fpga_manager_ops *mops,
>>>>> -                      void *priv);
>>>>> +struct fpga_manager *
>>>>> +devm_fpga_mgr_register(struct device *dev, const char *name,
>>>>> +               struct fpga_compat_id *compat_id,
>>>>> +               const struct fpga_manager_ops *mops,
>>>>> +               void *priv);
>>>>>      #endif /*_LINUX_FPGA_MGR_H */
>


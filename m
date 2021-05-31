Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 797873957B8
	for <lists+linux-fpga@lfdr.de>; Mon, 31 May 2021 11:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbhEaJB5 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 31 May 2021 05:01:57 -0400
Received: from mga06.intel.com ([134.134.136.31]:63778 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231184AbhEaJBp (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 31 May 2021 05:01:45 -0400
IronPort-SDR: SlFWQUiK1lX9y1gk/FP2UCKXjuHR787hRgtzTvfATmOPus1HDDOvbRYs7J+WT6V1XraL6/1EKu
 AAGB9K7czh3w==
X-IronPort-AV: E=McAfee;i="6200,9189,10000"; a="264516019"
X-IronPort-AV: E=Sophos;i="5.83,236,1616482800"; 
   d="scan'208";a="264516019"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2021 02:00:02 -0700
IronPort-SDR: IgLjUcg7+0DbdBxnXQgc0pdSRyU40Jth8BjnKB8QIRyG64tS18Wyyz/VsW7wf6aVnKeE8TrJ92
 pJh7tA/j1lTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,236,1616482800"; 
   d="scan'208";a="549355314"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.162])
  by fmsmga001.fm.intel.com with ESMTP; 31 May 2021 01:59:56 -0700
Date:   Mon, 31 May 2021 16:54:26 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org, trix@redhat.com,
        lgoncalv@redhat.com, hao.wu@intel.com, matthew.gerlach@intel.com,
        richard.gong@intel.com
Subject: Re: [PATCH v4 1/3] fpga: mgr: Use standard dev_release for class
 driver
Message-ID: <20210531085426.GA1928186@yilunxu-OptiPlex-7050>
References: <20210528215755.839712-1-russell.h.weight@intel.com>
 <20210528215755.839712-2-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210528215755.839712-2-russell.h.weight@intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

A quick comment, may come back later. See inline:

On Fri, May 28, 2021 at 02:57:53PM -0700, Russ Weight wrote:
> The FPGA manager class driver data structure is being treated as a
> managed resource instead of using standard dev_release call-back
> to release the class data structure. This change removes the
> managed resource code for the freeing of the class data structure
> and combines the create() and register() functions into a single
> register() function.
> 
> The devm_fpga_mgr_register() function is retained.
> 
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> ---
> v4:
>   - Added the compat_id parameter to fpga_mgr_register() and
>     devm_fpga_mgr_register() to ensure that the compat_id is set before
>     the device_register() call.
> v3:
>   - Cleaned up comment header for fpga_mgr_register()
>   - Fix error return on ida_simple_get() failure
> v2:
>   - Restored devm_fpga_mgr_register() functionality, adapted for the combined
>     create/register functionality.
>   - All previous callers of devm_fpga_mgr_register() will continue to call
>     devm_fpga_mgr_register().
>   - replaced unnecessary ternary operators in return statements with standard
>     if conditions.
> ---
>  drivers/fpga/altera-cvp.c        |  12 +--
>  drivers/fpga/altera-pr-ip-core.c |   9 +-
>  drivers/fpga/altera-ps-spi.c     |  10 +-
>  drivers/fpga/dfl-fme-mgr.c       |  12 +--
>  drivers/fpga/fpga-mgr.c          | 168 +++++++++----------------------
>  drivers/fpga/ice40-spi.c         |  10 +-
>  drivers/fpga/machxo2-spi.c       |  10 +-
>  drivers/fpga/socfpga-a10.c       |  16 ++-
>  drivers/fpga/socfpga.c           |  10 +-
>  drivers/fpga/stratix10-soc.c     |  15 +--
>  drivers/fpga/ts73xx-fpga.c       |  10 +-
>  drivers/fpga/xilinx-spi.c        |  12 +--
>  drivers/fpga/zynq-fpga.c         |  16 ++-
>  drivers/fpga/zynqmp-fpga.c       |  10 +-
>  include/linux/fpga/fpga-mgr.h    |  19 ++--
>  15 files changed, 120 insertions(+), 219 deletions(-)
> 
> diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
> index 4e0edb60bfba..25eaa97ae7aa 100644
> --- a/drivers/fpga/altera-cvp.c
> +++ b/drivers/fpga/altera-cvp.c
> @@ -652,19 +652,15 @@ static int altera_cvp_probe(struct pci_dev *pdev,
>  	snprintf(conf->mgr_name, sizeof(conf->mgr_name), "%s @%s",
>  		 ALTERA_CVP_MGR_NAME, pci_name(pdev));
>  
> -	mgr = devm_fpga_mgr_create(&pdev->dev, conf->mgr_name,
> -				   &altera_cvp_ops, conf);
> -	if (!mgr) {
> -		ret = -ENOMEM;
> +	mgr = fpga_mgr_register(&pdev->dev, conf->mgr_name, NULL,
> +				&altera_cvp_ops, conf);
> +	if (IS_ERR(mgr)) {
> +		ret = PTR_ERR(mgr);
>  		goto err_unmap;
>  	}
>  
>  	pci_set_drvdata(pdev, mgr);
>  
> -	ret = fpga_mgr_register(mgr);
> -	if (ret)
> -		goto err_unmap;
> -
>  	return 0;
>  
>  err_unmap:
> diff --git a/drivers/fpga/altera-pr-ip-core.c b/drivers/fpga/altera-pr-ip-core.c
> index 5b130c4d9882..bfd4de1e7ac5 100644
> --- a/drivers/fpga/altera-pr-ip-core.c
> +++ b/drivers/fpga/altera-pr-ip-core.c
> @@ -191,11 +191,12 @@ int alt_pr_register(struct device *dev, void __iomem *reg_base)
>  		(val & ALT_PR_CSR_STATUS_MSK) >> ALT_PR_CSR_STATUS_SFT,
>  		(int)(val & ALT_PR_CSR_PR_START));
>  
> -	mgr = devm_fpga_mgr_create(dev, dev_name(dev), &alt_pr_ops, priv);
> -	if (!mgr)
> -		return -ENOMEM;
> +	mgr = devm_fpga_mgr_register(dev, dev_name(dev), NULL,
> +				     &alt_pr_ops, priv);
> +	if (IS_ERR(mgr))
> +		return PTR_ERR(mgr);
>  
> -	return devm_fpga_mgr_register(dev, mgr);
> +	return 0;
>  }
>  EXPORT_SYMBOL_GPL(alt_pr_register);
>  
> diff --git a/drivers/fpga/altera-ps-spi.c b/drivers/fpga/altera-ps-spi.c
> index 23bfd4d1ad0f..e6fc7208213c 100644
> --- a/drivers/fpga/altera-ps-spi.c
> +++ b/drivers/fpga/altera-ps-spi.c
> @@ -302,12 +302,12 @@ static int altera_ps_probe(struct spi_device *spi)
>  	snprintf(conf->mgr_name, sizeof(conf->mgr_name), "%s %s",
>  		 dev_driver_string(&spi->dev), dev_name(&spi->dev));
>  
> -	mgr = devm_fpga_mgr_create(&spi->dev, conf->mgr_name,
> -				   &altera_ps_ops, conf);
> -	if (!mgr)
> -		return -ENOMEM;
> +	mgr = devm_fpga_mgr_register(&spi->dev, conf->mgr_name, NULL,
> +				     &altera_ps_ops, conf);
> +	if (IS_ERR(mgr))
> +		return PTR_ERR(mgr);
>  
> -	return devm_fpga_mgr_register(&spi->dev, mgr);
> +	return 0;
>  }
>  
>  static const struct spi_device_id altera_ps_spi_ids[] = {
> diff --git a/drivers/fpga/dfl-fme-mgr.c b/drivers/fpga/dfl-fme-mgr.c
> index d5861d13b306..c9b98afa7d50 100644
> --- a/drivers/fpga/dfl-fme-mgr.c
> +++ b/drivers/fpga/dfl-fme-mgr.c
> @@ -308,14 +308,12 @@ static int fme_mgr_probe(struct platform_device *pdev)
>  
>  	fme_mgr_get_compat_id(priv->ioaddr, compat_id);
>  
> -	mgr = devm_fpga_mgr_create(dev, "DFL FME FPGA Manager",
> -				   &fme_mgr_ops, priv);
> -	if (!mgr)
> -		return -ENOMEM;
> -
> -	mgr->compat_id = compat_id;
> +	mgr = devm_fpga_mgr_register(dev, "DFL FME FPGA Manager", compat_id,
> +				     &fme_mgr_ops, priv);
> +	if (IS_ERR(mgr))
> +		return PTR_ERR(mgr);
>  
> -	return devm_fpga_mgr_register(dev, mgr);
> +	return 0;
>  }
>  
>  static struct platform_driver fme_mgr_driver = {
> diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
> index b85bc47c91a9..d6d64ce34417 100644
> --- a/drivers/fpga/fpga-mgr.c
> +++ b/drivers/fpga/fpga-mgr.c
> @@ -550,20 +550,22 @@ void fpga_mgr_unlock(struct fpga_manager *mgr)
>  EXPORT_SYMBOL_GPL(fpga_mgr_unlock);
>  
>  /**
> - * fpga_mgr_create - create and initialize a FPGA manager struct
> + * fpga_mgr_register - create and register a FPGA Manager device
>   * @dev:	fpga manager device from pdev
>   * @name:	fpga manager name
> + * @compat_id:	FPGA manager id for compatibility check.
>   * @mops:	pointer to structure of fpga manager ops
>   * @priv:	fpga manager private data
>   *
> - * The caller of this function is responsible for freeing the struct with
> - * fpga_mgr_free().  Using devm_fpga_mgr_create() instead is recommended.
> + * The caller of this function is responsible for calling fpga_mgr_unregister().
> + * Using devm_fpga_mgr_register instead is recommended.
>   *
> - * Return: pointer to struct fpga_manager or NULL
> + * Return: struct fpga_manager pointer on success, ERR_PTR() on error.
>   */
> -struct fpga_manager *fpga_mgr_create(struct device *dev, const char *name,
> -				     const struct fpga_manager_ops *mops,
> -				     void *priv)
> +struct fpga_manager *
> +fpga_mgr_register(struct device *dev, const char *name,
> +		  struct fpga_compat_id *compat_id,
> +		  const struct fpga_manager_ops *mops, void *priv)
>  {
>  	struct fpga_manager *mgr;
>  	int id, ret;
> @@ -572,29 +574,31 @@ struct fpga_manager *fpga_mgr_create(struct device *dev, const char *name,
>  	    !mops->write_init || (!mops->write && !mops->write_sg) ||
>  	    (mops->write && mops->write_sg)) {
>  		dev_err(dev, "Attempt to register without fpga_manager_ops\n");
> -		return NULL;
> +		return ERR_PTR(-EINVAL);
>  	}
>  
>  	if (!name || !strlen(name)) {
>  		dev_err(dev, "Attempt to register with no name!\n");
> -		return NULL;
> +		return ERR_PTR(-EINVAL);
>  	}
>  
>  	mgr = kzalloc(sizeof(*mgr), GFP_KERNEL);
>  	if (!mgr)
> -		return NULL;
> +		return ERR_PTR(-ENOMEM);
>  
>  	id = ida_simple_get(&fpga_mgr_ida, 0, 0, GFP_KERNEL);
> -	if (id < 0)
> +	if (id < 0) {
> +		ret = id;
>  		goto error_kfree;
> +	}
>  
>  	mutex_init(&mgr->ref_mutex);
>  
>  	mgr->name = name;
> +	mgr->compat_id = compat_id;
>  	mgr->mops = mops;
>  	mgr->priv = priv;
>  
> -	device_initialize(&mgr->dev);
>  	mgr->dev.class = fpga_mgr_class;
>  	mgr->dev.groups = mops->groups;
>  	mgr->dev.parent = dev;
> @@ -605,84 +609,6 @@ struct fpga_manager *fpga_mgr_create(struct device *dev, const char *name,
>  	if (ret)
>  		goto error_device;
>  
> -	return mgr;
> -
> -error_device:
> -	ida_simple_remove(&fpga_mgr_ida, id);
> -error_kfree:
> -	kfree(mgr);
> -
> -	return NULL;
> -}
> -EXPORT_SYMBOL_GPL(fpga_mgr_create);
> -
> -/**
> - * fpga_mgr_free - free a FPGA manager created with fpga_mgr_create()
> - * @mgr:	fpga manager struct
> - */
> -void fpga_mgr_free(struct fpga_manager *mgr)
> -{
> -	ida_simple_remove(&fpga_mgr_ida, mgr->dev.id);
> -	kfree(mgr);
> -}
> -EXPORT_SYMBOL_GPL(fpga_mgr_free);
> -
> -static void devm_fpga_mgr_release(struct device *dev, void *res)
> -{
> -	struct fpga_mgr_devres *dr = res;
> -
> -	fpga_mgr_free(dr->mgr);
> -}
> -
> -/**
> - * devm_fpga_mgr_create - create and initialize a managed FPGA manager struct
> - * @dev:	fpga manager device from pdev
> - * @name:	fpga manager name
> - * @mops:	pointer to structure of fpga manager ops
> - * @priv:	fpga manager private data
> - *
> - * This function is intended for use in a FPGA manager driver's probe function.
> - * After the manager driver creates the manager struct with
> - * devm_fpga_mgr_create(), it should register it with fpga_mgr_register().  The
> - * manager driver's remove function should call fpga_mgr_unregister().  The
> - * manager struct allocated with this function will be freed automatically on
> - * driver detach.  This includes the case of a probe function returning error
> - * before calling fpga_mgr_register(), the struct will still get cleaned up.
> - *
> - * Return: pointer to struct fpga_manager or NULL
> - */
> -struct fpga_manager *devm_fpga_mgr_create(struct device *dev, const char *name,
> -					  const struct fpga_manager_ops *mops,
> -					  void *priv)
> -{
> -	struct fpga_mgr_devres *dr;
> -
> -	dr = devres_alloc(devm_fpga_mgr_release, sizeof(*dr), GFP_KERNEL);
> -	if (!dr)
> -		return NULL;
> -
> -	dr->mgr = fpga_mgr_create(dev, name, mops, priv);
> -	if (!dr->mgr) {
> -		devres_free(dr);
> -		return NULL;
> -	}
> -
> -	devres_add(dev, dr);
> -
> -	return dr->mgr;
> -}
> -EXPORT_SYMBOL_GPL(devm_fpga_mgr_create);
> -
> -/**
> - * fpga_mgr_register - register a FPGA manager
> - * @mgr: fpga manager struct
> - *
> - * Return: 0 on success, negative error code otherwise.
> - */
> -int fpga_mgr_register(struct fpga_manager *mgr)
> -{
> -	int ret;
> -
>  	/*
>  	 * Initialize framework state by requesting low level driver read state
>  	 * from device.  FPGA may be in reset mode or may have been programmed
> @@ -690,18 +616,20 @@ int fpga_mgr_register(struct fpga_manager *mgr)
>  	 */
>  	mgr->state = mgr->mops->state(mgr);
>  
> -	ret = device_add(&mgr->dev);
> -	if (ret)
> -		goto error_device;
> -
> -	dev_info(&mgr->dev, "%s registered\n", mgr->name);
> +	ret = device_register(&mgr->dev);
> +	if (ret) {
> +		put_device(&mgr->dev);
> +		return ERR_PTR(ret);
> +	}
>  
> -	return 0;
> +	return mgr;
>  
>  error_device:
> -	ida_simple_remove(&fpga_mgr_ida, mgr->dev.id);
> +	ida_simple_remove(&fpga_mgr_ida, id);
> +error_kfree:
> +	kfree(mgr);
>  
> -	return ret;
> +	return ERR_PTR(ret);
>  }
>  EXPORT_SYMBOL_GPL(fpga_mgr_register);
>  
> @@ -726,14 +654,6 @@ void fpga_mgr_unregister(struct fpga_manager *mgr)
>  }
>  EXPORT_SYMBOL_GPL(fpga_mgr_unregister);
>  
> -static int fpga_mgr_devres_match(struct device *dev, void *res,
> -				 void *match_data)
> -{
> -	struct fpga_mgr_devres *dr = res;
> -
> -	return match_data == dr->mgr;
> -}
> -
>  static void devm_fpga_mgr_unregister(struct device *dev, void *res)
>  {
>  	struct fpga_mgr_devres *dr = res;
> @@ -743,44 +663,46 @@ static void devm_fpga_mgr_unregister(struct device *dev, void *res)
>  
>  /**
>   * devm_fpga_mgr_register - resource managed variant of fpga_mgr_register()
> - * @dev: managing device for this FPGA manager
> - * @mgr: fpga manager struct
> + * @dev:	fpga manager device from pdev
> + * @name:	fpga manager name
> + * @compat_id:	FPGA manager id for compatibility check.
> + * @mops:	pointer to structure of fpga manager ops
> + * @priv:	fpga manager private data
>   *
>   * This is the devres variant of fpga_mgr_register() for which the unregister
>   * function will be called automatically when the managing device is detached.
>   */
> -int devm_fpga_mgr_register(struct device *dev, struct fpga_manager *mgr)
> +struct fpga_manager *
> +devm_fpga_mgr_register(struct device *dev, const char *name,
> +		       struct fpga_compat_id *compat_id,
> +		       const struct fpga_manager_ops *mops, void *priv)
>  {
>  	struct fpga_mgr_devres *dr;
> -	int ret;
> -
> -	/*
> -	 * Make sure that the struct fpga_manager * that is passed in is
> -	 * managed itself.
> -	 */
> -	if (WARN_ON(!devres_find(dev, devm_fpga_mgr_release,
> -				 fpga_mgr_devres_match, mgr)))
> -		return -EINVAL;
> +	struct fpga_manager *mgr;
>  
>  	dr = devres_alloc(devm_fpga_mgr_unregister, sizeof(*dr), GFP_KERNEL);
>  	if (!dr)
> -		return -ENOMEM;
> +		return ERR_PTR(-ENOMEM);
>  
> -	ret = fpga_mgr_register(mgr);
> -	if (ret) {
> +	mgr = fpga_mgr_register(dev, name, compat_id, mops, priv);
> +	if (IS_ERR(mgr)) {
>  		devres_free(dr);
> -		return ret;
> +		return mgr;
>  	}
>  
>  	dr->mgr = mgr;
>  	devres_add(dev, dr);
>  
> -	return 0;
> +	return mgr;
>  }
>  EXPORT_SYMBOL_GPL(devm_fpga_mgr_register);
>  
>  static void fpga_mgr_dev_release(struct device *dev)
>  {
> +	struct fpga_manager *mgr = to_fpga_manager(dev);
> +
> +	ida_simple_remove(&fpga_mgr_ida, mgr->dev.id);
> +	kfree(mgr);
>  }
>  
>  static int __init fpga_mgr_class_init(void)
> diff --git a/drivers/fpga/ice40-spi.c b/drivers/fpga/ice40-spi.c
> index 69dec5af23c3..b1c7c0713e11 100644
> --- a/drivers/fpga/ice40-spi.c
> +++ b/drivers/fpga/ice40-spi.c
> @@ -178,12 +178,12 @@ static int ice40_fpga_probe(struct spi_device *spi)
>  		return ret;
>  	}
>  
> -	mgr = devm_fpga_mgr_create(dev, "Lattice iCE40 FPGA Manager",
> -				   &ice40_fpga_ops, priv);
> -	if (!mgr)
> -		return -ENOMEM;
> +	mgr = devm_fpga_mgr_register(dev, "Lattice iCE40 FPGA Manager",
> +				     NULL, &ice40_fpga_ops, priv);
> +	if (IS_ERR(mgr))
> +		return PTR_ERR(mgr);
>  
> -	return devm_fpga_mgr_register(dev, mgr);
> +	return 0;
>  }
>  
>  static const struct of_device_id ice40_fpga_of_match[] = {
> diff --git a/drivers/fpga/machxo2-spi.c b/drivers/fpga/machxo2-spi.c
> index 114a64d2b7a4..75cc6efaa1b6 100644
> --- a/drivers/fpga/machxo2-spi.c
> +++ b/drivers/fpga/machxo2-spi.c
> @@ -366,12 +366,12 @@ static int machxo2_spi_probe(struct spi_device *spi)
>  		return -EINVAL;
>  	}
>  
> -	mgr = devm_fpga_mgr_create(dev, "Lattice MachXO2 SPI FPGA Manager",
> -				   &machxo2_ops, spi);
> -	if (!mgr)
> -		return -ENOMEM;
> +	mgr = devm_fpga_mgr_register(dev, "Lattice MachXO2 SPI FPGA Manager",
> +				     NULL, &machxo2_ops, spi);
> +	if (IS_ERR(mgr))
> +		return PTR_ERR(mgr);
>  
> -	return devm_fpga_mgr_register(dev, mgr);
> +	return 0;
>  }
>  
>  static const struct of_device_id of_match[] = {
> diff --git a/drivers/fpga/socfpga-a10.c b/drivers/fpga/socfpga-a10.c
> index 573d88bdf730..80b8891fb302 100644
> --- a/drivers/fpga/socfpga-a10.c
> +++ b/drivers/fpga/socfpga-a10.c
> @@ -508,19 +508,15 @@ static int socfpga_a10_fpga_probe(struct platform_device *pdev)
>  		return -EBUSY;
>  	}
>  
> -	mgr = devm_fpga_mgr_create(dev, "SoCFPGA Arria10 FPGA Manager",
> -				   &socfpga_a10_fpga_mgr_ops, priv);
> -	if (!mgr)
> -		return -ENOMEM;
> -
> -	platform_set_drvdata(pdev, mgr);
> -
> -	ret = fpga_mgr_register(mgr);
> -	if (ret) {
> +	mgr = fpga_mgr_register(dev, "SoCFPGA Arria10 FPGA Manager",
> +				NULL, &socfpga_a10_fpga_mgr_ops, priv);
> +	if (IS_ERR(mgr)) {
>  		clk_disable_unprepare(priv->clk);
> -		return ret;
> +		return PTR_ERR(mgr);
>  	}
>  
> +	platform_set_drvdata(pdev, mgr);
> +
>  	return 0;
>  }
>  
> diff --git a/drivers/fpga/socfpga.c b/drivers/fpga/socfpga.c
> index 1f467173fc1f..06edfab8a496 100644
> --- a/drivers/fpga/socfpga.c
> +++ b/drivers/fpga/socfpga.c
> @@ -571,12 +571,12 @@ static int socfpga_fpga_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> -	mgr = devm_fpga_mgr_create(dev, "Altera SOCFPGA FPGA Manager",
> -				   &socfpga_fpga_ops, priv);
> -	if (!mgr)
> -		return -ENOMEM;
> +	mgr = devm_fpga_mgr_register(dev, "Altera SOCFPGA FPGA Manager",
> +				     NULL, &socfpga_fpga_ops, priv);
> +	if (IS_ERR(mgr))
> +		return PTR_ERR(mgr);
>  
> -	return devm_fpga_mgr_register(dev, mgr);
> +	return 0;
>  }
>  
>  #ifdef CONFIG_OF
> diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
> index 657a70c5fc99..434094c3ac69 100644
> --- a/drivers/fpga/stratix10-soc.c
> +++ b/drivers/fpga/stratix10-soc.c
> @@ -425,18 +425,11 @@ static int s10_probe(struct platform_device *pdev)
>  
>  	init_completion(&priv->status_return_completion);
>  
> -	mgr = fpga_mgr_create(dev, "Stratix10 SOC FPGA Manager",
> -			      &s10_ops, priv);
> -	if (!mgr) {
> -		dev_err(dev, "unable to create FPGA manager\n");
> -		ret = -ENOMEM;
> -		goto probe_err;
> -	}
> -
> -	ret = fpga_mgr_register(mgr);
> -	if (ret) {
> +	mgr = fpga_mgr_register(dev, "Stratix10 SOC FPGA Manager",
> +				NULL, &s10_ops, priv);
> +	if (IS_ERR(mgr)) {
>  		dev_err(dev, "unable to register FPGA manager\n");
> -		fpga_mgr_free(mgr);
> +		ret = PTR_ERR(mgr);
>  		goto probe_err;
>  	}
>  
> diff --git a/drivers/fpga/ts73xx-fpga.c b/drivers/fpga/ts73xx-fpga.c
> index 101f016c6ed8..5efbec2b9f9f 100644
> --- a/drivers/fpga/ts73xx-fpga.c
> +++ b/drivers/fpga/ts73xx-fpga.c
> @@ -122,12 +122,12 @@ static int ts73xx_fpga_probe(struct platform_device *pdev)
>  	if (IS_ERR(priv->io_base))
>  		return PTR_ERR(priv->io_base);
>  
> -	mgr = devm_fpga_mgr_create(kdev, "TS-73xx FPGA Manager",
> -				   &ts73xx_fpga_ops, priv);
> -	if (!mgr)
> -		return -ENOMEM;
> +	mgr = devm_fpga_mgr_register(kdev, "TS-73xx FPGA Manager",
> +				     &ts73xx_fpga_ops, priv);
> +	if (IS_ERR(mgr))
> +		return PTR_ERR(mgr);
>  
> -	return devm_fpga_mgr_register(kdev, mgr);
> +	return 0;
>  }
>  
>  static struct platform_driver ts73xx_fpga_driver = {
> diff --git a/drivers/fpga/xilinx-spi.c b/drivers/fpga/xilinx-spi.c
> index fee4d0abf6bf..6f1894929687 100644
> --- a/drivers/fpga/xilinx-spi.c
> +++ b/drivers/fpga/xilinx-spi.c
> @@ -247,13 +247,13 @@ static int xilinx_spi_probe(struct spi_device *spi)
>  		return dev_err_probe(&spi->dev, PTR_ERR(conf->done),
>  				     "Failed to get DONE gpio\n");
>  
> -	mgr = devm_fpga_mgr_create(&spi->dev,
> -				   "Xilinx Slave Serial FPGA Manager",
> -				   &xilinx_spi_ops, conf);
> -	if (!mgr)
> -		return -ENOMEM;
> +	mgr = devm_fpga_mgr_register(&spi->dev,
> +				     "Xilinx Slave Serial FPGA Manager",
> +				     NULL, &xilinx_spi_ops, conf);
> +	if (IS_ERR(mgr))
> +		return PTR_ERR(mgr);
>  
> -	return devm_fpga_mgr_register(&spi->dev, mgr);
> +	return 0;
>  }
>  
>  static const struct of_device_id xlnx_spi_of_match[] = {
> diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
> index 07fa8d9ec675..74bbb9710f4e 100644
> --- a/drivers/fpga/zynq-fpga.c
> +++ b/drivers/fpga/zynq-fpga.c
> @@ -609,20 +609,16 @@ static int zynq_fpga_probe(struct platform_device *pdev)
>  
>  	clk_disable(priv->clk);
>  
> -	mgr = devm_fpga_mgr_create(dev, "Xilinx Zynq FPGA Manager",
> -				   &zynq_fpga_ops, priv);
> -	if (!mgr)
> -		return -ENOMEM;
> -
> -	platform_set_drvdata(pdev, mgr);
> -
> -	err = fpga_mgr_register(mgr);
> -	if (err) {
> +	mgr = fpga_mgr_register(dev, "Xilinx Zynq FPGA Manager",
> +				&zynq_fpga_ops, priv);
> +	if (IS_ERR(mgr)) {
>  		dev_err(dev, "unable to register FPGA manager\n");
>  		clk_unprepare(priv->clk);
> -		return err;
> +		return PTR_ERR(mgr);
>  	}
>  
> +	platform_set_drvdata(pdev, mgr);
> +
>  	return 0;
>  }
>  
> diff --git a/drivers/fpga/zynqmp-fpga.c b/drivers/fpga/zynqmp-fpga.c
> index 125743c9797f..1a6d520985be 100644
> --- a/drivers/fpga/zynqmp-fpga.c
> +++ b/drivers/fpga/zynqmp-fpga.c
> @@ -102,12 +102,12 @@ static int zynqmp_fpga_probe(struct platform_device *pdev)
>  
>  	priv->dev = dev;
>  
> -	mgr = devm_fpga_mgr_create(dev, "Xilinx ZynqMP FPGA Manager",
> -				   &zynqmp_fpga_ops, priv);
> -	if (!mgr)
> -		return -ENOMEM;
> +	mgr = devm_fpga_mgr_register(dev, "Xilinx ZynqMP FPGA Manager",
> +				     &zynqmp_fpga_ops, priv);
> +	if (IS_ERR(mgr))
> +		return PTR_ERR(mgr);
>  
> -	return devm_fpga_mgr_register(dev, mgr);
> +	return 0;
>  }
>  
>  static const struct of_device_id zynqmp_fpga_of_match[] = {
> diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
> index 2bc3030a69e5..3e1859cc0640 100644
> --- a/include/linux/fpga/fpga-mgr.h
> +++ b/include/linux/fpga/fpga-mgr.h
> @@ -191,17 +191,16 @@ struct fpga_manager *fpga_mgr_get(struct device *dev);
>  
>  void fpga_mgr_put(struct fpga_manager *mgr);
>  
> -struct fpga_manager *fpga_mgr_create(struct device *dev, const char *name,
> -				     const struct fpga_manager_ops *mops,
> -				     void *priv);
> -void fpga_mgr_free(struct fpga_manager *mgr);
> -int fpga_mgr_register(struct fpga_manager *mgr);
> +struct fpga_manager *fpga_mgr_register(struct device *dev, const char *name,
> +				       struct fpga_compat_id *compat_id,
> +				       const struct fpga_manager_ops *mops,
> +				       void *priv);
>  void fpga_mgr_unregister(struct fpga_manager *mgr);
>  
> -int devm_fpga_mgr_register(struct device *dev, struct fpga_manager *mgr);
> -
> -struct fpga_manager *devm_fpga_mgr_create(struct device *dev, const char *name,
> -					  const struct fpga_manager_ops *mops,
> -					  void *priv);
> +struct fpga_manager *
> +devm_fpga_mgr_register(struct device *dev, const char *name,
> +		       struct fpga_compat_id *compat_id,

Could we integrate the compat_id in fpga_manager_ops? Actually not much
driver cares about the compat_id.
In this way we don't force everyone fill a NULL on registration.

Expecting more opinions.

Thanks,
Yilun

> +		       const struct fpga_manager_ops *mops,
> +		       void *priv);
>  
>  #endif /*_LINUX_FPGA_MGR_H */
> -- 
> 2.25.1

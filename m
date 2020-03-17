Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAD46187BF4
	for <lists+linux-fpga@lfdr.de>; Tue, 17 Mar 2020 10:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725962AbgCQJVv (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 17 Mar 2020 05:21:51 -0400
Received: from mga06.intel.com ([134.134.136.31]:19241 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725957AbgCQJVv (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 17 Mar 2020 05:21:51 -0400
IronPort-SDR: EJw8uvmiDaNSHMcUnyxTGN0hAP1s4Vzb8ZIODsyW6Md+r8ktr5PkP9Cd2O29hRMp5H1cObVePt
 2qrIuH8MvFow==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2020 02:21:50 -0700
IronPort-SDR: SoePouZA6FtgayFSkqZnmj/hhoNwuBDqQDSYAwuJSYDckD7VNLWsEULM9lANX54yFhuwLV+cEt
 1VBWy/DIggAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,563,1574150400"; 
   d="scan'208";a="244421050"
Received: from hao-dev.bj.intel.com (HELO localhost) ([10.238.157.65])
  by orsmga003.jf.intel.com with ESMTP; 17 Mar 2020 02:21:47 -0700
Date:   Tue, 17 Mar 2020 17:00:44 +0800
From:   Wu Hao <hao.wu@intel.com>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luwei Kang <luwei.kang@intel.com>
Subject: Re: [PATCH v2 1/7] fpga: dfl: parse interrupt info for feature
 devices on enumeration
Message-ID: <20200317090044.GA15301@hao-dev>
References: <1584332222-26652-1-git-send-email-yilun.xu@intel.com>
 <1584332222-26652-2-git-send-email-yilun.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584332222-26652-2-git-send-email-yilun.xu@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Yilun

Some comments inline.

On Mon, Mar 16, 2020 at 12:16:56PM +0800, Xu Yilun wrote:
> DFL based FPGA devices could support interrupts for different purposes,
> but current DFL framework only supports feature device enumeration with
> given MMIO resources information via common DFL headers. This patch
> introduces one new API dfl_fpga_enum_info_add_irq for low level bus
> drivers (e.g. PCIe device driver) to pass its interrupt resources
> information to DFL framework for enumeration, and also adds interrupt
> enumeration code in framework to parse and assign interrupt resources
> for enumerated feature devices and their own sub features.
> 
> With this patch, DFL framework enumerates interrupt resources for core
> features, including PORT Error Reporting, FME (FPGA Management Engine)
> Error Reporting and also AFU User Interrupts.
> 
> Signed-off-by: Luwei Kang <luwei.kang@intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> ----
> v2: early validating irq table for each feature in parse_feature_irq().
>     Some code improvement and minor fix for Hao's comments.
> ---
>  drivers/fpga/dfl.c | 152 +++++++++++++++++++++++++++++++++++++++++++++++++++--
>  drivers/fpga/dfl.h |  40 ++++++++++++++
>  2 files changed, 188 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> index 9909948..28e2cd8 100644
> --- a/drivers/fpga/dfl.c
> +++ b/drivers/fpga/dfl.c
> @@ -11,6 +11,7 @@
>   *   Xiao Guangrong <guangrong.xiao@linux.intel.com>
>   */
>  #include <linux/module.h>
> +#include <asm/irq.h>
>  
>  #include "dfl.h"
>  
> @@ -421,6 +422,9 @@ EXPORT_SYMBOL_GPL(dfl_fpga_dev_ops_unregister);
>   *
>   * @dev: device to enumerate.
>   * @cdev: the container device for all feature devices.
> + * @nr_irqs: number of irqs for all feature devices.
> + * @irq_table: Linux IRQ numbers for all irqs, indexed by local irq index of
> + *	       this device.
>   * @feature_dev: current feature device.
>   * @ioaddr: header register region address of feature device in enumeration.
>   * @sub_features: a sub features linked list for feature device in enumeration.
> @@ -429,6 +433,9 @@ EXPORT_SYMBOL_GPL(dfl_fpga_dev_ops_unregister);
>  struct build_feature_devs_info {
>  	struct device *dev;
>  	struct dfl_fpga_cdev *cdev;
> +	unsigned int nr_irqs;
> +	int *irq_table;
> +
>  	struct platform_device *feature_dev;
>  	void __iomem *ioaddr;
>  	struct list_head sub_features;
> @@ -442,12 +449,16 @@ struct build_feature_devs_info {
>   * @mmio_res: mmio resource of this sub feature.
>   * @ioaddr: mapped base address of mmio resource.
>   * @node: node in sub_features linked list.
> + * @irq_base: start of irq index in this sub feature.
> + * @nr_irqs: number of irqs of this sub feature.
>   */
>  struct dfl_feature_info {
>  	u64 fid;
>  	struct resource mmio_res;
>  	void __iomem *ioaddr;
>  	struct list_head node;
> +	unsigned int irq_base;
> +	unsigned int nr_irqs;
>  };
>  
>  static void dfl_fpga_cdev_add_port_dev(struct dfl_fpga_cdev *cdev,
> @@ -520,6 +531,8 @@ static int build_info_commit_dev(struct build_feature_devs_info *binfo)
>  	/* fill features and resource information for feature dev */
>  	list_for_each_entry_safe(finfo, p, &binfo->sub_features, node) {
>  		struct dfl_feature *feature = &pdata->features[index];
> +		struct dfl_feature_irq_ctx *ctx;
> +		int i;

should be unsigned int?

>  
>  		/* save resource information for each feature */
>  		feature->id = finfo->fid;
> @@ -527,6 +540,20 @@ static int build_info_commit_dev(struct build_feature_devs_info *binfo)
>  		feature->ioaddr = finfo->ioaddr;
>  		fdev->resource[index++] = finfo->mmio_res;
>  
> +		if (finfo->nr_irqs) {
> +			ctx = devm_kcalloc(binfo->dev, finfo->nr_irqs,
> +					   sizeof(*ctx), GFP_KERNEL);
> +			if (!ctx)
> +				return -ENOMEM;
> +
> +			for (i = 0; i < finfo->nr_irqs; i++)
> +				ctx[i].irq =
> +					binfo->irq_table[finfo->irq_base + i];
> +
> +			feature->irq_ctx = ctx;
> +			feature->nr_irqs = finfo->nr_irqs;
> +		}
> +
>  		list_del(&finfo->node);
>  		kfree(finfo);
>  	}
> @@ -648,7 +675,8 @@ static u64 feature_id(void __iomem *start)
>  static int
>  create_feature_instance(struct build_feature_devs_info *binfo,
>  			struct dfl_fpga_enum_dfl *dfl, resource_size_t ofst,
> -			resource_size_t size, u64 fid)
> +			resource_size_t size, u64 fid, unsigned int irq_base,
> +			unsigned int nr_irqs)
>  {
>  	struct dfl_feature_info *finfo;
>  
> @@ -667,6 +695,8 @@ create_feature_instance(struct build_feature_devs_info *binfo,
>  	finfo->mmio_res.start = dfl->start + ofst;
>  	finfo->mmio_res.end = finfo->mmio_res.start + size - 1;
>  	finfo->mmio_res.flags = IORESOURCE_MEM;
> +	finfo->irq_base = irq_base;
> +	finfo->nr_irqs = nr_irqs;
>  	finfo->ioaddr = dfl->ioaddr + ofst;
>  
>  	list_add_tail(&finfo->node, &binfo->sub_features);
> @@ -684,7 +714,8 @@ static int parse_feature_port_afu(struct build_feature_devs_info *binfo,
>  
>  	WARN_ON(!size);
>  
> -	return create_feature_instance(binfo, dfl, ofst, size, FEATURE_ID_AFU);
> +	return create_feature_instance(binfo, dfl, ofst, size, FEATURE_ID_AFU,
> +				       0, 0);
>  }
>  
>  static int parse_feature_afu(struct build_feature_devs_info *binfo,
> @@ -724,7 +755,7 @@ static int parse_feature_fiu(struct build_feature_devs_info *binfo,
>  	if (ret)
>  		return ret;
>  
> -	ret = create_feature_instance(binfo, dfl, ofst, 0, 0);
> +	ret = create_feature_instance(binfo, dfl, ofst, 0, 0, 0, 0);
>  	if (ret)
>  		return ret;
>  	/*
> @@ -742,17 +773,86 @@ static int parse_feature_fiu(struct build_feature_devs_info *binfo,
>  	return ret;
>  }
>  
> +static void parse_feature_irqs(struct build_feature_devs_info *binfo,
> +			       struct dfl_fpga_enum_dfl *dfl,
> +			       resource_size_t ofst,
> +			       unsigned int *irq_base, unsigned int *nr_irqs)
> +{
> +	unsigned int i;
> +	u64 id, v;
> +	int virq;
> +
> +	/*
> +	 * Ideally DFL framework should only read info from DFL header, but
> +	 * current version DFL only provides mmio resources information for
> +	 * each feature in DFL Header, no field for interrupt resources.
> +	 * Some interrupt resources information are provided by specific
> +	 * mmio registers of each components(e.g. different private features)
> +	 * which supports interrupt. So in order to parse and assign irq
> +	 * resources to different components, DFL framework has to look into
> +	 * specific capability registers of these core private features.
> +	 *
> +	 * Once future DFL version supports generic interrupt resources
> +	 * information in common DFL headers, some generic interrupt parsing
> +	 * code could be added. But in order to be compatible to old version
> +	 * DFL, driver may still fall back to these quirks.
> +	 */
> +
> +	id = feature_id((dfl->ioaddr + ofst));
> +
> +	if (id == PORT_FEATURE_ID_UINT) {
> +		v = readq(dfl->ioaddr + ofst + PORT_UINT_CAP);
> +		*irq_base = FIELD_GET(PORT_UINT_CAP_FST_VECT, v);
> +		*nr_irqs = FIELD_GET(PORT_UINT_CAP_INT_NUM, v);
> +	} else if (id == PORT_FEATURE_ID_ERROR) {
> +		v = readq(dfl->ioaddr + ofst + PORT_ERROR_CAP);
> +		*irq_base = FIELD_GET(PORT_ERROR_CAP_INT_VECT, v);
> +		*nr_irqs = FIELD_GET(PORT_ERROR_CAP_SUPP_INT, v);
> +	} else if (id == FME_FEATURE_ID_GLOBAL_ERR) {
> +		v = readq(dfl->ioaddr + ofst + FME_ERROR_CAP);
> +		*irq_base = FIELD_GET(FME_ERROR_CAP_INT_VECT, v);
> +		*nr_irqs = FIELD_GET(FME_ERROR_CAP_SUPP_INT, v);
> +	} else {
> +		return;
> +	}

As you know, most features don't support interrupts, but all of them have to
go through this whole block, do you think if switch is better in this case?

> +
> +	dev_dbg(binfo->dev, "feature: 0x%llx, nr_irqs: %u, irq_base: %u\n",
> +		(unsigned long long)id, *nr_irqs, *irq_base);
> +
> +	if (*irq_base + *nr_irqs > binfo->nr_irqs)
> +		goto parse_irq_fail;
> +
> +	for (i = 0; i < *nr_irqs; i++) {
> +		virq = binfo->irq_table[*irq_base + i];
> +		if (virq < 0 || virq > NR_IRQS)
> +			goto parse_irq_fail;
> +	}
> +
> +	return;
> +
> +parse_irq_fail:
> +	*irq_base = 0;
> +	*nr_irqs = 0;

Please add some comments, if parsing failed, then still try to support features
without inerrupts capability.

> +	dev_warn(binfo->dev, "Invalid interrupt number in feature 0x%llx\n",
> +		 (unsigned long long)id);


I am thinking if it's possibe to put this interrupt parsing code into
create_feature_instance, as mmio parsing code for the private feature is
actually inside the create_feature_instance. If we do it this way, we
don't need to introduce more parameters to create_feature_instance function.

How do you think?


> +}
> +
>  static int parse_feature_private(struct build_feature_devs_info *binfo,
>  				 struct dfl_fpga_enum_dfl *dfl,
>  				 resource_size_t ofst)
>  {
> +	unsigned int irq_base = 0, nr_irqs = 0;
> +
>  	if (!binfo->feature_dev) {
>  		dev_err(binfo->dev, "the private feature %llx does not belong to any AFU.\n",
>  			(unsigned long long)feature_id(dfl->ioaddr + ofst));
>  		return -EINVAL;
>  	}
>  
> -	return create_feature_instance(binfo, dfl, ofst, 0, 0);
> +	parse_feature_irqs(binfo, dfl, ofst, &irq_base, &nr_irqs);
> +
> +	return create_feature_instance(binfo, dfl, ofst, 0, 0, irq_base,
> +				       nr_irqs);
>  }
>  
>  /**
> @@ -853,6 +953,10 @@ void dfl_fpga_enum_info_free(struct dfl_fpga_enum_info *info)
>  		devm_kfree(dev, dfl);
>  	}
>  
> +	/* remove irq table */
> +	if (info->irq_table)
> +		devm_kfree(dev, info->irq_table);
> +
>  	devm_kfree(dev, info);
>  	put_device(dev);
>  }
> @@ -892,6 +996,42 @@ int dfl_fpga_enum_info_add_dfl(struct dfl_fpga_enum_info *info,
>  }
>  EXPORT_SYMBOL_GPL(dfl_fpga_enum_info_add_dfl);
>  
> +/**
> + * dfl_fpga_enum_info_add_irq - add irq table to enum info
> + *
> + * @info: ptr to dfl_fpga_enum_info
> + * @nr_irqs: number of irqs of the DFL fpga device to be enumerated.
> + * @irq_table: Linux IRQ numbers for all irqs, indexed by local irq index of
> + *	       this device.
> + *
> + * One FPGA device may have several interrupts. This function adds irq
> + * information of the DFL fpga device to enum info for next step enumeration.
> + * This function should be called before dfl_fpga_feature_devs_enumerate().
> + * Adding multiply irq tables is not supported so it will fail on a second
> + * call.

Actually in current dfl implementation, it allows low layer bus driver to hand
multiple dfls to dfl framework using one enum_info. So that means we expected
that only one interrupt table shared by all dfls in the same enum_info. If dfls
can't share the irq table, or logically they are used to represent different
fpga devices tree, they need to fill more enum_info. I guess we should add more
descriptions to tell users these limitations.

Hao

> + *
> + * Return: 0 on success, negative error code otherwise.
> + */
> +int dfl_fpga_enum_info_add_irq(struct dfl_fpga_enum_info *info,
> +			       unsigned int nr_irqs, int *irq_table)
> +{
> +	if (!nr_irqs)
> +		return -EINVAL;
> +
> +	if (info->irq_table)
> +		return -EEXIST;
> +
> +	info->irq_table = devm_kmemdup(info->dev, irq_table,
> +				       sizeof(int) * nr_irqs, GFP_KERNEL);
> +	if (!info->irq_table)
> +		return -ENOMEM;
> +
> +	info->nr_irqs = nr_irqs;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(dfl_fpga_enum_info_add_irq);
> +
>  static int remove_feature_dev(struct device *dev, void *data)
>  {
>  	struct platform_device *pdev = to_platform_device(dev);
> @@ -959,6 +1099,10 @@ dfl_fpga_feature_devs_enumerate(struct dfl_fpga_enum_info *info)
>  	binfo->dev = info->dev;
>  	binfo->cdev = cdev;
>  
> +	binfo->nr_irqs = info->nr_irqs;
> +	if (info->nr_irqs)
> +		binfo->irq_table = info->irq_table;
> +
>  	/*
>  	 * start enumeration for all feature devices based on Device Feature
>  	 * Lists.
> diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
> index 4a9a33c..6a498cd 100644
> --- a/drivers/fpga/dfl.h
> +++ b/drivers/fpga/dfl.h
> @@ -112,6 +112,13 @@
>  #define FME_PORT_OFST_ACC_VF	1
>  #define FME_PORT_OFST_IMP	BIT_ULL(60)
>  
> +/* FME Error Capability Register */
> +#define FME_ERROR_CAP		0x70
> +
> +/* FME Error Capability Register Bitfield */
> +#define FME_ERROR_CAP_SUPP_INT	BIT_ULL(0)		/* Interrupt Support */
> +#define FME_ERROR_CAP_INT_VECT	GENMASK_ULL(12, 1)	/* Interrupt vector */
> +
>  /* PORT Header Register Set */
>  #define PORT_HDR_DFH		DFH
>  #define PORT_HDR_GUID_L		GUID_L
> @@ -145,6 +152,20 @@
>  #define PORT_STS_PWR_STATE_AP2	2			/* 90% throttling */
>  #define PORT_STS_PWR_STATE_AP6	6			/* 100% throttling */
>  
> +/* Port Error Capability Register */
> +#define PORT_ERROR_CAP		0x38
> +
> +/* Port Error Capability Register Bitfield */
> +#define PORT_ERROR_CAP_SUPP_INT	BIT_ULL(0)		/* Interrupt Support */
> +#define PORT_ERROR_CAP_INT_VECT	GENMASK_ULL(12, 1)	/* Interrupt vector */
> +
> +/* Port Uint Capability Register */
> +#define PORT_UINT_CAP		0x8
> +
> +/* Port Uint Capability Register Bitfield */
> +#define PORT_UINT_CAP_INT_NUM	GENMASK_ULL(11, 0)	/* Interrupts num */
> +#define PORT_UINT_CAP_FST_VECT	GENMASK_ULL(23, 12)	/* First Vector */
> +
>  /**
>   * struct dfl_fpga_port_ops - port ops
>   *
> @@ -189,6 +210,15 @@ struct dfl_feature_driver {
>  };
>  
>  /**
> + * struct dfl_feature_irq_ctx - dfl private feature interrupt context
> + *
> + * @irq: Linux IRQ number of this interrupt.
> + */
> +struct dfl_feature_irq_ctx {
> +	int irq;
> +};
> +
> +/**
>   * struct dfl_feature - sub feature of the feature devices
>   *
>   * @id: sub feature id.
> @@ -196,12 +226,16 @@ struct dfl_feature_driver {
>   *		    this index is used to find its mmio resource from the
>   *		    feature dev (platform device)'s reources.
>   * @ioaddr: mapped mmio resource address.
> + * @irq_ctx: interrupt context list.
> + * @nr_irqs: number of interrupt contexts.
>   * @ops: ops of this sub feature.
>   */
>  struct dfl_feature {
>  	u64 id;
>  	int resource_index;
>  	void __iomem *ioaddr;
> +	struct dfl_feature_irq_ctx *irq_ctx;
> +	unsigned int nr_irqs;
>  	const struct dfl_feature_ops *ops;
>  };
>  
> @@ -388,10 +422,14 @@ static inline u8 dfl_feature_revision(void __iomem *base)
>   *
>   * @dev: parent device.
>   * @dfls: list of device feature lists.
> + * @nr_irqs: number of irqs for all feature devices.
> + * @irq_table: Linux IRQ numbers for all irqs, indexed by hw irq numbers.
>   */
>  struct dfl_fpga_enum_info {
>  	struct device *dev;
>  	struct list_head dfls;
> +	unsigned int nr_irqs;
> +	int *irq_table;
>  };
>  
>  /**
> @@ -415,6 +453,8 @@ struct dfl_fpga_enum_info *dfl_fpga_enum_info_alloc(struct device *dev);
>  int dfl_fpga_enum_info_add_dfl(struct dfl_fpga_enum_info *info,
>  			       resource_size_t start, resource_size_t len,
>  			       void __iomem *ioaddr);
> +int dfl_fpga_enum_info_add_irq(struct dfl_fpga_enum_info *info,
> +			       unsigned int nr_irqs, int *irq_table);
>  void dfl_fpga_enum_info_free(struct dfl_fpga_enum_info *info);
>  
>  /**
> -- 
> 2.7.4

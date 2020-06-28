Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7406720C9F5
	for <lists+linux-fpga@lfdr.de>; Sun, 28 Jun 2020 21:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgF1TrJ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 28 Jun 2020 15:47:09 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:45007 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbgF1TrJ (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 28 Jun 2020 15:47:09 -0400
Received: by mail-il1-f193.google.com with SMTP id w73so858115ila.11;
        Sun, 28 Jun 2020 12:47:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xaQUN8d5Iee1cV07RJcjx2G+tw1YUTqHYlYTqv0UcoU=;
        b=ATFqgmVUdlL0IoINSZVPRnv37XKIEPeqwLZ2N3M4Yi6DxRIvKMa2QfarGzfTBiL12C
         ag/I6D882NiHyQyfJgCk+k0rgxmyqlOiLfnPF8cFzK7Wq6rr/1veesUyypWeTURLhVsl
         iKUW/uMstmcx+PicauImV0LsN4WaWPAXaKXGvK41XbKuKK/X8go2oGeP4C/6Hz0KBkU/
         z0/YNWqbIp8bQxhui4FJonGc1/x/JA/tHowMm7jXFor/06pUHrwV0vdQhuhPuaWU8HLl
         wfVoIB33LK3nnWGjV4AMXNi7XuUvMjjp5XNRfus8r7p/XIHCW/sPcTqaLvLfQpUzR7Nr
         AbgQ==
X-Gm-Message-State: AOAM532UZ9i4OnnGtIZB7tOhmKlGZG+YvRl1WjQgFj1k4TtJY1nlfWXL
        oywhKw5CY6ngVJMPl9rLByc=
X-Google-Smtp-Source: ABdhPJxhEKueMOTuIuTo5ohRoAcG07+4Rt+pnL6LvElf34/QF0+U054I2sKagjDIJa5k91xq0sDXlw==
X-Received: by 2002:a92:8b90:: with SMTP id i138mr13665218ild.286.1593373627061;
        Sun, 28 Jun 2020 12:47:07 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id c25sm13121606ioi.13.2020.06.28.12.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2020 12:47:06 -0700 (PDT)
Date:   Sun, 28 Jun 2020 12:47:05 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, trix@redhat.com, bhu@redhat.com,
        mtosatti@redhat.com, gregkh@linuxfoundation.org,
        Luwei Kang <luwei.kang@intel.com>, Wu Hao <hao.wu@intel.com>
Subject: Re: [PATCH v7 1/7] fpga: dfl: parse interrupt info for feature
 devices on enumeration
Message-ID: <20200628194705.GA2469@epycbox.lan>
References: <1592280528-6350-1-git-send-email-yilun.xu@intel.com>
 <1592280528-6350-2-git-send-email-yilun.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592280528-6350-2-git-send-email-yilun.xu@intel.com>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Jun 16, 2020 at 12:08:42PM +0800, Xu Yilun wrote:
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
> Reviewed-by: Marcelo Tosatti <mtosatti@redhat.com>
> Acked-by: Wu Hao <hao.wu@intel.com>
> ---
> v2: early validating irq table for each feature in parse_feature_irq().
>     Some code improvement and minor fix for Hao's comments.
> v3: put parse_feature_irqs() inside create_feature_instance()
>     some minor fixes and more comments
> v4: no need to include asm/irq.h.
>     fail the dfl enumeration when irq parsing error happens.
> v5: Some minor fix for Hao's comments
> v6: Remove unnecessary type casting.
>     Some comment fix for Moritz's comments.
> v7: Add the header file <linux/interrupt.h>, to fix build error on
>     ARCH=xtensa
> ---
>  drivers/fpga/dfl.c | 153 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/fpga/dfl.h |  41 ++++++++++++++
>  2 files changed, 194 insertions(+)
> 
> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> index 9909948..02c1ec4 100644
> --- a/drivers/fpga/dfl.c
> +++ b/drivers/fpga/dfl.c
> @@ -421,6 +421,9 @@ EXPORT_SYMBOL_GPL(dfl_fpga_dev_ops_unregister);
>   *
>   * @dev: device to enumerate.
>   * @cdev: the container device for all feature devices.
> + * @nr_irqs: number of irqs for all feature devices.
> + * @irq_table: Linux IRQ numbers for all irqs, indexed by local irq index of
> + *	       this device.
>   * @feature_dev: current feature device.
>   * @ioaddr: header register region address of feature device in enumeration.
>   * @sub_features: a sub features linked list for feature device in enumeration.
> @@ -429,6 +432,9 @@ EXPORT_SYMBOL_GPL(dfl_fpga_dev_ops_unregister);
>  struct build_feature_devs_info {
>  	struct device *dev;
>  	struct dfl_fpga_cdev *cdev;
> +	unsigned int nr_irqs;
> +	int *irq_table;
> +
>  	struct platform_device *feature_dev;
>  	void __iomem *ioaddr;
>  	struct list_head sub_features;
> @@ -442,12 +448,16 @@ struct build_feature_devs_info {
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
> @@ -520,6 +530,8 @@ static int build_info_commit_dev(struct build_feature_devs_info *binfo)
>  	/* fill features and resource information for feature dev */
>  	list_for_each_entry_safe(finfo, p, &binfo->sub_features, node) {
>  		struct dfl_feature *feature = &pdata->features[index];
> +		struct dfl_feature_irq_ctx *ctx;
> +		unsigned int i;
>  
>  		/* save resource information for each feature */
>  		feature->id = finfo->fid;
> @@ -527,6 +539,20 @@ static int build_info_commit_dev(struct build_feature_devs_info *binfo)
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
> @@ -638,6 +664,78 @@ static u64 feature_id(void __iomem *start)
>  	return 0;
>  }
>  
> +static int parse_feature_irqs(struct build_feature_devs_info *binfo,
> +			      resource_size_t ofst, u64 fid,
> +			      unsigned int *irq_base, unsigned int *nr_irqs)
> +{
> +	void __iomem *base = binfo->ioaddr + ofst;
> +	unsigned int i, ibase, inr = 0;
> +	int virq;
> +	u64 v;
> +
> +	/*
> +	 * Ideally DFL framework should only read info from DFL header, but
> +	 * current version DFL only provides mmio resources information for
> +	 * each feature in DFL Header, no field for interrupt resources.
> +	 * Interrupt resource information is provided by specific mmio
> +	 * registers of each private feature which supports interrupt. So in
> +	 * order to parse and assign irq resources, DFL framework has to look
> +	 * into specific capability registers of these private features.
> +	 *
> +	 * Once future DFL version supports generic interrupt resource
> +	 * information in common DFL headers, the generic interrupt parsing
> +	 * code will be added. But in order to be compatible to old version
> +	 * DFL, the driver may still fall back to these quirks.
> +	 */
> +	switch (fid) {
> +	case PORT_FEATURE_ID_UINT:
> +		v = readq(base + PORT_UINT_CAP);
> +		ibase = FIELD_GET(PORT_UINT_CAP_FST_VECT, v);
> +		inr = FIELD_GET(PORT_UINT_CAP_INT_NUM, v);
> +		break;
> +	case PORT_FEATURE_ID_ERROR:
> +		v = readq(base + PORT_ERROR_CAP);
> +		ibase = FIELD_GET(PORT_ERROR_CAP_INT_VECT, v);
> +		inr = FIELD_GET(PORT_ERROR_CAP_SUPP_INT, v);
> +		break;
> +	case FME_FEATURE_ID_GLOBAL_ERR:
> +		v = readq(base + FME_ERROR_CAP);
> +		ibase = FIELD_GET(FME_ERROR_CAP_INT_VECT, v);
> +		inr = FIELD_GET(FME_ERROR_CAP_SUPP_INT, v);
> +		break;
> +	}
> +
> +	if (!inr) {
> +		*irq_base = 0;
> +		*nr_irqs = 0;
> +		return 0;
> +	}
> +
> +	dev_dbg(binfo->dev, "feature: 0x%llx, irq_base: %u, nr_irqs: %u\n",
> +		fid, ibase, inr);
> +
> +	if (ibase + inr > binfo->nr_irqs) {
> +		dev_err(binfo->dev,
> +			"Invalid interrupt number in feature 0x%llx\n", fid);
> +		return -EINVAL;
> +	}
> +
> +	for (i = 0; i < inr; i++) {
> +		virq = binfo->irq_table[ibase + i];
> +		if (virq < 0 || virq > NR_IRQS) {
> +			dev_err(binfo->dev,
> +				"Invalid irq table entry for feature 0x%llx\n",
> +				fid);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	*irq_base = ibase;
> +	*nr_irqs = inr;
> +
> +	return 0;
> +}
> +
>  /*
>   * when create sub feature instances, for private features, it doesn't need
>   * to provide resource size and feature id as they could be read from DFH
> @@ -650,7 +748,9 @@ create_feature_instance(struct build_feature_devs_info *binfo,
>  			struct dfl_fpga_enum_dfl *dfl, resource_size_t ofst,
>  			resource_size_t size, u64 fid)
>  {
> +	unsigned int irq_base, nr_irqs;
>  	struct dfl_feature_info *finfo;
> +	int ret;
>  
>  	/* read feature size and id if inputs are invalid */
>  	size = size ? size : feature_size(dfl->ioaddr + ofst);
> @@ -659,6 +759,10 @@ create_feature_instance(struct build_feature_devs_info *binfo,
>  	if (dfl->len - ofst < size)
>  		return -EINVAL;
>  
> +	ret = parse_feature_irqs(binfo, ofst, fid, &irq_base, &nr_irqs);
> +	if (ret)
> +		return ret;
> +
>  	finfo = kzalloc(sizeof(*finfo), GFP_KERNEL);
>  	if (!finfo)
>  		return -ENOMEM;
> @@ -667,6 +771,8 @@ create_feature_instance(struct build_feature_devs_info *binfo,
>  	finfo->mmio_res.start = dfl->start + ofst;
>  	finfo->mmio_res.end = finfo->mmio_res.start + size - 1;
>  	finfo->mmio_res.flags = IORESOURCE_MEM;
> +	finfo->irq_base = irq_base;
> +	finfo->nr_irqs = nr_irqs;
>  	finfo->ioaddr = dfl->ioaddr + ofst;
>  
>  	list_add_tail(&finfo->node, &binfo->sub_features);
> @@ -853,6 +959,10 @@ void dfl_fpga_enum_info_free(struct dfl_fpga_enum_info *info)
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
> @@ -892,6 +1002,45 @@ int dfl_fpga_enum_info_add_dfl(struct dfl_fpga_enum_info *info,
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
> + * As we only support one irq domain for all DFLs in the same enum info, adding
> + * irq table a second time for the same enum info will return error.
> + *
> + * If we need to enumerate DFLs which belong to different irq domains, we
> + * should fill more enum info and enumerate them one by one.
> + *
> + * Return: 0 on success, negative error code otherwise.
> + */
> +int dfl_fpga_enum_info_add_irq(struct dfl_fpga_enum_info *info,
> +			       unsigned int nr_irqs, int *irq_table)
> +{
> +	if (!nr_irqs || !irq_table)
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
> @@ -959,6 +1108,10 @@ dfl_fpga_feature_devs_enumerate(struct dfl_fpga_enum_info *info)
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
> index 2f5d305..59e26f7 100644
> --- a/drivers/fpga/dfl.h
> +++ b/drivers/fpga/dfl.h
> @@ -18,6 +18,7 @@
>  #include <linux/cdev.h>
>  #include <linux/delay.h>
>  #include <linux/fs.h>
> +#include <linux/interrupt.h>
>  #include <linux/iopoll.h>
>  #include <linux/io-64-nonatomic-lo-hi.h>
>  #include <linux/platform_device.h>
> @@ -112,6 +113,13 @@
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
> @@ -145,6 +153,20 @@
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
> @@ -189,6 +211,15 @@ struct dfl_feature_driver {
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
> @@ -196,6 +227,8 @@ struct dfl_feature_driver {
>   *		    this index is used to find its mmio resource from the
>   *		    feature dev (platform device)'s reources.
>   * @ioaddr: mapped mmio resource address.
> + * @irq_ctx: interrupt context list.
> + * @nr_irqs: number of interrupt contexts.
>   * @ops: ops of this sub feature.
>   * @priv: priv data of this feature.
>   */
> @@ -203,6 +236,8 @@ struct dfl_feature {
>  	u64 id;
>  	int resource_index;
>  	void __iomem *ioaddr;
> +	struct dfl_feature_irq_ctx *irq_ctx;
> +	unsigned int nr_irqs;
>  	const struct dfl_feature_ops *ops;
>  	void *priv;
>  };
> @@ -390,10 +425,14 @@ static inline u8 dfl_feature_revision(void __iomem *base)
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
> @@ -417,6 +456,8 @@ struct dfl_fpga_enum_info *dfl_fpga_enum_info_alloc(struct device *dev);
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
> 
Applied to for-next,

Thanks!

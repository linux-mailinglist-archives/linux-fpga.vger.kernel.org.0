Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 957505B4CF1
	for <lists+linux-fpga@lfdr.de>; Sun, 11 Sep 2022 11:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbiIKJQb (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 11 Sep 2022 05:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiIKJQa (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 11 Sep 2022 05:16:30 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7793BC4D;
        Sun, 11 Sep 2022 02:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662887787; x=1694423787;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=R8farjhv/coFNpKXqTaQfgiezZzPSSkEHtaqgvhs4vg=;
  b=CCXfVFnWzGD8bN/83irtBBwOzOlllZKPGtsDpNdN2ciyRnuMnAmuh6uo
   GiqMswfpHcT8ayDTpWyZ/QdO3uKbXNjm03sIyzXrvMYfEcBP1WtvXv0bJ
   QTLPPND7VPKV02jdfhmyLfjIYZywMyFcWjfdI18phFLU/kI4K2MYpOsrY
   VH9z06Sn41AGtdGJW8KlFQ3CuWvZB5wqPxOw/+2jZgcr7dL1LOkG1Lt22
   SUM8i7iMSzupsEOWO5IGHq7Kg9n/BqWCZjVlSlTPJMymhWoHtMkdATI0n
   vuBq3uwAorYxeizc76hO/pWgowqPU7FRh23wwupRxvuXjgkurIKC0VeLY
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10466"; a="298507693"
X-IronPort-AV: E=Sophos;i="5.93,307,1654585200"; 
   d="scan'208";a="298507693"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2022 02:16:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,307,1654585200"; 
   d="scan'208";a="648939104"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga001.jf.intel.com with ESMTP; 11 Sep 2022 02:16:21 -0700
Date:   Sun, 11 Sep 2022 17:06:49 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     matthew.gerlach@linux.intel.com
Cc:     hao.wu@intel.com, russell.h.weight@intel.com,
        basheer.ahmed.muddebihal@intel.com, trix@redhat.com,
        mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tianfei.zhang@intel.com, corbet@lwn.net,
        gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        jirislaby@kernel.org, geert+renesas@glider.be,
        andriy.shevchenko@linux.intel.com,
        niklas.soderlund+renesas@ragnatech.se, phil.edworthy@renesas.com,
        macro@orcam.me.uk, johan@kernel.org, lukas@wunner.de
Subject: Re: [PATCH v1 4/5] fpga: dfl: add generic support for MSIX interrupts
Message-ID: <Yx2lKZJq4LA0KWRY@yilunxu-OptiPlex-7050>
References: <20220906190426.3139760-1-matthew.gerlach@linux.intel.com>
 <20220906190426.3139760-5-matthew.gerlach@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906190426.3139760-5-matthew.gerlach@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2022-09-06 at 12:04:25 -0700, matthew.gerlach@linux.intel.com wrote:
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> 
> Define and use a DFHv1 parameter to add generic support for MSIX
> interrupts for DFL devices.
> 
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> ---
>  drivers/fpga/dfl.c  | 59 +++++++++++++++++++++++++++++++++------------
>  include/linux/dfl.h | 13 ++++++++++
>  2 files changed, 57 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> index b9aae85ba930..17f704dc8483 100644
> --- a/drivers/fpga/dfl.c
> +++ b/drivers/fpga/dfl.c
> @@ -941,25 +941,11 @@ static int parse_feature_irqs(struct build_feature_devs_info *binfo,
>  	void __iomem *base = binfo->ioaddr + ofst;
>  	unsigned int i, ibase, inr = 0;
>  	enum dfl_id_type type;
> -	int virq;
> +	int virq, off;
>  	u64 v;
>  
>  	type = feature_dev_id_type(binfo->feature_dev);
>  
> -	/*
> -	 * Ideally DFL framework should only read info from DFL header, but
> -	 * current version DFL only provides mmio resources information for
> -	 * each feature in DFL Header, no field for interrupt resources.
> -	 * Interrupt resource information is provided by specific mmio
> -	 * registers of each private feature which supports interrupt. So in
> -	 * order to parse and assign irq resources, DFL framework has to look
> -	 * into specific capability registers of these private features.
> -	 *
> -	 * Once future DFL version supports generic interrupt resource
> -	 * information in common DFL headers, the generic interrupt parsing
> -	 * code will be added. But in order to be compatible to old version
> -	 * DFL, the driver may still fall back to these quirks.
> -	 */

I don't think we should just remove the entire comments here, we still
need these quirks for DFHv0.

>  	if (type == PORT_ID) {
>  		switch (fid) {
>  		case PORT_FEATURE_ID_UINT:
> @@ -981,6 +967,28 @@ static int parse_feature_irqs(struct build_feature_devs_info *binfo,
>  		}
>  	}
>  
> +	if (fid != FEATURE_ID_AFU && fid != PORT_FEATURE_ID_ERROR &&
> +	    fid != PORT_FEATURE_ID_UINT && fid != FME_FEATURE_ID_GLOBAL_ERR) {

Is it possible we don't list all quirks again?

> +		v = readq(base);
> +		v = FIELD_GET(DFH_VERSION, v);
> +
> +		if (v == 1) {
> +			v =  readq(base + DFHv1_CSR_SIZE_GRP);
> +			if (FIELD_GET(DFHv1_CSR_SIZE_GRP_HAS_PARAMS, v)) {
> +				off = dfl_find_param(base + DFHv1_PARAM_HDR, ofst,
> +						     DFHv1_PARAM_ID_MSIX);
> +				if (off >= 0) {
> +					ibase = readl(base + DFHv1_PARAM_HDR +
> +						      off + DFHv1_PARAM_MSIX_STARTV);
> +					inr = readl(base + DFHv1_PARAM_HDR +
> +						    off + DFHv1_PARAM_MSIX_NUMV);
> +					dev_dbg(binfo->dev, "%s start %d num %d fid 0x%x\n",
> +						__func__, ibase, inr, fid);
> +				}
> +			}
> +		}
> +	}

Please help describe how the new irq params works with existing irq
capable features. Some possible cases?

If version = v1, has irq param, no feature quirk.
If version = v1, no irq param, has feature quirk.
If version = v1, has irq param, has feature quirk.

Thanks,
Yilun

> +
>  	if (!inr) {
>  		*irq_base = 0;
>  		*nr_irqs = 0;
> @@ -1879,6 +1887,27 @@ long dfl_feature_ioctl_set_irq(struct platform_device *pdev,
>  }
>  EXPORT_SYMBOL_GPL(dfl_feature_ioctl_set_irq);
>  
> +int dfl_find_param(void __iomem *base, resource_size_t max, int param)
> +{
> +	int off = 0;
> +	u64 v, next;
> +
> +	while (off < max) {
> +		v = readq(base + off);
> +		if (param == FIELD_GET(DFHv1_PARAM_HDR_ID, v))
> +			return off;
> +
> +		next = FIELD_GET(DFHv1_PARAM_HDR_NEXT_OFFSET, v);
> +		if (!next)
> +			break;
> +
> +		off += next;
> +	}
> +
> +	return -ENOENT;
> +}
> +EXPORT_SYMBOL_GPL(dfl_find_param);
> +
>  static void __exit dfl_fpga_exit(void)
>  {
>  	dfl_chardev_uinit();
> diff --git a/include/linux/dfl.h b/include/linux/dfl.h
> index 61bcf20c1bc8..5652879ab48e 100644
> --- a/include/linux/dfl.h
> +++ b/include/linux/dfl.h
> @@ -69,6 +69,10 @@
>  #define DFHv1_PARAM_HDR_VERSION		GENMASK_ULL(31, 16) /* Version Param */
>  #define DFHv1_PARAM_HDR_NEXT_OFFSET	GENMASK_ULL(63, 32) /* Offset of next Param */
>  
> +#define DFHv1_PARAM_ID_MSIX	0x1
> +#define DFHv1_PARAM_MSIX_STARTV	0x8
> +#define DFHv1_PARAM_MSIX_NUMV	0xc
> +
>  /**
>   * enum dfl_id_type - define the DFL FIU types
>   */
> @@ -142,4 +146,13 @@ void dfl_driver_unregister(struct dfl_driver *dfl_drv);
>  	module_driver(__dfl_driver, dfl_driver_register, \
>  		      dfl_driver_unregister)
>  
> +/*
> + * dfl_find_param() - find the offset of the given parameter
> + * @base: base pointer to start of dfl parameters in DFH
> + * @max: maximum offset to search
> + * @param: id of dfl parameter
> + *
> + * Return: positive offset on success, negative error code otherwise.
> + */
> +int dfl_find_param(void __iomem *base, resource_size_t max, int param);
>  #endif /* __LINUX_DFL_H */
> -- 
> 2.25.1
> 

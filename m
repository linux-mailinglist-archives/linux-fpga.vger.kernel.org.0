Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7415F0362
	for <lists+linux-fpga@lfdr.de>; Fri, 30 Sep 2022 05:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbiI3Dhg (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 29 Sep 2022 23:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiI3Dhe (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 29 Sep 2022 23:37:34 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D2EA118B1D;
        Thu, 29 Sep 2022 20:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664509053; x=1696045053;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/t5PvzkP5CnfVfh6FXwUHOhMRJZQfg+GbB0zWgJE51E=;
  b=To2DeY+Tjm5gldKvOE8kNdGTSx3OMsNt+gVL/aaGIDgnXHeByunqxrUq
   f0xnmIEZzAc1BfSKGtOffAHQ0AEFGThGz/yTbT1xCVHl5/B9TQhghXBfp
   opRZERiiRj6fd+vL6+Y3Q7RP7pBG/j6TU0tdNa7MO96qbhzGBfHyV/gOY
   qa5NguRMZ9iYwbz3rjXXX/JPA4ifwGCgyQavlxKScsVBQ4r6p8t0qH3BN
   T+IKlpMy8lgLUNVthVWRQf6e+kwIWHvGtGPOtOWPX89T4Dke+05HhxCVg
   qzcTY2h8GjRCGz4d4jxVc82+rN0Yxnoh/2r+Q1lfZVFzv7g4QfkDqjVCz
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="303006236"
X-IronPort-AV: E=Sophos;i="5.93,357,1654585200"; 
   d="scan'208";a="303006236"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 20:37:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="685122739"
X-IronPort-AV: E=Sophos;i="5.93,357,1654585200"; 
   d="scan'208";a="685122739"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga008.fm.intel.com with ESMTP; 29 Sep 2022 20:37:27 -0700
Date:   Fri, 30 Sep 2022 11:28:38 +0800
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
Subject: Re: [PATCH v2 4/6] fpga: dfl: add generic support for MSIX interrupts
Message-ID: <YzZiZsc3X0Iy6Z5S@yilunxu-OptiPlex-7050>
References: <20220923121745.129167-1-matthew.gerlach@linux.intel.com>
 <20220923121745.129167-5-matthew.gerlach@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220923121745.129167-5-matthew.gerlach@linux.intel.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2022-09-23 at 05:17:43 -0700, matthew.gerlach@linux.intel.com wrote:
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> 
> Define and use a DFHv1 parameter to add generic support for MSIX
> interrupts for DFL devices.
> 
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> ---
> v2: fix kernel doc
>     clarify use of DFH_VERSION field
> ---
>  drivers/fpga/dfl.c  | 60 +++++++++++++++++++++++++++++++++++++++++----
>  include/linux/dfl.h | 14 +++++++++++
>  2 files changed, 69 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> index 1132f3c10440..dfd3f563c92d 100644
> --- a/drivers/fpga/dfl.c
> +++ b/drivers/fpga/dfl.c
> @@ -941,23 +941,22 @@ static int parse_feature_irqs(struct build_feature_devs_info *binfo,
>  	void __iomem *base = binfo->ioaddr + ofst;
>  	unsigned int i, ibase, inr = 0;
>  	enum dfl_id_type type;
> -	int virq;
> +	int virq, off;
>  	u64 v;
>  
>  	type = feature_dev_id_type(binfo->feature_dev);
>  
>  	/*
>  	 * Ideally DFL framework should only read info from DFL header, but
> -	 * current version DFL only provides mmio resources information for
> +	 * current version, DFHv0, only provides mmio resources information for

With this patchset, it's not 'current version' anymore.

>  	 * each feature in DFL Header, no field for interrupt resources.
>  	 * Interrupt resource information is provided by specific mmio
>  	 * registers of each private feature which supports interrupt. So in
>  	 * order to parse and assign irq resources, DFL framework has to look
>  	 * into specific capability registers of these private features.
>  	 *
> -	 * Once future DFL version supports generic interrupt resource
> -	 * information in common DFL headers, the generic interrupt parsing
> -	 * code will be added. But in order to be compatible to old version
> +	 * DFHv1 supports generic interrupt resource information in DFHv1
> +	 * parameter blocks. But in order to be compatible to old version
>  	 * DFL, the driver may still fall back to these quirks.
>  	 */
>  	if (type == PORT_ID) {
> @@ -981,6 +980,36 @@ static int parse_feature_irqs(struct build_feature_devs_info *binfo,
>  		}
>  	}
>  
> +	if (fid != FEATURE_ID_AFU && fid != PORT_FEATURE_ID_ERROR &&
> +	    fid != PORT_FEATURE_ID_UINT && fid != FME_FEATURE_ID_GLOBAL_ERR) {
> +
> +		v = FIELD_GET(DFH_VERSION, readq(base));
> +		switch (v) {
> +		case 0:
> +			break;

In last version, you mentioned that there will be no quirk for DFLv1, so
how about:

  v = FIELD_GET(DFH_VERSION, readq(base));

  if (v == 0) {
	/* quirks */
  } else {
	/* parse PARAM MSIX  */
  }

No need to check specific feature ids again.

Thanks,
Yilun

> +
> +		case 1:
> +			v =  readq(base + DFHv1_CSR_SIZE_GRP);
> +			if (FIELD_GET(DFHv1_CSR_SIZE_GRP_HAS_PARAMS, v)) {
> +				off = dfl_find_param(base + DFHv1_PARAM_HDR, ofst,
> +						     DFHv1_PARAM_ID_MSIX);
> +				if (off >= 0) {
> +					ibase = readl(base + DFHv1_PARAM_HDR +
> +						      off + DFHv1_PARAM_MSIX_STARTV);
> +					inr = readl(base + DFHv1_PARAM_HDR +
> +						    off + DFHv1_PARAM_MSIX_NUMV);
> +					dev_dbg(binfo->dev, "start %d num %d fid 0x%x\n",
> +						ibase, inr, fid);
> +				}
> +			}
> +			break;
> +
> +		default:
> +			dev_warn(binfo->dev, "unexpected DFH version %lld\n", v);
> +			break;
> +		}
> +	}
> +
>  	if (!inr) {
>  		*irq_base = 0;
>  		*nr_irqs = 0;
> @@ -1879,6 +1908,27 @@ long dfl_feature_ioctl_set_irq(struct platform_device *pdev,
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
> index 1e53468ba8d8..33e21c360671 100644
> --- a/include/linux/dfl.h
> +++ b/include/linux/dfl.h
> @@ -63,6 +63,10 @@
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
> @@ -136,4 +140,14 @@ void dfl_driver_unregister(struct dfl_driver *dfl_drv);
>  	module_driver(__dfl_driver, dfl_driver_register, \
>  		      dfl_driver_unregister)
>  
> +/**
> + * dfl_find_param() - find the offset of the given parameter
> + * @base: base pointer to start of dfl parameters in DFH
> + * @max: maximum offset to search
> + * @param: id of dfl parameter
> + *
> + * Return: positive offset on success, negative error code otherwise.
> + */
> +int dfl_find_param(void __iomem *base, resource_size_t max, int param);
> +
>  #endif /* __LINUX_DFL_H */
> -- 
> 2.25.1
> 

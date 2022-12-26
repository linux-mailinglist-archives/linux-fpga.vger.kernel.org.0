Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80AD5656047
	for <lists+linux-fpga@lfdr.de>; Mon, 26 Dec 2022 07:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbiLZGGk (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 26 Dec 2022 01:06:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiLZGGj (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 26 Dec 2022 01:06:39 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC13E45;
        Sun, 25 Dec 2022 22:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672034798; x=1703570798;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oA+2akBz8f9G0yJVLVSJpvfu0UZtDt88sO01ckh/aVc=;
  b=EAfeNH4G0xIfKz2N9H7wwQBJJ1Jhxx6vkwOpxRpyqO1fzwdMPx4NS8D1
   EHVPqzdoeXo0QpRPraPwHLxzhDXV0UH6rjDGs5nhbTTEMJgbGAfvWjZAw
   Sur1cwA/mw2Mqv1CETsWqVqPYjO1PrdXBsbYXHOgEGLls9EoFnZqfzpzw
   ltO3KMk3bSPj3u8nPlwZ3XNG18O4ullB78089VN6iMir9czvYsOe8rqJA
   eZq1MmMfgbjOQs6PsTnJsI3LrRZ2s7V+4pB5QxDMKj6h67aohdcTrMj8D
   cVaQEcBtx+S/mWp1nJvwaZVSNCdtnfZxDjN7lturCs1WvKRlFdnMfK/2W
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10571"; a="304027728"
X-IronPort-AV: E=Sophos;i="5.96,274,1665471600"; 
   d="scan'208";a="304027728"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2022 22:06:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10571"; a="721177000"
X-IronPort-AV: E=Sophos;i="5.96,274,1665471600"; 
   d="scan'208";a="721177000"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga004.fm.intel.com with ESMTP; 25 Dec 2022 22:06:32 -0800
Date:   Mon, 26 Dec 2022 13:56:29 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Nava kishore Manne <nava.kishore.manne@amd.com>
Cc:     michal.simek@xilinx.com, mdf@kernel.org, hao.wu@intel.com,
        trix@redhat.com, ronak.jain@xilinx.com, gregkh@linuxfoundation.org,
        tanmay.shah@xilinx.com, ben.levinsky@amd.com,
        harsha.harsha@xilinx.com, rajan.vaja@xilinx.com,
        mathieu.poirier@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: Re: [PATCH v4 1/2] firmware: xilinx: Add pm api function for PL
 config reg readback
Message-ID: <Y6k3jXv+J7C43akc@yilunxu-OptiPlex-7050>
References: <20221223115850.2572573-1-nava.kishore.manne@amd.com>
 <20221223115850.2572573-2-nava.kishore.manne@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221223115850.2572573-2-nava.kishore.manne@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2022-12-23 at 17:28:49 +0530, Nava kishore Manne wrote:
> Adds PM API for performing Programmable Logic(PL) configuration
> register readback. It provides an interface to the firmware(pmufw)
> to readback the FPGA configuration register.
> 
> Signed-off-by: Nava kishore Manne <nava.kishore.manne@amd.com>
> ---
> changes for v2:
>               - None.
> 
> Changes for v3:
>               - Updated API and config reg read-back handling logic
>               - Updated the commit msg to align with the changes.
> 
> Changes for v4:
>               - Fix some minor coding issues. No functional changes.
>               - Updated Return value comments as suggested by Xu Yilun.
> 
>  drivers/firmware/xilinx/zynqmp.c     | 33 ++++++++++++++++++++++++++++
>  include/linux/firmware/xlnx-zynqmp.h | 10 +++++++++
>  2 files changed, 43 insertions(+)
> 
> diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
> index ff5cabe70a2b..ca954e1119b5 100644
> --- a/drivers/firmware/xilinx/zynqmp.c
> +++ b/drivers/firmware/xilinx/zynqmp.c
> @@ -941,6 +941,39 @@ int zynqmp_pm_fpga_get_status(u32 *value)
>  }
>  EXPORT_SYMBOL_GPL(zynqmp_pm_fpga_get_status);
>  
> +/**
> + * zynqmp_pm_fpga_get_config_status - Get the FPGA configuration status.
> + * @value: Buffer to store FPGA configuration status.
> + *
> + * This function provides access to the pmufw to get the FPGA configuration
> + * status
> + *
> + * Return: 0 on success, a negative value on error
> + */
> +int zynqmp_pm_fpga_get_config_status(u32 *value)
> +{
> +	u32 buf, phys_lower_addr, phys_upper_addr;

Why naming them phys_xxx?

> +	u32 ret_payload[PAYLOAD_ARG_CNT];
> +	int ret;
> +
> +	if (!value)
> +		return -EINVAL;
> +
> +	phys_lower_addr = lower_32_bits((u64)&buf);
> +	phys_upper_addr = upper_32_bits((u64)&buf);
> +
> +	ret = zynqmp_pm_invoke_fn(PM_FPGA_READ,
> +				  XILINX_ZYNQMP_PM_FPGA_CONFIG_STAT_OFFSET,
> +				  phys_lower_addr, phys_upper_addr,
> +				  XILINX_ZYNQMP_PM_FPGA_READ_CONFIG_REG,
> +				  ret_payload);
> +
> +	*value = ret_payload[1];
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(zynqmp_pm_fpga_get_config_status);
> +
>  /**
>   * zynqmp_pm_pinctrl_request - Request Pin from firmware
>   * @pin: Pin number to request
> diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
> index 76d2b3ebad84..29e8964f4297 100644
> --- a/include/linux/firmware/xlnx-zynqmp.h
> +++ b/include/linux/firmware/xlnx-zynqmp.h
> @@ -70,6 +70,10 @@
>  #define XILINX_ZYNQMP_PM_FPGA_FULL	0x0U
>  #define XILINX_ZYNQMP_PM_FPGA_PARTIAL	BIT(0)
>  
> +/* FPGA Status Reg */
> +#define XILINX_ZYNQMP_PM_FPGA_CONFIG_STAT_OFFSET	7U
> +#define XILINX_ZYNQMP_PM_FPGA_READ_CONFIG_REG		0U
> +
>  /*
>   * Node IDs for the Error Events.
>   */
> @@ -117,6 +121,7 @@ enum pm_api_id {
>  	PM_CLOCK_GETRATE = 42,
>  	PM_CLOCK_SETPARENT = 43,
>  	PM_CLOCK_GETPARENT = 44,
> +	PM_FPGA_READ = 46,
>  	PM_SECURE_AES = 47,
>  	PM_FEATURE_CHECK = 63,
>  };
> @@ -505,6 +510,7 @@ int zynqmp_pm_register_sgi(u32 sgi_num, u32 reset);
>  int zynqmp_pm_set_sd_config(u32 node, enum pm_sd_config_type config, u32 value);
>  int zynqmp_pm_set_gem_config(u32 node, enum pm_gem_config_type config,
>  			     u32 value);
> +int zynqmp_pm_fpga_get_config_status(u32 *value);

Is it better put it along with zynqmp_pm_fpga_get_status()?

Thanks,
Yilun

>  #else
>  static inline int zynqmp_pm_get_api_version(u32 *version)
>  {
> @@ -790,6 +796,10 @@ static inline int zynqmp_pm_set_gem_config(u32 node,
>  	return -ENODEV;
>  }
>  
> +static inline int zynqmp_pm_fpga_get_config_status(u32 *value)
> +{
> +	return -ENODEV;
> +}
>  #endif
>  
>  #endif /* __FIRMWARE_ZYNQMP_H__ */
> -- 
> 2.25.1
> 

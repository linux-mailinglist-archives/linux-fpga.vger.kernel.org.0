Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBD1F6A27DC
	for <lists+linux-fpga@lfdr.de>; Sat, 25 Feb 2023 09:14:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbjBYIM3 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 25 Feb 2023 03:12:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjBYIM2 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 25 Feb 2023 03:12:28 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D429B11E82;
        Sat, 25 Feb 2023 00:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677312746; x=1708848746;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=P1QZMTFRt/gCcckpVneXrNNscsR4SIg0AgfC8vIFN7o=;
  b=TkFJeooQytddLWTq7H9k0IVBr7z4oqMCRtgvDEOE9t9kyKjl8DiqMXqU
   R8+8oH2cvogdK0q8HnPGQjCasRaiySDF8C6L/7jdhzTEWdsX7jyJnI94C
   UGMNshJ+40uwXbQ4tXv/E0qKBw+exdGTzd6ASY/tyTN4Qe3dfugWn/ybD
   x8Yp0F4h6cg2WdzCVH6lRWNll/OVP3e0Ct8/7tZm8ORgYvZlBXc15cBd1
   yXJaIQcvPCtVR82ojjQzqK2l+L8Tt01kUyY3PohXYu87THytHWeqUctKd
   y/Brai140ZUYs/rS3ZtvXheKTSRi71KFc/hYJf4sdTSohhWkmHO8nng09
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10631"; a="332334440"
X-IronPort-AV: E=Sophos;i="5.97,327,1669104000"; 
   d="scan'208";a="332334440"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2023 00:12:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10631"; a="796989551"
X-IronPort-AV: E=Sophos;i="5.97,327,1669104000"; 
   d="scan'208";a="796989551"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga004.jf.intel.com with ESMTP; 25 Feb 2023 00:12:19 -0800
Date:   Sat, 25 Feb 2023 16:01:18 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Nava kishore Manne <nava.kishore.manne@amd.com>
Cc:     michal.simek@xilinx.com, mdf@kernel.org, hao.wu@intel.com,
        trix@redhat.com, ronak.jain@xilinx.com, gregkh@linuxfoundation.org,
        tanmay.shah@xilinx.com, mathieu.poirier@linaro.org,
        ben.levinsky@amd.com, rajan.vaja@xilinx.com,
        harsha.harsha@xilinx.com, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: Re: [PATCH v7 1/2] firmware: xilinx: Add pm api function for PL
 config reg readback
Message-ID: <Y/nATlazfFZrDZRr@yilunxu-OptiPlex-7050>
References: <20230224120738.329416-1-nava.kishore.manne@amd.com>
 <20230224120738.329416-2-nava.kishore.manne@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230224120738.329416-2-nava.kishore.manne@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2023-02-24 at 17:37:37 +0530, Nava kishore Manne wrote:
> Adds PM API for performing Programmable Logic(PL) configuration
> register readback. It provides an interface to the firmware(pmufw)
> to readback the FPGA configuration register.
> 
> Signed-off-by: Nava kishore Manne <nava.kishore.manne@amd.com>

Acked-by: Xu Yilun <yilun.xu@intel.com>

> ---
> changes for v2:
>               - None.
> 
> Changes for v3:
>               - Updated API and config reg read-back handling logic
>               - Updated the commit msg to align with the changes.
> 
> Changes for v4:
>               - Fixed some minor coding issues. No functional changes.
>               - Updated Return value comments as suggested by Xu Yilun.
> 
> Changes for v5:
>               - Fixed some minor coding issues as suggested by Xu Yilun.
>                 No functional changes.
> 
> Changes for v6:
>               - None.
> 
> Changes for v7:
>               - None.
> 
>  drivers/firmware/xilinx/zynqmp.c     | 33 ++++++++++++++++++++++++++++
>  include/linux/firmware/xlnx-zynqmp.h | 11 ++++++++++
>  2 files changed, 44 insertions(+)
> 
> diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
> index 129f68d7a6f5..3d8cc6795b43 100644
> --- a/drivers/firmware/xilinx/zynqmp.c
> +++ b/drivers/firmware/xilinx/zynqmp.c
> @@ -948,6 +948,39 @@ int zynqmp_pm_fpga_get_status(u32 *value)
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
> +	u32 ret_payload[PAYLOAD_ARG_CNT];
> +	u32 buf, lower_addr, upper_addr;
> +	int ret;
> +
> +	if (!value)
> +		return -EINVAL;
> +
> +	lower_addr = lower_32_bits((u64)&buf);
> +	upper_addr = upper_32_bits((u64)&buf);
> +
> +	ret = zynqmp_pm_invoke_fn(PM_FPGA_READ,
> +				  XILINX_ZYNQMP_PM_FPGA_CONFIG_STAT_OFFSET,
> +				  lower_addr, upper_addr,
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
> index b09f443d3ab9..ce37d55ffa44 100644
> --- a/include/linux/firmware/xlnx-zynqmp.h
> +++ b/include/linux/firmware/xlnx-zynqmp.h
> @@ -71,6 +71,10 @@
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
> @@ -120,6 +124,7 @@ enum pm_api_id {
>  	PM_CLOCK_GETRATE = 42,
>  	PM_CLOCK_SETPARENT = 43,
>  	PM_CLOCK_GETPARENT = 44,
> +	PM_FPGA_READ = 46,
>  	PM_SECURE_AES = 47,
>  	PM_FEATURE_CHECK = 63,
>  };
> @@ -515,6 +520,7 @@ int zynqmp_pm_aes_engine(const u64 address, u32 *out);
>  int zynqmp_pm_sha_hash(const u64 address, const u32 size, const u32 flags);
>  int zynqmp_pm_fpga_load(const u64 address, const u32 size, const u32 flags);
>  int zynqmp_pm_fpga_get_status(u32 *value);
> +int zynqmp_pm_fpga_get_config_status(u32 *value);
>  int zynqmp_pm_write_ggs(u32 index, u32 value);
>  int zynqmp_pm_read_ggs(u32 index, u32 *value);
>  int zynqmp_pm_write_pggs(u32 index, u32 value);
> @@ -721,6 +727,11 @@ static inline int zynqmp_pm_fpga_get_status(u32 *value)
>  	return -ENODEV;
>  }
>  
> +static inline int zynqmp_pm_fpga_get_config_status(u32 *value)
> +{
> +	return -ENODEV;
> +}
> +
>  static inline int zynqmp_pm_write_ggs(u32 index, u32 value)
>  {
>  	return -ENODEV;
> -- 
> 2.25.1
> 

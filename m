Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1A85A350F
	for <lists+linux-fpga@lfdr.de>; Sat, 27 Aug 2022 08:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbiH0GbG (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 27 Aug 2022 02:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbiH0GbF (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 27 Aug 2022 02:31:05 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C7040E0B;
        Fri, 26 Aug 2022 23:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661581864; x=1693117864;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2RdCy6tyMucjJ+3ngZSsWyiE4xxEX4EO/OwoRyYj4oU=;
  b=T/egcI7soO5io6EVHok/Son4qe+lEiRXzrPyYpt0qqulVpUiq8dHXJfM
   gd/pHoXeDf5LC/CtZXHwJ418PD248nHg4zyu4B6Xo3hEC7L/9U7Ftq46h
   IqDbbfOE54hptl/ApGpbRGj5e3PFMkTg9bxtD3mOIDDmtc1ITI9flFbC+
   7Esk6hd+6t2EJ82NKJ2rx0O/JMCBL+HCNxafnu7nYVoPRviKRJ9nrGgo3
   nmKJzTO3Xo4JK0B7DejmGNzZNVfcLjyPWMKnyt7XJuT41iIUHg57YTQ43
   XZH4J0ME15vbMP3sG3yhSQqWN4/AKAeOq8g+Sq4c6D1pwQ1+69chNUwPE
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10451"; a="275044533"
X-IronPort-AV: E=Sophos;i="5.93,267,1654585200"; 
   d="scan'208";a="275044533"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 23:31:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,267,1654585200"; 
   d="scan'208";a="938992735"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga005.fm.intel.com with ESMTP; 26 Aug 2022 23:30:58 -0700
Date:   Sat, 27 Aug 2022 14:21:42 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Nava kishore Manne <nava.kishore.manne@amd.com>
Cc:     git@amd.com, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        michal.simek@xilinx.com, mdf@kernel.org, hao.wu@intel.com,
        trix@redhat.com, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, ronak.jain@xilinx.com,
        rajan.vaja@xilinx.com, abhyuday.godhasara@xilinx.com,
        piyush.mehta@xilinx.com, lakshmi.sai.krishna.potthuri@xilinx.com,
        harsha.harsha@xilinx.com, linus.walleij@linaro.org,
        nava.manne@xilinx.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org, yilun.xu@intel.com
Subject: Re: [PATCH 1/4] firmware: xilinx: Add afi ioctl support
Message-ID: <Ywm39iYGLliU9ncv@yilunxu-OptiPlex-7050>
References: <20220824035542.706433-1-nava.kishore.manne@amd.com>
 <20220824035542.706433-2-nava.kishore.manne@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220824035542.706433-2-nava.kishore.manne@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2022-08-24 at 09:25:39 +0530, Nava kishore Manne wrote:
> Adds afi ioctl to support dynamic PS-PL bus width settings.

Please also describe what is afi, PS, PL here, Patch #0 won't appear in
upstream tree finally.

Thanks,
Yilun

> 
> Signed-off-by: Nava kishore Manne <nava.kishore.manne@amd.com>
> ---
>  drivers/firmware/xilinx/zynqmp.c     | 14 +++++++++++
>  include/linux/firmware/xlnx-zynqmp.h | 36 ++++++++++++++++++++++++++++
>  2 files changed, 50 insertions(+)
> 
> diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
> index d1f652802181..cbd84c96a66a 100644
> --- a/drivers/firmware/xilinx/zynqmp.c
> +++ b/drivers/firmware/xilinx/zynqmp.c
> @@ -843,6 +843,20 @@ int zynqmp_pm_read_pggs(u32 index, u32 *value)
>  }
>  EXPORT_SYMBOL_GPL(zynqmp_pm_read_pggs);
>  
> +/**
> + * zynqmp_pm_afi() - PM API for setting the PS-PL bus width
> + * @config_id:	Register index value
> + * @bus_width:	Afi interface bus width value.
> + *
> + * Return:	Returns status, either success or error+reason

I see other functions are also like this, but I still can't figure out
what values for success and what for error+reason.

Thanks,
Yilun

> + */
> +int zynqmp_pm_afi(u32 config_id, u32 bus_width)
> +{
> +	return zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_AFI,
> +				   config_id, bus_width, NULL);
> +}
> +EXPORT_SYMBOL_GPL(zynqmp_pm_afi);
> +
>  /**
>   * zynqmp_pm_set_boot_health_status() - PM API for setting healthy boot status
>   * @value:	Status value to be written
> diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
> index 9f50dacbf7d6..7d0d98303acc 100644
> --- a/include/linux/firmware/xlnx-zynqmp.h
> +++ b/include/linux/firmware/xlnx-zynqmp.h
> @@ -78,6 +78,16 @@
>  #define EVENT_ERROR_PSM_ERR1	(0x28108000U)
>  #define EVENT_ERROR_PSM_ERR2	(0x2810C000U)
>  
> +#define AFIFM_BUS_WIDTH_128_CONFIG_VAL	0x0U
> +#define AFIFM_BUS_WIDTH_64_CONFIG_VAL	0x1U
> +#define AFIFM_BUS_WIDTH_32_CONFIG_VAL	0x2U
> +
> +#define AFIFS_SS0_SS2_BUS_WIDTH_128_CONFIG_VAL	0x200U
> +#define AFIFS_SS0_SS2_BUS_WIDTH_64_CONFIG_VAL	0x100U
> +#define AFIFS_SS1_BUS_WIDTH_128_CONFIG_VAL	0x800U
> +#define AFIFS_SS1_BUS_WIDTH_64_CONFIG_VAL	0x400U
> +#define AFIFS_SS_BUS_WIDTH_32_CONFIG_VAL	0x0U
> +
>  enum pm_api_cb_id {
>  	PM_INIT_SUSPEND_CB = 30,
>  	PM_ACKNOWLEDGE_CB = 31,
> @@ -147,6 +157,7 @@ enum pm_ioctl_id {
>  	IOCTL_READ_PGGS = 15,
>  	/* Set healthy bit value */
>  	IOCTL_SET_BOOT_HEALTH_STATUS = 17,
> +	IOCTL_AFI = 18,
>  	IOCTL_OSPI_MUX_SELECT = 21,
>  	/* Register SGI to ATF */
>  	IOCTL_REGISTER_SGI = 25,
> @@ -155,6 +166,25 @@ enum pm_ioctl_id {
>  	IOCTL_GET_FEATURE_CONFIG = 27,
>  };
>  
> +enum pm_afi_config_id {
> +	AFIFM0_RDCTRL = 0,
> +	AFIFM0_WRCTRL = 1,
> +	AFIFM1_RDCTRL = 2,
> +	AFIFM1_WRCTRL = 3,
> +	AFIFM2_RDCTRL = 4,
> +	AFIFM2_WRCTRL = 5,
> +	AFIFM3_RDCTRL = 6,
> +	AFIFM3_WRCTRL = 7,
> +	AFIFM4_RDCTRL = 8,
> +	AFIFM4_WRCTRL = 9,
> +	AFIFM5_RDCTRL = 10,
> +	AFIFM5_WRCTRL = 11,
> +	AFIFM6_RDCTRL = 12,
> +	AFIFM6_WRCTRL = 13,
> +	AFIFS = 14,
> +	AFIFS_SS2 = 15,
> +};
> +
>  enum pm_query_id {
>  	PM_QID_INVALID = 0,
>  	PM_QID_CLOCK_GET_NAME = 1,
> @@ -475,6 +505,7 @@ int zynqmp_pm_is_function_supported(const u32 api_id, const u32 id);
>  int zynqmp_pm_set_feature_config(enum pm_feature_config_id id, u32 value);
>  int zynqmp_pm_get_feature_config(enum pm_feature_config_id id, u32 *payload);
>  int zynqmp_pm_register_sgi(u32 sgi_num, u32 reset);
> +int zynqmp_pm_afi(u32 config_id, u32 bus_width);
>  #else
>  static inline int zynqmp_pm_get_api_version(u32 *version)
>  {
> @@ -745,6 +776,11 @@ static inline int zynqmp_pm_register_sgi(u32 sgi_num, u32 reset)
>  {
>  	return -ENODEV;
>  }
> +
> +static inline int zynqmp_pm_afi(u32 config_id, u32 bus_width)
> +{
> +	return -ENODEV;
> +}
>  #endif
>  
>  #endif /* __FIRMWARE_ZYNQMP_H__ */
> -- 
> 2.25.1
> 

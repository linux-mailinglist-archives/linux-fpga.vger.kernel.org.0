Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56D215FF195
	for <lists+linux-fpga@lfdr.de>; Fri, 14 Oct 2022 17:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbiJNPmb (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 14 Oct 2022 11:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiJNPma (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 14 Oct 2022 11:42:30 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8522AE25;
        Fri, 14 Oct 2022 08:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665762148; x=1697298148;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=O3hlM9RR1X0TYLon8E8uraMngu523Z9hnJiAtff+dNg=;
  b=Gd0/iQZAHcRdhTOyPrFx/TVyUoONcPjTKcIBQhI643DlV8+WsqJKCwEr
   FRBG8FO4rZC0mWrJufLvtiGBzEQ0YREEijh29rT+56DD5UuWwf6DMY08+
   yZ+UN329W/1O4hCuGLJ+5jqXgIRoW2ou65jPKdftCDep5Y6ld/4xdCC2z
   6+FBiVaMIPBZ+St7456HYSOwSQVhJTS6iAdXltM/wGJdHStsFtk28YAc8
   QIwhoV8Ax0bh/7zzmSXYD6/UBlub8TCR2GOm85Mjmn0e64M3YhJQmMW0o
   XkYFbqL1VtkvXBnkLvZG81TEy8fUIqJa1ZqKCDJhZ3IYTKcMd73vEWqpE
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="285794014"
X-IronPort-AV: E=Sophos;i="5.95,184,1661842800"; 
   d="scan'208";a="285794014"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 08:42:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="660767496"
X-IronPort-AV: E=Sophos;i="5.95,184,1661842800"; 
   d="scan'208";a="660767496"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga001.jf.intel.com with ESMTP; 14 Oct 2022 08:42:23 -0700
Date:   Fri, 14 Oct 2022 23:33:18 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Nava kishore Manne <nava.kishore.manne@amd.com>
Cc:     git@xilinx.com, michal.simek@xilinx.com, mdf@kernel.org,
        hao.wu@intel.com, trix@redhat.com, gregkh@linuxfoundation.org,
        ronak.jain@xilinx.com, rajan.vaja@xilinx.com,
        abhyuday.godhasara@xilinx.com, harsha.harsha@xilinx.com,
        lakshmi.sai.krishna.potthuri@xilinx.com, tanmay.shah@xilinx.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: Re: [PATCH v3 1/2] firmware: xilinx: Add pm api function for PL
 config reg readback
Message-ID: <Y0mBPmoAeAZ+9SGv@yilunxu-OptiPlex-7050>
References: <20221013090556.741357-1-nava.kishore.manne@amd.com>
 <20221013090556.741357-2-nava.kishore.manne@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221013090556.741357-2-nava.kishore.manne@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2022-10-13 at 14:35:55 +0530, Nava kishore Manne wrote:
> Adds PM API for performing Programmable Logic(PL) configuration
> register readback. It provides an interface to the firmware(pmufw)
> to readback the FPGA configuration register.
> 
> Signed-off-by: Nava kishore Manne <nava.kishore.manne@amd.com>
> ---
> hanges for v2:
>               - None.
> 
> Changes for v3:
>               - Updated API and config reg read-back handling logic
>               - Updated the commit msg to align with the changes.
> 
>  drivers/firmware/xilinx/zynqmp.c     | 35 ++++++++++++++++++++++++++++
>  include/linux/firmware/xlnx-zynqmp.h | 11 +++++++++
>  2 files changed, 46 insertions(+)
> 
> diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
> index d1f652802181..045a113434c2 100644
> --- a/drivers/firmware/xilinx/zynqmp.c
> +++ b/drivers/firmware/xilinx/zynqmp.c
> @@ -941,6 +941,41 @@ int zynqmp_pm_fpga_get_status(u32 *value)
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
> + * Return: Returns status, either success or error+reason

As mentioned before, please at least specify what value is success

> + */
> +int zynqmp_pm_fpga_get_config_status(u32 *value)
> +{
> +	u32 ret_payload[PAYLOAD_ARG_CNT];
> +	u32 buf, phys_lower_addr, phys_upper_addr, addr;

reverse santa tree, please

> +	int ret;
> +
> +	if (!value)
> +		return -EINVAL;
> +
> +	addr = (u64)&buf;
> +
> +	phys_lower_addr = lower_32_bits(addr);
> +	phys_upper_addr = upper_32_bits(addr);

u64 addr???

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
> index 9f50dacbf7d6..34b0a9171293 100644
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
> @@ -475,6 +480,7 @@ int zynqmp_pm_is_function_supported(const u32 api_id, const u32 id);
>  int zynqmp_pm_set_feature_config(enum pm_feature_config_id id, u32 value);
>  int zynqmp_pm_get_feature_config(enum pm_feature_config_id id, u32 *payload);
>  int zynqmp_pm_register_sgi(u32 sgi_num, u32 reset);
> +int zynqmp_pm_fpga_get_config_status(u32 *value);
>  #else
>  static inline int zynqmp_pm_get_api_version(u32 *version)
>  {
> @@ -745,6 +751,11 @@ static inline int zynqmp_pm_register_sgi(u32 sgi_num, u32 reset)
>  {
>  	return -ENODEV;
>  }
> +
> +int zynqmp_pm_fpga_get_config_status(u32 *value)
> +{
> +	return -ENODEV;
> +}
>  #endif
>  
>  #endif /* __FIRMWARE_ZYNQMP_H__ */
> -- 
> 2.25.1
> 

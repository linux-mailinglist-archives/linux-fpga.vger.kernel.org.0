Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 693104F22A7
	for <lists+linux-fpga@lfdr.de>; Tue,  5 Apr 2022 07:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbiDEFpH (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 5 Apr 2022 01:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiDEFpH (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 5 Apr 2022 01:45:07 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456AC7D036;
        Mon,  4 Apr 2022 22:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649137389; x=1680673389;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QkhwjM4NOVGIGV18viP88LLCyv8YTx7E+6w6ZCZlrFY=;
  b=YY6vRpGMaD3wmxes0B2k3Ff1GdkZEuxfXjvj65kyhYKQIMPtG5h/ipGs
   WMqEiuU9vuVRMSKEMJ1WBjK+xqtum4BnDwh0mkOROaBHwnoXW8DBEbskj
   yxiZvn41A6datIvHfHOnMqSdXUoz5WptBEnCnqo2lqx6jzXFvihLJGmsW
   lwgBgpNY3V5xGeA3mlN++VJ8IQp3fogTJdDDfwVNwrcwthp+PNBMpnrkV
   03BMZLE1z1PKieKd4z6GPXjjGqTe7gGQ90vTPECEydDvr9KQNk4tk81SX
   6AIpUBU/CfcBLD0hQjp2h+I4PBItn+4dOoclAb+u3H7f/4CmN+5amYqgW
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10307"; a="260366446"
X-IronPort-AV: E=Sophos;i="5.90,235,1643702400"; 
   d="scan'208";a="260366446"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 22:43:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,235,1643702400"; 
   d="scan'208";a="523857444"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.135])
  by orsmga006.jf.intel.com with ESMTP; 04 Apr 2022 22:43:06 -0700
Date:   Tue, 5 Apr 2022 13:35:47 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Nava kishore Manne <nava.manne@xilinx.com>
Cc:     mdf@kernel.org, hao.wu@intel.com, trix@redhat.com,
        michal.simek@xilinx.com, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        git@xilinx.com
Subject: Re: [PATCH v3 5/5] fpga: fpga-region: Add missing kernel-doc
 description
Message-ID: <20220405053547.GA249845@yilunxu-OptiPlex-7050>
References: <20220403051641.3867610-1-nava.manne@xilinx.com>
 <20220403051641.3867610-6-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220403051641.3867610-6-nava.manne@xilinx.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Sun, Apr 03, 2022 at 10:46:41AM +0530, Nava kishore Manne wrote:
> Fixed the warnings: No description found for return value of 'xxx'

The commit message is not clear. There are descriptions for some
functions, but not in right format.

Thanks,
Yilun

> 
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> ---
> Changes for v2:
>                 -Replaced s/@return:/Return:/
> Changes for v3:
>                -Updated commit description.
> 
>  drivers/fpga/of-fpga-region.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/fpga/of-fpga-region.c b/drivers/fpga/of-fpga-region.c
> index 50b83057c048..9e330a2c0a1b 100644
> --- a/drivers/fpga/of-fpga-region.c
> +++ b/drivers/fpga/of-fpga-region.c
> @@ -28,7 +28,7 @@ MODULE_DEVICE_TABLE(of, fpga_region_of_match);
>   *
>   * Caller will need to put_device(&region->dev) when done.
>   *
> - * Returns FPGA Region struct or NULL
> + * Return: FPGA Region struct or NULL
>   */
>  static struct fpga_region *of_fpga_region_find(struct device_node *np)
>  {
> @@ -80,7 +80,7 @@ static struct fpga_manager *of_fpga_region_get_mgr(struct device_node *np)
>   * Caller should call fpga_bridges_put(&region->bridge_list) when
>   * done with the bridges.
>   *
> - * Return 0 for success (even if there are no bridges specified)
> + * Return: 0 for success (even if there are no bridges specified)
>   * or -EBUSY if any of the bridges are in use.
>   */
>  static int of_fpga_region_get_bridges(struct fpga_region *region)
> @@ -139,13 +139,13 @@ static int of_fpga_region_get_bridges(struct fpga_region *region)
>  }
>  
>  /**
> - * child_regions_with_firmware
> + * child_regions_with_firmware - Used to check the child region info.
>   * @overlay: device node of the overlay
>   *
>   * If the overlay adds child FPGA regions, they are not allowed to have
>   * firmware-name property.
>   *
> - * Return 0 for OK or -EINVAL if child FPGA region adds firmware-name.
> + * Return: 0 for OK or -EINVAL if child FPGA region adds firmware-name.
>   */
>  static int child_regions_with_firmware(struct device_node *overlay)
>  {
> @@ -184,7 +184,7 @@ static int child_regions_with_firmware(struct device_node *overlay)
>   * Given an overlay applied to an FPGA region, parse the FPGA image specific
>   * info in the overlay and do some checking.
>   *
> - * Returns:
> + * Return:
>   *   NULL if overlay doesn't direct us to program the FPGA.
>   *   fpga_image_info struct if there is an image to program.
>   *   error code for invalid overlay.
> @@ -279,7 +279,7 @@ static struct fpga_image_info *of_fpga_region_parse_ov(
>   * If the checks fail, overlay is rejected and does not get added to the
>   * live tree.
>   *
> - * Returns 0 for success or negative error code for failure.
> + * Return: 0 for success or negative error code for failure.
>   */
>  static int of_fpga_region_notify_pre_apply(struct fpga_region *region,
>  					   struct of_overlay_notify_data *nd)
> @@ -339,7 +339,7 @@ static void of_fpga_region_notify_post_remove(struct fpga_region *region,
>   * This notifier handles programming an FPGA when a "firmware-name" property is
>   * added to an fpga-region.
>   *
> - * Returns NOTIFY_OK or error if FPGA programming fails.
> + * Return: NOTIFY_OK or error if FPGA programming fails.
>   */
>  static int of_fpga_region_notify(struct notifier_block *nb,
>  				 unsigned long action, void *arg)
> @@ -446,6 +446,8 @@ static struct platform_driver of_fpga_region_driver = {
>  /**
>   * of_fpga_region_init - init function for fpga_region class
>   * Creates the fpga_region class and registers a reconfig notifier.
> + *
> + * Return: 0 on success, negative error code otherwise.
>   */
>  static int __init of_fpga_region_init(void)
>  {
> -- 
> 2.25.1

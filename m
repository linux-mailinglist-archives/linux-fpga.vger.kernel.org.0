Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 845235037A2
	for <lists+linux-fpga@lfdr.de>; Sat, 16 Apr 2022 18:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232611AbiDPQvd (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 16 Apr 2022 12:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbiDPQvc (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 16 Apr 2022 12:51:32 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E833EBBF;
        Sat, 16 Apr 2022 09:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650127739; x=1681663739;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FRSApa93qf26an3ztDlnFEZ03B94VG7Q1j0FckBB3sg=;
  b=FLTK+EBh0hnDgaPERHN3s1/Ag8/jH6m/E6qvhS1GHixMzWORCPsfVauH
   6Y8/vYLgtgQ2rEGM9GVhozBWHSQxHtIT8wOkb6wKi+BsnuRQZLo6+GY5B
   8pAvzUYJ342mixpDzx1zomOpoCjbqQVqfc0/yy/59rSFZERlqtPcTSn1i
   vv7bj+xZXtry66oN6SdR+GajKWOihGqxAT0HLjCbBtX6ntMHBfyPstev1
   MZD0m95VZhRVbUYQ4UDDbgoBLn2iG1yUQoz+uTlxpvhSG6YkwFoRFAESh
   5whAm2mbQ6e5N+hSnVHkpoEaRw0/NcKrtkOPVcYTgTUe14BcVY6LW0Tgs
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10318"; a="349756409"
X-IronPort-AV: E=Sophos;i="5.90,264,1643702400"; 
   d="scan'208";a="349756409"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2022 09:48:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,264,1643702400"; 
   d="scan'208";a="574878515"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.135])
  by orsmga008.jf.intel.com with ESMTP; 16 Apr 2022 09:48:54 -0700
Date:   Sun, 17 Apr 2022 00:41:23 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Nava kishore Manne <nava.manne@xilinx.com>
Cc:     mdf@kernel.org, hao.wu@intel.com, trix@redhat.com,
        michal.simek@xilinx.com, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        git@xilinx.com
Subject: Re: [PATCH v4 5/5] fpga: fpga-region: fix kernel-doc formatting
 issues
Message-ID: <20220416164123.GE301222@yilunxu-OptiPlex-7050>
References: <20220416133719.3382895-1-nava.manne@xilinx.com>
 <20220416133719.3382895-6-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220416133719.3382895-6-nava.manne@xilinx.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Sat, Apr 16, 2022 at 07:07:19PM +0530, Nava kishore Manne wrote:
> To fix below kernel-doc warnings this patch does the following
> ->Replaced Return\Returns with 'Return:' keyword.
> ->Added 'Return' description For __init of_fpga_region_init()' API.
> ->Added description for 'child_regions_with_firmware()' API.
> 
> warning: No description found for return value of
> 'of_fpga_region_find'.
> warning: No description found for return value of
> 'of_fpga_region_get_bridges'.
> warning: missing initial short description on line:
> * child_regions_with_firmware
> warning: No description found for return value of
> 'child_regions_with_firmware'.
> warning: No description found for return value of
> 'of_fpga_region_notify_pre_apply'.
> warning: No description found for return value of
> 'of_fpga_region_notify'.
> warning: No description found for return value of
> 'of_fpga_region_init'.
> 
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>

Acked-by: Xu Yilun <yilun.xu@intel.com>

> ---
> Changes for v2:
>                 -Replaced s/@return:/Return:/
> Changes for v3:
>                -Updated commit description.
> Changes for v4:
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

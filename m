Return-Path: <linux-fpga+bounces-1229-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E158AC9EF4
	for <lists+linux-fpga@lfdr.de>; Sun,  1 Jun 2025 17:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B10F189482F
	for <lists+linux-fpga@lfdr.de>; Sun,  1 Jun 2025 15:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703831DED5C;
	Sun,  1 Jun 2025 15:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jhLElKtj"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406D12DCC09;
	Sun,  1 Jun 2025 15:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748790500; cv=none; b=igfQiUQ2ciUEdLRX/BbDYIwRWGLvkr/kXdekbSNj7+4dipeuH5vVOnOLgcygFomwQhyAxn+T8qNrmcwCAbI2UeRNa4nvSJ6uMucLq6DQ1WZywbrwRWFBy53bhIYFDWdwKAKa0m7ecmiNxG5tjOYls7cFgACJ2yAHh5BR+IOCoOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748790500; c=relaxed/simple;
	bh=XcjtFPcb6aPylZHVSaNqWbVqbXWvaGDNoEwVoVyk6uw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iHePdsI65zv2BCygfQYT4x1/wgQ7a7bSRKTi1Cf9f7WS9v1Q7lJ6WY2VKAzqRe5HSexLY3do0v8/4YdBiDkRNr0zzo9gzf1sZy0RmhFUZ38IS0RJ78wDHKLclCgbgFQSSTjpjxljGpd87aVb2SsaFac9QQfnJtKsGg7RWnm3v2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jhLElKtj; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748790498; x=1780326498;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XcjtFPcb6aPylZHVSaNqWbVqbXWvaGDNoEwVoVyk6uw=;
  b=jhLElKtjS9ur4Nik1CZFuXTXLxeCOyloDeAenfq8B5V2dENogVdZNWqX
   zCKD+S9XJ8c2/VEihYdocw3UkWeGG56dULZZ3WBN8sw4P/WgNnf6RVmVc
   tJ6JVaECCYVLqWfZBOSM+cPdcw7eM8rPRQvyCdwtz+RJ/BqmQXJ/NsUrG
   4FRthAXNaZaJ23hc89Y9Xl9JNCbwHmg7ODHDhUXX2t+pjJ3m2XRA55WoE
   YrGa9MYqQ+FmATgLBhSSLaW7N9PDa2H0Rfv2rmWIGls75Ld2uZoe4H3CK
   oTkYJzRvnQsGs1ebOUSCYkb7qTRc5bDg7GnOIc/SWs7jE0plpLeCLmYgD
   A==;
X-CSE-ConnectionGUID: DcPYil3SQ+yiUDGn3lifXg==
X-CSE-MsgGUID: +v7rYJIcTgasEoE+eB0DfA==
X-IronPort-AV: E=McAfee;i="6700,10204,11450"; a="49936920"
X-IronPort-AV: E=Sophos;i="6.16,201,1744095600"; 
   d="scan'208";a="49936920"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2025 08:08:17 -0700
X-CSE-ConnectionGUID: MKA503UtTzeupO4TU3swVw==
X-CSE-MsgGUID: fXDRWmWlQoai33kFy7Mm+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,201,1744095600"; 
   d="scan'208";a="149107716"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa003.jf.intel.com with ESMTP; 01 Jun 2025 08:08:09 -0700
Date: Sun, 1 Jun 2025 23:01:36 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Nava kishore Manne <nava.kishore.manne@amd.com>
Cc: mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com, trix@redhat.com,
	robh@kernel.org, saravanak@google.com, linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	git@amd.com
Subject: Re: [RFC v3 1/1] fpga-region: Introduce ConfigFS interface for
 runtime FPGA configuration
Message-ID: <aDxrUD9YjnFkWy3M@yilunxu-OptiPlex-7050>
References: <20250519033950.2669858-1-nava.kishore.manne@amd.com>
 <20250519033950.2669858-2-nava.kishore.manne@amd.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250519033950.2669858-2-nava.kishore.manne@amd.com>

On Mon, May 19, 2025 at 09:09:37AM +0530, Nava kishore Manne wrote:
> Introduces an ConfigFS interface within the fpga-region subsystem,
> providing a generic and standardized mechanism for configuring (or)
> reprogramming FPGAs during runtime. The newly added interface supports
> both OF (Open Firmware) and non-OF devices, leveraging vendor-specific
> callbacks (e.g., pre_config, post_config, removal, and status) to
> accommodate a wide range of device specific configurations.
> 
> The ConfigFS interface ensures compatibility with both OF and non-OF
> devices, allowing for seamless FPGA reprogramming across diverse
> platforms.
> 
> Vendor-specific callbacks are integrated into the interface, enabling
> custom FPGA pre_config, post_config, removal, and status reporting
> mechanisms, ensuring flexibility for vendor implementations.
> 
> This solution enhances FPGA runtime management, supporting various device
> types and vendors, while ensuring compatibility with the current FPGA
> configuration flow.
> 
> Signed-off-by: Nava kishore Manne <nava.kishore.manne@amd.com>
> ---
> Changes for v3:
>  - As discussed with Yilun, the implementation continues to use a callback-based
>  approach to seamlessly support both OF (Open Firmware) and non-OF devices via
>  vendor-specific hooks. Additionally, the earlier IOCTL-based interface has been
>  replaced with a more suitable ConfigFS-based mechanism to enable runtime FPGA
>  configuration.
> 
> Changes for v2:
>  - As discussed with Yilun, the implementation has been modified to utilize a
>  callback approach, enabling seamless handling of both OF and non-OF devices.
> 
>  - As suggested by Yilun in the POC code, we have moved away from using  void *args
>  as a parameter for ICOTL inputs to obtain the required user inputs. Instead, we are
>  utilizing the fpga_region_config_info structure to gather user inputs. Currently,
>  this structure is implemented to support only OF devices, but we intend to extend
>  it by incorporating new members to accommodate non-OF devices in the future.
> 
>  drivers/fpga/fpga-region.c       | 196 +++++++++++++
>  drivers/fpga/of-fpga-region.c    | 474 +++++++++++++++++--------------
>  include/linux/fpga/fpga-region.h |  34 +++
>  3 files changed, 493 insertions(+), 211 deletions(-)
> 
> diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
> index 753cd142503e..d583fc22955b 100644
> --- a/drivers/fpga/fpga-region.c
> +++ b/drivers/fpga/fpga-region.c
> @@ -5,6 +5,7 @@
>   *  Copyright (C) 2013-2016 Altera Corporation
>   *  Copyright (C) 2017 Intel Corporation
>   */
> +#include <linux/configfs.h>
>  #include <linux/fpga/fpga-bridge.h>
>  #include <linux/fpga/fpga-mgr.h>
>  #include <linux/fpga/fpga-region.h>
> @@ -180,6 +181,158 @@ static struct attribute *fpga_region_attrs[] = {
>  };
>  ATTRIBUTE_GROUPS(fpga_region);
>  
> +static struct fpga_region *item_to_fpga_region(struct config_item *item)
> +{
> +	return container_of(to_configfs_subsystem(to_config_group(item)),
> +			    struct fpga_region, subsys);
> +}
> +
> +/**
> + * fpga_region_image_store - Set firmware image name for FPGA region
> + * This function sets the firmware image name for an FPGA region through configfs.
> + * @item: Configfs item representing the FPGA region
> + * @buf: Input buffer containing the firmware image name
> + * @count: Size of the input buffer
> + *
> + * Return: Number of bytes written on success, or negative errno on failure.
> + */
> +static ssize_t fpga_region_image_store(struct config_item *item, const char *buf, size_t count)
> +{
> +	struct fpga_region *region = item_to_fpga_region(item);
> +	struct device *dev = &region->dev;
> +	struct fpga_image_info *info;
> +	char firmware_name[NAME_MAX];
> +	char *s;
> +
> +	if (region->info) {
> +		dev_err(dev, "Region already has already configured.\n");
> +		return -EINVAL;
> +	}
> +
> +	info = fpga_image_info_alloc(dev);
> +	if (!info)
> +		return -ENOMEM;
> +
> +	/* copy to path buffer (and make sure it's always zero terminated */
> +	count = snprintf(firmware_name, sizeof(firmware_name) - 1, "%s", buf);
> +	firmware_name[sizeof(firmware_name) - 1] = '\0';
> +
> +	/* strip trailing newlines */
> +	s = firmware_name + strlen(firmware_name);
> +	while (s > firmware_name && *--s == '\n')
> +		*s = '\0';
> +
> +	region->firmware_name = devm_kstrdup(dev, firmware_name, GFP_KERNEL);
> +	if (!region->firmware_name)
> +		return -ENOMEM;
> +
> +	region->info = info;
> +
> +	return count;
> +}
> +
> +/**
> + * fpga_region_config_store - Trigger FPGA configuration via configfs
> + * @item: Configfs item representing the FPGA region
> + * @buf: Input buffer containing the configuration command (expects "1" to program, "0" to remove)
> + * @count: Size of the input buffer
> + *
> + * If the input is "1", this function performs:
> + *   1. region_pre_config() (if defined)

Please define explicit workflow, and explicit expectation for each
callback, or this framework makes no sense. From your of-fpga-region
implementation, seems pre_config() means "parse image", post_config()
means "populate devices".

> + *   2. Bitstream programming via fpga_region_program_fpga() (unless external config flag is set)
> + *   3. region_post_config() (if defined)
> + *
> + * If the input is "0", it triggers region_remove() (if defined).
> + *
> + * Return: Number of bytes processed on success, or negative errno on failure.

Please put the uAPI description in Documentation/ABI/testing. Then we
could know the file path layout from userspace POV.

> + */
> +static ssize_t fpga_region_config_store(struct config_item *item,
> +					const char *buf, size_t count)
> +{
> +	struct fpga_region *region = item_to_fpga_region(item);
> +	int config_value, ret = 0;
> +
> +	/* Parse input: must be "0" or "1" */
> +	if (kstrtoint(buf, 10, &config_value) || (config_value != 0 && config_value != 1))
> +		return -EINVAL;
> +
> +	/* Ensure fpga_image_info is available */
> +	if (!region->info)
> +		return -EINVAL;
> +
> +	if (config_value == 1) {
> +		/* Pre-config */
> +		if (region->region_ops->region_pre_config) {
> +			ret = region->region_ops->region_pre_config(region);
> +			if (ret)
> +				return ret;
> +		}
> +
> +		/* Program bitstream if not external */
> +		if (!(region->info->flags & FPGA_MGR_EXTERNAL_CONFIG)) {
> +			ret = fpga_region_program_fpga(region);
> +			if (ret)
> +				return ret;
> +		}
> +
> +		/* Post-config */
> +		if (region->region_ops->region_post_config) {
> +			ret = region->region_ops->region_post_config(region);
> +			if (ret)
> +				return ret;
> +		}
> +
> +	} else {
> +		/* Remove configuration */
> +		if (region->region_ops->region_remove) {
> +			ret = region->region_ops->region_remove(region);
> +			if (ret)
> +				return ret;
> +		}
> +	}
> +
> +	return count;
> +}
> +
> +/* Define Attributes */
> +CONFIGFS_ATTR_WO(fpga_region_, image);
> +CONFIGFS_ATTR_WO(fpga_region_, config);
> +
> +/* Attribute List */
> +static struct configfs_attribute *fpga_region_config_attrs[] = {
> +	&fpga_region_attr_image,
> +	&fpga_region_attr_config,
> +	NULL,
> +};
> +
> +/* ConfigFS Item Type */
> +static const struct config_item_type fpga_region_item_type = {
> +	.ct_attrs = fpga_region_config_attrs,
> +	.ct_owner = THIS_MODULE,
> +};

I think this is still the sysfs methodology. My understanding from configfs.rst
is, use userspace interfaces to control the lifecycle of a kernel object.

Now for existing kernel reprogramming flow, the image object for
fpga_region is the struct fpga_image_info. We need to associate the
struct with a config_item: alloc the struct fpga_image_info instance by
mkdir, expose necessary fields (enable_timeout_us, disable_timeout_us,
firmware_name, and the most important for of-fpga-region - overlay blob ...)
for user to fill/query via configfs attributes. And finally use a writeable
attribute (e.g. load) to trigger fpga_region_program_fpga().

> +
> +static int fpga_region_configfs_register(struct fpga_region *region)
> +{
> +	struct configfs_subsystem *subsys = &region->subsys;
> +
> +	snprintf(subsys->su_group.cg_item.ci_namebuf,
> +		 sizeof(subsys->su_group.cg_item.ci_namebuf),
> +		 "%s", dev_name(&region->dev));
> +
> +	subsys->su_group.cg_item.ci_type = &fpga_region_item_type;
> +
> +	config_group_init(&subsys->su_group);

I think we'd better make a root "fpga_region" group to include all
regions.

> +
> +	return configfs_register_subsystem(subsys);
> +}
> +
> +static void fpga_region_configfs_unregister(struct fpga_region *region)
> +{
> +	struct configfs_subsystem *subsys = &region->subsys;
> +
> +	configfs_unregister_subsystem(subsys);
> +}

[...]

>  static void __exit of_fpga_region_exit(void)
>  {
>  	platform_driver_unregister(&of_fpga_region_driver);
> -	of_overlay_notifier_unregister(&fpga_region_of_nb);
>  }

Sorry, it is really hard to review if all the changes are mess up
together. Maybe I'll revisit it later. But next time please split
the patches to produce some readable diff.

Thanks,
Yilun


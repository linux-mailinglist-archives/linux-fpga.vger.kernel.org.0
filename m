Return-Path: <linux-fpga+bounces-943-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BEAE79D1F26
	for <lists+linux-fpga@lfdr.de>; Tue, 19 Nov 2024 05:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FA38B22026
	for <lists+linux-fpga@lfdr.de>; Tue, 19 Nov 2024 04:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C42946F;
	Tue, 19 Nov 2024 04:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H4rmwVXg"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5EB20E6;
	Tue, 19 Nov 2024 04:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731989856; cv=none; b=Pfuzfae0899UDWnvZKdnfG7ZP5qPDDtKQJsRj3bvQ6KgxdvM1DgU+H8A9hkeSSArDUTm9rrlkbRBgruusRShm8qMuNkAkonPMDdbjImYJ9BAyEagrDu01Gtw0RvS1CZcdxdk59DjHFgHuKyCRFxCqj1+4jeHae++FkSYhPOK0Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731989856; c=relaxed/simple;
	bh=FWdkW510l0RsBPZbuKOTZJFipSox6oLSZFzGXKWpPSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r7oCZQZnMGn+MXEx1tYZKde9Xf8Y3OI38zipe/sQQ46OXSpf1n7T6pUaUfPhIKJgTA4tbJlSz88PJfsNNckc7A6PEkTuc9ZEYlwrK7Fk/mFqiRa4qlNT/Znjj01zCyrK/0KwH/bCWUpd1L4CmjJL5UVbd/pO7pxixA7OeG7nFHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H4rmwVXg; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731989854; x=1763525854;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FWdkW510l0RsBPZbuKOTZJFipSox6oLSZFzGXKWpPSc=;
  b=H4rmwVXgVQ3OZQomuRQ83x/I88OFdw1xlnm7btOPp0pAHms8CkMIhE7f
   1ASTxt+rxqNFGqJPxF2J6XQ0IP+L0zKNC/Linn7RtYRrRQsQmtaV22d73
   PFCqPi9cDl7WJz6RxDDqGKUa9JQV9myo0UgE95oMsqsR+Qs84XfRYxzYV
   8/MCbbilQMiEwc3BNAokBS8zl+b6mHIPzKL3T3sGM/E8ZKUO2q/toA00V
   ASRY1nqW327Ql05zyO7HPZQVZHocs7+ETFSkLX7VtViyJNCEug83ohWap
   JyQGc9503r4BR3Lm5g/iIq/oY+yYy7mNggxhb6sfsnlwOmXqgnh2JtC2t
   Q==;
X-CSE-ConnectionGUID: lY0r7xBRTBGvsIFhMka7aQ==
X-CSE-MsgGUID: sPF91OEwRtWRrbdvE/4n6A==
X-IronPort-AV: E=McAfee;i="6700,10204,11260"; a="43042305"
X-IronPort-AV: E=Sophos;i="6.12,165,1728975600"; 
   d="scan'208";a="43042305"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2024 20:17:33 -0800
X-CSE-ConnectionGUID: 76MbDn9nT22KcyM3iua/Lw==
X-CSE-MsgGUID: xvKOkE9kQ6yGEjKZjgEB4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,165,1728975600"; 
   d="scan'208";a="93502782"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa003.fm.intel.com with ESMTP; 18 Nov 2024 20:17:30 -0800
Date: Tue, 19 Nov 2024 12:14:37 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Nava kishore Manne <nava.kishore.manne@amd.com>
Cc: git@amd.com, mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
	trix@redhat.com, robh@kernel.org, saravanak@google.com,
	linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [RFC v2 1/1] fpga-region: Add generic IOCTL interface for
 runtime FPGA programming
Message-ID: <ZzwQrYeWVF6cRtgA@yilunxu-OptiPlex-7050>
References: <20241029091734.3288005-1-nava.kishore.manne@amd.com>
 <20241029091734.3288005-2-nava.kishore.manne@amd.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029091734.3288005-2-nava.kishore.manne@amd.com>

On Tue, Oct 29, 2024 at 02:47:34PM +0530, Nava kishore Manne wrote:
> Introduces an IOCTL interface within the fpga-region subsystem,
> providing a generic and standardized mechanism for configuring (or)
> reprogramming FPGAs during runtime. The newly added interface supports
> both OF (Open Firmware) and non-OF devices, leveraging vendor-specific
> callbacks (e.g., configuration + enumeration, removal, and status) to
> accommodate a wide range of device specific configurations.
> 
> The IOCTL interface ensures compatibility with both OF and non-OF
> devices, allowing for seamless FPGA reprogramming across diverse
> platforms.
> 
> Vendor-specific callbacks are integrated into the interface, enabling
> custom FPGA configuration + enumeration, removal, and status reporting
> mechanisms, ensuring flexibility for vendor implementations.
> 
> This solution enhances FPGA runtime management, supporting various device
> types and vendors, while ensuring compatibility with the current FPGA
> configuration flow.
> 
> Signed-off-by: Nava kishore Manne <nava.kishore.manne@amd.com>
> ---
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
>  drivers/fpga/fpga-region.c       | 110 +++++++++++++++++++++++++++++++
>  drivers/fpga/of-fpga-region.c    |  91 ++++++++++++++++++++++++-
>  include/linux/fpga/fpga-region.h |  32 +++++++++
>  include/uapi/linux/fpga-region.h |  51 ++++++++++++++
>  4 files changed, 283 insertions(+), 1 deletion(-)
>  create mode 100644 include/uapi/linux/fpga-region.h
> 
> diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
> index 753cd142503e..c6bea3c99a69 100644
> --- a/drivers/fpga/fpga-region.c
> +++ b/drivers/fpga/fpga-region.c
> @@ -8,6 +8,7 @@
>  #include <linux/fpga/fpga-bridge.h>
>  #include <linux/fpga/fpga-mgr.h>
>  #include <linux/fpga/fpga-region.h>
> +#include <linux/fpga-region.h>
>  #include <linux/idr.h>
>  #include <linux/kernel.h>
>  #include <linux/list.h>
> @@ -180,6 +181,67 @@ static struct attribute *fpga_region_attrs[] = {
>  };
>  ATTRIBUTE_GROUPS(fpga_region);
>  
> +static int fpga_region_device_open(struct inode *inode, struct file *file)
> +{
> +	struct miscdevice *miscdev = file->private_data;
> +	struct fpga_region *region = container_of(miscdev, struct fpga_region, miscdev);
> +
> +	file->private_data = region;
> +
> +	return 0;
> +}
> +
> +static int fpga_region_device_release(struct inode *inode, struct file *file)
> +{
> +	return 0;
> +}
> +
> +static long fpga_region_device_ioctl(struct file *file, unsigned int cmd,
> +				     unsigned long arg)
> +{
> +	int err;
> +	void __user *argp = (void __user *)arg;
> +	struct fpga_region_config_info config_info;
> +	struct fpga_region *region =  (struct fpga_region *)(file->private_data);
> +
> +	switch (cmd) {
> +	case FPGA_REGION_IOCTL_LOAD:
> +		if (copy_from_user(&config_info, argp, sizeof(struct fpga_region_config_info)))
> +			return -EFAULT;
> +
> +		err = region->region_ops->region_config_enumeration(region, &config_info);
> +
> +		break;
> +	case FPGA_REGION_IOCTL_REMOVE:
> +		if (copy_from_user(&config_info, argp, sizeof(struct fpga_region_config_info)))
> +			return -EFAULT;
> +
> +		err = region->region_ops->region_remove(region, &config_info);
> +
> +		break;
> +	case FPGA_REGION_IOCTL_STATUS:
> +		unsigned int status;
> +
> +		status = region->region_ops->region_status(region);
> +
> +		if (copy_to_user((void __user *)arg, &status, sizeof(status)))
> +			err = -EFAULT;
> +		break;
> +	default:
> +		err = -ENOTTY;
> +	}
> +
> +	return err;
> +}
> +
> +static const struct file_operations fpga_region_fops = {
> +	.owner		= THIS_MODULE,
> +	.open		= fpga_region_device_open,
> +	.release	= fpga_region_device_release,
> +	.unlocked_ioctl	= fpga_region_device_ioctl,
> +	.compat_ioctl	= fpga_region_device_ioctl,
> +};
> +
>  /**
>   * __fpga_region_register_full - create and register an FPGA Region device
>   * @parent: device parent
> @@ -229,8 +291,21 @@ __fpga_region_register_full(struct device *parent, const struct fpga_region_info
>  	if (ret)
>  		goto err_remove;
>  
> +	if (info->region_ops) {
> +		region->region_ops = info->region_ops;
> +		region->miscdev.minor = MISC_DYNAMIC_MINOR;
> +		region->miscdev.name = kobject_name(&region->dev.kobj);
> +		region->miscdev.fops = &fpga_region_fops;
> +		ret = misc_register(&region->miscdev);
> +		if (ret) {
> +			pr_err("fpga-region: failed to register misc device.\n");
> +			goto err_remove;
> +		}
> +	}
> +
>  	ret = device_register(&region->dev);
>  	if (ret) {
> +		misc_deregister(&region->miscdev);
>  		put_device(&region->dev);
>  		return ERR_PTR(ret);
>  	}
> @@ -272,6 +347,40 @@ __fpga_region_register(struct device *parent, struct fpga_manager *mgr,
>  }
>  EXPORT_SYMBOL_GPL(__fpga_region_register);
>  
> +/**
> + * __fpga_region_register_with_ops - create and register an FPGA Region device
> + * with user interface call-backs.
> + * @parent: device parent
> + * @mgr: manager that programs this region
> + * @region_ops: ops for low level FPGA region for device enumeration/removal
> + * @priv: of-fpga-region private data
> + * @get_bridges: optional function to get bridges to a list
> + * @owner: module containing the get_bridges function
> + *
> + * This simple version of the register function should be sufficient for most users.
> + * The fpga_region_register_full() function is available for users that need to
> + * pass additional, optional parameters.
> + *
> + * Return: struct fpga_region or ERR_PTR()
> + */
> +struct fpga_region *
> +__fpga_region_register_with_ops(struct device *parent, struct fpga_manager *mgr,
> +				const struct fpga_region_ops *region_ops,
> +				void *priv,
> +				int (*get_bridges)(struct fpga_region *),
> +				struct module *owner)
> +{
> +	struct fpga_region_info info = { 0 };
> +
> +	info.mgr = mgr;
> +	info.priv = priv;
> +	info.get_bridges = get_bridges;
> +	info.region_ops = region_ops;
> +
> +	return __fpga_region_register_full(parent, &info, owner);
> +}
> +EXPORT_SYMBOL_GPL(__fpga_region_register_with_ops);
> +
>  /**
>   * fpga_region_unregister - unregister an FPGA region
>   * @region: FPGA region
> @@ -280,6 +389,7 @@ EXPORT_SYMBOL_GPL(__fpga_region_register);
>   */
>  void fpga_region_unregister(struct fpga_region *region)
>  {
> +	misc_deregister(&region->miscdev);
>  	device_unregister(&region->dev);
>  }
>  EXPORT_SYMBOL_GPL(fpga_region_unregister);
> diff --git a/drivers/fpga/of-fpga-region.c b/drivers/fpga/of-fpga-region.c
> index 8526a5a86f0c..63fe56e0466f 100644
> --- a/drivers/fpga/of-fpga-region.c
> +++ b/drivers/fpga/of-fpga-region.c
> @@ -8,6 +8,8 @@
>  #include <linux/fpga/fpga-bridge.h>
>  #include <linux/fpga/fpga-mgr.h>
>  #include <linux/fpga/fpga-region.h>
> +#include <linux/firmware.h>
> +#include <linux/fpga-region.h>
>  #include <linux/idr.h>
>  #include <linux/kernel.h>
>  #include <linux/list.h>
> @@ -18,6 +20,20 @@
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
>  
> +/**
> + * struct of_fpga_region_priv - Private data structure
> + * image.
> + * @dev:	Device data structure
> + * @fw:		firmware of coeff table.
> + * @path:	path of FPGA overlay image firmware file.
> + * @ovcs_id:	overlay changeset id.
> + */
> +struct of_fpga_region_priv {
> +	struct device *dev;
> +	const struct firmware *fw;
> +	int ovcs_id;
> +};
> +
>  static const struct of_device_id fpga_region_of_match[] = {
>  	{ .compatible = "fpga-region", },
>  	{},
> @@ -394,20 +410,93 @@ static struct notifier_block fpga_region_of_nb = {
>  	.notifier_call = of_fpga_region_notify,
>  };
>  
> +static int of_fpga_region_status(struct fpga_region *region)
> +{
> +	struct of_fpga_region_priv *ovcs = region->priv;
> +
> +	if (ovcs->ovcs_id)
> +		return FPGA_REGION_HAS_PL;

Could you help specify what is PL?

> +
> +	return FPGA_REGION_EMPTY;
> +}
> +
> +static int of_fpga_region_config_enumeration(struct fpga_region *region,
> +					     struct fpga_region_config_info *config_info)
> +{
> +	struct of_fpga_region_priv *ovcs = region->priv;
> +	int err;
> +
> +	/* if it's set do not allow changes */
> +	if (ovcs->ovcs_id)
> +		return -EPERM;
> +
> +	err = request_firmware(&ovcs->fw, config_info->firmware_name, NULL);
> +	if (err != 0)
> +		goto out_err;
> +
> +	err = of_overlay_fdt_apply((void *)ovcs->fw->data, ovcs->fw->size,
> +				   &ovcs->ovcs_id, NULL);
> +	if (err < 0) {
> +		pr_err("%s: Failed to create overlay (err=%d)\n",
> +		       __func__, err);
> +		release_firmware(ovcs->fw);
> +		goto out_err;
> +	}
> +
> +	return 0;
> +
> +out_err:
> +	ovcs->ovcs_id = 0;
> +	ovcs->fw = NULL;
> +
> +	return err;
> +}
> +
> +static int of_fpga_region_config_remove(struct fpga_region *region,
> +					struct fpga_region_config_info *config_info)
> +{
> +	struct of_fpga_region_priv *ovcs = region->priv;
> +
> +	if (!ovcs->ovcs_id)
> +		return -EPERM;
> +
> +	of_overlay_remove(&ovcs->ovcs_id);
> +	release_firmware(ovcs->fw);
> +
> +	ovcs->ovcs_id = 0;
> +	ovcs->fw = NULL;
> +
> +	return 0;
> +}
> +
> +static const struct fpga_region_ops region_ops = {
> +	.region_status = of_fpga_region_status,
> +	.region_config_enumeration = of_fpga_region_config_enumeration,
> +	.region_remove = of_fpga_region_config_remove,
> +};
> +
>  static int of_fpga_region_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct device_node *np = dev->of_node;
> +	struct of_fpga_region_priv *priv;
>  	struct fpga_region *region;
>  	struct fpga_manager *mgr;
>  	int ret;
>  
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->dev = dev;
> +
>  	/* Find the FPGA mgr specified by region or parent region. */
>  	mgr = of_fpga_region_get_mgr(np);
>  	if (IS_ERR(mgr))
>  		return -EPROBE_DEFER;
>  
> -	region = fpga_region_register(dev, mgr, of_fpga_region_get_bridges);
> +	region = fpga_region_register_with_ops(dev, mgr, &region_ops, priv,
> +					       of_fpga_region_get_bridges);
>  	if (IS_ERR(region)) {
>  		ret = PTR_ERR(region);
>  		goto eprobe_mgr_put;
> diff --git a/include/linux/fpga/fpga-region.h b/include/linux/fpga/fpga-region.h
> index 5fbc05fe70a6..3a3ba6dbb5e1 100644
> --- a/include/linux/fpga/fpga-region.h
> +++ b/include/linux/fpga/fpga-region.h
> @@ -6,15 +6,35 @@
>  #include <linux/device.h>
>  #include <linux/fpga/fpga-mgr.h>
>  #include <linux/fpga/fpga-bridge.h>
> +#include <linux/fpga-region.h>
> +#include <linux/miscdevice.h>
>  
>  struct fpga_region;
>  
> +/**
> + * struct fpga_region_ops - ops for low level FPGA region ops for device
> + * enumeration/removal
> + * @region_status: returns the FPGA region status
> + * @region_config_enumeration: Configure and enumerate the FPGA region.
> + * @region_remove: Remove all devices within the FPGA region
> + * (which are added as part of the enumeration).
> + */
> +struct fpga_region_ops {
> +	int (*region_status)(struct fpga_region *region);
> +	int (*region_config_enumeration)(struct fpga_region *region,
> +					 struct fpga_region_config_info *config_info);

My current concern is still about this combined API, it just offloads
all work to low level, but we have some common flows. That's why we
introduce a common FPGA reprograming API.

I didn't see issue about the vendor specific pre configuration. They
are generally needed to initialize the struct fpga_image_info, which
is a common structure for fpga_region_program_fpga().

For port IDs(AFU) inputs for DFL, I think it could also be changed
(Don't have to be implemented in this patchset). Previously DFL
provides an uAPI for the whole device, so it needs a port_id input to
position which fpga_region within the device for programming. But now,
we are introducing a per fpga_region programming interface, IIUC port_id
should not be needed anymore.

The combined API is truly simple for leveraging the existing
of-fpga-region overlay apply mechanism. But IMHO that flow doesn't fit
our new uAPI well. That flow is to adapt the generic configfs overlay
interface, which comes to a dead end as you mentioned.

My gut feeling for the generic programing flow should be:

 1. Program the image to HW.
 2. Enumerate the programmed image (apply the DT overlay)

Why we have to:

 1. Start enumeration.
 2. On pre enumeration, programe the image.
 3. Real enumeration.

Thanks,
Yilun

> +	int (*region_remove)(struct fpga_region *region,
> +			     struct fpga_region_config_info *config_info);
> +};
> +
>  /**
>   * struct fpga_region_info - collection of parameters an FPGA Region
>   * @mgr: fpga region manager
>   * @compat_id: FPGA region id for compatibility check.
>   * @priv: fpga region private data
>   * @get_bridges: optional function to get bridges to a list
> + * @fpga_region_ops: ops for low level FPGA region ops for device
> + * enumeration/removal
>   *
>   * fpga_region_info contains parameters for the register_full function.
>   * These are separated into an info structure because they some are optional
> @@ -26,6 +46,7 @@ struct fpga_region_info {
>  	struct fpga_compat_id *compat_id;
>  	void *priv;
>  	int (*get_bridges)(struct fpga_region *region);
> +	const struct fpga_region_ops *region_ops;
>  };
>  
>  /**
> @@ -39,6 +60,8 @@ struct fpga_region_info {
>   * @ops_owner: module containing the get_bridges function
>   * @priv: private data
>   * @get_bridges: optional function to get bridges to a list
> + * @fpga_region_ops: ops for low level FPGA region ops for device
> + * enumeration/removal
>   */
>  struct fpga_region {
>  	struct device dev;
> @@ -50,6 +73,8 @@ struct fpga_region {
>  	struct module *ops_owner;
>  	void *priv;
>  	int (*get_bridges)(struct fpga_region *region);
> +	const struct fpga_region_ops *region_ops;
> +	struct miscdevice miscdev;
>  };
>  
>  #define to_fpga_region(d) container_of(d, struct fpga_region, dev)
> @@ -71,6 +96,13 @@ __fpga_region_register_full(struct device *parent, const struct fpga_region_info
>  struct fpga_region *
>  __fpga_region_register(struct device *parent, struct fpga_manager *mgr,
>  		       int (*get_bridges)(struct fpga_region *), struct module *owner);
> +#define fpga_region_register_with_ops(parent, mgr, region_ops, priv, get_bridges) \
> +	__fpga_region_register_with_ops(parent, mgr, region_ops, priv, get_bridges, THIS_MODULE)
> +struct fpga_region *
> +__fpga_region_register_with_ops(struct device *parent, struct fpga_manager *mgr,
> +				const struct fpga_region_ops *region_ops, void *priv,
> +				int (*get_bridges)(struct fpga_region *),
> +				struct module *owner);
>  void fpga_region_unregister(struct fpga_region *region);
>  
>  #endif /* _FPGA_REGION_H */
> diff --git a/include/uapi/linux/fpga-region.h b/include/uapi/linux/fpga-region.h
> new file mode 100644
> index 000000000000..88ade83daf61
> --- /dev/null
> +++ b/include/uapi/linux/fpga-region.h
> @@ -0,0 +1,51 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/*
> + * Header File for FPGA Region User API
> + *
> + * Copyright (C) 2024 Advanced Micro Devices, Inc.
> + *
> + * Author: Manne, Nava kishore <nava.kishore.manne@amd.com>
> + */
> +
> +#ifndef _UAPI_LINUX_FPGA_REGION_H
> +#define _UAPI_LINUX_FPGA_REGION_H
> +
> +#include <linux/ioctl.h>
> +#include <linux/limits.h>
> +#include <linux/types.h>
> +
> +/* IOCTLs for fpga region file descriptor */
> +#define FPGA_REGION_MAGIC_NUMBER	'f'
> +#define FPGA_REGION_BASE		0
> +
> +/**
> + * FPGA_REGION_IOCTL_LOAD - _IOW(FPGA_REGION_MAGIC, 0,
> + *                               struct fpga_region_config_info)
> + *
> + * FPGA_REGION_IOCTL_REMOVE - _IOW(FPGA_REGION_MAGIC, 1,
> + *                                 struct fpga_region_config_info)
> + *
> + * Driver does Configuration/Reconfiguration based on Region ID and
> + * Buffer (Image) provided by caller.
> + * Return: 0 on success, -errno on failure.
> + */
> +struct fpga_region_config_info {	/* Input */
> +	char firmware_name[NAME_MAX];   /* Firmware file name */
> +};
> +
> +/*
> + * FPGA Region Control IOCTLs.
> + */
> +#define FPGA_REGION_MAGIC	'f'
> +#define FPGA_IOW(num, dtype)	_IOW(FPGA_REGION_MAGIC, num, dtype)
> +#define FPGA_IOR(num, dtype)	_IOR(FPGA_REGION_MAGIC, num, dtype)
> +
> +#define FPGA_REGION_IOCTL_LOAD		FPGA_IOW(0, __u32)
> +#define FPGA_REGION_IOCTL_REMOVE        FPGA_IOW(1, __u32)
> +#define FPGA_REGION_IOCTL_STATUS        FPGA_IOR(2, __u32)
> +
> +/* Region status possibilities returned by FPGA_REGION_IOCTL_STATUS ioctl */
> +#define FPGA_REGION_HAS_PL	0	/* if the region has PL logic */
> +#define FPGA_REGION_EMPTY	1	/* If the region is empty */
> +
> +#endif /* _UAPI_LINUX_FPGA_REGION_H */
> -- 
> 2.34.1
> 
> 


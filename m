Return-Path: <linux-fpga+bounces-1016-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 609C8A1CEB8
	for <lists+linux-fpga@lfdr.de>; Sun, 26 Jan 2025 22:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC43C3A4BFF
	for <lists+linux-fpga@lfdr.de>; Sun, 26 Jan 2025 21:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD0F25A62A;
	Sun, 26 Jan 2025 21:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bklfTBSO"
X-Original-To: linux-fpga@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FAF189905
	for <linux-fpga@vger.kernel.org>; Sun, 26 Jan 2025 21:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737926009; cv=none; b=kmhrWyGsEWBGbPRHigjVUiYLCaEOlZIf6x1gP//WUe6aQm71BvduGbSs82Yu6ecfNO4h9RZTGMUKGdDXa0eXI2PeyU6wrVhRuFJ/r72Okb9a/292jbtl4QLJ1QFRzvtuMQUGe9x7+2jkHRr1+aoEzKPOasPKQ3VhOTKH4/dwKCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737926009; c=relaxed/simple;
	bh=nV6jifjlYVTpVfeYsDhrH+CYsrUiL0NmA8MENN9UK08=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fKdlHDgFnAkh5czULHcHZqq9TvRl31p2S6XuZRC/j1CixktD8vNkgKYOPTqKrFybTcnwV0LcsYby3pVcGwBARm8J0DsvPsJve3b/81Q4eGFie4u5INZqR16j4xupP/m7iG5Sc2MBHdDM49BSAd+NcXLzT64koQ7UELO2mWCHeQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bklfTBSO; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <00e5c1c1-a98e-4360-b7e5-ffaa384e1036@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737925995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/22ufbnK9lDcUFCGuRMmAaCHCE7LlR/Z6sietFd58vQ=;
	b=bklfTBSOC3wqMnF5Wf4rAi6MLXTQsKk205abTM9CMOscJDIMwe3Egcb3JZJARDeCdUAdZU
	vuAJhUdj6NEnvA70kfNZeDq+kj9e7STHH1NMtzgpWtA0RR+JloCsbTdQeXmNc6FnSA1UDB
	jqRz49ldH19KoX91xZS7+jDWG1bwc44=
Date: Sun, 26 Jan 2025 22:13:11 +0100
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC v2 1/1] fpga-region: Add generic IOCTL interface for runtime
 FPGA programming
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: Nava kishore Manne <nava.kishore.manne@amd.com>, git@amd.com,
 mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com, trix@redhat.com,
 robh@kernel.org, saravanak@google.com, linux-kernel@vger.kernel.org,
 linux-fpga@vger.kernel.org, devicetree@vger.kernel.org
References: <20241029091734.3288005-1-nava.kishore.manne@amd.com>
 <20241029091734.3288005-2-nava.kishore.manne@amd.com>
 <ZzwQrYeWVF6cRtgA@yilunxu-OptiPlex-7050>
 <9bfaf1cf-3313-4cb3-9963-2b4bad2d3165@redhat.com>
 <Z0fIiQPCS69O2d/n@yilunxu-OptiPlex-7050>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Marco Pagani <marco.pagani@linux.dev>
In-Reply-To: <Z0fIiQPCS69O2d/n@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024-11-28 02:34, Xu Yilun wrote:
> On Mon, Nov 25, 2024 at 12:26:06PM +0100, Marco Pagani wrote:
>> On 2024-11-19 05:14, Xu Yilun wrote:
>>> On Tue, Oct 29, 2024 at 02:47:34PM +0530, Nava kishore Manne wrote:
>>>> Introduces an IOCTL interface within the fpga-region subsystem,
>>>> providing a generic and standardized mechanism for configuring (or)
>>>> reprogramming FPGAs during runtime. The newly added interface supports
>>>> both OF (Open Firmware) and non-OF devices, leveraging vendor-specific
>>>> callbacks (e.g., configuration + enumeration, removal, and status) to
>>>> accommodate a wide range of device specific configurations.
>>>>
>>>> The IOCTL interface ensures compatibility with both OF and non-OF
>>>> devices, allowing for seamless FPGA reprogramming across diverse
>>>> platforms.
>>>>
>>>> Vendor-specific callbacks are integrated into the interface, enabling
>>>> custom FPGA configuration + enumeration, removal, and status reporting
>>>> mechanisms, ensuring flexibility for vendor implementations.
>>>>
>>>> This solution enhances FPGA runtime management, supporting various device
>>>> types and vendors, while ensuring compatibility with the current FPGA
>>>> configuration flow.
>>>>
>>>> Signed-off-by: Nava kishore Manne <nava.kishore.manne@amd.com>
>>>> ---
>>>> Changes for v2:
>>>>  - As discussed with Yilun, the implementation has been modified to utilize a
>>>>  callback approach, enabling seamless handling of both OF and non-OF devices.
>>>>
>>>>  - As suggested by Yilun in the POC code, we have moved away from using  void *args
>>>>  as a parameter for ICOTL inputs to obtain the required user inputs. Instead, we are
>>>>  utilizing the fpga_region_config_info structure to gather user inputs. Currently,
>>>>  this structure is implemented to support only OF devices, but we intend to extend
>>>>  it by incorporating new members to accommodate non-OF devices in the future.
>>>>
>>>>  drivers/fpga/fpga-region.c       | 110 +++++++++++++++++++++++++++++++
>>>>  drivers/fpga/of-fpga-region.c    |  91 ++++++++++++++++++++++++-
>>>>  include/linux/fpga/fpga-region.h |  32 +++++++++
>>>>  include/uapi/linux/fpga-region.h |  51 ++++++++++++++
>>>>  4 files changed, 283 insertions(+), 1 deletion(-)
>>>>  create mode 100644 include/uapi/linux/fpga-region.h
>>>>
>>>> diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
>>>> index 753cd142503e..c6bea3c99a69 100644
>>>> --- a/drivers/fpga/fpga-region.c
>>>> +++ b/drivers/fpga/fpga-region.c
>>>> @@ -8,6 +8,7 @@
>>>>  #include <linux/fpga/fpga-bridge.h>
>>>>  #include <linux/fpga/fpga-mgr.h>
>>>>  #include <linux/fpga/fpga-region.h>
>>>> +#include <linux/fpga-region.h>
>>>>  #include <linux/idr.h>
>>>>  #include <linux/kernel.h>
>>>>  #include <linux/list.h>
>>>> @@ -180,6 +181,67 @@ static struct attribute *fpga_region_attrs[] = {
>>>>  };
>>>>  ATTRIBUTE_GROUPS(fpga_region);
>>>>  
>>>> +static int fpga_region_device_open(struct inode *inode, struct file *file)
>>>> +{
>>>> +	struct miscdevice *miscdev = file->private_data;
>>>> +	struct fpga_region *region = container_of(miscdev, struct fpga_region, miscdev);
>>>> +
>>>> +	file->private_data = region;
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static int fpga_region_device_release(struct inode *inode, struct file *file)
>>>> +{
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static long fpga_region_device_ioctl(struct file *file, unsigned int cmd,
>>>> +				     unsigned long arg)
>>>> +{
>>>> +	int err;
>>>> +	void __user *argp = (void __user *)arg;
>>>> +	struct fpga_region_config_info config_info;
>>>> +	struct fpga_region *region =  (struct fpga_region *)(file->private_data);
>>>> +
>>>> +	switch (cmd) {
>>>> +	case FPGA_REGION_IOCTL_LOAD:
>>>> +		if (copy_from_user(&config_info, argp, sizeof(struct fpga_region_config_info)))
>>>> +			return -EFAULT;
>>>> +
>>>> +		err = region->region_ops->region_config_enumeration(region, &config_info);
>>>> +
>>>> +		break;
>>>> +	case FPGA_REGION_IOCTL_REMOVE:
>>>> +		if (copy_from_user(&config_info, argp, sizeof(struct fpga_region_config_info)))
>>>> +			return -EFAULT;
>>>> +
>>>> +		err = region->region_ops->region_remove(region, &config_info);
>>>> +
>>>> +		break;
>>>> +	case FPGA_REGION_IOCTL_STATUS:
>>>> +		unsigned int status;
>>>> +
>>>> +		status = region->region_ops->region_status(region);
>>>> +
>>>> +		if (copy_to_user((void __user *)arg, &status, sizeof(status)))
>>>> +			err = -EFAULT;
>>>> +		break;
>>>> +	default:
>>>> +		err = -ENOTTY;
>>>> +	}
>>>> +
>>>> +	return err;
>>>> +}
>>>> +
>>>> +static const struct file_operations fpga_region_fops = {
>>>> +	.owner		= THIS_MODULE,
>>>> +	.open		= fpga_region_device_open,
>>>> +	.release	= fpga_region_device_release,
>>>> +	.unlocked_ioctl	= fpga_region_device_ioctl,
>>>> +	.compat_ioctl	= fpga_region_device_ioctl,
>>>> +};
>>>> +
>>>>  /**
>>>>   * __fpga_region_register_full - create and register an FPGA Region device
>>>>   * @parent: device parent
>>>> @@ -229,8 +291,21 @@ __fpga_region_register_full(struct device *parent, const struct fpga_region_info
>>>>  	if (ret)
>>>>  		goto err_remove;
>>>>  
>>>> +	if (info->region_ops) {
>>>> +		region->region_ops = info->region_ops;
>>>> +		region->miscdev.minor = MISC_DYNAMIC_MINOR;
>>>> +		region->miscdev.name = kobject_name(&region->dev.kobj);
>>>> +		region->miscdev.fops = &fpga_region_fops;
>>>> +		ret = misc_register(&region->miscdev);
>>>> +		if (ret) {
>>>> +			pr_err("fpga-region: failed to register misc device.\n");
>>>> +			goto err_remove;
>>>> +		}
>>>> +	}
>>>> +
>>>>  	ret = device_register(&region->dev);
>>>>  	if (ret) {
>>>> +		misc_deregister(&region->miscdev);
>>>>  		put_device(&region->dev);
>>>>  		return ERR_PTR(ret);
>>>>  	}
>>>> @@ -272,6 +347,40 @@ __fpga_region_register(struct device *parent, struct fpga_manager *mgr,
>>>>  }
>>>>  EXPORT_SYMBOL_GPL(__fpga_region_register);
>>>>  
>>>> +/**
>>>> + * __fpga_region_register_with_ops - create and register an FPGA Region device
>>>> + * with user interface call-backs.
>>>> + * @parent: device parent
>>>> + * @mgr: manager that programs this region
>>>> + * @region_ops: ops for low level FPGA region for device enumeration/removal
>>>> + * @priv: of-fpga-region private data
>>>> + * @get_bridges: optional function to get bridges to a list
>>>> + * @owner: module containing the get_bridges function
>>>> + *
>>>> + * This simple version of the register function should be sufficient for most users.
>>>> + * The fpga_region_register_full() function is available for users that need to
>>>> + * pass additional, optional parameters.
>>>> + *
>>>> + * Return: struct fpga_region or ERR_PTR()
>>>> + */
>>>> +struct fpga_region *
>>>> +__fpga_region_register_with_ops(struct device *parent, struct fpga_manager *mgr,
>>>> +				const struct fpga_region_ops *region_ops,
>>>> +				void *priv,
>>>> +				int (*get_bridges)(struct fpga_region *),
>>>> +				struct module *owner)
>>>> +{
>>>> +	struct fpga_region_info info = { 0 };
>>>> +
>>>> +	info.mgr = mgr;
>>>> +	info.priv = priv;
>>>> +	info.get_bridges = get_bridges;
>>>> +	info.region_ops = region_ops;
>>>> +
>>>> +	return __fpga_region_register_full(parent, &info, owner);
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(__fpga_region_register_with_ops);
>>>> +
>>>>  /**
>>>>   * fpga_region_unregister - unregister an FPGA region
>>>>   * @region: FPGA region
>>>> @@ -280,6 +389,7 @@ EXPORT_SYMBOL_GPL(__fpga_region_register);
>>>>   */
>>>>  void fpga_region_unregister(struct fpga_region *region)
>>>>  {
>>>> +	misc_deregister(&region->miscdev);
>>>>  	device_unregister(&region->dev);
>>>>  }
>>>>  EXPORT_SYMBOL_GPL(fpga_region_unregister);
>>>> diff --git a/drivers/fpga/of-fpga-region.c b/drivers/fpga/of-fpga-region.c
>>>> index 8526a5a86f0c..63fe56e0466f 100644
>>>> --- a/drivers/fpga/of-fpga-region.c
>>>> +++ b/drivers/fpga/of-fpga-region.c
>>>> @@ -8,6 +8,8 @@
>>>>  #include <linux/fpga/fpga-bridge.h>
>>>>  #include <linux/fpga/fpga-mgr.h>
>>>>  #include <linux/fpga/fpga-region.h>
>>>> +#include <linux/firmware.h>
>>>> +#include <linux/fpga-region.h>
>>>>  #include <linux/idr.h>
>>>>  #include <linux/kernel.h>
>>>>  #include <linux/list.h>
>>>> @@ -18,6 +20,20 @@
>>>>  #include <linux/slab.h>
>>>>  #include <linux/spinlock.h>
>>>>  
>>>> +/**
>>>> + * struct of_fpga_region_priv - Private data structure
>>>> + * image.
>>>> + * @dev:	Device data structure
>>>> + * @fw:		firmware of coeff table.
>>>> + * @path:	path of FPGA overlay image firmware file.
>>>> + * @ovcs_id:	overlay changeset id.
>>>> + */
>>>> +struct of_fpga_region_priv {
>>>> +	struct device *dev;
>>>> +	const struct firmware *fw;
>>>> +	int ovcs_id;
>>>> +};
>>>> +
>>>>  static const struct of_device_id fpga_region_of_match[] = {
>>>>  	{ .compatible = "fpga-region", },
>>>>  	{},
>>>> @@ -394,20 +410,93 @@ static struct notifier_block fpga_region_of_nb = {
>>>>  	.notifier_call = of_fpga_region_notify,
>>>>  };
>>>>  
>>>> +static int of_fpga_region_status(struct fpga_region *region)
>>>> +{
>>>> +	struct of_fpga_region_priv *ovcs = region->priv;
>>>> +
>>>> +	if (ovcs->ovcs_id)
>>>> +		return FPGA_REGION_HAS_PL;
>>>
>>> Could you help specify what is PL?
>>>
>>>> +
>>>> +	return FPGA_REGION_EMPTY;
>>>> +}
>>>> +
>>>> +static int of_fpga_region_config_enumeration(struct fpga_region *region,
>>>> +					     struct fpga_region_config_info *config_info)
>>>> +{
>>>> +	struct of_fpga_region_priv *ovcs = region->priv;
>>>> +	int err;
>>>> +
>>>> +	/* if it's set do not allow changes */
>>>> +	if (ovcs->ovcs_id)
>>>> +		return -EPERM;
>>>> +
>>>> +	err = request_firmware(&ovcs->fw, config_info->firmware_name, NULL);
>>>> +	if (err != 0)
>>>> +		goto out_err;
>>>> +
>>>> +	err = of_overlay_fdt_apply((void *)ovcs->fw->data, ovcs->fw->size,
>>>> +				   &ovcs->ovcs_id, NULL);
>>>> +	if (err < 0) {
>>>> +		pr_err("%s: Failed to create overlay (err=%d)\n",
>>>> +		       __func__, err);
>>>> +		release_firmware(ovcs->fw);
>>>> +		goto out_err;
>>>> +	}
>>>> +
>>>> +	return 0;
>>>> +
>>>> +out_err:
>>>> +	ovcs->ovcs_id = 0;
>>>> +	ovcs->fw = NULL;
>>>> +
>>>> +	return err;
>>>> +}
>>>> +
>>>> +static int of_fpga_region_config_remove(struct fpga_region *region,
>>>> +					struct fpga_region_config_info *config_info)
>>>> +{
>>>> +	struct of_fpga_region_priv *ovcs = region->priv;
>>>> +
>>>> +	if (!ovcs->ovcs_id)
>>>> +		return -EPERM;
>>>> +
>>>> +	of_overlay_remove(&ovcs->ovcs_id);
>>>> +	release_firmware(ovcs->fw);
>>>> +
>>>> +	ovcs->ovcs_id = 0;
>>>> +	ovcs->fw = NULL;
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static const struct fpga_region_ops region_ops = {
>>>> +	.region_status = of_fpga_region_status,
>>>> +	.region_config_enumeration = of_fpga_region_config_enumeration,
>>>> +	.region_remove = of_fpga_region_config_remove,
>>>> +};
>>>> +
>>>>  static int of_fpga_region_probe(struct platform_device *pdev)
>>>>  {
>>>>  	struct device *dev = &pdev->dev;
>>>>  	struct device_node *np = dev->of_node;
>>>> +	struct of_fpga_region_priv *priv;
>>>>  	struct fpga_region *region;
>>>>  	struct fpga_manager *mgr;
>>>>  	int ret;
>>>>  
>>>> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>>>> +	if (!priv)
>>>> +		return -ENOMEM;
>>>> +
>>>> +	priv->dev = dev;
>>>> +
>>>>  	/* Find the FPGA mgr specified by region or parent region. */
>>>>  	mgr = of_fpga_region_get_mgr(np);
>>>>  	if (IS_ERR(mgr))
>>>>  		return -EPROBE_DEFER;
>>>>  
>>>> -	region = fpga_region_register(dev, mgr, of_fpga_region_get_bridges);
>>>> +	region = fpga_region_register_with_ops(dev, mgr, &region_ops, priv,
>>>> +					       of_fpga_region_get_bridges);
>>>>  	if (IS_ERR(region)) {
>>>>  		ret = PTR_ERR(region);
>>>>  		goto eprobe_mgr_put;
>>>> diff --git a/include/linux/fpga/fpga-region.h b/include/linux/fpga/fpga-region.h
>>>> index 5fbc05fe70a6..3a3ba6dbb5e1 100644
>>>> --- a/include/linux/fpga/fpga-region.h
>>>> +++ b/include/linux/fpga/fpga-region.h
>>>> @@ -6,15 +6,35 @@
>>>>  #include <linux/device.h>
>>>>  #include <linux/fpga/fpga-mgr.h>
>>>>  #include <linux/fpga/fpga-bridge.h>
>>>> +#include <linux/fpga-region.h>
>>>> +#include <linux/miscdevice.h>
>>>>  
>>>>  struct fpga_region;
>>>>  
>>>> +/**
>>>> + * struct fpga_region_ops - ops for low level FPGA region ops for device
>>>> + * enumeration/removal
>>>> + * @region_status: returns the FPGA region status
>>>> + * @region_config_enumeration: Configure and enumerate the FPGA region.
>>>> + * @region_remove: Remove all devices within the FPGA region
>>>> + * (which are added as part of the enumeration).
>>>> + */
>>>> +struct fpga_region_ops {
>>>> +	int (*region_status)(struct fpga_region *region);
>>>> +	int (*region_config_enumeration)(struct fpga_region *region,
>>>> +					 struct fpga_region_config_info *config_info);
>>>
>>> My current concern is still about this combined API, it just offloads
>>> all work to low level, but we have some common flows. That's why we
>>> introduce a common FPGA reprograming API.
>>>
>>> I didn't see issue about the vendor specific pre configuration. They
>>> are generally needed to initialize the struct fpga_image_info, which
>>> is a common structure for fpga_region_program_fpga().
>>>
>>> For port IDs(AFU) inputs for DFL, I think it could also be changed
>>> (Don't have to be implemented in this patchset). Previously DFL
>>> provides an uAPI for the whole device, so it needs a port_id input to
>>> position which fpga_region within the device for programming. But now,
>>> we are introducing a per fpga_region programming interface, IIUC port_id
>>> should not be needed anymore.
>>>
>>> The combined API is truly simple for leveraging the existing
>>> of-fpga-region overlay apply mechanism. But IMHO that flow doesn't fit
>>> our new uAPI well. That flow is to adapt the generic configfs overlay
>>> interface, which comes to a dead end as you mentioned.
>>>
>>> My gut feeling for the generic programing flow should be:
>>>
>>>  1. Program the image to HW.
>>>  2. Enumerate the programmed image (apply the DT overlay)
>>>
>>> Why we have to:
>>>
>>>  1. Start enumeration.
>>>  2. On pre enumeration, programe the image.
>>>  3. Real enumeration.
>>
>> I'm currently working on an RFC to propose a rework of the fpga
>> subsystem in order to make it more aligned with the device model. One of
>> the ideas I'm experimenting with is having a bus (struct bus_type) for
>> fpga regions (devices) so that we can have region drivers that could
>> handle internal device enumeration/management whenever a new region is
>> configured on the fabric. Does this make sense in your opinions?
> 
> mm.. I didn't fully understand the need to have a region driver, what's
> the issue to solve?
> 

Sorry for the late reply. The general idea is to handle regions in a way
that is more aligned with the device model without having to resort to
extra ops and additional devices.

Having an fpga bus would allow us to handle enumeration using proper
region drivers (in the device model sense of the term, i.e., struct
device_driver) instead of derived region devices.

On second thought, I think having a reconfiguration interface at the
fpga manager level is sounder than having it at the region level (one
for each region).

With that in place, the fpga manager could request a firmware image,
parse it, write the content into the fpga configuration memory, and then
instantiate the region devices and add them to its fpga bus. Then, if
there is a match, a specific region driver can handle the enumeration
within the new region.

What do you think?

Thanks,
Marco



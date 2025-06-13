Return-Path: <linux-fpga+bounces-1242-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 061F0AD8953
	for <lists+linux-fpga@lfdr.de>; Fri, 13 Jun 2025 12:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1909B3B0739
	for <lists+linux-fpga@lfdr.de>; Fri, 13 Jun 2025 10:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DDD12D29C5;
	Fri, 13 Jun 2025 10:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OuHU6G1u"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846292C3253;
	Fri, 13 Jun 2025 10:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749809820; cv=none; b=tuBTVKm1393VVHN7gv2AMESfWw281MOniwgDsk1R8xnjJJEskjurTROoB/Y9bVOif2sD3KKYBH2c3K7b8s+W9aQonaymaC2c4Rawyn/SXiIiYSL7jaIjqZ3KgNIjXX5amQtknzkObdkGhVP9b9ieQhxAWZaPHnn1refXJ0UOzoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749809820; c=relaxed/simple;
	bh=BbvwoOMhx5QUYjz1948lGeP96P+UqKHJjDfYHav2DJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y8cC4soBvSLaQnwIoMIJphHA3gGTDsesmLouChzBT9BD4T3jYTzMGGH0YYaI58t3wPmHMpGPskSnenR3u/us2vaVkb8gVX+djg04+nHknLRjF+zzvUmpVoFcPZTtk7HXMFV1HPIp8U/pl0t9ENhdz5CmNcw3IzR12lRVszgbIUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OuHU6G1u; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749809818; x=1781345818;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BbvwoOMhx5QUYjz1948lGeP96P+UqKHJjDfYHav2DJs=;
  b=OuHU6G1u+eBvQacgNBXYD9m4KCSxE2OYt0cKASe4J4Hrj0hreUEl2bob
   FuMVDwPmxVbpWv/+PL1IcQ3xR2LIiFC49rXhvCn9cP1OOLkg5Hlpq6h4l
   s8vBF5/ODDJd+76Oubt3l/6CE9toetWtbmlRkJ9atzUfWPKDkpqcrx7aL
   7XVP5xcwkxfMjIbX+HYe7Clp/qBXcT3d+sjT4CWZBHXpjOZZOLE5w0Kc6
   XPUjmO67gC0VK5R6PzhAOwRft2+FX3h7MpT4u5KlquHZmsmIVCs6H+INN
   H7mHAuKbyyCXPuzFf8ZoyMTGyIvj2EjOSNZzRt/3AyAq87I/YRrSg2pQP
   w==;
X-CSE-ConnectionGUID: oIBEqrn7TR2LSJ6K5Yg2bg==
X-CSE-MsgGUID: QpH/8Pw5SV2OQBfwVVSuag==
X-IronPort-AV: E=McAfee;i="6800,10657,11462"; a="62672901"
X-IronPort-AV: E=Sophos;i="6.16,233,1744095600"; 
   d="scan'208";a="62672901"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 03:16:57 -0700
X-CSE-ConnectionGUID: UwDJ2zuBTN+9Bp4hy8iYFA==
X-CSE-MsgGUID: cM2K0UbJTI6TcRXG86BJXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,233,1744095600"; 
   d="scan'208";a="152758340"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa004.jf.intel.com with ESMTP; 13 Jun 2025 03:16:53 -0700
Date: Fri, 13 Jun 2025 18:09:52 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: "Manne, Nava kishore" <nava.kishore.manne@amd.com>
Cc: "mdf@kernel.org" <mdf@kernel.org>,
	"hao.wu@intel.com" <hao.wu@intel.com>,
	"yilun.xu@intel.com" <yilun.xu@intel.com>,
	"trix@redhat.com" <trix@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"saravanak@google.com" <saravanak@google.com>,
	"linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"git (AMD-Xilinx)" <git@amd.com>
Subject: Re: [RFC v3 1/1] fpga-region: Introduce ConfigFS interface for
 runtime FPGA configuration
Message-ID: <aEv48IZSinWjJgBt@yilunxu-OptiPlex-7050>
References: <20250519033950.2669858-1-nava.kishore.manne@amd.com>
 <20250519033950.2669858-2-nava.kishore.manne@amd.com>
 <aDxrUD9YjnFkWy3M@yilunxu-OptiPlex-7050>
 <DS7PR12MB607015CAB2781E16A4EC110ECD74A@DS7PR12MB6070.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS7PR12MB607015CAB2781E16A4EC110ECD74A@DS7PR12MB6070.namprd12.prod.outlook.com>

On Thu, Jun 12, 2025 at 09:05:21AM +0000, Manne, Nava kishore wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> Hi Yilun,
> 
>         Thanks for quick response.
> Please find my response inline.
> 
> > -----Original Message-----
> > From: Xu Yilun <yilun.xu@linux.intel.com>
> > Sent: Sunday, June 1, 2025 8:32 PM
> > To: Manne, Nava kishore <nava.kishore.manne@amd.com>
> > Cc: mdf@kernel.org; hao.wu@intel.com; yilun.xu@intel.com; trix@redhat.com;
> > robh@kernel.org; saravanak@google.com; linux-fpga@vger.kernel.org; linux-
> > kernel@vger.kernel.org; devicetree@vger.kernel.org; git (AMD-Xilinx)
> > <git@amd.com>
> > Subject: Re: [RFC v3 1/1] fpga-region: Introduce ConfigFS interface for runtime
> > FPGA configuration
> >
> > On Mon, May 19, 2025 at 09:09:37AM +0530, Nava kishore Manne wrote:
> > > Introduces an ConfigFS interface within the fpga-region subsystem,
> > > providing a generic and standardized mechanism for configuring (or)
> > > reprogramming FPGAs during runtime. The newly added interface supports
> > > both OF (Open Firmware) and non-OF devices, leveraging vendor-specific
> > > callbacks (e.g., pre_config, post_config, removal, and status) to
> > > accommodate a wide range of device specific configurations.
> > >
> > > The ConfigFS interface ensures compatibility with both OF and non-OF
> > > devices, allowing for seamless FPGA reprogramming across diverse
> > > platforms.
> > >
> > > Vendor-specific callbacks are integrated into the interface, enabling
> > > custom FPGA pre_config, post_config, removal, and status reporting
> > > mechanisms, ensuring flexibility for vendor implementations.
> > >
> > > This solution enhances FPGA runtime management, supporting various
> > > device types and vendors, while ensuring compatibility with the
> > > current FPGA configuration flow.
> > >
> > > Signed-off-by: Nava kishore Manne <nava.kishore.manne@amd.com>
> > > ---
> > > Changes for v3:
> > >  - As discussed with Yilun, the implementation continues to use a
> > > callback-based  approach to seamlessly support both OF (Open Firmware)
> > > and non-OF devices via  vendor-specific hooks. Additionally, the
> > > earlier IOCTL-based interface has been  replaced with a more suitable
> > > ConfigFS-based mechanism to enable runtime FPGA  configuration.
> > >
> > > Changes for v2:
> > >  - As discussed with Yilun, the implementation has been modified to
> > > utilize a  callback approach, enabling seamless handling of both OF and non-OF
> > devices.
> > >
> > >  - As suggested by Yilun in the POC code, we have moved away from
> > > using  void *args  as a parameter for ICOTL inputs to obtain the
> > > required user inputs. Instead, we are  utilizing the
> > > fpga_region_config_info structure to gather user inputs. Currently,
> > > this structure is implemented to support only OF devices, but we intend to extend
> > it by incorporating new members to accommodate non-OF devices in the future.
> > >
> > >  drivers/fpga/fpga-region.c       | 196 +++++++++++++
> > >  drivers/fpga/of-fpga-region.c    | 474 +++++++++++++++++--------------
> > >  include/linux/fpga/fpga-region.h |  34 +++
> > >  3 files changed, 493 insertions(+), 211 deletions(-)
> > >
> > > diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
> > > index 753cd142503e..d583fc22955b 100644
> > > --- a/drivers/fpga/fpga-region.c
> > > +++ b/drivers/fpga/fpga-region.c
> > > @@ -5,6 +5,7 @@
> > >   *  Copyright (C) 2013-2016 Altera Corporation
> > >   *  Copyright (C) 2017 Intel Corporation
> > >   */
> > > +#include <linux/configfs.h>
> > >  #include <linux/fpga/fpga-bridge.h>
> > >  #include <linux/fpga/fpga-mgr.h>
> > >  #include <linux/fpga/fpga-region.h>
> > > @@ -180,6 +181,158 @@ static struct attribute *fpga_region_attrs[] = {
> > > };  ATTRIBUTE_GROUPS(fpga_region);
> > >
> > > +static struct fpga_region *item_to_fpga_region(struct config_item
> > > +*item) {
> > > +   return container_of(to_configfs_subsystem(to_config_group(item)),
> > > +                       struct fpga_region, subsys);
> > > +}
> > > +
> > > +/**
> > > + * fpga_region_image_store - Set firmware image name for FPGA region
> > > + * This function sets the firmware image name for an FPGA region through
> > configfs.
> > > + * @item: Configfs item representing the FPGA region
> > > + * @buf: Input buffer containing the firmware image name
> > > + * @count: Size of the input buffer
> > > + *
> > > + * Return: Number of bytes written on success, or negative errno on failure.
> > > + */
> > > +static ssize_t fpga_region_image_store(struct config_item *item,
> > > +const char *buf, size_t count) {
> > > +   struct fpga_region *region = item_to_fpga_region(item);
> > > +   struct device *dev = &region->dev;
> > > +   struct fpga_image_info *info;
> > > +   char firmware_name[NAME_MAX];
> > > +   char *s;
> > > +
> > > +   if (region->info) {
> > > +           dev_err(dev, "Region already has already configured.\n");
> > > +           return -EINVAL;
> > > +   }
> > > +
> > > +   info = fpga_image_info_alloc(dev);
> > > +   if (!info)
> > > +           return -ENOMEM;
> > > +
> > > +   /* copy to path buffer (and make sure it's always zero terminated */
> > > +   count = snprintf(firmware_name, sizeof(firmware_name) - 1, "%s", buf);
> > > +   firmware_name[sizeof(firmware_name) - 1] = '\0';
> > > +
> > > +   /* strip trailing newlines */
> > > +   s = firmware_name + strlen(firmware_name);
> > > +   while (s > firmware_name && *--s == '\n')
> > > +           *s = '\0';
> > > +
> > > +   region->firmware_name = devm_kstrdup(dev, firmware_name,
> > GFP_KERNEL);
> > > +   if (!region->firmware_name)
> > > +           return -ENOMEM;
> > > +
> > > +   region->info = info;
> > > +
> > > +   return count;
> > > +}
> > > +
> > > +/**
> > > + * fpga_region_config_store - Trigger FPGA configuration via configfs
> > > + * @item: Configfs item representing the FPGA region
> > > + * @buf: Input buffer containing the configuration command (expects
> > > +"1" to program, "0" to remove)
> > > + * @count: Size of the input buffer
> > > + *
> > > + * If the input is "1", this function performs:
> > > + *   1. region_pre_config() (if defined)
> >
> > Please define explicit workflow, and explicit expectation for each callback, or this
> > framework makes no sense. From your of-fpga-region implementation, seems
> > pre_config() means "parse image", post_config() means "populate devices".
> >
> > > + *   2. Bitstream programming via fpga_region_program_fpga() (unless external
> > config flag is set)
> > > + *   3. region_post_config() (if defined)
> > > + *
> > > + * If the input is "0", it triggers region_remove() (if defined).
> > > + *
> > > + * Return: Number of bytes processed on success, or negative errno on failure.
> >
> > Please put the uAPI description in Documentation/ABI/testing. Then we could know
> > the file path layout from userspace POV.
> >
> > > + */
> > > +static ssize_t fpga_region_config_store(struct config_item *item,
> > > +                                   const char *buf, size_t count)
> > > +{
> > > +   struct fpga_region *region = item_to_fpga_region(item);
> > > +   int config_value, ret = 0;
> > > +
> > > +   /* Parse input: must be "0" or "1" */
> > > +   if (kstrtoint(buf, 10, &config_value) || (config_value != 0 && config_value !=
> > 1))
> > > +           return -EINVAL;
> > > +
> > > +   /* Ensure fpga_image_info is available */
> > > +   if (!region->info)
> > > +           return -EINVAL;
> > > +
> > > +   if (config_value == 1) {
> > > +           /* Pre-config */
> > > +           if (region->region_ops->region_pre_config) {
> > > +                   ret = region->region_ops->region_pre_config(region);
> > > +                   if (ret)
> > > +                           return ret;
> > > +           }
> > > +
> > > +           /* Program bitstream if not external */
> > > +           if (!(region->info->flags & FPGA_MGR_EXTERNAL_CONFIG)) {
> > > +                   ret = fpga_region_program_fpga(region);
> > > +                   if (ret)
> > > +                           return ret;
> > > +           }
> > > +
> > > +           /* Post-config */
> > > +           if (region->region_ops->region_post_config) {
> > > +                   ret = region->region_ops->region_post_config(region);
> > > +                   if (ret)
> > > +                           return ret;
> > > +           }
> > > +
> > > +   } else {
> > > +           /* Remove configuration */
> > > +           if (region->region_ops->region_remove) {
> > > +                   ret = region->region_ops->region_remove(region);
> > > +                   if (ret)
> > > +                           return ret;
> > > +           }
> > > +   }
> > > +
> > > +   return count;
> > > +}
> > > +
> > > +/* Define Attributes */
> > > +CONFIGFS_ATTR_WO(fpga_region_, image);
> > CONFIGFS_ATTR_WO(fpga_region_,
> > > +config);
> > > +
> > > +/* Attribute List */
> > > +static struct configfs_attribute *fpga_region_config_attrs[] = {
> > > +   &fpga_region_attr_image,
> > > +   &fpga_region_attr_config,
> > > +   NULL,
> > > +};
> > > +
> > > +/* ConfigFS Item Type */
> > > +static const struct config_item_type fpga_region_item_type = {
> > > +   .ct_attrs = fpga_region_config_attrs,
> > > +   .ct_owner = THIS_MODULE,
> > > +};
> >
> > I think this is still the sysfs methodology. My understanding from configfs.rst is, use
> > userspace interfaces to control the lifecycle of a kernel object.
> >
> > Now for existing kernel reprogramming flow, the image object for fpga_region is the
> > struct fpga_image_info. We need to associate the struct with a config_item: alloc the
> > struct fpga_image_info instance by mkdir, expose necessary fields
> > (enable_timeout_us, disable_timeout_us, firmware_name, and the most important for
> > of-fpga-region - overlay blob ...) for user to fill/query via configfs attributes. And finally
> > use a writeable attribute (e.g. load) to trigger fpga_region_program_fpga().
> >
> 
> Thanks for the inputs. We've now implemented a ConfigFS-based reprogramming
> interface for fpga_region that aligns with the intended lifecycle-driven model
> described in configfs.rst.
> 
> New Interface Usage Instructions:
> # 1. Mount configfs (if not already mounted)
> mkdir -p /configfs
> mount -t configfs configfs /configfs
> 
> # 2. Create a region directory (e.g., region0)
> mkdir /configfs/fpga_regions/region0

FPGA region is the device driver generated kernel object, so this per
fpga_region group should be created by kernel, not userspace.  User
should create fpga_image config_item under region group.

  mkdir /configfs/fpga_region/region0/my_image

> 
> # 3. Copy your bitstream or overlay files to firmware path
> cp pl.dtbo /lib/firmware/
> 
> # 4. Set the firmware name (e.g., overlay .dtbo)
> echo pl.dtbo > /configfs/fpga_regions/region0/image
> 
> # 5. Trigger Programming/reprogramming
> echo 1 > /configfs/fpga_regions/region0/config

My idea is, when an image item is first created, it is not activated,
user needs to read/write its attributes to initialize it, then we
could have an attribute (e.g. enable) to activate/reprograme the image.

For example:

  echo 1 > /configfs/fpga_regions/region0/my_image/enable

> 
> # 6. Unload/Reset the Programmable Logic
> echo 0 > /configfs/fpga_regions/region0/config

Maybe we could just delete the image item for unloading

  rmdir /configfs/fpga_region/region0/my_image

Thanks,
Yilun

> 
> Summary of Changes:
> ->Lifecycle Management:
>     ->On mkdir /configfs/fpga_regions/regionX, we allocate and associate
>        a struct fpga_image_info to the corresponding fpga_region.
>     ->On rmdir, we clean up the associated image info via the new
>        fpga_regions_drop_item() callback.
> ->Device Lookup:
>     ->class_find_device_by_name() is now used in fpga_regions_make_item()
>        to map a region name (e.g., region0) directly to a registered
>        fpga_region device.
> 
> Please share your thoughts on this approach.
> 
> Regards,
> Navakishore.


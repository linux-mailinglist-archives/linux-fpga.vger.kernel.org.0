Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5C604068CE
	for <lists+linux-fpga@lfdr.de>; Fri, 10 Sep 2021 10:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbhIJJAX (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 10 Sep 2021 05:00:23 -0400
Received: from mga04.intel.com ([192.55.52.120]:62019 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231771AbhIJJAX (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 10 Sep 2021 05:00:23 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10102"; a="219170877"
X-IronPort-AV: E=Sophos;i="5.85,282,1624345200"; 
   d="scan'208";a="219170877"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2021 01:59:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,282,1624345200"; 
   d="scan'208";a="470465066"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.162])
  by orsmga007.jf.intel.com with ESMTP; 10 Sep 2021 01:59:09 -0700
Date:   Fri, 10 Sep 2021 16:52:38 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, trix@redhat.com, lgoncalv@redhat.com,
        hao.wu@intel.com, matthew.gerlach@intel.com
Subject: Re: [PATCH v15 5/6] fpga: image-load: create status sysfs node
Message-ID: <20210910085238.GD754505@yilunxu-OptiPlex-7050>
References: <20210909021846.681121-1-russell.h.weight@intel.com>
 <20210909021846.681121-6-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210909021846.681121-6-russell.h.weight@intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, Sep 08, 2021 at 07:18:45PM -0700, Russ Weight wrote:
> Extend the FPGA Image Load class driver to include a status sysfs node that
> can be viewed to determine from the command line if an image load is in
> progress. Status will be one of: idle, starting, preparing, writing, or
> programming.

The FPGA_IMAGE_LOAD_STATUS ioctl already provides the progress info.
Why we need 2 user interfaces for the same information?

Thanks,
Yilun

> 
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> ---
> v15:
>  - Compare to previous patch:
>      [PATCH v14 3/6] fpga: sec-mgr: expose sec-mgr update status
>  - Changed file, symbol, and config names to reflect the new driver name
>  - Removed signed-off/reviewed-by tags
> v14:
>  - Updated ABI documentation date and kernel version
> v13:
>   - No change
> v12:
>   - Updated Date and KernelVersion fields in ABI documentation
>   - Changed syntax of sec_mgr_prog_str[] array definition from:
> 	"idle",			/* FPGA_SEC_PROG_IDLE */
>     to:
> 	[FPGA_SEC_PROG_IDLE]	    = "idle",
> v11:
>   - No change
> v10:
>   - Rebased to 5.12-rc2 next
>   - Updated Date and KernelVersion in ABI documentation
> v9:
>   - Updated Date and KernelVersion in ABI documentation
> v8:
>   - No change
> v7:
>   - Changed Date in documentation file to December 2020
> v6:
>   - No change
> v5:
>   - Use new function sysfs_emit() in the status_show() function
> v4:
>   - Changed from "Intel FPGA Security Manager" to FPGA Security Manager"
>     and removed unnecessary references to "Intel".
>   - Changed: iops -> sops, imgr -> smgr, IFPGA_ -> FPGA_, ifpga_ to fpga_
> v3:
>   - Use a local variable to read progress once in status_show()
>   - Use dev_err to report invalid progress status
> v2:
>   - Bumped documentation date and version
>   - Changed progress state "read_file" to "reading"
> ---
>  .../ABI/testing/sysfs-class-fpga-image-load   |  7 ++++
>  MAINTAINERS                                   |  1 +
>  drivers/fpga/fpga-image-load.c                | 33 +++++++++++++++++++
>  3 files changed, 41 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-fpga-image-load
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-fpga-image-load b/Documentation/ABI/testing/sysfs-class-fpga-image-load
> new file mode 100644
> index 000000000000..6c04a49f01cc
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-class-fpga-image-load
> @@ -0,0 +1,7 @@
> +What: 		/sys/class/fpga_image_load/fpga_imageX/status
> +Date:		Aug 2021
> +KernelVersion:	5.15
> +Contact:	Russ Weight <russell.h.weight@intel.com>
> +Description:	Read-only. Returns a string describing the current status
> +		of an FPGA image upload. The string will be one of the
> +		following: idle, starting, preparing, writing, programming.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 637bc003ca81..e3fbc1bde9bc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7362,6 +7362,7 @@ FPGA SECURITY MANAGER DRIVERS
>  M:	Russ Weight <russell.h.weight@intel.com>
>  L:	linux-fpga@vger.kernel.org
>  S:	Maintained
> +F:	Documentation/ABI/testing/sysfs-class-fpga-image-load
>  F:	Documentation/fpga/fpga-image-load.rst
>  F:	drivers/fpga/fpga-image-load.c
>  F:	include/linux/fpga/fpga-image-load.h
> diff --git a/drivers/fpga/fpga-image-load.c b/drivers/fpga/fpga-image-load.c
> index 99a47b21c995..6ec0a39f07b3 100644
> --- a/drivers/fpga/fpga-image-load.c
> +++ b/drivers/fpga/fpga-image-load.c
> @@ -236,6 +236,38 @@ static const struct file_operations fpga_image_load_fops = {
>  	.unlocked_ioctl = fpga_image_load_ioctl,
>  };
>  
> +static const char * const image_load_prog_str[] = {
> +	[FPGA_IMAGE_PROG_IDLE]	      = "idle",
> +	[FPGA_IMAGE_PROG_STARTING]    = "starting",
> +	[FPGA_IMAGE_PROG_PREPARING]   = "preparing",
> +	[FPGA_IMAGE_PROG_WRITING]     = "writing",
> +	[FPGA_IMAGE_PROG_PROGRAMMING] = "programming"
> +};
> +
> +static ssize_t
> +status_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct fpga_image_load *imgld = to_image_load(dev);
> +	const char *status = "unknown-status";
> +	enum fpga_image_prog progress;
> +
> +	progress = imgld->progress;
> +	if (progress < FPGA_IMAGE_PROG_MAX)
> +		status = image_load_prog_str[progress];
> +	else
> +		dev_err(dev, "Invalid status during secure update: %d\n",
> +			progress);
> +
> +	return sysfs_emit(buf, "%s\n", status);
> +}
> +static DEVICE_ATTR_RO(status);
> +
> +static struct attribute *fpga_image_load_attrs[] = {
> +	&dev_attr_status.attr,
> +	NULL,
> +};
> +ATTRIBUTE_GROUPS(fpga_image_load);
> +
>  /**
>   * fpga_image_load_register - create and register an FPGA Image Load Device
>   *
> @@ -373,6 +405,7 @@ static int __init fpga_image_load_class_init(void)
>  	if (ret)
>  		goto exit_destroy_class;
>  
> +	fpga_image_load_class->dev_groups = fpga_image_load_groups;
>  	fpga_image_load_class->dev_release = fpga_image_load_dev_release;
>  
>  	return 0;
> -- 
> 2.25.1

Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B552B406769
	for <lists+linux-fpga@lfdr.de>; Fri, 10 Sep 2021 08:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbhIJGyt (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 10 Sep 2021 02:54:49 -0400
Received: from mga01.intel.com ([192.55.52.88]:21996 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231312AbhIJGyt (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 10 Sep 2021 02:54:49 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10102"; a="243331833"
X-IronPort-AV: E=Sophos;i="5.85,282,1624345200"; 
   d="scan'208";a="243331833"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2021 23:53:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,282,1624345200"; 
   d="scan'208";a="504949298"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.162])
  by fmsmga008.fm.intel.com with ESMTP; 09 Sep 2021 23:53:29 -0700
Date:   Fri, 10 Sep 2021 14:46:58 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, trix@redhat.com, lgoncalv@redhat.com,
        hao.wu@intel.com, matthew.gerlach@intel.com
Subject: Re: [PATCH v15 1/6] fpga: image-load: fpga image load class driver
Message-ID: <20210910064658.GA754505@yilunxu-OptiPlex-7050>
References: <20210909021846.681121-1-russell.h.weight@intel.com>
 <20210909021846.681121-2-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210909021846.681121-2-russell.h.weight@intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, Sep 08, 2021 at 07:18:41PM -0700, Russ Weight wrote:
> The FPGA Image Load class driver provides an API to transfer update
> files to an FPGA device. Image files are self-describing. They could
> contain FPGA images, BMC images, Root Entry Hashes, or other device
> specific files. It is up to the device driver and the target device
> to authenticate and disposition the file data.
> 
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> ---
> v15:
>  - Compare to previous patch:
>      [PATCH v14 1/6] fpga: sec-mgr: fpga security manager class driver 
>  - Changed file, symbol, and config names to reflect the new driver name
>  - Rewrote documentation. The documentation will be added to in later patches.
>  - Removed signed-off/reviewed-by tags
> v14:
>  - Updated copyright to 2021
>  - Removed the name sysfs entry
>  - Removed MAINTAINERS reference to
>    Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
>  - Use xa_alloc() instead of ida_simple_get()
>  - Rename dev to parent for parent devices
>  - Remove fpga_sec_mgr_create(), devm_fpga_sec_mgr_create(), and
>    fpga_sec_mgr_free() functions and update the fpga_sec_mgr_register()
>    function to both create and register a new security manager.
>  - Populate the fpga_sec_mgr_dev_release() function.
> v13:
>   - No change
> v12:
>   - Updated Date and KernelVersion fields in ABI documentation
> v11:
>   - No change
> v10:
>   - Rebased to 5.12-rc2 next
>   - Updated Date and KernelVersion in ABI documentation
> v9:
>   - Updated Date and KernelVersion in ABI documentation
> v8:
>   - Fixed grammatical error in Documentation/fpga/fpga-sec-mgr.rst
> v7:
>   - Changed Date in documentation file to December 2020
> v6:
>   - Removed sysfs support and documentation for the display of the
>     flash count, root entry hashes, and code-signing-key cancelation
>     vectors.
> v5:
>   - Added the devm_fpga_sec_mgr_unregister() function, following recent
>     changes to the fpga_manager() implementation.
>   - Changed some *_show() functions to use sysfs_emit() instead of sprintf(
> v4:
>   - Changed from "Intel FPGA Security Manager" to FPGA Security Manager"
>     and removed unnecessary references to "Intel".
>   - Changed: iops -> sops, imgr -> smgr, IFPGA_ -> FPGA_, ifpga_ to fpga_
> v3:
>   - Modified sysfs handler check in check_sysfs_handler() to make
>     it more readable.
> v2:
>   - Bumped documentation dates and versions
>   - Added Documentation/fpga/ifpga-sec-mgr.rst
>   - Removed references to bmc_flash_count & smbus_flash_count (not supported)
>   - Split ifpga_sec_mgr_register() into create() and register() functions
>   - Added devm_ifpga_sec_mgr_create()
>   - Removed typedefs for imgr ops
> ---
> ---
>  Documentation/fpga/fpga-image-load.rst |  10 ++
>  Documentation/fpga/index.rst           |   1 +
>  MAINTAINERS                            |   8 ++
>  drivers/fpga/Kconfig                   |  10 ++
>  drivers/fpga/Makefile                  |   3 +
>  drivers/fpga/fpga-image-load.c         | 124 +++++++++++++++++++++++++
>  include/linux/fpga/fpga-image-load.h   |  35 +++++++
>  7 files changed, 191 insertions(+)
>  create mode 100644 Documentation/fpga/fpga-image-load.rst
>  create mode 100644 drivers/fpga/fpga-image-load.c
>  create mode 100644 include/linux/fpga/fpga-image-load.h
> 
> diff --git a/Documentation/fpga/fpga-image-load.rst b/Documentation/fpga/fpga-image-load.rst
> new file mode 100644
> index 000000000000..a6e53ac66026
> --- /dev/null
> +++ b/Documentation/fpga/fpga-image-load.rst
> @@ -0,0 +1,10 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +============================
> +FPGA Image Load Class Driver
> +============================
> +
> +The FPGA Image Load class driver provides a common API for user-space
> +tools to manage image uploads to FPGA devices. Device drivers that
> +instantiate the FPGA Image Load class driver will interact with the
> +target device to transfer and authenticate the image data.
> diff --git a/Documentation/fpga/index.rst b/Documentation/fpga/index.rst
> index f80f95667ca2..85d25fb22c08 100644
> --- a/Documentation/fpga/index.rst
> +++ b/Documentation/fpga/index.rst
> @@ -8,6 +8,7 @@ fpga
>      :maxdepth: 1
>  
>      dfl
> +    fpga-image-load
>  
>  .. only::  subproject and html
>  
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6c63415d2ac2..4e7f48fa7e5c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7358,6 +7358,14 @@ F:	Documentation/fpga/
>  F:	drivers/fpga/
>  F:	include/linux/fpga/
>  
> +FPGA SECURITY MANAGER DRIVERS
> +M:	Russ Weight <russell.h.weight@intel.com>
> +L:	linux-fpga@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/fpga/fpga-image-load.rst
> +F:	drivers/fpga/fpga-image-load.c
> +F:	include/linux/fpga/fpga-image-load.h
> +
>  FPU EMULATOR
>  M:	Bill Metzenthen <billm@melbpc.org.au>
>  S:	Maintained
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index 991b3f361ec9..c12a14e62fff 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -243,4 +243,14 @@ config FPGA_MGR_VERSAL_FPGA
>  	  configure the programmable logic(PL).
>  
>  	  To compile this as a module, choose M here.
> +
> +config FPGA_IMAGE_LOAD
> +	tristate "FPGA Image Load Driver"

Maybe we don't call it "Driver". A framework or "FPGA Image load support",
is it better?

There are more descriptions about "driver" below, maybe you need to change
them all.

> +	help
> +	  The FPGA Image Load class driver presents a common user API for
> +	  uploading an image file to an FPGA device. The image file is
> +	  expected to be self-describing. It is up to the device driver
> +	  and/or the device itself to authenticate and disposition the
> +	  image data.
> +
>  endif # FPGA
> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
> index 0bff783d1b61..adf228ee4f5e 100644
> --- a/drivers/fpga/Makefile
> +++ b/drivers/fpga/Makefile
> @@ -22,6 +22,9 @@ obj-$(CONFIG_FPGA_MGR_VERSAL_FPGA)      += versal-fpga.o
>  obj-$(CONFIG_ALTERA_PR_IP_CORE)         += altera-pr-ip-core.o
>  obj-$(CONFIG_ALTERA_PR_IP_CORE_PLAT)    += altera-pr-ip-core-plat.o
>  
> +# FPGA Image Load Framework
> +obj-$(CONFIG_FPGA_IMAGE_LOAD)		+= fpga-image-load.o
> +
>  # FPGA Bridge Drivers
>  obj-$(CONFIG_FPGA_BRIDGE)		+= fpga-bridge.o
>  obj-$(CONFIG_SOCFPGA_FPGA_BRIDGE)	+= altera-hps2fpga.o altera-fpga2sdram.o
> diff --git a/drivers/fpga/fpga-image-load.c b/drivers/fpga/fpga-image-load.c
> new file mode 100644
> index 000000000000..7d75bbcff541
> --- /dev/null
> +++ b/drivers/fpga/fpga-image-load.c
> @@ -0,0 +1,124 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * FPGA Image Load Class Driver
> + *
> + * Copyright (C) 2019-2021 Intel Corporation, Inc.
> + */
> +
> +#include <linux/fpga/fpga-image-load.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/vmalloc.h>
> +
> +#define IMAGE_LOAD_XA_LIMIT	XA_LIMIT(0, INT_MAX)
> +static DEFINE_XARRAY_ALLOC(fpga_image_load_xa);
> +
> +static struct class *fpga_image_load_class;
> +
> +#define to_image_load(d) container_of(d, struct fpga_image_load, dev)
> +
> +/**
> + * fpga_image_load_register - create and register an FPGA Image Load Device
> + *
> + * @parent: fpga image load device from pdev
> + * @lops:   pointer to a structure of image load callback functions

Maybe "ops" is just good, some more below.

> + * @priv:   fpga image load private data
> + *
> + * Returns a struct fpga_image_load pointer on success, or ERR_PTR() on
> + * error. The caller of this function is responsible for calling
> + * fpga_image_load_unregister().
> + */
> +struct fpga_image_load *
> +fpga_image_load_register(struct device *parent,
> +			 const struct fpga_image_load_ops *lops, void *priv)
> +{
> +	struct fpga_image_load *imgld;
> +	int id, ret;
> +
> +	imgld = kzalloc(sizeof(*imgld), GFP_KERNEL);
> +	if (!imgld)
> +		return NULL;
> +
> +	ret = xa_alloc(&fpga_image_load_xa, &imgld->dev.id, imgld, IMAGE_LOAD_XA_LIMIT,
> +		       GFP_KERNEL);
> +	if (ret)
> +		goto error_kfree;
> +
> +	mutex_init(&imgld->lock);
> +
> +	imgld->priv = priv;
> +	imgld->lops = lops;
> +
> +	imgld->dev.class = fpga_image_load_class;
> +	imgld->dev.parent = parent;
> +
> +	ret = dev_set_name(&imgld->dev, "fpga_image%d", id);

Is it better "fpga_image_load%d"?

> +	if (ret) {
> +		dev_err(parent, "Failed to set device name: fpga_image%d\n", id);
> +		goto error_device;
> +	}
> +
> +	ret = device_register(&imgld->dev);
> +	if (ret) {
> +		put_device(&imgld->dev);
> +		return ERR_PTR(ret);
> +	}
> +
> +	return imgld;
> +
> +error_device:
> +	xa_erase(&fpga_image_load_xa, imgld->dev.id);
> +
> +error_kfree:
> +	kfree(imgld);
> +
> +	return ERR_PTR(ret);
> +}
> +EXPORT_SYMBOL_GPL(fpga_image_load_register);
> +
> +/**
> + * fpga_image_load_unregister - unregister an FPGA image load device
> + *
> + * @imgld: pointer to struct fpga_image_load
> + *
> + * This function is intended for use in an FPGA Image Load driver's
> + * remove() function.
> + */
> +void fpga_image_load_unregister(struct fpga_image_load *imgld)
> +{
> +	device_unregister(&imgld->dev);
> +}
> +EXPORT_SYMBOL_GPL(fpga_image_load_unregister);
> +
> +static void fpga_image_load_dev_release(struct device *dev)
> +{
> +	struct fpga_image_load *imgld = to_image_load(dev);
> +
> +	xa_erase(&fpga_image_load_xa, imgld->dev.id);
> +	kfree(imgld);
> +}
> +
> +static int __init fpga_image_load_class_init(void)
> +{
> +	pr_info("FPGA Image Load Driver\n");
> +
> +	fpga_image_load_class = class_create(THIS_MODULE, "fpga_image_load");
> +	if (IS_ERR(fpga_image_load_class))
> +		return PTR_ERR(fpga_image_load_class);
> +
> +	fpga_image_load_class->dev_release = fpga_image_load_dev_release;
> +
> +	return 0;
> +}
> +
> +static void __exit fpga_image_load_class_exit(void)
> +{
> +	class_destroy(fpga_image_load_class);
> +	WARN_ON(!xa_empty(&fpga_image_load_xa));
> +}
> +
> +MODULE_DESCRIPTION("FPGA Image Load Driver");
> +MODULE_LICENSE("GPL v2");
> +
> +subsys_initcall(fpga_image_load_class_init);
> +module_exit(fpga_image_load_class_exit)
> diff --git a/include/linux/fpga/fpga-image-load.h b/include/linux/fpga/fpga-image-load.h
> new file mode 100644
> index 000000000000..a9cef9e1056b
> --- /dev/null
> +++ b/include/linux/fpga/fpga-image-load.h
> @@ -0,0 +1,35 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Header file for FPGA Image Load Driver
> + *
> + * Copyright (C) 2019-2021 Intel Corporation, Inc.
> + */
> +#ifndef _LINUX_FPGA_IMAGE_LOAD_H
> +#define _LINUX_FPGA_IMAGE_LOAD_H
> +
> +#include <linux/device.h>
> +#include <linux/mutex.h>
> +#include <linux/types.h>
> +
> +struct fpga_image_load;
> +
> +/**
> + * struct fpga_image_load_ops - device specific operations
> + */
> +struct fpga_image_load_ops {
> +};
> +
> +struct fpga_image_load {
> +	struct device dev;
> +	const struct fpga_image_load_ops *lops;
> +	struct mutex lock;		/* protect data structure contents */
> +	void *priv;
> +};
> +
> +struct fpga_image_load *
> +fpga_image_load_register(struct device *dev,
> +			 const struct fpga_image_load_ops *lops, void *priv);
> +
> +void fpga_image_load_unregister(struct fpga_image_load *imgld);
> +
> +#endif
> -- 
> 2.25.1

Thanks,
Yilun

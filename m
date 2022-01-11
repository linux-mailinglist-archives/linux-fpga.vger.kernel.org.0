Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A073248A7DF
	for <lists+linux-fpga@lfdr.de>; Tue, 11 Jan 2022 07:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233436AbiAKGnd (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 11 Jan 2022 01:43:33 -0500
Received: from mga09.intel.com ([134.134.136.24]:16144 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230516AbiAKGnd (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 11 Jan 2022 01:43:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641883413; x=1673419413;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=JC7uTHKkW5VTcbpX1uUCYsf2IvBEn/igMmqtR2ixWX0=;
  b=VhxioM/O+1v3jaDiROVtp3mxgs0aCY2qaSFsoynmUu7atqcbLfBDzzl3
   XPJ81Ffg6t9BDqX/Pk6eBn31SzQzc7Qyj1bX8ku7SD7Cmb9tMMbp2hQUS
   zrySTaw16g99vJ7xSpoAEuD7x9uCQGWjgurrXi60znV34h6ZSmavQgINZ
   EldapyHnW0DIfxNFMpikuADG03862Fbs5erpEl6TUNDWSUyUARNdAilqJ
   pcW+i3pIfUgOK6tsdI8mNyOrNRwO67ERvIiVoDv/x/XlzC/VQP0Vo2k4Y
   fof+uBAvGuCNj/JHkvVee4x4SR8uQMrTQ5uriMwKbmFn5gI2CGKpsIe8y
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10223"; a="243212774"
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="243212774"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 22:43:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="528613134"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.68])
  by orsmga008.jf.intel.com with ESMTP; 10 Jan 2022 22:43:29 -0800
Date:   Tue, 11 Jan 2022 14:35:35 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Tom Rix <trix@redhat.com>
Cc:     Lizhi Hou <lizhi.hou@xilinx.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org, maxz@xilinx.com,
        sonal.santan@xilinx.com, yliu@xilinx.com, michal.simek@xilinx.com,
        stefanos@xilinx.com, devicetree@vger.kernel.org, mdf@kernel.org,
        robh@kernel.org, dwmw2@infradead.org,
        Max Zhen <max.zhen@xilinx.com>
Subject: Re: [PATCH V4 XRT Alveo Infrastructure 4/5] fpga: xrt: xrt-lib
 common  interfaces
Message-ID: <20220111063535.GB979169@yilunxu-OptiPlex-7050>
References: <20220105225013.1567871-1-lizhi.hou@xilinx.com>
 <20220105225013.1567871-5-lizhi.hou@xilinx.com>
 <c2e3b692-011b-0536-68db-a09a436b01ef@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c2e3b692-011b-0536-68db-a09a436b01ef@redhat.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Sun, Jan 09, 2022 at 01:16:23PM -0800, Tom Rix wrote:
> 
> On 1/5/22 2:50 PM, Lizhi Hou wrote:
> > The Alveo platform has to PCI fucntions. Each function has its own driver
                           two
> > attached. The common interfaces are created to support both drivers.
> 
> The commit log should be more descriptive since this introduces a new class
> 
> of drivers.  Reuse the cover letter content.
> 
> > 
> > Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
> > Signed-off-by: Max Zhen <max.zhen@xilinx.com>
> > Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
> > ---
> >   drivers/fpga/Kconfig                  |   3 +
> >   drivers/fpga/Makefile                 |   3 +
> >   drivers/fpga/xrt/Kconfig              |   6 +
> >   drivers/fpga/xrt/include/xpartition.h |  28 ++++
> >   drivers/fpga/xrt/lib/Kconfig          |  17 +++
> >   drivers/fpga/xrt/lib/Makefile         |  15 +++
> >   drivers/fpga/xrt/lib/lib-drv.c        | 178 ++++++++++++++++++++++++++
> >   drivers/fpga/xrt/lib/lib-drv.h        |  15 +++
> >   8 files changed, 265 insertions(+)
> >   create mode 100644 drivers/fpga/xrt/Kconfig
> >   create mode 100644 drivers/fpga/xrt/include/xpartition.h
> >   create mode 100644 drivers/fpga/xrt/lib/Kconfig
> >   create mode 100644 drivers/fpga/xrt/lib/Makefile
> >   create mode 100644 drivers/fpga/xrt/lib/lib-drv.c
> >   create mode 100644 drivers/fpga/xrt/lib/lib-drv.h
> > 
> > diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> > index 991b3f361ec9..93ae387c97c5 100644
> > --- a/drivers/fpga/Kconfig
> > +++ b/drivers/fpga/Kconfig
> > @@ -243,4 +243,7 @@ config FPGA_MGR_VERSAL_FPGA
> >   	  configure the programmable logic(PL).
> >   	  To compile this as a module, choose M here.
> > +
> > +source "drivers/fpga/xrt/Kconfig"
> 
> This patchset will have 2 new Kconfigs and only 2 config setting.
> 
> To simplify, add the 2 config settings directly to fpga/Kconfig

Or have a xrt/Kconfig that records all config settings.

> 
> > +
> >   endif # FPGA
> > diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
> > index 0bff783d1b61..5bd41cf4c7ec 100644
> > --- a/drivers/fpga/Makefile
> > +++ b/drivers/fpga/Makefile
> > @@ -49,3 +49,6 @@ obj-$(CONFIG_FPGA_DFL_NIOS_INTEL_PAC_N3000)	+= dfl-n3000-nios.o
> >   # Drivers for FPGAs which implement DFL
> >   obj-$(CONFIG_FPGA_DFL_PCI)		+= dfl-pci.o
> > +
> > +# XRT drivers for Alveo
> > +obj-$(CONFIG_FPGA_XRT_LIB)		+= xrt/lib/

Have a xrt/Makefile that records all makings?

> > diff --git a/drivers/fpga/xrt/Kconfig b/drivers/fpga/xrt/Kconfig
> > new file mode 100644
> > index 000000000000..04c3bb5aaf4f
> > --- /dev/null
> > +++ b/drivers/fpga/xrt/Kconfig
> > @@ -0,0 +1,6 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +#
> > +# Xilinx Alveo FPGA device configuration
> > +#
> > +
> > +source "drivers/fpga/xrt/lib/Kconfig"
> > diff --git a/drivers/fpga/xrt/include/xpartition.h b/drivers/fpga/xrt/include/xpartition.h
> > new file mode 100644
> > index 000000000000..d72090ddfbee
> > --- /dev/null
> > +++ b/drivers/fpga/xrt/include/xpartition.h
> > @@ -0,0 +1,28 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2020-2022 Xilinx, Inc.
> > + *
> > + * Authors:
> > + *	Lizhi Hou <lizhih@xilinx.com>
> > + */
> > +
> > +#ifndef _XRT_PARTITION_H_
> > +#define _XRT_PARTITION_H_
> > +
> > +struct xrt_partition_range {
> > +	u32 bar_idx;
> > +	u64 base;
> > +	u64 size;
> > +};
> > +
> > +struct xrt_partition_info {
> > +	int num_range;
> > +	struct xrt_partition_range *ranges;
> > +	void *fdt;
> > +	u32 fdt_len;
> > +};
> > +
> > +int xrt_partition_create(struct device *dev, struct xrt_partition_info *info, void **handle);
> > +void xrt_partition_destroy(void *handle);
> > +
> > +#endif
> > diff --git a/drivers/fpga/xrt/lib/Kconfig b/drivers/fpga/xrt/lib/Kconfig
> > new file mode 100644
> > index 000000000000..73de1f50d5c6
> > --- /dev/null
> > +++ b/drivers/fpga/xrt/lib/Kconfig
> > @@ -0,0 +1,17 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +#
> > +# XRT Alveo FPGA device configuration
> > +#
> > +
> > +config FPGA_XRT_LIB
> > +	tristate "XRT Alveo Driver Library"
> > +	depends on HWMON && PCI && HAS_IOMEM && OF

depends on HWMON & PCI?

> > +	select REGMAP_MMIO
> > +	select OF_OVERLAY

Same concern, add options when you really need them.

> > +	help
> > +	  Select this option to enable Xilinx XRT Alveo driver library. This
> > +	  library is core infrastructure of XRT Alveo FPGA drivers which
> > +	  provides functions for working with device nodes, iteration and
> > +	  lookup of platform devices, common interfaces for platform devices,
> > +	  plumbing of function call and ioctls between platform devices and
> > +	  parent partitions.
> > diff --git a/drivers/fpga/xrt/lib/Makefile b/drivers/fpga/xrt/lib/Makefile
> > new file mode 100644
> > index 000000000000..698877c39657
> > --- /dev/null
> > +++ b/drivers/fpga/xrt/lib/Makefile
> > @@ -0,0 +1,15 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +#
> > +# Copyright (C) 2020-2022 Xilinx, Inc. All rights reserved.
> > +#
> > +# Authors: Sonal.Santan@xilinx.com
> > +#
> > +
> > +FULL_XRT_PATH=$(srctree)/$(src)/..
> > +
> > +obj-$(CONFIG_FPGA_XRT_LIB) += xrt-lib.o
> > +
> > +xrt-lib-objs :=			\
> > +	lib-drv.o
> > +
> > +ccflags-y := -I$(FULL_XRT_PATH)/include
> > diff --git a/drivers/fpga/xrt/lib/lib-drv.c b/drivers/fpga/xrt/lib/lib-drv.c
> > new file mode 100644
> > index 000000000000..56334b2b9bec
> > --- /dev/null
> > +++ b/drivers/fpga/xrt/lib/lib-drv.c
> > @@ -0,0 +1,178 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2020-2022 Xilinx, Inc.
> > + *
> > + * Authors:
> > + *	Cheng Zhen <maxz@xilinx.com>
> > + *	Lizhi Hou <lizhi.hou@xilinx.com>
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/slab.h>
> > +#include <linux/vmalloc.h>
> > +#include <linux/of.h>
> > +#include <linux/of_fdt.h>
> > +#include <linux/of_device.h>
> > +#include <linux/of_platform.h>
> > +#include "xpartition.h"
> > +#include "lib-drv.h"
> > +
> > +#define XRT_PARTITION_FDT_ALIGN		8
> > +#define XRT_PARTITION_NAME_LEN		64
> > +
> > +struct xrt_partition {
> > +	struct device *dev;
> > +	u32 id;
> > +	char name[XRT_PARTITION_NAME_LEN];
> > +	void *fdt;
> > +	struct property ranges;
> > +	struct of_changeset chgset;
> > +	bool chgset_applied;
> > +	void *dn_mem;
> > +};
> > +
> > +DEFINE_IDA(xrt_partition_id);
> > +
> > +static int xrt_partition_set_ranges(struct xrt_partition *xp, struct xrt_partition_range *ranges,
> > +				    int num_range)
> > +{
> > +	__be64 *prop;
> > +	u32 prop_len;
> > +	int i;
> > +
> > +	prop_len = num_range * (sizeof(u64) * 3);
> > +	prop = kzalloc(prop_len, GFP_KERNEL);
> > +	if (!prop)
> > +		return -ENOMEM;
> > +
> > +	xp->ranges.name = "ranges";
> > +	xp->ranges.length = prop_len;
> > +	xp->ranges.value = prop;
> > +
> > +	for (i = 0; i < num_range; i++) {
> > +		*prop = cpu_to_be64((u64)ranges[i].bar_idx << 60);
> > +		prop++;
> > +		*prop = cpu_to_be64(ranges[i].base);
> > +		prop++;
> > +		*prop = cpu_to_be64(ranges[i].size);
> > +		prop++;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +void xrt_partition_destroy(void *handle)
> > +{
> > +	struct xrt_partition *xp = handle;
> > +
> > +	if (xp->chgset_applied)
> > +		of_changeset_revert(&xp->chgset);
> > +	of_changeset_destroy(&xp->chgset);
> > +
> > +	ida_free(&xrt_partition_id, xp->id);
> > +	kfree(xp->dn_mem);
> > +	kfree(xp->fdt);
> > +	kfree(xp->ranges.value);
> > +	kfree(xp);
> > +}
> > +EXPORT_SYMBOL_GPL(xrt_partition_destroy);
> > +
> > +int xrt_partition_create(struct device *dev, struct xrt_partition_info *info, void **handle)
> > +{
> > +	struct device_node *parent_dn = NULL, *dn, *part_dn;
> > +	struct xrt_partition *xp = NULL;
> > +	void *fdt_aligned;
> > +	int ret;
> > +
> > +	xp = kzalloc(sizeof(*xp), GFP_KERNEL);
> > +	if (!xp)
> > +		return -ENOMEM;
> > +
> > +	ret = ida_alloc(&xrt_partition_id, GFP_KERNEL);
> > +	if (ret < 0) {
> > +		dev_err(dev, "alloc id failed, ret %d", ret);
> > +		kfree(xp);
> > +		return ret;
> > +	}
> > +	xp->id = ret;
> > +	of_changeset_init(&xp->chgset);
> > +
> > +	parent_dn = of_find_node_by_path("/");
> > +	if (!parent_dn) {
> > +		dev_err(dev, "did not find xrt node");
> > +		ret = -EINVAL;
> > +		goto failed;
> > +	}
> > +
> > +	xp->dev = dev;
> > +	snprintf(xp->name, XRT_PARTITION_NAME_LEN, "xrt-part@%x", xp->id);
> > +	ret = xrt_partition_set_ranges(xp, info->ranges, info->num_range);
> > +	if (ret)
> > +		goto failed;
> > +
> > +	xp->fdt = kmalloc(info->fdt_len + XRT_PARTITION_FDT_ALIGN, GFP_KERNEL);
> > +	if (!xp->fdt) {
> > +		ret = -ENOMEM;
> > +		goto failed;
> > +	}
> > +	fdt_aligned = PTR_ALIGN(xp->fdt, XRT_PARTITION_FDT_ALIGN);
> > +	memcpy(fdt_aligned, info->fdt, info->fdt_len);
> > +
> > +	xp->dn_mem = of_fdt_unflatten_tree(fdt_aligned, NULL, &part_dn);
> > +	if (!xp->dn_mem) {
> > +		ret = -EINVAL;
> > +		goto failed;
> > +	}
> > +
> > +	of_node_get(part_dn);
> > +	part_dn->full_name = xp->name;
> > +	part_dn->parent = parent_dn;
> > +	for (dn = part_dn; dn; dn = of_find_all_nodes(dn))
> > +		of_changeset_attach_node(&xp->chgset, dn);
> > +
> > +	ret = of_changeset_add_property(&xp->chgset, part_dn, &xp->ranges);
> > +	if (ret) {
> > +		dev_err(dev, "failed to add property, ret %d", ret);
> > +		goto failed;
> > +	}
> > +
> > +	ret = of_changeset_apply(&xp->chgset);
> > +	if (ret) {
> > +		dev_err(dev, "failed to apply changeset, ret %d", ret);
> > +		goto failed;
> > +	}
> > +	xp->chgset_applied = true;
> > +	of_node_put(parent_dn);
> > +
> > +	ret = of_platform_populate(part_dn, NULL, NULL, dev);
> > +	if (ret) {
> > +		dev_err(dev, "failed to populate devices, ret %d", ret);
> > +		goto failed;
> > +	}
> > +
> > +	*handle = xp;
> > +	return 0;
> > +
> > +failed:
> > +	if (parent_dn)
> > +		of_node_put(parent_dn);
> > +	xrt_partition_destroy(xp);
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(xrt_partition_create);

Maybe you could put the necessary lib functions and the callers in the
same patch next time, for easier review.

> > +
> > +static __init int xrt_lib_init(void)
> > +{
> > +	return 0;
> > +}
> > +
> > +static __exit void xrt_lib_fini(void)
> > +{
> > +}
> > +
> > +module_init(xrt_lib_init);
> > +module_exit(xrt_lib_fini);
> noops
> > +
> > +MODULE_AUTHOR("XRT Team <runtime@xilinx.com>");
> > +MODULE_DESCRIPTION("Xilinx Alveo IP Lib driver");
> > +MODULE_LICENSE("GPL v2");
> > diff --git a/drivers/fpga/xrt/lib/lib-drv.h b/drivers/fpga/xrt/lib/lib-drv.h
> > new file mode 100644
> > index 000000000000..77ed5c399dcf
> > --- /dev/null
> > +++ b/drivers/fpga/xrt/lib/lib-drv.h
> > @@ -0,0 +1,15 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2020-2022 Xilinx, Inc.
> > + *
> > + * Authors:
> > + *	Cheng Zhen <maxz@xilinx.com>
> > + */
> > +
> > +#ifndef _LIB_DRV_H_
> > +#define _LIB_DRV_H_
> header guards should have a consistent prefix and this one is a little
> generic, append _XRT
> > +
> > +extern u8 __dtb_xrt_begin[];
> > +extern u8 __dtb_xrt_end[];
> 
> I could not find where these were used in the patch.
> 
> Maybe consolidate all the xrt/lib/*.h to just this one file.
> 
> Tom

Thanks,
Yilun

> 
> > +
> > +#endif	/* _LIB_DRV_H_ */

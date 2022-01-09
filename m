Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A314488C7E
	for <lists+linux-fpga@lfdr.de>; Sun,  9 Jan 2022 22:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237047AbiAIVQa (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 9 Jan 2022 16:16:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:29663 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233251AbiAIVQa (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 9 Jan 2022 16:16:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641762989;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QlsXrbBeuHOIa6FHEgTbopC7quMKemellkAYuzXHtDY=;
        b=UPH7eYiqM2ymVYGoJ+omi9WRbfxmCoLpt8aqD2/J5fwoAtNJoS+VGCv7ELoMG0L66Vi5fb
        cLI3l8TNtLcdRer/S/CLBN27W1HiZ0NpepMtGCtJwL/+wVz+RglbSBHs/XXc9WnaSQ9qcr
        tL8BMX5km+haaGAmGJbN6l2mbtkIPUw=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-7-WDb0hrKKNXyrbAvvO7_-yg-1; Sun, 09 Jan 2022 16:16:28 -0500
X-MC-Unique: WDb0hrKKNXyrbAvvO7_-yg-1
Received: by mail-oo1-f71.google.com with SMTP id n5-20020a4ab345000000b002dc79e4a2baso3462464ooo.15
        for <linux-fpga@vger.kernel.org>; Sun, 09 Jan 2022 13:16:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=QlsXrbBeuHOIa6FHEgTbopC7quMKemellkAYuzXHtDY=;
        b=ps6qAjKixM1SbRYJ37v6KCR6fMV4chLNKJJ7B+aA99j5K7mHHzjVgIdXY3Q1EqJk3N
         z0omeCRd/1xH+MPwAMtWfnTjQ1+uFuKc7Cu1beNgujrMSAnN8c6NqK/bK3uAk1TWd+t8
         4NJIcCd0OLrvYbxOo6gvKLq9bL6XrQmAa/6JadhJb9kNg0hWLBluEGfogO149eHO6ISQ
         W/aqWY3F9quB9v31RoAy3KNcwdpp0atYLM99SdYilKCq7JT1lfn28SaFy48n7OZuO91o
         Q8BgOjfO1fAImM/t2jmsLrUv8zzrtQg8vPl0IsQGBg18smPHoqyRrd5YH9J82Hbsajj2
         4GnA==
X-Gm-Message-State: AOAM530iuNzgTivG9SBAC+dVhEDvvrb5W6sISDiccfUiTuZ5FVl2QaCW
        YUDHSfJO+7YjB64mWdOKEF392AL8spnb2J4Bu8eNhL2ogmhTfNI7uLH5qiSILlp0uIt6IS/jntY
        9j9cEI7cBHQyT9RAWUI2INQ==
X-Received: by 2002:a4a:c18e:: with SMTP id w14mr12374021oop.41.1641762987038;
        Sun, 09 Jan 2022 13:16:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx5uzkh3hmGQuDCpoQEf2N0HI+ebkPwu2D2esqxL221JB5r63tW6ACPosV6bn/UKhxXWBaEnA==
X-Received: by 2002:a4a:c18e:: with SMTP id w14mr12374013oop.41.1641762986588;
        Sun, 09 Jan 2022 13:16:26 -0800 (PST)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id w20sm1111818otl.40.2022.01.09.13.16.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Jan 2022 13:16:26 -0800 (PST)
Subject: Re: [PATCH V4 XRT Alveo Infrastructure 4/5] fpga: xrt: xrt-lib common
 interfaces
To:     Lizhi Hou <lizhi.hou@xilinx.com>, linux-kernel@vger.kernel.org
Cc:     linux-fpga@vger.kernel.org, maxz@xilinx.com,
        sonal.santan@xilinx.com, yliu@xilinx.com, michal.simek@xilinx.com,
        stefanos@xilinx.com, devicetree@vger.kernel.org, mdf@kernel.org,
        robh@kernel.org, dwmw2@infradead.org,
        Max Zhen <max.zhen@xilinx.com>
References: <20220105225013.1567871-1-lizhi.hou@xilinx.com>
 <20220105225013.1567871-5-lizhi.hou@xilinx.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <c2e3b692-011b-0536-68db-a09a436b01ef@redhat.com>
Date:   Sun, 9 Jan 2022 13:16:23 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220105225013.1567871-5-lizhi.hou@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 1/5/22 2:50 PM, Lizhi Hou wrote:
> The Alveo platform has to PCI fucntions. Each function has its own driver
> attached. The common interfaces are created to support both drivers.

The commit log should be more descriptive since this introduces a new class

of drivers.  Reuse the cover letter content.

>
> Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
> Signed-off-by: Max Zhen <max.zhen@xilinx.com>
> Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
> ---
>   drivers/fpga/Kconfig                  |   3 +
>   drivers/fpga/Makefile                 |   3 +
>   drivers/fpga/xrt/Kconfig              |   6 +
>   drivers/fpga/xrt/include/xpartition.h |  28 ++++
>   drivers/fpga/xrt/lib/Kconfig          |  17 +++
>   drivers/fpga/xrt/lib/Makefile         |  15 +++
>   drivers/fpga/xrt/lib/lib-drv.c        | 178 ++++++++++++++++++++++++++
>   drivers/fpga/xrt/lib/lib-drv.h        |  15 +++
>   8 files changed, 265 insertions(+)
>   create mode 100644 drivers/fpga/xrt/Kconfig
>   create mode 100644 drivers/fpga/xrt/include/xpartition.h
>   create mode 100644 drivers/fpga/xrt/lib/Kconfig
>   create mode 100644 drivers/fpga/xrt/lib/Makefile
>   create mode 100644 drivers/fpga/xrt/lib/lib-drv.c
>   create mode 100644 drivers/fpga/xrt/lib/lib-drv.h
>
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index 991b3f361ec9..93ae387c97c5 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -243,4 +243,7 @@ config FPGA_MGR_VERSAL_FPGA
>   	  configure the programmable logic(PL).
>   
>   	  To compile this as a module, choose M here.
> +
> +source "drivers/fpga/xrt/Kconfig"

This patchset will have 2 new Kconfigs and only 2 config setting.

To simplify, add the 2 config settings directly to fpga/Kconfig

> +
>   endif # FPGA
> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
> index 0bff783d1b61..5bd41cf4c7ec 100644
> --- a/drivers/fpga/Makefile
> +++ b/drivers/fpga/Makefile
> @@ -49,3 +49,6 @@ obj-$(CONFIG_FPGA_DFL_NIOS_INTEL_PAC_N3000)	+= dfl-n3000-nios.o
>   
>   # Drivers for FPGAs which implement DFL
>   obj-$(CONFIG_FPGA_DFL_PCI)		+= dfl-pci.o
> +
> +# XRT drivers for Alveo
> +obj-$(CONFIG_FPGA_XRT_LIB)		+= xrt/lib/
> diff --git a/drivers/fpga/xrt/Kconfig b/drivers/fpga/xrt/Kconfig
> new file mode 100644
> index 000000000000..04c3bb5aaf4f
> --- /dev/null
> +++ b/drivers/fpga/xrt/Kconfig
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Xilinx Alveo FPGA device configuration
> +#
> +
> +source "drivers/fpga/xrt/lib/Kconfig"
> diff --git a/drivers/fpga/xrt/include/xpartition.h b/drivers/fpga/xrt/include/xpartition.h
> new file mode 100644
> index 000000000000..d72090ddfbee
> --- /dev/null
> +++ b/drivers/fpga/xrt/include/xpartition.h
> @@ -0,0 +1,28 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2020-2022 Xilinx, Inc.
> + *
> + * Authors:
> + *	Lizhi Hou <lizhih@xilinx.com>
> + */
> +
> +#ifndef _XRT_PARTITION_H_
> +#define _XRT_PARTITION_H_
> +
> +struct xrt_partition_range {
> +	u32 bar_idx;
> +	u64 base;
> +	u64 size;
> +};
> +
> +struct xrt_partition_info {
> +	int num_range;
> +	struct xrt_partition_range *ranges;
> +	void *fdt;
> +	u32 fdt_len;
> +};
> +
> +int xrt_partition_create(struct device *dev, struct xrt_partition_info *info, void **handle);
> +void xrt_partition_destroy(void *handle);
> +
> +#endif
> diff --git a/drivers/fpga/xrt/lib/Kconfig b/drivers/fpga/xrt/lib/Kconfig
> new file mode 100644
> index 000000000000..73de1f50d5c6
> --- /dev/null
> +++ b/drivers/fpga/xrt/lib/Kconfig
> @@ -0,0 +1,17 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# XRT Alveo FPGA device configuration
> +#
> +
> +config FPGA_XRT_LIB
> +	tristate "XRT Alveo Driver Library"
> +	depends on HWMON && PCI && HAS_IOMEM && OF
> +	select REGMAP_MMIO
> +	select OF_OVERLAY
> +	help
> +	  Select this option to enable Xilinx XRT Alveo driver library. This
> +	  library is core infrastructure of XRT Alveo FPGA drivers which
> +	  provides functions for working with device nodes, iteration and
> +	  lookup of platform devices, common interfaces for platform devices,
> +	  plumbing of function call and ioctls between platform devices and
> +	  parent partitions.
> diff --git a/drivers/fpga/xrt/lib/Makefile b/drivers/fpga/xrt/lib/Makefile
> new file mode 100644
> index 000000000000..698877c39657
> --- /dev/null
> +++ b/drivers/fpga/xrt/lib/Makefile
> @@ -0,0 +1,15 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Copyright (C) 2020-2022 Xilinx, Inc. All rights reserved.
> +#
> +# Authors: Sonal.Santan@xilinx.com
> +#
> +
> +FULL_XRT_PATH=$(srctree)/$(src)/..
> +
> +obj-$(CONFIG_FPGA_XRT_LIB) += xrt-lib.o
> +
> +xrt-lib-objs :=			\
> +	lib-drv.o
> +
> +ccflags-y := -I$(FULL_XRT_PATH)/include
> diff --git a/drivers/fpga/xrt/lib/lib-drv.c b/drivers/fpga/xrt/lib/lib-drv.c
> new file mode 100644
> index 000000000000..56334b2b9bec
> --- /dev/null
> +++ b/drivers/fpga/xrt/lib/lib-drv.c
> @@ -0,0 +1,178 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2020-2022 Xilinx, Inc.
> + *
> + * Authors:
> + *	Cheng Zhen <maxz@xilinx.com>
> + *	Lizhi Hou <lizhi.hou@xilinx.com>
> + */
> +
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/vmalloc.h>
> +#include <linux/of.h>
> +#include <linux/of_fdt.h>
> +#include <linux/of_device.h>
> +#include <linux/of_platform.h>
> +#include "xpartition.h"
> +#include "lib-drv.h"
> +
> +#define XRT_PARTITION_FDT_ALIGN		8
> +#define XRT_PARTITION_NAME_LEN		64
> +
> +struct xrt_partition {
> +	struct device *dev;
> +	u32 id;
> +	char name[XRT_PARTITION_NAME_LEN];
> +	void *fdt;
> +	struct property ranges;
> +	struct of_changeset chgset;
> +	bool chgset_applied;
> +	void *dn_mem;
> +};
> +
> +DEFINE_IDA(xrt_partition_id);
> +
> +static int xrt_partition_set_ranges(struct xrt_partition *xp, struct xrt_partition_range *ranges,
> +				    int num_range)
> +{
> +	__be64 *prop;
> +	u32 prop_len;
> +	int i;
> +
> +	prop_len = num_range * (sizeof(u64) * 3);
> +	prop = kzalloc(prop_len, GFP_KERNEL);
> +	if (!prop)
> +		return -ENOMEM;
> +
> +	xp->ranges.name = "ranges";
> +	xp->ranges.length = prop_len;
> +	xp->ranges.value = prop;
> +
> +	for (i = 0; i < num_range; i++) {
> +		*prop = cpu_to_be64((u64)ranges[i].bar_idx << 60);
> +		prop++;
> +		*prop = cpu_to_be64(ranges[i].base);
> +		prop++;
> +		*prop = cpu_to_be64(ranges[i].size);
> +		prop++;
> +	}
> +
> +	return 0;
> +}
> +
> +void xrt_partition_destroy(void *handle)
> +{
> +	struct xrt_partition *xp = handle;
> +
> +	if (xp->chgset_applied)
> +		of_changeset_revert(&xp->chgset);
> +	of_changeset_destroy(&xp->chgset);
> +
> +	ida_free(&xrt_partition_id, xp->id);
> +	kfree(xp->dn_mem);
> +	kfree(xp->fdt);
> +	kfree(xp->ranges.value);
> +	kfree(xp);
> +}
> +EXPORT_SYMBOL_GPL(xrt_partition_destroy);
> +
> +int xrt_partition_create(struct device *dev, struct xrt_partition_info *info, void **handle)
> +{
> +	struct device_node *parent_dn = NULL, *dn, *part_dn;
> +	struct xrt_partition *xp = NULL;
> +	void *fdt_aligned;
> +	int ret;
> +
> +	xp = kzalloc(sizeof(*xp), GFP_KERNEL);
> +	if (!xp)
> +		return -ENOMEM;
> +
> +	ret = ida_alloc(&xrt_partition_id, GFP_KERNEL);
> +	if (ret < 0) {
> +		dev_err(dev, "alloc id failed, ret %d", ret);
> +		kfree(xp);
> +		return ret;
> +	}
> +	xp->id = ret;
> +	of_changeset_init(&xp->chgset);
> +
> +	parent_dn = of_find_node_by_path("/");
> +	if (!parent_dn) {
> +		dev_err(dev, "did not find xrt node");
> +		ret = -EINVAL;
> +		goto failed;
> +	}
> +
> +	xp->dev = dev;
> +	snprintf(xp->name, XRT_PARTITION_NAME_LEN, "xrt-part@%x", xp->id);
> +	ret = xrt_partition_set_ranges(xp, info->ranges, info->num_range);
> +	if (ret)
> +		goto failed;
> +
> +	xp->fdt = kmalloc(info->fdt_len + XRT_PARTITION_FDT_ALIGN, GFP_KERNEL);
> +	if (!xp->fdt) {
> +		ret = -ENOMEM;
> +		goto failed;
> +	}
> +	fdt_aligned = PTR_ALIGN(xp->fdt, XRT_PARTITION_FDT_ALIGN);
> +	memcpy(fdt_aligned, info->fdt, info->fdt_len);
> +
> +	xp->dn_mem = of_fdt_unflatten_tree(fdt_aligned, NULL, &part_dn);
> +	if (!xp->dn_mem) {
> +		ret = -EINVAL;
> +		goto failed;
> +	}
> +
> +	of_node_get(part_dn);
> +	part_dn->full_name = xp->name;
> +	part_dn->parent = parent_dn;
> +	for (dn = part_dn; dn; dn = of_find_all_nodes(dn))
> +		of_changeset_attach_node(&xp->chgset, dn);
> +
> +	ret = of_changeset_add_property(&xp->chgset, part_dn, &xp->ranges);
> +	if (ret) {
> +		dev_err(dev, "failed to add property, ret %d", ret);
> +		goto failed;
> +	}
> +
> +	ret = of_changeset_apply(&xp->chgset);
> +	if (ret) {
> +		dev_err(dev, "failed to apply changeset, ret %d", ret);
> +		goto failed;
> +	}
> +	xp->chgset_applied = true;
> +	of_node_put(parent_dn);
> +
> +	ret = of_platform_populate(part_dn, NULL, NULL, dev);
> +	if (ret) {
> +		dev_err(dev, "failed to populate devices, ret %d", ret);
> +		goto failed;
> +	}
> +
> +	*handle = xp;
> +	return 0;
> +
> +failed:
> +	if (parent_dn)
> +		of_node_put(parent_dn);
> +	xrt_partition_destroy(xp);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(xrt_partition_create);
> +
> +static __init int xrt_lib_init(void)
> +{
> +	return 0;
> +}
> +
> +static __exit void xrt_lib_fini(void)
> +{
> +}
> +
> +module_init(xrt_lib_init);
> +module_exit(xrt_lib_fini);
noops
> +
> +MODULE_AUTHOR("XRT Team <runtime@xilinx.com>");
> +MODULE_DESCRIPTION("Xilinx Alveo IP Lib driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/fpga/xrt/lib/lib-drv.h b/drivers/fpga/xrt/lib/lib-drv.h
> new file mode 100644
> index 000000000000..77ed5c399dcf
> --- /dev/null
> +++ b/drivers/fpga/xrt/lib/lib-drv.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2020-2022 Xilinx, Inc.
> + *
> + * Authors:
> + *	Cheng Zhen <maxz@xilinx.com>
> + */
> +
> +#ifndef _LIB_DRV_H_
> +#define _LIB_DRV_H_
header guards should have a consistent prefix and this one is a little 
generic, append _XRT
> +
> +extern u8 __dtb_xrt_begin[];
> +extern u8 __dtb_xrt_end[];

I could not find where these were used in the patch.

Maybe consolidate all the xrt/lib/*.h to just this one file.

Tom

> +
> +#endif	/* _LIB_DRV_H_ */


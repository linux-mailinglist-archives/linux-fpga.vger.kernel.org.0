Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24689320DA7
	for <lists+linux-fpga@lfdr.de>; Sun, 21 Feb 2021 21:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbhBUUkX (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 21 Feb 2021 15:40:23 -0500
Received: from mail-pg1-f172.google.com ([209.85.215.172]:45084 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbhBUUkV (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 21 Feb 2021 15:40:21 -0500
Received: by mail-pg1-f172.google.com with SMTP id p21so8836214pgl.12;
        Sun, 21 Feb 2021 12:40:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HHIRMMKElR7qt/qK4sUuMdT/ZhoEzcXLzRz90+ElSFA=;
        b=JaenpsSMRo2rabbKUD+6kBrvkI+a3eVk9ksRrwGTJOMmXsBYSXPBFM4E6yPr98QTMs
         jRxhyKF6anf1PnivMpBehxlHItt9aBwoWy3mN4x9y4VnQ9BS4diLPibyJ9PGjLCxRVkH
         CiZeNLJ5gfQi2YJnpEE0jYY5wHxe01HIliO5ccnTfV6D0/zgh7FzYEQP67UigxyxKkFR
         EcVHk026ngO9UfBTECm8H+Qu3q7TKSdMRl7JqH2ENZ83UGMP9KhhQZtdRGtAhNyNy8OR
         GYErccUVdcGqF8sQA0GHdRWr3Llym+Tz85MKJcoCpXAJRL4apnBKf6T52aI/f7pUi6kI
         nF3Q==
X-Gm-Message-State: AOAM531IaqJFfWHTU3Q0BuQEbv4RQ3muU5mJ/Ti+x001hbgelFUdyM7B
        OA5pZWj5ybxiDfrSEXBlLmMDKF23sy7TBg==
X-Google-Smtp-Source: ABdhPJxnsfw8vud1fFj+y0HFsqfuVW0SUd8Zo1cAXWcxl8iCVtM7OYEmtLX/Xqo+gZlh2bOVYrz2Dg==
X-Received: by 2002:aa7:9205:0:b029:1ec:8eab:7ca3 with SMTP id 5-20020aa792050000b02901ec8eab7ca3mr19356292pfo.20.1613939980110;
        Sun, 21 Feb 2021 12:39:40 -0800 (PST)
Received: from localhost ([2601:647:5b00:1162:1ac0:17a6:4cc6:d1ef])
        by smtp.gmail.com with ESMTPSA id 23sm10812502pfx.44.2021.02.21.12.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Feb 2021 12:39:39 -0800 (PST)
Date:   Sun, 21 Feb 2021 12:39:42 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     Lizhi Hou <lizhi.hou@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, Lizhi Hou <lizhih@xilinx.com>,
        linux-fpga@vger.kernel.org, maxz@xilinx.com,
        sonal.santan@xilinx.com, michal.simek@xilinx.com,
        stefanos@xilinx.com, devicetree@vger.kernel.org, trix@redhat.com,
        mdf@kernel.org, robh@kernel.org, Max Zhen <max.zhen@xilinx.com>
Subject: Re: [PATCH V3 XRT Alveo 04/18] fpga: xrt: xrt-lib platform driver
 manager
Message-ID: <YDLFDpJ4STer/yKx@archbook>
References: <20210218064019.29189-1-lizhih@xilinx.com>
 <20210218064019.29189-5-lizhih@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210218064019.29189-5-lizhih@xilinx.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Lizhi,

On Wed, Feb 17, 2021 at 10:40:05PM -0800, Lizhi Hou wrote:
> xrt-lib kernel module infrastructure code to register and manage all
> leaf driver modules.
> 
> Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
> Signed-off-by: Max Zhen <max.zhen@xilinx.com>
> Signed-off-by: Lizhi Hou <lizhih@xilinx.com>
> ---
>  drivers/fpga/xrt/lib/main.c | 274 ++++++++++++++++++++++++++++++++++++
>  drivers/fpga/xrt/lib/main.h |  17 +++
>  2 files changed, 291 insertions(+)
>  create mode 100644 drivers/fpga/xrt/lib/main.c
>  create mode 100644 drivers/fpga/xrt/lib/main.h
> 
> diff --git a/drivers/fpga/xrt/lib/main.c b/drivers/fpga/xrt/lib/main.c
> new file mode 100644
> index 000000000000..36fb62710843
> --- /dev/null
> +++ b/drivers/fpga/xrt/lib/main.c
> @@ -0,0 +1,274 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Driver for Xilinx Alveo FPGA Support
> + *
> + * Copyright (C) 2020-2021 Xilinx, Inc.
> + *
> + * Authors:
> + *	Cheng Zhen <maxz@xilinx.com>
> + */
> +
> +#include <linux/module.h>
> +#include "xleaf.h"
> +#include "xroot.h"
> +#include "main.h"
> +
> +#define XRT_IPLIB_MODULE_NAME		"xrt-lib"
> +#define XRT_IPLIB_MODULE_VERSION	"4.0.0"
> +#define XRT_MAX_DEVICE_NODES		128
> +#define XRT_DRVNAME(drv)		((drv)->driver.name)
> +
> +/*
> + * Subdev driver is known by ID to others. We map the ID to it's
> + * struct platform_driver, which contains it's binding name and driver/file ops.
> + * We also map it to the endpoint name in DTB as well, if it's different
> + * than the driver's binding name.
> + */
> +struct xrt_drv_map {
> +	struct list_head list;
> +	enum xrt_subdev_id id;
> +	struct platform_driver *drv;
> +	struct xrt_subdev_endpoints *eps;
> +	struct ida ida; /* manage driver instance and char dev minor */
> +};
> +
> +static DEFINE_MUTEX(xrt_lib_lock); /* global lock protecting xrt_drv_maps list */
> +static LIST_HEAD(xrt_drv_maps);
> +struct class *xrt_class;
> +
> +static inline struct xrt_subdev_drvdata *
> +xrt_drv_map2drvdata(struct xrt_drv_map *map)
> +{
> +	return (struct xrt_subdev_drvdata *)map->drv->id_table[0].driver_data;
> +}
> +
> +static struct xrt_drv_map *
> +xrt_drv_find_map_by_id_nolock(enum xrt_subdev_id id)
> +{
> +	const struct list_head *ptr;
> +
> +	list_for_each(ptr, &xrt_drv_maps) {
> +		struct xrt_drv_map *tmap = list_entry(ptr, struct xrt_drv_map, list);
list_for_each_entry, maybe?
> +
> +		if (tmap->id == id)
> +			return tmap;
> +	}
> +	return NULL;
> +}
> +
> +static struct xrt_drv_map *
> +xrt_drv_find_map_by_id(enum xrt_subdev_id id)
> +{
> +	struct xrt_drv_map *map;
> +
> +	mutex_lock(&xrt_lib_lock);
> +	map = xrt_drv_find_map_by_id_nolock(id);
> +	mutex_unlock(&xrt_lib_lock);
> +	/*
> +	 * map should remain valid even after lock is dropped since a registered
> +	 * driver should only be unregistered when driver module is being unloaded,
> +	 * which means that the driver should not be used by then.
> +	 */
> +	return map;
> +}
> +
> +static int xrt_drv_register_driver(struct xrt_drv_map *map)
> +{
> +	struct xrt_subdev_drvdata *drvdata;
> +	int rc = 0;
> +	const char *drvname = XRT_DRVNAME(map->drv);
> +
> +	rc = platform_driver_register(map->drv);
> +	if (rc) {
> +		pr_err("register %s platform driver failed\n", drvname);
> +		return rc;
> +	}
> +
> +	drvdata = xrt_drv_map2drvdata(map);
> +	if (drvdata) {
> +		/* Initialize dev_t for char dev node. */
> +		if (xleaf_devnode_enabled(drvdata)) {
> +			rc = alloc_chrdev_region(&drvdata->xsd_file_ops.xsf_dev_t, 0,
> +						 XRT_MAX_DEVICE_NODES, drvname);
> +			if (rc) {
> +				platform_driver_unregister(map->drv);
> +				pr_err("failed to alloc dev minor for %s: %d\n", drvname, rc);
> +				return rc;
> +			}
> +		} else {
> +			drvdata->xsd_file_ops.xsf_dev_t = (dev_t)-1;
> +		}
> +	}
> +
> +	ida_init(&map->ida);
> +
> +	pr_info("%s registered successfully\n", drvname);
Is this not xrt_info() then?
> +
> +	return 0;
> +}
> +
> +static void xrt_drv_unregister_driver(struct xrt_drv_map *map)
> +{
> +	const char *drvname = XRT_DRVNAME(map->drv);
> +	struct xrt_subdev_drvdata *drvdata;
> +
> +	ida_destroy(&map->ida);
> +
> +	drvdata = xrt_drv_map2drvdata(map);
> +	if (drvdata && drvdata->xsd_file_ops.xsf_dev_t != (dev_t)-1) {
> +		unregister_chrdev_region(drvdata->xsd_file_ops.xsf_dev_t,
> +					 XRT_MAX_DEVICE_NODES);
> +	}
> +
> +	platform_driver_unregister(map->drv);
> +
> +	pr_info("%s unregistered successfully\n", drvname);
> +}
> +
> +int xleaf_register_driver(enum xrt_subdev_id id,
> +			  struct platform_driver *drv,
> +			  struct xrt_subdev_endpoints *eps)
> +{
> +	struct xrt_drv_map *map;
> +
> +	mutex_lock(&xrt_lib_lock);
> +
> +	map = xrt_drv_find_map_by_id_nolock(id);
> +	if (map) {
> +		mutex_unlock(&xrt_lib_lock);
> +		pr_err("Id %d already has a registered driver, 0x%p\n",
> +		       id, map->drv);
> +		return -EEXIST;
> +	}
> +
> +	map = vzalloc(sizeof(*map));
> +	if (!map) {
> +		mutex_unlock(&xrt_lib_lock);
> +		return -ENOMEM;
> +	}
> +	map->id = id;
> +	map->drv = drv;
> +	map->eps = eps;
> +
> +	xrt_drv_register_driver(map);
> +
> +	list_add(&map->list, &xrt_drv_maps);
> +
> +	mutex_unlock(&xrt_lib_lock);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(xleaf_register_driver);
> +
> +void xleaf_unregister_driver(enum xrt_subdev_id id)
> +{
> +	struct xrt_drv_map *map;
> +
> +	mutex_lock(&xrt_lib_lock);
> +
> +	map = xrt_drv_find_map_by_id_nolock(id);
> +	if (!map) {
> +		mutex_unlock(&xrt_lib_lock);
> +		pr_err("Id %d has no registered driver\n", id);
> +		return;
> +	}
> +
> +	list_del(&map->list);
> +
> +	mutex_unlock(&xrt_lib_lock);
> +
> +	xrt_drv_unregister_driver(map);
> +	vfree(map);
> +}
> +EXPORT_SYMBOL_GPL(xleaf_unregister_driver);
> +
> +const char *xrt_drv_name(enum xrt_subdev_id id)
> +{
> +	struct xrt_drv_map *map = xrt_drv_find_map_by_id(id);
> +
> +	if (map)
> +		return XRT_DRVNAME(map->drv);
> +	return NULL;
> +}
> +
> +int xrt_drv_get_instance(enum xrt_subdev_id id)
> +{
> +	struct xrt_drv_map *map = xrt_drv_find_map_by_id(id);
> +
> +	return ida_alloc_range(&map->ida, 0, XRT_MAX_DEVICE_NODES, GFP_KERNEL);
> +}
> +
> +void xrt_drv_put_instance(enum xrt_subdev_id id, int instance)
> +{
> +	struct xrt_drv_map *map = xrt_drv_find_map_by_id(id);
> +
> +	ida_free(&map->ida, instance);
> +}
> +
> +struct xrt_subdev_endpoints *xrt_drv_get_endpoints(enum xrt_subdev_id id)
> +{
> +	struct xrt_drv_map *map = xrt_drv_find_map_by_id(id);
> +	struct xrt_subdev_endpoints *eps;
> +
> +	eps = map ? map->eps : NULL;
> +	return eps;
> +}
> +
> +/* Leaf driver's module init/fini callbacks. */
> +static void (*leaf_init_fini_cbs[])(bool) = {
> +	group_leaf_init_fini,
> +	vsec_leaf_init_fini,
> +	devctl_leaf_init_fini,
> +	axigate_leaf_init_fini,
> +	icap_leaf_init_fini,
> +	calib_leaf_init_fini,
> +	clkfreq_leaf_init_fini,
> +	clock_leaf_init_fini,
> +	ucs_leaf_init_fini,
> +};
> +
> +static __init int xrt_lib_init(void)
> +{
> +	int i;
> +
> +	xrt_class = class_create(THIS_MODULE, XRT_IPLIB_MODULE_NAME);
> +	if (IS_ERR(xrt_class))
> +		return PTR_ERR(xrt_class);
> +
> +	for (i = 0; i < ARRAY_SIZE(leaf_init_fini_cbs); i++)
> +		leaf_init_fini_cbs[i](true);
> +	return 0;
> +}
> +
> +static __exit void xrt_lib_fini(void)
> +{
> +	struct xrt_drv_map *map;
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(leaf_init_fini_cbs); i++)
> +		leaf_init_fini_cbs[i](false);
> +
> +	mutex_lock(&xrt_lib_lock);
> +
> +	while (!list_empty(&xrt_drv_maps)) {
> +		map = list_first_entry_or_null(&xrt_drv_maps, struct xrt_drv_map, list);
> +		pr_err("Unloading module with %s still registered\n", XRT_DRVNAME(map->drv));
> +		list_del(&map->list);
> +		mutex_unlock(&xrt_lib_lock);
> +		xrt_drv_unregister_driver(map);
> +		vfree(map);
> +		mutex_lock(&xrt_lib_lock);
> +	}
> +
> +	mutex_unlock(&xrt_lib_lock);
> +
> +	class_destroy(xrt_class);
> +}
> +
> +module_init(xrt_lib_init);
> +module_exit(xrt_lib_fini);
> +
> +MODULE_VERSION(XRT_IPLIB_MODULE_VERSION);
> +MODULE_AUTHOR("XRT Team <runtime@xilinx.com>");
> +MODULE_DESCRIPTION("Xilinx Alveo IP Lib driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/fpga/xrt/lib/main.h b/drivers/fpga/xrt/lib/main.h
> new file mode 100644
> index 000000000000..f3bfc87ee614
> --- /dev/null
> +++ b/drivers/fpga/xrt/lib/main.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2020-2021 Xilinx, Inc.
> + *
> + * Authors:
> + *	Cheng Zhen <maxz@xilinx.com>
> + */
> +
> +#ifndef _XRT_MAIN_H_
> +#define _XRT_MAIN_H_
> +
> +const char *xrt_drv_name(enum xrt_subdev_id id);
> +int xrt_drv_get_instance(enum xrt_subdev_id id);
> +void xrt_drv_put_instance(enum xrt_subdev_id id, int instance);
> +struct xrt_subdev_endpoints *xrt_drv_get_endpoints(enum xrt_subdev_id id);
> +
> +#endif	/* _XRT_MAIN_H_ */
> -- 
> 2.18.4
> 

This smells like it should be a bus to me...

- Moritz

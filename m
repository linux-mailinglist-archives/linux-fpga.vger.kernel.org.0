Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 295403224B5
	for <lists+linux-fpga@lfdr.de>; Tue, 23 Feb 2021 04:36:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbhBWDgW (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 22 Feb 2021 22:36:22 -0500
Received: from mail-pf1-f175.google.com ([209.85.210.175]:33824 "EHLO
        mail-pf1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbhBWDgW (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 22 Feb 2021 22:36:22 -0500
Received: by mail-pf1-f175.google.com with SMTP id m6so7955005pfk.1;
        Mon, 22 Feb 2021 19:36:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=H2J5wziZsYc8+BUp4JjXv7YRZAB9ZHjD0cUAu7yvr4o=;
        b=NG7XbEFIdBWdfxIpg8ow3ndYp//fuA5E2cbeRr0aMsFlaufpdjPjQnYK2XN/K6s+L9
         r986v4N9EdZeIo2R2Hgjt0UwAH6wr6M6Bi9HoCcRi/woa+oCNA9e3o85ftxuZxlpsgY/
         5G1AZ6BY2AxzujuI20+vJqryXtNvRE2swtuXd4GXLxztuFzxNhQDLIcq9iDZMLKriM2F
         c+EiayUGE4j3pgGvq4uIXzxRmqmYsl5zw84izyuFlEghULacZtp5btdbMs1OVHz+DCsn
         1ONF5WR8nKjoOTGQ/XxW6jKTwzz6v3J6ViriX+sMf9DWD92u2jAwlmFnfs6DhiR9zD4Q
         sj6A==
X-Gm-Message-State: AOAM531+qnDdY37UC4WGPob2AP8OU5XDuXP7xpoDs5n3h9osfNoF11qQ
        dlhbZ6p9CHIH3/VNRmdIOt4=
X-Google-Smtp-Source: ABdhPJz5mUyby0lU17TuL1ZMo5WT/R7fA8aQWHcQ1iHUzNB21bn8g0HgbIaj4Emf1pMxYp/h5EgxiA==
X-Received: by 2002:a63:ab4f:: with SMTP id k15mr22190203pgp.280.1614051340723;
        Mon, 22 Feb 2021 19:35:40 -0800 (PST)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id h23sm20633441pfn.118.2021.02.22.19.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 19:35:40 -0800 (PST)
Date:   Mon, 22 Feb 2021 19:35:39 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     Tom Rix <trix@redhat.com>
Cc:     Lizhi Hou <lizhi.hou@xilinx.com>, linux-kernel@vger.kernel.org,
        Lizhi Hou <lizhih@xilinx.com>, linux-fpga@vger.kernel.org,
        maxz@xilinx.com, sonal.santan@xilinx.com, michal.simek@xilinx.com,
        stefanos@xilinx.com, devicetree@vger.kernel.org, mdf@kernel.org,
        robh@kernel.org, Max Zhen <max.zhen@xilinx.com>
Subject: Re: [PATCH V3 XRT Alveo 04/18] fpga: xrt: xrt-lib platform driver
 manager
Message-ID: <YDR4CyHu2tum0zIJ@epycbox.lan>
References: <20210218064019.29189-1-lizhih@xilinx.com>
 <20210218064019.29189-5-lizhih@xilinx.com>
 <b93fb3ad-bbde-81db-d448-72fb8049f323@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b93fb3ad-bbde-81db-d448-72fb8049f323@redhat.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Feb 22, 2021 at 07:05:29AM -0800, Tom Rix wrote:
> 
> On 2/17/21 10:40 PM, Lizhi Hou wrote:
> > xrt-lib kernel module infrastructure code to register and manage all
> > leaf driver modules.
> >
> > Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
> > Signed-off-by: Max Zhen <max.zhen@xilinx.com>
> > Signed-off-by: Lizhi Hou <lizhih@xilinx.com>
> > ---
> >  drivers/fpga/xrt/lib/main.c | 274 ++++++++++++++++++++++++++++++++++++
> >  drivers/fpga/xrt/lib/main.h |  17 +++
> >  2 files changed, 291 insertions(+)
> >  create mode 100644 drivers/fpga/xrt/lib/main.c
> >  create mode 100644 drivers/fpga/xrt/lib/main.h
> 
> Not sure if 'main' is a good base name for something going into a lib.
> 
> >
> > diff --git a/drivers/fpga/xrt/lib/main.c b/drivers/fpga/xrt/lib/main.c
> > new file mode 100644
> > index 000000000000..36fb62710843
> > --- /dev/null
> > +++ b/drivers/fpga/xrt/lib/main.c
> > @@ -0,0 +1,274 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Driver for Xilinx Alveo FPGA Support
> > + *
> > + * Copyright (C) 2020-2021 Xilinx, Inc.
> > + *
> > + * Authors:
> > + *	Cheng Zhen <maxz@xilinx.com>
> > + */
> > +
> > +#include <linux/module.h>
> > +#include "xleaf.h"
> > +#include "xroot.h"
> > +#include "main.h"
> > +
> > +#define XRT_IPLIB_MODULE_NAME		"xrt-lib"
> > +#define XRT_IPLIB_MODULE_VERSION	"4.0.0"
> > +#define XRT_MAX_DEVICE_NODES		128
> > +#define XRT_DRVNAME(drv)		((drv)->driver.name)
> > +
> > +/*
> > + * Subdev driver is known by ID to others. We map the ID to it's
> by it's ID
> > + * struct platform_driver, which contains it's binding name and driver/file ops.
> > + * We also map it to the endpoint name in DTB as well, if it's different
> > + * than the driver's binding name.
> > + */
> > +struct xrt_drv_map {
> > +	struct list_head list;
> > +	enum xrt_subdev_id id;
> > +	struct platform_driver *drv;
> > +	struct xrt_subdev_endpoints *eps;
> > +	struct ida ida; /* manage driver instance and char dev minor */
> > +};
> > +
> > +static DEFINE_MUTEX(xrt_lib_lock); /* global lock protecting xrt_drv_maps list */
> > +static LIST_HEAD(xrt_drv_maps);
> > +struct class *xrt_class;
> > +
> > +static inline struct xrt_subdev_drvdata *
> > +xrt_drv_map2drvdata(struct xrt_drv_map *map)
> > +{
> > +	return (struct xrt_subdev_drvdata *)map->drv->id_table[0].driver_data;
> > +}
> > +
> > +static struct xrt_drv_map *
> > +xrt_drv_find_map_by_id_nolock(enum xrt_subdev_id id)
> 
> name could be by convention
> 
> __xrt_drv_find_map_id
> 
> > +{
> > +	const struct list_head *ptr;
> > +
> > +	list_for_each(ptr, &xrt_drv_maps) {
> > +		struct xrt_drv_map *tmap = list_entry(ptr, struct xrt_drv_map, list);
> > +
> > +		if (tmap->id == id)
> > +			return tmap;
> > +	}
> > +	return NULL;
> > +}
> > +
> > +static struct xrt_drv_map *
> > +xrt_drv_find_map_by_id(enum xrt_subdev_id id)
> > +{
> > +	struct xrt_drv_map *map;
> > +
> > +	mutex_lock(&xrt_lib_lock);
> > +	map = xrt_drv_find_map_by_id_nolock(id);
> > +	mutex_unlock(&xrt_lib_lock);
> > +	/*
> > +	 * map should remain valid even after lock is dropped since a registered
> even after the lock
> > +	 * driver should only be unregistered when driver module is being unloaded,
> > +	 * which means that the driver should not be used by then.
> > +	 */
> > +	return map;
> > +}
> > +
> > +static int xrt_drv_register_driver(struct xrt_drv_map *map)
> > +{
> > +	struct xrt_subdev_drvdata *drvdata;
> > +	int rc = 0;
> > +	const char *drvname = XRT_DRVNAME(map->drv);
> > +
> > +	rc = platform_driver_register(map->drv);
> > +	if (rc) {
> > +		pr_err("register %s platform driver failed\n", drvname);
> > +		return rc;
> > +	}
> > +
> > +	drvdata = xrt_drv_map2drvdata(map);
> > +	if (drvdata) {
> > +		/* Initialize dev_t for char dev node. */
> > +		if (xleaf_devnode_enabled(drvdata)) {
> > +			rc = alloc_chrdev_region(&drvdata->xsd_file_ops.xsf_dev_t, 0,
> > +						 XRT_MAX_DEVICE_NODES, drvname);
> > +			if (rc) {
> > +				platform_driver_unregister(map->drv);
> > +				pr_err("failed to alloc dev minor for %s: %d\n", drvname, rc);
> > +				return rc;
> > +			}
> > +		} else {
> > +			drvdata->xsd_file_ops.xsf_dev_t = (dev_t)-1;
> > +		}
> > +	}
> > +
> > +	ida_init(&map->ida);
> > +
> > +	pr_info("%s registered successfully\n", drvname);
> > +
> > +	return 0;
> > +}
> > +
> > +static void xrt_drv_unregister_driver(struct xrt_drv_map *map)
> > +{
> > +	const char *drvname = XRT_DRVNAME(map->drv);
> > +	struct xrt_subdev_drvdata *drvdata;
> > +
> > +	ida_destroy(&map->ida);
> > +
> > +	drvdata = xrt_drv_map2drvdata(map);
> > +	if (drvdata && drvdata->xsd_file_ops.xsf_dev_t != (dev_t)-1) {
> > +		unregister_chrdev_region(drvdata->xsd_file_ops.xsf_dev_t,
> > +					 XRT_MAX_DEVICE_NODES);
> > +	}
> > +
> > +	platform_driver_unregister(map->drv);
> > +
> > +	pr_info("%s unregistered successfully\n", drvname);
> > +}
> > +
> > +int xleaf_register_driver(enum xrt_subdev_id id,
> > +			  struct platform_driver *drv,
> > +			  struct xrt_subdev_endpoints *eps)
> > +{
> > +	struct xrt_drv_map *map;
> > +
> > +	mutex_lock(&xrt_lib_lock);
> 
> Trying to minimize length of lock being held.
> 
> Could holding this lock be split or the alloc moved above ?
> 
> > +
> > +	map = xrt_drv_find_map_by_id_nolock(id);
> > +	if (map) {
> > +		mutex_unlock(&xrt_lib_lock);
> > +		pr_err("Id %d already has a registered driver, 0x%p\n",
> > +		       id, map->drv);
> > +		return -EEXIST;
> > +	}
> > +
> > +	map = vzalloc(sizeof(*map));
> 
> general issue
> 
> map is small, so kzalloc
> 
> > +	if (!map) {
> > +		mutex_unlock(&xrt_lib_lock);
> > +		return -ENOMEM;
> > +	}
> > +	map->id = id;
> > +	map->drv = drv;
> > +	map->eps = eps;
> > +
> > +	xrt_drv_register_driver(map);
> 
> xrt_drv_register_driver failure is unhandled.
> 
> This is the only time xrt_drv_register_driver is called, consider expanding the function here and removing the call.
> 
> > +
> > +	list_add(&map->list, &xrt_drv_maps);
> > +
> > +	mutex_unlock(&xrt_lib_lock);
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(xleaf_register_driver);
> > +
> > +void xleaf_unregister_driver(enum xrt_subdev_id id)
> > +{
> > +	struct xrt_drv_map *map;
> > +
> > +	mutex_lock(&xrt_lib_lock);
> > +
> > +	map = xrt_drv_find_map_by_id_nolock(id);
> > +	if (!map) {
> > +		mutex_unlock(&xrt_lib_lock);
> > +		pr_err("Id %d has no registered driver\n", id);
> > +		return;
> > +	}
> > +
> > +	list_del(&map->list);
> > +
> > +	mutex_unlock(&xrt_lib_lock);
> > +
> > +	xrt_drv_unregister_driver(map);
> > +	vfree(map);
> > +}
> > +EXPORT_SYMBOL_GPL(xleaf_unregister_driver);
> > +
> > +const char *xrt_drv_name(enum xrt_subdev_id id)
> > +{
> > +	struct xrt_drv_map *map = xrt_drv_find_map_by_id(id);
> > +
> > +	if (map)
> > +		return XRT_DRVNAME(map->drv);
> > +	return NULL;
> > +}
> > +
> > +int xrt_drv_get_instance(enum xrt_subdev_id id)
> > +{
> > +	struct xrt_drv_map *map = xrt_drv_find_map_by_id(id);
> > +
> > +	return ida_alloc_range(&map->ida, 0, XRT_MAX_DEVICE_NODES, GFP_KERNEL);
> > +}
> > +
> > +void xrt_drv_put_instance(enum xrt_subdev_id id, int instance)
> > +{
> > +	struct xrt_drv_map *map = xrt_drv_find_map_by_id(id);
> > +
> > +	ida_free(&map->ida, instance);
> > +}
> > +
> > +struct xrt_subdev_endpoints *xrt_drv_get_endpoints(enum xrt_subdev_id id)
> > +{
> > +	struct xrt_drv_map *map = xrt_drv_find_map_by_id(id);
> > +	struct xrt_subdev_endpoints *eps;
> > +
> > +	eps = map ? map->eps : NULL;
> > +	return eps;
> > +}
> > +
> > +/* Leaf driver's module init/fini callbacks. */
> 
> These constructor/destructor calls needs to be more dynamic.
> 
> calls are made even if there are no subdevices to go with the id's.
> 
> Also this list can not grow.  How would a new id be added by a module ?
> 
> > +static void (*leaf_init_fini_cbs[])(bool) = {
> > +	group_leaf_init_fini,
> > +	vsec_leaf_init_fini,
> > +	devctl_leaf_init_fini,
> > +	axigate_leaf_init_fini,
> > +	icap_leaf_init_fini,
> > +	calib_leaf_init_fini,
> > +	clkfreq_leaf_init_fini,
> > +	clock_leaf_init_fini,
> > +	ucs_leaf_init_fini,
> > +};
> > +
> > +static __init int xrt_lib_init(void)
> > +{
> > +	int i;
> > +
> > +	xrt_class = class_create(THIS_MODULE, XRT_IPLIB_MODULE_NAME);
> > +	if (IS_ERR(xrt_class))
> > +		return PTR_ERR(xrt_class);
> > +
> > +	for (i = 0; i < ARRAY_SIZE(leaf_init_fini_cbs); i++)
> > +		leaf_init_fini_cbs[i](true);
> > +	return 0;
> > +}
> > +
> > +static __exit void xrt_lib_fini(void)
> > +{
> > +	struct xrt_drv_map *map;
> > +	int i;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(leaf_init_fini_cbs); i++)
> > +		leaf_init_fini_cbs[i](false);
> > +
> > +	mutex_lock(&xrt_lib_lock);
> > +
> > +	while (!list_empty(&xrt_drv_maps)) {
> > +		map = list_first_entry_or_null(&xrt_drv_maps, struct xrt_drv_map, list);
> > +		pr_err("Unloading module with %s still registered\n", XRT_DRVNAME(map->drv));
> > +		list_del(&map->list);
> > +		mutex_unlock(&xrt_lib_lock);
> > +		xrt_drv_unregister_driver(map);
> > +		vfree(map);
> > +		mutex_lock(&xrt_lib_lock);
> > +	}
> > +
> > +	mutex_unlock(&xrt_lib_lock);
> > +
> > +	class_destroy(xrt_class);
> > +}
> > +
> > +module_init(xrt_lib_init);
> > +module_exit(xrt_lib_fini);
> > +
> > +MODULE_VERSION(XRT_IPLIB_MODULE_VERSION);
> > +MODULE_AUTHOR("XRT Team <runtime@xilinx.com>");
> > +MODULE_DESCRIPTION("Xilinx Alveo IP Lib driver");
> > +MODULE_LICENSE("GPL v2");
> > diff --git a/drivers/fpga/xrt/lib/main.h b/drivers/fpga/xrt/lib/main.h
> > new file mode 100644
> > index 000000000000..f3bfc87ee614
> > --- /dev/null
> > +++ b/drivers/fpga/xrt/lib/main.h
> > @@ -0,0 +1,17 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2020-2021 Xilinx, Inc.
> > + *
> > + * Authors:
> > + *	Cheng Zhen <maxz@xilinx.com>
> > + */
> > +
> > +#ifndef _XRT_MAIN_H_
> > +#define _XRT_MAIN_H_
> > +
> > +const char *xrt_drv_name(enum xrt_subdev_id id);
> 
> To be self contained, the header defining enum xrt_subdev_id should be included.
> 
> This is subdev_id.h which comes in with patch 6
> 
> A dependency on a future patch breaks bisectablity.
> 
> It may make sense to collect these small headers into a single large header for the ip infra lib and bring them all in this patch.

Please add the headers when you use them, do *not* do header only commits.

It's perfectly fine (and desirable) to add things over time to a header
as you use them.

Note *each* commit must compile and work standing on its own, so yes as
Tom pointed out, do not depend on future (later commit) files.

> 
> Tom
> 
> > +int xrt_drv_get_instance(enum xrt_subdev_id id);
> > +void xrt_drv_put_instance(enum xrt_subdev_id id, int instance);
> > +struct xrt_subdev_endpoints *xrt_drv_get_endpoints(enum xrt_subdev_id id);
> > +
> > +#endif	/* _XRT_MAIN_H_ */
> 

- Moritz

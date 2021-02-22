Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76E28321AC5
	for <lists+linux-fpga@lfdr.de>; Mon, 22 Feb 2021 16:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbhBVPHJ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 22 Feb 2021 10:07:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35706 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230500AbhBVPHE (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 22 Feb 2021 10:07:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614006335;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jfLiXK853Af1kpeF/zm3Muk1EF9s40aEj3nT84zY5gY=;
        b=Or536OOnw+iVjh7ijIHm1UQYNsG5HxRU6LDIJkZDAD8TRuseEpqr/Wbnq4dX/tlsp8gsF9
        LbwIpOl2RLyuDc05YODVzXxH2I5GE8Q0JQvd7zD7hkQIkieNe/5sSpTyb0w7MzTDuXUjvc
        Bw6X7UhePbPL4E8ihDjSbYynGQpVf9U=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-gVjrW9OiM1im15UvI-VLLQ-1; Mon, 22 Feb 2021 10:05:33 -0500
X-MC-Unique: gVjrW9OiM1im15UvI-VLLQ-1
Received: by mail-qt1-f199.google.com with SMTP id z3so7841719qtv.20
        for <linux-fpga@vger.kernel.org>; Mon, 22 Feb 2021 07:05:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=jfLiXK853Af1kpeF/zm3Muk1EF9s40aEj3nT84zY5gY=;
        b=PxZ2o1JtdbQ2TD5fsP736m2SOa7LngOqFKOEJcDyNzH7WuuWhdv5INvIQuPyGutsMv
         hgaWJPtwanGmv2ZTzcpjtqaui7Fz7q8gge2K6Zzdry6Em6O/qtYAQoZ9YVOt83OSLB4S
         ZAKxG+uGjj1x8ZMMuv8hBnPdkXWSq2jxVhagcsWc39bH6pZM8TD0JjWdL4UnJlDab1i7
         BKHaB1WfOAbvXebml7TC7xjU7BOslwMInymTohz3oENFpXcidktEwCIcnWfWka4V+OHI
         WAPLSHNzkWk2TLXrxrSAQnTI/YPJMPCq2BqlNn0dounRfpGghxns+SLLF9ba6f4ZmJlI
         CGWg==
X-Gm-Message-State: AOAM531l7Zg+h+jbX0QF1xq0NJR++LZprSNFkwD0nHyActgD0wDtZm9J
        uc2moEoghXZJvd7+MzNHqkAi0icu2KZ2+xAkLSirx2KI27hW/8e5raxkGYR/eyZmUpTXctrL0Bx
        OZqYMeffe5OWXnDcFyP0YsQ==
X-Received: by 2002:a37:6348:: with SMTP id x69mr20862390qkb.254.1614006331990;
        Mon, 22 Feb 2021 07:05:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzrq+L4B1BnH+O9XSPxa50MZXky4EblzpAR85A0xm+pmjp03ZouWKADpoR+8D6lvfa0Lu/eUQ==
X-Received: by 2002:a37:6348:: with SMTP id x69mr20862361qkb.254.1614006331672;
        Mon, 22 Feb 2021 07:05:31 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id v135sm12562346qka.98.2021.02.22.07.05.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Feb 2021 07:05:31 -0800 (PST)
Subject: Re: [PATCH V3 XRT Alveo 04/18] fpga: xrt: xrt-lib platform driver
 manager
To:     Lizhi Hou <lizhi.hou@xilinx.com>, linux-kernel@vger.kernel.org
Cc:     Lizhi Hou <lizhih@xilinx.com>, linux-fpga@vger.kernel.org,
        maxz@xilinx.com, sonal.santan@xilinx.com, michal.simek@xilinx.com,
        stefanos@xilinx.com, devicetree@vger.kernel.org, mdf@kernel.org,
        robh@kernel.org, Max Zhen <max.zhen@xilinx.com>
References: <20210218064019.29189-1-lizhih@xilinx.com>
 <20210218064019.29189-5-lizhih@xilinx.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <b93fb3ad-bbde-81db-d448-72fb8049f323@redhat.com>
Date:   Mon, 22 Feb 2021 07:05:29 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210218064019.29189-5-lizhih@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 2/17/21 10:40 PM, Lizhi Hou wrote:
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

Not sure if 'main' is a good base name for something going into a lib.

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
by it's ID
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

name could be by convention

__xrt_drv_find_map_id

> +{
> +	const struct list_head *ptr;
> +
> +	list_for_each(ptr, &xrt_drv_maps) {
> +		struct xrt_drv_map *tmap = list_entry(ptr, struct xrt_drv_map, list);
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
even after the lock
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

Trying to minimize length of lock being held.

Could holding this lock be split or the alloc moved above ?

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

general issue

map is small, so kzalloc

> +	if (!map) {
> +		mutex_unlock(&xrt_lib_lock);
> +		return -ENOMEM;
> +	}
> +	map->id = id;
> +	map->drv = drv;
> +	map->eps = eps;
> +
> +	xrt_drv_register_driver(map);

xrt_drv_register_driver failure is unhandled.

This is the only time xrt_drv_register_driver is called, consider expanding the function here and removing the call.

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

These constructor/destructor calls needs to be more dynamic.

calls are made even if there are no subdevices to go with the id's.

Also this list can not grow.  How would a new id be added by a module ?

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

To be self contained, the header defining enum xrt_subdev_id should be included.

This is subdev_id.h which comes in with patch 6

A dependency on a future patch breaks bisectablity.

It may make sense to collect these small headers into a single large header for the ip infra lib and bring them all in this patch.

Tom

> +int xrt_drv_get_instance(enum xrt_subdev_id id);
> +void xrt_drv_put_instance(enum xrt_subdev_id id, int instance);
> +struct xrt_subdev_endpoints *xrt_drv_get_endpoints(enum xrt_subdev_id id);
> +
> +#endif	/* _XRT_MAIN_H_ */


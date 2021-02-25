Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB7D32592C
	for <lists+linux-fpga@lfdr.de>; Thu, 25 Feb 2021 23:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233952AbhBYWB1 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 25 Feb 2021 17:01:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34473 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234055AbhBYWBL (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 25 Feb 2021 17:01:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614290372;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lPo0lrOYI4NMOljtP5y4qTyMBp/r53Wo+7ixQwBy0qo=;
        b=GtmEZWVZD4vlffdZC0le51Hh6PtAeB4mu5L0s3xr7SdRFBf/U7DHUZk2Pdxhnwbg+IxF7J
        1xfpr5GUOtwQ04l2jpzA39h23FkZToQAH+JNA3DGNxTzFhtYFBocM9PResnUa175JBrzxG
        Yc12Olq8qT1z9cD3L1k8e9LFjypRZf8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-JQm7qkSyPZm6mxPOJ5AIpw-1; Thu, 25 Feb 2021 16:59:29 -0500
X-MC-Unique: JQm7qkSyPZm6mxPOJ5AIpw-1
Received: by mail-qv1-f71.google.com with SMTP id e9so5336171qvf.21
        for <linux-fpga@vger.kernel.org>; Thu, 25 Feb 2021 13:59:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=lPo0lrOYI4NMOljtP5y4qTyMBp/r53Wo+7ixQwBy0qo=;
        b=RzUvAsAsmXv2jZEv0C2RSfrQW76AF6EbjXa9xq0lbLaY9fpxG5xKCDHwL7K14Text5
         y7+sLmtnKMWBkWYi52XzCwvZiT4Zk+J0LHOsl+/b3OKlfl8xKbyncUhb+zdzbNzR6bQk
         NXZVM46tTyE4HyeUgpjDpiz14GLmCNwlM18GCIMendSrAVGEdyucMyCwqTi2zKG7N6h4
         0wFkwxZE5RbSWoXaugFlKsg226Z6wDofSZMRQnKzjqdi+H6D6K/MnxGf85WMMm33WSWB
         x3rq+20BA8IzJg5xi8/PgAClsc5pjqvwMSQj+l+Njbz+a5pvNMEz3P27I/JbLu1v7Sgz
         ze4A==
X-Gm-Message-State: AOAM5322XhCB/XP9777yAth2Xht/Xz9MWIuRYLwhIWOGU/0laMnFMnrG
        3SXH6ehLmGA8sScGu361pa4DQB0W2XjTF38YwBmml+EQq/q6lEMRs8EKFnkOrtJUmXWX5o3unS3
        mkDO/yQTvexCgQ0spYIDoWg==
X-Received: by 2002:ae9:e418:: with SMTP id q24mr4766724qkc.409.1614290368308;
        Thu, 25 Feb 2021 13:59:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxpVSLRF4EAAJvV5p4L5TpGmKsBqmi5oFwipXJZpPTc6MpT4cajqaYb4RPBBiwviVIW0hn4vQ==
X-Received: by 2002:ae9:e418:: with SMTP id q24mr4766662qkc.409.1614290367215;
        Thu, 25 Feb 2021 13:59:27 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id i16sm4982945qkk.104.2021.02.25.13.59.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Feb 2021 13:59:26 -0800 (PST)
Subject: Re: [PATCH V3 XRT Alveo 06/18] fpga: xrt: platform driver
 infrastructure
To:     Lizhi Hou <lizhi.hou@xilinx.com>, linux-kernel@vger.kernel.org
Cc:     Lizhi Hou <lizhih@xilinx.com>, linux-fpga@vger.kernel.org,
        maxz@xilinx.com, sonal.santan@xilinx.com, michal.simek@xilinx.com,
        stefanos@xilinx.com, devicetree@vger.kernel.org, mdf@kernel.org,
        robh@kernel.org, Max Zhen <max.zhen@xilinx.com>
References: <20210218064019.29189-1-lizhih@xilinx.com>
 <20210218064019.29189-7-lizhih@xilinx.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <45b8d30f-5350-e36c-09b9-2741cba80a60@redhat.com>
Date:   Thu, 25 Feb 2021 13:59:24 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210218064019.29189-7-lizhih@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 2/17/21 10:40 PM, Lizhi Hou wrote:
> infrastructure code providing APIs for managing leaf driver instance
> groups, facilitating inter-leaf driver calls and root calls, managing leaf
> driver device nodes.
>
> Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
> Signed-off-by: Max Zhen <max.zhen@xilinx.com>
> Signed-off-by: Lizhi Hou <lizhih@xilinx.com>
> ---
>  drivers/fpga/xrt/include/events.h    |  48 ++
>  drivers/fpga/xrt/include/subdev_id.h |  43 ++
>  drivers/fpga/xrt/include/xleaf.h     | 276 +++++++++
>  drivers/fpga/xrt/lib/cdev.c          | 231 +++++++
>  drivers/fpga/xrt/lib/subdev.c        | 871 +++++++++++++++++++++++++++
>  drivers/fpga/xrt/lib/subdev_pool.h   |  53 ++
>  drivers/fpga/xrt/lib/xroot.c         | 598 ++++++++++++++++++
>  7 files changed, 2120 insertions(+)
>  create mode 100644 drivers/fpga/xrt/include/events.h
>  create mode 100644 drivers/fpga/xrt/include/subdev_id.h
>  create mode 100644 drivers/fpga/xrt/include/xleaf.h
>  create mode 100644 drivers/fpga/xrt/lib/cdev.c
>  create mode 100644 drivers/fpga/xrt/lib/subdev.c
>  create mode 100644 drivers/fpga/xrt/lib/subdev_pool.h
>  create mode 100644 drivers/fpga/xrt/lib/xroot.c
>
> diff --git a/drivers/fpga/xrt/include/events.h b/drivers/fpga/xrt/include/events.h
> new file mode 100644
> index 000000000000..2a9aae8bceb4
> --- /dev/null
> +++ b/drivers/fpga/xrt/include/events.h
> @@ -0,0 +1,48 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Header file for Xilinx Runtime (XRT) driver
general problem with generic, low information comments
> + *
> + * Copyright (C) 2020-2021 Xilinx, Inc.
> + *
> + * Authors:
> + *	Cheng Zhen <maxz@xilinx.com>
> + */
> +
> +#ifndef _XRT_EVENTS_H_
> +#define _XRT_EVENTS_H_
> +
> +#include <linux/platform_device.h>
why is platform_device.h needed ?
> +#include "subdev_id.h"
> +
> +/*
> + * Event notification.
> + */
> +enum xrt_events {
> +	XRT_EVENT_TEST = 0, /* for testing */
> +	/*
> +	 * Events related to specific subdev
> +	 * Callback arg: struct xrt_event_arg_subdev
> +	 */
> +	XRT_EVENT_POST_CREATION,
> +	XRT_EVENT_PRE_REMOVAL,
> +	/*
> +	 * Events related to change of the whole board
> +	 * Callback arg: <none>
> +	 */
> +	XRT_EVENT_PRE_HOT_RESET,
> +	XRT_EVENT_POST_HOT_RESET,
> +	XRT_EVENT_PRE_GATE_CLOSE,
> +	XRT_EVENT_POST_GATE_OPEN,
> +};
> +
> +struct xrt_event_arg_subdev {
> +	enum xrt_subdev_id xevt_subdev_id;
> +	int xevt_subdev_instance;
> +};
> +
> +struct xrt_event {
> +	enum xrt_events xe_evt;
> +	struct xrt_event_arg_subdev xe_subdev;
> +};
> +
> +#endif	/* _XRT_EVENTS_H_ */
> diff --git a/drivers/fpga/xrt/include/subdev_id.h b/drivers/fpga/xrt/include/subdev_id.h
> new file mode 100644
> index 000000000000..6205a9f26196
> --- /dev/null
> +++ b/drivers/fpga/xrt/include/subdev_id.h
> @@ -0,0 +1,43 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Header file for Xilinx Runtime (XRT) driver
> + *
> + * Copyright (C) 2020-2021 Xilinx, Inc.
> + *
> + * Authors:
> + *	Cheng Zhen <maxz@xilinx.com>
> + */
> +
> +#ifndef _XRT_SUBDEV_ID_H_
> +#define _XRT_SUBDEV_ID_H_
> +
> +/*
> + * Every subdev driver should have an ID for others to refer to it.
driver has an ID
> + * There can be unlimited number of instances of a subdev driver. A
unlimited? change to 'multiple'
> + * <subdev_id, subdev_instance> tuple should be a unique identification of
tuple is a unique
> + * a specific instance of a subdev driver.
> + * NOTE: PLEASE do not change the order of IDs. Sub devices in the same
> + * group are initialized by this order.
why does the order matter? the enums are all initialized
> + */
> +enum xrt_subdev_id {
> +	XRT_SUBDEV_GRP = 0,
> +	XRT_SUBDEV_VSEC = 1,
> +	XRT_SUBDEV_VSEC_GOLDEN = 2,
> +	XRT_SUBDEV_DEVCTL = 3,
> +	XRT_SUBDEV_AXIGATE = 4,
> +	XRT_SUBDEV_ICAP = 5,
> +	XRT_SUBDEV_TEST = 6,
> +	XRT_SUBDEV_MGMT_MAIN = 7,
> +	XRT_SUBDEV_QSPI = 8,
> +	XRT_SUBDEV_MAILBOX = 9,
> +	XRT_SUBDEV_CMC = 10,
> +	XRT_SUBDEV_CALIB = 11,
> +	XRT_SUBDEV_CLKFREQ = 12,
> +	XRT_SUBDEV_CLOCK = 13,
> +	XRT_SUBDEV_SRSR = 14,
> +	XRT_SUBDEV_UCS = 15,
> +	XRT_SUBDEV_NUM = 16, /* Total number of subdevs. */
> +	XRT_ROOT = -1, /* Special ID for root driver. */
> +};
> +
> +#endif	/* _XRT_SUBDEV_ID_H_ */
> diff --git a/drivers/fpga/xrt/include/xleaf.h b/drivers/fpga/xrt/include/xleaf.h
> new file mode 100644
> index 000000000000..10215a75d474
> --- /dev/null
> +++ b/drivers/fpga/xrt/include/xleaf.h
> @@ -0,0 +1,276 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Header file for Xilinx Runtime (XRT) driver
> + *
> + * Copyright (C) 2020-2021 Xilinx, Inc.
> + *
> + * Authors:
> + *    Cheng Zhen <maxz@xilinx.com>
> + *    Sonal Santan <sonal.santan@xilinx.com>
> + */
> +
> +#ifndef _XRT_XLEAF_H_
> +#define _XRT_XLEAF_H_
> +
> +#include <linux/mod_devicetable.h>
not needed
> +#include <linux/platform_device.h>
> +#include <linux/fs.h>
> +#include <linux/cdev.h>
> +#include <linux/pci.h>

not needed

check if includes are actually needed.

> +#include <linux/libfdt_env.h>
> +#include "libfdt.h"
> +#include "subdev_id.h"
> +#include "xroot.h"
> +#include "events.h"
> +
> +/* All subdev drivers should use below common routines to print out msg. */
> +#define DEV(pdev)	(&(pdev)->dev)
> +#define DEV_PDATA(pdev)					\
> +	((struct xrt_subdev_platdata *)dev_get_platdata(DEV(pdev)))
> +#define DEV_DRVDATA(pdev)				\
> +	((struct xrt_subdev_drvdata *)			\
> +	platform_get_device_id(pdev)->driver_data)
> +#define FMT_PRT(prt_fn, pdev, fmt, args...)		\
> +	({typeof(pdev) (_pdev) = (pdev);		\
> +	prt_fn(DEV(_pdev), "%s %s: " fmt,		\
> +	DEV_PDATA(_pdev)->xsp_root_name, __func__, ##args); })
> +#define xrt_err(pdev, fmt, args...) FMT_PRT(dev_err, pdev, fmt, ##args)
> +#define xrt_warn(pdev, fmt, args...) FMT_PRT(dev_warn, pdev, fmt, ##args)
> +#define xrt_info(pdev, fmt, args...) FMT_PRT(dev_info, pdev, fmt, ##args)
> +#define xrt_dbg(pdev, fmt, args...) FMT_PRT(dev_dbg, pdev, fmt, ##args)
> +
> +/* Starting IOCTL for common IOCTLs implemented by all leaves. */
> +#define XRT_XLEAF_COMMON_BASE	0
> +/* Starting IOCTL for leaves' specific IOCTLs. */
> +#define XRT_XLEAF_CUSTOM_BASE	64
> +enum xrt_xleaf_common_ioctl_cmd {
> +	XRT_XLEAF_EVENT = XRT_XLEAF_COMMON_BASE,
> +};
> +
> +/*
> + * If populated by subdev driver, infra will handle the mechanics of
> + * char device (un)registration.
> + */
> +enum xrt_subdev_file_mode {
> +	/* Infra create cdev, default file name */
> +	XRT_SUBDEV_FILE_DEFAULT = 0,
> +	/* Infra create cdev, need to encode inst num in file name */
> +	XRT_SUBDEV_FILE_MULTI_INST,
> +	/* No auto creation of cdev by infra, leaf handles it by itself */
> +	XRT_SUBDEV_FILE_NO_AUTO,
> +};
> +
> +struct xrt_subdev_file_ops {
> +	const struct file_operations xsf_ops;
> +	dev_t xsf_dev_t;
> +	const char *xsf_dev_name;
> +	enum xrt_subdev_file_mode xsf_mode;
> +};
> +
> +/*
> + * Subdev driver callbacks populated by subdev driver.
> + */
> +struct xrt_subdev_drv_ops {
> +	/*
> +	 * Per driver instance callback. The pdev points to the instance.
> +	 * If defined these are called by other leaf drivers.
If defined,
> +	 * Note that root driver may call into xsd_ioctl of a group driver.
> +	 */
> +	int (*xsd_ioctl)(struct platform_device *pdev, u32 cmd, void *arg);
> +};
> +
> +/*
> + * Defined and populated by subdev driver, exported as driver_data in
> + * struct platform_device_id.
> + */
> +struct xrt_subdev_drvdata {
> +	struct xrt_subdev_file_ops xsd_file_ops;
> +	struct xrt_subdev_drv_ops xsd_dev_ops;
> +};
> +
> +/*
> + * Partially initialized by the parent driver, then, passed in as subdev driver's
> + * platform data when creating subdev driver instance by calling platform
> + * device register API (platform_device_register_data() or the likes).
> + *
> + * Once device register API returns, platform driver framework makes a copy of
> + * this buffer and maintains its life cycle. The content of the buffer is
> + * completely owned by subdev driver.
> + *
> + * Thus, parent driver should be very careful when it touches this buffer
> + * again once it's handed over to subdev driver. And the data structure
> + * should not contain pointers pointing to buffers that is managed by
> + * other or parent drivers since it could have been freed before platform
> + * data buffer is freed by platform driver framework.
This sounds complicated and risky, why have two copies ?
> + */
> +struct xrt_subdev_platdata {
> +	/*
> +	 * Per driver instance callback. The pdev points to the instance.
> +	 * Should always be defined for subdev driver to get service from root.
> +	 */
> +	xrt_subdev_root_cb_t xsp_root_cb;
> +	void *xsp_root_cb_arg;
> +
> +	/* Something to associate w/ root for msg printing. */
> +	const char *xsp_root_name;
> +
> +	/*
> +	 * Char dev support for this subdev instance.
> +	 * Initialized by subdev driver.
> +	 */
> +	struct cdev xsp_cdev;
> +	struct device *xsp_sysdev;
> +	struct mutex xsp_devnode_lock; /* devnode lock */
> +	struct completion xsp_devnode_comp;
> +	int xsp_devnode_ref;
> +	bool xsp_devnode_online;
> +	bool xsp_devnode_excl;
> +
> +	/*
> +	 * Subdev driver specific init data. The buffer should be embedded
> +	 * in this data structure buffer after dtb, so that it can be freed
> +	 * together with platform data.
> +	 */
> +	loff_t xsp_priv_off; /* Offset into this platform data buffer. */
> +	size_t xsp_priv_len;
> +
> +	/*
> +	 * Populated by parent driver to describe the device tree for
> +	 * the subdev driver to handle. Should always be last one since it's
> +	 * of variable length.
> +	 */
> +	char xsp_dtb[sizeof(struct fdt_header)];
could be xsp_dtb[1] and save including the fdt headers just to get a size that doesn't matter.
> +};
> +
> +/*
> + * this struct define the endpoints belong to the same subdevice
> + */
> +struct xrt_subdev_ep_names {
> +	const char *ep_name;
> +	const char *regmap_name;
> +};
> +
> +struct xrt_subdev_endpoints {
> +	struct xrt_subdev_ep_names *xse_names;
> +	/* minimum number of endpoints to support the subdevice */
> +	u32 xse_min_ep;

see earlier comment about needed a null entry and checking for it.

a 'size' element would be better here.

> +};
> +
> +struct subdev_match_arg {
> +	enum xrt_subdev_id id;
> +	int instance;
> +};
> +
> +bool xleaf_has_endpoint(struct platform_device *pdev, const char *endpoint_name);
> +struct platform_device *xleaf_get_leaf(struct platform_device *pdev,
> +				       xrt_subdev_match_t cb, void *arg);
> +
> +static inline bool subdev_match(enum xrt_subdev_id id, struct platform_device *pdev, void *arg)
> +{
> +	const struct subdev_match_arg *a = (struct subdev_match_arg *)arg;
> +	bool ret = (id == a->id && (pdev->id == a->instance || PLATFORM_DEVID_NONE == a->instance));
This statement is too complicated, turn this into an if-else
> +
> +	return ret;
> +}
> +
> +static inline bool xrt_subdev_match_epname(enum xrt_subdev_id id,
> +					   struct platform_device *pdev, void *arg)
> +{
> +	return xleaf_has_endpoint(pdev, arg);

This function is used only once.

Just inline the function to the caller and remove this function.

> +}
> +
> +static inline struct platform_device *
> +xleaf_get_leaf_by_id(struct platform_device *pdev,
> +		     enum xrt_subdev_id id, int instance)
> +{
> +	struct subdev_match_arg arg = { id, instance };
> +
> +	return xleaf_get_leaf(pdev, subdev_match, &arg);
> +}
> +
> +static inline struct platform_device *
> +xleaf_get_leaf_by_epname(struct platform_device *pdev, const char *name)
> +{
> +	return xleaf_get_leaf(pdev, xrt_subdev_match_epname, (void *)name);
> +}
> +
> +static inline int xleaf_ioctl(struct platform_device *tgt, u32 cmd, void *arg)
> +{
> +	struct xrt_subdev_drvdata *drvdata = DEV_DRVDATA(tgt);
> +
> +	return (*drvdata->xsd_dev_ops.xsd_ioctl)(tgt, cmd, arg);
> +}
> +
> +int xleaf_put_leaf(struct platform_device *pdev,
> +		   struct platform_device *leaf);
> +int xleaf_create_group(struct platform_device *pdev, char *dtb);
> +int xleaf_destroy_group(struct platform_device *pdev, int instance);
> +int xleaf_wait_for_group_bringup(struct platform_device *pdev);
> +void xleaf_hot_reset(struct platform_device *pdev);
> +int xleaf_broadcast_event(struct platform_device *pdev,
> +			  enum xrt_events evt, bool async);
> +void xleaf_get_barres(struct platform_device *pdev,
> +		      struct resource **res, uint bar_idx);
> +void xleaf_get_root_id(struct platform_device *pdev,
> +		       unsigned short *vendor, unsigned short *device,
> +		       unsigned short *subvendor, unsigned short *subdevice);
> +struct device *xleaf_register_hwmon(struct platform_device *pdev,
> +				    const char *name, void *drvdata,
> +				    const struct attribute_group **grps);
> +void xleaf_unregister_hwmon(struct platform_device *pdev, struct device *hwmon);

could better organize these decl's alphabetically.

Also not intermix inlines and decls.

> +
> +/*
> + * Character device helper APIs for use by leaf drivers
> + */
> +static inline bool xleaf_devnode_enabled(struct xrt_subdev_drvdata *drvdata)
> +{
> +	return drvdata && drvdata->xsd_file_ops.xsf_ops.open;
> +}
> +
> +int xleaf_devnode_create(struct platform_device *pdev,
> +			 const char *file_name, const char *inst_name);
> +int xleaf_devnode_destroy(struct platform_device *pdev);
> +
> +struct platform_device *xleaf_devnode_open_excl(struct inode *inode);
> +struct platform_device *xleaf_devnode_open(struct inode *inode);
> +void xleaf_devnode_close(struct inode *inode);
> +
> +/* Helpers. */
> +static inline void xrt_memcpy_fromio(void *buf, void __iomem *iomem, u32 size)
> +{
Replace with mmio_insl/outsl
> +	int i;
> +
> +	WARN_ON(size & 0x3);
> +	for (i = 0; i < size / 4; i++)
> +		((u32 *)buf)[i] = ioread32((char *)(iomem) + sizeof(u32) * i);
> +}
> +
> +static inline void xrt_memcpy_toio(void __iomem *iomem, void *buf, u32 size)
> +{
> +	int i;
> +
> +	WARN_ON(size & 0x3);
> +	for (i = 0; i < size / 4; i++)
> +		iowrite32(((u32 *)buf)[i], ((char *)(iomem) + sizeof(u32) * i));
> +}
> +
> +int xleaf_register_driver(enum xrt_subdev_id id, struct platform_driver *drv,
> +			  struct xrt_subdev_endpoints *eps);
> +void xleaf_unregister_driver(enum xrt_subdev_id id);
> +
> +/* Module's init/fini routines for leaf driver in xrt-lib module */
> +void group_leaf_init_fini(bool init);
> +void vsec_leaf_init_fini(bool init);
> +void vsec_golden_leaf_init_fini(bool init);
> +void devctl_leaf_init_fini(bool init);
> +void axigate_leaf_init_fini(bool init);
> +void icap_leaf_init_fini(bool init);
> +void calib_leaf_init_fini(bool init);
> +void qspi_leaf_init_fini(bool init);
> +void mailbox_leaf_init_fini(bool init);
> +void cmc_leaf_init_fini(bool init);
> +void clkfreq_leaf_init_fini(bool init);
> +void clock_leaf_init_fini(bool init);
> +void ucs_leaf_init_fini(bool init);
Shouldn't these be in the specific leaf drv ?
> +
> +#endif	/* _XRT_LEAF_H_ */
> diff --git a/drivers/fpga/xrt/lib/cdev.c b/drivers/fpga/xrt/lib/cdev.c
> new file mode 100644
> index 000000000000..7f104ab3d527
> --- /dev/null
> +++ b/drivers/fpga/xrt/lib/cdev.c
> @@ -0,0 +1,231 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Xilinx Alveo FPGA device node helper functions.
> + *
> + * Copyright (C) 2020-2021 Xilinx, Inc.
> + *
> + * Authors:
> + *	Cheng Zhen <maxz@xilinx.com>
> + */
> +
> +#include "xleaf.h"
> +
> +extern struct class *xrt_class;
> +
> +#define XRT_CDEV_DIR		"xfpga"
'xfpga' is not very unique, maybe 'xrt' ?
> +#define INODE2PDATA(inode)	\
> +	container_of((inode)->i_cdev, struct xrt_subdev_platdata, xsp_cdev)
> +#define INODE2PDEV(inode)	\
> +	to_platform_device(kobj_to_dev((inode)->i_cdev->kobj.parent))
> +#define CDEV_NAME(sysdev)	(strchr((sysdev)->kobj.name, '!') + 1)
> +
> +/* Allow it to be accessed from cdev. */
> +static void xleaf_devnode_allowed(struct platform_device *pdev)
> +{
> +	struct xrt_subdev_platdata *pdata = DEV_PDATA(pdev);
> +
> +	/* Allow new opens. */
> +	mutex_lock(&pdata->xsp_devnode_lock);
> +	pdata->xsp_devnode_online = true;
> +	mutex_unlock(&pdata->xsp_devnode_lock);
> +}
> +
> +/* Turn off access from cdev and wait for all existing user to go away. */
> +static int xleaf_devnode_disallowed(struct platform_device *pdev)
> +{
> +	int ret = 0;
> +	struct xrt_subdev_platdata *pdata = DEV_PDATA(pdev);
> +
> +	mutex_lock(&pdata->xsp_devnode_lock);
> +
> +	/* Prevent new opens. */
> +	pdata->xsp_devnode_online = false;
> +	/* Wait for existing user to close. */
> +	while (!ret && pdata->xsp_devnode_ref) {
> +		int rc;
> +
> +		mutex_unlock(&pdata->xsp_devnode_lock);
> +		rc = wait_for_completion_killable(&pdata->xsp_devnode_comp);
> +		mutex_lock(&pdata->xsp_devnode_lock);
> +
> +		if (rc == -ERESTARTSYS) {
> +			/* Restore online state. */
> +			pdata->xsp_devnode_online = true;
> +			xrt_err(pdev, "%s is in use, ref=%d",
> +				CDEV_NAME(pdata->xsp_sysdev),
> +				pdata->xsp_devnode_ref);
> +			ret = -EBUSY;
> +		}
> +	}
> +
> +	mutex_unlock(&pdata->xsp_devnode_lock);
> +
> +	return ret;
> +}
> +
> +static struct platform_device *
> +__xleaf_devnode_open(struct inode *inode, bool excl)
> +{
> +	struct xrt_subdev_platdata *pdata = INODE2PDATA(inode);
> +	struct platform_device *pdev = INODE2PDEV(inode);
> +	bool opened = false;
> +
> +	mutex_lock(&pdata->xsp_devnode_lock);
> +
> +	if (pdata->xsp_devnode_online) {
> +		if (excl && pdata->xsp_devnode_ref) {
> +			xrt_err(pdev, "%s has already been opened exclusively",
> +				CDEV_NAME(pdata->xsp_sysdev));
> +		} else if (!excl && pdata->xsp_devnode_excl) {
> +			xrt_err(pdev, "%s has been opened exclusively",
> +				CDEV_NAME(pdata->xsp_sysdev));
> +		} else {
> +			pdata->xsp_devnode_ref++;
> +			pdata->xsp_devnode_excl = excl;
> +			opened = true;
> +			xrt_info(pdev, "opened %s, ref=%d",
> +				 CDEV_NAME(pdata->xsp_sysdev),
> +				 pdata->xsp_devnode_ref);
> +		}
> +	} else {
> +		xrt_err(pdev, "%s is offline", CDEV_NAME(pdata->xsp_sysdev));
> +	}
> +
> +	mutex_unlock(&pdata->xsp_devnode_lock);
> +
> +	pdev = opened ? pdev : NULL;
> +	return pdev;
> +}
> +
> +struct platform_device *
> +xleaf_devnode_open_excl(struct inode *inode)
> +{
> +	return __xleaf_devnode_open(inode, true);
> +}
> +
> +struct platform_device *
> +xleaf_devnode_open(struct inode *inode)
> +{
> +	return __xleaf_devnode_open(inode, false);
> +}
> +EXPORT_SYMBOL_GPL(xleaf_devnode_open);

generally

exported systems should have their decl's in include/linux/fpga/

These are in drivers/fpga/xrt/include/xleaf.h

as exported, they should have a better than average prefix.

maybe 'xrt_fpga_'

> +
> +void xleaf_devnode_close(struct inode *inode)
> +{
> +	struct xrt_subdev_platdata *pdata = INODE2PDATA(inode);
> +	struct platform_device *pdev = INODE2PDEV(inode);
> +	bool notify = false;
> +
> +	mutex_lock(&pdata->xsp_devnode_lock);
> +
> +	pdata->xsp_devnode_ref--;
check before dec ? or at least warn if ref is already 0
> +	if (pdata->xsp_devnode_ref == 0) {
> +		pdata->xsp_devnode_excl = false;
> +		notify = true;
> +	}
> +	if (notify) {
> +		xrt_info(pdev, "closed %s, ref=%d",
> +			 CDEV_NAME(pdata->xsp_sysdev), pdata->xsp_devnode_ref);
> +	} else {
> +		xrt_info(pdev, "closed %s, notifying waiter",
> +			 CDEV_NAME(pdata->xsp_sysdev));
> +	}
> +
> +	mutex_unlock(&pdata->xsp_devnode_lock);
> +
> +	if (notify)
> +		complete(&pdata->xsp_devnode_comp);
> +}
> +EXPORT_SYMBOL_GPL(xleaf_devnode_close);
> +
> +static inline enum xrt_subdev_file_mode
> +devnode_mode(struct xrt_subdev_drvdata *drvdata)
> +{
> +	return drvdata->xsd_file_ops.xsf_mode;
> +}
> +
> +int xleaf_devnode_create(struct platform_device *pdev, const char *file_name,
> +			 const char *inst_name)
> +{
> +	struct xrt_subdev_drvdata *drvdata = DEV_DRVDATA(pdev);
> +	struct xrt_subdev_file_ops *fops = &drvdata->xsd_file_ops;
> +	struct xrt_subdev_platdata *pdata = DEV_PDATA(pdev);
> +	struct cdev *cdevp;
> +	struct device *sysdev;
> +	int ret = 0;
> +	char fname[256];

will a /dev/xfpga* created for ever leaf device ?

do they all really need /dev/ support ?

> +
> +	mutex_init(&pdata->xsp_devnode_lock);
> +	init_completion(&pdata->xsp_devnode_comp);
> +
> +	cdevp = &DEV_PDATA(pdev)->xsp_cdev;
no cdev_alloc ?
> +	cdev_init(cdevp, &fops->xsf_ops);
> +	cdevp->owner = fops->xsf_ops.owner;
> +	cdevp->dev = MKDEV(MAJOR(fops->xsf_dev_t), pdev->id);
> +
> +	/*
> +	 * Set pdev as parent of cdev so that when pdev (and its platform
> +	 * data) will not be freed when cdev is not freed.
> +	 */
> +	cdev_set_parent(cdevp, &DEV(pdev)->kobj);
> +
> +	ret = cdev_add(cdevp, cdevp->dev, 1);
> +	if (ret) {
> +		xrt_err(pdev, "failed to add cdev: %d", ret);
> +		goto failed;
> +	}
> +	if (!file_name)
> +		file_name = pdev->name;
> +	if (!inst_name) {
> +		if (devnode_mode(drvdata) == XRT_SUBDEV_FILE_MULTI_INST) {
> +			snprintf(fname, sizeof(fname), "%s/%s/%s.%u",
> +				 XRT_CDEV_DIR, DEV_PDATA(pdev)->xsp_root_name,
> +				 file_name, pdev->id);
> +		} else {
> +			snprintf(fname, sizeof(fname), "%s/%s/%s",
> +				 XRT_CDEV_DIR, DEV_PDATA(pdev)->xsp_root_name,
> +				 file_name);
> +		}
> +	} else {
> +		snprintf(fname, sizeof(fname), "%s/%s/%s.%s", XRT_CDEV_DIR,
> +			 DEV_PDATA(pdev)->xsp_root_name, file_name, inst_name);
> +	}
> +	sysdev = device_create(xrt_class, NULL, cdevp->dev, NULL, "%s", fname);
> +	if (IS_ERR(sysdev)) {
> +		ret = PTR_ERR(sysdev);
> +		xrt_err(pdev, "failed to create device node: %d", ret);
> +		goto failed;
this calls device_destroy, but the create call failed, so is this needed ?
> +	}
> +	pdata->xsp_sysdev = sysdev;
> +
> +	xleaf_devnode_allowed(pdev);
> +
> +	xrt_info(pdev, "created (%d, %d): /dev/%s",
> +		 MAJOR(cdevp->dev), pdev->id, fname);
> +	return 0;
> +
> +failed:
> +	device_destroy(xrt_class, cdevp->dev);
> +	cdev_del(cdevp);
> +	cdevp->owner = NULL;
> +	return ret;
> +}
> +
> +int xleaf_devnode_destroy(struct platform_device *pdev)
> +{
> +	struct xrt_subdev_platdata *pdata = DEV_PDATA(pdev);
> +	struct cdev *cdevp = &pdata->xsp_cdev;
> +	dev_t dev = cdevp->dev;
> +	int rc;
> +
> +	rc = xleaf_devnode_disallowed(pdev);
> +	if (rc)
> +		return rc;
This return is not checked by xrt_subdev_destroy
> +
> +	xrt_info(pdev, "removed (%d, %d): /dev/%s/%s", MAJOR(dev), MINOR(dev),
> +		 XRT_CDEV_DIR, CDEV_NAME(pdata->xsp_sysdev));
> +	device_destroy(xrt_class, cdevp->dev);
> +	pdata->xsp_sysdev = NULL;
> +	cdev_del(cdevp);
> +	return 0;
> +}
> diff --git a/drivers/fpga/xrt/lib/subdev.c b/drivers/fpga/xrt/lib/subdev.c
> new file mode 100644
> index 000000000000..73552c549bdb
> --- /dev/null
> +++ b/drivers/fpga/xrt/lib/subdev.c
> @@ -0,0 +1,871 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Xilinx Alveo FPGA device helper functions
> + *
> + * Copyright (C) 2020-2021 Xilinx, Inc.
> + *
> + * Authors:
> + *	Cheng Zhen <maxz@xilinx.com>
> + */
> +
> +#include <linux/platform_device.h>
> +#include <linux/pci.h>
> +#include <linux/vmalloc.h>
> +#include "xleaf.h"
> +#include "subdev_pool.h"
> +#include "main.h"
> +#include "metadata.h"
> +
> +#define DEV_IS_PCI(dev) ((dev)->bus == &pci_bus_type)
> +static inline struct device *find_root(struct platform_device *pdev)
> +{
> +	struct device *d = DEV(pdev);
> +
> +	while (!DEV_IS_PCI(d))
> +		d = d->parent;

Shouldn't the root have no parent ?

Could then check if d->parent == NULL instead of bus type

> +	return d;
> +}
> +
> +/*
> + * It represents a holder of a subdev. One holder can repeatedly hold a subdev
> + * as long as there is a unhold corresponding to a hold.
> + */
> +struct xrt_subdev_holder {
> +	struct list_head xsh_holder_list;
> +	struct device *xsh_holder;
> +	int xsh_count;
> +	struct kref xsh_kref;

general, i see this in struct xrt_subdev

guessing 'xsh' is xrt subdev holder.

why is this prefix needed for the elements ? consider removing it.

> +};
> +
> +/*
> + * It represents a specific instance of platform driver for a subdev, which
> + * provides services to its clients (another subdev driver or root driver).
> + */
> +struct xrt_subdev {
> +	struct list_head xs_dev_list;
> +	struct list_head xs_holder_list;
> +	enum xrt_subdev_id xs_id;		/* type of subdev */
> +	struct platform_device *xs_pdev;	/* a particular subdev inst */
> +	struct completion xs_holder_comp;
> +};
> +
> +static struct xrt_subdev *xrt_subdev_alloc(void)
> +{
> +	struct xrt_subdev *sdev = vzalloc(sizeof(*sdev));
similar kzalloc as another patch.
> +
> +	if (!sdev)
> +		return NULL;
> +
> +	INIT_LIST_HEAD(&sdev->xs_dev_list);
> +	INIT_LIST_HEAD(&sdev->xs_holder_list);
> +	init_completion(&sdev->xs_holder_comp);
> +	return sdev;
> +}
> +
> +static void xrt_subdev_free(struct xrt_subdev *sdev)
> +{
> +	vfree(sdev);
> +}
> +
> +int xrt_subdev_root_request(struct platform_device *self, u32 cmd, void *arg)
> +{
> +	struct device *dev = DEV(self);
> +	struct xrt_subdev_platdata *pdata = DEV_PDATA(self);
> +
> +	return (*pdata->xsp_root_cb)(dev->parent, pdata->xsp_root_cb_arg, cmd, arg);

xrt_subdev_create does not check if pcb is valid. is a null is passed in, it will crash.

there should at least be a warn or -INVALID returned there

> +}
> +
> +/*
> + * Subdev common sysfs nodes.
> + */
> +static ssize_t holders_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	ssize_t len;
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct xrt_root_ioctl_get_holders holders = { pdev, buf, 1024 };
is 1024 a guess ?
> +
> +	len = xrt_subdev_root_request(pdev, XRT_ROOT_GET_LEAF_HOLDERS, &holders);
take a closer look at xrt_subdev_get_holders() it stops after it goes past len.
> +	if (len >= holders.xpigh_holder_buf_len)
> +		return len;
> +	buf[len] = '\n';
> +	return len + 1;
> +}
> +static DEVICE_ATTR_RO(holders);
> +
> +static struct attribute *xrt_subdev_attrs[] = {
> +	&dev_attr_holders.attr,
> +	NULL,
> +};
> +
> +static ssize_t metadata_output(struct file *filp, struct kobject *kobj,
> +			       struct bin_attribute *attr, char *buf, loff_t off, size_t count)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct xrt_subdev_platdata *pdata = DEV_PDATA(pdev);
> +	unsigned char *blob;
> +	unsigned long  size;
> +	ssize_t ret = 0;
> +
> +	blob = pdata->xsp_dtb;
> +	size = xrt_md_size(dev, blob);
> +	if (size == XRT_MD_INVALID_LENGTH) {
> +		ret = -EINVAL;
> +		goto failed;
> +	}
> +
> +	if (off >= size)
> +		goto failed;
silently failed because ret = 0 ?
> +
> +	if (off + count > size)
> +		count = size - off;
truncating is ok ?
> +	memcpy(buf, blob + off, count);
> +
> +	ret = count;
> +failed:
> +	return ret;
> +}
> +
> +static struct bin_attribute meta_data_attr = {
> +	.attr = {
> +		.name = "metadata",
> +		.mode = 0400
> +	},
> +	.read = metadata_output,
> +	.size = 0
> +};
> +
> +static struct bin_attribute  *xrt_subdev_bin_attrs[] = {
> +	&meta_data_attr,

is giving the average user access to the meta data a good idea ?

this seems like a developer only need.

> +	NULL,
> +};
> +
> +static const struct attribute_group xrt_subdev_attrgroup = {
> +	.attrs = xrt_subdev_attrs,
> +	.bin_attrs = xrt_subdev_bin_attrs,
> +};
> +
> +/*
> + * Given the device metadata, parse it to get IO ranges and construct
> + * resource array.
> + */
> +static int
> +xrt_subdev_getres(struct device *parent, enum xrt_subdev_id id,
> +		  char *dtb, struct resource **res, int *res_num)
> +{
> +	struct xrt_subdev_platdata *pdata;
> +	struct resource *pci_res = NULL;
> +	const u64 *bar_range;
> +	const u32 *bar_idx;
> +	char *ep_name = NULL, *regmap = NULL;
> +	uint bar;
> +	int count1 = 0, count2 = 0, ret;
> +
> +	if (!dtb)
> +		return -EINVAL;
> +
> +	pdata = DEV_PDATA(to_platform_device(parent));
> +
> +	/* go through metadata and count endpoints in it */
> +	for (xrt_md_get_next_endpoint(parent, dtb, NULL, NULL, &ep_name, &regmap); ep_name;

Ugly.

Can you preprocess the dtb into a list of end points ?

> +	     xrt_md_get_next_endpoint(parent, dtb, ep_name, regmap, &ep_name, &regmap)) {
> +		ret = xrt_md_get_prop(parent, dtb, ep_name, regmap,
> +				      XRT_MD_PROP_IO_OFFSET, (const void **)&bar_range, NULL);
> +		if (!ret)
> +			count1++;
> +	}
> +	if (!count1)
> +		return 0;
> +
> +	/* allocate resource array for all endpoints been found in metadata */
> +	*res = vzalloc(sizeof(**res) * count1);
> +
> +	/* go through all endpoints again and get IO range for each endpoint */
> +	for (xrt_md_get_next_endpoint(parent, dtb, NULL, NULL, &ep_name, &regmap); ep_name;
> +	     xrt_md_get_next_endpoint(parent, dtb, ep_name, regmap, &ep_name, &regmap)) {
> +		ret = xrt_md_get_prop(parent, dtb, ep_name, regmap,
> +				      XRT_MD_PROP_IO_OFFSET, (const void **)&bar_range, NULL);
> +		if (ret)
> +			continue;
> +		xrt_md_get_prop(parent, dtb, ep_name, regmap,
> +				XRT_MD_PROP_BAR_IDX, (const void **)&bar_idx, NULL);

bar can fail, but bar idx can not.

should add an assert here

> +		bar = bar_idx ? be32_to_cpu(*bar_idx) : 0;
> +		xleaf_get_barres(to_platform_device(parent), &pci_res, bar);
> +		(*res)[count2].start = pci_res->start +
> +			be64_to_cpu(bar_range[0]);
> +		(*res)[count2].end = pci_res->start +
> +			be64_to_cpu(bar_range[0]) +
> +			be64_to_cpu(bar_range[1]) - 1;
> +		(*res)[count2].flags = IORESOURCE_MEM;
any irqs need handling?
> +		/* check if there is conflicted resource */
> +		ret = request_resource(pci_res, *res + count2);
> +		if (ret) {
> +			dev_err(parent, "Conflict resource %pR\n", *res + count2);
> +			vfree(*res);
> +			*res_num = 0;
> +			*res = NULL;
> +			return ret;
> +		}
> +		release_resource(*res + count2);
> +
> +		(*res)[count2].parent = pci_res;
> +
> +		xrt_md_find_endpoint(parent, pdata->xsp_dtb, ep_name,
> +				     regmap, &(*res)[count2].name);
> +
> +		count2++;
> +	}
> +
> +	WARN_ON(count1 != count2);
> +	*res_num = count2;
> +
> +	return 0;
> +}
> +
> +static inline enum xrt_subdev_file_mode
> +xleaf_devnode_mode(struct xrt_subdev_drvdata *drvdata)
> +{
> +	return drvdata->xsd_file_ops.xsf_mode;
> +}
> +
> +static bool xrt_subdev_cdev_auto_creation(struct platform_device *pdev)
> +{
> +	struct xrt_subdev_drvdata *drvdata = DEV_DRVDATA(pdev);
> +
> +	if (!drvdata)
> +		return false;
> +
> +	return xleaf_devnode_enabled(drvdata) &&
> +		(xleaf_devnode_mode(drvdata) == XRT_SUBDEV_FILE_DEFAULT ||
> +		(xleaf_devnode_mode(drvdata) == XRT_SUBDEV_FILE_MULTI_INST));
This is complicated to check, split into checking the call and then checking its side effects.
> +}
> +
> +static struct xrt_subdev *
> +xrt_subdev_create(struct device *parent, enum xrt_subdev_id id,
> +		  xrt_subdev_root_cb_t pcb, void *pcb_arg, char *dtb)
> +{
> +	struct xrt_subdev *sdev = NULL;
> +	struct platform_device *pdev = NULL;
> +	struct xrt_subdev_platdata *pdata = NULL;
> +	unsigned long dtb_len = 0;
> +	size_t pdata_sz;
> +	int inst = PLATFORM_DEVID_NONE;
> +	struct resource *res = NULL;
> +	int res_num = 0;
> +
> +	sdev = xrt_subdev_alloc();
> +	if (!sdev) {
> +		dev_err(parent, "failed to alloc subdev for ID %d", id);
> +		goto fail;
> +	}
> +	sdev->xs_id = id;
> +
> +	if (dtb) {
> +		xrt_md_pack(parent, dtb);
> +		dtb_len = xrt_md_size(parent, dtb);
> +		if (dtb_len == XRT_MD_INVALID_LENGTH) {
> +			dev_err(parent, "invalid metadata len %ld", dtb_len);
> +			goto fail;
> +		}
> +	}
> +	pdata_sz = sizeof(struct xrt_subdev_platdata) + dtb_len - 1;

-1 ?

if dtb_len == 0, pdata_sz be too small.

> +
> +	/* Prepare platform data passed to subdev. */
> +	pdata = vzalloc(pdata_sz);
> +	if (!pdata)
> +		goto fail;
> +
> +	pdata->xsp_root_cb = pcb;
> +	pdata->xsp_root_cb_arg = pcb_arg;
> +	memcpy(pdata->xsp_dtb, dtb, dtb_len);
> +	if (id == XRT_SUBDEV_GRP) {
> +		/* Group can only be created by root driver. */
> +		pdata->xsp_root_name = dev_name(parent);
> +	} else {
> +		struct platform_device *grp = to_platform_device(parent);
> +		/* Leaf can only be created by group driver. */
> +		WARN_ON(strcmp(xrt_drv_name(XRT_SUBDEV_GRP), platform_get_device_id(grp)->name));
> +		pdata->xsp_root_name = DEV_PDATA(grp)->xsp_root_name;
> +	}
> +
> +	/* Obtain dev instance number. */
> +	inst = xrt_drv_get_instance(id);
> +	if (inst < 0) {
> +		dev_err(parent, "failed to obtain instance: %d", inst);
> +		goto fail;
> +	}
> +
> +	/* Create subdev. */
> +	if (id == XRT_SUBDEV_GRP) {
> +		pdev = platform_device_register_data(parent, xrt_drv_name(XRT_SUBDEV_GRP),
> +						     inst, pdata, pdata_sz);
> +	} else {
> +		int rc = xrt_subdev_getres(parent, id, dtb, &res, &res_num);
> +
> +		if (rc) {
> +			dev_err(parent, "failed to get resource for %s.%d: %d",
> +				xrt_drv_name(id), inst, rc);
> +			goto fail;
> +		}
> +		pdev = platform_device_register_resndata(parent, xrt_drv_name(id),
> +							 inst, res, res_num, pdata, pdata_sz);
> +		vfree(res);
> +	}

a small optimization

platform_device_register_data is a wrapper to platform_device_register_resndata.

with initial values for res, res_num, just one call need to be made.

> +	if (IS_ERR(pdev)) {
> +		dev_err(parent, "failed to create subdev for %s inst %d: %ld",
> +			xrt_drv_name(id), inst, PTR_ERR(pdev));
> +		goto fail;
> +	}
> +	sdev->xs_pdev = pdev;
> +
> +	if (device_attach(DEV(pdev)) != 1) {
> +		xrt_err(pdev, "failed to attach");
> +		goto fail;
> +	}
> +
> +	if (sysfs_create_group(&DEV(pdev)->kobj, &xrt_subdev_attrgroup))
> +		xrt_err(pdev, "failed to create sysfs group");
no failure ?
> +
> +	/*
> +	 * Create sysfs sym link under root for leaves
> +	 * under random groups for easy access to them.
> +	 */
> +	if (id != XRT_SUBDEV_GRP) {
> +		if (sysfs_create_link(&find_root(pdev)->kobj,
> +				      &DEV(pdev)->kobj, dev_name(DEV(pdev)))) {
> +			xrt_err(pdev, "failed to create sysfs link");
> +		}
> +	}
> +
> +	/* All done, ready to handle req thru cdev. */
> +	if (xrt_subdev_cdev_auto_creation(pdev))
> +		xleaf_devnode_create(pdev, DEV_DRVDATA(pdev)->xsd_file_ops.xsf_dev_name, NULL);
> +
> +	vfree(pdata);
> +	return sdev;
> +
> +fail:

Instead of adding checks in the error handling block, add more specific labels and gotos.

I think i have noticed this before, so apply this advice generally.

> +	vfree(pdata);
> +	if (sdev && !IS_ERR_OR_NULL(sdev->xs_pdev))
> +		platform_device_unregister(sdev->xs_pdev);
> +	if (inst >= 0)
> +		xrt_drv_put_instance(id, inst);
> +	xrt_subdev_free(sdev);
> +	return NULL;
> +}
> +
> +static void xrt_subdev_destroy(struct xrt_subdev *sdev)
> +{
> +	struct platform_device *pdev = sdev->xs_pdev;
> +	int inst = pdev->id;
> +	struct device *dev = DEV(pdev);
> +
> +	/* Take down the device node */
> +	if (xrt_subdev_cdev_auto_creation(pdev))
> +		xleaf_devnode_destroy(pdev);
> +	if (sdev->xs_id != XRT_SUBDEV_GRP)
> +		sysfs_remove_link(&find_root(pdev)->kobj, dev_name(dev));
> +	sysfs_remove_group(&dev->kobj, &xrt_subdev_attrgroup);
> +	platform_device_unregister(pdev);
> +	xrt_drv_put_instance(sdev->xs_id, inst);
> +	xrt_subdev_free(sdev);
> +}
> +
> +struct platform_device *
> +xleaf_get_leaf(struct platform_device *pdev, xrt_subdev_match_t match_cb, void *match_arg)
> +{
> +	int rc;
> +	struct xrt_root_ioctl_get_leaf get_leaf = {
> +		pdev, match_cb, match_arg, };
> +
> +	rc = xrt_subdev_root_request(pdev, XRT_ROOT_GET_LEAF, &get_leaf);
> +	if (rc)
> +		return NULL;
> +	return get_leaf.xpigl_leaf;
> +}
> +EXPORT_SYMBOL_GPL(xleaf_get_leaf);
> +
> +bool xleaf_has_endpoint(struct platform_device *pdev, const char *endpoint_name)
> +{
> +	struct resource	*res;
> +	int		i;
whitespace
> +
> +	for (i = 0, res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	    res;
> +	    res = platform_get_resource(pdev, IORESOURCE_MEM, ++i)) {
Do not inc i inside the call, do it at the bottom of the loop
> +		if (!strncmp(res->name, endpoint_name, strlen(res->name) + 1))
shouldn't you also check the strlen matches ?
> +			return true;
> +	}
> +
> +	return false;
> +}
> +EXPORT_SYMBOL_GPL(xleaf_has_endpoint);
> +
> +int xleaf_put_leaf(struct platform_device *pdev, struct platform_device *leaf)
> +{
> +	struct xrt_root_ioctl_put_leaf put_leaf = { pdev, leaf };
> +
> +	return xrt_subdev_root_request(pdev, XRT_ROOT_PUT_LEAF, &put_leaf);
> +}
> +EXPORT_SYMBOL_GPL(xleaf_put_leaf);
> +
> +int xleaf_create_group(struct platform_device *pdev, char *dtb)
> +{
> +	return xrt_subdev_root_request(pdev, XRT_ROOT_CREATE_GROUP, dtb);
> +}
> +EXPORT_SYMBOL_GPL(xleaf_create_group);
> +
> +int xleaf_destroy_group(struct platform_device *pdev, int instance)
> +{
> +	return xrt_subdev_root_request(pdev, XRT_ROOT_REMOVE_GROUP, (void *)(uintptr_t)instance);

Instead of these clunky casts, why not make the type of the args void *

and leave it to the handler to cast.

this would unify the signature of these functions somewhat.

> +}
> +EXPORT_SYMBOL_GPL(xleaf_destroy_group);
> +
> +int xleaf_wait_for_group_bringup(struct platform_device *pdev)
> +{
> +	return xrt_subdev_root_request(pdev, XRT_ROOT_WAIT_GROUP_BRINGUP, NULL);
> +}
> +EXPORT_SYMBOL_GPL(xleaf_wait_for_group_bringup);
> +
> +static ssize_t
> +xrt_subdev_get_holders(struct xrt_subdev *sdev, char *buf, size_t len)
> +{
> +	const struct list_head *ptr;
> +	struct xrt_subdev_holder *h;
> +	ssize_t n = 0;
> +
> +	list_for_each(ptr, &sdev->xs_holder_list) {
> +		h = list_entry(ptr, struct xrt_subdev_holder, xsh_holder_list);
> +		n += snprintf(buf + n, len - n, "%s:%d ",
> +			      dev_name(h->xsh_holder), kref_read(&h->xsh_kref));
> +		if (n >= (len - 1))
This is the overrun i mentioned above.
> +			break;
> +	}
> +	return n;
> +}
> +
> +void xrt_subdev_pool_init(struct device *dev, struct xrt_subdev_pool *spool)
> +{
> +	INIT_LIST_HEAD(&spool->xsp_dev_list);
> +	spool->xsp_owner = dev;
> +	mutex_init(&spool->xsp_lock);
> +	spool->xsp_closing = false;
> +}
> +
> +static void xrt_subdev_free_holder(struct xrt_subdev_holder *holder)
> +{
> +	list_del(&holder->xsh_holder_list);
> +	vfree(holder);
> +}
> +
> +static void xrt_subdev_pool_wait_for_holders(struct xrt_subdev_pool *spool, struct xrt_subdev *sdev)
> +{
> +	const struct list_head *ptr, *next;
> +	char holders[128];
> +	struct xrt_subdev_holder *holder;
> +	struct mutex *lk = &spool->xsp_lock;
> +
> +	WARN_ON(!mutex_is_locked(lk));
> +
> +	while (!list_empty(&sdev->xs_holder_list)) {
> +		int rc;
> +
> +		/* It's most likely a bug if we ever enters this loop. */
> +		xrt_subdev_get_holders(sdev, holders, sizeof(holders));
will overrun, error not reported.
> +		xrt_err(sdev->xs_pdev, "awaits holders: %s", holders);
> +		mutex_unlock(lk);
> +		rc = wait_for_completion_killable(&sdev->xs_holder_comp);
> +		mutex_lock(lk);
> +		if (rc == -ERESTARTSYS) {
> +			xrt_err(sdev->xs_pdev, "give up on waiting for holders, clean up now");
> +			list_for_each_safe(ptr, next, &sdev->xs_holder_list) {
> +				holder = list_entry(ptr, struct xrt_subdev_holder, xsh_holder_list);
> +				xrt_subdev_free_holder(holder);
> +			}
> +		}
> +	}
> +}
> +
> +void xrt_subdev_pool_fini(struct xrt_subdev_pool *spool)
> +{
> +	struct list_head *dl = &spool->xsp_dev_list;
> +	struct mutex *lk = &spool->xsp_lock;
> +
> +	mutex_lock(lk);
> +

i am wondering about the locking here.

xsp_closing is only set to true in this function.

the unlocking then relocking in the loop is strange, why do you need to do this ?

> +	if (spool->xsp_closing) {
> +		mutex_unlock(lk);
> +		return;
> +	}
> +
> +	spool->xsp_closing = true;
> +	/* Remove subdev in the reverse order of added. */
> +	while (!list_empty(dl)) {
> +		struct xrt_subdev *sdev = list_first_entry(dl, struct xrt_subdev, xs_dev_list);
> +
> +		xrt_subdev_pool_wait_for_holders(spool, sdev);
> +		list_del(&sdev->xs_dev_list);
> +		mutex_unlock(lk);
> +		xrt_subdev_destroy(sdev);
> +		mutex_lock(lk);
> +	}
> +
> +	mutex_unlock(lk);
> +}
> +
> +static struct xrt_subdev_holder *xrt_subdev_find_holder(struct xrt_subdev *sdev,
> +							struct device *holder_dev)
> +{
> +	struct list_head *hl = &sdev->xs_holder_list;
> +	struct xrt_subdev_holder *holder;
> +	const struct list_head *ptr;
> +
> +	list_for_each(ptr, hl) {
> +		holder = list_entry(ptr, struct xrt_subdev_holder, xsh_holder_list);
> +		if (holder->xsh_holder == holder_dev)
> +			return holder;
> +	}
> +	return NULL;
> +}
> +
> +static int xrt_subdev_hold(struct xrt_subdev *sdev, struct device *holder_dev)
> +{
> +	struct xrt_subdev_holder *holder = xrt_subdev_find_holder(sdev, holder_dev);
> +	struct list_head *hl = &sdev->xs_holder_list;
> +
> +	if (!holder) {
> +		holder = vzalloc(sizeof(*holder));
> +		if (!holder)
> +			return -ENOMEM;
> +		holder->xsh_holder = holder_dev;
> +		kref_init(&holder->xsh_kref);
> +		list_add_tail(&holder->xsh_holder_list, hl);
> +	} else {
> +		kref_get(&holder->xsh_kref);
> +	}
> +
> +	return 0;
> +}
> +
> +static void xrt_subdev_free_holder_kref(struct kref *kref)
> +{
> +	struct xrt_subdev_holder *holder = container_of(kref, struct xrt_subdev_holder, xsh_kref);
> +
> +	xrt_subdev_free_holder(holder);
> +}
> +
> +static int
> +xrt_subdev_release(struct xrt_subdev *sdev, struct device *holder_dev)
> +{
> +	struct xrt_subdev_holder *holder = xrt_subdev_find_holder(sdev, holder_dev);
> +	struct list_head *hl = &sdev->xs_holder_list;
> +
> +	if (!holder) {
> +		dev_err(holder_dev, "can't release, %s did not hold %s",
> +			dev_name(holder_dev), dev_name(DEV(sdev->xs_pdev)));
> +		return -EINVAL;
> +	}
> +	kref_put(&holder->xsh_kref, xrt_subdev_free_holder_kref);
> +
> +	/* kref_put above may remove holder from list. */
> +	if (list_empty(hl))
> +		complete(&sdev->xs_holder_comp);
> +	return 0;
> +}
> +
> +int xrt_subdev_pool_add(struct xrt_subdev_pool *spool, enum xrt_subdev_id id,
> +			xrt_subdev_root_cb_t pcb, void *pcb_arg, char *dtb)
> +{
> +	struct mutex *lk = &spool->xsp_lock;
> +	struct list_head *dl = &spool->xsp_dev_list;
> +	struct xrt_subdev *sdev;
> +	int ret = 0;
> +
> +	sdev = xrt_subdev_create(spool->xsp_owner, id, pcb, pcb_arg, dtb);
> +	if (sdev) {
> +		mutex_lock(lk);
> +		if (spool->xsp_closing) {
> +			/* No new subdev when pool is going away. */
> +			xrt_err(sdev->xs_pdev, "pool is closing");
> +			ret = -ENODEV;
> +		} else {
> +			list_add(&sdev->xs_dev_list, dl);
> +		}
> +		mutex_unlock(lk);
> +		if (ret)
> +			xrt_subdev_destroy(sdev);
> +	} else {
> +		ret = -EINVAL;
> +	}
> +
> +	ret = ret ? ret : sdev->xs_pdev->id;
> +	return ret;
> +}
> +
> +int xrt_subdev_pool_del(struct xrt_subdev_pool *spool, enum xrt_subdev_id id, int instance)
> +{
> +	const struct list_head *ptr;
> +	struct mutex *lk = &spool->xsp_lock;
> +	struct list_head *dl = &spool->xsp_dev_list;
> +	struct xrt_subdev *sdev;
> +	int ret = -ENOENT;
> +
> +	mutex_lock(lk);
> +	list_for_each(ptr, dl) {
> +		sdev = list_entry(ptr, struct xrt_subdev, xs_dev_list);
> +		if (sdev->xs_id != id || sdev->xs_pdev->id != instance)
> +			continue;
> +		xrt_subdev_pool_wait_for_holders(spool, sdev);
> +		list_del(&sdev->xs_dev_list);
> +		ret = 0;
> +		break;
> +	}
> +	mutex_unlock(lk);
> +	if (ret)
> +		return ret;
> +
> +	xrt_subdev_destroy(sdev);
> +	return 0;
> +}
> +
> +static int xrt_subdev_pool_get_impl(struct xrt_subdev_pool *spool, xrt_subdev_match_t match,
> +				    void *arg, struct device *holder_dev, struct xrt_subdev **sdevp)
> +{
> +	const struct list_head *ptr;
> +	struct mutex *lk = &spool->xsp_lock;
> +	struct list_head *dl = &spool->xsp_dev_list;
> +	struct xrt_subdev *sdev = NULL;
> +	int ret = -ENOENT;
> +
> +	mutex_lock(lk);
> +
> +	if (match == XRT_SUBDEV_MATCH_PREV) {
> +		struct platform_device *pdev = (struct platform_device *)arg;
> +		struct xrt_subdev *d = NULL;
> +
> +		if (!pdev) {
> +			sdev = list_empty(dl) ? NULL :
> +				list_last_entry(dl, struct xrt_subdev, xs_dev_list);
> +		} else {
> +			list_for_each(ptr, dl) {
> +				d = list_entry(ptr, struct xrt_subdev, xs_dev_list);
> +				if (d->xs_pdev != pdev)
> +					continue;
> +				if (!list_is_first(ptr, dl))
> +					sdev = list_prev_entry(d, xs_dev_list);
> +				break;
> +			}
> +		}
> +	} else if (match == XRT_SUBDEV_MATCH_NEXT) {
> +		struct platform_device *pdev = (struct platform_device *)arg;
> +		struct xrt_subdev *d = NULL;
> +
> +		if (!pdev) {
> +			sdev = list_first_entry_or_null(dl, struct xrt_subdev, xs_dev_list);
> +		} else {
> +			list_for_each(ptr, dl) {
> +				d = list_entry(ptr, struct xrt_subdev, xs_dev_list);
> +				if (d->xs_pdev != pdev)
> +					continue;
> +				if (!list_is_last(ptr, dl))
> +					sdev = list_next_entry(d, xs_dev_list);
> +				break;
> +			}
> +		}
> +	} else {
> +		list_for_each(ptr, dl) {
> +			struct xrt_subdev *d = NULL;
> +
> +			d = list_entry(ptr, struct xrt_subdev, xs_dev_list);
> +			if (d && !match(d->xs_id, d->xs_pdev, arg))
> +				continue;
> +			sdev = d;
> +			break;
> +		}
> +	}

3 similar blocks of code

This looks like it could be refactored into this else case and minor changes for match_next/prev

> +
> +	if (sdev)
> +		ret = xrt_subdev_hold(sdev, holder_dev);
> +
> +	mutex_unlock(lk);
> +
> +	if (!ret)
> +		*sdevp = sdev;
> +	return ret;
> +}
> +
> +int xrt_subdev_pool_get(struct xrt_subdev_pool *spool, xrt_subdev_match_t match, void *arg,
> +			struct device *holder_dev, struct platform_device **pdevp)
> +{
> +	int rc;
> +	struct xrt_subdev *sdev;
> +
> +	rc = xrt_subdev_pool_get_impl(spool, match, arg, holder_dev, &sdev);
> +	if (rc) {
> +		if (rc != -ENOENT)
> +			dev_err(holder_dev, "failed to hold device: %d", rc);
> +		return rc;
> +	}
> +
> +	if (!DEV_IS_PCI(holder_dev)) {
! root_dev()
> +		xrt_dbg(to_platform_device(holder_dev), "%s <<==== %s",
> +			dev_name(holder_dev), dev_name(DEV(sdev->xs_pdev)));
> +	}
> +
> +	*pdevp = sdev->xs_pdev;
> +	return 0;
> +}
> +
> +static int xrt_subdev_pool_put_impl(struct xrt_subdev_pool *spool, struct platform_device *pdev,
> +				    struct device *holder_dev)
> +{
> +	const struct list_head *ptr;
> +	struct mutex *lk = &spool->xsp_lock;
> +	struct list_head *dl = &spool->xsp_dev_list;
> +	struct xrt_subdev *sdev;
> +	int ret = -ENOENT;
> +
> +	mutex_lock(lk);
> +	list_for_each(ptr, dl) {
> +		sdev = list_entry(ptr, struct xrt_subdev, xs_dev_list);
> +		if (sdev->xs_pdev != pdev)
> +			continue;
Could this and similar looping be avoided by storing sdev in pdev ?
> +		ret = xrt_subdev_release(sdev, holder_dev);
> +		break;
> +	}
> +	mutex_unlock(lk);
> +
> +	return ret;
> +}
> +
> +int xrt_subdev_pool_put(struct xrt_subdev_pool *spool, struct platform_device *pdev,
> +			struct device *holder_dev)
> +{
> +	int ret = xrt_subdev_pool_put_impl(spool, pdev, holder_dev);
> +
> +	if (ret)
> +		return ret;
> +
> +	if (!DEV_IS_PCI(holder_dev)) {

! root_dev() or similar.

If you really need to use DEV_IS_PCI, do it only once so when you need to change something you don not have to find all the calls to DEV_IS_PCI.

> +		xrt_dbg(to_platform_device(holder_dev), "%s <<==X== %s",
> +			dev_name(holder_dev), dev_name(DEV(pdev)));
> +	}
> +	return 0;
> +}
> +
> +void xrt_subdev_pool_trigger_event(struct xrt_subdev_pool *spool, enum xrt_events e)
> +{
> +	struct platform_device *tgt = NULL;
> +	struct xrt_subdev *sdev = NULL;
> +	struct xrt_event evt;
> +
> +	while (!xrt_subdev_pool_get_impl(spool, XRT_SUBDEV_MATCH_NEXT,
> +					 tgt, spool->xsp_owner, &sdev)) {
> +		tgt = sdev->xs_pdev;
> +		evt.xe_evt = e;
> +		evt.xe_subdev.xevt_subdev_id = sdev->xs_id;
> +		evt.xe_subdev.xevt_subdev_instance = tgt->id;
> +		xrt_subdev_root_request(tgt, XRT_ROOT_EVENT, &evt);
> +		xrt_subdev_pool_put_impl(spool, tgt, spool->xsp_owner);
> +	}
> +}
> +
> +void xrt_subdev_pool_handle_event(struct xrt_subdev_pool *spool, struct xrt_event *evt)
> +{
> +	struct platform_device *tgt = NULL;
> +	struct xrt_subdev *sdev = NULL;
> +
> +	while (!xrt_subdev_pool_get_impl(spool, XRT_SUBDEV_MATCH_NEXT,
> +					 tgt, spool->xsp_owner, &sdev)) {
> +		tgt = sdev->xs_pdev;
> +		xleaf_ioctl(tgt, XRT_XLEAF_EVENT, evt);
> +		xrt_subdev_pool_put_impl(spool, tgt, spool->xsp_owner);
> +	}
> +}
> +
> +ssize_t xrt_subdev_pool_get_holders(struct xrt_subdev_pool *spool,
> +				    struct platform_device *pdev, char *buf, size_t len)
> +{
> +	const struct list_head *ptr;
> +	struct mutex *lk = &spool->xsp_lock;
> +	struct list_head *dl = &spool->xsp_dev_list;
> +	struct xrt_subdev *sdev;
> +	ssize_t ret = 0;
> +
> +	mutex_lock(lk);
> +	list_for_each(ptr, dl) {
> +		sdev = list_entry(ptr, struct xrt_subdev, xs_dev_list);
> +		if (sdev->xs_pdev != pdev)
> +			continue;
> +		ret = xrt_subdev_get_holders(sdev, buf, len);
> +		break;
> +	}
> +	mutex_unlock(lk);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(xrt_subdev_pool_get_holders);
> +
> +int xleaf_broadcast_event(struct platform_device *pdev, enum xrt_events evt, bool async)
> +{
> +	struct xrt_event e = { evt, };
> +	u32 cmd = async ? XRT_ROOT_EVENT_ASYNC : XRT_ROOT_EVENT;
> +
> +	WARN_ON(evt == XRT_EVENT_POST_CREATION || evt == XRT_EVENT_PRE_REMOVAL);
> +	return xrt_subdev_root_request(pdev, cmd, &e);
> +}
> +EXPORT_SYMBOL_GPL(xleaf_broadcast_event);
> +
> +void xleaf_hot_reset(struct platform_device *pdev)
> +{
> +	xrt_subdev_root_request(pdev, XRT_ROOT_HOT_RESET, NULL);
> +}
> +EXPORT_SYMBOL_GPL(xleaf_hot_reset);
> +
> +void xleaf_get_barres(struct platform_device *pdev, struct resource **res, uint bar_idx)
> +{
> +	struct xrt_root_ioctl_get_res arg = { 0 };
> +
> +	if (bar_idx > PCI_STD_RESOURCE_END) {
> +		xrt_err(pdev, "Invalid bar idx %d", bar_idx);
> +		*res = NULL;
> +		return;
> +	}
> +
> +	xrt_subdev_root_request(pdev, XRT_ROOT_GET_RESOURCE, &arg);
> +
> +	*res = &arg.xpigr_res[bar_idx];

is this correct ?

do all res need to be found to return a single one ?

> +}
> +
> +void xleaf_get_root_id(struct platform_device *pdev, unsigned short *vendor, unsigned short *device,
> +		       unsigned short *subvendor, unsigned short *subdevice)
> +{
> +	struct xrt_root_ioctl_get_id id = { 0 };
> +
> +	xrt_subdev_root_request(pdev, XRT_ROOT_GET_ID, (void *)&id);
> +	if (vendor)
> +		*vendor = id.xpigi_vendor_id;
> +	if (device)
> +		*device = id.xpigi_device_id;
> +	if (subvendor)
> +		*subvendor = id.xpigi_sub_vendor_id;
> +	if (subdevice)
> +		*subdevice = id.xpigi_sub_device_id;
not setting anything because user passed in all nulls would make this function a noop.
> +}
> +
> +struct device *xleaf_register_hwmon(struct platform_device *pdev, const char *name, void *drvdata,
> +				    const struct attribute_group **grps)
> +{
> +	struct xrt_root_ioctl_hwmon hm = { true, name, drvdata, grps, };
> +
> +	xrt_subdev_root_request(pdev, XRT_ROOT_HWMON, (void *)&hm);
> +	return hm.xpih_hwmon_dev;
> +}
> +
> +void xleaf_unregister_hwmon(struct platform_device *pdev, struct device *hwmon)
> +{
> +	struct xrt_root_ioctl_hwmon hm = { false, };
> +
> +	hm.xpih_hwmon_dev = hwmon;
> +	xrt_subdev_root_request(pdev, XRT_ROOT_HWMON, (void *)&hm);
> +}
> diff --git a/drivers/fpga/xrt/lib/subdev_pool.h b/drivers/fpga/xrt/lib/subdev_pool.h
> new file mode 100644
> index 000000000000..50a8490e0e41

apologies for delay, was busy.

If it seems like i forgot a train of thought, i did.

> --- /dev/null
> +++ b/drivers/fpga/xrt/lib/subdev_pool.h
> @@ -0,0 +1,53 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Header file for Xilinx Runtime (XRT) driver
> + *
> + * Copyright (C) 2020-2021 Xilinx, Inc.
> + *
> + * Authors:
> + *	Cheng Zhen <maxz@xilinx.com>
> + */
> +
> +#ifndef _XRT_SUBDEV_POOL_H_
> +#define _XRT_SUBDEV_POOL_H_
> +
> +#include "xroot.h"
> +
> +/*
> + * It manages a list of xrt_subdevs for root and group drivers.

'It' does not have a lot of context, better would be

The xrt_subdev_pool struct ..

> + */
> +struct xrt_subdev_pool {
> +	struct list_head xsp_dev_list;
> +	struct device *xsp_owner;
> +	struct mutex xsp_lock; /* pool lock */
Header files should be self contained, a quick look at xroot.h makes me suspicious that device and mutex decls assume the includer has added their headers before this one
> +	bool xsp_closing;
If you thing additional state will be needed, you could change this to a bitfield. sizewise with compiler padding i don't think the size would change.
> +};
> +
> +/*
> + * Subdev pool API for root and group drivers only.

'API' makes me think these should go in include/linux/fpga

Do/will these functions get called outside of the drivers/fpga ?

> + */
> +void xrt_subdev_pool_init(struct device *dev,
> +			  struct xrt_subdev_pool *spool);
> +void xrt_subdev_pool_fini(struct xrt_subdev_pool *spool);
> +int xrt_subdev_pool_get(struct xrt_subdev_pool *spool,
> +			xrt_subdev_match_t match,
> +			void *arg, struct device *holder_dev,
> +			struct platform_device **pdevp);
> +int xrt_subdev_pool_put(struct xrt_subdev_pool *spool,
> +			struct platform_device *pdev,
> +			struct device *holder_dev);
> +int xrt_subdev_pool_add(struct xrt_subdev_pool *spool,
> +			enum xrt_subdev_id id, xrt_subdev_root_cb_t pcb,
> +			void *pcb_arg, char *dtb);
> +int xrt_subdev_pool_del(struct xrt_subdev_pool *spool,
> +			enum xrt_subdev_id id, int instance);
> +ssize_t xrt_subdev_pool_get_holders(struct xrt_subdev_pool *spool,
> +				    struct platform_device *pdev,
> +				    char *buf, size_t len);
> +
> +void xrt_subdev_pool_trigger_event(struct xrt_subdev_pool *spool,
> +				   enum xrt_events evt);
> +void xrt_subdev_pool_handle_event(struct xrt_subdev_pool *spool,
> +				  struct xrt_event *evt);
> +
> +#endif	/* _XRT_SUBDEV_POOL_H_ */
> diff --git a/drivers/fpga/xrt/lib/xroot.c b/drivers/fpga/xrt/lib/xroot.c
> new file mode 100644
> index 000000000000..3dc7b0243277
> --- /dev/null
> +++ b/drivers/fpga/xrt/lib/xroot.c
> @@ -0,0 +1,598 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Xilinx Alveo FPGA Root Functions
> + *
> + * Copyright (C) 2020-2021 Xilinx, Inc.
> + *
> + * Authors:
> + *	Cheng Zhen <maxz@xilinx.com>
> + */
> +
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/hwmon.h>
> +#include "xroot.h"
> +#include "subdev_pool.h"
> +#include "group.h"
> +#include "metadata.h"
> +
> +#define XROOT_PDEV(xr)		((xr)->pdev)
> +#define XROOT_DEV(xr)		(&(XROOT_PDEV(xr)->dev))
> +#define xroot_err(xr, fmt, args...)	\
> +	dev_err(XROOT_DEV(xr), "%s: " fmt, __func__, ##args)
> +#define xroot_warn(xr, fmt, args...)	\
> +	dev_warn(XROOT_DEV(xr), "%s: " fmt, __func__, ##args)
> +#define xroot_info(xr, fmt, args...)	\
> +	dev_info(XROOT_DEV(xr), "%s: " fmt, __func__, ##args)
> +#define xroot_dbg(xr, fmt, args...)	\
> +	dev_dbg(XROOT_DEV(xr), "%s: " fmt, __func__, ##args)
> +
> +#define XRT_VSEC_ID		0x20

Is this the best place to define some pci magic ?

It looks like the xroot is combination of the root of the device tree and the pci setup for the board.

Can the pci-ness be split and the root mostly handling how the subtrees are organized ?

> +
> +#define XROOT_GRP_FIRST		(-1)
> +#define XROOT_GRP_LAST		(-2)
> +
> +static int xroot_root_cb(struct device *, void *, u32, void *);
> +
> +struct xroot_evt {
> +	struct list_head list;
> +	struct xrt_event evt;
> +	struct completion comp;
> +	bool async;
> +};
> +
> +struct xroot_events {
> +	struct mutex evt_lock; /* event lock */
> +	struct list_head evt_list;
> +	struct work_struct evt_work;
> +};
> +
> +struct xroot_grps {
> +	struct xrt_subdev_pool pool;
> +	struct work_struct bringup_work;
> +	atomic_t bringup_pending;
> +	atomic_t bringup_failed;
combine with bitfield
> +	struct completion bringup_comp;
> +};
> +
> +struct xroot {
> +	struct pci_dev *pdev;
> +	struct xroot_events events;
> +	struct xroot_grps grps;
> +	struct xroot_pf_cb pf_cb;
expand pf_cb, maybe 'physical_function_callback' ?
> +};
> +
> +struct xroot_grp_match_arg {
> +	enum xrt_subdev_id id;
> +	int instance;
> +};
> +
> +static bool xroot_grp_match(enum xrt_subdev_id id,
> +			    struct platform_device *pdev, void *arg)
> +{
> +	struct xroot_grp_match_arg *a = (struct xroot_grp_match_arg *)arg;
> +	return id == a->id && pdev->id == a->instance;

scanning the code i expected to see ... && pdev->instance == a->instance

pdev->id == a->instance looks like a bug, a change to pdev->id element name to pdev->instance or in needed of a comment.

> +}
> +
> +static int xroot_get_group(struct xroot *xr, int instance,
> +			   struct platform_device **grpp)
> +{
> +	int rc = 0;
> +	struct xrt_subdev_pool *grps = &xr->grps.pool;
> +	struct device *dev = DEV(xr->pdev);
> +	struct xroot_grp_match_arg arg = { XRT_SUBDEV_GRP, instance };
> +
> +	if (instance == XROOT_GRP_LAST) {
> +		rc = xrt_subdev_pool_get(grps, XRT_SUBDEV_MATCH_NEXT,
> +					 *grpp, dev, grpp);
> +	} else if (instance == XROOT_GRP_FIRST) {
> +		rc = xrt_subdev_pool_get(grps, XRT_SUBDEV_MATCH_PREV,
> +					 *grpp, dev, grpp);
For consistency, maybe the suffix of ...MATCH_NEXT/PREV should be changed to LAST/FIRST
> +	} else {
> +		rc = xrt_subdev_pool_get(grps, xroot_grp_match,
> +					 &arg, dev, grpp);
> +	}
> +
> +	if (rc && rc != -ENOENT)
> +		xroot_err(xr, "failed to hold group %d: %d", instance, rc);
> +	return rc;
> +}
> +
> +static void xroot_put_group(struct xroot *xr, struct platform_device *grp)
> +{
> +	int inst = grp->id;
> +	int rc = xrt_subdev_pool_put(&xr->grps.pool, grp, DEV(xr->pdev));
> +
> +	if (rc)
> +		xroot_err(xr, "failed to release group %d: %d", inst, rc);
> +}
> +
> +static int xroot_trigger_event(struct xroot *xr,
> +			       struct xrt_event *e, bool async)
> +{
> +	struct xroot_evt *enew = vzalloc(sizeof(*enew));
> +
> +	if (!enew)
> +		return -ENOMEM;
> +
> +	enew->evt = *e;
> +	enew->async = async;
> +	init_completion(&enew->comp);
> +
> +	mutex_lock(&xr->events.evt_lock);
> +	list_add(&enew->list, &xr->events.evt_list);
> +	mutex_unlock(&xr->events.evt_lock);
> +
> +	schedule_work(&xr->events.evt_work);
> +
> +	if (async)
> +		return 0;
> +
> +	wait_for_completion(&enew->comp);
> +	vfree(enew);
> +	return 0;
> +}
> +
> +static void
> +xroot_group_trigger_event(struct xroot *xr, int inst, enum xrt_events e)
> +{
> +	int ret;
> +	struct platform_device *pdev = NULL;
> +	struct xrt_event evt = { 0 };
> +
> +	WARN_ON(inst < 0);
> +	/* Only triggers subdev specific events. */
> +	if (e != XRT_EVENT_POST_CREATION && e != XRT_EVENT_PRE_REMOVAL) {
> +		xroot_err(xr, "invalid event %d", e);
> +		return;
> +	}
> +
> +	ret = xroot_get_group(xr, inst, &pdev);
> +	if (ret)
> +		return;
> +
> +	/* Triggers event for children, first. */
> +	(void)xleaf_ioctl(pdev, XRT_GROUP_TRIGGER_EVENT, (void *)(uintptr_t)e);
These voids are not needed, but maybe error checking is.
> +
> +	/* Triggers event for itself. */
> +	evt.xe_evt = e;
> +	evt.xe_subdev.xevt_subdev_id = XRT_SUBDEV_GRP;
> +	evt.xe_subdev.xevt_subdev_instance = inst;
> +	(void)xroot_trigger_event(xr, &evt, false);
> +
> +	(void)xroot_put_group(xr, pdev);
> +}
> +
> +int xroot_create_group(void *root, char *dtb)
> +{
> +	struct xroot *xr = (struct xroot *)root;
> +	int ret;
> +
> +	atomic_inc(&xr->grps.bringup_pending);
could this state and the error be moved to xrt_sbudev_pool_add where locking happens so atomics are not needed ?
> +	ret = xrt_subdev_pool_add(&xr->grps.pool, XRT_SUBDEV_GRP,
> +				  xroot_root_cb, xr, dtb);
> +	if (ret >= 0) {
> +		schedule_work(&xr->grps.bringup_work);
> +	} else {
> +		atomic_dec(&xr->grps.bringup_pending);
> +		atomic_inc(&xr->grps.bringup_failed);
> +		xroot_err(xr, "failed to create group: %d", ret);
> +	}
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(xroot_create_group);
> +
> +static int xroot_destroy_single_group(struct xroot *xr, int instance)
> +{
A better name would be 'xroot_destroy_group'
> +	struct platform_device *pdev = NULL;
> +	int ret;
> +
> +	WARN_ON(instance < 0);
> +	ret = xroot_get_group(xr, instance, &pdev);
> +	if (ret)
> +		return ret;
> +
> +	xroot_group_trigger_event(xr, instance, XRT_EVENT_PRE_REMOVAL);
> +
> +	/* Now tear down all children in this group. */
> +	ret = xleaf_ioctl(pdev, XRT_GROUP_FINI_CHILDREN, NULL);
> +	(void)xroot_put_group(xr, pdev);
> +	if (!ret) {
> +		ret = xrt_subdev_pool_del(&xr->grps.pool, XRT_SUBDEV_GRP,
> +					  instance);
> +	}
> +
> +	return ret;
> +}
> +
> +static int xroot_destroy_group(struct xroot *xr, int instance)
A better name would be 'xroot_destroy_groups'
> +{
> +	struct platform_device *target = NULL;
> +	struct platform_device *deps = NULL;
> +	int ret;
> +
> +	WARN_ON(instance < 0);
> +	/*
> +	 * Make sure target group exists and can't go away before
> +	 * we remove it's dependents
> +	 */
> +	ret = xroot_get_group(xr, instance, &target);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Remove all groups depend on target one.
> +	 * Assuming subdevs in higher group ID can depend on ones in
> +	 * lower ID groups, we remove them in the reservse order.
> +	 */
> +	while (xroot_get_group(xr, XROOT_GRP_LAST, &deps) != -ENOENT) {
> +		int inst = deps->id;
> +
> +		xroot_put_group(xr, deps);
> +		if (instance == inst)
> +			break;

breaking in the middle does not seem correct.

please add a comment

> +		(void)xroot_destroy_single_group(xr, inst);
> +		deps = NULL;
> +	}
> +
> +	/* Now we can remove the target group. */
> +	xroot_put_group(xr, target);
> +	return xroot_destroy_single_group(xr, instance);
> +}
> +
> +static int xroot_lookup_group(struct xroot *xr,
> +			      struct xrt_root_ioctl_lookup_group *arg)
> +{
> +	int rc = -ENOENT;
> +	struct platform_device *grp = NULL;
> +
> +	while (rc < 0 && xroot_get_group(xr, XROOT_GRP_LAST, &grp) != -ENOENT) {
> +		if (arg->xpilp_match_cb(XRT_SUBDEV_GRP, grp,
> +					arg->xpilp_match_arg)) {
> +			rc = grp->id;
> +		}
> +		xroot_put_group(xr, grp);
> +	}
> +	return rc;
> +}
> +
> +static void xroot_event_work(struct work_struct *work)
> +{
> +	struct xroot_evt *tmp;
> +	struct xroot *xr = container_of(work, struct xroot, events.evt_work);
> +
> +	mutex_lock(&xr->events.evt_lock);
> +	while (!list_empty(&xr->events.evt_list)) {
> +		tmp = list_first_entry(&xr->events.evt_list,
> +				       struct xroot_evt, list);
> +		list_del(&tmp->list);
> +		mutex_unlock(&xr->events.evt_lock);
why is unlocking necessary ?
> +
> +		(void)xrt_subdev_pool_handle_event(&xr->grps.pool, &tmp->evt);
> +
> +		if (tmp->async)
> +			vfree(tmp);
> +		else
> +			complete(&tmp->comp);
> +
> +		mutex_lock(&xr->events.evt_lock);
> +	}
> +	mutex_unlock(&xr->events.evt_lock);
> +}
> +
> +static void xroot_event_init(struct xroot *xr)
> +{
> +	INIT_LIST_HEAD(&xr->events.evt_list);
> +	mutex_init(&xr->events.evt_lock);
> +	INIT_WORK(&xr->events.evt_work, xroot_event_work);
> +}
> +
> +static void xroot_event_fini(struct xroot *xr)
> +{
> +	flush_scheduled_work();
> +	WARN_ON(!list_empty(&xr->events.evt_list));
> +}
> +
> +static int xroot_get_leaf(struct xroot *xr, struct xrt_root_ioctl_get_leaf *arg)
> +{
> +	int rc = -ENOENT;
> +	struct platform_device *grp = NULL;
> +
> +	while (rc && xroot_get_group(xr, XROOT_GRP_LAST, &grp) != -ENOENT) {

while (rc) ?

while we see an error on xleaf_ioctl, keep going ?

Seems like would rather have !rc

similar below in put_leaf

> +		rc = xleaf_ioctl(grp, XRT_GROUP_GET_LEAF, arg);
> +		xroot_put_group(xr, grp);
> +	}
> +	return rc;
> +}
> +
> +static int xroot_put_leaf(struct xroot *xr, struct xrt_root_ioctl_put_leaf *arg)
> +{
> +	int rc = -ENOENT;
> +	struct platform_device *grp = NULL;
> +
> +	while (rc && xroot_get_group(xr, XROOT_GRP_LAST, &grp) != -ENOENT) {
> +		rc = xleaf_ioctl(grp, XRT_GROUP_PUT_LEAF, arg);
> +		xroot_put_group(xr, grp);
> +	}
> +	return rc;
> +}
> +
> +static int xroot_root_cb(struct device *dev, void *parg, u32 cmd, void *arg)
> +{
> +	struct xroot *xr = (struct xroot *)parg;
> +	int rc = 0;
> +
> +	switch (cmd) {
> +	/* Leaf actions. */
> +	case XRT_ROOT_GET_LEAF: {
> +		struct xrt_root_ioctl_get_leaf *getleaf =
> +			(struct xrt_root_ioctl_get_leaf *)arg;
> +		rc = xroot_get_leaf(xr, getleaf);
> +		break;
> +	}
> +	case XRT_ROOT_PUT_LEAF: {
> +		struct xrt_root_ioctl_put_leaf *putleaf =
> +			(struct xrt_root_ioctl_put_leaf *)arg;
> +		rc = xroot_put_leaf(xr, putleaf);
> +		break;
> +	}
looking at these two cases without any changes to arg but a cast, i think these and the next pass the void * onto the function and have the function manage the cast.
> +	case XRT_ROOT_GET_LEAF_HOLDERS: {
> +		struct xrt_root_ioctl_get_holders *holders =
> +			(struct xrt_root_ioctl_get_holders *)arg;
> +		rc = xrt_subdev_pool_get_holders(&xr->grps.pool,
> +						 holders->xpigh_pdev,
> +						 holders->xpigh_holder_buf,
> +						 holders->xpigh_holder_buf_len);
> +		break;
> +	}
> +
> +	/* Group actions. */
> +	case XRT_ROOT_CREATE_GROUP:
> +		rc = xroot_create_group(xr, (char *)arg);
> +		break;
> +	case XRT_ROOT_REMOVE_GROUP:
> +		rc = xroot_destroy_group(xr, (int)(uintptr_t)arg);
> +		break;
> +	case XRT_ROOT_LOOKUP_GROUP: {
> +		struct xrt_root_ioctl_lookup_group *getgrp =
> +			(struct xrt_root_ioctl_lookup_group *)arg;
> +		rc = xroot_lookup_group(xr, getgrp);
> +		break;
> +	}
> +	case XRT_ROOT_WAIT_GROUP_BRINGUP:
> +		rc = xroot_wait_for_bringup(xr) ? 0 : -EINVAL;
> +		break;
> +
> +	/* Event actions. */
> +	case XRT_ROOT_EVENT:
> +	case XRT_ROOT_EVENT_ASYNC: {
> +		bool async = (cmd == XRT_ROOT_EVENT_ASYNC);
> +		struct xrt_event *evt = (struct xrt_event *)arg;
> +
> +		rc = xroot_trigger_event(xr, evt, async);
> +		break;
> +	}
> +
> +	/* Device info. */
> +	case XRT_ROOT_GET_RESOURCE: {
> +		struct xrt_root_ioctl_get_res *res =
> +			(struct xrt_root_ioctl_get_res *)arg;
> +		res->xpigr_res = xr->pdev->resource;
> +		break;
> +	}
> +	case XRT_ROOT_GET_ID: {
> +		struct xrt_root_ioctl_get_id *id =
> +			(struct xrt_root_ioctl_get_id *)arg;
> +
> +		id->xpigi_vendor_id = xr->pdev->vendor;
> +		id->xpigi_device_id = xr->pdev->device;
> +		id->xpigi_sub_vendor_id = xr->pdev->subsystem_vendor;
> +		id->xpigi_sub_device_id = xr->pdev->subsystem_device;
> +		break;
> +	}
> +
> +	/* MISC generic PCIE driver functions. */

misc functions may need a need some place else.

Is there a way to extend the cmd with some additional layer of abstraction ?

> +	case XRT_ROOT_HOT_RESET: {
> +		xr->pf_cb.xpc_hot_reset(xr->pdev);
> +		break;
> +	}
> +	case XRT_ROOT_HWMON: {
> +		struct xrt_root_ioctl_hwmon *hwmon =
> +			(struct xrt_root_ioctl_hwmon *)arg;
> +
> +		if (hwmon->xpih_register) {
> +			hwmon->xpih_hwmon_dev =
> +				hwmon_device_register_with_info(DEV(xr->pdev),
> +								hwmon->xpih_name,
> +								hwmon->xpih_drvdata,
> +								NULL,
> +								hwmon->xpih_groups);
> +		} else {
> +			(void)hwmon_device_unregister(hwmon->xpih_hwmon_dev);
> +		}
> +		break;
> +	}
> +
> +	default:
> +		xroot_err(xr, "unknown IOCTL cmd %d", cmd);
> +		rc = -EINVAL;
> +		break;
> +	}
> +
> +	return rc;
> +}
> +
> +static void xroot_bringup_group_work(struct work_struct *work)
> +{
> +	struct platform_device *pdev = NULL;
> +	struct xroot *xr = container_of(work, struct xroot, grps.bringup_work);
> +
> +	while (xroot_get_group(xr, XROOT_GRP_FIRST, &pdev) != -ENOENT) {
> +		int r, i;
> +
> +		i = pdev->id;
> +		r = xleaf_ioctl(pdev, XRT_GROUP_INIT_CHILDREN, NULL);
> +		(void)xroot_put_group(xr, pdev);
> +		if (r == -EEXIST)
> +			continue; /* Already brough up, nothing to do. */
> +		if (r)
> +			atomic_inc(&xr->grps.bringup_failed);
> +
> +		xroot_group_trigger_event(xr, i, XRT_EVENT_POST_CREATION);
> +
> +		if (atomic_dec_and_test(&xr->grps.bringup_pending))
> +			complete(&xr->grps.bringup_comp);
> +	}
> +}
> +
> +static void xroot_grps_init(struct xroot *xr)

Consistency in terms is needed. In the last few lines i see

group, grp, grps, my vote is for group(s)

> +{
> +	xrt_subdev_pool_init(DEV(xr->pdev), &xr->grps.pool);
> +	INIT_WORK(&xr->grps.bringup_work, xroot_bringup_group_work);
> +	atomic_set(&xr->grps.bringup_pending, 0);
> +	atomic_set(&xr->grps.bringup_failed, 0);
> +	init_completion(&xr->grps.bringup_comp);
> +}
> +
> +static void xroot_grps_fini(struct xroot *xr)
> +{
> +	flush_scheduled_work();
> +	xrt_subdev_pool_fini(&xr->grps.pool);
> +}
> +
> +int xroot_add_vsec_node(void *root, char *dtb)
> +{
This is the pci part i think needs to move to its own file.
> +	struct xroot *xr = (struct xroot *)root;
> +	struct device *dev = DEV(xr->pdev);
> +	struct xrt_md_endpoint ep = { 0 };
> +	int cap = 0, ret = 0;
> +	u32 off_low, off_high, vsec_bar, header;
> +	u64 vsec_off;
> +
> +	while ((cap = pci_find_next_ext_capability(xr->pdev, cap,
> +						   PCI_EXT_CAP_ID_VNDR))) {
> +		pci_read_config_dword(xr->pdev, cap + PCI_VNDR_HEADER, &header);
> +		if (PCI_VNDR_HEADER_ID(header) == XRT_VSEC_ID)
> +			break;
> +	}
> +	if (!cap) {
> +		xroot_info(xr, "No Vendor Specific Capability.");
> +		return -ENOENT;
> +	}
> +
> +	if (pci_read_config_dword(xr->pdev, cap + 8, &off_low) ||
> +	    pci_read_config_dword(xr->pdev, cap + 12, &off_high)) {
> +		xroot_err(xr, "pci_read vendor specific failed.");
> +		return -EINVAL;
> +	}
> +
> +	ep.ep_name = XRT_MD_NODE_VSEC;
> +	ret = xrt_md_add_endpoint(dev, dtb, &ep);
> +	if (ret) {
> +		xroot_err(xr, "add vsec metadata failed, ret %d", ret);
> +		goto failed;
> +	}
> +
> +	vsec_bar = cpu_to_be32(off_low & 0xf);
> +	ret = xrt_md_set_prop(dev, dtb, XRT_MD_NODE_VSEC, NULL,
> +			      XRT_MD_PROP_BAR_IDX, &vsec_bar, sizeof(vsec_bar));
> +	if (ret) {
> +		xroot_err(xr, "add vsec bar idx failed, ret %d", ret);
> +		goto failed;
> +	}
> +
> +	vsec_off = cpu_to_be64(((u64)off_high << 32) | (off_low & ~0xfU));
> +	ret = xrt_md_set_prop(dev, dtb, XRT_MD_NODE_VSEC, NULL,
> +			      XRT_MD_PROP_OFFSET, &vsec_off, sizeof(vsec_off));
> +	if (ret) {
> +		xroot_err(xr, "add vsec offset failed, ret %d", ret);
> +		goto failed;
> +	}
> +
> +failed:
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(xroot_add_vsec_node);
> +
> +int xroot_add_simple_node(void *root, char *dtb, const char *endpoint)
> +{
> +	struct xroot *xr = (struct xroot *)root;
> +	struct device *dev = DEV(xr->pdev);
> +	struct xrt_md_endpoint ep = { 0 };
> +	int ret = 0;
> +
> +	ep.ep_name = endpoint;
> +	ret = xrt_md_add_endpoint(dev, dtb, &ep);
> +	if (ret)
> +		xroot_err(xr, "add %s failed, ret %d", endpoint, ret);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(xroot_add_simple_node);
> +
> +bool xroot_wait_for_bringup(void *root)
> +{
> +	struct xroot *xr = (struct xroot *)root;
> +
> +	wait_for_completion(&xr->grps.bringup_comp);
> +	return atomic_xchg(&xr->grps.bringup_failed, 0) == 0;
Is there going to a race in intialization ?
> +}
> +EXPORT_SYMBOL_GPL(xroot_wait_for_bringup);
> +
> +int xroot_probe(struct pci_dev *pdev, struct xroot_pf_cb *cb, void **root)
> +{
> +	struct device *dev = DEV(pdev);
> +	struct xroot *xr = NULL;
> +
> +	dev_info(dev, "%s: probing...", __func__);
> +
> +	xr = devm_kzalloc(dev, sizeof(*xr), GFP_KERNEL);
> +	if (!xr)
> +		return -ENOMEM;
> +
> +	xr->pdev = pdev;
> +	xr->pf_cb = *cb;
> +	xroot_grps_init(xr);
> +	xroot_event_init(xr);
> +
> +	*root = xr;
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(xroot_probe);
> +
> +void xroot_remove(void *root)
> +{
> +	struct xroot *xr = (struct xroot *)root;
> +	struct platform_device *grp = NULL;
> +
> +	xroot_info(xr, "leaving...");
> +
> +	if (xroot_get_group(xr, XROOT_GRP_FIRST, &grp) == 0) {
> +		int instance = grp->id;

another instance = id, the variable and element names should be consistent.

earlier (id, instance) is used to uniquely determine a node. if that is so then using the names should be kept seperate.

> +
> +		xroot_put_group(xr, grp);
> +		(void)xroot_destroy_group(xr, instance);
> +	}
> +
> +	xroot_event_fini(xr);
> +	xroot_grps_fini(xr);
> +}
> +EXPORT_SYMBOL_GPL(xroot_remove);
> +
> +void xroot_broadcast(void *root, enum xrt_events evt)
> +{
> +	struct xroot *xr = (struct xroot *)root;
> +	struct xrt_event e = { 0 };
> +
> +	/* Root pf driver only broadcasts below two events. */
> +	if (evt != XRT_EVENT_POST_CREATION && evt != XRT_EVENT_PRE_REMOVAL) {
> +		xroot_info(xr, "invalid event %d", evt);
> +		return;
> +	}
> +
> +	e.xe_evt = evt;
> +	e.xe_subdev.xevt_subdev_id = XRT_ROOT;
> +	e.xe_subdev.xevt_subdev_instance = 0;

see..

id =

instance =

Tom

> +	(void)xroot_trigger_event(xr, &e, false);
> +}
> +EXPORT_SYMBOL_GPL(xroot_broadcast);


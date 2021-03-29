Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4353C34D87B
	for <lists+linux-fpga@lfdr.de>; Mon, 29 Mar 2021 21:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbhC2TpI (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 29 Mar 2021 15:45:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31928 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231815AbhC2Tol (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 29 Mar 2021 15:44:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617047080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HfGemtEEc++ayiyi27LQ/1OVDD9D2mP6nkDIbuqq90I=;
        b=VUbFv0mCaFUNlsEzTGfm/zG2EDr+Sgs2MKxWkJSx8yzl72mwbXggZQp7jh+GnNCAz/iTUY
        vMdl1HPD4wqMt9hg9Z2wS9XStj9LGfzNNF/0LiTPNttoP6U4CLU0cn4utAgKhwBA0fL3eh
        3AhhpJXypHqoRQ5T7GwpGx6k6mySo7M=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-183-iGR-_EB8OlKHyPdVb0cZxg-1; Mon, 29 Mar 2021 15:44:39 -0400
X-MC-Unique: iGR-_EB8OlKHyPdVb0cZxg-1
Received: by mail-qt1-f200.google.com with SMTP id a16so8298552qtw.1
        for <linux-fpga@vger.kernel.org>; Mon, 29 Mar 2021 12:44:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=HfGemtEEc++ayiyi27LQ/1OVDD9D2mP6nkDIbuqq90I=;
        b=CdRl2MfjLvBZsBKf6H40gdFg7IO0Iwzml22T2XdsQ7i34FTgUxAwR9hFyFcuZIRqnM
         IpziHKNzLYMYzEkQCXMqJ6DKqFQcn8/HlhfBRwxIraLCmczQRZFa3aJPhE6n9l/Y3CYL
         73VxgE9WC9D1wsGh1oMmQvEF9gMokfclOITv+dEvdrhNRO060JKrRtoX4AsvEnbcmHpo
         oBC85ynenolGfSIgsbJo2B9U8s4fasmAfOlcfluX0i9MDpJMuMnRencIknlh35mSPBtb
         Bf1+Fe7wYgZHJZAmV68uEoGcCHpbJ4iULqnkdTTorE2/3jTUwLD9T98fOD69Eb5Jij23
         y+rg==
X-Gm-Message-State: AOAM5334qVRcnx7PCBE7hLiNGhhS2gmBS8MQXes1h7oRpAVTiy5DrYBb
        5B79dlAi6Y9sDXtk7+iZ3WPWvYtOl4TLCi1JyBdFVhz6f5chQnABIbQef92poNjM5E4F251sD4a
        Tgm+Xy0U3K7eb7Hz7YiloHA==
X-Received: by 2002:a05:6214:2ea:: with SMTP id h10mr17803495qvu.55.1617047077680;
        Mon, 29 Mar 2021 12:44:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJztmBDazJ2ofAmGdbbvMwz/alxYjJ6MNqiSH6VE2NAkC6M4Cb21qg4n2gUrzVcBreT2pJVkcw==
X-Received: by 2002:a05:6214:2ea:: with SMTP id h10mr17803466qvu.55.1617047077267;
        Mon, 29 Mar 2021 12:44:37 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id h5sm11517985qtq.1.2021.03.29.12.44.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Mar 2021 12:44:36 -0700 (PDT)
Subject: Re: [PATCH V4 XRT Alveo 04/20] fpga: xrt: xrt-lib platform driver
 manager
To:     Lizhi Hou <lizhi.hou@xilinx.com>, linux-kernel@vger.kernel.org,
        Max Zhen <max.zhen@xilinx.com>,
        "mdf@kernel.org" <mdf@kernel.org>
Cc:     linux-fpga@vger.kernel.org, maxz@xilinx.com,
        sonal.santan@xilinx.com, yliu@xilinx.com, michal.simek@xilinx.com,
        stefanos@xilinx.com, devicetree@vger.kernel.org, mdf@kernel.org,
        robh@kernel.org
References: <20210324052947.27889-1-lizhi.hou@xilinx.com>
 <20210324052947.27889-5-lizhi.hou@xilinx.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <73acaff9-d8a7-ff26-e838-7184c08c513f@redhat.com>
Date:   Mon, 29 Mar 2021 12:44:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210324052947.27889-5-lizhi.hou@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

bisectablity may be/is  an issue.

Moritz,

building happens on the last patch, so in theory there will never be a build break needing bisection.  Do we care about the misordering of serveral of these patches?

On 3/23/21 10:29 PM, Lizhi Hou wrote:
> xrt-lib kernel module infrastructure code to register and manage all
> leaf driver modules.
>
> Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
> Signed-off-by: Max Zhen <max.zhen@xilinx.com>
> Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
> ---
>  drivers/fpga/xrt/include/subdev_id.h |  38 ++++
>  drivers/fpga/xrt/include/xleaf.h     | 264 +++++++++++++++++++++++++
>  drivers/fpga/xrt/lib/lib-drv.c       | 277 +++++++++++++++++++++++++++
ok
>  drivers/fpga/xrt/lib/lib-drv.h       |  17 ++
>  4 files changed, 596 insertions(+)
>  create mode 100644 drivers/fpga/xrt/include/subdev_id.h
>  create mode 100644 drivers/fpga/xrt/include/xleaf.h
>  create mode 100644 drivers/fpga/xrt/lib/lib-drv.c
>  create mode 100644 drivers/fpga/xrt/lib/lib-drv.h
>
> diff --git a/drivers/fpga/xrt/include/subdev_id.h b/drivers/fpga/xrt/include/subdev_id.h
> new file mode 100644
> index 000000000000..42fbd6f5e80a
> --- /dev/null
> +++ b/drivers/fpga/xrt/include/subdev_id.h
> @@ -0,0 +1,38 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
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
> + * Every subdev driver has an ID for others to refer to it. There can be multiple number of
> + * instances of a subdev driver. A <subdev_id, subdev_instance> tuple is a unique identification
> + * of a specific instance of a subdev driver.
> + */
> +enum xrt_subdev_id {
> +	XRT_SUBDEV_GRP = 0,
not necessary to initialize all unless there are gaps.
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
> index 000000000000..acb500df04b0
> --- /dev/null
> +++ b/drivers/fpga/xrt/include/xleaf.h
> @@ -0,0 +1,264 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
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
> +#include <linux/platform_device.h>
> +#include <linux/fs.h>
> +#include <linux/cdev.h>
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
> +enum {
> +	/* Starting cmd for common leaf cmd implemented by all leaves. */
> +	XRT_XLEAF_COMMON_BASE = 0,
> +	/* Starting cmd for leaves' specific leaf cmds. */
> +	XRT_XLEAF_CUSTOM_BASE = 64,
> +};
> +
> +enum xrt_xleaf_common_leaf_cmd {
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
> +	 * If defined, these are called by other leaf drivers.
> +	 * Note that root driver may call into xsd_leaf_call of a group driver.
> +	 */
> +	int (*xsd_leaf_call)(struct platform_device *pdev, u32 cmd, void *arg);
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
> +	bool xsp_dtb_valid;
> +	char xsp_dtb[0];
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
> +	int instance = a->instance;
> +
> +	if (id != a->id)
> +		return false;
> +	if (instance != pdev->id && instance != PLATFORM_DEVID_NONE)
> +		return false;
> +	return true;
> +}
> +
> +static inline bool xrt_subdev_match_epname(enum xrt_subdev_id id,
> +					   struct platform_device *pdev, void *arg)
> +{
> +	return xleaf_has_endpoint(pdev, arg);
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
> +static inline int xleaf_call(struct platform_device *tgt, u32 cmd, void *arg)
> +{
> +	struct xrt_subdev_drvdata *drvdata = DEV_DRVDATA(tgt);
> +
> +	return (*drvdata->xsd_dev_ops.xsd_leaf_call)(tgt, cmd, arg);
> +}
> +
> +int xleaf_broadcast_event(struct platform_device *pdev, enum xrt_events evt, bool async);
> +int xleaf_create_group(struct platform_device *pdev, char *dtb);
> +int xleaf_destroy_group(struct platform_device *pdev, int instance);
> +void xleaf_get_barres(struct platform_device *pdev, struct resource **res, uint bar_idx);
> +void xleaf_get_root_id(struct platform_device *pdev, unsigned short *vendor, unsigned short *device,
> +		       unsigned short *subvendor, unsigned short *subdevice);
> +void xleaf_hot_reset(struct platform_device *pdev);
> +int xleaf_put_leaf(struct platform_device *pdev, struct platform_device *leaf);
> +struct device *xleaf_register_hwmon(struct platform_device *pdev, const char *name, void *drvdata,
> +				    const struct attribute_group **grps);
> +void xleaf_unregister_hwmon(struct platform_device *pdev, struct device *hwmon);
> +int xleaf_wait_for_group_bringup(struct platform_device *pdev);
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
> +int xleaf_register_driver(enum xrt_subdev_id id, struct platform_driver *drv,
> +			  struct xrt_subdev_endpoints *eps);
> +void xleaf_unregister_driver(enum xrt_subdev_id id);
> +
> +/* Module's init/fini routines for leaf driver in xrt-lib module */
> +#define XRT_LEAF_INIT_FINI_FUNC(_id, name)				\
> +void name##_leaf_init_fini(bool init)					\
> +{									\
> +	typeof(_id) id = _id;						\
> +	if (init) {							\
> +		xleaf_register_driver(id,				\
> +				      &xrt_##name##_driver,		\
> +				      xrt_##name##_endpoints);		\
> +	} else {							\
> +		xleaf_unregister_driver(id);				\
> +	}								\
> +}
> +
> +void group_leaf_init_fini(bool init);
> +void vsec_leaf_init_fini(bool init);
> +void devctl_leaf_init_fini(bool init);
> +void axigate_leaf_init_fini(bool init);
> +void icap_leaf_init_fini(bool init);
> +void calib_leaf_init_fini(bool init);
> +void clkfreq_leaf_init_fini(bool init);
> +void clock_leaf_init_fini(bool init);
> +void ucs_leaf_init_fini(bool init);
> +
> +#endif	/* _XRT_LEAF_H_ */
> diff --git a/drivers/fpga/xrt/lib/lib-drv.c b/drivers/fpga/xrt/lib/lib-drv.c
> new file mode 100644
> index 000000000000..64bb8710be66
> --- /dev/null
> +++ b/drivers/fpga/xrt/lib/lib-drv.c
> @@ -0,0 +1,277 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2020-2021 Xilinx, Inc.
> + *
> + * Authors:
> + *	Cheng Zhen <maxz@xilinx.com>
> + */
> +
> +#include <linux/module.h>
> +#include <linux/vmalloc.h>
> +#include "xleaf.h"
> +#include "xroot.h"
> +#include "lib-drv.h"
> +
> +#define XRT_IPLIB_MODULE_NAME		"xrt-lib"
> +#define XRT_IPLIB_MODULE_VERSION	"4.0.0"
> +#define XRT_MAX_DEVICE_NODES		128
> +#define XRT_DRVNAME(drv)		((drv)->driver.name)
> +
> +/*
> + * Subdev driver is known by it's ID to others. We map the ID to it's
ok
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
> +__xrt_drv_find_map_by_id(enum xrt_subdev_id id)
ok
> +{
> +	struct xrt_drv_map *tmap;
> +
> +	list_for_each_entry(tmap, &xrt_drv_maps, list) {
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
> +	map = __xrt_drv_find_map_by_id(id);
> +	mutex_unlock(&xrt_lib_lock);
> +	/*
> +	 * map should remain valid even after the lock is dropped since a registered
ok
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
> +	int rc;
> +
> +	mutex_lock(&xrt_lib_lock);
> +
> +	map = __xrt_drv_find_map_by_id(id);
> +	if (map) {
> +		mutex_unlock(&xrt_lib_lock);
> +		pr_err("Id %d already has a registered driver, 0x%p\n",
> +		       id, map->drv);
> +		return -EEXIST;
> +	}
> +
> +	map = kzalloc(sizeof(*map), GFP_KERNEL);
ok
> +	if (!map) {
> +		mutex_unlock(&xrt_lib_lock);
> +		return -ENOMEM;
> +	}
> +	map->id = id;
> +	map->drv = drv;
> +	map->eps = eps;
> +
> +	rc = xrt_drv_register_driver(map);
> +	if (rc) {
ok
> +		kfree(map);
> +		mutex_unlock(&xrt_lib_lock);
> +		return rc;
> +	}
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
> +	map = __xrt_drv_find_map_by_id(id);
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
> +	kfree(map);
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
add comment to effect that dynamically adding drivers/ID's are not supported.
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
> +		kfree(map);
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
> diff --git a/drivers/fpga/xrt/lib/lib-drv.h b/drivers/fpga/xrt/lib/lib-drv.h
> new file mode 100644
> index 000000000000..a94c58149cb4
> --- /dev/null
> +++ b/drivers/fpga/xrt/lib/lib-drv.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2020-2021 Xilinx, Inc.
> + *
> + * Authors:
> + *	Cheng Zhen <maxz@xilinx.com>
> + */
> +
> +#ifndef _LIB_DRV_H_
> +#define _LIB_DRV_H_
> +
> +const char *xrt_drv_name(enum xrt_subdev_id id);

bisectablity may be /is still an issue.

Tom

> +int xrt_drv_get_instance(enum xrt_subdev_id id);
> +void xrt_drv_put_instance(enum xrt_subdev_id id, int instance);
> +struct xrt_subdev_endpoints *xrt_drv_get_endpoints(enum xrt_subdev_id id);
> +
> +#endif	/* _LIB_DRV_H_ */


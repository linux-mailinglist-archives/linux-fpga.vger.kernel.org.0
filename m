Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA12320D91
	for <lists+linux-fpga@lfdr.de>; Sun, 21 Feb 2021 21:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbhBUUVn (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 21 Feb 2021 15:21:43 -0500
Received: from mail-pf1-f175.google.com ([209.85.210.175]:44967 "EHLO
        mail-pf1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbhBUUVk (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 21 Feb 2021 15:21:40 -0500
Received: by mail-pf1-f175.google.com with SMTP id t29so5266670pfg.11;
        Sun, 21 Feb 2021 12:21:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=APqVdABLzG5UzazVGxKXPyhfAPWdQIk3G5SNCXGKyX0=;
        b=rQEyr4Jwo5qjBwqxKT6bcvngIK/iH2TgwBIWgCfNA2xI3kPvAY3lmPFA5kJO8Zt0xp
         VoWrwsgKFjlm6bmo4B//jN9quJPMRO6clf1iiqOqSy8HYuKTyvjO8/zBCs4NNoi8onYn
         a9CU7cGJ3kx+C5/YI2LHmwaYr4jtIGYEm38cxPM8kAngC7/tM5IE/O8hs5HoiAaYSwXx
         KH8KWfelCu3TImLsmbL+PSUjM/YgW+Tx9JNTxbO8Kpgdms8KnofZsuWs0dyC7deN7D24
         0xTpEqvAztsbi54WdUO6ogjH9TcP6Oy56lcS5wAzIrqj6NLqgDdtgbwYaDae4XkHE86k
         JQqg==
X-Gm-Message-State: AOAM530N6eN7aZuv5gGFaCa5oztv9PHMhiJXOWVDDxql6533ycVOasOZ
        2GdidvrTmYTWne8uIpttdrU=
X-Google-Smtp-Source: ABdhPJyqO9VrJTGtLdvqdr8Qh+mtpJAINzs0USNF5x+lI5qCh7kaiJOVsAQ4OZr6XhZZzMAzTmN/Ag==
X-Received: by 2002:a63:2643:: with SMTP id m64mr9574701pgm.4.1613938858477;
        Sun, 21 Feb 2021 12:20:58 -0800 (PST)
Received: from localhost ([2601:647:5b00:1162:1ac0:17a6:4cc6:d1ef])
        by smtp.gmail.com with ESMTPSA id j201sm5844615pfd.143.2021.02.21.12.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Feb 2021 12:20:57 -0800 (PST)
Date:   Sun, 21 Feb 2021 12:21:00 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     Lizhi Hou <lizhi.hou@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, Lizhi Hou <lizhih@xilinx.com>,
        linux-fpga@vger.kernel.org, maxz@xilinx.com,
        sonal.santan@xilinx.com, michal.simek@xilinx.com,
        stefanos@xilinx.com, devicetree@vger.kernel.org, trix@redhat.com,
        mdf@kernel.org, robh@kernel.org, Max Zhen <max.zhen@xilinx.com>
Subject: Re: [PATCH V3 XRT Alveo 16/18] fpga: xrt: DDR calibration platform
 driver
Message-ID: <YDLArLO6TXPhUNPE@archbook>
References: <20210218064019.29189-1-lizhih@xilinx.com>
 <20210218064019.29189-17-lizhih@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210218064019.29189-17-lizhih@xilinx.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Lizhi,

On Wed, Feb 17, 2021 at 10:40:17PM -0800, Lizhi Hou wrote:
> Add DDR calibration driver. DDR calibration is a hardware function
> discovered by walking firmware metadata. A platform device node will
> be created for it. Hardware provides DDR calibration status through
> this function.
> 
> Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
> Signed-off-by: Max Zhen <max.zhen@xilinx.com>
> Signed-off-by: Lizhi Hou <lizhih@xilinx.com>
> ---
>  drivers/fpga/xrt/include/xleaf/calib.h |  30 ++++
>  drivers/fpga/xrt/lib/xleaf/calib.c     | 226 +++++++++++++++++++++++++
>  2 files changed, 256 insertions(+)
>  create mode 100644 drivers/fpga/xrt/include/xleaf/calib.h
>  create mode 100644 drivers/fpga/xrt/lib/xleaf/calib.c
> 
> diff --git a/drivers/fpga/xrt/include/xleaf/calib.h b/drivers/fpga/xrt/include/xleaf/calib.h
> new file mode 100644
> index 000000000000..f8aba4594c58
> --- /dev/null
> +++ b/drivers/fpga/xrt/include/xleaf/calib.h
> @@ -0,0 +1,30 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Header file for XRT DDR Calibration Leaf Driver
> + *
> + * Copyright (C) 2020-2021 Xilinx, Inc.
> + *
> + * Authors:
> + *	Cheng Zhen <maxz@xilinx.com>
> + */
> +
> +#ifndef _XRT_CALIB_H_
> +#define _XRT_CALIB_H_
> +
> +#include "xleaf.h"
> +#include <linux/xrt/xclbin.h>
> +
> +/*
> + * Memory calibration driver IOCTL calls.
> + */
> +enum xrt_calib_results {
> +	XRT_CALIB_UNKNOWN,
> +	XRT_CALIB_SUCCEEDED,
> +	XRT_CALIB_FAILED,
> +};
> +
> +enum xrt_calib_ioctl_cmd {
> +	XRT_CALIB_RESULT = XRT_XLEAF_CUSTOM_BASE, /* See comments in xleaf.h */
> +};
Could this be using sysfs instead of an IOCTL?
> +
> +#endif	/* _XRT_CALIB_H_ */
> diff --git a/drivers/fpga/xrt/lib/xleaf/calib.c b/drivers/fpga/xrt/lib/xleaf/calib.c
> new file mode 100644
> index 000000000000..fbb813636e76
> --- /dev/null
> +++ b/drivers/fpga/xrt/lib/xleaf/calib.c
> @@ -0,0 +1,226 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Xilinx Alveo FPGA memory calibration driver
> + *
> + * Copyright (C) 2020-2021 Xilinx, Inc.
> + *
> + * memory calibration
> + *
> + * Authors:
> + *      Lizhi Hou<Lizhi.Hou@xilinx.com>
> + */
> +#include <linux/delay.h>
> +#include "xclbin-helper.h"
> +#include "metadata.h"
> +#include "xleaf/calib.h"
> +
> +#define XRT_CALIB	"xrt_calib"
> +
> +struct calib_cache {
> +	struct list_head	link;
> +	const char		*ep_name;
> +	char			*data;
> +	u32			data_size;
> +};
> +
> +struct calib {
> +	struct platform_device	*pdev;
> +	void			*calib_base;
> +	struct mutex		lock; /* calibration dev lock */
> +	struct list_head	cache_list;
> +	u32			cache_num;
> +	enum xrt_calib_results	result;
> +};
> +
> +#define CALIB_DONE(calib)			\
> +	(ioread32((calib)->calib_base) & BIT(0))
> +
> +static void calib_cache_clean_nolock(struct calib *calib)
> +{
> +	struct calib_cache *cache, *temp;
> +
> +	list_for_each_entry_safe(cache, temp, &calib->cache_list, link) {
> +		vfree(cache->data);
> +		list_del(&cache->link);
> +		vfree(cache);
> +	}
> +	calib->cache_num = 0;
> +}
> +
> +static void calib_cache_clean(struct calib *calib)
> +{
> +	mutex_lock(&calib->lock);
> +	calib_cache_clean_nolock(calib);
> +	mutex_unlock(&calib->lock);
> +}
> +
> +static int calib_srsr(struct calib *calib, struct platform_device *srsr_leaf)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static int calib_calibration(struct calib *calib)
> +{
> +	int i;
> +
> +	for (i = 0; i < 20; i++) {
> +		if (CALIB_DONE(calib))
> +			break;
> +		msleep(500);
> +	}
> +
> +	if (i == 20) {
> +		xrt_err(calib->pdev,
> +			"MIG calibration timeout after bitstream download");
> +		return -ETIMEDOUT;
> +	}
> +
> +	xrt_info(calib->pdev, "took %dms", i * 500);
> +	return 0;
> +}
> +
> +static void xrt_calib_event_cb(struct platform_device *pdev, void *arg)
> +{
> +	struct calib *calib = platform_get_drvdata(pdev);
> +		struct xrt_event *evt = (struct xrt_event *)arg;
> +	enum xrt_events e = evt->xe_evt;
> +	enum xrt_subdev_id id = evt->xe_subdev.xevt_subdev_id;
> +	int instance = evt->xe_subdev.xevt_subdev_instance;
> +	struct platform_device *leaf;
> +	int ret;
> +
> +	switch (e) {
> +	case XRT_EVENT_POST_CREATION: {
> +		if (id == XRT_SUBDEV_SRSR) {
> +			leaf = xleaf_get_leaf_by_id(pdev,
> +						    XRT_SUBDEV_SRSR,
> +						    instance);
> +			if (!leaf) {
> +				xrt_err(pdev, "does not get SRSR subdev");
> +				return;
> +			}
> +			ret = calib_srsr(calib, leaf);
> +			xleaf_put_leaf(pdev, leaf);
> +			calib->result =
> +				ret ? XRT_CALIB_FAILED : XRT_CALIB_SUCCEEDED;
> +		} else if (id == XRT_SUBDEV_UCS) {
> +			ret = calib_calibration(calib);
> +			calib->result =
> +				ret ? XRT_CALIB_FAILED : XRT_CALIB_SUCCEEDED;
> +		}
> +		break;
> +	}
> +	default:
> +		break;
> +	}
> +}
> +
> +static int xrt_calib_remove(struct platform_device *pdev)
> +{
> +	struct calib *calib = platform_get_drvdata(pdev);
> +
> +	calib_cache_clean(calib);
> +
> +	if (calib->calib_base)
> +		iounmap(calib->calib_base);
> +
> +	platform_set_drvdata(pdev, NULL);
> +	devm_kfree(&pdev->dev, calib);
> +
> +	return 0;
> +}
> +
> +static int xrt_calib_probe(struct platform_device *pdev)
> +{
> +	struct calib *calib;
> +	struct resource *res;
> +	int err = 0;
> +
> +	calib = devm_kzalloc(&pdev->dev, sizeof(*calib), GFP_KERNEL);
> +	if (!calib)
> +		return -ENOMEM;
> +
> +	calib->pdev = pdev;
> +	platform_set_drvdata(pdev, calib);
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res)
> +		goto failed;
> +
> +	calib->calib_base = ioremap(res->start, res->end - res->start + 1);
> +	if (!calib->calib_base) {
> +		err = -EIO;
> +		xrt_err(pdev, "Map iomem failed");
> +		goto failed;
> +	}
> +
> +	mutex_init(&calib->lock);
> +	INIT_LIST_HEAD(&calib->cache_list);
> +
> +	return 0;
> +
> +failed:
> +	xrt_calib_remove(pdev);
> +	return err;
> +}

This is extremly weird imho, you have a platform driver that essentially
does not register with a subsystem or anything else.

Do you intend to use this from the outside through
platform_get_drvdata(), or how does this tie together with the rest?
> +
> +static int
> +xrt_calib_leaf_ioctl(struct platform_device *pdev, u32 cmd, void *arg)
> +{
> +	struct calib *calib = platform_get_drvdata(pdev);
> +	int ret = 0;
> +
> +	switch (cmd) {
> +	case XRT_XLEAF_EVENT:
> +		xrt_calib_event_cb(pdev, arg);
> +		break;
> +	case XRT_CALIB_RESULT: {
> +		enum xrt_calib_results *r = (enum xrt_calib_results *)arg;
> +		*r = calib->result;
> +		break;
> +	}
> +	default:
> +		xrt_err(pdev, "unsupported cmd %d", cmd);
> +		ret = -EINVAL;
> +	}
> +	return ret;
> +}
> +
> +static struct xrt_subdev_endpoints xrt_calib_endpoints[] = {
> +	{
> +		.xse_names = (struct xrt_subdev_ep_names[]) {
> +			{ .ep_name = XRT_MD_NODE_DDR_CALIB },
> +			{ NULL },
> +		},
> +		.xse_min_ep = 1,
> +	},
> +	{ 0 },
> +};
> +
> +static struct xrt_subdev_drvdata xrt_calib_data = {
> +	.xsd_dev_ops = {
> +		.xsd_ioctl = xrt_calib_leaf_ioctl,
> +	},
> +};
> +
> +static const struct platform_device_id xrt_calib_table[] = {
> +	{ XRT_CALIB, (kernel_ulong_t)&xrt_calib_data },
> +	{ },
> +};
> +
> +static struct platform_driver xrt_calib_driver = {
> +	.driver = {
> +		.name = XRT_CALIB,
> +	},
> +	.probe = xrt_calib_probe,
> +	.remove = xrt_calib_remove,
> +	.id_table = xrt_calib_table,
> +};
> +
> +void calib_leaf_init_fini(bool init)
> +{
> +	if (init)
> +		xleaf_register_driver(XRT_SUBDEV_CALIB, &xrt_calib_driver, xrt_calib_endpoints);
> +	else
> +		xleaf_unregister_driver(XRT_SUBDEV_CALIB);
> +}
> -- 
> 2.18.4
> 
- Moritz

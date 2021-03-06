Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA0032FB61
	for <lists+linux-fpga@lfdr.de>; Sat,  6 Mar 2021 16:36:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbhCFPfY (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 6 Mar 2021 10:35:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52869 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230489AbhCFPey (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 6 Mar 2021 10:34:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615044893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R3hQZSQ9MJ2knEb9nSe7iww33RZoQyXEr4sHQKxLqXg=;
        b=Zcewowf5NIqvZ6AvRxRTzyUBOpDn5t284DHxuzQ/5+xcHLPEEzwbH8ObUJINnafIWnCeJP
        AQ/6dqRJTuAdTvfXmq5+lwbD4T0o62WT4qMemXjQS1KICkwAiUIdQrfIOCF//CTmoFxk8H
        j/k7dA5iHF5p66o/9R/5WTk2ITh8W9s=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-508-Yq7o5TutNcaBHC6iPL8n5w-1; Sat, 06 Mar 2021 10:34:52 -0500
X-MC-Unique: Yq7o5TutNcaBHC6iPL8n5w-1
Received: by mail-qv1-f72.google.com with SMTP id s16so3893063qvw.3
        for <linux-fpga@vger.kernel.org>; Sat, 06 Mar 2021 07:34:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=R3hQZSQ9MJ2knEb9nSe7iww33RZoQyXEr4sHQKxLqXg=;
        b=ZylSqHzK49bydzQnthm6DSrWRHx5c1QG+QUbtWbky5kg7sUwt1xBBpvOwGkd9PIWEE
         8eQFQsEEHi/07wXgPEiw2ozmATrzERxXPZSk1yX9iZlvsnOnO+BbilqyClGka2gru4wb
         8eBPhFoipza/jiere2o830GeuBGuzLSTrUfld6d91JLhhIBpB/v2is+H+E2Rs2RVBu+n
         PBVrV2q3lBGUerC+bfCn04HrORsq+pKpz1Jz1n+OXig71txVXrASb6UrfdqBA8lmPihf
         PXJGpYWV7P4CEYT+jRIycMWWTB9aJ/60MQMLN1iX0BUNfKvfhR6hXsFpUUAeIzHXDl8y
         YTOQ==
X-Gm-Message-State: AOAM530sl4CTfNRV1eVQlPIM/APODvHhAXJAeu8AuPKjC/UXUTahofnl
        8XF81cFNhEAWzn34uoyGbFB7nZvFffX3q+46tXg/D0p6SE2cHka9jLytvqHKNDP73B000AWFee6
        lNdrvgxqWJaRQA4TiORXHMQ==
X-Received: by 2002:a37:6115:: with SMTP id v21mr13815997qkb.239.1615044891649;
        Sat, 06 Mar 2021 07:34:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxNs84qV4rSvCJc2zO7VA6gkRpmtfs+aMA1mbyFBABSgKFo0mgqvdgr5fW9ReJYGv4kUFGqoA==
X-Received: by 2002:a37:6115:: with SMTP id v21mr13815981qkb.239.1615044891434;
        Sat, 06 Mar 2021 07:34:51 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id b22sm4133701qkk.45.2021.03.06.07.34.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Mar 2021 07:34:51 -0800 (PST)
Subject: Re: [PATCH V3 XRT Alveo 16/18] fpga: xrt: DDR calibration platform
 driver
To:     Lizhi Hou <lizhi.hou@xilinx.com>, linux-kernel@vger.kernel.org
Cc:     Lizhi Hou <lizhih@xilinx.com>, linux-fpga@vger.kernel.org,
        maxz@xilinx.com, sonal.santan@xilinx.com, michal.simek@xilinx.com,
        stefanos@xilinx.com, devicetree@vger.kernel.org, mdf@kernel.org,
        robh@kernel.org, Max Zhen <max.zhen@xilinx.com>
References: <20210218064019.29189-1-lizhih@xilinx.com>
 <20210218064019.29189-17-lizhih@xilinx.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <b77ea263-d368-25d8-409e-7cac2601a967@redhat.com>
Date:   Sat, 6 Mar 2021 07:34:48 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210218064019.29189-17-lizhih@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 2/17/21 10:40 PM, Lizhi Hou wrote:
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
calib is not descriptive, change filename to ddr_calibration
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
Initialize ?
> +	XRT_CALIB_SUCCEEDED,
> +	XRT_CALIB_FAILED,
> +};
> +
> +enum xrt_calib_ioctl_cmd {
> +	XRT_CALIB_RESULT = XRT_XLEAF_CUSTOM_BASE, /* See comments in xleaf.h */
> +};
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
No lock functions (i believe) should be prefixed with '__'
> +	mutex_unlock(&calib->lock);
> +}
> +
> +static int calib_srsr(struct calib *calib, struct platform_device *srsr_leaf)

what is srsr ?

Why a noop function ?

> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static int calib_calibration(struct calib *calib)
> +{
> +	int i;
> +
> +	for (i = 0; i < 20; i++) {

20 is a config parameter so should have a #define

There a couple of busy wait blocks in xrt/ some count up, some count down.

It would be good if they were consistent.

> +		if (CALIB_DONE(calib))
> +			break;
> +		msleep(500);

500 is another config

Tom

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


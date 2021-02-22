Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 598AF321F6C
	for <lists+linux-fpga@lfdr.de>; Mon, 22 Feb 2021 19:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbhBVSxP (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 22 Feb 2021 13:53:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20634 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231419AbhBVSwD (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 22 Feb 2021 13:52:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614019834;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GfUDGfi6ea7xF4viXCBTQQvX0/p+g7vjdBBK65j/VPA=;
        b=ULobO5LQsVpxGQz6PekQogVexvSXGtmPjvEHXLmVUHI7jhAARAPmc6TaZitCBZ3sys2CLm
        rUZC9ygxVL+Xfw7YyqETo3WNoLEL+WNmsH75RLfuQjGtbW/ymeHjOp26NNem9e29/5lHAB
        4eEZYvYXmj3f9fWGvGTsIo6d7JuHdlU=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-PfM1iV4PNy2lgQ77I-8CNg-1; Mon, 22 Feb 2021 13:50:33 -0500
X-MC-Unique: PfM1iV4PNy2lgQ77I-8CNg-1
Received: by mail-qv1-f70.google.com with SMTP id h10so8351025qvf.19
        for <linux-fpga@vger.kernel.org>; Mon, 22 Feb 2021 10:50:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=GfUDGfi6ea7xF4viXCBTQQvX0/p+g7vjdBBK65j/VPA=;
        b=dq0BEGvxAkRTXomGpKt7TLVmdpnsIOMCGEOjKuj2CP+RjnbNaHGMJLsLbyJUPVtjC1
         eLLRGudi84qPyVUX1Sc5VvY+t42HPm/KdoScHGPM0eLnS62XKEiLOR17ykp7z5puyqyd
         yZ4o633nwuguxwyGXBnU3QXStbZKFU6xJZdJEO+Sv+dA5sgJk07DJxO4xOmvG6IlrAGm
         fM9z30WS7MvKqRmvHnjMKEBJPJO5ixBYNCKtZ5IugWW8FE12Bi3BrjEJLrIqUQmy3P6i
         l3ATTfNcC1cCcgC9vvxBy3daFPYkGlJGwYJaImT2R4WyhrkhlLrTRqQqEsh+YnVKWUVU
         5k8g==
X-Gm-Message-State: AOAM530WArZr6WwV1xuzUNwvlPWmnb5v4aD2Cw7yR/TUMCiyuV8P90La
        ZSKK8Bj/nuoejQt1nwMl4NS/ni1OJeiici/AMNJAJMDB46DUV7c/kP55qn7TqPJnpDQ04epz2+H
        JGU8BUCgS1ee0aPChHpgqVA==
X-Received: by 2002:ad4:5894:: with SMTP id dz20mr14440221qvb.26.1614019832398;
        Mon, 22 Feb 2021 10:50:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwEzGiYdJnvdaOsdcpNFb0pt6R8goL7WirxetzekByYomC7ZgOJd9mVMcDW+paUosTpuxblbw==
X-Received: by 2002:ad4:5894:: with SMTP id dz20mr14440187qvb.26.1614019831970;
        Mon, 22 Feb 2021 10:50:31 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id f186sm1811264qkj.106.2021.02.22.10.50.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Feb 2021 10:50:31 -0800 (PST)
Subject: Re: [PATCH V3 XRT Alveo 05/18] fpga: xrt: group platform driver
To:     Lizhi Hou <lizhi.hou@xilinx.com>, linux-kernel@vger.kernel.org
Cc:     Lizhi Hou <lizhih@xilinx.com>, linux-fpga@vger.kernel.org,
        maxz@xilinx.com, sonal.santan@xilinx.com, michal.simek@xilinx.com,
        stefanos@xilinx.com, devicetree@vger.kernel.org, mdf@kernel.org,
        robh@kernel.org, Max Zhen <max.zhen@xilinx.com>
References: <20210218064019.29189-1-lizhih@xilinx.com>
 <20210218064019.29189-6-lizhih@xilinx.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <ebf64992-4067-18c2-661d-6c3a3b64c7c0@redhat.com>
Date:   Mon, 22 Feb 2021 10:50:29 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210218064019.29189-6-lizhih@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 2/17/21 10:40 PM, Lizhi Hou wrote:
> group driver that manages life cycle of a bunch of leaf driver instances
> and bridges them with root.
>
> Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
> Signed-off-by: Max Zhen <max.zhen@xilinx.com>
> Signed-off-by: Lizhi Hou <lizhih@xilinx.com>
> ---
>  drivers/fpga/xrt/include/group.h |  27 ++++
>  drivers/fpga/xrt/lib/group.c     | 265 +++++++++++++++++++++++++++++++
>  2 files changed, 292 insertions(+)
>  create mode 100644 drivers/fpga/xrt/include/group.h
>  create mode 100644 drivers/fpga/xrt/lib/group.c
>
> diff --git a/drivers/fpga/xrt/include/group.h b/drivers/fpga/xrt/include/group.h
> new file mode 100644
> index 000000000000..1874cdd5120d
> --- /dev/null
> +++ b/drivers/fpga/xrt/include/group.h
> @@ -0,0 +1,27 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Header file for Xilinx Runtime (XRT) driver
A bit too generic, please add a description or remove.
> + *
> + * Copyright (C) 2020-2021 Xilinx, Inc.
> + *
> + * Authors:
> + *	Cheng Zhen <maxz@xilinx.com>
> + */
> +
> +#ifndef _XRT_GROUP_H_
> +#define _XRT_GROUP_H_
> +
> +#include "xleaf.h"
This is patch 6, consider comments on patch 4.
> +
> +/*
> + * Group driver IOCTL calls.

Are these really ioctl calls?

Seems more like messages between nodes in a tree.

Consider changing to better jagon, maybe ioctl -> msg

> + */
> +enum xrt_group_ioctl_cmd {
> +	XRT_GROUP_GET_LEAF = XRT_XLEAF_CUSTOM_BASE, /* See comments in xleaf.h */
XRT_LEAF_CUSTOM_BASE is a #define, while these are enums. To be consistent, the XRT_LEAF_CUSTOM_BASE should be an enum in xleaf, you can initialize it to 64 there.
> +	XRT_GROUP_PUT_LEAF,
> +	XRT_GROUP_INIT_CHILDREN,
> +	XRT_GROUP_FINI_CHILDREN,
> +	XRT_GROUP_TRIGGER_EVENT,
> +};
> +
> +#endif	/* _XRT_GROUP_H_ */
> diff --git a/drivers/fpga/xrt/lib/group.c b/drivers/fpga/xrt/lib/group.c
> new file mode 100644
> index 000000000000..6ba56eea479b
> --- /dev/null
> +++ b/drivers/fpga/xrt/lib/group.c
> @@ -0,0 +1,265 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Xilinx Alveo FPGA Group Driver
> + *
> + * Copyright (C) 2020-2021 Xilinx, Inc.
> + *
> + * Authors:
> + *	Cheng Zhen <maxz@xilinx.com>
> + */
> +
> +#include <linux/mod_devicetable.h>
> +#include <linux/platform_device.h>
> +#include "xleaf.h"
> +#include "subdev_pool.h"
> +#include "group.h"
> +#include "metadata.h"
> +#include "main.h"
> +
> +#define XRT_GRP "xrt_group"
> +
> +struct xrt_group {
> +	struct platform_device *pdev;
> +	struct xrt_subdev_pool leaves;
> +	bool leaves_created;
> +	struct mutex lock; /* lock for group */
> +};
> +
> +static int xrt_grp_root_cb(struct device *dev, void *parg,
> +			   u32 cmd, void *arg)
could 'cmd' be some enum type ?
> +{
> +	int rc;
> +	struct platform_device *pdev =
> +		container_of(dev, struct platform_device, dev);
> +	struct xrt_group *xg = (struct xrt_group *)parg;
> +
> +	switch (cmd) {
> +	case XRT_ROOT_GET_LEAF_HOLDERS: {
> +		struct xrt_root_ioctl_get_holders *holders =
> +			(struct xrt_root_ioctl_get_holders *)arg;
> +		rc = xrt_subdev_pool_get_holders(&xg->leaves,
> +						 holders->xpigh_pdev,
> +						 holders->xpigh_holder_buf,
> +						 holders->xpigh_holder_buf_len);
> +		break;
> +	}
> +	default:
> +		/* Forward parent call to root. */
> +		rc = xrt_subdev_root_request(pdev, cmd, arg);
> +		break;
> +	}
> +
> +	return rc;
> +}
> +
> +static int xrt_grp_create_leaves(struct xrt_group *xg)
> +{
> +	struct xrt_subdev_platdata *pdata = DEV_PDATA(xg->pdev);
> +	enum xrt_subdev_id did;
> +	struct xrt_subdev_endpoints *eps = NULL;
> +	int ep_count = 0, i, ret = 0, failed = 0;
> +	unsigned long mlen;
> +	char *dtb, *grp_dtb = NULL;
> +	const char *ep_name;
> +
> +	mutex_lock(&xg->lock);
> +
> +	if (xg->leaves_created) {
> +		mutex_unlock(&xg->lock);
This happens should be programming error, so print out some error message
> +		return -EEXIST;
> +	}
> +
> +	xrt_info(xg->pdev, "bringing up leaves...");
> +
> +	/* Create all leaves based on dtb. */
> +	if (!pdata)
> +		goto bail;
move to above the lock and fail with something like -EINVAL
> +
> +	mlen = xrt_md_size(DEV(xg->pdev), pdata->xsp_dtb);
> +	if (mlen == XRT_MD_INVALID_LENGTH) {
> +		xrt_err(xg->pdev, "invalid dtb, len %ld", mlen);
> +		goto bail;
> +	}
> +
> +	grp_dtb = vmalloc(mlen);
> +	if (!grp_dtb)
> +		goto bail;
failed is only set in the loop. This is an unreported -ENOMEM
> +
> +	memcpy(grp_dtb, pdata->xsp_dtb, mlen);
> +	for (did = 0; did < XRT_SUBDEV_NUM;) {
why isn't the did incremented ?
> +		eps = eps ? eps + 1 : xrt_drv_get_endpoints(did);

this assumes the enpoints are in an array and accessed serially.

this is fragile.

convert to using just the xrt_drv_get_endpoints() call

> +		if (!eps || !eps->xse_names) {
> +			did++;
> +			eps = NULL;
> +			continue;
> +		}
> +		ret = xrt_md_create(DEV(xg->pdev), &dtb);
> +		if (ret) {
> +			xrt_err(xg->pdev, "create md failed, drv %s",
> +				xrt_drv_name(did));
> +			failed++;
failed but no cleanup of earier successes
> +			continue;
> +		}
> +		for (i = 0; eps->xse_names[i].ep_name ||

this assumes that xse_names[] always has a guard.

why not use xse_min_ep ?

> +		     eps->xse_names[i].regmap_name; i++) {
> +			ep_name = (char *)eps->xse_names[i].ep_name;
> +			if (!ep_name) {
> +				xrt_md_get_compatible_endpoint(DEV(xg->pdev),
> +							       grp_dtb,
> +							       eps->xse_names[i].regmap_name,
> +							       &ep_name);
> +			}
> +			if (!ep_name)
> +				continue;
> +
> +			ret = xrt_md_copy_endpoint(DEV(xg->pdev),
> +						   dtb, grp_dtb, ep_name,
> +						   (char *)eps->xse_names[i].regmap_name,
> +						   NULL);
> +			if (ret)
> +				continue;
> +			xrt_md_del_endpoint(DEV(xg->pdev), grp_dtb, ep_name,
> +					    (char *)eps->xse_names[i].regmap_name);
> +			ep_count++;
> +		}
> +		if (ep_count >= eps->xse_min_ep) {
This only happens if all additions are successful.
> +			ret = xrt_subdev_pool_add(&xg->leaves, did,
> +						  xrt_grp_root_cb, xg, dtb);
> +			eps = NULL;
> +			if (ret < 0) {
> +				failed++;
> +				xrt_err(xg->pdev, "failed to create %s: %d",
> +					xrt_drv_name(did), ret);
> +			}
> +		} else if (ep_count > 0) {
> +			xrt_md_copy_all_endpoints(DEV(xg->pdev), grp_dtb, dtb);
> +		}
> +		vfree(dtb);
> +		ep_count = 0;
> +	}
> +
> +	xg->leaves_created = true;
This is true even if some failed ?
> +
> +bail:
> +	vfree(grp_dtb);
> +	mutex_unlock(&xg->lock);
> +
> +	return failed == 0 ? 0 : -ECHILD;
> +}
> +
> +static void xrt_grp_remove_leaves(struct xrt_group *xg)
> +{
> +	mutex_lock(&xg->lock);
> +
> +	if (!xg->leaves_created) {
> +		mutex_unlock(&xg->lock);
> +		return;
> +	}
> +
> +	xrt_info(xg->pdev, "tearing down leaves...");
> +	xrt_subdev_pool_fini(&xg->leaves);
partial failure above and the subdev_pool is not created ?
> +	xg->leaves_created = false;
> +
> +	mutex_unlock(&xg->lock);
> +}
> +
> +static int xrt_grp_probe(struct platform_device *pdev)
> +{
> +	struct xrt_group *xg;
> +
> +	xrt_info(pdev, "probing...");
> +
> +	xg = devm_kzalloc(&pdev->dev, sizeof(*xg), GFP_KERNEL);
> +	if (!xg)
> +		return -ENOMEM;
> +
> +	xg->pdev = pdev;
> +	mutex_init(&xg->lock);
> +	xrt_subdev_pool_init(DEV(pdev), &xg->leaves);
> +	platform_set_drvdata(pdev, xg);
> +
> +	return 0;
> +}
> +
> +static int xrt_grp_remove(struct platform_device *pdev)
> +{
> +	struct xrt_group *xg = platform_get_drvdata(pdev);
> +
> +	xrt_info(pdev, "leaving...");
> +	xrt_grp_remove_leaves(xg);

lock ?

Tom

> +	return 0;
> +}
> +
> +static int xrt_grp_ioctl(struct platform_device *pdev, u32 cmd, void *arg)
> +{
> +	int rc = 0;
> +	struct xrt_group *xg = platform_get_drvdata(pdev);
> +
> +	switch (cmd) {
> +	case XRT_XLEAF_EVENT:
> +		/* Simply forward to every child. */
> +		xrt_subdev_pool_handle_event(&xg->leaves,
> +					     (struct xrt_event *)arg);
> +		break;
> +	case XRT_GROUP_GET_LEAF: {
> +		struct xrt_root_ioctl_get_leaf *get_leaf =
> +			(struct xrt_root_ioctl_get_leaf *)arg;
> +
> +		rc = xrt_subdev_pool_get(&xg->leaves, get_leaf->xpigl_match_cb,
> +					 get_leaf->xpigl_match_arg,
> +					 DEV(get_leaf->xpigl_pdev),
> +					 &get_leaf->xpigl_leaf);
> +		break;
> +	}
> +	case XRT_GROUP_PUT_LEAF: {
> +		struct xrt_root_ioctl_put_leaf *put_leaf =
> +			(struct xrt_root_ioctl_put_leaf *)arg;
> +
> +		rc = xrt_subdev_pool_put(&xg->leaves, put_leaf->xpipl_leaf,
> +					 DEV(put_leaf->xpipl_pdev));
> +		break;
> +	}
> +	case XRT_GROUP_INIT_CHILDREN:
> +		rc = xrt_grp_create_leaves(xg);
> +		break;
> +	case XRT_GROUP_FINI_CHILDREN:
> +		xrt_grp_remove_leaves(xg);
> +		break;
> +	case XRT_GROUP_TRIGGER_EVENT:
> +		xrt_subdev_pool_trigger_event(&xg->leaves, (enum xrt_events)(uintptr_t)arg);
> +		break;
> +	default:
> +		xrt_err(pdev, "unknown IOCTL cmd %d", cmd);
> +		rc = -EINVAL;
> +		break;
> +	}
> +	return rc;
> +}
> +
> +static struct xrt_subdev_drvdata xrt_grp_data = {
> +	.xsd_dev_ops = {
> +		.xsd_ioctl = xrt_grp_ioctl,
> +	},
> +};
> +
> +static const struct platform_device_id xrt_grp_id_table[] = {
> +	{ XRT_GRP, (kernel_ulong_t)&xrt_grp_data },
> +	{ },
> +};
> +
> +static struct platform_driver xrt_group_driver = {
> +	.driver	= {
> +		.name    = XRT_GRP,
> +	},
> +	.probe   = xrt_grp_probe,
> +	.remove  = xrt_grp_remove,
> +	.id_table = xrt_grp_id_table,
> +};
> +
> +void group_leaf_init_fini(bool init)
> +{
> +	if (init)
> +		xleaf_register_driver(XRT_SUBDEV_GRP, &xrt_group_driver, NULL);
> +	else
> +		xleaf_unregister_driver(XRT_SUBDEV_GRP);
> +}


Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 319B33715BE
	for <lists+linux-fpga@lfdr.de>; Mon,  3 May 2021 15:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233317AbhECNLH (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 3 May 2021 09:11:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34659 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234120AbhECNLG (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 3 May 2021 09:11:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620047413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VAP/ETS+jHrt/PTMFAJUTwy5IukB5/ESSQkZ50OVY7g=;
        b=WMUcWTm0BZn2gTfVHX0ty/UYp2IqVk5HDw9wjW42tOg2Po3QdErQvSzllp/eHFRWaJNccu
        jX9x13LdqKum9hkuCSV21+nyq/7CF/PEVlDwnfJkXGs83hf97f6PzK5gOUzxf7mofHuo9G
        WLcjh2uenHC36684aB4lT28xtSLWTSE=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-Uhm9uY7_NOS7qNq_H7toTw-1; Mon, 03 May 2021 09:10:09 -0400
X-MC-Unique: Uhm9uY7_NOS7qNq_H7toTw-1
Received: by mail-qk1-f197.google.com with SMTP id p133-20020a37428b0000b02902de31dd8da3so5070285qka.1
        for <linux-fpga@vger.kernel.org>; Mon, 03 May 2021 06:10:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=VAP/ETS+jHrt/PTMFAJUTwy5IukB5/ESSQkZ50OVY7g=;
        b=YL48DFAX/dWOcMP95LZP3vqXb6yqmrMf7bYAjPLmwIVILdPgppz1t/TkmXaOm3IsrI
         OVIgSeN24UupS8dvIv2I92030DFEns1/K346hy9Yjk5M13YZBCv0QV4ws4oJ1ezSKXAD
         G6Er1BHOq6c6m/DDpp2oEW29P1dCurpgj5Wmhvn9AHCDeFO/7XZtDG758SQG1GQUOwMC
         Q5sYPX7iAm7ky2Lxrnadx+5TeZ9kHWHOv9hnOJ61Ir9Qr3lty70O5ryVikZF1qUZXRht
         rm8VlSsdYF8RBBJE9+bcrbNLcIWD6Vibot+Xzafdj4dxg3eRMnX1OJR/AJYImlqSXFWe
         eiXw==
X-Gm-Message-State: AOAM533EUX1iAovrpsPZKYhd3OYDDhLQCJWLmZtTDsctwOhWT+3/31OS
        2LGS98mfR8+cZFO4QFNM6u2AE8x0vUWIpRMpQ5poux+ozGkYaxpQUr2a8gxDRgo3GKXRhuke50Z
        lwpmcuDZ/Bv7pg9qgZAoDNw==
X-Received: by 2002:a05:622a:253:: with SMTP id c19mr17266163qtx.53.1620047409183;
        Mon, 03 May 2021 06:10:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz2ytiiTKcC6r1Fv+xrymYnJ0tXIhsA4HHhZ8ypa81ar8SbjLm8OlQokC+IcdyTUZM3RYAR9Q==
X-Received: by 2002:a05:622a:253:: with SMTP id c19mr17266133qtx.53.1620047408846;
        Mon, 03 May 2021 06:10:08 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id w7sm1834762qtn.91.2021.05.03.06.10.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 May 2021 06:10:08 -0700 (PDT)
Subject: Re: [PATCH V5 XRT Alveo 05/20] fpga: xrt: group driver
To:     Lizhi Hou <lizhi.hou@xilinx.com>, linux-kernel@vger.kernel.org
Cc:     linux-fpga@vger.kernel.org, maxz@xilinx.com,
        sonal.santan@xilinx.com, yliu@xilinx.com, michal.simek@xilinx.com,
        stefanos@xilinx.com, devicetree@vger.kernel.org, mdf@kernel.org,
        robh@kernel.org, Max Zhen <max.zhen@xilinx.com>
References: <20210427205431.23896-1-lizhi.hou@xilinx.com>
 <20210427205431.23896-6-lizhi.hou@xilinx.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <0af9a4ad-5216-05a3-2db5-60f879296baa@redhat.com>
Date:   Mon, 3 May 2021 06:10:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210427205431.23896-6-lizhi.hou@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 4/27/21 1:54 PM, Lizhi Hou wrote:
> group driver that manages life cycle of a bunch of leaf driver instances
> and bridges them with root.
>
> Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
> Signed-off-by: Max Zhen <max.zhen@xilinx.com>
> Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
> ---
>   drivers/fpga/xrt/include/group.h |  25 +++
>   drivers/fpga/xrt/lib/group.c     | 278 +++++++++++++++++++++++++++++++
>   2 files changed, 303 insertions(+)
>   create mode 100644 drivers/fpga/xrt/include/group.h
>   create mode 100644 drivers/fpga/xrt/lib/group.c
>
> diff --git a/drivers/fpga/xrt/include/group.h b/drivers/fpga/xrt/include/group.h
> new file mode 100644
> index 000000000000..09e9d03f53fe
> --- /dev/null
> +++ b/drivers/fpga/xrt/include/group.h
> @@ -0,0 +1,25 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
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
> +
> +/*
> + * Group driver leaf calls.
> + */
> +enum xrt_group_leaf_cmd {
> +	XRT_GROUP_GET_LEAF = XRT_XLEAF_CUSTOM_BASE, /* See comments in xleaf.h */
> +	XRT_GROUP_PUT_LEAF,
> +	XRT_GROUP_INIT_CHILDREN,
> +	XRT_GROUP_FINI_CHILDREN,
> +	XRT_GROUP_TRIGGER_EVENT,
> +};
> +
> +#endif	/* _XRT_GROUP_H_ */
> diff --git a/drivers/fpga/xrt/lib/group.c b/drivers/fpga/xrt/lib/group.c
> new file mode 100644
> index 000000000000..b45f05449e0b
> --- /dev/null
> +++ b/drivers/fpga/xrt/lib/group.c
> @@ -0,0 +1,278 @@
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
> +#include "xleaf.h"
> +#include "subdev_pool.h"
> +#include "group.h"
> +#include "metadata.h"
> +#include "lib-drv.h"
> +
> +#define XRT_GRP "xrt_group"
> +
> +struct xrt_group {
> +	struct xrt_device *xdev;
> +	struct xrt_subdev_pool leaves;
> +	bool leaves_created;
> +	struct mutex lock; /* lock for group */
> +};
> +
> +static int xrt_grp_root_cb(struct device *dev, void *parg,
> +			   enum xrt_root_cmd cmd, void *arg)
> +{
> +	int rc;
> +	struct xrt_device *xdev =
> +		container_of(dev, struct xrt_device, dev);
> +	struct xrt_group *xg = (struct xrt_group *)parg;
> +
> +	switch (cmd) {
> +	case XRT_ROOT_GET_LEAF_HOLDERS: {
> +		struct xrt_root_get_holders *holders =
> +			(struct xrt_root_get_holders *)arg;
> +		rc = xrt_subdev_pool_get_holders(&xg->leaves,
> +						 holders->xpigh_xdev,
> +						 holders->xpigh_holder_buf,
> +						 holders->xpigh_holder_buf_len);
> +		break;
> +	}
> +	default:
> +		/* Forward parent call to root. */
> +		rc = xrt_subdev_root_request(xdev, cmd, arg);
> +		break;
> +	}
> +
> +	return rc;
> +}
> +
> +/*
> + * Cut subdev's dtb from group's dtb based on passed-in endpoint descriptor.
> + * Return the subdev's dtb through dtbp, if found.
> + */
> +static int xrt_grp_cut_subdev_dtb(struct xrt_group *xg, struct xrt_dev_endpoints *eps,
> +				  char *grp_dtb, char **dtbp)
> +{
> +	int ret, i, ep_count = 0;
> +	char *dtb = NULL;
> +
> +	ret = xrt_md_create(DEV(xg->xdev), &dtb);
> +	if (ret)
> +		return ret;
> +
> +	for (i = 0; eps->xse_names[i].ep_name || eps->xse_names[i].compat; i++) {
> +		const char *ep_name = eps->xse_names[i].ep_name;
> +		const char *compat = eps->xse_names[i].compat;
> +
> +		if (!ep_name)
> +			xrt_md_get_compatible_endpoint(DEV(xg->xdev), grp_dtb, compat, &ep_name);
> +		if (!ep_name)
> +			continue;
> +
> +		ret = xrt_md_copy_endpoint(DEV(xg->xdev), dtb, grp_dtb, ep_name, compat, NULL);
> +		if (ret)
> +			continue;
> +		xrt_md_del_endpoint(DEV(xg->xdev), grp_dtb, ep_name, compat);
> +		ep_count++;
> +	}
> +	/* Found enough endpoints, return the subdev's dtb. */
> +	if (ep_count >= eps->xse_min_ep) {
> +		*dtbp = dtb;
> +		return 0;
> +	}
> +
> +	/* Cleanup - Restore all endpoints that has been deleted, if any. */
> +	if (ep_count > 0) {
> +		xrt_md_copy_endpoint(DEV(xg->xdev), grp_dtb, dtb,
> +				     XRT_MD_NODE_ENDPOINTS, NULL, NULL);
> +	}
> +	vfree(dtb);
> +	*dtbp = NULL;
> +	return 0;
> +}
> +
> +static int xrt_grp_create_leaves(struct xrt_group *xg)
> +{
> +	struct xrt_subdev_platdata *pdata = DEV_PDATA(xg->xdev);
> +	struct xrt_dev_endpoints *eps = NULL;
> +	int ret = 0, failed = 0;
> +	enum xrt_subdev_id did;
> +	char *grp_dtb = NULL;
> +	unsigned long mlen;
> +
> +	if (!pdata)
> +		return -EINVAL;
> +
> +	mlen = xrt_md_size(DEV(xg->xdev), pdata->xsp_dtb);
> +	if (mlen == XRT_MD_INVALID_LENGTH) {
> +		xrt_err(xg->xdev, "invalid dtb, len %ld", mlen);
> +		return -EINVAL;
> +	}
> +
> +	mutex_lock(&xg->lock);
> +
> +	if (xg->leaves_created) {
> +		/*
> +		 * This is expected since caller does not keep track of the state of the group
> +		 * and may, in some cases, still try to create leaves after it has already been
> +		 * created. This special error code will let the caller know what is going on.
> +		 */

ok

Reviewed-by: Tom Rix <trix@redhat.com>

> +		mutex_unlock(&xg->lock);
> +		return -EEXIST;
> +	}
> +
> +	grp_dtb = vmalloc(mlen);
> +	if (!grp_dtb) {
> +		mutex_unlock(&xg->lock);
> +		return -ENOMEM;
> +	}
> +
> +	/* Create all leaves based on dtb. */
> +	xrt_info(xg->xdev, "bringing up leaves...");
> +	memcpy(grp_dtb, pdata->xsp_dtb, mlen);
> +	for (did = 0; did < XRT_SUBDEV_NUM; did++) {
> +		eps = xrt_drv_get_endpoints(did);
> +		while (eps && eps->xse_names) {
> +			char *dtb = NULL;
> +
> +			ret = xrt_grp_cut_subdev_dtb(xg, eps, grp_dtb, &dtb);
> +			if (ret) {
> +				failed++;
> +				xrt_err(xg->xdev, "failed to cut subdev dtb for drv %s: %d",
> +					xrt_drv_name(did), ret);
> +			}
> +			if (!dtb) {
> +				/*
> +				 * No more dtb to cut or bad things happened for this instance,
> +				 * switch to the next one.
> +				 */
> +				eps++;
> +				continue;
> +			}
> +
> +			/* Found a dtb for this instance, let's add it. */
> +			ret = xrt_subdev_pool_add(&xg->leaves, did, xrt_grp_root_cb, xg, dtb);
> +			if (ret < 0) {
> +				/*
> +				 * It is not a fatal error here. Some functionality is not usable
> +				 * due to this missing device, but the error can be handled
> +				 * when the functionality is used.
ok
> +				 */
> +				failed++;
> +				xrt_err(xg->xdev, "failed to add %s: %d", xrt_drv_name(did), ret);
> +			}
> +			vfree(dtb);
> +			/* Continue searching for the same instance from grp_dtb. */
> +		}
> +	}
> +
> +	xg->leaves_created = true;
> +	vfree(grp_dtb);
> +	mutex_unlock(&xg->lock);
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
> +	xrt_info(xg->xdev, "tearing down leaves...");
> +	xrt_subdev_pool_fini(&xg->leaves);
> +	xg->leaves_created = false;
> +
> +	mutex_unlock(&xg->lock);
> +}
> +
> +static int xrt_grp_probe(struct xrt_device *xdev)
> +{
> +	struct xrt_group *xg;
> +
> +	xrt_info(xdev, "probing...");
> +
> +	xg = devm_kzalloc(&xdev->dev, sizeof(*xg), GFP_KERNEL);
> +	if (!xg)
> +		return -ENOMEM;
> +
> +	xg->xdev = xdev;
> +	mutex_init(&xg->lock);
> +	xrt_subdev_pool_init(DEV(xdev), &xg->leaves);
> +	xrt_set_drvdata(xdev, xg);
> +
> +	return 0;
> +}
> +
> +static void xrt_grp_remove(struct xrt_device *xdev)
> +{
> +	struct xrt_group *xg = xrt_get_drvdata(xdev);
> +
> +	xrt_info(xdev, "leaving...");
> +	xrt_grp_remove_leaves(xg);
> +}
> +
> +static int xrt_grp_leaf_call(struct xrt_device *xdev, u32 cmd, void *arg)
> +{
> +	int rc = 0;
> +	struct xrt_group *xg = xrt_get_drvdata(xdev);
> +
> +	switch (cmd) {
> +	case XRT_XLEAF_EVENT:
> +		/* Simply forward to every child. */
> +		xrt_subdev_pool_handle_event(&xg->leaves,
> +					     (struct xrt_event *)arg);
> +		break;
> +	case XRT_GROUP_GET_LEAF: {
> +		struct xrt_root_get_leaf *get_leaf =
> +			(struct xrt_root_get_leaf *)arg;
> +
> +		rc = xrt_subdev_pool_get(&xg->leaves, get_leaf->xpigl_match_cb,
> +					 get_leaf->xpigl_match_arg,
> +					 DEV(get_leaf->xpigl_caller_xdev),
> +					 &get_leaf->xpigl_tgt_xdev);
> +		break;
> +	}
> +	case XRT_GROUP_PUT_LEAF: {
> +		struct xrt_root_put_leaf *put_leaf =
> +			(struct xrt_root_put_leaf *)arg;
> +
> +		rc = xrt_subdev_pool_put(&xg->leaves, put_leaf->xpipl_tgt_xdev,
> +					 DEV(put_leaf->xpipl_caller_xdev));
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
> +		xrt_err(xdev, "unknown IOCTL cmd %d", cmd);
> +		rc = -EINVAL;
> +		break;
> +	}
> +	return rc;
> +}
> +
> +static struct xrt_driver xrt_group_driver = {
> +	.driver	= {
> +		.name    = XRT_GRP,
> +	},
> +	.subdev_id = XRT_SUBDEV_GRP,
> +	.probe = xrt_grp_probe,
> +	.remove = xrt_grp_remove,
> +	.leaf_call = xrt_grp_leaf_call,
> +};
> +
> +XRT_LEAF_INIT_FINI_FUNC(group);


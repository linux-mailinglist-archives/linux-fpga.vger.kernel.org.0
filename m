Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39B3532ABD7
	for <lists+linux-fpga@lfdr.de>; Tue,  2 Mar 2021 21:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241744AbhCBUo6 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 2 Mar 2021 15:44:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42057 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1449114AbhCBQPw (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 2 Mar 2021 11:15:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614701604;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xj617NCTkcQlVOBgs3nUDfsN/jKMhqs1NUx4EljorXw=;
        b=NUTsKroQDTIqYViB7/mlLw0+TkfnK9Glf9jYubjcrM9Vb1ExYr3uHjTHey8CGZywB2VqZ8
        7Bmd6XqbOauXIR1t7tJCjERiXzaUhMDcqYUSefsswLXzriTc2f0zRZBuVs0nFuyOIwBRhi
        pwAcz9gdqK3cg/z1J34d7bWisko2aa8=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-UgVf-WfLOymNEDljAaSwRQ-1; Tue, 02 Mar 2021 11:09:11 -0500
X-MC-Unique: UgVf-WfLOymNEDljAaSwRQ-1
Received: by mail-qt1-f199.google.com with SMTP id w33so4578040qte.11
        for <linux-fpga@vger.kernel.org>; Tue, 02 Mar 2021 08:09:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Xj617NCTkcQlVOBgs3nUDfsN/jKMhqs1NUx4EljorXw=;
        b=Xz1Un8m3XWJ8nZ97gUTUWZC0WSmArlGpoHYzXl5/Hi5RpgFtTLrzZ5cKhjC+w+rBSx
         1PlEFEb7QyB6Ktr3hsuzUOSAvBXm2B+bWBp7AJKQPGGhwnWwGVtgjyxsW3YMtiq7/Kwf
         LEB6YNkOMigUnQ11Dd04nCD0BRykgPSo3AsUm5Gv6P0Cm5IroKYM+sa8IhsAxnCoHS3a
         fJiNJG+xywKr5nQ8BcS3p0wIjdbSrDvUEiBoGqE7hEIycBnsSRG62abv9dyUjU56K3z/
         rNLfoEpEwLB9nqV3KfXx/CAildfqwKWCNbnfkSf3CObi4pHbpuWosW+O7KhatGvEoxLs
         e/iw==
X-Gm-Message-State: AOAM531Is8Zmma4/pA+g3tzxCbCcvAeG4evbnM7WvIm1eVZwKN4DnFIM
        X6RuJo0WHsTQ+Zh+NOM57k6qne4GBJ6nwqMYJYbWgAWY7vhBDgqL4K0RILKzUDtNBLKKPPcJVxN
        L13NRvorPfLtGSVhi2kWVHg==
X-Received: by 2002:a05:622a:254:: with SMTP id c20mr19101080qtx.387.1614701350177;
        Tue, 02 Mar 2021 08:09:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxPgp9285reKXXR5zjKwXh6Fk/hEiFPTHqxCo3e1OBX7LNY5TcUk/WK9fFTfyQiSgC4mCBgVw==
X-Received: by 2002:a05:622a:254:: with SMTP id c20mr19101057qtx.387.1614701349880;
        Tue, 02 Mar 2021 08:09:09 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 79sm401850qki.37.2021.03.02.08.09.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Mar 2021 08:09:09 -0800 (PST)
Subject: Re: [PATCH V3 XRT Alveo 11/18] fpga: xrt: UCS platform driver
To:     Lizhi Hou <lizhi.hou@xilinx.com>, linux-kernel@vger.kernel.org
Cc:     Lizhi Hou <lizhih@xilinx.com>, linux-fpga@vger.kernel.org,
        maxz@xilinx.com, sonal.santan@xilinx.com, michal.simek@xilinx.com,
        stefanos@xilinx.com, devicetree@vger.kernel.org, mdf@kernel.org,
        robh@kernel.org, Max Zhen <max.zhen@xilinx.com>
References: <20210218064019.29189-1-lizhih@xilinx.com>
 <20210218064019.29189-12-lizhih@xilinx.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <3e4edfaa-e90d-1889-cd05-41107e730c18@redhat.com>
Date:   Tue, 2 Mar 2021 08:09:07 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210218064019.29189-12-lizhih@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 2/17/21 10:40 PM, Lizhi Hou wrote:
> Add UCS driver. UCS is a hardware function discovered by walking xclbin
What does UCS stand for ? add to commit log
> metadata. A platform device node will be created for it.
> UCS enables/disables the dynamic region clocks.
>
> Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
> Signed-off-by: Max Zhen <max.zhen@xilinx.com>
> Signed-off-by: Lizhi Hou <lizhih@xilinx.com>
> ---
>  drivers/fpga/xrt/include/xleaf/ucs.h |  24 +++
>  drivers/fpga/xrt/lib/xleaf/ucs.c     | 235 +++++++++++++++++++++++++++
>  2 files changed, 259 insertions(+)
>  create mode 100644 drivers/fpga/xrt/include/xleaf/ucs.h
>  create mode 100644 drivers/fpga/xrt/lib/xleaf/ucs.c
>
> diff --git a/drivers/fpga/xrt/include/xleaf/ucs.h b/drivers/fpga/xrt/include/xleaf/ucs.h
> new file mode 100644
> index 000000000000..a5ef0e100e12
> --- /dev/null
> +++ b/drivers/fpga/xrt/include/xleaf/ucs.h

This header is only used by ucs.c, so is it needed ?

could the enum be defined in ucs.c ?

> @@ -0,0 +1,24 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Header file for XRT UCS Leaf Driver
> + *
> + * Copyright (C) 2020-2021 Xilinx, Inc.
> + *
> + * Authors:
> + *	Lizhi Hou <Lizhi.Hou@xilinx.com>
> + */
> +
> +#ifndef _XRT_UCS_H_
> +#define _XRT_UCS_H_
> +
> +#include "xleaf.h"
> +
> +/*
> + * UCS driver IOCTL calls.
> + */
> +enum xrt_ucs_ioctl_cmd {
> +	XRT_UCS_CHECK = XRT_XLEAF_CUSTOM_BASE, /* See comments in xleaf.h */
> +	XRT_UCS_ENABLE,
no disable ?
> +};
> +
> +#endif	/* _XRT_UCS_H_ */
> diff --git a/drivers/fpga/xrt/lib/xleaf/ucs.c b/drivers/fpga/xrt/lib/xleaf/ucs.c
> new file mode 100644
> index 000000000000..ae762c8fddbb
> --- /dev/null
> +++ b/drivers/fpga/xrt/lib/xleaf/ucs.c
> @@ -0,0 +1,235 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Xilinx Alveo FPGA UCS Driver
> + *
> + * Copyright (C) 2020-2021 Xilinx, Inc.
> + *
> + * Authors:
> + *      Lizhi Hou<Lizhi.Hou@xilinx.com>
> + */
> +
> +#include <linux/mod_devicetable.h>
> +#include <linux/platform_device.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/io.h>
> +#include "metadata.h"
> +#include "xleaf.h"
> +#include "xleaf/ucs.h"
> +#include "xleaf/clock.h"
> +
> +#define UCS_ERR(ucs, fmt, arg...)   \
> +	xrt_err((ucs)->pdev, fmt "\n", ##arg)
> +#define UCS_WARN(ucs, fmt, arg...)  \
> +	xrt_warn((ucs)->pdev, fmt "\n", ##arg)
> +#define UCS_INFO(ucs, fmt, arg...)  \
> +	xrt_info((ucs)->pdev, fmt "\n", ##arg)
> +#define UCS_DBG(ucs, fmt, arg...)   \
> +	xrt_dbg((ucs)->pdev, fmt "\n", ##arg)
> +
> +#define XRT_UCS		"xrt_ucs"
> +
> +#define CHANNEL1_OFFSET			0
> +#define CHANNEL2_OFFSET			8
> +
> +#define CLK_MAX_VALUE			6400
> +
> +struct ucs_control_status_ch1 {
> +	unsigned int shutdown_clocks_latched:1;
> +	unsigned int reserved1:15;
> +	unsigned int clock_throttling_average:14;
> +	unsigned int reserved2:2;
> +};
Likely needs to be packed and/or the unsigned int changed to u32
> +
> +struct xrt_ucs {
> +	struct platform_device	*pdev;
> +	void __iomem		*ucs_base;
> +	struct mutex		ucs_lock; /* ucs dev lock */
> +};
> +
> +static inline u32 reg_rd(struct xrt_ucs *ucs, u32 offset)
> +{
> +	return ioread32(ucs->ucs_base + offset);
> +}
> +
> +static inline void reg_wr(struct xrt_ucs *ucs, u32 val, u32 offset)
> +{
> +	iowrite32(val, ucs->ucs_base + offset);
> +}
> +
> +static void xrt_ucs_event_cb(struct platform_device *pdev, void *arg)
> +{
> +	struct platform_device	*leaf;
> +	struct xrt_event *evt = (struct xrt_event *)arg;
> +	enum xrt_events e = evt->xe_evt;
> +	enum xrt_subdev_id id = evt->xe_subdev.xevt_subdev_id;
> +	int instance = evt->xe_subdev.xevt_subdev_instance;
> +
> +	switch (e) {
> +	case XRT_EVENT_POST_CREATION:
> +		break;
> +	default:
> +		xrt_dbg(pdev, "ignored event %d", e);
> +		return;
> +	}
this switch is a noop, remove
> +
> +	if (id != XRT_SUBDEV_CLOCK)
> +		return;
> +
> +	leaf = xleaf_get_leaf_by_id(pdev, XRT_SUBDEV_CLOCK, instance);
> +	if (!leaf) {
> +		xrt_err(pdev, "does not get clock subdev");
> +		return;
> +	}
> +
> +	xleaf_ioctl(leaf, XRT_CLOCK_VERIFY, NULL);
> +	xleaf_put_leaf(pdev, leaf);
> +}
> +
> +static void ucs_check(struct xrt_ucs *ucs, bool *latched)
> +{

checking but not returning status, change to returning int.

this function is called but xrt_ucs_leaf_ioctl which does return status.

> +	struct ucs_control_status_ch1 *ucs_status_ch1;
> +	u32 status;
> +
> +	mutex_lock(&ucs->ucs_lock);
> +	status = reg_rd(ucs, CHANNEL1_OFFSET);
> +	ucs_status_ch1 = (struct ucs_control_status_ch1 *)&status;
> +	if (ucs_status_ch1->shutdown_clocks_latched) {
> +		UCS_ERR(ucs,
> +			"Critical temperature or power event, kernel clocks have been stopped.");
> +		UCS_ERR(ucs,
> +			"run 'xbutil valiate -q' to continue. See AR 73398 for more details.");
This error message does not seem like it would be useful, please review.
> +		/* explicitly indicate reset should be latched */
> +		*latched = true;
> +	} else if (ucs_status_ch1->clock_throttling_average >
> +	    CLK_MAX_VALUE) {
> +		UCS_ERR(ucs, "kernel clocks %d exceeds expected maximum value %d.",
> +			ucs_status_ch1->clock_throttling_average,
> +			CLK_MAX_VALUE);
> +	} else if (ucs_status_ch1->clock_throttling_average) {
> +		UCS_ERR(ucs, "kernel clocks throttled at %d%%.",
> +			(ucs_status_ch1->clock_throttling_average /
> +			 (CLK_MAX_VALUE / 100)));
> +	}
> +	mutex_unlock(&ucs->ucs_lock);
> +}
> +
> +static void ucs_enable(struct xrt_ucs *ucs)
> +{
> +	reg_wr(ucs, 1, CHANNEL2_OFFSET);
lock ?
> +}
> +
> +static int
> +xrt_ucs_leaf_ioctl(struct platform_device *pdev, u32 cmd, void *arg)
> +{
> +	struct xrt_ucs		*ucs;
> +	int			ret = 0;
> +
> +	ucs = platform_get_drvdata(pdev);
> +
> +	switch (cmd) {
> +	case XRT_XLEAF_EVENT:
> +		xrt_ucs_event_cb(pdev, arg);
> +		break;
> +	case XRT_UCS_CHECK: {
brace not needed here
> +		ucs_check(ucs, (bool *)arg);
> +		break;
> +	}
> +	case XRT_UCS_ENABLE:
> +		ucs_enable(ucs);
> +		break;
> +	default:
> +		xrt_err(pdev, "unsupported cmd %d", cmd);
> +		return -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +static int ucs_remove(struct platform_device *pdev)
> +{
> +	struct xrt_ucs *ucs;
> +
> +	ucs = platform_get_drvdata(pdev);
> +	if (!ucs) {

is this possible ?

Tom

> +		xrt_err(pdev, "driver data is NULL");
> +		return -EINVAL;
> +	}
> +
> +	if (ucs->ucs_base)
> +		iounmap(ucs->ucs_base);
> +
> +	platform_set_drvdata(pdev, NULL);
> +	devm_kfree(&pdev->dev, ucs);
> +
> +	return 0;
> +}
> +
> +static int ucs_probe(struct platform_device *pdev)
> +{
> +	struct xrt_ucs *ucs = NULL;
> +	struct resource *res;
> +	int ret;
> +
> +	ucs = devm_kzalloc(&pdev->dev, sizeof(*ucs), GFP_KERNEL);
> +	if (!ucs)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, ucs);
> +	ucs->pdev = pdev;
> +	mutex_init(&ucs->ucs_lock);
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	ucs->ucs_base = ioremap(res->start, res->end - res->start + 1);
> +	if (!ucs->ucs_base) {
> +		UCS_ERR(ucs, "map base %pR failed", res);
> +		ret = -EFAULT;
> +		goto failed;
> +	}
> +	ucs_enable(ucs);
> +
> +	return 0;
> +
> +failed:
> +	ucs_remove(pdev);
> +	return ret;
> +}
> +
> +static struct xrt_subdev_endpoints xrt_ucs_endpoints[] = {
> +	{
> +		.xse_names = (struct xrt_subdev_ep_names[]) {
> +			{ .ep_name = XRT_MD_NODE_UCS_CONTROL_STATUS },
> +			{ NULL },
> +		},
> +		.xse_min_ep = 1,
> +	},
> +	{ 0 },
> +};
> +
> +static struct xrt_subdev_drvdata xrt_ucs_data = {
> +	.xsd_dev_ops = {
> +		.xsd_ioctl = xrt_ucs_leaf_ioctl,
> +	},
> +};
> +
> +static const struct platform_device_id xrt_ucs_table[] = {
> +	{ XRT_UCS, (kernel_ulong_t)&xrt_ucs_data },
> +	{ },
> +};
> +
> +static struct platform_driver xrt_ucs_driver = {
> +	.driver = {
> +		.name = XRT_UCS,
> +	},
> +	.probe = ucs_probe,
> +	.remove = ucs_remove,
> +	.id_table = xrt_ucs_table,
> +};
> +
> +void ucs_leaf_init_fini(bool init)
> +{
> +	if (init)
> +		xleaf_register_driver(XRT_SUBDEV_UCS, &xrt_ucs_driver, xrt_ucs_endpoints);
> +	else
> +		xleaf_unregister_driver(XRT_SUBDEV_UCS);
> +}


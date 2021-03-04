Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD16132D45D
	for <lists+linux-fpga@lfdr.de>; Thu,  4 Mar 2021 14:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241409AbhCDNlj (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 4 Mar 2021 08:41:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58278 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241427AbhCDNlQ (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 4 Mar 2021 08:41:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614865191;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ekOwjBVLyvG/SdJJ95XbcF+3uVLr94jDQEL8woMHUvs=;
        b=ZTgxdJTdlUu5B1uRlyw7MhEUwndAqq2N3iV+rJmcNo/wp8Vh7xPdqLlpZY950v1MZUwgDA
        vImvcOu0U7mxIAvrf2VZmD/AHTYFdrK05z5G5COTvP8V/T4y1BZPP7Ck6sRJ4AGv6O7ojT
        gA+Qmf9ZLfQ70SQL4Y4o14N6+NnZtVM=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-10-MU0YapP4NZWS2-sw5qTrTg-1; Thu, 04 Mar 2021 08:39:50 -0500
X-MC-Unique: MU0YapP4NZWS2-sw5qTrTg-1
Received: by mail-qk1-f197.google.com with SMTP id h134so9601639qke.1
        for <linux-fpga@vger.kernel.org>; Thu, 04 Mar 2021 05:39:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ekOwjBVLyvG/SdJJ95XbcF+3uVLr94jDQEL8woMHUvs=;
        b=hQ9A8xe97nmo/jzYgcnobWISFKfkpZHQiALL8LSpirf1tuZX0MvXxk42cukYUQRyts
         6OPl3T/KfqYfVW2s3V3VZ1Tuyv13fdPxdG1z+gKR8KfoTj3IUk2sM8ZheTFM/ctKbeyl
         bfN6u6m+MJA1pjIHNqv8IQofjEvAOY8tRmeXwm83qemvorvuQjsxTgM45+x13kE7KFv7
         iznkIqEnjtcBkOhzTP6Qr2QIRPeMjnGm1tziB/nQlbd69undpFi6Q6zp8B+SGt4rgmLq
         ptk8fSdSBuuVmSyorsTXlgdil6vKhh8WK984k1SmOIM0EQGj/sq6uhn8CivWVGtaXm/8
         kcsQ==
X-Gm-Message-State: AOAM533n5ZnqV5pnN8d2nZAPrIztJa1rQS0eXYawqLhv62rTRlCl39OF
        Gj39Mq0S5IeSFJRtkO1GBD3Kkp49v59IDjvt6rPvZIvwo9UGqoWCg2ZuNKrnrzG700b0uxRtOyW
        sQLA03lwal0DEZTb97gjNSg==
X-Received: by 2002:a37:5243:: with SMTP id g64mr3889261qkb.376.1614865189434;
        Thu, 04 Mar 2021 05:39:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz39ia44Xjc22E0lCMnwd++aFVAU2PmF9Dow8C0dnza9IdHZCG92M9XqC1aKWAXeZ+WRWNlKA==
X-Received: by 2002:a37:5243:: with SMTP id g64mr3889235qkb.376.1614865189156;
        Thu, 04 Mar 2021 05:39:49 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id b22sm6464402qkk.45.2021.03.04.05.39.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Mar 2021 05:39:48 -0800 (PST)
Subject: Re: [PATCH V3 XRT Alveo 13/18] fpga: xrt: devctl platform driver
To:     Lizhi Hou <lizhi.hou@xilinx.com>, linux-kernel@vger.kernel.org
Cc:     Lizhi Hou <lizhih@xilinx.com>, linux-fpga@vger.kernel.org,
        maxz@xilinx.com, sonal.santan@xilinx.com, michal.simek@xilinx.com,
        stefanos@xilinx.com, devicetree@vger.kernel.org, mdf@kernel.org,
        robh@kernel.org, Max Zhen <max.zhen@xilinx.com>
References: <20210218064019.29189-1-lizhih@xilinx.com>
 <20210218064019.29189-14-lizhih@xilinx.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <f32d06bc-1054-eb97-cce1-9b40e9c4442b@redhat.com>
Date:   Thu, 4 Mar 2021 05:39:46 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210218064019.29189-14-lizhih@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 2/17/21 10:40 PM, Lizhi Hou wrote:
> Add devctl driver. devctl is a type of hardware function which only has
> few registers to read or write. They are discovered by walking firmware
> metadata. A platform device node will be created for them.
>
> Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
> Signed-off-by: Max Zhen <max.zhen@xilinx.com>
> Signed-off-by: Lizhi Hou <lizhih@xilinx.com>
> ---
>  drivers/fpga/xrt/include/xleaf/devctl.h |  43 +++++
>  drivers/fpga/xrt/lib/xleaf/devctl.c     | 206 ++++++++++++++++++++++++
>  2 files changed, 249 insertions(+)
>  create mode 100644 drivers/fpga/xrt/include/xleaf/devctl.h
>  create mode 100644 drivers/fpga/xrt/lib/xleaf/devctl.c
>
> diff --git a/drivers/fpga/xrt/include/xleaf/devctl.h b/drivers/fpga/xrt/include/xleaf/devctl.h
> new file mode 100644
> index 000000000000..96a40e066f83
> --- /dev/null
> +++ b/drivers/fpga/xrt/include/xleaf/devctl.h
> @@ -0,0 +1,43 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Header file for XRT DEVCTL Leaf Driver
> + *
> + * Copyright (C) 2020-2021 Xilinx, Inc.
> + *
> + * Authors:
> + *	Lizhi Hou <Lizhi.Hou@xilinx.com>
> + */
> +
> +#ifndef _XRT_DEVCTL_H_
> +#define _XRT_DEVCTL_H_
> +
> +#include "xleaf.h"
> +
> +/*
> + * DEVCTL driver IOCTL calls.
> + */
> +enum xrt_devctl_ioctl_cmd {
> +	XRT_DEVCTL_READ = XRT_XLEAF_CUSTOM_BASE, /* See comments in xleaf.h */
> +	XRT_DEVCTL_WRITE,
> +};
> +
> +enum xrt_devctl_id {
> +	XRT_DEVCTL_ROM_UUID,
Assumes 0, should make this explicit and initialize to 0
> +	XRT_DEVCTL_DDR_CALIB,
> +	XRT_DEVCTL_GOLDEN_VER,
> +	XRT_DEVCTL_MAX
> +};
> +
> +struct xrt_devctl_ioctl_rw {
> +	u32	xgir_id;
> +	void	*xgir_buf;
> +	u32	xgir_len;
> +	u32	xgir_offset;
similar to other patches, the xgir_ prefix is not needed
> +};
> +
> +struct xrt_devctl_ioctl_intf_uuid {
> +	u32	xgir_uuid_num;
> +	uuid_t	*xgir_uuids;
> +};
> +
> +#endif	/* _XRT_DEVCTL_H_ */
> diff --git a/drivers/fpga/xrt/lib/xleaf/devctl.c b/drivers/fpga/xrt/lib/xleaf/devctl.c
> new file mode 100644
> index 000000000000..caf8c6569f0f
> --- /dev/null
> +++ b/drivers/fpga/xrt/lib/xleaf/devctl.c
> @@ -0,0 +1,206 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Xilinx Alveo FPGA devctl Driver
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
> +#include "xleaf/devctl.h"
> +
> +#define XRT_DEVCTL "xrt_devctl"
> +
> +struct xrt_name_id {
> +	char *ep_name;
> +	int id;
> +};
> +
> +static struct xrt_name_id name_id[XRT_DEVCTL_MAX] = {
> +	{ XRT_MD_NODE_BLP_ROM, XRT_DEVCTL_ROM_UUID },
> +	{ XRT_MD_NODE_GOLDEN_VER, XRT_DEVCTL_GOLDEN_VER },
DDR_CALIB is unused ?
> +};
> +
> +struct xrt_devctl {
> +	struct platform_device	*pdev;
> +	void		__iomem *base_addrs[XRT_DEVCTL_MAX];
> +	ulong			sizes[XRT_DEVCTL_MAX];
> +};
similar to other patches, why not use regmap ?
> +
> +static int xrt_devctl_name2id(struct xrt_devctl *devctl, const char *name)
> +{
> +	int	i;
> +
> +	for (i = 0; i < XRT_DEVCTL_MAX && name_id[i].ep_name; i++) {
> +		if (!strncmp(name_id[i].ep_name, name, strlen(name_id[i].ep_name) + 1))
> +			return name_id[i].id;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int
> +xrt_devctl_leaf_ioctl(struct platform_device *pdev, u32 cmd, void *arg)
> +{
> +	struct xrt_devctl	*devctl;
> +	int			ret = 0;
> +
> +	devctl = platform_get_drvdata(pdev);
> +
> +	switch (cmd) {
> +	case XRT_XLEAF_EVENT:
> +		/* Does not handle any event. */
> +		break;
> +	case XRT_DEVCTL_READ: {
> +		struct xrt_devctl_ioctl_rw	*rw_arg = arg;
> +		u32				*p_src, *p_dst, i;
> +
> +		if (rw_arg->xgir_len & 0x3) {
> +			xrt_err(pdev, "invalid len %d", rw_arg->xgir_len);
> +			return -EINVAL;
> +		}
> +
> +		if (rw_arg->xgir_id >= XRT_DEVCTL_MAX) {
> +			xrt_err(pdev, "invalid id %d", rw_arg->xgir_id);
> +			return -EINVAL;
> +		}
needs a < 0 check ?
> +
> +		p_src = devctl->base_addrs[rw_arg->xgir_id];
> +		if (!p_src) {
> +			xrt_err(pdev, "io not found, id %d",
> +				rw_arg->xgir_id);
> +			return -EINVAL;
> +		}
> +		if (rw_arg->xgir_offset + rw_arg->xgir_len >
> +		    devctl->sizes[rw_arg->xgir_id]) {
> +			xrt_err(pdev, "invalid argument, off %d, len %d",
> +				rw_arg->xgir_offset, rw_arg->xgir_len);
> +			return -EINVAL;
> +		}
> +		p_dst = rw_arg->xgir_buf;
> +		for (i = 0; i < rw_arg->xgir_len / sizeof(u32); i++) {
> +			u32 val = ioread32(p_src + rw_arg->xgir_offset + i);
> +
> +			memcpy(p_dst + i, &val, sizeof(u32));
> +		}
> +		break;
> +	}

The _WRITE msg is not handled Then why have it ?

Tom

> +	default:
> +		xrt_err(pdev, "unsupported cmd %d", cmd);
> +		return -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +static int xrt_devctl_remove(struct platform_device *pdev)
> +{
> +	struct xrt_devctl	*devctl;
> +	int			i;
> +
> +	devctl = platform_get_drvdata(pdev);
> +
> +	for (i = 0; i < XRT_DEVCTL_MAX; i++) {
> +		if (devctl->base_addrs[i])
> +			iounmap(devctl->base_addrs[i]);
> +	}
> +
> +	platform_set_drvdata(pdev, NULL);
> +	devm_kfree(&pdev->dev, devctl);
> +
> +	return 0;
> +}
> +
> +static int xrt_devctl_probe(struct platform_device *pdev)
> +{
> +	struct xrt_devctl	*devctl;
> +	int			i, id, ret = 0;
> +	struct resource		*res;
> +
> +	devctl = devm_kzalloc(&pdev->dev, sizeof(*devctl), GFP_KERNEL);
> +	if (!devctl)
> +		return -ENOMEM;
> +
> +	devctl->pdev = pdev;
> +	platform_set_drvdata(pdev, devctl);
> +
> +	xrt_info(pdev, "probing...");
> +	for (i = 0, res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	    res;
> +	    res = platform_get_resource(pdev, IORESOURCE_MEM, ++i)) {
> +		id = xrt_devctl_name2id(devctl, res->name);
> +		if (id < 0) {
> +			xrt_err(pdev, "ep %s not found", res->name);
> +			continue;
> +		}
> +		devctl->base_addrs[id] = ioremap(res->start, res->end - res->start + 1);
> +		if (!devctl->base_addrs[id]) {
> +			xrt_err(pdev, "map base failed %pR", res);
> +			ret = -EIO;
> +			goto failed;
> +		}
> +		devctl->sizes[id] = res->end - res->start + 1;
> +	}
> +
> +failed:
> +	if (ret)
> +		xrt_devctl_remove(pdev);
> +
> +	return ret;
> +}
> +
> +static struct xrt_subdev_endpoints xrt_devctl_endpoints[] = {
> +	{
> +		.xse_names = (struct xrt_subdev_ep_names[]) {
> +			/* add name if ep is in same partition */
> +			{ .ep_name = XRT_MD_NODE_BLP_ROM },
> +			{ NULL },
> +		},
> +		.xse_min_ep = 1,
> +	},
> +	{
> +		.xse_names = (struct xrt_subdev_ep_names[]) {
> +			{ .ep_name = XRT_MD_NODE_GOLDEN_VER },
> +			{ NULL },
> +		},
> +		.xse_min_ep = 1,
> +	},
> +	/* adding ep bundle generates devctl device instance */
> +	{ 0 },
> +};
> +
> +static struct xrt_subdev_drvdata xrt_devctl_data = {
> +	.xsd_dev_ops = {
> +		.xsd_ioctl = xrt_devctl_leaf_ioctl,
> +	},
> +};
> +
> +static const struct platform_device_id xrt_devctl_table[] = {
> +	{ XRT_DEVCTL, (kernel_ulong_t)&xrt_devctl_data },
> +	{ },
> +};
> +
> +static struct platform_driver xrt_devctl_driver = {
> +	.driver = {
> +		.name = XRT_DEVCTL,
> +	},
> +	.probe = xrt_devctl_probe,
> +	.remove = xrt_devctl_remove,
> +	.id_table = xrt_devctl_table,
> +};
> +
> +void devctl_leaf_init_fini(bool init)
> +{
> +	if (init)
> +		xleaf_register_driver(XRT_SUBDEV_DEVCTL, &xrt_devctl_driver, xrt_devctl_endpoints);
> +	else
> +		xleaf_unregister_driver(XRT_SUBDEV_DEVCTL);
> +}


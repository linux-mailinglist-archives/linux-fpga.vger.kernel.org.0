Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97F9E355654
	for <lists+linux-fpga@lfdr.de>; Tue,  6 Apr 2021 16:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345022AbhDFOSr (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 6 Apr 2021 10:18:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46824 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345012AbhDFOSj (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 6 Apr 2021 10:18:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617718710;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M5mbJXjeN3hfYRqWOXyJ/7mfMosPMWxzqRmSmdI+Zk0=;
        b=Mat5YF4OmKmbycnVykAXk+wed333LgdpRQ6ASfiX7Hz1prMNocAjKENz1OGVtE44tPs6aL
        U4torhaA3F06xxeD779brmtQ8VJQS196mZLwmrWkWHviYhF4IalbxGRRvqa1p47hhKqoaL
        MwYYR6f6ER07DK8UcdCDucR5xI6IRPM=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-rjsZLZ03NkO8uGDvih5OUQ-1; Tue, 06 Apr 2021 10:18:28 -0400
X-MC-Unique: rjsZLZ03NkO8uGDvih5OUQ-1
Received: by mail-qv1-f71.google.com with SMTP id s8so3452565qve.16
        for <linux-fpga@vger.kernel.org>; Tue, 06 Apr 2021 07:18:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=M5mbJXjeN3hfYRqWOXyJ/7mfMosPMWxzqRmSmdI+Zk0=;
        b=rwqIkBCHSjZc2D1G9U+mlWMiMfqZeCVMum7reI1h3lw97TIBHXyB0H3bxDl3zkjZKD
         tRVO1y0pTpCG46IRL2sMQeRBfu+jgy6mvnfJyczXJgSrBmT4EBbvvTzQ0kwIshsj2crb
         Tb5iA4vU2LHNCbVWKpDge/Fl/36/VZ+Xmr7YQ8ZP0QKCcokX/W3IG7ngWUZ6SGgxRzh+
         y2pkX5PiCDS/ag6ay+Amyfwxe7KP/kg+Tn2EdtVLHR7Y5xgn/rFb5HRfPPVP05zwNXfy
         oPQZy6MewhPZCSuar51sYW4vDXfrHDTFKHmuEOYzdlKffQ3zhgdzYjQiRhFZapk1xk10
         MBNA==
X-Gm-Message-State: AOAM530bDjzNHiRxjjN77mvZJS/Q1Y39sWPcW2put+wvbUX1EVIYQu7l
        xcbQ3syBBeUEOFGRGkCIIQGtPNye5vFat1bWmvkk8eQLD1GouWsiERDIJ2HRgYqQPaEXCtHv30x
        VVlwtO1V4AP6sf0UIgur8FQ==
X-Received: by 2002:a0c:9b82:: with SMTP id o2mr29256595qve.47.1617718707987;
        Tue, 06 Apr 2021 07:18:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzloBXKd22M9Q0Zf5q1jsljUgJfBVpOfoAKbi6na9kFVhAEF76+smWaeZR7LlDpWXjCSKfLYA==
X-Received: by 2002:a0c:9b82:: with SMTP id o2mr29256573qve.47.1617718707755;
        Tue, 06 Apr 2021 07:18:27 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id j18sm15596346qtl.83.2021.04.06.07.18.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Apr 2021 07:18:27 -0700 (PDT)
Subject: Re: [PATCH V4 XRT Alveo 15/20] fpga: xrt: devctl platform driver
To:     Lizhi Hou <lizhi.hou@xilinx.com>, linux-kernel@vger.kernel.org
Cc:     linux-fpga@vger.kernel.org, maxz@xilinx.com,
        sonal.santan@xilinx.com, yliu@xilinx.com, michal.simek@xilinx.com,
        stefanos@xilinx.com, devicetree@vger.kernel.org, mdf@kernel.org,
        robh@kernel.org, Max Zhen <max.zhen@xilinx.com>
References: <20210324052947.27889-1-lizhi.hou@xilinx.com>
 <20210324052947.27889-16-lizhi.hou@xilinx.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <019c4124-3dc1-340e-3473-fa4582b3ae71@redhat.com>
Date:   Tue, 6 Apr 2021 07:18:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210324052947.27889-16-lizhi.hou@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 3/23/21 10:29 PM, Lizhi Hou wrote:
> Add devctl driver. devctl is a type of hardware function which only has
> few registers to read or write. They are discovered by walking firmware
> metadata. A platform device node will be created for them.
>
> Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
> Signed-off-by: Max Zhen <max.zhen@xilinx.com>
> Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
> ---
>   drivers/fpga/xrt/include/xleaf/devctl.h |  40 ++++++
>   drivers/fpga/xrt/lib/xleaf/devctl.c     | 183 ++++++++++++++++++++++++
>   2 files changed, 223 insertions(+)
>   create mode 100644 drivers/fpga/xrt/include/xleaf/devctl.h
>   create mode 100644 drivers/fpga/xrt/lib/xleaf/devctl.c
>
> diff --git a/drivers/fpga/xrt/include/xleaf/devctl.h b/drivers/fpga/xrt/include/xleaf/devctl.h
> new file mode 100644
> index 000000000000..b97f3b6d9326
> --- /dev/null
> +++ b/drivers/fpga/xrt/include/xleaf/devctl.h
> @@ -0,0 +1,40 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
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
> + * DEVCTL driver leaf calls.
> + */
> +enum xrt_devctl_leaf_cmd {
> +	XRT_DEVCTL_READ = XRT_XLEAF_CUSTOM_BASE, /* See comments in xleaf.h */
> +};
> +
> +enum xrt_devctl_id {
> +	XRT_DEVCTL_ROM_UUID = 0,
ok
> +	XRT_DEVCTL_DDR_CALIB,
> +	XRT_DEVCTL_GOLDEN_VER,
> +	XRT_DEVCTL_MAX
> +};
> +
> +struct xrt_devctl_rw {
> +	u32	xdr_id;
> +	void	*xdr_buf;
> +	u32	xdr_len;
> +	u32	xdr_offset;
> +};
> +
> +struct xrt_devctl_intf_uuid {
> +	u32	uuid_num;
> +	uuid_t	*uuids;
> +};
> +
> +#endif	/* _XRT_DEVCTL_H_ */
> diff --git a/drivers/fpga/xrt/lib/xleaf/devctl.c b/drivers/fpga/xrt/lib/xleaf/devctl.c
> new file mode 100644
> index 000000000000..ae086d7c431d
> --- /dev/null
> +++ b/drivers/fpga/xrt/lib/xleaf/devctl.c
> @@ -0,0 +1,183 @@
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
> +#include <linux/regmap.h>
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
> +};
> +
> +static const struct regmap_config devctl_regmap_config = {
> +	.reg_bits = 32,
> +	.val_bits = 32,
> +	.reg_stride = 4,
ok
> +};
> +
> +struct xrt_devctl {
> +	struct platform_device	*pdev;
> +	struct regmap		*regmap[XRT_DEVCTL_MAX];
> +	ulong			sizes[XRT_DEVCTL_MAX];
> +};
> +
> +static int xrt_devctl_name2id(struct xrt_devctl *devctl, const char *name)
> +{
> +	int i;
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
> +xrt_devctl_leaf_call(struct platform_device *pdev, u32 cmd, void *arg)
> +{
> +	struct xrt_devctl *devctl;
> +	int ret = 0;
> +
> +	devctl = platform_get_drvdata(pdev);
> +
> +	switch (cmd) {
> +	case XRT_XLEAF_EVENT:
> +		/* Does not handle any event. */
> +		break;
> +	case XRT_DEVCTL_READ: {
> +		struct xrt_devctl_rw *rw_arg = arg;
> +
> +		if (rw_arg->xdr_len & 0x3) {
> +			xrt_err(pdev, "invalid len %d", rw_arg->xdr_len);
> +			return -EINVAL;
> +		}
> +
> +		if (rw_arg->xdr_id >= XRT_DEVCTL_MAX) {
ok
> +			xrt_err(pdev, "invalid id %d", rw_arg->xdr_id);
> +			return -EINVAL;
> +		}
> +
> +		if (!devctl->regmap[rw_arg->xdr_id]) {
> +			xrt_err(pdev, "io not found, id %d",
> +				rw_arg->xdr_id);
> +			return -EINVAL;
> +		}
> +
> +		ret = regmap_bulk_read(devctl->regmap[rw_arg->xdr_id], rw_arg->xdr_offset,
> +				       rw_arg->xdr_buf,
> +				       rw_arg->xdr_len / devctl_regmap_config.reg_stride);
> +		break;
> +	}

ok, *_WRITE removed.

Thanks for the changes

Reviewed-by: Tom Rix <trix@redhat.com>

> +	default:
> +		xrt_err(pdev, "unsupported cmd %d", cmd);
> +		return -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +static int xrt_devctl_probe(struct platform_device *pdev)
> +{
> +	struct xrt_devctl *devctl = NULL;
> +	void __iomem *base = NULL;
> +	struct resource *res;
> +	int i, id, ret = 0;
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
> +		struct regmap_config config = devctl_regmap_config;
> +
> +		id = xrt_devctl_name2id(devctl, res->name);
> +		if (id < 0) {
> +			xrt_err(pdev, "ep %s not found", res->name);
> +			continue;
> +		}
> +		base = devm_ioremap_resource(&pdev->dev, res);
> +		if (IS_ERR(base)) {
> +			ret = PTR_ERR(base);
> +			break;
> +		}
> +		config.max_register = res->end - res->start + 1;
> +		devctl->regmap[id] = devm_regmap_init_mmio(&pdev->dev, base, &config);
> +		if (IS_ERR(devctl->regmap[id])) {
> +			xrt_err(pdev, "map base failed %pR", res);
> +			ret = PTR_ERR(devctl->regmap[id]);
> +			break;
> +		}
> +		devctl->sizes[id] = res->end - res->start + 1;
> +	}
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
> +		.xsd_leaf_call = xrt_devctl_leaf_call,
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
> +	.id_table = xrt_devctl_table,
> +};
> +
> +XRT_LEAF_INIT_FINI_FUNC(XRT_SUBDEV_DEVCTL, devctl);


Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8614E32FB56
	for <lists+linux-fpga@lfdr.de>; Sat,  6 Mar 2021 16:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbhCFPZo (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 6 Mar 2021 10:25:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32897 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230311AbhCFPZM (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 6 Mar 2021 10:25:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615044311;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/B+AOlJcs0hfQ6IJqPho0ZM2HN4EgmewxC/QAoQZ8IY=;
        b=NiS2498lDPHiacrKr4am5TsSgW6EdA1bYLnlxn7I98j03xoZWLRlE5kmLzsOpES2/DESnU
        jXQwU945cV45f8RKm3d2N6UZHy1sfnezvD3SAgbfjYRmG+FgFfTLukCHFq4b//mblrpeB/
        ahXaYwPyAqT5GbiagE9QMdfW2k4p4UI=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-76-zMkSE6tUMGyjHZ-_jqCLog-1; Sat, 06 Mar 2021 10:25:09 -0500
X-MC-Unique: zMkSE6tUMGyjHZ-_jqCLog-1
Received: by mail-qt1-f199.google.com with SMTP id i2so4393225qtd.4
        for <linux-fpga@vger.kernel.org>; Sat, 06 Mar 2021 07:25:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=/B+AOlJcs0hfQ6IJqPho0ZM2HN4EgmewxC/QAoQZ8IY=;
        b=ngPlBdSVFUhNX0Uyz/6n/+SDiV37budUHUkDEKdqokHGgndDjO+/ErjYH3ClH3fE1Q
         wbut4iprTwHzDh4N5XAjAGOAYjndJkJu9EJkvo3rAFVCsuo/nLhe/EkRp94cSEUSSikx
         D7i3P2OR7RUgku/WCfGojbmUXRDgnumlZHLSoUEF+pnfI73snX61U2+UBEMjRi1jpyf3
         eSVUq4dOdVjsiiOoZP2OBB6c1KWTK3T7qqvSzBh5DZQqGPL8fOgCZ4dMXSunLW3Rn/mQ
         +O3X+SE+RZHtJedjPiglxTwFKkJANfO+NAld5jAA6yizeMASYea5RLiuQJlWGMZYX6z5
         G1sQ==
X-Gm-Message-State: AOAM532vvKcXqWgPMMs/U++n7zPTcODGDFvrfzsGQeCVPzVCXgFU8PEW
        NIml56LiQmw68y1Q8In+BjirTHBC+jBsjCahMgqZATvJwps7WYUbKTjZT55fOwo93+MDGPNvIHe
        AmdC6qCzwBjoFU/lc667BDQ==
X-Received: by 2002:a37:65d4:: with SMTP id z203mr13280568qkb.254.1615044309329;
        Sat, 06 Mar 2021 07:25:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzIUVIyeva1qRVIcNon+2c22Suy+MV5TCgJ/eHP+Jn5Csxx+NtUMMCbCbkLeleE2t/TJBftNg==
X-Received: by 2002:a37:65d4:: with SMTP id z203mr13280548qkb.254.1615044309035;
        Sat, 06 Mar 2021 07:25:09 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id v17sm4263200qtq.41.2021.03.06.07.25.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Mar 2021 07:25:08 -0800 (PST)
Subject: Re: [PATCH V3 XRT Alveo 15/18] fpga: xrt: clock frequence counter
 platform driver
To:     Lizhi Hou <lizhi.hou@xilinx.com>, linux-kernel@vger.kernel.org
Cc:     Lizhi Hou <lizhih@xilinx.com>, linux-fpga@vger.kernel.org,
        maxz@xilinx.com, sonal.santan@xilinx.com, michal.simek@xilinx.com,
        stefanos@xilinx.com, devicetree@vger.kernel.org, mdf@kernel.org,
        robh@kernel.org, Max Zhen <max.zhen@xilinx.com>
References: <20210218064019.29189-1-lizhih@xilinx.com>
 <20210218064019.29189-16-lizhih@xilinx.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <85c34149-ccb4-31c9-4a7d-477b30effad2@redhat.com>
Date:   Sat, 6 Mar 2021 07:25:06 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210218064019.29189-16-lizhih@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 2/17/21 10:40 PM, Lizhi Hou wrote:
> Add clock frequence counter driver. Clock frequence counter is
> a hardware function discovered by walking xclbin metadata. A platform
> device node will be created for it. Other part of driver can read the
> actual clock frequence through clock frequence counter driver.
>
> Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
> Signed-off-by: Max Zhen <max.zhen@xilinx.com>
> Signed-off-by: Lizhi Hou <lizhih@xilinx.com>
> ---
>  drivers/fpga/xrt/include/xleaf/clkfreq.h |  23 +++
>  drivers/fpga/xrt/lib/xleaf/clkfreq.c     | 221 +++++++++++++++++++++++
>  2 files changed, 244 insertions(+)
>  create mode 100644 drivers/fpga/xrt/include/xleaf/clkfreq.h
>  create mode 100644 drivers/fpga/xrt/lib/xleaf/clkfreq.c
>
> diff --git a/drivers/fpga/xrt/include/xleaf/clkfreq.h b/drivers/fpga/xrt/include/xleaf/clkfreq.h
> new file mode 100644
> index 000000000000..29fc45e8a31b
> --- /dev/null
> +++ b/drivers/fpga/xrt/include/xleaf/clkfreq.h
> @@ -0,0 +1,23 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Header file for XRT Clock Counter Leaf Driver
> + *
> + * Copyright (C) 2020-2021 Xilinx, Inc.
> + *
> + * Authors:
> + *	Lizhi Hou <Lizhi.Hou@xilinx.com>
> + */
> +
> +#ifndef _XRT_CLKFREQ_H_
> +#define _XRT_CLKFREQ_H_
> +
> +#include "xleaf.h"
> +
> +/*
> + * CLKFREQ driver IOCTL calls.
> + */
> +enum xrt_clkfreq_ioctl_cmd {
> +	XRT_CLKFREQ_READ = XRT_XLEAF_CUSTOM_BASE, /* See comments in xleaf.h */
> +};
> +
> +#endif	/* _XRT_CLKFREQ_H_ */
> diff --git a/drivers/fpga/xrt/lib/xleaf/clkfreq.c b/drivers/fpga/xrt/lib/xleaf/clkfreq.c
> new file mode 100644
> index 000000000000..2482dd2cff47
> --- /dev/null
> +++ b/drivers/fpga/xrt/lib/xleaf/clkfreq.c
> @@ -0,0 +1,221 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Xilinx Alveo FPGA Clock Frequency Counter Driver
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
> +#include "xleaf/clkfreq.h"
> +
> +#define CLKFREQ_ERR(clkfreq, fmt, arg...)   \
> +	xrt_err((clkfreq)->pdev, fmt "\n", ##arg)
> +#define CLKFREQ_WARN(clkfreq, fmt, arg...)  \
> +	xrt_warn((clkfreq)->pdev, fmt "\n", ##arg)
> +#define CLKFREQ_INFO(clkfreq, fmt, arg...)  \
> +	xrt_info((clkfreq)->pdev, fmt "\n", ##arg)
> +#define CLKFREQ_DBG(clkfreq, fmt, arg...)   \
> +	xrt_dbg((clkfreq)->pdev, fmt "\n", ##arg)
> +
> +#define XRT_CLKFREQ		"xrt_clkfreq"
> +
> +#define OCL_CLKWIZ_STATUS_MASK		0xffff
> +
> +#define OCL_CLKWIZ_STATUS_MEASURE_START	0x1
> +#define OCL_CLKWIZ_STATUS_MEASURE_DONE	0x2
> +#define OCL_CLK_FREQ_COUNTER_OFFSET	0x8
> +#define OCL_CLK_FREQ_V5_COUNTER_OFFSET	0x10
> +#define OCL_CLK_FREQ_V5_CLK0_ENABLED	0x10000

Similar to earlier, OCL -> XRT_CLKFREQ

Use regmap

> +
> +struct clkfreq {
> +	struct platform_device	*pdev;
> +	void __iomem		*clkfreq_base;
> +	const char		*clkfreq_ep_name;
> +	struct mutex		clkfreq_lock; /* clock counter dev lock */
> +};
> +
> +static inline u32 reg_rd(struct clkfreq *clkfreq, u32 offset)
> +{
> +	return ioread32(clkfreq->clkfreq_base + offset);
> +}
> +
> +static inline void reg_wr(struct clkfreq *clkfreq, u32 val, u32 offset)
> +{
> +	iowrite32(val, clkfreq->clkfreq_base + offset);
> +}
> +
> +static u32 clkfreq_read(struct clkfreq *clkfreq)
> +{

failure returns 0, it would be better if -EINVAL or similar was returned.

and u32 *freq added as a function parameter

> +	u32 freq = 0, status;
> +	int times = 10;
10 is a config parameter, should be a #define
> +
> +	mutex_lock(&clkfreq->clkfreq_lock);
> +	reg_wr(clkfreq, OCL_CLKWIZ_STATUS_MEASURE_START, 0);
> +	while (times != 0) {
> +		status = reg_rd(clkfreq, 0);
> +		if ((status & OCL_CLKWIZ_STATUS_MASK) ==
> +		    OCL_CLKWIZ_STATUS_MEASURE_DONE)
> +			break;
> +		mdelay(1);
> +		times--;
> +	};
> +	if (times > 0) {
I do not like tristate setting, convert to if-else
> +		freq = (status & OCL_CLK_FREQ_V5_CLK0_ENABLED) ?
> +			reg_rd(clkfreq, OCL_CLK_FREQ_V5_COUNTER_OFFSET) :
> +			reg_rd(clkfreq, OCL_CLK_FREQ_COUNTER_OFFSET);
> +	}
> +	mutex_unlock(&clkfreq->clkfreq_lock);
> +
> +	return freq;
> +}
> +
> +static ssize_t freq_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct clkfreq *clkfreq = platform_get_drvdata(to_platform_device(dev));
> +	u32 freq;
> +	ssize_t count;
> +
> +	freq = clkfreq_read(clkfreq);
unchecked error
> +	count = snprintf(buf, 64, "%d\n", freq);
%u
> +
> +	return count;
> +}
> +static DEVICE_ATTR_RO(freq);
> +
> +static struct attribute *clkfreq_attrs[] = {
> +	&dev_attr_freq.attr,
> +	NULL,
> +};
> +
> +static struct attribute_group clkfreq_attr_group = {
> +	.attrs = clkfreq_attrs,
> +};
> +
> +static int
> +xrt_clkfreq_leaf_ioctl(struct platform_device *pdev, u32 cmd, void *arg)
> +{
> +	struct clkfreq		*clkfreq;
> +	int			ret = 0;
> +
> +	clkfreq = platform_get_drvdata(pdev);
> +
> +	switch (cmd) {
> +	case XRT_XLEAF_EVENT:
> +		/* Does not handle any event. */
> +		break;
> +	case XRT_CLKFREQ_READ: {
brace not needed
> +		*(u32 *)arg = clkfreq_read(clkfreq);
Unchecked error
> +		break;
> +	}
> +	default:
> +		xrt_err(pdev, "unsupported cmd %d", cmd);
> +		return -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +static int clkfreq_remove(struct platform_device *pdev)
> +{
> +	struct clkfreq *clkfreq;
> +
> +	clkfreq = platform_get_drvdata(pdev);
> +	if (!clkfreq) {
> +		xrt_err(pdev, "driver data is NULL");
> +		return -EINVAL;
> +	}
> +
> +	platform_set_drvdata(pdev, NULL);
> +	devm_kfree(&pdev->dev, clkfreq);
> +
> +	CLKFREQ_INFO(clkfreq, "successfully removed clkfreq subdev");
> +	return 0;
> +}
> +
> +static int clkfreq_probe(struct platform_device *pdev)
> +{
> +	struct clkfreq *clkfreq = NULL;
> +	struct resource *res;
> +	int ret;
> +
> +	clkfreq = devm_kzalloc(&pdev->dev, sizeof(*clkfreq), GFP_KERNEL);
> +	if (!clkfreq)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, clkfreq);
> +	clkfreq->pdev = pdev;
> +	mutex_init(&clkfreq->clkfreq_lock);
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	clkfreq->clkfreq_base = ioremap(res->start, res->end - res->start + 1);
> +	if (!clkfreq->clkfreq_base) {
> +		CLKFREQ_ERR(clkfreq, "map base %pR failed", res);
> +		ret = -EFAULT;
> +		goto failed;
> +	}
> +	clkfreq->clkfreq_ep_name = res->name;
> +
> +	ret = sysfs_create_group(&pdev->dev.kobj, &clkfreq_attr_group);
> +	if (ret) {
> +		CLKFREQ_ERR(clkfreq, "create clkfreq attrs failed: %d", ret);
> +		goto failed;
> +	}
> +
> +	CLKFREQ_INFO(clkfreq, "successfully initialized clkfreq subdev");
> +
> +	return 0;
> +
> +failed:
> +	clkfreq_remove(pdev);
> +	return ret;
> +}
> +
> +static struct xrt_subdev_endpoints xrt_clkfreq_endpoints[] = {
> +	{
> +		.xse_names = (struct xrt_subdev_ep_names[]) {
> +			{ .regmap_name = "freq_cnt" },

name should be closer to filename, maybe 'clock_frequency' or 'clkfreq'

Tom

> +			{ NULL },
> +		},
> +		.xse_min_ep = 1,
> +	},
> +	{ 0 },
> +};
> +
> +static struct xrt_subdev_drvdata xrt_clkfreq_data = {
> +	.xsd_dev_ops = {
> +		.xsd_ioctl = xrt_clkfreq_leaf_ioctl,
> +	},
> +};
> +
> +static const struct platform_device_id xrt_clkfreq_table[] = {
> +	{ XRT_CLKFREQ, (kernel_ulong_t)&xrt_clkfreq_data },
> +	{ },
> +};
> +
> +static struct platform_driver xrt_clkfreq_driver = {
> +	.driver = {
> +		.name = XRT_CLKFREQ,
> +	},
> +	.probe = clkfreq_probe,
> +	.remove = clkfreq_remove,
> +	.id_table = xrt_clkfreq_table,
> +};
> +
> +void clkfreq_leaf_init_fini(bool init)
> +{
> +	if (init) {
> +		xleaf_register_driver(XRT_SUBDEV_CLKFREQ,
> +				      &xrt_clkfreq_driver, xrt_clkfreq_endpoints);
> +	} else {
> +		xleaf_unregister_driver(XRT_SUBDEV_CLKFREQ);
> +	}
> +}


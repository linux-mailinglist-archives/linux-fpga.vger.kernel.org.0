Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A04D372BC3
	for <lists+linux-fpga@lfdr.de>; Tue,  4 May 2021 16:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbhEDOOR (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 4 May 2021 10:14:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50879 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231451AbhEDOOJ (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 4 May 2021 10:14:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620137594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AFQOereHJicYv2+fYp6ywaLPbbKl26zwBxuZTHmGJeg=;
        b=KHO6zy1ojT59CxzeqEQw2AXVh8rnXq9N9RhDfRaYTuCtg2Wv/smZ5gU0IgAHsyhpSp0uXf
        yj8Chr53MzPwKB3PbNY7u1RwZf9mG1hPmP3gAzyaVUjHakj1Rr/eq7nVP/aN7sZX8ZaQW/
        jYZj+WPLta5Ey/5wCxB6dAWu8N/bkZc=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-Ok7WskoxPImIe1tc9Ig3MQ-1; Tue, 04 May 2021 10:13:12 -0400
X-MC-Unique: Ok7WskoxPImIe1tc9Ig3MQ-1
Received: by mail-qt1-f200.google.com with SMTP id h7-20020ac854870000b02901cc0a321bc4so1359993qtq.1
        for <linux-fpga@vger.kernel.org>; Tue, 04 May 2021 07:13:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=AFQOereHJicYv2+fYp6ywaLPbbKl26zwBxuZTHmGJeg=;
        b=N+Ss2DNT1+kvAE8y6TRufANT6uewRSzvPSOu+SPpsm9rni2BrtNiMYvDSKGrlc2KY6
         dvabPIESAyk5sXqTrfvZ6a0wg6B4kzSbytbksQ6wzOpgjKsYpgvMFtstmNpb2BB1Y7Ie
         ZSl3p48mZ2IDtbAiCKsE1/k7HDeHKxvmPuYyAcxAPahKbQXYVFK4ggg/4DPUgYt2WW5h
         Jksi8MkyNPmqIqEAtaCXLj4L4OxzIEhbENXQH4bttUOPYNfRy+aq/PhpwLZP/nck/7Pa
         r7u5F2psGR9IyQR4F92rS3VoiZldF2bphXO7cea245Bt4FRfLn1wNG7jhPVZX0d1EImE
         zsMw==
X-Gm-Message-State: AOAM531U6b3ArPJtN5xsOSL9K2xs8Bl52niQ8GUT1C4mdoQuiZUYAIwz
        rDQeqHKkyC5v7QdaMXtZtfA6FaP48oLvx6uU25C28lK7DGZR2A9G4ArrDsPgu4nU0XqOFnAxA5G
        C+51ayi3sm5yiA+if3bbfIA==
X-Received: by 2002:ad4:556a:: with SMTP id w10mr6983113qvy.1.1620137591757;
        Tue, 04 May 2021 07:13:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxk2c01A8ViGXrubmim1tnOdXxD3g2mORY9fRVwjzxaNHbphtBt5i660RTZmLqvsyV3Lb1glg==
X-Received: by 2002:ad4:556a:: with SMTP id w10mr6983087qvy.1.1620137591550;
        Tue, 04 May 2021 07:13:11 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id l16sm11329443qkg.91.2021.05.04.07.13.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 May 2021 07:13:11 -0700 (PDT)
Subject: Re: [PATCH V5 XRT Alveo 19/20] fpga: xrt: partition isolation driver
To:     Lizhi Hou <lizhi.hou@xilinx.com>, linux-kernel@vger.kernel.org
Cc:     linux-fpga@vger.kernel.org, maxz@xilinx.com,
        sonal.santan@xilinx.com, yliu@xilinx.com, michal.simek@xilinx.com,
        stefanos@xilinx.com, devicetree@vger.kernel.org, mdf@kernel.org,
        robh@kernel.org, Max Zhen <max.zhen@xilinx.com>
References: <20210427205431.23896-1-lizhi.hou@xilinx.com>
 <20210427205431.23896-20-lizhi.hou@xilinx.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <75159546-8ea9-179e-e052-ff512483f1fb@redhat.com>
Date:   Tue, 4 May 2021 07:13:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210427205431.23896-20-lizhi.hou@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 4/27/21 1:54 PM, Lizhi Hou wrote:
> Add partition isolation xrt driver. partition isolation is
> a hardware function discovered by walking firmware metadata.
> A xrt device node will be created for it. Partition isolation
> function isolate the different fpga regions
>
> Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
> Signed-off-by: Max Zhen <max.zhen@xilinx.com>
> Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>

v4 was fine. Please add my Reviewed-by line

Reviewed-by: Tom Rix <trix@redhat.com>

> ---
>   drivers/fpga/xrt/include/xleaf/axigate.h |  23 ++
>   drivers/fpga/xrt/lib/xleaf/axigate.c     | 325 +++++++++++++++++++++++
>   2 files changed, 348 insertions(+)
>   create mode 100644 drivers/fpga/xrt/include/xleaf/axigate.h
>   create mode 100644 drivers/fpga/xrt/lib/xleaf/axigate.c
>
> diff --git a/drivers/fpga/xrt/include/xleaf/axigate.h b/drivers/fpga/xrt/include/xleaf/axigate.h
> new file mode 100644
> index 000000000000..58f32c76dca1
> --- /dev/null
> +++ b/drivers/fpga/xrt/include/xleaf/axigate.h
> @@ -0,0 +1,23 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2020-2021 Xilinx, Inc.
> + *
> + * Authors:
> + *	Lizhi Hou <Lizhi.Hou@xilinx.com>
> + */
> +
> +#ifndef _XRT_AXIGATE_H_
> +#define _XRT_AXIGATE_H_
> +
> +#include "xleaf.h"
> +#include "metadata.h"
> +
> +/*
> + * AXIGATE driver leaf calls.
> + */
> +enum xrt_axigate_leaf_cmd {
> +	XRT_AXIGATE_CLOSE = XRT_XLEAF_CUSTOM_BASE, /* See comments in xleaf.h */
> +	XRT_AXIGATE_OPEN,
> +};
> +
> +#endif	/* _XRT_AXIGATE_H_ */
> diff --git a/drivers/fpga/xrt/lib/xleaf/axigate.c b/drivers/fpga/xrt/lib/xleaf/axigate.c
> new file mode 100644
> index 000000000000..493707b782e4
> --- /dev/null
> +++ b/drivers/fpga/xrt/lib/xleaf/axigate.c
> @@ -0,0 +1,325 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Xilinx Alveo FPGA AXI Gate Driver
> + *
> + * Copyright (C) 2020-2021 Xilinx, Inc.
> + *
> + * Authors:
> + *      Lizhi Hou<Lizhi.Hou@xilinx.com>
> + */
> +
> +#include <linux/mod_devicetable.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/regmap.h>
> +#include <linux/io.h>
> +#include "metadata.h"
> +#include "xleaf.h"
> +#include "xleaf/axigate.h"
> +
> +#define XRT_AXIGATE "xrt_axigate"
> +
> +#define XRT_AXIGATE_WRITE_REG		0
> +#define XRT_AXIGATE_READ_REG		8
> +
> +#define XRT_AXIGATE_CTRL_CLOSE		0
> +#define XRT_AXIGATE_CTRL_OPEN_BIT0	1
> +#define XRT_AXIGATE_CTRL_OPEN_BIT1	2
> +
> +#define XRT_AXIGATE_INTERVAL		500 /* ns */
> +
> +struct xrt_axigate {
> +	struct xrt_device	*xdev;
> +	struct regmap		*regmap;
> +	struct mutex		gate_lock; /* gate dev lock */
> +	void			*evt_hdl;
> +	const char		*ep_name;
> +	bool			gate_closed;
> +};
> +
> +XRT_DEFINE_REGMAP_CONFIG(axigate_regmap_config);
> +
> +/* the ep names are in the order of hardware layers */
> +static const char * const xrt_axigate_epnames[] = {
> +	XRT_MD_NODE_GATE_PLP, /* PLP: Provider Logic Partition */
> +	XRT_MD_NODE_GATE_ULP  /* ULP: User Logic Partition */
> +};
> +
> +static inline int close_gate(struct xrt_axigate *gate)
> +{
> +	u32 val;
> +	int ret;
> +
> +	ret = regmap_write(gate->regmap, XRT_AXIGATE_WRITE_REG, XRT_AXIGATE_CTRL_CLOSE);
> +	if (ret) {
> +		xrt_err(gate->xdev, "write gate failed %d", ret);
> +		return ret;
> +	}
> +	ndelay(XRT_AXIGATE_INTERVAL);
> +	/*
> +	 * Legacy hardware requires extra read work properly.
> +	 * This is not on critical path, thus the extra read should not impact performance much.
> +	 */
> +	ret = regmap_read(gate->regmap, XRT_AXIGATE_READ_REG, &val);
> +	if (ret) {
> +		xrt_err(gate->xdev, "read gate failed %d", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static inline int open_gate(struct xrt_axigate *gate)
> +{
> +	u32 val;
> +	int ret;
> +
> +	ret = regmap_write(gate->regmap, XRT_AXIGATE_WRITE_REG, XRT_AXIGATE_CTRL_OPEN_BIT1);
> +	if (ret) {
> +		xrt_err(gate->xdev, "write 2 failed %d", ret);
> +		return ret;
> +	}
> +	ndelay(XRT_AXIGATE_INTERVAL);
> +	/*
> +	 * Legacy hardware requires extra read work properly.
> +	 * This is not on critical path, thus the extra read should not impact performance much.
> +	 */
> +	ret = regmap_read(gate->regmap, XRT_AXIGATE_READ_REG, &val);
> +	if (ret) {
> +		xrt_err(gate->xdev, "read 2 failed %d", ret);
> +		return ret;
> +	}
> +	ret = regmap_write(gate->regmap, XRT_AXIGATE_WRITE_REG,
> +			   XRT_AXIGATE_CTRL_OPEN_BIT0 | XRT_AXIGATE_CTRL_OPEN_BIT1);
> +	if (ret) {
> +		xrt_err(gate->xdev, "write 3 failed %d", ret);
> +		return ret;
> +	}
> +	ndelay(XRT_AXIGATE_INTERVAL);
> +	ret = regmap_read(gate->regmap, XRT_AXIGATE_READ_REG, &val);
> +	if (ret) {
> +		xrt_err(gate->xdev, "read 3 failed %d", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int xrt_axigate_epname_idx(struct xrt_device *xdev)
> +{
> +	struct resource	*res;
> +	int ret, i;
> +
> +	res = xrt_get_resource(xdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		xrt_err(xdev, "Empty Resource!");
> +		return -EINVAL;
> +	}
> +
> +	for (i = 0; i < ARRAY_SIZE(xrt_axigate_epnames); i++) {
> +		ret = strncmp(xrt_axigate_epnames[i], res->name,
> +			      strlen(xrt_axigate_epnames[i]) + 1);
> +		if (!ret)
> +			return i;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int xrt_axigate_close(struct xrt_device *xdev)
> +{
> +	struct xrt_axigate *gate;
> +	u32 status = 0;
> +	int ret;
> +
> +	gate = xrt_get_drvdata(xdev);
> +
> +	mutex_lock(&gate->gate_lock);
> +	ret = regmap_read(gate->regmap, XRT_AXIGATE_READ_REG, &status);
> +	if (ret) {
> +		xrt_err(xdev, "read gate failed %d", ret);
> +		goto failed;
> +	}
> +	if (status) {		/* gate is opened */
> +		xleaf_broadcast_event(xdev, XRT_EVENT_PRE_GATE_CLOSE, false);
> +		ret = close_gate(gate);
> +		if (ret)
> +			goto failed;
> +	}
> +
> +	gate->gate_closed = true;
> +
> +failed:
> +	mutex_unlock(&gate->gate_lock);
> +
> +	xrt_info(xdev, "close gate %s", gate->ep_name);
> +	return ret;
> +}
> +
> +static int xrt_axigate_open(struct xrt_device *xdev)
> +{
> +	struct xrt_axigate *gate;
> +	u32 status;
> +	int ret;
> +
> +	gate = xrt_get_drvdata(xdev);
> +
> +	mutex_lock(&gate->gate_lock);
> +	ret = regmap_read(gate->regmap, XRT_AXIGATE_READ_REG, &status);
> +	if (ret) {
> +		xrt_err(xdev, "read gate failed %d", ret);
> +		goto failed;
> +	}
> +	if (!status) {		/* gate is closed */
> +		ret = open_gate(gate);
> +		if (ret)
> +			goto failed;
> +		xleaf_broadcast_event(xdev, XRT_EVENT_POST_GATE_OPEN, true);
> +		/* xrt_axigate_open() could be called in event cb, thus
> +		 * we can not wait for the completes
> +		 */
> +	}
> +
> +	gate->gate_closed = false;
> +
> +failed:
> +	mutex_unlock(&gate->gate_lock);
> +
> +	xrt_info(xdev, "open gate %s", gate->ep_name);
> +	return ret;
> +}
> +
> +static void xrt_axigate_event_cb(struct xrt_device *xdev, void *arg)
> +{
> +	struct xrt_axigate *gate = xrt_get_drvdata(xdev);
> +	struct xrt_event *evt = (struct xrt_event *)arg;
> +	enum xrt_events e = evt->xe_evt;
> +	struct xrt_device *leaf;
> +	enum xrt_subdev_id id;
> +	struct resource	*res;
> +	int instance;
> +
> +	if (e != XRT_EVENT_POST_CREATION)
> +		return;
> +
> +	instance = evt->xe_subdev.xevt_subdev_instance;
> +	id = evt->xe_subdev.xevt_subdev_id;
> +	if (id != XRT_SUBDEV_AXIGATE)
> +		return;
> +
> +	leaf = xleaf_get_leaf_by_id(xdev, id, instance);
> +	if (!leaf)
> +		return;
> +
> +	res = xrt_get_resource(leaf, IORESOURCE_MEM, 0);
> +	if (!res || !strncmp(res->name, gate->ep_name, strlen(res->name) + 1)) {
> +		xleaf_put_leaf(xdev, leaf);
> +		return;
> +	}
> +
> +	/* higher level axigate instance created, make sure the gate is opened. */
> +	if (xrt_axigate_epname_idx(leaf) > xrt_axigate_epname_idx(xdev))
> +		xrt_axigate_open(xdev);
> +	else
> +		xleaf_call(leaf, XRT_AXIGATE_OPEN, NULL);
> +
> +	xleaf_put_leaf(xdev, leaf);
> +}
> +
> +static int
> +xrt_axigate_leaf_call(struct xrt_device *xdev, u32 cmd, void *arg)
> +{
> +	int ret = 0;
> +
> +	switch (cmd) {
> +	case XRT_XLEAF_EVENT:
> +		xrt_axigate_event_cb(xdev, arg);
> +		break;
> +	case XRT_AXIGATE_CLOSE:
> +		ret = xrt_axigate_close(xdev);
> +		break;
> +	case XRT_AXIGATE_OPEN:
> +		ret = xrt_axigate_open(xdev);
> +		break;
> +	default:
> +		xrt_err(xdev, "unsupported cmd %d", cmd);
> +		return -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +static int xrt_axigate_probe(struct xrt_device *xdev)
> +{
> +	struct xrt_axigate *gate = NULL;
> +	void __iomem *base = NULL;
> +	struct resource *res;
> +	int ret;
> +
> +	gate = devm_kzalloc(&xdev->dev, sizeof(*gate), GFP_KERNEL);
> +	if (!gate)
> +		return -ENOMEM;
> +
> +	gate->xdev = xdev;
> +	xrt_set_drvdata(xdev, gate);
> +
> +	xrt_info(xdev, "probing...");
> +	res = xrt_get_resource(xdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		xrt_err(xdev, "Empty resource 0");
> +		ret = -EINVAL;
> +		goto failed;
> +	}
> +
> +	base = devm_ioremap_resource(&xdev->dev, res);
> +	if (IS_ERR(base)) {
> +		xrt_err(xdev, "map base iomem failed");
> +		ret = PTR_ERR(base);
> +		goto failed;
> +	}
> +
> +	gate->regmap = devm_regmap_init_mmio(&xdev->dev, base, &axigate_regmap_config);
> +	if (IS_ERR(gate->regmap)) {
> +		xrt_err(xdev, "regmap %pR failed", res);
> +		ret = PTR_ERR(gate->regmap);
> +		goto failed;
> +	}
> +	gate->ep_name = res->name;
> +
> +	mutex_init(&gate->gate_lock);
> +
> +	return 0;
> +
> +failed:
> +	return ret;
> +}
> +
> +static struct xrt_dev_endpoints xrt_axigate_endpoints[] = {
> +	{
> +		.xse_names = (struct xrt_dev_ep_names[]) {
> +			{ .ep_name = XRT_MD_NODE_GATE_ULP },
> +			{ NULL },
> +		},
> +		.xse_min_ep = 1,
> +	},
> +	{
> +		.xse_names = (struct xrt_dev_ep_names[]) {
> +			{ .ep_name = XRT_MD_NODE_GATE_PLP },
> +			{ NULL },
> +		},
> +		.xse_min_ep = 1,
> +	},
> +	{ 0 },
> +};
> +
> +static struct xrt_driver xrt_axigate_driver = {
> +	.driver = {
> +		.name = XRT_AXIGATE,
> +	},
> +	.subdev_id = XRT_SUBDEV_AXIGATE,
> +	.endpoints = xrt_axigate_endpoints,
> +	.probe = xrt_axigate_probe,
> +	.leaf_call = xrt_axigate_leaf_call,
> +};
> +
> +XRT_LEAF_INIT_FINI_FUNC(axigate);


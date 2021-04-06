Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB71F355D1F
	for <lists+linux-fpga@lfdr.de>; Tue,  6 Apr 2021 22:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238398AbhDFUqW (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 6 Apr 2021 16:46:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28268 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231676AbhDFUqV (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 6 Apr 2021 16:46:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617741973;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9jF6SBpkkUkARcJvBrW5Yv44iq+0zRMq+xdTHI1J2Vs=;
        b=HYC5aO0fTUS0ADAQh0D+tBinXvVTnaDqFqISzGOsoMvKchgYNHO4J05wN6q6ej4sHZ7FNV
        eH+xx9Q88Xj0Ov+BZOaYyNGld6PbDKasMkJNh1wXg5GuahbSkB40XdB7Sgl9bLXkA3OdJE
        BphWeEi9OEKd6FF6FH4qkar/Sj+zwF0=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-y9s5o__zMM-HuyQ9qhiKVw-1; Tue, 06 Apr 2021 16:46:11 -0400
X-MC-Unique: y9s5o__zMM-HuyQ9qhiKVw-1
Received: by mail-qv1-f69.google.com with SMTP id p2so11236593qvi.6
        for <linux-fpga@vger.kernel.org>; Tue, 06 Apr 2021 13:46:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=9jF6SBpkkUkARcJvBrW5Yv44iq+0zRMq+xdTHI1J2Vs=;
        b=V/BD0Qayzrjli9ijWwPncb2yBPXQhq7GxIa+WPZ2emKnwqTg4SnqievH3uvWTWP2PW
         l2vb38lkSFQ5W1Ou6sI/jpMYLu4eHLA1lCxO2yGi5+H2QbBrhPZzOazV4PvaFyNrNSp9
         15C1NeO9HXZgN2uByFnVwjHoMkmMwGIWKWPVZ3J7xP/umGTaE/gc+vgzfGLus/ZL7b3Z
         KvQdsOiCETpUqPwXUFTYa0q0w8PYPUYIE4Hf+FFoqcaaq/l7sWj04CAGYjW0eS9jqvuo
         mECpAeHGo8keqVBJ0jm0RVX/6EIK6P0yF1UPlO3Um+uxx/ZyNaFGDHzTtiafj8n5rKml
         h2Ag==
X-Gm-Message-State: AOAM531iRsAGCPGeD9lXup7GrmhX9NaY0m3YevLBFx/02hPKPDMg0Qea
        CIapL/Ajg0uOKR282BsTmWjqW0ehETqStmiqI/LcaYi4rWV5GChTNocmRq1dqXcRTw/162uRDcQ
        uK3Ww2ntl+rjsGo+caE4uXw==
X-Received: by 2002:ad4:4c83:: with SMTP id bs3mr30440626qvb.41.1617741971164;
        Tue, 06 Apr 2021 13:46:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy0VnL+exA7RU+abGL9Cqt4ZUPE4i0OrQRW+KnkIReqpOvj+jPAKt5SZzCRXT3wt26vn3ennw==
X-Received: by 2002:ad4:4c83:: with SMTP id bs3mr30440605qvb.41.1617741970928;
        Tue, 06 Apr 2021 13:46:10 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id a187sm16475449qkd.69.2021.04.06.13.46.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Apr 2021 13:46:10 -0700 (PDT)
Subject: Re: [PATCH V4 XRT Alveo 19/20] fpga: xrt: partition isolation
 platform driver
To:     Lizhi Hou <lizhi.hou@xilinx.com>, linux-kernel@vger.kernel.org
Cc:     linux-fpga@vger.kernel.org, maxz@xilinx.com,
        sonal.santan@xilinx.com, yliu@xilinx.com, michal.simek@xilinx.com,
        stefanos@xilinx.com, devicetree@vger.kernel.org, mdf@kernel.org,
        robh@kernel.org, Max Zhen <max.zhen@xilinx.com>
References: <20210324052947.27889-1-lizhi.hou@xilinx.com>
 <20210324052947.27889-20-lizhi.hou@xilinx.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <a0ecd4aa-718d-5099-4861-37be9b2e7b4f@redhat.com>
Date:   Tue, 6 Apr 2021 13:46:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210324052947.27889-20-lizhi.hou@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 3/23/21 10:29 PM, Lizhi Hou wrote:
> Add partition isolation platform driver. partition isolation is
> a hardware function discovered by walking firmware metadata.
> A platform device node will be created for it. Partition isolation
> function isolate the different fpga regions
>
> Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
> Signed-off-by: Max Zhen <max.zhen@xilinx.com>
> Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
> ---
>   drivers/fpga/xrt/include/xleaf/axigate.h |  23 ++
>   drivers/fpga/xrt/lib/xleaf/axigate.c     | 342 +++++++++++++++++++++++
>   2 files changed, 365 insertions(+)
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
ok
> +};
> +
> +#endif	/* _XRT_AXIGATE_H_ */
> diff --git a/drivers/fpga/xrt/lib/xleaf/axigate.c b/drivers/fpga/xrt/lib/xleaf/axigate.c
> new file mode 100644
> index 000000000000..231bb0335278
> --- /dev/null
> +++ b/drivers/fpga/xrt/lib/xleaf/axigate.c
> @@ -0,0 +1,342 @@
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
> +#include <linux/platform_device.h>
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
> +	struct platform_device	*pdev;
> +	struct regmap		*regmap;
> +	struct mutex		gate_lock; /* gate dev lock */
> +
> +	void			*evt_hdl;
> +	const char		*ep_name;
> +
> +	bool			gate_closed;
white space, extra nl's are not needed
> +};
> +
> +static const struct regmap_config axigate_regmap_config = {
> +	.reg_bits = 32,
> +	.val_bits = 32,
> +	.reg_stride = 4,
> +	.max_register = 0x1000,
ok
> +};
> +
> +/* the ep names are in the order of hardware layers */
> +static const char * const xrt_axigate_epnames[] = {
> +	XRT_MD_NODE_GATE_PLP, /* PLP: Provider Logic Partition */
> +	XRT_MD_NODE_GATE_ULP  /* ULP: User Logic Partition */
ok
> +};
> +
> +static inline int close_gate(struct xrt_axigate *gate)
> +{
> +	u32 val;
> +	int ret;
> +
> +	ret = regmap_write(gate->regmap, XRT_AXIGATE_WRITE_REG, XRT_AXIGATE_CTRL_CLOSE);
ok, regs defined
> +	if (ret) {
> +		xrt_err(gate->pdev, "write gate failed %d", ret);
> +		return ret;
> +	}
> +	ndelay(XRT_AXIGATE_INTERVAL);
> +	/*
> +	 * Legacy hardware requires extra read work properly.
> +	 * This is not on critical path, thus the extra read should not impact performance much.
> +	 */
> +	ret = regmap_read(gate->regmap, XRT_AXIGATE_READ_REG, &val);
> +	if (ret) {
> +		xrt_err(gate->pdev, "read gate failed %d", ret);
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
> +		xrt_err(gate->pdev, "write 2 failed %d", ret);
> +		return ret;
> +	}
> +	ndelay(XRT_AXIGATE_INTERVAL);
> +	/*
> +	 * Legacy hardware requires extra read work properly.
> +	 * This is not on critical path, thus the extra read should not impact performance much.
> +	 */
> +	ret = regmap_read(gate->regmap, XRT_AXIGATE_READ_REG, &val);
> +	if (ret) {
> +		xrt_err(gate->pdev, "read 2 failed %d", ret);
> +		return ret;
> +	}
> +	ret = regmap_write(gate->regmap, XRT_AXIGATE_WRITE_REG,
> +			   XRT_AXIGATE_CTRL_OPEN_BIT0 | XRT_AXIGATE_CTRL_OPEN_BIT1);
> +	if (ret) {
> +		xrt_err(gate->pdev, "write 3 failed %d", ret);
> +		return ret;
> +	}
> +	ndelay(XRT_AXIGATE_INTERVAL);
> +	ret = regmap_read(gate->regmap, XRT_AXIGATE_READ_REG, &val);
> +	if (ret) {
> +		xrt_err(gate->pdev, "read 3 failed %d", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int xrt_axigate_epname_idx(struct platform_device *pdev)
> +{
> +	struct resource	*res;
> +	int ret, i;
ok
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		xrt_err(pdev, "Empty Resource!");
> +		return -EINVAL;
> +	}
> +
> +	for (i = 0; i < ARRAY_SIZE(xrt_axigate_epnames); i++) {
ok
> +		ret = strncmp(xrt_axigate_epnames[i], res->name,
> +			      strlen(xrt_axigate_epnames[i]) + 1);
ok
> +		if (!ret)
> +			return i;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int xrt_axigate_close(struct platform_device *pdev)
> +{
> +	struct xrt_axigate *gate;
> +	u32 status = 0;
> +	int ret;
> +
> +	gate = platform_get_drvdata(pdev);
> +
> +	mutex_lock(&gate->gate_lock);
> +	ret = regmap_read(gate->regmap, XRT_AXIGATE_READ_REG, &status);
> +	if (ret) {
> +		xrt_err(pdev, "read gate failed %d", ret);
> +		goto failed;
> +	}
> +	if (status) {		/* gate is opened */
> +		xleaf_broadcast_event(pdev, XRT_EVENT_PRE_GATE_CLOSE, false);
> +		ret = close_gate(gate);
ok
> +		if (ret)
> +			goto failed;
> +	}
> +
> +	gate->gate_closed = true;
ok
> +
> +failed:
> +	mutex_unlock(&gate->gate_lock);
> +
> +	xrt_info(pdev, "close gate %s", gate->ep_name);
> +	return ret;
> +}
> +
> +static int xrt_axigate_open(struct platform_device *pdev)
> +{
> +	struct xrt_axigate *gate;
> +	u32 status;
> +	int ret;
> +
> +	gate = platform_get_drvdata(pdev);
> +
> +	mutex_lock(&gate->gate_lock);
> +	ret = regmap_read(gate->regmap, XRT_AXIGATE_READ_REG, &status);
> +	if (ret) {
> +		xrt_err(pdev, "read gate failed %d", ret);
> +		goto failed;
> +	}
> +	if (!status) {		/* gate is closed */
> +		ret = open_gate(gate);
> +		if (ret)
> +			goto failed;
> +		xleaf_broadcast_event(pdev, XRT_EVENT_POST_GATE_OPEN, true);
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
> +	xrt_info(pdev, "open gate %s", gate->ep_name);
> +	return ret;
> +}
> +
> +static void xrt_axigate_event_cb(struct platform_device *pdev, void *arg)
> +{
> +	struct xrt_axigate *gate = platform_get_drvdata(pdev);
> +	struct xrt_event *evt = (struct xrt_event *)arg;
> +	enum xrt_events e = evt->xe_evt;
> +	struct platform_device *leaf;
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
ok
> +
> +	leaf = xleaf_get_leaf_by_id(pdev, id, instance);
> +	if (!leaf)
> +		return;
> +
> +	res = platform_get_resource(leaf, IORESOURCE_MEM, 0);
> +	if (!res || !strncmp(res->name, gate->ep_name, strlen(res->name) + 1)) {
> +		xleaf_put_leaf(pdev, leaf);
> +		return;
> +	}
> +
> +	/* higher level axigate instance created, make sure the gate is opened. */

ok

only minor ws issue, otherwise good to go

Reviewed-by: Tom Rix <trix@redhat.com>

> +	if (xrt_axigate_epname_idx(leaf) > xrt_axigate_epname_idx(pdev))
> +		xrt_axigate_open(pdev);
> +	else
> +		xleaf_call(leaf, XRT_AXIGATE_OPEN, NULL);
> +
> +	xleaf_put_leaf(pdev, leaf);
> +}
> +
> +static int
> +xrt_axigate_leaf_call(struct platform_device *pdev, u32 cmd, void *arg)
> +{
> +	int ret = 0;
> +
> +	switch (cmd) {
> +	case XRT_XLEAF_EVENT:
> +		xrt_axigate_event_cb(pdev, arg);
> +		break;
> +	case XRT_AXIGATE_CLOSE:
> +		ret = xrt_axigate_close(pdev);
> +		break;
> +	case XRT_AXIGATE_OPEN:
> +		ret = xrt_axigate_open(pdev);
> +		break;
> +	default:
> +		xrt_err(pdev, "unsupported cmd %d", cmd);
> +		return -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +static int xrt_axigate_probe(struct platform_device *pdev)
> +{
> +	struct xrt_axigate *gate = NULL;
> +	void __iomem *base = NULL;
> +	struct resource *res;
> +	int ret;
> +
> +	gate = devm_kzalloc(&pdev->dev, sizeof(*gate), GFP_KERNEL);
> +	if (!gate)
> +		return -ENOMEM;
> +
> +	gate->pdev = pdev;
> +	platform_set_drvdata(pdev, gate);
> +
> +	xrt_info(pdev, "probing...");
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		xrt_err(pdev, "Empty resource 0");
> +		ret = -EINVAL;
> +		goto failed;
> +	}
> +
> +	base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(base)) {
> +		xrt_err(pdev, "map base iomem failed");
> +		ret = PTR_ERR(base);
> +		goto failed;
> +	}
> +
> +	gate->regmap = devm_regmap_init_mmio(&pdev->dev, base, &axigate_regmap_config);
> +	if (IS_ERR(gate->regmap)) {
> +		xrt_err(pdev, "regmap %pR failed", res);
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
> +static struct xrt_subdev_endpoints xrt_axigate_endpoints[] = {
> +	{
> +		.xse_names = (struct xrt_subdev_ep_names[]) {
> +			{ .ep_name = XRT_MD_NODE_GATE_ULP },
> +			{ NULL },
> +		},
> +		.xse_min_ep = 1,
> +	},
> +	{
> +		.xse_names = (struct xrt_subdev_ep_names[]) {
> +			{ .ep_name = XRT_MD_NODE_GATE_PLP },
> +			{ NULL },
> +		},
> +		.xse_min_ep = 1,
> +	},
> +	{ 0 },
> +};
> +
> +static struct xrt_subdev_drvdata xrt_axigate_data = {
> +	.xsd_dev_ops = {
> +		.xsd_leaf_call = xrt_axigate_leaf_call,
> +	},
> +};
> +
> +static const struct platform_device_id xrt_axigate_table[] = {
> +	{ XRT_AXIGATE, (kernel_ulong_t)&xrt_axigate_data },
> +	{ },
> +};
> +
> +static struct platform_driver xrt_axigate_driver = {
> +	.driver = {
> +		.name = XRT_AXIGATE,
> +	},
> +	.probe = xrt_axigate_probe,
> +	.id_table = xrt_axigate_table,
> +};
> +
> +XRT_LEAF_INIT_FINI_FUNC(XRT_SUBDEV_AXIGATE, axigate);


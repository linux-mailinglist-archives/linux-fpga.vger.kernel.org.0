Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29E4532FB7C
	for <lists+linux-fpga@lfdr.de>; Sat,  6 Mar 2021 16:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbhCFPy5 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 6 Mar 2021 10:54:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36770 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230216AbhCFPyz (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 6 Mar 2021 10:54:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615046094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YLgTC5xuRtEJoWFeLL0Al3QRdT5Bosciz4GMHZ864Iw=;
        b=OUM3UOd7bMqgZCjzd/uiRJ3QdbL4bhVu9i+/Phe2hhGX05ATdU0ItbPUQ+RGySssoPnwG9
        cZ1ZC1SN9IjzzwpzhL6h8IK40fDh5ETu25/s/HinxBnXCW1wuArim/jtU5Zw1hy8P49uYQ
        QU0fYmz5LyPmAsZo5Vd3WOqAAOwHagA=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-413-kWZEnqhzO06AD24yDCfOxQ-1; Sat, 06 Mar 2021 10:54:52 -0500
X-MC-Unique: kWZEnqhzO06AD24yDCfOxQ-1
Received: by mail-qt1-f199.google.com with SMTP id i2so4444820qtd.4
        for <linux-fpga@vger.kernel.org>; Sat, 06 Mar 2021 07:54:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=YLgTC5xuRtEJoWFeLL0Al3QRdT5Bosciz4GMHZ864Iw=;
        b=bM5i9aLhQLvA1ixPjzvbjcTj98pcQDp/TOzRs0YlJIyb7sALa2jaUEwIgNFxuaIf9e
         rF9Ni6leKZEXuGD/YBU7mqlhva/Dgsg6md3om7xuSAkZ9loK3MaNH05Q9lFwX96CJ8XS
         8JY3AM6bOSbX8z1ln7JOcyGzw2IEJLKvoFhx6Q6lHVGPjMvh1pKHa4tNwGmbsBi9Shkg
         1ngjZQgw4Z2NxFN5EBhMa7sOgnjdSS757BjsLz264ml4+g2kS7rA7F8+yOhZVqpBjlT+
         zHQ7r4HbxvfnbdzSZeIkLCuhGGpdV/E9KCFh/X6SXywr21LbHnuCMZvSm/Apqqhu1BKF
         AVYQ==
X-Gm-Message-State: AOAM531uCq0ZN5BRfVfaHBPEfcAcIHNiMv7agQ74yljwJ5qcLUAv/WZW
        qdzJZkZ68sfEWmfA3ZQoBYyb/kvz28SS7wEryjCza9OPCzX3D5oerqMuJiRyizFvV+bQPQ/usnd
        P7+oA6L4KQULlhYZCVMWBIw==
X-Received: by 2002:a37:4986:: with SMTP id w128mr13417969qka.313.1615046092130;
        Sat, 06 Mar 2021 07:54:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzyLTrFOQONvwDTS1rBfmKz8RbkWm9STaMvLOWehDw2QzE7KpMqyZdcIsSYwSHcEdi0UdRfcA==
X-Received: by 2002:a37:4986:: with SMTP id w128mr13417959qka.313.1615046091884;
        Sat, 06 Mar 2021 07:54:51 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id z11sm4182354qkg.52.2021.03.06.07.54.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Mar 2021 07:54:51 -0800 (PST)
Subject: Re: [PATCH V3 XRT Alveo 17/18] fpga: xrt: partition isolation
 platform driver
To:     Lizhi Hou <lizhi.hou@xilinx.com>, linux-kernel@vger.kernel.org
Cc:     Lizhi Hou <lizhih@xilinx.com>, linux-fpga@vger.kernel.org,
        maxz@xilinx.com, sonal.santan@xilinx.com, michal.simek@xilinx.com,
        stefanos@xilinx.com, devicetree@vger.kernel.org, mdf@kernel.org,
        robh@kernel.org, Max Zhen <max.zhen@xilinx.com>
References: <20210218064019.29189-1-lizhih@xilinx.com>
 <20210218064019.29189-18-lizhih@xilinx.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <74def489-0a25-f90a-a00c-9d79dcbaf25a@redhat.com>
Date:   Sat, 6 Mar 2021 07:54:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210218064019.29189-18-lizhih@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 2/17/21 10:40 PM, Lizhi Hou wrote:
> Add partition isolation platform driver. partition isolation is
> a hardware function discovered by walking firmware metadata.
> A platform device node will be created for it. Partition isolation
> function isolate the different fpga regions
>
> Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
> Signed-off-by: Max Zhen <max.zhen@xilinx.com>
> Signed-off-by: Lizhi Hou <lizhih@xilinx.com>
> ---
>  drivers/fpga/xrt/include/xleaf/axigate.h |  25 ++
>  drivers/fpga/xrt/lib/xleaf/axigate.c     | 298 +++++++++++++++++++++++
>  2 files changed, 323 insertions(+)
>  create mode 100644 drivers/fpga/xrt/include/xleaf/axigate.h
>  create mode 100644 drivers/fpga/xrt/lib/xleaf/axigate.c
>
> diff --git a/drivers/fpga/xrt/include/xleaf/axigate.h b/drivers/fpga/xrt/include/xleaf/axigate.h
> new file mode 100644
> index 000000000000..2cef71e13b30
> --- /dev/null
> +++ b/drivers/fpga/xrt/include/xleaf/axigate.h
> @@ -0,0 +1,25 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Header file for XRT Axigate Leaf Driver
> + *
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
> + * AXIGATE driver IOCTL calls.
> + */
> +enum xrt_axigate_ioctl_cmd {
> +	XRT_AXIGATE_FREEZE = XRT_XLEAF_CUSTOM_BASE, /* See comments in xleaf.h */
> +	XRT_AXIGATE_FREE,
These are substrings, could change suffix to make it harder for developer to mix up.
> +};
> +
> +#endif	/* _XRT_AXIGATE_H_ */
> diff --git a/drivers/fpga/xrt/lib/xleaf/axigate.c b/drivers/fpga/xrt/lib/xleaf/axigate.c
> new file mode 100644
> index 000000000000..382969f9925f
> --- /dev/null
> +++ b/drivers/fpga/xrt/lib/xleaf/axigate.c
> @@ -0,0 +1,298 @@
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
> +#include <linux/io.h>
> +#include "metadata.h"
> +#include "xleaf.h"
> +#include "xleaf/axigate.h"
> +
> +#define XRT_AXIGATE "xrt_axigate"
> +
> +struct axigate_regs {
> +	u32		iag_wr;
> +	u32		iag_rvsd;
> +	u32		iag_rd;
> +} __packed;
similar to other patches, prefix of element is not needed.
> +
> +struct xrt_axigate {
> +	struct platform_device	*pdev;
> +	void			*base;
> +	struct mutex		gate_lock; /* gate dev lock */
> +
> +	void			*evt_hdl;
> +	const char		*ep_name;
> +
> +	bool			gate_freezed;
> +};
> +
> +/* the ep names are in the order of hardware layers */
> +static const char * const xrt_axigate_epnames[] = {
> +	XRT_MD_NODE_GATE_PLP,
> +	XRT_MD_NODE_GATE_ULP,
what are plp, ulp ? it is helpful to comment or expand acronyms
> +	NULL
> +};
> +
> +#define reg_rd(g, r)						\
> +	ioread32((void *)(g)->base + offsetof(struct axigate_regs, r))
> +#define reg_wr(g, v, r)						\
> +	iowrite32(v, (void *)(g)->base + offsetof(struct axigate_regs, r))
> +
> +static inline void freeze_gate(struct xrt_axigate *gate)
> +{
> +	reg_wr(gate, 0, iag_wr);
The values written here and below are magic, the need to have #defines
> +	ndelay(500);
> +	reg_rd(gate, iag_rd);
> +}
> +
> +static inline void free_gate(struct xrt_axigate *gate)
> +{
> +	reg_wr(gate, 0x2, iag_wr);
> +	ndelay(500);
> +	(void)reg_rd(gate, iag_rd);
> +	reg_wr(gate, 0x3, iag_wr);
> +	ndelay(500);
> +	reg_rd(gate, iag_rd);
> +}
> +
> +static int xrt_axigate_epname_idx(struct platform_device *pdev)
> +{
> +	int			i;
> +	int			ret;
int i, ret;
> +	struct resource		*res;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		xrt_err(pdev, "Empty Resource!");
> +		return -EINVAL;
> +	}
> +
> +	for (i = 0; xrt_axigate_epnames[i]; i++) {

null guarded array is useful with the size isn't know,

in this case it is, so covert loop to using ARRAY_SIZE

> +		ret = strncmp(xrt_axigate_epnames[i], res->name,
> +			      strlen(xrt_axigate_epnames[i]) + 1);
needs a strlen check in case res->name is just a substring
> +		if (!ret)
> +			break;
> +	}
> +
> +	ret = (xrt_axigate_epnames[i]) ? i : -EINVAL;
> +	return ret;
> +}
> +
> +static void xrt_axigate_freeze(struct platform_device *pdev)
> +{
> +	struct xrt_axigate	*gate;
> +	u32			freeze = 0;
> +
> +	gate = platform_get_drvdata(pdev);
> +
> +	mutex_lock(&gate->gate_lock);
> +	freeze = reg_rd(gate, iag_rd);
> +	if (freeze) {		/* gate is opened */
> +		xleaf_broadcast_event(pdev, XRT_EVENT_PRE_GATE_CLOSE, false);
> +		freeze_gate(gate);
> +	}
> +
> +	gate->gate_freezed = true;
Looks like freeze could be 0, so is setting gate_freeze = true correct all the time ?
> +	mutex_unlock(&gate->gate_lock);
> +
> +	xrt_info(pdev, "freeze gate %s", gate->ep_name);
> +}
> +
> +static void xrt_axigate_free(struct platform_device *pdev)
> +{
> +	struct xrt_axigate	*gate;
> +	u32			freeze;
> +
> +	gate = platform_get_drvdata(pdev);
> +
> +	mutex_lock(&gate->gate_lock);
> +	freeze = reg_rd(gate, iag_rd);
> +	if (!freeze) {		/* gate is closed */
> +		free_gate(gate);
> +		xleaf_broadcast_event(pdev, XRT_EVENT_POST_GATE_OPEN, true);
> +		/* xrt_axigate_free() could be called in event cb, thus
> +		 * we can not wait for the completes
> +		 */
> +	}
> +
> +	gate->gate_freezed = false;
freezed is not a word, the element name should be 'gate_frozen'
> +	mutex_unlock(&gate->gate_lock);
> +
> +	xrt_info(pdev, "free gate %s", gate->ep_name);
> +}
> +
> +static void xrt_axigate_event_cb(struct platform_device *pdev, void *arg)
> +{
> +	struct platform_device *leaf;
> +	struct xrt_event *evt = (struct xrt_event *)arg;
> +	enum xrt_events e = evt->xe_evt;
> +	enum xrt_subdev_id id = evt->xe_subdev.xevt_subdev_id;
> +	int instance = evt->xe_subdev.xevt_subdev_instance;
> +	struct xrt_axigate *gate = platform_get_drvdata(pdev);
> +	struct resource	*res;
> +
> +	switch (e) {
> +	case XRT_EVENT_POST_CREATION:
> +		break;
> +	default:
> +		return;
> +	}
convert switch() to if ()
> +
> +	if (id != XRT_SUBDEV_AXIGATE)
> +		return;
> +
> +	leaf = xleaf_get_leaf_by_id(pdev, id, instance);
> +	if (!leaf)
> +		return;
> +
> +	res = platform_get_resource(leaf, IORESOURCE_MEM, 0);
> +	if (!res || !strncmp(res->name, gate->ep_name, strlen(res->name) + 1)) {
> +		(void)xleaf_put_leaf(pdev, leaf);
> +		return;
> +	}
> +
> +	/*
> +	 * higher level axigate instance created,
> +	 * make sure the gate is openned. This covers 1RP flow which

is openned -> is opened

what is 1RP ?

Tom

> +	 * has plp gate as well.
> +	 */
> +	if (xrt_axigate_epname_idx(leaf) > xrt_axigate_epname_idx(pdev))
> +		xrt_axigate_free(pdev);
> +	else
> +		xleaf_ioctl(leaf, XRT_AXIGATE_FREE, NULL);
> +
> +	(void)xleaf_put_leaf(pdev, leaf);
> +}
> +
> +static int
> +xrt_axigate_leaf_ioctl(struct platform_device *pdev, u32 cmd, void *arg)
> +{
> +	switch (cmd) {
> +	case XRT_XLEAF_EVENT:
> +		xrt_axigate_event_cb(pdev, arg);
> +		break;
> +	case XRT_AXIGATE_FREEZE:
> +		xrt_axigate_freeze(pdev);
> +		break;
> +	case XRT_AXIGATE_FREE:
> +		xrt_axigate_free(pdev);
> +		break;
> +	default:
> +		xrt_err(pdev, "unsupported cmd %d", cmd);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int xrt_axigate_remove(struct platform_device *pdev)
> +{
> +	struct xrt_axigate	*gate;
> +
> +	gate = platform_get_drvdata(pdev);
> +
> +	if (gate->base)
> +		iounmap(gate->base);
> +
> +	platform_set_drvdata(pdev, NULL);
> +	devm_kfree(&pdev->dev, gate);
> +
> +	return 0;
> +}
> +
> +static int xrt_axigate_probe(struct platform_device *pdev)
> +{
> +	struct xrt_axigate	*gate;
> +	struct resource		*res;
> +	int			ret;
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
> +	gate->base = ioremap(res->start, res->end - res->start + 1);
> +	if (!gate->base) {
> +		xrt_err(pdev, "map base iomem failed");
> +		ret = -EFAULT;
> +		goto failed;
> +	}
> +
> +	gate->ep_name = res->name;
> +
> +	mutex_init(&gate->gate_lock);
> +
> +	return 0;
> +
> +failed:
> +	xrt_axigate_remove(pdev);
> +	return ret;
> +}
> +
> +static struct xrt_subdev_endpoints xrt_axigate_endpoints[] = {
> +	{
> +		.xse_names = (struct xrt_subdev_ep_names[]) {
> +			{ .ep_name = "ep_pr_isolate_ulp_00" },
> +			{ NULL },
> +		},
> +		.xse_min_ep = 1,
> +	},
> +	{
> +		.xse_names = (struct xrt_subdev_ep_names[]) {
> +			{ .ep_name = "ep_pr_isolate_plp_00" },
> +			{ NULL },
> +		},
> +		.xse_min_ep = 1,
> +	},
> +	{ 0 },
> +};
> +
> +static struct xrt_subdev_drvdata xrt_axigate_data = {
> +	.xsd_dev_ops = {
> +		.xsd_ioctl = xrt_axigate_leaf_ioctl,
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
> +	.remove = xrt_axigate_remove,
> +	.id_table = xrt_axigate_table,
> +};
> +
> +void axigate_leaf_init_fini(bool init)
> +{
> +	if (init) {
> +		xleaf_register_driver(XRT_SUBDEV_AXIGATE,
> +				      &xrt_axigate_driver, xrt_axigate_endpoints);
> +	} else {
> +		xleaf_unregister_driver(XRT_SUBDEV_AXIGATE);
> +	}
> +}


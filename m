Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72860320DA1
	for <lists+linux-fpga@lfdr.de>; Sun, 21 Feb 2021 21:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbhBUUgv (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 21 Feb 2021 15:36:51 -0500
Received: from mail-pg1-f178.google.com ([209.85.215.178]:33619 "EHLO
        mail-pg1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbhBUUgu (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 21 Feb 2021 15:36:50 -0500
Received: by mail-pg1-f178.google.com with SMTP id z68so8861417pgz.0;
        Sun, 21 Feb 2021 12:36:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vHCEZBQ8Zwww1dLO0CiH24OH/UIaB4jYs9CkhxB9x3c=;
        b=ZAogPoDXl8g4cs3/0tREXcuyXcrrrDBmjs23iYNBpeV83HlhPJma2Dn0HnP9SbmIgu
         V2FgVaq1kF8nG8qO0oIWNwZQ+dm1RvtOHaqkBvCaoRFgVOAgm2V3d2rXVL4FXUwHwL6C
         gxDEE9Oj19E3euCju7TIa08PQurFf95MqYIx1VhImc2U7e6Ff0IMMh9/rKZ1GOtWha6N
         3tD8KaOr94RbWB3tMo43bwjxjjgp8bQE9O9VcsPsL+8AWUYh6Q/lMTlGypBDbE23z1oe
         bTKeARW1yXPZ40WKUIpF69Oqp/pidlqL5qNeDrkJdUIf6aBOi5UDGm//a4r3e5wyUNyd
         hPPA==
X-Gm-Message-State: AOAM533AHv68raMmTLRUHc9jy3ILFccGcdGvTTGpOD8A6ieRcFBP5JJX
        0BIbMtjAvcZrIfqFQZ5hm0E=
X-Google-Smtp-Source: ABdhPJxTZ62R6dxwkrfhBHDsVmU6ehjh8fBmM6l0NDGMufzuu7Gm4Cx3scy7PadyiBZ61wa430lhEg==
X-Received: by 2002:a63:2306:: with SMTP id j6mr17219954pgj.187.1613939769551;
        Sun, 21 Feb 2021 12:36:09 -0800 (PST)
Received: from localhost ([2601:647:5b00:1162:1ac0:17a6:4cc6:d1ef])
        by smtp.gmail.com with ESMTPSA id y123sm9484519pfb.122.2021.02.21.12.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Feb 2021 12:36:08 -0800 (PST)
Date:   Sun, 21 Feb 2021 12:36:11 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     Lizhi Hou <lizhi.hou@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, Lizhi Hou <lizhih@xilinx.com>,
        linux-fpga@vger.kernel.org, maxz@xilinx.com,
        sonal.santan@xilinx.com, michal.simek@xilinx.com,
        stefanos@xilinx.com, devicetree@vger.kernel.org, trix@redhat.com,
        mdf@kernel.org, robh@kernel.org, Max Zhen <max.zhen@xilinx.com>
Subject: Re: [PATCH V3 XRT Alveo 17/18] fpga: xrt: partition isolation
 platform driver
Message-ID: <YDLEO6Bg6ySSoupI@archbook>
References: <20210218064019.29189-1-lizhih@xilinx.com>
 <20210218064019.29189-18-lizhih@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210218064019.29189-18-lizhih@xilinx.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, Feb 17, 2021 at 10:40:18PM -0800, Lizhi Hou wrote:
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

Just make them #defines, even more so if there are only 3 of them.
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
> +	ndelay(500);
> +	reg_rd(gate, iag_rd);
> +}
> +
> +static inline void free_gate(struct xrt_axigate *gate)
> +{
> +	reg_wr(gate, 0x2, iag_wr);
> +	ndelay(500);
Magic constants?
> +	(void)reg_rd(gate, iag_rd);
At the very least add a comment on why? Is this for PCI synchronization
reasons?

> +	reg_wr(gate, 0x3, iag_wr);
> +	ndelay(500);
Magic constants?
> +	reg_rd(gate, iag_rd);
Does it nead a (void) or not? Be consistent, again, why do we read here
at all?
> +}
> +
> +static int xrt_axigate_epname_idx(struct platform_device *pdev)
> +{
> +	int			i;
> +	int			ret;
> +	struct resource		*res;
Nope. Indents:

struct resource *res;
int, i, ret;

> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		xrt_err(pdev, "Empty Resource!");
> +		return -EINVAL;
> +	}
> +
> +	for (i = 0; xrt_axigate_epnames[i]; i++) {
> +		ret = strncmp(xrt_axigate_epnames[i], res->name,
> +			      strlen(xrt_axigate_epnames[i]) + 1);
> +		if (!ret)
> +			break;
> +	}
> +
> +	ret = (xrt_axigate_epnames[i]) ? i : -EINVAL;
Why not just:

	if (xrt_axigate_epnames[i])
		return i;

	return -EINVAL;
> +	return ret;
> +}
> +
> +static void xrt_axigate_freeze(struct platform_device *pdev)
> +{
> +	struct xrt_axigate	*gate;
> +	u32			freeze = 0;
Indents. Fix everywhere.
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
s/freezed/frozen
> +	mutex_unlock(&gate->gate_lock);
> +
> +	xrt_info(pdev, "freeze gate %s", gate->ep_name);
debug?
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
Reverse x-mas tree;
xxxxxxxxxx
xxxxxxxxx
xxxxxxxx
xxxxxx
> +
> +	switch (e) {
> +	case XRT_EVENT_POST_CREATION:
> +		break;
> +	default:
> +		return;
> +	}
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
No! The point of using devres is so cleanup happens on removal.
While you're at it, if you move the ioremap to a devres version, this
function can basically go away entirely.
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

This thing is duplicated in every file, maybe a macro would be an idea.
> -- 
> 2.18.4
> 

- Moritz

Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43B3F6BE438
	for <lists+linux-fpga@lfdr.de>; Fri, 17 Mar 2023 09:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbjCQIpb (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 17 Mar 2023 04:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbjCQIox (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 17 Mar 2023 04:44:53 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F36ED3B64E;
        Fri, 17 Mar 2023 01:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679042632; x=1710578632;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+BPhXMysi6zfuQEz41gB1kolf7E+GWAU3NvU90oXPgQ=;
  b=XL9fLnKekYvWA/U9CY4Tm/uGQGivGmJRbKWne95wEb88JCc0CDGPI1mJ
   SoYIaSB5x4kqgJdVi3IFlXKZgYiYV14QHydk6xR5vVF0XKFe+Ih9su50/
   mfxgUfAg8FN+kw8REQjroCHBk90NrRi7m4f7tWXQftBy3yZBiKjsuIXuX
   ji89Mda9E7fYYidOf7Qikgw0bSmW378My9hB5XZrUXGZlKVLJSZ90lO9x
   WGClklq96IEV86di9YPQ4fmqxtMzLBOXQdyBvSRfMStkFn6r80vViLqVo
   U92Ey8KDSLmh3DKa6d94DyQRroIVYTZfuHb1dsIrmOG1okktL7dJOOO6i
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="400792925"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="400792925"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 01:43:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10651"; a="804041146"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="804041146"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga004.jf.intel.com with ESMTP; 17 Mar 2023 01:43:49 -0700
Date:   Fri, 17 Mar 2023 16:32:29 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Marco Pagani <marpagan@redhat.com>
Cc:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: Re: [RFC PATCH v2 2/4] fpga: add fake FPGA bridge
Message-ID: <ZBQlnUQWZHJ+ZBu5@yilunxu-OptiPlex-7050>
References: <20230310170412.708363-1-marpagan@redhat.com>
 <20230310170412.708363-3-marpagan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310170412.708363-3-marpagan@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2023-03-10 at 18:04:10 +0100, Marco Pagani wrote:
> Add fake FPGA bridge driver with support functions. The driver includes
> a counter for the number of switching cycles. This module is part of
> the KUnit tests for the FPGA subsystem.
> 
> Signed-off-by: Marco Pagani <marpagan@redhat.com>
> ---
>  drivers/fpga/tests/fake-fpga-bridge.c | 228 ++++++++++++++++++++++++++
>  drivers/fpga/tests/fake-fpga-bridge.h |  36 ++++
>  2 files changed, 264 insertions(+)
>  create mode 100644 drivers/fpga/tests/fake-fpga-bridge.c
>  create mode 100644 drivers/fpga/tests/fake-fpga-bridge.h
> 
> diff --git a/drivers/fpga/tests/fake-fpga-bridge.c b/drivers/fpga/tests/fake-fpga-bridge.c
> new file mode 100644
> index 000000000000..8a2f64fc1bbb
> --- /dev/null
> +++ b/drivers/fpga/tests/fake-fpga-bridge.c
> @@ -0,0 +1,228 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Driver for the fake FPGA bridge
> + *
> + * Copyright (C) 2023 Red Hat, Inc.
> + *
> + * Author: Marco Pagani <marpagan@redhat.com>
> + */
> +
> +#include <linux/types.h>
> +#include <linux/device.h>
> +#include <linux/platform_device.h>
> +#include <linux/fpga/fpga-bridge.h>
> +#include <kunit/test.h>
> +
> +#include "fake-fpga-bridge.h"
> +
> +#define FAKE_FPGA_BRIDGE_DEV_NAME	"fake_fpga_bridge"
> +
> +struct fake_bridge_priv {
> +	int id;
> +	bool enable;
> +	int cycles_count;
> +	struct kunit *test;
> +};
> +
> +struct fake_bridge_data {
> +	struct kunit *test;
> +};
> +
> +static int op_enable_show(struct fpga_bridge *bridge)
> +{
> +	struct fake_bridge_priv *priv;
> +
> +	priv = bridge->priv;
> +
> +	if (priv->test)
> +		kunit_info(priv->test, "Fake FPGA bridge %d: enable_show\n",
> +			   priv->id);

Why check the kunit pointer every time? I remember you mentioned that
the fake fpga modules are expected to be used out of Kunit test, so the
priv->test may be NULL? I suggest you work on these usecases in separate
patchsets. For now just check priv->test on probe is fine.

> +
> +	return priv->enable;
> +}
> +
> +static int op_enable_set(struct fpga_bridge *bridge, bool enable)
> +{
> +	struct fake_bridge_priv *priv;
> +
> +	priv = bridge->priv;
> +
> +	if (enable && !priv->enable)
> +		priv->cycles_count++;
> +
> +	priv->enable = enable;
> +
> +	if (priv->test)
> +		kunit_info(priv->test, "Fake FPGA bridge %d: enable_set: %d\n",
> +			   priv->id, enable);
> +
> +	return 0;
> +}
> +
> +static void op_remove(struct fpga_bridge *bridge)
> +{
> +	struct fake_bridge_priv *priv;
> +
> +	priv = bridge->priv;
> +
> +	if (priv->test)
> +		kunit_info(priv->test, "Fake FPGA bridge: remove\n");
> +}
> +
> +static const struct fpga_bridge_ops fake_fpga_bridge_ops = {
> +	.enable_show = op_enable_show,
> +	.enable_set = op_enable_set,
> +	.fpga_bridge_remove = op_remove,
> +};
> +
> +/**
> + * fake_fpga_bridge_register() - register a fake FPGA bridge.
> + * @bridge_ctx: fake FPGA bridge context data structure.
> + * @parent: parent device.
> + * @test: KUnit test context object.
> + *
> + * Return: 0 if registration succeeded, an error code otherwise.
> + */
> +int fake_fpga_bridge_register(struct fake_fpga_bridge *bridge_ctx,
> +			      struct device *parent, struct kunit *test)

struct fake_fpga_bridge *fake_fpga_bridge_register(struct device *parent, ...)

Is it better?

Thanks,
Yilun

> +{
> +	struct fake_bridge_data pdata;
> +	struct fake_bridge_priv *priv;
> +	int ret;
> +
> +	pdata.test = test;
> +
> +	bridge_ctx->pdev = platform_device_alloc(FAKE_FPGA_BRIDGE_DEV_NAME,
> +						 PLATFORM_DEVID_AUTO);
> +	if (IS_ERR(bridge_ctx->pdev)) {
> +		pr_err("Fake FPGA bridge device allocation failed\n");
> +		return -ENOMEM;
> +	}
> +
> +	bridge_ctx->pdev->dev.parent = parent;
> +	platform_device_add_data(bridge_ctx->pdev, &pdata, sizeof(pdata));
> +
> +	ret = platform_device_add(bridge_ctx->pdev);
> +	if (ret) {
> +		pr_err("Fake FPGA bridge device add failed\n");
> +		platform_device_put(bridge_ctx->pdev);
> +		return ret;
> +	}
> +
> +	bridge_ctx->bridge = platform_get_drvdata(bridge_ctx->pdev);
> +
> +	if (test) {
> +		priv = bridge_ctx->bridge->priv;
> +		kunit_info(test, "Fake FPGA bridge %d registered\n", priv->id);
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(fake_fpga_bridge_register);
> +
> +/**
> + * fake_fpga_bridge_unregister() - unregister a fake FPGA bridge.
> + * @bridge_ctx: fake FPGA bridge context data structure.
> + */
> +void fake_fpga_bridge_unregister(struct fake_fpga_bridge *bridge_ctx)
> +{
> +	struct fake_bridge_priv *priv;
> +	struct kunit *test;
> +	int id;
> +
> +	if (!bridge_ctx)
> +		return;
> +
> +	priv = bridge_ctx->bridge->priv;
> +	test = priv->test;
> +	id = priv->id;
> +
> +	if (bridge_ctx->pdev) {
> +		platform_device_unregister(bridge_ctx->pdev);
> +		if (test)
> +			kunit_info(test, "Fake FPGA bridge %d unregistered\n", id);
> +	}
> +}
> +EXPORT_SYMBOL_GPL(fake_fpga_bridge_unregister);
> +
> +/**
> + * fake_fpga_bridge_get_state() - get state of a fake FPGA bridge.
> + * @bridge_ctx: fake FPGA bridge context data structure.
> + *
> + * Return: 1 if the bridge is enabled, 0 if disabled.
> + */
> +int fake_fpga_bridge_get_state(const struct fake_fpga_bridge *bridge_ctx)
> +{
> +	return bridge_ctx->bridge->br_ops->enable_show(bridge_ctx->bridge);
> +}
> +EXPORT_SYMBOL_GPL(fake_fpga_bridge_get_state);
> +
> +/**
> + * fake_fpga_bridge_get_cycles_count() - get the number of switching cycles.
> + * @bridge_ctx: fake FPGA bridge context data structure.
> + *
> + * Return: number of switching cycles.
> + */
> +int fake_fpga_bridge_get_cycles_count(const struct fake_fpga_bridge *bridge_ctx)
> +{
> +	struct fake_bridge_priv *priv;
> +
> +	priv = bridge_ctx->bridge->priv;
> +
> +	return priv->cycles_count;
> +}
> +EXPORT_SYMBOL_GPL(fake_fpga_bridge_get_cycles_count);
> +
> +static int fake_fpga_bridge_probe(struct platform_device *pdev)
> +{
> +	struct device *dev;
> +	struct fpga_bridge *bridge;
> +	struct fake_bridge_data *pdata;
> +	struct fake_bridge_priv *priv;
> +	static int id_count;
> +
> +	dev = &pdev->dev;
> +	pdata = dev_get_platdata(dev);
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->id = id_count++;
> +	priv->enable = true;
> +
> +	if (pdata)
> +		priv->test = pdata->test;
> +
> +	bridge = fpga_bridge_register(dev, "Fake FPGA Bridge",
> +				      &fake_fpga_bridge_ops, priv);
> +	if (IS_ERR(bridge))
> +		return PTR_ERR(bridge);
> +
> +	platform_set_drvdata(pdev, bridge);
> +
> +	return 0;
> +}
> +
> +static int fake_fpga_bridge_remove(struct platform_device *pdev)
> +{
> +	struct fpga_bridge *bridge = platform_get_drvdata(pdev);
> +
> +	fpga_bridge_unregister(bridge);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver fake_fpga_bridge_drv = {
> +	.driver = {
> +		.name = FAKE_FPGA_BRIDGE_DEV_NAME
> +	},
> +	.probe = fake_fpga_bridge_probe,
> +	.remove = fake_fpga_bridge_remove,
> +};
> +
> +module_platform_driver(fake_fpga_bridge_drv);
> +
> +MODULE_AUTHOR("Marco Pagani <marpagan@redhat.com>");
> +MODULE_DESCRIPTION("Fake FPGA Bridge");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/fpga/tests/fake-fpga-bridge.h b/drivers/fpga/tests/fake-fpga-bridge.h
> new file mode 100644
> index 000000000000..ae224b13f284
> --- /dev/null
> +++ b/drivers/fpga/tests/fake-fpga-bridge.h
> @@ -0,0 +1,36 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Header file for the fake FPGA bridge
> + *
> + * Copyright (C) 2023 Red Hat, Inc.
> + *
> + * Author: Marco Pagani <marpagan@redhat.com>
> + */
> +
> +#ifndef __FPGA_FAKE_BRIDGE_H
> +#define __FPGA_FAKE_BRIDGE_H
> +
> +#include <linux/platform_device.h>
> +#include <kunit/test.h>
> +
> +/**
> + * struct fake_fpga_bridge - fake FPGA bridge context data structure
> + *
> + * @bridge: FPGA bridge.
> + * @pdev: platform device of the FPGA bridge.
> + */
> +struct fake_fpga_bridge {
> +	struct fpga_bridge *bridge;
> +	struct platform_device *pdev;
> +};
> +
> +int fake_fpga_bridge_register(struct fake_fpga_bridge *bridge_ctx,
> +			      struct device *parent, struct kunit *test);
> +
> +void fake_fpga_bridge_unregister(struct fake_fpga_bridge *bridge_ctx);
> +
> +int fake_fpga_bridge_get_state(const struct fake_fpga_bridge *bridge_ctx);
> +
> +int fake_fpga_bridge_get_cycles_count(const struct fake_fpga_bridge *bridge_ctx);
> +
> +#endif /* __FPGA_FAKE_BRIDGE_H */
> -- 
> 2.39.2
> 

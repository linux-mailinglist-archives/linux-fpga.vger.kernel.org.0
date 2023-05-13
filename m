Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FEDD701528
	for <lists+linux-fpga@lfdr.de>; Sat, 13 May 2023 09:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjEMHqc (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 13 May 2023 03:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjEMHqb (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 13 May 2023 03:46:31 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3E965AB;
        Sat, 13 May 2023 00:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683963963; x=1715499963;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sM5GIRpxM9rqVk3fpD3LKKDYhJq4tKYnuCbUlz35vjw=;
  b=mkfIaLRyLuLgT8+590XVYxVzknbh1jjqloezwjAsuC85Nvx1FluVUvGp
   trEChDTmpy/bdY0C4fjCfkgdGqTMtwbXmtQbTJIXXFPVZVWKvaJQcS/Im
   dIedGdVAwBu8bKLtUleH9IbqQ9I8SnFQeOmeWzKUjOnJ1zZqo2RZYKEhb
   0Z2tgO22Ggf+bn5NZ5qlSdVf61oBLTBwH90aKU3BB66W7vCXfRb0sVjTH
   5mZF49VTWwKt+zh5PIQB0SIANz15y4yvdCuMDJDTuHeGY5GyQqAdjD3hr
   V4Nl086hJfw3O7G3VrlhJapPRgDFclRi07qvAi4z0orBeGk6XQUNii+HA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="335462084"
X-IronPort-AV: E=Sophos;i="5.99,271,1677571200"; 
   d="scan'208";a="335462084"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2023 00:46:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="874628927"
X-IronPort-AV: E=Sophos;i="5.99,271,1677571200"; 
   d="scan'208";a="874628927"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga005.jf.intel.com with ESMTP; 13 May 2023 00:46:01 -0700
Date:   Sat, 13 May 2023 23:46:01 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Marco Pagani <marpagan@redhat.com>
Cc:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: Re: [RFC PATCH v5 2/4] fpga: add fake FPGA bridge
Message-ID: <ZF+wuXVRc0/o19Gg@yilunxu-OptiPlex-7050>
References: <20230511141922.437328-1-marpagan@redhat.com>
 <20230511141922.437328-3-marpagan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230511141922.437328-3-marpagan@redhat.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2023-05-11 at 16:19:20 +0200, Marco Pagani wrote:
> Add fake FPGA bridge platform driver with support functions. This module
> is part of the KUnit tests for the FPGA subsystem.
> 
> Signed-off-by: Marco Pagani <marpagan@redhat.com>
> ---
>  drivers/fpga/tests/fake-fpga-bridge.c | 203 ++++++++++++++++++++++++++
>  drivers/fpga/tests/fake-fpga-bridge.h |  40 +++++
>  2 files changed, 243 insertions(+)
>  create mode 100644 drivers/fpga/tests/fake-fpga-bridge.c
>  create mode 100644 drivers/fpga/tests/fake-fpga-bridge.h
> 
> diff --git a/drivers/fpga/tests/fake-fpga-bridge.c b/drivers/fpga/tests/fake-fpga-bridge.c
> new file mode 100644
> index 000000000000..e5db0a809ee3
> --- /dev/null
> +++ b/drivers/fpga/tests/fake-fpga-bridge.c
> @@ -0,0 +1,203 @@
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
> +struct fake_bridge_pdata {
> +	struct kunit *test;
> +	struct fake_fpga_bridge_stats *stats;
> +};
> +
> +struct fake_bridge_priv {
> +	bool state;
> +	struct fake_bridge_pdata *pdata;
> +};
> +
> +static int op_enable_show(struct fpga_bridge *bridge)
> +{
> +	struct fake_bridge_priv *priv;
> +
> +	priv = bridge->priv;
> +
> +	kunit_info(priv->pdata->test, "Fake FPGA bridge %u: enable_show\n",
> +		   bridge->dev.id);
> +
> +	return priv->state;
> +}
> +
> +static int op_enable_set(struct fpga_bridge *bridge, bool enable)
> +{
> +	struct fake_bridge_priv *priv;
> +
> +	priv = bridge->priv;
> +
> +	if (enable && !priv->state)
> +		priv->pdata->stats->cycles_count++;
> +
> +	priv->state = enable;
> +	priv->pdata->stats->enable = priv->state;
> +
> +	kunit_info(priv->pdata->test, "Fake FPGA bridge %u: enable_set: %d\n",
> +		   bridge->dev.id, enable);
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
> +	kunit_info(priv->pdata->test, "Fake FPGA bridge %u: remove\n",
> +		   bridge->dev.id);
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
> + * @test: KUnit test context object.
> + * @parent: parent device.
> + *
> + * Return: pointer to a new fake FPGA bridge on success, an ERR_PTR()
> + * encoded error code on failure.
> + */
> +struct fake_fpga_bridge *
> +fake_fpga_bridge_register(struct kunit *test, struct device *parent)
> +{
> +	struct fake_fpga_bridge *bridge_ctx;
> +	struct fake_bridge_pdata pdata;
> +	struct fake_bridge_priv *priv;
> +	int ret;
> +
> +	bridge_ctx = kunit_kzalloc(test, sizeof(*bridge_ctx), GFP_KERNEL);
> +	if (!bridge_ctx) {
> +		ret = -ENOMEM;
> +		goto err_mem;
> +	}
> +
> +	bridge_ctx->pdev = platform_device_alloc(FAKE_FPGA_BRIDGE_DEV_NAME,
> +						 PLATFORM_DEVID_AUTO);
> +	if (!bridge_ctx->pdev) {
> +		pr_err("Fake FPGA bridge device allocation failed\n");
> +		ret = -ENOMEM;
> +		goto err_mem;
> +	}
> +
> +	pdata.test = test;
> +	pdata.stats = &bridge_ctx->stats;
> +	platform_device_add_data(bridge_ctx->pdev, &pdata, sizeof(pdata));
> +
> +	bridge_ctx->pdev->dev.parent = parent;
> +	ret = platform_device_add(bridge_ctx->pdev);
> +	if (ret) {
> +		pr_err("Fake FPGA bridge device add failed\n");
> +		goto err_pdev;
> +	}
> +
> +	bridge_ctx->bridge = platform_get_drvdata(bridge_ctx->pdev);
> +
> +	priv = bridge_ctx->bridge->priv;
> +	bridge_ctx->stats.enable = priv->state;
> +
> +	kunit_info(test, "Fake FPGA bridge %u: registered\n",
> +		   bridge_ctx->bridge->dev.id);
> +
> +	return bridge_ctx;
> +
> +err_pdev:
> +	platform_device_put(bridge_ctx->pdev);
> +err_mem:
> +	return ERR_PTR(ret);
> +}
> +EXPORT_SYMBOL_GPL(fake_fpga_bridge_register);

Same as fake_fpga_mgr.

Thanks,
Yilun

> +
> +/**
> + * fake_fpga_bridge_unregister() - unregister a fake FPGA bridge.
> + * @bridge_ctx: fake FPGA bridge context data structure.
> + */
> +void fake_fpga_bridge_unregister(struct fake_fpga_bridge *bridge_ctx)
> +{
> +	struct fake_bridge_priv *priv;
> +	struct kunit *test;
> +	u32 id;
> +
> +	if (!bridge_ctx)
> +		return;
> +
> +	id = bridge_ctx->bridge->dev.id;
> +	priv = bridge_ctx->bridge->priv;
> +	test = priv->pdata->test;
> +
> +	platform_device_unregister(bridge_ctx->pdev);
> +
> +	kunit_info(test, "Fake FPGA bridge %u: unregistered\n", id);
> +}
> +EXPORT_SYMBOL_GPL(fake_fpga_bridge_unregister);
> +
> +static int fake_fpga_bridge_probe(struct platform_device *pdev)
> +{
> +	struct device *dev;
> +	struct fake_bridge_pdata *pdata;
> +	struct fpga_bridge *bridge;
> +	struct fake_bridge_priv *priv;
> +
> +	dev = &pdev->dev;
> +	pdata = dev_get_platdata(dev);
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->pdata = pdata;
> +	priv->state = true;
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
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/fpga/tests/fake-fpga-bridge.h b/drivers/fpga/tests/fake-fpga-bridge.h
> new file mode 100644
> index 000000000000..3ecfab7e2890
> --- /dev/null
> +++ b/drivers/fpga/tests/fake-fpga-bridge.h
> @@ -0,0 +1,40 @@
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
> +#include <linux/types.h>
> +#include <linux/platform_device.h>
> +#include <kunit/test.h>
> +
> +struct fake_fpga_bridge_stats {
> +	bool enable;
> +	u32 cycles_count;
> +};
> +
> +/**
> + * struct fake_fpga_bridge - fake FPGA bridge context data structure
> + *
> + * @bridge: FPGA bridge.
> + * @pdev: platform device of the FPGA bridge.
> + * @stats: info from the low level driver.
> + */
> +struct fake_fpga_bridge {
> +	struct fpga_bridge *bridge;
> +	struct platform_device *pdev;
> +	struct fake_fpga_bridge_stats stats;
> +};
> +
> +struct fake_fpga_bridge *
> +fake_fpga_bridge_register(struct kunit *test, struct device *parent);
> +
> +void fake_fpga_bridge_unregister(struct fake_fpga_bridge *bridge_ctx);
> +
> +#endif /* __FPGA_FAKE_BRIDGE_H */
> -- 
> 2.40.1
> 

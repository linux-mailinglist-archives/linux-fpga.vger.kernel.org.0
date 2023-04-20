Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17A816E907C
	for <lists+linux-fpga@lfdr.de>; Thu, 20 Apr 2023 12:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234796AbjDTKkD (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 20 Apr 2023 06:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234941AbjDTKjo (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 20 Apr 2023 06:39:44 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4274849C1;
        Thu, 20 Apr 2023 03:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681987080; x=1713523080;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BAxakRwqXiPJ+GM7Gx3o03YUOC4SmgR4gPeQQceMyMQ=;
  b=Y0/PdNxHvvlkRAjLQVeuZfgXq3Znc9lpzqK314yEgI9SrPBcCfKKnJZK
   Wrj8HHNZM5Kg8ZVlRCZp8gAbMRzrJ+jn3fTAKACmN0VeZ6YvYVVSriKEH
   YdMO311/KDY9UzKHxZgvioMoHvoECApJyRIwDHmmXcxIsGaaW8tusupLR
   BWonCBGrlfHZUQ9S2EEdrhfCcuOGpaWX85Q3EDveA+UaXGliDfrRzOPIM
   j7mzoLg6fdtZ9svTcFzvfC/nANy7+fnRrxA3IHD2DwLsGIdMtL2diNzTX
   1m2YIxXBq9zi7WRgy4kB4N6W8ipr7tVGyp0HQZCKz8ok1wTzADqzV63Uz
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="325304878"
X-IronPort-AV: E=Sophos;i="5.99,212,1677571200"; 
   d="scan'208";a="325304878"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 03:37:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="866201654"
X-IronPort-AV: E=Sophos;i="5.99,212,1677571200"; 
   d="scan'208";a="866201654"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga005.jf.intel.com with ESMTP; 20 Apr 2023 03:37:57 -0700
Date:   Fri, 21 Apr 2023 02:38:28 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Marco Pagani <marpagan@redhat.com>
Cc:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: Re: [RFC PATCH v4 3/4] fpga: add fake FPGA region
Message-ID: <ZEGGpNQfUxsMUOnh@yilunxu-OptiPlex-7050>
References: <20230417122308.131453-1-marpagan@redhat.com>
 <20230417122308.131453-4-marpagan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230417122308.131453-4-marpagan@redhat.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2023-04-17 at 14:23:07 +0200, Marco Pagani wrote:
> Add fake FPGA region platform driver with support functions. This
> module is part of the KUnit tests for the FPGA subsystem.
> 
> Signed-off-by: Marco Pagani <marpagan@redhat.com>
> ---
>  drivers/fpga/tests/fake-fpga-region.c | 259 ++++++++++++++++++++++++++
>  drivers/fpga/tests/fake-fpga-region.h |  40 ++++
>  2 files changed, 299 insertions(+)
>  create mode 100644 drivers/fpga/tests/fake-fpga-region.c
>  create mode 100644 drivers/fpga/tests/fake-fpga-region.h
> 
> diff --git a/drivers/fpga/tests/fake-fpga-region.c b/drivers/fpga/tests/fake-fpga-region.c
> new file mode 100644
> index 000000000000..b23ae5e94fe6
> --- /dev/null
> +++ b/drivers/fpga/tests/fake-fpga-region.c
> @@ -0,0 +1,259 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Driver for the fake FPGA region
> + *
> + * Copyright (C) 2023 Red Hat, Inc.
> + *
> + * Author: Marco Pagani <marpagan@redhat.com>
> + */
> +
> +#include <linux/device.h>
> +#include <linux/list.h>
> +#include <linux/platform_device.h>
> +#include <linux/fpga/fpga-mgr.h>
> +#include <linux/fpga/fpga-region.h>
> +#include <linux/fpga/fpga-bridge.h>
> +#include <kunit/test.h>
> +
> +#include "fake-fpga-region.h"
> +
> +#define FAKE_FPGA_REGION_DEV_NAME	"fake_fpga_region"
> +
> +struct fake_region_priv {
> +	int id;
> +	struct kunit *test;
> +	struct list_head bridge_list;
> +};
> +
> +struct bridge_elem {
> +	struct fpga_bridge *bridge;
> +	struct list_head node;
> +};
> +
> +struct fake_region_data {
> +	struct fpga_manager *mgr;
> +	struct kunit *test;
> +};
> +
> +/**
> + * fake_fpga_region_register() - register a fake FPGA region.
> + * @mgr: associated FPGA manager.
> + * @parent: parent device.
> + * @test: KUnit test context object.
> + *
> + * Return: pointer to a new fake FPGA region on success, an ERR_PTR() encoded
> + * error code on failure.
> + */
> +struct fake_fpga_region *
> +fake_fpga_region_register(struct fpga_manager *mgr, struct device *parent,
> +			  struct kunit *test)
> +{
> +	struct fake_fpga_region *region_ctx;
> +	struct fake_region_data pdata;
> +	struct fake_region_priv *priv;
> +	int ret;
> +
> +	region_ctx = kzalloc(sizeof(*region_ctx), GFP_KERNEL);
> +	if (!region_ctx) {
> +		ret = -ENOMEM;
> +		goto err_mem;
> +	}
> +
> +	region_ctx->pdev = platform_device_alloc(FAKE_FPGA_REGION_DEV_NAME,
> +						 PLATFORM_DEVID_AUTO);
> +	if (!region_ctx->pdev) {
> +		pr_err("Fake FPGA region device allocation failed\n");
> +		ret = -ENOMEM;
> +		goto err_mem;
> +	}
> +
> +	pdata.mgr = mgr;
> +	pdata.test = test;
> +	platform_device_add_data(region_ctx->pdev, &pdata, sizeof(pdata));
> +
> +	region_ctx->pdev->dev.parent = parent;
> +	ret = platform_device_add(region_ctx->pdev);
> +	if (ret) {
> +		pr_err("Fake FPGA region device add failed\n");
> +		goto err_pdev;
> +	}
> +
> +	region_ctx->region = platform_get_drvdata(region_ctx->pdev);
> +
> +	if (test) {
> +		priv = region_ctx->region->priv;
> +		kunit_info(test, "Fake FPGA region %d registered\n", priv->id);
> +	}
> +
> +	return region_ctx;
> +
> +err_pdev:
> +	platform_device_put(region_ctx->pdev);
> +	kfree(region_ctx);
> +err_mem:
> +	return ERR_PTR(ret);
> +}
> +EXPORT_SYMBOL_GPL(fake_fpga_region_register);
> +
> +/**
> + * fake_fpga_region_unregister() - unregister a fake FPGA region.
> + * @region_ctx: fake FPGA region context data structure.
> + */
> +void fake_fpga_region_unregister(struct fake_fpga_region *region_ctx)
> +{
> +	struct fake_region_priv *priv;
> +	struct kunit *test;
> +	int id;
> +
> +	if (!region_ctx)
> +		return;
> +
> +	priv = region_ctx->region->priv;
> +	test = priv->test;
> +	id = priv->id;
> +
> +	if (region_ctx->pdev) {
> +		platform_device_unregister(region_ctx->pdev);
> +		if (test)
> +			kunit_info(test, "Fake FPGA region %d unregistered\n", id);
> +	}
> +
> +	kfree(region_ctx);
> +}
> +EXPORT_SYMBOL_GPL(fake_fpga_region_unregister);
> +
> +/**
> + * fake_fpga_region_add_bridge() - add a bridge to a fake FPGA region.
> + * @region_ctx: fake FPGA region context data structure.
> + * @bridge: FPGA bridge.
> + *
> + * Return: 0 if registration succeeded, an error code otherwise.
> + */
> +int fake_fpga_region_add_bridge(struct fake_fpga_region *region_ctx,
> +				struct fpga_bridge *bridge)
> +{
> +	struct fake_region_priv *priv;
> +	struct bridge_elem *elem;
> +
> +	priv = region_ctx->region->priv;
> +
> +	elem = devm_kzalloc(&region_ctx->pdev->dev, sizeof(*elem), GFP_KERNEL);
> +	if (!elem)
> +		return -ENOMEM;
> +
> +	/* Add bridge to the list of bridges in the private context */
> +	elem->bridge = bridge;
> +	list_add(&elem->node, &priv->bridge_list);
> +
> +	if (priv->test)
> +		kunit_info(priv->test, "Bridge added to fake FPGA region %d\n",
> +			   priv->id);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(fake_fpga_region_add_bridge);

To move these exported functions out of fake driver, could we also provide
the bridge list in platform_data?

Thanks,
Yilun

> +
> +int fake_fpga_region_program(struct fake_fpga_region *region_ctx)
> +{
> +	int ret;
> +
> +	ret = fpga_region_program_fpga(region_ctx->region);
> +
> +	/* fpga_region_program_fpga() already puts the bridges in case of errors */
> +	if (!ret)
> +		fpga_bridges_put(&region_ctx->region->bridge_list);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(fake_fpga_region_program);
> +
> +static int fake_region_get_bridges(struct fpga_region *region)
> +{
> +	struct fake_region_priv *priv;
> +	struct bridge_elem *elem;
> +	int ret;
> +
> +	priv = region->priv;
> +
> +	/* Copy the list of bridges from the private context to the region */
> +	list_for_each_entry(elem, &priv->bridge_list, node) {
> +		ret = fpga_bridge_get_to_list(elem->bridge->dev.parent,
> +					      region->info,
> +					      &region->bridge_list);
> +		if (ret)
> +			break;
> +	}
> +
> +	return ret;
> +}
> +
> +static int fake_fpga_region_probe(struct platform_device *pdev)
> +{
> +	struct device *dev;
> +	struct fpga_region *region;
> +	struct fpga_manager *mgr;
> +	struct fake_region_data *pdata;
> +	struct fake_region_priv *priv;
> +	struct fpga_region_info info;
> +	static int id_count;
> +
> +	dev = &pdev->dev;
> +	pdata = dev_get_platdata(dev);
> +
> +	if (!pdata) {
> +		dev_err(&pdev->dev, "Missing platform data\n");
> +		return -EINVAL;
> +	}
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	mgr = fpga_mgr_get(pdata->mgr->dev.parent);
> +	if (IS_ERR(mgr))
> +		return PTR_ERR(mgr);
> +
> +	INIT_LIST_HEAD(&priv->bridge_list);
> +	priv->id = id_count++;
> +	priv->test = pdata->test;
> +
> +	memset(&info, 0, sizeof(info));
> +	info.priv = priv;
> +	info.mgr = mgr;
> +	info.get_bridges = fake_region_get_bridges;
> +
> +	region = fpga_region_register_full(dev, &info);
> +	if (IS_ERR(region)) {
> +		fpga_mgr_put(mgr);
> +		return PTR_ERR(region);
> +	}
> +
> +	platform_set_drvdata(pdev, region);
> +
> +	return 0;
> +}
> +
> +static int fake_fpga_region_remove(struct platform_device *pdev)
> +{
> +	struct fpga_region *region = platform_get_drvdata(pdev);
> +	struct fpga_manager *mgr = region->mgr;
> +
> +	fpga_mgr_put(mgr);
> +	fpga_region_unregister(region);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver fake_fpga_region_drv = {
> +	.driver = {
> +		.name = FAKE_FPGA_REGION_DEV_NAME
> +	},
> +	.probe = fake_fpga_region_probe,
> +	.remove = fake_fpga_region_remove,
> +};
> +
> +module_platform_driver(fake_fpga_region_drv);
> +
> +MODULE_AUTHOR("Marco Pagani <marpagan@redhat.com>");
> +MODULE_DESCRIPTION("Fake FPGA Bridge");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/fpga/tests/fake-fpga-region.h b/drivers/fpga/tests/fake-fpga-region.h
> new file mode 100644
> index 000000000000..976982c192bc
> --- /dev/null
> +++ b/drivers/fpga/tests/fake-fpga-region.h
> @@ -0,0 +1,40 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Header file for the fake FPGA region
> + *
> + * Copyright (C) 2023 Red Hat, Inc.
> + *
> + * Author: Marco Pagani <marpagan@redhat.com>
> + */
> +
> +#ifndef __FPGA_FAKE_RGN_H
> +#define __FPGA_FAKE_RGN_H
> +
> +#include <linux/platform_device.h>
> +#include <kunit/test.h>
> +#include <linux/fpga/fpga-mgr.h>
> +#include <linux/fpga/fpga-bridge.h>
> +
> +/**
> + * struct fake_fpga_region - fake FPGA region context data structure
> + *
> + * @region: FPGA region.
> + * @pdev: platform device of the FPGA region.
> + */
> +struct fake_fpga_region {
> +	struct fpga_region *region;
> +	struct platform_device *pdev;
> +};
> +
> +struct fake_fpga_region *
> +fake_fpga_region_register(struct fpga_manager *mgr, struct device *parent,
> +			  struct kunit *test);
> +
> +int fake_fpga_region_add_bridge(struct fake_fpga_region *region_ctx,
> +				struct fpga_bridge *bridge);
> +
> +int fake_fpga_region_program(struct fake_fpga_region *region_ctx);
> +
> +void fake_fpga_region_unregister(struct fake_fpga_region *region_ctx);
> +
> +#endif /* __FPGA_FAKE_RGN_H */
> -- 
> 2.39.2
> 

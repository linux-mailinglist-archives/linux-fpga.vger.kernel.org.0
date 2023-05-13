Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3C23701532
	for <lists+linux-fpga@lfdr.de>; Sat, 13 May 2023 10:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjEMIF6 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 13 May 2023 04:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjEMIF5 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 13 May 2023 04:05:57 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB115BBB;
        Sat, 13 May 2023 01:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683965155; x=1715501155;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oao92bh3jD3POKV+VsvSoOIuZTjka8HT8kyBCSCwpbU=;
  b=AJzXEagSr5daX5vfRb3cFk6/eZaliL9mh6itOQ+shmIs5WwIwsAvAO9a
   KzicGrSTOOEVY0hmhbbR5Yq0rmU7Q9PlVtFPQ2phOZd6q24PrTK+cAoOk
   4Yv9f/+ClgoILGnxSfAeASZNJoaXvU/bxx/YwI8VFEDD1boGOPXsQnHX8
   HqJAEMKQevo+sjUDXhNts7uCCm/MnXpUgc1XylLM7Fj+8u4MyDfo/+JDJ
   w7U4o5SvltcrHIIsQXXH8F0hfkMRmEKAuiERyoUy0sRF5xGIlkNAwEjXm
   xFO5fCKLY2OJKvxEutA9s5KJ7cFKQcaHMYZBJz7heDWENU1pVpRZIWvI4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="379082917"
X-IronPort-AV: E=Sophos;i="5.99,271,1677571200"; 
   d="scan'208";a="379082917"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2023 01:05:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="1030317882"
X-IronPort-AV: E=Sophos;i="5.99,271,1677571200"; 
   d="scan'208";a="1030317882"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga005.fm.intel.com with ESMTP; 13 May 2023 01:05:53 -0700
Date:   Sun, 14 May 2023 00:05:53 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Marco Pagani <marpagan@redhat.com>
Cc:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: Re: [RFC PATCH v5 3/4] fpga: add fake FPGA region
Message-ID: <ZF+1YV1H5xwVeSX0@yilunxu-OptiPlex-7050>
References: <20230511141922.437328-1-marpagan@redhat.com>
 <20230511141922.437328-4-marpagan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230511141922.437328-4-marpagan@redhat.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2023-05-11 at 16:19:21 +0200, Marco Pagani wrote:
> Add fake FPGA region platform driver with support functions. This module
> is part of the KUnit tests for the FPGA subsystem.
> 
> Signed-off-by: Marco Pagani <marpagan@redhat.com>
> ---
>  drivers/fpga/tests/fake-fpga-region.c | 245 ++++++++++++++++++++++++++
>  drivers/fpga/tests/fake-fpga-region.h |  40 +++++
>  2 files changed, 285 insertions(+)
>  create mode 100644 drivers/fpga/tests/fake-fpga-region.c
>  create mode 100644 drivers/fpga/tests/fake-fpga-region.h
> 
> diff --git a/drivers/fpga/tests/fake-fpga-region.c b/drivers/fpga/tests/fake-fpga-region.c
> new file mode 100644
> index 000000000000..020c3ad13812
> --- /dev/null
> +++ b/drivers/fpga/tests/fake-fpga-region.c
> @@ -0,0 +1,245 @@
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
> +struct fake_region_pdata {
> +	struct kunit *test;
> +	struct fpga_manager *mgr;
> +};
> +
> +struct bridge_elem {
> +	struct fpga_bridge *bridge;
> +	struct list_head node;
> +};
> +
> +struct fake_region_priv {
> +	struct list_head bridge_list;
> +	struct fake_region_pdata *pdata;
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
> +fake_fpga_region_register(struct kunit *test, struct fpga_manager *mgr,
> +			  struct device *parent)
> +{
> +	struct fake_fpga_region *region_ctx;
> +	struct fake_region_pdata pdata;
> +	int ret;
> +
> +	region_ctx = kunit_kzalloc(test, sizeof(*region_ctx), GFP_KERNEL);
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
> +	kunit_info(test, "Fake FPGA region %u: registered\n",
> +		   region_ctx->region->dev.id);
> +
> +	return region_ctx;
> +
> +err_pdev:
> +	platform_device_put(region_ctx->pdev);
> +err_mem:
> +	return ERR_PTR(ret);
> +}
> +EXPORT_SYMBOL_GPL(fake_fpga_region_register);

Same as fake_fpga_mgr, move it to fpga-test? Same as below exported
functions.

> +
> +/**
> + * fake_fpga_region_unregister() - unregister a fake FPGA region.
> + * @region_ctx: fake FPGA region context data structure.
> + */
> +void fake_fpga_region_unregister(struct fake_fpga_region *region_ctx)
> +{
> +	struct fake_region_priv *priv;
> +	struct kunit *test;
> +	u32 id;
> +
> +	if (!region_ctx)
> +		return;
> +
> +	id = region_ctx->region->dev.id;
> +	priv = region_ctx->region->priv;
> +	test = priv->pdata->test;
> +
> +	platform_device_unregister(region_ctx->pdev);
> +
> +	kunit_info(test, "Fake FPGA region %u: unregistered\n", id);
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
> +	kunit_info(priv->pdata->test, "Bridge: %u added to fake FPGA region: %u\n",
> +		   bridge->dev.id, region_ctx->region->dev.id);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(fake_fpga_region_add_bridge);

I remember in previous version we are going to provide the bridges in
platform data.

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

Move it to fpga-test if possible. Maintain all the region/mgr/bridge_ctx
in fpga_test.

Thanks,
Yilun

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
> +	struct fake_region_pdata *pdata;
> +	struct fake_region_priv *priv;
> +	struct fpga_region_info info;
> +
> +	dev = &pdev->dev;
> +	pdata = dev_get_platdata(dev);
> +
> +	if (!pdata) {
> +		dev_err(&pdev->dev, "Fake FPGA region probe: missing platform data\n");
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
> +	priv->pdata = pdata;
> +	INIT_LIST_HEAD(&priv->bridge_list);
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
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/fpga/tests/fake-fpga-region.h b/drivers/fpga/tests/fake-fpga-region.h
> new file mode 100644
> index 000000000000..c72992cbb218
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
> +fake_fpga_region_register(struct kunit *test, struct fpga_manager *mgr,
> +			  struct device *parent);
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
> 2.40.1
> 

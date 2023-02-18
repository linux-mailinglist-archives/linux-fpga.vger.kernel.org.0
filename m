Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0009B69B961
	for <lists+linux-fpga@lfdr.de>; Sat, 18 Feb 2023 11:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjBRKYV (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 18 Feb 2023 05:24:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjBRKYU (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 18 Feb 2023 05:24:20 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A521310ABB;
        Sat, 18 Feb 2023 02:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676715859; x=1708251859;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CCD9Tacgmqwo7OXIk2hPU2SzxlmvsHxP3x7TcQdl+8Q=;
  b=oIM7P6IGwwC/ek94+MqeHXw0biHzny4YkpmqWkhIGHDKpVAbQNdQvK+z
   QNYNk4gG8y3x6R9tgilX+Tm9kRK6gbW1a4s7IQB+LyYHP+fk88Qc1MBRU
   AAEx8h/RCdL5BE2XjOz5Ckz1knUM+z/wFQ4vKMd/NhRAF1DO6/BHIXpnC
   a+ayYnxaIAEQc7OzrBH6xnSlhdPcJR6jv/EEhdcMJCQx82hffW4cmPIpf
   XEEo4WsYLtR1qiBNgLossH9DNbUUJ+Sy0VR3kZjSiA9WDLJwBXnvRfZI8
   JafABK+kgXtPvyKu9KGtaLgMob3NzL8kpA8bot+3zMv85MI9RwbAMR+9V
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10624"; a="315874062"
X-IronPort-AV: E=Sophos;i="5.97,306,1669104000"; 
   d="scan'208";a="315874062"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2023 02:24:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10624"; a="999765276"
X-IronPort-AV: E=Sophos;i="5.97,306,1669104000"; 
   d="scan'208";a="999765276"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga005.fm.intel.com with ESMTP; 18 Feb 2023 02:24:17 -0800
Date:   Sat, 18 Feb 2023 18:13:23 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Marco Pagani <marpagan@redhat.com>
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/4] fpga: add fake FPGA region
Message-ID: <Y/Ckw+F/sb2er2oK@yilunxu-OptiPlex-7050>
References: <20230203170653.414990-1-marpagan@redhat.com>
 <20230203170653.414990-3-marpagan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230203170653.414990-3-marpagan@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2023-02-03 at 18:06:51 +0100, Marco Pagani wrote:
> Add fake FPGA region platform driver with support functions. This
> module is part of the KUnit test suite for the FPGA subsystem.
> 
> Signed-off-by: Marco Pagani <marpagan@redhat.com>
> ---
>  drivers/fpga/tests/fake-fpga-region.c | 186 ++++++++++++++++++++++++++
>  drivers/fpga/tests/fake-fpga-region.h |  37 +++++
>  2 files changed, 223 insertions(+)
>  create mode 100644 drivers/fpga/tests/fake-fpga-region.c
>  create mode 100644 drivers/fpga/tests/fake-fpga-region.h
> 
> diff --git a/drivers/fpga/tests/fake-fpga-region.c b/drivers/fpga/tests/fake-fpga-region.c
> new file mode 100644
> index 000000000000..095397e41837
> --- /dev/null
> +++ b/drivers/fpga/tests/fake-fpga-region.c
> @@ -0,0 +1,186 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Driver for fake FPGA region
> + *
> + * Copyright (C) 2023 Red Hat, Inc. All rights reserved.
> + *
> + * Author: Marco Pagani <marpagan@redhat.com>
> + */
> +
> +#include <linux/device.h>
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
> +};
> +
> +struct fake_region_data {
> +	struct fpga_manager *mgr;
> +	struct kunit *test;
> +};
> +
> +/**
> + * fake_fpga_region_register - register a fake FPGA region
> + * @region_ctx: fake FPGA region context data structure.
> + * @test: KUnit test context object.
> + *
> + * Return: 0 if registration succeeded, an error code otherwise.
> + */
> +int fake_fpga_region_register(struct fake_fpga_region *region_ctx,
> +			      struct fpga_manager *mgr, struct kunit *test)
> +{
> +	struct fake_region_data pdata;
> +	struct fake_region_priv *priv;
> +	int ret;
> +
> +	pdata.mgr = mgr;
> +	pdata.test = test;
> +
> +	region_ctx->pdev = platform_device_alloc(FAKE_FPGA_REGION_DEV_NAME,
> +						 PLATFORM_DEVID_AUTO);
> +	if (IS_ERR(region_ctx->pdev)) {
> +		pr_err("Fake FPGA region device allocation failed\n");
> +		return -ENOMEM;
> +	}
> +
> +	platform_device_add_data(region_ctx->pdev, &pdata, sizeof(pdata));
> +
> +	ret = platform_device_add(region_ctx->pdev);
> +	if (ret) {
> +		pr_err("Fake FPGA region device add failed\n");
> +		platform_device_put(region_ctx->pdev);
> +		return ret;
> +	}
> +
> +	region_ctx->region = platform_get_drvdata(region_ctx->pdev);
> +
> +	if (test) {
> +		priv = region_ctx->region->priv;
> +		kunit_info(test, "Fake FPGA region %d registered\n", priv->id);
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(fake_fpga_region_register);
> +
> +/**
> + * fake_fpga_region_unregister - unregister a fake FPGA region
> + * @region_ctx: fake FPGA region context data structure.
> + */
> +void fake_fpga_region_unregister(struct fake_fpga_region *region_ctx)
> +{
> +	struct fake_region_priv *priv;
> +	struct kunit *test;
> +	int id;
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
> +}
> +EXPORT_SYMBOL_GPL(fake_fpga_region_unregister);
> +
> +/**
> + * fake_fpga_region_add_bridge - add a bridge to a fake FPGA region
> + * @region_ctx: fake FPGA region context data structure.
> + * @bridge: FPGA bridge.
> + *
> + * Return: 0 if registration succeeded, an error code otherwise.
> + */
> +int fake_fpga_region_add_bridge(struct fake_fpga_region *region_ctx,
> +				struct fpga_bridge *bridge)
> +{
> +	struct fake_region_priv *priv;
> +	int ret;
> +
> +	priv = region_ctx->region->priv;
> +
> +	ret = fpga_bridge_get_to_list(bridge->dev.parent, NULL,
> +				      &region_ctx->region->bridge_list);
> +
> +	if (priv->test && !ret)
> +		kunit_info(priv->test, "Bridge added to fake FPGA region %d\n",
> +			   priv->id);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(fake_fpga_region_add_bridge);
> +
> +static int fake_fpga_region_probe(struct platform_device *pdev)
> +{
> +	struct device *dev;
> +	struct fpga_region *region;
> +	struct fpga_manager *mgr;
> +	struct fake_region_data *pdata;
> +	struct fake_region_priv *priv;
> +	static int id_count;
> +
> +	dev = &pdev->dev;
> +	pdata = dev_get_platdata(dev);
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	mgr = fpga_mgr_get(pdata->mgr->dev.parent);
> +	if (IS_ERR(mgr))
> +		return PTR_ERR(mgr);
> +
> +	/*
> +	 * No get_bridges() method since the bridges list is
> +	 * pre-built using fake_fpga_region_add_bridge()
> +	 */

This is not the common use for drivers to associate the region & bridge,
Better to realize the get_bridges() method.

Thanks,
Yilun

> +	region = fpga_region_register(dev, mgr, NULL);
> +	if (IS_ERR(region)) {
> +		fpga_mgr_put(mgr);
> +		return PTR_ERR(region);
> +	}
> +
> +	priv->test = pdata->test;
> +	priv->id = id_count++;
> +	region->priv = priv;
> +
> +	platform_set_drvdata(pdev, region);
> +
> +	return 0;
> +}

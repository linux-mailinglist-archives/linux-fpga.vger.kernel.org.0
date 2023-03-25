Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 392876C8C2B
	for <lists+linux-fpga@lfdr.de>; Sat, 25 Mar 2023 08:25:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbjCYHXR (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 25 Mar 2023 03:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbjCYHXQ (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 25 Mar 2023 03:23:16 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031364214;
        Sat, 25 Mar 2023 00:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679728993; x=1711264993;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mGPluVOwEXuhHN7hBM3Bki6iwVdk0FYDlxKt56oXSuk=;
  b=Ao0byYpO7TcWHfR3MdBklfTdK3NzTEuQYBUsSEKyXAq0Ad58c8nd2Htx
   UqlwSpPm+FiPnIehUOzQdIUgI570kCe4eZSRZwkF8fJgbPLQzEbIKVRhW
   JqP+qK+PHgnTNTuCzO0sjDK1ylSj9xVe+csebbGVCelCaBvXOAERoTUSN
   Y4VpBZXpTmF5Zumvh2PZ/CfEJ+NaW4eOR49w+Qjx7LaDcv/OJxPm4CS7O
   gF6LLUDTQS+Vs07bvTRtdPBY4MUoGNkNwNGCmbQ06XqcWVHBcgvwBopHW
   cSmShasFPwfNcUkNBepi2N3DYwlkdr6KJJ0lSO6JzSvN6XuBRHXOl+9OX
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="319599979"
X-IronPort-AV: E=Sophos;i="5.98,290,1673942400"; 
   d="scan'208";a="319599979"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2023 00:23:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10659"; a="806926218"
X-IronPort-AV: E=Sophos;i="5.98,290,1673942400"; 
   d="scan'208";a="806926218"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga004.jf.intel.com with ESMTP; 25 Mar 2023 00:23:10 -0700
Date:   Sat, 25 Mar 2023 15:11:42 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Marco Pagani <marpagan@redhat.com>
Cc:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: Re: [RFC PATCH v2 3/4] fpga: add fake FPGA region
Message-ID: <ZB6erkW2IC75YJuT@yilunxu-OptiPlex-7050>
References: <20230310170412.708363-1-marpagan@redhat.com>
 <20230310170412.708363-4-marpagan@redhat.com>
 <ZBRDu2/Kc142b8jJ@yilunxu-OptiPlex-7050>
 <7e717966-597d-0ce4-1152-ebf43a611a35@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e717966-597d-0ce4-1152-ebf43a611a35@redhat.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2023-03-21 at 21:07:43 +0100, Marco Pagani wrote:
> 
> 
> On 2023-03-17 11:40, Xu Yilun wrote:
> > On 2023-03-10 at 18:04:11 +0100, Marco Pagani wrote:
> >> Add fake FPGA region platform driver with support functions. This
> >> module is part of the KUnit tests for the FPGA subsystem.
> >>
> >> Signed-off-by: Marco Pagani <marpagan@redhat.com>
> >> ---
> >>  drivers/fpga/tests/fake-fpga-region.c | 219 ++++++++++++++++++++++++++
> >>  drivers/fpga/tests/fake-fpga-region.h |  38 +++++
> >>  2 files changed, 257 insertions(+)
> >>  create mode 100644 drivers/fpga/tests/fake-fpga-region.c
> >>  create mode 100644 drivers/fpga/tests/fake-fpga-region.h
> >>
> >> diff --git a/drivers/fpga/tests/fake-fpga-region.c b/drivers/fpga/tests/fake-fpga-region.c
> >> new file mode 100644
> >> index 000000000000..54d0e564728b
> >> --- /dev/null
> >> +++ b/drivers/fpga/tests/fake-fpga-region.c
> >> @@ -0,0 +1,219 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * Driver for the fake FPGA region
> >> + *
> >> + * Copyright (C) 2023 Red Hat, Inc.
> >> + *
> >> + * Author: Marco Pagani <marpagan@redhat.com>
> >> + */
> >> +
> >> +#include <linux/device.h>
> >> +#include <linux/list.h>
> >> +#include <linux/platform_device.h>
> >> +#include <linux/fpga/fpga-mgr.h>
> >> +#include <linux/fpga/fpga-region.h>
> >> +#include <linux/fpga/fpga-bridge.h>
> >> +#include <kunit/test.h>
> >> +
> >> +#include "fake-fpga-region.h"
> >> +
> >> +#define FAKE_FPGA_REGION_DEV_NAME	"fake_fpga_region"
> >> +
> >> +struct fake_region_priv {
> >> +	int id;
> >> +	struct kunit *test;
> >> +	struct list_head bridge_list;
> >> +};
> >> +
> >> +struct fake_region_data {
> >> +	struct fpga_manager *mgr;
> >> +	struct kunit *test;
> >> +};
> >> +
> >> +/**
> >> + * fake_fpga_region_register() - register a fake FPGA region.
> >> + * @region_ctx: fake FPGA region context data structure.
> >> + * @mgr: associated FPGA manager.
> >> + * @parent: parent device.
> >> + * @test: KUnit test context object.
> >> + *
> >> + * Return: 0 if registration succeeded, an error code otherwise.
> >> + */
> >> +int fake_fpga_region_register(struct fake_fpga_region *region_ctx,
> >> +			      struct fpga_manager *mgr, struct device *parent,
> >> +			      struct kunit *test)
> >> +{
> >> +	struct fake_region_data pdata;
> >> +	struct fake_region_priv *priv;
> >> +	int ret;
> >> +
> >> +	pdata.mgr = mgr;
> >> +	pdata.test = test;
> >> +
> >> +	region_ctx->pdev = platform_device_alloc(FAKE_FPGA_REGION_DEV_NAME,
> >> +						 PLATFORM_DEVID_AUTO);
> >> +	if (IS_ERR(region_ctx->pdev)) {
> >> +		pr_err("Fake FPGA region device allocation failed\n");
> >> +		return -ENOMEM;
> >> +	}
> >> +
> >> +	region_ctx->pdev->dev.parent = parent;
> >> +	platform_device_add_data(region_ctx->pdev, &pdata, sizeof(pdata));
> >> +
> >> +	ret = platform_device_add(region_ctx->pdev);
> >> +	if (ret) {
> >> +		pr_err("Fake FPGA region device add failed\n");
> >> +		platform_device_put(region_ctx->pdev);
> >> +		return ret;
> >> +	}
> >> +
> >> +	region_ctx->region = platform_get_drvdata(region_ctx->pdev);
> >> +
> >> +	if (test) {
> >> +		priv = region_ctx->region->priv;
> >> +		kunit_info(test, "Fake FPGA region %d registered\n", priv->id);
> >> +	}
> >> +
> >> +	return 0;
> >> +}
> >> +EXPORT_SYMBOL_GPL(fake_fpga_region_register);
> >> +
> >> +/**
> >> + * fake_fpga_region_unregister() - unregister a fake FPGA region.
> >> + * @region_ctx: fake FPGA region context data structure.
> >> + */
> >> +void fake_fpga_region_unregister(struct fake_fpga_region *region_ctx)
> >> +{
> >> +	struct fake_region_priv *priv;
> >> +	struct kunit *test;
> >> +	int id;
> >> +
> >> +	if (!region_ctx)
> >> +		return;
> >> +
> >> +	priv = region_ctx->region->priv;
> >> +	test = priv->test;
> >> +	id = priv->id;
> >> +
> >> +	if (region_ctx->pdev) {
> >> +		platform_device_unregister(region_ctx->pdev);
> >> +		if (test)
> >> +			kunit_info(test, "Fake FPGA region %d unregistered\n", id);
> >> +	}
> >> +}
> >> +EXPORT_SYMBOL_GPL(fake_fpga_region_unregister);
> >> +
> >> +/**
> >> + * fake_fpga_region_add_bridge() - add a bridge to a fake FPGA region.
> >> + * @region_ctx: fake FPGA region context data structure.
> >> + * @bridge: FPGA bridge.
> >> + *
> >> + * Return: 0 if registration succeeded, an error code otherwise.
> >> + */
> >> +void fake_fpga_region_add_bridge(struct fake_fpga_region *region_ctx,
> >> +				 struct fpga_bridge *bridge)
> >> +{
> >> +	struct fake_region_priv *priv;
> >> +
> >> +	priv = region_ctx->region->priv;
> >> +
> >> +	/* Add bridge to the list of bridges in the private context */
> >> +	list_add(&bridge->node, &priv->bridge_list);
> >> +
> >> +	if (priv->test)
> >> +		kunit_info(priv->test, "Bridge added to fake FPGA region %d\n",
> >> +			   priv->id);
> >> +}
> >> +EXPORT_SYMBOL_GPL(fake_fpga_region_add_bridge);
> >> +
> >> +static int fake_region_get_bridges(struct fpga_region *region)
> >> +{
> >> +	struct fake_region_priv *priv;
> >> +	struct fpga_bridge *bridge, *tmp;
> >> +	int ret;
> >> +
> >> +	priv = region->priv;
> >> +
> >> +	list_for_each_entry_safe(bridge, tmp, &priv->bridge_list, node) {
> >> +		list_del(&bridge->node);
> > 
> > I think the fake_fpga_region user just need to call
> > fake_fpga_region_add_bridge() once on init, and may call
> > fpga_bridges_put() at any time after fpga_region_program_fpga(), then
> > you may lose the track of the bridges, which breaks the next
> > fpga_region_program_fpga().
> > 
> > Thanks,
> > Yilun
> >
> 
> That's right, fake_fpga_region_add_bridge() is intended to be called once
> (for each bridge) just after registering the region. I should have added
> this to the kernel-doc description of the function.
> 
> When a fake region is unregistered, its bridges are released using
> fpga_bridges_put() by the remove method of the platform driver.

Please check the kernel-doc:

/**
 * fpga_region_program_fpga - program FPGA
 *
 * @region: FPGA region
 *
 * Program an FPGA using fpga image info (region->info).
 * If the region has a get_bridges function, the exclusive reference for the
 * bridges will be held if programming succeeds.  This is intended to prevent
 * reprogramming the region until the caller considers it safe to do so.
 * The caller will need to call fpga_bridges_put() before attempting to
 * reprogram the region.
 *
 * Return 0 for success or negative error code.
 */
int fpga_region_program_fpga(struct fpga_region *region)

That means the fpga test should call fpga_bridges_put() before a second
fpga_region_program_fpga().

> 
> In the fpga_test_static_cfg test case, the base region is configured
> twice. Then, when the base region is unregistered by the exit method of
> the test suite, the base bridge is released.
> 
> Here's the raw test output with dev_dbg() prints of the FPGA bridge
> enabled:
> 
>     # Subtest: fpga
>     1..2
>     # fpga_test_static_cfg: Fake FPGA manager: state
>     # fpga_test_static_cfg: Fake FPGA manager registered
>     # fpga_test_static_cfg: Fake FPGA bridge 3 registered
>     # fpga_test_static_cfg: Fake FPGA region 0 registered
>     # fpga_test_static_cfg: Bridge added to fake FPGA region 0
>     # fpga_test_static_cfg: FPGA base system built
>     # fpga_test_static_cfg: Fake FPGA bridge 3: enable_show
>     # fpga_test_static_cfg: FPGA image allocated in a buffer, size: 16384
> fpga_bridge br0: get <---
> fpga_bridge br0: disable
>     # fpga_test_static_cfg: Fake FPGA bridge 3: enable_set: 0
>     # fpga_test_static_cfg: Fake FPGA manager: parse_header
>     # fpga_test_static_cfg: Fake FPGA manager: write_init
>     # fpga_test_static_cfg: Fake FPGA manager: write
>     # fpga_test_static_cfg: Fake FPGA manager: write_complete
> fpga_bridge br0: enable
>     # fpga_test_static_cfg: Fake FPGA bridge 3: enable_set: 1
>     # fpga_test_static_cfg: Fake FPGA bridge 3: enable_show
>     # fpga_test_static_cfg: FPGA configuration completed using a buffer image
>     # fpga_test_static_cfg: FPGA image allocated in a scatter gather table, size: 16384
> fpga_bridge br0: disable
>     # fpga_test_static_cfg: Fake FPGA bridge 3: enable_set: 0
>     # fpga_test_static_cfg: Fake FPGA manager: parse_header
>     # fpga_test_static_cfg: Fake FPGA manager: write_init
>     # fpga_test_static_cfg: Fake FPGA manager: write_sg
>     # fpga_test_static_cfg: Fake FPGA manager: write_complete
> fpga_bridge br0: enable
>     # fpga_test_static_cfg: Fake FPGA bridge 3: enable_set: 1
>     # fpga_test_static_cfg: Fake FPGA bridge 3: enable_show
>     # fpga_test_static_cfg: FPGA configuration completed using scatter gather table image
> fpga_bridge br0: put <---
>     # fpga_test_static_cfg: Fake FPGA region 0 unregistered
>     # fpga_test_static_cfg: Fake FPGA bridge: remove
>     # fpga_test_static_cfg: Fake FPGA bridge 3 unregistered
> fpga_manager fpga0: fpga_mgr_unregister Fake FPGA Manager
>     # fpga_test_static_cfg: Fake FPGA manager: remove
>     # fpga_test_static_cfg: Fake FPGA manager unregistered
>     ok 1 fpga_test_static_cfg
> 
> In my understanding, of-region uses a similar approach by releasing
> bridges only when the overlay is removed.

The overlay removal is not equal to the of-fpga-region removal. Actually
the overlay could be applied & removed multiple times, and
fpga_region_program_fpga & fpga_bridges_put() are called each time.


Thanks,
Yilun

> 
> 
> >> +		ret = fpga_bridge_get_to_list(bridge->dev.parent,
> >> +					      region->info,
> >> +					      &region->bridge_list);
> >> +		if (ret)
> >> +			break;
> >> +	}
> >> +
> >> +	return ret;
> >> +}
> >> +
> >> +static int fake_fpga_region_probe(struct platform_device *pdev)
> >> +{
> >> +	struct device *dev;
> >> +	struct fpga_region *region;
> >> +	struct fpga_manager *mgr;
> >> +	struct fake_region_data *pdata;
> >> +	struct fake_region_priv *priv;
> >> +	struct fpga_region_info info;
> >> +	static int id_count;
> >> +
> >> +	dev = &pdev->dev;
> >> +	pdata = dev_get_platdata(dev);
> >> +
> >> +	if (!pdata) {
> >> +		dev_err(&pdev->dev, "Missing platform data\n");
> >> +		return -EINVAL;
> >> +	}
> >> +
> >> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> >> +	if (!priv)
> >> +		return -ENOMEM;
> >> +
> >> +	mgr = fpga_mgr_get(pdata->mgr->dev.parent);
> >> +	if (IS_ERR(mgr))
> >> +		return PTR_ERR(mgr);
> >> +
> >> +	INIT_LIST_HEAD(&priv->bridge_list);
> >> +	priv->id = id_count++;
> >> +	priv->test = pdata->test;
> >> +
> >> +	memset(&info, 0, sizeof(info));
> >> +	info.priv = priv;
> >> +	info.mgr = mgr;
> >> +	info.get_bridges = fake_region_get_bridges;
> >> +
> >> +	region = fpga_region_register_full(dev, &info);
> >> +	if (IS_ERR(region)) {
> >> +		fpga_mgr_put(mgr);
> >> +		return PTR_ERR(region);
> >> +	}
> >> +
> >> +	platform_set_drvdata(pdev, region);
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static int fake_fpga_region_remove(struct platform_device *pdev)
> >> +{
> >> +	struct fpga_region *region = platform_get_drvdata(pdev);
> >> +	struct fpga_manager *mgr = region->mgr;
> >> +
> >> +	fpga_mgr_put(mgr);
> >> +	fpga_bridges_put(&region->bridge_list);
> >> +	fpga_region_unregister(region);
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static struct platform_driver fake_fpga_region_drv = {
> >> +	.driver = {
> >> +		.name = FAKE_FPGA_REGION_DEV_NAME
> >> +	},
> >> +	.probe = fake_fpga_region_probe,
> >> +	.remove = fake_fpga_region_remove,
> >> +};
> >> +
> >> +module_platform_driver(fake_fpga_region_drv);
> >> +
> >> +MODULE_AUTHOR("Marco Pagani <marpagan@redhat.com>");
> >> +MODULE_DESCRIPTION("Fake FPGA Bridge");
> >> +MODULE_LICENSE("GPL v2");
> >> diff --git a/drivers/fpga/tests/fake-fpga-region.h b/drivers/fpga/tests/fake-fpga-region.h
> >> new file mode 100644
> >> index 000000000000..9268ca335662
> >> --- /dev/null
> >> +++ b/drivers/fpga/tests/fake-fpga-region.h
> >> @@ -0,0 +1,38 @@
> >> +/* SPDX-License-Identifier: GPL-2.0 */
> >> +/*
> >> + * Header file for the fake FPGA region
> >> + *
> >> + * Copyright (C) 2023 Red Hat, Inc.
> >> + *
> >> + * Author: Marco Pagani <marpagan@redhat.com>
> >> + */
> >> +
> >> +#ifndef __FPGA_FAKE_RGN_H
> >> +#define __FPGA_FAKE_RGN_H
> >> +
> >> +#include <linux/platform_device.h>
> >> +#include <kunit/test.h>
> >> +#include <linux/fpga/fpga-mgr.h>
> >> +#include <linux/fpga/fpga-bridge.h>
> >> +
> >> +/**
> >> + * struct fake_fpga_region - fake FPGA region context data structure
> >> + *
> >> + * @region: FPGA region.
> >> + * @pdev: platform device of the FPGA region.
> >> + */
> >> +struct fake_fpga_region {
> >> +	struct fpga_region *region;
> >> +	struct platform_device *pdev;
> >> +};
> >> +
> >> +int fake_fpga_region_register(struct fake_fpga_region *region_ctx,
> >> +			      struct fpga_manager *mgr, struct device *parent,
> >> +			      struct kunit *test);
> >> +
> >> +void fake_fpga_region_add_bridge(struct fake_fpga_region *region_ctx,
> >> +				 struct fpga_bridge *bridge);
> >> +
> >> +void fake_fpga_region_unregister(struct fake_fpga_region *region_ctx);
> >> +
> >> +#endif /* __FPGA_FAKE_RGN_H */
> >> -- 
> >> 2.39.2
> >>
> > 
> 
> Thanks,
> Marco
> 

Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DACD6A175D
	for <lists+linux-fpga@lfdr.de>; Fri, 24 Feb 2023 08:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjBXHdx (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 24 Feb 2023 02:33:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjBXHdk (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 24 Feb 2023 02:33:40 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B6146174;
        Thu, 23 Feb 2023 23:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677223994; x=1708759994;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zwryG0AGbtAQ6n2azIrnoaRDyFC29oFDBNeBPcHwTlg=;
  b=A9Xd7ybVEDcTMhO5oeOBOfF9iAHgx6s7pihraO0V3w9TXJq4v0N878Zx
   54SMCLSZVD5TjUU3p9MajGoWWJ2uSKLCA77Zm9+/DvV45fWwqMSu/uF1s
   iCMO/pioOTgres8HGiBCwFbnz/OoCdmoR8JQR7Je14VHUqF69WlrOjcv+
   uw/jNLjr5j0FOO+v8mbX5Zr4Zw9mwDm0q/ZhFfs18iviIGpY+W4PzC/RT
   q+WM+NT+xr4CT8LTXEFXsUBmIQzKTFUGiqZlbTSEV7Kpxvd1ArgJCaK9f
   LfwNO4geN3h1iOZ61fTh1p/wzGp8ZqZDq5cXFt5K31aJ42Ra4h6612Q9o
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="419650667"
X-IronPort-AV: E=Sophos;i="5.97,324,1669104000"; 
   d="scan'208";a="419650667"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2023 23:31:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="918331423"
X-IronPort-AV: E=Sophos;i="5.97,324,1669104000"; 
   d="scan'208";a="918331423"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga006.fm.intel.com with ESMTP; 23 Feb 2023 23:31:48 -0800
Date:   Fri, 24 Feb 2023 15:20:48 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Marco Pagani <marpagan@redhat.com>
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/4] fpga: add fake FPGA region
Message-ID: <Y/hlUOy26HBfdJFR@yilunxu-OptiPlex-7050>
References: <20230203170653.414990-1-marpagan@redhat.com>
 <20230203170653.414990-3-marpagan@redhat.com>
 <Y/Ckw+F/sb2er2oK@yilunxu-OptiPlex-7050>
 <3f17060a-69ce-fb39-61ab-a892b9a1e8c6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f17060a-69ce-fb39-61ab-a892b9a1e8c6@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2023-02-21 at 15:53:20 +0100, Marco Pagani wrote:
> 
> 
> On 2023-02-18 11:13, Xu Yilun wrote:
> > On 2023-02-03 at 18:06:51 +0100, Marco Pagani wrote:
> >> Add fake FPGA region platform driver with support functions. This
> >> module is part of the KUnit test suite for the FPGA subsystem.
> >>
> >> Signed-off-by: Marco Pagani <marpagan@redhat.com>
> >> ---
> >>  drivers/fpga/tests/fake-fpga-region.c | 186 ++++++++++++++++++++++++++
> >>  drivers/fpga/tests/fake-fpga-region.h |  37 +++++
> >>  2 files changed, 223 insertions(+)
> >>  create mode 100644 drivers/fpga/tests/fake-fpga-region.c
> >>  create mode 100644 drivers/fpga/tests/fake-fpga-region.h
> >>
> >> diff --git a/drivers/fpga/tests/fake-fpga-region.c b/drivers/fpga/tests/fake-fpga-region.c
> >> new file mode 100644
> >> index 000000000000..095397e41837
> >> --- /dev/null
> >> +++ b/drivers/fpga/tests/fake-fpga-region.c
> >> @@ -0,0 +1,186 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * Driver for fake FPGA region
> >> + *
> >> + * Copyright (C) 2023 Red Hat, Inc. All rights reserved.
> >> + *
> >> + * Author: Marco Pagani <marpagan@redhat.com>
> >> + */
> >> +
> >> +#include <linux/device.h>
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
> >> +};
> >> +
> >> +struct fake_region_data {
> >> +	struct fpga_manager *mgr;
> >> +	struct kunit *test;
> >> +};
> >> +
> >> +/**
> >> + * fake_fpga_region_register - register a fake FPGA region
> >> + * @region_ctx: fake FPGA region context data structure.
> >> + * @test: KUnit test context object.
> >> + *
> >> + * Return: 0 if registration succeeded, an error code otherwise.
> >> + */
> >> +int fake_fpga_region_register(struct fake_fpga_region *region_ctx,
> >> +			      struct fpga_manager *mgr, struct kunit *test)
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
> >> + * fake_fpga_region_unregister - unregister a fake FPGA region
> >> + * @region_ctx: fake FPGA region context data structure.
> >> + */
> >> +void fake_fpga_region_unregister(struct fake_fpga_region *region_ctx)
> >> +{
> >> +	struct fake_region_priv *priv;
> >> +	struct kunit *test;
> >> +	int id;
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
> >> + * fake_fpga_region_add_bridge - add a bridge to a fake FPGA region
> >> + * @region_ctx: fake FPGA region context data structure.
> >> + * @bridge: FPGA bridge.
> >> + *
> >> + * Return: 0 if registration succeeded, an error code otherwise.
> >> + */
> >> +int fake_fpga_region_add_bridge(struct fake_fpga_region *region_ctx,
> >> +				struct fpga_bridge *bridge)
> >> +{
> >> +	struct fake_region_priv *priv;
> >> +	int ret;
> >> +
> >> +	priv = region_ctx->region->priv;
> >> +
> >> +	ret = fpga_bridge_get_to_list(bridge->dev.parent, NULL,
> >> +				      &region_ctx->region->bridge_list);
> >> +
> >> +	if (priv->test && !ret)
> >> +		kunit_info(priv->test, "Bridge added to fake FPGA region %d\n",
> >> +			   priv->id);
> >> +
> >> +	return ret;
> >> +}
> >> +EXPORT_SYMBOL_GPL(fake_fpga_region_add_bridge);
> >> +
> >> +static int fake_fpga_region_probe(struct platform_device *pdev)
> >> +{
> >> +	struct device *dev;
> >> +	struct fpga_region *region;
> >> +	struct fpga_manager *mgr;
> >> +	struct fake_region_data *pdata;
> >> +	struct fake_region_priv *priv;
> >> +	static int id_count;
> >> +
> >> +	dev = &pdev->dev;
> >> +	pdata = dev_get_platdata(dev);
> >> +
> >> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> >> +	if (!priv)
> >> +		return -ENOMEM;
> >> +
> >> +	mgr = fpga_mgr_get(pdata->mgr->dev.parent);
> >> +	if (IS_ERR(mgr))
> >> +		return PTR_ERR(mgr);
> >> +
> >> +	/*
> >> +	 * No get_bridges() method since the bridges list is
> >> +	 * pre-built using fake_fpga_region_add_bridge()
> >> +	 */
> > 
> > This is not the common use for drivers to associate the region & bridge,
> > Better to realize the get_bridges() method.
> 
> Initially, I was using a get_bridges() method to create the list of bridges
> before each reconfiguration. However, this required having a "duplicated"
> list of bridges in the context of the fake region low-level driver.
> 
> Since I couldn't find a reason to keep a duplicate list of bridges in the
> fake region driver, I decided then to change the approach and build the
> list of bridges at device instantiation time.
> 
> In my understanding, the approach of creating the list of bridges just
> before reconfiguration with a get_bridges() method works best for the
> OF case, where the topology is already encoded in the DT. I feel using
> this approach on platforms without OF support would increase complexity
> and create unnecessary duplication.

I'm not fully get your point. My understanding is we don't have to
always grab the bridge driver module if we don't reprogram. In many
cases, we just work with the existing bitstream before Linux is started.
So generally I prefer not to have an example that gets all bridges at
initialization unless there is a real need.

Thanks,
Yilun

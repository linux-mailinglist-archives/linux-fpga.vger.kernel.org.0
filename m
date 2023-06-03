Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95EE4720FE1
	for <lists+linux-fpga@lfdr.de>; Sat,  3 Jun 2023 13:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbjFCLMV (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 3 Jun 2023 07:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjFCLMU (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 3 Jun 2023 07:12:20 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10AD7133;
        Sat,  3 Jun 2023 04:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685790739; x=1717326739;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tQpbEfI5mySRE7voMPRFgNoLsin+/pbxsffoH1S6pao=;
  b=jvDRn7opiPNUxiWHh0qCk+Jse+1irFuOcjsn9pS4WIU2yb63VwDLYO2J
   kGbhGQ65lOfju340A6m07y5fQAJ52yoBeNgAlRX/+2DYjTvruV25klPAW
   vh6helIQ/Yc2V+YO+woVCNMsvTdA4JD6eBMGbjgjzBp5XspVRDDH3mRAZ
   54ZUNHRr7TTgyeQnj9tnd8Ab9moeQ/BKwJ4f7RqA8ShtJ7uGUhF9V1LBv
   saQ5pF3PuDi1qav5m4CUNTxZrPJQxy5Lk/vb3be+TsM3iGqQR/30yGegl
   w/uoXk/RT+/lWsFO5bRue7nYGxzct50cR3VWkHoa3xg9ZOpnCSYPXCkRR
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="356070542"
X-IronPort-AV: E=Sophos;i="6.00,215,1681196400"; 
   d="scan'208";a="356070542"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2023 04:12:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10729"; a="832254394"
X-IronPort-AV: E=Sophos;i="6.00,215,1681196400"; 
   d="scan'208";a="832254394"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga004.jf.intel.com with ESMTP; 03 Jun 2023 04:12:16 -0700
Date:   Sun, 4 Jun 2023 03:11:47 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Marco Pagani <marpagan@redhat.com>
Cc:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: Re: [RFC PATCH v6 3/4] fpga: add an initial KUnit suite for the FPGA
 Region
Message-ID: <ZHuQc7WfN1zKOeTE@yilunxu-OptiPlex-7050>
References: <20230531095405.342080-1-marpagan@redhat.com>
 <20230531095405.342080-4-marpagan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531095405.342080-4-marpagan@redhat.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2023-05-31 at 11:54:04 +0200, Marco Pagani wrote:
> The suite tests the programming of an FPGA Region with a Bridge
> and the function for finding a particular Region.
> 
> Signed-off-by: Marco Pagani <marpagan@redhat.com>
> ---
>  drivers/fpga/tests/fpga-region-test.c | 186 ++++++++++++++++++++++++++
>  1 file changed, 186 insertions(+)
>  create mode 100644 drivers/fpga/tests/fpga-region-test.c
> 
> diff --git a/drivers/fpga/tests/fpga-region-test.c b/drivers/fpga/tests/fpga-region-test.c
> new file mode 100644
> index 000000000000..81b271088240
> --- /dev/null
> +++ b/drivers/fpga/tests/fpga-region-test.c
> @@ -0,0 +1,186 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * KUnit test for the FPGA Region
> + *
> + * Copyright (C) 2023 Red Hat, Inc.
> + *
> + * Author: Marco Pagani <marpagan@redhat.com>
> + */
> +
> +#include <linux/types.h>
> +#include <linux/module.h>
> +#include <kunit/test.h>
> +#include <linux/platform_device.h>
> +#include <linux/fpga/fpga-mgr.h>
> +#include <linux/fpga/fpga-bridge.h>
> +#include <linux/fpga/fpga-region.h>
> +
> +struct mgr_stats {
> +	u32 write_count;
> +};
> +
> +struct bridge_stats {
> +	u32 enable_count;
> +};
> +
> +struct test_ctx {
> +	struct fpga_manager *mgr;
> +	struct platform_device *mgr_pdev;
> +	struct fpga_bridge *bridge;
> +	struct platform_device *bridge_pdev;
> +	struct fpga_region *region;
> +	struct platform_device *region_pdev;
> +	struct bridge_stats bridge_stats;
> +	struct mgr_stats mgr_stats;
> +};
> +
> +static int op_write(struct fpga_manager *mgr, const char *buf, size_t count)
> +{
> +	struct mgr_stats *stats = mgr->priv;
> +
> +	stats->write_count++;
> +
> +	return 0;
> +}
> +
> +static const struct fpga_manager_ops fake_mgr_ops = {
> +	.write = op_write,
> +};

Maybe better just put all tests in one module, and have unified
fake_mgr_ops/mgr_stats/fake_bridge_ops/bridge_stats across all tests.

In previous thread, I said I'm good to the self-contained test module
but I didn't actually follow the idea. Sorry for that.

The concern is why in this region test, the write_count and only the
write_count is taken care of.

Although fpga_mgr_load() test covers all mgr_ops, but does that
means these ops are still good for more complex case like
fpga_region_program_fpga()? And there is no guarantee
fpga_region_program_fpga() would always call mgr_ops the same way
as fpga_mgr_load() in future.

Similar for fpga_bridge. Maybe a complete setup for fpga_region is
still necessary.

BTW: I like the way that fake drivers are removed. Looks much straight
forward.

Thanks,
Yilun

> +
> +static int op_enable_set(struct fpga_bridge *bridge, bool enable)
> +{
> +	struct bridge_stats *stats = bridge->priv;
> +
> +	if (enable)
> +		stats->enable_count++;
> +
> +	return 0;
> +}
> +
> +static const struct fpga_bridge_ops fake_bridge_ops = {
> +	.enable_set = op_enable_set
> +};
> +
> +static int fake_region_get_bridges(struct fpga_region *region)
> +{
> +	struct fpga_bridge *bridge = region->priv;
> +
> +	return fpga_bridge_get_to_list(bridge->dev.parent, region->info, &region->bridge_list);
> +}
> +
> +static int fake_region_match(struct device *dev, const void *data)
> +{
> +	return dev->parent == data;
> +}
> +
> +static void fpga_region_test_class_find(struct kunit *test)
> +{
> +	struct test_ctx *ctx = test->priv;
> +	struct fpga_region *region;
> +
> +	region = fpga_region_class_find(NULL, &ctx->region_pdev->dev, fake_region_match);
> +	KUNIT_EXPECT_PTR_EQ(test, region, ctx->region);
> +}
> +
> +static void fpga_region_test_program_fpga(struct kunit *test)
> +{
> +	struct test_ctx *ctx = test->priv;
> +	struct fpga_image_info *img_info;
> +	char img_buf[4];
> +	int ret;
> +
> +	img_info = fpga_image_info_alloc(&ctx->mgr_pdev->dev);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, img_info);
> +
> +	img_info->buf = img_buf;
> +	img_info->count = sizeof(img_buf);
> +
> +	ctx->region->info = img_info;
> +	ret = fpga_region_program_fpga(ctx->region);
> +	KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +	KUNIT_EXPECT_EQ(test, 1, ctx->mgr_stats.write_count);
> +	KUNIT_EXPECT_EQ(test, 1, ctx->bridge_stats.enable_count);
> +
> +	fpga_bridges_put(&ctx->region->bridge_list);
> +
> +	ret = fpga_region_program_fpga(ctx->region);
> +	KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +	KUNIT_EXPECT_EQ(test, 2, ctx->mgr_stats.write_count);
> +	KUNIT_EXPECT_EQ(test, 2, ctx->bridge_stats.enable_count);
> +
> +	fpga_bridges_put(&ctx->region->bridge_list);
> +
> +	fpga_image_info_free(img_info);
> +}
> +
> +static int fpga_region_test_init(struct kunit *test)
> +{
> +	struct test_ctx *ctx;
> +	struct fpga_region_info region_info = { 0 };
> +
> +	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
> +
> +	ctx->mgr_pdev = platform_device_register_simple("mgr_pdev", PLATFORM_DEVID_AUTO, NULL, 0);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->mgr_pdev);
> +
> +	ctx->mgr = devm_fpga_mgr_register(&ctx->mgr_pdev->dev, "Fake FPGA Manager", &fake_mgr_ops,
> +					  &ctx->mgr_stats);
> +	KUNIT_ASSERT_FALSE(test, IS_ERR_OR_NULL(ctx->mgr));
> +
> +	ctx->bridge_pdev = platform_device_register_simple("bridge_pdev", PLATFORM_DEVID_AUTO,
> +							   NULL, 0);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->bridge_pdev);
> +
> +	ctx->bridge = fpga_bridge_register(&ctx->bridge_pdev->dev, "Fake FPGA Bridge",
> +					   &fake_bridge_ops, &ctx->bridge_stats);
> +	KUNIT_ASSERT_FALSE(test, IS_ERR_OR_NULL(ctx->bridge));
> +
> +	ctx->region_pdev = platform_device_register_simple("region_pdev", PLATFORM_DEVID_AUTO,
> +							   NULL, 0);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->region_pdev);
> +
> +	region_info.mgr = ctx->mgr;
> +	region_info.priv = ctx->bridge;
> +	region_info.get_bridges = fake_region_get_bridges;
> +
> +	ctx->region = fpga_region_register_full(&ctx->region_pdev->dev, &region_info);
> +	KUNIT_ASSERT_FALSE(test, IS_ERR_OR_NULL(ctx->region));
> +
> +	test->priv = ctx;
> +
> +	return 0;
> +}
> +
> +static void fpga_region_test_exit(struct kunit *test)
> +{
> +	struct test_ctx *ctx = test->priv;
> +
> +	fpga_region_unregister(ctx->region);
> +	platform_device_unregister(ctx->region_pdev);
> +
> +	fpga_bridge_unregister(ctx->bridge);
> +	platform_device_unregister(ctx->bridge_pdev);
> +
> +	platform_device_unregister(ctx->mgr_pdev);
> +}
> +
> +static struct kunit_case fpga_region_test_cases[] = {
> +	KUNIT_CASE(fpga_region_test_class_find),
> +	KUNIT_CASE(fpga_region_test_program_fpga),
> +
> +	{}
> +};
> +
> +static struct kunit_suite fpga_region_suite = {
> +	.name = "fpga_mgr",
> +	.init = fpga_region_test_init,
> +	.exit = fpga_region_test_exit,
> +	.test_cases = fpga_region_test_cases,
> +};
> +
> +kunit_test_suite(fpga_region_suite);
> +
> +MODULE_LICENSE("GPL");
> -- 
> 2.40.1
> 

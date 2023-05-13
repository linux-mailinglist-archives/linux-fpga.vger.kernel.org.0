Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 299877015DA
	for <lists+linux-fpga@lfdr.de>; Sat, 13 May 2023 11:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238230AbjEMJlA (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 13 May 2023 05:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjEMJk7 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 13 May 2023 05:40:59 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1C23C27;
        Sat, 13 May 2023 02:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683970856; x=1715506856;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yL0fm+Az3hzHjrI5x9cinZO6/S1A3nsW9QkVFWhcNTA=;
  b=B2jA0e1i3So6mc87xdZr7uEQ57JBnRlxgYjYIqhnJ5KvGQdhs2I+sOJg
   FY+svEBwURUOl6Z4HLZJOwmUfL3jhEcg6ZKVSoPFotteK+yJlw/szFPCF
   TQp45gnKuW52Odz7p6xGD3Idrk1rVpWpBj1ZhKmxt6kfc/zhSk2Me+M2i
   NkCAi3acxoxh2Nl5/J0AsNNrxXLtUUHuNNfHeW6c3+i07NWBHzekH8E0t
   EAQTKfEwVyMyN/KMv75xVGjv+OJP17vSjn2aWA+0EG6fCfgcnCIWmXqN8
   lA6ja5aZ0pJ/TP2+qhbHfiAiMqRlFK+U7rJdpKix/77TOvMQXy3CUzICs
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="354086825"
X-IronPort-AV: E=Sophos;i="5.99,272,1677571200"; 
   d="scan'208";a="354086825"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2023 02:40:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="824621903"
X-IronPort-AV: E=Sophos;i="5.99,272,1677571200"; 
   d="scan'208";a="824621903"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga004.jf.intel.com with ESMTP; 13 May 2023 02:40:54 -0700
Date:   Sun, 14 May 2023 01:40:53 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Marco Pagani <marpagan@redhat.com>
Cc:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: Re: [RFC PATCH v5 4/4] fpga: add initial KUnit test suites
Message-ID: <ZF/LpdlyBu2Z1uQE@yilunxu-OptiPlex-7050>
References: <20230511141922.437328-1-marpagan@redhat.com>
 <20230511141922.437328-5-marpagan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230511141922.437328-5-marpagan@redhat.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2023-05-11 at 16:19:22 +0200, Marco Pagani wrote:
> Introduce initial KUnit tests for the FPGA subsystem. Tests are organized
> into three test suites. The first suite tests the FPGA Manager.
> The second suite tests the FPGA Bridge. Finally, the last test suite
> models a complete FPGA platform and tests static and partial reconfiguration.
> 
> Signed-off-by: Marco Pagani <marpagan@redhat.com>
> ---
>  drivers/fpga/Kconfig            |   2 +
>  drivers/fpga/Makefile           |   3 +
>  drivers/fpga/tests/.kunitconfig |   5 +
>  drivers/fpga/tests/Kconfig      |  11 +
>  drivers/fpga/tests/Makefile     |   6 +
>  drivers/fpga/tests/fpga-test.c  | 551 ++++++++++++++++++++++++++++++++
>  6 files changed, 578 insertions(+)
>  create mode 100644 drivers/fpga/tests/.kunitconfig
>  create mode 100644 drivers/fpga/tests/Kconfig
>  create mode 100644 drivers/fpga/tests/Makefile
>  create mode 100644 drivers/fpga/tests/fpga-test.c
> 
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index 0a00763b9f28..2f689ac4ba3a 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -276,4 +276,6 @@ config FPGA_MGR_LATTICE_SYSCONFIG_SPI
>  	  FPGA manager driver support for Lattice FPGAs programming over slave
>  	  SPI sysCONFIG interface.
>  
> +source "drivers/fpga/tests/Kconfig"
> +
>  endif # FPGA
> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
> index 72e554b4d2f7..352a2612623e 100644
> --- a/drivers/fpga/Makefile
> +++ b/drivers/fpga/Makefile
> @@ -55,3 +55,6 @@ obj-$(CONFIG_FPGA_DFL_NIOS_INTEL_PAC_N3000)	+= dfl-n3000-nios.o
>  
>  # Drivers for FPGAs which implement DFL
>  obj-$(CONFIG_FPGA_DFL_PCI)		+= dfl-pci.o
> +
> +# KUnit tests
> +obj-$(CONFIG_FPGA_KUNIT_TESTS)		+= tests/
> diff --git a/drivers/fpga/tests/.kunitconfig b/drivers/fpga/tests/.kunitconfig
> new file mode 100644
> index 000000000000..a1c2a2974c39
> --- /dev/null
> +++ b/drivers/fpga/tests/.kunitconfig
> @@ -0,0 +1,5 @@
> +CONFIG_KUNIT=y
> +CONFIG_FPGA=y
> +CONFIG_FPGA_REGION=y
> +CONFIG_FPGA_BRIDGE=y
> +CONFIG_FPGA_KUNIT_TESTS=y
> diff --git a/drivers/fpga/tests/Kconfig b/drivers/fpga/tests/Kconfig
> new file mode 100644
> index 000000000000..1cbea75dd29b
> --- /dev/null
> +++ b/drivers/fpga/tests/Kconfig
> @@ -0,0 +1,11 @@
> +config FPGA_KUNIT_TESTS
> +	tristate "KUnit test for the FPGA subsystem" if !KUNIT_ALL_TESTS
> +	depends on FPGA && FPGA_REGION && FPGA_BRIDGE && KUNIT
> +	default KUNIT_ALL_TESTS
> +        help
> +          This builds unit tests for the FPGA subsystem
> +
> +          For more information on KUnit and unit tests in general,
> +          please refer to the KUnit documentation in Documentation/dev-tools/kunit/.
> +
> +          If unsure, say N.
> diff --git a/drivers/fpga/tests/Makefile b/drivers/fpga/tests/Makefile
> new file mode 100644
> index 000000000000..0b052570659b
> --- /dev/null
> +++ b/drivers/fpga/tests/Makefile
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +obj-$(CONFIG_FPGA_KUNIT_TESTS) += fake-fpga-mgr.o
> +obj-$(CONFIG_FPGA_KUNIT_TESTS) += fake-fpga-region.o
> +obj-$(CONFIG_FPGA_KUNIT_TESTS) += fake-fpga-bridge.o
> +obj-$(CONFIG_FPGA_KUNIT_TESTS) += fpga-test.o
> diff --git a/drivers/fpga/tests/fpga-test.c b/drivers/fpga/tests/fpga-test.c
> new file mode 100644
> index 000000000000..929684c1337e
> --- /dev/null
> +++ b/drivers/fpga/tests/fpga-test.c
> @@ -0,0 +1,551 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * KUnit tests for the FPGA subsystem
> + *
> + * Copyright (C) 2023 Red Hat, Inc.
> + *
> + * Author: Marco Pagani <marpagan@redhat.com>
> + */
> +
> +#include <kunit/test.h>
> +#include <linux/list.h>
> +#include <linux/platform_device.h>
> +#include <linux/scatterlist.h>
> +
> +#include <linux/fpga/fpga-mgr.h>
> +#include <linux/fpga/fpga-region.h>
> +#include <linux/fpga/fpga-bridge.h>
> +
> +#include "fake-fpga-region.h"
> +#include "fake-fpga-bridge.h"
> +#include "fake-fpga-mgr.h"
> +
> +#define STATIC_IMG_BLOCKS	16
> +#define STATIC_IMG_SIZE		(FPGA_IMG_BLOCK * STATIC_IMG_BLOCKS)
> +
> +#define PARTIAL_IMG_BLOCKS	4
> +#define PARTIAL_IMG_SIZE	(FPGA_IMG_BLOCK * PARTIAL_IMG_BLOCKS)
> +
> +/**
> + * fill_test_header() - fill a buffer with the test header data.
> + * @buf: image buffer.
> + * @count: length of the header.
> + */
> +static void fill_test_header(u8 *buf, size_t count)
> +{
> +	size_t i;
> +
> +	for (i = 0; i < count; i++)
> +		buf[i] = TEST_HEADER_MAGIC;
> +}
> +
> +/**
> + * buf_img_alloc() - Allocate a test FPGA image using a buffer.
> + * @test: KUnit test context object.
> + * @dev: owning device.
> + * @size: image size.
> + *
> + * Return: pointer to a struct fpga_image_info or NULL on failure.
> + */
> +static struct fpga_image_info *buf_img_alloc(struct kunit *test, struct device *dev,
> +					     size_t size)
> +{
> +	struct fpga_image_info *img_info;
> +	char *img_buf;
> +
> +	img_buf = kunit_kzalloc(test, size, GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, img_buf);
> +	fill_test_header(img_buf, TEST_HEADER_SIZE);
> +
> +	img_info = fpga_image_info_alloc(dev);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, img_info);
> +
> +	img_info->count = size;
> +	img_info->buf = img_buf;
> +	img_info->header_size = TEST_HEADER_SIZE;
> +
> +	kunit_info(test, "FPGA image allocated in a buffer, size: %zu\n", size);
> +
> +	return img_info;
> +}
> +
> +/**
> + * sgt_img_alloc() - Allocate a test FPGA image using a scatter gather table.
> + * @test: KUnit test context object.
> + * @dev: owning device.
> + * @size: image size.
> + *
> + * Return: pointer to a struct fpga_image_info or NULL on failure.
> + */
> +static struct fpga_image_info *sgt_img_alloc(struct kunit *test, struct device *dev,
> +					     size_t size)
> +{
> +	struct fpga_image_info *img_info;
> +	char *img_buf;
> +	struct sg_table *sgt;
> +	int ret;
> +
> +	img_buf = kunit_kzalloc(test, size, GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, img_buf);
> +	fill_test_header(img_buf, TEST_HEADER_SIZE);
> +
> +	sgt = kunit_kzalloc(test, sizeof(*sgt), GFP_KERNEL);
> +	ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
> +	KUNIT_ASSERT_EQ(test, ret, 0);
> +	sg_init_one(sgt->sgl, img_buf, size);
> +
> +	img_info = fpga_image_info_alloc(dev);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, img_info);
> +
> +	img_info->sgt = sgt;
> +	img_info->header_size = TEST_HEADER_SIZE;
> +
> +	kunit_info(test, "FPGA image allocated in a scatter gather table, size: %zu\n",
> +		   size);
> +
> +	return img_info;
> +}
> +
> +/**
> + * img_free() - Free a test FPGA image
> + * @img_info: fpga image information struct.
> + *
> + */
> +static void img_free(struct fpga_image_info *img_info)
> +{
> +	if (!img_info)
> +		return;
> +
> +	if (img_info->sgt)
> +		sg_free_table(img_info->sgt);
> +
> +	fpga_image_info_free(img_info);
> +}
> +
> +/**
> + * fake_fpga_mgr_check_write() - check if the programming sequence is correct.
> + * @test: KUnit test context object.
> + * @mgr_ctx: fake FPGA manager context data structure.
> + */
> +static void fake_fpga_mgr_check_write(struct kunit *test,
> +				      const struct fake_fpga_mgr *mgr_ctx)
> +{
> +	KUNIT_EXPECT_TRUE(test, mgr_ctx->stats.header_done);
> +
> +	KUNIT_EXPECT_EQ(test, mgr_ctx->stats.op_parse_header_state,
> +			FPGA_MGR_STATE_PARSE_HEADER);
> +	KUNIT_EXPECT_EQ(test, mgr_ctx->stats.op_write_init_state,
> +			FPGA_MGR_STATE_WRITE_INIT);
> +	KUNIT_EXPECT_EQ(test, mgr_ctx->stats.op_write_state,
> +			FPGA_MGR_STATE_WRITE);
> +	KUNIT_EXPECT_EQ(test, mgr_ctx->stats.op_write_complete_state,
> +			FPGA_MGR_STATE_WRITE_COMPLETE);
> +
> +	KUNIT_EXPECT_EQ(test, mgr_ctx->stats.op_write_init_seq,
> +			mgr_ctx->stats.op_parse_header_seq + 1);
> +	KUNIT_EXPECT_EQ(test, mgr_ctx->stats.op_write_seq,
> +			mgr_ctx->stats.op_parse_header_seq + 2);
> +	KUNIT_EXPECT_EQ(test, mgr_ctx->stats.op_write_complete_seq,
> +			mgr_ctx->stats.op_parse_header_seq + 3);
> +}
> +
> +static int fpga_mgr_test_init(struct kunit *test)
> +{
> +	struct fake_fpga_mgr *mgr_ctx;
> +
> +	mgr_ctx = fake_fpga_mgr_register(test, NULL);
> +	KUNIT_ASSERT_FALSE(test, IS_ERR(mgr_ctx));
> +
> +	test->priv = mgr_ctx;
> +
> +	return 0;
> +}
> +
> +static void fpga_mgr_test_img_load_buf(struct kunit *test)
> +{
> +	struct fake_fpga_mgr *mgr_ctx;
> +	struct fpga_image_info *img_info;
> +	int ret;
> +
> +	mgr_ctx = test->priv;
> +
> +	/* Allocate an FPGA image using a buffer */
> +	img_info = buf_img_alloc(test, &mgr_ctx->pdev->dev, STATIC_IMG_SIZE);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, img_info);
> +
> +	KUNIT_EXPECT_EQ(test, 0, mgr_ctx->stats.prog_count);
> +
> +	ret = fpga_mgr_load(mgr_ctx->mgr, img_info);
> +	KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +	fake_fpga_mgr_check_write(test, mgr_ctx);
> +
> +	KUNIT_EXPECT_EQ(test, 1, mgr_ctx->stats.prog_count);
> +
> +	img_free(img_info);
> +}
> +
> +static void fpga_mgr_test_img_load_sgt(struct kunit *test)
> +{
> +	struct fake_fpga_mgr *mgr_ctx;
> +	struct fpga_image_info *img_info;
> +	int ret;
> +
> +	mgr_ctx = test->priv;
> +
> +	/* Allocate an FPGA image using a scatter gather table */
> +	img_info = sgt_img_alloc(test, &mgr_ctx->pdev->dev, STATIC_IMG_SIZE);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, img_info);
> +
> +	KUNIT_EXPECT_EQ(test, 0, mgr_ctx->stats.prog_count);
> +
> +	ret = fpga_mgr_load(mgr_ctx->mgr, img_info);
> +	KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +	fake_fpga_mgr_check_write(test, mgr_ctx);
> +
> +	KUNIT_EXPECT_EQ(test, 1, mgr_ctx->stats.prog_count);
> +
> +	img_free(img_info);
> +}
> +
> +static void fpga_mgr_test_exit(struct kunit *test)
> +{
> +	struct fake_fpga_mgr *mgr_ctx;
> +
> +	mgr_ctx = test->priv;
> +
> +	if (mgr_ctx)
> +		fake_fpga_mgr_unregister(mgr_ctx);
> +}
> +
> +static struct kunit_case fpga_mgr_test_cases[] = {
> +	KUNIT_CASE(fpga_mgr_test_img_load_buf),
> +	KUNIT_CASE(fpga_mgr_test_img_load_sgt),
> +	{}
> +};
> +
> +static struct kunit_suite fpga_mgr_suite = {
> +	.name = "fpga_mgr",
> +	.init = fpga_mgr_test_init,
> +	.exit = fpga_mgr_test_exit,
> +	.test_cases = fpga_mgr_test_cases,
> +};
> +
> +static int fpga_bridge_test_init(struct kunit *test)
> +{
> +	struct fake_fpga_bridge *bridge_ctx;
> +
> +	bridge_ctx = fake_fpga_bridge_register(test, NULL);
> +	KUNIT_ASSERT_FALSE(test, IS_ERR(bridge_ctx));
> +
> +	test->priv = bridge_ctx;
> +
> +	return 0;
> +}
> +
> +static void fpga_bridge_test_exit(struct kunit *test)
> +{
> +	struct fake_fpga_bridge *bridge_ctx;
> +
> +	bridge_ctx = test->priv;
> +
> +	if (bridge_ctx)
> +		fake_fpga_bridge_unregister(bridge_ctx);
> +}
> +
> +static void fpga_bridge_test_toggle(struct kunit *test)
> +{
> +	struct fake_fpga_bridge *bridge_ctx;
> +	int ret;
> +
> +	bridge_ctx = test->priv;
> +
> +	KUNIT_EXPECT_TRUE(test, bridge_ctx->stats.enable);
> +	KUNIT_EXPECT_EQ(test, 0, bridge_ctx->stats.cycles_count);
> +
> +	ret = fpga_bridge_disable(bridge_ctx->bridge);
> +	KUNIT_EXPECT_EQ(test, ret, 0);
> +	KUNIT_EXPECT_FALSE(test, bridge_ctx->stats.enable);
> +
> +	ret = fpga_bridge_enable(bridge_ctx->bridge);
> +	KUNIT_EXPECT_EQ(test, ret, 0);
> +	KUNIT_EXPECT_TRUE(test, bridge_ctx->stats.enable);
> +	KUNIT_EXPECT_EQ(test, 1, bridge_ctx->stats.cycles_count);
> +}
> +
> +static void fpga_bridge_test_get_put_list(struct kunit *test)
> +{
> +	struct list_head bridge_list;
> +	struct fake_fpga_bridge *bridge_0_ctx, *bridge_1_ctx;
> +	int ret;
> +
> +	bridge_0_ctx = test->priv;
> +
> +	/* Register another bridge for this test */
> +	bridge_1_ctx = fake_fpga_bridge_register(test, NULL);
> +	KUNIT_ASSERT_FALSE(test, IS_ERR(bridge_1_ctx));

I think bridge_1 could also be initialized in test_init together with
bridge_0

> +
> +	INIT_LIST_HEAD(&bridge_list);
> +
> +	/* Get bridge_0 and add it to the list */
> +	ret = fpga_bridge_get_to_list(bridge_1_ctx->bridge->dev.parent, NULL,
> +				      &bridge_list);
> +	KUNIT_EXPECT_EQ(test, ret, 0);
> +
> +	KUNIT_EXPECT_PTR_EQ(test, bridge_1_ctx->bridge,
> +			    list_first_entry_or_null(&bridge_list, struct fpga_bridge, node));

Should operate on bridge_0_ctx?

> +
> +	/* Get bridge_1 and add it to the list */
> +	ret = fpga_bridge_get_to_list(bridge_0_ctx->bridge->dev.parent, NULL,
> +				      &bridge_list);
> +	KUNIT_EXPECT_EQ(test, ret, 0);
> +
> +	KUNIT_EXPECT_PTR_EQ(test, bridge_0_ctx->bridge,
> +			    list_first_entry_or_null(&bridge_list, struct fpga_bridge, node));

Should operate on bridge_1_ctx?

> +
> +	/* Disable an then enable both bridges from the list */
> +	KUNIT_EXPECT_TRUE(test, bridge_0_ctx->stats.enable);

Why expect enable without fpga_bridges_enable()?

> +	KUNIT_EXPECT_EQ(test, 0, bridge_0_ctx->stats.cycles_count);
> +
> +	KUNIT_EXPECT_TRUE(test, bridge_1_ctx->stats.enable);
> +	KUNIT_EXPECT_EQ(test, 0, bridge_1_ctx->stats.cycles_count);
> +
> +	ret = fpga_bridges_disable(&bridge_list);
> +	KUNIT_EXPECT_EQ(test, ret, 0);
> +
> +	KUNIT_EXPECT_FALSE(test, bridge_0_ctx->stats.enable);
> +	KUNIT_EXPECT_EQ(test, 0, bridge_0_ctx->stats.cycles_count);
> +
> +	KUNIT_EXPECT_FALSE(test, bridge_1_ctx->stats.enable);
> +	KUNIT_EXPECT_EQ(test, 0, bridge_1_ctx->stats.cycles_count);
> +
> +	ret = fpga_bridges_enable(&bridge_list);
> +	KUNIT_EXPECT_EQ(test, ret, 0);
> +
> +	KUNIT_EXPECT_TRUE(test, bridge_0_ctx->stats.enable);
> +	KUNIT_EXPECT_EQ(test, 1, bridge_0_ctx->stats.cycles_count);
> +
> +	KUNIT_EXPECT_TRUE(test, bridge_1_ctx->stats.enable);
> +	KUNIT_EXPECT_EQ(test, 1, bridge_1_ctx->stats.cycles_count);
> +
> +	/* Put and remove both bridges from the list */
> +	fpga_bridges_put(&bridge_list);
> +
> +	KUNIT_EXPECT_TRUE(test, list_empty(&bridge_list));
> +
> +	fake_fpga_bridge_unregister(bridge_1_ctx);
> +}
> +
> +static struct kunit_case fpga_bridge_test_cases[] = {
> +	KUNIT_CASE(fpga_bridge_test_toggle),
> +	KUNIT_CASE(fpga_bridge_test_get_put_list),
> +	{}
> +};
> +
> +static struct kunit_suite fpga_bridge_suite = {
> +	.name = "fpga_bridge",
> +	.init = fpga_bridge_test_init,
> +	.exit = fpga_bridge_test_exit,
> +	.test_cases = fpga_bridge_test_cases,
> +};
> +
> +struct fpga_base_ctx {
> +	/*
> +	 * Base FPGA layout consisting of a single region
> +	 * controlled by a bridge and the FPGA manager
> +	 */
> +	struct fake_fpga_mgr *mgr_ctx;
> +	struct fake_fpga_bridge *bridge_ctx;
> +	struct fake_fpga_region *region_ctx;
> +};
> +
> +static int fpga_test_init(struct kunit *test)
> +{
> +	struct fpga_base_ctx *base_ctx;
> +	int ret;
> +
> +	base_ctx = kunit_kzalloc(test, sizeof(*base_ctx), GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, base_ctx);
> +	test->priv = base_ctx;
> +
> +	/* Build the base FPGA layout */
> +	base_ctx->mgr_ctx = fake_fpga_mgr_register(test, NULL);
> +	KUNIT_ASSERT_FALSE(test, IS_ERR(base_ctx->mgr_ctx));
> +
> +	base_ctx->bridge_ctx = fake_fpga_bridge_register(test, NULL);
> +	KUNIT_ASSERT_FALSE(test, IS_ERR(base_ctx->bridge_ctx));
> +
> +	/* The base region a child of the base bridge */
> +	base_ctx->region_ctx = fake_fpga_region_register(test, base_ctx->mgr_ctx->mgr,
> +							 &base_ctx->bridge_ctx->bridge->dev);
> +	KUNIT_ASSERT_FALSE(test, IS_ERR(base_ctx->region_ctx));
> +
> +	ret = fake_fpga_region_add_bridge(base_ctx->region_ctx, base_ctx->bridge_ctx->bridge);
> +	KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +	kunit_info(test, "FPGA base system built\n");
> +
> +	KUNIT_EXPECT_EQ(test, 0, base_ctx->mgr_ctx->stats.prog_count);
> +	KUNIT_EXPECT_TRUE(test, base_ctx->bridge_ctx->stats.enable);
> +	KUNIT_EXPECT_EQ(test, 0, base_ctx->bridge_ctx->stats.cycles_count);
> +
> +	return 0;
> +}
> +
> +static void fpga_test_exit(struct kunit *test)
> +{
> +	struct fpga_base_ctx *base_ctx;
> +
> +	base_ctx = test->priv;
> +
> +	if (!base_ctx)
> +		return;
> +
> +	if (base_ctx->region_ctx)
> +		fake_fpga_region_unregister(base_ctx->region_ctx);
> +
> +	if (base_ctx->bridge_ctx)
> +		fake_fpga_bridge_unregister(base_ctx->bridge_ctx);
> +
> +	if (base_ctx->mgr_ctx)
> +		fake_fpga_mgr_unregister(base_ctx->mgr_ctx);
> +}
> +
> +static void fpga_test_static_cfg(struct kunit *test)
> +{
> +	struct fpga_base_ctx *base_ctx;
> +	struct fpga_image_info *buf_img_info;
> +	struct fpga_image_info *sgt_img_info;
> +	int ret;
> +
> +	base_ctx = test->priv;
> +
> +	buf_img_info = buf_img_alloc(test, &base_ctx->mgr_ctx->pdev->dev, STATIC_IMG_SIZE);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf_img_info);
> +
> +	/* Configure the FPGA using the image in a buffer */
> +	base_ctx->region_ctx->region->info = buf_img_info;
> +	ret = fake_fpga_region_program(base_ctx->region_ctx);
> +	KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +	fake_fpga_mgr_check_write(test, base_ctx->mgr_ctx);
> +
> +	KUNIT_EXPECT_EQ(test, 1, base_ctx->mgr_ctx->stats.prog_count);
> +	KUNIT_EXPECT_TRUE(test, base_ctx->bridge_ctx->stats.enable);
> +	KUNIT_EXPECT_EQ(test, 1, base_ctx->bridge_ctx->stats.cycles_count);
> +
> +	kunit_info(test, "FPGA configuration completed using a buffer image\n");
> +
> +	sgt_img_info = sgt_img_alloc(test, &base_ctx->mgr_ctx->pdev->dev, STATIC_IMG_SIZE);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, sgt_img_info);
> +
> +	/* Re-configure the FPGA using the image in a scatter list */
> +	base_ctx->region_ctx->region->info = sgt_img_info;
> +	ret = fake_fpga_region_program(base_ctx->region_ctx);
> +	KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +	fake_fpga_mgr_check_write(test, base_ctx->mgr_ctx);
> +
> +	KUNIT_EXPECT_EQ(test, 2, base_ctx->mgr_ctx->stats.prog_count);
> +	KUNIT_EXPECT_TRUE(test, base_ctx->bridge_ctx->stats.enable);
> +	KUNIT_EXPECT_EQ(test, 2, base_ctx->bridge_ctx->stats.cycles_count);
> +
> +	kunit_info(test, "FPGA configuration completed using scatter gather table image\n");
> +
> +	img_free(sgt_img_info);
> +}
> +
> +static void fpga_test_partial_rcfg(struct kunit *test)
> +{
> +	struct fpga_base_ctx *base_ctx;
> +	struct fake_fpga_region *sub_region_0_ctx, *sub_region_1_ctx;
> +	struct fake_fpga_bridge *sub_bridge_0_ctx, *sub_bridge_1_ctx;
> +	struct fpga_image_info *partial_img_info;
> +	int ret;
> +
> +	base_ctx = test->priv;
> +
> +	/*
> +	 * Add two reconfigurable sub-regions, each controlled by a bridge. The
> +	 * reconfigurable sub-region are children of their bridges which are,
> +	 * in turn, children of the base region. For simplicity, the same image
> +	 * is used to configure reconfigurable regions
> +	 */
> +	sub_bridge_0_ctx = fake_fpga_bridge_register(test,
> +						     &base_ctx->region_ctx->region->dev);
> +	KUNIT_ASSERT_FALSE(test, IS_ERR(sub_bridge_0_ctx));
> +
> +	sub_region_0_ctx = fake_fpga_region_register(test, base_ctx->mgr_ctx->mgr,
> +						     &sub_bridge_0_ctx->bridge->dev);
> +	KUNIT_ASSERT_FALSE(test, IS_ERR(sub_region_0_ctx));
> +
> +	ret = fake_fpga_region_add_bridge(sub_region_0_ctx, sub_bridge_0_ctx->bridge);
> +	KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +	sub_bridge_1_ctx = fake_fpga_bridge_register(test,
> +						     &base_ctx->region_ctx->region->dev);
> +	KUNIT_ASSERT_FALSE(test, IS_ERR(sub_bridge_1_ctx));
> +
> +	sub_region_1_ctx = fake_fpga_region_register(test, base_ctx->mgr_ctx->mgr,
> +						     &sub_bridge_1_ctx->bridge->dev);
> +	KUNIT_ASSERT_FALSE(test, IS_ERR(sub_region_1_ctx));
> +
> +	ret = fake_fpga_region_add_bridge(sub_region_1_ctx, sub_bridge_1_ctx->bridge);
> +	KUNIT_ASSERT_EQ(test, ret, 0);

I'm wondering if we need to construct the topology for partial
reconfiguration test. The FPGA core doesn't actually check the topology.
It is OK to do partial reconfiguration for a region without parents as
long as its associated FPGA manager device has the capability.

Thanks,
Yilun

> +
> +	/* Allocate a partial image using a buffer */
> +	partial_img_info = buf_img_alloc(test, &base_ctx->mgr_ctx->pdev->dev,
> +					 PARTIAL_IMG_SIZE);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, partial_img_info);
> +	partial_img_info->flags = FPGA_MGR_PARTIAL_RECONFIG;
> +
> +	/* Re-configure sub-region 0 with the partial image */
> +	sub_region_0_ctx->region->info = partial_img_info;
> +	ret = fake_fpga_region_program(sub_region_0_ctx);
> +	KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +	fake_fpga_mgr_check_write(test, base_ctx->mgr_ctx);
> +	KUNIT_EXPECT_EQ(test, 1, base_ctx->mgr_ctx->stats.prog_count);
> +
> +	KUNIT_EXPECT_TRUE(test, sub_bridge_0_ctx->stats.enable);
> +	KUNIT_EXPECT_EQ(test, 1, sub_bridge_0_ctx->stats.cycles_count);
> +
> +	/* Re-configure sub-region 1 with the partial image */
> +	sub_region_1_ctx->region->info = partial_img_info;
> +	ret = fake_fpga_region_program(sub_region_1_ctx);
> +	KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +	fake_fpga_mgr_check_write(test, base_ctx->mgr_ctx);
> +	KUNIT_EXPECT_EQ(test, 2, base_ctx->mgr_ctx->stats.prog_count);
> +
> +	KUNIT_EXPECT_TRUE(test, sub_bridge_1_ctx->stats.enable);
> +	KUNIT_EXPECT_EQ(test, 1, sub_bridge_1_ctx->stats.cycles_count);
> +
> +	/* Check that the base bridge has not been disabled during reconfiguration */
> +	KUNIT_EXPECT_TRUE(test, base_ctx->bridge_ctx->stats.enable);
> +	KUNIT_EXPECT_EQ(test, 0, base_ctx->bridge_ctx->stats.cycles_count);
> +
> +	img_free(partial_img_info);
> +	fake_fpga_region_unregister(sub_region_0_ctx);
> +	fake_fpga_bridge_unregister(sub_bridge_0_ctx);
> +	fake_fpga_region_unregister(sub_region_1_ctx);
> +	fake_fpga_bridge_unregister(sub_bridge_1_ctx);
> +}
> +
> +static struct kunit_case fpga_test_cases[] = {
> +	KUNIT_CASE(fpga_test_static_cfg),
> +	KUNIT_CASE(fpga_test_partial_rcfg),
> +	{}
> +};
> +
> +static struct kunit_suite fpga_suite = {
> +	.name = "fpga",
> +	.init = fpga_test_init,
> +	.exit = fpga_test_exit,
> +	.test_cases = fpga_test_cases,
> +};
> +
> +kunit_test_suites(&fpga_mgr_suite, &fpga_bridge_suite, &fpga_suite);
> +
> +MODULE_LICENSE("GPL");
> -- 
> 2.40.1
> 

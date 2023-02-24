Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 993936A1699
	for <lists+linux-fpga@lfdr.de>; Fri, 24 Feb 2023 07:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjBXGZx (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 24 Feb 2023 01:25:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjBXGZw (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 24 Feb 2023 01:25:52 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A7A52DD4;
        Thu, 23 Feb 2023 22:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677219950; x=1708755950;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Mvse0Dk+PVM6ct60Ca8CUltfQlI5dMoqb3qzFdL0Xf0=;
  b=IXsbMzZuOQqz9+5HkqgjTWRQ3FB0LNLAfD+hlan1DnpSUMKmQWc0pQMT
   NDcCHQLR1IALmWRtoMHlEabDk3wykI8sMhQZ176pXJkpLgrfVzETJKCua
   SqEcGGGfyfvEDfB5J2gXfeF42grcqgxewNxWcPlU+mZF/p4TkYWUF7ucU
   xKaHkUUN0Bg5K4+0osyZUZQQtBigfsUppsDeiE5Q44mH2o8Dklay/JiyC
   UDJdXhZYUHAZ5lW1BV8l/+ll+p32nhtO0q6xxTzTiP2BbK77H9ylWaEN5
   QpElF4CBoDS5UvS72UVKQeXvWlZ0pFW4ItyR5IryyacndD0pqdRKIXRod
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="398142068"
X-IronPort-AV: E=Sophos;i="5.97,322,1669104000"; 
   d="scan'208";a="398142068"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2023 22:25:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="666059095"
X-IronPort-AV: E=Sophos;i="5.97,322,1669104000"; 
   d="scan'208";a="666059095"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga007.jf.intel.com with ESMTP; 23 Feb 2023 22:25:48 -0800
Date:   Fri, 24 Feb 2023 14:14:48 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Marco Pagani <marpagan@redhat.com>
Cc:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: Re: [RFC PATCH 1/4] fpga: add initial KUnit test suite
Message-ID: <Y/hV2F8+ZIcG2Bsq@yilunxu-OptiPlex-7050>
References: <20230203170653.414990-1-marpagan@redhat.com>
 <20230203170653.414990-2-marpagan@redhat.com>
 <Y/Chiq2kiAFGZpV6@yilunxu-OptiPlex-7050>
 <8c56c1a2-551d-d3ed-9e32-87ba9b9ea559@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c56c1a2-551d-d3ed-9e32-87ba9b9ea559@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2023-02-21 at 12:10:48 +0100, Marco Pagani wrote:
> 
> 
> On 2023-02-18 10:59, Xu Yilun wrote:
> > On 2023-02-03 at 18:06:50 +0100, Marco Pagani wrote:
> >> Introduce an initial KUnit suite to test the core components of the
> >> FPGA subsystem.
> > 
> > I'm not familiar with kunit, and I spend some time to read the
> > Documentation/dev-tools/kunit/, sorry for late response.
> 
> Thank you for reviewing.
> 
> > 
> >>
> >> The test suite consists of two test cases. The first test case checks
> >> the programming of a static image on a fake FPGA with a single hardware
> >> bridge. The FPGA is first programmed using a test image stored in a
> >> buffer, and then with the same image linked to a single-entry
> >> scatter-gather list.
> >>
> >> The second test case models dynamic partial reconfiguration. The FPGA
> >> is first configured with a static image that implements a
> >> reconfigurable design containing a sub-region controlled by two soft
> >> bridges. Then, the reconfigurable sub-region is reconfigured using
> >> a fake partial bitstream image. After the reconfiguration, the test
> >> checks that the soft bridges have been correctly activated.
> >>
> >> Signed-off-by: Marco Pagani <marpagan@redhat.com>
> >> ---
> >>  drivers/fpga/Kconfig            |   2 +
> >>  drivers/fpga/Makefile           |   3 +
> >>  drivers/fpga/tests/.kunitconfig |   5 +
> >>  drivers/fpga/tests/Kconfig      |  15 ++
> >>  drivers/fpga/tests/Makefile     |   6 +
> >>  drivers/fpga/tests/fpga-tests.c | 264 ++++++++++++++++++++++++++++++++
> >>  6 files changed, 295 insertions(+)
> >>  create mode 100644 drivers/fpga/tests/.kunitconfig
> >>  create mode 100644 drivers/fpga/tests/Kconfig
> >>  create mode 100644 drivers/fpga/tests/Makefile
> >>  create mode 100644 drivers/fpga/tests/fpga-tests.c
> >>
> >> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> >> index 0a00763b9f28..2f689ac4ba3a 100644
> >> --- a/drivers/fpga/Kconfig
> >> +++ b/drivers/fpga/Kconfig
> >> @@ -276,4 +276,6 @@ config FPGA_MGR_LATTICE_SYSCONFIG_SPI
> >>  	  FPGA manager driver support for Lattice FPGAs programming over slave
> >>  	  SPI sysCONFIG interface.
> >>  
> >> +source "drivers/fpga/tests/Kconfig"
> >> +
> >>  endif # FPGA
> >> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
> >> index 72e554b4d2f7..352a2612623e 100644
> >> --- a/drivers/fpga/Makefile
> >> +++ b/drivers/fpga/Makefile
> >> @@ -55,3 +55,6 @@ obj-$(CONFIG_FPGA_DFL_NIOS_INTEL_PAC_N3000)	+= dfl-n3000-nios.o
> >>  
> >>  # Drivers for FPGAs which implement DFL
> >>  obj-$(CONFIG_FPGA_DFL_PCI)		+= dfl-pci.o
> >> +
> >> +# KUnit tests
> >> +obj-$(CONFIG_FPGA_KUNIT_TESTS)		+= tests/
> >> diff --git a/drivers/fpga/tests/.kunitconfig b/drivers/fpga/tests/.kunitconfig
> >> new file mode 100644
> >> index 000000000000..a1c2a2974c39
> >> --- /dev/null
> >> +++ b/drivers/fpga/tests/.kunitconfig
> >> @@ -0,0 +1,5 @@
> >> +CONFIG_KUNIT=y
> >> +CONFIG_FPGA=y
> >> +CONFIG_FPGA_REGION=y
> >> +CONFIG_FPGA_BRIDGE=y
> >> +CONFIG_FPGA_KUNIT_TESTS=y
> >> diff --git a/drivers/fpga/tests/Kconfig b/drivers/fpga/tests/Kconfig
> >> new file mode 100644
> >> index 000000000000..5198e605b38d
> >> --- /dev/null
> >> +++ b/drivers/fpga/tests/Kconfig
> >> @@ -0,0 +1,15 @@
> >> +config FPGA_KUNIT_TESTS
> >> +	tristate "FPGA KUnit tests" if !KUNIT_ALL_TESTS
> >> +	depends on FPGA && FPGA_REGION && FPGA_BRIDGE && KUNIT
> >> +	default KUNIT_ALL_TESTS
> >> +	help
> >> +	  Builds unit tests for the FPGA subsystem. This option
> >> +	  is not useful for distributions or general kernels,
> >> +	  but only for kernel developers working on the FPGA
> >> +	  subsystem and its associated drivers.
> >> +
> >> +	  For more information on KUnit and unit tests in general,
> >> +	  please refer to the KUnit documentation in
> >> +	  Documentation/dev-tools/kunit/.
> >> +
> >> +	  If in doubt, say "N".
> >> diff --git a/drivers/fpga/tests/Makefile b/drivers/fpga/tests/Makefile
> >> new file mode 100644
> >> index 000000000000..74346ae62457
> >> --- /dev/null
> >> +++ b/drivers/fpga/tests/Makefile
> >> @@ -0,0 +1,6 @@
> >> +# SPDX-License-Identifier: GPL-2.0
> >> +
> >> +obj-$(CONFIG_FPGA_KUNIT_TESTS) += fake-fpga-mgr.o
> >> +obj-$(CONFIG_FPGA_KUNIT_TESTS) += fake-fpga-region.o
> >> +obj-$(CONFIG_FPGA_KUNIT_TESTS) += fake-fpga-bridge.o
> > 
> > It is better the patches for fake components come first, otherwise may
> > break the compilation. Also not friendly for review.
> 
> Sorry. I'll change the order in the next version.
> 
> > 
> >> +obj-$(CONFIG_FPGA_KUNIT_TESTS) += fpga-tests.o
> > 
> > Maybe fpga-test.o?
> 
> I'll change the name in the next version.
> 
> > 
> > And could they be built in a single module? I haven't find a reason
> > these fake components been used alone.
> > 
> 
> My feeling is that they could also come in handy to do some general
> development or testing on the subsystem. For instance, I used the fake
> FPGA manager in isolation to experiment with the OF region.

That's fine.

> 
> Initially, the fake manager also had an of_device_id device matching
> struct. However, I later removed it because it was not used for the
> test setup, and I was not sure if adding an OF device matching struct
> was acceptable for a test driver.
> 
> >> diff --git a/drivers/fpga/tests/fpga-tests.c b/drivers/fpga/tests/fpga-tests.c
> >> new file mode 100644
> >> index 000000000000..33f04079b32f
> >> --- /dev/null
> >> +++ b/drivers/fpga/tests/fpga-tests.c
> >> @@ -0,0 +1,264 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * Test suite for the FPGA subsystem
> >> + *
> >> + * Copyright (C) 2023 Red Hat, Inc. All rights reserved.
> >> + *
> >> + * Author: Marco Pagani <marpagan@redhat.com>
> >> + */
> >> +
> >> +#include <kunit/test.h>
> >> +#include <linux/platform_device.h>
> >> +#include <linux/scatterlist.h>
> >> +
> >> +#include <linux/fpga/fpga-mgr.h>
> >> +#include <linux/fpga/fpga-region.h>
> >> +#include <linux/fpga/fpga-bridge.h>
> >> +
> >> +#include "fake-fpga-region.h"
> >> +#include "fake-fpga-bridge.h"
> >> +#include "fake-fpga-mgr.h"
> >> +
> >> +#define FAKE_BIT_BLOCKS		16
> >> +#define FAKE_BIT_SIZE		(FPGA_TEST_BIT_BLOCK * FAKE_BIT_BLOCKS)
> >> +
> >> +static u8 fake_bit[FAKE_BIT_SIZE];
> >> +
> >> +static int init_sgt_bit(struct sg_table *sgt, void *bit, size_t len)
> >> +{
> >> +	int ret;
> >> +
> >> +	ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	sg_init_one(sgt->sgl, bit, len);
> >> +
> >> +	return ret;
> >> +}
> >> +
> >> +static void free_sgt_bit(struct sg_table *sgt)
> >> +{
> >> +	if (sgt)
> >> +		sg_free_table(sgt);
> >> +}
> >> +
> >> +static void fpga_build_base_sys(struct kunit *test, struct fake_fpga_mgr *mgr_ctx,
> >> +				struct fake_fpga_bridge *bridge_ctx,
> >> +				struct fake_fpga_region *region_ctx)
> >> +{
> >> +	int ret;
> >> +
> >> +	ret = fake_fpga_mgr_register(mgr_ctx, test);
> >> +	KUNIT_ASSERT_EQ(test, ret, 0);
> >> +
> >> +	ret = fake_fpga_bridge_register(bridge_ctx, test);
> >> +	KUNIT_ASSERT_EQ(test, ret, 0);
> >> +
> >> +	ret = fake_fpga_region_register(region_ctx, mgr_ctx->mgr, test);
> >> +	KUNIT_ASSERT_EQ(test, ret, 0);
> >> +
> >> +	ret = fake_fpga_region_add_bridge(region_ctx, bridge_ctx->bridge);
> >> +	KUNIT_ASSERT_EQ(test, ret, 0);
> >> +}
> >> +
> >> +static void fpga_free_base_sys(struct fake_fpga_mgr *mgr_ctx,
> >> +			       struct fake_fpga_bridge *bridge_ctx,
> >> +			       struct fake_fpga_region *region_ctx)
> >> +{
> >> +	if (region_ctx)
> >> +		fake_fpga_region_unregister(region_ctx);
> >> +
> >> +	if (bridge_ctx)
> >> +		fake_fpga_bridge_unregister(bridge_ctx);
> >> +
> >> +	if (region_ctx)
> >> +		fake_fpga_mgr_unregister(mgr_ctx);
> >> +}
> >> +
> >> +static int fpga_suite_init(struct kunit_suite *suite)
> >> +{
> >> +	fake_fpga_mgr_fill_header(fake_bit);
> > 
> > Do we need to run it before every case? Or just run once for all cases?
> >
> 
> Just once for all cases. So I'm calling it from the suite_init function.
> 
> For the next version, I'm thinking of allocating the image buffer using
> kunit_kzalloc() instead of using a global static array.
> 
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static void fpga_base_test(struct kunit *test)
> >> +{
> >> +	int ret;
> >> +
> >> +	struct fake_fpga_mgr mgr_ctx;
> >> +	struct fake_fpga_bridge base_bridge_ctx;
> >> +	struct fake_fpga_region base_region_ctx;
> >> +
> >> +	struct fpga_image_info *test_img_info;
> >> +
> >> +	struct sg_table sgt_bit;
> >> +
> >> +	fpga_build_base_sys(test, &mgr_ctx, &base_bridge_ctx, &base_region_ctx);
> >> +
> >> +	/* Allocate a fake test image using a buffer */
> >> +	test_img_info = fpga_image_info_alloc(&mgr_ctx.pdev->dev);
> >> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, test_img_info);
> >> +
> >> +	test_img_info->buf = fake_bit;
> >> +	test_img_info->count = sizeof(fake_bit);
> >> +
> >> +	kunit_info(test, "fake bitstream size: %zu\n", test_img_info->count);
> >> +
> >> +	KUNIT_EXPECT_EQ(test, 0, fake_fpga_mgr_get_rcfg_count(&mgr_ctx));
> >> +
> >> +	KUNIT_EXPECT_EQ(test, 0, fake_fpga_bridge_get_state(&base_bridge_ctx));
> >> +	KUNIT_EXPECT_EQ(test, 0, fake_fpga_bridge_get_cycles_count(&base_bridge_ctx));
> >> +
> >> +	/* Program the fake FPGA using the image buffer */
> >> +	base_region_ctx.region->info = test_img_info;
> >> +	ret = fpga_region_program_fpga(base_region_ctx.region);
> >> +	KUNIT_ASSERT_EQ(test, ret, 0);
> >> +
> >> +	fake_fpga_mgr_check_write_buf(&mgr_ctx);
> >> +
> >> +	KUNIT_EXPECT_EQ(test, 1, fake_fpga_mgr_get_rcfg_count(&mgr_ctx));
> >> +
> >> +	KUNIT_EXPECT_EQ(test, 1, fake_fpga_bridge_get_state(&base_bridge_ctx));
> >> +	KUNIT_EXPECT_EQ(test, 1, fake_fpga_bridge_get_cycles_count(&base_bridge_ctx));
> >> +
> >> +	fpga_image_info_free(test_img_info);
> >> +
> >> +	/* Allocate another fake test image using a scatter list */
> >> +	test_img_info = fpga_image_info_alloc(&mgr_ctx.pdev->dev);
> >> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, test_img_info);
> >> +
> >> +	ret = init_sgt_bit(&sgt_bit, fake_bit, FAKE_BIT_SIZE);
> >> +	KUNIT_ASSERT_EQ(test, ret, 0);
> > 
> > This is not fpga function, do we need the ASSERT?
> >
> 
> You're right. I'll change it to EXPECT.

Mm.. I think we may move the sgt initialization in .suite_init, and just
return ERROR for failure. Does it help to quickly find out this is an
ENV error, not a test case failure?

Thanks,
Yilun

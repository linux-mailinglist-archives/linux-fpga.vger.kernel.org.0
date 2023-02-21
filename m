Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 714B869DE89
	for <lists+linux-fpga@lfdr.de>; Tue, 21 Feb 2023 12:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233893AbjBULMM (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 21 Feb 2023 06:12:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233991AbjBULLp (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 21 Feb 2023 06:11:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370662310B
        for <linux-fpga@vger.kernel.org>; Tue, 21 Feb 2023 03:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676977855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hYQSmw7GwCkxkEir34K+ML1qC05iE401njn+GC4KXGs=;
        b=dCsYUlRobrdHXQJRVgmjJHw8qLdzK4oJzDNVkp/FzbTaxqjV/+SgeszevDc65gvEme1er8
        E/iWocVulhA0ttcj0SylKmw+MFl92V5JtW6+YCb3dkDp0h5GzMwbslzV/BWBmVUNvGFauE
        19ztUvzSxivliI9M1o+ODkvkFmhItbo=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-510-t4bzO9guNJycWHzU2yGQQA-1; Tue, 21 Feb 2023 06:10:52 -0500
X-MC-Unique: t4bzO9guNJycWHzU2yGQQA-1
Received: by mail-ed1-f70.google.com with SMTP id eg35-20020a05640228a300b004ad6e399b73so4704976edb.10
        for <linux-fpga@vger.kernel.org>; Tue, 21 Feb 2023 03:10:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hYQSmw7GwCkxkEir34K+ML1qC05iE401njn+GC4KXGs=;
        b=F9encW9dcsWWmoILMv/uJ9RWe2Odi6brKM4SP/IF192Z8I9PCs7S3l3zAwOFmFGyc0
         VJyOj/9C2F/0TOMwjb3LjyOElEPRMeX+JELW6SrfQoJylUVE20ZM2Prpy5OBgyvBzMUC
         b4B6MxD8n6EqorkO0Xt5sVXpVYDS9ZbpEbn/Nq9UgL1IbYivoMh9GDwkbfkioAdd6Wdl
         83uqnm27tcFVXMh8wixHoFo7D1QP30v1uvKSEOk2FZY21cr/qGXIVwHRQOuY+Bz5lOrG
         kwztttjaf9QO8XdZ+LjRauSLC4eDEfEecwXaAkDyOkhuf8U7OwBNom3hnpV0T5Zn5eSp
         zghA==
X-Gm-Message-State: AO0yUKWN8+L3m2HQQ4FDpDz6pNaaLUvmtF5nulKs6Wjxf9Nqo7+A+KYK
        oajr1ig9WQt5HbW05TdK2KqmeGzi4cVhHPCqsEe0FRlPmVoIANuMb5DuJRhuKl1wOJYtMRVD4Ue
        nK3GpGta3GFwW96V+DEx8
X-Received: by 2002:a17:907:a782:b0:8d9:8f8f:d542 with SMTP id vx2-20020a170907a78200b008d98f8fd542mr6193587ejc.32.1676977850949;
        Tue, 21 Feb 2023 03:10:50 -0800 (PST)
X-Google-Smtp-Source: AK7set+FH89HINgrgCD5Xj5Z9xjTKiVDkTgyyHYNnVMna7OYixdw2ap45Cs1AkOpJDO5/76dT0LLQA==
X-Received: by 2002:a17:907:a782:b0:8d9:8f8f:d542 with SMTP id vx2-20020a170907a78200b008d98f8fd542mr6193547ejc.32.1676977850533;
        Tue, 21 Feb 2023 03:10:50 -0800 (PST)
Received: from [192.168.9.16] (net-2-34-30-183.cust.vodafonedsl.it. [2.34.30.183])
        by smtp.gmail.com with ESMTPSA id gj18-20020a170906e11200b008d47cd2edfbsm2371897ejb.60.2023.02.21.03.10.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 03:10:50 -0800 (PST)
Message-ID: <8c56c1a2-551d-d3ed-9e32-87ba9b9ea559@redhat.com>
Date:   Tue, 21 Feb 2023 12:10:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFC PATCH 1/4] fpga: add initial KUnit test suite
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
References: <20230203170653.414990-1-marpagan@redhat.com>
 <20230203170653.414990-2-marpagan@redhat.com>
 <Y/Chiq2kiAFGZpV6@yilunxu-OptiPlex-7050>
Content-Language: en-US
From:   Marco Pagani <marpagan@redhat.com>
In-Reply-To: <Y/Chiq2kiAFGZpV6@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 2023-02-18 10:59, Xu Yilun wrote:
> On 2023-02-03 at 18:06:50 +0100, Marco Pagani wrote:
>> Introduce an initial KUnit suite to test the core components of the
>> FPGA subsystem.
> 
> I'm not familiar with kunit, and I spend some time to read the
> Documentation/dev-tools/kunit/, sorry for late response.

Thank you for reviewing.

> 
>>
>> The test suite consists of two test cases. The first test case checks
>> the programming of a static image on a fake FPGA with a single hardware
>> bridge. The FPGA is first programmed using a test image stored in a
>> buffer, and then with the same image linked to a single-entry
>> scatter-gather list.
>>
>> The second test case models dynamic partial reconfiguration. The FPGA
>> is first configured with a static image that implements a
>> reconfigurable design containing a sub-region controlled by two soft
>> bridges. Then, the reconfigurable sub-region is reconfigured using
>> a fake partial bitstream image. After the reconfiguration, the test
>> checks that the soft bridges have been correctly activated.
>>
>> Signed-off-by: Marco Pagani <marpagan@redhat.com>
>> ---
>>  drivers/fpga/Kconfig            |   2 +
>>  drivers/fpga/Makefile           |   3 +
>>  drivers/fpga/tests/.kunitconfig |   5 +
>>  drivers/fpga/tests/Kconfig      |  15 ++
>>  drivers/fpga/tests/Makefile     |   6 +
>>  drivers/fpga/tests/fpga-tests.c | 264 ++++++++++++++++++++++++++++++++
>>  6 files changed, 295 insertions(+)
>>  create mode 100644 drivers/fpga/tests/.kunitconfig
>>  create mode 100644 drivers/fpga/tests/Kconfig
>>  create mode 100644 drivers/fpga/tests/Makefile
>>  create mode 100644 drivers/fpga/tests/fpga-tests.c
>>
>> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
>> index 0a00763b9f28..2f689ac4ba3a 100644
>> --- a/drivers/fpga/Kconfig
>> +++ b/drivers/fpga/Kconfig
>> @@ -276,4 +276,6 @@ config FPGA_MGR_LATTICE_SYSCONFIG_SPI
>>  	  FPGA manager driver support for Lattice FPGAs programming over slave
>>  	  SPI sysCONFIG interface.
>>  
>> +source "drivers/fpga/tests/Kconfig"
>> +
>>  endif # FPGA
>> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
>> index 72e554b4d2f7..352a2612623e 100644
>> --- a/drivers/fpga/Makefile
>> +++ b/drivers/fpga/Makefile
>> @@ -55,3 +55,6 @@ obj-$(CONFIG_FPGA_DFL_NIOS_INTEL_PAC_N3000)	+= dfl-n3000-nios.o
>>  
>>  # Drivers for FPGAs which implement DFL
>>  obj-$(CONFIG_FPGA_DFL_PCI)		+= dfl-pci.o
>> +
>> +# KUnit tests
>> +obj-$(CONFIG_FPGA_KUNIT_TESTS)		+= tests/
>> diff --git a/drivers/fpga/tests/.kunitconfig b/drivers/fpga/tests/.kunitconfig
>> new file mode 100644
>> index 000000000000..a1c2a2974c39
>> --- /dev/null
>> +++ b/drivers/fpga/tests/.kunitconfig
>> @@ -0,0 +1,5 @@
>> +CONFIG_KUNIT=y
>> +CONFIG_FPGA=y
>> +CONFIG_FPGA_REGION=y
>> +CONFIG_FPGA_BRIDGE=y
>> +CONFIG_FPGA_KUNIT_TESTS=y
>> diff --git a/drivers/fpga/tests/Kconfig b/drivers/fpga/tests/Kconfig
>> new file mode 100644
>> index 000000000000..5198e605b38d
>> --- /dev/null
>> +++ b/drivers/fpga/tests/Kconfig
>> @@ -0,0 +1,15 @@
>> +config FPGA_KUNIT_TESTS
>> +	tristate "FPGA KUnit tests" if !KUNIT_ALL_TESTS
>> +	depends on FPGA && FPGA_REGION && FPGA_BRIDGE && KUNIT
>> +	default KUNIT_ALL_TESTS
>> +	help
>> +	  Builds unit tests for the FPGA subsystem. This option
>> +	  is not useful for distributions or general kernels,
>> +	  but only for kernel developers working on the FPGA
>> +	  subsystem and its associated drivers.
>> +
>> +	  For more information on KUnit and unit tests in general,
>> +	  please refer to the KUnit documentation in
>> +	  Documentation/dev-tools/kunit/.
>> +
>> +	  If in doubt, say "N".
>> diff --git a/drivers/fpga/tests/Makefile b/drivers/fpga/tests/Makefile
>> new file mode 100644
>> index 000000000000..74346ae62457
>> --- /dev/null
>> +++ b/drivers/fpga/tests/Makefile
>> @@ -0,0 +1,6 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +
>> +obj-$(CONFIG_FPGA_KUNIT_TESTS) += fake-fpga-mgr.o
>> +obj-$(CONFIG_FPGA_KUNIT_TESTS) += fake-fpga-region.o
>> +obj-$(CONFIG_FPGA_KUNIT_TESTS) += fake-fpga-bridge.o
> 
> It is better the patches for fake components come first, otherwise may
> break the compilation. Also not friendly for review.

Sorry. I'll change the order in the next version.

> 
>> +obj-$(CONFIG_FPGA_KUNIT_TESTS) += fpga-tests.o
> 
> Maybe fpga-test.o?

I'll change the name in the next version.

> 
> And could they be built in a single module? I haven't find a reason
> these fake components been used alone.
> 

My feeling is that they could also come in handy to do some general
development or testing on the subsystem. For instance, I used the fake
FPGA manager in isolation to experiment with the OF region.

Initially, the fake manager also had an of_device_id device matching
struct. However, I later removed it because it was not used for the
test setup, and I was not sure if adding an OF device matching struct
was acceptable for a test driver.

>> diff --git a/drivers/fpga/tests/fpga-tests.c b/drivers/fpga/tests/fpga-tests.c
>> new file mode 100644
>> index 000000000000..33f04079b32f
>> --- /dev/null
>> +++ b/drivers/fpga/tests/fpga-tests.c
>> @@ -0,0 +1,264 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Test suite for the FPGA subsystem
>> + *
>> + * Copyright (C) 2023 Red Hat, Inc. All rights reserved.
>> + *
>> + * Author: Marco Pagani <marpagan@redhat.com>
>> + */
>> +
>> +#include <kunit/test.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/scatterlist.h>
>> +
>> +#include <linux/fpga/fpga-mgr.h>
>> +#include <linux/fpga/fpga-region.h>
>> +#include <linux/fpga/fpga-bridge.h>
>> +
>> +#include "fake-fpga-region.h"
>> +#include "fake-fpga-bridge.h"
>> +#include "fake-fpga-mgr.h"
>> +
>> +#define FAKE_BIT_BLOCKS		16
>> +#define FAKE_BIT_SIZE		(FPGA_TEST_BIT_BLOCK * FAKE_BIT_BLOCKS)
>> +
>> +static u8 fake_bit[FAKE_BIT_SIZE];
>> +
>> +static int init_sgt_bit(struct sg_table *sgt, void *bit, size_t len)
>> +{
>> +	int ret;
>> +
>> +	ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
>> +	if (ret)
>> +		return ret;
>> +
>> +	sg_init_one(sgt->sgl, bit, len);
>> +
>> +	return ret;
>> +}
>> +
>> +static void free_sgt_bit(struct sg_table *sgt)
>> +{
>> +	if (sgt)
>> +		sg_free_table(sgt);
>> +}
>> +
>> +static void fpga_build_base_sys(struct kunit *test, struct fake_fpga_mgr *mgr_ctx,
>> +				struct fake_fpga_bridge *bridge_ctx,
>> +				struct fake_fpga_region *region_ctx)
>> +{
>> +	int ret;
>> +
>> +	ret = fake_fpga_mgr_register(mgr_ctx, test);
>> +	KUNIT_ASSERT_EQ(test, ret, 0);
>> +
>> +	ret = fake_fpga_bridge_register(bridge_ctx, test);
>> +	KUNIT_ASSERT_EQ(test, ret, 0);
>> +
>> +	ret = fake_fpga_region_register(region_ctx, mgr_ctx->mgr, test);
>> +	KUNIT_ASSERT_EQ(test, ret, 0);
>> +
>> +	ret = fake_fpga_region_add_bridge(region_ctx, bridge_ctx->bridge);
>> +	KUNIT_ASSERT_EQ(test, ret, 0);
>> +}
>> +
>> +static void fpga_free_base_sys(struct fake_fpga_mgr *mgr_ctx,
>> +			       struct fake_fpga_bridge *bridge_ctx,
>> +			       struct fake_fpga_region *region_ctx)
>> +{
>> +	if (region_ctx)
>> +		fake_fpga_region_unregister(region_ctx);
>> +
>> +	if (bridge_ctx)
>> +		fake_fpga_bridge_unregister(bridge_ctx);
>> +
>> +	if (region_ctx)
>> +		fake_fpga_mgr_unregister(mgr_ctx);
>> +}
>> +
>> +static int fpga_suite_init(struct kunit_suite *suite)
>> +{
>> +	fake_fpga_mgr_fill_header(fake_bit);
> 
> Do we need to run it before every case? Or just run once for all cases?
>

Just once for all cases. So I'm calling it from the suite_init function.

For the next version, I'm thinking of allocating the image buffer using
kunit_kzalloc() instead of using a global static array.

>> +
>> +	return 0;
>> +}
>> +
>> +static void fpga_base_test(struct kunit *test)
>> +{
>> +	int ret;
>> +
>> +	struct fake_fpga_mgr mgr_ctx;
>> +	struct fake_fpga_bridge base_bridge_ctx;
>> +	struct fake_fpga_region base_region_ctx;
>> +
>> +	struct fpga_image_info *test_img_info;
>> +
>> +	struct sg_table sgt_bit;
>> +
>> +	fpga_build_base_sys(test, &mgr_ctx, &base_bridge_ctx, &base_region_ctx);
>> +
>> +	/* Allocate a fake test image using a buffer */
>> +	test_img_info = fpga_image_info_alloc(&mgr_ctx.pdev->dev);
>> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, test_img_info);
>> +
>> +	test_img_info->buf = fake_bit;
>> +	test_img_info->count = sizeof(fake_bit);
>> +
>> +	kunit_info(test, "fake bitstream size: %zu\n", test_img_info->count);
>> +
>> +	KUNIT_EXPECT_EQ(test, 0, fake_fpga_mgr_get_rcfg_count(&mgr_ctx));
>> +
>> +	KUNIT_EXPECT_EQ(test, 0, fake_fpga_bridge_get_state(&base_bridge_ctx));
>> +	KUNIT_EXPECT_EQ(test, 0, fake_fpga_bridge_get_cycles_count(&base_bridge_ctx));
>> +
>> +	/* Program the fake FPGA using the image buffer */
>> +	base_region_ctx.region->info = test_img_info;
>> +	ret = fpga_region_program_fpga(base_region_ctx.region);
>> +	KUNIT_ASSERT_EQ(test, ret, 0);
>> +
>> +	fake_fpga_mgr_check_write_buf(&mgr_ctx);
>> +
>> +	KUNIT_EXPECT_EQ(test, 1, fake_fpga_mgr_get_rcfg_count(&mgr_ctx));
>> +
>> +	KUNIT_EXPECT_EQ(test, 1, fake_fpga_bridge_get_state(&base_bridge_ctx));
>> +	KUNIT_EXPECT_EQ(test, 1, fake_fpga_bridge_get_cycles_count(&base_bridge_ctx));
>> +
>> +	fpga_image_info_free(test_img_info);
>> +
>> +	/* Allocate another fake test image using a scatter list */
>> +	test_img_info = fpga_image_info_alloc(&mgr_ctx.pdev->dev);
>> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, test_img_info);
>> +
>> +	ret = init_sgt_bit(&sgt_bit, fake_bit, FAKE_BIT_SIZE);
>> +	KUNIT_ASSERT_EQ(test, ret, 0);
> 
> This is not fpga function, do we need the ASSERT?
>

You're right. I'll change it to EXPECT.
 
>> +
>> +	test_img_info->sgt = &sgt_bit;
>> +
>> +	/* Re-program the fake FPGA using the image scatter list */
>> +	base_region_ctx.region->info = test_img_info;
>> +	ret = fpga_region_program_fpga(base_region_ctx.region);
>> +	KUNIT_ASSERT_EQ(test, ret, 0);
>> +
>> +	fake_fpga_mgr_check_write_sg(&mgr_ctx);
>> +
>> +	KUNIT_EXPECT_EQ(test, 2, fake_fpga_mgr_get_rcfg_count(&mgr_ctx));
>> +
>> +	KUNIT_EXPECT_EQ(test, 1, fake_fpga_bridge_get_state(&base_bridge_ctx));
>> +	KUNIT_EXPECT_EQ(test, 2, fake_fpga_bridge_get_cycles_count(&base_bridge_ctx));
>> +
>> +	free_sgt_bit(&sgt_bit);
>> +	fpga_image_info_free(test_img_info);
>> +	fpga_free_base_sys(&mgr_ctx, &base_bridge_ctx, &base_region_ctx);
>> +}
>> +
>> +static void fpga_pr_test(struct kunit *test)
>> +{
>> +	int ret;
>> +
>> +	struct fake_fpga_mgr mgr_ctx;
>> +	struct fake_fpga_bridge base_bridge_ctx;
>> +	struct fake_fpga_region base_region_ctx;
>> +
>> +	struct fake_fpga_bridge pr_bridge_0_ctx;
>> +	struct fake_fpga_bridge pr_bridge_1_ctx;
>> +	struct fake_fpga_region pr_region_ctx;
>> +
>> +	struct fpga_image_info *test_static_img_info;
>> +	struct fpga_image_info *test_pr_img_info;
>> +
>> +	fpga_build_base_sys(test, &mgr_ctx, &base_bridge_ctx, &base_region_ctx);
> 
> If we need the base region/bridge/mgr for each case, could we create
> global ones in .init(), or .suite_init()?
>

Ok, I'll reduce code duplication in the next version. My only concern is that
I would not want to complicate the test code.

In my intentions, this is just an initial set of tests intended to lay the
foundation for other test suites. At this stage, I'm not sure if other tests
will need or use this kind of setup. So I would like to keep the test code
as simple as possible.

>> +
>> +	/* Allocate a fake test image using a buffer */
>> +	test_static_img_info = fpga_image_info_alloc(&mgr_ctx.pdev->dev);
>> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, test_static_img_info);
>> +
>> +	test_static_img_info->buf = fake_bit;
>> +	test_static_img_info->count = sizeof(fake_bit);
> 
> Same concern, may remove the test image info initialization from each
> test case code.
> 

Same as above, I'll reduce code duplication in the next version.

>> +
>> +	kunit_info(test, "fake bitstream size: %zu\n", test_static_img_info->count);
>> +
>> +	KUNIT_EXPECT_EQ(test, 0, fake_fpga_mgr_get_rcfg_count(&mgr_ctx));
>> +
>> +	KUNIT_EXPECT_EQ(test, 0, fake_fpga_bridge_get_state(&base_bridge_ctx));
>> +	KUNIT_EXPECT_EQ(test, 0, fake_fpga_bridge_get_cycles_count(&base_bridge_ctx));
>> +
>> +	/* Program the fake FPGA using the image buffer */
>> +	base_region_ctx.region->info = test_static_img_info;
>> +	ret = fpga_region_program_fpga(base_region_ctx.region);
>> +	KUNIT_ASSERT_EQ(test, ret, 0);
>> +
>> +	fake_fpga_mgr_check_write_buf(&mgr_ctx);
>> +
>> +	KUNIT_EXPECT_EQ(test, 1, fake_fpga_mgr_get_rcfg_count(&mgr_ctx));
>> +
>> +	KUNIT_EXPECT_EQ(test, 1, fake_fpga_bridge_get_state(&base_bridge_ctx));
>> +	KUNIT_EXPECT_EQ(test, 1, fake_fpga_bridge_get_cycles_count(&base_bridge_ctx));
>> +
>> +	/* The static image contains a reconfigurable sub-region with two soft bridges */
> 
> Till now I didn't find any difference with fpga_base_test.
> And I can't figure out how the "static parent region - sub pr region"
> topology is created?
> 

You're right, the topology is missing. I'm preparing a new version where regions
are hierarchically organized according to the FPGA Region DT binding documentation.
I.e., the static region is the parent device of the reconfigurable region.

>> +	ret = fake_fpga_bridge_register(&pr_bridge_0_ctx, test);
>> +	KUNIT_ASSERT_EQ(test, ret, 0);
>> +
>> +	ret = fake_fpga_bridge_register(&pr_bridge_1_ctx, test);
>> +	KUNIT_ASSERT_EQ(test, ret, 0);
>> +
>> +	ret = fake_fpga_region_register(&pr_region_ctx, mgr_ctx.mgr, test);
>> +	KUNIT_ASSERT_EQ(test, ret, 0);
>> +
>> +	ret = fake_fpga_region_add_bridge(&pr_region_ctx, pr_bridge_0_ctx.bridge);
>> +	KUNIT_ASSERT_EQ(test, ret, 0);
>> +
>> +	ret = fake_fpga_region_add_bridge(&pr_region_ctx, pr_bridge_1_ctx.bridge);
>> +	KUNIT_ASSERT_EQ(test, ret, 0);
>> +
>> +	/* Allocate a fake partial test image using a buffer */
>> +	test_pr_img_info = fpga_image_info_alloc(&mgr_ctx.pdev->dev);
>> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, test_pr_img_info);
>> +
>> +	test_pr_img_info->buf = fake_bit;
>> +	test_pr_img_info->count = sizeof(fake_bit) / 2;
>> +	test_pr_img_info->flags = FPGA_MGR_PARTIAL_RECONFIG;
>> +
>> +	kunit_info(test, "fake partial bitstream size: %zu\n", test_pr_img_info->count);
>> +
>> +	/* Program the reconfigurable sub-region */
>> +	pr_region_ctx.region->info = test_pr_img_info;
>> +	ret = fpga_region_program_fpga(pr_region_ctx.region);
>> +	KUNIT_ASSERT_EQ(test, ret, 0);
>> +
>> +	fake_fpga_mgr_check_write_buf(&mgr_ctx);
>> +
>> +	KUNIT_EXPECT_EQ(test, 2, fake_fpga_mgr_get_rcfg_count(&mgr_ctx));
>> +
>> +	KUNIT_EXPECT_EQ(test, 1, fake_fpga_bridge_get_state(&pr_bridge_0_ctx));
>> +	KUNIT_EXPECT_EQ(test, 1, fake_fpga_bridge_get_cycles_count(&pr_bridge_0_ctx));
>> +
>> +	KUNIT_EXPECT_EQ(test, 1, fake_fpga_bridge_get_state(&pr_bridge_1_ctx));
>> +	KUNIT_EXPECT_EQ(test, 1, fake_fpga_bridge_get_cycles_count(&pr_bridge_1_ctx));
>> +
>> +	/* Check that the base bridge has not been disabled */
>> +	KUNIT_EXPECT_EQ(test, 1, fake_fpga_bridge_get_state(&base_bridge_ctx));
>> +	KUNIT_EXPECT_EQ(test, 1, fake_fpga_bridge_get_cycles_count(&base_bridge_ctx));
>> +
>> +	fpga_image_info_free(test_pr_img_info);
>> +	fpga_image_info_free(test_static_img_info);
>> +
>> +	fake_fpga_region_unregister(&pr_region_ctx);
>> +	fake_fpga_bridge_unregister(&pr_bridge_0_ctx);
>> +	fake_fpga_bridge_unregister(&pr_bridge_1_ctx);
>> +
>> +	fpga_free_base_sys(&mgr_ctx, &base_bridge_ctx, &base_region_ctx);
> 
> Same concern, may put them in .exit() or suite_exit()?

Same as above, I'll reduce code duplication.

> 
>> +}
>> +
>> +static struct kunit_case fpga_test_cases[] = {
>> +	KUNIT_CASE(fpga_base_test),
>> +	KUNIT_CASE(fpga_pr_test),
> 
> I feel there are too many tasks for each test case, and some duplicated
> routines.
> 
> Could we have a suite for the common routine test in each case, like
> region/bridge/mgr (un)register, fpga image alloc ... And another suite
> which have these common routines in .init() or .suite_init().
>

Right, I'll reduce code duplication in the next version.

>> +	{},
>> +};
>> +
>> +static struct kunit_suite fpga_test_suite = {
>> +	.name = "fpga-tests",
> 
> I see from style.rst that:
>   
>   "Names should use underscores, not dashes, to separate words"
> 
> and
> 
>   "*Do not* include "test" or "kunit" directly in the subsystem name
>    unless we are actually testing other tests or the kunit framework
>    itself"
> 
> So IIUC I assume the name should be "fpga"?
> 
> BTW: I do see some existing test cases that are not conform to the style,
> even the examples in doc itself.

Thanks for noticing this. I'll change the name in the next version.

> 
> Thanks,
> Yilun
> 
>> +	.suite_init = fpga_suite_init,
>> +	.test_cases = fpga_test_cases,
>> +};
>> +
>> +kunit_test_suite(fpga_test_suite);
>> -- 
>> 2.39.1
>>
> 

Thanks,
Marco


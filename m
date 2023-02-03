Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 381D7689FFB
	for <lists+linux-fpga@lfdr.de>; Fri,  3 Feb 2023 18:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbjBCRIN (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 3 Feb 2023 12:08:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232835AbjBCRIL (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 3 Feb 2023 12:08:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770CD9D076
        for <linux-fpga@vger.kernel.org>; Fri,  3 Feb 2023 09:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675444038;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QQmhmkEzd3xkaSu4HvpTV2rx3eqChwz0npZXZDCowYk=;
        b=S9i4U2qQ5Ir1g6CBxz5LWKY11qvlu8k1V7XZRpMSpmHop/GAM8rnaSg250xeI5B2115qug
        pLWAFQ7teKXJzvKPJVppCHqk0G8aycJvbFaOqgOVw2mUnXlsQ58xKCYgvT5NtPZ2MLYabn
        tRVJ2woXBJAs6lOgUiQ1L04h7mgGKvs=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-659-HBMYz4vSO4SuQGV0cNi0Cw-1; Fri, 03 Feb 2023 12:07:17 -0500
X-MC-Unique: HBMYz4vSO4SuQGV0cNi0Cw-1
Received: by mail-qk1-f200.google.com with SMTP id s7-20020ae9f707000000b007294677a6e8so3672537qkg.17
        for <linux-fpga@vger.kernel.org>; Fri, 03 Feb 2023 09:07:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QQmhmkEzd3xkaSu4HvpTV2rx3eqChwz0npZXZDCowYk=;
        b=4mYP5VemXhnhs8nWUJobqf+Vb3iz3LH9uhUFwRHx1E0SjJmVcNBW9DVYgtTp202Qif
         XdO4aeIP4Sr5olVaFRqfSwBO7OPH+l5mESR6i7AYJE2U5VVrWgJ2OALWIBzi57DbXAfN
         gboBv+NWXZhLoV/aT0LtzRf59UAdHqPe5E7HnrooWqilK96e6+26ynidwKUU73wO7H/T
         Q9LRNwFn5Z6uU6MFjPcSjyLFAlyX9AS7MtRTsxPDud2PXnWiv+pkXbTo2SBff7HGsEfT
         Z1WRQ5nMidAuXn/IYv+tJxt20YsrKf9/wmzk6FBAFFCxNmlfZQ/L86S+phbPxpN0evr9
         N2PQ==
X-Gm-Message-State: AO0yUKXCj+K4ue/kMtgjBbw+J+WHuPt7qnA0w3PGr9niM0d+0MOi48o2
        arnbsePgHC4e4uIhkBvvwPgt3HLoZJwNM7OTfapyl13z5MZ+Vd6H5WXMQrIGsRz56dBLHhtFIBz
        6kpik5D4FbTFKWbxvraj1
X-Received: by 2002:a05:622a:14ca:b0:3b8:58d0:b4e4 with SMTP id u10-20020a05622a14ca00b003b858d0b4e4mr19562219qtx.33.1675444036418;
        Fri, 03 Feb 2023 09:07:16 -0800 (PST)
X-Google-Smtp-Source: AK7set9x8dWaBd+yCZwsjADawRgWA+tKJHY1o36x7wjhrDbsFVesaFoSBOd4OrnSGwH5yKnajeSjig==
X-Received: by 2002:a05:622a:14ca:b0:3b8:58d0:b4e4 with SMTP id u10-20020a05622a14ca00b003b858d0b4e4mr19562176qtx.33.1675444036095;
        Fri, 03 Feb 2023 09:07:16 -0800 (PST)
Received: from klayman.redhat.com (net-2-34-30-183.cust.vodafonedsl.it. [2.34.30.183])
        by smtp.gmail.com with ESMTPSA id b13-20020ac801cd000000b003a6a19ee4f0sm1884287qtg.33.2023.02.03.09.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 09:07:15 -0800 (PST)
From:   Marco Pagani <marpagan@redhat.com>
To:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
Cc:     Marco Pagani <marpagan@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: [RFC PATCH 1/4] fpga: add initial KUnit test suite
Date:   Fri,  3 Feb 2023 18:06:50 +0100
Message-Id: <20230203170653.414990-2-marpagan@redhat.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230203170653.414990-1-marpagan@redhat.com>
References: <20230203170653.414990-1-marpagan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Introduce an initial KUnit suite to test the core components of the
FPGA subsystem.

The test suite consists of two test cases. The first test case checks
the programming of a static image on a fake FPGA with a single hardware
bridge. The FPGA is first programmed using a test image stored in a
buffer, and then with the same image linked to a single-entry
scatter-gather list.

The second test case models dynamic partial reconfiguration. The FPGA
is first configured with a static image that implements a
reconfigurable design containing a sub-region controlled by two soft
bridges. Then, the reconfigurable sub-region is reconfigured using
a fake partial bitstream image. After the reconfiguration, the test
checks that the soft bridges have been correctly activated.

Signed-off-by: Marco Pagani <marpagan@redhat.com>
---
 drivers/fpga/Kconfig            |   2 +
 drivers/fpga/Makefile           |   3 +
 drivers/fpga/tests/.kunitconfig |   5 +
 drivers/fpga/tests/Kconfig      |  15 ++
 drivers/fpga/tests/Makefile     |   6 +
 drivers/fpga/tests/fpga-tests.c | 264 ++++++++++++++++++++++++++++++++
 6 files changed, 295 insertions(+)
 create mode 100644 drivers/fpga/tests/.kunitconfig
 create mode 100644 drivers/fpga/tests/Kconfig
 create mode 100644 drivers/fpga/tests/Makefile
 create mode 100644 drivers/fpga/tests/fpga-tests.c

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 0a00763b9f28..2f689ac4ba3a 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -276,4 +276,6 @@ config FPGA_MGR_LATTICE_SYSCONFIG_SPI
 	  FPGA manager driver support for Lattice FPGAs programming over slave
 	  SPI sysCONFIG interface.
 
+source "drivers/fpga/tests/Kconfig"
+
 endif # FPGA
diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
index 72e554b4d2f7..352a2612623e 100644
--- a/drivers/fpga/Makefile
+++ b/drivers/fpga/Makefile
@@ -55,3 +55,6 @@ obj-$(CONFIG_FPGA_DFL_NIOS_INTEL_PAC_N3000)	+= dfl-n3000-nios.o
 
 # Drivers for FPGAs which implement DFL
 obj-$(CONFIG_FPGA_DFL_PCI)		+= dfl-pci.o
+
+# KUnit tests
+obj-$(CONFIG_FPGA_KUNIT_TESTS)		+= tests/
diff --git a/drivers/fpga/tests/.kunitconfig b/drivers/fpga/tests/.kunitconfig
new file mode 100644
index 000000000000..a1c2a2974c39
--- /dev/null
+++ b/drivers/fpga/tests/.kunitconfig
@@ -0,0 +1,5 @@
+CONFIG_KUNIT=y
+CONFIG_FPGA=y
+CONFIG_FPGA_REGION=y
+CONFIG_FPGA_BRIDGE=y
+CONFIG_FPGA_KUNIT_TESTS=y
diff --git a/drivers/fpga/tests/Kconfig b/drivers/fpga/tests/Kconfig
new file mode 100644
index 000000000000..5198e605b38d
--- /dev/null
+++ b/drivers/fpga/tests/Kconfig
@@ -0,0 +1,15 @@
+config FPGA_KUNIT_TESTS
+	tristate "FPGA KUnit tests" if !KUNIT_ALL_TESTS
+	depends on FPGA && FPGA_REGION && FPGA_BRIDGE && KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  Builds unit tests for the FPGA subsystem. This option
+	  is not useful for distributions or general kernels,
+	  but only for kernel developers working on the FPGA
+	  subsystem and its associated drivers.
+
+	  For more information on KUnit and unit tests in general,
+	  please refer to the KUnit documentation in
+	  Documentation/dev-tools/kunit/.
+
+	  If in doubt, say "N".
diff --git a/drivers/fpga/tests/Makefile b/drivers/fpga/tests/Makefile
new file mode 100644
index 000000000000..74346ae62457
--- /dev/null
+++ b/drivers/fpga/tests/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_FPGA_KUNIT_TESTS) += fake-fpga-mgr.o
+obj-$(CONFIG_FPGA_KUNIT_TESTS) += fake-fpga-region.o
+obj-$(CONFIG_FPGA_KUNIT_TESTS) += fake-fpga-bridge.o
+obj-$(CONFIG_FPGA_KUNIT_TESTS) += fpga-tests.o
diff --git a/drivers/fpga/tests/fpga-tests.c b/drivers/fpga/tests/fpga-tests.c
new file mode 100644
index 000000000000..33f04079b32f
--- /dev/null
+++ b/drivers/fpga/tests/fpga-tests.c
@@ -0,0 +1,264 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Test suite for the FPGA subsystem
+ *
+ * Copyright (C) 2023 Red Hat, Inc. All rights reserved.
+ *
+ * Author: Marco Pagani <marpagan@redhat.com>
+ */
+
+#include <kunit/test.h>
+#include <linux/platform_device.h>
+#include <linux/scatterlist.h>
+
+#include <linux/fpga/fpga-mgr.h>
+#include <linux/fpga/fpga-region.h>
+#include <linux/fpga/fpga-bridge.h>
+
+#include "fake-fpga-region.h"
+#include "fake-fpga-bridge.h"
+#include "fake-fpga-mgr.h"
+
+#define FAKE_BIT_BLOCKS		16
+#define FAKE_BIT_SIZE		(FPGA_TEST_BIT_BLOCK * FAKE_BIT_BLOCKS)
+
+static u8 fake_bit[FAKE_BIT_SIZE];
+
+static int init_sgt_bit(struct sg_table *sgt, void *bit, size_t len)
+{
+	int ret;
+
+	ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
+	if (ret)
+		return ret;
+
+	sg_init_one(sgt->sgl, bit, len);
+
+	return ret;
+}
+
+static void free_sgt_bit(struct sg_table *sgt)
+{
+	if (sgt)
+		sg_free_table(sgt);
+}
+
+static void fpga_build_base_sys(struct kunit *test, struct fake_fpga_mgr *mgr_ctx,
+				struct fake_fpga_bridge *bridge_ctx,
+				struct fake_fpga_region *region_ctx)
+{
+	int ret;
+
+	ret = fake_fpga_mgr_register(mgr_ctx, test);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	ret = fake_fpga_bridge_register(bridge_ctx, test);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	ret = fake_fpga_region_register(region_ctx, mgr_ctx->mgr, test);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	ret = fake_fpga_region_add_bridge(region_ctx, bridge_ctx->bridge);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+}
+
+static void fpga_free_base_sys(struct fake_fpga_mgr *mgr_ctx,
+			       struct fake_fpga_bridge *bridge_ctx,
+			       struct fake_fpga_region *region_ctx)
+{
+	if (region_ctx)
+		fake_fpga_region_unregister(region_ctx);
+
+	if (bridge_ctx)
+		fake_fpga_bridge_unregister(bridge_ctx);
+
+	if (region_ctx)
+		fake_fpga_mgr_unregister(mgr_ctx);
+}
+
+static int fpga_suite_init(struct kunit_suite *suite)
+{
+	fake_fpga_mgr_fill_header(fake_bit);
+
+	return 0;
+}
+
+static void fpga_base_test(struct kunit *test)
+{
+	int ret;
+
+	struct fake_fpga_mgr mgr_ctx;
+	struct fake_fpga_bridge base_bridge_ctx;
+	struct fake_fpga_region base_region_ctx;
+
+	struct fpga_image_info *test_img_info;
+
+	struct sg_table sgt_bit;
+
+	fpga_build_base_sys(test, &mgr_ctx, &base_bridge_ctx, &base_region_ctx);
+
+	/* Allocate a fake test image using a buffer */
+	test_img_info = fpga_image_info_alloc(&mgr_ctx.pdev->dev);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, test_img_info);
+
+	test_img_info->buf = fake_bit;
+	test_img_info->count = sizeof(fake_bit);
+
+	kunit_info(test, "fake bitstream size: %zu\n", test_img_info->count);
+
+	KUNIT_EXPECT_EQ(test, 0, fake_fpga_mgr_get_rcfg_count(&mgr_ctx));
+
+	KUNIT_EXPECT_EQ(test, 0, fake_fpga_bridge_get_state(&base_bridge_ctx));
+	KUNIT_EXPECT_EQ(test, 0, fake_fpga_bridge_get_cycles_count(&base_bridge_ctx));
+
+	/* Program the fake FPGA using the image buffer */
+	base_region_ctx.region->info = test_img_info;
+	ret = fpga_region_program_fpga(base_region_ctx.region);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	fake_fpga_mgr_check_write_buf(&mgr_ctx);
+
+	KUNIT_EXPECT_EQ(test, 1, fake_fpga_mgr_get_rcfg_count(&mgr_ctx));
+
+	KUNIT_EXPECT_EQ(test, 1, fake_fpga_bridge_get_state(&base_bridge_ctx));
+	KUNIT_EXPECT_EQ(test, 1, fake_fpga_bridge_get_cycles_count(&base_bridge_ctx));
+
+	fpga_image_info_free(test_img_info);
+
+	/* Allocate another fake test image using a scatter list */
+	test_img_info = fpga_image_info_alloc(&mgr_ctx.pdev->dev);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, test_img_info);
+
+	ret = init_sgt_bit(&sgt_bit, fake_bit, FAKE_BIT_SIZE);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	test_img_info->sgt = &sgt_bit;
+
+	/* Re-program the fake FPGA using the image scatter list */
+	base_region_ctx.region->info = test_img_info;
+	ret = fpga_region_program_fpga(base_region_ctx.region);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	fake_fpga_mgr_check_write_sg(&mgr_ctx);
+
+	KUNIT_EXPECT_EQ(test, 2, fake_fpga_mgr_get_rcfg_count(&mgr_ctx));
+
+	KUNIT_EXPECT_EQ(test, 1, fake_fpga_bridge_get_state(&base_bridge_ctx));
+	KUNIT_EXPECT_EQ(test, 2, fake_fpga_bridge_get_cycles_count(&base_bridge_ctx));
+
+	free_sgt_bit(&sgt_bit);
+	fpga_image_info_free(test_img_info);
+	fpga_free_base_sys(&mgr_ctx, &base_bridge_ctx, &base_region_ctx);
+}
+
+static void fpga_pr_test(struct kunit *test)
+{
+	int ret;
+
+	struct fake_fpga_mgr mgr_ctx;
+	struct fake_fpga_bridge base_bridge_ctx;
+	struct fake_fpga_region base_region_ctx;
+
+	struct fake_fpga_bridge pr_bridge_0_ctx;
+	struct fake_fpga_bridge pr_bridge_1_ctx;
+	struct fake_fpga_region pr_region_ctx;
+
+	struct fpga_image_info *test_static_img_info;
+	struct fpga_image_info *test_pr_img_info;
+
+	fpga_build_base_sys(test, &mgr_ctx, &base_bridge_ctx, &base_region_ctx);
+
+	/* Allocate a fake test image using a buffer */
+	test_static_img_info = fpga_image_info_alloc(&mgr_ctx.pdev->dev);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, test_static_img_info);
+
+	test_static_img_info->buf = fake_bit;
+	test_static_img_info->count = sizeof(fake_bit);
+
+	kunit_info(test, "fake bitstream size: %zu\n", test_static_img_info->count);
+
+	KUNIT_EXPECT_EQ(test, 0, fake_fpga_mgr_get_rcfg_count(&mgr_ctx));
+
+	KUNIT_EXPECT_EQ(test, 0, fake_fpga_bridge_get_state(&base_bridge_ctx));
+	KUNIT_EXPECT_EQ(test, 0, fake_fpga_bridge_get_cycles_count(&base_bridge_ctx));
+
+	/* Program the fake FPGA using the image buffer */
+	base_region_ctx.region->info = test_static_img_info;
+	ret = fpga_region_program_fpga(base_region_ctx.region);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	fake_fpga_mgr_check_write_buf(&mgr_ctx);
+
+	KUNIT_EXPECT_EQ(test, 1, fake_fpga_mgr_get_rcfg_count(&mgr_ctx));
+
+	KUNIT_EXPECT_EQ(test, 1, fake_fpga_bridge_get_state(&base_bridge_ctx));
+	KUNIT_EXPECT_EQ(test, 1, fake_fpga_bridge_get_cycles_count(&base_bridge_ctx));
+
+	/* The static image contains a reconfigurable sub-region with two soft bridges */
+	ret = fake_fpga_bridge_register(&pr_bridge_0_ctx, test);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	ret = fake_fpga_bridge_register(&pr_bridge_1_ctx, test);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	ret = fake_fpga_region_register(&pr_region_ctx, mgr_ctx.mgr, test);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	ret = fake_fpga_region_add_bridge(&pr_region_ctx, pr_bridge_0_ctx.bridge);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	ret = fake_fpga_region_add_bridge(&pr_region_ctx, pr_bridge_1_ctx.bridge);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	/* Allocate a fake partial test image using a buffer */
+	test_pr_img_info = fpga_image_info_alloc(&mgr_ctx.pdev->dev);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, test_pr_img_info);
+
+	test_pr_img_info->buf = fake_bit;
+	test_pr_img_info->count = sizeof(fake_bit) / 2;
+	test_pr_img_info->flags = FPGA_MGR_PARTIAL_RECONFIG;
+
+	kunit_info(test, "fake partial bitstream size: %zu\n", test_pr_img_info->count);
+
+	/* Program the reconfigurable sub-region */
+	pr_region_ctx.region->info = test_pr_img_info;
+	ret = fpga_region_program_fpga(pr_region_ctx.region);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	fake_fpga_mgr_check_write_buf(&mgr_ctx);
+
+	KUNIT_EXPECT_EQ(test, 2, fake_fpga_mgr_get_rcfg_count(&mgr_ctx));
+
+	KUNIT_EXPECT_EQ(test, 1, fake_fpga_bridge_get_state(&pr_bridge_0_ctx));
+	KUNIT_EXPECT_EQ(test, 1, fake_fpga_bridge_get_cycles_count(&pr_bridge_0_ctx));
+
+	KUNIT_EXPECT_EQ(test, 1, fake_fpga_bridge_get_state(&pr_bridge_1_ctx));
+	KUNIT_EXPECT_EQ(test, 1, fake_fpga_bridge_get_cycles_count(&pr_bridge_1_ctx));
+
+	/* Check that the base bridge has not been disabled */
+	KUNIT_EXPECT_EQ(test, 1, fake_fpga_bridge_get_state(&base_bridge_ctx));
+	KUNIT_EXPECT_EQ(test, 1, fake_fpga_bridge_get_cycles_count(&base_bridge_ctx));
+
+	fpga_image_info_free(test_pr_img_info);
+	fpga_image_info_free(test_static_img_info);
+
+	fake_fpga_region_unregister(&pr_region_ctx);
+	fake_fpga_bridge_unregister(&pr_bridge_0_ctx);
+	fake_fpga_bridge_unregister(&pr_bridge_1_ctx);
+
+	fpga_free_base_sys(&mgr_ctx, &base_bridge_ctx, &base_region_ctx);
+}
+
+static struct kunit_case fpga_test_cases[] = {
+	KUNIT_CASE(fpga_base_test),
+	KUNIT_CASE(fpga_pr_test),
+	{},
+};
+
+static struct kunit_suite fpga_test_suite = {
+	.name = "fpga-tests",
+	.suite_init = fpga_suite_init,
+	.test_cases = fpga_test_cases,
+};
+
+kunit_test_suite(fpga_test_suite);
-- 
2.39.1


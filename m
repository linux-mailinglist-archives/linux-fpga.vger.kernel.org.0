Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1606E47A6
	for <lists+linux-fpga@lfdr.de>; Mon, 17 Apr 2023 14:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbjDQM0F (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 17 Apr 2023 08:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbjDQMZ4 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 17 Apr 2023 08:25:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145B176AE
        for <linux-fpga@vger.kernel.org>; Mon, 17 Apr 2023 05:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681734202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g1TfEl15TvyQuW0Jd2k6AgOgc4iivRGBLaeKw9XMy7A=;
        b=D/ttu2pMblpKpMORiyLb4RUA/AkN/kSnu6Z1N92wmM4TyltlEwyWyDzH73/l49P19kprw1
        kRxdRBCamd3vQK2WuuXTMB5dzpeW+d6eFngsJoEWKP7SJenUO8uaInY96sXDnAVjV/j39v
        2KZjgSPcjPnltfL3X3hJeZ/kmPGgmJc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-392-mADTsyxqN4a5EiUjr0OVbQ-1; Mon, 17 Apr 2023 08:23:20 -0400
X-MC-Unique: mADTsyxqN4a5EiUjr0OVbQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-94a356c74e0so305879066b.2
        for <linux-fpga@vger.kernel.org>; Mon, 17 Apr 2023 05:23:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681734199; x=1684326199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g1TfEl15TvyQuW0Jd2k6AgOgc4iivRGBLaeKw9XMy7A=;
        b=VLoPRg635+s0dTHqDrQ8sSi9VvzTUtPfln8cX9h3TfCFD1y9xeKuL5OvWXx+nhr2Xf
         LwuIILVOi4Lu5TVEQvzsGVEQRNW25xeBgvn0sBy5vAM2ixaM7V1QdoVjtcawMRUNK7Re
         L8ihPNIecHie41Ak2G5X66UQ7oOs71H9L8Yu2TJsUwtcjKViOqSVGuNylxJB67lSNnwi
         5r4d+Z+aQlGqJRxXgIXA6aCMEJwVE5DIhROBUhhSEeBsFPReAJYNH25hgMaMMnXU+C3W
         xa+BSTNiEH5pQDKYD9WEp89KVrhEVxhSvotVmVHeharcpIGiAJp5OQ/hg8z16j5B/s68
         ZRnQ==
X-Gm-Message-State: AAQBX9fgRRuffbIXLYiMStqeyJAtzKs49Os7wlPmxvL6OPeS/m45vL4m
        fkZNzKzIbWiL1nhSgEEkgbW4pQHYh8nMRpi+KrJmY+4lgXldMAEKkGXM5bq+xUyJOnMVYYCqIYw
        Wp92v9nMjvRfkFKWUNsDS
X-Received: by 2002:a50:fb97:0:b0:501:c839:cf91 with SMTP id e23-20020a50fb97000000b00501c839cf91mr14133693edq.6.1681734199539;
        Mon, 17 Apr 2023 05:23:19 -0700 (PDT)
X-Google-Smtp-Source: AKy350aEGGmMDdQ4m5HWFGXByQUBMZS1a5K/u5Rz4Qa6Qz7RH9t7kFmoP7/x7octEzYxJ0quiOTnmQ==
X-Received: by 2002:a50:fb97:0:b0:501:c839:cf91 with SMTP id e23-20020a50fb97000000b00501c839cf91mr14133670edq.6.1681734199215;
        Mon, 17 Apr 2023 05:23:19 -0700 (PDT)
Received: from klayman.. ([37.163.248.182])
        by smtp.gmail.com with ESMTPSA id q21-20020aa7cc15000000b004fbf6b35a56sm5756618edt.76.2023.04.17.05.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 05:23:18 -0700 (PDT)
From:   Marco Pagani <marpagan@redhat.com>
To:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
Cc:     Marco Pagani <marpagan@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: [RFC PATCH v4 4/4] fpga: add initial KUnit test suites
Date:   Mon, 17 Apr 2023 14:23:08 +0200
Message-Id: <20230417122308.131453-5-marpagan@redhat.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230417122308.131453-1-marpagan@redhat.com>
References: <20230417122308.131453-1-marpagan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Introduce initial KUnit tests for the FPGA subsystem. Tests are
organized into three test suites. The first suite tests the FPGA
Manager. The second suite tests the FPGA Bridge. Finally, the last
test suite models a complete FPGA platform and tests static and
partial reconfiguration.

Signed-off-by: Marco Pagani <marpagan@redhat.com>
---
 drivers/fpga/Kconfig            |   2 +
 drivers/fpga/Makefile           |   3 +
 drivers/fpga/tests/.kunitconfig |   5 +
 drivers/fpga/tests/Kconfig      |  11 +
 drivers/fpga/tests/Makefile     |   6 +
 drivers/fpga/tests/fpga-test.c  | 479 ++++++++++++++++++++++++++++++++
 6 files changed, 506 insertions(+)
 create mode 100644 drivers/fpga/tests/.kunitconfig
 create mode 100644 drivers/fpga/tests/Kconfig
 create mode 100644 drivers/fpga/tests/Makefile
 create mode 100644 drivers/fpga/tests/fpga-test.c

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
index 000000000000..1cbea75dd29b
--- /dev/null
+++ b/drivers/fpga/tests/Kconfig
@@ -0,0 +1,11 @@
+config FPGA_KUNIT_TESTS
+	tristate "KUnit test for the FPGA subsystem" if !KUNIT_ALL_TESTS
+	depends on FPGA && FPGA_REGION && FPGA_BRIDGE && KUNIT
+	default KUNIT_ALL_TESTS
+        help
+          This builds unit tests for the FPGA subsystem
+
+          For more information on KUnit and unit tests in general,
+          please refer to the KUnit documentation in Documentation/dev-tools/kunit/.
+
+          If unsure, say N.
diff --git a/drivers/fpga/tests/Makefile b/drivers/fpga/tests/Makefile
new file mode 100644
index 000000000000..0b052570659b
--- /dev/null
+++ b/drivers/fpga/tests/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_FPGA_KUNIT_TESTS) += fake-fpga-mgr.o
+obj-$(CONFIG_FPGA_KUNIT_TESTS) += fake-fpga-region.o
+obj-$(CONFIG_FPGA_KUNIT_TESTS) += fake-fpga-bridge.o
+obj-$(CONFIG_FPGA_KUNIT_TESTS) += fpga-test.o
diff --git a/drivers/fpga/tests/fpga-test.c b/drivers/fpga/tests/fpga-test.c
new file mode 100644
index 000000000000..52e71ce07b27
--- /dev/null
+++ b/drivers/fpga/tests/fpga-test.c
@@ -0,0 +1,479 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit tests for the FPGA subsystem
+ *
+ * Copyright (C) 2023 Red Hat, Inc.
+ *
+ * Author: Marco Pagani <marpagan@redhat.com>
+ */
+
+#include <kunit/test.h>
+#include <linux/list.h>
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
+#define STATIC_IMG_BLOCKS	16
+#define STATIC_IMG_SIZE		(FPGA_IMG_BLOCK * STATIC_IMG_BLOCKS)
+
+#define PARTIAL_IMG_BLOCKS	4
+#define PARTIAL_IMG_SIZE	(FPGA_IMG_BLOCK * PARTIAL_IMG_BLOCKS)
+
+/**
+ * buf_img_alloc() - Allocate a fake FPGA image using a buffer.
+ * @test: KUnit test context object.
+ * @dev: owning device.
+ * @size: image size.
+ *
+ * Return: pointer to a struct fpga_image_info or NULL on failure.
+ */
+static struct fpga_image_info *buf_img_alloc(struct kunit *test, struct device *dev,
+					     size_t size)
+{
+	struct fpga_image_info *img_info;
+	char *img_buf;
+
+	img_buf = kunit_kzalloc(test, size, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, img_buf);
+	fake_fpga_mgr_fill_header(img_buf);
+
+	img_info = fpga_image_info_alloc(dev);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, img_info);
+
+	img_info->count = size;
+	img_info->buf = img_buf;
+
+	kunit_info(test, "FPGA image allocated in a buffer, size: %zu\n", size);
+
+	return img_info;
+}
+
+/**
+ * sgt_img_alloc() - Allocate a fake FPGA image using a scatter gather table.
+ * @test: KUnit test context object.
+ * @dev: owning device.
+ * @size: image size.
+ *
+ * Return: pointer to a struct fpga_image_info or NULL on failure.
+ */
+static struct fpga_image_info *sgt_img_alloc(struct kunit *test, struct device *dev,
+					     size_t size)
+{
+	struct fpga_image_info *img_info;
+	char *img_buf;
+	struct sg_table *sgt;
+	int ret;
+
+	img_buf = kunit_kzalloc(test, size, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, img_buf);
+	fake_fpga_mgr_fill_header(img_buf);
+
+	sgt = kunit_kzalloc(test, sizeof(*sgt), GFP_KERNEL);
+	ret = sg_alloc_table(sgt, 1, GFP_KERNEL);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	sg_init_one(sgt->sgl, img_buf, size);
+
+	img_info = fpga_image_info_alloc(dev);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, img_info);
+
+	img_info->sgt = sgt;
+
+	kunit_info(test, "FPGA image allocated in a scatter gather table, size: %zu\n",
+		   size);
+
+	return img_info;
+}
+
+/**
+ * img_free() - Free a fake FPGA image
+ * @img_info: fpga image information struct.
+ *
+ */
+static void img_free(struct fpga_image_info *img_info)
+{
+	if (!img_info)
+		return;
+
+	if (img_info->sgt)
+		sg_free_table(img_info->sgt);
+
+	fpga_image_info_free(img_info);
+}
+
+static int fpga_mgr_test_init(struct kunit *test)
+{
+	struct fake_fpga_mgr *mgr_ctx;
+
+	mgr_ctx = fake_fpga_mgr_register(test, NULL);
+	KUNIT_ASSERT_FALSE(test, IS_ERR(mgr_ctx));
+
+	test->priv = mgr_ctx;
+
+	return 0;
+}
+
+static void fpga_mgr_test_img_load_buf(struct kunit *test)
+{
+	struct fake_fpga_mgr *mgr_ctx;
+	struct fpga_image_info *img_info;
+	int ret;
+
+	mgr_ctx = test->priv;
+
+	/* Allocate an FPGA image using a buffer */
+	img_info = buf_img_alloc(test, &mgr_ctx->pdev->dev, STATIC_IMG_SIZE);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, img_info);
+
+	KUNIT_EXPECT_EQ(test, 0, fake_fpga_mgr_get_rcfg_count(mgr_ctx));
+
+	ret = fpga_mgr_load(mgr_ctx->mgr, img_info);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	fake_fpga_mgr_check_write_buf(mgr_ctx);
+
+	KUNIT_EXPECT_EQ(test, 1, fake_fpga_mgr_get_rcfg_count(mgr_ctx));
+
+	img_free(img_info);
+}
+
+static void fpga_mgr_test_img_load_sgt(struct kunit *test)
+{
+	struct fake_fpga_mgr *mgr_ctx;
+	struct fpga_image_info *img_info;
+	int ret;
+
+	mgr_ctx = test->priv;
+
+	/* Allocate an FPGA image using a scatter gather table */
+	img_info = sgt_img_alloc(test, &mgr_ctx->pdev->dev, STATIC_IMG_SIZE);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, img_info);
+
+	KUNIT_EXPECT_EQ(test, 0, fake_fpga_mgr_get_rcfg_count(mgr_ctx));
+
+	ret = fpga_mgr_load(mgr_ctx->mgr, img_info);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	fake_fpga_mgr_check_write_sgt(mgr_ctx);
+
+	KUNIT_EXPECT_EQ(test, 1, fake_fpga_mgr_get_rcfg_count(mgr_ctx));
+
+	img_free(img_info);
+}
+
+static void fpga_mgr_test_exit(struct kunit *test)
+{
+	struct fake_fpga_mgr *mgr_ctx;
+
+	mgr_ctx = test->priv;
+
+	if (mgr_ctx)
+		fake_fpga_mgr_unregister(mgr_ctx);
+}
+
+static struct kunit_case fpga_mgr_test_cases[] = {
+	KUNIT_CASE(fpga_mgr_test_img_load_buf),
+	KUNIT_CASE(fpga_mgr_test_img_load_sgt),
+	{}
+};
+
+static struct kunit_suite fpga_mgr_suite = {
+	.name = "fpga_mgr",
+	.init = fpga_mgr_test_init,
+	.exit = fpga_mgr_test_exit,
+	.test_cases = fpga_mgr_test_cases,
+};
+
+static int fpga_bridge_test_init(struct kunit *test)
+{
+	struct fake_fpga_bridge *bridge_ctx;
+
+	bridge_ctx = fake_fpga_bridge_register(NULL, test);
+	KUNIT_ASSERT_FALSE(test, IS_ERR(bridge_ctx));
+
+	test->priv = bridge_ctx;
+
+	return 0;
+}
+
+static void fpga_bridge_test_exit(struct kunit *test)
+{
+	struct fake_fpga_bridge *bridge_ctx;
+
+	bridge_ctx = test->priv;
+
+	if (bridge_ctx)
+		fake_fpga_bridge_unregister(bridge_ctx);
+}
+
+static void fpga_bridge_test_toggle(struct kunit *test)
+{
+	struct fake_fpga_bridge *bridge_ctx;
+
+	bridge_ctx = test->priv;
+
+	KUNIT_EXPECT_EQ(test, 1, fake_fpga_bridge_get_state(bridge_ctx));
+
+	fpga_bridge_disable(bridge_ctx->bridge);
+	KUNIT_EXPECT_EQ(test, 0, fake_fpga_bridge_get_state(bridge_ctx));
+
+	fpga_bridge_enable(bridge_ctx->bridge);
+	KUNIT_EXPECT_EQ(test, 1, fake_fpga_bridge_get_state(bridge_ctx));
+}
+
+static void fpga_bridge_test_get_put_list(struct kunit *test)
+{
+	struct list_head bridge_list;
+	struct fake_fpga_bridge *bridge_0_ctx, *bridge_1_ctx;
+	int ret;
+
+	bridge_0_ctx = test->priv;
+
+	/* Register another bridge for this test */
+	bridge_1_ctx = fake_fpga_bridge_register(NULL, test);
+	KUNIT_ASSERT_FALSE(test, IS_ERR(bridge_1_ctx));
+
+	INIT_LIST_HEAD(&bridge_list);
+
+	/* Get bridge_0 and add it to the list */
+	ret = fpga_bridge_get_to_list(bridge_1_ctx->bridge->dev.parent, NULL,
+				      &bridge_list);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	KUNIT_EXPECT_PTR_EQ(test, bridge_1_ctx->bridge,
+			    list_first_entry_or_null(&bridge_list, struct fpga_bridge, node));
+
+	/* Get bridge_1 and add it to the list */
+	ret = fpga_bridge_get_to_list(bridge_0_ctx->bridge->dev.parent, NULL,
+				      &bridge_list);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	KUNIT_EXPECT_PTR_EQ(test, bridge_0_ctx->bridge,
+			    list_first_entry_or_null(&bridge_list, struct fpga_bridge, node));
+
+	/* Put and remove both bridges from the list */
+	fpga_bridges_put(&bridge_list);
+
+	KUNIT_EXPECT_TRUE(test, list_empty(&bridge_list));
+
+	fake_fpga_bridge_unregister(bridge_1_ctx);
+}
+
+static struct kunit_case fpga_bridge_test_cases[] = {
+	KUNIT_CASE(fpga_bridge_test_toggle),
+	KUNIT_CASE(fpga_bridge_test_get_put_list),
+	{}
+};
+
+static struct kunit_suite fpga_bridge_suite = {
+	.name = "fpga_bridge",
+	.init = fpga_bridge_test_init,
+	.exit = fpga_bridge_test_exit,
+	.test_cases = fpga_bridge_test_cases,
+};
+
+struct fpga_base_ctx {
+	/*
+	 * Base FPGA layout consisting of a single region
+	 * controlled by a bridge and the FPGA manager
+	 */
+	struct fake_fpga_mgr *mgr_ctx;
+	struct fake_fpga_bridge *bridge_ctx;
+	struct fake_fpga_region *region_ctx;
+};
+
+static int fpga_test_init(struct kunit *test)
+{
+	struct fpga_base_ctx *base_ctx;
+	int ret;
+
+	base_ctx = kunit_kzalloc(test, sizeof(*base_ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, base_ctx);
+	test->priv = base_ctx;
+
+	/* Build the base FPGA layout */
+	base_ctx->mgr_ctx = fake_fpga_mgr_register(test, NULL);
+	KUNIT_ASSERT_FALSE(test, IS_ERR(base_ctx->mgr_ctx));
+
+	base_ctx->bridge_ctx = fake_fpga_bridge_register(NULL, test);
+	KUNIT_ASSERT_FALSE(test, IS_ERR(base_ctx->bridge_ctx));
+
+	/* The base region a child of the base bridge */
+	base_ctx->region_ctx = fake_fpga_region_register(base_ctx->mgr_ctx->mgr,
+							 &base_ctx->bridge_ctx->bridge->dev, test);
+	KUNIT_ASSERT_FALSE(test, IS_ERR(base_ctx->region_ctx));
+
+	ret = fake_fpga_region_add_bridge(base_ctx->region_ctx, base_ctx->bridge_ctx->bridge);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	kunit_info(test, "FPGA base system built\n");
+
+	KUNIT_EXPECT_EQ(test, 0, fake_fpga_mgr_get_rcfg_count(base_ctx->mgr_ctx));
+	KUNIT_EXPECT_EQ(test, 1, fake_fpga_bridge_get_state(base_ctx->bridge_ctx));
+	KUNIT_EXPECT_EQ(test, 0, fake_fpga_bridge_get_cycles_count(base_ctx->bridge_ctx));
+
+	return 0;
+}
+
+static void fpga_test_exit(struct kunit *test)
+{
+	struct fpga_base_ctx *base_ctx;
+
+	base_ctx = test->priv;
+
+	if (!base_ctx)
+		return;
+
+	if (base_ctx->region_ctx)
+		fake_fpga_region_unregister(base_ctx->region_ctx);
+
+	if (base_ctx->bridge_ctx)
+		fake_fpga_bridge_unregister(base_ctx->bridge_ctx);
+
+	if (base_ctx->mgr_ctx)
+		fake_fpga_mgr_unregister(base_ctx->mgr_ctx);
+}
+
+static void fpga_test_static_cfg(struct kunit *test)
+{
+	struct fpga_base_ctx *base_ctx;
+	struct fpga_image_info *buf_img_info;
+	struct fpga_image_info *sgt_img_info;
+	int ret;
+
+	base_ctx = test->priv;
+
+	buf_img_info = buf_img_alloc(test, &base_ctx->mgr_ctx->pdev->dev, STATIC_IMG_SIZE);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf_img_info);
+
+	/* Configure the FPGA using the image in a buffer */
+	base_ctx->region_ctx->region->info = buf_img_info;
+	ret = fake_fpga_region_program(base_ctx->region_ctx);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	fake_fpga_mgr_check_write_buf(base_ctx->mgr_ctx);
+
+	KUNIT_EXPECT_EQ(test, 1, fake_fpga_mgr_get_rcfg_count(base_ctx->mgr_ctx));
+	KUNIT_EXPECT_EQ(test, 1, fake_fpga_bridge_get_state(base_ctx->bridge_ctx));
+	KUNIT_EXPECT_EQ(test, 1, fake_fpga_bridge_get_cycles_count(base_ctx->bridge_ctx));
+
+	kunit_info(test, "FPGA configuration completed using a buffer image\n");
+
+	sgt_img_info = sgt_img_alloc(test, &base_ctx->mgr_ctx->pdev->dev, STATIC_IMG_SIZE);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, sgt_img_info);
+
+	/* Re-configure the FPGA using the image in a scatter list */
+	base_ctx->region_ctx->region->info = sgt_img_info;
+	ret = fake_fpga_region_program(base_ctx->region_ctx);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	fake_fpga_mgr_check_write_sgt(base_ctx->mgr_ctx);
+
+	KUNIT_EXPECT_EQ(test, 2, fake_fpga_mgr_get_rcfg_count(base_ctx->mgr_ctx));
+	KUNIT_EXPECT_EQ(test, 1, fake_fpga_bridge_get_state(base_ctx->bridge_ctx));
+	KUNIT_EXPECT_EQ(test, 2, fake_fpga_bridge_get_cycles_count(base_ctx->bridge_ctx));
+
+	kunit_info(test, "FPGA configuration completed using scatter gather table image\n");
+
+	img_free(sgt_img_info);
+}
+
+static void fpga_test_partial_rcfg(struct kunit *test)
+{
+	struct fpga_base_ctx *base_ctx;
+	struct fake_fpga_region *sub_region_0_ctx, *sub_region_1_ctx;
+	struct fake_fpga_bridge *sub_bridge_0_ctx, *sub_bridge_1_ctx;
+	struct fpga_image_info *partial_img_info;
+	int ret;
+
+	base_ctx = test->priv;
+
+	/*
+	 * Add two reconfigurable sub-regions, each controlled by a bridge. The
+	 * reconfigurable sub-region are children of their bridges which are,
+	 * in turn, children of the base region. For simplicity, the same image
+	 * is used to configure reconfigurable regions
+	 */
+	sub_bridge_0_ctx = fake_fpga_bridge_register(&base_ctx->region_ctx->region->dev,
+						     test);
+	KUNIT_ASSERT_FALSE(test, IS_ERR(sub_bridge_0_ctx));
+
+	sub_region_0_ctx = fake_fpga_region_register(base_ctx->mgr_ctx->mgr,
+						     &sub_bridge_0_ctx->bridge->dev, test);
+	KUNIT_ASSERT_FALSE(test, IS_ERR(sub_region_0_ctx));
+
+	ret = fake_fpga_region_add_bridge(sub_region_0_ctx, sub_bridge_0_ctx->bridge);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	sub_bridge_1_ctx = fake_fpga_bridge_register(&base_ctx->region_ctx->region->dev,
+						     test);
+	KUNIT_ASSERT_FALSE(test, IS_ERR(sub_bridge_1_ctx));
+
+	sub_region_1_ctx = fake_fpga_region_register(base_ctx->mgr_ctx->mgr,
+						     &sub_bridge_1_ctx->bridge->dev, test);
+	KUNIT_ASSERT_FALSE(test, IS_ERR(sub_region_1_ctx));
+
+	ret = fake_fpga_region_add_bridge(sub_region_1_ctx, sub_bridge_1_ctx->bridge);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	/* Allocate a partial image using a buffer */
+	partial_img_info = buf_img_alloc(test, &base_ctx->mgr_ctx->pdev->dev,
+					 PARTIAL_IMG_SIZE);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, partial_img_info);
+	partial_img_info->flags = FPGA_MGR_PARTIAL_RECONFIG;
+
+	/* Re-configure sub-region 0 with the partial image */
+	sub_region_0_ctx->region->info = partial_img_info;
+	ret = fake_fpga_region_program(sub_region_0_ctx);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	fake_fpga_mgr_check_write_buf(base_ctx->mgr_ctx);
+	KUNIT_EXPECT_EQ(test, 1, fake_fpga_mgr_get_rcfg_count(base_ctx->mgr_ctx));
+
+	KUNIT_EXPECT_EQ(test, 1, fake_fpga_bridge_get_state(sub_bridge_0_ctx));
+	KUNIT_EXPECT_EQ(test, 1, fake_fpga_bridge_get_cycles_count(sub_bridge_0_ctx));
+
+	/* Re-configure sub-region 1 with the partial image */
+	sub_region_1_ctx->region->info = partial_img_info;
+	ret = fake_fpga_region_program(sub_region_1_ctx);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	fake_fpga_mgr_check_write_buf(base_ctx->mgr_ctx);
+	KUNIT_EXPECT_EQ(test, 2, fake_fpga_mgr_get_rcfg_count(base_ctx->mgr_ctx));
+
+	KUNIT_EXPECT_EQ(test, 1, fake_fpga_bridge_get_state(sub_bridge_1_ctx));
+	KUNIT_EXPECT_EQ(test, 1, fake_fpga_bridge_get_cycles_count(sub_bridge_1_ctx));
+
+	/* Check that the base bridge has not been disabled during reconfiguration */
+	KUNIT_EXPECT_EQ(test, 1, fake_fpga_bridge_get_state(base_ctx->bridge_ctx));
+	KUNIT_EXPECT_EQ(test, 0, fake_fpga_bridge_get_cycles_count(base_ctx->bridge_ctx));
+
+	img_free(partial_img_info);
+	fake_fpga_region_unregister(sub_region_0_ctx);
+	fake_fpga_bridge_unregister(sub_bridge_0_ctx);
+	fake_fpga_region_unregister(sub_region_1_ctx);
+	fake_fpga_bridge_unregister(sub_bridge_1_ctx);
+}
+
+static struct kunit_case fpga_test_cases[] = {
+	KUNIT_CASE(fpga_test_static_cfg),
+	KUNIT_CASE(fpga_test_partial_rcfg),
+	{}
+};
+
+static struct kunit_suite fpga_suite = {
+	.name = "fpga",
+	.init = fpga_test_init,
+	.exit = fpga_test_exit,
+	.test_cases = fpga_test_cases,
+};
+
+kunit_test_suites(&fpga_mgr_suite, &fpga_bridge_suite, &fpga_suite);
+
+MODULE_LICENSE("GPL v2");
-- 
2.39.2


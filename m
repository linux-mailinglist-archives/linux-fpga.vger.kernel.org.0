Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C27BD7B36B2
	for <lists+linux-fpga@lfdr.de>; Fri, 29 Sep 2023 17:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233648AbjI2PWj (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 29 Sep 2023 11:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233613AbjI2PWf (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 29 Sep 2023 11:22:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F781AC
        for <linux-fpga@vger.kernel.org>; Fri, 29 Sep 2023 08:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696000905;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4eFMXkTSJCSP/LuqcR7rWb5lOePf6Wh6Ne6wvaIuhIA=;
        b=CCP+LNWcuUxPspuhkm3z/pccUJFLnv4ybLoHBPorBBoxATx1n4DzDrDviAOzboKWsSsDUQ
        r0/3a5qM43qDTxMn2HADU+SvLkoXS9zIwpK8+uoSOIEAeKtCHk3UmNEa4b8g1yV18vXrsZ
        JFuQbmQkFqmC9aK/E1PnmBZPQjVs1vA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-1KV1VA5iOCmfmiI7dm2kQw-1; Fri, 29 Sep 2023 11:21:44 -0400
X-MC-Unique: 1KV1VA5iOCmfmiI7dm2kQw-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-65afb74699eso193314646d6.3
        for <linux-fpga@vger.kernel.org>; Fri, 29 Sep 2023 08:21:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696000903; x=1696605703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4eFMXkTSJCSP/LuqcR7rWb5lOePf6Wh6Ne6wvaIuhIA=;
        b=GSGaf2wvAUC+EhLcjcVSMbsUAUdedP9SyCbOeILCC3lxt7pHikScgLC8D0RckBdls9
         4p8gevXS9fQe0DGGyN/nd5oQMfy/yJQmvbrFR4Fck4dMv94iYfltWmlSKYGSF3AZzGAR
         oz3k7gCL5cXFjcLulQ5UKOTYDAl16Jmx14Oj0hQN9BnfoNVyJbhxJeQ+NwBW5EePAR8E
         Fc80IeSbQXN87u5Ik3Zs86UQahbbVwmost98/yZOcDCZYsv3/pxkZQ805dMwTWlsXhdh
         ZW+GET5R0wsp4MINds+NnHycFkApBqu9LRhqzNF/m+TI15RLoQhdS4A+CNg55cqM8TmG
         fuNg==
X-Gm-Message-State: AOJu0YwGLSX+iMm6JgDoNuhOE7tYVQfws3qhNBSLU84fSy+vkYdVe8ga
        18rxkpSZ2n9XL4NsoSb/BfZsEWFAWCQ33QWbOBCEX2rTxqs2Or0QQRN/z32EN0sxK77S54fwL1l
        koW30FiSwI3itijZkrjlI
X-Received: by 2002:ac8:5e0d:0:b0:412:1e4c:e858 with SMTP id h13-20020ac85e0d000000b004121e4ce858mr5611982qtx.36.1696000903595;
        Fri, 29 Sep 2023 08:21:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFn58PBLwTq+THIqS9k7CeHslslS8Zkx9jdCHCLUBpRCxKtjNqsvILp9zhdNCpI8CYEa32WgQ==
X-Received: by 2002:ac8:5e0d:0:b0:412:1e4c:e858 with SMTP id h13-20020ac85e0d000000b004121e4ce858mr5611964qtx.36.1696000903357;
        Fri, 29 Sep 2023 08:21:43 -0700 (PDT)
Received: from klayman.redhat.com (net-2-34-30-58.cust.vodafonedsl.it. [2.34.30.58])
        by smtp.gmail.com with ESMTPSA id bq14-20020a05622a1c0e00b00419801b1094sm287053qtb.13.2023.09.29.08.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 08:21:43 -0700 (PDT)
From:   Marco Pagani <marpagan@redhat.com>
To:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
Cc:     Marco Pagani <marpagan@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org, Jinjie Ruan <ruanjinjie@huawei.com>
Subject: [PATCH v2 4/4] fpga: add a platform driver to the FPGA Region test suite
Date:   Fri, 29 Sep 2023 17:20:57 +0200
Message-ID: <20230929152057.85047-5-marpagan@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230929152057.85047-1-marpagan@redhat.com>
References: <20230929152057.85047-1-marpagan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Register a minimal platform driver associated with the parent platform
device used for testing to prevent a null-ptr-deref when try_module_get()
is called by fpga_region_get(). Also, fix a typo in the suite's name.

Fixes: 64a5f972c93d ("fpga: add an initial KUnit suite for the FPGA Region")
Reported-by: Jinjie Ruan <ruanjinjie@huawei.com>
Signed-off-by: Marco Pagani <marpagan@redhat.com>
---
 drivers/fpga/tests/fpga-region-test.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/fpga/tests/fpga-region-test.c b/drivers/fpga/tests/fpga-region-test.c
index 9f9d50ee7871..5ff688b394f9 100644
--- a/drivers/fpga/tests/fpga-region-test.c
+++ b/drivers/fpga/tests/fpga-region-test.c
@@ -15,6 +15,8 @@
 #include <linux/platform_device.h>
 #include <linux/types.h>
 
+#include "fpga-test-helpers.h"
+
 struct mgr_stats {
 	u32 write_count;
 };
@@ -132,6 +134,18 @@ static void fpga_region_test_program_fpga(struct kunit *test)
 	fpga_image_info_free(img_info);
 }
 
+TEST_PLATFORM_DRIVER(test_platform_driver);
+
+static int fpga_region_test_suite_init(struct kunit_suite *suite)
+{
+	return platform_driver_register(&test_platform_driver);
+}
+
+static void fpga_region_test_suite_exit(struct kunit_suite *suite)
+{
+	platform_driver_unregister(&test_platform_driver);
+}
+
 /*
  * The configuration used in this test suite uses a single bridge to
  * limit the code under test to a single unit. The functions used by the
@@ -146,14 +160,15 @@ static int fpga_region_test_init(struct kunit *test)
 	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
 
-	ctx->mgr_pdev = platform_device_register_simple("mgr_pdev", PLATFORM_DEVID_AUTO, NULL, 0);
+	ctx->mgr_pdev = platform_device_register_simple(TEST_PDEV_NAME, PLATFORM_DEVID_AUTO,
+							NULL, 0);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->mgr_pdev);
 
 	ctx->mgr = devm_fpga_mgr_register(&ctx->mgr_pdev->dev, "Fake FPGA Manager", &fake_mgr_ops,
 					  &ctx->mgr_stats);
 	KUNIT_ASSERT_FALSE(test, IS_ERR_OR_NULL(ctx->mgr));
 
-	ctx->bridge_pdev = platform_device_register_simple("bridge_pdev", PLATFORM_DEVID_AUTO,
+	ctx->bridge_pdev = platform_device_register_simple(TEST_PDEV_NAME, PLATFORM_DEVID_AUTO,
 							   NULL, 0);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->bridge_pdev);
 
@@ -163,7 +178,7 @@ static int fpga_region_test_init(struct kunit *test)
 
 	ctx->bridge_stats.enable = true;
 
-	ctx->region_pdev = platform_device_register_simple("region_pdev", PLATFORM_DEVID_AUTO,
+	ctx->region_pdev = platform_device_register_simple(TEST_PDEV_NAME, PLATFORM_DEVID_AUTO,
 							   NULL, 0);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->region_pdev);
 
@@ -195,12 +210,13 @@ static void fpga_region_test_exit(struct kunit *test)
 static struct kunit_case fpga_region_test_cases[] = {
 	KUNIT_CASE(fpga_region_test_class_find),
 	KUNIT_CASE(fpga_region_test_program_fpga),
-
 	{}
 };
 
 static struct kunit_suite fpga_region_suite = {
-	.name = "fpga_mgr",
+	.name = "fpga_region",
+	.suite_init = fpga_region_test_suite_init,
+	.suite_exit = fpga_region_test_suite_exit,
 	.init = fpga_region_test_init,
 	.exit = fpga_region_test_exit,
 	.test_cases = fpga_region_test_cases,
-- 
2.41.0


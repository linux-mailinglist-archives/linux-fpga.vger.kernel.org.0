Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2BEA7B36BA
	for <lists+linux-fpga@lfdr.de>; Fri, 29 Sep 2023 17:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233618AbjI2PXK (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 29 Sep 2023 11:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233585AbjI2PW0 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 29 Sep 2023 11:22:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31CD1F9
        for <linux-fpga@vger.kernel.org>; Fri, 29 Sep 2023 08:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696000894;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bU5dbp4PmbcRGMxxeBcidbIs/vd32ofMq8iILiK+4+o=;
        b=G06tgh5GOcgTz7fETM26pHVPdaWaKTJ096RYjAAu9GehTvDcosihwahGUcTHOrWouiLZs4
        N3Yh51eJ2wkf35bWc8o/g35StgYcoIsh6qf+Lp2S47aL61+jkgvbjzGwpcb1LUI5QNnZaI
        7Cg1vTr+h7yBWySflrEPW2hrBX/QhbA=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-fCz-QdkZPA292ILbpQa6zg-1; Fri, 29 Sep 2023 11:21:33 -0400
X-MC-Unique: fCz-QdkZPA292ILbpQa6zg-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-418198baf49so153155471cf.1
        for <linux-fpga@vger.kernel.org>; Fri, 29 Sep 2023 08:21:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696000892; x=1696605692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bU5dbp4PmbcRGMxxeBcidbIs/vd32ofMq8iILiK+4+o=;
        b=XWgBDAjXuNI/WjZGIf2p60LIAQr/GLAKsM2JTHo9Irw6HA3yW3BHy3yFG4yqStC2S+
         0tmHPwLuDJKcg2w+9saloYvCUqWXxNkRaCBqLf9qJebvKz8RRex3bmRjOwMbDVg41RgF
         iqPF7W2ZrK9yP4xeKQgYe4UDKcXu2scXgrRL43nNHaUKPydSDZo7bAE/J4k+t4z/ppSl
         LPz+TGVXxmUX4175HxSviCfj9u6jAUzpt3FLCfcTYb0SjUgSRFjDJ6+eI9bn8Uel0qTA
         G4r5uCJ8PozZ7hwN/pZoUHc//4g+0YmqjT4eEqbl/cgE9U2yDrdPbKOp2B9RE0FYprrg
         1mnQ==
X-Gm-Message-State: AOJu0YxjAUqoHnqbN6zINdagzCy16Hbp985IbXMl+U/j9hUtkMNqZxF0
        TKfqDXrLXsdiO9ch6G9Jr3gQUbUzWJoXzgEc6Fkr0IkXxc1tO5FAPw/H6/tf9mQ0BOOr15PGi7n
        Eg9pyB0lIHBUCPSkBIijq
X-Received: by 2002:ac8:5892:0:b0:412:1899:76d0 with SMTP id t18-20020ac85892000000b00412189976d0mr5347708qta.63.1696000892713;
        Fri, 29 Sep 2023 08:21:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGA4UgDS1c2uv6+SMZwT1kU2C6jc6BualUKTCmwz6tpPUY3Nmvkik5hsl9BfJAOnURocaa8g==
X-Received: by 2002:ac8:5892:0:b0:412:1899:76d0 with SMTP id t18-20020ac85892000000b00412189976d0mr5347689qta.63.1696000892501;
        Fri, 29 Sep 2023 08:21:32 -0700 (PDT)
Received: from klayman.redhat.com (net-2-34-30-58.cust.vodafonedsl.it. [2.34.30.58])
        by smtp.gmail.com with ESMTPSA id bq14-20020a05622a1c0e00b00419801b1094sm287053qtb.13.2023.09.29.08.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 08:21:32 -0700 (PDT)
From:   Marco Pagani <marpagan@redhat.com>
To:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
Cc:     Marco Pagani <marpagan@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org, Jinjie Ruan <ruanjinjie@huawei.com>
Subject: [PATCH v2 3/4] fpga: add a platform driver to the FPGA Bridge test suite
Date:   Fri, 29 Sep 2023 17:20:56 +0200
Message-ID: <20230929152057.85047-4-marpagan@redhat.com>
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
is called by __fpga_bridge_get().

Fixes: 9e6823481e5f ("fpga: add an initial KUnit suite for the FPGA Bridge")
Reported-by: Jinjie Ruan <ruanjinjie@huawei.com>
Signed-off-by: Marco Pagani <marpagan@redhat.com>
---
 drivers/fpga/tests/fpga-bridge-test.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/fpga/tests/fpga-bridge-test.c b/drivers/fpga/tests/fpga-bridge-test.c
index 1d258002cdd7..4bd4ecaa7e90 100644
--- a/drivers/fpga/tests/fpga-bridge-test.c
+++ b/drivers/fpga/tests/fpga-bridge-test.c
@@ -13,6 +13,8 @@
 #include <linux/module.h>
 #include <linux/types.h>
 
+#include "fpga-test-helpers.h"
+
 struct bridge_stats {
 	bool enable;
 };
@@ -53,7 +55,7 @@ static struct bridge_ctx *register_test_bridge(struct kunit *test)
 	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
 
-	ctx->pdev = platform_device_register_simple("bridge_pdev", PLATFORM_DEVID_AUTO, NULL, 0);
+	ctx->pdev = platform_device_register_simple(TEST_PDEV_NAME, PLATFORM_DEVID_AUTO, NULL, 0);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->pdev);
 
 	ctx->bridge = fpga_bridge_register(&ctx->pdev->dev, "Fake FPGA bridge", &fake_bridge_ops,
@@ -144,6 +146,18 @@ static void fpga_bridge_test_get_put_list(struct kunit *test)
 	unregister_test_bridge(ctx_1);
 }
 
+TEST_PLATFORM_DRIVER(test_platform_driver);
+
+static int fpga_bridge_test_suite_init(struct kunit_suite *suite)
+{
+	return platform_driver_register(&test_platform_driver);
+}
+
+static void fpga_bridge_test_suite_exit(struct kunit_suite *suite)
+{
+	platform_driver_unregister(&test_platform_driver);
+}
+
 static int fpga_bridge_test_init(struct kunit *test)
 {
 	test->priv = register_test_bridge(test);
@@ -165,6 +179,8 @@ static struct kunit_case fpga_bridge_test_cases[] = {
 
 static struct kunit_suite fpga_bridge_suite = {
 	.name = "fpga_bridge",
+	.suite_init = fpga_bridge_test_suite_init,
+	.suite_exit = fpga_bridge_test_suite_exit,
 	.init = fpga_bridge_test_init,
 	.exit = fpga_bridge_test_exit,
 	.test_cases = fpga_bridge_test_cases,
-- 
2.41.0


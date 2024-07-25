Return-Path: <linux-fpga+bounces-577-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B907A93C26F
	for <lists+linux-fpga@lfdr.de>; Thu, 25 Jul 2024 14:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 039FBB22FD4
	for <lists+linux-fpga@lfdr.de>; Thu, 25 Jul 2024 12:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D40D19AD94;
	Thu, 25 Jul 2024 12:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="isjGv++Y"
X-Original-To: linux-fpga@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F347A19AD7E
	for <linux-fpga@vger.kernel.org>; Thu, 25 Jul 2024 12:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721911861; cv=none; b=BxPqAvo1ayl+CBO98Af907IPL+80RPLEymiij0ZUuPMLwUjL/wb6MLtMRmRphKroGQ4WkxH/tew6tw4zhdB1L+EwJYU/2I8b1my54XSDADd3FPyqd7tG7CVY/iXgSAC5HkOjQyS/sYTfLtEKX/dbn6pc0ZDOZvRdxegJqT40FXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721911861; c=relaxed/simple;
	bh=8tnd/VQtiNpjeTI/Si1dXPTSVhoxuAsentG0xIJwfhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oAR9idhWoSZFBPb3LmEjCZaA3Ql/ckla5LKfa2zDEqQ/+c5oeSjRnmxuWBfoPohj8t1eKslqGWl+okeNx40bcn2EtUvhsTt9OiBaGqnJPS2UvaNaOfS3Op3z6v+76fnGghw05oT4YkHkgyeF8JYFQL3E7NZVjO0ATmEXPCYyunI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=isjGv++Y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721911859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ujCDSZiUUPCMMti3b2r7m+p5eUsjfxpaUTFjvUJjKxQ=;
	b=isjGv++YHCG5bilI7zQxFdIcIoqtYDRnMoHeO3zvV66g5Z/q1QbRydClmIo4tLhCPBst+d
	bYtJx2EyklvaJ2f+yPXQC3zbuS4IkPNhk+wtlD3e5NlOavgw5OvuMFEouI6Ulb53NaFjhL
	qSH7uAppO3q3y6WLYiSsn5sx2GlZbUg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-pKTJO3lUNDq98DOu5mAPOw-1; Thu, 25 Jul 2024 08:50:57 -0400
X-MC-Unique: pKTJO3lUNDq98DOu5mAPOw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4280507dc5cso6449035e9.2
        for <linux-fpga@vger.kernel.org>; Thu, 25 Jul 2024 05:50:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721911856; x=1722516656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ujCDSZiUUPCMMti3b2r7m+p5eUsjfxpaUTFjvUJjKxQ=;
        b=wzQv9ltHai7ux0q1VEe9NvJOnRIcMeI9bzHXQtba27Gh9G/QVcn/5NF7nw6KYPzDRa
         SOexrzZRnySwFFZyGz/UV64KL1HWh8OyAdgx9vEgKtHDvnNuMWGmMnsebYgFgHvpokEx
         MJ5r/adGUS2ra7/9HkZ0vPmO2GzDoeEdKPM23PtQ/upa7pTxLPXsQ2jAq0fhj7pW9g6c
         g3327Vo9ZqolAuI4H4yhno5ykdhapDTUU6gNvSvC1KBq34aU1sKQRFS8LyNeEiKZ18+i
         aOZzTdkvUeACb/13awi9QIx1tkH7A7PhYocQwQPFl+MuDdbPI2QJbx3hM2oOhe5VAccv
         +7uA==
X-Forwarded-Encrypted: i=1; AJvYcCX4/hBESbbIAf0kbQK431BCh7+NBEnIM5ALHO7PGzch7z1ZOV40gUyeCOJyf57k74NXVccwGowKF4OKXEaxJkhr1MQ3q8r7560rMg==
X-Gm-Message-State: AOJu0YwhebLJZgOPctQH+H672f3MEG6lAkZnsJK8JgKdtGajapLbggZV
	CxPBnLv3S66fbksJU5vqk9Ui18c/LUxN+OTXCmZUk54Gmnd37UvcUA5OTsYsH8SFQvTlSG6mbDb
	jxKwOvLAh/eJgFz7VTIpqbZ/OROO+Dd9FJpi1aisMX8sxerSvdU5vGnBwzQ==
X-Received: by 2002:a05:6000:a85:b0:368:7fd3:291c with SMTP id ffacd0b85a97d-36b3644426dmr1196351f8f.60.1721911856675;
        Thu, 25 Jul 2024 05:50:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVAxLclyNlj7nM4ZL2qCkLrBuxajhLd/cD318oAsWpXooT8OH8qKqixRKTnOf6Vcohzy5f5A==
X-Received: by 2002:a05:6000:a85:b0:368:7fd3:291c with SMTP id ffacd0b85a97d-36b3644426dmr1196338f8f.60.1721911856417;
        Thu, 25 Jul 2024 05:50:56 -0700 (PDT)
Received: from klayman.redhat.com (host-82-62-247-97.business.telecomitalia.it. [82.62.247.97])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367d9393sm2092301f8f.26.2024.07.25.05.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 05:50:56 -0700 (PDT)
From: Marco Pagani <marpagan@redhat.com>
To: Moritz Fischer <mdf@kernel.org>,
	Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>
Cc: Marco Pagani <marpagan@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-fpga@vger.kernel.org
Subject: [PATCH 3/3] Simplify and improve the fpga region test suite using deferred actions
Date: Thu, 25 Jul 2024 14:50:31 +0200
Message-ID: <20240725125031.308195-4-marpagan@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725125031.308195-1-marpagan@redhat.com>
References: <20240725125031.308195-1-marpagan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use deferred actions to simplify the test suite and avoid potential memory
leaks when test cases fail. Remove unnecessary calls to
kunit_device_unregister() since kunit devices are tied to the test context
and released by a deferred action when the test is completed.

Other changes: fix a typo by changing the test suite name to fpga_region in
the kunit_suite struct.

Signed-off-by: Marco Pagani <marpagan@redhat.com>
---
 drivers/fpga/tests/fpga-region-test.c | 41 ++++++++++++++++-----------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/drivers/fpga/tests/fpga-region-test.c b/drivers/fpga/tests/fpga-region-test.c
index bcf0651df261..6a108cafded8 100644
--- a/drivers/fpga/tests/fpga-region-test.c
+++ b/drivers/fpga/tests/fpga-region-test.c
@@ -35,6 +35,19 @@ struct test_ctx {
 	struct mgr_stats mgr_stats;
 };
 
+/*
+ * Wrappers to avoid cast warnings when passing action functions directly
+ * to kunit_add_action().
+ */
+KUNIT_DEFINE_ACTION_WRAPPER(fpga_image_info_free_wrapper, fpga_image_info_free,
+			    struct fpga_image_info *);
+
+KUNIT_DEFINE_ACTION_WRAPPER(fpga_bridge_unregister_wrapper, fpga_bridge_unregister,
+			    struct fpga_bridge *);
+
+KUNIT_DEFINE_ACTION_WRAPPER(fpga_region_unregister_wrapper, fpga_region_unregister,
+			    struct fpga_region *);
+
 static int op_write(struct fpga_manager *mgr, const char *buf, size_t count)
 {
 	struct mgr_stats *stats = mgr->priv;
@@ -111,6 +124,9 @@ static void fpga_region_test_program_fpga(struct kunit *test)
 	img_info = fpga_image_info_alloc(ctx->mgr_dev);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, img_info);
 
+	ret = kunit_add_action_or_reset(test, fpga_image_info_free_wrapper, img_info);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
 	img_info->buf = img_buf;
 	img_info->count = sizeof(img_buf);
 
@@ -130,8 +146,6 @@ static void fpga_region_test_program_fpga(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, 2, ctx->bridge_stats.cycles_count);
 
 	fpga_bridges_put(&ctx->region->bridge_list);
-
-	fpga_image_info_free(img_info);
 }
 
 /*
@@ -144,6 +158,7 @@ static int fpga_region_test_init(struct kunit *test)
 {
 	struct test_ctx *ctx;
 	struct fpga_region_info region_info = { 0 };
+	int ret;
 
 	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
@@ -164,6 +179,9 @@ static int fpga_region_test_init(struct kunit *test)
 
 	ctx->bridge_stats.enable = true;
 
+	ret = kunit_add_action_or_reset(test, fpga_bridge_unregister_wrapper, ctx->bridge);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
 	ctx->region_dev = kunit_device_register(test, "fpga-region-test-dev");
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->region_dev);
 
@@ -174,24 +192,14 @@ static int fpga_region_test_init(struct kunit *test)
 	ctx->region = fpga_region_register_full(ctx->region_dev, &region_info);
 	KUNIT_ASSERT_FALSE(test, IS_ERR_OR_NULL(ctx->region));
 
+	ret = kunit_add_action_or_reset(test, fpga_region_unregister_wrapper, ctx->region);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
 	test->priv = ctx;
 
 	return 0;
 }
 
-static void fpga_region_test_exit(struct kunit *test)
-{
-	struct test_ctx *ctx = test->priv;
-
-	fpga_region_unregister(ctx->region);
-	kunit_device_unregister(test, ctx->region_dev);
-
-	fpga_bridge_unregister(ctx->bridge);
-	kunit_device_unregister(test, ctx->bridge_dev);
-
-	kunit_device_unregister(test, ctx->mgr_dev);
-}
-
 static struct kunit_case fpga_region_test_cases[] = {
 	KUNIT_CASE(fpga_region_test_class_find),
 	KUNIT_CASE(fpga_region_test_program_fpga),
@@ -199,9 +207,8 @@ static struct kunit_case fpga_region_test_cases[] = {
 };
 
 static struct kunit_suite fpga_region_suite = {
-	.name = "fpga_mgr",
+	.name = "fpga_region",
 	.init = fpga_region_test_init,
-	.exit = fpga_region_test_exit,
 	.test_cases = fpga_region_test_cases,
 };
 
-- 
2.45.2



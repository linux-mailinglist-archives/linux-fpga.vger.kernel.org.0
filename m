Return-Path: <linux-fpga+bounces-575-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5642093C268
	for <lists+linux-fpga@lfdr.de>; Thu, 25 Jul 2024 14:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FB5AB22E1F
	for <lists+linux-fpga@lfdr.de>; Thu, 25 Jul 2024 12:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6BE19AA68;
	Thu, 25 Jul 2024 12:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S4Fy/XHm"
X-Original-To: linux-fpga@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC2319AA4F
	for <linux-fpga@vger.kernel.org>; Thu, 25 Jul 2024 12:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721911848; cv=none; b=uOXDSYiLjZLEne2VUJZg2+FFr/v0MHOEj4rgjFB09DSQT4nMQnZ+I4C1aWPpRtW1H2LBFeMsNVPkMOq+Jmz3VMaVBXjOvW8Ul9KPjVvPBYBsAVCGLRfw4sZJkO5LKK5CtqBX6pYj2Hu0UdV2luwv7bAwEdVYIc7teqcjTR9nAc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721911848; c=relaxed/simple;
	bh=4XUqPxSx6vk33Fs5v1/69vqGU9Qu4OJRWDV/cVUixi8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bDzvDf4Eee5mTjAjUbWkxsKbGFcw+QNNrPNs0zifYA2tnRDWIAGUjCShKG20N7JyHgHmRGGVwdDDhoJrAoy666mCL7B3MuksiPaffLOnDJtMX5XL7tZubvBGJWFaiz7Lp4Klld6d/peGYzKmkQZJRHgFIftOH7p1NtcXwbvZhNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S4Fy/XHm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721911845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a6VNin/3nB4iUE5Zgy3fIduRtJbFimcejG9hH+gh4os=;
	b=S4Fy/XHmKCm3g4TSh4T8pqv2YpyCn/OZlko68waVOpD/fbcJ6ptRd5dfB5UlbYiRI9Y8rj
	tsTTzp1UAQ3cRFIzEs68KUql5VuvNNBIOQ7uvKy7IDaZx+vX3awzSrFI2JVEUXueoj4tec
	A6sfwKo/9cAmKrIy33Bw2Ev/mr7sJs8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-vAzTLjXBOxiKUtDWZppIXA-1; Thu, 25 Jul 2024 08:50:44 -0400
X-MC-Unique: vAzTLjXBOxiKUtDWZppIXA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3685a5a765fso525862f8f.1
        for <linux-fpga@vger.kernel.org>; Thu, 25 Jul 2024 05:50:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721911843; x=1722516643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a6VNin/3nB4iUE5Zgy3fIduRtJbFimcejG9hH+gh4os=;
        b=icI9sKo1ZXCpeS7hYZD98ME0qYp96sfrRfziBtPQGPl/yqMmBvGfJ3E1zwhsq6xkPO
         NOV2zVFZozu9ouy80kG3AXI+QUFEPuvT+n3g2PmkaU3Estt9uFJ2yRwFXVmaKxBtN+Zf
         YN2sRhji3WCdQWPNT4gCjf/OAYNZXGWFfgr00+byZgQFTxNHFHQdyfL5rwofC1zeFk5W
         21XsJnxHjJcC+eahvH66P1lqm97frmDTEslZIbJFeM8lmG7NbPKi3UXV46N9Jx10Jm0o
         ZFojsWZgZYFa73sf2UJ7Dm1pc0lL8KzkQiDlno9X3S4jvrG8Y3yFcuRjnveGBw4bjNJQ
         Ifsw==
X-Forwarded-Encrypted: i=1; AJvYcCVMQRkhRhTOTVyTv50+jNWeXh0fthsgJ5Jv1Pb3SkXTuaa6iNbcgSh4ugHXm+CeSOFlXvJGO4vdffd+5xulVkp2spC3a5WXvLjeYA==
X-Gm-Message-State: AOJu0YyZC0a2EFeTHoe3RZnlR8ooeo8Nekf6LCmovOxk5gmsh/KwMxdu
	oshpTwmxikc02tF92HK1iJ7N0SJOWagIAqXnVTb20Dx2xqGAUz72S287oFkR6+PB4b1ogsDG26p
	maLI4VdlzD78uT8m9klnSRfXA9Kuj3cxGmgYBsib0DNoZlrHH6ObMw/ieryqgP/LcMg==
X-Received: by 2002:a5d:530a:0:b0:368:334d:aad4 with SMTP id ffacd0b85a97d-36b319d0671mr1996494f8f.4.1721911843404;
        Thu, 25 Jul 2024 05:50:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFnQtljov7mTyBnm12EsdGYTBFRa0d3qWO13EEzKuHlha1cnD0ekvmxjpnTJcwuAzA/gfxuQ==
X-Received: by 2002:a5d:530a:0:b0:368:334d:aad4 with SMTP id ffacd0b85a97d-36b319d0671mr1996480f8f.4.1721911843083;
        Thu, 25 Jul 2024 05:50:43 -0700 (PDT)
Received: from klayman.redhat.com (host-82-62-247-97.business.telecomitalia.it. [82.62.247.97])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367d9393sm2092301f8f.26.2024.07.25.05.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 05:50:42 -0700 (PDT)
From: Marco Pagani <marpagan@redhat.com>
To: Moritz Fischer <mdf@kernel.org>,
	Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>
Cc: Marco Pagani <marpagan@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-fpga@vger.kernel.org
Subject: [PATCH 1/3] Simplify and improve the fpga manager test suite using deferred actions
Date: Thu, 25 Jul 2024 14:50:29 +0200
Message-ID: <20240725125031.308195-2-marpagan@redhat.com>
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

Signed-off-by: Marco Pagani <marpagan@redhat.com>
---
 drivers/fpga/tests/fpga-mgr-test.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/fpga/tests/fpga-mgr-test.c b/drivers/fpga/tests/fpga-mgr-test.c
index 125b3a4d43c6..9cb37aefbac4 100644
--- a/drivers/fpga/tests/fpga-mgr-test.c
+++ b/drivers/fpga/tests/fpga-mgr-test.c
@@ -44,6 +44,16 @@ struct mgr_ctx {
 	struct mgr_stats stats;
 };
 
+/*
+ * Wrappers to avoid cast warnings when passing action functions directly
+ * to kunit_add_action().
+ */
+KUNIT_DEFINE_ACTION_WRAPPER(sg_free_table_wrapper, sg_free_table,
+			    struct sg_table *);
+
+KUNIT_DEFINE_ACTION_WRAPPER(fpga_image_info_free_wrapper, fpga_image_info_free,
+			    struct fpga_image_info *);
+
 /**
  * init_test_buffer() - Allocate and initialize a test image in a buffer.
  * @test: KUnit test context object.
@@ -257,6 +267,9 @@ static void fpga_mgr_test_img_load_sgt(struct kunit *test)
 	KUNIT_ASSERT_EQ(test, ret, 0);
 	sg_init_one(sgt->sgl, img_buf, IMAGE_SIZE);
 
+	ret = kunit_add_action_or_reset(test, sg_free_table_wrapper, sgt);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
 	ctx->img_info->sgt = sgt;
 
 	ret = fpga_mgr_load(ctx->mgr, ctx->img_info);
@@ -273,13 +286,12 @@ static void fpga_mgr_test_img_load_sgt(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, ctx->stats.op_write_init_seq, ctx->stats.op_parse_header_seq + 1);
 	KUNIT_EXPECT_EQ(test, ctx->stats.op_write_sg_seq, ctx->stats.op_parse_header_seq + 2);
 	KUNIT_EXPECT_EQ(test, ctx->stats.op_write_complete_seq, ctx->stats.op_parse_header_seq + 3);
-
-	sg_free_table(ctx->img_info->sgt);
 }
 
 static int fpga_mgr_test_init(struct kunit *test)
 {
 	struct mgr_ctx *ctx;
+	int ret;
 
 	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
@@ -294,19 +306,14 @@ static int fpga_mgr_test_init(struct kunit *test)
 	ctx->img_info = fpga_image_info_alloc(ctx->dev);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->img_info);
 
+	ret = kunit_add_action_or_reset(test, fpga_image_info_free_wrapper, ctx->img_info);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
 	test->priv = ctx;
 
 	return 0;
 }
 
-static void fpga_mgr_test_exit(struct kunit *test)
-{
-	struct mgr_ctx *ctx = test->priv;
-
-	fpga_image_info_free(ctx->img_info);
-	kunit_device_unregister(test, ctx->dev);
-}
-
 static struct kunit_case fpga_mgr_test_cases[] = {
 	KUNIT_CASE(fpga_mgr_test_get),
 	KUNIT_CASE(fpga_mgr_test_lock),
@@ -318,7 +325,6 @@ static struct kunit_case fpga_mgr_test_cases[] = {
 static struct kunit_suite fpga_mgr_suite = {
 	.name = "fpga_mgr",
 	.init = fpga_mgr_test_init,
-	.exit = fpga_mgr_test_exit,
 	.test_cases = fpga_mgr_test_cases,
 };
 
-- 
2.45.2



Return-Path: <linux-fpga+bounces-576-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A5E93C26B
	for <lists+linux-fpga@lfdr.de>; Thu, 25 Jul 2024 14:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29063B22CA1
	for <lists+linux-fpga@lfdr.de>; Thu, 25 Jul 2024 12:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A2A19AA77;
	Thu, 25 Jul 2024 12:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fnTFa/lB"
X-Original-To: linux-fpga@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF94519AA74
	for <linux-fpga@vger.kernel.org>; Thu, 25 Jul 2024 12:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721911854; cv=none; b=PLEprI4lvoXqlSvEv+dcOBVGYXS8sADFB8ZlK/+ACoESwTjM0wpl+oaqY4IgIgG2Xcm5n+a20HZpTN9T3fvEQ3g5gtZeTn04yJmscH12brqxSalaeV4cFQWqWEx316GkQVTnNSHrnc9dI2B2B4QEfh4BvcVdzn7DO7kqApoqK1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721911854; c=relaxed/simple;
	bh=YV909LoEI6bsi0Em/tZckNhqRD0hUSsHLMe7pCoiwxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HK/eHC7QbQtckUM8Sd9nRL5zeQ8XnX264nrcbIN/8vxI4dqVeGJ0pF0nm9qzeQ/O3W+VkQtX5GBl1LXct8WuHSn+LcYMxaBemQiPrOuw99JOz+gU53zmh0J5VwdPTSU8C0N2V1rIFRPStjDSkZS3+zxdD/fxEyMJG1UWFJcns/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fnTFa/lB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721911851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EFHivbMHZeqOfhJYc/N6VPffgKBGWyLKy4zJkm5ynK8=;
	b=fnTFa/lBitrmqZziSbmCIRnBDDQGloINBtOE1sqNIUBi6WHERvIbWVIMo2endiHgTzuLno
	ucSAMz8+BT5F0DNDuPZDngps77IK7YH7VBFwVBG201r0ruZEiEWgOWjy2RESsEdgHpE4D+
	EiAJV9qKpa3+x8RPB5BonjBX5G7qBWE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-eahsemJ2MzulafgrZ7YEAA-1; Thu, 25 Jul 2024 08:50:50 -0400
X-MC-Unique: eahsemJ2MzulafgrZ7YEAA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4266fbae4c6so6643925e9.0
        for <linux-fpga@vger.kernel.org>; Thu, 25 Jul 2024 05:50:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721911849; x=1722516649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EFHivbMHZeqOfhJYc/N6VPffgKBGWyLKy4zJkm5ynK8=;
        b=gRf0/tUzbNr9E4Zo/i46oxNxvHPfVENg7iqgYrQq7CtZzKoc+UpU2tjegRURn01Fe0
         m0MfpKnpUaSUJlvaO8nIa5rdRmkQPvNBr0TPSchd3ttUYKuveM4CAOUs2yYaXJGVgmiQ
         tixRPqWicT1yu5GuZUAu+9buFs9POvs4XhOujNIWsw21dnJPFLllcRM8wLEbZkF0CE0L
         7P7XqQJAw5lWPn8gUndmtiT3xuQFJyjRkH0TSHNDtOLaNkce/DnRtGR/arr+9J8ZbIFk
         x9UTeEMJuVZoY8puPdcUzWFjCarqL7b35SpwirlvYnCX+9gwJ2u9jG9y6Lk5p0xjm9rT
         t8kA==
X-Forwarded-Encrypted: i=1; AJvYcCXZse7ksarSnJrBC+LUadjkcg1J5iqFExs1U/xalDLe6CYaeE5tKl06w8TR7SiZ3lQQeowsicnmit9oJhhZ81xAOM5CgNVfvy05yw==
X-Gm-Message-State: AOJu0YyQ6bAXce3LOGt7nnihRgeZR/ejGTPX3rxdnnJQDaQr1O64EbK7
	/3C7+O5YsYsej/tN2L+P5vwnvsslLDQOc+6vtncPlYEw7PyAsPb9eeTyfCBzv2g1NxdsjUOwJcD
	ulQsqTTWXP5AGNWdjPfPPtukiwmvGllTbNCaGD/5WDDk5BWonCWSPz7zZ6w==
X-Received: by 2002:a05:600c:474d:b0:426:6e8b:3dc5 with SMTP id 5b1f17b1804b1-42806be7778mr15913625e9.32.1721911849194;
        Thu, 25 Jul 2024 05:50:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9q5uvqNSpT/5NnExscK0qCysyLDTMmr36IVw8Rt4+6jOlfp+0J3Wz3/u5fD/iD40wX4HhFg==
X-Received: by 2002:a05:600c:474d:b0:426:6e8b:3dc5 with SMTP id 5b1f17b1804b1-42806be7778mr15913505e9.32.1721911848939;
        Thu, 25 Jul 2024 05:50:48 -0700 (PDT)
Received: from klayman.redhat.com (host-82-62-247-97.business.telecomitalia.it. [82.62.247.97])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367d9393sm2092301f8f.26.2024.07.25.05.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 05:50:48 -0700 (PDT)
From: Marco Pagani <marpagan@redhat.com>
To: Moritz Fischer <mdf@kernel.org>,
	Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>
Cc: Marco Pagani <marpagan@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-fpga@vger.kernel.org
Subject: [PATCH 2/3] Simplify and improve the fpga bridge test suite using deferred actions
Date: Thu, 25 Jul 2024 14:50:30 +0200
Message-ID: <20240725125031.308195-3-marpagan@redhat.com>
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
 drivers/fpga/tests/fpga-bridge-test.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/fpga/tests/fpga-bridge-test.c b/drivers/fpga/tests/fpga-bridge-test.c
index 2f7a24f23808..b9ab29809e96 100644
--- a/drivers/fpga/tests/fpga-bridge-test.c
+++ b/drivers/fpga/tests/fpga-bridge-test.c
@@ -23,6 +23,13 @@ struct bridge_ctx {
 	struct bridge_stats stats;
 };
 
+/*
+ * Wrapper to avoid a cast warning when passing the action function directly
+ * to kunit_add_action().
+ */
+KUNIT_DEFINE_ACTION_WRAPPER(fpga_bridge_unregister_wrapper, fpga_bridge_unregister,
+			    struct fpga_bridge *);
+
 static int op_enable_set(struct fpga_bridge *bridge, bool enable)
 {
 	struct bridge_stats *stats = bridge->priv;
@@ -50,6 +57,7 @@ static const struct fpga_bridge_ops fake_bridge_ops = {
 static struct bridge_ctx *register_test_bridge(struct kunit *test, const char *dev_name)
 {
 	struct bridge_ctx *ctx;
+	int ret;
 
 	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
@@ -61,13 +69,10 @@ static struct bridge_ctx *register_test_bridge(struct kunit *test, const char *d
 					   &ctx->stats);
 	KUNIT_ASSERT_FALSE(test, IS_ERR_OR_NULL(ctx->bridge));
 
-	return ctx;
-}
+	ret = kunit_add_action_or_reset(test, fpga_bridge_unregister_wrapper, ctx->bridge);
+	KUNIT_ASSERT_EQ(test, ret, 0);
 
-static void unregister_test_bridge(struct kunit *test, struct bridge_ctx *ctx)
-{
-	fpga_bridge_unregister(ctx->bridge);
-	kunit_device_unregister(test, ctx->dev);
+	return ctx;
 }
 
 static void fpga_bridge_test_get(struct kunit *test)
@@ -141,8 +146,6 @@ static void fpga_bridge_test_get_put_list(struct kunit *test)
 	fpga_bridges_put(&bridge_list);
 
 	KUNIT_EXPECT_TRUE(test, list_empty(&bridge_list));
-
-	unregister_test_bridge(test, ctx_1);
 }
 
 static int fpga_bridge_test_init(struct kunit *test)
@@ -152,11 +155,6 @@ static int fpga_bridge_test_init(struct kunit *test)
 	return 0;
 }
 
-static void fpga_bridge_test_exit(struct kunit *test)
-{
-	unregister_test_bridge(test, test->priv);
-}
-
 static struct kunit_case fpga_bridge_test_cases[] = {
 	KUNIT_CASE(fpga_bridge_test_get),
 	KUNIT_CASE(fpga_bridge_test_toggle),
@@ -167,7 +165,6 @@ static struct kunit_case fpga_bridge_test_cases[] = {
 static struct kunit_suite fpga_bridge_suite = {
 	.name = "fpga_bridge",
 	.init = fpga_bridge_test_init,
-	.exit = fpga_bridge_test_exit,
 	.test_cases = fpga_bridge_test_cases,
 };
 
-- 
2.45.2



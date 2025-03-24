Return-Path: <linux-fpga+bounces-1125-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5484EA6E11E
	for <lists+linux-fpga@lfdr.de>; Mon, 24 Mar 2025 18:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E8631898C43
	for <lists+linux-fpga@lfdr.de>; Mon, 24 Mar 2025 17:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14FA8267B0F;
	Mon, 24 Mar 2025 17:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lmig1M0o"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993AD267B11;
	Mon, 24 Mar 2025 17:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742837600; cv=none; b=REVXqQS5o9LZ4EoyQ4/8bDCbpd266GYNz/QCLI4JM1ugnb0c9zYDc4zRKLisMhZQ54ytifugVzhOFZ7KWjX6DN+zUojkkakiM/93s7hxheFGwxm3rrFDeF+0tvPh8jlBeT+WvAHrW5E3cerrSPU9gWUBFQpr0vRkyhAwS4+enQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742837600; c=relaxed/simple;
	bh=5PgJCWrmA1a2uCozek4IhhKjd8jMGQnwBUzXUFNdLdc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F+Cg+tTQOG8g+wT8QV9vbgXmCd6tw/gsdFB5uGGiLnTySIT2KBe4elZQpNhWlmDYliwomn29yoM8W+kYEJx42Npm1iFGFahFPD8WH2e2SyWXV5ygIL8aeY0Bk1aKzcNqwQrNHP0vEiNgiVKfZ0XkdxU33QlPkUvKpnLRsH+23HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lmig1M0o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B0D7C4CEE4;
	Mon, 24 Mar 2025 17:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742837600;
	bh=5PgJCWrmA1a2uCozek4IhhKjd8jMGQnwBUzXUFNdLdc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lmig1M0ocMObm4YsaaDsh0k/5azy/Ys46N/oK536aHhWpeuNf/tHfUFRiMEcztSqU
	 yk3A9AExIdhs6jZw1Jfbzx3u7clE17drz+0vtou+c4GHOgJqPSUV7y+KO6szBRIy26
	 khN9wuKwlvHv9ZZkG4pOyhHwdQgELSvX4Z1BRJzRe7As5xWgRac7trN6s6INMRe9Gx
	 aFebhacfWG++vBWqYxX9DScuWmlCJcTxwswfXuh7teBmZbmI22Azrho7h4gvAfca1X
	 q4/EGf9cmUQaWPuf2vN1FcdBZIIYxV2IHLxTo60ByRvF4H+5Nj8WruvCFml9+Plhd4
	 A8AnAJQ3VfY8w==
From: Arnd Bergmann <arnd@kernel.org>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Moritz Fischer <mdf@kernel.org>,
	Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-next@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Tom Rix <trix@redhat.com>,
	Marco Pagani <marpagan@redhat.com>,
	Russ Weight <russ.weight@linux.dev>,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 04/10] fpga: tests: add module descriptions
Date: Mon, 24 Mar 2025 18:32:29 +0100
Message-Id: <20250324173242.1501003-4-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250324173242.1501003-1-arnd@kernel.org>
References: <20250324173242.1501003-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Modules without a description now cause a warning:

WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fpga/tests/fpga-bridge-test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fpga/tests/fpga-mgr-test.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fpga/tests/fpga-region-test.o

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/fpga/tests/fpga-bridge-test.c | 1 +
 drivers/fpga/tests/fpga-mgr-test.c    | 1 +
 drivers/fpga/tests/fpga-region-test.c | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/fpga/tests/fpga-bridge-test.c b/drivers/fpga/tests/fpga-bridge-test.c
index b9ab29809e96..124ba40e32b1 100644
--- a/drivers/fpga/tests/fpga-bridge-test.c
+++ b/drivers/fpga/tests/fpga-bridge-test.c
@@ -170,4 +170,5 @@ static struct kunit_suite fpga_bridge_suite = {
 
 kunit_test_suite(fpga_bridge_suite);
 
+MODULE_DESCRIPTION("KUnit test for the FPGA Bridge");
 MODULE_LICENSE("GPL");
diff --git a/drivers/fpga/tests/fpga-mgr-test.c b/drivers/fpga/tests/fpga-mgr-test.c
index 9cb37aefbac4..8748babb0504 100644
--- a/drivers/fpga/tests/fpga-mgr-test.c
+++ b/drivers/fpga/tests/fpga-mgr-test.c
@@ -330,4 +330,5 @@ static struct kunit_suite fpga_mgr_suite = {
 
 kunit_test_suite(fpga_mgr_suite);
 
+MODULE_DESCRIPTION("KUnit test for the FPGA Manager");
 MODULE_LICENSE("GPL");
diff --git a/drivers/fpga/tests/fpga-region-test.c b/drivers/fpga/tests/fpga-region-test.c
index 6a108cafded8..020ceac48509 100644
--- a/drivers/fpga/tests/fpga-region-test.c
+++ b/drivers/fpga/tests/fpga-region-test.c
@@ -214,4 +214,5 @@ static struct kunit_suite fpga_region_suite = {
 
 kunit_test_suite(fpga_region_suite);
 
+MODULE_DESCRIPTION("KUnit test for the FPGA Region");
 MODULE_LICENSE("GPL");
-- 
2.39.5



Return-Path: <linux-fpga+bounces-1052-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41FC6A3324D
	for <lists+linux-fpga@lfdr.de>; Wed, 12 Feb 2025 23:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB8223AA6D2
	for <lists+linux-fpga@lfdr.de>; Wed, 12 Feb 2025 22:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133231FF1D6;
	Wed, 12 Feb 2025 22:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RuYw5nad"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3104F190470;
	Wed, 12 Feb 2025 22:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739398594; cv=none; b=EgbdC8vHnueL+CfqF4imaSyMCQwFSMDT8Kthgi+MKvOEfVNlYDK7BFU6MNzKzcg9W75s0mgkUTkoFUoyHGEX2skMDcUf9+WOeHrDpKbi99GQ6tVVsKF1uIuRgKwAKlEriM0jUVFmNuHoWzQ0HNXmqmqT9Os3Ec6xelstD2LLyHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739398594; c=relaxed/simple;
	bh=kNDG/gEhiX5P6/7ND6hRtddzOBz2ryqMmMGUppU/+Fs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DLFTWxOBeVPFslLwfYMZ03osgonrBH+Q9ylUudNdSYqiWmspkrne4Wc5k6JPjmsNez2dnaq54lkrmcXbQu5mHgCUoQDsqOFjYxG7a0grxfzlej77ENZpNn5KigG20uYtlUdV+dXik5x0/5ibAlAXALBnjswn9Vzx62nJpa7uJH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RuYw5nad; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739398592; x=1770934592;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kNDG/gEhiX5P6/7ND6hRtddzOBz2ryqMmMGUppU/+Fs=;
  b=RuYw5nadeTrNlUZD4udC+PgBvETILiA9ow7QCho22iu0OOjTdzRzS3I9
   UokC3E3bW8pOUlVWYni4YXtgwUX6mo/OOEMGKxR2gJxYyOku63Mj4m3Dv
   wJVPNZY0Nrucl492PkXJfiQqbV1lAdQkfxVzyEqdJnOBNQfLK/O6MHbeL
   xhOOLUWCyKlDHbUuCpsmu+lQ0IRb9dObynNVswm8K1/JeVpLcAFLm+eH8
   U+bkltvV/X2QmWoWvwDaRgUuc0BFzvpynnENw67N3MXaBziHRUEqBh3JQ
   zR7a7SuQ0dzVgFahxFz6fG3zi4NooQGLknEEhFm1AJ9LXXduPeFya2X++
   A==;
X-CSE-ConnectionGUID: bfFxhWuESvC4SFRK0g+Jxw==
X-CSE-MsgGUID: h+lgoIbpSfq6Afe4NFWcRA==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="51066689"
X-IronPort-AV: E=Sophos;i="6.13,281,1732608000"; 
   d="scan'208";a="51066689"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 14:16:32 -0800
X-CSE-ConnectionGUID: 96gXPdYgRO2hb2f6hjraLw==
X-CSE-MsgGUID: AkjgMlqmQduJcg5E8fOQcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="150123862"
Received: from pg15swiplab1181.png.altera.com ([10.244.232.167])
  by orviesa001.jf.intel.com with ESMTP; 12 Feb 2025 14:16:29 -0800
From: tien.sung.ang@intel.com
To: Moritz Fischer <mdf@kernel.org>,
	Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kuhanh.murugasen.krishnan@intel.com,
	kuhanh.murugasen.krishnan@altera.com
Cc: Ang Tien Sung <tien.sung.ang@intel.com>
Subject: [PATCH] fpga: altera-cvp: Increase credit timeout
Date: Thu, 13 Feb 2025 06:12:49 +0800
Message-Id: <20250212221249.2715929-1-tien.sung.ang@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kuhanh Murugasen Krishnan <kuhanh.murugasen.krishnan@intel.com>

Increase the timeout for SDM (Secure device manager) data credits from
20ms to 40ms. Internal stress tests running at 500 loops failed with the
current timeout of 20ms. At the start of a FPGA configuration, the CVP
host driver reads the transmit credits from SDM. It then sends bitstream
FPGA data to SDM based on the total credits. Each credit allows the
CVP host driver to send 4kBytes of data. There are situations whereby,
the SDM did not respond in time during testing.

Signed-off-by: Ang Tien Sung <tien.sung.ang@intel.com>
Signed-off-by: Kuhanh Murugasen Krishnan <kuhanh.murugasen.krishnan@intel.com>
---
 drivers/fpga/altera-cvp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
index 6b0914432445..5af0bd33890c 100644
--- a/drivers/fpga/altera-cvp.c
+++ b/drivers/fpga/altera-cvp.c
@@ -52,7 +52,7 @@
 /* V2 Defines */
 #define VSE_CVP_TX_CREDITS		0x49	/* 8bit */
 
-#define V2_CREDIT_TIMEOUT_US		20000
+#define V2_CREDIT_TIMEOUT_US		40000
 #define V2_CHECK_CREDIT_US		10
 #define V2_POLL_TIMEOUT_US		1000000
 #define V2_USER_TIMEOUT_US		500000
-- 
2.25.1



Return-Path: <linux-fpga+bounces-1195-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C54AAB7C4
	for <lists+linux-fpga@lfdr.de>; Tue,  6 May 2025 08:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 145074E37E4
	for <lists+linux-fpga@lfdr.de>; Tue,  6 May 2025 06:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F57834D649;
	Tue,  6 May 2025 00:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rm/59r5A"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC05F3BC91E;
	Mon,  5 May 2025 23:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487382; cv=none; b=XX/py7Ze4QW9hOWO3Haln13SZ5+G4FReV/2XvH9c8daL659EhamsnQxiuMbpCN48Y25ewPmC6TqQHR+ZtP8iNk9V6LR1h/ZpPysNSDuKnxLvSJzaVeCZvyNoz395Pc6WmAc/ME61KP7HuDSsyq0Lc/zNuwPQqN8egxWTrSTjUoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487382; c=relaxed/simple;
	bh=MNGlNLSARosDWL9/qPbCvoRohfJjlFuxy37g7ldF6l0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HABZolcKy8tYd/btWwWjrtRhuqAqJORkJkASHWcBV8qNTicCx83hqJ2R3aZrXQtOR4eOVSlhV+CWK3T2+BEc7MdwscAI4zWwNf8pjgW5xghTUz9FXcfm+a/EZczoXjtf+cNRtI+Y5uCBTitA9OmW9hqQltJ3hlttiCAFTB9rIQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rm/59r5A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 948E3C4CEE4;
	Mon,  5 May 2025 23:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487382;
	bh=MNGlNLSARosDWL9/qPbCvoRohfJjlFuxy37g7ldF6l0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rm/59r5AruEniC19DV8O3mAlHe54IB0S4TO/fM63E13JbEfhOWGH8GopnQBLAQ/jU
	 n67/YGVin/dZF6BKeudtOSxi9BV8FfktJRtRvtKkl/Jn2pq5/QVZHQ7Y1aGP3i5KyB
	 awrNsc3/pIbywZvvV2L3I07Z07pXUi0IYzPnJLUq0R4O/9war3msJoRtZRboha5pe6
	 pS8dbKAAM6IODGUkAxrGlZBiQyUrQPoxbzpTZ1k70DX5uzTdDb6zGKAXnPZKFEYevP
	 K34kCXgYwr1GNyW0L/DrY5+kGVi/vuoyUTXeglC0KMWASLuZtoSNy5gQJkr2qVyuXb
	 Hl0BdOGypTZ4w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kuhanh Murugasen Krishnan <kuhanh.murugasen.krishnan@intel.com>,
	Ang Tien Sung <tien.sung.ang@intel.com>,
	Xu Yilun <yilun.xu@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	mdf@kernel.org,
	hao.wu@intel.com,
	linux-fpga@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 40/79] fpga: altera-cvp: Increase credit timeout
Date: Mon,  5 May 2025 19:21:12 -0400
Message-Id: <20250505232151.2698893-40-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505232151.2698893-1-sashal@kernel.org>
References: <20250505232151.2698893-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.293
Content-Transfer-Encoding: 8bit

From: Kuhanh Murugasen Krishnan <kuhanh.murugasen.krishnan@intel.com>

[ Upstream commit 0f05886a40fdc55016ba4d9ae0a9c41f8312f15b ]

Increase the timeout for SDM (Secure device manager) data credits from
20ms to 40ms. Internal stress tests running at 500 loops failed with the
current timeout of 20ms. At the start of a FPGA configuration, the CVP
host driver reads the transmit credits from SDM. It then sends bitstream
FPGA data to SDM based on the total credits. Each credit allows the
CVP host driver to send 4kBytes of data. There are situations whereby,
the SDM did not respond in time during testing.

Signed-off-by: Ang Tien Sung <tien.sung.ang@intel.com>
Signed-off-by: Kuhanh Murugasen Krishnan <kuhanh.murugasen.krishnan@intel.com>
Acked-by: Xu Yilun <yilun.xu@intel.com>
Link: https://lore.kernel.org/r/20250212221249.2715929-1-tien.sung.ang@intel.com
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/fpga/altera-cvp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
index 4e0edb60bfba6..d107ad73a188c 100644
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
2.39.5



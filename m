Return-Path: <linux-fpga+bounces-1061-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DECFCA3C5FC
	for <lists+linux-fpga@lfdr.de>; Wed, 19 Feb 2025 18:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08DCC188E505
	for <lists+linux-fpga@lfdr.de>; Wed, 19 Feb 2025 17:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B222144CC;
	Wed, 19 Feb 2025 17:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HfGzKuRJ"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C6A21423F;
	Wed, 19 Feb 2025 17:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739985618; cv=none; b=MqTmtvWMiEp1tPI2glVYiUVUOhokQla9J5pQeQNUrZj2hIY1T5+Ou8Plw9Ju67DQE+KHvKdwI+I6NByY37QOsWCBBuONjzO5FEcwFAz/o+eMjggN49JtvYozPK7LkZ3I/4XcgjKWjsOsfT5bJElREqy9oO4nEQ4nddccR7jOaXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739985618; c=relaxed/simple;
	bh=bMSRWL9vhgEV0SWpFh+qnRL63hnQOGX+QjCyihjf6vE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uxQ8PWbo/fuglXQeygtCkVIJBGGxriw7w0SrjpeAvUK+455w++sosGldcWucfpx9awyvOKsrhR9i3rroaCg8hsU8kBz3mPaEuokcOnNefZj7NeRyE9/p6DFRTWDTj5Fn7xOXYIXNTWw+cjGc+ud86ypYFJoDBxrp/tbxN7+RRPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HfGzKuRJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C061CC4CEDD;
	Wed, 19 Feb 2025 17:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739985617;
	bh=bMSRWL9vhgEV0SWpFh+qnRL63hnQOGX+QjCyihjf6vE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=HfGzKuRJqxFIQWlGy2hP9VwCCnYYjAUNsv0/v7RaHeLjU/srBm73VQTxDiFcoT5gy
	 bUAem9iShteDeUDvmtZv9HkxfJTcpfSlwFUvDTesXYmPButyZZPQvdqkNGH7O+5/a5
	 9ADj31JzRjhqsHgTB5sJ7ahQlGocnpCrRCcbL8KIp3L4PIfHnOeIh1wTukWYPRkeWo
	 PdBGadJIkpxUwSydhFnelNwVtXkznNDQV4cN/QU9vJqAfrk2IFA/i7BaSvhivecAip
	 ClKWfFgmO9bJRNLNR7GOBYoqeHiDyLKNFzyV6p/7GnGi0xVlDKxMwiBkzGcy0L5z6p
	 4vcYfrVNByOYQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A5FC021B0;
	Wed, 19 Feb 2025 17:20:17 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Wed, 19 Feb 2025 17:20:19 +0000
Subject: [PATCH 1/6] clk: clk-axi-clkgen: fix fpfd_max frequency for zynq
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250219-dev-axi-clkgen-limits-v1-1-26f7ef14cd9c@analog.com>
References: <20250219-dev-axi-clkgen-limits-v1-0-26f7ef14cd9c@analog.com>
In-Reply-To: <20250219-dev-axi-clkgen-limits-v1-0-26f7ef14cd9c@analog.com>
To: linux-clk@vger.kernel.org, linux-fpga@vger.kernel.org
Cc: Stephen Boyd <sboyd@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>, 
 Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739985620; l=999;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=3XWz9JBStnY9lwXNwvrymtRHf0DsK7mnM7TrKIE5Q88=;
 b=CagHeeQdIboKjyeU5BMWDU+YjMPK03N/b7ioxFvpB1lk3BgUHlZ3TLsHbsqZhRj+bAMcgIkBW
 MFypUeUwB2LCsv7Fhvc3zbcg1h5EJk18I7KXqEEZII+FEzfr0DLkZUP
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

The fpfd_max frequency should be set to 450 MHz instead of 300 MHz.
Well, it actually depends on the platform speed grade but we are being
conservative for ultrascale so let's be consistent. In a following
change we will set these limits at runtime.

Fixes: 0e646c52cf0e ("clk: Add axi-clkgen driver")
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/clk/clk-axi-clkgen.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-axi-clkgen.c b/drivers/clk/clk-axi-clkgen.c
index 934e53a96dddac8ed61dd109cfc188f3a2a0539a..00bf799964c61a3efc042b0f3a9ec3bc8625c9da 100644
--- a/drivers/clk/clk-axi-clkgen.c
+++ b/drivers/clk/clk-axi-clkgen.c
@@ -118,7 +118,7 @@ static const struct axi_clkgen_limits axi_clkgen_zynqmp_default_limits = {
 
 static const struct axi_clkgen_limits axi_clkgen_zynq_default_limits = {
 	.fpfd_min = 10000,
-	.fpfd_max = 300000,
+	.fpfd_max = 450000,
 	.fvco_min = 600000,
 	.fvco_max = 1200000,
 };

-- 
2.48.1




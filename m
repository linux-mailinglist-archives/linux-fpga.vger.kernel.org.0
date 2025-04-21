Return-Path: <linux-fpga+bounces-1163-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 832B8A95328
	for <lists+linux-fpga@lfdr.de>; Mon, 21 Apr 2025 16:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAF283AB1C2
	for <lists+linux-fpga@lfdr.de>; Mon, 21 Apr 2025 14:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B061C84A5;
	Mon, 21 Apr 2025 14:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GkIZOLWT"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B411C5F18;
	Mon, 21 Apr 2025 14:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745247488; cv=none; b=Fu7ZbU7+UnuUpvngj/kcEoEPZHn1EnJjuxcvYJU41veSGD45DSvYxmmJ4uyrzlcv6A9W4KSYvbDF5SJQlhmfYuMfYEQpF7MRgxK5nu6BdYudCOK/DK389Rf4NHU01f3/eQJYxRrqLqexeaAFbUNuxIh60O0kG9/eT76bMlth5DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745247488; c=relaxed/simple;
	bh=HI59+3VsZAHzDG2lW8mj78HPsyNMQFBt0V6LHST9s0s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PFERdfNujwxVwIXyysL3PZq7vcqrwEAXflnE96tDgJd7FSUksnyoya0Goi8SZNzXg9tkkVTcg1rg1IcKxuBI2zeJ/vxJF4ZjQzXyk+j3Uu3bK//3jqVsZw502lg86QeBV6Wa8hb0db80SbJfV3DGm7gJPMSPH/NHxAD7fuWZdxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GkIZOLWT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9961CC4CEEC;
	Mon, 21 Apr 2025 14:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745247487;
	bh=HI59+3VsZAHzDG2lW8mj78HPsyNMQFBt0V6LHST9s0s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=GkIZOLWTK9XPN+tq7mneQjrzPENLkJ+Tt7WIV+tAGPt3NEUYMVcWYV6ori1NJngtp
	 hfTWBQ5ykr82Wr1bv9mgmrooo0JpzeLNSNFX7EY316mYhakeVNaAUUzYcORgj/5xFz
	 8I4UaFIvI4Tgf7JGUeJ0fcGp7JLmNUmENFznPTAY+8auve3+ea2Azf83Ib6IyraZiP
	 f2PP+u+o2NFG5NfwzvaE7hhexqED405P6IOoEsa6YG0E6aOevd3bKrX/whNXTt1Gt3
	 WPhAkmlHq7h1BQJqZIe1dfkOAUHxYwSXLBzBluc3/4Jh4gGx7PPqkHYqNV+fOgmAHf
	 /tGtHrADZu0qQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87909C369C2;
	Mon, 21 Apr 2025 14:58:07 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Mon, 21 Apr 2025 15:58:02 +0100
Subject: [PATCH RESEND v3 1/6] clk: clk-axi-clkgen: fix fpfd_max frequency
 for zynq
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250421-dev-axi-clkgen-limits-v3-1-4203b4fed2c9@analog.com>
References: <20250421-dev-axi-clkgen-limits-v3-0-4203b4fed2c9@analog.com>
In-Reply-To: <20250421-dev-axi-clkgen-limits-v3-0-4203b4fed2c9@analog.com>
To: linux-clk@vger.kernel.org, linux-fpga@vger.kernel.org
Cc: Stephen Boyd <sboyd@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>, 
 Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745247490; l=999;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=5+y858CS+pLM6RSN4Bbzxos5w9xYK0rwoYDgzKAlxLk=;
 b=sda2AdKLkiMCkdtnb64oYpMyE1Xif5zUSv0VQOQ+q0fDfLYblmNUU8zNIhTaY0KVCbPJywzFR
 6FrWSqju4KqCtw9eSpUC6KqSLeWwpCmwaqKSOLGsnKexhEydp//xk1Y
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
2.49.0




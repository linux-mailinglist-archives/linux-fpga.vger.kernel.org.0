Return-Path: <linux-fpga+bounces-1137-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64905A7DB30
	for <lists+linux-fpga@lfdr.de>; Mon,  7 Apr 2025 12:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AD3F179659
	for <lists+linux-fpga@lfdr.de>; Mon,  7 Apr 2025 10:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56D2230BFA;
	Mon,  7 Apr 2025 10:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k2Qb565T"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1CD22FF58;
	Mon,  7 Apr 2025 10:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744021699; cv=none; b=bUV3ORt5Rg8MxNrKlxxDhbleAb6wOMT8M+EnddR0yFzq/n0tYInO8f8EmfmBLDsd5f2r9+FNfVXy5JfpUOtL/qSsWfwViB1C2KJYqRXEJWirBFgka1xfM2gqhtY1UWtcPPYuIXjyAPxxBKJo/Pidn+tzlgwZmh42rsrETUOiHFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744021699; c=relaxed/simple;
	bh=HI59+3VsZAHzDG2lW8mj78HPsyNMQFBt0V6LHST9s0s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DuqKKCteBUlvYuT/+17lL8IX5CX348vc2Pcw8/yYtmUhtg7hAIcj7xWSw/7vgxHxMtjHtfWxxsEEPnjqGWTm/oxZpWs3ekbw+jF5OapS775bXdOvjyjPkvEe95F9+fSJQDiy9WssO8WSgfg8IknXb1koJwWDu6hDQeNApAoA2Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k2Qb565T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F2D5FC4CEE7;
	Mon,  7 Apr 2025 10:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744021699;
	bh=HI59+3VsZAHzDG2lW8mj78HPsyNMQFBt0V6LHST9s0s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=k2Qb565TIhfBtmWLqysMjHVtz/UnisQoOETYVMzg7q67i1c8G1YRt3RIxsSCHCXJZ
	 j1ayiAGWmPfbSS6DVWXTFWInQR63G1vlnXpI6S0VLeSJTF6jXKNsoBpKcw9e0qH9gV
	 IeLlmWhabBf6LefNsjr9V2hoRTVGxnAnaIR+HKtQL/sO2QswDae21r1OU2AAWqJ5N+
	 x6FrXyc65iYsfcqvjeRjk2aVK7XHlXwFZEFtuTrjVCljI7F8XyJ0/+sycPk65dEUPn
	 RRUdGg+hWS9RZdx8Qe8TwpGKA4jo/gmCOA/0ThOHBF2C+A/OoxxXhPTBNVNjP0xAgb
	 jf+/frvLLs6TA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E757DC369A2;
	Mon,  7 Apr 2025 10:28:18 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Mon, 07 Apr 2025 11:28:15 +0100
Subject: [PATCH v3 1/6] clk: clk-axi-clkgen: fix fpfd_max frequency for
 zynq
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250407-dev-axi-clkgen-limits-v3-1-33c7f27c9d69@analog.com>
References: <20250407-dev-axi-clkgen-limits-v3-0-33c7f27c9d69@analog.com>
In-Reply-To: <20250407-dev-axi-clkgen-limits-v3-0-33c7f27c9d69@analog.com>
To: linux-clk@vger.kernel.org, linux-fpga@vger.kernel.org
Cc: Stephen Boyd <sboyd@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>, 
 Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744021698; l=999;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=5+y858CS+pLM6RSN4Bbzxos5w9xYK0rwoYDgzKAlxLk=;
 b=CCbAPb3qeKPsNTvTPoqpQ/gxT/HkLcCV37Twy0S8esbtKaByFoAWtrMz+j+WXxoPFbNu3xtlR
 DmmC54ZaTzhCsBcVMakPB4OY2JIuyEvi4ryRRsHPS9gUM7pd5D2mO1d
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




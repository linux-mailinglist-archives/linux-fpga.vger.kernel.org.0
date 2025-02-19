Return-Path: <linux-fpga+bounces-1058-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA61A3C5FA
	for <lists+linux-fpga@lfdr.de>; Wed, 19 Feb 2025 18:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE3A016FDDC
	for <lists+linux-fpga@lfdr.de>; Wed, 19 Feb 2025 17:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5845A2144A7;
	Wed, 19 Feb 2025 17:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KDdCksLP"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F91320E6F9;
	Wed, 19 Feb 2025 17:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739985618; cv=none; b=Tt1urtrHAKWIQcDoYeBWszQlcwBgy4LMSoHi/aAS+5ubmRcjqN/wtagyMj9LwPcgAFmcZwAj39HIEHQexbQooZN6f/jswbQP1/ukBl7jvqjL4nW1a6wtpYB6iU3k8gAg15mWsbDS52sefmaAAQisfhrfXlnvD8rQ9BAhXSh3oEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739985618; c=relaxed/simple;
	bh=4es1eyBKKpCqIekbjwlzdY5OhzypORpRYcmfkLXfn9k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uXUAs7P3ZppC/CySPjpHlt99hYNmT+OGLRHSMuJTl7wZGFWbIbONIXOMfMto59p1l17eDI4xJ7rr+ZObRetclIdFz9IYOJhsTLioOVnWP77ZsV1rtzCshmBSFNrhs7yv516lsanCcNmCqUG0uRReVsjVVHkXLKszow7q+evSqiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KDdCksLP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0988CC4CEEE;
	Wed, 19 Feb 2025 17:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739985618;
	bh=4es1eyBKKpCqIekbjwlzdY5OhzypORpRYcmfkLXfn9k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=KDdCksLPzektJVATykRIL1+vlMXfJZGNMRfEIq6nBhoBbFOJRUXAWGYbTUaoEtTpG
	 eX2nt4Iq9InjaKzvhnAM/wNEhxsgYYhht8aInT2J0fH13V2763qEdoc55hjFTLMBoc
	 K+8sUcOAOT1WGrp3Pp2sfmC9gPEhq64bGQZb2ECJWjwAHeZqbDSn8kBtHrb6OdfZl9
	 1X6+tjNRTfMKqCZF6xneIipMRt5cfv6qL7Nfutb+5ZFK0AL02d6Lyk1AL9s+lmyCCs
	 SC8wnAtCUld/dyx8VWn6RC+MnTH0QKuA/7iaVlqeF3lkOadXo8b7lrHqQeJ/nYjNWJ
	 cwIXUUtYiRhKg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3DF6C021AA;
	Wed, 19 Feb 2025 17:20:17 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Wed, 19 Feb 2025 17:20:23 +0000
Subject: [PATCH 5/6] clk: clk-axi-clkgen move to min/max()
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250219-dev-axi-clkgen-limits-v1-5-26f7ef14cd9c@analog.com>
References: <20250219-dev-axi-clkgen-limits-v1-0-26f7ef14cd9c@analog.com>
In-Reply-To: <20250219-dev-axi-clkgen-limits-v1-0-26f7ef14cd9c@analog.com>
To: linux-clk@vger.kernel.org, linux-fpga@vger.kernel.org
Cc: Stephen Boyd <sboyd@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>, 
 Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739985620; l=1495;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=dKtpJRfG8e67XLztq7w3SFpV7IL+cAAC4d8nwJYRezc=;
 b=79EDtsKwfsLPU2lzzPpm5kQnq6fd/Z0f5NE3HV/z0qdK756HI+5vSXWMH2J0HCDCLQ6sqWIzR
 QjXa4qYZWM2Aahnl9qQBSrEfaY1SFAAA0Rfpf6fCjkR3E4w8QBSuPKz
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

Instead of using the type versions of min/max(), use the plain ones as
now they are perfectly capable of handling different types like
unsigned and non negative integers that are compiletime constant.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/clk/clk-axi-clkgen.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/clk-axi-clkgen.c b/drivers/clk/clk-axi-clkgen.c
index 8c270ba7626bc24c4385615b7aa08ee95e198881..82a99c3b9063cd2dd8a9dc7fdec81a38feee12b9 100644
--- a/drivers/clk/clk-axi-clkgen.c
+++ b/drivers/clk/clk-axi-clkgen.c
@@ -144,15 +144,15 @@ static void axi_clkgen_calc_params(const struct axi_clkgen_limits *limits,
 	*best_m = 0;
 	*best_dout = 0;
 
-	d_min = max_t(unsigned long, DIV_ROUND_UP(fin, limits->fpfd_max), 1);
-	d_max = min_t(unsigned long, fin / limits->fpfd_min, 80);
+	d_min = max(DIV_ROUND_UP(fin, limits->fpfd_max), 1);
+	d_max = min(fin / limits->fpfd_min, 80);
 
 again:
 	fvco_min_fract = limits->fvco_min << fract_shift;
 	fvco_max_fract = limits->fvco_max << fract_shift;
 
-	m_min = max_t(unsigned long, DIV_ROUND_UP(fvco_min_fract, fin) * d_min, 1);
-	m_max = min_t(unsigned long, fvco_max_fract * d_max / fin, 64 << fract_shift);
+	m_min = max(DIV_ROUND_UP(fvco_min_fract, fin) * d_min, 1);
+	m_max = min(fvco_max_fract * d_max / fin, 64 << fract_shift);
 
 	for (m = m_min; m <= m_max; m++) {
 		_d_min = max(d_min, DIV_ROUND_UP(fin * m, fvco_max_fract));

-- 
2.48.1




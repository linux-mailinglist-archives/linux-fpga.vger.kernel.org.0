Return-Path: <linux-fpga+bounces-1168-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6952BA95332
	for <lists+linux-fpga@lfdr.de>; Mon, 21 Apr 2025 16:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0B123ADA2D
	for <lists+linux-fpga@lfdr.de>; Mon, 21 Apr 2025 14:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A431CEEB2;
	Mon, 21 Apr 2025 14:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k6Xu7ZUg"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED0E1CAA79;
	Mon, 21 Apr 2025 14:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745247488; cv=none; b=GsUYp0rqI0csMjWzEZnPnYdJiWCYDs3e4w4SGyV9WytZJQK0ZT7Zj5WkbLsKPN3awTTy21dnbj4XCg9gPnDKvjKe71QSAMwwuQABA7L+aGX+iU9OyTjGGvW7Uov0x/pK52vttsnBPRtqLZxFU8LZ8lO8cSZjaMH0s0gaA6bEqA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745247488; c=relaxed/simple;
	bh=GkXRp/bBkXhpMmVJsCM71rhkrdoAeH33xil+Yj6A7NQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NfaY0+rcdUs47qXcmET2UyhWkSPGrKUvxpJE+37qljAeih/fkJI9NK549y0CpT89LqeBovEVRDekxqAXZQwYkGHW994TllXK++CTQ6zUkWfGppVQtDRxns3p6LW1IHY0XMJ2AM++Zj/KajCSTDX8b86SotrumhzyP7IKnz8tIzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k6Xu7ZUg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D3114C4CEF1;
	Mon, 21 Apr 2025 14:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745247487;
	bh=GkXRp/bBkXhpMmVJsCM71rhkrdoAeH33xil+Yj6A7NQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=k6Xu7ZUgTZW7yjgSINaBPreWtGmr9KQy+qW9+DqwKfqSoFV+JPkYv5y4fDA6MIrcg
	 JOB86A7pNgcXSt3jk8wEthLj/CblkrTVcs/IvrXsraeAYODUE2v3AXXZ2ykhY1qxAP
	 ysQab5MCyGXZhz+1KWgzGf4i9o5/3h4Zd8NXHBcTeGK+rg1LjhDz6y+jBnVlEBvEOP
	 G7z9/c5yHPaxg9UZvxyNUbdkmq9ZbP1IK+SSYhHpzLbhB4PF8DsXFwMwwTpohGKxDD
	 /G83dkxrRKyL2CRBp1dQL0Ox63XZQlnqXGosr8Zex4IcHTheweDQrauwOB4ZdeOArH
	 kqt7AjBYwIRpg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA5FC369AB;
	Mon, 21 Apr 2025 14:58:07 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Mon, 21 Apr 2025 15:58:06 +0100
Subject: [PATCH RESEND v3 5/6] clk: clk-axi-clkgen move to min/max()
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250421-dev-axi-clkgen-limits-v3-5-4203b4fed2c9@analog.com>
References: <20250421-dev-axi-clkgen-limits-v3-0-4203b4fed2c9@analog.com>
In-Reply-To: <20250421-dev-axi-clkgen-limits-v3-0-4203b4fed2c9@analog.com>
To: linux-clk@vger.kernel.org, linux-fpga@vger.kernel.org
Cc: Stephen Boyd <sboyd@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>, 
 Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745247490; l=1495;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=BmiMR6v/RhazvTHFDFm7ANLKTnoa1lQFUceXNiwKsBk=;
 b=BBH7qSmHHh4B8lpAK+X9SxJjH5zfwug/7+ZWuZrvFVA6jOLaNqiLe8CwWKJiZvUYbDLpaFuEY
 CdJPgmSJuCjCVSALC9HZVxCw8nS2qf0qkINxOIgW5rvdmhI+vkWTnaC
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
2.49.0




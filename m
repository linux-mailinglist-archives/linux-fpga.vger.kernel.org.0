Return-Path: <linux-fpga+bounces-1111-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D7AA5F963
	for <lists+linux-fpga@lfdr.de>; Thu, 13 Mar 2025 16:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7665717701C
	for <lists+linux-fpga@lfdr.de>; Thu, 13 Mar 2025 15:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D0A268C77;
	Thu, 13 Mar 2025 15:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s8t0VT7A"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0029268C55;
	Thu, 13 Mar 2025 15:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741878881; cv=none; b=bBCVM7XkuGjao7lRIIfEEq3hROlBlFuvnHo/DNBXw1cfuVSL8k8BJG7Ya0qNg6SoMnzBslXmnF+73y1r54Gh6u/PkvhSvpoiGd8XSf2XUgXZyPpHyY6wCVSwWn0TykQ2D+E+FE8GCAIa0n3NyWo+0DFHbImbF6DHjpcwDv9zPJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741878881; c=relaxed/simple;
	bh=4es1eyBKKpCqIekbjwlzdY5OhzypORpRYcmfkLXfn9k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LmrXBgZbL/3GdHxMnl0Hzwmz+BKXtHGWP3IhNobxRvkbQB7GE5RPzMYVJYyJSccf3FDrSJKbrCawl9wuSKvjNRG8GDl6cav6RXUsfluT2UqH2O5no0J+bS7L2MW98mzsLgDS9dVObkxhw/DoevfjjJENWtEZrafx08C8LUJxvEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s8t0VT7A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3DDFAC4CEF2;
	Thu, 13 Mar 2025 15:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741878881;
	bh=4es1eyBKKpCqIekbjwlzdY5OhzypORpRYcmfkLXfn9k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=s8t0VT7A//EjHhXdlJjaSrMTNRP34gZVQxAFjdGh8tqhyfPXbm/FwDUUWELLzVz/A
	 jHsLtrXdBA0tU2/ouSFvJ4bw0zjL5Kh2IyX7zymLJw3hjzZUNZWp3cCstkNtwGxi5N
	 SOnHUGp/CQ7YKbQ4Te6ZS4VFY3JjqkFuDgZOJgekf33jnc6pSx4otiq5NWqCHbH14e
	 fGz8ewvbPF9LlAieqKAGVaSb04ehJj7o7foEruAOZiT8GNk7cB8d6FhVoHSIwZIql1
	 3OZDTXPiVA+632zKVNncDksGE2dn2gGBQ7G/JwlW6cfODnhEbYTZaRsT8h7mHyqOSq
	 1Ho6Z8TIMxoEA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35919C282DE;
	Thu, 13 Mar 2025 15:14:41 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Thu, 13 Mar 2025 15:14:47 +0000
Subject: [PATCH v2 5/6] clk: clk-axi-clkgen move to min/max()
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250313-dev-axi-clkgen-limits-v2-5-173ae2ad6311@analog.com>
References: <20250313-dev-axi-clkgen-limits-v2-0-173ae2ad6311@analog.com>
In-Reply-To: <20250313-dev-axi-clkgen-limits-v2-0-173ae2ad6311@analog.com>
To: linux-clk@vger.kernel.org, linux-fpga@vger.kernel.org
Cc: Stephen Boyd <sboyd@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>, 
 Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741878886; l=1495;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=dKtpJRfG8e67XLztq7w3SFpV7IL+cAAC4d8nwJYRezc=;
 b=Vaada4RxJfvnhKF+Fha4ARloVFoxIcsrMfoi6U9oVR883Fu/5rxTZ0L4FhCtFEDSZy/N/AEDA
 GolpL6aUP13BdtbfObqZwNaA0/8MlTtC96ltigAy/y38b6JUTzt9yYK
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




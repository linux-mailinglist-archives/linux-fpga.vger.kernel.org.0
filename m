Return-Path: <linux-fpga+bounces-1062-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 779DDA3C602
	for <lists+linux-fpga@lfdr.de>; Wed, 19 Feb 2025 18:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 251FA1890951
	for <lists+linux-fpga@lfdr.de>; Wed, 19 Feb 2025 17:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A46D2144D1;
	Wed, 19 Feb 2025 17:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p2qCmyP5"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C24F2144A1;
	Wed, 19 Feb 2025 17:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739985618; cv=none; b=vErP1s6CK8apB4kCAZ4ZX6FxjrIWV4wn160SEZkeMHS8lwq6/FbEYDN9bkMp+PP17eJICKp4ZxcfYWuNyVnuYS7DgSPsW0Y6uItvUacXt6VHUyYFH4jiB7X4JbXwa70/uCFtu7LZfpYUHTcJkfzsNf5lvvwYfoiE9JHL6NqESD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739985618; c=relaxed/simple;
	bh=i1VGXudil3uO8mpDRLwILbAkxLcKhM1U565yRk8gfXg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AeWKi7Oqq4ZFhcHcKnRbm9m2XZhpep8kC5h0YU6Gy2gwNES6IZRBb+RvG4fnU9yLG/kTPwADeIeiHHzKqxOVMjVPrqddyj1eTOU6iSTjzgjYEsxchNcthSEfBtWys/HZPmm3rjht843FktUfnK881h/oj22ZNQj6QuE5Scrz7+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p2qCmyP5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 20FA0C4CEF0;
	Wed, 19 Feb 2025 17:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739985618;
	bh=i1VGXudil3uO8mpDRLwILbAkxLcKhM1U565yRk8gfXg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=p2qCmyP5hZUekRMQcJ0nHd0lh/uPFISWV9mb/QQF2+sx9ntZswasaLiNjO4YUy/gh
	 hVlrpN75Cwv6gwepJBrBMF58flW+/yZbCXj97XAZRuoLlkWitl0tfVIbrkXEqya9G6
	 Iie4G5kfR5g+Q39uOxigSOoUE04Dm7PMx9L2ASTU3AJkl2e2Lq/uDh7l82h80AiDAa
	 MPDoRKrk7HE42vdC9rLXvGqPFrZ54fx5ZZ4cIT6plvTyI+uqQUEYjaZM0LfiaehptK
	 QGpae/Pubf5O3Qw03WUrd7RhKbr5+nOA9QhrgB1+lgQDviLgH+9/DWhtrEBYXNfOMW
	 0UXiBemb4+o7g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10973C021B2;
	Wed, 19 Feb 2025 17:20:18 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Wed, 19 Feb 2025 17:20:24 +0000
Subject: [PATCH 6/6] clk: clk-axi-clkgen: fix coding style issues
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250219-dev-axi-clkgen-limits-v1-6-26f7ef14cd9c@analog.com>
References: <20250219-dev-axi-clkgen-limits-v1-0-26f7ef14cd9c@analog.com>
In-Reply-To: <20250219-dev-axi-clkgen-limits-v1-0-26f7ef14cd9c@analog.com>
To: linux-clk@vger.kernel.org, linux-fpga@vger.kernel.org
Cc: Stephen Boyd <sboyd@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>, 
 Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739985620; l=8515;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=tI86xVg7YOftvhQhe4lqGIGeOGxdqHpIWGA5l8Te3T4=;
 b=hJnbc8/K+bhq/Lcif6ek1z9lnq9aCHnZLwwZ/JdW8wusoQtBwJt9aTrBw+WeGRWVxv73wYdLx
 Pme1b4X/TMqAZifURg8pjCdW9zVuNIV/97YtDXqutLYF8H8f8vj27k5
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

This is just cosmetics and so no functional changes intended.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/clk/clk-axi-clkgen.c | 76 +++++++++++++++++++++++---------------------
 1 file changed, 39 insertions(+), 37 deletions(-)

diff --git a/drivers/clk/clk-axi-clkgen.c b/drivers/clk/clk-axi-clkgen.c
index 82a99c3b9063cd2dd8a9dc7fdec81a38feee12b9..c2b5c01698455075ad01d5fad356aa162c53b3bc 100644
--- a/drivers/clk/clk-axi-clkgen.c
+++ b/drivers/clk/clk-axi-clkgen.c
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/err.h>
+#include <linux/types.h>
 
 #include <linux/fpga/adi-axi-common.h>
 
@@ -93,7 +94,7 @@ static uint32_t axi_clkgen_lookup_filter(unsigned int m)
 	}
 }
 
-static const uint32_t axi_clkgen_lock_table[] = {
+static const u32 axi_clkgen_lock_table[] = {
 	0x060603e8, 0x060603e8, 0x080803e8, 0x0b0b03e8,
 	0x0e0e03e8, 0x111103e8, 0x131303e8, 0x161603e8,
 	0x191903e8, 0x1c1c03e8, 0x1f1f0384, 0x1f1f0339,
@@ -105,7 +106,7 @@ static const uint32_t axi_clkgen_lock_table[] = {
 	0x1f1f012c, 0x1f1f0113, 0x1f1f0113, 0x1f1f0113,
 };
 
-static uint32_t axi_clkgen_lookup_lock(unsigned int m)
+static u32 axi_clkgen_lookup_lock(unsigned int m)
 {
 	if (m < ARRAY_SIZE(axi_clkgen_lock_table))
 		return axi_clkgen_lock_table[m];
@@ -127,8 +128,9 @@ static const struct axi_clkgen_limits axi_clkgen_zynq_default_limits = {
 };
 
 static void axi_clkgen_calc_params(const struct axi_clkgen_limits *limits,
-	unsigned long fin, unsigned long fout,
-	unsigned int *best_d, unsigned int *best_m, unsigned int *best_dout)
+				   unsigned long fin, unsigned long fout,
+				   unsigned int *best_d, unsigned int *best_m,
+				   unsigned int *best_dout)
 {
 	unsigned long d, d_min, d_max, _d_min, _d_max;
 	unsigned long m, m_min, m_max;
@@ -195,9 +197,9 @@ struct axi_clkgen_div_params {
 };
 
 static void axi_clkgen_calc_clk_params(unsigned int divider,
-	unsigned int frac_divider, struct axi_clkgen_div_params *params)
+				       unsigned int frac_divider,
+				       struct axi_clkgen_div_params *params)
 {
-
 	memset(params, 0x0, sizeof(*params));
 
 	if (divider == 1) {
@@ -224,8 +226,8 @@ static void axi_clkgen_calc_clk_params(unsigned int divider,
 
 		if (params->edge == 0 || frac_divider == 1)
 			params->low--;
-		if (((params->edge == 0) ^ (frac_divider == 1)) ||
-			(divider == 2 && frac_divider == 1))
+		if ((params->edge == 0 ^ frac_divider == 1) ||
+		    (divider == 2 && frac_divider == 1))
 			params->frac_wf_f = 1;
 
 		params->frac_phase = params->edge * 4 + frac_divider / 2;
@@ -233,13 +235,13 @@ static void axi_clkgen_calc_clk_params(unsigned int divider,
 }
 
 static void axi_clkgen_write(struct axi_clkgen *axi_clkgen,
-	unsigned int reg, unsigned int val)
+			     unsigned int reg, unsigned int val)
 {
 	writel(val, axi_clkgen->base + reg);
 }
 
 static void axi_clkgen_read(struct axi_clkgen *axi_clkgen,
-	unsigned int reg, unsigned int *val)
+			    unsigned int reg, unsigned int *val)
 {
 	*val = readl(axi_clkgen->base + reg);
 }
@@ -260,7 +262,7 @@ static int axi_clkgen_wait_non_busy(struct axi_clkgen *axi_clkgen)
 }
 
 static int axi_clkgen_mmcm_read(struct axi_clkgen *axi_clkgen,
-	unsigned int reg, unsigned int *val)
+				unsigned int reg, unsigned int *val)
 {
 	unsigned int reg_val;
 	int ret;
@@ -284,7 +286,8 @@ static int axi_clkgen_mmcm_read(struct axi_clkgen *axi_clkgen,
 }
 
 static int axi_clkgen_mmcm_write(struct axi_clkgen *axi_clkgen,
-	unsigned int reg, unsigned int val, unsigned int mask)
+				 unsigned int reg, unsigned int val,
+				 unsigned int mask)
 {
 	unsigned int reg_val = 0;
 	int ret;
@@ -305,8 +308,7 @@ static int axi_clkgen_mmcm_write(struct axi_clkgen *axi_clkgen,
 	return 0;
 }
 
-static void axi_clkgen_mmcm_enable(struct axi_clkgen *axi_clkgen,
-	bool enable)
+static void axi_clkgen_mmcm_enable(struct axi_clkgen *axi_clkgen, bool enable)
 {
 	unsigned int val = AXI_CLKGEN_V2_RESET_ENABLE;
 
@@ -322,31 +324,31 @@ static struct axi_clkgen *clk_hw_to_axi_clkgen(struct clk_hw *clk_hw)
 }
 
 static void axi_clkgen_set_div(struct axi_clkgen *axi_clkgen,
-	unsigned int reg1, unsigned int reg2, unsigned int reg3,
-	struct axi_clkgen_div_params *params)
+			       unsigned int reg1, unsigned int reg2,
+			       unsigned int reg3,
+			       struct axi_clkgen_div_params *params)
 {
 	axi_clkgen_mmcm_write(axi_clkgen, reg1,
-		(params->high << 6) | params->low, 0xefff);
+			      (params->high << 6) | params->low, 0xefff);
 	axi_clkgen_mmcm_write(axi_clkgen, reg2,
-		(params->frac << 12) | (params->frac_en << 11) |
-		(params->frac_wf_r << 10) | (params->edge << 7) |
-		(params->nocount << 6), 0x7fff);
+			      (params->frac << 12) | (params->frac_en << 11) |
+			      (params->frac_wf_r << 10) | (params->edge << 7) |
+			      (params->nocount << 6), 0x7fff);
 	if (reg3 != 0) {
 		axi_clkgen_mmcm_write(axi_clkgen, reg3,
-			(params->frac_phase << 11) | (params->frac_wf_f << 10), 0x3c00);
+				      (params->frac_phase << 11) | (params->frac_wf_f << 10),
+				      0x3c00);
 	}
 }
 
-static int axi_clkgen_set_rate(struct clk_hw *clk_hw,
-	unsigned long rate, unsigned long parent_rate)
+static int axi_clkgen_set_rate(struct clk_hw *clk_hw, unsigned long rate,
+			       unsigned long parent_rate)
 {
 	struct axi_clkgen *axi_clkgen = clk_hw_to_axi_clkgen(clk_hw);
 	const struct axi_clkgen_limits *limits = &axi_clkgen->limits;
 	unsigned int d, m, dout;
 	struct axi_clkgen_div_params params;
-	uint32_t power = 0;
-	uint32_t filter;
-	uint32_t lock;
+	u32 power = 0, filter, lock;
 
 	if (parent_rate == 0 || rate == 0)
 		return -EINVAL;
@@ -366,22 +368,22 @@ static int axi_clkgen_set_rate(struct clk_hw *clk_hw,
 
 	axi_clkgen_calc_clk_params(dout >> 3, dout & 0x7, &params);
 	axi_clkgen_set_div(axi_clkgen,  MMCM_REG_CLKOUT0_1, MMCM_REG_CLKOUT0_2,
-		MMCM_REG_CLKOUT5_2, &params);
+			   MMCM_REG_CLKOUT5_2, &params);
 
 	axi_clkgen_calc_clk_params(d, 0, &params);
 	axi_clkgen_mmcm_write(axi_clkgen, MMCM_REG_CLK_DIV,
-		(params.edge << 13) | (params.nocount << 12) |
-		(params.high << 6) | params.low, 0x3fff);
+			      (params.edge << 13) | (params.nocount << 12) |
+			      (params.high << 6) | params.low, 0x3fff);
 
 	axi_clkgen_calc_clk_params(m >> 3, m & 0x7, &params);
 	axi_clkgen_set_div(axi_clkgen,  MMCM_REG_CLK_FB1, MMCM_REG_CLK_FB2,
-		MMCM_REG_CLKOUT6_2, &params);
+			   MMCM_REG_CLKOUT6_2, &params);
 
 	axi_clkgen_mmcm_write(axi_clkgen, MMCM_REG_LOCK1, lock & 0x3ff, 0x3ff);
 	axi_clkgen_mmcm_write(axi_clkgen, MMCM_REG_LOCK2,
-		(((lock >> 16) & 0x1f) << 10) | 0x1, 0x7fff);
+			      (((lock >> 16) & 0x1f) << 10) | 0x1, 0x7fff);
 	axi_clkgen_mmcm_write(axi_clkgen, MMCM_REG_LOCK3,
-		(((lock >> 24) & 0x1f) << 10) | 0x3e9, 0x7fff);
+			      (((lock >> 24) & 0x1f) << 10) | 0x3e9, 0x7fff);
 	axi_clkgen_mmcm_write(axi_clkgen, MMCM_REG_FILTER1, filter >> 16, 0x9900);
 	axi_clkgen_mmcm_write(axi_clkgen, MMCM_REG_FILTER2, filter, 0x9900);
 
@@ -410,7 +412,7 @@ static int axi_clkgen_determine_rate(struct clk_hw *hw,
 }
 
 static unsigned int axi_clkgen_get_div(struct axi_clkgen *axi_clkgen,
-	unsigned int reg1, unsigned int reg2)
+				       unsigned int reg1, unsigned int reg2)
 {
 	unsigned int val1, val2;
 	unsigned int div;
@@ -437,7 +439,7 @@ static unsigned int axi_clkgen_get_div(struct axi_clkgen *axi_clkgen,
 }
 
 static unsigned long axi_clkgen_recalc_rate(struct clk_hw *clk_hw,
-	unsigned long parent_rate)
+					    unsigned long parent_rate)
 {
 	struct axi_clkgen *axi_clkgen = clk_hw_to_axi_clkgen(clk_hw);
 	unsigned int d, m, dout;
@@ -445,9 +447,9 @@ static unsigned long axi_clkgen_recalc_rate(struct clk_hw *clk_hw,
 	unsigned int val;
 
 	dout = axi_clkgen_get_div(axi_clkgen, MMCM_REG_CLKOUT0_1,
-		MMCM_REG_CLKOUT0_2);
+				  MMCM_REG_CLKOUT0_2);
 	m = axi_clkgen_get_div(axi_clkgen, MMCM_REG_CLK_FB1,
-		MMCM_REG_CLK_FB2);
+			       MMCM_REG_CLK_FB2);
 
 	axi_clkgen_mmcm_read(axi_clkgen, MMCM_REG_CLK_DIV, &val);
 	if (val & MMCM_CLK_DIV_NOCOUNT)
@@ -620,7 +622,7 @@ static int axi_clkgen_probe(struct platform_device *pdev)
 
 	clk_name = pdev->dev.of_node->name;
 	of_property_read_string(pdev->dev.of_node, "clock-output-names",
-		&clk_name);
+				&clk_name);
 
 	init.name = clk_name;
 	init.ops = &axi_clkgen_ops;

-- 
2.48.1




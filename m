Return-Path: <linux-fpga+bounces-1142-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 472F5A7DB28
	for <lists+linux-fpga@lfdr.de>; Mon,  7 Apr 2025 12:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE2B27A3707
	for <lists+linux-fpga@lfdr.de>; Mon,  7 Apr 2025 10:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69A123312E;
	Mon,  7 Apr 2025 10:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CHhW61xD"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E96E218AD4;
	Mon,  7 Apr 2025 10:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744021700; cv=none; b=rctfxT/VoxTOCzW3AGYZUtPzqjPUCFda5oHoKR7Nfp+2PJpC+At72pgFwIXrRd36jZGDzr69K3SmSW/19sjUXkBU2/YFX+mSL1KignFT91vP7vpvoRiKkAE3l9hMZbdUrsVyOKy/4KGTJlXkhCd9QxA/a4hs7Zm/44StenQ8bp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744021700; c=relaxed/simple;
	bh=Dh7d4NNcRLM6B44zz96/SyD/o2WcN9uht2JGlC4604Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QQ5iwWTYBrjvPKC5TwJsTzYR6cGfULIlYroMKbz6xdqefl6rwVwruWw7xjiRXuEzswO9t/l+NuPTCO8LtcBnmN9HVh8PG0VdNcGB/1zP5ZW4cfu0cFc1VOriy8sjnZx7cDCKeyX3CBVPlnXDlZvbpH0pArGQvymN4J8zBDJt1Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CHhW61xD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 58889C4CEF0;
	Mon,  7 Apr 2025 10:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744021700;
	bh=Dh7d4NNcRLM6B44zz96/SyD/o2WcN9uht2JGlC4604Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=CHhW61xDle86wUncX7qJI0DP/R7WiJ8kek9bzJ7u5MP3BYucSGKA7Ec38QQiYzr+G
	 FUnhmfiEF/a300TtATwWEe7C+toG1r8DFbAJdBSziSq5W7qzcw8c+uLmzA6PouAyR5
	 kASbeiO+R7DrNJr/kXFTWlx3k5+Mrkrc6kBBLeHF02IkvTNz9PnopzBqjnqO61Ndcq
	 A/5OwVdfoWSd5R1AYOGFeG02tW499lv/uZvXe27yaOmWIDcW7l567I38Pu5XJMaKrZ
	 +Xc/ADHvfbK3KIi87NKaSKs4KyhXJUvPHiCYUGLPu/rwdaTgHngYiKNdyBhyYUSz/F
	 SIt3Hxx+nwf5Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FBE8C369A3;
	Mon,  7 Apr 2025 10:28:19 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Mon, 07 Apr 2025 11:28:20 +0100
Subject: [PATCH v3 6/6] clk: clk-axi-clkgen: fix coding style issues
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250407-dev-axi-clkgen-limits-v3-6-33c7f27c9d69@analog.com>
References: <20250407-dev-axi-clkgen-limits-v3-0-33c7f27c9d69@analog.com>
In-Reply-To: <20250407-dev-axi-clkgen-limits-v3-0-33c7f27c9d69@analog.com>
To: linux-clk@vger.kernel.org, linux-fpga@vger.kernel.org
Cc: Stephen Boyd <sboyd@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>, 
 Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744021699; l=8461;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=qQwPDRPAfekBU0wa3q3YKSwWmxMm9L4Csvfk9h/Stis=;
 b=fikJii0ra58zqW1+lEDe4UuTZe7mJE9MKESzGoQ7Ge5HQ6V10Ly+a7/XdwrcuA4UC9hqZsca7
 GOTKlxyV7LuBkoZpC5PEHTlvW74JEGDgiUoDZzfEoP84+zBG4uRnVB3
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
 drivers/clk/clk-axi-clkgen.c | 74 +++++++++++++++++++++++---------------------
 1 file changed, 38 insertions(+), 36 deletions(-)

diff --git a/drivers/clk/clk-axi-clkgen.c b/drivers/clk/clk-axi-clkgen.c
index 82a99c3b9063cd2dd8a9dc7fdec81a38feee12b9..0ea174a185bc34be62579f07072fd75a595aab5b 100644
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
@@ -225,7 +227,7 @@ static void axi_clkgen_calc_clk_params(unsigned int divider,
 		if (params->edge == 0 || frac_divider == 1)
 			params->low--;
 		if (((params->edge == 0) ^ (frac_divider == 1)) ||
-			(divider == 2 && frac_divider == 1))
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
2.49.0




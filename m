Return-Path: <linux-fpga+bounces-1141-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C05EBA7DB33
	for <lists+linux-fpga@lfdr.de>; Mon,  7 Apr 2025 12:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C6463AE3AC
	for <lists+linux-fpga@lfdr.de>; Mon,  7 Apr 2025 10:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17AA32309AD;
	Mon,  7 Apr 2025 10:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rlz35hwN"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C7C2309A7;
	Mon,  7 Apr 2025 10:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744021700; cv=none; b=aiUZQoeOSumIudqr7JI50GSEqfnjxS7asiWsLf9b+RtpcB0DAXoTgpk0XnLuzNzI/y8kN93CLUN+GPAmrRLSE4sI39Upe6t00F1rPMRF/tmHlEAy/8mWFaDKZk52As/yGa3CwSAvWrv1iHiIiSj+XHoPiSyYVpVjGcK+Qapj65I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744021700; c=relaxed/simple;
	bh=GkXRp/bBkXhpMmVJsCM71rhkrdoAeH33xil+Yj6A7NQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hfWmI5InhY67pA+gyaLv9E16EheWR/o25/1dfu2/0X7qSpPTbm+i7BAFpL0R0SUwKwrcSZVJIT/AUkNY6X5167Sxht7tPqxuj//wh2MNlnHAp7E2CbHz9NNHIksaYe2f2W2sxM1f4ji9Lc1tsuHWNrVXZzL6XJ/atFCCAKLOcUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rlz35hwN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4A753C4CEF3;
	Mon,  7 Apr 2025 10:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744021699;
	bh=GkXRp/bBkXhpMmVJsCM71rhkrdoAeH33xil+Yj6A7NQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=rlz35hwNdRbHfZnnGzzffU1fgosn5j9NvXxBnaCRxBtqwtYzEKD19CxVIKpS5DIQJ
	 5dutTZCS74lp8J2qfUU7z4nVlq4k1W1BhMluvIcRnXO4YveYxvqJALYzsl5QDWlfnd
	 xsTS2wtVQuqLmJ9WD10bPfd023AJw+CkwO+RluJqezz591jG7/F47TIWw4OUVwJbTA
	 Gvhf2LR/xtMdaiBqinQCRKQn+bXCyvN1PpMv8bKkroudbyr85aZya4bEsxqgEaMm0d
	 WnSvahJ2qSq5/HrjK2AwFJHyBvEhxVjlB/JcMrvsLQzVLRLLNeY1GcZkhW9oz6fR7v
	 1pFEndAA5kosA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 401CCC3601A;
	Mon,  7 Apr 2025 10:28:19 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Mon, 07 Apr 2025 11:28:19 +0100
Subject: [PATCH v3 5/6] clk: clk-axi-clkgen move to min/max()
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250407-dev-axi-clkgen-limits-v3-5-33c7f27c9d69@analog.com>
References: <20250407-dev-axi-clkgen-limits-v3-0-33c7f27c9d69@analog.com>
In-Reply-To: <20250407-dev-axi-clkgen-limits-v3-0-33c7f27c9d69@analog.com>
To: linux-clk@vger.kernel.org, linux-fpga@vger.kernel.org
Cc: Stephen Boyd <sboyd@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>, 
 Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744021699; l=1495;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=BmiMR6v/RhazvTHFDFm7ANLKTnoa1lQFUceXNiwKsBk=;
 b=cpheWQAHeWGKIYfuisZrI3h7uf7kYkYeqcOn4LemPIgH976jTMIL2uHUkGLa1sLNU+K5ZoSAS
 hvx/1uA+rmnAZcCVJTF6HqrP2BZ0TsW16GbpkF0re5UTv+iN//VCysY
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




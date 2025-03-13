Return-Path: <linux-fpga+bounces-1106-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B64A5F95C
	for <lists+linux-fpga@lfdr.de>; Thu, 13 Mar 2025 16:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0947188AAD7
	for <lists+linux-fpga@lfdr.de>; Thu, 13 Mar 2025 15:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72DF9268C43;
	Thu, 13 Mar 2025 15:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FQShQDRg"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AC8267F77;
	Thu, 13 Mar 2025 15:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741878881; cv=none; b=hgu23QjE2i3qbvq7C1QlqFXHx7+xzW8NBifma6K4X3ZxP2U6EDeXBCb+ZSYeaaFofPSxy0zQjrfalfRlrRvscSZq+i7GQMErBgWMIC9X/u5hLLbL99z0QxnQz4avgcLUboYFiYTBVnBqy42DZGVjXVgoqrwtuInFynxSDX7GX98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741878881; c=relaxed/simple;
	bh=bMSRWL9vhgEV0SWpFh+qnRL63hnQOGX+QjCyihjf6vE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JaCcwmPKFctDQUifr+aI5Hfy11nl18TD4jvh9oS7jBbXhpI9DztAfuHMql+PRSXihTr/22aCg5JJAaMo7GJvFpKxESLkaAkBLZ7/ZDjpbdW4SKzbgi2GplY+V69oRLajDdJP0bi3g20Ui/joLn0nUj2bSoVDEQ2yr2tgVkMVlMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FQShQDRg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1408FC4CEEA;
	Thu, 13 Mar 2025 15:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741878881;
	bh=bMSRWL9vhgEV0SWpFh+qnRL63hnQOGX+QjCyihjf6vE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=FQShQDRgrEik14pYYVD9tytbLaNX5jQRlmCEbInFrqqH1Q4DqF6wJLjxiNVwKYPTV
	 CiKAB5rdgSidfKHbYVi1FuLhYRS00+fyMmz9Q7vCH7y8inZWzDWXPSs97PYFwZJYzO
	 9ukCx1l1CLygBSgf7vHxeTEOo2LDFLlu8St/5d82f9L2zix5fpvuABU2slgjDEu3kq
	 AVuFZI0r0OSJM/eKV30VotkCCpn1WphBh6EJ2uuT1KkLqbQuFa8IrArvppeZnh26IY
	 traVF4ILlbnNDpIYuNUSdbPYPnN7H7EUC01okpiLTqlKhfJgiP1jMxqJoPJFZdS5Tw
	 fgw4nIJiL0F3Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0270AC35FF3;
	Thu, 13 Mar 2025 15:14:41 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Thu, 13 Mar 2025 15:14:43 +0000
Subject: [PATCH v2 1/6] clk: clk-axi-clkgen: fix fpfd_max frequency for
 zynq
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250313-dev-axi-clkgen-limits-v2-1-173ae2ad6311@analog.com>
References: <20250313-dev-axi-clkgen-limits-v2-0-173ae2ad6311@analog.com>
In-Reply-To: <20250313-dev-axi-clkgen-limits-v2-0-173ae2ad6311@analog.com>
To: linux-clk@vger.kernel.org, linux-fpga@vger.kernel.org
Cc: Stephen Boyd <sboyd@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>, 
 Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741878886; l=999;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=3XWz9JBStnY9lwXNwvrymtRHf0DsK7mnM7TrKIE5Q88=;
 b=6wz805AcrdVA9xC5iFAPQxb+UezKOZv8nDv/wSBrBcPCE23Y8Wf8saY25c5N594eGd/l3W5dr
 Y+FsG3ZgD8YA8eDXW4yVIkmB6vvpmm3HpSoUj68xZZm8J/OwEe5Nm78
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




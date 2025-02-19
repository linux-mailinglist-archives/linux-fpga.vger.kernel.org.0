Return-Path: <linux-fpga+bounces-1059-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFFADA3C5FB
	for <lists+linux-fpga@lfdr.de>; Wed, 19 Feb 2025 18:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F0C61712C8
	for <lists+linux-fpga@lfdr.de>; Wed, 19 Feb 2025 17:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7040D1FDA93;
	Wed, 19 Feb 2025 17:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ps0flReu"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B9E214209;
	Wed, 19 Feb 2025 17:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739985618; cv=none; b=nlXigiDIEdWU2/vkRZNH2oO+tHL1vVYp+8EDF7VYn0y1/ZFe2W9347rYyo8rfZOfb+GYQyV/CW0Y9VzAnYOTN5XRea2+0BDZzm7z/XkzUv6L4jRPtG8rJkJfiYmIXTxyh04Kwr6F144dpyaQ3l2wiJuceV2kv8iKgXUf4DeAN+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739985618; c=relaxed/simple;
	bh=gyCOn420nu33ZZ8ZpTt+CB+QBZMb4ojXZKnLb7lc8r8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eWYbpNDWJDV1WVC7RqVAFBZXmhKY1xdOPr+f9AfqAZGZwOW+FjD7psSJ87XRehydbxWuscbAOA6QNyvccBmfMrD7yOpsUxxPgSM3kzwrPhlKavQAgwFcCD7Jk0okFNtKtBBVwjV3tBE7b0BRerYM84p78PwcluAtTcXDCcdzSzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ps0flReu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CDA25C4CEE7;
	Wed, 19 Feb 2025 17:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739985617;
	bh=gyCOn420nu33ZZ8ZpTt+CB+QBZMb4ojXZKnLb7lc8r8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ps0flReuQt+HJF57c5kpt0ZAbDnkhlQ12FIZiD15d2c63v49uPHzIWiCjeB39lEfi
	 SBdVjliO73Wh05K0uGYrQEG+RqxAvty+oqlUsmzi0EORAQBjVY3IuByYmrtHGg3mNS
	 NC/vOAu8bi8yMKk/zh7ZCSRm3c89ZdfHgLKO2WagD/6sSf3g56nM1ivKWh3UC6O4Qr
	 VHYEeV93ZQBjq9OPa8buMf3MO1r83wTKng3+RBGsCSjHBf0Zl9K8jqhKX8QqvEGvW4
	 +Im2YY3qpffmYf5kFjoMQAb0HLFeW1RHvf8jEjadCtPncreN0KF5bGrZkfOs9h+c4i
	 rrGGcmGkrUe3A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC0AC021B2;
	Wed, 19 Feb 2025 17:20:17 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Wed, 19 Feb 2025 17:20:20 +0000
Subject: [PATCH 2/6] clk: clk-axi-clkgen: make sure to include
 mod_devicetable.h
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250219-dev-axi-clkgen-limits-v1-2-26f7ef14cd9c@analog.com>
References: <20250219-dev-axi-clkgen-limits-v1-0-26f7ef14cd9c@analog.com>
In-Reply-To: <20250219-dev-axi-clkgen-limits-v1-0-26f7ef14cd9c@analog.com>
To: linux-clk@vger.kernel.org, linux-fpga@vger.kernel.org
Cc: Stephen Boyd <sboyd@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>, 
 Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739985620; l=659;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=BGGCp0B/QWIWTXslxwf7dXWZP54vUsku9BYioWyTJhQ=;
 b=VE6/nEVCYXRxFQEzYPWaJ3WVokWfafGzx7yQ8E2/PBZ0+mhT5vF+x3M+B7+7VgB0s27yB9EvS
 r3y7t+A+EKsA36YmAjkovnsFSYPmHwNBhHvEMW24UuW0kLf10LJtg5I
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

The mod_devicetable header is the one to be used for struct
of_device_id.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/clk/clk-axi-clkgen.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/clk-axi-clkgen.c b/drivers/clk/clk-axi-clkgen.c
index 00bf799964c61a3efc042b0f3a9ec3bc8625c9da..2a95f9b220234a1245024a821c50e1eb9c104ac9 100644
--- a/drivers/clk/clk-axi-clkgen.c
+++ b/drivers/clk/clk-axi-clkgen.c
@@ -13,6 +13,7 @@
 #include <linux/io.h>
 #include <linux/of.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/err.h>
 
 #define AXI_CLKGEN_V2_REG_RESET		0x40

-- 
2.48.1




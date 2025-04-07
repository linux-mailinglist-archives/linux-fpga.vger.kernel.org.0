Return-Path: <linux-fpga+bounces-1140-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4EFBA7DB2D
	for <lists+linux-fpga@lfdr.de>; Mon,  7 Apr 2025 12:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E21733B2414
	for <lists+linux-fpga@lfdr.de>; Mon,  7 Apr 2025 10:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4E0231A51;
	Mon,  7 Apr 2025 10:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h+jiwIkv"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86489230BDA;
	Mon,  7 Apr 2025 10:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744021699; cv=none; b=HPC8iz0dPfg5VyV8S9qC0aNiNo72AidDap5xLgC7SofX7/BefIk4djCrqVtckpbqEWl3GaDEO8qFNFnXx5sTZHLKQchBgJZWojiC+Rf3OkxMlCnjmNWWprZEe+VcRmWsCCALVmNLT9BZ8VpnJJ6UjvS/wPp/y11FxUjl6ewQ3bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744021699; c=relaxed/simple;
	bh=Lc+0ipnOsOyMrbnE9ygCUwscmE7Y6WD4G1olrBmxHzk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SMDE4jUR/jG912nTH5DILO/omjaof34X/FklQrLQJiZcl3RjkR68Sn44ovtkiUuDsHdDSPjBlkzn5SXWBuzsZmJYXWPQSxaQjqKpX4z1/vMsiBhkF84AXuS4F7UPXa+UkiMUuQItuiipybzA05MdprITtbNn8JtVAXQl0Eo6Lw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h+jiwIkv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 10924C4AF09;
	Mon,  7 Apr 2025 10:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744021699;
	bh=Lc+0ipnOsOyMrbnE9ygCUwscmE7Y6WD4G1olrBmxHzk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=h+jiwIkvMy22R+yxn5R8d5eA9K3QftnDa0wia8f5WKJcVK1DZYRHH16bLG2zw4ZVQ
	 +bE/qPJV2W8EyEoj86VbOZAMZc01jMNO8EJJU779x+tLIDiveDct2wvN+T6+lsw2fU
	 Mldpa1UlShBTWhiZlIHHWjrgWr5ahDqg07VpPhtv4VGuDuMUrzw08EXP5e5YWvUGmj
	 f2UPnhalbcB3vwpnezJtGmyzgHPFRcZou20BS32CwwWd+e/TgF+elBDYvp8DEmonXi
	 UPOqKKHNQRnK3NXTZfy1iBgj4RIlo/povGgJzN1/ayVNfef9gpoF8Ld32PEYZ/mzbt
	 8Km9YMtvhrd9w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04ADCC369A3;
	Mon,  7 Apr 2025 10:28:19 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Mon, 07 Apr 2025 11:28:16 +0100
Subject: [PATCH v3 2/6] clk: clk-axi-clkgen: make sure to include
 mod_devicetable.h
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250407-dev-axi-clkgen-limits-v3-2-33c7f27c9d69@analog.com>
References: <20250407-dev-axi-clkgen-limits-v3-0-33c7f27c9d69@analog.com>
In-Reply-To: <20250407-dev-axi-clkgen-limits-v3-0-33c7f27c9d69@analog.com>
To: linux-clk@vger.kernel.org, linux-fpga@vger.kernel.org
Cc: Stephen Boyd <sboyd@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>, 
 Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744021698; l=659;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=/HIQW7i7xy9rSNcN8n33vnPmXH+zPymhP7sV+jmjYCI=;
 b=d/GOWIfcd02nY2qEzWvwMgofKIFZfoMuwQf6jPrJf1+BoOwPyC7ZGTz3WYVav+oGTdh/V6Ms8
 yqt3YXpLFdcA1/Kckb5i9HUhkqfSCKv8NgXIjs3CCY71jbASCfrOaHL
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
2.49.0




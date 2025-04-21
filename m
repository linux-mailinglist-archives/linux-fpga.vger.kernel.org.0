Return-Path: <linux-fpga+bounces-1165-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34BC2A95327
	for <lists+linux-fpga@lfdr.de>; Mon, 21 Apr 2025 16:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3675B172608
	for <lists+linux-fpga@lfdr.de>; Mon, 21 Apr 2025 14:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8C51C8604;
	Mon, 21 Apr 2025 14:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CkWgMI3D"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312991C6FE4;
	Mon, 21 Apr 2025 14:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745247488; cv=none; b=Lsec9tF9S+uROozxDh7YBgr8RBwxL7XDUDQWqqtWin3mQcNmzy/aEnY2meFHBnge19TZmKjnbLHzwumv5vXuvfj4FruVUj+cb3CkEeoLnvzdZMR6r4xZpw1UVlU18V+RiKiX4qKV6bIqymsgDF6X+X2o5KH7iYgpjx9CYbhSoMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745247488; c=relaxed/simple;
	bh=Lc+0ipnOsOyMrbnE9ygCUwscmE7Y6WD4G1olrBmxHzk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mZ/Y1NSNeh10JG3cOGV/v0AJwD9VkB0aLaz1+++gvvx0Bdl/aOFsXX70+5ba6oHIehzYY5WYUrQ1qYgMVIwxwEkSta657MqKZ/PvQ+fOHeZJ56XejCqcqrqUtDKqRty1+33R5tFXfWSox8RmdAklK7Nocj2Gk2YR4/Uw/c8/mTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CkWgMI3D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A9F99C4CEF4;
	Mon, 21 Apr 2025 14:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745247487;
	bh=Lc+0ipnOsOyMrbnE9ygCUwscmE7Y6WD4G1olrBmxHzk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=CkWgMI3Dm3gY4eQyB1n7uwNknfm2Y5JE9l5XP9/DBJLUvBVhSCn+jWd2g9KSDr1i+
	 vxv7TnmQdIKSIipGITtZWaoRFTBD60xIA5l4n/Yizdbdjrv1bwtz/jeh3l86RAjMtp
	 /A19Vw2g1KYanN0lEqFlSQsWlS0rWbL8fMDQm1eHupwgDUTndu+t5HGK1dcak8S2+c
	 ZWv5t8p1GpDiDmtwfGZ4ldxWuBlVscEnakVFXznQyeV4eXwAO66WxsOlf5LBe/6T7r
	 4d7lg3ENBD8n4ijPoUerfBX1GJ44AsnETJ2Nn4p9WE4KGYPSbLCxNfo9rnhFbPYJuy
	 Yk39B3JDvM1cA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D3DC369D6;
	Mon, 21 Apr 2025 14:58:07 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Mon, 21 Apr 2025 15:58:03 +0100
Subject: [PATCH RESEND v3 2/6] clk: clk-axi-clkgen: make sure to include
 mod_devicetable.h
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250421-dev-axi-clkgen-limits-v3-2-4203b4fed2c9@analog.com>
References: <20250421-dev-axi-clkgen-limits-v3-0-4203b4fed2c9@analog.com>
In-Reply-To: <20250421-dev-axi-clkgen-limits-v3-0-4203b4fed2c9@analog.com>
To: linux-clk@vger.kernel.org, linux-fpga@vger.kernel.org
Cc: Stephen Boyd <sboyd@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>, 
 Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745247490; l=659;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=/HIQW7i7xy9rSNcN8n33vnPmXH+zPymhP7sV+jmjYCI=;
 b=cTExq5M/0nS/NGJYFhOB/Z8XLyAmxPkws+GExA/baS5fQfiLUf5we3B8e2w6v5Q9/3GJXyFwC
 xVwVeq+OdiIDhXeNfrg2REzX9W+XJBlWlaqR9WrJse5lLgboyVULL5O
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




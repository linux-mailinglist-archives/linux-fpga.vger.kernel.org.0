Return-Path: <linux-fpga+bounces-1107-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3BDCA5F960
	for <lists+linux-fpga@lfdr.de>; Thu, 13 Mar 2025 16:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B122F19C1D2E
	for <lists+linux-fpga@lfdr.de>; Thu, 13 Mar 2025 15:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D75C268C49;
	Thu, 13 Mar 2025 15:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nb1rEyNM"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C77726869C;
	Thu, 13 Mar 2025 15:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741878881; cv=none; b=MilXolD0BDE/KQ+5ZepbsbWIt1ntbu7DnrPoXyqajrF2+yK2fixjEBkVbS4+QApyEFcn9qp+nWJrYaPNfEYP0zkp4o9/zty9TX0r659WW6hI1YvKLdnlyq7e4VAP8Ftm2KO+Jh6GKIIePuCYckxfIs1EAodFrcMWn0qHhHYu5V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741878881; c=relaxed/simple;
	bh=gyCOn420nu33ZZ8ZpTt+CB+QBZMb4ojXZKnLb7lc8r8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EvHZJMTBvolYXxPJibHGHHxFdXvW0u5+n7gRJfo030cGXbb+KIL4/Dwr/RgJknuFrGWtiKhnrGBY3wTAQ7aq5ZCwkgin3u4032J1rtumyVCoIc7gWOMl3HyUxb7CQ1u4zNLH5igRPpNuCWpevFBvlWCTzhoBGNc42obard0aB2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nb1rEyNM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1FF45C4CEEB;
	Thu, 13 Mar 2025 15:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741878881;
	bh=gyCOn420nu33ZZ8ZpTt+CB+QBZMb4ojXZKnLb7lc8r8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=nb1rEyNMHIvNCYp000gFSp7+rj4jr6PgKv68qBPjrJtXlnfqgu4OljlKn8hOd7loy
	 Ie933n3ALc6RbmjDU76oXVWUHAh2kiRFSrcUfqEzu0Rl/AnkBC/qbvUI0KuJidWpl2
	 Sl+n/I9lW/0K3tVzksPvceZJWc4+ucK35qau4phCX1YLu3IRpZPiAFLfl/Opq66L0z
	 4vVCGUxtg2ef1Ub7TlWRNi+02RYjh17rzpYh+EwUvBxLsCC8uIJu0kNQ/rLyzOwqn9
	 CXkGzmqoOvZGMwtcpXYOlnxgKvQLgJgKoLORLqpAceMAwSjok5A/KzO6mXCj0ytdKr
	 pjfRes77fFe/Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F7BFC35FF4;
	Thu, 13 Mar 2025 15:14:41 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Thu, 13 Mar 2025 15:14:44 +0000
Subject: [PATCH v2 2/6] clk: clk-axi-clkgen: make sure to include
 mod_devicetable.h
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250313-dev-axi-clkgen-limits-v2-2-173ae2ad6311@analog.com>
References: <20250313-dev-axi-clkgen-limits-v2-0-173ae2ad6311@analog.com>
In-Reply-To: <20250313-dev-axi-clkgen-limits-v2-0-173ae2ad6311@analog.com>
To: linux-clk@vger.kernel.org, linux-fpga@vger.kernel.org
Cc: Stephen Boyd <sboyd@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>, 
 Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741878886; l=659;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=BGGCp0B/QWIWTXslxwf7dXWZP54vUsku9BYioWyTJhQ=;
 b=0pDqjr74YVLZgY0k3lL2nGqwvPJ+rMhG/DTcr09WvNX+swc91tKW+DRs5gSn2qLNBooMH2yA9
 ck3EeXD5nZ0DOeY7QQhVQCgtUiNOOxJWR9MwiBIkCS8BXaYkHdMDW/8
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




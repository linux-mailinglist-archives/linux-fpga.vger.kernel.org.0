Return-Path: <linux-fpga+bounces-1056-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FCBEA3C5F9
	for <lists+linux-fpga@lfdr.de>; Wed, 19 Feb 2025 18:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3244188973E
	for <lists+linux-fpga@lfdr.de>; Wed, 19 Feb 2025 17:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F741FCFD3;
	Wed, 19 Feb 2025 17:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pa8cGCiH"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1638286284;
	Wed, 19 Feb 2025 17:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739985617; cv=none; b=BIzCetLulOlDoDN+2uw1/Vgba+NmgnCwgRCvrfeecFtBzG6ac00ZR4uvq9GKNheEBL6nLrQ3dXPvOUUKAe2ILBZCLQFPc9moERUscCBBj4puONTCAx/DBM51stLpHKXbz+VrB/ES+/4PfimUWdhvEIetjBk/BH/txN/RQmjXTp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739985617; c=relaxed/simple;
	bh=lhlb0oWuR17RNf0Vp0EHzjC/aagOic5Ps7J0XIlnC4o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DV+h0mB33XteaITzhCnKmT6MSNsRUKt6kLXhxccoZeBY20rUpT9zWkr4TBJUSf9zrsCwPTaeVL+OvYV0/pqPMRcalwPq4TuZPBQxxufsGe2LNojC2CD6eGoz/SDZ+/eQIMLnTdtQ4PsyhLseC17DDhCFxtHuCSb3lGMcTJLRpGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pa8cGCiH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AB4ACC4CED1;
	Wed, 19 Feb 2025 17:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739985617;
	bh=lhlb0oWuR17RNf0Vp0EHzjC/aagOic5Ps7J0XIlnC4o=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=Pa8cGCiHaTjL+YhKQKoIToWtNMrLwGZhWDWegbQiP3xTvPhOh1NQiw6IUvYs66+MM
	 Mj3NRp8YSgMRCW24dpbFa9raqPOkCUY6W9TOgWjaFPs0cI0gegHpeh6+ws3cqEo8wc
	 8iQeJB6LB6X3kekBk1n0Cus9CUMcH4L7KVBrEQyhlDqW3j1tUJj8d22Rc3JnypjkaQ
	 5vz6BtkQVXFCV5JgJkuvOUYqa3xq9mTbJmphxdEN03zvmJpZK7CfydPJRiCamC3K3z
	 Mz6IGl396/rd0ZDhilFi9qT1YdE2Fpeadnviyu3r7BFn6SJCpCoV7Q+tcjQi1AshQx
	 AOrBW+CU5Drjg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3418C021AA;
	Wed, 19 Feb 2025 17:20:17 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Subject: [PATCH 0/6] clk: clk-axi-clkgen: improvements and some fixes
Date: Wed, 19 Feb 2025 17:20:18 +0000
Message-Id: <20250219-dev-axi-clkgen-limits-v1-0-26f7ef14cd9c@analog.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIANIStmcC/x3MQQqAIBBA0avErBtQw4iuEi1KxxoyC40IpLsnL
 d/i/wyJIlOCvsoQ6ebERyiQdQVmncJCyLYYlFBaKNmhpRunh9H4baGAnne+EraNm4XRZJpuhtK
 ekRw//3cY3/cDW3y8mWcAAAA=
X-Change-ID: 20250218-dev-axi-clkgen-limits-63fb0c5ec38b
To: linux-clk@vger.kernel.org, linux-fpga@vger.kernel.org
Cc: Stephen Boyd <sboyd@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>, 
 Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739985620; l=872;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=lhlb0oWuR17RNf0Vp0EHzjC/aagOic5Ps7J0XIlnC4o=;
 b=gAGHHx90yruTZFfFG9Pro8Lq67D9hlStPBzCz/mR0e8R52paS8QpFwcLUfWcEuFb8xNCG79jR
 0WROiYBw1u/CS5Fyw5cwyNlHkh8oUBl0rVA8fs6P69TLTllJtp6+Gj9
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

This series starts with a small fix and then a bunch of small
improvements. The main change though is to allow detecting of
struct axi_clkgen_limits during probe().

---
Nuno Sá (6):
      clk: clk-axi-clkgen: fix fpfd_max frequency for zynq
      clk: clk-axi-clkgen: make sure to include mod_devicetable.h
      include: fpga: adi-axi-common: add new helper macros
      clk: clk-axi-clkgen: detect axi_clkgen_limits at runtime
      clk: clk-axi-clkgen move to min/max()
      clk: clk-axi-clkgen: fix coding style issues

 drivers/clk/clk-axi-clkgen.c        | 149 +++++++++++++++++++++++++-----------
 include/linux/fpga/adi-axi-common.h |  35 +++++++++
 2 files changed, 141 insertions(+), 43 deletions(-)
---
base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
change-id: 20250218-dev-axi-clkgen-limits-63fb0c5ec38b
--

Thanks!
- Nuno Sá




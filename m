Return-Path: <linux-fpga+bounces-1136-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E64EA7DB2C
	for <lists+linux-fpga@lfdr.de>; Mon,  7 Apr 2025 12:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 930373ACF31
	for <lists+linux-fpga@lfdr.de>; Mon,  7 Apr 2025 10:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A343674BE1;
	Mon,  7 Apr 2025 10:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M5VR2Vkw"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B167A920;
	Mon,  7 Apr 2025 10:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744021699; cv=none; b=OKK1SQ9Q5c1JVVZbP/5bVeru3pvpL04yvna41IGqrgOp+bOz3utzedKFG3pEsRsW4kcW/zb30e1VGZF8RavcwUCkE7pedybZ7SZypNhzNHlF15h8f91YuqyidnQ926PaHY7j7DfdsJuu9+klJC00WnpjNFRVKDmW5fS+kMS310w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744021699; c=relaxed/simple;
	bh=DtKEQ7AKPSModph2Km+mV9LVY9fsLpdZjnc0srYg814=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Ug4BD39QR9s56ryXHtpkU6BS/sV/so/mHYPrmUqaW3lgFDqCgB8k3Lhpxp5v697ums+cN3T7Y8CRMbcmIQ/HuhGU8N+ttNPku6ewaOeD/aQ+P5KYaYs4enDfkC6joBu/AIBA1oPS23w25DXwWS60auVwiSUso4rEPTmpiCMBgZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M5VR2Vkw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DE658C4CEE9;
	Mon,  7 Apr 2025 10:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744021699;
	bh=DtKEQ7AKPSModph2Km+mV9LVY9fsLpdZjnc0srYg814=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=M5VR2VkwbFI8EgWcqA/WGTYaXTJ/vvAhVYOgNYR068uHGHwhjgPz9EX1/Ma9lEnFc
	 sTqGyz6cyFqKhV/iBrB/9nt2NFyJZ8HPTRZjGKbP0kAWF24la1ik71f4nbuEtL9yaS
	 +9lm6+mHjED+V+lMa0trFnPQ/xpj8sO3cOKO92vRB6mqoUlj1lvjbZW+7rkQqBgQO9
	 4zmeSbB5jcvQlOnzgEsXhf6b+TBc5LbCh7LJ7cOwATI6LzZCBiN5DHCaSt+QIagXIL
	 //dUnC/6FUbzbQrlXy4zOyPW3HyqdE7QGqX552KlErAGZs+sMClaGIgTFVWAZ6ANJu
	 P5AZfmmpaw0FQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D52D8C3601A;
	Mon,  7 Apr 2025 10:28:18 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Subject: [PATCH v3 0/6] clk: clk-axi-clkgen: improvements and some fixes
Date: Mon, 07 Apr 2025 11:28:14 +0100
Message-Id: <20250407-dev-axi-clkgen-limits-v3-0-33c7f27c9d69@analog.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAL+o82cC/3XNTQ6DIBCG4asY1qURqH9d9R5NFwiDTqrQgCE2x
 rsXTZqmC5fvl8wzCwngEQK5ZgvxEDGgsynEKSOql7YDijo14Tkvcs5qqiFSOSNVw7MDSwcccQq
 0FKbNVQFK1C1Jty8PBufdvT9S9xgm59/7m8i29Ss2B2JkNKe8NBUYdlG6UTdp5eC6s3Ij2cjIf
 4xg4ojhiWGVkMClLgVjf8y6rh9ox3O7AgEAAA==
X-Change-ID: 20250218-dev-axi-clkgen-limits-63fb0c5ec38b
To: linux-clk@vger.kernel.org, linux-fpga@vger.kernel.org
Cc: Stephen Boyd <sboyd@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>, 
 Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744021698; l=1425;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=DtKEQ7AKPSModph2Km+mV9LVY9fsLpdZjnc0srYg814=;
 b=jo9XcmxOLCAjs6V8XW5LEWb1woSRPM3xAM89MZhmfgX4wrOc4Q9+ACAWoeecVktuFWmiJKA/T
 h4ifHOOCv+sB0xvqQQI7uIdrhG3VqV+4ZoY9sKy2jUCrXmb+YTI2vTj
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
Changes in v3:
- Patch 6:
    * Revert change and parenthesis back on 'if (((params->edge == 0) ^
      (frac_divider == 1))'. While checkpatch complains, it's more
      readable like this and in some configs we might even get -Wparentheses.
- Link to v2: https://lore.kernel.org/r/20250313-dev-axi-clkgen-limits-v2-0-173ae2ad6311@analog.com

Changes in v2:
- Patch 3
   * Rename adi_axi_fgpa_technology -> adi_axi_fpga_technology.

- Link to v1: https://lore.kernel.org/r/20250219-dev-axi-clkgen-limits-v1-0-26f7ef14cd9c@analog.com

---
Nuno Sá (6):
      clk: clk-axi-clkgen: fix fpfd_max frequency for zynq
      clk: clk-axi-clkgen: make sure to include mod_devicetable.h
      include: fpga: adi-axi-common: add new helper macros
      clk: clk-axi-clkgen: detect axi_clkgen_limits at runtime
      clk: clk-axi-clkgen move to min/max()
      clk: clk-axi-clkgen: fix coding style issues

 drivers/clk/clk-axi-clkgen.c        | 147 +++++++++++++++++++++++++-----------
 include/linux/fpga/adi-axi-common.h |  35 +++++++++
 2 files changed, 140 insertions(+), 42 deletions(-)
---
base-commit: 82f69876ef45ad66c0b114b786c7c6ac0f6a4580
change-id: 20250218-dev-axi-clkgen-limits-63fb0c5ec38b
--

Thanks!
- Nuno Sá




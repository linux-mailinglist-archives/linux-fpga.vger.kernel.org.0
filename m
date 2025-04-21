Return-Path: <linux-fpga+bounces-1164-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9116DA9532A
	for <lists+linux-fpga@lfdr.de>; Mon, 21 Apr 2025 16:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 207623AA750
	for <lists+linux-fpga@lfdr.de>; Mon, 21 Apr 2025 14:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0191C84B9;
	Mon, 21 Apr 2025 14:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HJxnKR26"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B961C5F2C;
	Mon, 21 Apr 2025 14:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745247488; cv=none; b=gRYbb6C0LY3agdxgiZrnH4teCokHbsHgpCaP9Z7KWw5rtpmvL1PruRmBcteh7jqg4QtaXnKwNUpo66VzFMqYMqFmjVRchMEyFOb1EdbXXWXkulpsAdNc1TpfDfE2WhC/Kkj5nIC9juKjbHwvO8lr7iJ5AMr6cn55EzDfDmNmaoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745247488; c=relaxed/simple;
	bh=yjlz1+aLlRQYQhpF4+uSLLx9jArQyUOmwqytKlg1KfE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Kc7e3ismCoi8++1HYavH4Q6t9zAkGIbcKFGlf7s8Q7NEREjP+svByzzDIiX2CzMf6kmAHrS+ZOOPc6eGtj6Bj3pmslX9n80pTgRwL/wCAv8fyYgD8IKSm6eYq+ZosXX1w49vhyYCtKuJBStAupJuCEfS2LAiscjFDwh8AtrvgEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HJxnKR26; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8A4A2C4CEEA;
	Mon, 21 Apr 2025 14:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745247487;
	bh=yjlz1+aLlRQYQhpF4+uSLLx9jArQyUOmwqytKlg1KfE=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=HJxnKR26Mp1IEee21HLak1BmHcswiVou+e71QKNl2QJe+aFwODdEjHo2vAeWpIWHl
	 E/uXMjqL/FwAm4Ac5d2r0m6ZHqWtV57QTuDn8UNWJPkRLfpLEAB13OjYELvQmhASG+
	 uL4p/0cxPcBv8lepXCMRPdcBYnULfEWnwMgZD5/EXD8KRuAYY3438AZcG3vusvFuxk
	 5lRq6C791CbDyT8KEtEtIUfsLEnZtLYQWsn+MDIPNJgfFi5P7WyzU49CziXwOr1u3p
	 ymjl72PXeI+BmRWbDER3lbr9MNX96LDtXDYpTe1IRIFgFgTpunrT/usa4+FMIKLZIp
	 CdsW/+C4hI+3Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F56C369AB;
	Mon, 21 Apr 2025 14:58:07 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Subject: [PATCH RESEND v3 0/6] clk: clk-axi-clkgen: improvements and some
 fixes
Date: Mon, 21 Apr 2025 15:58:01 +0100
Message-Id: <20250421-dev-axi-clkgen-limits-v3-0-4203b4fed2c9@analog.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPlcBmgC/3XNQYvCMBAF4L8iOW+WJFMb68mDXvewe1w8xMmkH
 aytNCW4SP+7oQgiS49vHvO9u4g0MEWxXd3FQIkj910O8LES2LiuJsk+Z2GUWSujN9JTku7GEtt
 zTZ1s+cJjlCWEk8I1IWxOIv9eBwp8m91f8X34OXztxTHfG45jP/zNc0nP7VOuFuSkpZKmDJaCL
 tBXuHOda/v6E/vLTCbzYkDDEmMyoy04Ms6XoPU/Bl5MoewSA5kBQBuMxcqX1RszTdMDweSwjVE
 BAAA=
X-Change-ID: 20250218-dev-axi-clkgen-limits-63fb0c5ec38b
To: linux-clk@vger.kernel.org, linux-fpga@vger.kernel.org
Cc: Stephen Boyd <sboyd@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>, 
 Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745247490; l=1653;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=yjlz1+aLlRQYQhpF4+uSLLx9jArQyUOmwqytKlg1KfE=;
 b=arhBxZrC43kWNaK2hEX8qiJ3ugamENsnGipAbaj+I8fnsQGe4NHChb6MT04cclc6aVScZENSd
 beRSHN9hLukCuJbZx3WJ+CwKgu2xnac8YpDlNUmJyqpvRLuPbHmhUMt
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
Changes in v4:
- EDITME: describe what is new in this series revision.
- EDITME: use bulletpoints and terse descriptions.
- Link to v3: https://lore.kernel.org/r/20250407-dev-axi-clkgen-limits-v3-0-33c7f27c9d69@analog.com

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




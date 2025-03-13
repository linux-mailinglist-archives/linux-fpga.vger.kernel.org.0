Return-Path: <linux-fpga+bounces-1109-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5EB9A5F95D
	for <lists+linux-fpga@lfdr.de>; Thu, 13 Mar 2025 16:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CDCF179B85
	for <lists+linux-fpga@lfdr.de>; Thu, 13 Mar 2025 15:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70CD268C63;
	Thu, 13 Mar 2025 15:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s8mBlLuJ"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF09267F77;
	Thu, 13 Mar 2025 15:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741878881; cv=none; b=hXhblR7/hvbZWjfT+VzwJF/sqzuughvWLsBQiCxcfXKVdrpz8nk3DQKi2Kg67VDsAeLDA+H9ywejZw9+tjFrmiic2FSpxuX07FTeeZqNDRIrqyZXd0+KWXyt5+c0mNWtFYJSKV2Yc7MaWyQD1KQyP2ntezXe3M8lKScrpMI51tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741878881; c=relaxed/simple;
	bh=zcGj1uOEL8WR4UP614EhP+WDUNi3KOZTpWDDpUBnmv0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lZaUKQbkOLeImqsjGOfhORNDRIR9xepw9YlZ9ptYjoyqgTiNwh43dEa8zzN2UlWEdKZx4yVSWxvx49Afj1ERmaXGcZ5iRuRi1xAzjBUlW4g0ggImnQg4hUC/8qDkrEy5510gbOj2D053vGa3m1pSf19/noMuF3ZnZlV8PXLrflo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s8mBlLuJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 07142C4CEDD;
	Thu, 13 Mar 2025 15:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741878881;
	bh=zcGj1uOEL8WR4UP614EhP+WDUNi3KOZTpWDDpUBnmv0=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=s8mBlLuJGnQR/Yd9aio0WV727q2o2yBudAk0vbuRvEyvHWQjWEcQBLVSaTIB+6Al6
	 SEYLnonhfqK1TbFRNzLJwxd9qx42JgykZi5u4i1sGsX38j2eQdqS6t7yimg2X3fPDm
	 3o84Iw3VdywC2MSL+tU/qlTew6tC/MlO3pJa3fJra1CiPQCZBo/t+DXAwIeziC5weQ
	 pzj3T2P/ooIsX/whgegHI/96WQILrEhFe2st5Rt3rFSkvtbs6B1p60Sw/g1WsoBjoL
	 yUUY7Pdekrz/FSvgtoOdMC1NS9KXdhd+JSvCnMFj5RjTCRCY1Eqneb5kY5bPf/fl4h
	 pyqEXWFmkdSUg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5357C282DE;
	Thu, 13 Mar 2025 15:14:40 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Subject: [PATCH v2 0/6] clk: clk-axi-clkgen: improvements and some fixes
Date: Thu, 13 Mar 2025 15:14:42 +0000
Message-Id: <20250313-dev-axi-clkgen-limits-v2-0-173ae2ad6311@analog.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAGL20mcC/3WNwQ6CMBAFf4X07Jq2CIIn/8NwKGULG6E1LWkwp
 P9uJfHocSZ583YW0BMGdit25jFSIGczyFPB9KTsiEBDZia5rLgUDQwYQW0Een6OaGGmhdYAdWl
 6rivUZdOzvH15NLQd3UeXeaKwOv8+bqL42l+x/VOMAjjI2lzRiIseWn1XVs1uPGu3sC6l9AF9n
 do9uwAAAA==
X-Change-ID: 20250218-dev-axi-clkgen-limits-63fb0c5ec38b
To: linux-clk@vger.kernel.org, linux-fpga@vger.kernel.org
Cc: Stephen Boyd <sboyd@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>, 
 Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741878886; l=1074;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=zcGj1uOEL8WR4UP614EhP+WDUNi3KOZTpWDDpUBnmv0=;
 b=ElfHDd6UrzzxERpEEORfL8eDB3IhstNDMUwliSk6zJ3yJiMTKaTL63/+YKLInzQ23liTiBpUQ
 o5jYG6ac+X8BA0jv0IF+tCvzSPHPqz1C1GKSksccbnDfpImNCWM4uwz
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

 drivers/clk/clk-axi-clkgen.c        | 149 +++++++++++++++++++++++++-----------
 include/linux/fpga/adi-axi-common.h |  35 +++++++++
 2 files changed, 141 insertions(+), 43 deletions(-)
---
base-commit: 82f69876ef45ad66c0b114b786c7c6ac0f6a4580
change-id: 20250218-dev-axi-clkgen-limits-63fb0c5ec38b
--

Thanks!
- Nuno Sá




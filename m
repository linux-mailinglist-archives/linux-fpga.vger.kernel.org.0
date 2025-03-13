Return-Path: <linux-fpga+bounces-1110-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE6DA5F966
	for <lists+linux-fpga@lfdr.de>; Thu, 13 Mar 2025 16:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91E4D19C1F90
	for <lists+linux-fpga@lfdr.de>; Thu, 13 Mar 2025 15:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE232268C75;
	Thu, 13 Mar 2025 15:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fkedl9Er"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFCB268C52;
	Thu, 13 Mar 2025 15:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741878881; cv=none; b=lUhsxo72Y0iGjHSGRa1fl3XWvaW4+WflsNpbkWI7A/5ECJnljC5CN54oIbMODoc2Cpyx0EKf4UiHLdKwL5QBUUyNDFh8PAf/sysbek4bV14ZTe/sSSNdJ86xyCLRtFUSr81J8D1Lx42U8e314yUccYrcibXc7bq8kbDa+bRVw/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741878881; c=relaxed/simple;
	bh=MnRZ3RO6d/dKLYhdmgFmgy5v6Ek8gwoEm8NYdSEo24g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pWRXRxj/0JH4fCEGg/rl4sHIqgo/CbPuELP86Mv5uALPXONGNR0Q0lJ9D6rnBdovW3BQJy6pb46KaTRyxg9vVUovTyuqrQ8bnmLypvWvL6CVJtGAzedLJ6L/oh/+TIetNbvcYb4aLqtx5PmUMIqCTJy2eOlFZaup8TmbcV+hcEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fkedl9Er; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 295FCC4CEEF;
	Thu, 13 Mar 2025 15:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741878881;
	bh=MnRZ3RO6d/dKLYhdmgFmgy5v6Ek8gwoEm8NYdSEo24g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Fkedl9Er4fgkU5jIHytKMiT7ZlSsU7TOWflnY/gT/6Cvws/Ru1J0oQtRk3qjZEwSJ
	 F5TfOzm2ADcqoPRSFUJACTYoHVx1GVwXvfyKrtDBHb5mjVqs1mSq+uj4fvtoNPp33Z
	 dMC7cmpO0we8AhByQAGLyT3kvJAba2M18aGQH5CgG8MdWZN2ouTfrm4vapJqb/BBcZ
	 QvsgqhwRyf/WpklIPbVUxWtOxxGRzBi5+x/0PuonEw20lqDnLbM9LnyiDzY9UUSE0U
	 lIl58oNb4uuvtZVghSGtDIuC04/34tFP90SpU9sv7/9vumyw3hwQ/1S+2tF/o9QCIX
	 1ZY3G8R+We33Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BEC6C282EC;
	Thu, 13 Mar 2025 15:14:41 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Thu, 13 Mar 2025 15:14:45 +0000
Subject: [PATCH v2 3/6] include: fpga: adi-axi-common: add new helper
 macros
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250313-dev-axi-clkgen-limits-v2-3-173ae2ad6311@analog.com>
References: <20250313-dev-axi-clkgen-limits-v2-0-173ae2ad6311@analog.com>
In-Reply-To: <20250313-dev-axi-clkgen-limits-v2-0-173ae2ad6311@analog.com>
To: linux-clk@vger.kernel.org, linux-fpga@vger.kernel.org
Cc: Stephen Boyd <sboyd@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>, 
 Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741878886; l=2067;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=HReA2MAYtduz2bb2HnPbeBWJeXtFJv4KCDm8xe4UC+Q=;
 b=wvEskadfW/ZpqWTnJAPIwY9fIq4O3mfs0reybrhuJw0AN1LRtGWgIC8Aj2VJD0iNsDkUDltVf
 jD1NlVx9bHVDE3Apc/oYjzqhMSMyxkH1rEJ3GMtu0VoiPmlz4qrGbwS
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

Add new helper macros and enums to help identifying the platform and some
characteristics of it at runtime.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 include/linux/fpga/adi-axi-common.h | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/include/linux/fpga/adi-axi-common.h b/include/linux/fpga/adi-axi-common.h
index 141ac3f251e6f256526812b9d55cd440a2a46e76..a832ef9b37473ca339a2a2ff8a4a5716d428fd29 100644
--- a/include/linux/fpga/adi-axi-common.h
+++ b/include/linux/fpga/adi-axi-common.h
@@ -12,6 +12,8 @@
 #define ADI_AXI_COMMON_H_
 
 #define ADI_AXI_REG_VERSION			0x0000
+#define ADI_AXI_REG_FPGA_INFO			0x001C
+#define ADI_AXI_REG_FPGA_VOLTAGE		0x0140
 
 #define ADI_AXI_PCORE_VER(major, minor, patch)	\
 	(((major) << 16) | ((minor) << 8) | (patch))
@@ -20,4 +22,37 @@
 #define ADI_AXI_PCORE_VER_MINOR(version)	(((version) >> 8) & 0xff)
 #define ADI_AXI_PCORE_VER_PATCH(version)	((version) & 0xff)
 
+#define ADI_AXI_INFO_FPGA_TECH(info)            (((info) >> 24) & 0xff)
+#define ADI_AXI_INFO_FPGA_FAMILY(info)          (((info) >> 16) & 0xff)
+#define ADI_AXI_INFO_FPGA_SPEED_GRADE(info)     (((info) >> 8) & 0xff)
+#define ADI_AXI_INFO_FPGA_VOLTAGE(val)          ((val) & 0xffff)
+
+enum adi_axi_fpga_technology {
+	ADI_AXI_FPGA_TECH_UNKNOWN = 0,
+	ADI_AXI_FPGA_TECH_SERIES7,
+	ADI_AXI_FPGA_TECH_ULTRASCALE,
+	ADI_AXI_FPGA_TECH_ULTRASCALE_PLUS,
+};
+
+enum adi_axi_fpga_family {
+	ADI_AXI_FPGA_FAMILY_UNKNOWN = 0,
+	ADI_AXI_FPGA_FAMILY_ARTIX,
+	ADI_AXI_FPGA_FAMILY_KINTEX,
+	ADI_AXI_FPGA_FAMILY_VIRTEX,
+	ADI_AXI_FPGA_FAMILY_ZYNQ,
+};
+
+enum adi_axi_fpga_speed_grade {
+	ADI_AXI_FPGA_SPEED_UNKNOWN      = 0,
+	ADI_AXI_FPGA_SPEED_1    = 10,
+	ADI_AXI_FPGA_SPEED_1L   = 11,
+	ADI_AXI_FPGA_SPEED_1H   = 12,
+	ADI_AXI_FPGA_SPEED_1HV  = 13,
+	ADI_AXI_FPGA_SPEED_1LV  = 14,
+	ADI_AXI_FPGA_SPEED_2    = 20,
+	ADI_AXI_FPGA_SPEED_2L   = 21,
+	ADI_AXI_FPGA_SPEED_2LV  = 22,
+	ADI_AXI_FPGA_SPEED_3    = 30,
+};
+
 #endif /* ADI_AXI_COMMON_H_ */

-- 
2.48.1




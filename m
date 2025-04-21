Return-Path: <linux-fpga+bounces-1166-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 380C5A9532F
	for <lists+linux-fpga@lfdr.de>; Mon, 21 Apr 2025 16:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D20DC3AC26C
	for <lists+linux-fpga@lfdr.de>; Mon, 21 Apr 2025 14:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E6F1C8611;
	Mon, 21 Apr 2025 14:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GE1kVDOx"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312E71C6FF2;
	Mon, 21 Apr 2025 14:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745247488; cv=none; b=ctC6yJclqK6imet2bZMr9KmDxC04BFyEwaNA4x7V1PpHJRvkfZxB9bAvVMQnnL2SM0tJEHxVYvMAtju/g7qVHVl1rQ60uSbP70Pzz4MOKoGRezuu7IdgeZhglzhdMXZTxgy8QJIK51DwB8qw8JnFMcHv6yPberPShNCGsB7URGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745247488; c=relaxed/simple;
	bh=zU7qUe5tOFyK1gdGBXLbS8e/ReGYgRnf9vPbRIf94cM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oZbNSf//HV8+/Nw/qhBBDYZQNxHrqz4d+p1SIsQqByRxorlVK+fzN2iWfjkSxHLAFHMNhA8SzWzJ9oiZvbRbo2USHPn/aEZ6ogdmUyXQD4v8Mp/Ai3XTozOg5ef06ZYgjEGJZFQ5fMn+naO7j0rYQMxXCyt9K9/SycZCBFuhRDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GE1kVDOx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B86DFC4CEF0;
	Mon, 21 Apr 2025 14:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745247487;
	bh=zU7qUe5tOFyK1gdGBXLbS8e/ReGYgRnf9vPbRIf94cM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=GE1kVDOxiT7/LYhjvvzw1PGspLpwsCXJh5xX9ODn9i5X043pS8fsoPEdkKiGy03In
	 WiIA+pflpiB953gvSo+iYXrt4KKjms8A/oNn1awsKQFxA2PZEH38yX6z+XlZ+CPK9p
	 OygAwv3lAnMon35wO96UKiPqzjKYSiFJN/lK13R6GVtv6NdTeut1w/aP7Ez1ILKLDO
	 KLECsDmXJG8mHL5mCFEzuhKfmiLhTgLjtIDBD1PEDEYW/rr0nRcRiY/+b1VnQtXx1f
	 QQBP2RZ6193dcdNaVGdn64NVeO3bxDKWL2iTX6Synmg6pjRX7PZPKoJtTl6nn9qHqv
	 xDUUe3n+Ogcow==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC06EC369D5;
	Mon, 21 Apr 2025 14:58:07 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Mon, 21 Apr 2025 15:58:04 +0100
Subject: [PATCH RESEND v3 3/6] include: fpga: adi-axi-common: add new
 helper macros
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250421-dev-axi-clkgen-limits-v3-3-4203b4fed2c9@analog.com>
References: <20250421-dev-axi-clkgen-limits-v3-0-4203b4fed2c9@analog.com>
In-Reply-To: <20250421-dev-axi-clkgen-limits-v3-0-4203b4fed2c9@analog.com>
To: linux-clk@vger.kernel.org, linux-fpga@vger.kernel.org
Cc: Stephen Boyd <sboyd@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>, 
 Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745247490; l=2067;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=+TkAxyW1xXsPUzdQREPOMhF0lodnEOmKT8NEfrr7xoI=;
 b=FtTDVc0F2kWPNERHxmcLatqiBwqIveh+PnOJ4fGM4Z//ffYbUlqaV48ePZgmGwoSUPnMpbGMP
 2uskUwS1AIGDTcamrmcde6WV+isf9ignDlFxZVRmw+pBNWHerR0/gaq
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
2.49.0




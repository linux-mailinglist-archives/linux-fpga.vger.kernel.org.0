Return-Path: <linux-fpga+bounces-1057-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2D1A3C5F6
	for <lists+linux-fpga@lfdr.de>; Wed, 19 Feb 2025 18:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32C3A1888BE2
	for <lists+linux-fpga@lfdr.de>; Wed, 19 Feb 2025 17:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C62B286284;
	Wed, 19 Feb 2025 17:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kd3HYP8E"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133BE1FDA93;
	Wed, 19 Feb 2025 17:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739985618; cv=none; b=ojeXZC+uxCGKdJJCIvx/MqbHzdpmwGp1pXj2KafMz5y84yiNe4F1pg6RaljHmbIcoHOrObNIZ81j2H9DGm9Gwi8Bu+omTxGX1bXGtLXoFA0RGGpuqztUJkcN8n7xOu8rReBz4jdwPBldWL7Gxv38ZUOOwH6Im3eghZWzr5QVBtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739985618; c=relaxed/simple;
	bh=e+m0k0M5Z5wNKexhhlUYDfbSJ1xgMvf3PJ1NPl7NcQ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qBh1ji+m7bl3RXHbdoM4Toom7d2i4uN6tr+jPmyrzv1+DduZ9O/ECQN+86ARby1nkj0HV4nAjCt+PNlFG0W+xsodJNSaORL5kE5NJOgOgM4ONVC0Xq+UYH6YiVHL+NMf7f1eu2/GlgbjFSiEB9V8jgvAQw04Eb++H1RU9x3XjFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kd3HYP8E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E1F7FC4CEE9;
	Wed, 19 Feb 2025 17:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739985617;
	bh=e+m0k0M5Z5wNKexhhlUYDfbSJ1xgMvf3PJ1NPl7NcQ8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Kd3HYP8EtFlOBKJuOF4Uy2MsZEobizSikyRcMA38XP04cjCRSB/rQnK0LOsQxJuNZ
	 IHvJN7MPmIRVF5vby2j5uuK9a2AZ54/eYq9CUIckfXwyrfrO3S43iequoR4/fonqSn
	 4erfQ9Z4r71sAGtdd/TRoTGWzBbO8+AAO8fGupU2kjxOAsvbagWH3Z56vSaR2denMz
	 1nbputL8z9bgakqS2DBFOWlFKqc5QAj4eQnm4YUIQlpddUY8tLXQkTcS6y37P0aQop
	 QrPaNe0Hm8C8+ituxTXEInjNPPIPW/eVSrV3QYS2NoHIp9t9maxqRgIX/dSmuwjDEW
	 sw9QbuNdOu3Bg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5727C021B1;
	Wed, 19 Feb 2025 17:20:17 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Wed, 19 Feb 2025 17:20:21 +0000
Subject: [PATCH 3/6] include: fpga: adi-axi-common: add new helper macros
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250219-dev-axi-clkgen-limits-v1-3-26f7ef14cd9c@analog.com>
References: <20250219-dev-axi-clkgen-limits-v1-0-26f7ef14cd9c@analog.com>
In-Reply-To: <20250219-dev-axi-clkgen-limits-v1-0-26f7ef14cd9c@analog.com>
To: linux-clk@vger.kernel.org, linux-fpga@vger.kernel.org
Cc: Stephen Boyd <sboyd@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>, 
 Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739985620; l=2067;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=yJg4OAu6RcRDDQlB5kvTHzyUpwrZS4HT9bCyy9oa3/U=;
 b=mMLTxcaS1tOVeHlljXiFRHkGMv3JTZDZLu+MQ6KMv/El0EQ+Qg9DiqHxQa9ZPOgfC88P1oLdh
 iCDZ7dr0JNuAKUM7GdEyeluoNx8v90P4oKDE6PpxTpvYKulfubyQBXW
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
index 141ac3f251e6f256526812b9d55cd440a2a46e76..747a4ff586708a3dcf34c26ec5aec347cf617b15 100644
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
+enum adi_axi_fgpa_technology {
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




Return-Path: <linux-fpga+bounces-1112-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC0EA5F965
	for <lists+linux-fpga@lfdr.de>; Thu, 13 Mar 2025 16:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90AE83BA92C
	for <lists+linux-fpga@lfdr.de>; Thu, 13 Mar 2025 15:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83EC268C79;
	Thu, 13 Mar 2025 15:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z0JrcSy1"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CBB268C57;
	Thu, 13 Mar 2025 15:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741878881; cv=none; b=ZZHJo0URvdvgdnViP4HF2OV/dTI6Kf/u3wcMhy5/tqV7W+y/43nI/+c5NVhg0KlarUZ+pkKpzV30ZZvbs7x0T4fCNivunQjf0NFBnPGGitxtAFz4QdCLByerUGl90OBGe0YWgT7D34sg9LaBtnf4Iv/+CQjX/AfnCQrmTIHAL7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741878881; c=relaxed/simple;
	bh=N0gDNeAdIYDJBypJgqWPXHM4B/7XjOy4fs/9xKEoAlc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GrH0gzxtxBvR2xpSTTHXMU4us4lHydWl6vv65JuoYxVBtNw4NGOACQ8HjwpobSZYESGnb79MZJ6BtzL8smepwARqvnWcm2jlJei0Bph4vaNLQ6WgXNBIuiogXq9dCnnUnHM1sDusJoDd7l9mJijXomOQKz7HPVekgsSD15sTvbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z0JrcSy1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 336A9C4CEF0;
	Thu, 13 Mar 2025 15:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741878881;
	bh=N0gDNeAdIYDJBypJgqWPXHM4B/7XjOy4fs/9xKEoAlc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Z0JrcSy19qcfXeAcpBYBuFL+3F9b0maaTbNK7ezoWRe/1xsgvVj5IOipyrEhC3aYL
	 kPXJlI26OdvWtX2uya9DSd5Y+7N7zNPlRWqWCzhWP48EAxQqbOj+LSimNqKJz30Wl0
	 FPEFgfBRSxk9qU1kadeE1GvToV8YJYjPuJ3VBpflkElInpYmHdHRjaQnvWR+S0WB00
	 XrVJTLYm1Mz0ovhwQpymj7RkLChHgGucMsGflET0iRqlqTg5QnTRxIC0YJ2ypc1ZpQ
	 pqhWBb2pNn4JjlHlPKG6zWEKFYctrNeZGA3c8l/K5Nyo+LRiFAfBKtzbg3PriPlv7O
	 dIWqq5X5U6ErA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 297CBC35FF5;
	Thu, 13 Mar 2025 15:14:41 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Thu, 13 Mar 2025 15:14:46 +0000
Subject: [PATCH v2 4/6] clk: clk-axi-clkgen: detect axi_clkgen_limits at
 runtime
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250313-dev-axi-clkgen-limits-v2-4-173ae2ad6311@analog.com>
References: <20250313-dev-axi-clkgen-limits-v2-0-173ae2ad6311@analog.com>
In-Reply-To: <20250313-dev-axi-clkgen-limits-v2-0-173ae2ad6311@analog.com>
To: linux-clk@vger.kernel.org, linux-fpga@vger.kernel.org
Cc: Stephen Boyd <sboyd@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>, 
 Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741878886; l=3698;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=b0wTLM4W+6x7yEOO5vkPSqdl2eWJcNE+mU1J9N7CBFo=;
 b=VkGA3c3jsf+kGI8iFvA71ejt75sXrb2MaJyP7DUAbbDuxhFd7be8vVIvoX1VdmfLXkueuH2Eo
 W46pQx0BSy1BMAA9zNbKht8xPyCvrZ+abbetaYc9IFiTylhrHn6qqN+
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

This patch adds support for setting the limits in struct
axi_clkgen_limits  in accordance with fpga speed grade, voltage,
technology and family. This new information is extracted from
two new registers implemented in the ip core that are only available
for core versions higher or equal to 4.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/clk/clk-axi-clkgen.c | 62 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 61 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-axi-clkgen.c b/drivers/clk/clk-axi-clkgen.c
index 2a95f9b220234a1245024a821c50e1eb9c104ac9..8c270ba7626bc24c4385615b7aa08ee95e198881 100644
--- a/drivers/clk/clk-axi-clkgen.c
+++ b/drivers/clk/clk-axi-clkgen.c
@@ -16,6 +16,8 @@
 #include <linux/mod_devicetable.h>
 #include <linux/err.h>
 
+#include <linux/fpga/adi-axi-common.h>
+
 #define AXI_CLKGEN_V2_REG_RESET		0x40
 #define AXI_CLKGEN_V2_REG_CLKSEL	0x44
 #define AXI_CLKGEN_V2_REG_DRP_CNTRL	0x70
@@ -497,6 +499,54 @@ static u8 axi_clkgen_get_parent(struct clk_hw *clk_hw)
 	return parent;
 }
 
+static int axi_clkgen_setup_limits(struct axi_clkgen *axi_clkgen,
+				   struct device *dev)
+{
+	unsigned int tech, family, speed_grade, reg_value;
+
+	axi_clkgen_read(axi_clkgen, ADI_AXI_REG_FPGA_INFO, &reg_value);
+	tech = ADI_AXI_INFO_FPGA_TECH(reg_value);
+	family = ADI_AXI_INFO_FPGA_FAMILY(reg_value);
+	speed_grade = ADI_AXI_INFO_FPGA_SPEED_GRADE(reg_value);
+
+	axi_clkgen->limits.fpfd_min = 10000;
+	axi_clkgen->limits.fvco_min = 600000;
+
+	switch (speed_grade) {
+	case ADI_AXI_FPGA_SPEED_1 ... ADI_AXI_FPGA_SPEED_1LV:
+		axi_clkgen->limits.fvco_max = 1200000;
+		axi_clkgen->limits.fpfd_max = 450000;
+		break;
+	case ADI_AXI_FPGA_SPEED_2 ... ADI_AXI_FPGA_SPEED_2LV:
+		axi_clkgen->limits.fvco_max = 1440000;
+		axi_clkgen->limits.fpfd_max = 500000;
+		if (family == ADI_AXI_FPGA_FAMILY_KINTEX || family == ADI_AXI_FPGA_FAMILY_ARTIX) {
+			axi_clkgen_read(axi_clkgen, ADI_AXI_REG_FPGA_VOLTAGE,
+					&reg_value);
+			if (ADI_AXI_INFO_FPGA_VOLTAGE(reg_value) < 950) {
+				axi_clkgen->limits.fvco_max = 1200000;
+				axi_clkgen->limits.fpfd_max = 450000;
+			}
+		}
+		break;
+	case ADI_AXI_FPGA_SPEED_3:
+		axi_clkgen->limits.fvco_max = 1600000;
+		axi_clkgen->limits.fpfd_max = 550000;
+		break;
+	default:
+		return dev_err_probe(dev, -ENODEV, "Unknown speed grade %d\n",
+				     speed_grade);
+	};
+
+	/* Overwrite vco limits for ultrascale+ */
+	if (tech == ADI_AXI_FPGA_TECH_ULTRASCALE_PLUS) {
+		axi_clkgen->limits.fvco_max = 1600000;
+		axi_clkgen->limits.fvco_min = 800000;
+	}
+
+	return 0;
+}
+
 static const struct clk_ops axi_clkgen_ops = {
 	.recalc_rate = axi_clkgen_recalc_rate,
 	.determine_rate = axi_clkgen_determine_rate,
@@ -511,6 +561,7 @@ static int axi_clkgen_probe(struct platform_device *pdev)
 {
 	const struct axi_clkgen_limits *dflt_limits;
 	struct axi_clkgen *axi_clkgen;
+	unsigned int pcore_version;
 	struct clk_init_data init;
 	const char *parent_names[2];
 	const char *clk_name;
@@ -556,7 +607,16 @@ static int axi_clkgen_probe(struct platform_device *pdev)
 			return -EINVAL;
 	}
 
-	memcpy(&axi_clkgen->limits, dflt_limits, sizeof(axi_clkgen->limits));
+	axi_clkgen_read(axi_clkgen, ADI_AXI_REG_VERSION, &pcore_version);
+
+	if (ADI_AXI_PCORE_VER_MAJOR(pcore_version) > 0x04) {
+		ret = axi_clkgen_setup_limits(axi_clkgen, &pdev->dev);
+		if (ret)
+			return ret;
+	} else {
+		memcpy(&axi_clkgen->limits, dflt_limits,
+		       sizeof(axi_clkgen->limits));
+	}
 
 	clk_name = pdev->dev.of_node->name;
 	of_property_read_string(pdev->dev.of_node, "clock-output-names",

-- 
2.48.1




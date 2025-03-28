Return-Path: <linux-fpga+bounces-1127-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F91FA74CC9
	for <lists+linux-fpga@lfdr.de>; Fri, 28 Mar 2025 15:34:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAC44189AD4D
	for <lists+linux-fpga@lfdr.de>; Fri, 28 Mar 2025 14:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7C322156D;
	Fri, 28 Mar 2025 14:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=framepointer.org header.i=@framepointer.org header.b="mIOVfjN5"
X-Original-To: linux-fpga@vger.kernel.org
Received: from out-16.pe-a.jellyfish.systems (out-16.pe-a.jellyfish.systems [198.54.127.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6F721D5AF;
	Fri, 28 Mar 2025 14:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743172203; cv=none; b=J5qX6U5a62TZJ214yN90RmHdEEoxxf8HRrdxhmZFmOKFEom0D5pnKD84YfevSNgQ5x/pHvim2tvEtPiahyWAOPNM1KaOEyexRxL6BnSsjmwT3fupaKihu6scMQglAeOgT24gcHEJqHVPPoX7DKj6IB4XGg6pjPG8bVPNRKnH6Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743172203; c=relaxed/simple;
	bh=hFqHqKV+KeZawAy1aS1MAjdhzYhHV8EspKvPassTmhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CHOl0isXnnRAaCe8H5aJzatmMvT0nPuvKuGx+YtKMcamz34DoYAXEfhyL3w6MsdkMkQELOPj7Amo8lAKB5NodK8cT07UquDEqMYoTAlY4tPugJd3bux6gE+6+3+EYuW157tQecvq1AYjm/O7YJ5ZMtbsGji2SrXJA10E+jbAXWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=framepointer.org; spf=pass smtp.mailfrom=framepointer.org; dkim=pass (2048-bit key) header.d=framepointer.org header.i=@framepointer.org header.b=mIOVfjN5; arc=none smtp.client-ip=198.54.127.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=framepointer.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=framepointer.org
Received: from prod-lbout-phx.jellyfish.systems (new-01-3.privateemail.com [66.29.159.56])
	by pe-a.jellyfish.systems (Postfix) with ESMTPA id 4ZPN3b5FRYz4wb6;
	Fri, 28 Mar 2025 14:20:43 +0000 (UTC)
Received: from MTA-10-1.privateemail.com (unknown [10.50.14.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by NEW-01-3.privateemail.com (Postfix) with ESMTPS id 4ZPN3b4M3hz2Sd0W;
	Fri, 28 Mar 2025 10:20:43 -0400 (EDT)
Received: from mta-10.privateemail.com (localhost [127.0.0.1])
	by mta-10.privateemail.com (Postfix) with ESMTP id 4ZPN3b2cFrz3hhVG;
	Fri, 28 Mar 2025 10:20:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=framepointer.org;
	s=default; t=1743171643;
	bh=hFqHqKV+KeZawAy1aS1MAjdhzYhHV8EspKvPassTmhE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mIOVfjN5eG8XbGFfWVIZgnAcnec3Vh+Fy84/9xQnW7U+BLy/ywNpN6suyLAqyX8BA
	 2YxQ5ykvFOa/zLWYgT4Hz522N6l0nPUU1R6G/+j4HoXI/F7fdMwAbCv5FyTHpOjcs+
	 ArRLxZirG3Rdb1lhjqtG2Y3vpoVugxpSVFbvA0hoO5bonMbHLH/KAYDg8aTuR1Ad8K
	 Wb4qa474SoBQAQ6Z5rW9wjliQJy94u8aawIQwWuVrudNgxLXj/ZZ0uhZchv4zH8fMh
	 0e2KRZXlFsQByva9qAsoKYiz6kPBGyVJEc1r0uLHg+55YVfcYUsy/TZBSl5BKVi+HD
	 PCULFNVCLJUOg==
Received: from 65YTFL3.secure.tethers.com (unknown [152.44.190.141])
	by mta-10.privateemail.com (Postfix) with ESMTPA;
	Fri, 28 Mar 2025 10:20:26 -0400 (EDT)
From: Sam Winchenbach <sam.winchenbach@framepointer.org>
To: linux-kernel@vger.kernel.org
Cc: mdf@kernel.org,
	hao.wu@intel.com,
	yilun.xu@intel.com,
	trix@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	michal.simek@amd.com,
	linux-fpga@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	sam.winchenbach@framepointer.org,
	Sam Winchenbach <swinchenbach@arka.org>
Subject: [PATCH 2/2] fpga: zynq-fpga: Allow ICAP enable on probe
Date: Fri, 28 Mar 2025 10:19:44 -0400
Message-ID: <20250328141944.119504-2-sam.winchenbach@framepointer.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250328141944.119504-1-sam.winchenbach@framepointer.org>
References: <20250328141944.119504-1-sam.winchenbach@framepointer.org>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP

From: Sam Winchenbach <swinchenbach@arka.org>

Adds an option to enable the ICAP interface when driver is probed. This
is useful when the fabric is loaded as part of the first or second stage
of the boot process and contains an IP core that requires access to the
ICAP interface, such as Soft Error Mitigation (SEM) core.

Signed-off-by: Sam Winchenbach <swinchenbach@arka.org>
---
 drivers/fpga/zynq-fpga.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
index f7e08f7ea9ef3..4a53a429d659f 100644
--- a/drivers/fpga/zynq-fpga.c
+++ b/drivers/fpga/zynq-fpga.c
@@ -20,6 +20,7 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/pm.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/string.h>
 #include <linux/scatterlist.h>
@@ -482,8 +483,7 @@ static int zynq_fpga_ops_write(struct fpga_manager *mgr, struct sg_table *sgt)
 	return err;
 }
 
-static int zynq_fpga_ops_write_complete(struct fpga_manager *mgr,
-					struct fpga_image_info *info)
+static int zynq_fpga_enable_icap(struct fpga_manager *mgr)
 {
 	struct zynq_fpga_priv *priv = mgr->priv;
 	int err;
@@ -504,6 +504,18 @@ static int zynq_fpga_ops_write_complete(struct fpga_manager *mgr,
 
 	clk_disable(priv->clk);
 
+	return err;
+}
+
+static int zynq_fpga_ops_write_complete(struct fpga_manager *mgr,
+					struct fpga_image_info *info)
+{
+	struct zynq_fpga_priv *priv = mgr->priv;
+	int err;
+	u32 intr_status;
+
+	err = zynq_fpga_enable_icap(mgr);
+
 	if (err)
 		return err;
 
@@ -615,6 +627,16 @@ static int zynq_fpga_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, mgr);
 
+	if (device_property_read_bool(dev, "enable-icap-on-load")) {
+		err = zynq_fpga_enable_icap(mgr);
+		if (err) {
+			dev_err(dev, "unable to enable ICAP interface\n");
+			fpga_mgr_unregister(mgr);
+			clk_unprepare(priv->clk);
+			return err;
+		}
+	}
+
 	return 0;
 }
 
-- 
2.49.0



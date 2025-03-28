Return-Path: <linux-fpga+bounces-1128-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4AE6A74CDA
	for <lists+linux-fpga@lfdr.de>; Fri, 28 Mar 2025 15:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D2801797E3
	for <lists+linux-fpga@lfdr.de>; Fri, 28 Mar 2025 14:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8329E221714;
	Fri, 28 Mar 2025 14:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=framepointer.org header.i=@framepointer.org header.b="b8/dVB7P"
X-Original-To: linux-fpga@vger.kernel.org
Received: from out-14.pe-a.jellyfish.systems (out-14.pe-a.jellyfish.systems [198.54.127.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AB521D5BD;
	Fri, 28 Mar 2025 14:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743172204; cv=none; b=TiHCNbhJLbHd1iuQ2OibF2RmVPwCKKlmG2VatVtQOYppEDDfc11pivzu4ofSFxBS/crMc0r4thnyaNeY8N2kuM/e9uga14ezyzQt31ToAXDfY8Mr+bqGMbiqCgBJoC7O5UK1J25CVb5WzRGDOWTn7O1D6+LCbX4scVsUkkr3+kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743172204; c=relaxed/simple;
	bh=oFKlVEIJkzbevNVbC3MkyLq3MXtcD4FApIeE0ARhv1w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=akwTmH+l8V+u3N0yk/jUYhJCXemZWlX82JPJqiY3uyjCIl5DmWHvq43cM3aV3qv13EvMBTuyMeHUiMBlGwTXD/llzdyidDTiHccyoLlJDG1X08XLpUec2KHYvSwFomtUHJfnmMtI9z7usa0T/VU5ojv5wUWpUJirBgFhZNxT12E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=framepointer.org; spf=pass smtp.mailfrom=framepointer.org; dkim=pass (2048-bit key) header.d=framepointer.org header.i=@framepointer.org header.b=b8/dVB7P; arc=none smtp.client-ip=198.54.127.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=framepointer.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=framepointer.org
Received: from prod-lbout-phx.jellyfish.systems (new-01-3.privateemail.com [66.29.159.56])
	by pe-a.jellyfish.systems (Postfix) with ESMTPA id 4ZPN3G1B6qz3x6g;
	Fri, 28 Mar 2025 14:20:26 +0000 (UTC)
Received: from MTA-10-1.privateemail.com (unknown [10.50.14.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by NEW-01-3.privateemail.com (Postfix) with ESMTPS id 4ZPN3G0jPQz2Sd0R;
	Fri, 28 Mar 2025 10:20:26 -0400 (EDT)
Received: from mta-10.privateemail.com (localhost [127.0.0.1])
	by mta-10.privateemail.com (Postfix) with ESMTP id 4ZPN3F61XZz3hhd0;
	Fri, 28 Mar 2025 10:20:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=framepointer.org;
	s=default; t=1743171625;
	bh=oFKlVEIJkzbevNVbC3MkyLq3MXtcD4FApIeE0ARhv1w=;
	h=From:To:Cc:Subject:Date:From;
	b=b8/dVB7PNLK+P5v9+Otf5pd+f4WzKsBcH5Fc1pg7vrfv3FuxNWsRzF9MMUSp8Lr9p
	 Uo3rNJIyIXwFvuVYOJ6tjoGraigBBFNvBbYKAJcDC4bSWmVrZeBhXh7POz+caem+dl
	 V8sLrKAX+yvaz+3LQGNsdJVQQtMl8svvu/Ipguu/RJn0ZgMeLvl8sU8ZgpVnCvjAzc
	 Fp8eJ3M5IGNaIm3dsnnpKmY9b8a6eiqpjtngmUGbtQxTM7lCZkh7TPIBuwHVHE9ukL
	 ovf1mn7YQsheFgriFLwTbN12UAW0EXfBDNOWWss0zFVUyZ/liWxz6Y2KjYTFr4hg2U
	 S/1y0hfcNn9Qw==
Received: from 65YTFL3.secure.tethers.com (unknown [152.44.190.141])
	by mta-10.privateemail.com (Postfix) with ESMTPA;
	Fri, 28 Mar 2025 10:20:09 -0400 (EDT)
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
Subject: [PATCH 1/2] dt-bindings: fpga: zynq: Document ICAP on boot
Date: Fri, 28 Mar 2025 10:19:43 -0400
Message-ID: <20250328141944.119504-1-sam.winchenbach@framepointer.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP

From: Sam Winchenbach <swinchenbach@arka.org>

Documents the ability to enable the ICAP interface on boot.

Signed-off-by: Sam Winchenbach <swinchenbach@arka.org>
---
 .../devicetree/bindings/fpga/xilinx-zynq-fpga-mgr.yaml     | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/fpga/xilinx-zynq-fpga-mgr.yaml b/Documentation/devicetree/bindings/fpga/xilinx-zynq-fpga-mgr.yaml
index 04dcadc2c20e9..bb2781ae126ca 100644
--- a/Documentation/devicetree/bindings/fpga/xilinx-zynq-fpga-mgr.yaml
+++ b/Documentation/devicetree/bindings/fpga/xilinx-zynq-fpga-mgr.yaml
@@ -31,6 +31,13 @@ properties:
     description:
       Phandle to syscon block which provide access to SLCR registers
 
+  enable-icap-on-load:
+    type: boolean
+    description: If present, the ICAP controller will be enabled when
+      the driver probes. This is useful if the fabric is loaded
+      during the boot process and contains a core, such as the SEM,
+      that requires access to ICAP interface to operate properly.
+
 required:
   - compatible
   - reg
-- 
2.49.0



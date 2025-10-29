Return-Path: <linux-fpga+bounces-1394-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CCAC8C1CD6C
	for <lists+linux-fpga@lfdr.de>; Wed, 29 Oct 2025 19:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7842834BD7E
	for <lists+linux-fpga@lfdr.de>; Wed, 29 Oct 2025 18:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9497B357A2B;
	Wed, 29 Oct 2025 18:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PmExY34D"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69937357729;
	Wed, 29 Oct 2025 18:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761764112; cv=none; b=RWUPNZq+LTWQzivUs1f58PsYl+mrGbo3PDKvZLrMrsw5vfjO6zFZverPkymMa4jT9OkE8I262RPwowJsDlCfIGG5a3+gms/bKGMQr9Sia1dkhbQ6zU8StTaBOOTm5++qEuOZ14GAaBzS3/rRs5ou3tGxuFEoKycN70S4zP/1kRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761764112; c=relaxed/simple;
	bh=sggErpQd1c8hPjN2A5o1EFzWHHxgAVKtCjT9r1sMl2E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GHu29cD0YR3bIJIcWGcMH8CWNfqkOarPz0sJXrPKF/wKYZCelyZ0UvOdAKomBYuh+pa+vYkp58CzGtv31FGXKT++oSilzgiwbB5Mde2AoRgegYCGIb3N2mpHOS6DrALpe+iOgRBqfTqhu6zLZH9/0+WzJJN3mEzqENWrSo9rWG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PmExY34D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23A85C4CEF7;
	Wed, 29 Oct 2025 18:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761764112;
	bh=sggErpQd1c8hPjN2A5o1EFzWHHxgAVKtCjT9r1sMl2E=;
	h=From:To:Cc:Subject:Date:From;
	b=PmExY34DDSXvDTi4/n6n0Rk3++L6LHNi4jIo5mvKA2JU++htL6RT1DL2yBDklGDpS
	 jjLcUWrg6kiTWulfMYWlSZbZdQPeqlkOIINNiaJdYemqe4TBLP9hdIcAMFdQwwQzyw
	 ZSiw3YqzhUxDFKppIXhsmPCbtsEk7e2lhzpxM3Nn8tVgjdPjmRG+l0a8YAb93UpSaG
	 8MSaK+jyJgDofXe5/NyjxNj3xWQDIyUNNnzKvQ5J5BSwPQnHr3BHPfAm3hOZInKF0b
	 JMhLU0lCqDpehT8jOR+XEjhEiLmfaEv2Z8gzX9ZyGkxlxegePZ98INv1qAMwutjvE2
	 A3IsoynRP97rQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Holdsworth <joel@airwebreathe.org.uk>
Cc: linux-fpga@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: fpga: Convert lattice,ice40-fpga-mgr to DT schema
Date: Wed, 29 Oct 2025 13:55:01 -0500
Message-ID: <20251029185503.2124434-1-robh@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the lattice,ice40-fpga-mgr binding to DT schema format. It's a
straight-forward conversion.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/fpga/lattice,ice40-fpga-mgr.yaml | 59 +++++++++++++++++++
 .../bindings/fpga/lattice-ice40-fpga-mgr.txt  | 21 -------
 2 files changed, 59 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/fpga/lattice,ice40-fpga-mgr.yaml
 delete mode 100644 Documentation/devicetree/bindings/fpga/lattice-ice40-fpga-mgr.txt

diff --git a/Documentation/devicetree/bindings/fpga/lattice,ice40-fpga-mgr.yaml b/Documentation/devicetree/bindings/fpga/lattice,ice40-fpga-mgr.yaml
new file mode 100644
index 000000000000..5121c6120785
--- /dev/null
+++ b/Documentation/devicetree/bindings/fpga/lattice,ice40-fpga-mgr.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/fpga/lattice,ice40-fpga-mgr.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Lattice iCE40 FPGA Manager
+
+maintainers:
+  - Joel Holdsworth <joel@airwebreathe.org.uk>
+
+properties:
+  compatible:
+    const: lattice,ice40-fpga-mgr
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    minimum: 1000000
+    maximum: 25000000
+
+  cdone-gpios:
+    maxItems: 1
+    description: GPIO input connected to CDONE pin
+
+  reset-gpios:
+    maxItems: 1
+    description:
+      Active-low GPIO output connected to CRESET_B pin. Note that unless the
+      GPIO is held low during startup, the FPGA will enter Master SPI mode and
+      drive SCK with a clock signal potentially jamming other devices on the bus
+      until the firmware is loaded.
+
+required:
+  - compatible
+  - reg
+  - spi-max-frequency
+  - cdone-gpios
+  - reset-gpios
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        fpga@0 {
+            compatible = "lattice,ice40-fpga-mgr";
+            reg = <0>;
+            spi-max-frequency = <1000000>;
+            cdone-gpios = <&gpio 24 GPIO_ACTIVE_HIGH>;
+            reset-gpios = <&gpio 22 GPIO_ACTIVE_LOW>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/fpga/lattice-ice40-fpga-mgr.txt b/Documentation/devicetree/bindings/fpga/lattice-ice40-fpga-mgr.txt
deleted file mode 100644
index 4dc412437b08..000000000000
--- a/Documentation/devicetree/bindings/fpga/lattice-ice40-fpga-mgr.txt
+++ /dev/null
@@ -1,21 +0,0 @@
-Lattice iCE40 FPGA Manager
-
-Required properties:
-- compatible:		Should contain "lattice,ice40-fpga-mgr"
-- reg:			SPI chip select
-- spi-max-frequency:	Maximum SPI frequency (>=1000000, <=25000000)
-- cdone-gpios:		GPIO input connected to CDONE pin
-- reset-gpios:		Active-low GPIO output connected to CRESET_B pin. Note
-			that unless the GPIO is held low during startup, the
-			FPGA will enter Master SPI mode and drive SCK with a
-			clock signal potentially jamming other devices on the
-			bus until the firmware is loaded.
-
-Example:
-	fpga: fpga@0 {
-		compatible = "lattice,ice40-fpga-mgr";
-		reg = <0>;
-		spi-max-frequency = <1000000>;
-		cdone-gpios = <&gpio 24 GPIO_ACTIVE_HIGH>;
-		reset-gpios = <&gpio 22 GPIO_ACTIVE_LOW>;
-	};
-- 
2.51.0



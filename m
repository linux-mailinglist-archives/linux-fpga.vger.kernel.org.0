Return-Path: <linux-fpga+bounces-551-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5FDD9108B6
	for <lists+linux-fpga@lfdr.de>; Thu, 20 Jun 2024 16:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 805C5B22BD9
	for <lists+linux-fpga@lfdr.de>; Thu, 20 Jun 2024 14:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21F71AE86B;
	Thu, 20 Jun 2024 14:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MLV8QkqG"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0757C1AE85D;
	Thu, 20 Jun 2024 14:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718894693; cv=none; b=hTa7B0lyq2mk9jo+LVwlx94zVmWLWXfZuTo9sinpaxmCu3e0nev87MS/Syz2do3guq2gRgBGqZOPvIiCNVz22i7V7M8YDqJSRsolxbyxrvz6mO/2iPEbYp2xewyOH0RyZxWsbD/d+GqnMPoP2Rq5KcjgBAcyJIxCTvm4Gx6cqRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718894693; c=relaxed/simple;
	bh=LF0GwIC9fAhksgqgCC83N+teH+nYDXOaOl6URfn9EFc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ph5fPscnbv3gv631NSg1A8JHVa/cu0WNXFoR48VhALHOtsY96Dqy1koiy2Y+7ZH/qVXONxvwGO3dgZPOgp2WvF5sXEK2Lv/O97Gr+n0Jr9bHA6GxEGqYOCo4uFO5DcX4e/fd6kKDav18FW9H29iUD49gebcWrEYKQNOy8e8FVjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MLV8QkqG; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-57d07673185so881976a12.1;
        Thu, 20 Jun 2024 07:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718894690; x=1719499490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=atAjC4pVJ1zE+1cO85vpLr2442FgmFpzRcvGU9579hs=;
        b=MLV8QkqGxhYSsV8FkFDCFWUxml5BqK4mzqjWShH5Ki+K0jIbxozgP1w6DabSDiHIhC
         t4wUs3DBDNJC+wUlD4/23Pyt7pkAlQh4aUndTNLJefdGEAXeVSwO3Dej9cMMOy6hlj3/
         IcYf6mVeY52HjiBgqhusfgZ6WHRCkU16MW11xH2BINeTmBHMOxhAUfuj71pkqubnk35U
         pHIzUrlqgtOs/N4MdTjtS+LbQX21OASPKqhRqd+LWMJsQ8fPDMLKCmkA/2POBFLR8AkU
         xqFD5jMc3SwOEFx/6eAo+bvN7UuYg1/0Bkjuuo8ED8o68UYj3lTfJO+VmVfAbfkG6w6V
         /Spw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718894690; x=1719499490;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=atAjC4pVJ1zE+1cO85vpLr2442FgmFpzRcvGU9579hs=;
        b=YJZHyWJ6JbbOYLF7lejFk29VHJLOpJoSbe7XZCndh1LPpJD32wKyykKN7r5HbUgPD+
         UM+b+6xKdLvqUiEbNuSlwxXxSSp5bpwbbNMbiFgqL/B5I8z6jNTVS28xX/kWg6oWHDQB
         n/5kQR4mKOZ60zBXqAKuRhx3/bY9raQgdcPJQey/rVv3oteh888HzN0OFXuCIXYfwYon
         f/2kLyk4A8NngdGXW8A+U6WWZRZRJAE3l0EQ7PsBkNx2TyyyIBumvcu+AUoJYKhBBON+
         JGWIJVP2POPCa5FNl1aQlbf56NTBJJHsPnjpZsN35R6q3iO72uFcmEFpsJeYHNi1duZP
         oyYg==
X-Forwarded-Encrypted: i=1; AJvYcCVJeEWrSC8IyOs+bPp2xgkGcm9hvVeUOqhpQGbI5T3CnSgqkaULIxhzF5b0EUkJ4r+2AqjOBn5l+RxTWcEbPniVW1L2+Ugr9G6wJhOWIHB4ECq9Y0IET0czdVZ8P5WgPyy4K3rlUXNuKJAfNgBE9ioVPQqDnQj9bfqo5LbLYXwWHzxWsgI=
X-Gm-Message-State: AOJu0YywKPq8aC2OYZ8iGqqofpBOXxPmrQaKUYKydsbR8TpT/gKAKu9V
	WK24v8FBpySHeR5YkcHh1KbgOcFzRq8gxdSV+vxnfcIky4tg1TpBCbxtc3Ct
X-Google-Smtp-Source: AGHT+IFtKSrOtcZ+BEcZiCSv7+wwC7t2l20tBF8LT1Ij3BSgETCQ5kBXKzUH0OrPPiRXvyheF+CN2Q==
X-Received: by 2002:a50:bac3:0:b0:57c:7151:2669 with SMTP id 4fb4d7f45d1cf-57d07e1792bmr3108340a12.7.1718894690107;
        Thu, 20 Jun 2024 07:44:50 -0700 (PDT)
Received: from iris-Ian.fritz.box (p200300eb5f2e9b00caea2d1d6a49249f.dip0.t-ipconnect.de. [2003:eb:5f2e:9b00:caea:2d1d:6a49:249f])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb741e782sm9706982a12.64.2024.06.20.07.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 07:44:49 -0700 (PDT)
From: iansdannapel@gmail.com
To: mdf@kernel.org,
	hao.wu@intel.com,
	yilun.xu@intel.com,
	trix@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-fpga@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ian Dannapel <iansdannapel@gmail.com>
Subject: [PATCH 2/3] dt-bindings: fpga: Add Efinix serial SPI programming binding description
Date: Thu, 20 Jun 2024 16:44:40 +0200
Message-Id: <20240620144440.125374-1-iansdannapel@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ian Dannapel <iansdannapel@gmail.com>

Add device tree binding documentation for configuring Efinix FPGA
using serial SPI passive programming mode.

Signed-off-by: Ian Dannapel <iansdannapel@gmail.com>
---
 .../bindings/fpga/efnx,fpga-passive-spi.yaml  | 76 +++++++++++++++++++
 1 file changed, 76 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fpga/efnx,fpga-passive-spi.yaml

diff --git a/Documentation/devicetree/bindings/fpga/efnx,fpga-passive-spi.yaml b/Documentation/devicetree/bindings/fpga/efnx,fpga-passive-spi.yaml
new file mode 100644
index 000000000000..855ceb3b89e8
--- /dev/null
+++ b/Documentation/devicetree/bindings/fpga/efnx,fpga-passive-spi.yaml
@@ -0,0 +1,76 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/fpga/efnx,fpga-passive-spi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Efinix SPI FPGA Manager
+
+description: |
+  Efinix Trion and Titanium Series FPGAs support a method of loading the
+  bitstream over what is referred to as "SPI Passive Programming".
+  Only serial (1x bus width) is supported, setting the programming mode
+  is not in the scope the this manager and must be done elsewhere.
+
+  References:
+  - https://www.efinixinc.com/docs/an033-configuring-titanium-fpgas-v2.6.pdf
+  - https://www.efinixinc.com/docs/an006-configuring-trion-fpgas-v6.0.pdf
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    enum:
+      - efnx,fpga-spi-passive
+
+  spi-cpha: true
+  spi-cpol: true
+
+  spi-max-frequency:
+    maximum: 25000000
+
+  reg:
+    maxItems: 1
+
+  reset-gpios:
+    description:
+      reset pin (low active)
+    maxItems: 1
+
+  cs-gpios:
+    description:
+      chip-select pin (low active)
+    maxItems: 1
+
+  done-gpios:
+    description:
+      optional programming done pin, referred as CDONE (high active)
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - reset-gpios
+  - cs-gpios
+
+additionalProperties: false
+
+examples:
+  - |
+    &spi2 {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      fpga_mgr_spi: fpga-mgr@0 {
+        compatible = "efnx,fpga-spi-passive";
+        spi-max-frequency = <25000000>;
+        spi-cpha;
+        spi-cpol;
+        reg = <0>;
+        reset-gpios = <&gpio4 17 GPIO_ACTIVE_LOW>;
+        cs-gpios = <&gpio5 13 GPIO_ACTIVE_LOW>;
+        done-gpios = <&gpio0 9 GPIO_ACTIVE_HIGH>;
+      };
+    };
+...
-- 
2.34.1



Return-Path: <linux-fpga+bounces-998-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85BADA18B83
	for <lists+linux-fpga@lfdr.de>; Wed, 22 Jan 2025 06:59:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF5B33ABF12
	for <lists+linux-fpga@lfdr.de>; Wed, 22 Jan 2025 05:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B1D192B66;
	Wed, 22 Jan 2025 05:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T6QCP1KW"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CBA1B21BD;
	Wed, 22 Jan 2025 05:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737525539; cv=none; b=aY1bpLMlkAfAuELA3HnoyF6EHhcdy7upATG8P8nyTjs2PTyyVCECvlWXzgWiFTYAoHru5onKf8wSDW9ok4t1FsJ0hYNFnYVDcAlA+qii73U/balQwyEXYsuLVx4Nx8IghoqGN+fYo7/qZ+OpWFQsqoXvAi3paca28Znp28hofig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737525539; c=relaxed/simple;
	bh=BJQO0qdpzO4wnUrw1TLDsZZtcTqKgIqADSc+Uvw68x8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p99rvOW3cPIsDd6AxIy5j3Xd3kk8jW66k2sxYnFzxvfGNs+bDU5ZyrcyEidp5vsR1BmPRsrmN2E80lojn96zGArtqiR4JIl8GoIZmeevc98J/Uqc+z49KPo/WOntJNM4B0RWNNloSF7uEsV0QjfyscQH+f5emrV7Q1YL2uzVemc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T6QCP1KW; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737525537; x=1769061537;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=BJQO0qdpzO4wnUrw1TLDsZZtcTqKgIqADSc+Uvw68x8=;
  b=T6QCP1KW1/wnuPhEscDSbEQSLXDVi+I6taHPHRlqihzFWirCLXqnFFvR
   CJBVjrWyHCzwgtt/Ac2MG+yPWTq8ZADNt8jLFJoEH2PKeCo0KOpUj6hew
   e4aCud87Cb1CqrqhsBlphj5Ce7B4D1xPgFq3ExGsHrqMVKkViwoBVrvdJ
   GQd2I+J6gnIJ1EC42ri1Bqsg0eS0c07sRGCT1X3acDLs51RW3TilMUo1M
   HnhH9fu0FJ7ofis9DMVt0QdrtX8CPzPMz+iP7Wsl8HfGCRa70ZsGjNDeA
   Hm9+zOO/iZkCJwFjPtNBls3r26zm0HvemKoiT2FHqtt/JCIyyEbHzjp11
   Q==;
X-CSE-ConnectionGUID: Het1PIs8RMiV2V3e0QJz0g==
X-CSE-MsgGUID: P0YMz1ANT8OwLbeViuM28w==
X-IronPort-AV: E=McAfee;i="6700,10204,11322"; a="55381135"
X-IronPort-AV: E=Sophos;i="6.13,224,1732608000"; 
   d="scan'208";a="55381135"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2025 21:58:57 -0800
X-CSE-ConnectionGUID: oYKFYFZjSwun8VQFHncd6Q==
X-CSE-MsgGUID: SccH6Ad2TiCRkA5cR4auuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,224,1732608000"; 
   d="scan'208";a="106851743"
Received: from apgc00009.png.altera.com ([10.244.70.6])
  by fmviesa006.fm.intel.com with ESMTP; 21 Jan 2025 21:58:53 -0800
From: Mahesh Rao <mahesh.rao@intel.com>
Date: Wed, 22 Jan 2025 13:58:44 +0800
Subject: [PATCH 2/3] dt-bindings: firmware: stratix10: Convert to
 json-schema
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250122-socfpga_sip_svc_misc-v1-2-cbdcd034ae34@intel.com>
References: <20250122-socfpga_sip_svc_misc-v1-0-cbdcd034ae34@intel.com>
In-Reply-To: <20250122-socfpga_sip_svc_misc-v1-0-cbdcd034ae34@intel.com>
To: Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>, 
 Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-fpga@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mahesh Rao <mahesh.rao@altera.com>, 
 Mahesh Rao <mahesh.rao@intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737525526; l=6082;
 i=mahesh.rao@intel.com; s=20250107; h=from:subject:message-id;
 bh=BJQO0qdpzO4wnUrw1TLDsZZtcTqKgIqADSc+Uvw68x8=;
 b=4plAXuYMeUcoLn2dDDOXi3mHUSmvBBiybXdNiytJhTTc6ks8FmeUBDZ7Lv3pRB4LMwH807peX
 Ojm+zMQcT8wAxhm5NNRAosZYD1h33PbeJggmuEOZTCaKeLkqd6641BN
X-Developer-Key: i=mahesh.rao@intel.com; a=ed25519;
 pk=tQiFUzoKxHrQLDtWeEeaeTeJTl/UfclUHWZy1fjSiyg=

Convert intel,stratix10-svc service layer devicetree
binding file from freeform format to json-schema.

Signed-off-by: Mahesh Rao <mahesh.rao@intel.com>
---
 .../bindings/firmware/intel,stratix10-svc.txt      | 57 ---------------
 .../bindings/firmware/intel,stratix10-svc.yaml     | 84 ++++++++++++++++++++++
 2 files changed, 84 insertions(+), 57 deletions(-)

diff --git a/Documentation/devicetree/bindings/firmware/intel,stratix10-svc.txt b/Documentation/devicetree/bindings/firmware/intel,stratix10-svc.txt
deleted file mode 100644
index 6eff1afd8daf91714d6a18859667d2607e707da7..0000000000000000000000000000000000000000
--- a/Documentation/devicetree/bindings/firmware/intel,stratix10-svc.txt
+++ /dev/null
@@ -1,57 +0,0 @@
-Intel Service Layer Driver for Stratix10 SoC
-============================================
-Intel Stratix10 SoC is composed of a 64 bit quad-core ARM Cortex A53 hard
-processor system (HPS) and Secure Device Manager (SDM). When the FPGA is
-configured from HPS, there needs to be a way for HPS to notify SDM the
-location and size of the configuration data. Then SDM will get the
-configuration data from that location and perform the FPGA configuration.
-
-To meet the whole system security needs and support virtual machine requesting
-communication with SDM, only the secure world of software (EL3, Exception
-Layer 3) can interface with SDM. All software entities running on other
-exception layers must channel through the EL3 software whenever it needs
-service from SDM.
-
-Intel Stratix10 service layer driver, running at privileged exception level
-(EL1, Exception Layer 1), interfaces with the service providers and provides
-the services for FPGA configuration, QSPI, Crypto and warm reset. Service layer
-driver also manages secure monitor call (SMC) to communicate with secure monitor
-code running in EL3.
-
-Required properties:
--------------------
-The svc node has the following mandatory properties, must be located under
-the firmware node.
-
-- compatible: "intel,stratix10-svc" or "intel,agilex-svc"
-- method: smc or hvc
-        smc - Secure Monitor Call
-        hvc - Hypervisor Call
-- memory-region:
-	phandle to the reserved memory node. See
-	Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
-	for details
-
-Example:
--------
-
-	reserved-memory {
-                #address-cells = <2>;
-                #size-cells = <2>;
-                ranges;
-
-                service_reserved: svcbuffer@0 {
-                        compatible = "shared-dma-pool";
-                        reg = <0x0 0x0 0x0 0x1000000>;
-                        alignment = <0x1000>;
-                        no-map;
-                };
-        };
-
-	firmware {
-		svc {
-			compatible = "intel,stratix10-svc";
-			method = "smc";
-			memory-region = <&service_reserved>;
-		};
-	};
diff --git a/Documentation/devicetree/bindings/firmware/intel,stratix10-svc.yaml b/Documentation/devicetree/bindings/firmware/intel,stratix10-svc.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..b8aae996da87c16007efa7e5e12cced1432b62e9
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/intel,stratix10-svc.yaml
@@ -0,0 +1,84 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/firmware/intel,stratix10-svc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Intel Service Layer Driver for Stratix10 SoC
+
+maintainers:
+  - Dinh Nguyen <dinguyen@kernel.org>
+
+description: |
+  Intel Stratix10 SoC is composed of a 64 bit quad-core ARM Cortex A53 hard
+  processor system (HPS) and Secure Device Manager (SDM). When the FPGA is
+  configured from HPS, there needs to be a way for HPS to notify SDM the
+  location and size of the configuration data. Then SDM will get the
+  configuration data from that location and perform the FPGA configuration.
+
+  To meet the whole system security needs and support virtual machine requesting
+  communication with SDM, only the secure world of software (EL3, Exception
+  Layer 3) can interface with SDM. All software entities running on other
+  exception layers must channel through the EL3 software whenever it needs
+  service from SDM.
+
+  Intel Stratix10 service layer driver, running at privileged exception level
+  (EL1, Exception Layer 1), interfaces with the service providers and provides
+  the services for FPGA configuration, QSPI, Crypto and warm reset. Service layer
+  driver also manages secure monitor call (SMC) to communicate with secure monitor
+  code running in EL3.
+
+properties:
+  compatible:
+    enum:
+      - intel,stratix10-svc
+      - intel,agilex-svc
+
+  method:
+    enum: [smc, hvc]
+    description: supervisory call method to be used for the service layer.
+
+  memory-region:
+    maxItems: 1
+    description:
+      phandle to a reserved memory region for the service layer driver to
+      communicate with the secure device manager. For more details see
+      Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt.
+
+  fpga-mgr:
+    $ref: /schemas/fpga/intel,stratix10-soc-fpga-mgr.yaml
+    description: Optional child node for fpga manager to perform fabric configuration.
+
+required:
+  - compatible
+  - method
+  - memory-region
+
+additionalProperties: false
+
+examples:
+  - |
+    reserved-memory {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      service_reserved: svcbuffer@0 {
+              compatible = "shared-dma-pool";
+              reg = <0x0 0x0 0x0 0x1000000>;
+              alignment = <0x1000>;
+              no-map;
+      };
+    };
+
+    firmware {
+      svc {
+        compatible = "intel,stratix10-svc";
+        method = "smc";
+        memory-region = <&service_reserved>;
+
+        fpga-mgr {
+          compatible = "intel,stratix10-soc-fpga-mgr";
+        };
+      };
+    };
+

-- 
2.35.3



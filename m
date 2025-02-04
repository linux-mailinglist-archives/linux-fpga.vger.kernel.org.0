Return-Path: <linux-fpga+bounces-1035-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC14A272A7
	for <lists+linux-fpga@lfdr.de>; Tue,  4 Feb 2025 14:22:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8CC21886EDE
	for <lists+linux-fpga@lfdr.de>; Tue,  4 Feb 2025 13:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD232153E7;
	Tue,  4 Feb 2025 12:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h82qOsB1"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DB1212D83;
	Tue,  4 Feb 2025 12:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738673910; cv=none; b=rwcfb8Wv52yG84+DwaZzmUGdFLkyvtlIobn74AoaCt0snuDQ/M5HEmRaX8cMyZiAJ8uXNU9ALoXtEsCIGYwpj/WOcwxzIKYdZwQIj2IbvAlrGarQr1qHoTd45H+rohVDohQrJrxTVHMxOLpojw6ddFsxnX7QuzOxM8YK0R23IKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738673910; c=relaxed/simple;
	bh=mkjBwDH3jRDkTTR0sd3jiLgzDZuZjSG6SUey1iRkwiY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HduV/cGKOfssfdVjH895Us3Y4d+LZnayOneiOptmA4yKVsnwDDizKoHMfsznmtSizxOIdI/WN7da1Z+zfX/jWD7bac78Dd9iProU/FJbSgmde1ZuplHMPsliSVbVWzwv1MUKTOfXgSJUwCmmqafbDCZ+xjwmPKIvI1+baZFQNPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h82qOsB1; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738673908; x=1770209908;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=mkjBwDH3jRDkTTR0sd3jiLgzDZuZjSG6SUey1iRkwiY=;
  b=h82qOsB1YEtAouCfqzH5HNlyrB6mR7zeTWcLi1FNYptzOlo6rnLVzx0i
   efCsGFsw3yea0cQnG9zrvnICNoD1C+rI/DsJbJnnJlAUly/GZyks8YgFw
   p05SYSH2JMi6CWHg0ZIQYZObHjFqjiUOV6Tl0j2Z19SpKaCoMscqHeSU+
   ioF+WY2oxk7M74jL+OvvNDsrZYYP+KCVwNbgUbSHEus3dneWuOyPYZvJU
   WigC91bWSWLJYqDEjFV/X7wazvTobuxmgoRQ3cYVhey7XvCDw9pt3t54s
   lBqx0msagmiQxYKsv1xAktpJ9+SKpy4GECRKf+AlOzZdHS3FrsQh+MVdL
   g==;
X-CSE-ConnectionGUID: VooJ8yMET2aotmXMua6Q7g==
X-CSE-MsgGUID: 9qPiaz11T0mPLOGLYNN+7Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39096993"
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; 
   d="scan'208";a="39096993"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 04:58:28 -0800
X-CSE-ConnectionGUID: r6P4jrbzQq2hX9L8Sfnrsg==
X-CSE-MsgGUID: m/t1IqkjRJ6cSdlN1A4NKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="133834304"
Received: from apgcp0c531115.png.altera.com ([10.244.76.209])
  by fmviesa002.fm.intel.com with ESMTP; 04 Feb 2025 04:58:24 -0800
From: Mahesh Rao <mahesh.rao@intel.com>
Date: Tue, 04 Feb 2025 20:58:06 +0800
Subject: [PATCH v3 2/3] dt-bindings: firmware: stratix10: Convert to
 json-schema
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250204-socfpga_sip_svc_misc-v3-2-697f7f153cfa@intel.com>
References: <20250204-socfpga_sip_svc_misc-v3-0-697f7f153cfa@intel.com>
In-Reply-To: <20250204-socfpga_sip_svc_misc-v3-0-697f7f153cfa@intel.com>
To: Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>, 
 Tom Rix <trix@redhat.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Wu Hao <hao.wu@intel.com>, Ho Yin <adrian.ho.yin.ng@altera.com>, 
 Niravkumar L Rabara <nirav.rabara@altera.com>
Cc: linux-fpga@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mahesh Rao <mahesh.rao@altera.com>, 
 Mahesh Rao <mahesh.rao@intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738673895; l=6327;
 i=mahesh.rao@intel.com; s=20250107; h=from:subject:message-id;
 bh=mkjBwDH3jRDkTTR0sd3jiLgzDZuZjSG6SUey1iRkwiY=;
 b=XVJL0IJAmPWojBwCaXLyBNImwkjARNuZGefSrPthZtWuBWHOT3qRB5JKdcE4XIcAXQNNHoDci
 IWd5rSdb8OmBcY7vW7TMbCPZEFAGPX/EjGAXJMRxaqmB6F5+A9ZlmrI
X-Developer-Key: i=mahesh.rao@intel.com; a=ed25519;
 pk=tQiFUzoKxHrQLDtWeEeaeTeJTl/UfclUHWZy1fjSiyg=

Convert intel,stratix10-svc service layer devicetree
binding file from freeform format to json-schema.

Also added DT binding for optional stratix10-soc
FPGA manager child node.

Signed-off-by: Mahesh Rao <mahesh.rao@intel.com>
---
 .../bindings/firmware/intel,stratix10-svc.txt      | 57 -------------
 .../bindings/firmware/intel,stratix10-svc.yaml     | 93 ++++++++++++++++++++++
 2 files changed, 93 insertions(+), 57 deletions(-)

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
index 0000000000000000000000000000000000000000..fac1e955852e4f9b966c991dcfac56222c5f7315
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/intel,stratix10-svc.yaml
@@ -0,0 +1,93 @@
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
+  - Mahesh Rao <mahesh.rao@altera.com>
+
+description: >
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
+    description: |
+      Supervisory call method to be used to communicate with the
+      secure service layer.
+      Permitted values are:
+      - "smc" : SMC #0, following the SMCCC
+      - "hvc" : HVC #0, following the SMCCC
+
+    $ref: /schemas/types.yaml#/definitions/string-array
+    enum:
+      - smc
+      - hvc
+
+  memory-region:
+    maxItems: 1
+    description:
+      reserved memory region for the service layer driver to
+      communicate with the secure device manager.
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



Return-Path: <linux-fpga+bounces-1026-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EECA6A23C18
	for <lists+linux-fpga@lfdr.de>; Fri, 31 Jan 2025 11:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8E397A411B
	for <lists+linux-fpga@lfdr.de>; Fri, 31 Jan 2025 10:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886CD1AF0DB;
	Fri, 31 Jan 2025 10:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k9pXc82m"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867BD1B21A9;
	Fri, 31 Jan 2025 10:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738318668; cv=none; b=jvKhMl76bfeScd+Fo79VCfop9JMf5nXiC7ICOEXMad80L7Xt4F2amwC767lZREnu2H/df0IryENPksD15plpqLdEr1zLteDUf0EsNiaZL7w35ctIGOO34QKiS2SWZfZCClnB1nUqe61GWzIkCfGKSv5pHq+GR77/3GzEsb7ThVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738318668; c=relaxed/simple;
	bh=GHqdxg2DS4YgMXOLBGV+kcxzA37+EhGXDzEY8PqyFNc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b6LP1oRGwiCjiFisgybyrDAmGQjNBwjDWoHvX5KoHoycBiK0wLPe9DfRgR5OQj3U9pr0kFcWFUAOe5S378Dtl/hESfbYxkiSDw/r5X5abcFP5F8JOwVyyZ8L8ROdwZ4aBHQiLlZnKGjysiSCQG2nhEOwXjDpOX5VahSNO1cAfpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k9pXc82m; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738318666; x=1769854666;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=GHqdxg2DS4YgMXOLBGV+kcxzA37+EhGXDzEY8PqyFNc=;
  b=k9pXc82mrMKA99+b7vBOjwOK9D2F2ncA9DGW+dRh08ZcPVLOJBUB4Ar8
   00d4FqbjP3tv1AyAwzCo7Dn0qgk+RY64irA8RIcN2qAFec1+5R9KoiWZ5
   jMBZALV/KS2ObZx2We1bW0vCqeVuVGH8YmZZAnQt6EuOTUnXvC5OBxiwT
   lk1+mNroTGcWr53FtPsa5l+2upoFfMQjTvUMDogdK6MyUeaLR7BiV5ZXQ
   LXT60eOr6VsRrZBO0xZujveS9cvney4jUmIwCAFjMG6sV84YxnFqXQq+I
   gYA7hOrVqMOSWKEG83/+6dXqEM/1qDMoYi+PmxCc2L/Iongf25RASYrY7
   A==;
X-CSE-ConnectionGUID: Uz3gprILTMOKSd1+2taMuA==
X-CSE-MsgGUID: l05qj0fAQmycJVMXGWiOVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11331"; a="38777229"
X-IronPort-AV: E=Sophos;i="6.13,248,1732608000"; 
   d="scan'208";a="38777229"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2025 02:17:46 -0800
X-CSE-ConnectionGUID: fSlTFxgYSjy+Ibj3KPWtCQ==
X-CSE-MsgGUID: geB1Eg7lTV2pAEz49PYfrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,248,1732608000"; 
   d="scan'208";a="114596196"
Received: from apgcp0c531115.png.altera.com ([10.244.76.209])
  by fmviesa004.fm.intel.com with ESMTP; 31 Jan 2025 02:17:43 -0800
From: Mahesh Rao <mahesh.rao@intel.com>
Date: Fri, 31 Jan 2025 18:17:25 +0800
Subject: [PATCH v2 2/3] dt-bindings: firmware: stratix10: Convert to
 json-schema
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250131-socfpga_sip_svc_misc-v2-2-eeed4ebc35f9@intel.com>
References: <20250131-socfpga_sip_svc_misc-v2-0-eeed4ebc35f9@intel.com>
In-Reply-To: <20250131-socfpga_sip_svc_misc-v2-0-eeed4ebc35f9@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738318654; l=6493;
 i=mahesh.rao@intel.com; s=20250107; h=from:subject:message-id;
 bh=GHqdxg2DS4YgMXOLBGV+kcxzA37+EhGXDzEY8PqyFNc=;
 b=UEjLxJvCLnLJnSpySaCufDdLJcmx7nX/CzJTkrWWMoFMQ+zWscduEZITxa+T4HwC2L6ATQl6L
 MRahfK32CO9Ctnqj/uiNibiGkX5PmQSQrG1yaFjPIVqQzNzaHMChCgS
X-Developer-Key: i=mahesh.rao@intel.com; a=ed25519;
 pk=tQiFUzoKxHrQLDtWeEeaeTeJTl/UfclUHWZy1fjSiyg=

Convert intel,stratix10-svc service layer devicetree
binding file from freeform format to json-schema.

Also added DT binding for optional stratix10-soc
FPGA manager child node.

Signed-off-by: Mahesh Rao <mahesh.rao@intel.com>
---
 .../bindings/firmware/intel,stratix10-svc.txt      | 57 -------------
 .../bindings/firmware/intel,stratix10-svc.yaml     | 94 ++++++++++++++++++++++
 2 files changed, 94 insertions(+), 57 deletions(-)

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
index 0000000000000000000000000000000000000000..e30e79d4c3150f90993e728320e9ef90d484a10d
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/intel,stratix10-svc.yaml
@@ -0,0 +1,94 @@
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
+description:
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
+                 Supervisory call method to be used to communicate with the
+                 secure service layer.
+                 Permitted values are:
+                 - "smc" : SMC #0, following the SMCCC
+                 - "hvc" : HVC #0, following the SMCCC
+
+    $ref: /schemas/types.yaml#/definitions/string-array
+    enum:
+      - smc
+      - hvc
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



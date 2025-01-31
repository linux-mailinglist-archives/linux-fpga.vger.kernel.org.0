Return-Path: <linux-fpga+bounces-1025-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 938A2A23C13
	for <lists+linux-fpga@lfdr.de>; Fri, 31 Jan 2025 11:17:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8930C3A5DC6
	for <lists+linux-fpga@lfdr.de>; Fri, 31 Jan 2025 10:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1721AF0B4;
	Fri, 31 Jan 2025 10:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AsSZtwRI"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0A116EB7C;
	Fri, 31 Jan 2025 10:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738318664; cv=none; b=kN+5/BpMjRNynRGoaV1uL5oppRwZYlPXaCGSwk1JzErqoLMNmW5EEhUpjJU+1y81dIPNmLaW9Elm1DDEpYgf3/jhD4YOAMK09B86l2gJF64uFMiZmTwEtpJ492uqukzX+8KEjtDOFJVmf30OY6MnvEWVCXdgp1STD2vcSuXOcR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738318664; c=relaxed/simple;
	bh=xIvHbDqiEdk2VI7vzbiKbjtJ5iQ7i2K3SPDh9KKxMFc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IWjSKTu0K+7BihpK5IGaQy85UWQOqDdqZvBArsR27OPjBBcOfCCS1nJ1sLqI4fs9SCGB/NOd6fITbBDKkIrAnGi/lz0+uGaT809W9lRmu0/oC1r0u3HzePJ7JGARj8gcgHuY7+adpePdMLJafMQbY4LjU3ihpkqZqcMYynknWiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AsSZtwRI; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738318662; x=1769854662;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=xIvHbDqiEdk2VI7vzbiKbjtJ5iQ7i2K3SPDh9KKxMFc=;
  b=AsSZtwRI8Xt8PfsC41/cVAPyA0AKd6xY8Ytoj3Gx6KtHOkctUgLdH0td
   HsbYzCeJWs9Fq/9ILyOXWV252GXYldSxRlCcpaYjOjMWoQiMVk1MXkU7a
   Cip+/7Tbzo5HRfzdJ4z4cVmKs9gQ9jTyo9Pnqgfa+T5h+Xesmaw5DJBY3
   NWS3vIZTKezKoDJzERG9DzeC1dMR+9vuwmxpU4GyOKm3s79/NfETM9YKb
   oymfT/ozu3TY1dke4NUyhbDcLlct3KaDonrRUu1yS1aHgoV1GivYHOQpx
   xYqhnhaJMbhD1sVh8enzxNltbV+C2A9zf68YMufNFOmzMTnmRQ7MBE6Dl
   Q==;
X-CSE-ConnectionGUID: CSKelIg1TF+8izBjE3IJ1w==
X-CSE-MsgGUID: xYn8YRPfTUOsDd7lrjrCbQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11331"; a="38777220"
X-IronPort-AV: E=Sophos;i="6.13,248,1732608000"; 
   d="scan'208";a="38777220"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2025 02:17:42 -0800
X-CSE-ConnectionGUID: i+VoEgvYQriJ/BYpEZlObg==
X-CSE-MsgGUID: N4C1nKNtTtW4A8eX6s+MQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,248,1732608000"; 
   d="scan'208";a="114596183"
Received: from apgcp0c531115.png.altera.com ([10.244.76.209])
  by fmviesa004.fm.intel.com with ESMTP; 31 Jan 2025 02:17:39 -0800
From: Mahesh Rao <mahesh.rao@intel.com>
Date: Fri, 31 Jan 2025 18:17:24 +0800
Subject: [PATCH v2 1/3] dt-bindings: fpga: stratix10: Convert to
 json-schema
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250131-socfpga_sip_svc_misc-v2-1-eeed4ebc35f9@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738318654; l=2648;
 i=mahesh.rao@intel.com; s=20250107; h=from:subject:message-id;
 bh=xIvHbDqiEdk2VI7vzbiKbjtJ5iQ7i2K3SPDh9KKxMFc=;
 b=QnUTHXZLPs6LywnCnvHz1YXuqCAAxbOmQo0NLfsIoNdDq3SqoVeRPgtXYgJSA3KfGJjE5qcTQ
 AGoJtwArxxgCggm+jyBdjnsbTlltpf6RdhXFiga2hjw28MiNrSz7TnV
X-Developer-Key: i=mahesh.rao@intel.com; a=ed25519;
 pk=tQiFUzoKxHrQLDtWeEeaeTeJTl/UfclUHWZy1fjSiyg=

Convert intel,stratix10-soc fpga manager devicetree
binding file from freeform format to json-schema.

Signed-off-by: Mahesh Rao <mahesh.rao@intel.com>
---
 .../fpga/intel,stratix10-soc-fpga-mgr.yaml         | 36 ++++++++++++++++++++++
 .../bindings/fpga/intel-stratix10-soc-fpga-mgr.txt | 18 -----------
 2 files changed, 36 insertions(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/fpga/intel,stratix10-soc-fpga-mgr.yaml b/Documentation/devicetree/bindings/fpga/intel,stratix10-soc-fpga-mgr.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..6e536d6b28a9732c492da5d57f89df648dba7f4b
--- /dev/null
+++ b/Documentation/devicetree/bindings/fpga/intel,stratix10-soc-fpga-mgr.yaml
@@ -0,0 +1,36 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/fpga/intel,stratix10-soc-fpga-mgr.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Intel Stratix10 SoC FPGA Manager
+
+maintainers:
+  - Mahesh Rao <mahesh.rao@altera.com>
+  - Adrian Ng Ho Yin <adrian.ho.yin.ng@altera.com>
+  - Niravkumar L Rabara <nirav.rabara@altera.com>
+
+description:
+  The Intel Stratix10 SoC consists of a 64-bit quad-core ARM Cortex A53 hard
+  processor system (HPS) and a Secure Device Manager (SDM). The Stratix10
+  SoC FPGA Manager driver is used to configure/reconfigure the FPGA fabric
+  on the die.The driver communicates with SDM/ATF via the stratix10-svc
+  platform driver for performing its operations.
+
+properties:
+  compatible:
+    enum:
+      - intel,stratix10-soc-fpga-mgr
+      - intel,agilex-soc-fpga-mgr
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    fpga-mgr {
+      compatible = "intel,stratix10-soc-fpga-mgr";
+    };
diff --git a/Documentation/devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt b/Documentation/devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt
deleted file mode 100644
index 0f874137ca4697820341b23eddb882634bb131d1..0000000000000000000000000000000000000000
--- a/Documentation/devicetree/bindings/fpga/intel-stratix10-soc-fpga-mgr.txt
+++ /dev/null
@@ -1,18 +0,0 @@
-Intel Stratix10 SoC FPGA Manager
-
-Required properties:
-The fpga_mgr node has the following mandatory property, must be located under
-firmware/svc node.
-
-- compatible : should contain "intel,stratix10-soc-fpga-mgr" or
-	       "intel,agilex-soc-fpga-mgr"
-
-Example:
-
-	firmware {
-		svc {
-			fpga_mgr: fpga-mgr {
-				compatible = "intel,stratix10-soc-fpga-mgr";
-			};
-		};
-	};

-- 
2.35.3



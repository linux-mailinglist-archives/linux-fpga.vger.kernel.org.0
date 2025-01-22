Return-Path: <linux-fpga+bounces-997-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F4170A18B7F
	for <lists+linux-fpga@lfdr.de>; Wed, 22 Jan 2025 06:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADBDF7A32DC
	for <lists+linux-fpga@lfdr.de>; Wed, 22 Jan 2025 05:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA781AC892;
	Wed, 22 Jan 2025 05:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vnl/W48c"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3832199384;
	Wed, 22 Jan 2025 05:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737525535; cv=none; b=YiI+5i0aTEYh047yMpqkuUyJ6f5n6cJusXMHZo7k6QHcmH7Gj/VN8PvC1pFsRzll3r0bFumuIDj/qKUKUClfw6VBkvVUocIBWtCTE7uKM/cMhF7+XnIpsT6TY4sTvTDp8Q6u1E8KGVWdsXAUXCjNVFnapZn3bGBsXz1sX1tFFY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737525535; c=relaxed/simple;
	bh=nVqNbeosntrJCyZgs2kQPJbHtJoOIeIK4d1BOT+/l5Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cVPOJB15DxL6VS26weAEqI9oPiZnCbL+jno5pKPn7USTU2ZPEmpmh+3tH9VF1XXLXJ+FwpMA3bk5gE/VMWSuU58S6tZeK5EWerKPb6ABgRdKVgnE2WyFDIfuoQlSifxD5G94L4gip3GLwg7Yi3GN/XU+kFQXObKXyK2ViTtFAjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vnl/W48c; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737525534; x=1769061534;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=nVqNbeosntrJCyZgs2kQPJbHtJoOIeIK4d1BOT+/l5Y=;
  b=Vnl/W48cMmRLR5b3Cb1i6sPk5VSGRW1GrxzwgbZ08HL2DpPEOcakEdE4
   h+Eyz3bCb7Fy6zcyD8UAAmiHXmPpraCHzpE61s5vXIWht6y+UUdH+XqCj
   MsUOenj7HxTBQj3WtEjTvpY0XeWixQHn1iagmugvkTOYXtg9cLl3Kwip2
   mJ72cqO324U6qO+BYFE2BhWrVfLBLepm92cARZz02p3uDaXj5NyvbxYE0
   cujWgPnR7hecGA01te3LTIx1ALeLczcvA5kEHj9YxQJfjEvmldGQJhdYt
   95xX7Hh92xV9XoyQanJSw9hWxnR7323ZU1zO0M1Ijj5EipbVXkBEFw1lq
   A==;
X-CSE-ConnectionGUID: DjggtGkZRO2SjcWD65ZN/g==
X-CSE-MsgGUID: XPp5z07XSRWT7BFjubNHJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11322"; a="55381130"
X-IronPort-AV: E=Sophos;i="6.13,224,1732608000"; 
   d="scan'208";a="55381130"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2025 21:58:53 -0800
X-CSE-ConnectionGUID: 4t1rCwJvQBCY4v2hXthQMA==
X-CSE-MsgGUID: mNtU/TyLR2Gx/K41yCLsPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,224,1732608000"; 
   d="scan'208";a="106851728"
Received: from apgc00009.png.altera.com ([10.244.70.6])
  by fmviesa006.fm.intel.com with ESMTP; 21 Jan 2025 21:58:50 -0800
From: Mahesh Rao <mahesh.rao@intel.com>
Date: Wed, 22 Jan 2025 13:58:43 +0800
Subject: [PATCH 1/3] dt-bindings: fpga: stratix10: Convert to json-schema
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250122-socfpga_sip_svc_misc-v1-1-cbdcd034ae34@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737525526; l=2309;
 i=mahesh.rao@intel.com; s=20250107; h=from:subject:message-id;
 bh=nVqNbeosntrJCyZgs2kQPJbHtJoOIeIK4d1BOT+/l5Y=;
 b=0sM29CTX2K0K4M9YNT7uNXegAvONhHRNZocmoH2Ur6B7iuWB6mLbE+/vsFbRSf1ovRmjvyPRN
 6Bf2YHzaVzHBlF7dCg253erzJVj7jHYpewy0DGBmydg9kMGTdvfXp7b
X-Developer-Key: i=mahesh.rao@intel.com; a=ed25519;
 pk=tQiFUzoKxHrQLDtWeEeaeTeJTl/UfclUHWZy1fjSiyg=

Convert intel,stratix10-soc fpga manager devicetree
binding file from freeform format to json-schema.

Signed-off-by: Mahesh Rao <mahesh.rao@intel.com>
---
 .../fpga/intel,stratix10-soc-fpga-mgr.yaml         | 32 ++++++++++++++++++++++
 .../bindings/fpga/intel-stratix10-soc-fpga-mgr.txt | 18 ------------
 2 files changed, 32 insertions(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/fpga/intel,stratix10-soc-fpga-mgr.yaml b/Documentation/devicetree/bindings/fpga/intel,stratix10-soc-fpga-mgr.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..34e1bc2359672210ab69e1d5af73c4c637b7f584
--- /dev/null
+++ b/Documentation/devicetree/bindings/fpga/intel,stratix10-soc-fpga-mgr.yaml
@@ -0,0 +1,32 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/fpga/intel,stratix10-soc-fpga-mgr.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Intel Stratix10 SoC FPGA Manager
+
+maintainers:
+  - Moritz Fischer <mdf@kernel.org>
+  - Wu Hao <hao.wu@intel.com>
+  - Xu Yilun <yilun.xu@intel.com>
+
+description: |
+  Bindings for the Intel Stratix10 SoC FPGA Manager.
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



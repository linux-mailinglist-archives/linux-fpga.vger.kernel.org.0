Return-Path: <linux-fpga+bounces-1036-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 588E4A272A8
	for <lists+linux-fpga@lfdr.de>; Tue,  4 Feb 2025 14:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C550A3A6B4D
	for <lists+linux-fpga@lfdr.de>; Tue,  4 Feb 2025 13:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8EF2153EF;
	Tue,  4 Feb 2025 12:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z5mKkhMm"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5972E2135CD;
	Tue,  4 Feb 2025 12:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738673910; cv=none; b=EXStdFTLB1/nvmWeEfc47tQ1k90HQUZNIgx/DOtfj0+l5g19acpoCCZ3jGiixl+dM+GRKakZyR48OcshQN2F6HIvoeQVJtU0qpdrWxu309HZKzgvXWbvzmf/ehmTT5e4edyqK80pC9yMxR4vIVWNBYozTEktDr995fVMkf742FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738673910; c=relaxed/simple;
	bh=I8DMgUlKxN0YLFW7fIpYk765miWWiSO7x6Ir08Z+YeE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R+f/9HIDUT9ButMqoF/BDdNSfROAP+2DzxC2wnPxLzBBpPTWQqQS1akZp0UZpY1eVJ4srpNnwym6H4AqhBlz4ZcOeYoL358KGlejxr6plpPPDsIWR7O1KdzfivQFrdYQ3/Js0eL1dQQDfvMdoPAdXg9EzeBeviMlFCfwCRFTPR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z5mKkhMm; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738673909; x=1770209909;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=I8DMgUlKxN0YLFW7fIpYk765miWWiSO7x6Ir08Z+YeE=;
  b=Z5mKkhMmfwsGW5b7DgcS6kaXr87cWhJQ2qJ95x76opM4MLL8+cYhJrNP
   oG0VYUzb2ofOLNQnjIhvnQ+VzHtFz3l9k8yIAtGKoGR4gu4b9P4HB8yeX
   qTC6CmpEPunq7FdfrIOD1Pkuk6T2VASBbe7gTrd4OBVS1V+eJhxVPMMVd
   08rKMs9OqmtwZnruY8vNXeEMXUESaOFRGv6fBiFRJjhyL7e0OJJ50UQfB
   oz4mjcEee4N+jRAaoRbTmm6f4Hxrl9lzja3qPzwDExp2VMoc8KcBXXrqz
   v4dngbjWzb6Fd5vq+6XvfkQxXN2k6hhTIFP3Ycaju413v2gdXSn7NPXaL
   Q==;
X-CSE-ConnectionGUID: kOLjvJPWQ+uIQpZgTpLrWg==
X-CSE-MsgGUID: gSlYTUlpRZCBBRJDO0A9zw==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39096981"
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; 
   d="scan'208";a="39096981"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 04:58:24 -0800
X-CSE-ConnectionGUID: BroWyTuoSgKikE5YQgTpXA==
X-CSE-MsgGUID: VbVTFyJJQtCxvsK7KeJHrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="133834287"
Received: from apgcp0c531115.png.altera.com ([10.244.76.209])
  by fmviesa002.fm.intel.com with ESMTP; 04 Feb 2025 04:58:20 -0800
From: Mahesh Rao <mahesh.rao@intel.com>
Date: Tue, 04 Feb 2025 20:58:05 +0800
Subject: [PATCH v3 1/3] dt-bindings: fpga: stratix10: Convert to
 json-schema
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250204-socfpga_sip_svc_misc-v3-1-697f7f153cfa@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738673895; l=2698;
 i=mahesh.rao@intel.com; s=20250107; h=from:subject:message-id;
 bh=I8DMgUlKxN0YLFW7fIpYk765miWWiSO7x6Ir08Z+YeE=;
 b=Q37eBlhDCOqcDCxX5fUIhBab1V2DWJZ3YqBctIfwtLOmq1jDVC9+6iBzbNLet/T3ZC3EsumjV
 aaqcNyOJPrvB654MQDo3Vl5aQnCJxIuLfWaDuRom4yOO0EOQt2HRrVB
X-Developer-Key: i=mahesh.rao@intel.com; a=ed25519;
 pk=tQiFUzoKxHrQLDtWeEeaeTeJTl/UfclUHWZy1fjSiyg=

Convert intel,stratix10-soc fpga manager devicetree
binding file from freeform format to json-schema.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
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



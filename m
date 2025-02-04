Return-Path: <linux-fpga+bounces-1037-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE40A272AC
	for <lists+linux-fpga@lfdr.de>; Tue,  4 Feb 2025 14:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7A391883D64
	for <lists+linux-fpga@lfdr.de>; Tue,  4 Feb 2025 13:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2EB215792;
	Tue,  4 Feb 2025 12:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aze0gIRo"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4FB21577A;
	Tue,  4 Feb 2025 12:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738673913; cv=none; b=tFTfqxwyCRgxnc9L8D8CkBTp1+JlDoqAjOqpiPD4YqRIIaW3+z9K61b3cyaNcxPTnlUomqFs7eG1+ywBTPxXXlD5Re3ADUfwDb1SwUVVg+xjQNxrdYZt+JV5vn60S6oh+fzxHCqpOLPOVmgR3F+/DdaLYK78cvR81fD836666FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738673913; c=relaxed/simple;
	bh=jpyQ7g3vF9VLx3+P43WwCMx1CgQIacytqeT6+99h4uE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CqulO9+jCkgMkO/v1bCzWqd8L4lxetiWvp8GCGXUVQwhpN5ppHgOhqxydwCbMtLXMcSwIP4LbK8s+fCMzCAMlxvzf1d7FXwW3SlTCtxXPVdcinBE/YHvrV0Wwfy3KJ6Jv+2hOSNA9JED1/7nrXv9HIKi0W4ke9xgrUOy+d1R424=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aze0gIRo; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738673913; x=1770209913;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=jpyQ7g3vF9VLx3+P43WwCMx1CgQIacytqeT6+99h4uE=;
  b=aze0gIRo0BJHYkwAlHkIfjNy/NR+jGxjFjdJpH0tpePiJAFhpIRraU3C
   dPAohbZXZf95J3C4snEV0POdVUqEZ46rySw0TT++BcXiowgYzJjZIwNMr
   AiHSc+ggmb0wc/KORUjpc4EOFgSPFJmamJ3K+MzR0S8o/xYt0JI0SR3fF
   ApFpBEka7CNd4re2ERAkrG6kMOVMfNilRygsv5uA/RhRHuFicfMOR+Ae6
   kYhHinSKsXKk5jpz1/XggKD2FlMt7nK61pNjkBsZiGJkmdBwkv+vEUC9L
   d+rEb9o2QJFpbHU5JNOLqG0G5/yhTbfQtvjRZ0ZRvkpi6cBIe0vb2Bvsy
   w==;
X-CSE-ConnectionGUID: PslFRMMyRz6g4QF6Z6ZDFA==
X-CSE-MsgGUID: yTVTcNSoTay/woEZKi2e5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39097010"
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; 
   d="scan'208";a="39097010"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 04:58:32 -0800
X-CSE-ConnectionGUID: B/89JrSFR/ugFvMRLWJKuw==
X-CSE-MsgGUID: YNHQ1PhZT7evA34cNuMcoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="133834346"
Received: from apgcp0c531115.png.altera.com ([10.244.76.209])
  by fmviesa002.fm.intel.com with ESMTP; 04 Feb 2025 04:58:28 -0800
From: Mahesh Rao <mahesh.rao@intel.com>
Date: Tue, 04 Feb 2025 20:58:07 +0800
Subject: [PATCH v3 3/3] firmware: stratix10-svc: Add
 of_platform_default_populate()
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250204-socfpga_sip_svc_misc-v3-3-697f7f153cfa@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738673895; l=2045;
 i=mahesh.rao@intel.com; s=20250107; h=from:subject:message-id;
 bh=jpyQ7g3vF9VLx3+P43WwCMx1CgQIacytqeT6+99h4uE=;
 b=dJhy3C+0dSJI1aJL0X9Q54m7AsYc1IB8zBWoL3x0THtmJHt3XLmWOYgZk+85IICM6w8TgjLN6
 o5DahOeqbVZAeQMNZtOt52ms2MLwUMccKjE57kGed6/tNJfk7llfSOT
X-Developer-Key: i=mahesh.rao@intel.com; a=ed25519;
 pk=tQiFUzoKxHrQLDtWeEeaeTeJTl/UfclUHWZy1fjSiyg=

Add of_platform_default_populate() to stratix10-svc
driver as the firmware/svc node was moved out of soc.
This fixes the failed probing of child drivers of
svc node.

Fixes: 23c3ebed382a ("arm64: dts: socfpga: agilex: move firmware out of soc node")
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Mahesh Rao <mahesh.rao@intel.com>
---
 drivers/firmware/stratix10-svc.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index 3c52cb73237a43aac6984e497d75bab389e3eb9d..e3f990d888d71829f0ab22b8a59aa7af0316bea0 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -1224,22 +1224,28 @@ static int stratix10_svc_drv_probe(struct platform_device *pdev)
 	if (!svc->intel_svc_fcs) {
 		dev_err(dev, "failed to allocate %s device\n", INTEL_FCS);
 		ret = -ENOMEM;
-		goto err_unregister_dev;
+		goto err_unregister_rsu_dev;
 	}
 
 	ret = platform_device_add(svc->intel_svc_fcs);
 	if (ret) {
 		platform_device_put(svc->intel_svc_fcs);
-		goto err_unregister_dev;
+		goto err_unregister_rsu_dev;
 	}
 
+	ret = of_platform_default_populate(dev_of_node(dev), NULL, dev);
+	if (ret)
+		goto err_unregister_fcs_dev;
+
 	dev_set_drvdata(dev, svc);
 
 	pr_info("Intel Service Layer Driver Initialized\n");
 
 	return 0;
 
-err_unregister_dev:
+err_unregister_fcs_dev:
+	platform_device_unregister(svc->intel_svc_fcs);
+err_unregister_rsu_dev:
 	platform_device_unregister(svc->stratix10_svc_rsu);
 err_free_kfifo:
 	kfifo_free(&controller->svc_fifo);
@@ -1253,6 +1259,8 @@ static void stratix10_svc_drv_remove(struct platform_device *pdev)
 	struct stratix10_svc *svc = dev_get_drvdata(&pdev->dev);
 	struct stratix10_svc_controller *ctrl = platform_get_drvdata(pdev);
 
+	of_platform_depopulate(ctrl->dev);
+
 	platform_device_unregister(svc->intel_svc_fcs);
 	platform_device_unregister(svc->stratix10_svc_rsu);
 

-- 
2.35.3



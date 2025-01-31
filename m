Return-Path: <linux-fpga+bounces-1027-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B2C1A23C1A
	for <lists+linux-fpga@lfdr.de>; Fri, 31 Jan 2025 11:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7667C1689B8
	for <lists+linux-fpga@lfdr.de>; Fri, 31 Jan 2025 10:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1171B6CE5;
	Fri, 31 Jan 2025 10:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GbuOONEo"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6342E1B415A;
	Fri, 31 Jan 2025 10:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738318672; cv=none; b=NF2+CpEVIDKipUHM/dDIQ72rhauRzlSrmv6Y1r3Cu0ejccY96xDRK1ZHYVfPXI/zlO6EqNQkdx7frIlBRrpx32JqZnvdNF2/sSzpJc1THuNBZF0a0sbZL4SRln8OL2KeSDCpOsvnQrQlOrmjOntbinpMpJSc+FsdCTiKwa9IhTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738318672; c=relaxed/simple;
	bh=T5wOj3s71piKUatOmbSbPqAr7wZL43qmiavckBOkNE8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SQyZd1L9C/ZP/Hnw1Mq8a/I7fZGNI3I0GAB0JbGn0B1KWXyCzCLixv1k9wnUGoy8/kfXlahb5iN9/Fy3nCm84Zn44OBys6hJXr6J2CdFs0soqCfEJQzsqIzu1+u5jbblDApxIbugTxYN/kdabX7Km0xWIO/pyzBjy+ducFQx6lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GbuOONEo; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738318670; x=1769854670;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=T5wOj3s71piKUatOmbSbPqAr7wZL43qmiavckBOkNE8=;
  b=GbuOONEoTVU1X4A01tudV9FJnTYpFL+5NAPJBqpX0OgtxeHVguV4gcmJ
   ASudc2G3tUzxhwgVzzdN76+GWE8rce+eHJKmAyDcnessnIsyIUGilgqiz
   PjptqiofV2Hg4ia6UfZvguuE2VJsDvMij3QgUYzr7dBDNcl4gsQWK2YsK
   Vrbzv+Xy1YFWajmaT3guDesTt8kGnEaLTFUipoUdCuo/5oRE/zurT26F5
   iTBviNMiqTNln9V8nN+75nEh4MpZW9vxBZdHfssUNNbzpwC3w2ZA3g4BL
   Z0qSrVCdkuJjI840JZZiPlB5wroH4tGmVuTyEGpd7FDTLoYJkcpvO9Vda
   A==;
X-CSE-ConnectionGUID: df2oKtOKRrmWvK9Q1L9s9Q==
X-CSE-MsgGUID: S2gAEILqRsOjHBLBzzVuYQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11331"; a="38777242"
X-IronPort-AV: E=Sophos;i="6.13,248,1732608000"; 
   d="scan'208";a="38777242"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2025 02:17:50 -0800
X-CSE-ConnectionGUID: fIveUyynQvCZgPl1LTxW1g==
X-CSE-MsgGUID: OT2bVGWzSf2jGK9mdV8hsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,248,1732608000"; 
   d="scan'208";a="114596205"
Received: from apgcp0c531115.png.altera.com ([10.244.76.209])
  by fmviesa004.fm.intel.com with ESMTP; 31 Jan 2025 02:17:46 -0800
From: Mahesh Rao <mahesh.rao@intel.com>
Date: Fri, 31 Jan 2025 18:17:26 +0800
Subject: [PATCH v2 3/3] firmware: stratix10-svc: Add
 of_platform_default_populate()
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250131-socfpga_sip_svc_misc-v2-3-eeed4ebc35f9@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738318654; l=1978;
 i=mahesh.rao@intel.com; s=20250107; h=from:subject:message-id;
 bh=T5wOj3s71piKUatOmbSbPqAr7wZL43qmiavckBOkNE8=;
 b=ZbR8Hn4nMA33JLcFsfEMZY7CrsWIgH++5jix9TNCqxlrPDNM0oDwTmYkFRvKq0ofWwr+DDg+a
 YQmunFT0KH6CJ9Ls3nHeuSc+U4jvC4AEKqfpWQD0O8axGGAImWm124R
X-Developer-Key: i=mahesh.rao@intel.com; a=ed25519;
 pk=tQiFUzoKxHrQLDtWeEeaeTeJTl/UfclUHWZy1fjSiyg=

Add of_platform_default_populate() to stratix10-svc
driver as the firmware/svc node was moved out of soc.
This fixes the failed probing of child drivers of
svc node.

Fixes: 23c3ebed382a ("arm64: dts: socfpga: agilex: move firmware out of soc node")
Signed-off-by: Mahesh Rao <mahesh.rao@intel.com>
---
 drivers/firmware/stratix10-svc.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index c5c78b869561b0c1e9602823ad1f501e98e3ce51..6a0419197c9ed2f2ccfc4643baba70340d0934f2 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -1227,22 +1227,28 @@ static int stratix10_svc_drv_probe(struct platform_device *pdev)
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
@@ -1256,6 +1262,8 @@ static void stratix10_svc_drv_remove(struct platform_device *pdev)
 	struct stratix10_svc *svc = dev_get_drvdata(&pdev->dev);
 	struct stratix10_svc_controller *ctrl = platform_get_drvdata(pdev);
 
+	of_platform_depopulate(ctrl->dev);
+
 	platform_device_unregister(svc->intel_svc_fcs);
 	platform_device_unregister(svc->stratix10_svc_rsu);
 

-- 
2.35.3



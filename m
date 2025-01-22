Return-Path: <linux-fpga+bounces-999-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D3BA18B85
	for <lists+linux-fpga@lfdr.de>; Wed, 22 Jan 2025 06:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCC14188C28A
	for <lists+linux-fpga@lfdr.de>; Wed, 22 Jan 2025 05:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425E11B85E8;
	Wed, 22 Jan 2025 05:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kWS6GMXG"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFB51B6CFA;
	Wed, 22 Jan 2025 05:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737525542; cv=none; b=ragF3mfBLmGIldxyaIOxfakbca8EC3p8+48GlETWuuzcXiiErSP6FcjxhTiCSAlZeePjU7h4PZ1GDW8sGwYv8p8EnCiLSa6uWTXDJVk9ONlpPJq3AVhPuOtRlVHKk1yC4vQ+/T7S7eF+t1I0dDtQXVYPw0YN9t4l8zK2ALIeGy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737525542; c=relaxed/simple;
	bh=f1R1HuBBcb8MhbJww71G48rj37+nGAaMtA9a39JKJPc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ssGBrBCYb/D5Z2k9qUMz9Vft8u0P4chIGp325ENS2oNMv6wTH4NGUwXYi84fc/b72hu3eQe3LToR3l4QOUc5MGUxNnyB0QpkGAgLXuByonxUZLzD1kHZ5GagLGgR2XfZKvbxeGnzZlSPnLUOJOVu+pLy3Y6OYrCyz3EYVYx9N/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kWS6GMXG; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737525541; x=1769061541;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=f1R1HuBBcb8MhbJww71G48rj37+nGAaMtA9a39JKJPc=;
  b=kWS6GMXGZcPHed9BvT3uSnCKu2ZTGCiAdOSnZNUcdVjLId+IPwKa8Q91
   I5cb9DC0AE+2nKK724Bwmm7vcYF2LS5iQ5vglpYwESv94lkgaxOFa7enW
   67vnyr+B3W5Zkj2IlYAbNPWY/ZqLHPakpdC8oYausyYDH71s6Gh3LSd2i
   7WUTERaj88jA2Ik/8NwuRjmSDrLZCVBh/YvF0tF5lRIyJGsjTaFhkFfiV
   9NmeL9/nasDHAjTJjM49QXo3W28SVdera/qAaxH3tVPdS+NCJ24iHSLUy
   JiLWntF3PjuH0mtvjGeyrbhIrFqqDARcyrEHonr1f5WwBephFxt1jz7R1
   A==;
X-CSE-ConnectionGUID: vRsgz5YjRHuq9l14EUPpJQ==
X-CSE-MsgGUID: PXzLAqlPRnGgdhL7vnvXwg==
X-IronPort-AV: E=McAfee;i="6700,10204,11322"; a="55381142"
X-IronPort-AV: E=Sophos;i="6.13,224,1732608000"; 
   d="scan'208";a="55381142"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2025 21:59:00 -0800
X-CSE-ConnectionGUID: IX9pmmhiQPCzxWUOMgGrIg==
X-CSE-MsgGUID: 55LYosT9Q9CI9YIblHaOVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,224,1732608000"; 
   d="scan'208";a="106851748"
Received: from apgc00009.png.altera.com ([10.244.70.6])
  by fmviesa006.fm.intel.com with ESMTP; 21 Jan 2025 21:58:57 -0800
From: Mahesh Rao <mahesh.rao@intel.com>
Date: Wed, 22 Jan 2025 13:58:45 +0800
Subject: [PATCH 3/3] firmware: stratix10-svc: Add
 of_platform_default_populate()
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250122-socfpga_sip_svc_misc-v1-3-cbdcd034ae34@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737525526; l=1679;
 i=mahesh.rao@intel.com; s=20250107; h=from:subject:message-id;
 bh=f1R1HuBBcb8MhbJww71G48rj37+nGAaMtA9a39JKJPc=;
 b=R2NUnlksLkbcM7F22Hmsm0Ja/366o6JCazI6r8TUudp0GOQjxgd57X33fmd+uQaE0UgCB0lq7
 bfPtbhg/hj3AcnfZMjAVN4fZG1XgcSQHfBYu4Yba8ml69ehQhTGbnjE
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
index c5c78b869561b0c1e9602823ad1f501e98e3ce51..15a7207f7753dcd4e94da4aa9a6162fedb577fe9 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -1227,13 +1227,19 @@ static int stratix10_svc_drv_probe(struct platform_device *pdev)
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
+	}
+
+	ret = of_platform_default_populate(dev_of_node(dev), NULL, dev);
+	if (ret < 0) {
+		of_platform_depopulate(dev);
+		goto err_unregister_fcs_dev;
 	}
 
 	dev_set_drvdata(dev, svc);
@@ -1242,7 +1248,9 @@ static int stratix10_svc_drv_probe(struct platform_device *pdev)
 
 	return 0;
 
-err_unregister_dev:
+err_unregister_fcs_dev:
+	platform_device_unregister(svc->intel_svc_fcs);
+err_unregister_rsu_dev:
 	platform_device_unregister(svc->stratix10_svc_rsu);
 err_free_kfifo:
 	kfifo_free(&controller->svc_fifo);

-- 
2.35.3



Return-Path: <linux-fpga+bounces-1256-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6671DAEB650
	for <lists+linux-fpga@lfdr.de>; Fri, 27 Jun 2025 13:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50E6B561DB8
	for <lists+linux-fpga@lfdr.de>; Fri, 27 Jun 2025 11:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00C829CB32;
	Fri, 27 Jun 2025 11:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UO0CI4yM"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E6329B8F7;
	Fri, 27 Jun 2025 11:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751023602; cv=none; b=huhT3z7eNKdow0SeVl5Ga/fFNLC1JYgeShjJpNgcmPTzanQi5ygjxWCCjKeNNW4gvp21KvfNjnL+8B1X1chFpXuXE0Ai+NqVBHL4/qP5ZummPkjZ1TF5s8XEXf1YKRiZ1OIdKByWVf1dyeAdfviBAYpvNnrearSBLcuQCpVSoaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751023602; c=relaxed/simple;
	bh=ymHj2heJ3EaEpXwaDAEWgN5F5AZ/YCUmvRRX+CctGCM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nju5rU3bbvHt+uPTKf+NPgIziDDpXYHt04JCpmyl1Ktw7JNOV20QFXJ0BiQxanJX8sUL0oAhpG1EpLIWQxMRL2T2/SwmHn1I1TEnDi/zAdmLpEZ/6/F7Mr9F35QsjKsX95fvmvHwMx1nU1HoOy5kUGWn1Nk91JDNjpauAkxbeGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UO0CI4yM; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751023601; x=1782559601;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ymHj2heJ3EaEpXwaDAEWgN5F5AZ/YCUmvRRX+CctGCM=;
  b=UO0CI4yMwxeDZC6zeI2oN8SEELAqn+xA7kBxhBbyY0y7j20HaQuxOh31
   XfZLcQW9+m0FX/wjKxgB5FYP84HIqlMN4aeTbQyKiK0yOzV8sa+lmJbfo
   /qFiiJyJ641nCYXokJQPhDMb0AEO4Zi9tDs5ucuh+GZtk5MwtUIsZfbSp
   yhbxI9mf0aQ+8G0kBbQ39u8unXKGMUWeYP+UFCajaLU5bnRVmLDj82nhw
   xUmpFeD/rJNiCp2864otjpv2B1RBZpTXMHClSEpLnmAyWDBWjgb0bduHB
   YKTbjW72ODLBPXGNSfkehw5TApISLUjXYl03YTjxICGfZ57GfM/b4HEWE
   A==;
X-CSE-ConnectionGUID: FVmULpZyQpqt9XIuK4ck+w==
X-CSE-MsgGUID: PMcLk8pbTWKv/e95Br6AaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11476"; a="53208802"
X-IronPort-AV: E=Sophos;i="6.16,270,1744095600"; 
   d="scan'208";a="53208802"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2025 04:26:41 -0700
X-CSE-ConnectionGUID: CNvLs3amSLWUlOXrDX3C/g==
X-CSE-MsgGUID: dpxZq7fuR4ij1vbYv3THBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,270,1744095600"; 
   d="scan'208";a="152960312"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa007.jf.intel.com with ESMTP; 27 Jun 2025 04:26:39 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id B20E46A; Fri, 27 Jun 2025 14:26:37 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Xu Yilun <yilun.xu@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Moritz Fischer <mdf@kernel.org>,
	Wu Hao <hao.wu@intel.com>,
	Tom Rix <trix@redhat.com>
Subject: [PATCH v2 1/1] fpga: altera-cvp: Use pci_find_vsec_capability() when probing FPGA device
Date: Fri, 27 Jun 2025 14:26:22 +0300
Message-ID: <20250627112635.789872-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently altera_cvp_probe() open-codes pci_find_vsec_capability().
Refactor the former to use the latter. No functional change intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

v2: removed unused variable (LKP)

 drivers/fpga/altera-cvp.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
index 5af0bd33890c..514d2ac18e5f 100644
--- a/drivers/fpga/altera-cvp.c
+++ b/drivers/fpga/altera-cvp.c
@@ -22,9 +22,6 @@
 #define TIMEOUT_US	2000	/* CVP STATUS timeout for USERMODE polling */
 
 /* Vendor Specific Extended Capability Registers */
-#define VSE_PCIE_EXT_CAP_ID		0x0
-#define VSE_PCIE_EXT_CAP_ID_VAL		0x000b	/* 16bit */
-
 #define VSE_CVP_STATUS			0x1c	/* 32bit */
 #define VSE_CVP_STATUS_CFG_RDY		BIT(18)	/* CVP_CONFIG_READY */
 #define VSE_CVP_STATUS_CFG_ERR		BIT(19)	/* CVP_CONFIG_ERROR */
@@ -577,25 +574,18 @@ static int altera_cvp_probe(struct pci_dev *pdev,
 {
 	struct altera_cvp_conf *conf;
 	struct fpga_manager *mgr;
-	int ret, offset;
-	u16 cmd, val;
+	u16 cmd, offset;
 	u32 regval;
-
-	/* Discover the Vendor Specific Offset for this device */
-	offset = pci_find_next_ext_capability(pdev, 0, PCI_EXT_CAP_ID_VNDR);
-	if (!offset) {
-		dev_err(&pdev->dev, "No Vendor Specific Offset.\n");
-		return -ENODEV;
-	}
+	int ret;
 
 	/*
 	 * First check if this is the expected FPGA device. PCI config
 	 * space access works without enabling the PCI device, memory
 	 * space access is enabled further down.
 	 */
-	pci_read_config_word(pdev, offset + VSE_PCIE_EXT_CAP_ID, &val);
-	if (val != VSE_PCIE_EXT_CAP_ID_VAL) {
-		dev_err(&pdev->dev, "Wrong EXT_CAP_ID value 0x%x\n", val);
+	offset = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_ALTERA, 0);
+	if (!offset) {
+		dev_err(&pdev->dev, "Wrong EXT_CAP_ID value\n");
 		return -ENODEV;
 	}
 
-- 
2.47.2



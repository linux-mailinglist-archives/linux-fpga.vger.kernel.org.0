Return-Path: <linux-fpga+bounces-1254-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C820AEAEDD
	for <lists+linux-fpga@lfdr.de>; Fri, 27 Jun 2025 08:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5388056700D
	for <lists+linux-fpga@lfdr.de>; Fri, 27 Jun 2025 06:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CE52A8D0;
	Fri, 27 Jun 2025 06:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LyqOcJnF"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076271E8322;
	Fri, 27 Jun 2025 06:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751004879; cv=none; b=WA5GCh6TyM73Cm5aWP1Xddu+fR1Pmam1uOzWKUV4czdO21vNad7o1z6GTDIMyr/i4azJdt6aRgKyntsYuPCNPiX00t75kOUTEF/7c7jPnamfm+iUTrzctS0XNDR5fc4fAMlpv9nnt20nDgkYxlLCrvInC1OMh5VxK0zmrlYRjuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751004879; c=relaxed/simple;
	bh=0FAP8h3Bqn60g8pdq2IXB//EoK8uGVAIYk1n1XgwjaY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HN5oOalqzI5hWtNOKlWoi7TdFdjzcPS8gnIRAuhxPcbi7qVR71fUnYwQCLyQkUNWqCmGKdOlcZtP8v5W7f65oSKhOK9MKAi6jtK36QdDR2e2nWXmo4DhAl61Q/M8GEze7VxpQNB2iU2UgNXM5ySynHR10Qj2TAdaZ2dbSCD+qH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LyqOcJnF; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751004878; x=1782540878;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0FAP8h3Bqn60g8pdq2IXB//EoK8uGVAIYk1n1XgwjaY=;
  b=LyqOcJnF+AuUs73fcYslGvSCA9z6CR2ZPNJr0n/R0+YTbHPmeZ6S2J/X
   quJslTq8uE7J23Iv49SwKzxNoKkCXp+jXUooZ6iW3m5wCJYJywkPEWPm1
   PPXr/FP95busSmHKRJnwJ0GKhl8ixkjYxp8BWGgs0KAP20r6KuT0LIZhE
   VmQi4xfNS0iurE02rPZhmcopLp/T1r0hJiast84nRXSH2tBhSz2Lx9U4L
   vdGr3QaU7Bcz8Uv7DJKVmRRXq6GVHQySUdP8ce4PuiOa/QE7u2iEsQ/Cn
   blDKyVc8kuzmVWrH4Nsc2t1IK9qMQuFhKSXrGBwrOuJCRwZIleUz5Rtnn
   g==;
X-CSE-ConnectionGUID: wD4QsDZpSzymRI9FO+pX4g==
X-CSE-MsgGUID: Z2sTrkkQRMiKdQbJoNbQOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11476"; a="57118946"
X-IronPort-AV: E=Sophos;i="6.16,269,1744095600"; 
   d="scan'208";a="57118946"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2025 23:14:38 -0700
X-CSE-ConnectionGUID: SxK+aZxVTPOy8PTdX3DNAw==
X-CSE-MsgGUID: uiO6Ism6TPymVeQbjZPqsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,269,1744095600"; 
   d="scan'208";a="158457188"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa005.jf.intel.com with ESMTP; 26 Jun 2025 23:14:35 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id CFB4B21E; Fri, 27 Jun 2025 09:14:33 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Xu Yilun <yilun.xu@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Moritz Fischer <mdf@kernel.org>,
	Wu Hao <hao.wu@intel.com>,
	Tom Rix <trix@redhat.com>
Subject: [PATCH v1 1/1] fpga: altera-cvp: Use pci_find_vsec_capability() when probing FPGA device
Date: Fri, 27 Jun 2025 09:14:31 +0300
Message-ID: <20250627061431.522016-1-andriy.shevchenko@linux.intel.com>
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
 drivers/fpga/altera-cvp.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
index 5af0bd33890c..f6140a56c70b 100644
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
@@ -577,25 +574,19 @@ static int altera_cvp_probe(struct pci_dev *pdev,
 {
 	struct altera_cvp_conf *conf;
 	struct fpga_manager *mgr;
-	int ret, offset;
 	u16 cmd, val;
+	u16 offset;
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



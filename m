Return-Path: <linux-fpga+bounces-1434-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5DBC446AE
	for <lists+linux-fpga@lfdr.de>; Sun, 09 Nov 2025 21:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 713523ADFA9
	for <lists+linux-fpga@lfdr.de>; Sun,  9 Nov 2025 20:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC1623EA98;
	Sun,  9 Nov 2025 20:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kh4UqDOL"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0625621885A;
	Sun,  9 Nov 2025 20:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762719458; cv=none; b=jeM6BU6MgYzp8gd3FzjmDA7QUm7OBUufRf1lM9BYwmo+qhMphk7EkNV7hCLUT6Mr5fa1RychOWxwMXlL0HP9LJIrsRLx60PfIwKZYziNJ6QwRGss7mt3Z5ybdHxH/wdBgXIP9TAIhTUwqnj77dajj7y/8uCYvuXUI0MAgNWIMak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762719458; c=relaxed/simple;
	bh=1KRhyqT3RL8+J1aPjCPNmWkZUU7rTkrdCzwbvZfrVQg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u9P03K3m8vGvUbNNhnTJJI3acNasdYKuyJritBGqAwUJNTbXNGZ/Bq04ZoPErgQ57ljj8hCDfl1znZCq0lWKVuYDUa8ElhqRY7h2Xm3S2e4eGhtgoBheQwwZcV5iF8PnmbD+TB/0ejHyjvr2v+yUGzBIi45z9PzH02l2GLccjtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kh4UqDOL; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762719456; x=1794255456;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1KRhyqT3RL8+J1aPjCPNmWkZUU7rTkrdCzwbvZfrVQg=;
  b=Kh4UqDOLrXHj2z4SjsL0w+p8OnYdo8YXCIz9sOvXZGkES4YXCgQv0ez6
   7b8VdLiHkIrPiefzGT3BRLMgOfmSFuPa2ZI4Os131WsUUMKqO813uw2Ip
   cW453i2DKb4lxZUGXhKqirli7g5Vbb6F/ivnZxA1wm1QeS5QnX/qprkbn
   B7OTzDUTJkvwyM9Jou5OdJs12+7mCVIeg4OZwbYEv5GLo4/RaFP03tBkP
   RFDP1kimG75g6uTVupfw97jrX03Cr13D5fmdHebV+Nx40jb62TleAnXk5
   /Qx0pkEJGV55LDIBUrR3Hiso2AwCNH7Edkl9n2mQqroqGfu9hBpwYcCp8
   w==;
X-CSE-ConnectionGUID: Y4mE6LmsSUSLGV5n5uwfGQ==
X-CSE-MsgGUID: gG2zoX7kS4aXzu1DFRux1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11608"; a="67386916"
X-IronPort-AV: E=Sophos;i="6.19,292,1754982000"; 
   d="scan'208";a="67386916"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2025 12:17:35 -0800
X-CSE-ConnectionGUID: zugnw0nQQXukRBAiH7eeEA==
X-CSE-MsgGUID: fxxLKX4ITTuczS7ZqpXO6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,292,1754982000"; 
   d="scan'208";a="225765073"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa001.jf.intel.com with ESMTP; 09 Nov 2025 12:17:34 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id D782C95; Sun, 09 Nov 2025 21:17:32 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Xu Yilun <yilun.xu@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Moritz Fischer <mdf@kernel.org>,
	Tom Rix <trix@redhat.com>
Subject: [PATCH v3 1/1] fpga: altera-cvp: Use pci_find_vsec_capability() when probing FPGA device
Date: Sun,  9 Nov 2025 21:16:37 +0100
Message-ID: <20251109201729.3220460-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently altera_cvp_probe() open-codes pci_find_vsec_capability().
Refactor the former to use the latter.

With that done:
- use the VSEC ID as per datasheet [1]
- update the error message accordingly

Link: https://www.intel.com/content/www/us/en/docs/programmable/683763/23-1/vendor-specific-header-register.html [1]
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

v3: used VSEC ID per datasheet (Xu), updated commit message (Xu)

 drivers/fpga/altera-cvp.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
index 5af0bd33890c..44badfd11e1b 100644
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
+	offset = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_ALTERA, 0x1172);
+	if (!offset) {
+		dev_err(&pdev->dev, "Wrong VSEC ID value\n");
 		return -ENODEV;
 	}
 
-- 
2.50.1



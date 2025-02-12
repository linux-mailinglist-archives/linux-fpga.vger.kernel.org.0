Return-Path: <linux-fpga+bounces-1054-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D03A332C7
	for <lists+linux-fpga@lfdr.de>; Wed, 12 Feb 2025 23:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6411718895DC
	for <lists+linux-fpga@lfdr.de>; Wed, 12 Feb 2025 22:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67185204594;
	Wed, 12 Feb 2025 22:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dwXaJWXz"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21B2204591;
	Wed, 12 Feb 2025 22:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739399970; cv=none; b=gh3C+RHn0xkreWm56Is+oV62rkMayrRTrKxKORHe1DQ0RLOlZRTe83zlz15/vUHG3XIP2wJ4nMvf1i/21cMRLp9bYZQ/xSpX85zlgNqZM6vv5a/JL8J6mAm7flU2oFsbwaYrBcQzPiOyf8A7ZoIyaqywKgS3pJXSz7kkpZ4A/vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739399970; c=relaxed/simple;
	bh=/3+mBVrE63/84GWfZK7OmV4Ny/tGhzzzgdhYFy/il4Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BgP2DKrqMRVbiwz95H5E6MEnEh/RQJMaPLremhR1eP5wMFnXOcKUkje1W+HbPZdeuuhRUrU6+bOIL02nwGZjveXDArN6pitQTSgXrPJBDkKNwcial61eYbzzjiIS+2MzBUoQR1jr2HuiIPY/Vxg2oOiSof42lLJ+7ey/+ERr47s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dwXaJWXz; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739399969; x=1770935969;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/3+mBVrE63/84GWfZK7OmV4Ny/tGhzzzgdhYFy/il4Q=;
  b=dwXaJWXzEIkMh7yZx0JP65Wx1J1Xf/DHbb05opzTrmJuAZK6QlE0qHg7
   wOoEbyclup0k4GWcpeJnX940Lem8dEbnIq6FNrE/x2mQRGbC/h1ErvnkQ
   u6OnWi7hC0KmILtx98DM0CfTKShee3mvIB/dhlYh9Rm38CGyH66x3PzfF
   nggLg4aEohrC2rmO6H4W3tbuhlLsAHoFXjIs3RTI8ljTVyjbYoc0dVUL4
   eMYZVk6eSqQA1WwXV4EHDdwuGKpZiMMd4SL9Bw7+rTISbwq0BPM0H6Wcd
   TzTOVAMwrBfWttWXJXTQXJBN+Dta1jljaaeE0fl7u6JCJNhSGdEQCfY3R
   g==;
X-CSE-ConnectionGUID: DFK5Dgk+RVq6teKzbf/C/A==
X-CSE-MsgGUID: R8ly/kwhQ9OQOOV6VyIb+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="51477510"
X-IronPort-AV: E=Sophos;i="6.13,281,1732608000"; 
   d="scan'208";a="51477510"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 14:39:29 -0800
X-CSE-ConnectionGUID: 05zNa/znTkyUTxknDH1uZw==
X-CSE-MsgGUID: vC9d2BQfQe6i8Hbd2elhPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117581233"
Received: from pg15swiplab1181.png.altera.com ([10.244.232.167])
  by fmviesa005.fm.intel.com with ESMTP; 12 Feb 2025 14:39:25 -0800
From: Kuhanh Murugasen Krishnan <kuhanh.murugasen.krishnan@intel.com>
To: Moritz Fischer <mdf@kernel.org>,
	Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kuhanh Murugasen Krishnan <kuhanh.murugasen.krishnan@intel.com>,
	kuhanh.murugasen.krishnan@altera.com
Cc: Ang Tien Sung <tien.sung.ang@intel.com>
Subject: [PATCH] fpga: altera-cvp: PCIex8x8 ports
Date: Thu, 13 Feb 2025 06:35:53 +0800
Message-Id: <20250212223553.2717304-1-kuhanh.murugasen.krishnan@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enabling the possibility of supporting multiple
PCIe devices from Intel Altera FPGA but with different
device ids. The current driver registers itself
to all device IDs which causes an incorrect driver
association.

Signed-off-by: Ang Tien Sung <tien.sung.ang@intel.com>
Signed-off-by: Kuhanh Murugasen Krishnan <kuhanh.murugasen.krishnan@intel.com>
---
 drivers/fpga/altera-cvp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
index 5af0bd33890c..97e9d4d981ad 100644
--- a/drivers/fpga/altera-cvp.c
+++ b/drivers/fpga/altera-cvp.c
@@ -560,7 +560,7 @@ static int altera_cvp_probe(struct pci_dev *pdev,
 static void altera_cvp_remove(struct pci_dev *pdev);
 
 static struct pci_device_id altera_cvp_id_tbl[] = {
-	{ PCI_VDEVICE(ALTERA, PCI_ANY_ID) },
+	{ PCI_VDEVICE(ALTERA, 0x00) },
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, altera_cvp_id_tbl);
-- 
2.25.1



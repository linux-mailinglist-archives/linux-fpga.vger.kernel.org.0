Return-Path: <linux-fpga+bounces-1053-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF308A33288
	for <lists+linux-fpga@lfdr.de>; Wed, 12 Feb 2025 23:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAAEC164B91
	for <lists+linux-fpga@lfdr.de>; Wed, 12 Feb 2025 22:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59FA0202F68;
	Wed, 12 Feb 2025 22:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RKW3YlQz"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518C9202C45;
	Wed, 12 Feb 2025 22:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739399221; cv=none; b=BNFl0lrFLuly0adzKksQZmn1DLp9uHu0nVzWmwQvkM0zT77qybEfj4Qf26XNBEdUpviapW0d5PiT0a6uoCbYxg+PmHpbfEDAtauz3wQC6pSrcJsqFFqyYHb2f1s8iiX7PYJ4XhC1CJS9/6Gn5pGfbbnWtgduDwYqxmjsUXxaQgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739399221; c=relaxed/simple;
	bh=/3+mBVrE63/84GWfZK7OmV4Ny/tGhzzzgdhYFy/il4Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HJrTVU3mXSrGe+Tjz8ZEKWn3aYPKggD9HDwFKsgdBIx/rW6lFxT2kI8dR8VckEHoOxNxEF6ouHqEVdBHgFr1Svm+2bc7fcYnqOoDmgY+r+2ZT20EAo8hNbHm3u45Nl+WAZJyt0sWRIYJT+ptuxkp6eT8FXOZj1oQp4pfYlKXF+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RKW3YlQz; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739399219; x=1770935219;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/3+mBVrE63/84GWfZK7OmV4Ny/tGhzzzgdhYFy/il4Q=;
  b=RKW3YlQzhT+0w2VxLepW/buJ6YAtdng2+jL6vc00z+rqZv5b6xExmtxe
   Srs42M9/G8s7ieTQf3F+/KMtpE5ae/8DGY3oQYtcAlAlmpi8g9WFq6E9+
   RnS5oZ/GpZxRnpmUj5M9COoe1Hjd5ZGnnfWjodbVIFqDuqLSm7omPz3c5
   97U4GW8swmFVNPIS/f2TGASHvAmnTxmgzXRvh/5t9xaQoZ6smX9Xdwd9p
   4WMoJeNt/tpjJ75ep2GhhucpoEiBEzIXspmFgByKN/f6f2JimgsoISmZ7
   0jnFNs1QSjaf7//el/BfYsFw47Yu2YP8md8hDWEd5ybjYtUMUwjIF9FEB
   w==;
X-CSE-ConnectionGUID: 7IBeE15jR/m/FEYqGMus/Q==
X-CSE-MsgGUID: f0WXe2sMQDyRyx1ADL5Ehg==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="42919934"
X-IronPort-AV: E=Sophos;i="6.13,281,1732608000"; 
   d="scan'208";a="42919934"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 14:26:58 -0800
X-CSE-ConnectionGUID: 5gpj1kBGTU60agfsopnnIg==
X-CSE-MsgGUID: H+oFrjRlRKCfbaGSO0YdUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,281,1732608000"; 
   d="scan'208";a="118038847"
Received: from pg15swiplab1181.png.altera.com ([10.244.232.167])
  by fmviesa004.fm.intel.com with ESMTP; 12 Feb 2025 14:26:56 -0800
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
Subject: [PATCH] fpga: altera-cvp: PCIex8x8 ports (#94)
Date: Thu, 13 Feb 2025 06:23:21 +0800
Message-Id: <20250212222321.2716639-1-kuhanh.murugasen.krishnan@intel.com>
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



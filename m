Return-Path: <linux-fpga+bounces-1239-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2E0AD87B4
	for <lists+linux-fpga@lfdr.de>; Fri, 13 Jun 2025 11:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8163C3B6E20
	for <lists+linux-fpga@lfdr.de>; Fri, 13 Jun 2025 09:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90AA42727E6;
	Fri, 13 Jun 2025 09:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hmNMrVhl"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1151B19049B;
	Fri, 13 Jun 2025 09:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749806700; cv=none; b=QLfik75T9OT6xLfi5Vy6eJu82oymtjuzQr2vn3ko38/Y6pJr1Wbyd8SFaXquDSEYXfPn9BMJrSb5hrP55sYXa3hZZ6eU867dxJbWH1M1HNElymwO/iQ9/naPQ4JdItKTP/r8Ziu5LtsE3QiUo0rxa6nnAT59hSAme1sN5VtKNVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749806700; c=relaxed/simple;
	bh=2rdfYYv854C7M7g8ZFsIspD82wwfXyRvy4/0FUJvoxY=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=ggpArF8F/qAxHroprYMxtgcODKaWkRNlpPLJ7ru0re3igjQgI46bR5Dz5SPPD5zol8rTIwrdZ4VoJUTSUU7WEf3HcVKaNu3IbO9SmV/GVap2oORkpSiMtlAzXQ+vnsUxIRm3AjzqJ45sNKqSdojwb4UUT5UxzfpxSGUcppuYyqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hmNMrVhl; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749806699; x=1781342699;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2rdfYYv854C7M7g8ZFsIspD82wwfXyRvy4/0FUJvoxY=;
  b=hmNMrVhlQrnH5P3103vBdTf7XVuo/axMqp2QV48VTIq3essI4J1V6gAk
   mqepqAic2zcnRotezgjOohS7DQRKLB5B938ZIwbCMAYO/6AzuJiqUZo0R
   3S0kItLAB6/XyUnsdenfoRXiPvgLYNNdOfbhIMkrOdbf3hL7uwJp3UgWD
   gGH9G4VfRgTCBL7oJMJj3zNp6h5R3bnnzPzVOeTt59wo+Mmc+2f1PUrqw
   RT9WqgepFsIYC9c13TcnVEz60i5FVpZp9Sb5Y475cOLiFNJXh9KeB84vp
   eK+iU2STYpFToIxMjSRD6yUFeBHfWdlbybSXoC0YcQDtuqEXk42FkP5QE
   Q==;
X-CSE-ConnectionGUID: C0B9wv6oSw2/dNk+ptJDxg==
X-CSE-MsgGUID: VSZLAIZ+Q2ODzgTJpIL4AA==
X-IronPort-AV: E=McAfee;i="6800,10657,11462"; a="54639585"
X-IronPort-AV: E=Sophos;i="6.16,233,1744095600"; 
   d="scan'208";a="54639585"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 02:24:59 -0700
X-CSE-ConnectionGUID: Akm7th/yT72xATCP9Tw2uw==
X-CSE-MsgGUID: x93kd78ZRW+6noZ70evQmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,233,1744095600"; 
   d="scan'208";a="152937851"
Received: from pg15swiplab1181.png.altera.com ([10.244.232.167])
  by fmviesa004.fm.intel.com with ESMTP; 13 Jun 2025 02:24:56 -0700
From: Kuhanh Murugasen Krishnan <kuhanh.murugasen.krishnan@intel.com>
To: Moritz Fischer <mdf@kernel.org>,
	Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kuhanh Murugasen Krishnan <kuhanh.murugasen.krishnan@intel.com>,
	Kuhanh Murugasen Krishnan <kuhanh.murugasen.krishnan@altera.com>,
	Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Subject: [PATCH] fpga: altera-cvp: Add FPGA Configuration Framework dependency
Date: Fri, 13 Jun 2025 17:24:14 +0800
Message-Id: <20250613092414.3198092-1-kuhanh.murugasen.krishnan@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Murugasen Krishnan, Kuhanh" <kuhanh.murugasen.krishnan@altera.com>

Altera CvP FPGA Manager driver depends on FPGA
Configuration Framework drivers to be loaded in
the kernel. Updating FPGA_MGR_ALTERA_CVP in Kconfig
depends on to include FPGA.

Signed-off-by: Murugasen Krishnan, Kuhanh <kuhanh.murugasen.krishnan@altera.com>
---
 drivers/fpga/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 37b35f58f0df..6f741348bfbc 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -47,7 +47,7 @@ config FPGA_MGR_ALTERA_PS_SPI
 
 config FPGA_MGR_ALTERA_CVP
 	tristate "Altera CvP FPGA Manager"
-	depends on PCI
+	depends on PCI && FPGA
 	help
 	  FPGA manager driver support for Arria-V, Cyclone-V, Stratix-V,
 	  Arria 10 and Stratix10 Altera FPGAs using the CvP interface over PCIe.
-- 
2.25.1



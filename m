Return-Path: <linux-fpga+bounces-996-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66794A18B7C
	for <lists+linux-fpga@lfdr.de>; Wed, 22 Jan 2025 06:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA5901650FA
	for <lists+linux-fpga@lfdr.de>; Wed, 22 Jan 2025 05:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB23169397;
	Wed, 22 Jan 2025 05:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mSN+I0by"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB6C49659;
	Wed, 22 Jan 2025 05:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737525532; cv=none; b=GgZ5Aapng0POumbq1P/B8lbXQn5RTskq7mTc62A8mOgy3M4BMdN1DidIEaTF7uqqKflsajnuY1R3driSMCIaR7QQ/G2l14IAuRQyfv0SwnCyxeJLWLXqfH8uchUF9M3GLrPiJfbA8KPAPHAm2vATvHOGDJpkz/TRCHzuWMv+KqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737525532; c=relaxed/simple;
	bh=Q7XVhlMW9Tgmsho4UsQVqJikg9MTpE1DdY0zKBEgu2Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EVSBTRc3tFdL4wi+jYlN6WfYtvGZDI/ZXKLlcv+FO9kOAznwny/1baL5VERqpsgsf1BKwhh94itQZ5SgqXxkAs++9JCif6MepNH/7VxPJzhlExtMOxf88bCtejxUgybxeGyHzz1D+Z8yTG4K3XRh9hX6QVzGV9OMf6/vM+GSbCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mSN+I0by; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737525531; x=1769061531;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=Q7XVhlMW9Tgmsho4UsQVqJikg9MTpE1DdY0zKBEgu2Q=;
  b=mSN+I0byMC61CTyCCxI9YHmXhsaX74iwNz7wQSQvmkiM/v2IZ1IS2TH/
   aH4oQqEflY6rLGcfFWq82A06wAxsNtpKdguJ58Gja3C944GQvURbZvwdA
   YVgUSmdbFfuGfRHNVKv2d2V72umtak+f+Gk2Vx3KtJVWHj2s6CICJcNNj
   N2kZ6Exh5gHNo4kbkWQwJllEIFx5Y2N4+jBvQNEZzcEMzzONTMqezDr+d
   LZmxlAwvvBQi/sVPvJjUeWDkCPyZYVMmn3FGSiJ8ny/QgP2YKx1TpSynv
   1DlW23AePcKxuPl6hAN0WAkoGzdScR2fgGnljaoyETHgxk3t31VIi9oPF
   w==;
X-CSE-ConnectionGUID: HSHhntm9Scq3lfzMREESxg==
X-CSE-MsgGUID: HYA61HKSTfOcc4/Oh1oM4g==
X-IronPort-AV: E=McAfee;i="6700,10204,11322"; a="55381126"
X-IronPort-AV: E=Sophos;i="6.13,224,1732608000"; 
   d="scan'208";a="55381126"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2025 21:58:50 -0800
X-CSE-ConnectionGUID: iveFudNbSKSrD/omeKvQsQ==
X-CSE-MsgGUID: hPpDSx67Re28AvwEzkdlbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,224,1732608000"; 
   d="scan'208";a="106851723"
Received: from apgc00009.png.altera.com ([10.244.70.6])
  by fmviesa006.fm.intel.com with ESMTP; 21 Jan 2025 21:58:46 -0800
From: Mahesh Rao <mahesh.rao@intel.com>
Subject: [PATCH 0/3] stratix10: miscellaneous changes and fix for child
 driver probing
Date: Wed, 22 Jan 2025 13:58:42 +0800
Message-Id: <20250122-socfpga_sip_svc_misc-v1-0-cbdcd034ae34@intel.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABKJkGcC/x3MSwqAMAwA0atI1hZiQfxcRaS0MdUs1NKACOLdL
 S7fYuYB5SysMFYPZL5E5TwKmroC2vyxspGlGCzaFhscjJ4U0+qdSnJ6kdtFyYRASwydR7Q9lDR
 ljnL/22l+3w+xdOSzZgAAAA==
X-Change-ID: 20250109-socfpga_sip_svc_misc-bbcdfb7a0028
To: Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>, 
 Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-fpga@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mahesh Rao <mahesh.rao@altera.com>, 
 Mahesh Rao <mahesh.rao@intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737525526; l=1194;
 i=mahesh.rao@intel.com; s=20250107; h=from:subject:message-id;
 bh=Q7XVhlMW9Tgmsho4UsQVqJikg9MTpE1DdY0zKBEgu2Q=;
 b=inMXrKemwuCywjcYXRoyH3xau8bizyua+g9fKVPmligk4pYs3mW98psyvENiaPIsMek3h30Fz
 dyR1NYXXw37BfiWXv2hR47iI0l93qXS3cVbsdM0K5UTnmtOGqo8QNB9
X-Developer-Key: i=mahesh.rao@intel.com; a=ed25519;
 pk=tQiFUzoKxHrQLDtWeEeaeTeJTl/UfclUHWZy1fjSiyg=

The patch set includes the following changes:

- Conversion of the devicetree binding file to JSON-schema for the Stratix10
  SVC driver and its child stratix10 fpga manager driver.
- Addition of support for probing the child driver. This fixes the failure
  of child driver probing as the SVC driver node has been moved out of the
  SoC node.

Signed-off-by: Mahesh Rao <mahesh.rao@intel.com>
---
Mahesh Rao (3):
      dt-bindings: fpga: stratix10: Convert to json-schema
      dt-bindings: firmware: stratix10: Convert to json-schema
      firmware: stratix10-svc: Add of_platform_default_populate()

 .../bindings/firmware/intel,stratix10-svc.txt      | 57 ---------------
 .../bindings/firmware/intel,stratix10-svc.yaml     | 84 ++++++++++++++++++++++
 .../fpga/intel,stratix10-soc-fpga-mgr.yaml         | 32 +++++++++
 .../bindings/fpga/intel-stratix10-soc-fpga-mgr.txt | 18 -----
 drivers/firmware/stratix10-svc.c                   | 14 +++-
 5 files changed, 127 insertions(+), 78 deletions(-)
---
base-commit: ffd294d346d185b70e28b1a28abe367bbfe53c04
change-id: 20250109-socfpga_sip_svc_misc-bbcdfb7a0028

Best regards,
-- 
Mahesh Rao <mahesh.rao@intel.com>



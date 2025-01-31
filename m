Return-Path: <linux-fpga+bounces-1024-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1328AA23C11
	for <lists+linux-fpga@lfdr.de>; Fri, 31 Jan 2025 11:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 703E2188A3E0
	for <lists+linux-fpga@lfdr.de>; Fri, 31 Jan 2025 10:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1D11A0BD7;
	Fri, 31 Jan 2025 10:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h1si7qW+"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3859517B50A;
	Fri, 31 Jan 2025 10:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738318661; cv=none; b=Cbcdw3uMZzCHYizRpbOqVc3GOluoND7FfO68IJc3jGLM7/PiSZ1D8OQC3VGpzYoOryWDOI6wZdpHtGBuMZnE8IO6xRucX4vbUYU6q201uUVtRMQD+rRHUfNjrr06JJPlbfXem6FDjYwogqu4JgaIX65+7xrwjtWt0AYRSmuTa0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738318661; c=relaxed/simple;
	bh=A9/mYfP+OD/0j0zfraXjknqg/Xt/IbJ7KyXe9WJnOOg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GXQdYpWSFjoGWxPwXaJ89XgkgXPhOcHkqGA3PvIgW59QtdS/8hSJVlJ7YVnHF6sWBNTkAALyojRUB/CJwBIT9WZoQCT8RfLJq/yr7e3xBKHN4cp1L3XtS8W3BixgenU/r9UWhZzlfQDPq9X0jCHC7sgh/rH1XjIqH+Uxu/IoyOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h1si7qW+; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738318659; x=1769854659;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=A9/mYfP+OD/0j0zfraXjknqg/Xt/IbJ7KyXe9WJnOOg=;
  b=h1si7qW+8o0J6SAPMjbqynoEAgfFVwCPVKT8yAMVKSuaTiW1KvhKoRfQ
   91y0Nee8PyM9e8HfJwmRRVqgekjxtYRNplW3cZrFa9XCwXtvJnfspFkZs
   mwMVeQQ25/xA7Qf0HSJuXfLCZYRODQ7kV5VSOEZ1LZIXLYAxzvVLctSeX
   PUvyBnnWacnDz1fPbOjuadpUhdfvjhdF/StiywfePnoRODRx1UBZR4rbd
   wALIIer60DQ4LXiyDmKUHRsnR0LGxaW0JqQnxoAiAJr+z1CN6I6H9oxUc
   q0y9EDx2Q9eFuAOYTmH//T1ArhscCCKoTd5jnbB2KRoIkkOLKUxLibbZ2
   A==;
X-CSE-ConnectionGUID: YMY9hY7VTAG7+nvuuhMCDw==
X-CSE-MsgGUID: hi7zRDr7THKpUnao723muQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11331"; a="38777207"
X-IronPort-AV: E=Sophos;i="6.13,248,1732608000"; 
   d="scan'208";a="38777207"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2025 02:17:38 -0800
X-CSE-ConnectionGUID: Ik9Mj5lLQ5SycvG65zzElw==
X-CSE-MsgGUID: GRLBwycgRvqs9fmyICpi8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,248,1732608000"; 
   d="scan'208";a="114596173"
Received: from apgcp0c531115.png.altera.com ([10.244.76.209])
  by fmviesa004.fm.intel.com with ESMTP; 31 Jan 2025 02:17:35 -0800
From: Mahesh Rao <mahesh.rao@intel.com>
Subject: [PATCH v2 0/3] stratix10: miscellaneous changes and fix for child
 driver probing
Date: Fri, 31 Jan 2025 18:17:23 +0800
Message-Id: <20250131-socfpga_sip_svc_misc-v2-0-eeed4ebc35f9@intel.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADOjnGcC/22NywqDMBBFf0Vm3ZQxWvpY9T+KSDKJOlCNZCS0i
 P/eVLrs8hy4564gPrIXuBUrRJ9YOEwZ9KEAGszUe8UuM2jUJyzxqiRQN/emFZ5bSdSOLKSsJdf
 Zs0HUF8jTOfqOX3v20WQeWJYQ3/tLKr/2F9T6fzCVChVZRw6r2viqvvO0+OeRwgjNtm0fEQ49D
 bgAAAA=
X-Change-ID: 20250109-socfpga_sip_svc_misc-bbcdfb7a0028
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738318654; l=1582;
 i=mahesh.rao@intel.com; s=20250107; h=from:subject:message-id;
 bh=A9/mYfP+OD/0j0zfraXjknqg/Xt/IbJ7KyXe9WJnOOg=;
 b=t4qytP/UpuSFd6rfZU7WuUJqJ0qJXcX2m+x6VSjFqpjAZ5hYZuIfs8zw/yb24D9xNLRdExing
 Z9/3VpVxR5MCxFj+xRw/zdUgtdt6uTc5f4IG3K6WweezbvgQwlQPQ4c
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
Changes in v2:
  * Added brief description on stratix10 soc fpga manager
    in the binding files.
  * method property in stratix10-svc binding file was
    changed to array of strings.
  * Updated/fixed the usage of of_platform_depopulate()
    in the stratix10-svc driver.

- Link to v1: https://lore.kernel.org/r/20250122-socfpga_sip_svc_misc-v1-0-cbdcd034ae34@intel.com

---
Mahesh Rao (3):
      dt-bindings: fpga: stratix10: Convert to json-schema
      dt-bindings: firmware: stratix10: Convert to json-schema
      firmware: stratix10-svc: Add of_platform_default_populate()

 .../bindings/firmware/intel,stratix10-svc.txt      | 57 -------------
 .../bindings/firmware/intel,stratix10-svc.yaml     | 94 ++++++++++++++++++++++
 .../fpga/intel,stratix10-soc-fpga-mgr.yaml         | 36 +++++++++
 .../bindings/fpga/intel-stratix10-soc-fpga-mgr.txt | 18 -----
 drivers/firmware/stratix10-svc.c                   | 14 +++-
 5 files changed, 141 insertions(+), 78 deletions(-)
---
base-commit: ffd294d346d185b70e28b1a28abe367bbfe53c04
change-id: 20250109-socfpga_sip_svc_misc-bbcdfb7a0028

Best regards,
-- 
Mahesh Rao <mahesh.rao@intel.com>



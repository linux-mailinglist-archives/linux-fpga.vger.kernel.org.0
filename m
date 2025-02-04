Return-Path: <linux-fpga+bounces-1034-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34872A272A3
	for <lists+linux-fpga@lfdr.de>; Tue,  4 Feb 2025 14:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B195A3A67C1
	for <lists+linux-fpga@lfdr.de>; Tue,  4 Feb 2025 13:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14776212D6D;
	Tue,  4 Feb 2025 12:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MXsOXZnn"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4B421128A;
	Tue,  4 Feb 2025 12:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738673908; cv=none; b=TSkrxq2pdQ/sOEP0Yjm8/qOxQrWqvfXVbBHMLmA3zHvqMHzWiDLzJbEStbnQDtEyPhaCsTQ65WWtnnx6BckjJDsf3Mot+ZPR+O/7Ymxoi6W7iHDC/UvAG9kSTPs7rPw1QbOKaWNj6hzHZcWyClHfaYsnBoJNppLaLFf1eZSWO60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738673908; c=relaxed/simple;
	bh=pXe2aqU/rvOurFe5wAFRO0y/dkH0dBSuhsyCIBwgDz8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DoIlJ3ZMs/MwC6tGBDka2Pc8dVD15+6oPiqP1nD4t6FZrTYrAzxdav8VpFn8XwLhvTX90fE4pkULvcXaiXCddXsUoVE77USqnnn4kw3mgNLWBrXVL9rgx3JFQe9nnPegAqY2vlpUejT8SOTMzWgzH5c40pnRFJ5x7uB/vzDH9Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MXsOXZnn; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738673906; x=1770209906;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=pXe2aqU/rvOurFe5wAFRO0y/dkH0dBSuhsyCIBwgDz8=;
  b=MXsOXZnn6+NyypJaI5KS+5ec1TJZgt9ha8TdtsUP8PrwN69HrLIG1eCa
   7j3BKKEn0UTVAIGB1Xj7ziYZdUv1VyOx0bFF4fHWpF1JKiGg75hfhCwyl
   A46JVpCzbh8X+KSzEKitZpLrBb/We+bsBqE//nXe+sZXTwk3QB2AL5Glh
   gnd9LEPo3E9XM3AYPdeVIsOTdNTvRCszG2XoBPlOV8IyH3gaiIpVrimKO
   vkcbupGeY1oD9382nHi8ntzTcrVBevanj+WVkT9nybFKbJxVjBAzjXrm3
   gcE7APX68uzQPkzsyCLJSxwfnCiq9HFdRwPbj/4+qQcnEb+hEpasFwYob
   A==;
X-CSE-ConnectionGUID: 2TmuYnEqRjKNy0yJRpAfyg==
X-CSE-MsgGUID: xqDrg80zSFaDErR46n4Avw==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39096970"
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; 
   d="scan'208";a="39096970"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 04:58:20 -0800
X-CSE-ConnectionGUID: nbAIxL0dS6eCFSr8iU031w==
X-CSE-MsgGUID: sVwdD2lbR7Ox+IsfL9X7iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="133834269"
Received: from apgcp0c531115.png.altera.com ([10.244.76.209])
  by fmviesa002.fm.intel.com with ESMTP; 04 Feb 2025 04:58:16 -0800
From: Mahesh Rao <mahesh.rao@intel.com>
Subject: [PATCH v3 0/3] stratix10: miscellaneous changes and fix for child
 driver probing
Date: Tue, 04 Feb 2025 20:58:04 +0800
Message-Id: <20250204-socfpga_sip_svc_misc-v3-0-697f7f153cfa@intel.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANwOomcC/3XNTQqDMBCG4atI1k3Jj9LaVe9RipjJRAdaI4mEF
 vHujdKFi3b5fjDPzCxiIIzsUswsYKJIfsihDwWDvh065GRzMyVUJaSoefTgxq5tIo1NTNA8KQI
 3Bqwzp1YIdWb5dAzo6LWxt3vunuLkw3v7kuS6fkGlfoNJcsHBWLBCly3q8krDhI8j+CdbwaR2i
 JZ/EJURRLQlGtCVq/fIsiwfwoRKLv0AAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738673895; l=1876;
 i=mahesh.rao@intel.com; s=20250107; h=from:subject:message-id;
 bh=pXe2aqU/rvOurFe5wAFRO0y/dkH0dBSuhsyCIBwgDz8=;
 b=lM95x2jqB1+UZAkt0qPglb2/N6GoGEGqdzO60JlJinGdcv2hHpbw9nqjE2WQXhOiQU5H1/K06
 aQXI3x+tGyGCjYdt2upSK6aHNQLSUMygSjX6q5f3+1BGiaOlwWqI9lE
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
Changes in v3:
  * Updated reserved-memory node as per dt-schema.
  * Adjusted the indentation and corrected usage for
    multi-paragraph description in stratix10-svc
    binding file.

- Link to v2: https://lore.kernel.org/r/20250131-socfpga_sip_svc_misc-v2-0-eeed4ebc35f9@intel.com

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
 .../bindings/firmware/intel,stratix10-svc.yaml     | 93 ++++++++++++++++++++++
 .../fpga/intel,stratix10-soc-fpga-mgr.yaml         | 36 +++++++++
 .../bindings/fpga/intel-stratix10-soc-fpga-mgr.txt | 18 -----
 drivers/firmware/stratix10-svc.c                   | 14 +++-
 5 files changed, 140 insertions(+), 78 deletions(-)
---
base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
change-id: 20250109-socfpga_sip_svc_misc-bbcdfb7a0028

Best regards,
-- 
Mahesh Rao <mahesh.rao@intel.com>



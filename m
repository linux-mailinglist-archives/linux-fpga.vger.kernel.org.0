Return-Path: <linux-fpga+bounces-522-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 395AA8B681B
	for <lists+linux-fpga@lfdr.de>; Tue, 30 Apr 2024 04:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 650911C21730
	for <lists+linux-fpga@lfdr.de>; Tue, 30 Apr 2024 02:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2326D53B;
	Tue, 30 Apr 2024 02:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ixQll0cn"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2586ED517
	for <linux-fpga@vger.kernel.org>; Tue, 30 Apr 2024 02:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714445899; cv=none; b=ovsTxcOAsGl9ZKbXg97qoMhK21l2sa2vfat/THXsUxXnBFPAJErMGJHH9pwDTsVXWVniR3w1mFh4PvksRg9vW054HIv4xpygkzQrkxxm+Zw2+k9PNBe1XH43dxGCtjGmnYzeREO4+T79GQPN3dAQ5n6W/d7mEJLGTRdWF2rrgkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714445899; c=relaxed/simple;
	bh=ekn9qnZWUP0PBTxH6cdWo6gQQ5pRxGYziH1bSnTMp+4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bVgAU+HT+33YlOBQVrQTtyff1Zw9KFwiMwi0oNkMHdLea3YsWwR3RmvknYJlRJ0K/weWniHaynADsBDPRSZWaMz4+o98AZNNDjSG92vuL/7IwHAMEDjHgX0CeEH4j8vgoL7ppsnA6RK8RWOQ0CIsLVB1p/1rmFvh+dyXZjssA/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ixQll0cn; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714445898; x=1745981898;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ekn9qnZWUP0PBTxH6cdWo6gQQ5pRxGYziH1bSnTMp+4=;
  b=ixQll0cn4SYGyH5WCQui95C6OwtLmzGt1LQsrNY4dcz2nX/rUD47PMrG
   oyAgqA+oNAv4tVMqJGFEn9AOtWJTxL24rzxwyOASbRePwyGHZTnT3uhN+
   09oLzaiyZ9i7CIfrbZ5ddPmT7Kas02APzByCocp16EY3R/7xbI/1uweuw
   c3KdeNBTZMSpPnXA8a3fommcpU9ITbmTyA/SbK4HTTtejl7lKlvoehG4B
   bP60WjZ09l810QNqPVuqdwnQmuyEHpBpYYU/2bCbqb4whQeW/c4BkY95O
   tzfHwTgPrBfCimLiQbsmsOPq3R/Dr+03Alq5EzAOkTx0xeDJhptyyu9xQ
   w==;
X-CSE-ConnectionGUID: yMaQ6ZbcSIugnOIOF0chfA==
X-CSE-MsgGUID: 7tw+H5RlQiaDmd4PaOgYVw==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="10349375"
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="10349375"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 19:58:17 -0700
X-CSE-ConnectionGUID: P7yg9hDRTFmD8iPvBDHhCw==
X-CSE-MsgGUID: n6sYSXXNSZ6cKF83pb/JgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="26814005"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa007.jf.intel.com with ESMTP; 29 Apr 2024 19:58:15 -0700
Date: Tue, 30 Apr 2024 10:52:46 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: gregkh@linuxfoundation.org
Cc: yilun.xu@linux.intel.com, yilun.xu@intel.com,
	linux-fpga@vger.kernel.org, hao.wu@intel.com, mdf@kernel.org
Subject: [GIT PULL] FPGA Manager changes for 6.10-rc1
Message-ID: <ZjBc/ta+Luxdp8Dr@yilunxu-OptiPlex-7050>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga tags/fpga-for-6.20-rc1

for you to fetch changes up to b7c0e1ecee403a43abc89eb3e75672b01ff2ece9:

  fpga: region: add owner module and take its refcount (2024-04-23 15:37:20 +0800)

----------------------------------------------------------------
FPGA Manager changes for 6.10-rc1

FPGA MGR core:

- Marco's change adds module owner parameter for all registration APIs.

FPGA test:

- Macro's change uses KUnit devices instead of platform devices.

DFL:

- Peter's change cleans up unused symbols.

Xlinux:

- Charles adds SelectMAP interface reprogramming support.
- Andy's header inclusion cleanup.

Altera:

- Krzysztof & Christophe's cleanup for drivers.

----------------------------------------------------------------
Andy Shevchenko (1):
      fpga: ice40-spi: Don't use "proxy" headers

Charles Perry (4):
      fpga: xilinx-spi: extract a common driver core
      dt-bindings: fpga: xlnx,fpga-selectmap: add DT schema
      fpga: xilinx-selectmap: add new driver
      fpga: xilinx-core: add new gpio names for prog and init

Christophe JAILLET (1):
      fpga: altera-cvp: Remove an unused field in struct altera_cvp_conf

Krzysztof Kozlowski (1):
      fpga: altera: drop driver owner assignment

Marco Pagani (4):
      fpga: manager: add owner module and take its refcount
      fpga: bridge: add owner module and take its refcount
      fpga: tests: use KUnit devices instead of platform devices
      fpga: region: add owner module and take its refcount

Peter Colberg (2):
      fpga: dfl: remove unused function is_dfl_feature_present()
      fpga: dfl: remove unused member pdata from struct dfl_{afu,fme}

 .../bindings/fpga/xlnx,fpga-selectmap.yaml         |  86 ++++++++
 Documentation/driver-api/fpga/fpga-bridge.rst      |   7 +-
 Documentation/driver-api/fpga/fpga-mgr.rst         |  34 +--
 Documentation/driver-api/fpga/fpga-region.rst      |  13 +-
 drivers/fpga/Kconfig                               |  12 ++
 drivers/fpga/Makefile                              |   2 +
 drivers/fpga/altera-cvp.c                          |   1 -
 drivers/fpga/altera-ps-spi.c                       |   1 -
 drivers/fpga/dfl-afu-main.c                        |   2 -
 drivers/fpga/dfl-afu.h                             |   3 -
 drivers/fpga/dfl-fme-main.c                        |   2 -
 drivers/fpga/dfl-fme.h                             |   2 -
 drivers/fpga/dfl.h                                 |   5 -
 drivers/fpga/fpga-bridge.c                         |  57 ++---
 drivers/fpga/fpga-mgr.c                            |  82 +++++---
 drivers/fpga/fpga-region.c                         |  24 ++-
 drivers/fpga/ice40-spi.c                           |   4 +-
 drivers/fpga/tests/fpga-bridge-test.c              |  33 +--
 drivers/fpga/tests/fpga-mgr-test.c                 |  16 +-
 drivers/fpga/tests/fpga-region-test.c              |  41 ++--
 drivers/fpga/xilinx-core.c                         | 229 +++++++++++++++++++++
 drivers/fpga/xilinx-core.h                         |  27 +++
 drivers/fpga/xilinx-selectmap.c                    |  95 +++++++++
 drivers/fpga/xilinx-spi.c                          | 224 ++------------------
 include/linux/fpga/fpga-bridge.h                   |  10 +-
 include/linux/fpga/fpga-mgr.h                      |  26 ++-
 include/linux/fpga/fpga-region.h                   |  13 +-
 27 files changed, 676 insertions(+), 375 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,fpga-selectmap.yaml
 create mode 100644 drivers/fpga/xilinx-core.c
 create mode 100644 drivers/fpga/xilinx-core.h
 create mode 100644 drivers/fpga/xilinx-selectmap.c


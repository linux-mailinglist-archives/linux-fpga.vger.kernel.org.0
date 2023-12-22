Return-Path: <linux-fpga+bounces-85-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1637A81CA51
	for <lists+linux-fpga@lfdr.de>; Fri, 22 Dec 2023 13:54:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4809F1C20F4A
	for <lists+linux-fpga@lfdr.de>; Fri, 22 Dec 2023 12:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5956C18B00;
	Fri, 22 Dec 2023 12:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cX3q1Ayj"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1BD18AE4
	for <linux-fpga@vger.kernel.org>; Fri, 22 Dec 2023 12:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703249636; x=1734785636;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=5K4d1ia9ndxMQLxtwCC+0mQc5EQsb4GcrR7bGiJfmOc=;
  b=cX3q1Ayj8lW75KQMh9aCLgWkj/uG7isc+zo1kBI72nuCUPoyD9b8yhnA
   ouLpO68JxxO0etAKOpAbotOt45oCTZFNTzxw6Z0phhepUZmwIUXULDTIr
   tMki6L9kbB2zngeG2vB3dSG6dOWFCsHUkcLsHV/Mz3eHn+qKJ8zA0AbxB
   JvxT7yCDNbR4GWZUxOT+06rkDXL3PWCWOdmGw2NpRIX44t8wc1JzrD6UT
   xzZbvSHTEQ2qYNAQwQF2SelN+utQneSeLoZXUk7Kl0hgy2SHCqGBoToy4
   +imF59cH6exEXhBTp2jPJrtFHavi3JfEBvljOHUUXnOG2Nxyds6/VNQSN
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="427273058"
X-IronPort-AV: E=Sophos;i="6.04,296,1695711600"; 
   d="scan'208";a="427273058"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 04:53:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="867630771"
X-IronPort-AV: E=Sophos;i="6.04,296,1695711600"; 
   d="scan'208";a="867630771"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Dec 2023 04:53:54 -0800
Date: Fri, 22 Dec 2023 20:51:20 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: gregkh@linuxfoundation.org
Cc: yilun.xu@linux.intel.com, yilun.xu@intel.com,
	linux-fpga@vger.kernel.org, hao.wu@intel.com, mdf@kernel.org
Subject: [GIT PULL] FPGA Manager changes for 6.8-rc1 part two
Message-ID: <ZYWGSOYo3x06z8of@yilunxu-OptiPlex-7050>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The following changes since commit 5496fb8eedd637e1e9d87655f86dc816afd5ad68:

  drivers/fpga: use standard array-copy function (2023-11-17 16:34:26 +0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga tags/fpga-for-6.8-rc1-2

for you to fetch changes up to c849ecb2ae8413f86c84627cb0af06dffce4e215:

  fpga: zynq-fpga: Convert to platform remove callback returning void (2023-12-21 22:33:46 +0800)

----------------------------------------------------------------
FPGA Manager changes for 6.8-rc1 second part

Not sure if it's too late for 6.8 rc1, but I try to speed up this
intermediate change.

- Uwe's change convert to new platform remove callback.

All patches have been reviewed on the mailing list, and have been in the
last linux-next releases (as part of our for-next branch).

Signed-off-by: Xu Yilun <yilun.xu@intel.com>

----------------------------------------------------------------
Uwe Kleine-König (13):
      fpga: altera-fpga2sdram: Convert to platform remove callback returning void
      fpga: altera-freeze-bridge: Convert to platform remove callback returning void
      fpga: altera-hps2fpga: Convert to platform remove callback returning void
      fpga: dfl-afu-main: Convert to platform remove callback returning void
      fpga: dfl-fme-br: Convert to platform remove callback returning void
      fpga: dfl-fme-main: Convert to platform remove callback returning void
      fpga: dfl-fme-region: Convert to platform remove callback returning void
      fpga: intel-m10-bmc-sec-update: Convert to platform remove callback returning void
      fpga: of-fpga-region: Convert to platform remove callback returning void
      fpga: socfpga-a10: Convert to platform remove callback returning void
      fpga: stratix10-soc: Convert to platform remove callback returning void
      fpga: xilinx-pr-decoupler: Convert to platform remove callback returning void
      fpga: zynq-fpga: Convert to platform remove callback returning void

 drivers/fpga/altera-fpga2sdram.c        | 6 ++----
 drivers/fpga/altera-freeze-bridge.c     | 6 ++----
 drivers/fpga/altera-hps2fpga.c          | 6 ++----
 drivers/fpga/dfl-afu-main.c             | 6 ++----
 drivers/fpga/dfl-fme-br.c               | 6 ++----
 drivers/fpga/dfl-fme-main.c             | 6 ++----
 drivers/fpga/dfl-fme-region.c           | 6 ++----
 drivers/fpga/intel-m10-bmc-sec-update.c | 6 ++----
 drivers/fpga/of-fpga-region.c           | 6 ++----
 drivers/fpga/socfpga-a10.c              | 6 ++----
 drivers/fpga/stratix10-soc.c            | 6 ++----
 drivers/fpga/xilinx-pr-decoupler.c      | 6 ++----
 drivers/fpga/zynq-fpga.c                | 6 ++----
 13 files changed, 26 insertions(+), 52 deletions(-)


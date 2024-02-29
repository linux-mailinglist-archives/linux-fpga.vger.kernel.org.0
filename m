Return-Path: <linux-fpga+bounces-298-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C02BB86BF0F
	for <lists+linux-fpga@lfdr.de>; Thu, 29 Feb 2024 03:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2F3F1C2121C
	for <lists+linux-fpga@lfdr.de>; Thu, 29 Feb 2024 02:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9BF6286A7;
	Thu, 29 Feb 2024 02:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RfrcV2Vs"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C307F26AEA
	for <linux-fpga@vger.kernel.org>; Thu, 29 Feb 2024 02:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709174456; cv=none; b=gPPg8FOl8vhcoXDZ+6khExmnfGh00DGOcL8hoCX96L0kAe/VF830wZSjVSt4uUXSLSh9nUlN92VPGQ9tMHRU77FgBFc5Qco2r5fL5fqc6p/O34AlsPlFkivsd5X4P3X+pvmbCBRl1kclFPduBHnmXPQsuM2MG2Zy8JOKgH42NNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709174456; c=relaxed/simple;
	bh=EToCnTh+J0F9s6geSMUP9N/uP0wXxSFYj7Sy5jQQXSM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HyDImyD/+6BD6GmXILPTcbw+6WGs2cmeQouh6mMS2/blwgTLP2NKf4t8NhcTdc1qFgRR+1VKtPvjOAz6MJCaDPZiigcoYEozVxUJkcrJb0H1tiD2nXOcgzZlIlKlYE5McTTjRK0p+iUZK/3F348vyGwBH5vnj4jjds81tjFF8gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RfrcV2Vs; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709174454; x=1740710454;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=EToCnTh+J0F9s6geSMUP9N/uP0wXxSFYj7Sy5jQQXSM=;
  b=RfrcV2VsQFY1I4bGLMUM3NHPJU3bGbqpqvkphZIxJMX2krDY/RjW+Nmb
   1+j3DzzIEDKvGRI5mSOpbA4DACN59FallMizQfJd90LPtWZcu4z03kRBL
   D/H5AHfumWqzN8DZ37lAYC4wG8cEiGMOUi1Yaz4ltSLcT2e8QrTlc/urf
   UaJCk++ag/wIoCi1Ks94bssB6o+izD1BC9xJwU6VmrdcG45/XnomDaj2F
   hrfkTjUvby1ebcMk8Wd6uiAIvOX212UeiMTq61RXSoUTKwtC0suDEvklv
   3vCfs6J5uku9pVIAoJmv5QwCTyYvEW89Rt2YzPYKqk4nyihQT/bM9fDRw
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="3783548"
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; 
   d="scan'208";a="3783548"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 18:40:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; 
   d="scan'208";a="7772944"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa008.fm.intel.com with ESMTP; 28 Feb 2024 18:40:50 -0800
Date: Thu, 29 Feb 2024 10:36:45 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: gregkh@linuxfoundation.org
Cc: yilun.xu@linux.intel.com, yilun.xu@intel.com,
	linux-fpga@vger.kernel.org, hao.wu@intel.com, mdf@kernel.org
Subject: [GIT PULL] FPGA Manager changes for 6.9-rc1
Message-ID: <Zd/tvYnZg31SJLKz@yilunxu-OptiPlex-7050>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga tags/fpga-for-6.9-rc1

for you to fetch changes up to b1a91ca25f15b6d7b311de4465854a5981dee3d3:

  fpga: remove redundant checks for bridge ops (2024-02-18 18:07:06 +0800)

----------------------------------------------------------------
FPGA Manager changes for 6.9-rc1

DFL:

- Ricardo's change makes dfl_bus_type const.

FPGA MGR core:

- Marco's change removes redundant checks for bridge ops.

All patches have been reviewed on the mailing list, and have been in the
last linux-next releases (as part of our for-next branch).

Signed-off-by: Xu Yilun <yilun.xu@intel.com>

----------------------------------------------------------------
Marco Pagani (1):
      fpga: remove redundant checks for bridge ops

Ricardo B. Marliere (1):
      fpga: dfl: make dfl_bus_type const

 drivers/fpga/dfl.c         | 2 +-
 drivers/fpga/fpga-bridge.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)


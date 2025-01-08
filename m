Return-Path: <linux-fpga+bounces-994-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D01A07031
	for <lists+linux-fpga@lfdr.de>; Thu,  9 Jan 2025 09:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D739B164AB3
	for <lists+linux-fpga@lfdr.de>; Thu,  9 Jan 2025 08:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431E621504D;
	Thu,  9 Jan 2025 08:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="focsUpEX"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DCE206F3E
	for <linux-fpga@vger.kernel.org>; Thu,  9 Jan 2025 08:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736412005; cv=none; b=i8+1g15awBaRehTzH/LJqDtJuJ0oRHNoaFfCNl5jsb4/VZHiZgeaxPPPzQTLLayDGGGuJbUGsn8xHXHVk9yX+2wA1maXrkRfLo58oiFkMSx8rO4VobugoMFeWwLyT7Ya0zvgKfOtpAxbAfcXwQpKBkoSu5+qMKYDfIrygw7VCXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736412005; c=relaxed/simple;
	bh=WutN+eqG56Gs57UTLqm81H5tjSaJNmobSXIsVXVfP4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=iByLZl9bCAhyRIVS4aJu1XOWMkRMTppkpocsP9K3r5jcm2vmcjJMidURSWa6y1Ht51hYInn7pwWp9sVUwKwUeIZSNTFeDGGOslFoDHFnycuz2vziJhIegZ5PWep2Bwpq1VD7ZQRKCX/v0hyDeEKcUNPO7xvm0GMK28+3RLVNNJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=focsUpEX; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736412003; x=1767948003;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WutN+eqG56Gs57UTLqm81H5tjSaJNmobSXIsVXVfP4Q=;
  b=focsUpEXeHyZWOC27XP/IYCOnon4QwMIyJsc0EckunZ8tcIB0cH2Yp6u
   mXj2eAOG58EK1SSuG5GN+ZiaFpwTT2XeA2OHzgyt1KZrl5/jUiem3sNmd
   nC1qz/4xFsAE8oJCBGv+8oIfH4rVBVRfEGVFV7UyUsStBKMfBwkFmPW6p
   /i1VRqoUSdi+nC3jrNI2//qfoN5yS+NBOhpcvmqK9W272Jv8psrb4F4w8
   eDQCQATLdaysCxwMaz3DhBAcTikkreQojzXH/HF3TfToya2Xvwpg6NLlV
   iFo4xFyaJWCCUWQW6Wb0+imqFLENrizNXzbHKAmZ9rGhwiETNNull1mva
   w==;
X-CSE-ConnectionGUID: bVa3EkK5SS+LfeP+eB9itA==
X-CSE-MsgGUID: +hCEVAvGRDWTOd6mxJWdrQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11309"; a="35948480"
X-IronPort-AV: E=Sophos;i="6.12,300,1728975600"; 
   d="scan'208";a="35948480"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2025 00:40:02 -0800
X-CSE-ConnectionGUID: cU0sZZm1RASubQ4od4Ynzw==
X-CSE-MsgGUID: aw6PH4K0Q9GdqJQTj7XpnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,300,1728975600"; 
   d="scan'208";a="103537283"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa008.fm.intel.com with ESMTP; 09 Jan 2025 00:40:01 -0800
Date: Thu, 9 Jan 2025 04:38:59 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: gregkh@linuxfoundation.org
Cc: yilun.xu@linux.intel.com, yilun.xu@intel.com,
	linux-fpga@vger.kernel.org, mdf@kernel.org
Subject: [GIT PULL] FPGA Manager changes for 6.14-rc1
Message-ID: <Z37iY9vD0ZG2ykZW@yilunxu-OptiPlex-7050>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 40384c840ea1944d7c5a392e8975ed088ecf0b37:

  Linux 6.13-rc1 (2024-12-01 14:28:56 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga tags/fpga-for-6.14-rc1

for you to fetch changes up to 46b155acbf4ee4ebf6bd7d5661b08762220ab894:

  fpga: dfl: destroy/recreate feature platform device on port release/assign (2024-12-18 22:28:48 +0800)

----------------------------------------------------------------
FPGA Manager changes for 6.14-rc1

- Peter's change fixes SRIOV problems for Intel DFL device.

All patches have been reviewed on the mailing list, and have been in the
last linux-next releases (as part of our for-next branch).

Signed-off-by: Xu Yilun <yilun.xu@intel.com>

----------------------------------------------------------------
Peter Colberg (17):
      fpga: dfl: omit unneeded argument pdata from dfl_feature_instance_init()
      fpga: dfl: return platform data from dfl_fpga_inode_to_feature_dev_data()
      fpga: dfl: afu: use parent device to log errors on port enable/disable
      fpga: dfl: afu: define local pointer to feature device
      fpga: dfl: pass feature platform data instead of device as argument
      fpga: dfl: factor out feature data creation from build_info_commit_dev()
      fpga: dfl: store FIU type in feature platform data
      fpga: dfl: refactor internal DFL APIs to take/return feature device data
      fpga: dfl: factor out feature device registration
      fpga: dfl: factor out feature device data from platform device data
      fpga: dfl: convert features from flexible array member to separate array
      fpga: dfl: store MMIO resources in feature device data
      fpga: dfl: store platform device name in feature device data
      fpga: dfl: store platform device id in feature device data
      fpga: dfl: allocate platform device after feature device data
      fpga: dfl: remove unneeded function build_info_create_dev()
      fpga: dfl: drop unneeded get_device() and put_device() of feature device

Xu Yilun (1):
      fpga: dfl: destroy/recreate feature platform device on port release/assign

 drivers/fpga/dfl-afu-dma-region.c | 117 +++++-----
 drivers/fpga/dfl-afu-error.c      |  59 ++---
 drivers/fpga/dfl-afu-main.c       | 278 ++++++++++++------------
 drivers/fpga/dfl-afu-region.c     |  51 ++---
 drivers/fpga/dfl-afu.h            |  26 +--
 drivers/fpga/dfl-fme-br.c         |  24 +-
 drivers/fpga/dfl-fme-error.c      |  98 +++++----
 drivers/fpga/dfl-fme-main.c       |  95 ++++----
 drivers/fpga/dfl-fme-pr.c         |  86 ++++----
 drivers/fpga/dfl.c                | 445 +++++++++++++++++++-------------------
 drivers/fpga/dfl.h                | 140 +++++++-----
 11 files changed, 720 insertions(+), 699 deletions(-)


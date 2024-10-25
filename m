Return-Path: <linux-fpga+bounces-893-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 911DB9B12BD
	for <lists+linux-fpga@lfdr.de>; Sat, 26 Oct 2024 00:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4E9E1C20C17
	for <lists+linux-fpga@lfdr.de>; Fri, 25 Oct 2024 22:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C6721312B;
	Fri, 25 Oct 2024 22:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T+fFI7kH"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297911D4148;
	Fri, 25 Oct 2024 22:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729895852; cv=none; b=YnOEiaPjrT0iuiA3gYBmgYuS3kOipky+2ULMk7E0msSRRDFgOjXAhSA+1lUJvjNtNuJDwMtArEVMbnLI+fvwj6lIQMhVHq24MN7nXwg8+tM4XaH4wFxiKXq5vcmsM/nJSvlL+csdKky+26g+UkREAWp/EDsK7yeXNUvXe7sHpW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729895852; c=relaxed/simple;
	bh=pdIvKCUXOz0e83ZH+U2/Hi9zAS6WH8FTGzRBFrQcy+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A4GYEmuFMiL39ck//mVtcSxGO36htN+c7OfORpo43drgmSdTHAWc5OHr6g2Y1lNM5azLfAoZuzDjD2BKjfX3rmwYDV0ppLJ402csDy1650ApchHgQc902Ej0NDynm6Dlb+YzRj0+8h3o7yXIEDU2NADytAG+eHb4lHa1mBKO3Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T+fFI7kH; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729895850; x=1761431850;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pdIvKCUXOz0e83ZH+U2/Hi9zAS6WH8FTGzRBFrQcy+Y=;
  b=T+fFI7kHmjrm4YfAhZL5n6Ff/ff2AKPmqK08ObvesBtO1eJsuMINOnTA
   xGrglevMQOarugqtO84W4Gys8cEltBaErgKG0eALkWkB1sagNQ/6ZxQ57
   lbbdf59CV7boAddr7xyEELKXSv32nRZZgE9F1bWMVjNLB2L1iFqMsuRZk
   64Oa36uh6aKOvDcMF0HUvCSxLuqiDWoocpCJLv3UIC47k6XW7+wf2kC7g
   CvDJs3MRWA7RPupeB9ahAMOlseZBbEJ+hbWU/W+Y9QkhhF0kLMWFrRZt1
   iGEGI3lpJId9GFBZOBLFXQxNALE8qDxkwGKvQgOJkowjZZSjMHAZ3xfAe
   g==;
X-CSE-ConnectionGUID: ad5DQMoPTo6jWpysXH/vpw==
X-CSE-MsgGUID: usv4ppmyQt2OfnsEfPrhGA==
X-IronPort-AV: E=McAfee;i="6700,10204,11236"; a="29474612"
X-IronPort-AV: E=Sophos;i="6.11,233,1725346800"; 
   d="scan'208";a="29474612"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 15:37:29 -0700
X-CSE-ConnectionGUID: 1GFnsl14SrG1LHHh4RjFlA==
X-CSE-MsgGUID: s480GF8oRh6/xxL2TwnfSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,233,1725346800"; 
   d="scan'208";a="85596112"
Received: from sj-4150-psse-sw-opae-dev3.sj.altera.com ([10.244.138.109])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 15:37:29 -0700
From: Peter Colberg <peter.colberg@intel.com>
To: Wu Hao <hao.wu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Russ Weight <russ.weight@linux.dev>,
	Marco Pagani <marpagan@redhat.com>,
	Matthew Gerlach <matthew.gerlach@linux.intel.com>,
	Basheer Ahmed Muddebihal <basheer.ahmed.muddebihal@linux.intel.com>,
	Peter Colberg <peter.colberg@intel.com>
Subject: [PATCH v4 00/19] fpga: dfl: fix kernel warning on port release/assign for SRIOV
Date: Fri, 25 Oct 2024 18:36:55 -0400
Message-ID: <20241025223714.394533-1-peter.colberg@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the Intel FPGA PAC D5005, DFL ports are registered as platform
devices in PF mode. The port device must be removed from the host when
the user wants to configure the port as a VF for use by a user-space
driver, e.g., for pass-through to a virtual machine. The FME device
ioctls DFL_FPGA_FME_PORT_RELEASE/ASSIGN are assigned for this purpose.

In the previous implementation, the port platform device is not
completely destroyed on port release: it is removed from the system by
platform_device_del(), but the platform device instance is retained.
When DFL_FPGA_FME_PORT_ASSIGN is called, the platform device is added
back with platform_device_add(), which conflicts with this comment of
device_add(): "Do not call this routine more than once for any device
structure", and would previously cause a kernel warning at runtime.

This patch completely unregisters the port platform device on release
and registers a new device on assign. But the main work is to remove
the dependency on struct dfl_feature_platform_data for many internal DFL
APIs. This structure holds many DFL enumeration infos for feature
devices. Many DFL APIs are expected to work with these infos even when
the port platform device is unregistered. But after this change, the
platform_data will be freed on port release. Hence this patch introduces
a new structure dfl_feature_dev_data, which acts similarly to the
previous dfl_feature_platform_data. dfl_feature_platform_data then only
needs a pointer to dfl_feature_dev_data to query DFL enumeration infos.

Link: https://lore.kernel.org/all/DM6PR11MB3819F9CCD0A6126B55BCB47685FB9@DM6PR11MB3819.namprd11.prod.outlook.com/T/#t
Link: https://patchwork.kernel.org/project/linux-fpga/cover/20240409233942.828440-1-peter.colberg@intel.com/
Link: https://patchwork.kernel.org/project/linux-fpga/cover/20240919203430.1278067-1-peter.colberg@intel.com/

Changes since v3:
- The last patch of the v2 series has been broken up into smaller,
  self-contained patches, which carry out and describe each cosmetic
  or functional transformation separately to ensure its correctness.
- When a port had been released using the DFL_FPGA_FME_PORT_RELEASE ioctl,
  the corresponding device id was no longer being released as part of
  dfl_fpga_feature_devs_remove(). Instead of manually cleaning up feature
  device ids, use devm_add_action_or_reset() to automatically free the
  device id right before the corresponding feature device data is freed.

Changes since v2:
- Restructure series to break monolithic v1 patch into logical,
  self-contained patches, instead of per-file patches as in v2.
  In particular, the next-to-last patch only contains non-functional
  changes that are strictly limited to replacing pdata with fdata.
- Omit unneeded null pointer check from fme_open(), the same as for
  afu_open(). Refactor dfl_fpga_inode_to_feature_dev_data() to directly
  return the platform data and retrieve the device from the data.
- Fix missing free() of type in binfo_create_feature_dev_data().
  Free allocated FIU type when devm_kmemdup() returns a NULL pointer.
- Store fdata instead of pdata as file descriptor private data in
  fme_open() since pdata is only used to look up fdata.
- Remove pdata pointers that are only used to look up fdata, in
  dfl_fpga_dev_feature_uinit() and dfl_feature_ioctl_set_irq().
- Omit unneeded argument pdata from dfl_feature_instance_init().
- Drop redundant 0 in zero initializer of dfl_feature_platform_data in
  feature_dev_register().
- Revert defining pointer to device when the pointer is only used once
  per function, in afu_dma_region_add() and afu_dma_region_add().
- Revert minor, unneeded code formatting changes to reduce noise.

Changes since v1:
- Split monolithic patch into series at request of maintainer.
- Substitute binfo->type for removed function feature_dev_id_type() in
  parse_feature_irqs().
- Return ERR_PTR(-ENOMEM) on !feature->params in
  binfo_create_feature_dev_data().
- Reorder cdev as first member of struct dfl_feature_platform_data
  such that container_of() to obtain pdata evaluates to a no-op.
- Change afu_ioctl_*() to receive dfl_feature_dev_data instead of
  dfl_feature_platform_data.
- Change fme_hdr_ioctl_*() to receive dfl_feature_dev_data instead of
  dfl_feature_platform_data.
- Replace local variable pdata with fdata in afu_mmap().
- Remove unused local variable pdata in afu_dev_{init,destroy}().
- Remove unused local variable pdata in fme_dev_{init,destroy}().
- Reorder local variables in afu_dma_unpin_pages() to reverse Christmas
  tree order.
- Align kernel-doc function name for __dfl_fpga_cdev_find_port_data().
- Substitute @fdata for @pdata in kernel-doc comments for
  dfl_fme_create_mgr() and dfl_fme_destroy_mgr().

Peter Colberg (18):
  fpga: dfl: omit unneeded argument pdata from
    dfl_feature_instance_init()
  fpga: dfl: return platform data from
    dfl_fpga_inode_to_feature_dev_data()
  fpga: dfl: afu: use parent device to log errors on port enable/disable
  fpga: dfl: afu: define local pointer to feature device
  fpga: dfl: pass feature platform data instead of device as argument
  fpga: dfl: factor out feature data creation from
    build_info_commit_dev()
  fpga: dfl: store FIU type in feature platform data
  fpga: dfl: refactor internal DFL APIs to take/return feature device
    data
  fpga: dfl: factor out feature device registration
  fpga: dfl: factor out feature device data from platform device data
  fpga: dfl: convert features from flexible array member to separate
    array
  fpga: dfl: store MMIO resources in feature device data
  fpga: dfl: store platform device name in feature device data
  fpga: dfl: store platform device id in feature device data
  fpga: dfl: convert is_feature_dev_detected() to use FIU type
  fpga: dfl: allocate platform device after feature device data
  fpga: dfl: remove unneeded function build_info_create_dev()
  fpga: dfl: drop unneeded get_device() and put_device() of feature
    device

Xu Yilun (1):
  fpga: dfl: destroy/recreate feature platform device on port
    release/assign

 drivers/fpga/dfl-afu-dma-region.c | 117 ++++----
 drivers/fpga/dfl-afu-error.c      |  59 ++--
 drivers/fpga/dfl-afu-main.c       | 278 +++++++++----------
 drivers/fpga/dfl-afu-region.c     |  51 ++--
 drivers/fpga/dfl-afu.h            |  26 +-
 drivers/fpga/dfl-fme-br.c         |  24 +-
 drivers/fpga/dfl-fme-error.c      |  98 +++----
 drivers/fpga/dfl-fme-main.c       |  95 +++----
 drivers/fpga/dfl-fme-pr.c         |  86 +++---
 drivers/fpga/dfl.c                | 431 ++++++++++++++----------------
 drivers/fpga/dfl.h                | 140 ++++++----
 11 files changed, 708 insertions(+), 697 deletions(-)

-- 
2.47.0



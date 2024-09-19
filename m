Return-Path: <linux-fpga+bounces-713-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4243797CE78
	for <lists+linux-fpga@lfdr.de>; Thu, 19 Sep 2024 22:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8D30281FB1
	for <lists+linux-fpga@lfdr.de>; Thu, 19 Sep 2024 20:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D64B3F9D2;
	Thu, 19 Sep 2024 20:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QAbcwfN6"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DECD1CD15;
	Thu, 19 Sep 2024 20:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726778103; cv=none; b=nNYnGSCs3vNP2cLxIDUh50J5TVAO3/u5dD/7m9dY/luhzrnMxCLM+Tn8c+SNJYuv4VGk8tfztZw0RpcwDrpIsz4sIfaPdakwGO4FqUf7x5R+2XCnJoh1KFMFzmFk8HUjRajFpd/mzIMiWycIzD/oMDlg6Lcvt3MXQxm/gxGqCH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726778103; c=relaxed/simple;
	bh=PUijb/E7DFJ2X4MHBlAYZAmMiY/Ntrt4i42W810Px6g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N0vOoFctZ2LshKr2wzuG1XHE/VYoLk38QpcgFsHK64E87zFBNbScssNa/jKzqyAaKRDCCHd2mfCfU2WAnlK+MfNM6jpd9E1yEcqyOhHgIYhg9biqJ4tpga/qv3lzVsyT17BwskijmNWuftqPZb5sG/WBn8/bkinyGkI5GYqRoOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QAbcwfN6; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726778101; x=1758314101;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PUijb/E7DFJ2X4MHBlAYZAmMiY/Ntrt4i42W810Px6g=;
  b=QAbcwfN6zs2WBqPp+EPyi9du5Yvf50B2Tw80nh+HIhEuq7Z3/lMWpbp3
   HThwXxcLMsssP/k5T2vV5Vwu/BfrSkhY2GXuwi8cBSxmF/zE9B7NCqsAR
   XVIbo/h8/CF6eZUnV7gA45U/tNkpcv4FXz0yfJxiVPlWW6rt3KyYGYXi+
   dciz5Vf5kFpeQn+do/9zdZpfwEZ1cO+d4aiQuD7j+0rAGAyLhrm0mOGCJ
   MR4fm9fLnyUxqyh/qIYq9UEcpEbeLEn0wKCIVuaRWclbu3/bs8SQ8TEV9
   CIe9Qr2ctJRn97S9jY/pvr+lrTFuhu2FiWa8LRlnnBjd8ESN3ynhZLSkM
   w==;
X-CSE-ConnectionGUID: SwyBIbslT+Cotrl66zkgAw==
X-CSE-MsgGUID: guAfj7BvRbmSUV6LpR9jbw==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="25912934"
X-IronPort-AV: E=Sophos;i="6.10,242,1719903600"; 
   d="scan'208";a="25912934"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 13:35:01 -0700
X-CSE-ConnectionGUID: JUrXHz3BQ0i2XsBF0tI78Q==
X-CSE-MsgGUID: 4ABRKPYJRV+5joCcJmsUpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,242,1719903600"; 
   d="scan'208";a="93338287"
Received: from sj-4150-psse-sw-opae-dev3.sj.altera.com ([10.244.138.109])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 13:35:00 -0700
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
	Peter Colberg <peter.colberg@intel.com>
Subject: [PATCH v3 0/9] fpga: dfl: fix kernel warning on port release/assign for SRIOV
Date: Thu, 19 Sep 2024 16:34:21 -0400
Message-ID: <20240919203430.1278067-1-peter.colberg@intel.com>
X-Mailer: git-send-email 2.46.1
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

Peter Colberg (8):
  fpga: dfl: omit unneeded argument pdata from
    dfl_feature_instance_init()
  fpga: dfl: omit unneeded null pointer check from {afu,fme}_open()
  fpga: dfl: afu: use parent device to log errors on port enable/disable
  fpga: dfl: afu: define local pointer to feature device
  fpga: dfl: pass feature platform data instead of device as argument
  fpga: dfl: factor out feature data creation from
    build_info_commit_dev()
  fpga: dfl: store FIU type in feature platform data
  fpga: dfl: refactor functions to take/return feature device data

Xu Yilun (1):
  fpga: dfl: fix kernel warning on port release/assign for SRIOV

 drivers/fpga/dfl-afu-dma-region.c | 117 ++++----
 drivers/fpga/dfl-afu-error.c      |  59 ++--
 drivers/fpga/dfl-afu-main.c       | 278 +++++++++----------
 drivers/fpga/dfl-afu-region.c     |  51 ++--
 drivers/fpga/dfl-afu.h            |  26 +-
 drivers/fpga/dfl-fme-br.c         |  24 +-
 drivers/fpga/dfl-fme-error.c      |  98 +++----
 drivers/fpga/dfl-fme-main.c       |  95 +++----
 drivers/fpga/dfl-fme-pr.c         |  86 +++---
 drivers/fpga/dfl.c                | 439 ++++++++++++++----------------
 drivers/fpga/dfl.h                | 140 ++++++----
 11 files changed, 712 insertions(+), 701 deletions(-)

-- 
2.46.1



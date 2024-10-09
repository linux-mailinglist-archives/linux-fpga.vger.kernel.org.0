Return-Path: <linux-fpga+bounces-762-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BE599678D
	for <lists+linux-fpga@lfdr.de>; Wed,  9 Oct 2024 12:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 670292853CA
	for <lists+linux-fpga@lfdr.de>; Wed,  9 Oct 2024 10:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80AA018EFE6;
	Wed,  9 Oct 2024 10:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aswCXubY"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A9018EFF3;
	Wed,  9 Oct 2024 10:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728470755; cv=none; b=AHKSXFx0relS4LX2vKCI3jGnA99d+8692UcY6T7yHu2jhTcD+KgLtOU/62+R0j1w9JTzzg8CYMYN2rZ3jPXNl1ceXP4emmpm1W99x1R6jVBxnnLs7VkvMaeIs8LGoj5fyyP7UHhf8bQmzFrqUcJP7h5ljejJjv9i0p0YjFlGCqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728470755; c=relaxed/simple;
	bh=gMKUeQtrnPo4kR4MnMS8BtbkVAYoHv1S/PoJjMPwJSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sbNigRsEoa8rPmrKm6OuyGQEG6IKcALO/Ark9QGYMNCV+XNWUn8tmVkdsT7IDVGfdetFRht0E2vSNXOKePigjhk0jHMY/puxowU1euTJJz7gcL1L1TVmtTgXrrwKS3LsqYTIiTMgQrpreWAZp5WvvRrt9a27lgfsZJHr6W7M/f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aswCXubY; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728470753; x=1760006753;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gMKUeQtrnPo4kR4MnMS8BtbkVAYoHv1S/PoJjMPwJSE=;
  b=aswCXubYTg7EbHCoJMNNbIAb3B7U2ntgdm6n+UUPOKLZKsir3VMKSpwX
   PD8U4iMRmV0gCIh1ll8KsHSIdE6nJ30TFFnScvOrOaTCPhguEKBw4Fi4+
   QeKBDtQXENNFmjT330OxhAJzIzquXfCs65qkbaUb0e+nb78I5QFJ2Cd+O
   a2NtpeKz5omlr/7Q25H3zf4z1Muc0qKA2Zku6UUeO7oHGKzlKfapTtqyc
   OWivy6w7Dg7nKzYU5CKFFAYJbdPFjQ5I9HA7wTAICO3IiwVtiydaBW5lw
   tf5CYOSjR9dkkBRPPcYrpa9E0wlqPbZ2kMX0VG9ttEnX7msf5gBZWk0PR
   A==;
X-CSE-ConnectionGUID: /IF0/Vd4TIqDhzcLEddHHw==
X-CSE-MsgGUID: 7A/AxyOITTqiGyTcDnBIGQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="27921679"
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="27921679"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 03:45:51 -0700
X-CSE-ConnectionGUID: I1ezf7fVTz2BCYhdfcd3mw==
X-CSE-MsgGUID: EaxfduZPTBGETjHSyioJIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="76100546"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 09 Oct 2024 03:45:49 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1syUCP-00097O-2s;
	Wed, 09 Oct 2024 10:45:45 +0000
Date: Wed, 9 Oct 2024 18:44:51 +0800
From: kernel test robot <lkp@intel.com>
To: David Zhang <yidong.zhang@amd.com>, linux-kernel@vger.kernel.org,
	linux-fpga@vger.kernel.org, mdf@kernel.org, hao.wu@intel.com,
	yilun.xu@intel.com
Cc: oe-kbuild-all@lists.linux.dev, Yidong Zhang <yidong.zhang@amd.com>,
	lizhi.hou@amd.com, Nishad Saraf <nishads@amd.com>,
	Prapul Krishnamurthy <prapulk@amd.com>
Subject: Re: [PATCH V1 2/3] drivers/fpga/amd: Add communication with firmware
Message-ID: <202410091855.yLTZGOfr-lkp@intel.com>
References: <20241007220128.3023169-2-yidong.zhang@amd.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007220128.3023169-2-yidong.zhang@amd.com>

Hi David,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.12-rc2 next-20241008]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Zhang/drivers-fpga-amd-Add-communication-with-firmware/20241008-060253
base:   linus/master
patch link:    https://lore.kernel.org/r/20241007220128.3023169-2-yidong.zhang%40amd.com
patch subject: [PATCH V1 2/3] drivers/fpga/amd: Add communication with firmware
config: x86_64-randconfig-121-20241009 (https://download.01.org/0day-ci/archive/20241009/202410091855.yLTZGOfr-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241009/202410091855.yLTZGOfr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410091855.yLTZGOfr-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/fpga/amd/vmgmt.c:35:14: sparse: sparse: symbol 'vmgmt_class' was not declared. Should it be static?
>> drivers/fpga/amd/vmgmt.c:272:45: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void * @@
   drivers/fpga/amd/vmgmt.c:272:45: sparse:     expected void const [noderef] __user *from
   drivers/fpga/amd/vmgmt.c:272:45: sparse:     got void *
   drivers/fpga/amd/vmgmt.c:301:45: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void * @@
   drivers/fpga/amd/vmgmt.c:301:45: sparse:     expected void const [noderef] __user *from
   drivers/fpga/amd/vmgmt.c:301:45: sparse:     got void *

vim +272 drivers/fpga/amd/vmgmt.c

   257	
   258	static long vmgmt_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
   259	{
   260		struct vmgmt_device *vdev = (struct vmgmt_device *)filep->private_data;
   261		struct vmgmt_fpga_region reg = { 0 };
   262		struct fpga_region *region = NULL;
   263		struct axlf *axlf = NULL;
   264		void *data = NULL;
   265		size_t size = 0;
   266		int ret = 0;
   267	
   268		axlf = vmalloc(sizeof(*axlf));
   269		if (!axlf)
   270			return -ENOMEM;
   271	
 > 272		ret = copy_from_user((void *)axlf, (void *)arg, sizeof(*axlf));
   273		if (ret) {
   274			vmgmt_err(vdev, "Failed to copy axlf: %d", ret);
   275			ret = -EFAULT;
   276			goto exit;
   277		}
   278	
   279		ret = memcmp(axlf->magic, VERSAL_XCLBIN_MAGIC_ID,
   280			     sizeof(VERSAL_XCLBIN_MAGIC_ID));
   281		if (ret) {
   282			vmgmt_err(vdev, "unknown axlf magic %s", axlf->magic);
   283			ret = -EINVAL;
   284			goto exit;
   285		}
   286	
   287		/* axlf should never be over 1G and less than size of struct axlf */
   288		size = axlf->header.length;
   289		if (size < sizeof(struct axlf) || size > 1024 * 1024 * 1024) {
   290			vmgmt_err(vdev, "axlf length %zu is invalid", size);
   291			ret = -EINVAL;
   292			goto exit;
   293		}
   294	
   295		data = vmalloc(size);
   296		if (!data) {
   297			ret = -ENOMEM;
   298			goto exit;
   299		}
   300	
   301		ret = copy_from_user((void *)data, (void *)arg, size);
   302		if (ret) {
   303			vmgmt_err(vdev, "Failed to copy data: %d", ret);
   304			ret = -EFAULT;
   305			goto exit;
   306		}
   307	
   308		switch (cmd) {
   309		case VERSAL_MGMT_LOAD_XCLBIN_IOCTL:
   310			vdev->fdev->fw.opcode = RM_QUEUE_OP_LOAD_XCLBIN;
   311			break;
   312		default:
   313			vmgmt_err(vdev, "Invalid IOCTL command: %d", cmd);
   314			ret = -EINVAL;
   315			goto exit;
   316		}
   317	
   318		reg.uuid = &axlf->header.rom_uuid;
   319		reg.fdev = vdev->fdev;
   320	
   321		region = fpga_region_class_find(NULL, &reg, vmgmt_fpga_region_match);
   322		if (!region) {
   323			vmgmt_err(vdev, "Failed to find compatible region");
   324			ret = -ENOENT;
   325			goto exit;
   326		}
   327	
   328		ret = vmgmt_region_program(region, data);
   329		if (ret) {
   330			vmgmt_err(vdev, "Failed to program region");
   331			goto exit;
   332		}
   333	
   334		vmgmt_info(vdev, "Downloaded axlf %pUb of size %zu Bytes",
   335			   &axlf->header.uuid, size);
   336		uuid_copy(&vdev->xclbin_uuid, &axlf->header.uuid);
   337	
   338	exit:
   339		vfree(data);
   340		vfree(axlf);
   341	
   342		return ret;
   343	}
   344	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


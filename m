Return-Path: <linux-fpga+bounces-1274-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9401AEED2C
	for <lists+linux-fpga@lfdr.de>; Tue,  1 Jul 2025 06:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A985D17C11B
	for <lists+linux-fpga@lfdr.de>; Tue,  1 Jul 2025 04:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015D11EA7EB;
	Tue,  1 Jul 2025 04:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PBOIJuD+"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB901E2858;
	Tue,  1 Jul 2025 04:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751343034; cv=none; b=ZrbzIdJxb+ObEChr8mNhWQ426a52XtAQuJ+r30YY+AG3N83a6uUmLcDe+DBvRrWcYxiuiZDXy9SgNGsABXWBHxmGShOPluNT3QS3I3F/2hoZJQnlVruAwljSQOXBjRSq1k0ez61ipjN3vRaqChoe2horgI0c5KeS/pLPgoWlt4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751343034; c=relaxed/simple;
	bh=5JbsaJo9u0TrLmzNGqZM/nMXEajQm6eUT1Qn9/HjkDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c/m54NA4Ctu1qleEK6iKH9rjNz2DEn3MypLgQ3bmnray2nvmq8BDVFqVMNtlkgfCIgxq6m2mJEoZeEtASdMHMzLkUS+Jz0Dc6LiCGtQznuTYoYE87R8T4KQgG7qVWE9I2uSX3pXvP7fCrYKX/+nMAPQVxqhw/I4rSSbdbEAnCiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PBOIJuD+; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751343033; x=1782879033;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5JbsaJo9u0TrLmzNGqZM/nMXEajQm6eUT1Qn9/HjkDA=;
  b=PBOIJuD+KBiB0IZt3/OQ0I/7EB6VjBMm4sTv+neHCil0YVk5n9zqGIVi
   8i+7kCzzVFlT1Q8Pfe971VLGURdnPrTv14GUfCcc+61l0i/VVJpWcx0dC
   y8pSPndWi7jd5fwokc5mSP0bYdRm4oMrqiCK9Gha1fCX60zo+HNd1u6LC
   l68+KaKHSgC4j9H2xzGwOUC/LIgf4sS23WO4PJpSIoksnmmcVonszcC6b
   0cOLCThy/UmtT+HFkVWMU098utn8a/2iekMiK0xtENmSIR4IbhHXJJvez
   pgViElFxUc7gXxxu9pvs4FYhsQ+HYJUDRYLqRltXIaLDZvL4TyaUXEy+c
   A==;
X-CSE-ConnectionGUID: tByB1ZcpRMSHy9opF87R/w==
X-CSE-MsgGUID: KA5KFiMZSWWOB/aTP5piVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11480"; a="41216124"
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="41216124"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 21:10:33 -0700
X-CSE-ConnectionGUID: zruNx06+ROSRDz2s/oclFg==
X-CSE-MsgGUID: Ho6XgQr/RpCuBexgRqxCQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="157913406"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 30 Jun 2025 21:10:30 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uWSKC-000Zhy-0a;
	Tue, 01 Jul 2025 04:10:28 +0000
Date: Tue, 1 Jul 2025 12:09:45 +0800
From: kernel test robot <lkp@intel.com>
To: Ryan Chung <seokwoo.chung130@gmail.com>, hao.wu@intel.com,
	trix@redhat.com, mdf@kernel.org, yilun.xu@intel.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-fpga@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Ryan Chung <seokwoo.chung130@gmail.com>
Subject: Re: [PATCH] fpga: dfl: Replace scnprintf() with sysfs_emit()
Message-ID: <202507011110.nJmYZDdm-lkp@intel.com>
References: <20250630125018.48417-1-seokwoo.chung130@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630125018.48417-1-seokwoo.chung130@gmail.com>

Hi Ryan,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.16-rc4 next-20250630]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ryan-Chung/fpga-dfl-Replace-scnprintf-with-sysfs_emit/20250630-205221
base:   linus/master
patch link:    https://lore.kernel.org/r/20250630125018.48417-1-seokwoo.chung130%40gmail.com
patch subject: [PATCH] fpga: dfl: Replace scnprintf() with sysfs_emit()
config: i386-randconfig-011-20250701 (https://download.01.org/0day-ci/archive/20250701/202507011110.nJmYZDdm-lkp@intel.com/config)
compiler: clang version 20.1.7 (https://github.com/llvm/llvm-project 6146a88f60492b520a36f8f8f3231e15f3cc6082)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250701/202507011110.nJmYZDdm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507011110.nJmYZDdm-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/fpga/dfl-afu-main.c:159:25: error: incompatible integer to pointer conversion passing 'unsigned long' to parameter of type 'const char *' [-Wint-conversion]
     159 |         return sysfs_emit(buf, PAGE_SIZE, "%d\n", id);
         |                                ^~~~~~~~~
   include/vdso/page.h:15:19: note: expanded from macro 'PAGE_SIZE'
      15 | #define PAGE_SIZE       (_AC(1,UL) << CONFIG_PAGE_SHIFT)
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/sysfs.h:492:39: note: passing argument to parameter 'fmt' here
     492 | int sysfs_emit(char *buf, const char *fmt, ...);
         |                                       ^
   drivers/fpga/dfl-afu-main.c:478:25: error: incompatible integer to pointer conversion passing 'unsigned long' to parameter of type 'const char *' [-Wint-conversion]
     478 |         return sysfs_emit(buf, PAGE_SIZE, "%016llx%016llx\n", guidh, guidl);
         |                                ^~~~~~~~~
   include/vdso/page.h:15:19: note: expanded from macro 'PAGE_SIZE'
      15 | #define PAGE_SIZE       (_AC(1,UL) << CONFIG_PAGE_SHIFT)
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/sysfs.h:492:39: note: passing argument to parameter 'fmt' here
     492 | int sysfs_emit(char *buf, const char *fmt, ...);
         |                                       ^
   2 errors generated.


vim +159 drivers/fpga/dfl-afu-main.c

   152	
   153	static ssize_t
   154	id_show(struct device *dev, struct device_attribute *attr, char *buf)
   155	{
   156		struct dfl_feature_dev_data *fdata = to_dfl_feature_dev_data(dev);
   157		int id = port_get_id(fdata);
   158	
 > 159		return sysfs_emit(buf, PAGE_SIZE, "%d\n", id);
   160	}
   161	static DEVICE_ATTR_RO(id);
   162	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


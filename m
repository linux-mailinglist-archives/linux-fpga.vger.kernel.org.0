Return-Path: <linux-fpga+bounces-1276-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E97ADAEF603
	for <lists+linux-fpga@lfdr.de>; Tue,  1 Jul 2025 13:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FCB11C018C7
	for <lists+linux-fpga@lfdr.de>; Tue,  1 Jul 2025 11:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693A927057D;
	Tue,  1 Jul 2025 11:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EbAYtmfM"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D156B264626;
	Tue,  1 Jul 2025 11:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751367800; cv=none; b=FoIYfxOMtbDcaZMfDrONAyZTxEOVz3Hhek3JVlLp5mG/M1oyjWWNYVR7o0UNA7DgU5lBPTjOhicNc0/xaSvuNoVpVK+9nep0aohtVE6Kqgtwb5JnyRcpV03LspARsuSc8RSSvSzE8Y0053obhlYARysj/Jm8To8Hs53xFCoy3Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751367800; c=relaxed/simple;
	bh=6kNKJ2mFTxTcmBjI382PaBWELeHf7O/jzRNGF2VoYfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y0vnUaEQ9kxk44YIa3+1HZOdGvvNJ8CvJ1qnCfQI9oFKtYyN8RUi5mRYfH2LNMVaACDG/oiLUc5bQ5t44aqXMuwoka3YaI2APFnggF3WBgy5S1VYQ4B+qYjvHDL/Pt30WXjO3m2pfWybAVdYKCejw23WjwBi3XvVPwfTHMJ+lJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EbAYtmfM; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751367797; x=1782903797;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6kNKJ2mFTxTcmBjI382PaBWELeHf7O/jzRNGF2VoYfc=;
  b=EbAYtmfMA28hnMRh+T/NSLZy/AXML7AaCqsEKfFdKE8zC0gYxp39YiZ/
   AjAqxKdRAZD8XZIkMwvgocpYdFLq8XYzcHznlKg+GDZWkXC/Lb27h9rsA
   5Tzs1MMpsjW7Xp2lLZc8O6oMFtqO6vf/aQbZPqHYaltlpFwHMLa4jX6Zc
   7dHxmREbJ94EtIzfp7K1ZeBvM3JjAETArmLFv4im4m0r7z8BPFcHUHncU
   2JdLlYoUkM2zV6k46I6A78Q2VbehesJjW6pvYghdKDtlbhAaCmC0p+wNX
   hdvA0OdE/cwyscpQ2ew1GdGICokXsS7JmFkxofA9JfHN1y2S/fN/pykNi
   A==;
X-CSE-ConnectionGUID: cG4js02XRLifbLCMTCTtCA==
X-CSE-MsgGUID: 6Bkamq6JRHy1IDUuVCdmJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11480"; a="71189314"
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="71189314"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 04:03:16 -0700
X-CSE-ConnectionGUID: 5cI7/pJ0QSqlP2QGqmcjTg==
X-CSE-MsgGUID: 4KTUbD3rTP6h/BIVcGBvwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="153352936"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 01 Jul 2025 04:03:14 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uWYlb-000a2s-35;
	Tue, 01 Jul 2025 11:03:11 +0000
Date: Tue, 1 Jul 2025 19:02:28 +0800
From: kernel test robot <lkp@intel.com>
To: Ryan Chung <seokwoo.chung130@gmail.com>, hao.wu@intel.com,
	trix@redhat.com, mdf@kernel.org, yilun.xu@intel.com
Cc: oe-kbuild-all@lists.linux.dev, linux-fpga@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev, linux-kernel@vger.kernel.org,
	Ryan Chung <seokwoo.chung130@gmail.com>
Subject: Re: [PATCH] fpga: dfl: Replace scnprintf() with sysfs_emit()
Message-ID: <202507011805.BSIqVlhe-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.16-rc4 next-20250630]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ryan-Chung/fpga-dfl-Replace-scnprintf-with-sysfs_emit/20250630-205221
base:   linus/master
patch link:    https://lore.kernel.org/r/20250630125018.48417-1-seokwoo.chung130%40gmail.com
patch subject: [PATCH] fpga: dfl: Replace scnprintf() with sysfs_emit()
config: sparc-randconfig-r112-20250701 (https://download.01.org/0day-ci/archive/20250701/202507011805.BSIqVlhe-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 8.5.0
reproduce: (https://download.01.org/0day-ci/archive/20250701/202507011805.BSIqVlhe-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507011805.BSIqVlhe-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/fpga/dfl-afu-main.c:159:32: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected char const *fmt @@     got unsigned long @@
   drivers/fpga/dfl-afu-main.c:159:32: sparse:     expected char const *fmt
   drivers/fpga/dfl-afu-main.c:159:32: sparse:     got unsigned long
   drivers/fpga/dfl-afu-main.c:478:32: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected char const *fmt @@     got unsigned long @@
   drivers/fpga/dfl-afu-main.c:478:32: sparse:     expected char const *fmt
   drivers/fpga/dfl-afu-main.c:478:32: sparse:     got unsigned long

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


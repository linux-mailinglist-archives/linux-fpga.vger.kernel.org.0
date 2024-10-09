Return-Path: <linux-fpga+bounces-761-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F134996454
	for <lists+linux-fpga@lfdr.de>; Wed,  9 Oct 2024 11:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCB58B24D66
	for <lists+linux-fpga@lfdr.de>; Wed,  9 Oct 2024 09:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F2A188714;
	Wed,  9 Oct 2024 09:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U6g2TRzG"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC673BB48;
	Wed,  9 Oct 2024 09:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728464507; cv=none; b=k2f73jEHNIon2K+J1IKuCBQ4FODlk9bP4W6IWrPzhms/SEYVjp/7GwDl71/SKze6g5JZMM5/FYMu1XIZh7gtA0BJCjHShg0bA/UFwzC1xtR4YmwHf/Q7maUL233oF0R386/YYmYOkDt12oPa3R/15BuQJuitjOFzMHvrIii32xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728464507; c=relaxed/simple;
	bh=ZJVBHZGvtKxbvpjFmlBpj6KCGjNmtHop4yOFN0tcpYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rf/xJnk4hrZB/wUYnnnpvKf14L9+ngyGQM3UYIxmDBPMf27mavzbseh7px/u6/U955okl9j3g4JHcO1824Hb0G4FcStZ09B+Z+L1DEPL11axysfUNCzXOemvqeLpjrs6729gBT337ut5s1GFTPxftfJ9OvFy4YxJjFn9Q4tgf8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U6g2TRzG; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728464506; x=1760000506;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZJVBHZGvtKxbvpjFmlBpj6KCGjNmtHop4yOFN0tcpYY=;
  b=U6g2TRzGdCgtGHww1fl1E2BGMEGsaVT15zt0D4MKRsnm6EoYKRea2otT
   NKD7zsv7C1kWCFUDF9LWY52iIcHER0MkfB5CtFX+zoE2xBGoYyOx7h74L
   k4+Zj9npDNKEoFzzpksMb6acM13Bk/Z1xduneC7i7ppZUYq8y6Qbc0DVs
   cKWvyvjSZ9Wkvtb13p8YgPoF7yp5UOSZor9WSgLW+0qJOzjFamHz9fbML
   yxhNPPksqH+YYWfS5kJhgFeOzeIlalXqg1766el5LjSfTL2/4smupctOa
   RFPI/qn4iqJK9+uANCHl0Ph2pDp5JnTDqdB3RdRFsw8x2gpB9HHf5CEXB
   A==;
X-CSE-ConnectionGUID: wTmf5pSCQZSnrqrhQPi15A==
X-CSE-MsgGUID: Vt3hSNgxRn+QCTikSFsYsw==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="31451012"
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="31451012"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 02:01:45 -0700
X-CSE-ConnectionGUID: wcu5qtTISe2Vnw8WgQXuow==
X-CSE-MsgGUID: aHGKTm2kTe2d2jOBhrmJNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="75778756"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 09 Oct 2024 02:01:44 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sySZh-00091w-0c;
	Wed, 09 Oct 2024 09:01:41 +0000
Date: Wed, 9 Oct 2024 17:01:28 +0800
From: kernel test robot <lkp@intel.com>
To: David Zhang <yidong.zhang@amd.com>, linux-kernel@vger.kernel.org,
	linux-fpga@vger.kernel.org, mdf@kernel.org, hao.wu@intel.com,
	yilun.xu@intel.com
Cc: oe-kbuild-all@lists.linux.dev, Yidong Zhang <yidong.zhang@amd.com>,
	lizhi.hou@amd.com, DMG Karthik <Karthik.DMG@amd.com>,
	Nishad Saraf <nishads@amd.com>,
	Prapul Krishnamurthy <prapulk@amd.com>
Subject: Re: [PATCH V1 1/3] drivers/fpga/amd: Add new driver for AMD Versal
 PCIe card
Message-ID: <202410091652.aQHmRoj1-lkp@intel.com>
References: <20241007220128.3023169-1-yidong.zhang@amd.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007220128.3023169-1-yidong.zhang@amd.com>

Hi David,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.12-rc2 next-20241008]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Zhang/drivers-fpga-amd-Add-communication-with-firmware/20241008-060253
base:   linus/master
patch link:    https://lore.kernel.org/r/20241007220128.3023169-1-yidong.zhang%40amd.com
patch subject: [PATCH V1 1/3] drivers/fpga/amd: Add new driver for AMD Versal PCIe card
config: x86_64-randconfig-121-20241009 (https://download.01.org/0day-ci/archive/20241009/202410091652.aQHmRoj1-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241009/202410091652.aQHmRoj1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410091652.aQHmRoj1-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/fpga/amd/vmgmt.c:33:14: sparse: sparse: symbol 'vmgmt_class' was not declared. Should it be static?

vim +/vmgmt_class +33 drivers/fpga/amd/vmgmt.c

    30	
    31	static DEFINE_IDA(vmgmt_dev_minor_ida);
    32	static dev_t vmgmt_devnode;
  > 33	struct class *vmgmt_class;
    34	static struct fpga_bridge_ops vmgmt_br_ops;
    35	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


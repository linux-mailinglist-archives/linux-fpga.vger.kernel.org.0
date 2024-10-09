Return-Path: <linux-fpga+bounces-760-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CAB996075
	for <lists+linux-fpga@lfdr.de>; Wed,  9 Oct 2024 09:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E51F6287879
	for <lists+linux-fpga@lfdr.de>; Wed,  9 Oct 2024 07:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6390A186616;
	Wed,  9 Oct 2024 07:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nn9D5q9s"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F76D17DFE8;
	Wed,  9 Oct 2024 07:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728458083; cv=none; b=d/kXlck3PaEcEfgjmMr3N5l7qn5sFT6DZFVEW0q2lXLTKUyL1ZJBN61+9+KWM4KIdohHgyUWkwMmlqZAhSt7MyNX+LVmnCdL6Cl/FANbywbtvtQ0EP6cc7evWS6lXi3AIKTEAp8JxoKl5EGP9ATvob416KUyChvP7oKY7Xa9M3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728458083; c=relaxed/simple;
	bh=m17sdrYRBmfrCEo9usomhJOmDw78sWaZlC5tm9EazsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PYl7P0dcqcfkn9HeGnhmz5gtB4Mq8g+XWm7M36FrdLCSgOouTXexJY44Wotm9YaeF+1Swip5pXNXJPZ0+cepV+DnQyzf8BaKlwu2biUDF63KUmPuNs4vBkEAqJv7Tgm4BOkFA2X1oFWKYrSYI/r/LWAjewy6epXJubo7A7lYdKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nn9D5q9s; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728458082; x=1759994082;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=m17sdrYRBmfrCEo9usomhJOmDw78sWaZlC5tm9EazsY=;
  b=nn9D5q9sSeAzLoSBl+t8JplSDWQgF+nfABFP82679jQ76zYVv3Yx167g
   DOtPwxuFq5yPB/wTcETQbjsfGuoEkPDIPEQnrkwzk6sF/oufC79WiXwbb
   HinKhpFyFEwM0yQAwSWVNnRbtlvsgnH7Ap0T+L+CgsNDJwPeoPIdXeBg8
   vs1Xfc9AsP1zbjf992FQrWZ7g/us9saNNny3OGgq5OBAgFKyS8wPPsTAq
   ZQ6ryfYXlZbKgu4a5HS7oM3PNyiQ455TBXdyK/GMI23qSnNDAfJ6hU3yo
   m7R7u2ThBP7qG8F91W4tCEYzf1oar7UUQXVKsiw62cLnLye6ohIyaHdz2
   g==;
X-CSE-ConnectionGUID: CbHejmX9RrKPQZJC28hxJw==
X-CSE-MsgGUID: kyV2snYbTdG6mQeAATyfCA==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="45260807"
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="45260807"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 00:14:41 -0700
X-CSE-ConnectionGUID: 3+LEDsoyRZOe/UG+VQsOdg==
X-CSE-MsgGUID: B+ITTU1YQsmd/+VIvVOkVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="75741048"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 09 Oct 2024 00:14:38 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1syQu4-0008vO-2F;
	Wed, 09 Oct 2024 07:14:36 +0000
Date: Wed, 9 Oct 2024 15:13:43 +0800
From: kernel test robot <lkp@intel.com>
To: David Zhang <yidong.zhang@amd.com>, linux-kernel@vger.kernel.org,
	linux-fpga@vger.kernel.org, mdf@kernel.org, hao.wu@intel.com,
	yilun.xu@intel.com
Cc: oe-kbuild-all@lists.linux.dev, Yidong Zhang <yidong.zhang@amd.com>,
	lizhi.hou@amd.com, Nishad Saraf <nishads@amd.com>,
	Prapul Krishnamurthy <prapulk@amd.com>
Subject: Re: [PATCH V1 3/3] drivers/fpga/amd: Add remote queue service APIs
Message-ID: <202410091512.rcCqJO6z-lkp@intel.com>
References: <20241007220128.3023169-3-yidong.zhang@amd.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007220128.3023169-3-yidong.zhang@amd.com>

Hi David,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.12-rc2 next-20241008]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Zhang/drivers-fpga-amd-Add-communication-with-firmware/20241008-060253
base:   linus/master
patch link:    https://lore.kernel.org/r/20241007220128.3023169-3-yidong.zhang%40amd.com
patch subject: [PATCH V1 3/3] drivers/fpga/amd: Add remote queue service APIs
config: i386-randconfig-054-20241009 (https://download.01.org/0day-ci/archive/20241009/202410091512.rcCqJO6z-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410091512.rcCqJO6z-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> drivers/fpga/amd/vmgmt-rm-queue.c:280:2-3: Unneeded semicolon

vim +280 drivers/fpga/amd/vmgmt-rm-queue.c

   254	
   255	static void rm_check_msg(struct work_struct *w)
   256	{
   257		struct rm_device *rdev = to_rdev_msg_monitor(w);
   258		int ret;
   259	
   260		mutex_lock(&rdev->queue);
   261	
   262		ret = rm_queue_get_cidx(rdev, RM_QUEUE_SQ, &rdev->sq.cidx);
   263		if (ret)
   264			goto error;
   265	
   266		ret = rm_queue_get_pidx(rdev, RM_QUEUE_CQ, &rdev->cq.pidx);
   267		if (ret)
   268			goto error;
   269	
   270		while (rdev->cq.cidx < rdev->cq.pidx) {
   271			ret = rm_process_msg(rdev);
   272			if (ret)
   273				break;
   274	
   275			rdev->cq.cidx++;
   276	
   277			ret = rm_queue_set_cidx(rdev, RM_QUEUE_CQ, rdev->cq.cidx);
   278			if (ret)
   279				break;
 > 280		};
   281	
   282	error:
   283		mutex_unlock(&rdev->queue);
   284	}
   285	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


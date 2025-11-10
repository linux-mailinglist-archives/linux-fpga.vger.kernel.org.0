Return-Path: <linux-fpga+bounces-1437-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A90C48392
	for <lists+linux-fpga@lfdr.de>; Mon, 10 Nov 2025 18:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 96F644F50C4
	for <lists+linux-fpga@lfdr.de>; Mon, 10 Nov 2025 16:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08205325715;
	Mon, 10 Nov 2025 16:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RibJyiN7"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBFF3203A7;
	Mon, 10 Nov 2025 16:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762793112; cv=none; b=FrPhENFWncFtAAjY/PTd0Zo4G7Fy/fpyMA7/YldRdDE7TUiWJnMjT7mK4evWMchKSaJOjZK04eUopMrl12I6CMZIXf9iHvCn6QL8uIphBEFgA0373RFJ/zbtiOcEuGKgU86IWtef1kNVVIoNmL+szATeMF3kiuUNrLisK8T+qDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762793112; c=relaxed/simple;
	bh=6f20xq54TtLMEztquYTz/7sBfmq6m9A/0irzWSYMt5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=snD8O/0n/q9r+HuFCLE/pA05na5VrO+Y4ZDW07FCO7epX1jwkJCZZadZy4IURjU/rkw6vPotIO8nK1LBRZb01sgRcx7Rheq3VonAospOjFJ2nzMKz72SRy+LKf3ew68unNjyC3+g/pmKblcoZ4fhR42cdrXkaDviw+1dSklYNCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RibJyiN7; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762793111; x=1794329111;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6f20xq54TtLMEztquYTz/7sBfmq6m9A/0irzWSYMt5A=;
  b=RibJyiN7dxIACcTtSLDg2Scsq273aNPVHLHjVOXRlNMquqLFvMNT4SqQ
   T/asvdX921Z6xTW+Rymg2+4tKFY10kUUMP/JLb+4acqewpBiC0BnETMh1
   T9TxnhTesrI2BhCZSzBQguBKcLvaZFPt4JAD6cbxc2JXyiS4UJQ3yxNEe
   clfsaOp55LF82wUMg0gWP1liQ74qXFOxRTmtceWxE/taQLblOUtc/tPzT
   rcC41EcAnj6p3tLLOFZcW4vIYMcAdivR6fM+tJVJBTKLyWyfTvz/jN2E1
   puqcuS7YpFpZ6mNZmsZN3ag2Uufrybv+wgiAu7fieg7JRwS9oDNvdfgwg
   w==;
X-CSE-ConnectionGUID: PxXHTDQzR5W+k1eQlgnjMA==
X-CSE-MsgGUID: fy6wZb+eSV2XDAUP7rCCsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="68693895"
X-IronPort-AV: E=Sophos;i="6.19,294,1754982000"; 
   d="scan'208";a="68693895"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 08:45:10 -0800
X-CSE-ConnectionGUID: 8AFq1LKyRMmFIRouCX1Frw==
X-CSE-MsgGUID: 5NKautCWTWy8rabxuFIM7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,294,1754982000"; 
   d="scan'208";a="225975965"
Received: from lkp-server01.sh.intel.com (HELO 7b01c990427b) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 10 Nov 2025 08:45:08 -0800
Received: from kbuild by 7b01c990427b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vIV0s-0000h9-27;
	Mon, 10 Nov 2025 16:45:06 +0000
Date: Tue, 11 Nov 2025 00:44:24 +0800
From: kernel test robot <lkp@intel.com>
To: Rosen Penev <rosenp@gmail.com>, linux-fpga@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] fpga: stratix10-soc: add COMPILE_TEST support
Message-ID: <202511110022.BepBhYbE-lkp@intel.com>
References: <20251106185938.6419-3-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106185938.6419-3-rosenp@gmail.com>

Hi Rosen,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.18-rc5 next-20251110]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Rosen-Penev/fpga-stratix10-soc-add-missing-header/20251107-030213
base:   linus/master
patch link:    https://lore.kernel.org/r/20251106185938.6419-3-rosenp%40gmail.com
patch subject: [PATCH 2/2] fpga: stratix10-soc: add COMPILE_TEST support
config: nios2-allyesconfig (https://download.01.org/0day-ci/archive/20251111/202511110022.BepBhYbE-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251111/202511110022.BepBhYbE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511110022.BepBhYbE-lkp@intel.com/

All errors (new ones prefixed by >>):

   nios2-linux-ld: drivers/fpga/stratix10-soc.o: in function `s10_remove':
>> stratix10-soc.c:(.text+0x1c): undefined reference to `stratix10_svc_free_channel'
>> stratix10-soc.c:(.text+0x1c): relocation truncated to fit: R_NIOS2_CALL26 against `stratix10_svc_free_channel'
   nios2-linux-ld: drivers/fpga/stratix10-soc.o: in function `s10_svc_send_msg':
>> stratix10-soc.c:(.text+0xb4): undefined reference to `stratix10_svc_send'
>> stratix10-soc.c:(.text+0xb4): relocation truncated to fit: R_NIOS2_CALL26 against `stratix10_svc_send'
   nios2-linux-ld: drivers/fpga/stratix10-soc.o: in function `s10_probe':
>> stratix10-soc.c:(.text+0x1d4): undefined reference to `stratix10_svc_request_channel_byname'
>> stratix10-soc.c:(.text+0x1d4): relocation truncated to fit: R_NIOS2_CALL26 against `stratix10_svc_request_channel_byname'
>> nios2-linux-ld: stratix10-soc.c:(.text+0x25c): undefined reference to `stratix10_svc_free_channel'
   stratix10-soc.c:(.text+0x25c): relocation truncated to fit: R_NIOS2_CALL26 against `stratix10_svc_free_channel'
   nios2-linux-ld: drivers/fpga/stratix10-soc.o: in function `s10_free_buffers':
>> stratix10-soc.c:(.text+0x344): undefined reference to `stratix10_svc_free_memory'
>> stratix10-soc.c:(.text+0x344): relocation truncated to fit: R_NIOS2_CALL26 against `stratix10_svc_free_memory'
   nios2-linux-ld: drivers/fpga/stratix10-soc.o: in function `s10_ops_write_complete':
>> stratix10-soc.c:(.text+0x4b0): undefined reference to `stratix10_svc_done'
>> stratix10-soc.c:(.text+0x4b0): relocation truncated to fit: R_NIOS2_CALL26 against `stratix10_svc_done'
   nios2-linux-ld: drivers/fpga/stratix10-soc.o: in function `s10_ops_write_init':
>> stratix10-soc.c:(.text+0x988): undefined reference to `stratix10_svc_allocate_memory'
>> stratix10-soc.c:(.text+0x988): relocation truncated to fit: R_NIOS2_CALL26 against `stratix10_svc_allocate_memory'
>> nios2-linux-ld: stratix10-soc.c:(.text+0x9c0): undefined reference to `stratix10_svc_done'
   stratix10-soc.c:(.text+0x9c0): relocation truncated to fit: R_NIOS2_CALL26 against `stratix10_svc_done'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


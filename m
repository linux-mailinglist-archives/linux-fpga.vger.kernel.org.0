Return-Path: <linux-fpga+bounces-1275-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C30E8AEED4C
	for <lists+linux-fpga@lfdr.de>; Tue,  1 Jul 2025 06:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6D721BC0CB2
	for <lists+linux-fpga@lfdr.de>; Tue,  1 Jul 2025 04:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14154242D86;
	Tue,  1 Jul 2025 04:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FpMJnW9G"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF222248BD;
	Tue,  1 Jul 2025 04:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751344237; cv=none; b=bSZPskPqjGnUnrLUeF8apQg8jtFQnDLp9NiwSK5pIHeOiGOgiZ3givyf2wjgcWFkbzkj1wl6Su6/TCE6u1QeOcNvQqZ3sWD7R3t3aojnIQ8T8rGG/cxqvu0gY6t47x4Fau0C11hiDR/iELMqWSuQ4GVMe6XfNhzqmgEzFr7KarY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751344237; c=relaxed/simple;
	bh=ESSpbAhyzHl+us763V2GUBX0A0mjMQTO+0IGNVgjxfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g4OXQAl0BaRgzFyd61tjd1pSR285t5yTE2hTLvrNmm4rsUj/+USKVX10GEWuKdmkMu4Lah+PvVlpmMU1LOISrkmsHQhP1wHG6QPcksTJNo/1DQ2XAwVy8HuLDO26GTZBMGOuN5M9tyupnBfa0zv/CEswRba0gLBJZy+NZ88dh/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FpMJnW9G; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751344236; x=1782880236;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ESSpbAhyzHl+us763V2GUBX0A0mjMQTO+0IGNVgjxfM=;
  b=FpMJnW9G/uB7RWOZE/0gNJgryCdGcVCEjlrV2yefw/QAToq+9xU9XqLh
   YSJqQXFcXk8OQPDWt9cQ5vPFtbZAosY5L0MFWMbz7/T+o2BWzDk38CjoZ
   DgsqrWoUePdN3QRtkYYkXv9KmTbNY1mWGRMf60AX+tZKxFHLJni/maXoM
   deor+/hf4EFf/buMUCu80KL0ReU4iLSm2OEzdWdgLyn43egVgJ9+8z1y/
   asR0ywOTljni1Wk+yKhhor90eiOv2IovbCNIZ+O4g+Pgk8L/X68ZWSFnS
   jYg2/w+OaIMwMnVbtyVyOdvAqig/zMg4yJ7pR6odXKNsy4ER2FAYZVC26
   Q==;
X-CSE-ConnectionGUID: gx8Zit1yRfaougBW7xa28g==
X-CSE-MsgGUID: nYvUhEFPQu+VKahXRX8JfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11480"; a="53713226"
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="53713226"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 21:30:35 -0700
X-CSE-ConnectionGUID: km7WhSfYTM2b/SWYFPbUsw==
X-CSE-MsgGUID: RCcT1HKfR+eqqyC3FEZfdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="153042577"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 30 Jun 2025 21:30:33 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uWSda-000ZiQ-0T;
	Tue, 01 Jul 2025 04:30:30 +0000
Date: Tue, 1 Jul 2025 12:30:10 +0800
From: kernel test robot <lkp@intel.com>
To: Ryan Chung <seokwoo.chung130@gmail.com>, hao.wu@intel.com,
	trix@redhat.com, mdf@kernel.org, yilun.xu@intel.com
Cc: oe-kbuild-all@lists.linux.dev, linux-fpga@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev, linux-kernel@vger.kernel.org,
	Ryan Chung <seokwoo.chung130@gmail.com>
Subject: Re: [PATCH] fpga: dfl: Replace scnprintf() with sysfs_emit()
Message-ID: <202507011152.ULf4bZsW-lkp@intel.com>
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
config: x86_64-randconfig-001-20250701 (https://download.01.org/0day-ci/archive/20250701/202507011152.ULf4bZsW-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250701/202507011152.ULf4bZsW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507011152.ULf4bZsW-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from arch/x86/include/asm/page_types.h:9,
                    from arch/x86/include/asm/ptrace.h:6,
                    from arch/x86/include/asm/math_emu.h:5,
                    from arch/x86/include/asm/processor.h:13,
                    from arch/x86/include/asm/timex.h:5,
                    from include/linux/timex.h:67,
                    from include/linux/time32.h:13,
                    from include/linux/time.h:60,
                    from include/linux/stat.h:19,
                    from include/linux/module.h:13,
                    from drivers/fpga/dfl-afu-main.c:18:
   drivers/fpga/dfl-afu-main.c: In function 'id_show':
>> include/vdso/page.h:15:25: warning: passing argument 2 of 'sysfs_emit' makes pointer from integer without a cast [-Wint-conversion]
      15 | #define PAGE_SIZE       (_AC(1,UL) << CONFIG_PAGE_SHIFT)
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                         |
         |                         long unsigned int
   drivers/fpga/dfl-afu-main.c:159:32: note: in expansion of macro 'PAGE_SIZE'
     159 |         return sysfs_emit(buf, PAGE_SIZE, "%d\n", id);
         |                                ^~~~~~~~~
   In file included from include/linux/kobject.h:20,
                    from include/linux/module.h:21:
   include/linux/sysfs.h:492:39: note: expected 'const char *' but argument is of type 'long unsigned int'
     492 | int sysfs_emit(char *buf, const char *fmt, ...);
         |                           ~~~~~~~~~~~~^~~
   drivers/fpga/dfl-afu-main.c: In function 'afu_id_show':
>> include/vdso/page.h:15:25: warning: passing argument 2 of 'sysfs_emit' makes pointer from integer without a cast [-Wint-conversion]
      15 | #define PAGE_SIZE       (_AC(1,UL) << CONFIG_PAGE_SHIFT)
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                         |
         |                         long unsigned int
   drivers/fpga/dfl-afu-main.c:478:32: note: in expansion of macro 'PAGE_SIZE'
     478 |         return sysfs_emit(buf, PAGE_SIZE, "%016llx%016llx\n", guidh, guidl);
         |                                ^~~~~~~~~
   include/linux/sysfs.h:492:39: note: expected 'const char *' but argument is of type 'long unsigned int'
     492 | int sysfs_emit(char *buf, const char *fmt, ...);
         |                           ~~~~~~~~~~~~^~~
--
   In file included from arch/x86/include/asm/page_types.h:9,
                    from arch/x86/include/asm/ptrace.h:6,
                    from arch/x86/include/asm/math_emu.h:5,
                    from arch/x86/include/asm/processor.h:13,
                    from arch/x86/include/asm/timex.h:5,
                    from include/linux/timex.h:67,
                    from include/linux/time32.h:13,
                    from include/linux/time.h:60,
                    from include/linux/stat.h:19,
                    from include/linux/module.h:13,
                    from dfl-afu-main.c:18:
   dfl-afu-main.c: In function 'id_show':
>> include/vdso/page.h:15:25: warning: passing argument 2 of 'sysfs_emit' makes pointer from integer without a cast [-Wint-conversion]
      15 | #define PAGE_SIZE       (_AC(1,UL) << CONFIG_PAGE_SHIFT)
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                         |
         |                         long unsigned int
   dfl-afu-main.c:159:32: note: in expansion of macro 'PAGE_SIZE'
     159 |         return sysfs_emit(buf, PAGE_SIZE, "%d\n", id);
         |                                ^~~~~~~~~
   In file included from include/linux/kobject.h:20,
                    from include/linux/module.h:21:
   include/linux/sysfs.h:492:39: note: expected 'const char *' but argument is of type 'long unsigned int'
     492 | int sysfs_emit(char *buf, const char *fmt, ...);
         |                           ~~~~~~~~~~~~^~~
   dfl-afu-main.c: In function 'afu_id_show':
>> include/vdso/page.h:15:25: warning: passing argument 2 of 'sysfs_emit' makes pointer from integer without a cast [-Wint-conversion]
      15 | #define PAGE_SIZE       (_AC(1,UL) << CONFIG_PAGE_SHIFT)
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                         |
         |                         long unsigned int
   dfl-afu-main.c:478:32: note: in expansion of macro 'PAGE_SIZE'
     478 |         return sysfs_emit(buf, PAGE_SIZE, "%016llx%016llx\n", guidh, guidl);
         |                                ^~~~~~~~~
   include/linux/sysfs.h:492:39: note: expected 'const char *' but argument is of type 'long unsigned int'
     492 | int sysfs_emit(char *buf, const char *fmt, ...);
         |                           ~~~~~~~~~~~~^~~


vim +/sysfs_emit +15 include/vdso/page.h

efe8419ae78d65e Vincenzo Frascino 2024-10-14  14  
efe8419ae78d65e Vincenzo Frascino 2024-10-14 @15  #define PAGE_SIZE	(_AC(1,UL) << CONFIG_PAGE_SHIFT)
efe8419ae78d65e Vincenzo Frascino 2024-10-14  16  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


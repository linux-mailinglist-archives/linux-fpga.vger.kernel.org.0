Return-Path: <linux-fpga+bounces-1114-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66BB3A60D27
	for <lists+linux-fpga@lfdr.de>; Fri, 14 Mar 2025 10:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B46FC3A3713
	for <lists+linux-fpga@lfdr.de>; Fri, 14 Mar 2025 09:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214A31EB1B5;
	Fri, 14 Mar 2025 09:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YnqSazN9"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405B41DFD83;
	Fri, 14 Mar 2025 09:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741944240; cv=none; b=DmpLfUqLCM5qxNr//OofsBW8F73JQBGUVDTJHzXi4VrnEEUdMyd7XiT77CXPtMtud5xWzUhhjXefriX0IKmJFUMYfdEIsSbyE2gfLpo/x21C2I4fonQyQHK8OeffttHdQJ+bp72xU/7rQKtoO/d6Ar5GuuwNgNjrNoHsn8rSPUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741944240; c=relaxed/simple;
	bh=TU43wqA/8dbhWA9scGNatwoVqQof5AVD2D/WCmQyh3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XpfKrwcFBLCKiN/m6lGDw9WmrgIwfyDkvekpC83EyP1nLBSGzGOZOiOzs3+MwWPOFQwJe5AjUmGoXU+38eYCh0Q2duz2EHyzUW583FW64Nb2uIgdLv6BMQQzL72fdz/3wDIFyqyW4gDbksnOpf1+aVMUMLJv26Nex3GqZIRS+MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YnqSazN9; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741944237; x=1773480237;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TU43wqA/8dbhWA9scGNatwoVqQof5AVD2D/WCmQyh3c=;
  b=YnqSazN9McEn0adfOsHUlN1p3rBo5QKKbjEhuylCBa/mSGByy8FX3EnQ
   0wOWLZuDriD4jt+O9miG59/xbEFLluOFVsXpx913CU3RKZbGvY/n3Fj1y
   ex1xB4UFDz292v1N1ZHu/GBrAJfoD1FRW71ljVBmbnq2QvoRUj3VbFWfo
   rr/gV9G2GUWwilxDtlHYLrGARSUVd3AwCQ5RapB0VO+ZrvYH+9dxr6t1w
   TidUIYPmPKIrR17zepWTIle7wf3I7cWuF3PhasVyAf495kF/utsUVHcS6
   CjeoqyTo5TNK4jgPC7qFtN7wuYBx2WVz/sL++uEX/39Q1C5xQHsmsyC5o
   A==;
X-CSE-ConnectionGUID: 7ttRWp6sSgKWke17DpT1uw==
X-CSE-MsgGUID: In8a+m2XRyOhdxArNVQA6Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="65547237"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="65547237"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 02:23:57 -0700
X-CSE-ConnectionGUID: TNVymWu0Sd62m3Efu0MvMg==
X-CSE-MsgGUID: ueA2IGZpScuFaNA+Qj2oEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="152071766"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 14 Mar 2025 02:23:53 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tt1Gh-000AIA-1y;
	Fri, 14 Mar 2025 09:23:51 +0000
Date: Fri, 14 Mar 2025 17:23:04 +0800
From: kernel test robot <lkp@intel.com>
To: Nuno =?iso-8859-1?Q?S=E1?= via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>,
	linux-clk@vger.kernel.org, linux-fpga@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Stephen Boyd <sboyd@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
Subject: Re: [PATCH v2 6/6] clk: clk-axi-clkgen: fix coding style issues
Message-ID: <202503141741.UAwRQuuG-lkp@intel.com>
References: <20250313-dev-axi-clkgen-limits-v2-6-173ae2ad6311@analog.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313-dev-axi-clkgen-limits-v2-6-173ae2ad6311@analog.com>

Hi Nuno,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 82f69876ef45ad66c0b114b786c7c6ac0f6a4580]

url:    https://github.com/intel-lab-lkp/linux/commits/Nuno-S-via-B4-Relay/clk-clk-axi-clkgen-fix-fpfd_max-frequency-for-zynq/20250313-231624
base:   82f69876ef45ad66c0b114b786c7c6ac0f6a4580
patch link:    https://lore.kernel.org/r/20250313-dev-axi-clkgen-limits-v2-6-173ae2ad6311%40analog.com
patch subject: [PATCH v2 6/6] clk: clk-axi-clkgen: fix coding style issues
config: riscv-randconfig-002-20250314 (https://download.01.org/0day-ci/archive/20250314/202503141741.UAwRQuuG-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250314/202503141741.UAwRQuuG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503141741.UAwRQuuG-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/clk/clk-axi-clkgen.c: In function 'axi_clkgen_calc_clk_params':
>> drivers/clk/clk-axi-clkgen.c:229:35: warning: suggest parentheses around comparison in operand of '^' [-Wparentheses]
     229 |                 if ((params->edge == 0 ^ frac_divider == 1) ||
         |                      ~~~~~~~~~~~~~^~~~


vim +229 drivers/clk/clk-axi-clkgen.c

   198	
   199	static void axi_clkgen_calc_clk_params(unsigned int divider,
   200					       unsigned int frac_divider,
   201					       struct axi_clkgen_div_params *params)
   202	{
   203		memset(params, 0x0, sizeof(*params));
   204	
   205		if (divider == 1) {
   206			params->nocount = 1;
   207			return;
   208		}
   209	
   210		if (frac_divider == 0) {
   211			params->high = divider / 2;
   212			params->edge = divider % 2;
   213			params->low = divider - params->high;
   214		} else {
   215			params->frac_en = 1;
   216			params->frac = frac_divider;
   217	
   218			params->high = divider / 2;
   219			params->edge = divider % 2;
   220			params->low = params->high;
   221	
   222			if (params->edge == 0) {
   223				params->high--;
   224				params->frac_wf_r = 1;
   225			}
   226	
   227			if (params->edge == 0 || frac_divider == 1)
   228				params->low--;
 > 229			if ((params->edge == 0 ^ frac_divider == 1) ||
   230			    (divider == 2 && frac_divider == 1))
   231				params->frac_wf_f = 1;
   232	
   233			params->frac_phase = params->edge * 4 + frac_divider / 2;
   234		}
   235	}
   236	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


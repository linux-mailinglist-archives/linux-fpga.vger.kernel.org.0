Return-Path: <linux-fpga+bounces-1435-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0174CC44D35
	for <lists+linux-fpga@lfdr.de>; Mon, 10 Nov 2025 04:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A341C345915
	for <lists+linux-fpga@lfdr.de>; Mon, 10 Nov 2025 03:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA43278753;
	Mon, 10 Nov 2025 03:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TlQaRIvi"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130842777FC;
	Mon, 10 Nov 2025 03:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762744932; cv=none; b=ouWHxqQJ3f3Vj2m7tcZJPhgCe97tfdcVw1EIXELU7usvkRzDZvhnoywEPeyQLYNNREKAmvfC8Tt9F79/mneyuQc8c+77Aeanq1MlDx3tC2aDjkA6rQ1+ENhkryvIfNW3QEZiRKQY/RpVzU8DCvSaKAoFLLeE/3EBHsTgAVLa3+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762744932; c=relaxed/simple;
	bh=fFXeusc/ORNmXapL4y2WMn4jZ5Sv6ZxjnhBOK9sOlfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aRh3c0LkxDGcFugkoMy6de4aFdC7FQEIGG5ZQpz17nsmbYKup1vYLanCQnzPos8//87w0jiiu5YLhim64WCgj37OlU6Pos7OVFZMY5UhvFirZGCBDiYSyqdaZxoS0p5XJ3P+OS4JH2RWnwPjdhKn/ct70UevDbIs+vc6Myk9GD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TlQaRIvi; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762744931; x=1794280931;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fFXeusc/ORNmXapL4y2WMn4jZ5Sv6ZxjnhBOK9sOlfs=;
  b=TlQaRIviD/37lNzRiGr/Vx1QPOAYmL2TXvn83D9+u7EzJ28ff8UyTu2I
   gVtm3riiBIMiGJLf9omsOhP5oIlKK+6F0bQBpVgRxc0nJ/ohND/Mfk/Io
   TWpc8xfwt4lVyCTdFY5IvhzJUgr5JJKPyZ4D8FTmOH/eT6gAvlMdjbqI3
   KVd9FhNnxJbBzN0dtahUFTwgZ/nDR/Bbv/XHYAxp+N1h/7hvhWvNqRHCZ
   8Shai8IQoSZhaEDxBqu1HeBBprWrhwRks7S/6SsFj6sHeIZ0dRJb/S34m
   Rj3ZaZTAlyGMh+8Hy70bAWqebW1mpA8yVO2gexG3QxdsbjYo75J1ltoxs
   A==;
X-CSE-ConnectionGUID: 6vrUDJ54Tf2O5ERrphHMow==
X-CSE-MsgGUID: xxNWjpCPRFCe6TKRE0OUkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11608"; a="76142571"
X-IronPort-AV: E=Sophos;i="6.19,292,1754982000"; 
   d="scan'208";a="76142571"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2025 19:22:10 -0800
X-CSE-ConnectionGUID: 7VJglhsETQGo68803dEwIA==
X-CSE-MsgGUID: fEuu/wdJRaesSck5hMQa8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,292,1754982000"; 
   d="scan'208";a="188514149"
Received: from lkp-server01.sh.intel.com (HELO 6ef82f2de774) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 09 Nov 2025 19:22:09 -0800
Received: from kbuild by 6ef82f2de774 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vIITm-0002cJ-0a;
	Mon, 10 Nov 2025 03:22:06 +0000
Date: Mon, 10 Nov 2025 11:21:38 +0800
From: kernel test robot <lkp@intel.com>
To: Rosen Penev <rosenp@gmail.com>, linux-fpga@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] fpga: stratix10-soc: add COMPILE_TEST support
Message-ID: <202511101109.ZYEQ8h7p-lkp@intel.com>
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
[also build test ERROR on v6.18-rc5 next-20251107]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Rosen-Penev/fpga-stratix10-soc-add-missing-header/20251107-030213
base:   linus/master
patch link:    https://lore.kernel.org/r/20251106185938.6419-3-rosenp%40gmail.com
patch subject: [PATCH 2/2] fpga: stratix10-soc: add COMPILE_TEST support
config: nios2-allmodconfig (https://download.01.org/0day-ci/archive/20251110/202511101109.ZYEQ8h7p-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251110/202511101109.ZYEQ8h7p-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511101109.ZYEQ8h7p-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "stratix10_svc_free_channel" [drivers/fpga/stratix10-soc.ko] undefined!
>> ERROR: modpost: "stratix10_svc_send" [drivers/fpga/stratix10-soc.ko] undefined!
>> ERROR: modpost: "stratix10_svc_request_channel_byname" [drivers/fpga/stratix10-soc.ko] undefined!
>> ERROR: modpost: "stratix10_svc_free_memory" [drivers/fpga/stratix10-soc.ko] undefined!
>> ERROR: modpost: "stratix10_svc_done" [drivers/fpga/stratix10-soc.ko] undefined!
>> ERROR: modpost: "stratix10_svc_allocate_memory" [drivers/fpga/stratix10-soc.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


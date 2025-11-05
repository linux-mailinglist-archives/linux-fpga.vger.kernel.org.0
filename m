Return-Path: <linux-fpga+bounces-1414-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA7AC3433B
	for <lists+linux-fpga@lfdr.de>; Wed, 05 Nov 2025 08:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4C6E14E5C26
	for <lists+linux-fpga@lfdr.de>; Wed,  5 Nov 2025 07:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009782C15B6;
	Wed,  5 Nov 2025 07:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HmRj98Hy"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A7328A3F2;
	Wed,  5 Nov 2025 07:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762327157; cv=none; b=OGfcGHcRzh5yA+IkcWwy1LHuHf1C9kwJEMBPBg8rdQ6HuHqWX83av59VqhRZ/0o/bg8EUJCgA8hDLE48+GraEZXfrkfA+h02oT+ge0jUvfLa3/3V+6SEjbMZZ7LF1fCuofAh/flGI7XCH3bKw5SkPcOi8+lh8mYiYOQKHCcPXlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762327157; c=relaxed/simple;
	bh=0KK7ia02w0Fvey6RGHPOajTij35rBwtDHsoWATuFaL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mwSkN+KyvPS4hgv8JKRinT0i8gWMkR95s6BqZS2ke416tkK4HEd2yTZ6UquM+tU+5xa9LtV4TrCmn+Q+tFBqQYFlPSGyec08omh4AjQpksqxnv8RULW3dvEvK35/Wjy0iC983lWtU70jtSF1c+ObTlUmpowujCEcW80xFPDGbwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HmRj98Hy; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762327157; x=1793863157;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0KK7ia02w0Fvey6RGHPOajTij35rBwtDHsoWATuFaL0=;
  b=HmRj98HyOBq4a1nRGfLRY+ciCxzhwCxfwAKIeZjHg7rGToPlfrfDFDqA
   kJmbGGMsljah24tUi1hqeM4Qe5cwNBLBNSMzMWMCIzgUkFYUswMNjlc+Z
   3mEJ272vvYnIh9zZuNRvFtNykPnOMIxEmWAS89y8uXtmqOMsc/4YxcJ75
   HyMmoFBRVvu5mx50fEzhBXdm1FJsD/AdWbPEG+8BQi+qoHFSDWgHJBu+o
   FDHfJ4keF4UICRnsgPCCOgkDnejKmuylvklWfPfurWrKZkzm8zc8DlBun
   oK0zYbOvwNkSU7tnsUaP1SebXCsTBX0OgBTyPPPuOmyaUhIlwtLP3l/W1
   Q==;
X-CSE-ConnectionGUID: bH8KOJwxQ3at0M8R4Nx3dA==
X-CSE-MsgGUID: 0KADcc1GSSS0DnnwvC1A1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="67048825"
X-IronPort-AV: E=Sophos;i="6.19,281,1754982000"; 
   d="scan'208";a="67048825"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 23:19:16 -0800
X-CSE-ConnectionGUID: gorJg/h5RdiRJnLbOALtZQ==
X-CSE-MsgGUID: CnPV+/N0QXm8zJ0zw+gS5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,281,1754982000"; 
   d="scan'208";a="191671317"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 04 Nov 2025 23:19:14 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vGXnL-000SFs-0A;
	Wed, 05 Nov 2025 07:19:04 +0000
Date: Wed, 5 Nov 2025 15:17:59 +0800
From: kernel test robot <lkp@intel.com>
To: Ian Abbott <abbotti@mev.co.uk>, linux-fpga@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
	linux-kernel@vger.kernel.org, Ian Abbott <abbotti@mev.co.uk>
Subject: Re: [PATCH 1/4] fpga: altera-pr-ip: Add dummy definitions of API
 functions
Message-ID: <202511051513.Wkv71gq0-lkp@intel.com>
References: <20251104153013.154463-2-abbotti@mev.co.uk>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104153013.154463-2-abbotti@mev.co.uk>

Hi Ian,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.18-rc4 next-20251104]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ian-Abbott/fpga-altera-pr-ip-Add-dummy-definitions-of-API-functions/20251105-000956
base:   linus/master
patch link:    https://lore.kernel.org/r/20251104153013.154463-2-abbotti%40mev.co.uk
patch subject: [PATCH 1/4] fpga: altera-pr-ip: Add dummy definitions of API functions
config: parisc-randconfig-001-20251105 (https://download.01.org/0day-ci/archive/20251105/202511051513.Wkv71gq0-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 12.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251105/202511051513.Wkv71gq0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511051513.Wkv71gq0-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/fpga/altera-pr-ip-core.c:11:
>> include/linux/fpga/altera-pr-ip-core.h:11: error: unterminated #ifndef
      11 | #ifndef _ALT_PR_IP_CORE_H
         | 
>> drivers/fpga/altera-pr-ip-core.c:176:5: error: redefinition of 'alt_pr_register'
     176 | int alt_pr_register(struct device *dev, void __iomem *reg_base)
         |     ^~~~~~~~~~~~~~~
   include/linux/fpga/altera-pr-ip-core.h:19:19: note: previous definition of 'alt_pr_register' with type 'int(struct device *, void *)'
      19 | static inline int alt_pr_register(struct device *dev, void __iomem *reg_base)
         |                   ^~~~~~~~~~~~~~~
--
   In file included from altera-pr-ip-core.c:11:
>> include/linux/fpga/altera-pr-ip-core.h:11: error: unterminated #ifndef
      11 | #ifndef _ALT_PR_IP_CORE_H
         | 
   altera-pr-ip-core.c:176:5: error: redefinition of 'alt_pr_register'
     176 | int alt_pr_register(struct device *dev, void __iomem *reg_base)
         |     ^~~~~~~~~~~~~~~
   include/linux/fpga/altera-pr-ip-core.h:19:19: note: previous definition of 'alt_pr_register' with type 'int(struct device *, void *)'
      19 | static inline int alt_pr_register(struct device *dev, void __iomem *reg_base)
         |                   ^~~~~~~~~~~~~~~


vim +11 include/linux/fpga/altera-pr-ip-core.h

d201cc17a8a31c Matthew Gerlach 2017-03-23 @11  #ifndef _ALT_PR_IP_CORE_H
d201cc17a8a31c Matthew Gerlach 2017-03-23  12  #define _ALT_PR_IP_CORE_H
d201cc17a8a31c Matthew Gerlach 2017-03-23  13  #include <linux/io.h>
961ea9f518b406 Ian Abbott      2025-11-04  14  #include <asm/errno.h>
d201cc17a8a31c Matthew Gerlach 2017-03-23  15  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


Return-Path: <linux-fpga+bounces-1000-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A31EA18CE7
	for <lists+linux-fpga@lfdr.de>; Wed, 22 Jan 2025 08:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EFEF168CE6
	for <lists+linux-fpga@lfdr.de>; Wed, 22 Jan 2025 07:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019501BEF6A;
	Wed, 22 Jan 2025 07:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g5wiEvQf"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBFD1BD9C7;
	Wed, 22 Jan 2025 07:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737531793; cv=none; b=oUBjlMFZPvbVkMJFN58iDSmPHPlGpyldT84orJVT5HLI89Yl7zajjPKbTuBltgT0JuzlTznfZPdtRVL1I2TbANwqRnc3TbKF40ll9F6isVVeZn2vrpZkP52n1YGGEHSgZ0m0JvQVSkE/Dlh4BMdMS7zx3s1xn38zUVR4waIIAyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737531793; c=relaxed/simple;
	bh=98AwB6Kppog+VQrqZXlFbfBwHPH7UsnQvM92LZJMuBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p37PTtRnuN4UGRyQEpX3F7rTuAGcfhvGADWW/W18hqqX2/4gqFtI6Ec6zTrN37kW/r1OtGMAdP+PonVlU8pJ6HDF1gp3LOBOb56HqXvWGIyJSA0aht+f7xQacxOVS4VjG0u+PrUCMcRlfu/y1E+QyvXm5cWGykPdW5WU3FMlLxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g5wiEvQf; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737531792; x=1769067792;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=98AwB6Kppog+VQrqZXlFbfBwHPH7UsnQvM92LZJMuBk=;
  b=g5wiEvQf6R+/gn70xViCqZeZ44vff8cxRE+YbiZxNmgxMkI2PdmS4yXm
   GTz5SIp0Y3sNcblvOkPG0D3u9csxpQsTGPFJf3gMQS1kIW2uuMD9oa/II
   XkvquDowhm6pKxmG1mTVIWt1pZ/2ilqo9omm5T3d2MJHyjLUfAxKK0rYM
   tRINkFKjUtS7RdnxtRDVYa6WuucZ0Lg1ni0LE26ZsSAmy7gWBKA8pjTly
   oph5cQZqrab1LnJ0vim19i88zK4+Uq2y281hTBbSDO37giM9+8UGQEGLK
   n+z+a3/rsgp++8qSvalUcl3I6/9fqR5ye9XqWjMNA2cK3IWlfyjXZr8cK
   Q==;
X-CSE-ConnectionGUID: K9RXABiQQlaEqejUDM0zaQ==
X-CSE-MsgGUID: PIK6IAOqSxuEBe3Hf33EyA==
X-IronPort-AV: E=McAfee;i="6700,10204,11322"; a="49372919"
X-IronPort-AV: E=Sophos;i="6.13,224,1732608000"; 
   d="scan'208";a="49372919"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2025 23:43:11 -0800
X-CSE-ConnectionGUID: JXwhL4XtQrq86NpgWXMfUA==
X-CSE-MsgGUID: H2a1tTaHQf667a0cWNk5tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="112131092"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 21 Jan 2025 23:43:07 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1taVOD-000Zcp-0d;
	Wed, 22 Jan 2025 07:43:05 +0000
Date: Wed, 22 Jan 2025 15:42:31 +0800
From: kernel test robot <lkp@intel.com>
To: Mahesh Rao <mahesh.rao@intel.com>, Moritz Fischer <mdf@kernel.org>,
	Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dinh Nguyen <dinguyen@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-fpga@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mahesh Rao <mahesh.rao@altera.com>
Subject: Re: [PATCH 2/3] dt-bindings: firmware: stratix10: Convert to
 json-schema
Message-ID: <202501221710.7llON7lZ-lkp@intel.com>
References: <20250122-socfpga_sip_svc_misc-v1-2-cbdcd034ae34@intel.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250122-socfpga_sip_svc_misc-v1-2-cbdcd034ae34@intel.com>

Hi Mahesh,

kernel test robot noticed the following build warnings:

[auto build test WARNING on ffd294d346d185b70e28b1a28abe367bbfe53c04]

url:    https://github.com/intel-lab-lkp/linux/commits/Mahesh-Rao/dt-bindings-fpga-stratix10-Convert-to-json-schema/20250122-140026
base:   ffd294d346d185b70e28b1a28abe367bbfe53c04
patch link:    https://lore.kernel.org/r/20250122-socfpga_sip_svc_misc-v1-2-cbdcd034ae34%40intel.com
patch subject: [PATCH 2/3] dt-bindings: firmware: stratix10: Convert to json-schema
reproduce: (https://download.01.org/0day-ci/archive/20250122/202501221710.7llON7lZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501221710.7llON7lZ-lkp@intel.com/

All warnings (new ones prefixed by >>):

   Warning: Documentation/devicetree/bindings/regulator/siliconmitus,sm5703-regulator.yaml references a file that doesn't exist: Documentation/devicetree/bindings/mfd/siliconmitus,sm5703.yaml
   Warning: Documentation/hwmon/g762.rst references a file that doesn't exist: Documentation/devicetree/bindings/hwmon/g762.txt
   Warning: Documentation/hwmon/isl28022.rst references a file that doesn't exist: Documentation/devicetree/bindings/hwmon/isl,isl28022.yaml
   Warning: Documentation/translations/ja_JP/SubmittingPatches references a file that doesn't exist: linux-2.6.12-vanilla/Documentation/dontdiff
>> Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/firmware/intel,stratix10-svc.txt
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
   Warning: lib/Kconfig.debug references a file that doesn't exist: Documentation/dev-tools/fault-injection/fault-injection.rst
   Using alabaster theme

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


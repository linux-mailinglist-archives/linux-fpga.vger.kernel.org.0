Return-Path: <linux-fpga+bounces-1173-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD466A9A9F5
	for <lists+linux-fpga@lfdr.de>; Thu, 24 Apr 2025 12:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D4803A78A4
	for <lists+linux-fpga@lfdr.de>; Thu, 24 Apr 2025 10:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA5B204C2E;
	Thu, 24 Apr 2025 10:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QvLtSevx"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D025C19F40B;
	Thu, 24 Apr 2025 10:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745490072; cv=none; b=EV3Thwya0a+/Jfzeb7vIw5xcVwdXx5Qe9s1CIz5Yxy+1PMMXnF/VoXgwZSeShk1fSkcoRxHJE177Kr5tkWOkdY7Pif2W7ojUF5CxtCfT+79Vo/uaG2T4SM/U+Jh/242BYbk77dT6/0hYaWSzcsGEdsK9uOzklajjd42fm3+uKHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745490072; c=relaxed/simple;
	bh=8EUjkqxm/psCAdZRPqkUFO8JU00BjloN7TrrUog3mgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CCLk/nK3tW+0hzGMo1spcegFVD4jvfVrEOxmegDEGgJH2fvtQd/YVr/Q5/ap54ajjvSxPpJG9qufmkEe1SuYJrD0oCvbUUsSyP2KGb0pgz7xF5R0bMdcGN9ZFDjVlBdP+SBE3RgljJK/6bw77bw4QgCnWz6VTNM8b1Y/ia57fkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QvLtSevx; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745490071; x=1777026071;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=8EUjkqxm/psCAdZRPqkUFO8JU00BjloN7TrrUog3mgM=;
  b=QvLtSevxINqlUkrE7r+Db7nJH0YvpWC3CglZRl1NguaSYQCEth5lYhTf
   A8mYItwF9JHFV0AADe309vU39ftn2Fmo74nqVdwg9806XKyqoJKFHFTKX
   knTQ7+LvbepJKY/HRflyesyvOLfwFlajRoF0pSYxpdEH0vPWbdZiaVqNq
   K1vHuaH4jLS5y0OXFcvIU3qFNTUcmaH7xWIWXPEGBuNf1Czda8kDyTmq6
   VeC6kgQbxTPgPz8VZoG0kQIOmKu/rCkt03hPun1Mop0ron66BBRjbJAmN
   YQoU9WrZ63PWG7KIWh8ArGcMD/LGO/86Zfjs7EQ9mNM7LfZOtrUhN+uOw
   g==;
X-CSE-ConnectionGUID: 33R0TBEFTHu2maHj6ODP8Q==
X-CSE-MsgGUID: CCaeZRBWSFCCWufKN48geg==
X-IronPort-AV: E=McAfee;i="6700,10204,11412"; a="58486398"
X-IronPort-AV: E=Sophos;i="6.15,235,1739865600"; 
   d="scan'208";a="58486398"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 03:21:09 -0700
X-CSE-ConnectionGUID: dFcD6XaPTLybRhWauEDuCg==
X-CSE-MsgGUID: zex+pMsPQtatMOWPr+venA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,235,1739865600"; 
   d="scan'208";a="163616817"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa001.fm.intel.com with ESMTP; 24 Apr 2025 03:21:06 -0700
Date: Thu, 24 Apr 2025 18:16:30 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: nuno.sa@analog.com
Cc: linux-clk@vger.kernel.org, linux-fpga@vger.kernel.org,
	Stephen Boyd <sboyd@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
Subject: Re: [PATCH RESEND v3 3/6] include: fpga: adi-axi-common: add new
 helper macros
Message-ID: <aAoPfoL8ZDBK7hf6@yilunxu-OptiPlex-7050>
References: <20250421-dev-axi-clkgen-limits-v3-0-4203b4fed2c9@analog.com>
 <20250421-dev-axi-clkgen-limits-v3-3-4203b4fed2c9@analog.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250421-dev-axi-clkgen-limits-v3-3-4203b4fed2c9@analog.com>

On Mon, Apr 21, 2025 at 03:58:04PM +0100, Nuno Sá via B4 Relay wrote:
> From: Nuno Sá <nuno.sa@analog.com>
> 
> Add new helper macros and enums to help identifying the platform and some
> characteristics of it at runtime.
> 
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> ---
>  include/linux/fpga/adi-axi-common.h | 35 +++++++++++++++++++++++++++++++++++

I'm wondering why these definitions (including existing ones) are in
fpga directory. They are not specific for any fpga_manager driver. I
suggest move the whole file out of fpga/

Thanks,
Yilun

>  1 file changed, 35 insertions(+)
> 
> diff --git a/include/linux/fpga/adi-axi-common.h b/include/linux/fpga/adi-axi-common.h
> index 141ac3f251e6f256526812b9d55cd440a2a46e76..a832ef9b37473ca339a2a2ff8a4a5716d428fd29 100644
> --- a/include/linux/fpga/adi-axi-common.h
> +++ b/include/linux/fpga/adi-axi-common.h
> @@ -12,6 +12,8 @@
>  #define ADI_AXI_COMMON_H_
>  
>  #define ADI_AXI_REG_VERSION			0x0000
> +#define ADI_AXI_REG_FPGA_INFO			0x001C
> +#define ADI_AXI_REG_FPGA_VOLTAGE		0x0140
>  
>  #define ADI_AXI_PCORE_VER(major, minor, patch)	\
>  	(((major) << 16) | ((minor) << 8) | (patch))
> @@ -20,4 +22,37 @@
>  #define ADI_AXI_PCORE_VER_MINOR(version)	(((version) >> 8) & 0xff)
>  #define ADI_AXI_PCORE_VER_PATCH(version)	((version) & 0xff)
>  
> +#define ADI_AXI_INFO_FPGA_TECH(info)            (((info) >> 24) & 0xff)
> +#define ADI_AXI_INFO_FPGA_FAMILY(info)          (((info) >> 16) & 0xff)
> +#define ADI_AXI_INFO_FPGA_SPEED_GRADE(info)     (((info) >> 8) & 0xff)
> +#define ADI_AXI_INFO_FPGA_VOLTAGE(val)          ((val) & 0xffff)
> +
> +enum adi_axi_fpga_technology {
> +	ADI_AXI_FPGA_TECH_UNKNOWN = 0,
> +	ADI_AXI_FPGA_TECH_SERIES7,
> +	ADI_AXI_FPGA_TECH_ULTRASCALE,
> +	ADI_AXI_FPGA_TECH_ULTRASCALE_PLUS,
> +};
> +
> +enum adi_axi_fpga_family {
> +	ADI_AXI_FPGA_FAMILY_UNKNOWN = 0,
> +	ADI_AXI_FPGA_FAMILY_ARTIX,
> +	ADI_AXI_FPGA_FAMILY_KINTEX,
> +	ADI_AXI_FPGA_FAMILY_VIRTEX,
> +	ADI_AXI_FPGA_FAMILY_ZYNQ,
> +};
> +
> +enum adi_axi_fpga_speed_grade {
> +	ADI_AXI_FPGA_SPEED_UNKNOWN      = 0,
> +	ADI_AXI_FPGA_SPEED_1    = 10,
> +	ADI_AXI_FPGA_SPEED_1L   = 11,
> +	ADI_AXI_FPGA_SPEED_1H   = 12,
> +	ADI_AXI_FPGA_SPEED_1HV  = 13,
> +	ADI_AXI_FPGA_SPEED_1LV  = 14,
> +	ADI_AXI_FPGA_SPEED_2    = 20,
> +	ADI_AXI_FPGA_SPEED_2L   = 21,
> +	ADI_AXI_FPGA_SPEED_2LV  = 22,
> +	ADI_AXI_FPGA_SPEED_3    = 30,
> +};
> +
>  #endif /* ADI_AXI_COMMON_H_ */
> 
> -- 
> 2.49.0
> 
> 
> 


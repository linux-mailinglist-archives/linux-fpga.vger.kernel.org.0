Return-Path: <linux-fpga+bounces-1083-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1908CA4B8A3
	for <lists+linux-fpga@lfdr.de>; Mon,  3 Mar 2025 08:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29FA316D1D8
	for <lists+linux-fpga@lfdr.de>; Mon,  3 Mar 2025 07:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9411EC012;
	Mon,  3 Mar 2025 07:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ioHZQeae"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9310E1D63C0;
	Mon,  3 Mar 2025 07:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740988763; cv=none; b=cHA4FZVry3usANG40EIUo9Crml2r9fnZpEKVI6pXdxtc4dpRCAnxVmHfTXeYyX5rkuHJTYfSRHWVANnu/gHiNhKqjOL0/GQpzlOqrOKSGkSN0E9lLYVAJdQqXlibki1Cqx/OPmxNA/AXZkppg1cASZRn2Z56QHiF1Q/mQ0ITyv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740988763; c=relaxed/simple;
	bh=Xta72Xtoqtmx6r5+q/pD/V08xqthdy7owZ3Wj5jOESY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RYftwOjIJBr9p57hWnpLEahwQhn1Nn8IGDE/PIMiujgKDaLafwstC3uGRw3kgFbZzJKqmxsO7R7QFvXnE3QHAu16a7YEkmAzgA5S8eAtX9PusQsTg2TkUeuuHH1Y2O+ATb6Zq93Rs1zqbYlDyJTA/4hVTyNc/BpCaKn3uB9L2uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ioHZQeae; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740988763; x=1772524763;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Xta72Xtoqtmx6r5+q/pD/V08xqthdy7owZ3Wj5jOESY=;
  b=ioHZQeaer7zaLv6qiwY2bTO9G6gpTectTEVYECkcCVMzFDmvOrtMZtqR
   Zsu66BqAfcwFbcjNhXonjDWbbsoZ3vtL6WFbotUEi4IkgOKvnheIJSOXU
   HtJqMjS76aAKzsuszn4oLyuDj9t0942eQJ3ZiMiHM1iiINn/XAEI6lsX7
   6LohKAmo6Zb1JtQmXxShM/DbX+jGNHkOSrxPS1sHTovb02DvxwFFZ1rBy
   BpSbYhpSIsCKrNkt5+ogsz5v3YAEzT8X6qVak3WmNAw9DPGQcebgA5/ti
   NPheqa2exD3HwkG+KKOFJf8Nq8lcQLnXCwwV5vQGDcTTHJERaxr8/HkiR
   A==;
X-CSE-ConnectionGUID: OwrjfLUlRW2BztUbRLZfNQ==
X-CSE-MsgGUID: To3JaBQQTLWkZtQL92UYkA==
X-IronPort-AV: E=McAfee;i="6700,10204,11361"; a="41975215"
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; 
   d="scan'208";a="41975215"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2025 23:59:22 -0800
X-CSE-ConnectionGUID: tDUV7ep6QcGAfQ+7/1/EYQ==
X-CSE-MsgGUID: k2oG920CShaV+Co+pDdUHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; 
   d="scan'208";a="118628401"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa009.fm.intel.com with ESMTP; 02 Mar 2025 23:59:11 -0800
Date: Mon, 3 Mar 2025 15:57:06 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Yidong Zhang <yidong.zhang@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
	mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
	lizhi.hou@amd.com, DMG Karthik <Karthik.DMG@amd.com>,
	Nishad Saraf <nishads@amd.com>,
	Hayden Laccabue <hayden.laccabue@amd.com>
Subject: Re: [PATCH V2 1/4] drivers/fpga/amd: Add new driver amd versal-pci
Message-ID: <Z8Vg0nJ2T9ezHDVf@yilunxu-OptiPlex-7050>
References: <Z6Q3W2mUw/ZbtnWV@yilunxu-OptiPlex-7050>
 <796e2826-a423-4d0c-977a-105ed236e067@amd.com>
 <Z6Vtz/Bb8wsIH0pG@yilunxu-OptiPlex-7050>
 <7b9bd24f-8f89-4d6c-a079-47c4c0b88a35@amd.com>
 <Z6WO2Ktc9HoqdUSU@yilunxu-OptiPlex-7050>
 <e68be2e2-7fdd-4f09-b479-4b0e31af5be5@amd.com>
 <Z6sT20uzjes7SGzr@yilunxu-OptiPlex-7050>
 <84281771-52d8-4b1d-8478-1fedb6f31608@amd.com>
 <Z8LDSjhcXvwnyeiF@yilunxu-OptiPlex-7050>
 <790910eb-4876-49de-b8eb-0ac50868bc1f@amd.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <790910eb-4876-49de-b8eb-0ac50868bc1f@amd.com>

On Sat, Mar 01, 2025 at 11:03:29AM -0800, Yidong Zhang wrote:
> 
> 
> On 3/1/25 00:20, Xu Yilun wrote:
> > Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> > 
> > 
> > > My last question for this topic:
> > > If we decide to upstream both userPF and mgmtPF driver together, could them
> > > be both within the drivers/fpga/amd as in-tree driver? This will help user
> > 
> > I don't look into your full driver stack. Generally, if your drivers are
> > all about reprogramming, then yes. If they are also about all kinds of
> > accelaration functions you'd better split them out in different domains.
> > I may not have enough knowledge to make them correct.
> > 
> 
> The driver has more features than just re-programing. The re-programing is
> already done in the embedded firmware that's why the mgmtPF driver is just a
> utility driver.
> 
> The userPF driver has features such as:
>   xdma (already in drivers/xilinx/xdma as platform driver)
>   qdma (already in drivers/amd/qdma as platform driver)
>   mailbox and more which have not been upstreamed in linux kernel yet.
> 
> The driver architecture is:
> 
>   userPF driver (as pci_driver)
>     qdma (as platform_driver)
>     ..
>     mailbox (as platform_driver)
>        /\
>        ||
>        \/
>     mailbox (as platform_driver)
>   mgmtPF driver (as pci_driver)
>        /\
>        ||
>        \/
>     Embedded firmware (re-programing done here)
> 
> Right now, I am working on upstreaming the mgmtPF driver as pci_driver.
> In the future, I think the userPF driver should be fitting into the
> "drivers/fpga", given that should manage all these platform_drivers and

No I think userPF driver should manage all these *platform_devices*.
Platform_drivers could be independent and put into proper domain folders.

> utilize the fpga_region callbacks to online/offline services due to hardware

fpga_region should online/offline platform devices. Not services, which is the
job of each platform_driver.

Thanks,
Yilun

> changes after re-programing.
> 
> Thanks,
> David
> 
> > Thanks,
> > Yilun
> > 
> > > find source code easily.


Return-Path: <linux-fpga+bounces-989-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14EF79FC8B4
	for <lists+linux-fpga@lfdr.de>; Thu, 26 Dec 2024 06:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9431E18834D9
	for <lists+linux-fpga@lfdr.de>; Thu, 26 Dec 2024 05:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550ED14AD3F;
	Thu, 26 Dec 2024 05:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A8tTNQV9"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE5E823DE;
	Thu, 26 Dec 2024 05:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735192403; cv=none; b=dUpZE7qnVMaNnS7ckwXWfUhU/ojathNgNnuJ58k8YhfUorrtmBufj3dkJBrJNAp1T+JvhEO1DpP1DycsBrSJ8i1wrNxjJsYWMcHsMnNKMx/vuovD19fdLXuYlaPqSRhbThGCFf1bqd34Tl+kSBP/NqY6pl0/N1Wo14A+TszSrtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735192403; c=relaxed/simple;
	bh=BCRmiIfypeTfjv65rEu/laMqybG7Zaekl1Vc37F+N2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J2JqO72hfEx+S263OvW+e6Q+X8AMsarfCHyjwGaNGW6DI/ZafO7CE+CJOfzDttVoKFylf4KCOlqrXQHYeXLkPe6nKxcgZR9dw8l4hzSmUUb7KO1WyoCQbEmUABnDD3rGj53EPbZRgr1WRYYMc+rvspy67p/EdQTcwcuveZAzQ/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A8tTNQV9; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735192401; x=1766728401;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BCRmiIfypeTfjv65rEu/laMqybG7Zaekl1Vc37F+N2c=;
  b=A8tTNQV92o9kALN9UKvvcJY3/aFUFMFvZ0PnSZE8yCaJGxGYtHXA0t2w
   ErKV05gESxzZ31cIauymMZo6v2b41aYn0Kk09qlpMaTCXMwwSxxzVSK30
   2tbrB/7kgfyaDnt5hb+cQJX00TfCjsabdwKMWly7CXDb+ZT6yhSP3Zh3Q
   DlqCWi9ghzG0SX5LI9XRE7398yjvGeDdwVM/0q3y2TKh2nyR4gNa7lGQW
   tGD2sOW6Ycq1YlH45UQTi8YSFTJlYx96i0baVHcDE7PndPz05hiPOs5qm
   2OibZTsiOFvfCOKQObneEO8e0+pFd6F25c0nR9UhPRK8saKrGegXl67Sy
   Q==;
X-CSE-ConnectionGUID: EY5DzM6cRBi7x9MyDFzq7w==
X-CSE-MsgGUID: dizal19oQrWw8JPiLxWnrA==
X-IronPort-AV: E=McAfee;i="6700,10204,11296"; a="34922417"
X-IronPort-AV: E=Sophos;i="6.12,265,1728975600"; 
   d="scan'208";a="34922417"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2024 21:53:20 -0800
X-CSE-ConnectionGUID: MD3SZwsGQVGQD6bzIGhv6w==
X-CSE-MsgGUID: UwoHw776TmSwRjPWq2/QLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="130830232"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa001.fm.intel.com with ESMTP; 25 Dec 2024 21:53:18 -0800
Date: Mon, 13 Mar 2023 02:03:10 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Yidong Zhang <yidong.zhang@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
	mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
	lizhi.hou@amd.com, DMG Karthik <Karthik.DMG@amd.com>,
	Nishad Saraf <nishads@amd.com>,
	Prapul Krishnamurthy <prapulk@amd.com>
Subject: Re: [PATCH V1 1/3] drivers/fpga/amd: Add new driver for AMD Versal
 PCIe card
Message-ID: <ZA4T3rawY7rEIhxp@yilunxu-OptiPlex-7050>
References: <20241007220128.3023169-1-yidong.zhang@amd.com>
 <ZxH9Xjd0eU/7IDGC@yilunxu-OptiPlex-7050>
 <56421e2e-062c-407b-b731-0c1d585a1277@amd.com>
 <Zzw5MOb6dUD6BLYh@yilunxu-OptiPlex-7050>
 <f9abc70d-2d07-4506-a227-af297eb77058@amd.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9abc70d-2d07-4506-a227-af297eb77058@amd.com>

On Sun, Dec 22, 2024 at 05:53:30PM -0800, Yidong Zhang wrote:
> 
> 
> On 11/18/24 23:07, Xu Yilun wrote:
> > 
> > > > > +obj-$(CONFIG_AMD_VERSAL_MGMT)                        += amd-vmgmt.o
> > > > IMHO the naming vmgmt is hard to understand, any better idea?
> > > The "v" stand for Versal. We would change to amd-vpci for Versal based pcie
> > "v" + "pci" is quite a misleading term, maybe just versal-pci?
> 
> Hi Yilun,
> 
> I sent the V2 patch and refactored the driver as versal-pci now.
> One more thing that I kept in V2 was the firmware_upload. I forgot to
> mention that I'd love to switch to the newly proposed interface once
> it is ready. I saw the proposal was now as config_fs and it was not merged

Good to know that.

I didn't start reviewing the v2 yet. But one thing is that now the
versal-pci FPGA manager has no user because of the ongoing uAPI, so
cannot be merged, and I won't pay much effort on this series for now.

Thanks,
Yilun

> yet.
> 
> Happy Holidays.
> 
> Thanks,
> David


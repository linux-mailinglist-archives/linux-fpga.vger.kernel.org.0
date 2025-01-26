Return-Path: <linux-fpga+bounces-1006-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C941A1C729
	for <lists+linux-fpga@lfdr.de>; Sun, 26 Jan 2025 10:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 553F518882C1
	for <lists+linux-fpga@lfdr.de>; Sun, 26 Jan 2025 09:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382CB171D2;
	Sun, 26 Jan 2025 09:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tk0dvErw"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423F625A64F;
	Sun, 26 Jan 2025 09:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737883691; cv=none; b=Djc9AkO53Nb7TFYmV2+Lf8fkKNqPGbbAubxP5z3nfYwU1euvIidoWfYUMPnAJDo2cnDM17ksNTzUpij6RlPCYRf1svsl27gX0KOG5JCrY0+8zMcuUit16UvrUstbP+5x3EJO7UiKHSXiJ6EHbOkcxI6fktncbcq44nF7/5DCYeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737883691; c=relaxed/simple;
	bh=QAtwq+gbugYFyBZMDmCnbI0JxPss39A3WmLmQyCwNn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FcbjDxASjYmxdyplS8DVx7KpiuT8H7zs9GhmmMI1DuMcfJjh3VnbvKwq2dP0IiiLviWZmbuhlC6jsRIXRWxDVYrSWLCZebvrBhvJusfVEP6Y0fP4olkgKn8Pn2rBCsoIm1RWMIlwhRTzbWPZm9l/QSNRZAXLplaRPLzm7JO8Xoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tk0dvErw; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737883689; x=1769419689;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QAtwq+gbugYFyBZMDmCnbI0JxPss39A3WmLmQyCwNn0=;
  b=Tk0dvErwaUX7AV9YAm55rJu/g9lnRT7KuXwHrZAP6HUWe0AeSgZfoIp3
   dIr6QbavMUOGKIOoihu9E8NZLcCDP/EJHxbdciA7c/gxTEeLXHK3oqyGw
   gO/9katDunAaikStrK1BAA3tNeek3pcs8wdr9D226tbcYjLToNaTMtB6F
   exALq6bfiiW2YzQZ5HIDl2pwyxffgCEPBx2iIuoApqgu6VpgOwG85hAnl
   bt/IqwKZ6qvZuDt0laqP8LGAW+jRk8DQRa70iF3T82NfJZYMWj1z8YWrf
   suPI6ZYIL/7jLZMHQ7N0SdswGKVlW25uGmaJR1yS2tK+yOuy/nUdI3Nkg
   w==;
X-CSE-ConnectionGUID: MovO1NHhSXuHObXm36s1Cg==
X-CSE-MsgGUID: SyJVaS5aTCGgBy9wRy7HRw==
X-IronPort-AV: E=McAfee;i="6700,10204,11326"; a="25966033"
X-IronPort-AV: E=Sophos;i="6.13,236,1732608000"; 
   d="scan'208";a="25966033"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2025 01:28:08 -0800
X-CSE-ConnectionGUID: aqzvXQr9T16JN1HCTuR1FA==
X-CSE-MsgGUID: /WX5DNVFTBegWRG+GWcBSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,236,1732608000"; 
   d="scan'208";a="108053640"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa007.fm.intel.com with ESMTP; 26 Jan 2025 01:28:07 -0800
Date: Sun, 26 Jan 2025 17:27:45 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Yidong Zhang <yidong.zhang@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
	mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
	lizhi.hou@amd.com
Subject: Re: [PATCH V2 0/4] Add versal-pci driver
Message-ID: <Z5YAEXtUWgB82JD3@yilunxu-OptiPlex-7050>
References: <20241210183734.30803-1-yidong.zhang@amd.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210183734.30803-1-yidong.zhang@amd.com>

On Tue, Dec 10, 2024 at 10:37:29AM -0800, Yidong Zhang wrote:
> This patchset introduces a new Linux Kernel Driver, versal-pci for AMD
> Alevo Versal based PCIe Card. The driver is based on Linux fpga driver
> framework.
> 
> The AMD Alevo Versal based PCIe Card, including V70, is the first Alevo
> production card leveraging AMD XDNA architecture with AI Engines. It is
> designed for AI inference efficiency and is tuned for video analytics and
> natural language processing applications [1].
> 
> This versal-pci driver provides services, including:
>   - leveraging linux firmware and FPGA framework to download management
>     firmware
>   - program additional bit-streams for AMD Xilinx specific hardware
>   - communicate with PCIe user function
>   - communicate with firmware running on the PCIe Card
>   - monitor device health
> 
> The driver is licensed under GPL-2.0.
> 
> The firmware and bit-streams are distributed as a closed binary, delivered
> by AMD. Please see [1] for more information.
> 
> [1] https://www.amd.com/en/products/accelerators/alveo/v70.html
> 
> Refactor driver to address all comments from v1.
> Changes since v1:
> - Add driver architecture description.
> - Change the driver name to versal-pci 
> - Remove unnecessary memcpy in versal-pci-comm-chan.c
> - Keep mod_timer because we need single_threaded_queue with delayed_work.
> - Change the "comms" to "comm_chan".
> - Remove regmap, use base+offset directly.
> - Add skeleton ops with on implementation (TODO) for fpga_manager in early
>   patch (0001) and add implementation in later patch(0004).
> - Remove br_ops and FPGA region, no need.

I never said FPGA region is no need. FPGA region is the essential for
managing the reprogramming and re-enumeration.

Thanks,
Yilun


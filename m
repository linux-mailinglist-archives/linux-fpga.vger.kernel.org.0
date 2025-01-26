Return-Path: <linux-fpga+bounces-1010-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7799EA1C762
	for <lists+linux-fpga@lfdr.de>; Sun, 26 Jan 2025 11:33:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5FC03A5B61
	for <lists+linux-fpga@lfdr.de>; Sun, 26 Jan 2025 10:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3724825A64B;
	Sun, 26 Jan 2025 10:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E5jI5EAg"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBBA25A63B;
	Sun, 26 Jan 2025 10:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737887605; cv=none; b=FT6l9ix5VVefGpfS+v3fPyJ5bcxZ3qli4slpQVw3zzKQGhp2kyMX5uYcK1yf9F+bfznFsJdMosiOynSKCFK0Urgnqsr+K6lcIZey2ISn8NlI/dWlAULJOap7n+kaNQlAPQkOVT3+LV5zSHjqfHJg19lfReumsioDtPjUx/Yv4aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737887605; c=relaxed/simple;
	bh=tpS/nlUb1y6UUTAci5KJFgE8mYcgREi76uPa4Xqx01g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kAjrhJRPqQXUcMYXsFFGu1OD8bJXa9OleUQ2orb2kDoLGuQqw0RwcVjP4avvCmu+smx9mkfe0oNCbMcyLAcCw2mPM3M1TeN9EQZSEBeA3Un7Q2G/uwV/+1SKv94XF5oAwEHSUQ9cUlIC37Lwe32PHBHn/x58KllTwOH41TuAqDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E5jI5EAg; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737887603; x=1769423603;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tpS/nlUb1y6UUTAci5KJFgE8mYcgREi76uPa4Xqx01g=;
  b=E5jI5EAgBsadFVkBg9X9SeQOpxq+PI0BHyVyCgIZDApuKyoEJ+Z4alcq
   bA6/kniV5hYVyglNP+g+LzcUv9zDQjKP1LrfpeRKCF18N1vAqUBXPopG+
   htPEUzqjVCTuiXJTepzw4mYl0gMHZLqECamTk12yV2oKevbk5sy+6qKG8
   ktXTRkfix+nt9ZPyGvIeXyJt7PjYIByXxz6DUYQmoa9iv2128OlrIxmmV
   Dwc8aYfsYmytTKYidvbYXArlMAM5O95I3PJnNgdAvHhFcNA9tM68ZC/MF
   PAXrAY6d0d3v5aFK2vYtNRv5RrUwth5lEaPJbNHOMzkekUOdGi1qp92j/
   g==;
X-CSE-ConnectionGUID: 0dKoaK8oR064e2z+/xLuzQ==
X-CSE-MsgGUID: CS7j7b6aTTq4hZ10M9lgLw==
X-IronPort-AV: E=McAfee;i="6700,10204,11326"; a="42300587"
X-IronPort-AV: E=Sophos;i="6.13,236,1732608000"; 
   d="scan'208";a="42300587"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2025 02:33:22 -0800
X-CSE-ConnectionGUID: VIE4CYvnSw+d89hnQiPv2g==
X-CSE-MsgGUID: k4p7cbHBQua/60abedfiWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,236,1732608000"; 
   d="scan'208";a="107967454"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa006.fm.intel.com with ESMTP; 26 Jan 2025 02:33:18 -0800
Date: Sun, 26 Jan 2025 18:32:56 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Yidong Zhang <yidong.zhang@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
	mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
	lizhi.hou@amd.com, DMG Karthik <Karthik.DMG@amd.com>,
	Nishad Saraf <nishads@amd.com>,
	Prapul Krishnamurthy <prapulk@amd.com>,
	Hayden Laccabue <hayden.laccabue@amd.com>
Subject: Re: [PATCH V2 1/4] drivers/fpga/amd: Add new driver amd versal-pci
Message-ID: <Z5YPWHVmL29zuQNm@yilunxu-OptiPlex-7050>
References: <20241210183734.30803-1-yidong.zhang@amd.com>
 <20241210183734.30803-2-yidong.zhang@amd.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210183734.30803-2-yidong.zhang@amd.com>

On Tue, Dec 10, 2024 at 10:37:30AM -0800, Yidong Zhang wrote:
> AMD Versal based PCIe card, including V70, is designed for AI inference
> efficiency and is tuned for video analytics and natural language processing
> applications.
> 
> The driver architecture:
> 
>   +---------+  Communication +---------+  Remote  +-----+------+
>   |         |  Channel       |         |  Queue   |     |      |
>   | User PF | <============> | Mgmt PF | <=======>| FW  | FPGA |
>   +---------+                +---------+          +-----+------+
>     PL Data                    base FW
>                                APU FW
>                                PL Data (copy)
>  - PL (FPGA Program Logic)
>  - FW (Firmware)
> 
> There are 2 separate drivers from the original XRT[1] design.
>  - UserPF driver
>  - MgmtPF driver
> 
> The new AMD versal-pci driver will replace the MgmtPF driver for Versal
> PCIe card.
> 
> The XRT[1] is already open-sourced. It includes solution of runtime for
> many different type of PCIe Based cards. It also provides utilities for
> managing and programming the devices.
> 
> The AMD versal-pci stands for AMD Versal brand PCIe device management
> driver. This driver provides the following functionalities:
> 
>    - module and PCI device initialization
>      this driver will attach to specific device id of V70 card;
>      the driver will initialize itself based on bar resources for
>      - communication channel:
>        a hardware message service between mgmt PF and user PF
>      - remote queue:
>        a hardware queue based ring buffer service between mgmt PF and PCIe
>        hardware firmware for programming FPGA Program Logic, loading
>        firmware and checking card healthy status.
> 
>    - programming FW
>      - The base FW is downloaded onto the flash of the card.
>      - The APU FW is downloaded once after a POR (power on reset).
>      - Reloading the MgmtPF driver will not change any existing hardware.
> 
>    - programming FPGA hardware binaries - PL Data
>     - using fpga framework ops to support re-programing FPGA
>     - the re-programming request will be initiated from the existing UserPF
>       driver only, and the MgmtPF driver load the matched PL Data after
>       receiving request from the communication channel. The matching PL

I think this is not the way the FPGA generic framework should do. A FPGA
region user (your userPF driver) should not also be the reprogram requester.
The user driver cannot deal with the unexpected HW change if it happens.
Maybe after reprogramming, the user driver cannot match the device
anymore, and if user driver is still working on it, crash.

The expected behavior is, the FPGA region removes user devices (thus
detaches user drivers), does reprogramming, re-enumerates/rescans and
matches new devices with new drivers. And I think that's what Nava is
working on.

BTW, AFAICS the expected flow is easier to implement for of-fpga-region,
but harder for PCI devices. But I think that's the right direction and
should try to work it out.

Thanks,
Yilun


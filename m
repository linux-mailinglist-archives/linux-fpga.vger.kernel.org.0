Return-Path: <linux-fpga+bounces-587-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F35293FA24
	for <lists+linux-fpga@lfdr.de>; Mon, 29 Jul 2024 17:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74C8F1C21F57
	for <lists+linux-fpga@lfdr.de>; Mon, 29 Jul 2024 15:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACED215AAC8;
	Mon, 29 Jul 2024 15:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n6SPavpH"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BC81E4A2;
	Mon, 29 Jul 2024 15:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722268737; cv=none; b=W1uNxt5PSsmpKpWCwvV8/wfxhG0NxEKjCbVqarGzV20XCGUEzXnBLKio44sb1hp8rgF8rL1WQHf0A3WXlICoY1r1vTk3pOiKCV1djzUasH14tPPLtvxS8M3lz4VoE15ras5XybgwVWrvBs6WWa/ww2aRzqrggjHzgTZ2Ra8v0gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722268737; c=relaxed/simple;
	bh=Qd0V6uEEt+MlDRsvthQTsw9ALbu+/sxmMXHbNxvXJ/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BTOC7q3D7reu8t/GjdhWffCah0/8GpXcx52EwpaEYb3KPFLI0VVhBWRUA7MucznA3/q1xJNaWF8j5koCW560sP5mnJ6Q1Iv95xgmqngb+SSe00TPYQ/UUG2XMR8GUww4gULMK02AMdR25F6K471gJoAWXGTVMaUQd9D7XnHz6Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n6SPavpH; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722268736; x=1753804736;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Qd0V6uEEt+MlDRsvthQTsw9ALbu+/sxmMXHbNxvXJ/w=;
  b=n6SPavpH/oy6h/1CPH1F/6rtAOWgViH2UvEpVnSLw7rXkfOLowkWLDon
   WqRmPHYEj0+33r+1XE36QKdp7qjrt/dW5ISfKw2WRzGjpApq4GncPu06N
   7wQDgRiktmZcfYwVifl1UjC0nKtH3LdEV7iPvyd75LzG+4QLn57y/ks6I
   vkt770DUtjaRhI4qcA21wOJA5UDnxDQdGBPGR9k4MX4Fv3mZI3IVFlpxX
   dO9gg7RKAa3jKYXXJs0kPY8Q689o+PBOcbFyHrZTNPWZ6AL83WSg3Re8B
   rHSwh4jm6pXqv6qO3K/Zl252xbVjsqwPrH7zzll30tiQef1nIc+pgYtV5
   g==;
X-CSE-ConnectionGUID: DUBwiyIjR9ynltNTUv0+rA==
X-CSE-MsgGUID: qvkf3rWIQ064eP5M0QdDXg==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="37540542"
X-IronPort-AV: E=Sophos;i="6.09,246,1716274800"; 
   d="scan'208";a="37540542"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 08:58:54 -0700
X-CSE-ConnectionGUID: pSsxZAZEThecrcnpbL95hw==
X-CSE-MsgGUID: IZWRdteTTdeHpd+qkQmgeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,246,1716274800"; 
   d="scan'208";a="59109505"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa004.jf.intel.com with ESMTP; 29 Jul 2024 08:58:51 -0700
Date: Mon, 29 Jul 2024 23:56:58 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Nava kishore Manne <nava.kishore.manne@amd.com>
Cc: git@amd.com, mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
	trix@redhat.com, robh@kernel.org, saravanak@google.com,
	linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [RFC 1/1] of-fpga-region: Add sysfs interface support for FPGA
 configuration
Message-ID: <Zqe7yoAMIJ+Qv8YC@yilunxu-OptiPlex-7050>
References: <20240726063819.2274324-1-nava.kishore.manne@amd.com>
 <20240726063819.2274324-2-nava.kishore.manne@amd.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726063819.2274324-2-nava.kishore.manne@amd.com>

On Fri, Jul 26, 2024 at 12:08:19PM +0530, Nava kishore Manne wrote:
> Adds sysfs interface as part of the of-fpga-region. This newly added
> sysfs interface uses Device Tree Overlay (DTO) files to configure/reprogram
> an FPGA while an operating system is running.This solution will not change
> the existing sequence When a DT overlay that targets an FPGA Region is
> applied.
> 	- Disable appropriate FPGA bridges.
> 	- Program the FPGA using the FPGA manager.
> 	- Enable the FPGA bridges.
> 	- The Device Tree overlay is accepted into the live tree.
> 	- Child devices are populated.
> 
> When the overlay is removed, the child nodes will be removed, and the FPGA
> Region will disable the bridges.
> 
> Usage:
> To configure/reprogram an FPGA region:
> echo "fpga.dtbo" > /sys/class/fpga_region/<region>/device/load

IIRC, last time we are considering some generic interface for both OF &
non-OF FPGA region, but this is still OF specific.

Thanks,
Yilun


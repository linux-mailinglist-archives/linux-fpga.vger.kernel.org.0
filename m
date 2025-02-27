Return-Path: <linux-fpga+bounces-1066-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5A6A482D2
	for <lists+linux-fpga@lfdr.de>; Thu, 27 Feb 2025 16:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34F3D3A7FFD
	for <lists+linux-fpga@lfdr.de>; Thu, 27 Feb 2025 15:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C5D26B090;
	Thu, 27 Feb 2025 15:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fQQnLoZm"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A3225E473;
	Thu, 27 Feb 2025 15:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740669838; cv=none; b=fed1eIewVVscYpyj3LZ59FPXJ2ZgqbXBfe5Q7d4Yimc05hd2+vfcvxzcvk+3wQ4i0VsCPcMsHR915wu4izpYYmBonXOz+qoWf1pdsNIIKgvRmj7HGrNjf7330mUfuGh2k3KGASYpK1P4mE0ZIiYKvWpJqvHj+eREIPNf3bKLIDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740669838; c=relaxed/simple;
	bh=hEZgWF5jcuzJTlTXwHCEelOsenWw00az0sbOKJzuIjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d0B85kIzQAcTyIBO2kpKh1fV+qujcOy7I6SS2OH5wuWS+IYOtBg2zwQHzrcmuxfBDHelQ/thRy7Rklxp251zcChnwsGnFGfqI0fPqD4R8bliGDb7umzNkdjmf5PYFtOGpC/sI3TirVwIs1hOK+65OBvvGRQVWO5sakV+1l0a5bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fQQnLoZm; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740669837; x=1772205837;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=hEZgWF5jcuzJTlTXwHCEelOsenWw00az0sbOKJzuIjs=;
  b=fQQnLoZmKdaNfp3Ex90awzrYz1/XY9fjtuNzgBIJ1xB/PQSOHtdexhv+
   FdPMfdC2MS5HRmLTizaaHWtGoonrZ3twRBboGr5vMf2HiyTzQXDYiNhd4
   rbd6UASrbgpwS9JE9gaLJ/MwF0sXD/XoBI9hFsf+2Oj/arxjfmHitK606
   scIthbG4P2leXgpJMgDdOn7i3bVzLgOxNb0tgt3sEfYO8LQ4FRBZjVV96
   dOi1hmJ+7H6AFHERN/bFU2pRm8aAA9WiT+EIJafktn7FseKSmi4ixYFhd
   M2jQLAR/dX1SAd6l77map2WJS+y9gicXdW5Swi4qkbBCYp3nJ/ctXt9Fd
   Q==;
X-CSE-ConnectionGUID: csLU+rl1TSOLlAwVrDpKhw==
X-CSE-MsgGUID: hnN20fSdS2G2zceZtg8X4g==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="40742561"
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="40742561"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 07:23:57 -0800
X-CSE-ConnectionGUID: lz52O0lzRYyBZ25jMHRwTQ==
X-CSE-MsgGUID: dkDwAZhSRGq/oPn17OU6/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117568615"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 07:23:52 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tnfjo-0000000FdE8-2tBf;
	Thu, 27 Feb 2025 17:23:48 +0200
Date: Thu, 27 Feb 2025 17:23:48 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Richard Cochran <richardcochran@gmail.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	Arnd Bergmann <arnd@arndb.de>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Tianfei Zhang <tianfei.zhang@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Calvin Owens <calvin@wbinvd.org>,
	Philipp Stanner <pstanner@redhat.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: Re: [PATCH] RFC: ptp: add comment about register access race
Message-ID: <Z8CDhIN5vhcSm1ge@smile.fi.intel.com>
References: <20250227141749.3767032-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250227141749.3767032-1-arnd@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 27, 2025 at 03:17:27PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> While reviewing a patch to the ioread64_hi_lo() helpers, I noticed
> that there are several PTP drivers that use multiple register reads
> to access a 64-bit hardware register in a racy way.
> 
> There are usually safe ways of doing this, but at least these four
> drivers do that.  A third register read obviously makes the hardware
> access 50% slower. If the low word counds nanoseconds and a single
> register read takes on the order of 1µs, the resulting value is
> wrong in one of 4 million cases, which is pretty rare but common
> enough that it would be observed in practice.

...

> Sorry I hadn't sent this out as a proper patch so far. Any ideas
> what we should do here?

Actually this reminds me one of the discussion where it was some interesting
HW design that latches the value on the first read of _low_ part (IIRC), but
I might be mistaken with the details.

That said, it's from HW to HW, it might be race-less in some cases.

-- 
With Best Regards,
Andy Shevchenko




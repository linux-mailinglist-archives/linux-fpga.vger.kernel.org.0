Return-Path: <linux-fpga+bounces-1082-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A216A4B88A
	for <lists+linux-fpga@lfdr.de>; Mon,  3 Mar 2025 08:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE1B93AFE20
	for <lists+linux-fpga@lfdr.de>; Mon,  3 Mar 2025 07:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764D61EB1B0;
	Mon,  3 Mar 2025 07:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J1HPdinK"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA561EE03D;
	Mon,  3 Mar 2025 07:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740988211; cv=none; b=IQCPhjwz0kTcfBvoFS1hpOpl5Whi8VJo4kgLfEhmsT7MnpDbs7GNkATOI2l9r0e4zvXmbJXXDARu2L0ynFb8YVyBrU7InhDMb0r6HelWHAU4qz3im0J/wAADYGzJu9uWe9cueNGaWd9/JB+8CPpG8tL3qeAPZ65qHF7g+BwWJ0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740988211; c=relaxed/simple;
	bh=4aoAkVkWJ9rE1k/obWZXGikyJB41caL0MMe9Y2MIi4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VBtNB85Sw4WHQCCFloQtUBFZwUduLThz4/f8j2OGTLnprvV1lfZZYPYrBWyfOdlmhdAnKoe//R0Nh0uJJY9/XtFdDzhyWrXPl+MaoN7V8yaoFc+xPt6ZgNJKxmmJNpvwdeLxST/Z2FPAiZILqmzhCt7VsulGKldayMrST91EcWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J1HPdinK; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740988210; x=1772524210;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=4aoAkVkWJ9rE1k/obWZXGikyJB41caL0MMe9Y2MIi4Q=;
  b=J1HPdinK/KHhwgQv/bWmTAhKcU/J6BvYcJoHelipf0r3WU49WMITlKHJ
   FdWx1Vxm27zOYt8/7WFW3kE35CIjvAx/f2TYK5uGFBebI2Ow/Vbr38YFe
   IgQy6sSqVYqGbQru/lInxN2PdqscsrlonqOAo39mepYr8FlliEhxkbmaO
   G3lmxGw5CAebtk0fv8mfzGI+58cgvvVWLKH4eoIr6YEONXbq2zMHiODfN
   m0sfKih4ovJSMndfK9ORG1aj5XISwMWeBmgNrVlU5JsFyQVE2E6eWDs6f
   aczZIFCgYj7i0UUS+jEsPwjOnaGGSmaw0ETEI2DwuITULXkaAM/w2eaTv
   Q==;
X-CSE-ConnectionGUID: AXQRHB34QcOtqvi2QUpwsQ==
X-CSE-MsgGUID: FAG3B9gWRW6NFITqEzXHLw==
X-IronPort-AV: E=McAfee;i="6700,10204,11361"; a="41974308"
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; 
   d="scan'208";a="41974308"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2025 23:50:09 -0800
X-CSE-ConnectionGUID: r4EkK5uLTOOHRZNDHcCvsQ==
X-CSE-MsgGUID: oK5Me+PZRnKJQDwsK0W+pA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; 
   d="scan'208";a="117733442"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2025 23:50:04 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tp0Yr-0000000GkI5-1VwS;
	Mon, 03 Mar 2025 09:50:01 +0200
Date: Mon, 3 Mar 2025 09:50:01 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Richard Cochran <richardcochran@gmail.com>
Cc: Arnd Bergmann <arnd@kernel.org>,
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
Message-ID: <Z8VfKYMGEKhvluJV@smile.fi.intel.com>
References: <20250227141749.3767032-1-arnd@kernel.org>
 <Z8CDhIN5vhcSm1ge@smile.fi.intel.com>
 <Z8TFrPv1oajA3H4V@hoboy.vegasvil.org>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z8TFrPv1oajA3H4V@hoboy.vegasvil.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, Mar 02, 2025 at 12:55:08PM -0800, Richard Cochran wrote:
> On Thu, Feb 27, 2025 at 05:23:48PM +0200, Andy Shevchenko wrote:
> > On Thu, Feb 27, 2025 at 03:17:27PM +0100, Arnd Bergmann wrote:
> > > From: Arnd Bergmann <arnd@arndb.de>
> > > 
> > > While reviewing a patch to the ioread64_hi_lo() helpers, I noticed
> > > that there are several PTP drivers that use multiple register reads
> > > to access a 64-bit hardware register in a racy way.
> > > 
> > > There are usually safe ways of doing this, but at least these four
> > > drivers do that.  A third register read obviously makes the hardware
> > > access 50% slower. If the low word counds nanoseconds and a single
> > > register read takes on the order of 1µs, the resulting value is
> > > wrong in one of 4 million cases, which is pretty rare but common
> > > enough that it would be observed in practice.
> 
> If the hardware does NOT latch the registers together, then the driver must do:
> 
>   1. hi1 = read hi
>   2. low = read lo
>   3. hi2 = read h1
>   4. if (hi2 == hi1 return (hi1 << 32) | low;
>   5. goto step 1.
> 
> This for correctness, and correctness > performance.

Right.

> > > Sorry I hadn't sent this out as a proper patch so far. Any ideas
> > > what we should do here?
> 
> Need to have driver authors check the data sheet because ...
> 
> > Actually this reminds me one of the discussion where it was some interesting
> > HW design that latches the value on the first read of _low_ part (IIRC), but
> > I might be mistaken with the details.
> > 
> > That said, it's from HW to HW, it might be race-less in some cases.
> 
> ... of this.

Perhaps it's still good to have a comment, but rephrase it that the code is
questionable depending on the HW behaviour that needs to be checked.

-- 
With Best Regards,
Andy Shevchenko




Return-Path: <linux-fpga+bounces-1277-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71193AFBCC3
	for <lists+linux-fpga@lfdr.de>; Mon,  7 Jul 2025 22:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40F5D1BC1FD6
	for <lists+linux-fpga@lfdr.de>; Mon,  7 Jul 2025 20:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CCF41F4CB2;
	Mon,  7 Jul 2025 20:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jF2cfUVe"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BD1137C2A;
	Mon,  7 Jul 2025 20:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751921198; cv=none; b=pQjU6z9C8ewsQWYfd+2iBmF21OnBs4XhAL0DP/BYhl9+FMY3XRosgqIZ03HQS5FN9cbhW8yevjEthYaKVU72YZMQRlj9XAYouKLlUnC0cnjd06FOtYWId7QA7S58RaX0g49qRgfIMz0s/XKEkCnioBiSgouP8vrlyRLWDok5P3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751921198; c=relaxed/simple;
	bh=6EcPz9fwbDqKNkVzNDDrhgoBLsTF1NAAEiAdfSrej1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iNTpQOyI2Z/rCtDFI226qfq5T08DhjdtOs1mF2lb3zkMlQqsDPLnaxoj1fePeMSEbFd1zBdUvbceqH3subQdGlJIiVqzDKImV1KJ8DMfkhlw9N+Bl2z6P4UYtdUlp1F6k/yK9QctSr0xaS9NEkh7dpACH/vuLh+bnhdwYmOlSN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jF2cfUVe; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751921197; x=1783457197;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6EcPz9fwbDqKNkVzNDDrhgoBLsTF1NAAEiAdfSrej1w=;
  b=jF2cfUVeOOqoKrb9WQ/ahf+bEqxC2XIZgLUjUf4OI7YobOdvJMjPZBdL
   PoCwexSpxMy2ElwIhRnHYwpiSaQf/Xvxmj4MT0MhMg6/I2lFluJT0fjpW
   9XKSMSxcsG/rm4dzs+uG44bEFTRyktGW2fPOID9k/q44C0sibGhHJ32KN
   F870LdmQsGKB2wPM+1iXupDz4qJlidteW8zl1JdMFXdCotKXXRmiqyBzs
   9oC1rd7sgMWsiECIFqnlY++pVWcnfCAW7VqZ6oSvSvKd+OjiiOazqAZ0I
   s1DdX9kgxH/iM+GvXupunwBVRcx9LCzjNfyIa4p5tf5kGrgmUdfwp9TON
   g==;
X-CSE-ConnectionGUID: LcFEvhSATS+9YT3wm8Voxw==
X-CSE-MsgGUID: asPGwr4JR0aFN4I5yJhsEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="53270685"
X-IronPort-AV: E=Sophos;i="6.16,295,1744095600"; 
   d="scan'208";a="53270685"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 13:46:36 -0700
X-CSE-ConnectionGUID: NJ0vmgAkQfCOMOAQ3ixETw==
X-CSE-MsgGUID: +vOzX2DRQN+4vl6xlbNLBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,295,1744095600"; 
   d="scan'208";a="155408768"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 13:46:34 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uYsjP-0000000DOVM-1jvQ;
	Mon, 07 Jul 2025 23:46:31 +0300
Date: Mon, 7 Jul 2025 23:46:31 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Xu Yilun <yilun.xu@intel.com>, linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
	Tom Rix <trix@redhat.com>
Subject: Re: [PATCH v2 1/1] fpga: altera-cvp: Use pci_find_vsec_capability()
 when probing FPGA device
Message-ID: <aGwyJxTdP31vibkf@smile.fi.intel.com>
References: <20250627112635.789872-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250627112635.789872-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jun 27, 2025 at 02:26:22PM +0300, Andy Shevchenko wrote:
> Currently altera_cvp_probe() open-codes pci_find_vsec_capability().
> Refactor the former to use the latter. No functional change intended.

Any comments, please?
Can it be applied now?

-- 
With Best Regards,
Andy Shevchenko




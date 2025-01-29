Return-Path: <linux-fpga+bounces-1022-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E7CA21904
	for <lists+linux-fpga@lfdr.de>; Wed, 29 Jan 2025 09:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 322443A4397
	for <lists+linux-fpga@lfdr.de>; Wed, 29 Jan 2025 08:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCED919CD1D;
	Wed, 29 Jan 2025 08:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="To/7BzIv"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB06619C561;
	Wed, 29 Jan 2025 08:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738139279; cv=none; b=I1yG8fGkdGXMizTXZEQ6++OtX5wxqcll+Mt5InlruJfzM5TJjmizZN52oQxAkDg/jXJqJzOycLhs2IWgJz/Or+ZsOFNdNmQVVrcpbc/QZQfK8+QF3Iezelc6gbRvz31V0IK2TryUpKeNAtD7LbkA2+9SLsRBIsZrwDn5ffCVeDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738139279; c=relaxed/simple;
	bh=/X29OiCWGmDz6z8wOFd0y497f3tCiDOd3ggTrOOjvnc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r4iTLjuwtCAF0Ju8JAUA2QemWa31iSbuGPhiywykqD3ipbTM8JhzVfkZhd7w7dk5zWkUUgKh/g6WN4sfJPfZ+kW5stN6IoMZR2rV+HYXbTRQ0L5eRgjelffY+nEfaq+XnqrNy42AAE/L/8W2WvIo7kNOmKSP9yFn1Z4sB14CrCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=To/7BzIv; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738139278; x=1769675278;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/X29OiCWGmDz6z8wOFd0y497f3tCiDOd3ggTrOOjvnc=;
  b=To/7BzIvFO5a7HsniplsnbcDJ0GZOUOPGYduojlOSBYl5LaaKxeutPqX
   fsX7JF1z+jYDHiSYtcWh5ltup4QVoPJcIiWh72pn9Sp4bh5EYCQuys4CD
   I5Nkib+oKtzyP8AwTzBU1z38gtqI9GZhnqrz893irXFYGYo/z67yXJ4RU
   Si4HYKgh7vBjqVyeATu5pc27yFVrU+dMEDvN4zMoaFgP/HorxRKLsRZf0
   YPWyqGoT7JlDmD45MSAJiu4mFo/TlYUi3fb0vJBv3VUWUYBdJJCNG3TTr
   rU3dSO6kqXpE8ZwpZpDOuiZX1H+zU/+BABw5QOiOfOGCBilQFseCrexhR
   Q==;
X-CSE-ConnectionGUID: l8p+FdWeSFK1cg13++VCLA==
X-CSE-MsgGUID: r87x9SyhQcikIC9qtGC1fA==
X-IronPort-AV: E=McAfee;i="6700,10204,11329"; a="38546260"
X-IronPort-AV: E=Sophos;i="6.13,242,1732608000"; 
   d="scan'208";a="38546260"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2025 00:27:57 -0800
X-CSE-ConnectionGUID: V/LvVmCJTemQC6osFYg0uQ==
X-CSE-MsgGUID: m8gf/rTBQkWjXWgNbF0+vQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,242,1732608000"; 
   d="scan'208";a="113961390"
Received: from apgcp0c531115.png.altera.com ([10.244.76.209])
  by fmviesa004.fm.intel.com with ESMTP; 29 Jan 2025 00:27:54 -0800
From: Mahesh Rao <mahesh.rao@intel.com>
To: krzysztof.kozlowski@linaro.org
Cc: conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	dinguyen@kernel.org,
	hao.wu@intel.com,
	krzk+dt@kernel.org,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mahesh.rao@altera.com,
	mahesh.rao@intel.com,
	mdf@kernel.org,
	robh@kernel.org,
	trix@redhat.com,
	yilun.xu@intel.com
Subject: Re: [PATCH 3/3] firmware: stratix10-svc: Add of_platform_default_populate()
Date: Wed, 29 Jan 2025 16:27:14 +0800
Message-Id: <20250129082714.22432-1-mahesh.rao@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <3819c34c-6ec3-400a-a02d-f89216b417c6@linaro.org>
References: <3819c34c-6ec3-400a-a02d-f89216b417c6@linaro.org>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Krzysztof,
Thanks for Reviewing the patch.

On Thu, 23 Jan 2025 08:26:08 +0100, Krzysztof Kozlowski wrote:
> > Add of_platform_default_populate() to stratix10-svc driver as the
> > firmware/svc node was moved out of soc.
> > This fixes the failed probing of child drivers of svc node.
> >
> > Fixes: 23c3ebed382a ("arm64: dts: socfpga: agilex: move firmware out
> > of soc node")
> >
> 
> 
> There is never a blank line between tags. Use: `git log`
> 
> > Signed-off-by: Mahesh Rao <mahesh.rao@intel.com>

Understood, I will revise this in the next revision.

> 
> > ---
> >  drivers/firmware/stratix10-svc.c | 14 +++++++++++---
> >  1 file changed, 11 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/firmware/stratix10-svc.c
> > b/drivers/firmware/stratix10-svc.c
> > index

> >  	platform_device_unregister(svc->stratix10_svc_rsu);
> >  err_free_kfifo:
> >  	kfifo_free(&controller->svc_fifo);
> 
> 
> You need to update remove() callback.
> 

Sure, I will add the changes in the next revision.

Best regards,
Mahesh Rao


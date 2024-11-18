Return-Path: <linux-fpga+bounces-935-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4299E9D135C
	for <lists+linux-fpga@lfdr.de>; Mon, 18 Nov 2024 15:42:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE5321F2196B
	for <lists+linux-fpga@lfdr.de>; Mon, 18 Nov 2024 14:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5A01AB52B;
	Mon, 18 Nov 2024 14:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YPpPt5o3"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14401A9B3D;
	Mon, 18 Nov 2024 14:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731940671; cv=none; b=jmxZyaQyGNnTP4ipkxZJxIBAhAxEoTAMtB3NIfgtiXZeXU/mx2ElUTd1iSpDPhGwp9hatUsotW40ulDd6cTfRn5shKRJ6eilb6yi4wxvWrQAMbQk104UpKnhQfsqOegLaRapqujZy7li/hrWLw5PI9BMauhQX80w73YS4dgHg50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731940671; c=relaxed/simple;
	bh=0Mff/cEL5+d6LJrnWwVGPQwG6oiEpcGHSPgksNwaS9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fmJ9PFypWu5aO5ujejp/BLYklkWQvALdP6abXr4Ua0mYLHctTCQ8grfOl1Lh5Hh9I4ET+LUWfRiHA+RfMCkIsRQ5Y0OeOWHVcjA+Cp8XVbgFfAAf5ib5xYrvsjiibXsyi8OmQLSNlfhNn/GZ0JOPR8g0tVgB12JfEYNCQFd8+Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YPpPt5o3; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731940670; x=1763476670;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0Mff/cEL5+d6LJrnWwVGPQwG6oiEpcGHSPgksNwaS9w=;
  b=YPpPt5o3QKy/JR/qvz5tPNl4EZ2+2eAK0lEP9qnGJLIuqNLPFJ/Ic9+h
   dsXu2fTRpvMVQXoQUa4J4TGDbk3lpPrFxCGc40e1+3esGnqYppsMZi4T9
   8+Gk6GXBCbTczVfFoJVNWpxzYXyBKWCsjhCBBK+qncdaKGdkXErgUNTrH
   jgoO3IdkBIZMgCQwf+Ikwd2wRDd1WFNvRFPySsXm+dmZmAS2yRmVI+fKA
   eRMddZfjux+RwRTwsrkfIOLJxtcoKwFA1gN0PcbunxKEl9gVPLghHMge7
   LAp4ZiUyiN2AnYjnWINOLB5KKHHir9oO1D5XR22ri70+P8rk0vlaawsVR
   g==;
X-CSE-ConnectionGUID: arzkTSjqSqaPgUXQlvDF2Q==
X-CSE-MsgGUID: 7ym56KJZR2a0BoUwvhMw0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11260"; a="49437058"
X-IronPort-AV: E=Sophos;i="6.12,164,1728975600"; 
   d="scan'208";a="49437058"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2024 06:37:49 -0800
X-CSE-ConnectionGUID: 1FPwQi4nT7qh75Xn6teAoA==
X-CSE-MsgGUID: e4HHHpm5TlK9mQwoZG0rwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,164,1728975600"; 
   d="scan'208";a="120099788"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa002.jf.intel.com with ESMTP; 18 Nov 2024 06:37:46 -0800
Date: Mon, 18 Nov 2024 22:34:54 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Peter Colberg <peter.colberg@intel.com>
Cc: Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
	Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
	Russ Weight <russ.weight@linux.dev>,
	Marco Pagani <marpagan@redhat.com>,
	Matthew Gerlach <matthew.gerlach@linux.intel.com>,
	Basheer Ahmed Muddebihal <basheer.ahmed.muddebihal@linux.intel.com>
Subject: Re: [PATCH v4 14/19] fpga: dfl: store platform device id in feature
 device data
Message-ID: <ZztQjpI4EtmagwyT@yilunxu-OptiPlex-7050>
References: <20241025223714.394533-1-peter.colberg@intel.com>
 <20241025223714.394533-15-peter.colberg@intel.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025223714.394533-15-peter.colberg@intel.com>

> @@ -1658,7 +1660,6 @@ void dfl_fpga_feature_devs_remove(struct dfl_fpga_cdev *cdev)
>  
>  		/* remove released ports */
>  		if (!device_is_registered(&port_dev->dev)) {
> -			dfl_id_free(fdata->type, port_dev->id);

Also remove the braces.

Thanks,
Yilun

>  			platform_device_put(port_dev);
>  		}


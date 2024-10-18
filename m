Return-Path: <linux-fpga+bounces-786-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 861D49A3543
	for <lists+linux-fpga@lfdr.de>; Fri, 18 Oct 2024 08:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 895941C23A5E
	for <lists+linux-fpga@lfdr.de>; Fri, 18 Oct 2024 06:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C49F17DFEB;
	Fri, 18 Oct 2024 06:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k4t0RoQM"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFB616F851;
	Fri, 18 Oct 2024 06:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729232568; cv=none; b=AzyEY6rj1jFfIOmzKe7L5hl0hZS2nXWZofQnyGuYqvSP56h/J1eOheJn1hhrczpVG8IIwOdzoWQc+w2XtQOLFtCgVQNTMSXhS3D0h3tqsiQaWLuAAvYs5r/bYsl6pjQuLrcdB0Dg9WwKcgfeqCsi+0bMtKebnJ7gRpsZykGFSw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729232568; c=relaxed/simple;
	bh=p5A4kN+o6fCIjb6vKc4doaZvxuIxQty9Vj5IgtKaAHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZaFnH5bu1FFfx/I5cMMzk6jcA+Q3MGEXfJHFFVbeqij/dJkLGeMfaS460Ac3cH39Pck0Zib/4a4IqAvzr7SuE0ICRXdRu3TlKZd9s2LSSFvgagW3qujDbDIMaCdIiFTo3oJC7hxG+HolFUHjt5KCoi7WXWdLxEISngjZc4PofS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k4t0RoQM; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729232567; x=1760768567;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=p5A4kN+o6fCIjb6vKc4doaZvxuIxQty9Vj5IgtKaAHc=;
  b=k4t0RoQMDMQP9NLXU6M0SvpVjL1urNetPX8GJ/jGKUQ1Hcd82Bxu7G+j
   hdH3tGMtMo5lAaOqJyVsMlTuK7biYfaqMalMUI2FhNEBz8cehecxmiybo
   D6SPQkBXhOxD6sEkb3x0LKn0tSx8Xlf1kvqiL7QHehJUTDwhcZHqguxL6
   sUX/Iqoug/jIZZRoACH3abUZtss+FV35PU5j4hBA6N81wTBU4xdfrJxS9
   jdI2O6X5QXbWO3/BohBR+nPKD41bPNYi7sMp2vnKrPXO/OvKIO8nZCoj7
   AtC8+FzLCm78JUXLbQXNXgVB+7V+fxT1G4FioJnmOTKCJmQD/0mWgIbYr
   w==;
X-CSE-ConnectionGUID: dkA01FLVTkS7wTK3M6pI0w==
X-CSE-MsgGUID: 6ZXhDUrKT7+IV/4+gLcJwg==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="54163708"
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="54163708"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 23:22:47 -0700
X-CSE-ConnectionGUID: uHhNH92PSDiH8yM13h6jWw==
X-CSE-MsgGUID: JW71ZBprRWKXrTWmUmc8yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="78813631"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa008.fm.intel.com with ESMTP; 17 Oct 2024 23:22:44 -0700
Date: Fri, 18 Oct 2024 14:19:23 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: David Zhang <yidong.zhang@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
	mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
	lizhi.hou@amd.com
Subject: Re: [PATCH V1 0/3] Add new driver for AMD Versal PCIe Card
Message-ID: <ZxH96/aRhMvS2Dgx@yilunxu-OptiPlex-7050>
References: <20241007215556.3023089-1-yidong.zhang@amd.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007215556.3023089-1-yidong.zhang@amd.com>

On Mon, Oct 07, 2024 at 02:55:53PM -0700, David Zhang wrote:
> From: Yidong Zhang <yidong.zhang@amd.com>
> 
> This patchset introduces a new Linux Kernel Driver, amd-vmgmt for AMD Alevo
> Versal based PCIe Card. The driver is based on Linux fpga driver framework.

Your patchset is not correctly threaded. Please use proper --cover-letter
argument.

Thanks,
Yilun


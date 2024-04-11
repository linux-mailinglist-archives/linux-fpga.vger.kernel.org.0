Return-Path: <linux-fpga+bounces-434-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E91498A0B97
	for <lists+linux-fpga@lfdr.de>; Thu, 11 Apr 2024 10:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 881711F212FE
	for <lists+linux-fpga@lfdr.de>; Thu, 11 Apr 2024 08:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9410613FD61;
	Thu, 11 Apr 2024 08:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wly2BFPL"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84F535F18
	for <linux-fpga@vger.kernel.org>; Thu, 11 Apr 2024 08:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712825294; cv=none; b=OHPWiFGfRnGQVqvChI5mb7Q3DBErY0qWs+ohGE81Y4qWIW85uywzJz/9HvGQqyGReC7Pk20eA/WL2eKFuFbKy6OV4y5IVHqN4u+E0hJZx5Lxz+jtTlRttIAXXd9fccrIl/FIXB/UzyXFl51isL5L1bs4wKaq2yUdFafnETmLA+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712825294; c=relaxed/simple;
	bh=EDAON+0zjlGNvHRUwu6VIDk4gpNv3gQNV2Tio1X/8HE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=stihW0J9nvSD/mEVcR/cB7y6AoGvWyzQKkP6uIp0QOB6V4DmjDqjICkN6wu+KVWxqJZdS7wfhHxejmIfS4JSj2cjT6wDdCNeHEwFv7L4L7NQSV01xZBZGONlshauptNIG9uTX/Xdd/xKkfBil3qyQDGU5gvpg006xmnML7sORrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wly2BFPL; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712825293; x=1744361293;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EDAON+0zjlGNvHRUwu6VIDk4gpNv3gQNV2Tio1X/8HE=;
  b=Wly2BFPLQU9mr5VUy6b0YAULbry3J0NKrMw3r3+pzzKJOaQB7Hckakgt
   7UmggBE8yJhE8HYx1ohhAWYt+isa/S8l6OhTf6mDnIeMteqkO0Pv5/YMK
   ZCdCSooXKMA7ettGqUrohw+dDkc4HGnh0KFQTpKCIuOnlf1cVA0DIS9KA
   4r3/I1TE/BiF3c4Gzn3BcukMBq4pDZy1Rgu5K3wOaWZrt17aYxbAH/Gzs
   scN2xckYYk73j/pqCqo7PsMCD0VQeXR4RtMv7O7B5hgM9NawcwuGDFJ3C
   /XnGsZAx8pGZkQTWEKxVvDCflVaMPan+t72goUP5iFsnHB+IfDMXMWEQx
   g==;
X-CSE-ConnectionGUID: tqbjBMxFQOOC6Cyb3cSQ5g==
X-CSE-MsgGUID: vTsMbId+RbaMbaTy+l9eRQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="8350557"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="8350557"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 01:48:12 -0700
X-CSE-ConnectionGUID: sxMcKS3aSCu+GKgObjOlkA==
X-CSE-MsgGUID: 8hkowe1iSRmqXc+mFy+iUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="20914901"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa008.fm.intel.com with ESMTP; 11 Apr 2024 01:48:11 -0700
Date: Thu, 11 Apr 2024 16:43:07 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: David Gideon <gideonda32@gmail.com>
Cc: linux-fpga@vger.kernel.org
Subject: Re: info->header_size always 0, breaks fpga-zynq.c driver
Message-ID: <Zheim/iQP31H1pMh@yilunxu-OptiPlex-7050>
References: <CAOLMD=xWnfEVEobNnE+ipMwi=x7wNA7ZfQo1+9CH8UyUVAffQA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLMD=xWnfEVEobNnE+ipMwi=x7wNA7ZfQo1+9CH8UyUVAffQA@mail.gmail.com>

On Thu, Apr 11, 2024 at 02:16:24PM +1000, David Gideon wrote:
> Hi Everyone,
> 
> Our Xilinx FPGA driver (zynq-fpga.c) is no longer compatible with
> fpga-mgr.c and barfs with:
> 
>       "Invalid bitstream, could not find a sync word. Bitstream must
> be a byte swapped .bin file"
> 
> It seems to come from here (inside fpga_mgr_write_init_buf()):
>       size_t header_size = info->header_size;
> 
> It uses header_size to decide whether or not to call
> fpga_mgr_write_init() with a NULL buffer and a 0 size, or use a real
> buffer and real size, like this:
> 
>     if (header_size > count)
>         ret = -EINVAL;
>     else if (!header_size)
>         ret = fpga_mgr_write_init(mgr, info, NULL, 0);
>     else
>         ret = fpga_mgr_write_init(mgr, info, buf, count);
> 
> The trouble is, that if I follow my code path, info->header_size isn't
> set by anyone.  So it's **ALWAYS** zero.  But the value **should** be

From your link below, I see info->header_size is set here:

@@ -404,6 +571,8 @@ static int fpga_mgr_firmware_load(struct fpga_manager *mgr,
  */
 int fpga_mgr_load(struct fpga_manager *mgr, struct fpga_image_info *info)
 {
+	info->header_size = mgr->mops->initial_header_size;
+
 	if (info->sgt)
 		return fpga_mgr_buf_load_sg(mgr, info, info->sgt);

Thanks,
Yilun

> 128:
> 
>     static const struct fpga_manager_ops zynq_fpga_ops = {
>          .initial_header_size = 128,
>         ...
>     };
> 
> The issue seems to have been introduced as part of commit 3cc624beba
> which I have linked to here:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/fpga/fpga-mgr.c?id=3cc624beba6310a8a534fb00841f22445a200d54
> 
> 
> What I find really interesting is that the original mailing list patch
> submission didn't have this bug, and would have worked for us:
> 
>     + if (info->header_size)
>         + header_size = info->header_size;
>     + else
>         + header_size = mgr->mops->initial_header_size;
> 
> Could this be a viable way to ensure that the FPGA manager driver is
> compatible with the zynq-fpga.c driver again?
> 
> 
> - DG
> 


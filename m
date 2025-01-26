Return-Path: <linux-fpga+bounces-1005-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED5DA1C727
	for <lists+linux-fpga@lfdr.de>; Sun, 26 Jan 2025 10:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40C7C1887C39
	for <lists+linux-fpga@lfdr.de>; Sun, 26 Jan 2025 09:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 309101CF8B;
	Sun, 26 Jan 2025 09:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hohscvff"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606CB25A64F;
	Sun, 26 Jan 2025 09:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737883484; cv=none; b=Js0+bANzxdE/xS30vDfLgBEOSwhIj5gx98fs488lWjod8ivaY0seWRspAgi+dRvQbs53NG6qXBkBldEqWxGdpPIEAbms6nMckbsjKCT4549+OVo5DwdtuNdzt+uTu2Gpj/qBuP8/BSDDw7LXOrucSl7ok/jg77kERxnlGUlW5G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737883484; c=relaxed/simple;
	bh=xK2S6nDQzWa8Zvdx4k1Xsubdp9fejadJDLBSnB28SQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nQDhLAx5COE6GJ9FNaaaZBcgriLJsnF+bTo7a1pVQjA9HYc3kO9xWox19dE/LOPXMPZGNUMvreboUyGHfrkHp2p6/x7ERNvs8YH3fWQbAv4dfuddB0uaSsPVXaYfxL1XRXBJrOHbx0/tlTfLT0zCMghCXNT0dCw54F4XgV+xZhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hohscvff; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737883482; x=1769419482;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xK2S6nDQzWa8Zvdx4k1Xsubdp9fejadJDLBSnB28SQE=;
  b=hohscvffEfazDiYFcplufZnygWVmsI/2/sy3tgOTG33CPEaAJXY4EF33
   PZs5e4Gm/Ju8ofP/2EY49hCQmjybYvPF4wyRuAKdce4Z8pm5bC5qkP1Lr
   nToAgYx72avhgmVIMZayA873//EpwRMYiaNxMAPFyvd+abstfWLC5/Ai7
   iZ8aW+KhwndGYuzvfBuGuEwupOCKg7QFVucjj0MsSirYZ7RunSPlxdjJU
   pT4cYJB7fQawmVfk6M4XMRa5lrnh047Ed0OLmSmixLq9cWKURTxeOMAzm
   eiqJS4+i7cBRJmKlExT9SXeFVZaUL7zT9UOtphuU/SPQl0ql61IPq1rWF
   A==;
X-CSE-ConnectionGUID: xJ/UTpBzRkKUgl/FJE2DvA==
X-CSE-MsgGUID: iAaB2v66QiSKdbKMANoUgg==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="38466982"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="38466982"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2025 01:24:41 -0800
X-CSE-ConnectionGUID: WUvmIMXdQuKFHwY8rU8Ylg==
X-CSE-MsgGUID: UVYP4haSTeqcPCaxY246oA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="108026149"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa010.jf.intel.com with ESMTP; 26 Jan 2025 01:24:38 -0800
Date: Sun, 26 Jan 2025 17:24:17 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Yidong Zhang <yidong.zhang@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
	mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
	lizhi.hou@amd.com, DMG Karthik <Karthik.DMG@amd.com>,
	Nishad Saraf <nishads@amd.com>,
	Prapul Krishnamurthy <prapulk@amd.com>,
	Hayden Laccabue <hayden.laccabue@amd.com>
Subject: Re: [PATCH V2 1/4] drivers/fpga/amd: Add new driver amd versal-pci
Message-ID: <Z5X/QeJ49s5Y3SuH@yilunxu-OptiPlex-7050>
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

> +static int versal_pci_program_axlf(struct versal_pci_device *vdev, char *data, size_t size)
> +{
> +	const struct axlf *axlf = (struct axlf *)data;
> +	struct fpga_image_info *image_info;
> +	int ret;
> +
> +	image_info = fpga_image_info_alloc(&vdev->pdev->dev);
> +	if (!image_info)
> +		return -ENOMEM;
> +
> +	image_info->count = axlf->header.length;
> +	image_info->buf = (char *)axlf;
> +
> +	ret = fpga_mgr_load(vdev->fdev->mgr, image_info);

I see, but this is not working like this. fpga_mgr_load() is intended to be
called by fpga_region, any reprogramming API should come from fpga_region,
and fpga_region could provide uAPI for userspace reprogramming.

If your driver act both as a fpga_mgr backend and a fpga_mgr kAPI user,
then you don't have to bother using fpga framework at all.

Thanks,
Yilun

> +	if (ret) {
> +		vdev_err(vdev, "failed to load xclbin: %d", ret);
> +		goto exit;
> +	}
> +
> +	vdev_info(vdev, "Downloaded axlf %pUb of size %zu Bytes", &axlf->header.uuid, size);
> +	uuid_copy(&vdev->xclbin_uuid, &axlf->header.uuid);
> +
> +exit:
> +	fpga_image_info_free(image_info);
> +
> +	return ret;
> +}


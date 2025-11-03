Return-Path: <linux-fpga+bounces-1403-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D9BC2CF37
	for <lists+linux-fpga@lfdr.de>; Mon, 03 Nov 2025 17:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D656A56221F
	for <lists+linux-fpga@lfdr.de>; Mon,  3 Nov 2025 15:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A249314D02;
	Mon,  3 Nov 2025 15:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N9Lsjbvl"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB98828506C;
	Mon,  3 Nov 2025 15:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762182054; cv=none; b=swR/3G/A0bMqblZ0j8JckyMDGYSRM9G5xNA494L1/JzhXSnYZljl2mYLqWJPeHOuMN1Htm/4XT7SauepzkBfzRfZ/svr0C/8KvAKgi9qwmlTmpnLGhts8W6HN1DjC0J0o3DTtusScNrZ5lGMkW0407m9njbdg7p1ZI9fPkjC64U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762182054; c=relaxed/simple;
	bh=6RwdVLCfvW/I8UZyHeN/hVkPySSPR4Zt7NQljAFMBJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YxXcfS3DQVDiztMMP34bwB9dt3kQwufE0CQVO3IkcqWMqx60qZ64Txpn4vxczmvzPslOYLZEeg8NXC9GG075iFVxxq03yjgywrfbSFdXO9dYD7sJOxf59Fgq3gXeG6fc4wk3CcOlFH/lhbaTEE8RC3ANVonen6ydGFNNgcovXao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N9Lsjbvl; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762182052; x=1793718052;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6RwdVLCfvW/I8UZyHeN/hVkPySSPR4Zt7NQljAFMBJA=;
  b=N9LsjbvlQqzOY1/hlIXWANdnXLXdCCJUTEKwIlmi7yh+y59moRGa0rDJ
   cz39HNn+sO4TrlBQ2/iQuHUFqvN1QHf3we+byViOulthEVNDRcONOOl52
   0h0wB/X3deSXqoS0z28/yIn1JlcK7y5qgAwWaN8xXqibeW3K6e5g6wPIX
   JzG55OuagjVYduQNks+xYNEtQ6qGHmPQNkAcuQ7VKzk6DfffnfkTA2Cjy
   rcPJ5crIGM4z4HFfLpsaJrKL0YTMwCsvncwj4496bb3YmCNIuzKjCtWzI
   mRpWijtE9gcm48AS1ZZQyQ9XTk3RU/mX/nmOGIym7QO6XTaq4f6OScuOA
   g==;
X-CSE-ConnectionGUID: knZcKNmfS++0oHCSBatJNg==
X-CSE-MsgGUID: GYQoA4BTQ7WNPheFsLZIpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="75368226"
X-IronPort-AV: E=Sophos;i="6.19,276,1754982000"; 
   d="scan'208";a="75368226"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 07:00:52 -0800
X-CSE-ConnectionGUID: Ijxr1MP2TACwV7q1U6H48A==
X-CSE-MsgGUID: VheaoV/KQX6UDEVwfnyYow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,276,1754982000"; 
   d="scan'208";a="217707603"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa001.fm.intel.com with ESMTP; 03 Nov 2025 07:00:50 -0800
Date: Mon, 3 Nov 2025 22:46:47 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Dinh Nguyen <dinguyen@kernel.org>, devicetree@vger.kernel.org,
	linux-fpga@vger.kernel.org, yilun.xu@intel.com, trix@redhat.com,
	robh+dt@kernel.org, krzysztof.kozlowskii+dt@linaro.org,
	conor+dt@kernel.org, michal.simek@amd.com
Subject: Re: [PATCH] dt-bindings: fpga: update link for Altera's and AMD
 partial recon
Message-ID: <aQjAV/fVWManlprT@yilunxu-OptiPlex-7050>
References: <20251101190848.24271-1-dinguyen@kernel.org>
 <20251102-ginger-pig-of-lightning-f65ef4@kuoka>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251102-ginger-pig-of-lightning-f65ef4@kuoka>

On Sun, Nov 02, 2025 at 05:41:54PM +0100, Krzysztof Kozlowski wrote:
> On Sat, Nov 01, 2025 at 02:08:48PM -0500, Dinh Nguyen wrote:
> > The link is giving the 404 error, so use the correct link for the
> > documents
> > 
> > Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> > ---
> >  Documentation/devicetree/bindings/fpga/fpga-region.yaml | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Xu Yilun <yilun.xu@linux.intel.com>

Applied to for-next, thank.

> 
> Best regards,
> Krzysztof
> 
> 


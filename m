Return-Path: <linux-fpga+bounces-1449-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE2BC55E1C
	for <lists+linux-fpga@lfdr.de>; Thu, 13 Nov 2025 07:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87F873B3563
	for <lists+linux-fpga@lfdr.de>; Thu, 13 Nov 2025 06:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86CDF316902;
	Thu, 13 Nov 2025 06:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dFEzbQv0"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D2A316196;
	Thu, 13 Nov 2025 06:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763013984; cv=none; b=PDP3sJnQJl48VBENc3MPuItievRI9A57WBmBXNWKF2vHAbylJPWQ1aEhRlJIf3pI9vf/qgZQhwzsSzMGNzH+gbCH758RgkbjkAvAgmlNNgCCrnogSTizmOdUjuVw1s8ewGbT3cYNzru6yIBtsKp+mub0sgg1PoMd39ZhF377Jqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763013984; c=relaxed/simple;
	bh=BihPEsijl7sB5jl+yb+zBRJlum8QyQpnZDAo1ovvViA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A90EogAQNStDy6OqXrebFp9YIof8Xg3Ak0J5RIg8ANx2D/SgGPDAb4xfoI6PXl5/a9pST+BhcDBlh4c3OAR9P0vCDg8qs1d7wPds1FEhm1a3JwJKmanzHVS0m+PiuQ2Bkv57vtlpXVAODiOfXeT5rhVp4zW8KW86NPEhu86/Mao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dFEzbQv0; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763013982; x=1794549982;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BihPEsijl7sB5jl+yb+zBRJlum8QyQpnZDAo1ovvViA=;
  b=dFEzbQv0qQTsecBVLeOa88lutXJ1qZT3jz7DdsNeZcAhsYCyKXyP/A/D
   5yM6Ru0yAuvE0IL0C+KvtiZ9KHtr33fcKF4vb3Xp5BtJFhxrty+YQNi7O
   H3gpeKns+VEsnpkG9osMD9uVnfTVy0KvSaovIePDa5U3b5ADaMVmO04P1
   KxnrO6crvg/T+waXBWse7Ifv3S8fjwD1kYKv+Ht55prNwW1fyfh89tQ58
   oRePXo/WaMUM5XWX84jzcGpip+jPG3+O66qEklDYUZ5rSWP5hsZ+bfeWW
   ayAi2bQUXXmMaM4VLh0WBnQ0wDLESaGz/tRp+RSj08y2555LjoFJXwRBz
   A==;
X-CSE-ConnectionGUID: 9xMPavI6QqaTqjn2rzIMDw==
X-CSE-MsgGUID: yVdqkpEsTembr0+yoLdg4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="76432193"
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; 
   d="scan'208";a="76432193"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 22:06:21 -0800
X-CSE-ConnectionGUID: eHIgh349QfuiTo4tsGIEUg==
X-CSE-MsgGUID: mSrADsZmRiGeOyer8xCk5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; 
   d="scan'208";a="194397594"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa004.fm.intel.com with ESMTP; 12 Nov 2025 22:06:17 -0800
Date: Thu, 13 Nov 2025 13:51:47 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Cc: Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>, Dinh Nguyen <dinguyen@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mahesh Rao <mahesh.rao@altera.com>,
	Ho Yin <adrian.ho.yin.ng@altera.com>,
	Niravkumar L Rabara <nirav.rabara@altera.com>,
	linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: fpga: stratix10: add support for
 Agilex5
Message-ID: <aRVx85JJHDD4yygV@yilunxu-OptiPlex-7050>
References: <cover.1763008269.git.khairul.anuar.romli@altera.com>
 <e342dc1626ae07d6b1773ad9fa5232d38af76bc2.1763008269.git.khairul.anuar.romli@altera.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e342dc1626ae07d6b1773ad9fa5232d38af76bc2.1763008269.git.khairul.anuar.romli@altera.com>

On Thu, Nov 13, 2025 at 12:43:55PM +0800, Khairul Anuar Romli wrote:
> The Agilex 5 SoC FPGA manager introduces updated hardware features and
> register maps that require explicit binding support to enable correct
> initialization and control through the FPGA manager subsystem.
> 
> It allows FPGA manager drivers detect and configure Agilex 5 FPGA managers
> properly. This changes also keep device tree bindings up to date with
> hardware platforms changes.
> 
> Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
> ---
> Changes in v2:
> 	- No changes in this patch
> ---
>  .../devicetree/bindings/fpga/intel,stratix10-soc-fpga-mgr.yaml   | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/fpga/intel,stratix10-soc-fpga-mgr.yaml b/Documentation/devicetree/bindings/fpga/intel,stratix10-soc-fpga-mgr.yaml
> index 6e536d6b28a9..b531522cca07 100644
> --- a/Documentation/devicetree/bindings/fpga/intel,stratix10-soc-fpga-mgr.yaml
> +++ b/Documentation/devicetree/bindings/fpga/intel,stratix10-soc-fpga-mgr.yaml
> @@ -23,6 +23,7 @@ properties:
>      enum:
>        - intel,stratix10-soc-fpga-mgr
>        - intel,agilex-soc-fpga-mgr
> +      - intel,agilex5-soc-fpga-mgr

Reviewed-by: Xu Yilun <yilun.xu@intel.com>

>  
>  required:
>    - compatible
> -- 
> 2.43.7
> 
> 


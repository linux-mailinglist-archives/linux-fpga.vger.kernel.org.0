Return-Path: <linux-fpga+bounces-1243-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09956AD89D2
	for <lists+linux-fpga@lfdr.de>; Fri, 13 Jun 2025 12:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 293001892019
	for <lists+linux-fpga@lfdr.de>; Fri, 13 Jun 2025 10:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3A72D23B7;
	Fri, 13 Jun 2025 10:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y/Rlg/sW"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA012C15B0;
	Fri, 13 Jun 2025 10:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749811881; cv=none; b=LER4b4DoKovlx1MgLXN9+jCy+5wM/65ZkIEap1R5eBD9E1r2kpty82WcFlsATWVRogztlRjBECT26jsubkgDFPwIC9NszjVdtFudHBBZq7koH/4PFnVRx+nHAhNMjVNpYQPFs+em60KDoMV8gn5+f3tGpxiq9ibyYx161tp+o/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749811881; c=relaxed/simple;
	bh=EciE3//NCfIsA4Ol8/HoACr+mWBPUyiZqVRyI1XWzEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B6fm2Nj41RJ/CNYuSeqqkjF/ZydpDBXXRA4P/KlzgGEBFGdyMtKYY7brfpXgxyvBZ1XkroFr+LFe/twwyz7ARAVIPubDFqXLlifwp6MxVwYM8rzV6qaT7bzPDjx3ow/8QYWCsk3VDlyQucqXfl5tnnBwnir2aE8ovoEE+mQ5x2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y/Rlg/sW; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749811879; x=1781347879;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EciE3//NCfIsA4Ol8/HoACr+mWBPUyiZqVRyI1XWzEQ=;
  b=Y/Rlg/sWA3TcPlWst0ZV7MldqzpQt6dIXs5rCOyYqsc2mNXknXSSJ+Xw
   qT2/PvddciFA3MMA/0gkXgvFd7JmcurpmuiEdM3Ba7sKwlsGxhI0diA2J
   FQPGgIYzCdCezZeLcyNmV9uP181Atns3XyQIaCM8F/0YvOTValx5Mp27Y
   CcIf9dl8tlHNTPgCVajd3fbBwnZnpc12zMspdqXA+LR1TmWdqLBqFhmPE
   wNg6sw2FYLxDG8moc9FQVwyX2RjLBZ+Laj1M+cuXeyWrWouAXD4CznpuL
   sNRg1xgeTEeZ9irsUeswpWcWUagLq4RZHNYpdGxA25c6dnHwGQ5dBP93C
   A==;
X-CSE-ConnectionGUID: CLA6K1zWQx6zkRWO/55NFQ==
X-CSE-MsgGUID: O8VYBQcHTYS4qaFXAoVqSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11462"; a="55823426"
X-IronPort-AV: E=Sophos;i="6.16,233,1744095600"; 
   d="scan'208";a="55823426"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 03:51:18 -0700
X-CSE-ConnectionGUID: u6CjAHYBRKOI1F1Vwmiv5Q==
X-CSE-MsgGUID: CkffUuZ/TOa0uAWa89ht1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,233,1744095600"; 
   d="scan'208";a="152691358"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa005.fm.intel.com with ESMTP; 13 Jun 2025 03:51:15 -0700
Date: Fri, 13 Jun 2025 18:44:14 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Michal Simek <michal.simek@amd.com>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com,
	git@xilinx.com, Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Moritz Fischer <mdf@kernel.org>, Rob Herring <robh@kernel.org>,
	Tom Rix <trix@redhat.com>, Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"open list:FPGA MANAGER FRAMEWORK" <linux-fpga@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: fpga: Also describe clock for gpio
Message-ID: <aEwA/pFuvbP+acSY@yilunxu-OptiPlex-7050>
References: <8407ef56b11632c1a7abfce8a4534ed8a8ed56cc.1749809570.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8407ef56b11632c1a7abfce8a4534ed8a8ed56cc.1749809570.git.michal.simek@amd.com>

On Fri, Jun 13, 2025 at 12:12:52PM +0200, Michal Simek wrote:
> Axi gpio is going to have clocks as required property that's why it should
> be also described in bindings which are using axi gpio node.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
> Changes in v2:
> - New patch to fix reported as issue by the second patch
> - https://lore.kernel.org/r/174954437576.4177094.15371626866789542129.robh@kernel.org
> 
>  Documentation/devicetree/bindings/fpga/fpga-region.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/fpga/fpga-region.yaml b/Documentation/devicetree/bindings/fpga/fpga-region.yaml
> index 77554885a6c4..7d2d3b7aa4b7 100644
> --- a/Documentation/devicetree/bindings/fpga/fpga-region.yaml
> +++ b/Documentation/devicetree/bindings/fpga/fpga-region.yaml
> @@ -316,6 +316,7 @@ examples:
>          reg = <0x40000000 0x10000>;
>          gpio-controller;
>          #gpio-cells = <2>;
> +        clocks = <&clk>;

This file is mainly for fpga-region bindings. So I don't think we have
to strictly align with the example IP block binding every time it has
an update.

Thanks,
Yilun

>        };
>      };
>  
> -- 
> 2.43.0
> 
> 


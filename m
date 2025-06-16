Return-Path: <linux-fpga+bounces-1246-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22EFFADA715
	for <lists+linux-fpga@lfdr.de>; Mon, 16 Jun 2025 06:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7DCC16C616
	for <lists+linux-fpga@lfdr.de>; Mon, 16 Jun 2025 04:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F351BF33F;
	Mon, 16 Jun 2025 04:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D4IQXzua"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EB17262B;
	Mon, 16 Jun 2025 04:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750047310; cv=none; b=sHwIm9AvI24NhBo8REydowH57T44cZw7l2ImP42sl3lK1k+jf6kpUw6v5TCbunUXS7Yw8Px1q+i6HtqM8dp+lkl2NOcu2tHm/h24Z0PErp/7A9D1ZT2e+M4Au0RWUk6gPro/gwEfw15cLkKpNVfaBokydWhI9P6J4jg25by/UY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750047310; c=relaxed/simple;
	bh=WzDEvnQGvdgtdYz/0ru2tNuMxEP5YJDnyny/hKocKAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cYzk9ywH6MYoAqu2XD3rGtHsJVAZCPIXN8OFJtIG8pHtS3qciDWNF+zJ4/5XU8D0Wk2LafH9XDYrFfxhM4o0zG4qjRlDY9ml2onpsFwHpZdiiVWGbtrCLO9D+snl7rQfc9UFxBZgQKb451cE91ZgVr4KPBKcYPi7L8vOZ8A84Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D4IQXzua; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750047308; x=1781583308;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WzDEvnQGvdgtdYz/0ru2tNuMxEP5YJDnyny/hKocKAE=;
  b=D4IQXzuaj3TGX7Mm3uY8yTbML/0jgm0MtufWfM2x/uudV2zGjx2wFZ6W
   tu83u1X9GPLnWHAvh+4uzQ+TCWqenqCIwq9zWb71ueHUKxeIYVx2CGqG7
   r01sihVouzraV1jUt0bv3XbZVtV1r7Dd3HoDi2Bii2KkUrJQhIO/dfM+a
   nMCYn+AXKpEH9BcXUjjLhtSIies5LNlb0SmYd3xpxQHnmNG1sAMM5SY+C
   isJWvEFRgKIN/ljDwTb4VM9Yk5SS4K1uJOlj2kNogLgWYEIS2QGMukTTp
   S/5C4FfutAhtr4CY44REUlm2WDbfQ+WLh6BRsG4dKlyCIyh95rQceSrWY
   g==;
X-CSE-ConnectionGUID: l1wT6HaoQJe9+QNkjlCg6Q==
X-CSE-MsgGUID: IcVo+z1kQKSSRk8uU77OJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="63213811"
X-IronPort-AV: E=Sophos;i="6.16,240,1744095600"; 
   d="scan'208";a="63213811"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2025 21:15:07 -0700
X-CSE-ConnectionGUID: S8Nxdwc0RoGeD5CmbsCYHA==
X-CSE-MsgGUID: Wb1PpUIdT0O6iG26yvCcJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,240,1744095600"; 
   d="scan'208";a="171569944"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa002.fm.intel.com with ESMTP; 15 Jun 2025 21:15:04 -0700
Date: Mon, 16 Jun 2025 12:07:54 +0800
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
Message-ID: <aE+YmvQGvpB3kx48@yilunxu-OptiPlex-7050>
References: <8407ef56b11632c1a7abfce8a4534ed8a8ed56cc.1749809570.git.michal.simek@amd.com>
 <aEwA/pFuvbP+acSY@yilunxu-OptiPlex-7050>
 <712b690d-2fcf-486e-87a1-17e2354d371f@amd.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <712b690d-2fcf-486e-87a1-17e2354d371f@amd.com>

On Fri, Jun 13, 2025 at 12:52:46PM +0200, Michal Simek wrote:
> 
> 
> On 6/13/25 12:44, Xu Yilun wrote:
> > On Fri, Jun 13, 2025 at 12:12:52PM +0200, Michal Simek wrote:
> > > Axi gpio is going to have clocks as required property that's why it should
> > > be also described in bindings which are using axi gpio node.
> > > 
> > > Signed-off-by: Michal Simek <michal.simek@amd.com>
> > > ---
> > > 
> > > Changes in v2:
> > > - New patch to fix reported as issue by the second patch
> > > - https://lore.kernel.org/r/174954437576.4177094.15371626866789542129.robh@kernel.org
> > > 
> > >   Documentation/devicetree/bindings/fpga/fpga-region.yaml | 1 +
> > >   1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/fpga/fpga-region.yaml b/Documentation/devicetree/bindings/fpga/fpga-region.yaml
> > > index 77554885a6c4..7d2d3b7aa4b7 100644
> > > --- a/Documentation/devicetree/bindings/fpga/fpga-region.yaml
> > > +++ b/Documentation/devicetree/bindings/fpga/fpga-region.yaml
> > > @@ -316,6 +316,7 @@ examples:
> > >           reg = <0x40000000 0x10000>;
> > >           gpio-controller;
> > >           #gpio-cells = <2>;
> > > +        clocks = <&clk>;
> > 
> > This file is mainly for fpga-region bindings. So I don't think we have
> > to strictly align with the example IP block binding every time it has
> > an update.
> 
> But Rob's script are reporting issue if they are not. Please take a look at
> link above.

I see, then from FPGA side

Reviewed-by: Xu Yilun <yilun.xu@intel.com>
> 
> M


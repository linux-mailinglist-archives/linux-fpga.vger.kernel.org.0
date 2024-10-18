Return-Path: <linux-fpga+bounces-783-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB9CC9A320C
	for <lists+linux-fpga@lfdr.de>; Fri, 18 Oct 2024 03:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57861B220FB
	for <lists+linux-fpga@lfdr.de>; Fri, 18 Oct 2024 01:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27796F073;
	Fri, 18 Oct 2024 01:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U9Ct4E4E"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395D83A1CD;
	Fri, 18 Oct 2024 01:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729214752; cv=none; b=n3O623YnpOOFwSLay7Mhzhj0XGqeloWxaWpUBFNQurkJuMg0jyR7Lh1pmEPT9ehts9A1Xtlhh3bkeIb7OBsW0XiwaEYWdh84MHLvH9XClek1/jOsIdwKlceYxn3LcaFAFxpsLF9lP17Ti1mWiEnu9+kWqfgPgQO0yjysuFnVLO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729214752; c=relaxed/simple;
	bh=oUcHYf6Yxf0HLGdS6QLBeLKKNH3FLbYxBR5ql4zrxNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qp7FizR2W2dV5ndcnSFgTBlVr5SYj52VjoYlbnLh6w/o9c2WuX56EAtPTLzK6I2wmYk0NXEjrgciYmaBALzdxN2avD9XVZJvLYjci+hJoXyp50BwAPdEJlDYYNqUeSfQnJn9x/snhGNj4ALMx2b3C2a6qhKlOmMDbfWp02M5rHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U9Ct4E4E; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729214751; x=1760750751;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oUcHYf6Yxf0HLGdS6QLBeLKKNH3FLbYxBR5ql4zrxNE=;
  b=U9Ct4E4EF8xRyvuyrbdMCv0IrxcnwbjgI5jUSZwOqod6nc2xdOiId1xt
   q+3BDcwkn1Tw2zojAb8Pj1ug7CPtrm0S9wdypZEHrEnX3at0ANeJjg0ZZ
   uLMs4noIrRqxYhNWEQKOPRjiO5Fc5ieUf9vQ4JQH0k9GkE23/qIuwMitE
   t+IraQxt/pR8sBqpRtNWzKlMNC19f6FbS4jqXYVaiJ5Dw31txlnUrFSIr
   vmXlHugdFdRKiVn7EoQYlcca9zdvudnZoLRwE3/dlm/OZQxjLCUvtckDd
   u6u7IyZ26KrQxD21tmm0P1yJ00+6BXxB85XK1lUNYi4mOCx6giH8abnAT
   A==;
X-CSE-ConnectionGUID: qc+8v0BsSxqZb3rQ4VM/7Q==
X-CSE-MsgGUID: mrtAh9dbRMWOlaA9rhvRQA==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="31599152"
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="31599152"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 18:25:50 -0700
X-CSE-ConnectionGUID: GboODaqjRM6hrajyNTEJDA==
X-CSE-MsgGUID: 0iu7g0FaTnyadkGJiiydBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="78388666"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa007.fm.intel.com with ESMTP; 17 Oct 2024 18:25:43 -0700
Date: Fri, 18 Oct 2024 09:22:22 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: iansdannapel@gmail.com, mdf@kernel.org, hao.wu@intel.com,
	yilun.xu@intel.com, trix@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, neil.armstrong@linaro.org,
	heiko.stuebner@cherry.de, rafal@milecki.pl,
	linus.walleij@linaro.org, linux-fpga@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] fpga: Add Efinix Trion & Titanium serial SPI
 programming driver
Message-ID: <ZxG4TiP4tliF/bms@yilunxu-OptiPlex-7050>
References: <20240927141445.157234-1-iansdannapel@gmail.com>
 <c292b99c-3d51-461e-aadb-cd21ed972db0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c292b99c-3d51-461e-aadb-cd21ed972db0@kernel.org>

> > +static int efinix_spi_apply_clk_cycles(struct efinix_spi_conf *conf)
> > +{
> > +	char data[13] = {0};
> > +
> > +	return spi_write(conf->spi, data, sizeof(data));
> 
> Hm, aren't buffers from stack discouraged? spi-summary explicitly
> mentions this case or I am getting this wrong?

You are right. And there were already some fixes for this issue in FPGA. E.g.

https://lore.kernel.org/all/20221230092922.18822-2-i.bornyakov@metrotek.ru/

Thanks,
Yilun


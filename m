Return-Path: <linux-fpga+bounces-1451-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58440C55E80
	for <lists+linux-fpga@lfdr.de>; Thu, 13 Nov 2025 07:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A26983A42AE
	for <lists+linux-fpga@lfdr.de>; Thu, 13 Nov 2025 06:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F08320387;
	Thu, 13 Nov 2025 06:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MjAWJ9oH"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40C428852B;
	Thu, 13 Nov 2025 06:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763014587; cv=none; b=uH7z8mvUnhll45e0xn4QUMQkcs7CeiMWHdPbxDuObVEDUyT+HFbqqEEyq8+ZuVnHDIPha8KFuszpv7LOIeBwdnm5AfSHPusN2vYOAj7/7rblZkLdHWhQvY96JNYQzGK9jyyfvZ5K6tydXAl04R7ZQLsTtUYjb93lyCMh+LRmqRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763014587; c=relaxed/simple;
	bh=hgwRM688ElQHiPjqvUjsOtTlRk8zqrACeavqoqUaif0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JFaYtBQgMTVCcgL8hpE2MLCa2VMiJWWAkEdnSTj1cmC5b2AEFmzK1XGqhCoDYDk7VxJZ1ecCpmhISzMm3R2IuVzNBhMlHj0vk13Mko92cbK930otK9gfBTkvHT8jytabxUlweGKmnteaIGXUNFbkp/f7Huiqq6dnF5DmK5tLkoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MjAWJ9oH; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763014586; x=1794550586;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hgwRM688ElQHiPjqvUjsOtTlRk8zqrACeavqoqUaif0=;
  b=MjAWJ9oHJAi2hnoFvX/ZR4lbpcWeCIPQnL7SBelTRDM0pKYHgqlwqAvq
   537L9RzAvpH8wHVmlbtTfdw9OeVGR/5uUvw46QT2W2Sxbfg3ZA4W+jeX8
   CYf2DMzF4ClVG1CDoDhCGyKFqq4yg59TsZRlT7US4/StRyqo35Vy0su9s
   daPq5qG8+Y3vsDGKe1zof2Ehlg619GBHsT0p562nKiXv/6jCYaGPLINXf
   xHUdHUWihRwbS3WCj09tqpO83rv0NKM5NB10CZ6g7tJlestNwln53vnCP
   umRP0+7+cjseuniHSVPNEXNAexOiH/a773reSk2LGcRMaN3RwWokVK8O3
   A==;
X-CSE-ConnectionGUID: 6v4oR6ohQgq8GAFIhHHOQg==
X-CSE-MsgGUID: KC5lSfsZRfa1R0z/p3zAog==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="64992085"
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; 
   d="scan'208";a="64992085"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 22:16:25 -0800
X-CSE-ConnectionGUID: DR8rkq7hT5G4yWETmHv5HA==
X-CSE-MsgGUID: IPUKawIYT7Wam7MXm7dN9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; 
   d="scan'208";a="189839025"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa009.fm.intel.com with ESMTP; 12 Nov 2025 22:16:22 -0800
Date: Thu, 13 Nov 2025 14:01:52 +0800
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
Subject: Re: [PATCH v2 0/2] Enable FPGA Manager support for Agilex5
Message-ID: <aRV0UCZD6fwnfWUE@yilunxu-OptiPlex-7050>
References: <cover.1763008269.git.khairul.anuar.romli@altera.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1763008269.git.khairul.anuar.romli@altera.com>

On Thu, Nov 13, 2025 at 12:43:54PM +0800, Khairul Anuar Romli wrote:
> This patch series adds device tree bindings, driver support, and DTS
> updates to enable FPGA Manager functionality for Intel Agilex5 SoC.
> 
> These changes are intended to enable FPGA programming and management
> capabilities on Agilex5-based platforms.
> 
> ---
> Notes:
> Patch #3 depends on  "arm64: dts: intel: Add Agilex5 SVC node with memory

There is no patch #3 now. Should be Patch #2 ?

> region" from
> https://lore.kernel.org/all/3381ef56c1ff34a0b54cf76010889b5523ead825.1762387665.git.khairul.anuar.romli@altera.com/
> 
> This patch series is applied on socfpga maintainer's tree
> https://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git/log/?h=socfpga_dts_for_v6.19

Given that, @Dinh Nguyen could you take the series if you are good?

Thanks,
Yilun

> 
> Changes in v2:
> 	- Drop "fpga: stratix10-soc: Add support for Agilex5"
> 	- Add fallback compatible in DT
> ---
> Khairul Anuar Romli (2):
>   dt-bindings: fpga: stratix10: add support for Agilex5
>   arm64: dts: agilex5: add fpga-region and fpga-mgr nodes
> 
>  .../bindings/fpga/intel,stratix10-soc-fpga-mgr.yaml  |  1 +
>  arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi       | 12 ++++++++++++
>  2 files changed, 13 insertions(+)
> 
> -- 
> 2.43.7
> 
> 


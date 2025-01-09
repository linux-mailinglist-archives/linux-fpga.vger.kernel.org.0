Return-Path: <linux-fpga+bounces-995-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B3CA0724F
	for <lists+linux-fpga@lfdr.de>; Thu,  9 Jan 2025 10:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F1C81881437
	for <lists+linux-fpga@lfdr.de>; Thu,  9 Jan 2025 09:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15DDA1FCFF4;
	Thu,  9 Jan 2025 09:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="la00jHma"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53B02F2D
	for <linux-fpga@vger.kernel.org>; Thu,  9 Jan 2025 09:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736416689; cv=none; b=iyobQs/m2CevTKGuXcaAVnzJ3wGYKLi1hnOxgXnUZR0Z7P7lcqLGEWnCtwvDPgB+nror71G+OqfrndLSssJQBdsGES2GChmHqbr5KVOopal7mXSbomx+Ie26kHXxcR09YD2R0Nr1DPwBEYtAsabOR7wVL9hrSelMW9n0j3rtBFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736416689; c=relaxed/simple;
	bh=F2ljSmXRocZTCiVDlHucCPEhlltJxYq+4wlhGF4NOZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NwNbVXOJ5BnSvEOimfvfPUl/89PiWPmbGkw7uAV1Hhlitc8AjO/nlzpLyjQCCOIIQkx+2yJCAUSUPdIq50IWbKTV6SPwsmvIMxU0ARr0/rzBZDZNUl5V9bEE0UL8DVyZC1Hl6sx/+CsG05f9cwpUoqDtIkNVo7+vkXSPVUEo+6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=la00jHma; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFEC5C4CED2;
	Thu,  9 Jan 2025 09:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736416688;
	bh=F2ljSmXRocZTCiVDlHucCPEhlltJxYq+4wlhGF4NOZ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=la00jHmaXxgcWUHtLUjrRo5Cmf4b1HQ39ffbp9TeluL9jB3+QwV9d9kWpmLrStGI8
	 abxw/6tSOiCPIMPfgN1G/Ed8kSeJYaj0h5zmmkgeFPSTn7Ia32CdJGsXvDUPUt0W3D
	 yt9J7ucO0GUQzmh/UiK3EOZNiqVeL1j+X+K1S6Yo=
Date: Thu, 9 Jan 2025 10:57:27 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: yilun.xu@intel.com, linux-fpga@vger.kernel.org, mdf@kernel.org
Subject: Re: [GIT PULL] FPGA Manager changes for 6.14-rc1
Message-ID: <2025010920-dimness-reverse-de37@gregkh>
References: <Z37iY9vD0ZG2ykZW@yilunxu-OptiPlex-7050>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z37iY9vD0ZG2ykZW@yilunxu-OptiPlex-7050>

On Thu, Jan 09, 2025 at 04:38:59AM +0800, Xu Yilun wrote:
> The following changes since commit 40384c840ea1944d7c5a392e8975ed088ecf0b37:
> 
>   Linux 6.13-rc1 (2024-12-01 14:28:56 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga tags/fpga-for-6.14-rc1

Pulled and pushed out, thanks.

greg k-h


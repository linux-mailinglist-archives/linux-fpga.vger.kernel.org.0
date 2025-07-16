Return-Path: <linux-fpga+bounces-1286-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97215B07BE5
	for <lists+linux-fpga@lfdr.de>; Wed, 16 Jul 2025 19:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 045A31C236B0
	for <lists+linux-fpga@lfdr.de>; Wed, 16 Jul 2025 17:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2F6277030;
	Wed, 16 Jul 2025 17:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hBSkbfQc"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA48C2F5C4A
	for <linux-fpga@vger.kernel.org>; Wed, 16 Jul 2025 17:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752686524; cv=none; b=C8448HM0EjnfFzQeZPnR7C0TAr1uV2rchn4Eo81SUefwT9r7pEwJwnh9NtLnhR+ECQPkKlTP7tzhGHFuXHUyEwlIRTYpdONQuggewmkfsZv5UxFwECGc3y7nKbDNzHOQpv8bVdxNyw5f4/a+Asx5zD1Gaf666HZhFooMViyErXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752686524; c=relaxed/simple;
	bh=m/Y80Qv2a/0KEDfZw6AOyd6C8voP0x4BQNlI94HS7xY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IHt7NpAKfVHAHvjs723ps2RXZ72INGuvFVIklCn/T9jkaf9QdDl1DwAgEVqYp5z1BuQG9KNo3B5OocUgznwFBHEnq/QQzdO0NM/4oJoHC+ufxim8LycHqt84OZBL0l0Hn51hFI12Z3Xxv9cE5w3NVE4rq2/3UXgceZ8G/v645YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hBSkbfQc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC126C4CEF0;
	Wed, 16 Jul 2025 17:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752686524;
	bh=m/Y80Qv2a/0KEDfZw6AOyd6C8voP0x4BQNlI94HS7xY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hBSkbfQc7ysVMm1dUoaNv7Q0GEDC7pjs2WTYfPpv9O93gyduc6irXOB6oZ/Dk3Akc
	 hLxENONNvYmtQsHV7V7+fL6bZMSoxURVVTt4sy+bgILycnjlzuQtMa0v8OvZq8yKxi
	 MHx28b7/Vm3KYeNQTPAAVYWFZYTA1OcgwXAW/kDk=
Date: Wed, 16 Jul 2025 19:22:01 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: yilun.xu@intel.com, linux-fpga@vger.kernel.org, mdf@kernel.org
Subject: Re: [GIT PULL] FPGA Manager changes for 6.16-final
Message-ID: <2025071619-epic-confined-3bfd@gregkh>
References: <aHfYjZ62LMw2VCCU@yilunxu-OptiPlex-7050>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHfYjZ62LMw2VCCU@yilunxu-OptiPlex-7050>

On Thu, Jul 17, 2025 at 12:51:25AM +0800, Xu Yilun wrote:
> The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494:
> 
>   Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga tags/fpga-for-6.16-final
> 
> for you to fetch changes up to 1c6a132cb30909aba5b37ffc1739f3c288330603:
> 
>   MAINTAINERS: Update FPGA MANAGER maintainer (2025-07-12 02:52:40 +0800)
> 
> ----------------------------------------------------------------
> FPGA Manager changes for 6.16-final
> 
> - FPGA DFL DRIVERS Maintainer change from Wu Hao to Yilun
> 
> All patches have been reviewed on the mailing list, and have been in the
> last linux-next releases (as part of our fixes branch)
> 
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> 
> ----------------------------------------------------------------
> Xu Yilun (1):
>       MAINTAINERS: Update FPGA MANAGER maintainer
> 
>  MAINTAINERS | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

I already took this in my -next branch, any reason it has to be in
6.16-final?

thanks,

greg k-h


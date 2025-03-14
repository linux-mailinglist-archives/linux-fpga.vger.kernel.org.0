Return-Path: <linux-fpga+bounces-1113-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CBCA60A64
	for <lists+linux-fpga@lfdr.de>; Fri, 14 Mar 2025 08:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EFF57A9D62
	for <lists+linux-fpga@lfdr.de>; Fri, 14 Mar 2025 07:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCDD118C004;
	Fri, 14 Mar 2025 07:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="J7/exdD0"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E9018A922
	for <linux-fpga@vger.kernel.org>; Fri, 14 Mar 2025 07:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741938655; cv=none; b=qL18Uh80y/6G3vra7yvPRlKhobuyX4JTPvK+2EBAUBX578E80ABFafdOw6a/w5RJVqIPJqnPafctNLwlGrWy70aFxaRjch6ncfHvBxqJo7kYzyzoiJPApAuYGDa4Fs3YPzyQ402WWFKWQbBTCuLr+xVzO5MGfxHBm41GCy092uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741938655; c=relaxed/simple;
	bh=XEtISccRuz6ByWmOIOrv/EgQpupSkH4cjhVOuhSncUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c7+wZ8VEWUhbGjSIio22Te+wTF37O1GmFTsVim5bh2KVA+Y/nyALmeGxD6rk6rHJhvF7T/Xk+sO6qOLs/GnS8smdHq5R8Z4DEb+ZKJRMB6srpQjK/97i1SmpDSxRwtOXuHVnJwTrpLU4cm3P1bhzVtcsucRnDI3y6N5Kv3/sMWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=J7/exdD0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E031DC4CEE3;
	Fri, 14 Mar 2025 07:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741938655;
	bh=XEtISccRuz6ByWmOIOrv/EgQpupSkH4cjhVOuhSncUw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J7/exdD0Zs7EdG3fdYLCwEIwAxQN607DBAffjrc/7BwDG5axkYMDuNjceJX/KA74Q
	 5l2TIGha8bvEw/xAt3khWiOZy9gcOhS6ISR9TWUyqAz5dPGR3qL+GfMsL1K6va78i7
	 67TkN0PfuMqOn+BD6cbNxhdSOIHM/SVuziKcOEKI=
Date: Fri, 14 Mar 2025 08:45:59 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: yilun.xu@intel.com, linux-fpga@vger.kernel.org, mdf@kernel.org
Subject: Re: [GIT PULL] FPGA Manager changes for 6.15-rc1
Message-ID: <2025031453-dastardly-overarch-8581@gregkh>
References: <Z8+X+gHZjyvbP6cc@yilunxu-OptiPlex-7050>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8+X+gHZjyvbP6cc@yilunxu-OptiPlex-7050>

On Tue, Mar 11, 2025 at 09:55:06AM +0800, Xu Yilun wrote:
> The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:
> 
>   Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga tags/fpga-for-6.15-rc1

Pulled and pushed out, thanks.

greg k-h


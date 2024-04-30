Return-Path: <linux-fpga+bounces-525-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C3C8B6B9C
	for <lists+linux-fpga@lfdr.de>; Tue, 30 Apr 2024 09:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ED721C21D28
	for <lists+linux-fpga@lfdr.de>; Tue, 30 Apr 2024 07:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BEBE2C184;
	Tue, 30 Apr 2024 07:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tXcPnNxX"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4616222618
	for <linux-fpga@vger.kernel.org>; Tue, 30 Apr 2024 07:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714462130; cv=none; b=ZdIN4VLfEefu0AtIUw9uVL5sE9cpyEOny7ozz4g6EALuJuwvceth7E/qFvEr9J1VAgXvjEn3EIZQrXN7XNyS4Qbu+POqB/c/o9FQpqI+gtn6mjtq0Hd9SkN+PekcqlHMN7sOwilRBG6LPPA3Kztp0szGf98Pe+hqbzXhq2jC3gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714462130; c=relaxed/simple;
	bh=mN0xWTlyuuaZd32X2uPJWuSlufDfFSByR8tGkVprd+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rit2YfjNUBXTIyFFvHF/IK7XDE75/8i3dATm+iRlRvatxfqlzZwhPGi2pv8XjqQov0yvhGQi/uqfx9i0DIEyRhN77l7oMGgzrRX09kSL3A0LpDLqgMlf1lplE4suC9qmcvZhtdvg3SAnxpZDf1MhkYXgyImFlced/iqJfe5LKs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tXcPnNxX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B1F0C2BBFC;
	Tue, 30 Apr 2024 07:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714462129;
	bh=mN0xWTlyuuaZd32X2uPJWuSlufDfFSByR8tGkVprd+E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tXcPnNxXMEEFlTnEmWdQ3+ey4vn5I/tgr/x3pJABa1J3DItxIe31/UuGtYe390y6f
	 WGqCwG+TZdXC1/TSBnl6hepsXgYPol3PYWFHU0TogQtpWk+1hyKEm0s56gFfZCFSgE
	 zRgvUkWj3r25uOAqN9DlnrTMieEiFtpIHHZXTEYM=
Date: Tue, 30 Apr 2024 09:28:13 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: yilun.xu@intel.com, linux-fpga@vger.kernel.org, hao.wu@intel.com,
	mdf@kernel.org
Subject: Re: [GIT PULL] FPGA Manager changes for 6.10-rc1
Message-ID: <2024043006-chaffing-whisking-fe18@gregkh>
References: <ZjBc/ta+Luxdp8Dr@yilunxu-OptiPlex-7050>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjBc/ta+Luxdp8Dr@yilunxu-OptiPlex-7050>

On Tue, Apr 30, 2024 at 10:52:46AM +0800, Xu Yilun wrote:
> The following changes since commit 4cece764965020c22cff7665b18a012006359095:
> 
>   Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga tags/fpga-for-6.20-rc1

Pulled and pushed out, thanks.

greg k-h


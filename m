Return-Path: <linux-fpga+bounces-1225-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9740ABF3C6
	for <lists+linux-fpga@lfdr.de>; Wed, 21 May 2025 14:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA022164399
	for <lists+linux-fpga@lfdr.de>; Wed, 21 May 2025 12:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D082620CA;
	Wed, 21 May 2025 12:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="irrQp/US"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8CD221D8D
	for <linux-fpga@vger.kernel.org>; Wed, 21 May 2025 12:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747829405; cv=none; b=UXMDJP8mj4dgkps18fkRyg4WKnmxqNI4oKi0CkKHMrJYhakZ+y+9MWOKecEhK4GY00Mr/DtPJGGLa6DoABV/o2dtKWlOKihCdoW/Nq+G77KFLY0605d1Gc+MnEHx3IsmxQF3JSe6eWEcl5LjMa1dRElvHOSe1L/dzo/y3QYyTMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747829405; c=relaxed/simple;
	bh=2FuhgljJsSytqZeICooLisAXn3Zkc0lbVQCVKcX8m4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b1QX7qF5W5luAS2QG3hd8fnTWL0DnTdJIyqBITwcR9b75JTOazlKTKArNAjLNwHTBzmad21c7r2K8MRJi8k+IG4wGA6N8t+FP5SV3J6K/S8Yi8tDBQh1QqS7XZaL6Gcz4c0dvNlUr8iYK2xKsa6d6vukRolhOF0lmHiPkmJGCjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=irrQp/US; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E9F8C4CEE7;
	Wed, 21 May 2025 12:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747829405;
	bh=2FuhgljJsSytqZeICooLisAXn3Zkc0lbVQCVKcX8m4s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=irrQp/USP1QXC889wOn5aM6h0oQO+9DZ73c33m4KFxrKbSz8rS1RDza9fuLHpGcdS
	 FQ3a7r2Dialg7+iPGlWd1i4C2vy6UJ3IOJ7JJLk2P9EIpg1wMBNYQ01c4NYtUtEH4/
	 kwysFokPX3aEdvsV6kESDpWczYSIB1QVmzEOswzE=
Date: Wed, 21 May 2025 14:10:02 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: yilun.xu@intel.com, linux-fpga@vger.kernel.org, mdf@kernel.org
Subject: Re: [GIT PULL] FPGA Manager changes for 6.16-rc1
Message-ID: <2025052115-lance-punctured-578b@gregkh>
References: <aCDPz42LmQ47ANDX@yilunxu-OptiPlex-7050>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCDPz42LmQ47ANDX@yilunxu-OptiPlex-7050>

On Mon, May 12, 2025 at 12:26:55AM +0800, Xu Yilun wrote:
> The following changes since commit 0af2f6be1b4281385b618cb86ad946eded089ac8:
> 
>   Linux 6.15-rc1 (2025-04-06 13:11:33 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga tags/fpga-for-6.16-rc1

I've taken this but for some reason you have a commit in here with a
Fixes: tag but no cc: stable line, which means it will not be
automatically picked up for any stable backports :(

Please notify the stable team when it hits a release so that they can be
sure to include it properly where needed.  And in the future, be more
careful.

thanks,

greg k-h


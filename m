Return-Path: <linux-fpga+bounces-524-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F4E8B6B35
	for <lists+linux-fpga@lfdr.de>; Tue, 30 Apr 2024 09:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48A831F2166C
	for <lists+linux-fpga@lfdr.de>; Tue, 30 Apr 2024 07:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1598531A8F;
	Tue, 30 Apr 2024 07:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gFfAy2VG"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B691C291
	for <linux-fpga@vger.kernel.org>; Tue, 30 Apr 2024 07:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714461299; cv=none; b=Dq1ZRKIFFVwrNyZwWKjMAZoc4Ol/bsUQuL5EOZNQ46+p9r/AmLO/zFOq2kn6XpSw6bXG/rXoTLP3P06u5VA7e6brSqd9PwX1VoIx6wsgNYMU5RowK4ENh0Ubhkou5YgnpmF81QgWAhbKyCv0vdvXioKMGyiBKCYvzZ93VtHUjB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714461299; c=relaxed/simple;
	bh=JYLFHdAQYVetmbNOotm3KR/Dgw3SN2kj30a9C4qMDuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VOlQZgkYWv0Mm6tt8MAqNlXl9X1s49C98uY9HkS2nsWTX/xQwQFAN5u7K19M7SmYIkaFVUjvVEY2HyP6QOfHk3oV3OJhAQjFABUJC66+ORcI/0u2C4Bm32EQiw7AkdASvjIS6La5aYwvIwAKxxSXLcUJb7m5oS2/sgRrnC/HUg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gFfAy2VG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF63AC2BBFC;
	Tue, 30 Apr 2024 07:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714461298;
	bh=JYLFHdAQYVetmbNOotm3KR/Dgw3SN2kj30a9C4qMDuA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gFfAy2VGZ3z94YKKPjda2aIfMi5CBc7mpUaI5b8Xhpq61RNl6QCvEYAY/R7KsMH66
	 AhLaenbgc/YdrAUW9tvuSw9NIebarRfZlj4yfxsW7teVehVCXF6ydRuNkI9nkDB1Cg
	 IwPWSoQkrwzg0Lo6hEbYEwW7uqXYVoCmzD7yF0Jc=
Date: Tue, 30 Apr 2024 09:14:55 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: yilun.xu@intel.com, linux-fpga@vger.kernel.org, hao.wu@intel.com,
	mdf@kernel.org
Subject: Re: [GIT PULL] FPGA Manager changes for 6.9 final
Message-ID: <2024043047-deflate-pelt-914f@gregkh>
References: <ZjBf3XLBKXFZMhoc@yilunxu-OptiPlex-7050>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjBf3XLBKXFZMhoc@yilunxu-OptiPlex-7050>

On Tue, Apr 30, 2024 at 11:05:01AM +0800, Xu Yilun wrote:
> The following changes since commit 4cece764965020c22cff7665b18a012006359095:
> 
>   Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga tags/fpga-for-6.9-final

Pulled and pushed out, thanks.

greg k-h


Return-Path: <linux-fpga+bounces-1288-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B66B0AE71
	for <lists+linux-fpga@lfdr.de>; Sat, 19 Jul 2025 09:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6549156482F
	for <lists+linux-fpga@lfdr.de>; Sat, 19 Jul 2025 07:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0867F22D7A5;
	Sat, 19 Jul 2025 07:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bAfw3EIg"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA57F22AE76
	for <linux-fpga@vger.kernel.org>; Sat, 19 Jul 2025 07:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752910908; cv=none; b=UYRpXpcp8hCQ0A+kZoARf9hQcXriSIqqdhtiBiTsJf7Y6xEopza0/avhbXVmcKj9MkfkTPognxzYcJuEPRnCTirFyeIPWayGXwzUnlgplivEGoM9JGE8weC6RDzEa0/a5m3jNaPGBvdx9sy/YzfwtzlEXtgaNeenVXIVABUIZOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752910908; c=relaxed/simple;
	bh=n/gdgAO9ZNXi7B0dH94VKxhzin+ZDNGUsDgfOdxVLkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mt3VkAn/z2mLkbY5RLtPgcCPFKRYcyxsFTIVBMr9He/ZYfXJoi+r67WOGrJ3vNpoh1oovN1850c68LmSPpGiQKgsgElGnOA1GyOPu5KQbW8taP2hStUGZRsAK1lRGukAlG5WSQ5BP+Zhg2+9YQLHy+Qqw6vfMhM7xBor53Z7jBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bAfw3EIg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA9D1C4CEE3;
	Sat, 19 Jul 2025 07:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752910908;
	bh=n/gdgAO9ZNXi7B0dH94VKxhzin+ZDNGUsDgfOdxVLkM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bAfw3EIgjLG/4ZmUCNUqycd4lJeZ/SJ5fEWqUKVAM29KbnBfTqAvEri/n74Mdx2iv
	 X/NnzTtX5aCeFUzUz5y4bAKt/w7ZIG9lnjM93iqZfdMTY43+tF2h7NkE4UiK7DyFHW
	 ls3x8zyKLfrrq8qHoh99DAoLMepHAs39STJEP5e0=
Date: Sat, 19 Jul 2025 09:41:45 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: yilun.xu@intel.com, linux-fpga@vger.kernel.org, mdf@kernel.org
Subject: Re: [GIT PULL] FPGA Manager changes for 6.17-rc1
Message-ID: <2025071929-gap-dynamic-e413@gregkh>
References: <aHfYRyt9KycaroDx@yilunxu-OptiPlex-7050>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHfYRyt9KycaroDx@yilunxu-OptiPlex-7050>

On Thu, Jul 17, 2025 at 12:50:15AM +0800, Xu Yilun wrote:
> The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494:
> 
>   Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga tags/fpga-for-6.17-rc1

Pulled and pushed out, thanks.

greg k-h


Return-Path: <linux-fpga+bounces-88-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E46581D413
	for <lists+linux-fpga@lfdr.de>; Sat, 23 Dec 2023 13:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EECF2B20D08
	for <lists+linux-fpga@lfdr.de>; Sat, 23 Dec 2023 12:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03F9D28B;
	Sat, 23 Dec 2023 12:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1ooFP/kx"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72C09441
	for <linux-fpga@vger.kernel.org>; Sat, 23 Dec 2023 12:50:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD0A2C433C7;
	Sat, 23 Dec 2023 12:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703335851;
	bh=tlOCZQcgw8CsG6Y3KVbiP/f4y5fmuBbqTrF8wkK+Okw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1ooFP/kxIs9A4+fvO+p0VmqC32Xlaap8LKp3zdFz62XDp98INfHRXiTlISIpEa/9X
	 ZBLqBGf0HNKZKAxzEK2eN4Bmxs6EfbHtzYh3OSO4A3yUJ+gKZDmmzqP1q/8waKbm7J
	 GksP65JGLNe0z8scMrcT0S5T4To6xKrNiEhIDWKQ=
Date: Sat, 23 Dec 2023 13:50:30 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: yilun.xu@intel.com, linux-fpga@vger.kernel.org, hao.wu@intel.com,
	mdf@kernel.org
Subject: Re: [GIT PULL] FPGA Manager changes for 6.8-rc1 part two
Message-ID: <2023122318-campfire-unwound-fca4@gregkh>
References: <ZYWGSOYo3x06z8of@yilunxu-OptiPlex-7050>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZYWGSOYo3x06z8of@yilunxu-OptiPlex-7050>

On Fri, Dec 22, 2023 at 08:51:20PM +0800, Xu Yilun wrote:
> The following changes since commit 5496fb8eedd637e1e9d87655f86dc816afd5ad68:
> 
>   drivers/fpga: use standard array-copy function (2023-11-17 16:34:26 +0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga tags/fpga-for-6.8-rc1-2

Pulled and pushed out, thanks.

greg k-h


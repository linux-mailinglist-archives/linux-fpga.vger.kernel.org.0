Return-Path: <linux-fpga+bounces-56-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 424DA816B26
	for <lists+linux-fpga@lfdr.de>; Mon, 18 Dec 2023 11:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2E45281A7A
	for <lists+linux-fpga@lfdr.de>; Mon, 18 Dec 2023 10:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0005519471;
	Mon, 18 Dec 2023 10:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kBfGMdsx"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60B11945D
	for <linux-fpga@vger.kernel.org>; Mon, 18 Dec 2023 10:28:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE9CCC433C7;
	Mon, 18 Dec 2023 10:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702895315;
	bh=4u7x7/7wTNCLwNiIt+fRkfuhxXQA+iUwP/UYxGec+Cg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kBfGMdsxfPvfDz2EvJh4SGfdM0bwKPwtjG3CzAcF9KYIZ980nm18bibePfZPVj9el
	 xa2cB92fewFzzwTq5BQMFukdMVsFOIdjizrEYlUIUXrvjKZR/O4YFOOf7bM8gYUwFi
	 qbSoNkhSFQS9lGOIaFIpGXjDk/OFtwMLwQ5ZYZt0=
Date: Mon, 18 Dec 2023 11:28:32 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: yilun.xu@intel.com, linux-fpga@vger.kernel.org, hao.wu@intel.com,
	mdf@kernel.org
Subject: Re: [GIT PULL] FPGA Manager changes for 6.8-rc1
Message-ID: <2023121825-refutable-retinal-6772@gregkh>
References: <ZX/blWwXpO3/K914@yilunxu-OptiPlex-7050>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZX/blWwXpO3/K914@yilunxu-OptiPlex-7050>

On Mon, Dec 18, 2023 at 01:41:41PM +0800, Xu Yilun wrote:
> The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:
> 
>   Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga tags/fpga-for-6.8-rc1

Pulled and pushed out, thanks.

greg k-h


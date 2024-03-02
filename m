Return-Path: <linux-fpga+bounces-307-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7AA586F1FB
	for <lists+linux-fpga@lfdr.de>; Sat,  2 Mar 2024 20:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E71C1F214F9
	for <lists+linux-fpga@lfdr.de>; Sat,  2 Mar 2024 19:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7449137168;
	Sat,  2 Mar 2024 19:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cuRU+86x"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAF83FBA6
	for <linux-fpga@vger.kernel.org>; Sat,  2 Mar 2024 19:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709406102; cv=none; b=lhdXFTbRivkBe6wZoJHC2UIE0DUfP3vBgYFn0sKmmuEjHSnZNNVROborMbBeRs33/ss7HtExEjMGp1kc6rdv+0EncwVwGwJUAZHWw4bRKjKx4OXUBHaGapRpZeyj/V/sV3+nU85l4bPp5v7n3zaFXtSP8yLrb+q76x4gyNprj+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709406102; c=relaxed/simple;
	bh=IQlgq22W8DoKTW48uALvqp4anYw9cxfRSiZIHSxT/m8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RaEOvqdk1Ua0nw/PGQsBcPPCsuRVgNlkKuk8eB4TgD+o88+WzT7ecGMZYWsFDUrxRI9gp8nH8daSjZ6fCv2OwslshlS1RN7xHc1+ng2gJf96Wq1SGYeiqcwM1mtEEfUZ0Hn/S/leUXrrJvZnvyFf/MrofytzByh3LQQ2HeGfKEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cuRU+86x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B377C433F1;
	Sat,  2 Mar 2024 19:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709406101;
	bh=IQlgq22W8DoKTW48uALvqp4anYw9cxfRSiZIHSxT/m8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cuRU+86xzTxYhdszpKqs0R8tBXa3TyHJiPhwz8tIa1DUjo8sgfxa1UKIB9u225cT7
	 i624uL2p+wyAfaX4piBkZ5qlETrU/4EDbXVW0RZmExaa8iPllErelGy7oPY/mK/8SO
	 RYRZ8+e2yBMxCDceI3U8RikxKHp+otw3KmZHbAvM=
Date: Sat, 2 Mar 2024 20:01:39 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: yilun.xu@intel.com, linux-fpga@vger.kernel.org, hao.wu@intel.com,
	mdf@kernel.org
Subject: Re: [GIT PULL] FPGA Manager changes for 6.9-rc1
Message-ID: <2024030229-undercoat-fiddling-1bbf@gregkh>
References: <Zd/tvYnZg31SJLKz@yilunxu-OptiPlex-7050>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zd/tvYnZg31SJLKz@yilunxu-OptiPlex-7050>

On Thu, Feb 29, 2024 at 10:36:45AM +0800, Xu Yilun wrote:
> The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:
> 
>   Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga tags/fpga-for-6.9-rc1

Pulled and pushed out, thanks.

greg k-h


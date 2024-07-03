Return-Path: <linux-fpga+bounces-572-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C8B926229
	for <lists+linux-fpga@lfdr.de>; Wed,  3 Jul 2024 15:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92F201C21B13
	for <lists+linux-fpga@lfdr.de>; Wed,  3 Jul 2024 13:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFCCC17084B;
	Wed,  3 Jul 2024 13:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EBJrsKEa"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CB385624
	for <linux-fpga@vger.kernel.org>; Wed,  3 Jul 2024 13:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720014539; cv=none; b=DMahNXjBucJI0RgAbPKKIRY6HGVqecnwB1/K7NnsioCxgStVDxTX3wF8ZkgqwXMDbq09KgIv7d2OkM0HPhWeKg424CFLWm45wqpDT6pjCxOqXqCkKjdo4PZLDBJSRQ+IrvJ+lOSQQU8BSg5XPpR5RSn1/Uk/pMFWrGSBOltMjLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720014539; c=relaxed/simple;
	bh=8NOh2//grj9pcPlQy7y/jx2JbibWTdzwuCO/4HuN86o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RAshX2ApQyVz4Acm6nAIJX9ikK9IUJt9UMXYBoh1XiRjp/UYw2aOFCDYLeb72iY6wR3BiD+wACclxDXnS7e0e8qbudOlOEAse/sVwGylHvwukx5f0K2kGeQFpZ3ORorSYaxdc9o84+iWq6XXIDxlVUAoJ9ZfFRXmgNxQy+nS3oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EBJrsKEa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCE03C3277B;
	Wed,  3 Jul 2024 13:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720014539;
	bh=8NOh2//grj9pcPlQy7y/jx2JbibWTdzwuCO/4HuN86o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EBJrsKEaTZDkaBX4JBpPVFK9Ne06EQl+ahdkt/8KCscMMAsb7R6zagwkrlCmpmqIN
	 WO4dsj6GqrA2UOLCqXfotnoyjgWkV7coWqx0KYeAe5jMWf1d+C6KrG5dE+vNki7Ujy
	 9FdqyBaa3cRzpOowLPHg8HzHBmbHQiN8k3WLtn4I=
Date: Wed, 3 Jul 2024 15:48:48 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: yilun.xu@intel.com, linux-fpga@vger.kernel.org, hao.wu@intel.com,
	mdf@kernel.org
Subject: Re: [GIT PULL] FPGA Manager changes for 6.11-rc1
Message-ID: <2024070338-repose-mascot-cb6a@gregkh>
References: <Zn+lLiSHzlysDRbI@yilunxu-OptiPlex-7050>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zn+lLiSHzlysDRbI@yilunxu-OptiPlex-7050>

On Sat, Jun 29, 2024 at 02:09:50PM +0800, Xu Yilun wrote:
> The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:
> 
>   Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga tags/fpga-for-6.11-rc1

Pulled and pushed out, thanks.

greg k-h


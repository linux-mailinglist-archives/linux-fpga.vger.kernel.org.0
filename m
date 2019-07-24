Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4680728F3
	for <lists+linux-fpga@lfdr.de>; Wed, 24 Jul 2019 09:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725882AbfGXHU7 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 24 Jul 2019 03:20:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:34072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725851AbfGXHU7 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 24 Jul 2019 03:20:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6513421951;
        Wed, 24 Jul 2019 07:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563952858;
        bh=nIRMc07rGfZiKX6gVDxHBVQTuhgqPIkLbt87owpnbSY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uDD0AV5T00xPHfB6+9m1Gjz/sWE8kUlOVeuCFuabIjxXO18BT+kgzb0vTltfNXmcf
         BqJOf5N7P13DM4fMfgmuNVVLjnaN0Wc2rlztPz7DgzzuXHm2CNdcOLukZItAaxXRVs
         QNO2/X6yl2av7O75KLPZors0uWoG/yuhZBRAZxeE=
Date:   Wed, 24 Jul 2019 09:20:56 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org
Subject: Re: [GIT PULL] FPGA Manager fix for 5.3
Message-ID: <20190724072056.GA27472@kroah.com>
References: <20190724052012.GA3140@archbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724052012.GA3140@archbox>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Jul 23, 2019 at 10:20:12PM -0700, Moritz Fischer wrote:
> The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:
> 
>   Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga.git tags/fixes-for-5.3
> 
> for you to fetch changes up to c3aefa0b8f54e8c7967191e546a11019bc060fe6:
> 
>   fpga-manager: altera-ps-spi: Fix build error (2019-07-23 17:29:17 -0700)
> 
> ----------------------------------------------------------------
> FPGA Manager fixes for 5.3
> 
> Hi Greg,
> 
> this is only one (late) bugfix for 5.3 that fixes a build error,
> when altera-ps-spi is built as builtin while a dependency is built as a
> module.
> 
> This has been on the list for a while and I've reviewed it.
> 
> Signed-off-by: Moritz Fischer <mdf@kernel.org>

This message is not in the signed tag in the repo, are you sure you make
this correctly?  All I see is the first line:
	FPGA Manager fixes for 5.3

And it's a singluar "fix" :)

Care to fix this up and resend, or, just send the single patch as email,
as that's probably easier here.

thanks,

greg k-h

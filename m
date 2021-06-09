Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (unknown [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A996D3A1841
	for <lists+linux-fpga@lfdr.de>; Wed,  9 Jun 2021 16:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238871AbhFIO73 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 9 Jun 2021 10:59:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:34874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238713AbhFIO7N (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 9 Jun 2021 10:59:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DB43F611CC;
        Wed,  9 Jun 2021 14:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623250628;
        bh=PoYwI9DjnEQh9Wl4w4xBqnWBXjC1LGAiHsJEEJ6mXGA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cuXuDESBH4coEGxFrqh46LUUazB5vkj5TUfBOfEmOQ+WXJSt7Dx5gajXLLigJQnh8
         eZj4jicxM7b5l6eQc4ZydlAStTCbKTkBwfe58PKnMKNcquIB5Uc/qv6URGWz0n6QFF
         sD3iB5RGzTvAU92hIOkS9u+LQeVt25AbJo5FxFZ4=
Date:   Wed, 9 Jun 2021 16:57:06 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tom Rix <trix@redhat.com>
Cc:     mdf@kernel.org, michal.simek@xilinx.com, nava.manne@xilinx.com,
        luca@lucaceresoli.net, linux-fpga@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] fpga: xilinx: remove xilinx- prefix on files
Message-ID: <YMDWwjnCAMNMH94W@kroah.com>
References: <20210608162551.3010533-1-trix@redhat.com>
 <YMCQ9rNKAtXaCiuw@kroah.com>
 <ec407ae2-ea5a-5c97-aea6-1ba2451116b7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec407ae2-ea5a-5c97-aea6-1ba2451116b7@redhat.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, Jun 09, 2021 at 06:27:05AM -0700, Tom Rix wrote:
> 
> On 6/9/21 2:59 AM, Greg KH wrote:
> > On Tue, Jun 08, 2021 at 09:25:51AM -0700, trix@redhat.com wrote:
> > > From: Tom Rix <trix@redhat.com>
> > > 
> > > It is not necessary to have a xilinx- prefix on a file
> > > when the file is in a xilinx/ subdir.
> > > 
> > > Signed-off-by: Tom Rix <trix@redhat.com>
> > > ---
> > >   drivers/fpga/xilinx/Makefile                                  | 4 ++--
> > >   drivers/fpga/xilinx/{xilinx-pr-decoupler.c => pr-decoupler.c} | 0
> > >   drivers/fpga/xilinx/{xilinx-spi.c => spi.c}                   | 0
> > >   3 files changed, 2 insertions(+), 2 deletions(-)
> > >   rename drivers/fpga/xilinx/{xilinx-pr-decoupler.c => pr-decoupler.c} (100%)
> > >   rename drivers/fpga/xilinx/{xilinx-spi.c => spi.c} (100%)
> > > 
> > > diff --git a/drivers/fpga/xilinx/Makefile b/drivers/fpga/xilinx/Makefile
> > > index 7bb7543412790..4ac727d03e140 100644
> > > --- a/drivers/fpga/xilinx/Makefile
> > > +++ b/drivers/fpga/xilinx/Makefile
> > > @@ -1,7 +1,7 @@
> > >   # SPDX-License-Identifier: GPL-2.0
> > > -obj-$(CONFIG_XILINX_PR_DECOUPLER) += xilinx-pr-decoupler.o
> > > -obj-$(CONFIG_FPGA_MGR_XILINX_SPI) += xilinx-spi.o
> > > +obj-$(CONFIG_XILINX_PR_DECOUPLER) += pr-decoupler.o
> > > +obj-$(CONFIG_FPGA_MGR_XILINX_SPI) += spi.o
> > You just renamed the module to be called "spi.ko"????
> > 
> > Did you test this thing?  You can not rename modules without good
> > reasons, and calling a device specific kernel module "spi.ko" is not ok.
> 
> yes, this is a problem, I will drop the renaming patches.

So you didn't test these?

Again, why is this file movement necessary?

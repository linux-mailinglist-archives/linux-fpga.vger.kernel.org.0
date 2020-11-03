Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 569DA2A43B6
	for <lists+linux-fpga@lfdr.de>; Tue,  3 Nov 2020 12:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbgKCLH0 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 3 Nov 2020 06:07:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:37806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727709AbgKCLH0 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 3 Nov 2020 06:07:26 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B64FB208B6;
        Tue,  3 Nov 2020 11:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604401644;
        bh=M+dhHVbqNWje4Xwzwps9gEAORdzCR/kq/obe/1/Cj3M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fzaxGfsBhQgWe69kjrE7KARlOukzwJP2+cQ3/naZiUVz4lC+gMnxRECgHxgeIeMRt
         YOApBOpqURqoxmmFShY/yK6YjBQ7tXYYdOpyCPiM01TfAlNe+oZ/sUN5Yy2BaqFADZ
         uSfP0n57nY9l8K2YNgOxXPAGUxrahOGtWZzEOViI=
Date:   Tue, 3 Nov 2020 12:08:17 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        Tom Rix <trix@redhat.com>, Wu Hao <hao.wu@intel.com>
Subject: Re: [PATCH 4/4] fpga: dfl: move dfl bus related APIs to
 include/linux/dfl.h
Message-ID: <20201103110817.GA2680561@kroah.com>
References: <20201103072104.12361-1-mdf@kernel.org>
 <20201103072104.12361-5-mdf@kernel.org>
 <20201103074307.GD2500572@kroah.com>
 <20201103104317.GB23473@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103104317.GB23473@yilunxu-OptiPlex-7050>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Nov 03, 2020 at 06:43:17PM +0800, Xu Yilun wrote:
> On Tue, Nov 03, 2020 at 08:43:07AM +0100, Greg KH wrote:
> > On Mon, Nov 02, 2020 at 11:21:04PM -0800, Moritz Fischer wrote:
> > > From: Xu Yilun <yilun.xu@intel.com>
> > > 
> > > Now the dfl drivers could be made as independent modules and put in
> > > different folders according to their functionalities. In order for
> > > scattered dfl device drivers to include dfl bus APIs, move the
> > > dfl bus APIs to a new header file in the public folder.
> > > 
> > > [mdf@kernel.org: Fixed up header guards to match filename]
> > > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > > Reviewed-by: Tom Rix <trix@redhat.com>
> > > Acked-by: Wu Hao <hao.wu@intel.com>
> > > Signed-off-by: Moritz Fischer <mdf@kernel.org>
> > > ---
> > >  MAINTAINERS         |  1 +
> > >  drivers/fpga/dfl.c  |  1 +
> > >  drivers/fpga/dfl.h  | 72 -------------------------------------
> > >  include/linux/dfl.h | 86 +++++++++++++++++++++++++++++++++++++++++++++
> > >  4 files changed, 88 insertions(+), 72 deletions(-)
> > >  create mode 100644 include/linux/dfl.h
> > 
> > Why move this if there is no in-kernel users?
> 
> The DFL emif driver in driver/memory is the first user, see:
> 
> https://lore.kernel.org/linux-fpga/20201027105545.GB20676@kozik-lap/T/#m6b72f043ecf266c6305bf43db88cddcaf3f9f73d
> 
> It is not in this patchset, but the memory controller maintainer is already
> acked this patch.

How am I, or anyone else, supposed to know this?

Again, don't include patches that are not actually used, that's a huge
red flag to any reviewer and it just makes them grumpy and sad and
less-likely to ever want to review code from the submitter again...

{sigh}

greg k-h

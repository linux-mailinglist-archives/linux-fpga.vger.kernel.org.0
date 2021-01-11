Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 776812F1DBB
	for <lists+linux-fpga@lfdr.de>; Mon, 11 Jan 2021 19:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389276AbhAKSPH (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 11 Jan 2021 13:15:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:37738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726668AbhAKSPH (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 11 Jan 2021 13:15:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9666B207B1;
        Mon, 11 Jan 2021 18:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610388866;
        bh=B62HC3paLLckrwQ1xkjNWaCPCuRiDK6rJQAJHbpRzW0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CPEP7PyqdyWqlypm0V+py211dLaXp0PKJ548GXRHUjlxBI1C1pA0riBCH8NE/YmK8
         zeCPeAzynkkTQ3bs128bQMKaOQKUst9hFNCInoXxc+XOVTuQ4dwH1jNzzccRZf7S3i
         KaHQOkQ6DajfJ9898JY4pNhDgLsb9talwxc6gnwU=
Date:   Mon, 11 Jan 2021 19:14:22 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Wu Hao <hao.wu@intel.com>, Moritz Fischer <mdf@kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        linux-fpga@vger.kernel.org, Tom Rix <trix@redhat.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] fpga: dfl-pci: rectify ReST formatting
Message-ID: <X/yVflU6ccIlAtgO@kroah.com>
References: <20210111112113.27242-1-lukas.bulwahn@gmail.com>
 <X/x0j+hWRdJ6U/MG@kroah.com>
 <CAKXUXMzR2J895_+ZsRqcJ___Pu0HnRfiiFFrGfehQe8J4kQrgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKXUXMzR2J895_+ZsRqcJ___Pu0HnRfiiFFrGfehQe8J4kQrgg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Jan 11, 2021 at 05:34:57PM +0100, Lukas Bulwahn wrote:
> On Mon, Jan 11, 2021 at 4:52 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Jan 11, 2021 at 12:21:13PM +0100, Lukas Bulwahn wrote:
> > > Commit fa41d10589be ("fpga: dfl-pci: locate DFLs by PCIe vendor specific
> > > capability") provides documentation to the FPGA Device Feature List (DFL)
> > > Framework Overview, but introduced new documentation warnings:
> > >
> > >   ./Documentation/fpga/dfl.rst:
> > >     505: WARNING: Title underline too short.
> > >     523: WARNING: Unexpected indentation.
> > >     523: WARNING: Blank line required after table.
> > >     524: WARNING: Block quote ends without a blank line; unexpected unindent.
> > >
> > > Rectify ReST formatting in ./Documentation/fpga/dfl.rst.
> > >
> > > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> >
> 
> > You forgot a Reported-by: tag for the person who notified you of this :(
> 
> Greg, would you believe that I run 'make htmldocs' on linux-next myself?

Sure, just seemed to match up with when Stephen reported this a few
hours earlier...

thanks,

greg k-h

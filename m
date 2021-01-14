Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06C542F66C5
	for <lists+linux-fpga@lfdr.de>; Thu, 14 Jan 2021 18:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbhANRGO (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 14 Jan 2021 12:06:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:54126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726212AbhANRGO (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 14 Jan 2021 12:06:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1C14C23B1C;
        Thu, 14 Jan 2021 17:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610643933;
        bh=hwf3Sj/6g5H0FgDr5lRz9hWS4NsLDeGdj2FQI3Njcdw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kCHIxu1Ium/Rgyz9SefxLajRjTZIbQFN2FuB/rX1oEHn0mJkVmz7ZTNvVOHIKd6jG
         MYb9a/yLBsC+WqGiW5yEWMm8/U1Di9efvc0l2YwFC6JC2xZSfONs0c4vdtuj31cSgB
         +pJkSIM0retppMmDDkFcqgMIgoK4Qimua9I+m9zw=
Date:   Thu, 14 Jan 2021 18:05:30 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>, Wu Hao <hao.wu@intel.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        linux-fpga@vger.kernel.org, Tom Rix <trix@redhat.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] fpga: dfl-pci: rectify ReST formatting
Message-ID: <YAB52nrYo2MTdlzA@kroah.com>
References: <20210111112113.27242-1-lukas.bulwahn@gmail.com>
 <X/x0j+hWRdJ6U/MG@kroah.com>
 <CAKXUXMzR2J895_+ZsRqcJ___Pu0HnRfiiFFrGfehQe8J4kQrgg@mail.gmail.com>
 <X/yVflU6ccIlAtgO@kroah.com>
 <YAB1G9e4lCaKq0sq@epycbox.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YAB1G9e4lCaKq0sq@epycbox.lan>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, Jan 14, 2021 at 08:45:15AM -0800, Moritz Fischer wrote:
> Hi Greg,
> 
> On Mon, Jan 11, 2021 at 07:14:22PM +0100, Greg Kroah-Hartman wrote:
> > On Mon, Jan 11, 2021 at 05:34:57PM +0100, Lukas Bulwahn wrote:
> > > On Mon, Jan 11, 2021 at 4:52 PM Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Mon, Jan 11, 2021 at 12:21:13PM +0100, Lukas Bulwahn wrote:
> > > > > Commit fa41d10589be ("fpga: dfl-pci: locate DFLs by PCIe vendor specific
> > > > > capability") provides documentation to the FPGA Device Feature List (DFL)
> > > > > Framework Overview, but introduced new documentation warnings:
> > > > >
> > > > >   ./Documentation/fpga/dfl.rst:
> > > > >     505: WARNING: Title underline too short.
> > > > >     523: WARNING: Unexpected indentation.
> > > > >     523: WARNING: Blank line required after table.
> > > > >     524: WARNING: Block quote ends without a blank line; unexpected unindent.
> > > > >
> > > > > Rectify ReST formatting in ./Documentation/fpga/dfl.rst.
> > > > >
> > > > > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > > >
> > > 
> > > > You forgot a Reported-by: tag for the person who notified you of this :(
> > > 
> > > Greg, would you believe that I run 'make htmldocs' on linux-next myself?
> > 
> > Sure, just seemed to match up with when Stephen reported this a few
> > hours earlier...
> > 
> > thanks,
> > 
> > greg k-h
> 
> Are you waiting for a resend on this? Just asking because we got three
> versions of this patch by now :)
> 
> I haven't re-sent this since you were already on the thread.

I'll just take this one, for some reason I thought Lukas was going to
resend, my fault...

greg k-h

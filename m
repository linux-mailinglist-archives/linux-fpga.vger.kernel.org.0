Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 058575F254
	for <lists+linux-fpga@lfdr.de>; Thu,  4 Jul 2019 07:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725945AbfGDFjb (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 4 Jul 2019 01:39:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:46356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725879AbfGDFjb (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 4 Jul 2019 01:39:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64BBC21882;
        Thu,  4 Jul 2019 05:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562218769;
        bh=l5a03sjl2l+bpYmsMzEJCgF/WiLVKn30HEWoyaM68Gs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kx9GCrWZpCqJURDrv6MyxKtWv5zXwNx82aigBZrINlKbl1iT5/ewAvzGSwqbKK7Mv
         ZUzqlEGkgebmK8z1OHhyP8xRXyAjrpGC1wKAGgb0i6jWW/mqh32Cc9vbA2Ct1iijXd
         KguDsOmTHYOBrUsg3XicHtiPyWLKsCq4M4oSlv2E=
Date:   Thu, 4 Jul 2019 07:39:27 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wu Hao <hao.wu@intel.com>
Cc:     Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Zhang Yi Z <yi.z.zhang@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Alan Tull <atull@kernel.org>
Subject: Re: [PATCH 06/15] fpga: dfl: fme: add
 DFL_FPGA_FME_PORT_RELEASE/ASSIGN ioctl support.
Message-ID: <20190704053927.GB347@kroah.com>
References: <20190628004951.6202-1-mdf@kernel.org>
 <20190628004951.6202-7-mdf@kernel.org>
 <20190703180753.GA24723@kroah.com>
 <20190703233058.GA15825@hao-dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190703233058.GA15825@hao-dev>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, Jul 04, 2019 at 07:30:58AM +0800, Wu Hao wrote:
> On Wed, Jul 03, 2019 at 08:07:53PM +0200, Greg KH wrote:
> > On Thu, Jun 27, 2019 at 05:49:42PM -0700, Moritz Fischer wrote:
> > > From: Wu Hao <hao.wu@intel.com>
> > > 
> > > In order to support virtualization usage via PCIe SRIOV, this patch
> > > adds two ioctls under FPGA Management Engine (FME) to release and
> > > assign back the port device. In order to safely turn Port from PF
> > > into VF and enable PCIe SRIOV, it requires user to invoke this
> > > PORT_RELEASE ioctl to release port firstly to remove userspace
> > > interfaces, and then configure the PF/VF access register in FME.
> > > After disable SRIOV, it requires user to invoke this PORT_ASSIGN
> > > ioctl to attach the port back to PF.
> > > 
> > >  Ioctl interfaces:
> > >  * DFL_FPGA_FME_PORT_RELEASE
> > >    Release platform device of given port, it deletes port platform
> > >    device to remove related userspace interfaces on PF, then
> > >    configures PF/VF access mode to VF.
> > > 
> > >  * DFL_FPGA_FME_PORT_ASSIGN
> > >    Assign platform device of given port back to PF, it configures
> > >    PF/VF access mode to PF, then adds port platform device back to
> > >    re-enable related userspace interfaces on PF.
> > 
> > Why are you not using the "generic" bind/unbind facility that userspace
> > already has for this with binding drivers to devices?  Why a special
> > ioctl?
> 
> Hi Greg,
> 
> Actually we think it should be safer that making the device invisble than
> just unbinding its driver. Looks like user can try to rebind it at any
> time and we don't have any method to stop them.

Why do you want to "stop" the user from doing something?  They asked to
do it, why prevent it?  If they ask to do something foolish, well, they
get to keep the pieces :)

> > > --- a/include/uapi/linux/fpga-dfl.h
> > > +++ b/include/uapi/linux/fpga-dfl.h
> > > @@ -176,4 +176,36 @@ struct dfl_fpga_fme_port_pr {
> > >  
> > >  #define DFL_FPGA_FME_PORT_PR	_IO(DFL_FPGA_MAGIC, DFL_FME_BASE + 0)
> > >  
> > > +/**
> > > + * DFL_FPGA_FME_PORT_RELEASE - _IOW(DFL_FPGA_MAGIC, DFL_FME_BASE + 1,
> > > + *					struct dfl_fpga_fme_port_release)
> > > + *
> > > + * Driver releases the port per Port ID provided by caller.
> > > + * Return: 0 on success, -errno on failure.
> > > + */
> > > +struct dfl_fpga_fme_port_release {
> > > +	/* Input */
> > > +	__u32 argsz;		/* Structure length */
> > > +	__u32 flags;		/* Zero for now */
> > > +	__u32 port_id;
> > > +};
> > 
> > meta-comment, why do all of your structures for ioctls have argsz?  You
> > "know" the size of the structure already, it's part of the ioctl
> > definition.  You shouldn't need to also set it again, right?  Otherwise
> > ALL Linux ioctls would need something crazy like this.
> 
> Actually we followed the same method as vfio.

vfio is a protocol on "the wire", right?  Not an ioctl.

> The major purpose should be extendibility, as we really need this to
> be sth long term maintainable.

You can't change ioctl structure sizes at any time.

> It really helps, if we add some new members for extentions/enhancement
> under the same ioctl.

You don't do that.

> I don't think everybody needs this, but my consideration here is if
> newer generations of hardware/specs come with some extentions, I still
> hope we can resue these IOCTLs as much as we could, instead of
> creating more new ones.

You create new ones, like everyone else does, as you can not change old
code.  By trying to "version" structures like this, it's just going to
be a nightmare.

thanks,

greg k-h

Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DEE35EFBD
	for <lists+linux-fpga@lfdr.de>; Thu,  4 Jul 2019 01:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbfGCXro (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 3 Jul 2019 19:47:44 -0400
Received: from mga07.intel.com ([134.134.136.100]:25134 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726902AbfGCXro (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 3 Jul 2019 19:47:44 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jul 2019 16:47:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,448,1557212400"; 
   d="scan'208";a="154901178"
Received: from hao-dev.bj.intel.com (HELO localhost) ([10.238.157.65])
  by orsmga007.jf.intel.com with ESMTP; 03 Jul 2019 16:47:41 -0700
Date:   Thu, 4 Jul 2019 07:30:58 +0800
From:   Wu Hao <hao.wu@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Zhang Yi Z <yi.z.zhang@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Alan Tull <atull@kernel.org>
Subject: Re: [PATCH 06/15] fpga: dfl: fme: add
 DFL_FPGA_FME_PORT_RELEASE/ASSIGN ioctl support.
Message-ID: <20190703233058.GA15825@hao-dev>
References: <20190628004951.6202-1-mdf@kernel.org>
 <20190628004951.6202-7-mdf@kernel.org>
 <20190703180753.GA24723@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190703180753.GA24723@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, Jul 03, 2019 at 08:07:53PM +0200, Greg KH wrote:
> On Thu, Jun 27, 2019 at 05:49:42PM -0700, Moritz Fischer wrote:
> > From: Wu Hao <hao.wu@intel.com>
> > 
> > In order to support virtualization usage via PCIe SRIOV, this patch
> > adds two ioctls under FPGA Management Engine (FME) to release and
> > assign back the port device. In order to safely turn Port from PF
> > into VF and enable PCIe SRIOV, it requires user to invoke this
> > PORT_RELEASE ioctl to release port firstly to remove userspace
> > interfaces, and then configure the PF/VF access register in FME.
> > After disable SRIOV, it requires user to invoke this PORT_ASSIGN
> > ioctl to attach the port back to PF.
> > 
> >  Ioctl interfaces:
> >  * DFL_FPGA_FME_PORT_RELEASE
> >    Release platform device of given port, it deletes port platform
> >    device to remove related userspace interfaces on PF, then
> >    configures PF/VF access mode to VF.
> > 
> >  * DFL_FPGA_FME_PORT_ASSIGN
> >    Assign platform device of given port back to PF, it configures
> >    PF/VF access mode to PF, then adds port platform device back to
> >    re-enable related userspace interfaces on PF.
> 
> Why are you not using the "generic" bind/unbind facility that userspace
> already has for this with binding drivers to devices?  Why a special
> ioctl?

Hi Greg,

Actually we think it should be safer that making the device invisble than
just unbinding its driver. Looks like user can try to rebind it at any
time and we don't have any method to stop them.

> 
> > --- a/include/uapi/linux/fpga-dfl.h
> > +++ b/include/uapi/linux/fpga-dfl.h
> > @@ -176,4 +176,36 @@ struct dfl_fpga_fme_port_pr {
> >  
> >  #define DFL_FPGA_FME_PORT_PR	_IO(DFL_FPGA_MAGIC, DFL_FME_BASE + 0)
> >  
> > +/**
> > + * DFL_FPGA_FME_PORT_RELEASE - _IOW(DFL_FPGA_MAGIC, DFL_FME_BASE + 1,
> > + *					struct dfl_fpga_fme_port_release)
> > + *
> > + * Driver releases the port per Port ID provided by caller.
> > + * Return: 0 on success, -errno on failure.
> > + */
> > +struct dfl_fpga_fme_port_release {
> > +	/* Input */
> > +	__u32 argsz;		/* Structure length */
> > +	__u32 flags;		/* Zero for now */
> > +	__u32 port_id;
> > +};
> 
> meta-comment, why do all of your structures for ioctls have argsz?  You
> "know" the size of the structure already, it's part of the ioctl
> definition.  You shouldn't need to also set it again, right?  Otherwise
> ALL Linux ioctls would need something crazy like this.

Actually we followed the same method as vfio. The major purpose should be
extendibility, as we really need this to be sth long term maintainable.
It really helps, if we add some new members for extentions/enhancement
under the same ioctl. I don't think everybody needs this, but my
consideration here is if newer generations of hardware/specs come with some
extentions, I still hope we can resue these IOCTLs as much as we could,
instead of creating more new ones.

Thanks
Hao

> 
> thanks,
> 
> greg k-h

Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DEBA2937E9
	for <lists+linux-fpga@lfdr.de>; Tue, 20 Oct 2020 11:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392747AbgJTJVO (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 20 Oct 2020 05:21:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:48202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392347AbgJTJVO (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 20 Oct 2020 05:21:14 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E96BF22283;
        Tue, 20 Oct 2020 09:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603185673;
        bh=xJBPcxy4dg9fBmvpcO8v9x+85PkwUhOcKInV6wGeUMc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n7CvHIR6EtuUnzq8D48VufpuZuKI5klitmeGyGXQhW+ymLcLPeTI1d77twcfyDOPl
         kdtqqqRaBa8m4Oh/2fcKlyl/CfAp5uHI3wETp8eCcn4OPQnrpzbjGFRxKmcDq8ZeSF
         ue1MxRK+sj2+lgZQsJkrmpL8j35I750onFD57yIg=
Date:   Tue, 20 Oct 2020 11:21:55 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     Tom Rix <trix@redhat.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        lgoncalv@redhat.com, hao.wu@intel.com
Subject: Re: [PATCH 1/2] fpga: dfl: add driver_override support
Message-ID: <20201020092155.GA3879567@kroah.com>
References: <1602828151-24784-1-git-send-email-yilun.xu@intel.com>
 <1602828151-24784-2-git-send-email-yilun.xu@intel.com>
 <63d7730b-d9b8-c75d-16f6-3ebb507aabaa@redhat.com>
 <20201019040612.GA16172@yilunxu-OptiPlex-7050>
 <f767b9a0-1db8-7ced-6bd9-5ee1f58d40da@redhat.com>
 <20201020071158.GC28746@yilunxu-OptiPlex-7050>
 <20201020073259.GA3803984@kroah.com>
 <20201020085723.GE16172@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201020085723.GE16172@yilunxu-OptiPlex-7050>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Oct 20, 2020 at 04:57:23PM +0800, Xu Yilun wrote:
> On Tue, Oct 20, 2020 at 09:32:59AM +0200, Greg KH wrote:
> > On Tue, Oct 20, 2020 at 03:11:58PM +0800, Xu Yilun wrote:
> > > I think it is normal case that a driver is successfully registered but
> > > doesn't match any device because it provides no id_table.
> > 
> > How is that "normal"?  What would ever cause that driver to be bound to
> > a device then?
> 
> This patchset adds the driver_override sysfs node, to let userspace
> specify which driver (by name matching) to be bound to a device. The
> driver "dfl-uio-pdev" doesn't provide an id_table, it could only be
> bound to a device whose driver_override is set to "dfl-uio-pdev".
> 
> Sorry, this is actually not "normal". Usually dfl drivers with valid id_table
> should be used to drive the dfl devices. But we also want to give an option
> for userspace to take full control of the device, some IP blocks in FPGA are
> written for specific purposes by FPGA user so a userspace driver may
> serve them better.
> 
> > 
> > And you better not say userspace is responsible for it...
> 
> Actually it is the userspace's decision which device they want to
> access directly ...
> 
> I'm not sure if this idea is OK. I see similar implementation for
> pci/platform devices.

That is there for debugging and for being able to support things when
the kernel is not updated with a new device id yet.

The virtio people took this to a new extreme and use it to bind real
devices through to virtual machines, but really, that's horrid.  And
they have problems with it as is seen in random patches at times.

Don't make this the only way to support this, that's not an ok api.

greg k-h

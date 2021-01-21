Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51DC02FF558
	for <lists+linux-fpga@lfdr.de>; Thu, 21 Jan 2021 21:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725779AbhAUUEq (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 21 Jan 2021 15:04:46 -0500
Received: from mail-pl1-f170.google.com ([209.85.214.170]:40063 "EHLO
        mail-pl1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbhAUUEe (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 21 Jan 2021 15:04:34 -0500
Received: by mail-pl1-f170.google.com with SMTP id q4so1900357plr.7;
        Thu, 21 Jan 2021 12:04:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vbOjpVsmpQhtFnQUm4RFDxZclscWyGQi1/nGqZaeVtM=;
        b=Tpne2kzSworlUdK2MYUw0bvIW5tLRQQX8UCl4nwSgtEZQ1dpKIv/vnPSoDrUdAuIek
         szErvfdB4AXLCyirAh3N3Frrj8GXvdxu3hDM46fgUPDiNpvy1KCBQRGEKMH5yISeyavY
         jRbFFJvNbgIKSJQtgdevxXnTHo9qL/gk32t31721t1zxTv2su0UGZ3/SxSEV7E6J+sfZ
         aDEcsAbKeGzRe+Pfw0La1/j8ARZz9mY9f0k+zjFIj6HJKIlx5d5bty8/74y1INKLgyte
         yS5zgJ6Nc2GtBnin7ts8onQIEl7+NhKOiByIHUWdIOVM8mywcdzBrix/MlTiwvYFEpML
         Yv4w==
X-Gm-Message-State: AOAM531knEXiw3YAKySZLhxnwlJ0e2cQvmZWCgw15zl9pICLYwEftlm1
        otgdcOI3Ou3jbx861nalERFexjmvEAE=
X-Google-Smtp-Source: ABdhPJx1lk8lK8OTgsKIrKodBSpWgO9BN3xXCd480n42hjho6/oSG4okH5VmWuGA5qYR1yfC0UT63A==
X-Received: by 2002:a17:90a:da01:: with SMTP id e1mr1163029pjv.58.1611259429210;
        Thu, 21 Jan 2021 12:03:49 -0800 (PST)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id t22sm7000998pgm.18.2021.01.21.12.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 12:03:48 -0800 (PST)
Date:   Thu, 21 Jan 2021 12:03:47 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     Tom Rix <trix@redhat.com>
Cc:     Moritz Fischer <mdf@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Xu Yilun <yilun.xu@intel.com>, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, lgoncalv@redhat.com, hao.wu@intel.com
Subject: Re: [PATCH v6 1/2] fpga: dfl: add the userspace I/O device support
 for DFL devices
Message-ID: <YAneI4AmuYqqqyUs@epycbox.lan>
References: <1610502848-30345-1-git-send-email-yilun.xu@intel.com>
 <1610502848-30345-2-git-send-email-yilun.xu@intel.com>
 <YARbgGU6lr3zZaKP@kroah.com>
 <YARkTFMrotPo45ic@epycbox.lan>
 <1d205328-6ffa-0f77-0bdf-0f4b822edc3a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d205328-6ffa-0f77-0bdf-0f4b822edc3a@redhat.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Tom,

On Thu, Jan 21, 2021 at 06:30:20AM -0800, Tom Rix wrote:
> 
> On 1/17/21 8:22 AM, Moritz Fischer wrote:
> > Greg,
> >
> > On Sun, Jan 17, 2021 at 04:45:04PM +0100, Greg KH wrote:
> >> On Wed, Jan 13, 2021 at 09:54:07AM +0800, Xu Yilun wrote:
> >>> This patch supports the DFL drivers be written in userspace. This is
> >>> realized by exposing the userspace I/O device interfaces.
> >>>
> >>> The driver leverages the uio_pdrv_genirq, it adds the uio_pdrv_genirq
> >>> platform device with the DFL device's resources, and let the generic UIO
> >>> platform device driver provide support to userspace access to kernel
> >>> interrupts and memory locations.
> >> Why doesn't the existing uio driver work for this, why do you need a new
> >> one?
> >>
> >>> ---
> >>>  drivers/fpga/Kconfig        | 10 +++++
> >>>  drivers/fpga/Makefile       |  1 +
> >>>  drivers/fpga/dfl-uio-pdev.c | 93 +++++++++++++++++++++++++++++++++++++++++++++
> >> uio drivers traditionally go in drivers/uio/ and start with "uio", so
> >> shouldn't this be drivers/uio/uio_dfl_pdev.c to match the same naming
> >> scheme?
> > I had considered suggesting that, but ultimately this driver only
> > creates a 'uio_pdrv_genirq' platform device, so it didn't seem like a
> > good fit.
> >> But again, you need to explain in detail, why the existing uio driver
> >> doesn't work properly, or why you can't just add a few lines to an
> >> existing one.
> > Ultimately there are three options I see:
> > 1) Do what Xu does, which is re-use the 'uio_pdrv_genirq' uio driver by
> >   creating a platform device for it as sub-device of the dfl device that
> >   we bind to uio_pdrv_genirq
> > 2) Add a module_dfl_driver part to drivers/uio/uio_pdrv_genirq.c and
> >   corresponding id table
> > 3) Create a new uio_dfl_genirq kind of driver that uses the dfl bus and
> >   that would make sense to then put into drivers/uio. (This would
> >   duplicate code in uio_pdrv_genirq to some extend)
> >
> > Overall I think in terms of code re-use I think Xu's choice might be
> > less new code as it simply wraps the uio platform device driver, and
> > allows for defining the resources passed to the UIO driver to be defined
> > by hardware through a DFL.
> >
> > I've seen the pattern that Xu proposed used in other places like the
> > macb network driver where you'd have macb_main (the platform driver) and
> > macb_pci that wraps it for a pci usage.
> >
> > - Moritz
> 
> Thinking of this problem more generally.
> 
> Every fpga will have a handful of sub devices.
> 
> Do we want to carry them in the fpga subsystem or carry them in the other subsystems ?

Yeah no we really don't. I think that was the point of the whole DFL
bus :)
> 
> Consider the short term reviewing and long term maintenance of the sub devices by the subsystem maintainers.
> 
> It easier for them if the sub devices are in the other subsystems.

Agreed.
> 
> 
> Applying this to specifically for dfl_uio.
> 
> No one from the uio subsystem reviewing this change is a problem.

Greg will.
> I think this change needs to go to the uio subsystem.

Yeah I've thought about this some for the last few days, maybe it's
easier that way.

Tbh, there's so little code here even if we went with option 3 above
it's probably fairly short. It would set a better prcedent.

Xu, how do you feel about giving that a spin? See if option 3 will be
way more code.

- Moritz


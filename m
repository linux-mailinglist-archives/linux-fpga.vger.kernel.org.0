Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E89B3E03F2
	for <lists+linux-fpga@lfdr.de>; Wed,  4 Aug 2021 17:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238692AbhHDPM4 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 4 Aug 2021 11:12:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:41564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237114AbhHDPM4 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 4 Aug 2021 11:12:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4DC9860EC0;
        Wed,  4 Aug 2021 15:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628089963;
        bh=vadE6yeF5L8S43Jf3zRh5ILASlxnKhbEMTB2btVC0JE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aGtYNNXMxkGcKumW5LilD3DbonuqX/Wic/Cf0ufLxUSSjrDF70iyP8srh5fPHyDUl
         SF3TYHcfqAnF7tJEb+GQNr3PNXqI9io7sY6sBrB1kpUQIwKTveSuO3bSLguhO3SpI1
         aaYbFpQk+4Z1ZMtZoMMi6fC/6gvDCIgohHKFTZ6A=
Date:   Wed, 4 Aug 2021 17:12:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     Russ Weight <russell.h.weight@intel.com>,
        Tom Rix <trix@redhat.com>, linux-fpga@vger.kernel.org,
        moritzf@google.com
Subject: Re: [PATCH 02/12] fpga: sec-mgr: enable secure updates
Message-ID: <YQquaUQCb0hIJmre@kroah.com>
References: <20210517023200.52707-3-mdf@kernel.org>
 <YKH/6xQ7bEwJzEsM@kroah.com>
 <5d0552ce-d2bd-cca1-006e-8f11991fd378@intel.com>
 <f3d474d2-f85d-4759-75b5-84af64fe5b3c@intel.com>
 <YQPgFn/z024U06HJ@kroah.com>
 <85cd4801-ca1f-4482-6999-3d2e648b24e5@intel.com>
 <YQjY+KL59m51kucV@kroah.com>
 <3ba35b3c-3c85-394b-f404-130968587a6f@intel.com>
 <YQpDySXy0ASM5u9y@kroah.com>
 <YQqrGvwkf6bJ/5in@archbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQqrGvwkf6bJ/5in@archbook>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, Aug 04, 2021 at 07:58:34AM -0700, Moritz Fischer wrote:
> On Wed, Aug 04, 2021 at 09:37:45AM +0200, Greg KH wrote:
> > On Tue, Aug 03, 2021 at 12:02:24PM -0700, Russ Weight wrote:
> > > 
> > > 
> > > On 8/2/21 10:49 PM, Greg KH wrote:
> > > >> If the request_firmware() implementation is not acceptable, then would
> > > >> you agree that an IOCTL implementation is our best option?
> > > > There is no difference in the end between using an ioctl, or a sysfs
> > > > file, to provide the filename of your firmware, don't get hung up on
> > > > that.
> > > 
> > > I meant to suggest that passing file data (not a filename) through an
> > > IOCTL might be better for this use case than trying to use request_firmware.
> > > We have to, somehow, allow the user to point us to the desired image
> > > data (which could be a root-entry-hash, or an FPGA image). We can't
> > > really use a fixed filename modified by device version as many of
> > > the devices do.
> > 
> > Ah, yes, a "normal" write command might be best for this as that can be
> > properly containerized and controlled.
> > 
> > > > By providing a "filename", you are going around all of the namespace and
> > > > other "container" protection that the kernel provides, and allowing
> > > > processes to potentially load files that are normally outside of their
> > > > scope to the hardware.  If you are willing to allow that security
> > > > "escape", wonderful, but you better document the heck out of it and
> > > > explain why this is allowed for your special hardware and use case.
> > > >
> > > > As you are expecting this to work "in the cloud", I do not think that
> > > > the operators of such hardware are really going to be all that happy to
> > > > see this type of interface given these reasons.
> > > >
> > > > What is wrong with the current fpga firmware api that somehow is lacking
> > > > for your special hardware, that other devices do not have to worry
> > > > about?
> > > The existing framework wants to update the live image in the FPGA,
> > > whereas for this device, we are passing signed data to BMC firmware
> > > which will store it in FLASH to be loaded on a subsequent boot of
> > > the card.
> > > 
> > > The existing framework needs to manage FPGA state, whereas for this
> > > device, it is just a transfer of signed data. We also have to handle
> > > a total transfer/authentication time of up to 45 minutes, so we are
> > > using a kernel worker thread for the update.
> > > 
> > > Perhaps the name, fpga security manager, is wrong? Maybe something
> > > like fpga_sec_image_xfer is better?
> > 
> > It does not sound like this has anything to do with "security", and
> > rather is just a normal firmware upload, so "fpga_image_upload()"
> > perhaps?
> 
> I had originally suggested 'load' and 'persist' or 'load' and 'update or
> something of that sort.
> 
> Taking one step back, maybe the case could be made for a generic
> 'persistent firmware' update framework that addresses use-cases that
> require updating firmware that may take extended periods of time.

There should not be a problem with using the existing firmware layer for
images that take long periods of time, as long as you are not wanting to
see any potential progress :)

So how about just adding anything missing to the existing firmware
subsystem.  It's attempting to handle all use cases already, if it is
missing one, no harm in adding more options there...

thanks,

greg k-h

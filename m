Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B85DC44344D
	for <lists+linux-fpga@lfdr.de>; Tue,  2 Nov 2021 18:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234759AbhKBRJT (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 2 Nov 2021 13:09:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:43192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229806AbhKBRJS (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 2 Nov 2021 13:09:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 02C7A60EB9;
        Tue,  2 Nov 2021 17:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1635872803;
        bh=+BMtRaPSNnNH8Mb/Ej1z7kOz1KvdUFxZVgerMSQbnGY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qJbUlL7G2JROb0rbO7Tmu9pUQr95lpq4O24xBE+4vgqqqg67AcPNj9NPIk9tuUZTC
         iL70U2yAo0JA38Fisb98aJhQT33BPjUL/Oebs30p8Vxu1oW+ittzrbZvY1JjjqqJ8b
         8eyrH4ly/lRnKByot4dwUALERzq952XZeAk/ANvM=
Date:   Tue, 2 Nov 2021 18:06:30 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     Moritz Fischer <mdf@kernel.org>, Tom Rix <trix@redhat.com>,
        linux-fpga@vger.kernel.org, moritzf@google.com
Subject: Re: [PATCH 02/12] fpga: sec-mgr: enable secure updates
Message-ID: <YYFwFleJXqqc9ZW/@kroah.com>
References: <5d0552ce-d2bd-cca1-006e-8f11991fd378@intel.com>
 <f3d474d2-f85d-4759-75b5-84af64fe5b3c@intel.com>
 <YQPgFn/z024U06HJ@kroah.com>
 <85cd4801-ca1f-4482-6999-3d2e648b24e5@intel.com>
 <YQjY+KL59m51kucV@kroah.com>
 <3ba35b3c-3c85-394b-f404-130968587a6f@intel.com>
 <YQpDySXy0ASM5u9y@kroah.com>
 <YQqrGvwkf6bJ/5in@archbook>
 <YQquaUQCb0hIJmre@kroah.com>
 <62ae6249-8561-7e85-2aa8-3dd49646180a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <62ae6249-8561-7e85-2aa8-3dd49646180a@intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Nov 02, 2021 at 09:25:10AM -0700, Russ Weight wrote:
> 
> 
> On 8/4/21 8:12 AM, Greg KH wrote:
> > On Wed, Aug 04, 2021 at 07:58:34AM -0700, Moritz Fischer wrote:
> >> On Wed, Aug 04, 2021 at 09:37:45AM +0200, Greg KH wrote:
> >>> On Tue, Aug 03, 2021 at 12:02:24PM -0700, Russ Weight wrote:
> >>>>
> >>>> On 8/2/21 10:49 PM, Greg KH wrote:
> >>>>>> If the request_firmware() implementation is not acceptable, then would
> >>>>>> you agree that an IOCTL implementation is our best option?
> >>>>> There is no difference in the end between using an ioctl, or a sysfs
> >>>>> file, to provide the filename of your firmware, don't get hung up on
> >>>>> that.
> >>>> I meant to suggest that passing file data (not a filename) through an
> >>>> IOCTL might be better for this use case than trying to use request_firmware.
> >>>> We have to, somehow, allow the user to point us to the desired image
> >>>> data (which could be a root-entry-hash, or an FPGA image). We can't
> >>>> really use a fixed filename modified by device version as many of
> >>>> the devices do.
> >>> Ah, yes, a "normal" write command might be best for this as that can be
> >>> properly containerized and controlled.
> >>>
> >>>>> By providing a "filename", you are going around all of the namespace and
> >>>>> other "container" protection that the kernel provides, and allowing
> >>>>> processes to potentially load files that are normally outside of their
> >>>>> scope to the hardware.  If you are willing to allow that security
> >>>>> "escape", wonderful, but you better document the heck out of it and
> >>>>> explain why this is allowed for your special hardware and use case.
> >>>>>
> >>>>> As you are expecting this to work "in the cloud", I do not think that
> >>>>> the operators of such hardware are really going to be all that happy to
> >>>>> see this type of interface given these reasons.
> >>>>>
> >>>>> What is wrong with the current fpga firmware api that somehow is lacking
> >>>>> for your special hardware, that other devices do not have to worry
> >>>>> about?
> >>>> The existing framework wants to update the live image in the FPGA,
> >>>> whereas for this device, we are passing signed data to BMC firmware
> >>>> which will store it in FLASH to be loaded on a subsequent boot of
> >>>> the card.
> >>>>
> >>>> The existing framework needs to manage FPGA state, whereas for this
> >>>> device, it is just a transfer of signed data. We also have to handle
> >>>> a total transfer/authentication time of up to 45 minutes, so we are
> >>>> using a kernel worker thread for the update.
> >>>>
> >>>> Perhaps the name, fpga security manager, is wrong? Maybe something
> >>>> like fpga_sec_image_xfer is better?
> >>> It does not sound like this has anything to do with "security", and
> >>> rather is just a normal firmware upload, so "fpga_image_upload()"
> >>> perhaps?
> >> I had originally suggested 'load' and 'persist' or 'load' and 'update or
> >> something of that sort.
> >>
> >> Taking one step back, maybe the case could be made for a generic
> >> 'persistent firmware' update framework that addresses use-cases that
> >> require updating firmware that may take extended periods of time.
> > There should not be a problem with using the existing firmware layer for
> > images that take long periods of time, as long as you are not wanting to
> > see any potential progress :)
> >
> > So how about just adding anything missing to the existing firmware
> > subsystem.  It's attempting to handle all use cases already, if it is
> > missing one, no harm in adding more options there...
> Hi Greg,
> 
> We have had a lot of internal (to Intel) discussion about how to
> organize the support for uploading FPGA images. It would be helpful
> to know which of the following two options you find the least
> disturbing :-)
> 
> Background: We are uploading signed, self-describing images that are
> authenticated and dispositioned by the Card BMC. These could result
> in FLASH updates for FPGA images, BMC images, firmware, or security
> keys.  They could also result in a temporary authentication
> certificate being loaded into RAM as part of a multi-step key
> provisioning process.
> 
> Options:
> (a) A single API that facilitates the upload of a data stream
> without analyzing the stream contents, relying on the lower-level
> driver and/or HW to accept or reject the data.

That is the firmware api we have today, please use that like all other
drivers should be using.

> (b) Multiple, targeted APIs (e.g. IOCTL_FPGA_IMAGE_UPDATE,
> IOCTL_BMC_IMAGE_UPDATE, IOCTL_KEY_UPDATE, IOCTL_KEY_CANCEL) that
> each interpret the stream type and reject them if they don't
> correspond to the API target.

Please no, do not make a zillion "custom" ioctls.  That way lies
madness.  Will you want to maintain them all for the next 30+ years?

thanks,

greg k-h

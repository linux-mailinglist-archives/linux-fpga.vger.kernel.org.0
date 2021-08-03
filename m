Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3A133DE658
	for <lists+linux-fpga@lfdr.de>; Tue,  3 Aug 2021 07:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233839AbhHCFt5 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 3 Aug 2021 01:49:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:49096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230096AbhHCFt5 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 3 Aug 2021 01:49:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E8F1260EFF;
        Tue,  3 Aug 2021 05:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1627969786;
        bh=Cg8xz/crrt/8YWgnaKBzCWkG7N+IBq0I/sFmVvCnXU0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zvyUcpYsRNbzkaj7u+PMwtuNL7xHaBYrMYUgDfr4K+YNoMt7ZmPkt5jrUJoiaEeg4
         nKnR5JO+m6j+na1wONJvYxWNVEfoTr4sD8ya/zXGTl37nEWUmJU4jCVEq9x9mlyf1L
         +MffmhSojzuGymlszigDcUiz8se3ZqAaTSu5RT4c=
Date:   Tue, 3 Aug 2021 07:49:44 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>,
        linux-fpga@vger.kernel.org, moritzf@google.com
Subject: Re: [PATCH 02/12] fpga: sec-mgr: enable secure updates
Message-ID: <YQjY+KL59m51kucV@kroah.com>
References: <20210517023200.52707-1-mdf@kernel.org>
 <20210517023200.52707-3-mdf@kernel.org>
 <YKH/6xQ7bEwJzEsM@kroah.com>
 <5d0552ce-d2bd-cca1-006e-8f11991fd378@intel.com>
 <f3d474d2-f85d-4759-75b5-84af64fe5b3c@intel.com>
 <YQPgFn/z024U06HJ@kroah.com>
 <85cd4801-ca1f-4482-6999-3d2e648b24e5@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85cd4801-ca1f-4482-6999-3d2e648b24e5@intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Aug 02, 2021 at 11:31:47AM -0700, Russ Weight wrote:
> 
> 
> On 7/30/21 4:18 AM, Greg KH wrote:
> > On Thu, Jul 29, 2021 at 06:23:12PM -0700, Russ Weight wrote:
> >>
> >> On 5/17/21 12:37 PM, Russ Weight wrote:
> >>> On 5/16/21 10:32 PM, Greg KH wrote:
> >>>> On Sun, May 16, 2021 at 07:31:50PM -0700, Moritz Fischer wrote:
> >>>>> From: Russ Weight <russell.h.weight@intel.com>
> >>>>>
> >>>>> Extend the FPGA Security Manager class driver to
> >>>>> include an update/filename sysfs node that can be used
> >>>>> to initiate a secure update.  The filename of a secure
> >>>>> update file (BMC image, FPGA image, Root Entry Hash image,
> >>>>> or Code Signing Key cancellation image) can be written to
> >>>>> this sysfs entry to cause a secure update to occur.
> >>>> Why is userspace responsible for triggering this?  Passing a "filename"
> >>>> into the kernel and having it do something with it is ripe for major
> >>>> problems, please do not.
> >>>>
> >>> I am using the "request_firmware" framework, which accepts a filename
> >>> and finds the firmware file under /lib/firmware.
> >>>
> >>> Is this not an acceptable use for request_firmware?
> >>>
> >>> - Russ
> >> Hi Greg,
> >>
> >> The dev_release fixes that you asked for in the FPGA Manager, Bridge, and
> >> Region code are almost complete. I'm trying to get back to the FPGA
> >> security manager patch set. Your previous comments challenged some basic
> >> assumptions. If it is OK, I would like to get some clarity before I rework
> >> the patches.
> > Note, I do not have the time, nor the inclination, to help your company
> > out with design reviews at this point in time.  If you have questions
> > about this, please discuss it with the open source managers at Intel,
> > they know the current situation quite well.
> >
> > I am glad to review patches that have gone through the proper internal
> > Intel patch review process and then sent out to the community.
> 
> For what it is worth, these patches _were_ reviewed internally before
> they were submitted to the public list. The first public submission
> (Sep 2020) included review tags. I was asked to remove them and let
> them be added back during the public review:
> 
> https://marc.info/?l=linux-fpga&m=159926670526828&w=2
> 
> Unfortunately, Intel review tags were not volunteered during the
> public review, and it didn't occur to me to solicit the tags before
> the patches were forwarded on to you by Moritz.
> 
> Most notably, Yilun and Hao contributed to the review both internally
> and publicly. They are both listed in the MAINTAINERS file:
> 
> Xu Yilun <yilun.xu@intel.com>
> Wu Hao <hao.wu@intel.com>
> 
> All issues/comments were resolved before the patches were sent to you.

That's fine and wonderful, but not what I was talking about here at all.

Again, I am willing to review patches, but not take the time out to
comment on general design decisions like this for the reasons stated in
the past.

> > That being said, I will make one comment on your questions below:
> >
> >> (1) request_firmware(). We had assumed that making use of the existing
> >> request_firmware() would be preferred. This requires providing a filename
> >> under /lib/firmware to the framework. You commented (above): "Passing a
> >> 'filename' into the kernel and having it do something with it is ripe for
> >> problems, please do not." Unless you have additional comments on this, I
> >> will plan to NOT use the request_firmware framework.
> > request_firmware() should always be used for requesting firmware for a
> > device.  Having an api where you write a random filename to a sysfs file
> > and have that loaded by the kernel seems ripe for disaster though, I can
> > not think of any other in-kernel user of the firmware api that does
> > this.  Or are there examples that I have just missed?
> 
> I found an instance of a driver that allows the firmware filename
> (under /lib/firmware) to be changed via sysfs:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/ABI/testing/sysfs-class-mic#n107
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/ABI/testing/sysfs-class-mic#n117

Ah, another Intel driver wanting to do bad things, nice example :)

> I get why it seems dangerous to provide a /lib/firmware filename via
> sysfs and have the system automatically transfer that data to a device.
> I'm just trying to figure out if there is a preferred/less-dangerous
> way to do what we are trying to do.
> 
> Our objective is to allow the user to provide a new, signed FPGA image
> that can be loaded on the fly (think cloud environment). The PCIe FPGA
> card authenticates the image data with encryption keys; the host-side
> software is not trusted by the device. So, other than checking the data
> size, host software just passes the data through.
> 
> I think our usage is firmware-like, but it doesn't exactly fit the
> current usage of request_firmware(). The firmware filename isn't
> hardwired into the driver and the image isn't loaded at probe time.
> 
> If the request_firmware() implementation is not acceptable, then would
> you agree that an IOCTL implementation is our best option?

There is no difference in the end between using an ioctl, or a sysfs
file, to provide the filename of your firmware, don't get hung up on
that.

By providing a "filename", you are going around all of the namespace and
other "container" protection that the kernel provides, and allowing
processes to potentially load files that are normally outside of their
scope to the hardware.  If you are willing to allow that security
"escape", wonderful, but you better document the heck out of it and
explain why this is allowed for your special hardware and use case.

As you are expecting this to work "in the cloud", I do not think that
the operators of such hardware are really going to be all that happy to
see this type of interface given these reasons.

What is wrong with the current fpga firmware api that somehow is lacking
for your special hardware, that other devices do not have to worry
about?

thanks,

greg k-h

Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 068513DB7AA
	for <lists+linux-fpga@lfdr.de>; Fri, 30 Jul 2021 13:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238403AbhG3LSy (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 30 Jul 2021 07:18:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:35344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230157AbhG3LSy (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 30 Jul 2021 07:18:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5923260F48;
        Fri, 30 Jul 2021 11:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1627643928;
        bh=AZxwPyppExrB/z7d2++YjFvcn5ph6Qq45oTx0RCRNow=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wpEefXegDCZ8MLvMN2ilv/zzwWzm60qSj8uvPz32rHbmlW16IGN4CSnNhX3XyHmSf
         IrrNhNxwT5XsGs99/HcbLLO2XPJUD3ehqZVodijM79VLAKjfp+X5FyK87IdNXGnbKY
         RyQ60BAACdMJu+slLGJxo1Zbntz+3IMBCGmXXOoQ=
Date:   Fri, 30 Jul 2021 13:18:46 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>,
        linux-fpga@vger.kernel.org, moritzf@google.com
Subject: Re: [PATCH 02/12] fpga: sec-mgr: enable secure updates
Message-ID: <YQPgFn/z024U06HJ@kroah.com>
References: <20210517023200.52707-1-mdf@kernel.org>
 <20210517023200.52707-3-mdf@kernel.org>
 <YKH/6xQ7bEwJzEsM@kroah.com>
 <5d0552ce-d2bd-cca1-006e-8f11991fd378@intel.com>
 <f3d474d2-f85d-4759-75b5-84af64fe5b3c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3d474d2-f85d-4759-75b5-84af64fe5b3c@intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, Jul 29, 2021 at 06:23:12PM -0700, Russ Weight wrote:
> 
> 
> On 5/17/21 12:37 PM, Russ Weight wrote:
> > On 5/16/21 10:32 PM, Greg KH wrote:
> >> On Sun, May 16, 2021 at 07:31:50PM -0700, Moritz Fischer wrote:
> >>> From: Russ Weight <russell.h.weight@intel.com>
> >>>
> >>> Extend the FPGA Security Manager class driver to
> >>> include an update/filename sysfs node that can be used
> >>> to initiate a secure update.  The filename of a secure
> >>> update file (BMC image, FPGA image, Root Entry Hash image,
> >>> or Code Signing Key cancellation image) can be written to
> >>> this sysfs entry to cause a secure update to occur.
> >> Why is userspace responsible for triggering this?  Passing a "filename"
> >> into the kernel and having it do something with it is ripe for major
> >> problems, please do not.
> >>
> > I am using the "request_firmware" framework, which accepts a filename
> > and finds the firmware file under /lib/firmware.
> >
> > Is this not an acceptable use for request_firmware?
> >
> > - Russ
> 
> Hi Greg,
> 
> The dev_release fixes that you asked for in the FPGA Manager, Bridge, and
> Region code are almost complete. I'm trying to get back to the FPGA
> security manager patch set. Your previous comments challenged some basic
> assumptions. If it is OK, I would like to get some clarity before I rework
> the patches.

Note, I do not have the time, nor the inclination, to help your company
out with design reviews at this point in time.  If you have questions
about this, please discuss it with the open source managers at Intel,
they know the current situation quite well.

I am glad to review patches that have gone through the proper internal
Intel patch review process and then sent out to the community.

That being said, I will make one comment on your questions below:

> (1) request_firmware(). We had assumed that making use of the existing
> request_firmware() would be preferred. This requires providing a filename
> under /lib/firmware to the framework. You commented (above): "Passing a
> 'filename' into the kernel and having it do something with it is ripe for
> problems, please do not." Unless you have additional comments on this, I
> will plan to NOT use the request_firmware framework.

request_firmware() should always be used for requesting firmware for a
device.  Having an api where you write a random filename to a sysfs file
and have that loaded by the kernel seems ripe for disaster though, I can
not think of any other in-kernel user of the firmware api that does
this.  Or are there examples that I have just missed?

thanks,

greg k-h

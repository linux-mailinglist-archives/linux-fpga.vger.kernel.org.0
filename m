Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED1DD15A9ED
	for <lists+linux-fpga@lfdr.de>; Wed, 12 Feb 2020 14:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbgBLNUr (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 12 Feb 2020 08:20:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:47150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727962AbgBLNUq (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 12 Feb 2020 08:20:46 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE8CD2086A;
        Wed, 12 Feb 2020 13:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581513645;
        bh=2dOsmB0o98+qf56HpgUqHTo4+gRYS1ahpt6eAMncra4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lYbU7znJzBmUWV5YMM6MB1suNCzjbbi9Z7lTuEBYM22xy3LGxKs7oCc39Ab16ThNh
         /iOw34z7VSNXP27IaEEVmYGtDumjL8kfq4MBHshQKaLoxEY+PSK089KW3MwLpH7OHs
         gDITsQ+Sq2dK+yMDygicQ3N4TY65hMhBtsmtXwKM=
Date:   Wed, 12 Feb 2020 05:20:45 -0800
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wu Hao <hao.wu@intel.com>
Cc:     Will Deacon <will@kernel.org>, mdf@kernel.org,
        mark.rutland@arm.com, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        atull@kernel.org, yilun.xu@intel.com,
        Luwei Kang <luwei.kang@intel.com>
Subject: Re: [PATCH v7 2/2] fpga: dfl: fme: add performance reporting support
Message-ID: <20200212132045.GC1789899@kroah.com>
References: <1581306469-22629-1-git-send-email-hao.wu@intel.com>
 <1581306469-22629-3-git-send-email-hao.wu@intel.com>
 <20200210163400.GA21900@willie-the-truck>
 <20200212031929.GB5645@hao-dev>
 <20200212053035.GA382718@kroah.com>
 <20200212100211.GA10436@hao-dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212100211.GA10436@hao-dev>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, Feb 12, 2020 at 06:02:11PM +0800, Wu Hao wrote:
> On Tue, Feb 11, 2020 at 09:30:35PM -0800, Greg KH wrote:
> > On Wed, Feb 12, 2020 at 11:19:29AM +0800, Wu Hao wrote:
> > > On Mon, Feb 10, 2020 at 04:34:01PM +0000, Will Deacon wrote:
> > > > Hi,
> > > > 
> > > > On Mon, Feb 10, 2020 at 11:47:49AM +0800, Wu Hao wrote:
> > > > > This patch adds support for performance reporting private feature
> > > > > for FPGA Management Engine (FME). Now it supports several different
> > > > > performance counters, including 'basic', 'cache', 'fabric', 'vtd'
> > > > > and 'vtd_sip'. It allows user to use standard linux tools to access
> > > > > these performance counters.
> > > > 
> > > > I had a quick look at this, and it mostly looks alright to me. Just a few
> > > > high-level comments/questions:
> > > 
> > > Hi Will
> > > 
> > > Thanks a lot for the review! :)
> > > 
> > > > 
> > > >   - I would still prefer for the PMU drivers to live under drivers/perf/
> > > 
> > > Hm.. one possible way is to create a platform device, and introduce a new
> > > platform device driver under drivers/perf/.
> > 
> > No, do not abuse platform drivers, you have a real device, use it.
> 
> Sure, thanks for the comments. Then I don't have any other idea to move code to
> drivers/perf/ directory, so probably only can live with current code.

The location of the file in the kernel tree has no bearing on if you use
a platform device, a USB device, or a PCI device.  It is just a location
of a file.

You are interacting with the perf api as the driver's primary userspace
api, so put the driver into the drivers/perf/ directory.  That's all
that Will is asking you to do here.

greg k-h

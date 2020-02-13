Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD3515B798
	for <lists+linux-fpga@lfdr.de>; Thu, 13 Feb 2020 04:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729440AbgBMDMq (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 12 Feb 2020 22:12:46 -0500
Received: from mga01.intel.com ([192.55.52.88]:16902 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729378AbgBMDMp (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 12 Feb 2020 22:12:45 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2020 19:12:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,434,1574150400"; 
   d="scan'208";a="313601327"
Received: from hao-dev.bj.intel.com (HELO localhost) ([10.238.157.65])
  by orsmga001.jf.intel.com with ESMTP; 12 Feb 2020 19:12:42 -0800
Date:   Thu, 13 Feb 2020 10:51:59 +0800
From:   Wu Hao <hao.wu@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Will Deacon <will@kernel.org>, mdf@kernel.org,
        mark.rutland@arm.com, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        atull@kernel.org, yilun.xu@intel.com,
        Luwei Kang <luwei.kang@intel.com>
Subject: Re: [PATCH v7 2/2] fpga: dfl: fme: add performance reporting support
Message-ID: <20200213025159.GA11784@hao-dev>
References: <1581306469-22629-1-git-send-email-hao.wu@intel.com>
 <1581306469-22629-3-git-send-email-hao.wu@intel.com>
 <20200210163400.GA21900@willie-the-truck>
 <20200212031929.GB5645@hao-dev>
 <20200212053035.GA382718@kroah.com>
 <20200212100211.GA10436@hao-dev>
 <20200212132045.GC1789899@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212132045.GC1789899@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, Feb 12, 2020 at 05:20:45AM -0800, Greg KH wrote:
> On Wed, Feb 12, 2020 at 06:02:11PM +0800, Wu Hao wrote:
> > On Tue, Feb 11, 2020 at 09:30:35PM -0800, Greg KH wrote:
> > > On Wed, Feb 12, 2020 at 11:19:29AM +0800, Wu Hao wrote:
> > > > On Mon, Feb 10, 2020 at 04:34:01PM +0000, Will Deacon wrote:
> > > > > Hi,
> > > > > 
> > > > > On Mon, Feb 10, 2020 at 11:47:49AM +0800, Wu Hao wrote:
> > > > > > This patch adds support for performance reporting private feature
> > > > > > for FPGA Management Engine (FME). Now it supports several different
> > > > > > performance counters, including 'basic', 'cache', 'fabric', 'vtd'
> > > > > > and 'vtd_sip'. It allows user to use standard linux tools to access
> > > > > > these performance counters.
> > > > > 
> > > > > I had a quick look at this, and it mostly looks alright to me. Just a few
> > > > > high-level comments/questions:
> > > > 
> > > > Hi Will
> > > > 
> > > > Thanks a lot for the review! :)
> > > > 
> > > > > 
> > > > >   - I would still prefer for the PMU drivers to live under drivers/perf/
> > > > 
> > > > Hm.. one possible way is to create a platform device, and introduce a new
> > > > platform device driver under drivers/perf/.
> > > 
> > > No, do not abuse platform drivers, you have a real device, use it.
> > 
> > Sure, thanks for the comments. Then I don't have any other idea to move code to
> > drivers/perf/ directory, so probably only can live with current code.
> 
> The location of the file in the kernel tree has no bearing on if you use
> a platform device, a USB device, or a PCI device.  It is just a location
> of a file.
> 
> You are interacting with the perf api as the driver's primary userspace
> api, so put the driver into the drivers/perf/ directory.  That's all
> that Will is asking you to do here.

Thanks a lot for the patient explanation. : )

Actually this patch only adds a new file to existing fme platform driver, fme
platform driver already has several different types userspace interfaces,
including hwmon, sysfs and etc, so the new perf api is only one of them, as
we can't move the whole fme platform driver into drivers/perf/, we feel that
maybe we should keep that code together with other fme files in drivers/fpga/.

Thanks
Hao

> 
> greg k-h

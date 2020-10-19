Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6893D2921B1
	for <lists+linux-fpga@lfdr.de>; Mon, 19 Oct 2020 06:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbgJSEWQ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 19 Oct 2020 00:22:16 -0400
Received: from mga14.intel.com ([192.55.52.115]:65303 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726829AbgJSEWQ (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 19 Oct 2020 00:22:16 -0400
IronPort-SDR: gB9fCH3xMs096NXojgxhqxE6g7lQLGQdCnrIIBmJwE5MLHOfqYkDoq2ID9CVGR3Zh5Lei6R+oW
 7FoKZtAngqhg==
X-IronPort-AV: E=McAfee;i="6000,8403,9778"; a="166183480"
X-IronPort-AV: E=Sophos;i="5.77,393,1596524400"; 
   d="scan'208";a="166183480"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2020 21:22:13 -0700
IronPort-SDR: MbfntzzDOkBTt66vMeL8cpge34ZUlAD51ktwVXEb124MwqDEmKD9Q6mytHhpFCOq8MygzWh9ES
 JNA+/Fun+0PA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,393,1596524400"; 
   d="scan'208";a="522967712"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by fmsmga005.fm.intel.com with ESMTP; 18 Oct 2020 21:22:12 -0700
Date:   Mon, 19 Oct 2020 12:17:04 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Tom Rix <trix@redhat.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        lgoncalv@redhat.com, hao.wu@intel.com, yilun.xu@intel.com
Subject: Re: [PATCH 0/2] UIO support for dfl devices
Message-ID: <20201019041704.GC16172@yilunxu-OptiPlex-7050>
References: <1602828151-24784-1-git-send-email-yilun.xu@intel.com>
 <3dcc1b4e-d0fd-0586-ea87-eada0c557bed@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3dcc1b4e-d0fd-0586-ea87-eada0c557bed@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, Oct 16, 2020 at 09:40:03AM -0700, Tom Rix wrote:
> 
> On 10/15/20 11:02 PM, Xu Yilun wrote:
> > This patchset supports some dfl device drivers written in userspace.
> >
> > The usage is like:
> >
> >  # echo dfl_dev.1 > /sys/bus/dfl/drivers/<kernel driver>/unbind
> >  # echo dfl-uio-pdev > /sys/bus/dfl/devices/dfl_dev.1/driver_override
> >  # echo dfl_dev.1 > /sys/bus/dfl/drivers_probe
> >
> >
> > Xu Yilun (2):
> >   fpga: dfl: add driver_override support
> >   fpga: dfl: add the userspace I/O device support for DFL devices
> >
> >  Documentation/ABI/testing/sysfs-bus-dfl | 28 +++++++++--
> >  drivers/fpga/Kconfig                    | 10 ++++
> >  drivers/fpga/Makefile                   |  1 +
> >  drivers/fpga/dfl-uio-pdev.c             | 83 +++++++++++++++++++++++++++++++++
> >  drivers/fpga/dfl.c                      | 54 ++++++++++++++++++++-
> >  include/linux/dfl.h                     |  2 +
> >  6 files changed, 173 insertions(+), 5 deletions(-)
> >  create mode 100644 drivers/fpga/dfl-uio-pdev.c
> 
> This is a neat new feature.
> 
> Should something be added to Documentation/fpga/dfl.rst ?

Yes, I could add the Doc.

> 
> Overall, patchset looks good.
> 
> Tom

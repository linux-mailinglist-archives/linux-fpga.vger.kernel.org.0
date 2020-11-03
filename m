Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B07D2A4364
	for <lists+linux-fpga@lfdr.de>; Tue,  3 Nov 2020 11:48:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgKCKsr (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 3 Nov 2020 05:48:47 -0500
Received: from mga17.intel.com ([192.55.52.151]:14562 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726058AbgKCKsr (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 3 Nov 2020 05:48:47 -0500
IronPort-SDR: sYtBw8T/RRYhK7ARIwMvaZejHqWCscYq5lYWnypvXG4WJPqriGF29hfVuwfntPq/uolJnd5A1y
 J5fw3Rw4wrkA==
X-IronPort-AV: E=McAfee;i="6000,8403,9793"; a="148888103"
X-IronPort-AV: E=Sophos;i="5.77,447,1596524400"; 
   d="scan'208";a="148888103"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2020 02:48:46 -0800
IronPort-SDR: PABlOJAwUL/rLPUczyCimRdDpblJiQfSzGDl86cli7ZGX34EosrJrcGn+iEiMaqvyU1o1JhzIr
 V86ZjcKGujfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,447,1596524400"; 
   d="scan'208";a="470749591"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by orsmga004.jf.intel.com with ESMTP; 03 Nov 2020 02:48:45 -0800
Date:   Tue, 3 Nov 2020 18:43:17 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        Tom Rix <trix@redhat.com>, Wu Hao <hao.wu@intel.com>,
        yilun.xu@intel.com
Subject: Re: [PATCH 4/4] fpga: dfl: move dfl bus related APIs to
  include/linux/dfl.h
Message-ID: <20201103104317.GB23473@yilunxu-OptiPlex-7050>
References: <20201103072104.12361-1-mdf@kernel.org>
 <20201103072104.12361-5-mdf@kernel.org>
 <20201103074307.GD2500572@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103074307.GD2500572@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Nov 03, 2020 at 08:43:07AM +0100, Greg KH wrote:
> On Mon, Nov 02, 2020 at 11:21:04PM -0800, Moritz Fischer wrote:
> > From: Xu Yilun <yilun.xu@intel.com>
> > 
> > Now the dfl drivers could be made as independent modules and put in
> > different folders according to their functionalities. In order for
> > scattered dfl device drivers to include dfl bus APIs, move the
> > dfl bus APIs to a new header file in the public folder.
> > 
> > [mdf@kernel.org: Fixed up header guards to match filename]
> > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > Reviewed-by: Tom Rix <trix@redhat.com>
> > Acked-by: Wu Hao <hao.wu@intel.com>
> > Signed-off-by: Moritz Fischer <mdf@kernel.org>
> > ---
> >  MAINTAINERS         |  1 +
> >  drivers/fpga/dfl.c  |  1 +
> >  drivers/fpga/dfl.h  | 72 -------------------------------------
> >  include/linux/dfl.h | 86 +++++++++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 88 insertions(+), 72 deletions(-)
> >  create mode 100644 include/linux/dfl.h
> 
> Why move this if there is no in-kernel users?

The DFL emif driver in driver/memory is the first user, see:

https://lore.kernel.org/linux-fpga/20201027105545.GB20676@kozik-lap/T/#m6b72f043ecf266c6305bf43db88cddcaf3f9f73d

It is not in this patchset, but the memory controller maintainer is already
acked this patch.

Thanks,
Yilun

> 
> greg k-h

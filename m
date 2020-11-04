Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77D092A5BD9
	for <lists+linux-fpga@lfdr.de>; Wed,  4 Nov 2020 02:25:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729858AbgKDBZB (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 3 Nov 2020 20:25:01 -0500
Received: from mga14.intel.com ([192.55.52.115]:64432 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729246AbgKDBZA (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 3 Nov 2020 20:25:00 -0500
IronPort-SDR: ZJoeo41UYP2vFJZQuXUKTpdVyd4yV65t5nLm6bMolRhwBJ2bw/g5CH15M/UC1CGTJmCOo0yHEA
 cMoq+wp9S46Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9794"; a="168364494"
X-IronPort-AV: E=Sophos;i="5.77,449,1596524400"; 
   d="scan'208";a="168364494"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2020 17:25:00 -0800
IronPort-SDR: 4lhc+gr/MxSQUiCkMfV+zmEKzxysAtC3JOS+VPFrL/KD+6kMDKa+VajYAE8+MvG9BVON0/RDwB
 fbqb2aDAMMtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,449,1596524400"; 
   d="scan'208";a="320631856"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by orsmga003.jf.intel.com with ESMTP; 03 Nov 2020 17:24:58 -0800
Date:   Wed, 4 Nov 2020 09:19:29 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        Tom Rix <trix@redhat.com>, Wu Hao <hao.wu@intel.com>,
        yilun.xu@intel.com
Subject: Re: [PATCH 4/4] fpga: dfl: move dfl bus related APIs to
  include/linux/dfl.h
Message-ID: <20201104011929.GD10673@yilunxu-OptiPlex-7050>
References: <20201103072104.12361-1-mdf@kernel.org>
 <20201103072104.12361-5-mdf@kernel.org>
 <20201103074307.GD2500572@kroah.com>
 <20201103104317.GB23473@yilunxu-OptiPlex-7050>
 <20201103110817.GA2680561@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103110817.GA2680561@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Nov 03, 2020 at 12:08:17PM +0100, Greg KH wrote:
> On Tue, Nov 03, 2020 at 06:43:17PM +0800, Xu Yilun wrote:
> > On Tue, Nov 03, 2020 at 08:43:07AM +0100, Greg KH wrote:
> > > On Mon, Nov 02, 2020 at 11:21:04PM -0800, Moritz Fischer wrote:
> > > > From: Xu Yilun <yilun.xu@intel.com>
> > > > 
> > > > Now the dfl drivers could be made as independent modules and put in
> > > > different folders according to their functionalities. In order for
> > > > scattered dfl device drivers to include dfl bus APIs, move the
> > > > dfl bus APIs to a new header file in the public folder.
> > > > 
> > > > [mdf@kernel.org: Fixed up header guards to match filename]
> > > > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > > > Reviewed-by: Tom Rix <trix@redhat.com>
> > > > Acked-by: Wu Hao <hao.wu@intel.com>
> > > > Signed-off-by: Moritz Fischer <mdf@kernel.org>
> > > > ---
> > > >  MAINTAINERS         |  1 +
> > > >  drivers/fpga/dfl.c  |  1 +
> > > >  drivers/fpga/dfl.h  | 72 -------------------------------------
> > > >  include/linux/dfl.h | 86 +++++++++++++++++++++++++++++++++++++++++++++
> > > >  4 files changed, 88 insertions(+), 72 deletions(-)
> > > >  create mode 100644 include/linux/dfl.h
> > > 
> > > Why move this if there is no in-kernel users?
> > 
> > The DFL emif driver in driver/memory is the first user, see:
> > 
> > https://lore.kernel.org/linux-fpga/20201027105545.GB20676@kozik-lap/T/#m6b72f043ecf266c6305bf43db88cddcaf3f9f73d
> > 
> > It is not in this patchset, but the memory controller maintainer is already
> > acked this patch.
> 
> How am I, or anyone else, supposed to know this?
> 
> Again, don't include patches that are not actually used, that's a huge
> red flag to any reviewer and it just makes them grumpy and sad and
> less-likely to ever want to review code from the submitter again...

Sorry, I didn't explain it clearly.

The DFL emif driver was in this patchset before v11. All the maintainers
are on the maillist, see the v10:
https://lore.kernel.org/linux-fpga/20201015162812.GA251058@epycbox.lan/T/#m64f61e205ed0ea1fd65e30e24bea55da40f8881d

In v10, the first 4 patches are DFL bus related, the same as you can see
in this pull request. The 5th is the dfl-n3000-nios driver and the 6th is
the dfl-emif, they are the in-kernel users of dfl bus.

In v11, I didn't include the first 4 patches because Moritz has already
queued them to his branch, I just send the remaining ones in order to
save time for the reviewers.

Thanks,
Yilun

> 
> {sigh}
> 
> greg k-h

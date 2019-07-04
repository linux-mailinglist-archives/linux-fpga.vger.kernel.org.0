Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA295F74E
	for <lists+linux-fpga@lfdr.de>; Thu,  4 Jul 2019 13:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbfGDLp7 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 4 Jul 2019 07:45:59 -0400
Received: from mga01.intel.com ([192.55.52.88]:2275 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727436AbfGDLp7 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 4 Jul 2019 07:45:59 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jul 2019 04:45:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,450,1557212400"; 
   d="scan'208";a="339583474"
Received: from hao-dev.bj.intel.com (HELO localhost) ([10.238.157.65])
  by orsmga005.jf.intel.com with ESMTP; 04 Jul 2019 04:45:56 -0700
Date:   Thu, 4 Jul 2019 19:29:13 +0800
From:   Wu Hao <hao.wu@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Zhang Yi Z <yi.z.zhang@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Alan Tull <atull@kernel.org>
Subject: Re: [PATCH 06/15] fpga: dfl: fme: add
 DFL_FPGA_FME_PORT_RELEASE/ASSIGN ioctl support.
Message-ID: <20190704112913.GA24884@hao-dev>
References: <20190628004951.6202-1-mdf@kernel.org>
 <20190628004951.6202-7-mdf@kernel.org>
 <20190703180753.GA24723@kroah.com>
 <20190703233058.GA15825@hao-dev>
 <20190704053927.GB347@kroah.com>
 <20190704063106.GA24777@hao-dev>
 <20190704082013.GE6438@kroah.com>
 <20190704085855.GB7391@hao-dev>
 <20190704110449.GC1404@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190704110449.GC1404@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, Jul 04, 2019 at 01:04:49PM +0200, Greg KH wrote:
> On Thu, Jul 04, 2019 at 04:58:55PM +0800, Wu Hao wrote:
> > > > Hope things could be more clear now. :)
> > > 
> > > That's nice for the vfio stuff, but you are just a "normal" driver here.
> > > You want an ioctl that just does one thing, no arguments, no flags, no
> > > anything.  No need for a size argument then at all.  These ioctls don't
> > > even need a structure for them!
> > > 
> > > Don't try to be fancy, it's not needed, it's not like you are running
> > > out of ioctl space...
> > 
> > Thanks a lot for the comments and suggestions.
> > 
> > That's true, it's a "normal" driver, maybe I overly considered the
> > extensibility of it. OK, Let me rework this patch to remove argsz from
> > these two ioctls.
> > 
> > What about the existing ioctls for this driver, they have argsz too.
> > shall I prepare another patch to remove them as well?
> 
> I am hoping you actually have users for those ioctls in userspace today?
> If not, and no one is using them, then yes, please fix those too.

Yes, we have a few users, not many, e.g. https://github.com/OPAE/opae-sdk

I believe we may have more users as we are submitting code to make this
driver more usable.

Let me think about this, if we want to do this clean up, we have to 
increase the API version to tell everybody, things are changed. If
finally we decide to do this clean up, that will be a new patch after
this patchset.

Many Thanks for your patient guide and suggestions. :)

Hao

> 
> thanks,
> 
> greg k-h

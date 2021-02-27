Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C798326D76
	for <lists+linux-fpga@lfdr.de>; Sat, 27 Feb 2021 16:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbhB0PDB (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 27 Feb 2021 10:03:01 -0500
Received: from mga07.intel.com ([134.134.136.100]:13509 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229953AbhB0PDA (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sat, 27 Feb 2021 10:03:00 -0500
IronPort-SDR: 8hhi+eehJJUoIb93FbGddrDZPyNNfRpZddjw1gceJ7ehV71Y2WSlgsSI/G/rS3VTN6NM6smO0c
 qwxy0FK/VZxQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9908"; a="250180451"
X-IronPort-AV: E=Sophos;i="5.81,211,1610438400"; 
   d="scan'208";a="250180451"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2021 07:02:18 -0800
IronPort-SDR: Kd5ye0T3DevRgyR0HYEMxZcZhU+shIsMZH4d9IRfH6DJ0LVau6Nlay7zGzDtSleJd3OoHF3JyG
 qKy8tXHiqZag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,211,1610438400"; 
   d="scan'208";a="394225402"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by fmsmga008.fm.intel.com with ESMTP; 27 Feb 2021 07:02:12 -0800
Date:   Sat, 27 Feb 2021 22:57:33 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Tom Rix <trix@redhat.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        lgoncalv@redhat.com, hao.wu@intel.com, yilun.xu@intel.com
Subject: Re: [PATCH v11 0/2] UIO support for dfl devices
Message-ID: <20210227145733.GA2224@yilunxu-OptiPlex-7050>
References: <1612403971-13291-1-git-send-email-yilun.xu@intel.com>
 <9b5f6e54-7122-8cfb-39f8-a84599e081f1@redhat.com>
 <20210226012237.GA27194@yilunxu-OptiPlex-7050>
 <YDiX+Fl0AiQrdZJL@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YDiX+Fl0AiQrdZJL@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Greg:

On Fri, Feb 26, 2021 at 07:40:56AM +0100, Greg KH wrote:
> On Fri, Feb 26, 2021 at 09:22:37AM +0800, Xu Yilun wrote:
> > On Mon, Feb 22, 2021 at 10:56:45AM -0800, Tom Rix wrote:
> > > Yilun,
> > > 
> > > Is there anything outstanding or remaining to be done ?
> > 
> > Sorry for late reply. No, this is my lastest version now.
> > 
> > 
> > Hi Greg:
> > 
> > Do you have some comments on this patchset?
> 
> It's the middle of the merge window, I can't accept anything right
> now...
> 
> But this doesn't even look like it is in my "to review" queue anymore,
> which means that there must have been a lot of discussion on it and
> others asking for changes, so why not work on that right now while you
> can and resubmit it when you have done that?
> 
> No need to ever wait on me for fixing things up.

I checked the mails again and confirmed all the comments from Moritz,
Tom and Hao are fixed. So could you help review it so it could be
accepted in next cycle?

Thanks,
Yilun

> 
> greg k-h

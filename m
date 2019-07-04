Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2775F6FB
	for <lists+linux-fpga@lfdr.de>; Thu,  4 Jul 2019 13:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbfGDLEx (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 4 Jul 2019 07:04:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:41898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727499AbfGDLEx (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 4 Jul 2019 07:04:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E312205C9;
        Thu,  4 Jul 2019 11:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562238292;
        bh=HOf3Gt574sW018UHM7jh+XFy1sW2z2WUCnb0QJPFYoI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=02zEdmnU0sRzYtS80yJ6C96y1XRaDizVgNgwTeOxUkCCgUaDD92ze6QDP5muTHIkR
         voz341lKhKUFLdPp6QW4EG/ymk0RSKBkOEZiMGHSoPyOlTt3dxePLhkLYH4dtxFZTB
         PtZLtlmeAo7O6EcPSqJc50zf3yNJndWayWbtLpFg=
Date:   Thu, 4 Jul 2019 13:04:49 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wu Hao <hao.wu@intel.com>
Cc:     Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Zhang Yi Z <yi.z.zhang@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Alan Tull <atull@kernel.org>
Subject: Re: [PATCH 06/15] fpga: dfl: fme: add
 DFL_FPGA_FME_PORT_RELEASE/ASSIGN ioctl support.
Message-ID: <20190704110449.GC1404@kroah.com>
References: <20190628004951.6202-1-mdf@kernel.org>
 <20190628004951.6202-7-mdf@kernel.org>
 <20190703180753.GA24723@kroah.com>
 <20190703233058.GA15825@hao-dev>
 <20190704053927.GB347@kroah.com>
 <20190704063106.GA24777@hao-dev>
 <20190704082013.GE6438@kroah.com>
 <20190704085855.GB7391@hao-dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190704085855.GB7391@hao-dev>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, Jul 04, 2019 at 04:58:55PM +0800, Wu Hao wrote:
> > > Hope things could be more clear now. :)
> > 
> > That's nice for the vfio stuff, but you are just a "normal" driver here.
> > You want an ioctl that just does one thing, no arguments, no flags, no
> > anything.  No need for a size argument then at all.  These ioctls don't
> > even need a structure for them!
> > 
> > Don't try to be fancy, it's not needed, it's not like you are running
> > out of ioctl space...
> 
> Thanks a lot for the comments and suggestions.
> 
> That's true, it's a "normal" driver, maybe I overly considered the
> extensibility of it. OK, Let me rework this patch to remove argsz from
> these two ioctls.
> 
> What about the existing ioctls for this driver, they have argsz too.
> shall I prepare another patch to remove them as well?

I am hoping you actually have users for those ioctls in userspace today?
If not, and no one is using them, then yes, please fix those too.

thanks,

greg k-h

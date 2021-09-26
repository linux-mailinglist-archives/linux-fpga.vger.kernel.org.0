Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCF364187EA
	for <lists+linux-fpga@lfdr.de>; Sun, 26 Sep 2021 11:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbhIZJdl (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 26 Sep 2021 05:33:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:59964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229584AbhIZJdk (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sun, 26 Sep 2021 05:33:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 81F3360EC0;
        Sun, 26 Sep 2021 09:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632648725;
        bh=xTM899nuas+7465j3Cnl+Dzu4wy3OCnVBSboxjaHXw4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YScpJJSGgkOy9zaVZnSkrgozjIcx5EK014FrXFZA7ndqi14A71rC+PoWACbaaTGgq
         xMdohhx2kXscCZMCoGIB1WJckqyLcz1o9EgZZvzOqUL5fholHHtqEyfmv/ciIBWVnO
         vNgduHyrC/e2c6LfquHP1e4PTWSv1BGHqT+s6FOY=
Date:   Sun, 26 Sep 2021 11:32:02 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     linux-fpga@vger.kernel.org, hao.wu@intel.com, yilun.xu@intel.com
Subject: Re: Maintenance of Linux FPGA
Message-ID: <YVA+EvWpX4vNKqTf@kroah.com>
References: <YU9s27qwyzmeONiq@epycbox.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YU9s27qwyzmeONiq@epycbox.lan>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Sat, Sep 25, 2021 at 11:39:23AM -0700, Moritz Fischer wrote:
> Hi all,
> 
> I lately did not have enough time to dedicate to the Linux FPGA
> subsystem, concerns were raised around bus-factor and all.
> 
> Looking at my day-job I don't see this getting better in the short-term
> so I've decided to get a conversation going on how to structure this
> better for the benefit of the Linux FPGA subsystem.
> 
> Maybe a maintainer team approach would address the bus factor and
> workload concerns better?
> 
> In terms of people I was thinking about:
> 
> Hao has done a great job at keeping the DFL part of things going, so I
> think he'd be a great choice.
> 
> Yilun has been very helpful with reviews and I think he'd be a good
> pick, too.
> 
> In terms of how to structure this: I'm not sure just yet, open to input.
> 
> How do other multi-maintainer subsystems operate? Ideas? Suggestions?

There's lots of different ways they work, depends on what works best for
you all.

Some take turns on a weekly basis to commit patches to the tree.  Some
require multiple acks/reviews by the others before they are allowed to
merge to their tree.  Some just do what they can and merge what they
want :)

So it's all up to you all as to what you all find works best.  I'll
gladly take patches from whatever you all determine to do.

thanks,

greg k-h

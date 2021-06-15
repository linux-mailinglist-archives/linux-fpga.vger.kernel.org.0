Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7B43A77CE
	for <lists+linux-fpga@lfdr.de>; Tue, 15 Jun 2021 09:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbhFOHSg (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 15 Jun 2021 03:18:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:51618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229488AbhFOHSf (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 15 Jun 2021 03:18:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 542B6613DB;
        Tue, 15 Jun 2021 07:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623741390;
        bh=lXwub9KAeW5h5fIYe3kGfhXgBefFwCNjn82/prRFv+8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i2eWGogZzHLIrG9Dhp+xpvK8BEbHFp8gc2yuwJstRDqkv9HA3EVDotM8s7OY7x76l
         fkQ6zcwvBpwAYjCs98fCcQQwLNyMMoTGvsXcahynnSzhzY5zzRfns+kd63aRSr1qj9
         5bxJVI3w3BOJr0UeOv+lCSBGJ5pZRtwGbdhvF4P8=
Date:   Tue, 15 Jun 2021 09:16:28 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        Xu Yilun <yilun.xu@intel.com>
Subject: Re: [PATCH 2/8] fpga: stratix10-soc: Add missing fpga_mgr_free() call
Message-ID: <YMhTzHNQV/iYHUJr@kroah.com>
References: <20210614170909.232415-1-mdf@kernel.org>
 <20210614170909.232415-3-mdf@kernel.org>
 <YMeSG6puw7/4OZ6b@kroah.com>
 <e7aef991-cd78-15fd-fdc9-9b75709af8c7@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7aef991-cd78-15fd-fdc9-9b75709af8c7@intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Jun 14, 2021 at 10:38:01AM -0700, Russ Weight wrote:
> 
> 
> On 6/14/21 10:30 AM, Greg KH wrote:
> > On Mon, Jun 14, 2021 at 10:09:03AM -0700, Moritz Fischer wrote:
> >> From: Russ Weight <russell.h.weight@intel.com>
> >>
> >> The stratix10-soc driver uses fpga_mgr_create() function and is therefore
> >> responsible to call fpga_mgr_free() to release the class driver resources.
> >> Add a missing call to fpga_mgr_free in the s10_remove() function.
> >>
> >> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> >> Reviewed-by: Xu Yilun <yilun.xu@intel.com>
> >> Signed-off-by: Moritz Fischer <mdf@kernel.org>
> >> ---
> >>  drivers/fpga/stratix10-soc.c | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
> >> index 657a70c5fc99..9e34bbbce26e 100644
> >> --- a/drivers/fpga/stratix10-soc.c
> >> +++ b/drivers/fpga/stratix10-soc.c
> >> @@ -454,6 +454,7 @@ static int s10_remove(struct platform_device *pdev)
> >>  	struct s10_priv *priv = mgr->priv;
> >>  
> >>  	fpga_mgr_unregister(mgr);
> >> +	fpga_mgr_free(mgr);
> >>  	stratix10_svc_free_channel(priv->chan);
> >>  
> >>  	return 0;
> >> -- 
> >> 2.31.1
> >>
> > Does this fix a specific commit?  Does it need a Fixes: and cc: stable
> > line too?
> It fixes:
> 
> e7eef1d7633a fpga: add intel stratix10 soc fpga manager driver
> 
> And yes, I think it needs the Fixes: and cc: stable lines
> 
> Moritz: Let me know if you want me to add the tags
> 
> Greg: Patch 1 in this series could be viewed as a fix for a particular
> commit as well, but the code being deleted is harmless/unused. I'm
> assuming it does NOT need the Fixes: and cc: stable lines?

All patch 1 did is delete unused code, that doesn't really "fix"
anything that could be seen as a bug :)

thanks,

greg k-h
